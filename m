Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40332C3DA5E
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEC688874;
	Mon, 15 Jul 2024 12:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cjfh3jpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4DE488859; Mon, 15 Jul 2024 12:08:52 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B85B988883
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a77e392f59fso488147366b.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721038130; x=1721642930; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N9IT/zALEh7mKodPKHns820h3aA7IvXfqWmQ85Fiq50=;
 b=Cjfh3jpkxDUXV/i8UYQpOfe3s8YpB+SswhKiqb5qhvxOcZLf9QnbdrMgGm9gITRkio
 H2sAMs5L/Y4FCCm5BM288ga0BQDbJXbY9LfV2iqPKF4tJcUd7YizGt7tgtG4J7RtJ88G
 p811Xw1h1OMACJt0SXcnqLj4i5tSihbE1LgEoRqFHlXO3U+1fFupx9PYAoMzNDq38OpH
 2WIJ+CxKmn2E2N7lDO8G+j8mrz950EbehSYXWZ/tEmrLBCMIHHVgimlDdN0q7z7Lpw+K
 FyyB5b33rc56Jm/HMFXqsA3+/1+iIpCvNeRU6SvR45FjbNVPEzfhoj8tYUnZHmeMUtNJ
 7blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038130; x=1721642930;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9IT/zALEh7mKodPKHns820h3aA7IvXfqWmQ85Fiq50=;
 b=rxef7+p3tiuxv12sj0tZwLGCiD96QVrsBMeChaadNRPXLhwCEBq+cr9m2ORqilIv/g
 2JtD3ukHh96HljgxVNNZKpBBrEpgPhnKw8EYfTJKLdFX3ETCoGCYfPdTXCV3wMFmiZO8
 q0nz63Yhd3ma7QENCaVKcxnMNU1GIovA0SliygMGnma7/8a4HQ+wpdPqqtdkDTQ9TS75
 BsEXT+JWQLVuSzHD/skMJTk4RDdlaw+zdEVvMJHzfdejqgRMdR9UstrZGzWMVlmUGnaz
 LGynd+cztKXEf0Lbx6JDi6Umot0h2j8elXB8ceN5GFOqvzgdsY98hNlANp75YTUK7lEH
 mXLw==
X-Gm-Message-State: AOJu0YwnwmB32QiYypDTLzUTzkc4ZQpAVJb8mNOExeSwloB3t12UHEjW
 4fODLeKZVzqyG2+D83f3UJw6nnEwtWx0kvrhbImWvxYmbSM1aOzs92/zM2SIJsc=
X-Google-Smtp-Source: AGHT+IF0RkkBsSjC+/KcmNrXYOshhqqJ+HO4ALN06xP5J/GIk4QaPUaLMdzZIhxiWbYr2sNzDH3NLQ==
X-Received: by 2002:a17:907:6d0c:b0:a72:450f:6045 with SMTP id
 a640c23a62f3a-a780b6b1e47mr1419147966b.21.1721038130298; 
 Mon, 15 Jul 2024 03:08:50 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5b7eb4sm198102266b.60.2024.07.15.03.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:08:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 15 Jul 2024 12:08:17 +0200
Subject: [PATCH v6 18/24] power: regulator: qcom-rpmh-regulator: port over
 lineage_range helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-b4-qcom-rpmh-v6-18-0c948a25d018@linaro.org>
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
In-Reply-To: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2125;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=T2PdM3mGDz1+DKxROesAPumWj6fK3RvayA6EpoqfUCo=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmlPUHRKgneCu/8lejQZ/QZlLhjeC1Z+QNGsqOh
 tn9AsRPJyCJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZpT1BwAKCRAFgzErGV9k
 ti0ID/972vxpjKjO1yCV6UdmAVExyR0Wjj/ImR5e3m9QtJDam9MRQnsIBxPFgy7h3eNauPWSsj+
 ylOGVafgnVZFDsiNzFvKDyMjichV8jn8b5/pyH9vsQbrBq897PAX43UOA17wMLAts0paJaTV3qA
 V2Df8NpmoHH81AxVU+7sg6M1MwLDysnpnKXJ1zTxHBgF3PfyMdYrmGnguaplzg9DDnkl57xCMYG
 5z6XZ2UOrfCeF0npn/qZAi7PowXb1Rb0CVu6QC12EcPymq+4P7455ftMj+g9FUw57WUh89yFrz5
 E1c7B5j6OjpCi9Jhzq4HisxuHvhtKTBXWKWSc5TE3CzrqqPssbBX+YbVEaYQS51rT2t+jezDtKb
 OieODFMm4iUSCu2g+Id37qEA6c08Om5awybtpAndZ1E2AXzI7XMAzvkBSJ6ND7YPnXX6FnsdLVB
 AtYbBnbTaCPBp1cSVmkv2Eqf5+wK0K4MByjuiA7uk9sipZWK/VIdYmPkFj4TO0oRxnuA0mq0RoL
 TjAXrt+1GO0pYrfSAsbU0sasvqIINtLHroYVCqL8dEMVJdjyWulKZO2Nkp0co2CdvSknvu3eE/P
 CmoX3ymftwnppcry8ZdeRPzKMMFeC/bvHoBgO8v+W5tmnBCJwtHpH5FMjLgacAcZxzCrKJFylDI
 T4RIWZt8O15ngig==
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

