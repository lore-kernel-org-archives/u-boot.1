Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A149FC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8149087FBC;
	Mon,  4 Mar 2024 15:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ADG7syAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987DF87F92; Mon,  4 Mar 2024 15:43:11 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A21A187FAA
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1dcad814986so40632975ad.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709563385; x=1710168185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kAnBmvUPtyk9ZyqY5Twdb8FXlln2XacWWSGREZ+qdVg=;
 b=ADG7syAniQ5h+x8LkavjzpasFuPcaqjFLTfdbzbyu2v0H8EkDCHUpt/VZfKnZOMyY2
 6BQfvZmo8lVOs98C4CYcRf32T5HOfWhmq8ljmGWjwKD15MAZhBLbk9u/Tc05WPTvSQbZ
 J2t89WQKKmSANXy/2JKMmbJ/UUtwbNOJkizF/e1TH2YtikgI/Fr1qBpoNBnowfIrXYuq
 spJw4jUl1k8QdHIgLqnQNjZRPEY+fDmFE1JyiP03Tni3mAM/HvkCvKjn4K6IPL7MqllL
 DstucOaxOpzUcjo/4NiLQpjOt1bEYwe2Q+u+eAgdrWJ5cOHH2uAhh2g04Ow7Rnapye8U
 yjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563385; x=1710168185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAnBmvUPtyk9ZyqY5Twdb8FXlln2XacWWSGREZ+qdVg=;
 b=D+rVThlIEINlmesBJOwCzu/y4Etoazn63kqHnSwcz+F+99gvqpDxbm5amNLDG/Nrx9
 PVPexchhf6py5ma8W9aCA1cf5FXR/eKruwXSbPz5lafF9xML/vC/SRD+0VzNUSRGnHTa
 rU0JVwNF5c8sghnk1Csot/CjA2PPM0TlOPl/tps2FNAsEn31nc/WoUTGZ40lKxiqtXHq
 UqEkbEokgndNE2Jo2jpO4w0szE9tCVLvi5N3Wv8garDzYqVlhhn3zubPCKa5ORdeqGnl
 T8D8mxCyZVURuZTqaIngOgB8xtv4mkh7MXtVCnlxQNUTASp0hAzvxD6brz5cN5Af8PCI
 CwrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEvx5CkxdKLg0RXOAc9kCwR4lwmh+FZ7GIbf0jPaL40qEssDXRukOUHlyngWwbwuE7hM3igibABKvy/1F7+FwXZz1kDA==
X-Gm-Message-State: AOJu0Yx9zD19X+ApKi4XWx71YspsbyDwq+SFYBxzlLZfgRVolqSc39Ak
 wsILDMz5TfvJkcuY8vLtNoUNZPmEwt/1WEkjQ1PNWMULw3N0YZWh
X-Google-Smtp-Source: AGHT+IFEl6onAjtAZwyO+DsN9aAedcEbFzd5Jx+ay/aaoA25+DMO9DwkQGbUCILDmjFzQjAlvQ9p9g==
X-Received: by 2002:a17:902:c408:b0:1db:28bd:2949 with SMTP id
 k8-20020a170902c40800b001db28bd2949mr13078576plk.0.1709563384957; 
 Mon, 04 Mar 2024 06:43:04 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 lc8-20020a170902fa8800b001dc8923a2c4sm8629529plb.294.2024.03.04.06.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 06:43:04 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Weizhao Ouyang <o451686892@gmail.com>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: [PATCH v4 1/3] firmware: psci: Fix bind_smccc_features psci check
Date: Mon,  4 Mar 2024 14:42:40 +0000
Message-Id: <20240304144242.11666-2-o451686892@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240304144242.11666-1-o451686892@gmail.com>
References: <20240304144242.11666-1-o451686892@gmail.com>
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
2.40.1

