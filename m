Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8B4C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF4588B06;
	Wed,  1 May 2024 04:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CP+qWIGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E60F88AFD; Wed,  1 May 2024 04:43:56 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0273B88AF4
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4375ddb9eaeso39506641cf.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531432; x=1715136232; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4i2nL95kfEC579VKP3H/RrtU6OI0Gzdimj1cxd3sYY=;
 b=CP+qWIGpBFiiT1AN9aHN2YYedDmWabXb6q3eq4VZA3GzN1Iq7nOcL/r7UYab+qTI4U
 Tf8oOHhxx0grSKNyW9gt8pi6YbKlTgANGSieai80szck8KOjfXDj7CifRPSFGzOa9eIi
 pFItQL80/ayk2x/AEaatQvp1axeyV2UFoMAIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531432; x=1715136232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4i2nL95kfEC579VKP3H/RrtU6OI0Gzdimj1cxd3sYY=;
 b=F61ywvMUNUW/vKrjdQuJAdOwxV2raIUwHnUzOE9nO6GEjslnzDS7KJbB5AliKdCKSe
 Cd2H0La6Q9FJcADmqEeRmnC9j4oVHP73MCkTL8gIKYx662r35ven/olyjo+ZhXtgv1J8
 U2UNFTk8C3PjJDPVS4+eG2rTr0PlskgZWokuzhN9nswNeqXDWJmxNBq96loc8ha2iBc9
 enrdcSPhEptDWY6S8X+wtHZGkyZHwC4vT4XukQMyKzpC5NmrLQpFyNYZnF506DenZFKL
 9M3MYo4+NXudfU25t36DmyaV4F4z/jWnVXOv2pMXvT0TWS8KH7lNfTIsx8cvjolpKUqs
 pojA==
X-Gm-Message-State: AOJu0Yw4cIKd2VN62Lp46+u/gcCbS3ggIYXFADQ/EF7wUPh9gnWoSTWG
 bc1kyqeu2vYvfmVTrVqfZz2oC7V1zokeAr3sX6zEXNYc9kquRZp/4DFNvTWwRNoJ+0Hh3mBPyEE
 G384Upg==
X-Google-Smtp-Source: AGHT+IF1nQanAhkCHin6GEFTTxbLo39xx3fOh/7B753csjL4J+y0QHoqcTXDCmDXZCwPYerPg5+5MQ==
X-Received: by 2002:a05:6214:aca:b0:6a0:d72b:682e with SMTP id
 g10-20020a0562140aca00b006a0d72b682emr1091529qvi.23.1714531432688; 
 Tue, 30 Apr 2024 19:43:52 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anand Gore <anand.gore@broadcom.com>,
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>,
 Joel Peshkin <joel.peshkin@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>
Subject: [PATCH 029/149] board: broadcom: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:16 -0600
Message-Id: <20240501024316.1767971-29-trini@konsulko.com>
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
Cc: Anand Gore <anand.gore@broadcom.com>
Cc: William Zhang <william.zhang@broadcom.com>
Cc: Kursad Oney <kursad.oney@broadcom.com>
Cc: Joel Peshkin <joel.peshkin@broadcom.com>
Cc: Philippe Reynes <philippe.reynes@softathome.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: Thomas Fitzsimmons <fitzsim@fitzsim.org>
---
 board/broadcom/bcmbca/board.c  | 1 -
 board/broadcom/bcmns/ns.c      | 1 -
 board/broadcom/bcmns3/ns3.c    | 2 +-
 board/broadcom/bcmstb/bcmstb.c | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/board/broadcom/bcmbca/board.c b/board/broadcom/bcmbca/board.c
index bcecb4d78392..a6ced92565f9 100644
--- a/board/broadcom/bcmbca/board.c
+++ b/board/broadcom/bcmbca/board.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2022 Broadcom Ltd.
  */
 
-#include <common.h>
 #include <fdtdec.h>
 
 int board_init(void)
diff --git a/board/broadcom/bcmns/ns.c b/board/broadcom/bcmns/ns.c
index 1249e45af036..45cc62936cec 100644
--- a/board/broadcom/bcmns/ns.c
+++ b/board/broadcom/bcmns/ns.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2023 Linus Walleij <linus.walleij@linaro.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/broadcom/bcmns3/ns3.c b/board/broadcom/bcmns3/ns3.c
index 7ae6742c4be8..bb2f1e4f62ad 100644
--- a/board/broadcom/bcmns3/ns3.c
+++ b/board/broadcom/bcmns3/ns3.c
@@ -4,8 +4,8 @@
  *
  */
 
-#include <common.h>
 #include <fdt_support.h>
+#include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/gic-v3.h>
 #include <asm/global_data.h>
diff --git a/board/broadcom/bcmstb/bcmstb.c b/board/broadcom/bcmstb/bcmstb.c
index aead6f099e81..bc05aecc446d 100644
--- a/board/broadcom/bcmstb/bcmstb.c
+++ b/board/broadcom/bcmstb/bcmstb.c
@@ -12,7 +12,6 @@
 #include <time.h>
 #include <asm/global_data.h>
 #include <linux/types.h>
-#include <common.h>
 #include <env.h>
 #include <asm/io.h>
 #include <asm/bootm.h>
-- 
2.34.1

