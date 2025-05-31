Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA26C5AE59
	for <u-boot@archiver.kernel.org>; Sat, 31 May 2025 08:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B2D82B37;
	Sat, 31 May 2025 10:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HxPXJljc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B7482AB9; Sat, 31 May 2025 10:44:56 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F83082B5B
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 10:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a4f78ebec8so896628f8f.0
 for <u-boot@lists.denx.de>; Sat, 31 May 2025 01:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748681093; x=1749285893; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DarqbFbBD3bowKp4SFPjJEsXffZywZSf2BuekqLKxls=;
 b=HxPXJljcNy1gr+lha2fmMwA1FzjRiFtNE/4EMdIlL4zhZqj+GRLyA3i791iE/QpVsg
 Spnjoy+pqwu6z8p1bJ7ChTeuiY1ZaTISZmYxUl1PyNQNPPHh72m0/vBIV/1RUT09OEnT
 anQ0diQYhRSwrZtYKRV9paDPYabQy5IKbWcJPr7hCq7oRDDW7MFriwyB+CThGuMK90ZK
 rPfZ9Ep9eB6CLlVaq26UMdU0LKsWnbC08cFa+VQyEu3DHpGWC2e8vRhQaRnXsGOvHs9B
 H+97L5e5ad3BOiLLUlN37tcE1OnW6rbazRoACXerB0O3vV2GsVPMUwo0CPiAXLZKycYC
 oWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748681093; x=1749285893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DarqbFbBD3bowKp4SFPjJEsXffZywZSf2BuekqLKxls=;
 b=Sn+RvZMFNj0rO8WLC1EeM2hIJrVlihWnQGyfEjSGarAWDbJWaYqu9A3I/fMys++rqo
 DJSlpIElC0mrm6F0RUNVD7/9Pn3Zranx+ZKMZnRIvpWdFUCewDo7u72rA/5HX9lJOT0k
 Wq59HQDL/pO7S9M31gvi40OJV8NyXD0rdPJsFJwZN2se8MmbwU5vimYkFLeTDpShbbP+
 mGDHYg8TwoG4vfMSKLw3dY322BvKnzDxIGsnVAkYDG9nRl8lh90ljoimN6pz6Id9yfk8
 j1Gwl1a1JoV2jVWNXZTf7kywX93IwonwSNOH5P9yThCTZM+WmOswwZs7BskWup1vl2aO
 uzjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbAnZxwOwGB9QIjHgNT9V1+i//79yv1A7IM79Ggth1lrPOVBuZi3gyd/zigpKGTWz/3JgeDrs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2Bye42x6BSbVP58C0QQODsj/2SYIJSqqNL4POg2TNKfj7SUsX
 WqBLAo+xjeCVDnzfrsqENkHeC7MuTBVWN8fCuvGWVeNE8O2zeN3Ii/0Ik2kIOg1JtrM=
X-Gm-Gg: ASbGnctMIxp6eI+5Knw/0HmucG6nENo5Ou6HFyLI9nD7+6Tr9KfK/ti2+S+IekIOY+k
 NHHUlqUaZcOz2YcKAZv+HlCYiiIhHdPZwGBxeNFn3xDiUI77kMk8Mc4ZD4zRNVQHUSaOopMm3WZ
 60jhEWs9fTgtxDTA3xsAQnel3SugQxia7xwAiLVFTO8YC40Re1ay5Y512c4Xj1eipMKT/GdF2p1
 m8tMMiYL3wLO/C2JZW6IHWbUROMVDFTsz1SYWsO05bdS4dbXLVuT5QwN/0F7VrNMFZymcBINL2L
 1FaT1ihfhzauLZt1+J5u1RF2jPLY4xL0w7DA8mLt1czfn79ZRjpt6Fk3tc82pugSk++l0ouURoh
 jTgkbJ9Gb2ImJC98PccIHjAQXzIgtuTVeWFUWQdpk
X-Google-Smtp-Source: AGHT+IGlc3DrTaHz6PMDM9UjsDGPcnLXYgc3n8j1sWwPY2wcxIf1a2ZZTFZga4qDF1DyUNgcob90Eg==
X-Received: by 2002:a05:6000:2207:b0:3a4:f6e0:c1b5 with SMTP id
 ffacd0b85a97d-3a4f89d2b1dmr4630430f8f.27.1748681093515; 
 Sat, 31 May 2025 01:44:53 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73f3csm7153986f8f.42.2025.05.31.01.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 May 2025 01:44:52 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH 01/13] kbuild: add -fno-PIE flag unconditionally
Date: Sat, 31 May 2025 11:44:29 +0300
Message-ID: <20250531084449.4125187-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
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

Backport from kernel
commit 42a92bccd213 ("kbuild: add -fno-PIE flag unconditionally")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index c7b82299c198..6a1eb26c6e41 100644
--- a/Makefile
+++ b/Makefile
@@ -435,9 +435,10 @@ KBUILD_CPPFLAGS := -D__KERNEL__ -D__UBOOT__
 
 KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -Wno-format-security \
-		   -fno-builtin -ffreestanding $(CSTD_FLAG)
+		   -fno-builtin -ffreestanding $(CSTD_FLAG) \
+		   -fno-PIE
 KBUILD_CFLAGS	+= -fshort-wchar -fno-strict-aliasing
-KBUILD_AFLAGS   := -D__ASSEMBLY__
+KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
 KBUILD_LDFLAGS  :=
 
 ifeq ($(cc-name),clang)
@@ -457,10 +458,6 @@ KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
 KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
 endif
 
-# Don't generate position independent code
-KBUILD_CFLAGS	+= $(call cc-option,-fno-PIE)
-KBUILD_AFLAGS	+= $(call cc-option,-fno-PIE)
-
 # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
 UBOOTRELEASE = $(shell cat include/config/uboot.release 2> /dev/null)
 UBOOTVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
-- 
2.49.0

