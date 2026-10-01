Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E13CA5FD9
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 15:48:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CDEB60660;
	Thu,  1 Oct 2026 15:48:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LxVzIaDQf2ub; Thu,  1 Oct 2026 15:48:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E5E63607E7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790869706;
	b=UJwYsdflM5mOtvJeX4XbSUVdagnweHwO+cBnc8Zm9MH9tgFlSkKedszd3SFKNgCgPP2q
	 I3zVrIF3NLqMX71Ks1IYbB1zX2kwBJWyVrp8NnjkX4A2QkBEorPHx0ED9sOAJDAAZ8u3s
	 5naPy1qv3n3h9MVVwidOjnSyRkARd6ZhuJ98+cS/rGy3D4rZIkDhfQd2Wp/ikD+7OPVHi
	 o9iof+D3Co5o4Ft6gVQM8u/rLyzrZRh84+cXVFM5hr+nq/8Eai9enNW0vypGdY2BGRUFC
	 c6bc1BkUs9mkvPYZFXwTR0KQDfbHYMvD0UpdAgTGD+E6KVcjeZFExgD2+UW8sJxcL/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790869706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QpS3zVsII9GAyr5VscnnVU71zcht9ZJM7LwUT3EoFfs=;
	b=lxzaLilt8VmIrZ62g7eMpeMNAe2xCwqgnPedVIwzkCEIMNtrylro485+lvMq4Flgy7Z/
	 3r2kZHPQ7De9T1kZ1zqe1DAvS0J4eZUgbFs2gvUAHwfs/udhgh2RtyeQnLhV13FlNELeX
	 CLXYH8B8yG7qbutk9kcl7gEQnJav1pAw4lvDob1mtT+bg7W2ewwZ+fJ47HIGtMYjG65tP
	 N9+gloqjJO0DLX31GfKtOTxx2tTQSIsMqJjdDSoJMods/3at0VSM+2OMq5E9ULvrc1Auc
	 R+SyOCr2skjt4gh7Uqtami67ELOL0u2UbKHuX6e7LLAaL+DhHUrgp89XJvogj9LQT5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790869706;
	bh=QpS3zVsII9GAyr5VscnnVU71zcht9ZJM7LwUT3EoFfs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QauZ5YjCDZBPsY7LCyD2R/EZn3RaYBI+ptfPCc4NGkt8/OK3Z/Q96VOV2abDljTG1
	 O0TESp1csEsGGiU+ccBekGZHOvYJ45dqoxNKt42zw3Vp9X3R08UTY2fQnfp5x0Fd2U
	 2kXze/OoEN0dXKdiNiMJ3ERR3eCGY5ATjxdmd7acL/243Ub4mqFl4IvD8HH3qifSMt
	 UFiPp9s59oEVV5A8kMGRHdvCQbbn3hYCbC7XrRgEYiNKOPdn0pl9MJn/2mvFpa/KuZ
	 2N7W8EF0qJLiULe/fRUSk8Tbg8xsYwwAzcQpBG+0/V+DsPsuHc7eSv9GJk9mQ+QGEr
	 NbMHNm67UFO0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5E63607E7;
	Thu,  1 Oct 2026 15:48:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8ACC91A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4C27440528
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:48:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VpwE1UosgjU0 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 15:48:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2412A40098
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:8e30::8fa9"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790869702;
 b=UXkZw2ph5phlsItA1Jf77UlVnm69vV9wmT7PSk7/iG9lVcskjmFg2cnptMlfpkxbhbIc
 c0+oSskehfOWBYc0EUGsgpZ4CcYINqyrNCE7cL36EO3TCaWtjJW7RFEyYoubkBG5lzjYT
 5xDlu9fXNdCNfTaYgul+TR3l/MHsUxu9nOvAFOnSxZAvN7LWbVH4KWfvzx4YV/mW9csB5
 aK9Qz6iFOSO9I/RytMNPq2xeIdsR2u4k4TTbmISuCkPxyXullikpKCj6a8vSxWPVE1Y0/
 hcVUKNqAcherilhvxxUE2vQ4rJw5mfTBRijDr79IdB6iJh+fTvCbq2keQq72du5Dqzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790869702;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:From:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=QpS3zVsII9GAyr5VscnnVU71zcht9ZJM7LwUT3EoFfs=;
 b=GcCVRXaHlilag8ZoAsvd0XOkZYQxcY351+g24uhi0zsS+oOq3yQUv12XfQIsbDyr2rJ+
 HTq4o+i44cbjkcREKHfkwAoU4JxKGBFD5p3LOgx+koYiEr+VBm3bNl9i97V/qs7ySps+0
 DwJQ2G2lBp3+xmg9JKlqzvGo70Jb9Poki652thH9YzJGt4ExlyjYQlnUXYMzPY3i0OLfe
 9ih0+WnWuzNWi6ltOxJuQHS8HFRJnQoNCTQUKsdCFsqiXrcI/oqsrjer8lDUWfCHMvgye
 RcnC6sIPfYmfYxOmekV/y9BLWMouaQgJcPo8N9kgJ1E+eChd9d4ijYrGXiHsWTH1ZRA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=iDAuhMOG; 
 arc=none smtp.remote-ip="2001:1600:19:8e30::8fa9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:8e30::8fa9; helo=smtp-8fa9.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=iDAuhMOG
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::8fa9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2412A40098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:48:20 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hwbsq0DFqzVTZ;
 Thu,  1 Oct 2026 17:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1790869694;
 bh=QpS3zVsII9GAyr5VscnnVU71zcht9ZJM7LwUT3EoFfs=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=iDAuhMOGMkvOnjfM22KRFnslrz5EPErGOuiuUez65KqlZVmaQYc1e50r8RJwJm6j4
 6FfQkjAinzLbdTegDiU3h8upGQ7RidoC+kBbTJC705XPHgjFk7meLufkPifzHor+fo
 NxhTJrgYEp8jWt92WpvUudGGpG6Vh0HCRUuD0hT8QwPUe0gwt28CRoLc07MTAZ1Hws
 QwCHsX0uwn+iEH9LOV+TTrA4h+JaPa74rT84wxoG78wtYCICzE8gffM04L57c5mVc9
 cbGVH/HdWkoSGZQ+n88otLTUjYF+WNZd8k51o+bnJJc/EQAGYGk2EfQ0CUnCuuCJkX
 2/WSNR1kJkgLg==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hwbsp1wbYzDqK; Thu,  1 Oct 2026 17:48:14 +0200 (CEST)
