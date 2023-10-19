Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D69CCDB483
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 07:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C947287184;
	Thu, 19 Oct 2023 09:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BzUIbxGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1805687188; Thu, 19 Oct 2023 09:28:27 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823AD87178
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 09:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39J7SJO7088281;
 Thu, 19 Oct 2023 02:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697700499;
 bh=eur/mbNvncsWslTz8xy4CkBi+e43XnBrNJ164kNTWoQ=;
 h=From:To:CC:Subject:Date;
 b=BzUIbxGmUB6F7quNG46bmTmprqhZTohrpoHdT/7YFCRzedNl8TjG6A6x2cJtGMHIT
 8TxyMP2FEC6/vXkVOKhygZ4MX/JJYH4D6zNrMkYKzrJh6KHYaZVjNeuPovQrZRSsjy
 GnvjwFlUTYgqaVuSga8spLQZyAXrPH5oHhDZSpGA=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39J7SJqw016831
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 19 Oct 2023 02:28:19 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Oct 2023 02:28:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Oct 2023 02:28:19 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39J7SFkv117646;
 Thu, 19 Oct 2023 02:28:16 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>
CC: <peng.fan@nxp.com>, <ye.li@nxp.com>, <robimarko@gmail.com>,
 <u-boot@lists.denx.de>, <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v3] driver: misc: k3_avs: Add support for thermal shutdown
Date: Thu, 19 Oct 2023 12:57:53 +0530
Message-ID: <20231019072752.1330935-1-u-kumar1@ti.com>
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

To avoid thermal burn out, program thermal shutdown
value in VTM (Voltage and Thermal Manager) IP.

Part of Linux kernel driver (drivers/thermal/k3_j72xx_bandgap.c)
is ported from kernel 6.6-rc1, which sets thermal shutdown values.
 
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Neha Francis <n-francis@ti.com>
---
Change log:

Changes in v3:
- Ported only needed functionality from kernel driver to program tshut
- Removed support for temp from u-boot shell
- Appended Sign-off list

v2:https://lore.kernel.org/all/20230908172914.436194-2-u-kumar1@ti.com/
 

Changes in v2:
- Trying to merge AVS and kernel driver into 1
- Mark as RFC
v1 : https://lore.kernel.org/all/20230901061500.2342452-1-u-kumar1@ti.com/

 drivers/misc/k3_avs.c | 104 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index acfc731845..9a088244dd 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -15,6 +15,7 @@
 #include <k3-avs.h>
 #include <dm/device_compat.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <power/regulator.h>
 
 #define AM6_VTM_DEVINFO(i)	(priv->base + 0x100 + 0x20 * (i))
@@ -25,11 +26,28 @@
 #define AM6_VTM_OPP_SHIFT(opp)	(8 * (opp))
 #define AM6_VTM_OPP_MASK	0xff
 
+#define K3_VTM_DEVINFO_PWR0_OFFSET		0x4
+#define K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK	0xf0
+#define K3_VTM_TMPSENS0_CTRL_OFFSET		0x300
+#define K3_VTM_TMPSENS_STAT_OFFSET		0x8
+#define K3_VTM_ANYMAXT_OUTRG_ALERT_EN		0x1
+#define K3_VTM_LOW_TEMP_OFFSET			0x10
+#define K3_VTM_MISC_CTRL2_OFFSET		0x10
+#define K3_VTM_MISC_CTRL1_OFFSET		0xc
+#define K3_VTM_TMPSENS_CTRL1_SOC		BIT(5)
+#define K3_VTM_TMPSENS_CTRL_CLRZ		BIT(6)
+#define K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN	BIT(11)
+#define K3_VTM_ADC_COUNT_FOR_123C		0x2f8
+#define K3_VTM_ADC_COUNT_FOR_105C		0x288
+#define K3_VTM_ADC_WA_VALUE			0x2c
+#define K3_VTM_FUSE_MASK			0xc0000000
+
 #define VD_FLAG_INIT_DONE	BIT(0)
 
 struct k3_avs_privdata {
 	void *base;
 	struct vd_config *vd_config;
+	struct udevice *dev;
 };
 
 struct opp {
@@ -237,6 +255,88 @@ static int k3_avs_configure(struct udevice *dev, struct k3_avs_privdata *priv)
 	return 0;
 }
 
