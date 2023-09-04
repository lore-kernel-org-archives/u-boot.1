Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E67BC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC69869EB;
	Mon,  4 Sep 2023 16:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X8w6Wbvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A37D3846D2; Mon,  4 Sep 2023 16:41:53 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 858F9869A1
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34e2aad3f8bso4177525ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838509; x=1694443309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRPNdp2hknp5s1cuq6fFa/LrXSVVgukFWwTIW6IbROo=;
 b=X8w6WbvihzkfJhsoyz6DlvXIDj8Lpqm6ltZWTcUydq++d7mJEmzzLPpJdi3AIDsOvh
 9abyBpfckDffRzvIwmbt69poOOnhL+T/peH6LThCc3P+LXrY31/tLO9cbUZfBhT7Gig1
 ChB0sfYlYMOhgpaMea6P/QieHnw7wsDbdK6jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838509; x=1694443309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SRPNdp2hknp5s1cuq6fFa/LrXSVVgukFWwTIW6IbROo=;
 b=XZ2z1z5nGa49UwEzF8yLyhQe7Gp4+hzpk7To/eJUsg3N3cdpUSSj3udts0X92dfvpt
 AaXuxUEIvVhv/dbsisAu6sz4/2dK05TE2VgYj/AD6B+B5bxzi0ZFSXiyIz+N/13exrjD
 iD5w5EBKtPMbPSb9avn0mVLumxqFpNlTsNv7My4iFzB1lvVOZV/mVFQPKAm+eXijwQQz
 aL8CgaeTslaWqSq3TmskUD7LZVTVzK6DQ6e9+KbUvuqlixOpAZOWP3ypFX3WsPPHO6c8
 3a8iRZJzN2bDesxHWFzyGyQckfOSsg9XU4ixRF49DVi69aatfdv5mDuoDYyhaGCjk3SC
 rGOw==
X-Gm-Message-State: AOJu0YxAGAPH5vGGOGtiGpiMxrvtzNQFEv+Pqbf6jhoo05aRSqd+tvut
 aUFYh/GL6L+rx4XnMWDcuyd6P7zAmjHVq4MozUY=
X-Google-Smtp-Source: AGHT+IEFtvJYeI/9TdRGHbegOyCIyAmrLeTCPIEDF3+6jaVp1OxZ3PMNnyery6DhA0XUOZtk0nGpOA==
X-Received: by 2002:a05:6e02:f42:b0:348:8396:9f88 with SMTP id
 y2-20020a056e020f4200b0034883969f88mr9600181ilj.9.1693838509188; 
 Mon, 04 Sep 2023 07:41:49 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 10/20] boot: Move some other fdt-fixup options to the same
 menu
Date: Mon,  4 Sep 2023 08:41:13 -0600
Message-ID: <20230904144131.2699824-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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
index 025fa01d782c..70cbcc38fdd4 100644
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
2.42.0.283.g2d96d420d3-goog

