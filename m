Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31D4C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28076888BE;
	Mon, 15 Jul 2024 12:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RLS1lt+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4967D887FD; Mon, 15 Jul 2024 12:14:08 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B7C888AB
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so23990895e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038445; x=1721643245; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB5ZDOkOkf+2KgWtXcMf2gZCEiYVoz42wYTaKJLZS1M=;
 b=RLS1lt+t3XA9GF9NUqmdZbtZ6y4aLZIPsJADb8uGlgS9b1QPs1e7Me6EHQg5CK++3O
 1Wnxv6EvvUJ5Zc+5t8AfAjZCDh9tN44bleEwwJQJg+vuw31WOKJ3qsULIOgSir06qP5A
 HGFVzdjiRaApsWks2pEnNJTkUzM4YULlPMMzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038445; x=1721643245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lB5ZDOkOkf+2KgWtXcMf2gZCEiYVoz42wYTaKJLZS1M=;
 b=PxYRB1J9AuWCh2wiB+zUg9LHTSkGkQ5YiSBa4mUH6xwXXIWca13857cRYJ1BPHIg77
 rBb6hbk3j8VV8f8JR4zp1p/2RhuUTLgDxUuOSnFat5RGfEgGziF5AS2qlmca9zTvWepQ
 zRRDtJifjRdmS0ITsvJHUcCy9cJqiY3wi/Aip1lPjzYa1ik3baJBHOBgX40UP/xBbKDm
 BcW9tUjTW7DO/73D6bfUQa3rg8Ffmp8b0IdBPmqUJcxIiT/ZRDn3SgYLfbv0GTGwMLnI
 9i3CeRYvCWymfrgcS7zmAQ6UnAi4AMDACh9ZALa7XP3qfsoLmNtX9nN9CpLZ1d281sho
 NLWg==
X-Gm-Message-State: AOJu0YwSZSeL43SZO9B3TTs3Nnrw17yzHA/f529GdFmax6koVWVg9qS3
 rg0xJ8jnI2j6oMsmyahvy9erAncjqv5EL7+Oj0G8vPPZ9E+6qH3rH5JM/YbLAclaI7lMeEgoprk
 =
X-Google-Smtp-Source: AGHT+IEWNwnsLDbkCXvm3a7jA5eEnWt1nG7RLMOxMIhriQBXtjaskj3Fb8PzmsYNfnEl6SzGKwjq7w==
X-Received: by 2002:a05:600c:4f49:b0:424:aa83:ef27 with SMTP id
 5b1f17b1804b1-4279d9f289emr92196315e9.1.1721038445327; 
 Mon, 15 Jul 2024 03:14:05 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH 07/13] doc: Add a description for bootmeth_sandbox
Date: Mon, 15 Jul 2024 11:13:48 +0100
Message-Id: <20240715101354.97895-8-sjg@chromium.org>
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

Add documentation for the sandbox bootmeth.

Fix up the compatible string to drop the 'extlinux' part, which is not
relevant to this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootmeth_sandbox.c          |  2 +-
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  1 +
 doc/develop/bootstd/sandbox.rst  | 18 ++++++++++++++++++
 4 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 doc/develop/bootstd/sandbox.rst

diff --git a/boot/bootmeth_sandbox.c b/boot/bootmeth_sandbox.c
index 0bc8f688e30..26c713bb5f3 100644
--- a/boot/bootmeth_sandbox.c
+++ b/boot/bootmeth_sandbox.c
@@ -55,7 +55,7 @@ static struct bootmeth_ops sandbox_bootmeth_ops = {
 };
 
 static const struct udevice_id sandbox_bootmeth_ids[] = {
-	{ .compatible = "u-boot,sandbox-extlinux" },
+	{ .compatible = "u-boot,sandbox-bootmeth" },
 	{ }
 };
 
diff --git a/doc/develop/bootstd/index.rst b/doc/develop/bootstd/index.rst
index 69fd3c2d2eb..2c5d2d3fade 100644
--- a/doc/develop/bootstd/index.rst
+++ b/doc/develop/bootstd/index.rst
@@ -11,3 +11,4 @@ Standard Boot
    pxelinux
    qfw
    cros
+   sandbox
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index f12e93236a7..58acaa4d3ce 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -420,6 +420,7 @@ Bootmeth drivers are provided for:
    - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
    - EFI boot using boot manager
    - :doc:`QFW <qfw>`: QEMU firmware interface
+   - :doc:`sandbox <sandbox>` used only for testing
 
 
 Command interface
diff --git a/doc/develop/bootstd/sandbox.rst b/doc/develop/bootstd/sandbox.rst
new file mode 100644
index 00000000000..508f0fd5baa
--- /dev/null
+++ b/doc/develop/bootstd/sandbox.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+Sandbox Bootmeth
+================
+
+The sandbox bootmeth is only used for testing. It does not provide any facility
+for booting an OS. While sandbox can do all the processing before the actual
+boot, it is not connected in this bootmeth.
+
+When invoked on a bootdev, this bootmeth pretends to find a bootflow and creates
+the associated structure.
+
+When the bootflow is booted, the bootmeth returns -EENOTSUPP indicating that it
+is not supported.
+
+The compatible string "u-boot,sandbox-bootmeth" is used for the driver. The
+driver is automatically instantiated if there are no bootmeth drivers in the
+devicetree.
-- 
2.34.1

