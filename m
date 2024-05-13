Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8755C25B78
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 23:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD6187D08;
	Tue, 14 May 2024 01:43:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OYiHstEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DE6B87C75; Tue, 14 May 2024 01:43:35 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60BB487B30
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 01:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 094EE60FC3;
 Mon, 13 May 2024 23:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEABC113CC;
 Mon, 13 May 2024 23:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715643811;
 bh=aFlPkVmPzw5ys2UVVqjXBVtvSMl+s6grfOSm5CCcQto=;
 h=From:To:Cc:Subject:Date:From;
 b=OYiHstEFctSbEN+U0I+pQifC3ac+EeVUmW/LDmFDkY7Qh5stKdlBmTbrNCH9h+GCu
 I6J4E0nmuST6/uufXQ5JA/N/HtE1By8g1cCUs4+K8pcdJ9KK19ZS72QqGkvj/VStCW
 D1k5edaO8XyP08bAYG/wMiDzfw9G6maVGoPCyNz4YQGvTWEwbgppMQu0K4ZjWZ8qQB
 7hQtfpgHOpKu++0YGgBM8YtqIt0JNw71D3rY1EvAxCLrrtgU70EHyBKGqora7z3nQG
 85bRnDlIU1ixdEdtp3e3yV4/dwd2XiwsIlLEt0enqjcbCZ+m0HIMnZo9YtAyWoGtih
 pAKbUwfN3RoIg==
From: Michael Walle <mwalle@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] sunxi: SPL SPI: add support for the V3s SoC
Date: Tue, 14 May 2024 01:43:19 +0200
Message-Id: <20240513234319.1966434-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
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

The V3s is identical regarding register layout, clocks and resets to
the sun6i variants. Therefore, we can just add the MACH_SUN8I_V3S to
the sun6i compatible ones.

SPI boot was tested on a custom board with a Gigadevice GD25Q64 8MiB
SPI flash.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/arm/mach-sunxi/Kconfig         | 2 +-
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ddf9414b08e..17666814c52 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1078,7 +1078,7 @@ config SPL_STACK_R_ADDR
 
 config SPL_SPI_SUNXI
 	bool "Support for SPI Flash on Allwinner SoCs in SPL"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_R40 || MACH_SUN8I_V3S || SUN50I_GEN_H6 || MACH_SUNIV || SUNXI_GEN_NCAT2
 	help
 	  Enable support for SPI Flash. This option allows SPL to read from
 	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 7acb44f52ae..d7abdc2e401 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -140,7 +140,8 @@ static bool is_sun6i_gen_spi(void)
 {
 	return IS_ENABLED(CONFIG_SUNXI_GEN_SUN6I) ||
 	       IS_ENABLED(CONFIG_SUN50I_GEN_H6) ||
-	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2);
+	       IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2) ||
+	       IS_ENABLED(CONFIG_MACH_SUN8I_V3S);
 }
 
 static uintptr_t spi0_base_address(void)
-- 
2.39.2

