Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88BBC47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E508287BDD;
	Wed, 31 Jan 2024 12:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XmfNnDRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C22587BDA; Wed, 31 Jan 2024 12:12:43 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 658F287727
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 12:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ddc0c02665so2249275b3a.0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 03:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706699560; x=1707304360; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KTOZcHnxf0qanQi0Y2qOuj7RyKzN91RjCgXJOCzYEmM=;
 b=XmfNnDRIUCqyweKUV/JPY8km4PnSLHkc15ZdxjILVDRKiA4uQTpyjMIt9Hw7r41SLH
 iWQ+kNs2TenPAYekI5z0rOIIXbniBXkZACmpiEZz+ISQ0bHUKtISsOOrCns7GO6GkvsN
 4br12jud89tJQ8uFZKr1laEaxorDi116fWg0qyyqSVccUdgmGox3tbzgfGl1dE0Zc3ft
 +Ta5Q1Wgifj82xCDJF11EAw2kQXdjv/aP10HARbyfy13n7uqO19CVUBspjXnqGQVqItR
 9Ml0mSLq0gemSc/hVw+yLInBpGWN6exE+Yv0I/0u1E4aca72Fk1XQQx7TsOH49H/74wu
 clbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706699560; x=1707304360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTOZcHnxf0qanQi0Y2qOuj7RyKzN91RjCgXJOCzYEmM=;
 b=MoFV4OY1Xd0Q65HKA0M1Fw310ekLAnewKr6hOe/FZyiN+CY9qM3r5jNzKQNWjuzgZo
 m0jY+R+rhEppozaxdwCJbM1VyK26+tIdnmHcFEIg4k09FvSTFAUbFJ8KTQQ/DLoasJu/
 z5FoJk0EEWrfFQcGjpFijD3txZM7RqumhZVKclkTIWAebFNbANt+79N371jU64opNVBD
 7CzzMg7IRNb75686LcbSus0Y/SZu2A5twCbRqmp2wZVk7o9hfwaLJE2Lhi7XbfCi8St2
 e4LDPmJLxKTQg+KBA2mvycuZQDTC6GAaVuHWkHqAg4sKs0NXGJUoe0BcM7nYHc4gsEGm
 nc4g==
X-Gm-Message-State: AOJu0YzIKLnq7P5XmXLLf6Or4FdiON0x+Ka9qxERdBf1KzeIVC64DKNz
 q6RA7siE57idSWYBOCv08W/4OYEhQntSKvolpQEm4sfALqH2IYBT
X-Google-Smtp-Source: AGHT+IH7qlSHt1ViYkkQOpc0VtAkZ3QjcMHYR2R96axuA3Q4N4jjAASy4ngzdntYPPjRl02AEfiwjg==
X-Received: by 2002:a05:6a20:871c:b0:19c:935d:8a69 with SMTP id
 e28-20020a056a20871c00b0019c935d8a69mr1014178pzf.36.1706699559073; 
 Wed, 31 Jan 2024 03:12:39 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVtMBxFaBuSdvz+hbOZcH99boD9/vj88koSZcJM3CY6xD8sFZ4NdUQfsAPTcVWDyITCLeUhVoKm0WWwgaOFVL5YXaKa/iQQZwzbhMF+ZOD4SZdJ3iymfYWYZ7AhT1rEKUVFqQLGPHm8dcZ+B3CPgpH/GjZ9MQaiDo0O0qij5Vxblt2VfijJ7B+iIGa7lnQX9Wor1XBwQsZgw4blC2MXJrq1JJJnUfjF60m+3vb6lb3qiUAicuGjs6jx+2cfamcM8ExSjCeKbcHOTEWs2YOCEl2nkZK3xT82a+RynyV1Gy4IGbp+WKe8m6zyolp+NLeeJJ5fIDbl2eGQnidVuw==
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a62f201000000b006ddc03c425bsm9535007pfh.180.2024.01.31.03.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 03:12:38 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/3] firmware: psci: Fix bind_smccc_features psci check
Date: Wed, 31 Jan 2024 11:12:15 +0000
Message-Id: <20240131111217.30124-2-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131111217.30124-1-o451686892@gmail.com>
References: <20240131111217.30124-1-o451686892@gmail.com>
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

According to PSCI specification DEN0022F, PSCI_FEATURES is used to check
whether the SMCCC is implemented by discovering SMCCC_VERSION.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
v2: check SMCCC_ARCH_FEATURES
---
 drivers/firmware/psci.c   | 9 ++++++++-
 include/linux/arm-smccc.h | 6 ++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c6b9efab41..ed701cd1e4 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -135,7 +135,7 @@ static int bind_smccc_features(struct udevice *dev, int psci_method)
 	    PSCI_VERSION_MAJOR(psci_0_2_get_version()) == 0)
 		return 0;
 
-	if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) ==
+	if (request_psci_features(ARM_SMCCC_VERSION) ==
 	    PSCI_RET_NOT_SUPPORTED)
 		return 0;
 
@@ -144,6 +144,13 @@ static int bind_smccc_features(struct udevice *dev, int psci_method)
 	else
 		pdata->invoke_fn = smccc_invoke_smc;
 
+	/*
+	 * SMCCC_ARCH_FEATURES is MANDATORY from SMCCC v1.1, but we still remain
+	 * the invoke_fn() even the SMCCC version is v1.0.
+	 */
+	if (invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) < ARM_SMCCC_VERSION_1_1)
+		return 0;
+
 	feature_cnt = ll_entry_count(struct arm_smccc_feature, arm_smccc_feature);
 	feature = ll_entry_start(struct arm_smccc_feature, arm_smccc_feature);
 
diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index f44e9e8f93..da3d29aabe 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -55,8 +55,14 @@
 #define ARM_SMCCC_QUIRK_NONE		0
 #define ARM_SMCCC_QUIRK_QCOM_A6		1 /* Save/restore register a6 */
 
+#define ARM_SMCCC_VERSION		0x80000000
 #define ARM_SMCCC_ARCH_FEATURES		0x80000001
 
+#define ARM_SMCCC_VERSION_1_0		0x10000
+#define ARM_SMCCC_VERSION_1_1		0x10001
+#define ARM_SMCCC_VERSION_1_2		0x10002
+#define ARM_SMCCC_VERSION_1_3		0x10003
+
 #define ARM_SMCCC_RET_NOT_SUPPORTED	((unsigned long)-1)
 
 #ifndef __ASSEMBLY__
-- 
2.39.2

