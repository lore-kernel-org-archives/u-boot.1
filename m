Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7C68D6E2DE
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A840C8877E;
	Wed, 20 Nov 2024 10:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="q8DxcbCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703328964F; Wed, 20 Nov 2024 10:03:45 +0100 (CET)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82AE98916D
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O63v5S3MscQ9f5pEFpkcPUL7Q0yIOPqAwWIsTJ7n79Q=; b=q8DxcbCuzFfeU2LHETTIXymdQH
 4HWNChMhxE0/RhVXJBsiphzNP46lVTAtFaa9TPpkZIjT5dWE1gZevJ+SVEgiS0N3l84AaxLsKkwv9
 5QSm+9HtSlKbRikfDxWkMl4c6DiG8Ro0k2vSAGf2XdwKXoFQdX8Z2CFdOHaujKJJu9+tAzaf09trv
 /3yVss+SlpmNZ2ARjoctZFdRtvnnW6+3M6LIgkL1YWIgqMvSTrycxKKpduycPGXUmxuSk3eEGB5Wu
 YU9K2IfSAApz52qgm0HXsRvNSCUE+Gk2k2/O8dGDzSewk5vxMdOUk/R9oiHzkHmE6sLLmjhcukW6Q
 LrHr0trA==;
Received: from [89.212.21.243] (port=41650 helo=[192.168.69.116])
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1tDgcf-00CsD0-06;
 Wed, 20 Nov 2024 10:03:41 +0100
Message-ID: <8981f0ad-78c8-41a4-96de-31c25905b632@norik.com>
Date: Wed, 20 Nov 2024 10:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] board: phytec: phycore-imx93: Add 2GB LPDDR4X RAM
 timings
To: Christoph Stoidner <c.stoidner@phytec.de>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Cc: Mathieu Othacehe <m.othacehe@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yannic Moog <y.moog@phytec.de>, Andrej Picej <andrej.picej@norik.com>,
 Wadim Egorov <w.egorov@phytec.de>
References: <20241119162907.17934-1-c.stoidner@phytec.de>
 <20241119162907.17934-2-c.stoidner@phytec.de>
From: Primoz Fiser <primoz.fiser@norik.com>
Content-Language: en-US
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <20241119162907.17934-2-c.stoidner@phytec.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Tested on phyBOARD-Nash-i.MX93 with phyCORE-i.MX93 2GiB SOM

Link: https://gist.github.com/pfiser/d5766c95f5639e6a9852c94412f39eb5

Tested-by: Primoz Fiser <primoz.fiser@norik.com>


