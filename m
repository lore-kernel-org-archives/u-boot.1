Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF38F1098792
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 14:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24E3F84067;
	Fri, 20 Mar 2026 15:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="ak6Bif3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6669283FA4; Fri, 20 Mar 2026 15:32:15 +0100 (CET)
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E3C83D71
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 15:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kcxt@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1774017124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+j14yI1rEtcX7RlxXrvDIeNek6v1I/NuXA08inTHp8=;
 b=ak6Bif3UFipHQgIuO+Ivo+MPbs6FnWQx/Cl0/pauXqrDpOPntftY6VLghLjvOsrSDBW7pd
 89HJM35H860N4fBGBohWqdB43ZqNGt9Wx+d79TtSnYn4H316eUtnwQdCNjZrQhGDpsh/ej
 kSefbl8PIvvvnqcY6DXoOGG2sP/05lpwLA2wyTqRuiUrZgBfrDMPPoFM+DRoJZPcgQZ/JM
 ZswGQSErz9YO/ZAAOh4rT0wmvPSLgOB5AGs1TOMS8WkeKUL9XDSrCX0LCVN3Hm+ouRg8I6
 WjEm6dFVpO/SaZ+qUYvoL4j9DfmYEpJUqkiP7Kx+DZl8UVEbWalBqX0mEoTmfA==
From: Casey Connolly <kcxt@postmarketos.org>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 u-boot-qcom@groups.io, uboot-snps-arc@synopsys.com,
 u-boot-amlogic@groups.io, Sumit Garg <sumit.garg@kernel.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Michal Simek <michal.simek@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Robert Marko <robert.marko@sartura.hr>,
 Thierry Reding <treding@nvidia.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org,
 Marek Vasut <marex@denx.de>
Subject: [PATCH RFC 33/40] clk/qcom: drop in Linux Qualcomm CCF drivers
Date: Fri, 20 Mar 2026 15:31:29 +0100
Message-ID: <20260320-casey-ccf-upstream-v1-33-5b654f4b6620@linaro.org>
In-Reply-To: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
References: <20260319-casey-ccf-upstream-v1-0-4df2ee2226da@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=237191;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=kMPQg+tzsMHiBKL5gulBE361n+f5rIBmL2G0Jkdc2zY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsy9kSsedSfNecRXOOPZ2yf3Q5zmGih/m+3Ss/Tp6iwzv
 lzLdeX+HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiM+cw/E+WmKMmM3GPpZ7e
 Lo07Dja5m4q9dM1L73iGGXsoCDddUmb4n/D76CbfK2rrBJl4Lpo+VWidt+uOR61x2eZSDp4tS3a
 9/gIA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Fri, 20 Mar 2026 15:38:37 +0100
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

From: Casey Connolly <casey.connolly@linaro.org>

Drop in most of the Qualcomm clk core code from Linux 6.18, not
everything is included here but this will enable SM8650 gcc and dispcc
support.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/ccf/clk-alpha-pll.c      | 3193 +++++++++++++++++++++++++++++
 drivers/clk/qcom/ccf/clk-alpha-pll.h      |  251 +++
 drivers/clk/qcom/ccf/clk-branch.c         |  200 ++
 drivers/clk/qcom/ccf/clk-branch.h         |  124 ++
 drivers/clk/qcom/ccf/clk-rcg.h            |  217 ++
 drivers/clk/qcom/ccf/clk-rcg2.c           | 1860 +++++++++++++++++
 drivers/clk/qcom/ccf/clk-regmap-divider.c |   90 +
 drivers/clk/qcom/ccf/clk-regmap-divider.h |   22 +
 drivers/clk/qcom/ccf/clk-regmap-mux-div.c |  231 +++
 drivers/clk/qcom/ccf/clk-regmap-mux-div.h |   44 +
 drivers/clk/qcom/ccf/clk-regmap-mux.c     |   57 +
 drivers/clk/qcom/ccf/clk-regmap-mux.h     |   23 +
 drivers/clk/qcom/ccf/clk-regmap-phy-mux.c |   62 +
 drivers/clk/qcom/ccf/clk-regmap-phy-mux.h |   33 +
 drivers/clk/qcom/ccf/clk-regmap.c         |  106 +
 drivers/clk/qcom/ccf/clk-regmap.h         |   38 +
 drivers/clk/qcom/ccf/common.c             |  468 +++++
 drivers/clk/qcom/ccf/common.h             |   92 +
 drivers/clk/qcom/ccf/gdsc.c               |  667 ++++++
 drivers/clk/qcom/ccf/gdsc.h               |  101 +
 drivers/clk/qcom/ccf/reset.c              |   59 +
 drivers/clk/qcom/ccf/reset.h              |   31 +
 22 files changed, 7969 insertions(+)

