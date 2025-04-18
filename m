Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B61C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1413E83264;
	Fri, 18 Apr 2025 16:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wMpmiXWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5DBF83249; Fri, 18 Apr 2025 16:11:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F01D8324C
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf3192f3bso18094815e9.1
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985493; x=1745590293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wE8Fj4ZBUDxONpVurV1GP5HifIm5+3mqTIntosh6lTU=;
 b=wMpmiXWXNqc+YEB5ZEj7kWvuELq/OJtGKNuTpd1Qm4KVWMFsKOPXiHnn0KXmAGuC40
 5/v88D0JLZNRk+EyY1yRIGt17VMpmSKkPBoB/0Xvvg1/tQJGHkr3VlIH/lhuD2ae/sd+
 /zbIA5ecFTjFfaL33l5PtzM6ndDaL6vN4ASlfsMc8QzBj1a5HIMl3y4vQx15Aul7YCoN
 XHXaBxLk2m5FA6cr079IhaHwdWTTDqurZbDiWs9ANPhhLgUTzU+Kpc69n2OZyoBOJiWE
 PQDBL2/J4DtZe8bnnAsaGEcKof3pZAdoleEHZIK/ZhtPLcN9mYO6NcRijmE6/Ucn1v8G
 Iy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985493; x=1745590293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wE8Fj4ZBUDxONpVurV1GP5HifIm5+3mqTIntosh6lTU=;
 b=Pi6W2daaHJLqMaid/H8rEaLpPIEveHVFJnjb/R5vRqsIN+Tc56CptRxGFTfEiyt1R6
 sYaco+Hj1WdC//hHIsDjFfb7hgbOzQD2wLfcaVWEOu1iOM1Cm+TAxJNNkal726wfd99n
 Q94lTr+Aci2tMwlRKfUBt83nFFJ8GrcoS90K5b6J2G02tc0jaMel4bBRpcC0sT5qxDM2
 gpZOQFbOgC1L28xoY+XGCA9J5fT03tbtMVhpSSUTYMyJzTRCzdQWjUzaJXk75dYW7DAb
 3TVGCi075mIYXTnr6tPJSqNIxsI7Q+Jk5KNo47WkyvhhsGNmBO8sDtsYAAuusE30ABAH
 Tp7A==
X-Gm-Message-State: AOJu0Yz263yvbbRHFMsG2MhxIkf/qcz3/AaoAzhlFz9zo+BvkODtl8eC
 2lFDUkOEjaYrVxc/cc+8uW0M0Jp40ByS8OO/ise6epgQbG3t0oIDcNS2i8Is2aevhTgZOTpTB0c
 BLcyjaQ==
X-Gm-Gg: ASbGncvLBJJf7X5lMjmaEBbDXpdFrXnvDxTdyGf9jIekvIcS9BuM256EE47yjuQLvTd
 8Of8rPLFh6023Pudoi0PDGASjR2uRMskvkKCVue9n64u5doXJdAR2FGchkOEUU29tZWatzgVvys
 u1oXhbsJ93WYgfMVCHNU5xCjTFnOtWkes7LT+nqF3FnweKbUyhG43pZ25png/sLzPbwCb5XRr4N
 ATiFjh34o5zXmr1r0gb3MJ8fm3jFalYGwZhpi/JDURHdG4aO0sBTFU2jJYNhR/Dek6R8Com7bdT
 zy/czXJxLVd+tKE7vCjDEo3C6qAbeNzNXxq6p/3OQIKXefCew26NIsCbcRaz
X-Google-Smtp-Source: AGHT+IGzO7Xa9/tAPuV6emxYbkylkQ29gUCW0+cPCzbozFl5xT+YMt8HsNH439c5cuhL1K3osvnySg==
X-Received: by 2002:a05:600c:a06:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-4406aba7201mr27027255e9.18.1744985492652; 
 Fri, 18 Apr 2025 07:11:32 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:32 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@sysam.it>,
 Bin Meng <bmeng.cn@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <monstr@monstr.eu>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Scott McNutt <smcnutt@psyent.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Thomas Chou <thomas@wytron.com.tw>, Tom Rini <trini@konsulko.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, Wolfgang Denk <wd@denx.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v6 01/17] arch: introduce initjmp() and Kconfig symbol
 HAVE_INITJMP
Date: Fri, 18 Apr 2025 16:09:29 +0200
Message-ID: <20250418141114.2056981-2-jerome.forissier@linaro.org>
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

(no changes since v1)

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

