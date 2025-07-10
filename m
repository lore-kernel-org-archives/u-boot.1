Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415C2C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 21:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F10835C9;
	Thu, 10 Jul 2025 23:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=yngvason.is header.i=@yngvason.is header.b="LefGdNe3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF67E836CE; Thu, 10 Jul 2025 19:32:02 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C927F82AFC
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=yngvason.is
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andri@yngvason.is
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso17265165e9.0
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1752168719; x=1752773519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UTF+37kJ6oUy2g9APuN6nKId86xRWSbHVYZAyp7d8oo=;
 b=LefGdNe3d3Dzd+EwBfUlaLHMqOZnmnlWG2s8Y//PbNntwO26L1+8PG+/kYuEPhCu+4
 9PLRhbMWBFRwQIZXtJmeqnzAToi/nu5EljADluHOIVeAeZJgFFuxE6eHsclQN9WGmMsb
 7yJ/D4afkRfWVvsUkS31raU4kfQ2GsjhevAc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752168719; x=1752773519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UTF+37kJ6oUy2g9APuN6nKId86xRWSbHVYZAyp7d8oo=;
 b=iQTajToEWlERVjArZjltDCb4utg2NLqxiMDkoYeBoCNRnSJm3E6qbSN61W3YaJf5Ck
 jIw+tEXQug6cOjNfz9/fvujZ9FZqDF046Y+0HagnXrEtCa0qg/pm/rl/s603r1ZTj8iC
 y1oSve+6eIbaoMPrtsBr4uw8TAyRahuSqc6o8e0q43e6Ar0uRnxWWN8KFMBaj8g9z0vK
 fD8+8eflGDgGGRQCuwLp2vwdQ922JTlcUlXlNelFdAn2gDDkkTzJT08LQinh8dVSFpig
 SrD2RX9BqsLVF8f8wWw8I7i1luaypeq8seDWjSbplmev1a6OThBOBur+UM6ABXhtiiU5
 q4ZQ==
X-Gm-Message-State: AOJu0Yx/B6Z+K0QfbR/jJTshzjXhbhRXQJQEkTRignkLE3G1uYhboUZ3
 Zp79AwaMy6YxJnLP+rZJnWDovJ1p6INu+yW08ZHxpCfJDE8o3I+AHPoLichmjSnCCbnQOan0yQy
 tCQKi8wYCWA==
X-Gm-Gg: ASbGncv9vptbWguGqVqSpMFu1jzGzWZ5+1L/Rjgt6J/tf0iuID+qysab1dkQOZbxGSs
 58cmMZDwIqj8a8G3t/5bFwZtq99itzLcfri46qW63IhAL8SCL/Gev7pMYrZvTfKWTkAXLRiIC7Z
 wpElp9mTgK8ZNjaLB+LyZPuC9IgOufOJjtL/gAtnbqrsAAf9ql80GXp40boZngWaADc0VpJugGl
 cR3DYhAZ0kp6NrZ0np2OjYWsPX+nTuzpIg54TDqUNUI+8i3d0kKq8VWAFDI8BR5mXMqDKjQR9x3
 60E0PluJFrx1JFlKklR7d6d0jHmCrGuWK9tji2dYwgGPiR2NzCDbVEOPEapfguS/1PxpwiF6J+a
 PJJIVuuB0mv1egdgJIegglCM=
X-Google-Smtp-Source: AGHT+IFmPGRAg3O57V/rSmkyJCJVOjOXsdACZ2wAPxFx1ycY2qw1Wwq05FyDE/gs79FzchNKV502Lg==
X-Received: by 2002:a05:600c:3508:b0:454:b97a:486e with SMTP id
 5b1f17b1804b1-454e2b351d7mr1593385e9.10.1752168719010; 
 Thu, 10 Jul 2025 10:31:59 -0700 (PDT)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d732sm2442227f8f.52.2025.07.10.10.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 10:31:58 -0700 (PDT)
From: Andri Yngvason <andri@yngvason.is>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Andri Yngvason <andri@yngvason.is>
Subject: [PATCH 1/3] phy: rockchip: inno-usb2: Add rk3576 config
Date: Thu, 10 Jul 2025 17:31:52 +0000
Message-ID: <20250710173154.1244430-1-andri@yngvason.is>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Jul 2025 23:56:14 +0200
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

Signed-off-by: Andri Yngvason <andri@yngvason.is>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 88b33de1b2a..c38b48d0c71 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -456,6 +456,28 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3576_phy_cfgs[] = {
+	{
+		.reg		= 0x0000,
+		.clkout_ctl	= { 0x0008, 0, 0, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0000, 8, 0, 0, 0x1d1 },
+			}
+		},
+	},
+	{
+		.reg		= 0x2000,
+		.clkout_ctl	= { 0x2008, 0, 0, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x2000, 8, 0, 0, 0x1d1 },
+			}
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
 	{
 		.reg		= 0x0000,
@@ -517,6 +539,10 @@ static const struct udevice_id rockchip_usb2phy_ids[] = {
 		.compatible = "rockchip,rk3568-usb2phy",
 		.data = (ulong)&rk3568_phy_cfgs,
 	},
+	{
+		.compatible = "rockchip,rk3576-usb2phy",
+		.data = (ulong)&rk3576_phy_cfgs,
+	},
 	{
 		.compatible = "rockchip,rk3588-usb2phy",
 		.data = (ulong)&rk3588_phy_cfgs,
-- 
2.50.0

