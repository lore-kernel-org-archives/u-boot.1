Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3031BC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:25:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4370D88AB6;
	Thu, 15 Aug 2024 22:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HHVTK8aF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6927488AE8; Thu, 15 Aug 2024 22:24:45 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1647A88AB6
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39d20c4be2eso3499545ab.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753473; x=1724358273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J+3K1D32XFzIlqKv8IxwxtO9z9dD+tWb033XYnecns=;
 b=HHVTK8aFEuwzjyGNFdsPVvblWvn9RkKTdhM6iRzLV1SFMfRSXBBEazFux2PWePGap7
 /kMYeqOuqm0o/G1YtbuOz2bc/xpAcm+LQzocZLObEVenNoOFLX0FKJvDoCeRG2IYCaOE
 /lZIg6nlFvSdsdqab1w7ausXTNNsr9RjkU4p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753473; x=1724358273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6J+3K1D32XFzIlqKv8IxwxtO9z9dD+tWb033XYnecns=;
 b=PqbRIVSFNuHBHMA0aqgdphq8lwdceTsxbEnJoXxCEgEWoT+d+QS3oyPcOwaAlHRTYq
 aAsC7T/RTKfrxdLvhSDhPrizPqoNygSdjqVrBbk6u/FiPeUfIpvUdqFe58kjOoNDLmLY
 96hViJWcZZLvR4sqtnmR99VGDJ8AkXPuxlpC1Z9amjPAF9aMjTEXgjGY2paOpr/pJDAi
 BCrxrAjqdEo00G6AVX1vjINxkfSiJAG9g1UsPhc2FQz7zaE0EC6h0vL3xEYNLs/M7qQ7
 pEPTsNkjLg3zVaWjTi4MrFmLuSgY3h5gaELIKn5uThOaJYaZ/MBadKxjF5VeYSsNZnw5
 D0hA==
X-Gm-Message-State: AOJu0YyvR1T2FPCVriAnqP1waFJngWJmsngKUO6jNrWyXl1nCRaPyqnO
 YRxXv5hBL5kIsqEJylqVrE8lyOSfkQJ39cv3WZu7cl3HcMMtliNyJ6WwpxXzo9rRJ/YHniehLLg
 5+A==
X-Google-Smtp-Source: AGHT+IFPXVSUfZBpsenIkUIbFNzcyEM675Rk8vX0aq+oXNTRHx5KrBVvUP/gnzyZ79y+bbO9+QrVMg==
X-Received: by 2002:a05:6e02:1c29:b0:398:3b82:4ac8 with SMTP id
 e9e14a558f8ab-39d26d74544mr12333445ab.24.1723753472805; 
 Thu, 15 Aug 2024 13:24:32 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 06/14] efi_loader: Shorten the app rules further
Date: Thu, 15 Aug 2024 14:24:16 -0600
Message-Id: <20240815202424.766778-7-sjg@chromium.org>
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
2.34.1

