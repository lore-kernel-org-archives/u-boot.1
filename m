Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28447C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D028889B;
	Mon, 15 Jul 2024 12:14:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R3ntReAX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E472888B7; Mon, 15 Jul 2024 12:14:07 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F00B8889B
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3679df4cb4cso2543875f8f.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038444; x=1721643244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ji24cnwekH8rAO7TZQtHsRlpti1CEOVP02ZOYAPoh28=;
 b=R3ntReAXw6LXlQzPBskIhHeT3BRPTuvBSIOOhVv3JhJ+M7NuWd9EP0o3QCtxnftrOf
 jkLqIAz1Iu9GoyTGTPQZX+1KeiB5BcGdySMcrYdCkGqZ22g6OQzubl+D2XIrgC9fYa5J
 Q4K7+frCJ8zS9nx+Y2yxJHmfSQFpL1TXUyY2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038444; x=1721643244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ji24cnwekH8rAO7TZQtHsRlpti1CEOVP02ZOYAPoh28=;
 b=cbWC/sAeKqHkS4daWFbnom+V+1ZjW2ESPgQCbjwPSFzd7F9c48ClhFM/yjwGvaUfag
 IkXxuJUAFOLpnA2eoCSuVHm9kGvU8LLURIH3xl/6cJm/BlSj/8RTM9MiC7e143ZTVifi
 /XYVKtz39/ggaP4sDn/W3x/b6cP5BQMdo+YcL3zoIPG63gn9fmV6+EvPsfMpGyhQRRDl
 rMe6YCv5dioYxY2F+WPZRoyNVl8+789P1YWi0Iwlh7bG0MUUXvgnvLs2DRrSskrGVuy0
 JzVkcfK3BRLIMLyXnHS7gN75FEyxUuk4JyyvGdRv/Qkh6bX9pHY/bIFE07m32c0sYm3e
 RzdQ==
X-Gm-Message-State: AOJu0Yz74IdI2+SSlC7ykM7EGJOVCkTh+Z4IUDu/SNbqvKMxiSLWWLmF
 TUTw3Lq9j+yAybfmx+wFmpjFgoh9KICHCHhQwuBZfl85fsw0lLQPn2EgqBcVKK95EiXQYg+qVo8
 =
X-Google-Smtp-Source: AGHT+IH4tfzRINJ8vdm3QYQHh9euATMhRtGPwAHf+26WKu8os5iLo2aJNO6I5D+8WXyY3Oc8EfqI9w==
X-Received: by 2002:a5d:526d:0:b0:367:42ce:f004 with SMTP id
 ffacd0b85a97d-367ff7053a8mr7356633f8f.23.1721038444692; 
 Mon, 15 Jul 2024 03:14:04 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 06/13] doc: Add a description for bootmeth_cros
Date: Mon, 15 Jul 2024 11:13:47 +0100
Message-Id: <20240715101354.97895-7-sjg@chromium.org>
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

Add documentation for the cros bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/bootstd/cros.rst     | 33 ++++++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  1 +
 3 files changed, 35 insertions(+)
 create mode 100644 doc/develop/bootstd/cros.rst

diff --git a/doc/develop/bootstd/cros.rst b/doc/develop/bootstd/cros.rst
new file mode 100644
index 00000000000..96f148837ac
--- /dev/null
+++ b/doc/develop/bootstd/cros.rst
@@ -0,0 +1,33 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+ChromiumOS Bootmeth
+===================
+
+ChromiumOS provides a mechanism for booting its Operating System from a block
+device, described
+`here <https://www.chromium.org/chromium-os/chromiumos-design-docs/verified-boot/>`_.
+
+U-Boot includes support for reading the associated data structures from the
+device and identifying a bootable ChromiumOS image. This structure includes the
+kernel itself, boot arguments (kernel command line), as well as the x86 setup
+block (for x86 only).
+
+When invoked on a bootdev, this bootmeth searches for kernel partitions with
+the appropriate GUID (Globally Unique Identifier). When found, the information
+is loaded and a bootflow is created.
+
+When the bootflow is booted, the bootmeth reads the kernel and boot arguments.
+It then boots the kernel using zboot (on x86) or bootm (on ARM). The boot
+arguments are adjusted to replace %U with the UUID of the selected kernel
+partition. This results in the correct root disk being used, which is the next
+partition after the kernel partition.
+
+For ARM, a :doc:`/usage/fit/index` is used. The `CONFIG_FIT_BEST_MATCH` option
+must be enabled for U-Boot to select the correct devicetree to boot with.
+
+Note that a ChromiumOS image typically has two copies of the OS, each with its
+own kernel and root disk. There is no initial ramdisk (initrd). This means that
+this bootmeth typically locates two separate images.
+
+The compatible string "u-boot,cros" is used for the driver. The driver is
+automatically instantiated if there are no bootmeth drivers in the devicetree.
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index f8fce7207ce..69fd3c2d2eb 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -10,3 +10,4 @@ Standard Boot
    extlinux
    pxelinux
    qfw
+   cros
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index bcc2c00c775..f12e93236a7 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -417,6 +417,7 @@ Bootmeth drivers are provided for:
    - U-Boot scripts from disk, network or SPI flash
    - EFI boot using bootefi from disk
    - VBE
+   - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
    - EFI boot using boot manager
    - :doc:`QFW <qfw>`: QEMU firmware interface
 
-- 
2.34.1

