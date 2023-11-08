Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BC1C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A31E8722B;
	Wed,  8 Nov 2023 16:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="YpP29szo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A38ED8743A; Wed,  8 Nov 2023 15:53:30 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E953E8749D
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202311081453262036f81373abeb18aa for <u-boot@lists.denx.de>;
 Wed, 08 Nov 2023 15:53:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=QuFF02dUZ8G3hkb7CarCl/0b6Eh+ixqqe+AiMuLJ5F4=;
 b=YpP29szo2PzlfplWEDUd42FjR3wUgL9tdbVUjSKdGu4MwMQ31Ytbr7bBjmf0PDYHmM3G9R
 4FRd0oHxtKVRC/ngaCPreVMSOqtIevzGbtXhy+8m03Uf8NfJIlsehS1wn8pU4KVjgij/qDfx
 Z0FivZBApRuhioMW5HaC/28Qrm5RE=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 4/6] configs: draco: remove unused resources from spl
Date: Wed,  8 Nov 2023 15:53:20 +0100
Message-Id: <20231108145322.302927-5-enrico.leto@siemens.com>
In-Reply-To: <20231108145322.302927-1-enrico.leto@siemens.com>
References: <20231108145322.302927-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
X-Mailman-Approved-At: Wed, 08 Nov 2023 16:10:16 +0100
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

We don't need device tree, GPIO & SPI in SPL.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 configs/draco-etamin_defconfig   | 4 ----
 configs/draco-rastaban_defconfig | 4 ----
 configs/draco-thuban_defconfig   | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index 3f9e91810ed..7814e125c29 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
@@ -10,7 +9,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x980000
-CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="am335x-draco"
 CONFIG_AM33XX=y
 CONFIG_SYS_MPUCLK=300
@@ -22,7 +20,6 @@ CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0xB80000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x81000000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_BOOTDELAY=3
@@ -72,7 +69,6 @@ CONFIG_MTDIDS_DEFAULT="nand2=omap2-nand_concat"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand_concat:512k(spl),512k(spl.backup1),512k(spl.backup2),512k(spl.backup3),7680k(u-boot),2048k(u-boot.env0),2048k(u-boot.env1),2048k(mtdoops),-(rootfs)"
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 218177b6d97..2460182b12c 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -2,14 +2,12 @@ CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x2000
-CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="am335x-draco"
 CONFIG_AM33XX=y
 CONFIG_SYS_MPUCLK=300
@@ -20,7 +18,6 @@ CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x2E0000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x81000000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_BOOTDELAY=3
@@ -70,7 +67,6 @@ CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:128k(spl),128k(spl.backup1),128k(spl.backup2),128k(spl.backup3),1920k(u-boot),512k(u-boot.env0),512k(u-boot.env1),300m(rootfs),512k(mtdoops),-(configuration)"
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index 80841135229..766b1596a17 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -2,14 +2,12 @@ CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TEXT_BASE=0x80100000
 CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
 CONFIG_ENV_SIZE=0x2000
-CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="am335x-draco"
 CONFIG_AM33XX=y
 CONFIG_SYS_MPUCLK=300
@@ -20,7 +18,6 @@ CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x2E0000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x81000000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_BOOTDELAY=3
@@ -70,7 +67,6 @@ CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:128k(spl),128k(spl.backup1),128k(spl.backup2),128k(spl.backup3),1920k(u-boot),512k(u-boot.env0),512k(u-boot.env1),512k(mtdoops),-(rootfs)"
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-- 
2.30.2

