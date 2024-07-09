Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44637C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33940886DA;
	Tue,  9 Jul 2024 11:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hNssE/qU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EABF6886E2; Tue,  9 Jul 2024 11:35:05 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C64EC88664
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:35:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso493200866b.3
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517703; x=1721122503; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PBRV9HtCAioY8W6KRuovgHIWG2DQPIA8+so2CUToZuw=;
 b=hNssE/qUpzJQFCgfdLJhqRUsbUiIJqyUZizaEq0vqOzxOUwzhX5tuBosqskmDsRqi9
 JISCFWQM1kbWt0+YL+RCMHkupuBGlA9AnCMU3yFkoKYbThUEUmroSBTKlXbVTZ2wc0TK
 qOKDz7MDDKwEa+7aJiwauJsmkifGx94/9ezelqAI+75bDZ9eHqe6vD4bdw9VPLg3uWFz
 /NJPzlEo6QNPitwndeINTE/hU2E6G2R5n0jtFyMgWzLNA80Kgrkk0lJf8CnCaAJtHJzr
 YSgIiikuaSVkBkFSYmMwhjEOxj3cOUM00XyOM4AcMHkyBNboSsU3X8tD/tkYd78jVKQJ
 b5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517703; x=1721122503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PBRV9HtCAioY8W6KRuovgHIWG2DQPIA8+so2CUToZuw=;
 b=V94ZTNCywvFpAgiMfSIMSdArQ7LHrc9k21lOd3P14LpAaVtcn6OmM4wNG9Gi7hgyn8
 xKHKi7YdU9zuxpQXGzr0gE4IpueHnUbOgX4hD2leFMSIeDcLaCgizndkOWkRlNBMTuF0
 cA82Wm9mqKkl9rfwJxYCOCh2q21+KPOcPOiMvWUAFYxupw6wWHkzTe+Ej2p4ClutTG/m
 vufaMbYPwkB6A4X8MLPMC/mPM3iyCD0xtUrMd9Tfsagzil+okHe9jeMo6W/+gxI4cmwP
 GyLTNgo82zPVKNHVlabklEZS/2SNt4MR6EhGTVV3rzga261mwQxz7QjC8w0TIe/KrrLs
 WHCg==
X-Gm-Message-State: AOJu0Yz8Gf9RvUlfCA9deYqD5l/jx4pvmB8F/R1QLS5XSD9/maqw7t0E
 Af0tgP2JmXNXtWu4tmKDCH3PYtqkwe5E9Frytrzoyt5Zr88fIsgGIIOT+HJPrN4=
X-Google-Smtp-Source: AGHT+IHhYVrJO7YXs+LkriDccZwE41//SD1fmXRDj1sLp7I+igyDK5YMiMrTDZr+to/MNRKRRxa8DA==
X-Received: by 2002:a17:907:7da8:b0:a6f:e456:4207 with SMTP id
 a640c23a62f3a-a780b88498fmr170927066b.61.1720517703246; 
 Tue, 09 Jul 2024 02:35:03 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:35:02 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:44 +0200
Subject: [PATCH v4 16/21] power: regulator: qcom-rpmh-regulator: port over
 lineage_range helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-16-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=5Z/DU99kQYFH1eROtd3LbcjUhXJFE12rJaGmm5hJdLY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQ0ppIjYkt3kKBiZNZYjAXh7eZk2I6877dHF
 kbx4u/6bt2JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0ENAAKCRAFgzErGV9k
 thrcD/9IPv4D/A35mSbnMO0710jPjHUEOyR22s8J64JnYaH1DqiR8ahwUu0DPePwYIHuRdTKtHr
 zXHS7h+3EUcU/ISxyFm7/ixLVYjURPKweiEezBqyrw8Op/UUvYU9Gl6Qb8scL52+S5/gJAKG42K
 nk/Dx828KSi60ThGV01XvIY2WvKNTeAy0/Fs3Mjhk7GERo+O0Oya1ZspXBKlXI0lI1am2iETbjT
 481yK41+bitKpDrGo57AdKKNeeAuJZuRtzT2db7xDpjsX2ixREjfj+t+S1zxJK8ulZ2CIBj2Wf8
 SkiWrI4PjXZexEXMDmrrZ2Cz7Rk/VXiB+VLky7uvOt2mflejqNBsj1w00tOPhr1g5TKLNOoyIsH
 lJ6IspNkrM8aLzDJ1PQ+wjg/J9tJDTL6kOVa638e6HTJ7j6jD+i8XKdSGg+l5SR5wJnsQtfGIoF
 0NmdTgIYA6Y3bevSezuYFZxXhvTxgI6n0ZKsLpmLM0nWvsBEbvkRUo5KMRvPSdYPisdtZd0k8qB
 rbNiMXeaLTrGbdNVc+xXbQkXvOQ3yyvJvsfGy0s1gWJVcKwSOw0MgsrrsR4vZqzdsNfVFazLRWK
 SxKkaSxaZb2xaFbffMCWNn8tLEP0OQpbBrqj7pPQGNwvGo2AZcQFnIy8icjcvovBDwlI49Y/nbx
 kynYunsVhr/UnPg==
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

