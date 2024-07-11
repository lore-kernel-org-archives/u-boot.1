Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11B7C3DA45
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 16:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F562887D6;
	Thu, 11 Jul 2024 18:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WAxOGHy6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199B7887C3; Thu, 11 Jul 2024 18:47:05 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D72888766
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 18:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a77c7d3e8bcso149731466b.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 09:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720716421; x=1721321221; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N9IT/zALEh7mKodPKHns820h3aA7IvXfqWmQ85Fiq50=;
 b=WAxOGHy6lExpmM5lUDjAf6B6vNUR7eqyOdkxjQDAyB8M4aZ2Tnq0jW7RHIe1SbU0vI
 a7KAH0rmPPdQmCFY1hU8LAzPfMQDOghcEYHKIL3sy+JPB4Zy6jNe57KqpE0eP2bCFZmo
 KW+XUMjB9xOz2zyOTMk6IGmtV3if0e54crXaPzp6U2ws5xQ6tkscul29aWyhZlFOBCUT
 GyU5HvQlD9M2UkmYu+g19ZyN6QDW4u3HPhSBnKLoakGkA/+gxZHSWFfQjYb8Ej6qoLV3
 U4aL2JIE9mueMRvAavNETpNFKvrKRfhA32FwwWTXamV2ev9oa2Hd+A96IVXVKFB6f05V
 bBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720716421; x=1721321221;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9IT/zALEh7mKodPKHns820h3aA7IvXfqWmQ85Fiq50=;
 b=Wx4imfHQebY8BU5sWm85HBqeq1FZBrKnXeUcjsX9HwAZNLKU7vgFNa9bwchfXkr5Do
 YAUY7Q4wZImSl8a6yRmLAsFE/1jYJ9apEG1cxY9+vahyvxCFD5CPaqanK9PjAuSegO+6
 SQ8H6Zhy3IYsk0JNUFTdkGyXWeIkmRR8BiiNNrn5DBtPC8zMCr5/vjTKLtOaZvzsVMcM
 9dXGXf4XA6GPVSNqdeNtaVXUo+hac0T0jL/lC03QuohIs+EXFjD1a7amMcUMno9lr3eC
 NStMaist8FMpXbv91ZrCMRcsCw/pbCwqJJt8CZHoFCpyWJj+SMOmtzVJHQ6ZbzJxV4UO
 ctjw==
X-Gm-Message-State: AOJu0YwD3xP82WteSn0dcTZWNXLL6DzlKJxRdsB1Sd12AimoTiKGqD6c
 LubgiW2hdVUvQjJnQJbjavpSzlMiSF52PL13R39YTd9n0WUH7MdbhRcsM/fHeKY=
X-Google-Smtp-Source: AGHT+IELoNmsnKRqputKG8UAtTHTNYqOYwdwKtbCUA0XIAoBglHeCn9/hGf37/xy7NTXbojtWYeq6w==
X-Received: by 2002:a17:907:1759:b0:a6f:4bf2:daa2 with SMTP id
 a640c23a62f3a-a780b68a8a3mr590279366b.15.1720716421774; 
 Thu, 11 Jul 2024 09:47:01 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a8545adsm268454166b.159.2024.07.11.09.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 09:47:01 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 11 Jul 2024 18:46:49 +0200
Subject: [PATCH v5 17/23] power: regulator: qcom-rpmh-regulator: port over
 lineage_range helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-b4-qcom-rpmh-v5-17-fbf04ce6a7e8@linaro.org>
