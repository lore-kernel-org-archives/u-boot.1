Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C373CD3436
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBFB08491D;
	Wed,  6 May 2026 14:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CD/2igTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC1E848A1; Wed,  6 May 2026 14:36:35 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A1D38484F
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D27C40178;
 Wed,  6 May 2026 12:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57407C2BCB8;
 Wed,  6 May 2026 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070992;
 bh=HCxlvubW8qImPlN/lrwZO016CxYfR8p+V/Y/jX14PWM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CD/2igTZl45kSuGs9+CjlaV9jXCdqAYUiaPzT7iFaMoI330W4mI7au2zbTSO3z/H5
 nCdsoqHvuMGDk4iihaSDeLfOXm/ck1wtuqWGPZsCE+oCULKXjLv5TQuhHxHCVt8TVK
 GjNi0mThkRT6ekJXuqCA5Pu4ZeFi1xXNJwIPuXPEKAlE5DRb9+d7Cc9L0j7ZhJ8fNm
 /p0PLchWXqh8s1dZbl58WQ2h/JSaT4oAnB/v3CkJ8bRmWKhg7XrbkknBId7WT1fU+3
 25bHr8eYRYHeOnY1O+rDIdkNHamJ10RZkfG0RoWr5sWHS9reQK+8UrDjIGS+8aEoou
 lZhNEVd2TeHog==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 08/11] p2041rdb: support SDcard boot
Date: Wed,  6 May 2026 14:34:17 +0200
Message-ID: <20260506123507.2081751-9-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506123507.2081751-1-mwalle@kernel.org>
References: <20260506123507.2081751-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The RCW was just supporting SPI boot. Add a second one for the SDcard
boot. While at it, use the same naming scheme as for the other NXP
boards.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg                | 11 +++++++++++
 .../{rcw_p2041rdb.cfg => p2041rdb_rcw_spi.cfg}        |  0
 configs/P2041RDB_SDCARD_defconfig                     |  6 ++++--
 configs/P2041RDB_SPIFLASH_defconfig                   |  2 +-
 4 files changed, 16 insertions(+), 3 deletions(-)
 create mode 100644 board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg
 rename board/nxp/p2041rdb/{rcw_p2041rdb.cfg => p2041rdb_rcw_spi.cfg} (100%)

diff --git a/board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg b/board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg
new file mode 100644
index 00000000000..f22f3335e73
--- /dev/null
+++ b/board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg
@@ -0,0 +1,11 @@
+#
+# Default RCW for P2041RDB.
+#
+
+#PBL preamble and RCW header
+aa55aa55 010e0100
+#64 bytes RCW data
+12600000 00000000 241C0000 00000000
+649FA0C1 C3C02000 68000000 40000000
+00000000 00000000 00000000 D0030F07
+00000000 00000000 00000000 00000000
diff --git a/board/nxp/p2041rdb/rcw_p2041rdb.cfg b/board/nxp/p2041rdb/p2041rdb_rcw_spi.cfg
similarity index 100%
rename from board/nxp/p2041rdb/rcw_p2041rdb.cfg
rename to board/nxp/p2041rdb/p2041rdb_rcw_spi.cfg
diff --git a/configs/P2041RDB_SDCARD_defconfig b/configs/P2041RDB_SDCARD_defconfig
index ad04e2a1172..88695e1cabe 100644
--- a/configs/P2041RDB_SDCARD_defconfig
+++ b/configs/P2041RDB_SDCARD_defconfig
@@ -1,10 +1,11 @@
 CONFIG_PPC=y
 CONFIG_TEXT_BASE=0xFFF40000
 CONFIG_SYS_MALLOC_LEN=0x100000
+CONFIG_SYS_MALLOC_F_LEN=0x600
 CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0xCF400
-CONFIG_DEFAULT_DEVICE_TREE="p2041rdb"
+CONFIG_DEFAULT_DEVICE_TREE="fsl/p2041rdb"
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_MPC85xx=y
 CONFIG_SYS_INIT_RAM_LOCK=y
@@ -28,7 +29,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SYS_FSL_PBL_PBI="board/nxp/p2041rdb/pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/nxp/p2041rdb/rcw_p2041rdb.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/p2041rdb/p2041rdb_rcw_sd.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
@@ -54,6 +55,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
diff --git a/configs/P2041RDB_SPIFLASH_defconfig b/configs/P2041RDB_SPIFLASH_defconfig
index 465b3ee7dc7..fc187eb311c 100644
--- a/configs/P2041RDB_SPIFLASH_defconfig
+++ b/configs/P2041RDB_SPIFLASH_defconfig
@@ -31,7 +31,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_RAMBOOT_PBL=y
 CONFIG_SPIFLASH=y
 CONFIG_SYS_FSL_PBL_PBI="board/nxp/p2041rdb/pbi.cfg"
-CONFIG_SYS_FSL_PBL_RCW="board/nxp/p2041rdb/rcw_p2041rdb.cfg"
+CONFIG_SYS_FSL_PBL_RCW="board/nxp/p2041rdb/p2041rdb_rcw_spi.cfg"
 CONFIG_BOOTDELAY=10
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-- 
2.47.3

