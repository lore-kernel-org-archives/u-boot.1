Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840DFC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:33:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E97E88BFB;
	Thu,  2 May 2024 03:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ITgFdLOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD6E88B93; Thu,  2 May 2024 03:31:53 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5436788BF4
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43a8246b51dso38288011cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613510; x=1715218310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jcDp8A0nffEY8McOU1bX8tI1zw0tcOz6P2gweaYkb/I=;
 b=ITgFdLOU3BFLOuQ/gZlsG1qeVTcx9sPKr5U183vg7V7jUrELPlShO2KdEjVkSK4gzt
 i8Tf+yTImoFgSNUELn3sE3GKFJURN0JUJaIipAZjhBU6yJFwstXQmGXUiCZNawE+vcVz
 TFdUXOrslXRDF0Ull1hsZ3CCqfrjCu86pS6Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613510; x=1715218310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jcDp8A0nffEY8McOU1bX8tI1zw0tcOz6P2gweaYkb/I=;
 b=MXK0LAAbGpjci0znnwfROCW1p3rdeXzfPObZz2iu9A3RqMgDdR/UaQU2G05oajBDOK
 SJWINT2i6+aT4m5AkrUl/n1NUp2/RF4hdAekrYmBgzV9KhKEVMY9ntColbWR/1eFMDao
 REmQ9slgippmFXbgx8M/txyTerLOws5cjwmEdllG9XVeBGj1RUNj/wv1vDg+whBQET0T
 g/VB3mX2Xsx963sqgUs0ciNkgoAzEjNrSYUigcwCheBEzwniAoZyH6auEd29b1ph0DqR
 RrUldFXLripLM6OiZD0xIp7P9pH9JjshrkkS64fTlsOtN6uQw6yJ3ZYXK3Y580PmvxA2
 cAFQ==
X-Gm-Message-State: AOJu0Yx1KXntsBD85m8WBZo4nglkOA1ai1noAfweGt7+qq0HCj+RNSFM
 WpMppeJIjgMi5TchZVzORMq72usrLDZ5zMLvD7lMvdGRtqwFILCMMywLA1o1Z6kPHTt9UvYd3Zq
 F5pRUFlBH
X-Google-Smtp-Source: AGHT+IGtObzhnDMQEti4+mZ19YsyCzyKLiKqOWkZY1WHfJMVOR+6UVhvyRkVSpaqZD5GGLo9CcFLbw==
X-Received: by 2002:a05:622a:2c1:b0:43a:a255:cf3 with SMTP id
 a1-20020a05622a02c100b0043aa2550cf3mr610301qtx.63.1714613510057; 
 Wed, 01 May 2024 18:31:50 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.31.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:31:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 08/81] fsl_ifc.h: Add <asm/ppc.h>
Date: Wed,  1 May 2024 19:30:25 -0600
Message-Id: <20240502013138.2383421-8-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

In the case of PowerPC, this file needs to include <asm/ppc.h> in order
to resolve all of the references it makes.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/fsl_ifc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/fsl_ifc.h b/include/fsl_ifc.h
index f9a0a7017d4a..4991d9322007 100644
--- a/include/fsl_ifc.h
+++ b/include/fsl_ifc.h
@@ -12,6 +12,8 @@
 #include <part.h>
 #ifdef CONFIG_ARM
 #include <asm/arch/soc.h>
+#else
+#include <asm/ppc.h>
 #endif
 
 #define FSL_IFC_V1_1_0	0x01010000
-- 
2.34.1

