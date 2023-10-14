Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA6ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7295C86F15;
	Sun, 15 Oct 2023 08:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kl6N8iMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1276686F2F; Sun, 15 Oct 2023 08:27:32 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE63886BCD
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-66cfd35f595so19897136d6.2
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697351204; x=1697956004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=drtR4h46Sosj/J/MkEWhL+uPjz7j8iUvIZAVDqCo8mc=;
 b=Kl6N8iMI7FszL/fSaaQWIzp+kxrgGVHqp3KGGdFfoe5wLyxxwL0rscjuyzi2tuMv1E
 ZsJ0nfYdOuyDgM8sBtaI6aqcPzxooPB3mlBoAqnUqPNIetrwTVfBXWAx0nARrOI75uQG
 7thEZ+AATw6rEAAEtS5+T3S724/6H/IFDSECrAs4v1B83QlSLIeSTyM2bIwY61st6iBG
 adGUrw7NT4UZqTIZG/q9eLsW+vDy9wv+AGg/p0JyTno6t29DXzB2k5WNZs2EefbhlsqM
 Rq74hIruaWwZUGT4jSbvG6ZVvrr6Ol5xZ3NCrUO/jYyJKiPOJ7qwN4PgRUvvGb60ploz
 871A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697351204; x=1697956004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=drtR4h46Sosj/J/MkEWhL+uPjz7j8iUvIZAVDqCo8mc=;
 b=HZITbhxGCBRC/ZwdGwTnWO+Grma4ryl6ejWIozXpJUr1JOISRIPNRqwpwVAz2pFkq0
 YrEla165MojqPsI/Kx90wXYcS5y+PpiwwCNwjXeiCF3tZkP3C1h6D02uqrDIIGRblM/W
 M68HCJDpE+Cvu9Kb++KrG4bsVdftXSJirX26vxDGpLF/97CyP134zBvIKHVK8rjRQdWI
 gLOxZanmSk4AzgWTp5du4VUZ2bIwAiZuxD5Ti68dNJLbJvquoCFLfzFchQn0y9QsG/z3
 cVtk8/0Ev5e9EimRMHdLVY805ji6hmVIcDvYrhcEYFvRhSOURIOLWAf8e+7oxlLDs2gJ
 Dr9Q==
X-Gm-Message-State: AOJu0YxPdYxyNZqOqmSvKVcdZAlu4tG1iLFvs9Bcvm+X5qlOXMnk0tr0
 wgIiUd44UxTV19Ukexch2lcdMVEhyeW3tw==
X-Google-Smtp-Source: AGHT+IHZNcYO8gpQZxRMfUIQZRfGodasZ/kA4TT8hsnYoURUl6ZjYZE8cb6vDKb53SoJMzYP20MHmw==
X-Received: by 2002:a05:6808:cd:b0:3a8:7c67:7cd with SMTP id
 t13-20020a05680800cd00b003a87c6707cdmr31587516oic.24.1697316489144; 
 Sat, 14 Oct 2023 13:48:09 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 bt15-20020ad455cf000000b0065b2f4dd300sm1960522qvb.90.2023.10.14.13.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:08 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Marek Vasut <marex@denx.de>
Subject: [PATCH v2 01/29] spl: legacy: Fix referencing _image_binary_end
Date: Sat, 14 Oct 2023 16:47:37 -0400
Message-Id: <20231014204805.439009-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

On non-arm architectures, _image_binary_end is defined as a ulong and not a
char[]. Take the address of it when accessing it, which is correct for
both.

Fixes: 1b8a1be1a1f ("spl: spl_legacy: Fix spl_end address")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use "address of" to describe the "&" operator

 common/spl/spl_legacy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index 095443c63d8..e9564e5c2a5 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -19,7 +19,7 @@
 static void spl_parse_legacy_validate(uintptr_t start, uintptr_t size)
 {
 	uintptr_t spl_start = (uintptr_t)_start;
-	uintptr_t spl_end = (uintptr_t)_image_binary_end;
+	uintptr_t spl_end = (uintptr_t)&_image_binary_end;
 	uintptr_t end = start + size;
 
 	if ((start >= spl_start && start < spl_end) ||
-- 
2.37.1