On 19. 11. 24 17:29, Christoph Stoidner wrote:
> The phyCORE-i.MX 93 is available with a 1GB ram chip or a 2GB ram chip.
> Add the ram timings for the 2GB chip, in form of a diff compared
> to the existing LPDDR4X 1GB timings. With that, the SPL can select the
> appropriate timings at startup.
> Update also the 1GB ram timings with new version of the DDR Tool.
> 
> Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
> ---
> Cc: Mathieu Othacehe <m.othacehe@gmail.com>
> Cc: Christoph Stoidner <c.stoidner@phytec.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yannic Moog <y.moog@phytec.de>
> Cc: Primoz Fiser <primoz.fiser@norik.com>
> Cc: Andrej Picej <andrej.picej@norik.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> ---
> No changes in v3
> 
> Changes in v2:
> - remove multiple blank lines
> - add update of 1GB ram timings to commit message
> 
>  board/phytec/phycore_imx93/lpddr4_timing.c | 793 +++++++++++++++++++--
>  1 file changed, 732 insertions(+), 61 deletions(-)
> 
> diff --git a/board/phytec/phycore_imx93/lpddr4_timing.c b/board/phytec/phycore_imx93/lpddr4_timing.c
> index 2111972a40..f1261f6a92 100644
> --- a/board/phytec/phycore_imx93/lpddr4_timing.c
> +++ b/board/phytec/phycore_imx93/lpddr4_timing.c
> @@ -1,24 +1,24 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2023 NXP
> - * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> + * Copyright 2024 NXP
> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
>   * Christoph Stoidner <c.stoidner@phytec.de>
>   *
> - * Code generated with DDR Tool v1.0.0.
> + * Code generated with DDR Tool v3.1.0_7.4.
>   */
>  
>  #include <linux/kernel.h>
>  #include <asm/arch/ddr.h>
>  
> +/* Initialize DDRC registers */
>  static struct dram_cfg_param ddr_ddrc_cfg[] = {
> -	/** Initialize DDRC registers **/
>  	{0x4e300110, 0x44100001},
>  	{0x4e300000, 0x8000bf},
>  	{0x4e300008, 0x0},
>  	{0x4e300080, 0x80000412},
>  	{0x4e300084, 0x0},
>  	{0x4e300114, 0x1002},
> -	{0x4e300260, 0x4080},
> +	{0x4e300260, 0x80},
>  	{0x4e300f04, 0x80},
>  	{0x4e300800, 0x43b30002},
>  	{0x4e300804, 0x1f1f1f1f},
> @@ -31,18 +31,17 @@ static struct dram_cfg_param ddr_ddrc_cfg[] = {
>  	{0x4e301254, 0x0},
>  	{0x4e301258, 0x0},
>  	{0x4e30125c, 0x0},
> -
>  };
>  
>  /* dram fsp cfg */
>  static struct dram_fsp_cfg ddr_dram_fsp_cfg[] = {
>  	{
>  		{
> -			{0x4e300100, 0x24A0421B},
> +			{0x4e300100, 0x24A0321B},
>  			{0x4e300104, 0xF8EE001B},
> -			{0x4e300108, 0x2F263233},
> -			{0x4e30010C, 0x0005E18B},
> -			{0x4e300124, 0x1C770000},
> +			{0x4e300108, 0x2F2E3233},
> +			{0x4e30010C, 0x0005C18B},
> +			{0x4e300124, 0x1C790000},
>  			{0x4e300160, 0x00009102},
>  			{0x4e30016C, 0x35F00000},
>  			{0x4e300170, 0x8B0B0608},
> @@ -50,21 +49,73 @@ static struct dram_fsp_cfg ddr_dram_fsp_cfg[] = {
>  			{0x4e300254, 0x00FE00FE},
>  			{0x4e300258, 0x00000008},
>  			{0x4e30025C, 0x00000400},
> -			{0x4e300300, 0x224F2215},
> +			{0x4e300300, 0x224F2213},
>  			{0x4e300304, 0x00FE2213},
> -			{0x4e300308, 0x0A3C0E3C},
> +			{0x4e300308, 0x0A380E3D},
>  		},
>  		{
>  			{0x01, 0xE4},
>  			{0x02, 0x36},
> -			{0x03, 0xF2},
> -			{0x0b, 0x46},
> -			{0x0c, 0x11},
> -			{0x0e, 0x11},
> +			{0x03, 0x22},
> +			{0x0b, 0x44},
> +			{0x0c, 0x1E},
> +			{0x0e, 0x12},
> +			{0x16, 0x04},
> +		},
> +		0,
> +	},
> +	{
> +		{
> +			{0x4e300100, 0x124F2100},
> +			{0x4e300104, 0xF877000E},
> +			{0x4e300108, 0x1816E4AA},
> +			{0x4e30010C, 0x005101E6},
> +			{0x4e300124, 0x0E3C0000},
> +			{0x4e300160, 0x00009101},
> +			{0x4e30016C, 0x30900000},
> +			{0x4e300170, 0x8A0A0508},
> +			{0x4e300250, 0x00000014},
> +			{0x4e300254, 0x007B007B},
> +			{0x4e300258, 0x00000008},
> +			{0x4e30025C, 0x00000400},
> +		},
> +		{
> +			{0x01, 0xB4},
> +			{0x02, 0x1B},
> +			{0x03, 0x22},
> +			{0x0b, 0x44},
> +			{0x0c, 0x1E},
> +			{0x0e, 0x12},
>  			{0x16, 0x04},
>  		},
>  		0,
>  	},
> +	{
> +		{
> +			{0x4e300100, 0x00051000},
> +			{0x4e300104, 0xF855000A},
> +			{0x4e300108, 0x6E620A48},
> +			{0x4e30010C, 0x0031010D},
> +			{0x4e300124, 0x04C50000},
> +			{0x4e300160, 0x00009100},
> +			{0x4e30016C, 0x30000000},
> +			{0x4e300170, 0x89090408},
> +			{0x4e300250, 0x00000007},
> +			{0x4e300254, 0x00240024},
> +			{0x4e300258, 0x00000008},
> +			{0x4e30025C, 0x00000400},
> +		},
> +		{
> +			{0x01, 0x94},
> +			{0x02, 0x9},
> +			{0x03, 0x22},
> +			{0x0b, 0x44},
> +			{0x0c, 0x1E},
> +			{0x0e, 0x12},
> +			{0x16, 0x04},
> +		},
> +		1,
> +	},
>  
>  };
>  
> @@ -90,25 +141,65 @@ static struct dram_cfg_param ddr_ddrphy_cfg[] = {
>  	{0x1015f, 0x5ff},
>  	{0x1105f, 0x5ff},
>  	{0x1115f, 0x5ff},
> +	{0x11005f, 0x5ff},
> +	{0x11015f, 0x5ff},
> +	{0x11105f, 0x5ff},
> +	{0x11115f, 0x5ff},
> +	{0x21005f, 0x5ff},
> +	{0x21015f, 0x5ff},
> +	{0x21105f, 0x5ff},
> +	{0x21115f, 0x5ff},
>  	{0x55, 0x1ff},
>  	{0x1055, 0x1ff},
>  	{0x2055, 0x1ff},
>  	{0x200c5, 0x19},
> +	{0x1200c5, 0xb},
> +	{0x2200c5, 0x7},
>  	{0x2002e, 0x2},
> +	{0x12002e, 0x2},
> +	{0x22002e, 0x2},
>  	{0x90204, 0x0},
> +	{0x190204, 0x0},
> +	{0x290204, 0x0},
>  	{0x20024, 0x1e3},
>  	{0x2003a, 0x2},
>  	{0x2007d, 0x212},
>  	{0x2007c, 0x61},
> +	{0x120024, 0x1e3},
> +	{0x2003a, 0x2},
> +	{0x12007d, 0x212},
> +	{0x12007c, 0x61},
> +	{0x220024, 0x1e3},
> +	{0x2003a, 0x2},
> +	{0x22007d, 0x212},
> +	{0x22007c, 0x61},
>  	{0x20056, 0x3},
> +	{0x120056, 0x3},
> +	{0x220056, 0x3},
>  	{0x1004d, 0x600},
>  	{0x1014d, 0x600},
>  	{0x1104d, 0x600},
>  	{0x1114d, 0x600},
> -	{0x10049, 0xe00},
> -	{0x10149, 0xe00},
> -	{0x11049, 0xe00},
> -	{0x11149, 0xe00},
> +	{0x11004d, 0x600},
> +	{0x11014d, 0x600},
> +	{0x11104d, 0x600},
> +	{0x11114d, 0x600},
> +	{0x21004d, 0x600},
> +	{0x21014d, 0x600},
> +	{0x21104d, 0x600},
> +	{0x21114d, 0x600},
> +	{0x10049, 0x604},
> +	{0x10149, 0x604},
> +	{0x11049, 0x604},
> +	{0x11149, 0x604},
> +	{0x110049, 0x604},
> +	{0x110149, 0x604},
> +	{0x111049, 0x604},
> +	{0x111149, 0x604},
> +	{0x210049, 0x604},
> +	{0x210149, 0x604},
> +	{0x211049, 0x604},
> +	{0x211149, 0x604},
>  	{0x43, 0x60},
>  	{0x1043, 0x60},
>  	{0x2043, 0x60},
> @@ -117,14 +208,30 @@ static struct dram_cfg_param ddr_ddrphy_cfg[] = {
>  	{0x20050, 0x0},
>  	{0x2009b, 0x2},
>  	{0x20008, 0x3a5},
> +	{0x120008, 0x1d3},
> +	{0x220008, 0x9c},
>  	{0x20088, 0x9},
> -	{0x200b2, 0x10c},
> +	{0x200b2, 0x104},
>  	{0x10043, 0x5a1},
>  	{0x10143, 0x5a1},
>  	{0x11043, 0x5a1},
>  	{0x11143, 0x5a1},
> +	{0x1200b2, 0x104},
> +	{0x110043, 0x5a1},
> +	{0x110143, 0x5a1},
> +	{0x111043, 0x5a1},
> +	{0x111143, 0x5a1},
> +	{0x2200b2, 0x104},
> +	{0x210043, 0x5a1},
> +	{0x210143, 0x5a1},
> +	{0x211043, 0x5a1},
> +	{0x211143, 0x5a1},
>  	{0x200fa, 0x2},
> +	{0x1200fa, 0x2},
> +	{0x2200fa, 0x2},
>  	{0x20019, 0x1},
> +	{0x120019, 0x1},
> +	{0x220019, 0x1},
>  	{0x200f0, 0x600},
>  	{0x200f1, 0x0},
>  	{0x200f2, 0x4444},
> @@ -133,42 +240,83 @@ static struct dram_cfg_param ddr_ddrphy_cfg[] = {
>  	{0x200f5, 0x0},
>  	{0x200f6, 0x0},
>  	{0x200f7, 0xf000},
> +	{0x1004a, 0x500},
> +	{0x1104a, 0x500},
>  	{0x20025, 0x0},
> -	{0x2002d, 0x1},
> +	{0x2002d, 0x0},
> +	{0x12002d, 0x0},
> +	{0x22002d, 0x0},
>  	{0x2002c, 0x0},
>  	{0x20021, 0x0},
>  	{0x200c7, 0x21},
>  	{0x1200c7, 0x21},
>  	{0x200ca, 0x24},
>  	{0x1200ca, 0x24},
> -
>  };
>  
> -/* ddr phy trained csr */
> +/* PHY trained csr */
>  static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
>  	{0x1005f, 0x0},
>  	{0x1015f, 0x0},
>  	{0x1105f, 0x0},
>  	{0x1115f, 0x0},
> +	{0x11005f, 0x0},
> +	{0x11015f, 0x0},
> +	{0x11105f, 0x0},
> +	{0x11115f, 0x0},
> +	{0x21005f, 0x0},
> +	{0x21015f, 0x0},
> +	{0x21105f, 0x0},
> +	{0x21115f, 0x0},
>  	{0x55, 0x0},
>  	{0x1055, 0x0},
>  	{0x2055, 0x0},
>  	{0x200c5, 0x0},
> +	{0x1200c5, 0x0},
> +	{0x2200c5, 0x0},
>  	{0x2002e, 0x0},
> +	{0x12002e, 0x0},
> +	{0x22002e, 0x0},
>  	{0x90204, 0x0},
> +	{0x190204, 0x0},
> +	{0x290204, 0x0},
>  	{0x20024, 0x0},
>  	{0x2003a, 0x0},
>  	{0x2007d, 0x0},
>  	{0x2007c, 0x0},
> +	{0x120024, 0x0},
> +	{0x12007d, 0x0},
> +	{0x12007c, 0x0},
> +	{0x220024, 0x0},
> +	{0x22007d, 0x0},
> +	{0x22007c, 0x0},
>  	{0x20056, 0x0},
> +	{0x120056, 0x0},
> +	{0x220056, 0x0},
>  	{0x1004d, 0x0},
>  	{0x1014d, 0x0},
>  	{0x1104d, 0x0},
>  	{0x1114d, 0x0},
> +	{0x11004d, 0x0},
> +	{0x11014d, 0x0},
> +	{0x11104d, 0x0},
> +	{0x11114d, 0x0},
> +	{0x21004d, 0x0},
> +	{0x21014d, 0x0},
> +	{0x21104d, 0x0},
> +	{0x21114d, 0x0},
>  	{0x10049, 0x0},
>  	{0x10149, 0x0},
>  	{0x11049, 0x0},
>  	{0x11149, 0x0},
> +	{0x110049, 0x0},
> +	{0x110149, 0x0},
> +	{0x111049, 0x0},
> +	{0x111149, 0x0},
> +	{0x210049, 0x0},
> +	{0x210149, 0x0},
> +	{0x211049, 0x0},
> +	{0x211149, 0x0},
>  	{0x43, 0x0},
>  	{0x1043, 0x0},
>  	{0x2043, 0x0},
> @@ -177,14 +325,30 @@ static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
>  	{0x20050, 0x0},
>  	{0x2009b, 0x0},
>  	{0x20008, 0x0},
> +	{0x120008, 0x0},
> +	{0x220008, 0x0},
>  	{0x20088, 0x0},
>  	{0x200b2, 0x0},
>  	{0x10043, 0x0},
>  	{0x10143, 0x0},
>  	{0x11043, 0x0},
>  	{0x11143, 0x0},
> +	{0x1200b2, 0x0},
> +	{0x110043, 0x0},
> +	{0x110143, 0x0},
> +	{0x111043, 0x0},
> +	{0x111143, 0x0},
> +	{0x2200b2, 0x0},
> +	{0x210043, 0x0},
> +	{0x210143, 0x0},
> +	{0x211043, 0x0},
> +	{0x211143, 0x0},
>  	{0x200fa, 0x0},
> +	{0x1200fa, 0x0},
> +	{0x2200fa, 0x0},
>  	{0x20019, 0x0},
> +	{0x120019, 0x0},
> +	{0x220019, 0x0},
>  	{0x200f0, 0x0},
>  	{0x200f1, 0x0},
>  	{0x200f2, 0x0},
> @@ -193,8 +357,12 @@ static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
>  	{0x200f5, 0x0},
>  	{0x200f6, 0x0},
>  	{0x200f7, 0x0},
> +	{0x1004a, 0x0},
> +	{0x1104a, 0x0},
>  	{0x20025, 0x0},
>  	{0x2002d, 0x0},
> +	{0x12002d, 0x0},
> +	{0x22002d, 0x0},
>  	{0x2002c, 0x0},
>  	{0xd0000, 0x0},
>  	{0x90000, 0x0},
> @@ -682,6 +850,14 @@ static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
>  	{0x2000c, 0x0},
>  	{0x2000d, 0x0},
>  	{0x2000e, 0x0},
> +	{0x12000b, 0x0},
> +	{0x12000c, 0x0},
> +	{0x12000d, 0x0},
> +	{0x12000e, 0x0},
> +	{0x22000b, 0x0},
> +	{0x22000c, 0x0},
> +	{0x22000d, 0x0},
> +	{0x22000e, 0x0},
>  	{0x9000c, 0x0},
>  	{0x9000d, 0x0},
>  	{0x9000e, 0x0},
> @@ -692,12 +868,26 @@ static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
>  	{0x90013, 0x0},
>  	{0x20010, 0x0},
>  	{0x20011, 0x0},
> +	{0x120010, 0x0},
> +	{0x120011, 0x0},
>  	{0x40080, 0x0},
>  	{0x40081, 0x0},
>  	{0x40082, 0x0},
>  	{0x40083, 0x0},
>  	{0x40084, 0x0},
>  	{0x40085, 0x0},
> +	{0x140080, 0x0},
> +	{0x140081, 0x0},
> +	{0x140082, 0x0},
> +	{0x140083, 0x0},
> +	{0x140084, 0x0},
> +	{0x140085, 0x0},
> +	{0x240080, 0x0},
> +	{0x240081, 0x0},
> +	{0x240082, 0x0},
> +	{0x240083, 0x0},
> +	{0x240084, 0x0},
> +	{0x240085, 0x0},
>  	{0x400fd, 0x0},
>  	{0x400f1, 0x0},
>  	{0x10011, 0x0},
> @@ -866,6 +1056,160 @@ static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
>  	{0x90207, 0x0},
>  	{0x90208, 0x0},
>  	{0x20020, 0x0},
> +	{0x100080, 0x0},
> +	{0x101080, 0x0},
> +	{0x102080, 0x0},
> +	{0x110020, 0x0},
> +	{0x110080, 0x0},
> +	{0x110081, 0x0},
> +	{0x1100d0, 0x0},
> +	{0x1100d1, 0x0},
> +	{0x11008c, 0x0},
> +	{0x11008d, 0x0},
> +	{0x110180, 0x0},
> +	{0x110181, 0x0},
> +	{0x1101d0, 0x0},
> +	{0x1101d1, 0x0},
> +	{0x11018c, 0x0},
> +	{0x11018d, 0x0},
> +	{0x1100c0, 0x0},
> +	{0x1100c1, 0x0},
> +	{0x1101c0, 0x0},
> +	{0x1101c1, 0x0},
> +	{0x1102c0, 0x0},
> +	{0x1102c1, 0x0},
> +	{0x1103c0, 0x0},
> +	{0x1103c1, 0x0},
> +	{0x1104c0, 0x0},
> +	{0x1104c1, 0x0},
> +	{0x1105c0, 0x0},
> +	{0x1105c1, 0x0},
> +	{0x1106c0, 0x0},
> +	{0x1106c1, 0x0},
> +	{0x1107c0, 0x0},
> +	{0x1107c1, 0x0},
> +	{0x1108c0, 0x0},
> +	{0x1108c1, 0x0},
> +	{0x1100ae, 0x0},
> +	{0x1100af, 0x0},
> +	{0x111020, 0x0},
> +	{0x111080, 0x0},
> +	{0x111081, 0x0},
> +	{0x1110d0, 0x0},
> +	{0x1110d1, 0x0},
> +	{0x11108c, 0x0},
> +	{0x11108d, 0x0},
> +	{0x111180, 0x0},
> +	{0x111181, 0x0},
> +	{0x1111d0, 0x0},
> +	{0x1111d1, 0x0},
> +	{0x11118c, 0x0},
> +	{0x11118d, 0x0},
> +	{0x1110c0, 0x0},
> +	{0x1110c1, 0x0},
> +	{0x1111c0, 0x0},
> +	{0x1111c1, 0x0},
> +	{0x1112c0, 0x0},
> +	{0x1112c1, 0x0},
> +	{0x1113c0, 0x0},
> +	{0x1113c1, 0x0},
> +	{0x1114c0, 0x0},
> +	{0x1114c1, 0x0},
> +	{0x1115c0, 0x0},
> +	{0x1115c1, 0x0},
> +	{0x1116c0, 0x0},
> +	{0x1116c1, 0x0},
> +	{0x1117c0, 0x0},
> +	{0x1117c1, 0x0},
> +	{0x1118c0, 0x0},
> +	{0x1118c1, 0x0},
> +	{0x1110ae, 0x0},
> +	{0x1110af, 0x0},
> +	{0x190201, 0x0},
> +	{0x190202, 0x0},
> +	{0x190203, 0x0},
> +	{0x190205, 0x0},
> +	{0x190206, 0x0},
> +	{0x190207, 0x0},
> +	{0x190208, 0x0},
> +	{0x120020, 0x0},
> +	{0x200080, 0x0},
> +	{0x201080, 0x0},
> +	{0x202080, 0x0},
> +	{0x210020, 0x0},
> +	{0x210080, 0x0},
> +	{0x210081, 0x0},
> +	{0x2100d0, 0x0},
> +	{0x2100d1, 0x0},
> +	{0x21008c, 0x0},
> +	{0x21008d, 0x0},
> +	{0x210180, 0x0},
> +	{0x210181, 0x0},
> +	{0x2101d0, 0x0},
> +	{0x2101d1, 0x0},
> +	{0x21018c, 0x0},
> +	{0x21018d, 0x0},
> +	{0x2100c0, 0x0},
> +	{0x2100c1, 0x0},
> +	{0x2101c0, 0x0},
> +	{0x2101c1, 0x0},
> +	{0x2102c0, 0x0},
> +	{0x2102c1, 0x0},
> +	{0x2103c0, 0x0},
> +	{0x2103c1, 0x0},
> +	{0x2104c0, 0x0},
> +	{0x2104c1, 0x0},
> +	{0x2105c0, 0x0},
> +	{0x2105c1, 0x0},
> +	{0x2106c0, 0x0},
> +	{0x2106c1, 0x0},
> +	{0x2107c0, 0x0},
> +	{0x2107c1, 0x0},
> +	{0x2108c0, 0x0},
> +	{0x2108c1, 0x0},
> +	{0x2100ae, 0x0},
> +	{0x2100af, 0x0},
> +	{0x211020, 0x0},
> +	{0x211080, 0x0},
> +	{0x211081, 0x0},
> +	{0x2110d0, 0x0},
> +	{0x2110d1, 0x0},
> +	{0x21108c, 0x0},
> +	{0x21108d, 0x0},
> +	{0x211180, 0x0},
> +	{0x211181, 0x0},
> +	{0x2111d0, 0x0},
> +	{0x2111d1, 0x0},
> +	{0x21118c, 0x0},
> +	{0x21118d, 0x0},
> +	{0x2110c0, 0x0},
> +	{0x2110c1, 0x0},
> +	{0x2111c0, 0x0},
> +	{0x2111c1, 0x0},
> +	{0x2112c0, 0x0},
> +	{0x2112c1, 0x0},
> +	{0x2113c0, 0x0},
> +	{0x2113c1, 0x0},
> +	{0x2114c0, 0x0},
> +	{0x2114c1, 0x0},
> +	{0x2115c0, 0x0},
> +	{0x2115c1, 0x0},
> +	{0x2116c0, 0x0},
> +	{0x2116c1, 0x0},
> +	{0x2117c0, 0x0},
> +	{0x2117c1, 0x0},
> +	{0x2118c0, 0x0},
> +	{0x2118c1, 0x0},
> +	{0x2110ae, 0x0},
> +	{0x2110af, 0x0},
> +	{0x290201, 0x0},
> +	{0x290202, 0x0},
> +	{0x290203, 0x0},
> +	{0x290205, 0x0},
> +	{0x290206, 0x0},
> +	{0x290207, 0x0},
> +	{0x290208, 0x0},
> +	{0x220020, 0x0},
>  	{0x20077, 0x0},
>  	{0x20072, 0x0},
>  	{0x20073, 0x0},
> @@ -888,7 +1232,6 @@ static struct dram_cfg_param ddr_ddrphy_trained_csr[] = {
>  	{0x11640, 0x0},
>  	{0x11740, 0x0},
>  	{0x11840, 0x0},
> -
>  };
>  
>  /* P0 message block parameter for training firmware */
> @@ -896,7 +1239,7 @@ static struct dram_cfg_param ddr_fsp0_cfg[] = {
>  	{0xd0000, 0x0},
>  	{0x54003, 0xe94},
>  	{0x54004, 0x4},
> -	{0x54006, 0x15},
> +	{0x54006, 0x14},
>  	{0x54008, 0x131f},
>  	{0x54009, 0xc8},
>  	{0x5400b, 0x4},
> @@ -904,26 +1247,102 @@ static struct dram_cfg_param ddr_fsp0_cfg[] = {
>  	{0x5400f, 0x100},
>  	{0x54012, 0x110},
>  	{0x54019, 0x36e4},
> -	{0x5401a, 0xf2},
> -	{0x5401b, 0x1146},
> -	{0x5401c, 0x1108},
> +	{0x5401a, 0x22},
> +	{0x5401b, 0x1e44},
> +	{0x5401c, 0x1208},
>  	{0x5401e, 0x4},
>  	{0x5401f, 0x36e4},
> -	{0x54020, 0xf2},
> -	{0x54021, 0x1146},
> -	{0x54022, 0x1108},
> +	{0x54020, 0x22},
> +	{0x54021, 0x1e44},
> +	{0x54022, 0x1208},
>  	{0x54024, 0x4},
>  	{0x54032, 0xe400},
> -	{0x54033, 0xf236},
> -	{0x54034, 0x4600},
> -	{0x54035, 0x811},
> -	{0x54036, 0x11},
> +	{0x54033, 0x2236},
> +	{0x54034, 0x4400},
> +	{0x54035, 0x81e},
> +	{0x54036, 0x12},
>  	{0x54037, 0x400},
>  	{0x54038, 0xe400},
> -	{0x54039, 0xf236},
> -	{0x5403a, 0x4600},
> -	{0x5403b, 0x811},
> -	{0x5403c, 0x11},
> +	{0x54039, 0x2236},
> +	{0x5403a, 0x4400},
> +	{0x5403b, 0x81e},
> +	{0x5403c, 0x12},
> +	{0x5403d, 0x400},
> +	{0xd0000, 0x1}
> +};
> +
> +/* P1 message block parameter for training firmware */
> +static struct dram_cfg_param ddr_fsp1_cfg[] = {
> +	{0xd0000, 0x0},
> +	{0x54002, 0x1},
> +	{0x54003, 0x74a},
> +	{0x54004, 0x4},
> +	{0x54006, 0x14},
> +	{0x54008, 0x121f},
> +	{0x54009, 0xc8},
> +	{0x5400b, 0x4},
> +	{0x5400d, 0x100},
> +	{0x5400f, 0x100},
> +	{0x54012, 0x110},
> +	{0x54019, 0x1bb4},
> +	{0x5401a, 0x22},
> +	{0x5401b, 0x1e44},
> +	{0x5401c, 0x1208},
> +	{0x5401e, 0x4},
> +	{0x5401f, 0x1bb4},
> +	{0x54020, 0x22},
> +	{0x54021, 0x1e44},
> +	{0x54022, 0x1208},
> +	{0x54024, 0x4},
> +	{0x54032, 0xb400},
> +	{0x54033, 0x221b},
> +	{0x54034, 0x4400},
> +	{0x54035, 0x81e},
> +	{0x54036, 0x12},
> +	{0x54037, 0x400},
> +	{0x54038, 0xb400},
> +	{0x54039, 0x221b},
> +	{0x5403a, 0x4400},
> +	{0x5403b, 0x81e},
> +	{0x5403c, 0x12},
> +	{0x5403d, 0x400},
> +	{0xd0000, 0x1}
> +};
> +
> +/* P2 message block parameter for training firmware */
> +static struct dram_cfg_param ddr_fsp2_cfg[] = {
> +	{0xd0000, 0x0},
> +	{0x54002, 0x102},
> +	{0x54003, 0x270},
> +	{0x54004, 0x4},
> +	{0x54006, 0x14},
> +	{0x54008, 0x121f},
> +	{0x54009, 0xc8},
> +	{0x5400b, 0x4},
> +	{0x5400d, 0x100},
> +	{0x5400f, 0x100},
> +	{0x54012, 0x110},
> +	{0x54019, 0x994},
> +	{0x5401a, 0x22},
> +	{0x5401b, 0x1e44},
> +	{0x5401c, 0x1200},
> +	{0x5401e, 0x4},
> +	{0x5401f, 0x994},
> +	{0x54020, 0x22},
> +	{0x54021, 0x1e44},
> +	{0x54022, 0x1200},
> +	{0x54024, 0x4},
> +	{0x54032, 0x9400},
> +	{0x54033, 0x2209},
> +	{0x54034, 0x4400},
> +	{0x54035, 0x1e},
> +	{0x54036, 0x12},
> +	{0x54037, 0x400},
> +	{0x54038, 0x9400},
> +	{0x54039, 0x2209},
> +	{0x5403a, 0x4400},
> +	{0x5403b, 0x1e},
> +	{0x5403c, 0x12},
>  	{0x5403d, 0x400},
>  	{0xd0000, 0x1}
>  };
> @@ -933,7 +1352,7 @@ static struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
>  	{0xd0000, 0x0},
>  	{0x54003, 0xe94},
>  	{0x54004, 0x4},
> -	{0x54006, 0x15},
> +	{0x54006, 0x14},
>  	{0x54008, 0x61},
>  	{0x54009, 0xc8},
>  	{0x5400b, 0x4},
> @@ -942,26 +1361,26 @@ static struct dram_cfg_param ddr_fsp0_2d_cfg[] = {
>  	{0x54010, 0x2080},
>  	{0x54012, 0x110},
>  	{0x54019, 0x36e4},
> -	{0x5401a, 0xf2},
> -	{0x5401b, 0x1146},
> -	{0x5401c, 0x1108},
> +	{0x5401a, 0x22},
> +	{0x5401b, 0x1e44},
> +	{0x5401c, 0x1208},
>  	{0x5401e, 0x4},
>  	{0x5401f, 0x36e4},
> -	{0x54020, 0xf2},
> -	{0x54021, 0x1146},
> -	{0x54022, 0x1108},
> +	{0x54020, 0x22},
> +	{0x54021, 0x1e44},
> +	{0x54022, 0x1208},
>  	{0x54024, 0x4},
>  	{0x54032, 0xe400},
> -	{0x54033, 0xf236},
> -	{0x54034, 0x4600},
> -	{0x54035, 0x811},
> -	{0x54036, 0x11},
> +	{0x54033, 0x2236},
> +	{0x54034, 0x4400},
> +	{0x54035, 0x81e},
> +	{0x54036, 0x12},
>  	{0x54037, 0x400},
>  	{0x54038, 0xe400},
> -	{0x54039, 0xf236},
> -	{0x5403a, 0x4600},
> -	{0x5403b, 0x811},
> -	{0x5403c, 0x11},
> +	{0x54039, 0x2236},
> +	{0x5403a, 0x4400},
> +	{0x5403b, 0x81e},
> +	{0x5403c, 0x12},
>  	{0x5403d, 0x400},
>  	{0xd0000, 0x1}
>  };
> @@ -1451,10 +1870,18 @@ static struct dram_cfg_param ddr_phy_pie[] = {
>  	{0x400d7, 0x20b},
>  	{0x2003a, 0x2},
>  	{0x200be, 0x3},
> -	{0x2000b, 0x75},
> +	{0x2000b, 0x41a},
>  	{0x2000c, 0xe9},
>  	{0x2000d, 0x91c},
>  	{0x2000e, 0x2c},
> +	{0x12000b, 0x20d},
> +	{0x12000c, 0x74},
> +	{0x12000d, 0x48e},
> +	{0x12000e, 0x2c},
> +	{0x22000b, 0xb0},
> +	{0x22000c, 0x27},
> +	{0x22000d, 0x186},
> +	{0x22000e, 0x10},
>  	{0x9000c, 0x0},
>  	{0x9000d, 0x173},
>  	{0x9000e, 0x60},
> @@ -1465,12 +1892,26 @@ static struct dram_cfg_param ddr_phy_pie[] = {
>  	{0x90013, 0x6152},
>  	{0x20010, 0x5a},
>  	{0x20011, 0x3},
> +	{0x120010, 0x5a},
> +	{0x120011, 0x3},
>  	{0x40080, 0xe0},
>  	{0x40081, 0x12},
>  	{0x40082, 0xe0},
>  	{0x40083, 0x12},
>  	{0x40084, 0xe0},
>  	{0x40085, 0x12},
> +	{0x140080, 0xe0},
> +	{0x140081, 0x12},
> +	{0x140082, 0xe0},
> +	{0x140083, 0x12},
> +	{0x140084, 0xe0},
> +	{0x140085, 0x12},
> +	{0x240080, 0xe0},
> +	{0x240081, 0x12},
> +	{0x240082, 0xe0},
> +	{0x240083, 0x12},
> +	{0x240084, 0xe0},
> +	{0x240085, 0x12},
>  	{0x400fd, 0xf},
>  	{0x400f1, 0xe},
>  	{0x10011, 0x1},
> @@ -1505,7 +1946,6 @@ static struct dram_cfg_param ddr_phy_pie[] = {
>  	{0x20088, 0x19},
>  	{0xc0080, 0x0},
>  	{0xd0000, 0x1},
> -
>  };
>  
>  static struct dram_fsp_msg ddr_dram_fsp_msg[] = {
> @@ -1515,9 +1955,21 @@ static struct dram_fsp_msg ddr_dram_fsp_msg[] = {
>  		.fw_type = FW_1D_IMAGE,
>  		.fsp_cfg = ddr_fsp0_cfg,
>  		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_cfg),
> -
>  	},
> -
> +	{
> +		/* P1 1866mts 1D */
> +		.drate = 1866,
> +		.fw_type = FW_1D_IMAGE,
> +		.fsp_cfg = ddr_fsp1_cfg,
> +		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp1_cfg),
> +	},
> +	{
> +		/* P2 625mts 1D */
> +		.drate = 625,
> +		.fw_type = FW_1D_IMAGE,
> +		.fsp_cfg = ddr_fsp2_cfg,
> +		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp2_cfg),
> +	},
>  	{
>  		/* P0 3733mts 2D */
>  		.drate = 3733,
> @@ -1525,7 +1977,6 @@ static struct dram_fsp_msg ddr_dram_fsp_msg[] = {
>  		.fsp_cfg = ddr_fsp0_2d_cfg,
>  		.fsp_cfg_num = ARRAY_SIZE(ddr_fsp0_2d_cfg),
>  	},
> -
>  };
>  
>  /* ddr timing config params */
> @@ -1540,7 +1991,227 @@ struct dram_timing_info dram_timing = {
>  	.ddrphy_trained_csr_num = ARRAY_SIZE(ddr_ddrphy_trained_csr),
>  	.ddrphy_pie = ddr_phy_pie,
>  	.ddrphy_pie_num = ARRAY_SIZE(ddr_phy_pie),
> -	.fsp_table = { 3733, },
> +	.fsp_table = { 3733, 1866, 625, },
>  	.fsp_cfg = ddr_dram_fsp_cfg,
>  	.fsp_cfg_num = ARRAY_SIZE(ddr_dram_fsp_cfg),
>  };
> +
> +void set_dram_timings_2gb_lpddr4x(void)
> +{
> +	/* Initialize DDRC registers */
> +	dram_timing.ddrc_cfg[1].val = 0x8000ff;
> +	dram_timing.ddrc_cfg[3].val = 0x80000512;
> +
> +	/* dram fsp cfg */
> +	dram_timing.fsp_cfg[0].ddrc_cfg[0].val = 0x24AB321B;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[2].val = 0x2F2EE233;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[9].val = 0x015B015B;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[13].val = 0x015B2213;
> +	dram_timing.fsp_cfg[0].mr_cfg[4].val = 0x20;
> +	dram_timing.fsp_cfg[0].mr_cfg[5].val = 0x13;
> +
> +	dram_timing.fsp_cfg[1].ddrc_cfg[0].val = 0x12552100;
> +	dram_timing.fsp_cfg[1].ddrc_cfg[2].val = 0x1816B4AA;
> +	dram_timing.fsp_cfg[1].ddrc_cfg[9].val = 0x00AA00AA;
> +	dram_timing.fsp_cfg[1].mr_cfg[4].val = 0x20;
> +	dram_timing.fsp_cfg[1].mr_cfg[5].val = 0x13;
> +
> +	dram_timing.fsp_cfg[2].ddrc_cfg[0].val = 0x00061000;
> +	dram_timing.fsp_cfg[2].ddrc_cfg[2].val = 0x6E62FA48;
> +	dram_timing.fsp_cfg[2].ddrc_cfg[9].val = 0x00340034;
> +	dram_timing.fsp_cfg[2].mr_cfg[4].val = 0x20;
> +	dram_timing.fsp_cfg[2].mr_cfg[5].val = 0x13;
> +
> +	/* P0 message block parameter for training firmware */
> +	dram_timing.fsp_msg[0].fsp_cfg[12].val = 0x2044;
> +	dram_timing.fsp_msg[0].fsp_cfg[13].val = 0x1308;
> +	dram_timing.fsp_msg[0].fsp_cfg[17].val = 0x2044;
> +	dram_timing.fsp_msg[0].fsp_cfg[18].val = 0x1308;
> +	dram_timing.fsp_msg[0].fsp_cfg[23].val = 0x820;
> +	dram_timing.fsp_msg[0].fsp_cfg[24].val = 0x13;
> +	dram_timing.fsp_msg[0].fsp_cfg[29].val = 0x820;
> +	dram_timing.fsp_msg[0].fsp_cfg[30].val = 0x13;
> +
> +	/* P1 message block parameter for training firmware */
> +	dram_timing.fsp_msg[1].fsp_cfg[13].val = 0x2044;
> +	dram_timing.fsp_msg[1].fsp_cfg[14].val = 0x1308;
> +	dram_timing.fsp_msg[1].fsp_cfg[18].val = 0x2044;
> +	dram_timing.fsp_msg[1].fsp_cfg[19].val = 0x1308;
> +	dram_timing.fsp_msg[1].fsp_cfg[24].val = 0x820;
> +	dram_timing.fsp_msg[1].fsp_cfg[25].val = 0x13;
> +	dram_timing.fsp_msg[1].fsp_cfg[30].val = 0x820;
> +	dram_timing.fsp_msg[1].fsp_cfg[31].val = 0x13;
> +
> +	/* P2 message block parameter for training firmware */
> +	dram_timing.fsp_msg[2].fsp_cfg[13].val = 0x2044;
> +	dram_timing.fsp_msg[2].fsp_cfg[14].val = 0x1300;
> +	dram_timing.fsp_msg[2].fsp_cfg[18].val = 0x2044;
> +	dram_timing.fsp_msg[2].fsp_cfg[19].val = 0x1300;
> +	dram_timing.fsp_msg[2].fsp_cfg[24].val = 0x20;
> +	dram_timing.fsp_msg[2].fsp_cfg[25].val = 0x13;
> +	dram_timing.fsp_msg[2].fsp_cfg[30].val = 0x20;
> +	dram_timing.fsp_msg[2].fsp_cfg[31].val = 0x13;
> +
> +	/* P0 2D message block parameter for training firmware */
> +	dram_timing.fsp_msg[3].fsp_cfg[13].val = 0x2044;
> +	dram_timing.fsp_msg[3].fsp_cfg[14].val = 0x1308;
> +	dram_timing.fsp_msg[3].fsp_cfg[18].val = 0x2044;
> +	dram_timing.fsp_msg[3].fsp_cfg[19].val = 0x1308;
> +	dram_timing.fsp_msg[3].fsp_cfg[24].val = 0x820;
> +	dram_timing.fsp_msg[3].fsp_cfg[25].val = 0x13;
> +	dram_timing.fsp_msg[3].fsp_cfg[30].val = 0x820;
> +	dram_timing.fsp_msg[3].fsp_cfg[31].val = 0x13;
> +}
> +
> +/* Generated with DDR Tool v3.3.0_7.8-d1cdb7d3 */
> +void set_dram_timings_1gb_lpddr4x_900mhz(void)
> +{
> +	/* Initialize DDRC registers */
> +	dram_timing.ddrc_cfg[6].val = 0x4080;
> +
> +	/* dram fsp cfg */
> +	dram_timing.fsp_cfg[0].ddrc_cfg[0].val = 0x124F2100;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[1].val = 0xF877000E;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[2].val = 0x181AE4AA;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[3].val = 0x005101E6;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[4].val = 0x0E3C0000;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[5].val = 0x00009101;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[6].val = 0x30900000;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[7].val = 0x8A0A0508;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[8].val = 0x00000014;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[9].val = 0x007B007B;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[12].val = 0x1128110B;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[13].val = 0x007B140A;
> +	dram_timing.fsp_cfg[0].ddrc_cfg[14].val = 0x0620071E;
> +	dram_timing.fsp_cfg[0].mr_cfg[0].val = 0xB4;
> +	dram_timing.fsp_cfg[0].mr_cfg[1].val = 0x1B;
> +	dram_timing.fsp_cfg[0].mr_cfg[2].val = 0xE2;
> +	dram_timing.fsp_cfg[0].mr_cfg[4].val = 0x20;
> +	dram_timing.fsp_cfg[0].mr_cfg[5].val = 0x15;
> +
> +	dram_timing.fsp_cfg[1].ddrc_cfg[2].val = 0x181AE4AA;
> +	dram_timing.fsp_cfg[1].mr_cfg[2].val = 0xE2;
> +	dram_timing.fsp_cfg[1].mr_cfg[4].val = 0x20;
> +	dram_timing.fsp_cfg[1].mr_cfg[5].val = 0x15;
> +
> +	dram_timing.fsp_cfg[2].ddrc_cfg[2].val = 0x6E660A48;
> +	dram_timing.fsp_cfg[2].mr_cfg[2].val = 0xE2;
> +	dram_timing.fsp_cfg[2].mr_cfg[4].val = 0x20;
> +	dram_timing.fsp_cfg[2].mr_cfg[5].val = 0x15;
> +
> +	/* PHY Initialize Configuration */
> +	dram_timing.ddrphy_cfg[31].val = 0xb;
> +	dram_timing.ddrphy_cfg[86].val = 0x1d3;
> +	dram_timing.ddrphy_cfg[90].val = 0x10c;
> +	dram_timing.ddrphy_cfg[95].val = 0x10c;
> +	dram_timing.ddrphy_cfg[100].val = 0x10c;
> +	dram_timing.ddrphy_cfg[122].val = 0x1;
> +	/**
> +	 * NOTE:
> +	 * In the output from DDR Tool v3.3.0_7.8-d1cdb7d3, array members 119
> +	 * (reg=0x1004a, val=0x500) and 120 (reg=0x1104a, val=0x500) are not
> +	 * present in the ddr_ddrphy_cfg array. However they were present in array
> +	 * generated with previous DDR Tool v3.1.0_7.4. We simply set both values
> +	 * to default value of 0x400 (read with dwc_ddrphy_apb_rd()) here to avoid
> +	 * any negative side-effects.
> +	 */
> +	dram_timing.ddrphy_cfg[119].val = 0x400;
> +	dram_timing.ddrphy_cfg[120].val = 0x400;
> +
> +	/**
> +	 * NOTE:
> +	 * In the output from DDR Tool v3.3.0_7.8-d1cdb7d3, array members 101
> +	 * (reg=0x1004a, val=0x0) and 120 (reg=0x1104a, val=0x0) are not present
> +	 * in the ddr_ddrphy_trained_csr array. However they were present in array
> +	 * generated with previous DDR Tool v3.1.0_7.4. We simply set both values
> +	 * to default 0x0 (like all other ddrphy_trained_csr values) here to avoid
> +	 * any negative side-effects.
> +	 */
> +	/* PHY trained csr */
> +	dram_timing.ddrphy_trained_csr[101].val = 0x0;
> +	dram_timing.ddrphy_trained_csr[102].val = 0x0;
> +
> +	/* P0 message block parameter for training firmware */
> +	dram_timing.fsp_msg[0].fsp_cfg[1].val = 0x74a;
> +	dram_timing.fsp_msg[0].fsp_cfg[3].val = 0x15;
> +	dram_timing.fsp_msg[0].fsp_cfg[10].val = 0x1bb4;
> +	dram_timing.fsp_msg[0].fsp_cfg[11].val = 0xe2;
> +	dram_timing.fsp_msg[0].fsp_cfg[12].val = 0x2044;
> +	dram_timing.fsp_msg[0].fsp_cfg[13].val = 0x1508;
> +	dram_timing.fsp_msg[0].fsp_cfg[15].val = 0x1bb4;
> +	dram_timing.fsp_msg[0].fsp_cfg[16].val = 0xe2;
> +	dram_timing.fsp_msg[0].fsp_cfg[17].val = 0x2044;
> +	dram_timing.fsp_msg[0].fsp_cfg[18].val = 0x1508;
> +	dram_timing.fsp_msg[0].fsp_cfg[20].val = 0xb400;
> +	dram_timing.fsp_msg[0].fsp_cfg[21].val = 0xe21b;
> +	dram_timing.fsp_msg[0].fsp_cfg[23].val = 0x820;
> +	dram_timing.fsp_msg[0].fsp_cfg[24].val = 0x15;
> +	dram_timing.fsp_msg[0].fsp_cfg[26].val = 0xb400;
> +	dram_timing.fsp_msg[0].fsp_cfg[27].val = 0xe21b;
> +	dram_timing.fsp_msg[0].fsp_cfg[29].val = 0x820;
> +	dram_timing.fsp_msg[0].fsp_cfg[30].val = 0x15;
> +
> +	/* P1 message block parameter for training firmware */
> +	dram_timing.fsp_msg[1].fsp_cfg[4].val = 0x15;
> +	dram_timing.fsp_msg[1].fsp_cfg[12].val = 0xe2;
> +	dram_timing.fsp_msg[1].fsp_cfg[13].val = 0x2044;
> +	dram_timing.fsp_msg[1].fsp_cfg[14].val = 0x1508;
> +	dram_timing.fsp_msg[1].fsp_cfg[17].val = 0xe2;
> +	dram_timing.fsp_msg[1].fsp_cfg[18].val = 0x2044;
> +	dram_timing.fsp_msg[1].fsp_cfg[19].val = 0x1508;
> +	dram_timing.fsp_msg[1].fsp_cfg[22].val = 0xe21b;
> +	dram_timing.fsp_msg[1].fsp_cfg[24].val = 0x820;
> +	dram_timing.fsp_msg[1].fsp_cfg[25].val = 0x15;
> +	dram_timing.fsp_msg[1].fsp_cfg[28].val = 0xe21b;
> +	dram_timing.fsp_msg[1].fsp_cfg[30].val = 0x820;
> +	dram_timing.fsp_msg[1].fsp_cfg[31].val = 0x15;
> +
> +	/* P2 message block parameter for training firmware */
> +	dram_timing.fsp_msg[2].fsp_cfg[4].val = 0x15;
> +	dram_timing.fsp_msg[2].fsp_cfg[12].val = 0xe2;
> +	dram_timing.fsp_msg[2].fsp_cfg[13].val = 0x2044;
> +	dram_timing.fsp_msg[2].fsp_cfg[14].val = 0x1500;
> +	dram_timing.fsp_msg[2].fsp_cfg[17].val = 0xe2;
> +	dram_timing.fsp_msg[2].fsp_cfg[18].val = 0x2044;
> +	dram_timing.fsp_msg[2].fsp_cfg[19].val = 0x1500;
> +	dram_timing.fsp_msg[2].fsp_cfg[22].val = 0xe209;
> +	dram_timing.fsp_msg[2].fsp_cfg[24].val = 0x20;
> +	dram_timing.fsp_msg[2].fsp_cfg[25].val = 0x15;
> +	dram_timing.fsp_msg[2].fsp_cfg[28].val = 0xe209;
> +	dram_timing.fsp_msg[2].fsp_cfg[30].val = 0x20;
> +	dram_timing.fsp_msg[2].fsp_cfg[31].val = 0x15;
> +
> +	/* P0 2D message block parameter for training firmware */
> +	dram_timing.fsp_msg[3].fsp_cfg[1].val = 0x74a;
> +	dram_timing.fsp_msg[3].fsp_cfg[3].val = 0x15;
> +	dram_timing.fsp_msg[3].fsp_cfg[11].val = 0x1bb4;
> +	dram_timing.fsp_msg[3].fsp_cfg[12].val = 0xe2;
> +	dram_timing.fsp_msg[3].fsp_cfg[13].val = 0x2044;
> +	dram_timing.fsp_msg[3].fsp_cfg[14].val = 0x1508;
> +	dram_timing.fsp_msg[3].fsp_cfg[16].val = 0x1bb4;
> +	dram_timing.fsp_msg[3].fsp_cfg[17].val = 0xe2;
> +	dram_timing.fsp_msg[3].fsp_cfg[18].val = 0x2044;
> +	dram_timing.fsp_msg[3].fsp_cfg[19].val = 0x1508;
> +	dram_timing.fsp_msg[3].fsp_cfg[21].val = 0xb400;
> +	dram_timing.fsp_msg[3].fsp_cfg[22].val = 0xe21b;
> +	dram_timing.fsp_msg[3].fsp_cfg[24].val = 0x820;
> +	dram_timing.fsp_msg[3].fsp_cfg[25].val = 0x15;
> +	dram_timing.fsp_msg[3].fsp_cfg[27].val = 0xb400;
> +	dram_timing.fsp_msg[3].fsp_cfg[28].val = 0xe21b;
> +	dram_timing.fsp_msg[3].fsp_cfg[30].val = 0x820;
> +	dram_timing.fsp_msg[3].fsp_cfg[31].val = 0x15;
> +
> +	/* DRAM PHY init engine image */
> +	dram_timing.ddrphy_pie[483].val = 0x20d;
> +	dram_timing.ddrphy_pie[484].val = 0x74;
> +	dram_timing.ddrphy_pie[485].val = 0x48e;
> +
> +	/* P0 3733mts 1D */
> +	dram_timing.fsp_msg[0].drate = 1866;
> +
> +	/* P0 1866mts 2D */
> +	dram_timing.fsp_msg[3].drate = 1866;
> +
> +	/* ddr timing config params */
> +	dram_timing.fsp_table[0] = 1866;
> +}

-- 
Primoz Fiser                    | phone: +386-41-390-545
<tel:+386-41-390-545> |
---------------------------------------------------------|
Norik systems d.o.o.            | https://www.norik.com
<https://www.norik.com>  |
Your embedded software partner  | email: info@norik.com
<mailto:info@norik.com> |
Slovenia, EU                    | phone: +386-41-540-545
<tel:+386-41-540-545> |

