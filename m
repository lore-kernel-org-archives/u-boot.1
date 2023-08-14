Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D475CC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DFB86993;
	Mon, 14 Aug 2023 23:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tvg9MJtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D7886989; Mon, 14 Aug 2023 23:55:17 +0200 (CEST)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DFE486986
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdaeb0f29aso24363085ad.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050112; x=1692654912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPtr6fI9Bdh8bOLDB2VIunwCap9dAHhSQtgc84vsuKk=;
 b=Tvg9MJtY+DxoJh0l2UXwMAyoGRAC10juJjqHO3ePelovCTXeA6o1YYm+Zs9Zndddxu
 T5SbFmFIqd+UIpUk3bKklcR6nyTHp0BHGzmRVadZDVwyh82lJw8I3ZzkeYzJwtL0mlgk
 KWktnBs2lmuLhjFFO7EQonr9PiFuAl9+2x+FnyvZxwQKSiMj6Tg9B+f97ZhhtA7DAhDv
 a4fiaRsXE9uV6/3P6RyjgAIrXOezzJpqT/OxQEdNOzjjjKurvK3ast7S+0LKk+DMf0wI
 nnM0t9DISrgE9b25+WCgL4hUe5HmMiBV84qJZJFMVqncRbA0cUCqcvU4xRvxnrWOsMbW
 dKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050112; x=1692654912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPtr6fI9Bdh8bOLDB2VIunwCap9dAHhSQtgc84vsuKk=;
 b=jLPYXLuifwpswRoIwQr5f3nheLy+fRb24N/5VmJiRfeLaQLhP4tvofK2s9TviyezL3
 Q1t8+KUnzZRl3q4jMznLjNkHd6w1sFBvu2pcmC/gxILB6fJeWgJHRXfSOq2WxLAhZ+TV
 mtan0a8C0vxneJDA3w0d5SX15AEUKVa/cNiai6mzLMMkq+YK/FT8AnP7b3EI/ZtUPIhn
 xJRzYDbYPXgl3byduWZ5+V5ijlnbBz5DkvfuVBsX3ZSZAyGuBnVBOnaqLVBpdeFHO+eQ
 J45pJ6uUma7IWaSPeNpahCujWv/rrbiGayCxyEuZ4OtNNpci3TMcUtx7aAS9YCCHlcWt
 0WYA==
X-Gm-Message-State: AOJu0YxcjgM3YV8fwa5IRo96I3OPSn1t1YXa643xUfyenF9ZnjsEzdKg
 vuiGMhmOYbVbgCkntWDF0yEZF0SHZciqf79oqcY=
X-Google-Smtp-Source: AGHT+IHqAgQIyJ+M31BDxFaYr31oIcPJ2kpe+fguY6mlWmCUdslnzkL770XaxC4MgGLYna4OXFOsiQ==
X-Received: by 2002:a17:902:700c:b0:1bc:9820:1169 with SMTP id
 y12-20020a170902700c00b001bc98201169mr7358991plk.62.1692050112620; 
 Mon, 14 Aug 2023 14:55:12 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:12 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 01/17] reset: qcom: Add support for SDM845 SoC reset table
Date: Tue, 15 Aug 2023 03:24:41 +0530
Message-Id: <20230814215457.4075025-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
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

Add support for SDM845 SoC reset table

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/reset/reset-qcom.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/reset/reset-qcom.c b/drivers/reset/reset-qcom.c
index 94315e76d5..0d37305e10 100644
--- a/drivers/reset/reset-qcom.c
+++ b/drivers/reset/reset-qcom.c
@@ -131,6 +131,38 @@ static const struct qcom_reset_map gcc_qcom_resets[] = {
 };
 #endif
 
+#ifdef CONFIG_SDM845
+#include <dt-bindings/clock/qcom,gcc-sdm845.h>
+static const struct qcom_reset_map gcc_qcom_resets[] = {
+	[GCC_MMSS_BCR] = { 0xb000 },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PCIE_1_BCR] = { 0x8d000 },
+	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_PRNG_BCR] = { 0x34000 },
+	[GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_TSIF_BCR] = { 0x36000 },
+	[GCC_UFS_CARD_BCR] = { 0x75000 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0xf000 },
+	[GCC_USB30_SEC_BCR] = { 0x10000 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
+	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
+};
+#endif
+
 static int qcom_reset_assert(struct reset_ctl *rst)
 {
 	struct qcom_reset_priv *priv = dev_get_priv(rst->dev);
@@ -171,6 +203,7 @@ static const struct reset_ops qcom_reset_ops = {
 static const struct udevice_id qcom_reset_ids[] = {
 	{ .compatible = "qcom,gcc-reset-ipq4019" },
 	{ .compatible = "qcom,gcc-reset-qcs404" },
+	{ .compatible = "qcom,gcc-reset-sdm845" },
 	{ }
 };
 
-- 
2.38.1

