Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9D8C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 10:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D6E87664;
	Mon, 11 Dec 2023 11:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sGWD9pTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C273876AC; Mon, 11 Dec 2023 11:42:20 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7306E804CE
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 11:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BBAgD2Q079138;
 Mon, 11 Dec 2023 04:42:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702291333;
 bh=eCSBlEqNGjpcLXT2wJMnj0nEfUli3EgVMp9E4eJv2Cc=;
 h=From:To:CC:Subject:Date;
 b=sGWD9pTeGMPMifJgyHD5F2QqdFAMtFgyKJ3/rvc24uRysOkaI6ZEY8VfpNKOJ8g9M
 i6A6Fl/oqfNgSbxA/mQlZCygihKohJan8vlMLnLXyzcZBgEWGspWUzqo3gRVMv+iOE
 CVF2bLoS+pY/6PJgooayUAe334q7+kAQF0SU2MFQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BBAgDVS072639
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Dec 2023 04:42:13 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Dec 2023 04:42:13 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Dec 2023 04:42:13 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BBAg99l022654; 
 Mon, 11 Dec 2023 04:42:10 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <bmeng.cn@gmail.com>,
 <sjg@chromium.org>, <afd@ti.com>, <mkorpershoek@baylibre.com>,
 <n-francis@ti.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH] include: env: ti: ti_common: Run main_cpsw0_qsgmii_phyinit
 conditionally
Date: Mon, 11 Dec 2023 16:12:09 +0530
Message-ID: <20231211104209.1078892-1-s-vadapalli@ti.com>
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

From: Manorit Chawdhry <m-chawdhry@ti.com>

The main_cpsw0_qsgmii_phyinit command is defined only for certain TI
SoCs which have the do_main_cpsw0_qsgmii_phyinit variable set.

Add a check to ensure that the main_cpsw0_qsgmii_phyinit command is run
only for such SoCs.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
65eed68772 test/py: Disable error E0611 in two cases for pylint

Regards,
Siddharth.

 include/env/ti/ti_common.env | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index f5d84216e3..f0f89a2287 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -25,7 +25,10 @@ run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
 bootcmd_ti_mmc=
 	run findfdt; run init_${boot};
 #if CONFIG_CMD_REMOTEPROC
-	run main_cpsw0_qsgmii_phyinit; run boot_rprocs;
+	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
+		then run main_cpsw0_qsgmii_phyinit;
+	fi
+	run boot_rprocs;
 #endif
 	if test ${boot_fit} -eq 1;
 		then run get_fit_${boot}; run get_fit_overlaystring; run run_fit;
-- 
2.34.1

