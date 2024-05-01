Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D5FC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9916F88C10;
	Wed,  1 May 2024 04:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ejkv14Ni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB4388C87; Wed,  1 May 2024 04:45:44 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBBD388C0B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6a073f10e25so33846746d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531540; x=1715136340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbrPGjVYJbtFpNS+35/GVUIHtVXmkhaFTIZsM029pv4=;
 b=ejkv14Ni1XeZyZr7HEZdIYtY4bA2FfJmvfYX1lHLRi5aXp/AATxhHFRQZFcFG7uz79
 hJKEtBOG/wSav8+48G1eRVihETHfgEQysmySWbMTAaByBymB/6mA0OhmoREzghCtVodI
 fOE4mo0f3+2WzY5Yd+wqZi7TSG5kv/AaAPcJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531540; x=1715136340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JbrPGjVYJbtFpNS+35/GVUIHtVXmkhaFTIZsM029pv4=;
 b=gJSM572ilETPbrzkA/IqVpwrodXJRHIrvXSbrOLJ2C6UmnODwWeKZUHCToH1Jg5Tu/
 KmZFBJ4lj1ZTz4gFjAxgvR4LGI7iDFH+b1L0dEnhcb5V2s34YbAmPc0gxi+onB2GrduA
 stE4CjjIFCEx9x0tdFm8cfVk8T4TKQCaN382/rzt/m+12pZUmFwEadqoDb1q0mryQ4d1
 2tnElRTobiUfLJAfvi3DG+DG+yR9MMZAMuIKdOg/bTc7+8Sl4YvkoZMFO+ENY6rHBZws
 A8J0r9CzLiJ8IKRGRDS097JKKOI9CwzK/ftcHEcN7VgeHkzZKtfvcUZ+pFSiWEgj0btu
 yoWA==
X-Gm-Message-State: AOJu0YxytMsLiHNex/Xp54LlcQN6fZfILqph1fVEgZDh4vE5VeM3L1Ao
 t2mZSvkbgL3qZaGYarrWnY+hkbg3UfiLZyc8IPxWYSMg02ncEp4z0Aef8WRiCgGRyObvIYuUkzk
 c8WLbAu19
X-Google-Smtp-Source: AGHT+IHTbi3Kmn9dEElwiZmqkduV7nvsDEi5WLD+1Vqgw5vk23J6LTVNajKJgdJYiLC+MsKlk/TN9g==
X-Received: by 2002:a05:6214:2484:b0:69f:ebc3:7d0d with SMTP id
 gi4-20020a056214248400b0069febc37d0dmr1194746qvb.60.1714531540404; 
 Tue, 30 Apr 2024 19:45:40 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Arkadiusz Karas <arkadiusz.karas@somlabs.com>
Subject: [PATCH 124/149] board: somlabs: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:51 -0600
Message-Id: <20240501024316.1767971-124-trini@konsulko.com>
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
Cc: Arkadiusz Karas <arkadiusz.karas@somlabs.com>
---
 board/somlabs/visionsom-6ull/visionsom-6ull.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/somlabs/visionsom-6ull/visionsom-6ull.c b/board/somlabs/visionsom-6ull/visionsom-6ull.c
index 38d14f6bc268..0ecb5c3b4930 100644
--- a/board/somlabs/visionsom-6ull/visionsom-6ull.c
+++ b/board/somlabs/visionsom-6ull/visionsom-6ull.c
@@ -17,7 +17,6 @@
 #include <asm/mach-imx/iomux-v3.h>
 #include <asm/mach-imx/mxc_i2c.h>
 #include <asm/io.h>
-#include <common.h>
 #include <env.h>
 #include <fsl_esdhc_imx.h>
 #include <i2c.h>
-- 
2.34.1

