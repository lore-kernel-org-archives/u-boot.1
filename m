Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C89C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C151182BA7;
	Tue, 29 Jul 2025 17:52:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sC3brYx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45FAA8311B; Tue, 29 Jul 2025 17:52:36 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40DA081E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45611a6a706so26912935e9.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804353; x=1754409153; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9fiiMiVJRf1i31Avgztmf9WmZhaG7v+AEL3q+uQl2no=;
 b=sC3brYx98dRsJvkS9ZnXiBH0eTtfKJ25LRDuTwyxV6cqXM/noIPP1m4A/BGxll+fi1
 kvAbLpIsjiY9kpA4xNNxuUhAo+LGJc1LLP4JxQSNyRostY3l1FhbapoTZxJaHAL6tNpV
 /CmdJKdebg4hujJhWN3Sr9e01WTXCG/SVbcLY1oIoKWubQCfhM/J2al2dsd0cDMIDQjZ
 DcGd8MOXu8Xj9MhZCCxf2RREBom74AUC+plfg2n5s4CNiwbNTtmJgkB+Z7KB90NpmqSo
 vsMJ8VI9BVM8Fx/HvSmZwVPvgoxn4bl0lLk3l0iXgegaYek60/sBzozCe/5EeYMkEB7l
 wSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804353; x=1754409153;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fiiMiVJRf1i31Avgztmf9WmZhaG7v+AEL3q+uQl2no=;
 b=fW8TlTbtQauZPQ3/yDwbRfC7aHigcvjQH+R1AOghY9/4a7g2CSYpSIFIV1Yf9/lpX6
 nCvHBWZ3G9mciQOuhxEEvn253AXQK7hHkFXTppPdPDnByNC0YDjaBiznT5bQc8A0O67s
 tQRqFywsBIcldbkqC8ViwiHNF8fbvVga2+R5g2GGEmByMpx6IqtU7rWLLc377nRHI4l2
 0otnRNlXEiWHc52Ot1blUvb47mbKWt+4zvu28mWThpF1ZqZhBlhgRgkN4rdvGi+cTiIX
 ZVVvFlWPcfu0c7JHTmQeHYzM7gA7igt5Lkof9SLlEWVRVy9ZSX+5FoXn4IU2hwxvH+J5
 gQoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6F6ryuhqXg8bAzHINN9Mgg17wGwXVfrlQbt4TJ/JnvIiHMl4MFt+8uVeyn9UJpMCnYYZpWwc=@lists.denx.de
X-Gm-Message-State: AOJu0Yykcr5m5dOVQa6gwH5YdioPKDQUIHiwjSkVvkdmdjeGqTSs2K1k
 r/qGukGgZyENGXjQ9BVsKxegpy3nCjG104cQ3vIrs0aSmGfi6uqoYfDr2ptU814ZxqZ76l2B94H
 3ry6B
X-Gm-Gg: ASbGncs+1bjtzCYEgsBRNBH2G0pbBle+u14DCkYE5Mmosu2L073QgmcHv50UiydszB0
 mE7b3xacySsNzy9KrF0G8+L/su1LQqTFJ445ecfrxlxaQkYBysFlBH8sbEg9/pHACHUbroOEEpA
 tYLUReVh5YdGOVKbgY5Xg3JmGq1yfuMm3rPJJUQOjCP7hR6QMbtEHhvHtBebmASb9wvhjp4/L7c
 GXJvq7xhkQOs7UGLkUQPx2BYWnbcc3a6uieIaxW6WPXCNIuDW20wvFJPMTZ75JGj1kOkr0DwI4k
 b/8MFMGW0ZHXOIzlVjNaQyL3fjlnOYvw/jB79aEgw69dy6OEr3E1Ez44E7i7H8EzmGsL0FXygsP
 p6tLSh5RFvO3+bCYk0gP/lJ1w0PxPkYY/4R1onlXzydpG0oo1hGXoIENoXh2a0Z1dRtLipcmaWG
 3xqK27T+ponQ==
X-Google-Smtp-Source: AGHT+IFxZa7iHMjlUXtiSWv2AxeIHW4OEY8ZYg60zTzNKk8ivcvNKNYHbQq+ddVZ/LtwrIVFE0MGwQ==
X-Received: by 2002:a05:600c:4713:b0:456:2b2a:5f41 with SMTP id
 5b1f17b1804b1-45892bdd2a9mr2272525e9.32.1753804353280; 
 Tue, 29 Jul 2025 08:52:33 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588dda59cfsm18948535e9.3.2025.07.29.08.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:52:32 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:52:02 +0200
