Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A601CA101E
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F074A88A0A;
	Mon,  2 Sep 2024 03:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b1zyYSwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9B3288717; Mon,  2 Sep 2024 03:18:44 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E0088606
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39d47a9ffd5so14471315ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239921; x=1725844721; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6J+3K1D32XFzIlqKv8IxwxtO9z9dD+tWb033XYnecns=;
 b=b1zyYSwX20arzJh7CfzXIJRful58jLwIVv0H4b8Vv3xpX6d9MlUD1x5lOcUa3ujk5D
 c4+OLCJMA7ZqTW2w2rfgTlu2AurdDURmFkEBqNSzCRBRAfK32XpE1IhgXJkXT07bGXRQ
 fBhgLzh2L6rcJ9wLubL4rEktdzSGYPG8T1v4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239921; x=1725844721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6J+3K1D32XFzIlqKv8IxwxtO9z9dD+tWb033XYnecns=;
 b=LFkPcIeDEETLKRUUcJ9mA8unLcbd7mrfw2B4Fw/ODj0GkCGoyY+ZmBg5lTpoMWWsEp
 VemQQKBSz4yHMX37KcemebiZuCFR5kNtKdt+dBLrmmVbjIZCyAlwxeKufM8iNUd1K3ne
 5UHBulLS8tI+xnyI0X6ZKQxh3rfYd4fCJSq8OVMOFktibyOir6VImBRqbEgThaeapx/a
 jHw5p4+J1VoMMNAThLUFrOlvTFErAuf25iR/bvnBCQCisyKoq5x9zzQ6rz9+42Fv4yTT
 3C/KVZLwSKBitrNDqTvjAZKPq6+BKJ6Egx2bs9/RJZJkuYJLA+COK5krSwXFD1yNneXd
 Lbyg==
X-Gm-Message-State: AOJu0YydA2gTUrSncMYUTZwi49xg4TDoxMvM8KnchZgoIrVjvU1o6YXR
 4vovKjc1jUOqvO5Hd2iSKhF40LujziWE5OBpyCnSY353owoTGKmBLvzVzo1OSU2kqBV4G0mZTVc
 =
X-Google-Smtp-Source: AGHT+IF0a3RW7YOvPoM2J/wJ+MqM2h19KcWS1psrtncg01bDeeQ5Jm3YUxB/W898XOmck6UVcVUZFQ==
X-Received: by 2002:a92:8706:0:b0:39f:4ec5:f4ab with SMTP id
 e9e14a558f8ab-39f4ec5f66cmr57631055ab.19.1725239921114; 
 Sun, 01 Sep 2024 18:18:41 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 06/14] efi_loader: Shorten the app rules further
Date: Sun,  1 Sep 2024 19:18:17 -0600
Message-Id: <20240902011825.746421-7-sjg@chromium.org>
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

