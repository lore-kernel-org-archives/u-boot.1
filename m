Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F503C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 19:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8338388D34;
	Mon, 19 Aug 2024 21:34:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TiPYtFA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87B1188D28; Mon, 19 Aug 2024 21:34:29 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7253488CC9
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 21:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52efd08e6d9so5608075e87.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724096067; x=1724700867; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lr05GnlfvAsxpkamHeIJpnX6FfbX9eMlmBjZxVkUo3g=;
 b=TiPYtFA2+BBbmwDBygCw83AhUCbEkiTOIFDYByXwzskwAcPnd51XQx20YvgLHJxeHV
 5zOCi/fAKuYUlmh0H9AwzLlRBPU2WvKwI3wUdN5FuxiyUSy+3e/Iu1qVqQLP9WBILQi1
 l0Ky3/vTimcZ2lEuBq81C94+EGU4fF9fSK7BZhvxAVm7XmQTg8TE+QrSvkijdKXvpRB6
 WU7tMaswQDennbf3b6cIHkTurMxPk4DebM2ZQTSIxRlA00CACO/ugJw7qy74iBvMiWb/
 MCI5cdY6y5zQX46gs0OoLMI0Gd0TUq8/HHZvJeghS5lmhNaFkVsD4b0FaxldM3ygIopi
 y6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724096067; x=1724700867;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lr05GnlfvAsxpkamHeIJpnX6FfbX9eMlmBjZxVkUo3g=;
 b=PUYqUevlIOVMSxo8z6AG5729dnAA57cYqhxsga04Gmb+ONFYaobKu66pNNT0ofNBHO
 d2pLo5FsK5voRlhX3hjYF8obuOHhWzUF7PlTzAfV9rQXXJvJr8YMk/NnES2KjHbCC4IQ
 2K+Ztz1qQ8A8D68OVVN0ckUPNyCzU3vsMNzpg1tcF9IS0o2dEhGwJ9doPkBoSVNQKHce
 scvwCiGOYesuxpt+nkUwGlce71exibKsgLL5eh5K9xBUlAXvNtgQ0vuANPczPhNa/6ll
 AlcO9V43vmMDPOSIHt48yc0JR3YC3q1CKGuQ8Cz1Cevi/De4Y56EUPtFolyXvnmAdmOl
 oXdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Cwi0znpdEb5L5F9Bm74tTijtFRURHcj5GCfB7XpxBs7etwy1whxME0OHABKxbNQKeyWJPd1ur+DQBRakTKwlSMs2Sg==
X-Gm-Message-State: AOJu0Ywa9YyEbOgist5+SvYgveunFOm0j+vGHGAsZ/sf5aKIkF1xgrz6
 DItcP+AhpfIhEQJ2SfcTAYi4db7yS3X4PVfC/OPb+hXmLkgyitaSxwmYKWGsxww=
X-Google-Smtp-Source: AGHT+IFSUitoEzloQQ4InXmDPR14+wO0hT4BRMdhGxHEknNSUPPF/p+6yH7qNv5g03pUR0kMw8icoA==
X-Received: by 2002:a05:6512:308a:b0:52c:dac3:392b with SMTP id
 2adb3069b0e04-5331c6b3705mr8444793e87.33.1724096066311; 
 Mon, 19 Aug 2024 12:34:26 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8383964976sm667783666b.188.2024.08.19.12.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 12:34:25 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 19 Aug 2024 21:34:20 +0200
Subject: [PATCH 4/4] clk/qcom: sm8250: add debug data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-b4-qcom-clk-dump-v1-4-182cf77c23a2@linaro.org>
References: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
In-Reply-To: <20240819-b4-qcom-clk-dump-v1-0-182cf77c23a2@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5406;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=MOlEeC3YWFagl+NBtYginLvXnge7rLfMOd2qIYaWJmY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmw548a1bN0ZTLO+E3/+8DLcDW9v7apECmdYxuO
 2WLT9hzz4KJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsOePAAKCRAFgzErGV9k
 tlKKD/90Y9SYw7Ubss5t1qodpndsHpf/lunHGrA6LOfobkrctqEF1ky5e4smHrmWwTqRgV5pI1M
 dst+e07pTrg6uG49Ltyg/T9eucgVe1ZlwKU+DgFF8mD66+mpz+gF4L/hNniLZH5xi1kUO5dUzj4
 XciWrXq/EwEncoT+LUb04NrVG5ui0uW5Rd1GNBtX0iCtuWuvsqSO88aOFnUeY8haFBblPWUGrZW
 LpRZrBWavfIDKiuVBGClTM00bZLzqXwGBLjZ/v5bj8FHq1K6afCOT+95zG5a2niCaJQQl4vZPxJ
 nNaMC6NqE11tHNtEbGtNmJsGl5Lg9IB2s2+nnDU1BoIlJouxlP9nJarrsuozC8CgJjNNsIP5dry
 NO72z70xplNx3iyiL6BTpcEK/idKmHLJFSX4+j10y0NN+yy1Ple5XP9dnRt5nHNv1+yU1p8JVVB
 sn6ALRlFyGDgziqwGD7WGeyjYak5xCacBIsakpra8OqNbP+w6w7je53Rk3CFyBa3K/TdZflu+oI
 4sKx3piuZmmGrb2sOX4G6NHGVo9Xn4IscRNN54Ae5JJYZmsyGUN12ybB3I/BJ4oMFnL4X+KQCoz
 l4gGM6IjGNFWEt7ag4t5dRdt07Q+xpKiomzWP2I+xevfKOTGBj3mKrupngISB8QNE2VcKDwuQqs
 893ePPPiuxxl47g==
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

