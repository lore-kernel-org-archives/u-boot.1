Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E24C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C33E81E72;
	Thu, 24 Apr 2025 14:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uTHx84eO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A51A881F0B; Thu, 24 Apr 2025 14:14:04 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F26B581E14
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 77E0840327
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745496824;
 bh=R2fOQmaQEq8mvON778B7IxOhJNrBZeMKwun4/fDKIDI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=uTHx84eOcWiH3sgXbyQmdIWgC2VOjEyS9v0rRft9WCcs0VgdOXWMDRBQ17I23P1H2
 GabXQYUHLEY4WW4DVyVbGP3OtepcWQwO0Xh/6k248opnsNC7qKRhIImHi32SqT9b7G
 IOLxUvNH2jAj3exRVD2AYJSRBUAWjCf3bw2H/74/kLG+8ofvBWVQF+bwT3hMv954D2
 DwbktWZHHkA5Bf1i8yeVlyOp4KE++ISbHLOPRrY5K8I3flisxyEw4aSKGDkujNT4dK
 jtP974taltCMSfbaQVvsn7fSgkNXINzDkNFI1yAAypZV4mHZk3/rIfkGmUteQBtZyr
 +bQJdDsZoV+2A==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39979ad285bso428772f8f.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496809; x=1746101609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2fOQmaQEq8mvON778B7IxOhJNrBZeMKwun4/fDKIDI=;
 b=hQ6CP2x4sd878NXNVRLPILUki7JlEEA9IyK8ook18b8ytdQLZIfWaLOhP5sk2KuEbZ
 b4HLU/ZqPltiYemSKP4UAaMVjaD6WPH00yCS7FR5jZWQjP7BkuyNtjm0YJOB6KeuYBnv
 tkzDBd84fGm2KWvliFgQmv3a43+7FmmVXqqPZFmebrnG+k3N/H+UHnMA3iOy8KAvyj3O
 djTlqPi8mXocSXluGMk6MMTHyzG7mSVP7N6/c25O8YTovTX5RXCZQN0UzNz5CkAM/2kE
 /wW+O0OK3OuBkGnWSeWf5nDDrKoT/u6rvXEzyZjHc5TTlSJlj3+bZsxBjfrLyH5nJ0Yp
 1gNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU77biaB28vh+re27spoogu0ntdTU7ip+0B0GQeOQT/L6263UkEQe9dCXm0MmpzikljuWfY9k=@lists.denx.de
X-Gm-Message-State: AOJu0YyxltzmoxKg0EBZvNokQlavs0XQOuK4bmcCRx1Z8EErdxzZZGLl
 7UASU+lufpKsdVRaM2nfbOXXz5sDHNYVv4Y8ytIKJ/zHMdr+gKxeejhfV4in5v9PjSByrWBMHfx
 0eEYrQonYEkoka1U+ej2ZVRM7eAsi4xIvqCUui9n+WD4vwU5Woc8lKJ6B46lze4v3Mtg=
X-Gm-Gg: ASbGnctxeVKx1UkYrxfxWq+QvOA7eqFphnP1jH3f+NksujSOGJyu3dgUA2/H6vKZeCZ
 dCexCcrWZV82qmaE26vLRmFw8xM7DS6GbEDRbmA/rNJLGcTk7wv4X/eGS6eopQ8nufvtdiBQvr6
 okZdz7N+hFT0RuiNS3dk6v9GsHz332xXj6otk/UlFEn2bb1sUnGEGH8aeFQKT0R+lRhgBew1mJd
 nEDhZIYuDkomb9tD0ynzpTf/6PlDz68dxoo2NAmdR/cd9yw1sUiDso16zWz+NpD46LaG+fHaeyZ
 Gdt9FMgilSfRmUCeIEVnR/++AngPieel6Edl3bmliftHy17fvJZYaGurFsatjz1fLPajLT9XGMF
 QQTmRpPqy0HyVpA==
X-Received: by 2002:a05:6000:430c:b0:39c:1f10:d294 with SMTP id
 ffacd0b85a97d-3a06cf5f192mr1969636f8f.26.1745496809578; 
 Thu, 24 Apr 2025 05:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEm+oFOCoDQifPbU7d9c93STpjYPC0cx6RjQZ/i7W0Auc/RVQw1mtY/hRbhE1uoY2Mxw61ZHg==
X-Received: by 2002:a05:6000:430c:b0:39c:1f10:d294 with SMTP id
 ffacd0b85a97d-3a06cf5f192mr1969606f8f.26.1745496809126; 
 Thu, 24 Apr 2025 05:13:29 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5326e1sm1900906f8f.70.2025.04.24.05.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 05:13:28 -0700 (PDT)
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
Subject: [PATCH v4 6/8] doc: starfive: use consistent formatting
Date: Thu, 24 Apr 2025 14:13:13 +0200
Message-ID: <20250424121315.144549-7-heinrich.schuchardt@canonical.com>
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

Always use ---- for the H2 level.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	no change
v3:
	rebased upong Milk-V Mars CM removal patch
v2:
	new patch
