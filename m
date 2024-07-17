Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 411C4C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FABB88A4B;
	Wed, 17 Jul 2024 10:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cRX8Lf14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D58886E5; Wed, 17 Jul 2024 10:31:21 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D0678841D
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so52327465e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205079; x=1721809879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHXfwRfqfKGf0ihjpwe0qbTiX5XWprKn6Mlgvi4ejjQ=;
 b=cRX8Lf14lcawei9LJ9r2O/+3UWAk67RwBBD7LfES/Uc1lHCIPhrAfz16og9DsLmZx3
 x+guo0LT2jJH3w2F2A6O2o2doyNZxcfMbseraJ3yxxi3qNyMkEL63pVqXmQVenSOGxX4
 FMbmSMIP/OShLYtWefpCIICJYFoegqBrUjRg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205079; x=1721809879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHXfwRfqfKGf0ihjpwe0qbTiX5XWprKn6Mlgvi4ejjQ=;
 b=Cy27nyeWyHhX2qVWgMZUsHcRPkRupVSDsAGJ7EQKJkXvyck+027OuDvRGaYToqXTnU
 n6L6JW4h10RuPnELjIfqvmTy7n1yeMLx0L+18I9JGKs0XYlocfgpBtzRGblxYXg5Zxh0
 q8ESXpJDgI8kRee++fzQn8C12h4PRNEm9tkZ5wfRVctFa73ZNuXyoIbQXisae49uQo9e
 VR76py3YNZrygKqLA5HxJjsYmEyjjVA2xFsz6uYSzaiR7Mc7sN0Sj6AkSOiA9ui3sTul
 IluAONWqHMWsKuexa74yvymsw7BZQveDb5H66svFS82fim/14O7fUkXqU9PbkhCKtFQX
 eXRA==
X-Gm-Message-State: AOJu0YxRryRiWl0xXaHi8YBfHzvNQbwE3o6i6G+4vhNN8KO0rIqNdD2q
 r/hjutWd3MIRCOTmu0AIlrCPcOQnnYhCyQkc60HsaP69GbZkMlk/KQa6uF8ITEK5kXXJd4Me5EA
 =
X-Google-Smtp-Source: AGHT+IGKJoKPz8AmJzFmFGQNP+bU0Zbz6E6LjTC92Mkc2xHM2YO1o/zOcn7BmMNchZwfyAXx+Y17LA==
X-Received: by 2002:a05:600c:46c3:b0:426:6714:5415 with SMTP id
 5b1f17b1804b1-427c2d01f36mr9052415e9.30.1721205078756; 
 Wed, 17 Jul 2024 01:31:18 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 05/14] doc: Add a description for bootmeth_pxe
Date: Wed, 17 Jul 2024 09:30:55 +0100
Message-Id: <20240717083104.1963431-6-sjg@chromium.org>
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

Add documentation for the pxe bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v3:
- Link to pxelinux from extlinux
- Use quoting on function names

Changes in v2:
- Adjustments from Heinrich's comments

 doc/develop/bootstd/extlinux.rst |  3 ++-
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  2 +-
 doc/develop/bootstd/pxelinux.rst | 27 +++++++++++++++++++++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 doc/develop/bootstd/pxelinux.rst

diff --git a/doc/develop/bootstd/extlinux.rst b/doc/develop/bootstd/extlinux.rst
index 46e9ad9eea1..bf27dc57aaa 100644
--- a/doc/develop/bootstd/extlinux.rst
+++ b/doc/develop/bootstd/extlinux.rst
@@ -14,7 +14,8 @@ under the `boot/` subdirectory. This list of prefixes (``{"/", "/boot"}`` by
 default) can be selected with the `filename-prefixes` property in the bootstd
 device.
 
-Note that the PXE bootmeth uses the same file format, but in a network context.
+Note that the :doc:`pxelinux` uses the same file format, but in a
+network context.
 
 When invoked on a bootdev, this bootmeth searches for the file and creates a
 bootflow if found.
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index 5bbb3d633a3..5052afe448f 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -8,3 +8,4 @@ Standard Boot
 
    overview
    extlinux
+   pxelinux
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 7af159b9ca8..b9b45f1e7a7 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -413,7 +413,7 @@ Available bootmeth drivers
 Bootmeth drivers are provided for booting from various media:
 
    - :doc:`extlinux / syslinux <extlinux>` boot from a storage device
-   - extlinux boot from a network (PXE)
+   - :doc:`extlinux / syslinux <extlinux>` boot from a network (PXE)
    - U-Boot scripts from disk, network or SPI flash
    - EFI boot using bootefi from disk
    - VBE
diff --git a/doc/develop/bootstd/pxelinux.rst b/doc/develop/bootstd/pxelinux.rst
new file mode 100644
index 00000000000..c4b7fbb4c9c
--- /dev/null
+++ b/doc/develop/bootstd/pxelinux.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+PXE Bootmeth
+============
+
+PXE (Preboot eXecution-Environment) provides a way to boot an operating system
+over a network interface. The PXE bootmeth supports PXELINUX and allows U-Boot to
+provide a menu of possible Operating Systems from which the user can choose.
+
+U-Boot includes a parser for the `extlinux.conf` file described
+`here <https://uapi-group.org/specifications/specs/boot_loader_specification>`_.
+It consists primarily of a list of named operating systems along with the
+kernel, initial ramdisk and other settings. The file is retrieved from a network
+server using the TFTP protocol.
+
+When invoked on a bootdev, this bootmeth searches for the file and creates a
+bootflow if found. See
+`PXELINUX <https://wiki.syslinux.org/wiki/index.php?title=PXELINUX>`_ for
+a full description of the search procedure.
+
+When the bootflow is booted, the bootmeth calls ``pxe_setup_ctx()`` to set up
+the context, then ``pxe_process()`` to process the file. Depending on the
+contents, this may boot an Operating System or provide a list of options to the
+user, perhaps with a timeout.
+
+The compatible string "u-boot,extlinux-pxe" is used for the driver. It is
+present if `CONFIG_BOOTMETH_EXTLINUX_PXE` is enabled.
-- 
2.34.1

