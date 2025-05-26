Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B68AC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 09:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5712F8006D;
	Mon, 26 May 2025 11:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UEnhbtW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013F180584; Mon, 26 May 2025 11:32:15 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D78C8004F
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 11:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54PMuTnA025125
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NQ40DO0GF5K
 fQRwRLyfYdoFnywdWW3ZAHPYl3nyO4s4=; b=UEnhbtW8zCADYGAcSfE2mfpLlc7
 iX+QC9w6J2ILSzvnwEQIsU2yF3OXAyTGAwrpEvek761pNLOuJ2clN0oAIvm0oaea
 PH4I+BjsVgngZrHgY9iZyDhf4qgpg+YxdjQ3golrAsJLG0FKIP8AoKwFesRltH5g
 fqOIJDCCaRAtm+8e3GhbugC95rGioMW+U9kgVLAvfmfAhAWrZ/1vC/9eQ5kOsOG8
 Sky0OD2Otak46jHvJpmwsSihfEApY47mvyXlvvASVhvzmkzWnqTgeqKhVEi479gY
 ZEc4ikOOfKjkgvFrTyK+hVQTY/do8x5/orqCIv76jcorrIwcQGAqrkhMHLw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46u79p3p5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 09:32:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-23443196f00so18222385ad.1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 02:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251929; x=1748856729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQ40DO0GF5KfQRwRLyfYdoFnywdWW3ZAHPYl3nyO4s4=;
 b=v3qzvRNfUDGtuP/mexHCIHt48o9ehaASUFUY/XZsl+puLlfBWuSy9GFIV04GHrQ4o2
 ll2lNAwx/BdJJ2IIeAv1h2VlcUi/E215gv729L9oSb7nGOQQ5auICkFStj8MyFvfpHH+
 LGf3jzkQHCIkOhN5pyes8uFNcHC/n+GUHtM4AyiWy5pkJ4atQKScwxKr6KIFYZDyamwB
 j/n8qlwDzObEpseiShAQWh5q+/XjuL0ByErwr4nDg3x2PNy8aZH0EegViVHHXqzg7s5f
 c/t9qQpQvipTqTKIV2TqnpckXI1op+nONa/PS+E1zQgPzVz/NEXcSOdsDdnaQWdHk7oF
 HRuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbo0zfA3xe7uAhruOVtWCRRL2ufD1G5CfxsdNwRYz+ov8xNpAhvtZ3cGZS4qbm20mIR+hudRk=@lists.denx.de
X-Gm-Message-State: AOJu0YypAPBCGQkPqDrA2aq7UvHwEM0RloMc6gsy8ATAVH1l8zRk6sbc
 wVuQxZSt24Gou68uccf1GjmPXEU5GjRfPadpi55qDB9Lskg9U+YSwEyB+HFiFqniUSyjSNrFYPo
 o9WG/4huLV8ydpM6tWIUasnf3GQnUN7f2BOngfttcY9jVW3ZGTc0FtIme
X-Gm-Gg: ASbGncuMuj8KwGQVD/b9L+/8RkmgUlrEyBk+rG+mDxzjX3vHHulq9IVsFCiWFj3t7WD
 P1H98mI7V9LvkiqfHAZPV5zA4Mzs3YtWjY7Iphlap50hsRI1anv3ySW3NJpxVhHy34+7GJlFuot
 tuefQrcV9QsaJUyv2ZqAKZq/e699sRzNBGPjxQNkeA4ln7jEf/g4Tj7+APYfa8CaScvsvPZ7HiS
 cXIFaQQTtAlVp6jPSwXOZ6jyIgRx+/0UI/wLVlg1c7AI1/+MSeouUWq410RRBWyBvXCxAb7r34l
 ScBnav60obqNZXTTKlL+MPH+PWVS6AuDFKrxwuiE8YwUuOcxPmtZZMmlDNsGkJzPSReBmKHrPQX
 7uIqpry3s55lMSWvQllga0WbUefVmPoWgnZUD/gay
