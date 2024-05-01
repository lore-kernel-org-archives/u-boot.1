Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414C6C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:48:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335CE88AF5;
	Wed,  1 May 2024 04:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t8LFsEwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC4C88AF5; Wed,  1 May 2024 04:43:54 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB4488ACE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-790c36dcee9so307517685a.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531430; x=1715136230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jkLegOnroJwBONhf7MNMooEVcgZnQaWkdVVzAD/1ESY=;
 b=t8LFsEwn4N6wl4FFSlXbfD7H5gyQuBtosGUI2cQfFWXNyvnfw5utAxf47MgGOz4psV
 nVxbKqOHVMQjJqMgIAQtDmXUuX9VqqqQRY20pDy43T/09nyT7MF0uZoPjQzEAGWfxrZ0
 k2u0V9EiJlGi1UDIR07JcTBYOjEg5Eru/h0og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531430; x=1715136230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkLegOnroJwBONhf7MNMooEVcgZnQaWkdVVzAD/1ESY=;
 b=JaIOdoXUR/EZk8jaAWFLorTMJoLxwEYLp6o6dRb8+PlkfyK5oB4Xc+2rWZEgVbllUZ
 ele3STy98fBZuMepYxq0SpB7MnGsk38KYkFh8zW8IqbvkwdlEPLFJvr2SypJ8KimIYbK
 Vsj2tF8Txn+oiJXUivA/n+hYNgx6uIxe555yCs5gd3lHbcfwcLPsDHmQ6ik8W9tVpQKR
 lgqE7eNa97GUHAOUEPCKA9D8hK6IiqPaI81tdb2+UgtM5IvO1gJRUUkDmsX/g2kxkg7e
 8KbykOYf14+eMVkw2TDazYyonWyIOuk7hLB95Qy3ffy6psRbjiowk/6U0+h2Y77M0Wv8
 sdZQ==
X-Gm-Message-State: AOJu0YzTV2aoBuw3NQ1T3tUy+S2Ztj+/H8fxLmOmUHFfFX7mGUXqKwO9
 iwe/weOLxSZlHauKf73l5Jrk1fD6KhvpGs09mwc4cirUwfpUfpngaW0NSpnQXCjCsDUF6OwSZnd
 iL/ulWg==
X-Google-Smtp-Source: AGHT+IFWwFDnUoklTLMhvGkU7InvDEujOgko2ywZ6nCIWIrhVVU8j0JzelPG3ROh63igHaqkB/SWOw==
X-Received: by 2002:ad4:5968:0:b0:6a0:c953:cb02 with SMTP id
 eq8-20020ad45968000000b006a0c953cb02mr1266405qvb.3.1714531430139; 
 Tue, 30 Apr 2024 19:43:50 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 Heiko Schocher <hs@denx.de>
Subject: [PATCH 027/149] board: bosch: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:14 -0600
Message-Id: <20240501024316.1767971-27-trini@konsulko.com>
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
Cc: Matthias Winker <matthias.winker@de.bosch.com>
Cc: Philip Oberfichtner <pro@denx.de>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>
Cc: Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>
Cc: Heiko Schocher <hs@denx.de>
---
 board/bosch/acc/acc.c        | 2 +-
 board/bosch/guardian/board.c | 2 +-
 board/bosch/guardian/mux.c   | 1 -
 board/bosch/shc/board.c      | 2 +-
 board/bosch/shc/mux.c        | 1 -
 5 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/board/bosch/acc/acc.c b/board/bosch/acc/acc.c
index 65c2f3567135..a1a00e7ffc49 100644
--- a/board/bosch/acc/acc.c
+++ b/board/bosch/acc/acc.c
@@ -5,7 +5,7 @@
  * Copyright (c) 2022 DENX Software Engineering GmbH, Philip Oberfichtner <pro@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <bootstage.h>
 #include <dm.h>
diff --git a/board/bosch/guardian/board.c b/board/bosch/guardian/board.c
index ee9e6d632ed4..41d7567ad21e 100644
--- a/board/bosch/guardian/board.c
+++ b/board/bosch/guardian/board.c
@@ -8,7 +8,7 @@
  * Copyright (C) 2018 Robert Bosch Power Tools GmbH
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <env_internal.h>
 #include <errno.h>
diff --git a/board/bosch/guardian/mux.c b/board/bosch/guardian/mux.c
index 53850ffb8f7e..eab3398c4aec 100644
--- a/board/bosch/guardian/mux.c
+++ b/board/bosch/guardian/mux.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2018 Robert Bosch Power Tools GmbH
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/mux.h>
diff --git a/board/bosch/shc/board.c b/board/bosch/shc/board.c
index aebdfd4dfec0..ab688745938a 100644
--- a/board/bosch/shc/board.c
+++ b/board/bosch/shc/board.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <bootstage.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/board/bosch/shc/mux.c b/board/bosch/shc/mux.c
index f19d1866c721..a2a8947a3bd8 100644
--- a/board/bosch/shc/mux.c
+++ b/board/bosch/shc/mux.c
@@ -9,7 +9,6 @@
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <hang.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
-- 
2.34.1

