Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D37C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37A7A88AA5;
	Wed,  1 May 2024 04:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MNM8CQoz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D75F788A99; Wed,  1 May 2024 04:43:33 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6508588AAD
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-69b4043b7b3so36824366d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531410; x=1715136210; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yirq0eIlCn9cQXfJPCHs4UY61SDDODZf3k5HYajEffk=;
 b=MNM8CQozJJowDKhOAvB2EH77LUtSAlqLeUzEPUuF4a3piooDCOgEM3HBJDFl7aUu4m
 qOs+pPUsNPqgN0EoXKQIFeu07ZBgZDfetlkyW9j/pTX2PlBb5G34nqG/I1vmOUhxbSgv
 XNhR/ysl2Vh6Pb9CEdaYBBwnuHLX4PTC1LvdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531410; x=1715136210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yirq0eIlCn9cQXfJPCHs4UY61SDDODZf3k5HYajEffk=;
 b=niKfN1hPkvVaz7PyjUssGhMROzm1DMj6YGdRngxS6OVbnIK/gJwUPzC2Yh9urWlkLw
 hTitT2ELhu5vCLT9KhocEoWv/SxFRBXauRXG3GRWD4FrHEQOPwCPZbelLS4bqzzKQ9xz
 c2AwKQGLt7m2twa7isdE7U20GWXqaj0rp+bg2fq3SCRjOztMxNRqVkgsVLbYMX+Ep7YO
 0myGA/btDxPaueHRyYaw/Bq7/3MnQBldtTyvU8khmSlqt391aNv/WFTp80xqFMsJaaLo
 +27FMmOo87iH4l+CcACQvPhyY4YJm2L5IwX+CMrwfENAdXE8g8+M9eqMRnkoz43GKf/k
 y9XQ==
X-Gm-Message-State: AOJu0Yy0QQuuMI/QuRnzvpMUIDlsUFHzVM4k2WBLa5GOu5vHqWJlU3gI
 wjtARrsehk7nz6alIDdIKtCDaBiT0UCd6YMWJclJJzP4nMuBQdbR/P8chpY5lZwc7xpidRRWBCy
 nnfGGkQ==
X-Google-Smtp-Source: AGHT+IE/SBLr8qh/DFXmI6gojFT3FEnSQRd9veC8BDrEtsDVMtFliI4TCcOYK3YJnxEMElNVCHUKcA==
X-Received: by 2002:ad4:5c65:0:b0:69b:1dd3:3610 with SMTP id
 i5-20020ad45c65000000b0069b1dd33610mr1412477qvh.49.1714531409981; 
 Tue, 30 Apr 2024 19:43:29 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tony Dinh <mibodhi@gmail.com>,
	Evgeni Dobrev <evgeni@studio-punkt.com>
Subject: [PATCH 011/149] board: Seagate: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:40:58 -0600
Message-Id: <20240501024316.1767971-11-trini@konsulko.com>
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
Cc: Tony Dinh <mibodhi@gmail.com>
Cc: Evgeni Dobrev <evgeni@studio-punkt.com>
---
 board/Seagate/dockstar/dockstar.c     | 1 -
 board/Seagate/goflexhome/goflexhome.c | 1 -
 board/Seagate/nas220/nas220.c         | 1 -
 3 files changed, 3 deletions(-)

diff --git a/board/Seagate/dockstar/dockstar.c b/board/Seagate/dockstar/dockstar.c
index d72e3ef24ee6..e6ec00a9c6cc 100644
--- a/board/Seagate/dockstar/dockstar.c
+++ b/board/Seagate/dockstar/dockstar.c
@@ -9,7 +9,6 @@
  * Marvell Semiconductor <www.marvell.com>
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <init.h>
 #include <netdev.h>
diff --git a/board/Seagate/goflexhome/goflexhome.c b/board/Seagate/goflexhome/goflexhome.c
index caea89c10e07..b2d0ad8c3f22 100644
--- a/board/Seagate/goflexhome/goflexhome.c
+++ b/board/Seagate/goflexhome/goflexhome.c
@@ -12,7 +12,6 @@
  * Marvell Semiconductor <www.marvell.com>
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <init.h>
 #include <netdev.h>
diff --git a/board/Seagate/nas220/nas220.c b/board/Seagate/nas220/nas220.c
index cd2bbdad1cd6..fa7553250d1c 100644
--- a/board/Seagate/nas220/nas220.c
+++ b/board/Seagate/nas220/nas220.c
@@ -8,7 +8,6 @@
  * Marvell Semiconductor <www.marvell.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <net.h>
-- 
2.34.1

