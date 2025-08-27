Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A68ECA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A7CC8327A;
	Wed, 27 Aug 2025 16:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rangpwqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBFAA831BE; Wed, 27 Aug 2025 13:03:37 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDC128304F
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 13:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhimeswararao.matsa@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-246aef91e57so46567645ad.1
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 04:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756292613; x=1756897413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bkNIFhI4U6PGpvLpQLJNk9P0i1SQJRu/AHODYNBsNsM=;
 b=RangpwquLJrFKOlckLlRyfp9sMV8WZI5CMwZzX+FgWoFByiC37/NjvojOwm9p/oT7i
 2bpRVNuYXocLmgYmIuALK2J+bqqAlfR4y3hc/YfGi0vHZLW7r0nAsqA6P1HivektM++w
 RxzReCAmKGvUD7Kl7O4H1IiRZ7osR3AqhpdJwwhBnZGMpiOFvMGqoJDNqWabd3yr3yBO
 iOkYbiPj+RA0Qi33AJdToNqCQkOtEo+E7pZBA+xbdKn4p6m7+fJjgpIdHqfatSDlfMPE
 D2xGy53At9e2Sa+sj2jOet81Q8PLR2xy5ScG4U4F5akq08XIB7FU3fRo0D+kOk2+zlWP
 a1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756292613; x=1756897413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bkNIFhI4U6PGpvLpQLJNk9P0i1SQJRu/AHODYNBsNsM=;
 b=KvG7qQnNNq346Y9CbFtbTVgIrHYjCrwLEtLkIUVxDlbCojFs/dNr6e/et9+d6mz8B0
 H3s/ttILHIOz0O0XeNyb3P7xfZO7fUFboyyirKo0vMzVlRIbtP/sKyMTJTr6rqeqqqaA
 nHSU8QghjMPfUIBBIff96oMxkgpgKmvpoduZkdzglJaHCojbn30FYF1T8CdGLPPB6PCN
 6rS7KrU5rzJQ2pGVUZ0WhRU0TwhMBScnhoQhC6aUCX9vW79Ps0pel8Gz5f04etb5Tcdk
 iWPRclsJ9tSdrTnFu393mUUkND/SInlGudvbQMgSFcaJ9+21+h4XjZXX5j68nZngeUeh
 SGpQ==
X-Gm-Message-State: AOJu0YxpyS8g0Kgzjhl0SwXg//YDQoXcP/f+6On2SWXaom/yepk9eG5q
 i8CkatZbmJvPYzfqW8qnVRkre/X518vdhO031l93WBNPIZWNxY3kZky0ipsytMG8
X-Gm-Gg: ASbGncsnY6fjJAALHhKqCDYUMvoKhtg7+6/7JeC+XS11PZp6yr6UEyB32vdHf3s+jEx
 +2jR+3ZGwzi/V3i+3eSI0Vyh/OuC1sbP4jziiOhWz+LSRn0ekV96Co2FwMoOLAdHJLK0AFwLjgj
 HafoO/FU5h1XO6ob3BLywa26p8UBIL9ORaZmW8soPs+8eQUXosL/WH0dkqeLzG5+8EANOoHl5AJ
 m0Y/rOQZJbP3uJBwjaeeoAXwUbE7ZL1+P54MHE8Df1nk3zXEgYCK9M2W/DcmTWN4FpeyhryzL9o
 H3DXSsyVz2yIU2lfCa780UtyF1FfOyxZEuucScFI9mCa2dXkyuD9YKG3YGqLpIAzTkTMRrD/zEK
 It/uQuPIg4Ab9wna2c2y/CSsun+HI//w8oFFLUWTFku24Q2/O8iEQmLdeiwdLvKloTO7zcpxOVf
 J15xBZtAPIaQ==
X-Google-Smtp-Source: AGHT+IEQmLJyxuALN1edK3fdZPJD6DK8o+mTMvmX5ddAyCcdu9394xgWhxUppgtRIghaywFuHs3+Lg==
X-Received: by 2002:a17:903:32c8:b0:248:79d4:939b with SMTP id
 d9443c01a7336-24879d4978cmr62315405ad.54.1756292612804; 
 Wed, 27 Aug 2025 04:03:32 -0700 (PDT)
Received: from kumara-Inspiron-15-3530.. ([49.207.207.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24897f78580sm16110045ad.33.2025.08.27.04.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 04:03:32 -0700 (PDT)
From: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
To: u-boot@lists.denx.de
Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] i2c: davinci: prefer kernel types (u8/u32)
Date: Wed, 27 Aug 2025 16:33:23 +0530
Message-ID: <20250827110324.39396-1-bhimeswararao.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 Aug 2025 16:25:23 +0200
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

Replace uint8_t/uint32_t with u8/u32 to match U-Boot style
(checkpatch PREFER_KERNEL_TYPES). No functional change.

Signed-off-by: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
---
 drivers/i2c/davinci_i2c.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/davinci_i2c.c b/drivers/i2c/davinci_i2c.c
index 39132747208..9bba0600e3e 100644
--- a/drivers/i2c/davinci_i2c.c
+++ b/drivers/i2c/davinci_i2c.c
@@ -19,6 +19,7 @@
 #include <asm/arch/i2c_defs.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/types.h>
 #include "davinci_i2c.h"
 
 /* Information about i2c controller */
@@ -87,7 +88,7 @@ static void _flush_rx(struct i2c_regs *i2c_base)
 static uint _davinci_i2c_setspeed(struct i2c_regs *i2c_base,
 				  uint speed)
 {
-	uint32_t	div, psc;
+	u32	div, psc;
 
 	psc = 2;
 	/* SCLL + SCLH */
@@ -122,10 +123,10 @@ static void _davinci_i2c_init(struct i2c_regs *i2c_base,
 	udelay(1000);
 }
 
-static int _davinci_i2c_read(struct i2c_regs *i2c_base, uint8_t chip,
-			     uint32_t addr, int alen, uint8_t *buf, int len)
+static int _davinci_i2c_read(struct i2c_regs *i2c_base, u8 chip,
+			     u32 addr, int alen, u8 *buf, int len)
 {
-	uint32_t	tmp;
+	u32	tmp;
 	int		i;
 
 	if ((alen < 0) || (alen > 2)) {
@@ -220,10 +221,10 @@ static int _davinci_i2c_read(struct i2c_regs *i2c_base, uint8_t chip,
 	return 0;
 }
 
-static int _davinci_i2c_write(struct i2c_regs *i2c_base, uint8_t chip,
-			      uint32_t addr, int alen, uint8_t *buf, int len)
+static int _davinci_i2c_write(struct i2c_regs *i2c_base, u8 chip,
+			      u32 addr, int alen, u8 *buf, int len)
 {
-	uint32_t	tmp;
+	u32	tmp;
 	int		i;
 
 	if ((alen < 0) || (alen > 2)) {
@@ -302,7 +303,7 @@ static int _davinci_i2c_write(struct i2c_regs *i2c_base, uint8_t chip,
 	return 0;
 }
 
-static int _davinci_i2c_probe_chip(struct i2c_regs *i2c_base, uint8_t chip)
+static int _davinci_i2c_probe_chip(struct i2c_regs *i2c_base, u8 chip)
 {
 	int	rc = 1;
 
-- 
2.43.0

