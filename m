Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC762CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419D3848BB;
	Wed, 27 May 2026 18:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Md9QwL50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6610D848BC; Wed, 27 May 2026 18:11:28 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C08848A2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e615b4c2a7so1304621a34.2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898285; x=1780503085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbgqnXpUogYkFpoEpGUyK96gKCJuaeQNEUiLpJNmg+s=;
 b=Md9QwL50m2260IhAQZ891jJGRvC5A0mFxOdno22DpXvtgbFfQAkLWKigmn9PYddLlT
 PboYWdbKbK/BkgatNzkgKOouYjyzpGfntRmi64uf698p2CQP3rFahvZGAYP0rql8CADO
 t5ahsVC3XGa8hCA/0jQDRd5RGtONIvfB2lmtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898285; x=1780503085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HbgqnXpUogYkFpoEpGUyK96gKCJuaeQNEUiLpJNmg+s=;
 b=gBN0N9pVHxDyS5nwfhW6TY8MPv+U8nImv6bC9vIK+NneVpWv7wftwz/f5B0O+TvUoR
 8HiEhpxa3HI01X+td6p7yPG5vUmv/g78cPQ7lGy4Ifm56JsqPYf9QQHhiNZjI1dh6L4t
 VrjcWSXTkI1RPfYe1O+rNwa8n+0e4aGGgwcd049lTT6KnSd/HebfuLuFdQ3TPAjy0oKQ
 mYYiGAc+Bd8xVsDiqJweH35NxS0FU8g+TvYaUWjm+K7VNwOvDLbO35ytsWxrNlxzz1GP
 4wsCMsXW4uLQzVlmHNaDDDcMxzrstmy9kzP7MmYVibyP2q1zEmLLTVw+xGO7tMvyL55C
 c9pQ==
X-Gm-Message-State: AOJu0YzLavSUZb4x8H5ShR6dmBIrDi55Ve84d1ePP1hItJqJ3IJ+icPr
 eC23herxBuCrWmxwHNFTNa11gwky98M1hqXoaJSms3qf2paL36vpZ7Z9HqrfUuQmSMFbUosVdAa
 esxChwOOPBX0PnQ==
X-Gm-Gg: Acq92OHXnD9tpEoQqbQfAqvAtGmeNWYE4Btso4tWKuBGIvdMWvsr97spL1eCOgWpT3o
 QkaeZfNBQOfJ6h5x9tMdE9PkSiP5y6HlzORjYJ3JyUpLCg/q1BrRGSUNiulDbgADPCbHYwlZZoS
 llR9ckJe2R2/FPkgOLDcRNRbRiBSCJHweWWVeea3gkb4DzRpiiDn3oXx99e6nOFtYPqeOCcb6UK
 L63j98oOoh3fr6M3+HfOa7ychUaJvBBSmOesklU+O4dX+A7nwrdR/HzS+5fsq1T7WwxUc+2p6X3
 DuOFYfyCats4EQ5h++vKyQHdviHpHFeLywf4uGWAD0xLTK6hTUoO+XuSPAkmrOnDZPg2vy2vKRt
 oACYdu+EgT8NzsiOuAhz7OS1iSEFwxpRxOSNEbu+rUByRUUhJAm7ULK+ZWYO6p9pp4FtdtzFPOs
 O+ttbnIL28+pYUgRx/qQ8vQiRPWQHD
X-Received: by 2002:a05:6830:418b:b0:7e6:7dc7:4542 with SMTP id
 46e09a7af769-7e67dc747eemr1059402a34.16.1779898285075; 
 Wed, 27 May 2026 09:11:25 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Christian Speich <c.speich@avm.de>, Daniel Palmer <daniel@thingy.jp>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/13] virtio: Set the log-category for all drivers
Date: Wed, 27 May 2026 10:10:20 -0600
Message-ID: <20260527161033.3273795-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161033.3273795-1-sjg@chromium.org>
References: <20260527161033.3273795-1-sjg@chromium.org>
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

Most drivers have the log-category set but not all. Fill this in for
the rest.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/virtio/virtio_mmio.c       | 2 ++
 drivers/virtio/virtio_net.c        | 2 ++
 drivers/virtio/virtio_pci_legacy.c | 2 ++
 drivers/virtio/virtio_pci_modern.c | 2 ++
 drivers/virtio/virtio_ring.c       | 2 ++
 drivers/virtio/virtio_sandbox.c    | 2 ++
 6 files changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index e66b8d244fb..496d26b4dd4 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -7,6 +7,8 @@
  * Ported from Linux drivers/virtio/virtio_mmio.c
  */
 
+#define LOG_CATEGORY	UCLASS_VIRTIO
+
 #include <dm.h>
 #include <log.h>
 #include <virtio_types.h>
diff --git a/drivers/virtio/virtio_net.c b/drivers/virtio/virtio_net.c
index 71e4d251396..7a94c8a528f 100644
--- a/drivers/virtio/virtio_net.c
+++ b/drivers/virtio/virtio_net.c
@@ -4,6 +4,8 @@
  * Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
  */
 
+#define LOG_CATEGORY	UCLASS_VIRTIO
+
 #include <dm.h>
 #include <net.h>
 #include <virtio_types.h>
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index fe3e3b475ea..4713c12e7ac 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -6,6 +6,8 @@
  * Ported from Linux drivers/virtio/virtio_pci*.c
  */
 
+#define LOG_CATEGORY	UCLASS_VIRTIO
+
 #include <dm.h>
 #include <log.h>
 #include <virtio_types.h>
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5850e0c18c6..4ce68920c6d 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -6,6 +6,8 @@
  * Ported from Linux drivers/virtio/virtio_pci*.c
  */
 
+#define LOG_CATEGORY	UCLASS_VIRTIO
+
 #include <dm.h>
 #include <log.h>
 #include <virtio_types.h>
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3a40b12f6e5..17e351ca2be 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -6,6 +6,8 @@
  * virtio ring implementation
  */
 
+#define LOG_CATEGORY	UCLASS_VIRTIO
+
 #include <bouncebuf.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/virtio/virtio_sandbox.c b/drivers/virtio/virtio_sandbox.c
index 0f1ebef22e5..6767e5bd5fe 100644
--- a/drivers/virtio/virtio_sandbox.c
+++ b/drivers/virtio/virtio_sandbox.c
@@ -5,6 +5,8 @@
  * VirtIO Sandbox transport driver, for testing purpose only
  */
 
+#define LOG_CATEGORY	UCLASS_VIRTIO
+
 #include <dm.h>
 #include <virtio_types.h>
 #include <virtio.h>
-- 
2.43.0

