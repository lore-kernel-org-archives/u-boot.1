Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47785C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7221788CC6;
	Thu,  2 May 2024 03:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iP/txviJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A4088CC6; Thu,  2 May 2024 03:34:14 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D835F88CB7
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43969307359so46367011cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613649; x=1715218449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJ/Z6eBTIY7RW9NwWXZPQAN8HsfMuHWq4qYQKS67W/8=;
 b=iP/txviJCe8P/uGRQqbx1FkYmEHKwBrnD2yUkMi4Benp/B0oRWSYztkaD8t1ru6D4m
 6RLx1Y8psww74QW9QVHeAXenE2DEKYBay2lIyHsmZA8hda5K7UGgJnyzy6YMAmX9LtdH
 /Y0o9opgcbAOhjvPBj9i8fOrcSQyMLdnaeuv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613649; x=1715218449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OJ/Z6eBTIY7RW9NwWXZPQAN8HsfMuHWq4qYQKS67W/8=;
 b=RIKWX6AI8c2zoY8MYDrr0TY6z6CCpaaDOOLxy7g4B5rrnAo5QNX8GFmuXTwTpIeqG6
 XWRLVJ9shDf9BaB0Z8So4izUvFDoHhI4GvApblJ4YlCE1suBfa2459oBHiXfcYePd/do
 CyL6HDFBd0URpVtg37+ZDhU8Y2z20CePSTM5nx6mmPuQnEZdFuEsrRPx9Pk5z6QIBZ37
 Y+VdYGWKn4hY2evT99i+luKCPoZG/yMOV0wXC0ddvbyU8fhJ7FjGlFGs+7fR9QsxNXlT
 tnxF0gSMnD7VytQsdJ2+I+7iltlEBiezgt4O348YBxYyE0jmyRtlV084ESPiF2/qn2z4
 SE2Q==
X-Gm-Message-State: AOJu0YypjiO/IM8Tlf25CMV6jDzdtTwUlLB2jgfAuBvbOZZsugyNYup3
 14M5mNTdz0tkxXWlrmkvHwA3EPGBIInInI82eTpjvvqirmAyOpMH2SNsyDhI4RTJTtv5LZ7JQbz
 98RPVe/S0
X-Google-Smtp-Source: AGHT+IFnqlUrHweCASEQrrpRvyVUriFo1NkvrJIS9eW3NDYlR1ieTeHL16wegO1k820ukfdZYHdR1w==
X-Received: by 2002:a05:622a:4e07:b0:43a:d12b:43ea with SMTP id
 dh7-20020a05622a4e0700b0043ad12b43eamr4893828qtb.54.1714613649597; 
 Wed, 01 May 2024 18:34:09 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:34:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 75/81] virtio: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:32 -0600
Message-Id: <20240502013138.2383421-75-trini@konsulko.com>
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
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/virtio/virtio-uclass.c     | 1 -
 drivers/virtio/virtio_blk.c        | 1 -
 drivers/virtio/virtio_mmio.c       | 1 -
 drivers/virtio/virtio_net.c        | 1 -
 drivers/virtio/virtio_pci_legacy.c | 1 -
 drivers/virtio/virtio_pci_modern.c | 1 -
 drivers/virtio/virtio_ring.c       | 1 -
 drivers/virtio/virtio_rng.c        | 1 -
 drivers/virtio/virtio_sandbox.c    | 1 -
 include/virtio.h                   | 1 +
 10 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c54201627352..1dbc1a56aa21 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -17,7 +17,6 @@
 
 #define LOG_CATEGORY UCLASS_VIRTIO
 
-#include <common.h>
 #include <bootdev.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 95810582867c..3404f61eba5f 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_VIRTIO
 
-#include <common.h>
 #include <blk.h>
 #include <dm.h>
 #include <part.h>
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 78c15c821b4e..1cd737aca249 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -7,7 +7,6 @@
  * Ported from Linux drivers/virtio/virtio_mmio.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <virtio_types.h>
diff --git a/drivers/virtio/virtio_net.c b/drivers/virtio/virtio_net.c
index 1794f73a8de8..0e5367a085e4 100644
--- a/drivers/virtio/virtio_net.c
+++ b/drivers/virtio/virtio_net.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <net.h>
 #include <virtio_types.h>
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index aa89604ae84d..15f8c6e7d257 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -6,7 +6,6 @@
  * Ported from Linux drivers/virtio/virtio_pci*.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <virtio_types.h>
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 3cdc2d2d6fd3..5850e0c18c69 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -6,7 +6,6 @@
  * Ported from Linux drivers/virtio/virtio_pci*.c
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <virtio_types.h>
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c9adcce5c09b..306fa5b3f681 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -7,7 +7,6 @@
  */
 
 #include <bouncebuf.h>
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/virtio/virtio_rng.c b/drivers/virtio/virtio_rng.c
index 786359a6e364..90a371a59cc7 100644
--- a/drivers/virtio/virtio_rng.c
+++ b/drivers/virtio/virtio_rng.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2019, Linaro Limited
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <rng.h>
diff --git a/drivers/virtio/virtio_sandbox.c b/drivers/virtio/virtio_sandbox.c
index b34f1d60455e..0f1ebef22e58 100644
--- a/drivers/virtio/virtio_sandbox.c
+++ b/drivers/virtio/virtio_sandbox.c
@@ -5,7 +5,6 @@
  * VirtIO Sandbox transport driver, for testing purpose only
  */
 
-#include <common.h>
 #include <dm.h>
 #include <virtio_types.h>
 #include <virtio.h>
diff --git a/include/virtio.h b/include/virtio.h
index 062a24630ce9..1ab0ec5f39f5 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -23,6 +23,7 @@
 #include <virtio_types.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
+#include <linux/typecheck.h>
 #define VIRTIO_ID_NET		1 /* virtio net */
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_RNG		4 /* virtio rng */
-- 
2.34.1

