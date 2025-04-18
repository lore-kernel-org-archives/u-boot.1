Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E48C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 14:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B491C8329B;
	Fri, 18 Apr 2025 16:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JimfCtRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 592BC83287; Fri, 18 Apr 2025 16:11:37 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8C381F45
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 16:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4394a823036so10485375e9.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744985494; x=1745590294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjN9f8+RKUCM1bfAsnKFxh2T60ROTFd40n0Hwh5GyX0=;
 b=JimfCtRIAqWr8buAzsgg3bTcq9AvBdLJezOF/GrX+DoOwfOAH6dbx2yZGPF1gFfONk
 Cwb7gFi+U15upS8pgwFIOsrr3ReUNfO6fTentcF6u6uDS9PNfSfdOLmi5oNYrkKAqzm5
 +qc5GLyzpNJH6ir9CXIA2VzCAsXgklemDTftL7UrUPBkwefYDlZQDE//R9PM0Z2hFNYn
 2hgxf0C0tPYhowEh6vNpLOcvs+85xnCNpUuXvGFrMxwwqceeB8iYkIuJIqloKBfT/mGT
 7PU5zRGhmFXNy64f0tQDatNnz2yYPAah6uVDE8QkFlmb4xJsSRBNg3SpHvGP0M0GX1bV
 kN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744985494; x=1745590294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vjN9f8+RKUCM1bfAsnKFxh2T60ROTFd40n0Hwh5GyX0=;
 b=EOJTUc6V+3kUnyRsK2TP7E4tDh++JbxapZzELDhbxzWLETN7yJxSmQhkRsjQ3NKswi
 N4X9s+a0sWCMnN3qg/sZ9OXeJzUhFf439fKDv5smwE/fR2MGWOcOPw1dqcWt0NwlBBTF
 yO6s7Li1KVtr3aez4/h5USr+xqVqV6YMWbcCYZnBs+bsOLbkpaZMKUH6yREtHMMJepTA
 YGPB8FPLXfgO5Q6KTzUGaChlLNgcn9vUcMIwlr4PSUqMtlZT1Ma3PwEL0oOiZb9SwtW3
 YB2SopkW1cG3t0JJ35pD6qpRJEINQhALKuIryh+poqTupAZ76CS3rg64L/UXvpMNEO57
 EMSQ==
X-Gm-Message-State: AOJu0YxBgmEhZdzLGGj5C41SMDv4imfdEi6++1Ehc0/HTL3BIK0jWmmn
 JkL43C57j+WXpgYFhVhPto29OjcaPdKytJxoRjVdOwIDSk8NdQzO1j+g0kOZtlNX1dYNPyJcgu8
 gm6tFmg==
X-Gm-Gg: ASbGncs77+sA7qlbx5FZymvp09qkKqGm6pnIfTNVqtRMvVDbRGNt+kjyiRqwOCCcZG2
 dmwZDaPX+ahy6zPNGMz8yRHc4JGbsIBL/LmB1FcmarZSXlgVAJmRaqIkS3BbebjOEmFEOpWBdyG
 loyblQe2JZC984uBG5iuk5CXGfibneLD5mel+NKxAzE/uvaLZAtU1pURXq3fwehM8Qv9ge8nrH2
 I8UQl+acjcItSsCFri1ts2Cf95CHFudqFEgGsJ3++Hf5UnvY1X4U2HndAfbjQEpm3lKN9AAsCsl
 sYWKCVF5j3Yyh7W0a1Z/jC++M7xKJfXtVhAh/hQuY94OsQUuugprfGiNhG0t
X-Google-Smtp-Source: AGHT+IFo+q4N0KuZWO+cglZvw5xl4HRBjhlqoRlmbn5E5SyEVDd3r6gF7hC1S9tdehmR/9/JB8HcPA==
X-Received: by 2002:a05:6000:25e6:b0:39e:cbd2:9ad4 with SMTP id
 ffacd0b85a97d-39efba263e3mr2007719f8f.2.1744985494519; 
 Fri, 18 Apr 2025 07:11:34 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1526:5ffd:d63c:cc85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbcc3sm23734385e9.19.2025.04.18.07.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 07:11:34 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yu-Chien Peter Lin <peter.lin@sifive.com>
Subject: [PATCH v6 03/17] riscv: add initjmp()
Date: Fri, 18 Apr 2025 16:09:31 +0200
Message-ID: <20250418141114.2056981-4-jerome.forissier@linaro.org>
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

Implement initjmp() for RISC-V, a non-standard extension to setjmp()/
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

 arch/Kconfig            |  1 +
 arch/riscv/lib/setjmp.S | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 7a3141e92b3..aa60c5ff03c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -153,6 +153,7 @@ config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
 	select HAVE_SETJMP
+	select HAVE_INITJMP
 	select SUPPORT_ACPI
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_OF_CONTROL
diff --git a/arch/riscv/lib/setjmp.S b/arch/riscv/lib/setjmp.S
index 99d6195827e..9e1f3d5749b 100644
--- a/arch/riscv/lib/setjmp.S
+++ b/arch/riscv/lib/setjmp.S
@@ -59,3 +59,14 @@ ENTRY(longjmp)
 	ret
 ENDPROC(longjmp)
 .popsection
+
+.pushsection .text.initjmp, "ax"
+ENTRY(initjmp)
+	/* a1: entry point address, a2: stack base, a3: stack size */
+	add a2, a2, a3
+	STORE_IDX(a1, 12)
+	STORE_IDX(a2, 13)
+	li  a0, 0
+	ret
+ENDPROC(initjmp)
+.popsection
-- 
2.43.0

