Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E396E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF918030F;
	Wed, 11 Dec 2024 14:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hgkn6asZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F7680296; Wed, 11 Dec 2024 14:54:46 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 977C880316
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-83eb38883b5so222960139f.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925281; x=1734530081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQMhH5zpH9xTlkNY2thzP/ZcWXC9aaJUuk5Co38KTDY=;
 b=hgkn6asZNhR0qKfaz5y9gfstPzcfGwBICj7CoCJWpxdjkJ8/q9R+Cvvk2iVGi/lAZ4
 3AFL+2wQneFKddjtVGesc5uOTL6reRNeAzJF4WujFX3C7O6/+zQkT+lYkMjqTbGYercE
 f+Um8JC3u7KUMODV6VpBlhNhDCgBEIUrIeF7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925281; x=1734530081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQMhH5zpH9xTlkNY2thzP/ZcWXC9aaJUuk5Co38KTDY=;
 b=I/DL1eYFfRmB8liwdowtenYCiiUZIjLbquLbrHO1NdzUSZ+a6fLkJDy9gmccNlIAZW
 3l3+5OjpaWbfzgjSMOR+vajJ92Kc8RCvLAPqbcjTyuWTZz+yfeHNnot5rAdkex2bFkFy
 lhdJdC/4Hjj5Q/2FsHcO7PiLidl7al2cnec48o9L2cnLC1sQ61EJD1ShHIJ8bdJUriGv
 mquKhFd3CD1bt0ZhT+7MeFsHHrLp4rq2IKPfjFSyJSeUsgO1x4KU0FMv9UK88ILPRiz9
 fg49DC0VHt5FCzPy+Z0r1f5B5Nwo1z6/NcZdjDkuYfPd/j2AvnR4hS+Gc7NhrLSY243g
 I8Mg==
X-Gm-Message-State: AOJu0YyA0EK9fscW9rsZuJFakTOiSORTyCGN/VnaSzjYbATp4UxmdU3c
 lGe6x7F5w388TyS3gLSgW8C2sPrxO8JewM0jG+KFnCPT4qOTD8DrtAK7uG+tqYPcut3rqCrHueE
 =
X-Gm-Gg: ASbGncuw5Q2SNagTSOvRG+gAzos7rVJwQY+nM+uJjAHJEyPi2OvysaB83nl8uKfyG3w
 Qz+fGYzveN62RYA6i95TQz/Xw5ZUJXuTDOuxppFQdQDFRIdV7hyQMY/8A61B8Ianps2i6Tf/p3x
 D8sgsmwv8/faJxJu29aDviZmmzl5ExG5P6SntnHFIfR9HTDtIBW2y5K601SMkdApGEoAfOUq4In
 Mh2XIT/QNjSE71Fg7q4IKoGfBLHA8FlPA9SyQ/wRPfki75DpcbY0gOaSRXVFtAMDlN6qYwPhvGv
 VHG4pkN46Ni4ixo=
X-Google-Smtp-Source: AGHT+IHbfhNabkZJDWnlhjvMU9c2ewwOQdsP0UiSzgFQiiRHOlag1xyY3+hvTxqi4AIwaTCYTHMAJQ==
X-Received: by 2002:a05:6e02:1fe5:b0:3a7:bcbf:ba99 with SMTP id
 e9e14a558f8ab-3aa05f79062mr36152285ab.6.1733925280843; 
 Wed, 11 Dec 2024 05:54:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 09/23] efi_loader: Drop virtual_start from priv_mem_desc
Date: Wed, 11 Dec 2024 06:54:03 -0700
Message-Id: <20241211135418.563803-10-sjg@chromium.org>
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

This field is always the same as physical_start, so keeping track of it
separately is unnecessary and confusing. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index db40aee8353..8211600f7f6 100644
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
 	newlist->desc.type = memory_type;
 	newlist->desc.physical_start = start;
-	newlist->desc.virtual_start = start;
 	newlist->desc.num_pages = pages;
 
 	switch (memory_type) {
@@ -711,7 +705,9 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
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

