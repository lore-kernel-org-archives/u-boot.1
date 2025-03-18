Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCF2C28B28
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F3E18186D;
	Tue, 18 Mar 2025 11:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pV1o8aeV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B398186D; Tue, 18 Mar 2025 11:47:23 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ECD3805D7
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso33328365e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294840; x=1742899640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUVHl6Za6D6pDyge7r7bRk6nRvr2lGPQEthV8hlLudM=;
 b=pV1o8aeVGNvSL+EcEUa18EkzdpcFL5ixW+wzTCiyzkuWazmgGxFxvSu+HEbvYRrXdR
 3+/wDgk9En9k/n/1LVWDLNZ4exXeh/Ij8Sk+eqTitKRbnUf+GzSSIDbHXfqcP59cu7Wa
 9cR9sbXbWH07HN7WSl0SRCwiFdNQlRiRKjLq9Y2VY2gbSmP7/LxvudPj7ywU96wsmcJF
 lYPt9bbPGuLKlIRJcdNmgfwb1Q9cngnW4svoC5L0KMTNR/uJ1IbtZmRDztDsu7dJ1nRX
 Z5b45rtBO6B54LwYNqRhH18i6QoLWIt9wtLr08pBUHCRtLGtpqFUeSyBgyeTRQxR2pgf
 JCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294840; x=1742899640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUVHl6Za6D6pDyge7r7bRk6nRvr2lGPQEthV8hlLudM=;
 b=MNv3D9hfRFkV6PFbXo9PyHA3dk4OPIoluk/Io8UpJl4GNOrFFt1te+P36gHCTjM2QW
 +oCyZ3DdXB0HSsVQ+aJ2YNBwSI2odS7xL0XFhr5z9zj8Fk7Eqske9skRyhPb235vmq2w
 tz5ZE4snShgpJPOT5EKp7v9qkwoFXKapCPaQ7Cf++V3e09ZEZS/rrfz0vkun2bIM9ijk
 S2/HyqxZJ2/Qq5jEptBAefns+o/6bVdVHwVI1CJYPJvuxv3Q2d865PINu5VfHOJrcRC5
 P9/r0A8gYH6xmVuO3+gFKUUo2/OofOrMyjUXHIi+63WM+1yclGq1ChK8j+u1qj397etP
 ktHA==
X-Gm-Message-State: AOJu0YxCPzQP6QWEV+QQrVTn/cmthJFoZ4q1W+l/lsw8Uw5PGLzt/Cyb
 GSF5tbjgBRIz0H93DGZyWg1AIzroYc1YUURIAK1JwS018xYOGwo64/RsAQI+cHgdW7/WDbZSEVP
 vez4=
X-Gm-Gg: ASbGnctzrado2FC9pIwIE15b70SacLlI9+z+JHYLxEF/7pWpzXtE6tQYDW7UfxKiw4M
 PBFzQSczSCza0KoqNgbhiM3O6BXXr6zNhi84+oY4UDRQniwc6dNOYeUF9vqgKpMCnDFua/SB0IJ
 RJdsBZ6g27WHaTw+bjkw+Fw0lkCeSad+0wP93KrgYB2iWuXO+rg+zH60nrn3C4dG3SdK2IFBkzF
 pfeaJCW2/jjkXZAu0SNaRVVP/OxQXxIZq3TGMrRkN6VKs0bzC7Kf+WZu19LnkAfwnojcwLwid5N
 m9Y0Haij7xgtbT+sO2cMsfC1w+Tf8g9k5kolxWSJzUMSpIGSgRbp3QyfTE0nKYgz
X-Google-Smtp-Source: AGHT+IEan2OXN3OsRyMPtlJQplUgcTC1isxr68Pd206+AxRnsBcm3X91aeRQSTBtzBH/vEUFrgrhJw==
X-Received: by 2002:a05:600c:19d4:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-43d3b951a04mr15716535e9.2.1742294840522; 
 Tue, 18 Mar 2025 03:47:20 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:20 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v4 01/14] arch: introduce initjmp() and Kconfig symbol
 HAVE_INITJMP
Date: Tue, 18 Mar 2025 11:46:37 +0100
Message-ID: <20250318104659.1114340-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318104659.1114340-1-jerome.forissier@linaro.org>
References: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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

