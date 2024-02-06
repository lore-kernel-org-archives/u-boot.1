Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35494C48286
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 05:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8184A8798F;
	Tue,  6 Feb 2024 06:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="UP8PSPLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82FF9879A2; Tue,  6 Feb 2024 06:52:23 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 252FB87964
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 06:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707198740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GCs5ycan7w9Pji72SjWDTMFa8WOmvNiggrLoQlJ7utE=;
 b=UP8PSPLnVPPMu2UnSXH3YQ/pi/oaWVJTBjvJwc8Y67+dfJ4Pb78xLkr+70DkfhCDqJLSnA
 6RXk0dD1ApgowaTZoE94g8JtdV/VCI8MsGzJ53J2oE4vLdO+D4alqEOULGDEiqvv3RGFt4
 9FF18/Ln0THLIqHIkaCazH63rWhANOYMC/8lCuoZdy4fatvdRXwnmPL1szWtjLCvUCuW6L
 vG388IZ8602I7FIaYtyU3zqqyKuBfagx07/d61JyBwbEfip1TqruxKrJZuUy/DXRHnDs7S
 C/CEPhO5OMIiQ5Cb6JamQgGuKw4Waae/jlXONh/n3FWErTLtqxMn1P1+eutDgA==
Date: Tue, 06 Feb 2024 06:52:19 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Nicolas Frattaroli
 <frattaroli.nicolas@gmail.com>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>, Tianling Shen
 <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>, Eugen Hristev
 <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>, Weizhao
 Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
In-Reply-To: <39a349b2-8ddc-4806-94fe-79355aa7d5f0@kwiboo.se>
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-2-jonas@kwiboo.se>
 <3ec22d95-ee0d-4a0b-8c0e-90067ba0dc32@theobroma-systems.com>
 <b889d4e3-f507-4520-a02e-212f4ce9c7c7@kwiboo.se>
 <66d3d8ad40cfce744e8b80c9ad0419eb@manjaro.org>
 <be5b2bd5-f855-4585-b59d-c6d0c1df16d4@theobroma-systems.com>
 <e1c70a4b74cd4da978e98927dc08485f@manjaro.org>
 <39a349b2-8ddc-4806-94fe-79355aa7d5f0@kwiboo.se>
Message-ID: <f935a6be2317d9d8c68c9603504f4939@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Jonas,

On 2024-02-05 18:01, Jonas Karlman wrote:
> On 2024-02-05 14:51, Dragan Simic wrote:
>> On 2024-02-05 14:45, Quentin Schulz wrote:
>>> On 2/5/24 14:40, Dragan Simic wrote:
>>>> How about waiting until I fix the mode selection in the Linux kernel
>>>> drivers?  As I noted already, that's already on my TODO list, and
>>>> perhaps it would be good to test a bit again under Linux with those
>>>> fixes applied, before actually removing the buggy modes from the
>>>> kernel's RK356x and RK3588(s) SoC dtsi files.
>>> 
>>> While I appreciate there's some work that can be done in the Linux
>>> kernel for those low-speed modes, the properties in question are
>>> removed only from U-Boot's DTS and your future patches for the kernel
>>> wouldn't impact the bootloader anyway.
>>> 
>>> The issue right now is that U-Boot is currently broken because of
>>> those properties, which are only in U-Boot's DTS.
>>> 
>>> Not sure exactly why we should waiting on Linux kernel patches for
>>> merging work-arounds for U-Boot? What exactly are you suggesting we
>>> wait for? What can improve the situation?
>> 
>> Ah, sorry for the confusion, let me clarify a bit...
>> 
>> I just replied to the Jonas's remark about the need to eventually
>> have the same fixes and mode removals in the Linux kernel's SoC dtsi
>> files.  In other words, all I wrote was about those changes, not
>> about the changes on the U-Boot side.
>> 
>> Of course, there are no reasons for delaying these U-Boot fixes.
> 
> Short history about the added eMMC modes in u-boot.dtsi on RK35xx 
> boards:
> 
> U-Boot defaults to not support HS200+ modes unless explicitly enabled 
> in
> Kconfig options and on top of that the driver require DT to have a
> corresponding mode prop to make use of any mode faster than MMC legacy.
> 
> When I worked on eMMC fixes for RK3568 and support for RK3588 [1] I 
> only
> tested reading data using all modes.
> 
> Because reading data in all modes seem to work on the boards I tested 
> on,
> I eventually added the "missing" props to board u-boot.dtsi-files, so
> that U-Boot could make use of faster modes. However, I opted to only
> enable the HS200 Kconfig option on boards with embedded eMMC.
> 
> This has resulted in that most RK35xx boards now default to using the
> fastest none HS200+ mode, i.e. DDR52 mode. They would also try to use a
> faster mode as long as a HS200+ Kconfig option is enabled.
> 
> With the removal of mmc-ddr-1_8v prop in this series, at least the most
> broken mode is avoided for all RK35xx boards. And with the HS200 
> Kconfig
> option enabled by default, the required tuning in HS200+ mode should
> automatically happen as long as eMMC module support HS200 mode. After
> that writing in any supported lower speed seem to work OK.
> 
> In the case where HS200 is supported any read/write in lower speed seem
> to work, so the modes provided by cap-mmc-highspeed prop is OK.
> 
> However, if HS200+ is not supported it does not really matter, first
> write will fail in any remaining mode, the slowest legacy or the modes
> provided by cap-mmc-highspeed prop.
> 
> Keeping the cap-mmc-highspeed prop at least make reading data faster
> possible, and writing data is still semi-broken in any remaining mode.
> 
> In conclusion I suggest:
> 
> - We keep the cap-mmc-highspeed props in board u-boot.dtsi for now.
> 
> - The mmc mode props that has been added in board u-boot.dtsi and have
>   been validated working with both U-Boot and linux should be added to
>   board DT. e.g HS200+ props is missing in some board DT.
> 
> - When an updated board DT has been synced from linux, any override in
>   board u-boot.dtsi should be dropped.
> 
> I am also fine with completely dropping cap-mmc-highspeed props now if
> they cause issues not solved by the HS200 Kconfig option being enabled.
> 
> [1] https://patchwork.ozlabs.org/cover/1764606/

Thank you for taking the time to write this detailed summary!

It's somewhat unexpected that the writes to eMMC fail to work while
the reads work fine.  As we know, the writes don't introduce the delay
between the host-generated clock and the data to be written.  It would
be expected for the reads to be more error-prone.
