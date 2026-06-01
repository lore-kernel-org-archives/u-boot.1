Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E030CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 12:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E28884A12;
	Mon,  1 Jun 2026 14:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="WuhOqZrr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D227A846A3; Mon,  1 Jun 2026 11:32:38 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45A684837
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 11:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so1493285f8f.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1780306356; x=1780911156; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u7Bt06sqmtRI+zsie+UhNriEYgLp0d1gCsGoybXEu1w=;
 b=WuhOqZrrb8/PhNZSPCyUzwFjLMzWcs74wwoOvTN4TOwtr/hSMBC6vHBF/rPJOce+vl
 sFlt+MZEYiZ6KYB9hISI8AuMw21/Nr4pFxd9BhvdH0pCOYLIf9dyu3E+AXhStSHbWp6F
 1jW7LWcxWcwbOiK7Fb8217aZspkbUNo2brRy7mjJe4giKOexvbkmFOzgGhJY4Pqp0qRJ
 BSGJnJ5wSz2DNqcG0J6SHdzWIXFRbtmF+S0MSjIgxdQdl2JbZVoopJ+h+bUN+qLVUPGj
 hpIQnwBib3zsd1FaTEkMO3qqOa2WhtnxhUjq8847cRR7ZIBPJr73VMsQnmsPkqdkW+lo
 ldfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780306356; x=1780911156;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=u7Bt06sqmtRI+zsie+UhNriEYgLp0d1gCsGoybXEu1w=;
 b=lXaV2p8p9kzuwNnW85Lb9RtN7IMZapcLnZjX7Gl3qOeEtruhMOFRfJeRnKHolBLSMi
 Fc9Zt2N/KB0ugy6A+0HwrxOnA1OQJ8eeLjZrK+yNTMJ22qarnpaRTh6oyLr7IhdswNqD
 hkK+BI/wYGGXUr4R7RHdpuvdmeazKr9YWWanrCL97uhTpJmL9FSvq+fzwCpcTtVcJSgJ
 EuRddjTxi7pP9nGc+hbTuk5lSOAWdTtWveJS5InUOhAgZxE+Wa5L1ofbY3KpnEMZLHlE
 7up7PgHytqv1fa7SaNP5WvgeZpLkZU5YYN+sqCDHXYpm97+Y2aLUzLmzamEonlLeQ4pA
 HjCg==
X-Gm-Message-State: AOJu0YyAjA2X+x1WnJO+DNiDyPlBSs3VUmYVHkhe3l05h//xFFsiRrxw
 zzl6jCz/Xq9pTWbHQVmtRxQ59ff1yduY0FRx01bkOjLuTbx5mOHVr/HySBEjMnoJAg8=
X-Gm-Gg: Acq92OFOM1QSupjdKy7DIgqFKlN7pDgxh/DSTXaIij2PDYd3ZcxQTI2CJnVaiBtTVQD
 Wfd4nNwFGuwpOzVmOCKvoKXEDEEUXEy/SN+ypf2uyE5rXrvR5LmVd8ZoJwgPzOyjAmb3dEjLect
 eGUjdZppOZt2NALuLv31GIVPzx1pxgyIuIIIqDDnGSmpDil+sC6QH9aUmI1u+B0TKXhV8AJkkRf
 mx0CJd0eLPSD5gqAoQfR4w1gU5gF8vo8/molM+l116/ubEMc5LQGVQ6pwQrgwm0ccLVv8RV2ZGB
 J/86jCx7wZLF4eYInhuiaJ7cVF9wX0pM6GJVejWAEwIdNzk+6iF3Ua7rg7iuQgVd5060DrYg3Wu
 8oI3wGXcowoehNgL2dx2ojckJN2BKSD5oDPBhA68u9UJSIihxqbuZ+VufRPqY2Mic/GIWIpMabL
 hSraxGMhHTWqdwEQE2QjqV4fQlu0cfZZE=
X-Received: by 2002:adf:ff89:0:b0:441:2aee:d561 with SMTP id
 ffacd0b85a97d-45ef6b5f8e3mr12690402f8f.28.1780306356142; 
 Mon, 01 Jun 2026 02:32:36 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8595:a745:3210:d732:4094])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef358c07bsm24758880f8f.36.2026.06.01.02.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 02:32:35 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Mon, 01 Jun 2026 11:30:47 +0200
Subject: [PATCH v8 12/17] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-topic-am33-evm-oftree-v2026-01-v8-12-2c33c98e7ce5@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4735; i=msp@baylibre.com;
 h=from:subject:message-id; bh=vw5pwhQR6lqESVBYKXl9TQv9EbF5sFMbqA1R4uWKNk4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhizZwLrX5567pvzLME1oWLDv1+bal0J3zBd/2JgiOj+Vi
 e3PmTmiHaUsDGJcDLJiiiydiaFp/+V3HktetGwzzBxWJpAhDFycAjCR+kJGhvfij+rXaMY7swip
 K30OjolYt6nzwfLgQA677fKtOWoWGQz/1P6V3p2y6Puu7j3lWxkzzkVs5vhn/enP6n0/3Js2L5q
 lwAYA
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

