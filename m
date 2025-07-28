Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D94AC87FCE
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 01:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B495583013;
	Mon, 28 Jul 2025 03:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VwFq1JRb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F51583045; Mon, 28 Jul 2025 03:05:47 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA0C482E26
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 03:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2403ceef461so1023065ad.3
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 18:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753664743; x=1754269543; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ttQCb5nIIM5kdNmxD0KgxK2nkXEp3s4dE2YUbq+wHvw=;
 b=VwFq1JRbbaIf794IHNyIA+yEL+6NRG0DaZjIx+LLy7y98JJsjUbW+FjaTmqjWeKyqj
 oCUhDXrHkjR+m1yWitJQPOxIXrxUtugHVqGIZM+tfHVynbVHDjQKY5ehAj/tBSYHA4hU
 pTdELQWeGM9ACUyP5UNNTeoA+/b41hjAroY/jReF7FY1ZXlXFGMcqVmv5jWnZtYwyx4i
 6mFI+OFbBD3Cf+Vn7pn1zyYchZKlzyleZRH7QBayf3uZ6T2uVqP4C99RIHnBqh7Ehnda
 JzWSSdymDK1RDQoibJYXYCVhzh+WczA+Hkrs21iHmUl8VXTRS7X9fha2e3IxF8UJO3bU
 lsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753664743; x=1754269543;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ttQCb5nIIM5kdNmxD0KgxK2nkXEp3s4dE2YUbq+wHvw=;
 b=SDefvWArC5My6yhY6DDBF+J1TT6ieoVHOPyQFNWjyRkGhQE1rEFbh0bJ2WB2FZ6BzE
 Skhd3/8ugL61R1BZLA4wqfhelDCGgw2zQl2ZLBfZxEOMcJfVXOCiOc+pDZwWOQgxdbg6
 9uuvZ0HTDxzoYZaPBhh8pN/M9em2tlfVsjmzYF5L24uDbnJYvVsDyHICUGHskk60wAa2
 jmIonMcbaSgZunL3OwpyxsZNA/pqS1LotddkXY2n9vLsUUmms87k/1PMspIwrWlBggWn
 42O19+zvtpq7vhehs7+3ijWzDh/812MGKqesQ2xU5MfLQs/JVWZqOsRJ8C4l5T2CjVqc
 lADA==
X-Gm-Message-State: AOJu0YxMJ9LlJRHzkeXWbCCFmVBC2UV2FKbhyxJxvskeS//xmm7wRh0J
 mmeJtVAU5EWx/hC/lPar0ehL6czLCE3BD6m/afbLUpsotYrM6DkADR0g03zJ3g==
X-Gm-Gg: ASbGncvNwBbSo0Uym4l7q8k5fJeynBya6kyCb2Bj12bqZFNUzr4jo5sPxekANkfcTvt
 N2gxOIvVuLJkoW52QZf4tMlwz3Iq40QLsuGpWtySmhHUFKQKaSGGBwL5MTX9SyKxHpeJ8+rhzDu
 CaCccvtFLs35EgvKK5ZIcckypumb/YqTrIWCtGdVKAcydglLgzIXbq0h7eTiZCh0hv+q/OHn9EM
 iR7wTbJS2W/YFme+IhX+Gkx5/KrTrwdf18I0F5CIJVp7g6IMIZgqy8u5xuJgVPDMJgUyaYXtDVy
 a3Tl6iuZjDrZAo+Fa32VYbDPP1bO+qNXr1NdZpczIk/b+enpXMmto3ok/qx9rELchzSHiVe9lyd
 LPqgdsCz+tdrTVQAxIjxWujVujIBdR9XT5NAgOXTE2+Mh3r2D3avWtHehrlHI1dCA9ReOaKXLPC
 6nAKUk3fMJyC1zOEI=
X-Google-Smtp-Source: AGHT+IFMa9snuJPELzK9B/wgW/xHnVJdwBd7WoDBBbM4etz1Ol17BaVveDjHpcEOFyLuBpQoAsOUDg==
X-Received: by 2002:a17:902:f606:b0:240:aa0:1584 with SMTP id
 d9443c01a7336-2400aa017b2mr51232215ad.38.1753664743279; 
 Sun, 27 Jul 2025 18:05:43 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe545087sm41039695ad.178.2025.07.27.18.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 18:05:42 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
Subject: [PATCH] mtd: spi-nor: Fix return value of s25_s28_mdp_read()
Date: Mon, 28 Jul 2025 10:04:46 +0900
Message-Id: <20250728010446.29087-1-Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

s25_s28_mdp_ready() returns 1 when spansion_sr_ready() returns negative
value (error code). Fix this problem by following Linux implementation.

Fixes: 1c3dd193b5b ("mtd: spi-nor-core: Add fixups for Cypress s25hl-t/s25hs-t")
Reported-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 655bf3aaf81..76c33b24368 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -3784,8 +3784,10 @@ static int s25_s28_mdp_ready(struct spi_nor *nor)
 
 	for (addr = 0; addr < nor->mtd.size; addr += SZ_128M) {
 		ret = spansion_sr_ready(nor, addr, nor->rdsr_dummy);
-		if (!ret)
+		if (ret < 0)
 			return ret;
+		else if (ret == 0)
+			return 0;
 	}
 
 	return 1;
-- 
2.34.1

