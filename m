Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495E0C3DA5D
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 886F3889A2;
	Tue, 16 Jul 2024 09:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AnxcWcT/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC2088991; Tue, 16 Jul 2024 09:04:34 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 529B28896A
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4266f344091so37106795e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113470; x=1721718270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OnfPt1XhrNOkp5y4g/8qfZKZIISZTXmcBrdXJTSE17w=;
 b=AnxcWcT/2ZEz4TfOcJ20jC+Ojx30NBUcd6Wk9Hj493OXTsE1T3c+eLYRv4hYzc9Gqz
 xSdPfu7D6jDvEHb4vrGXw12Grz8Sr7fvd32MenmMPcg5VJQbSgdKE70ZJZJAoF/DOLrv
 gHAiqIToQwSR4yp4H2b03T/1GIOoy/w84AyhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113470; x=1721718270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OnfPt1XhrNOkp5y4g/8qfZKZIISZTXmcBrdXJTSE17w=;
 b=LxNVFJK9WqisXIEnMebZlGSeTc8zR/BqT5OvcKT5EEGemVHro9IBEzpwX9X1JM/lK7
 Q6UHppNL2l/KFkawedNiAadzgfA/yQlviaeGoQHj5m1c301VuPgCrTfqLIyrsdtcnB07
 XRGul3BWuALdvwBFNjZDAUp214gNY+hZaoCK/LLx7zOqq0J5hDrWasDiHfUL4e2ZuAXE
 CH1DVd9bf+SUNzaDBw3oP0x11L/9LRuEjz6WMfrMCeF3hCycj+Z6PcXIHno9Zhcn8lTw
 DlSeLRc76fPgFcNy+rGIpGKN7/0baSo2YYanMJ8bw5HbkONM68rA9taRnSdFepQmKL15
 werw==
X-Gm-Message-State: AOJu0YxC4Z/fzrZQpbcT9JAUCod9OpVcM+UjtuAK9ZsB8u5sqc8iJlfO
 82iaIt/otUtvqNVKm/OIn0GyRysP4FX+J0Apru+74vsLnG/BUBjldS0BPgBIE/aieAGblgogoOE
 =
X-Google-Smtp-Source: AGHT+IFdyDzuHoq0faMTKfMEiMcLtRzEl5B4GX7NP8vlUd9fiC1hA0iMNw2elVb12iB6x8cRofuKZA==
X-Received: by 2002:a05:600c:4e93:b0:426:5e91:3ff1 with SMTP id
 5b1f17b1804b1-427ba696bb9mr6248905e9.24.1721113470698; 
 Tue, 16 Jul 2024 00:04:30 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 05/14] doc: Add a description for bootmeth_pxe
Date: Tue, 16 Jul 2024 08:04:10 +0100
Message-Id: <20240716070419.1897560-6-sjg@chromium.org>
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

Add documentation for the pxe bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Adjustments from Heinrich's comments

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
index 00000000000..a4e559160ca
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
+When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
+context, then pxe_process() to process the file. Depending on the contents, this
+may boot an Operating System or provide a list of options to the user, perhaps
+with a timeout.
+
+The compatible string "u-boot,extlinux-pxe" is used for the driver. It is
+present if `CONFIG_BOOTMETH_EXTLINUX_PXE` is enabled.
-- 
2.34.1

