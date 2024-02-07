Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE89C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 13:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0ADB87CF9;
	Wed,  7 Feb 2024 14:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="o9Oh18p3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 258EA87CF9; Wed,  7 Feb 2024 14:16:42 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 540BE87CF7
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 14:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707311799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkS2FVzogc4M5sM7lhI0slJ7tHiq6uXsguNRNeOh/Hs=;
 b=o9Oh18p3x89iMpG10Ikve6wzIJDU+oHcKsjiyZygMFlPNLAnF/3fbv1p4sLL2HgSvPbsuv
 hQUT/7DWKK4MIrRDvwLUnPhS2OXKgacxOXK+caYKFWtwzcHUGYq0pS3iMxdCuC0l1HeWEY
 GQ4/z+Jdwwcrn1nuSxBVs7OHmZ9Z9mZS/anVqjmbOEZ7gdgylJyCJWhVvChCRddJmYguZc
 llo/PAIzZ9AxjU7kmYsK95QIV0iYtC2qQtndM2LY8iyvsOG2f5u9zwPBL6F1qKlUUEqZPI
 Docu/HyQpRUFSlH6g9UqJkBy38JEyItSvnh6OaHXyK2VHKdprHs3i/FQcZLooA==
Date: Wed, 07 Feb 2024 14:16:39 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Shantur Rathore <i@shantur.com>
Cc: u-boot@lists.denx.de, andre.przywara@arm.com, Hector Martin
 <marcan@marcan.st>, Marek Vasut <marex@denx.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [FIX PATCH v1] Fix: common: usb_hub: Reset only USB3.0 hub
In-Reply-To: <76674885ff74d02d96e49d41759eaa85@manjaro.org>
References: <20240207102327.35125-1-i@shantur.com>
 <76674885ff74d02d96e49d41759eaa85@manjaro.org>
Message-ID: <e6c97c306012571cfa790c157bf09fe0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-07 14:14, Dragan Simic wrote:
> Hello Shantur,
> 
> Please see my notes below.
> 
> On 2024-02-07 11:23, Shantur Rathore wrote:
>> USB 3.0 spec requires hub to reset device while
>> enumeration. Some USB 2.0 hubs / devices don't
>> handle this well and after implementation of
>> reset some USB 2.0 disks weren't detected on
>> Allwinner based boards.
>> 
>> Resetting only when hub is USB 3.0 fixes it.
>> 
>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>> 
>> Signed-off-by: Shantur Rathore <i@shantur.com>
> 
> Please, add the "Fixes" line available below, reformat the patch
> description to the usual 78-character width, and remove unnecessary
> "FIX " from the patch subject prefix.
> 
> Fixes: 33e06dcbe57a ("common: usb-hub: Reset hub port before scanning")
> 
> As a side note, such tags can be produced very easily by running
> "git log --max-count=1 --pretty=fixes <commit>".  I have an alias
> like that defined in my ~/.gitconfig.
> 
> With these changes applied, please feel free to also add:
> 
> Reviewed-by: Dragan Simic <dsimic@anjaro.org>

Oops, sorry for the typo...  s/anjaro/manjaro/

>> ---
>> 
>>  common/usb_hub.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/common/usb_hub.c b/common/usb_hub.c
>> index 3fb7e14d10..2e054eb935 100644
>> --- a/common/usb_hub.c
>> +++ b/common/usb_hub.c
>> @@ -174,8 +174,10 @@ static void usb_hub_power_on(struct 
>> usb_hub_device *hub)
>> 
>>  	debug("enabling power on all ports\n");
>>  	for (i = 0; i < dev->maxchild; i++) {
>> -		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
>> -		debug("Reset : port %d returns %lX\n", i + 1, dev->status);
>> +		if (usb_hub_is_superspeed(dev)) {
>> +			usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESET);
>> +			debug("Reset : port %d returns %lX\n", i + 1, dev->status);
>> +		}
>>  		usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWER);
>>  		debug("PowerOn : port %d returns %lX\n", i + 1, dev->status);
>>  	}
