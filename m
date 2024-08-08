Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E59AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:00:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A25688BCB;
	Fri,  9 Aug 2024 01:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KDyyJfZz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F35788BC1; Fri,  9 Aug 2024 01:59:46 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 660A888A2F
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a728f74c23dso172278666b.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161584; x=1723766384; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3G9RhTpI8+/3NayuP0N2elh0qwR/6mBQ4VCSAEH8Kz0=;
 b=KDyyJfZzo3RTKfmwRFixePsxIMRnITdSr6hRYGSQr9r+cYtxHTxzZEfRzdhquFcRYH
 YOvRYurm0flmV4A5qfGFbJuApNEJdiAuP8qQRbfCVKNn6L/UxWROREP3MDwiy/VD50ms
 dU1SMBRYmJrT1w98i2EckCC+zNlGeLTD6e9DdbKFaUI2Zu39KmZCRFFkww5WVR/CtM4a
 WNCc9EK8wwyC+t3P8kcm44WGuPwNQT0Fhx1r9i0hadMrXBSJ8a/UyuzFU2HFPhxMBK+G
 11+CqPBRM8OvliFGLtrGMNr3TerNfW35h9m9C+MqtGkgZL8VcszNuErN7S5KF9pzKznC
 9Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161584; x=1723766384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3G9RhTpI8+/3NayuP0N2elh0qwR/6mBQ4VCSAEH8Kz0=;
 b=ShIUO7YiouRsYeOeAhaMyNpzzjt/Qx4p0O1bnz/WOOEruYmLKe+iZwElbq4SUv2m1u
 /Ny3haL4Qm4tA2pVrrLhgCnYUxYgdjK4dUJ0I28EaX1eUUzPdNTbDQiwfF8LV5nahDHo
 S1ZXE8pTtE2jKy27pRzr/geju4FcbrSt5sqCkxLpz9o9DUae9ZfNxlg5NaXE+gPD+0Hq
 xLCjZmwWm6WehBrC+ELIBByTZvEE360P2npDEY++M0rDF63Ui1lfd3KgOiEtgGIlCJqf
 Ifcjg7tPIQ/ygEDYfx/ji1oI53gFLT0IK7fH2K2p9nh3WnvaTu5MGF5oP8W/pRpk7y+u
 5pyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyhMjWKB1TSGzWsMthyTTjBn92JrtherdRnyaYirvG59NfReY5zEkmHq9lsDfOT45N7VIGIpc=@lists.denx.de
X-Gm-Message-State: AOJu0YysFDxATFeeVeYSpQExPiT7pf68CAX6QFZpZAPXSJpF/XPI/PkZ
 5AVzn2ILuy+FhuC8auXRYUqpVe4N/tqdXaTQWpyitGAF6C9dWL+PPINkdsLtDUo=
X-Google-Smtp-Source: AGHT+IE7DADOmh+8QdzbjGCZK1PNXv/vTQAn+J/KdNAy9GC3Fx+7QVgllkeLeTkmJ5Bsj3XclRJBhw==
X-Received: by 2002:a17:907:720a:b0:a7a:9a78:4b4e with SMTP id
 a640c23a62f3a-a8090d9684amr248712466b.40.1723161583766; 
 Thu, 08 Aug 2024 16:59:43 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:43 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:29 +0200
Subject: [PATCH 06/11] mach-snapdragon: populate fallback FDT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-6-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=rg6FOSTIuaN7QQZlGRJ0L5q042tTeo5rq40zvWz8PBE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvnzLpIzvVAgOqLAMcULso3v/l5UEUOs734y
 v6wpWR0AhmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb5wAKCRAFgzErGV9k
 toswEACk74v98PLIW22JoOOoMB0M0QCQRL+jRBXVgdPw/LvTMae5gFQoMlx38KWf3PiBx4C57Y2
 RJ67NpYRP5XYhaaAQonArmUikyDFj6KHcNB1SZIf/THDe51aS8LwUbk1Sx7VZ7S2JTMPwHmdbMG
 HSOxFG5UNpdFabY/x4jwNxEytHW55Ackr5iNMonMS5gQTLtRTXKtDRP8so+JkHXcYOtxqgnqtlw
 NcJg1v4XuO8cF8gyp+yEvUWx8z6s/l4JtqpdB/836fo9LsVfEMlK0c9cck9EL8oVJhCdyCxOjXf
 AiJ+HV9U9/fRKBE+5m03zvO8mMf6X5mSY6F+PY2k/Qk6oqsFlOOAJQ4UqQ5zklvhyvi3bRocu1G
 XcCwaOz7aohr5bPhkX30GPAyrETSaD4yechkrfKkZRpyXRpQTJexafO502r3saXNpGgG+2EQkAJ
 Rn36rvgJJyHLiO4mgPxQaX0zPw0l4n3bGWqg+a7ul0uRjyhqdbCSv+QQ96r2E78BCkHSQFJUU49
 D9v/k7I/JgqyTBjbExxtTRrY7sxT262CSWhMfz9FMB5i4A7Xv37yASf7dgmT1nzCQYYsQDyWdyb
 36K2hXqu7ZHi0ycUV9UYblfYfauFbkRHeL3Dd3V8CkmJ2QF91Z0A49ViMZHJPhZ6tRZrMbSXnra
 +WU5r0kTNGhhCMA==
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

Set the fdt_addr_r environment variable to a region of LMB allocated
memory, and populate it by default with a copy of U-Boots FDT. This will
be used for Linux if no other DT is provided.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 37925c40f36f..8c0c7394698b 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -423,8 +423,9 @@ void __weak qcom_late_init(void)
 int board_late_init(void)
 {
 	struct lmb lmb;
 	u32 status = 0;
+	phys_addr_t fdt_addr;
 
 	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
 
 	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
@@ -435,13 +436,17 @@ int board_late_init(void)
 	if (IS_ENABLED(CONFIG_FASTBOOT))
 		status |= env_set_hex("fastboot_addr_r", addr_alloc(&lmb, FASTBOOT_BUF_SIZE));
 	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
 	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
-	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
+	fdt_addr = addr_alloc(&lmb, SZ_2M);
+	status |= env_set_hex("fdt_addr_r", fdt_addr);
 
 	if (status)
 		log_warning("%s: Failed to set run time variables\n", __func__);
 
+	/* By default copy U-Boots FDT, it will be used as a fallback */
+	memcpy((void *)fdt_addr, (void *)gd->fdt_blob, gd->fdt_size);
+
 	configure_env();
 	qcom_late_init();
 
 	return 0;

-- 
2.46.0

