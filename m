Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEECCCFA18
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 20:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6912A83EA9;
	Sat,  8 Nov 2025 21:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fePDmQ5z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D748B83E83; Sat,  8 Nov 2025 21:48:52 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF95483E63
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 21:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d3dx12.xx@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b7291af7190so278284066b.3
 for <u-boot@lists.denx.de>; Sat, 08 Nov 2025 12:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762634930; x=1763239730; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V8jlBs+ds0kcjHsnZS492m2og17rADK8DdJi/HEd/08=;
 b=fePDmQ5zyNanoMB7WVvQUeKTo3y9Pa585JNUWwU0ZCXcDzGXKLncKImUi0hd697Um8
 x2q82hS98/BgNrW/pqE/42PGkY2CGazGGUdM3UfwSLsjE5Uqm5XGZz62qT99qDJlPjes
 MXRvAou59kaiW6+pNqIlrvZwFy9q/quZBMTsPbzZBROKhsVzDjsksSHAwxmlZts82qAR
 uSP4AE2gP6sRPiwPSvMTTloTBL60NejtmYbATizwH2zGhje+Raje/0QdtOAEzWfWe5OZ
 lRSbJZTTqE3azdgSPddd3vf+aHA1XNHkQu7l4TSYvse1nx2j6CcyWt0E8iISsptL8N3M
 ms7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762634930; x=1763239730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=V8jlBs+ds0kcjHsnZS492m2og17rADK8DdJi/HEd/08=;
 b=jpnYdfa7WC2PuqElXR0rt6MaxDgt6OIfS+5Vc/D3s3Ji9Wi+7cs/noRYLDchCOPUWz
 iRRxEg+32pAH9Dnws++uh2IstNS5RS/NTcWVMhxr4EXLNOMFF4scih8qvrmIxWp8+vUZ
 89YrNp9zlw21xUtbVSUZZI4DE0otM/CtVMYSQxXSeO1vMivhnvfXmI5123A8S8rcvom0
 3BhllBZrLzoktHWSXYqugf6zwkM/kH6UkqVJ7gOMMFp0giQIqaYspmPYyCa3ktDr7MyY
 JSr0vRQtc6M565/bRUkyAAy6sVbJrlymDFTo1W9Q+xF5vxI/nAM2xg7SvwpaXh7z5YMD
 uM1Q==
X-Gm-Message-State: AOJu0Yz1Hg+4Di6XfN97ScpWdAskUMyahh37NyVtEhFsrmd+x2yJhkV9
 2bsK/5XK/e1EzC2oXBP54nKecViaxKWMXKYK5gBgjKnAM40dPvbeLS3j
X-Gm-Gg: ASbGncs5feOcn3Ctf1gnMguJFOMmUQwVK/pUOKxcUSuK2JMmtBeqYDl433XEBXIwPuN
 zOLyvvGd8HjmOhh9DT72w27KyFs28LWC/GSn5s9u0PZnM6N5mfiFkqHMVc7m6xSvYl2ZSvY79Bd
 pQ44qRPMg7cNRyzxkkfDtAC/hl6DsPqWQ0dpDGUFk0NOhTx3JpMdpBQIGxnGVCsZJzmO+dhfgGv
 jatgUIfqrH7sgZrnuiC0eoCgIuArr+f4xIEek9AvJz2DeCW7QCNrsRGH6PNC2eFH2d/TuTzWlrv
 861oQXG3/rDsyCo+dBy/wWP0C35ZdaiHdAVJeOctMQjhS0W5XSe1btO7mKF6qLrwpoGqNWXwBYc
 8qqPhFdD/JkiIsNJFH7ZMBwbCYwPsHvQ+3dPdRTwRozBN0OS7zYE88Vg3B9cOPFpgcOfUWBQQ8x
 G1LsqnUNFWjF/jw5w77ElCSMs7DrVU4xNnDdU=
X-Google-Smtp-Source: AGHT+IG179WY5GkneCogeAhIGa9Jc7BDhWYOCuudukmKR+cQmmYpeHs/yZLIutoZB3pE6uezDoYVwQ==
X-Received: by 2002:a17:907:9812:b0:b71:34c3:d5a9 with SMTP id
 a640c23a62f3a-b72e03ee841mr296295066b.38.1762634930342; 
 Sat, 08 Nov 2025 12:48:50 -0800 (PST)
Received: from [127.0.0.1] (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9bd3d1sm642067366b.58.2025.11.08.12.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 12:48:49 -0800 (PST)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Date: Sat, 08 Nov 2025 21:48:47 +0100
Subject: [PATCH 2/2] arch: arm: fix AArch64 builds with Clang 21+
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-clang-cross-fixes-v1-2-ea6c4282844a@gmail.com>
References: <20251108-clang-cross-fixes-v1-0-ea6c4282844a@gmail.com>
In-Reply-To: <20251108-clang-cross-fixes-v1-0-ea6c4282844a@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>
X-Mailer: b4 0.14.3
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

Clang is strict with respect to unknown options.

Therefore, only enable AArch32-specific options when CONFIG_ARM64
is not set.

Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
---
 arch/arm/config.mk | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/config.mk b/arch/arm/config.mk
index ba7dd99672a..73fddd50bd7 100644
--- a/arch/arm/config.mk
+++ b/arch/arm/config.mk
@@ -30,18 +30,19 @@ PLATFORM_RELFLAGS += $(call cc-option,-mgeneral-regs-only)
 endif
 
 # LLVM support
-LLVM_RELFLAGS		:= $(call cc-option,-mllvm,) \
-			$(call cc-option,-mno-movt,)
-PLATFORM_RELFLAGS	+= $(LLVM_RELFLAGS)
-
+LLVM_RELFLAGS		:= $(call cc-option,-mllvm,)
 PLATFORM_CPPFLAGS += -D__ARM__
 
 ifdef CONFIG_ARM64
 PLATFORM_ELFFLAGS += -B aarch64 -O elf64-littleaarch64
 else
 PLATFORM_ELFFLAGS += -B arm -O elf32-littlearm
+# no-movt is only available when targeting AArch32
+LLVM_RELFLAGS	+= $(call cc-option,-mno-movt,)
 endif
 
+PLATFORM_RELFLAGS	+= $(LLVM_RELFLAGS)
+
 # Choose between ARM/Thumb instruction sets
 ifeq ($(CONFIG_$(PHASE_)SYS_THUMB_BUILD),y)
 AFLAGS_IMPLICIT_IT	:= $(call as-option,-Wa$(comma)-mimplicit-it=always)
@@ -50,7 +51,7 @@ PF_CPPFLAGS_ARM		:= $(AFLAGS_IMPLICIT_IT) \
 			$(call cc-option,-marm,)\
 			$(call cc-option,-mno-thumb-interwork,)\
 		)
-else
+else ifneq ($(CONFIG_ARM64),y)
 PF_CPPFLAGS_ARM := $(call cc-option,-marm,) \
 		$(call cc-option,-mno-thumb-interwork,)
 endif

-- 
2.51.1

