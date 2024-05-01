Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E8DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9948F88AAE;
	Wed,  1 May 2024 04:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KuBp2fXP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F82988A99; Wed,  1 May 2024 04:43:34 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBCC88A92
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-437610adf96so43453261cf.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531411; x=1715136211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MIgImzqYviUc5BCzMnN9h0UK4ocVvSr4U1unut/a+JU=;
 b=KuBp2fXPMzrq3XE6waUW/MQDDRtsQelDCaczg8O8fsMzRikEl+SKkJwjtu5uOU6gr1
 X6G3b7SKVeALJEy0VxUYf4aZzO0lADPUBbVzYYmhVRufLsEaPI/f7Iq9uQVEqrV57xQB
 XiPf156TPlURIMz3LhC8xQLspFkman0fEgDyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531411; x=1715136211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MIgImzqYviUc5BCzMnN9h0UK4ocVvSr4U1unut/a+JU=;
 b=mXH3gK46bOXacYJj+hyMPaP4T1mt/P1BRZR0P+nTTcQJ0OYZMABkPHf6BoDzh1XUfn
 PvFOiAzkLNPjhGT8wWTHpChCdhFphLTO9gZ6umIFSaoUTWF7ZfSj60A+3h9JlLiGObqH
 lTQVeDGiMioXgCP26dSER1SShZ2RV/VgsmEXxpg2akbOlhxFjq6wRn2Qd9kNiFWbPaUQ
 Wd+APW5GJN1K7c8KgRMk4LmD6ShgpKVpAf+lByS4GKCFmjUmWbMlR8r6HBf7D6tUDceF
 /NbfkXFcFPJZ8iJd2Q6uXDeZOdiU3rC0ZtQMsXklgr1Dus5pl1n1Zp5TlrNQJ/87xHQc
 F8zA==
X-Gm-Message-State: AOJu0YxSUMrowKVlwljnIABTGTGMfk/bsu3v1ZRUA04Z/mrfK8NrUlHw
 gNa3qYI/j1MsDoCPp3JGJTt8FGvtK46L+ThvWZf3ZWJDIerrZZ5xUXvn+OjwJ78jJ9GWYYE1XWW
 mQ7a2ow==
X-Google-Smtp-Source: AGHT+IG22w/TuIvxAIo1egSZx3T34IjcDjJyuXafFlAjSlaVicfe6x7aVkiGAHB3OHdOcvTz4SIZww==
X-Received: by 2002:ad4:4eeb:0:b0:6a0:991b:cea1 with SMTP id
 dv11-20020ad44eeb000000b006a0991bcea1mr1580406qvb.5.1714531410997; 
 Tue, 30 Apr 2024 19:43:30 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Walter Schweizer <swwa@users.sourceforge.net>,
	Phil Sutter <phil@nwl.cc>
Subject: [PATCH 012/149] board: Synology: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:40:59 -0600
Message-Id: <20240501024316.1767971-12-trini@konsulko.com>
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
Cc: Walter Schweizer <swwa@users.sourceforge.net>
Cc: Phil Sutter <phil@nwl.cc>
---
 board/Synology/ds109/ds109.c    | 2 +-
 board/Synology/ds414/cmd_syno.c | 1 -
 board/Synology/ds414/ds414.c    | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/Synology/ds109/ds109.c b/board/Synology/ds109/ds109.c
index 5c3f46e23f46..4f3975781823 100644
--- a/board/Synology/ds109/ds109.c
+++ b/board/Synology/ds109/ds109.c
@@ -5,7 +5,7 @@
  * Luka Perkov <luka@openwrt.org>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <miiphy.h>
 #include <net.h>
diff --git a/board/Synology/ds414/cmd_syno.c b/board/Synology/ds414/cmd_syno.c
index a62658a2eb6b..29ea35e5e910 100644
--- a/board/Synology/ds414/cmd_syno.c
+++ b/board/Synology/ds414/cmd_syno.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2015  Phil Sutter <phil@nwl.cc>
  */
 
-#include <common.h>
 #include <command.h>
 #include <div64.h>
 #include <env.h>
diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
index abe6f9eb5e23..8db810ad3eba 100644
--- a/board/Synology/ds414/ds414.c
+++ b/board/Synology/ds414/ds414.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2015 Phil Sutter <phil@nwl.cc>
  */
 
-#include <common.h>
 #include <init.h>
 #include <miiphy.h>
 #include <asm/global_data.h>
-- 
2.34.1

