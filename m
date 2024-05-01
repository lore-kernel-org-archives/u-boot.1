Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595E6C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 564C288CEC;
	Wed,  1 May 2024 04:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hMscUnWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF5EE88C8C; Wed,  1 May 2024 04:46:01 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FCBF88771
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6a0b68733f5so28053096d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531558; x=1715136358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xpQM/e+6/kSD/wJ+ncODNYUB7WqOgt38MEYzMbR9d94=;
 b=hMscUnWIVmzBTHfNEO80TXToTIMjKRcA9miNVWXzRzF01mNuO8RdOOTvc1a38ymXXK
 j4fpSYTiPC2ufnh1JDXl605o1z8twphez/xIJUYyp4AgWR88p1XW5onhlyO6Ltjnp7JS
 n/xnYQvkD0PFIw/ZaPeDic1Rp+4AOy4rf2SFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531558; x=1715136358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xpQM/e+6/kSD/wJ+ncODNYUB7WqOgt38MEYzMbR9d94=;
 b=UYWVitOeI24+VpmXc/IOmSGwTWBd2xa0kC9P2nHGF6Zi+P1KNn1Gjgjw1NwqmUGtAS
 vC/mV6FJqA1RZ1EnnjT8FnV0wCamLANpku7X2Q2caOEwuQ05xktMJaf/DeL0kyMhTT2d
 xlFOMPZN6BngM9pirGbDWThxsqwP07LdkuSQHlrW1miaGGRdK5R2JxnQppKFb+XXgXRm
 tFJwXzlkLCIMXPGPUvZaXHH7xQuV97ddhoXg5wJcMExOVL0DP59ycNAFee9fo+iyDLr3
 Vr81G8BqNcumXaQkkAWtRFHZXIUGQiroq9cicNWjImVDO4mGyUmRQLklO8aKYhnbBJyM
 JITQ==
X-Gm-Message-State: AOJu0YzQI4X8yDNaEZe0yyISGnvvPZPDIIsqw9VqK3y3Rlb0c6KtqZPR
 UcmGZwbKD8DzblqjgaOR9R2ZqPRWB9QFi4KgFk8VLZ5f3EApN1n12zHQNS2JsVAJGdkdU6Fope5
 pflZx+ikl
X-Google-Smtp-Source: AGHT+IFyqYSypCAcy/1Qk8SbgR0kSiZLKy63+f3yfGDQ7jZURI933hJnz/fhr3N8iIW+auRcWTP/oA==
X-Received: by 2002:a05:6214:e65:b0:696:a202:5f53 with SMTP id
 jz5-20020a0562140e6500b00696a2025f53mr1107838qvb.49.1714531558402; 
 Tue, 30 Apr 2024 19:45:58 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Breno Lima <breno.lima@nxp.com>,
 Francesco Montefoschi <francesco.montefoschi@udoo.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 141/149] board: udoo: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 20:43:08 -0600
Message-Id: <20240501024316.1767971-141-trini@konsulko.com>
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
Cc: Breno Lima <breno.lima@nxp.com>
Cc: Francesco Montefoschi <francesco.montefoschi@udoo.org>
Cc: Fabio Estevam <festevam@gmail.com>
---
 board/udoo/neo/neo.c  | 1 -
 board/udoo/udoo_spl.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/udoo/neo/neo.c b/board/udoo/neo/neo.c
index d99d93b44ae5..b435b721e53c 100644
--- a/board/udoo/neo/neo.c
+++ b/board/udoo/neo/neo.c
@@ -29,7 +29,6 @@
 #include <spl.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
-#include <common.h>
 #include <i2c.h>
 #include <power/pmic.h>
 #include <power/pfuze3000_pmic.h>
diff --git a/board/udoo/udoo_spl.c b/board/udoo/udoo_spl.c
index 647380e1db63..6c477530055c 100644
--- a/board/udoo/udoo_spl.c
+++ b/board/udoo/udoo_spl.c
@@ -6,7 +6,6 @@
  * Based on board/wandboard/spl.c
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
-- 
2.34.1

