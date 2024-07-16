Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F90C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1024889BA;
	Tue, 16 Jul 2024 09:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WpxDzvg5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC3088958; Tue, 16 Jul 2024 09:04:38 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D944F88865
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266f535e82so34309345e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113475; x=1721718275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFu1Ayw8W31Xn34+lcNSb/bDpOkUO+7Syy1Eb6ZRdR4=;
 b=WpxDzvg5D+/5e5hVZ1N9fnjNRj35MXwwfKYd8N/Xmz746LWUotgRDWLUBaotLQCLYO
 j24Top65w9VOgUwp6jQp3SosmzWjrNnVfHgwx3i8W+C52h9Twe+W/JXkkXg9cpAc77qc
 +M40H2F2Hwp+1StOxE4vdP6ZLyPqE7IGZ9c1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113475; x=1721718275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFu1Ayw8W31Xn34+lcNSb/bDpOkUO+7Syy1Eb6ZRdR4=;
 b=pZUfr58/h0ppai/ys6Vihmb0yybA7kkKV1KU/HZoJnPgKbycCFcu+RqRvIqfTrO05R
 v1tXJJ+Ey8jA9glqIiYr5Bals1SsiOgJCFQorEgFtLabwvgtAOeOrmU6hEw91q8c3Fm4
 umLUavIUFc+HbuqAJv/tMmsFK8xHanuz3nFNrRyXiFSSeP9lGrhEXvHDNjSrpdLFhK0l
 IbmUkJBeyz3ZN8wmI0m8rx8V7UpkoQgnpqo3TeTrWrxK4kH4ZTF1bgF1MYCebN73ifIZ
 oMpm58PeX6jzCF6DljyWrz2+Goiiy3S3kslzRkaPOomUbk4Lt4IsWGTqdTSo2iS6RE+8
 rtiA==
X-Gm-Message-State: AOJu0YwZqGyFrv7whU6saLGyxD8+xKYzJ3JFb2KDWwhgTGqXEwXABTcg
 lzj1wk3TaHT7CkcH5lL9021mManSSaDIsCUadkIe12hgO/YTkOX8Mfk3iLMoCQyHP13TMUJ4GAw
 =
X-Google-Smtp-Source: AGHT+IEm6Fwqul9KFz2oIW077a1YiHTjwyEoNLKBukM1RzzvA6IbP9Hgn9WThRoRljXY2Ikgkijq4g==
X-Received: by 2002:a05:600c:3592:b0:425:7c5f:1bac with SMTP id
 5b1f17b1804b1-427ba69d54fmr7478175e9.21.1721113475265; 
 Tue, 16 Jul 2024 00:04:35 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 11/14] doc: Add a description for bootmeth_script
Date: Tue, 16 Jul 2024 08:04:16 +0100
Message-Id: <20240716070419.1897560-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716070419.1897560-1-sjg@chromium.org>
References: <20240716070419.1897560-1-sjg@chromium.org>
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
---

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
index 00000000000..58ddc1cae1d
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
+
+The compatible string "u-boot,script" is used for the driver. It is present
+if `CONFIG_BOOTMETH_SCRIPT` is enabled.
-- 
2.34.1

