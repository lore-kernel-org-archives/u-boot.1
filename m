Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB74CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 15:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 919DB60C29;
	Thu,  1 Oct 2026 15:41:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5WtSWSJaGg7V; Thu,  1 Oct 2026 15:40:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1C9A360B5E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790869259;
	b=LYKrPs3ozoLNdaUPm9qJ+gC47ySfDuc5bv9FaLNFSeiwPaoJTRAm+8f9dAxY4b4zbhfb
	 KZZ5lLeseVk96jcEK+Cp6grzoyHAksezMUt+DD3hoptctz1W2Q7vkXTLj4pvNY5Z3GxvQ
	 AhOyI8FKQe+ui/5uJFMfLKjHxFvVP53O5xn0dHcYCrvlt7WfpV6p6eJfVyEIffHZMCfFm
	 Cl86xemm3N/rl2BxwilAz/0X6UrPIngAQK22fVQduzrwp4oiLTLe+zvMwrhQuRr53yVvI
	 I0lZyUTvv1/CxcFN9+EjMCTYswb5Xx5ScCkgVOnpREZRZAZjKCN5p5hJT8wW9lOC9kQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790869259;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ePkvKhlkDNFVUCqZUtwBmV5LbczDHzCOH8hIPimkI7w=;
	b=nhpN5bDUye/JOz0hGFM/665CHMWYx7flTN1OA7g5YVLC4ed/LVtsbyv1uT0JQyCfILsM
	 PXN49/OzcATTfjWmZIXXDNUwacbFYRdGIcJUykVQ7bAbqgtOKiyBLgDZSGf7q1bMnATcc
	 cG/ZX5UCgnSOzI2zEp9WZddxzB85rLM5QSB1CIx4Z2zQailjrc3C0Fu2NK9nxn2oKgABd
	 X8vRgN4TwzkLDbd+nRTpzUNVDkEr2Tum4upYaTGS6Z3/afOFWKhLMkDzq3Ge1H/iO9yLs
	 BpIOZACr3rtSReHzS3PxQsIFkgwgXatzw/dKOCcCMS9nu9gOFGccskJtZ4/ftyrLIWA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790869259;
	bh=ePkvKhlkDNFVUCqZUtwBmV5LbczDHzCOH8hIPimkI7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g93UWTpUKQeuDrvg5b9YinAZorMLJn4yCQby9Z6B+NTMGK6Oazt4wmVXjDxENhG8G
	 IUeeWUSOQV/EXIURoDFWpUlQz3JJ36popBvEuTFTThRNowsfZ0yxLJTlVd16331kzw
	 +Mk4LOm2a1ur6ShY1/yZyqJ2ieV1NIawbukq58W9jyYsEEX8HRn3RPO4aq90S63L1J
	 nL5ap8MJP5twToVrzqtxHqJmAxhrzItmU2YKmbQZOIWCf89wTGKs4NymaS9tJ2B1lk
	 GyD60MJdquSZDOVhxSL8Kh7Qqq/we5XZzg+2vFH2kOF1t7oeWY0omIrRL5Rlt59r/s
	 Vjz0tlSKPdCGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C9A360B5E;
	Thu,  1 Oct 2026 15:40:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E384C263
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C8A1240C9C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:40:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UWNr2b_sexCK for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 15:40:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5391640C9A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.125.25.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790869256;
 b=oLMzQtdxwOFf/zO75MjfSiN87EN/f4M6Dkls766LB3QwOA5vmgmBat/jZvxmVWoDUuLE
 0uxaXn9b+BHGxOiAtcccutPMuf/mbcym0Ydu9qeBMQNykrK3Poy1exgj++u2C+gDWJu5R
 ZaqLrOJx+zfk70SYutxrvHZvnhZNGBJjaR2PHgmDealXoC9FQAPdbhBFnJsi3ZNkUOLN1
 Hsljrllr+e31LBoszuT12SUpiq403AoYni9XPxOlXrLVQ2qHLzfjDPLb/YebE4OTu5PDY
 1w74dg2Wt+tMQxq4sJN8/+rE+qUSxg89bBx6pDfku5M9RagO6GFEowPSQNLUFevS7rg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790869256;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Infomaniak-Routing;
 bh=ePkvKhlkDNFVUCqZUtwBmV5LbczDHzCOH8hIPimkI7w=;
 b=oMJHmH8lzge6eu9UCcZxq9XCX5ON/zrzADmr7/968fyn/qvMa1UI7FwsEbFYB5KR5L4P
 ESeQd63gIa7BMYRVrLCpmug9xQn3yo5cE4rd6Esxj6YjmqBlnaxa13zHdF7VmymD7cU82
 tYn+Otm16nqtqaIaQBReMqws5HQGVjhrZ0077ThZOzg+BiTMTDkCbjE24DmisH/DqMBmQ
 ZZsoJINHmUKe3t26XLlVbsZjmSlJzv8TcjwqRLUon4kD7++bbhRVF2bWU/A5jolqxM8+/
 z9iMr5jWJ+HMiuzBPyPhw0cqkzUO1gmVH/52akNxAItJJS1tvTWg9R9FQ8AScrp4ubw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=Bq4rcZXB; 
 arc=none smtp.remote-ip=185.125.25.15
