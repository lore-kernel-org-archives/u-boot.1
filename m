Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F8CC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8830980708;
	Thu, 16 Jan 2025 02:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W6ynluuE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECDBF80214; Thu, 16 Jan 2025 02:27:55 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16EB80762
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3ce915a8a25so1380075ab.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990872; x=1737595672; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0uT+R87MnjtaOa7ts0wx/f0ARlwnPcoI7UpEzhwheA=;
 b=W6ynluuEMbXzMKJluKjBOpckVH0+u9IrGvc8iWKo27wzBQ58F6J0v7IrwpdxnZPlGi
 7x/OH1usgbJpscUQ64gigt+FE6who2QV6J0QN8M5Q5YCyiDcA3+nFGGl9VWTG4Kp063u
 gKg+nCeCVNctecy7fjrvt+oojycdM9Zl+DXzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990872; x=1737595672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E0uT+R87MnjtaOa7ts0wx/f0ARlwnPcoI7UpEzhwheA=;
 b=iIdyDA0bxVxdsq288Dc8zsluzSdO9dcFOarfeX8+dY1IUaFZLuFhe5nTNLKMh7H7rk
 fk2tfUKpVBDo+wdPwZAt4reGEfPwdZZlHBGsGdvZuU5PqKbetLaIHyVJT8ZrhC6M5NKg
 RPhD2T9Ce7/x7AJNPWXFWAOCbm8IU88r6dCf/fGILKu+J3Ga9IpGJyhlrgQj8uLl0eEY
 rooQFBzF/uN4zcRr6wa6/zdRBVCSuBMV1YjU76edXfnLv2g6Lk7HUa9fEh1B6qQTK/uY
 W9FJawywMAebBEQL65CvAHJOc9gBAdpvSqxn7gzJDX+xRhdadmzv7reo0XOxE4WmOYOc
 UQwA==
X-Gm-Message-State: AOJu0YwFFVrQ7gena8pfUG2c8YL0QuNTMN57eZZ26Q4PWKA0ZUDsx5eR
 rbl2mLxcW15XxXGiCux3yIypqQhURMqs3L0LZ3Z5lcgzcNvtJ8ZzT5fEFP5eo/Uc276NWYJ2RXU
 =
X-Gm-Gg: ASbGncsxgd9YKQGor6h6qiEj0DWfLmf+qdfgZXIqex6Hy6LB5bDlVCbwGf1V0pf7gZI
 C4Toj5lrWUejW3YR8nxQUtvu0op/zfq8xjmH9xX3yoPX+l0Jp++f7kahGzDGk4OMQvXjenr41LU
 rPTmMo3YvAHoe3p97CnrjowddhAjed5Fl69+6Lzog2+/Q4lhaEec86r8l+4aqMqnp5agjrW0VAV
 KFWzWgitmEQ8P8s9PyARRIyYAGbJmHk6fup+KFV8O6qJG4/9YX9PH92R2awhWyZC4/AqUAKHum4
 fZ8cxe2uhCqJ7dkz3g==
X-Google-Smtp-Source: AGHT+IHVnTf+lAN4aQa1a1CilX/hrFTWqE/bf/q9WQ1xgYu+uINuYKG0mhmgjcFhJTS9vJ4+aSeJCw==
X-Received: by 2002:a05:6e02:3984:b0:3ce:874d:f7ef with SMTP id
 e9e14a558f8ab-3ce874df891mr48055085ab.22.1736990871895; 
 Wed, 15 Jan 2025 17:27:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:27:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 06/22] vbe: Create a common function to get the block device
Date: Wed, 15 Jan 2025 18:27:07 -0700
Message-Id: <20250116012723.2820301-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250116012723.2820301-1-sjg@chromium.org>
References: <20250116012723.2820301-1-sjg@chromium.org>
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

