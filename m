Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F41CAC5A7
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:10:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E057C8004F;
	Sat, 20 Sep 2025 18:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Kw1f2Ftz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0BC83327; Sat, 20 Sep 2025 18:10:24 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2EBD8003E
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45f2c5ef00fso23260785e9.1
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758384622; x=1758989422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7L9njOUmsxHm9NGRDv7NAH+4+29gn1b4BwlhKJgBaJo=;
 b=Kw1f2Ftz+4Togmtm/qrmRz/8b4DlY8OUeQxhGPm9qu6xtmbyNCxP6dEvyJJzGfm7uf
 3XUAJHcP1xXt+fWhun85JR5iGTUq2Z7negSqdIREI8s2B2w7nSoNJKRFkNu1s/ZkiMhe
 FmBfsxBTvfLevva/2zX+9dwYWTNFMzubQ8OM9gHnoShbnEWEWPkPnNcxO0DVIIZpbEHe
 xtvyh3gpMgdgZkSvm3MfkFE/OF/NwDxZybPzT1LHDOGqNPAjXsSu6N2JFTFErgqurvgy
 p9yCeUEt2izOyGQqMGmYXkY+26ToMf+UYqyNU76zpnXslpLSn1pEmiJ/a0mPcz/ATpNW
 yFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758384622; x=1758989422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7L9njOUmsxHm9NGRDv7NAH+4+29gn1b4BwlhKJgBaJo=;
 b=S4Io7atcOBZXeeEfumzbgq/zXqzQXHe4RdOH4XHduMomdG5IUn5F9tgo8F/51D4Kit
 AiLUPEungKN9IetiBGO1fZgBR9rsiK3HRWgIws3TRKPsUOPAFlp3dP0aGGI2PyxHfA8b
 DolUUzgSHeD9uQNC81bYuRrfKPMnRRVHJGzEsI+Ey/9iavLSfeLSmX7ESZ7gZnyef1VU
 FcOp0jOHgF8Ndal8ncGrAlCuVLmU9QDWxKN39L93p4qQT69N9fXE5qvLrIfLBn5uQMAg
 NEWlbZDXdXAGgTyw0nrsD3rK/0GxXUB+6sYnEIqGbMRdF3TVh/lkL8JlTCe8ccX077he
 bp7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCULbqI6ZcmNdQCtlwbMPuzVOtuHcVhYG2XHikuw0Tmup8+BmwbLoCtrBz58ziqS1K6tUf9uV1c=@lists.denx.de
X-Gm-Message-State: AOJu0YwM/YLV4W0G7Nq4CrJRez3Lb01bCPHg2JAqNRExXUydpXnx4G1R
 /Vs5R1O6MTFMH9RjyxtuTyz6aiC2WyH7ODD2VUabc/b7Q7zTUGMuEcxODCz3Pg==
X-Gm-Gg: ASbGncs/5PU9UXD7AdI+EK6GRINvnSzBsCbynDBgU+9P3hcPxiWpMlNf3eBpJ9eh+xr
 BTs5WCFtGoJvrjtTSmPUZKtQMRgaKc6zhd1UiCNqJD7rQQl6hNf0GQn74yg2KEWouZJ3Usdo53c
 VwTIxSyjccB0OsGIAlRE+VctCB57s8/1/P7HuoRX37iQd6CmMWyHJWfy1uEzYzoRFs0cQpIuDG7
 kK58GNvQ3dm4Ls8/xrnXTH84v2Erf1j1nCUku2Cyh7rzqHwuj9XPIgpNZQzSlMi2R7BhS7toWBM
 x0+HGDdArt93uhMTR4yY+iCtx7j2o6lVN6Dwrawbs4h6D5PVkq2UtxFoS8PEA+KiyvZuKKxW9Tw
 nSYZsXLsiQXZQj5DXy9Jdze5I5mPnbdRKzLVp18fZvPMKGPaeaRNISl18Lg8URrzdRDbZPcg=
X-Google-Smtp-Source: AGHT+IFdvnKKd4dGvD6jQeFx6JQAQdGO6xBKs+aOagN2WLf0In8uAelsKb+mDt5A6XEeivUBug6/dQ==
X-Received: by 2002:a05:600c:1391:b0:45b:74fc:d6ec with SMTP id
 5b1f17b1804b1-467ead675c1mr71300205e9.8.1758384622371; 
 Sat, 20 Sep 2025 09:10:22 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45f325cec0fsm105878675e9.4.2025.09.20.09.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 09:10:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/5] net: mediatek: mt7988: restore PHY page on PHY setting
 exit
Date: Sat, 20 Sep 2025 18:09:42 +0200
Message-ID: <20250920161013.31799-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920161013.31799-1-ansuelsmth@gmail.com>
References: <20250920161013.31799-1-ansuelsmth@gmail.com>
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

On exiting the phy_setting function for MT7988, the PHY page is never
restored to Page 0. This can cause all kind of problem with reading the
status of the PHY at runtime.

Correctly restore PHY page on exiting the PHY setting function.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mtk_eth/mt7988.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mtk_eth/mt7988.c b/drivers/net/mtk_eth/mt7988.c
index 87b6ed30cd0..06bbe049da3 100644
--- a/drivers/net/mtk_eth/mt7988.c
+++ b/drivers/net/mtk_eth/mt7988.c
@@ -34,8 +34,10 @@ static void mt7988_phy_setting(struct mt753x_switch_priv *priv)
 	u32 i;
 
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
-		/* Enable HW auto downshift */
+		/* Set PHY to PHY page 1 */
 		mt7531_mii_write(priv, i, 0x1f, 0x1);
+
+		/* Enable HW auto downshift */
 		val = mt7531_mii_read(priv, i, PHY_EXT_REG_14);
 		val |= PHY_EN_DOWN_SHFIT;
 		mt7531_mii_write(priv, i, PHY_EXT_REG_14, val);
@@ -44,6 +46,9 @@ static void mt7988_phy_setting(struct mt753x_switch_priv *priv)
 		val = mt7531_mii_read(priv, i, PHY_EXT_REG_17);
 		val |= PHY_LINKDOWN_POWER_SAVING_EN;
 		mt7531_mii_write(priv, i, PHY_EXT_REG_17, val);
+
+		/* Restore PHY to PHY page 0 */
+		mt7531_mii_write(priv, i, 0x1f, 0x0);
 	}
 }
 
-- 
2.51.0