X-Received: by 2002:a17:902:da8b:b0:224:c46:d166 with SMTP id
 d9443c01a7336-23414fafe1emr142579725ad.40.1748251929196; 
 Mon, 26 May 2025 02:32:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERUhSor9F85H10X5Hi+W6E8Ww3+odIyDOqU7t9b4kixRltxPlAOWUTh5Yib3M02Xi7IaALHA==
X-Received: by 2002:a17:902:da8b:b0:224:c46:d166 with SMTP id
 d9443c01a7336-23414fafe1emr142579285ad.40.1748251928710; 
 Mon, 26 May 2025 02:32:08 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-233ff290d45sm46633845ad.153.2025.05.26.02.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 02:32:08 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, sr@denx.de, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 jonas@kwiboo.se, jerome.forissier@linaro.org, raymond.mao@linaro.org,
 ravi@prevas.dk, hs@denx.de, arturs.artamonovs@analog.com,
 devarsht@ti.com, nathan.morrison@timesys.com,
 balaji.selvanathan@oss.qualcomm.com, bastien.curutchet@bootlin.com,
 ian.roberts@timesys.com, festevam@gmail.com,
 vasileios.bimpikas@analog.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v1 1/2] drivers: watchdog: Add Qualcomm Watchdog Driver Support
Date: Mon, 26 May 2025 15:01:52 +0530
Message-Id: <20250526093153.3387410-2-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526093153.3387410-1-balaji.selvanathan@oss.qualcomm.com>
References: <20250526093153.3387410-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iBNI8F8uHLNm0FTe3FTH9fWSqsuNI5Pf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDA4MCBTYWx0ZWRfX1ewORcEt09t2
 sjNZfnn91ww8G9Z2Qt7JqKfFjQeMOAT2BU0A/s3goDf1SQJbgYQgCQjFqihZ6P9eo2rHLb5UCgM
 0rF02stdXZ/VDpfYvR77DFJlVF/KJaWHkwYivDlniiaqPT5W/p66aecCRZ56EMOCgWM40h+U9zr
 rNPMsVwTmAwpU6dIrrMEhO0zthtCG9m4R1BPKZxnxkNB6tLsaskkEM4hd+90qrrVH59YpcSbgFI
 kTdTvxPoEeGpu7wokQMOHLT/W+7xhy9qGrLZpCGf6Fjx1fE2FfJjs6zJnUwTOLM6H67VIgDXmRM
 CfTMf78DGpQBi98KMABZ8S72xtpsIW7CIHAylf1gRAY0vCEJF9Iyu0ej7Ys0KGdTZrjUU+LZD7O
 w2kLuJ4RYdymckvL9Vcfty+F+ScUH/HeGJ7puqwMSSYYcPnGpmh+WVsk+EgmfbyE534sN0Wz
X-Authority-Analysis: v=2.4 cv=HNnDFptv c=1 sm=1 tr=0 ts=6834351a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TA7fvYvJ7Aprm3MZS8IA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: iBNI8F8uHLNm0FTe3FTH9fWSqsuNI5Pf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505260080
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

Added support for watchdog timer in Qualcomm chipsets, by adding a
Qualcomm watchdog driver.
This is a port of the upstream Linux changes to U-Boot:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/watchdog/qcom-wdt.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/watchdog/Kconfig    |  17 ++++
 drivers/watchdog/Makefile   |   2 +
 drivers/watchdog/qcom-wdt.c | 194 ++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/watchdog/qcom-wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1bb67f50352..e9c39dd37c7 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -33,6 +33,7 @@ config WATCHDOG_TIMEOUT_MSECS
 	default 16000 if ARCH_SUNXI
 	default 5376 if ULP_WATCHDOG
 	default 15000 if ARCH_BCM283X
+	default 30000 if ARCH_SNAPDRAGON
 	default 60000
 	help
 	  Watchdog timeout in msec
@@ -61,6 +62,14 @@ config OMAP_WATCHDOG
 	help
 	  Say Y here to enable the OMAP3+ watchdog driver.
 
+config QCOM_WATCHDOG
+	bool "QCOM watchdog timer support"
+	depends on ARCH_SNAPDRAGON
+	select HW_WATCHDOG
+	select CYCLIC
+	help
+	  Say Y here to enable the Qualcomm watchdog driver.
+
 config ULP_WATCHDOG
 	bool "i.MX7ULP watchdog"
 	help
