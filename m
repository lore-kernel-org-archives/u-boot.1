Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D779C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 16:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90FA48215B;
	Mon,  5 May 2025 18:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="N1YrfI4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6435382163; Mon,  5 May 2025 18:58:48 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E92820EB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 18:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4ZrnmL4l8Cz9wmy;
 Mon,  5 May 2025 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1746464323; bh=eBvUp22VIKoopu5kje3iFUx50BsWAxgeMJrtA0guYhs=;
 h=From:Subject:Date:To:Cc:From;
 b=N1YrfI4UWXBRRvZttbIXLn1lxnU49e8nfaw55I1uBaaZ0pkR9m7HLZA1s9zK2eUpo
 4e7KKo7T8pTsAfXJzj7HBz+ZtEpb3q8TGqSpirQL5K8Gj59HZfzjZvIwDRNHL1JVWY
 neZ5A7Q6XcsqNh3eLsIxR+lgYR9IZH20b1jHye1k=
X-Riseup-User-ID: 17B4653CF4377CD487998075565CE4945C34558EBBD30DB253068ABCDAC8EA05
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4ZrnmG0vwVzJp9k;
 Mon,  5 May 2025 16:58:37 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Subject: [PATCH v4 00/12] Rockchip VOP2 support
Date: Mon, 05 May 2025 23:58:16 +0700
Message-Id: <20250505-vop2-pt2-v4-0-3b7c3ab1a617@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjuGGgC/2XMTQ6CMBCG4auQrq1pp3/WlfcwLiwM0g00LTYaw
 t0tJAaMy28yzzuRhNFjIudqIhGzT37oy5CHitTdvX8g9U3ZBBgoxrmkeQhAwwjUKNU6bi13TpP
 yHiK2/rWmrreyO5/GIb7XcubL9RvRWyRzymhtGy21U8IKdok+4TMcexzJUsmwSQCxk1Ck4UIxl
 Cew5l+KTUoOOykWWRurGyeEQvsj53n+AKtLO2gVAQAA
X-Change-ID: 20250114-vop2-pt2-755fb1991bb6
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, u-boot@lists.denx.de, 
 Piotr Zalewski <pZ010001011111@proton.me>, Dang Huynh <danct12@riseup.net>
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

PATCH 4 and 7 requires get_display_timing patch[1]. This patch should
should now be in master.

There is a regression in clk_enable() call which breaks set_parent(),
it is recommended to apply [2] for this series to work properly.

[1]: https://lore.kernel.org/u-boot/20250220170629.228485-1-clamor95@gmail.com
[2]: https://lore.kernel.org/u-boot/20250419090718.2469756-1-jonas@kwiboo.se

Tested-by: Piotr Zalewski <pZ010001011111@proton.me>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
Changes in v4:
- Remove unnecessary clk_enable() as VOP clocks are enabled by TF-A
- Adjust I2C clock configuration to match 24 MHz clock
- Reorganize VOP node order
- Link to v3: https://lore.kernel.org/r/20250412-vop2-pt2-v3-0-7c796db335e9@riseup.net

Changes in v3:
- Renaming prefix from "rkvop" to "rkvop2" and similar
- Win planes are platform-configurable
- Link to v2: https://lore.kernel.org/r/20250223-vop2-pt2-v2-0-71350e482970@riseup.net

Changes in v2:
- Get display timings from video bridge (requires [1])
- Disable esmart and post before booting to OS
- Enable avdd-0v9 and avdd-1v8 when probing HDMI.
- Link to v1: https://lore.kernel.org/r/20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net

---
Dang Huynh (10):
      video: rockchip: dw-mipi-dsi: Depend on CONFIG_VIDEO_BRIDGE
      video: rockchip: dw-mipi-dsi: Add get_display_timing support
      video: Add BOE TH101MB31IG002-28A MIPI-DSI panel
      video: rockchip: Add VOP2 support
      video: rockchip: vop2: Add video bridge support
      dts: rockchip: rk356x: Prerelocate VOP in U-Boot proper
      configs: quartz64: Enable vidconsole
      video: rockchip: Add HDMI support for RK3568
      configs: pinetab2-rk3566: Enable video and USB keyboard
      clk: rockchip: rk3568: Use assigned VPLL clock when possible

Ondrej Jirman (2):
      video: rockchip: dw_mipi_dsi: Improve pixel clock calculations
      video: rockchip: dw_mipi_dsi: Proceed when external PHY is not defined

 arch/arm/dts/rk356x-u-boot.dtsi                 |   4 +
 arch/arm/include/asm/arch-rockchip/vop_rk3568.h | 280 ++++++++++++
 configs/pinetab2-rk3566_defconfig               |  10 +
 drivers/clk/rockchip/clk_rk3568.c               |   6 +-
 drivers/video/Kconfig                           |  10 +
 drivers/video/Makefile                          |   1 +
 drivers/video/boe-th101mb31ig002-28a.c          | 236 ++++++++++
 drivers/video/rockchip/Kconfig                  |   2 +-
 drivers/video/rockchip/Makefile                 |   4 +-
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c   |  45 +-
 drivers/video/rockchip/rk3568_hdmi.c            |  71 +++
 drivers/video/rockchip/rk3568_vop.c             | 260 +++++++++++
 drivers/video/rockchip/rk_vop2.c                | 554 ++++++++++++++++++++++++
 drivers/video/rockchip/rk_vop2.h                |  76 ++++
 include/configs/quartz64_rk3566.h               |   5 +-
 15 files changed, 1541 insertions(+), 23 deletions(-)
---
base-commit: 9dbe8d889546efd6c1a3470092588b9b6820158f
change-id: 20250114-vop2-pt2-755fb1991bb6

Best regards,
-- 
Dang Huynh <danct12@riseup.net>

