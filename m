Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD264E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF7638012C;
	Fri, 13 Dec 2024 11:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o1LZJ34L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A88380219; Fri, 13 Dec 2024 11:32:18 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 392468012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAWEMC101635;
 Fri, 13 Dec 2024 04:32:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734085934;
 bh=+/jEbx8NtXaCzpa+qF0d+IyFzMgWc7Jd1VbMrNTOVXs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=o1LZJ34LRR6ylngoss7GTqD4UyCpSYUs9vgtTpyjGu4ecJ7CslGWKV/g503pkWNT0
 lemrkLiLOH2zP7tgJW1Zoa4+1l8nPlO/V23FkxHStsOITTvj/AUC8D/+zCnCSaVYOC
 m/2Qm8p5C2Nd0iTJMMbZ+Wdf8DSG5M0EgKD0DWJY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAWEBo005843
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Dec 2024 04:32:14 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 04:32:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 04:32:14 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAVpqA067253;
 Fri, 13 Dec 2024 04:32:10 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v5 5/9] ram: k3-ddrss: Enable ECC interrupts
Date: Fri, 13 Dec 2024 16:01:25 +0530
Message-ID: <20241213103129.332246-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213103129.332246-1-s-k6@ti.com>
References: <20241213103129.332246-1-s-k6@ti.com>
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

Enable ECC 1-bit error, 2-bit error, multiple 1-bit error interrupts
by setting the respective bits in the DDRSS_V2A_INT_SET_REG register.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 0678db3b418b..e4f9891bee20 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -45,6 +45,11 @@
 #define DDRSS_ECC_R2_STR_ADDR_REG		0x0140
 #define DDRSS_ECC_R2_END_ADDR_REG		0x0144
 #define DDRSS_ECC_1B_ERR_CNT_REG		0x0150
+#define DDRSS_V2A_INT_SET_REG			0x00a8
+
+#define DDRSS_V2A_INT_SET_REG_ECC1BERR_EN	BIT(3)
+#define DDRSS_V2A_INT_SET_REG_ECC2BERR_EN	BIT(4)
+#define DDRSS_V2A_INT_SET_REG_ECCM1BERR_EN	BIT(5)
 
 #define SINGLE_DDR_SUBSYSTEM	0x1
 #define MULTI_DDR_SUBSYSTEM	0x2
@@ -742,6 +747,9 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
 	/* Clear Error Count Register */
 	writel(0x1, base + DDRSS_ECC_1B_ERR_CNT_REG);
 
+	writel(DDRSS_V2A_INT_SET_REG_ECC1BERR_EN | DDRSS_V2A_INT_SET_REG_ECC2BERR_EN |
+		   DDRSS_V2A_INT_SET_REG_ECCM1BERR_EN, base + DDRSS_V2A_INT_SET_REG);
+
 	/* Enable ECC Check */
 	val = readl(base + DDRSS_ECC_CTRL_REG);
 	val |= DDRSS_ECC_CTRL_REG_ECC_CK;
-- 
2.34.1

