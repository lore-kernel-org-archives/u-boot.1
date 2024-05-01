Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D5CC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 178E488C05;
	Wed,  1 May 2024 04:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eEjkUngK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F2F88BF8; Wed,  1 May 2024 04:45:07 +0200 (CEST)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FBED88BFE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7f16ff3aa86so527099241.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531503; x=1715136303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Gao4Q8tjjzQf/n/3sG4uI+iAjZW/HpqWNawfINSHpQ=;
 b=eEjkUngKzFoVoH5FBLgWufJx4Xp3dn3s5+Ay40i4UxuIytLJwjKy9/bCg2rSK0/R1T
 49SGpaQL4E6obxAfEpxYOVuW46H5ajX8ZJu/URkicP7JMLL1Xeo6eymcjPvDOJvx2W+n
 HSWgTbcThCIhh7qicVaYzmWVBe3NRdmfA/EwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531503; x=1715136303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Gao4Q8tjjzQf/n/3sG4uI+iAjZW/HpqWNawfINSHpQ=;
 b=OjhmN0KdGhg9DwSnxU9eDxT9aqgKWre4ZNwnSuQJ+C747JMwQq9Z1s67+RUeZWfJJb
 eQqcoaovotF5j8+D1U/2SLyl3uXA7qpNDqiCPKSw14IObdCRZRAo+rKLvspjvp/uM525
 M0ragdoOjv4xi7PWkADwqb4u2x6/stzT5xHsLBptnYRF8U9fjTySXPdkRT/iWwUYIOFf
 DZ9SGal6oufFfmg0SbE2/+NJYZA8VjkIYv90H4w05djdVp7T77d8T1hmVo1GZ1+3n8CD
 xORGeht13sZFhtOKrIAZiYPIUPAC2LjrA5+ujwzQkD/bFfCOniyhcV+L3fz3KjAIX9eC
 8iLg==
X-Gm-Message-State: AOJu0YyPGczCgBmrYnEPKMwJMKrQEDi5JyVm+i8yvuDgPIrVejHoYF5f
 5p5quXxiuOob93CVNuOdiJylQCgoDknl3QeSktAkdPvaR4qCBXm6rJiVs2uKVUqn8M3Mf0xQW9o
 DondWqzZz
X-Google-Smtp-Source: AGHT+IGN/uJ3RSGqjkvMcn6mR9hFtsQQA6pGUXZfiAg3Pyeb6aq1YzdzvMlkQMlwk3MeC0kJVHA/GA==
X-Received: by 2002:a67:f554:0:b0:47c:e2b:69f7 with SMTP id
 z20-20020a67f554000000b0047c0e2b69f7mr1558423vsn.4.1714531502796; 
 Tue, 30 Apr 2024 19:45:02 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Padmarao Begari <padmarao.begari@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>,
 Purna Chandra Mandal <purna.mandal@microchip.com>
Subject: [PATCH 090/149] board: microchip: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:17 -0600
Message-Id: <20240501024316.1767971-90-trini@konsulko.com>
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
Cc: Padmarao Begari <padmarao.begari@microchip.com>
Cc: Cyril Jean <cyril.jean@microchip.com>
Cc: Purna Chandra Mandal <purna.mandal@microchip.com>
---
 board/microchip/mpfs_icicle/mpfs_icicle.c | 1 -
 board/microchip/pic32mzda/pic32mzda.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/mpfs_icicle/mpfs_icicle.c
index 0f5f82924e77..7beac33cfbd3 100644
--- a/board/microchip/mpfs_icicle/mpfs_icicle.c
+++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
@@ -4,7 +4,6 @@
  * Padmarao Begari <padmarao.begari@microchip.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/microchip/pic32mzda/pic32mzda.c b/board/microchip/pic32mzda/pic32mzda.c
index 3c2203d22025..848a1aee4000 100644
--- a/board/microchip/pic32mzda/pic32mzda.c
+++ b/board/microchip/pic32mzda/pic32mzda.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <clk.h>
 #include <init.h>
-- 
2.34.1

