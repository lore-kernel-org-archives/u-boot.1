Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66975C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 09:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3330833FC;
	Tue,  8 Apr 2025 11:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A13XgPrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80B63833C6; Tue,  8 Apr 2025 11:13:51 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D5FD833BE
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 11:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso29277025e9.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 02:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744103626; x=1744708426; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zcNtQq/p3lrJ5+YREThRsDvkDYGSU2+7JCaahH9LgMs=;
 b=A13XgPrAgR7wizIk79/zxxpTE1bbQh95vdDY0M3zEjrfR/WdZjCaryXLtJx0APOGod
 eM2L1nIdj4PcYr8VZxs4dJYLsq2a2mwTBelh2P059e6e5kghQ0oIloSbjAM5A3PRe/wi
 wUr+H6xp2ayGyd0kzhkqypRNwK2zVkFjyhpGsfICkrI6x9yhZh6CdH1AtIGpW+GJKbNw
 HZqsW0v2w9r7VaAS3+epG/Y2pn8K7t3MhMTlWsrdcHH0zemAdxpErjgQSUB86bDOOiNB
 N/nEdbHJY64yUyIRVu/uh+vmc+3Q/FdegBAdG8ol411UJSevHXmTPSsV9aXC+opcyMFe
 StBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744103626; x=1744708426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zcNtQq/p3lrJ5+YREThRsDvkDYGSU2+7JCaahH9LgMs=;
 b=t4Q+sjGXR2wYO0WujPTgUibZe2k8G55n9TMi5avTg8A/Wn/KfbxZE6XQs3VNVVUYDT
 L5A9UFRiE4MYm4We9BwcehudtGN1seXnMZrjKNLrYE1CiKz9TkAuNIa2yZi+UbSRuR7E
 KA7QJmWiVgw6TXFODfcurRO6ukaeQ/L5tZ2KGlXheVYPyF++XhB5e1mScrgxGRg4v5Ci
 KI7gnTl/L2x+PURrXmg3ijUY77m2ltrPNyV8faYTjpFwpobU3DJGYTzhS8t/gUMDo6cj
 KXG15+GMRaHvwZNL4GYWKcLjn1+EDqX405YV2nszrAy9T0gFGLgwPSRfOs/3nmGAtNn0
 W0CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUysJOEgTTkAx8OGz7FLRQTz/sAsLlqNDdz/Q7LlzXfaQgFCYA2KNaB3PoriKNgTZmDAHxGmrA=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz2y10adok0D/oweC+Q3iF6R0ckqJdMmK8e8oAET4+BtV1KsPw
 2vATspWQqLZBPib32oTp7B88i63EVI8ZjLrJMBZZ7dUEczGANGiWbM8k488r0vaB2gS4plLiKcV
 b
X-Gm-Gg: ASbGncs1EU6nWs8z8wtqmMIxtwm+qWB7U53kSgDImEzzKku9oW3YqZCpy9VixrhTTn4
 JflHK7hpoFYclVBRNBqm36yhV/x4ZBy4tPCJ8+5x2OTYxAVnEEaMeWgK7+jM17cq6FL0zBly1Ng
 CsmTetTMKeSs7ukXupkE7adMWlLbKhztn3aTmz8m2h0baaZcS6sB+RhnLHG71sJPFaRtJjZCllD
 RirfphtffEeF1XnoBMLtbKbFM/+x6FxMX2kgtHtTbtR3Cj3qfQLwQVKwuFVjkrVyiIZPUGhtn3/
 QS3b7MDOeFVuel3/W7pZ7pChv45TIQAaTUdn6IOoV43lDXtYuZnjD0a2l+aW9d8d6g==
X-Google-Smtp-Source: AGHT+IEb7ARxnEIE7lve28rd6ltowKF2937Cx9Aoj5z5o6g4tPiO51k0bDdd5LjrWSW6nkXKfwlzag==
X-Received: by 2002:a05:600c:1d8f:b0:43d:526:e0ce with SMTP id
 5b1f17b1804b1-43ee076d517mr82670985e9.21.1744103625785; 
 Tue, 08 Apr 2025 02:13:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366aa29sm155056555e9.39.2025.04.08.02.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 02:13:45 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Apr 2025 11:13:41 +0200
