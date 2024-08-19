Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4541AC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 19:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B45788D17;
	Mon, 19 Aug 2024 21:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GjFdB8t5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A7F88D31; Mon, 19 Aug 2024 21:34:28 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC10288D25
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 21:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7b2dbd81e3so653032066b.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 12:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724096065; x=1724700865; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AcrKyzxsUO1H1BaVXpa9GAvBUcaNW0SBlGn7eZJZXgU=;
 b=GjFdB8t5t7C8BQ4Wi6skZEpThsotZh2eqTh4ZdyI+DW/Pax9aR/XD7u5uNye1Een+V
 VdRPqWud2+q5TfO0BTgtW2ubWW6dPhkfIql7psIah2omp3FuqKxKneiUMPFqXWK/2uwt
 2mLct0WVTx/e90dPjvsIdebkQ0oZH+MeDYBue/IpHH3BATwIdYysYhqq8+qUrWFg2xnz
 fQn4Ozzzsc+W3oqXHtJcS4RF2cFwVbtPL7MLoccWhWEHA+cEckF7H+2NDhP1cckxOvtH
 0o1ylbojO0KvqGG61O3mKiKUIegwLj6FWefMJPkrnNJ1a9KHQP6DtnjkoO8iVoAP4ljH
 tP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724096065; x=1724700865;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcrKyzxsUO1H1BaVXpa9GAvBUcaNW0SBlGn7eZJZXgU=;
 b=BusaVi9wsmOcOBytDUAYiXQoJv736a0m2odAZ7WeF+lYWiTWPa3ncf2jtcdn6ZfHrr
 VtEv8fP/wgggvTDAg0gAfIF2eW+Uvea8lu1UdRFQG2zSKc/tQ2JbhG+IwYKRcZTWhiw+
 Rcs8Gg6OMnTh66oFTL1gmiE5V0QR9Qo936O6uCmrABWKabYapapI6GV7ldo1Yyz6Sj7I
 fZi2/7jzyFgpGtoF6ivvGlKh+1c40shS5oe/aHWbuLRYvo0yQraY/AY0Oms7ABSG5wHk
 Kp1UFdYeBG8am3OnBPvdYOpm8wSIQTpWin6gJtHaOSZsWT/MQWvGEh+SIxBho3bT3hVN
 zS8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzpj6sRPhIxmr/oSyTutOu3WRAg8lyyJ31iCYpsKFWivJewHHXhjlSF+F0gZiix1mvGydEMqI=@lists.denx.de
X-Gm-Message-State: AOJu0YwoMGW7sb+mg2dbR1jRyWCNEBbcrEwNcftgiwxanqkNYsaDBbDS
 hx3jkjQQChsuJ+zn2gDsswn8bREe11+n3Mh2dGhFGXr0RLJo4xTkeQ8eTBWibns=
X-Google-Smtp-Source: AGHT+IHk1a0Cg8oJnPjWtcmhsNGkPH9yeTrU4H7J/LBS9VeG4QCSlFZMvJLKgYHf+qVCl6papLQ8og==
X-Received: by 2002:a17:907:7d9f:b0:a80:f6a9:c311 with SMTP id
 a640c23a62f3a-a839256bc37mr857047666b.0.1724096065229; 
 Mon, 19 Aug 2024 12:34:25 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383964976sm667783666b.188.2024.08.19.12.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 12:34:24 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 19 Aug 2024 21:34:19 +0200
Subject: [PATCH 3/4] clk/qcom: sm6115: add debug data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-b4-qcom-clk-dump-v1-3-182cf77c23a2@linaro.org>
References: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
In-Reply-To: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3234;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SlA311QwZtYmqz+dEDAxfHciQntHSwnUxGtFdmo2DAs=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmw548FTL3u0kVXaOwR+o17nbxQYM44mXF5Rlgx
 vWuoHFeGaqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsOePAAKCRAFgzErGV9k
 trv9D/4/EGg7jIawJo35Z3kDsljZ/XRdxoFDfM5T6Vsn5OVKAz/XqmyvMl8QllesH125LUyXgsj
 FfY5p3A2Yw3RvK3xbGBnLU2y6M5yzWC2wfCiLLVUk8kF6Mz2iLPQWldINxxqiFaRiKf7Y//n0fU
 OnqlkrX1GA81jIsAYl2dCm5/UreyEmGCu7DWvVfNCb+TbG+wG8ZtPA6ei28E638VE5NSsfJFj8I
 4bwhPoDTmDRo4GRG+9frexCY53rc0M7d1Su2H3Y6vTXUQZeoxL2WvGnKneRqMVbw6S/SOd6bh85
 3ERgM8OCnRPfsGxahoqvAXHXOfd/7ZrKyclqAUDdRTOkfdUiLeeQIGQHYeexmRYJJmSmMRJDvuK
 O+K8BVd0nbRIvHddmsP7rLT+x1urWjvLqSQzIzWLNshdbCYJmyS1Cf59nJ7JUqLodkj8pyBR9gT
 MNREsRkm5gcTbych0ooIz8ARfDjs5SO6mx0gVKUBL8R3dfUF7yg7F7VeZzi6Cm6aMtUDlGsH/mE
 qZ0RKNNwKwTEm4c6mCcvgiLzVg90EtIDXEQRKmMp3xaJ03yYdR2rynnfvdNFVYhE3zvbTpZLNjc
 1S48vwYqZp6GxW8OEwJpYucdfhTayS7pF1Mv2FFc27RGsa8fwqGdsGbE+D3leitGYbDSxFqstzV
 QKbO+afL/QNekAw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

