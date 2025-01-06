Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE56E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0403E8036B;
	Mon,  6 Jan 2025 10:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YSA7t3RF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 250388007D; Mon,  6 Jan 2025 10:07:45 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F3548036B
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50697f4B2768687
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jan 2025 03:07:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736154461;
 bh=+/jEbx8NtXaCzpa+qF0d+IyFzMgWc7Jd1VbMrNTOVXs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=YSA7t3RF3JAZpyxnZEAedR4QyXwgNOFVgAHPOQ8E/lH0Vyk7j/ZeIE9K/ALdwEhLq
 aZmf7DJ4CIescuPJulkFka/ZzVZXluuKVgySaoSKJnyWDOSgQgwUAL6BaoRC5SEXWf
 3LPD5HIkOF0UUgSupT8OMOx5srzNfpW9DtKktQ+Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50697f80071186
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Jan 2025 03:07:41 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 03:07:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 03:07:41 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50697Jua103050;
 Mon, 6 Jan 2025 03:07:38 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v6 5/9] ram: k3-ddrss: Enable ECC interrupts
Date: Mon, 6 Jan 2025 14:37:04 +0530
Message-ID: <20250106090708.1541212-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106090708.1541212-1-s-k6@ti.com>
References: <20250106090708.1541212-1-s-k6@ti.com>
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

