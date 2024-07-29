Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4613C3DA49
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 01:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B969B8841D;
	Mon, 29 Jul 2024 03:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RIeA493d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1315A882D6; Mon, 29 Jul 2024 03:35:03 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98EB1882D6
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 03:35:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=woods.technical@gmail.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-64b417e1511so16512327b3.3
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 18:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722216899; x=1722821699; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=us2CKvHWQD7hxj3uutBZsLWM6HFNuk8mRX1RhCfEDng=;
 b=RIeA493d0De/nSLazyobIQ1swq8umhE593z6Z+BCeIPbJb7K7rINaEjx2CzfIvqiNv
 dHJQTDUWofNpiOCTQC3kSnmDBbeYjB9wyIGmE6jTLRQ6DHitR0R/B7Tklkig44bB3mjD
 i7v98LtC3PirlUvBduU4eanrZq7LnHpZxAfjtTO0OQoMEmEhnAQa1pzKwYfwhtgvr14a
 HGKhSrxDoVBb2TG/q82nMJTJVqNC9ZSV8nRgs/9g0L3o1BKwetAUh+t0rCLj6nXsH+db
 rIu8B1n7PDBYQz5bMgYYq7T4NcZs1O855KV/Z8NP8l9wnKXBIhz2uOvMTvDpqvXVHJ86
 06ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722216899; x=1722821699;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=us2CKvHWQD7hxj3uutBZsLWM6HFNuk8mRX1RhCfEDng=;
 b=wzzZPYg+Xay/S/YuWCa+hfV7IuhR7NFdnBwpKZ3DEY3/oUM65cMqal1rxQBV+uTfNF
 6DO/h/taygCoGVyVaGef/1QpHeLph59OQb78CZzf0brHjIt0byW+dxnQZQSHrX3iLht+
 QuMxD+mOj3GXoxXGezd0vXkClIGLToCbKK7Atx2fe0aSPV+dZnhU+76nT3OQrEtbQD8h
 Dr/eppEe1EY7z+eHIlicmAOQbUtp/y+GO6omYi7BpWWuAvCmeUwHw7ItGbf9o/z8Ww4t
 tEdGoackJKCO6ejAI5PiyJIq9BtpaFmSWVVZayPlDIIzrGU7gNKzmqj7EldDyb775rc8
 oIaQ==
X-Gm-Message-State: AOJu0Yx1UyOLaI0ozMDRmk13Y3ELG55pxCXYJm4YpX85IcupOXDG4nx6
 b48uZ82sF0YLk3SC+SAfTzR3KGs9bFI9vb2za2Iq9BAx9dDYMk0x24tF09gi
X-Google-Smtp-Source: AGHT+IHSx8lHDKHfkRpK67RKBD3Wv66zu2Y7dPBIv1tlTN+7DgFq/7+A8foOuCTpG4aILi3eqv88Rg==
X-Received: by 2002:a05:690c:3811:b0:66a:d93b:3047 with SMTP id
 00721157ae682-67a072ba7dfmr81992627b3.25.1722216899357; 
 Sun, 28 Jul 2024 18:34:59 -0700 (PDT)
