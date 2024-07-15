Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A4BC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDA438889C;
	Mon, 15 Jul 2024 12:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L19AMRAu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F81F88820; Mon, 15 Jul 2024 12:14:06 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC8B887FD
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52e9a920e73so4585859e87.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038443; x=1721643243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0V3mzX0eaYXP2K/veYYjLTj/LZ0d5hauNSf66SPST1Q=;
 b=L19AMRAuH5gfU+BnsBPV+/kzG5EtiOCzhlGifJsEK/ZOQ3WHan1v8MZsMEMgZUEYLH
 C9q5KusrHQ2P0kvBDqtwGV6ehfh9RQqSsJnQJdQ3zaftliMX2vLWfezwxfXOeFS8L4Xk
 eLQuXADMzZL5WIsICxD8JaT6eiG/LdkpZjOnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038443; x=1721643243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0V3mzX0eaYXP2K/veYYjLTj/LZ0d5hauNSf66SPST1Q=;
 b=JzPXrzSelErmXa5gW4PRKt4syJ+z/Z+9m/KqDzoi9qx+b0M5ZbB3RUrPF424OVxPut
 YnIhzDGh9iEMLdeFPC2thXUyp13+PWkeMadqzyfJtetLlcOpi1R5io/2bi98cUH5G8C9
 N8JeAX02GNQMp5gevyFHVH2ER0RAwG5WBSUhDZmh7BPjRE/sr/ETIgb+wvalLJ90HHXi
 fL2b5j6dFRrACpOhR34jgnzMgc4WQI0m3DFb8v2cCyaqAXZhcy4G1PYp76URLX5Es5IQ
 XhjKYzT8yqHo6Kqfj8ADEyCci6ZvAx1wFt7pzJTmDYpIHQaDuWKmhQ5h1Wgxg+rcpgnV
 NULQ==
X-Gm-Message-State: AOJu0Yx64VNtXXPnuZ+p3eBxQfjAlntjgi/vUAINxIvpPlaU5CTljG1L
 dEQ9ifdI6Kmm7t7vMKV7/FyuIwpCWjHYUxgibbRUHzRS7uT93x8hl8xVt3psEBUJtPZXx7EuLT4
 =
X-Google-Smtp-Source: AGHT+IE7zA+q9uawqg3u/ep1SZOknHpLPU2B4yDAaZ9R0Te1tY0KkV+hwWCKvQQ2oLJFypenshqWKw==
X-Received: by 2002:ac2:5613:0:b0:52e:9ec8:a407 with SMTP id
 2adb3069b0e04-52eb99d3dc1mr8744508e87.63.1721038441115; 
 Mon, 15 Jul 2024 03:14:01 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 04/13] doc: Add a description for bootmeth_pxe
Date: Mon, 15 Jul 2024 11:13:45 +0100
Message-Id: <20240715101354.97895-5-sjg@chromium.org>
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

Add documentation for the pxe bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  2 +-
 doc/develop/bootstd/pxelinux.rst | 27 +++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 doc/develop/bootstd/pxelinux.rst

diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index 5bbb3d633a3..5052afe448f 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -8,3 +8,4 @@ Standard Boot
 
    overview
    extlinux
+   pxelinux
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 086a0b1281d..fd0692daf0d 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -413,7 +413,7 @@ Available bootmeth drivers
 Bootmeth drivers are provided for:
 
    - :doc:`extlinux / syslinux <extlinux>` boot from a disk
-   - extlinux boot from a network (PXE)
+   - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
    - U-Boot scripts from disk, network or SPI flash
    - EFI boot using bootefi from disk
    - VBE
diff --git a/doc/develop/bootstd/pxelinux.rst b/doc/develop/bootstd/pxelinux.rst
new file mode 100644
index 00000000000..08ba67e09c5
--- /dev/null
+++ b/doc/develop/bootstd/pxelinux.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+PXE Bootmeth
+============
+
+PXE (Preboot eXecution-Environment) provides a way to boot an Operating System
+over a network interface. The PXE bootmeth supports PXELINUX and allows U-Boot to
+provide a menu of possible Operating Systems from which the user can choose.
+
+U-Boot includes a parser for the `extlinux.conf` file described
+`here <https://uapi-group.org/specifications/specs/boot_loader_specification>`_.
+It consists primarily of a list of named OSes along with the kernel, initial
+ramdisk and other settings. The file is retrieved from a network server using
+tftpboot.
+
+When invoked on a bootdev, this bootmeth searches for the file and creates a
+bootflow if found. See
+`PXELINUX <https://wiki.syslinux.org/wiki/index.php?title=PXELINUX>`_ for
+a full description of the search procedure.
+
+When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
+context, then pxe_process() to process the file. Depending on the contents, this
+may boot an OS or provide a list of options to the user, perhaps with a timeout.
+
+The compatible string "u-boot,extlinux-pxe" is used for the driver. The driver
+is automatically instantiated if there are no bootmeth drivers in the
+devicetree.
-- 
2.34.1

