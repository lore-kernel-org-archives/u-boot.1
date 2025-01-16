Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC247C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54F1680748;
	Thu, 16 Jan 2025 02:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UC8OnSAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2D780214; Thu, 16 Jan 2025 02:27:59 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F13DB80753
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-84a012f7232so53596539f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990875; x=1737595675; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVEZDW0JnW+FGT8jli1Cnf0eex89SlWZDrw2xhqky88=;
 b=UC8OnSAc2XSIC3jnnACBaiWcsfFkbxHWVAuEgs+/fpMsk2LQ3AX3u8AkjKkyr0mnG+
 vx4UGHk4nUECCMeWm2jFCWgs3+J15/iHTfOh6upRoykly1vhJngXJEBL3TbCV59+PxEU
 Qtw9sERZyBDMu7ves4A/BP+FD5CoevcRBPWaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990875; x=1737595675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVEZDW0JnW+FGT8jli1Cnf0eex89SlWZDrw2xhqky88=;
 b=GmKuYF5aRmWdOEADzPRqWMYmY9h390s7Wh9Ah8iMFExApqZmM6yqNaPxMpD7DlI++4
 aZoeT8HANm65xdi3Tk4Crs0gmxLAipaNYZ5PZrfSRgDE2ObL/N79JkpfGjwi61L/BPs6
 405x5k4kyZm0KvhdZEZaALJOJ7xv3uRfnrRPL/6yo0yNKQ8T8pkALCbf+LhIbHIzVWLZ
 SNvbbdsrLof00gkzCFCD9bu70Nk425ae94WKvjJ3bmMfsA8geEryel6GR1AmH2dc2pyH
 obVzE0IgZQHXUO9lB1z+wi7nRBafVjzgqZ2q77B8k3Yg9hwRqUzC4LMoi8EYL15UVq0+
 hlNw==
X-Gm-Message-State: AOJu0YxA98Lic24cJQGD/IO4Bhbc/nQCw2kFVbcGCvpgNVbmz/hC6Zvl
 9hdukhtf917wdNL1F9zE9ZB9FuG9rdE0mHOwxP6hHL+gA1cTQojzeAT8qoMlZnYj4tep0nVBuEU
 =
X-Gm-Gg: ASbGncvEoNIbwNghTB+qnfBGdCePZRpyRle2R+pMqB1FYho9GbDvBgyAADlV994ZaTv
 ToV6qenobYoPnEavEDCJrYyVDwU/KG9e1eQTyvqce1LexBgsmyK2zUi5LwXOBsyHmvd1Qv2giJ0
 PtPcISUyfhuRsQQYq5aWeETWSXORMpkq+Ze3k4GAtOlWq/AqR057kwYl6Cc9DNaX7TOHneuRvF4
 bCXB1J4xt7ZiTUsh37JU0Vs6Ziq3fLaZ5Pe28DhwHOYw7RaYDMxZ/rC9ILaDubNCovM4rLbZ/N/
 jdHntbd2uJT4wa9j9g==
X-Google-Smtp-Source: AGHT+IEoyoywnk53ySEuJPZwxQoVqoyLAsRyNUcp9LxWmRoZiBF+KmMHJmbVrERGdj+j/4nDmq7g+A==
X-Received: by 2002:a05:6e02:190c:b0:3ce:7b33:8c3b with SMTP id
 e9e14a558f8ab-3ce849de894mr49615815ab.5.1736990874761; 
 Wed, 15 Jan 2025 17:27:54 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:27:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 07/22] vbe: Move reading the version into the common file
Date: Wed, 15 Jan 2025 18:27:08 -0700
Message-Id: <20250116012723.2820301-8-sjg@chromium.org>
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

All VBE methods read a version string, so move this function into a
common file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split patch into several pieces
- Reduce inclusion of headers to only those necessary

 boot/vbe_common.c | 29 +++++++++++++++++++++++++++--
 boot/vbe_common.h | 17 +++++++++++++++++
 boot/vbe_simple.c | 30 ++----------------------------
 3 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index ede452ba306..8bbcc37e67e 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -6,8 +6,9 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <part.h>
