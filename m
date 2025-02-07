Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F303C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 17:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094CD807F1;
	Fri,  7 Feb 2025 18:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qAU5c7cU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C6F80756; Fri,  7 Feb 2025 18:22:21 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BC8800B3
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 18:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 70E7940138
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1738948936;
 bh=urizyDLuiEPOtfGjVdWHeeHMkhDb+h8hYOiPGbcVIBI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=qAU5c7cUIZAj1McoYJsJHRLh1DdQ3N6qmTkrdYEkElEitb2F9VmTn5ZsWWHgRGbJ6
 MGKPH5lnMonQCpPakZGTa7etCdoeMdImOiv+CCmq0D/uVkHHqHD11OwvuNHjxOm0Zw
 bCZNzpxHfI7XxL5/5RVQ6xB4LACiocpWyCvUtT+e7OBqD7NWrBkcUH2abGa4y6CL2c
 q7sbqNXXwYl2R85GEwVY4+AqorkW6d6NcTCv5rjJq35hN3T2FkC6ZsPo9OeJHUZ0W8
 nyewVDqiVwJQLw04JAKjxKKdfsygQL4FAKC/JQWq4FP54ZrDCjETAjTJOKrIgEY5pl
 9iF0w9k5KzkyA==
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5d9fb24f87bso2722945a12.0
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 09:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948928; x=1739553728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=urizyDLuiEPOtfGjVdWHeeHMkhDb+h8hYOiPGbcVIBI=;
 b=pYNvj7R+IhN76b1pI0EZilLmYlxAWJL3T3JyBtK0qQaAkjWs6G8/KN6W5690aMFc+B
 f+B3wMGTpwDY5bAj3c5QOYewK06ecQ6SCYHGNgeVu3VuO3HX1eAEhOkxKAzYr4IauHYB
 d4z+APUwCxjNjFLUmyICxVzQjqETmiGCM2ty8Ut1Sy/8sF50OAMXlmDnQTE0L/Q4voMd
 7YNVVmnIA7XIsXJenBqpeG4258XNzzckaLJuHiKWZveeMQv1Q+/Zj7k29BdOv6aTaNtb
 QhpLS8tjKRHOH8nYkq2TQZq+NefUxMc5FgmBcFh23WFnThtve2QlB2HuzHCRsPFeRx5u
 7RYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdK7poBuwyJ/s1y2zmdZ1tV2IuqxLZARd30jQkn2s17lgQIO7OC30FM3uEa9/OPdFVdbiF05M=@lists.denx.de
X-Gm-Message-State: AOJu0YwbMAj+jJhmeK592ReWs2V3+3AsUZMYCq5dFcIadnMKUrH248QQ
 ZtpcYuXcZXyDs3vdwPmXL7l+8Z6xR6uxd3mqEF62TpyqPEUCWiNFBLuZ2wxnnuzgU9i3FBB60AL
 wFEZipGkcxtauzk2eXxoxMu4NINhPtR6isBBVcJ6+7VFoxwAP2DtnXGWag8lWUJVzITU=
X-Gm-Gg: ASbGnctRYEkWk4amvqPIxXK125NU/4xGzIBGqXBNlFbyUnNlL3bpPqxo/ePkBgxTNwL
 h5A8wDHqxystuJrjWb0jEgrSV5zmsGefslTHaj5qb8uzgCOOju0czKlKjcR61D0dzy0uX/n4I2E
 efzRCXq07GykIfhePWjZnteaqdUi9d+C13e5emogXXQ1qosQAleYHmE2DYUxajXtpUV5t/WA99k
 q332BJfo6D4Dx+DffsM5dzNsu+evSrjrSIv1bXK4fbwrBOGISiefkk8sHVls9/eDq+CpFGOBifw
 5b+kCljJ5YrJbfm1IRTQ2tOx0Gq59abb6ZIutL5/zYJ8WMw3yvCuaL0FqVziru0txS44pd7Lqrh
 wPP6F98I=
X-Received: by 2002:a05:6402:2087:b0:5dc:7fbe:72ff with SMTP id
 4fb4d7f45d1cf-5de44fe9d7cmr4103547a12.2.1738948928370; 
 Fri, 07 Feb 2025 09:22:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzLhKnwCkVc7U8esUlKVHUSpqa6805GVUNV2GojTzjZ6dYsd6DpIvzE1N4GZdnyPACW6bHqA==
X-Received: by 2002:a05:6402:2087:b0:5dc:7fbe:72ff with SMTP id
 4fb4d7f45d1cf-5de44fe9d7cmr4103520a12.2.1738948927974; 
 Fri, 07 Feb 2025 09:22:07 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf6c9f8besm2866914a12.52.2025.02.07.09.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:22:07 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Sandie Cao <sandie.cao@deepcomputing.io>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, E Shattow <e@freeshell.de>,
 "E . Shattow" <lucent@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>,
 H Bell <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 6/6] doc: add DeepComputing FML13V01 documentation
Date: Fri,  7 Feb 2025 18:21:16 +0100
Message-ID: <20250207172116.117749-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
References: <20250207172116.117749-1-heinrich.schuchardt@canonical.com>
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

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/starfive/deepcomputing_fml13v01.rst | 143 ++++++++++++++++++
 doc/board/starfive/index.rst                  |   1 +
 2 files changed, 144 insertions(+)
 create mode 100644 doc/board/starfive/deepcomputing_fml13v01.rst

diff --git a/doc/board/starfive/deepcomputing_fml13v01.rst b/doc/board/starfive/deepcomputing_fml13v01.rst
new file mode 100644
index 00000000000..0d0295555b6
--- /dev/null
+++ b/doc/board/starfive/deepcomputing_fml13v01.rst
@@ -0,0 +1,143 @@
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
+Booting from SD-Card or eMMC
+----------------------------
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
diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 72ab6ddfbf6..ce0ee4a0a2f 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -6,6 +6,7 @@ StarFive
 .. toctree::
    :maxdepth: 1
 
+   deepcomputing_fml13v01
    milk-v_mars
    milk-v_mars_cm
    pine64_star64
-- 
2.47.1