Subject: [PATCH v4 04/10] arm64: simplify interrupt code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v4-4-8d8bda8e22c1@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v4-0-8d8bda8e22c1@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4376;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=fPu0dk9AHL3tpJtCCPWHurvWt0zPiyF9h4DkBoYxn6o=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO4jtO9bTXqx1u2oP/ymUOVKxX4RnnRsQkeh8
 45PrutrMPOJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjuIwAKCRAFgzErGV9k
 tnLsD/0fY+EjCua1zYuFBACfJh7CK6INPiYTDqjuYy7+10DQPJVZkUfuzrVHhoKJnaWAWZZbM5v
 0hehp7u/uftQO6BeUKNX6+4BQ2wBLoiRK3sBVwK0xyb08ewR5Yg/U52Lpx3YOHFSAwAdbXOycMM
 QfmXNh/rCBhnXTNBcVdywih/Bf/YQwfRaijH2exp0/Rvx/HTccwrL6YHgvhKgLxf3zr3WnxoH03
 T5ChKwnk0FqJ4uvIeUI0KRBOC8f7pJDPDAMFLwH8QokvM4GEaS6ZbE6jdjV0ZsQA83jvofpbauD
 EbvkIsqWSMj9RdMDg9p4dVi0wtO6Ma6VvbE056fnyA0EzwYYQR3QTEaCNoMR6fHV4NdLjeFwr9g
 oW3ahiByskcde3vK799jbEnj5Lyg8wEwEMuUhkxySjjc3TPxQZMoPJYPxBrpMo3En/wzkZseE/f
 BytLOl2xqAhZ6917X0CfF7fghqwlbamvTb7s2qwvCOlTAr/9C0/vIg7RxziM8YPk0leMj3DAse7
 ExnCqPNbwrkq+cbp15BnUqje5LbOnSQdDPI0Xi1EXYpELQ8o+BzV/tkT+4IhXTZsExn6yUcFPVD
 btTBPvzV3fAX5hpwE+N13Slq6cK8K5rSBffDNotd8SWO12ZCjzkL07ZqsSiiN0mSQOLKbFSi2eA
 Ow+ZO7v622Zmggg==
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

Carve out a function except_msg() to handle the output for most type of
interrupts.

Consistently use 16 digits for printing the exception syndrome register
esr to match the register size.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/lib/interrupts_64.c | 62 ++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index b3024ba514ec363bfc3b957df203fc784278037e..d13ee8d9f81dc8c41ef4732167663b223ab6ab3b 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -139,55 +139,55 @@ static bool smh_emulate_trap(struct pt_regs *regs)
 	regs->elr += size;
 	return true;
 }
 
+/**
+ * except_msg() - print exception message
+ *
+ * Print exception message, register contents, backtrace, loaded EFI images.
+ *
+ * @msg:	message describing exception type
+ * @pt_regs:	registers
+ */
+static void except_msg(const char *msg, struct pt_regs *pt_regs)
+{
+	efi_restore_gd();
+	printf("%s handler, esr 0x%016lx\n", msg, pt_regs->esr);
+	show_regs(pt_regs);
+	show_efi_loaded_images(pt_regs);
+	panic("Resetting CPU ...\n");
+}
+
 /*
  * do_bad_sync handles the impossible case in the Synchronous Abort vector.
  */
 void do_bad_sync(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
-	       pt_regs->esr);
-	show_regs(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("Bad mode in \"Synchronous Abort\"", pt_regs);
 }
 
 /*
  * do_bad_irq handles the impossible case in the Irq vector.
  */
 void do_bad_irq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("Bad mode in \"Irq\"", pt_regs);
 }
 
 /*
  * do_bad_fiq handles the impossible case in the Fiq vector.
  */
 void do_bad_fiq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("Bad mode in \"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("Bad mode in \"Fiq\"", pt_regs);
 }
 
 /*
  * do_bad_error handles the impossible case in the Error vector.
  */
 void do_bad_error(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("Bad mode in \"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("Bad mode in \"Error\"", pt_regs);
 }
 
 /*
  * do_sync handles the Synchronous Abort exception.
@@ -197,9 +197,9 @@ void do_sync(struct pt_regs *pt_regs)
 	if (CONFIG_IS_ENABLED(SEMIHOSTING_FALLBACK) &&
 	    smh_emulate_trap(pt_regs))
 		return;
 	efi_restore_gd();
-	printf("\"Synchronous Abort\" handler, esr 0x%08lx", pt_regs->esr);
+	printf("\"Synchronous Abort\" handler, esr 0x%016lx", pt_regs->esr);
 	dump_far(pt_regs->esr);
 	printf("\n");
 	show_regs(pt_regs);
 	show_efi_loaded_images(pt_regs);
@@ -210,25 +210,17 @@ void do_sync(struct pt_regs *pt_regs)
  * do_irq handles the Irq exception.
  */
 void do_irq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("\"Irq\"", pt_regs);
 }
 
 /*
  * do_fiq handles the Fiq exception.
  */
 void do_fiq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("\"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("\"Fiq\"", pt_regs);
 }
 
 /*
  * do_error handles the Error exception.
@@ -237,10 +229,6 @@ void do_fiq(struct pt_regs *pt_regs)
  * in processor specific code.
  */
 void __weak do_error(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("\"Error\"", pt_regs);
 }

-- 
2.50.0

