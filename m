Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C273C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 12:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4C958304D;
	Tue,  8 Jul 2025 14:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aNQwnISt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE7D8305C; Tue,  8 Jul 2025 14:13:01 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 990D083015
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 14:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB44C3F6A0
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1751976778;
 bh=YFsILjV7xD6V5YJCenMP2lgA2qwvhwIOOVF5SXVKHb8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=aNQwnISt8fXE3p6z3lCZV0asB2UHa4F3ISgMmf2LsxflbLTIpn1JJ2H8t2GqbooNo
 0i4Aaxk4EwUVJoSA03d6XUJCxDIvCCwUWY67rvDxogMDZy09K/nd0b6ldG/lS4gEY9
 4lfmsAVyI/Z0n5UROUhqt6g4eof/0OEZsDN/rb+Td6h/bY0ocdrYD3EVLt46Paj+SE
 yyTHRCi/rAogoWhS2ezllBuVwxbX9HaLN4Ffoz/sDYtIuyNRs0XDagKOS3OjGgE8pu
 3r9MicoZkhe/EXpmNSfI5s7uManhtYjkV618K6jIJ2YcBgcCDeGr4SrrxLbS4kcTko
 NCetrPei5Dw/w==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4edf5bb4dso2666423f8f.0
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 05:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751976778; x=1752581578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YFsILjV7xD6V5YJCenMP2lgA2qwvhwIOOVF5SXVKHb8=;
 b=m5OW86YSdjFuE4nIIaiIHTfxXWTcGWweprIIO4wwe86cMib++JV4qogiBmbUi9BBCN
 Jzrs/JFNcmNOR3lAdnQt8mAc4Wb5AFwTe56kI3LCV8i6IEs0ZHHbL8ZunxhdxOQvSYD1
 l/q2pWNtf1mc+iUrQ6RnMMp+/fCL6Vbg/3oavcHyX6/hexgEBJKcx/vJvvYIBGNKiO1T
 FFFfqPI3h2F07vRgrqURn3OeqqwYH1vnH7vzKiMT/4aQP0ygHjxBRdN8VB1Bf9onN+W7
 GkAnBJQ0GxiksUXSt/L2AykMuEgqEwr/AUGFtMEPwPRpEo2C43ZjbQrB/7UWymHlK127
 3g7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV66J4PoE5Mp6OWrRY5vuWWBch6AOlU1IakKKMm+eTOhQy+HCi5nZAlbpaO04jrmKMvJMkn0i8=@lists.denx.de
X-Gm-Message-State: AOJu0Yxum1r8NS9y/IMS0jlYhnTMoyO4SVbgMECwSdb5lxQJSYU7uNRL
 06w82z7GGOTfsEbI5dczr6wpGQFKjmcwgr7rQdJ5NhWPS9kH0MTDbRabkurli7sTlWxQkt74G/Z
 ULS4k2BLwg9VxnNnoTXEbPGvgJPCgHUc9Nwrylb/7OQFDS6xHzXXtbkan0WBlDki8lI06tk0=
X-Gm-Gg: ASbGncumMVoYOgeOByHC7OaB26jStjFacVPFPRAQprxUvLN6WyIjhJOpofeHIK1ymFm
 Qtgtni4Hg1lHayVceqCfVmZJW309GUd6jltXDUeKmcBxwOTTrmQiWue3pRi5Z7wR4tNKXK1fyap
 NjiQdIYI/ofUEbb+gJrmZQInAqO4MQeSA2pVsjY1FdN4NXJ0UsFNgnHNQloyNM2L9ZF45R0dObC
 WwuXGDpt7udA4meuIro/G80MjiHs/ZJhA9vGlvvKoU7B1AApEx03zawTakxOW5hoEsNVNxkA0SH
 CSMfp1WJwwCeu3pyhsV2kcWE05Xsxw8A2aQ+S2M4O7iwTQwjLIYHHwo8bwdK/xEEslX9WbD//vt
 0w09p8kM47SSowHJRC+LTD5yZ
X-Received: by 2002:a05:6000:2409:b0:3a4:f787:9b58 with SMTP id
 ffacd0b85a97d-3b5ddecd0aemr2401022f8f.58.1751976778009; 
 Tue, 08 Jul 2025 05:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnEmPU3ifqNPNiw03YwRbhVO6YKSv4DVuisIcP5eKOa0IVNoWu49XBEYidd02FN0qsX791Dg==
X-Received: by 2002:a05:6000:2409:b0:3a4:f787:9b58 with SMTP id
 ffacd0b85a97d-3b5ddecd0aemr2401002f8f.58.1751976777656; 
 Tue, 08 Jul 2025 05:12:57 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c919sm12910007f8f.92.2025.07.08.05.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 05:12:56 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Janne Grunau <j@jannau.net>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lmb: add missing fallthrough in lmb_alloc_mem()
Date: Tue,  8 Jul 2025 14:12:51 +0200
Message-ID: <20250708121251.83980-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Add fallthrough to clarify the intent.

Addresses-Coverity-ID: CID 569481: Control flow issues (MISSING_BREAK)
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/lmb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/lmb.c b/lib/lmb.c
index 45b26512a5b..e5a0677e3f9 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -762,6 +762,7 @@ int lmb_alloc_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
 	switch (type) {
 	case LMB_MEM_ALLOC_ANY:
 		*addr = LMB_ALLOC_ANYWHERE;
+		fallthrough;
 	case LMB_MEM_ALLOC_MAX:
 		ret = _lmb_alloc_base(size, align, addr, flags);
 		break;
-- 
2.48.1

