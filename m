Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B1CC6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 18:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45148813A;
	Thu, 21 Mar 2024 19:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QT3KgCa1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5205E88129; Thu, 21 Mar 2024 19:12:52 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A23888134
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 19:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 210364247C
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711044754;
 bh=osqNa8DJOxCyh8MRiw4r995gi1+I0Cp9hNCxcdQnPRs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=QT3KgCa1VUqOnbX6hOtZWwJF00bgvR+LuhU3rmd83a9FzVUdOpgGCS+i4JlsAOgKV
 aITvzMHCjl7I1GIL0YLwJe4kC/i5Sl8zBnFFGs636Ps0JWlW68ux3U7m07Ia7bU6RM
 URh9VjpJtNkrIWAi7jsnxfXyndk6cSoAA2QvNttd1W5nE3iZ/8Kbu8c6WnvEXg/DAS
 pBxltOJ/UdzjS6vVW7Ubn9eahRYMkGC/YQbaSAxV2arCmJHKk2tzGWN8DPeyKLF/t+
 pgOk5HoE/8bfosMkXiJO21s/AhcXX8PAzuoKgYCFz9FKr3N16p++Udd8ZcLcycRAUM
 oGCFnVJTluRNg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e4478a3afso6863075e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 11:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711044742; x=1711649542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osqNa8DJOxCyh8MRiw4r995gi1+I0Cp9hNCxcdQnPRs=;
 b=Tu4DYKkvnfKJ8DugvcEyVfgYsGhAh/UcK+XuEy6yfG9QU2I0l0LlsCSRSCecejYHQU
 ltxCvFDZHyz/gvxRYmEDrg/fRmBYuxK20LMRdkqIrwihsX/wDWLLI23nUFwI0xOZOBQK
 qJi8p27Aqpiw3cvYhawsRSWFFvtkc+myBpjQmIOk4uMGQcu5UaYlTbJxq9SIDJlVbPKz
 yaGDpfvCQFIw7xL8m0CZikFCiRJgvt2tSapkWZoS9eDJFHa3Kh9eQLW4NYsdyzFnqujU
 WEseYjcGgzLHb1HMtiWxKl8kxTzJW9CykXsvMLbBycW3kpCfzojy2ipXXmlswWsTXfnK
 HQXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUI/7oKTnQq5IqirSJ8SW8s0f0UPnVV11dzEyworehRmmQrAa2MoVbLEFlbj8kKNpuNI6jLGVkhE3CSWLVVX4rvDrnmA==
X-Gm-Message-State: AOJu0YyW91F4W7jUgUnEZQintdZSUJO+HLAx8zhrB7arkIbrJYngpF0h
 /JTBSBgGjS3VZIBYsQp6uHvvhClAvt/ejpL2IdzI8XC39BeyV3DEEC8pyHil1uitBL4wiMpfY1a
 HKvYL+hmew9fIhKAILYwCzP3x1acBUncPUdWhpTNTBeToxRfcHwLb/Tv6AqkuBKpGitw=
X-Received: by 2002:a05:600c:1d17:b0:414:6391:6a4e with SMTP id
 l23-20020a05600c1d1700b0041463916a4emr301515wms.3.1711044741884; 
 Thu, 21 Mar 2024 11:12:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG481pYschbq6g4x+zeBrTSxYrRy7WxitgZUq8Ns3L0cJy352UPW0KLJyhYMsCnzO/7Jl1BeA==
X-Received: by 2002:a05:600c:1d17:b0:414:6391:6a4e with SMTP id
 l23-20020a05600c1d1700b0041463916a4emr301492wms.3.1711044741569; 
 Thu, 21 Mar 2024 11:12:21 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 hg10-20020a05600c538a00b004147743bd0dsm1469420wmb.38.2024.03.21.11.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 11:12:21 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Chanho Park <chanho61.park@samsung.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 6/6] doc: describe Milk-V Mars board
Date: Thu, 21 Mar 2024 19:11:49 +0100
Message-ID: <20240321181149.177356-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
References: <20240321181149.177356-1-heinrich.schuchardt@canonical.com>
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

