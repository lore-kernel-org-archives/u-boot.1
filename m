Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56004CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 21:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96BC78467E;
	Mon, 11 May 2026 23:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ZvNfaJBI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61A4F80086; Mon, 11 May 2026 23:38:12 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 748F980086
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 23:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62A462C3A;
 Mon, 11 May 2026 14:37:59 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 283E63F85F; Mon, 11 May 2026 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778535484; bh=ZuebneHLwwjWV2c6b/QFWASPVQ443WhMKbY6rAlQSdk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZvNfaJBIhWMFOXsxc3e1P7BZIFzF/wlocnorJc+Abb1AfDNQ61ie1oTXBgnJemX/L
 FYlcczzh5WqVKXbuoNoULpnTcWGQLKWl+2IUUFymm8GplWIgO//YCbXvcjlWvufQji
 7syzQ2ATwARrbfSsg6OA/mWEzcbdKA4k4hxm37CM=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Paul Kocialkowski <contact@paulk.fr>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 3/5] sunxi: spl: spi: Add support for Allwinner A523
Date: Mon, 11 May 2026 23:37:11 +0200
Message-ID: <20260511213713.15943-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260511213713.15943-1-andre.przywara@arm.com>
References: <20260511213713.15943-1-andre.przywara@arm.com>
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
---
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 905a7db2a77..25878026891 100644
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

