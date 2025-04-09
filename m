Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6BFC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10B58353F;
	Wed,  9 Apr 2025 09:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sSBcmg+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B34983564; Wed,  9 Apr 2025 09:19:04 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A2783513
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-104-207.46.114.pool.telefonica.de
 [46.114.104.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4AF7C414A5; 
 Wed,  9 Apr 2025 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744183131;
 bh=idJIrKhA4/UNS7zCHw9ZvXkMiWnoQOaKmy730dE3clE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sSBcmg+vRH09k/QFTrmBr+FgRBus/QLG9ZiAVMbQIyCZq5hWkJBiiQWsyTpsP3Ag9
 wb3JMvIXFPx0uz/JEudD862VK6pkb7o6M0OTGN+mKjExLLy/L1oKL5EM/6FX1gTCuw
 DURnLJC9jvmB+M+wYeqRgbYdZOA5jxjgYNZg6fiffm9Zl+lLh3b42h4o9gNlGRvPYp
 +fHUiBWaK0+F/VvSz4whAyy5Y69mq5A1UyRqgxV22IqBN8qUrzJapk1Q+IlfMOV7E5
 wcMrRrzZBtjKVCEqDoh6uDjFb7N9j/SUwTdwmZ9nBqLHVWr3W4AKMoBOlU7W8t/efH
 fOXLYJU3fVKNQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Hal Feng <hal.feng@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 H Bell <dmoo_dv@protonmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 6/8] doc: starfive: use consistent formatting
Date: Wed,  9 Apr 2025 09:18:33 +0200
Message-ID: <20250409071836.26629-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
References: <20250409071836.26629-1-heinrich.schuchardt@canonical.com>
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

