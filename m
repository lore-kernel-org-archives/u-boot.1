Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CDAFC3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EC088ABE;
	Thu, 15 Aug 2024 22:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SX0nYocB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2272E88AE8; Thu, 15 Aug 2024 22:24:44 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C919488AB2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-39d2044b522so3095415ab.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753472; x=1724358272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDi34zh5iUF/lazft3RFzZ6HaolClJOkEgnwinZkr2E=;
 b=SX0nYocBMNzumtmIdTzTmQeuupoXGtPztZYiE6VFXz/l1FMydxdJbU+C6NfYAc/dkK
 ofgWHbkx/EW8RCDZqF2P9YUuoaaUk7jQ/l0QxhWBabEdQGYBstRu25Z+hl3vpNeJackc
 EoG2uBkASmxfMbfFjMktQFnKdplSe5RLilIWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753472; x=1724358272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDi34zh5iUF/lazft3RFzZ6HaolClJOkEgnwinZkr2E=;
 b=bnj3hfrvEORPl47yQdLfJltKFVNQcAKgoGYNnXGaq+8TXFpeCOub78f2+5X8ob9VVh
 HZ+21TFry2xc0nEPP02ieQZojpcdD4QhQR9A3mR/dBtTdsfVdYMb47BnTy1cpq2CpSXH
 gk07tT13A1TURyMfIzO/BwwZwYEj4FESl3W3cJMGDIUP01uZ7fQE0mflIHX1NPl90JdM
 feZ8j+oXz7vDA3Sae6ZhToZexRtJLA1muFflcxoWUhtNiOBVnSCIaKpNCeec+TjWZpH6
 45YOdH/acWM6eKlxo75BVMiOyRaxOLRZohvBGyPVGViF+SBYxpX8FgHE2F8t+dcXWwmK
 X1Gw==
X-Gm-Message-State: AOJu0YzQmJM/eqglohsBswd7YeTJO82kqbJ9JKPNUOZvKjH3b7Kn+cPG
 XfAM3L05B40RiEER9CH/CquZwq7CwMSOYRDB2poF7e5WToJzOBRvk16TdbxchckHD1ertv6XPQa
 0qA==
X-Google-Smtp-Source: AGHT+IGnypvAh96tBfumfsqmWJoFkaSjWi7LyoNme0qyI5xSGDe/kG21GfLwPuJH1Sb43eOEU3B2cA==
X-Received: by 2002:a05:6e02:1689:b0:39b:3a44:fe8a with SMTP id
 e9e14a558f8ab-39d26cdf7d9mr9621315ab.4.1723753471997; 
 Thu, 15 Aug 2024 13:24:31 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 05/14] efi_loader: Shorten the app rules
Date: Thu, 15 Aug 2024 14:24:15 -0600
Message-Id: <20240815202424.766778-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202424.766778-1-sjg@chromium.org>
References: <20240815202424.766778-1-sjg@chromium.org>
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
2.34.1

