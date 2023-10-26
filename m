Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21688C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B55387B9B;
	Thu, 26 Oct 2023 20:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OLHSRYrv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C8B87B23; Thu, 26 Oct 2023 20:31:55 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B9A87B5B
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1e9db321ed1so719034fac.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345110; x=1698949910; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AuPzyCGPgn45/EDbAEoZxAmuTASrqBvjZUgQtUDfvM=;
 b=OLHSRYrvYEqiTHZwCr7E9++tnKVSinTJGuapqKJBGWyfaoRWhQ3vhYvmTuqXIsc9om
 wLzO/zuriImVcxsWeHBXJx9TQtZG+01KSLQd8afzdd6MDXP4/cFsVI8LI19LXgny4/4H
 gJxOncRoNLc8GAEqcUaKCVzjaCBGP1rtz3Cgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345110; x=1698949910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AuPzyCGPgn45/EDbAEoZxAmuTASrqBvjZUgQtUDfvM=;
 b=VYbDQ5IR28khaqtKR4yramEoFnk4RjhV1prhVOymOa3BqufysP+72kJGtvbFjH022g
 acp7Ys7aIKyqQu+icowWkYe7XqU1YOJ0RCG+sk7le9rkiN1aGlX3tX0X81fdURX3Dq6y
 Ma7zhU8ZoD2dS/+U77TgcjiMrsMMRL5RQ8M/GpQjK1Q3JG0Jk33vWCRtmY669RqC9GOD
 0DJ7tV2Q6zVs4ssXgfRAXS1H3wnCGh8W6NCHBfer0RQ2CAcBCaWhxoXeiBQyKQiTmTJo
 aG/EkOVU7VPUvaf3X40yag8p2kRiRPz6hU0wWA7nw29y4tX5CWajf0lQdtCEvqr3Bj47
 RrKQ==
X-Gm-Message-State: AOJu0Yz6LVLcMnKOuKSsrnheWcJkOP4HFJpl6bZopSmx0wjZ7+kSBcUU
 JFC/MDI3ZNqhRvicQD5VD1I5qHaZr+qlB6LarlcNAQ==
X-Google-Smtp-Source: AGHT+IGHgqNUTbwTUXgV6nLnIj7bqEby8HzyqtLlxuJIkERjwkvCtKgvHoYa43i9qjThwCdMl5/Pfg==
X-Received: by 2002:a05:6870:200f:b0:1bf:9f6:b810 with SMTP id
 o15-20020a056870200f00b001bf09f6b810mr462158oab.36.1698345110293; 
 Thu, 26 Oct 2023 11:31:50 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [v5 12/30] efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
Date: Thu, 26 Oct 2023 14:31:20 -0400
Message-Id: <20231026183138.636948-12-trini@konsulko.com>
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

From: Simon Glass <sjg@chromium.org>

The command should not be used to enable library functionality. Add a
new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that the
same code is built.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>

Changes in v5:
None, because AKASHI Takahiro has taken up the work of a further
refactor. In response to v4 Heinrich wanted to just use BOOTEFI_BOOTMGR
and drop the CMD portion entirely. While I understand conceptually the
request, it would then make this code very different from all other
subcommands, even when they depend on CONFIG symbols for additional
functionality. If there's a strong objection to taking this patch, and
then further reworking things with AKASHI Takahiro's series being on top
of this series, an alternative would be moving the final portion where
CMDLINE=n is allowed and tested out of this series and in to a further
series that depends on both. They would all be applied in short order.

Changes in v4:
- Integrate AKASHI Takahiro's feedback from v3
- Reword the help text on CMD_BOOTEFI_BOOTMGR slightly
---
 cmd/Kconfig             | 11 ++++++++++-
 lib/efi_loader/Kconfig  |  6 +++---
 lib/efi_loader/Makefile |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f8b34ca504b2..bfe363710c79 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -379,6 +379,15 @@ config CMD_BOOTEFI
 	help
 	  Boot an EFI image from memory.
 
+config CMD_BOOTEFI_BOOTMGR
+	bool "UEFI Boot Manager command"
+	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
+	default y
+	help
+	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
+	  This subcommand will allow you to select the UEFI binary to be booted
+	  via UEFI variables Boot####, BootOrder, and BootNext.
+
 config CMD_BOOTEFI_HELLO_COMPILE
 	bool "Compile a standard EFI hello world binary for testing"
 	depends on CMD_BOOTEFI && !CPU_V7M
@@ -2118,7 +2127,7 @@ config CMD_EFIDEBUG
 config CMD_EFICONFIG
 	bool "eficonfig - provide menu-driven uefi variables maintenance interface"
 	default y if !HAS_BOARD_SIZE_LIMIT
-	depends on CMD_BOOTEFI_BOOTMGR
+	depends on BOOTEFI_BOOTMGR
 	select MENU
 	help
 	  Enable the 'eficonfig' command which provides the menu-driven UEFI
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index d20aaab6dba4..13cad6342c36 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -32,14 +32,14 @@ config EFI_LOADER
 
 if EFI_LOADER
 
-config CMD_BOOTEFI_BOOTMGR
+config BOOTEFI_BOOTMGR
 	bool "UEFI Boot Manager"
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
2.34.1

