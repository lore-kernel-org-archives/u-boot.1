Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EB9C3DA5E
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562C2888B2;
	Mon, 15 Jul 2024 12:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MK5ba//A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23F9888B9; Mon, 15 Jul 2024 12:14:10 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51BB2888A5
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4279c924ca7so23625315e9.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038447; x=1721643247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9HMXFnXYZcKnKJCl9G0dl3FkzQBcXzoSfGMcITdRZo8=;
 b=MK5ba//AmyO8rH4wPWFxdiYrQNMYKzye6ZS8JJhtbpUYnpk4gbWR5q7TyX+qE730aT
 Drk9yyfl+NiybCiM4PhM8zmBQTDRYRZsyoLUYb3qG25wIotRZQPxdqcGI7NfcNHULpw5
 wYuL5+uRZ/diNCZ+r+1VDUjyD6UHKXlH1vnxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038447; x=1721643247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9HMXFnXYZcKnKJCl9G0dl3FkzQBcXzoSfGMcITdRZo8=;
 b=tIbzE7EQ1R3nYp3Wm9olnW2ZFGL6T+l2n+XpCOTJXBy/PyvFCYXQ87/02RO6RRZnsR
 YR2IGvfYEE1jXqzdsmQU1yLkWQGmZbr4EvbYZKCraydX+QEbM3NP6+Yo8KmbcONSjyTA
 +VKOIaAyMDA7cVZGvufL1G4KqVWDtsISXeSZ+xKzMnpQDjBZPpFgMsyOdUpkkwzIhgZb
 qukP/hguVWQEioaJOE7CyP84PmZNYiGBWUipW0rx5NGdpOj7vfOSvLul4uuZjN+qx/hK
 6C8k0K7V0hn6DQg+poQ3ZQBVf5kHuMIf1i4pp3jo6Y/etWcVQ9wTPzMBLmFJBLYpiPYC
 x31Q==
X-Gm-Message-State: AOJu0YxTQaQw8MwfaM3Fcy7BcOIj9AAUIr/4YA/uLdc4pUL0FEwUxDIt
 UuPViTN5LAPIxtHKj3EklShdFIOj5xzDJ/DiqzYORKYCY8H+GVgL0xVok5IfKzAJCQz4l/2Q7rw
 =
X-Google-Smtp-Source: AGHT+IGm8z4sI8klAXjR5HlpeGn98frsb1p5x3AAm+un3WWIPFhhXXwyZN90wWg0zEO9HK8pNeUHFg==
X-Received: by 2002:a05:600c:6d4:b0:426:6b85:bafb with SMTP id
 5b1f17b1804b1-426707db6e7mr107411635e9.20.1721038447593; 
 Mon, 15 Jul 2024 03:14:07 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 10/13] doc: Add a description for bootmeth_script
Date: Mon, 15 Jul 2024 11:13:51 +0100
Message-Id: <20240715101354.97895-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715101354.97895-1-sjg@chromium.org>
References: <20240715101354.97895-1-sjg@chromium.org>
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

Add documentation for the script bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  2 +-
 doc/develop/bootstd/script.rst   | 49 ++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 doc/develop/bootstd/script.rst

diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index 2c5d2d3fade..9d35b567d55 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -11,4 +11,5 @@ Standard Boot
    pxelinux
    qfw
    cros
+   script
    sandbox
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 58acaa4d3ce..7d31d5e6427 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -414,7 +414,7 @@ Bootmeth drivers are provided for:
 
    - :doc:`extlinux / syslinux <extlinux>` boot from a disk
    - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
-   - U-Boot scripts from disk, network or SPI flash
+   - :doc:`U-Boot scripts <script>` from disk, network or SPI flash
    - EFI boot using bootefi from disk
    - VBE
    - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
diff --git a/doc/develop/bootstd/script.rst b/doc/develop/bootstd/script.rst
new file mode 100644
index 00000000000..8127e21ec1d
--- /dev/null
+++ b/doc/develop/bootstd/script.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+Script Bootmeth
+===============
+
+This bootmeth provides a way to locate and run a script on a block or network
+device. It can also support SPI flash.
+
+For a block device the file is read from the selected partition, which must use
+a supported filesystem. The subdirectory to search in is defined by the bootstd
+list of prefixes ({"/", "/boot"} by default) and can be adjust with the
+`filename-prefixes` property in the bootstd device.
+
+For a network device, the filename is obtained from the `boot_script_dhcp`
+environment variable and the file is read using tftp. It must be in the
+top-level directory of the tftp server.
+
+In either case (file or network), the bootmeth searches for the file and creates
+a bootflow if found. The bootmeth searches for "boot.scr.uimg" first, then
+"boot.scr" if not found.
+
+For SPI flash, a script is read from flash using the offset provided by the
+"script_offset_f" environment variable.
+
+Some attempt is made to identify the OS: so far this only detects an
+`Armbian <https://www.armbian.com>`_
+distro. For block devices, if a file called "boot.bmp" exists in the same
+directory then it is used as the bootflow logo.
+
+When the bootflow is booted, the bootmeth sets these environment variables:
+
+    devtype
+        device type (e.g. "usb", "mmc", "ethernet" or "spi_flash")
+
+    devnum
+        device number, corresponding to the device 'sequence' number
+        `dev_seq(dev)`
+
+    distro_bootpart
+        (block devices only) partition number on the device (numbered from 1)
+
+    prefix
+        prefix used to find the file
+
+    mmc_bootdev
+        device number (same as `devnum`), set for sunxi mmc devices only
+
+The script file must be a FIT or a legacy uImage. It is loaded into memory and
+executed.
-- 
2.34.1

