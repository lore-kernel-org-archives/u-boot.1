Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14922C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2CC783197;
	Tue, 29 Jul 2025 17:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EPuphz+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 938CD83197; Tue, 29 Jul 2025 17:50:45 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D2C8319A
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4561a4a8bf2so63030335e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804243; x=1754409043; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y6K0JLA/MOAR6rzgPS/WIlBLo9llbO/sRy1UBUSYfsI=;
 b=EPuphz+rodaTwiqQFJfTpBbPcP6Mgfj3Qd/PyP4eEHsozOsH0BuSTwzOZ7nlDQBfat
 zEIEYPQ2vCUeC8n97CPwJS0WoF2EZVm1wjxHtEoHPAL8wpApOFBSRmHftp/NR723tl/E
 lXZiVYMLqnlSLahff5OtIaZYtrkaT61rEGANqjIXQclZRXboEG1XQKmi+mWZst3kycHt
 9GBgKpxToWdqkN4lKtGibKfjjUfEz/AX3eYBkELVvR6ydkP8klkowaWU/lfZf3HENsdt
 mJ/WJrUZ9y5HnNgnzw3mmvSQ/fafIWyfumpLyjldA84wKkTvO6oJF7Ehgbv2xNx8/B2j
 DNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804243; x=1754409043;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y6K0JLA/MOAR6rzgPS/WIlBLo9llbO/sRy1UBUSYfsI=;
 b=uGBXyOCBDCN32jb0p/FEwbD7jam3vXSY9zsN8d6Rap4JE99kveBScXIkswQskHHGWM
 DYKGDvn+yhY5kkehXEySIav9ngAPvd+lXp1fBq9gawWdsJKF1kmSA0RW8DRVBgj79iPj
 KGsUzZZ35ne3qYyvXT6n6MYDkJycbPhiqILnRdjc3FvwVUoOLa5hTNf/hffZj1hFpL7i
 kwgATNxJXyWDTtpRJsBGEpIk1XT+ot8i1augCfHGM9jK7ZJGR82Bn7bb/Mf3bGH3ODy3
 UV4jcnXOS6NfQ0EWwPYkzUsrlZ2R+y5/xtKi1PGSbT2arPH6gSHE4l9S15qReZ6Gnmn5
 Fllg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrBigGfxHWlFlsxiOsPBMCEp47pfdb/wEiBQb1cIxW7BfDbd5lr+HR6cGlYSScDl3XrmmptAc=@lists.denx.de
X-Gm-Message-State: AOJu0YzqW83yYXrEb4/3OZ650BpvCWId17IREoUKavE4bEArtFOQ06H4
 gXhFRdKNTXEGBnxlhjpAGba+rQ69SnmtVTj0ayNRXW0abe+fVXoylK8XgJO+9TsKoGs=
X-Gm-Gg: ASbGncsc3HXeWKQwIyxH7dcuYH83OTDMaTJx/STRh3riY3ZnbwNWBwPBM7t6CEdQFzC
 n2SHlklNdAsz524SALBmTfbjskNjEuoa4eYsBEXsKHGr4pg2pRuYg8rrZ/B4Hxn4KBXXI3PfBJr
 y6Kpaask2+hIqxVQw+UiejGerORD19d0AbS5H0QbhNkRm1Nl2dNRpmuff5vw1UIMO9V+HgS2Mh9
 +kVfmeBRKeeAsWdtcFT1q9FoqkyGMKOYdFBck9zi/OT8a2hPmEyW5OmycaNTTzMPDW4kOGDn48Z
 hfwCdSmGnBE8hDREWIt9kDBmrdO8rpcIb3ojny0C3A6y00FUrDT2eaFyopQKoas4YftvgYtTmkP
 C6W2J9ObAtjfKFOI7qFBz2vABDK0UviM0vHAPTv7Xi4T74FAaSGhZ1Xh1tORqeIUYl6n3MNRhl2
 oaUy9cKhoKHA==
X-Google-Smtp-Source: AGHT+IEa9i1TDuKI03VDyKYmV6GjehX8pZL2DOyWvQtsZoTomXpauE8DgdSyZRNpDbbNeTzVvAmwmw==
X-Received: by 2002:a05:600c:4e91:b0:454:a37a:db67 with SMTP id
 5b1f17b1804b1-45892bc5ff7mr3045475e9.17.1753804242870; 
 Tue, 29 Jul 2025 08:50:42 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:42 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:50:07 +0200
