Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8065AC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4BB082045;
	Thu, 24 Apr 2025 14:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hG+zgAFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E6581F0D; Thu, 24 Apr 2025 14:14:07 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D45E820B0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3BFE3403AD
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745496836;
 bh=Nf/NEeGJTSZfsl3CH88uvChWiSAjDGu/dMAOwgE2r4w=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=hG+zgAFjA8xmvKkNR/PIh1NpCyeUHV3DmL6vZbEqVvi+zmSSqWVwkxM7okelwpCHB
 0PVze+MDpcndrbf2BdzBzujEICqhQ9wyF5F3kg9AFYeXs4DjDGpGR5Z2l/jj0GM2/A
 f6KB81RRgkglF1RrpOUm/vM0snDmbVDEhqzAkp2NGyFwj2fL6gFGTaBBibFFrYtRsu
 cAoYBk00G4pZYPdzcp7hFLVmWSSgZ3A+YQYuqbukWEzBH07Lcoez9+si2YWV+O+AF9
 QChj5WWhZRAR6KbWT7pMVfDU3OV+vhi01pdyaRRlh0FIUAom95rs0fRQrA4yRGm9ac
 DSSX85TKrjzoQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43d08915f61so5033825e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496808; x=1746101608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nf/NEeGJTSZfsl3CH88uvChWiSAjDGu/dMAOwgE2r4w=;
 b=YcK3IwPoPJkDFrsRDEJ33pPV39oy+0w5DB8KCDGiGqDO23ga7BLW9B8kxRzreEyMya
 SH5E6WZmWNvkj744nW7PkG//4Inj0mLuP6VWe8lrj0TjnFYCHYXLsO0NX+fsDGaycmc/
 YnUOVFzDKlFs/NO+XrAhgNZsMyMmD8h05D3oABlZmHDzEVqj+Hq2zdi/dT0EI4smkZh9
 ObczW1sqyU65TPsNlHsRdp8wOf2rkcWQ4bL+MfMyLbS6eFwsQRLofMEDu722cpOzzAXe
 T1ulP7gs0a8qYo7IygRx9geruPqWxmqiFp7thAL6HNEd/bW+nZj6iZc73ydyQkM9sbNq
 Tc3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMVcKLUN5NdBdnAZwmfLNbyhXQnNjSC0tKPRnMywMvIr/qS1f1n6mI0oTLikLrR/3UVa+7Z+M=@lists.denx.de
X-Gm-Message-State: AOJu0YzsqlBl3CJ0yauV7y4cuB9WQBMbbB57mj9oCxeCnae7YSEKy3gD
 zpK0sYyfK8WwQVaXt66348U9/dHtEJnVl6N9nF8BmurIMC6pRS9oCgHc0Yhw50mu1SxCvlD0n4p
 uq1wZLOeKO0e1MC9NRfBJyaP6AeUCxTClJEqKFla+epdHNpW8DmkFC44CvVUbkOYSjZw=
X-Gm-Gg: ASbGncuOdichZiRX99QLd7ZCbS31Cz5xEMe0A0+uAfNawFtM/hnpOUd5ETGnz/cem1k
 CmH/voRjV4qmepggc8P25HFQo5WGVAnKDxjC8oqJOonb3oMN72JFGI1s2Mp5aXRiPkgHJ/DLUcB
 2Kxwqs7z5g42ZAPnfGEJv4eSNrMW2wq0asvM7CvvG4Zlf5APdOHEZixzWZncu3y+q4GiEuxAuyh
 OVB7nloDUYg36Vj2YZ8rrJMAE/8Py4dSpdpVZQNg9wCUwucPnzaVZ4AQUIpx8PSbsW0wiye6ddM
 dwTWKeetJgCgGtBLedySoCVLtqYmMpGqdnil8QoYQprhOsrOJkWJrVvD0Dj7DM4vcNm8r9X6WMU
 tXagYr3RaZMmrMw==
X-Received: by 2002:a5d:588f:0:b0:397:8f09:600 with SMTP id
 ffacd0b85a97d-3a06cf563cbmr2009778f8f.13.1745496808370; 
 Thu, 24 Apr 2025 05:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWVFHOTG/3ogTYS9iChNwocCOz9WqN5OIcDUdsIS8ire7qOxuPbW61sDO9JofRIWXJsUwwLg==
X-Received: by 2002:a5d:588f:0:b0:397:8f09:600 with SMTP id
 ffacd0b85a97d-3a06cf563cbmr2009745f8f.13.1745496807828; 
 Thu, 24 Apr 2025 05:13:27 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5326e1sm1900906f8f.70.2025.04.24.05.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 05:13:27 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Matthias Brugger <mbrugger@suse.com>, "E . Shattow" <lucent@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 5/8] doc: add DeepComputing FML13V01 documentation
Date: Thu, 24 Apr 2025 14:13:12 +0200
Message-ID: <20250424121315.144549-6-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
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

Describe building U-Boot for the board and booting.

Carve out common information for JH7110 boards into an include.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	Correct the description of booting JH7110 boards from eMMC
v3:
	rebased
v2:
	carve out common information for JH7110 boards into an include
---
 doc/board/starfive/deepcomputing_fml13v01.rst | 80 +++++++++++++++++
 doc/board/starfive/index.rst                  |  1 +
 doc/board/starfive/jh7110_common.rst          | 89 +++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst
 create mode 100644 doc/board/starfive/jh7110_common.rst

