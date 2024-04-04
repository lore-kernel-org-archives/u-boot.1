Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D4CCD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50FB88431;
	Thu,  4 Apr 2024 11:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rmaTQH+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F7E8842C; Thu,  4 Apr 2024 11:01:01 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD35C88419
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43490jlQ122394;
 Thu, 4 Apr 2024 04:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221245;
 bh=8P/qTgr1uqP9QqcWZTpq1ewNHPVFQwPvF3998MqRoIE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rmaTQH+nkYXJUso68mffb8btbiOacS7HIFIPxZBZZE+bPOc4K7Hhrc6YpABhCUWVX
 +O+mMNI8K4G995kiKHWMNd4f/Xwqvydxe+HrwlqHNCsbwruKddBXpPRdzcrPY/f1gF
 9xWSHdf48d0W8cBewvLZpyhCm6BM00vMrRaUZPTU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43490jXr062048
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:00:45 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:00:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:00:44 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.252])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43490ick010697;
 Thu, 4 Apr 2024 04:00:44 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 03/15] soc: ti: k3-socinfo: Fix SOC JTAG entry order
Date: Thu, 4 Apr 2024 14:30:27 +0530
Message-ID: <20240404090039.87458-4-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404090039.87458-1-j-choudhary@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
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

Add JTAG_ID_PARTNO_* in alphabetical order.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/soc/soc_ti_k3.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index 3a4e58bba6..bcc11e6bff 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -24,33 +24,33 @@ static const char *get_family_string(u32 idreg)
 	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
 
 	switch (soc) {
+	case JTAG_ID_PARTNO_AM62X:
+		family = "AM62X";
+		break;
+	case JTAG_ID_PARTNO_AM62AX:
+		family = "AM62AX";
+		break;
+	case JTAG_ID_PARTNO_AM62PX:
+		family = "AM62PX";
+		break;
+	case JTAG_ID_PARTNO_AM64X:
+		family = "AM64X";
+		break;
 	case JTAG_ID_PARTNO_AM65X:
 		family = "AM65X";
 		break;
-	case JTAG_ID_PARTNO_J721E:
-		family = "J721E";
-		break;
 	case JTAG_ID_PARTNO_J7200:
 		family = "J7200";
 		break;
-	case JTAG_ID_PARTNO_AM64X:
-		family = "AM64X";
+	case JTAG_ID_PARTNO_J721E:
+		family = "J721E";
 		break;
 	case JTAG_ID_PARTNO_J721S2:
 		family = "J721S2";
 		break;
-	case JTAG_ID_PARTNO_AM62X:
-		family = "AM62X";
-		break;
-	case JTAG_ID_PARTNO_AM62AX:
-		family = "AM62AX";
-		break;
 	case JTAG_ID_PARTNO_J784S4:
 		family = "J784S4";
 		break;
-	case JTAG_ID_PARTNO_AM62PX:
-		family = "AM62PX";
-		break;
 	default:
 		family = "Unknown Silicon";
 	};
-- 
2.25.1

