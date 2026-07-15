Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2608CC44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 01:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A43C84CDB;
	Thu, 16 Jul 2026 03:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Xk0tQJT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC84284C2A; Wed, 15 Jul 2026 17:17:52 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA47084BB3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so956451266b.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784128670; x=1784733470; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JdtkERUUTWujsB78hdP9Lza18DFRMXcFutgGqhk94n4=;
 b=Xk0tQJT+fZVDqi+BbhtVi1RCpRfflNljeKZfigbMzkcVed+4FqlxuN0DJV+oenWYI4
 NAhaC+yrg3R5uwnJn/43A0MnopbO7mCeD37Px+IWOoP1/YVjOuLRxJBHKjFg3lVWo5kr
 QMd6COM1SQHPz+jvUAN6r+oCMVBGcTpQkxSQMWOWCPQAMwYLMUV144OLrLD5+lcpA0a8
 1H7POUDSbudDo8e55s3QIdyYi0/BCRQYDcvCLFb54JU4ILJyy7Q7LpXWXeCR1EIVgRbX
 v/PIj6riSTqyTJKwdVmlKy5Iq/llTptay4UhW65i4TYxFSE20HCRCwzBr2kMt9TtoKEv
 jJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128670; x=1784733470;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JdtkERUUTWujsB78hdP9Lza18DFRMXcFutgGqhk94n4=;
 b=FxVXAQ4lyzFUeQHFzshAnhZdu+qqDUgn0s8aQRCgFREt7TRi384Fmwq84xtJmXqcwS
 PJfs+PkiBihY1yamdSWI2WdAkNisrbLilyVTqs8AE/1WR4OmgWsQ+07JXTfUTFBztze8
 FRxOY/Cs7ESiKmpV4Og4gBTmLyOAnWgUSNWvmleLj8LodfeMis8hdi/+x2Q3rgYGtBC/
 +xpEsex9mEqjz5wNnsJoMOQfjolW7va8XJwxot2bN5uQPBCZJ5SGP9Q8rVwE8sLIAyZO
 g08X1sbyf7QKxGo3caBTYfHZNO2ttq9LRBF1GG/ZLhcVInFhizMArhBJQWY2TxeFLQoI
 B6pA==
X-Forwarded-Encrypted: i=1;
 AHgh+RraqZY2mk4omXvl/SV2ZD+EDfpnLfeO85O3KJpwu0rmz6hKXA+Mrlv/uBitDxqAU3e8On3WIYs=@lists.denx.de
X-Gm-Message-State: AOJu0YwRvnqcQMoZGp+gak5mFCGyaQFo690F80Xa8eNA7a91snxVCdK8
 OQIuv0jClkFc4mFWgYWN0RcUJ+yrlZeSYQfH05Mw4lzUOWJ7+Tzpa5VTpmnvJDiAL5Q=
X-Gm-Gg: AfdE7cm23BkFH3/Uhq1y07nnLTo/1lmnksUmEk1q5cvFsenXl12krZbL0pn7cagBEGn
 qaY1k/7XQs07XO2GseQHUGBRkWL8lfyYkb6dx2oaMwB6ZgrW+5UUZpgG+1dJIYcFlQVhf8PenlF
 1gQ0ewq/V8+t8mpAFPS7i/cUVQ7D7DXBQwjWA90nWgFR8faCYkldC4vZbPsArOcz3cnpLOrGZ2D
 VvB7gIOXZcFl3NADPRPGvZyaJ9E9wEpJAg1xSLXVOEJvGmxnto+3vRSpLmT6jCLAZfFa3C5EDmF
 prxdBki70DuvQihqt9EuOCb8wXMTTbKpEMfdQFUFgnu+fZLwjm79hRH1IGjhYoBJlUUX8SLQdPw
 9Zlf8ZHGV85U1AxdbHKZ71uuCxDebAiRQ5zuymtP0ff4n3Axi/MPG8P6D1dJOjs/EQ9dDvhnvxu
 zqdBXt5Kw+4wLdkp48sSsQfstT4HPYM1Je2ddeNnPm+DHu0e5tcH4oVifADbqlYxVY8NGP1QK4n
 IxGlQ==
X-Received: by 2002:a17:907:1c1d:b0:c15:e17b:fed with SMTP id
 a640c23a62f3a-c1679445f68mr227520466b.37.1784128670263; 
 Wed, 15 Jul 2026 08:17:50 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168716f6dbsm59145766b.15.2026.07.15.08.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:17:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 17:17:40 +0200
Subject: [PATCH 1/4] clk/qcom: Add MSM8953 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-msm8953-basic-v1-1-bc4cb5099d8e@fairphone.com>
References: <20260715-msm8953-basic-v1-0-bc4cb5099d8e@fairphone.com>
In-Reply-To: <20260715-msm8953-basic-v1-0-bc4cb5099d8e@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784128669; l=6421;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=NuXPG+T2txRS50qALbn8pmbo5sAdN1dPfHGLFyz6Q8A=;
 b=+y3gmtwwyxZtbGqp1qJVVl1eVxOXGmADpaFJ1jhw02WdmvdF6XUNkBpRBQk+Q9rmIuSEaKVva
 ka/yUcF5Xf4BgtAKMXMDOB2DUuLs9a9eJYw/m3v7PGU5z9Moc1BLK6r
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Thu, 16 Jul 2026 03:03:52 +0200
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

