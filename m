Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914D5C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AE5A88B4A;
	Wed,  1 May 2024 04:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m2LaWr+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB0B088B67; Wed,  1 May 2024 04:44:24 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8521388B4A
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6a077a861e7so40173216d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531461; x=1715136261; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V2radydmRWMzt0/+WIOpwsKwg85uZzWjCs/Kgny0hP0=;
 b=m2LaWr+Suvb1RUrf4d2dbpFOmnRhQSVhUiJRqesS3/z/mrATaBuOiqZbU1Aj5909Hm
 pP32KZqy3NEsCjR7CArkF54o6axToBeW3THG5w2ax63v0wTa0sHHTE+WwAwizh3/eItA
 h67h0Kfe8x19qaHmClpKDvTTFoYjFViyhWNns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531461; x=1715136261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V2radydmRWMzt0/+WIOpwsKwg85uZzWjCs/Kgny0hP0=;
 b=ieFDI3f3ACkKPCiKTVizhlUIjWCymTZlsCQ+BK/eZOg++op8k98YroS2MGVnvRlKpl
 6iSlCTWrXHSuQ96zCTfqmVo0ey+CSjmXJbl0wuUeo4ZXJhhlraMQ+tnR4wgdjpFySsh3
 LhMLLraOlE9pDm/4ainQbGVyrnAmVh6++AbfmmDVE1AOYLT5pFStaunIurDumfL+XOb6
 NNZgLLVe9I15zRLwB/C4j3kcXVW/Vdzaz5uwWZ1KLLCHDVvw3Qizjj+t9/QVyX6xwVGR
 lNO3DP0JSIWqn0PEYXN5D/CXZaOAtHtOwKU2VxFzjJ8VMJQppaS6uULpBBG8H/F1iDXx
 q8pA==
X-Gm-Message-State: AOJu0YzUpNzIersj8jefirSpAnW8Bav7uLlF7J9d+5J53Gs3yYyuAh1e
 kiQkb7EIDIsg8VsP3wLRZOs5GTOUVLdbOE+esdyzq01Bmmt/sbyTcih92K3l+0lXFBqVyvoiAsL
 CjPtBuw==
X-Google-Smtp-Source: AGHT+IGL225512OO69GjIDYq9OGLoTTgXpKnXdc82rF+omc/qdBACTWPVB+xxIAu5Ub3N7e6cynxaA==
X-Received: by 2002:a05:6214:240b:b0:6a0:b905:97ba with SMTP id
 fv11-20020a056214240b00b006a0b90597bamr1280116qvb.44.1714531461183; 
 Tue, 30 Apr 2024 19:44:21 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: egnite GmbH <info@egnite.de>
Subject: [PATCH 054/149] board: egnite: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:41 -0600
Message-Id: <20240501024316.1767971-54-trini@konsulko.com>
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
Cc: egnite GmbH <info@egnite.de>
---
 board/egnite/ethernut5/ethernut5.c        | 2 +-
 board/egnite/ethernut5/ethernut5_pwrman.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/egnite/ethernut5/ethernut5.c b/board/egnite/ethernut5/ethernut5.c
index 9953df017e19..64e341c3779c 100644
--- a/board/egnite/ethernut5/ethernut5.c
+++ b/board/egnite/ethernut5/ethernut5.c
@@ -52,7 +52,7 @@
  * http://www.ethernut.de/
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <net.h>
 #include <netdev.h>
diff --git a/board/egnite/ethernut5/ethernut5_pwrman.c b/board/egnite/ethernut5/ethernut5_pwrman.c
index 81f1abf2fad9..42e1914a8759 100644
--- a/board/egnite/ethernut5/ethernut5_pwrman.c
+++ b/board/egnite/ethernut5/ethernut5_pwrman.c
@@ -31,8 +31,8 @@
  * For additional information visit the project home page at
  * http://www.ethernut.de/
  */
-#include <common.h>
 #include <command.h>
+#include <vsprintf.h>
 #include <asm/arch/at91sam9260.h>
 #include <asm/arch/at91_common.h>
 #include <asm/arch/gpio.h>
-- 
2.34.1

