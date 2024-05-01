Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88664C10F1A
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D3B88C79;
	Wed,  1 May 2024 04:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s/Mh7KfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3E6688C18; Wed,  1 May 2024 04:45:34 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62E3F88771
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-790c36dcee9so307589785a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531531; x=1715136331; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypK9lxfs8ldVJarsFXnyhnytW0XUElDLWc0MMjdiEF4=;
 b=s/Mh7KfK5frsbCMAgQ8bTb/x5iaTtgZlijUcmDqFSpzfE4edu4dHt1VRNKz0YNol9/
 /wfjTGphKajkLkeZhWWPz8loqnPejnOzf+cXwndpvAZ0ynxGFwLJdZW4jW0VDOq3PAO4
 XS2otC7Ki8ZdzCgUen+aElxZ0pN8OfI0EBUv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531531; x=1715136331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypK9lxfs8ldVJarsFXnyhnytW0XUElDLWc0MMjdiEF4=;
 b=v8Y129s3s2Mi/iBO7Hg542zKRLFMSXfeGiHedCv5T+VcbV0HKuMqBzeAMoFhl7ngY/
 GkqjEokjsuFJ/2lGlEioxHc1oznOUoR8VJBrympxXBHjK1J3JOkws2lIB9xyFZ8cCyHB
 bC9DnFdMObxr4r6xHtGC8ATOXoiIzZ6o9bbPRNYpBUUxbeNabWUIqNvDC5/KnivEGyK0
 tiRSokueaDsBH1h2uYCw74N0fcZiOiZ1GnOBvfqUXCovVizc8wOb5mxBiQMVU4Hao1ak
 2s1XfRWnA98KNI/oAIKU3S+tECNSM0liaB6G7I3uxbuoYbkDDD0ZmKCSMKxu/7oBYz44
 U/ug==
X-Gm-Message-State: AOJu0Yx9PyG0npKvxgl5OAdNrOHcZSamg3XNq96jmCYJMHZy7eD4QIYs
 yBzZhcW21qVYmh1TgxboqwDQEt1YEVQFId3/mi7ADrD8ksLuvzA9ufTAh4na5W9Dp7V0grUp1AW
 7duan9zau
X-Google-Smtp-Source: AGHT+IHmOgS20y9WQLsR/QStsIQ9JmmCcW4oIRE+sz/vPugrGKL9Kv5EQQ+gSsvGkf9fhWW1dhi9qw==
X-Received: by 2002:a05:6214:e46:b0:6a0:dda7:744f with SMTP id
 o6-20020a0562140e4600b006a0dda7744fmr1454357qvc.37.1714531530935; 
 Tue, 30 Apr 2024 19:45:30 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <agust@denx.de>, Heiko Schocher <hs@denx.de>,
 Le Jin <le.jin@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 116/149] board: siemens: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:43 -0600
Message-Id: <20240501024316.1767971-116-trini@konsulko.com>
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
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Heiko Schocher <hs@denx.de>
Cc: Le Jin <le.jin@siemens.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
---
 board/siemens/capricorn/board.c   | 1 -
 board/siemens/capricorn/spl.c     | 1 -
 board/siemens/corvus/board.c      | 2 +-
 board/siemens/iot2050/board.c     | 2 +-
 board/siemens/smartweb/smartweb.c | 2 +-
 board/siemens/taurus/taurus.c     | 2 +-
 6 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/board/siemens/capricorn/board.c b/board/siemens/capricorn/board.c
index b1d7e3b1c05a..53dac8bfe1be 100644
--- a/board/siemens/capricorn/board.c
+++ b/board/siemens/capricorn/board.c
@@ -5,7 +5,6 @@
  * Copyright 2019 Siemens AG
  *
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <env.h>
diff --git a/board/siemens/capricorn/spl.c b/board/siemens/capricorn/spl.c
index e160c611a962..696b5ebd340b 100644
--- a/board/siemens/capricorn/spl.c
+++ b/board/siemens/capricorn/spl.c
@@ -5,7 +5,6 @@
  * Copyright 2019 Siemens AG
  *
  */
-#include <common.h>
 #include <init.h>
 #include <spl.h>
 #include <dm.h>
diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
index 569b86db00ac..7d73d1f2b361 100644
--- a/board/siemens/corvus/board.c
+++ b/board/siemens/corvus/board.c
@@ -10,7 +10,7 @@
  * Lead Tech Design <www.leadtechdesign.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/board/siemens/iot2050/board.c b/board/siemens/iot2050/board.c
index 0b0686e2628b..ed292c364a5f 100644
--- a/board/siemens/iot2050/board.c
+++ b/board/siemens/iot2050/board.c
@@ -8,7 +8,7 @@
  *   Jan Kiszka <jan.kiszka@siemens.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <bootstage.h>
 #include <dm.h>
 #include <fdt_support.h>
diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
index 15044c7d0edf..946fbc3f2299 100644
--- a/board/siemens/smartweb/smartweb.c
+++ b/board/siemens/smartweb/smartweb.c
@@ -15,7 +15,7 @@
  * DENX Software Engineering GmbH
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <init.h>
 #include <net.h>
diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
index ad44a7c0d28b..bda12a977088 100644
--- a/board/siemens/taurus/taurus.c
+++ b/board/siemens/taurus/taurus.c
@@ -12,7 +12,7 @@
  */
 
 #include <command.h>
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <env.h>
 #include <init.h>
-- 
2.34.1

