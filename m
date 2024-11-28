Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F234D6911A
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E02E289D74;
	Thu, 28 Nov 2024 16:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IPJERnox";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD5789D6C; Thu, 28 Nov 2024 16:48:13 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5964A89877
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea47869282so911158b6e.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808888; x=1733413688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yjw5hgOL22GWtBTGctGJpyUU1SDZWOBQpuwyk3TBfs=;
 b=IPJERnoxrsS7WaKYVVvBnWHcVIzdoTEncj7qYyR+4GtpcVyWgthD+dG310liJHe9HR
 kUH9V4cIakPYP0ZSFdofa2YH8ifGEf3Cy6OA1ffeGXMptk7jnKD/EZFvQrPYE05Q9UtE
 FNKV25VWZt/QEQOi0oxpPNTMe47Y7nCiNhRDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808888; x=1733413688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yjw5hgOL22GWtBTGctGJpyUU1SDZWOBQpuwyk3TBfs=;
 b=nrUcr3mYlb4MA5XcEv3jZ+urA22Ae6BZ7FNm5uRUTnSOB+7/LsBfFA9s+Ca75iaWla
 BK5PG7Q1PwrgwmeV6fxB3X5pYibklfLxmsX/yvR3mVbbXXY5QIn9WQRsH4HmTPQAqGsd
 LvpD4f65Yx4Kup9VUiUvV6dzlrLM2Tc2iWwQt1ZV6pAZLzfd6yISdWqx0aQYMHK21CBH
 nAs1foN/QnAU3W8aPWxPr1QAXESGdoOBbOigu1R4fIVt6cfZLNoaZI1RBo3Ye4S5Rh5b
 HQ2QlXCm/wW1Lz3ixrF/uOSPMk//Bsfyu9qoKxOEL+NrBSe1m4rL/p4wOYqpDrZ2TQmz
 L9KA==
X-Gm-Message-State: AOJu0Yw5dq63sASSmDbnvTEsAYUhFJT3cKpTcV5UCLvndTl3NgMt5DtG
 pUYlJP3ReYbeLFSxHvuahwhLnxQw5M3Z56PVVOWEoZW+oelZbaJK59oLW2rkgj8xAseMH5FL1r0
 =
X-Gm-Gg: ASbGnctUWQeBcyhsGhk70jgwBQJ9w79ofyz1v9cguxEjQgCfJ4ftLQj2oU+qotyF+ET
 h1hpkwfIoRiGLveWQ1lipQCWB3wakEbo/BdqPpn0d2pxNVy1eESnBBGVnfKBL2gG46WfGHUdXIj
 DWBLexdaVvmpUZUqVFeyIUFus9yvU18mX/YG1BVHh9/3xcdFiA035mLK6oAcFtKKlE92Uq+VOxW
 UX4QLlgjWkVfgf8G823cDNkNTIm7HOAsZB3Rhz7jSodFg==
X-Google-Smtp-Source: AGHT+IEdTDDtmbqZlOQEY4SmQzM2y1J6gEWBKvrgvVtIafLTwL08ZrTM3dTROCTO/W0UYJj6muTx6Q==
X-Received: by 2002:a05:6808:f15:b0:3e4:d70c:42f6 with SMTP id
 5614622812f47-3ea814faa37mr1906418b6e.10.1732808888676; 
 Thu, 28 Nov 2024 07:48:08 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/28] efi_loader: Drop reserved from priv_mem_desc
Date: Thu, 28 Nov 2024 08:47:11 -0700
Message-Id: <20241128154727.771871-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

This field is not used. Drop it and set the value to 0 when the
memory-map is requested.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 518b8cff61d..81e40fc923d 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -35,7 +35,6 @@ efi_uintn_t efi_memory_map_key;
  * internal format is converted to the external struct efi_mem_desc format.
  *
  * @type (enum efi_memory_type): EFI memory-type
- * @reserved: unused
  * @physical_start: Start address of region in physical memory
  * @num_pages: Number of EFI pages this record covers (each is EFI_PAGE_SIZE
  *	bytes)
@@ -43,7 +42,6 @@ efi_uintn_t efi_memory_map_key;
  */
 struct priv_mem_desc {
 	u32 type;
-	u32 reserved;
 	efi_physical_addr_t physical_start;
 	u64 num_pages;
 	u64 attribute;
@@ -705,7 +703,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 	memory_map = &memory_map[map_entries - 1];
 	list_for_each_entry(lmem, &efi_mem, link) {
 		memory_map->type = lmem->desc.type;
-		memory_map->reserved = lmem->desc.reserved;
+		memory_map->reserved = 0;
 		memory_map->physical_start = lmem->desc.physical_start;
 
 		/* virtual and physical are always the same */
-- 
2.34.1

