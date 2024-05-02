Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4032CC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D39888C19;
	Thu,  2 May 2024 03:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WCHelIfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8948C88C0A; Thu,  2 May 2024 03:32:02 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2427D88BF7
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43ca8e1f990so4008341cf.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613518; x=1715218318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5nYhvykwUDA1gRqecrFWRgbCvmpSfWJckgr853e65eY=;
 b=WCHelIfo20ZTUFDJ6vw7bX1NCkzoF6BXf0egV7OCVMvvxJ3jAMqTdAZt6w9SrisC8u
 eRfHF+uNgDPRCN9PhizpntSubZM9r+KmCTGxnNmRdZ7jCCU7HFxEhqJPtC5vd+FPYFo3
 /c7hJ8W1JoPsSLh+4c8l5goftI5Kbicf9Jm4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613518; x=1715218318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nYhvykwUDA1gRqecrFWRgbCvmpSfWJckgr853e65eY=;
 b=AjFCCtftOM0uHyM498rRdE461FFqWrYsYtrSUvGdsPMJXEn/iNOFBrBvojaMWTtGUU
 iKWC58VlM6F+zBwJGB2E1eOGNl009hOJpvvWjo2XsSpSvnolE/xbjyRI667dfosNPtir
 g9yrymmC0hjO6x2Ql71MQPAwMFkPx+7hcqtaxLiO/2q8JWz0ZTvoGlsq/uYALz+sDFGQ
 yz0xxRyNhQat0o88uPvDNek5QLvWCUJh4VZOlSyQ2/aSlpfGvwyoDV+7Vp1UvhfWFENp
 p2GbxudX2ZETHFvqye5zRyqMRvc9F5xyOKjoCJIrUnDlpRNaOwqKp+gFzQ/0+pk3hxZ+
 SM7Q==
X-Gm-Message-State: AOJu0YzPrvEm/7sC8lYIylSp3lBQxnvWcDQ0nZZFOZ9plN25OVz5XZru
 ZeNB7lTjdB4vvAlq/vF2dZY7tObutlv7sPt1fBkQ/EyNL+qe9j0eGjanILimv8odqyvmez8fvHr
 4zD/X9QjR
X-Google-Smtp-Source: AGHT+IEORc54W6wNeitI3mm1uPn+XCrn0dfKSDLr8BFQeAAjbz5H19elo9VqzvZSih+Oy8a19++2Fg==
X-Received: by 2002:a05:622a:124f:b0:43a:e2da:136a with SMTP id
 z15-20020a05622a124f00b0043ae2da136amr2550457qtx.26.1714613518542; 
 Wed, 01 May 2024 18:31:58 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tobias Waldekranz <tobias@waldekranz.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng@tinylab.org>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 14/81] block: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:31 -0600
Message-Id: <20240502013138.2383421-14-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Bin Meng <bmeng@tinylab.org>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/block/blk-uclass.c       | 1 -
 drivers/block/blk_legacy.c       | 1 -
 drivers/block/blkcache.c         | 1 -
 drivers/block/blkmap.c           | 1 -
 drivers/block/efi-media-uclass.c | 1 -
 drivers/block/efi_blk.c          | 1 -
 drivers/block/host-uclass.c      | 1 -
 drivers/block/host_dev.c         | 1 -
 drivers/block/ide.c              | 1 -
 drivers/block/sandbox.c          | 1 -
 drivers/block/sb_efi_media.c     | 1 -
 11 files changed, 11 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 77066da352a3..512c952f4d7a 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_BLK
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/block/blk_legacy.c b/drivers/block/blk_legacy.c
index 5bf1d0471524..f36932183d1f 100644
--- a/drivers/block/blk_legacy.c
+++ b/drivers/block/blk_legacy.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <part.h>
 #include <linux/err.h>
diff --git a/drivers/block/blkcache.c b/drivers/block/blkcache.c
index 26bcbea43533..0e69160249c7 100644
--- a/drivers/block/blkcache.c
+++ b/drivers/block/blkcache.c
@@ -4,7 +4,6 @@
  * Author: Eric Nelson<eric@nelint.com>
  *
  */
-#include <common.h>
 #include <blk.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 21201409ed4b..34eed1380dca 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -4,7 +4,6 @@
  * Author: Tobias Waldekranz <tobias@waldekranz.com>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <blkmap.h>
 #include <dm.h>
diff --git a/drivers/block/efi-media-uclass.c b/drivers/block/efi-media-uclass.c
index e012f6f2f4c4..dc5e4f59b7f3 100644
--- a/drivers/block/efi-media-uclass.c
+++ b/drivers/block/efi-media-uclass.c
@@ -5,7 +5,6 @@
  * Copyright 2021 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 
 UCLASS_DRIVER(efi_media) = {
diff --git a/drivers/block/efi_blk.c b/drivers/block/efi_blk.c
index 917a19f60254..9766cd6f8327 100644
--- a/drivers/block/efi_blk.c
+++ b/drivers/block/efi_blk.c
@@ -8,7 +8,6 @@
  * Copyright 2021 Google LLC
  */
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <efi.h>
diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
index b3647e3ce335..cf42bd1e07ac 100644
--- a/drivers/block/host-uclass.c
+++ b/drivers/block/host-uclass.c
@@ -9,7 +9,6 @@
 
 #define LOG_CATEGORY UCLASS_HOST
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/drivers/block/host_dev.c b/drivers/block/host_dev.c
index 52313435a0cb..b3ff3cd1fab9 100644
--- a/drivers/block/host_dev.c
+++ b/drivers/block/host_dev.c
@@ -9,7 +9,6 @@
 
 #define LOG_CATEGORY UCLASS_HOST
 
-#include <common.h>
 #include <blk.h>
 #include <bootdev.h>
 #include <dm.h>
diff --git a/drivers/block/ide.c b/drivers/block/ide.c
index c698f9cbd558..b16623d7a3ab 100644
--- a/drivers/block/ide.c
+++ b/drivers/block/ide.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_IDE
 
-#include <common.h>
 #include <ata.h>
 #include <blk.h>
 #include <bootdev.h>
diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
index be4e02cb601a..ec34f1ad8c2e 100644
--- a/drivers/block/sandbox.c
+++ b/drivers/block/sandbox.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013 Henrik Nordstrom <henrik@henriknordstrom.net>
  */
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <fdtdec.h>
diff --git a/drivers/block/sb_efi_media.c b/drivers/block/sb_efi_media.c
index 52af155a6001..3255db064961 100644
--- a/drivers/block/sb_efi_media.c
+++ b/drivers/block/sb_efi_media.c
@@ -5,7 +5,6 @@
  * Copyright 2021 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 
 static const struct udevice_id sandbox_efi_media_ids[] = {
-- 
2.34.1

