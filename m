Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D58FC36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:46:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2048881F7E;
	Sun, 30 Mar 2025 11:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bs7QGU//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D498144A; Sun, 30 Mar 2025 11:45:41 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DB2981EC0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso621750266b.2
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327933; x=1743932733; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wU9Sl15SVPyt9gemA2sIaoAlJGaXUUDk4d5rH1SoPRo=;
 b=bs7QGU//1rs3JFV0EH9N1s1j/i9Gp+0vhkHMjm3RIckCKUhzEl8rEJ5bQoVrlJ/lOV
 WPK0mvQ++NRRrNljl4nXCbyu/PcNGhzjVz670YIsAPwgGu0QFwU6I8fBFxMhLZM9Asc6
 56wf75AwGdJxSR/FWXcrxt3ppDRUJDexIJmngGpVdP1v41EZEKQBSlDavdZhYYI9KXQd
 h24+yrtNri4UGLGyY4E9SRPGQ2NW91yz4qwU2P5ofuwCwNamKDWmEd+1VrSfJeT1+FQj
 CPYip96p43hebRRa6rhp7fcW3+MVEtmnJP0xa3j+JLkdWGOxsd2s05K20ChjlM4yfk45
 f5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327933; x=1743932733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wU9Sl15SVPyt9gemA2sIaoAlJGaXUUDk4d5rH1SoPRo=;
 b=AYunt/JKnVUns/bphBZR53UuQhgsThjM0m8DyyG7vBNsme3XFMG0CfsExhxlm6GKMQ
 wDZx9R4FgbXEdATq1VW0WdjUULslfKNgPb3EBW1rWQ/FvXSRAarDlqU1R+4Oh6mdTuaX
 Z4JVHy83Qv0b865drc5D979CNSUFJWCNqBhEKTP9zt7s9//1w5n/OWOJrHhcbHCUOyTh
 LVcJxvV3k/f3QAUWP0RCp8HCR7XK9VQbIF6dHB/jOV4vL3HPCyxAGF0NFULNkQOhgdbo
 TsARUTvXKynB0RwCho/dTsCRzqf5l7qIW9ke6v6peaopDgY+3Lu84DdK4yb/tnEmoQhP
 lctA==
X-Gm-Message-State: AOJu0Yz+6wkRnTamzB6Opi6Z0lx8Zk559yQlDz71IWo0itWUfWobcWhh
 Ogl1QDePCbax462sdNjQsJFf149yQezHsrF+pgcKqyEC/1VOxU/7
X-Gm-Gg: ASbGncu45a5mr6yaloY2QWL2VxQlGQ+rHGe3RVoZwBEcKMHfjrZh/yCg7MAiw3Du5DW
 t2v21ytuC/Pc4sYl1g1LvzNZ5xuAmOOS1YE80Gp4i+T9C2hZL/aAL2xPinaGANmtiw9yIYfGOAP
 kLmwKfpVEYR8pE5ZiCQlurGgdu4xlnbuo/GEeG2Rf2XD2SNxJa8C3BrilNZ/nXQD3PrYk7fTew0
 Kp14mALfy8LPggCDOHycOq2XC+WNIkUmFUw23h+ttSrFQJXAsUrYvZ+N6pS6y02XRhQ78yb3zDK
 oO1lYTIUjqJCQWSVsiTQWIGGeP8E9AInEY/y
X-Google-Smtp-Source: AGHT+IFUNHnGDUpVTbfL3s6ortvy4F6dRQSQkuQF4U5lDOO23UqN/i4SKhXC3eoLy40jBY2Ga2zVog==
X-Received: by 2002:a17:906:f5a2:b0:ac3:17bb:34fc with SMTP id
 a640c23a62f3a-ac738c20e31mr375268766b.52.1743327932618; 
 Sun, 30 Mar 2025 02:45:32 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71927b175sm463235866b.61.2025.03.30.02.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:45:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Geis <pgwipeout@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Anton Bambura <jenneron@protonmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/6] power: regulator: add regulator support for CPCAP PMIC
