Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B28EC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:12:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E8287683;
	Tue, 21 Nov 2023 18:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E2asuA7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4734E87572; Tue, 21 Nov 2023 18:09:59 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A5DA8765D
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c503dbe50dso74720971fa.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586585; x=1701191385; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Of2YYKYdJ68xTbV8pTDVXj3IfQKQn9Zl5WBNrO92z5A=;
 b=E2asuA7x+O3RNcRqhowd+6yuqEysiZwduiArPMmQ8/mfC8TZrXgw3Fk1eJkTRy9Xde
 p1gZav85G+HpuA9Wcb68isQAMLr2SB72UZMJlmdPa/L+aOQWPVaYGoz+ogH8ElDxboyu
 lShbEIVz54IrtWdQuiGOKCJeNdaNWTbCZafiPkrquewkOVepriaRwW8u/QOi04dKIPrv
 T8HVjbZS9k8nAfB+2nwBJYyBofWERMknp21yKRj1wr7AEEuEvHfWYkZlVBzP0A0kewak
 NTXDRxkTBEnMU1YW59Ar0Ms1AHXxND6W6JP9vXgv86c0I34XidC/65fOTOaDAfnofEtm
 gIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586585; x=1701191385;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Of2YYKYdJ68xTbV8pTDVXj3IfQKQn9Zl5WBNrO92z5A=;
 b=tvjwrEmBCjwFb5PKHf2wko/hTirGAr0H40+g4RONBWraYqqVGRvcYiFmCWfRJ1zTrR
 /9SmcKQinhhbEstmNhb3v3mqqioBkGBNAE2hWmZrWfTnpi/AoPlIsny/wyhQC+KPkQM4
 fjlIHOzpl7scNT6VtgaJ/fjeoR8bZgLMBAzXESYM6DwBlt4g0uPt4fhPX+ryIP/G12eF
 aCtRTeEkLcAlzEBWGvQedRu8YgkI0Kp2W260MCFb1NqjnDKB6kgHYQfQ8FrTwiP6cozT
 NY8QEs1Tyeoot5D8kyhRLNdQ5vGdlAQU90DZCh21sIV70/m4StBv0gv383Ypn49xjL4V
 dcQQ==
X-Gm-Message-State: AOJu0Yzz3zgPGqfX2XKxdjM+6wYIRy+/s6GZqieX5RESCbACrHaZ4mGw
 j9lrTXGDn7JgUWxGbRK9ZshLbsPt4pLJ3hzyl/sQzw==
X-Google-Smtp-Source: AGHT+IEbMP75I0oLINxnSeSuNgJBXy5rnOSgEdNWC6WuQeilrDvB/kpywVe7rQMfOzB4St9d2du/YQ==
X-Received: by 2002:a2e:9155:0:b0:2c7:4220:56fc with SMTP id
 q21-20020a2e9155000000b002c7422056fcmr7904528ljg.11.1700586584764; 
 Tue, 21 Nov 2023 09:09:44 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:44 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:39 +0000
Subject: [PATCH 16/21] doc: board/qualcomm: document generic targets
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-16-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=13982;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=G3AoQokfEZ9xVWenNiZdYYdLdi+vanbBcBS8NReEwF4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ27GjVIlr+/sVNLZxZ26MnFtq2+EbkT9rmVRhn5Gh
 nyvQm53lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIl4r2b4X3jhav8jfZ+vtiF3
 Ypy7l1hn9EwKsww/I1hamq3p3hzdyMgwQXSZmNuChY/XbmB41uu/apvHMdZLZl/y4jcreKabTHZ
 6BQA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Replace the board specific docs with a generic board.rst file which
documents the build/boot process for the sdm845 and qcs404 boards now
that the only differences are the DTB in use.

At the same time, create a debugging page to document some useful
snippets and tips for working with Qualcomm platforms.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS                      |   1 +
 doc/board/qualcomm/board.rst     | 119 ++++++++++++++++++++++++++++
 doc/board/qualcomm/debugging.rst |  61 +++++++++++++++
 doc/board/qualcomm/index.rst     |   4 +-
 doc/board/qualcomm/qcs404.rst    |  79 -------------------
 doc/board/qualcomm/sdm845.rst    | 162 ---------------------------------------
 6 files changed, 183 insertions(+), 243 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40b03d2647d0..5a4bfbf550ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -573,6 +573,7 @@ R:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	arch/arm/mach-snapdragon/
 F:	configs/qcom_defconfig
+F:	doc/board/qualcomm
 F:	drivers/button/button-qcom-pmic.c
 F:	drivers/clk/qcom/
 F:	drivers/gpio/msm_gpio.c
diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
new file mode 100644
index 000000000000..3d08b88c39be
--- /dev/null
+++ b/doc/board/qualcomm/board.rst
@@ -0,0 +1,119 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Dzmitry Sankouski <dsankouski@gmail.com>
+
+Qualcomm generic boards
+=======================
+
+About this
+----------
+This document describes how to build and run U-Boot for Qualcomm generic
+boards. Right now the generic target supports the Snapdragon 845 SoC, however
+it's expected to support more SoCs going forward.
+
+SDM845 - hi-end qualcomm chip, introduced in late 2017.
+Mostly used in flagship phones and tablets of 2018.
+
+The current boot flow support loading u-boot as an Android boot image via
+Qualcomm's UEFI-based ABL (Android) Bootloader. The DTB used by U-Boot will
+be appended to the U-Boot image the same way as when booting Linux. U-Boot
+will then retrieve the DTB during init. This way the memory layout and KASLR
+offset will be populated by ABL.
+
+Installation
+------------
+Build
+^^^^^
+Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
+
+	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
+	$ make <your board name here, see Boards section>_defconfig
+	$ make
+
+This will build ``u-boot-nodtb.bin`` in the configured output directory.
+
+Generate FIT image
+^^^^^^^^^^^^^^^^^^
+See doc/uImage.FIT for more details
+
+Pack android boot image
+^^^^^^^^^^^^^^^^^^^^^^^
+We'll assemble android boot image with ``u-boot-nodtb.bin`` instead of linux kernel,
+and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
+with appended dtb, so let's mimic linux to satisfy stock bootloader.
+
+Boards
+------
+
+starqlte
+^^^^^^^^
+
+The starqltechn is a production board for Samsung S9 (SM-G9600) phone,
+based on the Qualcomm SDM845 SoC.
+
+This device is supported by the common qcom_defconfig.
+
+The DTB is called "starqltechn.dtb"
+
+More information can be found on the `Samsung S9 page`_.
+
+dragonboard845c
+^^^^^^^^^^^^^^^
+
+The dragonboard845c is a Qualcomm Robotics RB3 Development Platform, based on
+the Qualcomm SDM845 SoC.
+
+This device is supported by the common qcom_defconfig
+
+The DTB is called "dragonboard845c.dtb"
+
+More information can be found on the `DragonBoard 845c page`_.
+
+qcs404-evb
+^^^^^^^^^^
+
+The QCS404 EvB is a Qualcomm Development Platform, based on the Qualcomm QCS404 SoC.
+
+This device is supported by the common qcom_defconfig
+
+The DTB is called "qcs404-evb.dtb"
+
+Building steps
+--------------
+
+Steps:
+
+- Build u-boot::
+
+	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
+	$ make qcom_defconfig
+	$ make
+
+- gzip u-boot::
+
+	gzip u-boot-nodtb.bin
+
+- Append dtb to gzipped u-boot::
+
+	 cat u-boot-nodtb.bin.gz arch/arm/dts/your-board.dtb > u-boot-nodtb.bin.gz-dtb
+
+- A ``qcom.its`` file can be found in ``board/qualcomm/generic/``
+  directory. It expects a folder as ``qcom_imgs/`` in the main directory
+  containing pre-built kernel, dts and ramdisk images. See ``qcom.its``
+  for full path to images::
+
+	mkimage -f qcom.its qcom.itb
+
+- Now we've got everything to build android boot image::
+
+	mkbootimg --kernel u-boot-nodtb.bin.gz-dtb --ramdisk db845c.itb \
+	--output boot.img --pagesize 4096 --base 0x80000000
+
+- Flash boot.img using fastboot and erase dtbo to avoid conflicts with our DTB:
+
+  .. code-block:: bash
+
+      fastboot flash boot boot.img
+      fastboot erase dtbo
+
+.. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
+.. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
new file mode 100644
index 000000000000..1c35d1909d12
--- /dev/null
+++ b/doc/board/qualcomm/debugging.rst
@@ -0,0 +1,61 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
+
+Qualcomm debugging
+==================
+
+About this
+----------
+
+This page describes how to enable early UART and other debugging techniques
+for Qualcomm boards.
+
+Enable debug UART
+-----------------
+
+Newer boards (SDM845 and newer, those with GENI SE UART)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Open ``configs/qcom_defconfig`` and add the following snippet to the bottom:
+
+	CONFIG_BAUDRATE=115200
+
+	# Uncomment to enable UART pre-relocation
+	CONFIG_DEBUG_UART=y
+	CONFIG_DEBUG_UART_ANNOUNCE=y
+	# This is the address of the debug-uart peripheral
+	# The value here is for SDM845, other platforms will vary
+	CONFIG_DEBUG_UART_BASE=0xa84000
+	# Boards older than ~2018 pre-date the GENI driver and unfortunately
+	# aren't supported here
+	CONFIG_DEBUG_UART_MSM_GENI=y
+	# For sdm845 this is the UART clock rate
+	CONFIG_DEBUG_UART_CLOCK=7372800
+	# Most newer boards have an oversampling value of 16 instead
+	# of 32, they need the clock rate to be doubled
+	#CONFIG_DEBUG_UART_CLOCK=14745600
+
+Then build as normal (don't forget to ``make qcom_defconfig``` again).
+
+Older boards (db410c and db820c)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Open ``configs/dragonboard<BOARD>_defconfig``
+
+	CONFIG_BAUDRATE=115200
+	CONFIG_DEBUG_UART=y
+	CONFIG_DEBUG_UART_ANNOUNCE=y
+	# db410c - 0x78b0000
+	# db820c - 0x75b0000
+	CONFIG_DEBUG_UART_BASE=0x75b0000
+	CONFIG_DEBUG_UART_MSM=y
+	CONFIG_DEBUG_UART_CLOCK=7372800
+	#CONFIG_DEBUG_UART_SKIP_INIT=y
+
+	CONFIG_LOG=y
+	CONFIG_HEXDUMP=y
+	CONFIG_CMD_LOG=y
+	CONFIG_LOG_MAX_LEVEL=9
+	CONFIG_LOG_DEFAULT_LEVEL=9
+	CONFIG_LOGLEVEL=9
+
diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 0f9c4299569a..4955274a39bc 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -7,5 +7,5 @@ Qualcomm
    :maxdepth: 2
 
    dragonboard410c
-   sdm845
-   qcs404
+   board
+   debugging
diff --git a/doc/board/qualcomm/qcs404.rst b/doc/board/qualcomm/qcs404.rst
deleted file mode 100644
index 0cb71d97c987..000000000000
--- a/doc/board/qualcomm/qcs404.rst
+++ /dev/null
@@ -1,79 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-.. sectionauthor:: Sumit Garg <sumit.garg@linaro.org>
-
-QCS404 EVB
-==========
-
-About this
-----------
-This document describes the information about Qualcomm QCS404 evaluation board
-and it's usage steps.
-
-The current boot flow support loading u-boot as an Android boot image via
-Qualcomm's UEFI-based ABL (Android) Bootloader.
-
-Installation
-------------
-Build
-^^^^^
-Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
-
-	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
-	$ make qcs404evb_defconfig
-	$ make
-
-This will build ``u-boot.bin`` in the configured output directory.
-
-Generate FIT image
-^^^^^^^^^^^^^^^^^^
-A ``qcs404.its`` file can be found in ``board/qualcomm/qcs404-evb/`` directory.
-It expects a folder as ``qcs404_imgs/`` in the main directory containing
-pre-built kernel, dts and ramdisk images. See ``qcs404.its`` for full path to
-images.
-
-- Build FIT image::
-
-	mkimage -f qcs404-evb.its qcs404-evb.itb
-
-Pack android boot image
-^^^^^^^^^^^^^^^^^^^^^^^
-We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
-and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
-with appended dtb, so let's mimic linux to satisfy stock bootloader:
-
-- create dump dtb::
-
-	workdir=/tmp/prepare_payload
-	mkdir -p "$workdir"
-	cd "$workdir"
-	mock_dtb="$workdir"/payload_mock.dtb
-
-	dtc -I dts -O dtb -o "$mock_dtb" << EOF
-	/dts-v1/;
-	/ {
-		model = "Qualcomm Technologies, Inc. QCS404 EVB 4000";
-		compatible = "qcom,qcs404-evb-4000", "qcom,qcs404-evb", "qcom,qcs404";
-
-		#address-cells = <2>;
-		#size-cells = <2>;
-
-		memory@80000000 {
-			device_type = "memory";
-			/* We expect the bootloader to fill in the size */
-			reg = <0 0x80000000 0 0>;
-		};
-
-		chosen { };
-	};
-	EOF
-
-- gzip u-boot ``gzip u-boot.bin``
-- append dtb to gzipped u-boot: ``cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb``
-
-Now we've got everything to build android boot image:::
-
-	mkbootimg --kernel u-boot.bin.gz-dtb \
-	--ramdisk qcs404-evb.itb --pagesize 4096 \
-	--base 0x80000000 --output boot.img
-
-Flash image on qcs404-evb using fastboot method.
diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/sdm845.rst
deleted file mode 100644
index d3f218e835e0..000000000000
--- a/doc/board/qualcomm/sdm845.rst
+++ /dev/null
@@ -1,162 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0+
-.. sectionauthor:: Dzmitry Sankouski <dsankouski@gmail.com>
-
-Snapdragon 845
-================
-
-About this
-----------
-This document describes the information about Qualcomm Snapdragon 845
-supported boards and it's usage steps.
-
-SDM845 - hi-end qualcomm chip, introduced in late 2017.
-Mostly used in flagship phones and tablets of 2018.
-
-The current boot flow support loading u-boot as an Android boot image via
-Qualcomm's UEFI-based ABL (Android) Bootloader.
-
-Installation
-------------
-Build
-^^^^^
-Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
-
-	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
-	$ make <your board name here, see Boards section>_defconfig
-	$ make
-
-This will build ``u-boot.bin`` in the configured output directory.
-
-Generate FIT image
-^^^^^^^^^^^^^^^^^^
-See doc/uImage.FIT for more details
-
-Pack android boot image
-^^^^^^^^^^^^^^^^^^^^^^^
-We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
-and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
-with appended dtb, so let's mimic linux to satisfy stock bootloader.
-
-Boards
-------
-
-starqlte
-^^^^^^^^
-
-The starqltechn is a production board for Samsung S9 (SM-G9600) phone,
-based on the Qualcomm SDM845 SoC.
-
-Steps:
-
-- Build u-boot::
-
-	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
-	$ make starqltechn_defconfig
-	$ make
-
-- Create dump dtb::
-
-	workdir=/tmp/prepare_payload
-	mkdir -p "$workdir"
-	cd "$workdir"
-	mock_dtb="$workdir"/payload_mock.dtb
-
-	dtc -I dts -O dtb -o "$mock_dtb" << EOF
-	/dts-v1/;
-	/ {
-		memory {
-			/* We expect the bootloader to fill in the size */
-			reg = <0 0 0 0>;
-		};
-
-		chosen { };
-	};
-	EOF
-
-- gzip u-boot::
-
-	gzip u-boot.bin
-
-- Append dtb to gzipped u-boot::
-
-	cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
-
-- Now we've got everything to build android boot image::
-
-	mkbootimg --base 0x0 --kernel_offset 0x00008000 \
-	--ramdisk_offset 0x02000000 --tags_offset 0x01e00000 \
-	--pagesize 4096 --second_offset 0x00f00000 \
-	--ramdisk "$fit_image" \
-	--kernel u-boot.bin.gz-dtb \
-	-o boot.img
-
-- Flash image with your phone's flashing method.
-
-More information can be found on the `Samsung S9 page`_.
-
-dragonboard845c
-^^^^^^^^^^^^^^^
-
-The dragonboard845c is a Qualcomm Robotics RB3 Development Platform, based on
-the Qualcomm SDM845 SoC.
-
-Steps:
-
-- Build u-boot::
-
-	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
-	$ make dragonboard845c_defconfig
-	$ make
-
-- Create dummy dtb::
-
-	workdir=/tmp/prepare_payload
-	mkdir -p "$workdir"
-	mock_dtb="$workdir"/payload_mock.dtb
-
-	dtc -I dts -O dtb -o "$mock_dtb" << EOF
-	/dts-v1/;
-	/ {
-		#address-cells = <2>;
-		#size-cells = <2>;
-
-		memory@80000000 {
-			device_type = "memory";
-			/* We expect the bootloader to fill in the size */
-			reg = <0 0x80000000 0 0>;
-		};
-
-		chosen { };
-	};
-	EOF
-
-- gzip u-boot::
-
-	gzip u-boot.bin
-
-- Append dtb to gzipped u-boot::
-
-	 cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
-
-- A ``db845c.its`` file can be found in ``board/qualcomm/dragonboard845c/``
-  directory. It expects a folder as ``db845c_imgs/`` in the main directory
-  containing pre-built kernel, dts and ramdisk images. See ``db845c.its``
-  for full path to images::
-
-	mkimage -f db845c.its db845c.itb
-
-- Now we've got everything to build android boot image::
-
-	mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.itb \
-	--output boot.img --pagesize 4096 --base 0x80000000
-
-- Flash boot.img using db845c fastboot method:
-
-  .. code-block:: bash
-
-      sudo fastboot flash boot boot.img
-
-More information can be found on the `DragonBoard 845c page`_.
-
-.. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
-.. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/

-- 
2.42.1