Subject: [PATCH v2 2/3] part: efi: add GPT PTE cache used with
 part_get_info_cached() API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-topic-gpt-cache-v2-2-de76e47debb7@linaro.org>
References: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
In-Reply-To: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8871;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zDk+kDSWWudphQFpbKALF1vSKMox4zCeWi+smggKCUY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn9OjHHdGSwQrneeToAlVXksPedGZeng5sw2FzyxbN
 womORsGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ToxwAKCRB33NvayMhJ0RX3EA
 Cg5YEbryuF3/zTH47FQnek0NhRhQLGFVuSG/Ry5Nfiel8jX9is1/eZdmO2AhzC79oiOUq7n2haqFxc
 FfT61mzxS6SAf0tiYLI3XuiXHux7fKMwG6jxs3qi4IyaXwpzguG2wsznKgXfXo7Xrun+2NyM+tv3XP
 L3zS1u5DRcNWlWO4uXF9R60XnFRKZ7bVql342tnXkE4lK30hvUrvGOr6UGa5T1qbeLg7XfS7c+5/vJ
 AAdJKNT5ARWGPu3LROvY9blUv7ZJNmS8M4874iOhbrfhzqWdpec3z4lnKSr/uNYDVEO2kA+rb/J4Ju
 cPp5SOzbNS7AnMdEQhf4HdJPkt1qGtpuqnOBXB5tQMq/UuumchUdA/HmGHqJtlxGPa37UekUflKZ2v
 n3Yi5LpxYy6vAO6QaUvNLbtrPyFAmY6kHNElImg2x0ufAFW7ixW6fVJqGQlxAz1jTngTGMm88LyAtk
 4LMw+1a36j8kpaOkI3ZatMF1N+Szo3d3fkbZgUVol/zOzk2mihmfLpmma3Srs8s7Ldqs5q4CvV9Dxy
 xJPENVW2tc0mAHvCNH0Bp62/zuN5jRbMoj1P8as4jBwPiWuJX5W//HW8qkxnTX68Y8AtIvZCNtJtv7
 OkVFB2QPKYf77RBqV8AmNpYhMGMcSYBvOiwv+EQCWOKojKj0c6JeAD5eE6Ow==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Implement a simple cache for part_efi to be used by the newly
introduced part_get_info_cached() API.

The cache simply stores a successfully scanned GPT PTE if called
from the part_get_info_cached() ops, and will return the cached
data if the blk_desc and lba offset matches, invalidating the
cache if not.

The cache will only operate if called from the part_get_info_cached()
API, all the over calls will operate uncached, making sure we
can still update & re-scan the GPT partitions like before.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 disk/part_efi.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 96 insertions(+), 18 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 932d058c184ce6946b7142e7c2d9637b28e4661e..949968fcd30fc18766a023e73f43ca1381dcef89 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -55,12 +55,58 @@ static inline u32 efi_crc32(const void *buf, u32 len)
 static int pmbr_part_valid(struct partition *part);
 static int is_pmbr_valid(legacy_mbr * mbr);
 static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
-			gpt_entry **pgpt_pte);
+			gpt_entry **pgpt_pte, bool cache);
 static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
 					 gpt_header *pgpt_head);
 static int is_pte_valid(gpt_entry * pte);
 static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
