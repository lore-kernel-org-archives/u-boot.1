Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30747D5A6DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 05:34:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8268389BFC;
	Tue, 26 Nov 2024 06:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QaOP3GCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4841A88D9A; Tue, 26 Nov 2024 06:34:52 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2EF48903C
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQ5YmUY462309
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 25 Nov 2024 23:34:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732599288;
 bh=zLdHFFfy9fKGbwuvwpu9YXxOXo3JVmZqmr3w7kSWqds=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QaOP3GCMBGXi5qUZ5PpcHonDjOcircbcS13J7phd2FmZZ1rQLqAMPaYjyyxRr5Aag
 JU4mdsj1VQuEvqypTIrAUED7k7IDQSGPCK5jbcTqXLEehI9+gd10fLzFoca5vU3k7l
 2lbqQG801uA8deurGMs5UZKEsfLJDHf2SPss0Fgo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ5YmeR044404;
 Mon, 25 Nov 2024 23:34:48 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Nov 2024 23:34:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Nov 2024 23:34:47 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQ5YcKp107360;
 Mon, 25 Nov 2024 23:34:44 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <n-francis@ti.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <m-chawdhry@ti.com>, <j-keerthy@ti.com>, <p-mantena@ti.com>,
 <j-choudhary@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 1/3] board: ti: j721s2: Initialize the ESM & PMIC ESM
Date: Tue, 26 Nov 2024 11:04:24 +0530
Message-ID: <20241126053426.2627686-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126053426.2627686-1-u-kumar1@ti.com>
References: <20241126053426.2627686-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Keerthy <j-keerthy@ti.com>

Initialize the 3 instances of SOC ESM & PMIC ESM.
This is needed for watchdog functionality.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 board/ti/j721s2/evm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 2cfeb3bec6c..9bcf67b7bfb 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -326,4 +326,27 @@ int board_late_init(void)
 
 void spl_board_init(void)
 {
+	struct udevice *dev;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_ESM_K3)) {
+		const char * const esms[] = {"esm@700000", "esm@40800000", "esm@42080000"};
+
+		for (int i = 0; i < ARRAY_SIZE(esms); ++i) {
+			ret = uclass_get_device_by_name(UCLASS_MISC, esms[i],
+							&dev);
+			if (ret) {
+				printf("MISC init for %s failed: %d\n", esms[i], ret);
+				break;
+			}
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_ESM_PMIC) && ret == 0) {
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(pmic_esm),
+						  &dev);
+		if (ret)
+			printf("ESM PMIC init failed: %d\n", ret);
+	}
 }
-- 
2.34.1