Date: Sun, 30 Mar 2025 12:45:08 +0300
Message-ID: <20250330094515.11359-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330094515.11359-1-clamor95@gmail.com>
References: <20250330094515.11359-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The driver provides regulator set/get voltage and enable/disable functions
for CPCAP PMIC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/power/pmic/cpcap.c                |  35 +++
 drivers/power/regulator/Kconfig           |   9 +
 drivers/power/regulator/Makefile          |   1 +
 drivers/power/regulator/cpcap_regulator.c | 275 ++++++++++++++++++++++
 include/power/cpcap.h                     | 135 +++++++++++
 5 files changed, 455 insertions(+)
 create mode 100644 drivers/power/regulator/cpcap_regulator.c

diff --git a/drivers/power/pmic/cpcap.c b/drivers/power/pmic/cpcap.c
index 4923255f0a7..f2076afff43 100644
--- a/drivers/power/pmic/cpcap.c
+++ b/drivers/power/pmic/cpcap.c
@@ -12,6 +12,12 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 
+static const struct pmic_child_info pmic_children_info[] = {
+	{ .prefix = "sw", .driver = CPCAP_SW_DRIVER },
+	{ .prefix = "v", .driver = CPCAP_LDO_DRIVER },
+	{ },
+};
+
 static int cpcap_write(struct udevice *dev, uint reg, const uint8_t *buff, int len)
 {
 	u8 buf[4];
@@ -47,6 +53,34 @@ static int cpcap_read(struct udevice *dev, uint reg, uint8_t *buff, int len)
 	return ret;
 }
 
