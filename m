Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C23C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 10:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C31E987AB7;
	Wed, 10 Jan 2024 11:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D54zfNVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FD5E87AFF; Wed, 10 Jan 2024 11:37:11 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA4C387B03
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 11:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d480c6342dso31646975ad.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 02:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704883025; x=1705487825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIS9yp2pj60f8mlkj+VU7D14bpVqhCzj3gRXqDuXK9s=;
 b=D54zfNVVrhxybk8GknGlW/pJMAvXfw/OfZxkABxrrXxA8Exz64+eQZEFo8KAoFyMYu
 DO9d7YJO8verNyNRt0656jaXmci8A1UdLILwirKKLBZZkX7UnwVWXT2K+efSU905HS+7
 pnfUCpPIi/iwjEs7mUNpNOMqyduAALiO8JEQWSDjG+w1fuCZV5e0wbpr7ZIsy4e2nCvw
 w4D+2JxW4wGh44ZFsHij1bPgRWXaJFxn3QNvibwu/RUsvuhy1tdthvEdlQcaxxIPDALy
 u06dwQuoj9jge1czvMxqRxiffGD4LtKMAa90LY0DqJdSdE+ea1k2KcerwlSPFguKCxvk
 oBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704883025; x=1705487825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIS9yp2pj60f8mlkj+VU7D14bpVqhCzj3gRXqDuXK9s=;
 b=Xts5MVH9UjAFefkxnMYabmJu3YAWS3t4JC5fy8XnOXw0QS4PRk6u1eIyEhCqttYVbw
 nYIb2P4X+Rn+uIQK/TEj9aufMUiftHMxz1EdOrNze00FyIfRKAnGacVGN2H9HDf3gO6W
 qeiWLmURn9rwPi848bd3K3QFCpfwniUfDtiGqokV8HI4xGJxAmhqdWGY8sR0+LlmbyTc
 l02XJHLl17ttcaQaJB4B9Cc+v/QAbcJHUyIXNV0XszYhkRxCWVEjliTJBAmYN6Z+ofuD
 kIHRhXZwRfM5PYavWSU9IEtOyrTGc9wML0iG0NsSKe1m92+HxURDwY1c4omznsbenFlT
 5NQQ==
X-Gm-Message-State: AOJu0YzshR3akV6l+Ddyi1jTDC/vGbrV9Hlk45uQt0Bn7pzltM6Ohy1Y
 wwzY1JazPibATJ4sVyiVWFd+WdbTVXy+mTFWpnDhiQAj/Ns=
X-Google-Smtp-Source: AGHT+IFqHQEqj+SBvOZqozq76B6pjGjn99A62JPbbjSeoon1QvBVLxmgowUraMmkirr8aS4Dknmjqw==
X-Received: by 2002:a17:903:247:b0:1d5:4c37:714f with SMTP id
 j7-20020a170903024700b001d54c37714fmr1019149plh.22.1704883024631; 
 Wed, 10 Jan 2024 02:37:04 -0800 (PST)
Received: from sumit-X1.. ([223.178.208.66]) by smtp.gmail.com with ESMTPSA id
 i7-20020a17090332c700b001d38a7e6a30sm3332604plr.70.2024.01.10.02.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 02:37:04 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 07/11] doc: devicetree: Align documentation to use Kconfig
 options
Date: Wed, 10 Jan 2024 16:05:43 +0530
Message-Id: <20240110103547.719757-8-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110103547.719757-1-sumit.garg@linaro.org>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
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

Since U-Boot switched away from manual CONFIG_* defines to Kconfig
options, align devicetree documentation accordingly.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---

Changes in v4:
- Separate patch to align documentation to use Kconfig symbols instead.

 doc/develop/devicetree/control.rst | 50 ++++++++++++++----------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
index 11c92d440f4..75d5e02aaec 100644
--- a/doc/develop/devicetree/control.rst
+++ b/doc/develop/devicetree/control.rst
@@ -29,7 +29,7 @@ a number of similar boards with different peripherals, you can describe
 the features of each board in the devicetree file, and have a single
 generic source base.
 
-To enable this feature, add CONFIG_OF_CONTROL to your board config file.
+To enable this feature, select `OF_CONTROL` via Kconfig.
 
 
 What is a Flattened Devicetree?
@@ -81,12 +81,8 @@ Failing that, you could write one from scratch yourself!
 Configuration
 -------------
 
-Use::
-
-   #define CONFIG_DEFAULT_DEVICE_TREE	"<name>"
-
-to set the filename of the devicetree source. Then put your devicetree
-file into::
+Set up "<name>" when prompted for `DEFAULT_DEVICE_TREE` by Kconfig. Then put
+your devicetree file into::
 
    arch/<arch>/dts/<name>.dts
 
@@ -94,24 +90,24 @@ This should include your CPU or SOC's devicetree file, placed in
 `arch/<arch>/dts`, and then make any adjustments required using a u-boot-dtsi
 file for your board.
 
