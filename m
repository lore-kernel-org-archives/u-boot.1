Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C98CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2416588E9F;
	Fri, 27 Sep 2024 00:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GQ/7IeQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF5C188EC9; Fri, 27 Sep 2024 00:00:57 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6D4988E9F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb2458774dso9788696d6.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388054; x=1727992854; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0fE4v1/zhNDvHrzRjK/HlTmtUOa9OFPgm96GahDpEo=;
 b=GQ/7IeQZiDGQZpM7ttDvHxuBhTCYQoRyzvVd0H/LMkDJTxbvQtKWhK80sF7VENxkRY
 60x5tKEb6pAs3wjIDwZXWX/7OEVA+r6K2BAtdEXuKsJ9u5QtQHD3JOU3PWUuqRkF8b8S
 84kvQrLS+bgYHoSHLaDGF+09jL5tAJ1X24vv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388054; x=1727992854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0fE4v1/zhNDvHrzRjK/HlTmtUOa9OFPgm96GahDpEo=;
 b=dovlEI7DCfDWWNMl9n1PxOCzlwQGS6BChtiW5EGdjoRSvxJUaunBk/roEtiW8SanLS
 7bWFRSndkaEF/uKRxK6IcMpPMEKkjga6u/hoMfwv15y6xVArSWVVr/Kc+B0xFLR05ucm
 fNhogIgCjBVEUiwz+UbeRxdk5pdJZDSY5Q+wDhX7hsQ0xLNJJl6XnwCFnN5NvAe0/I9H
 odAZfNGQpbHyrNP0qmtv+1+/3fQE9S/CffB0Rq+NiUb48bbBzAc5zXnLR088uXfOJhTP
 XTRNX49yskB/vnBJDrrE1eD0aj/U4otqCrzcKOsqmi0m7FJpJ8qixhWgMGEJxUhpWTZp
 NCQQ==
X-Gm-Message-State: AOJu0YxyksHb8CfMyCzxAoIy9br2taQBcovOWcPu8yzmEFKni88BPTmZ
 2seHNUh0AkUp9q4PubRiKEuA0Tn+N4x7TWADumy5Av/sMnocPE6+/aO0xPLEK9z1d6vdNtTcRgs
 /HYO3zBY=
X-Google-Smtp-Source: AGHT+IFwJmHAbWwxHCh++mHksLZdNx3xBVm4wFbE7TVVGTJA2cc7X4ooIwsOJ06EcYiYCGFgqRD8tw==
X-Received: by 2002:a05:6214:5b09:b0:6c3:5c39:45e1 with SMTP id
 6a1803df08f44-6cb3b5d8f96mr14448986d6.12.1727388053897; 
 Thu, 26 Sep 2024 15:00:53 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b632366sm3079696d6.71.2024.09.26.15.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:00:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 03/12] efi_loader: Shorten the app rules
Date: Thu, 26 Sep 2024 23:59:33 +0200
Message-ID: <20240926215950.1265143-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926215950.1265143-1-sjg@chromium.org>
References: <20240926215950.1265143-1-sjg@chromium.org>
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

We have quite a few apps now, so create a way to specify them as a list
rather than repeating the same rules again and again.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v1)

 lib/efi_loader/Makefile | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 27dbd9e760d..660368b9d8f 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -22,29 +22,13 @@ CFLAGS_REMOVE_dtbdump.o := $(CFLAGS_NON_EFI)
 CFLAGS_initrddump.o := $(CFLAGS_EFI) -Os -ffreestanding
 CFLAGS_REMOVE_initrddump.o := $(CFLAGS_NON_EFI)
 
-ifdef CONFIG_RISCV
-always += boothart.efi
-targets += boothart.o
-endif
-
-ifneq ($(CONFIG_BOOTEFI_HELLO_COMPILE),)
-always += helloworld.efi
-targets += helloworld.o
-endif
-
-ifneq ($(CONFIG_GENERATE_SMBIOS_TABLE),)
-always += smbiosdump.efi
-targets += smbiosdump.o
-endif
-
+# These are the apps that are built
+apps-$(CONFIG_RISCV) += boothart
+apps-$(CONFIG_BOOTEFI_HELLO_COMPILE) += helloworld
+apps-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbiosdump
+apps-$(CONFIG_EFI_LOAD_FILE2_INITRD) += initrddump
 ifeq ($(CONFIG_GENERATE_ACPI_TABLE),)
-always += dtbdump.efi
-targets += dtbdump.o
-endif
-
-ifdef CONFIG_EFI_LOAD_FILE2_INITRD
-always += initrddump.efi
-targets += initrddump.o
+apps-y += dtbdump
 endif
 
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
@@ -95,3 +79,6 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
 
 EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
 $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
+
+always += $(foreach f,$(apps-y),$(f).efi)
+targets += $(foreach f,$(apps-y),$(f).o)
-- 
2.43.0

