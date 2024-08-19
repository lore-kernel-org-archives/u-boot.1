Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6345EC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 19:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A944988D2D;
	Mon, 19 Aug 2024 21:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZutHQI3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A9588D17; Mon, 19 Aug 2024 21:34:27 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA2088D1F
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 21:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5becd359800so3592807a12.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724096064; x=1724700864; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GTr66mSU4Vru9Y1q5TaXUqjtPY4DyoBYunKN4yraEyo=;
 b=ZutHQI3yUQYF4kwDrFC6MIp8PJvT4/FSusi2P7r05122LIzqjzDMWod3VY0c6NYtht
 cg6tsuax1EIXMcTDAOKH9dML3nps+HFH/IJJTUV6NfD16Sks2pTFSw6hMvDVmHhKL0yb
 ywjeUIvmTpkm54vbAtmxWNelGWplbQK/92THDwo2bPGsDBXjgZysxC/x7ak9SxplR2fW
 KUoF7TR5tM12+2vHVFwTd/EwSQEFVuAcEgpvyWPFhM2XOPSFrJFzNufeORClnNm4j+Tb
 WJ/gKDZ3My538GmBqpWBtkUqBgjF9xZIQaJVsLdtQ4Tw6qoOfizBehW/guSsPRi3Sial
 fLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724096064; x=1724700864;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTr66mSU4Vru9Y1q5TaXUqjtPY4DyoBYunKN4yraEyo=;
 b=hvGfCsUHpB5H35zUXL8eidc0SBsGtYmimobFq3VtRTLRvV4XJoTQgyAw7HB8CnsPAQ
 azlw/lJ0grXMqkdRQgQQtTmej9KFEoa8VxnFMAm0fsja+pEIiffsOx3Nq2Aygvr1KXDo
 vvYFtQj24M6y/HCb42mhoNtouTKP4QkJFQX5zjJGLu3TEiWLuQgmD3mt1slsMr+pA9O+
 tmDiioZ0qmcVzknjOIKs7EnYFtoIRww5UOJX0TuswyokpPzQaWd9QSuXaRU6rQvrohTI
 fWjxQqZEGRoEKDv0Ma1pLAD/tRzr8QIoIsM38zq/ZTJpsBwegfWyrXiIjRbrNlDyOqDZ
 Lt+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3xRv+7d1YU143bzQP9Fw7t6DFnN08ZlMimc+SHykcyOf4Nh2uli64uveb+RDewzXd5xQZaBY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7CygYF9l/ZOySHndF3qqAbISIYlQKOx0pRY4/VlyMc3p29Z8Q
 zwlYzhlpyU9V3rEjdzkkBt7WzziGAajhPLT31psReozoZBvfcp4YwT4K1oF/h8g=
X-Google-Smtp-Source: AGHT+IE4Ran0SNXgWCDt3+9d2mU1GvdQGhlQrG9H9loQOav1589dqoc66AFS3IQvGILYmAkOmJvIxA==
X-Received: by 2002:a17:907:e665:b0:a7a:b9dd:7762 with SMTP id
 a640c23a62f3a-a8392a16e82mr858498866b.42.1724096064242; 
 Mon, 19 Aug 2024 12:34:24 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383964976sm667783666b.188.2024.08.19.12.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 12:34:23 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 19 Aug 2024 21:34:18 +0200
