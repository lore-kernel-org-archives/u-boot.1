Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD56E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 14:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 197EE80714;
	Tue, 14 Jan 2025 15:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kEmyr7HU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A5F780714; Tue, 14 Jan 2025 15:47:11 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503C580657
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 15:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=31090870d4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ED877D012061;
 Tue, 14 Jan 2025 15:47:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 kfyP0yWrORt8BTNvQJr/Z4Wuus68i3W4OsmAZq5xZQs=; b=kEmyr7HUrhC4fM1m
 8xYEzy09OjM4oy9FW+ZR2Bj9y0uOS2chNPh/0f2Xcxl7BqCa4tw2CFEObNIDPsjW
 l+h0wfIfGD8TqmTJZpXG9Nrb0dBS5zYOtkEj568aqIvmZmxh6PFGj8brTiKxl3L4
 8burauv3ninBwO88lvq/K9aKiZPnn+kLnw79AHL5099bTS9BGSBSf8qAyz4WYvM1
 zBiey0lOmjCjR4XdTGCNKlQYhAZJzr8/I6yM0nMSr51GjxmZPXDN1SWv71W2/B4/
 Kkyyfw3ZZqhHt1lLhrp7Tp/Z1YAs1RsxeyE0fhk/apLgfmWHzvOhzALyt+uXaPRI
 RUa8lg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4453a7wak4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jan 2025 15:47:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 22FF440046;
 Tue, 14 Jan 2025 15:46:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BBD9C2ABA72;
 Tue, 14 Jan 2025 15:45:34 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 14 Jan
 2025 15:45:34 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut <marex@denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jan Kiszka
 <jan.kiszka@siemens.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/10] usb: dwc3-generic: Add STih407 support
Date: Tue, 14 Jan 2025 15:45:22 +0100
Message-ID: <20250114144528.1612168-5-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
References: <20250114144528.1612168-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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

Add STi glue logic to manage the DWC3 HC on STiH407
SoC family. It configures the internal glue logic and
syscfg registers.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Marek Vasut <marex@denx.de>
---

 drivers/usb/dwc3/dwc3-generic.c | 108 ++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index cb96e1f344f..0cd03bf0787 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -14,7 +14,9 @@
 #include <generic-phy.h>
 #include <log.h>
 #include <malloc.h>
+#include <regmap.h>
 #include <reset.h>
+#include <syscon.h>
 #include <usb.h>
 #include <asm/gpio.h>
 #include <dm/device-internal.h>
@@ -511,6 +513,111 @@ struct dwc3_glue_ops rk_ops = {
 	.glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
 };
 
