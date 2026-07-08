Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBAAC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 01:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7250784A0B;
	Wed,  8 Jul 2026 03:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="epG3tZ/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B438849D2; Wed,  8 Jul 2026 03:30:27 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F7EB8497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e9eaf04bfaso56518a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 18:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783474224; x=1784079024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NB4JzuA6RY8q8ApNvXM9ZKoMgTZdYzmp+gwvC6SQ60=;
 b=epG3tZ/jYbwAW4F/UUthWBUShPSquIbPidQ1+xaFcZ6SiPpxDj4jJwyIXO072nVyaw
 L6PgUn46xbo5C7ZoGh77UIINzv4G9jrl8cN7rGGlJgQlQsmpp3gBKBF8lIjs/ha/zzPH
 Ke3VlFCInwaZn5OTIotVolPAMfujg9SLmsK+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783474224; x=1784079024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0NB4JzuA6RY8q8ApNvXM9ZKoMgTZdYzmp+gwvC6SQ60=;
 b=JSpWqHXoS8WsVYO9tqDJ+QThZT1xtoc5H6hWjQh/aKpnzIRe22ae8hTRHeWSBjxwea
 GYw994HYTy3RhCpqE+pUTQ3UeoegOk6amzJ/OcF6ouP5lbSFRU42lEw8rpTFYruviXiG
 rc++mocO6ha8si5IMstQY/iXBCSXV4CfB8oRRzvPoFwAj4eqyNQss4RguYuBV5zGh90v
 xg8JsIcoXr4F8M8umSGh5N/8JH71EZ2teCmNSm882ITozA+6NpoLvfz9exvKxnpzGM+B
 DwE/ZSPnddmJSvYFT5l09m+ZCvSuIMV1VPBHySxycVQ893ej5C+47PvaK/sxOtjJhx8V
 aX2Q==
X-Gm-Message-State: AOJu0Ywr8d3bveV6KStBqWA8sYsgmHvO1BoP7XYbhcNZ+lLp9ASb+LKm
 Z9Ulb3p4Rp7V9DaORZ/81TEuyeF8qkfsBb4zrvL4LuL2mQrCHhMoaRIJL8OjNazcylY+Ru7eszF
 AZQYQUuk=
X-Gm-Gg: AfdE7cmarZeUoTJg+2aFcsrT1isfnjPaic14AzRrZ3AtM6Iq/72dSh645cuIwRouoYY
 M+N5I6DkzA08ICu6elmvUpRQcNxSQPH3r+8sdYjsZUTsqixVWhyV14o8oMbQoR4396hb576OJTO
 AAdZDerrsfkYKEi7BrdMq5Mzj3Fjv+pWAr/8LitROqllhqZDEOEuUa/xlnXj+qcOjrfGQWwkEbv
 PUSrevDndjlHHO1DtSgTwGSAB5qBASkh3tKoipUK4S5OMK7e0nlhzVhR8dSMUEnza/oVUuGZz4O
 nhLWAeQhiipbQ819WlyKSVuNHDJGlXWvmghDFkXKNrRQIWnHbQzNlohiHEPobX7vzgp5XpHgXC0
 0Z8jqWtBHdzQODS9gEcXubKwjVmj/gWQo9eeBKRvZ7hp6sIywMzta6R1Ka+BBvAom1MLQ961V0J
 qi0XjmJP1zXVAtMV/fnqes4DogTmcrXI26WRFlADBx9pSFcdgxF5XCoIuQkyyYiO3sXPa//sbUn
 7MHPcpjWInRm1t7O8PRDf2N68Tm9XD1kz8QiJkkPQ5Q/cHKe8uJCx0hdlgRKw==
X-Received: by 2002:a05:6830:6a97:b0:7e9:cddb:142a with SMTP id
 46e09a7af769-7ebcfe5d840mr262462a34.7.1783474224124; 
 Tue, 07 Jul 2026 18:30:24 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcaf77ba4sm780182a34.9.2026.07.07.18.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 18:30:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymondmaoca@gmail.com>
Subject: [PATCH 1/7] lib/fdtdec.c: Disallow overriding the fdt address with
 mandatory passage
Date: Tue,  7 Jul 2026 19:25:11 -0600
Message-ID: <20260708013019.288985-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708013019.288985-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
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

When we have CONFIG_BLOBLIST_PASSAGE_MANDATORY don't allow the device
tree address to be overridden. The device tree we're given is the one
that must be used.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymondmaoca@gmail.com>
---
 lib/fdtdec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b91e067106dd..ecb22a58b964 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1856,7 +1856,8 @@ int fdtdec_setup(void)
 	}
 
 	/* Allow the board to override the fdt address. */
-	if (IS_ENABLED(CONFIG_OF_BOARD)) {
+	if (IS_ENABLED(CONFIG_OF_BOARD) &&
+	    !IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)) {
 		void *blob;
 
 		blob = (void *)gd->fdt_blob;
-- 
2.43.0

