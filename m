Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250B0C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 15:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A31CA830EA;
	Tue, 29 Jul 2025 17:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vNWHtYKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43810830EA; Tue, 29 Jul 2025 17:50:29 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 209D881E14
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 17:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3b78b2c6ecfso1339812f8f.0
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753804226; x=1754409026; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9fiiMiVJRf1i31Avgztmf9WmZhaG7v+AEL3q+uQl2no=;
 b=vNWHtYKSmotPwnoiugOtBvxBf9EtESNKex3J8V/tF9QvGBVjRkuqlgLlAPWb91COHd
 Y2SrATX8U1GR8DtHZGSXIW9EOlQc2H4QvLSxzmnhd7HsI40lT17bwIK6LPzsHes9uLWu
 5qdS+rkHuMz4p7Y8f9DZAyuzIJK/ENopOCEwTzPPDiuTl+mY8udkj/hx8atQdz1J4r8Y
 Ju+PAOmQE6755i0jIsVDf51UiMVvbLCS33Kvjolda4/neclfh8+tKkhLmfk+wJxKvTpR
 B0FBERW1+nkAa4VhdQ0rTftVuY5zx904MSHhLfXzIpuNDOIDdDomfaMDpGZ+tA7XojkE
 pCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753804226; x=1754409026;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fiiMiVJRf1i31Avgztmf9WmZhaG7v+AEL3q+uQl2no=;
 b=JP3HsWgWhTXEyiEA+uvXBZ0If3NzAEUjmj97gX8PY49bQSBvpHAZ519RPeBoYNrDCN
 N/cGzUlI8/2qe+nT58wkMKkxfZo5KiPPv/oIzt3pjDhMrjrf9cXBmdjj/HYa0geq5o5r
 edAVelYfJFoMWASEYEJYo5xkkQ7eLB9QpJarWlE6ccDBAF5ZpNwy2jqJ6tWcLK33eC59
 qLcTInZYeKgutFXdJFx6yTMnEU3+KVaDowoSzhQS7a7VSRNhzcn2KLLFw1WvX6SyC1v+
 xXr1c/pbY3RZ97bQ1nocXOfEjAN79B0nBOnYKnvv7Tkye1f4A1EQ3+Hdx9tiGA8ul5r0
 gejg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6H0+6TI1xivz8wXuKnvWk5j3/8EQix5u//BJHgCK7SmJis1R6dMQGduXz6JYwsLfNoJoIlvM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5hLeDtjLp0IwkAF6TYwe5rt9rEUQvOaBUkqSQFo3W5+CbMchd
 56oRpbPYJAsAqw8ORLD7EjMzifkfR6KOHPTx4Fj3tp0GvmmOiQBW/IY52pciA30aQe0=
X-Gm-Gg: ASbGncv6OGXxJh1nOAY0ZBADCVrRnpT++hVWTrsKRj80jYoYynCgXjr2YfpiBHEECjg
 5RWWQXp0SGHDfPD9zG2NgbP2tPQ/dNBHKdOnGsKdQtuYF+Env0tKwuiUHBQJeyJGojhm5Pnm1eZ
 HJ9m0BPcHzmypNYIOOKdfjKAXgd9Qkh5FmbLRC89wtkezDDXXgJyechxdPK39cVaWJUyyYuzd2Q
 sTItolYjoxRUB0ldcBGPF0T7sCMhTGHYWFSbYzsbmPk6uqpZRYmAlwhe/WBC+TuwgFT15q2Y82k
 k9CHkqtKORICDpM/ZICQQXnp1Z0PCHqVdZNdm/7w3GAE8XkhljzUS+v2gfyVTry6iAO7Mjlu+OZ
 PFBOinmuzUR+LXAWdBqu5bC1S5viPpfJEf+e66vDEe04UdzDrbDkpuTpXeiYKSB0odJX6Zaawp+
 WIxD4XuUJd2A==
X-Google-Smtp-Source: AGHT+IHBdVlD/HVU7h0xwhJBz09D0WF3Yhr+ZT1S6bqkIGxuDvbUmq1kc5b6LHTfSVtSOOJsL19jMg==
X-Received: by 2002:a05:6000:381:b0:3a3:7ba5:93a5 with SMTP id
 ffacd0b85a97d-3b794fc17f5mr161661f8f.26.1753804226394; 
 Tue, 29 Jul 2025 08:50:26 -0700 (PDT)
Received: from toyger.tail248178.ts.net (ip-185-104-138-124.ptr.icomera.net.
 [185.104.138.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5c1a2fsm30635875e9.12.2025.07.29.08.50.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 08:50:25 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 29 Jul 2025 17:50:02 +0200
Subject: [PATCH v3 04/10] arm64: simplify interrupt code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-b4-arm64-backtrace-symbols-v3-4-6f258b34fe8c@linaro.org>
References: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
In-Reply-To: <20250729-b4-arm64-backtrace-symbols-v3-0-6f258b34fe8c@linaro.org>
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
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoiO2qfPdb9zPjuK+NX41aJBizlsCCLySTRzMhr
 T0eAHRbh7aJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaIjtqgAKCRAFgzErGV9k
 ts2ED/9f8A3Er/xARgVBB8tFznRmAvuscaln9HK6cB56p9HVjVDbk2QhGBxka52gUxufIujDlOL
 ZtQxV5wmFxIflHhVg3GISUZS7LzZRo1RF4pMYzbTCafb43urZZuWvEVUm6tKaATiXx0V9uDcjJV
 BiOX0DEmgEQ5bi3hLToSQYI+8IJOwOB5C8CcFUds479FJ0OQcTsbvLH+Qp9zOKsXkHeeVYjyFXr
 OIe4vnCL01ZyCO/+7OEDCrkCiO7r6olUWUenel4DT7prN5NEQmPU1XRHbpAGSmVIsXaiKRVYgvS
 lMM3Q42DZTHQ2Ctagc/BrxsXJy2L5pognWPn1AN1Uk53VTZ5J7aWBi3sYTYb/cU3AWEH2Awj7Kt
 qme4Gjg8FmnRa+7JRJM/GASRPQOF2+jc+MxDsyumAhEP+B2tD74F3Tl2rn9oFUiO2L81ZzBnWpU
 lcHY6tKQkAJ0ssrSJxEV10wHKwq2NDpCT9WfskzGJy/M4W6qMyTJU7C7voxq2+egZWladHGIfm4
 b/MjuaOG6mNEOYsuKgJNpaXpnosBxIkwKn0oEMK68jIJ7c+YyWf14f1IjNBGQlUy+ZlQHx8d/4w
 Ibn9SltKthbHyQx2BJBrx4wB8gO/sLgS/FYn9eIjR9Fam6KvKZwZs9oI4ekNedD7kSS197QjrDY
 o3V8VeB7Ci0DCJQ==
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

