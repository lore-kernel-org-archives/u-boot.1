Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5663EC48291
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 16:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFDE687C3D;
	Fri,  2 Feb 2024 17:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q/0ByGB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B72887C15; Fri,  2 Feb 2024 17:04:20 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8A187BF1
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 17:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d97d086756so662575ad.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706889856; x=1707494656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGbaT51S6dZ/iUgH4jNh2ugjc/NvPEGM9rEU36lf/8A=;
 b=Q/0ByGB4u7D+VMeFqw2+x752dpp9ayCkBAFy5DfSsl1+Su05Q2B0/4vqIHcW4qUYv5
 pvW0A4K9B0TY7ShvBgazLvwLas9AvztziSnsxJmcep58lw5448gWbjFnPxLXe7XCl+zF
 wGB/D0GmIdhg0zxG1NgTIzthOoG3gGOjbrMNYiKvbu9dbAXS6YM0MVJuNFLih5K5+52t
 ATXC8MHJkbk9IhNKHJKh1Ou8adgbC7se07SVpq28+T62cuzIJSS8+C+rABxY74v638EH
 qVs3+corpNeWs/WeqDC9n5/wVqY6ufbflUcGWIZobngTUeAEsQxD/P38bQayXrlONAaD
 bSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706889856; x=1707494656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OGbaT51S6dZ/iUgH4jNh2ugjc/NvPEGM9rEU36lf/8A=;
 b=Q+jXXV0AqnoEHVjkimUWzTTlzIKALQdfZJk6FprIfDf9BtLYQ3GTM/3FeXi6fCRuHC
 e1f0orzVxB7A9eCHr1PUrE/xnCXHX6O64lKam2DBY61SXrPPM5m6MdIMylOeM9YADyx7
 mCLnuFQAG34NakSlNFV37NMEZw5UOP/2fnXhjLyL8jxEI6M05VAmjKPD2odvpJxoaYrD
 djUjuRAIjoXNCG3HSOAhGZfAFBn1Yzw2OtxqUx/YhR9JyHuzOsCodUEYKR8MSRFEKrSO
 VRYdERi2TPHjIpyoIYwH6WW+C/ES5OlGWGuHmD9siQd4wOTfxst0n+BleEeh7zgXTBLS
 ec+A==
X-Gm-Message-State: AOJu0YzmG8pNDdR1D558wXziIo7Ca6+hmfHLEEaqfQQCL3u2nqmG0kZ6
 nZTnp3aY31xU5sY7CBej+Osx3/lmWcUkD++hdBEB/BBH20BFs13j
X-Google-Smtp-Source: AGHT+IE3Am5h/+ljLNWYfN+GN8R4nM55RVG3vPEm9yIihZ3zVflx2iSiSWAFjvSOfMtr5WUOpvOosw==
X-Received: by 2002:a17:902:ec89:b0:1d8:eac8:5e00 with SMTP id
 x9-20020a170902ec8900b001d8eac85e00mr6400593plg.4.1706889856446; 
 Fri, 02 Feb 2024 08:04:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXJbJq6XSafWgOhOp7lHBgyoTtLBmVz2nrrKpc0FF+YeKj3IbjOj9HrbwKAB+S6LcycGL4D4CNbWShps3OZghFTTlysrlsCSzePQ8dt2pTB+emoQxKLnnInO9lJDmuEKm0go/Rf9xPqv2zV
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:fa09:d56a:f130:f280])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a170902b7c400b001d8b8bf8e44sm1780086plz.92.2024.02.02.08.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 08:04:16 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de,
	trini@konsulko.com
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 3/3] mx6sabresd: Remove board_phy_config()
Date: Fri,  2 Feb 2024 13:04:05 -0300
Message-Id: <20240202160405.4126192-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202160405.4126192-1-festevam@gmail.com>
References: <20240202160405.4126192-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

With Ethernet DM in place, there is no longer the need for having
the board_phy_config() anymore.
    
Remove it.

Confirmed that TFTP transfer still works fine without board_phy_config().

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Newly introduced.

 board/freescale/mx6sabresd/mx6sabresd.c | 34 -------------------------
 1 file changed, 34 deletions(-)

diff --git a/board/freescale/mx6sabresd/mx6sabresd.c b/board/freescale/mx6sabresd/mx6sabresd.c
index b558a596dff8..bb066a5d36c3 100644
--- a/board/freescale/mx6sabresd/mx6sabresd.c
+++ b/board/freescale/mx6sabresd/mx6sabresd.c
@@ -7,7 +7,6 @@
 
 #include <image.h>
 #include <init.h>
-#include <net.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/iomux.h>
@@ -254,39 +253,6 @@ int board_mmc_init(struct bd_info *bis)
 }
 #endif
 
-static int ar8031_phy_fixup(struct phy_device *phydev)
-{
-	unsigned short val;
-
-	/* To enable AR8031 ouput a 125MHz clk from CLK_25M */
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x7);
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xe, 0x8016);
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x4007);
-
-	val = phy_read(phydev, MDIO_DEVAD_NONE, 0xe);
-	val &= 0xffe3;
-	val |= 0x18;
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xe, val);
-
-	/* introduce tx clock delay */
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x5);
-	val = phy_read(phydev, MDIO_DEVAD_NONE, 0x1e);
-	val |= 0x0100;
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, val);
-
-	return 0;
-}
-
-int board_phy_config(struct phy_device *phydev)
-{
-	ar8031_phy_fixup(phydev);
-
-	if (phydev->drv->config)
-		phydev->drv->config(phydev);
-
-	return 0;
-}
-
 #if defined(CONFIG_VIDEO_IPUV3)
 static void disable_lvds(struct display_info_t const *dev)
 {
-- 
2.34.1

