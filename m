Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D79CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40018849CA;
	Mon,  1 Jun 2026 14:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="W6dgMHnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314F984851; Mon,  1 Jun 2026 11:32:25 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BFE784852
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so27512015e9.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306342; x=1780911142; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S84NuKwxlzuwrKnv+jAv6cYm1/svGOBXcu1bZ4s0JAU=;
 b=W6dgMHnSP8K86YCvy67Y8i+scykeVE6pOtlz1YhHk9+n7orHSjdMJ1CeU8j/66UtdE
 kMmCStV+6ATvjHKowyOQBcprI4W/STeDkWPYyOvUHkLYxRpsg4w0N+Um5aGVCfxYn8Vo
 81T+JbjXogUvDcyVMyjnmQYLFtZgEtrsJ9i/uSq6KonH6l4Eq52f8HkCnANlOkvafMu1
 iDeAk47jvs8VAc1qtND//+J96NebnwPbIhVH42qNW5ZSvlH0/e9bsmkBYaLbQFdyppkQ
 aoxU6FD6YcjB8Ewk5o1UF5xU6UkVSxuViRW+IiRzEVv7Wl9F8jUhOD+FLEaB+/KlHlDn
 N+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306342; x=1780911142;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S84NuKwxlzuwrKnv+jAv6cYm1/svGOBXcu1bZ4s0JAU=;
 b=G0WsNWVVqd7KlG8/a3po9/ebq9tp3f+TUTnRTxJcTWCDJbiWPeCniROfPLlma6uGOO
 r1F9RwmIIFqPyefOZnHmQkv9ppbs2Pssjk4jQN5j0W3/908GX3bt43lfrcXqHCre4Dle
 EkAxY8xjcDfSy4bmodRzYBV95uAe3n9BYaHYaZGmj4aB/WYeCe4QDa0ZhmKnUrEgNnv+
 ZjOdfFT9wsi5IsQPFuzjHTpdH0wa7jRrexolMxTrWj9W95CRl4q33EoBZvLTWDOxMf7L
 6bsCyrLdrns9A0qd1hKyvJWFm0H4waJsBMKNiiKNv4Sr9SVBJDDY7BqrN9qinmudx3Uc
 tIIQ==
X-Gm-Message-State: AOJu0Yx3Feyfoo46rTWIm3oPlgKxqRNQqg+o8tv4qzqVrlPXMtHHpe+1
 4RmGshzik+Zyz4bY7ZEsBAYK4RzbUKrUtVx732QalRVw0pi4+RQ40LyB9njLOxERw30=
X-Gm-Gg: Acq92OHPha3LebCgluo48otzbph53Ct9a7CyusL9RKZjHRLS85JCH6dqF97KgWv65YA
 5mJnIoLHXleELUOofK2fJVA9mrNw0SFop2XfBoJ8uptXeAmwaCL8TGgsZesbSt+Dmb4+SzIiY/P
 nc64P6NiqW6zO1REsHwaL4UJGeYvH6otRKdON0+RYKufMFK8n9joMXo9X1j0bDD65Z0U7tIZtRh
 VzYNYJkOEqzlVVgcuyeLx1ERqn5w91PvPY10JWSqBJsqIZbR8niHsB56LptmPll5k7sFVn0B8VG
 Ppp+tdgCI8YJe2ZeUN+qgtD+c9DwVLVlcaUcqCMUUeHG44ERIUBMalwY0d2kG9nHtsAIshhQ/1o
 auIrE0TojAigocfHX1TQl0in1uixth9c6A3nrFf4n4WBhZwDW7KmaG0XYX8/ELxGu6MjZxYMoJw
 o/ENlNy29G0u4LgMs4GKssVmdFsi53j7c=
X-Received: by 2002:a05:600d:844e:20b0:490:9df1:f0cf with SMTP id
 5b1f17b1804b1-490a290cdb7mr134395375e9.2.1780306342430; 
 Mon, 01 Jun 2026 02:32:22 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cab0e79sm413556525e9.13.2026.06.01.02.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:22 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:37 +0200
Subject: [PATCH v8 02/17] configs: am335x_evm_defconfig: Enable panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-2-2c33c98e7ce5@baylibre.com>
References: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
In-Reply-To: <20260601-topic-am33-evm-oftree-v2026-01-v8-0-2c33c98e7ce5@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Johan Jonker <jbx6244@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Hai Pham <hai.pham.ud@renesas.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 David Lechner <dlechner@baylibre.com>, Janne Grunau <j@jannau.net>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=msp@baylibre.com;
 h=from:subject:message-id; bh=8Rxd9W0y4tIK833OyvOG/0CqTD9kFb8Wv8+htaGG6sc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZQC8Xy7WX7zp4qe5p+3ibUelf+4dIsU1urVG15XdcH
 jidXubWUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABP5eoyRYbnHlaj25VxL7luu
 jlk0NfV+c233b7ee96VBt3btnmRv5cbIcGO9cEHkta17V0y9lmVU6W28RW3ltNU268wn3HrVPNe
 Bkx0A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 01 Jun 2026 14:07:04 +0200
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
Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am335x_evm_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 24c947ad1b98c32deb2801e241d949576a180cb2..f12847b6bacf65ccf6445840e41229dea78edfab 100644
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
2.53.0

