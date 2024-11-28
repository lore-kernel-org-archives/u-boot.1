Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B595ED69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6376D89D6D;
	Thu, 28 Nov 2024 16:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="izfw4bGq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FDFD893D7; Thu, 28 Nov 2024 16:48:43 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BA889D84
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ea411ef5a9so473988b6e.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808917; x=1733413717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5DPp8kUN3uZhiYiZwHs5d6pabr4Avdp/tIomPwJmaY=;
 b=izfw4bGqs8+qXvYxK7/B7kZWA/CIdJH6gjqBEf8/zwyrMulDpkzQyfBw10w7HkExjt
 JciOlu4PDBwtc3pnfIox7tSPbkPtP91GWyG+b/5nkMe8/ujSmW84fIGCCD+aACO/+k3d
 czNkBB4oP0Ft2pXzZDeEceS6qNApb3vmJGsq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808917; x=1733413717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5DPp8kUN3uZhiYiZwHs5d6pabr4Avdp/tIomPwJmaY=;
 b=JvVfqiKVBll7xizzfrVXUPc0KtWa8u3ZqbPPL0T3AIE2vquXv05mng2hz3eRtBd5TU
 KVwLD9uq6EjnkKUJOfTzTRNjWMnVSX0xbx0iLJnNgEX2zf3QVt6CF1y56rc/pxZzaaAf
 TZPuFNBw3RD3N8uCAOrp5hjr0mG6E8Mis079uq4i3vURHW2aD7A9b/eK96YTWjWfRLfq
 CeTU3IIJhPSORl/U5Q67ddo9fbtq7TQF+PjQZeL1acRTIstUpOLOk02Fl20pJLUQyynL
 CCpn8IXVpSjGCqDFn07/9E4u7S264tlTh9mBS3BTwI4KcUMEw8AIIVUvjlyr823Y2ikR
 8ZVA==
X-Gm-Message-State: AOJu0YxD9ePqhGAiYtdRU9zOMCrlowGPsaEuR7m8ybFrnvL4SAWLikzr
 JzvnfLERcoz0VZF1UOXJfOcGZtycyDInnM5kdYhxCdeX9LBQUd+go2Dr7Hwz411qAiVq+JzkBSE
 =
X-Gm-Gg: ASbGncu9ENS4ffhAtgR7z8oWZiUIPIqxIrZ2za1QfgrDgQMl6RUw1SHF6ZsKumqk43Q
 bsikkAS1oISkfnmvwDxp8pR1HWKCvndcDfwWFCtGVkhBPC8aBLQPDBAu6PswG+qYOztCa7eh4/a
 FJobkC9/FTCxY+4zF+PNfG8QURYFT0TkF7ECcGqo9TpiacfTvpaCEa4+jxzOrmQXF5ZJQsjujcI
 lE+1ZTj15W4YmI721fiJNPzytEK6aO/DNRRXlhCpHLVXg==
X-Google-Smtp-Source: AGHT+IFwGkXc5V416OTZXK5aX5c1fbwqleRQLNjsS4Rim6kjY8xebaaX9Y9H+lJquhOVFK2wEnw92Q==
X-Received: by 2002:a05:6808:3c8c:b0:3ea:4a46:ecd2 with SMTP id
 5614622812f47-3ea6dd54d7amr7550932b6e.31.1732808917596; 
 Thu, 28 Nov 2024 07:48:37 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v2 19/28] efi_loader: Update efi_add_memory_map() to use
 address
Date: Thu, 28 Nov 2024 08:47:18 -0700
Message-Id: <20241128154727.771871-20-sjg@chromium.org>
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

Update this function and its friend to use an address rather than a
pointer cast to an integer.

The callers are updated in later patches, as marked, to reduce the diff,
but we may which to squash some patches.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/efi_loader.h        | 11 +++++------
 lib/efi_loader/efi_memory.c |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 4c346addae3..f1ae29b04d7 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -834,9 +834,9 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 /**
  * efi_add_memory_map() - add memory area to the memory map
  *
- * @start:		start address of the memory area. Note that this is
- *			actually a pointer provided as an integer. To pass in
- *			an address, pass in (ulong)map_to_sysmem(addr)
+ * @start:		start address, must be a multiple of EFI_PAGE_SIZE. Note
+ *			that this is an address, not a pointer. Use
+ *			map_to_sysmem(ptr) if you need to pass in a pointer
  * @size:		length in bytes of the memory area
  * @mem_type:		EFI type of memory added
  * Return:		status code
@@ -851,9 +851,8 @@ efi_status_t efi_add_memory_map(u64 start, u64 size,
  * efi_add_memory_map_pg() - add pages to the memory map
  *
  * @start: start address, must be a multiple of EFI_PAGE_SIZE. Note that this
- * is actually a pointer provided as an integer. To pass in an address, pass
- * in (ulong)map_to_sysmem(addr)
- *
+ *	is an address, not a pointer. Use map_to_sysmem(ptr) if you need to pass
+ *	in a pointer
  * @pages:			number of pages to add
  * @mem_type:		EFI type of memory added
  * @overlap_conventional:	region may only overlap free(conventional)
diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 89f22388fc4..157ba5ec50c 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -298,7 +298,7 @@ efi_status_t efi_add_memory_map_pg(u64 start, u64 pages,
 	if (!newlist)
 		return EFI_OUT_OF_RESOURCES;
 	newlist->type = mem_type;
-	newlist->base = start;
+	newlist->base = (uintptr_t)map_sysmem(start, pages * EFI_PAGE_SIZE);
 	newlist->num_pages = pages;
 
 	switch (mem_type) {
-- 
2.34.1