diff --git a/doc/board/starfive/deepcomputing_fml13v01.rst b/doc/board/starfive/deepcomputing_fml13v01.rst
new file mode 100644
index 00000000000..5d9612483b4
--- /dev/null
+++ b/doc/board/starfive/deepcomputing_fml13v01.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+DeepComputing Framework Motherboard (FLM13V01)
+==============================================
+
+The DeepComputing Framework motherboard (FLM13V01) can be combined with a
+13 inch Framework laptop chassis to provide a complete laptop.
+
+U-Boot for the board uses the same binaries as the VisionFive 2 board.
+Currently only serial console output is supported by mainline U-Boot.
+
+Building
+--------
+
+Setup the cross compilation environment variable:
+
+.. code-block:: bash
+
+   export CROSS_COMPILE=riscv64-linux-gnu-
+
+The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
+is responsible for the switch to S-Mode. It is a prerequisite for building
+U-Boot. Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended
+to use a current release.
+
+.. code-block:: bash
+
+    git clone https://github.com/riscv/opensbi.git
+    cd opensbi
+    make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
+    export OPENSBI="$(pwd)/build/platform/generic/firmware/fw_dynamic.bin"
+
+Now build U-Boot SPL and main U-Boot.
+
+.. code-block:: bash
+
+    cd <U-Boot-dir>
+    make starfive_visionfive2_defconfig
+    make
+
+This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
+as the FIT image (u-boot.itb) with OpenSBI, U-Boot, and device-trees.
+
+Device-tree selection
+---------------------
+
+The product ID stored in the board EEPROM is used by U-Boot SPL to select the
+right configuration and device-tree from the u-boot.itb FIT image.
+
+Furthermore if variable $fdtfile has not been saved in the environment it is
+set based on the product ID to *starfive/jh7110-deepcomputing-fml13v01.dtb*.
+
+To overrule this default the variable can be set manually and saved in the
+environment
+
+.. code-block:: console
+
+    setenv fdtfile my_device-tree.dtb
+    env save
+
+Power switch
+------------
+
+A tiny power switch is located in right upper corner of the board.
+
+Open case detection
+-------------------
+
+The board has an open case detection switch. Red lights will flash and the
+board will not boot if the switch is not held down.
+
+UART
+----
+
+UART 0 is exposed via the side channel contacts SBU1 and SBU2 of the lower,
+right USB C connector. A USB C cable and a breakout board are needed for
+physical access. It depends on the cable orientation on which of SBU1 and SBU2
+you will find RX and TX. The signal voltage is 3.3 V. The baud rate is 115200.
+
+.. include:: jh7110_common.rst
diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 2cba1b6dc56..66abc6f9d98 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -6,6 +6,7 @@ StarFive
 .. toctree::
    :maxdepth: 1
 
+   deepcomputing_fml13v01
    milk-v_mars
    pine64_star64
    visionfive2
diff --git a/doc/board/starfive/jh7110_common.rst b/doc/board/starfive/jh7110_common.rst
new file mode 100644
index 00000000000..fb8d87a1551
--- /dev/null
+++ b/doc/board/starfive/jh7110_common.rst
@@ -0,0 +1,89 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Boot source selection
+---------------------
+
+The board provides DIP switches to select the device for loading the boot
+firmware.
+
+=========== === ===
+Boot source SW1 SW2
+=========== === ===
+UART        OFF OFF
+SD-card     ON  OFF
+eMMC        OFF ON
+SPI flash   ON  ON
+=========== === ===
+
+Flashing a new U-Boot version
+-----------------------------
+
+U-Boot SPL is provided as file spl/u-boot-spl.bin.normal.out. Main U-Boot is
+in file u-boot.itb.
+
+Assuming your new U-Boot version is on partition 1 of an SD-card you could
+install it to the SPI flash with:
+
+.. code-block:: console
+
+    sf probe
+    load mmc 1:1 $kernel_addr_r u-boot-spl.bin.normal.out
+    sf update $kernel_addr_r 0 $filesize
+    load mmc 1:1 $kernel_addr_r u-boot.itb
+    sf update $kernel_addr_r 0x100000 $filesize
+
+For loading the files from a TFTP server refer to the dhcp and tftpboot
+commands.
+
+After updating U-Boot you may want to erase a saved environment and reboot.
+
+.. code-block:: console
+
+    env erase
+    reset
+
+Booting from SD-Card
+--------------------
+
+The device boot ROM loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
+partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
+to choose any partition number.
+
+With the default configuration U-Boot SPL loads the U-Boot FIT image
+(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
+When formatting it is recommended to use GUID
+BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
+
+Booting from eMMC
+-----------------
+
+The device boot ROM tries to load U-Boot SPL (u-boot-spl.bin.normal.out) from
+sector 0 of the eMMC's main hardware partition. But this conflicts with GPT
+partitioning. Fortunately eMMC can alternatively load U-Boot SPL from a backup
+position.
+
+For U-Boot SPL (u-boot-spl.bin.normal.out) starting at sector 2048 (position
+0x100000) write the following bytes to the eMMC device after GPT partitioning:
+
+======= ========================
+Address Bytes
+======= ========================
+0x0000  40 02 00 00  00 00 10 00
+0x0290  40 02 00 00  00 00 10 00
+======= ========================
+
+With the default configuration U-Boot SPL loads the U-Boot FIT image
+(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
+When formatting it is recommended to use GUID
+BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
+
+Booting from UART
+-----------------
+
+The boot ROM supports the X-modem protocol to upload
+spl/u-boot-spl.bin.normal.out. U-Boot SPL support loading the FIT image
+u-boot.itb via the Y-modem protocol.
+
+Due to restrictions of the boot ROM not all X-modem implementations are
+compatible. The package tio (https://github.com/tio/tio) has been found to be
+usable.
-- 
2.48.1