+static int cpcap_bind(struct udevice *dev)
+{
+	ofnode regulators_node;
+	int children;
+
+	/* Regulator device node of PMIC */
+	regulators_node = dev_read_subnode(dev, "regulator");
+	if (!ofnode_valid(regulators_node)) {
+		log_err("%s regulator subnode not found!\n", dev->name);
+		return -ENXIO;
+	}
+
+	/* Actual regulators container */
+	regulators_node = ofnode_find_subnode(regulators_node, "regulators");
+	if (!ofnode_valid(regulators_node)) {
+		log_err("%s regulators subnode not found!\n", dev->name);
+		return -ENXIO;
+	}
+
+	debug("%s: '%s' - found regulators subnode\n", __func__, dev->name);
+
+	children = pmic_bind_children(dev, regulators_node, pmic_children_info);
+	if (!children)
+		log_err("%s - no child found\n", dev->name);
+
+	return dm_scan_fdt_dev(dev);
+}
+
 static int cpcap_probe(struct udevice *dev)
 {
 	struct spi_slave *slave = dev_get_parent_priv(dev);
@@ -85,6 +119,7 @@ U_BOOT_DRIVER(pmic_cpcap) = {
 	.name = "cpcap_pmic",
 	.id = UCLASS_PMIC,
 	.of_match = cpcap_ids,
+	.bind = cpcap_bind,
 	.probe = cpcap_probe,
 	.ops = &cpcap_ops,
 };
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 8f102a92c23..903030b329b 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -486,3 +486,12 @@ config REGULATOR_RZG2L_USBPHY
 	  Enable this option to support controlling the VBUS supply in
 	  the USB PHY peripheral of the Renesas RZ/G2L SoC. This option
 	  is required in order to use the USB OTG port.
+
+config DM_REGULATOR_CPCAP
+	bool "Enable driver for CPCAP PMIC regulators"
+	depends on DM_REGULATOR && DM_PMIC_CPCAP
+	---help---
+	Enable implementation of driver-model regulator uclass features for
+	REGULATOR CPCAP. The driver supports both DC-to-DC Step-Down Switching
+	(SW) Regulators and Low-Dropout Linear (LDO) Regulators	found in CPCAP
+	PMIC and implements get/set api for voltage and state.
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index 4382d4b3ab9..799ab792a88 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -43,3 +43,4 @@ obj-$(CONFIG_DM_REGULATOR_SCMI) += scmi_regulator.o
 obj-$(CONFIG_$(XPL_)DM_REGULATOR_ANATOP) += anatop_regulator.o
 obj-$(CONFIG_DM_REGULATOR_TPS65219) += tps65219_regulator.o
 obj-$(CONFIG_REGULATOR_RZG2L_USBPHY) += rzg2l-usbphy-regulator.o
+obj-$(CONFIG_$(XPL_)DM_REGULATOR_CPCAP) += cpcap_regulator.o
diff --git a/drivers/power/regulator/cpcap_regulator.c b/drivers/power/regulator/cpcap_regulator.c
new file mode 100644
index 00000000000..04cd6651374
--- /dev/null
+++ b/drivers/power/regulator/cpcap_regulator.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Copyright(C) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <dm.h>
+#include <power/pmic.h>
+#include <power/regulator.h>
+#include <power/cpcap.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+
+/* CPCAP_REG_ASSIGN2 bits - Resource Assignment 2 */
+#define CPCAP_BIT_VSDIO_SEL		BIT(15)
+#define CPCAP_BIT_VDIG_SEL		BIT(14)
+#define CPCAP_BIT_VCAM_SEL		BIT(13)
+#define CPCAP_BIT_SW6_SEL		BIT(12)
+#define CPCAP_BIT_SW5_SEL		BIT(11)
+#define CPCAP_BIT_SW4_SEL		BIT(10)
+#define CPCAP_BIT_SW3_SEL		BIT(9)
+#define CPCAP_BIT_SW2_SEL		BIT(8)
+#define CPCAP_BIT_SW1_SEL		BIT(7)
+
+/* CPCAP_REG_ASSIGN3 bits - Resource Assignment 3 */
+#define CPCAP_BIT_VUSBINT2_SEL		BIT(15)
+#define CPCAP_BIT_VUSBINT1_SEL		BIT(14)
+#define CPCAP_BIT_VVIB_SEL		BIT(13)
+#define CPCAP_BIT_VWLAN1_SEL		BIT(12)
+#define CPCAP_BIT_VRF1_SEL		BIT(11)
+#define CPCAP_BIT_VHVIO_SEL		BIT(10)
+#define CPCAP_BIT_VDAC_SEL		BIT(9)
+#define CPCAP_BIT_VUSB_SEL		BIT(8)
+#define CPCAP_BIT_VSIM_SEL		BIT(7)
+#define CPCAP_BIT_VRFREF_SEL		BIT(6)
+#define CPCAP_BIT_VPLL_SEL		BIT(5)
+#define CPCAP_BIT_VFUSE_SEL		BIT(4)
+#define CPCAP_BIT_VCSI_SEL		BIT(3)
+#define CPCAP_BIT_SPARE_14_2		BIT(2)
+#define CPCAP_BIT_VWLAN2_SEL		BIT(1)
+#define CPCAP_BIT_VRF2_SEL		BIT(0)
+#define CPCAP_BIT_NONE			0
+
+/* CPCAP_REG_ASSIGN4 bits - Resource Assignment 4 */
+#define CPCAP_BIT_VAUDIO_SEL		BIT(0)
+
+/*
+ * Off mode configuration bit. Used currently only by SW5 on omap4. There's
+ * the following comment in Motorola Linux kernel tree for it:
+ *
+ * When set in the regulator mode, the regulator assignment will be changed
+ * to secondary when the regulator is disabled. The mode will be set back to
+ * primary when the regulator is turned on.
+ */
+#define CPCAP_REG_OFF_MODE_SEC		BIT(15)
+
+#define CPCAP_REG(_reg, _assignment_reg, _assignment_mask, _mode_mask,		\
+		  _volt_mask, _volt_shft, _mode_val, _off_mode_val, _val_tbl,	\
+		  _mode_cntr, _volt_trans_time, _turn_on_time, _bit_offset) {	\
+	.reg = CPCAP_REG_##_reg,						\
+	.assignment_reg = CPCAP_REG_##_assignment_reg,				\
+	.assignment_mask = CPCAP_BIT_##_assignment_mask,			\
+	.mode_mask = _mode_mask,						\
+	.volt_mask = _volt_mask,						\
+	.volt_shft = _volt_shft,						\
+	.mode_val = _mode_val,							\
+	.off_mode_val = _off_mode_val,						\
+	.val_tbl_sz = ARRAY_SIZE(_val_tbl),					\
+	.val_tbl = _val_tbl,							\
+	.mode_cntr = _mode_cntr,						\
+	.volt_trans_time = _volt_trans_time,					\
+	.turn_on_time = _turn_on_time,						\
+	.bit_offset_from_cpcap_lowest_voltage = _bit_offset,			\
+}
+
+static const struct cpcap_regulator_data tegra20_regulators[CPCAP_REGULATORS_COUNT] = {
+	/* BUCK */
+	[CPCAP_SW1]      = CPCAP_REG(S1C1, ASSIGN2, SW1_SEL, 0x6f00, 0x007f,
+				     0, 0x6800, 0, sw1_val_tbl, 0, 0, 1500, 0x0c),
+	[CPCAP_SW2]      = CPCAP_REG(S2C1, ASSIGN2, SW2_SEL, 0x6f00, 0x007f,
+				     0, 0x4804, 0, sw2_sw4_val_tbl, 0, 0, 1500, 0x18),
+	[CPCAP_SW3]      = CPCAP_REG(S3C, ASSIGN2, SW3_SEL, 0x0578, 0x0003,
+				     0, 0x043c, 0, sw3_val_tbl, 0, 0, 0, 0),
+	[CPCAP_SW4]      = CPCAP_REG(S4C1, ASSIGN2, SW4_SEL, 0x6f00, 0x007f,
+				     0, 0x4909, 0, sw2_sw4_val_tbl, 0, 0, 1500, 0x18),
+	[CPCAP_SW5]      = CPCAP_REG(S5C, ASSIGN2, SW5_SEL, 0x0028, 0x0000,
+				     0, 0x0020, 0, sw5_val_tbl, 0, 0, 1500, 0),
+	[CPCAP_SW6]      = CPCAP_REG(S6C, ASSIGN2, SW6_SEL, 0x0000, 0x0000,
+				     0, 0, 0, unknown_val_tbl, 0, 0, 0, 0),
+	/* LDO */
+	[CPCAP_VCAM]     = CPCAP_REG(VCAMC, ASSIGN2, VCAM_SEL, 0x0087, 0x0030,
+				     4, 0x7, 0, vcam_val_tbl, 0, 420, 1000, 0),
+	[CPCAP_VCSI]     = CPCAP_REG(VCSIC, ASSIGN3, VCSI_SEL, 0x0047, 0x0010,
+				     4, 0x7, 0, vcsi_val_tbl, 0, 350, 1000, 0),
+	[CPCAP_VDAC]     = CPCAP_REG(VDACC, ASSIGN3, VDAC_SEL, 0x0087, 0x0030,
+				     4, 0x0, 0, vdac_val_tbl, 0, 420, 1000, 0),
+	[CPCAP_VDIG]     = CPCAP_REG(VDIGC, ASSIGN2, VDIG_SEL, 0x0087, 0x0030,
+				     4, 0x0, 0, vdig_val_tbl, 0, 420, 1000, 0),
+	[CPCAP_VFUSE]    = CPCAP_REG(VFUSEC, ASSIGN3, VFUSE_SEL, 0x00a0, 0x000f,
+				     0, 0x0, 0, vfuse_val_tbl, 0, 420, 1000, 0),
+	[CPCAP_VHVIO]    = CPCAP_REG(VHVIOC, ASSIGN3, VHVIO_SEL, 0x0017, 0x0000,
+				     0, 0x2, 0, vhvio_val_tbl, 0, 0, 1000, 0),
+	[CPCAP_VSDIO]    = CPCAP_REG(VSDIOC, ASSIGN2, VSDIO_SEL, 0x0087, 0x0038,
+				     3, 0x2, 0, vsdio_val_tbl, 0, 420, 1000, 0),
+	[CPCAP_VPLL]     = CPCAP_REG(VPLLC, ASSIGN3, VPLL_SEL, 0x0047, 0x0018,
+				     3, 0x1, 0, vpll_val_tbl, 0, 420, 100, 0),
+	[CPCAP_VRF1]     = CPCAP_REG(VRF1C, ASSIGN3, VRF1_SEL, 0x00ac, 0x0002,
+				     1, 0x0, 0, vrf1_val_tbl, 0, 10, 1000, 0),
+	[CPCAP_VRF2]     = CPCAP_REG(VRF2C, ASSIGN3, VRF2_SEL, 0x0023, 0x0008,
+				     3, 0x0, 0, vrf2_val_tbl, 0, 10, 1000, 0),
+	[CPCAP_VRFREF]   = CPCAP_REG(VRFREFC, ASSIGN3, VRFREF_SEL, 0x0023, 0x0008,
+				     3, 0x0, 0, vrfref_val_tbl, 0, 420, 100, 0),
+	[CPCAP_VWLAN1]   = CPCAP_REG(VWLAN1C, ASSIGN3, VWLAN1_SEL, 0x0047, 0x0010,
+				     4, 0x0, 0, vwlan1_val_tbl, 0, 420, 1000, 0),
+	[CPCAP_VWLAN2]   = CPCAP_REG(VWLAN2C, ASSIGN3, VWLAN2_SEL, 0x020c, 0x00c0,
+				     6, 0xd, 0, vwlan2_val_tbl, 0, 420, 1000, 0),
+	[CPCAP_VSIM]     = CPCAP_REG(VSIMC, ASSIGN3, NONE, 0x0023, 0x0008,
+				     3, 0x0, 0, vsim_val_tbl, 0, 420, 1000, 0),
+	[CPCAP_VSIMCARD] = CPCAP_REG(VSIMC, ASSIGN3, NONE, 0x1e80, 0x0008,
+				     3, 0x1E00, 0, vsimcard_val_tbl, 0, 420, 1000, 0),
+	[CPCAP_VVIB]     = CPCAP_REG(VVIBC, ASSIGN3, VVIB_SEL, 0x0001, 0x000c,
+				     2, 0x1, 0, vvib_val_tbl, 0, 500, 500, 0),
+	[CPCAP_VUSB]     = CPCAP_REG(VUSBC, ASSIGN3, VUSB_SEL, 0x011c, 0x0040,
+				     6, 0xc, 0, vusb_val_tbl, 0, 0, 1000, 0),
+	[CPCAP_VAUDIO]   = CPCAP_REG(VAUDIOC, ASSIGN4, VAUDIO_SEL, 0x0016, 0x0001,
+				     0, 0x5, 0, vaudio_val_tbl, 0, 0, 1000, 0),
+};
+
+static int cpcap_regulator_get_value(struct udevice *dev)
+{
+	const struct cpcap_regulator_data *regulator =
+					&tegra20_regulators[dev->driver_data];
+	int value, volt_shift = regulator->volt_shft;
+
+	value = pmic_reg_read(dev->parent, regulator->reg);
+	if (value < 0)
+		return value;
+
+	if (!(value & regulator->mode_mask))
+		return 0;
+
+	value &= regulator->volt_mask;
+	value -= regulator->bit_offset_from_cpcap_lowest_voltage;
+
+	return regulator->val_tbl[value >> volt_shift];
+}
+
+static int cpcap_regulator_set_value(struct udevice *dev, int uV)
+{
+	const struct cpcap_regulator_data *regulator =
+					&tegra20_regulators[dev->driver_data];
+	int value, ret, volt_shift = regulator->volt_shft;
+
+	if (dev->driver_data == CPCAP_VRF1) {
+		if (uV > 2500000)
+			value = 0;
+		else
+			value = regulator->volt_mask;
+	} else {
+		for (value = 0; value < regulator->val_tbl_sz; value++)
+			if (regulator->val_tbl[value] >= uV)
+				break;
+
+		if (value >= regulator->val_tbl_sz)
+			value = regulator->val_tbl_sz;
+
+		value <<= volt_shift;
+		value += regulator->bit_offset_from_cpcap_lowest_voltage;
+	}
+
+	ret = pmic_clrsetbits(dev->parent, regulator->reg, regulator->volt_mask,
+			      value);
+	if (ret)
+		return ret;
+
+	if (regulator->volt_trans_time)
+		udelay(regulator->volt_trans_time);
+
+	return 0;
+}
+
+static int cpcap_regulator_get_enable(struct udevice *dev)
+{
+	const struct cpcap_regulator_data *regulator =
+					&tegra20_regulators[dev->driver_data];
+	int value;
+
+	value = pmic_reg_read(dev->parent, regulator->reg);
+	if (value < 0)
+		return value;
+
+	return (value & regulator->mode_mask) ? 1 : 0;
+}
+
+static int cpcap_regulator_set_enable(struct udevice *dev, bool enable)
+{
+	const struct cpcap_regulator_data *regulator =
+					&tegra20_regulators[dev->driver_data];
+	int ret;
+
+	if (enable) {
+		ret = pmic_clrsetbits(dev->parent, regulator->reg, regulator->mode_mask,
+				      regulator->mode_val);
+		if (ret)
+			return ret;
+	}
+
+	if (regulator->mode_val & CPCAP_REG_OFF_MODE_SEC) {
+		ret = pmic_clrsetbits(dev->parent, regulator->assignment_reg,
+				      regulator->assignment_mask,
+				      enable ? 0 : regulator->assignment_mask);
+		if (ret)
+			return ret;
+	}
+
+	if (!enable) {
+		ret = pmic_clrsetbits(dev->parent, regulator->reg, regulator->mode_mask,
+				      regulator->off_mode_val);
+		if (ret)
+			return ret;
+	}
+
+	if (regulator->turn_on_time)
+		udelay(regulator->turn_on_time);
+
+	return 0;
+}
+
+static int cpcap_regulator_probe(struct udevice *dev)
+{
+	struct dm_regulator_uclass_plat *uc_pdata = dev_get_uclass_plat(dev);
+	int id;
+
+	for (id = 0; id < CPCAP_REGULATORS_COUNT; id++)
+		if (cpcap_regulator_to_name[id])
+			if (!strcmp(dev->name, cpcap_regulator_to_name[id]))
+				break;
+
+	switch (id) {
+	case CPCAP_SW1 ... CPCAP_SW6:
+		uc_pdata->type = REGULATOR_TYPE_BUCK;
+		break;
+
+	case CPCAP_VCAM ... CPCAP_VAUDIO:
+		uc_pdata->type = REGULATOR_TYPE_LDO;
+		break;
+
+	default:
+		log_err("CPCAP: Invalid regulator ID\n");
+		return -ENODEV;
+	}
+
+	dev->driver_data = id;
+	return 0;
+}
+
+static const struct dm_regulator_ops cpcap_regulator_ops = {
+	.get_value  = cpcap_regulator_get_value,
+	.set_value  = cpcap_regulator_set_value,
+	.get_enable = cpcap_regulator_get_enable,
+	.set_enable = cpcap_regulator_set_enable,
+};
+
+U_BOOT_DRIVER(cpcap_sw) = {
+	.name = CPCAP_SW_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &cpcap_regulator_ops,
+	.probe = cpcap_regulator_probe,
+};
+
+U_BOOT_DRIVER(cpcap_ldo) = {
+	.name = CPCAP_LDO_DRIVER,
+	.id = UCLASS_REGULATOR,
+	.ops = &cpcap_regulator_ops,
+	.probe = cpcap_regulator_probe,
+};
diff --git a/include/power/cpcap.h b/include/power/cpcap.h
index ecc0ece6518..bb0e28cec55 100644
--- a/include/power/cpcap.h
+++ b/include/power/cpcap.h
@@ -235,4 +235,139 @@
 
 #define CPCAP_REG_ST_TEST2	0x7d18	/* ST Test2 */
 