Add Clock driver for the GCC block found in the MSM8953 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/Kconfig         |   8 +++
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/clock-msm8953.c | 141 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 9ad233c83ac..8d980acd0a7 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -55,6 +55,14 @@ config CLK_QCOM_MILOS
 	  on the Snapdragon Milos SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config CLK_QCOM_MSM8953
+	bool "Qualcomm MSM8953 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon MSM8953 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index c0d95a6300e..4f7eae589cc 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
 obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
 obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
+obj-$(CONFIG_CLK_QCOM_MSM8953) += clock-msm8953.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-msm8953.c b/drivers/clk/qcom/clock-msm8953.c
new file mode 100644
index 00000000000..b8d04d7e3ee
--- /dev/null
+++ b/drivers/clk/qcom/clock-msm8953.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Clock drivers for Qualcomm MSM8953
+ *
+ * Copyright (c) 2026 Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,gcc-msm8953.h>
+
+#include "clock-qcom.h"
+
+static const struct freq_tbl ftbl_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, (4 << 8) /*P_GPLL0_DIV2*/, 5, 1, 4),
+	F(25000000, (4 << 8) /*P_GPLL0_DIV2*/, 16, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0, 16, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
+	F(177770000, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(192000000, (2 << 8) /*P_GPLL4*/, 6, 0, 0),
+	F(384000000, (2 << 8) /*P_GPLL4*/, 3, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_sdcc2_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, (4 << 8) /*P_GPLL0_DIV2*/, 5, 1, 4),
+	F(25000000, (4 << 8) /*P_GPLL0_DIV2*/, 16, 0, 0),
+	F(50000000, CFG_CLK_SRC_GPLL0, 16, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
+	F(177770000, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
+	F(192000000, (2 << 8) /*P_GPLL4*/, 6, 0, 0),
+	F(200000000, CFG_CLK_SRC_GPLL0, 4, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_usb30_master_clk_src[] = {
+	F(80000000, (2 << 8) /*P_GPLL0_DIV2*/, 5, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 8, 0, 0),
+	F(133330000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static const struct freq_tbl ftbl_usb30_mock_utmi_clk_src[] = {
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(60000000, (2 << 8) /*P_GPLL6_DIV2*/, 9, 1, 1),
+	{ }
+};
+
+static ulong msm8953_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_SDCC1_APPS_CLK: /* SDC1 */
+		freq = qcom_find_freq(ftbl_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x42004,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_SDCC2_APPS_CLK: /* SDC2 */
+		freq = qcom_find_freq(ftbl_sdcc2_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x43004,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	case GCC_USB30_MASTER_CLK:
+		freq = qcom_find_freq(ftbl_usb30_master_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x3f00c,
+				     freq->pre_div, freq->m, freq->n, freq->src, 0);
+		return freq->freq;
+	case GCC_USB30_MOCK_UTMI_CLK:
+		freq = qcom_find_freq(ftbl_usb30_mock_utmi_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x3f020,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk msm8953_clks[] = {
+	GATE_CLK_POLLED(GCC_SDCC1_AHB_CLK,		0x4201c, BIT(0), 0x4201c),
+	GATE_CLK_POLLED(GCC_SDCC1_APPS_CLK,		0x42018, BIT(0), 0x42018),
+	GATE_CLK_POLLED(GCC_SDCC2_AHB_CLK,		0x4301c, BIT(0), 0x4301c),
+	GATE_CLK_POLLED(GCC_SDCC2_APPS_CLK,		0x43018, BIT(0), 0x43018),
+	GATE_CLK_POLLED(GCC_USB30_MASTER_CLK,		0x3f000, BIT(0), 0x3f000),
+	GATE_CLK_POLLED(GCC_USB30_SLEEP_CLK,		0x3f004, BIT(0), 0x3f004),
+	GATE_CLK_POLLED(GCC_USB30_MOCK_UTMI_CLK,	0x3f008, BIT(0), 0x3f008),
+	GATE_CLK_POLLED(GCC_PCNOC_USB3_AXI_CLK,		0x3f038, BIT(0), 0x3f038),
+	GATE_CLK_POLLED(GCC_USB_PHY_CFG_AHB_CLK,	0x3f080, BIT(0), 0x3f080),
+};
+
+static int msm8953_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map msm8953_resets[] = {
+	[GCC_QUSB2_PHY_BCR]	= { 0x4103c },
+};
+
+static const struct qcom_power_map msm8953_gdscs[] = {
+	[USB30_GDSC]		= { .reg = 0x3f078, .flags = ALWAYS_ON },
+};
+
+static struct msm_clk_data msm8953_clk_data = {
+	.resets = msm8953_resets,
+	.num_resets = ARRAY_SIZE(msm8953_resets),
+
+	.clks = msm8953_clks,
+	.num_clks = ARRAY_SIZE(msm8953_clks),
+
+	.power_domains = msm8953_gdscs,
+	.num_power_domains = ARRAY_SIZE(msm8953_gdscs),
+
+	.enable = msm8953_enable,
+	.set_rate = msm8953_set_rate,
+};
+
+static const struct udevice_id gcc_msm8953_of_match[] = {
+	{
+		.compatible = "qcom,gcc-msm8953",
+		.data = (ulong)&msm8953_clk_data,
+	},
+	{}
+};
+
+U_BOOT_DRIVER(gcc_msm8953) = {
+	.name = "gcc_msm8953",
+	.id = UCLASS_NOP,
+	.of_match = gcc_msm8953_of_match,
+	.bind = qcom_cc_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.55.0