Subject: [PATCH v3 09/10] lib: expose unwind_stack() and call it from panic()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-9-6f258b34fe8c@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3686;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Hn5uUJbh5+36uuRZfF3la88uufwudb7fNyvQPNPEsz0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2riy9LZQxLCDJrC5Q2wPgZVBjKTLJYkD1G2
 NEWcOzXEISJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqwAKCRAFgzErGV9k
 ttd5D/9j0rDn+7D9pzBLIPh2dCx28JSj1nbMTAq+8fRCQtX6bSYW1YuGik/+RxfSxSOWUxD0HY1
 0nMx1maJkL++kqWQzmTlcV5hQmeUkTd/hw3QbiYZilufJKsYJizFhSvCRp/pybskRvVtoj6LoX7
 90VcB0fuwZNvh5UxuMm3fHyfgR15dyv6gAj9VGsXn3VjBQOeGqY6aDvmI9Ggu9zZcR24JgRMa8g
 UyHcLXoqNWijYWfM07NyKMjzuRmZxpYrpIDOgcP8vIJqHvOW2MzmAiwkVcwq0oks6VVOV23ewcZ
 8+z7HsBwxSDvh8haTOuZm9mTLp4pVwvealFbvq24+dkY6V6CoVdSdOrT/ZTA67h1UHIVPBN+BAf
 ZBBM7SZxSI31ibgfuSe/Vp2gP4eVa0zKK9aOkqzGt1WJplLWlvtt7/wMfpA8ZxTUmB/kcitupfM
 GJ1HzBjOQKZs4BA5NflVjLR1M7ZU7swpImKG1XkHTyx1iQNW6Lo98StF2Ud1OK0o5hSX9tFHmCG
 ZawoLmOMJq9jXz/7ZyEwAta5gLGbMvgYIRAAG39DtQzyxi9iJgYnM69atWsaPCSBeW1AdDgJdYk
 aqewwRHeE7d0klYbB5BDhxfOzLwSQFRQk+KkTDqZrpUpS+Z2tF7JX+Dv8k8zliy6kHwRjgIRukh
 0BWg2D/xQAZPXbQ==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
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

unwind_stack() will walk the callstack and show the symbol names
if available by using the architecture-specific framepointer
implementation.

When available, call unwind_stack() during a panic to give more
information about what caused the panic and help with debugging.

Adjust the interrupt handlers to call panic_str() to avoid duplicating
the backtrace.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/lib/interrupts_64.c | 8 ++++----
 include/symbols.h            | 9 ++++++++-
 lib/panic.c                  | 7 +++++++
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index 0f8ca7d343156bd53688bf4a0acd9437f041f8f5..dcba82b560d3be73233674d9b657767d8641a76e 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -114,10 +114,10 @@ static void print_sym(unsigned long lr)
 
 	symbol_lookup(lr, NULL, &offset, symname);
 
 	/* Print the symbol address and the offset to the LR */
-	printf("\t<%#016lx> %s+%#lx\n", lr - (gd->flags & GD_FLG_RELOC ? gd->reloc_off : 0),
-	       symname, offset);
+	printf("\t<%#016lx> %pS\n", lr - (gd->flags & GD_FLG_RELOC ? gd->reloc_off : 0),
+	       (void *)lr);
 }
 
 /**
  * show_backtrace - show backtrace using frame pointers
@@ -233,9 +233,9 @@ static void except_msg(const char *msg, struct pt_regs *pt_regs)
 	show_regs(pt_regs);
 	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
 		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	panic_str("Resetting CPU ...\n");
 }
 
 /*
  * do_bad_sync handles the impossible case in the Synchronous Abort vector.
@@ -284,9 +284,9 @@ void do_sync(struct pt_regs *pt_regs)
 	show_regs(pt_regs);
 	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
 		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	panic_str("Resetting CPU ...\n");
 }
 
 /*
  * do_irq handles the Irq exception.
diff --git a/include/symbols.h b/include/symbols.h
index c5267edbe768f304bc0f6235e71a39b6c3835a67..845f993060f042139df46bcc51a0180faadc35bc 100644
--- a/include/symbols.h
+++ b/include/symbols.h
@@ -4,9 +4,9 @@
 #include <string.h>
 
 #define KSYM_NAME_LEN 127
 
-#if IS_ENABLED(CONFIG_SYMBOL_LOOKUP)
+#if CONFIG_IS_ENABLED(SYMBOL_LOOKUP)
 const char * __attribute__((weak)) symbol_lookup(unsigned long addr, unsigned long *symaddr, unsigned long *offset,
 			   char *namebuf);
 #else
 static inline const char *symbol_lookup(unsigned long addr, unsigned long *symaddr, unsigned long *offset,
@@ -21,4 +21,11 @@ static inline const char *symbol_lookup(unsigned long addr, unsigned long *symad
 	namebuf[3] = '\0';
 	return namebuf;
 }
 #endif
+
+#if CONFIG_IS_ENABLED(FRAMEPOINTER)
+/**
+ * unwind_stack - unwind the callstack and print a backtrace.
+ */
+void unwind_stack(void);
+#endif
diff --git a/lib/panic.c b/lib/panic.c
index 0f578b5b5131589d215f5f4b16b95d9c9f3e8ce3..6f8bd7cc1eef7e5d97ba925bef65cc46924b4418 100644
--- a/lib/panic.c
+++ b/lib/panic.c
@@ -14,8 +14,9 @@
 #include <command.h>
 #endif
 #include <linux/delay.h>
 #include <stdio.h>
+#include <symbols.h>
 
 static void panic_finish(void) __attribute__ ((noreturn));
 
 static void panic_finish(void)
@@ -44,8 +45,14 @@ void panic(const char *fmt, ...)
 	va_list args;
 	va_start(args, fmt);
 	vprintf(fmt, args);
 	va_end(args);
+
+	if (CONFIG_IS_ENABLED(FRAMEPOINTER)) {
+		puts("\n");
+		unwind_stack();
+	}
+
 #endif
 	panic_finish();
 }
 

-- 
2.50.0

