Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0FEF46112
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 13:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 076908416C;
	Mon, 23 Mar 2026 14:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VoDsbN09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE6384114; Mon, 23 Mar 2026 14:43:23 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1278284175
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 14:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CE9E340ABC;
 Mon, 23 Mar 2026 13:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8476FC4CEF7;
 Mon, 23 Mar 2026 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774273396;
 bh=E/d0Y9rfYY0+dgC04Nx9nfu7GqYdQ08cupS06mN5wu4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VoDsbN09sMXwtmEjBznr/DjH+5NZXB03rYwqJF94l0TN7M5DXvEE9lkeQnJIWnIg0
 P2Bksc3DTc9nT7gUcmlv7OBwV4ORT4yTyyq+IxYso2dHaRpUMhUQSUCQ+iYW9EB0HJ
 mOF+tmHgmC9jM5pkfmBwGiTIxGJN/eaam1OgV1COVzaSaq4Vb0zw0NZX12De6iCkjw
 GhTXQpuF0/sCRTcw1XasCMdfJMDjl3sEbOETocuZ6vQvWv6xVbxXZje5kSDuo4GcyK
 GC/c1CMOHPk6hkzrs2cvKz5Fdf0MUD/ARawstrLR1ddHyZzJOqai9JQDXvmfZxOTNB
 wwmNFX4tmS6yg==
From: Michael Walle <mwalle@kernel.org>
To: Huang Jianan <jnhuang95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: linux-erofs@lists.ozlabs.org, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 4/4] fs/erofs: allocate data buffers on heap with alignment
 (3/3)
Date: Mon, 23 Mar 2026 14:42:20 +0100
Message-ID: <20260323134305.2675822-5-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323134305.2675822-1-mwalle@kernel.org>
References: <20260323134305.2675822-1-mwalle@kernel.org>
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

The data buffers are used to transfer from or to hardware peripherals.
Often, there are restrictions on addresses, i.e. they have to be aligned
at a certain size. Thus, allocate the data on the heap instead of the
stack (at a random address alignment).

This will also have the benefit, that large data (4k) isn't eating up
the stack.

The actual change is split across multiple patches. This one handles the
"struct erofs_map_blocks" which itself contains a data buffer. Add some
helpers to alloc and free the struct because the data buffer will now be
malloc'ed separately.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 fs/erofs/data.c     | 103 +++++++++++++++++++++++++++++---------------
 fs/erofs/internal.h |   4 +-
 fs/erofs/zmap.c     |  29 ++++++++++---
 3 files changed, 94 insertions(+), 42 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 2fe345d80ee..d10c00fe9f3 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -174,32 +174,60 @@ int erofs_read_one_data(struct erofs_map_blocks *map, char *buffer, u64 offset,
 	return 0;
 }
 
+struct erofs_map_blocks *erofs_alloc_map_blocks(void)
+{
+	struct erofs_map_blocks *map;
+
+	map = malloc(sizeof(struct erofs_map_blocks));
+	if (!map)
+		return NULL;
+
+	memset(map, 0, sizeof(struct erofs_map_blocks));
+	map->index = UINT_MAX;
+
+	map->mpage = malloc_cache_aligned(EROFS_MAX_BLOCK_SIZE);
+	if (!map->mpage) {
+		free(map);
+		return NULL;
+	}
+
+	return map;
+}
+
+void erofs_free_map_blocks(struct erofs_map_blocks *map)
+{
+	free(map->mpage);
+	free(map);
+}
+
 static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			       erofs_off_t size, erofs_off_t offset)
 {
-	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
-	};
+	struct erofs_map_blocks *map;
 	int ret;
 	erofs_off_t ptr = offset;
 
