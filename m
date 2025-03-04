Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACF0C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D69CC81253;
	Tue,  4 Mar 2025 16:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IZZGeq4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDAC81433; Tue,  4 Mar 2025 16:32:21 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B698142E
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390dd362848so4517591f8f.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102286; x=1741707086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6HQ7yLaCV2yD73oy4V3ghzdBT7DFF+iSIvgXL8Pym0=;
 b=IZZGeq4mZxis+YdSrAUVbL5gmsDjlhWRt2H0gZ1rzcamhRi/LgvvXskMMVGpDRgb2x
 MTF7gkj4OBcEa1vS8GcEusJs094W7i6VR/D427aU8/dfhPcdoIzJU3AflZ9A+hAEup12
 UGW94dXEUmI/mXo773J5t8yxFLVjogZjZlkx9RVADuuxNjqDj31c5GgEH8hIgZIPbr+1
 RE04f0yTr6MjEBxsOeE1AmMy4e2M7Ngcshx74BQzOTmbMV2KSXa4ZQTZD02NHp/dL+Rg
 B0EKDF5i97H+4/T5/Oak6UlaEzTqR9eM6DcSbjcGFpdTwWnW+DOWWT+UvcyzZHBlIdT8
 YOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102286; x=1741707086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6HQ7yLaCV2yD73oy4V3ghzdBT7DFF+iSIvgXL8Pym0=;
 b=qu1XEXea5V3tvJ9fIjVWZ2eMogAYWbObkGvs4KaQ7oxCDn9AbZsZNTYRDorC3SRHEZ
 WY5Q3+YnWGDSa7/115YFR70oQWh+iPbBX6a1LKKp09aULIbai5pipBnHH/eHZu1znR4u
 yeQnGxIEoJF1+PNykMJsEy0TCSg9cHrwLb+g4fNpeM2IxwziFdYXvf0h0zgTZdXjdBY5
 HpIaT/4bjCaFYJwAVR0m1U129bMjkjJeQHxzShtnMquBmrEaAOTZCuY4Pxzb1ErnBou4
 gzVnini0Hd5tnhAZkb1fXJbtK/Wyb4ooSuJu6nU3D9qyHo0dLDTim7P5llqDwJgLCA5T
 V72g==
X-Gm-Message-State: AOJu0Yx9zF3ZnrRnxUois32Y+Dc7Hv2/O8D2cHf6zF8yix1qFhKXKmQ3
 rxEhoS2sCxmfI5yNh/8KIw8WndAFaXKZOoILf0Iuusn1JYS7iXnygnN9SGI9b51TIAiDzO12343
 v
X-Gm-Gg: ASbGncuq0zL4bb6fFHxC3bSoYdWpzfI65m90qU6Lmglq2Dt5KgylzhyE4/FI7tN/sMJ
 Mk/HsVCqn3ervL0WElyTX66VPLxxpHS0735+so2WM1OVIpM/2C3nFRA4juI2n2aRJWBC7CLwP58
 MITk1yA3gSLd9r1fd9pUkwPwGcAhmU0LewmT9P34iMR3WXM9Nv86f2ffJUTitVHLJionurgOV3i
 dmqPTCDXHfRI+8GzgdMgz/b1VN2vDIPltE1jzN9IfIAMUWzLNJI7N5UmpqyfUe/AwcVl2Xglv+H
 PAd7FVDtOMe68auwfowU6WCm6ycNcUC6D+I0pji4Df348CcrC4TGyQ==
X-Google-Smtp-Source: AGHT+IFyGnyIgDeg4BGgGV2f8UDHWFsZK/XeE6RtqRrU1ifILfIHlB/sE+UqSWcqDxHm3nqr95pe2Q==
X-Received: by 2002:a5d:5889:0:b0:391:1222:b459 with SMTP id
 ffacd0b85a97d-3911222b5fdmr5267410f8f.49.1741102285576; 
 Tue, 04 Mar 2025 07:31:25 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:25 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 01/14] arch: introduce initjmp() and Kconfig symbol
 HAVE_INITJMP
Date: Tue,  4 Mar 2025 16:24:49 +0100
Message-ID: <20250304152510.2832340-2-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304152510.2832340-1-jerome.forissier@linaro.org>
References: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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
 include/setjmp.h   | 29 +++++++++++++++++++++++++++++
 4 files changed, 47 insertions(+)
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
index 37d3a8af85d..8b2ff66a4c2 100644
--- a/include/setjmp.h
+++ b/include/setjmp.h
@@ -3,12 +3,26 @@
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
 
 /**
  * typedef jmp_buf - information needed to restore a calling environment
@@ -37,4 +51,19 @@ int setjmp(jmp_buf env);
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
+ * @stack:	the stack to be used by @func
+ */
+int initjmp(jmp_buf env, void __noreturn (*func)(void), void *stack);
+
 #endif /* _SETJMP_H_ */
-- 
2.43.0

