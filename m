Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84A4C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 627FB81E47;
	Mon, 31 Mar 2025 14:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c+MuyaHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D2D81F0D; Mon, 31 Mar 2025 14:31:38 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 902E181E6C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so40554955e9.0
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424296; x=1744029096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwIiwSIVCNOG7AvHRdtrv6FKroYqnkWvT/sitGZCSNY=;
 b=c+MuyaHk/VyIPlBRVaxD7zsd6jTL4pC4lJ8pE32h4dyY48rtKR9A/DqFYTGO4WidGl
 CjurU+SlbMxz8g3fRBLklod3u3goIBiBYnnEB9f7Mh+cZrMJHgPQu71zibxbfrBKWj1b
 s2bRxcl27sHk+QTT5S93sRtuNc0bz9W1E2OpH0CvEr4lJT7ZYSQIdZPw+PXnpGMJjIxP
 MxCr6QH2MrmgrpAMx5EhaT4w2rz5uEJPXEZiXgSuroMLsH7kegEmjLnNTXF+ZufVqoQS
 1pNd+fqHswVOzMRA+XHZJcm542gj1KYfR+8IQIOWTDj/mSKYgA46c6sI4NNubO6SE3Rl
 RWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424296; x=1744029096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwIiwSIVCNOG7AvHRdtrv6FKroYqnkWvT/sitGZCSNY=;
 b=t+4DOQnjQASx51mCku1fvoILVRnPI9cryaxZhhYz3uE9BTgcwf719UbRnTiDz9cmMl
 PptPybSYqKcjl37VCHyLrE0v6g2VJnBPDZIzOIHNlCnhg34IE1KjvX1ZkUZqZ+9YgMHL
 qvBStaxXJ2A14UjssWENjQoh9seTEq6Cvu/xeZJbYquEGIG9I2pyx9YGI+jLsKKyDyXH
 pqEsQv0X34Wshc8/ymU0HwwqNjga4/2Mju/63gGNqj9n5PSOtM339glO4AWDD4kny5Hw
 l4yQRp9OPoJlXEe5M568dzljHHYwYpcPxoWDoNN/Cd9o8IB8UqSxPJ99s2f5cPCmAxhu
 quog==
X-Gm-Message-State: AOJu0YwOSW1pVQq30IqH6k7ErWpUEkN48D/MvHx7G1OlJrY9wTiL7DYV
 m4oyX7mbjEm0NY/+UPGHGbCWL1bh0ahT+oq/cgQTAKayZPbW6BGV+KKK5HapF36BbYQCCRU0eW9
 aNPbZhg==
X-Gm-Gg: ASbGncsxBLOLQhl0+pLBK8rETz0/T96z5OKQNipO7oHuaPDzHD9OKE/rq5CjZpHveKy
 puP/ybaTKwqrbUuVn29whfDstSrafjVeFLnskJ30GyEXX2kX7FM7jCUietFoh86Y9H8locu49/d
 U0NbLZJ+0c/jjFSOJZF1BHvW6kQQTzQ5ZtqTOhVBjoMfGkivsKwcT947EgYEw0CpL5/YnpOpH57
 3DbQfwzgEKnfh0DlbuFxpDlBxRXeTb5wV6RGwM3PwBX7v0QaEL0jOobhiSpBDw5+XChay/dgV8d
 wbS1IejkKrnEROOoEBZt5nazfFx0jLB+vJ1O31Ghogz23hIRBve+
X-Google-Smtp-Source: AGHT+IFSnBoam2fGI5CX5B5Y2WZ1kvein+yW0+lzDADn0tJLDgj6WTxYKdAc3yfuMm9GAkd/+UK8UQ==
X-Received: by 2002:a05:600c:a03:b0:43d:94:cff0 with SMTP id
 5b1f17b1804b1-43db62bc167mr70884545e9.19.1743424295767; 
 Mon, 31 Mar 2025 05:31:35 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:35 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v5 03/16] riscv: add initjmp()
Date: Mon, 31 Mar 2025 14:30:57 +0200
Message-ID: <20250331123120.2025062-4-jerome.forissier@linaro.org>
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

