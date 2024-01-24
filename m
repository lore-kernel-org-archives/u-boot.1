Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B73AC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 04:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2581387BD3;
	Wed, 24 Jan 2024 05:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ra5wn+9j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A3787BC7; Wed, 24 Jan 2024 05:06:35 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D848783B
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 05:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1706069193;
 bh=zrAUeuw7lJyuuSnefYFCyayPOSTbpVhr0OZyDrZhaKM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ra5wn+9jxwZj9VpT7j/ea8lBXO4huAkBaurvEfDOffvxsvgpHgxyVgHcdrd5QNf5e
 /FasRhsLx1rtk//UqrhvxU6ZyggjBo8bHtqvwH/YEF1N3B/Ym0SwT47LF3orL/bs2T
 vKr8kkT4zdhIN9W8kAEe7PhcKHwS+8N5v7LfP6qnThSVu6W0DuplsKWRL/uS2ol+Df
 H7geJyslwOBh4+MChibtBT1+5z0A1AQN+ka5zU8J3KulZkCLNMvDUHJp+rW5xEzSBI
 gShybCfkOLxUOtuJnesYQP5FYXjXtOqT9ap1/p3Bphbg6c3wmWhiJtF5+EsSresRZl
 aFwc2Kuimvi+g==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 08ED537810CD;
 Wed, 24 Jan 2024 04:06:30 +0000 (UTC)
Message-ID: <8c0a3a40-2d1b-47e9-9fb2-9b5e409f96d7@collabora.com>
Date: Wed, 24 Jan 2024 06:06:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Facilitate new atmel raw nand driver for SAMA5D2
Content-Language: en-US
To: Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Wenyou Yang <wenyou.yang@microchip.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <20231212160423.44290-1-ada@thorsis.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20231212160423.44290-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
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

On 12/12/23 18:04, Alexander Dahl wrote:
> Hei hei,
> 
> for some downstream boards with SAMA5D27 SiP SoCs with raw NAND flash I
> added the necessary nodes to sama5d2.dtsi with just one little
> guesswork: the clocks.  Motivation was to fix reading from raw nand
> flash which failed on some of those boards, while others worked fine.
> So I suppose the timings for the external interface were set to too slow
> values. (IIRC I took them from the sama5d2_ptc_ek_nandflash board code
> back in 2019.)
> 
> The solution was basically to switch from the old non-DM driver with
> hardcoded timings for the external memory interface to the new DM based
> driver introduced earlier this year, which sets the timings based on
> ONFI parameters read from the flash chip.
> 
> Works for me, but I have no boards with that SoC _and_ a raw NAND flash
> at hand, which are supported by upstream U-Boot.  The only matching
> upstream config is sama5d2_ptc_ek_nandflash_defconfig but because we
> don't have that board, I did not touch it.
> 
> (When that driver was added with 6a8dfd57220d ("nand: atmel: Add DM
> based NAND driver") the author claims in the commit message it was
> tested on SAMA5D3, but none of the sama5d3 configs actually uses it.)
> 
> Some more changes to the board dts are necessary, but porting from Linux
> is straightforward.  The necessary changes to the defconfig should look
> like this:
> 
>  # CONFIG_I2C is not set
>  CONFIG_LED=y
>  CONFIG_LED_GPIO=y
> +CONFIG_ATMEL_EBI=y
> +CONFIG_MFD_ATMEL_SMC=y
>  # CONFIG_MMC is not set
>  CONFIG_MTD=y
> -CONFIG_NAND_ATMEL=y
> -CONFIG_ATMEL_NAND_HW_PMECC=y
> -CONFIG_PMECC_CAP=8
> +CONFIG_DM_MTD=y
> +CONFIG_DM_NAND_ATMEL=y
>  CONFIG_SYS_NAND_ONFI_DETECTION=y
>  CONFIG_PHY_SMSC=y
>  CONFIG_MACB=y
> 
> Hope the changes are acceptable nevertheless.  The last patch has a
> trivial fix for the new atmel raw nand driver which I came up with while
> working on this.
> 
> Greets
> Alex
> 
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Wenyou Yang <wenyou.yang@microchip.com>
> Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
> 
> Alexander Dahl (4):
>   ARM: dts: at91: sama5d2: Move sfr node
>   ARM: dts: at91: sama5d2: Port ebi/nand nodes from linux
>   ARM: dts: at91: sama5d2: Align more node names with Linux
>   mtd: nand: raw: atmel: Remove duplicate definitions
> 
>  arch/arm/dts/sama5d2.dtsi          | 74 ++++++++++++++++++++++++++----
>  drivers/mtd/nand/raw/atmel/pmecc.c |  3 --
>  2 files changed, 65 insertions(+), 12 deletions(-)
> 
> 
> base-commit: 2f0282922b2c458eea7f85c500a948a587437b63


Applied series to u-boot-at91/master, thanks !
