Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F4A106B530
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 13:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E7B583AAB;
	Wed, 25 Mar 2026 14:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZNhgcu+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6F883CD3; Wed, 25 Mar 2026 14:08:27 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 051FA81E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 14:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d7ebe11bffso4508652a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774444103; x=1775048903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pbOrn84Xkzv5lhQUHdQURoeaywa+UgT6vYgTS83rhUo=;
 b=ZNhgcu+mw7m7y+TGb9aMkx/cF84yr7LlycK+57zrz2In+SYBOf7I4rQtmCbG+oJi9x
 T62unZFaPEhXsp7eGxP00I5V1Bybw5yNfGKes7ivjS/yT8V2rAQBFU/94tr5kGt/9wyh
 uHHamrYqt1Uxd3Kq1LogmPu1ohVmESbfSeuT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774444103; x=1775048903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbOrn84Xkzv5lhQUHdQURoeaywa+UgT6vYgTS83rhUo=;
 b=piaZVmyhZeMrVgYbr+xnk04oXdSbIPTxqyUqbetpUZjGHaq1VW8gTvSYkASrPRw1cA
 KHqnsB9Rz39vP6JD6+lGBz9OFBqR2zh3RaTWZ39mqzK2lWvk8OmeLkAGbEN+P0fABPyF
 wIC77ca8HxkGo4VQ5z6aS2Mjq11ZC/ENhUmwvDazbCaz0vJFBJuMJAOulLVzVWqemSt3
 +KyhqWerjq217gBTMk3trkkDSWmfTafeR4m7GoYpqsJDPwYSImyetZh6esQuO1RcA7s7
 w3cTe3VNuG8aDYvsFeOgW52ZC4xirxioqp9OhA3aM4Ozyfht7WCM2SiZBnzDLGlTjSfr
 TgLQ==
X-Gm-Message-State: AOJu0YwIgH30hgLI1XcHyIvvFRg+Nc+igp2DPluSnNFbKRlX6bbghlMk
 QCh2LeYRiEyotmuv2Kqaq42VHk/d7jrxavDd3t0lR9FSHk7pW3uoJ3UQ9LolyTfkVh2iDWMKIKm
 FJ4IBWA==
X-Gm-Gg: ATEYQzyBSea5XhAmq5cXik6DQ5YsykV/jQnie7mVIBWp9+Evwwuu5RzBqMr4roelSby
 /QM2Dmk2ibsT5FZdhgRYDOxwNqmIUFhme2ODpk+WUL7HvHll9+eGDm56pIGH6wZ+sbJAx7mKT6f
 1MCgu2Up1QN5vjq9DQfQ9451OSXS5OYZINOZYAIXYcr02xKbCQAy9FQGgsaRVRvcU4iuAqC+h0q
 1WLXVfT27eUInjEm/iVzbC3lGJAZAirLO0Ityaka3fDtUXrw7Ds78AYQqql8GBrph4maA7+Ntyg
 ym5r23eVsa6X7XEL36cbzkeSumWD9qN0LO2K0X0tDV2ifTsoL2ftDr9sRkNYiusLKl77oXig+Hi
 +0nMYfn1DWO7JJMHRPSqphRcxtq2EAAARDjqWk2pJ0llbVrZy1305IBMIxlfBtGB2RmlRGqa025
 dcT8A5S+850LzY5f/dGQ==
X-Received: by 2002:a05:6830:6ae5:b0:7d9:b58e:55f2 with SMTP id
 46e09a7af769-7d9d6966d65mr1929451a34.24.1774444103040; 
 Wed, 25 Mar 2026 06:08:23 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadc8a12sm14466116a34.16.2026.03.25.06.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 06:08:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] kbuild: Use relative paths in generated .incbin directives
Date: Wed, 25 Mar 2026 07:08:09 -0600
Message-ID: <20260325130811.447377-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

The generated .S files for fonts, splash screens and EFI apps use
.incbin with the full prerequisite path. When building with O= this
bakes an absolute path into the .S file. If the build directory is
later used on a different machine (e.g. in a container), the assembler
cannot find the source file.

Use $(src)/$(notdir $<) instead of $< so the .incbin directive contains
a source-relative path like drivers/video/fonts/nimbus_sans_l_regular.ttf
rather than an absolute one. Add -Wa,-I$(srctree) to the assembler
flags so the assembler can resolve these paths.

The DTB and DTBO rules are left unchanged since their prerequisites are
generated files in the build directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/Makefile.lib | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 7386353e0cc..e44120ea0c0 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -219,6 +219,7 @@ c_flags        = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)    \
 		 $(basename_flags) $(modname_flags)
 
 a_flags        = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
+		 -Wa,-I$(srctree)                                   \
 		 $(_a_flags) $(modkern_aflags)
 
 cpp_flags      = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
@@ -520,7 +521,7 @@ cmd_S_ttf=						\
 	echo '.balign 16';				\
 	echo '.global __ttf_$(*F)_begin';		\
 	echo '__ttf_$(*F)_begin:';			\
-	echo '.incbin "$<" ';				\
+	echo '.incbin "$(src)/$(notdir $<)" ';				\
 	echo '__ttf_$(*F)_end:';			\
 	echo '.global __ttf_$(*F)_end';			\
 	echo '.balign 16';				\
@@ -541,7 +542,7 @@ cmd_S_splash=						\
 	echo '.balign 16';				\
 	echo '.global __splash_$(*F)_begin';		\
 	echo '__splash_$(*F)_begin:';			\
-	echo '.incbin "$<" ';				\
+	echo '.incbin "$(src)/$(notdir $<)" ';				\
 	echo '__splash_$(*F)_end:';			\
 	echo '.global __splash_$(*F)_end';			\
 	echo '.balign 16';				\
@@ -562,7 +563,7 @@ cmd_S_efi=					\
 	echo '.balign 16';			\
 	echo '.global __efi_$*_begin';		\
 	echo '__efi_$*_begin:';			\
-	echo '.incbin "$<" ';			\
+	echo '.incbin "$(src)/$(notdir $<)" ';			\
 	echo '__efi_$*_end:';			\
 	echo '.global __efi_$*_end';		\
 	echo '.balign 16';			\
-- 
2.43.0

base-commit: 1ffc541eafc96d5eebcf837ab892dccec3b93568
branch: font-us
