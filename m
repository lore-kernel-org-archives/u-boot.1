Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA885C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 08:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F263987963;
	Wed,  3 Jan 2024 09:00:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PfvfGTAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60598797F; Wed,  3 Jan 2024 09:00:16 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B91A487963
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 09:00:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d5336986cso99850585e9.1
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 00:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704268812; x=1704873612;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cu0/fk4OYVU0LqadHB25KoQ+ND1UPy6z/fIPi+5A6Cc=;
 b=PfvfGTAJ5DpFnoIpTub1rFmUgekN2NHDT4qTk1FN9qubftKtxL/oYx67AZ8sizwqZ3
 0grX3gr5Duy6lmY1QKXXS6E+yU89FtyvVEtt/HQMXnnpCu/jyWRlSalSewJe0pBSvn1D
 WKtfT52xbhZuYyvWBA8xZIe+MAqoBR1lQQBN/YoqCZ/v6AReMEkQ6u/8Fi5bQFSsC1fY
 /MULtgT4IJcqpjHPdBx0++zBd0Jbp1gi/3+AxIXZCpvhKhKs55uYrvRJe3aGa2yLYPAc
 Y5SRAELoBaNdNPkWKwgUTB8ViVQwtXV4H+dNsalPkmpkGuP300+7ehKcYtMphKsV80ef
 2Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704268812; x=1704873612;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cu0/fk4OYVU0LqadHB25KoQ+ND1UPy6z/fIPi+5A6Cc=;
 b=pkrDoN3upi+tuORn0CwvTs+liymEcu3h9G7+vU80N5GrENWka3MiqAvhle+codvm2G
 a//9KTI06F5tG6pYeH9GZMyY1+ycWgbhSSZHPge9S4xuhUMCLvxaTvO4vBm213nN5xfx
 YyVOXPcsQ8pUsslrG3RcIpc8VpNnd8tgfYdHpuRn50RwR5INuSj+sYHC/82vXyViA8v9
 gqIBGDo2eCPJS+YxwD+cLogK9QQbxjhrtRI9xyIxQTINldAiq7Zr/KnXzvdv+UBRZIqA
 ZMCJwTV3uIfqZ8BBk+Ha0aJ59Zrbh4tiTFEg6+h3MvEEf/h9iaM0K6MM+aHINBPkcKes
 pcrg==
X-Gm-Message-State: AOJu0Yyl7ZxqN8MFkRJasPxoEZ1WrGDj0yG7+xDpJT98pZMaObEgtFdl
 Bf+kdsUOJTWLWwCVwomSYnR5yeBqAXKzbA==
X-Google-Smtp-Source: AGHT+IF5k6EZwBGz3NRAt5+/OSLMA1H6dOw9D2gHnxH8CSBWmYMxFjdJv7W0FPa2MNNgOW0MzHcn+Q==
X-Received: by 2002:a05:600c:188f:b0:40d:177b:c420 with SMTP id
 x15-20020a05600c188f00b0040d177bc420mr9285201wmp.65.1704268812041; 
 Wed, 03 Jan 2024 00:00:12 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 t13-20020adfe10d000000b00336c9ad1173sm20917156wrz.26.2024.01.03.00.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 00:00:11 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 03 Jan 2024 09:00:04 +0100
Subject: [PATCH] doc: dfu: fix a handful of typos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-dfu-doc-typos-v1-1-9d0a28339bec@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAMUlWUC/x3MMQqAMAxA0atIZgNNdRCvIg4lTTWLlVZFkd7d4
 viG/1/IklQyjM0LSS7NGrcKahvg1W2LoPpqsMb2hkyHPpzoI+Px7DEjdcRBeBDHDLXZkwS9/98
 0l/IB9Xl8+l8AAAA=
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
X-Mailer: b4 0.12.4-dev-6aa5d
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

Reword some sentences, add missing periods and fix various typos in the
dfu documentation.

This was originally contributed on [1]

[1] https://github.com/Maalobs/u-boot/commit/9a21ed8ba722d904b68945f40ca6697b4b1cc4d4

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
The author wished to remain anonymous so I just included a link to the
original change.
---
 doc/usage/dfu.rst | 60 +++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
index 8845a71df369..8cc09c308d82 100644
--- a/doc/usage/dfu.rst
+++ b/doc/usage/dfu.rst
@@ -6,11 +6,11 @@ Device Firmware Upgrade (DFU)
 Overview
 --------
 
-The Device Firmware Upgrade (DFU) allows to download and upload firmware
-to/from U-Boot connected over USB.
+Device Firmware Upgrade (DFU) enables the download and upload of firmware
+to/from U-Boot while connected over USB.
 
 U-Boot follows the Universal Serial Bus Device Class Specification for
-Device Firmware Upgrade Version 1.1 the USB forum (DFU v1.1 in www.usb.org).
+Device Firmware Upgrade Version 1.1 from the USB forum (DFU v1.1 in www.usb.org).
 
 U-Boot implements this DFU capability (CONFIG_DFU) with the command dfu
 (cmd/dfu.c / CONFIG_CMD_DFU) based on:
@@ -43,7 +43,7 @@ target (for example OTP), only based on the weak functions:
 Configuration Options
 ---------------------
 
