Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C797DC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33BBC82CD6;
	Wed, 16 Apr 2025 13:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="dDy2O+NP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BBF982D17; Wed, 16 Apr 2025 13:44:18 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C63081F45
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chf.fritz@googlemail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c14016868so6148772f8f.1
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 04:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1744803856; x=1745408656; darn=lists.denx.de; 
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to
 :reply-to:from:subject:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sUbPesgil7r2bEyVl4wGVhR8zmoTPEt85om+FE7i9XE=;
 b=dDy2O+NPzLqSHT91auZSe5UJtZaSFsK17d7XTRgUC2r1qK+75ax83rUJtXPDdiaf5a
 8A7gi0CUev0t/aI6IDs3budrN3ODp2Je5j9nBSAfMVe37p9c6Clwteg8+/OPxZgq01JE
 9iWsC6rAMlHRt+RgftIPZXi+iELLdjzT04V4ORXrlZE2iZtTTg3SjOsgP5096oH7AHZG
 n+yGRXWmp2FKaGxPQWUGH2Se3/nilwCqiPBWjr+4CpNoUwQ1M9KRYtSVVSnSdzLA4mhz
 eX1mcMMgXnd+YlV3yTDwktRS37IN0HHKRvLIjDweSGZXBa6QlF3SvdsWRQy7ws5l+5HH
 ij0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744803856; x=1745408656;
 h=mime-version:user-agent:content-transfer-encoding:date:cc:to
 :reply-to:from:subject:message-id:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sUbPesgil7r2bEyVl4wGVhR8zmoTPEt85om+FE7i9XE=;
 b=K1O9BTy++o+j38274jPA/KMouNPn3etXvb+CORocKa84fPPesaPUi3OUDYAVkY1rM5
 YBwHq+0YUNkbJ3+1MuYtlHx2wvMp8fIvkzec017LdISc85xIC5A+9xX3/eicBUEwcOHZ
 exKUyEIZR/Cu+zsIoCLrF8vztrjUbSgsBIIToH87/csnwGpYtOOUIac9D9n/3LHO/0K6
 yuFCmIOXEhS5E5ecoGXtBBnrf0JXCXsDWT3GV45gtijavSAv8Oagv00NxqDl9RScg2ob
 l6aBvjCR1kSHGKkDUO4X3VIS3ve85X+MRNfAzwcqfCibTCh5rz+YCb+vwBjdVinIT0B8
 gIUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiAfKEHC+tmlaK1KoU0MTfwpdbxH1lteF5YEb1pUkep5vW1o+KFW425+KNxVkZpeM6OAkHykw=@lists.denx.de
X-Gm-Message-State: AOJu0YxUOjVq+9IJn6gIN9FMoPUTVpziNvp4gZku6CypWtO1PWCmD7OA
 Mo4iMt+Blm6VuYA5CCswwehjBZmJfx066b7LVZGiFZinD5c/TI1h
X-Gm-Gg: ASbGncsusAHvAZonqMOEwKa8xR30ZZ1UCHuSkfHyy6TK3HEh9Ni+ugpBE5yhIISjibG
 DSylvsOzALMp5JkMqZSGeAKhlEgNEGgqVA5SfuSPlRHQEuXv+2SprRSR04akfbeDeTaDKhKYHE+
 ji0ZhvnSkUi9n4024d+zLJhYNn5MuohDzB4/r1LBuVsNzT5sU1RsAHCiQl6fFOupJ3kpXoQIWze
 ybKpBW8K5PFFWv0kGkQ+Le6kVH60tpGcLWttiDbpXR8YNK2bZJ18qrvnYZvTKu71+S0T7ufmD17
 e8s5t3XrmFtPzUQABpm0+y9VlNaEGRWHbZMCh2FSrM8YGJ1qZ1FPwTw=