+void dwc3_stih407_glue_configure(struct udevice *dev, int index,
+				 enum usb_dr_mode mode)
+{
+/* glue registers */
+#define CLKRST_CTRL		0x00
+#define AUX_CLK_EN		BIT(0)
+#define SW_PIPEW_RESET_N	BIT(4)
+#define EXT_CFG_RESET_N		BIT(8)
+
+#define XHCI_REVISION		BIT(12)
+
+#define USB2_VBUS_MNGMNT_SEL1	0x2C
+#define USB2_VBUS_UTMIOTG	0x1
+
+#define SEL_OVERRIDE_VBUSVALID(n)	((n) << 0)
+#define SEL_OVERRIDE_POWERPRESENT(n)	((n) << 4)
+#define SEL_OVERRIDE_BVALID(n)		((n) << 8)
+
+/* Static DRD configuration */
+#define USB3_CONTROL_MASK		0xf77
+
+#define USB3_DEVICE_NOT_HOST		BIT(0)
+#define USB3_FORCE_VBUSVALID		BIT(1)
+#define USB3_DELAY_VBUSVALID		BIT(2)
+#define USB3_SEL_FORCE_OPMODE		BIT(4)
+#define USB3_FORCE_OPMODE(n)		((n) << 5)
+#define USB3_SEL_FORCE_DPPULLDOWN2	BIT(8)
+#define USB3_FORCE_DPPULLDOWN2		BIT(9)
+#define USB3_SEL_FORCE_DMPULLDOWN2	BIT(10)
+#define USB3_FORCE_DMPULLDOWN2		BIT(11)
+
+	struct dwc3_glue_data *glue = dev_get_plat(dev);
+	struct regmap *regmap;
+	ulong syscfg_base;
+	ulong syscfg_offset;
+	ulong glue_base;
+	u32 reg;
+	int ret;
+
+	/* deassert both powerdown and softreset */
+	ret = reset_deassert_bulk(&glue->resets);
+	if (ret) {
+		debug("reset_deassert_bulk error: %d\n", ret);
+		return;
+	}
+
+	regmap = syscon_regmap_lookup_by_phandle(dev, "st,syscfg");
+
+	syscfg_base = regmap->ranges[0].start;
+	glue_base = dev_read_addr_index(dev, 0);
+	syscfg_offset = dev_read_addr_index(dev, 1);
+
+	reg = readl(syscfg_base + syscfg_offset);
+	reg &= USB3_CONTROL_MASK;
+
+	/* glue drd init */
+	switch (mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		reg &= ~(USB3_DELAY_VBUSVALID
+			| USB3_SEL_FORCE_OPMODE | USB3_FORCE_OPMODE(0x3)
+			| USB3_SEL_FORCE_DPPULLDOWN2 | USB3_FORCE_DPPULLDOWN2
+			| USB3_SEL_FORCE_DMPULLDOWN2 | USB3_FORCE_DMPULLDOWN2);
+
+		reg |= USB3_DEVICE_NOT_HOST | USB3_FORCE_VBUSVALID;
+		break;
+
+	case USB_DR_MODE_HOST:
+		reg &= ~(USB3_DEVICE_NOT_HOST | USB3_FORCE_VBUSVALID
+			| USB3_SEL_FORCE_OPMODE	| USB3_FORCE_OPMODE(0x3)
+			| USB3_SEL_FORCE_DPPULLDOWN2 | USB3_FORCE_DPPULLDOWN2
+			| USB3_SEL_FORCE_DMPULLDOWN2 | USB3_FORCE_DMPULLDOWN2);
+
+		reg |= USB3_DELAY_VBUSVALID;
+		break;
+
+	default:
+		debug("Unsupported mode of operation %d\n", mode);
+		return;
+	}
+	writel(reg, syscfg_base + syscfg_offset);
+
+	/* glue init */
+	reg = readl(glue_base + CLKRST_CTRL);
+
+	reg |= AUX_CLK_EN | EXT_CFG_RESET_N | XHCI_REVISION;
+	reg &= ~SW_PIPEW_RESET_N;
+
+	writel(reg, glue_base + CLKRST_CTRL);
+
+	/* configure mux for vbus, powerpresent and bvalid signals */
+	reg = readl(glue_base + USB2_VBUS_MNGMNT_SEL1);
+
+	reg |= SEL_OVERRIDE_VBUSVALID(USB2_VBUS_UTMIOTG) |
+	       SEL_OVERRIDE_POWERPRESENT(USB2_VBUS_UTMIOTG) |
+	       SEL_OVERRIDE_BVALID(USB2_VBUS_UTMIOTG);
+
+	writel(reg, glue_base + USB2_VBUS_MNGMNT_SEL1);
+
+	setbits_le32(glue_base + CLKRST_CTRL, SW_PIPEW_RESET_N);
+};
+
+struct dwc3_glue_ops stih407_ops = {
+	.glue_configure = dwc3_stih407_glue_configure,
+};
+
 static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
 {
 	const char *name = ofnode_get_name(node);
@@ -714,6 +821,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
 	{ .compatible = "fsl,imx8mq-dwc3" },
 	{ .compatible = "intel,tangier-dwc3" },
+	{ .compatible = "st,stih407-dwc3", .data = (ulong)&stih407_ops},
 	{ }
 };
 
-- 
2.25.1

