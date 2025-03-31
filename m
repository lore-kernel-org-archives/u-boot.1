Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9F2C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:24:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 179B681FC0;
	Mon, 31 Mar 2025 14:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YPS3/YYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8922281F95; Mon, 31 Mar 2025 14:23:54 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B1F581F32
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:23:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso230728f8f.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743423832; x=1744028632; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zidw17LZzOK8ylbcZWh7b80v6c7K27Jrs7l8fmBwM94=;
 b=YPS3/YYnvIMH5QGsJ+ms4ICj9pmrlD8Xcr/1OqmflA9d7tdj3rZY/Ng6jW7In6tw0N
 xJngEG/ecjfHoQf8t1QdkAYk50WTmIjpONwqrk4gmKS4kXn/2Iiek1926zaz5Mw1vZGP
 TAkhoAoSlKPJugz528nfqeI50ZsAbExpAkcZjCGy9+sBYincLQtPRP82G3tbI+TIRpqi
 rYVvY6F32r+f3+kxCitFp3iyiEaeQnhr3/NQ0HaTgUd3QX4UmEDVo58xRz07zBreTJuZ
 Dun19L8Df2knt2IvieBPBakA6dwJELelmp46TaBZqrwDxA/L3dLWjnf2kmlYRVRxZ/O+
 fD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743423832; x=1744028632;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zidw17LZzOK8ylbcZWh7b80v6c7K27Jrs7l8fmBwM94=;
 b=HiFPDnJr/iADTPhmnItIGoGbnvCXfxhr9NEmYpeKHPq6kRcMvPrxVn2c5HBZbmRF5J
 oL5Xqc1cDRLnhsiCeR6HVbQxhzl7JKI9NuznGIzSh6R5DAXvigQkxSaiKkC9cVyILKxk
 mO8rXL9jYl4B5wClq6TqtVWkmFbY1xTS5nKsztpSHePcarz021bQ/Xi4lchG7uz0zvZ0
 wIAaQAAJQmo9L2L4P9FQH1H9K65s8RVyc+m2pax6e14CsnQbRvV7efZp9TgBstxQASjg
 JZtQDcaD6V0uwh+nzvD8gYs2LfZr2gcT82le6Po0JfRyfu0CDDoSIfS2YuKFPJlhfCEE
 /cDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqBieskIje8xyUvqT4VY0/pe48iomnep9N8CjPQnPtz2rEE9f2wyU+a/CbkzDtLCLF6qQCrw8=@lists.denx.de
X-Gm-Message-State: AOJu0YxkKZ4RQ3OsTKgppqbCcn4AV9pDmEh//Y2FAbQOXqgz3YGvnK38
 iOunaqRFgdA9OhbrD4vLUyRG+6RoJ7k0EqPwFLAC0eYCUF1h7L+X/NOLHL6RWbk=
X-Gm-Gg: ASbGnctIK+X40+GPlK9XtptXzPngQsbaDn2jwRNSAOOVjyU/lBGCxwze1MZ8UhYnfWL
 D7WU0x+uiYMunhQ8UtGqI+AzoS2T/lc4HEt3VTZseY4+94YYTaNtlsIhj1ecPhHVqn2YsUo0D53
 uubrd6CAROfnU2i1IYc/kLdXDM5le5qPNA48m2Qs0Rj7uzb9v3c/H6rmMtcLKM1WLBZjokBayV/
 YjtyxNp02y8Qk3L4Weo4Nhac3Q9Vb4iWhWYlPr5X2kntfqcZLZfGZUhD9y4NCG/Tyn6rV/uc4us
 Y5GR/WxoBEuHmhJeD7+UopIlY3E06fnT7CsWRAodUpyNCz/eIuauRxRViXzIlSeM2kpcYAgOCGN
 MFqZ6zxIrt3jC
X-Google-Smtp-Source: AGHT+IE1Y514EP28jJ8EbB/L3Kl4FhgCQQb6eJUd8DDoGR08UOQju39tuthl8reNK3g2uN/11VNkdg==
X-Received: by 2002:a05:6000:2405:b0:39c:140c:308 with SMTP id
 ffacd0b85a97d-39c140c036cmr5733307f8f.3.1743423831975; 
 Mon, 31 Mar 2025 05:23:51 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b60a9ddsm11315562f8f.0.2025.03.31.05.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:23:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 31 Mar 2025 14:23:22 +0200
Subject: [PATCH v4 5/6] button: qcom-pmic: prettify and standardise button
 labels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-qcom-phones-v4-5-f52e57d3b8c6@linaro.org>
