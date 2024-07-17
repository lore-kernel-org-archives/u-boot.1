Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29889C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D840688A3C;
	Wed, 17 Jul 2024 10:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J9/+ePXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D3D88A44; Wed, 17 Jul 2024 10:31:20 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A260B88A35
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so2169154f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205078; x=1721809878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zhBThakuR/pt0Xd6GUtGbXTLGH2T+9QUkC7zA4LXBA=;
 b=J9/+ePXY6u8KcKDS6u/0w9eUvxMhPp6kc88ekC1SDEF5wkxWRrk9HCEcJexCyXS8f8
 l1SkIkk1lEl4+AYYGvY1k3hlOUW5etDcloodTCkH2Pio+FoOlsqT/E7Y03lWB5Gjui6Q
 skmkuc7BFh5VvtaIbajEtO+IGSv7MC2vXq+5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205078; x=1721809878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zhBThakuR/pt0Xd6GUtGbXTLGH2T+9QUkC7zA4LXBA=;
 b=Baxs1sLnB49z7i1woYJWXZuX3n8UhwrrPBmt1mMSPUE3rsFJShe/C/D1Q7JkeaOyys
 XtPaMquHMt09OqjXK9G5WMJ/F9qm4evOdBjPFq7rSCoWtRSXPSjga6nKv+jdlOmP+usK
 GA1F3/HM8OjXUqzZ3WBSaciq/JNzaJ4gmKOcNX7pBlZNbwsbTr8KtC2s7rS2wKIfKmED
 PCL8xJHwBr1k/WmDIuEW2eucM4DcUNhh/FFKousQXRR4zomWoObi4kUn2PpoQcW7jfpz
 6GbmSJTTP2QRfR7l3w/nvz0ct2LbdSwwFxQshTlZ0+8Q5hZas5Oj+jWeAmooJxCjXcEE
 8aXQ==
X-Gm-Message-State: AOJu0YwMPCii+zbBlzhRlo0uOlntrwrz4rYt0oE3JFVVQ91UVcaR5o35
 /pZxvcRCLwUg4X+fK1/w7Rt6G2jI9gI959jXXa/S/LgGVuYAVrc1zqqYhl/IdRxTLYC1SyuTofY
 =
X-Google-Smtp-Source: AGHT+IF7EHA6iOZYpJYSHuQ7s25obBxgDEZZh1PBda4I4Ngo2nlikcZm+VetjPJR64KdQr3WZRh87g==
X-Received: by 2002:adf:fe50:0:b0:362:5816:f134 with SMTP id
 ffacd0b85a97d-368315fe328mr603737f8f.13.1721205077934; 
 Wed, 17 Jul 2024 01:31:17 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 04/14] doc: Add a description for bootmeth_extlinux
Date: Wed, 17 Jul 2024 09:30:54 +0100
Message-Id: <20240717083104.1963431-5-sjg@chromium.org>
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

Add documentation for the extlinux bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v3:
- Use quoting on list and function names

Changes in v2:
- Adjustments from Heinrich's comments

 doc/develop/bootstd/extlinux.rst | 28 ++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  4 ++--
 3 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 doc/develop/bootstd/extlinux.rst

diff --git a/doc/develop/bootstd/extlinux.rst b/doc/develop/bootstd/extlinux.rst
new file mode 100644
index 00000000000..46e9ad9eea1
--- /dev/null
+++ b/doc/develop/bootstd/extlinux.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+Extlinux Bootmeth
+=================
+
+`Extlinux <https://uapi-group.org/specifications/specs/boot_loader_specification>`_
+(sometimes called syslinux) allows U-Boot to provide a menu of available
+operating systems from which the user can choose.
+
+U-Boot includes a parser for the `extlinux.conf` file. It consists primarily of
+a list of named operating systems along with the kernel, initial ramdisk and
+other settings. The file is stored in the `extlinux/` subdirectory, possibly
+under the `boot/` subdirectory. This list of prefixes (``{"/", "/boot"}`` by
+default) can be selected with the `filename-prefixes` property in the bootstd
+device.
+
+Note that the PXE bootmeth uses the same file format, but in a network context.
+
+When invoked on a bootdev, this bootmeth searches for the file and creates a
+bootflow if found.
+
+When the bootflow is booted, the bootmeth calls ``pxe_setup_ctx()`` to set up
+the context, then ``pxe_process()`` to process the file. Depending on the
+contents, this may boot an operating system or provide a list of options to
+the user, perhaps with a timeout.
+
+The compatible string "u-boot,extlinux" is used for the driver. It is present
+if `CONFIG_BOOTMETH_EXTLINUX` is enabled.
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index f4f87c7787c..5bbb3d633a3 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -7,3 +7,4 @@ Standard Boot
    :maxdepth: 2
 
    overview
+   extlinux
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index d5051e986bb..7af159b9ca8 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -410,9 +410,9 @@ a good selection of boot options is available.
 Available bootmeth drivers
 --------------------------
 
-Bootmeth drivers are provided for:
+Bootmeth drivers are provided for booting from various media:
 
-   - extlinux / syslinux boot from a disk
+   - :doc:`extlinux / syslinux <extlinux>` boot from a storage device
    - extlinux boot from a network (PXE)
    - U-Boot scripts from disk, network or SPI flash
    - EFI boot using bootefi from disk
-- 
2.34.1

