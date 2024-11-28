Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6622D70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A4A689D2F;
	Thu, 28 Nov 2024 20:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cPKySudw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C78D89D49; Thu, 28 Nov 2024 20:13:20 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0485289D52
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-29685066b8dso642161fac.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821195; x=1733425995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+6HH10P8a7GQtvW+POJjkt5FpOBSE+CJSzEwxrq7DY=;
 b=cPKySudw+S5I1tCdUM7Q/CHRZ6ZbqJnqX/7rXZ/j7uL8lrxYINPHJrOV7HiutRbA8T
 C2E3WsuYXDTl/XfSVq/dkg5bP6/jGg/FUB/hvw2+oVYs2AkZlt8DuDzvN+7CyYEk5kyd
 G77obnnZS1ckIQ9fHd/qlMlJbaFoY11UXVSNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821195; x=1733425995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+6HH10P8a7GQtvW+POJjkt5FpOBSE+CJSzEwxrq7DY=;
 b=Zn3WfK+hsxuX+DQM0G+501mr1wUYSK4vo7F0jx3FCGOvoGfmVgPAcUfeDknNOaBETW
 mEFeSd/H9ZlB1uFEG2ScRccwkz+nCxFTDTwpvSgqH/XijBweVQLcyvpR/HenKqS+QXoA
 pmCsYKrm7+z7oEuAGq5dGiDHUHuy8IeXyEm/V9Rl3FbNIWB0d6iMaOCl21BKn39DONJ7
 VE0sBlTGcRK8k8ALAEwvugrSSLtanzmjEut4W1RhhgvFxoKCmeq5UO66Qnxwg84p7Xds
 Eby/kVPZoDsDJPqhVPofpJiqP0yL9dNjjuLdc3KMJrv00j9XUjDPnQfFI3sY+SVwH7aD
 DQ7w==
X-Gm-Message-State: AOJu0Yy64bDbp7h5pbxmNcwKIFLNSIyYoI3q1SnnUrJzGnn1hFw2zmq8
 Q3nvrQY8VJKqANp6PO9YWXvFSPlXbtuWtz/C2AmGVl5fxyL45rln8iwsltuT1hCz6WgcAqaAIX4
 =
X-Gm-Gg: ASbGncvUKTk2wSwf6pVnjVed1T0ltLB5h+vBk2K4LSEdcNvBc4heNje7jEx1N3rinv4
 GIg05jPs/Fx1xfIIQfu1/FpmO+gWon+kVu1g1kMIiGU1p/dAiQJxXxrWIeT5TGW6tGbHNHaQlT8
 kzPg3z7Tdta30CSqbAuwfrMNIhrkexO2WGo0omqUlMaClH2aiWxyn8j9Nl+qz0CmiO2VdtegEsf
 AXF3vV8KsCC66n2+v4PTBqEMOYJzj4Fzkqc8VZl9Qx86A==
X-Google-Smtp-Source: AGHT+IG6KVwBr9/Q65Ohv/8w7/beHPrVTmGUnXK/4PwtuOphJYastKNvdc7B6OAyRoCMk5mTJ0EQ0g==
X-Received: by 2002:a05:6870:9a26:b0:288:53f6:2216 with SMTP id
 586e51a60fabf-29dc463f7b4mr8004632fac.31.1732821194843; 
 Thu, 28 Nov 2024 11:13:14 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/28] efi_loader: Use a separate struct for memory nodes
Date: Thu, 28 Nov 2024 12:12:26 -0700
Message-Id: <20241128191244.900006-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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
2.34.1

