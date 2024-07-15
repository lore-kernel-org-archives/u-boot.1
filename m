Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C801C3DA5E
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5649A888AC;
	Mon, 15 Jul 2024 12:14:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PtC6WGlv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF3E888B2; Mon, 15 Jul 2024 12:14:06 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 901F2887EE
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42660b8dd27so27258165e9.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038444; x=1721643244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ER8WNnl4oQ5Zu8/brMbGAaOYfh+6mSl488l1hDRfuuY=;
 b=PtC6WGlvwAdQsMFdbRywfWGZEgnldQgN1LWfgAWmPNycdtUvhtCpa/YPTCogBZ9w0+
 cAekPdOrliVGUHe+bXKYboTohHALJmw11O3FD5T1YZL/u3Up1pJCmPd0MRKPhdCGB3ui
 VL0or64LKgBg4rw5lC6NuJYmMhtfymy1Kczb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038444; x=1721643244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ER8WNnl4oQ5Zu8/brMbGAaOYfh+6mSl488l1hDRfuuY=;
 b=aAg+CKn0ohItPv7alN+S5jrwrIaKFbi960GMZXJgN9R8QKbMF40WNkCJ8WE1EvsZmB
 75enw5A0CtA7ZJDKbEzPFshqy7AzKkH0DvSt5S4H+RGD76HJKLefZ/TaIf+G//TxXCg2
 FtYKRP6+hKcyRF5l0TOfHIGe1+U1hbE4TSJSVDSroGdDM7Hb4rKMaopAZ6keIUNt/iSB
 Th5lEdm8dtEfYyErYNZL2cdjIfKQtarQ4FLNyscusAJJ3QakDSJ/wyrCmjVKKOjbTGiG
 n0NUTl4OH8OHe7+bvyFYv9jREE5n5YQ9Fls17fz8eoEUlt36eGiDMJCKGul/JoT5Mxtc
 hKGw==
X-Gm-Message-State: AOJu0YxYjHpxJKtIKSxPhh/tY0x3JojNzyVOw59PEmSGetXzQNHNX6rW
 3CDGwk+xCDobuW5bLLoBbPH44U2X1wl+WyXGUVoBlPIqZHzDFiY2i+rK68BffbXvrt4jpKWuJQY
 =
X-Google-Smtp-Source: AGHT+IFtUMf4qu+NPV2aEwL1mekkwcVtzEmqI64aZ85O3sEw4jXTaEI+HGVkp1AgHATRjNINJVoR4A==
X-Received: by 2002:a05:600c:468d:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-42688842d2fmr133862355e9.4.1721038443973; 
 Mon, 15 Jul 2024 03:14:03 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 05/13] doc: Add a description for bootmeth_qfw
Date: Mon, 15 Jul 2024 11:13:46 +0100
Message-Id: <20240715101354.97895-6-sjg@chromium.org>
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

Add documentation for the qfw bootmeth.

Fix up the compatible string to drop the 'extlinux' part, which is not
relevant to this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_qfw.c              |  2 +-
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  1 +
 doc/develop/bootstd/qfw.rst      | 21 +++++++++++++++++++++
 4 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 doc/develop/bootstd/qfw.rst

diff --git a/boot/bootmeth_qfw.c b/boot/bootmeth_qfw.c
index dfaa944594e..2f8e00cf350 100644
--- a/boot/bootmeth_qfw.c
+++ b/boot/bootmeth_qfw.c
@@ -88,7 +88,7 @@ static struct bootmeth_ops qfw_bootmeth_ops = {
 };
 
 static const struct udevice_id qfw_bootmeth_ids[] = {
-	{ .compatible = "u-boot,qfw-extlinux" },
+	{ .compatible = "u-boot,qfw-bootmeth" },
 	{ }
 };
 
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index 5052afe448f..f8fce7207ce 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -9,3 +9,4 @@ Standard Boot
    overview
    extlinux
    pxelinux
+   qfw
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index fd0692daf0d..bcc2c00c775 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -418,6 +418,7 @@ Bootmeth drivers are provided for:
    - EFI boot using bootefi from disk
    - VBE
    - EFI boot using boot manager
+   - :doc:`QFW <qfw>`: QEMU firmware interface
 
 
 Command interface
diff --git a/doc/develop/bootstd/qfw.rst b/doc/develop/bootstd/qfw.rst
new file mode 100644
index 00000000000..b0d47fd246a
--- /dev/null
+++ b/doc/develop/bootstd/qfw.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+QFW Bootmeth
+============
+
+`QEMU <hhttps://www.qemu.org/>`_ is a system emulator which is able to boot
+Operating Systems. QEMU provides specific support for booting an OS image
+provided on the QEMU command line.
+
+When invoked on a bootdev for UCLASS_QFW, this bootmeth reads the kernel
+provided by the QEMU `-kernel` argument, the iniital ramdisk and provided by
+`-initrd` and the boot arguments (command line) provided by `-append` into
+memory ready for booting.
+
+When the bootflow is booted, the bootmeth tries the `booti` command first, then
+falls back to the `bootz` command. U-Boot's 'control' devicetree is passed
+through to the kernel.
+
+The compatible string "u-boot,qfw-bootmeth" is used for the driver. The driver
+is automatically instantiated if there are no bootmeth drivers in the
+devicetree.
-- 
2.34.1

