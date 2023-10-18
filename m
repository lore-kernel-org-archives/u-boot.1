Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368A2CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 02:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A54286EE0;
	Wed, 18 Oct 2023 04:09:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cpGFHDIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB4F86D9C; Wed, 18 Oct 2023 04:09:12 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555A886EE0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 04:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so48001825ad.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 19:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697594948; x=1698199748; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D6whRWpO8fWuwN/uGrX/sBhN4CoXdLKWceRDVcZrSQ8=;
 b=cpGFHDIQ59VwCOSFckAqebB7WmEmosKBQXiXnGR3rk+N4OZSXGyb/3mvM71f2cNxCh
 vzCNYsd5YoS1qhoeEMeBkfUHjkABevl8o6rP0w5w3pAcqgwTuIf3+phS5GH7xrE6yoMn
 YZd0+d3OlE5MBrPk+ueW4/h7XGY7ukZNvk4QBmUGcB/sGHF60bmuE2hMp7gz18BeGmMS
 SF9+7lumjk+ZsPXloB5xA+LesV3GmNTifQT0iksFj+dxATs112nMaO6cOm38Uow0xxkK
 cGoFS7O7PT+BPZfv4gz3wT1HxUbBsUDi9O4L+CZ5Gi+aEjOvtof+jn0m8ZMW48pkvR3s
 iMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697594948; x=1698199748;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6whRWpO8fWuwN/uGrX/sBhN4CoXdLKWceRDVcZrSQ8=;
 b=vxfrWZNsK1RUt9eecQ47vv0PO8Bs75KHf/g8ZdIj6LWkKvR/NkUapQjjL3iyHYQUKS
 fu3Pa94CQ990x5N70IuFoo66GNg06nT/qa63nJ2f7bFroz4mrWVkcTSoPAKEkeUhp0N5
 pDoLd4nU1SqShgrJsT4CphJZxwgsxpj3Xystv2z/KOFmg/HpWyVH4EVkUWB+JF7EPZ4l
 NR+7KzM06AFJ8OVwWIXah5BTeuh61ESVk/CFdPYqW98/B520n3mQt8tPi7WKotas8XOE
 +6NBbJAix8Olqyhhwj1xt3+1N39WhuYiFj5spSqGS+xQumK8iwZMjC50CBUiTi25OAtB
 fwrg==
X-Gm-Message-State: AOJu0YwChAe+UwQHt+yVgrkdQY9HtT6/i2b+roGZTWTwjSqNh9sijHeh
 kg+sAyYphCGm0VWjYbGFzxA=
X-Google-Smtp-Source: AGHT+IEP6bJDGSkafYT6OvE5cBLTA76sqHtTWcIlxeVSsjk6HSfgWujcQ38tnH/z/3czO/6bBY+pxw==
X-Received: by 2002:a17:902:f542:b0:1bf:193a:70b6 with SMTP id
 h2-20020a170902f54200b001bf193a70b6mr6345468plf.5.1697594947754; 
 Tue, 17 Oct 2023 19:09:07 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a170902d30600b001bb97e51ab4sm2263138plc.98.2023.10.17.19.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 19:09:07 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: YSCHU@nuvoton.com, KWLIU@nuvoton.com, sr@denx.de, jim.t90615@gmail.com,
 JJLIU0@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v3] wdt: nuvoton: Fix reset/expire function error
Date: Wed, 18 Oct 2023 10:09:00 +0800
Message-Id: <20231018020900.189021-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
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

Fix npcm845 watchdog halt for reset function and expire function.
Reset function is restart wdt.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v3:
   - Modify start sentences
   - Remove empty line
Changes for v2:
   - Add commit message
   - Fix no empty line problem
   - Remove dts
---
 drivers/watchdog/npcm_wdt.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index e56aa0ebe1..57b61215a2 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -69,15 +69,21 @@ static int npcm_wdt_stop(struct udevice *dev)
 static int npcm_wdt_reset(struct udevice *dev)
 {
 	struct npcm_wdt_priv *priv = dev_get_priv(dev);
+	u32 val;
 
-	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
+	val = readl(priv->regs);
+	writel(val | NPCM_WTR, priv->regs);
 
 	return 0;
 }
 
 static int npcm_wdt_expire_now(struct udevice *dev, ulong flags)
 {
-	return npcm_wdt_reset(dev);
+	struct npcm_wdt_priv *priv = dev_get_priv(dev);
+
+	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
+
+	return 0;
 }
 
 static int npcm_wdt_of_to_plat(struct udevice *dev)
-- 
2.25.1

