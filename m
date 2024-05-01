Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9972BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:03:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AD5788C33;
	Wed,  1 May 2024 04:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n1oCPIZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78DA88C11; Wed,  1 May 2024 04:45:16 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 796E988C1C
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-790fb9d1b55so212135485a.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531513; x=1715136313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HO/wyC38SD8mqtQD9AprkIGh5aGSEES+794hdGVzBrg=;
 b=n1oCPIZIhBhxy7R1Ijp4V9LdgAkd0oHO5fWCV6bGFmRJNcjSM3KH6SMQzeJSrcqrEA
 +3jm5EIXFcK+IJjq2cdeIwk29iDHzwVf6g0LMVQ1wTOO8ywr45qBtMtj7CirVs1NBTsL
 UTzOZntHsp3UR0reYeG7i9iQWDp0mIhJW/m7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531513; x=1715136313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HO/wyC38SD8mqtQD9AprkIGh5aGSEES+794hdGVzBrg=;
 b=dfH7XYTbVXohs3Dg/tKRzKlHDRuQIuVKjWVscxlNv/fr3XvYWcJyx7YeKTONZt1QE/
 RsSVOf1nyOXa720Cq3Zgcl2J+UD5l3Zq2qRTFvqdxtkUoZ/oYEnZ8KiZ0313cGljCyhy
 +qavgiNqvlNfTIOSLLXc522rJa0SBybr6zF95BmKdUv+oMNFF/SHVvQ0FRO97JVYHRUn
 JDHeuxs6KDHE87CUsK10RBprQbEez4odqxzK+ard7vOCGeCx2Io/y8opDeNNkd80+FiB
 u0fLyVHaESjuaCm7/trK9rf0ZTZ7fxAW3L4ByKWOBGnmMhfF0PKM1Qqv3jFLnUhl0eTx
 eMfg==
X-Gm-Message-State: AOJu0Yyc+npI2T0EQNbX+9K8zLPNRmU44dMcoM+cUs9HWIXw2ctcwyJ7
 9olMCH2PyGoxFNO9ENUzytAX7dFtKRUks0Nfxwz9yRKQm1BcP6kXvmBROiiCLspZIpbDIgPB0KC
 USX6QjjWv
X-Google-Smtp-Source: AGHT+IGDT8OF8dO8A1UAVXyt5ctdwZeG2EdVRJCrAP5Abm2vEjUCbq4V698AZqWU26mhEE2gRuGxJw==
X-Received: by 2002:ad4:5dec:0:b0:6a0:d2dc:bbe1 with SMTP id
 jn12-20020ad45dec000000b006a0d2dcbbe1mr928139qvb.52.1714531513183; 
 Tue, 30 Apr 2024 19:45:13 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Subject: [PATCH 100/149] board: olimex: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:27 -0600
Message-Id: <20240501024316.1767971-100-trini@konsulko.com>
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
Cc: Marek Vasut <marex@denx.de>
---
 board/olimex/mx23_olinuxino/mx23_olinuxino.c | 1 -
 board/olimex/mx23_olinuxino/spl_boot.c       | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/olimex/mx23_olinuxino/mx23_olinuxino.c b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
index bdd5fcd76ae8..b2bb6678c23f 100644
--- a/board/olimex/mx23_olinuxino/mx23_olinuxino.c
+++ b/board/olimex/mx23_olinuxino/mx23_olinuxino.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2013 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
diff --git a/board/olimex/mx23_olinuxino/spl_boot.c b/board/olimex/mx23_olinuxino/spl_boot.c
index 248176c23cdc..eb85ce9643d8 100644
--- a/board/olimex/mx23_olinuxino/spl_boot.c
+++ b/board/olimex/mx23_olinuxino/spl_boot.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2013 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <config.h>
 #include <asm/io.h>
 #include <asm/arch/iomux-mx23.h>
-- 
2.34.1