@@ -315,6 +324,13 @@ config WDT_K3_RTI
 	  Say Y here if you want to include support for the K3 watchdog
 	  timer (RTI module) available in the K3 generation of processors.
 
+config WDT_QCOM
+	bool "Qualcomm watchdog timer driver support"
+	depends on WDT && ARCH_SNAPDRAGON
+	imply WATCHDOG
+	help
+	  Enables support for Qualcomm watchdog timer in Qualcomm chipsets.
+
 if WDT_K3_RTI
 
 config WDT_K3_RTI_LOAD_FW
@@ -459,4 +475,5 @@ config WDT_FTWDT010
 	help
 	  Faraday Technology ftwdt010 watchdog is an architecture independent
 	  watchdog. It is usually used in SoC chip design.
+
 endmenu
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index e6bd4c587af..93de2b31cef 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -12,6 +12,7 @@ endif
 obj-$(CONFIG_S5P)               += s5p_wdt.o
 obj-$(CONFIG_XILINX_TB_WATCHDOG) += xilinx_tb_wdt.o
 obj-$(CONFIG_OMAP_WATCHDOG) += omap_wdt.o
+obj-$(CONFIG_QCOM_WATCHDOG) += qcom-wdt.o
 obj-$(CONFIG_DESIGNWARE_WATCHDOG) += designware_wdt.o
 obj-$(CONFIG_ULP_WATCHDOG) += ulp_wdog.o
 obj-$(CONFIG_$(PHASE_)WDT) += wdt-uclass.o
@@ -43,6 +44,7 @@ obj-$(CONFIG_WDT_MTK) += mtk_wdt.o
 obj-$(CONFIG_WDT_NPCM) += npcm_wdt.o
 obj-$(CONFIG_WDT_OCTEONTX) += octeontx_wdt.o
 obj-$(CONFIG_WDT_OMAP3) += omap_wdt.o
