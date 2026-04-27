Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AABFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 12:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5217784353;
	Mon, 27 Apr 2026 14:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="QXYYPlev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E35E84119; Mon, 27 Apr 2026 11:03:37 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CD4839D9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 11:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so5808723f8f.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 02:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777280611; x=1777885411;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u7Bt06sqmtRI+zsie+UhNriEYgLp0d1gCsGoybXEu1w=;
 b=QXYYPlevs0T0lO+96mjaydjbQaeM8vlga3p4I7ghDDfuI9lACsxx0T08xqJUM8eOfy
 V0j84sAuRMwE86+iA5FlQA/JHL0rJSEmBTv/k8ktOv+2NgvEYBOa/h4IrA4IYJqeupjI
 w6qc+1ThkrpKzJm1ix6MNvrsviw/9sUMVxTrw7qr0LaDtwwxBcxsLdGWdW2QLNIb8D/Y
 kthubf/ZSHO2NDnh8DU4v91eI1WPheHhbZ35d5r18ZzUIhhqkLfnt4xDVTBImUJ4TMqX
 +/79cjNzvg9Z9nxzXVe0Ydi2L9aMVsL5GT7A14F9XBzRBX8WHXkJLaSG5mCMLBU8bIkF
 VklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777280611; x=1777885411;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u7Bt06sqmtRI+zsie+UhNriEYgLp0d1gCsGoybXEu1w=;
 b=NPRXCPG7QqKPq+C2KxY4f4KpbnclL49pnLh9gHgbXPVPUYbOK3lpKjJt0tqJYeO9zs
 vn4I5w7ww5Fogzy0f3B1/NxKmQA8pE6Wcbt7dJdYrzU+QRjIzdnd6Qlr+hTQw9jRwmVO
 4Jwy05XvzOOGA5+BOE4lfCyDKhh+0zoSRF0oOAJxoXzvxazvqwEiRpnrOBX2Eu/Ls79u
 iDv6eYnaWDk0sBS1Tr5UNHbLJM1m0cxc0YYVEPr6chXOUlUOealDsB/YHs+8kV9hlQmv
 iNujFSyDdO8/50mCaSMHq3HznF99Mc6XvAKv3l4URlqejoItLSUbQM0uFb3WxUg4/PVj
 mAzA==
X-Gm-Message-State: AOJu0YzqvYRQMw1Mrf0r9bf0UN1HpvCGBgbGZQzkGwx8xQIkivXXHaKM
 y+GyLKVxPxzW0OZf8x8bEXPtSonz9S6p1enE9xlNsIwgRB+XkQcJha57FXW7cUqTEKg=
X-Gm-Gg: AeBDietBwu15tl9v292I8lm49DAp8cdSnGU/xYm0cbZu6p/qs/4a2F+He2mOu2YY2bj
 ix/jBLeh3UJ3SYPWb4X0y7KV83LIOoHvWyx8S2IP3DPRkZ4OZkxTZ8Ud87fwsIUp3cfK4QXbmIB
 VUPJv1YZUUUlRToksANRe3OhxjrGMfFio1Pz2dsuZChxSDW44a+Ef/MwKy2fogYsN4BCTNyecSl
 IJAOV6WOKlEKvPoqkJ2SQtGvmemDcYSNxW7SnXwaOThp8GN9cQFAOQPUx9EujklKtQJ3N8lde47
 oZxXnjB1pz3o+dPm7W7PCJpi47JYSK7eRMjNft1LDH9Xm0heu99tpowSehHrsRo/zANumv9ONIl
 91QQA0pV1aUUs8etOJOcAMVuyOjXberXQkySAdJayg4m1x4RRtNwsKMhbqL4ggfHvZTgSwqOPf3
 +msXYdcagG7NyLf3R1uBLD/uqQISODPmQ=
X-Received: by 2002:a05:6000:1866:b0:43e:a69b:d7fd with SMTP id
 ffacd0b85a97d-43fe3e0c709mr59996816f8f.40.1777280610989; 
 Mon, 27 Apr 2026 02:03:30 -0700 (PDT)
Received: from localhost ([2001:4090:a246:83ca:1917:a47e:1872:2063])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a174sm85811368f8f.18.2026.04.27.02.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 02:03:30 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 27 Apr 2026 11:01:28 +0200
Subject: [PATCH v7 12/14] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-topic-am33-evm-oftree-v2026-01-v7-12-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
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
 Andre Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Ion Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4735; i=msp@baylibre.com;
 h=from:subject:message-id; bh=vw5pwhQR6lqESVBYKXl9TQv9EbF5sFMbqA1R4uWKNk4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhsz3aq5L5J2rnZQOyXt8D4rbkR5obt7ov+ut+QOdqdEXU
 m88EvfrKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIlkezH8Mz1nM3vJQdGZOWsE
 +9y7PdctKeu77vPH1FTnm5/1r5LuTkaG42Jlsr4NJ2p7FJdpnV9yxlvreF7QRy2xwmPHNFOnGce
 xAQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 27 Apr 2026 14:54:41 +0200
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

CONFIG_PHANDLE_CHECK_SEQ is now needed as many device nodes are now
named for example mmc@0.

This switches all evm defconfig variants to use the upstream devicetree.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 configs/am335x_evm.config            | 7 ++++++-
 configs/am335x_evm_defconfig         | 2 +-
 configs/am335x_evm_spiboot_defconfig | 2 +-
 configs/am335x_hs_evm.config         | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/configs/am335x_evm.config b/configs/am335x_evm.config
index 9c12771a3299bcd0b1c5c14bb4c2306d7b02aae5..7fcda5863a3ef68f7cca38e5b35376116129ed3d 100644
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
@@ -12,6 +15,8 @@ CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_PHANDLE_CHECK_SEQ=y
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

