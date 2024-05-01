Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE4BC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:54:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E0A788B6B;
	Wed,  1 May 2024 04:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sfj9LnI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4ACE88B3E; Wed,  1 May 2024 04:44:25 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D4C188AD7
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69b24162dd6so39901746d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531462; x=1715136262; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qu+RzvZBphRBPWW+rwNH289+LRzlg2YcQDfo69Mm/Iw=;
 b=Sfj9LnI5iFY9QBtwrszPI2OPYG8SCjP6aOG3mN5QDr7Pibd6w+uEcgeAseceoDpCJS
 nhjIHvpGesMR81tl2WInfALYhKrYmp29b8LLST1mdKegKaxf4rBIXyTeHLkPDAJRCmUO
 Crlmob9bQuGrOrvMx3U0SmJ3UCC9ziORHZ2ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531462; x=1715136262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qu+RzvZBphRBPWW+rwNH289+LRzlg2YcQDfo69Mm/Iw=;
 b=Nl9rc7fAM7InO9X8NyhArI/9tZw3KV8hpYxGgBhsRIDQWxY+uN94YLJRbOdGoDHOfk
 0Lw7lz+6OFbhHeZbtzllOMD3FzKbiwxuCM+iXHWXiytffP1O0uzwIkWkL6AuWEEqHBCu
 tYOfPtUb+nsGCfGYdRomOgdJ3v+7feIrGn+OHVc1raRmrh4Tr+N/uBxSGPxEgWE2cVRx
 x51dqVIoor+b20UwR1PF3pSsPdRYC1Z1e1dJds4xcqK4dFOU7h+28bYPp4dz2P1OOZ12
 UjeaPw3btmR+Zc99YbfAsE5MzNe1EX0pUH31oArAoXbwBE16sy5oMlcG+8noY9HjUVTK
 whjg==
X-Gm-Message-State: AOJu0Yy/iKVvv6WCEW+ZRfCea8dJH2gue/z5RIxuwv7aZFqheR3VRr8k
 o+IBqGQgsIJaANIi5WOA3b9unNUtK88SGM+eeHHbFzw2eMJgeyslIk4ej4PcSQCqLSZV2m1EmbR
 5FmNIcw==
X-Google-Smtp-Source: AGHT+IF75Jq0KZpxWGURn2VGSoQ0qspr3yc23p78ToC3oKGJYA8JQ2X84+qQU1842wVPyJzheZPELA==
X-Received: by 2002:a05:6214:248f:b0:6a0:6676:f1c8 with SMTP id
 gi15-20020a056214248f00b006a06676f1c8mr1286648qvb.59.1714531462130; 
 Tue, 30 Apr 2024 19:44:22 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Otavio Salvador <otavio@ossystems.com.br>
Subject: [PATCH 055/149] board: elgin: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:42 -0600
Message-Id: <20240501024316.1767971-55-trini@konsulko.com>
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
Cc: Otavio Salvador <otavio@ossystems.com.br>
---
 board/elgin/elgin_rv1108/elgin_rv1108.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/elgin/elgin_rv1108/elgin_rv1108.c b/board/elgin/elgin_rv1108/elgin_rv1108.c
index 10398e7f7126..9fea4f86d5aa 100644
--- a/board/elgin/elgin_rv1108/elgin_rv1108.c
+++ b/board/elgin/elgin_rv1108/elgin_rv1108.c
@@ -4,7 +4,6 @@
  * Authors: Andy Yan <andy.yan@rock-chips.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-- 
2.34.1

