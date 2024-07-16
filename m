Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C203DC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98FC68875B;
	Tue, 16 Jul 2024 09:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fJx/ei5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B1C8875B; Tue, 16 Jul 2024 09:04:35 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 513DF88865
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2eaafda3b5cso54078731fa.3
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113472; x=1721718272; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OS9cOi4j5GzChSoZUHcM9VrXyla+Rmwm0yeqhYyHbk=;
 b=fJx/ei5tJ0CHXDNN25DisA/oo5KkWfatWo0OAl9S7qo3i0kjhkeh9pzXbPs2OXpi/O
 +2CG1Xs229WUbWaGYcN+INJZVH6YhUikQY2YQFzU5lD7XWzd/aiNybClScKzS9x7z4dO
 pvvl130HKfRW0DQLy9XrWbmDlLMJ+2nABAyQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113472; x=1721718272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OS9cOi4j5GzChSoZUHcM9VrXyla+Rmwm0yeqhYyHbk=;
 b=r29X5qHzEfgGuYvbpvVWDovYbsnVCbzhcaXC5UqJL1qa3QwEYK4PKd3ofLhzdukuUJ
 DVlQ7lQGm8TSC0gJlfjCBrzIWA6KNPhYcxAKYOJV0OwbQQXmqyBYsH8P0Gksp2538E4+
 fVzX9Riy6UWS1rRfIztpURg9rtfWs8OLb9w3Kw+CjUdmoeN11G8pq+GSB+9qOoCMYoEC
 SEGsizQ/00jDOqqCgR4E1SqpdUerDKeUC2vYVel4A6fZbXCx8izYKqMHCQkTaonhDt0b
 nhxfLGwsTaypayr7eV2bzftxZosbzDeyJSroBOAfqXDyFEBKS2/KywT1kKB0Fsz4R3fu
 kd1Q==
X-Gm-Message-State: AOJu0Yzb1GTeOZC281xe+0bfNkXpKNNoVMvBHz5Qa9H6j7nga9AvnWw4
 HFzG1DUZDwvAVl2dyDZhDqk2xumzcAw2YLMrpQQvdAUUQr/Ogym4kgxP+rkDDXW00wU9lbHz9IM
 =
X-Google-Smtp-Source: AGHT+IF9cGgOiGA6xgEVNgYB4lhxD7kJ0rBqWdqbzXy1Q2G3zGVxhhX/iVovUz0QnKrug7DI/ISUfQ==
X-Received: by 2002:a2e:b17a:0:b0:2ec:1ce8:9a7d with SMTP id
 38308e7fff4ca-2eef415adf7mr7243931fa.4.1721113472148; 
 Tue, 16 Jul 2024 00:04:32 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 07/14] doc: Add a description for bootmeth_cros
Date: Tue, 16 Jul 2024 08:04:12 +0100
Message-Id: <20240716070419.1897560-8-sjg@chromium.org>
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

Add documentation for the cros bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Adjustments from Heinrich's comments

 doc/develop/bootstd/cros.rst     | 33 ++++++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  1 +
 3 files changed, 35 insertions(+)
 create mode 100644 doc/develop/bootstd/cros.rst

diff --git a/doc/develop/bootstd/cros.rst b/doc/develop/bootstd/cros.rst
new file mode 100644
index 00000000000..92b83729150
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

