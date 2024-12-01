Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A896D49771
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A7F7895C7;
	Sun,  1 Dec 2024 16:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G31fFpfC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C010894E5; Sun,  1 Dec 2024 16:25:49 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07C6893C4
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 16:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-8418ecda126so108319339f.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733066744; x=1733671544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HqEkALkswr4a5Dgw0P2U4FBtOSFQXhxN38YBTciQcPA=;
 b=G31fFpfC6KeME8St6YGQwCssFYIc7vNZKhTEDr3zb0p/H2biOs3BgTl7RoYelfRyKs
 WX+znqorst8ZoWpXg7y1Emy3W0oS+8VOORIYvl6RV4gxXc+HLfl7DOHpVd9SQj72hnDm
 wQQ0N+tTXLVVS+Yz5nvXSdy423TbS1/O44phs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733066744; x=1733671544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HqEkALkswr4a5Dgw0P2U4FBtOSFQXhxN38YBTciQcPA=;
 b=COE0o26iKJC1awxVSF1ES4PTi3o3uTJK9GScdWj4aTDew3Eo2SMGMicIN8M9BD09/A
 dzm/SmKwAFnuvSjZpsP57jiamRFmfnHDheMF3D24+GRed/+Fmu5vgDEKwa9BEPAtc9O9
 i4RNazNbehvBIflDGjIHBFTE9XheNnO8cu3veYO+FkT5vqIDnrCvvJ+OlK01yZBuuu6x
 VRwxxHT3ags+170WQHZ9DBxdBNYT+Lh5yqyHp9ulCHa88fdKvtykvXCio6aifm21yD2S
 /G4xV8UvBWVKBO7Ybqv+zPoEvS++8PVe4GmexuRREnSY5xnk+a+Z5GAuxzYGW4oqNWUX
 kgPA==
X-Gm-Message-State: AOJu0YwhHc6/9j9K9U57wli78ZNXRzpxwusHk8sMSWJ2rrwOdbbyFkF/
 T18m7iFgyhBiKbGSq8k0eRln9usW39ZR6wsRuT2zX7fT9upnvZRAcXn90FRLLzn8wxAS69o/hDQ
 =
X-Gm-Gg: ASbGncvUYutUpnL0+NsgsxODbzJjOF7PAmEgiDupT7Q5+yi6UoinYMJFJom1eT33wfk
 XwtgD6Ss7fH/C5jVe8Ikdw39mbgIurVI6OrR03zMau25TVPlwdC28zU6PSHut/6tTc/5mTS0CCT
 il6k3VA1OpwfK7vDmVCRPVBmOW5JH7bUEIJgGpzh8MWCf4QlkmmfS97mEdZaOBtYo/W9juJrDzD
 JM8PxyVnpHzZ6+EyzBvPTVoLnDZfntlY49qHAbkfewO
X-Google-Smtp-Source: AGHT+IGLZyXr5RXm+xBB2WfmM1f00iLop5BA9J8unpDeps3EVBMMkGKCqXdsRVpElXbDth3MOHrg9Q==
X-Received: by 2002:a05:6602:1485:b0:83a:bd82:78e with SMTP id
 ca18e2360f4ac-843ed0d5db1mr1773591639f.13.1733066744570; 
 Sun, 01 Dec 2024 07:25:44 -0800 (PST)
Received: from chromium.org ([139.60.174.4]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405ec8d88sm159755239f.19.2024.12.01.07.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:25:43 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 11/25] efi_loader: Drop virtual_start from priv_mem_desc
Date: Sun,  1 Dec 2024 08:24:30 -0700
Message-ID: <20241201152505.1666789-12-sjg@chromium.org>
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
2.43.0

