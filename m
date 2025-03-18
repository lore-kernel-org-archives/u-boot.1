Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B97C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63BD481951;
	Tue, 18 Mar 2025 11:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xPFzPUDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A23180F4C; Tue, 18 Mar 2025 11:47:24 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C92D800B3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so4786694f8f.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294841; x=1742899641; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9Aws54lCojzlmAYh4hyQ7NAp3mGWeR2F4tRNwvQTfE=;
 b=xPFzPUDvk1beKQPtZWO1+ufYwM6ny0hNOFUOUVkZ75aHE8dVwTut4uAgHfnPmRt3hV
 eS+mQf5OErC5aAsLbWP/kDEuzHpE2+8tHtXiLasdM5faFKslyQhBE8elWgpXT3LHosBh
 eOx7XO4+9q9vuDokiMWNz3X7r7x3KItzeSUyy54ULFfAiY8jaou3+YWXcoJW+0O5yrNT
 cVVBcv8KAccvI39D+kLF5xYAYFHiHzj6rNNYdsFLfxrPUUXKnS6pWK0FFM01RzasCitk
 Pz/oUgDFwMX6KKfR09prQSTlg3xPHGaSegACn4CP5Ox/QV7+XEV6l9AdSoGcBQBq/Wtv
 jhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294841; x=1742899641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9Aws54lCojzlmAYh4hyQ7NAp3mGWeR2F4tRNwvQTfE=;
 b=HEUWmOdleCOkAc0Z1ZQaO2zwoHqp+SeDERK6D3wXsmumKpkbA/KY+B3soHKeIxWc9m
 FVE6gCNVZYbi+Yfp1899d7y/9ki7Jz/hOcyV3KbtLovxqpXtr74euZmWBwt1kDxGmTxW
 XFv2QmhW6nCU3lPDcedyP/ZG/30xWPaHbjJq6+UoApC37Gebzpg/MPq4ISZZ/sQwow0v
 LV+lPXFlQDmHsbEx12L6kMNZXD0/aNrRYHJwcYCVz+7aIU5i9HiwTh1lAKVkn7aZe7eE
 fqrqRn3X5I1M2wsPmOyxarxSw6xVrTqneYRjd7P3mxaRY2C+it4SyZ/7fcH3zeAqDaUu
 rl5w==
X-Gm-Message-State: AOJu0YyWa3UZYvYmmzPDmqETt3o0hhhgqk4PaEu0JMwFAVRdocrq3Mdn
 vu3uOxRrDdhZhSVsVzXPNn8+QbZXTECYwfOikEA0QScyZkjuWesiB9oXDt7Q8nzWGpd6fJt5Rb0
 oFCM=
X-Gm-Gg: ASbGncvDEJxT6NzKB8c6OQxDJGjEvcQRiG6fZ/QKqUHkVvzTEUHJCPmDgB+DoKL6SBb
 /3dhcdkVWmVMQ6XPAnauJ+4I+Lwp5G4rNAsb2m/2i6dhwoH2Y+kb4O/8jfV1gKaNs611d/Dlfyz
 8FUzrwAFXqQonJq8Py1oKZp4QwzN+5wffETqkQEbC5o91nUugjlLSoIDBZqfvlzqJltU/3e2iLt
 cXZ3Kxxwe72Wm9dovtp7x7/ieSTzt56mRF/goyG3uKHl8H+tBlYId3Y5k73oHtfcfDkkVB8K+30
 veL0/wx7LmedlOJJhdQRsJH1SUXbePTCZCwNKrmvh3LOB47ji/72SQ==
X-Google-Smtp-Source: AGHT+IHud1+P2yX+X8DQi+VVt3uWYNa3muPrsE4O4pvoQvhH2XhXejMoELaLcPNYz8dPEw/5aHfdDQ==
X-Received: by 2002:a5d:47cc:0:b0:391:3f4f:a17f with SMTP id
 ffacd0b85a97d-3971ee43fc3mr18049663f8f.42.1742294841472; 
 Tue, 18 Mar 2025 03:47:21 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:21 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v4 02/14] arm: add initjmp()
Date: Tue, 18 Mar 2025 11:46:38 +0100
Message-ID: <20250318104659.1114340-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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

Implement initjmp() for Arm.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/Kconfig                  |  1 +
 arch/arm/lib/setjmp.S         | 12 ++++++++++++
 arch/arm/lib/setjmp_aarch64.S | 10 ++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 14111ca14fb..7a3141e92b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -95,6 +95,7 @@ config ARC
 config ARM
 	bool "ARM architecture"
 	select HAVE_SETJMP
+	select HAVE_INITJMP
 	select ARCH_SUPPORTS_LTO
 	select CREATE_ARCH_SYMLINK
 	select HAVE_PRIVATE_LIBGCC if !ARM64
diff --git a/arch/arm/lib/setjmp.S b/arch/arm/lib/setjmp.S
index 2f041aeef01..81bef578719 100644
--- a/arch/arm/lib/setjmp.S
+++ b/arch/arm/lib/setjmp.S
@@ -34,3 +34,15 @@ ENTRY(longjmp)
 	ret  lr
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	stm  a1, {v1-v8}
+	/* a2: entry point address, a3: stack base, a4: stack size */
+	add  a3, a3, a4
+	str  a3, [a1, #32]  /* where setjmp would save sp */
+	str  a2, [a1, #36]  /* where setjmp would save lr */
+	mov  a1, #0
+	ret  lr
+ENDPROC(initjmp)
+.popsection
diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
index 1b8d000eb48..01193ccc426 100644
--- a/arch/arm/lib/setjmp_aarch64.S
+++ b/arch/arm/lib/setjmp_aarch64.S
@@ -39,3 +39,13 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* x1: entry point address, x2: stack base, x3: stack size */
+	add x2, x2, x3
+	stp x1, x2, [x0,#88]
+	mov  x0, #0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

