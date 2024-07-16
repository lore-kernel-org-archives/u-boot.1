Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F8DC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 07:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41325889B3;
	Tue, 16 Jul 2024 09:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SCkVmNg7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 783C48875B; Tue, 16 Jul 2024 09:04:35 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C4AB88984
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 09:04:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so8621745e9.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 00:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721113473; x=1721718273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VStutLHX4ReJC3QC20bFQLw8j5iPWBhNi6yCRaXUtVo=;
 b=SCkVmNg7XYtm5N+nuU/nI/ww7vdRg+kY5if65n7BNkH/7Lbmo/nCRpqCY3l9NiwW0N
 wquHopiUt8Id01C3J+Kv24e0b5MQYnydoYMDr+BtJNhoFYbUxt5YDv1j0vpGHW3Ot7CP
 0abh1k9VaABFa7fmlYp3JxHlzpViI0x+cbxRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721113473; x=1721718273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VStutLHX4ReJC3QC20bFQLw8j5iPWBhNi6yCRaXUtVo=;
 b=ezk7hLjJZnSUTLdOXGTpsfRtA7YuqflqFkHT93o5szNaZJgIu2iBOPRuKBZ3KbECl1
 8ZGZkr4Fm36Q1Mr+BOITqI1pQcUHH9biB8u3bBRca/ZySuzsC17W2hOdWOttQQJYD43C
 J7RtLH3RO8mAHiR0sw2T3zDpFDtMIWyH0o4G1uZvgbjaNGaDUarIpGY+9uv7JuD8wuyB
 tIMkKLONIlGZFSAdSXsGpdDO9H6XHTv2BlMgpECURd00VO1nEY+qoHbvQpH+7pMyWgxS
 xlquCxARiNdkovVNOC7VflhYRzA8uqPbJD8ibTw+Jt/n7hHZpM9DahuhTGhwaKtMh2u+
 frKg==
X-Gm-Message-State: AOJu0YxwfpXWz9iSHDkks+Fu+7EbHc0g9PGKJITGK3Wi/mgBjdDAjBbw
 2hCd3b4nqWtLKXqNocmof2zUYMv3HpuMQcnShrHnUCNspM5KeL4iVgBngKjctkJrwj2cDlf6eP8
 =
X-Google-Smtp-Source: AGHT+IGR5alt/hF8DrjBFmdVp8dEvhQMI0QfBTVmqd403x07f2QYKSrbi804v8jS33jF/cRuDC3Phg==
X-Received: by 2002:a05:600c:1396:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-427bb5f5b32mr6063605e9.0.1721113472880; 
 Tue, 16 Jul 2024 00:04:32 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc286sm149446295e9.33.2024.07.16.00.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 00:04:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 08/14] doc: Add a description for bootmeth_sandbox
Date: Tue, 16 Jul 2024 08:04:13 +0100
Message-Id: <20240716070419.1897560-9-sjg@chromium.org>
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

Add documentation for the sandbox bootmeth.

Fix up the compatible string to drop the 'extlinux' part, which is not
relevant to this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Changes in v2:
- Adjustments from Heinrich's comments

 boot/bootmeth_sandbox.c          |  2 +-
 doc/develop/bootstd/index.rst    |  1 +
 doc/develop/bootstd/overview.rst |  1 +
 doc/develop/bootstd/sandbox.rst  | 17 +++++++++++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)
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
index 9b50b5593c4..add054f3088 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -420,6 +420,7 @@ Bootmeth drivers are provided for booting from various media:
    - :doc:`ChromiumOS <cros>` ChromiumOS boot from a disk
    - EFI boot using boot manager
    - :doc:`QFW <qfw>`: QEMU firmware interface
+   - :doc:`sandbox <sandbox>` used only for testing
 
 Each driver is controlled by a Kconfig option. If no bootmeth driver is
 selected by a compatible string in the devicetree, all available bootmeth
diff --git a/doc/develop/bootstd/sandbox.rst b/doc/develop/bootstd/sandbox.rst
new file mode 100644
index 00000000000..a90c1accc84
--- /dev/null
+++ b/doc/develop/bootstd/sandbox.rst
@@ -0,0 +1,17 @@
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
+The compatible string "u-boot,sandbox-bootmeth" is used for the driver. It is present
+if `CONFIG_BOOTMETH_SANDBOX` is enabled.
-- 
2.34.1

