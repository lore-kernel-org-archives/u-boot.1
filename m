Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012A4C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B1F360DD0;
	Fri, 21 Aug 2026 13:17:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gtqotwv-sz4r; Fri, 21 Aug 2026 13:17:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318064;
	bh=lGf+IT7u3vx13i87XGmPTr4Jo/HB5/02CLT8YVW8kTQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P9eornugmRN9JOQZXFLko7HyZYXF6T9oYo7OhAeorivuCXvfc/K5qk0VI/qTzTfBl
	 FRzMbUwzBioEuZa3vDCzgmuOW5uo+kHMXreP5qkRs2d4rNbB2n08vSDJlJKdxk1MPk
	 pQONDTVSBh3pb8b2H9GyC+z9qY9jKKqPELW35Ufpk/L3JWIK7SC1I56N9mvUnw/GZn
	 kh3UOIDtznZfxPujkkxj32OvE2gbn0J93w4GwaIZ4xEdw2sjpeBkoxcFStB4ocqEQC
	 GeTmS70f+GleOyOLrj26eN9rtaKjdkPA2m1NHwXm1K2lBwZFNxSPIEnHD/DId2pNik
	 1mv8aVm/3CGzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21EA660EB7;
	Fri, 21 Aug 2026 13:14:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61EE81B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 04:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5431D60A3F
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 04:11:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8q4cjEPlp2WB for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 04:11:48 +0000 (UTC)
X-Greylist: delayed 351 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 21 Aug 2026 04:11:47 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=FTDmHL6D
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7677608CA
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 04:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1787285128;
 bh=lGf+IT7u3vx13i87XGmPTr4Jo/HB5/02CLT8YVW8kTQ=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=FTDmHL6DFtqVMxyp8lXHgDmYS6Cv4wY3feE9cVkDoZq4g9VIOyZV/Uc/4QuluVk1/
 oYqAZ1G1wD9sQOD/Iol4NajPHJRBhnF6hVrygyeE1HpjLCj08VmGIo1ET2hT82FdmZ
 hXa95mFRoBBR3HK03IiNRnE63oYxMc9xU/rApcSZlwsIxK10teernUC9e4z3inmmtm
 jrdTa4RGKD3h+hq8q9hyXc+0lcIdzMCP2fQs7tb7gABndrl9ILi8LNgOmM/8dDfvB0
 T81V0D9b8z122wZONx4+JrwKmaMTS238G0jGG8x0hE+52bqbTjjcQhUOH2WIxnXqUh
 PSdVN2ucIbTbw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id EF932B225C39;
 Fri, 21 Aug 2026 06:05:27 +0200 (CEST)
Message-ID: <3164cc59-695c-459b-af4e-840836573036@freeshell.de>
Date: Thu, 20 Aug 2026 21:05:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add fastboot to SPL
To: Stefan Monnier <monnier@iro.umontreal.ca>,
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>,
 Jonas Karlman <jonas@kwiboo.se>
References: <20260820-ccaione-upstream-spl-fastboot-v4-0-57e5ef71c74d__17726.0234997206$1787249364$gmane$org@baylibre.com>
 <jwv8q60y6nj.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <jwv8q60y6nj.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:12:32 +0000
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

Hi Stefan,

On 8/20/26 11:50, Stefan Monnier wrote:
> Carlo Caione [2026-08-20 20:08:24] wrote:
>> Some recovery and initial-provisioning flows need a standard host protocol
>> before usable firmware is available in persistent storage. U-Boot already
>> provides fastboot, but the implementation can currently be started only
>> from the U-Boot-proper command line.
> 
> I'm curious.  In my limited exposure to U-Boot, I got the impression that
> the split between SPL and U-Boot proper is mostly a "technical detail",
> usually mostly hidden from those who install it onto a device: you just
> take the combined U-Boot + SPL image and write it at the appropriate
> offset on the relevant device.  And usually if SPL works, U-Boot
> also works.
> 
> So a bit like Jonas in the recent "hotkey in SPL" patch for rockchip
> SoCs, I'm curious why/when we'd want to add to SPL functionality already
> supported from U-Boot.
> 
> 
> === Stefan
> 

The purpose of SPL is to have small codesize so that it may run in SoC
on-die memory in the most permissive operational mode, select for
hardware configuration settings (devicetree model), load U-Boot main app
to more plentiful off-die memory (DRAM), and then either jump execution
to U-Boot main app itself or pass execution to a system supervisor that
would run U-Boot main app in some different operational mode.

This requires that U-Boot main app exists somewhere that may be loaded
from (UART serial, SPI flash, MMC storage...) and further complicates
the use of U-Boot SPL as a fast and efficient recovery tool.

If adding fastboot feature to SPL does not balloon the codesize beyond
hardware limits then it is a very interesting feature to enable, indeed.

Sometimes the SPL is not something we control or have insight into. The
vendor may have provided some proprietary SPL via code obscurity or
cryptographic signing or it will be the functionality of some
proprietary on-die firmware IP block. More typically though the on-die
boot ROM has functionality that may include fastboot-alike
functionality, UART loading, and MMC loading capability for transferring
SPL and jumping code execution to that but without initializing DRAM.

Additionally there may be additional firmware for some SoC cores that
require initializing with e.g. realtime operating system for power
management or DSP functions, and that must be done before changing the
operational mode (so before U-Boot main app).

I'm no expert on this but if I get some detail wrong it is not
intentional, much of this confusion was the same for me when I begin to
look at the situation for RISC-V.

-E
