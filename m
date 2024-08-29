Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFBBC83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:59:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D71D88C7D;
	Thu, 29 Aug 2024 16:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b4Ae/waI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B14188C4C; Thu, 29 Aug 2024 16:58:24 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5D988C4F
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-829e856a159so36152639f.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943501; x=1725548301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fbFHuo366UOzjd1TopN6GKVwDGnUsMhtI4cdRsRc2Ac=;
 b=b4Ae/waIiG5Q+5DyV7uYkEA8+ZerorT8Lt2tN5eN5npYnBK5aElnfNriiQHpS+sYQk
 YCr06uDf6d0jMJhQhYUHys14O4QHlXVDbTGsLhbLR7S5QFddOTac0ngddolxhTb4zeyh
 fV+bKdPxVtc5H56JR/dcQpEDjed/alTJmbZdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943501; x=1725548301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbFHuo366UOzjd1TopN6GKVwDGnUsMhtI4cdRsRc2Ac=;
 b=W/cUwhvBMmEIlX7m6i/DHlLRhxcCC2NoyUvh10P1PnGvrxi3KAu3P7QGPixADOJfwC
 r3Wwc9telFeeATVosH1i1C7Pdp+PIOQBgrd+iXnjiFihb7oVADsG91ArFcdGfD3i1JWm
 0PIwsFTn0gWU4v2vSd4+HpHaCKYJb82NiD3a8Ebkb50xIT9fUUen2HoxOBBXQpZF/+pi
 WYbj13n7UxMWTxcZM1QfKeA9mDY8kU3NaGamyDlTKYbV3AxrFSIeu83s5YdEAGcKdOqa
 vlMS9O9+GJswg2wboDSKKd2dgqhTP/M/+lu587e5wYK1Z3/6/jnRcl9JQsWUi4xnnW85
 sGlA==
X-Gm-Message-State: AOJu0YxD0vtXgbn1ve8+hLVaWSOPUMiZRu5pT6jND4Mvciz45aWQMIKB
 pUfLDY2zBZBI/pANqjepmaNEvbG77aGkGKLcQfsuFTgpDZLvFVeWBEIFnFEYrsJRJFF75kBbmIw
 =
X-Google-Smtp-Source: AGHT+IFlkAelaZ071Iei/XGK4Fa6t1cZtNifJhc4GG4crvVrm8VOmJY2pU+PeH49KWjJ+jpugS8Y8g==
X-Received: by 2002:a05:6e02:16cb:b0:37a:9ab7:ce34 with SMTP id
 e9e14a558f8ab-39f378608f1mr40809105ab.19.1724943500922; 
 Thu, 29 Aug 2024 07:58:20 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/19] malloc: Show amount of used space when memory runs out
Date: Thu, 29 Aug 2024 08:57:49 -0600
Message-Id: <20240829145802.1827952-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

Show a bit more information when malloc() space is exhausted and
debugging is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/malloc_simple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 5a8ec538f8f..f2b3dc53689 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
 	log_debug("size=%lx, ptr=%lx, limit=%x: ", (ulong)bytes, new_ptr,
 		  gd->malloc_limit);
 	if (new_ptr > gd->malloc_limit) {
-		log_err("alloc space exhausted\n");
+		log_err("alloc space exhausted %lx %x\n", new_ptr,
+			gd->malloc_limit);
 		return NULL;
 	}
 
-- 
2.34.1

