Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E0DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1FD88B2A;
	Wed,  1 May 2024 04:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UKGcb123";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4863188B20; Wed,  1 May 2024 04:44:07 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A3D388B13
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7f012a66df7so1380805241.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531444; x=1715136244; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3v13pjHeHVjq84C0OkC85Hl9VYOcGNmwim/cfCd3lo=;
 b=UKGcb123ykcYNIMn9Qpwv0wu5rXRgUrIMbBOwotwn+XSQFZQmUaYBn7oQv2VWJIVBQ
 iSUq1E2VYu21nf0el5LyfsusEOBIF75/0JHCZXxre+Ap3A9JPXgw9zB5ddkEn/eFV3A0
 wM0v4/RldxlNy33HMrVtnJS3ozfkgGFX63QdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531444; x=1715136244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3v13pjHeHVjq84C0OkC85Hl9VYOcGNmwim/cfCd3lo=;
 b=h4IFcOAo+R9pjwrbGeWzvpEa7KaUnQEQ620X8xLivLJILkcinEKmqo9vm5CTGBdyJ2
 YN6jznHqpQmpfllNj1dfZAVkY1M49p79NsO913XoaZzaK/9ToPQ4LtsEqRIGmb6dm7UJ
 TkIbFNoV/kwhcaBqDHrHLGmTXyF52BbD15NqviAwU26Sjo4BOhKM6wbn0/TtglbJI7Kz
 REjisdzICcCFm78yn2FVVOp2SnVLH2w7OTLEWeBT5OrA1Dge0qvCSkDypzry5aqVfAXs
 giWl49JrnWSX0dgmae6eQo02PJvpcAwWB6CqMQx7gYKb5cxeY4u+iOinm5VU3pH57JM5
 +5Kg==
X-Gm-Message-State: AOJu0YzbH3CdMgsdKs0Y8oFk6/m6K8JQozHmKhsWyBN75tB9GDpP2SsW
 uY9010ieLJst9eiixfjSn4bNmllmSYx7LbWAg9K9Vl/tQI/9FHSkR735SB4Hik5OnsbPZlvn+ra
 Lz1vdFw==
X-Google-Smtp-Source: AGHT+IH4KsbNh7PxuhotBlWOFFSlBCrupbla+Xhbge0EGohbqgUVKxmot291emAYc4AzQ4t8Gekecg==
X-Received: by 2002:a05:6102:525:b0:47b:ab56:825f with SMTP id
 m5-20020a056102052500b0047bab56825fmr1528737vsa.7.1714531443539; 
 Tue, 30 Apr 2024 19:44:03 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Dave Purdy <david.c.purdy@gmail.com>,
	Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 039/149] board: cloudengines: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:26 -0600
Message-Id: <20240501024316.1767971-39-trini@konsulko.com>
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
Cc: Dave Purdy <david.c.purdy@gmail.com>
Cc: Tony Dinh <mibodhi@gmail.com>
---
 board/cloudengines/pogo_e02/pogo_e02.c | 1 -
 board/cloudengines/pogo_v4/pogo_v4.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/cloudengines/pogo_e02/pogo_e02.c b/board/cloudengines/pogo_e02/pogo_e02.c
index 59e1218b411a..48eee67129fa 100644
--- a/board/cloudengines/pogo_e02/pogo_e02.c
+++ b/board/cloudengines/pogo_e02/pogo_e02.c
@@ -10,7 +10,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <netdev.h>
diff --git a/board/cloudengines/pogo_v4/pogo_v4.c b/board/cloudengines/pogo_v4/pogo_v4.c
index 61ce0d59c77e..c8ad563f721d 100644
--- a/board/cloudengines/pogo_v4/pogo_v4.c
+++ b/board/cloudengines/pogo_v4/pogo_v4.c
@@ -11,7 +11,6 @@
  * Written-by: Prafulla Wadaskar <prafulla@marvell.com>
  */
 
-#include <common.h>
 #include <netdev.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
-- 
2.34.1

