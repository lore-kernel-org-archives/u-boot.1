Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E3FC369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6012483236;
	Fri, 18 Apr 2025 16:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZTyxsf4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E748324C; Fri, 18 Apr 2025 16:11:36 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7406B83208
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso1267221f8f.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985493; x=1745590293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWOckKqYXC1BgXfRaZVp2T9Ty29KaBSkqFhmOWssckE=;
 b=ZTyxsf4RdSnxx/4xc4M+UTnXuY/MUjbXdniAMfZ99QNYAbHLM/9pHADAHwn/MyYHOd
 0OQ5KtJa8FkYSUx40VPQ4Qse47vYjqVt01VIkJPS95USfE/R+etlMV8DuWNRmLvKrKfq
 bELo8+80wFxfWoepmEeHcPkXkv+lTn0EbKw3RII/nzlBNm4gbv/shHvSKrvch16qflYo
 5sXsnM/8DoOPl/hA8W3EIztidQdKooQcTxbM29CORroehhn/8pwmyF2eTgFtWPzmEh+/
 s6GcOWthNI3LUOF7ppJvWHlMqitCEShvSIlr/ny1WDg9i+RpHYObKOfHRXzy8V3rHPWw
 HPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985493; x=1745590293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sWOckKqYXC1BgXfRaZVp2T9Ty29KaBSkqFhmOWssckE=;
 b=G8jMqdOoFPwL1eG7oVhsZe0LIjyKrgN8IhbgcvrSqfxt25A0M6/Pk7BlMEfsR4Glk3
 X6lkckWab8iU4wRrDy8A1fkIIzZoW5ytKmEYrf3OhA1MWGq4PEiVZuuY2p6dFA1tWdSo
 QFJXLloQXSOqEmQyD+OAe4sEQa8gVW3CoGwcC5WNBnD4Qx/NmZuHqJ5ZskjqYTIZZUng
 r/QBVBDTdSZPZLG5gOzbngbUo4rPmLCFBSGoXAqg2ea8rPWmKz7gzJ7nH7qbeUP7Z4qS
 YAjWTRab2XH58V3VgbsxSd3NzckpcOje9fErHRAJjIYdHK1PZehKCPY5C06GdhwXPvuO
 b07A==
X-Gm-Message-State: AOJu0Yze6HTm2wFnkOv8pOGDDArPaqIx5J4HF0tu0PLFKfvOI+2exyog
 J9lJHfSDYAAwaQiAZbRsBUWhcDnIBRVvF7pRwP5/QJotDVsaf+1ZoWACssvro9HFXL2QEWhBIfs
 9jtxdUA==
X-Gm-Gg: ASbGnct8gYnQHC9DhdVAqVY8/f9Sok+NW21IgbbMhL+CpaLVQ1aMdT/oqABo4XMacns
 IHWkFWkw+Y8vXfUd4QRH33l9gjQxajgaZmL9eKy4WYwfvQ4AAfxRUqlvkGRGb8nnQ34JQoJawYG
 jYo7yTDf30840wudXoSIkLZEbjH8I/mAk/ZJbMTKzjTv84prS7BcLoATLhndRfQwljfuihVXt1D
 I9hQjm/UZbTUb/S/ZsYR1wQCmqAQFKM08fHYJD6G29YWcY1fayc40WZHEVIcHpDpHOjjEG/CJIL
 L5suRdu2aO1vWtaRJzs4qbPxK+po4YWeQKsCIWz5dcjh3x8KEjnu0+nsgT/u
X-Google-Smtp-Source: AGHT+IHYRrQbqqUggbaxxeornYEnDBNVL5qzfFH2vDEgP5RpU4UTT2Vy3+M+zOGg5KQxP30VRjdRmQ==
X-Received: by 2002:a05:6000:178a:b0:391:3f4f:a169 with SMTP id
 ffacd0b85a97d-39efba6da14mr2079290f8f.32.1744985493492; 
 Fri, 18 Apr 2025 07:11:33 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:33 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v6 02/17] arm: add initjmp()
Date: Fri, 18 Apr 2025 16:09:30 +0200
Message-ID: <20250418141114.2056981-3-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418141114.2056981-1-jerome.forissier@linaro.org>
References: <20250418141114.2056981-1-jerome.forissier@linaro.org>
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

Implement initjmp() for Arm. a non-standard extension to setjmp()/
longjmp() allowing to initialize a jump buffer with a function pointer
and a stack pointer. This will be useful to later introduce threads.
With this new function it becomes possible to longjmp() to a particular
function pointer (rather than to a point previously reached during
program execution as is the case with setjmp()), and with a custom stack.
Both things are needed to spin off a new thread. Then the usual
setjmp()/longjmp() pair is enough to save and restore a context, i.e.,
switch thread.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v1)

 arch/Kconfig                  |  1 +
 arch/arm/lib/setjmp.S         | 12 ++++++++++++
 arch/arm/lib/setjmp_aarch64.S | 10 ++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 14111ca14fb..7a3141e92b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -95,6 +95,7 @@ config ARC
 config ARM
 	bool "ARM architecture"
 	select HAVE_SETJMP
+	select HAVE_INITJMP
 	select ARCH_SUPPORTS_LTO
 	select CREATE_ARCH_SYMLINK
 	select HAVE_PRIVATE_LIBGCC if !ARM64
diff --git a/arch/arm/lib/setjmp.S b/arch/arm/lib/setjmp.S
index 2f041aeef01..81bef578719 100644
--- a/arch/arm/lib/setjmp.S
+++ b/arch/arm/lib/setjmp.S
@@ -34,3 +34,15 @@ ENTRY(longjmp)
 	ret  lr
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	stm  a1, {v1-v8}
+	/* a2: entry point address, a3: stack base, a4: stack size */
+	add  a3, a3, a4
+	str  a3, [a1, #32]  /* where setjmp would save sp */
+	str  a2, [a1, #36]  /* where setjmp would save lr */
+	mov  a1, #0
+	ret  lr
+ENDPROC(initjmp)
+.popsection
diff --git a/arch/arm/lib/setjmp_aarch64.S b/arch/arm/lib/setjmp_aarch64.S
index 1b8d000eb48..01193ccc426 100644
--- a/arch/arm/lib/setjmp_aarch64.S
+++ b/arch/arm/lib/setjmp_aarch64.S
@@ -39,3 +39,13 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* x1: entry point address, x2: stack base, x3: stack size */
+	add x2, x2, x3
+	stp x1, x2, [x0,#88]
+	mov  x0, #0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

