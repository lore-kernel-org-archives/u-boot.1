Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC69CD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A98784886;
	Wed, 27 May 2026 18:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OYe1ZOUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF6B8487C; Wed, 27 May 2026 18:11:19 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3303984837
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e55b95ba13so6203397a34.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898276; x=1780503076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GppCdaoI6bmfyEiV/EtjxxQs1w/J9r57YkUfk/UfLqQ=;
 b=OYe1ZOUK8LS4IMHmFQ/JdtiYXkfaJ6NcmZ2Pa5SSctE74ba021UO/naHYPIAo7K53b
 WNlRQ3D10jJ9fB+Rri6R8FC97iwPCoZydQabGHEUisfTsYHmSWRJES1fF3LZXz3Dpt2U
 bxacG5wGPHqyOTJv+Ap0V17pLXUwdnL0Ye/9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898276; x=1780503076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GppCdaoI6bmfyEiV/EtjxxQs1w/J9r57YkUfk/UfLqQ=;
 b=tVvBibPO/AiLAwH8UdlBnMjz0IX3GW/wappLgIUC7snVKekM8QT0+4A5haIwU5SbWe
 Cl1RMmxkxIepm6866RP1GhbQJo3Jv4QflaGX9+ReLJtyp90o+uXILOfQP7d8ukI8StNY
 UXtQsP3u2f8YXhieo1OEx6na9a4mKWoJaOFdVV/ylSYz9UsWLcZN92qdg5YW5UkBhsGT
 DgWgiUmNHFelZXrYABv2ZOjcWIfLCOkFyqikTUM3QmGlohPla2dMHMpsMOnwzaww8vwh
 pn8ycXPitpGZmsyEV7qmxutuQ6d5yf3X62pAQyPlHBdHIWgSf/BVkKm8HigWCur49lrn
 B4KA==
X-Gm-Message-State: AOJu0YwQLeJ5uAi03MGz4A1+jpVntgraqdoAAirV0l+yF38CPOlzqlun
 AmwT7uu1IBJD4bN2vW7/KRn2Iv0K/mUkclPatZbQOhc63Qz385WxpmhcdtHa5fc6PASDD74ugFK
 flpTUfQGPQLg1TA==
X-Gm-Gg: Acq92OHobkcoVHaxqH45QzWYvvH/v2ILayio2O96xuIXAbnOVcM+0K1IYNODiJMrTpp
 ywfmgYlta+WHObFBhTA1aqk5Y/6Hvz1aaDez/511nysUU5CAoa8hhLeezJQwdVPpWzQmzeseRGN
 KL9dlUKHZaT/gw6b4GetdULkSouHc8yhkgL5lDr7FwRhOH9/axaJVvUOQ/2WJPjajg4ukgPsiK7
 909S+fm4qWJTA330nZ0c7+l5pbBlY1Vx7D4aIo6J4rCgPTuCwm1FnUCXXZGsl/CiGNx1Vn1Uf+I
 L76uN5IyeB0in5t/NzRhMULdPY/2oBz+nnh0mpMhjfpihxAv9btxbabOH5HO3ygzYpzok9ZvYXK
 nca82t3cSksqonFZm8LX27W7tZmEr1DDDycHFP6Tz9im2SJlmVa1hU9Rw/wVrWVXv/zOt0lqzsP
 CmjRP39rr4IeTuOe5hH711AmXaB4ZV
X-Received: by 2002:a05:6830:6ab0:b0:7dc:a6f8:e3be with SMTP id
 46e09a7af769-7e5fefea143mr14558383a34.26.1779898275885; 
 Wed, 27 May 2026 09:11:15 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Palmer <daniel@thingy.jp>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/13] virtio: Export a few things from virtio_mmio.c
Date: Wed, 27 May 2026 10:10:15 -0600
Message-ID: <20260527161033.3273795-6-sjg@chromium.org>
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

Add a header file to allow other drivers to implement MMIO and share the
code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/virtio/virtio_internal.h | 19 +++++++++++++++++++
 drivers/virtio/virtio_mmio.c     |  7 ++++---
 2 files changed, 23 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virtio/virtio_internal.h

diff --git a/drivers/virtio/virtio_internal.h b/drivers/virtio/virtio_internal.h
new file mode 100644
index 00000000000..96b6bffbe54
--- /dev/null
+++ b/drivers/virtio/virtio_internal.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Internal header file for virtio
+ *
+ * Copyright 2025 Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef _VIRTIO_INTERNAL_H
+#define _VIRTIO_INTERNAL_H
+
+struct udevice;
+
+/* MMIO operations from virtio_mmcio.c */
+extern const struct dm_virtio_ops virtio_mmio_ops;
+
+/* exported probe function from virtio_mmcio.c */
+int virtio_mmio_probe(struct udevice *udev);
+
+#endif
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 975f98cd9e5..e66b8d244fb 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -349,7 +349,7 @@ static int virtio_mmio_of_to_plat(struct udevice *udev)
 	return 0;
 }
 
-static int virtio_mmio_probe(struct udevice *udev)
+int virtio_mmio_probe(struct udevice *udev)
 {
 	struct virtio_mmio_plat *plat = dev_get_plat(udev);
 	struct virtio_mmio_priv *priv = dev_get_priv(udev);
@@ -359,6 +359,7 @@ static int virtio_mmio_probe(struct udevice *udev)
 	priv->base = (void __iomem *)(uintptr_t)plat->base;
 
 	/* Check magic value */
+	log_debug("probe %p\n", priv->base);
 	magic = readl(priv->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		debug("(%s): wrong magic value 0x%08x!\n", udev->name, magic);
@@ -387,13 +388,13 @@ static int virtio_mmio_probe(struct udevice *udev)
 	if (priv->version == 1)
 		writel(PAGE_SIZE, priv->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
 
-	debug("(%s): device (%d) vendor (%08x) version (%d)\n", udev->name,
+	debug("(%s): device (%04x) vendor (%04x) version (%d)\n", udev->name,
 	      uc_priv->device, uc_priv->vendor, priv->version);
 
 	return 0;
 }
 
-static const struct dm_virtio_ops virtio_mmio_ops = {
+const struct dm_virtio_ops virtio_mmio_ops = {
 	.get_config	= virtio_mmio_get_config,
 	.set_config	= virtio_mmio_set_config,
 	.generation	= virtio_mmio_generation,
-- 
2.43.0

