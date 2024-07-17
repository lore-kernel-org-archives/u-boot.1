Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB2FC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03FD088A66;
	Wed, 17 Jul 2024 10:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YGPxBJtM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE36688A4D; Wed, 17 Jul 2024 10:31:23 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65D388A1B
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52ea1a69624so6929562e87.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205081; x=1721809881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GCtU9161GWo66aWI5cy67+Oy6gpa5xlz9nORu27Jos4=;
 b=YGPxBJtMsc4LoGzUJyqv7EDl7VvNjjr/Zsp4EW6Loj7bHg+++NYcg6ANUUmOcnkgZk
 dJhf1R4eA/vW/Phj4SzaE2eXLx7OERDIuRZ+8XDA/Uqa1cxDmsSnhMBXec1EK5ha3JgF
 Mfg83LEsXlbsu3tF7DEW/ybNBJGzfp7OLADbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205081; x=1721809881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCtU9161GWo66aWI5cy67+Oy6gpa5xlz9nORu27Jos4=;
 b=F9Tb0r/TnezKehmRuKJSjigkLrwrzXzekJ72oDHC/aILlzuOpwhapErw9kYBL1XX2Q
 3jq6/O7JBpBrKA+FoS7E1LmtMnNNaYKWihoGSclk2UMJzWvEHyKMmUZfh14UN9PNW3W3
 RjSInn3nejSci9e28AuLLSBAibHI5T1mTmefRWORLhSZZty3uC47cUxZVUaMfrWXIqzy
 6HupyqpLuwVHV9q4Y0NFwqISe50DKLeWuQ0xXAqgOd12tW66hALNx6Q8KWXdu0fL1d6H
 kW4VQBSHVfDfIrs6iVlTLRHCGV5Pe/VBL2b2i1GFC2Qe74V/WD1P0Ma7irt8n+qlwsiu
 lKCg==
X-Gm-Message-State: AOJu0Yz9GsfxCB5C4ACRjGbv7jrriaM6/5AEARovY07xsADdgyeKpAHe
 lm1suQmkq6sBKfJFE7VV+L37RZYR5IvsB2/k9mgJQ9fuT/Xcy7Up9NFcRCW5c2MREph/RZp3Uec
 =
X-Google-Smtp-Source: AGHT+IEAK5QF1ece0/uB5FUAWeDmQIzVMHSpttl1bQiHnOWY1WeizHjfKRzpzEVrhLqJkZk6lS2B0g==
X-Received: by 2002:a05:6512:3f16:b0:52c:d750:bd19 with SMTP id
 2adb3069b0e04-52ee53ad97dmr769521e87.8.1721205080860; 
 Wed, 17 Jul 2024 01:31:20 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 08/14] doc: Add a description for bootmeth_sandbox
Date: Wed, 17 Jul 2024 09:30:58 +0100
Message-Id: <20240717083104.1963431-9-sjg@chromium.org>
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

Add documentation for the sandbox bootmeth.

Fix up the compatible string to drop the 'extlinux' part, which is not
relevant to this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v3:
- Fix EENOTSUPP typo and add quotes

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
index 00000000000..d501518c39a
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
+When the bootflow is booted, the bootmeth returns `-ENOTSUPP` indicating that it
+is not supported.
+
+The compatible string "u-boot,sandbox-bootmeth" is used for the driver. It is present
+if `CONFIG_BOOTMETH_SANDBOX` is enabled.
-- 
2.34.1

