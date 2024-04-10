Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C8ECD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 18:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BAC87EEB;
	Wed, 10 Apr 2024 20:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="muW2Xwgj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B64518819D; Wed, 10 Apr 2024 20:20:23 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D91870AB
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 20:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AIKHw5111922;
 Wed, 10 Apr 2024 13:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712773217;
 bh=Mt+9hn3LxVlo/hVP1YAVF14eiOsW//5qmbuYyBWZ1DM=;
 h=From:To:CC:Subject:Date;
 b=muW2XwgjDpu3UYx/Gw/wYDO6si+Lwfmqqro2pRlXs1F0r7Q50GyD/utoSTBqMXONI
 8jf56nqYaUMAsBkCpRqVAlELwhMH0A34t2tGLLLnzt2ciguV3XMO0REb/dkSU8QIuE
 D4MJ24WhwiyEy+7wo1EZflOSHIHyiL0pHFpiGEHg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AIKH0H124287
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Apr 2024 13:20:17 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 13:20:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 13:20:16 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AIKGIU050138;
 Wed, 10 Apr 2024 13:20:16 -0500
From: Judith Mendez <jm@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
CC: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>
Subject: [PATCH] configs: am64x_evm_*_defconfig: Increase offsets for eMMC raw
 boot
Date: Wed, 10 Apr 2024 13:20:16 -0500
Message-ID: <20240410182016.1117085-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

EMMC boot can fail due to the size of R5 SPL image growing beyond the
500KB of memory allocated in eMMC. Update offsets for eMMMC raw boot
to load each binary from the correct address in eMMC according to the
following eMMC layout:

            boot0/1 partition
    0x0+----------------------------------+
       |     tiboot3.bin (1 MB)           |
  0x800+----------------------------------+
       |       tispl.bin (2 MB)           |
0x1800+-----------------------------------+
       |       u-boot.img (4 MB)          |
0x3800+-----------------------------------+
       |      environment (128 KB)        |
0x3900+-----------------------------------+

Signed-off-by: Judith Mendez <jm@ti.com>
---
 configs/am64x_evm_a53_defconfig | 2 +-
 configs/am64x_evm_r5_defconfig  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index b7057be3d65..86740559905 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -44,7 +44,7 @@ CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1800
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_ETH=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 555d69bb117..4a3780ce660 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -51,7 +51,7 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
 CONFIG_SPL_EARLY_BSS=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x800
 CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_ETH=y

base-commit: bc39e06778168a34bb4e0a34fbee4edbde4414d8
-- 
2.43.2

