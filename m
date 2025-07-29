Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C22C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640928320C;
	Tue, 29 Jul 2025 17:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ujNmpmN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF6F831E4; Tue, 29 Jul 2025 17:52:57 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54890831BB
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so53369955e9.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804374; x=1754409174; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0kCY89KGKiEAE0pE8jXEx0PB/aN9TrUhdpshpKiW8IA=;
 b=ujNmpmN6Jn93xoFo77FLfl+E0z1uSciZ0lihWWG3Sfym5nOXidD5RR082+IWd+X0QL
 4JYJN4Of3B+JRONNxy9goQyzKLtmK9Eu+c38APfPG6xVFifJS881auuE7wR3OEtm9F/J
 xgfWYpW3IwDTfnUAWuCheP3UK0y9ss9qyd4frObrC8fqKaAsZtbopZ9Sy9y03E+SPqn4
 O7kJs3j1QtL99wMv5fZMniqisatcY+A9SH6M6gEyjFVeiKg/0vE/YeRe0wjjNfIfsWHe
 xfrkRSQ66HAInAzxdT4AcujTY8ozmxVNFw3XY3eNturVuCx7ErOv/NOsYtL3ksm94lfP
 JH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804374; x=1754409174;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kCY89KGKiEAE0pE8jXEx0PB/aN9TrUhdpshpKiW8IA=;
 b=wDEqo7RuZ6SgPOruk4PjQHdHM9Y8mY34yxWhCJvBn1SRbLFYLKuFoXvkswPryMV+Mc
 qvbfbKFTrRG5wjrhU1VHhRSOSeY6Kl+ZLyUNauBUapyW1Le+DtwU+Bk//hf6FTRgBMTg
 ZTRLFFoLtC6TJiLIqHFx5yWbPu43b1E/rNhvfsaH0TyfAhHKOv5Ra2nEf/I537Y8PZxg
 YoRr/dV1UQtWM7jgxtAym6ReaFQsX3cHSxQ+p7e2w0a7wrPVloqsw7W7SiZs0e+NEJJ7
 yED7g8kiifq6ToLnC/kV9SZtUtqk2Tzv5KYEB8qPv/YofSwHViaa7/Ho1KAxl8UPYLeW
 zIWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEdjsrgKgW2h7P/HtmvhD61BVhq30dcuaaYLjpXlJ7qLLbt2Q6BmkwLxBCHGDVlRCnT7sRN8Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4d9aiMRi3d3Y4luVaCiui8FMQ/iUITa3rkpV47esEmjNKDV6/
 pC5KfJzHhoLB7TViNSRqwhtvRc/g3vcnWoEzvLv+CPfPCS4V0S8ZPFW4LB3Im9zH9ZjYkvDPhlD
 3K7e9
X-Gm-Gg: ASbGncuhYXv8BbXtwVcfBJ4QB5CX/YcFT0dgf4+Augvf0r67BCgeNaCTxsYxpaqxk4p
 QLu/y6RMgS6hsUCdTJ7seHn1quk32OwRW7MqwgbD7odPsAK/UiXgcxQgzsCV5Q8tV0WnDjEo7iT
 K3EjvYxoGHEPRkJhvOJ0znF50xq+teS7jmfIqZm+vzEgH7qNnw2eGm1oPHrbIUxDOkeBJXjF0iV
 HAdv//mhqAvIVTCfnUiMtH/NwUjZbmjmGPmCMGxAO/HHZWRyklK7Zdzvfwsqwk5C38tk/SDczfc
 1xyXxymKABCCbPNiAN2Tj0iLvrbToUadMxfqCjG62ERkvyJg9NhRkwsKt3uVv7+h0w2OAGFp6It
 s6WegKmDGSVh/8udHFXcyv62M67sKUCCkfe/pipsq4FFR4mYAJKOU848H5cJQ+s8ahbI9mr8umj
 o9zGZTQlU5UhNttUgSLjPB571AEr5ldcw=
X-Google-Smtp-Source: AGHT+IGOCG5sL3fcmKhDfkRag9zPhRTFwXCxiQf2qsmOFhEnr0le0noqFdiMDCPGE/vlGmRAPhxrjQ==
X-Received: by 2002:a05:6000:2003:b0:3b7:886b:fb8d with SMTP id
 ffacd0b85a97d-3b795026234mr107328f8f.31.1753804374395; 
 Tue, 29 Jul 2025 08:52:54 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:53 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:52:07 +0200
Subject: [PATCH v4 09/10] lib: expose unwind_stack() and call it from panic()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-9-8d8bda8e22c1@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3664;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=8NNVe4Djqcx3dshqmzh5gNAE3JvDvAKB3ImiVXLSrks=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4k+hsMZCgYeiT74VdGbwAtqYmdDFRmuxUn1
 fPqm3i1pMqJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuJAAKCRAFgzErGV9k
 tsRzD/9hMjyHYewvETnYw8MGD4UxiT+h6UeIOW+AcdtJOkHh2ATKtNN5NjOnQDdrNLuOoYaDuI/
 cejar0BpvHm32aLR3vSEYjap1vuStW2JBODbRj86zLtWpjsgYy+BgUKB3BhOxbzd9j2kGW1j3JJ
 uYLRso8Dh1rPJrS3zdS96y5sdxze+Zoa0FJQrongqaPsZaqWGeUhawSB6ddUauNI9xFaSz8VlAr
 gJRruTOydsc17UyORJoGMy/Xfnmv+8fHgJL7ILYRCwSZ14xBqSdbJxv7oDchaADWYACSAcokckL
 557Hn7JuAl+dMnlp+m5vLNoUvDnYL3CdP14qTHnQwf+zaAh6/MyIlBYAPtm6tXoXRZOLN7oBExC
 f1egWLxi3vddrs+4hvA4MbeSj4fkGjkigQL/uFpzOmULTIZeGa2DkVpAuryU4yuALm9RSpGsTBA
 UPjOgrInbak7BX2rvOOWdiYBqHu75py2Gsi83kbsu9PIyTzgeYaEvTTE+MiXTWuRMHJC3ma10Me
 W7M0MeyW25SEqDvLrEnOAek646kPEQA1ulRUxY8vee5WzgDHwyYFH3Cm1KVYJqyvt+95ZX8XrXE
 t4yJBHYO/5g7wjr/01uK59tXPsyc0rTdFjc7XTSUfvbDk44ewqTu/hMHNHOp6Ry45j4TR1QAHIA
 /YNnnkcJ3LnjOdA==
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
index 08d81ca7f654c586521ff97bb5ca37229c9b939d..949ae0f94168fd53036c1dff376b574808ebf9ea 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -109,10 +109,10 @@ struct stack_frame {
 
 static void print_sym(unsigned long lr)
 {
 	/* Print the symbol address and the offset to the LR */
-	printf("\t<%#016lx> %s+%#lx\n", lr - (gd->flags & GD_FLG_RELOC ? gd->reloc_off : 0),
-	       symname, offset);
+	printf("\t<%#016lx> %pS\n", lr - (gd->flags & GD_FLG_RELOC ? gd->reloc_off : 0),
+	       (void *)lr);
 }
 
 /**
  * show_backtrace - show backtrace using frame pointers
@@ -228,9 +228,9 @@ static void except_msg(const char *msg, struct pt_regs *pt_regs)
 	show_regs(pt_regs);
 	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
 		show_backtrace(pt_regs->elr, pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	panic_str("Resetting CPU ...\n");
 }
 
 /*
  * do_bad_sync handles the impossible case in the Synchronous Abort vector.
@@ -279,9 +279,9 @@ void do_sync(struct pt_regs *pt_regs)
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

