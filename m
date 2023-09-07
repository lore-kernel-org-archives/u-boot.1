Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5DFEC873A
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B45186B0C;
	Thu,  7 Sep 2023 17:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GxSn7gBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D16DA86AFA; Thu,  7 Sep 2023 17:59:53 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E570786A34
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34e1ddc38c6so4624345ab.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102387; x=1694707187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDGnaIWbNhNl6kWHptIT+eNHXJ+a52oZEkH/UOuEe44=;
 b=GxSn7gBsNITltCblcj4nJvjNaaDf2TkBLq+ZdMTjTq9a+hDRJzPAVlgE0HMvIN8SEu
 EjW2KV1yN2ehmLFMprWDPGJjCOijb5sPtEnv/S/vcJb0UHenyW1JHWw4jnGgrQOtId7u
 VN32IAkTtO83EfE6VmEBXzR+QE0551W+u3UVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102387; x=1694707187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDGnaIWbNhNl6kWHptIT+eNHXJ+a52oZEkH/UOuEe44=;
 b=kiWBXbPgXNwa+bpBXzS5/TXSvzSR+wbZxe/UjaxM/w8vTGduF1t3Vcr7MnS4VAHvCH
 QDj2SYWszvzAjd0LwwwYPALCdaBs4Xsf3p6682mc4IueoV+aUXoK78Ls8mCYXUy9Pzch
 sqDPm4Wzhp+g7aITh0d/ebbTdhWT3H6G5/BznmRAPQMt3HayAyTuf2Lz89c1N+rQZdxG
 h2bz4Zz+r4kpnU+Sk6cc5mIzyBMQL+rUQRZz4ybqJjimzZcdJGY9tG7B+iunReOeLkXE
 UMiBFNRp/nvdy5svh/uZEWkoXyx0xg9zq8rLwSQTmG6QwXoO+gTMK4JyCQR9VxkLv9eG
 sTtw==
X-Gm-Message-State: AOJu0YyMb4QTgfrahE0pwd+Ckw/vK71ntxFsaj8wOsbYWu+49KZLSje6
 54XcPx9ZEEBCh792skgN8+BiSSRHi6Zbvui5j5A=
X-Google-Smtp-Source: AGHT+IF+zP0RhCPy7p3Cblx/5wOmoLM4JT2c51xtzAyv6D0ubiBC0n03GlByaREfuBqcQqBnKTE+eg==
X-Received: by 2002:a05:6e02:c72:b0:34c:b981:52d4 with SMTP id
 f18-20020a056e020c7200b0034cb98152d4mr90774ilj.31.1694102387598; 
 Thu, 07 Sep 2023 08:59:47 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 10/22] boot: Move some other fdt-fixup options to the same
 menu
Date: Thu,  7 Sep 2023 09:59:15 -0600
Message-ID: <20230907155933.48511-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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
index 39c51e9e2fe8..f8b8d6089511 100644
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