-#include <vsprintf.h>
+#include <blk.h>
+#include <memalign.h>
+#include <spl.h>
 #include "vbe_common.h"
 
 int vbe_get_blk(const char *storage, struct udevice **blkp)
@@ -34,3 +35,27 @@ int vbe_get_blk(const char *storage, struct udevice **blkp)
 
 	return 0;
 }
+
+int vbe_read_version(struct udevice *blk, ulong offset, char *version,
+		     int max_size)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
+
+	/* we can use an assert() here since we already read only one block */
+	assert(max_size <= MMC_MAX_BLOCK_LEN);
+
+	/*
+	 * we can use an assert() here since reading the wrong block will just
+	 * cause an invalid version-string to be (safely) read
+	 */
+	assert(!(offset & (MMC_MAX_BLOCK_LEN - 1)));
+
+	offset /= MMC_MAX_BLOCK_LEN;
+
+	if (blk_read(blk, offset, 1, buf) != 1)
+		return log_msg_ret("read", -EIO);
+	strlcpy(version, buf, max_size);
+	log_debug("version=%s\n", version);
+
+	return 0;
+}
diff --git a/boot/vbe_common.h b/boot/vbe_common.h
index 0cd9617b5b1..a122bead93e 100644
--- a/boot/vbe_common.h
+++ b/boot/vbe_common.h
@@ -61,4 +61,21 @@ struct vbe_nvdata {
  */
 int vbe_get_blk(const char *storage, struct udevice **blkp);
 
+/**
+ * vbe_read_version() - Read version-string from a block device
+ *
+ * Reads the VBE version-string from a device. This function reads a single
+ * block from the device, so the string cannot be larger than that. It uses a
+ * temporary buffer for the read, then copies in up to @size bytes
+ *
+ * @blk: Device to read from
+ * @offset: Offset to read, in bytes
+ * @version: Place to put the string
+ * @max_size: Maximum size of @version
+ * Return: 0 if OK, -E2BIG if @max_size > block size, -EBADF if the offset is
+ * not block-aligned, -EIO if an I/O error occurred
+ */
+int vbe_read_version(struct udevice *blk, ulong offset, char *version,
+		     int max_size);
+
 #endif /* __VBE_ABREC_H */
diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index ee51804e02d..ce385065321 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -21,33 +21,6 @@
 #include <u-boot/crc.h>
 #include "vbe_simple.h"
 
-static int simple_read_version(const struct simple_priv *priv,
-			       struct udevice *blk, u8 *buf,
-			       struct simple_state *state)
-{
-	int start;
-
-	/* we can use an assert() here since we already read only one block */
-	assert(priv->version_size <= MMC_MAX_BLOCK_LEN);
-
-	start = priv->area_start + priv->version_offset;
-
-	/*
-	 * we can use an assert() here since reading the wrong block will just
-	 * cause an invalid version-string to be (safely) read
-	 */
-	assert(!(start & (MMC_MAX_BLOCK_LEN - 1)));
-
-	start /= MMC_MAX_BLOCK_LEN;
-
-	if (blk_read(blk, start, 1, buf) != 1)
-		return log_msg_ret("read", -EIO);
-	strlcpy(state->fw_version, buf, MAX_VERSION_LEN);
-	log_debug("version=%s\n", state->fw_version);
-
-	return 0;
-}
-
 static int simple_read_nvdata(const struct simple_priv *priv,
 			      struct udevice *blk, u8 *buf,
 			      struct simple_state *state)
@@ -105,7 +78,8 @@ int vbe_simple_read_state(struct udevice *dev, struct simple_state *state)
 	if (ret)
 		return log_msg_ret("blk", ret);
 
-	ret = simple_read_version(priv, blk, buf, state);
+	ret = vbe_read_version(blk, priv->area_start + priv->version_offset,
+			       state->fw_version, MAX_VERSION_LEN);
 	if (ret)
 		return log_msg_ret("ver", ret);
 
-- 
2.34.1

