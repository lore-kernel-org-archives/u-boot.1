Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918C5C54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 14:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E864987F6E;
	Thu, 14 Mar 2024 15:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iw8AZA2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A623E87F6E; Thu, 14 Mar 2024 15:33:38 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0AA687CEA
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 15:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42EEXOe3061141;
 Thu, 14 Mar 2024 09:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710426804;
 bh=fJXwvAbrZGP1MQiqsCOvjMHZTZWIhwUdax8QXy31z9k=;
 h=From:To:CC:Subject:Date;
 b=iw8AZA2gXa4as7FyDS5Ap4oeIhQuo6MC1sW9Q2fmMrg1j5562AnrxjweQ0rCde8EM
 8j7r3S/pwpkRRyYRaWprmCAZFpvFc/GxW1Y+4W85GxaKCcPJtZUAATVfKtxO0LULy5
 SIJKfSsVpqZGfj4n20sUYH8+SKjomn9Nt+oVASlw=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42EEXOEG029743
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Mar 2024 09:33:24 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Mar 2024 09:33:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Mar 2024 09:33:24 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42EEXODm118052;
 Thu, 14 Mar 2024 09:33:24 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 42EEXNSc014010;
 Thu, 14 Mar 2024 09:33:24 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Nishanth Menon <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>, Igor
 Opaniuk <igor.opaniuk@foundries.io>, Andrew Davis <afd@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] arm: mach-k3: Fix config check for FS_LOADER
Date: Thu, 14 Mar 2024 20:03:10 +0530
Message-ID: <20240314143311.259568-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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

load_firmware() API calls fs-loader APIs and checks for CONFIG_FS_LOADER
before calling those APIs. The if check only checks for CONFIG_FS_LOADER
but not for CONFIG_SPL_FS_LOADER.

When CONFIG_FS_LOADER is enabled, load_firmware() API calls fs-loader APIs
but this is done at SPL stage and at this time FS_LOADER is not built yet
as a result we see below build error.

  AR      spl/boot/built-in.o
  LD      spl/u-boot-spl
arm-none-linux-gnueabihf-ld.bfd: arch/arm/mach-k3/common.o: in function
`load_firmware':
/home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:184: undefined
reference to `get_fs_loader'
arm-none-linux-gnueabihf-ld.bfd:
/home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:185: undefined
reference to `request_firmware_into_buf'
make[2]: *** [/home/danish/workspace/u-boot/scripts/Makefile.spl:527:
spl/u-boot-spl] Error 1
make[1]: *** [/home/danish/workspace/u-boot/Makefile:2055:
spl/u-boot-spl] Error 2
make[1]: Leaving directory '/home/danish/uboot_images/am64x/r5'
make: *** [Makefile:177: sub-make] Error 2

Fix this by modifying the if check to CONFIG_IS_ENABLED(FS_LOADER) instead
of IS_ENABLED(CONFIG_FS_LOADER) as the former will check for the
appropriate config option (CONFIG_SPL_FS_LOADER / CONFIG_FS_LOADER) based
on the build stage.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm/mach-k3/r5/common.c      | 2 +-
 arch/arm/mach-omap2/boot-common.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 7309573a3f..c02f8d3309 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -70,7 +70,7 @@ int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr)
 	char *name = NULL;
 	int size = 0;
 
-	if (!IS_ENABLED(CONFIG_FS_LOADER))
+	if (!CONFIG_IS_ENABLED(FS_LOADER))
 		return 0;
 
 	*loadaddr = 0;
diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
index 57917da25c..aa0ab13d5f 100644
--- a/arch/arm/mach-omap2/boot-common.c
+++ b/arch/arm/mach-omap2/boot-common.c
@@ -190,7 +190,7 @@ int load_firmware(char *name_fw, u32 *loadaddr)
 	struct udevice *fsdev;
 	int size = 0;
 
-	if (!IS_ENABLED(CONFIG_FS_LOADER))
+	if (!CONFIG_IS_ENABLED(FS_LOADER))
 		return 0;
 
 	if (!*loadaddr)
-- 
2.34.1

