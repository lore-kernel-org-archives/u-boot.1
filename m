Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CE3C48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 13:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F30487E50;
	Thu,  8 Feb 2024 14:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1707399498;
	bh=LAStPwk723gohgRXbqB6xj/oz+JP3u4Nq0M2UhHEG20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gFEehiYZ3TQzNoZL+mLB11tGop+K9TA5aKOU9Bwl87mX1L7kac+JH1XUbFqDFCDOg
	 Hrzn5j4So+Tzmg+dSAMOGpd+PUB+k1N9+Lf+Z1sXbJak6pjK/K0lnTR+4fKoN4AilK
	 oMaReaJvzyODZNxQsNUTeVLTZ5BXyUDoXX25xu5ZmutuGiAnD/ZjTIWLiowSpmwSNC
	 d0LAPfO3JwrUhCHCxMymdtfG0Gv7Acdx2oDwkg/KxpdsdHLbzQDKRTfrzJ++Z3de1x
	 ZFszXzhhM3eQP2jwWofDcZFUlmCQmpftwVk+OlHkSJXs8Q8XCUDN4QXpuYH9Go5D6r
	 tJW3QEtSlTIQQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CF63E87E42;
 Thu,  8 Feb 2024 14:38:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1707399497;
 bh=LAStPwk723gohgRXbqB6xj/oz+JP3u4Nq0M2UhHEG20=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=n6175Ncuz+FuHuuQeyuM1NX9v9S3UQ3o1e2axZWAIBPbJxYv8IHFaEud6TyRY5fAR
 yyRIjy9bp1KKwxR3naG91hCg4NioAkjfmSh67s8idK0xnQ4zQvfl9uDHPVPJTcW+ta
 B+gIpO57qz0nKRshUW8Ha7BvwqZb+v27SkQsZ8PE5CUJrCxI6fm0jrDM2EMB4Clp+7
 mWkbNC1JCr7H3sBp1gJuwHB+U2e4yc9J4enPyOh9u4Z0ZXy2ueES4KFsPo24/mi/Qc
 4YQzZSMhjM0xJZ+lzX4knc/GbXu6K9JmcPoih02FyXPfTR5nyd4u5ypwTH5rMPAn9L
 QHAkRNNtZdS4A==
Message-ID: <93f69779-3197-4ede-bb78-f2512ec30fc1@denx.de>
Date: Thu, 8 Feb 2024 14:33:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
Content-Language: en-US
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, andre.przywara@arm.com, dsimic@manjaro.org,
 Hector Martin <marcan@marcan.st>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20240207102327.35125-1-i@shantur.com>
 <32db6dba-d515-4077-9d72-d77a7f431335@denx.de>
 <CABEcMwXW3KXQCJM16Qhk=19Sss3zdtQyWtJEed5y=na2mP8RFA@mail.gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CABEcMwXW3KXQCJM16Qhk=19Sss3zdtQyWtJEed5y=na2mP8RFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2/8/24 12:30, Shantur Rathore wrote:
> Hi Marek,
> 
> On Wed, Feb 7, 2024 at 1:07 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 2/7/24 11:23, Shantur Rathore wrote:
>>> USB 3.0 spec requires hub to reset device while
>>> enumeration. Some USB 2.0 hubs / devices don't
>>> handle this well and after implementation of
>>> reset some USB 2.0 disks weren't detected on
>>> Allwinner based boards.
>>>
>>> Resetting only when hub is USB 3.0 fixes it.
>>
>> It would be good to include as many details about the faulty hardware in
>> the commit message as possible, so that when someone else runs into
>> this, they would have all that information available.
>>
>>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>>>
>>> Signed-off-by: Shantur Rathore <i@shantur.com>
>>> ---
>>>
>>>    common/usb_hub.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/common/usb_hub.c b/common/usb_hub.c
>>> index 3fb7e14d10..2e054eb935 100644
>>> --- a/common/usb_hub.c
>>> +++ b/common/usb_hub.c
>>> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct usb_hub_device *hub)
>>>
>>>        debug("enabling power on all ports\n");
>>>        for (i = 0; i < dev->maxchild; i++) {
>>> -             usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
>>> -             debug("Reset : port %d returns %lX\n", i + 1, dev->status);
>>> +             if (usb_hub_is_superspeed(dev)) {
>>
>> Should this condition be "all which are lower than superspeed" instead ,
>> so when the next generation of USB comes, this problem won't trigger ?
>>
>> What does Linux do btw ?
> 
> As of now Linux checks if the hub is superspeed
> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c#L2859
> 
> which is
>   return hdev->descriptor.bDeviceProtocol == USB_HUB_PR_SS; // USB_HUB_PR_SS = 3
> 
> This holds true for newer SuperSpeedPlus hubs as well.
> https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.h#L155
> 
> We can change the check to be  bDeviceProtocol > 2 but who knows if
> things change in the newer version of spec.
> I am open to suggestions.

Please just include the ^ in the commit description. Use link to 
git.kernel.org , not some mirror . This is extremely useful information 
and, well, you already wrote the V2 commit message addition in this answer.

Thanks
