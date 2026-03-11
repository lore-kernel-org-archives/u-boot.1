Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF9E1125839
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:24:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D34E84166;
	Wed, 11 Mar 2026 15:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="KlObNTsF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C6BE84057; Wed, 11 Mar 2026 15:20:50 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D07F84010
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:20:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-661be3380adso9233052a12.3
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773238848; x=1773843648; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IOsidBoM6WUp2S/HKC6wUY/JOr6GH5hsyAkZ98mIWtY=;
 b=KlObNTsFftBpHrqh08GJYTNJeEJYw9dk2DVbEtPsxUhZftOnux7s5n9PqKwyqHonOs
 HyzVuk50BIQmUDl60YUyXRuz2CwsE2zrI5V/0LhrftRIKuLYCs7kVXkx0J5qB2r+jqM1
 6xUCy4ourqz5nHfrTi1TDRfQ7qRTaCjdEkI1fYAdjvuykZcWqNeEk6xz4tseC4+L1Qdd
 LtFB+2AjiWAkFwvHHt4y8udVQnVg6HoeBssMHSQ2dG1TyDD1itvdiOB2872iu9GKJ4UF
 5Z1rfPkIuFhj7xdxEdd/HIujMQzYPN0zctHpgTaKRqsIN89O6bP645MejSRn5KTi6/ka
 Kqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773238848; x=1773843648;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IOsidBoM6WUp2S/HKC6wUY/JOr6GH5hsyAkZ98mIWtY=;
 b=SGQCmCAUHe9TEU2yi1+nOLPcldenXI/6QOIRX3I92hLWIDgop201GC6QbhoLT+PnCb
 jHrgJJXYu1mKdlBI0HciPFhvFCM2y4QR+HR8NJMV0nzjH6UsORsUbOCs/+Mblr/0VucY
 XJoha5MEF0WTz2N8v+xXoRc7mcxi82ShMWS2xmX1ksJ8XuwUV32e3Bdg7ZlJup/0AVda
 MOBzJ4QFCMWmGNz1xW1hBJPX3wP2CQcQb9IecWcmW9617ZwQ1fL82oDtMYyVjbiwNmeP
 ly7zrWiu+7elNsptE9jmnLEiGEFpH0CsFLDRJUdmDzb7/K/OeGD+wcyShpMbSgxakp/u
 qunA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcolwYnLXHt267Ljxs83WS74Rch6qwGq9d0I46jG6VnrIM+1uuU98gagIbM+3PjqK3HXREuvQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxVg7/HQPcZstJctDPnjtee+FRETyr0t2GFMMohSpod3lymH9Qx
 rzmtP7UnzSgP0DDot9M+yIQm6sZKAprYxSEyYaCuoP+1zc+OKF7yEWyoW/1iWVGOrZc=
X-Gm-Gg: ATEYQzwYz858inb5n2Gt3LOYVOfl1cbUEPylrszPUicn3oNpf9K4sJuRXdGGreYQCND
 qhlJ8RfN1j5MFGalH3Se1xXCgwSH4tu80VS8GWnxg6TmrxRsiHdNiqyFUVPcsewYvolXtwPcJDF
 dLaMtj7UewdrhSdwweXs2G2bLul8tj6pAUiURrO6vIkKZZteJgNvESR1HMFUlzGPRII5gPHFdaN
 JkNWgdD0siHxet2zyvS8X/IOvp2H34NYtZTwy5gnYzYJG459QiicUsxk1aNkEXyGfAKdjqRXBDv
 qWM+p6RspRyENKMfEAihqZEIRnV6JlxN8ZUmC0MP33wD7N1LsAP5Ar0gBefQwgWD9hxeAWSszHU
 4HbCg6jIhrI3mm2dWhgJZLJlIDrJYQyIOWCcAMXhtJ1v/+QCRZo+72u4puro7S1pJpKsaHt/7as
 lbWJtmhuVIUNa8Om1OBumYK4lE2LVU6aVN7HfMMobD8zyhRFPA7hDFEe25t2EKSILUfOov7tN/F
 WIzMA==
X-Received: by 2002:a05:6402:1443:b0:658:cf28:90ed with SMTP id
 4fb4d7f45d1cf-66319cc6b4emr1709183a12.15.1773238847674; 
 Wed, 11 Mar 2026 07:20:47 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6631503c903sm543467a12.20.2026.03.11.07.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:20:47 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Mar 2026 15:20:42 +0100
Subject: [PATCH 2/7] clk/qcom: Add Milos clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-milos-bringup-v1-2-eb905c467f10@fairphone.com>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
In-Reply-To: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773238844; l=8994;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=TtC5F7ifwAig9gup26kwEUwL8D9T7b7KgJwwt37/3gc=;
 b=q/42mDFEq2upJNpgqqy5WvX3YboPhFaH+dzWm60uNoTjmSirfZ8tmD0k5eF5M1q5yXRI2i4Jh
 bKpkGWmZTKoDf5DvrZczq02LMttx04eBgYzddaoUL7zOEC+JhI1ghLc
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

Add Clock driver for the GCC block found in the Milos SoC.

The qcom-snps-eusb2-hsphy driver requires the TCXO frequency ("ref"
clock), so we need to pass that as well.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/Kconfig       |   8 ++
 drivers/clk/qcom/Makefile      |   1 +
 drivers/clk/qcom/clock-milos.c | 224 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 233 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 8504ed5d656..0a2ce55aaa2 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -47,6 +47,14 @@ config CLK_QCOM_IPQ9574
 	  on the Snapdragon IPQ9574 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_MILOS
