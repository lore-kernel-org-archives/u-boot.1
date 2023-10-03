Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67A4E75433
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 08:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC1587222;
	Tue,  3 Oct 2023 10:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="STRCIWVa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EEA87222; Tue,  3 Oct 2023 10:41:17 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC8787201
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-69101d33315so512434b3a.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696322470; x=1696927270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1sjwdXifx+JA/aXFP7BCpMbSPUFbAJgcSPgBTpX/Eyk=;
 b=STRCIWVapmUvbYGs51MKsODiE141Oo1x1yr3MP20+iyZJTveKTTILq+TKBbmNoBvT1
 2aOKI1cbNNkg9Acsp4UrD7Ny0ZUd8Xky69YDMCQfnPb8jxaQCkXgmyCHm9D8P3247mbE
 I4Hd3xo1yJWY9jFmMk1erofLcWwLcLeZBYHXM9MYvWSiHJmCGZn4JcAurcKUtXp9CYNs
 kxUT8nWeaPBrO8BmLVXiC0lwXduM5WfGFdWbty+jkqHUL9WDeMm5ZgZlKUlerzQRMujH
 Atsp7cUi3pOivUjXjEaHRHkm9tXldTOdocuGHaVqEmmzuru/p2bhdbv9cWJ5z9Tjr5t6
 Qx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696322470; x=1696927270;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1sjwdXifx+JA/aXFP7BCpMbSPUFbAJgcSPgBTpX/Eyk=;
 b=vw7aKL/LJ1QMvW0rn0aixVbVH2fqLbQaoYK99ln66ePBlwRduZaBTxd25CpDH3Cniv
 Dh4C2ym9LTf7HQ/IJnuKMwRCNHNKO0pxYwq66lB9v6p7HHwGa24C7L6CoU5GZ5ibp2hs
 QF86pBIKPJahdTY1eejJBSyi1MPH4+yIYW8kJOKf6oFdxlbUaBjNKSznq9AqBY+AxIwM
 TSCb9x4mnRqVA6hAzpWVRPbtZ66OChgnbNvX8N+PJFMVSHqc1LKjZyiJOPDnFZpTe7i7
 cGABZCHOmnS3d6jl3VRSTCU53L4DaX1a13kLL7FGhKT4IK5mLWIjpuHZ/6Rl353GZpX9
 Ihgg==
X-Gm-Message-State: AOJu0YwiF4FBkvi6eaGg0m+8AVyuj9X/Es5NAuh/uGWo5zOajSi+sZPU
 5P5rg8ILwGHS4OZO7ViBSAQ=
X-Google-Smtp-Source: AGHT+IEV4wkv8aWVLHtqV2zJmBG2ESFExbV/x0jws/iGPPWTLxF6+wDZW5nUGIBMn5M/Cy4YCjfEVQ==
X-Received: by 2002:a05:6a20:5509:b0:14b:f9b2:eb7 with SMTP id
 ko9-20020a056a20550900b0014bf9b20eb7mr10158992pzb.59.1696322469646; 
 Tue, 03 Oct 2023 01:41:09 -0700 (PDT)
Received: from cs20-buildserver.lan ([2403:c300:d608:e3a4:b564:cfec:3897:9e1b])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a170902e55100b001c625acfed0sm907689plf.44.2023.10.03.01.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:41:09 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: sr@denx.de, trini@konsulko.com, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
 JJLIU0@nuvoton.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2] wdt: nuvoton: fix reset/expire function error
Date: Tue,  3 Oct 2023 16:40:58 +0800
Message-Id: <20231003084058.2656171-1-JJLIU0@nuvoton.com>
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

fix npcm845 watchdog halt for reset function and expire function.
reset function is restart wdt.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - add commit message
   - fix no empty line problem
   - remove dts
---
 drivers/watchdog/npcm_wdt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index e56aa0ebe1..22d7fc45dd 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -70,14 +70,21 @@ static int npcm_wdt_reset(struct udevice *dev)
 {
 	struct npcm_wdt_priv *priv = dev_get_priv(dev);
 
-	writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
+	u32 val;
+
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

