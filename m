Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3488FC83F0F
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 11:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 167C283285;
	Tue,  8 Jul 2025 13:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HMYe5AAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 326EC832DD; Tue,  8 Jul 2025 13:16:47 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E45C283280
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 13:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so2843264f8f.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 04:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751973404; x=1752578204; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bk7ER4k0jYR4JQv9dDQESrpV0ZkvdnIoch5rzcoi9oA=;
 b=HMYe5AAH4jVl0xr8I6Q3K4ERwKANI/kxPj8ZpJKk6NFaBKoXyhw32vfHB0x94Ge49E
 Ei2ssMJDYIsskQCg6bFxADLfBs/PfaVgU3js5m2VYaHitnhTcnDvsq+GlKtUJMUXB6u3
 ac/q2nZYKM8zX5xXAhsGB4TdRI5ugDWofV+4Uq8GlToGYsrEzVBgbNRcBPXjiJrH4nX+
 emW4io5G8wg2uGg+cFy2TL4I/BGRrbeeviaZsPyT7X6U762LVplW+/RbFkMS/5d1s7fq
 TiqJk2G7uMbFYweJKo/ZtToPCKGY1YMjcYbG6+JVvhCCc85iSoEqYBXh5DkK3mqafwpZ
 3FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751973404; x=1752578204;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bk7ER4k0jYR4JQv9dDQESrpV0ZkvdnIoch5rzcoi9oA=;
 b=OtCuoF3Z+w9x+XPStsFH1o9b84XXfPLuS+S2OKL7N8f4YkQInyfnRpNIg7KbrzOVEC
 A6DlmO7Bo14UDFYNSxwkcDLDzbzH1jGfoz1YYrOkJbX0bd2hH1a/xPG7/Pek8uxt3z3d
 d85A9wfi6cIlzcbLa8I+DaJnpioWfAtKZMhi0Vw5/Ad7CeBnGpChlmfaFKfQxjSIJELA
 L8HwXnFycbpMb4TSpURwDgqPw/JBIoy2IVRGe3xSXN+cShxKjkwjlEvX0ZjaULoMcbYa
 c7dJ4MpGBsZZgIfSk4XX/KQO4azseVbkpHwGOUSQiCzfs4EH+G4Dc41hFkNGAJcvci+Q
 EGyQ==
X-Gm-Message-State: AOJu0YycTqGO7YXE8ZRkM+0OV0MOsm0W3y9D4ABj/cyPWQa5WgePZ1/X
 oaqTWcKTUO1Ag1HKbomxlKagJ/d5ExdcS9v4iTnVxUaEZnsTefPFaAE0B7b5CGIkI8QJGNGxb/H
 +6N3r
X-Gm-Gg: ASbGnculL6AX+uziNwgfpU+hgDsMJQKJZMPDLnPP5qkhc+I0wwk+ya7nRm3GPyzHU8q
 5vp8dLEaMXwQZvy7G89nRZ4a+U1WlVH+BKYvWqKrJuA5N5PyiTWACZuNvv+aFol5xea7nYugDXa
 rTbBZeuKqCEtQNDP5aG0rQJOI5PO+wiuIxVPozpIqCyjLrFsjdEhnvcmET/kF7hlsqiivi7kvef
 itbx9l7/+H8nIeo2bN8p/ctUgqjDVcistM8BUYr8VPGvCLftipyFZbJlS3edtCNWAak+AgvZ9BW
 AbdJhoakhyvSsW8d0y/IoaF77M9Axt97vumqmx1duRRsGl48HQrC/J0MdX7zYz1nBasvkm37Ksb
 omrnshbsNhEZi
X-Google-Smtp-Source: AGHT+IEuaG5BZANi/1JIm3esYabR89f1Yv/geRfiKjfre4ekCU89zc/cxI/nWsCQnHIZ+b1dhG+Etg==
X-Received: by 2002:a05:6000:1a89:b0:3a5:8934:4959 with SMTP id
 ffacd0b85a97d-3b5de03565amr2113533f8f.27.1751973403949; 
 Tue, 08 Jul 2025 04:16:43 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:a08:6480:3e01:6cde])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd3d806bsm19168985e9.33.2025.07.08.04.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 04:16:43 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 08 Jul 2025 12:16:42 +0100
