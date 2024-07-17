Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33B2C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6154188A65;
	Wed, 17 Jul 2024 10:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WAryZcSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1C0388A4D; Wed, 17 Jul 2024 10:31:23 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2450E88A47
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3683f56b9bdso32942f8f.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205080; x=1721809880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ll68qJERxK8VyCzx9XMbMp88pRY9OPkyXBQKmwXIur0=;
 b=WAryZcSjo9XjilBPft4Xx37xlKUKADRPECIQTRYEoAEFl5da6lO0J0oWTXXgUOAjRH
 ijTPFLpYfOaDc9bJ0Y8lQC3Ep8HVr88B/KqgNQm5+HtlhAC9LcH3DSueGSlIooAV3r64
 eZnGcF2bRBQhAGds3zJU0euAmHNwEdlnZEQcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205080; x=1721809880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ll68qJERxK8VyCzx9XMbMp88pRY9OPkyXBQKmwXIur0=;
 b=OCPEBhfmfvnznA7erry4OpJfIzh5ObY4qzVZC+nPsKYXqCVCbmF5IhbmI+KAZWtRUO
 xzh/BZu/Qc99ONAk3PHdLzSWP7F8PSd0NTGWSrTHo1GBTL0zWBmEHp1AjSxyNVUOiZqr
 Y9HTyhsylueQzALhOU5MIPkjybd4b3kU7yXNEORo6O1/eNXbyogGlKHW5pKlvlMlsfmT
 hrvij2T7fWSK1jW65XdZ4jGuqU4prArTQ0xTpOw7ypaG6cAU1HPRZH6+hNKnAf0oA7I/
 E2WLexPtoHVl/WFvjR3gHU4jON1n0NK53esdW7g3S36MKV1ZwaZZzoPOKERZ/4tnHlnM
 2isQ==
X-Gm-Message-State: AOJu0Yy6bhHRT5EAwQZwlKQg5LAyZ9uZrC7z7Lu/iH90CZr+1w9sOl0T
 k+yDbfNaIMg1Ii3mneDgsWzQq150w/0QwOPzuUKdvcXqe5LAZYkUiU6gshP9drUBLKyZVINOr1c
 =
X-Google-Smtp-Source: AGHT+IGUzBZknprcONkkuCpwMOkd/4UnNW63gkPb1l/sdhErdGj++1tdDw0eMXi3jsPD/vi6M6cngA==
X-Received: by 2002:adf:e90d:0:b0:367:9978:7ff with SMTP id
 ffacd0b85a97d-3683164fee6mr745742f8f.18.1721205080147; 
 Wed, 17 Jul 2024 01:31:20 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 07/14] doc: Add a description for bootmeth_cros
Date: Wed, 17 Jul 2024 09:30:57 +0100
Message-Id: <20240717083104.1963431-8-sjg@chromium.org>
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

Add documentation for the cros bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v3:
- Quote the %U

Changes in v2:
- Adjustments from Heinrich's comments

 doc/develop/bootstd/cros.rst     | 33 ++++++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  1 +
 3 files changed, 35 insertions(+)
 create mode 100644 doc/develop/bootstd/cros.rst

diff --git a/doc/develop/bootstd/cros.rst b/doc/develop/bootstd/cros.rst
new file mode 100644
index 00000000000..85af10588c1
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
+arguments are adjusted to replace `%U` with the UUID of the selected kernel
+partition. This results in the correct root disk being used, which is the next
+partition after the kernel partition.
+
+For ARM, a :doc:`/usage/fit/index` is used. The `CONFIG_FIT_BEST_MATCH` option
+must be enabled for U-Boot to select the correct devicetree to boot with.
+
+Note that a ChromiumOS image typically has two copies of the Operating System,
+each with its own kernel and root disk. There is no initial ramdisk (initrd).
+This means that this bootmeth typically locates two separate images.
+
+The compatible string "u-boot,cros" is used for the driver. It is present
+if `CONFIG_BOOTMETH_CROS` is enabled.
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
index f23e344546d..9b50b5593c4 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -417,6 +417,7 @@ Bootmeth drivers are provided for booting from various media:
    - U-Boot scripts from disk, network or SPI flash
    - EFI boot using bootefi from disk
    - VBE
+   - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
    - EFI boot using boot manager
    - :doc:`QFW <qfw>`: QEMU firmware interface
 
-- 
2.34.1

