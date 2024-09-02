Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99501CA101E
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:19:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98CFA88ABF;
	Mon,  2 Sep 2024 03:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B8ZWDarw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5C5488A6C; Mon,  2 Sep 2024 03:18:43 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCA488901
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-39d3636e955so13405005ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239920; x=1725844720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12B1yvdC0Ari13W8CfkME18RN43gdPplxq9p6jmguNc=;
 b=B8ZWDarwwn1OtM4oHaCUId6C0qkSYAgL5DhzIqwV46qvvGPPOP066orRNk5CnqY6g1
 euEK0hvpYkIdPUA4h+EhB5CTyfRr1WgV2jcwChhQPKsncnxKL7wBrwcAkKkLF82oGWH7
 n8d9xNfG8j7/woikwa1ayCw/ApTSvNhsFRKzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239920; x=1725844720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12B1yvdC0Ari13W8CfkME18RN43gdPplxq9p6jmguNc=;
 b=P8NOZ2QA8WYFcDS2BZuqhdEif7FGlESJBUyDawXW2u5X3WgVLi1mf6CWonZcMg7ytO
 EcvZNC/nte0i+Z5HDWUNBrZfmh6AKIPUmgryMk6EODErqrw2rTOwt4tMV6TrMYWMJjqv
 EXOXP8b31jdHtS8yi4ECFX8/6RkZF55RM7LOr9tH+8bEUzst0kpoz8ynVOtjXpuOWXhG
 AeixBZ8zQVGLC6V6oulLel4B9uAS3f+V29XFb8Irqg5bSD3u+5MZfyggjETN0t020u0s
 5SWeAH1fN/h3GFBOYx2SgLdJPmur2r/P67a9Di8GADDIXH+JPeEFpoly0WyVO6NowaZQ
 eZdg==
X-Gm-Message-State: AOJu0YxIpX0PeKBF0pRNzjb/CiWhPT3uqCJp/jCTZAHVDWnMAxBFNbXk
 9ZXJRaw0egSgATfYa8VqvmReLCVaFwP9BmYdecot24CclHiA/aGrPsqEmPpVJlihX1A38oPIVds
 =
X-Google-Smtp-Source: AGHT+IEPXabqUJ4Yj+LpJytdWL792lXe95PapXJOUqb8U1Jeli6kmd+JdTS+AJaL7Bk30VbVa0QOuQ==
X-Received: by 2002:a05:6e02:1c82:b0:39d:1037:42e2 with SMTP id
 e9e14a558f8ab-39f4f6c1b0cmr67158855ab.18.1725239920023; 
 Sun, 01 Sep 2024 18:18:40 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 05/14] efi_loader: Shorten the app rules
Date: Sun,  1 Sep 2024 19:18:16 -0600
Message-Id: <20240902011825.746421-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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
2.34.1

