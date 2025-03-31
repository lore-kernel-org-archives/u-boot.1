Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D625C3600C
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:31:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5B9A81EC0;
	Mon, 31 Mar 2025 14:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wO7VNb/2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 598FA8171B; Mon, 31 Mar 2025 14:31:36 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1BE819D2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so27519535e9.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424293; x=1744029093; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUVHl6Za6D6pDyge7r7bRk6nRvr2lGPQEthV8hlLudM=;
 b=wO7VNb/2rAv+poPD/hrvAuxXF4VX5v/7GFc125PrMHqb5URn75YisX7BdFsjEchF0x
 uuTXomFvo4ajwO8T6EJf8/ZW4lnYxnxEFmCaeMPiPrlaiDcKjUmFMHJ1jjfJMUsBgAik
 f8baD9d9SMAffXCb1w0gnGCvBlKpxZAy2he8YG54Y/94NAsEGeG7Nls5YUNV2r7bJInO
 3506yHG5E8qrJrVM1Ji1lsOhDOL6mhpPziGmnQoxNkzeMofAzM8C1Z/hI5e5WNaMPVjj
 mECeewL3fPNRLCs/AoCp8xmx6DTYTLxdmMjJXbNAJF59l1olH8Rf9eU3rpK89sl+sU9u
 exKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424293; x=1744029093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUVHl6Za6D6pDyge7r7bRk6nRvr2lGPQEthV8hlLudM=;
 b=srlovk7QqHT4sEhVMnQBkOBkdlmN0zQ4IanZW0UlVhS7u7kJT0KeJH5Etrb80c08n0
 nRDBF36/TEspIyzmD5wj/zWZbBHFTMb4OnW7C94MDxuTXHJcRYuvMeEFskRtW+rJl0xo
 mwMpg/wJBxIGF7l42FY9ZByl0fZ18TMwMr74mLYVc9T78mXe780eyo87iKatN+ZF2IHk
 b831l+d9Q5xd0eSe1Cfjv3uDAMHpv4qg+8sGvxXWhOBETTdmyrYL/pozeuON5dPuIP+v
 l178AhgOkDRGq2DE/zdHyZT+YaOKgD+PGb/CaBfLGNUipPx/wEZlB267H1CXB7d4IqCY
 Bp+Q==
X-Gm-Message-State: AOJu0Yx6prvUrpNi9W4BbGiqJTB45qfpPxvyPFywCK/v1/YYkeygw+Nr
 Kt6JPzGfBMFPtcx8bOeF9KTzuM7p+16ev1QGxou3wKJt1u2X40VW6c93bGmUIogHXXpyuU+hTIU
 +DmA+8g==
X-Gm-Gg: ASbGncvyikLUpHWIIXvrZRvkGy5eZ+okf2F71qnvIlV/aCO4u09w3o7CwzJXJoM5dRu
 oQ5ZUswBaScJil2QMP8RNLtFDSLTCTDbU1Y5y81SmqVeGO/mJqHKVr3jD+JWgKwRrzTW7UNlzuM
 tPT/3J4suTs7mxU2H6PwjjEE6AlRgnyGf9LY6uG/DDAG0zv7vPLyWBu9hyKW+uSJeopgP0kOQvy
 oaULYIVrzbUSwRUYvfNuZLJ1iI77p1I5pyY7uttnVEInUzN88iLFWgP9ZNLf/AGcAN5w2KROJpI
 JpcY8/+HFMESMNU/Xqn95OvsvnDbYjgr0owo+1HUUS0XXBx044Cf
X-Google-Smtp-Source: AGHT+IEiqwawpQsivBeo1sEVdwTTYbEOkko9sPyEmT7pd7F2sqhDNdd16K6KLF9u+kmi1EYjrDR4fA==
X-Received: by 2002:a5d:598d:0:b0:391:6fd:bb65 with SMTP id
 ffacd0b85a97d-39c120ca6c1mr7269090f8f.9.1743424293443; 
 Mon, 31 Mar 2025 05:31:33 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:33 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v5 01/16] arch: introduce initjmp() and Kconfig symbol
 HAVE_INITJMP
Date: Mon, 31 Mar 2025 14:30:55 +0200
Message-ID: <20250331123120.2025062-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331123120.2025062-1-jerome.forissier@linaro.org>
References: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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

