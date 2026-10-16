Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A082ECC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 17:28:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CC1460B15;
	Fri, 16 Oct 2026 17:28:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAiGa6lhNiiX; Fri, 16 Oct 2026 17:28:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4E14C60ADC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792171698;
	b=ayAo9m0yZBGvHxrOySBm67Ik0QIVgMtkEEXEHC1sLAvB1uTKLV+0F4LeQhA5F0BAjklT
	 uvPsZsaBBgmo/es/lAB/ZyAG07zTiaC4VTJS+QD8EZ0BUXncf38vfhHc2QBmTlaZzwFkn
	 JkPaa9RWZvA3vGVTfU/AbiB8czvbbIpJZbGFFvzQSYiO52zhIsGh1OYIb70FPK9woAKgI
	 KCibe6Teu2xJu/lT3np9FsyVB1lH0FkgKd5Xh+/tTFjgrAX7qHSyU/jl/NbxF27p7I1iX
	 uyJaSdOaoJXhoKjYzlR4YIkIg/8yLw9CDN2MHRzwJzcWpd7U0HsvD6Sy07kE6oxG6fw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792171698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=99ywM5dpAZzpUcqdjafjhWbdSuz0HMN56ZAW6HyrbKU=;
	b=rIMlvjKD4KJxNwWp8HRIGjz5ePcJy7FRbqDDTJ62g/FlxzqwtxrxNLyvVrXvomp1HKNN
	 y/gOB60srKsqax5RPz+Y5wst+jdHy/cj2QcqC4q/STtUOZNyCCJ4eRmPVqkALBXWwc/Pk
	 yo4ToB++9WoJdE7iQZldEoQNA4tqU8yr3TBL5eF2yzuSQHsH/iiIox0ElnMMsIXYfTCgj
	 /kNzH7diccuWHIXqThpWI7BKItrWveq8hkCPuJVrY5xA3Sz1J/deS7g/V2StXg4pGc2il
	 Y4sQyvc6SRZrMeCGRh7xIRH4qIQINox/7OEzKDUfzJ3Onab45/9ooy1ppcDrSScS78A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792171698;
	bh=99ywM5dpAZzpUcqdjafjhWbdSuz0HMN56ZAW6HyrbKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KmYBkzS/NyQq0oTjpVPJbkMt1EnYU1j3vHMqt3OGEFEaZ7yI4ceAEtsuqKyphk1fD
	 dBBOUs/zRuOV7DVmmi4eANWJOiadVB226zhEskmb9Sg3t5ofXfhEy+TtywQ91mAemc
	 5OhYlaB+QLUeI0ssyueXU5/ePAzi4sz8Y/d3rDptE7Rg0eEZ9XJtNHzLUUy9M3sCkC
	 AnhKhPdsP5fYaieShzOf2fELZBi9c3SVRdVvMXwx7NG9SSSBwQQ1Rn1GX4z4FfP1W8
	 5nJBLR3+zl+DsVW2m1oWgN4vh7fHXAaWoA1n/06SRElaVn37swOJ1S1P2GzWe5UQqL
	 NXcN5kySQ/nBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E14C60ADC;
	Fri, 16 Oct 2026 17:28:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7BCDD1DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6DBE540087
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7_I1fumgcy6p for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 17:28:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9C5BB40042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792171696;
 b=SV8DODNnffXYugNb0iJNdrEd+brEhrVRDSjr1300ZqKvmE6vS3wHjs9hRzNcja5ySYco
 SQbiFMm7Alpm4207Y2NCpJjeTqJGRIu9rgIfS0v25/mAfwJZiWPx0lnBv1iAhtVVipevs
 Yn55HSo/7wrKQ8jw8DRZroTmi+aWcdO9UYBU2TxNY31brNlHXly/wSW4Mqs/kGec46k7G
 Bp2rPdXKkThvwwtET1Os9dS2nWMYIzjI0VLz1HSnJUQgaaK+5FYJ8G8M/IWwhYxbfyRz1
 ZrrWWOYnKaMcx+03WXfXKCJGTA0IZGjTfMF4tpmmXzHpC8jH2FlWyo4Fks1D6GZx71w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792171696;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=99ywM5dpAZzpUcqdjafjhWbdSuz0HMN56ZAW6HyrbKU=;
 b=G5m5ar4wadwUnPWL01LvGSHplYmwhQVsGbNSigd84SPDmsE294yS3Nu8S2nGM/N4gbmv
 YhhK1DT/zHPsXN5C7BmSV+WGRy85wx6ddDdETKTJnla8oDaZKN31j0L3saWxG4DF5Dept
 ooFHFRQ3FGmN42rvIh9QqF2CgXovuFOloB52VGVSQrYSNAM2vwASSfAf8T/qIndHIpslJ
 Ka3HoUTIMuiAx7kpu6BWHEFKQGkmfiV2I9mUDtqeAXGPEW0hvrZgN1+IFrWDkgnefVcHG
 Kv6dTe4T4No7no6X1hy3k2X7RgyNcvHmFZbW0xYzLrwE3A6vBRHLJUSocGUgEzVT8xQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=Fvy5KhrW; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=andre.przywara@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=Fvy5KhrW
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C5BB40042
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 17:28:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65EC51477;
 Fri, 16 Oct 2026 10:28:10 -0700 (PDT)
