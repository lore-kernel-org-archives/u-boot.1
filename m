Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7227C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2620E8657F;
	Thu, 31 Aug 2023 05:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ik76LP/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F6298658D; Thu, 31 Aug 2023 05:53:42 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9275686585
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-792707f78b5so17694139f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454018; x=1694058818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qXWWsbvECqr/HyFu+PaOo+hHnkm6k3lExxyIcb/VOGE=;
 b=ik76LP/xejRwfZUg/8+D/h9nJtX3i8ae/fCUYGVLjpDKzjvo1OpmgQM39iAJSWhaaB
 RQgL3mvIap3w6I+t1MwZNl4kQTuRZPmICJNLM2Lldvc0s/OFk0vUxbeXMfNSKZCtDi+r
 qMzowrrPmY5VDMP/DhsEhopS/aE4YnVKOZUj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454018; x=1694058818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qXWWsbvECqr/HyFu+PaOo+hHnkm6k3lExxyIcb/VOGE=;
 b=fXYOsqZ1Vp5qlI6Fy4OHQLNnctXHDEBCgxFJ+axWKWdO6Bkmifkp8ytspB+gjfHhM6
 LFXJi374v4nh4gourvL4UDFxjZ6vI8bayu+3mQIugo7pqNYMqzfvG4flHnpY9tGxbO+z
 6lsWVy/66kABhtFvVyjD3vsL8F7kPgKFrux1K1/41zQVxerduUVrcYt4Ij9THANIbfZD
 RdnBwcNkq491RssXUzRhYiw4XML47E9QZE6Ex2oXXK/psb9XRigDeV1XjW9E1wAW6FaK
 PvcDqtLqXPoVGaaNydxE0be825+2mkwRUsk+R+/bzv7Zd1FZscCfO+cIc/A6h/n02XOW
 BrCA==
X-Gm-Message-State: AOJu0YzQVBZcWxUMTuvkRz5k6lRBeK1n9VvmoOZdOssQunDwkeHfByQr
 joxgTMnX/Bd541KTyJhav2tJ2G43+gt8IAu9TxI=
X-Google-Smtp-Source: AGHT+IFh5apMJqGSd6bBYcl7Pedx2EMPdGa3FRfw/ItV+Ovz7Jv6ebBCVMBv8gtk21hsBD/MpmmNPA==
X-Received: by 2002:a5e:8a48:0:b0:790:c259:4ee5 with SMTP id
 o8-20020a5e8a48000000b00790c2594ee5mr4796136iom.8.1693454018229; 
 Wed, 30 Aug 2023 20:53:38 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/19] boot: Move some other fdt-fixup options to the same
 menu
Date: Wed, 30 Aug 2023 21:53:04 -0600
Message-ID: <20230831035319.2316665-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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
2.42.0.rc2.253.gd59a3bf2b4-goog

