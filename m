Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0854FC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 16:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58AFB81DE3;
	Tue,  1 Apr 2025 18:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YsZchXFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C841C81EC0; Tue,  1 Apr 2025 18:21:30 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 935C6817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 18:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-603862f3f91so620496eaf.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743524487; x=1744129287; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9UaTihw8jYvFo78L2RrSuYx3twssAqFPlLhmh1P8CE4=;
 b=YsZchXFYZ29TkAk0IzjIDydExpblp5JUd3JBFY/vi9x1CjAzBoo8HY9IR7lXP2LrKe
 TMvrticfRKd7ZLzh+9H9H7kO5AVmnivwBNLnjyHI6Nhzu21Q2+mldICA7eQSMoykujUx
 1TsWy+E3Ol+ggfnKLU0VaaFRG604JuDHhg/5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743524487; x=1744129287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9UaTihw8jYvFo78L2RrSuYx3twssAqFPlLhmh1P8CE4=;
 b=eyubV8WuLYLkkFFA5MA1c4SYzqK/94WncwLqIAv8hzrskJ6w7i4F96pkOrN8rt10kM
 GtBIKX/jFGXzyCbqbOqFeArjtYKi3weFQKH6KA7+D5GL6/896xrxbLtNXzg8VkOcDqj3
 PjC8JFqqaeauJkCh/UjWEnkurFCLg6CNLMKw7PK5rxQV1ZyGyg9swhfq7mvYGHh1Bgkv
 6rukn3d0UGybRetz0Y7oR9Pd4PbOTdH/NFGcsfOz76BTQyrOB12ZO4SsnAd35USigjEQ
 AT8TL7No1qXB5r6dh63Uvk+YNThYpNyAvdq4DUm+t28U32gdtiRC6TpktCxVwqza48hX
 86jQ==
X-Gm-Message-State: AOJu0YxU16CJMnYq/VXAyyMh9qUY5A2+s/6QjpaPwrYGK2Ffpyj9+p6w
 +H6QpcqSkijJQclfF4XEFSYI5hDbuzvalBvWuUJNRsVd2AFTka46AqeOZ0z2Car+cUmFeuid9c8
 l
X-Gm-Gg: ASbGnctG+liYfu84qYVk4wPBof71g/KTI4WSKPvwXrviIoJspzDuJnD/n9HowZK4VjQ
 sR6z8LnhgCfVLSOHZHf5vUZ07Y3I24CV176M04he+xkg/husMwga358hHLFXJSyPZszFOFhs+/D
 gr7XXKfJDmG7iK9q6PEiX3JWClPKnw1Y1/I43wIGYrGOj46/66HjmklxwsGJhqa2lD7q9HPX7fB
 hRVlbFL72kkY6Iu/cZ5tKmgmM5J1ZvxMuF1VpP3VkqMwbW5sBRPYZecTy64BKlU7qsZ6n7+fgPs
 NFbtxUbaKmxLyeIa0/G0rsUGVVToZ6e1NC4rmb9ShcxK0d+UoknmKBjNi6qOEybgvtWuiRoxFVk
 DSusrCA1T
X-Google-Smtp-Source: AGHT+IGvdRxTo4EHuQR+XqagiY0Qk7Le+ztC60J1c/mfUW0VIW/fjCpP75P7qy/+c5THaJYsrwOc5w==
X-Received: by 2002:a05:6808:2385:b0:3fe:ee31:f7b4 with SMTP id
 5614622812f47-3ffdd9641ddmr2468983b6e.8.1743524487261; 
 Tue, 01 Apr 2025 09:21:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05181ecesm1976954b6e.15.2025.04.01.09.21.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 09:21:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] env: mmc: Fix test for ENV_IS_EMBEDDED
Date: Tue,  1 Apr 2025 10:21:25 -0600
Message-ID: <20250401162125.125055-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The symbol "ENV_IS_EMBEDDED" is an environment internal define and not a
real CONFIG symbol. The IS_ENABLED() macro is still valid to use here,
so update the check.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 env/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/mmc.c b/env/mmc.c
index 2ef15fb72e7b..8848371eb4f5 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -553,7 +553,7 @@ err:
 
 static int env_mmc_load(void)
 {
-	if (IS_ENABLED(CONFIG_ENV_IS_EMBEDDED))
+	if (IS_ENABLED(ENV_IS_EMBEDDED))
 		return 0;
 	else if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
 		return env_mmc_load_redundant();
-- 
2.43.0

