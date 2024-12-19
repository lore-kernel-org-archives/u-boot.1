Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0037E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A5880312;
	Thu, 19 Dec 2024 19:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lTrfdkhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 426BD80429; Thu, 19 Dec 2024 19:29:53 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC0D2803D0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a815ed5acfso3670125ab.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632989; x=1735237789; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Pqj5j4n91CGE5fq4cYZtnOBIv1KwlDEUk9XmJMQkH8=;
 b=lTrfdkhyMoHNJtO3eAENxvfqwhgDNt6oF4W+0eZK2+ZeSwjuC56wd7KP/WrlRcGODr
 VAo0J9fNKBip1PpN/aCejRX7lsdv4sAfxn3YNK6B9CHqwSJMDGzB/FP8EX5/GqukeOY6
 4e/xcXHx+Nv4pv0cpCnrbihvzuFGRY15EZH7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632989; x=1735237789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Pqj5j4n91CGE5fq4cYZtnOBIv1KwlDEUk9XmJMQkH8=;
 b=sr1H9LwoCzEjTzOe3xAoO2boTa6lrdvAjBaRNsOUuh7etZFrTqDkgGQjtiCB1p98gs
 d3CGYVmw/n9nTcq3yw//vFY/b6XokuzrFMZdPdCTlHdGbJH3xLgAkbjQ1SOW613DpNRX
 Hew8viEr5+gQS1sYC8Q1VnMMWJe/swaLu/sV9AufliicfF86f5Pui9AQ8R134sGUWmb5
 SGHtkjAX8BZOarC+UILLx7BPjtQrN/W1NTtpWwVcUVy0w7CKcj4hI6GxsCbXfahUuWON
 95ybtWLVyqgX5RzQqEDzRm7MULIoocQhnsjx4OT5NcGRJ3+KtAC1dNJjWDkadiqAHnfM
 enug==
X-Gm-Message-State: AOJu0YyJ+iFHBwuzyiJrE249GhInoZ4MR6XfrHfC/Ey9QgprFzTxjcjs
 JMvj+zIun+tuGEW0FKu0SOZBjI1yE5ULux7nmfxvlrIAhAk5LZDFsQpgsiTJscOxVcV/l7tFK0U
 =
X-Gm-Gg: ASbGncuv5LimXgpeMxVm1JAqdHWIKMr5zZaV79DHZdq5QStxSAVp6QJaQb0kUOly4Bc
 rSgtNMJtZqgM1es51iOLD+3ElPBNSZag1QAZjou4ky19RmcR+bDUYKO6n86KupDD4BuLBPBcN+K
 UoXugcjBOOyAj8vVQM5IRfzJMXbnuuF3p5OWXVTg0RnvA0ZzkXZ5bpUSWqFJEWTc7Td4Snhivxo
 XPQJcu8q5lOHAfMoP7dtnKtXnlhJH4ZNvVrcfkEgTXN83JwFiWy/QyNXViIJPo1Ek2oeHwPdrV0
 NyOJPf0ykI9N5uEpTA==
X-Google-Smtp-Source: AGHT+IHTzPSYhBJjfBoQWUVG+h6WXp/07laABJBxtPp6MdSRwa4iWTmf7jtzEo2GU6tyfWnq2dnosg==
X-Received: by 2002:a05:6e02:1546:b0:3a7:708b:da28 with SMTP id
 e9e14a558f8ab-3c2d5919bcfmr863085ab.21.1734632989112; 
 Thu, 19 Dec 2024 10:29:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 16/19] boot: Allow use of FIT in TPL and VPL
Date: Thu, 19 Dec 2024 11:29:04 -0700
Message-Id: <20241219182907.2609704-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

With VBE we want to use FIT in all phases of the boot. Add Kconfig
options to support this.

Disable the options for sandbox_vpl for now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig                  | 69 ++++++++++++++++++++++++++++++++++-
 configs/sandbox_vpl_defconfig |  2 +
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 99dcedcc840..cdf787eb5c2 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -163,6 +163,18 @@ config SPL_FIT
 	select SPL_HASH
 	select SPL_OF_LIBFDT
 
