Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51FBC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDAC88B5B;
	Wed,  1 May 2024 04:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PvOyLDEq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32BD88B4F; Wed,  1 May 2024 04:44:22 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64C6D88B5B
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6a073f10e8eso30745216d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531459; x=1715136259; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEDm9ObA9kDjtrBoV3YuTxS6YsnJfDam3Cx59Tjjqy8=;
 b=PvOyLDEqz8bdTTlo7nBrKDOKOyqopVhOtrmuvJdpWK1cNdGbhu3JpA1YIBF/wCETkd
 XybR6XS0gMur9r2BZvYhF3ubicp7lJ3uFzr08GYyBw9xbj+jUSfN+5SFx1iv9snDm6zp
 DfCCob4hK+JeB9ZfB59213jXDLWnnrkVDPPzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531459; x=1715136259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEDm9ObA9kDjtrBoV3YuTxS6YsnJfDam3Cx59Tjjqy8=;
 b=qBOkFeNfLws0qlndCWIsdJ/2ZhswDoIl4Q2FIE0/p5bbNFl/j+nGExUGeHk4sVwGx3
 dBl+T3KzumW0xWIAECmZ7bQn8nzc/aapOgEP9Rfx2hdBng0K9WEI37z90EsZJCPBdZVg
 W3FXN8jiOjlK6uvThN+lC4pm3vXIsJAI719xxYE+owUvLW5pUJn50/AJ0Xq25Y3gTEK5
 jzOE4v1UfjydQxLQLcpkU8GXTl6+Zq7eb2DFCviKIXGa30iUrrAlZgMXoWJjNj2YoB6w
 7IYPpEogeMdZuDXzO3srfMg8WtUUgO5pg4iJVSFwgvvdCU87TMlNoz7P+Rb1l56bZHBp
 9F+g==
X-Gm-Message-State: AOJu0Yw9vAt4tPI+Ozwxzr7KLrAFL8xTJmplPk2rVkXilG7l/FF4H9H5
 wFwMI2uKKSmg2Zhi4X/MAHlyfO3gHZuJ+tlBm/iqtBPtLBaOlnyGBoIeoLU4e9D+zrSK3IlJnZ+
 I4Lw2fw==
X-Google-Smtp-Source: AGHT+IFJH2fCzfZ1mZhNUDkVya9qPWO4Veh9nHeuqswM9brymlG4qkhNYpCoGt0fpVSlTNELjxlpoA==
X-Received: by 2002:a05:6214:2623:b0:69b:7af:62e2 with SMTP id
 gv3-20020a056214262300b0069b07af62e2mr1382338qvb.36.1714531458887; 
 Tue, 30 Apr 2024 19:44:18 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Felix Brack <fb@ltec.ch>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 052/149] board: eets: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:41:39 -0600
Message-Id: <20240501024316.1767971-52-trini@konsulko.com>
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
Cc: Felix Brack <fb@ltec.ch>
Cc: Nishanth Menon <nm@ti.com>
---
 board/eets/pdu001/board.c | 2 +-
 board/eets/pdu001/mux.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/eets/pdu001/board.c b/board/eets/pdu001/board.c
index 3a52e4ae675f..2ad256f86357 100644
--- a/board/eets/pdu001/board.c
+++ b/board/eets/pdu001/board.c
@@ -9,7 +9,7 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <errno.h>
 #include <init.h>
diff --git a/board/eets/pdu001/mux.c b/board/eets/pdu001/mux.c
index c97927e5cfe9..f306a1340315 100644
--- a/board/eets/pdu001/mux.c
+++ b/board/eets/pdu001/mux.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <i2c.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
-- 
2.34.1

