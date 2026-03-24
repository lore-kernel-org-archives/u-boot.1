Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD37FEC0FC
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 19:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B20B383A1B;
	Tue, 24 Mar 2026 20:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QhJ9iFS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A7083A91; Tue, 24 Mar 2026 20:45:47 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A634A83981
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 20:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d75ed779bfso1305563a34.2
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774381544; x=1774986344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r9+HDK5733+jjeoxynKyW3vVuU3i5ZQsZ4OKGA2zjUE=;
 b=QhJ9iFS0cKp54HOeBHtkbEhrsAMjDW2gmxmMTbUjw8f4xpxstJnFENpb9L4CcrsDKk
 9iU8ECeJuAfRJnWYv6d/0nYJCk2ceBej2ij6eSpdvi1MYf09unh/FrdDRahS/e7BkyTf
 /sbKScJKqUaClhBFhwOjShn2oBBYEiNkXOYD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774381544; x=1774986344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9+HDK5733+jjeoxynKyW3vVuU3i5ZQsZ4OKGA2zjUE=;
 b=aCXyMG8mS/yh1nxRoxAoV6RTIM8jm6g+32mkabC0YBJdj05p+75+bKAwl6RtR3Qw+I
 npBbuqNb+oIV6ANbVHSWFvutf2UuBSho8yHJVGzUw9an04IhvpJEhpqyTYJ6NZYQ7DyF
 5iRHHkY0rim0spK+/AhBNnvjCVpeT+/vvEGAG20bxy73TJi2Nfvn7KSShZrkc9andt1q
 7fj0Se6iCLolnvgaUCGUofAX6Zksztn7owlq9jKQ7RV3D7pKKhzE2QPaHqys581GYvNu
 6S21bsdEp19pP87GVR68AjvCEgljrCfWBUZHG88wUP4p55ll/34xNAwbmQj0NagqtylC
 Z+xw==
X-Gm-Message-State: AOJu0YxMe8pszRHvAFTsQJtoMmcNwcHawoeYWqiNgyPQiPNyToKicBTA
 dXeVafZNfHM8IoIuhXrqgPKiWe+O6FmTKr0Y3cnTOiE/iCtUqWOymMMkAr0+cUdANFjGpSUBDep
 8lFiTJA==
X-Gm-Gg: ATEYQzxszkXqa/Fc9SD5jy120kFMk1sesztdpQRslIQEQQp5QcA/UYTUbdESK2p0Jh5
 g3YQ2pBUAA0+fBB4HSgD7owUXTD9frG+JFlaE6epy7HSDJ4x5xtL7rE/3tCQtfjS3MHDsWr4jo4
 JOQwskjpd9VABQ+doH14OVSK7rB4lEUoYpb5OYUmCIH49PF4rYW8acHddms3jcQzugZ4ETYSIDX
 EoCIXjyRarerFWZ7XjGI92kUxhDZzAdVUoN1h803AiDJE/cMHuDmbkwC+LMMsdkCkWx+G7Hf7Bi
 KqeaYcOgY11zf4oZVBWbBu/Vi/U0YI/JUOLgp40hATo/QuoxNdHHvO5dWRdC/b1+rJEgq7hk4XN
 9cDnDCyxtxXuyVMdcFnVAUmNB6Mi3VO2cNH4tx01xZfmyTaVivOT76SXZDvRxB9ihzTJN8kXZXm
 I+vmu9G7TcBDmoXWFp1g==
X-Received: by 2002:a05:6830:2403:b0:7d7:fbe5:e9be with SMTP id
 46e09a7af769-7d9d695c0f4mr378160a34.20.1774381543771; 
 Tue, 24 Mar 2026 12:45:43 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadc8a12sm12783012a34.16.2026.03.24.12.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:45:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH] sandbox: Adjust how OS-interface files are built
Date: Tue, 24 Mar 2026 13:45:20 -0600
Message-ID: <20260324194535.2338985-1-sjg@chromium.org>
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

The current mechanism uses a completely separate build rule for each
file which must be built with system headers. This is tricky to
maintain.

Add a foreach template in the sandbox cpu Makefile which generates the
custom compile rules from a CFLAGS_USE_SYSHDRS list. This keeps the
rules data-driven without needing changes to the common
scripts/Makefile.lib, which could affect other architectures.

Move initjmp.o into the template since it uses the same pattern. Add
sdl.o to the list too, with an override for its command since it also
needs -fshort-wchar removed and -fno-lto added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/Makefile     |  2 +-
 arch/sandbox/cpu/Makefile | 45 ++++++++++++++-------------------------
 2 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/arch/sandbox/Makefile b/arch/sandbox/Makefile
