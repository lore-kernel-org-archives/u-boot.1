Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7942CAC5A5
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 14:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88EA8334F;
	Sat, 20 Sep 2025 16:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TCFTbqta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2625983335; Sat, 20 Sep 2025 16:37:07 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA5A8317B
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 16:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ece0e4c5faso3649725f8f.1
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758379025; x=1758983825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5LaOODRJqTx16UG0jCV1Ndpk4MJFBAR1fxl1Y6fpeVY=;
 b=TCFTbqtar6ALZAUAFnfEuVKBRn9Bk8YgOxNjMTwFP7KPJoeeVGNdUMlg28lx8hJA75
 ipFzw9wzKDf6Txy+D7vtzJu41gVxKLkHkD4l9GOBgvJBvlvF8bIYjAe1juv4t0OOy9Dc
 VDMDxDdeYe8uO3PCZ2FOej0KmX1fU1UZ8Zsl2bIwRq8+3YnKvlL07WOneCGXligge1ZV
 rrIeQvQ/v8+zNHuzkva87TZ2nbywdEi5h0hD6oT6UM5Xhziwh0IyDg3X9cOJBDUkGv2E
 uUiStmQrK56a/NPkL+r/Mq8Pwtlgcj7NqmiXeRc0GXJxNOxwI/orbkJbk5cUhWej+lPe
 7G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758379025; x=1758983825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5LaOODRJqTx16UG0jCV1Ndpk4MJFBAR1fxl1Y6fpeVY=;
 b=wgf+iRiaJnuDCPdaxJqNP/7WtpA2Kq62HC7aBOCHnqZVfT+ct/9+bCGyLX/LiKLTrm
 OBuoGAX2vkyC0r2ax3B58opjtzRfQvpNabh/mXfDzqKvWx2ebZ6pOePlmSc9vF3kUX1U
 cLV7S2nrUJrJLIuu2Bg5wJvA73tklsbpT1YaWAw0Jrp6HYfZhhxSa0AvcUhJwmPiViX0
 4GR5RdMA2i4EFlg0LEQ04xrDabjkEiBhWcdKrmPChRlznXMy9eXZTRM2IqaMq3TaMRfT
 x86gdlSBTd1Zl3IndVsNpKCZKHaDrZaX+gFLpQaWHoJCwxN6O2SmNm4g/qD12mZG0E0M
 tjxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRsgZfAnm0NATeBfTyrGlnQVzqY4OynqFMVlwc3eHtNk+eLo6i/ul5ngSMPN8y7/ZMQ7NK4xY=@lists.denx.de
X-Gm-Message-State: AOJu0YxahIdyAqPWNC4mw5Ux1pbFa4yEfeNc5F+qdZNb8yP3zpxgqxpp
 9ZiJxgwFbGzsXmTEEGLwa+XY7UXmc2NR48CS5MAKtJYNESfTzApb03KQ
X-Gm-Gg: ASbGncuxhbK3h28CUMpGrsea9EXXN3zTySVgd91PZDTrb8ibZz6xrBQatVjeIbzhuQI
 zXVM/M2N3IbPzPh3sMcpbjOlmvhmf8lJLE2OJXaZKiAAIV8OvrqHIiegnfYjjq2rReK/jX1VVDv
 hmfRshN4piOL2C4BUoQCm1z4CaP9cWm04za5dBjFeitUwAQTQwYdg80CVIg3gXOY7ItX95LklTK
 XYOomdxkIrN2KX34GCd9MCNj/KHxwtkyrOVH930zRpWrGDL3sVRcCAwtwz1z0uI8vqGXRfWvy21
 Pu0oyrVie3R4mpWrmXJqscT1VclxaCLf4YD0Wr/hJY2S8/lLSeljdrcj++96tMNuTwza5EVR/y6
 lh79+dJuv51rmV/AzTJjSA1Ux1yE7MkbpPMf8bYKFBVhAfRoyI25W6rY207aq405XPkWSE5Y=
X-Google-Smtp-Source: AGHT+IEzl8ni1wYWILnteu2nwG0cOmjJ7JxqARTcMBPrEoJaS2/af22Jepf++0aK2qmURG/lMkqdxg==
X-Received: by 2002:a05:6000:402b:b0:3e3:e7a0:1fec with SMTP id
 ffacd0b85a97d-3ee7ee63e17mr4938745f8f.16.1758379024604; 
 Sat, 20 Sep 2025 07:37:04 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fc00a92sm12353716f8f.63.2025.09.20.07.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 07:37:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH 1/5] net: mediatek: mt7988: fix broken phy_setting config
Date: Sat, 20 Sep 2025 16:36:46 +0200
Message-ID: <20250920143656.29770-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920143656.29770-1-ansuelsmth@gmail.com>
References: <20250920143656.29770-1-ansuelsmth@gmail.com>
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

The PHY setting for MT7988 are actually never configured for the
affected PHY as we are read/writing to the wrong PHY address.

This is caused by the fact that we use the index of the NUM_PHYS loop as
the PHY address without first offsetting it to the base address.

Correctly offset the PHY address before configuring the PHY setting.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mtk_eth/mt7988.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mtk_eth/mt7988.c b/drivers/net/mtk_eth/mt7988.c
index a416d87840c..bc58462af26 100644
--- a/drivers/net/mtk_eth/mt7988.c
+++ b/drivers/net/mtk_eth/mt7988.c
@@ -34,16 +34,18 @@ static void mt7988_phy_setting(struct mt753x_switch_priv *priv)
 	u32 i;
 
 	for (i = 0; i < MT753X_NUM_PHYS; i++) {
+		u16 addr = MT753X_PHY_ADDR(priv->phy_base, i);
+
 		/* Enable HW auto downshift */
-		mt7531_mii_write(priv, i, 0x1f, 0x1);
-		val = mt7531_mii_read(priv, i, PHY_EXT_REG_14);
+		mt7531_mii_write(priv, addr, 0x1f, 0x1);
+		val = mt7531_mii_read(priv, addr, PHY_EXT_REG_14);
 		val |= PHY_EN_DOWN_SHFIT;
-		mt7531_mii_write(priv, i, PHY_EXT_REG_14, val);
+		mt7531_mii_write(priv, addr, PHY_EXT_REG_14, val);
 
 		/* PHY link down power saving enable */
-		val = mt7531_mii_read(priv, i, PHY_EXT_REG_17);
+		val = mt7531_mii_read(priv, addr, PHY_EXT_REG_17);
 		val |= PHY_LINKDOWN_POWER_SAVING_EN;
-		mt7531_mii_write(priv, i, PHY_EXT_REG_17, val);
+		mt7531_mii_write(priv, addr, PHY_EXT_REG_17, val);
 	}
 }
 
-- 
2.51.0

