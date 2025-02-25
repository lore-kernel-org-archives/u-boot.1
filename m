Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0E5C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE5D480FD1;
	Tue, 25 Feb 2025 17:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O/qsy75H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5690580FB9; Tue, 25 Feb 2025 17:35:15 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB2B80F7B
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4399ee18a57so35129165e9.1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501312; x=1741106112; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCu7qj8HR3Py0+iZlP/oCbK1XsWURJ6VtwUuKp1Xrk8=;
 b=O/qsy75H64tBbgFjUojdulw5J1pG5Eu8MKiTn2JxWdJoozHrbuMHLwFg3OWuG+5J9m
 OnxkmnHrbQmP4uIxKKKDebz8QTyxvxtkV86x6Ho58Kqi3ryVADfwc50e7KpQw4Efqaua
 XJD3ILJ55KBnmVpnv1IlMPaH2uSMCYzp8Z6BTfvUj/wQx8GtuUzYvV7/WyEab51b6IOX
 PPCE+RJwI0+8js3XnRWasnLqGHbUjEz839ch48hBS98JkCVJ3ZD1L3UTB8oFGaHRD77D
 MFGGGL9Y9grwiO3sXjsH8X1UkIdTzpNEIrkzLJOw1+5dG7RXYFmUmftnKRZ+EInGqaiN
 rmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501312; x=1741106112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCu7qj8HR3Py0+iZlP/oCbK1XsWURJ6VtwUuKp1Xrk8=;
 b=uMumCFFTbst7Pi16HvyjlKLnk132xOSGOs0eNB2F/Hlumrzcd8Snicn1thBIa9q5CM
 +h770hfWRve47sUZuVLfKdI2s31PeJmmiRRVK4/c3NHkJIzvOD+ymTIta59HPn1kJNs+
 hWUEGJjd1/qaaF1X14sz3zI7zKHBm5GBMh4+I3JLvdUxTkUauTpvQapvzSb6s7ZwQaAx
 UUYo8f/aCJYLF7F1ve81HCp98eUmFPv7+dYugUULk+pxdSePQq+LS8u9lPoRPN7EHFFC
 zuriuWGRlBtLhftvsDDDD+92QHfrMxPMhyGiLBdiJnVsZGE34cmJeQijLRE15IvBaqGt
 6GFg==
X-Gm-Message-State: AOJu0Yy2ah/6DDmW65q/DgZ9VEEbwguDWkQ2uuQqQsavaO4y+n4v32aX
 OK+yL0nxUukBnTBQEVkc+LFDZVQazhKr9f2PRD077YQ9GqWvnIUA0/Jh6qLMOMy6OTn21zMQvQV
 gJpDuoQ==
X-Gm-Gg: ASbGncuqmTf3ClB9eT1DqhW5QRmWVX5TbOk/a46JJSiu1CYFX1iW0W5JcGNbvRaUCp2
 iKBCDU7CcXI4IuUKarsZKJ2l8ZbbidaT0TSwpjr5nMwDrrWWMtKUSsa3y3su07wVvAF8VIL4xrk
 /D72ZjRtOxsiTSj2hlvJIN1hlKU8MePoTS4siN0wtETPWd904urSQgXCo3xsg6WbS0Y0uGldvry
 IzwekRmLoGUw+B1S+GVZ91oZWZJfdOkTPtWf+iveVPxRHy3Cl9rajw6FHN5dCbZAxqPjI1/58YS
 wNK80W2XqZuccxguRSjDYFVZzpQA43MVqwQ=
X-Google-Smtp-Source: AGHT+IFcMLrOS7e68Yc5dCEfszbJ1MghOkjcH1Bw3ZaIMPk37K91nomptOun2LgwMdvgyODfN9Zteg==
X-Received: by 2002:a05:600c:4511:b0:439:5f04:4f8d with SMTP id
 5b1f17b1804b1-439ae320687mr127688625e9.12.1740501312043; 
 Tue, 25 Feb 2025 08:35:12 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:11 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v2 02/14] arm: add initjmp()
Date: Tue, 25 Feb 2025 17:34:28 +0100
Message-ID: <bba48e537696016b94faa69a20f998256b060685.1740499185.git.jerome.forissier@linaro.org>
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