index a335f8acfde..5bbf9f1f96b 100644
--- a/arch/sandbox/Makefile
+++ b/arch/sandbox/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
-head-y := arch/sandbox/cpu/start.o arch/sandbox/cpu/os.o
+head-y := arch/sandbox/cpu/start.o
 head-$(CONFIG_SANDBOX_SDL) += arch/sandbox/cpu/sdl.o
 libs-y += arch/sandbox/cpu/
 libs-y += arch/sandbox/lib/
diff --git a/arch/sandbox/cpu/Makefile b/arch/sandbox/cpu/Makefile
index 038ad78accc..ee3c04c49e1 100644
--- a/arch/sandbox/cpu/Makefile
+++ b/arch/sandbox/cpu/Makefile
@@ -5,42 +5,29 @@
 # (C) Copyright 2000-2003
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-obj-y	:= cache.o cpu.o state.o initjmp.o
-extra-y	:= start.o os.o
+obj-y	:= cache.o cpu.o state.o initjmp.o os.o
+extra-y	:= start.o
 extra-$(CONFIG_SANDBOX_SDL)    += sdl.o
 obj-$(CONFIG_XPL_BUILD)	+= spl.o
 obj-$(CONFIG_ETH_SANDBOX_RAW)	+= eth-raw-os.o
 
-# os.c is build in the system environment, so needs standard includes
-# CFLAGS_REMOVE_os.o cannot be used to drop header include path
-quiet_cmd_cc_os.o = CC $(quiet_modtag)  $@
-cmd_cc_os.o = $(CC) $(filter-out -nostdinc, \
-	$(patsubst -I%,-idirafter%,$(c_flags))) -c -o $@ $<
+# These files need to be built with system headers, since they use system
+# calls or system-level interfaces. Generate a custom compile rule for each
+# one that drops -nostdinc and converts -I to -idirafter.
+CFLAGS_USE_SYSHDRS := eth-raw-os.o initjmp.o os.o sdl.o
 
-$(obj)/os.o: $(src)/os.c FORCE
-	$(call if_changed_dep,cc_os.o)
+define syshdrs_rule
+quiet_cmd_cc_$(1) = CC $$(quiet_modtag)  $$@
+cmd_cc_$(1) = $$(CC) $$(filter-out -nostdinc, \
+	$$(patsubst -I%,-idirafter%,$$(c_flags))) -c -o $$@ $$<
 
-# eth-raw-os.c is built in the system env, so needs standard includes
-# CFLAGS_REMOVE_eth-raw-os.o cannot be used to drop header include path
-quiet_cmd_cc_eth-raw-os.o = CC $(quiet_modtag)  $@
-cmd_cc_eth-raw-os.o = $(CC) $(filter-out -nostdinc, \
-	$(patsubst -I%,-idirafter%,$(c_flags))) -c -o $@ $<
+$$(obj)/$(1): $$(src)/$(1:.o=.c) FORCE
+	$$(call if_changed_dep,cc_$(1))
+endef
 
-$(obj)/eth-raw-os.o: $(src)/eth-raw-os.c FORCE
-	$(call if_changed_dep,cc_eth-raw-os.o)
+$(foreach f,$(CFLAGS_USE_SYSHDRS),$(eval $(call syshdrs_rule,$(f))))
 
-# initjmp.c is build in the system environment, so needs standard includes
-# CFLAGS_REMOVE_initjmp.o cannot be used to drop header include path
-quiet_cmd_cc_initjmp.o = CC $(quiet_modtag)  $@
-cmd_cc_initjmp.o = $(CC) $(filter-out -nostdinc, \
-	$(patsubst -I%,-idirafter%,$(c_flags))) -c -o $@ $<
-
-$(obj)/initjmp.o: $(src)/initjmp.c FORCE
-	$(call if_changed_dep,cc_initjmp.o)
-
-# sdl.c fails to build with -fshort-wchar using musl
+# sdl.c also needs -fshort-wchar removed (musl) and -fno-lto, so override
+# the generated rule
 cmd_cc_sdl.o = $(CC) $(filter-out -nostdinc -fshort-wchar, \
 	$(patsubst -I%,-idirafter%,$(c_flags))) -fno-lto -c -o $@ $<
-
-$(obj)/sdl.o: $(src)/sdl.c FORCE
-	$(call if_changed_dep,cc_sdl.o)
-- 
2.43.0

base-commit: 1ffc541eafc96d5eebcf837ab892dccec3b93568
branch: sb-os-us
