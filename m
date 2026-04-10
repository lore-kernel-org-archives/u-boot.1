Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CF1F4485A
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 13:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A760E8419C;
	Fri, 10 Apr 2026 15:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Ksvn6S1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9572C84239; Fri, 10 Apr 2026 15:33:08 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA1C83DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so1990661f8f.3
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775827986; x=1776432786;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4M20qAupan8z/4SDxma9LpAKjOM73fhT5f4veP8pFnY=;
 b=Ksvn6S1arlOFAyHzLZu8ybhQG7iplFLsUQNrLGapLRkG+B5Ke6Y292gnlev4AH5ML9
 PM8ShgVNcrnakzaAad18vzPCczqyG9ANWoeHlleyy5Dg6a8KZth10Q6jkHuDOfOp/wf3
 sRXbxt6RJH1e2bLdUg/Ac/wLeehO05nFwTTBwpRgJgsL5Rkhjw2TUTd0PGz2oBW1r9J1
 ewq7kc0lV/4Ev4gsHyC+Xgv9Id/Xo0p38vyuOMDUw1hqJivizZO25Y0gM+hN7zXfrcOS
 5kX41zSHS8azMRbn7vzZUxBffU4nanVnGt0nwqT6b/lF4GbLP8dUPHA+s5WWWaBfcVSG
 L2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775827986; x=1776432786;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4M20qAupan8z/4SDxma9LpAKjOM73fhT5f4veP8pFnY=;
 b=hpcWkLhlJmt0UrdumewCC1QCFwnkOWJuAOpPyMtaU5RWyDfKPgPluRFH9bQAKD469G
 XFDKSso03IoqHFkerAxGi47DEnLF5MgKPStCEyHcsD0b/1B6Aa/tr0IuLT3zYlE9/y4y
 31TUwkQ3ulx0tbmaScfsQZUfJ+mnZN+A97llcBeLKEJpFwAEfLFGRXwkr3oQ62aXkFHF
 BzxducOypkSMqyfdmYkcU/6c0AzYIgiJrdK36z8wpvoqQ/M1tFegkL6wf7J0Wj5XyoX7
 O97IRfwdq+5SGWqYmbVKovHJSGbDmQPTza/7idpPMVJ9hkCPRY7FjsM+CxcMRtDmlfmV
 rv4A==
X-Gm-Message-State: AOJu0Yz9nSDnFW8GlpNk9v+9StvPbGz/A6xTUGKw/u8laVGUMsjJjWvl
 nTIOxVazX45FfW4c6gZX3pVTGhIzJzfXO53MLH5w6XXbS8lmsGLWROv61pJEs+w80PU=
X-Gm-Gg: AeBDiesnI5EPh2jZy8y+ftf7CfMrLxEJpCO1ZQnweVMrh99CLkCGWyR2z9Fea5zYxkn
 0T+NcmQGcy/s789XirRxK3cNoJZpD3tP7mXKh7g42DMoXaNQuLJmDPiznyX/eK3xifzBqHzDpCB
 kGk8fFf38KTcPAIERqdUIkVx26Uj8UVM/ZO+8BOVtOjQ5V19UgClCWAKoD3v0PaXD/+rC6/qaQ/
 /D01vWm+riQl43vUmdWnqhrIh8ghJoyzo9nej0/xax4inGd+G1Undor1P8oZSq35rZAW5Jkbl/t
 sQ+vnYg33LT7d+7GLQ8IjEewK048vmvmWxdOFPh62N9J5J5oZS1csJlbMLGS4H6Xc7FgNPVG/rt
 PFC6FE32Mdx29RLKUbZcBZ2w/fBKphnpYyE4wQnV+BbHti5zjWui68sC7ZMNvX5zuP8HJ79INDB
 JaS8exzCkp0FUSFpOYkTJH
X-Received: by 2002:a05:6000:178e:b0:43c:ff58:35d3 with SMTP id
 ffacd0b85a97d-43d6429b8acmr4851875f8f.17.1775827985757; 
 Fri, 10 Apr 2026 06:33:05 -0700 (PDT)
Received: from localhost ([2001:4091:a246:8598:4c79:7b44:ca74:c5de])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e469ddsm7474561f8f.17.2026.04.10.06.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:33:05 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Date: Fri, 10 Apr 2026 15:31:52 +0200
Subject: [PATCH v5 12/12] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-topic-am33-evm-oftree-v2026-01-v5-12-4b9c7aca0e3e@baylibre.com>
References: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
In-Reply-To: <20260410-topic-am33-evm-oftree-v2026-01-v5-0-4b9c7aca0e3e@baylibre.com>
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
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4608; i=msp@baylibre.com;
 h=from:subject:message-id; bh=/E7M2RrseHnPwGA230gS5byeoTqaswUn7KCX8cBGr/0=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhswbv//0NNXZSb9RVRdbwLkovrUu3oo73lq+8n2bbdnDy
 mJRvscdpSwMYlwMsmKKLJ2JoWn/5XceS160bDPMHFYmkCEMXJwCMBGeRQx/+ErnbeQVDHP7Jv19
 SpRk2zeb4we7VkSW3/R9m+useCE1mJHh8a8czyyrhdVbzjXNK9/+Tjm65N6/lYqSPoteVpzwmXi
 CFwA=
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

