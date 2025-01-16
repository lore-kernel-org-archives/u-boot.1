Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 319F4C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B38A68022B;
	Thu, 16 Jan 2025 14:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="bLdttPWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD708801B0; Thu, 16 Jan 2025 10:16:22 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ABC3801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 10:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4YYcg51RGcz9vQ2;
 Thu, 16 Jan 2025 09:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1737018977; bh=dFViDX4bR2mVUXIKD2ipdhw1JMpiLb7HTy5leMque6Y=;
 h=From:Subject:Date:To:Cc:From;
 b=bLdttPWPTmBTImHD3rLKk72ngfZZeG0bAErbgJ5ZM3/ncusMf9h0EfqtH/mjD0JOs
 B20VpfxLwWadGiLjaRYQvgaN3aOq9kIE4BwNP6xRdD630cNM51xT4R0/hayST6gPFj
 EE90GkEGJ/GS+2PBXTVaZ3PnfFrUTt+ldxKk3NWk=
X-Riseup-User-ID: 420CB3D33429FA7FA6746FB6D9096E121081A1F39898F031E9CD5A8190F7A33B
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4YYcg12HlXzJq7r;
 Thu, 16 Jan 2025 09:16:13 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Subject: [PATCH 00/10] Rockchip VOP2 support
Date: Thu, 16 Jan 2025 16:15:49 +0700
Message-Id: <20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEXOiGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQ0MT3bL8AiPdghIjXXNT07QkQ0tLw6QkMyWg8oKi1LTMCrBR0bG1tQB
 xa3/fWgAAAA==
X-Change-ID: 20250114-vop2-pt2-755fb1991bb6
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:20 +0100
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

This series adds VOP2 support to U-Boot and enable it for PineTab2.

HDMI should work flawlessly but there's still some timings issue with
DW MIPI DSI, perhaps that's something to look into later.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
Dang Huynh (8):
      video: rockchip: dw-mipi-dsi: Depend on CONFIG_VIDEO_BRIDGE
      video: Add BOE TH101MB31IG002-28A MIPI-DSI panel
      video: rockchip: Add VOP2 support
      video: rockchip: vop2: Add video bridge support
      dts: rockchip: rk356x: Prerelocate VOP in U-Boot proper
      configs: quartz64: Enable vidconsole
      video: rockchip: Add HDMI support for RK3568
      configs: pinetab2-rk3566: Enable video and USB keyboard

Ondrej Jirman (2):
      video: rockchip: dw_mipi_dsi: Improve pixel clock calculations
      video: rockchip: dw_mipi_dsi: Proceed when external PHY is not defined

 arch/arm/dts/rk356x-u-boot.dtsi                 |   4 +
 arch/arm/include/asm/arch-rockchip/vop_rk3568.h | 249 ++++++++++++
 configs/pinetab2-rk3566_defconfig               |  15 +
 drivers/video/Kconfig                           |  10 +
 drivers/video/Makefile                          |   1 +
 drivers/video/boe-th101mb31ig002-28a.c          | 231 +++++++++++
 drivers/video/rockchip/Kconfig                  |   2 +-
 drivers/video/rockchip/Makefile                 |   4 +-
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c   |  26 +-
 drivers/video/rockchip/rk3568_hdmi.c            |  63 +++
 drivers/video/rockchip/rk3568_vop.c             | 214 ++++++++++
 drivers/video/rockchip/rk_vop2.c                | 519 ++++++++++++++++++++++++
 drivers/video/rockchip/rk_vop2.h                |  58 +++
 include/configs/quartz64_rk3566.h               |   5 +-
 14 files changed, 1383 insertions(+), 18 deletions(-)
---
base-commit: 6d41f0a39d6423c8e57e92ebbe9f8c0333a63f72
change-id: 20250114-vop2-pt2-755fb1991bb6

Best regards,
-- 
Dang Huynh <danct12@riseup.net>

