Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5678C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:04:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A78288C54;
	Wed,  1 May 2024 04:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oZrdd+f9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88C8D88C6B; Wed,  1 May 2024 04:45:26 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DEDD88BE5
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-479f2922db0so1894852137.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531523; x=1715136323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TjNDKn29xPvdNlbykkgjHB4DZ07jESo2+Pa2MxtToRA=;
 b=oZrdd+f94bIew1FZu0cypLuPd1bNPEJ09InJEEwRj3vEm1WilAHNiD0b0IIma8Vrv7
 QRukSCxtTOtD4qGevDLH4TtcUa0vW3c1QwJteMZLuemcDbuwr+UlJQYc90VI5QqSyrkC
 ifM4coRUAf4OyiNtiMMBvAOV3RkirqmmbqpRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531523; x=1715136323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TjNDKn29xPvdNlbykkgjHB4DZ07jESo2+Pa2MxtToRA=;
 b=OPflsBPPebrUzRm91GHhJx+kWpgNg6qlFIRckBPznElGRJS6+hE9nngWtsxUs+sTYw
 QWh20018Hs0HFjIeWvme857jTRBC7+k7XqAhR3DYdIlRhFvFBNhFL3wMQ0Ft9LGbL73g
 OCWHaGC/+TAMeH5UxYm1F8hrrDJ4vMjDrkGjmiYr/WBAGpT/IhH3O59hCP/plzIusg0O
 ArNi2pU0VyNUhN73Z1VxQ2dxgQqSkqTWKPG8qGDW7d5pncheqQ3R3Fxz7rB9wov4AbVW
 U6QeUMUTnS7N7zdjxEuciX90lhIRzeNq5VgWGs2c1cxKfj2lLQLvCQX2evaIQGOiL6ut
 /zsg==
X-Gm-Message-State: AOJu0YzFCqDhVVpN78/5rRn8yfmwb0s9bpbChT+H6TB09ii1TpS7Fulv
 oecJSikIWelra84wXEfZyXWw5VJ2PcXws+OvgcVamNd+UtCitzheIVWNPFNDik97ZboXr2mlFXt
 /lIIiMao6
X-Google-Smtp-Source: AGHT+IEs9vU6xaD+9r6BZ6z+1ZMWddbYoriehndea7KJe9TJFwQeG9fix3v3k6yuQfW4bh1sl+Mtzw==
X-Received: by 2002:a05:6102:5f53:b0:47c:2013:9d3e with SMTP id
 il19-20020a0561025f5300b0047c20139d3emr1237274vsb.10.1714531523041; 
 Tue, 30 Apr 2024 19:45:23 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Luka Perkov <luka@openwrt.org>
Subject: [PATCH 109/149] board: raidsonic: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:36 -0600
Message-Id: <20240501024316.1767971-109-trini@konsulko.com>
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
Cc: Luka Perkov <luka@openwrt.org>
---
 board/raidsonic/ib62x0/ib62x0.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/raidsonic/ib62x0/ib62x0.c b/board/raidsonic/ib62x0/ib62x0.c
index f9bc07649e0a..8d1d549a217c 100644
--- a/board/raidsonic/ib62x0/ib62x0.c
+++ b/board/raidsonic/ib62x0/ib62x0.c
@@ -6,7 +6,6 @@
  * Simon Baatz <gmbnomis@gmail.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <asm/global_data.h>
-- 
2.34.1

