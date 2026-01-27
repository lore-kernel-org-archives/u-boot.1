Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F992D340BC
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9655A84166;
	Tue, 27 Jan 2026 17:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UxGLCdrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BFE784164; Tue, 27 Jan 2026 17:51:11 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A339484148
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48049955f7fso51752685e9.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769532669; x=1770137469;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0LhVisA/dAqNh6vCizgqrXButgnprtcOeAMx1SA0mg0=;
 b=UxGLCdrW7Bt7tV4gayiPp3Uxkl3yZ3ILSgOkcq8C0oC7HOnXjc0Tw1OfvQgTND1sWG
 DTEYqod6IIT597ED6mG2xH1KzrG+xgsmZj9F+YR/ssIqDnVbrkinArMqdHVkys6Yw+gU
 Vbq2suu++A83Grw+a5bidKF1yrr1qkdZ9ELV9cb/fh4QijEDkDa8PXKSe+ni5DrR5obI
 I/BSrt5gUbHRmaDGMlzCESDJU6rnAvyCbydogJ9pqS7AU1KNuadyaaFbTsJ05a1AClTv
 D6w2U2cILySOqQfgWhbLofjcK7Bu9mjbmL9fLmaWhLz75ShYFJaVBjdP+Dcn7T2PhriD
 nVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769532669; x=1770137469;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0LhVisA/dAqNh6vCizgqrXButgnprtcOeAMx1SA0mg0=;
 b=d2ShJtGKavcpOqfRc3J7qqGanSVg0XoL3eB6sPasvIJukVy35Bgji93IsC7iV2PLRL
 yAzLCjfUJEWX01HhFtQxq5pFj6mo61F1UrUE1frInerwL2yrbDL9X3nOwtF8MBzZoKJh
 PN0vNc8PUPwuRzume0nFr0lspPSYpCnzX0wXpbQkvVN58Ys1rD79oWaYfa+0iQXrkKoA
 FS/UpjEnyCdH5c0zNqbOiIl8LtyH+Qp/lEj0Gz3YnGE3x7bmCPSPBNUzrLEYZKGVuZ43
 /WAPGD8nOMbPgb8q6iyL/jtJylBfhDf5Kw/18SEzV1pL5NiZMua2mxU1pfR9uvSzDW0b
 l88g==
X-Gm-Message-State: AOJu0Ywikcrr7mG2HLR9DIaIZjtYXTupduTSZv0V/+9eEptiGuWhdNSm
 Bu2ZMDSLi5U4ND9WVO+C9WG4A59WmnF11WkRWNvaLYveb17mhd4UThz7BHqzAMIgEOf2sPiya/3
 Qb+DW
X-Gm-Gg: AZuq6aLMgCMtIA0VF3EJY8YsqY6dnoG4CwUjw75TS4OkWAmjbv7eBnjV6DULUvp/hog
 mAUv43zQhcpWu0+/Bd2ssHPgSd2+fTeuPeThMo586h5lg6RS3owDwlxpcLmhLRZwq9WBSY7ZzJ5
 hlj+PklVsdpxkAGuqAECHyd+MawGlVh5mlD9L1RoP2RS5YzcLSNptG+SwmjBHjGbpslgM/LqI6z
 LopgNfkcSQJYnQamqQkCZQhIN6gCRqOHLiGJd1GV9gKOFnXTk7WbYSWq1TmhN3ZMtkaFWDCGSWe
 l+Y2nGgH7VV01MMPlyFrOsr7djQKo5okmZWaIeSh7B+O+GX++YdMGDUKiTwz1/ZeZ2nE6RNFHSN
 dBEfCOE5f/To2NBHh78/0pi9dcjVviHaorYv2vFR50SSlXU1j6wmLYZAr7Uz4hI0ECCOwmPzOe8
 KwJISAdSaWyQoeZquMRYk=
X-Received: by 2002:a05:600c:4689:b0:47e:e7e5:ff32 with SMTP id
 5b1f17b1804b1-48069c6077fmr27400705e9.34.1769532669023; 
 Tue, 27 Jan 2026 08:51:09 -0800 (PST)
Received: from localhost ([2001:4090:a244:872b:a354:65f3:92a0:8de7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7404sm77182365e9.1.2026.01.27.08.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:51:08 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 27 Jan 2026 17:48:16 +0100
Subject: [PATCH v4 02/10] configs: am335x_evm_defconfig: Enable panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-topic-am33-evm-oftree-v2026-01-v4-2-0dadb0710ce7@baylibre.com>
References: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
In-Reply-To: <20260127-topic-am33-evm-oftree-v2026-01-v4-0-0dadb0710ce7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752; i=msp@baylibre.com;
 h=from:subject:message-id; bh=V6x6lZUshJD0VlFKXCJ9evMg4jEnIt2esn6+FimOrZo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsyKN1u/R8xi71pW5FSyl+/YbZv7NzeFbJm1fWZ81tJvh
 e+cuvWVOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAi3CmMDLfmpL99pj7Nkkuo
 etV1gYjayrigyKUB52V+5cmEL7mlvYeR4Y2o9Cnbm/d5bgQEbI3/saDuyLH/296wKC3pk/x09Me
 LmYwA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

Enable LCD panel support on am335x-evm:
 - CLK_CCF and CLK_TI_* for display clock tree
 - DM_PWM and PWM_TI_ECAP for backlight control
 - VIDEO and AM335X_LCD for display controller

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 5a3e0530a31663faf565e0afeede5765be16985b..bd188c252780fb541afbbe61a243bddaab79be93 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -60,8 +60,14 @@ CONFIG_NET_RETRY_COUNT=10
 CONFIG_BOOTP_SEND_HOSTNAME=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_SYS_BOOTCOUNT_BE=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
 CONFIG_CLK_CDCE9XX=y
+CONFIG_CLK_TI_AM3_DPLL=y
 CONFIG_CLK_TI_CTRL=y
+CONFIG_CLK_TI_DIVIDER=y
+CONFIG_CLK_TI_GATE=y
+CONFIG_CLK_TI_MUX=y
 CONFIG_DFU_TFTP=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_NAND=y
@@ -71,6 +77,7 @@ CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=1
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_DM_I2C=y
+CONFIG_MISC=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
 # CONFIG_MMC_HW_PARTITIONING is not set
 CONFIG_MMC_OMAP_HS=y
@@ -95,6 +102,8 @@ CONFIG_DM_PMIC=y
 # CONFIG_SPL_DM_PMIC is not set
 CONFIG_PMIC_TPS65217=y
 CONFIG_SPL_POWER_TPS65910=y
+CONFIG_DM_PWM=y
+CONFIG_PWM_TI_ECAP=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_OMAP3_SPI=y
@@ -113,6 +122,8 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0xd022
 CONFIG_USB_ETHER=y
 CONFIG_SPL_USB_ETHER=y
+CONFIG_VIDEO=y
+CONFIG_AM335X_LCD=y
 CONFIG_WDT=y
 # CONFIG_SPL_WDT is not set
 CONFIG_DYNAMIC_CRC_TABLE=y

-- 
2.51.0

