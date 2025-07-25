Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9CAC87FCE
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C36F839B1;
	Fri, 25 Jul 2025 14:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IVF7pVBD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8883883979; Fri, 25 Jul 2025 14:57:39 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F8CF8398A
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4561514c7f0so21215605e9.0
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753448257; x=1754053057; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GSq5X4512m5eJvCVK1Nl89ZHbLR25dUma3empyLdwO4=;
 b=IVF7pVBDBSv6m7DCSYNfjuQqR/X1q30n4R+uiMt14Ou4IpcFVwaUWmDRd58EjpN0N6
 qGJUS4OUba9DRFRcNNHmjtSKLBjBYMdsVyXrKXPJcEjKAH8RaH/MiVanhtwa6UGaoLGr
 zbVtWkvT9f9+VHQSouefsVpRryY9SPye+9F7HBi1m/jzCY/9S0I6bpFEaZ1R8IiGH3Gg
 IAs1tOzKTFxCu2Mn7dDMlcAOSdGEVlx/VseY+x6W1GVVZSp+umsFzhWhQSYpDHo10TBN
 TYVmUCGngAkrzyWskLmbZhPki9BZfDFV+yDlPUqsmhG54zZgi1HvSjdDO6FCEnO8uB3s
 QyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753448257; x=1754053057;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSq5X4512m5eJvCVK1Nl89ZHbLR25dUma3empyLdwO4=;
 b=n9rAYZMSsI69Gvau76Q9ntU1wCr6GXoGIItAJWqS7PWK5xtKla7/YrOFnOZFlNsfbf
 04Yn4jPM9V/7sTk1N4dXE09mSZg6OUCv62FaiZ2VhkTEpOWTryCA4mP9gChO20Z0xbWD
 zdG3uQrCtOdf8oYtG+0gEqSoA/gk2EN/qyuCVvyuzuEiFk3KTXDR6jCfDkfFaOz+JpUI
 ez8b3brEfBr0pnbafDAbNQaU6FIXhMcATy0AbuvfkiBauO/nt7BxSeAi4JwOroyiR0L3
 c4q8DMk+GOPdlr6HrXR6GvK1YADVvT9F32LKTzGhpofEYUb3eNBjnVABQnUae6HZNd1x
 QZbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAuRCL5naCO7uMKATHY7ijwY16hZGXEy4F5MiVeR0gNDfeNr88i+yzRiXuozORkH7saSJ8nQs=@lists.denx.de
X-Gm-Message-State: AOJu0YyAgtbZZDjT4LZ9q3830nHxDyDvofA7bwLBHW8fhPHYInMDW1FC
 K7R1mGqLKjvwpbUHQy6+b4bFu4TWk0VaXBDnBPF7vYEMTIfRxw+JhHgLp4/9HIfrsWc=
X-Gm-Gg: ASbGnctlgOvw9DtKv2WiT3iOPgu/hVejcVAwSq5eivXYFgB1lB5b/zRLyvMPo72gJLo
 ytMLfi1qQOp3qyhiZDVXg0FQcJHDTCzVBLIcglgREyWYND+XOPVKgo7VT0IZxplUuodP4Nithgb
 KLg3iv3zHXB3pDWclLx+4BI3B4/oGXbdVceu/7gFTV4UgQ4OGbjK/xRWh7hnfvCZdktvgsn/g9J
 6OHD9rgP+e6KDAXPvCr0QZWaoOKihIk8P1kv4eKiqkx7ChfiPMZu3XJMaYdc0GIf6cIVFB6eDMC
 ns8LcWrdiGWDbNR8Y0E6XS1Gtb4unto+L5ze1QEXPk1kGzX9sgT7NPrJeQd0tWJJAniujKlTSHB
 quPBOHB+5pYkjrmN2KG4uaUfk4RK/j+KRuinnMWzkBv8TsDXMPmu4q2t+qcrhpjxztRQ2zBcAEx
 WF
X-Google-Smtp-Source: AGHT+IH7jYYCEdmeetyY2xAnsuNg14/LBcEJjp5T0jWBcibbdsI99XwXArVEzBVDbqvA362aAhw9/Q==
X-Received: by 2002:a05:600c:6207:b0:456:1bae:5478 with SMTP id
 5b1f17b1804b1-458784eb3d8mr11865685e9.2.1753448256685; 
 Fri, 25 Jul 2025 05:57:36 -0700 (PDT)
