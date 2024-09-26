Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29718CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED1488EE0;
	Fri, 27 Sep 2024 00:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mSWpq7j7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42E4088EE2; Fri, 27 Sep 2024 00:01:06 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F26F88EE0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:01:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6cb2c5128d5so9931386d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388063; x=1727992863; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zILTwi5mQXhaEo7onWN3pBa95BZkAMxEkeivqeC9TpQ=;
 b=mSWpq7j7x1K+cyqOuuQbTIk6pCdhIcgQDIBzPa/3jkZtMoA5a8MgwSpYWCb4N5jOSS
 onhWX7uOaKNCaFJmHIrs6C/Tm8gRJc4tiS2mBt9HQsYR8y4Vd6yCQ82Zid9ybV2ta+PL
 cROxhIBuNqY0Q2QmtsG4PwSu0jczcQn06dtWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388063; x=1727992863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zILTwi5mQXhaEo7onWN3pBa95BZkAMxEkeivqeC9TpQ=;
 b=CjUGnxeFK1o2X2caA0zkVWqiE4UaMLUpkZD9MUSdtO1W8IXvX3Z1tudIB8WG4ez7Bk
 Z5KFQQ8DCnMr209H5dAhGjrjTNcDGFQJtO7KbtSe+4eby6ukHpzOGrIkF4MWSUWaL/Qe
 YyjX3TSd5lMVDgqmLEKp6Hqsu6UKi6Q3bCIFaMpE1ILw/2m7UQkXgwx1d4Ah0K5l2Gi7
 T88rcT99OLamCalWD1XadcpxPIPdlorTyFtt4tNPdtmeeNFmGxmuQ60+3KFJpmadVE47
 j/On4tlcXLL3RqiH+FziGpcAWAkn1CiXsT870jcsqvJ9OvS7DFF67dmnI5T4tiOUePpK
 35Bg==
X-Gm-Message-State: AOJu0YybJsNiOKjINKG5yB/0HjN4ng/jd8XA+VfchxNvt+aEE6ypNHmO
 N776QliBgOpu5BYP3p9zbamelfJ2fdVAmw+bN36y1TX4Iy+UztCJ96B4+IGh2Oh7CTcpdhgSP0R
 5Dj7lv7o=
X-Google-Smtp-Source: AGHT+IFQalFVcHwyQvoyoPii19SXMGzUHLjcmaZ/kgRCCojU1zaFRss0bhA9eMPUd+XnMVtZhJw7Aw==
X-Received: by 2002:ad4:4450:0:b0:6cb:3ba3:8eab with SMTP id
 6a1803df08f44-6cb3ba38f1amr13091336d6.31.1727388062601; 
 Thu, 26 Sep 2024 15:01:02 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b632366sm3079696d6.71.2024.09.26.15.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:01:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 04/12] efi_loader: Shorten the app rules further
Date: Thu, 26 Sep 2024 23:59:34 +0200
Message-ID: <20240926215950.1265143-5-sjg@chromium.org>
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

Add a way to factor out the CFLAGS changes for each app, since they are
all the same.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
2.43.0

