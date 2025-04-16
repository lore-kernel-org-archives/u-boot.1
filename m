Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBBFC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4758482DA1;
	Wed, 16 Apr 2025 13:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="EI7ZfiSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E83F082DF2; Wed, 16 Apr 2025 13:45:38 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB97581F45
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:45:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chf.fritz@googlemail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso374530f8f.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1744803936; x=1745408736; darn=lists.denx.de; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AjbcDiZaTSk61OeJzZ2YpS1Fi8UbohnHwB6/eFidNsQ=;
 b=EI7ZfiSkVg7BUTgIRUMi31W3CXx119sMpkioo6WrqE9lvsnV2d9qHTr1YXlaPim3HU
 R55D7SSgY+Oe1H6+i4O2IOQP90nYqfXqIo4jxbtWfMHyVoUzcDtyOLquYepirUsvfiJM
 b2vYeGefV0TmPl0jnIXqHgbVHZE4uOAOKuMFWWlop0R/XLiglKjJtgNzs1vYLPh3rpD0
 6nRQd+eiwLeWmEaRUO4Gdc7LGkbGdKuV9hxN0oGjyG9Ugwr39Y0bJ7M2FMkuMtsuYPzs
 FjG8efFQVU63zahKWFUVg4pB33+ku0PMtp2JAziGXGCd/FVVVqJ9Dj8K8WMO8wJiB0px
 Tp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744803936; x=1745408736;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:reply-to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AjbcDiZaTSk61OeJzZ2YpS1Fi8UbohnHwB6/eFidNsQ=;
 b=tTRRoP7kIfCYxhBL/ysfRY2bVv7/6JQ6QN8oFwbNXg8LyDR4180vVvgXrrZfPP7Fyi
 faYO0yp3dJk64Hx0najkTb3aGrwoXOUWgzLvdj1q6Rtj0pzxQTl/RST0SJxZpPaDug+I
 QkBW3NQ2rJmi6zBKIvmg90Dloys25LBbEtZtDbrzWXFNfUB3Tp0Pk2gMdhAHQHb/ZGbZ
 Y9NMENYlxNLV737mhzAvAKvT5HtZ51zh8Vd+cXAP29Dp1gpxswc9kLEZD9024fP+Wiyx
 77ItHQHNDVLamcuGqMGJuhG9E+GKhXxUlIePW4tTdD4wVguT0uhmpIs8+sXFn8i0d3sZ
 YGwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTg1bUUJ7a4QBVUsc8HiZ9SaZBWur4LKI1xyhYC3CggqeTr3F/GbZRjaZWkLByIXQ4thq7umc=@lists.denx.de
X-Gm-Message-State: AOJu0YxXBl/Nnt9t+MT9x63HjwQ9aku0Xzk5iOrRumrbJ3/X/PMmNzAf
 gZkA+sVWxXa6s3nGZWgfmbSF1HPy0D56sEvtHdNrxz3gyJlCL7Eo
X-Gm-Gg: ASbGncu6evEkXlNViwPBpuwHqwlgIQOyOdjFH+g4HPJBbNp9Ag2g4EbjGiU3wS1WOfu
 c7JBhoZWMOEiP1PPVb1M19swxr2jTTwz8c3jQdkGQSLAamcdjd5cgeeMyxoglFX9Zr6I+NswhRI
 n51cYP5/0nZen7NZ69r/ibcKKrTOImKhZO0S8rucbKdFNlhKK/mCrC0aEaw3zyalOYw8Ih1xmDY
 JcKhYKMoUIE/PwABQY/JpPokB8V14KhsktuOmKYPOO/GOzBYyHKIVNMkP+Pv35nuJWM8KjhpAl+
 IU6huTMuir8fPjfX4ge/IGbyGwTVM5v2BUA6op4PuBBz/Zqn/tMyBXvKcwHFOet+yQ==
X-Google-Smtp-Source: AGHT+IHmgWdTXZKVFFmKLrwSu51gXCNVlRAoTZBz6rz1WIoDicUXdCBr8BYkfpYupHZDCiq2i4XRfg==
X-Received: by 2002:a05:6000:220c:b0:390:f116:d220 with SMTP id
 ffacd0b85a97d-39ee5ea43f5mr1350212f8f.17.1744803936295; 
 Wed, 16 Apr 2025 04:45:36 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c684sm17070813f8f.33.2025.04.16.04.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 04:45:35 -0700 (PDT)
Message-ID: <b8247c8953823fc1b61ec7447b37b9844d6c3db3.camel@googlemail.com>
Subject: [PATCH 2/2] net: gmac_rockchip: Add RMII support for rk3288
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>,  Fabio Estevam <festevam@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Joe Hershberger
 <joe.hershberger@ni.com>, RamonFried <rfried.dev@gmail.com>, u-boot
 <u-boot@lists.denx.de>
