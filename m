Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB87E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 13:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 078E68026A;
	Wed, 11 Dec 2024 14:54:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m0IRHSs1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E02800C2; Wed, 11 Dec 2024 14:54:46 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F148E8032F
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 14:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a9d9c86920so9043145ab.2
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733925282; x=1734530082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2g6guY3BYobXckZxwLya3XzsbEi0ah5fNaw530tl00=;
 b=m0IRHSs1M+cay6JK3hL/7rS5Pua9TIX+CV4uffC0t/cV1+q+8ZSvWVFcuE+dJ3QegR
 VuACPMNRLDfoNOJV2FIOM4gzumdUvw7MpVk3fBxPEu605z47M0JfLBXJJSISXfNBjLkn
 vHU7EX6yPV3ky/PM8Ok3b7bTmRnoByqxo/VnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733925282; x=1734530082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2g6guY3BYobXckZxwLya3XzsbEi0ah5fNaw530tl00=;
 b=HRS0BxdYCg/pcVBzzV1fEowZQIVUZF//WitAJdwB6F9TBPIdCjw0plIgDu5T3bKyKW
 wy6sujuG9oj/Fbb60O8OC+reDAXjQMvWrlIvLHAzWLL1MeFbD3I3EqOOQyKepDFp7SCz
 zYaOyvfe7A6wlIRiihiyyk9SlRVbf6QYwjpmvq3slJSp6ycK7x08aotVBlb13822D9To
 dlVJMapzH5pm2L9T6YX5El4/HSzmSeBtyy+Y41gpPV/jWwrIz3qOoar2s5eRJebwKZoj
 MklUvj2g1IHN8b3gSbBGVh7/uetsBJCa8m0Q4tETwdGRn8oaiMmIYf99vfDaiO9QHEWc
 cfUw==
X-Gm-Message-State: AOJu0Yyomap4hEVt64m3liVfUG3lak3JXdIksJPEdx3ji8KSTirlq6GV
 Agg2s7v4DYwCuyDhHD+/jyjYXm8OUKxltdrQDbYfcbcNpJe2z1hwElzQVCqhh3e/MYd+/T6EMyE
 =
X-Gm-Gg: ASbGncv0x27bC9l0rmdpaz4a5+RhsAxmbeLEc1EIork72ddsiVLW+tb/C+ruvW74Enb
 rpHEu6JxUcxIsxlG9gD+FfWWEaOrSuuZv9VG7Q9FA+0RU00m1G3rVMX5SfBEkb90Q5/JRD6dBSG
 7hwWdnaHDVlUQFmb5fFFPtT5c2GSzLIlLVNy36XsUmouTVky5CKYJJVWlz60KuGHqrmcEZcl+yb
 h6kF1JdtsPoJASG3za1+7/HUD3knrJEMW4pZUWScMMSag1aNlhFJHAVoefhgBiiSiA3SnIl6yVF
 tjTLSBdV1ngDaRs=
X-Google-Smtp-Source: AGHT+IG9TNqKNGbXIjGQDoKpT3Wh/dzmdyHQyUQjNjRwATEYl5LMYUuiewMmNsyytIrhhtXuQl1IpQ==
X-Received: by 2002:a05:6e02:3092:b0:3a7:a738:d9c8 with SMTP id
 e9e14a558f8ab-3aa05010ea4mr30197735ab.2.1733925282220; 
 Wed, 11 Dec 2024 05:54:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2d46f66f0sm695441173.30.2024.12.11.05.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 05:54:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 10/23] efi_loader: Drop reserved from priv_mem_desc
Date: Wed, 11 Dec 2024 06:54:04 -0700
Message-Id: <20241211135418.563803-11-sjg@chromium.org>
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

This field is not used. Drop it and set the value to 0 when the
memory-map is requested.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 8211600f7f6..024361483a0 100644
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
@@ -703,7 +701,7 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 	memory_map = &memory_map[map_entries - 1];
 	list_for_each_entry(lmem, &efi_mem, link) {
 		memory_map->type = lmem->desc.type;
-		memory_map->reserved = lmem->desc.reserved;
+		memory_map->reserved = 0;
 		memory_map->physical_start = lmem->desc.physical_start;
 
 		/* virtual and physical are always the same */
-- 
2.34.1

