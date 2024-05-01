Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A57C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCEE088C8A;
	Wed,  1 May 2024 04:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V+QVuxIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F1AA88C85; Wed,  1 May 2024 04:45:37 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2758588C6F
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6a0d1032362so10906736d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531534; x=1715136334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hL21iZM6VKhWXtn14zUsGlwfLsP+OVYxk6LP2Ir6ylc=;
 b=V+QVuxIPdLXjkB0x9iJRsSyUmN0TLMybMk4aznAACIUAJKCTb6HMOYeSD7Ih4nkt1g
 f6CVKy7+znmfW92MAjnMg02Muzeo0+zHMi/ZVjSGF1d4WtpymIZUqhOLJj0uutQ7lB1e
 dl36PsskAGjYRV1gh2gk80k5CssEcGOG2Hojc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531534; x=1715136334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hL21iZM6VKhWXtn14zUsGlwfLsP+OVYxk6LP2Ir6ylc=;
 b=DRiS8uqoRGcz+J5fyuHuH0WgZ/7HCOQs1FgR9tWcypTLaAJZ6U42FLovvjPNGoZMsC
 nbobPZgVAjBYC6KVIrjVAKCzG5NUCR/UPrr4iGg3baK8GadcELT45E9GXR6lXGTMWmCF
 bgwoeUDde27HclXEPR2v/X571GWGuIoguv+KQmb5YmGT9oP3ypwEZJQX7to1U5QfjCQw
 ym8rb2tjYD9QqH6VhPLW+4P4rPh/r96GAVT1NzbeT3wQPT0PGrXDIAonmqPHqRqVH7A/
 P5s8nLKsfupQK0xrcL9+pVHaIt/oZtcoal2l/VLp7MYsxiPFRZxI82hlrSG0B3Bi/dgq
 JG2w==
X-Gm-Message-State: AOJu0Ywm9f5y6wdMCSu9ENAN+kFcJn+LP4Ir2byNjkNU793r8AFOjvcY
 76m/Q8/xoVzBLgnuLxwM429hg9jPet09fmuuCw25e9k+pwGbGO62MwqejbXfEkJxxRuWm9QEVjp
 NRExzxfxI
X-Google-Smtp-Source: AGHT+IG7z0S13lrTIa8A09BRuwd5Uxa5VZXFf4mWrvkkDxp0oyymYNnR39Ck44UnnNX6jTD/P8Xsug==
X-Received: by 2002:a05:6214:2528:b0:6a0:cde0:e46d with SMTP id
 gg8-20020a056214252800b006a0cde0e46dmr1286709qvb.46.1714531531948; 
 Tue, 30 Apr 2024 19:45:31 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 117/149] board: silinux: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:44 -0600
Message-Id: <20240501024316.1767971-117-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 board/silinux/ek874/ek874.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/silinux/ek874/ek874.c b/board/silinux/ek874/ek874.c
index 6dc804a0c06e..a3fe6f96d091 100644
--- a/board/silinux/ek874/ek874.c
+++ b/board/silinux/ek874/ek874.c
@@ -6,8 +6,8 @@
  * Copyright (C) 2021 Renesas Electronics Corporation
  */
 
-#include <common.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 
 #define RST_BASE	0xE6160000
-- 
2.34.1

