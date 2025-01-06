Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150B7E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25D980612;
	Mon,  6 Jan 2025 15:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="APIzCd2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8553580612; Mon,  6 Jan 2025 15:48:13 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4890B8056D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3ab2f414695so51650275ab.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174889; x=1736779689; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwWZvUbmDOfHKdhbO8JFvUEaTjz1RLbLcA6QVrPvH0M=;
 b=APIzCd2fFqAH+eR32pb0uDJbZTSPr05JgBYUQHUq278V1+N8EAwwCdcVxrqxJxoLuE
 QN+yroweZuQQraJx0oTQEj/Vb2NHWjHRcgJWoRQPUrW8Sc/HrRLiMmZmypjBrOgmbOgw
 DN28icRQSKbZgBtkIz4KqZve8ZYH4olBScfJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174889; x=1736779689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BwWZvUbmDOfHKdhbO8JFvUEaTjz1RLbLcA6QVrPvH0M=;
 b=L4cR48N3U0bVwK1DpL1rUvG2YAYYVqThiS3vM1xX5JaW/om8SZ2rEjxsZaJyacPrgJ
 Ro0JF4fLVFmNrJ78JUjAeOEHDgw5+mtwfl1rInz0Lhz4sCJeLnxW40hvZMHZQ/wwpLim
 9LKP9bPuhjn/rBlz00kBm7gFhkd3WXBsK0Pm1ZlO3UkeXDi5xSWUjWBzMll2zVsfQPOZ
 9tP1eVXhKP63cA1h0zsEi4+91IZnFmhHr4kRG/S+qUAZSRfx/82i2h6UX3YuVFIRDAvK
 XVaN3hNgcpe7IcdhNezkqCU9ddNwneddwXqC2lhri6eqNGADwdrCMg66yXWn9FCSEUln
 cWxw==
X-Gm-Message-State: AOJu0YyXjyxeV4jAjpDMGe7yS0SYsSWVHR5DtTeBCCBOG2Lmui2E2HIY
 x5TiYRuNtbeKE4rzioV8ChZ1oopfpu726Lc0YgC+aN4YNVy90Um1x8u8l2mNHHoMsuq+baX+tM8
 =
X-Gm-Gg: ASbGncvsNNgKDZQezIWb4mwr+VlQBk1C/k+kD40GN2sz+bR2AKfJW+d82bKu9hzr2rE
 +grBEqRm6YWH8tlqGhLz2y0qo+8eOJtNuhmD7nXpw485lFbnlFH3SUgq9WCgQBhAhWpLE88KZui
 +QX7dsu0F5B5uXL04ySTK7dp6pRf8W5ZkbWRx/LfuzSkoo+UOPe5fvSwE2f1fJVkYF2nJYDBcSa
 27eKxzV5zpDHBMhX3HlthaTVJEUirFa30GFPRt/1jGt/fX3Q3ptTRoF05bQMOFpZnhoshCd3jt8
 IPQ/rpGJ6OclECKjGw==
X-Google-Smtp-Source: AGHT+IGpTePbZhp5VLpfHx/sTyysaAxHlgasx3l0pOS1bL12doLpQf5VlJU3YF0MK6LdQ5ZXH4NlVQ==
X-Received: by 2002:a05:6e02:310c:b0:3a7:8cdd:c0d2 with SMTP id
 e9e14a558f8ab-3c2cc083da3mr460672965ab.0.1736174889484; 
 Mon, 06 Jan 2025 06:48:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c37bb139a0sm94081185ab.70.2025.01.06.06.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:48:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/8] efi_loader: Return the memory map in pointer format
Date: Mon,  6 Jan 2025 07:47:50 -0700
Message-Id: <20250106144755.3054780-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106144755.3054780-1-sjg@chromium.org>
References: <20250106144755.3054780-1-sjg@chromium.org>
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

An EFI app expects pointers to be returned, cast to u64. The conversion
to use addresses missed this, so fix the call.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 321a8c3cf31..2e197e94edd 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -735,10 +735,11 @@ efi_status_t efi_get_memory_map(efi_uintn_t *memory_map_size,
 	list_for_each_entry(lmem, &efi_mem, link) {
 		memory_map->type = lmem->type;
 		memory_map->reserved = 0;
-		memory_map->physical_start = lmem->base;
+		memory_map->physical_start = (u64)(ulong)map_sysmem(lmem->base,
+					lmem->num_pages * EFI_PAGE_SIZE);
 
 		/* virtual and physical are always the same */
-		memory_map->virtual_start = lmem->base;
+		memory_map->virtual_start = memory_map->physical_start;
 		memory_map->num_pages = lmem->num_pages;
 		memory_map->attribute = lmem->attribute;
 		memory_map--;
-- 
2.34.1