Received: from nubia. (162-228-215-203.lightspeed.tukrga.sbcglobal.net.
 [162.228.215.203]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-67566dd9275sm18646017b3.12.2024.07.28.18.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jul 2024 18:34:58 -0700 (PDT)
Message-ID: <66a6f1c2.050a0220.3c5865.7ac4@mx.google.com>
X-Google-Original-Message-ID: <ZqbxwTkKAgShAIIy@nubia.>
Date: Sun, 28 Jul 2024 21:34:57 -0400
From: "Derald D. Woods" <woods.technical@gmail.com>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 "Andrew F . Davis" <afd@ti.com>,
 Javier =?iso-8859-1?Q?Mart=EDnez?= Canillas <javier@dowhile0.org>,
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@denx.de>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Adam Ford <aford173@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 Thomas Weber <weber@corscience.de>, Enrico Leto <enrico.leto@siemens.com>,
 "Matwey V . Kornilov" <matwey.kornilov@gmail.com>,
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>
Subject: Re: [PATCH 00/12] omap configuration cleanups
References: <20240728202501.3204905-1-paulk@sys-base.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240728202501.3204905-1-paulk@sys-base.io>
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

On Sun, Jul 28, 2024 at 10:24:49PM +0200, Paul Kocialkowski wrote:
> Here is a bunch of configuration cleanups for OMAP boards, mostly
> unifying and moving common configuration from board-specific defconfigs
> to Kconfig definitions.
> 
> There's also a cleanup of the sniper (LG Optimus Black) defconfig,
> prior to migrating it to DM/DT in a future follow-up series.
> 
> Paul Kocialkowski (12):
>   omap3: Define common SPL text base in Kconfig instead of defconfigs
>   omap3: Define common init stack pointer address in Kconfig
>   am33xx: Unify init stack pointer address across boards
>   am33xx: Define common init stack pointer address in Kconfig
>   am43xx: Define common init stack pointer address in Kconfig
>   dra7xx: Unify init stack pointer address across boards
>   dra7xx: Define common init stack pointer address in Kconfig
>   omap3: Define maximum U-Boot size in Kconfig instead of defconfigs
>   omap3: Define maximum SPL size in Kconfig instead of defconfigs
>   omap3: Define DRAM banks number in Kconfig instead of defconfigs
>   dra7xx: Remove explicit DRAM banks number from defconfigs
>   omap3: sniper: Streamline defconfig
> 
>  Kconfig                                   |  7 +++++++
>  common/spl/Kconfig                        |  2 ++
>  configs/am335x_baltos_defconfig           |  2 --
>  configs/am335x_evm_defconfig              |  2 --
>  configs/am335x_evm_spiboot_defconfig      |  2 --
>  configs/am335x_guardian_defconfig         |  2 --
>  configs/am335x_hs_evm_defconfig           |  2 --
>  configs/am335x_hs_evm_uart_defconfig      |  2 --
>  configs/am335x_igep003x_defconfig         |  2 --
>  configs/am335x_pdu001_defconfig           |  2 --
>  configs/am335x_shc_defconfig              |  2 --
>  configs/am335x_shc_ict_defconfig          |  2 --
>  configs/am335x_shc_netboot_defconfig      |  2 --
>  configs/am335x_shc_sdboot_defconfig       |  2 --
>  configs/am335x_sl50_defconfig             |  2 --
>  configs/am3517_evm_defconfig              |  6 ------
>  configs/am43xx_evm_defconfig              |  2 --
>  configs/am43xx_evm_qspiboot_defconfig     |  2 --
>  configs/am43xx_evm_rtconly_defconfig      |  2 --
>  configs/am43xx_evm_usbhost_boot_defconfig |  2 --
>  configs/am43xx_hs_evm_defconfig           |  2 --
>  configs/am43xx_hs_evm_qspi_defconfig      |  2 --
>  configs/am57xx_evm_defconfig              |  3 ---
>  configs/am57xx_hs_evm_defconfig           |  3 ---
>  configs/am57xx_hs_evm_usb_defconfig       |  3 ---
>  configs/brppt1_mmc_defconfig              |  2 --
>  configs/brsmarc1_defconfig                |  2 --
>  configs/brxre1_defconfig                  |  2 --
>  configs/chiliboard_defconfig              |  2 --
>  configs/cm_t43_defconfig                  |  2 --
>  configs/devkit8000_defconfig              |  6 ------
>  configs/dra7xx_evm_defconfig              |  3 ---
>  configs/dra7xx_hs_evm_defconfig           |  3 ---
>  configs/dra7xx_hs_evm_usb_defconfig       |  3 ---
>  configs/draco-etamin_defconfig            |  2 --
>  configs/draco-rastaban_defconfig          |  2 --
>  configs/draco-thuban_defconfig            |  2 --
>  configs/igep00x0_defconfig                |  6 ------
>  configs/omap35_logic_defconfig            |  6 ------
>  configs/omap35_logic_somlv_defconfig      |  6 ------
>  configs/omap3_evm_defconfig               |  6 ------
>  configs/omap3_logic_defconfig             |  6 ------
>  configs/omap3_logic_somlv_defconfig       |  6 ------
>  configs/pcm051_rev3_defconfig             |  2 --
>  configs/phycore-am335x-r2-regor_defconfig |  2 --
>  configs/phycore-am335x-r2-wega_defconfig  |  2 --
>  configs/pxm2_defconfig                    |  2 --
>  configs/rut_defconfig                     |  2 --
>  configs/sniper_defconfig                  | 21 ++++-----------------
>  49 files changed, 13 insertions(+), 147 deletions(-)
> 
> -- 
> 2.45.2
> 

For "configs/omap3_evm_defconfig":

Tested-by: Derald D. Woods <woods.technical@gmail.com>

