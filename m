Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3CDC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A30388B92;
	Wed,  1 May 2024 04:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TnF200AH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC73488B8B; Wed,  1 May 2024 04:44:37 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDEEA88B7A
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b44071a07so60773546d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531473; x=1715136273; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weilCs0Wdh1s6KP4BeAMpLa5nTao2AuZQ+AXJ+76W/Q=;
 b=TnF200AHn+p+1L9QYKlzgpNJFTIn+DlOtZy2B76ifp5OpoyLz+muMn5Sc1DW4f8Pfw
 ifGaohZHzt8M4G/WKQV2+gO1kLtcDqD5VH3TtwC/L/rSSyCzrL/W1tKnFtbAO6qJM4LP
 u8SAegmWaJ+zwIfmeYU8uvymH/jAGuSeuor8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531473; x=1715136273;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=weilCs0Wdh1s6KP4BeAMpLa5nTao2AuZQ+AXJ+76W/Q=;
 b=vzt9okIqC8ova6EGlabo369599UCXjaw9DWhfsAEYkmQ5ul7oeiPKuVkavmYfmBxLw
 zOwQ9/Kd/cU3mbSZX/DC8FILBCywWvzJ6bcD+t8A/TTueo7SQ1+STqvKfqUn5tbW+Nap
 /6pyh60JksHxeluux3F9x15x5jAYJmR9T37hJ6LkPDqpEzSWS01n4MBo6Rfj2Ev/quHz
 l5QGeGm3rdsdL2+a+/EygeOBicbYuvSL4u40t+mVs4l73SRHcPzGChfC45swztucJ44b
 J+J5K2gb90qTaII1mZjGaA7hbenTkGqYw+PUZ3JZQ1gH4uevjFZzF/vcCEplUrAVXdzt
 2YOA==
X-Gm-Message-State: AOJu0YwvRCD/hn4fxabYWwQX1IncM2soZ2+eqaqD+TZPEzlg9GIPLihy
 DssHjG3KOkzY7jS5vo+7o8rG9qOD2QdePQJHMWypr3qKIyc6RoirdIchh5+OfXkWTjqjaviam6O
 ryrnbEg==
X-Google-Smtp-Source: AGHT+IEGZZAAv1FIutdjvxYTGr192fvCAyhQZQGcJLOaKTBY3R+CpCIC6HS20hKVHZMNXbEMKmdp3A==
X-Received: by 2002:a05:6214:226b:b0:69b:3923:94d5 with SMTP id
 gs11-20020a056214226b00b0069b392394d5mr1204595qvb.52.1714531473635; 
 Tue, 30 Apr 2024 19:44:33 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:33 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>
Subject: [PATCH 063/149] board: gardena: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:50 -0600
Message-Id: <20240501024316.1767971-63-trini@konsulko.com>
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
Cc: Stefan Roese <sr@denx.de>
---
 board/gardena/smart-gateway-at91sam/board.c | 2 +-
 board/gardena/smart-gateway-at91sam/spl.c   | 2 +-
 board/gardena/smart-gateway-mt7688/board.c  | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/board/gardena/smart-gateway-at91sam/board.c b/board/gardena/smart-gateway-at91sam/board.c
index d9dfb256b32a..2b5b2844fbd2 100644
--- a/board/gardena/smart-gateway-at91sam/board.c
+++ b/board/gardena/smart-gateway-at91sam/board.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2019 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <debug_uart.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/gardena/smart-gateway-at91sam/spl.c b/board/gardena/smart-gateway-at91sam/spl.c
index 2807c4e31141..fb3ec48f9c52 100644
--- a/board/gardena/smart-gateway-at91sam/spl.c
+++ b/board/gardena/smart-gateway-at91sam/spl.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2019 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <nand.h>
 #include <spl.h>
 #include <asm/arch/at91sam9x5_matrix.h>
diff --git a/board/gardena/smart-gateway-mt7688/board.c b/board/gardena/smart-gateway-mt7688/board.c
index 0cfde91c94c6..c6b14bed41fb 100644
--- a/board/gardena/smart-gateway-mt7688/board.c
+++ b/board/gardena/smart-gateway-mt7688/board.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <env.h>
 #include <env_internal.h>
-- 
2.34.1

