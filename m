Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DEBD70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71BB289D75;
	Thu, 28 Nov 2024 20:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fbQnMWDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D8A89D91; Thu, 28 Nov 2024 20:13:48 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0538389D7D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2967af48248so633550fac.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821224; x=1733426024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kKT9HoY2+7KH63qIOQXaz9mBZ0nLzOo2Q/+WA0kqS0=;
 b=fbQnMWDrYvU9O1cuG981rO4uffC5CRdU/ozxFof88DI93j9E4wcFEvYfI3uOHNItZb
 o6/uyH/4agg9Pz/ODitS0lGo8U36BDyWJlV8GOkj6PA7tfV4guY747kk+xOXLDMV06FV
 WQaY+MRTMfvluUHVEZW8LXe0SC5yxKAat8uJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821224; x=1733426024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kKT9HoY2+7KH63qIOQXaz9mBZ0nLzOo2Q/+WA0kqS0=;
 b=qKwjji8MFYZ18uBWd50aiKaaeezv+s4Cx16DUVUsluCWaQXWIpUABARmDVDaZm6EYW
 IMNsgOVSJH5VjIGqjeXIW+Cw7f0kLFJrtbKeI/lF+N+1SNojmL0c+9Bc1BHaqUfrgKIT
 frnRjeam6RNFUAvj5WH5FbUGnH9WMft1PnGCYDyKbdwcHkjqj4/xbXYPw9D04dLAKIjD
 tFQNr3gFThvcMz59M8MEWw4IN9UtTVavl5pKm8Jr7VkP83Pppun1MEeSUkF4A4EsKm5i
 dP0llSj4JjfQrvgEE2bZQ6KXNBQdarz8CTT6r9lZd9ksq17FcqmLfv/v93QsNjxxj/Ks
 GwoQ==
X-Gm-Message-State: AOJu0Ywc81tZ0v4TmcmbDThyxdhhrSHhknfIYPp4YsWI2bkYiovIZHh7
 R9E7ng9/q+w4hH3iIygxl6gpIEGwIE3Pt7cxW0iy0QhEsM/mW6mt4f7Hxo07csykip1Jy1/mmwg
 =
X-Gm-Gg: ASbGncusF3OvqVHo9gnYXFQGahSdomRqlJKNdAoJuVv/am8CAF3rtNmXvF2OUfzRI49
 nc32vevX29Ua1s3MDcvVOgB1YjnuYpgy2y+rti82DqHlkCEWhdgcP5HCMR9ZeD3RLy/VGJ5WSpn
 zfucfXWZ4+xIPXoDjfuoc8GFdM8JbE//OXn21Dz9KzDAxJFNULgliaDAjPEV7/kuMFS6gjlQPr4
 wWEE3x73w1IE8KOcTdKWxml0jcs1ByUA/FgPtBkjGxx/w==
X-Google-Smtp-Source: AGHT+IGsYiK3K3i3tvcTrZR8SBB8mfNhTwiyRUr6q5MVrwgM4cUYGGco5Rg9yhYMKpDkUfXApYZ5kw==
X-Received: by 2002:a05:6870:e356:b0:29d:c85f:bc8c with SMTP id
 586e51a60fabf-29dc85fdee2mr3186581fac.36.1732821224254; 
 Thu, 28 Nov 2024 11:13:44 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 23/28] efi_loader: Update efi_add_runtime_mmio() to pass an
 address
Date: Thu, 28 Nov 2024 12:12:39 -0700
Message-Id: <20241128191244.900006-24-sjg@chromium.org>
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

Now that efi_add_memory_map() takes an address rather than a pointer,
do the mapping in this function.

This is fix#4/4 for: Update efi_add_memory_map() to use address

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_runtime.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 9d3b940afbd..37ed5963e2b 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -13,6 +13,7 @@
 #include <efi_variable.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <rtc.h>
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
@@ -930,7 +931,7 @@ out:
 efi_status_t efi_add_runtime_mmio(void **mmio_ptr, u64 len)
 {
 	struct efi_runtime_mmio_list *newmmio;
-	uint64_t addr = *(uintptr_t *)mmio_ptr;
+	u64 addr = map_to_sysmem(*mmio_ptr);
 	efi_status_t ret;
 
 	ret = efi_add_memory_map(addr, len, EFI_MMAP_IO);
-- 
2.34.1