Message-ID: <52e81472-3fc2-43b5-bc4e-076d9484eb0a@0leil.net>
Date: Thu, 1 Oct 2026 17:48:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
From: Quentin Schulz <u-boot@0leil.net>
To: Milivoje Legenovic <m.legenovic@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20260926005853.1727-1-m.legenovic@gmail.com>
 <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
 <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
 <49c6cdf8-4074-4325-9744-9fcfdce0317b@0leil.net>
Content-Language: en-US
In-Reply-To: <49c6cdf8-4074-4325-9744-9fcfdce0317b@0leil.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Sorry, forgot to add something.

On 10/1/26 5:35 PM, Quentin Schulz wrote:
> Hi Milivoje,
> 
> On 10/1/26 12:28 AM, Milivoje Legenovic wrote:
>> [You don't often get email from m.legenovic@gmail.com. Learn why this 
>> is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Hello everyone,
>>
>> Here are the details of my analysis:
>> The commit that introduced the change in behavior in version 2026.01
>> is this one:
>>
>> commit 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
>> Author: Adriana Nicolae <adriana@arista.com>
>> Date:   Thu Nov 27 08:28:34 2025 -0800
>>
>>      boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
>>
>>      The Linux kernel can discover SMBIOS tables through two primary 
>> methods:
>>      1. Via EFI tables, when using EFI boot;
>>      2. Via the 'smbios3-entrypoint' property in the /chosen node of the
>>      device tree.
>> ...
>>
>> I found this out by comparing the device tree from a working version,
>> decompiled using
>>
>> sudo dtc -I fs -O dts /sys/firmware/devicetree/base -o live_tree.dts
>>
>> and difference was in /chosen node:
>>
>> chosen {
>>          u-boot,version =
>> "2026.01_armbian-2026.01-S127a-P7283-Hee1c-V2928-B3a7f-R448a";
>>          linux,initrd-end = <0x00 0xecbffca5>;
>>          bootargs = ...
>>          smbios3-entrypoint = <0x00 0xedf47000>;
>>          kaslr-seed = <0x00 0x00>;
>>          linux,initrd-start = <0x00 0xeb519000>;
>>          stdout-path = "serial2:1500000n8";
>> };
>>
>> In 2026.01 version smbios3-entrypoint was there, in 2025.10 not. I
>> searched for this term in git history and found the commit mentioned
>> above.
>> With git show I saw what activates this, and made a patch in armbian
>> build system to disable it and confirm it fixes the problem. And it
>> fixed it.
>>
> 

Can you run a bisect between 2025.10 and 2026.01 without a change to the 
defconfig? I'm pretty sure this commit is not the issue (you can revert 
it and keep CONFIG_GENERATE_SMBIOS_TABLE enabled and you'll likely see 
behavior hasn't changed, meaning the breaking change is coming from 
another commit). After a glance at the log between 2025.10 and 2026.01, 
I don't see anything obviously related to smbios that changed (aside 
from the commit you mentioned and 2d226a735e0e ("smbios: Fix warning 
when building with clang") but that isn't a clear candidate for a 
breakage of this kind).

