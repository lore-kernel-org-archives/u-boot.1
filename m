Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437CDC83F2F
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 17:21:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F11286553;
	Thu, 31 Aug 2023 19:21:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RjTIvrXl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091E2865A2; Thu, 31 Aug 2023 19:21:10 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 243FE86205
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 19:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-792979d4cb5so40081939f.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693502465; x=1694107265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nLPDbmdtXfw67vRmbp4ZUtpxNocfBG3T1SFa3d72hHA=;
 b=RjTIvrXlyohFwvDiyk57qjsvSa0DWRR4QJ1aB07U9YJXHmk6W65HQN9Deb5CirMIk6
 0fgW3YMIri58sOD7M18ZdnAefTPsvvXkYtK4rqNrwFqtDuahNQKyaFKJEbW0hYIfBkcA
 nFUPRdjIO/WthIDKjdNYYVa0rOaorsNGcg7tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693502465; x=1694107265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nLPDbmdtXfw67vRmbp4ZUtpxNocfBG3T1SFa3d72hHA=;
 b=XmrS6xzWFflvBF9+Zj0yK38X/imm+E3dJHw6ywPBoyKK/T+V5Y0DmRFoKLVlEFUwMc
 ecv7tCR3b9J/il7w78Cu/iOUm2GfRIB1RwrLGOxwZz/e9a5kz99YlAhzM++Ez1Z3CkrM
 LbPfWLrc/W9R4eIcGtjFcf0HvTnJzxWRMJ79SMKfKNAz//EWlqzj3qok0fVw098yGJkB
 448vGoqB9asG8hLre8ZpQq4d205ICX0d5h8x4mR7dpL196IJYchDnF3s2diCyRxDc9ei
 PfIjUEGBjZrBLViUVB+XF6DTfMhQglV4mlMN8ckfQ2mA2/H/iR5onSurhSU10RVEVq6e
 S/UQ==
X-Gm-Message-State: AOJu0YxtM8H7GDxNTO9BhTuEBczkqB1HwfTaHZ8ZLt3f4GbTeiHo7rC5
 RpJkfniDSItWSFpgy34WNJ7vLDcqq6AHleSbE+o=
X-Google-Smtp-Source: AGHT+IF7MbwEF6ZmiIMoRhNlH/KBI8zXhiXV01P8cC2DOBrSqdwLeAunP8fC4zqfaAl+scsWKlrJRQ==
X-Received: by 2002:a6b:6e09:0:b0:783:56f2:e733 with SMTP id
 d9-20020a6b6e09000000b0078356f2e733mr6741050ioh.4.1693502465713; 
 Thu, 31 Aug 2023 10:21:05 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:24b3:5dcf:cfe6:7f23])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a056638190500b00430bd8692absm503732jal.159.2023.08.31.10.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 10:21:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Mike Frysinger <vapier@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 1/2] Allow Python packages to be dropped
Date: Thu, 31 Aug 2023 11:20:52 -0600
Message-ID: <20230831112051.1.I3fe7ac62de70902fd1be093bcda7c53acd43daf8@changeid>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
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

When building in a portage chroot, we do not have the environment needed
to build pylibfdt. It is instead build as a separate package.

Provide a build option to tell U-Boot to skip this part of the build. We
still need it to use binman, etc. but don't need it to build its
dependencies.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mike Frysinger <vapier@chromium.org>
---

 Makefile             | 8 ++++++++
 doc/build/tools.rst  | 9 +++++++++
 scripts/dtc/Makefile | 2 ++
 3 files changed, 19 insertions(+)

diff --git a/Makefile b/Makefile
index 9b90204bfe6..25be94ef20f 100644
--- a/Makefile
+++ b/Makefile
@@ -646,12 +646,20 @@ export CFLAGS_NON_EFI	# Compiler flags to remove when building EFI app
 export EFI_TARGET	# binutils target if EFI is natively supported
 
 export LTO_ENABLE
+export PYTHON_ENABLE
 
 # This is y if LTO is enabled for this build. See NO_LTO=1 to disable LTO
 ifeq ($(NO_LTO),)
 LTO_ENABLE=$(if $(CONFIG_LTO),y)
 endif
 
+# This is y if U-Boot should not build any Python tools or libraries. Typically
+# you would need to set this if those tools/libraries (typically binman and
+# pylibfdt) cannot be built by your environment and are provided separately.
+ifeq ($(NO_PYTHON),)
+PYTHON_ENABLE=y
+endif
+
 # If board code explicitly specified LDSCRIPT or CONFIG_SYS_LDSCRIPT, use
 # that (or fail if absent).  Otherwise, search for a linker script in a
 # standard location.
diff --git a/doc/build/tools.rst b/doc/build/tools.rst
index ec017229258..418f0abb236 100644
--- a/doc/build/tools.rst
+++ b/doc/build/tools.rst
@@ -45,3 +45,12 @@ Launch the MSYS2 shell of the MSYS2 environment, and do the following::
 
    $ make tools-only_defconfig
    $ make tools-only
+
+
+Building without Python
+-----------------------
+
+The tools-only build bytes pylibfdt by default. To disable this, use the
+NO_PYTHON variable::
+
+   NO_PYTHON=1 make tools-only_defconfig tools-only
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 58d879dd11f..faa72d95e28 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -19,4 +19,6 @@ HOSTCFLAGS_dtc-parser.tab.o := -I$(src)
 $(obj)/dtc-lexer.lex.o: $(obj)/dtc-parser.tab.h
 
 # Added for U-Boot
+ifeq ($(PYTHON_ENABLE),y)
 subdir-$(CONFIG_PYLIBFDT) += pylibfdt
+endif
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

