Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191AAD70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:16:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238C589D48;
	Thu, 28 Nov 2024 20:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DfDaUo40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCE689D6F; Thu, 28 Nov 2024 20:13:41 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F188938D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71d46ace74aso437908a34.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821215; x=1733426015; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v5DPp8kUN3uZhiYiZwHs5d6pabr4Avdp/tIomPwJmaY=;
 b=DfDaUo40FlZrJNWy1FQEOqVYwi4RfpdrfBxXCiUawybuJYGLwR5yZw8MCUhM8o44v3
 Bbi+TdUeOBJFEtdmb9soKaWS/F1Wr1MNydPhhnfRhg0nTL5TMIkcWJniVAg0/K+13XTD
 6jSj2IeueaYhgVgmJcuNt7nNUO9lE+5NRPmyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821215; x=1733426015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v5DPp8kUN3uZhiYiZwHs5d6pabr4Avdp/tIomPwJmaY=;
 b=lVpoxvXKe8CRDY3XQOFjZlkjmvRU2Lk1QaAg7nxsoPxZPxMRWq92vM9kL6DPVXSQDS
 2pPxSSJk5EjxikLogWZ+2c3FW9PMgqBWt69LaTJKp8Zi9lHHlkGlCuQHY+M2NfTMhjX6
 WeVX/WK5zFufKy/Kwd+LliUwuAah9BMZLVkU25717Q7Uzp31qzMO4FRAmFVdQHDRtEga
 5eo2y1+Mp+W5J0uVvNQkZq6IAJb7dazeqOfROUkELpIpacH7TjM7tMSAJFXaKO1QpdrI
 +PzdmGLg/w9d4ROFBdj/5xrieSAPQ3TvPmPHaIinhMeTKVqlXX2l6IuJcSGq7mDnNKs8
 v36Q==
X-Gm-Message-State: AOJu0YyhI/qpXi1HsmFk2HdbOnloo1FUR/RYMQnW6w92myqZFryxWA7T
 WieqyQPPIycMUfbnhXCRn+hLtDIzJuXh4J1MRzd4ic4vjlXGnUdd/WZjGzjKAQfPs376RUR50rk
 =
X-Gm-Gg: ASbGncsADvgsB4jC6XUeXYk5f4BpIGo3uTKQojkQPFcqzyPkB1OxyO1OU26x8xYUy0c
 YNWyhwhE5wt4aGYyn24hZrILjiz1A0Kdn6dB125Of6fVsqv3xSutPexYGiaPIsg4bJUuHzvttiR
 ZFSwVCeZk7LyPfwm9NasrupLqxXphxMmcvWV/4aq+jxHljy8L6H6G0AgYJjsotsJIS7rLZfC/xr
 Pk9ZcXDTVKi/u/aNoQAo+p6mMKlJ516kVrcAFdMb5zntA==
X-Google-Smtp-Source: AGHT+IGNObexGtBvdAQgUx9R6e97rVi3y5L9AAMtV0hoNYn/jECh9OgARQXmqCvXX9jc+VFyRpbz6A==
X-Received: by 2002:a05:6830:6509:b0:71d:50f0:afbf with SMTP id
 46e09a7af769-71d65cf91a3mr8012764a34.21.1732821215403; 
 Thu, 28 Nov 2024 11:13:35 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 19/28] efi_loader: Update efi_add_memory_map() to use
 address
Date: Thu, 28 Nov 2024 12:12:35 -0700
Message-Id: <20241128191244.900006-20-sjg@chromium.org>
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