Add "clk dump" support for SM6115.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sm6115.c | 63 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/clk/qcom/clock-sm6115.c b/drivers/clk/qcom/clock-sm6115.c
index 8314a0deb348..9057dfe0bb18 100644
--- a/drivers/clk/qcom/clock-sm6115.c
+++ b/drivers/clk/qcom/clock-sm6115.c
@@ -169,8 +169,65 @@ static const struct qcom_reset_map sm6115_gcc_resets[] = {
 static const struct qcom_power_map sm6115_gdscs[] = {
 	[GCC_USB30_PRIM_GDSC] = { 0x1a004 },
 };
 
+static const phys_addr_t sm6115_gpll_addrs[] = {
+	0x01400000, // GCC_GPLL0_MODE
+	0x01401000, // GCC_GPLL1_MODE
+	0x01402000, // GCC_GPLL2_MODE
+	0x01403000, // GCC_GPLL3_MODE
+	0x01404000, // GCC_GPLL4_MODE
+	0x01405000, // GCC_GPLL5_MODE
+	0x01406000, // GCC_GPLL6_MODE
+	0x01407000, // GCC_GPLL7_MODE
+	0x01408000, // GCC_GPLL8_MODE
+	0x01409000, // GCC_GPLL9_MODE
+	0x0140a000, // GCC_GPLL10_MODE
+	0x0140b000, // GCC_GPLL11_MODE
+};
+
+static const phys_addr_t sm6115_rcg_addrs[] = {
+	0x0141a01c, // GCC_USB30_PRIM_MASTER_CMD_RCGR
+	0x0141a034, // GCC_USB30_PRIM_MOCK_UTMI_CMD_RCGR
+	0x0141a060, // GCC_USB3_PRIM_PHY_AUX_CMD_RCGR
+	0x01438028, // GCC_SDCC1_APPS_CMD_RCGR
+	0x0141e00c, // GCC_SDCC2_APPS_CMD_RCGR
+	0x0141f018, // GCC_QUPV3_WRAP0_CORE_2X_CMD_RCGR
+	0x0141f148, // GCC_QUPV3_WRAP0_S0_CMD_RCGR
+	0x0141f278, // GCC_QUPV3_WRAP0_S1_CMD_RCGR
+	0x0141f3a8, // GCC_QUPV3_WRAP0_S2_CMD_RCGR
+	0x0141f4d8, // GCC_QUPV3_WRAP0_S3_CMD_RCGR
+	0x0141f608, // GCC_QUPV3_WRAP0_S4_CMD_RCGR
+	0x0141f738, // GCC_QUPV3_WRAP0_S5_CMD_RCGR
+	0x01428014, // GCC_SLEEP_CMD_RCGR
+	0x0142802c, // GCC_XO_CMD_RCGR
+	0x01445020, // GCC_UFS_PHY_AXI_CMD_RCGR
+	0x01445048, // GCC_UFS_PHY_ICE_CORE_CMD_RCGR
+	0x01445060, // GCC_UFS_PHY_UNIPRO_CORE_CMD_RCGR
+	0x0144507c, // GCC_UFS_PHY_PHY_AUX_CMD_RCGR
+};
+
+static const char *const sm6115_rcg_names[] = {
+	"GCC_USB30_PRIM_MASTER_CMD_RCGR",
+	"GCC_USB30_PRIM_MOCK_UTMI_CMD_RCGR",
+	"GCC_USB3_PRIM_PHY_AUX_CMD_RCGR",
+	"GCC_SDCC1_APPS_CMD_RCGR",
+	"GCC_SDCC2_APPS_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_CORE_2X_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S0_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S1_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S2_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S3_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S4_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S5_CMD_RCGR",
+	"GCC_SLEEP_CMD_RCGR",
+	"GCC_XO_CMD_RCGR",
+	"GCC_UFS_PHY_AXI_CMD_RCGR",
+	"GCC_UFS_PHY_ICE_CORE_CMD_RCGR",
+	"GCC_UFS_PHY_UNIPRO_CORE_CMD_RCGR",
+	"GCC_UFS_PHY_PHY_AUX_CMD_RCGR",
+};
+
 static struct msm_clk_data sm6115_gcc_data = {
 	.resets = sm6115_gcc_resets,
 	.num_resets = ARRAY_SIZE(sm6115_gcc_resets),
 	.clks = sm6115_clks,
@@ -179,8 +236,14 @@ static struct msm_clk_data sm6115_gcc_data = {
 	.num_power_domains = ARRAY_SIZE(sm6115_gdscs),
 
 	.enable = sm6115_enable,
 	.set_rate = sm6115_set_rate,
+
+	.dbg_pll_addrs = sm6115_gpll_addrs,
+	.num_plls = ARRAY_SIZE(sm6115_gpll_addrs),
+	.dbg_rcg_addrs = sm6115_rcg_addrs,
+	.num_rcgs = ARRAY_SIZE(sm6115_rcg_addrs),
+	.dbg_rcg_names = sm6115_rcg_names,
 };
 
 static const struct udevice_id gcc_sm6115_of_match[] = {
 	{

-- 
2.46.0

