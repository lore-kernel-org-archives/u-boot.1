Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D63C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD32D889AA;
	Tue, 16 Jul 2024 09:04:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BGwdShX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404A688993; Tue, 16 Jul 2024 09:04:34 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB1D8875C
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4265b7514fcso35266595e9.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113471; x=1721718271; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dPPAqRcL+pQdni0ZIlGEeHTBTO7lq1hwIWFJ04DS90Y=;
 b=BGwdShX7JFHQQTY/fmmE28RQFnNw6YlQcyDy9T4nUHaqQgV4XSRqykxYLz+LOwjStD
 lasAoCaiKXJiQ199yymm3K6SUTynuxzh7nLC1xyDSTIA4LQceOitu3C1ozDOckUS5CJO
 D1dwR780y6VQ4R6RkTwD06EpYCu0FdtKiyLq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113471; x=1721718271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dPPAqRcL+pQdni0ZIlGEeHTBTO7lq1hwIWFJ04DS90Y=;
 b=CNxgAjuT+MtqIzZJg1J5jest1b+8C4yCXZZQGY56aQGzojR233pIDnVtPBGOWm9G+U
 HSje+ytaz2zeQzQvhSzwpUx+VZQKSj+R3LCdORV4cF0E7Bn3OOOO90UMmTfL2uVMj6iU
 Zh3g6/Rr9SRXgLsB7Y1cOgRI/TqNTPszwQQs4AERt2mvgRzEGJu/8LJVjrdrBt7zHb2N
 ibTydt7IxBzBgQVWq3gaaKFAZpw5lPvxoHgE8H+SuYCKfhb8p1UR00im+J//gWkaMqMk
 igl1Iveop4/USYk+nej5BjLJofW7WrYMZ1ab+kEtlWFrrObolIrQdbXECX5ia6fGXeNP
 sK2w==
X-Gm-Message-State: AOJu0YxUHUdpR3qzPVb98g8uYRuesejKykJxUomj75EknTgNO/YW80ce
 Ps4wiDNgpjLfFoEFu6iN1YWsEgWYcaAETvp1I6CHr3njKAEBe5gxs8a4lzlncK7atRCWeZOxpU8
 =
X-Google-Smtp-Source: AGHT+IFsEYEiI88N976I8yzq3vAYoGlAGsQncqJ3lzdkCExmixKcKnPaaA7ov3HRGURfpUUfAoh3nw==
X-Received: by 2002:a05:600c:198c:b0:424:a7f1:ba2 with SMTP id
 5b1f17b1804b1-427bb8f4241mr7141495e9.17.1721113471374; 
 Tue, 16 Jul 2024 00:04:31 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 06/14] doc: Add a description for bootmeth_qfw
Date: Tue, 16 Jul 2024 08:04:11 +0100
Message-Id: <20240716070419.1897560-7-sjg@chromium.org>
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

Add documentation for the qfw bootmeth.

Fix up the compatible string to drop the 'extlinux' part, which is not
relevant to this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Adjustments from Heinrich's comments

 boot/bootmeth_qfw.c              |  2 +-
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  1 +
 doc/develop/bootstd/qfw.rst      | 20 ++++++++++++++++++++
 4 files changed, 23 insertions(+), 1 deletion(-)
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
index b9b45f1e7a7..f23e344546d 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -418,6 +418,7 @@ Bootmeth drivers are provided for booting from various media:
    - EFI boot using bootefi from disk
    - VBE
    - EFI boot using boot manager
+   - :doc:`QFW <qfw>`: QEMU firmware interface
 
 Each driver is controlled by a Kconfig option. If no bootmeth driver is
 selected by a compatible string in the devicetree, all available bootmeth
diff --git a/doc/develop/bootstd/qfw.rst b/doc/develop/bootstd/qfw.rst
new file mode 100644
index 00000000000..b2ff1364fd8
--- /dev/null
+++ b/doc/develop/bootstd/qfw.rst
@@ -0,0 +1,20 @@
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
+provided by the QEMU `-kernel` argument, the initial ramdisk and provided by
+`-initrd` and the boot arguments (command line) provided by `-append` into
+memory ready for booting.
+
+When the bootflow is booted, the bootmeth tries the `booti` command first, then
+falls back to the `bootz` command. U-Boot's 'control' devicetree is passed
+through to the kernel.
+
+The compatible string "u-boot,qfw-bootmeth" is used for the driver. It is
+present if `CONFIG_QFW` is enabled.
-- 
2.34.1