Add the HAVE_INIJMP symbol to be set by architectures that support
initjmp(), a non-standard extension to setjmp()/longjmp() allowing to
initialize a jump buffer with a function pointer and a stack pointer.
This will be useful to later introduce threads. With this new function
it becomes possible to longjmp() to a particular function pointer
(rather than to a point previously reached during program execution as
is the case with setjmp()), and with a custom stack. Both things are
needed to spin off a new thread. Then the usual setjmp()/longjmp() pair
is enough to save and restore a context, i.e., switch thread.

Add the initjmp() prototype to <include/setjmp.h> since it is common to
all architectures.

Add an entry to the API documentation: doc/api/setjmp.rst.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/Kconfig       |  7 +++++++
 doc/api/index.rst  |  1 +
 doc/api/setjmp.rst | 10 ++++++++++
 include/setjmp.h   | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 doc/api/setjmp.rst

diff --git a/arch/Kconfig b/arch/Kconfig
index 35b19f9bfdc..14111ca14fb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -13,6 +13,13 @@ config HAVE_SETJMP
 	help
 	 The architecture supports setjmp() and longjmp().
 
+config HAVE_INITJMP
+	bool
+	depends on HAVE_SETJMP
+	help
+	 The architecture supports initjmp(), a non-standard companion to
+	 setjmp() and longjmp().
+
 config SUPPORT_BIG_ENDIAN
 	bool
 
diff --git a/doc/api/index.rst b/doc/api/index.rst
index a108718ea99..0dc9ad45d41 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -25,6 +25,7 @@ U-Boot API documentation
    rng
    sandbox
    serial
+   setjmp
    sysreset
    timer
    unicode
diff --git a/doc/api/setjmp.rst b/doc/api/setjmp.rst
new file mode 100644
index 00000000000..7718047085c
--- /dev/null
+++ b/doc/api/setjmp.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Long jump API
+=============
+
+.. kernel-doc:: include/setjmp.h
+   :doc: Overview
+
+.. kernel-doc:: include/setjmp.h
+   :internal:
diff --git a/include/setjmp.h b/include/setjmp.h
index 37d3a8af85d..32dd48803e9 100644
--- a/include/setjmp.h
+++ b/include/setjmp.h
@@ -3,12 +3,27 @@
 #ifndef _SETJMP_H_
 #define _SETJMP_H_ 1
 
+/**
+ * DOC: Overview
+ *
+ * The long jump API allows to perform nonlocal gotos, that is jump from one
+ * function to another typically further down in the stack, while properly
+ * restoring the stack's state (unwinding). The two functions needed to do this
+ * are setjmp() and longjmp().
+ *
+ * In addition to these two standard POSIX.1-2001/C89 functions, a third one is
+ * present in U-Boot: initjmp(). It is an extension which allows to implement
+ * user-mode threads.
+ */
+
 #ifdef CONFIG_HAVE_SETJMP
 #include <asm/setjmp.h>
 #else
 struct jmp_buf_data {
 };
 #endif
+#include <linux/compiler_attributes.h>
+#include <stddef.h>
 
 /**
  * typedef jmp_buf - information needed to restore a calling environment
@@ -37,4 +52,21 @@ int setjmp(jmp_buf env);
  */
 void longjmp(jmp_buf env, int val);
 
+/**
+ * initjmp() - prepare for a long jump to a given function with a given stack
+ *
+ * This function sets up a jump buffer for later use with longjmp(). It allows
+ * to branch to a specific function with a specific stack. Please note that
+ * @func MUST NOT return. It shall typically restore the main stack and resume
+ * execution by doing a long jump to a jump buffer initialized by setjmp()
+ * before the long jump. initjmp() allows to implement multithreading.
+ *
+ * @env:	jump buffer
+ * @func:	function to be called on longjmp(), MUST NOT RETURN
+ * @stack_base:	the stack to be used by @func (lower address)
+ * @stack_sz:	the stack size in bytes
+ */
+int initjmp(jmp_buf env, void __noreturn (*func)(void), void *stack_base,
+	    size_t stack_sz);
+
 #endif /* _SETJMP_H_ */
-- 
2.43.0

