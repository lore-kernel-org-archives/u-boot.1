Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C99CD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:01:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFABD881E4;
	Thu, 28 Mar 2024 18:59:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J12FDXHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A3E881BF; Thu, 28 Mar 2024 18:59:51 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56242881D5
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33ed7ef0ae8so848622f8f.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648788; x=1712253588; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MOEUaSh2jP1fM+GMfk9jn6DYONqGieAUpvNGE9zTi/M=;
 b=J12FDXHasM2pm80dPaSqUuV9CoBhg+V2qTFqTLoRyGnT9TYjEasUv0ijABSzpcmJFi
 cad5cVb3vY7D2PDHuF49GSDA8DcWkiRf/1Of9G4RGVkTBVNlsyDIW7Ue9zDqyz1cb+by
 NAq9osM9JRe5qKx6zgwA/c2JifieTjIayO+t7c/QMhEqoxukJBV1d0odtRGY0wccM2N6
 ZXxadkvPnwlDLTmI4qr85iLL8I5cPWZ+Qoi/XTwYYOHJ9q+mwAWmkhGTW2ZI4/gL95S4
 il/epkBdWKomCtodLaIOTEGuifDVsfAsvBhQAF0/mpbwVugIxgp8ZcRIh+B20YXXMkXp
 7ieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648788; x=1712253588;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOEUaSh2jP1fM+GMfk9jn6DYONqGieAUpvNGE9zTi/M=;
 b=R9AhmsTjYscZBrw0XotoljEol8eiprdLAbOODP3WHV/zJANHIN3uN8VXUW587ULQlg
 nD5zJ5zZM7vQa18+sP9679Jo1UJCuygover3Kn9i74suL8bERbH//SjL2wqbcwp/yRPN
 4JIwPDZOi2BAtaCy+e5UuAnvddfsOf/GV5fxORkQ4NbtMe9/AtgB9Lf/EBKGP1317o0G
 YI4pqYxDNakkdz7U3PdklWV9yFZWTHxHwO4RagqOSGKI+eEYhLNa53j2Jfz1qa/oaip9
 45Tl2ufirVWYmA3wYJ0U5nbYBL26deY/yKBVb0Qb1u00c2cCu6DJGXAnr3y9jEfUEBCZ
 uVHA==
X-Gm-Message-State: AOJu0Yy1X5TuW11bAX8kDQo1y2FfPzm3tiB4EXkrH3LDbbt1493rGk/z
 BVuLhBG10r+OjC4M2DymVMs9CDm7LOfFvQVYruKfTVdcODPcM+1hprfSAj80ZRQ=
X-Google-Smtp-Source: AGHT+IFyblP2ocaictBNYgt2T53qIadpg7insyBrVwoN1fYzUgPIDbxg+qcO85M4GP65r23Z7Sw3mg==
X-Received: by 2002:a5d:6b47:0:b0:33d:2d07:b567 with SMTP id
 x7-20020a5d6b47000000b0033d2d07b567mr3158000wrw.24.1711648787821; 
 Thu, 28 Mar 2024 10:59:47 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:46 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:12 +0000
Subject: [PATCH v5 06/16] clk/qcom: sdm845: add gdscs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-6-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=J2wyNARYq0khhF05IOZjfXaKY3NwgELyfaNZ+Dn9LDc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDZypKrqLKmf87QpfNCPp2mVmn2/tyd1Jn9ztfC9HX
 7229W1RRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhI9G9Ghs7wg9ELe/d9rI89
 KF7weP33cqWG5aH/8t1UohMvf33+KJvhn8LklBMNnVUmJmtZRJ3cLRxYk53q9FcInfHbnOxhNl+
 oHQA=
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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

