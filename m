Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F5DCC67861
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 01:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C00287EF5;
	Sun,  7 Apr 2024 03:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1712451961;
	bh=9JqXDj/rXgoJgojFGAsKJG1JWQSvC6wGIbZKUeYzfg8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R1fvDjg9Veh07wWjMlkDuIpoIMmfhbbotYNRr8l/FW0bcVbfKd6MKvsisSBuQu/I3
	 m5Ij3SkVyKXqK9AHlOQfleulw1HCLKFMCVbKYGycRTWFRLzBzQifB/CBOqPvsiz6Av
	 UYDjL9pv73I/iFqlgFioowsNtCgXJLPfqjUnwx4gAdbjSeeG1NIDf6YPn3rkeMismU
	 xvyglgzBW4Otbx0Anyv2xEGyZXPcUTKf/nqJ/GGlbtnvzOsWiDD6AP6o9+OexkF19p
	 q28EIlXcexYDbg/pho3LVJz0+O9w0OGNNaxZ42gFcAXDR+vK1J2Li4/laUEo+f3UEU
	 1pqVZjZugd1Xw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 06C5887EAF;
 Sun,  7 Apr 2024 03:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1712451960;
 bh=9JqXDj/rXgoJgojFGAsKJG1JWQSvC6wGIbZKUeYzfg8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=wwXwsTZK99EZpWegyRIrp8DgXQ4LReGo2pdvv/tVbb2y4/ah4A7wDGz/rbB6Bc7sM
 LvEAo79+aS5GlkCG13sIgrgQ0T3W8TX6QkmYm2Sh59j2TLib9/HPi1qr8fjtkEpOxH
 6sX3yzBrU+D35R0l4sbKNJd6I5XDbfiycHQhvvCSvl/6ge8wOHEMNsf94VqT0C68Fa
 qgZQw0+XSf1a51CE6ehn2suNDObesM2UlG4UgkqnxAMEiwpoo7I76RnxFfkLTClyLv
 zSv0tZt51H4Wxo70blu8L5zzud4VQoj6ApXvPe2k8+2qtguRvLD3l7jgs5biS0DFsV
 0hYqh+PbwSzBg==
Message-ID: <5ed4e6d2-edc7-461d-8183-e91d7b994aa5@denx.de>
Date: Sun, 7 Apr 2024 03:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] USB keyboard improvements for asahi / desktop
 systems
To: Janne Grunau <j@jannau.net>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 u-boot@lists.denx.de, asahi@lists.linux.dev, Neal Gompa <neal@gompa.dev>
References: <20240404-asahi-keyboards-v4-0-2266033feaff@jannau.net>
 <356b892a-a681-4ae0-a6c8-ed1b4b5a8717@denx.de> <ZhBLfQfxB_UEwvyY@robin>
 <5467f380-de35-4776-8c32-90b8e08aeda7@denx.de> <ZhGq0U_pkrYMe4S1@robin>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <ZhGq0U_pkrYMe4S1@robin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/6/24 10:04 PM, Janne Grunau wrote:
> On Sat, Apr 06, 2024 at 08:52:17PM +0200, Marek Vasut wrote:
>> On 4/5/24 9:05 PM, Janne Grunau wrote:
>>> On Fri, Apr 05, 2024 at 04:52:32PM +0200, Marek Vasut wrote:
>>>> On 4/4/24 8:25 AM, Janne Grunau via B4 Relay wrote:
>>>>> Apple USB Keyboards from 2021 need quirks to be useable. The boot HID
>>>>> keyboard protocol is unfortunately not described in the first interface
>>>>> descriptor but the second. This needs several changes. The USB keyboard
>>>>> driver has to look at all (2) interface descriptors during probing.
>>>>> Since I didn't want to rebuild the USB driver probe code the Apple
>>>>> keyboards are bound to the keyboard driver via USB vendor and product
>>>>> IDs.
>>>>> To make the keyboards useable on Apple silicon devices the xhci driver
>>>>> needs to initializes rings for the endpoints of the first two interface
>>>>> descriptors. If this is causes concerns regarding regressions or memory
>>>>> use the USB_MAX_ACTIVE_INTERFACES define could be turned into a CONFIG
>>>>> option.
>>>>> Even after this changes the keyboards still do not probe successfully
>>>>> since they apparently do not behave HID standard compliant. They only
>>>>> generate reports on key events. This leads the final check whether the
>>>>> keyboard is operational to fail unless the user presses keys during the
>>>>> probe. Skip this check for known keyboards.
>>>>> Keychron seems to emulate Apple keyboards (some models even "re-use"
>>>>> Apple's USB vendor ID) so apply this quirk as well.
>>>>>
>>>>> Some devices like Yubikeys emulate a keyboard. since u-boot only binds a
>>>>> single keyboard block this kind of devices from the USB keyboard driver.
>>>>>
>>>>> Signed-off-by: Janne Grunau <j@jannau.net>
>>>>
>>>> I picked the series, but CI indicates build errors, can you have a look ?
>>>>
>>>> https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20215
>>>
>>> The issue seems to be that the field dev in struct usb_device exists
>>> only for DM_USB. That means we can't use dev_dbg.
>>> Either take the following fixup patch or I can resend the series.
>>
>> I squashed the extra patch in, but I think the CI still complains:
>>
>> Pipeline #20236 (
>> https://source.denx.de/u-boot/custodians/u-boot-usb/-/pipelines/20236 )
>> triggered by Marek Vasut ( https://source.denx.de/marex )
>> had 1 failed job.
>>
>> Job #812215 (
>> https://source.denx.de/u-boot/custodians/u-boot-usb/-/jobs/812215/raw )
> 
> env_get() missing without CONFIG_ENV_SUPPORT. I'm too accustomed to the
> kernel's stub functions. Best option seems to to just #if the
> functionality out in this case. See attached fixup patch.
> 
> Sorry,

No worries.

Does it work if you do this instead ?

  static int usb_device_is_ignored(u16 id_vendor, u16 id_product)
  {
         ulong vid, pid;
+       /* No env support, nothing can be ignored */
+       if (CONFIG_IS_ENABLED(ENV_SUPPORT))
+           return 0;

That way, the function is always compiled and if it is unreachable, then 
compiler throws it out. This should improve code compile coverage.
