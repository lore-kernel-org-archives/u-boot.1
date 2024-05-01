Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498DDC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C772288B6E;
	Wed,  1 May 2024 04:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fU6Uz8NZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8E588B6C; Wed,  1 May 2024 04:44:27 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB1D88B60
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7f012a66df7so1380861241.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531463; x=1715136263; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUQDpOwYagjvliHAMjgN8/MvIAT8RkbIePvyXeS7ENM=;
 b=fU6Uz8NZkvNJNEzC1jaKxWv97Nfi2yVQ+NAgSRo98TDMyuwlN8P2cOUUeSkPHFTj5D
 Sch1qRw38xG7vMknI/aViWBJAobvmwAm3Hxebu00hbSADqpt7zj1IukbqPa2uaaWrQQH
 q2xfFAT9DQGyaBT8f4vqtvhtE+kcxgomwJdXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531463; x=1715136263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUQDpOwYagjvliHAMjgN8/MvIAT8RkbIePvyXeS7ENM=;
 b=JaKZbJrYDZaNgjoHWU8e4UZXuq4SK5MzQ6qmeesCXkzgZmy8QXV8sF/eF+uDn4O2gj
 VnM6yTOyvyUtoT7+vPsQ8qKC/irDWVYDrPMiA0sOzCGI0eWsASMiFg0tN23iTz7Mj8wQ
 vSBftWFf3B9dVPcSt1w653Kxcn72KjA6KuE7VeO4F/VQM5NvaUnRt5ySjohZRVx+GP8e
 7CXxE5Jo+Udr8HcEFgQKRTtOpj8ZsMrKAUhW+bz3XnfBXBnQ0UgAZfbGFqqSdXKGQQ7O
 FwJE/DJXcZK0t/U++ghiRR+4MHIdbtY66rcNMKgX2VvBinhMuTFYQM0XrXKJXEC5RYHJ
 r+0w==
X-Gm-Message-State: AOJu0Yz9WZv3KawgWjbD7qk9JVY7EOdv88y4xdIJVPun0s+WzFS4kxOl
 9Oo83zEp5gJdP0GcwZZCKDC4XacLYe3FXBzKO6E5Wy1SnGHhUVHXcHLxp3plePrjVn7fOcfyQab
 0UaCxIA==
X-Google-Smtp-Source: AGHT+IGfUO0S8L6G7DMaRLCg0dCL0W0gbMOOu26RfKS7AW6x9TT2Up2Vzsjwss4z3rsQyvKjqOq8oQ==
X-Received: by 2002:a05:6102:12c6:b0:47b:b058:849b with SMTP id
 jd6-20020a05610212c600b0047bb058849bmr1372070vsb.10.1714531463116; 
 Tue, 30 Apr 2024 19:44:23 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH 056/149] board: embest: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:43 -0600
Message-Id: <20240501024316.1767971-56-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: "Eric Bénard" <eric@eukrea.com>
---
 board/embest/mx6boards/mx6boards.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/embest/mx6boards/mx6boards.c b/board/embest/mx6boards/mx6boards.c
index a3c23bdfb64e..896350140d61 100644
--- a/board/embest/mx6boards/mx6boards.c
+++ b/board/embest/mx6boards/mx6boards.c
@@ -12,7 +12,6 @@
  * Copyright (C) 2013 Jon Nettleton <jon.nettleton@gmail.com>.
  */
 
-#include <common.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/clock.h>
-- 
2.34.1