+/* k3_avs_program_tshut : Program thermal shutdown value for SOC
+ * set the values corresponding to thresholds to ~123C and 105C
+ * This is optional feature, Few times OS driver takes care of
+ * tshut programing.
+ */
+
+static void k3_avs_program_tshut(struct k3_avs_privdata *priv)
+{
+	int cnt, id, val;
+	int workaround_needed = 0;
+	u32 ctrl_offset;
+	void __iomem *cfg2_base;
+	void __iomem *fuse_base;
+
+	cfg2_base = (void __iomem *)devfdt_get_addr_index(priv->dev, 1);
+	if (IS_ERR(cfg2_base)) {
+		dev_err(priv->dev, "cfg base is not defined\n");
+		return;
+	}
+
+	/*
+	 * Some of TI's J721E SoCs require a software trimming procedure
+	 * for the temperature monitors to function properly. To determine
+	 * if this particular SoC is NOT affected, both bits in the
+	 * WKUP_SPARE_FUSE0[31:30] will be set (0xC0000000) indicating
+	 * when software trimming should NOT be applied.
+	 *
+	 * https://www.ti.com/lit/er/sprz455c/sprz455c.pdf
+	 * This routine checks if workaround_needed to be applied or not
+	 * based upon workaround_needed, adjust fixed value of tshut high and low
+	 */
+
+	if (device_is_compatible(priv->dev, "ti,j721e-vtm")) {
+		fuse_base = (void __iomem *)devfdt_get_addr_index(priv->dev, 2);
+		if (IS_ERR(fuse_base)) {
+			dev_err(priv->dev, "fuse-base is not defined for J721E Soc\n");
+			return;
+		}
+
+		if (!((readl(fuse_base) & K3_VTM_FUSE_MASK) == K3_VTM_FUSE_MASK))
+			workaround_needed = 1;
+	}
+
+	dev_dbg(priv->dev, "Work around %sneeded\n", workaround_needed ? "" : "not ");
+
+	/* Get the sensor count in the VTM */
+	val = readl(priv->base + K3_VTM_DEVINFO_PWR0_OFFSET);
+	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
+	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
+
+	/* Program the thermal sensors */
+	for (id = 0; id < cnt; id++) {
+		ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET + id * 0x20;
+
+		val = readl(cfg2_base + ctrl_offset);
+		val |= (K3_VTM_TMPSENS_CTRL_MAXT_OUTRG_EN |
+			K3_VTM_TMPSENS_CTRL1_SOC |
+			K3_VTM_TMPSENS_CTRL_CLRZ | BIT(4));
+		writel(val, cfg2_base + ctrl_offset);
+	}
+
+	/*
+	 * Program TSHUT thresholds
+	 * Step 1: set the thresholds to ~123C and 105C WKUP_VTM_MISC_CTRL2
+	 * Step 2: WKUP_VTM_TMPSENS_CTRL_j set the MAXT_OUTRG_EN  bit
+	 *         This is already taken care as per of init
+	 * Step 3: WKUP_VTM_MISC_CTRL set the ANYMAXT_OUTRG_ALERT_EN  bit
+	 */
+
+	/* Low thresholds for tshut*/
+	val = (K3_VTM_ADC_COUNT_FOR_105C - workaround_needed * K3_VTM_ADC_WA_VALUE)
+		<< K3_VTM_LOW_TEMP_OFFSET;
+	/* high thresholds */
+	val |= K3_VTM_ADC_COUNT_FOR_123C - workaround_needed * K3_VTM_ADC_WA_VALUE;
+
+	writel(val, cfg2_base + K3_VTM_MISC_CTRL2_OFFSET);
+	/* ramp-up delay from Linux code */
+	mdelay(100);
+	val = readl(cfg2_base + K3_VTM_MISC_CTRL1_OFFSET) | K3_VTM_ANYMAXT_OUTRG_ALERT_EN;
+	writel(val, cfg2_base + K3_VTM_MISC_CTRL1_OFFSET);
+}
+
 /**
  * k3_avs_probe: parses VD info from VTM, and re-configures the OPP data
  *
@@ -255,6 +355,7 @@ static int k3_avs_probe(struct udevice *dev)
 	int ret;
 
 	priv = dev_get_priv(dev);
+	priv->dev = dev;
 
 	k3_avs_priv = priv;
 
@@ -294,6 +395,9 @@ static int k3_avs_probe(struct udevice *dev)
 		k3_avs_program_voltage(priv, vd, vd->opp);
 	}
 
+	if (!device_is_compatible(priv->dev, "ti,am654-avs"))
+		k3_avs_program_tshut(priv);
+
 	return 0;
 }
 
-- 
2.34.1

