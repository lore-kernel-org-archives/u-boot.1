Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33200C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 045EE88C5A;
	Wed,  1 May 2024 04:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WvXL+6ZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DDE87EF5; Wed,  1 May 2024 04:45:27 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E21A88C5C
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-69b782287f9so30786356d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531524; x=1715136324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ao9z6ZPY8QZ3armtIbVsrRPrF2rBc23xG5gZhREF6wU=;
 b=WvXL+6ZOG4yykbKazXmfvXkBeTYD7KS8PCzntXA7ZIADZwjhb83UXijMWTg7dnpvUe
 uedlS92OcPVt3mDWLJf1qPtX4kKeLNhptWbRLIQpiTbtcpkva+SkFzN/1oFZNyMDpKxw
 1kxVO+nBhNRDhuFmkr0Ii2IBgrErlSK9XcE0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531524; x=1715136324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ao9z6ZPY8QZ3armtIbVsrRPrF2rBc23xG5gZhREF6wU=;
 b=AOUnFOclrhSO1e1jwRgaHFdbGCbOwPZk2xgjhc7Ou6wJMunGn3zYybbPmw+RBEqZWQ
 cY0zzCuJs4RWYxLeHgNfEspsELYVywUp5szixFA3Vg8ssw1m5iMDEeBUYstZwrgfUL9i
 fLVyExF7eHMUgGyi7rmUh+z148sbdS8pS3lRDY/BNw4IseP0C+6DmgPge0D7bIU4OKus
 fOzieAJImknt0bhjI/nmm/P2OxJlVDqzop63FTHClFzJs1kWlvMmheIr3a79XREU1plt
 4GGbHQSw/3GBoyDKyWdISCghcAT1jg/LuQ1MJJgmKBtIPaLy3Wn0YYrybqZKFnBdsLRs
 dv8Q==
X-Gm-Message-State: AOJu0Yx34WeBuI4Pk9bpczlZsu2vXovyNXlL0ESJ/B/GfhaYtNjS7coI
 NwSyZMnwf54gHoTE5W9O9Y8C0TNwzwZ3vJB+sLrgwU4HBtdKAhp3QUSYQvRSxwrNKip4bw93yiV
 IiItbBVbS
X-Google-Smtp-Source: AGHT+IG/Ve8MZvTAmyDTugyqkL63UR3wyKJzI3Ls901Hjc/T4e9COrxnh6vYPhwijoHOPZsW6XPhGg==
X-Received: by 2002:a05:6214:2129:b0:69b:6fc5:ce4d with SMTP id
 r9-20020a056214212900b0069b6fc5ce4dmr1400010qvc.2.1714531524202; 
 Tue, 30 Apr 2024 19:45:24 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 110/149] board: raspberrypi: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:37 -0600
Message-Id: <20240501024316.1767971-110-trini@konsulko.com>
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
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 2851ebc98535..d996eb0cf695 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2012-2016 Stephen Warren
  */
 
-#include <common.h>
 #include <config.h>
 #include <dm.h>
 #include <env.h>
-- 
2.34.1

