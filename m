Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94707C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1664F830AF;
	Mon, 14 Jul 2025 15:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vXARV9wk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F7A683082; Mon, 14 Jul 2025 15:13:25 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D7E682F49
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3146677f8f.0
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 06:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752498803; x=1753103603; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jaRBQ3/jalK+RGxCqkHNMC3YoBepd5/a31wxJ68xZLM=;
 b=vXARV9wk2Vsvpuh4W/6rZaBZO1ri/bS8g4ykZp2fo2QbSXooVcWaRxHEcEuSt7JASA
 UQuJpjDUCcjB75OIxu/c6zg1HKOjm85PiyWI2C6cAl+FxfGPq5u3ld3IbC6ll/z7bCjy
 guVi95ErygzUAvc0bt4/utlTOgw0ysZv8bIoYRe9cKeI0cyNiTAs2I2Ze5cgP3bpeZB5
 0lDNuWZfbx+tUUw62IHTBVsai10dw0L/ZF+bLR4Qud07XjVzoIEGDcbE4bDtJTrtm3nH
 nRFuaX2Ao1jFg2w7pG0iJJgdbfAN0eubeIMx31vJa4BeN4TVAuZy2nJqWIBmbfUgRrp0
 Skgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752498803; x=1753103603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaRBQ3/jalK+RGxCqkHNMC3YoBepd5/a31wxJ68xZLM=;
 b=p5NckkGyfvOnX8+0RDcTPytSkdKWOHfV5xzJlWYAi+AYB7DSy31Ti8tHFslsOwT/De
 fHjbXkwJMjbcbxjF1Oc5dxEGOUgIhVXVW9kPNrAZbg7KOY/LxOmdpqLgyIX01O7kizM0
 M13EzZyjl3WSO0g87/qd+Bwn41eBucnZDhC3V11mHDCyDq3OJRjATAjE0mWizKKY64UQ
 8kDiWkjj7v2Yqn6X+jAEj4j6eGGW1QrMuSzay9WQRivUChXRNk/zlCB0cAL9YmjOdTi+
 /LBKFVaTOXGMXHT2SjQDGLdF5i79F/EtXls7df28vb6Y4/h1vuuiINLPMbgdZVPC/DgV
 paEA==
X-Gm-Message-State: AOJu0Yzh4UAsV3qDlBCIavr1EWoLSLTkpsdQ3fJGPVa+pWANBdQWOnzF
 FtQCgegq95Lni/I1BLWtJhuKnuvoc4GP+eF+gGhBIMGefat2qY5meu4wo4OXfB/grRo=
X-Gm-Gg: ASbGnctNXHokAPjzD0FI4RqRzsB+F26hQA1DenQglVT5OQmE7EdFcxzO/djIZvkhDeB
 8fTD0wdsw455EME11zTblkVC3bmgR1gnPDif4fQEPPMaDrC4scxOVSUM1GYbX6rXd2G0RNOBJty
 xdZT2dSHI3W97zg5xOIH7dUxzvYRkllPfN2amq10O0hFsEyK+C+NTSdMJZfJBYt5VHmO5eUJUu7
 V7PFfeNzVNnzvdWCAwpuN7yMpXJb7YcMgntaxOnYPZg1gTPxc3dhtIsF8dILmzo6JfW5G2Fz9p8
 eXQK+LyFigW50BN70stoAQr8FNgrMJOYB2Gz7NH4QADby0twjyaD4tJterEe2dBYPBw+5wYPysY
 RbjtIRt3Fb4OVgHQRFJ1laVCwPVy5ROe64q1Gfks2ai18jaGDo6DcgHewMAHvAq0U7EFI7w==
X-Google-Smtp-Source: AGHT+IGJ/b9c5NqvpaIqDkCSKYZZG9Uwyc84mnz/6c8hYCTVcQELP8CpDuzdTbjftGKzMWnf10+r+w==
X-Received: by 2002:a05:6000:1888:b0:3a5:298a:3214 with SMTP id
 ffacd0b85a97d-3b5f1e86bf9mr9662064f8f.13.1752498802620; 
 Mon, 14 Jul 2025 06:13:22 -0700 (PDT)
