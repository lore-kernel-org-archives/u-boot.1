Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B0CCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 13:18:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CFFB8323A;
	Wed, 22 Oct 2025 15:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JtnnX2Td";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vO3P3BXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12B6832BC; Wed, 22 Oct 2025 15:18:22 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3045982B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 15:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cs8qb63Zgz9tQp;
 Wed, 22 Oct 2025 15:18:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761139099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FcSZRm2InC94DyyupsRv1TIGj/OZbpaYq4sF916EmA8=;
 b=JtnnX2Td3/HmJfC94BBLMgrgyMq0ebyl0tz3+Up3xDWqhZbdsU7uKJCTrMON8tvdr2SBti
 JcPAre+gjGPLytO/YPcM74wBjJzu1Inmpl11xMwMiIN0JzswHMvgmX3Iop5zGSGaaaEspz
 8VEZ4l0qbAnkktE6lhqtMUsvDM3bkomtAs+AnyyHqI64mAHhhu1HxeLg6fFhVxlSEqRmk8
 JlcBSME2M4CeVxSuib3nbOFyCVhyzYPMFr0O6ink0R2CARr3/k6qMvw7oc+IiPyiyOlcHr
 39y1fh7HGiaz+Yl83kKiW9hZ6DHyxdOjZl77/hi9FtpgM+lQ4bEffC11oELHTQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=vO3P3BXb;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761139097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=FcSZRm2InC94DyyupsRv1TIGj/OZbpaYq4sF916EmA8=;
 b=vO3P3BXbH4JUl289gET7QkqtpC1TqEGvRMPStzkqbhCpRMsc7dOX0M1au2Nc5q42IIrYCj
 ZkwadL73VTrsGXfSKBgBB3XdjjZJOpO0Ai8qVRb+BL6qUk5uPNF8RqF/PKREbVDcoUudII
 oDcpyNpPkGoC4KMxr8hSEs41RoXvig6etQ9WgThqwxfuWt1iolkrHXeBCdInUdtskYRMrK
 p2i/PFGmEJksk8uC3pavZ44ER6NdaOitebTBDtEyjyhoE0h++BPyOzCNHxGRKW56rJtcA/
 qmLs4nKceexfhzLVh6tfS5nzUvRkE8M3Q9zWZDOMR7gxOaItGJ4wa+F73UeBPg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: renesas: Clean up default boot command
Date: Wed, 22 Oct 2025 15:17:16 +0200
Message-ID: <20251022131759.177233-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hef8gfhoxjf96e8h8z61b3i8wdobhab1
X-MBO-RS-ID: dda28ff44c6986a8eba
X-Rspamd-Queue-Id: 4cs8qb63Zgz9tQp
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

The current default boot command does not respect the Linux kernel 2 MiB
alignment requirement, present on aarch64 [1]:

"
The Image must be placed text_offset bytes from a 2MB aligned base
address anywhere in usable system RAM and called there.
"

Adjust the boot command such, that it always places both Image and DT at
the nearest highest 2 MiB aligned offset. The DT is placed at lower 2 MiB
aligned address, the aarch64 Image is placed at the next higher 2 MiB
aligned address. Is is unlikely that a DT would be larger than 2 MiB on
these systems.

Replace use of hard-coded load addresses with generic ${loadaddr} aligned
using setexpr. This way, if user picks valid ${loadaddr}, their kernel and
DT address will be correctly set as well.

Fix up boot commands to use && instead of ; to exit the boot command early
in case of failure.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/arch/arm64/booting.rst#n138

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 configs/hihope_rzg2_defconfig        | 2 +-
 configs/r8a77970_eagle_defconfig     | 2 +-
 configs/r8a77980_condor_defconfig    | 2 +-
 configs/r8a77990_ebisu_defconfig     | 2 +-
 configs/r8a77995_draak_defconfig     | 2 +-
 configs/r8a779a0_falcon_defconfig    | 2 +-
 configs/r8a779f0_spider_defconfig    | 2 +-
 configs/r8a779f4_s4sk_defconfig      | 2 +-
 configs/r8a779g0_whitehawk_defconfig | 2 +-
 configs/r8a779h0_grayhawk_defconfig  | 2 +-
 configs/rcar3_salvator-x_defconfig   | 2 +-
 configs/rcar3_ulcb_defconfig         | 2 +-
 configs/silinux_ek874_defconfig      | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index 19fb14887c6..5ef91e3df7e 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -12,7 +12,7 @@ CONFIG_TARGET_HIHOPE_RZG2=y
 # CONFIG_SPL is not set
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a774a1-hihope-rzg2m-ex.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a774a1-hihope-rzg2m-ex.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a774a1-hihope-rzg2m-ex.dtb"
 # CONFIG_BOARD_EARLY_INIT_F is not set
 CONFIG_CMD_MMC=y
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 3734836fa61..72e5dd5536c 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -20,7 +20,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 # CONFIG_EFI_LOADER is not set
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77970-eagle.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a77970-eagle.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a77970-eagle.dtb"
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_CMD_DFU=y
diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_defconfig
index 3ebb1e73284..5c7797c4373 100644
--- a/configs/r8a77980_condor_defconfig
+++ b/configs/r8a77980_condor_defconfig
@@ -19,7 +19,7 @@ CONFIG_SPL_BSS_START_ADDR=0xe631f000
 CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77980-condor.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a77980-condor.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a77980-condor.dtb"
 # CONFIG_BOARD_EARLY_INIT_F is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 7405f207612..bd2093653a2 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -19,7 +19,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77990-ebisu.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a77990-ebisu.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a77990-ebisu.dtb"
 # CONFIG_BOARD_EARLY_INIT_F is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index 2d487722677..ef2fe782936 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -19,7 +19,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77995-draak.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a77995-draak.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a77995-draak.dtb"
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=10
diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index 1b99ba1f02b..6e61cd87352 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -11,7 +11,7 @@ CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779a0-falcon"
 CONFIG_TARGET_FALCON=y
 CONFIG_SYS_CLK_FREQ=16666666
 CONFIG_ARMV8_PSCI=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a779a0-falcon.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a779a0-falcon.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a779a0-falcon.dtb"
 CONFIG_SYS_PBSIZE=2068
 CONFIG_ENV_IS_IN_SPI_FLASH=y
diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_defconfig
index 6b16ff55480..e3ee4d4bd99 100644
--- a/configs/r8a779f0_spider_defconfig
+++ b/configs/r8a779f0_spider_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_SPIDER=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779f0-spider"
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779f0-spider.dtb && booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a779f0-spider.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a779f0-spider.dtb"
 CONFIG_BAUDRATE=1843200
 CONFIG_DM_PCA953X=y
diff --git a/configs/r8a779f4_s4sk_defconfig b/configs/r8a779f4_s4sk_defconfig
index 1b353492d04..94ec079b47f 100644
--- a/configs/r8a779f4_s4sk_defconfig
+++ b/configs/r8a779f4_s4sk_defconfig
@@ -5,7 +5,7 @@ CONFIG_ARCH_RENESAS=y
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_S4SK=y
 CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779f4-s4sk"
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779f4-s4sk.dtb && booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a779f4-s4sk.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a779f4-s4sk.dtb"
 CONFIG_BAUDRATE=921600
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index 41217fa5776..c0e8620b2f7 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -13,7 +13,7 @@ CONFIG_SYS_CLK_FREQ=16666666
 CONFIG_SYS_BOOT_GET_CMDLINE=y
 CONFIG_SYS_BARGSIZE=2048
 CONFIG_BINMAN=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779g0-white-hawk.dtb && booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a779g0-white-hawk.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a779g0-white-hawk.dtb"
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_REMOTEPROC_RENESAS_APMU=y
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index 33009429315..2a3f25a12be 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -10,7 +10,7 @@ CONFIG_TARGET_GRAYHAWK=y
 CONFIG_SYS_CLK_FREQ=16666666
 CONFIG_SYS_BOOT_GET_CMDLINE=y
 CONFIG_SYS_BARGSIZE=2048
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779h0-gray-hawk.dtb && booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a779h0-gray-hawk.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a779h0-gray-hawk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_ENV_IS_IN_MMC=y
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 15ec0a45901..7adaf665a35 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -21,7 +21,7 @@ CONFIG_SYS_MONITOR_BASE=0x00000000
 # CONFIG_BOOTSTD is not set
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77951-salvator-x.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a77951-salvator-x.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a77951-salvator-x.dtb"
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=10
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index 41bdee19682..f3e2112a91e 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -19,7 +19,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_SYS_MONITOR_BASE=0x00000000
 CONFIG_USE_BOOTARGS=y
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a77951-ulcb.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a77951-ulcb.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a77951-ulcb.dtb"
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=10
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index af462d2086f..485e6067d10 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -20,7 +20,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x1000
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/nfs rw nfsroot=192.168.0.1:/export/rfs ip=192.168.0.20"
 CONFIG_USE_BOOTCOMMAND=y
-CONFIG_BOOTCOMMAND="tftp 0x48080000 Image; tftp 0x48000000 Image-r8a774c0-ek874.dtb; booti 0x48080000 - 0x48000000"
+CONFIG_BOOTCOMMAND="setexpr dloadaddr ${loadaddr} + 0x200000 && setexpr dloadaddr ${dloadaddr} \\\\& 0xffc00000 && setexpr kloadaddr ${dloadaddr} + 0x200000 && tftp ${dloadaddr} Image-r8a774c0-ek874.dtb && tftp ${kloadaddr} Image && booti ${kloadaddr} - ${dloadaddr}"
 CONFIG_DEFAULT_FDT_FILE="r8a774c0-ek874.dtb"
 # CONFIG_BOARD_EARLY_INIT_F is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.51.0

