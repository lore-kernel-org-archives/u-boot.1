Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA33C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:05:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75D288AE0;
	Tue,  6 Aug 2024 14:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZCRriwM2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFF388AD8; Tue,  6 Aug 2024 14:59:50 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E8788AA6
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-39b3a4d2577so1877145ab.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949184; x=1723553984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0vNVN0th9jf7sh1gUhjaR7iZSVKY+5V3kIOrxx7hYw=;
 b=ZCRriwM2k7k1xZLSkjHdGqaroUnCKXMRn3b8ejy+iptu2HyWeXe+mzOCllo9UKNLLf
 YLd5nmHLJoP5OZmBvtz2nqKU9nzv09KW0YpKlawvw3MxSrbl79DSgN1LCaQlnnnEbG7a
 ZVE0QCu7O2wXxK6wwY5YcXcCul/wydVe3+Hz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949184; x=1723553984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0vNVN0th9jf7sh1gUhjaR7iZSVKY+5V3kIOrxx7hYw=;
 b=NXqSC9eUrU5u32KGWL1AmeLPat+pUxAs6ltbZ7p/vsN6Ve3ed12h8G0bci1s/XrMBR
 tywffTgSHBE4Lfr7n2Q2j13UHZFVUYA7vSpT6b2GMd4CMkvFyiPP+ivg4jqG1pLUUNzG
 EMc8xgw2oJ1IlrnjG/pvfkdO8V5cQ+ymtwMESZojU18vz/3pzVX5s2QmMOGJHiWJsQ8f
 eUC/Q6TMCm0UWMSyxDbv+EBlChbvy9za+Re5g5yPQ4dIVIPcypi66tFdxpNOV071u768
 3+y3yTzvFh2GhsjTY1U5qjO+S2YEOzVh/XP7V4tiqkPj6+g59/Pe60tHydmMAW2n1KMs
 6JWA==
X-Gm-Message-State: AOJu0Ywcoukfj/ebalUvXUejArAttzn/Lf3uQSX2zOCzGD13sH/uylXw
 mbbsB/HDkstY9DOvFTPHhf57prZbwHw8nFjppu37al15wAKOO3i2tD/Zgv+5ghLHhCkoVPSG5xk
 =
X-Google-Smtp-Source: AGHT+IEUL7C+pi0Y/8VekKceyWohM5MuzBY1uJ5eXe1BlUCM6VbI/PjclFD3oM1ApD6G1S9/z0s4ug==
X-Received: by 2002:a92:d681:0:b0:375:a15e:d260 with SMTP id
 e9e14a558f8ab-39b1fb87164mr142521195ab.7.1722949184130; 
 Tue, 06 Aug 2024 05:59:44 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 29/39] efi_loader: Shorten the app rules further
Date: Tue,  6 Aug 2024 06:58:40 -0600
Message-Id: <20240806125850.2316956-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

Add a way to factor out the CFLAGS changes for each app, since they are
all the same.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/Makefile | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 660368b9d8f..00d18966f9e 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -11,16 +11,6 @@ asflags-y += -I.
 CFLAGS_efi_boottime.o += \
   -DFW_VERSION="0x$(VERSION)" \
   -DFW_PATCHLEVEL="0x$(PATCHLEVEL)"
-CFLAGS_boothart.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_boothart.o := $(CFLAGS_NON_EFI)
-CFLAGS_helloworld.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_helloworld.o := $(CFLAGS_NON_EFI)
-CFLAGS_smbiosdump.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_smbiosdump.o := $(CFLAGS_NON_EFI)
-CFLAGS_dtbdump.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_dtbdump.o := $(CFLAGS_NON_EFI)
-CFLAGS_initrddump.o := $(CFLAGS_EFI) -Os -ffreestanding
-CFLAGS_REMOVE_initrddump.o := $(CFLAGS_NON_EFI)
 
 # These are the apps that are built
 apps-$(CONFIG_RISCV) += boothart
@@ -80,5 +70,10 @@ obj-$(CONFIG_EFI_ECPT) += efi_conformance.o
 EFI_VAR_SEED_FILE := $(subst $\",,$(CONFIG_EFI_VAR_SEED_FILE))
 $(obj)/efi_var_seed.o: $(srctree)/$(EFI_VAR_SEED_FILE)
 
+# Set the C flags to add and remove for each app
+$(foreach f,$(apps-y),\
+	$(eval CFLAGS_$(f).o := $(CFLAGS_EFI) -Os -ffreestanding)\
+	$(eval CFLAGS_REMOVE_$(f).o := $(CFLAGS_NON_EFI)))
+
 always += $(foreach f,$(apps-y),$(f).efi)
 targets += $(foreach f,$(apps-y),$(f).o)
-- 
2.34.1

