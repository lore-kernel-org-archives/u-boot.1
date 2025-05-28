Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7870C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B06083A7D;
	Wed, 28 May 2025 14:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qa2lXH4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A17983AAE; Wed, 28 May 2025 14:33:49 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 277EA83A70
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3d6d6d82633so13016335ab.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435625; x=1749040425; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+sEIV3pc/3kgMkt4HtCjpor2NMO8iEUeULduRqYupkE=;
 b=Qa2lXH4UZKxfMPreuK2ifJYKEC2V+uEjLzV/LMdoUOEGqEyT06g1MHeQTV3uBp6xfg
 ZNOf708p8/XiFbmZBxVc4Hx1w8cGw2c0ETweilfDmovIyKIJpd3+z/to4ZIY9Kr1t6qW
 FgEfhhswFpNkeB4PGSOR+P01JzKdZm7B0FFys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435625; x=1749040425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sEIV3pc/3kgMkt4HtCjpor2NMO8iEUeULduRqYupkE=;
 b=pUFuD85gJsGvHETGC0/vxfqXixn9kaK88xyFfCZ14UfIRQeQbvs98SYPJGleHhpDfe
 BB7UsElzpVA6/LtWbkg32/qdrBoYQ7xnOCg2SwTN3wCLT3bbs9GVZJ2Ch8Zy/k393TtT
 Mcmw+oDG4sPF+T4gCNbrvLHPcpY7XNMPzYZ2QS9VkTfDQnmDuow3fJEOjHp8OUeQO04J
 QQ28J/wpcaFNicJ30dmkARay9gbJ2WQS5STMjIh+4SnAbrRBQkTgOAUUPqPGvsjUuX6b
 EOuojexhMmgWofCz2e3khZTfnCjSB9DzQubZhW/W8rhQBSSawRsQuTSON4VVUcte3ONw
 OJKA==
X-Gm-Message-State: AOJu0YwS5jnMdXo9HkdvNF/dqrLEgPYrsY3vK3j/bCL3fYN1ShHXK0w7
 mvHhCuCizIR8cBMRw/3axmjD+mVhl0CddS2bELXobqUjQkVATDQ08GRiAvJjI4FFeGLX8VOfPVB
 2tXUQHxHk
X-Gm-Gg: ASbGncsMih1AdGha0yIPDTrCIrPRokCyWDtuCWp13xA0HVMtSl+mRt2l+uky8rWJxlW
 BpQcyqM18Dr3Cj7S/yC1jPo/XTq4gF/hm6FOYAeVtlvZREhKpaxVp4U4a6fU+2mjXRNt9b7GtZJ
 E67ZDp+2KOxoBV7Th7wrtWUBA8HVWSmy+mzqQOme5ryNkWuLcVNdH5ALqlYSKf53WWEtwiZj7rp
 oQVsXvsRvYFxpmhGXg2LcMckwY8YgejUxdsqZtJF+S26Dh3aw0obPxsdBcVCUAeC1n1IuuyO8iE
 a7PcqJuYCC4xMBxmy2hUH6DNmOoCINkx+DapOeWguQcwvNHUvuuXtFmFEm7iA60cYALen9zIqzO
 bccG9l1KK7Y5z
X-Google-Smtp-Source: AGHT+IHvrAOFjZR5BRppG8Pu1hpbUGFAjXAzzN1SVqTVT+OtyNZIAyxWidWFs+JJ1UYsEwk8R2mutA==
X-Received: by 2002:a05:6e02:4410:20b0:3dd:752f:53c3 with SMTP id
 e9e14a558f8ab-3dd752f5827mr74371445ab.6.1748435625224; 
 Wed, 28 May 2025 05:33:45 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v5 15/25] passage: arm: Add the arch-specific standard passage
 impl
Date: Wed, 28 May 2025 06:32:17 -0600
Message-ID: <20250528063224.v5.15.Ie42090adf599e2b0ceb782298be5278b493f6beb@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

Add implementations for 32- and 64-bit ARM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Update registers to match the Firmware Handoff protocol

Changes in v2:
- Add new patch with the arm-specific standard passage implementation

 arch/arm/cpu/armv7/cpu.c | 18 ++++++++++++++++++
 arch/arm/cpu/armv8/cpu.c | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/cpu/armv7/cpu.c b/arch/arm/cpu/armv7/cpu.c
index 8082f369ed6..f1b07c414de 100644
--- a/arch/arm/cpu/armv7/cpu.c
+++ b/arch/arm/cpu/armv7/cpu.c
@@ -17,6 +17,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
+#include <passage.h>
 #include <asm/system.h>
 #include <asm/cache.h>
 #include <asm/armv7.h>
@@ -87,3 +88,20 @@ void allow_unaligned(void)
 {
 	v7_arch_cp15_allow_unaligned();
 }
+
+void __noreturn arch_passage_entry(ulong entry_addr, ulong bloblist, ulong fdt)
+{
+	typedef void __noreturn (*passage_entry_t)(ulong zero1, ulong mach,
+						   ulong fdt, ulong bloblist);
+	passage_entry_t entry = (passage_entry_t)entry_addr;
+
+	/*
+	 * Register   Contents
+	 * r0         0
+	 * r1         010fb10b (indicates standard passage v1)
+	 * r2         Address of devicetree
+	 * r3         Address of bloblist
+	 * lr         Return address
+	 */
+	entry(0, passage_mach_version(), fdt, bloblist);
+}
diff --git a/arch/arm/cpu/armv8/cpu.c b/arch/arm/cpu/armv8/cpu.c
index 82ecf02f4b0..275aa2501f1 100644
--- a/arch/arm/cpu/armv8/cpu.c
+++ b/arch/arm/cpu/armv8/cpu.c
@@ -13,6 +13,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
+#include <passage.h>
 #include <asm/cache.h>
 #include <asm/system.h>
 #include <asm/secure.h>
@@ -99,3 +100,21 @@ void allow_unaligned(void)
 {
 	set_sctlr(get_sctlr() & ~CR_A);
 }
+
+void __noreturn arch_passage_entry(ulong entry_addr, ulong bloblist, ulong fdt)
+{
+	typedef void __noreturn (*passage_entry_t)(ulong fdt, ulong abi,
+						   ulong zero1, ulong bloblist,
+						   ulong zero2);
+	passage_entry_t entry = (passage_entry_t)entry_addr;
+
+	/*
+	 * Register   Contents
+	 * x0         Address of devicetree
+	 * x1         00000001_4a0fb10b (indicates standard passage v1)
+	 * x2         0
+	 * x3         Address of bloblist
+	 * x30        Return address
+	 */
+	entry(fdt, passage_mach_version(), 0, bloblist, 0);
+}
-- 
2.43.0

