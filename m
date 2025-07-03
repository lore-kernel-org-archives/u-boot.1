Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8210C83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 06:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD8AF80E9A;
	Thu,  3 Jul 2025 08:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QWP2YDzE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3674C81FEE; Thu,  3 Jul 2025 08:05:25 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F089800D7
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 08:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-553b165c80cso7777233e87.2
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 23:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751522722; x=1752127522; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HE77RAEN6gDpaldI7x4n4XKR1SxX9dah/CCIsu2ycag=;
 b=QWP2YDzEzUUjXhSdLHXSCgrHTsLkWiR+EOdkMbsGOZIW7I3aSvGWaIaw2uzrWD8/ga
 +pWbLqtH+cn8D1YLS+pi33nFdKwG8/3Cq2bkv7LQGqKXfFOwH+K5p0+KdPqZyZDpeGTc
 9Aec63YDTv4d7No6LqLs1E/MsijPJcjPwwskQWfSlv51OXrwojUu5WqZnMhaHcKnKjU5
 Zyrtoz5Lct1hpCWxu9y6XqWureuzMGg5N4i18IT/uRpDjBq6pTJjW58+oPJaA3kZNMCZ
 9OeFJTX7k6k33gCcIbB8lWztgspgPEKwTmdpn0LsSyfgD9UG6vk3CaScaESVXF0q375Y
 hvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751522722; x=1752127522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HE77RAEN6gDpaldI7x4n4XKR1SxX9dah/CCIsu2ycag=;
 b=P+K9VXR9apreJKPj7qskvuDBI+uVxHlapniNC5/ZRO9h+gxMPSEB4wgDyuRcVjUAgc
 xJ7MX4donQ5shOhEDsSZa6rZcYC+AVvx8/4C+cmhtKp+gMSxmEsElgnjf/xB8DUmd6mA
 Sq/k21Ry69lKCZYsphHe1w/hjdqWTgUZMT7gcqXM4+BBiWpAfM9mqT5KBEWxAezHE6zY
 R8RJP3XtsIcm54qIq4U7sw2LKtCHW0+qHThQLscgJQIyQpoSMzcFswb449lxP5V3Y+0B
 jm1Z82X3k04pr1jq1vUZF9fOf9S6DPgXLEl98T6F6mL2U03doVf2UXl3Imbl7LDb6V0D
 dBVQ==
X-Gm-Message-State: AOJu0YyZg2x7NHRNKMUVoaK/aYgWdl90PrkdSRVHznmE5O2JhfYw7c0u
 d3mAoj4PoVqU7FEOAzqYIbfEGKcczzCWaI2U+bwK5ltE7JQUQwWdKpD6FdYsF5gyjKA=
X-Gm-Gg: ASbGnctiJCY2CoJVhVbOI5JnEm+u3kw4tvBVpSmIcLG8vG3lzKRxfPGPhnDc/dXL0iL
 KhVFBmJi3yvYFWPJfOLFK4Vk0c8Ik1h15yPTEGJKTOZdf5OzCL4cv/u2MTAEELOvt8UTGR6eqJ0
 McuxxeLm/7SqI4QOf4p3LEkaVenAEcLe8uYaZIbLw7W3micn/sDUmjQuRelmlyVid1wtQxaiDNx
 nlCz+6oi+XgqCQowOaBzTMdups9Odm2+23agI7wtzPdbnJuBw6dE+lxeMnY9QXe1GIV8tC42WEA
 YGekB++Nq6/iHhi7BmrqXw50frClKq7MTMobI0PpYaV8Jh1BN2tPwUlY0z0G2/BeOGwwXQ==
X-Google-Smtp-Source: AGHT+IGzDjRG7Uen2cUduJIfrWCFUo7LrveAsBn3NR5Drc7cDxJoMbOJrBMNkllFR01qQlzbrbX0rw==
X-Received: by 2002:a05:6512:4014:b0:553:5135:69fb with SMTP id
 2adb3069b0e04-5563088f2camr437315e87.10.1751522721780; 
 Wed, 02 Jul 2025 23:05:21 -0700 (PDT)
Received: from alex3d.netup (team.netup.ru. [91.213.249.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5550b2d8ea8sm2303526e87.210.2025.07.02.23.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 23:05:21 -0700 (PDT)
From: Alex Shumsky <alexthreed@gmail.com>
To: u-boot@lists.denx.de
Cc: Alex Shumsky <alexthreed@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] rockchip: rockchip-inno-usb2: Fix Synchronous Abort on usb
 start
Date: Thu,  3 Jul 2025 09:04:48 +0300
Message-ID: <20250703060517.3909695-1-alexthreed@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Fix NULL pointer dereference that happen when rockchip-inno-usb2 clock
enabled before device probe. This early clock enable call happen in process
of parent clock activation added in ac30d90f3367.

Fixes: 229218373c22 ("phy: rockchip-inno-usb2: Add support for clkout_ctl_phy").
Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
Co-authored-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
---

Changes in v2:
- rework patch (add NULL check to code instead of dts modification)

 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 88b33de1b2..3cc5956aed 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -167,20 +167,27 @@ static struct phy_ops rockchip_usb2phy_ops = {
 	.of_xlate = rockchip_usb2phy_of_xlate,
 };
 
-static void rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap **base,
-					const struct usb2phy_reg **clkout_ctl)
+static int rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap **base,
+				       const struct usb2phy_reg **clkout_ctl)
 {
 	struct udevice *parent = dev_get_parent(clk->dev);
 	struct rockchip_usb2phy *priv = dev_get_priv(parent);
 	const struct rockchip_usb2phy_cfg *phy_cfg = priv->phy_cfg;
 
-	if (priv->phy_cfg->clkout_ctl_phy.enable) {
+	// phy_cfg can be NULL if this function called before probe (when parent
+	// clocks are enabled)
+	if (!phy_cfg)
+		return -EINVAL;
+
+	if (phy_cfg->clkout_ctl_phy.enable) {
 		*base = priv->phy_base;
 		*clkout_ctl = &phy_cfg->clkout_ctl_phy;
 	} else {
 		*base = priv->reg_base;
 		*clkout_ctl = &phy_cfg->clkout_ctl;
 	}
+
+	return 0;
 }
 
 /**
@@ -206,7 +213,8 @@ int rockchip_usb2phy_clk_enable(struct clk *clk)
 	const struct usb2phy_reg *clkout_ctl;
 	struct regmap *base;
 
-	rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
+	if (rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl))
+		return -ENOSYS;
 
 	/* turn on 480m clk output if it is off */
 	if (!property_enabled(base, clkout_ctl)) {
@@ -230,7 +238,8 @@ int rockchip_usb2phy_clk_disable(struct clk *clk)
 	const struct usb2phy_reg *clkout_ctl;
 	struct regmap *base;
 
-	rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
+	if (rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl))
+		return -ENOSYS;
 
 	/* turn off 480m clk output */
 	property_enable(base, clkout_ctl, false);
-- 
2.43.0

base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
branch: fix-rk3328-usb2phy-clock-v2