Received: from toyger.localdomain (p549d4699.dip0.t-ipconnect.de.
 [84.157.70.153]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9298sm12361010f8f.44.2025.07.14.06.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 06:13:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 14 Jul 2025 15:13:16 +0200
Subject: [PATCH v5 5/8] clk/qcom: sc7280: add uart5 and uart7 clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-geni-load-fw-v5-5-5abbc0d29838@linaro.org>
References: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
In-Reply-To: <20250714-geni-load-fw-v5-0-5abbc0d29838@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3205;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=33ddvSQZ+PWj/UnAV5z6/wrIc3JlyKDT7gOkDt+5OwA=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBodQJqgxLEUNJELVHqZ4v+UCQLMFtAzdoejvqy/
 v9WN0lvb8OJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaHUCagAKCRAFgzErGV9k
 tkSJD/9dQ0XzmNY/uHy+cQL+jZ2qjlErZvZXXVKkXBrH7RnFj5cppA4r+FATqaIrCI3eQELvWBE
 Y4XM/EpTpVIUl0W5y+z1hznQjM+a1txc+H0yGn33Qlww+Pihhn6GS249mvfH77x0HUc9j2iiSRe
 lfWtvOkVdpM7h8kUKJrtWw90ShUBrtUjCJIMuS1m4qMlV4cbUjTExvTvbcyxpV0jdMXIUK7VViG
 RYjiT8wgqLTkKk1AWncMMsvQh8VRODcbqXf1/0br4zK2qDH4xkN4OfTrpyDOGch4Mf7QH/f/L4g
 CcgUaHF8ciD4Dj7/6GPRyeQGavMEkmRJCIvjZSIOCDWoj3WvSUt/SaNmfpOpzOhZV4k8Que6Jx8
 lNuWqzEz0qpcvEopzpaaFvCsa0cEJhYW+1jrYn5G9DFFgIGAWRIrr5TKrqIIKGTJFdjkjQIEbPO
 f3MQqbgG7/3oQ6AO3CMaXM7PsgNiJqAmJqUfcHBjVdIvuqqIJ8kibNbS6Xs29CgiAd1a9+ZfQ8l
 5x+RkY3o4HvVU6fo+LAOi0epqWJ2EDggLqsSwCpAZnkc347SIeJHgknFnNxQcjUwQTHJACJqbg5
 QZ9EMbpXy93Am/JDRgPJM/EgfLYh3mcLx149U44XHGSyZYnhnn/NcD9D3thYpitbJ564W2f1KPt
 cki+XxeFl2HXoXw==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Allow us to power up UART7 so we can load the QUP firmware, this is used
for bluetooth on RB3 Gen 2 and possibly other boards.

Additionally add the UART5 clocks so we can adjust baud rate for UART

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sc7280.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
index 47e0ca5f0e5ce37b8c0f78f3be32ab9c519e471f..55a233df39450e511aebf7892214967c284a603e 100644
--- a/drivers/clk/qcom/clock-sc7280.c
+++ b/drivers/clk/qcom/clock-sc7280.c
@@ -37,8 +37,24 @@ static const struct freq_tbl ftbl_gcc_usb30_sec_master_clk_src[] = {
 	F(120000000, CFG_CLK_SRC_GPLL0_EVEN, 2.5, 0, 0),
 	{ }
 };
 
+static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s2_clk_src[] = {
+	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
+	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
+	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
+	F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
+	F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
+	F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
+	F(52174000, CFG_CLK_SRC_GPLL0, 1, 2, 23),
+	F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
+	F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
+	F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
+	F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
+	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
+	{ }
+};
+
 static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 {
 	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
 	const struct freq_tbl *freq;
@@ -46,8 +62,18 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
 	if (clk->id < priv->data->num_clks)
 		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
 
 	switch (clk->id) {
+	case GCC_QUPV3_WRAP0_S5_CLK: /* UART5 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x17600,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
+	case GCC_QUPV3_WRAP0_S7_CLK: /* UART7 */
+		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
+		clk_rcg_set_rate_mnd(priv->base, 0x17860,
+				     freq->pre_div, freq->m, freq->n, freq->src, 16);
+		return freq->freq;
 	case GCC_USB30_PRIM_MASTER_CLK:
 		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
 		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
@@ -106,8 +132,10 @@ static const struct gate_clk sc7280_clks[] = {
 	GATE_CLK(GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK, 0x52008, BIT(28)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
 	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, BIT(15)),
+	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x52008, BIT(17)),
 	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
 	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
 	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),

-- 
2.50.0