> As far as my understanding goes, there's actually nothing consuming this 
> DT property right now. There is a patch on the Linux kernel mailing 
> list, c.f. https://lore.kernel.org/lkml/20251031115917.713105-2- 
> adriana@arista.com/ but it's not merged. I doubt Armbian would backport 
> this but maybe they did?
> So I don't think the *presence* of this property changes anything, but 
> there could be side-effects (e.g. actually having the SMBIOS3 table 
> somewhere it isn't expected, potentially corrupting e.g. the kernel). 
> I'm a bit skeptical though as the commit you point to only adds a 
> property, it doesn't seem to be doing anything else.
> 
>> Here is also where kernel hangs for 60 seconds (always at the same 
>> place):
>>
>> [   14.482048] calling  gpio_led_driver_init+0x0/0x38 @ 1
>> [   78.137967] Freeing initrd memory: 23448K
>> [   78.165027] probe of leds returned 0 after 63677665 usecs
>> [   78.166792] initcall gpio_led_driver_init+0x0/0x38 returned 0 after
>> 63684076 usecs
>>
> 
> So the probe of the drivers/leds/leds-gpio.c driver took 60+seconds, 
> that seems quite improbable (well, it technically could be anything on 
> the path for this driver to probe, c.f. really_probe() in drivers/base/ 
> dd.c.
> 
> Can you disable that driver (CONFIG_LEDS_GPIO) and see if it goes 
> further? Being curious :) (I see Armbian did some - clearly downstream - 
> changes to this driver, so being curious :) ).
> 
> Can you provide us with a link (with commit hash) to the exact sources 
> of U-Boot and Linux kernel that Armbian builds for your board?
> 
> Can you provide us with the full bootlog (including U-Boot up until the 
> Linux kernel's hung)?
> 
>> As you can see, I was only able to find the cause, but that’s the
>> extent of my expertise.
>>
>> At first, I wanted to sort out the problem with a patch in the Armbian
>> build project, but then I thought: "Why not sort it out at source?"
>>
> 
> I'm not convinced we're there yet but that's the kind of spirit I like, 
> let's not fix symptoms or consequences :)
> 
> Cheers,
> Quentin

