Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5123CC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0895288A95;
	Wed,  1 May 2024 04:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ne2cd0TL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227B988A93; Wed,  1 May 2024 04:43:28 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACCED88A83
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6a0c8fb3540so4312366d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531404; x=1715136204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SZiN19m7Y5Hg+lXqq+hFNkkzY4toW1dhGZMJQRAg7E=;
 b=ne2cd0TLr0TcIgnT4WMgcXijn/67knOUifBT1gH1Xgjf/5R1tgczundGIgUUF8mk1Z
 unOOomNzt+Nq0ENMNCsUOW07qD8j83LkuLSMWbf3OvhdFTsO49Zdaf+OnlmiTezoWZl1
 A6+C3aOsIhfZuSEiAozaI3gkTwA4ay4jMczDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531404; x=1715136204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SZiN19m7Y5Hg+lXqq+hFNkkzY4toW1dhGZMJQRAg7E=;
 b=Rnvd19Is/dyh/J/Iss/qSMeus/sSzv8kmmBx/k1BBTyelFWImpQMzew9VYUuvf0i0I
 AYOUHHqasWG7PH1clmDPzBYc+9UNKBnCIpAX1x9vtWhASOltc9byPSJUaFFzLgxOYHdk
 Lvcc4JEK82+7JpgYwgMn/sjJgcIJnnRzhHY1aKznEwXm8ch3+sUvK8HCel/toqBCHwEP
 3dEpG1azVjLX8KklYcNNTCQgXfptRRQj+V/HPCwyqHivHga3g21UkJ58uxXc2JJBT3ms
 82cWQ6Jaj4yFnxSBl9SnpB+j8jVt1TNt6GB6ku05cqxXxhFRDuZtHhgFjtEu0IxlreXU
 L1LQ==
X-Gm-Message-State: AOJu0YzmF/cPttA4jywLSRHpYfoOB5oSTthf9GdTIQx1bGmzlpGhD/XX
 CyGCHKc8YMxB3QafYwY+F2VYgBSj5UjA/jxz4IfNSDQN1pUBfodcNv9UfOwlT+Ibkk1btbeZE0b
 auywHxA==
X-Google-Smtp-Source: AGHT+IFP+SQ+evH3Vnn32AKAZmGAECdpzPM7tom9ftBOanadlqAleK18sV5LKb9sYsE3/XXOAad4NQ==
X-Received: by 2002:ad4:4d03:0:b0:6a0:ef09:dbaf with SMTP id
 l3-20020ad44d03000000b006a0ef09dbafmr1278887qvl.19.1714531404150; 
 Tue, 30 Apr 2024 19:43:24 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH 006/149] board: BuR: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:40:53 -0600
Message-Id: <20240501024316.1767971-6-trini@konsulko.com>
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
Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
---
 board/BuR/brppt1/board.c     | 2 +-
 board/BuR/brppt1/mux.c       | 1 -
 board/BuR/brppt2/board.c     | 1 -
 board/BuR/brsmarc1/board.c   | 1 -
 board/BuR/brsmarc1/mux.c     | 1 -
 board/BuR/brxre1/board.c     | 1 -
 board/BuR/brxre1/mux.c       | 1 -
 board/BuR/common/br_resetc.c | 1 -
 board/BuR/common/common.c    | 1 -
 9 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/board/BuR/brppt1/board.c b/board/BuR/brppt1/board.c
index 36945bbdccf5..192a2fa6327b 100644
--- a/board/BuR/brppt1/board.c
+++ b/board/BuR/brppt1/board.c
@@ -9,7 +9,7 @@
  *
  */
 
-#include <common.h>
+#include <config.h>
 #include <bootcount.h>
 #include <env.h>
 #include <errno.h>
diff --git a/board/BuR/brppt1/mux.c b/board/BuR/brppt1/mux.c
index 5d2c7a201ea0..8932b9ab3b1a 100644
--- a/board/BuR/brppt1/mux.c
+++ b/board/BuR/brppt1/mux.c
@@ -8,7 +8,6 @@
  * Bernecker & Rainer Industrieelektronik GmbH - http://www.br-automation.com
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
diff --git a/board/BuR/brppt2/board.c b/board/BuR/brppt2/board.c
index ee006f0196c6..105fac8912d0 100644
--- a/board/BuR/brppt2/board.c
+++ b/board/BuR/brppt2/board.c
@@ -6,7 +6,6 @@
  * B&R Industrial Automation GmbH - http://www.br-automation.com/
  *
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
diff --git a/board/BuR/brsmarc1/board.c b/board/BuR/brsmarc1/board.c
index 738a5d2ff944..2d3f593d0ab0 100644
--- a/board/BuR/brsmarc1/board.c
+++ b/board/BuR/brsmarc1/board.c
@@ -8,7 +8,6 @@
  * B&R Industrial Automation GmbH - http://www.br-automation.com
  *
  */
-#include <common.h>
 #include <errno.h>
 #include <init.h>
 #include <spl.h>
diff --git a/board/BuR/brsmarc1/mux.c b/board/BuR/brsmarc1/mux.c
index 33c214d6b2a7..b59d64f93ef3 100644
--- a/board/BuR/brsmarc1/mux.c
+++ b/board/BuR/brsmarc1/mux.c
@@ -9,7 +9,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
diff --git a/board/BuR/brxre1/board.c b/board/BuR/brxre1/board.c
index a909104df4ac..b9b595cb156d 100644
--- a/board/BuR/brxre1/board.c
+++ b/board/BuR/brxre1/board.c
@@ -8,7 +8,6 @@
  * Bernecker & Rainer Industrieelektronik GmbH - http://www.br-automation.com
  *
  */
-#include <common.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/BuR/brxre1/mux.c b/board/BuR/brxre1/mux.c
index 6c5ad891ba91..e2e8ec57678f 100644
--- a/board/BuR/brxre1/mux.c
+++ b/board/BuR/brxre1/mux.c
@@ -8,7 +8,6 @@
  * Bernecker & Rainer Industrieelektronik GmbH - http://www.br-automation.com
  */
 
-#include <common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
diff --git a/board/BuR/common/br_resetc.c b/board/BuR/common/br_resetc.c
index 32f32b65e9d8..f5d09fef3d34 100644
--- a/board/BuR/common/br_resetc.c
+++ b/board/BuR/common/br_resetc.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Hannes Schmelzer <oe5hpm@oevsv.at>
  * B&R Industrial Automation GmbH - http://www.br-automation.com/ *
  */
-#include <common.h>
 #include <env.h>
 #include <errno.h>
 #include <i2c.h>
diff --git a/board/BuR/common/common.c b/board/BuR/common/common.c
index 3c78020bf93c..8aff821cfe8a 100644
--- a/board/BuR/common/common.c
+++ b/board/BuR/common/common.c
@@ -10,7 +10,6 @@
  */
 #include <log.h>
 #include <version.h>
-#include <common.h>
 #include <env.h>
 #include <fdtdec.h>
 #include <i2c.h>
-- 
2.34.1

