Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7530CC04A95
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BC987730;
	Wed,  8 Nov 2023 17:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sh4QCEqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 296D786E2F; Wed,  8 Nov 2023 17:49:17 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB1A87546
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-41cbd2cf3bbso8680971cf.0
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462153; x=1700066953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVcfh+9U1YAaK5NsmxqeYiLId8fc06J6tu303NomJNU=;
 b=Sh4QCEqgnQFOc3lOFOQhLVjG7FNKRILAw5QqDnD3CfB4SqcqbgoBI2Hlo27sUNLB0I
 0MXHS2wkVoLtx8k3gjTDJd5hwY3YDpIZfnopCo51W6QcKgDOjAqGoK5Rzt/9telHy2iV
 NvadbpTOgaSa+1rZfbnU0TmRp0MTCdm9QTlC7C+mFr7tpLm/4AfvzYVeiU5r2jxm+vJv
 C5kXpcIqhSEqKq9LPLdV0FvD8pmMylhWf7JGCJpsatK8+4JBVEfKE/kdMVzPXIWqmyn/
 3l6v5JO4BGb4vGDbCZDPwVRHjTtg3UWvtK+y2iBMiieALcKXk88obNXQ4PY84rYTPUL7
 yAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462153; x=1700066953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cVcfh+9U1YAaK5NsmxqeYiLId8fc06J6tu303NomJNU=;
 b=j19BfobozgjdPezDUeEw+es6TrLepu8PcyW5sM356AedG9kz/xFcqgYBpx3pbG1/GJ
 /5dkgvIGOwTGKVK/YiYWzvFVj9RaKKNI+7VRycZWsO+MLrEsHvEuaykAdcD6gY4jEsHn
 yJSqzvAUXoOkkFCzjGfqLinLyH//M19t1dx350vL9spats8L3wvye1uofhQKu2VJXhOq
 /5nr1a9NdSpAe8sZ7kHiY01fmRoO3EKXwQ3gjgM1k/4oyTmKWyNGhP1uWwbe267vQGXR
 6Tsu7msgaX1QegGbaQV7ateLYuMAY7pW5gbzR4sJ7c1jLPYZuFbvL+/EE06sHKiIJCDD
 7C0Q==
X-Gm-Message-State: AOJu0YzkNS5d3UFpbZS0tYQCMh0OLg6njI4b4TC1N4OvUOe6BAkNbWjk
 g0zEbl/cY35gUVGQJVDjlRI=
X-Google-Smtp-Source: AGHT+IFXlrG3fTwNMUthq0qFk0exr0Rxr2Tjp9clBM8tvGrq/yXw3TVFcj1wb2KcqDyEsX3gGdh7yw==
X-Received: by 2002:ac8:7e95:0:b0:417:af0a:70a0 with SMTP id
 w21-20020ac87e95000000b00417af0a70a0mr9112659qtj.14.1699462153012; 
 Wed, 08 Nov 2023 08:49:13 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 t11-20020ac865cb000000b003f6ac526568sm1064525qto.39.2023.11.08.08.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:12 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 09/26] spl: Set FAT bl_len to ARCH_DMA_MINALIGN
Date: Wed,  8 Nov 2023 11:48:41 -0500
Message-Id: <20231108164858.3497420-10-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

Instead of relying on the presence of filename to determine whether we are
dealing with a FAT filesystem (and should DMA-align the buffer), have FAT set
bl_len to ARCH_DMA_MINALIGN instead. With this done, we can remove the
special-case logic checking for the presence of filename.

Because filesystems are not block-based, we may read less than the size passed
to spl_load_info.read. This can happen if the file size is not DMA-aligned. This
is fine as long as we read the amount we originally wanted to. Modify the
conditions for callers of spl_load_info.read to check against the original,
unaligned size to avoid failing spuriously.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v7:
- Split off from the removal of filename

 common/spl/spl_blk_fs.c        |  3 ++-
 common/spl/spl_fat.c           |  2 +-
 common/spl/spl_fit.c           | 23 +----------------------
 common/spl/spl_imx_container.c |  8 +++++---
 4 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/common/spl/spl_blk_fs.c b/common/spl/spl_blk_fs.c
