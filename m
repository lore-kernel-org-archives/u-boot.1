Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2273CC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35A9D88BB3;
	Wed,  1 May 2024 04:44:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z80kuUr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142C388BB2; Wed,  1 May 2024 04:44:47 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB5DF88B97
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-790f91b834cso232637085a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531483; x=1715136283; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pi8AXEqSn6GcYiupcZTt1yd0MUZSUnAt+ndS+pNaZo=;
 b=Z80kuUr3t6PBaTFdrh59cR643WuCOp5bT2/29Sb8O0QmoJQNx/2NPhcZnwRs12uAG6
 e0VWjslFLgy13ys3Ql1mPTBP4knZ5Rm3xSWa+ZEi/jLR6tUcJBNtmY33cd4+yjDWb18Q
 PSyWtlOremFtOxsJkwBHQeoa7HkXJjEX8ef/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531483; x=1715136283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/pi8AXEqSn6GcYiupcZTt1yd0MUZSUnAt+ndS+pNaZo=;
 b=UDj3hksMupmyoRc0iJdlBZBxRbrHUc2r2udRLs1Iljc4hsQ+V7znBC1G1KUpNdviFr
 CvsfBDoEHqvSE7vp8ZbUw/1hfD263gtYy3b89qBo7ZXLg8iyt2xszYWpKw3oj2F4U4NV
 RjeHMxB1YWsJuiPxk5lgy3mnpmW11U3z+SERaOyppkCTxxcpwlnFmowC7i/iaODjjADN
 MVoT8+kGqU0wOCTqa28vNGL7D2Kypo5mtxYbT0W+ZUcaSbo6vfLF8L4Llx8JXfvN5BkX
 PrArEidrudB+fjmavdJVZiOoQfsuHnuuAu/V0Sp/FWI1rrdkn56DfcAJ+my1H9uWXTjq
 pAmg==
X-Gm-Message-State: AOJu0Ywp4PkesokUFHEO4XY49zEwoLyeDnFNwFcp7jJ+716kmZN8qkZJ
 rFChsYvdInGtQQGiITJ/P8IiFC6GGpwkwdv0XvoA1VqZPogzlHc8e2rb2Dle7Ih9Lkx2fRoGfAz
 KAjXNSQ==
X-Google-Smtp-Source: AGHT+IHtSlmooiEtAD1jOIXdKna2hdVyf7t1DvzRJlKpjMv4kDKJ62m86DdSnHDzzq79ITi54hSKMA==
X-Received: by 2002:a05:6214:62d:b0:69b:4c1a:83ca with SMTP id
 a13-20020a056214062d00b0069b4c1a83camr1061315qvx.26.1714531483436; 
 Tue, 30 Apr 2024 19:44:43 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Paul Burton <paul.burton@mips.com>,
 Ezequiel Garcia <ezequiel@collabora.com>,
 Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: [PATCH 072/149] board: imgtec: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:59 -0600
Message-Id: <20240501024316.1767971-72-trini@konsulko.com>
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
Cc: Paul Burton <paul.burton@mips.com>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
---
 board/imgtec/boston/checkboard.c | 1 -
 board/imgtec/boston/ddr.c        | 2 +-
 board/imgtec/boston/dt.c         | 1 -
 board/imgtec/ci20/ci20.c         | 1 -
 board/imgtec/malta/superio.c     | 1 -
 board/imgtec/xilfpga/xilfpga.c   | 2 +-
 6 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/board/imgtec/boston/checkboard.c b/board/imgtec/boston/checkboard.c
index c246a7b9d455..b0f7d3243c5e 100644
--- a/board/imgtec/boston/checkboard.c
+++ b/board/imgtec/boston/checkboard.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Imagination Technologies
  */
 
-#include <common.h>
 #include <init.h>
 
 #include <asm/io.h>
diff --git a/board/imgtec/boston/ddr.c b/board/imgtec/boston/ddr.c
index cecf454011cc..55356d1175de 100644
--- a/board/imgtec/boston/ddr.c
+++ b/board/imgtec/boston/ddr.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2016 Imagination Technologies
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 
diff --git a/board/imgtec/boston/dt.c b/board/imgtec/boston/dt.c
index bf772ff5dec4..874a21cec61e 100644
--- a/board/imgtec/boston/dt.c
+++ b/board/imgtec/boston/dt.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Imagination Technologies
  */
 
-#include <common.h>
 #include <fdt_support.h>
 #include <asm/global_data.h>
 
diff --git a/board/imgtec/ci20/ci20.c b/board/imgtec/ci20/ci20.c
index 89f5e7ad792c..4e268381d3c5 100644
--- a/board/imgtec/ci20/ci20.c
+++ b/board/imgtec/ci20/ci20.c
@@ -6,7 +6,6 @@
  * Author: Paul Burton <paul.burton@imgtec.com>
  */
 
-#include <common.h>
 #include <env.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/imgtec/malta/superio.c b/board/imgtec/malta/superio.c
index aba11e25be31..edd5c203b16d 100644
--- a/board/imgtec/malta/superio.c
+++ b/board/imgtec/malta/superio.c
@@ -6,7 +6,6 @@
  * Setup code for the FDC37M817 super I/O controller
  */
 
-#include <common.h>
 #include <asm/io.h>
 
 #define SIO_CONF_PORT		0x3f0
diff --git a/board/imgtec/xilfpga/xilfpga.c b/board/imgtec/xilfpga/xilfpga.c
index 712269272114..e50ee8efe558 100644
--- a/board/imgtec/xilfpga/xilfpga.c
+++ b/board/imgtec/xilfpga/xilfpga.c
@@ -8,7 +8,7 @@
  *
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
 
-- 
2.34.1