Subject: [PATCH 2/2] fs: exfat: Remove pointless variable uoffset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-exfat_fix-v1-2-e5783978cd11@linaro.org>
References: <20250707-exfat_fix-v1-0-e5783978cd11@linaro.org>
In-Reply-To: <20250707-exfat_fix-v1-0-e5783978cd11@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In exfat_generic_pread and exfat_generic_pwrite offset is passed in as a
off_t type which is defined as 'unsigned long long' so there is no need
to create the variable uoffset as a uint64_t as this is just a direct
copy of offset. Also remove the impossible test of 'offset < 0' as this
is always false due to offset being unsigned.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 fs/exfat/io.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/fs/exfat/io.c b/fs/exfat/io.c
index d80eece6850..6c86688cd6c 100644
--- a/fs/exfat/io.c
+++ b/fs/exfat/io.c
@@ -479,43 +479,40 @@ ssize_t exfat_pwrite(struct exfat_dev* dev, const void* buffer, size_t size,
 ssize_t exfat_generic_pread(const struct exfat* ef, struct exfat_node* node,
 		void* buffer, size_t size, off_t offset)
 {
-	uint64_t uoffset = offset;
 	cluster_t cluster;
 	char* bufp = buffer;
 	off_t lsize, loffset, remainder;
 
-	if (offset < 0)
-		return -EINVAL;
-	if (uoffset >= node->size)
+	if (offset >= node->size)
 		return 0;
 	if (size == 0)
 		return 0;
 
-	if (uoffset + size > node->valid_size)
+	if (offset + size > node->valid_size)
 	{
 		ssize_t bytes = 0;
 
-		if (uoffset < node->valid_size)
+		if (offset < node->valid_size)
 		{
 			bytes = exfat_generic_pread(ef, node, buffer,
-					node->valid_size - uoffset, offset);
-			if (bytes < 0 || (size_t) bytes < node->valid_size - uoffset)
+					node->valid_size - offset, offset);
+			if (bytes < 0 || (size_t)bytes < node->valid_size - offset)
 				return bytes;
 		}
 		memset(buffer + bytes, 0,
 				MIN(size - bytes, node->size - node->valid_size));
-		return MIN(size, node->size - uoffset);
+		return MIN(size, node->size - offset);
 	}
 
-	cluster = exfat_advance_cluster(ef, node, uoffset / CLUSTER_SIZE(*ef->sb));
+	cluster = exfat_advance_cluster(ef, node, offset / CLUSTER_SIZE(*ef->sb));
 	if (CLUSTER_INVALID(*ef->sb, cluster))
 	{
 		exfat_error("invalid cluster 0x%x while reading", cluster);
 		return -EIO;
 	}
 
-	loffset = uoffset % CLUSTER_SIZE(*ef->sb);
-	remainder = MIN(size, node->size - uoffset);
+	loffset = offset % CLUSTER_SIZE(*ef->sb);
+	remainder = MIN(size, node->size - offset);
 	while (remainder > 0)
 	{
 		if (CLUSTER_INVALID(*ef->sb, cluster))
@@ -537,43 +534,40 @@ ssize_t exfat_generic_pread(const struct exfat* ef, struct exfat_node* node,
 	}
 	if (!(node->attrib & EXFAT_ATTRIB_DIR) && !ef->ro && !ef->noatime)
 		exfat_update_atime(node);
-	return MIN(size, node->size - uoffset) - remainder;
+	return MIN(size, node->size - offset) - remainder;
 }
 
 ssize_t exfat_generic_pwrite(struct exfat* ef, struct exfat_node* node,
 		const void* buffer, size_t size, off_t offset)
 {
-	uint64_t uoffset = offset;
 	int rc;
 	cluster_t cluster;
 	const char* bufp = buffer;
 	off_t lsize, loffset, remainder;
 
-	if (offset < 0)
-		return -EINVAL;
-	if (uoffset > node->size)
+	if (offset > node->size)
 	{
-		rc = exfat_truncate(ef, node, uoffset, true);
+		rc = exfat_truncate(ef, node, offset, true);
 		if (rc != 0)
 			return rc;
 	}
-	if (uoffset + size > node->size)
+	if (offset + size > node->size)
 	{
-		rc = exfat_truncate(ef, node, uoffset + size, false);
+		rc = exfat_truncate(ef, node, offset + size, false);
 		if (rc != 0)
 			return rc;
 	}
 	if (size == 0)
 		return 0;
 
-	cluster = exfat_advance_cluster(ef, node, uoffset / CLUSTER_SIZE(*ef->sb));
+	cluster = exfat_advance_cluster(ef, node, offset / CLUSTER_SIZE(*ef->sb));
 	if (CLUSTER_INVALID(*ef->sb, cluster))
 	{
 		exfat_error("invalid cluster 0x%x while writing", cluster);
 		return -EIO;
 	}
 
-	loffset = uoffset % CLUSTER_SIZE(*ef->sb);
+	loffset = offset % CLUSTER_SIZE(*ef->sb);
 	remainder = size;
 	while (remainder > 0)
 	{
@@ -592,7 +586,7 @@ ssize_t exfat_generic_pwrite(struct exfat* ef, struct exfat_node* node,
 		bufp += lsize;
 		loffset = 0;
 		remainder -= lsize;
-		node->valid_size = MAX(node->valid_size, uoffset + size - remainder);
+		node->valid_size = MAX(node->valid_size, offset + size - remainder);
 		cluster = exfat_next_cluster(ef, node, cluster);
 	}
 	if (!(node->attrib & EXFAT_ATTRIB_DIR))

-- 
2.39.5

