Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A226C83F17
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 22:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23A0A835AE;
	Thu, 10 Jul 2025 00:29:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S6+H9j9i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446178360D; Thu, 10 Jul 2025 00:29:40 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 682A8835AE
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-40b71debe9aso147652b6e.2
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 15:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752100175; x=1752704975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwYXJgBcEehjXLtmlnPPC9Q2prZVIlRsq2fdpzeOV94=;
 b=S6+H9j9i5aX6dPAavmyi2ad5Fh9NbpMXOXU6I4W7qDuJbNxaUSNry03dd17I814Zd2
 ZQzXQkM+ab9jlsTGLq2UckMUA4ZrlUvTrcDBWQYp3xk/0d4z1ZoMTi+S1lAizxqEvSaR
 +UaHCwKplwBFwdt+y2NYlypeoRL5XEIzM92+a4jLoFi9ETLurLj3Tcx3bNB1lic5zFJ6
 JkObHwYdVLCsUPMuqUZiBrXsEfX47SncBF/DXz4DTh63BLaZ+D7u7QKN5BTONglVizJG
 xBBGmGX89wURVWENDceZFvm1wZSHHCisiNRb7UmTdlZITzFiynMqdcROBEj2XH/KjddH
 JWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752100175; x=1752704975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwYXJgBcEehjXLtmlnPPC9Q2prZVIlRsq2fdpzeOV94=;
 b=dYeHzG9/Vezz2BGkduZfWt1GYqBjPJmeIhqegv9qQ4pdBxrUZreXNrBNcmhzAEVNkj
 JZlC7T6NIz4YNssATVREZmemza6/SENDBvCRLZpSk+ylw6+S+Hi2ze1/YBQmwXUDKig5
 7YiJnYCnfFBY3CR6jrgURcEKOJBPhBGm3hZcFN3b5ucHV9vUhcQGBjEBbIhRuAMYfwJ6
 v0yONRCDQuV66DB6Y/yLqFqBxr+rFWJ2Hm3xrqalPU+Y/LJtXfDao3fsJ7WIuNsiT8Ko
 TAMJCgQMh2rNRaXvjYddnC6iuAeSA0xWymKci1kUUi2pgj7hUM3HKcW3d67sQPiWhyX+
 9YJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWx7j6bEUHsuu5jZrlCVIp3bB+3Ek4Q1+AjXpcMsLELrw2r4oIwfB3IKdWFG4UGLuJPBekC+g=@lists.denx.de
X-Gm-Message-State: AOJu0YzWWPyUepcZpET92ZP+2LZKplQMoQu3BKZf8YtbmT9ZgiuEsZKx
 zmsG/9t3Ep2g8bub280BaKRcd2PWicqC53mQRDQdn2Vr0KjZs2tGxlRGuD0rdMzpJsI=
X-Gm-Gg: ASbGncs98Yv1murZT9Edcn0ipnNqbiMoEam2gpbK9V7AX9AX+u7HsgY/YD8hpdGxDW1
 UKyb7fcHzOBR6q2Ij5YDnnCeW5mIEenM71s8UVU47M2ASg93RpBx37LwtySOY3QjLOmnpXTqwlu
 Ri2LxqC9V12ryq2fx4QienZNeMbDudeaqha1kF4uwuRhwoS+u06kwJVNvvsJpkQlhxHLfAvyrZC
 8Lub3iw/qVcmRErICy7EwtQ1ma1gLA8ypsqOkXP5miF23ebcdahpg4V+ALuco/u/+K5QZoJ1Ze/
 k/Tia5TJyAAAdNLGD6JGa1ASOQx8tDC6N6PFfZfJ4jVWWSeaEq8n3pcRBlpDaIa5ldpbfNTPI9S
 VjrM4ekI=
X-Google-Smtp-Source: AGHT+IFv6AJmuPDI6t+O+Tz/9ZsF7wsXVu2rpAHRSQBLtsDAC31KfxICC46ehqhNLbAJlQPI/WKFyQ==
X-Received: by 2002:a05:6808:1792:b0:3fa:daa:dd8e with SMTP id
 5614622812f47-412bd196abamr2457720b6e.35.1752100175027; 
 Wed, 09 Jul 2025 15:29:35 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141bcd27c1sm508b6e.30.2025.07.09.15.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 15:29:34 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 9/9] doc: samsung: Describe flashing process for E850-96
Date: Wed,  9 Jul 2025 17:29:26 -0500
Message-Id: <20250709222926.24671-10-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709222926.24671-1-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
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

