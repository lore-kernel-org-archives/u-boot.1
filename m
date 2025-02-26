Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D41C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6F480FE2;
	Wed, 26 Feb 2025 12:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lersz09F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9CA80FEC; Wed, 26 Feb 2025 12:54:19 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 237C4810F4
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e0573a84fcso9177948a12.2
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570855; x=1741175655; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x96sgKatvojHJEM7nHujMdZr78XoZX+iT6JKa35UhE0=;
 b=lersz09FP1gf7DIOD9gEF7zakUiq7xVFd3SzfFFmQdh8noyWtNbJLUsrXfKEtESA/D
 Yx8a7Zkc+7eas2ud5xPiiJkpTjF3WY36eBkLvFq91tU2bQntKFlM0VoziDQ5u1mlJ2Uc
 7S1tHt8BFTw/D2LpEW9a+CLa69j1068e2fSIuEFbq1r5bJmrwgwpwxFE5OzJybBCgXwq
 ULNXPGTilubgaBcnIdgaCgHbsHKh+1OiHLOZGJ7gveuFUamh2jqdvwZic05gVL+50u5u
 IurMRxm5fc8aHxkzGgYe7AKqLT1IDnto38lUSh6iPIXdBT9YzCt5NZDce5tlfXWMf9IC
 WPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570855; x=1741175655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x96sgKatvojHJEM7nHujMdZr78XoZX+iT6JKa35UhE0=;
 b=QCcf9iIdigRtbBU4B7YRavc1OKrXoEXq1Kc/+I+bgPVCVPiNjDNLcWgBj4LLWnkUnh
 94OQUFGd8a9Hbjp5GQRUk2FedzjFb+BDPJTrg//cD9Vd0VRzdZlZ/oPnOU5rTIVFIuZc
 NS7k5x8/LOYEB4w+WTo95YvFq0Fcyz9xMf7226TfsVI3FBH5xVWKwKUTs3UzLG7tmVio
 N75Yiz5nWMq6aEbasXe4XL22iw9B+Y5MuEGA/JWjnr2ihKN2dNnDAfH6I3BT2SOaetBb
 nLlNxtnUXnczUy8R3Qn7l1DUSmqcAtdBwVXzmeolNzWbMoLoTKwq+1HgvMJwYXGTIXeQ
 21AQ==
X-Gm-Message-State: AOJu0Ywdau9qvLPjHR+P+qeLUh5UPCul02YZLFZNtRtzGmzQP2JwmIi+
 OkkgxnZCaPGrZCJDV6mW3pgO5YZz10/Jt1F/dDyVJAPXD4uHLK2z
X-Gm-Gg: ASbGncs0xZzgbz27jEWUsRaN0tBRhginwvQ1ZBiM9kxQfM3iUFo+mOymhDxJPY3mdXf
 9iqAFaKFJgFepo9aHalvWgKsjzW/7l0FstTBRnRalvlNmArS/QZups4nRKcT1MrOtIN2qPrLi0U
 Pmmia461Pjvstg4pw71aq1qP5S9tpafmwg1iospUFW1P2hhmSNYkgrZQc5lDEBhbRG/8NPabYty
 KtZtJRRFFloC7nGgbKqYXSese407NbLd+6gKWGI/vwW6QnvBvSGF5xTpE+NWva8FbiQ7C+hO/9v
 Ar+c1g9qwt2it/v6MQ==
X-Google-Smtp-Source: AGHT+IHMGC5BOyknupMOI1ine9h+B8ET0wHy4LuH4ilswo+X2zgPt0DS5/VOtayYQ21XhgaRiL5p0A==
X-Received: by 2002:a17:906:3152:b0:ab7:d87f:665b with SMTP id
 a640c23a62f3a-abc0de4a2cemr1964304666b.48.1740570855458; 
 Wed, 26 Feb 2025 03:54:15 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:15 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 08/12] video: tegra20: dsi: make SOL delay calculation mode
 independent
Date: Wed, 26 Feb 2025 13:53:34 +0200
Message-ID: <20250226115338.42832-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115338.42832-1-clamor95@gmail.com>
References: <20250226115338.42832-1-clamor95@gmail.com>
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

Move SOL delay calculation outside of video mode conditions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 47 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index dd091c15ca1..e1502d8d60e 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -712,9 +712,6 @@ static void tegra_dsi_configure(struct udevice *dev,
 		writel(hact << 16 | hbp, &len->dsi_pkt_len_2_3);
 		writel(hfp, &len->dsi_pkt_len_4_5);
 		writel(0x0f0f << 16, &len->dsi_pkt_len_6_7);
-
-		/* set SOL delay (for non-burst mode only) */
-		writel(8 * mul / div, &misc->dsi_sol_delay);
 	} else {
 		if (priv->master || priv->slave) {
 			/*
@@ -734,31 +731,31 @@ static void tegra_dsi_configure(struct udevice *dev,
 		value = MIPI_DCS_WRITE_MEMORY_START << 8 |
 			MIPI_DCS_WRITE_MEMORY_CONTINUE;
 		writel(value, &len->dsi_dcs_cmds);
+	}
 
-		/* set SOL delay */
-		if (priv->master || priv->slave) {
-			unsigned long delay, bclk, bclk_ganged;
-			unsigned int lanes = device->lanes;
-			unsigned long htotal = timing->hactive.typ + timing->hfront_porch.typ +
-					       timing->hback_porch.typ + timing->hsync_len.typ;
-
-			/* SOL to valid, valid to FIFO and FIFO write delay */
-			delay = 4 + 4 + 2;
-			delay = DIV_ROUND_UP(delay * mul, div * lanes);
-			/* FIFO read delay */
-			delay = delay + 6;
-
-			bclk = DIV_ROUND_UP(htotal * mul, div * lanes);
-			bclk_ganged = DIV_ROUND_UP(bclk * lanes / 2, lanes);
-			value = bclk - bclk_ganged + delay + 20;
-		} else {
-			/* TODO: revisit for non-ganged mode */
-			value = 8 * mul / div;
-		}
-
-		writel(value, &misc->dsi_sol_delay);
+	/* set SOL delay */
+	if (priv->master || priv->slave) {
+		unsigned long delay, bclk, bclk_ganged;
+		unsigned int lanes = device->lanes;
+		unsigned long htotal = timing->hactive.typ + timing->hfront_porch.typ +
+				       timing->hback_porch.typ + timing->hsync_len.typ;
+
+		/* SOL to valid, valid to FIFO and FIFO write delay */
+		delay = 4 + 4 + 2;
+		delay = DIV_ROUND_UP(delay * mul, div * lanes);
+		/* FIFO read delay */
+		delay = delay + 6;
+
+		bclk = DIV_ROUND_UP(htotal * mul, div * lanes);
+		bclk_ganged = DIV_ROUND_UP(bclk * lanes / 2, lanes);
+		value = bclk - bclk_ganged + delay + 20;
+	} else {
+		/* set SOL delay (for non-burst mode only) */
+		value = 8 * mul / div;
 	}
 
+	writel(value, &misc->dsi_sol_delay);
+
 	if (priv->slave) {
 		tegra_dsi_configure(priv->slave, mode_flags);
 		/*
-- 
2.43.0

