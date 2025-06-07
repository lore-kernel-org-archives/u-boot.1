Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7281C61CE8
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 05:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A33EF82A7B;
	Sat,  7 Jun 2025 07:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="XeL7qGXk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FA91807B1; Sat,  7 Jun 2025 07:43:23 +0200 (CEST)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FA74826AA
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 07:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danct12@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4bDnCp3Hrxz9twc;
 Sat,  7 Jun 2025 05:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1749274998; bh=zUMVDTdkBCNzZ8Gu3ljnAHzmJAYR3cTom6zq6BrpB5s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XeL7qGXk14pdefJfe27OU7ZAM6Z9n7+r6nAc/K9UByO0xYRUOMsXpjwbuNgMiVhN7
 DRc/AAn8FRh39DGgqvcS1GjZrCdJmFYwQWbDswMeVAMafjXz8SvcL1oUHCcwn4otn8
 hrBsAT9H/KtPzH4upXrzFr368C8rVO2Sr2/z+W1Y=
X-Riseup-User-ID: AB979F8B3AA5AB2B9A18122DBCD306C301F09209612E3F104042BC4ABC28761C
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4bDnCl1QJGzJn3S;
 Sat,  7 Jun 2025 05:43:15 +0000 (UTC)
From: Dang Huynh <danct12@riseup.net>
Date: Sat, 07 Jun 2025 12:43:00 +0700
Subject: [PATCH v5 01/12] video: rockchip: dw-mipi-dsi: Depend on
 CONFIG_VIDEO_BRIDGE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-vop2-pt2-v5-1-1d52f7a2cf3c@riseup.net>
References: <20250607-vop2-pt2-v5-0-1d52f7a2cf3c@riseup.net>
In-Reply-To: <20250607-vop2-pt2-v5-0-1d52f7a2cf3c@riseup.net>
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

The driver is in video bridge class, so we must depend on it or
the driver will fail to init.

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 drivers/video/rockchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/rockchip/Kconfig b/drivers/video/rockchip/Kconfig
index 0f4550a29e38b2ab7f5e228894cfb2970cf5cc40..dfd08f1e5d146ee388949f6a621455a8712ebebe 100644
--- a/drivers/video/rockchip/Kconfig
+++ b/drivers/video/rockchip/Kconfig
@@ -72,7 +72,7 @@ config DISPLAY_ROCKCHIP_MIPI
 
 config DISPLAY_ROCKCHIP_DW_MIPI
 	bool "Rockchip Designware MIPI"
-	depends on VIDEO_ROCKCHIP
+	depends on VIDEO_ROCKCHIP && VIDEO_BRIDGE
 	select VIDEO_DW_MIPI_DSI
 	help
 	  Select the Designware MIPI DSI controller in use on some Rockchip

-- 
2.49.0

