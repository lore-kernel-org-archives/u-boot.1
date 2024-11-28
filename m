Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEBBD70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A429C89D65;
	Thu, 28 Nov 2024 20:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J2J6lKx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C62DE89D14; Thu, 28 Nov 2024 20:13:23 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D00D89D46
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3ea55d16d73so414629b6e.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821200; x=1733426000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yjw5hgOL22GWtBTGctGJpyUU1SDZWOBQpuwyk3TBfs=;
 b=J2J6lKx8r+RPUVmDN21z97ldLGUIGVLJMFQbwYuL2n8drk7WAL5t6mqIwGsir981Rk
 FH/DBD3IQZI9rKloe1So//CviSbzd6Ws6VIkevL2a63NxSiS+dKsPwOL7CjNiTFmGniY
 WzL7WqNs0hBtRnuvWcl9MtNlQNiHF+cq3pjCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821200; x=1733426000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yjw5hgOL22GWtBTGctGJpyUU1SDZWOBQpuwyk3TBfs=;
 b=xR59rI44L/VN7ni/M1/l7fCPwBlDVBI3dA0S9RQL8an70HJQWX1Gg/5Xfw0xDSZnBe
 eLWFJnKMwCZ7vCVKliSvJ3I4C4xvbHewUgxBNqzeq4L+2Tt7WsNf569xdyXicbugsbAV
 WK2Hvi3rQwqcOAW8ZUVoqwSNKa3xMp93uYnq4o5KihrRR1MESdlyraBrGOHvg/5T82KY
 EkFXfmwUDqe9/tbn1b1ZfCO1vWusTYKM+gNMWuK8OzZZBP+LzAzmattmRt8ieTmJsqzO
 LwqkhCQucDzIoUlR1nZinoAECd2o7balI2X9xJetbtdFM/FLATklfIJzBt8PlaV3j4KC
 ihwQ==
X-Gm-Message-State: AOJu0Yx3VXZPMSrnmamTC5cuJVa9zb82KKM1dq5ZLkfi8Jf1mONCmunY
 vLKeKTI5mHaZGg90wG5UZmZsZrIf2uTeD9pBrchclM8grDkVzOAdg97PeEecTRg7QpsVklFjBq8
 =
X-Gm-Gg: ASbGncuuc4Q/Y7U8ULlMcBvoac9+PSEWrDPRA6U8j6N3jZ0CoWXUa/JAnqCDKigApqT
 TnyF9KtUD04ORbflzXeEy1tyozKrX3FWaVVdyiN0JiL0GbYzsStwB8Q0tktEF0y3RmOO+A563uS
 nazxA8dLBjv/r3Dppa88tz80NLtffPjTz39wxPOwgtvLNvxCUeOAnm355sGwqh67GXGdIIMwyUl
 R4aQVfLm5oNRtCg5IassQbRVGA+VKu7ZBSyfy3QvFh83Q==
X-Google-Smtp-Source: AGHT+IGWNsr171YjpelS7LA3cCXgenomFd1oLgdfc7tDcOyHcC9Tl+2hmQ0tZxDoa8osS821ey2LwA==
X-Received: by 2002:a05:6808:1448:b0:3e6:64c:a477 with SMTP id
 5614622812f47-3ea6dbebf71mr7843762b6e.14.1732821199707; 
 Thu, 28 Nov 2024 11:13:19 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 12/28] efi_loader: Drop reserved from priv_mem_desc
Date: Thu, 28 Nov 2024 12:12:28 -0700
Message-Id: <20241128191244.900006-13-sjg@chromium.org>
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

