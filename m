Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6005C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1B8382EB8;
	Tue, 29 Jul 2025 18:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r6PmAmXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C42883102; Tue, 29 Jul 2025 18:07:50 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2576882EB8
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b78d337dd9so947041f8f.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753805267; x=1754410067; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9fiiMiVJRf1i31Avgztmf9WmZhaG7v+AEL3q+uQl2no=;
 b=r6PmAmXW6JApmX0oi2fnSfK4kzYmP8xxMw4waPE52bbTsKJczGyGscMTvE3+PKsYfr
 HS+IBkTG5Ga5jyEuLRm1htucjf13bJVH5euy8Rz252GjxkALPvKPJh76lCrhXnkbcSvK
 vNjPlHjxxCsvK82+NziyT8f1jNoicnEDy8ebxW48IbWf+SOiarCemsU2hNma2NwE+aRw
 d1Mvo1NPdD9764xeQBFEb7aC4+PYmLOeQzA3Lg/vIzqANiWzEpJVyfksmZ1/VARRo9Rw
 +vSvTxN6RZYxCpfdQ3lcUREd45l1YrGRVhSOY4t79mKKm6jpKvVQKXvhiiZK2iu6auPW
 W/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753805267; x=1754410067;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fiiMiVJRf1i31Avgztmf9WmZhaG7v+AEL3q+uQl2no=;
 b=YX15rfM1j8Nd/dHxEsoPKb/1zmVSyyIUbuVJ3FZr4lvNoqj6LT4YXfaWq1U1LTQtnn
 MEnODR9o6mEUzTDwwq7A48Yta6Yr+mQGtprwNbo+WDfj2BbJtcEtLaQzFhHz1p+d8WV1
 z4oBxAepEJAeAPNSgfX1rujRAi8NXYaggu83eXHZ7msFEFwLgt0J2ZyAIfNj+MsEIfz5
 87WieCGirVAp6jY+GSg5+vkrZybOHs4fsd+MgMDzkb3uyD26Urg3K6ChQCzBZ/l6doX6
 MNGomiYevsa5aIxvUi9349BJGkPBbXTNx/jDNHUhdOFnqJc5TevoDr0zzmXcauhJUHhO
 OWgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Q1B5Th/gA9O2BlwSR+X+uI4jqS8V3ZUqp4MZzTHHfEFyMNKF8swkH//Bh8Ahg5i+eBUBOfw=@lists.denx.de
X-Gm-Message-State: AOJu0YwktwuhwalM79R5GpkJEgvHJOujwoSEn888JzEKTOUUuGHaTiKS
 +kFyQqMTPeJDJcRX80SF/PHnkQnEINSypNw+gG7d0RTv09xKqDHx2HTgtFRyzrCq0zs=
X-Gm-Gg: ASbGncuYcRBQ/fbTtVaEwlifhERkHdzSVAllD7ApFNOJdhEejeo32RcItSZLLU01zdH
 cYYm3JGrjAbqMLZec9pl+a4nEaZAXFCwkP1QP++rt+0dL6b+sxZGVh6VHBCGps5zc7la7ktwsUS
 Q7L6f/wxx/K2Ca8BtWlt/S0YWAOYH3+D4FBtIogXExiQjVSBavIT8ADw1vw7C2kr1CByrBp25Se
 BC69lnIdUt1w/fS8rI3DME+cuz8lg2COJe5DFMKmU45I+q46TmAPtWeC+HuGK2gIVZOhfDV+xa4
 qmBq7zWJVif6jMaPYdUu0p+0b9EjCSMh8J0Bw6Z7PW9+OlLo6HskPwfXOtIWTgDmSxYusdkpNXE
 6iy++narnDO4vO13hebfAt8aG0oByLK5pj+OyeWVVPN3o6O4lgFP75dCroOFjXen6eYtvQLSr82
 E3YO9QCc3ukg==
X-Google-Smtp-Source: AGHT+IEwU08t1csWYvO4u1sz7cQUfRHxXV3Vu9JkkvyRyQ05MZwkYei8OnjzeUlHtWvMV3scUlDsGw==
X-Received: by 2002:a5d:5f54:0:b0:3b4:990a:a0d6 with SMTP id
 ffacd0b85a97d-3b794fd5a7bmr178145f8f.19.1753805267548; 
 Tue, 29 Jul 2025 09:07:47 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b781d2fc1csm10512075f8f.5.2025.07.29.09.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:07:46 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 18:07:25 +0200
Subject: [PATCH v5 04/10] arm64: simplify interrupt code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v5-4-0009c4620a46@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v5-0-0009c4620a46@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4376;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=fPu0dk9AHL3tpJtCCPWHurvWt0zPiyF9h4DkBoYxn6o=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiPHB2tym8hkKl37HXrtlHjOshqCQmbklWVg4R
 EFQ0l8Y9KuJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjxwQAKCRAFgzErGV9k
 tjM2D/9dHCxBYovbNA1B2wRtCG2Ojs+ABegGDV/27+5cWY+xFTO5rYIz6wlDwdZkD1f+lAk9Kc6
 3HruELdCWqdKw8mmRJNJHcrp8CTNMM2vCEDx/YiNdnZl25SGHh0mCcEX8kOeECNEmxXRzZl0tI/
 jyeh6qmwZOKif+Iss0grDAzVImrdMSvj/v9/YSIlh6wwYL5+4OAaVUd2vV277SccQOCqJPTvyjG
 3NJhWl0CXCgOsAFDTIQzQmjSv4ZbqfPNvdFSQZTBIUubZpLkk6izo+upTZRiWG+rV+EoH4RJy8O
 a0GpkaaSHCtiJyl23JS3YGuoqUyoIacieVbgQQ+ML0yFGGGOQrn+aBlnTxcGIURqoEFZrcioO8m
 6fQMev1Gc25Y7l+ebUv6fdNy8Rl+I7JFsV8G6i8KhPVfN6QW8TjDi9rBroXn7YEoRowaDue73Nv
 EhxZxYeBvL5lTuYaJXnzCATwnfE1hx8/gINkQo83YvQbxz/BFfd3zADS0Otnxihyd/isdeQfx6D
 3VnbN29rjPIQ3UXrfm6D/T6SzmpUR+zr9UEl1ot/3Kubjw+1/ixN7Kfas+7ocb52nAlVRmH2fVa
 9jY2q/BbaIdBGSY4On3eNYJwpiRuon/Swtv15RV+sTQWhjLXNwlIN4i4vHaCrm5rNmutWrc0zDN
 +T8yjHkZQEJMBIA==
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

