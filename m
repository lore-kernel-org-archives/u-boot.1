Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5C4C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2567D838EF;
	Wed, 28 May 2025 18:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DRqhjRbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 779668394E; Wed, 28 May 2025 18:08:31 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D187C833F6
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:08:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so3076626b3a.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748448507; x=1749053307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1VYX8d7cChvAvWxHuiBQzZASbedEZSwD+wRhAOVBAlg=;
 b=DRqhjRbdhsTlVPses2rQ3/gAHpnsdV/mPYpRTuC3kUf1Md87lkVUIVP05EKthgTiti
 vOFjVPGR7sIGk17lIavxXtmIas0vU4t8SwvZE//0VimMd32/Hf+OrAWcCbb9D90v1dYt
 MtzBNRIo1HQJa3czE7ANwMaMgy6b1B4rDOKP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748448507; x=1749053307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1VYX8d7cChvAvWxHuiBQzZASbedEZSwD+wRhAOVBAlg=;
 b=sgGWErLH54IHzgGHlOhOmXB34jDRL8JXZ1ykSY+llt3UrRM64Zwr9dng8SztsqrZ/w
 SgAMey0+eBEBIUdOH/wabxgs8GqJ4iWDbO7ga5f0Qxim/sJQh0oxqbqWRTCd9p/cYOCo
 t9puHxd8sw2+1hac7lgYweQ1Z+lUcc5kUgYg8OlX8Kp/Uq8z17uWQunN1O+qhW2hHgVQ
 scLGS+n/SGtvaQY6D8fnKxLm1oY91vM5pxqwH2qzZ5j9sZrjr6Q/sRVKaiXhnrEl1f/c
 nOyzJwAo4vya/U7J7j72mKGzdfBZSYMSI3FoR3FWvT9KDHj15AhchxhkYFIfk7wOpaYu
 4Rpg==
X-Gm-Message-State: AOJu0YyRj/1qkjPmod92mESdSDOzu6zyPmBjFyOb6LOnq7Eq4dU6oXL/
 YxzSGsBsk2LodeUdP0MCj8p+pRAuu6W7/+HwC6NjolQtKDDBOzDyasgOu3TREwggEa7Ke8x07tR
 zjJLTCPy3
X-Gm-Gg: ASbGncv5aPM0Qja+Xroi67DnJVFH6/1h/HZlEwVsE5Gis9eTjRfy4BVguZsTaQoJ8Yo
 2foaGwsGw2Lger0EJluF+TgGBbE41arhU0yBa68ptCsgBRlMy69HhjqCiRyEvFDaneCcHrLDOdE
 yuncCCXGj5V9NixPqDGaHsJq+czkUlSEtxUEeNTOIdS9k/45dnlmbGXv+lI+gyG/+2AebC06dPc
 W7Skiqiohe6I5ijnI/PRvooAhrP4BDcrG35Hm2XTy+WfmloualYwJkmOtFihky4CnICpdeiGErZ
 deNGbu/pffEcr4ufss5qpGJJF4DRzv+BhBDGOsCs3mpsBdJ5FjP+DX6GIw8aSV/QSVdvmczkXAR
 RR2WRny03AwFe
X-Google-Smtp-Source: AGHT+IGC1TtwyMviMGdj0CjHdpyxxAk+fK4sJUWL+bXksVZNGkAmVII5lEpZyuT7jwi0FLxLxwrYyw==
X-Received: by 2002:a05:6a20:9f4f:b0:218:6697:1b67 with SMTP id
 adf61e73a8af0-2188c1e8d6bmr25427269637.8.1748448506521; 
 Wed, 28 May 2025 09:08:26 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd586873sm276277173.90.2025.05.28.09.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 09:08:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Adriano Cordova <adrianox@gmail.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] efi: Rename the lib/efi directory
Date: Wed, 28 May 2025 10:03:14 -0600
Message-ID: <20250528160323.1184731-1-sjg@chromium.org>
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

This directory was created when U-Boot gained the ability to run as an
EFI app in 2015. Since then the EFI-loader feature has been added.

The code in lib/efi is not actually used by the loader, so the name is
confusing.

Rename the directory to efi_client to indicate that it includes files
just for U-Boot being a client of EFI, i.e. the EFI app and stub.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS                            | 2 +-
 Makefile                               | 2 +-
 doc/develop/uefi/u-boot_on_efi.rst     | 8 ++++----
 lib/Makefile                           | 2 +-
 lib/{efi => efi_client}/Kconfig        | 0
 lib/{efi => efi_client}/Makefile       | 0
 lib/{efi => efi_client}/efi.c          | 0
 lib/{efi => efi_client}/efi_app.c      | 0
 lib/{efi => efi_client}/efi_app_init.c | 0
 lib/{efi => efi_client}/efi_info.c     | 0
 lib/{efi => efi_client}/efi_stub.c     | 0
 lib/efi_loader/Kconfig                 | 2 +-
 12 files changed, 8 insertions(+), 8 deletions(-)
 rename lib/{efi => efi_client}/Kconfig (100%)
 rename lib/{efi => efi_client}/Makefile (100%)
 rename lib/{efi => efi_client}/efi.c (100%)
 rename lib/{efi => efi_client}/efi_app.c (100%)
 rename lib/{efi => efi_client}/efi_app_init.c (100%)
 rename lib/{efi => efi_client}/efi_info.c (100%)
 rename lib/{efi => efi_client}/efi_stub.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..46ef4359961 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1102,7 +1102,7 @@ F:	configs/efi-x86_app*
 F:	doc/develop/uefi/u-boot_on_efi.rst
 F:	drivers/block/efi-media-uclass.c
 F:	drivers/block/sb_efi_media.c
