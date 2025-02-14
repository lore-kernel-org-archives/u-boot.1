Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113BAC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D59180EC1;
	Fri, 14 Feb 2025 15:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tb1C+31+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22F080EB5; Fri, 14 Feb 2025 15:01:02 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E25380C96
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f2c4382d1so473121f8f.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541659; x=1740146459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCu7qj8HR3Py0+iZlP/oCbK1XsWURJ6VtwUuKp1Xrk8=;
 b=Tb1C+31+OurP1EhwUn6n6yF1pwloUF66LCqIT57iNSG3K2XLpNN+ijps7PQC3h/djh
 aOutKwsH5UQZhkAuqXCSipfV+c16YzenZhLDKDrsorYizElcjyiXl2kFh5VH/FWFGDBB
 pskav4vPkLTk+djvTww48T1CYYQXkjay0rozdUkdx85ljuF0CKPfs93HNW/5cOat1tKf
 z9lo+le323IXxWyo04P9S894ImXITC4g8dHu0yHIzxJPh9reRcx7jJyWcHCHnP+UUuVF
 FFuMoal2EjqBrc6536jZVldgltqJNug0vdwVZ7KRgxLP2rJfHhJxwkEVTKBRSYrr9dou
 PHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541659; x=1740146459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCu7qj8HR3Py0+iZlP/oCbK1XsWURJ6VtwUuKp1Xrk8=;
 b=ifM/v0CUfOnNn9kp72r26o6aT3QGaVFBAQ4SBHxLSL47w8V8t9+eDdT6oWId1kHc85
 zl7AI1fPYwJvucbmFg5O2YnGEiGKEYwsFJRiqWd4Z0SCMsK1YDNoxTZQrpEJrchhbBX+
 tdhKLBecwyB+l1LZ8XyvaIwjIGnayeKqRV9gtsx3hZb2I2ZQ021uiYHkcw+Ls0PE8Lc+
 aOzgJyRqX2n3KqrjYsIB9TQSZ0TFWGKCSZoptWIVqIuXAjllUwyzi/Duj46yURXhmS7K
 J7sHwy/sFN3N9uduoWb0gw0dQi8eyOQvElilrkeXR67ZauG8n6mx58duZlUfyplf9B3n
 GyZw==
X-Gm-Message-State: AOJu0YxtrelHwNqYBauGR8a/xMqsPXyQGO5RVQO9B+7JElkQxDUevTZC
 h61hrFUoD4x7gC2iQnEfN2ema5/rc4wm7w2Lb9c9HCt4j/fTgMNEjoHHaNTZfR2jYRcNWueFguH
 7Z9rx+A==
X-Gm-Gg: ASbGncvcyb/dL1rXoFD/pSYJaTJ1oAeIttZ6FgmS/ZcguKCIkviRMHEL+ajkFlHmKMc
 ngf+GYWe0qRdLuVTj9VBHvqTyN59EHBqnPwd4SMK86YSNrHgvQMr+vBm29ObZfoBzvP7xKhPURx
 adpXu8id25cecEV3nFMZsCD+Iu3HiLlI3HDrKQhUi8oYaOizu4GAXmgRVHCTOERT7ZoMVNJ9fSq
 0RwZsj1MkzevhIo2Uge77IdXGavpVyrnSpYtmdbCjMn7mgLamgE4uNg9zSMnl6rbsx1KlCOjFob
 HLsh7nWKi3/Z0SXEQz+AXlGy
X-Google-Smtp-Source: AGHT+IFMURMr4Fy+Wcf9mmSCMU0ZIAHAUpmkUA3V8sP82xNeCSP+lvHVzDGaP5K9rgMREMkURRd5RQ==
X-Received: by 2002:a05:6000:4024:b0:38d:d8f7:8f75 with SMTP id
 ffacd0b85a97d-38f24d74d98mr8650343f8f.17.1739541658682; 
 Fri, 14 Feb 2025 06:00:58 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:00:58 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [RFC PATCH 02/10] arm: add initjmp()
Date: Fri, 14 Feb 2025 15:00:17 +0100
Message-ID: <20250214140031.484344-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214140031.484344-1-jerome.forissier@linaro.org>
References: <20250214140031.484344-1-jerome.forissier@linaro.org>
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

Implement initjmp() for Arm.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 arch/Kconfig                  |  1 +
 arch/arm/include/asm/setjmp.h |  1 +
 arch/arm/lib/setjmp.S         | 11 +++++++++++
 arch/arm/lib/setjmp_aarch64.S |  9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8d5b54031b3..57695fada8d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -94,6 +94,7 @@ config ARC
 config ARM
 	bool "ARM architecture"
 	select HAVE_SETJMP
+	select HAVE_INITJMP
 	select ARCH_SUPPORTS_LTO
 	select CREATE_ARCH_SYMLINK
 	select HAVE_PRIVATE_LIBGCC if !ARM64
diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp.h
index 662bec86321..1ad5b500f2a 100644
--- a/arch/arm/include/asm/setjmp.h
+++ b/arch/arm/include/asm/setjmp.h
@@ -23,5 +23,6 @@ typedef struct jmp_buf_data jmp_buf[1];
 
 int setjmp(jmp_buf jmp);
 void longjmp(jmp_buf jmp, int ret);
+int initjmp(jmp_buf jmp, void __noreturn (*func)(void), void *stack_top);
 
 #endif /* _SETJMP_H_ */
diff --git a/arch/arm/lib/setjmp.S b/arch/arm/lib/setjmp.S
index 2f041aeef01..320ddea85f9 100644
--- a/arch/arm/lib/setjmp.S
+++ b/arch/arm/lib/setjmp.S
@@ -34,3 +34,14 @@ ENTRY(longjmp)
 	ret  lr
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	stm  a1, {v1-v8}
+	/* a2: entry point address, a3: stack top */
+	str  a3, [a1, #32]  /* where setjmp would save sp */
+	str  a2, [a1, #36]  /* where setjmp would save lr */
+	mov  a1, #0
+	ret  lr
+ENDPROC(initjmp)
+.popsection
diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
index 1b8d000eb48..074320d25fb 100644
--- a/arch/arm/lib/setjmp_aarch64.S
+++ b/arch/arm/lib/setjmp_aarch64.S
@@ -39,3 +39,12 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* x1: entry point address, x2: stack top */
+	stp x1, x2, [x0,#88]
+	mov  x0, #0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

