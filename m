Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90ACCAC5B0
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 12:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E918382E;
	Fri,  3 Oct 2025 14:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="KwrSqr7n";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="zOmTC3Q5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F8F836B4; Fri,  3 Oct 2025 12:04:44 +0200 (CEST)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702048366F
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 12:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=david.wronek@mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485671; bh=LN1AXF768lrQcVEMtqwfZVY
 OJo/in3WS6H76f9GvCc0=; b=KwrSqr7nU5Vlteabdchkfu1iiNr3A3twdvDTGGHmgZvoNehByw
 fzBIAHn618yVW+sxCDUcWWuyiE6xkrIDnRyA7QJ0/NxRn9mOU9gZzYV6u7yyADbIAN227gdTWck
 EzyTC4UlPmPYrOBFNEsLdpbXAFHS7M0xFYXUHI+4ieZBAMJoccZHKcbJbheaymrsK72Zz4tXmd9
 dYQwHubjjga1/uu+85D29SXyX+I6yq4vszciBi1Fn9bhhGchUzDoi9+uEkjDtfE380aFFuEgHmY
 Gbr540SXAnTHF+gJff4hGmoENLve/g2oyPFRyuWezqAPT7RQG1qbv3ip+ciLibMMOTQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1759485671; bh=LN1AXF768lrQcVEMtqwfZVY
 OJo/in3WS6H76f9GvCc0=; b=zOmTC3Q5dY8jYSIN1r84ve4wh0HFMOfW63sUjpjggdwCj+26Ww
 VqmSC6ZWCjPeueZKJJu+dfh00iWdAlYbP2BA==;
From: David Wronek <david.wronek@mainlining.org>
Date: Fri, 03 Oct 2025 12:01:10 +0200
Subject: [PATCH v2 2/5] clk/qcom: sdm845: add support for sdm670
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-sdm670-v2-2-52c0fa481286@mainlining.org>
References: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
In-Reply-To: <20251003-sdm670-v2-0-52c0fa481286@mainlining.org>
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 David Wronek <david.wronek@mainlining.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759485669; l=7944;
 i=david.wronek@mainlining.org; s=20250914; h=from:subject:message-id;
 bh=82SqQeEJH+Pk8SO04V+GaqVpXVJ5S2NWB1Uo3Z6w0WM=;
 b=eoBdcD5pNdZPH4QyieRsgFO3NO/9eMy1KFKaDfPWV4qsPJdtKZnex+k8c+kYvqTwlYivOGc3E
 w2mLymVt49FCZweyW5lSLD9Bq8S5V204k8xDAxiT676M2FeF342yF2e
X-Developer-Key: i=david.wronek@mainlining.org; a=ed25519;
 pk=NtKhS1PfXjRIaJwWcYTu7JS0cX3GEmccZo+a6erVTfU=
X-Mailman-Approved-At: Fri, 03 Oct 2025 14:48:13 +0200
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

The global clock controller on SDM670 is similar to SDM845, so let's add
support here.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Wronek <david.wronek@mainlining.org>
---
 drivers/clk/qcom/clock-sdm845.c | 127 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index 5c8702ef2fe..c9a057cf6f9 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -23,6 +23,7 @@
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf018
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf030
 #define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf05c
+#define SDCC1_APPS_CLK_CMD_RCGR 0x26028
 #define SDCC2_APPS_CLK_CMD_RCGR 0x1400c
 
 static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
@@ -44,6 +45,18 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
 	{ }
 };
 
+static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
+	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
+	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
+	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
+	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 1, 2),
+	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	F(192000000, CFG_CLK_SRC_GPLL6, 2, 0, 0),
+	F(384000000, CFG_CLK_SRC_GPLL6, 1, 0, 0),
+	{ }
+};
+
 static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
 	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
@@ -55,6 +68,22 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
 	{ }
 };
 
+static ulong sdm670_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+	const struct freq_tbl *freq;
+
+	switch (clk->id) {
+	case GCC_SDCC1_APPS_CLK:
+		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
+				     freq->pre_div, freq->m, freq->n, freq->src, 8);
+		return freq->freq;
+	default:
+		return 0;
+	}
+}
+
 static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -76,6 +105,54 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
 	}
 }
 