---
 doc/board/starfive/milk-v_mars.rst   | 10 +++++-----
 doc/board/starfive/pine64_star64.rst | 12 ++++++------
 doc/board/starfive/visionfive2.rst   | 10 +++++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
index 554932ecfd4..aba9c9c53d4 100644
--- a/doc/board/starfive/milk-v_mars.rst
+++ b/doc/board/starfive/milk-v_mars.rst
@@ -8,7 +8,7 @@ board. In U-Boot SPL the actual board is detected and the device-tree patched
 accordingly.
 
 Building
-~~~~~~~~
+--------
 
 1. Add the RISC-V toolchain to your PATH.
 2. Setup ARCH & cross compilation environment variable:
@@ -40,7 +40,7 @@ This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
 Device-tree selection
-~~~~~~~~~~~~~~~~~~~~~
+---------------------
 
 Depending on the board version U-Boot set variable $fdtfile to either
 starfive/jh7110-starfive-visionfive-2-v1.2a.dtb or
@@ -58,14 +58,14 @@ or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
 provide a default value.
 
 Boot source selection
-~~~~~~~~~~~~~~~~~~~~~
+---------------------
 
 The board provides the DIP switches MSEL[1:0] to select the boot device out of
 SPI flash, eMMC, SD-card, UART. To select booting from SD-card set the DIP
 switches MSEL[1:0] to 10.
 
 Preparing the SD-Card
-~~~~~~~~~~~~~~~~~~~~~
+---------------------
 
 The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
 partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
@@ -106,6 +106,6 @@ Copy U-Boot to the SD card
 	sudo umount /mnt
 
 Booting
-~~~~~~~
+-------
 
 Once you plugin the sdcard and power up, you should see the U-Boot prompt.
diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pine64_star64.rst
index 52e9a907917..1df4b68e4a0 100644
--- a/doc/board/starfive/pine64_star64.rst
+++ b/doc/board/starfive/pine64_star64.rst
@@ -8,7 +8,7 @@ In U-Boot SPL the actual board is detected and the device-tree patched
 accordingly.
 
 Building
-~~~~~~~~
+--------
 
 1. Add the RISC-V toolchain to your PATH.
 2. Setup ARCH & cross compilation environment variable:
@@ -40,7 +40,7 @@ This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
 Device-tree selection
-~~~~~~~~~~~~~~~~~~~~~
+---------------------
 
 U-Boot will set variable $fdtfile to starfive/jh7110-pine64-star64.dtb.
 
@@ -56,7 +56,7 @@ or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
 provide a default value.
 
 Boot source selection
-~~~~~~~~~~~~~~~~~~~~~
+---------------------
 
 Boot mode is selected by an MSEL-DIP marked S1804 and GPIO_0 position adjacent
 to the 40pin GPIO header. ON/ONKE and number markings of the MSEL-DIP are
@@ -69,7 +69,7 @@ accurate selection.
 + UART: 11
 
 Preparing the SD-Card
-~~~~~~~~~~~~~~~~~~~~~
+---------------------
 
 The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
 partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
@@ -110,12 +110,12 @@ Copy U-Boot to the SD card
 	sudo umount /mnt
 
 Booting
-~~~~~~~
+-------
 
 Once you plugin the sdcard and power up, you should see the U-Boot prompt.
 
 Serial Number and MAC address issues
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+------------------------------------
 
 U-Boot requires valid EEPROM data to determine which board-specific fix-up to
 apply at runtime. This affects the size of memory initialized, network mac
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index 2c68df3ce4d..44e7fcb3a48 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -36,7 +36,7 @@ Currently, the u-boot.itb is used as a dynamic of the OpenSBI FW_DYNAMIC
 firmware with the latest.
 
 Building
-~~~~~~~~
+--------
 
 1. Add the RISC-V toolchain to your PATH.
 2. Setup ARCH & cross compilation environment variable:
@@ -72,7 +72,7 @@ This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
 as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
 
 Device-tree selection
-~~~~~~~~~~~~~~~~~~~~~
+---------------------
 
 Depending on the board version U-Boot set variable $fdtfile to either
 starfive/jh7110-starfive-visionfive-2-v1.2a.dtb or
@@ -90,7 +90,7 @@ or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to provide
 a default value.
 
 Flashing
-~~~~~~~~
+--------
 
 The device firmware loads U-Boot SPL (u-boot-spl.bin.normal.out) from the
 partition with type GUID 2E54B353-1271-4842-806F-E436D6AF6985. You are free
@@ -133,7 +133,7 @@ Program the SD card
 	sudo umount /mnt
 
 Booting
-~~~~~~~
+-------
 
 The board provides the DIP switches MSEL[1:0] to select the boot device.
 To select booting from SD-card set the DIP switches MSEL[1:0] to 10.
@@ -141,7 +141,7 @@ To select booting from SD-card set the DIP switches MSEL[1:0] to 10.
 Once you plugin the sdcard and power up, you should see the U-Boot prompt.
 
 Sample boot log from StarFive VisionFive2 board
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+-----------------------------------------------
 
 .. code-block:: none
 
-- 
2.48.1

