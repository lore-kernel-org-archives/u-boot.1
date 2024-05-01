Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8B1C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C7F188BE0;
	Wed,  1 May 2024 04:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XXPmUn9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D8988BD2; Wed,  1 May 2024 04:44:58 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 056AC88BBB
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6a0b4622ea0so21040606d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531495; x=1715136295; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ijk8qau922tqqLc7KJo8uDJknZ3ZGisEOCTyZ3VnKZM=;
 b=XXPmUn9qOhxN3fF4bqpIpiUT0kkB5ovm6m0EYm+2lrgqSkPADb7v9QjTiVnUt2XUIL
 1mKv/EH9kMcgCOJ+22PPxxWweIlHBeLyg+eonnMdltpwxE3XTzIS/onNxNBK2bi6OGDl
 M6HCxBFVoKzYZpA9YJY4bhTIUU+7dBOcrWFMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531495; x=1715136295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ijk8qau922tqqLc7KJo8uDJknZ3ZGisEOCTyZ3VnKZM=;
 b=ViAS+j2FGhsCf+OizaY0nz4I2cb7bh5J4w8d8MwSI3Iu/Jat6jiUKmQdJA6+JXgx3w
 KNfFt3fTsycZhnF0BEGnMtjf1JUzgRqYiPurXY1btyysrBKQJtfMIqDXqV8N3oJRcjXX
 /0vMAg5hKVBWAbZZ1XXy8tYLdJUrFHjr/v9nB8uM2HXTfGveMgCnylqX4Yo/MZu/RuIA
 6SdvgcORVo4f8XnrhaXfG7RBT5jirmIeYqUTU4cJPRyuNqFsW3MDrccs44AEaIQxN6vq
 bnPat/KHfgDf5wFni0OSBt7B/MoESWT5HxOtK22r+xUNNEqhOZHSHgrVHQjaonHzDQFI
 K/cQ==
X-Gm-Message-State: AOJu0YyGjQ2QTIQMkFSurLJjYWYtspwGAD8CmorRlOzyYdnM785EjRaN
 H5vER0gZpijkBEIGnGuJjc/HjGerFJgenZ8xLj2aeasFUVNzPu5UKvGZ5Nr5XV7IGarZ1U3FAe5
 LA1ixwg==
X-Google-Smtp-Source: AGHT+IGHIPks5HcES0vLgZ7t0BwmiXzwbqGjTbi8sa8QcIczU5etV/d2yCOfbV3hzH6Ak+POHmKXLw==
X-Received: by 2002:ad4:5fcd:0:b0:69b:2515:4197 with SMTP id
 jq13-20020ad45fcd000000b0069b25154197mr1591259qvb.13.1714531494600; 
 Tue, 30 Apr 2024 19:44:54 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 082/149] board: l+g: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:42:09 -0600
Message-Id: <20240501024316.1767971-82-trini@konsulko.com>
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
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 board/l+g/vinco/vinco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/l+g/vinco/vinco.c b/board/l+g/vinco/vinco.c
index b3c176dd59a0..066d315baa22 100644
--- a/board/l+g/vinco/vinco.c
+++ b/board/l+g/vinco/vinco.c
@@ -9,7 +9,7 @@
  *		      Gregory CLEMENT <gregory.clement@free-electrons.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-- 
2.34.1

