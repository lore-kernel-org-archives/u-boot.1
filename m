Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BE0C3DA5E
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99370888A3;
	Mon, 15 Jul 2024 12:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MwASdlns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E72B8888F; Mon, 15 Jul 2024 12:14:04 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA61687C69
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4267345e746so27226025e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038440; x=1721643240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uqdXWcMDcY+fR7sFQXwNJpey3qNDrnHcxZDmGv57WQ=;
 b=MwASdlnsNXJ4pm1qqMk9p1ktZIDIhIab0ad6a09u95d2W5/66Tq/oHU+PnzfY67Ek/
 QquXTA0CQYIze6BDEVXA70fx4tBgWtyKvgRNguRjAVZRp5mDkgenDLQirr74vvc+mCaL
 u2Wgpw1xrmXFJSrCq7KbfuIgjBHnmGqiiR4DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038440; x=1721643240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1uqdXWcMDcY+fR7sFQXwNJpey3qNDrnHcxZDmGv57WQ=;
 b=noRpv8GKLePGfXNtLUdjdxWcJWrRHoRH6LvsTDpML2XTrpmbxNnerx1KC3b4WybBNE
 ZgsO5FTJJr4aabrBq6a7odwRfbxI9luJIRk8zyC/qWdVhDg8A/Xu+wl4jf2gEqJ9DySY
 2f9OEmj3PtcMForUvZjMTdGQESlu8wnknjrCRS+Ui+5A+pymPJBIqKmezlXx9RMTGeuB
 x0t6U2dSvAAIYGSqhpGfq42GpMgzQul4gdHM+vllVpclbR9DbPdb4lWTtwa29EFav8jm
 UOrFTQ3nLElU0C24LdyPtgPbQYZKeA/0gCptv/b/Va1TjpZf6awJ5Tu6PW66NNMYbVMu
 NBUw==
X-Gm-Message-State: AOJu0YwAlBhHBjIef3/HAzUWJxMe3ca3z1VS5tdMySiPfGsiUdPQ+BbV
 q3E9bthp879nc7uq+FJVFMOJM9RokazppZTnZm1i36VBEprhGuTP4A0w16cvf1xLDV8t5Cuo6gs
 =
X-Google-Smtp-Source: AGHT+IFpdDn0ETHe0KgT5ifvIqS0m0PgiUuEwXYUMfhXA4dsgUaQxgY6bCEkeqTexS99wF2G3wzmVA==
X-Received: by 2002:a05:600c:460a:b0:426:51d1:63c3 with SMTP id
 5b1f17b1804b1-426708fa8e2mr121169595e9.38.1721038440294; 
 Mon, 15 Jul 2024 03:14:00 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 03/13] doc: Add a description for bootmeth_extlinux
Date: Mon, 15 Jul 2024 11:13:44 +0100
Message-Id: <20240715101354.97895-4-sjg@chromium.org>
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

Add documentation for the extlinux bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/bootstd/extlinux.rst | 27 +++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  2 +-
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 doc/develop/bootstd/extlinux.rst

diff --git a/doc/develop/bootstd/extlinux.rst b/doc/develop/bootstd/extlinux.rst
new file mode 100644
index 00000000000..28490f38899
--- /dev/null
+++ b/doc/develop/bootstd/extlinux.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+Extlinux Bootmeth
+=================
+
+`Extlinux <https://uapi-group.org/specifications/specs/boot_loader_specification>`_
+(sometimes called syslinux) allows U-Boot to provide a menu of possible
+Operating Systems from which the user can choose.
+
+U-Boot includes a parser for the `extlinux.conf` file. It consists primarily of
+a list of named OSes along with the kernel, initial ramdisk and other settings.
+The file is stored in the `extlinux/` subdirectory, possibly under the `boot/`
+subdirectory. This list of prefixes ({"/", "/boot"} by default) can be selected
+with the `filename-prefixes` property in the bootstd device.
+
+Note that PXE (Preboot eXecution-Environment) uses the same file format, but in
+a network context.
+
+When invoked on a bootdev, this bootmeth searches for the file and creates a
+bootflow if found.
+
+When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
+context, then pxe_process() to process the file. Depending on the contents, this
+may boot an OS or provide a list of options to the user, perhaps with a timeout.
+
+The compatible string "u-boot,extlinux" is used for the driver. The driver is
+automatically instantiated if there are no bootmeth drivers in the devicetree.
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index f4f87c7787c..5bbb3d633a3 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -7,3 +7,4 @@ Standard Boot
    :maxdepth: 2
 
    overview
+   extlinux
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 761f61a573b..086a0b1281d 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -412,7 +412,7 @@ Available bootmeth drivers
 
 Bootmeth drivers are provided for:
 
-   - extlinux / syslinux boot from a disk
+   - :doc:`extlinux / syslinux <extlinux>` boot from a disk
    - extlinux boot from a network (PXE)
    - U-Boot scripts from disk, network or SPI flash
    - EFI boot using bootefi from disk
-- 
2.34.1