Received: from lion.localdomain (p549d4bd0.dip0.t-ipconnect.de.
 [84.157.75.208]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm53115355e9.29.2025.07.25.05.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:57:36 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Fri, 25 Jul 2025 14:57:11 +0200
Subject: [PATCH v2 7/7] arm64: simplify interrupt code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-b4-arm64-backtrace-symbols-v2-7-230a9665085b@linaro.org>
References: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
In-Reply-To: <20250725-b4-arm64-backtrace-symbols-v2-0-230a9665085b@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5024;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=luvfoWXCYhjDQVTYxc/rmEPgnFwzuvE2vVwjv1wBrqE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhozmerMuh5prPQW/VuqVJFnYFvUtL+p2ehG5aeH7hT4m+
 1jLXz/qKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABMJvcjwv3Khf12QRdzzil65
 yNX3aw9p7TxntdQo1+pE3F6l42frjBkZVitcDPMs81969web1zUZNbYTfw9LxSmfO3zqseUP4+8
 HPgIA
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
 arch/arm/lib/interrupts_64.c | 72 +++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index 6cb16811566a..9687e2e1c142 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -206,63 +206,57 @@ static bool smh_emulate_trap(struct pt_regs *regs)
 	regs->elr += size;
 	return true;
 }
 
-/*
- * do_bad_sync handles the impossible case in the Synchronous Abort vector.
+/**
+ * except_msg() - print exception message
+ *
+ * Print exception message, register contents, backtrace, loaded EFI images.
+ *
+ * @msg:	message describing exception type
+ * @pt_regs:	registers
  */
-void do_bad_sync(struct pt_regs *pt_regs)
+static void except_msg(const char *msg, struct pt_regs *pt_regs)
 {
 	efi_restore_gd();
-	printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
-	       pt_regs->esr);
+	printf("%s handler, esr 0x%016lx\n", msg, pt_regs->esr);
 	show_regs(pt_regs);
 	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
 		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
 	show_efi_loaded_images(pt_regs);
 	panic("Resetting CPU ...\n");
 }
 
+/*
+ * do_bad_sync handles the impossible case in the Synchronous Abort vector.
+ */
+void do_bad_sync(struct pt_regs *pt_regs)
+{
+	except_msg("Bad mode in \"Synchronous Abort\"", pt_regs);
+}
+
 /*
  * do_bad_irq handles the impossible case in the Irq vector.
  */
 void do_bad_irq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
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
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
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
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("Bad mode in \"Error\"", pt_regs);
 }
 
 /*
  * do_sync handles the Synchronous Abort exception.
@@ -272,9 +266,9 @@ void do_sync(struct pt_regs *pt_regs)
 	if (CONFIG_IS_ENABLED(SEMIHOSTING_FALLBACK) &&
 	    smh_emulate_trap(pt_regs))
 		return;
 	efi_restore_gd();
-	printf("\"Synchronous Abort\" handler, esr 0x%08lx", pt_regs->esr);
+	printf("\"Synchronous Abort\" handler, esr 0x%016lx", pt_regs->esr);
 	dump_far(pt_regs->esr);
 	printf("\n");
 	show_regs(pt_regs);
 	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
@@ -287,29 +281,17 @@ void do_sync(struct pt_regs *pt_regs)
  * do_irq handles the Irq exception.
  */
 void do_irq(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
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
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("\"Fiq\"", pt_regs);
 }
 
 /*
  * do_error handles the Error exception.
@@ -318,12 +300,6 @@ void do_fiq(struct pt_regs *pt_regs)
  * in processor specific code.
  */
 void __weak do_error(struct pt_regs *pt_regs)
 {
-	efi_restore_gd();
-	printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
-	show_regs(pt_regs);
-	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
-		show_backtrace(pt_regs->regs[30], pt_regs->regs[29]);
-	show_efi_loaded_images(pt_regs);
-	panic("Resetting CPU ...\n");
+	except_msg("\"Error\"", pt_regs);
 }

-- 
2.50.1

