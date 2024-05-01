Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7495DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73CF88A8B;
	Wed,  1 May 2024 04:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S9/+mqrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA54988ABE; Wed,  1 May 2024 04:43:38 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B7488A8B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4df0e22754cso79661e0c.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531415; x=1715136215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lDmR2Gkx7XYhA9rV9PFsA2bDjvzlxXEMLEXlFehNxY4=;
 b=S9/+mqrwoxTQNjA9eHJ7xv3gAV3XDLfciI0fOYxhdC8rXoLjjN4tBBcvaE5Afn6aLl
 bNOcCdMAqbeLTWKmx3ROj/PiglKSMbeqSZfJPMrpgOS/JqFMB7k4J7wOB8b19j4OJFfz
 nM2W0hCfONzrXEWWHNFo5GEqWuBCajT6TWjBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531415; x=1715136215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDmR2Gkx7XYhA9rV9PFsA2bDjvzlxXEMLEXlFehNxY4=;
 b=GmQr4udI7jKHvQCQDJ1I7NawmqKeHebZtR/YveinQBTplftsjnFtwJI2HRK10LwrqX
 LshzO1JNzHWWOV4Tl6Z9LJB4ZReXDnJSosElPTvGJJZTnm3r2SsXn6nB0kRqdzPQ34/P
 s53PyP/8KEByj5gp9UhUwQRRMQPYCN9IOToHkccDQ7RINiGZdsBuIOzKKPso9ll1z/z6
 xr87ub7tXn0TTy5mDxNNVN5sKT6l9ajSphQ1K+2Di0HBXVAfemV/q1cU+Ln6p+hMXumL
 miAsgwFhxKwzSO+g8siZq8wuB9kENWsaem+9Fhb8U5AZYlVEp80ctU/Q9SDrX0Xh1VvF
 NWBA==
X-Gm-Message-State: AOJu0Yzny68rcVu5v1AALKjorstXJdFOFRGx+hytOOtEM+FZoXR3BEGJ
 m+oA+Ri9b4+BLx+KG0G3UUER1WAI79xYGMiPWK6zfeVRqjvpWB4QD34nR6ugjnhy0XnY2TPK/mA
 LM6KJSw==
X-Google-Smtp-Source: AGHT+IEBlzP3QnCpVoF+J7+ZKeII3jbjYjWYkWm5OOJ9jQgF2oOfYYmgfGd6sY7CThFQkPfonh8opA==
X-Received: by 2002:a05:6122:1d9e:b0:4c9:b8a8:78d4 with SMTP id
 gg30-20020a0561221d9e00b004c9b8a878d4mr1613824vkb.3.1714531414540; 
 Tue, 30 Apr 2024 19:43:34 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH 015/149] board: amarula: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:02 -0600
Message-Id: <20240501024316.1767971-15-trini@konsulko.com>
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
---
 board/amarula/vyasa-rk3288/vyasa-rk3288.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/amarula/vyasa-rk3288/vyasa-rk3288.c b/board/amarula/vyasa-rk3288/vyasa-rk3288.c
index 92e0698c534b..b220256c67fa 100644
--- a/board/amarula/vyasa-rk3288/vyasa-rk3288.c
+++ b/board/amarula/vyasa-rk3288/vyasa-rk3288.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Amarula Solutions
  */
 
-#include <common.h>
 #include <serial.h>
 
 #ifndef CONFIG_TPL_BUILD
-- 
2.34.1

