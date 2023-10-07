Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE53E95A77
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB7486F55;
	Sun,  8 Oct 2023 01:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g6HXy2Ov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27D2D86F1A; Sun,  8 Oct 2023 01:13:46 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34ECA86EC6
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3515deaa7c1so14216925ab.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720389; x=1697325189; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+zaT9mMwoRJjMivhawpct2oEMU8J9bXbSHghNIup9PU=;
 b=g6HXy2Ov/jELAwiYRzitjDaJY2AmUXvuRk1Eapr6Nsiavfai1l86gN22MuWwG1NKez
 j4zK84lB5NlL4qNehgD3u9/ofQ4+jyaUCd5+t/XQdsvmfm2Xdoww0uC2DwviZ7hgyWqV
 /mpqP3kiQ0gi3EfWhV83Wc9PQMfC9XUHZYEJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720389; x=1697325189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+zaT9mMwoRJjMivhawpct2oEMU8J9bXbSHghNIup9PU=;
 b=INWq98T/4iTDVqIwe+Vi1oXYUGyGkS1MUZFxx5WyAc/R+LVCpUqtbxQzIBWc1KE8xN
 WN8GLsleRS4LJpTvB5M7xH3YnB5gBTO1tyyuo5a3rAIeLThaUlKJ58g/XV0Fcf+PK2TA
 Thk3Vk7QoHrNy0Aac1VLi6eXIL7fuEB0+lpQit3BaaCHtMNkBgEiIodRJrXmNsnhCaGJ
 PHJV4eFtC+Uis2rKIlDJ5ceS2gPUgbQDnJ9zLaGvXY3Flge+LnZfsQ/bvqtGkDqvEWnM
 xCQmdL16KP1paugPyqJIsgnuNT2V4UQtlmaBNHFvYO6byZQDhVUKUWxkracVtzHMoW0M
 Cxog==
X-Gm-Message-State: AOJu0YyCLU3/hhFPZYmGPUwKxRcGI2RIDmj+AQyEPyoc7bBbTrmxPecP
 SwO1/AJrxtNGDeUanFkMSj1B82GpO/5zlnOP/G0=
X-Google-Smtp-Source: AGHT+IECf5XdY2iLXpLK1GIZU2G6RY0n2aWS+Le/yfa4tDJIAd+u0tRGVgNQmEW+COtNxinZAwcpWQ==
X-Received: by 2002:a05:6e02:1527:b0:348:8b42:47d with SMTP id
 i7-20020a056e02152700b003488b42047dmr14788327ilu.28.1696720389352; 
 Sat, 07 Oct 2023 16:13:09 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 06/27] cmd: Add a few more dependencies on CMDLINE
Date: Sat,  7 Oct 2023 17:12:25 -0600
Message-ID: <20231007231255.277623-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

Add this to some more commands to avoid build errors with sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6470b138d2f8..f914da6fe1ac 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -224,6 +224,7 @@ menu "Boot commands"
 
 config CMD_BOOTD
 	bool "bootd"
+	depends on CMDLINE
 	default y
 	help
 	  Run the command stored in the environment "bootcmd", i.e.
@@ -413,6 +414,7 @@ source lib/efi_selftest/Kconfig
 
 config CMD_BOOTMENU
 	bool "bootmenu"
+	depends on CMDLINE
 	select MENU
 	select CHARSET
 	help
@@ -479,6 +481,7 @@ config CMD_GO
 
 config CMD_RUN
 	bool "run"
+	depends on CMDLINE
 	default y
 	help
 	  Run the command in the given environment variable.
@@ -569,6 +572,7 @@ menu "Environment commands"
 
 config CMD_ASKENV
 	bool "ask for env variable"
+	depends on CMDLINE
 	help
 	  Ask for environment variable
 
@@ -2125,6 +2129,7 @@ config CMD_EFICONFIG
 
 config CMD_EXCEPTION
 	bool "exception - raise exception"
+	depends on CMDLINE
 	depends on ARM || RISCV || SANDBOX || X86
 	help
 	  Enable the 'exception' command which allows to raise an exception.
@@ -2231,6 +2236,7 @@ config CMD_SYSBOOT
 
 config CMD_QFW
 	bool "qfw"
+	depends on CMDLINE
 	select QFW
 	help
 	  This provides access to the QEMU firmware interface.  The main
-- 
2.42.0.609.gbb76f46606-goog