Date: Wed, 16 Apr 2025 13:45:35 +0200
In-Reply-To: <13931598d2714780f91ce96d054664f304de7c1f.camel@googlemail.com>
References: <13931598d2714780f91ce96d054664f304de7c1f.camel@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
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
Reply-To: chf.fritz@googlemail.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add RMII-specific handling to rk3288_gmac_fix_mac_speed() so that it
properly sets the RMII clock (2.5=E2=80=AFMHz vs. 25=E2=80=AFMHz) and speed=
 bits
(10=E2=80=AFMbps vs. 100=E2=80=AFMbps). Also define a new rk3288_gmac_set_t=
o_rmii()
function to set the PHY interface field and RMII_MODE bit.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/net/gmac_rockchip.c | 69 ++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 8cfeeffe95b..c8cfe7448d4 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -151,26 +151,51 @@ static int rk3228_gmac_fix_mac_speed(struct dw_eth_de=
v *priv)
=20
 static int rk3288_gmac_fix_mac_speed(struct dw_eth_dev *priv)
 {
+	struct dw_eth_pdata *dw_pdata =3D dev_get_plat(priv->dev);
+	struct eth_pdata *eth_pdata =3D &dw_pdata->eth_pdata;
 	struct rk3288_grf *grf;
+	grf =3D syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 	int clk;
=20
-	switch (priv->phydev->speed) {
-	case 10:
-		clk =3D RK3288_GMAC_CLK_SEL_2_5M;
-		break;
-	case 100:
-		clk =3D RK3288_GMAC_CLK_SEL_25M;
-		break;
-	case 1000:
-		clk =3D RK3288_GMAC_CLK_SEL_125M;
-		break;
-	default:
-		debug("Unknown phy speed: %d\n", priv->phydev->speed);
-		return -EINVAL;
-	}
+	if (eth_pdata->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII) {
+		switch (priv->phydev->speed) {
+		case 10:
+			rk_clrsetreg(&grf->soc_con1,
+				     RK3288_RMII_CLK_SEL_MASK |
+				     RK3288_GMAC_SPEED_MASK,
+				     RK3288_RMII_CLK_SEL_2_5M |
+				     RK3288_GMAC_SPEED_10M);
+			break;
+		case 100:
+			rk_clrsetreg(&grf->soc_con1,
+				     RK3288_RMII_CLK_SEL_MASK |
+				     RK3288_GMAC_SPEED_MASK,
+				     RK3288_RMII_CLK_SEL_25M |
+				     RK3288_GMAC_SPEED_100M);
+			break;
+		default:
+			debug("Unknown phy speed: %d\n", priv->phydev->speed);
+			return -EINVAL;
+		}
+	} else {
+		switch (priv->phydev->speed) {
+		case 10:
+			clk =3D RK3288_GMAC_CLK_SEL_2_5M;
+			break;
+		case 100:
+			clk =3D RK3288_GMAC_CLK_SEL_25M;
+			break;
+		case 1000:
+			clk =3D RK3288_GMAC_CLK_SEL_125M;
+			break;
+
+		default:
+			debug("Unknown phy speed: %d\n", priv->phydev->speed);
+			return -EINVAL;
+		}
=20
-	grf =3D syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-	rk_clrsetreg(&grf->soc_con1, RK3288_GMAC_CLK_SEL_MASK, clk);
+		rk_clrsetreg(&grf->soc_con1, RK3288_GMAC_CLK_SEL_MASK, clk);
+	}
=20
 	return 0;
 }
@@ -401,6 +426,17 @@ static void rk3228_gmac_set_to_rgmii(struct gmac_rockc=
hip_plat *pdata)
 		     pdata->tx_delay << RK3228_CLK_TX_DL_CFG_GMAC_SHIFT);
 }
=20
+static void rk3288_gmac_set_to_rmii(struct gmac_rockchip_plat *pdata)
+{
+	struct rk3288_grf *grf;
+
+	grf =3D syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
+
+	rk_clrsetreg(&grf->soc_con1,
+		     RK3288_GMAC_PHY_INTF_SEL_MASK | RK3288_RMII_MODE_MASK,
+		     RK3288_GMAC_PHY_INTF_SEL_RMII | RK3288_RMII_MODE);
+}
+
 static void rk3288_gmac_set_to_rgmii(struct gmac_rockchip_plat *pdata)
 {
 	struct rk3288_grf *grf;
@@ -703,6 +739,7 @@ const struct rk_gmac_ops rk3228_gmac_ops =3D {
 const struct rk_gmac_ops rk3288_gmac_ops =3D {
 	.fix_mac_speed =3D rk3288_gmac_fix_mac_speed,
 	.set_to_rgmii =3D rk3288_gmac_set_to_rgmii,
+	.set_to_rmii =3D rk3288_gmac_set_to_rmii,
 };
=20
 const struct rk_gmac_ops rk3308_gmac_ops =3D {
--=20
2.39.5


