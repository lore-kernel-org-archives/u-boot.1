Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BA6C02188
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 16:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5845C81292;
	Mon, 27 Jan 2025 17:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EC8djeQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8BDE81417; Mon, 27 Jan 2025 17:03:58 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB7281292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 17:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5401b7f7141so4125699e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737993836; x=1738598636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fQUXt6ZrJEglfv7S1MQenB5YG6nqB/C3HhxyzNqF/P8=;
 b=EC8djeQzMPmS+618aeyWKzPJc+zgUpefi4b4MGZBjk3Adcs3qQrGboWWSiM4Qlbmnv
 hC9L+hODcDoj6Lics6aOwSohgWZpnemSO8f7c0DPpoXm45VDu55DteLRREfywiFw07dF
 iw/6035FBgZQwJhhZtmTRV5g4Oh3Mz9CPVzGGRdAlO2unmZm283RaXcF9jMhBptm4Fu+
 i6HXtYQCndMdMsWbKg8vP7fW06a+xxnT9qtyWUfDqPeabeKErUZA2qYpGtHC1Kw3xta7
 CtFE93DXIzvqZ7g38X3O5a2Er0pxaNhF05lby+GsZbjhGv73kvGHPlKcEeVptocWnQGl
 qN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737993836; x=1738598636;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fQUXt6ZrJEglfv7S1MQenB5YG6nqB/C3HhxyzNqF/P8=;
 b=QCRF1BNmGLrHoa2yanMmOEbIHULvZ3HnjxK2ZnZamMUZepI07yr9LdCjHPa89R1NFG
 +CX98huwHM7MriFG2MMd1vNTWt4BBENpabQtf8e3+zikt9m+knqzy7xZCk6CIrH8xZ+k
 MZefiwnFlL2VRmuuzOdFi5HjZ2fxTpjnw1PvYRS/DCtqfrC0hWhX8ub7Ec+cs9PFEBYn
 I4Q+VU22JYbzPYDlOzckYfqVL9fASHlj8HXHhXBfCquRS1DGg+bMet/vkl8jUQNuuGiw
 cIN9X+OXDnR99q+r/16VEVVavek/T1whQvUuuKsbmHTGwOeX0UsInoZzn1HXmlVHIyMN
 5jFw==
X-Gm-Message-State: AOJu0Ywn6PsPnxN0nM7TM9Chmkr4Pw8SpoNYusX9yQmafYRf0y4Bxp5s
 /4Y9DUwnF16t5eknbsKLITeVB+OJH1uASHvKDTwwXnr/WZPhrpaDEm9WSA==
X-Gm-Gg: ASbGncveSPVbLx9OGjxaq8qL+tSf28mk8jNP06DbGS5lLMB4Fvq3eZDpO70y5NBYWZg
 At26+kdkjf/KBFb3w/5ckdkCZxdU+aTqxIzmN2eJuUdPWmvumspb7eTb9PepoF0fb7ZFqylxxiN
 UtE83r+/YEQxwUIuGRMIB6Mi/AH/q5LJ+5HNAZqUlzKI1iNsf+41Wjwmm+Fc/TIUHj+uH7wsMZ7
 rfotfsj45+sUF2RE2LcV1v0xf2ztWUg2nBW48ykSRVYAjID6n57QaOjKzv40hCDWImODktGXgiY
 tawtIR4yR8HN
X-Google-Smtp-Source: AGHT+IGqOYuC1wERl/uWE4rKn/LtrzzXFiI0kxVJZO5q0N3hQNht7PjriXu+SOXFF4OzUdhoaV2kYw==
X-Received: by 2002:a05:6512:aca:b0:53e:3804:57ae with SMTP id
 2adb3069b0e04-5439c27dfaemr15443636e87.51.1737993835506; 
 Mon, 27 Jan 2025 08:03:55 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-543c82289b1sm1351337e87.4.2025.01.27.08.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 08:03:53 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] common: fix incorrect comparison
Date: Mon, 27 Jan 2025 19:03:50 +0300
Message-Id: <20250127160350.312832-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Jan 2025 17:28:40 +0100
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

The variable n, which is of type size_t and cannot have negative values, 
is checked for a negative value in dlmalloc.c:2107.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 common/dlmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/dlmalloc.c b/common/dlmalloc.c
index cc4d3a0a02..a4182a8dd6 100644
--- a/common/dlmalloc.c
+++ b/common/dlmalloc.c
@@ -2104,7 +2104,7 @@ Void_t* cALLOc_impl(n, elem_size) size_t n; size_t elem_size;
 #endif
   Void_t* mem = mALLOc_impl (sz);
 
-  if ((long)n < 0) return NULL;
+  if ((long)n <= 0) return NULL;
 
   if (mem == NULL)
     return NULL;
-- 
2.34.1