-F:	lib/efi/efi_app.c
+F:	lib/efi_client/
 F:	scripts/build-efi.sh
 F:	test/dm/efi_media.c
 
diff --git a/Makefile b/Makefile
index f88684947ee..b24a16627db 100644
--- a/Makefile
+++ b/Makefile
@@ -1686,7 +1686,7 @@ u-boot-payload.lds: $(LDSCRIPT_EFI) FORCE
 quiet_cmd_u-boot_payload ?= LD      $@
       cmd_u-boot_payload ?= $(LD) $(LDFLAGS_EFI_PAYLOAD) -o $@ \
       -T u-boot-payload.lds arch/x86/cpu/call32.o \
-      lib/efi/efi.o lib/efi/efi_stub.o u-boot.bin.o \
+      lib/efi_client/efi.o lib/efi_client/efi_stub.o u-boot.bin.o \
       $(addprefix arch/$(ARCH)/lib/,$(EFISTUB))
 
 u-boot-payload: u-boot.bin.o u-boot-payload.lds FORCE
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index 245b4af1fa3..42e84c13049 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -113,7 +113,7 @@ implemented completely differently.
 EFI Application
 ~~~~~~~~~~~~~~~
 For the application the whole of U-Boot is built as a shared library. The
-efi_main() function is in lib/efi/efi_app.c. It sets up some basic EFI
+efi_main() function is in lib/efi_client/efi_app.c. It sets up some basic EFI
 functions with efi_init(), sets up U-Boot global_data, allocates memory for
 U-Boot's malloc(), etc. and enters the normal init sequence (board_init_f()
 and board_init_r()).
@@ -149,7 +149,7 @@ image (including device tree) into a small EFI stub application responsible
 for booting it. The stub application is built as a normal EFI application
 except that it has a lot of data attached to it.
 
-The stub application is implemented in lib/efi/efi_stub.c. The efi_main()
+The stub application is implemented in lib/efi_client/efi_stub.c. The efi_main()
 function is called by EFI. It is responsible for copying U-Boot from its
 original location into memory, disabling EFI boot services and starting
 U-Boot. U-Boot then starts as normal, relocates, starts all drivers, etc.
@@ -192,7 +192,7 @@ careful to build the correct one so that your UEFI firmware can start it. Most
 UEFI images are 64-bit at present.
 
 The payload stub can be build as either 32- or 64-bits. Only a small amount
-of code is built this way (see the extra- line in lib/efi/Makefile).
+of code is built this way (see the extra- line in lib/efi_client/Makefile).
 Everything else is built as a normal U-Boot, so is always 32-bit on x86 at
 present.
 
@@ -353,7 +353,7 @@ This work could be extended in a number of ways:
 
 Where is the code?
 ------------------
-lib/efi
+lib/efi_client
 	payload stub, application, support code. Mostly arch-neutral
 
 arch/x86/cpu/efi
diff --git a/lib/Makefile b/lib/Makefile
index 18ae0cd87bf..1dd738a7cd1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@
 
 ifndef CONFIG_XPL_BUILD
 
-obj-$(CONFIG_EFI) += efi/
+obj-$(CONFIG_EFI) += efi_client/
 obj-$(CONFIG_EFI_LOADER) += efi_driver/
 obj-$(CONFIG_EFI_LOADER) += efi_loader/
 obj-$(CONFIG_CMD_BOOTEFI_SELFTEST) += efi_selftest/
diff --git a/lib/efi/Kconfig b/lib/efi_client/Kconfig
similarity index 100%
rename from lib/efi/Kconfig
rename to lib/efi_client/Kconfig
diff --git a/lib/efi/Makefile b/lib/efi_client/Makefile
similarity index 100%
rename from lib/efi/Makefile
rename to lib/efi_client/Makefile
diff --git a/lib/efi/efi.c b/lib/efi_client/efi.c
similarity index 100%
rename from lib/efi/efi.c
rename to lib/efi_client/efi.c
diff --git a/lib/efi/efi_app.c b/lib/efi_client/efi_app.c
similarity index 100%
rename from lib/efi/efi_app.c
rename to lib/efi_client/efi_app.c
diff --git a/lib/efi/efi_app_init.c b/lib/efi_client/efi_app_init.c
similarity index 100%
rename from lib/efi/efi_app_init.c
rename to lib/efi_client/efi_app_init.c
diff --git a/lib/efi/efi_info.c b/lib/efi_client/efi_info.c
similarity index 100%
rename from lib/efi/efi_info.c
rename to lib/efi_client/efi_info.c
diff --git a/lib/efi/efi_stub.c b/lib/efi_client/efi_stub.c
similarity index 100%
rename from lib/efi/efi_stub.c
rename to lib/efi_client/efi_stub.c
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 7f02a83e2a2..86b5a3f947f 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -587,6 +587,6 @@ config BOOTEFI_TESTAPP_COMPILE
 
 endif
 
-source "lib/efi/Kconfig"
+source "lib/efi_client/Kconfig"
 
 endmenu
-- 
2.43.0

base-commit: 2f3766949bbea7aa5a472157561d387fd94205d2
branch: efit
