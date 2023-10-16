Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D793BCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:39:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E43DC86F32;
	Tue, 17 Oct 2023 00:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YLj6Pmcu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3816086F31; Tue, 17 Oct 2023 00:32:07 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A4186E7C
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-77574c6cab0so360647085a.3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495513; x=1698100313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jfbCUiJ+1SX/Bmo2wTOjlqi9mydjomzp7KJe9tcgyx8=;
 b=YLj6PmcuSxmKHEUykT5o/RclDziHerv9z9hkab2OCfwwaHmbR25+b6I4wh/DjLCqcK
 SCEYQifAP/p/+WpoKfhpCbgh1PNAKXJ4sMS7jr2c+UAkIHSN571GkcGn15PNwEJbO2j8
 DE2FYb9kFig6yg3cUtx2c5FRWjbgP/DH/07o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495513; x=1698100313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jfbCUiJ+1SX/Bmo2wTOjlqi9mydjomzp7KJe9tcgyx8=;
 b=qai+9z4JO1xVbKpO/i27SnBKjyq2SJRkfljKIurvwWrfSdmbjRLA4xaF5cRDqFkkdy
 YjycKxoGZq/adbh8SA7By6YWEenlVt18bcN74yLcA+YMnFHmtcuXvSPDbQuAFjo4OT6y
 AI0WNWt54jaBedw2JMV9DiFfQ7AqpEkZjMdDDJErjQmCXhl+26hvb03Ag0Ul+n3cJxeH
 AAM7YyBPRrLjMCck1iSF4wYa8Fmmpc2vUYmh7KqKrSZiEtOn5y6zAlUxZUm85HXGrmhO
 PBfK3rG1BUY0X22f2HPJbdZcMXGNGZH+OpU/i3QG1l37yaCd6eShP/hNb5jC62k+kofd
 o0CQ==
X-Gm-Message-State: AOJu0YxFpWFyFo9xJyOEyp7b9Ku2yoAp50RdJ489b1ez589AfzGkKe/h
 5yiCD5ILmYv25w06/D3RcbZIkQVHTMFlLNTu0KNMRg==
X-Google-Smtp-Source: AGHT+IHxV7TbFT0T/aQjr9E+YlBCCXRl32iGB3g41FMqP+7TKrFl1P0I6+4N9eynsTkgBxiVup4/zw==
X-Received: by 2002:a05:620a:6005:b0:775:9a54:a02b with SMTP id
 dw5-20020a05620a600500b007759a54a02bmr465602qkb.64.1697495512756; 
 Mon, 16 Oct 2023 15:31:52 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:31:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v3 21/32] efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
Date: Mon, 16 Oct 2023 16:28:12 -0600
Message-ID: <20231016222835.596572-22-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

The command should not be used to enable library functionality. Add a
new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that the
same code is built.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---

Changes in v3:
- Add new patch to rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR

 cmd/Kconfig             | 9 +++++++++
 lib/efi_loader/Kconfig  | 7 +++----
 lib/efi_loader/Makefile | 2 +-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 46e484fc08b6..3b4112d9f319 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -306,6 +306,15 @@ config CMD_BOOTI
 	help
 	  Boot an AArch64 Linux Kernel image from memory.
 
+config CMD_BOOTEFI_BOOTMGR
+	bool "UEFI Boot Manager command"
+	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
+	default y
+	help
+	  Select this option if you want to select the UEFI binary to be booted
+	  via UEFI variables Boot####, BootOrder, and BootNext. This enables the
+	  'bootefi bootmgr' command.
+
 config BOOTM_LINUX
 	bool "Support booting Linux OS images"
 	depends on CMD_BOOTM || CMD_BOOTZ || CMD_BOOTI
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 621ed5e5b0fb..13cad6342c36 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -32,15 +32,14 @@ config EFI_LOADER
 
 if EFI_LOADER
 
-config CMD_BOOTEFI_BOOTMGR
+config BOOTEFI_BOOTMGR
 	bool "UEFI Boot Manager"
-	depends on CMDLINE
 	default y
 	select BOOTMETH_GLOBAL if BOOTSTD
 	help
 	  Select this option if you want to select the UEFI binary to be booted
-	  via UEFI variables Boot####, BootOrder, and BootNext. This enables the
-	  'bootefi bootmgr' command.
+	  via UEFI variables Boot####, BootOrder, and BootNext. You should also
+	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
 
 choice
 	prompt "Store for non-volatile UEFI variables"
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 8d31fc61c601..0a2cb6e3c476 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -42,7 +42,7 @@ targets += initrddump.o
 endif
 
 obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
-obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) += efi_bootmgr.o
+obj-$(CONFIG_BOOTEFI_BOOTMGR) += efi_bootmgr.o
 obj-y += efi_boottime.o
 obj-y += efi_helper.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o
-- 
2.42.0.655.g421f12c284-goog