+	bool "Qualcomm Milos GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon Milos SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 82a5b166196..b96d61b603e 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
 obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-milos.c b/drivers/clk/qcom/clock-milos.c
new file mode 100644
index 00000000000..04f46b943c1
--- /dev/null
+++ b/drivers/clk/qcom/clock-milos.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm Milos
+ *
+ * (C) Copyright 2024 Linaro Ltd.
+ * (C) Copyright 2025 Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,milos-gcc.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
+
+#include "clock-qcom.h"
+
+/* On-board TCXO, TOFIX get from DT */
+#define TCXO_RATE	76800000
+
+/* bi_tcxo_div4 divided after RPMh output */
+#define TCXO_DIV4_RATE	(TCXO_RATE / 4)
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s3_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(51200000, CFG_CLK_SRC_GPLL0_EVEN, 1, 64, 375),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
+	F(37500000, CFG_CLK_SRC_GPLL0_EVEN, 8, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
+	/* TOFIX F(202000000, CFG_CLK_SRC_GPLL9, 4, 0, 0), */
+	{ }
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
+	F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
+	F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
+	{ }
+};
+
+static ulong milos_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_QUPV3_WRAP0_S5_CLK: /* UART5 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s3_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x18500,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x14018,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x3902c,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_PRIM_MOCK_UTMI_CLK:
+		clk_rcg_set_rate(priv->base, 0x39044, 0, 0);
+		return TCXO_DIV4_RATE;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk milos_clks[] = {
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x39090, BIT(0)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,		0x52008, BIT(27)),
+	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,		0x52008, BIT(20)),
+	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,		0x52008, BIT(21)),
+	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14010, BIT(0)),
+	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x39018, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x39028, BIT(0)),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x39024, BIT(0)),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x3908c, BIT(0)),
+};
+
+static int milos_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	switch (clk->id) {
+	case GCC_AGGRE_USB3_PRIM_AXI_CLK:
+		qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
+		break;
+	}
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map milos_gcc_resets[] = {
+	[GCC_CAMERA_BCR] = { 0x26000 },
+	[GCC_DISPLAY_BCR] = { 0x27000 },
+	[GCC_GPU_BCR] = { 0x71000 },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x6c014 },
+	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0x6c020 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0x6c028 },
+	[GCC_PCIE_1_BCR] = { 0x90000 },
+	[GCC_PCIE_1_LINK_DOWN_BCR] = { 0x8e014 },
+	[GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0x8e020 },
+	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
+	[GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0x8e024 },
+	[GCC_PCIE_RSCC_BCR] = { 0x11000 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x18000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x1e000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_SDCC1_BCR] = { 0xa3000 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0x39000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x32018, 2 },
+	[GCC_VIDEO_BCR] = { 0x32000 },
+};
+
+static const struct qcom_power_map milos_gdscs[] = {
+	[PCIE_0_GDSC] = { 0x6b004 },
+	[PCIE_0_PHY_GDSC] = { 0x6c000 },
+	[PCIE_1_GDSC] = { 0x90004 },
+	[PCIE_1_PHY_GDSC] = { 0xa2000 },
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[UFS_MEM_PHY_GDSC] = { 0x9e000 },
+	[USB30_PRIM_GDSC] = { 0x39004 },
+	[USB3_PHY_GDSC] = { 0x5000c },
+};
+
+static struct msm_clk_data milos_gcc_data = {
+	.resets = milos_gcc_resets,
+	.num_resets = ARRAY_SIZE(milos_gcc_resets),
+	.clks = milos_clks,
+	.num_clks = ARRAY_SIZE(milos_clks),
+	.power_domains = milos_gdscs,
+	.num_power_domains = ARRAY_SIZE(milos_gdscs),
+
+	.enable = milos_enable,
+	.set_rate = milos_set_rate,
+};
+
+static const struct udevice_id gcc_milos_of_match[] = {
+	{
+		.compatible = "qcom,milos-gcc",
+		.data = (ulong)&milos_gcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_milos) = {
+	.name		= "gcc_milos",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_milos_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
+
+static ulong milos_rpmh_clk_set_rate(struct clk *clk, ulong rate)
+{
+	return (clk->rate = rate);
+}
+
+static ulong milos_rpmh_clk_get_rate(struct clk *clk)
+{
+	switch (clk->id) {
+	case RPMH_CXO_CLK:
+		return TCXO_DIV4_RATE;
+	default:
+		return clk->rate;
+	}
+}
+
+static int milos_rpmh_clk_nop(struct clk *clk)
+{
+	return 0;
+}
+
+static struct clk_ops milos_rpmh_clk_ops = {
+	.set_rate = milos_rpmh_clk_set_rate,
+	.get_rate = milos_rpmh_clk_get_rate,
+	.enable = milos_rpmh_clk_nop,
+	.disable = milos_rpmh_clk_nop,
+};
+
+static const struct udevice_id milos_rpmh_clk_ids[] = {
+	{ .compatible = "qcom,milos-rpmh-clk" },
+	{ }
+};
+
+U_BOOT_DRIVER(milos_rpmh_clk) = {
+	.name		= "milos_rpmh_clk",
+	.id		= UCLASS_CLK,
+	.of_match	= milos_rpmh_clk_ids,
+	.ops		= &milos_rpmh_clk_ops,
+	.flags		= DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};

-- 
2.53.0