+/* Drivers name */
+#define CPCAP_LDO_DRIVER	"cpcap_ldo"
+#define CPCAP_SW_DRIVER		"cpcap_sw"
+
+enum cpcap_regulator_id {
+	CPCAP_SW1,
+	CPCAP_SW2,
+	CPCAP_SW3,
+	CPCAP_SW4,
+	CPCAP_SW5,
+	CPCAP_SW6,
+	CPCAP_VCAM,
+	CPCAP_VCSI,
+	CPCAP_VDAC,
+	CPCAP_VDIG,
+	CPCAP_VFUSE,
+	CPCAP_VHVIO,
+	CPCAP_VSDIO,
+	CPCAP_VPLL,
+	CPCAP_VRF1,
+	CPCAP_VRF2,
+	CPCAP_VRFREF,
+	CPCAP_VWLAN1,
+	CPCAP_VWLAN2,
+	CPCAP_VSIM,
+	CPCAP_VSIMCARD,
+	CPCAP_VVIB,
+	CPCAP_VUSB,
+	CPCAP_VAUDIO,
+	CPCAP_REGULATORS_COUNT,
+};
+
+static const char * const cpcap_regulator_to_name[] = {
+	/* BUCK */
+	[CPCAP_SW1] = "sw1",
+	[CPCAP_SW2] = "sw2",
+	[CPCAP_SW3] = "sw3",
+	[CPCAP_SW4] = "sw4",
+	[CPCAP_SW5] = "sw5",
+	[CPCAP_SW6] = "sw6",
+	/* LDO */
+	[CPCAP_VCAM] = "vcam",
+	[CPCAP_VCSI] = "vcsi",
+	[CPCAP_VDAC] = "vdac",
+	[CPCAP_VDIG] = "vdig",
+	[CPCAP_VFUSE] = "vfuse",
+	[CPCAP_VHVIO] = "vhvio",
+	[CPCAP_VSDIO] = "vsdio",
+	[CPCAP_VPLL] = "vpll",
+	[CPCAP_VRF1] = "vrf1",
+	[CPCAP_VRF2] = "vrf2",
+	[CPCAP_VRFREF] = "vrfref",
+	[CPCAP_VWLAN1] = "vwlan1",
+	[CPCAP_VWLAN2] = "vwlan2",
+	[CPCAP_VSIM] = "vsim",
+	[CPCAP_VSIMCARD] = "vsimcard",
+	[CPCAP_VVIB] = "vvib",
+	[CPCAP_VUSB] = "vusb",
+	[CPCAP_VAUDIO] = "vaudio",
+};
+
+static const u32 unknown_val_tbl[] = { 0, };
+static const u32 sw1_val_tbl[] = { 750000, 762500, 775000, 787500, 800000,
+				   812500, 825000, 837500, 850000, 862500,
+				   875000, 887500, 900000, 912500, 925000,
+				   937500, 950000, 962500, 975000, 987500,
+				   1000000, 1012500, 1025000, 1037500,
+				   1050000, 1062500, 1075000, 1087500,
+				   1100000, 1112500, 1125000, 1137500,
+				   1150000, 1162500, 1175000, 1187500,
+				   1200000, 1212500, 1225000, 1237500,
+				   1250000, 1262500, 1275000, 1287500,
+				   1300000, 1312500, 1325000, 1337500,
+				   1350000, 1362500, 1375000, 1387500,
+				   1400000, 1412500, 1425000, 1437500,
+				   1450000, 1462500, 1475000 };
+static const u32 sw2_sw4_val_tbl[] = { 900000, 912500, 925000, 937500, 950000,
+				       962500, 975000, 987500, 1000000, 1012500,
+				       1025000, 1037500, 1050000, 1062500,
+				       1075000, 1087500, 1100000, 1112500,
+				       1125000, 1137500, 1150000, 1162500,
+				       1175000, 1187500, 1200000, 1212500,
+				       1225000, 1237500, 1250000, 1262500,
+				       1275000, 1287500, 1300000, 1312500,
+				       1325000, 1337500, 1350000, 1362500,
+				       1375000, 1387500, 1400000, 1412500,
+				       1425000, 1437500, 1450000, 1462500,
+				       1475000 };
+static const u32 sw3_val_tbl[] = { 1350000, 1800000, 1850000, 1875000 };
+static const u32 sw5_val_tbl[] = { 0, 5050000 };
+static const u32 vcam_val_tbl[] = { 2600000, 2700000, 2800000, 2900000 };
+static const u32 vcsi_val_tbl[] = { 1200000, 1800000 };
+static const u32 vdac_val_tbl[] = { 1200000, 1500000, 1800000, 2500000 };
+static const u32 vdig_val_tbl[] = { 1200000, 1350000, 1500000, 1875000 };
+static const u32 vfuse_val_tbl[] = { 1500000, 1600000, 1700000, 1800000, 1900000,
+				     2000000, 2100000, 2200000, 2300000, 2400000,
+				     2500000, 2600000, 2700000, 3150000 };
+static const u32 vhvio_val_tbl[] = { 2775000 };
+static const u32 vsdio_val_tbl[] = { 1500000, 1600000, 1800000, 2600000,
+				     2700000, 2800000, 2900000, 3000000 };
+static const u32 vpll_val_tbl[] = { 1200000, 1300000, 1400000, 1800000 };
+static const u32 vrf1_val_tbl[] = { 2775000, 2500000 }; /* Yes, this is correct */
+static const u32 vrf2_val_tbl[] = { 0, 2775000 };
+static const u32 vrfref_val_tbl[] = { 2500000, 2775000 };
+static const u32 vwlan1_val_tbl[] = { 1800000, 1900000 };
+static const u32 vwlan2_val_tbl[] = { 2775000, 3000000, 3300000, 3300000 };
+static const u32 vsim_val_tbl[] = { 1800000, 2900000 };
+static const u32 vsimcard_val_tbl[] = { 1800000, 2900000 };
+static const u32 vvib_val_tbl[] = { 1300000, 1800000, 2000000, 3000000 };
+static const u32 vusb_val_tbl[] = { 0, 3300000 };
+static const u32 vaudio_val_tbl[] = { 0, 2775000 };
+
+struct cpcap_regulator_data {
+	u16 reg;
+	u16 assignment_reg;
+	u16 assignment_mask;
+	u16 mode_mask;
+	u16 volt_mask;
+	u8 volt_shft;
+	u16 mode_val;
+	u16 off_mode_val;
+	u32 val_tbl_sz;
+	const u32 *val_tbl;
+	u32 mode_cntr;
+	u32 volt_trans_time; /* in micro seconds */
+	u32 turn_on_time; /* in micro seconds */
+
+	/*
+	 * Bit difference between lowest value in val_tbl and start of voltage
+	 * table setting in cpcap. Use this for switchers that have many too
+	 * many voltages to list in val_tbl.
+	 */
+	u32 bit_offset_from_cpcap_lowest_voltage;
+};
+
 #endif /* _CPCAP_H_ */
-- 
2.43.0

