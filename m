Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6860CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A191F88378;
	Wed,  3 Apr 2024 14:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kKmq3YEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08198839E; Wed,  3 Apr 2024 14:07:57 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBE3C88391
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:07:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a4e62f3e63dso406921066b.0
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146075; x=1712750875; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MOEUaSh2jP1fM+GMfk9jn6DYONqGieAUpvNGE9zTi/M=;
 b=kKmq3YEKi6XLbho74MQYWCekPP9yoRkKq9SUtFtcjkA/0PK6ZUztta27P8N3C21GaE
 ONO32eraomxfeRELo6x8T3gWdKUn96Ieq115z6WH7vyH58uEacrldEgNZBR1Q8dfjXic
 faBqXjGu4BsirC6iWdI/a5Yn9obmEAMdIzZzHPb7TANTopoDxc2MK/zVGQwV71cfAP65
 0LCs9vdYETBAZ6yFyKK9XLoR81VuLXqL+Ids0/jr73STmmZORNtFNISWXI/0LRqPGYbl
 BMp0XlVdRBJI9uzIfBCpPKpGbA6w1ufOc10e+1lXnplwa630S1xUeaTlucQ/sPt08r5u
 Agng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146075; x=1712750875;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOEUaSh2jP1fM+GMfk9jn6DYONqGieAUpvNGE9zTi/M=;
 b=C5ot+snIA7dzBVEP2BVcy83zzIkCE0Uqe0Lw38xIy3UdXkdC9IQa0pkubUH4J+FVhs
 0yP7bqlm5CRhsOX9lc+HI9fx65wWRr/LDstU+NsjeCcJ2YY8WSOb+QzbjPQVl/wQxUGT
 mBJwJRtQQKIOWsDcnZLBNn9uUibIOn4C5glX74uEbJGUmZB4/CJ6Ytt/hUjalgIcelg2
 hckVX9D7yp5iPRD6rszE8HAa3sA5PS4Z5zcnjJ0mlMWDTFRLEKBSBYJlcdGo1d9CQ1Zd
 E3J8hnFIv2dbhxfI81rdttnWMhvJAdSvfbfsziuj+bXwa/Oa8L4At8p43l3jdrrJI4QU
 9yMA==
X-Gm-Message-State: AOJu0YwwV9QdnY1GWTZM9fLP3k4eV58A1n3zHHBFglwZOn7jAcFmsMrT
 1U60oCFzoz6mXqYP6lBxCXfqKkrhZdW1I5bzBHKNJZ0xFF0lIXiySF+XaeHLa1E=
X-Google-Smtp-Source: AGHT+IGSkfJ3NHZzNp5DAa1OQCBY6wOKSErVpMIGDAfH4tXIWjAN2ONtD6vHOdylQ2BuNOTqTxuKUQ==
X-Received: by 2002:a17:907:7d89:b0:a4e:696e:6b78 with SMTP id
 oz9-20020a1709077d8900b00a4e696e6b78mr7190649ejc.66.1712146075439; 
 Wed, 03 Apr 2024 05:07:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:07:54 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:41 +0200
Subject: [PATCH v6 06/16] clk/qcom: sdm845: add gdscs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-6-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=J2wyNARYq0khhF05IOZjfXaKY3NwgELyfaNZ+Dn9LDc=;
 b=kA0DAAgBBYMxKxlfZLYByyZiAGYNRpDI5k+7JMVTtSRnCXD/ehfdX3XshvJbt0/K/CoMxa+AQ
 4kCMwQAAQgAHRYhBLZRoUY8ar7QaQxVzQWDMSsZX2S2BQJmDUaQAAoJEAWDMSsZX2S26Z8QAI2V
 9XC4zPfc7182XWB8Vm64mGnmaLyXR4NJslKM6a+qWG3zVcAF6p3HZmM5MNGJPwhtraloydzhVsw
 SrMvJhh1L02uLRVR3JTizB8jMDMwDHx4pWlTs67W5+0yfxz9OPmSI0KtFQunzpMhrIXuj4Mk5Od
 i+EU5vLn/5+D6TW+QxT7foOCB/qO8PQMJ260ZliwHed5I2TF76BfRtk/REplMoIQlWoX0l7eLkJ
 2wwA2yynShgErPltZipu4yGQ68KEzjGi7Yk6MMBogcFH5+y4lQ6pFXFoDqynUcG5UPrh1uXjmFf
 cjPtsHaS7FkUomuZcjRLuAK4RbEwc0jWc+Bu3e2H0VS39WPwyPXhfzPzOQpbhL5SmPVpDtX6aa0
 83wMcMBfcFUCYqNsO7Kt0a03pTLzupkERpVX8df1RGWf1kvtq29rl5eSVG8ITjLFZP+Tl4GKhRU
 iLyjowkhB7CSbWeZYmpB/F6S7YhGkXKTqP2iAgHUl4c8j16vUmDcOXPMUpSf4zIXO+nx2JVm0O9
 eHVDKZO8Q7x9CgZivjAfhNIV85gmLrH/CwldDOE/mjukov6bzs3RSeTfnX+Alsnqm6CfFY5IjiE
 UhyxBIExlcoJwKwupGBUWc/W+w8FMLYofCt4qjMcF8E2NkaQzdiJFJF8Ozjkqy96y6dYzrvwTI3
 yEG39
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