X-Greylist: delayed 310 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 01 Oct 2026 15:40:56 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=Bq4rcZXB
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.25.15;
 helo=smtp-190f.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5391640C9A
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 15:40:55 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hwbbM1KYYzHXY;
 Thu,  1 Oct 2026 17:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1790868943;
 bh=ePkvKhlkDNFVUCqZUtwBmV5LbczDHzCOH8hIPimkI7w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Bq4rcZXBb7/4BbtDMDud1qt00tP/Eibn2F1XcqA4RyFhkFVuHyIXbEOjetRrA1pid
 bjB5zbbBAGGr3bSJ85wNymN8gw0DnaZv0IDDTrGM7STo0AIYL+i65CbiPfClTJFYhq
 VBw0qS7qRHBs1llr1ASZkOELqY63ZL2/lxKn+ADdgT6Tmv+pnnHyZn4g+dCzCli+1P
 OcZq6jc/jgtewYvzkUWL6ReZwf2m/f5AS+w1QuHrCNazp1DXlWEOl6EQWHqZml3Yiv
 iZvdwGxtqjg7uKEnZKuF+LNcfAobXh16wB1dQxTu+KDRhG/WDYHdo0HZYdMXXWkWct
 YLGyrQMlOCZtw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hwbbK70PRz48m; Thu,  1 Oct 2026 17:35:41 +0200 (CEST)
Message-ID: <49c6cdf8-4074-4325-9744-9fcfdce0317b@0leil.net>
Date: Thu, 1 Oct 2026 17:35:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Disable SMBIOS table creation for Odroid M2
To: Milivoje Legenovic <m.legenovic@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20260926005853.1727-1-m.legenovic@gmail.com>
 <CAFLszTh=X272wjo4_7B54hYMz4gRZ78KhUuDCKBPzOR8L4RA3g@mail.gmail.com>
 <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <CAGuQyfUdhhFuW-DCgw8C5hA8mkgP9DGyUW6XnLdMZ0q+Ui0QzA@mail.gmail.com>
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

Hi Milivoje,

On 10/1/26 12:28 AM, Milivoje Legenovic wrote:
> [You don't often get email from m.legenovic@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello everyone,
> 
> Here are the details of my analysis:
> The commit that introduced the change in behavior in version 2026.01
> is this one:
> 
> commit 209bbc4e0032228c6ea17e2172a8a6b89756c4f5
> Author: Adriana Nicolae <adriana@arista.com>
> Date:   Thu Nov 27 08:28:34 2025 -0800
> 
>      boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI boots
> 
>      The Linux kernel can discover SMBIOS tables through two primary methods:
>      1. Via EFI tables, when using EFI boot;
>      2. Via the 'smbios3-entrypoint' property in the /chosen node of the
>      device tree.
> ...
> 
> I found this out by comparing the device tree from a working version,
> decompiled using
> 
> sudo dtc -I fs -O dts /sys/firmware/devicetree/base -o live_tree.dts
> 
> and difference was in /chosen node:
> 
> chosen {
>          u-boot,version =
> "2026.01_armbian-2026.01-S127a-P7283-Hee1c-V2928-B3a7f-R448a";
>          linux,initrd-end = <0x00 0xecbffca5>;
>          bootargs = ...
>          smbios3-entrypoint = <0x00 0xedf47000>;
>          kaslr-seed = <0x00 0x00>;
>          linux,initrd-start = <0x00 0xeb519000>;
>          stdout-path = "serial2:1500000n8";
> };
> 
> In 2026.01 version smbios3-entrypoint was there, in 2025.10 not. I
> searched for this term in git history and found the commit mentioned
> above.
> With git show I saw what activates this, and made a patch in armbian
> build system to disable it and confirm it fixes the problem. And it
> fixed it.
> 

As far as my understanding goes, there's actually nothing consuming this 
DT property right now. There is a patch on the Linux kernel mailing 
list, c.f. 
https://lore.kernel.org/lkml/20251031115917.713105-2-adriana@arista.com/ 
but it's not merged. I doubt Armbian would backport this but maybe they did?
So I don't think the *presence* of this property changes anything, but 
there could be side-effects (e.g. actually having the SMBIOS3 table 
somewhere it isn't expected, potentially corrupting e.g. the kernel). 
I'm a bit skeptical though as the commit you point to only adds a 
property, it doesn't seem to be doing anything else.

> Here is also where kernel hangs for 60 seconds (always at the same place):
> 
> [   14.482048] calling  gpio_led_driver_init+0x0/0x38 @ 1
> [   78.137967] Freeing initrd memory: 23448K
> [   78.165027] probe of leds returned 0 after 63677665 usecs
> [   78.166792] initcall gpio_led_driver_init+0x0/0x38 returned 0 after
> 63684076 usecs
> 

So the probe of the drivers/leds/leds-gpio.c driver took 60+seconds, 
that seems quite improbable (well, it technically could be anything on 
the path for this driver to probe, c.f. really_probe() in drivers/base/dd.c.

Can you disable that driver (CONFIG_LEDS_GPIO) and see if it goes 
further? Being curious :) (I see Armbian did some - clearly downstream - 
changes to this driver, so being curious :) ).

Can you provide us with a link (with commit hash) to the exact sources 
of U-Boot and Linux kernel that Armbian builds for your board?

Can you provide us with the full bootlog (including U-Boot up until the 
Linux kernel's hung)?

> As you can see, I was only able to find the cause, but that’s the
> extent of my expertise.
> 
> At first, I wanted to sort out the problem with a patch in the Armbian
> build project, but then I thought: "Why not sort it out at source?"
> 

I'm not convinced we're there yet but that's the kind of spirit I like, 
let's not fix symptoms or consequences :)

Cheers,
Quentin
