Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50C3C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E85788A47;
	Wed, 17 Jul 2024 10:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B8YdDOfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ECA588A58; Wed, 17 Jul 2024 10:31:22 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25E7B885B6
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-367ab76d5e1so2169167f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205079; x=1721809879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqnBpgTPKSNCCM+zienf7jPxyVeSlY9pjtUDd1+uzxk=;
 b=B8YdDOfd0WcXabAhT0Waic0/9rHnbmmHvqVPRTuL0AHx/KS9xJ16gCOky2jb2Ta51h
 +FqMx5D1XPOw9dQEOLTDeAYuNcDmyAsnEan/XoRtKXo4cIlQ99dw17xcC3eXGS+O1wzs
 IS47bsWozHSCUuy+oamwe7Z2iZz2SuKktqGTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205079; x=1721809879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WqnBpgTPKSNCCM+zienf7jPxyVeSlY9pjtUDd1+uzxk=;
 b=GSHHlGJUkW/ykijo9G0lo7KqItcePzsyuUck1h88NbgVXR9+iM7TFtrFRi5Jwp7ULE
 BBepYDwifGuahmBPcXpUueMWq3lQnRgGiUvT9mvCzJaJje0X/A7ZRn/ATS9gfp3q7UxZ
 VpPVWrmcfSz2LiWKRFH4ZGRj+UTZeSEBFk+M4SGZeHv75m+cR8PJ4/GGjhwhiqCNZdQI
 kJsUXpAK5+cQ24YSxQoF3j6KgKygswxTQyEMa1OfHLoqLFRgsHu2n8jvgAIbFqcuj07A
 tEtcBdjyYY41IzSQtUbgGlUdUkub1g4PaHcYF+qBV4Q1NrMiArK8yomWSbH9ZrH2aM32
 QPKA==
X-Gm-Message-State: AOJu0YySJdn9pdfuhfebKiDJ5f+KRvrmvoHNrHVLKtNZK6LFMy5x/JpJ
 EBTdDvQGT042cbeXZXBT9He3Eyq5750YJP2Zo6XlkFmLbp6ylK+u3nqbmnPa6U4K2rW2RiBwJ6Y
 =
X-Google-Smtp-Source: AGHT+IFDt3FIKfy7FbTjhHTshDqzwb2gdO0dcCHy5wpgCSXu+Cngg5Ta1Xn07iPLEppxCa8zplGOog==
X-Received: by 2002:a05:6000:c8e:b0:367:8a87:ada2 with SMTP id
 ffacd0b85a97d-36831659bfcmr701379f8f.26.1721205079454; 
 Wed, 17 Jul 2024 01:31:19 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 06/14] doc: Add a description for bootmeth_qfw
Date: Wed, 17 Jul 2024 09:30:56 +0100
Message-Id: <20240717083104.1963431-7-sjg@chromium.org>
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

Add documentation for the qfw bootmeth.

Fix up the compatible string to drop the 'extlinux' part, which is not
relevant to this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v3:
- Drop extra 'and'

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
index 00000000000..70086ad1817
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
+provided by the QEMU `-kernel` argument, the initial ramdisk provided by
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

