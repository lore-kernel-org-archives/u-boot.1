Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE1EC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62A580753;
	Thu, 16 Jan 2025 02:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y0JuQIGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB51C806FE; Thu, 16 Jan 2025 02:28:01 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B0828033D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 02:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3ce886a2d5bso3244685ab.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 17:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736990877; x=1737595677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uth+3q/KOy1pJme7HaE9Aae4ZriK21QjLMjk1/CrjhI=;
 b=Y0JuQIGOMOFEkXV5WN2RFvuvGFqjDc+pGP4zRasAm9xwiXkg6ybEFZK4iC8Vwg7QkM
 s1ejlEnW7EnQOEXw7B3wCNCLwMFCI2tCP9KTqQMXl/Qf9HW68MYGuM+JruphvkyBp6Wv
 q7Nfowxs57D7eIH0T1yA5/eue/NBXw105LSVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736990877; x=1737595677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uth+3q/KOy1pJme7HaE9Aae4ZriK21QjLMjk1/CrjhI=;
 b=vlgxa4C3rvFjb/RlZDZgr5O/MerlAxaQUT3ZzGy3KhbxPVr7pISudNeo9DCfwUI41G
 YyTnkAW0RHRu0SOH5/jXqs1I+ZDt7E6klMh2sqheY+jDqjCU53v0CGGAKDQncd8TV6N3
 884bxdSZZ+kGXlw8fslVH7HaqhKxGNqMFmRND9Srrm8/SPibPEtz5/UxpxlJ2eezwc//
 OyRzUWBRsLsVzhjCOukJyNWpeI51MSosMu7CBu5eBdM/3o+mJgotX4vPkOHFRZiZSm6G
 vdlpnFqxnrb+dRGAb165smTR/vKAPFF1Fi/Z7jMK+SK3s8GI+GfHfjiESB2Kpj2yACnV
 QMpQ==
X-Gm-Message-State: AOJu0Yyw7kByTj+q5vwWW0ryMl8P5trVvd51cEvEph2iXtuRfu2eooGl
 c0pzEu77HY+H+t5AWJlaMts69CAlepayH4k20Sn/4AWBA5czRD/GXsDAEpelk2kuPb/AOHV5oCk
 =
X-Gm-Gg: ASbGncuVuZFQO2qX8L2bYpUcqg2gAgJDYxofhri0dTRpFUsLUh/LqvXxMqUMvUhGO6E
 LkkmaGVeYaqAANawL8U1+2YyIT3c2Y5jAUAze5fCxiwP2TEUCrLR3iKvnuqXggGGpPmDAdMZ7g6
 bb2Pe5x94D1K7DzXqAP7cdpb++/FReqzNi+PQcJWsChN7EHoeHvmkS3DgJ4PO+1Er4Fjf2EG9Tp
 LMITh0S1iquv4W5RCuBOOipK8j2JNq6c4qO6SoaepPKf2zKlU04YhFLabr5Tl7Cr1wBIWohrocZ
 A+KzJFoZMRvoigrZxA==
X-Google-Smtp-Source: AGHT+IH3bnsQYF4UuITg0Afy+Wy4HjX9nF1aTuY6sHO7UuET/ortdYNDi0jkVQp1I7CNTfmp/0forA==
X-Received: by 2002:a05:6e02:160e:b0:3a7:e732:471b with SMTP id
 e9e14a558f8ab-3ce3a88ace0mr250108665ab.11.1736990877505; 
 Wed, 15 Jan 2025 17:27:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3ce4add8570sm42587725ab.32.2025.01.15.17.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 17:27:56 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 08/22] vbe: Move reading the nvdata into the common file
Date: Wed, 15 Jan 2025 18:27:09 -0700
Message-Id: <20250116012723.2820301-9-sjg@chromium.org>
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

All VBE methods read non-volatile data, so move this function into a
common file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split patch into several pieces

 boot/vbe_common.c | 41 +++++++++++++++++++++++++++++++++++++++++
 boot/vbe_common.h | 16 ++++++++++++++++
 boot/vbe_simple.c | 44 ++++++++------------------------------------
 3 files changed, 65 insertions(+), 36 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 8bbcc37e67e..672878fe6fe 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -9,6 +9,7 @@
 #include <blk.h>
 #include <memalign.h>
 #include <spl.h>
+#include <u-boot/crc.h>
 #include "vbe_common.h"
 
 int vbe_get_blk(const char *storage, struct udevice **blkp)
@@ -59,3 +60,43 @@ int vbe_read_version(struct udevice *blk, ulong offset, char *version,
 
 	return 0;
 }
