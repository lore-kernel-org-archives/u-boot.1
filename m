Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05533E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2BFF801CE;
	Wed, 11 Dec 2024 14:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="By1MiXR2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F703801CE; Wed, 11 Dec 2024 14:54:43 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06D83802E6
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-843d7f16827so247243539f.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925279; x=1734530079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PI0Gt9dSy40ISiWFnq0S63pYzyZNa/xM32/765a6J9E=;
 b=By1MiXR2hZRlkYYIwlgenH9CFEitlf5XaBmsVbDCr3wGF4+sxYo2/Q8HCzPTADBT1o
 dT+/Kg8jUQ6ML1fQeiKi0rJpsWIr3SbaskFV62X36Iqb4a0VZi1hEHCYzbUDOQ8Lb73T
 8YYTIPGf0KR+xu1iZpXW+JHpQOJDPifWtTbIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925279; x=1734530079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PI0Gt9dSy40ISiWFnq0S63pYzyZNa/xM32/765a6J9E=;
 b=fFEr4wXEm36Mr+HbVLVpdS1yjSNJ2sLqpE/oHqLWU9i1Wb5Y7bR5h/Kd/WVQU3lH2t
 XRf7BJEsai8nHqVeFB143B1l5cpyLF4oCAj6s4GnRTDvESrHl/K3nSNyI/ev3nG3SccG
 SaFMrTgACIyyrkMIp3KXfU/NBwdLy1YkrN4/LyFPOVjW7o48DPbv1OWtNfIj0xwybrlS
 RzrG/SyvjKBU/PfLmn0ikl47DXLgiv9T7p7QFn/k5nIUFx/0xOpGkbiC9K8RHWnQOkvD
 9rgrgHJ6ZZAuvcdf7fjAhwRtSsHq8zpzjVSV6z9QZxnkBJyswbF8R3R22Xhv802CZ52x
 Oznw==
X-Gm-Message-State: AOJu0YyuuWyntOa64wduoLGL+5I8lze7eUAb+Pp2l8z0DzJfHxICSGvH
 lFyU6ovqCbB8IpWwmnYtUnp6RLSl3DU4LzKonCsKZk1IibtFSLaNmF81UQA0Hw9VbWRaa4bqtM0
 =
X-Gm-Gg: ASbGncuJL7ILD1o+Pll6DyymgAng7GrA06yp7ZwdX5HYiYYu1APzVXYeiK43/S3/lzw
 5gpvBj95uOJ3lqrn4MK4Mt435oz5ivz5nSe5zj8lyWCk/M4MN4NoanZhpaG/PaEtByrDHdb+saU
 o/HWADW6vz1hVv2xzo1t4agRUbipiIEe7yfNN+uIEWFcURqVfh9ZXxLS3jC53xZ6+pQWtz7/mS1
 uR90Yc9rNxvHcXCcDcDVHen0HmLLz+7GM1gRFU4YRA44CHfR/enqRTXfVg1G2/PnxH68lRQ/Hvg
 ST41GbZKA7yg3tY=
X-Google-Smtp-Source: AGHT+IFR24frbbRzDCzLJdCUJrzfTRSa+vUgwlclnOQqiuRm6gxaIdQ/CNZRtKyHSralSd3VJ9epRQ==
X-Received: by 2002:a05:6e02:1d8b:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3aa0a66cb85mr31128465ab.24.1733925278806; 
 Wed, 11 Dec 2024 05:54:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 08/23] efi_loader: Use a separate struct for memory nodes
Date: Wed, 11 Dec 2024 06:54:02 -0700
Message-Id: <20241211135418.563803-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211135418.563803-1-sjg@chromium.org>
References: <20241211135418.563803-1-sjg@chromium.org>
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
index 4bc6d12a1fe..db40aee8353 100644
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
@@ -678,7 +708,12 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
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
2.34.1

