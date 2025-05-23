Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB17C54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60A898310F;
	Fri, 23 May 2025 15:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sfv4hEn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF418831FE; Fri, 23 May 2025 15:07:45 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFF683108
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a366843fa6so4249575f8f.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748005663; x=1748610463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tEc0gJSULfSgxGAGKYDeC5xRpmQGsRABlVvY0pbWVU=;
 b=Sfv4hEn2re2Yo1we7SKu/Fsn3CyzN+8+ovmww/O/X5fkSFcchQvGAADr3682ITtlZU
 0nYed1GV2matDjzQs1oKQHTZTt4d6TwgcBAPig5WrHhErHTt0iY+f6tyThVgBScC7C+l
 ZHBeY1rZHJo+yP+38ZjKq1UgnM1OCXQeoLGxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748005663; x=1748610463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tEc0gJSULfSgxGAGKYDeC5xRpmQGsRABlVvY0pbWVU=;
 b=qRr727PE4u8rKz2rKDFF0hefUxlWb90uwZW0LxvbS6fyV1E9qC/Mm7tgSKYQ4oOc0Q
 O2NDk0jbd7J+8KmWuUMHjcKgRB5A6CHowQmzBoqdUWrxE/HVe8X2rYyAkwLVxBvvemCu
 mt0BLBruyRXg/Rnwastk/tDwe7iq0GKxVxuLM8IG+PcMlfIUbdXcA951/+n8Gx5PZ82a
 uRC9yqevK0Ode864Jm6Qp2PI4Tnsm0ADqfrIaXA7rZ3FYQImJKFZixJgXxAvtUlRJT97
 9/bNcSMU37SG5NPWhHzS0thTFZe8UztC13H8z0qZf/zyY2jUURoTnLz8eMvtPWOD3SQU
 uM0Q==
X-Gm-Message-State: AOJu0Yw4v/iVaVJnRE/WGrtFvLkfIIxVw8asrxv2tXqFsS0M4p+V9rWV
 T1gThsBOnK6HA/EayOQaA9pRHYI0KzlDpIgKwasruzapW53dHR9oK8ZaIfO5rIJx9rdHieAIGd2
 Lmi9h0Cty
X-Gm-Gg: ASbGnct4QN/JCOyn1VIN7AiNwdVjAkYln47IA8GUL33Z6ZnQBxmyvV0XnALw9WXHUiy
 +Hd6s38W9UcXstVOQOQoIWPPlaTvm4rvnuufNj+l1TXExr41Gq3Rrx/hyP82xWjvyW3+adtm8HB
 2WesHU97PdEg9FnAOyVRtooo4JVvNPvA43+MsQ4fcghU8MhN76gYstONJUT8UZ2VYYjIARIZ9b8
 RxDvo5Op+LHeaYvSVH6EiiPtxIQ7osZCCbvzFS2yk4x9BU+C1SYpq4CdffMQDs8b0JsMRKUNA5R
 ndUIXoXVuoysG7oUnucd8WlfXBKmfkypFVXLuPV5jy301Tj7bKsvW85//wd1e1YOGD3yeYs=
X-Google-Smtp-Source: AGHT+IFZ+P82uWOwfWUDgifd3fIHuuipQ2mg/FWqyPpOZKrabGtqjoMN7MEUQF381flFIe5Wa27flg==
X-Received: by 2002:a05:6000:1862:b0:3a3:55ee:8658 with SMTP id
 ffacd0b85a97d-3a35fddc975mr25253995f8f.0.1748005662692; 
 Fri, 23 May 2025 06:07:42 -0700 (PDT)
