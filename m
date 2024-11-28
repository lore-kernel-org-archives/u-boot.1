Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D47D70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5528089D57;
	Thu, 28 Nov 2024 20:13:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AGSlO5Qp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC39389D4F; Thu, 28 Nov 2024 20:13:21 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F7CF8938D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ea52520327so585451b6e.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821198; x=1733425998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lVldOF1cAOvUz84gGIujIGxYMgcivBDYN+CAURdhCAc=;
 b=AGSlO5QpnmGCQT5NvBSbi8In6LrxwQLkBETwdMPCe0OQmjCf0hurJaxa+3xt6Gr6o2
 jacHOy2TnjpBBedEQYT4gDAEIVQoskM2u93vfso83/4a4oM2NUKBfW2yxWCExCev8+//
 F9ov/41UoHdR70+GYtWoWfNt7/JS+b3d9IZgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821198; x=1733425998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVldOF1cAOvUz84gGIujIGxYMgcivBDYN+CAURdhCAc=;
 b=o+MESvzqeT9Z/q/iZHkYnosjdYRzu0KWGzVkq4yk/fn9SzXZqh70OoXRo3Ns/km8W5
 PcDjmNlZlOTg7v6Z9IqY2/Y0KzCNmK8BA89847AqEfXI3MuBRTvdHfqRI2U2hhMoRk8s
 n/SEd70bdNWjd9BYhqwm4ooHl7OjT4AYtDOU9ImJwxBAqzB36IeF1Ub7uA+lY20q6LoI
 vClw2RWfFvgOjhkuuGYkhzCXqNVCkTsdbZPpMWsRakb1wVWJGawbSREX+51sN5AAIO3o
 bSTxEC3V1IFfI/rhRgLAaU4vUIUI5UDnB9cFACKbvqOMKL26kn37rLbRVucMVL3C7Fv6
 d7FQ==
X-Gm-Message-State: AOJu0Yzb1pJMn+yxqh0S0/V6tKJLqqDW4Efv5uNQILHYC+WX0Sw1J3gi
 luUCxLQiEujT9gLDH9pZoEQrs1cuySlAIPlnCakVlw3l38+Kzw3CSajops4u+xNaMZ/9iNQJ8Gw
 =
X-Gm-Gg: ASbGncu70RX3wLlZsu7kgNlKwuDUxQXQQBatfdqvkzv0WlEidKENfKu5BV+hSNquNK7
 QFT02pzoxUKWUVfbDYuDVfH3WU194RqnCQYv2Aa/Fola60j9i53SbHw1eEMLQyPVjTRasi4dokG
 T7MBUjTuaxU1kdNY1yY5m7cwPHafyvBAPsOMrSfJdaNfrhXC4dpZtu8ROb0QTNl0fXzx6rt+omv
 1E++oaGqg++Od3viV7Swfv6zmm1UKsmgGDbrlz6FL5pAw==
X-Google-Smtp-Source: AGHT+IGZqOluOILI4/uq8Jo3xrLk8F6p+HE6B/i9044Dxu1ArZMSeJ5JvPBfgdATCUB7qBejbcAiag==
X-Received: by 2002:a05:6870:819b:b0:270:205a:4070 with SMTP id
 586e51a60fabf-29dc400846dmr7260994fac.14.1732821197809; 
 Thu, 28 Nov 2024 11:13:17 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 11/28] efi_loader: Drop virtual_start from priv_mem_desc
Date: Thu, 28 Nov 2024 12:12:27 -0700
Message-Id: <20241128191244.900006-12-sjg@chromium.org>
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

This field is always the same as physical_start, so keeping track of it
separately is unnecessary and confusing. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 9e4158edfaf..518b8cff61d 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -37,7 +37,6 @@ efi_uintn_t efi_memory_map_key;
  * @type (enum efi_memory_type): EFI memory-type
  * @reserved: unused
  * @physical_start: Start address of region in physical memory
- * @virtual_start: Start address of region in physical memory
  * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
  *	bytes)
  * @attribute: Memory attributes (see EFI_MEMORY...)
@@ -46,7 +45,6 @@ struct priv_mem_desc {
 	u32 type;
 	u32 reserved;
 	efi_physical_addr_t physical_start;
-	efi_virtual_addr_t virtual_start;
 	u64 num_pages;
 	u64 attribute;
 };
@@ -187,7 +185,6 @@ static void efi_mem_sort(void)
 				pages = cur->num_pages;
 				prev->num_pages += pages;
 				prev->physical_start -= pages << EFI_PAGE_SHIFT;
-				prev->virtual_start -= pages << EFI_PAGE_SHIFT;
 				list_del(&lmem->link);
 				free(lmem);
 
@@ -255,7 +252,6 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 			free(map);
 		} else {
 			map->desc.physical_start = carve_end;
-			map->desc.virtual_start = carve_end;
 			map->desc.num_pages = (map_end - carve_end)
 					      >> EFI_PAGE_SHIFT;
 		}
@@ -276,7 +272,6 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
 		return EFI_CARVE_OUT_OF_RESOURCES;
 	newmap->desc = map->desc;
 	newmap->desc.physical_start = carve_start;
-	newmap->desc.virtual_start = carve_start;
 	newmap->desc.num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
 	/* Insert before current entry (descending address order) */
 	list_add_tail(&newmap->link, &map->link);
@@ -313,7 +308,6 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 		return EFI_OUT_OF_RESOURCES;
 	newlist->desc.type = mem_type;
 	newlist->desc.physical_start = start;
-	newlist->desc.virtual_start = start;
 	newlist->desc.num_pages = pages;
 
 	switch (mem_type) {
@@ -713,7 +707,9 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 		memory_map->type = lmem->desc.type;
 		memory_map->reserved = lmem->desc.reserved;
 		memory_map->physical_start = lmem->desc.physical_start;
-		memory_map->virtual_start = lmem->desc.virtual_start;
+
+		/* virtual and physical are always the same */
+		memory_map->virtual_start = lmem->desc.physical_start;
 		memory_map->num_pages = lmem->desc.num_pages;
 		memory_map->attribute = lmem->desc.attribute;
 		memory_map--;
-- 
2.34.1