+config VPL_FIT
+	bool "Support Flattened Image Tree within VPL"
+	depends on VPL
+	select VPL_HASH
+	select VPL_OF_LIBFDT
+
+config TPL_FIT
+	bool "Support Flattened Image Tree within TPL"
+	depends on TPL
+	select TPL_HASH
+	select TPL_OF_LIBFDT
+
 config SPL_FIT_PRINT
 	bool "Support FIT printing within SPL"
 	depends on SPL_FIT
@@ -268,6 +280,28 @@ config SPL_LOAD_FIT_FULL
 	  particular it can handle selecting from multiple device tree
 	  and passing the correct one to U-Boot.
 
+config TPL_LOAD_FIT
+	bool "Enable TPL loading U-Boot as a FIT (basic fitImage features)"
+	depends on TPL
+	select TPL_FIT
+	help
+	  Normally with the SPL framework a legacy image is generated as part
+	  of the build. This contains U-Boot along with information as to
+	  where it should be loaded. This option instead enables generation
+	  of a FIT (Flat Image Tree) which provides more flexibility. In
+	  particular it can handle selecting from multiple device tree
+	  and passing the correct one to U-Boot.
+
+	  This path has the following limitations:
+
+	  1. "loadables" images, other than FDTs, which do not have a "load"
+	     property will not be loaded. This limitation also applies to FPGA
+	     images with the correct "compatible" string.
+	  2. For FPGA images, the supported "compatible" list is in the
+	     doc/uImage.FIT/source_file_format.txt.
+	  3. FDTs are only loaded for images with an "os" property of "u-boot".
+	     "linux" images are also supported with Falcon boot mode.
+
 config SPL_FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by the SPL"
 	depends on SPL_LOAD_FIT
@@ -292,6 +326,22 @@ config VPL_FIT
 	select VPL_HASH
 	select VPL_OF_LIBFDT
 
+config VPL_LOAD_FIT
+	bool "Enable VPL loading U-Boot as a FIT (basic fitImage features)"
+	select VPL_FIT
+	default y
+
+config VPL_LOAD_FIT_FULL
+	bool "Enable SPL loading U-Boot as a FIT (full fitImage features)"
+	select VPL_FIT
+	help
+	  Normally with the SPL framework a legacy image is generated as part
+	  of the build. This contains U-Boot along with information as to
+	  where it should be loaded. This option instead enables generation
+	  of a FIT (Flat Image Tree) which provides more flexibility. In
+	  particular it can handle selecting from multiple device tree
+	  and passing the correct one to U-Boot.
+
 config VPL_FIT_PRINT
 	bool "Support FIT printing within VPL"
 	depends on VPL_FIT
@@ -620,6 +670,15 @@ config VPL_BOOTMETH_VBE
 	  supports selection of various firmware components, selection of an OS to
 	  boot as well as updating these using fwupd.
 
+config TPL_BOOTMETH_VBE
+	bool "Bootdev support for Verified Boot for Embedded (TPL)"
+	depends on TPL
+	default y
+	help
+	  Enables support for VBE boot. This is a standard boot method which
+	  supports selection of various firmware components, seleciton of an OS to
+	  boot as well as updating these using fwupd.
+
 if BOOTMETH_VBE
 
 config BOOTMETH_VBE_REQUEST
@@ -698,7 +757,15 @@ config VPL_BOOTMETH_VBE_SIMPLE_FW
 	  This option enabled for VPL, since it is the phase where the SPL
 	  decision is made.
 
-endif # BOOTMETH_VBE
+config TPL_BOOTMETH_VBE_SIMPLE_FW
+	bool "Bootdev support for VBE 'simple' method firmware phase (TPL)"
+	depends on VPL
+	default y
+	help
+	  Enables support for the firmware parts of VBE 'simple' boot, in TPL.
+	  TPL loads a FIT containing the VPL binary and a suitable devicetree.
+
+endif # BOOTMETH_VBE_SIMPLE
 
 config EXPO
 	bool "Support for expos - groups of scenes displaying a UI"
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 84df2b85260..46329395ba5 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -27,6 +27,8 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_FIT_BEST_MATCH=y
 CONFIG_SPL_LOAD_FIT=y
+# CONFIG_TPL_BOOTMETH_VBE is not set
+# CONFIG_TPL_BOOTMETH_VBE_SIMPLE_FW is not set
 CONFIG_UPL=y
 CONFIG_UPL_IN=y
 CONFIG_BOOTSTAGE=y
-- 
2.34.1