-			  gpt_entry **pgpt_pte);
+			  gpt_entry **pgpt_pte, bool cache);
+
+static struct gpt_pte_cache_data {
+	struct blk_desc *desc;
+	u64 lba;
+	gpt_entry *gpt_pte;
+	gpt_header gpt_head;
+} gpt_pte_cache;
+
+static void clear_gpt_pte_cache(void)
+{
+	if (gpt_pte_cache.desc) {
+		if (gpt_pte_cache.gpt_pte)
+			free(gpt_pte_cache.gpt_pte);
+
+		memset(&gpt_pte_cache, 0, sizeof(gpt_pte_cache));
+	}
+}
+
+static void cache_gpt_pte(struct blk_desc *desc, u64 lba,
+			  gpt_entry *gpt_pte, gpt_header *pgpt_head)
+{
+	if (gpt_pte_cache.gpt_pte)
+		free(gpt_pte_cache.gpt_pte);
+
+	gpt_pte_cache.desc = desc;
+	gpt_pte_cache.lba = lba;
+	gpt_pte_cache.gpt_pte = gpt_pte;
+	if (pgpt_head)
+		memcpy(&gpt_pte_cache.gpt_head, pgpt_head, sizeof(gpt_header));
+}
+
+static gpt_entry *get_cached_gpt_pte(struct blk_desc *desc, u64 lba,
+				     gpt_header *pgpt_head)
+{
+	if (gpt_pte_cache.desc && gpt_pte_cache.gpt_pte) {
+		if (gpt_pte_cache.desc == desc &&
+		    gpt_pte_cache.lba == lba) {
+			memcpy(pgpt_head, &gpt_pte_cache.gpt_head, sizeof(gpt_header));
+			return gpt_pte_cache.gpt_pte;
+		}
+
+		clear_gpt_pte_cache();
+	}
+
+	return NULL;
+}
 
 static char *print_efiname(gpt_entry *pte)
 {
@@ -205,7 +251,7 @@ int get_disk_guid(struct blk_desc *desc, char *guid)
 	unsigned char *guid_bin;
 
 	/* This function validates AND fills in the GPT header and PTE */
-	if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
+	if (find_valid_gpt(desc, gpt_head, &gpt_pte, false) != 1)
 		return -EINVAL;
 
 	guid_bin = gpt_head->disk_guid.b;
@@ -224,7 +270,7 @@ static void __maybe_unused part_print_efi(struct blk_desc *desc)
 	unsigned char *uuid;
 
 	/* This function validates AND fills in the GPT header and PTE */
-	if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
+	if (find_valid_gpt(desc, gpt_head, &gpt_pte, false) != 1)
 		return;
 
 	debug("%s: gpt-entry at %p\n", __func__, gpt_pte);
@@ -258,8 +304,13 @@ static void __maybe_unused part_print_efi(struct blk_desc *desc)
 	return;
 }
 
-static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
-					    struct disk_partition *info)
+static void __maybe_unused part_get_info_cache_free_efi(struct blk_desc *desc)
+{
+	clear_gpt_pte_cache();
+}
+
+static int _part_get_info_efi(struct blk_desc *desc, int part,
+			      struct disk_partition *info, bool cache)
 {
 	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
 	gpt_entry *gpt_pte = NULL;
@@ -271,13 +322,14 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 	}
 
 	/* This function validates AND fills in the GPT header and PTE */
-	if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
+	if (find_valid_gpt(desc, gpt_head, &gpt_pte, cache) != 1)
 		return -EINVAL;
 
 	if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
 	    !is_pte_valid(&gpt_pte[part - 1])) {
 		log_debug("Invalid partition number %d\n", part);
-		free(gpt_pte);
+		if (!cache)
+			free(gpt_pte);
 		return -EPERM;
 	}
 
@@ -307,11 +359,23 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 	log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", info->start,
 		  info->size, info->name);
 
-	/* Remember to free pte */
-	free(gpt_pte);
+	if (!cache)
+		free(gpt_pte);
 	return 0;
 }
 
+static int __maybe_unused part_get_info_cached_efi(struct blk_desc *desc, int part,
+						   struct disk_partition *info)
+{
+	return _part_get_info_efi(desc, part, info, true);
+}
+
+static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
+					    struct disk_partition *info)
+{
+	return _part_get_info_efi(desc, part, info, false);
+}
+
 static int part_test_efi(struct blk_desc *desc)
 {
 	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, legacymbr, 1, desc->blksz);
