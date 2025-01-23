Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350E2C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 08:37:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67E7E801B0;
	Thu, 23 Jan 2025 09:37:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D2/mPZzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F5C280214; Thu, 23 Jan 2025 09:37:09 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2022D80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 09:37:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50N8b45C1170275
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Jan 2025 02:37:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737621424;
 bh=Phhxrb6s0c72yCD5X/i5wWrBRycytZigy/EC2VoXux4=;
 h=From:To:CC:Subject:Date;
 b=D2/mPZzWfuTv5RUTe3IvRO5/UNalQlsuEuako0d3vwze5e9HlFsUL/sW0NfrD/XuI
 WnLRyuEdomtpfaUKYNRVDQ1Fe+PqfQaJi00xADXjDIy68mLQYTCxgWd5Xap+AZmS8r
 4PStvyMvlxCQM41teZxYhq+Z23E4atkopDblHEiI=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50N8b4wc091991;
 Thu, 23 Jan 2025 02:37:04 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Jan 2025 02:37:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Jan 2025 02:37:03 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50N8b1Ha026676;
 Thu, 23 Jan 2025 02:37:01 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH] ram: k3-ddrss: Set SDRAM_IDX using device private data,
 ddr_ram_size
Date: Thu, 23 Jan 2025 14:06:26 +0530
Message-ID: <20250123083626.1035262-1-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
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

The SDRAM_IDX in DDRSS_V2A_CTL_REG describes the number of address bits
minus 16 that are used to determine the mask used to detect memory
rollover and prevent aliasing and false coherency issues.

Set SDRAM_IDX using the device private data, ddr_ram_size for K3 family
of SoCs.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---

Tested on AM64x, AM62Ax, AM62Px.
Logs: https://gist.github.com/santhosh21/6dcdeb9a118c13732f858a1baca7dc4c

---
 drivers/ram/k3-ddrss/k3-ddrss.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 05ea61bbfe9a..ff87faf6a224 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -33,6 +33,12 @@
 #define DDRSS_V2A_CTL_REG			0x0020
 #define DDRSS_ECC_CTRL_REG			0x0120
 
+#define DDRSS_V2A_CTL_REG_SDRAM_IDX_CALC(x)	((ilog2(x) - 16) << 5)
+#define DDRSS_V2A_CTL_REG_SDRAM_IDX_MASK	(~(0x1F << 0x5))
+#define DDRSS_V2A_CTL_REG_REGION_IDX_MASK	(~(0X1F))
+#define DDRSS_V2A_CTL_REG_REGION_IDX_DEFAULT	0xF
+
+#define DDRSS_ECC_CTRL_REG_DEFAULT		0x0
 #define DDRSS_ECC_CTRL_REG_ECC_EN		BIT(0)
 #define DDRSS_ECC_CTRL_REG_RMW_EN		BIT(1)
 #define DDRSS_ECC_CTRL_REG_ECC_CK		BIT(2)
@@ -711,6 +717,22 @@ static void k3_ddrss_ddr_bank_base_size_calc(struct k3_ddrss_desc *ddrss)
 		ddrss->ddr_ram_size += ddrss->ddr_bank_size[bank];
 }
 
+static void k3_ddrss_ddr_reg_init(struct k3_ddrss_desc *ddrss)
+{
+	u32 v2a_ctl_reg, sdram_idx;
+
+	sdram_idx = DDRSS_V2A_CTL_REG_SDRAM_IDX_CALC(ddrss->ddr_ram_size);
+	v2a_ctl_reg = readl(ddrss->ddrss_ss_cfg + DDRSS_V2A_CTL_REG);
+	v2a_ctl_reg = (v2a_ctl_reg & DDRSS_V2A_CTL_REG_SDRAM_IDX_MASK) | sdram_idx;
+
+	if (IS_ENABLED(CONFIG_SOC_K3_AM642))
+		v2a_ctl_reg = (v2a_ctl_reg & DDRSS_V2A_CTL_REG_REGION_IDX_MASK) |
+			      DDRSS_V2A_CTL_REG_REGION_IDX_DEFAULT;
+
+	writel(v2a_ctl_reg, ddrss->ddrss_ss_cfg + DDRSS_V2A_CTL_REG);
+	writel(DDRSS_ECC_CTRL_REG_DEFAULT, ddrss->ddrss_ss_cfg + DDRSS_ECC_CTRL_REG);
+}
+
 static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
 {
 	fdtdec_setup_mem_size_base_lowest();
@@ -769,11 +791,9 @@ static int k3_ddrss_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-#ifdef CONFIG_K3_AM64_DDRSS
-	/* AM64x supports only up to 2 GB SDRAM */
-	writel(0x000001EF, ddrss->ddrss_ss_cfg + DDRSS_V2A_CTL_REG);
-	writel(0x0, ddrss->ddrss_ss_cfg + DDRSS_ECC_CTRL_REG);
-#endif
+	k3_ddrss_ddr_bank_base_size_calc(ddrss);
+
+	k3_ddrss_ddr_reg_init(ddrss);
 
 	ddrss->driverdt = lpddr4_getinstance();
 
@@ -787,8 +807,6 @@ static int k3_ddrss_probe(struct udevice *dev)
 
 	k3_lpddr4_start(ddrss);
 
-	k3_ddrss_ddr_bank_base_size_calc(ddrss);
-
 	if (IS_ENABLED(CONFIG_K3_INLINE_ECC)) {
 		if (!ddrss->ddrss_ss_cfg) {
 			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
-- 
2.34.1

