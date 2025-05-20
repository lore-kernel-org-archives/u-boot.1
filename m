Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122AFC3ABDA
	for <u-boot@archiver.kernel.org>; Tue, 20 May 2025 05:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5EA82D21;
	Tue, 20 May 2025 07:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bqQcpgcp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EF8682D21; Tue, 20 May 2025 07:22:57 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DFA82BD9
 for <u-boot@lists.denx.de>; Tue, 20 May 2025 07:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so772416f8f.0
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 22:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747718575; x=1748323375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WSiWiGjJWO0FvvH5WdzqbgmVIbWrLeQ02QMM2g6qh5Q=;
 b=bqQcpgcppm8o7BwLmo3+Y9tJ99DUOba7ynOGqDfDuo/GqOFRo4nRz6B5eJJRq4UWF6
 HtvX2ZyoFZ1sDlhQWfAaFjORm7Ts7q78xP+es9ZHjkzTXJPwvY51c2+0oQF6viwBt1bu
 Qu30+fQ+BON9193TPOjBzDFQeCCi6tCkEe4LE0CMUMr/GlmSDbrFVEB7YbXeuNNSB3py
 Q9E54e4oZ9ilF1KY8OC8krgiCxkuJCA2DVUHVSs0w7lTaC8+fr2J4jlVsd9fQ7uqKBrX
 rl/wNhimnhXYcpxj8wx2PB846f2IP/n+S7ojk2R+lnqZlTFshcs1IETPr9b1itsqv+LH
 n8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747718575; x=1748323375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WSiWiGjJWO0FvvH5WdzqbgmVIbWrLeQ02QMM2g6qh5Q=;
 b=q5TdEPD2X5c1kI8xJ+HSzTrPAjMS13nEH2k3KTmc25NuTNdDMU4YFCtHmuXgloDfkn
 YMm/Pdh6IC1u/f3nIwZCklvIH2GlAMt9gFBhb3PgDu4nNhh1U5dloz0xKWFOp+foR6pB
 /bG1+ROyJaMnumLa/1qihdEZZd6oNUAohaF2/7Bh9hBhIigv7UAiO7Hs28oaxa0zJcwy
 r20+f/8l7ifgkLDfoJRF1lilmNqwaiG2Zn987psQPzp/rbY+itzcQyGqGpwiR+lprW+C
 KHC7FFMNuBlAJZLGYavvVkR6qBaGhnMFOpGrLiN878XrFCdS6NRZlNU2whaDOJqXLqo/
 bqgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUts6llHbt97wf5GIeh3P0Fk8MKVIKxGfFOZi8RyZPx2eevTRm7C7eeSgN9S1gGPzzZ75vdKMU=@lists.denx.de
X-Gm-Message-State: AOJu0YxLWmt9lCdBdLdITJjCVuTaPRlBeR5jl+22w4B0lmsJEmDP1KLg
 2WcolvnLvDRQCp/9g8hJ5ALI4+at9hjNNfDjAcpHWpV8bLzzLWfSaeIUhWKVqTveZ1Y=
X-Gm-Gg: ASbGnct1zOUMRmnMWAeWDFDnz3JqqMfeUq0VlW2V4LMLY2ObniT0LFEhKXZbAkz7Q+N
 2DSrpygexgb459cy9+YZ42kTt+t4Ou5rcEVkJqisi87SPavoDqANxPWtKMvhyBe09RdD90AaLdT
 wFMz8xi62YCAhczz6gXDB95xzR7HmDK4wn62+98lj8nfpZyoBIwyvZe2xsE23TiTGwrc4OsYnLS
 2Q5HShA72aWm+X1YMo2HXmjIKA2MVeTyJYZIgysMkGiIHgA4R/h7j7g3yEaS0qwc8zFBOx5/pa1
 uI4pTcZZAlssPSx5W5Uk/KmffMg/Pgwn2K97aOSWkjp1o/qrdwqUNSzfEtELLPgMDXlzMMDiYOs
 =
