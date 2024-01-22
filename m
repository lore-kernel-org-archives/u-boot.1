Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAD6C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 14:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B05C878A1;
	Mon, 22 Jan 2024 15:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FLtC1Yfv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E49F08792C; Mon, 22 Jan 2024 15:35:17 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA0787872
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 15:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6001449a2beso4208127b3.3
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 06:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705934114; x=1706538914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pcpQJsqIq942oD+tplzMjOB1gHb9foMqIIgHWHPKYzI=;
 b=FLtC1YfvKK69/7FO8oqszA+kMNWewys/ahSW5aaXN8aEJIgv0TETeoEQYHoSvv1fHB
 hIasfki6PuOAaVKcRNtqD2NnTVHq7cHnAcFVcsprFmkFyJ46601EVFXdaEed5yR8Z3B+
 ov4Et2ajwNrorRQq3C2ED9ub6jdx68EGLtFzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705934114; x=1706538914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pcpQJsqIq942oD+tplzMjOB1gHb9foMqIIgHWHPKYzI=;
 b=lFKXKWVb7LZxO6/U4sSl8RtkKDBEJ/WH91OSkEVNZN1dnZtF8yYFU5uwNW7dOSp1ed
 Tu8lX99Ffgc2dYgdLHMnvWix+gaR1KoWfYkS0U215sr5EhMtj2mgRVFf5ksPVIsiHI+L
 mCArgNZqHZy3+yOdcZoHPoRzY9gnBWU5CUMnfUGDltXiLbi2z6t+1W5l7l7FV8RY1FUN
 xj+9cmOt8U+wOQzUzH1B0nwBwYTXJ+rS8H64vIbCan5Qn7SqRKPdoXc8IUxB/s0YmlWD
 RJyOMp2FKVQ1x2fLJmxAcgnJfOTEXmPxlQ5HY5LXoplyQdm0+ZvXDIdJl7ZZ6MW5uL0v
 4TIA==
X-Gm-Message-State: AOJu0YzQa4Se4gZz5gzPqTgcklDHCghwDXtFG/3IqKaUTbH0Ea337swo
 tKey6uddFzZEBiZIx/BQoUCWtFsKx52/dln1Rr8rn41t/ojIWiBUN+jhk07gsDN98IQA3T6Taiz
 7
X-Google-Smtp-Source: AGHT+IFXwHxicsQ9gqiGMBz2rU/sU1lgMuabLeOhqlgGn4PmjCwa0iwhmfuNrjJfwzYkSv94rNbGbA==
X-Received: by 2002:a25:1988:0:b0:dc3:6990:99eb with SMTP id
 130-20020a251988000000b00dc3699099ebmr371142ybz.55.1705934114184; 
 Mon, 22 Jan 2024 06:35:14 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 i38-20020a25b226000000b00dc2203ad7d3sm1597342ybj.21.2024.01.22.06.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 06:35:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH] x86: Make default_print_cpuinfo be a weak alias for
 print_cpuinfo
Date: Mon, 22 Jan 2024 09:35:12 -0500
Message-Id: <20240122143512.196907-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

While a few SoCs have a unique print_cpuinfo function, a number of them
just use default_print_cpuinfo. Make default_print_cpuinfo have a weak
alias to provie print_cpuinfo.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This will make re-using arch/x86/cpu/efi/ as a generic set of support
code for U-Boot as EFI payload/app a little bit easier.

Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 arch/x86/cpu/coreboot/coreboot.c             | 5 -----
 arch/x86/cpu/cpu.c                           | 2 ++
 arch/x86/cpu/efi/app.c                       | 5 -----
 arch/x86/cpu/efi/payload.c                   | 5 -----
 arch/x86/cpu/slimbootloader/slimbootloader.c | 5 -----
 arch/x86/cpu/tangier/tangier.c               | 5 -----
 6 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index 82fe4c71cd27..5c8d32ff6acd 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -44,11 +44,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
-
 static void board_final_init(void)
 {
 	/*
diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index ce55efc454bf..5090f5cad746 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -165,6 +165,8 @@ char *cpu_get_name(char *name)
 	return ptr;
 }
 
+int print_cpuinfo(void) __attribute__((weak, alias("default_print_cpuinfo")));
+
 int default_print_cpuinfo(void)
 {
 	printf("CPU: %s, vendor %s, device %xh\n",
diff --git a/arch/x86/cpu/efi/app.c b/arch/x86/cpu/efi/app.c
index f754489784a7..0eea9e2b0975 100644
--- a/arch/x86/cpu/efi/app.c
+++ b/arch/x86/cpu/efi/app.c
@@ -19,11 +19,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
-
 void board_final_init(void)
 {
 }
diff --git a/arch/x86/cpu/efi/payload.c b/arch/x86/cpu/efi/payload.c
index 708bfbe7ee48..2bf4fefc19e6 100644
--- a/arch/x86/cpu/efi/payload.c
+++ b/arch/x86/cpu/efi/payload.c
@@ -144,11 +144,6 @@ int checkcpu(void)
 	return 0;
 }
 
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
-
 /* Find any available tables and copy them to a safe place */
 int reserve_arch(void)
 {
diff --git a/arch/x86/cpu/slimbootloader/slimbootloader.c b/arch/x86/cpu/slimbootloader/slimbootloader.c
index ec5b87cfd63f..1f98db1f7c77 100644
--- a/arch/x86/cpu/slimbootloader/slimbootloader.c
+++ b/arch/x86/cpu/slimbootloader/slimbootloader.c
@@ -55,8 +55,3 @@ int checkcpu(void)
 {
 	return 0;
 }
-
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
diff --git a/arch/x86/cpu/tangier/tangier.c b/arch/x86/cpu/tangier/tangier.c
index 1e2f6cc8b700..35bbecbf8479 100644
--- a/arch/x86/cpu/tangier/tangier.c
+++ b/arch/x86/cpu/tangier/tangier.c
@@ -20,8 +20,3 @@ int checkcpu(void)
 {
 	return 0;
 }
-
-int print_cpuinfo(void)
-{
-	return default_print_cpuinfo();
-}
-- 
2.34.1

