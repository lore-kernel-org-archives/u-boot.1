Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF63C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA42D88048;
	Fri, 15 Mar 2024 16:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WkcVKsnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A6588053; Fri, 15 Mar 2024 16:10:40 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEDE788001
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-414025406d7so3626715e9.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515435; x=1711120235; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XcXDGKGs2bZP+ebZn00UwvTozAt6kTe7PFxPgb291lE=;
 b=WkcVKsnGhl8blRq+GE6Awm0OWYLsXuZlg4GxBKtkeM5kstvYLh2d+0oqYdPUKW7p8+
 FMex9Oet7rSXzunWlEzcjvoTYVc3mQJ2e7S7IuK9rGxNmupcDLPreKjlnBtjfVWYQfpV
 j9vElPKKw5k7s/zCVvny3LmZUDKgd6k6PKDsrg3w9iAOD/Nxb3YxUYAxg1xcLjHzRHBw
 iQ2iUVsiEPn5rDqOYVKFkwaj2DEDUj8Tx9a5aVHxsdYZfKXfb/8+B3d03DEjnPswpJ84
 SD4pjT9VAj4DMcgw2L54IB58n3tAfdWpJRYY8HDUSUabbZiExlH6Ka4y3jTYYC/bG80I
 O7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515435; x=1711120235;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XcXDGKGs2bZP+ebZn00UwvTozAt6kTe7PFxPgb291lE=;
 b=WsNHZGpUsqSvcoQFvKBUpK2375N9TjQ4ahJX5MWN847BD3B9wQwTgPlafVMyejZzAc
 DUYqeCZt9UQsrHFxjdnKJOFuXFwS1xWFdIdOfwFSvWfI86rmhRYC0oie3Zd1++tJ2O//
 3JuL5ICl2mMAU2k6wDbIrq50htD0yZjp1jUHTS6Sk8Rpc2fOyx/VBVZaPEFvAVm6uxHn
 G43Q2jjeR8kLeG5DN8Gfe0mA7YVOO92zJacUdDmHJYX3uqlQSdyRmWmt3Z/PbD8v/9tg
 43NxE8B/d+EUAHzsMbQlOyrsxzYBIQD+z7MuXXTb58En9GFveC4ePJiGWLpYWbrjgnMy
 XSMg==
X-Gm-Message-State: AOJu0YyeQx/3+75hkWmj0JXeFH6kM+CwzgrhEFR/x95C9g35PYuqCpnR
 CyoA4BGCIu/WBOKyak5C0uMHhljE7oRly6Dj/egIoJ42njZi0SMXjo9XkDwaz3mOacVqqVLhdSZ
 B
X-Google-Smtp-Source: AGHT+IFbHihOVvie7IOFsZI8N9QHuUcIlxwbT9oRqFx3kVe5q7+B6ZzXZh2Iexz4MVZbUviCDJufEA==
X-Received: by 2002:a5d:568e:0:b0:33e:c385:7dce with SMTP id
 f14-20020a5d568e000000b0033ec3857dcemr3474737wrv.15.1710515434941; 
 Fri, 15 Mar 2024 08:10:34 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:33 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:15 +0000
Subject: [PATCH v2 06/14] clk/qcom: sdm845: add gdscs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-6-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=CZFRIcjdqr1GSgKHr5tO1jmY1D18fHto7mfrUIdD/TQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY+PNM4wkw2qOhwitSEumVuitMF7oc+n78cLLqSv3
 feN99CvjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRqhSGf7YhyRo39qy6veer
 wMc5dyTqMkJj7CctEvhUs9V42iWhB5cY/idnyb16Mrnf9tnE9sSsesGnX5dn+6Z/Lcyflb/ps8H
 Pq/sA
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

Define the GDSC power domains for SDM845.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-sdm845.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
index ccb0cf245d33..b7154360894a 100644
--- a/drivers/clk/qcom/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -145,13 +145,31 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
 	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
 };
 
+static const struct qcom_power_map sdm845_gdscs[] = {
+	[PCIE_0_GDSC] = { 0x6b004 },
+	[PCIE_1_GDSC] = { 0x8d004 },
+	[UFS_CARD_GDSC] = { 0x75004 },
+	[UFS_PHY_GDSC] = { 0x77004 },
+	[USB30_PRIM_GDSC] = { 0xf004 },
+	[USB30_SEC_GDSC] = { 0x10004 },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030 },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC] = { 0x7d03c },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034 },
+	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
+	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
+};
+
 static struct msm_clk_data sdm845_clk_data = {
 	.resets = sdm845_gcc_resets,
 	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
 	.clks = sdm845_clks,
 	.num_clks = ARRAY_SIZE(sdm845_clks),
+	.power_domains = sdm845_gdscs,
+	.num_power_domains = ARRAY_SIZE(sdm845_gdscs),
 
 	.enable = sdm845_clk_enable,
 	.set_rate = sdm845_clk_set_rate,
 };

-- 
2.44.0