References: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
In-Reply-To: <20250331-qcom-phones-v4-0-f52e57d3b8c6@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2972;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=fa+Rh9AbOBv8xk5ShaDK49XevY729gSpcGXWYyQnEok=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn6olN98VOFQ9gocXfeRhX1aEHwFBu4Yl8HRvNT
 FJAc0ktodmJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+qJTQAKCRAFgzErGV9k
 tpT4D/9W1r85BZ238Kt+6v7JmaRFZutT0iRo09XVjXzfKZEYQm1JgabxZyti/jsnmarniStMgHw
 DfNWfd02n1IVbI/i6MkJuPmOvhQWcLJAgiqjpPPgzJLbKYLcHoowWkP8P0XRRJTEg3pqsbHi7/h
 sHvfOhrT4zLlUU4TbqodytGcSKbjkWALfjy2UQTW/XKSCcsrf3JyBb7OUKHHPsqLT2wF4Q6q7JQ
 IdYz3hm+ABXA94nbPZ5K1F/Art6LLFBP3NcSrlBg5qyt/k7ALhlzzIObrueRouSz4hJKkfUipcX
 nTlmUiebWO+tHgTTxS0rvf8tAOn6xdbotirZp+tNvq72Xdec2ChPGBsgcGNACkOF8p2mouEJXGM
 /9yctxYUCpg4XAdoTAskkFTznShgfpcIqj5p7B8djo3LrwwcuENnq/YJyPA1CM/9rZjvm5DOF4e
 pbS61VTwUmrueLpKa7224luunECs6YuEI+M3mSvyjVWH+SL0b8x6bmd2slD1FwHki5qowfm7T2j
 Yf6xUzbbbnwiY23dBOmw06YrhJlqj6oGPTj7EjfiNDRC2TTQfxRUqljTsFpYWZpO7eLUbI5aC5L
 dKug1eVFstkOfuWPx6wKxNpT/NBKIboJ+v5X7+zbmcIo8kzxRMwTiqZDj+65YYjajh/CvW31S2D
 8Jrza+HQc19e8Yw==
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

Boards using gpio-keys for volume buttons label them "Volume Down",
let's match that here, and make the power button nicer too.

This simplifies configuring button_cmds in a board-agnostic way.

Tested-by: Danila Tikhonov <danila@jiaxyga.com> # google-sunfish
Tested-by: Jens Reidel <adrian@mainlining.org> # xiaomi-davinci
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/dragonboard410c/dragonboard410c.c | 2 +-
 board/qualcomm/dragonboard820c/dragonboard820c.c | 2 +-
 drivers/button/button-qcom-pmic.c                | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index fcbf2c3fe60f21bae1c6d64b542a4d9867c33826..d0d82489f53c4f31b7b08bcf6e4269730027874a 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -71,9 +71,9 @@ int misc_init_r(void)
 	struct udevice *btn;
 	int ret;
 	enum button_state_t state;
 
-	ret = button_get_by_label("vol_down", &btn);
+	ret = button_get_by_label("Volume Down", &btn);
 	if (ret < 0) {
 		printf("Couldn't find power button!\n");
 		return ret;
 	}
diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
index d3333a59db01caa940224a99df6b43a3375cacf8..12a9273ec4b9d240bc2eaed2834d5265290153ec 100644
--- a/board/qualcomm/dragonboard820c/dragonboard820c.c
+++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
@@ -105,9 +105,9 @@ int misc_init_r(void)
 	struct udevice *btn;
 	int ret;
 	enum button_state_t state;
 
-	ret = button_get_by_label("pwrkey", &btn);
+	ret = button_get_by_label("Power Button", &btn);
 	if (ret < 0) {
 		printf("Couldn't find power button!\n");
 		return ret;
 	}
diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index f9f0948ae095f433e35ecfc0f98741ab1a850742..e3bb9bd758aca819b3a10aac84787e703c55d36a 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -72,27 +72,27 @@ static const struct qcom_pmic_btn_data qcom_pmic_btn_data_table[] = {
 	{
 		.compatible = "qcom,pm8941-pwrkey",
 		.status_bit = PON_KPDPWR_N_SET,
 		.code = KEY_ENTER,
-		.label = "pwrkey",
+		.label = "Power Button",
 	},
 	{
 		.compatible = "qcom,pm8941-resin",
 		.status_bit = PON_RESIN_N_SET,
 		.code = KEY_DOWN,
-		.label = "vol_down",
+		.label = "Volume Down",
 	},
 	{
 		.compatible = "qcom,pmk8350-pwrkey",
 		.status_bit = PON_GEN3_KPDPWR_N_SET,
 		.code = KEY_ENTER,
-		.label = "pwrkey",
+		.label = "Power Button",
 	},
 	{
 		.compatible = "qcom,pmk8350-resin",
 		.status_bit = PON_GEN3_RESIN_N_SET,
 		.code = KEY_DOWN,
-		.label = "vol_down",
+		.label = "Volume Down",
 	},
 };
 
 static const struct qcom_pmic_btn_data *button_qcom_pmic_match(ofnode node)

-- 
2.49.0