Received: from [10.33.8.90] (e142021.arm.com [10.33.8.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22513F673;
 Fri, 16 Oct 2026 10:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792171693; bh=pcBT9zHT1D+p03B66uMDp4qvamCxtc5RSZ9WpV6l/DQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Fvy5KhrWczzctkoGURksT06H7dsNSNdQre6J2qKdGtJ2H00abbO9LkyMRVuYfzQub
 U3oGyEemBCSx0QAMC3TA9BdF6ygcDcSeR1nhAHOrf+WdHozoHSsvnK2il5UXq6MZ41
 UFEZ7S4nzDI4NaZfTAmI7Mj1FPeeQ74LGU1mDTuc=
Message-ID: <40856b24-1767-4fda-89af-11c51d3ec816@arm.com>
Date: Fri, 16 Oct 2026 18:28:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] sunxi: add the Allwinner B288 and the PocketBook Verse
To: Pablo Mazzini <pmazzini@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev
References: <20261016091608.121842-1-pmazzini@gmail.com>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261016091608.121842-1-pmazzini@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Pablo,

On 10/16/26 11:16, Pablo Mazzini wrote:
> The Allwinner B288 (sun8iw10p1) is a dual Cortex-A7 SoC used in e-book
> readers. This series adds SPL and U-Boot support for it, and one board:
> the PocketBook Verse (PB629).
 > > The DT is still under review for Linux. Until it reaches
> dts/upstream, the last patch carries a copy in arch/arm/dts.

Thanks for sending this, much appreciated. I had a coarse look over 
this, and this looks fine on the first glance.
As you said, this is somewhat blocked on the DT merge on the Linux side, 
which will probably not happen this year anymore (v7.5-rc1 would be the 
earliest).
But meanwhile, in preparation for that, could you please reorder the 
patches, so you enable the devices first (clocks, pinctrl, mmc), then 
DRAM, then the general support patch, with the defconfig on top.

For the DT parts: please try to emulate the future situation, so put the 
files in the directories where they would end up eventually. You can try 
to take the Linux DT binding patch (for clock and reset), and just 
change the paths in there to point to the respective dts/upstream 
directories. This is what would happen anyway, look for those 
cherry-picks and upstream references in the dts/upstream git log.
And the patch(es) wouldn't be taken as such anyway, but they provide a 
test base and reference for other people, until the DT lands.

There is no need to send a new version now, just wait until you receive 
some review or other comments.

Cheers,
Andre

> 
> Tested on a PB629.
> 
> Pablo Mazzini (7):
>    sunxi: add support for the Allwinner B288
>    sunxi: dram: support the Allwinner B288
>    dt-bindings: clock: add the Allwinner B288 CCU
>    clk: sunxi: add the Allwinner B288 gates and resets
>    pinctrl: sunxi: add the Allwinner B288 PIO
>    mmc: sunxi: B288 mmc0/mmc1 run off PLL_PERIPH0 2x
>    sunxi: add the PocketBook Verse
> 
>   arch/arm/cpu/armv7/sunxi/psci.c              |   9 +-
>   arch/arm/dts/Makefile                        |   2 +
>   arch/arm/dts/sun8i-b288-pocketbook-verse.dts | 114 ++++++++
>   arch/arm/dts/sun8i-b288.dtsi                 | 292 +++++++++++++++++++
>   arch/arm/include/asm/arch-sunxi/cpu.h        |   1 +
>   arch/arm/include/asm/arch-sunxi/cpu_sun4i.h  |  16 +-
>   arch/arm/mach-sunxi/Kconfig                  |  14 +
>   arch/arm/mach-sunxi/board.c                  |   4 +
>   arch/arm/mach-sunxi/clock_sun6i.c            |   1 +
>   arch/arm/mach-sunxi/cpu_info.c               |   2 +
>   arch/arm/mach-sunxi/dram_sunxi_dw.c          |  97 +++++-
>   board/sunxi/MAINTAINERS                      |   6 +
>   configs/pocketbook_verse_defconfig           |  10 +
>   drivers/clk/sunxi/Kconfig                    |   7 +
>   drivers/clk/sunxi/Makefile                   |   1 +
>   drivers/clk/sunxi/clk_b288.c                 | 101 +++++++
>   drivers/clk/sunxi/clk_sunxi.c                |   5 +
>   drivers/mmc/sunxi_mmc.c                      |   7 +
>   drivers/pinctrl/sunxi/Kconfig                |   5 +
>   drivers/pinctrl/sunxi/pinctrl-sunxi.c        |  22 ++
>   include/dt-bindings/clock/sun8i-b288-ccu.h   |  82 ++++++
>   include/dt-bindings/reset/sun8i-b288-ccu.h   |  45 +++
>   include/sunxi_gpio.h                         |   1 +
>   23 files changed, 827 insertions(+), 17 deletions(-)
>   create mode 100644 arch/arm/dts/sun8i-b288-pocketbook-verse.dts
>   create mode 100644 arch/arm/dts/sun8i-b288.dtsi
>   create mode 100644 configs/pocketbook_verse_defconfig
>   create mode 100644 drivers/clk/sunxi/clk_b288.c
>   create mode 100644 include/dt-bindings/clock/sun8i-b288-ccu.h
>   create mode 100644 include/dt-bindings/reset/sun8i-b288-ccu.h
> 
> 
> base-commit: 65a7532545336e4b73e049a69436e255da7df961

