Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C06C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 15:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E873F8788E;
	Tue,  5 Dec 2023 16:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="O4MI0uwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0739286E42; Tue,  5 Dec 2023 16:55:43 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B67C878DE
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 16:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtZP1126353;
 Tue, 5 Dec 2023 09:55:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701791735;
 bh=k26eeOP9SGY9uw+szxA3oW2fAufYEZvSYcppedhqMUs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=O4MI0uwkA+IM1vw5NsNLDrYRlFzgeI2E5e6ZjHN3Ax01vqq/NsKUs3ZtIWyJWMgvf
 aScMrbKIBT0ZLLMjRM2fJ9ByPchQtYMGgsToYViFwEalYjDjAAEBqoDoWA/VttIb67
 jFjo1Q4K4b2WQ6Ywb3KR7TkRkZ8H45XEJ12yGQbw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5FtZfx001205
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 09:55:35 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 09:55:34 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 09:55:34 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtY8Q081909;
 Tue, 5 Dec 2023 09:55:34 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 7/8] doc: spl: Add info for missing Kconfigs
Date: Tue, 5 Dec 2023 21:25:22 +0530
Message-ID: <20231205155523.721784-8-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205155523.721784-1-devarsht@ti.com>
References: <20231205155523.721784-1-devarsht@ti.com>
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
Reviewed-by: Simon Glass <sjg@chromium>
---
V2: No change
V3: No change
V4: Patch split from parent
V5: Add Reviewed-by
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

