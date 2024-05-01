Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81777C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:08:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E00188CB1;
	Wed,  1 May 2024 04:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QrOeu6GS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D16A88CB2; Wed,  1 May 2024 04:45:49 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08BBD88CA3
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7f169d3ef53so589059241.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531546; x=1715136346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oq9S6ZBNoxRuEPqxrUlimJGVrMaKpbfBBwDUfjV93m4=;
 b=QrOeu6GSOXF6eLWNt710OLvmqw4gSoIH3XijAdnICm6yxkHTVdktoM+UkRXVTIchKq
 tTPXT1sQDb6SPm/AgXnIvsfBjjYqDmObfjY6uz0QxoVay43GRJ6iwaXd/POyWN7aLl30
 T3AtBGHPDP+RD/fXuW3y4y7jMbFBRbY6ppWQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531546; x=1715136346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oq9S6ZBNoxRuEPqxrUlimJGVrMaKpbfBBwDUfjV93m4=;
 b=OgYal+BmLJf/qT5XKG4rBuBCqruywsuW1BmEdWRMGX9XWCwr53Zu8Yu1sOTcw9eGfd
 SIIX8VGk03v5F9efogtHz1hb8pe3BqQ6RTe1RNs0eYbqqazPDf9wPp6f7pcp/lbJqxA4
 ud6jQ/g2Qfy5ujOsPqHS7bgL/B6CUaKmnukxnnNu75c/Xvt7NtVVCcnfpM8ytAtOTu+S
 nGCCFDmRMxVBLw1hg2psjaOBiPSVVttmTufVuK5X6b3YT2YQHnOZTsluTcn9Yw7f1YF5
 gfvWzqqHgei15k2JWi5grIDVTWeZyq91X8cXWlK4qamq0ycTDuZnvNxFujHjEh/Q4SGA
 yNkw==
X-Gm-Message-State: AOJu0YwGJXkJ+tzoa6H0nk//iwzSRlo+cztM1AZ5aXohqIRBTGqTn+2x
 oZH7qLOw8pqaDg6AhtRv4ufS8DnsczIkoqYKP2VNY6VzqslkWdoKoFWQIrnbB96wizOy0TRFK+l
 Joaj18LCx
X-Google-Smtp-Source: AGHT+IEDMAQIN1Svm1VRpbp0pHZNDj3BvkYcpxNtMEwLuUuzATfhUbp2bhluQMvvEcj1rLjFCFNFQg==
X-Received: by 2002:a67:f40f:0:b0:47c:2926:6212 with SMTP id
 p15-20020a67f40f000000b0047c29266212mr1722040vsn.35.1714531545749; 
 Tue, 30 Apr 2024 19:45:45 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Angelo Dureghello <angelo@sysam.it>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 129/149] board: sysam: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:56 -0600
Message-Id: <20240501024316.1767971-129-trini@konsulko.com>
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
Cc: Angelo Dureghello <angelo@sysam.it>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 board/sysam/amcore/amcore.c   | 2 +-
 board/sysam/stmark2/stmark2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/sysam/amcore/amcore.c b/board/sysam/amcore/amcore.c
index 086421d9265d..d5aa1f0776fd 100644
--- a/board/sysam/amcore/amcore.c
+++ b/board/sysam/amcore/amcore.c
@@ -7,7 +7,7 @@
  * This file copies memory testdram() from sandburst/common/sb_common.c
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/immap.h>
diff --git a/board/sysam/stmark2/stmark2.c b/board/sysam/stmark2/stmark2.c
index 475e3edfa62e..7818f2671d5a 100644
--- a/board/sysam/stmark2/stmark2.c
+++ b/board/sysam/stmark2/stmark2.c
@@ -5,7 +5,7 @@
  * (C) Copyright 2017 Angelo Dureghello <angelo@sysam.it>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <spi.h>
 #include <asm/global_data.h>
-- 
2.34.1

