Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0459CC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 367C88749D;
	Sat, 18 Nov 2023 22:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P3FWu6LD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51E968711D; Sat, 18 Nov 2023 22:06:07 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8F68701D
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a94c550cc8so109835939f.0
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341556; x=1700946356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzXkcCSsp+slrCG+DPZ2tlV+JWyDgj/mkJQKg1tlBLs=;
 b=P3FWu6LDNhgwOdjBcVPEm915/Rb4QM7WAvKCavwBRzg19Y+iEFQVXTIFS79xckTWJZ
 XovByPlqyhgp5ZOXsdlwdTTL5zSxrB9oddtk2Pm1MxUK7teVEJlXaSvg45KClzk0b7Zs
 nyc3FnaZkWaxyS3SKnroWNgwbt5BMjsInDINM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341556; x=1700946356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzXkcCSsp+slrCG+DPZ2tlV+JWyDgj/mkJQKg1tlBLs=;
 b=ezfhwtU43JSyOxFbpP8rWhlgLbyeZUEZ8bgS8waSMMouV5py5Zlgdnz7rLJJggDTxf
 Y1rkhF2nJBLXYJ2kxwaoAdcKx52sc2fJNNnXFs9EXKs8M2qs64Onw0HsFFzs3sCLB2iP
 3I804sT7bpriWq3P6bxmYIvWB1YCJLLJPxpLU9nD57HKloWjvh8iaf2Mv7N1m+6QhqJz
 lGmoKWVFvPweckAlYlotj/OVgdle+lYcJOZ37lWG0dnF04S6Xcm2YRHDpHU2ff9wqXL4
 WDKNWpv99ydT9sPWHiBYgQksODIPEm9vQhIvvc1jt9zYArmHrVoF4q1c7qLQQEU7FPOg
 6y8Q==
X-Gm-Message-State: AOJu0Yw0jYE9JfaAMIpF3BYtiJdVS07ICidRB7ErtVo5a2lbjAVSo7s/
 M905IERtUxtRvjtcgl6DeU8F1XngVSo1/oqDjIGotw==
X-Google-Smtp-Source: AGHT+IFccAMmXDtJUd8kaAzZx9YxYzHPsz/2A3GeRTKY2Qqg2Ri37aqSD4PFZN4OHC4pwuwcSTYz0A==
X-Received: by 2002:a6b:e406:0:b0:7a9:5e03:a785 with SMTP id
 u6-20020a6be406000000b007a95e03a785mr3659312iog.15.1700341556589; 
 Sat, 18 Nov 2023 13:05:56 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:05:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 01/32] arm: x86: Drop discarding of command linker-lists
Date: Sat, 18 Nov 2023 14:04:49 -0700
Message-ID: <20231118210547.577026-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

Since we can now cleanly disable CMDLINE when needed, drop the rules
which discard the command code.  It will not be built in the first
place.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 arch/arm/cpu/u-boot.lds     | 3 ---
 arch/x86/cpu/u-boot-64.lds  | 4 ----
 arch/x86/cpu/u-boot-spl.lds | 4 ----
 arch/x86/cpu/u-boot.lds     | 4 ----
 4 files changed, 15 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index fc4f63d83489..7724c9332c3b 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -14,9 +14,6 @@ OUTPUT_ARCH(arm)
 ENTRY(_start)
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
 #if defined(CONFIG_ARMV7_SECURE_BASE) && defined(CONFIG_ARMV7_NONSEC)
 	/*
 	 * If CONFIG_ARMV7_SECURE_BASE is true, secure code will not
diff --git a/arch/x86/cpu/u-boot-64.lds b/arch/x86/cpu/u-boot-64.lds
index d0398ff00d71..00a6d8691211 100644
--- a/arch/x86/cpu/u-boot-64.lds
+++ b/arch/x86/cpu/u-boot-64.lds
@@ -11,10 +11,6 @@ ENTRY(_start)
 
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
-
 #ifdef CONFIG_TEXT_BASE
 	. = CONFIG_TEXT_BASE;	/* Location of bootcode in flash */
 #endif
diff --git a/arch/x86/cpu/u-boot-spl.lds b/arch/x86/cpu/u-boot-spl.lds
index a0a2a06a18cd..50b4b1608552 100644
--- a/arch/x86/cpu/u-boot-spl.lds
+++ b/arch/x86/cpu/u-boot-spl.lds
@@ -11,10 +11,6 @@ ENTRY(_start)
 
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
-
 	. = IMAGE_TEXT_BASE;	/* Location of bootcode in flash */
 	__text_start = .;
 	.text  : {
diff --git a/arch/x86/cpu/u-boot.lds b/arch/x86/cpu/u-boot.lds
index a31f4220a000..c418ff44aa08 100644
--- a/arch/x86/cpu/u-boot.lds
+++ b/arch/x86/cpu/u-boot.lds
@@ -11,10 +11,6 @@ ENTRY(_start)
 
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
-
 	. = CONFIG_TEXT_BASE;	/* Location of bootcode in flash */
 	__text_start = .;
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

