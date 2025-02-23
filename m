Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0E6C021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D61D480FBC;
	Sun, 23 Feb 2025 13:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="klsmJt+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 974B380F56; Sun, 23 Feb 2025 13:14:00 +0100 (CET)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFFBF80F56
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:13:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4Z12pV2S0KzDqbf;
 Sun, 23 Feb 2025 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1740312834; bh=4Gv2nzuyLuRNg128xLKluwrVmh6TJec0/um6IDxzT/M=;
 h=From:Subject:Date:To:Cc:From;
 b=klsmJt+x1nPPihQMA+M0AMutZDFaZiPj3Gm8Pzigyoqyufl3VuqyYmRPh0OEE62Vj
 Qd5R1egli0AZ76pLyMjWhOeS3WbphUNkOAL5fD+6LyEAT/ila1eq2atM502S1BjxRZ
 EA06V5RuqJeF3D1rCRHTDJOnQoWQ4vmkLHP7IFKY=
X-Riseup-User-ID: D940F196FFC03F891CC768BB001111A19EA17EF1F93E8ECBCA2F933C9A7E9E82
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Z12pP3L5dzJtjX;
 Sun, 23 Feb 2025 12:13:49 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Subject: [PATCH v2 00/11] Rockchip VOP2 support
Date: Sun, 23 Feb 2025 19:13:35 +0700
Message-Id: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO8Qu2cC/0XMQQ7CIBCF4as0sxYDtGBw1XuYLqSd2tkAASSah
 ruLTYzL/+Xl2yFhJExw7XaIWCiRdy3kqYN5u7sHMlpag+RScSEGVnyQLGTJLkqtVhgjrNXQ7iH
 iSq+Duk2tN0rZx/chF/Fdf4j+I0Uwzmaz6EFb1Zuej5ESPsPZYYap1voBYJs3LKEAAAA=
X-Change-ID: 20250114-vop2-pt2-755fb1991bb6
To: Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Ondrej Jirman <megi@xff.cz>, 
 Dragan Simic <dsimic@manjaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Dang Huynh <danct12@riseup.net>
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

PATCH 4 and 7 requires get_display_timing patch[1]. Until that patch
gets into master, the patches can be merged.

[1]: https://lore.kernel.org/u-boot/20250220170629.228485-1-clamor95@gmail.com

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
Changes in v2:
- Get display timings from video bridge (requires [1])
- Disable esmart and post before booting to OS
- Enable avdd-0v9 and avdd-1v8 when probing HDMI.
- Link to v1: https://lore.kernel.org/r/20250116-vop2-pt2-v1-0-c9d646b53930@riseup.net

---
Dang Huynh (9):
      video: rockchip: dw-mipi-dsi: Depend on CONFIG_VIDEO_BRIDGE
      video: rockchip: dw-mipi-dsi: Add get_display_timing support
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
 configs/pinetab2-rk3566_defconfig               |  11 +
 drivers/video/Kconfig                           |  10 +
 drivers/video/Makefile                          |   1 +
 drivers/video/boe-th101mb31ig002-28a.c          | 236 +++++++++++
 drivers/video/rockchip/Kconfig                  |   2 +-
 drivers/video/rockchip/Makefile                 |   4 +-
 drivers/video/rockchip/dw_mipi_dsi_rockchip.c   |  45 ++-
 drivers/video/rockchip/rk3568_hdmi.c            |  71 ++++
 drivers/video/rockchip/rk3568_vop.c             | 247 ++++++++++++
 drivers/video/rockchip/rk_vop2.c                | 514 ++++++++++++++++++++++++
 drivers/video/rockchip/rk_vop2.h                |  59 +++
 include/configs/quartz64_rk3566.h               |   5 +-
 14 files changed, 1436 insertions(+), 22 deletions(-)
---
base-commit: 313b9856f95419b01df7cc6b9a16f7b07d9fe13c
change-id: 20250114-vop2-pt2-755fb1991bb6

Best regards,
-- 
Dang Huynh <danct12@riseup.net>

