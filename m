Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F54C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 22:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95B848745B;
	Fri,  3 Nov 2023 23:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cNItZirF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CC4F87468; Fri,  3 Nov 2023 23:47:48 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B2A86FA5
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 23:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5845b7ee438so431963eaf.1
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699051665; x=1699656465; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nnx5yCMY7UVwOWi8MtMC1arMe2QcymGZX1Li9gSRpOE=;
 b=cNItZirFwtRDts0L2T+/bjwybZ2uX9/1LpQsliFKD3Lod/9OfZ0s5rMC/BcFk751dW
 nPGJjH+uzRjxcmMucX/oj1vEdXg2H/L1gMmuubwi60woA/yY6MwqaXGI2SguOUJzwxcq
 N07w7XDJQsM/qEfBkpFeokDHLSj/bEJqHBA7uIpmrsumhQEohiWukPlfOmhRh+toPupV
 pMCnRvBGW2DiT7CHomlHDcOtovkiO8FDAgug3Ev6asQg86GNqPvOObliN7BzKTGCYjxt
 WbHW2dytoNdpmstcW/urDnuL9F9xAjT0gEtUqNUyXHpVW24dh8wDqfZ1aI9czgvaPmq/
 RT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699051665; x=1699656465;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nnx5yCMY7UVwOWi8MtMC1arMe2QcymGZX1Li9gSRpOE=;
 b=uSg8B3fWaKsO+URQTshwC6iuhJPWtC1MlmXqFqf2T088oS6iD0v3fMizpgKp9kJv+w
 +VK3r3RCqhrUALX8iRAIVz/zXB1Eet576UV5e3aR37MxrX7UIdaSF/4lPRh/EcMy8VBg
 lNKw6eIC465jdxMrAgXmMavafnnYDZW1vVA7YLDT8eWI9bortTQ/0jcvhbLbVNRA6XvW
 JFrxu29IMrL1bRwQ4sgMdXrZfMHyPnDY/Ig7hrCH+WSs9WmqkeND2rSrCvN5VDVJ6m2a
 vPwbo1vs1PaFpAFwkiyevc1NzkQNuQVGlD54kPV6NXMYlOSAv6fvriUXFADw6NuGUu+x
 LthA==
X-Gm-Message-State: AOJu0Yz8ujp/j5n6YyKoYd/4vxRN1xY/O9UV/RT+0PZl7eiXvnCIjNFN
 9Hukwk0fI++Kv1CchhCWIwwK8PSAjUw=
X-Google-Smtp-Source: AGHT+IFTiqtfLwEeaaLNnG5bIcVCZLbTsoYqVMZEpA+8ynYZulUFFabcIP0k52UximGmQSSd6ZQQ6g==
X-Received: by 2002:a05:6830:390a:b0:6c0:c1ba:8f78 with SMTP id
 br10-20020a056830390a00b006c0c1ba8f78mr25380789otb.0.1699051664731; 
 Fri, 03 Nov 2023 15:47:44 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b4e9:3424:1f72:d6d3])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a05622a025500b004180fdcb482sm1080805qtx.81.2023.11.03.15.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 15:47:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] pico-imx7d: Remove board_phy_config()
Date: Fri,  3 Nov 2023 19:47:33 -0300
Message-Id: <20231103224733.59410-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

With Ethernet DM in place, there is no longer the need for having
the board_phy_config() anymore.

Remove it.

Tested on imx7d-pico-pi board:

=> setenv autoload no
=> dhcp
BOOTP broadcast 1
*** Unhandled DHCP Option in OFFER/ACK: 42
DHCP client bound to address 192.168.0.138 (138 ms)
=> tftp zImage
Using ethernet@30be0000 device
TFTP from server 192.168.0.16; our IP address is 192.168.0.138
Filename 'zImage'.
Load address: 0x80800000
Loading: #################################################################
....
	 #################################################################
	 ##########
	 4.3 MiB/s
done
Bytes transferred = 9034120 (89d988 hex)

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 board/technexion/pico-imx7d/pico-imx7d.c | 26 ------------------------
 1 file changed, 26 deletions(-)

diff --git a/board/technexion/pico-imx7d/pico-imx7d.c b/board/technexion/pico-imx7d/pico-imx7d.c
index 6e98b85b2873..5def6eda43e5 100644
--- a/board/technexion/pico-imx7d/pico-imx7d.c
+++ b/board/technexion/pico-imx7d/pico-imx7d.c
@@ -101,32 +101,6 @@ static int setup_fec(void)
 
 	return set_clk_enet(ENET_125MHZ);
 }
-
-int board_phy_config(struct phy_device *phydev)
-{
-	unsigned short val;
-
-	/* To enable AR8035 ouput a 125MHz clk from CLK_25M */
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x7);
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xe, 0x8016);
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xd, 0x4007);
-
-	val = phy_read(phydev, MDIO_DEVAD_NONE, 0xe);
-	val &= 0xffe7;
-	val |= 0x18;
-	phy_write(phydev, MDIO_DEVAD_NONE, 0xe, val);
-
-	/* introduce tx clock delay */
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1d, 0x5);
-	val = phy_read(phydev, MDIO_DEVAD_NONE, 0x1e);
-	val |= 0x0100;
-	phy_write(phydev, MDIO_DEVAD_NONE, 0x1e, val);
-
-	if (phydev->drv->config)
-		phydev->drv->config(phydev);
-
-	return 0;
-}
 #endif
 
 static void setup_iomux_uart(void)
-- 
2.34.1

