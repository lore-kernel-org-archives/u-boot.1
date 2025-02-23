Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199F9C021B2
	for <u-boot@archiver.kernel.org>; Sun, 23 Feb 2025 12:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B08680FB6;
	Sun, 23 Feb 2025 13:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="p53z+EGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83C1480FD1; Sun, 23 Feb 2025 13:14:02 +0100 (CET)
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7898880FB6
 for <u-boot@lists.denx.de>; Sun, 23 Feb 2025 13:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx1.riseup.net (Postfix) with ESMTPS id 4Z12pZ3xThzDqLj;
 Sun, 23 Feb 2025 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1740312838; bh=2s4hrR8quNh9gnlwJj0OpXMiEJyOwcW/KFda204l/YU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=p53z+EGDySh5aFcX6+YyhmvDwLy61iH7P06809TXZB9gyUhzBbUJ0xUE+h8gayyL1
 r/ir4xHc8A+/GhATEXImnMWu46LDUHl+0ODVmp3wHfuSN5MO+A5hZoN0BTL8rTXMO5
 OUQ9AeXRFPPlbj7uPMV8kxKwZCmyPlpwCOPc0/VI=
X-Riseup-User-ID: 90DAD60E11FBD2E9BFD90E938A36817579A1CA768FAD6CB044E01B631B03D949
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Z12pV59WyzJtjY;
 Sun, 23 Feb 2025 12:13:54 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sun, 23 Feb 2025 19:13:36 +0700
Subject: [PATCH v2 01/11] video: rockchip: dw-mipi-dsi: Depend on
 CONFIG_VIDEO_BRIDGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-vop2-pt2-v2-1-71350e482970@riseup.net>
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
In-Reply-To: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
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

The driver is in video bridge class, so we must depend on it or
the driver will fail to init.

Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/video/rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/rockchip/Kconfig b/drivers/video/rockchip/Kconfig
index 01804dcb1cc8743e738d32540bea6c8539e51ab4..72fcd6715a69e522f2ba6e8de9c1a923106ca10f 100644
--- a/drivers/video/rockchip/Kconfig
+++ b/drivers/video/rockchip/Kconfig
@@ -71,7 +71,7 @@ config DISPLAY_ROCKCHIP_MIPI
 
 config DISPLAY_ROCKCHIP_DW_MIPI
 	bool "Rockchip Designware MIPI"
-	depends on VIDEO_ROCKCHIP
+	depends on VIDEO_ROCKCHIP && VIDEO_BRIDGE
 	select VIDEO_DW_MIPI_DSI
 	help
 	  Select the Designware MIPI DSI controller in use on some Rockchip

-- 
2.48.1