diff --git a/drivers/clk/qcom/ccf/clk-alpha-pll.c b/drivers/clk/qcom/ccf/clk-alpha-pll.c
new file mode 100644
index 000000000000..6aeba40358c1
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-alpha-pll.c
@@ -0,0 +1,3193 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2015, 2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/delay.h>
+
+#include "clk-alpha-pll.h"
+#include "common.h"
+
+#define PLL_MODE(p)		((p)->offset + 0x0)
+# define PLL_OUTCTRL		BIT(0)
+# define PLL_BYPASSNL		BIT(1)
+# define PLL_RESET_N		BIT(2)
+# define PLL_OFFLINE_REQ	BIT(7)
+# define PLL_LOCK_COUNT_SHIFT	8
+# define PLL_LOCK_COUNT_MASK	0x3f
+# define PLL_BIAS_COUNT_SHIFT	14
+# define PLL_BIAS_COUNT_MASK	0x3f
+# define PLL_VOTE_FSM_ENA	BIT(20)
+# define PLL_FSM_ENA		BIT(20)
+# define PLL_VOTE_FSM_RESET	BIT(21)
+# define PLL_UPDATE		BIT(22)
+# define PLL_UPDATE_BYPASS	BIT(23)
+# define PLL_FSM_LEGACY_MODE	BIT(24)
+# define PLL_OFFLINE_ACK	BIT(28)
+# define ALPHA_PLL_ACK_LATCH	BIT(29)
+# define PLL_ACTIVE_FLAG	BIT(30)
+# define PLL_LOCK_DET		BIT(31)
+
+#define PLL_L_VAL(p)		((p)->offset + (p)->regs[PLL_OFF_L_VAL])
+#define PLL_CAL_L_VAL(p)	((p)->offset + (p)->regs[PLL_OFF_CAL_L_VAL])
+#define PLL_ALPHA_VAL(p)	((p)->offset + (p)->regs[PLL_OFF_ALPHA_VAL])
+#define PLL_ALPHA_VAL_U(p)	((p)->offset + (p)->regs[PLL_OFF_ALPHA_VAL_U])
+
+#define PLL_USER_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_USER_CTL])
+# define PLL_POST_DIV_SHIFT	8
+# define PLL_POST_DIV_MASK(p)	GENMASK((p)->width ? (p)->width - 1 : 3, 0)
+# define PLL_ALPHA_MSB		BIT(15)
+# define PLL_ALPHA_EN		BIT(24)
+# define PLL_ALPHA_MODE		BIT(25)
+# define PLL_VCO_SHIFT		20
+# define PLL_VCO_MASK		0x3
+
+#define PLL_USER_CTL_U(p)	((p)->offset + (p)->regs[PLL_OFF_USER_CTL_U])
+#define PLL_USER_CTL_U1(p)	((p)->offset + (p)->regs[PLL_OFF_USER_CTL_U1])
+
+#define PLL_CONFIG_CTL(p)	((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL])
+#define PLL_CONFIG_CTL_U(p)	((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL_U])
+#define PLL_CONFIG_CTL_U1(p)	((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL_U1])
+#define PLL_CONFIG_CTL_U2(p)	((p)->offset + (p)->regs[PLL_OFF_CONFIG_CTL_U2])
+#define PLL_TEST_CTL(p)		((p)->offset + (p)->regs[PLL_OFF_TEST_CTL])
+#define PLL_TEST_CTL_U(p)	((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U])
+#define PLL_TEST_CTL_U1(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U1])
+#define PLL_TEST_CTL_U2(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U2])
+#define PLL_TEST_CTL_U3(p)     ((p)->offset + (p)->regs[PLL_OFF_TEST_CTL_U3])
+#define PLL_STATUS(p)		((p)->offset + (p)->regs[PLL_OFF_STATUS])
+#define PLL_OPMODE(p)		((p)->offset + (p)->regs[PLL_OFF_OPMODE])
+#define PLL_FRAC(p)		((p)->offset + (p)->regs[PLL_OFF_FRAC])
+
+#define GET_PLL_TYPE(pll)	(((pll)->regs - clk_alpha_pll_regs[0]) / PLL_OFF_MAX_REGS)
+
+const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
+	[CLK_ALPHA_PLL_TYPE_DEFAULT] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
+		[PLL_OFF_USER_CTL] = 0x10,
+		[PLL_OFF_USER_CTL_U] = 0x14,
+		[PLL_OFF_CONFIG_CTL] = 0x18,
+		[PLL_OFF_TEST_CTL] = 0x1c,
+		[PLL_OFF_TEST_CTL_U] = 0x20,
+		[PLL_OFF_STATUS] = 0x24,
+	},
+	[CLK_ALPHA_PLL_TYPE_HUAYRA] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_USER_CTL] = 0x10,
+		[PLL_OFF_CONFIG_CTL] = 0x14,
+		[PLL_OFF_CONFIG_CTL_U] = 0x18,
+		[PLL_OFF_TEST_CTL] = 0x1c,
+		[PLL_OFF_TEST_CTL_U] = 0x20,
+		[PLL_OFF_STATUS] = 0x24,
+	},
+	[CLK_ALPHA_PLL_TYPE_HUAYRA_APSS] = {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_STATUS] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+	},
+	[CLK_ALPHA_PLL_TYPE_HUAYRA_2290] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_USER_CTL] = 0x0c,
+		[PLL_OFF_CONFIG_CTL] = 0x10,
+		[PLL_OFF_CONFIG_CTL_U] = 0x14,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x18,
+		[PLL_OFF_TEST_CTL] = 0x1c,
+		[PLL_OFF_TEST_CTL_U] = 0x20,
+		[PLL_OFF_TEST_CTL_U1] = 0x24,
+		[PLL_OFF_OPMODE] = 0x28,
+		[PLL_OFF_STATUS] = 0x38,
+	},
+	[CLK_ALPHA_PLL_TYPE_BRAMMO] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
+		[PLL_OFF_USER_CTL] = 0x10,
+		[PLL_OFF_CONFIG_CTL] = 0x18,
+		[PLL_OFF_TEST_CTL] = 0x1c,
+		[PLL_OFF_STATUS] = 0x24,
+	},
+	[CLK_ALPHA_PLL_TYPE_FABIA] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_USER_CTL] = 0x0c,
+		[PLL_OFF_USER_CTL_U] = 0x10,
+		[PLL_OFF_CONFIG_CTL] = 0x14,
+		[PLL_OFF_CONFIG_CTL_U] = 0x18,
+		[PLL_OFF_TEST_CTL] = 0x1c,
+		[PLL_OFF_TEST_CTL_U] = 0x20,
+		[PLL_OFF_STATUS] = 0x24,
+		[PLL_OFF_OPMODE] = 0x2c,
+		[PLL_OFF_FRAC] = 0x38,
+	},
+	[CLK_ALPHA_PLL_TYPE_TRION] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_CAL_L_VAL] = 0x08,
+		[PLL_OFF_USER_CTL] = 0x0c,
+		[PLL_OFF_USER_CTL_U] = 0x10,
+		[PLL_OFF_USER_CTL_U1] = 0x14,
+		[PLL_OFF_CONFIG_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x20,
+		[PLL_OFF_TEST_CTL] = 0x24,
+		[PLL_OFF_TEST_CTL_U] = 0x28,
+		[PLL_OFF_TEST_CTL_U1] = 0x2c,
+		[PLL_OFF_STATUS] = 0x30,
+		[PLL_OFF_OPMODE] = 0x38,
+		[PLL_OFF_ALPHA_VAL] = 0x40,
+	},
+	[CLK_ALPHA_PLL_TYPE_AGERA] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_USER_CTL] = 0x0c,
+		[PLL_OFF_CONFIG_CTL] = 0x10,
+		[PLL_OFF_CONFIG_CTL_U] = 0x14,
+		[PLL_OFF_TEST_CTL] = 0x18,
+		[PLL_OFF_TEST_CTL_U] = 0x1c,
+		[PLL_OFF_STATUS] = 0x2c,
+	},
+	[CLK_ALPHA_PLL_TYPE_ZONDA] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_USER_CTL] = 0x0c,
+		[PLL_OFF_CONFIG_CTL] = 0x10,
+		[PLL_OFF_CONFIG_CTL_U] = 0x14,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x18,
+		[PLL_OFF_TEST_CTL] = 0x1c,
+		[PLL_OFF_TEST_CTL_U] = 0x20,
+		[PLL_OFF_TEST_CTL_U1] = 0x24,
+		[PLL_OFF_OPMODE] = 0x28,
+		[PLL_OFF_STATUS] = 0x38,
+	},
+	[CLK_ALPHA_PLL_TYPE_LUCID_EVO] = {
+		[PLL_OFF_OPMODE] = 0x04,
+		[PLL_OFF_STATUS] = 0x0c,
+		[PLL_OFF_L_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x2c,
+		[PLL_OFF_TEST_CTL_U] = 0x30,
+		[PLL_OFF_TEST_CTL_U1] = 0x34,
+	},
+	[CLK_ALPHA_PLL_TYPE_LUCID_OLE] = {
+		[PLL_OFF_OPMODE] = 0x04,
+		[PLL_OFF_STATE] = 0x08,
+		[PLL_OFF_STATUS] = 0x0c,
+		[PLL_OFF_L_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x2c,
+		[PLL_OFF_TEST_CTL_U] = 0x30,
+		[PLL_OFF_TEST_CTL_U1] = 0x34,
+		[PLL_OFF_TEST_CTL_U2] = 0x38,
+	},
+	[CLK_ALPHA_PLL_TYPE_PONGO_ELU] = {
+		[PLL_OFF_OPMODE] = 0x04,
+		[PLL_OFF_STATE] = 0x08,
+		[PLL_OFF_STATUS] = 0x0c,
+		[PLL_OFF_L_VAL] = 0x10,
+		[PLL_OFF_USER_CTL] = 0x14,
+		[PLL_OFF_USER_CTL_U] = 0x18,
+		[PLL_OFF_CONFIG_CTL] = 0x1c,
+		[PLL_OFF_CONFIG_CTL_U] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x24,
+		[PLL_OFF_CONFIG_CTL_U2] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x2c,
+		[PLL_OFF_TEST_CTL_U] = 0x30,
+		[PLL_OFF_TEST_CTL_U1] = 0x34,
+		[PLL_OFF_TEST_CTL_U2] = 0x38,
+		[PLL_OFF_TEST_CTL_U3] = 0x3c,
+	},
+	[CLK_ALPHA_PLL_TYPE_TAYCAN_ELU] = {
+		[PLL_OFF_OPMODE] = 0x04,
+		[PLL_OFF_STATE] = 0x08,
+		[PLL_OFF_STATUS] = 0x0c,
+		[PLL_OFF_L_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U] = 0x24,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x2c,
+		[PLL_OFF_TEST_CTL_U] = 0x30,
+	},
+	[CLK_ALPHA_PLL_TYPE_RIVIAN_EVO] = {
+		[PLL_OFF_OPMODE] = 0x04,
+		[PLL_OFF_STATUS] = 0x0c,
+		[PLL_OFF_L_VAL] = 0x10,
+		[PLL_OFF_USER_CTL] = 0x14,
+		[PLL_OFF_USER_CTL_U] = 0x18,
+		[PLL_OFF_CONFIG_CTL] = 0x1c,
+		[PLL_OFF_CONFIG_CTL_U] = 0x20,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x24,
+		[PLL_OFF_TEST_CTL] = 0x28,
+		[PLL_OFF_TEST_CTL_U] = 0x2c,
+	},
+	[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
+		[PLL_OFF_TEST_CTL] = 0x10,
+		[PLL_OFF_TEST_CTL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_STATUS] = 0x24,
+	},
+	[CLK_ALPHA_PLL_TYPE_BRAMMO_EVO] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL_U] = 0x0c,
+		[PLL_OFF_TEST_CTL] = 0x10,
+		[PLL_OFF_TEST_CTL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL] = 0x1C,
+		[PLL_OFF_STATUS] = 0x20,
+	},
+	[CLK_ALPHA_PLL_TYPE_STROMER] = {
+		[PLL_OFF_L_VAL] = 0x08,
+		[PLL_OFF_ALPHA_VAL] = 0x10,
+		[PLL_OFF_ALPHA_VAL_U] = 0x14,
+		[PLL_OFF_USER_CTL] = 0x18,
+		[PLL_OFF_USER_CTL_U] = 0x1c,
+		[PLL_OFF_CONFIG_CTL] = 0x20,
+		[PLL_OFF_STATUS] = 0x28,
+		[PLL_OFF_TEST_CTL] = 0x30,
+		[PLL_OFF_TEST_CTL_U] = 0x34,
+	},
+	[CLK_ALPHA_PLL_TYPE_STROMER_PLUS] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_USER_CTL] = 0x08,
+		[PLL_OFF_USER_CTL_U] = 0x0c,
+		[PLL_OFF_CONFIG_CTL] = 0x10,
+		[PLL_OFF_TEST_CTL] = 0x14,
+		[PLL_OFF_TEST_CTL_U] = 0x18,
+		[PLL_OFF_STATUS] = 0x1c,
+		[PLL_OFF_ALPHA_VAL] = 0x24,
+		[PLL_OFF_ALPHA_VAL_U] = 0x28,
+	},
+	[CLK_ALPHA_PLL_TYPE_ZONDA_OLE] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_USER_CTL] = 0x0c,
+		[PLL_OFF_USER_CTL_U] = 0x10,
+		[PLL_OFF_CONFIG_CTL] = 0x14,
+		[PLL_OFF_CONFIG_CTL_U] = 0x18,
+		[PLL_OFF_CONFIG_CTL_U1] = 0x1c,
+		[PLL_OFF_CONFIG_CTL_U2] = 0x20,
+		[PLL_OFF_TEST_CTL] = 0x24,
+		[PLL_OFF_TEST_CTL_U] = 0x28,
+		[PLL_OFF_TEST_CTL_U1] = 0x2c,
+		[PLL_OFF_OPMODE] = 0x30,
+		[PLL_OFF_STATUS] = 0x3c,
+	},
+	[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA] = {
+		[PLL_OFF_L_VAL] = 0x04,
+		[PLL_OFF_ALPHA_VAL] = 0x08,
+		[PLL_OFF_TEST_CTL] = 0x0c,
+		[PLL_OFF_TEST_CTL_U] = 0x10,
+		[PLL_OFF_USER_CTL] = 0x14,
+		[PLL_OFF_CONFIG_CTL] = 0x18,
+		[PLL_OFF_CONFIG_CTL_U] = 0x1c,
+		[PLL_OFF_STATUS] = 0x20,
+	},
+
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
+
+/*
+ * Even though 40 bits are present, use only 32 for ease of calculation.
+ */
+#define ALPHA_REG_BITWIDTH	40
+#define ALPHA_REG_16BIT_WIDTH	16
+#define ALPHA_BITWIDTH		32U
+#define ALPHA_SHIFT(w)		min(w, ALPHA_BITWIDTH)
+
+#define	ALPHA_PLL_STATUS_REG_SHIFT	8
+
+#define PLL_HUAYRA_M_WIDTH		8
+#define PLL_HUAYRA_M_SHIFT		8
+#define PLL_HUAYRA_M_MASK		0xff
+#define PLL_HUAYRA_N_SHIFT		0
+#define PLL_HUAYRA_N_MASK		0xff
+#define PLL_HUAYRA_ALPHA_WIDTH		16
+
+#define PLL_STANDBY		0x0
+#define PLL_RUN			0x1
+#define PLL_OUT_MASK		0x7
+#define PLL_RATE_MARGIN		500
+
+/* TRION PLL specific settings and offsets */
+#define TRION_PLL_CAL_VAL	0x44
+#define TRION_PCAL_DONE		BIT(26)
+
+/* LUCID PLL specific settings and offsets */
+#define LUCID_PCAL_DONE		BIT(27)
+
+/* LUCID 5LPE PLL specific settings and offsets */
+#define LUCID_5LPE_PCAL_DONE		BIT(11)
+#define LUCID_5LPE_ALPHA_PLL_ACK_LATCH	BIT(13)
+#define LUCID_5LPE_PLL_LATCH_INPUT	BIT(14)
+#define LUCID_5LPE_ENABLE_VOTE_RUN	BIT(21)
+
+/* LUCID EVO PLL specific settings and offsets */
+#define LUCID_EVO_PCAL_NOT_DONE		BIT(8)
+#define LUCID_EVO_ENABLE_VOTE_RUN       BIT(25)
+#define LUCID_EVO_PLL_L_VAL_MASK        GENMASK(15, 0)
+#define LUCID_EVO_PLL_CAL_L_VAL_SHIFT	16
+#define LUCID_OLE_PLL_RINGOSC_CAL_L_VAL_SHIFT	24
+
+/* PONGO ELU PLL specific setting and offsets */
+#define PONGO_PLL_OUT_MASK		GENMASK(1, 0)
+#define PONGO_PLL_L_VAL_MASK		GENMASK(11, 0)
+#define PONGO_XO_PRESENT		BIT(10)
+#define PONGO_CLOCK_SELECT		BIT(12)
+
+/* ZONDA PLL specific */
+#define ZONDA_PLL_OUT_MASK	0xf
+#define ZONDA_STAY_IN_CFA	BIT(16)
+#define ZONDA_PLL_FREQ_LOCK_DET	BIT(29)
+
+#define pll_alpha_width(p)					\
+		((PLL_ALPHA_VAL_U(p) - PLL_ALPHA_VAL(p) == 4) ?	\
+				 ALPHA_REG_BITWIDTH : ALPHA_REG_16BIT_WIDTH)
+
+#define pll_has_64bit_config(p)	((PLL_CONFIG_CTL_U(p) - PLL_CONFIG_CTL(p)) == 4)
+
+#define to_clk_alpha_pll(_hw) container_of(to_clk_regmap(_hw), \
+					   struct clk_alpha_pll, clkr)
+
+#define to_clk_alpha_pll_postdiv(_hw) container_of(to_clk_regmap(_hw), \
+					   struct clk_alpha_pll_postdiv, clkr)
+
+static int wait_for_pll(struct clk_alpha_pll *pll, u32 mask, bool inverse,
+			const char *action)
+{
+	u32 val;
+	int count;
+	int ret;
+	const char *name = clk_hw_get_name(&pll->clkr.hw);
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	/* Pongo PLLs using a 32KHz reference can take upwards of 1500us to lock. */
+	for (count = 1500; count > 0; count--) {
+		ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+		if (ret)
+			return ret;
+		if (inverse && !(val & mask))
+			return 0;
+		else if ((val & mask) == mask)
+			return 0;
+
+		udelay(1);
+	}
+
+	WARN(1, "%s failed to %s!\n", name, action);
+	return -ETIMEDOUT;
+}
+
+#define wait_for_pll_enable_active(pll) \
+	wait_for_pll(pll, PLL_ACTIVE_FLAG, 0, "enable")
+
+#define wait_for_pll_enable_lock(pll) \
+	wait_for_pll(pll, PLL_LOCK_DET, 0, "enable")
+
+#define wait_for_zonda_pll_freq_lock(pll) \
+	wait_for_pll(pll, ZONDA_PLL_FREQ_LOCK_DET, 0, "freq enable")
+
+#define wait_for_pll_disable(pll) \
+	wait_for_pll(pll, PLL_ACTIVE_FLAG, 1, "disable")
+
+#define wait_for_pll_offline(pll) \
+	wait_for_pll(pll, PLL_OFFLINE_ACK, 0, "offline")
+
+#define wait_for_pll_update(pll) \
+	wait_for_pll(pll, PLL_UPDATE, 1, "update")
+
+#define wait_for_pll_update_ack_set(pll) \
+	wait_for_pll(pll, ALPHA_PLL_ACK_LATCH, 0, "update_ack_set")
+
+#define wait_for_pll_update_ack_clear(pll) \
+	wait_for_pll(pll, ALPHA_PLL_ACK_LATCH, 1, "update_ack_clear")
+
+static void clk_alpha_pll_write_config(struct regmap *regmap, unsigned int reg,
+					unsigned int val)
+{
+	if (val)
+		regmap_write(regmap, reg, val);
+}
+
+void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config)
+{
+	u32 val, mask;
+
+	regmap_write(regmap, PLL_L_VAL(pll), config->l);
+	regmap_write(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	regmap_write(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+
+	if (pll_has_64bit_config(pll))
+		regmap_write(regmap, PLL_CONFIG_CTL_U(pll),
+			     config->config_ctl_hi_val);
+
+	if (pll_alpha_width(pll) > 32)
+		regmap_write(regmap, PLL_ALPHA_VAL_U(pll), config->alpha_hi);
+
+	val = config->main_output_mask;
+	val |= config->aux_output_mask;
+	val |= config->aux2_output_mask;
+	val |= config->early_output_mask;
+	val |= config->pre_div_val;
+	val |= config->post_div_val;
+	val |= config->vco_val;
+	val |= config->alpha_en_mask;
+	val |= config->alpha_mode_mask;
+
+	mask = config->main_output_mask;
+	mask |= config->aux_output_mask;
+	mask |= config->aux2_output_mask;
+	mask |= config->early_output_mask;
+	mask |= config->pre_div_mask;
+	mask |= config->post_div_mask;
+	mask |= config->vco_mask;
+	mask |= config->alpha_en_mask;
+	mask |= config->alpha_mode_mask;
+
+	regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
+
+	if (config->test_ctl_mask)
+		regmap_update_bits(regmap, PLL_TEST_CTL(pll),
+				   config->test_ctl_mask,
+				   config->test_ctl_val);
+	else
+		clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll),
+					   config->test_ctl_val);
+
+	if (config->test_ctl_hi_mask)
+		regmap_update_bits(regmap, PLL_TEST_CTL_U(pll),
+				   config->test_ctl_hi_mask,
+				   config->test_ctl_hi_val);
+	else
+		clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll),
+					   config->test_ctl_hi_val);
+
+	if (pll->flags & SUPPORTS_FSM_MODE)
+		qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
+}
+EXPORT_SYMBOL_GPL(clk_alpha_pll_configure);
+
+static int clk_alpha_pll_hwfsm_enable(struct clk_hw *hw)
+{
+	int ret;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	val |= PLL_FSM_ENA;
+
+	if (pll->flags & SUPPORTS_OFFLINE_REQ)
+		val &= ~PLL_OFFLINE_REQ;
+
+	ret = regmap_write(pll->clkr.regmap, PLL_MODE(pll), val);
+	if (ret)
+		return ret;
+
+	/* Make sure enable request goes through before waiting for update */
+	mb();
+
+	return wait_for_pll_enable_active(pll);
+}
+
+static void clk_alpha_pll_hwfsm_disable(struct clk_hw *hw)
+{
+	int ret;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return;
+
+	if (pll->flags & SUPPORTS_OFFLINE_REQ) {
+		ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
+					 PLL_OFFLINE_REQ, PLL_OFFLINE_REQ);
+		if (ret)
+			return;
+
+		ret = wait_for_pll_offline(pll);
+		if (ret)
+			return;
+	}
+
+	/* Disable hwfsm */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
+				 PLL_FSM_ENA, 0);
+	if (ret)
+		return;
+
+	wait_for_pll_disable(pll);
+}
+
+static int pll_is_enabled(struct clk_hw *hw, u32 mask)
+{
+	int ret;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	return !!(val & mask);
+}
+
+static int clk_alpha_pll_hwfsm_is_enabled(struct clk_hw *hw)
+{
+	return pll_is_enabled(hw, PLL_ACTIVE_FLAG);
+}
+
+static int clk_alpha_pll_is_enabled(struct clk_hw *hw)
+{
+	return pll_is_enabled(hw, PLL_LOCK_DET);
+}
+
+static int clk_alpha_pll_enable(struct clk_hw *hw)
+{
+	int ret;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val, mask;
+
+	mask = PLL_OUTCTRL | PLL_RESET_N | PLL_BYPASSNL;
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	/* If in FSM mode, just vote for it */
+	if (val & PLL_VOTE_FSM_ENA) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+		return wait_for_pll_enable_active(pll);
+	}
+
+	/* Skip if already enabled */
+	if ((val & mask) == mask)
+		return 0;
+
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
+				 PLL_BYPASSNL, PLL_BYPASSNL);
+	if (ret)
+		return ret;
+
+	/*
+	 * H/W requires a 5us delay between disabling the bypass and
+	 * de-asserting the reset.
+	 */
+	mb();
+	udelay(5);
+
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
+				 PLL_RESET_N, PLL_RESET_N);
+	if (ret)
+		return ret;
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll),
+				 PLL_OUTCTRL, PLL_OUTCTRL);
+
+	/* Ensure that the write above goes through before returning. */
+	mb();
+	return ret;
+}
+
+static void clk_alpha_pll_disable(struct clk_hw *hw)
+{
+	int ret;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val, mask;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return;
+
+	/* If in FSM mode, just unvote it */
+	if (val & PLL_VOTE_FSM_ENA) {
+		clk_disable_regmap(hw);
+		return;
+	}
+
+	mask = PLL_OUTCTRL;
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), mask, 0);
+
+	/* Delay of 2 output clock ticks required until output is disabled */
+	mb();
+	udelay(1);
+
+	mask = PLL_RESET_N | PLL_BYPASSNL;
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), mask, 0);
+}
+
+static unsigned long
+alpha_pll_calc_rate(u64 prate, u32 l, u32 a, u32 alpha_width)
+{
+	return (prate * l) + ((prate * a) >> ALPHA_SHIFT(alpha_width));
+}
+
+static unsigned long
+alpha_pll_round_rate(unsigned long rate, unsigned long prate, u32 *l, u64 *a,
+		     u32 alpha_width)
+{
+	u64 remainder;
+	u64 quotient;
+
+	quotient = rate;
+	remainder = do_div(quotient, prate);
+	*l = quotient;
+
+	if (!remainder) {
+		*a = 0;
+		return rate;
+	}
+
+	/* Upper ALPHA_BITWIDTH bits of Alpha */
+	quotient = remainder << ALPHA_SHIFT(alpha_width);
+
+	remainder = do_div(quotient, prate);
+
+	if (remainder)
+		quotient++;
+
+	*a = quotient;
+	return alpha_pll_calc_rate(prate, *l, *a, alpha_width);
+}
+
+static const struct pll_vco *
+alpha_pll_find_vco(const struct clk_alpha_pll *pll, unsigned long rate)
+{
+	const struct pll_vco *v = pll->vco_table;
+	const struct pll_vco *end = v + pll->num_vco;
+
+	for (; v < end; v++)
+		if (rate >= v->min_freq && rate <= v->max_freq)
+			return v;
+
+	return NULL;
+}
+
+static unsigned long
+clk_alpha_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	u32 l, low, high, ctl;
+	u64 a = 0, prate = parent_rate;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 alpha_width = pll_alpha_width(pll);
+
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
+
+	if (ctl & PLL_ALPHA_EN) {
+		if (regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &low))
+			return 0;
+		if (alpha_width > 32) {
+			if (regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
+					&high))
+				return 0;
+			a = (u64)high << 32 | low;
+		} else {
+			a = low & GENMASK(alpha_width - 1, 0);
+		}
+
+		if (alpha_width > ALPHA_BITWIDTH)
+			a >>= alpha_width - ALPHA_BITWIDTH;
+	}
+
+	return alpha_pll_calc_rate(prate, l, a, alpha_width);
+}
+
+
+static int __clk_alpha_pll_update_latch(struct clk_alpha_pll *pll)
+{
+	int ret;
+	u32 mode;
+
+	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &mode);
+
+	/* Latch the input to the PLL */
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE,
+			   PLL_UPDATE);
+
+	/* Wait for 2 reference cycle before checking ACK bit */
+	udelay(1);
+
+	/*
+	 * PLL will latch the new L, Alpha and freq control word.
+	 * PLL will respond by raising PLL_ACK_LATCH output when new programming
+	 * has been latched in and PLL is being updated. When
+	 * UPDATE_LOGIC_BYPASS bit is not set, PLL_UPDATE will be cleared
+	 * automatically by hardware when PLL_ACK_LATCH is asserted by PLL.
+	 */
+	if (mode & PLL_UPDATE_BYPASS) {
+		ret = wait_for_pll_update_ack_set(pll);
+		if (ret)
+			return ret;
+
+		regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE, 0);
+	} else {
+		ret = wait_for_pll_update(pll);
+		if (ret)
+			return ret;
+	}
+
+	ret = wait_for_pll_update_ack_clear(pll);
+	if (ret)
+		return ret;
+
+	/* Wait for PLL output to stabilize */
+	udelay(10);
+
+	return 0;
+}
+
+static int clk_alpha_pll_update_latch(struct clk_alpha_pll *pll,
+				      int (*is_enabled)(struct clk_hw *))
+{
+	if (!is_enabled(&pll->clkr.hw) ||
+	    !(pll->flags & SUPPORTS_DYNAMIC_UPDATE))
+		return 0;
+
+	return __clk_alpha_pll_update_latch(pll);
+}
+
+static void clk_alpha_pll_update_configs(struct clk_alpha_pll *pll, const struct pll_vco *vco,
+					 u32 l, u64 alpha, u32 alpha_width, bool alpha_en)
+{
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+
+	if (alpha_width > ALPHA_BITWIDTH)
+		alpha <<= alpha_width - ALPHA_BITWIDTH;
+
+	if (alpha_width > 32)
+		regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll), upper_32_bits(alpha));
+
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), lower_32_bits(alpha));
+
+	if (vco) {
+		regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+				   PLL_VCO_MASK << PLL_VCO_SHIFT,
+				   vco->val << PLL_VCO_SHIFT);
+	}
+
+	if (alpha_en)
+		regmap_set_bits(pll->clkr.regmap, PLL_USER_CTL(pll), PLL_ALPHA_EN);
+}
+
+static int __clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long prate,
+				    int (*is_enabled)(struct clk_hw *))
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	const struct pll_vco *vco;
+	u32 l, alpha_width = pll_alpha_width(pll);
+	u64 a;
+
+	rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
+	vco = alpha_pll_find_vco(pll, rate);
+	if (pll->vco_table && !vco) {
+		pr_err("%s: alpha pll not in a valid vco range\n",
+		       clk_hw_get_name(hw));
+		return -EINVAL;
+	}
+
+	clk_alpha_pll_update_configs(pll, vco, l, a, alpha_width, true);
+
+	return clk_alpha_pll_update_latch(pll, is_enabled);
+}
+
+static int clk_alpha_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long prate)
+{
+	return __clk_alpha_pll_set_rate(hw, rate, prate,
+					clk_alpha_pll_is_enabled);
+}
+
+static int clk_alpha_pll_hwfsm_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long prate)
+{
+	return __clk_alpha_pll_set_rate(hw, rate, prate,
+					clk_alpha_pll_hwfsm_is_enabled);
+}
+
+static int clk_alpha_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, alpha_width = pll_alpha_width(pll);
+	u64 a;
+	unsigned long min_freq, max_freq;
+
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate, &l,
+					 &a, alpha_width);
+	if (!pll->vco_table || alpha_pll_find_vco(pll, req->rate))
+		return 0;
+
+	min_freq = pll->vco_table[0].min_freq;
+	max_freq = pll->vco_table[pll->num_vco - 1].max_freq;
+
+	req->rate = clamp(req->rate, min_freq, max_freq);
+
+	return 0;
+}
+
+void clk_huayra_2290_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				   const struct alpha_pll_config *config)
+{
+	u32 val;
+
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll), config->user_ctl_val);
+
+	/* Set PLL_BYPASSNL */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_BYPASSNL, PLL_BYPASSNL);
+	regmap_read(regmap, PLL_MODE(pll), &val);
+
+	/* Wait 5 us between setting BYPASS and deasserting reset */
+	udelay(5);
+
+	/* Take PLL out from reset state */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+	regmap_read(regmap, PLL_MODE(pll), &val);
+
+	/* Wait 50us for PLL_LOCK_DET bit to go high */
+	usleep_range(50, 55);
+
+	/* Enable PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
+}
+EXPORT_SYMBOL_GPL(clk_huayra_2290_pll_configure);
+
+static unsigned long
+alpha_huayra_pll_calc_rate(u64 prate, u32 l, u32 a)
+{
+	/*
+	 * a contains 16 bit alpha_val in two’s complement number in the range
+	 * of [-0.5, 0.5).
+	 */
+	if (a >= BIT(PLL_HUAYRA_ALPHA_WIDTH - 1))
+		l -= 1;
+
+	return (prate * l) + (prate * a >> PLL_HUAYRA_ALPHA_WIDTH);
+}
+
+static unsigned long
+alpha_huayra_pll_round_rate(unsigned long rate, unsigned long prate,
+			    u32 *l, u32 *a)
+{
+	u64 remainder;
+	u64 quotient;
+
+	quotient = rate;
+	remainder = do_div(quotient, prate);
+	*l = quotient;
+
+	if (!remainder) {
+		*a = 0;
+		return rate;
+	}
+
+	quotient = remainder << PLL_HUAYRA_ALPHA_WIDTH;
+	remainder = do_div(quotient, prate);
+
+	if (remainder)
+		quotient++;
+
+	/*
+	 * alpha_val should be in two’s complement number in the range
+	 * of [-0.5, 0.5) so if quotient >= 0.5 then increment the l value
+	 * since alpha value will be subtracted in this case.
+	 */
+	if (quotient >= BIT(PLL_HUAYRA_ALPHA_WIDTH - 1))
+		*l += 1;
+
+	*a = quotient;
+	return alpha_huayra_pll_calc_rate(prate, *l, *a);
+}
+
+static unsigned long
+alpha_pll_huayra_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	u64 rate = parent_rate, tmp;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, alpha = 0, ctl, alpha_m, alpha_n;
+
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
+
+	if (ctl & PLL_ALPHA_EN) {
+		regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &alpha);
+		/*
+		 * Depending upon alpha_mode, it can be treated as M/N value or
+		 * as a two’s complement number. When alpha_mode=1,
+		 * pll_alpha_val<15:8>=M and pll_apla_val<7:0>=N
+		 *
+		 *		Fout=FIN*(L+(M/N))
+		 *
+		 * M is a signed number (-128 to 127) and N is unsigned
+		 * (0 to 255). M/N has to be within +/-0.5.
+		 *
+		 * When alpha_mode=0, it is a two’s complement number in the
+		 * range [-0.5, 0.5).
+		 *
+		 *		Fout=FIN*(L+(alpha_val)/2^16)
+		 *
+		 * where alpha_val is two’s complement number.
+		 */
+		if (!(ctl & PLL_ALPHA_MODE))
+			return alpha_huayra_pll_calc_rate(rate, l, alpha);
+
+		alpha_m = alpha >> PLL_HUAYRA_M_SHIFT & PLL_HUAYRA_M_MASK;
+		alpha_n = alpha >> PLL_HUAYRA_N_SHIFT & PLL_HUAYRA_N_MASK;
+
+		rate *= l;
+		tmp = parent_rate;
+		if (alpha_m >= BIT(PLL_HUAYRA_M_WIDTH - 1)) {
+			alpha_m = BIT(PLL_HUAYRA_M_WIDTH) - alpha_m;
+			tmp *= alpha_m;
+			do_div(tmp, alpha_n);
+			rate -= tmp;
+		} else {
+			tmp *= alpha_m;
+			do_div(tmp, alpha_n);
+			rate += tmp;
+		}
+
+		return rate;
+	}
+
+	return alpha_huayra_pll_calc_rate(rate, l, alpha);
+}
+
+static int alpha_pll_huayra_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, a, ctl, cur_alpha = 0;
+
+	rate = alpha_huayra_pll_round_rate(rate, prate, &l, &a);
+
+	regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
+
+	if (ctl & PLL_ALPHA_EN)
+		regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &cur_alpha);
+
+	/*
+	 * Huayra PLL supports PLL dynamic programming. User can change L_VAL,
+	 * without having to go through the power on sequence.
+	 */
+	if (clk_alpha_pll_is_enabled(hw)) {
+		if (cur_alpha != a) {
+			pr_err("%s: clock needs to be gated\n",
+			       clk_hw_get_name(hw));
+			return -EBUSY;
+		}
+
+		regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+		/* Ensure that the write above goes to detect L val change. */
+		mb();
+		return wait_for_pll_enable_lock(pll);
+	}
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+
+	if (a == 0)
+		regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+				   PLL_ALPHA_EN, 0x0);
+	else
+		regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+				   PLL_ALPHA_EN | PLL_ALPHA_MODE, PLL_ALPHA_EN);
+
+	return 0;
+}
+
+static int alpha_pll_huayra_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
+{
+	u32 l, a;
+
+	req->rate = alpha_huayra_pll_round_rate(req->rate,
+						req->best_parent_rate, &l, &a);
+
+	return 0;
+}
+
+static int trion_pll_is_enabled(struct clk_alpha_pll *pll,
+				struct regmap *regmap)
+{
+	u32 mode_val, opmode_val;
+	int ret;
+
+	ret = regmap_read(regmap, PLL_MODE(pll), &mode_val);
+	ret |= regmap_read(regmap, PLL_OPMODE(pll), &opmode_val);
+	if (ret)
+		return 0;
+
+	return ((opmode_val & PLL_RUN) && (mode_val & PLL_OUTCTRL));
+}
+
+static int clk_trion_pll_is_enabled(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+
+	return trion_pll_is_enabled(pll, pll->clkr.regmap);
+}
+
+static int clk_trion_pll_enable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	/* If in FSM mode, just vote for it */
+	if (val & PLL_VOTE_FSM_ENA) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+		return wait_for_pll_enable_active(pll);
+	}
+
+	/* Set operation mode to RUN */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_RUN);
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable the PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll),
+				 PLL_OUT_MASK, PLL_OUT_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable the global PLL outputs */
+	return regmap_update_bits(regmap, PLL_MODE(pll),
+				 PLL_OUTCTRL, PLL_OUTCTRL);
+}
+
+static void clk_trion_pll_disable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return;
+
+	/* If in FSM mode, just unvote it */
+	if (val & PLL_VOTE_FSM_ENA) {
+		clk_disable_regmap(hw);
+		return;
+	}
+
+	/* Disable the global PLL output */
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+	if (ret)
+		return;
+
+	/* Disable the PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll),
+				 PLL_OUT_MASK, 0);
+	if (ret)
+		return;
+
+	/* Place the PLL mode in STANDBY */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+}
+
+static unsigned long
+clk_trion_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, frac, alpha_width = pll_alpha_width(pll);
+
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_ALPHA_VAL(pll), &frac))
+		return 0;
+
+	return alpha_pll_calc_rate(parent_rate, l, frac, alpha_width);
+}
+
+const struct clk_ops clk_alpha_pll_fixed_ops = {
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_ops);
+
+const struct clk_ops clk_alpha_pll_ops = {
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = clk_alpha_pll_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_ops);
+
+const struct clk_ops clk_alpha_pll_huayra_ops = {
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = alpha_pll_huayra_recalc_rate,
+	.determine_rate = alpha_pll_huayra_determine_rate,
+	.set_rate = alpha_pll_huayra_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_huayra_ops);
+
+const struct clk_ops clk_alpha_pll_hwfsm_ops = {
+	.enable = clk_alpha_pll_hwfsm_enable,
+	.disable = clk_alpha_pll_hwfsm_disable,
+	.is_enabled = clk_alpha_pll_hwfsm_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = clk_alpha_pll_hwfsm_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
+
+const struct clk_ops clk_alpha_pll_fixed_trion_ops = {
+	.enable = clk_trion_pll_enable,
+	.disable = clk_trion_pll_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = clk_trion_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_trion_ops);
+
+static unsigned long
+clk_alpha_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	u32 ctl;
+
+	if (regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl))
+		return 0;
+
+	ctl >>= PLL_POST_DIV_SHIFT;
+	ctl &= PLL_POST_DIV_MASK(pll);
+
+	return parent_rate >> fls(ctl);
+}
+
+static const struct clk_div_table clk_alpha_div_table[] = {
+	{ 0x0, 1 },
+	{ 0x1, 2 },
+	{ 0x3, 4 },
+	{ 0x7, 8 },
+	{ 0xf, 16 },
+	{ }
+};
+
+static const struct clk_div_table clk_alpha_2bit_div_table[] = {
+	{ 0x0, 1 },
+	{ 0x1, 2 },
+	{ 0x3, 4 },
+	{ }
+};
+
+static int clk_alpha_pll_postdiv_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	const struct clk_div_table *table;
+
+	if (pll->width == 2)
+		table = clk_alpha_2bit_div_table;
+	else
+		table = clk_alpha_div_table;
+
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       table, pll->width,
+				       CLK_DIVIDER_POWER_OF_TWO);
+
+	return 0;
+}
+
+static int clk_alpha_pll_postdiv_ro_determine_rate(struct clk_hw *hw,
+						   struct clk_rate_request *req)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	u32 ctl, div;
+
+	regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &ctl);
+
+	ctl >>= PLL_POST_DIV_SHIFT;
+	ctl &= BIT(pll->width) - 1;
+	div = 1 << fls(ctl);
+
+	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)
+		req->best_parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
+							  div * req->rate);
+
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
+
+	return 0;
+}
+
+static int clk_alpha_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+					  unsigned long parent_rate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	int div;
+
+	/* 16 -> 0xf, 8 -> 0x7, 4 -> 0x3, 2 -> 0x1, 1 -> 0x0 */
+	div = DIV_ROUND_UP_ULL(parent_rate, rate) - 1;
+
+	return regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+				  PLL_POST_DIV_MASK(pll) << PLL_POST_DIV_SHIFT,
+				  div << PLL_POST_DIV_SHIFT);
+}
+
+const struct clk_ops clk_alpha_pll_postdiv_ops = {
+	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
+	.determine_rate = clk_alpha_pll_postdiv_determine_rate,
+	.set_rate = clk_alpha_pll_postdiv_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ops);
+
+const struct clk_ops clk_alpha_pll_postdiv_ro_ops = {
+	.determine_rate = clk_alpha_pll_postdiv_ro_determine_rate,
+	.recalc_rate = clk_alpha_pll_postdiv_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_ro_ops);
+
+void clk_fabia_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config)
+{
+	u32 val, mask;
+
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	clk_alpha_pll_write_config(regmap, PLL_FRAC(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll),
+						config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll),
+						config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll),
+						config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll),
+						config->user_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll),
+						config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll),
+						config->test_ctl_hi_val);
+
+	if (config->post_div_mask) {
+		mask = config->post_div_mask;
+		val = config->post_div_val;
+		regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
+	}
+
+	if (pll->flags & SUPPORTS_FSM_LEGACY_MODE)
+		regmap_update_bits(regmap, PLL_MODE(pll), PLL_FSM_LEGACY_MODE,
+							PLL_FSM_LEGACY_MODE);
+
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_UPDATE_BYPASS,
+							PLL_UPDATE_BYPASS);
+
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+}
+EXPORT_SYMBOL_GPL(clk_fabia_pll_configure);
+
+static int alpha_pll_fabia_enable(struct clk_hw *hw)
+{
+	int ret;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val, opmode_val;
+	struct regmap *regmap = pll->clkr.regmap;
+
+	ret = regmap_read(regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	/* If in FSM mode, just vote for it */
+	if (val & PLL_VOTE_FSM_ENA) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+		return wait_for_pll_enable_active(pll);
+	}
+
+	ret = regmap_read(regmap, PLL_OPMODE(pll), &opmode_val);
+	if (ret)
+		return ret;
+
+	/* Skip If PLL is already running */
+	if ((opmode_val & PLL_RUN) && (val & PLL_OUTCTRL))
+		return 0;
+
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N,
+				 PLL_RESET_N);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, PLL_OPMODE(pll), PLL_RUN);
+	if (ret)
+		return ret;
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll),
+				 PLL_OUT_MASK, PLL_OUT_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL,
+				 PLL_OUTCTRL);
+}
+
+static void alpha_pll_fabia_disable(struct clk_hw *hw)
+{
+	int ret;
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val;
+	struct regmap *regmap = pll->clkr.regmap;
+
+	ret = regmap_read(regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return;
+
+	/* If in FSM mode, just unvote it */
+	if (val & PLL_FSM_ENA) {
+		clk_disable_regmap(hw);
+		return;
+	}
+
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+	if (ret)
+		return;
+
+	/* Disable main outputs */
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, 0);
+	if (ret)
+		return;
+
+	/* Place the PLL in STANDBY */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+}
+
+static unsigned long alpha_pll_fabia_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, frac, alpha_width = pll_alpha_width(pll);
+
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	if (regmap_read(pll->clkr.regmap, PLL_FRAC(pll), &frac))
+		return 0;
+
+	return alpha_pll_calc_rate(parent_rate, l, frac, alpha_width);
+}
+
+/*
+ * Due to limited number of bits for fractional rate programming, the
+ * rounded up rate could be marginally higher than the requested rate.
+ */
+static int alpha_pll_check_rate_margin(struct clk_hw *hw,
+			unsigned long rrate, unsigned long rate)
+{
+	unsigned long rate_margin = rate + PLL_RATE_MARGIN;
+
+	if (rrate > rate_margin || rrate < rate) {
+		pr_err("%s: Rounded rate %lu not within range [%lu, %lu)\n",
+		       clk_hw_get_name(hw), rrate, rate, rate_margin);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int alpha_pll_fabia_set_rate(struct clk_hw *hw, unsigned long rate,
+						unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, alpha_width = pll_alpha_width(pll);
+	unsigned long rrate;
+	int ret;
+	u64 a;
+
+	rrate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
+
+	ret = alpha_pll_check_rate_margin(hw, rrate, rate);
+	if (ret < 0)
+		return ret;
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_write(pll->clkr.regmap, PLL_FRAC(pll), a);
+
+	return __clk_alpha_pll_update_latch(pll);
+}
+
+static int alpha_pll_fabia_prepare(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	const struct pll_vco *vco;
+	struct clk_hw *parent_hw;
+	unsigned long cal_freq, rrate;
+	u32 cal_l, val, alpha_width = pll_alpha_width(pll);
+	const char *name = clk_hw_get_name(hw);
+	u64 a;
+	int ret;
+
+	/* Check if calibration needs to be done i.e. PLL is in reset */
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	/* Return early if calibration is not needed. */
+	if (val & PLL_RESET_N)
+		return 0;
+
+	vco = alpha_pll_find_vco(pll, clk_hw_get_rate(hw));
+	if (!vco) {
+		pr_err("%s: alpha pll not in a valid vco range\n", name);
+		return -EINVAL;
+	}
+
+	cal_freq = DIV_ROUND_CLOSEST((pll->vco_table[0].min_freq +
+				pll->vco_table[0].max_freq) * 54, 100);
+
+	parent_hw = clk_hw_get_parent(hw);
+	if (!parent_hw)
+		return -EINVAL;
+
+	rrate = alpha_pll_round_rate(cal_freq, clk_hw_get_rate(parent_hw),
+					&cal_l, &a, alpha_width);
+
+	ret = alpha_pll_check_rate_margin(hw, rrate, cal_freq);
+	if (ret < 0)
+		return ret;
+
+	/* Setup PLL for calibration frequency */
+	regmap_write(pll->clkr.regmap, PLL_CAL_L_VAL(pll), cal_l);
+
+	/* Bringup the PLL at calibration frequency */
+	ret = clk_alpha_pll_enable(hw);
+	if (ret) {
+		pr_err("%s: alpha pll calibration failed\n", name);
+		return ret;
+	}
+
+	clk_alpha_pll_disable(hw);
+
+	return 0;
+}
+
+const struct clk_ops clk_alpha_pll_fabia_ops = {
+	.prepare = alpha_pll_fabia_prepare,
+	.enable = alpha_pll_fabia_enable,
+	.disable = alpha_pll_fabia_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.set_rate = alpha_pll_fabia_set_rate,
+	.recalc_rate = alpha_pll_fabia_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fabia_ops);
+
+const struct clk_ops clk_alpha_pll_fixed_fabia_ops = {
+	.enable = alpha_pll_fabia_enable,
+	.disable = alpha_pll_fabia_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = alpha_pll_fabia_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_fabia_ops);
+
+static unsigned long clk_alpha_pll_postdiv_fabia_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	u32 i, div = 1, val;
+	int ret;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return ret;
+
+	val >>= pll->post_div_shift;
+	val &= BIT(pll->width) - 1;
+
+	for (i = 0; i < pll->num_post_div; i++) {
+		if (pll->post_div_table[i].val == val) {
+			div = pll->post_div_table[i].div;
+			break;
+		}
+	}
+
+	return (parent_rate / div);
+}
+
+static unsigned long
+clk_trion_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 i, div = 1, val;
+
+	if (regmap_read(regmap, PLL_USER_CTL(pll), &val))
+		return 0;
+
+	val >>= pll->post_div_shift;
+	val &= PLL_POST_DIV_MASK(pll);
+
+	for (i = 0; i < pll->num_post_div; i++) {
+		if (pll->post_div_table[i].val == val) {
+			div = pll->post_div_table[i].div;
+			break;
+		}
+	}
+
+	return (parent_rate / div);
+}
+
+static int clk_trion_pll_postdiv_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       pll->post_div_table,
+				       pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+
+	return 0;
+};
+
+static int
+clk_trion_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long parent_rate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	int i, val = 0, div;
+
+	div = DIV_ROUND_UP_ULL(parent_rate, rate);
+	for (i = 0; i < pll->num_post_div; i++) {
+		if (pll->post_div_table[i].div == div) {
+			val = pll->post_div_table[i].val;
+			break;
+		}
+	}
+
+	return regmap_update_bits(regmap, PLL_USER_CTL(pll),
+				  PLL_POST_DIV_MASK(pll) << pll->post_div_shift,
+				  val << pll->post_div_shift);
+}
+
+const struct clk_ops clk_alpha_pll_postdiv_trion_ops = {
+	.recalc_rate = clk_trion_pll_postdiv_recalc_rate,
+	.determine_rate = clk_trion_pll_postdiv_determine_rate,
+	.set_rate = clk_trion_pll_postdiv_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_trion_ops);
+
+static int clk_alpha_pll_postdiv_fabia_determine_rate(struct clk_hw *hw,
+						      struct clk_rate_request *req)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       pll->post_div_table,
+				       pll->width, CLK_DIVIDER_ROUND_CLOSEST);
+
+	return 0;
+}
+
+static int clk_alpha_pll_postdiv_fabia_set_rate(struct clk_hw *hw,
+				unsigned long rate, unsigned long parent_rate)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	int i, val = 0, div, ret;
+
+	/*
+	 * If the PLL is in FSM mode, then treat set_rate callback as a
+	 * no-operation.
+	 */
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (ret)
+		return ret;
+
+	if (val & PLL_VOTE_FSM_ENA)
+		return 0;
+
+	div = DIV_ROUND_UP_ULL(parent_rate, rate);
+	for (i = 0; i < pll->num_post_div; i++) {
+		if (pll->post_div_table[i].div == div) {
+			val = pll->post_div_table[i].val;
+			break;
+		}
+	}
+
+	return regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+				(BIT(pll->width) - 1) << pll->post_div_shift,
+				val << pll->post_div_shift);
+}
+
+const struct clk_ops clk_alpha_pll_postdiv_fabia_ops = {
+	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
+	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
+
+/**
+ * clk_trion_pll_configure - configure the trion pll
+ *
+ * @pll: clk alpha pll
+ * @regmap: register map
+ * @config: configuration to apply for pll
+ */
+void clk_trion_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config)
+{
+	/*
+	 * If the bootloader left the PLL enabled it's likely that there are
+	 * RCGs that will lock up if we disable the PLL below.
+	 */
+	if (trion_pll_is_enabled(pll, regmap)) {
+		pr_debug("Trion PLL is already enabled, skipping configuration\n");
+		return;
+	}
+
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	regmap_write(regmap, PLL_CAL_L_VAL(pll), TRION_PLL_CAL_VAL);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll),
+				     config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll),
+				     config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll),
+				     config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll),
+					config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll),
+					config->user_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U1(pll),
+					config->user_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll),
+					config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll),
+					config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll),
+					config->test_ctl_hi1_val);
+
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_UPDATE_BYPASS,
+			   PLL_UPDATE_BYPASS);
+
+	/* Disable PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll),  PLL_OUTCTRL, 0);
+
+	/* Set operation mode to OFF */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+
+	/* Place the PLL in STANDBY mode */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+}
+EXPORT_SYMBOL_GPL(clk_trion_pll_configure);
+
+/*
+ * The TRION PLL requires a power-on self-calibration which happens when the
+ * PLL comes out of reset. Calibrate in case it is not completed.
+ */
+static int __alpha_pll_trion_prepare(struct clk_hw *hw, u32 pcal_done)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val;
+	int ret;
+
+	/* Return early if calibration is not needed. */
+	regmap_read(pll->clkr.regmap, PLL_STATUS(pll), &val);
+	if (val & pcal_done)
+		return 0;
+
+	/* On/off to calibrate */
+	ret = clk_trion_pll_enable(hw);
+	if (!ret)
+		clk_trion_pll_disable(hw);
+
+	return ret;
+}
+
+static int alpha_pll_trion_prepare(struct clk_hw *hw)
+{
+	return __alpha_pll_trion_prepare(hw, TRION_PCAL_DONE);
+}
+
+static int alpha_pll_lucid_prepare(struct clk_hw *hw)
+{
+	return __alpha_pll_trion_prepare(hw, LUCID_PCAL_DONE);
+}
+
+static int __alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long prate, u32 latch_bit, u32 latch_ack)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	unsigned long rrate;
+	u32 val, l, alpha_width = pll_alpha_width(pll);
+	u64 a;
+	int ret;
+
+	rrate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
+
+	ret = alpha_pll_check_rate_margin(hw, rrate, rate);
+	if (ret < 0)
+		return ret;
+
+	regmap_update_bits(pll->clkr.regmap, PLL_L_VAL(pll), LUCID_EVO_PLL_L_VAL_MASK,  l);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+
+	/* Latch the PLL input */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), latch_bit, latch_bit);
+	if (ret)
+		return ret;
+
+	/* Wait for 2 reference cycles before checking the ACK bit. */
+	udelay(1);
+	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (!(val & latch_ack)) {
+		pr_err("Lucid PLL latch failed. Output may be unstable!\n");
+		return -EINVAL;
+	}
+
+	/* Return the latch input to 0 */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), latch_bit, 0);
+	if (ret)
+		return ret;
+
+	if (clk_hw_is_enabled(hw)) {
+		ret = wait_for_pll_enable_lock(pll);
+		if (ret)
+			return ret;
+	}
+
+	/* Wait for PLL output to stabilize */
+	udelay(100);
+	return 0;
+}
+
+static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long prate)
+{
+	return __alpha_pll_trion_set_rate(hw, rate, prate, PLL_UPDATE, ALPHA_PLL_ACK_LATCH);
+}
+
+const struct clk_ops clk_alpha_pll_trion_ops = {
+	.prepare = alpha_pll_trion_prepare,
+	.enable = clk_trion_pll_enable,
+	.disable = clk_trion_pll_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = clk_trion_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = alpha_pll_trion_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_trion_ops);
+
+const struct clk_ops clk_alpha_pll_lucid_ops = {
+	.prepare = alpha_pll_lucid_prepare,
+	.enable = clk_trion_pll_enable,
+	.disable = clk_trion_pll_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = clk_trion_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = alpha_pll_trion_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_ops);
+
+const struct clk_ops clk_alpha_pll_postdiv_lucid_ops = {
+	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
+	.set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_ops);
+
+void clk_agera_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			const struct alpha_pll_config *config)
+{
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll),
+							config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll),
+						config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll),
+						config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll),
+						config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap,  PLL_TEST_CTL_U(pll),
+						config->test_ctl_hi_val);
+}
+EXPORT_SYMBOL_GPL(clk_agera_pll_configure);
+
+static int clk_alpha_pll_agera_set_rate(struct clk_hw *hw, unsigned long rate,
+							unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, alpha_width = pll_alpha_width(pll);
+	int ret;
+	unsigned long rrate;
+	u64 a;
+
+	rrate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
+	ret = alpha_pll_check_rate_margin(hw, rrate, rate);
+	if (ret < 0)
+		return ret;
+
+	/* change L_VAL without having to go through the power on sequence */
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+
+	if (clk_hw_is_enabled(hw))
+		return wait_for_pll_enable_lock(pll);
+
+	return 0;
+}
+
+const struct clk_ops clk_alpha_pll_agera_ops = {
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = alpha_pll_fabia_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = clk_alpha_pll_agera_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_agera_ops);
+
+/**
+ * clk_lucid_5lpe_pll_configure - configure the lucid 5lpe pll
+ *
+ * @pll: clk alpha pll
+ * @regmap: register map
+ * @config: configuration to apply for pll
+ */
+void clk_lucid_5lpe_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				  const struct alpha_pll_config *config)
+{
+	/*
+	 * If the bootloader left the PLL enabled it's likely that there are
+	 * RCGs that will lock up if we disable the PLL below.
+	 */
+	if (trion_pll_is_enabled(pll, regmap)) {
+		pr_debug("Lucid 5LPE PLL is already enabled, skipping configuration\n");
+		return;
+	}
+
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	regmap_write(regmap, PLL_CAL_L_VAL(pll), TRION_PLL_CAL_VAL);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll),
+				     config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll),
+				     config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll),
+				     config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll),
+					config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll),
+					config->user_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U1(pll),
+					config->user_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll),
+					config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll),
+					config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll),
+					config->test_ctl_hi1_val);
+
+	/* Disable PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll),  PLL_OUTCTRL, 0);
+
+	/* Set operation mode to OFF */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+
+	/* Place the PLL in STANDBY mode */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+}
+EXPORT_SYMBOL_GPL(clk_lucid_5lpe_pll_configure);
+
+static int alpha_pll_lucid_5lpe_enable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return ret;
+
+	/* If in FSM mode, just vote for it */
+	if (val & LUCID_5LPE_ENABLE_VOTE_RUN) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+		return wait_for_pll_enable_lock(pll);
+	}
+
+	/* Check if PLL is already enabled, return if enabled */
+	if (trion_pll_is_enabled(pll, pll->clkr.regmap))
+		return 0;
+
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+	if (ret)
+		return ret;
+
+	regmap_write(pll->clkr.regmap, PLL_OPMODE(pll), PLL_RUN);
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable the PLL outputs */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, PLL_OUT_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable the global PLL outputs */
+	return regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
+}
+
+static void alpha_pll_lucid_5lpe_disable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(pll->clkr.regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return;
+
+	/* If in FSM mode, just unvote it */
+	if (val & LUCID_5LPE_ENABLE_VOTE_RUN) {
+		clk_disable_regmap(hw);
+		return;
+	}
+
+	/* Disable the global PLL output */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+	if (ret)
+		return;
+
+	/* Disable the PLL outputs */
+	ret = regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, 0);
+	if (ret)
+		return;
+
+	/* Place the PLL mode in STANDBY */
+	regmap_write(pll->clkr.regmap, PLL_OPMODE(pll), PLL_STANDBY);
+}
+
+/*
+ * The Lucid 5LPE PLL requires a power-on self-calibration which happens
+ * when the PLL comes out of reset. Calibrate in case it is not completed.
+ */
+static int alpha_pll_lucid_5lpe_prepare(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct clk_hw *p;
+	u32 val = 0;
+	int ret;
+
+	/* Return early if calibration is not needed. */
+	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (val & LUCID_5LPE_PCAL_DONE)
+		return 0;
+
+	p = clk_hw_get_parent(hw);
+	if (!p)
+		return -EINVAL;
+
+	ret = alpha_pll_lucid_5lpe_enable(hw);
+	if (ret)
+		return ret;
+
+	alpha_pll_lucid_5lpe_disable(hw);
+
+	return 0;
+}
+
+static int alpha_pll_lucid_5lpe_set_rate(struct clk_hw *hw, unsigned long rate,
+					 unsigned long prate)
+{
+	return __alpha_pll_trion_set_rate(hw, rate, prate,
+					  LUCID_5LPE_PLL_LATCH_INPUT,
+					  LUCID_5LPE_ALPHA_PLL_ACK_LATCH);
+}
+
+static int __clk_lucid_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+					    unsigned long parent_rate,
+					    unsigned long enable_vote_run)
+{
+	struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	int i, val, div, ret;
+	u32 mask;
+
+	/*
+	 * If the PLL is in FSM mode, then treat set_rate callback as a
+	 * no-operation.
+	 */
+	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return ret;
+
+	if (val & enable_vote_run)
+		return 0;
+
+	if (!pll->post_div_table) {
+		pr_err("Missing the post_div_table for the %s PLL\n",
+		       clk_hw_get_name(&pll->clkr.hw));
+		return -EINVAL;
+	}
+
+	div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+	for (i = 0; i < pll->num_post_div; i++) {
+		if (pll->post_div_table[i].div == div) {
+			val = pll->post_div_table[i].val;
+			break;
+		}
+	}
+
+	mask = GENMASK(pll->width + pll->post_div_shift - 1, pll->post_div_shift);
+	return regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+				  mask, val << pll->post_div_shift);
+}
+
+static int clk_lucid_5lpe_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+					       unsigned long parent_rate)
+{
+	return __clk_lucid_pll_postdiv_set_rate(hw, rate, parent_rate, LUCID_5LPE_ENABLE_VOTE_RUN);
+}
+
+const struct clk_ops clk_alpha_pll_lucid_5lpe_ops = {
+	.prepare = alpha_pll_lucid_5lpe_prepare,
+	.enable = alpha_pll_lucid_5lpe_enable,
+	.disable = alpha_pll_lucid_5lpe_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = clk_trion_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = alpha_pll_lucid_5lpe_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_5lpe_ops);
+
+const struct clk_ops clk_alpha_pll_fixed_lucid_5lpe_ops = {
+	.enable = alpha_pll_lucid_5lpe_enable,
+	.disable = alpha_pll_lucid_5lpe_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = clk_trion_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_5lpe_ops);
+
+const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops = {
+	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
+	.set_rate = clk_lucid_5lpe_pll_postdiv_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_5lpe_ops);
+
+void clk_zonda_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config)
+{
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll), config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll), config->user_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U1(pll), config->user_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
+
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_BYPASSNL, 0);
+
+	/* Disable PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+
+	/* Set operation mode to OFF */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+
+	/* Place the PLL in STANDBY mode */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+}
+EXPORT_SYMBOL_GPL(clk_zonda_pll_configure);
+
+static int clk_zonda_pll_enable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+	int ret;
+
+	regmap_read(regmap, PLL_MODE(pll), &val);
+
+	/* If in FSM mode, just vote for it */
+	if (val & PLL_VOTE_FSM_ENA) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+		return wait_for_pll_enable_active(pll);
+	}
+
+	/* Get the PLL out of bypass mode */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_BYPASSNL, PLL_BYPASSNL);
+
+	/*
+	 * H/W requires a 1us delay between disabling the bypass and
+	 * de-asserting the reset.
+	 */
+	udelay(1);
+
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+
+	/* Set operation mode to RUN */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_RUN);
+
+	regmap_read(regmap, PLL_TEST_CTL(pll), &val);
+
+	/* If cfa mode then poll for freq lock */
+	if (val & ZONDA_STAY_IN_CFA)
+		ret = wait_for_zonda_pll_freq_lock(pll);
+	else
+		ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable the PLL outputs */
+	regmap_update_bits(regmap, PLL_USER_CTL(pll), ZONDA_PLL_OUT_MASK, ZONDA_PLL_OUT_MASK);
+
+	/* Enable the global PLL outputs */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
+
+	return 0;
+}
+
+static void clk_zonda_pll_disable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+
+	regmap_read(regmap, PLL_MODE(pll), &val);
+
+	/* If in FSM mode, just unvote it */
+	if (val & PLL_VOTE_FSM_ENA) {
+		clk_disable_regmap(hw);
+		return;
+	}
+
+	/* Disable the global PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+
+	/* Disable the PLL outputs */
+	regmap_update_bits(regmap, PLL_USER_CTL(pll), ZONDA_PLL_OUT_MASK, 0);
+
+	/* Put the PLL in bypass and reset */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N | PLL_BYPASSNL, 0);
+
+	/* Place the PLL mode in OFF state */
+	regmap_write(regmap, PLL_OPMODE(pll), 0x0);
+}
+
+static void zonda_pll_adjust_l_val(unsigned long rate, unsigned long prate, u32 *l)
+{
+	u64 remainder, quotient;
+
+	quotient = rate;
+	remainder = do_div(quotient, prate);
+
+	*l = rate + (u32)(remainder * 2 >= prate);
+}
+
+static int clk_zonda_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	unsigned long rrate;
+	u32 test_ctl_val;
+	u32 l, alpha_width = pll_alpha_width(pll);
+	u64 a;
+	int ret;
+
+	rrate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
+
+	ret = alpha_pll_check_rate_margin(hw, rrate, rate);
+	if (ret < 0)
+		return ret;
+
+	if (a & PLL_ALPHA_MSB)
+		zonda_pll_adjust_l_val(rate, prate, &l);
+
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+
+	if (!clk_hw_is_enabled(hw))
+		return 0;
+
+	/* Wait before polling for the frequency latch */
+	udelay(5);
+
+	/* Read stay in cfa mode */
+	regmap_read(pll->clkr.regmap, PLL_TEST_CTL(pll), &test_ctl_val);
+
+	/* If cfa mode then poll for freq lock */
+	if (test_ctl_val & ZONDA_STAY_IN_CFA)
+		ret = wait_for_zonda_pll_freq_lock(pll);
+	else
+		ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Wait for PLL output to stabilize */
+	udelay(100);
+	return 0;
+}
+
+const struct clk_ops clk_alpha_pll_zonda_ops = {
+	.enable = clk_zonda_pll_enable,
+	.disable = clk_zonda_pll_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = clk_trion_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = clk_zonda_pll_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_zonda_ops);
+
+void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				 const struct alpha_pll_config *config)
+{
+	u32 lval = config->l;
+
+	/*
+	 * If the bootloader left the PLL enabled it's likely that there are
+	 * RCGs that will lock up if we disable the PLL below.
+	 */
+	if (trion_pll_is_enabled(pll, regmap)) {
+		pr_debug("Lucid Evo PLL is already enabled, skipping configuration\n");
+		return;
+	}
+
+	lval |= TRION_PLL_CAL_VAL << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), lval);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll), config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll), config->user_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U2(pll), config->test_ctl_hi2_val);
+
+	/* Disable PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+
+	/* Set operation mode to STANDBY and de-assert the reset */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+}
+EXPORT_SYMBOL_GPL(clk_lucid_evo_pll_configure);
+
+void clk_lucid_ole_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				 const struct alpha_pll_config *config)
+{
+	u32 lval = config->l;
+
+	lval |= TRION_PLL_CAL_VAL << LUCID_EVO_PLL_CAL_L_VAL_SHIFT;
+	lval |= TRION_PLL_CAL_VAL << LUCID_OLE_PLL_RINGOSC_CAL_L_VAL_SHIFT;
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), lval);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll), config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll), config->user_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U2(pll), config->test_ctl_hi2_val);
+
+	/* Disable PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+
+	/* Set operation mode to STANDBY and de-assert the reset */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+}
+EXPORT_SYMBOL_GPL(clk_lucid_ole_pll_configure);
+
+static int alpha_pll_lucid_evo_enable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return ret;
+
+	/* If in FSM mode, just vote for it */
+	if (val & LUCID_EVO_ENABLE_VOTE_RUN) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+		return wait_for_pll_enable_lock(pll);
+	}
+
+	/* Check if PLL is already enabled */
+	if (trion_pll_is_enabled(pll, regmap))
+		return 0;
+
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+	if (ret)
+		return ret;
+
+	/* Set operation mode to RUN */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_RUN);
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable the PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, PLL_OUT_MASK);
+	if (ret)
+		return ret;
+
+	/* Enable the global PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
+	if (ret)
+		return ret;
+
+	/* Ensure that the write above goes through before returning. */
+	mb();
+	return ret;
+}
+
+static void _alpha_pll_lucid_evo_disable(struct clk_hw *hw, bool reset)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, PLL_USER_CTL(pll), &val);
+	if (ret)
+		return;
+
+	/* If in FSM mode, just unvote it */
+	if (val & LUCID_EVO_ENABLE_VOTE_RUN) {
+		clk_disable_regmap(hw);
+		return;
+	}
+
+	/* Disable the global PLL output */
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+	if (ret)
+		return;
+
+	/* Disable the PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_USER_CTL(pll), PLL_OUT_MASK, 0);
+	if (ret)
+		return;
+
+	/* Place the PLL mode in STANDBY */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+
+	if (reset)
+		regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, 0);
+}
+
+static int _alpha_pll_lucid_evo_prepare(struct clk_hw *hw, bool reset)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct clk_hw *p;
+	u32 val = 0;
+	int ret;
+
+	/* Return early if calibration is not needed. */
+	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+	if (!(val & LUCID_EVO_PCAL_NOT_DONE))
+		return 0;
+
+	p = clk_hw_get_parent(hw);
+	if (!p)
+		return -EINVAL;
+
+	ret = alpha_pll_lucid_evo_enable(hw);
+	if (ret)
+		return ret;
+
+	_alpha_pll_lucid_evo_disable(hw, reset);
+
+	return 0;
+}
+
+static void alpha_pll_lucid_evo_disable(struct clk_hw *hw)
+{
+	_alpha_pll_lucid_evo_disable(hw, false);
+}
+
+static int alpha_pll_lucid_evo_prepare(struct clk_hw *hw)
+{
+	return _alpha_pll_lucid_evo_prepare(hw, false);
+}
+
+static void alpha_pll_reset_lucid_evo_disable(struct clk_hw *hw)
+{
+	_alpha_pll_lucid_evo_disable(hw, true);
+}
+
+static int alpha_pll_reset_lucid_evo_prepare(struct clk_hw *hw)
+{
+	return _alpha_pll_lucid_evo_prepare(hw, true);
+}
+
+static unsigned long alpha_pll_lucid_evo_recalc_rate(struct clk_hw *hw,
+						     unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 l, frac;
+
+	if (regmap_read(regmap, PLL_L_VAL(pll), &l))
+		return 0;
+	l &= LUCID_EVO_PLL_L_VAL_MASK;
+
+	if (regmap_read(regmap, PLL_ALPHA_VAL(pll), &frac))
+		return 0;
+
+	return alpha_pll_calc_rate(parent_rate, l, frac, pll_alpha_width(pll));
+}
+
+static int clk_lucid_evo_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+					      unsigned long parent_rate)
+{
+	return __clk_lucid_pll_postdiv_set_rate(hw, rate, parent_rate, LUCID_EVO_ENABLE_VOTE_RUN);
+}
+
+const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops = {
+	.enable = alpha_pll_lucid_evo_enable,
+	.disable = alpha_pll_lucid_evo_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_evo_ops);
+
+const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops = {
+	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
+	.determine_rate = clk_alpha_pll_postdiv_fabia_determine_rate,
+	.set_rate = clk_lucid_evo_pll_postdiv_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_evo_ops);
+
+const struct clk_ops clk_alpha_pll_lucid_evo_ops = {
+	.prepare = alpha_pll_lucid_evo_prepare,
+	.enable = alpha_pll_lucid_evo_enable,
+	.disable = alpha_pll_lucid_evo_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = alpha_pll_lucid_5lpe_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_evo_ops);
+
+const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops = {
+	.prepare = alpha_pll_reset_lucid_evo_prepare,
+	.enable = alpha_pll_lucid_evo_enable,
+	.disable = alpha_pll_reset_lucid_evo_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = alpha_pll_lucid_evo_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = alpha_pll_lucid_5lpe_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_reset_lucid_evo_ops);
+
+static int alpha_pll_pongo_elu_prepare(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	int ret;
+
+	/* Enable PLL intially to one-time calibrate against XO. */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_RUN);
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+	regmap_update_bits(regmap, PLL_MODE(pll), PONGO_XO_PRESENT, PONGO_XO_PRESENT);
+
+	/* Set regmap for wait_for_pll() */
+	pll->clkr.regmap = regmap;
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret) {
+		/* Reverse calibration - disable PLL output */
+		regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+		return ret;
+	}
+
+	/* Disable PLL after one-time calibration. */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+
+	/* Select internally generated clock. */
+	regmap_update_bits(regmap, PLL_MODE(pll), PONGO_CLOCK_SELECT,
+			   PONGO_CLOCK_SELECT);
+
+	return 0;
+}
+
+static int alpha_pll_pongo_elu_enable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	int ret;
+
+	/* Check if PLL is already enabled */
+	if (trion_pll_is_enabled(pll, regmap))
+		return 0;
+
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
+	if (ret)
+		return ret;
+
+	/* Set operation mode to RUN */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_RUN);
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret)
+		return ret;
+
+	/* Enable the global PLL outputs */
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, PLL_OUTCTRL);
+	if (ret)
+		return ret;
+
+	/* Ensure that the write above goes through before returning. */
+	mb();
+
+	return ret;
+}
+
+static void alpha_pll_pongo_elu_disable(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	int ret;
+
+	/* Disable the global PLL output */
+	ret = regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+	if (ret)
+		return;
+
+	/* Place the PLL mode in STANDBY */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+}
+
+static unsigned long alpha_pll_pongo_elu_recalc_rate(struct clk_hw *hw,
+						     unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct regmap *regmap = pll->clkr.regmap;
+	u32 l;
+
+	if (regmap_read(regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	l &= PONGO_PLL_L_VAL_MASK;
+
+	return alpha_pll_calc_rate(parent_rate, l, 0, pll_alpha_width(pll));
+}
+
+const struct clk_ops clk_alpha_pll_pongo_elu_ops = {
+	.prepare = alpha_pll_pongo_elu_prepare,
+	.enable = alpha_pll_pongo_elu_enable,
+	.disable = alpha_pll_pongo_elu_disable,
+	.recalc_rate = alpha_pll_pongo_elu_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_pongo_elu_ops);
+
+void clk_pongo_elu_pll_configure(struct clk_alpha_pll *pll,
+				 struct regmap *regmap,
+				 const struct alpha_pll_config *config)
+{
+	u32 val;
+
+	regmap_update_bits(regmap, PLL_USER_CTL(pll), PONGO_PLL_OUT_MASK,
+			   PONGO_PLL_OUT_MASK);
+
+	if (trion_pll_is_enabled(pll, regmap))
+		return;
+
+	if (regmap_read(regmap, PLL_L_VAL(pll), &val))
+		return;
+	val &= PONGO_PLL_L_VAL_MASK;
+	if (val)
+		return;
+
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U2(pll), config->config_ctl_hi2_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll),
+				   config->user_ctl_val | PONGO_PLL_OUT_MASK);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll), config->user_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U2(pll), config->test_ctl_hi2_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U3(pll), config->test_ctl_hi3_val);
+
+	/* Disable PLL output */
+	regmap_update_bits(regmap, PLL_MODE(pll), PLL_OUTCTRL, 0);
+}
+EXPORT_SYMBOL_GPL(clk_pongo_elu_pll_configure);
+
+void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				  const struct alpha_pll_config *config)
+{
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll), config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll), config->user_ctl_hi_val);
+
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+
+	regmap_update_bits(regmap, PLL_MODE(pll),
+			   PLL_RESET_N | PLL_BYPASSNL | PLL_OUTCTRL,
+			   PLL_RESET_N | PLL_BYPASSNL);
+}
+EXPORT_SYMBOL_GPL(clk_rivian_evo_pll_configure);
+
+static unsigned long clk_rivian_evo_pll_recalc_rate(struct clk_hw *hw,
+						    unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l;
+
+	if (regmap_read(pll->clkr.regmap, PLL_L_VAL(pll), &l))
+		return 0;
+
+	return parent_rate * l;
+}
+
+static int clk_rivian_evo_pll_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	unsigned long min_freq, max_freq;
+	u32 l;
+	u64 a;
+
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate, &l,
+					 &a, 0);
+	if (!pll->vco_table || alpha_pll_find_vco(pll, req->rate))
+		return 0;
+
+	min_freq = pll->vco_table[0].min_freq;
+	max_freq = pll->vco_table[pll->num_vco - 1].max_freq;
+
+	req->rate = clamp(req->rate, min_freq, max_freq);
+
+	return 0;
+}
+
+const struct clk_ops clk_alpha_pll_rivian_evo_ops = {
+	.enable = alpha_pll_lucid_5lpe_enable,
+	.disable = alpha_pll_lucid_5lpe_disable,
+	.is_enabled = clk_trion_pll_is_enabled,
+	.recalc_rate = clk_rivian_evo_pll_recalc_rate,
+	.determine_rate = clk_rivian_evo_pll_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_rivian_evo_ops);
+
+void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			       const struct alpha_pll_config *config)
+{
+	u32 val, val_u, mask, mask_u;
+
+	regmap_write(regmap, PLL_L_VAL(pll), config->l);
+	regmap_write(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	regmap_write(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+
+	if (pll_has_64bit_config(pll))
+		regmap_write(regmap, PLL_CONFIG_CTL_U(pll),
+			     config->config_ctl_hi_val);
+
+	if (pll_alpha_width(pll) > 32)
+		regmap_write(regmap, PLL_ALPHA_VAL_U(pll), config->alpha_hi);
+
+	val = config->main_output_mask;
+	val |= config->aux_output_mask;
+	val |= config->aux2_output_mask;
+	val |= config->early_output_mask;
+	val |= config->pre_div_val;
+	val |= config->post_div_val;
+	val |= config->vco_val;
+	val |= config->alpha_en_mask;
+	val |= config->alpha_mode_mask;
+
+	mask = config->main_output_mask;
+	mask |= config->aux_output_mask;
+	mask |= config->aux2_output_mask;
+	mask |= config->early_output_mask;
+	mask |= config->pre_div_mask;
+	mask |= config->post_div_mask;
+	mask |= config->vco_mask;
+	mask |= config->alpha_en_mask;
+	mask |= config->alpha_mode_mask;
+
+	regmap_update_bits(regmap, PLL_USER_CTL(pll), mask, val);
+
+	/* Stromer APSS PLL does not enable LOCK_DET by default, so enable it */
+	val_u = config->status_val << ALPHA_PLL_STATUS_REG_SHIFT;
+	val_u |= config->lock_det;
+
+	mask_u = config->status_mask;
+	mask_u |= config->lock_det;
+
+	regmap_update_bits(regmap, PLL_USER_CTL_U(pll), mask_u, val_u);
+	regmap_write(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	regmap_write(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+
+	if (pll->flags & SUPPORTS_FSM_MODE)
+		qcom_pll_set_fsm_mode(regmap, PLL_MODE(pll), 6, 0);
+}
+EXPORT_SYMBOL_GPL(clk_stromer_pll_configure);
+
+static int clk_alpha_pll_stromer_determine_rate(struct clk_hw *hw,
+						struct clk_rate_request *req)
+{
+	u32 l;
+	u64 a;
+
+	req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate,
+					 &l, &a, ALPHA_REG_BITWIDTH);
+
+	return 0;
+}
+
+static int clk_alpha_pll_stromer_set_rate(struct clk_hw *hw, unsigned long rate,
+					  unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	int ret;
+	u32 l;
+	u64 a;
+
+	rate = alpha_pll_round_rate(rate, prate, &l, &a, ALPHA_REG_BITWIDTH);
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+
+	a <<= ALPHA_REG_BITWIDTH - ALPHA_BITWIDTH;
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
+		     a >> ALPHA_BITWIDTH);
+
+	regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+			   PLL_ALPHA_EN, PLL_ALPHA_EN);
+
+	if (!clk_hw_is_enabled(hw))
+		return 0;
+
+	/*
+	 * Stromer PLL supports Dynamic programming.
+	 * It allows the PLL frequency to be changed on-the-fly without first
+	 * execution of a shutdown procedure followed by a bring up procedure.
+	 */
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE,
+			   PLL_UPDATE);
+
+	ret = wait_for_pll_update(pll);
+	if (ret)
+		return ret;
+
+	return wait_for_pll_enable_lock(pll);
+}
+
+const struct clk_ops clk_alpha_pll_stromer_ops = {
+	.enable = clk_alpha_pll_enable,
+	.disable = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_stromer_determine_rate,
+	.set_rate = clk_alpha_pll_stromer_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
+
+static int clk_alpha_pll_stromer_plus_set_rate(struct clk_hw *hw,
+					       unsigned long rate,
+					       unsigned long prate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	u32 l, alpha_width = pll_alpha_width(pll);
+	int ret, pll_mode;
+	u64 a;
+
+	rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
+
+	ret = regmap_read(pll->clkr.regmap, PLL_MODE(pll), &pll_mode);
+	if (ret)
+		return ret;
+
+	regmap_write(pll->clkr.regmap, PLL_MODE(pll), 0);
+
+	/* Delay of 2 output clock ticks required until output is disabled */
+	udelay(1);
+
+	regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
+
+	if (alpha_width > ALPHA_BITWIDTH)
+		a <<= alpha_width - ALPHA_BITWIDTH;
+
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
+	regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
+					a >> ALPHA_BITWIDTH);
+
+	regmap_update_bits(pll->clkr.regmap, PLL_USER_CTL(pll),
+			   PLL_ALPHA_EN, PLL_ALPHA_EN);
+
+	regmap_write(pll->clkr.regmap, PLL_MODE(pll), PLL_BYPASSNL);
+
+	/* Wait five micro seconds or more */
+	udelay(5);
+	regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_RESET_N,
+			   PLL_RESET_N);
+
+	/* The lock time should be less than 50 micro seconds worst case */
+	usleep_range(50, 60);
+
+	ret = wait_for_pll_enable_lock(pll);
+	if (ret) {
+		pr_err("Wait for PLL enable lock failed [%s] %d\n",
+		       clk_hw_get_name(hw), ret);
+		return ret;
+	}
+
+	if (pll_mode & PLL_OUTCTRL)
+		regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL,
+				   PLL_OUTCTRL);
+
+	return 0;
+}
+
+const struct clk_ops clk_alpha_pll_stromer_plus_ops = {
+	.prepare = clk_alpha_pll_enable,
+	.unprepare = clk_alpha_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_stromer_determine_rate,
+	.set_rate = clk_alpha_pll_stromer_plus_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_plus_ops);
+
+void clk_regera_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config)
+{
+	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
+	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U(pll), config->config_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL_U1(pll), config->config_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL(pll), config->user_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U(pll), config->user_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_USER_CTL_U1(pll), config->user_ctl_hi1_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL(pll), config->test_ctl_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U(pll), config->test_ctl_hi_val);
+	clk_alpha_pll_write_config(regmap, PLL_TEST_CTL_U1(pll), config->test_ctl_hi1_val);
+
+	/* Set operation mode to STANDBY */
+	regmap_write(regmap, PLL_OPMODE(pll), PLL_STANDBY);
+}
+EXPORT_SYMBOL_GPL(clk_regera_pll_configure);
+
+const struct clk_ops clk_alpha_pll_regera_ops = {
+	.enable = clk_zonda_pll_enable,
+	.disable = clk_zonda_pll_disable,
+	.is_enabled = clk_alpha_pll_is_enabled,
+	.recalc_rate = clk_trion_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = clk_zonda_pll_set_rate,
+};
+EXPORT_SYMBOL_GPL(clk_alpha_pll_regera_ops);
+
+void qcom_clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap)
+{
+	const struct clk_init_data *init = pll->clkr.hw.init;
+
+	switch (GET_PLL_TYPE(pll)) {
+	case CLK_ALPHA_PLL_TYPE_LUCID_OLE:
+		clk_lucid_ole_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_LUCID_EVO:
+		clk_lucid_evo_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_TAYCAN_ELU:
+		clk_taycan_elu_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_RIVIAN_EVO:
+		clk_rivian_evo_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_TRION:
+		clk_trion_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_HUAYRA_2290:
+		clk_huayra_2290_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_FABIA:
+		clk_fabia_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_AGERA:
+		clk_agera_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_PONGO_ELU:
+		clk_pongo_elu_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_ZONDA:
+	case CLK_ALPHA_PLL_TYPE_ZONDA_OLE:
+		clk_zonda_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_STROMER:
+	case CLK_ALPHA_PLL_TYPE_STROMER_PLUS:
+		clk_stromer_pll_configure(pll, regmap, pll->config);
+		break;
+	case CLK_ALPHA_PLL_TYPE_DEFAULT:
+	case CLK_ALPHA_PLL_TYPE_DEFAULT_EVO:
+	case CLK_ALPHA_PLL_TYPE_HUAYRA:
+	case CLK_ALPHA_PLL_TYPE_HUAYRA_APSS:
+	case CLK_ALPHA_PLL_TYPE_BRAMMO:
+	case CLK_ALPHA_PLL_TYPE_BRAMMO_EVO:
+		clk_alpha_pll_configure(pll, regmap, pll->config);
+		break;
+	default:
+		WARN(1, "%s: invalid pll type\n", init->name);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(qcom_clk_alpha_pll_configure);
+
+static int clk_alpha_pll_slew_update(struct clk_alpha_pll *pll)
+{
+	u32 val;
+	int ret;
+
+	regmap_set_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_UPDATE);
+	regmap_read(pll->clkr.regmap, PLL_MODE(pll), &val);
+
+	ret = wait_for_pll_update(pll);
+	if (ret)
+		return ret;
+	/*
+	 * Hardware programming mandates a wait of at least 570ns before polling the LOCK
+	 * detect bit. Have a delay of 1us just to be safe.
+	 */
+	udelay(1);
+
+	return wait_for_pll_enable_lock(pll);
+}
+
+static int clk_alpha_pll_slew_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	const struct pll_vco *curr_vco, *vco;
+	unsigned long freq_hz;
+	u64 a;
+	u32 l;
+
+	freq_hz = alpha_pll_round_rate(rate, parent_rate, &l, &a, ALPHA_REG_BITWIDTH);
+	if (freq_hz != rate) {
+		pr_err("alpha_pll: Call clk_set_rate with rounded rates!\n");
+		return -EINVAL;
+	}
+
+	curr_vco = alpha_pll_find_vco(pll, clk_hw_get_rate(hw));
+	if (!curr_vco) {
+		pr_err("alpha pll: not in a valid vco range\n");
+		return -EINVAL;
+	}
+
+	vco = alpha_pll_find_vco(pll, freq_hz);
+	if (!vco) {
+		pr_err("alpha pll: not in a valid vco range\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Dynamic pll update will not support switching frequencies across
+	 * vco ranges. In those cases fall back to normal alpha set rate.
+	 */
+	if (curr_vco->val != vco->val)
+		return clk_alpha_pll_set_rate(hw, rate, parent_rate);
+
+	clk_alpha_pll_update_configs(pll, NULL, l, a, ALPHA_REG_BITWIDTH, false);
+
+	/* Ensure that the write above goes before slewing the PLL */
+	mb();
+
+	if (clk_hw_is_enabled(hw))
+		return clk_alpha_pll_slew_update(pll);
+
+	return 0;
+}
+
+/*
+ * Slewing plls should be bought up at frequency which is in the middle of the
+ * desired VCO range. So after bringing up the pll at calibration freq, set it
+ * back to desired frequency(that was set by previous clk_set_rate).
+ */
+static int clk_alpha_pll_calibrate(struct clk_hw *hw)
+{
+	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
+	struct clk_hw *parent;
+	const struct pll_vco *vco;
+	unsigned long calibration_freq, freq_hz;
+	u64 a;
+	u32 l;
+	int rc;
+
+	parent = clk_hw_get_parent(hw);
+	if (!parent) {
+		pr_err("alpha pll: no valid parent found\n");
+		return -EINVAL;
+	}
+
+	vco = alpha_pll_find_vco(pll, clk_hw_get_rate(hw));
+	if (!vco) {
+		pr_err("alpha pll: not in a valid vco range\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * As during slewing plls vco_sel won't be allowed to change, vco table
+	 * should have only one entry table, i.e. index = 0, find the
+	 * calibration frequency.
+	 */
+	calibration_freq = (pll->vco_table[0].min_freq + pll->vco_table[0].max_freq) / 2;
+
+	freq_hz = alpha_pll_round_rate(calibration_freq, clk_hw_get_rate(parent),
+					&l, &a, ALPHA_REG_BITWIDTH);
+	if (freq_hz != calibration_freq) {
+		pr_err("alpha_pll: call clk_set_rate with rounded rates!\n");
+		return -EINVAL;
+	}
+
+	clk_alpha_pll_update_configs(pll, vco, l, a, ALPHA_REG_BITWIDTH, false);
+
+	/* Bringup the pll at calibration frequency */
+	rc = clk_alpha_pll_enable(hw);
+	if (rc) {
+		pr_err("alpha pll calibration failed\n");
+		return rc;
+	}
+
+	/*
+	 * PLL is already running at calibration frequency.
+	 * So slew pll to the previously set frequency.
+	 */
+	freq_hz = alpha_pll_round_rate(clk_hw_get_rate(hw),
+			clk_hw_get_rate(parent), &l, &a, ALPHA_REG_BITWIDTH);
+
+	pr_debug("pll %s: setting back to required rate %lu, freq_hz %ld\n",
+		clk_hw_get_name(hw), clk_hw_get_rate(hw), freq_hz);
+
+	clk_alpha_pll_update_configs(pll, NULL, l, a, ALPHA_REG_BITWIDTH, true);
+
+	return clk_alpha_pll_slew_update(pll);
+}
+
+static int clk_alpha_pll_slew_enable(struct clk_hw *hw)
+{
+	int rc;
+
+	rc = clk_alpha_pll_calibrate(hw);
+	if (rc)
+		return rc;
+
+	return clk_alpha_pll_enable(hw);
+}
+
+const struct clk_ops clk_alpha_pll_slew_ops = {
+	.enable = clk_alpha_pll_slew_enable,
+	.disable = clk_alpha_pll_disable,
+	.recalc_rate = clk_alpha_pll_recalc_rate,
+	.determine_rate = clk_alpha_pll_determine_rate,
+	.set_rate = clk_alpha_pll_slew_set_rate,
+};
+EXPORT_SYMBOL(clk_alpha_pll_slew_ops);
diff --git a/drivers/clk/qcom/ccf/clk-alpha-pll.h b/drivers/clk/qcom/ccf/clk-alpha-pll.h
new file mode 100644
index 000000000000..0903a05b18cc
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-alpha-pll.h
@@ -0,0 +1,251 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2015, 2018, 2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+
+#ifndef __QCOM_CLK_ALPHA_PLL_H__
+#define __QCOM_CLK_ALPHA_PLL_H__
+
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+
+/* Alpha PLL types */
+enum {
+	CLK_ALPHA_PLL_TYPE_DEFAULT,
+	CLK_ALPHA_PLL_TYPE_HUAYRA,
+	CLK_ALPHA_PLL_TYPE_HUAYRA_APSS,
+	CLK_ALPHA_PLL_TYPE_HUAYRA_2290,
+	CLK_ALPHA_PLL_TYPE_BRAMMO,
+	CLK_ALPHA_PLL_TYPE_FABIA,
+	CLK_ALPHA_PLL_TYPE_TRION,
+	CLK_ALPHA_PLL_TYPE_LUCID = CLK_ALPHA_PLL_TYPE_TRION,
+	CLK_ALPHA_PLL_TYPE_AGERA,
+	CLK_ALPHA_PLL_TYPE_ZONDA,
+	CLK_ALPHA_PLL_TYPE_REGERA = CLK_ALPHA_PLL_TYPE_ZONDA,
+	CLK_ALPHA_PLL_TYPE_ZONDA_OLE,
+	CLK_ALPHA_PLL_TYPE_LUCID_EVO,
+	CLK_ALPHA_PLL_TYPE_LUCID_OLE,
+	CLK_ALPHA_PLL_TYPE_PONGO_ELU,
+	CLK_ALPHA_PLL_TYPE_TAYCAN_ELU,
+	CLK_ALPHA_PLL_TYPE_TAYCAN_EKO_T = CLK_ALPHA_PLL_TYPE_TAYCAN_ELU,
+	CLK_ALPHA_PLL_TYPE_RIVIAN_EVO,
+	CLK_ALPHA_PLL_TYPE_DEFAULT_EVO,
+	CLK_ALPHA_PLL_TYPE_BRAMMO_EVO,
+	CLK_ALPHA_PLL_TYPE_STROMER,
+	CLK_ALPHA_PLL_TYPE_STROMER_PLUS,
+	CLK_ALPHA_PLL_TYPE_NSS_HUAYRA,
+	CLK_ALPHA_PLL_TYPE_MAX,
+};
+
+enum {
+	PLL_OFF_L_VAL,
+	PLL_OFF_CAL_L_VAL,
+	PLL_OFF_ALPHA_VAL,
+	PLL_OFF_ALPHA_VAL_U,
+	PLL_OFF_USER_CTL,
+	PLL_OFF_USER_CTL_U,
+	PLL_OFF_USER_CTL_U1,
+	PLL_OFF_CONFIG_CTL,
+	PLL_OFF_CONFIG_CTL_U,
+	PLL_OFF_CONFIG_CTL_U1,
+	PLL_OFF_CONFIG_CTL_U2,
+	PLL_OFF_TEST_CTL,
+	PLL_OFF_TEST_CTL_U,
+	PLL_OFF_TEST_CTL_U1,
+	PLL_OFF_TEST_CTL_U2,
+	PLL_OFF_TEST_CTL_U3,
+	PLL_OFF_STATE,
+	PLL_OFF_STATUS,
+	PLL_OFF_OPMODE,
+	PLL_OFF_FRAC,
+	PLL_OFF_CAL_VAL,
+	PLL_OFF_MAX_REGS
+};
+
+extern const u8 clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_MAX][PLL_OFF_MAX_REGS];
+
+struct pll_vco {
+	unsigned long min_freq;
+	unsigned long max_freq;
+	u32 val;
+};
+
+#define VCO(a, b, c) { \
+	.val = a,\
+	.min_freq = b,\
+	.max_freq = c,\
+}
+
+/**
+ * struct clk_alpha_pll - phase locked loop (PLL)
+ * @offset: base address of registers
+ * @regs: alpha pll register map (see @clk_alpha_pll_regs)
+ * @config: array of pll settings
+ * @vco_table: array of VCO settings
+ * @num_vco: number of VCO settings in @vco_table
+ * @flags: bitmask to indicate features supported by the hardware
+ * @clkr: regmap clock handle
+ */
+struct clk_alpha_pll {
+	u32 offset;
+	const u8 *regs;
+
+	const struct alpha_pll_config *config;
+	const struct pll_vco *vco_table;
+	size_t num_vco;
+#define SUPPORTS_OFFLINE_REQ		BIT(0)
+#define SUPPORTS_FSM_MODE		BIT(2)
+#define SUPPORTS_DYNAMIC_UPDATE	BIT(3)
+#define SUPPORTS_FSM_LEGACY_MODE	BIT(4)
+	u8 flags;
+
+	struct clk_regmap clkr;
+};
+
+/**
+ * struct clk_alpha_pll_postdiv - phase locked loop (PLL) post-divider
+ * @offset: base address of registers
+ * @regs: alpha pll register map (see @clk_alpha_pll_regs)
+ * @width: width of post-divider
+ * @post_div_shift: shift to differentiate between odd & even post-divider
+ * @post_div_table: table with PLL odd and even post-divider settings
+ * @num_post_div: Number of PLL post-divider settings
+ *
+ * @clkr: regmap clock handle
+ */
+struct clk_alpha_pll_postdiv {
+	u32 offset;
+	u8 width;
+	const u8 *regs;
+
+	struct clk_regmap clkr;
+	int post_div_shift;
+	const struct clk_div_table *post_div_table;
+	size_t num_post_div;
+};
+
+struct alpha_pll_config {
+	u32 l;
+	u32 alpha;
+	u32 alpha_hi;
+	u32 config_ctl_val;
+	u32 config_ctl_hi_val;
+	u32 config_ctl_hi1_val;
+	u32 config_ctl_hi2_val;
+	u32 user_ctl_val;
+	u32 user_ctl_hi_val;
+	u32 user_ctl_hi1_val;
+	u32 test_ctl_val;
+	u32 test_ctl_mask;
+	u32 test_ctl_hi_val;
+	u32 test_ctl_hi_mask;
+	u32 test_ctl_hi1_val;
+	u32 test_ctl_hi2_val;
+	u32 test_ctl_hi3_val;
+	u32 main_output_mask;
+	u32 aux_output_mask;
+	u32 aux2_output_mask;
+	u32 early_output_mask;
+	u32 alpha_en_mask;
+	u32 alpha_mode_mask;
+	u32 pre_div_val;
+	u32 pre_div_mask;
+	u32 post_div_val;
+	u32 post_div_mask;
+	u32 vco_val;
+	u32 vco_mask;
+	u32 status_val;
+	u32 status_mask;
+	u32 lock_det;
+};
+
+extern const struct clk_ops clk_alpha_pll_ops;
+extern const struct clk_ops clk_alpha_pll_fixed_ops;
+extern const struct clk_ops clk_alpha_pll_hwfsm_ops;
+extern const struct clk_ops clk_alpha_pll_postdiv_ops;
+extern const struct clk_ops clk_alpha_pll_huayra_ops;
+extern const struct clk_ops clk_alpha_pll_postdiv_ro_ops;
+extern const struct clk_ops clk_alpha_pll_stromer_ops;
+extern const struct clk_ops clk_alpha_pll_stromer_plus_ops;
+
+extern const struct clk_ops clk_alpha_pll_fabia_ops;
+extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
+extern const struct clk_ops clk_alpha_pll_postdiv_fabia_ops;
+
+extern const struct clk_ops clk_alpha_pll_trion_ops;
+extern const struct clk_ops clk_alpha_pll_fixed_trion_ops;
+extern const struct clk_ops clk_alpha_pll_postdiv_trion_ops;
+
+extern const struct clk_ops clk_alpha_pll_lucid_ops;
+#define clk_alpha_pll_fixed_lucid_ops clk_alpha_pll_fixed_trion_ops
+extern const struct clk_ops clk_alpha_pll_postdiv_lucid_ops;
+extern const struct clk_ops clk_alpha_pll_agera_ops;
+
+extern const struct clk_ops clk_alpha_pll_lucid_5lpe_ops;
+extern const struct clk_ops clk_alpha_pll_fixed_lucid_5lpe_ops;
+extern const struct clk_ops clk_alpha_pll_postdiv_lucid_5lpe_ops;
+
+extern const struct clk_ops clk_alpha_pll_zonda_ops;
+#define clk_alpha_pll_postdiv_zonda_ops clk_alpha_pll_postdiv_fabia_ops
+#define clk_alpha_pll_zonda_ole_ops clk_alpha_pll_zonda_ops
+
+extern const struct clk_ops clk_alpha_pll_lucid_evo_ops;
+#define clk_alpha_pll_taycan_elu_ops clk_alpha_pll_lucid_evo_ops
+#define clk_alpha_pll_taycan_eko_t_ops clk_alpha_pll_lucid_evo_ops
+extern const struct clk_ops clk_alpha_pll_reset_lucid_evo_ops;
+#define clk_alpha_pll_reset_lucid_ole_ops clk_alpha_pll_reset_lucid_evo_ops
+extern const struct clk_ops clk_alpha_pll_fixed_lucid_evo_ops;
+#define clk_alpha_pll_fixed_lucid_ole_ops clk_alpha_pll_fixed_lucid_evo_ops
+#define clk_alpha_pll_fixed_taycan_elu_ops clk_alpha_pll_fixed_lucid_evo_ops
+#define clk_alpha_pll_fixed_taycan_eko_t_ops clk_alpha_pll_fixed_lucid_evo_ops
+extern const struct clk_ops clk_alpha_pll_postdiv_lucid_evo_ops;
+#define clk_alpha_pll_postdiv_lucid_ole_ops clk_alpha_pll_postdiv_lucid_evo_ops
+#define clk_alpha_pll_postdiv_taycan_elu_ops clk_alpha_pll_postdiv_lucid_evo_ops
+#define clk_alpha_pll_postdiv_taycan_eko_t_ops clk_alpha_pll_postdiv_lucid_evo_ops
+
+extern const struct clk_ops clk_alpha_pll_pongo_elu_ops;
+extern const struct clk_ops clk_alpha_pll_rivian_evo_ops;
+#define clk_alpha_pll_postdiv_rivian_evo_ops clk_alpha_pll_postdiv_fabia_ops
+
+extern const struct clk_ops clk_alpha_pll_regera_ops;
+extern const struct clk_ops clk_alpha_pll_slew_ops;
+
+void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config);
+void clk_huayra_2290_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				   const struct alpha_pll_config *config);
+void clk_fabia_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				const struct alpha_pll_config *config);
+void clk_trion_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config);
+void clk_agera_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				const struct alpha_pll_config *config);
+#define clk_lucid_pll_configure(pll, regmap, config) \
+	clk_trion_pll_configure(pll, regmap, config)
+
+void clk_zonda_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config);
+void clk_lucid_5lpe_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				  const struct alpha_pll_config *config);
+void clk_lucid_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				 const struct alpha_pll_config *config);
+void clk_lucid_ole_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				 const struct alpha_pll_config *config);
+void clk_pongo_elu_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				 const struct alpha_pll_config *config);
+#define clk_taycan_elu_pll_configure(pll, regmap, config) \
+	clk_lucid_evo_pll_configure(pll, regmap, config)
+#define clk_taycan_eko_t_pll_configure(pll, regmap, config) \
+	clk_lucid_evo_pll_configure(pll, regmap, config)
+
+void clk_rivian_evo_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+				  const struct alpha_pll_config *config);
+void clk_stromer_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			       const struct alpha_pll_config *config);
+void clk_regera_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+			     const struct alpha_pll_config *config);
+void qcom_clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap);
+
+#endif
diff --git a/drivers/clk/qcom/ccf/clk-branch.c b/drivers/clk/qcom/ccf/clk-branch.c
new file mode 100644
index 000000000000..444e7d8648d4
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-branch.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+
+#include "clk-branch.h"
+
+static bool clk_branch_in_hwcg_mode(const struct clk_branch *br)
+{
+	u32 val;
+
+	if (!br->hwcg_reg)
+		return false;
+
+	regmap_read(br->clkr.regmap, br->hwcg_reg, &val);
+
+	return !!(val & BIT(br->hwcg_bit));
+}
+
+static bool clk_branch_check_halt(const struct clk_branch *br, bool enabling)
+{
+	bool invert = (br->halt_check & BRANCH_HALT_ENABLE);
+	u32 val;
+
+	regmap_read(br->clkr.regmap, br->halt_reg, &val);
+
+	val &= BIT(br->halt_bit);
+	if (invert)
+		val = !val;
+
+	return !!val == !enabling;
+}
+
+static bool clk_branch2_check_halt(const struct clk_branch *br, bool enabling)
+{
+	u32 val;
+	u32 mask;
+	bool invert = (br->halt_check & BRANCH_HALT_ENABLE);
+
+	mask = CBCR_NOC_FSM_STATUS;
+	mask |= CBCR_CLK_OFF;
+
+	regmap_read(br->clkr.regmap, br->halt_reg, &val);
+
+	if (enabling) {
+		val &= mask;
+		return (val & CBCR_CLK_OFF) == (invert ? CBCR_CLK_OFF : 0) ||
+			FIELD_GET(CBCR_NOC_FSM_STATUS, val) == FSM_STATUS_ON;
+	}
+	return (val & CBCR_CLK_OFF) == (invert ? 0 : CBCR_CLK_OFF);
+}
+
+static int clk_branch_wait(const struct clk_branch *br, bool enabling,
+		bool (check_halt)(const struct clk_branch *, bool))
+{
+	bool voted = br->halt_check & BRANCH_VOTED;
+	const char *name = clk_hw_get_name(&br->clkr.hw);
+
+	/*
+	 * Skip checking halt bit if we're explicitly ignoring the bit or the
+	 * clock is in hardware gated mode
+	 */
+	if (br->halt_check == BRANCH_HALT_SKIP || clk_branch_in_hwcg_mode(br))
+		return 0;
+
+	if (br->halt_check == BRANCH_HALT_DELAY || (!enabling && voted)) {
+		udelay(10);
+	} else if (br->halt_check == BRANCH_HALT_ENABLE ||
+		   br->halt_check == BRANCH_HALT ||
+		   (enabling && voted)) {
+		int count = 200;
+
+		while (count-- > 0) {
+			if (check_halt(br, enabling))
+				return 0;
+			udelay(1);
+		}
+		WARN(1, "%s status stuck at 'o%s'", name,
+				enabling ? "ff" : "n");
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static int clk_branch_toggle(struct clk_hw *hw, bool en,
+		bool (check_halt)(const struct clk_branch *, bool))
+{
+	struct clk_branch *br = to_clk_branch(hw);
+	int ret;
+
+	if (en) {
+		ret = clk_enable_regmap(hw);
+		if (ret)
+			return ret;
+	} else {
+		clk_disable_regmap(hw);
+	}
+
+	return clk_branch_wait(br, en, check_halt);
+}
+
+static int clk_branch_enable(struct clk_hw *hw)
+{
+	return clk_branch_toggle(hw, true, clk_branch_check_halt);
+}
+
+static void clk_branch_disable(struct clk_hw *hw)
+{
+	clk_branch_toggle(hw, false, clk_branch_check_halt);
+}
+
+const struct clk_ops clk_branch_ops = {
+	.enable = clk_branch_enable,
+	.disable = clk_branch_disable,
+	.is_enabled = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch_ops);
+
+static int clk_branch2_enable(struct clk_hw *hw)
+{
+	return clk_branch_toggle(hw, true, clk_branch2_check_halt);
+}
+
+static void clk_branch2_disable(struct clk_hw *hw)
+{
+	clk_branch_toggle(hw, false, clk_branch2_check_halt);
+}
+
+static int clk_branch2_mem_enable(struct clk_hw *hw)
+{
+	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
+	struct clk_branch branch = mem_br->branch;
+	u32 val;
+	int ret;
+
+	regmap_assign_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
+			   mem_br->mem_enable_mask, !mem_br->mem_enable_invert);
+
+	ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
+				       val, val & mem_br->mem_enable_ack_mask, 0, 200);
+	if (ret) {
+		WARN(1, "%s mem enable failed\n", clk_hw_get_name(&branch.clkr.hw));
+		return ret;
+	}
+
+	return clk_branch2_enable(hw);
+}
+
+static void clk_branch2_mem_disable(struct clk_hw *hw)
+{
+	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
+
+	regmap_assign_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
+			   mem_br->mem_enable_mask, mem_br->mem_enable_invert);
+
+	return clk_branch2_disable(hw);
+}
+
+const struct clk_ops clk_branch2_mem_ops = {
+	.enable = clk_branch2_mem_enable,
+	.disable = clk_branch2_mem_disable,
+	.is_enabled = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch2_mem_ops);
+
+const struct clk_ops clk_branch2_ops = {
+	.enable = clk_branch2_enable,
+	.disable = clk_branch2_disable,
+	.is_enabled = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch2_ops);
+
+const struct clk_ops clk_branch2_aon_ops = {
+	.enable = clk_branch2_enable,
+	.is_enabled = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch2_aon_ops);
+
+const struct clk_ops clk_branch_simple_ops = {
+	.enable = clk_enable_regmap,
+	.disable = clk_disable_regmap,
+	.is_enabled = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch_simple_ops);
+
+const struct clk_ops clk_branch2_prepare_ops = {
+	.prepare = clk_branch2_enable,
+	.unprepare = clk_branch2_disable,
+	.is_prepared = clk_is_enabled_regmap,
+};
+EXPORT_SYMBOL_GPL(clk_branch2_prepare_ops);
diff --git a/drivers/clk/qcom/ccf/clk-branch.h b/drivers/clk/qcom/ccf/clk-branch.h
new file mode 100644
index 000000000000..6bc2ba2b5350
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-branch.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2013, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_CLK_BRANCH_H__
+#define __QCOM_CLK_BRANCH_H__
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+
+#include "clk-regmap.h"
+
+/**
+ * struct clk_branch - gating clock with status bit and dynamic hardware gating
+ *
+ * @hwcg_reg: dynamic hardware clock gating register
+ * @hwcg_bit: ORed with @hwcg_reg to enable dynamic hardware clock gating
+ * @halt_reg: halt register
+ * @halt_bit: ANDed with @halt_reg to test for clock halted
+ * @halt_check: type of halt checking to perform
+ * @clkr: handle between common and hardware-specific interfaces
+ *
+ * Clock which can gate its output.
+ */
+struct clk_branch {
+	u32	hwcg_reg;
+	u32	halt_reg;
+	u8	hwcg_bit;
+	u8	halt_bit;
+	u8	halt_check;
+#define BRANCH_VOTED			BIT(7) /* Delay on disable */
+#define BRANCH_HALT			0 /* pol: 1 = halt */
+#define BRANCH_HALT_VOTED		(BRANCH_HALT | BRANCH_VOTED)
+#define BRANCH_HALT_ENABLE		1 /* pol: 0 = halt */
+#define BRANCH_HALT_ENABLE_VOTED	(BRANCH_HALT_ENABLE | BRANCH_VOTED)
+#define BRANCH_HALT_DELAY		2 /* No bit to check; just delay */
+#define BRANCH_HALT_SKIP		3 /* Don't check halt bit */
+
+	struct clk_regmap clkr;
+};
+
+/**
+ * struct clk_mem_branch - gating clock which are associated with memories
+ *
+ * @mem_enable_reg: branch clock memory gating register
+ * @mem_ack_reg: branch clock memory ack register
+ * @mem_enable_ack_mask: branch clock memory enable and ack field in @mem_ack_reg
+ * @mem_enable_mask: branch clock memory enable mask
+ * @mem_enable_invert: branch clock memory enable and disable has invert logic
+ * @branch: branch clock gating handle
+ *
+ * Clock which can gate its memories.
+ */
+struct clk_mem_branch {
+	u32	mem_enable_reg;
+	u32	mem_ack_reg;
+	u32	mem_enable_ack_mask;
+	u32	mem_enable_mask;
+	bool	mem_enable_invert;
+	struct clk_branch branch;
+};
+
+/* Branch clock common bits for HLOS-owned clocks */
+#define CBCR_CLK_OFF			BIT(31)
+#define CBCR_NOC_FSM_STATUS		GENMASK(30, 28)
+ #define FSM_STATUS_ON			BIT(1)
+#define CBCR_FORCE_MEM_CORE_ON		BIT(14)
+#define CBCR_FORCE_MEM_PERIPH_ON	BIT(13)
+#define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
+#define CBCR_WAKEUP			GENMASK(11, 8)
+#define CBCR_SLEEP			GENMASK(7, 4)
+#define CBCR_CLOCK_ENABLE		BIT(0)
+
+static inline void qcom_branch_set_force_mem_core(struct regmap *regmap,
+						  struct clk_branch clk, bool on)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_FORCE_MEM_CORE_ON,
+			   on ? CBCR_FORCE_MEM_CORE_ON : 0);
+}
+
+static inline void qcom_branch_set_force_periph_on(struct regmap *regmap,
+						   struct clk_branch clk, bool on)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_FORCE_MEM_PERIPH_ON,
+			   on ? CBCR_FORCE_MEM_PERIPH_ON : 0);
+}
+
+static inline void qcom_branch_set_force_periph_off(struct regmap *regmap,
+						    struct clk_branch clk, bool on)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_FORCE_MEM_PERIPH_OFF,
+			   on ? CBCR_FORCE_MEM_PERIPH_OFF : 0);
+}
+
+static inline void qcom_branch_set_wakeup(struct regmap *regmap, struct clk_branch clk, u32 val)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_WAKEUP,
+			   FIELD_PREP(CBCR_WAKEUP, val));
+}
+
+static inline void qcom_branch_set_sleep(struct regmap *regmap, struct clk_branch clk, u32 val)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_SLEEP,
+			   FIELD_PREP(CBCR_SLEEP, val));
+}
+
+static inline void qcom_branch_set_clk_en(struct regmap *regmap, u32 cbcr)
+{
+	regmap_update_bits(regmap, cbcr, CBCR_CLOCK_ENABLE, CBCR_CLOCK_ENABLE);
+}
+
+extern const struct clk_ops clk_branch_ops;
+extern const struct clk_ops clk_branch2_ops;
+extern const struct clk_ops clk_branch_simple_ops;
+extern const struct clk_ops clk_branch2_aon_ops;
+extern const struct clk_ops clk_branch2_mem_ops;
+extern const struct clk_ops clk_branch2_prepare_ops;
+
+#define to_clk_branch(_hw) \
+	container_of(to_clk_regmap(_hw), struct clk_branch, clkr)
+
+#define to_clk_mem_branch(_hw) \
+	container_of(to_clk_branch(_hw), struct clk_mem_branch, branch)
+
+#endif
diff --git a/drivers/clk/qcom/ccf/clk-rcg.h b/drivers/clk/qcom/ccf/clk-rcg.h
new file mode 100644
index 000000000000..4fbdf4880d03
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-rcg.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2013, 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_CLK_RCG_H__
+#define __QCOM_CLK_RCG_H__
+
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+
+#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
+
+struct freq_tbl {
+	unsigned long freq;
+	u8 src;
+	u8 pre_div;
+	u16 m;
+	u16 n;
+};
+
+#define C(s, h, m, n) { (s), (2 * (h) - 1), (m), (n) }
+#define FM(f, confs) { (f), ARRAY_SIZE(confs), (confs) }
+#define FMS(f, s, h, m, n) { (f), 1, (const struct freq_conf []){ C(s, h, m, n) } }
+
+struct freq_conf {
+	u8 src;
+	u8 pre_div;
+	u16 m;
+	u16 n;
+};
+
+struct freq_multi_tbl {
+	unsigned long freq;
+	size_t num_confs;
+	const struct freq_conf *confs;
+};
+
+/**
+ * struct mn - M/N:D counter
+ * @mnctr_en_bit: bit to enable mn counter
+ * @mnctr_reset_bit: bit to assert mn counter reset
+ * @mnctr_mode_shift: lowest bit of mn counter mode field
+ * @n_val_shift: lowest bit of n value field
+ * @m_val_shift: lowest bit of m value field
+ * @width: number of bits in m/n/d values
+ * @reset_in_cc: true if the mnctr_reset_bit is in the CC register
+ */
+struct mn {
+	u8		mnctr_en_bit;
+	u8		mnctr_reset_bit;
+	u8		mnctr_mode_shift;
+#define MNCTR_MODE_DUAL 0x2
+#define MNCTR_MODE_MASK 0x3
+	u8		n_val_shift;
+	u8		m_val_shift;
+	u8		width;
+	bool		reset_in_cc;
+};
+
+/**
+ * struct pre_div - pre-divider
+ * @pre_div_shift: lowest bit of pre divider field
+ * @pre_div_width: number of bits in predivider
+ */
+struct pre_div {
+	u8		pre_div_shift;
+	u8		pre_div_width;
+};
+
+/**
+ * struct src_sel - source selector
+ * @src_sel_shift: lowest bit of source selection field
+ * @parent_map: map from software's parent index to hardware's src_sel field
+ */
+struct src_sel {
+	u8		src_sel_shift;
+#define SRC_SEL_MASK	0x7
+	const struct parent_map	*parent_map;
+};
+
+/**
+ * struct clk_rcg - root clock generator
+ *
+ * @ns_reg: NS register
+ * @md_reg: MD register
+ * @mn: mn counter
+ * @p: pre divider
+ * @s: source selector
+ * @freq_tbl: frequency table
+ * @clkr: regmap clock handle
+ * @lock: register lock
+ */
+struct clk_rcg {
+	u32		ns_reg;
+	u32		md_reg;
+
+	struct mn	mn;
+	struct pre_div	p;
+	struct src_sel	s;
+
+	const struct freq_tbl	*freq_tbl;
+
+	struct clk_regmap	clkr;
+};
+
+extern const struct clk_ops clk_rcg_ops;
+extern const struct clk_ops clk_rcg_floor_ops;
+extern const struct clk_ops clk_rcg_bypass_ops;
+extern const struct clk_ops clk_rcg_bypass2_ops;
+extern const struct clk_ops clk_rcg_pixel_ops;
+extern const struct clk_ops clk_rcg_esc_ops;
+extern const struct clk_ops clk_rcg_lcc_ops;
+
+#define to_clk_rcg(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg, clkr)
+
+/**
+ * struct clk_dyn_rcg - root clock generator with glitch free mux
+ *
+ * @mux_sel_bit: bit to switch glitch free mux
+ * @ns_reg: NS0 and NS1 register
+ * @md_reg: MD0 and MD1 register
+ * @bank_reg: register to XOR @mux_sel_bit into to switch glitch free mux
+ * @mn: mn counter (banked)
+ * @s: source selector (banked)
+ * @freq_tbl: frequency table
+ * @clkr: regmap clock handle
+ * @lock: register lock
+ */
+struct clk_dyn_rcg {
+	u32	ns_reg[2];
+	u32	md_reg[2];
+	u32	bank_reg;
+
+	u8	mux_sel_bit;
+
+	struct mn	mn[2];
+	struct pre_div	p[2];
+	struct src_sel	s[2];
+
+	const struct freq_tbl *freq_tbl;
+
+	struct clk_regmap clkr;
+};
+
+extern const struct clk_ops clk_dyn_rcg_ops;
+
+#define to_clk_dyn_rcg(_hw) \
+	container_of(to_clk_regmap(_hw), struct clk_dyn_rcg, clkr)
+
+/**
+ * struct clk_rcg2 - root clock generator
+ *
+ * @cmd_rcgr: corresponds to *_CMD_RCGR
+ * @mnd_width: number of bits in m/n/d values
+ * @hid_width: number of bits in half integer divider
+ * @safe_src_index: safe src index value
+ * @parent_map: map from software's parent index to hardware's src_sel field
+ * @freq_tbl: frequency table
+ * @freq_multi_tbl: frequency table for clocks reachable with multiple RCGs conf
+ * @clkr: regmap clock handle
+ * @cfg_off: defines the cfg register offset from the CMD_RCGR + CFG_REG
+ * @parked_cfg: cached value of the CFG register for parked RCGs
+ * @hw_clk_ctrl: whether to enable hardware clock control
+ */
+struct clk_rcg2 {
+	u32			cmd_rcgr;
+	u8			mnd_width;
+	u8			hid_width;
+	u8			safe_src_index;
+	const struct parent_map	*parent_map;
+	union {
+		const struct freq_tbl		*freq_tbl;
+		const struct freq_multi_tbl	*freq_multi_tbl;
+	};
+	struct clk_regmap	clkr;
+	u8			cfg_off;
+	u32			parked_cfg;
+	bool			hw_clk_ctrl;
+};
+
+#define to_clk_rcg2(_hw) container_of(to_clk_regmap(_hw), struct clk_rcg2, clkr)
+
+struct clk_rcg2_gfx3d {
+	u8 div;
+	struct clk_rcg2 rcg;
+	struct clk_hw **hws;
+};
+
+#define to_clk_rcg2_gfx3d(_hw) \
+	container_of(to_clk_rcg2(_hw), struct clk_rcg2_gfx3d, rcg)
+
+extern const struct clk_ops clk_rcg2_ops;
+extern const struct clk_ops clk_rcg2_gp_ops;
+extern const struct clk_ops clk_rcg2_floor_ops;
+extern const struct clk_ops clk_rcg2_fm_ops;
+extern const struct clk_ops clk_rcg2_mux_closest_ops;
+extern const struct clk_ops clk_edp_pixel_ops;
+extern const struct clk_ops clk_byte_ops;
+extern const struct clk_ops clk_byte2_ops;
+extern const struct clk_ops clk_pixel_ops;
+extern const struct clk_ops clk_gfx3d_ops;
+extern const struct clk_ops clk_rcg2_shared_ops;
+extern const struct clk_ops clk_rcg2_shared_floor_ops;
+extern const struct clk_ops clk_rcg2_shared_no_init_park_ops;
+extern const struct clk_ops clk_dp_ops;
+
+struct clk_rcg_dfs_data {
+	struct clk_rcg2 *rcg;
+	struct clk_init_data *init;
+};
+
+#define DEFINE_RCG_DFS(r) \
+	{ .rcg = &r, .init = &r##_init }
+
+extern int qcom_cc_register_rcg_dfs(struct regmap *regmap,
+				    const struct clk_rcg_dfs_data *rcgs,
+				    size_t len);
+#endif
diff --git a/drivers/clk/qcom/ccf/clk-rcg2.c b/drivers/clk/qcom/ccf/clk-rcg2.c
new file mode 100644
index 000000000000..e18cb8807d73
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-rcg2.c
@@ -0,0 +1,1860 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2013, 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/bug.h>
+#include <linux/export.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/rational.h>
+#include <linux/regmap.h>
+#include <linux/math64.h>
+#include <linux/gcd.h>
+#include <linux/minmax.h>
+#include <linux/slab.h>
+
+#include <asm/div64.h>
+
+#include "clk-rcg.h"
+#include "common.h"
+
+#define CMD_REG			0x0
+#define CMD_UPDATE		BIT(0)
+#define CMD_ROOT_EN		BIT(1)
+#define CMD_DIRTY_CFG		BIT(4)
+#define CMD_DIRTY_N		BIT(5)
+#define CMD_DIRTY_M		BIT(6)
+#define CMD_DIRTY_D		BIT(7)
+#define CMD_ROOT_OFF		BIT(31)
+
+#define CFG_REG			0x4
+#define CFG_SRC_DIV_SHIFT	0
+#define CFG_SRC_DIV_LENGTH	8
+#define CFG_SRC_SEL_SHIFT	8
+#define CFG_SRC_SEL_MASK	(0x7 << CFG_SRC_SEL_SHIFT)
+#define CFG_MODE_SHIFT		12
+#define CFG_MODE_MASK		(0x3 << CFG_MODE_SHIFT)
+#define CFG_MODE_DUAL_EDGE	(0x2 << CFG_MODE_SHIFT)
+#define CFG_HW_CLK_CTRL_MASK	BIT(20)
+
+#define M_REG			0x8
+#define N_REG			0xc
+#define D_REG			0x10
+
+#define RCG_CFG_OFFSET(rcg)	((rcg)->cmd_rcgr + (rcg)->cfg_off + CFG_REG)
+#define RCG_M_OFFSET(rcg)	((rcg)->cmd_rcgr + (rcg)->cfg_off + M_REG)
+#define RCG_N_OFFSET(rcg)	((rcg)->cmd_rcgr + (rcg)->cfg_off + N_REG)
+#define RCG_D_OFFSET(rcg)	((rcg)->cmd_rcgr + (rcg)->cfg_off + D_REG)
+
+/* Dynamic Frequency Scaling */
+#define MAX_PERF_LEVEL		8
+#define SE_CMD_DFSR_OFFSET	0x14
+#define SE_CMD_DFS_EN		BIT(0)
+#define SE_PERF_DFSR(level)	(0x1c + 0x4 * (level))
+#define SE_PERF_M_DFSR(level)	(0x5c + 0x4 * (level))
+#define SE_PERF_N_DFSR(level)	(0x9c + 0x4 * (level))
+
+enum freq_policy {
+	FLOOR,
+	CEIL,
+};
+
+static int clk_rcg2_is_enabled(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 cmd;
+	int ret;
+
+	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG, &cmd);
+	if (ret)
+		return ret;
+
+	return (cmd & CMD_ROOT_OFF) == 0;
+}
+
+static u8 __clk_rcg2_get_parent(struct clk_hw *hw, u32 cfg)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int num_parents = clk_hw_get_num_parents(hw);
+	int i;
+
+	cfg &= CFG_SRC_SEL_MASK;
+	cfg >>= CFG_SRC_SEL_SHIFT;
+
+	for (i = 0; i < num_parents; i++)
+		if (cfg == rcg->parent_map[i].cfg)
+			return i;
+
+	pr_debug("%s: Clock %s has invalid parent, using default.\n",
+		 __func__, clk_hw_get_name(hw));
+	return 0;
+}
+
+static u8 clk_rcg2_get_parent(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 cfg;
+	int ret;
+
+	ret = regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+	if (ret) {
+		pr_debug("%s: Unable to read CFG register for %s\n",
+			 __func__, clk_hw_get_name(hw));
+		return 0;
+	}
+
+	return __clk_rcg2_get_parent(hw, cfg);
+}
+
+static int update_config(struct clk_rcg2 *rcg)
+{
+	int count, ret;
+	u32 cmd;
+	struct clk_hw *hw = &rcg->clkr.hw;
+	const char *name = clk_hw_get_name(hw);
+
+	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
+				 CMD_UPDATE, CMD_UPDATE);
+	if (ret)
+		return ret;
+
+	/* Wait for update to take effect */
+	for (count = 500; count > 0; count--) {
+		ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG, &cmd);
+		if (ret)
+			return ret;
+		if (!(cmd & CMD_UPDATE))
+			return 0;
+		udelay(1);
+	}
+
+	WARN(1, "%s: rcg didn't update its configuration.", name);
+	return -EBUSY;
+}
+
+static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int ret;
+	u32 cfg = rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
+
+	ret = regmap_update_bits(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg),
+				 CFG_SRC_SEL_MASK, cfg);
+	if (ret)
+		return ret;
+
+	return update_config(rcg);
+}
+
+/**
+ * convert_to_reg_val() - Convert divisor values to hardware values.
+ *
+ * @f: Frequency table with pure m/n/pre_div parameters.
+ */
+static void convert_to_reg_val(struct freq_tbl *f)
+{
+	f->pre_div *= 2;
+	f->pre_div -= 1;
+}
+
+/**
+ * calc_rate() - Calculate rate based on m/n:d values
+ *
+ * @rate: Parent rate.
+ * @m: Multiplier.
+ * @n: Divisor.
+ * @mode: Use zero to ignore m/n calculation.
+ * @hid_div: Pre divisor register value. Pre divisor value
+ *                  relates to hid_div as pre_div = (hid_div + 1) / 2.
+ *
+ * Return calculated rate according to formula:
+ *
+ *          parent_rate     m
+ *   rate = ----------- x  ---
+ *            pre_div       n
+ */
+static unsigned long
+calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
+{
+	if (hid_div)
+		rate = mult_frac(rate, 2, hid_div + 1);
+
+	if (mode)
+		rate = mult_frac(rate, m, n);
+
+	return rate;
+}
+
+static unsigned long
+__clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate, u32 cfg)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 hid_div, m = 0, n = 0, mode = 0, mask;
+
+	if (rcg->mnd_width) {
+		mask = BIT(rcg->mnd_width) - 1;
+		regmap_read(rcg->clkr.regmap, RCG_M_OFFSET(rcg), &m);
+		m &= mask;
+		regmap_read(rcg->clkr.regmap, RCG_N_OFFSET(rcg), &n);
+		n = ~n;
+		n &= mask;
+		n += m;
+		mode = cfg & CFG_MODE_MASK;
+		mode >>= CFG_MODE_SHIFT;
+	}
+
+	mask = BIT(rcg->hid_width) - 1;
+	hid_div = cfg >> CFG_SRC_DIV_SHIFT;
+	hid_div &= mask;
+
+	return calc_rate(parent_rate, m, n, mode, hid_div);
+}
+
+static unsigned long
+clk_rcg2_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 cfg;
+
+	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+
+	return __clk_rcg2_recalc_rate(hw, parent_rate, cfg);
+}
+
+static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
+				    struct clk_rate_request *req,
+				    enum freq_policy policy)
+{
+	unsigned long clk_flags, rate = req->rate;
+	struct clk_hw *p;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int index;
+
+	switch (policy) {
+	case FLOOR:
+		f = qcom_find_freq_floor(f, rate);
+		break;
+	case CEIL:
+		f = qcom_find_freq(f, rate);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!f)
+		return -EINVAL;
+
+	index = qcom_find_src_index(hw, rcg->parent_map, f->src);
+	if (index < 0)
+		return index;
+
+	clk_flags = clk_hw_get_flags(hw);
+	p = clk_hw_get_parent_by_index(hw, index);
+	if (!p)
+		return -EINVAL;
+
+	if (clk_flags & CLK_SET_RATE_PARENT) {
+		rate = f->freq;
+		if (f->pre_div) {
+			if (!rate)
+				rate = req->rate;
+			rate /= 2;
+			rate *= f->pre_div + 1;
+		}
+
+		if (f->n) {
+			u64 tmp = rate;
+			tmp = tmp * f->n;
+			do_div(tmp, f->m);
+			rate = tmp;
+		}
+	} else {
+		rate = clk_hw_get_rate(p);
+	}
+	req->best_parent_hw = p;
+	req->best_parent_rate = rate;
+	req->rate = f->freq;
+
+	return 0;
+}
+
+static const struct freq_conf *
+__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
+		       unsigned long req_rate)
+{
+	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
+	const struct freq_conf *conf, *best_conf = NULL;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const char *name = clk_hw_get_name(hw);
+	unsigned long parent_rate, rate;
+	struct clk_hw *p;
+	int index, i;
+
+	/* Exit early if only one config is defined */
+	if (f->num_confs == 1) {
+		best_conf = f->confs;
+		goto exit;
+	}
+
+	/* Search in each provided config the one that is near the wanted rate */
+	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
+		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
+		if (index < 0)
+			continue;
+
+		p = clk_hw_get_parent_by_index(hw, index);
+		if (!p)
+			continue;
+
+		parent_rate = clk_hw_get_rate(p);
+		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
+
+		if (rate == req_rate) {
+			best_conf = conf;
+			goto exit;
+		}
+
+		rate_diff = abs_diff(req_rate, rate);
+		if (rate_diff < best_rate_diff) {
+			best_rate_diff = rate_diff;
+			best_conf = conf;
+		}
+	}
+
+	/*
+	 * Very unlikely. Warn if we couldn't find a correct config
+	 * due to parent not found in every config.
+	 */
+	if (unlikely(!best_conf)) {
+		WARN(1, "%s: can't find a configuration for rate %lu\n",
+		     name, req_rate);
+		return ERR_PTR(-EINVAL);
+	}
+
+exit:
+	return best_conf;
+}
+
+static int _freq_tbl_fm_determine_rate(struct clk_hw *hw, const struct freq_multi_tbl *f,
+				       struct clk_rate_request *req)
+{
+	unsigned long clk_flags, rate = req->rate;
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_conf *conf;
+	struct clk_hw *p;
+	int index;
+
+	f = qcom_find_freq_multi(f, rate);
+	if (!f || !f->confs)
+		return -EINVAL;
+
+	conf = __clk_rcg2_select_conf(hw, f, rate);
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
+	index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
+	if (index < 0)
+		return index;
+
+	clk_flags = clk_hw_get_flags(hw);
+	p = clk_hw_get_parent_by_index(hw, index);
+	if (!p)
+		return -EINVAL;
+
+	if (clk_flags & CLK_SET_RATE_PARENT) {
+		rate = f->freq;
+		if (conf->pre_div) {
+			if (!rate)
+				rate = req->rate;
+			rate /= 2;
+			rate *= conf->pre_div + 1;
+		}
+
+		if (conf->n) {
+			u64 tmp = rate;
+
+			tmp = tmp * conf->n;
+			do_div(tmp, conf->m);
+			rate = tmp;
+		}
+	} else {
+		rate = clk_hw_get_rate(p);
+	}
+
+	req->best_parent_hw = p;
+	req->best_parent_rate = rate;
+	req->rate = f->freq;
+
+	return 0;
+}
+
+static int clk_rcg2_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, CEIL);
+}
+
+static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	return _freq_tbl_determine_rate(hw, rcg->freq_tbl, req, FLOOR);
+}
+
+static int clk_rcg2_fm_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	return _freq_tbl_fm_determine_rate(hw, rcg->freq_multi_tbl, req);
+}
+
+/**
+ * clk_rcg2_split_div() - Split multiplier that doesn't fit in n neither in pre_div.
+ *
+ * @multiplier: Multiplier to split between n and pre_div.
+ * @pre_div: Pointer to pre divisor value.
+ * @n: Pointer to n divisor value.
+ * @pre_div_max: Pre divisor maximum value.
+ */
+static inline void clk_rcg2_split_div(int multiplier, unsigned int *pre_div,
+				      u16 *n, unsigned int pre_div_max)
+{
+	*n = mult_frac(multiplier * *n, *pre_div, pre_div_max);
+	*pre_div = pre_div_max;
+}
+
+static void clk_rcg2_calc_mnd(u64 parent_rate, u64 rate, struct freq_tbl *f,
+			unsigned int mnd_max, unsigned int pre_div_max)
+{
+	int i = 2;
+	unsigned int pre_div = 1;
+	unsigned long rates_gcd, scaled_parent_rate;
+	u16 m, n = 1, n_candidate = 1, n_max;
+
+	rates_gcd = gcd(parent_rate, rate);
+	m = div64_u64(rate, rates_gcd);
+	scaled_parent_rate = div64_u64(parent_rate, rates_gcd);
+	while (scaled_parent_rate > (mnd_max + m) * pre_div_max) {
+		// we're exceeding divisor's range, trying lower scale.
+		if (m > 1) {
+			m--;
+			scaled_parent_rate = mult_frac(scaled_parent_rate, m, (m + 1));
+		} else {
+			// cannot lower scale, just set max divisor values.
+			f->n = mnd_max + m;
+			f->pre_div = pre_div_max;
+			f->m = m;
+			return;
+		}
+	}
+
+	n_max = m + mnd_max;
+
+	while (scaled_parent_rate > 1) {
+		while (scaled_parent_rate % i == 0) {
+			n_candidate *= i;
+			if (n_candidate < n_max)
+				n = n_candidate;
+			else if (pre_div * i < pre_div_max)
+				pre_div *= i;
+			else
+				clk_rcg2_split_div(i, &pre_div, &n, pre_div_max);
+
+			scaled_parent_rate /= i;
+		}
+		i++;
+	}
+
+	f->m = m;
+	f->n = n;
+	f->pre_div = pre_div > 1 ? pre_div : 0;
+}
+
+static int clk_rcg2_determine_gp_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl f_tbl = {}, *f = &f_tbl;
+	int mnd_max = BIT(rcg->mnd_width) - 1;
+	int hid_max = BIT(rcg->hid_width) - 1;
+	struct clk_hw *parent;
+	u64 parent_rate;
+
+	parent = clk_hw_get_parent(hw);
+	parent_rate = clk_get_rate(parent->clk);
+	if (!parent_rate)
+		return -EINVAL;
+
+	clk_rcg2_calc_mnd(parent_rate, req->rate, f, mnd_max, hid_max / 2);
+	convert_to_reg_val(f);
+	req->rate = calc_rate(parent_rate, f->m, f->n, f->n, f->pre_div);
+
+	return 0;
+}
+
+static int __clk_rcg2_configure_parent(struct clk_rcg2 *rcg, u8 src, u32 *_cfg)
+{
+	struct clk_hw *hw = &rcg->clkr.hw;
+	int index = qcom_find_src_index(hw, rcg->parent_map, src);
+
+	if (index < 0)
+		return index;
+
+	*_cfg &= ~CFG_SRC_SEL_MASK;
+	*_cfg |= rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
+
+	return 0;
+}
+
+static int __clk_rcg2_configure_mnd(struct clk_rcg2 *rcg, const struct freq_tbl *f,
+				u32 *_cfg)
+{
+	u32 cfg, mask, d_val, not2d_val, n_minus_m;
+	int ret;
+
+	if (rcg->mnd_width && f->n) {
+		mask = BIT(rcg->mnd_width) - 1;
+		ret = regmap_update_bits(rcg->clkr.regmap,
+				RCG_M_OFFSET(rcg), mask, f->m);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(rcg->clkr.regmap,
+				RCG_N_OFFSET(rcg), mask, ~(f->n - f->m));
+		if (ret)
+			return ret;
+
+		/* Calculate 2d value */
+		d_val = f->n;
+
+		n_minus_m = f->n - f->m;
+		n_minus_m *= 2;
+
+		d_val = clamp_t(u32, d_val, f->m, n_minus_m);
+		not2d_val = ~d_val & mask;
+
+		ret = regmap_update_bits(rcg->clkr.regmap,
+				RCG_D_OFFSET(rcg), mask, not2d_val);
+		if (ret)
+			return ret;
+	}
+
+	mask = BIT(rcg->hid_width) - 1;
+	mask |= CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK;
+	cfg = f->pre_div << CFG_SRC_DIV_SHIFT;
+	if (rcg->mnd_width && f->n && (f->m != f->n))
+		cfg |= CFG_MODE_DUAL_EDGE;
+	if (rcg->hw_clk_ctrl)
+		cfg |= CFG_HW_CLK_CTRL_MASK;
+
+	*_cfg &= ~mask;
+	*_cfg |= cfg;
+
+	return 0;
+}
+
+static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f,
+				u32 *_cfg)
+{
+	int ret;
+
+	ret = __clk_rcg2_configure_parent(rcg, f->src, _cfg);
+	if (ret)
+		return ret;
+
+	ret = __clk_rcg2_configure_mnd(rcg, f, _cfg);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
+{
+	u32 cfg;
+	int ret;
+
+	ret = regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+	if (ret)
+		return ret;
+
+	ret = __clk_rcg2_configure(rcg, f, &cfg);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), cfg);
+	if (ret)
+		return ret;
+
+	return update_config(rcg);
+}
+
+static int clk_rcg2_configure_gp(struct clk_rcg2 *rcg, const struct freq_tbl *f)
+{
+	u32 cfg;
+	int ret;
+
+	ret = regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+	if (ret)
+		return ret;
+
+	ret = __clk_rcg2_configure_mnd(rcg, f, &cfg);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), cfg);
+	if (ret)
+		return ret;
+
+	return update_config(rcg);
+}
+
+static int __clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
+			       enum freq_policy policy)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_tbl *f;
+
+	switch (policy) {
+	case FLOOR:
+		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
+		break;
+	case CEIL:
+		f = qcom_find_freq(rcg->freq_tbl, rate);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!f)
+		return -EINVAL;
+
+	return clk_rcg2_configure(rcg, f);
+}
+
+static int __clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_multi_tbl *f;
+	const struct freq_conf *conf;
+	struct freq_tbl f_tbl = {};
+
+	f = qcom_find_freq_multi(rcg->freq_multi_tbl, rate);
+	if (!f || !f->confs)
+		return -EINVAL;
+
+	conf = __clk_rcg2_select_conf(hw, f, rate);
+	if (IS_ERR(conf))
+		return PTR_ERR(conf);
+
+	f_tbl.freq = f->freq;
+	f_tbl.src = conf->src;
+	f_tbl.pre_div = conf->pre_div;
+	f_tbl.m = conf->m;
+	f_tbl.n = conf->n;
+
+	return clk_rcg2_configure(rcg, &f_tbl);
+}
+
+static int clk_rcg2_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	return __clk_rcg2_set_rate(hw, rate, CEIL);
+}
+
+static int clk_rcg2_set_gp_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int mnd_max = BIT(rcg->mnd_width) - 1;
+	int hid_max = BIT(rcg->hid_width) - 1;
+	struct freq_tbl f_tbl = {}, *f = &f_tbl;
+	int ret;
+
+	clk_rcg2_calc_mnd(parent_rate, rate, f, mnd_max, hid_max / 2);
+	convert_to_reg_val(f);
+	ret = clk_rcg2_configure_gp(rcg, f);
+
+	return ret;
+}
+
+static int clk_rcg2_set_floor_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	return __clk_rcg2_set_rate(hw, rate, FLOOR);
+}
+
+static int clk_rcg2_fm_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate)
+{
+	return __clk_rcg2_fm_set_rate(hw, rate);
+}
+
+static int clk_rcg2_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return __clk_rcg2_set_rate(hw, rate, CEIL);
+}
+
+static int clk_rcg2_set_floor_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return __clk_rcg2_set_rate(hw, rate, FLOOR);
+}
+
+static int clk_rcg2_fm_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return __clk_rcg2_fm_set_rate(hw, rate);
+}
+
+static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 notn_m, n, m, d, not2d, mask;
+
+	if (!rcg->mnd_width) {
+		/* 50 % duty-cycle for Non-MND RCGs */
+		duty->num = 1;
+		duty->den = 2;
+		return 0;
+	}
+
+	regmap_read(rcg->clkr.regmap, RCG_D_OFFSET(rcg), &not2d);
+	regmap_read(rcg->clkr.regmap, RCG_M_OFFSET(rcg), &m);
+	regmap_read(rcg->clkr.regmap, RCG_N_OFFSET(rcg), &notn_m);
+
+	if (!not2d && !m && !notn_m) {
+		/* 50 % duty-cycle always */
+		duty->num = 1;
+		duty->den = 2;
+		return 0;
+	}
+
+	mask = BIT(rcg->mnd_width) - 1;
+
+	d = ~(not2d) & mask;
+	d = DIV_ROUND_CLOSEST(d, 2);
+
+	n = (~(notn_m) + m) & mask;
+
+	duty->num = d;
+	duty->den = n;
+
+	return 0;
+}
+
+static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 notn_m, n, m, d, not2d, mask, duty_per, cfg;
+	int ret;
+
+	/* Duty-cycle cannot be modified for non-MND RCGs */
+	if (!rcg->mnd_width)
+		return -EINVAL;
+
+	mask = BIT(rcg->mnd_width) - 1;
+
+	regmap_read(rcg->clkr.regmap, RCG_N_OFFSET(rcg), &notn_m);
+	regmap_read(rcg->clkr.regmap, RCG_M_OFFSET(rcg), &m);
+	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+
+	/* Duty-cycle cannot be modified if MND divider is in bypass mode. */
+	if (!(cfg & CFG_MODE_MASK))
+		return -EINVAL;
+
+	n = (~(notn_m) + m) & mask;
+
+	duty_per = (duty->num * 100) / duty->den;
+
+	/* Calculate 2d value */
+	d = DIV_ROUND_CLOSEST(n * duty_per * 2, 100);
+
+	/*
+	 * Check bit widths of 2d. If D is too big reduce duty cycle.
+	 * Also make sure it is never zero.
+	 */
+	d = clamp_val(d, 1, mask);
+
+	if ((d / 2) > (n - m))
+		d = (n - m) * 2;
+	else if ((d / 2) < (m / 2))
+		d = m;
+
+	not2d = ~d & mask;
+
+	ret = regmap_update_bits(rcg->clkr.regmap, RCG_D_OFFSET(rcg), mask,
+				 not2d);
+	if (ret)
+		return ret;
+
+	return update_config(rcg);
+}
+
+const struct clk_ops clk_rcg2_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_determine_rate,
+	.set_rate = clk_rcg2_set_rate,
+	.set_rate_and_parent = clk_rcg2_set_rate_and_parent,
+	.get_duty_cycle = clk_rcg2_get_duty_cycle,
+	.set_duty_cycle = clk_rcg2_set_duty_cycle,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_ops);
+
+const struct clk_ops clk_rcg2_gp_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_determine_gp_rate,
+	.set_rate = clk_rcg2_set_gp_rate,
+	.get_duty_cycle = clk_rcg2_get_duty_cycle,
+	.set_duty_cycle = clk_rcg2_set_duty_cycle,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_gp_ops);
+
+const struct clk_ops clk_rcg2_floor_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_determine_floor_rate,
+	.set_rate = clk_rcg2_set_floor_rate,
+	.set_rate_and_parent = clk_rcg2_set_floor_rate_and_parent,
+	.get_duty_cycle = clk_rcg2_get_duty_cycle,
+	.set_duty_cycle = clk_rcg2_set_duty_cycle,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_floor_ops);
+
+const struct clk_ops clk_rcg2_fm_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.determine_rate = clk_rcg2_fm_determine_rate,
+	.set_rate = clk_rcg2_fm_set_rate,
+	.set_rate_and_parent = clk_rcg2_fm_set_rate_and_parent,
+	.get_duty_cycle = clk_rcg2_get_duty_cycle,
+	.set_duty_cycle = clk_rcg2_set_duty_cycle,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_fm_ops);
+
+const struct clk_ops clk_rcg2_mux_closest_ops = {
+	.determine_rate = __clk_mux_determine_rate_closest,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_mux_closest_ops);
+
+struct frac_entry {
+	int num;
+	int den;
+};
+
+static const struct frac_entry frac_table_675m[] = {	/* link rate of 270M */
+	{ 52, 295 },	/* 119 M */
+	{ 11, 57 },	/* 130.25 M */
+	{ 63, 307 },	/* 138.50 M */
+	{ 11, 50 },	/* 148.50 M */
+	{ 47, 206 },	/* 154 M */
+	{ 31, 100 },	/* 205.25 M */
+	{ 107, 269 },	/* 268.50 M */
+	{ },
+};
+
+static struct frac_entry frac_table_810m[] = { /* Link rate of 162M */
+	{ 31, 211 },	/* 119 M */
+	{ 32, 199 },	/* 130.25 M */
+	{ 63, 307 },	/* 138.50 M */
+	{ 11, 60 },	/* 148.50 M */
+	{ 50, 263 },	/* 154 M */
+	{ 31, 120 },	/* 205.25 M */
+	{ 119, 359 },	/* 268.50 M */
+	{ },
+};
+
+static int clk_edp_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl f = *rcg->freq_tbl;
+	const struct frac_entry *frac;
+	int delta = 100000;
+	s64 src_rate = parent_rate;
+	s64 request;
+	u32 mask = BIT(rcg->hid_width) - 1;
+	u32 hid_div;
+
+	if (src_rate == 810000000)
+		frac = frac_table_810m;
+	else
+		frac = frac_table_675m;
+
+	for (; frac->num; frac++) {
+		request = rate;
+		request *= frac->den;
+		request = div_s64(request, frac->num);
+		if ((src_rate < (request - delta)) ||
+		    (src_rate > (request + delta)))
+			continue;
+
+		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
+				&hid_div);
+		f.pre_div = hid_div;
+		f.pre_div >>= CFG_SRC_DIV_SHIFT;
+		f.pre_div &= mask;
+		f.m = frac->num;
+		f.n = frac->den;
+
+		return clk_rcg2_configure(rcg, &f);
+	}
+
+	return -EINVAL;
+}
+
+static int clk_edp_pixel_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	/* Parent index is set statically in frequency table */
+	return clk_edp_pixel_set_rate(hw, rate, parent_rate);
+}
+
+static int clk_edp_pixel_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_tbl *f = rcg->freq_tbl;
+	const struct frac_entry *frac;
+	int delta = 100000;
+	s64 request;
+	u32 mask = BIT(rcg->hid_width) - 1;
+	u32 hid_div;
+	int index = qcom_find_src_index(hw, rcg->parent_map, f->src);
+
+	/* Force the correct parent */
+	req->best_parent_hw = clk_hw_get_parent_by_index(hw, index);
+	req->best_parent_rate = clk_hw_get_rate(req->best_parent_hw);
+
+	if (req->best_parent_rate == 810000000)
+		frac = frac_table_810m;
+	else
+		frac = frac_table_675m;
+
+	for (; frac->num; frac++) {
+		request = req->rate;
+		request *= frac->den;
+		request = div_s64(request, frac->num);
+		if ((req->best_parent_rate < (request - delta)) ||
+		    (req->best_parent_rate > (request + delta)))
+			continue;
+
+		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
+				&hid_div);
+		hid_div >>= CFG_SRC_DIV_SHIFT;
+		hid_div &= mask;
+
+		req->rate = calc_rate(req->best_parent_rate,
+				      frac->num, frac->den,
+				      !!frac->den, hid_div);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+const struct clk_ops clk_edp_pixel_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.set_rate = clk_edp_pixel_set_rate,
+	.set_rate_and_parent = clk_edp_pixel_set_rate_and_parent,
+	.determine_rate = clk_edp_pixel_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_edp_pixel_ops);
+
+static int clk_byte_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_tbl *f = rcg->freq_tbl;
+	int index = qcom_find_src_index(hw, rcg->parent_map, f->src);
+	unsigned long parent_rate, div;
+	u32 mask = BIT(rcg->hid_width) - 1;
+	struct clk_hw *p;
+
+	if (req->rate == 0)
+		return -EINVAL;
+
+	req->best_parent_hw = p = clk_hw_get_parent_by_index(hw, index);
+	req->best_parent_rate = parent_rate = clk_hw_round_rate(p, req->rate);
+
+	div = DIV_ROUND_UP((2 * parent_rate), req->rate) - 1;
+	div = min_t(u32, div, mask);
+
+	req->rate = calc_rate(parent_rate, 0, 0, 0, div);
+
+	return 0;
+}
+
+static int clk_byte_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl f = *rcg->freq_tbl;
+	unsigned long div;
+	u32 mask = BIT(rcg->hid_width) - 1;
+
+	div = DIV_ROUND_UP((2 * parent_rate), rate) - 1;
+	div = min_t(u32, div, mask);
+
+	f.pre_div = div;
+
+	return clk_rcg2_configure(rcg, &f);
+}
+
+static int clk_byte_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	/* Parent index is set statically in frequency table */
+	return clk_byte_set_rate(hw, rate, parent_rate);
+}
+
+const struct clk_ops clk_byte_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.set_rate = clk_byte_set_rate,
+	.set_rate_and_parent = clk_byte_set_rate_and_parent,
+	.determine_rate = clk_byte_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_byte_ops);
+
+static int clk_byte2_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	unsigned long parent_rate, div;
+	u32 mask = BIT(rcg->hid_width) - 1;
+	struct clk_hw *p;
+	unsigned long rate = req->rate;
+
+	if (rate == 0)
+		return -EINVAL;
+
+	p = req->best_parent_hw;
+	req->best_parent_rate = parent_rate = clk_hw_round_rate(p, rate);
+
+	div = DIV_ROUND_UP((2 * parent_rate), rate) - 1;
+	div = min_t(u32, div, mask);
+
+	req->rate = calc_rate(parent_rate, 0, 0, 0, div);
+
+	return 0;
+}
+
+static int clk_byte2_set_rate(struct clk_hw *hw, unsigned long rate,
+			 unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl f = { 0 };
+	unsigned long div;
+	int i, num_parents = clk_hw_get_num_parents(hw);
+	u32 mask = BIT(rcg->hid_width) - 1;
+	u32 cfg;
+
+	div = DIV_ROUND_UP((2 * parent_rate), rate) - 1;
+	div = min_t(u32, div, mask);
+
+	f.pre_div = div;
+
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
+	cfg &= CFG_SRC_SEL_MASK;
+	cfg >>= CFG_SRC_SEL_SHIFT;
+
+	for (i = 0; i < num_parents; i++) {
+		if (cfg == rcg->parent_map[i].cfg) {
+			f.src = rcg->parent_map[i].src;
+			return clk_rcg2_configure(rcg, &f);
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int clk_byte2_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	/* Read the hardware to determine parent during set_rate */
+	return clk_byte2_set_rate(hw, rate, parent_rate);
+}
+
+const struct clk_ops clk_byte2_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.set_rate = clk_byte2_set_rate,
+	.set_rate_and_parent = clk_byte2_set_rate_and_parent,
+	.determine_rate = clk_byte2_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_byte2_ops);
+
+static const struct frac_entry frac_table_pixel[] = {
+	{ 3, 8 },
+	{ 2, 9 },
+	{ 4, 9 },
+	{ 1, 1 },
+	{ 2, 3 },
+	{ }
+};
+
+static int clk_pixel_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
+{
+	unsigned long request, src_rate;
+	int delta = 100000;
+	const struct frac_entry *frac = frac_table_pixel;
+
+	for (; frac->num; frac++) {
+		request = (req->rate * frac->den) / frac->num;
+
+		src_rate = clk_hw_round_rate(req->best_parent_hw, request);
+		if ((src_rate < (request - delta)) ||
+			(src_rate > (request + delta)))
+			continue;
+
+		req->best_parent_rate = src_rate;
+		req->rate = (src_rate * frac->num) / frac->den;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int clk_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl f = { 0 };
+	const struct frac_entry *frac = frac_table_pixel;
+	unsigned long request;
+	int delta = 100000;
+	u32 mask = BIT(rcg->hid_width) - 1;
+	u32 hid_div, cfg;
+	int i, num_parents = clk_hw_get_num_parents(hw);
+
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
+	cfg &= CFG_SRC_SEL_MASK;
+	cfg >>= CFG_SRC_SEL_SHIFT;
+
+	for (i = 0; i < num_parents; i++)
+		if (cfg == rcg->parent_map[i].cfg) {
+			f.src = rcg->parent_map[i].src;
+			break;
+		}
+
+	for (; frac->num; frac++) {
+		request = (rate * frac->den) / frac->num;
+
+		if ((parent_rate < (request - delta)) ||
+			(parent_rate > (request + delta)))
+			continue;
+
+		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
+				&hid_div);
+		f.pre_div = hid_div;
+		f.pre_div >>= CFG_SRC_DIV_SHIFT;
+		f.pre_div &= mask;
+		f.m = frac->num;
+		f.n = frac->den;
+
+		return clk_rcg2_configure(rcg, &f);
+	}
+	return -EINVAL;
+}
+
+static int clk_pixel_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate, u8 index)
+{
+	return clk_pixel_set_rate(hw, rate, parent_rate);
+}
+
+const struct clk_ops clk_pixel_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.set_rate = clk_pixel_set_rate,
+	.set_rate_and_parent = clk_pixel_set_rate_and_parent,
+	.determine_rate = clk_pixel_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_pixel_ops);
+
+static int clk_gfx3d_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
+{
+	struct clk_rate_request parent_req = { .min_rate = 0, .max_rate = ULONG_MAX };
+	struct clk_rcg2_gfx3d *cgfx = to_clk_rcg2_gfx3d(hw);
+	struct clk_hw *xo, *p0, *p1, *p2;
+	unsigned long p0_rate;
+	u8 mux_div = cgfx->div;
+	int ret;
+
+	p0 = cgfx->hws[0];
+	p1 = cgfx->hws[1];
+	p2 = cgfx->hws[2];
+	/*
+	 * This function does ping-pong the RCG between PLLs: if we don't
+	 * have at least one fixed PLL and two variable ones,
+	 * then it's not going to work correctly.
+	 */
+	if (WARN_ON(!p0 || !p1 || !p2))
+		return -EINVAL;
+
+	xo = clk_hw_get_parent_by_index(hw, 0);
+	if (req->rate == clk_hw_get_rate(xo)) {
+		req->best_parent_hw = xo;
+		return 0;
+	}
+
+	if (mux_div == 0)
+		mux_div = 1;
+
+	parent_req.rate = req->rate * mux_div;
+
+	/* This has to be a fixed rate PLL */
+	p0_rate = clk_hw_get_rate(p0);
+
+	if (parent_req.rate == p0_rate) {
+		req->rate = req->best_parent_rate = p0_rate;
+		req->best_parent_hw = p0;
+		return 0;
+	}
+
+	if (req->best_parent_hw == p0) {
+		/* Are we going back to a previously used rate? */
+		if (clk_hw_get_rate(p2) == parent_req.rate)
+			req->best_parent_hw = p2;
+		else
+			req->best_parent_hw = p1;
+	} else if (req->best_parent_hw == p2) {
+		req->best_parent_hw = p1;
+	} else {
+		req->best_parent_hw = p2;
+	}
+
+	clk_hw_get_rate_range(req->best_parent_hw,
+			      &parent_req.min_rate, &parent_req.max_rate);
+
+	if (req->min_rate > parent_req.min_rate)
+		parent_req.min_rate = req->min_rate;
+
+	if (req->max_rate < parent_req.max_rate)
+		parent_req.max_rate = req->max_rate;
+
+	ret = __clk_determine_rate(req->best_parent_hw, &parent_req);
+	if (ret)
+		return ret;
+
+	req->rate = req->best_parent_rate = parent_req.rate;
+	req->rate /= mux_div;
+
+	return 0;
+}
+
+static int clk_gfx3d_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate, u8 index)
+{
+	struct clk_rcg2_gfx3d *cgfx = to_clk_rcg2_gfx3d(hw);
+	struct clk_rcg2 *rcg = &cgfx->rcg;
+	u32 cfg;
+	int ret;
+
+	cfg = rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
+	/* On some targets, the GFX3D RCG may need to divide PLL frequency */
+	if (cgfx->div > 1)
+		cfg |= ((2 * cgfx->div) - 1) << CFG_SRC_DIV_SHIFT;
+
+	ret = regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, cfg);
+	if (ret)
+		return ret;
+
+	return update_config(rcg);
+}
+
+static int clk_gfx3d_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	/*
+	 * We should never get here; clk_gfx3d_determine_rate() should always
+	 * make us use a different parent than what we're currently using, so
+	 * clk_gfx3d_set_rate_and_parent() should always be called.
+	 */
+	return 0;
+}
+
+const struct clk_ops clk_gfx3d_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.set_rate = clk_gfx3d_set_rate,
+	.set_rate_and_parent = clk_gfx3d_set_rate_and_parent,
+	.determine_rate = clk_gfx3d_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_gfx3d_ops);
+
+static int clk_rcg2_set_force_enable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const char *name = clk_hw_get_name(hw);
+	int ret, count;
+
+	ret = regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
+				 CMD_ROOT_EN, CMD_ROOT_EN);
+	if (ret)
+		return ret;
+
+	/* wait for RCG to turn ON */
+	for (count = 500; count > 0; count--) {
+		if (clk_rcg2_is_enabled(hw))
+			return 0;
+
+		udelay(1);
+	}
+
+	pr_err("%s: RCG did not turn on\n", name);
+	return -ETIMEDOUT;
+}
+
+static int clk_rcg2_clear_force_enable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	return regmap_update_bits(rcg->clkr.regmap, rcg->cmd_rcgr + CMD_REG,
+					CMD_ROOT_EN, 0);
+}
+
+static int
+clk_rcg2_shared_force_enable_clear(struct clk_hw *hw, const struct freq_tbl *f)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int ret;
+
+	ret = clk_rcg2_set_force_enable(hw);
+	if (ret)
+		return ret;
+
+	ret = clk_rcg2_configure(rcg, f);
+	if (ret)
+		return ret;
+
+	return clk_rcg2_clear_force_enable(hw);
+}
+
+static int __clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long parent_rate,
+				      enum freq_policy policy)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	const struct freq_tbl *f;
+
+	switch (policy) {
+	case FLOOR:
+		f = qcom_find_freq_floor(rcg->freq_tbl, rate);
+		break;
+	case CEIL:
+		f = qcom_find_freq(rcg->freq_tbl, rate);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * In case clock is disabled, update the M, N and D registers, cache
+	 * the CFG value in parked_cfg and don't hit the update bit of CMD
+	 * register.
+	 */
+	if (!clk_hw_is_enabled(hw))
+		return __clk_rcg2_configure(rcg, f, &rcg->parked_cfg);
+
+	return clk_rcg2_shared_force_enable_clear(hw, f);
+}
+
+static int clk_rcg2_shared_set_rate(struct clk_hw *hw, unsigned long rate,
+				    unsigned long parent_rate)
+{
+	return __clk_rcg2_shared_set_rate(hw, rate, parent_rate, CEIL);
+}
+
+static int clk_rcg2_shared_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return __clk_rcg2_shared_set_rate(hw, rate, parent_rate, CEIL);
+}
+
+static int clk_rcg2_shared_set_floor_rate(struct clk_hw *hw, unsigned long rate,
+					  unsigned long parent_rate)
+{
+	return __clk_rcg2_shared_set_rate(hw, rate, parent_rate, FLOOR);
+}
+
+static int clk_rcg2_shared_set_floor_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return __clk_rcg2_shared_set_rate(hw, rate, parent_rate, FLOOR);
+}
+
+static int clk_rcg2_shared_enable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int ret;
+
+	/*
+	 * Set the update bit because required configuration has already
+	 * been written in clk_rcg2_shared_set_rate()
+	 */
+	ret = clk_rcg2_set_force_enable(hw);
+	if (ret)
+		return ret;
+
+	/* Write back the stored configuration corresponding to current rate */
+	ret = regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, rcg->parked_cfg);
+	if (ret)
+		return ret;
+
+	ret = update_config(rcg);
+	if (ret)
+		return ret;
+
+	return clk_rcg2_clear_force_enable(hw);
+}
+
+static void clk_rcg2_shared_disable(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/*
+	 * Store current configuration as switching to safe source would clear
+	 * the SRC and DIV of CFG register
+	 */
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &rcg->parked_cfg);
+
+	/*
+	 * Park the RCG at a safe configuration - sourced off of safe source.
+	 * Force enable and disable the RCG while configuring it to safeguard
+	 * against any update signal coming from the downstream clock.
+	 * The current parent is still prepared and enabled at this point, and
+	 * the safe source is always on while application processor subsystem
+	 * is online. Therefore, the RCG can safely switch its parent.
+	 */
+	clk_rcg2_set_force_enable(hw);
+
+	regmap_write(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG,
+		     rcg->safe_src_index << CFG_SRC_SEL_SHIFT);
+
+	update_config(rcg);
+
+	clk_rcg2_clear_force_enable(hw);
+}
+
+static u8 clk_rcg2_shared_get_parent(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/* If the shared rcg is parked use the cached cfg instead */
+	if (!clk_hw_is_enabled(hw))
+		return __clk_rcg2_get_parent(hw, rcg->parked_cfg);
+
+	return clk_rcg2_get_parent(hw);
+}
+
+static int clk_rcg2_shared_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/* If the shared rcg is parked only update the cached cfg */
+	if (!clk_hw_is_enabled(hw)) {
+		rcg->parked_cfg &= ~CFG_SRC_SEL_MASK;
+		rcg->parked_cfg |= rcg->parent_map[index].cfg << CFG_SRC_SEL_SHIFT;
+
+		return 0;
+	}
+
+	return clk_rcg2_set_parent(hw, index);
+}
+
+static unsigned long
+clk_rcg2_shared_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/* If the shared rcg is parked use the cached cfg instead */
+	if (!clk_hw_is_enabled(hw))
+		return __clk_rcg2_recalc_rate(hw, parent_rate, rcg->parked_cfg);
+
+	return clk_rcg2_recalc_rate(hw, parent_rate);
+}
+
+static int clk_rcg2_shared_init(struct clk_hw *hw)
+{
+	/*
+	 * This does a few things:
+	 *
+	 *  1. Sets rcg->parked_cfg to reflect the value at probe so that the
+	 *     proper parent is reported from clk_rcg2_shared_get_parent().
+	 *
+	 *  2. Clears the force enable bit of the RCG because we rely on child
+	 *     clks (branches) to turn the RCG on/off with a hardware feedback
+	 *     mechanism and only set the force enable bit in the RCG when we
+	 *     want to make sure the clk stays on for parent switches or
+	 *     parking.
+	 *
+	 *  3. Parks shared RCGs on the safe source at registration because we
+	 *     can't be certain that the parent clk will stay on during boot,
+	 *     especially if the parent is shared. If this RCG is enabled at
+	 *     boot, and the parent is turned off, the RCG will get stuck on. A
+	 *     GDSC can wedge if is turned on and the RCG is stuck on because
+	 *     the GDSC's controller will hang waiting for the clk status to
+	 *     toggle on when it never does.
+	 *
+	 * The safest option here is to "park" the RCG at init so that the clk
+	 * can never get stuck on or off. This ensures the GDSC can't get
+	 * wedged.
+	 */
+	clk_rcg2_shared_disable(hw);
+
+	return 0;
+}
+
+const struct clk_ops clk_rcg2_shared_ops = {
+	.init = clk_rcg2_shared_init,
+	.enable = clk_rcg2_shared_enable,
+	.disable = clk_rcg2_shared_disable,
+	.get_parent = clk_rcg2_shared_get_parent,
+	.set_parent = clk_rcg2_shared_set_parent,
+	.recalc_rate = clk_rcg2_shared_recalc_rate,
+	.determine_rate = clk_rcg2_determine_rate,
+	.set_rate = clk_rcg2_shared_set_rate,
+	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_shared_ops);
+
+const struct clk_ops clk_rcg2_shared_floor_ops = {
+	.enable = clk_rcg2_shared_enable,
+	.disable = clk_rcg2_shared_disable,
+	.get_parent = clk_rcg2_shared_get_parent,
+	.set_parent = clk_rcg2_shared_set_parent,
+	.recalc_rate = clk_rcg2_shared_recalc_rate,
+	.determine_rate = clk_rcg2_determine_floor_rate,
+	.set_rate = clk_rcg2_shared_set_floor_rate,
+	.set_rate_and_parent = clk_rcg2_shared_set_floor_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_shared_floor_ops);
+
+static int clk_rcg2_shared_no_init_park(struct clk_hw *hw)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+
+	/*
+	 * Read the config register so that the parent is properly mapped at
+	 * registration time.
+	 */
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &rcg->parked_cfg);
+
+	return 0;
+}
+
+/*
+ * Like clk_rcg2_shared_ops but skip the init so that the clk frequency is left
+ * unchanged at registration time.
+ */
+const struct clk_ops clk_rcg2_shared_no_init_park_ops = {
+	.init = clk_rcg2_shared_no_init_park,
+	.enable = clk_rcg2_shared_enable,
+	.disable = clk_rcg2_shared_disable,
+	.get_parent = clk_rcg2_shared_get_parent,
+	.set_parent = clk_rcg2_shared_set_parent,
+	.recalc_rate = clk_rcg2_shared_recalc_rate,
+	.determine_rate = clk_rcg2_determine_rate,
+	.set_rate = clk_rcg2_shared_set_rate,
+	.set_rate_and_parent = clk_rcg2_shared_set_rate_and_parent,
+};
+EXPORT_SYMBOL_GPL(clk_rcg2_shared_no_init_park_ops);
+
+/* Common APIs to be used for DFS based RCGR */
+static void clk_rcg2_dfs_populate_freq(struct clk_hw *hw, unsigned int l,
+				       struct freq_tbl *f)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct clk_hw *p;
+	unsigned long prate = 0;
+	u32 val, mask, cfg, mode, src;
+	int i, num_parents;
+
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_DFSR(l), &cfg);
+
+	mask = BIT(rcg->hid_width) - 1;
+	f->pre_div = 1;
+	if (cfg & mask)
+		f->pre_div = cfg & mask;
+
+	src = cfg & CFG_SRC_SEL_MASK;
+	src >>= CFG_SRC_SEL_SHIFT;
+
+	num_parents = clk_hw_get_num_parents(hw);
+	for (i = 0; i < num_parents; i++) {
+		if (src == rcg->parent_map[i].cfg) {
+			f->src = rcg->parent_map[i].src;
+			p = clk_hw_get_parent_by_index(&rcg->clkr.hw, i);
+			prate = clk_hw_get_rate(p);
+		}
+	}
+
+	mode = cfg & CFG_MODE_MASK;
+	mode >>= CFG_MODE_SHIFT;
+	if (mode) {
+		mask = BIT(rcg->mnd_width) - 1;
+		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_M_DFSR(l),
+			    &val);
+		val &= mask;
+		f->m = val;
+
+		regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_N_DFSR(l),
+			    &val);
+		val = ~val;
+		val &= mask;
+		val += f->m;
+		f->n = val;
+	}
+
+	f->freq = calc_rate(prate, f->m, f->n, mode, f->pre_div);
+}
+
+static int clk_rcg2_dfs_populate_freq_table(struct clk_rcg2 *rcg)
+{
+	struct freq_tbl *freq_tbl;
+	int i;
+
+	/* Allocate space for 1 extra since table is NULL terminated */
+	freq_tbl = kcalloc(MAX_PERF_LEVEL + 1, sizeof(*freq_tbl), GFP_KERNEL);
+	if (!freq_tbl)
+		return -ENOMEM;
+	rcg->freq_tbl = freq_tbl;
+
+	for (i = 0; i < MAX_PERF_LEVEL; i++)
+		clk_rcg2_dfs_populate_freq(&rcg->clkr.hw, i, freq_tbl + i);
+
+	return 0;
+}
+
+static int clk_rcg2_dfs_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	int ret;
+
+	if (!rcg->freq_tbl) {
+		ret = clk_rcg2_dfs_populate_freq_table(rcg);
+		if (ret) {
+			pr_err("Failed to update DFS tables for %s\n",
+					clk_hw_get_name(hw));
+			return ret;
+		}
+	}
+
+	return clk_rcg2_determine_rate(hw, req);
+}
+
+static unsigned long
+clk_rcg2_dfs_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	u32 level, mask, cfg, m = 0, n = 0, mode, pre_div;
+
+	regmap_read(rcg->clkr.regmap,
+		    rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET, &level);
+	level &= GENMASK(4, 1);
+	level >>= 1;
+
+	if (rcg->freq_tbl)
+		return rcg->freq_tbl[level].freq;
+
+	/*
+	 * Assume that parent_rate is actually the parent because
+	 * we can't do any better at figuring it out when the table
+	 * hasn't been populated yet. We only populate the table
+	 * in determine_rate because we can't guarantee the parents
+	 * will be registered with the framework until then.
+	 */
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + SE_PERF_DFSR(level),
+		    &cfg);
+
+	mask = BIT(rcg->hid_width) - 1;
+	pre_div = 1;
+	if (cfg & mask)
+		pre_div = cfg & mask;
+
+	mode = cfg & CFG_MODE_MASK;
+	mode >>= CFG_MODE_SHIFT;
+	if (mode) {
+		mask = BIT(rcg->mnd_width) - 1;
+		regmap_read(rcg->clkr.regmap,
+			    rcg->cmd_rcgr + SE_PERF_M_DFSR(level), &m);
+		m &= mask;
+
+		regmap_read(rcg->clkr.regmap,
+			    rcg->cmd_rcgr + SE_PERF_N_DFSR(level), &n);
+		n = ~n;
+		n &= mask;
+		n += m;
+	}
+
+	return calc_rate(parent_rate, m, n, mode, pre_div);
+}
+
+static const struct clk_ops clk_rcg2_dfs_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.determine_rate = clk_rcg2_dfs_determine_rate,
+	.recalc_rate = clk_rcg2_dfs_recalc_rate,
+};
+
+static int clk_rcg2_enable_dfs(const struct clk_rcg_dfs_data *data,
+			       struct regmap *regmap)
+{
+	struct clk_rcg2 *rcg = data->rcg;
+	struct clk_init_data *init = data->init;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(regmap, rcg->cmd_rcgr + SE_CMD_DFSR_OFFSET, &val);
+	if (ret)
+		return -EINVAL;
+
+	if (!(val & SE_CMD_DFS_EN))
+		return 0;
+
+	/*
+	 * Rate changes with consumer writing a register in
+	 * their own I/O region
+	 */
+	init->flags |= CLK_GET_RATE_NOCACHE;
+	init->ops = &clk_rcg2_dfs_ops;
+
+	rcg->freq_tbl = NULL;
+
+	return 0;
+}
+
+int qcom_cc_register_rcg_dfs(struct regmap *regmap,
+			     const struct clk_rcg_dfs_data *rcgs, size_t len)
+{
+	int i, ret;
+
+	for (i = 0; i < len; i++) {
+		ret = clk_rcg2_enable_dfs(&rcgs[i], regmap);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_cc_register_rcg_dfs);
+
+static int clk_rcg2_dp_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	struct freq_tbl f = { 0 };
+	u32 mask = BIT(rcg->hid_width) - 1;
+	u32 hid_div, cfg;
+	int i, num_parents = clk_hw_get_num_parents(hw);
+	unsigned long num, den;
+
+	rational_best_approximation(parent_rate, rate,
+			GENMASK(rcg->mnd_width - 1, 0),
+			GENMASK(rcg->mnd_width - 1, 0), &den, &num);
+
+	if (!num || !den)
+		return -EINVAL;
+
+	regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + CFG_REG, &cfg);
+	hid_div = cfg;
+	cfg &= CFG_SRC_SEL_MASK;
+	cfg >>= CFG_SRC_SEL_SHIFT;
+
+	for (i = 0; i < num_parents; i++) {
+		if (cfg == rcg->parent_map[i].cfg) {
+			f.src = rcg->parent_map[i].src;
+			break;
+		}
+	}
+
+	f.pre_div = hid_div;
+	f.pre_div >>= CFG_SRC_DIV_SHIFT;
+	f.pre_div &= mask;
+
+	if (num != den) {
+		f.m = num;
+		f.n = den;
+	} else {
+		f.m = 0;
+		f.n = 0;
+	}
+
+	return clk_rcg2_configure(rcg, &f);
+}
+
+static int clk_rcg2_dp_set_rate_and_parent(struct clk_hw *hw,
+		unsigned long rate, unsigned long parent_rate, u8 index)
+{
+	return clk_rcg2_dp_set_rate(hw, rate, parent_rate);
+}
+
+static int clk_rcg2_dp_determine_rate(struct clk_hw *hw,
+				struct clk_rate_request *req)
+{
+	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
+	unsigned long num, den;
+	u64 tmp;
+
+	/* Parent rate is a fixed phy link rate */
+	rational_best_approximation(req->best_parent_rate, req->rate,
+			GENMASK(rcg->mnd_width - 1, 0),
+			GENMASK(rcg->mnd_width - 1, 0), &den, &num);
+
+	if (!num || !den)
+		return -EINVAL;
+
+	tmp = req->best_parent_rate * num;
+	do_div(tmp, den);
+	req->rate = tmp;
+
+	return 0;
+}
+
+const struct clk_ops clk_dp_ops = {
+	.is_enabled = clk_rcg2_is_enabled,
+	.get_parent = clk_rcg2_get_parent,
+	.set_parent = clk_rcg2_set_parent,
+	.recalc_rate = clk_rcg2_recalc_rate,
+	.set_rate = clk_rcg2_dp_set_rate,
+	.set_rate_and_parent = clk_rcg2_dp_set_rate_and_parent,
+	.determine_rate = clk_rcg2_dp_determine_rate,
+};
+EXPORT_SYMBOL_GPL(clk_dp_ops);
diff --git a/drivers/clk/qcom/ccf/clk-regmap-divider.c b/drivers/clk/qcom/ccf/clk-regmap-divider.c
new file mode 100644
index 000000000000..4f5395f0ab6d
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap-divider.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <linux/export.h>
+
+#include "clk-regmap-divider.h"
+
+static inline struct clk_regmap_div *to_clk_regmap_div(struct clk_hw *hw)
+{
+	return container_of(to_clk_regmap(hw), struct clk_regmap_div, clkr);
+}
+
+static int div_ro_determine_rate(struct clk_hw *hw,
+				 struct clk_rate_request *req)
+{
+	struct clk_regmap_div *divider = to_clk_regmap_div(hw);
+	struct clk_regmap *clkr = &divider->clkr;
+	u32 val;
+
+	regmap_read(clkr->regmap, divider->reg, &val);
+	val >>= divider->shift;
+	val &= BIT(divider->width) - 1;
+
+	req->rate = divider_ro_round_rate(hw, req->rate,
+					  &req->best_parent_rate, NULL,
+					  divider->width,
+					  CLK_DIVIDER_ROUND_CLOSEST, val);
+
+	return 0;
+}
+
+static int div_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
+{
+	struct clk_regmap_div *divider = to_clk_regmap_div(hw);
+
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       NULL,
+				       divider->width,
+				       CLK_DIVIDER_ROUND_CLOSEST);
+
+	return 0;
+}
+
+static int div_set_rate(struct clk_hw *hw, unsigned long rate,
+			unsigned long parent_rate)
+{
+	struct clk_regmap_div *divider = to_clk_regmap_div(hw);
+	struct clk_regmap *clkr = &divider->clkr;
+	u32 div;
+
+	div = divider_get_val(rate, parent_rate, NULL, divider->width,
+			      CLK_DIVIDER_ROUND_CLOSEST);
+
+	return regmap_update_bits(clkr->regmap, divider->reg,
+				  (BIT(divider->width) - 1) << divider->shift,
+				  div << divider->shift);
+}
+
+static unsigned long div_recalc_rate(struct clk_hw *hw,
+				     unsigned long parent_rate)
+{
+	struct clk_regmap_div *divider = to_clk_regmap_div(hw);
+	struct clk_regmap *clkr = &divider->clkr;
+	u32 div;
+
+	regmap_read(clkr->regmap, divider->reg, &div);
+	div >>= divider->shift;
+	div &= BIT(divider->width) - 1;
+
+	return divider_recalc_rate(hw, parent_rate, div, NULL,
+				   CLK_DIVIDER_ROUND_CLOSEST, divider->width);
+}
+
+const struct clk_ops clk_regmap_div_ops = {
+	.determine_rate = div_determine_rate,
+	.set_rate = div_set_rate,
+	.recalc_rate = div_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_div_ops);
+
+const struct clk_ops clk_regmap_div_ro_ops = {
+	.determine_rate = div_ro_determine_rate,
+	.recalc_rate = div_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_div_ro_ops);
diff --git a/drivers/clk/qcom/ccf/clk-regmap-divider.h b/drivers/clk/qcom/ccf/clk-regmap-divider.h
new file mode 100644
index 000000000000..e75a65c3839c
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap-divider.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __QCOM_CLK_REGMAP_DIVIDER_H__
+#define __QCOM_CLK_REGMAP_DIVIDER_H__
+
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+
+struct clk_regmap_div {
+	u32			reg;
+	u32			shift;
+	u32			width;
+	struct clk_regmap	clkr;
+};
+
+extern const struct clk_ops clk_regmap_div_ops;
+extern const struct clk_ops clk_regmap_div_ro_ops;
+
+#endif
diff --git a/drivers/clk/qcom/ccf/clk-regmap-mux-div.c b/drivers/clk/qcom/ccf/clk-regmap-mux-div.c
new file mode 100644
index 000000000000..6044839da85a
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap-mux-div.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017, Linaro Limited
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+
+#include "clk-regmap-mux-div.h"
+
+#define CMD_RCGR			0x0
+#define CMD_RCGR_UPDATE			BIT(0)
+#define CMD_RCGR_DIRTY_CFG		BIT(4)
+#define CMD_RCGR_ROOT_OFF		BIT(31)
+#define CFG_RCGR			0x4
+
+#define to_clk_regmap_mux_div(_hw) \
+	container_of(to_clk_regmap(_hw), struct clk_regmap_mux_div, clkr)
+
+int mux_div_set_src_div(struct clk_regmap_mux_div *md, u32 src, u32 div)
+{
+	int ret, count;
+	u32 val, mask;
+	const char *name = clk_hw_get_name(&md->clkr.hw);
+
+	val = (div << md->hid_shift) | (src << md->src_shift);
+	mask = ((BIT(md->hid_width) - 1) << md->hid_shift) |
+	       ((BIT(md->src_width) - 1) << md->src_shift);
+
+	ret = regmap_update_bits(md->clkr.regmap, CFG_RCGR + md->reg_offset,
+				 mask, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(md->clkr.regmap, CMD_RCGR + md->reg_offset,
+				 CMD_RCGR_UPDATE, CMD_RCGR_UPDATE);
+	if (ret)
+		return ret;
+
+	/* Wait for update to take effect */
+	for (count = 500; count > 0; count--) {
+		ret = regmap_read(md->clkr.regmap, CMD_RCGR + md->reg_offset,
+				  &val);
+		if (ret)
+			return ret;
+		if (!(val & CMD_RCGR_UPDATE))
+			return 0;
+		udelay(1);
+	}
+
+	pr_err("%s: RCG did not update its configuration", name);
+	return -EBUSY;
+}
+EXPORT_SYMBOL_GPL(mux_div_set_src_div);
+
+static void mux_div_get_src_div(struct clk_regmap_mux_div *md, u32 *src,
+				u32 *div)
+{
+	u32 val, d, s;
+	const char *name = clk_hw_get_name(&md->clkr.hw);
+
+	regmap_read(md->clkr.regmap, CMD_RCGR + md->reg_offset, &val);
+
+	if (val & CMD_RCGR_DIRTY_CFG) {
+		pr_err("%s: RCG configuration is pending\n", name);
+		return;
+	}
+
+	regmap_read(md->clkr.regmap, CFG_RCGR + md->reg_offset, &val);
+	s = (val >> md->src_shift);
+	s &= BIT(md->src_width) - 1;
+	*src = s;
+
+	d = (val >> md->hid_shift);
+	d &= BIT(md->hid_width) - 1;
+	*div = d;
+}
+
+static inline bool is_better_rate(unsigned long req, unsigned long best,
+				  unsigned long new)
+{
+	return (req <= new && new < best) || (best < req && best < new);
+}
+
+static int mux_div_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
+{
+	struct clk_regmap_mux_div *md = to_clk_regmap_mux_div(hw);
+	unsigned int i, div, max_div;
+	unsigned long actual_rate, best_rate = 0;
+	unsigned long req_rate = req->rate;
+
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
+		unsigned long parent_rate = clk_hw_get_rate(parent);
+
+		max_div = BIT(md->hid_width) - 1;
+		for (div = 1; div < max_div; div++) {
+			parent_rate = mult_frac(req_rate, div, 2);
+			parent_rate = clk_hw_round_rate(parent, parent_rate);
+			actual_rate = mult_frac(parent_rate, 2, div);
+
+			if (is_better_rate(req_rate, best_rate, actual_rate)) {
+				best_rate = actual_rate;
+				req->rate = best_rate;
+				req->best_parent_rate = parent_rate;
+				req->best_parent_hw = parent;
+			}
+
+			if (actual_rate < req_rate || best_rate <= req_rate)
+				break;
+		}
+	}
+
+	if (!best_rate)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __mux_div_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
+					 unsigned long prate, u32 src)
+{
+	struct clk_regmap_mux_div *md = to_clk_regmap_mux_div(hw);
+	int ret;
+	u32 div, max_div, best_src = 0, best_div = 0;
+	unsigned int i;
+	unsigned long actual_rate, best_rate = 0;
+
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
+		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
+		unsigned long parent_rate = clk_hw_get_rate(parent);
+
+		max_div = BIT(md->hid_width) - 1;
+		for (div = 1; div < max_div; div++) {
+			parent_rate = mult_frac(rate, div, 2);
+			parent_rate = clk_hw_round_rate(parent, parent_rate);
+			actual_rate = mult_frac(parent_rate, 2, div);
+
+			if (is_better_rate(rate, best_rate, actual_rate)) {
+				best_rate = actual_rate;
+				best_src = md->parent_map[i];
+				best_div = div - 1;
+			}
+
+			if (actual_rate < rate || best_rate <= rate)
+				break;
+		}
+	}
+
+	ret = mux_div_set_src_div(md, best_src, best_div);
+	if (!ret) {
+		md->div = best_div;
+		md->src = best_src;
+	}
+
+	return ret;
+}
+
+static u8 mux_div_get_parent(struct clk_hw *hw)
+{
+	struct clk_regmap_mux_div *md = to_clk_regmap_mux_div(hw);
+	const char *name = clk_hw_get_name(hw);
+	u32 i, div, src = 0;
+
+	mux_div_get_src_div(md, &src, &div);
+
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++)
+		if (src == md->parent_map[i])
+			return i;
+
+	pr_err("%s: Can't find parent with src %d\n", name, src);
+	return 0;
+}
+
+static int mux_div_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_regmap_mux_div *md = to_clk_regmap_mux_div(hw);
+
+	return mux_div_set_src_div(md, md->parent_map[index], md->div);
+}
+
+static int mux_div_set_rate(struct clk_hw *hw,
+			    unsigned long rate, unsigned long prate)
+{
+	struct clk_regmap_mux_div *md = to_clk_regmap_mux_div(hw);
+
+	return __mux_div_set_rate_and_parent(hw, rate, prate, md->src);
+}
+
+static int mux_div_set_rate_and_parent(struct clk_hw *hw,  unsigned long rate,
+				       unsigned long prate, u8 index)
+{
+	struct clk_regmap_mux_div *md = to_clk_regmap_mux_div(hw);
+
+	return __mux_div_set_rate_and_parent(hw, rate, prate,
+					     md->parent_map[index]);
+}
+
+static unsigned long mux_div_recalc_rate(struct clk_hw *hw, unsigned long prate)
+{
+	struct clk_regmap_mux_div *md = to_clk_regmap_mux_div(hw);
+	u32 div, src;
+	int i, num_parents = clk_hw_get_num_parents(hw);
+	const char *name = clk_hw_get_name(hw);
+
+	mux_div_get_src_div(md, &src, &div);
+	for (i = 0; i < num_parents; i++)
+		if (src == md->parent_map[i]) {
+			struct clk_hw *p = clk_hw_get_parent_by_index(hw, i);
+			unsigned long parent_rate = clk_hw_get_rate(p);
+
+			return mult_frac(parent_rate, 2, div + 1);
+		}
+
+	pr_err("%s: Can't find parent %d\n", name, src);
+	return 0;
+}
+
+const struct clk_ops clk_regmap_mux_div_ops = {
+	.get_parent = mux_div_get_parent,
+	.set_parent = mux_div_set_parent,
+	.set_rate = mux_div_set_rate,
+	.set_rate_and_parent = mux_div_set_rate_and_parent,
+	.determine_rate = mux_div_determine_rate,
+	.recalc_rate = mux_div_recalc_rate,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_mux_div_ops);
diff --git a/drivers/clk/qcom/ccf/clk-regmap-mux-div.h b/drivers/clk/qcom/ccf/clk-regmap-mux-div.h
new file mode 100644
index 000000000000..4df6c8d24c24
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap-mux-div.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, Linaro Limited
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __QCOM_CLK_REGMAP_MUX_DIV_H__
+#define __QCOM_CLK_REGMAP_MUX_DIV_H__
+
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+
+/**
+ * struct mux_div_clk - combined mux/divider clock
+ * @reg_offset: offset of the mux/divider register
+ * @hid_width:	number of bits in half integer divider
+ * @hid_shift:	lowest bit of hid value field
+ * @src_width:	number of bits in source select
+ * @src_shift:	lowest bit of source select field
+ * @div:	the divider raw configuration value
+ * @src:	the mux index which will be used if the clock is enabled
+ * @parent_map: map from parent_names index to src_sel field
+ * @clkr:	handle between common and hardware-specific interfaces
+ * @pclk:	the input PLL clock
+ * @clk_nb:	clock notifier for rate changes of the input PLL
+ */
+struct clk_regmap_mux_div {
+	u32				reg_offset;
+	u32				hid_width;
+	u32				hid_shift;
+	u32				src_width;
+	u32				src_shift;
+	u32				div;
+	u32				src;
+	const u32			*parent_map;
+	struct clk_regmap		clkr;
+	struct clk			*pclk;
+	struct notifier_block		clk_nb;
+};
+
+extern const struct clk_ops clk_regmap_mux_div_ops;
+extern int mux_div_set_src_div(struct clk_regmap_mux_div *md, u32 src, u32 div);
+
+#endif
diff --git a/drivers/clk/qcom/ccf/clk-regmap-mux.c b/drivers/clk/qcom/ccf/clk-regmap-mux.c
new file mode 100644
index 000000000000..45d9cca28064
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap-mux.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/regmap.h>
+#include <linux/export.h>
+
+#include "clk-regmap-mux.h"
+
+static inline struct clk_regmap_mux *to_clk_regmap_mux(struct clk_hw *hw)
+{
+	return container_of(to_clk_regmap(hw), struct clk_regmap_mux, clkr);
+}
+
+static u8 mux_get_parent(struct clk_hw *hw)
+{
+	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(mux->width - 1, 0);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, mux->reg, &val);
+
+	val >>= mux->shift;
+	val &= mask;
+
+	if (mux->parent_map)
+		return qcom_find_cfg_index(hw, mux->parent_map, val);
+
+	return val;
+}
+
+static int mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_regmap_mux *mux = to_clk_regmap_mux(hw);
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	unsigned int mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
+	unsigned int val;
+
+	if (mux->parent_map)
+		index = mux->parent_map[index].cfg;
+
+	val = index;
+	val <<= mux->shift;
+
+	return regmap_update_bits(clkr->regmap, mux->reg, mask, val);
+}
+
+const struct clk_ops clk_regmap_mux_closest_ops = {
+	.get_parent = mux_get_parent,
+	.set_parent = mux_set_parent,
+	.determine_rate = __clk_mux_determine_rate_closest,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_mux_closest_ops);
diff --git a/drivers/clk/qcom/ccf/clk-regmap-mux.h b/drivers/clk/qcom/ccf/clk-regmap-mux.h
new file mode 100644
index 000000000000..db6f4cdd9586
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap-mux.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __QCOM_CLK_REGMAP_MUX_H__
+#define __QCOM_CLK_REGMAP_MUX_H__
+
+#include <linux/clk-provider.h>
+#include "clk-regmap.h"
+#include "common.h"
+
+struct clk_regmap_mux {
+	u32			reg;
+	u32			shift;
+	u32			width;
+	const struct parent_map	*parent_map;
+	struct clk_regmap	clkr;
+};
+
+extern const struct clk_ops clk_regmap_mux_closest_ops;
+
+#endif
diff --git a/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c b/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c
new file mode 100644
index 000000000000..7b7243b7107d
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap-phy-mux.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/export.h>
+
+#include "clk-regmap.h"
+#include "clk-regmap-phy-mux.h"
+
+#define PHY_MUX_MASK		GENMASK(1, 0)
+#define PHY_MUX_PHY_SRC		0
+#define PHY_MUX_REF_SRC		2
+
+static inline struct clk_regmap_phy_mux *to_clk_regmap_phy_mux(struct clk_regmap *clkr)
+{
+	return container_of(clkr, struct clk_regmap_phy_mux, clkr);
+}
+
+static int phy_mux_is_enabled(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
+	unsigned int val;
+
+	regmap_read(clkr->regmap, phy_mux->reg, &val);
+	val = FIELD_GET(PHY_MUX_MASK, val);
+
+	WARN_ON(val != PHY_MUX_PHY_SRC && val != PHY_MUX_REF_SRC);
+
+	return val == PHY_MUX_PHY_SRC;
+}
+
+static int phy_mux_enable(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
+
+	return regmap_update_bits(clkr->regmap, phy_mux->reg,
+				  PHY_MUX_MASK,
+				  FIELD_PREP(PHY_MUX_MASK, PHY_MUX_PHY_SRC));
+}
+
+static void phy_mux_disable(struct clk_hw *hw)
+{
+	struct clk_regmap *clkr = to_clk_regmap(hw);
+	struct clk_regmap_phy_mux *phy_mux = to_clk_regmap_phy_mux(clkr);
+
+	regmap_update_bits(clkr->regmap, phy_mux->reg,
+			   PHY_MUX_MASK,
+			   FIELD_PREP(PHY_MUX_MASK, PHY_MUX_REF_SRC));
+}
+
+const struct clk_ops clk_regmap_phy_mux_ops = {
+	.enable = phy_mux_enable,
+	.disable = phy_mux_disable,
+	.is_enabled = phy_mux_is_enabled,
+};
+EXPORT_SYMBOL_GPL(clk_regmap_phy_mux_ops);
diff --git a/drivers/clk/qcom/ccf/clk-regmap-phy-mux.h b/drivers/clk/qcom/ccf/clk-regmap-phy-mux.h
new file mode 100644
index 000000000000..614dd384695c
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap-phy-mux.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, Linaro Ltd.
+ */
+
+#ifndef __QCOM_CLK_REGMAP_PHY_MUX_H__
+#define __QCOM_CLK_REGMAP_PHY_MUX_H__
+
+#include "clk-regmap.h"
+
+/*
+ * A clock implementation for PHY pipe and symbols clock muxes.
+ *
+ * If the clock is running off the from-PHY source, report it as enabled.
+ * Report it as disabled otherwise (if it uses reference source).
+ *
+ * This way the PHY will disable the pipe clock before turning off the GDSC,
+ * which in turn would lead to disabling corresponding pipe_clk_src (and thus
+ * it being parked to a safe, reference clock source). And vice versa, after
+ * enabling the GDSC the PHY will enable the pipe clock, which would cause
+ * pipe_clk_src to be switched from a safe source to the working one.
+ *
+ * For some platforms this should be used for the UFS symbol_clk_src clocks
+ * too.
+ */
+struct clk_regmap_phy_mux {
+	u32			reg;
+	struct clk_regmap	clkr;
+};
+
+extern const struct clk_ops clk_regmap_phy_mux_ops;
+
+#endif
diff --git a/drivers/clk/qcom/ccf/clk-regmap.c b/drivers/clk/qcom/ccf/clk-regmap.c
new file mode 100644
index 000000000000..92ac4e0d7dbe
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/device.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/export.h>
+
+#include "clk-regmap.h"
+
+/**
+ * clk_is_enabled_regmap - standard is_enabled() for regmap users
+ *
+ * @hw: clk to operate on
+ *
+ * Clocks that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their struct clk_regmap and then use
+ * this as their is_enabled operation, saving some code.
+ */
+int clk_is_enabled_regmap(struct clk_hw *hw)
+{
+	struct clk_regmap *rclk = to_clk_regmap(hw);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rclk->regmap, rclk->enable_reg, &val);
+	if (ret != 0)
+		return ret;
+
+	if (rclk->enable_is_inverted)
+		return (val & rclk->enable_mask) == 0;
+	else
+		return (val & rclk->enable_mask) != 0;
+}
+EXPORT_SYMBOL_GPL(clk_is_enabled_regmap);
+
+/**
+ * clk_enable_regmap - standard enable() for regmap users
+ *
+ * @hw: clk to operate on
+ *
+ * Clocks that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their struct clk_regmap and then use
+ * this as their enable() operation, saving some code.
+ */
+int clk_enable_regmap(struct clk_hw *hw)
+{
+	struct clk_regmap *rclk = to_clk_regmap(hw);
+	unsigned int val;
+
+	if (rclk->enable_is_inverted)
+		val = 0;
+	else
+		val = rclk->enable_mask;
+
+	return regmap_update_bits(rclk->regmap, rclk->enable_reg,
+				  rclk->enable_mask, val);
+}
+EXPORT_SYMBOL_GPL(clk_enable_regmap);
+
+/**
+ * clk_disable_regmap - standard disable() for regmap users
+ *
+ * @hw: clk to operate on
+ *
+ * Clocks that use regmap for their register I/O can set the
+ * enable_reg and enable_mask fields in their struct clk_regmap and then use
+ * this as their disable() operation, saving some code.
+ */
+void clk_disable_regmap(struct clk_hw *hw)
+{
+	struct clk_regmap *rclk = to_clk_regmap(hw);
+	unsigned int val;
+
+	if (rclk->enable_is_inverted)
+		val = rclk->enable_mask;
+	else
+		val = 0;
+
+	regmap_update_bits(rclk->regmap, rclk->enable_reg, rclk->enable_mask,
+			   val);
+}
+EXPORT_SYMBOL_GPL(clk_disable_regmap);
+
+/**
+ * devm_clk_register_regmap - register a clk_regmap clock
+ *
+ * @dev: reference to the caller's device
+ * @rclk: clk to operate on
+ *
+ * Clocks that use regmap for their register I/O should register their
+ * clk_regmap struct via this function so that the regmap is initialized
+ * and so that the clock is registered with the common clock framework.
+ */
+int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk)
+{
+	if (dev && dev_get_regmap(dev, NULL))
+		rclk->regmap = dev_get_regmap(dev, NULL);
+	else if (dev && dev->parent)
+		rclk->regmap = dev_get_regmap(dev->parent, NULL);
+
+	return devm_clk_hw_register(dev, &rclk->hw);
+}
+EXPORT_SYMBOL_GPL(devm_clk_register_regmap);
diff --git a/drivers/clk/qcom/ccf/clk-regmap.h b/drivers/clk/qcom/ccf/clk-regmap.h
new file mode 100644
index 000000000000..14ec659a3a77
--- /dev/null
+++ b/drivers/clk/qcom/ccf/clk-regmap.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2014, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_CLK_REGMAP_H__
+#define __QCOM_CLK_REGMAP_H__
+
+#include <linux/clk-provider.h>
+
+struct regmap;
+
+/**
+ * struct clk_regmap - regmap supporting clock
+ * @hw:		handle between common and hardware-specific interfaces
+ * @regmap:	regmap to use for regmap helpers and/or by providers
+ * @enable_reg: register when using regmap enable/disable ops
+ * @enable_mask: mask when using regmap enable/disable ops
+ * @enable_is_inverted: flag to indicate set enable_mask bits to disable
+ *                      when using clock_enable_regmap and friends APIs.
+ */
+struct clk_regmap {
+	struct clk_hw hw;
+	struct regmap *regmap;
+	unsigned int enable_reg;
+	unsigned int enable_mask;
+	bool enable_is_inverted;
+};
+
+static inline struct clk_regmap *to_clk_regmap(struct clk_hw *hw)
+{
+	return container_of(hw, struct clk_regmap, hw);
+}
+
+int clk_is_enabled_regmap(struct clk_hw *hw);
+int clk_enable_regmap(struct clk_hw *hw);
+void clk_disable_regmap(struct clk_hw *hw);
+int devm_clk_register_regmap(struct device *dev, struct clk_regmap *rclk);
+
+#endif
diff --git a/drivers/clk/qcom/ccf/common.c b/drivers/clk/qcom/ccf/common.c
new file mode 100644
index 000000000000..121591886774
--- /dev/null
+++ b/drivers/clk/qcom/ccf/common.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/platform_device.h>
+#include <linux/clk-provider.h>
+#include <linux/interconnect-clk.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset-controller.h>
+#include <linux/of.h>
+
+#include "common.h"
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "reset.h"
+#include "gdsc.h"
+
+struct qcom_cc {
+	struct qcom_reset_controller reset;
+	struct clk_regmap **rclks;
+	size_t num_rclks;
+	struct dev_pm_domain_list *pd_list;
+};
+
+const
+struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, unsigned long rate)
+{
+	if (!f)
+		return NULL;
+
+	if (!f->freq)
+		return f;
+
+	for (; f->freq; f++)
+		if (rate <= f->freq)
+			return f;
+
+	/* Default to our fastest rate */
+	return f - 1;
+}
+EXPORT_SYMBOL_GPL(qcom_find_freq);
+
+const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
+						  unsigned long rate)
+{
+	if (!f)
+		return NULL;
+
+	if (!f->freq)
+		return f;
+
+	for (; f->freq; f++)
+		if (rate <= f->freq)
+			return f;
+
+	/* Default to our fastest rate */
+	return f - 1;
+}
+EXPORT_SYMBOL_GPL(qcom_find_freq_multi);
+
+const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
+					    unsigned long rate)
+{
+	const struct freq_tbl *best = NULL;
+
+	for ( ; f->freq; f++) {
+		if (rate >= f->freq)
+			best = f;
+		else
+			break;
+	}
+
+	return best;
+}
+EXPORT_SYMBOL_GPL(qcom_find_freq_floor);
+
+int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map, u8 src)
+{
+	int i, num_parents = clk_hw_get_num_parents(hw);
+
+	for (i = 0; i < num_parents; i++)
+		if (src == map[i].src)
+			return i;
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(qcom_find_src_index);
+
+int qcom_find_cfg_index(struct clk_hw *hw, const struct parent_map *map, u8 cfg)
+{
+	int i, num_parents = clk_hw_get_num_parents(hw);
+
+	for (i = 0; i < num_parents; i++)
+		if (cfg == map[i].cfg)
+			return i;
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_GPL(qcom_find_cfg_index);
+
+struct regmap *
+qcom_cc_map(struct platform_device *pdev, const struct qcom_cc_desc *desc)
+{
+	void __iomem *base;
+	struct device *dev = &pdev->dev;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	return devm_regmap_init_mmio(dev, base, desc->config);
+}
+EXPORT_SYMBOL_GPL(qcom_cc_map);
+
+void
+qcom_pll_set_fsm_mode(struct regmap *map, u32 reg, u8 bias_count, u8 lock_count)
+{
+	u32 val;
+	u32 mask;
+
+	/* De-assert reset to FSM */
+	regmap_update_bits(map, reg, PLL_VOTE_FSM_RESET, 0);
+
+	/* Program bias count and lock count */
+	val = bias_count << PLL_BIAS_COUNT_SHIFT |
+		lock_count << PLL_LOCK_COUNT_SHIFT;
+	mask = PLL_BIAS_COUNT_MASK << PLL_BIAS_COUNT_SHIFT;
+	mask |= PLL_LOCK_COUNT_MASK << PLL_LOCK_COUNT_SHIFT;
+	regmap_update_bits(map, reg, mask, val);
+
+	/* Enable PLL FSM voting */
+	regmap_update_bits(map, reg, PLL_VOTE_FSM_ENA, PLL_VOTE_FSM_ENA);
+}
+EXPORT_SYMBOL_GPL(qcom_pll_set_fsm_mode);
+
+static void qcom_cc_gdsc_unregister(void *data)
+{
+	gdsc_unregister(data);
+}
+
+/*
+ * Backwards compatibility with old DTs. Register a pass-through factor 1/1
+ * clock to translate 'path' clk into 'name' clk and register the 'path'
+ * clk as a fixed rate clock if it isn't present.
+ */
+static int _qcom_cc_register_board_clk(struct device *dev, const char *path,
+				       const char *name, unsigned long rate,
+				       bool add_factor)
+{
+	struct device_node *node = NULL;
+	struct device_node *clocks_node;
+	struct clk_fixed_factor *factor;
+	struct clk_fixed_rate *fixed;
+	struct clk_init_data init_data = { };
+	int ret;
+
+	clocks_node = of_find_node_by_path("/clocks");
+	if (clocks_node) {
+		node = of_get_child_by_name(clocks_node, path);
+		of_node_put(clocks_node);
+	}
+
+	if (!node) {
+		fixed = devm_kzalloc(dev, sizeof(*fixed), GFP_KERNEL);
+		if (!fixed)
+			return -EINVAL;
+
+		fixed->fixed_rate = rate;
+		fixed->hw.init = &init_data;
+
+		init_data.name = path;
+		init_data.ops = &clk_fixed_rate_ops;
+
+		ret = devm_clk_hw_register(dev, &fixed->hw);
+		if (ret)
+			return ret;
+	}
+	of_node_put(node);
+
+	if (add_factor) {
+		factor = devm_kzalloc(dev, sizeof(*factor), GFP_KERNEL);
+		if (!factor)
+			return -EINVAL;
+
+		factor->mult = factor->div = 1;
+		factor->hw.init = &init_data;
+
+		init_data.name = name;
+		init_data.parent_names = &path;
+		init_data.num_parents = 1;
+		init_data.flags = 0;
+		init_data.ops = &clk_fixed_factor_ops;
+
+		ret = devm_clk_hw_register(dev, &factor->hw);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int qcom_cc_register_board_clk(struct device *dev, const char *path,
+			       const char *name, unsigned long rate)
+{
+	bool add_factor = true;
+
+	/*
+	 * TODO: The RPM clock driver currently does not support the xo clock.
+	 * When xo is added to the RPM clock driver, we should change this
+	 * function to skip registration of xo factor clocks.
+	 */
+
+	return _qcom_cc_register_board_clk(dev, path, name, rate, add_factor);
+}
+EXPORT_SYMBOL_GPL(qcom_cc_register_board_clk);
+
+int qcom_cc_register_sleep_clk(struct device *dev)
+{
+	return _qcom_cc_register_board_clk(dev, "sleep_clk", "sleep_clk_src",
+					   32768, true);
+}
+EXPORT_SYMBOL_GPL(qcom_cc_register_sleep_clk);
+
+/* Drop 'protected-clocks' from the list of clocks to register */
+static void qcom_cc_drop_protected(struct device *dev, struct qcom_cc *cc)
+{
+	struct device_node *np = dev->of_node;
+	u32 i;
+
+	of_property_for_each_u32(np, "protected-clocks", i) {
+		if (i >= cc->num_rclks)
+			continue;
+
+		cc->rclks[i] = NULL;
+	}
+}
+
+static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
+					 void *data)
+{
+	struct qcom_cc *cc = data;
+	unsigned int idx = clkspec->args[0];
+
+	if (idx >= cc->num_rclks) {
+		pr_err("%s: invalid index %u\n", __func__, idx);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
+}
+
+static int qcom_cc_icc_register(struct device *dev,
+				const struct qcom_cc_desc *desc)
+{
+	struct icc_clk_data *icd;
+	struct clk_hw *hws;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_INTERCONNECT_CLK))
+		return 0;
+
+	if (!desc->icc_hws)
+		return 0;
+
+	icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
+	if (!icd)
+		return -ENOMEM;
+
+	for (i = 0; i < desc->num_icc_hws; i++) {
+		icd[i].master_id = desc->icc_hws[i].master_id;
+		icd[i].slave_id = desc->icc_hws[i].slave_id;
+		hws = &desc->clks[desc->icc_hws[i].clk_id]->hw;
+		icd[i].clk = devm_clk_hw_get_clk(dev, hws, "icc");
+		if (IS_ERR(icd[i].clk))
+			return dev_err_probe(dev, PTR_ERR(icd[i].clk),
+					     "(%d) clock entry is null\n", i);
+		icd[i].name = clk_hw_get_name(hws);
+	}
+
+	return devm_icc_clk_register(dev, desc->icc_first_node_id,
+						     desc->num_icc_hws, icd);
+}
+
+static int qcom_cc_clk_pll_configure(const struct qcom_cc_driver_data *data,
+				     struct regmap *regmap)
+{
+	const struct clk_init_data *init;
+	struct clk_alpha_pll *pll;
+	int i;
+
+	for (i = 0; i < data->num_alpha_plls; i++) {
+		pll = data->alpha_plls[i];
+		init = pll->clkr.hw.init;
+
+		if (!pll->config || !pll->regs) {
+			pr_err("%s: missing pll config or regs\n", init->name);
+			return -EINVAL;
+		}
+
+		qcom_clk_alpha_pll_configure(pll, regmap);
+	}
+
+	return 0;
+}
+
+static void qcom_cc_clk_regs_configure(struct device *dev, const struct qcom_cc_driver_data *data,
+				       struct regmap *regmap)
+{
+	int i;
+
+	for (i = 0; i < data->num_clk_cbcrs; i++)
+		qcom_branch_set_clk_en(regmap, data->clk_cbcrs[i]);
+
+	if (data->clk_regs_configure)
+		data->clk_regs_configure(dev, regmap);
+}
+
+int qcom_cc_really_probe(struct device *dev,
+			 const struct qcom_cc_desc *desc, struct regmap *regmap)
+{
+	int i, ret;
+	struct qcom_reset_controller *reset;
+	struct qcom_cc *cc;
+	struct gdsc_desc *scd;
+	size_t num_clks = desc->num_clks;
+	struct clk_regmap **rclks = desc->clks;
+	size_t num_clk_hws = desc->num_clk_hws;
+	struct clk_hw **clk_hws = desc->clk_hws;
+
+	cc = devm_kzalloc(dev, sizeof(*cc), GFP_KERNEL);
+	if (!cc)
+		return -ENOMEM;
+
+	ret = devm_pm_domain_attach_list(dev, NULL, &cc->pd_list);
+	if (ret < 0 && ret != -EEXIST)
+		return ret;
+
+	if (desc->use_rpm) {
+		ret = devm_pm_runtime_enable(dev);
+		if (ret)
+			return ret;
+
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret)
+			return ret;
+	}
+
+	if (desc->driver_data) {
+		ret = qcom_cc_clk_pll_configure(desc->driver_data, regmap);
+		if (ret)
+			goto put_rpm;
+
+		qcom_cc_clk_regs_configure(dev, desc->driver_data, regmap);
+	}
+
+	reset = &cc->reset;
+	reset->rcdev.of_node = dev->of_node;
+	reset->rcdev.ops = &qcom_reset_ops;
+	reset->rcdev.owner = dev->driver->owner;
+	reset->rcdev.nr_resets = desc->num_resets;
+	reset->regmap = regmap;
+	reset->reset_map = desc->resets;
+
+	ret = devm_reset_controller_register(dev, &reset->rcdev);
+	if (ret)
+		goto put_rpm;
+
+	if (desc->gdscs && desc->num_gdscs) {
+		scd = devm_kzalloc(dev, sizeof(*scd), GFP_KERNEL);
+		if (!scd) {
+			ret = -ENOMEM;
+			goto put_rpm;
+		}
+		scd->dev = dev;
+		scd->scs = desc->gdscs;
+		scd->num = desc->num_gdscs;
+		scd->pd_list = cc->pd_list;
+		ret = gdsc_register(scd, &reset->rcdev, regmap);
+		if (ret)
+			goto put_rpm;
+		ret = devm_add_action_or_reset(dev, qcom_cc_gdsc_unregister,
+					       scd);
+		if (ret)
+			goto put_rpm;
+	}
+
+	if (desc->driver_data &&
+	    desc->driver_data->dfs_rcgs &&
+	    desc->driver_data->num_dfs_rcgs) {
+		ret = qcom_cc_register_rcg_dfs(regmap,
+					       desc->driver_data->dfs_rcgs,
+					       desc->driver_data->num_dfs_rcgs);
+		if (ret)
+			goto put_rpm;
+	}
+
+	cc->rclks = rclks;
+	cc->num_rclks = num_clks;
+
+	qcom_cc_drop_protected(dev, cc);
+
+	for (i = 0; i < num_clk_hws; i++) {
+		ret = devm_clk_hw_register(dev, clk_hws[i]);
+		if (ret)
+			goto put_rpm;
+	}
+
+	for (i = 0; i < num_clks; i++) {
+		if (!rclks[i])
+			continue;
+
+		ret = devm_clk_register_regmap(dev, rclks[i]);
+		if (ret)
+			goto put_rpm;
+	}
+
+	ret = devm_of_clk_add_hw_provider(dev, qcom_cc_clk_hw_get, cc);
+	if (ret)
+		goto put_rpm;
+
+	ret = qcom_cc_icc_register(dev, desc);
+
+put_rpm:
+	if (desc->use_rpm)
+		pm_runtime_put(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
+
+int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return qcom_cc_really_probe(&pdev->dev, desc, regmap);
+}
+EXPORT_SYMBOL_GPL(qcom_cc_probe);
+
+int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
+			   const struct qcom_cc_desc *desc)
+{
+	struct regmap *regmap;
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource(pdev, index);
+	if (IS_ERR(base))
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, desc->config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return qcom_cc_really_probe(&pdev->dev, desc, regmap);
+}
+EXPORT_SYMBOL_GPL(qcom_cc_probe_by_index);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("QTI Common Clock module");
diff --git a/drivers/clk/qcom/ccf/common.h b/drivers/clk/qcom/ccf/common.h
new file mode 100644
index 000000000000..953c91f7b145
--- /dev/null
+++ b/drivers/clk/qcom/ccf/common.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2014, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_CLK_COMMON_H__
+#define __QCOM_CLK_COMMON_H__
+
+struct platform_device;
+struct regmap_config;
+struct clk_regmap;
+struct qcom_reset_map;
+struct regmap;
+struct freq_tbl;
+struct clk_hw;
+
+#define PLL_LOCK_COUNT_SHIFT	8
+#define PLL_LOCK_COUNT_MASK	0x3f
+#define PLL_BIAS_COUNT_SHIFT	14
+#define PLL_BIAS_COUNT_MASK	0x3f
+#define PLL_VOTE_FSM_ENA	BIT(20)
+#define PLL_VOTE_FSM_RESET	BIT(21)
+
+struct qcom_icc_hws_data {
+	int master_id;
+	int slave_id;
+	int clk_id;
+};
+
+struct qcom_cc_driver_data {
+	struct clk_alpha_pll **alpha_plls;
+	size_t num_alpha_plls;
+	u32 *clk_cbcrs;
+	size_t num_clk_cbcrs;
+	const struct clk_rcg_dfs_data *dfs_rcgs;
+	size_t num_dfs_rcgs;
+	void (*clk_regs_configure)(struct device *dev, struct regmap *regmap);
+};
+
+struct qcom_cc_desc {
+	const struct regmap_config *config;
+	struct clk_regmap **clks;
+	size_t num_clks;
+	const struct qcom_reset_map *resets;
+	size_t num_resets;
+	struct gdsc **gdscs;
+	size_t num_gdscs;
+	struct clk_hw **clk_hws;
+	size_t num_clk_hws;
+	const struct qcom_icc_hws_data *icc_hws;
+	size_t num_icc_hws;
+	unsigned int icc_first_node_id;
+	bool use_rpm;
+	struct qcom_cc_driver_data *driver_data;
+};
+
+/**
+ * struct parent_map - map table for source select configuration values
+ * @src: source
+ * @cfg: configuration value
+ */
+struct parent_map {
+	u8 src;
+	u8 cfg;
+};
+
+extern const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f,
+					     unsigned long rate);
+extern const struct freq_tbl *qcom_find_freq_floor(const struct freq_tbl *f,
+						   unsigned long rate);
+extern const struct freq_multi_tbl *qcom_find_freq_multi(const struct freq_multi_tbl *f,
+							 unsigned long rate);
+extern void
+qcom_pll_set_fsm_mode(struct regmap *m, u32 reg, u8 bias_count, u8 lock_count);
+extern int qcom_find_src_index(struct clk_hw *hw, const struct parent_map *map,
+			       u8 src);
+extern int qcom_find_cfg_index(struct clk_hw *hw, const struct parent_map *map,
+			       u8 cfg);
+
+extern int qcom_cc_register_board_clk(struct device *dev, const char *path,
+				      const char *name, unsigned long rate);
+extern int qcom_cc_register_sleep_clk(struct device *dev);
+
+extern struct regmap *qcom_cc_map(struct platform_device *pdev,
+				  const struct qcom_cc_desc *desc);
+extern int qcom_cc_really_probe(struct device *dev,
+				const struct qcom_cc_desc *desc,
+				struct regmap *regmap);
+extern int qcom_cc_probe(struct platform_device *pdev,
+			 const struct qcom_cc_desc *desc);
+extern int qcom_cc_probe_by_index(struct platform_device *pdev, int index,
+				  const struct qcom_cc_desc *desc);
+
+#endif
diff --git a/drivers/clk/qcom/ccf/gdsc.c b/drivers/clk/qcom/ccf/gdsc.c
new file mode 100644
index 000000000000..7deabf8400cf
--- /dev/null
+++ b/drivers/clk/qcom/ccf/gdsc.c
@@ -0,0 +1,667 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015, 2017-2018, 2022, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+#include "gdsc.h"
+
+#define PWR_ON_MASK		BIT(31)
+#define EN_REST_WAIT_MASK	GENMASK_ULL(23, 20)
+#define EN_FEW_WAIT_MASK	GENMASK_ULL(19, 16)
+#define CLK_DIS_WAIT_MASK	GENMASK_ULL(15, 12)
+#define SW_OVERRIDE_MASK	BIT(2)
+#define HW_CONTROL_MASK		BIT(1)
+#define SW_COLLAPSE_MASK	BIT(0)
+#define GMEM_CLAMP_IO_MASK	BIT(0)
+#define GMEM_RESET_MASK		BIT(4)
+
+/* CFG_GDSCR */
+#define GDSC_POWER_UP_COMPLETE		BIT(16)
+#define GDSC_POWER_DOWN_COMPLETE	BIT(15)
+#define GDSC_RETAIN_FF_ENABLE		BIT(11)
+#define CFG_GDSCR_OFFSET		0x4
+
+/* Wait 2^n CXO cycles between all states. Here, n=2 (4 cycles). */
+#define EN_REST_WAIT_VAL	0x2
+#define EN_FEW_WAIT_VAL		0x8
+#define CLK_DIS_WAIT_VAL	0x2
+
+/* Transition delay shifts */
+#define EN_REST_WAIT_SHIFT	20
+#define EN_FEW_WAIT_SHIFT	16
+#define CLK_DIS_WAIT_SHIFT	12
+
+#define RETAIN_MEM		BIT(14)
+#define RETAIN_PERIPH		BIT(13)
+
+#define STATUS_POLL_TIMEOUT_US	2000
+#define TIMEOUT_US		500
+
+#define domain_to_gdsc(domain) container_of(domain, struct gdsc, pd)
+
+enum gdsc_status {
+	GDSC_OFF,
+	GDSC_ON
+};
+
+/* Returns 1 if GDSC status is status, 0 if not, and < 0 on error */
+static int gdsc_check_status(struct gdsc *sc, enum gdsc_status status)
+{
+	unsigned int reg;
+	u32 val;
+	int ret;
+
+	if (sc->flags & POLL_CFG_GDSCR)
+		reg = sc->gdscr + CFG_GDSCR_OFFSET;
+	else if (sc->gds_hw_ctrl)
+		reg = sc->gds_hw_ctrl;
+	else
+		reg = sc->gdscr;
+
+	ret = regmap_read(sc->regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	if (sc->flags & POLL_CFG_GDSCR) {
+		switch (status) {
+		case GDSC_ON:
+			return !!(val & GDSC_POWER_UP_COMPLETE);
+		case GDSC_OFF:
+			return !!(val & GDSC_POWER_DOWN_COMPLETE);
+		}
+	}
+
+	switch (status) {
+	case GDSC_ON:
+		return !!(val & PWR_ON_MASK);
+	case GDSC_OFF:
+		return !(val & PWR_ON_MASK);
+	}
+
+	return -EINVAL;
+}
+
+static int gdsc_hwctrl(struct gdsc *sc, bool en)
+{
+	u32 val = en ? HW_CONTROL_MASK : 0;
+
+	return regmap_update_bits(sc->regmap, sc->gdscr, HW_CONTROL_MASK, val);
+}
+
+static int gdsc_poll_status(struct gdsc *sc, enum gdsc_status status)
+{
+	ktime_t start;
+
+	start = ktime_get();
+	do {
+		if (gdsc_check_status(sc, status))
+			return 0;
+	} while (ktime_us_delta(ktime_get(), start) < STATUS_POLL_TIMEOUT_US);
+
+	if (gdsc_check_status(sc, status))
+		return 0;
+
+	return -ETIMEDOUT;
+}
+
+static int gdsc_update_collapse_bit(struct gdsc *sc, bool val)
+{
+	u32 reg, mask;
+	int ret;
+
+	if (sc->collapse_mask) {
+		reg = sc->collapse_ctrl;
+		mask = sc->collapse_mask;
+	} else {
+		reg = sc->gdscr;
+		mask = SW_COLLAPSE_MASK;
+	}
+
+	ret = regmap_update_bits(sc->regmap, reg, mask, val ? mask : 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int gdsc_toggle_logic(struct gdsc *sc, enum gdsc_status status,
+		bool wait)
+{
+	int ret;
+
+	if (status == GDSC_ON && sc->rsupply) {
+		ret = regulator_enable(sc->rsupply);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = gdsc_update_collapse_bit(sc, status == GDSC_OFF);
+
+	/* If disabling votable gdscs, don't poll on status */
+	if ((sc->flags & VOTABLE) && status == GDSC_OFF && !wait) {
+		/*
+		 * Add a short delay here to ensure that an enable
+		 * right after it was disabled does not put it in an
+		 * unknown state
+		 */
+		udelay(TIMEOUT_US);
+		return 0;
+	}
+
+	if (sc->gds_hw_ctrl) {
+		/*
+		 * The gds hw controller asserts/de-asserts the status bit soon
+		 * after it receives a power on/off request from a master.
+		 * The controller then takes around 8 xo cycles to start its
+		 * internal state machine and update the status bit. During
+		 * this time, the status bit does not reflect the true status
+		 * of the core.
+		 * Add a delay of 1 us between writing to the SW_COLLAPSE bit
+		 * and polling the status bit.
+		 */
+		udelay(1);
+	}
+
+	ret = gdsc_poll_status(sc, status);
+	WARN(ret, "%s status stuck at 'o%s'", sc->pd.name, status ? "ff" : "n");
+
+	if (!ret && status == GDSC_OFF && sc->rsupply) {
+		ret = regulator_disable(sc->rsupply);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
+}
+
+static inline int gdsc_deassert_reset(struct gdsc *sc)
+{
+	int i;
+
+	for (i = 0; i < sc->reset_count; i++)
+		sc->rcdev->ops->deassert(sc->rcdev, sc->resets[i]);
+	return 0;
+}
+
+static inline int gdsc_assert_reset(struct gdsc *sc)
+{
+	int i;
+
+	for (i = 0; i < sc->reset_count; i++)
+		sc->rcdev->ops->assert(sc->rcdev, sc->resets[i]);
+	return 0;
+}
+
+static inline void gdsc_force_mem_on(struct gdsc *sc)
+{
+	int i;
+	u32 mask = RETAIN_MEM;
+
+	if (!(sc->flags & NO_RET_PERIPH))
+		mask |= RETAIN_PERIPH;
+
+	for (i = 0; i < sc->cxc_count; i++)
+		regmap_update_bits(sc->regmap, sc->cxcs[i], mask, mask);
+}
+
+static inline void gdsc_clear_mem_on(struct gdsc *sc)
+{
+	int i;
+	u32 mask = RETAIN_MEM;
+
+	if (!(sc->flags & NO_RET_PERIPH))
+		mask |= RETAIN_PERIPH;
+
+	for (i = 0; i < sc->cxc_count; i++)
+		regmap_update_bits(sc->regmap, sc->cxcs[i], mask, 0);
+}
+
+static inline void gdsc_deassert_clamp_io(struct gdsc *sc)
+{
+	regmap_update_bits(sc->regmap, sc->clamp_io_ctrl,
+			   GMEM_CLAMP_IO_MASK, 0);
+}
+
+static inline void gdsc_assert_clamp_io(struct gdsc *sc)
+{
+	regmap_update_bits(sc->regmap, sc->clamp_io_ctrl,
+			   GMEM_CLAMP_IO_MASK, 1);
+}
+
+static inline void gdsc_assert_reset_aon(struct gdsc *sc)
+{
+	regmap_update_bits(sc->regmap, sc->clamp_io_ctrl,
+			   GMEM_RESET_MASK, 1);
+	udelay(1);
+	regmap_update_bits(sc->regmap, sc->clamp_io_ctrl,
+			   GMEM_RESET_MASK, 0);
+}
+
+static void gdsc_retain_ff_on(struct gdsc *sc)
+{
+	u32 mask = GDSC_RETAIN_FF_ENABLE;
+
+	regmap_update_bits(sc->regmap, sc->gdscr, mask, mask);
+}
+
+static int gdsc_enable(struct generic_pm_domain *domain)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret;
+
+	if (sc->pwrsts == PWRSTS_ON)
+		return gdsc_deassert_reset(sc);
+
+	if (sc->flags & SW_RESET) {
+		gdsc_assert_reset(sc);
+		udelay(1);
+		gdsc_deassert_reset(sc);
+	}
+
+	if (sc->flags & CLAMP_IO) {
+		if (sc->flags & AON_RESET)
+			gdsc_assert_reset_aon(sc);
+		gdsc_deassert_clamp_io(sc);
+	}
+
+	ret = gdsc_toggle_logic(sc, GDSC_ON, false);
+	if (ret)
+		return ret;
+
+	if (sc->pwrsts & PWRSTS_OFF)
+		gdsc_force_mem_on(sc);
+
+	/*
+	 * If clocks to this power domain were already on, they will take an
+	 * additional 4 clock cycles to re-enable after the power domain is
+	 * enabled. Delay to account for this. A delay is also needed to ensure
+	 * clocks are not enabled within 400ns of enabling power to the
+	 * memories.
+	 */
+	udelay(1);
+
+	if (sc->flags & RETAIN_FF_ENABLE)
+		gdsc_retain_ff_on(sc);
+
+	/* Turn on HW trigger mode if supported */
+	if (sc->flags & HW_CTRL) {
+		ret = gdsc_hwctrl(sc, true);
+		if (ret)
+			return ret;
+		/*
+		 * Wait for the GDSC to go through a power down and
+		 * up cycle.  In case a firmware ends up polling status
+		 * bits for the gdsc, it might read an 'on' status before
+		 * the GDSC can finish the power cycle.
+		 * We wait 1us before returning to ensure the firmware
+		 * can't immediately poll the status bits.
+		 */
+		udelay(1);
+	}
+
+	return 0;
+}
+
+static int gdsc_disable(struct generic_pm_domain *domain)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret;
+
+	if (sc->pwrsts == PWRSTS_ON)
+		return gdsc_assert_reset(sc);
+
+	/* Turn off HW trigger mode if supported */
+	if (sc->flags & HW_CTRL) {
+		ret = gdsc_hwctrl(sc, false);
+		if (ret < 0)
+			return ret;
+		/*
+		 * Wait for the GDSC to go through a power down and
+		 * up cycle.  In case we end up polling status
+		 * bits for the gdsc before the power cycle is completed
+		 * it might read an 'on' status wrongly.
+		 */
+		udelay(1);
+
+		ret = gdsc_poll_status(sc, GDSC_ON);
+		if (ret)
+			return ret;
+	}
+
+	if (sc->pwrsts & PWRSTS_OFF)
+		gdsc_clear_mem_on(sc);
+
+	/*
+	 * If the GDSC supports only a Retention state, apart from ON,
+	 * leave it in ON state.
+	 * There is no SW control to transition the GDSC into
+	 * Retention state. This happens in HW when the parent
+	 * domain goes down to a Low power state
+	 */
+	if (sc->pwrsts == PWRSTS_RET_ON)
+		return 0;
+
+	ret = gdsc_toggle_logic(sc, GDSC_OFF, domain->synced_poweroff);
+	if (ret)
+		return ret;
+
+	if (sc->flags & CLAMP_IO)
+		gdsc_assert_clamp_io(sc);
+
+	return 0;
+}
+
+static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret;
+
+	ret = gdsc_hwctrl(sc, mode);
+	if (ret)
+		return ret;
+
+	/*
+	 * Wait for the GDSC to go through a power down and
+	 * up cycle. If we poll the status register before the
+	 * power cycle is finished we might read incorrect values.
+	 */
+	udelay(1);
+
+	/*
+	 * When the GDSC is switched to HW mode, HW can disable the GDSC.
+	 * When the GDSC is switched back to SW mode, the GDSC will be enabled
+	 * again, hence we need to poll for GDSC to complete the power up.
+	 */
+	if (!mode)
+		return gdsc_poll_status(sc, GDSC_ON);
+
+	return 0;
+}
+
+static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	u32 val;
+
+	regmap_read(sc->regmap, sc->gdscr, &val);
+
+	return !!(val & HW_CONTROL_MASK);
+}
+
+static int gdsc_init(struct gdsc *sc)
+{
+	u32 mask, val;
+	int on, ret;
+
+	/*
+	 * Disable HW trigger: collapse/restore occur based on registers writes.
+	 * Disable SW override: Use hardware state-machine for sequencing.
+	 * Configure wait time between states.
+	 */
+	mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
+	       EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
+
+	if (!sc->en_rest_wait_val)
+		sc->en_rest_wait_val = EN_REST_WAIT_VAL;
+	if (!sc->en_few_wait_val)
+		sc->en_few_wait_val = EN_FEW_WAIT_VAL;
+	if (!sc->clk_dis_wait_val)
+		sc->clk_dis_wait_val = CLK_DIS_WAIT_VAL;
+
+	val = sc->en_rest_wait_val << EN_REST_WAIT_SHIFT |
+		sc->en_few_wait_val << EN_FEW_WAIT_SHIFT |
+		sc->clk_dis_wait_val << CLK_DIS_WAIT_SHIFT;
+
+	ret = regmap_update_bits(sc->regmap, sc->gdscr, mask, val);
+	if (ret)
+		return ret;
+
+	/* Force gdsc ON if only ON state is supported */
+	if (sc->pwrsts == PWRSTS_ON) {
+		ret = gdsc_toggle_logic(sc, GDSC_ON, false);
+		if (ret)
+			return ret;
+	}
+
+	on = gdsc_check_status(sc, GDSC_ON);
+	if (on < 0)
+		return on;
+
+	if (on) {
+		/* The regulator must be on, sync the kernel state */
+		if (sc->rsupply) {
+			ret = regulator_enable(sc->rsupply);
+			if (ret < 0)
+				return ret;
+		}
+
+		/*
+		 * Votable GDSCs can be ON due to Vote from other masters.
+		 * If a Votable GDSC is ON, make sure we have a Vote.
+		 */
+		if (sc->flags & VOTABLE) {
+			ret = gdsc_update_collapse_bit(sc, false);
+			if (ret)
+				goto err_disable_supply;
+		}
+
+		/*
+		 * Make sure the retain bit is set if the GDSC is already on,
+		 * otherwise we end up turning off the GDSC and destroying all
+		 * the register contents that we thought we were saving.
+		 */
+		if (sc->flags & RETAIN_FF_ENABLE)
+			gdsc_retain_ff_on(sc);
+
+		/* Turn on HW trigger mode if supported */
+		if (sc->flags & HW_CTRL) {
+			ret = gdsc_hwctrl(sc, true);
+			if (ret < 0)
+				goto err_disable_supply;
+		}
+
+	} else if (sc->flags & ALWAYS_ON) {
+		/* If ALWAYS_ON GDSCs are not ON, turn them ON */
+		gdsc_enable(&sc->pd);
+		on = true;
+	}
+
+	if (on || (sc->pwrsts & PWRSTS_RET))
+		gdsc_force_mem_on(sc);
+	else
+		gdsc_clear_mem_on(sc);
+
+	if (sc->flags & ALWAYS_ON)
+		sc->pd.flags |= GENPD_FLAG_ALWAYS_ON;
+	if (!sc->pd.power_off)
+		sc->pd.power_off = gdsc_disable;
+	if (!sc->pd.power_on)
+		sc->pd.power_on = gdsc_enable;
+	if (sc->flags & HW_CTRL_TRIGGER) {
+		sc->pd.set_hwmode_dev = gdsc_set_hwmode;
+		sc->pd.get_hwmode_dev = gdsc_get_hwmode;
+	}
+
+	ret = pm_genpd_init(&sc->pd, NULL, !on);
+	if (ret)
+		goto err_disable_supply;
+
+	return 0;
+
+err_disable_supply:
+	if (on && sc->rsupply)
+		regulator_disable(sc->rsupply);
+
+	return ret;
+}
+
+static int gdsc_add_subdomain_list(struct dev_pm_domain_list *pd_list,
+				   struct generic_pm_domain *subdomain)
+{
+	int i, ret;
+
+	for (i = 0; i < pd_list->num_pds; i++) {
+		struct device *dev = pd_list->pd_devs[i];
+		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+
+		ret = pm_genpd_add_subdomain(genpd, subdomain);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void gdsc_remove_subdomain_list(struct dev_pm_domain_list *pd_list,
+				       struct generic_pm_domain *subdomain)
+{
+	int i;
+
+	for (i = 0; i < pd_list->num_pds; i++) {
+		struct device *dev = pd_list->pd_devs[i];
+		struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
+
+		pm_genpd_remove_subdomain(genpd, subdomain);
+	}
+}
+
+static void gdsc_pm_subdomain_remove(struct gdsc_desc *desc, size_t num)
+{
+	struct device *dev = desc->dev;
+	struct gdsc **scs = desc->scs;
+	int i;
+
+	/* Remove subdomains */
+	for (i = num - 1; i >= 0; i--) {
+		if (!scs[i])
+			continue;
+		if (scs[i]->parent)
+			pm_genpd_remove_subdomain(scs[i]->parent, &scs[i]->pd);
+		else if (!IS_ERR_OR_NULL(dev->pm_domain))
+			pm_genpd_remove_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		else if (desc->pd_list)
+			gdsc_remove_subdomain_list(desc->pd_list, &scs[i]->pd);
+	}
+}
+
+int gdsc_register(struct gdsc_desc *desc,
+		  struct reset_controller_dev *rcdev, struct regmap *regmap)
+{
+	int i, ret;
+	struct genpd_onecell_data *data;
+	struct device *dev = desc->dev;
+	struct gdsc **scs = desc->scs;
+	size_t num = desc->num;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->domains = devm_kcalloc(dev, num, sizeof(*data->domains),
+				     GFP_KERNEL);
+	if (!data->domains)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		if (!scs[i] || !scs[i]->supply)
+			continue;
+
+		scs[i]->rsupply = devm_regulator_get_optional(dev, scs[i]->supply);
+		if (IS_ERR(scs[i]->rsupply)) {
+			ret = PTR_ERR(scs[i]->rsupply);
+			if (ret != -ENODEV)
+				return ret;
+
+			scs[i]->rsupply = NULL;
+		}
+	}
+
+	data->num_domains = num;
+	for (i = 0; i < num; i++) {
+		if (!scs[i])
+			continue;
+		scs[i]->regmap = regmap;
+		scs[i]->rcdev = rcdev;
+		ret = gdsc_init(scs[i]);
+		if (ret)
+			return ret;
+		data->domains[i] = &scs[i]->pd;
+	}
+
+	/* Add subdomains */
+	for (i = 0; i < num; i++) {
+		if (!scs[i])
+			continue;
+		if (scs[i]->parent)
+			ret = pm_genpd_add_subdomain(scs[i]->parent, &scs[i]->pd);
+		else if (!IS_ERR_OR_NULL(dev->pm_domain))
+			ret = pm_genpd_add_subdomain(pd_to_genpd(dev->pm_domain), &scs[i]->pd);
+		else if (desc->pd_list)
+			ret = gdsc_add_subdomain_list(desc->pd_list, &scs[i]->pd);
+
+		if (ret)
+			goto err_pm_subdomain_remove;
+	}
+
+	return of_genpd_add_provider_onecell(dev->of_node, data);
+
+err_pm_subdomain_remove:
+	gdsc_pm_subdomain_remove(desc, i);
+
+	return ret;
+}
+
+void gdsc_unregister(struct gdsc_desc *desc)
+{
+	struct device *dev = desc->dev;
+	size_t num = desc->num;
+
+	gdsc_pm_subdomain_remove(desc, num);
+	of_genpd_del_provider(dev->of_node);
+}
+
+/*
+ * On SDM845+ the GPU GX domain is *almost* entirely controlled by the GMU
+ * running in the CX domain so the CPU doesn't need to know anything about the
+ * GX domain EXCEPT....
+ *
+ * Hardware constraints dictate that the GX be powered down before the CX. If
+ * the GMU crashes it could leave the GX on. In order to successfully bring back
+ * the device the CPU needs to disable the GX headswitch. There being no sane
+ * way to reach in and touch that register from deep inside the GPU driver we
+ * need to set up the infrastructure to be able to ensure that the GPU can
+ * ensure that the GX is off during this super special case. We do this by
+ * defining a GX gdsc with a dummy enable function and a "default" disable
+ * function.
+ *
+ * This allows us to attach with genpd_dev_pm_attach_by_name() in the GPU
+ * driver. During power up, nothing will happen from the CPU (and the GMU will
+ * power up normally but during power down this will ensure that the GX domain
+ * is *really* off - this gives us a semi standard way of doing what we need.
+ */
+int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain)
+{
+	struct gdsc *sc = domain_to_gdsc(domain);
+	int ret = 0;
+
+	/* Enable the parent supply, when controlled through the regulator framework. */
+	if (sc->rsupply)
+		ret = regulator_enable(sc->rsupply);
+
+	/* Do nothing with the GDSC itself */
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gdsc_gx_do_nothing_enable);
diff --git a/drivers/clk/qcom/ccf/gdsc.h b/drivers/clk/qcom/ccf/gdsc.h
new file mode 100644
index 000000000000..dd843e86c05b
--- /dev/null
+++ b/drivers/clk/qcom/ccf/gdsc.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2015, 2017-2018, 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __QCOM_GDSC_H__
+#define __QCOM_GDSC_H__
+
+#include <linux/err.h>
+#include <linux/pm_domain.h>
+
+struct regmap;
+struct regulator;
+struct reset_controller_dev;
+
+/**
+ * struct gdsc - Globally Distributed Switch Controller
+ * @pd: generic power domain
+ * @regmap: regmap for MMIO accesses
+ * @gdscr: gsdc control register
+ * @collapse_ctrl: APCS collapse-vote register
+ * @collapse_mask: APCS collapse-vote mask
+ * @gds_hw_ctrl: gds_hw_ctrl register
+ * @cxcs: offsets of branch registers to toggle mem/periph bits in
+ * @cxc_count: number of @cxcs
+ * @pwrsts: Possible powerdomain power states
+ * @en_rest_wait_val: transition delay value for receiving enr ack signal
+ * @en_few_wait_val: transition delay value for receiving enf ack signal
+ * @clk_dis_wait_val: transition delay value for halting clock
+ * @resets: ids of resets associated with this gdsc
+ * @reset_count: number of @resets
+ * @rcdev: reset controller
+ */
+struct gdsc {
+	struct generic_pm_domain	pd;
+	struct generic_pm_domain	*parent;
+	struct regmap			*regmap;
+	unsigned int			gdscr;
+	unsigned int			collapse_ctrl;
+	unsigned int			collapse_mask;
+	unsigned int			gds_hw_ctrl;
+	unsigned int			clamp_io_ctrl;
+	unsigned int			*cxcs;
+	unsigned int			cxc_count;
+	unsigned int			en_rest_wait_val;
+	unsigned int			en_few_wait_val;
+	unsigned int			clk_dis_wait_val;
+	const u8			pwrsts;
+/* Powerdomain allowable state bitfields */
+#define PWRSTS_OFF		BIT(0)
+/*
+ * There is no SW control to transition a GDSC into
+ * PWRSTS_RET. This happens in HW when the parent
+ * domain goes down to a low power state
+ */
+#define PWRSTS_RET		BIT(1)
+#define PWRSTS_ON		BIT(2)
+#define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
+#define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
+	const u16			flags;
+#define VOTABLE		BIT(0)
+#define CLAMP_IO	BIT(1)
+#define HW_CTRL		BIT(2)
+#define SW_RESET	BIT(3)
+#define AON_RESET	BIT(4)
+#define POLL_CFG_GDSCR	BIT(5)
+#define ALWAYS_ON	BIT(6)
+#define RETAIN_FF_ENABLE	BIT(7)
+#define NO_RET_PERIPH	BIT(8)
+#define HW_CTRL_TRIGGER	BIT(9)
+	struct reset_controller_dev	*rcdev;
+	unsigned int			*resets;
+	unsigned int			reset_count;
+
+	const char 			*supply;
+	struct regulator		*rsupply;
+};
+
+struct gdsc_desc {
+	struct device *dev;
+	struct gdsc **scs;
+	size_t num;
+	struct dev_pm_domain_list *pd_list;
+};
+
+#ifdef CONFIG_QCOM_GDSC
+int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
+		  struct regmap *);
+void gdsc_unregister(struct gdsc_desc *desc);
+int gdsc_gx_do_nothing_enable(struct generic_pm_domain *domain);
+#else
+static inline int gdsc_register(struct gdsc_desc *desc,
+				struct reset_controller_dev *rcdev,
+				struct regmap *r)
+{
+	return -ENOSYS;
+}
+
+static inline void gdsc_unregister(struct gdsc_desc *desc) {};
+#endif /* CONFIG_QCOM_GDSC */
+#endif /* __QCOM_GDSC_H__ */
diff --git a/drivers/clk/qcom/ccf/reset.c b/drivers/clk/qcom/ccf/reset.c
new file mode 100644
index 000000000000..d96c96a9089f
--- /dev/null
+++ b/drivers/clk/qcom/ccf/reset.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/delay.h>
+
+#include "reset.h"
+
+static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
+
+	rcdev->ops->assert(rcdev, id);
+	fsleep(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
+
+	rcdev->ops->deassert(rcdev, id);
+	return 0;
+}
+
+static int qcom_reset_set_assert(struct reset_controller_dev *rcdev,
+				 unsigned long id, bool assert)
+{
+	struct qcom_reset_controller *rst;
+	const struct qcom_reset_map *map;
+	u32 mask;
+
+	rst = to_qcom_reset_controller(rcdev);
+	map = &rst->reset_map[id];
+	mask = map->bitmask ? map->bitmask : BIT(map->bit);
+
+	regmap_update_bits(rst->regmap, map->reg, mask, assert ? mask : 0);
+
+	/* Read back the register to ensure write completion, ignore the value */
+	regmap_read(rst->regmap, map->reg, &mask);
+
+	return 0;
+}
+
+static int qcom_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return qcom_reset_set_assert(rcdev, id, true);
+}
+
+static int qcom_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
+{
+	return qcom_reset_set_assert(rcdev, id, false);
+}
+
+const struct reset_control_ops qcom_reset_ops = {
+	.reset = qcom_reset,
+	.assert = qcom_reset_assert,
+	.deassert = qcom_reset_deassert,
+};
+EXPORT_SYMBOL_GPL(qcom_reset_ops);
diff --git a/drivers/clk/qcom/ccf/reset.h b/drivers/clk/qcom/ccf/reset.h
new file mode 100644
index 000000000000..fe0561bf53d4
--- /dev/null
+++ b/drivers/clk/qcom/ccf/reset.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2013, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __QCOM_CLK_RESET_H__
+#define __QCOM_CLK_RESET_H__
+
+#include <linux/reset-controller.h>
+
+struct qcom_reset_map {
+	unsigned int reg;
+	u8 bit;
+	u16 udelay;
+	u32 bitmask;
+};
+
+struct regmap;
+
+struct qcom_reset_controller {
+	const struct qcom_reset_map *reset_map;
+	struct regmap *regmap;
+	struct reset_controller_dev rcdev;
+};
+
+#define to_qcom_reset_controller(r) \
+	container_of(r, struct qcom_reset_controller, rcdev);
+
+extern const struct reset_control_ops qcom_reset_ops;
+
+#endif

-- 
2.51.0

