Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822C0C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DFB288A6E;
	Wed, 17 Jul 2024 10:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mkhLqqJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89E0988A5D; Wed, 17 Jul 2024 10:31:26 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA9A88A1B
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4266fd39527so48584705e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205083; x=1721809883; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/sI4bztT08Wi1zXeo2ruFzab25bc6ZAjxTikKhuVkE=;
 b=mkhLqqJCF9LlOYQVLo6T/lZatRAJIWRp20ggNRFwqRi9Wn2IZ2iAwN2d1v9WOa7ULw
 tigr1Ti3hj5WrHmt4Omtp5rmXIGhKGONVBxZf/fd11qLRT/Dmj4zI1FuViIbofbq2s4e
 t8aaQ13Pw7zQvbePDrpkj2XW+Vkv/fvwPmwXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205083; x=1721809883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/sI4bztT08Wi1zXeo2ruFzab25bc6ZAjxTikKhuVkE=;
 b=V3a9n86ifePBqlysKgN3iqe8596JTNNy3VZsHrtPbUqvje8EFZqRzAGszzNkKvN+2W
 6tkoB3zB/p+kw5r9ywPKjVyI+heweu7UUysqmD3Gut6U3WoEjuGcbox0ooIwLOLBLxZ6
 n4JAKKH00iZU/61U5ckh3iK8le1P01WHeKSOKbFwlTteJk0F0VbKRpsn7txipZv0WKeu
 ZGP8ZFBme3/wFtxuqNSjUA4ROsIeE4aJWytW1c03H4yBjH7tOomzu5NKkXKHKf/nF42o
 DIGqV6fYKaPlOsyvyksMR9vjfAzfMdrZhQ1PnHUfbqO5I4b99JiIdEN88nPUyv64tEr4
 2sbg==
X-Gm-Message-State: AOJu0Yx57ivhOVmYWBc29U7BjbCO6DrH2NsvcPjD2bqG1SjAORZ6uHjK
 cNm0/kwcHhIXlD41gPCzttq+8t87DxPYz1IvZQCLQefr068BjX6xv7lg5MbAnT/l16wZQHfnMzo
 =
X-Google-Smtp-Source: AGHT+IEkMVNcRLziTX61X2ReJQIDLQw0IoLCcCV6YRbfFZT+rbiBJcY3OtSS7VHrbOX4aHWcKsw6QA==
X-Received: by 2002:adf:e80b:0:b0:368:255e:ab14 with SMTP id
 ffacd0b85a97d-368315ee839mr632646f8f.8.1721205083069; 
 Wed, 17 Jul 2024 01:31:23 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 11/14] doc: Add a description for bootmeth_script
Date: Wed, 17 Jul 2024 09:31:01 +0100
Message-Id: <20240717083104.1963431-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717083104.1963431-1-sjg@chromium.org>
References: <20240717083104.1963431-1-sjg@chromium.org>
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
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v3:
- Quote the list

Changes in v2:
- Adjustments from Heinrich's comments

 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  2 +-
 doc/develop/bootstd/script.rst   | 52 ++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 1 deletion(-)
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
index add054f3088..e4924b55ae7 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -414,7 +414,7 @@ Bootmeth drivers are provided for booting from various media:
 
    - :doc:`extlinux / syslinux <extlinux>` boot from a storage device
    - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
-   - U-Boot scripts from disk, network or SPI flash
+   - :doc:`U-Boot scripts <script>` from disk, network or SPI flash
    - EFI boot using bootefi from disk
    - VBE
    - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
diff --git a/doc/develop/bootstd/script.rst b/doc/develop/bootstd/script.rst
new file mode 100644
index 00000000000..47f3684b86b
--- /dev/null
+++ b/doc/develop/bootstd/script.rst
@@ -0,0 +1,52 @@
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
+list of prefixes (``{"/", "/boot"}`` by default) and can be adjust with the
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
+Some attempt is made to identify the Operating System: so far this only detects
+an `Armbian <https://www.armbian.com>`_
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
+        ``dev_seq(dev)``
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
+
+The compatible string "u-boot,script" is used for the driver. It is present
+if `CONFIG_BOOTMETH_SCRIPT` is enabled.
-- 
2.34.1

