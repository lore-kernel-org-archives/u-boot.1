Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07C2C3DA5E
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 10:15:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85FE8888D2;
	Mon, 15 Jul 2024 12:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AzVOTdzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF497888C9; Mon, 15 Jul 2024 12:14:08 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB0D888868
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42679f33fefso27107095e9.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721038446; x=1721643246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jV0y5SQVxrvtj2Cw8kmlXS/bUDW/pHBiDgLs4UYsUrE=;
 b=AzVOTdzAJ/CYuIHvAH6TtdihrtJi6RXAm10pzlMAlspZ5nMe0gxRETopFw1CyxJcsX
 FJqNiqEhdIX6oD3FS4TwTtNw/AEJ12wp8p1HKX05F9O1u9HBKZujnoxdQct3y/oS2FWN
 yrnWaQDBMce7Xrn63RAf9xi9PqQhzWZPKeVsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721038446; x=1721643246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jV0y5SQVxrvtj2Cw8kmlXS/bUDW/pHBiDgLs4UYsUrE=;
 b=Qj3Orhr1MU6H69314aqaqvKMv+A2YtG5mqMQHsloHBt7MAh+L3jnvuirZRK0mWgfAj
 JYhMuHCVEFotIH3Ilwa//48V+uHGlg6TR0c0+omkJWqYKerEoFx9HRMijWtD1ajQ9dea
 fq7k5cRd+whfvyATheerHFfBlz8ozCfrXXsf2i/mKZfBh4jPy3tyrMrtOlLVQrkrSSgr
 f4T4sEtlTPFkkFOxQ9E1JHcE/HDh4+4UTtftzirBsUc5Za4YgQoFR7QhXy6dtkDOURsY
 BmJB2gzOLGSwP2NYoAYF+JpSFtSi/UvyUa04ny8CRVUkHJBBxMYI1vwJa671XNRmt7Sy
 Uaeg==
X-Gm-Message-State: AOJu0YzZs+93gMyMRajE22+91QFljTJVxm3yjDpJhZ9mJ/JdFYMCotdH
 SaEmPkkO76w4KbQ44g6bR1VeD5gWgrfnU6ChL7paYNsJC9fH70MmZiFknbjjrioZBYnBASYxQe8
 =
X-Google-Smtp-Source: AGHT+IHqebFjmlk0NWijoB1bass1l01vHTBMODp42xCy17LF3El1W6hB6IkYFYBMzXXpvemtHlutMA==
X-Received: by 2002:a05:600c:524f:b0:427:9dad:8063 with SMTP id
 5b1f17b1804b1-4279dad8478mr65183855e9.12.1721038446101; 
 Mon, 15 Jul 2024 03:14:06 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f27a265sm114293605e9.28.2024.07.15.03.14.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 03:14:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>, John Clark <inindev@gmail.com>,
 Shantur Rathore <i@shantur.com>, Stefan Roese <sr@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 08/13] bootstd: Tidy up comments on the boothmeth drivers
Date: Mon, 15 Jul 2024 11:13:49 +0100
Message-Id: <20240715101354.97895-9-sjg@chromium.org>
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

Fix a typo in the comment and add one to the EFI driver too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