+static const struct gate_clk sdm670_clks[] = {
+	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x8201c, 0x00000001),
+	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x0502c, 0x00000001),
+	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
+	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
+	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,		0x5200c, 0x00001000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,		0x5200c, 0x00002000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK,		0x5200c, 0x00004000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,		0x5200c, 0x00008000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK,		0x5200c, 0x00010000),
+	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK,		0x5200c, 0x00020000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,		0x5200c, 0x00400000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,		0x5200c, 0x00800000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,		0x5200c, 0x02000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,		0x5200c, 0x04000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,		0x5200c, 0x08000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK,		0x5200c, 0x10000000),
+	GATE_CLK(GCC_QUPV3_WRAP1_S7_CLK,		0x5200c, 0x20000000),
+	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,		0x5200c, 0x00000040),
+	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,		0x5200c, 0x00000080),
+	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,		0x5200c, 0x00100000),
+	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,		0x5200c, 0x00200000),
+	GATE_CLK(GCC_SDCC1_AHB_CLK,			0x26008, 0x00000001),
+	GATE_CLK(GCC_SDCC1_APPS_CLK,			0x26004, 0x00000001),
+	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,		0x2600c, 0x00000001),
+	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14008, 0x00000001),
+	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, 0x00000001),
+	GATE_CLK(GCC_SDCC4_AHB_CLK,			0x16008, 0x00000001),
+	GATE_CLK(GCC_SDCC4_APPS_CLK,			0x16004, 0x00000001),
+	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,		0x8c000, 0x00000001),
+	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x82024, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77010, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x7700c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x77058, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x7708c, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x77018, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77014, 0x00000001),
+	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77054, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x0f00c, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x0f014, 0x00000001),
+	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x0f010, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK,		0x8c008, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x0f04c, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x0f050, 0x00000001),
+	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x0f054, 0x00000001),
+	GATE_CLK(GCC_USB_PHY_CFG_AHB2PHY_CLK,		0x6a004, 0x00000001),
+};
+
 static const struct gate_clk sdm845_clks[] = {
 	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x8201c, 0x00000001),
 	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,		0x82020, 0x00000001),
@@ -140,6 +217,28 @@ static const struct gate_clk sdm845_clks[] = {
 	GATE_CLK(GCC_USB_PHY_CFG_AHB2PHY_CLK,		0x6a004, 0x00000001),
 };
 
+static int sdm670_clk_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	debug("%s: clk %s\n", __func__, sdm670_clks[clk->id].name);
+
+	switch (clk->id) {
+	case GCC_USB30_PRIM_MASTER_CLK:
+		qcom_gate_clk_en(priv, GCC_USB_PHY_CFG_AHB2PHY_CLK);
+		/* These numbers are just pulled from the frequency tables in the Linux driver */
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
+				     (4.5 * 2) - 1, 0, 0, 1 << 8, 8);
+		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
+				     1, 0, 0, 0, 8);
+		clk_rcg_set_rate_mnd(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR,
+				     1, 0, 0, 0, 8);
+		break;
+	}
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
 static int sdm845_clk_enable(struct clk *clk)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
@@ -188,6 +287,17 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
 };
 
+static const struct qcom_power_map sdm670_gdscs[] = {
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[USB30_PRIM_GDSC] = { 0xf004 },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030 },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034 },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
+};
+
 static const struct qcom_power_map sdm845_gdscs[] = {
 	[PCIE_0_GDSC] = { 0x6b004 },
 	[PCIE_1_GDSC] = { 0x8d004 },
@@ -292,6 +402,19 @@ static const char *const sdm845_rcg_names[] = {
 	"GCC_UFS_PHY_PHY_AUX",
 };
 
+static struct msm_clk_data sdm670_clk_data = {
+	/* Snapdragon 670 can function without its own exclusive resets. */
+	.resets = sdm845_gcc_resets,
+	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
+	.clks = sdm670_clks,
+	.num_clks = ARRAY_SIZE(sdm670_clks),
+	.power_domains = sdm670_gdscs,
+	.num_power_domains = ARRAY_SIZE(sdm670_gdscs),
+
+	.enable = sdm670_clk_enable,
+	.set_rate = sdm670_clk_set_rate,
+};
+
 static struct msm_clk_data sdm845_clk_data = {
 	.resets = sdm845_gcc_resets,
 	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
@@ -310,6 +433,10 @@ static struct msm_clk_data sdm845_clk_data = {
 };
 
 static const struct udevice_id gcc_sdm845_of_match[] = {
+	{
+		.compatible = "qcom,gcc-sdm670",
+		.data = (ulong)&sdm670_clk_data,
+	},
 	{
 		.compatible = "qcom,gcc-sdm845",
 		.data = (ulong)&sdm845_clk_data,

-- 
2.51.0