Subject: [PATCH 2/4] clk/qcom: sdm845: add dump data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-b4-qcom-clk-dump-v1-2-182cf77c23a2@linaro.org>
References: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
In-Reply-To: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3942;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=VBGTaoTLCP0hDeMcg8fJUKbNu/8Z9t1pUuSzLkeb4GE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmw548wW0qEmi3kxpZXHKO6w85I3awGApojpGFE
 EV462BhEmqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsOePAAKCRAFgzErGV9k
 tuiSD/4k8uMJGFJdlnGJKkyxuTzIyNqfA4Z+/GXaYFTczVb7Cry/C4G+TT7nyQ3qnMSC5G4K63E
 hlUTqxM+JfNwK71Up5noteQVWxfLNNjDYXejQpL3dtThDx8nWtTcmDYgu+sXWrY1t2tsKBU+PBx
 hsP1hzaXO6PcnE5f0dY7MLQdrVnQf0KRbiFfuZojLp4P9L0h0pTulhfjwhaYdnewOKad98i7/ml
 fh+jgWwYyTLyXZyu2jVLRWMdNLTpgOYUp8xrmpnUrZSXP2eyT2txPqcCc20/3j26n5QaGU5v3cA
 hV1OVWs7PmGI0pYSUEQVU21Tj7HTlFiCn2Iqm0wIkqrMMdLBHRBC7vazp+4eeJwgl9Fgu2uh7pb
 TDfOl1B84Iv5LQvf9jIFi0LLyE1tdOfsUQloPme756kstsLXfmNyGANZQ/RrQpTwDQBlSt+ozOc
 OzjvQs8zXFZHwM9kuKZCA/i1A/RDJfz2qbhmEhynZa/FLkbkxYOM1E/3llIBZhrkUrpp8mkw8L2
 Zhyi63PR1qosuUI/u0LF8WlMAFcNJnA6bSh3KYSjgIVUT8HmUE6FniBvUDy0R2W38yn23wnmgI5
 yP8o6JPQc1QyDM0TQUXwkKLOtRdbhIIe+FU0RuiKbpbAruJbkcUA23PEH/NWy8bVYSOvt2gB/ae
 qyhnZudm5yOiFLA==
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

Add debug data to dump PLL and RCG clocks.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sdm845.c | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index f41f8c9e8dee..adffb0cb2402 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -202,8 +202,96 @@ static const struct qcom_power_map sdm845_gdscs[] = {
 	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
 	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
 };
 
