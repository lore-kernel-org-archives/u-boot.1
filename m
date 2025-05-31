Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762C3C5B543
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FE4382CB8;
	Sat, 31 May 2025 10:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CHXkuA9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC8A82CB8; Sat, 31 May 2025 10:45:16 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BCF82C87
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a363d15c64so1855572f8f.3
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681114; x=1749285914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hk11AmUhtMKK2sGAi3ks1yN2Tbkx2BHGdAuHecjE/w8=;
 b=CHXkuA9Thnh5mrI3TE0Ee2kYcMoyQNCu6pVcRjPJTSNh0/L16vzqJfC6L+Q1GA6L0+
 RBT/+4zEsKTMsgtezUmpDbglbZXrtd/a7NRUZpVsIeEv1GQeQEJVdS41I5Wgr2rbUBcH
 dYYsk1EwbPgMJu4FKA0Glxbd6jxrjTWG+xxww7PhqanXk+umRG1gcmK/xB9u0bilukfZ
 mzg2hWXmkdzgZ74D+OYPhUTqgtX4vA6fWIHsJdKjG+FDElw/PXx/S8AC+rQcNWUMOsdJ
 aSMqUMozf2wfd/P0cBWBA+T2pqsgM13GC/5eCZwlWjflcYwU3sIsgUiTDKNyN5zpjZJn
 2pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681114; x=1749285914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hk11AmUhtMKK2sGAi3ks1yN2Tbkx2BHGdAuHecjE/w8=;
 b=YJPOAgmDsAhqTpcUpD6uUTcVH6fM9G3euB2S6XhVfTmmTF6HK09UBt9ft4w7ovvMCi
 KZ1wX+gTPk4bIpTGKQ/oiDciBwFNh/XfCrTHkWQU7t93lyjNDz//eVSrVa/65OlOKT5y
 G4KwNGaL5r8VCr4B4Z8GzdeKzt1cvphWnVSWHXiA+DKm3QE5OL4qkBQVQXMYseZR7h27
 xTdb66fQehwM8ji8tRxET2sJkwIxweNg4LlEzLjfJUPpHfQAbrZFIn8Rdf79qPMuOzyg
 7L5iDvCb6GUlZxPYsSgmCwZ6qIPjlArt+/JrdM9YxSC4OGLJucExN2L5sW+0wZREv9D+
 x+cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4esC4uTu5obRu+4Rk9tRzX2nJ71MRNo9c6oW6cIiJ0hWwjci9WDZoPCrahSou7CbKHQBy0pQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyfUorH8ztXVdTNV/wqThSTVWJrSjNSj5JYkaQRkI0S7f/HOa/X
 yhb64IbGaqwCu/2IS3/7BSTha4TyNta8URGlyRdAMGhbBGRH5VE4aowahowMQyezMFI=
X-Gm-Gg: ASbGnct5/WEOB/eLO9p8LLBu81/QBoYlDZToEUjeNKp/SAcvyViUDiZW5J9ce6zLn4b
 WLJV6c5IjcGaSvAgK/+qO2EExk+5mzQDhO/cpUCNOBErClAQxkFPeqKe34se3zpe2QNP8UesrAc
 0Dy+jO9y1lNbeTu3oZLFuIrwYHo8RKTGgP7knJaTdDYpoaEdP7zmTWzNoVWTlOJ8VnQAf6fo1cd
 8YyJHBjtOFzNOSHVGdN85n19C4ziHVjGMyaLsZl6hq3v9FOqt1nxqJtPqBW3jOkx/GDondXDN7S
 e4xCb11D4ZkjHwrIk0OGrEBkmDlxD9lgqsL5QRgwZf/R8L7J2sgXsrUrdVYd1NNTk4lGDxz+ijl
 WDtDvaSxknKQMdqkzW9IrBp/ocx5kPGNliz5M9tDa
X-Google-Smtp-Source: AGHT+IFmKqmNvM4N3DJv6uecmnt8csxvzOa1X5m4hc2L0CWselqAf4r+OLXEa0r2LaiteIALyJOl/A==
X-Received: by 2002:a05:6000:420d:b0:3a3:7753:20ff with SMTP id
 ffacd0b85a97d-3a4f7a36f76mr5238544f8f.35.1748681113653; 
 Sat, 31 May 2025 01:45:13 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:45:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 10/13] kbuild: skip parsing pre sub-make code for recursion
Date: Sat, 31 May 2025 11:44:38 +0300
Message-ID: <20250531084449.4125187-10-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
References: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 221cc2d27ddc ("kbuild: skip parsing pre sub-make code for recursion")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 19fa77953d2f..24d6cd8fd7aa 100644
--- a/Makefile
+++ b/Makefile
@@ -51,7 +51,7 @@ undefine MK_ARCH
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
-ifneq ($(sub-make-done),1)
+ifneq ($(sub_make_done),1)
 
 # Do not use make's built-in rules and variables
 # (this increases performance and avoids hard-to-debug behaviour)
@@ -176,17 +176,18 @@ MAKEFLAGS += --no-print-directory
 
 endif # ifneq ($(KBUILD_OUTPUT),)
 
+export sub_make_done := 1
 PHONY += $(MAKECMDGOALS) sub-make
 
 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
 	@:
 
 sub-make: FORCE
-	$(Q)$(MAKE) sub-make-done=1 \
+	$(Q)$(MAKE) \
 	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
 
-else # sub-make-done
+else # sub_make_done
 # We process the rest of the Makefile if this is the final invocation of make
 
 # Do not print "Entering directory ...",
@@ -2549,7 +2550,7 @@ $(cmd_files): ;        # Do not try to update included dependency files
 
 endif    #ifeq ($(config-targets),1)
 endif    #ifeq ($(mixed-targets),1)
-endif	 # sub-make-done
+endif	 # sub_make_done
 
 PHONY += FORCE
 FORCE:
-- 
2.49.0

