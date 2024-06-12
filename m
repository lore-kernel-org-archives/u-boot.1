Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17268C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 09:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A587988814;
	Wed, 12 Jun 2024 11:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YM7BTmjk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68CC088723; Wed, 12 Jun 2024 11:11:42 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2096D887E7
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 11:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BSFA051189;
 Wed, 12 Jun 2024 04:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718183488;
 bh=CO7qCjLQejHDYmZ5f0kAoZTpfwGlEgoTbU7tgj2VWFI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=YM7BTmjkr6rbrz66pIG0ZSCb02DVsZJ4EgdvBVgm58Xc1xCTShAG7x/USlnCXWwJi
 I8u3ntG7Y48bCcT0qcKOdEL2hFn53SZyhYDTNctEgQ32ft+RasWXcaLEkWuv0L9NX8
 ICk4TlN8DBrzST21tysGDiXQ2tDR8vMsHNQpyN3E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45C9BSfq054167
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Jun 2024 04:11:28 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jun 2024 04:11:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jun 2024 04:11:27 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.55])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45C9BRf0062248;
 Wed, 12 Jun 2024 04:11:27 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <sumit.garg@linaro.org>,
 <afd@ti.com>, <j-choudhary@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
Subject: [PATCH v2 02/14] soc: ti: k3-socinfo: Fix SOC JTAG entry order
Date: Wed, 12 Jun 2024 14:41:11 +0530
Message-ID: <20240612091123.253835-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240612091123.253835-1-j-choudhary@ti.com>
References: <20240612091123.253835-1-j-choudhary@ti.com>
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
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/soc/soc_ti_k3.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index b585e47d46..0838808515 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -23,33 +23,33 @@ static const char *get_family_string(u32 idreg)
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