X-Google-Smtp-Source: AGHT+IGzAWXLuEMmBaXDzbsoR/jMdPbk8hI2qEftkh7VdZRQQrXAC+3EjEAiN10iC23QUlylY1ZjFA==
X-Received: by 2002:a5d:6485:0:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-39ee5b37b83mr1646513f8f.27.1744803855386; 
 Wed, 16 Apr 2025 04:44:15 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8071:7130:82c0:da34:bd1d:ae27:5be6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b4f3df8sm18894225e9.24.2025.04.16.04.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 04:44:14 -0700 (PDT)
Message-ID: <13931598d2714780f91ce96d054664f304de7c1f.camel@googlemail.com>
Subject: [PATCH 1/2] rockchip: rk3288: grf: Unify speed/flowctrl fields for
 clarity
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>,  Fabio Estevam <festevam@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Joe Hershberger
 <joe.hershberger@ni.com>, RamonFried <rfried.dev@gmail.com>, u-boot
 <u-boot@lists.denx.de>
Date: Wed, 16 Apr 2025 13:44:13 +0200
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

Update GMAC speed and flow control fields in GRF_SOC_CON1 to use
RK3288_GMAC_* prefix, ensuring a consistent naming convention. It also
shifts each mask/bit definition to match the actual hardware bits, which
makes future usage easier.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/include/asm/arch-rockchip/grf_rk3288.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3288.h b/arch/arm/inc=
lude/asm/arch-rockchip/grf_rk3288.h
index 894d3a40b09..0111b3a0ded 100644
--- a/arch/arm/include/asm/arch-rockchip/grf_rk3288.h
+++ b/arch/arm/include/asm/arch-rockchip/grf_rk3288.h
@@ -934,21 +934,21 @@ enum {
 	RK3288_RMII_CLK_SEL_2_5M  =3D (0 << RK3288_RMII_CLK_SEL_SHIFT),
 	RK3288_RMII_CLK_SEL_25M   =3D (1 << RK3288_RMII_CLK_SEL_SHIFT),
=20
-	GMAC_SPEED_SHIFT	=3D 0xa,
-	GMAC_SPEED_MASK		=3D 1,
-	GMAC_SPEED_10M		=3D 0,
-	GMAC_SPEED_100M,
+	RK3288_GMAC_SPEED_SHIFT	=3D 0xa,
+	RK3288_GMAC_SPEED_MASK	=3D (1 << RK3288_GMAC_SPEED_SHIFT),
+	RK3288_GMAC_SPEED_10M	=3D (0 << RK3288_GMAC_SPEED_SHIFT),
+	RK3288_GMAC_SPEED_100M	=3D (1 << RK3288_GMAC_SPEED_SHIFT),
=20
-	GMAC_FLOWCTRL_SHIFT	=3D 0x9,
-	GMAC_FLOWCTRL_MASK	=3D 1,
+	RK3288_GMAC_FLOWCTRL_SHIFT =3D 0x9,
+	RK3288_GMAC_FLOWCTRL_MASK =3D (1 << RK3288_GMAC_FLOWCTRL_SHIFT),
=20
 	RK3288_GMAC_PHY_INTF_SEL_SHIFT =3D 6,
 	RK3288_GMAC_PHY_INTF_SEL_MASK  =3D (7 << RK3288_GMAC_PHY_INTF_SEL_SHIFT),
 	RK3288_GMAC_PHY_INTF_SEL_RGMII =3D (1 << RK3288_GMAC_PHY_INTF_SEL_SHIFT),
 	RK3288_GMAC_PHY_INTF_SEL_RMII  =3D (4 << RK3288_GMAC_PHY_INTF_SEL_SHIFT),
=20
-	HOST_REMAP_SHIFT	=3D 0x5,
-	HOST_REMAP_MASK		=3D 1
+	RK3288_HOST_REMAP_SHIFT	=3D 0x5,
+	RK3288_HOST_REMAP_MASK	=3D (1 << RK3288_HOST_REMAP_SHIFT),
 };
=20
 /* GRF_SOC_CON2 */
--=20
2.39.5


