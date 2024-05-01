Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E377C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F3288AA2;
	Wed,  1 May 2024 04:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TPfgYqCz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4F6488A94; Wed,  1 May 2024 04:43:28 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D910E88A88
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-43716ff5494so4364341cf.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531405; x=1715136205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07dj89/VjNcljRAotSecZYEkKJtHJF0fkT8NGj10KQk=;
 b=TPfgYqCzR5fSZSpH/8zDURzbee+37hQuljsJTB0P4IxrKRNgLCJvDoTdqsUM6Z2HB3
 dCheAAGYNX6ZCvJtBkXFO7uuSYIXWgyu5OhDvQ8YuaJkKEMnjb1/ymJAybyHxVMjnk+U
 Dt51pfuO45tYZrOplSSm2k/QAp7CSbqx23YVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531405; x=1715136205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07dj89/VjNcljRAotSecZYEkKJtHJF0fkT8NGj10KQk=;
 b=jrmN6gw5z31meIUg6NsEKx3HmUr/OByVD2BbHjCWb7rPghx9ba0Trpc9DfLGVr5DZY
 qFeu82nDxYMc2aruWoMWLDUuYZGRecG4vRYYiZEObl2EMF9BIKmvMjG4NSIPFznAyJHt
 k8EMUtnqY291nhuWjZYueZ1zOieC5600jwD0OOfugolQOj2MX6EDeo3OktzKUZ4Ib5iK
 yl3NAu4MR7DoEjPx0QZmM4jvB9deXikZUqNRjK7/J5u9woMotby/t03TJOf5rlMUnpuk
 xUvkvUlSTdWGMTd74zT7vmVMZWzwFszBA5eMCKwrfNoefob3ghEMVqaFE0ILEkLZS4cE
 q2JQ==
X-Gm-Message-State: AOJu0YyilVom8nJF7j7HJ83deyM4nSEw9JRU2Lgnzr9b+yRMPCbOvZZf
 wbTDsxpjj6/3sf5cA6+otL44gUuw5Mu1T6m5J9awpfUp6c/yseMCT+xhABHSQmXoT93r8Ihv3tr
 2ab031g==
X-Google-Smtp-Source: AGHT+IHrkFa7ls0nALx/b7HS1OGz1o4WR//FodlMuRHIph1Ns3w+CEEXxo3y2IQRHri0XJBK6Zzfmg==
X-Received: by 2002:a05:6214:2683:b0:6a0:9496:8412 with SMTP id
 gm3-20020a056214268300b006a094968412mr1366081qvb.0.1714531405335; 
 Tue, 30 Apr 2024 19:43:25 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jens Scharsig <esw@bus-elektronik.de>
Subject: [PATCH 007/149] board: BuS: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:40:54 -0600
Message-Id: <20240501024316.1767971-7-trini@konsulko.com>
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
Cc: Jens Scharsig <esw@bus-elektronik.de>
---
 board/BuS/eb_cpu5282/eb_cpu5282.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/BuS/eb_cpu5282/eb_cpu5282.c b/board/BuS/eb_cpu5282/eb_cpu5282.c
index ea49c7a99c0b..cf5610861b50 100644
--- a/board/BuS/eb_cpu5282/eb_cpu5282.c
+++ b/board/BuS/eb_cpu5282/eb_cpu5282.c
@@ -7,7 +7,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <asm/global_data.h>
 #include "asm/m5282.h"
-- 
2.34.1

