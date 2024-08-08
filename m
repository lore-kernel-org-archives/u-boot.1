Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6AAC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 05:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA05F8871A;
	Thu,  8 Aug 2024 06:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="cgEH4Yn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F324E889D5; Thu,  8 Aug 2024 04:14:53 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C09885AE
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 04:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=tenstorrent.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=antonb@tenstorrent.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-66ca5e8cc51so5336857b3.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 19:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1723083287; x=1723688087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PZgf3NLEaDkLjiX8Errn9QyHLiOI+1dz39haZseoZqA=;
 b=cgEH4Yn/pKKsZVtnpUQuiOud7r9TJAFTQdFOvPfZ2GWMcAAnU5tYeqD4nPHDjSVWHz
 k5muDRBx9TZX5DqOVeuHZEM0Y6/h/shVyuUWF46K1xuAFgEYgbLRZzS/8HdjD3PnghU0
 wBI1S4L+LBCGcsq6cCIRSOR+0pGpjauWZNx2KeM6tu2Ba2CoKAxUg3YSk7k0cSoLbFFw
 VNx5gDMmLgm/59G1to0znDb1g9PpAIOOgbEQDzXtQJwS+rYDPwaB6wuWXkKXc48f9ht+
 hrjYYoLiOXWVaBbFWTr7zh1gr4SGqYivv3I9tO2FomuPua9Xk5yiTl9L3qyz1AoMXjSP
 GsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723083287; x=1723688087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZgf3NLEaDkLjiX8Errn9QyHLiOI+1dz39haZseoZqA=;
 b=ZwbOenVuImI2b6cGBMPYx964U016Y/JvICHZuIJpqMlddNum/Rahd8VnSJ3urpkJh8
 M8VDqQ6MVCLdUsKGEn4zNTLeJVPxnDT2Z8qC4BpFRdL6S0uNuum4kNnSIUYZonRcOO03
 k9bb//Sykm6HIAOY1cz3AI3zvMx2raRlAXpjVGJw8fAcXV0KoxdSYIz5Qh1gSzyq9hW0
 EOb8njWtdz3rZmGh5wF6cmwlfcKh3XwB8UbWEykz3rTgc2F4oSgy2YeWZQ5L7DxpM8Zq
 /y+MXUkhEXGqQcLhxJSjPlbMuguKoiaQCwSxbuTOffoE8EnVm1UzVnW4vDej5UsuQkC3
 gN9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6p45Z2FQYoW7PtUC5smnodzACXdpreXJeN2kIMi9x+1vkCTmg5TMCzqlXQoU5g8iEO0AR0/G3nMMg41catlUBugz7QA==
X-Gm-Message-State: AOJu0Yw3ZW42UEO5yt3orPcqGcEROoFrvmIMbdfClf2tGq5b8NXmzvKg
 gqtCEgoB8rzL5kqUf2WDD7CDwlhtMbxEnHFkrN0eX45Dj/dZjkLtix+va3/yw6E=
X-Google-Smtp-Source: AGHT+IGd+blXCKLVxNtWVy3Fqr2uJNRSIl8ve8y4elOHm28Amb7Yei6JhkZYnwp+RkflEGUFQ0kv2A==
X-Received: by 2002:a05:690c:2786:b0:65f:dbbd:6a7a with SMTP id
 00721157ae682-69bfc3739d5mr3142557b3.46.1723083287552; 
 Wed, 07 Aug 2024 19:14:47 -0700 (PDT)
Received: from ausc-rvsw-c-01-anton.local.tenstorrent.com ([38.104.49.66])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a3786fec1esm110853185a.134.2024.08.07.19.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 19:14:47 -0700 (PDT)
From: Anton Blanchard <antonb@tenstorrent.com>
To: rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 sjg@chromium.org, u-boot@lists.denx.de
Cc: Anton Blanchard <antonb@tenstorrent.com>
Subject: [PATCH] riscv: resume needs to be a global
Date: Thu,  8 Aug 2024 02:14:17 +0000
Message-Id: <20240808021417.1174390-1-antonb@tenstorrent.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 08 Aug 2024 06:59:58 +0200
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

If we take an exception before u-boot is relocated, there's a good
chance we will end up in an endless loop of exceptions because resume is
invalid until after relocation.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
---
 arch/riscv/include/asm/global_data.h |  1 +
 arch/riscv/lib/interrupts.c          | 10 ++++------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/global_data.h b/arch/riscv/include/asm/global_data.h
index 593d9276d3..d356752a56 100644
--- a/arch/riscv/include/asm/global_data.h
+++ b/arch/riscv/include/asm/global_data.h
@@ -42,6 +42,7 @@ struct arch_global_data {
 #ifdef CONFIG_SMBIOS
 	ulong smbios_start;		/* Start address of SMBIOS table */
 #endif
+	struct resume_data *resume;
 };
 
 #include <asm-generic/global_data.h>
diff --git a/arch/riscv/lib/interrupts.c b/arch/riscv/lib/interrupts.c
index f9a1428a48..a0e069e749 100644
--- a/arch/riscv/lib/interrupts.c
+++ b/arch/riscv/lib/interrupts.c
@@ -22,11 +22,9 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-static struct resume_data *resume;
-
 void set_resume(struct resume_data *data)
 {
-	resume = data;
+	gd->arch.resume = data;
 }
 
 static void show_efi_loaded_images(uintptr_t epc)
@@ -140,9 +138,9 @@ static void _exit_trap(ulong code, ulong epc, ulong tval, struct pt_regs *regs)
 		"Store/AMO page fault",
 	};
 
-	if (resume) {
-		resume->code = code;
-		longjmp(resume->jump, 1);
+	if (gd->arch.resume) {
+		gd->arch.resume->code = code;
+		longjmp(gd->arch.resume->jump, 1);
 	}
 
 	if (code < ARRAY_SIZE(exception_code))
-- 
2.34.1