Drop in the RCG and GPLL data for debugging these clocks.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sm8250.c | 115 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
index af10fc116219..e322a923a5c0 100644
--- a/drivers/clk/qcom/clock-sm8250.c
+++ b/drivers/clk/qcom/clock-sm8250.c
@@ -252,8 +252,117 @@ static const struct qcom_power_map sm8250_gdscs[] = {
 	[UFS_PHY_GDSC] = { 0x77004 },	[USB30_PRIM_GDSC] = { 0xf004 },
 	[USB30_SEC_GDSC] = { 0x10004 },
 };
 
+static const phys_addr_t sm8250_gpll_addrs[] = {
+	0x00100000, // GCC_GPLL0_MODE
+	0x00101000, // GCC_GPLL1_MODE
+	0x00102000, // GCC_GPLL2_MODE
+	0x00103000, // GCC_GPLL3_MODE
+	0x00176000, // GCC_GPLL4_MODE
+	0x00174000, // GCC_GPLL5_MODE
+	0x00113000, // GCC_GPLL6_MODE
+	0x0011a000, // GCC_GPLL7_MODE
+	0x0011b000, // GCC_GPLL8_MODE
+	0x0011c000, // GCC_GPLL9_MODE
+	0x0011d000, // GCC_GPLL10_MODE
+	0x0014a000, // GCC_GPLL11_MODE
+};
+
+static const phys_addr_t sm8250_rcg_addrs[] = {
+	0x0010f020, // GCC_USB30_PRIM_MASTER_CMD_RCGR
+	0x0010f038, // GCC_USB30_PRIM_MOCK_UTMI_CMD_RCGR
+	0x0010f064, // GCC_USB3_PRIM_PHY_AUX_CMD_RCGR
+	0x00110020, // GCC_USB30_SEC_MASTER_CMD_RCGR
+	0x00110038, // GCC_USB30_SEC_MOCK_UTMI_CMD_RCGR
+	0x00110064, // GCC_USB3_SEC_PHY_AUX_CMD_RCGR
+	0x0011400c, // GCC_SDCC2_APPS_CMD_RCGR
+	0x0011600c, // GCC_SDCC4_APPS_CMD_RCGR
+	0x0012300c, // GCC_QUPV3_WRAP0_CORE_2X_CMD_RCGR
+	0x00117010, // GCC_QUPV3_WRAP0_S0_CMD_RCGR
+	0x00117140, // GCC_QUPV3_WRAP0_S1_CMD_RCGR
+	0x00117270, // GCC_QUPV3_WRAP0_S2_CMD_RCGR
+	0x001173a0, // GCC_QUPV3_WRAP0_S3_CMD_RCGR
+	0x001174d0, // GCC_QUPV3_WRAP0_S4_CMD_RCGR
+	0x00117600, // GCC_QUPV3_WRAP0_S5_CMD_RCGR
+	0x00117730, // GCC_QUPV3_WRAP0_S6_CMD_RCGR
+	0x00117860, // GCC_QUPV3_WRAP0_S7_CMD_RCGR
+	0x00123144, // GCC_QUPV3_WRAP1_CORE_2X_CMD_RCGR
+	0x00118010, // GCC_QUPV3_WRAP1_S0_CMD_RCGR
+	0x00118140, // GCC_QUPV3_WRAP1_S1_CMD_RCGR
+	0x00118270, // GCC_QUPV3_WRAP1_S2_CMD_RCGR
+	0x001183a0, // GCC_QUPV3_WRAP1_S3_CMD_RCGR
+	0x001184d0, // GCC_QUPV3_WRAP1_S4_CMD_RCGR
+	0x00118600, // GCC_QUPV3_WRAP1_S5_CMD_RCGR
+	0x0016b038, // GCC_PCIE_0_AUX_CMD_RCGR
+	0x0018d038, // GCC_PCIE_1_AUX_CMD_RCGR
+	0x0016f014, // GCC_PCIE_PHY_REFGEN_CMD_RCGR
+	0x00175024, // GCC_UFS_CARD_AXI_CMD_RCGR
+	0x0017506c, // GCC_UFS_CARD_ICE_CORE_CMD_RCGR
+	0x00175084, // GCC_UFS_CARD_UNIPRO_CORE_CMD_RCGR
+	0x001750a0, // GCC_UFS_CARD_PHY_AUX_CMD_RCGR
+	0x00177024, // GCC_UFS_PHY_AXI_CMD_RCGR
+	0x0017706c, // GCC_UFS_PHY_ICE_CORE_CMD_RCGR
+	0x00177084, // GCC_UFS_PHY_UNIPRO_CORE_CMD_RCGR
+	0x001770a0, // GCC_UFS_PHY_PHY_AUX_CMD_RCGR
+	0x0012327c, // GCC_QUPV3_WRAP2_CORE_2X_CMD_RCGR
+	0x0011e010, // GCC_QUPV3_WRAP2_S0_CMD_RCGR
+	0x0011e140, // GCC_QUPV3_WRAP2_S1_CMD_RCGR
+	0x0011e270, // GCC_QUPV3_WRAP2_S2_CMD_RCGR
+	0x0011e3a0, // GCC_QUPV3_WRAP2_S3_CMD_RCGR
+	0x0011e4d0, // GCC_QUPV3_WRAP2_S4_CMD_RCGR
+	0x0011e600, // GCC_QUPV3_WRAP2_S5_CMD_RCGR
+	0x0010d00c, // GCC_RBCPR_MMCX_CMD_RCGR
+	0x00106038, // GCC_PCIE_2_AUX_CMD_RCGR
+};
+
+static const char *const sm8250_rcg_names[] = {
+	"GCC_USB30_PRIM_MASTER_CMD_RCGR",
+	"GCC_USB30_PRIM_MOCK_UTMI_CMD_RCGR",
+	"GCC_USB3_PRIM_PHY_AUX_CMD_RCGR",
+	"GCC_USB30_SEC_MASTER_CMD_RCGR",
+	"GCC_USB30_SEC_MOCK_UTMI_CMD_RCGR",
+	"GCC_USB3_SEC_PHY_AUX_CMD_RCGR",
+	"GCC_SDCC2_APPS_CMD_RCGR",
+	"GCC_SDCC4_APPS_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_CORE_2X_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S0_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S1_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S2_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S3_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S4_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S5_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S6_CMD_RCGR",
+	"GCC_QUPV3_WRAP0_S7_CMD_RCGR",
+	"GCC_QUPV3_WRAP1_CORE_2X_CMD_RCGR",
+	"GCC_QUPV3_WRAP1_S0_CMD_RCGR",
+	"GCC_QUPV3_WRAP1_S1_CMD_RCGR",
+	"GCC_QUPV3_WRAP1_S2_CMD_RCGR",
+	"GCC_QUPV3_WRAP1_S3_CMD_RCGR",
+	"GCC_QUPV3_WRAP1_S4_CMD_RCGR",
+	"GCC_QUPV3_WRAP1_S5_CMD_RCGR",
+	"GCC_PCIE_0_AUX_CMD_RCGR",
+	"GCC_PCIE_1_AUX_CMD_RCGR",
+	"GCC_PCIE_PHY_REFGEN_CMD_RCGR",
+	"GCC_UFS_CARD_AXI_CMD_RCGR",
+	"GCC_UFS_CARD_ICE_CORE_CMD_RCGR",
+	"GCC_UFS_CARD_UNIPRO_CORE_CMD_RCGR",
+	"GCC_UFS_CARD_PHY_AUX_CMD_RCGR",
+	"GCC_UFS_PHY_AXI_CMD_RCGR",
+	"GCC_UFS_PHY_ICE_CORE_CMD_RCGR",
+	"GCC_UFS_PHY_UNIPRO_CORE_CMD_RCGR",
+	"GCC_UFS_PHY_PHY_AUX_CMD_RCGR",
+	"GCC_QUPV3_WRAP2_CORE_2X_CMD_RCGR",
+	"GCC_QUPV3_WRAP2_S0_CMD_RCGR",
+	"GCC_QUPV3_WRAP2_S1_CMD_RCGR",
+	"GCC_QUPV3_WRAP2_S2_CMD_RCGR",
+	"GCC_QUPV3_WRAP2_S3_CMD_RCGR",
+	"GCC_QUPV3_WRAP2_S4_CMD_RCGR",
+	"GCC_QUPV3_WRAP2_S5_CMD_RCGR",
+	"GCC_RBCPR_MMCX_CMD_RCGR",
+	"GCC_PCIE_2_AUX_CMD_RCGR",
+};
+
 static struct msm_clk_data qcs404_gcc_data = {
 	.resets = sm8250_gcc_resets,
 	.num_resets = ARRAY_SIZE(sm8250_gcc_resets),
 	.clks = sm8250_clks,
@@ -262,8 +371,14 @@ static struct msm_clk_data qcs404_gcc_data = {
 	.num_power_domains = ARRAY_SIZE(sm8250_gdscs),
 
 	.enable = sm8250_enable,
 	.set_rate = sm8250_set_rate,
+
+	.dbg_pll_addrs = sm8250_gpll_addrs,
+	.num_plls = ARRAY_SIZE(sm8250_gpll_addrs),
+	.dbg_rcg_addrs = sm8250_rcg_addrs,
+	.num_rcgs = ARRAY_SIZE(sm8250_rcg_addrs),
+	.dbg_rcg_names = sm8250_rcg_names,
 };
 
 static const struct udevice_id gcc_sm8250_of_match[] = {
 	{

-- 
2.46.0

