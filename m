Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A60C4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 16:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC0D874D5;
	Sat, 25 Nov 2023 17:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wUvV8PM5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B082287174; Sat, 25 Nov 2023 17:27:22 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC21987257
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 17:27:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3APGRGRZ082165;
 Sat, 25 Nov 2023 10:27:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700929636;
 bh=drLmT9Fq2od9bVVs33L04vg9OKOBHCyr3JulN8xeRnk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wUvV8PM5+E12Co1ENer8oRipWwMr3wjBxFAZ5pLdSW4QJ4S6IvnoO5K1O22cLGDGt
 A8fqvMGaDkntWD9UsF/SMyAT3/oAxzif+E/nAmp+nFRMrNPkg9P4V97OurWIUjNz+a
 sO84K3jSqdjnOrLqk5lPztSw9yzumN71ah1S++pk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3APGRGdO110428
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Nov 2023 10:27:16 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 25
 Nov 2023 10:27:16 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 25 Nov 2023 10:27:16 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3APGRFn7003130;
 Sat, 25 Nov 2023 10:27:16 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 7/8] doc: spl: Add info for missing Kconfigs
Date: Sat, 25 Nov 2023 21:57:04 +0530
Message-ID: <20231125162705.1383401-8-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125162705.1383401-1-devarsht@ti.com>
References: <20231125162705.1383401-1-devarsht@ti.com>
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

Add info regarding splash screen, video, bloblist and GPIO related
Kconfigs which were missing in the documentation.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: No change
V3: No change
V4: Patch split from parent
---
 doc/develop/spl.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/doc/develop/spl.rst b/doc/develop/spl.rst
index 76e87f07c7..814530d348 100644
--- a/doc/develop/spl.rst
+++ b/doc/develop/spl.rst
@@ -65,6 +65,15 @@ CONFIG_SPL_NAND_LOAD (drivers/mtd/nand/raw/nand_spl_load.o)
 CONFIG_SPL_SPI_LOAD (drivers/mtd/spi/spi_spl_load.o)
 CONFIG_SPL_RAM_DEVICE (common/spl/spl.c)
 CONFIG_SPL_WATCHDOG (drivers/watchdog/libwatchdog.o)
+CONFIG_SPL_SYSCON (drivers/core/syscon-uclass.o)
+CONFIG_SPL_GZIP (lib/gzip.o)
+CONFIG_SPL_VIDEO (drivers/video/video-uclass.o drivers/video/vidconsole-uclass.o)
+CONFIG_SPL_SPLASH_SCREEN (common/splash.o)
+CONFIG_SPL_SPLASH_SOURCE (common/splash_source.o)
+CONFIG_SPL_GPIO (drivers/gpio)
+CONFIG_SPL_DM_GPIO (drivers/gpio/gpio-uclass.o)
+CONFIG_SPL_BMP (drivers/video/bmp.o)
+CONFIG_SPL_BLOBLIST (common/bloblist.o)
 
 Adding SPL-specific code
 ------------------------
-- 
2.34.1