index 144c8a65b5d..c105c55877a 100644
--- a/common/spl/spl_blk_fs.c
+++ b/common/spl/spl_blk_fs.c
@@ -9,6 +9,7 @@
 #include <spl.h>
 #include <image.h>
 #include <fs.h>
+#include <asm/cache.h>
 #include <asm/io.h>
 
 struct blk_dev {
@@ -85,7 +86,7 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.read = spl_fit_read;
-		load.bl_len = 1;
+		load.bl_len = ARCH_DMA_MINALIGN;
 		load.filename = (void *)filename;
 		load.priv = &dev;
 
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 6172e7bcd48..5b723456478 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -97,7 +97,7 @@ int spl_load_image_fat(struct spl_image_info *spl_image,
 
 		debug("Found FIT\n");
 		load.read = spl_fit_read;
-		load.bl_len = 1;
+		load.bl_len = ARCH_DMA_MINALIGN;
 		load.filename = (void *)filename;
 
 		return spl_load_simple_fit(spl_image, &load, 0, header);
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ce7ef0efd0d..0df4e6d1484 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -14,7 +14,6 @@
 #include <mapmem.h>
 #include <spl.h>
 #include <sysinfo.h>
-#include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/libfdt.h>
@@ -172,28 +171,11 @@ static int spl_fit_get_image_node(const struct spl_fit_info *ctx,
 
 static int get_aligned_image_offset(struct spl_load_info *info, int offset)
 {
-	/*
-	 * If it is a FS read, get the first address before offset which is
-	 * aligned to ARCH_DMA_MINALIGN. If it is raw read return the
-	 * block number to which offset belongs.
-	 */
-	if (info->filename)
-		return offset & ~(ARCH_DMA_MINALIGN - 1);
-
 	return ALIGN_DOWN(offset, info->bl_len);
 }
 
 static int get_aligned_image_overhead(struct spl_load_info *info, int offset)
 {
-	/*
-	 * If it is a FS read, get the difference between the offset and
-	 * the first address before offset which is aligned to
-	 * ARCH_DMA_MINALIGN. If it is raw read return the offset within the
-	 * block.
-	 */
-	if (info->filename)
-		return offset & (ARCH_DMA_MINALIGN - 1);
-
 	return offset & (info->bl_len - 1);
 }
 
@@ -202,9 +184,6 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
 {
 	data_size = data_size + get_aligned_image_overhead(info, offset);
 
-	if (info->filename)
-		return data_size;
-
 	return ALIGN(data_size, info->bl_len);
 }
 
@@ -295,7 +274,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		if (info->read(info,
 			       fit_offset +
 			       get_aligned_image_offset(info, offset), size,
-			       src_ptr) != size)
+			       src_ptr) < length)
 			return -EIO;
 
 		debug("External data: dst=%p, offset=%x, size=%lx\n",
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index ad89a99fb23..7cd674f835f 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -45,7 +45,8 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 	      container, offset, size);
 	if (info->read(info, offset, size,
 		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) != size) {
+				  images[image_index].size)) <
+	    images[image_index].size) {
 		printf("%s wrong\n", __func__);
 		return NULL;
 	}
@@ -77,7 +78,8 @@ static int read_auth_container(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %u\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size, container) != size) {
+	if (info->read(info, offset, size, container) <
+	    CONTAINER_HDR_ALIGNMENT) {
 		ret = -EIO;
 		goto end;
 	}
@@ -107,7 +109,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 
 		debug("%s: container: %p offset: %lu size: %u\n",
 		      __func__, container, offset, size);
-		if (info->read(info, offset, size, container) != size) {
+		if (info->read(info, offset, size, container) < length) {
 			ret = -EIO;
 			goto end;
 		}
-- 
2.37.1

