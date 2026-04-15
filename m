Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595D8F43848
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 16:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BC7584255;
	Wed, 15 Apr 2026 18:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="DlxeRU1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37DC48423D; Wed, 15 Apr 2026 18:04:09 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86AF7842BF
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 18:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ad135063so68702795e9.0
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776269045; x=1776873845;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4M20qAupan8z/4SDxma9LpAKjOM73fhT5f4veP8pFnY=;
 b=DlxeRU1o34Z688EEVCJvVCBfTx0z33wRJ/Fqb0KebOT2K1Wn0hgbKMKtvkOPIRuMe1
 0z3OpIkxQ3n4dKRCgGaFo0OdOjFTN3Lylj5qTY0DyKvjYpCUQteklpIR/vgAUk2UvMmk
 tSV03PoZI316r31cB6aSX1Lm2/y+8sHTufKEgo4TtsEe3ddPTePWid8qliFHeR7iDGzl
 ORumNVQzKFiMBQieEOHrHte7RsyedB5mj+GTayYk5NRnrYBVZq4wcfYm0EoiqVrqOH5p
 DXgVSIqW0Xara+4TK7240gWVtZ2WZm3BOl7A1rhOje9158a7WY+tUibMPXrYOUyAfti0
 P3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776269045; x=1776873845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4M20qAupan8z/4SDxma9LpAKjOM73fhT5f4veP8pFnY=;
 b=sqqrqu7EHGB3kh2tSDqivAYOXjBtrFSp2iixTZ3qsTJKUuAqYMSlGOL+sr40W0m6/8
 Y2PwaehmF7HoKrTzgpq5TUk/gvMj0YzulwiMFNGwdL+D5ebOywXWn28/ouvwFXrs3zql
 haySZRnve3dNxKBnfm1tiJCzfuW/Tz5sYjt4mogq8UkdumadLxWEo08aJBLf6u/Cydsm
 b3zlBfQ1C277bHG49DHg+9N/cbkPkSeA6I611fyGzxtDiEAiXUsvcVOXCcdzWmIz6JT6
 7QB3YpJy/8/pimYKe6Wmjxag8BJmTbJZ9TbBjZYDIQ27DernWn7Ewj7744bBoTgE/9e3
 fiTQ==
X-Gm-Message-State: AOJu0YxQ53dYSSyrpC8bRoi80QxmxgJheo3yzt6vylFA1R9GnXNrJnhc
 MygvAaSWhSKZM+KAsq1qCATGNZ0Uvz5f3fEoTFZOhRNcTfpPyE4HrVCKj1ukDm7HkAM=
X-Gm-Gg: AeBDieum1+WOlKlNEnf8Z2KPCGr9i+rWiQfQvFAxyasLyphBC2FpbcHF9xUEod4S+mt
 iuXVs/ifQioVOlke9+FaNaqfVqwOBh04d8r13aNax9ph0yHjXNN3LjY4HjwFxrRuo/qzKT2xljN
 y6hmzordgHzNeLCMb3TAO4Jvj6YTMyZTi6s7sxKKRpQlY20WGATWpVsK+dJsv8pJZlK0DSdJMne
 zu0rOQczVyHDccjxvprT2d8atZTtxzPJATel5hk/Qm/UVddI6PcS7wDRy8JIh2HCCHe11iln4MB
 ThMVS+F1rYQrc5ZWgWqwhiuMtig9hQ8QwbOfCSkUeFB3XFEsm4yGAgAxsoV7ksd1+T7q8BlwQOT
 RqO48iLFuSVT8zZQExFNwpjXJ1foRNvcwfq3ESE8RoGeJayFZHuSddR2vMItvajATSdAOLpl3U3
 IVMethhb3oC9c/F37U2tiIN7dxLriFdJM=
X-Received: by 2002:a05:600c:3f0a:b0:488:afb5:6a21 with SMTP id
 5b1f17b1804b1-488d68764b0mr306712055e9.15.1776269044926; 
 Wed, 15 Apr 2026 09:04:04 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e05bsm232558145e9.6.2026.04.15.09.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:04:04 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Wed, 15 Apr 2026 18:02:34 +0200
Subject: [PATCH v6 13/14] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-topic-am33-evm-oftree-v2026-01-v6-13-94cde349bb01@baylibre.com>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
In-Reply-To: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
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
 Parth Pancholi <parth.pancholi@toradex.com>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4608; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/E7M2RrseHnPwGA230gS5byeoTqaswUn7KCX8cBGr/0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz7267erah+ZCl1YMnRby0XG5xYwm7/TVQ6tuLNvoVPu
 1aubtGa3lHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQATuRzFyDBj5i+LxQwnPHYy
 HvVe1lfGOce9v0b3aDlPs2bbycX57M6MDO8Mpu9tk7tdNzfii+hD/bpzNvsK43OWJ0/8dESlxv2
 xJQsA
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

The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
power domain driver is requierd as well now.

This switches all evm defconfig variants to use the upstream devicetree.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am335x_evm.config            | 6 +++++-
 configs/am335x_evm_defconfig         | 2 +-
 configs/am335x_evm_spiboot_defconfig | 2 +-
 configs/am335x_hs_evm.config         | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/configs/am335x_evm.config b/configs/am335x_evm.config
index 9c12771a3299bcd0b1c5c14bb4c2306d7b02aae5..fbc070c930e4d2d85739c9e428c4b130490cd6bc 100644
--- a/configs/am335x_evm.config
+++ b/configs/am335x_evm.config
@@ -3,7 +3,10 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am335x-evm"
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_AM33XX=y
 CONFIG_CLOCK_SYNTHESIZER=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
@@ -12,6 +15,7 @@ CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 448b0a8308fcca04732b81313c72f7fd2247d1ca..9281178f914085b199e3d35e95d0ce1f3c0faaa5 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -24,7 +24,7 @@ CONFIG_CMD_SPL_NAND_OFS=0x00080000
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-sancloud-bbe ti/omap/am335x-sancloud-bbe-lite ti/omap/am335x-sancloud-bbe-extended-wifi ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
 CONFIG_SPL_ENV_IS_NOWHERE=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index eebd916c02a2cad0d01ab738aab37b11dd3a9645..bbaca6c8800baf19377a457e49db446159e338a8 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -12,7 +12,7 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
diff --git a/configs/am335x_hs_evm.config b/configs/am335x_hs_evm.config
index 7ade2fb163b204ad8bcc9554455fdd3e81657890..0bc8556b1d4b18a413ecd6879ab85be54f2730ef 100644
--- a/configs/am335x_hs_evm.config
+++ b/configs/am335x_hs_evm.config
@@ -8,7 +8,7 @@ CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_RSA=y

-- 
2.53.0