+	map = erofs_alloc_map_blocks();
+	if (!map)
+		return -ENOMEM;
+
 	while (ptr < offset + size) {
 		char *const estart = buffer + ptr - offset;
 		erofs_off_t eend, moff = 0;
 
-		map.m_la = ptr;
-		ret = erofs_map_blocks(inode, &map, 0);
+		map->m_la = ptr;
+		ret = erofs_map_blocks(inode, map, 0);
 		if (ret)
-			return ret;
+			goto out;
 
-		DBG_BUGON(map.m_plen != map.m_llen);
+		DBG_BUGON(map->m_plen != map->m_llen);
 
 		/* trim extent */
-		eend = min(offset + size, map.m_la + map.m_llen);
-		DBG_BUGON(ptr < map.m_la);
+		eend = min(offset + size, map->m_la + map->m_llen);
+		DBG_BUGON(ptr < map->m_la);
 
-		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
-			if (!map.m_llen) {
+		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
+			if (!map->m_llen) {
 				/* reached EOF */
 				memset(estart, 0, offset + size - ptr);
 				ptr = offset + size;
@@ -210,17 +238,21 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 			continue;
 		}
 
-		if (ptr > map.m_la) {
-			moff = ptr - map.m_la;
-			map.m_la = ptr;
+		if (ptr > map->m_la) {
+			moff = ptr - map->m_la;
+			map->m_la = ptr;
 		}
 
-		ret = erofs_read_one_data(&map, estart, moff, eend - map.m_la);
+		ret = erofs_read_one_data(map, estart, moff, eend - map->m_la);
 		if (ret)
-			return ret;
+			goto out;
 		ptr = eend;
 	}
-	return 0;
+
+	ret = 0;
+out:
+	erofs_free_map_blocks(map);
+	return ret;
 }
 
 int z_erofs_read_one_data(struct erofs_inode *inode,
@@ -282,19 +314,21 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			     erofs_off_t size, erofs_off_t offset)
 {
 	erofs_off_t end, length, skip;
-	struct erofs_map_blocks map = {
-		.index = UINT_MAX,
-	};
+	struct erofs_map_blocks *map;
 	bool trimmed;
 	unsigned int bufsize = 0;
 	char *raw = NULL;
 	int ret = 0;
 
+	map = erofs_alloc_map_blocks();
+	if (!map)
+		return -ENOMEM;
+
 	end = offset + size;
 	while (end > offset) {
-		map.m_la = end - 1;
+		map->m_la = end - 1;
 
-		ret = z_erofs_map_blocks_iter(inode, &map, 0);
+		ret = z_erofs_map_blocks_iter(inode, map, 0);
 		if (ret)
 			break;
 
@@ -302,31 +336,31 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		 * trim to the needed size if the returned extent is quite
 		 * larger than requested, and set up partial flag as well.
 		 */
-		if (end < map.m_la + map.m_llen) {
-			length = end - map.m_la;
+		if (end < map->m_la + map->m_llen) {
+			length = end - map->m_la;
 			trimmed = true;
 		} else {
-			DBG_BUGON(end != map.m_la + map.m_llen);
-			length = map.m_llen;
+			DBG_BUGON(end != map->m_la + map->m_llen);
+			length = map->m_llen;
 			trimmed = false;
 		}
 
-		if (map.m_la < offset) {
-			skip = offset - map.m_la;
+		if (map->m_la < offset) {
+			skip = offset - map->m_la;
 			end = offset;
 		} else {
 			skip = 0;
-			end = map.m_la;
+			end = map->m_la;
 		}
 
-		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		if (!(map->m_flags & EROFS_MAP_MAPPED)) {
 			memset(buffer + end - offset, 0, length - skip);
-			end = map.m_la;
+			end = map->m_la;
 			continue;
 		}
 
-		if (map.m_plen > bufsize) {
-			bufsize = map.m_plen;
+		if (map->m_plen > bufsize) {
+			bufsize = map->m_plen;
 			free(raw);
 			raw = malloc_cache_aligned(bufsize);
 			if (!raw) {
@@ -335,13 +369,14 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 			}
 		}
 
-		ret = z_erofs_read_one_data(inode, &map, raw,
+		ret = z_erofs_read_one_data(inode, map, raw,
 					    buffer + end - offset, skip, length,
 					    trimmed);
 		if (ret < 0)
 			break;
 	}
 	free(raw);
+	erofs_free_map_blocks(map);
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 13c862325a6..2e471d66c7d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -291,7 +291,7 @@ enum {
 #define EROFS_MAP_PARTIAL_REF	(1 << BH_Partialref)
 
 struct erofs_map_blocks {
-	char mpage[EROFS_MAX_BLOCK_SIZE];
+	char *mpage;
 
 	erofs_off_t m_pa, m_la;
 	u64 m_plen, m_llen;
@@ -367,6 +367,8 @@ static inline int erofs_get_occupied_size(const struct erofs_inode *inode,
 }
 
 /* data.c */
+struct erofs_map_blocks *erofs_alloc_map_blocks(void);
+void erofs_free_map_blocks(struct erofs_map_blocks *map);
 int erofs_getxattr(struct erofs_inode *vi, const char *name, char *buffer,
 		   size_t buffer_size);
 int erofs_listxattr(struct erofs_inode *vi, char *buffer, size_t buffer_size);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 1ded934a5d7..3060b2e9ec6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -75,28 +75,43 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 	}
 
 	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
+		struct erofs_map_blocks *map;
+
+		map = erofs_alloc_map_blocks();
+		if (!map) {
+			ret = -ENOMEM;
+			goto err_out;
+		}
 
 		vi->idata_size = le16_to_cpu(h->h_idata_size);
-		ret = z_erofs_do_map_blocks(vi, &map,
+		ret = z_erofs_do_map_blocks(vi, map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
-		if (!map.m_plen ||
-		    erofs_blkoff(map.m_pa) + map.m_plen > erofs_blksiz()) {
+		if (!map->m_plen ||
+		    erofs_blkoff(map->m_pa) + map->m_plen > erofs_blksiz()) {
 			erofs_err("invalid tail-packing pclustersize %llu",
-				  map.m_plen | 0ULL);
+				  map->m_plen | 0ULL);
 			ret = -EFSCORRUPTED;
+			erofs_free_map_blocks(map);
 			goto err_out;
 		}
+		erofs_free_map_blocks(map);
 		if (ret < 0)
 			goto err_out;
 	}
 	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
 	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
-		struct erofs_map_blocks map = { .index = UINT_MAX };
+		struct erofs_map_blocks *map;
+
+		map = erofs_alloc_map_blocks();
+		if (!map) {
+			ret = -ENOMEM;
+			goto err_out;
+		}
 
 		vi->fragmentoff = le32_to_cpu(h->h_fragmentoff);
-		ret = z_erofs_do_map_blocks(vi, &map,
+		ret = z_erofs_do_map_blocks(vi, map,
 					    EROFS_GET_BLOCKS_FINDTAIL);
+		erofs_free_map_blocks(map);
 		if (ret < 0)
 			goto err_out;
 	}
-- 
2.47.3

