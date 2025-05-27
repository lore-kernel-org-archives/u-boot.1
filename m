Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD99C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 21:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B4D782998;
	Tue, 27 May 2025 23:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M/6NP9Mh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 838BA831AC; Tue, 27 May 2025 23:05:23 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A5E82145
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 23:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7cadd46ea9aso475576085a.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 14:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748379920; x=1748984720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TFzSUtTfTgiMH9i9pTcQPeZSP5+CvSIevuyMNiOS39M=;
 b=M/6NP9Mh1fWsetn8z1MzxkcKCGWazACOuMK9bDxx+XDm+nabDEVIeTPEuO+0Nq/NWf
 +indV6zfcgok8rngicRnQ3Il8Y3mNrcBBR7X3LM7aTFZxd2ao5m8CQGfW8aNS6M3wVyw
 EsbqNm7HYkbkXjXwDT0soHc8IenYRBGU/fse4EFV9FtwiMfCVq71QIT4ui9jFzOLDHWs
 NslPYlcDFOWRElby/pOREvAttvFG5+K5mGFjvHyN6tLUVN0KF31zavKXikVkmxRd7bGK
 kG2LTxa9hDsOi27xotI0cqPSqEAzms45CFtTi34Lk6n+JPMJv5DDXxktaNr5MrWHbSjF
 r9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748379920; x=1748984720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TFzSUtTfTgiMH9i9pTcQPeZSP5+CvSIevuyMNiOS39M=;
 b=pH8juiOHl95FdixiKpdoFi9mHgMb9eBfhHzLnjp3qvmsRQ+6tH/nIVegpvEphTAGPs
 XUXsggmmdol/HyqT3HV92gwFJDYieGSD4IwM+e4UReMcOPP6b5f3680Un4f9qYwhqAYj
 Jw+7iwI6xWs7Stwi9XtuB8WyHYE0gapovhn0OhI1emvwdnST5LFshjTFFj3f15oqLfhR
 siCJOvbBmzsUKJYt5MXTa16P5teaUCBnk1hRjSJqpW6VDwJkq9iImIbzQIOOL+fEOd4Q
 K01ASS2X8AvXcJLyPQ51bklgl8237AvnOITqRckvwss+H9mg83VVFY0E9DFLlBIH4SGR
 yB/w==
X-Gm-Message-State: AOJu0YzLCFzpNk9TEM13/SAYLMbkiZPvcsVP40Ch0UusGb60PrzDTuoE
 +lPySegST2Dq9vJEhAZ7gqfBITwN5RGCbJGCJs+F5SgV9SN5hGeKatj9/5hxcXt1ctbjjC2ZMkP
 1yURw
X-Gm-Gg: ASbGncsiTiYxKotfoAqMceN5M/qSe6hy8p69OYIXkcWjS8lT06W/VSdU5tkKz8qpLut
 wRpcdtjJ2Yhy9mOZO0Iskr5cxP9mZm3+Uv1Vc9KoivZDZcVZ22Phrea88iJ6vRQt/kRwAYydzPd
 lci1ghG62Rr4DTjBZiTzxpkdaLNVjoG7mvquVrVzjnpQlcLZnlgKi4yOHspLowqAfNIwlX1BAyX
 weoDOVWRGzfPsnHjUGaTdOOS8vZxrCtCjZUE07tZkBx45KBIZY40xIus3+UKl/Vz7rKv3ZDXxqk
 lMSj8EWSp6/HOplSScdFC7PvvwtTIoTcEm1ZAFDIzOoEdFnuZjqHauTKDbMMC49MeDyhw0QDZsd
 c
X-Google-Smtp-Source: AGHT+IHfCKkMpso0RXwn8KGnR7Kj5bEbhyRZ+nYKL3bcmTLvfJ8SZOWLnGgeyW+y/blGNXuZYe6F+g==
X-Received: by 2002:a05:620a:2416:b0:7c5:405e:e88f with SMTP id
 af79cd13be357-7ceecbd70d0mr2368654385a.21.1748379919851; 
 Tue, 27 May 2025 14:05:19 -0700 (PDT)
Received: from ubuntu.localdomain ([209.227.128.158])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cf19d98cd5sm7249685a.103.2025.05.27.14.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:05:19 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] makefile: fix Clang link error when RSA_PUBLIC_KEY_PARSER is
 selected
Date: Tue, 27 May 2025 14:05:05 -0700
Message-Id: <20250527210508.1488509-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

MbedTLS bignum module needs '__udivti3' which is a 128-bit division
function provided by the compiler runtime, typically libgcc for GCC or
clang_rt.builtins for Clang.
Thus 'clang_rt.builtins' library is required when building using Clang.

Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f88684947ee..16506dcaec6 100644
--- a/Makefile
+++ b/Makefile
@@ -37,7 +37,6 @@ else ifeq ("riscv32", $(MK_ARCH))
 else ifeq ("riscv64", $(MK_ARCH))
   export HOST_ARCH=$(HOST_ARCH_RISCV64)
 endif
-undefine MK_ARCH
 
 # Avoid funny character set dependencies
 unexport LC_ALL
@@ -915,8 +914,13 @@ PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a
 else
 ifndef CONFIG_CC_IS_CLANG
 PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`) -lgcc
+else ifeq ($(CONFIG_RSA_PUBLIC_KEY_PARSER_MBEDTLS),y)
+# mbedtls bignum needs '__udivti3' - a 128-bit division function that's provided by clang-rt.
+CLANG_RT_DIR := $(shell $(CC) --print-resource-dir)/lib/linux
+PLATFORM_LIBGCC := -L$(CLANG_RT_DIR) -lclang_rt.builtins-$(MK_ARCH)
 endif
 endif
+undefine MK_ARCH
 PLATFORM_LIBS += $(PLATFORM_LIBGCC)
 
 ifdef CONFIG_CC_COVERAGE
-- 
2.25.1

