Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55ED8CDB482
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5693F86F60;
	Tue, 17 Oct 2023 00:33:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="db/aZduk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AADC086EE3; Tue, 17 Oct 2023 00:32:34 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A531803AE
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7ad24b3aaso62309807b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495538; x=1698100338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/wjs53QFL3yvc4NqV7Tx92CS+xTzb2wHc3+DCn+jYLY=;
 b=db/aZdukC7wpL1xTaO6Rns09cr2d4WX2DrqKxnUxp0CTPeHuvkY2LhhP/OLQeECkm9
 UEkSJ61Kpn6ijY2WmyUQmtGLTrrKRJwVkSkkPMYqel2+bUGnRbTgCEhGpXmelzp6UR1L
 OHFg+rfzJM01Dk2VlEsGIUzsVv+R3HfZFUutc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495538; x=1698100338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/wjs53QFL3yvc4NqV7Tx92CS+xTzb2wHc3+DCn+jYLY=;
 b=NotOQf5dM2nWoyy1opcU4hgFyrY4pg5lOcwVrbedTqVeQTsIClkX/Lkp5eOaQ1+Lol
 X/nsTAlhtIjeRqEC2BQzw1Z1L2VTdFKJEE4RqophFwpTw6eR6PM3OmLUVjam0uGk+ZyI
 yEHkktWZ0ZJ3CD7ggHaYU8xEcsj0NJ/LNPzK1+Eq90u/BtUlMmE0SlK7nUhPgU1YQYFY
 6IlGKBIodOC3hHDb6X3oAAp/dFOwSXhgXJzpLQSe8se1CpBY9w5cfQhULtQC5zgk0eZ9
 XgpGKZrbodayShRC8LJINzOOSAi43WCufWFi4qSBAbasckuTdwURfP6f1uAqzkdxHRNC
 qrVg==
X-Gm-Message-State: AOJu0YyqfYWu+P5i3Y6wQ9x1t/cTXloHS1A/mez9OPj9Of1mpo5FepVc
 0lBJ4AaqPg9PFuU7SRi6PXaRXCXQXkSG1CwiNG4SNw==
X-Google-Smtp-Source: AGHT+IE3HwDNGOa9NdZRrR2M5Gv/jHy016WdGoB8Cf2UGfmcvi4xy8YOHTfBKb1RKs/qwunLBAEEVA==
X-Received: by 2002:a0d:eac6:0:b0:59f:61b6:f584 with SMTP id
 t189-20020a0deac6000000b0059f61b6f584mr536293ywe.9.1697495538718; 
 Mon, 16 Oct 2023 15:32:18 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:32:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 24/32] Add a new Kconfig for command-line entry
Date: Mon, 16 Oct 2023 16:28:15 -0600
Message-ID: <20231016222835.596572-25-sjg@chromium.org>
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

At present EXPO requires CMDLINE since it uses cli_readline, which is
enabled by CMDLINE. It should be possible to enter lines of text to an
expo without having CMDLINE available.

Fix this dependency by creating a new Kconfig for cli_readline

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch with a Kconfig for command-line entry

 boot/Kconfig    | 1 +
 cmd/Kconfig     | 1 +
 common/Kconfig  | 7 +++++++
 common/Makefile | 2 +-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 2fbe70245ec9..e71de0647bc5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -649,6 +649,7 @@ config EXPO
 	bool "Support for expos - groups of scenes displaying a UI"
 	depends on VIDEO
 	default y if BOOTMETH_VBE
+	select CLI_READLINE
 	help
 	  An expo is a way of presenting and collecting information from the
 	  user. It consists of a collection of 'scenes' of which only one is
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3b4112d9f319..5cb45f9c025e 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -3,6 +3,7 @@ menu "Command line interface"
 config CMDLINE
 	bool "Support U-Boot commands"
 	default y
+	select CLI_READLINE
 	help
 	  Enable U-Boot's command-line functions. This provides a means
 	  to enter commands into U-Boot for a wide variety of purposes. It
diff --git a/common/Kconfig b/common/Kconfig
index 1ffb055744d9..df5bac646491 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1164,3 +1164,10 @@ endif
 
 config IO_TRACE
 	bool
+
+config CLI_READLINE
+	bool
+	help
+	  Enables support for reading a line of text from the user, This
+	  feature is used by the command-line interpreter and also by expo,
+	  which needs to read text when textline objects are used.
diff --git a/common/Makefile b/common/Makefile
index e22ced0c507f..a9c18c61895c 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_SPLASH_SOURCE) += splash_source.o
 obj-$(CONFIG_MENU) += menu.o
 obj-$(CONFIG_UPDATE_COMMON) += update.o
 obj-$(CONFIG_USB_KEYBOARD) += usb_kbd.o
-obj-$(CONFIG_CMDLINE_EDITING) += cli_cread.o
+obj-$(CONFIG_CLI_READLINE) += cli_cread.o
 obj-$(CONFIG_CMDLINE) += cli_readline.o cli_simple.o
 
 endif # !CONFIG_SPL_BUILD
-- 
2.42.0.655.g421f12c284-goog

