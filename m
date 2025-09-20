Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C23FCAC5A5
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 16:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8118340C;
	Sat, 20 Sep 2025 18:10:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GcND70t2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 028CC833E9; Sat, 20 Sep 2025 18:10:26 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1197A83335
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 18:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45decc9e83eso30905295e9.3
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758384623; x=1758989423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1627wziuut/QBMKwokWChBJZPJlHKysuhDms1cLBnkI=;
 b=GcND70t2qCstNyJBSig+sopght4k/H7a/DN+2lLZjK8buvqUpq+v7HbP1InTpHZhqm
 H6MR/tMUvHurvGFCPJJeGxRx8GFekF/nxpZZpenGpz8C2f+dHucHU2tAHjd9skjlNMeb
 pmBV3pMt/6a6m3xf0lJEotkp2urH9sHBiXiUEMO/qN0o1BMAn4/V8ieByVW7UgWnprr5
 AwbW3kFZp2e9PSKvZQitUzugJWUmT0k9Q7bh5icqDzdrpVvipi/69xTp3oRAuPD5n2Sy
 OVmQLfYN7Jt2OYlspQrMvhxl23kMBcaBtq8nybDvXkL2ogemjcpfQlD6v9zgGtM2z5dj
 qxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758384623; x=1758989423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1627wziuut/QBMKwokWChBJZPJlHKysuhDms1cLBnkI=;
 b=OjlsX82oC+UX4YvEqKAjxW+8uN5dJC3X9ECNaBXXKZzgE3VO38Pv+/NF8sP1oshwQK
 bvh4sIYkvAJ2pWDlRRhrHVCJ3fKGLAeY1x9d2n6Ooy53uT4uv23tRFq+WGDHULwfaxGK
 dEcukctb1bYYUE0FHbhr7G6n9aADtIaMF7I47cBteXq61H2AuzYLTY25pNcTZdIaPFvP
 t5tfRPQATGhqCkTgpOz5TWVjf0wzJLwvnYnBCQSL8MQH684FwixK2BcsFK5ETi0UUgkW
 mj5Rp/Iu6ifT8bCYb/7uAkiDmrn0gkA5JBvvNMRGPy9m2IX13kS02foUhSqDBBw4BfDG
 wLUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl2O3jfuhlUBmzHC+JkwH3VNxoDY7dFo2ua7OmxSfxDpLd3HxlVLArvIRgGibU63Iz8VED2lQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy9h/tO6ectaqQe59KA6pOEMgAYtZoOsb2fB61fMnPA0plu+fEI
 SCDfARz+1gI3ug5gOaPD1xk8shu3Dds9zOSDkayL8otNd4wG5CAnPAu9
X-Gm-Gg: ASbGncvWzoJ+OP31wAPgW5Si3/rw9N0VXHMxK22kMZDFpL6QlXcorVGJdka8k+gokb1
 udWyEXqwvxv/CaLObizLRyHdpj5EQkalunYqRf6Cq3HT/ag15ICnS3P9Bm+SRdM8fJ72I76IBYi
 QnQyHCkWostU4PHdGlUwG2v0WSl4PFPvL1yBORx8yceFEbveota/YgXOJR1kgsp+ji9U+uSPwk+
 upGtazajygv0eBuftTY7HYayWFDsH75kXuNZ2/QgPySuC5U2QU4nWkKWL+PQ0CbkSXTfKvmyDsH
 wuTDNDT8o051O6IGu4CB34JiWjP/KccX/r3DbNKUDV4n6RU4tc+d10PZn+0BZ4QpMTPnFuRE3qs
 tlD3lJOKhRyJwag9g+nofM68Xit2CO3lOvZK8vezCUplbn+NH7Mfh5LyVU4kh6jXGRQmt0RA=
X-Google-Smtp-Source: AGHT+IEv47RnbucJpi3U3YBPqnmrNL/GBHxFXLFpwUNu7uyHiMz6V84MrRg3LpUzeLdEbcLGs8K7uQ==
X-Received: by 2002:a05:600c:6288:b0:45b:86ee:415f with SMTP id
 5b1f17b1804b1-467e63be254mr62397675e9.6.1758384623438; 
 Sat, 20 Sep 2025 09:10:23 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it.
 [95.249.236.54]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-45f325cec0fsm105878675e9.4.2025.09.20.09.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 09:10:23 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 3/5] net: mediatek: mt7988: free allocated MDIO bus on
 cleanup
Date: Sat, 20 Sep 2025 18:09:43 +0200
Message-ID: <20250920161013.31799-4-ansuelsmth@gmail.com>
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

Correctly free the MDIO Bus on calling cleanup function. While at it
also fix a copy-paste error and rename the cleanup function name to the
more specific name.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/mtk_eth/mt7988.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mtk_eth/mt7988.c b/drivers/net/mtk_eth/mt7988.c
index 06bbe049da3..b77660be55c 100644
--- a/drivers/net/mtk_eth/mt7988.c
+++ b/drivers/net/mtk_eth/mt7988.c
@@ -142,11 +142,13 @@ static int mt7988_setup(struct mtk_eth_switch_priv *swpriv)
 	return mt7531_mdio_register(priv);
 }
 
-static int mt7531_cleanup(struct mtk_eth_switch_priv *swpriv)
+static int mt7988_cleanup(struct mtk_eth_switch_priv *swpriv)
 {
 	struct mt753x_switch_priv *priv = (struct mt753x_switch_priv *)swpriv;
+	struct mii_dev *mdio_bus = priv->mdio_bus;
 
-	mdio_unregister(priv->mdio_bus);
+	mdio_unregister(mdio_bus);
+	mdio_free(mdio_bus);
 
 	return 0;
 }
@@ -158,6 +160,6 @@ MTK_ETH_SWITCH(mt7988) = {
 	.reset_wait_time = 50,
 
 	.setup = mt7988_setup,
-	.cleanup = mt7531_cleanup,
+	.cleanup = mt7988_cleanup,
 	.mac_control = mt7988_mac_control,
 };
-- 
2.51.0

