//
//  OCJavascriptFunctions.m
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCJavascriptFunctions.h"

@implementation OCJavascriptFunctions

+ (NSString *)jsLogin
{
    return @"function OCLogin() { document.getElementsByClassName('btn btn-success coursera-signin-button')[0].click(); } OCLogin();";
}

+ (NSString *)jsFillElement:(NSString *)element withContent:(NSString *)content
{
    return [NSString stringWithFormat:@"function OCFillElement(){ document.getElementById('%@').value = '%@' } OCFillElement();",element, content];
}

+ (NSString *)jsCallObjectiveCFunction
{
    return @"function callObjectiveCFunction(functionName, args) { var iframe = document.createElement('IFRAME'); iframe.setAttribute('src', 'js-frame:' + functionName + ':' + encodeURIComponent(JSON.stringify(args))); document.documentElement.appendChild(iframe); iframe.parentNode.removeChild(iframe); iframe = null; }";
}

+ (NSString *)checkLogined
{
    return @"var intervalId = setInterval(function() { var courses = document.getElementsByClassName('coursera-course-listing-box coursera-course-listing-box-wide coursera-account-course-listing-box'); var signinFail = document.getElementById('signin-fail'); if (courses.length > 0) { callObjectiveCFunction('login_successfully','nothing'); clearInterval(intervalId); } else if (signinFail) { callObjectiveCFunction('login_fail','nothing'); clearInterval(intervalId); } }, 1000);";
}

+ (NSString *)checkPageLoaded
{
    return @"var pageLoadIntervalId = setInterval(function() { if (jQuery.active == 0) { callObjectiveCFunction('pageLoaded','nothing'); clearInterval(pageLoadIntervalId); } else {  } }, 1000);";
    
}

+ (NSString *)checkCourseLoaded
{
    return @"var number = 0; var pageLoadIntervalId = setInterval(function() { if (jQuery.active == 0) { number +=1; if(number >=2) {callObjectiveCFunction('pageLoaded','nothing'); clearInterval(pageLoadIntervalId);} } else {  } }, 1000);";
}

+ (NSString *)jsFetchAllImageCourse
{
    return @"function OCFetchAllImageCourse() { var imageLinks = document.getElementsByClassName('coursera-course-listing-icon'); var result = ''; for(var i = 0; i<imageLinks.length; ++i) {result += imageLinks[i].src; if(i != imageLinks.length-1) result += ';'; } return result;} OCFetchAllImageCourse();";
}

+ (NSString *)jsFetchAllTitleCourse
{
    return @"function OCFetchAllTitleCourse() { var titles = ''; var courseListingName = document.getElementsByClassName('coursera-course-listing-name'); for(var i =0; i<courseListingName.length; ++i){ titles += courseListingName[i].getElementsByTagName('a')[0].innerHTML; if(i != courseListingName.length-1) titles+=';';} return titles; } OCFetchAllTitleCourse();";
}

+ (NSString *)jsFetchAllLinkCourse
{
    return @"function OCFetchAllTitleCourse() { var titles = ''; var courseListingName = document.getElementsByClassName('coursera-course-listing-name'); for(var i =0; i<courseListingName.length; ++i){ titles += courseListingName[i].getElementsByTagName('a')[0].href; if(i != courseListingName.length-1) titles+=';';} return titles; } OCFetchAllTitleCourse();";
}

+ (NSString *)jsFetchAllMetaInfoCourse
{
    return @"function OCFetchAllMetaInfoCourse(){var metaInfo = document.getElementsByClassName('coursera-course-listing-meta'); var info = ''; for (var i = 0; i< metaInfo.length; ++i) { info += metaInfo[i].getElementsByTagName('span')[0].innerHTML; info +=';'; } return info; } OCFetchAllMetaInfoCourse();";
}

+ (NSString *)jsFetchAllStatusCourse
{
    return @"function OCFetchAllStatusCourse(){var result = ''; var courseStatus = document.getElementsByClassName('btn btn-success coursera-course-button'); for(var i=0;i<courseStatus.length;++i){ if(courseStatus[i].getAttribute('disabled')) {result += 'disabled';} else if(courseStatus[i].innerHTML == 'View class archive'){result += 'archive'} else {result += 'available'; } result += ';'; } return result;} OCFetchAllStatusCourse();";
}

+ (NSString *)jsFetchAllProgressCourse
{
    return @"function OCFetchAllProgressCourse(){ var result = ''; var courseProgress = document.getElementsByClassName('progress-bar'); for(var i=0;i<courseProgress.length;++i){ result += courseProgress[i].style.width.slice(0, -1); result += ';'; } return result;} OCFetchAllProgressCourse();";
}

+ (NSString *)jsCheckAuthenticationCourseNeeded
{
    return @"function OCCheckAuthenticationCourseNeeded(){ if (document.getElementById('agreehonorcode')) return true; else return false; } OCCheckAuthenticationCourseNeeded();";
}

+ (NSString *)jsAuthenticateCourse
{
    return @"function OCAuthenticateCourse(){ return document.getElementById('agreehonorcode').href; } OCAuthenticateCourse();";
}

+ (NSString *)jsFetchLectureLinks
{
    return @"function OCFetchLectureLinks(){ var listSection = document.getElementsByClassName('list_header_link'); var listItem = document.getElementsByClassName('item_section_list'); var result = []; for(var i =0; i< listSection.length; ++i) { var sectionItem = []; var section = listSection[i].getElementsByClassName('list_header')[0].innerHTML; var items = listItem[i].getElementsByClassName('lecture-link'); for (var j=0; j<items.length; ++j) { sectionItem.push(items[j].href + '~' + items[j].text); } result.push(section); result.push('^'); result.push(sectionItem.join(';')); result.push('|');     } return result.join(''); } OCFetchLectureLinks();";
}

+ (NSString *)jsPlayLectureVideo
{
    return @"function OCPlayLectureVideo(){ var iframe = document.getElementById('fancybox-frame'); var innerDoc = iframe.contentDocument || iframe.contentWindow.document; return innerDoc.getElementById('QL_video_element_first').src; } OCPlayLectureVideo();";
}

@end
