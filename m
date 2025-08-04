Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BE6C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 23:37:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990408403E;
	Tue,  5 Aug 2025 01:37:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SRuclpAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D24FE8405B; Tue,  5 Aug 2025 01:37:24 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 940A584005
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 01:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 574NbJII3911153;
 Mon, 4 Aug 2025 18:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754350639;
 bh=TdP4d5KqRRJG9WrEp01uxxAgDq36Zz/tS8P6LaEM45w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SRuclpAVofLnTXWrp/BRC2uIOk1xVIUMdl7uoAvmkc3C62H2CuKPGYgDjHJW4XDgd
 ccTfVXaIAdxnMBLVUdrcz1yopG7qzzgjjvrPZHYZ9bFMJvIVEyHAIXtuvkD+SDmAUf
 hGaVwuheDwrEPd5TpZNEqXENefJNHP5BUt0uUIPw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 574NbJEJ1859507
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 4 Aug 2025 18:37:19 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 4
 Aug 2025 18:37:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 4 Aug 2025 18:37:18 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 574NbIRJ898934;
 Mon, 4 Aug 2025 18:37:18 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 1/2] soc: soc_ti_k3: Add support for AM62P variants
Date: Mon, 4 Aug 2025 18:37:17 -0500
Message-ID: <20250804233718.1471877-2-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804233718.1471877-1-jm@ti.com>
References: <20250804233718.1471877-1-jm@ti.com>
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

This adds a support for detecting AM62P SR1.0, SR1.1, SR1.2.

On AM62P, silicon revision is discovered with GP_SW1 register instead
of JTAGID register, so introduce GP_SW register range to determine SoC
revision.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/soc/soc_ti_k3.c | 66 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index b34cbd08e07..d6097ee6d17 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -10,6 +10,8 @@
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 
+#define CTRLMMR_WKUP_GP_SW1_REG		4
+
 struct soc_ti_k3_plat {
 	const char *family;
 	const char *revision;
@@ -76,12 +78,17 @@ static char *j721e_rev_string_map[] = {
 	"1.0", "1.1", "2.0",
 };
 
+static char *am62p_gpsw_rev_string_map[] = {
+	"1.0", "1.1", "1.2",
+};
+
 static char *typical_rev_string_map[] = {
 	"1.0", "2.0", "3.0",
 };
 
-static const char *get_rev_string(u32 idreg)
+static const char *get_rev_string(u32 idreg, u32 gpsw1)
 {
+	u32 gpsw_variant = gpsw1 % 16;
 	u32 rev;
 	u32 soc;
 
@@ -93,7 +100,10 @@ static const char *get_rev_string(u32 idreg)
 		if (rev >= ARRAY_SIZE(j721e_rev_string_map))
 			goto bail;
 		return j721e_rev_string_map[rev];
-
+	case JTAG_ID_PARTNO_AM62PX:
+		if (gpsw_variant >= ARRAY_SIZE(am62p_gpsw_rev_string_map))
+			goto bail;
+		return am62p_gpsw_rev_string_map[gpsw_variant];
 	default:
 		if (rev >= ARRAY_SIZE(typical_rev_string_map))
 			goto bail;
@@ -104,6 +114,48 @@ bail:
 	return "Unknown Revision";
 }
 
+static int
+soc_ti_k3_get_variant_alternate(struct udevice *dev, u32 idreg)
+{
+	void *gpsw_addr;
+	u32 jtag_dev_id;
+	void *offset;
+	u32 soc;
+
+	jtag_dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
+
+	gpsw_addr = dev_read_addr_index_ptr(dev, 1);
+	if (!gpsw_addr)
+		return -EINVAL;
+
+	switch (soc) {
+	case JTAG_ID_PARTNO_AM62PX:
+		offset = gpsw_addr + CTRLMMR_WKUP_GP_SW1_REG;
+		break;
+	default:
+		offset = gpsw_addr + CTRLMMR_WKUP_GP_SW1_REG;
+	}
+
+	return (readl(offset));
+}
+
+static bool soc_ti_k3_variant_in_gp_sw(u32 idreg)
+{
+	u32 jtag_dev_id;
+	u32 soc;
+
+	jtag_dev_id = readl(CTRLMMR_WKUP_JTAG_DEVICE_ID);
+	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
+
+	switch (soc) {
+	case JTAG_ID_PARTNO_AM62PX:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int soc_ti_k3_get_family(struct udevice *dev, char *buf, int size)
 {
 	struct soc_ti_k3_plat *plat = dev_get_plat(dev);
@@ -130,17 +182,21 @@ static const struct soc_ops soc_ti_k3_ops = {
 int soc_ti_k3_probe(struct udevice *dev)
 {
 	struct soc_ti_k3_plat *plat = dev_get_plat(dev);
-	u32 idreg;
+	u32 gp_sw1_val = 0;
 	void *idreg_addr;
+	u32 idreg;
 
-	idreg_addr = dev_read_addr_ptr(dev);
+	idreg_addr = dev_read_addr_index_ptr(dev, 0);
 	if (!idreg_addr)
 		return -EINVAL;
 
 	idreg = readl(idreg_addr);
 
+	if (soc_ti_k3_variant_in_gp_sw(idreg))
+		gp_sw1_val = soc_ti_k3_get_variant_alternate(dev, idreg);
+
 	plat->family = get_family_string(idreg);
-	plat->revision = get_rev_string(idreg);
+	plat->revision = get_rev_string(idreg, gp_sw1_val);
 
 	return 0;
 }
-- 
2.49.0