+static const phys_addr_t sdm845_gpll_addrs[] = {
+	0x00100000, // GCC_GPLL0_MODE
+	0x00101000, // GCC_GPLL1_MODE
+	0x00102000, // GCC_GPLL2_MODE
+	0x00103000, // GCC_GPLL3_MODE
+	0x00176000, // GCC_GPLL4_MODE
+	0x00174000, // GCC_GPLL5_MODE
+	0x00113000, // GCC_GPLL6_MODE
+};
+
+static const phys_addr_t sdm845_rcg_addrs[] = {
+	0x0010f018, // GCC_USB30_PRIM_MASTER
+	0x0010f030, // GCC_USB30_PRIM_MOCK_UTMI
+	0x0010f05c, // GCC_USB3_PRIM_PHY_AUX
+	0x00110018, // GCC_USB30_SEC_MASTER
+	0x00110030, // GCC_USB30_SEC_MOCK_UTMI
+	0x0011005c, // GCC_USB3_SEC_PHY_AUX
+	0x0011400c, // GCC_SDCC2_APPS
+	0x0011600c, // GCC_SDCC4_APPS
+	0x00117018, // GCC_QUPV3_WRAP0_CORE_2X
+	0x00117034, // GCC_QUPV3_WRAP0_S0
+	0x00117164, // GCC_QUPV3_WRAP0_S1
+	0x00117294, // GCC_QUPV3_WRAP0_S2
+	0x001173c4, // GCC_QUPV3_WRAP0_S3
+	0x001174f4, // GCC_QUPV3_WRAP0_S4
+	0x00117624, // GCC_QUPV3_WRAP0_S5
+	0x00117754, // GCC_QUPV3_WRAP0_S6
+	0x00117884, // GCC_QUPV3_WRAP0_S7
+	0x00118018, // GCC_QUPV3_WRAP1_S0
+	0x00118148, // GCC_QUPV3_WRAP1_S1
+	0x00118278, // GCC_QUPV3_WRAP1_S2
+	0x001183a8, // GCC_QUPV3_WRAP1_S3
+	0x001184d8, // GCC_QUPV3_WRAP1_S4
+	0x00118608, // GCC_QUPV3_WRAP1_S5
+	0x00118738, // GCC_QUPV3_WRAP1_S6
+	0x00118868, // GCC_QUPV3_WRAP1_S7
+	0x0016b028, // GCC_PCIE_0_AUX
+	0x0018d028, // GCC_PCIE_1_AUX
+	0x0016f014, // GCC_PCIE_PHY_REFGEN
+	0x0017501c, // GCC_UFS_CARD_AXI
+	0x0017505c, // GCC_UFS_CARD_ICE_CORE
+	0x00175074, // GCC_UFS_CARD_UNIPRO_CORE
+	0x00175090, // GCC_UFS_CARD_PHY_AUX
+	0x0017701c, // GCC_UFS_PHY_AXI
+	0x0017705c, // GCC_UFS_PHY_ICE_CORE
+	0x00177074, // GCC_UFS_PHY_UNIPRO_CORE
+	0x00177090, // GCC_UFS_PHY_PHY_AUX
+};
+
+static const char *const sdm845_rcg_names[] = {
+	"GCC_USB30_PRIM_MASTER",
+	"GCC_USB30_PRIM_MOCK_UTMI",
+	"GCC_USB3_PRIM_PHY_AUX",
+	"GCC_USB30_SEC_MASTER",
+	"GCC_USB30_SEC_MOCK_UTMI",
+	"GCC_USB3_SEC_PHY_AUX",
+	"GCC_SDCC2_APPS",
+	"GCC_SDCC4_APPS",
+	"GCC_QUPV3_WRAP0_CORE_2X",
+	"GCC_QUPV3_WRAP0_S0",
+	"GCC_QUPV3_WRAP0_S1",
+	"GCC_QUPV3_WRAP0_S2",
+	"GCC_QUPV3_WRAP0_S3",
+	"GCC_QUPV3_WRAP0_S4",
+	"GCC_QUPV3_WRAP0_S5",
+	"GCC_QUPV3_WRAP0_S6",
+	"GCC_QUPV3_WRAP0_S7",
+	"GCC_QUPV3_WRAP1_S0",
+	"GCC_QUPV3_WRAP1_S1",
+	"GCC_QUPV3_WRAP1_S2",
+	"GCC_QUPV3_WRAP1_S3",
+	"GCC_QUPV3_WRAP1_S4",
+	"GCC_QUPV3_WRAP1_S5",
+	"GCC_QUPV3_WRAP1_S6",
+	"GCC_QUPV3_WRAP1_S7",
+	"GCC_PCIE_0_AUX",
+	"GCC_PCIE_1_AUX",
+	"GCC_PCIE_PHY_REFGEN",
+	"GCC_UFS_CARD_AXI",
+	"GCC_UFS_CARD_ICE_CORE",
+	"GCC_UFS_CARD_UNIPRO_CORE",
+	"GCC_UFS_CARD_PHY_AUX",
+	"GCC_UFS_PHY_AXI",
+	"GCC_UFS_PHY_ICE_CORE",
+	"GCC_UFS_PHY_UNIPRO_CORE",
+	"GCC_UFS_PHY_PHY_AUX",
+};
+
 static struct msm_clk_data sdm845_clk_data = {
 	.resets = sdm845_gcc_resets,
 	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
 	.clks = sdm845_clks,
@@ -212,8 +300,13 @@ static struct msm_clk_data sdm845_clk_data = {
 	.num_power_domains = ARRAY_SIZE(sdm845_gdscs),
 
 	.enable = sdm845_clk_enable,
 	.set_rate = sdm845_clk_set_rate,
+	.dbg_pll_addrs = sdm845_gpll_addrs,
+	.num_plls = ARRAY_SIZE(sdm845_gpll_addrs),
+	.dbg_rcg_addrs = sdm845_rcg_addrs,
+	.num_rcgs = ARRAY_SIZE(sdm845_rcg_addrs),
+	.dbg_rcg_names = sdm845_rcg_names,
 };
 
 static const struct udevice_id gcc_sdm845_of_match[] = {
 	{

-- 
2.46.0

