Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08A1E75434
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 08:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDED787452;
	Tue,  3 Oct 2023 10:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iWQJjVYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C61A086BE1; Tue,  3 Oct 2023 10:11:18 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5089687492
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:11:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3938B8UX023825;
 Tue, 3 Oct 2023 03:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696320668;
 bh=I/iMhVFMRchxUoqQ80Jkc3I2EMhKOs2BNpbWO5pRA3g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iWQJjVYXDclVUY2h2EmGYeVIYO4MIBozgFaZm+u0gdRNla3bH/C9LjnHpJ0leqZwJ
 CwkaJZxQ6qW7RY9I8sPqvh924bOUnbuVtcyI/S4B1zup2wGLdmhNyANyXR2U0iUVzV
 1Yy722BE29/bpfGie+ISCKHGk78XQ0lytpEq5Btk=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3938B8BR022326
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 03:11:08 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 03:11:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 03:11:08 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3938AhEK110453;
 Tue, 3 Oct 2023 03:11:06 -0500
From: Keerthy <j-keerthy@ti.com>
To: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
CC: <j-keerthy@ti.com>, <n-francis@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: [PATCH RFC 10/10] board: ti: j721e: Enable ESM initialization for
 J7200
Date: Tue, 3 Oct 2023 13:40:38 +0530
Message-ID: <20231003081038.24299-11-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003081038.24299-1-j-keerthy@ti.com>
References: <20231003081038.24299-1-j-keerthy@ti.com>
MIME-Version: 1.0
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

Enable ESM initialization for J7200

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 board/ti/j721e/evm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 42fa94b7a5..070b28326f 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -543,7 +543,8 @@ void spl_board_init(void)
 	}
 
 #ifdef CONFIG_ESM_K3
-	if (board_ti_k3_is("J721EX-PM2-SOM")) {
+	if ((board_ti_k3_is("J721EX-PM2-SOM")) ||
+	    IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM)) {
 		ret = uclass_get_device_by_driver(UCLASS_MISC,
 						  DM_DRIVER_GET(k3_esm), &dev);
 		if (ret)
@@ -557,7 +558,8 @@ void spl_board_init(void)
 #endif
 
 #ifdef CONFIG_ESM_PMIC
-	if (board_ti_k3_is("J721EX-PM2-SOM")) {
+	if ((board_ti_k3_is("J721EX-PM2-SOM")) ||
+	    IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM)) {
 		ret = uclass_get_device_by_driver(UCLASS_MISC,
 						  DM_DRIVER_GET(pmic_esm),
 						  &dev);
-- 
2.17.1

