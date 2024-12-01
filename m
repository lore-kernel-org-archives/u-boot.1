Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8A0D49776
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 15:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A2A89432;
	Sun,  1 Dec 2024 16:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="InNdecgo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA1E8945C; Sun,  1 Dec 2024 16:25:49 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7337B894E5
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8418ecda128so123068739f.2
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066742; x=1733671542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnkuGCqyab1Dmih6rAES6G+ds6QRLdVlJjn/CjTCr2A=;
 b=InNdecgo5Sd9U7HXsK22d0W1f3lgjfaZGdFWUTxIgYbk0us8+BgkIYIFj+RP4Gi0vA
 mxD7iIEwKpFNXQZBszlMfS1gvtwO/GtLbvzPdDJPpz/Zr6y2Xk1bXgJhoDXKmxhsOSBf
 3EQEeCZgFNMybG8szee8lkgQOvWCg+xhic7JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066742; x=1733671542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnkuGCqyab1Dmih6rAES6G+ds6QRLdVlJjn/CjTCr2A=;
 b=Gr35A64jilxr2L4PNxRxUTM8j/mW6vxXq9PU3Cq3iRwO6Sh/jLmMQww3YFi5CMmSIv
 ixiwHmIB4gggz94IigCYu1FLJYZohilLNZqeLRZkie6KSfwy0VAi4a6h8JK+jMTZurXE
 S+HPjsnVcPMY2GskOhCkfodLk5fxTG+Gzp4HbP182TrIllPKTY+8T3VS0Smao/587/sb
 WOr2/LS9VrHIJQYD+zm0ilQP1ujC2lOl4QKbM3weGTUkp8vFVz8FNVZOxvpDOLqI69iV
 7xr5uINhvFDa/edryRhe0/HTETZoEwJ6Dj2BcN8MvUTXbbbNQW3FS9DT5cuQfjfzQWne
 R3pg==
X-Gm-Message-State: AOJu0YyHM+978YKcoO4N6ZsQAvbgwOx0iVZOIDIFTV0yvCDyFa1czyr5
 /OCvVIDM0z1NJRA2lyvRPB7CbJ1x2Uj2scN/bsFkr08e0aI5+E43giTC51WjeGbrCT3ttSFHpJ4
 =
X-Gm-Gg: ASbGncvjqAk++hckwYPXnI44NgaWw6OlacGvUpdBUsFl/6kdxIpwmtNC7v/ziMMeTuG
 zBJM/6qhFAYrEaaAeVlvIpoMDMyznhmPS9F22aB5Z/P3l8534xxbFbSgT9MS03wzg/4NtFFVsiw
 U6U/0RDfLkRUKAt9SVDTh5HcIvrvzhEjoZiaa64rwY4rb2bb5Wryhqk82KdX7wG6lt03He1prhP
 nje+nY8RY/sojDuUt/ws3Tr2YYG+oIDOJvCIbIfYB9E
X-Google-Smtp-Source: AGHT+IHP+8Tg/K9ANwkrNcN+kfOFPqGrWqpMr4cuWu5g2N34RHEbledYhHFZY1CvsSBgYTQpioPgAA==
X-Received: by 2002:a05:6602:154a:b0:83a:f443:875 with SMTP id
 ca18e2360f4ac-843ed0fb082mr1936077039f.15.1733066741724; 
 Sun, 01 Dec 2024 07:25:41 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:40 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 10/25] efi_loader: Use a separate struct for memory nodes
Date: Sun,  1 Dec 2024 08:24:29 -0700
Message-ID: <20241201152505.1666789-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201152505.1666789-1-sjg@chromium.org>
References: <20241201152505.1666789-1-sjg@chromium.org>
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

At present efi_memory uses struct efi_mem_desc for each node of its
memory list. This is convenient but is not ideal, since:

- it means that the fields are under a 'desc' sub-structure
- it includes an unused 'reserved' field
- it includes virtual_start which is confusing as it is always the same
  as physical_start
