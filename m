Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED59C3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 12:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3946887F5;
	Wed, 24 Jul 2024 14:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PHGL+pzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 106B38881B; Wed, 24 Jul 2024 14:41:33 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 762DC8857D
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 14:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4277a5ed48bso51008935e9.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721824890; x=1722429690;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ws85tnaGLq+atxk5UHfnkVoJR9lY1iQJJyWYDvzrVU4=;
 b=PHGL+pzqE7dRyuxbQNTX4BsSthLWWVUJLRluliStyfQGXHSiyo+CZH4QNBoM+d6MeP
 WFoWy/RV87L/9Bi1TC7QMRbKT1oVdCfl41qVLNnGAZhsg2FbcdUQSWjK4YK4n9uu4EW1
 ynKH7eWI5qbS0S3x/O6ME+D2rCNt4iPJtLFF9rqNd7smB7F+4cMDz8VJ9oMqx50cxwy+
 2y2bCHoaUeREfEiNqVsQ99C+Et4jQw7NNQYPEGsN1BXXzlfqK4ejcI8PY2osxUnMeDzA
 Jw4s8WpZNFP7x+LvCsYfTCisOhUJoB0yZzsJ5QJ5imLvQQfKWSM9AQgr8gw2+ZmU9Jgf
 vR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721824890; x=1722429690;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ws85tnaGLq+atxk5UHfnkVoJR9lY1iQJJyWYDvzrVU4=;
 b=BjWgHJKIc1NEKGoaokk507av+Dyn7qNL0Wwk38YIppYY4PF9LPBOv96KHT9myTtNKt
 IUzRfvOOm1x0qumTHAZjaNwHa5TilEcgAYkjyoi9BONemvCGfzDGHyaJCLRdrglfO5pC
 N2+Hh6NHxw4Zb1CT2UiR7mLs6ljahq1KR4WUyHWVG5PTuFByCgaD1QnWEa3TUsEUfWId
 VeW8WUSXsI03m7xfohVK7JA2OeqPlBWdzslLyN1x2DSxUx/i46h2k3meJUQsPpdpGM02
 lbSyY4HK8C/P/AC5idSRofHIbuRkMb7vsuh5tiasIqfee8R5LtzZQDE03bTj//Q5V7hW
 cZTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP0vYalCOdpAfz9FSuzbzQXxH7VKMR7JVEj/VfeoEKpDx4sogDPvyVmY0049nyzV0zP7+h+g6Y50toOIJ/OdBzYsBHEg==
X-Gm-Message-State: AOJu0YwZjAVFr6vLTXlGw0wLlZnRTuCSB4ZCvb8qVMwGM/+nJbpd+sh1
 wKKJsYVgDJtpOY9TGV6NybUlLuZmQC9X06SEsKTTXl9r4RISLOIhQkMY7hZeC+o=
X-Google-Smtp-Source: AGHT+IGV7bGgnDZN6F7N9bw7FPiyg3U7JSj3P7CzaEElf8zY889Wjba53dPK9rtKD7efkdwswBR6BA==
X-Received: by 2002:a05:600c:5491:b0:426:6ed2:6130 with SMTP id
 5b1f17b1804b1-427f955845bmr14399305e9.14.1721824889323; 
 Wed, 24 Jul 2024 05:41:29 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427ffaf2460sm3032355e9.40.2024.07.24.05.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 05:41:28 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 24 Jul 2024 14:41:25 +0200
Subject: [PATCH] doc: Add a description for bootmeth_android
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240724-doc-bootstd-android-v1-1-03a55b7a7c92@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHT2oGYC/x3MMQqAMAxA0atIZgM1iopXEYdqomZppBURxLtbH
 N/w/wNJokqCoXggyqVJLWRUZQHL7sMmqJwN5KhxHTXItuBsdqaT0QeOpozMq+uruW6JPOTyiLL
 q/V/H6X0/mla+ymUAAAA=
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

Add initial documentation for the Android bootmeth.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS                      |  1 +
 doc/develop/bootstd/android.rst  | 39 +++++++++++++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  2 +-
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6e47e8a2179..c2832345ab18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -945,6 +945,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dfu.git
 F:	boot/bootmeth_android.c
 F:	boot/bootmeth_android.h
+F:	doc/develop/bootstd/android.rst
 
 BTRFS
 M:	Marek Behún <kabel@kernel.org>
diff --git a/doc/develop/bootstd/android.rst b/doc/develop/bootstd/android.rst
new file mode 100644
index 000000000000..41701d5bdff3
--- /dev/null
+++ b/doc/develop/bootstd/android.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+Android Bootmeth
+================
+
+Android provides a mechanism for booting its Operating System from eMMC storage,
+described on `source.android.com <https://source.android.com/docs/core/architecture/bootloader>`_.
+
+Android has strong requirements about partitioning layout which are described
+`here <https://source.android.com/docs/core/architecture/partitions>`_.
+Because multiple partitions are required, this bootmeth only operates on whole mmc
+devices which have a valid partition table.
+
+When invoked on a bootdev, this bootmeth searches for the ``misc`` partition in order
+to read the *boot mode*, which can be one of following:
+
+Normal
+  Boot the regular Android Operating System.
+
+Recovery
+  Boot a slimmed down Recovery Operating System. Can be used
+  to factory reset the device or to apply system updates.
+
+Bootloader
+  Stay in U-Boot and wait for fastboot commands from the host.
+
+After the *boot mode* has been determined, this bootmeth will read the *slot suffix*
+from the ``misc`` partition. For details about slots, see
+`the AOSP documentation <https://source.android.com/docs/core/ota/ab#slots>`_.
+
+When both the *boot mode* and the *slot suffix* are known, the bootflow is created.
+
+When the bootflow is booted, the bootmeth reads the kernel, the boot arguments and
+the vendor ramdisk.
+It then boots the kernel using bootm. The relevant devicetree blob is extracted
+from the ``boot`` partition based on the ``adtb_idx`` environment variable.
+
+The compatible string "u-boot,android" is used for the driver. It is present
+if `CONFIG_BOOTMETH_ANDROID` is enabled.
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index 9d35b567d55d..4c4e26ccdb70 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -10,6 +10,7 @@ Standard Boot
    extlinux
    pxelinux
    qfw
+   android
    cros
    script
    sandbox
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index ff3cc48eb64f..c6f003851b2a 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -429,7 +429,7 @@ Available bootmeth drivers
 
 Bootmeth drivers are provided for booting from various media:
 
-   - Android bootflow (boot image v4)
+   - :doc:`Android <android>` bootflow (boot image v4)
    - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
    - EFI boot using bootefi from disk
    - EFI boot using boot manager

---
base-commit: f659ba43837e5ae5a35fdff3736c8e13f9062abd
change-id: 20240724-doc-bootstd-android-ddf081b3622a

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

