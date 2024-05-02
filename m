Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F38C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F41AB88C86;
	Thu,  2 May 2024 03:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K3Hu6A64";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9080088BEF; Thu,  2 May 2024 03:32:58 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D99188C8A
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-43abc28f73fso12346551cf.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613575; x=1715218375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YptLP5ckMq1ZFf/pDfxoV8FIQV2Is/QnSUtmaunVHyU=;
 b=K3Hu6A64LIrmKRjfAjt9k5As1vn8ACtqT3CyySSRjtUAg8K9Xpbzke3HB/nKifolg5
 83H1Cwpfi6zLTK3iG2lumanLr2X5sYHN316JEqV7g/bhyiboy4ElxFeIPxwUPdwZrmlt
 yNZcX6jntWfHtVYiuU4ySVob1Qv2HRAPgjryc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613575; x=1715218375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YptLP5ckMq1ZFf/pDfxoV8FIQV2Is/QnSUtmaunVHyU=;
 b=D+kqoD7rPw14X/QOZOXQIlBF2XPBRdrV4A0QJQkdyg4iXR1KlTcuiLm/G9CqbRaSw1
 ajTJjutyN6e/b3DLOXrh8cfTrNVoezWPqTTBeklQso+JaLTifrLzA9VRVuThxXT6r/4c
 o2DlAlCkWYirdRnVlSq0Vjsf+GE8EcHzEiaGKiHt/oCl/crHeJy9CIJ31N6NQFXBiGXy
 bv8R6N3+KhVWZCKJgJO9I9EWSzyHOz777qO/hgnW50LdCaN9+E7IZ1Y7J1tpPcihmO5a
 yYUey8TKLw6vcZ1+rtTK2Y6dAbnvd/yfsHZCATmI8Y1IyXSbY2yBE9CzalP2OETaqJkd
 Ea7w==
X-Gm-Message-State: AOJu0YxGAPRAyjMOiFprsrwovPSqarFTZ9GWk4oK5hCT62Qa3s6CpWhI
 f/YVIEHa05ctMU7K3gMeV3gCNDg8ad8LqGnK98VMdZSj7Ape46qwWpHH6HU4jz57v3vSm94iNYb
 Fr3eFT1NE
X-Google-Smtp-Source: AGHT+IFc/usDPFRogvGU65ku/hZRC7K0e9QSIeyGoJG/zF9TWUrMgMTdRTfksU1l+3kqK973I25TCQ==
X-Received: by 2002:a05:622a:1650:b0:43a:c4e8:cb8c with SMTP id
 y16-20020a05622a165000b0043ac4e8cb8cmr627121qtj.64.1714613574922; 
 Wed, 01 May 2024 18:32:54 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Roger Quadros <rogerq@kernel.org>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 44/81] mux: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:01 -0600
Message-Id: <20240502013138.2383421-44-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
---
 drivers/mux/mmio.c       | 1 -
 drivers/mux/mux-uclass.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 00e0282dcc0e..e1125458a629 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2017 Pengutronix, Philipp Zabel <kernel@pengutronix.de>
  * Copyright (C) 2019 Texas Instrument, Jean-jacques Hiblot <jjhiblot@ti.com>
  */
-#include <common.h>
 #include <dm.h>
 #include <mux-internal.h>
 #include <regmap.h>
diff --git a/drivers/mux/mux-uclass.c b/drivers/mux/mux-uclass.c
index 8833888ded37..8a3e7a84f41b 100644
--- a/drivers/mux/mux-uclass.c
+++ b/drivers/mux/mux-uclass.c
@@ -13,7 +13,6 @@
 
 #define LOG_CATEGORY UCLASS_MUX
 
-#include <common.h>
 #include <dm.h>
 #include <mux-internal.h>
 #include <dm/device-internal.h>
-- 
2.34.1

