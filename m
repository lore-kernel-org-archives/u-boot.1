Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E698E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:28:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99EDE892B8;
	Sat,  7 Dec 2024 18:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="loqT0td9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E81D988DC6; Sat,  7 Dec 2024 18:26:46 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A36689578
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-843df3c4390so97380639f.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592403; x=1734197203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17hmU392SZZe1Ao2XB7mIXte12oEQvBpxBeRyuWC0/I=;
 b=loqT0td9pcySbFjOZ0k3IR7Iyp1L3JRoWHKbzPTdEXMEWqy6MlY4I/U+0HlOlp9LsI
 I1crB343TMzn+ZDpN6+RjR29UWv5VN1t4NSn1uBrGkj+v8GtOB7+utsix4Sqb1v2/JZm
 86BgalQBZSC4x+dRIuf9X9zri0E0zvIRnDRp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592403; x=1734197203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17hmU392SZZe1Ao2XB7mIXte12oEQvBpxBeRyuWC0/I=;
 b=CWQ17u75MUBipCtEKYXdS/aiYxSP/j2Pc+tukiYd6lpc6EdVCuXuHYqooc/bGJsA9J
 4QR/f6VzMeR0qtg+9RpaPvfsQwPuHM5UnqEBbUY1j8KoDbCHP/NLEhkQH7ArVDlwi1vd
 fpeovE9Z9p9xVyTK4qhuMSe5JXNhrj0H8/t2BxMUcJjlCqz9VnZXURJEEruWkqlC0vZH
 z/pSa8mTzH74ImboqLCFZZZgEQztq2IVUbNwfbP4NYBd5E/+MvuUs33TOTIFWsTloWzY
 BjtsGuaDBc/azgWK0gXaMGrrzPItzH/cv8QIzN4duUaRdMgMC9EThHZ5lY5vRB8tlRYT
 EAGw==
X-Gm-Message-State: AOJu0YwDvXroAsi7KgWTMACphuTuQ7IwAh6nEgAaQqbMkyCygyRWXS83
 MJpAy2ecDVybQhF7AhEech2CB6iXEpceupGs48PhezNUqDQeTDSgTBk+uh0hTmVQRwQBcVhWk8U
 =
X-Gm-Gg: ASbGncvs8jRexE8lNzlTZQ4a8RnVVRpeCNVA+op4OMinuwx28Tb8Kt1p9w+kIeY2+Za
 y8UaeH+TalAY0/yWqadU3WQMb6eMlaf+JdxkCP/n1sNKXVWTlAwJ8uGpoz0T2SRu2Hkwo+LG1V0
 WQgPQR8fJFr0L/ZkbZl4i5AD1E07DKcuUNoLXr3U7UKN1wLmnqqIH+CocS4mai4zMpQW3P2/Lxi
 XCqVx8BMnhCLU8TmIdqlNS4tC39csFd8eteEx5ea903auqn75czJvXv7R2ybn14+AKtHyga6Yn3
 mxFBr6PcY3o=
X-Google-Smtp-Source: AGHT+IH+IQRMNxeH8DST90zntGdgEfrE1BVD3Os+fm5AfjNxL5DkLAH1pmxs1EYdOgbjD/JJJx96Hg==
X-Received: by 2002:a05:6602:6b8c:b0:835:4931:b110 with SMTP id
 ca18e2360f4ac-8447e21faa8mr992837939f.5.1733592402789; 
 Sat, 07 Dec 2024 09:26:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 16/19] boot: Allow use of FIT in TPL and VPL
Date: Sat,  7 Dec 2024 10:24:09 -0700
Message-Id: <20241207172412.1124558-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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
index 705947cfa95..e8f87e48ee6 100644
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
@@ -307,6 +341,22 @@ config VPL_FIT
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
@@ -649,6 +699,15 @@ config VPL_BOOTMETH_VBE
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
@@ -727,7 +786,15 @@ config VPL_BOOTMETH_VBE_SIMPLE_FW
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