Add instructions to build U-Boot for the Milk-V Mars board

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	describe how to preset fdtfile
---
 doc/board/starfive/index.rst       |   1 +
 doc/board/starfive/milk-v_mars.rst | 111 +++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 doc/board/starfive/milk-v_mars.rst

diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 0c52dc7b095..2762bf74c11 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -6,4 +6,5 @@ StarFive
 .. toctree::
    :maxdepth: 1
 
+   milk-v_mars.rst
    visionfive2
diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
new file mode 100644
index 00000000000..9cfd5d7bddd
--- /dev/null
+++ b/doc/board/starfive/milk-v_mars.rst
@@ -0,0 +1,111 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Mars
+===========
+
+U-Boot for the Milk-V Mars uses the same U-Boot binaries as the VisionFive 2
+board. In U-Boot SPL the actual board is detected and the device-tree patched
+accordingly.
+
+Building
+~~~~~~~~
+
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: none
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+
+The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
+is responsible for the switch to S-Mode. It is a prerequisite to build U-Boot.
+Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended to use
+a current release.
+
+.. code-block:: console
+
+	git clone https://github.com/riscv/opensbi.git
+	cd opensbi
+	make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
+
+Now build the U-Boot SPL and U-Boot proper.
+
+.. code-block:: console
+
+	cd <U-Boot-dir>
+	make starfive_visionfive2_defconfig
+	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin
+
+This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
+as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
+
+Device-tree selection
+~~~~~~~~~~~~~~~~~~~~~
+
+Depending on the board version U-Boot set variable $fdtfile to either
+starfive/jh7110-starfive-visionfive-2-v1.2a.dtb or
+starfive/jh7110-starfive-visionfive-2-v1.3b.dtb.
+
+To overrule this selection the variable can be set manually and saved in the
+environment
+
+::
+
+    setenv fdtfile my_device-tree.dtb
+    env save
+
+or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
+provide a default value.
+
+Boot source selection
+~~~~~~~~~~~~~~~~~~~~~
+
+The board provides the DIP switches MSEL[1:0] to select the boot device out of
+SPI flash, eMMC, SD-card, UART. To select booting from SD-card set the DIP
+switches MSEL[1:0] to 10.
+
+Preparing the SD-Card
+~~~~~~~~~~~~~~~~~~~~~
+
+The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
+partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
+to choose any partition number.
+
+With the default configuration U-Boot SPL loads the U-Boot FIT image
+(u-boot.itb) from partition 2 (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
+When formatting it is recommended to use GUID
+BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
+
+The FIT image (u-boot.itb) is a combination of OpenSBI's fw_dynamic.bin,
+u-boot-nodtb.bin and the device tree blob.
+
+Format the SD card (make sure the disk has GPT, otherwise use gdisk to switch)
+
+.. code-block:: bash
+
+	sudo sgdisk --clear \
+	  --set-alignment=2 \
+	  --new=1:4096:8191 --change-name=1:spl --typecode=1:2E54B353-1271-4842-806F-E436D6AF6985\
+	  --new=2:8192:16383 --change-name=2:uboot --typecode=2:BC13C2FF-59E6-4262-A352-B275FD6F7172  \
+	  --new=3:16384:1654784 --change-name=3:system --typecode=3:EBD0A0A2-B9E5-4433-87C0-68B6B72699C7 \
+	  /dev/sdb
+
+Copy U-Boot to the SD card
+
+.. code-block:: bash
+
+	sudo dd if=u-boot-spl.bin.normal.out of=/dev/sdb1
+	sudo dd if=u-boot.itb of=/dev/sdb2
+
+	sudo mount /dev/sdb3 /mnt/
+	sudo cp u-boot-spl.bin.normal.out /mnt/
+	sudo cp u-boot.itb /mnt/
+	sudo cp Image.gz /mnt/
+	sudo cp initramfs.cpio.gz /mnt/
+	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
+	sudo umount /mnt
+
+Booting
+~~~~~~~
+
+Once you plugin the sdcard and power up, you should see the U-Boot prompt.
-- 
2.43.0

