Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F165C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:34:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4F887BA2;
	Thu, 26 Oct 2023 20:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q5EQpWNa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BCD887641; Thu, 26 Oct 2023 20:31:59 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88E2B87AFF
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1e5bc692721so731654fac.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345114; x=1698949914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lk6UZTtc4HiJZhtxsxnmrrTruw3uvviFnh5aTuQsOHs=;
 b=Q5EQpWNa5rMW+6aMJOGHm58rbySJG5afAALkbvkkASbKIHM5ArQoUvQroEESL/X3Fi
 GoxvUWJjrFqN7vS899tZ7ky/synLb0qurTam1ovUdY0mllNmmsPB7AG6ChrOCr2bqfXQ
 OmB4aEM0DGsHqqrVFNUeR/DTKu15ElM30wB64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345114; x=1698949914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lk6UZTtc4HiJZhtxsxnmrrTruw3uvviFnh5aTuQsOHs=;
 b=TNUQl0V0YY14F+fTCkze7oJ+kU/PpTFDysKgpyrVDBD7aLTPX5mKhAGCZwBzamm/2W
 cyyL9hWlg67WS1+ZODGlKN0CM37YwdFyuST6tmc1EMVjndzGZVdJ0IdwOYjRbk0b0Z0q
 0YMJKrj0e6+bi4VlRiSx49whWKCFNx992pS6EmyiARIaJR0p/3K0dmJ70o1ZWzxa34hO
 6SGKWCDR55THUPTvAmmSLqBevvKNY4l2qP/NN30OzawAyGPd3Jhlr9I4sWMc+FRZmjgc
 M9KSUAByoOFpfaM4FTPUDFN9mEIVzxsKA5EU1fjo1TdVUnXf2vvdMwGi6dNVjj4566c4
 Eo9Q==
X-Gm-Message-State: AOJu0YwDUE5QfRaQ+UbD+QKUjmO48D0+1vXrpPI43VccusndESNdehTN
 8MT85jhfRoHE+JhUZLT94+ffm43l58ZIhqlpi8pHCg==
X-Google-Smtp-Source: AGHT+IHZ0h8FkpuVd/dTuDo0Zk5JCuWXAelzHEL3SgYaBfMlrBkrPWYX1nCnUZHJrIqMyBgtX8hoog==
X-Received: by 2002:a05:6870:1344:b0:1e9:94c1:917a with SMTP id
 4-20020a056870134400b001e994c1917amr351510oac.54.1698345113978; 
 Thu, 26 Oct 2023 11:31:53 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 17/30] boot: Move SYS_BOOTM_LEN to be by LEGACY_IMAGE_FORMAT
Date: Thu, 26 Oct 2023 14:31:25 -0400
Message-Id: <20231026183138.636948-17-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

This particular option is required for booting all image types,
regardless of if we are starting an OS via command line or something
else.  Move the question for SYS_BOOTM_LEN to be by the question for
LEGACY_IMAGE_FORMAT, as that's where our generic OS questions start.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 11 +++++++++++
 cmd/Kconfig  | 11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 88b9296ee1bf..7c92e0974c5f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -692,6 +692,17 @@ config LEGACY_IMAGE_FORMAT
 	  loaded. If a board needs the legacy image format support in this
 	  case, enable it here.
 
+config SYS_BOOTM_LEN
+	hex "Maximum size of a decompresed OS image"
+	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
+		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
+	default 0x4000000 if PPC || ARM64
+	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
+	default 0x800000
+	help
+	  This is the maximum size of the buffer that is used to decompress the OS
+	  image in to if attempting to boot a compressed image.
+
 config SUPPORT_RAW_INITRD
 	bool "Enable raw initrd images"
 	help
diff --git a/cmd/Kconfig b/cmd/Kconfig
index bfe363710c79..febfa2cdaa5f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -361,17 +361,6 @@ config BOOTM_VXWORKS
 	help
 	  Support booting VxWorks images via the bootm command.
 
-config SYS_BOOTM_LEN
-	hex "Maximum size of a decompresed OS image"
-	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
-		   LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
-	default 0x4000000 if PPC || ARM64
-	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
-	default 0x800000
-	help
-	  This is the maximum size of the buffer that is used to decompress the OS
-	  image in to, if passing a compressed image to bootm/booti/bootz.
-
 config CMD_BOOTEFI
 	bool "bootefi"
 	depends on EFI_LOADER
-- 
2.34.1