-If CONFIG_OF_EMBED is defined, then it will be picked up and built into
+If `OF_EMBED` is selected by Kconfig, then it will be picked up and built into
 the U-Boot image (including u-boot.bin). This is suitable for debugging
 and development only and is not recommended for production devices.
 
-If CONFIG_OF_SEPARATE is defined, then it will be built and placed in
+If `OF_SEPARATE` is selected by Kconfig, then it will be built and placed in
 a u-boot.dtb file alongside u-boot-nodtb.bin with the combined result placed
-in u-boot.bin so you can still just flash u-boot.bin onto your board. If you are
-using CONFIG_SPL_FRAMEWORK, then u-boot.img will be built to include the device
-tree binary.
+in u-boot.bin so you can still just flash u-boot.bin onto your board. If Kconfig
+option `SPL_FRAMEWORK` is enabled, then u-boot.img will be built to include the
+device tree binary.
 
-If CONFIG_OF_BOARD is defined, a board-specific routine will provide the
+If `OF_BOARD` is selected by Kconfig, a board-specific routine will provide the
 devicetree at runtime, for example if an earlier bootloader stage creates
 it and passes it to U-Boot.
 
-If CONFIG_BLOBLIST is defined, the devicetree may come from a bloblist passed
-from a previous stage, if present.
+If `BLOBLIST` is selected by Kconfig, the devicetree may come from a bloblist
+passed from a previous stage, if present.
 
-If CONFIG_SANDBOX is defined, then it will be read from a file on
+If `SANDBOX` is selected by Kconfig, then it will be read from a file on
 startup. Use the -d flag to U-Boot to specify the file to read, -D for the
 default and -T for the test devicetree, used to run sandbox unit tests.
 
@@ -145,7 +141,7 @@ Build:
 After the board configuration is done, fdt supported u-boot can be built in two
 ways:
 
-#  build the default dts which is defined from CONFIG_DEFAULT_DEVICE_TREE::
+#  build the default dts which is selected by DEFAULT_DEVICE_TREE Kconfig::
 
     $ make
 
@@ -198,8 +194,8 @@ As mentioned above, the U-Boot build system automatically includes a
 `*-u-boot.dtsi` file, if found, containing U-Boot specific
 quirks. However, some data, such as the mentioned public keys, are not
 appropriate for upstream U-Boot but are better kept and maintained
-outside the U-Boot repository. You can use CONFIG_DEVICE_TREE_INCLUDES
-to specify a list of .dtsi files that will also be included when
+outside the U-Boot repository. You can use `DEVICE_TREE_INCLUDES` Kconfig
+option to specify a list of .dtsi files that will also be included when
 building .dtb files.
 
 
@@ -213,14 +209,14 @@ The full devicetree is available to U-Boot proper, but normally only a subset
 'SPL Support' in doc/driver-model/design.rst for more details.
 
 
-Using several DTBs in the SPL (CONFIG_SPL_MULTI_DTB)
-----------------------------------------------------
+Using several DTBs in the SPL (SPL_MULTI_DTB_FIT Kconfig option)
+----------------------------------------------------------------
 In some rare cases it is desirable to let SPL be able to select one DTB among
 many. This usually not very useful as the DTB for the SPL is small and usually
 fits several platforms. However the DTB sometimes include information that do
 work on several platforms (like IO tuning parameters).
-In this case it is possible to use CONFIG_SPL_MULTI_DTB. This option appends to
-the SPL a FIT image containing several DTBs listed in SPL_OF_LIST.
+In this case it is possible to use SPL_MULTI_DTB_FIT Kconfig option. This option
+appends to the SPL a FIT image containing several DTBs listed in SPL_OF_LIST.
 board_fit_config_name_match() is called to select the right DTB.
 
 If board_fit_config_name_match() relies on DM (DM driver to access an EEPROM
@@ -247,16 +243,16 @@ architectures.
 
 It is important to understand that the fdt only selects options
 available in the platform / drivers. It cannot add new drivers (yet). So
-you must still have the CONFIG option to enable the driver. For example,
-you need to define CONFIG_SYS_NS16550 to bring in the NS16550 driver,
+you must still have the Kconfig option to enable the driver. For example,
+you need to enable SYS_NS16550 Kconfig option to bring in the NS16550 driver,
 but can use the fdt to specific the UART clock, peripheral address, etc.
-In very broad terms, the CONFIG options in general control *what* driver
+In very broad terms, the Kconfig options in general control *what* driver
 files are pulled in, and the fdt controls *how* those files work.
 
 History
 -------
 
-U-Boot configuration was previous done using CONFIG options in the board
+U-Boot configuration was previous done using Kconfig options in the board
 config file. This eventually got out of hand with nearly 10,000 options.
 
 U-Boot adopted devicetrees around the same time as Linux and early boards
-- 
2.34.1

