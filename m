Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB58C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A37B88C67;
	Wed,  1 May 2024 04:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fkYMjSc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD4688C5F; Wed,  1 May 2024 04:45:25 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADF888C45
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6a0d1032362so10906326d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531522; x=1715136322; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LVVznbRRuS9T9fXXFJqdZ9MSUcGMQHcUMb7yTaFcFIw=;
 b=fkYMjSc/WWsEnaNu4+tmewdTNXLaN0KCVZMcS18Y5Ivz3VnTidERk34EWWvZr1tDqt
 j05xvqdIuAQDsFRjRFq33E9xR3y2opEx8LvN68EwLnjHPNclsDyT2zQ3VtebLMXGGRU8
 XmOD8yjNJfINiNlV5BcriJaDuETu0XF3qhyew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531522; x=1715136322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LVVznbRRuS9T9fXXFJqdZ9MSUcGMQHcUMb7yTaFcFIw=;
 b=L+pX3M38RURHRKGLGJHgfc9H4uDDtsS5/pvIBqK+svwZEmZtQ5EERnOg2JjLlk/Fy8
 V1PYEZCiURHp5YCm3lEVFUzqNgtj/R/WBmzEk9XyN+lgy5wTAaWZts/1vsjTd2MUtyzn
 huxN1Aw+G/TyCQjMNwuu7h9boDRCinMDf5Gl3g5YzWttOfk7aUauA8XriS/BB1J+oGWN
 RsIWuIYO/9Y++ULZeALkd6bTjAUhR9ZxmiYf53Fr/gzPeNoxG3TRFvGyPemEm9FB86pq
 qFXWIlkTZU3fdGFHjyACd5D7dCJXQr1ot5DW6MmztQzLrccJ7/td0M3wyCdY36ARF0Ms
 cPwA==
X-Gm-Message-State: AOJu0YwpoYv8yoF+3ctoj25s87/s+6WAQziBvLufhAqx4w9m8pLe5F8d
 dKa/RDY0eEZY3EMd4nhAC18ENE7lFD3HGpEf3mF+ajqpx4r66OoF6JYRRCKtB3j5B6UWHVAaUq3
 bICtKP+gi
X-Google-Smtp-Source: AGHT+IGLtvEUSx3YZYtk4/mPq9T+U1drlWeu9rL7ceL/Afd2vLXSv7M6KXiMB3d7yn7kjea/pJp+nQ==
X-Received: by 2002:a05:6214:226f:b0:6a0:9443:b64 with SMTP id
 gs15-20020a056214226f00b006a094430b64mr1193631qvb.9.1714531522211; 
 Tue, 30 Apr 2024 19:45:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ramon Fried <rfried.dev@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Subject: [PATCH 108/149] board: qualcomm: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:35 -0600
Message-Id: <20240501024316.1767971-108-trini@konsulko.com>
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
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
---
 board/qualcomm/dragonboard410c/dragonboard410c.c | 1 -
 board/qualcomm/dragonboard820c/dragonboard820c.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index fbbfc0e65e24..bd2e213b3bca 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -6,7 +6,6 @@
  */
 
 #include <button.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/pinctrl.h>
diff --git a/board/qualcomm/dragonboard820c/dragonboard820c.c b/board/qualcomm/dragonboard820c/dragonboard820c.c
index ac7de711c588..d3333a59db01 100644
--- a/board/qualcomm/dragonboard820c/dragonboard820c.c
+++ b/board/qualcomm/dragonboard820c/dragonboard820c.c
@@ -13,7 +13,6 @@
 #include <asm/global_data.h>
 #include <linux/arm-smccc.h>
 #include <linux/psci.h>
-#include <common.h>
 #include <dm.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-- 
2.34.1