Add a vbe_get_blk() function and use it to obtain the block device used
by VBE.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split patch into several pieces

 boot/Makefile     |  2 +-
 boot/vbe_common.c | 36 ++++++++++++++++++++++++++++++++++++
 boot/vbe_common.h | 13 +++++++++++++
 boot/vbe_simple.c | 23 ++++-------------------
 4 files changed, 54 insertions(+), 20 deletions(-)
 create mode 100644 boot/vbe_common.c

diff --git a/boot/Makefile b/boot/Makefile
index 9446c6b82a9..30529bac367 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -66,7 +66,7 @@ endif
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE) += vbe.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_REQUEST) += vbe_request.o
-obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE) += vbe_simple.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE) += vbe_simple.o vbe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_FW) += vbe_simple_fw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 
diff --git a/boot/vbe_common.c b/boot/vbe_common.c
new file mode 100644
index 00000000000..ede452ba306
--- /dev/null
+++ b/boot/vbe_common.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verified Boot for Embedded (VBE) common functions
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <part.h>
+#include <vsprintf.h>
+#include "vbe_common.h"
+
+int vbe_get_blk(const char *storage, struct udevice **blkp)
+{
+	struct blk_desc *desc;
+	char devname[16];
+	const char *end;
+	int devnum;
+
+	/* First figure out the block device */
+	log_debug("storage=%s\n", storage);
+	devnum = trailing_strtoln_end(storage, NULL, &end);
+	if (devnum == -1)
+		return log_msg_ret("num", -ENODEV);
+	if (end - storage >= sizeof(devname))
+		return log_msg_ret("end", -E2BIG);
+	strlcpy(devname, storage, end - storage + 1);
+	log_debug("dev=%s, %x\n", devname, devnum);
+
+	desc = blk_get_dev(devname, devnum);
+	if (!desc)
+		return log_msg_ret("get", -ENXIO);
+	*blkp = desc->bdev;
+
+	return 0;
+}
diff --git a/boot/vbe_common.h b/boot/vbe_common.h
index 1fc70ee74c8..0cd9617b5b1 100644
--- a/boot/vbe_common.h
+++ b/boot/vbe_common.h
@@ -48,4 +48,17 @@ struct vbe_nvdata {
 	u8 spare2[0x34];
 };
 
+/**
+ * vbe_get_blk() - Obtain the block device to use for VBE
+ *
+ * Decodes the string to produce a block device
+ *
+ * @storage: String indicating the device to use, e.g. "mmc1"
+ * @blkp: Returns associated block device, on success
+ * Return 0 if OK, -ENODEV if @storage does not end with a number, -E2BIG if
+ * the device name is more than 15 characters, -ENXIO if the block device could
+ * not be found
+ */
+int vbe_get_blk(const char *storage, struct udevice **blkp);
+
 #endif /* __VBE_ABREC_H */
diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index af16bdd34a3..ee51804e02d 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -98,28 +98,13 @@ int vbe_simple_read_state(struct udevice *dev, struct simple_state *state)
 {
 	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
 	struct simple_priv *priv = dev_get_priv(dev);
-	struct blk_desc *desc;
 	struct udevice *blk;
-	char devname[16];
-	const char *end;
-	int devnum;
 	int ret;
 
-	/* First figure out the block device */
-	log_debug("storage=%s\n", priv->storage);
-	devnum = trailing_strtoln_end(priv->storage, NULL, &end);
-	if (devnum == -1)
-		return log_msg_ret("num", -ENODEV);
-	if (end - priv->storage >= sizeof(devname))
-		return log_msg_ret("end", -E2BIG);
-	strlcpy(devname, priv->storage, end - priv->storage + 1);
-	log_debug("dev=%s, %x\n", devname, devnum);
-
-	desc = blk_get_dev(devname, devnum);
-	if (!desc)
-		return log_msg_ret("get", -ENXIO);
-
-	blk = desc->bdev;
+	ret = vbe_get_blk(priv->storage, &blk);
+	if (ret)
+		return log_msg_ret("blk", ret);
+
 	ret = simple_read_version(priv, blk, buf, state);
 	if (ret)
 		return log_msg_ret("ver", ret);
-- 
2.34.1

