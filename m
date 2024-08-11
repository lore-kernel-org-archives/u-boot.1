Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E67EC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D17788BB5;
	Sun, 11 Aug 2024 16:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mTDU1bjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71BAC88BCB; Sun, 11 Aug 2024 16:52:56 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D18F889CB
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso15679825ab.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387973; x=1723992773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDi34zh5iUF/lazft3RFzZ6HaolClJOkEgnwinZkr2E=;
 b=mTDU1bjm40znMQLf6sMC0sFe6go4+PAz0RzK/vmOBh6+NhaxV5f3jPi32HoJl8yWxA
 qh4IhLCp/ZhBKj/AxU5EM0257fEInJEJWmU1ofOAL1Lem7DIavOCsJLOLABR8DhY0TwO
 dHo/dcpY+n8fBjUvnMh0IlKmqjUj+aPrMdEAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387973; x=1723992773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VDi34zh5iUF/lazft3RFzZ6HaolClJOkEgnwinZkr2E=;
 b=mMnpnmGhIl2BsZEvbej1fcJ9RFWPCGWtk5Zn9Gi1rr5lPy1PSpXaLScfg/zlik0FHn
 +3fsqNYauSDChcqQZmb8Q8seh72222mv2c6msjPC+JzoPeVAnbgQrU0o+sw34pM5PL7u
 jBKnIfXsJNHfPuEFSZVC1UA2v4avj7BbLXStb/ClGdMrTgJzpX2UaGhGjPGFgdCrDBej
 gCDyFK1GUvz85KYyGjtELjYZWuM3JIC+CodKwbtyKyafggLAOCgj7HCcnTZWXi6Cn4mR
 jwpvb9haDMhcXb2C299GxQxNeAu4S35lHMqvAhbgeU8XCLmhgaw3D4HxoTquzW+DgrMo
 kkJA==
X-Gm-Message-State: AOJu0YzfRkcVWBA10FmbqrXuW10BkUnNnrgxz4nehvF/MusWnRoKg7ac
 X2gF7bhfnD70auBJ7AStHE4ordRP+Bn9crn2WlzcUoFbaLBAkptLUmYVsuNTME1teo2/ZHOvFlo
 =
X-Google-Smtp-Source: AGHT+IETZ5LLPYO6Bo4Vrjnt3WK5QANA5aYgZhcz7uv0ys+4FqLC3IwtdaRnty3HzjgsL+XWuFNc+w==
X-Received: by 2002:a05:6e02:138c:b0:39a:e9ec:9462 with SMTP id
 e9e14a558f8ab-39b748522fdmr95338715ab.5.1723387973042; 
 Sun, 11 Aug 2024 07:52:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 29/40] efi_loader: Shorten the app rules
Date: Sun, 11 Aug 2024 08:51:58 -0600
Message-Id: <20240811145209.4191404-30-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