References: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
In-Reply-To: <20240711-b4-qcom-rpmh-v5-0-fbf04ce6a7e8@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=T2PdM3mGDz1+DKxROesAPumWj6fK3RvayA6EpoqfUCo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmkAxvtJ4nRMschO9VOI47KFaFgoXuS5I3P+S7p
 AmQI5PJ6c2JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpAMbwAKCRAFgzErGV9k
 tiDLD/4qWdnhqwQWYpg2jlSQb7NCCMXwEiZzYQ+WXm0kZtqcurJMTuFgXVfQ63gNjQsy5vEHB4q
 FnURi6baFllTntjNwEMu/+iDZui9k6RhbgvjqGsK6vwDm6uYj4rfcd1Z4O/skJ/QzYMzG85FsOJ
 1LL0aivoYUplzakMbi5F0a+Lb95mIIqCJtmHgOlBYwQxpNrCURAD6+UgAEsqAT7MDrKvIs6El01
 o+Jzn9yi5xXIAZ85OWenxHQG+QttBGN0M18dpFPO+6+9YYBfsBf1O10L+MWhrqdnYhsyd24nfUp
 9UcqOzHWqhCQylpZXuZLyk9FtOjMGOh2s7/yJbpsbRlnF2L2enLC6U2hsKBf10HcmsPFTAN2sdA
 /rjgOYwrCr8eZXWmU9vHSZJB/X6COrUGi3ebWXxooZVBFnfzv1NoS15/cDWc6vWGXiXRnY/73OA
 MnpFrNiXcCVtJnhJPl7OIFo5a9zPKPqF/4ExYeAWMmScKcUKm+ZLSCa5Ei5cyoHs+2P7xkAmRAb
 aKzXefPTOjrHdFt1NX2bdA5ifh0WUkYvEauYEYiHfWga3aDKxhBRxY+OFMZ4UDmVApj7IktJFNn
 qPCdouFDfAegAkc4+c5bHmX6Aw5Cxd5sluaYDdlEvhid9PkyIdw9B9CcBgb2wJWe5A2lm/pzrRZ
 q+Rdx8lg7CcEJsg==
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

Import struct linear_range() and builder macro from Linux regulator
core.

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/power/regulator/qcom-rpmh-regulator.c | 37 +++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
index 5f522de44734..d0acee9f558e 100644
--- a/drivers/power/regulator/qcom-rpmh-regulator.c
+++ b/drivers/power/regulator/qcom-rpmh-regulator.c
@@ -28,8 +28,15 @@ enum rpmh_regulator_type {
 	VRM,
 	XOB,
 };
 
+enum rpmh_regulator_mode {
+	REGULATOR_MODE_RETENTION,
+	REGULATOR_MODE_LPM,
+	REGULATOR_MODE_AUTO,
+	REGULATOR_MODE_HPM,
+};
+
 #define RPMH_REGULATOR_REG_VRM_VOLTAGE		0x0
 #define RPMH_REGULATOR_REG_ENABLE		0x4
 #define RPMH_REGULATOR_REG_VRM_MODE		0x8
 
@@ -60,8 +67,38 @@ enum rpmh_regulator_type {
 #define PMIC5_BOB_MODE_PFM			4
 #define PMIC5_BOB_MODE_AUTO			6
 #define PMIC5_BOB_MODE_PWM			7
 
+
+/**
+ * struct linear_range - table of selector - value pairs
+ *
+ * Define a lookup-table for range of values. Intended to help when looking
+ * for a register value matching certaing physical measure (like voltage).
+ * Usable when increment of one in register always results a constant increment
+ * of the physical measure (like voltage).
+ *
+ * @min:  Lowest value in range
+ * @min_sel: Lowest selector for range
+ * @max_sel: Highest selector for range
+ * @step: Value step size
+ */
+struct linear_range {
+	unsigned int min;
+	unsigned int min_sel;
+	unsigned int max_sel;
+	unsigned int step;
+};
+
+/* Initialize struct linear_range for regulators */
+#define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
+{									\
+	.min		= _min_uV,					\
+	.min_sel	= _min_sel,					\
+	.max_sel	= _max_sel,					\
+	.step		= _step_uV,					\
+}
+
 /**
  * struct rpmh_vreg_hw_data - RPMh regulator hardware configurations
  * @regulator_type:		RPMh accelerator type used to manage this
  *				regulator

-- 
2.45.2

