Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F63C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 066D980FE1;
	Tue, 25 Feb 2025 17:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dGG5pYTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C521B80F7B; Tue, 25 Feb 2025 17:35:15 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA04A807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43aac0390e8so14719715e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501313; x=1741106113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FNw2IjE2pzkh8kOG8gbCKeyHG7nPC9wPKaPR6juqTg0=;
 b=dGG5pYTUnI9S9aeX/yOXlFBuBqrscI3j/fJSowSKrk2sZJ14AAq8k94n8kI9UjF/Ds
 173g8+aeRhCjjkpBj9oYW9C8jP5yKoQKYeqdXyoDMLDSAIhBHO91UIlwZQyNd1M4mwzz
 FidIXEjXqcJt1T/I+pUMaIqAka8FJTSLkrUaFYhPbXVvYawZ2peVbm648cRqV3gKQSSb
 4Cz1LV3LlyFteWYZElbUKXSRnoVcPnWlUtQrerEc74LrXQvuipOXCPcE3KAP7gRBiBa+
 Npv+x0TJ9jA97E/TImtcK9Vt+6gX+lWAQhwawdqaL4BmJNHVrsUEFL+GHDufcOXtsJKl
 BXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501313; x=1741106113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FNw2IjE2pzkh8kOG8gbCKeyHG7nPC9wPKaPR6juqTg0=;
 b=qjR1vy71y8aeQ7Hjqg0OueAmMQ72KF5M4wSzfs/v9iNTi+q2hJB9oXt6Xa/y6PqrgG
 Mi3azDZPEdN3aSIa9LEzzGGH/nAgSMV+cX8AJl8u6YNLRUdB1Xzr9FyuhnDmVoiKcKc3
 R7NuGpBenUOWMZOX8JqodbxxGHuhMjv/NXgeDJkIEaMk7gG1wqkfEne9cEk1i76J2axx
 1DITMf9D6QLjTGHkw5UgpkfGOx8+UVFz9SFo9EnrO7kvIUQirfQcdJ1O1rtaLGmpt+lw
 +GoF8QKF+ZX53kIFiysoIbwRdBKEC9w1wxad+hgjNsjBj7rOraxiZTLScO2Dgsn7zvd9
 QgIw==
X-Gm-Message-State: AOJu0YzzR/20nVr22rqXaH/iMA94ZwXpZf8QJPYHx7/R2E4HDY3P0PsO
 GxiJrDO7rddxKUctkfxYfVewEfGHA3bL2FUNhzmQQM9yPqCT9righh0COzuMLrvobXE5NrpiZ2M
 +qQ8eVA==
X-Gm-Gg: ASbGncuHQ2TIECNPJoF+a0hSkblOoiiDpXq9C0WdZ7YtAAeKE+bIGtbX+Oc2ST6C3Gt
 9vz0PIZnTSoeYdhm91tuD/vEP0blDw60p/anvUunc6z+Rys2mj8v1hOXHGq5EGir603hna0LyxO
 IZBm99qL0Kj4PjZhKRYPfz28dpCl5I3ri2b4m7LZv74yc6GPP5wjKCd39whIqAGFRfcfwIG4GiU
 fmUFjAcOrX2nsc8b6KSNnNcpGWLm6fUZKQVjhd7UonSUe1YFP4ar/vOwN4EDi1CAFRO4WTY2kx9
 zdZ+PeUBfvdy11yYk2kfXe8Za22gI9VKX68=
X-Google-Smtp-Source: AGHT+IGPlBnxoZZHG+g5yLfUelUcX2MyvzVZ1/gj8CPSDvkBZVFaooWrwamAn9iMEWwEvxSUwoqwYg==
X-Received: by 2002:a05:600c:3582:b0:434:f131:1e64 with SMTP id
 5b1f17b1804b1-439ae1e960dmr140911985e9.9.1740501313059; 
 Tue, 25 Feb 2025 08:35:13 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:12 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 03/14] riscv: add initjmp()
Date: Tue, 25 Feb 2025 17:34:29 +0100
Message-ID: <16aa0caab1aa196bb19e5e9b1c837b873e1beadb.1740499185.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740499185.git.jerome.forissier@linaro.org>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
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

Implement initjmp() for RISC-V.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/Kconfig                    |  1 +
 arch/riscv/include/asm/setjmp.h |  1 +
 arch/riscv/lib/setjmp.S         | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 57695fada8d..b745222bfbe 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -152,6 +152,7 @@ config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
 	select HAVE_SETJMP
+	select HAVE_INITJMP
 	select SUPPORT_ACPI
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
diff --git a/arch/riscv/include/asm/setjmp.h b/arch/riscv/include/asm/setjmp.h
index 72383d43303..98ea157eb3b 100644
--- a/arch/riscv/include/asm/setjmp.h
+++ b/arch/riscv/include/asm/setjmp.h
@@ -21,5 +21,6 @@ typedef struct jmp_buf_data jmp_buf[1];
 
 int setjmp(jmp_buf jmp);
 void longjmp(jmp_buf jmp, int ret);
+int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top);
 
 #endif /* _SETJMP_H_ */
diff --git a/arch/riscv/lib/setjmp.S b/arch/riscv/lib/setjmp.S
index 99d6195827e..6f952a16eee 100644
--- a/arch/riscv/lib/setjmp.S
+++ b/arch/riscv/lib/setjmp.S
@@ -59,3 +59,13 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* a1: entry point address, a2: stack top */
+	STORE_IDX(a1, 12)
+	STORE_IDX(a2, 13)
+	li  a0, 0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