@@ -689,7 +753,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
 	 */
 	if (is_gpt_valid(desc,
 			 GPT_PRIMARY_PARTITION_TABLE_LBA,
-			 gpt_head, gpt_pte) != 1) {
+			 gpt_head, gpt_pte, false) != 1) {
 		log_debug("Invalid GPT\n");
 		return -1;
 	}
@@ -706,7 +770,7 @@ int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
 	}
 
 	if (is_gpt_valid(desc, (desc->lba - 1),
-			 gpt_head, gpt_pte) != 1) {
+			 gpt_head, gpt_pte, false) != 1) {
 		log_debug("Invalid Backup GPT\n");
 		return -1;
 	}
@@ -765,9 +829,9 @@ int gpt_repair_headers(struct blk_desc *desc)
 	int ret = -1;
 
 	is_gpt1_valid = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
-				     gpt_h1, &gpt_e1);
+				     gpt_h1, &gpt_e1, false);
 	is_gpt2_valid = is_gpt_valid(desc, desc->lba - 1,
-				     gpt_h2, &gpt_e2);
+				     gpt_h2, &gpt_e2, false);
 
 	if (is_gpt1_valid && is_gpt2_valid) {
 		ret = 0;
@@ -1023,12 +1087,13 @@ static int is_pmbr_valid(legacy_mbr *mbr)
  * lba is the logical block address of the GPT header to test
  * gpt is a GPT header ptr, filled on return.
  * ptes is a PTEs ptr, filled on return.
+ * cache is a bool, true to use the cached gpt_pte from previous call
  *
  * Description: returns 1 if valid,  0 on error, 2 if ignored header
  * If valid, returns pointers to PTEs.
  */
 static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
-			gpt_entry **pgpt_pte)
+			gpt_entry **pgpt_pte, bool cache)
 {
 	/* Confirm valid arguments prior to allocation. */
 	if (!desc || !pgpt_head) {
@@ -1036,6 +1101,12 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
 		return 0;
 	}
 
+	if (cache) {
+		*pgpt_pte = get_cached_gpt_pte(desc, lba, pgpt_head);
+		if (*pgpt_pte)
+			return 1;
+	}
+
 	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, mbr, 1, desc->blksz);
 
 	/* Read MBR Header from device */
@@ -1081,6 +1152,9 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
 		return 0;
 	}
 
+	if (cache)
+		cache_gpt_pte(desc, lba, *pgpt_pte, pgpt_head);
+
 	/* We're done, all's well */
 	return 1;
 }
@@ -1090,23 +1164,25 @@ static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
  *
  * gpt is a GPT header ptr, filled on return.
  * ptes is a PTEs ptr, filled on return.
+ * cache if a bool, use cached GPT if available
  *
  * Description: returns 1 if found a valid gpt,  0 on error.
  * If valid, returns pointers to PTEs.
  */
 static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
-			  gpt_entry **pgpt_pte)
+			  gpt_entry **pgpt_pte, bool cache)
 {
 	int r;
 
 	r = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_head,
-			 pgpt_pte);
+			 pgpt_pte, cache);
 
 	if (r != 1) {
 		if (r != 2)
 			log_debug("Invalid GPT\n");
 
-		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte)
+		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte,
+				 true)
 		    != 1) {
 			log_debug("Invalid Backup GPT\n");
 			return 0;
@@ -1210,6 +1286,8 @@ U_BOOT_PART_TYPE(a_efi) = {
 	.name		= "EFI",
 	.part_type	= PART_TYPE_EFI,
 	.max_entries	= GPT_ENTRY_NUMBERS,
+	.get_info_cache_free	= part_get_info_ptr(part_get_info_cache_free_efi),
+	.get_info_cached	= part_get_info_ptr(part_get_info_cached_efi),
 	.get_info	= part_get_info_ptr(part_get_info_efi),
 	.print		= part_print_ptr(part_print_efi),
 	.test		= part_test_efi,

-- 
2.34.1