- we must use u64 to store pointers, since that is how they are returned
  by calls to efi_get_memory_map()

As a first step to tidying this up, create a new, private struct to hold
these fields.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to use a separate stuct for memory nodes

 lib/efi_loader/efi_memory.c | 49 +++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 3cece51f030..9e4158edfaf 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -27,9 +27,39 @@ DECLARE_GLOBAL_DATA_PTR;
 
 efi_uintn_t efi_memory_map_key;
 
+/**
+ * struct priv_mem_desc - defines an memory region
+ *
+ * Note that this struct is for use inside U-Boot and is not visible to the
+ * EFI application, other than through calls to efi_get_memory_map(), where this
+ * internal format is converted to the external struct efi_mem_desc format.
+ *
+ * @type (enum efi_memory_type): EFI memory-type
+ * @reserved: unused
+ * @physical_start: Start address of region in physical memory
+ * @virtual_start: Start address of region in physical memory
+ * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
+ *	bytes)
+ * @attribute: Memory attributes (see EFI_MEMORY...)
+ */
+struct priv_mem_desc {
+	u32 type;
+	u32 reserved;
+	efi_physical_addr_t physical_start;
+	efi_virtual_addr_t virtual_start;
+	u64 num_pages;
+	u64 attribute;
+};
+
+/**
+ * struct efi_mem_list - defines an EFI memory record
+ *
+ * @link: Link to prev/next node in list
+ * @desc: Memory information about this node
+ */
 struct efi_mem_list {
 	struct list_head link;
-	struct efi_mem_desc desc;
+	struct priv_mem_desc desc;
 };
 
 #define EFI_CARVE_NO_OVERLAP		-1
@@ -116,7 +146,7 @@ static int efi_mem_cmp(void *priv, struct list_head *a, struct list_head *b)
  * @desc:	memory descriptor
  * Return:	end address + 1
  */
-static uint64_t desc_get_end(struct efi_mem_desc *desc)
+static uint64_t desc_get_end(struct priv_mem_desc *desc)
 {
 	return desc->physical_start + (desc->num_pages << EFI_PAGE_SHIFT);
 }
@@ -138,8 +168,8 @@ static void efi_mem_sort(void)
 	while (merge_again) {
 		merge_again = false;
 		list_for_each_entry(lmem, &efi_mem, link) {
-			struct efi_mem_desc *prev;
-			struct efi_mem_desc *cur;
+			struct priv_mem_desc *prev;
+			struct priv_mem_desc *cur;
 			uint64_t pages;
 
 			if (!prevmem) {
@@ -194,11 +224,11 @@ static void efi_mem_sort(void)
  * to re-add the already carved out pages to the mapping.
  */
 static s64 efi_mem_carve_out(struct efi_mem_list *map,
-			     struct efi_mem_desc *carve_desc,
+			     struct priv_mem_desc *carve_desc,
 			     bool overlap_conventional)
 {
 	struct efi_mem_list *newmap;
-	struct efi_mem_desc *map_desc = &map->desc;
+	struct priv_mem_desc *map_desc = &map->desc;
 	uint64_t map_start = map_desc->physical_start;
 	uint64_t map_end = map_start + (map_desc->num_pages << EFI_PAGE_SHIFT);
 	uint64_t carve_start = carve_desc->physical_start;
@@ -680,7 +710,12 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 	/* Return the list in ascending order */
 	memory_map = &memory_map[map_entries - 1];
 	list_for_each_entry(lmem, &efi_mem, link) {
-		*memory_map = lmem->desc;
+		memory_map->type = lmem->desc.type;
+		memory_map->reserved = lmem->desc.reserved;
+		memory_map->physical_start = lmem->desc.physical_start;
+		memory_map->virtual_start = lmem->desc.virtual_start;
+		memory_map->num_pages = lmem->desc.num_pages;
+		memory_map->attribute = lmem->desc.attribute;
 		memory_map--;
 	}
 
-- 
2.43.0