+
+int vbe_read_nvdata(struct udevice *blk, ulong offset, ulong size, u8 *buf)
+{
+	uint hdr_ver, hdr_size, data_size, crc;
+	const struct vbe_nvdata *nvd;
+
+	/* we can use an assert() here since we already read only one block */
+	assert(size <= MMC_MAX_BLOCK_LEN);
+
+	/*
+	 * We can use an assert() here since reading the wrong block will just
+	 * cause invalid state to be (safely) read. If the crc passes, then we
+	 * obtain invalid state and it will likely cause booting to fail.
+	 *
+	 * VBE relies on valid values being in U-Boot's devicetree, so this
+	 * should not every be wrong on a production device.
+	 */
+	assert(!(offset & (MMC_MAX_BLOCK_LEN - 1)));
+
+	if (offset & (MMC_MAX_BLOCK_LEN - 1))
+		return log_msg_ret("get", -EBADF);
+	offset /= MMC_MAX_BLOCK_LEN;
+
+	if (blk_read(blk, offset, 1, buf) != 1)
+		return log_msg_ret("read", -EIO);
+	nvd = (struct vbe_nvdata *)buf;
+	hdr_ver = (nvd->hdr & NVD_HDR_VER_MASK) >> NVD_HDR_VER_SHIFT;
+	hdr_size = (nvd->hdr & NVD_HDR_SIZE_MASK) >> NVD_HDR_SIZE_SHIFT;
+	if (hdr_ver != NVD_HDR_VER_CUR)
+		return log_msg_ret("hdr", -EPERM);
+	data_size = 1 << hdr_size;
+	if (!data_size || data_size > sizeof(*nvd))
+		return log_msg_ret("sz", -EPERM);
+
+	crc = crc8(0, buf + 1, data_size - 1);
+	if (crc != nvd->crc8)
+		return log_msg_ret("crc", -EPERM);
+
+	return 0;
+}
diff --git a/boot/vbe_common.h b/boot/vbe_common.h
index a122bead93e..37a81330325 100644
--- a/boot/vbe_common.h
+++ b/boot/vbe_common.h
@@ -78,4 +78,20 @@ int vbe_get_blk(const char *storage, struct udevice **blkp);
 int vbe_read_version(struct udevice *blk, ulong offset, char *version,
 		     int max_size);
 
+/**
+ * vbe_read_nvdata() - Read non-volatile data from a block device
+ *
+ * Reads the VBE nvdata from a device. This function reads a single block from
+ * the device, so the nvdata cannot be larger than that.
+ *
+ * @blk: Device to read from
+ * @offset: Offset to read, in bytes
+ * @size: Number of bytes to read
+ * @buf: Buffer to hold the data
+ * Return: 0 if OK, -E2BIG if @size > block size, -EBADF if the offset is not
+ * block-aligned, -EIO if an I/O error occurred, -EPERM if the header version is
+ * incorrect, the header size is invalid or the data fails its CRC check
+ */
+int vbe_read_nvdata(struct udevice *blk, ulong offset, ulong size, u8 *buf);
+
 #endif /* __VBE_ABREC_H */
diff --git a/boot/vbe_simple.c b/boot/vbe_simple.c
index ce385065321..c6766c532f2 100644
--- a/boot/vbe_simple.c
+++ b/boot/vbe_simple.c
@@ -18,48 +18,21 @@
 #include <vbe.h>
 #include <dm/device-internal.h>
 #include <dm/ofnode.h>
-#include <u-boot/crc.h>
 #include "vbe_simple.h"
 
 static int simple_read_nvdata(const struct simple_priv *priv,
-			      struct udevice *blk, u8 *buf,
-			      struct simple_state *state)
+			      struct udevice *blk, struct simple_state *state)
 {
-	uint hdr_ver, hdr_size, size, crc;
+	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
 	const struct vbe_nvdata *nvd;
-	int start;
-
-	/* we can use an assert() here since we already read only one block */
-	assert(priv->state_size <= MMC_MAX_BLOCK_LEN);
-
-	start = priv->area_start + priv->state_offset;
-
-	/*
-	 * We can use an assert() here since reading the wrong block will just
-	 * cause invalid state to be (safely) read. If the crc passes, then we
-	 * obtain invalid state and it will likely cause booting to fail.
-	 *
-	 * VBE relies on valid values being in U-Boot's devicetree, so this
-	 * should not every be wrong on a production device.
-	 */
-	assert(!(start & (MMC_MAX_BLOCK_LEN - 1)));
+	int ret;
 
-	start /= MMC_MAX_BLOCK_LEN;
+	ret = vbe_read_nvdata(blk, priv->area_start + priv->state_offset,
+			      priv->state_size, buf);
+	if (ret)
+		return log_msg_ret("nv", ret);
 
-	if (blk_read(blk, start, 1, buf) != 1)
-		return log_msg_ret("read", -EIO);
 	nvd = (struct vbe_nvdata *)buf;
-	hdr_ver = (nvd->hdr & NVD_HDR_VER_MASK) >> NVD_HDR_VER_SHIFT;
-	hdr_size = (nvd->hdr & NVD_HDR_SIZE_MASK) >> NVD_HDR_SIZE_SHIFT;
-	if (hdr_ver != NVD_HDR_VER_CUR)
-		return log_msg_ret("hdr", -EPERM);
-	size = 1 << hdr_size;
-	if (!size || size > sizeof(*nvd))
-		return log_msg_ret("sz", -ENOEXEC);
-
-	crc = crc8(0, buf + 1, size - 1);
-	if (crc != nvd->crc8)
-		return log_msg_ret("crc", -EPERM);
 	state->fw_vernum = nvd->fw_vernum;
 
 	log_debug("version=%s\n", state->fw_version);
@@ -69,7 +42,6 @@ static int simple_read_nvdata(const struct simple_priv *priv,
 
 int vbe_simple_read_state(struct udevice *dev, struct simple_state *state)
 {
-	ALLOC_CACHE_ALIGN_BUFFER(u8, buf, MMC_MAX_BLOCK_LEN);
 	struct simple_priv *priv = dev_get_priv(dev);
 	struct udevice *blk;
 	int ret;
@@ -83,7 +55,7 @@ int vbe_simple_read_state(struct udevice *dev, struct simple_state *state)
 	if (ret)
 		return log_msg_ret("ver", ret);
 
-	ret = simple_read_nvdata(priv, blk, buf, state);
+	ret = simple_read_nvdata(priv, blk, state);
 	if (ret)
 		return log_msg_ret("nvd", ret);
 
-- 
2.34.1