X-Google-Smtp-Source: AGHT+IHrsazfHQ3AEoz0pSgFNQ8mVGecAd6NajQk4xUZrC0FpMdvtyuvMBYbAuraio1qfEaVylzmUA==
X-Received: by 2002:a05:6000:2012:b0:3a3:5a99:7e07 with SMTP id
 ffacd0b85a97d-3a35c8258fdmr13630501f8f.25.1747718575132; 
 Mon, 19 May 2025 22:22:55 -0700 (PDT)
Received: from localhost.localdomain ([46.198.180.244])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca889e6sm15100762f8f.71.2025.05.19.22.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 22:22:54 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 23/24] kbuild: make -r/-R effective in top Makefile for old
 Make versions
Date: Tue, 20 May 2025 08:21:34 +0300
Message-ID: <20250520052153.307194-24-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
References: <20250520052153.307194-1-ilias.apalodimas@linaro.org>
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
commit 3812b8c5c5d5 ("kbuild: make -r/-R effective in top Makefile for old Make versions")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 48 ++++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/Makefile b/Makefile
index 00876ef54a2a..66803f089d48 100644
--- a/Makefile
+++ b/Makefile
@@ -12,10 +12,6 @@ NAME =
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
-# Do not use make's built-in rules and variables
-# (this increases performance and avoids hard-to-debug behaviour)
-MAKEFLAGS += -rR
-
 # Determine target architecture for the sandbox
 include include/host_arch.h
 ifeq ("", "$(CROSS_COMPILE)")
@@ -39,15 +35,6 @@ else ifeq ("riscv64", $(MK_ARCH))
 endif
 undefine MK_ARCH
 
-# Avoid funny character set dependencies
-unexport LC_ALL
-LC_COLLATE=C
-LC_NUMERIC=C
-export LC_COLLATE LC_NUMERIC
-
-# Avoid interference with shell env settings
-unexport GREP_OPTIONS
-
 # We are using a recursive build, so we need to do a little thinking
 # to get the ordering right.
 #
@@ -64,6 +51,21 @@ unexport GREP_OPTIONS
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
+ifneq ($(sub-make-done),1)
+
+# Do not use make's built-in rules and variables
+# (this increases performance and avoids hard-to-debug behaviour)
+MAKEFLAGS += -rR
+
+# Avoid funny character set dependencies
+unexport LC_ALL
+LC_COLLATE=C
+LC_NUMERIC=C
+export LC_COLLATE LC_NUMERIC
+
+# Avoid interference with shell env settings
+unexport GREP_OPTIONS
+
 # Beautify output
 # ---------------------------------------------------------------------------
 #
@@ -137,7 +139,6 @@ export quiet Q KBUILD_VERBOSE
 
 # KBUILD_SRC is set on invocation of make in OBJ directory
 # KBUILD_SRC is not intended to be used by the regular user (for now)
-ifeq ($(KBUILD_SRC),)
 
 # OK, Make called in directory where kernel src resides
 # Do we want to locate output files in a separate directory?
@@ -168,22 +169,25 @@ $(if $(KBUILD_OUTPUT),, \
 # 'sub-make' below.
 MAKEFLAGS += --include-dir=$(CURDIR)
 
+else
+
+# Do not print "Entering directory ..." at all for in-tree build.
+MAKEFLAGS += --no-print-directory
+
+endif # ifneq ($(KBUILD_OUTPUT),)
+
 PHONY += $(MAKECMDGOALS) sub-make
 
 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
 	@:
 
 sub-make: FORCE
-	$(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR) \
+	$(Q)$(MAKE) sub-make-done=1 \
+	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
 
-# Leave processing to above invocation of make
-skip-makefile := 1
-endif # ifneq ($(KBUILD_OUTPUT),)
-endif # ifeq ($(KBUILD_SRC),)
-
+else # sub-make-done
 # We process the rest of the Makefile if this is the final invocation of make
-ifeq ($(skip-makefile),)
 
 # Do not print "Entering directory ...",
 # but we want to display it when entering to the output directory
@@ -2546,7 +2550,7 @@ $(cmd_files): ;        # Do not try to update included dependency files
 
 endif    #ifeq ($(config-targets),1)
 endif    #ifeq ($(mixed-targets),1)
-endif	# skip-makefile
+endif	 # sub-make-done
 
 PHONY += FORCE
 FORCE:
-- 
2.49.0

