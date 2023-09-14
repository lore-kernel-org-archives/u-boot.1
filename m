Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C8DEEAA59
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:58:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F63D870BA;
	Thu, 14 Sep 2023 18:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bsIb9VHL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DB38709D; Thu, 14 Sep 2023 18:56:43 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBEA18709F
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79275d86bc3so43461839f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710599; x=1695315399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afqUwr7xEJNBjw4RoAD9CHkkXQYgQecR2EmnZ+Scz8c=;
 b=bsIb9VHLFFdoZPTUIIn9vyXNxTbE7deCSpJ/AIct/fKhuZZ4pqHlqK3H3P/E712k65
 s95lgI7M6hVcdPLmsgMNZi9ph57wE+7kG+kWoA739MPAr6VWVrxEJAVnFlcEWU3Z0meK
 CdgnADq/H4FDhCLqszBa6LeorB8ZqOQChYNvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710599; x=1695315399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=afqUwr7xEJNBjw4RoAD9CHkkXQYgQecR2EmnZ+Scz8c=;
 b=CgqZvuBdItN9azHWZ0oZRzUpsQG20IVzzZlP1aZiorUIT0HZHlItPUy3mYI8V9PFeJ
 xRw0ApsVZRS+b1TZ1XWmgF8JM5Pus/1mf4XPpiFSDQjuZl4We0INtHx5uvIM/308R9BH
 C31OZFwD+p3IFiaM+nNc76eBjuGD838ddpHMIFDbHjH5/ySjmzMHEMdASb8pZfMK466q
 mJzlceAbgy4rY1bkXG4/CYAJopW1MWAylEZQqo/FVfcz4399vkPpa3LWEOaxSm0w0Nf8
 zs17i0z79L+e2+fJ5qDqfQ3yClmIoJqWK6zqotBj4oJ/P8p6SVjaDH14nPovvMdXwC0I
 tDIg==
X-Gm-Message-State: AOJu0YwpTVB5rfLel9aO/CIqwefNTxsdM+TLK2+5q1QuUZLII8TgZ/GB
 DtV3OE4eBdodKUTEnFhvNySMLYhuKjBVU1MbOdE=
X-Google-Smtp-Source: AGHT+IHbolEilUq2H2Lg2P1rrzUB/Do4I7o53v249ubewS2gPs8APtGZDVpCuQhQTLBjwXEr3BY79g==
X-Received: by 2002:a05:6e02:1d8d:b0:34f:7ff6:acfe with SMTP id
 h13-20020a056e021d8d00b0034f7ff6acfemr7598779ila.9.1694710599630; 
 Thu, 14 Sep 2023 09:56:39 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 09/21] boot: Move some other fdt-fixup options to the same
 menu
Date: Thu, 14 Sep 2023 10:55:47 -0600
Message-ID: <20230914165615.1058529-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

Move more options relating to fixing up a device tree into the new
devicetree-fixup menu.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 55 +++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 39c51e9e2fe..f8b8d608951 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -696,35 +696,6 @@ config SUPPORT_RAW_INITRD
 	  address of the initrd must be augmented by it's size, in the following
 	  format: "<initrd address>:<initrd size>".
 
-config OF_BOARD_SETUP
-	bool "Set up board-specific details in device tree before boot"
-	depends on OF_LIBFDT
-	help
-	  This causes U-Boot to call ft_board_setup() before booting into
-	  the Operating System. This function can set up various
-	  board-specific information in the device tree for use by the OS.
-	  The device tree is then passed to the OS.
-
-config OF_SYSTEM_SETUP
-	bool "Set up system-specific details in device tree before boot"
-	depends on OF_LIBFDT
-	help
-	  This causes U-Boot to call ft_system_setup() before booting into
-	  the Operating System. This function can set up various
-	  system-specific information in the device tree for use by the OS.
-	  The device tree is then passed to the OS.
-
-config OF_STDOUT_VIA_ALIAS
-	bool "Update the device-tree stdout alias from U-Boot"
-	depends on OF_LIBFDT
-	help
-	  This uses U-Boot's serial alias from the aliases node to update
-	  the device tree passed to the OS. The "linux,stdout-path" property
-	  in the chosen node is set to point to the correct serial node.
-	  This option currently references CONFIG_CONS_INDEX, which is
-	  incorrect when used with device tree as this option does not
-	  exist / should not be used.
-
 config HAVE_TEXT_BASE
 	bool
 	depends on !NIOS2 && !XTENSA
@@ -1542,6 +1513,32 @@ if OF_LIBFDT
 
 menu "Devicetree fixup"
 
+config OF_BOARD_SETUP
+	bool "Set up board-specific details in device tree before boot"
+	help
+	  This causes U-Boot to call ft_board_setup() before booting into
+	  the Operating System. This function can set up various
+	  board-specific information in the device tree for use by the OS.
+	  The device tree is then passed to the OS.
+
+config OF_SYSTEM_SETUP
+	bool "Set up system-specific details in device tree before boot"
+	help
+	  This causes U-Boot to call ft_system_setup() before booting into
+	  the Operating System. This function can set up various
+	  system-specific information in the device tree for use by the OS.
+	  The device tree is then passed to the OS.
+
+config OF_STDOUT_VIA_ALIAS
+	bool "Update the device-tree stdout alias from U-Boot"
+	help
+	  This uses U-Boot's serial alias from the aliases node to update
+	  the device tree passed to the OS. The "linux,stdout-path" property
+	  in the chosen node is set to point to the correct serial node.
+	  This option currently references CONFIG_CONS_INDEX, which is
+	  incorrect when used with device tree as this option does not
+	  exist / should not be used.
+
 config FDT_SIMPLEFB
 	bool "FDT tools for simplefb support"
 	help
-- 
2.42.0.459.ge4e396fd5e-goog

