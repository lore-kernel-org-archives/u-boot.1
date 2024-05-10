Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A590C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 08:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35DEA88194;
	Fri, 10 May 2024 10:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R+fLxb2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4B488667; Fri, 10 May 2024 10:48:29 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DCD08818B
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 10:48:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mPbJ003141;
 Fri, 10 May 2024 03:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715330905;
 bh=Y5jB4AbQmfinDNPwCOmQTFluxVrgpTPvXfAkzy4DTrU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=R+fLxb2u0fiaHtlio37WrEuKTwN1yTJXEUF/iDpuLctPmsk41y0HtdHr5Li7rAebW
 Z+hw6jNHzQnf1HHCtnhMPeJeRJrdY5mtykLUFpBOZtDCw7b14jy17RkVCDLp1zHhFU
 X+liHvBKxENtfqK9/TORigaqINNvqG/bLxhHj2go=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A8mP8s007156
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 03:48:25 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 03:48:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 03:48:25 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mA1d107745;
 Fri, 10 May 2024 03:48:22 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 4/8] ram: k3-ddrss: Enable ECC interrupts
Date: Fri, 10 May 2024 14:17:03 +0530
Message-ID: <20240510084707.1903133-5-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510084707.1903133-1-s-k6@ti.com>
References: <20240510084707.1903133-1-s-k6@ti.com>
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

Enable ECC 1-bit error, 2-bit error, multiple 1-bit error interrupts
by setting the respective bits in the DDRSS_V2A_INT_SET_REG register.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 6cf680972808..5bc625fc2db6 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -46,6 +46,11 @@
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
@@ -748,6 +753,9 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
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

