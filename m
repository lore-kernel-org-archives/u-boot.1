Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F823C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D289880F3;
	Wed, 20 Mar 2024 15:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FCDAOPTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 755F3880E8; Wed, 20 Mar 2024 15:57:18 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CDC287DF8
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-413f4cb646dso45896335e9.1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946636; x=1711551436; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MOEUaSh2jP1fM+GMfk9jn6DYONqGieAUpvNGE9zTi/M=;
 b=FCDAOPTr5IzJKG1Wmr81leoymv17fAv6ibAZoCgv1ufPDYjFwblqOPwOn9K/r0ZC85
 lkeW9C2FQmpIYPj4r1fn1FZlrI1ON9V0wqBLtDCHbkxl2ijlUoicWNokGVJbzRBbrUfg
 9NOJICOXaPAeizQpAUL1q3QeOsWKW4b80YHJx3ZnYMU4O9huIDgaPXD/xZP21vlCR3X/
 dnD/IgUrihJMW+PiEomTY5zAbbnyuz77yHx4SGm0+M2pKOpGacHAS1Tk0JxHQI7URME1
 lFP4x5bhMerPQn2Lubgbngc/xYCUTZGQYjN407sxKS1xQYhiVpEe20AZXJTdgkdu0Io6
 9Dgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946636; x=1711551436;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOEUaSh2jP1fM+GMfk9jn6DYONqGieAUpvNGE9zTi/M=;
 b=Xwr5sR6C+rWFHtiD6pXbn61+Gj9LLp28MRmppUUeIhdnP7WAsfsxK6Baap8eGeZilm
 6J/m4VWJkz0L24UOFqzGAa/sNZASp/D5n+mRDK+prBcD6JkLArAjZqftyWCVfXobcLfs
 cTRl5wNfGoylcu5RwiKUPE9K+9fvhV+tLULeJGkga/G1z+MItuwJ/LFmmiANWKNNS0D+
 +YnF+/qXl9HKawOKlpeF9N21OdOGr0s96KZS0QjD5cJFBGWO8L0Xx1Lshz5YqLIYMYcq
 YqGLiPlQk5LwfRvhd76TmOX2bfZgN9UewIDLc9KjHNVFMP9Q79cpO8SP10v0Xhh2nOf5
 26UQ==
X-Gm-Message-State: AOJu0Yy5CxjIFXstAiOGlCo470mDu/hyxk16bexp94CcFsqgeyOD3Rbi
 c8poX4obi8x8nbvd4MxlkiGEpRjOZ9sD+FulYdgo76DsVZGoRqQOLWJu9k/IHEQ=
X-Google-Smtp-Source: AGHT+IHPIPsAUBlQg1NX2IjCsiBTByoK0j4Jxa1zwq+0ZXbo5uT45kfbUHK5Q3Tj52q3bcECV3MKXQ==
X-Received: by 2002:a05:600c:4591:b0:414:6211:14a7 with SMTP id
 r17-20020a05600c459100b00414621114a7mr4227688wmo.14.1710946636136; 
 Wed, 20 Mar 2024 07:57:16 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:15 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:09 +0000
Subject: [PATCH v4 06/14] clk/qcom: sdm845: add gdscs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-6-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfPx3r78TMM7E097gctnxiUm79hqUOc4Iumjyrlbqqm
 ytwpKG1o5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzEvJPhF9NLW+npHL2ZzG0h
 EbEsAi0f2N4lTwv4+mCTUFVK4+TP7xn+J3k5PFpy2cf3Mc+kHoN1feEB5qoKkwwzU96e09DovSH
 VCQA=
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

