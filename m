Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FB3C47DDF
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 748FA87C39;
	Wed, 31 Jan 2024 15:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OKJWiGHP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C6787C13; Wed, 31 Jan 2024 15:14:49 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E0CE87D3B
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2907a17fa34so4047870a91.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706710485; x=1707315285; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/AajSOxFiOBeFhM/Afxcu3V3V1Jg+uEpIRi/E2vkK7c=;
 b=OKJWiGHPbdOCnj9/DpTRmOH5R29P5YFmEMiP9/nWdguN62Qpe+q7q8M918zeZcDACk
 zMEQWTiUEyyKrW6MyrDFB/udw7W8F3yYUynXzBys1+GD+WXAFPgiR2xqL4Yea2FOpUt+
 SfGHrwnnsunwNRfF+RrJE2uxO47nqAkBgNkIk7CXM2YWrw2keQYHZi9yeKEgSYVAmLe2
 HhySrThydQiQWjpytrkI8fHENzl3ptPF7XmhnzVKjG+lDNjdV8zR2WMSevDY2pajvjIh
 E8dcSvAtpJvGbSgs0rtl7Nn2pMRlow+MiLrte4OnvhH+PXLMwsJqAoPdVIO2VvJZ/3Od
 bpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706710485; x=1707315285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AajSOxFiOBeFhM/Afxcu3V3V1Jg+uEpIRi/E2vkK7c=;
 b=UQazvXyGclNiGWA1kHI+odcjpZ0NKVvqGKiBsPgMnEToBvoYc+GYZ98Ch4BxRaRVxN
 +bmfJevO+HRwrhJu4Rvtkt1bS1C2Pk4/nRkc0eUDZQXcysoxsIEpFl73yzQg3ulUlc8J
 bt0FNQ5RR65ZTf8b7ziVfBvswm3JPoAZbaoGGKRNAdof1TQGy2WyNEgPF6CM9L0KM1yP
 ++Yqj219eKAzS2++or7R6TIDYtvg5wPyKz6Xe1NSaHUZJzqP2iSQrEgITlMmAnCMChfx
 BCZBSsb8auRKeG42Wn98+LdmxcRCGlbUnLvvjLkPjhG9rNZmOtnPR9F5OPO+K33h2kfz
 QgSw==
X-Gm-Message-State: AOJu0Yzk4ZyEltahxrOAOgYrX7zLiScN5zo1uNMLGbYDTE9Z5QO4S1sE
 tw93djYQHl1mQM4P0DvEq9QQ3Wv3ZZGeLGXscDwBE81957D5pkUV
X-Google-Smtp-Source: AGHT+IHvN211vXyASPN2FFrt3qSPEAbw5e+g1zcbAJcG7jlEeetNF2YtTrcCtXskz/qEWWPf1mUJyA==
X-Received: by 2002:a17:90a:cb97:b0:295:b0cd:9be6 with SMTP id
 a23-20020a17090acb9700b00295b0cd9be6mr1761173pju.30.1706710484978; 
 Wed, 31 Jan 2024 06:14:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWSRDIJyNYzSzcwtCPTrCPSZspgv7rnZ7YAsNLIVE4kcHUwXQf+JWyZtxq31vdxAiFdWuWN1qB8Ir4rUDNF4F7/F8v7ZZaKnVZWNsm18osWPqBUPWySMIYF7jq4n9Wt//+orV9IqBw1URNHben3epADXui++cwuyn+wM6Br7TwLMSd/yAd7Fo8og3Tfi0Sm4pctlVFTnO88BNaA6yqqWUKH/3cQWSC6yqyRpvExerNpYoHbWFCEHMuPB0eZdUBdFuXG7BxaHtJDCoAC69N+E85fxVgG412cvPL8rvd1dhhoHVgAuG0Dlo0lH3zIEbFk4zaMJGTMW6uJ5MW28yGC0V7BaEi7SDs83s7AONikk6Mpyyl8MAPfzqfwHg==
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 mm3-20020a17090b358300b00295bafadb4fsm1534954pjb.57.2024.01.31.06.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:14:44 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v3 1/3] firmware: psci: Fix bind_smccc_features psci check
Date: Wed, 31 Jan 2024 14:14:24 +0000
Message-Id: <20240131141426.34926-2-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131141426.34926-1-o451686892@gmail.com>
References: <20240131141426.34926-1-o451686892@gmail.com>
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
v3: remove fallback smc call
v2: check SMCCC_ARCH_FEATURES
---
 drivers/firmware/psci.c   | 5 ++++-
 include/linux/arm-smccc.h | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c6b9efab41..03544d76ed 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -135,10 +135,13 @@ static int bind_smccc_features(struct udevice *dev, int psci_method)
 	    PSCI_VERSION_MAJOR(psci_0_2_get_version()) == 0)
 		return 0;
 
-	if (request_psci_features(ARM_SMCCC_ARCH_FEATURES) ==
+	if (request_psci_features(ARM_SMCCC_VERSION) ==
 	    PSCI_RET_NOT_SUPPORTED)
 		return 0;
 
+	if (invoke_psci_fn(ARM_SMCCC_VERSION, 0, 0, 0) < ARM_SMCCC_VERSION_1_1)
+		return 0;
+
 	if (psci_method == PSCI_METHOD_HVC)
 		pdata->invoke_fn = smccc_invoke_hvc;
 	else
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