Now that USB is enabled on the E850-96 board, DFU and fastboot tools are
functional and can be used to flash images to eMMC. Update the E850-96
documentation accordingly and describe flashing to User Data Area and
Boot HW Partition of eMMC using fastboot and DFU tools.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 doc/board/samsung/e850-96.rst | 85 ++++++++++++++++++++++++++++++-----
 1 file changed, 74 insertions(+), 11 deletions(-)

diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
index 0a7b6fc0c9dd..b435fa8b3533 100644
--- a/doc/board/samsung/e850-96.rst
+++ b/doc/board/samsung/e850-96.rst
@@ -43,17 +43,19 @@ Legend:
   BL31 in terms of ARM boot flow
 * ``LDFW``: Loadable Firmware
 
-Build Procedure
+Unbricking Note
 ---------------
 
-.. warning::
-  At the moment USB is not enabled in U-Boot for this board. Although eMMC is
-  enabled, you won't be able to flash images over USB (fastboot). So flashing
-  U-Boot binary **WILL** effectively brick your board. The ``dltool`` [8]_ can
-  be used then to perform USB boot and flash LittleKernel bootloader binary [7]_
-  to unbrick and revive the board. Flashing U-Boot binary might be helpful for
-  developers or anybody who want to check current state of U-Boot enablement on
-  E850-96 (which is mostly serial console, eMMC and related blocks).
+In case the board is bricked for some reason, the ``dltool`` [8]_ can be used to
+unbrick and revive it. This tool performs USB boot, and uploads the LittleKernel
+bootloader over USB, which is then being executed on the board. The loaded
+bootloader further enters fastboot mode, so that the user can flash the
+functional bootloader binary (U-Boot or LittleKernel [7]_) to eMMC using
+``fastboot`` tool. Please read the ``dltool`` README file for more details about
+the procedure.
+
+Build Procedure
+---------------
 
 Build U-Boot binary from source code (using AArch64 baremetal GCC toolchain):
 
@@ -64,8 +66,9 @@ Build U-Boot binary from source code (using AArch64 baremetal GCC toolchain):
   make e850-96_defconfig
   make
 
-Boot E850-96 board into fastboot mode as described in board software doc [9]_,
-and flash U-Boot binary into ``bootloader`` eMMC partition:
+The original E850-96 board is shipped with LittleKernel-based bootloader flashed
+in eMMC. To replace it with U-Boot, boot into fastboot mode (as described in
+the board software documentation [9]_), and flash U-Boot binary:
 
 .. prompt:: bash $
 
@@ -74,6 +77,66 @@ and flash U-Boot binary into ``bootloader`` eMMC partition:
 
 U-Boot will boot up to the shell.
 
+Flashing
+--------
+
+User area of eMMC contains GPT partition table (either Linux or Android). Boot
+Partition A (``mmc0boot0``) contains all firmware/bootloaders. Boot Partition
+B (``mmc0boot1``) contains U-Boot environment.
+
+First make sure to format eMMC accordingly. Prepare the initial environment:
+
+.. prompt:: bash =>
+
+  env default -f -a
+  env save
+
+For Linux, just format eMMC using default ``$partitions`` definitions:
+
+.. prompt:: bash =>
+
+  gpt write mmc 0 $partitions
+
+For Android, use ``$partitions_android`` instead:
+
+.. prompt:: bash =>
+
+  setenv partitions_linux $partitions
+  setenv partitions $partitions_android
+  env save
+  gpt write mmc 0 $partitions
+
+In case of Linux, there are two partitions available: ``esp`` (EFI System
+Partition) and ``rootfs``. It is recommended to use fastboot to flash images to
+those partitions. Enter fastboot mode on your device:
+
+.. prompt:: bash =>
+
+  fastboot usb 0
+
+And then flash the images:
+
+.. prompt:: bash $
+
+  fastboot flash esp esp.img
+  fastboot flash rootfs rootfs.img
+
+To update the firmware, it's easier to use DFU. Enter DFU mode on the board:
+
+.. prompt:: bash =>
+
+  dfu 0 mmc 0
+
+To update U-Boot:
+
+.. prompt:: bash $
+
+  dfu-util -D u-boot.bin -a bootloader
+
+It's also possible to use fastboot to flash the whole ``mmc0boot0`` HW
+partition, but it's not so straightforward, as one have to prepare the image for
+the whole ``boot0`` partition containing all firmware binaries first.
+
 References
 ----------
 
-- 
2.39.5

