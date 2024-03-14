Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49821C54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 08:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A81487F01;
	Thu, 14 Mar 2024 09:47:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="KxTmGBl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CB787F0E; Thu, 14 Mar 2024 09:47:15 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 380F6876E4
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 09:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1710406032;
 bh=Au1lJRXbR8O1S1ctH/QA0A7FJcSUV0/kHqmPg9zXXVY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KxTmGBl/TG+DCs/FFsScO0gTegJHyNlUP6pnO0bC1RPFFKzlWDqm12XK5nw7Xx3zI
 nS9L7pcsyLtGHMo84FtZ9q/uTYjGQPIM3FyLKq1YWgQ7a2immfSY3TGtj0Z+J350xF
 ffPmgLoyVeveFp4nTy1ObqYsi/7LwE+aAot2acOt4movqK2wy7OaAEA9TYPXimaB3g
 j/+hF4Hw4RXJ9Hxtjoh2bQGINs+SJW7rDYT5QzyNK+ebH2V5DcI9/739p671lxPIeb
 5tAr9tzAXdeyYUN9N6tDBZ6fClMz2sQ2KNY7Wf6qRLz+axgokn7soANP58C93h/x2x
 d5oCBwAAcAYWA==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1A235378105A;
 Thu, 14 Mar 2024 08:47:10 +0000 (UTC)
Message-ID: <e9eae6f0-0472-44fd-a17a-92bd3bd0531a@collabora.com>
Date: Thu, 14 Mar 2024 10:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add initial support for Microchip SAMA7G54
 Curiosity board
Content-Language: en-US
To: Mihai Sain <mihai.sain@microchip.com>, u-boot@lists.denx.de
Cc: cristian.birsan@microchip.com
References: <20240227134403.10686-1-mihai.sain@microchip.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20240227134403.10686-1-mihai.sain@microchip.com>
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

On 2/27/24 15:43, Mihai Sain wrote:
> This patch series adds initial support for Microchip SAMA7G54 Curiosity board.
> 
> Changes in v2:
> --------------
> 
> * Update flexcom 10 node in order to match previous flexcom definitions.
> * Sort in alphabetical order all nodes and pinctrl.
> * Remove status okay from leds, nand, eeprom, flash.
> * Add CONFIG_ENV_SIZE=0x4000 in mmc defconfig.
> * Set CONFIG_ENV_SECT_SIZE=0x10000 in qspiflash defconfig.
> 
> Mihai Sain (4):
>   ARM: dts: at91: sama7g5: Add flexcom 10 node
>   ARM: dts: at91: sama7g54_curiosity: Add initial device tree of the board
>   board: at91: sama7g54_curiosity: Add initial board support
>   configs: at91: sama7g54_curiosity: Add initial default configs
> 
>  arch/arm/dts/Makefile                         |   3 +
>  .../dts/at91-sama7g54_curiosity-u-boot.dtsi   |  59 +++++
>  arch/arm/dts/at91-sama7g54_curiosity.dts      | 242 ++++++++++++++++++
>  arch/arm/dts/sama7g5.dtsi                     |  24 ++
>  arch/arm/mach-at91/Kconfig                    |  10 +
>  board/atmel/sama7g54_curiosity/Kconfig        |  15 ++
>  board/atmel/sama7g54_curiosity/MAINTAINERS    |   9 +
>  board/atmel/sama7g54_curiosity/Makefile       |   7 +
>  .../sama7g54_curiosity/sama7g54_curiosity.c   |  36 +++
>  configs/sama7g54_curiosity_mmc_defconfig      | 123 +++++++++
>  .../sama7g54_curiosity_nandflash_defconfig    | 122 +++++++++
>  .../sama7g54_curiosity_qspiflash_defconfig    | 122 +++++++++
>  include/configs/sama7g54_curiosity.h          |  17 ++
>  13 files changed, 789 insertions(+)
>  create mode 100644 arch/arm/dts/at91-sama7g54_curiosity-u-boot.dtsi
>  create mode 100644 arch/arm/dts/at91-sama7g54_curiosity.dts
>  create mode 100644 board/atmel/sama7g54_curiosity/Kconfig
>  create mode 100644 board/atmel/sama7g54_curiosity/MAINTAINERS
>  create mode 100644 board/atmel/sama7g54_curiosity/Makefile
>  create mode 100644 board/atmel/sama7g54_curiosity/sama7g54_curiosity.c
>  create mode 100644 configs/sama7g54_curiosity_mmc_defconfig
>  create mode 100644 configs/sama7g54_curiosity_nandflash_defconfig
>  create mode 100644 configs/sama7g54_curiosity_qspiflash_defconfig
>  create mode 100644 include/configs/sama7g54_curiosity.h
> 


Applied to u-boot-at91/next , thanks !
