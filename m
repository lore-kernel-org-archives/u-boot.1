Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39050C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:49:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A8B488B05;
	Wed,  1 May 2024 04:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZSvABYK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7580788AD1; Wed,  1 May 2024 04:43:59 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4D388AE2
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78f056f928eso484787185a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531436; x=1715136236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3oOfYgR7C5AwT0Gxp+cz+N/iQjDJVS62l3kjSvhmlk=;
 b=ZSvABYK86j54DHOvMQf9ICA081Hs5RrQ11c72MLWO/47a4oiLUUzuZBu4Sy+gUYl02
 ILYQFEK0Ei2I4Y968o8UJYdML/b+Ras9pwaSDvgGPTMWwyQrPPRebePqexmRXq3Cw616
 kGw2jU1wDK50ZUC5O3wVF9sUdyd+TgdKK4UjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531436; x=1715136236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3oOfYgR7C5AwT0Gxp+cz+N/iQjDJVS62l3kjSvhmlk=;
 b=hjELB8J8M5rnUdFNofBolpVZPwennx55Wr7yLoCkKFsjR7Yxq4l5OEBnJ8Iz0E7A32
 9PJ4TY/uypnaZip5qGHNugpV9a2WloEPOKfPgwmIEuCU328eT8FxOyKwHXXeSlpCqhi8
 zZ4VVkcWOUY2kjtDWBKcYuywQ7YQG7C0PHOipFR6oI5uZN86+4wrKyaJ43SduaKCzy3U
 BFLewXImsp/xM5YFog7pJsmCGGRz3NzFGCQHvxXv9pCam6Z6bwfTIQOlkAFT2XqNEAu7
 Z6clP8VzTZbDFJVWETT8XVZkD1wPKYk5LDySJ6T16sDmMK5ZRUeCzIQ7JmUnHFXiQf/E
 DEAg==
X-Gm-Message-State: AOJu0YxEMfKK6Ptdzx2sEPEmDXO1uAwBIihwsUtAz3vshT0QZgWOsKGR
 pVDMQ8xkINSkEk9e5+y+chYQg5fAN99IFBenLMw10yPjgg0/b+YCJIW9vKte83L4sUHU2mfxtMe
 9BRAELw==
X-Google-Smtp-Source: AGHT+IHQ1bzeRhnCustFVQZ4PcGkEn0L7/TbwkMCNvtrmyxc1rPAKpqkBmSOxVHEk0kbjHSBDntMqg==
X-Received: by 2002:a05:6214:242e:b0:69b:17b2:df34 with SMTP id
 gy14-20020a056214242e00b0069b17b2df34mr1563363qvb.63.1714531435802; 
 Tue, 30 Apr 2024 19:43:55 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michael Walle <michael@walle.cc>
Subject: [PATCH 032/149] board: buffalo: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:19 -0600
Message-Id: <20240501024316.1767971-32-trini@konsulko.com>
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
Cc: Michael Walle <michael@walle.cc>
---
 board/buffalo/lsxl/lsxl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/buffalo/lsxl/lsxl.c b/board/buffalo/lsxl/lsxl.c
index 6a866b5470d6..1e501a09813d 100644
--- a/board/buffalo/lsxl/lsxl.c
+++ b/board/buffalo/lsxl/lsxl.c
@@ -7,7 +7,6 @@
  *   Marvell Semiconductor <www.marvell.com>
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <button.h>
 #include <command.h>
-- 
2.34.1