Received: from chromium.org (82-132-216-100.dab.02.net. [82.132.216.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm12109241f8f.100.2025.05.23.06.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 06:07:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/10] efi: Rename the lib/efi directory
Date: Fri, 23 May 2025 14:06:39 +0100
Message-ID: <20250523130651.1329593-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250523130651.1329593-1-sjg@chromium.org>
References: <20250523130651.1329593-1-sjg@chromium.org>
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

 MAINTAINERS                              | 2 +-
 Makefile                                 | 4 ++--
 doc/develop/uefi/u-boot_on_efi.rst       | 8 ++++----
 lib/Makefile                             | 2 +-
 lib/{efi => efi_client}/Kconfig          | 0
 lib/{efi => efi_client}/Makefile         | 0
 lib/{efi => efi_client}/efi.c            | 0
 lib/{efi => efi_client}/efi_app.c        | 0
 lib/{efi => efi_client}/efi_app_init.c   | 0
 lib/{efi => efi_client}/efi_dtb.S        | 0
 lib/{efi => efi_client}/efi_info.c       | 0
 lib/{efi => efi_client}/efi_stub_arm64.c | 0
 lib/{efi => efi_client}/efi_stub_x86.c   | 0
 lib/{efi => efi_client}/efi_vars.c       | 0
 lib/{efi => efi_client}/sdram.c          | 0
 lib/efi_loader/Kconfig                   | 2 +-
 16 files changed, 9 insertions(+), 9 deletions(-)
 rename lib/{efi => efi_client}/Kconfig (100%)
 rename lib/{efi => efi_client}/Makefile (100%)
 rename lib/{efi => efi_client}/efi.c (100%)
 rename lib/{efi => efi_client}/efi_app.c (100%)
 rename lib/{efi => efi_client}/efi_app_init.c (100%)
 rename lib/{efi => efi_client}/efi_dtb.S (100%)
 rename lib/{efi => efi_client}/efi_info.c (100%)
 rename lib/{efi => efi_client}/efi_stub_arm64.c (100%)
 rename lib/{efi => efi_client}/efi_stub_x86.c (100%)
 rename lib/{efi => efi_client}/efi_vars.c (100%)
 rename lib/{efi => efi_client}/sdram.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3dae1c618ba..ec8cafac13c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1073,7 +1073,7 @@ F:	configs/efi-x86_app*
 F:	doc/develop/uefi/u-boot_on_efi.rst
 F:	drivers/block/efi-media-uclass.c
 F:	drivers/block/sb_efi_media.c
-F:	lib/efi/
+F:	lib/efi_client/
 F:	scripts/build-efi
 F:	test/dm/efi_media.c
 
diff --git a/Makefile b/Makefile
index 24b8076f468..5cde0955cfc 100644
--- a/Makefile
+++ b/Makefile
@@ -1687,8 +1687,8 @@ EFI_STUB_ARCH := $(if $(CONFIG_ARM64),arm64,$(if $(CONFIG_X86_64),x86,$(ARCH)))
 quiet_cmd_u-boot_payload ?= LD      $@
       cmd_u-boot_payload ?= $(LD) $(LDFLAGS_EFI_PAYLOAD) -o $@ \
       -T u-boot-payload.lds $(if $(CONFIG_X86),arch/x86/cpu/call32.o,) \
-      lib/efi/efi.o lib/efi/efi_stub_$(EFI_STUB_ARCH).o u-boot.bin.o \
-      $(addprefix arch/$(ARCH)/lib/,$(EFISTUB))
+      lib/efi_client/efi.o lib/efi_client/efi_stub_$(EFI_STUB_ARCH).o \
+      u-boot.bin.o $(addprefix arch/$(ARCH)/lib/,$(EFISTUB))
 
 quiet_cmd_u-boot_payload_arm64.efi ?= OBJCOPY $@
       cmd_u-boot_payload_arm64.efi ?= $(OBJCOPY) -O binary u-boot-payload $@
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index e9f8e9c297c..ba3b3f501f1 100644
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
index 30b1933b8ef..95f11903d57 100644
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
diff --git a/lib/efi/efi_dtb.S b/lib/efi_client/efi_dtb.S
similarity index 100%
rename from lib/efi/efi_dtb.S
rename to lib/efi_client/efi_dtb.S
diff --git a/lib/efi/efi_info.c b/lib/efi_client/efi_info.c
similarity index 100%
rename from lib/efi/efi_info.c
rename to lib/efi_client/efi_info.c
diff --git a/lib/efi/efi_stub_arm64.c b/lib/efi_client/efi_stub_arm64.c
similarity index 100%
rename from lib/efi/efi_stub_arm64.c
rename to lib/efi_client/efi_stub_arm64.c
diff --git a/lib/efi/efi_stub_x86.c b/lib/efi_client/efi_stub_x86.c
similarity index 100%
rename from lib/efi/efi_stub_x86.c
rename to lib/efi_client/efi_stub_x86.c
diff --git a/lib/efi/efi_vars.c b/lib/efi_client/efi_vars.c
similarity index 100%
rename from lib/efi/efi_vars.c
rename to lib/efi_client/efi_vars.c
diff --git a/lib/efi/sdram.c b/lib/efi_client/sdram.c
similarity index 100%
rename from lib/efi/sdram.c
rename to lib/efi_client/sdram.c
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 01447ae9f7a..9c67cf55283 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -608,6 +608,6 @@ config BOOTEFI_TESTAPP_COMPILE
 
 endif
 
-source "lib/efi/Kconfig"
+source "lib/efi_client/Kconfig"
 
 endmenu
-- 
2.43.0