-The following configuration option are relevant for device firmware upgrade:
+The following configuration options are relevant to device firmware upgrade:
 
 * CONFIG_DFU
 * CONFIG_DFU_OVER_USB
@@ -60,7 +60,7 @@ The following configuration option are relevant for device firmware upgrade:
 Environment variables
 ---------------------
 
-The dfu command uses 3 environments variables:
+The dfu command uses 3 environment variables:
 
 dfu_alt_info
     The DFU setting for the USB download gadget with a semicolon separated
@@ -90,17 +90,17 @@ Commands
 --------
 
 dfu <USB_controller> [<interface> <dev>] list
-    list the alternate device defined in *dfu_alt_info*
+    List the alternate device defined in *dfu_alt_info*.
 
 dfu <USB_controller> [<interface> <dev>] [<timeout>]
-    start the dfu stack on the USB instance with the selected medium
+    Start the dfu stack on the USB instance with the selected medium
     backend and use the *dfu_alt_info* variable to configure the
-    alternate setting and link each one with the medium
-    The dfu command continue until receive a ^C in console or
-    a DFU detach transaction from HOST. If CONFIG_DFU_TIMEOUT option
-    is enabled and <timeout> parameter is present in the command line,
+    alternate setting and link each one with the medium.
+    The dfu command continues until it receives a ^C in the console or
+    a DFU detach transaction from the HOST. If the CONFIG_DFU_TIMEOUT option
+    is enabled and a <timeout> parameter is present in the command line,
     the DFU operation will be aborted automatically after <timeout>
-    seconds of waiting remote to initiate DFU session.
+    seconds of waiting for the remote to initiate a DFU session.
 
 The possible values of <interface> are (with <USB controller> = 0 in the dfu
 command example)
@@ -139,11 +139,11 @@ mmc
 
         u-boot raw 0x80 0x800;uImage ext4 0 2
 
-    If don't want to flash given image file to storage, use "skip" type
-    entity.
+    If you don't want to flash the given image file to storage, use the "skip"
+    type entity.
 
-    - It can be used to protect flashing wrong image for the specific board.
-    - Especailly, this layout will be useful when thor protocol is used,
+    - It can be used to protect from flashing the wrong image for the specific board.
+    - Especially, this layout will be useful when the thor protocol is used,
       which performs flashing in batch mode, where more than one file is
       processed.
 
@@ -153,18 +153,18 @@ mmc
 
         u-boot-<board1>.bin raw 0x80 0x800; u-boot-<board2>.bin skip 0 0
 
-    When flashing new system image requires do some more complex things
-    than just writing data to the storage medium, one can use 'script'
-    type. Data written to such entity will be executed as a command list
-    in the u-boot's shell. This for example allows to re-create partition
-    layout and even set new *dfu_alt_info* for the newly created paritions.
-    Such script would look like::
+    When flashing a new system image requires you to do some more complex
+    things than just writing data to the storage medium, one can use 'script'
+    type. Data written to such an entity will be executed as a command list
+    in the u-boot's shell. This for example allows you to re-create a partition
+    layout and even set a new *dfu_alt_info* for the newly created partitions.
+    Such a script would look like::
 
         setenv dfu_alt_info ...
         setenv mbr_parts ...
         mbr write ...
 
-    Please note that this means that user will be able to execute any
+    Please note that this means the user will be able to execute any
     arbitrary commands just like in the u-boot's shell.
 
 nand
@@ -216,8 +216,8 @@ sf
     each element in *dfu_alt_info* being either of:
 
     * <name> raw <offset> <size>  raw access to sf device
-    * <name> part <dev_id> <part_id>  raw acces to partition
-    * <name> partubi <dev_id> <part_id>  raw acces to ubi partition
+    * <name> part <dev_id> <part_id>  raw access to partition
+    * <name> partubi <dev_id> <part_id>  raw access to ubi partition
 
     with
 
@@ -288,17 +288,17 @@ Callbacks
 The weak callback functions can be implemented to manage specific behavior
 
 dfu_initiated_callback
-   called when the DFU transaction is started, used to initiase the device
+   called when the DFU transaction is started, used to initialize the device
 
 dfu_flush_callback
     called at the end of the DFU write after DFU manifestation, used to manage
-    the device when DFU transaction is closed
+    the device when the DFU transaction is closed
 
 Host tools
 ----------
 
 When U-Boot runs the dfu stack, the DFU host tools can be used
-to send/receive firmwares on each configurated alternate.
+to send/receive firmware images on each configured alternate.
 
 For example dfu-util is a host side implementation of the DFU 1.1
 specifications(http://dfu-util.sourceforge.net/) which works with U-Boot.
@@ -409,8 +409,8 @@ Same example with MTD backend
 
 Example 3
 
-firmware located in SD Card (mmc) and virtual partition on OTP and PMIC not
-volatile memory
+firmware located in SD Card (mmc) and virtual partition on OTP and PMIC
+non-volatile memory
 
 - alternate 1 (alt=1) for scard
 - alternate 2 (alt=2) for OTP (virtual)

---
base-commit: dffa6d0210f57793f1e4e1e209d91ca5642e4d05
change-id: 20240103-dfu-doc-typos-131cfec8eacc

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

