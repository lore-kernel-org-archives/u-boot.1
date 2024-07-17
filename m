Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D22C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C409788A53;
	Wed, 17 Jul 2024 10:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PKYJP35E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3D388A47; Wed, 17 Jul 2024 10:31:24 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 325F488A53
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3680667d831so2867248f8f.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721205081; x=1721809881; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8GAjNBLyju8iW60lZg4hJTdLsUVEkCQMBlsbgSlpB4E=;
 b=PKYJP35ETYB++DJKhomlEo16/k3dv7fI+sFxunSuuJW63WfdPf+waZqUpKy3AbrTRL
 XZEknQ9LuAPzHG6JNHoc9C5Ii5ysrOO0cLLvNMFO8wD8ZCwj0/qYT+TCeeWVH0WxPlfX
 gFV0+bNxfNyMIp9EGqHnnQh2S0tAqVQdhxZ2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721205081; x=1721809881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GAjNBLyju8iW60lZg4hJTdLsUVEkCQMBlsbgSlpB4E=;
 b=QSdjiddNQc1xAfs7qfOsrB0/dgQXs5eJuejNYdNWN0LaKuNnyzJWGUrZt4xvVrBoJS
 4va/a2kMgNJYtwvYfFKP0O+F/GdAErEnLTK8r6thgOCzqhmsBkk26Sw8BfdtYvDYE930
 J9cN0k3VhkBijo5RzHL00qMYOypkCikkvYgAsC6Eie1HnFmR+TZMMLQ/qedGQl83uFUA
 Gz+sqdvixIl3Z2lyVBhyaz5qN7YZBIMUhv5b5Ta7TjDs7L6+4RlBgCqZ4qCPBEMYFgCO
 1kFEi87dg33BdOjgOA2zhFRE3hp5KgZKIrml5Y6NvxQ7m1XmHp1SmASdpIUQpQXTLWSx
 tWVw==
X-Gm-Message-State: AOJu0YxuEd49mkuEQrFvcxeB7McJwCaESszs9/U7ViwJC6tm17/zIYNu
 dJCCZMbuDxBwxd1AXehjNVzISZlLfulXLEdarwEVjv09ZwGqJhc7NXwa8got9Ki+HKwclNV1I+M
 =
X-Google-Smtp-Source: AGHT+IGUF15vyozPu1uGfxHzT0rkqkDLPoKynfzTOUndw0pi6UxLz6zu4S+awQ3HI5rABhQmkep1Bw==
X-Received: by 2002:a5d:47ce:0:b0:368:75:26fe with SMTP id
 ffacd0b85a97d-368316527d5mr765844f8f.32.1721205081580; 
 Wed, 17 Jul 2024 01:31:21 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbb5bsm11069930f8f.80.2024.07.17.01.31.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 01:31:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 09/14] bootstd: Tidy up comments on the boothmeth drivers
Date: Wed, 17 Jul 2024 09:30:59 +0100
Message-Id: <20240717083104.1963431-10-sjg@chromium.org>
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

Fix a typo in the comment and add one to the EFI driver too.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 boot/bootmeth_efi.c      | 1 +
 boot/bootmeth_extlinux.c | 2 +-
 boot/bootmeth_script.c   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 5a4c125835a..56a6e47f5b2 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -394,6 +394,7 @@ static const struct udevice_id distro_efi_bootmeth_ids[] = {
 	{ }
 };
 
+/* Put a number before 'efi' to provide a default ordering */
 U_BOOT_DRIVER(bootmeth_4efi) = {
 	.name		= "bootmeth_efi",
 	.id		= UCLASS_BOOTMETH,
diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 9b55686948f..fbb05ef928e 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -183,7 +183,7 @@ static const struct udevice_id extlinux_bootmeth_ids[] = {
 	{ }
 };
 
-/* Put an number before 'extlinux' to provide a default ordering */
+/* Put a number before 'extlinux' to provide a default ordering */
 U_BOOT_DRIVER(bootmeth_1extlinux) = {
 	.name		= "bootmeth_extlinux",
 	.id		= UCLASS_BOOTMETH,
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index 0e05d28d4d9..24da47c7259 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -250,7 +250,7 @@ static const struct udevice_id script_bootmeth_ids[] = {
 	{ }
 };
 
-/* Put an number before 'script' to provide a default ordering */
+/* Put a number before 'script' to provide a default ordering */
 U_BOOT_DRIVER(bootmeth_2script) = {
 	.name		= "bootmeth_script",
 	.id		= UCLASS_BOOTMETH,
-- 
2.34.1

