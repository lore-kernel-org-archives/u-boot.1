Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7250E75434
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 08:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 909F38744C;
	Tue,  3 Oct 2023 10:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wWpP/Fs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265F887235; Tue,  3 Oct 2023 10:11:03 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6604E86BE1
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3938Av2p011564;
 Tue, 3 Oct 2023 03:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696320657;
 bh=EUStes5zmKkuV2eElVZl8NEA2qoANKgRtr1PdKHL8mg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wWpP/Fs4tAn1I/5tMqN2VYzeDJA9jrA6mfaeSd9h5ETzejMY7HEpqsj2/mG0abkEn
 eS45S/d2z9C/+4PrL1XRwkjsp+9hENisqAsW4ugg9HfdvPuy7YoFmNQZXCxgqWHHTl
 XmfDBqruIeywUF/xgBwTSYvIHD/CPn925EKw0xng=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3938Avod031875
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 03:10:57 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 03:10:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 03:10:57 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3938AhEF110453;
 Tue, 3 Oct 2023 03:10:55 -0500
From: Keerthy <j-keerthy@ti.com>
To: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
CC: <j-keerthy@ti.com>, <n-francis@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: [PATCH RFC 05/10] board: ti: j721e: Initialize MCU ESM
Date: Tue, 3 Oct 2023 13:40:33 +0530
Message-ID: <20231003081038.24299-6-j-keerthy@ti.com>
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

Initialize MCU ESM. This is needed to propagate MAIN domain
events to the PMIC.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 board/ti/j721e/evm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 38fe447d8f..42fa94b7a5 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -548,7 +548,12 @@ void spl_board_init(void)
 						  DM_DRIVER_GET(k3_esm), &dev);
 		if (ret)
 			printf("ESM init failed: %d\n", ret);
+
+		ret = uclass_get_device_by_name(UCLASS_MISC, "esm@40800000", &dev);
+		if (ret)
+			printf("MISC init for esm@40800000 failed: %d\n", ret);
 	}
+
 #endif
 
 #ifdef CONFIG_ESM_PMIC
-- 
2.17.1

