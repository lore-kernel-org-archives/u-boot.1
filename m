Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C9BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E24C8897B;
	Tue, 16 Jul 2024 09:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ClXqotHn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5DE088980; Tue, 16 Jul 2024 09:04:32 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99B2588865
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so39856705e9.2
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113470; x=1721718270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuYWvZH/k5wK7s199iLbxy5cq0VIwRLKe0QJhqJkfvg=;
 b=ClXqotHnIq3b++Es5b3PBN+v2L0UZ7mjl7hC0yINYbw5bWTX0xnIX9gpWsx2Wf+uPc
 OQoTUq7tUDBES1735T0gUJgb9etrbGvoMpYTbQbx2YQB9aEDz1YlJnZbnSfNsTR/TNcb
 IGvCTJOp4ByqJ8duTCsC3CbI+tsNlSxs/bY/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113470; x=1721718270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuYWvZH/k5wK7s199iLbxy5cq0VIwRLKe0QJhqJkfvg=;
 b=HuKl44pCbMBpTuDgI4YzCcMSJzunEIoFO6rjvmN5bkqOTQsrAYN67e3VvVR5BVxq1N
 3xYL+miL1eh2j3zHOjf7X78Ht3C1KCK0IRzrrqnaxzL8OD2FiJ4wGJMd3G9idFLwp80Q
 8dHV9nG9TDejZDasIW/lPbE4kfgW0sRQPDAgMEHv9OcfB2reEMDeAGHGCaWb0UcvnpuV
 oL/rdb5FWjojxpX7Pk2Y8S2K8Kk9lVoIMFEVeLBBPRJ5SvPb6/x51vLCUt1Iz6DrOznO
 /wcMRIIy7a2XZMKGLOELO3qEgPlUlyTrb+XITscTPzkA0adPiU8SzNuPHeU6iT9cdNxn
 G9jQ==
X-Gm-Message-State: AOJu0YxOxSYPK9IUEDD/A1Ij1bSKsEQgkToNpYiPCdXYOUnZEqSVtviU
 oQDBQhEX4lklB5bU0rTqoRh0ZrAygD5barDICtBjRCwbtABj+RKFDKelgeAHgmhB+LQw1NMXbRw
 =
X-Google-Smtp-Source: AGHT+IEaBYKGo8khjay/xUwXN3HbqJUTsx9K1uD99veHIwSRsbm8DM0eS2+MpIPu7hNf496HdhHygA==
X-Received: by 2002:a05:600c:5124:b0:426:6ed5:fcb with SMTP id
 5b1f17b1804b1-427ba64d446mr9652765e9.4.1721113469980; 
 Tue, 16 Jul 2024 00:04:29 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 04/14] doc: Add a description for bootmeth_extlinux
Date: Tue, 16 Jul 2024 08:04:09 +0100
Message-Id: <20240716070419.1897560-5-sjg@chromium.org>
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

Add documentation for the extlinux bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Adjustments from Heinrich's comments

 doc/develop/bootstd/extlinux.rst | 28 ++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  4 ++--
 3 files changed, 31 insertions(+), 2 deletions(-)
 create mode 100644 doc/develop/bootstd/extlinux.rst

diff --git a/doc/develop/bootstd/extlinux.rst b/doc/develop/bootstd/extlinux.rst
new file mode 100644
index 00000000000..d87730410ee
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
+under the `boot/` subdirectory. This list of prefixes ({"/", "/boot"} by
+default) can be selected with the `filename-prefixes` property in the bootstd
+device.
+
+Note that the PXE bootmeth uses the same file format, but in a network context.
+
+When invoked on a bootdev, this bootmeth searches for the file and creates a
+bootflow if found.
+
+When the bootflow is booted, the bootmeth calls pxe_setup_ctx() to set up the
+context, then pxe_process() to process the file. Depending on the contents, this
+may boot an operating system or provide a list of options to the user, perhaps
+with a timeout.
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

