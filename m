Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E3DCD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 23:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D48A8489F;
	Sat, 16 May 2026 01:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qjjC6OCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0F784894; Sat, 16 May 2026 01:46:53 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7EF4B8488A
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D6E535EA;
 Fri, 15 May 2026 16:46:45 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 7BBF43F85F; Fri, 15 May 2026 16:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778888810; bh=/NquZCMpDtl2WHUGjub+KUXRUFIT5Xv4Qr8cMNgBzUw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qjjC6OCCG+OKETa9Pgfa+gsDR9+gKhH3c5/raYpCfYuxQNQzfpe8z7nFaXWoLi6Wj
 49/IqbxXfHNnh4s/auRF58qbpL6WU68NSWerv7WxDN1yOYWeu7f75iTDUbTaSe8JtQ
 jU2tCMhw47fKsc01O+5H745lH5UALuuMXDyqabgw=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Paul Kocialkowski <contact@paulk.fr>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 3/5] sunxi: spl: spi: Add support for Allwinner A523
Date: Sat, 16 May 2026 01:45:59 +0200
Message-ID: <20260515234601.15431-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260515234601.15431-1-andre.przywara@arm.com>
References: <20260515234601.15431-1-andre.przywara@arm.com>
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

The SPI IP in the Allwinner A523 is mostly compatible to the later
generation used in other Allwinner SoCs, at least as far as the SPL
driver is concerned.

Just add the pinmux configuration for SPI0 on PortC, as used by the
BROM. This enables SPI (NOR) boot on A523/A527/T527 boards.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 5cdf155d76a..6c9937128b9 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -113,6 +113,8 @@ static void spi0_pinmux_setup(unsigned int pin_function)
 	const u16 spi0_pc_pins[4] = {
 #if IS_ENABLED(CONFIG_MACH_SUN8I_R528)
 		SUNXI_GPC(2), SUNXI_GPC(3), SUNXI_GPC(4), SUNXI_GPC(5)
+#elif IS_ENABLED(CONFIG_MACH_SUN55I_A523)
+		SUNXI_GPC(2), SUNXI_GPC(3), SUNXI_GPC(4), SUNXI_GPC(12)
 #elif IS_ENABLED(CONFIG_MACH_SUN50I_H616)
 		SUNXI_GPC(0), SUNXI_GPC(2), SUNXI_GPC(3), SUNXI_GPC(4)
 #elif IS_ENABLED(CONFIG_MACH_SUN50I_H6)
@@ -250,7 +252,8 @@ static void spi0_init(void)
 	unsigned int pin_function = SUNXI_GPC_SPI0;
 
 	if (IS_ENABLED(CONFIG_MACH_SUN50I) ||
-	    IS_ENABLED(CONFIG_SUN50I_GEN_H6))
+	    IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
+	    IS_ENABLED(CONFIG_MACH_SUN55I_A523))
 		pin_function = SUN50I_GPC_SPI0;
 	else if (IS_ENABLED(CONFIG_MACH_SUNIV) ||
 		 IS_ENABLED(CONFIG_MACH_SUN8I_R528))
-- 
2.46.4

