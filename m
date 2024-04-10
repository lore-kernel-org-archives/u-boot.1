Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16AB0CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 16:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F61881C1;
	Wed, 10 Apr 2024 17:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L21kE0R3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0CD68815B; Wed, 10 Apr 2024 17:59:51 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E043481EEF
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 17:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-343e7c20686so3884561f8f.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712764789; x=1713369589; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3FZxgBrC8KxfYtQvW62bs/elUi8gPOkzQrUnPtR7gPk=;
 b=L21kE0R3+/c/iL4PCZQa471Q2AzEtb2lm3Pz4uPEMcnG9GzaC7JPH7htKIvH9NFDTI
 Cp2U/Y7TR1uXAgD4jyp5Z+3JHJsO/VcttVejIpoG8kjvKFVvds5vd7of8D6FsXYTCgIM
 oXS/tUITxAYzKSR+Dd8jqfPmthmCnGVwRd9tAjTU9lMUa157Tf3BD6HMC3lty+MdOiU0
 s6ntauI/fEcfG+kItMorlAA6I/K/4WTnd/IjfF99qokvj7YVAwTJD5c84XY1ndEAEtgJ
 PjS3rEFDf5VcM4k/LHYPVXG2y77J5WLqT+AqR0yr77u3vB+WXP17UkNZkXqy2HjIHYzv
 sNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712764789; x=1713369589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FZxgBrC8KxfYtQvW62bs/elUi8gPOkzQrUnPtR7gPk=;
 b=wQsQz02jUGlU1ZQ+nZWekm945HypYUs+ONsjvSq7OqbEoQRo4p83Jx2PTAAfqozGGP
 NVn1a5mfIEdM6HrR0HPdFZDnApOQn5ryceY/hvlNM0QwZn34bWQ+cnefnn6+S3eapG3a
 Ms5Z2Z03SXVxZw4yjkrymi9a+DcCFA0nAFlf+QcSrJ8iA9Z3zKTukng65S3BxwUXbNkL
 uOXHa+qrNvWOUxP0WoZeUDT4oER5TiWMblCMDkMN024IFSbgq2zQVXerUrjuTCbP26Iq
 9MB58saSz5bj+xhV+hQx6oIOPlcc78uli9KMzeQ2HKRrZgqA6l08+XVhD6Ng7wpxeAQL
 Nu7w==
X-Gm-Message-State: AOJu0YzTfDgyyFBmcWfZVss80ci3FVn9MQSMFC1w1YBbkymJHtyH08rc
 3Y22Edfo/CLsW5QWygHKip4IzxR1lkdv7VBB24T5e0G/U9o/+PdDr+8gQvjUYNxDHdOkjMcm4hR
 TpLk=
X-Google-Smtp-Source: AGHT+IE9UdnQHXFBbEhGX3X5Wcm+H2ho5GvZazgKVH1wuhRJzeSkccN9V3+D9LiGxCcPJ5GVQNCq9A==
X-Received: by 2002:adf:e98a:0:b0:343:af1f:491f with SMTP id
 h10-20020adfe98a000000b00343af1f491fmr2258665wrm.14.1712764789039; 
 Wed, 10 Apr 2024 08:59:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a5d638d000000b00343ad4bca7dsm14039431wru.85.2024.04.10.08.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 08:59:48 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 10 Apr 2024 17:59:45 +0200
Subject: [PATCH v2 3/3] button: qcom-pmic: add support for pmk8350 button
 configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-topic-sm8x50-spmi-clients-v2-3-783e20d66c25@linaro.org>
References: <20240410-topic-sm8x50-spmi-clients-v2-0-783e20d66c25@linaro.org>
In-Reply-To: <20240410-topic-sm8x50-spmi-clients-v2-0-783e20d66c25@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=deSMcSYkix4cJpASgfIcHwoL3jgHF+QbOb+NbvbmeAY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmFrdx88MDbDc8D/dj5xRXNcc8lb/aZioCuPGwgq9O
 FS+Gk3iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZha3cQAKCRB33NvayMhJ0ewmD/
 41FQ/F15gW26ElSbcgSNuGtraylI6LZJoBtnEHAW1KZ6w1w8WUqqawF559pX43THB6J78Jhnh3qtj6
 jtMRFobDqJJvL6rvSGOzZnTBzV2tX1/RhL06HgR6CCb0gk2KaQj763v3LKfdk+AaxD67pDhmWIQzWX
 Ryo+9nBxfc913p5d6/67B0d5H+rFQAzQauULehewBbkwCvMR1mIbbsk0JkPmd4pmqlKRmXMxkw3Lxr
 08UlmDaedv+njv00mctJ4FUeoMRmgrcqwz2oKmgJRbbwDUQxJr5v6VKaXUNAkAI1jIe/V/nnQtVQzs
 ai7eCJj+86rzJ62o8AUswcDTWsWDoK4qUAVc09LyzOdPtd6KDNKsIfdAgnW4z8OVa82wop4fTQou0p
 7pwIiN2Pf8cKlK2cyKNWgtEATBZfrhb8s3T9AHFjfYhhxXm322amyN8T4FZ6ny/bJmdXwyv22nXZOf
 yhn9sOhGT2eSlXeH6rIJINZPoEmldaemna+pwPKuAxbFQqbzikmw0Js2MPwWWetpMmHWQq+rLaUZCA
 u26+JK296uHSnG1YyjO4Ees1I8VEueamq+03W0qLZjGExjTYxrTwKtUA2+4adcNeKh92ELV+0yHraL
 ejeomCieI7zaDdjN0PTW6E5aynYwROXmiRBlgSuCR83jmM8vGVqMTNGoXJmw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Finally add the entries for the qcom,pmk8350-pwrkey and qcom,pmk8350-resin
found on PMICs used with SM8350 and later SoCs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/button/button-qcom-pmic.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
index f6da958097c..ad7fed3ddaa 100644
--- a/drivers/button/button-qcom-pmic.c
+++ b/drivers/button/button-qcom-pmic.c
@@ -36,6 +36,8 @@ struct qcom_pmic_btn_priv {
 #define PON_INT_RT_STS                        0x10
 #define  PON_KPDPWR_N_SET		0
 #define  PON_RESIN_N_SET		1
+#define  PON_GEN3_RESIN_N_SET		6
+#define  PON_GEN3_KPDPWR_N_SET		7
 
 static enum button_state_t qcom_pwrkey_get_state(struct udevice *dev)
 {
@@ -69,6 +71,18 @@ static const struct qcom_pmic_btn_data qcom_pmic_btn_data_table[] = {
 		.code = KEY_DOWN,
 		.label = "vol_down",
 	},
+	{
+		.compatible = "qcom,pmk8350-pwrkey",
+		.status_bit = PON_GEN3_KPDPWR_N_SET,
+		.code = KEY_ENTER,
+		.label = "pwrkey",
+	},
+	{
+		.compatible = "qcom,pmk8350-resin",
+		.status_bit = PON_GEN3_RESIN_N_SET,
+		.code = KEY_DOWN,
+		.label = "vol_down",
+	},
 };
 
 static const struct qcom_pmic_btn_data *button_qcom_pmic_match(ofnode node)
@@ -179,6 +193,7 @@ static const struct udevice_id qcom_pwrkey_ids[] = {
 	{ .compatible = "qcom,pm8916-pon" },
 	{ .compatible = "qcom,pm8941-pon" },
 	{ .compatible = "qcom,pm8998-pon" },
+	{ .compatible = "qcom,pmk8350-pon" },
 	{ }
 };
 

-- 
2.34.1