+obj-$(CONFIG_WDT_QCOM) += qcom-wdt.o
 obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
 obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
 obj-$(CONFIG_WDT_SIEMENS_PMIC) += siemens_pmic_wdt.o
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
new file mode 100644
index 00000000000..2cb34ed8fcf
--- /dev/null
+++ b/drivers/watchdog/qcom-wdt.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <clk.h>
+#include <linux/delay.h>
+#include <wdt.h>
+
+enum wdt_reg {
+	WDT_RST,
+	WDT_EN,
+	WDT_STS,
+	WDT_BARK_TIME,
+	WDT_BITE_TIME,
+};
+
+#define QCOM_WDT_ENABLE		BIT(0)
+#define QCOM_WDT_NODE_PATH	"/soc/watchdog@17c10000"
+#define QCOM_WDT_BASE_ADDR	0x17c10000
+
+static const u32 reg_offset_data_kpss[] = {
+	[WDT_RST] = 0x4,
+	[WDT_EN] = 0x8,
+	[WDT_STS] = 0xC,
+	[WDT_BARK_TIME] = 0x10,
+	[WDT_BITE_TIME] = 0x14,
+};
+
+struct qcom_wdt_match_data {
+	const u32 *offset;
+	bool pretimeout;
+	u32 max_tick_count;
+};
+
+struct qcom_wdt_priv {
+	unsigned long	clk_rate;
+	void __iomem	*base;
+	const u32	*layout;
+	unsigned int	min_timeout;
+	unsigned int	max_timeout;
+};
+
+static void qcom_watchdog_stop(struct qcom_wdt_priv *wdt)
+{
+	writel(0, wdt->base + wdt->layout[WDT_EN]);
+}
+
+static void qcom_watchdog_reset(struct qcom_wdt_priv *wdt)
+{
+	writel(1, wdt->base + wdt->layout[WDT_RST]);
+}
+
+static void qcom_watchdog_init(struct qcom_wdt_priv *wdt, u32 timeout)
+{
+	u32 timeout_bark = timeout + 1000;
+
+	writel(0, wdt->base + wdt->layout[WDT_EN]);
+	writel(1, wdt->base + wdt->layout[WDT_RST]);
+	writel(timeout_bark, wdt->base + wdt->layout[WDT_BARK_TIME]);
+	writel(timeout, wdt->base + wdt->layout[WDT_BITE_TIME]);
+	writel(QCOM_WDT_ENABLE, wdt->base + wdt->layout[WDT_EN]);
+}
+
+void hw_watchdog_reset(void)
+{
+	struct qcom_wdt_priv wdt;
+
+	wdt.base = (void *)QCOM_WDT_BASE_ADDR;
+	wdt.layout = reg_offset_data_kpss;
+
+	qcom_watchdog_reset(&wdt);
+}
+
+void hw_watchdog_init(void)
+{
+	struct qcom_wdt_priv wdt;
+	struct clk clk;
+	int ret;
+	u32 timeout = 0;
+
+	wdt.base = (void *)QCOM_WDT_BASE_ADDR;
+	wdt.layout = reg_offset_data_kpss;
+
+	ofnode node = ofnode_path(QCOM_WDT_NODE_PATH);
+
+	if (!ofnode_valid(node)) {
+		printf("Watchdog DTS Node not found\n");
+		return;
+	}
+
+	ret = clk_get_by_index_nodev(node, 0, &clk);
+	if (ret) {
+		printf("Clk not found\n");
+		return;
+	}
+
+	wdt.clk_rate = clk_get_rate(&clk);
+	if (!wdt.clk_rate) {
+		printf("Clk rate not found\n");
+		return;
+	}
+
+	timeout = (CONFIG_WATCHDOG_TIMEOUT_MSECS * wdt.clk_rate) / 1000;
+
+	qcom_watchdog_init(&wdt, timeout);
+}
+
+static int qcom_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	struct qcom_wdt_priv *priv = dev_get_priv(dev);
+	u32 timeout = 0;
+
+	timeout = (timeout_ms * priv->clk_rate) / 1000;
+
+	qcom_watchdog_init(priv, timeout);
+
+	return 0;
+}
+
+static int qcom_wdt_stop(struct udevice *dev)
+{
+	struct qcom_wdt_priv *priv = dev_get_priv(dev);
+
+	qcom_watchdog_stop(priv);
+
+	return 0;
+}
+
+static int qcom_wdt_reset(struct udevice *dev)
+{
+	struct qcom_wdt_priv *priv = dev_get_priv(dev);
+
+	qcom_watchdog_reset(priv);
+
+	return 0;
+}
+
+static int qcom_wdt_probe(struct udevice *dev)
+{
+	int ret;
+	struct qcom_wdt_priv *priv = dev_get_priv(dev);
+	const struct qcom_wdt_match_data *data =
+		(const struct qcom_wdt_match_data *)dev_get_driver_data(dev);
+
+	priv->base = dev_read_addr_ptr(dev);
+
+	if (!priv->base)
+		return -EINVAL;
+
+	struct clk clk;
+
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret)
+		return ret;
+
+	priv->clk_rate = clk_get_rate(&clk);
+	if (!priv->clk_rate)
+		return -EINVAL;
+
+	priv->layout = data->offset;
+	priv->min_timeout = 1;
+	priv->max_timeout = data->max_tick_count / priv->clk_rate;
+
+	return 0;
+}
+
+static const struct wdt_ops qcom_wdt_ops = {
+	.start = qcom_wdt_start,
+	.stop = qcom_wdt_stop,
+	.reset = qcom_wdt_reset,
+};
+
+static const struct qcom_wdt_match_data match_data_kpss = {
+	.offset = reg_offset_data_kpss,
+	.pretimeout = true,
+	.max_tick_count = 0xFFFFFU,
+};
+
+static const struct udevice_id qcom_wdt_ids[] = {
+	{ .compatible = "qcom,kpss-wdt", .data = (ulong)&match_data_kpss },
+	{}
+};
+
+U_BOOT_DRIVER(qcom_wdt) = {
+	.name		= "qcom_wdt",
+	.id		= UCLASS_WDT,
+	.of_match	= qcom_wdt_ids,
+	.priv_auto	= sizeof(struct qcom_wdt_priv),
+	.probe		= qcom_wdt_probe,
+	.ops		= &qcom_wdt_ops,
+};
-- 
2.34.1

