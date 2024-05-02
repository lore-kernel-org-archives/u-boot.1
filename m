Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C808CC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CB4088D1C;
	Thu,  2 May 2024 03:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QR5VMAbp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8221488D19; Thu,  2 May 2024 03:34:18 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 142BE88CFC
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-434d0e3f213so26249261cf.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613654; x=1715218454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/EMvbCAolFbFS9R2RqncDNfFG09zZD2ZCjb8y4vDPs=;
 b=QR5VMAbpmKOA8LePANSqGbsSNxLUX9Vi5xU1ARjyAccnz42p7q6NEY0TWtSvbcTG08
 dnCPvH9oiU82rJ6oeZ1+MsPMvOVp3B7IfNbuiUB5zWQ2PGFSL6d57Zuo11bJ4QKbuGUZ
 oYDMUL9DqEq7EIsnJFCVn64CXHjDA/YEoDIos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613654; x=1715218454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/EMvbCAolFbFS9R2RqncDNfFG09zZD2ZCjb8y4vDPs=;
 b=CMgsClbo0MH+uIYhUCF4XBNRjwVo4LWw5XPUYi3lT5WylwR0LetkC2mBWTIEr0Jhp9
 +FTefnxwC/jUHyDCSSyKonq5h+/w84F6zP7zJU5DkntqO+2rfk2pZIvnWrAvA8qow55J
 kbKfmicc4FKiBqNBUlyN4cCXqAZT3Mtn7+tgK1MV9BDH9unFvE5lp1f5XNE3QTXSNmZ1
 K7ULV4d2x9GH9Ihxn+Q/9T1HneJHHqj+CWL9x0/DwPCnNNLFjcYiNdKBULfu3y7s0Bnt
 ZLLT5JfiNyj1YL1gZ2EAafvBdBFwv347EpGFmVJIwKu6lTk0tvmjUN8iwE+LLKvVbowV
 JI7A==
X-Gm-Message-State: AOJu0YyiPvuKOqPX6U+aT5JdT/OrtnjA+6HfTEnUm/OWkXTrf4X+rnoV
 7CWiaEvV9tax25HCY2muIWGfmtZSCFSC+F6L/hzvCJCTIs+KoWds2TdCh/jFKS3ZcTnHshidNHP
 PK1gGZ6ah
X-Google-Smtp-Source: AGHT+IGJltJY0I8LIoSquVqpIsmv28MVikmLOlSQMWHW3PCDbmfqT0NbMuIEKhL2Z9sxIn+2VfA8BA==
X-Received: by 2002:a05:622a:1b01:b0:43a:10cd:9d3 with SMTP id
 bb1-20020a05622a1b0100b0043a10cd09d3mr730682qtb.11.1714613654718; 
 Wed, 01 May 2024 18:34:14 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:34:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Anastasiia Lukianenko <vicooodin@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 79/81] xen: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:36 -0600
Message-Id: <20240502013138.2383421-79-trini@konsulko.com>
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
Cc: Anastasiia Lukianenko <vicooodin@gmail.com>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/xen/events.c     | 1 -
 drivers/xen/gnttab.c     | 1 -
 drivers/xen/hypervisor.c | 1 -
 drivers/xen/pvblock.c    | 1 -
 drivers/xen/xenbus.c     | 1 -
 include/xen/events.h     | 1 +
 6 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/xen/events.c b/drivers/xen/events.c
index 2ebe20dbf26e..fa8b13d2c61d 100644
--- a/drivers/xen/events.c
+++ b/drivers/xen/events.c
@@ -14,7 +14,6 @@
  *
  * [1] - http://xenbits.xen.org/gitweb/?p=mini-os.git;a=summary
  */
-#include <common.h>
 #include <log.h>
 
 #include <asm/io.h>
diff --git a/drivers/xen/gnttab.c b/drivers/xen/gnttab.c
index 31e96e2939c0..005694a5c626 100644
--- a/drivers/xen/gnttab.c
+++ b/drivers/xen/gnttab.c
@@ -14,7 +14,6 @@
  *
  * [1] - http://xenbits.xen.org/gitweb/?p=mini-os.git;a=summary
  */
-#include <common.h>
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <log.h>
diff --git a/drivers/xen/hypervisor.c b/drivers/xen/hypervisor.c
index 0b2311ba2675..d28df823c684 100644
--- a/drivers/xen/hypervisor.c
+++ b/drivers/xen/hypervisor.c
@@ -8,7 +8,6 @@
  * Copyright (c) 2005, Grzegorz Milos, gm281@cam.ac.uk,Intel Research Cambridge
  * Copyright (c) 2020, EPAM Systems Inc.
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <memalign.h>
diff --git a/drivers/xen/pvblock.c b/drivers/xen/pvblock.c
index 9fc51d203e5e..0e47ffb46a82 100644
--- a/drivers/xen/pvblock.c
+++ b/drivers/xen/pvblock.c
@@ -7,7 +7,6 @@
 #define LOG_CATEGORY UCLASS_PVBLOCK
 
 #include <blk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <malloc.h>
diff --git a/drivers/xen/xenbus.c b/drivers/xen/xenbus.c
index 177d144723c1..36de52550997 100644
--- a/drivers/xen/xenbus.c
+++ b/drivers/xen/xenbus.c
@@ -15,7 +15,6 @@
  * [1] - http://xenbits.xen.org/gitweb/?p=mini-os.git;a=summary
  */
 
-#include <common.h>
 #include <log.h>
 
 #include <asm/armv8/mmu.h>
diff --git a/include/xen/events.h b/include/xen/events.h
index 82bd18b48c88..f0a8ef32d00b 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -15,6 +15,7 @@
 #ifndef _EVENTS_H_
 #define _EVENTS_H_
 
+#include <asm/ptrace.h>
 #include <asm/xen/hypercall.h>
 #include <xen/interface/event_channel.h>
 
-- 
2.34.1

