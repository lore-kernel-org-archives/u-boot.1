Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4784C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DED687AB8;
	Tue, 31 Oct 2023 14:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HRPJKRxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF60C87C9D; Tue, 31 Oct 2023 14:28:20 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA5E4875F9
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-yadav@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSF6M015942;
 Tue, 31 Oct 2023 08:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698758895;
 bh=MzWfFCXs5MwQloMTwU5ZauxbyP0RndOIjQRCC3WUsVU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HRPJKRxIbClcC9Ou2DXCpLO5ogqvsK6AE/Y3FC4a93WaUQPsnBZvxpS2fZ79Q0UHM
 hZCT1FIKdhBvUJbCDGw2+lPXgFbFXdQQbP43ypblRv423sb87QbNrrM6S6luY0fYuV
 ZN1x3tPjOpitULHD/99h54NnSdYo52tohxZ7bWs4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDSF88106384
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:28:15 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:28:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:28:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDSEBR030417;
 Tue, 31 Oct 2023 08:28:14 -0500
From: Nitin Yadav <n-yadav@ti.com>
To: <nm@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 3/6] board: ti: am62x: Avoid overwriting reserve mem for AM62
 SIP
Date: Tue, 31 Oct 2023 18:58:06 +0530
Message-ID: <20231031132809.1524341-4-n-yadav@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031132809.1524341-1-n-yadav@ti.com>
References: <20231031132809.1524341-1-n-yadav@ti.com>
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

AM62 SIP has 512MB RAM. But the top of the RAM is reserved for
TF-A and OPTEE. U-Boot relocating there would cause overwriting
of these reserved regions. Fix this by limit U-Boot to first
64MB of RAM for all boards with 512MB.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Nitin Yadav <n-yadav@ti.com>
---
 board/ti/am62x/evm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index ad93908840..ad3e415592 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -18,6 +18,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <dm/uclass.h>
+#include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -59,6 +60,16 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
+phys_size_t get_effective_memsize(void)
+{
+	/*
+	* Just below 512MB are TF-A and OPTEE reserve regions, thus
+	* SPL/U-Boot RAM has to start below that. Leave 64MB space for
+	* all reserved memories.
+	*/
+	return gd->ram_size == SZ_512M ? SZ_512M - SZ_64M : gd->ram_size;
+}
+
 #if defined(CONFIG_SPL_BUILD)
 static int video_setup(void)
 {
-- 
2.25.1

