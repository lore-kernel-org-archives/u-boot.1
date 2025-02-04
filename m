Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D793C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:30:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52DA4800B3;
	Tue,  4 Feb 2025 18:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u1jW/fU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA550801DE; Tue,  4 Feb 2025 18:30:08 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E88FD80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wens@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A70C25C5EC7;
 Tue,  4 Feb 2025 17:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02785C4CEDF;
 Tue,  4 Feb 2025 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738690204;
 bh=5EYOvzuVjHGDRh1LED+di92vh0c497NVycSHNXFb524=;
 h=From:To:Cc:Subject:Date:From;
 b=u1jW/fU/G284g9fC7OljEg/3wU7FfWWmRl7jJwocEOff9MNqsl6WfgjG+wO9zJo3C
 pk8eC65qqCp5EjxVNHEn7X/aFP5zzK/4Zkl0ljPC/nwCjp7qaHEnIO+1vLvsVU/K6m
 QTpV0wYRm8doSPqbMeogBVbeJ2N2gH6gEQ0kg8nnLFsXhS0Dc5tH/FplgeymHldF88
 6p+ryQFsFQYnaAgDFC+CeevbwU9ttpaV75gXIsOf9yjwVJzt5/odp7yvFjL8I6f53Y
 QdDgjEwdyzGe+FNchBBEF5fzrEPFFbnfORPZAd5H/CP6CoTUcu+ba4y0EZmNnYB16o
 csuyePEz3RxdQ==
Received: by wens.tw (Postfix, from userid 1000)
 id F35135FB49; Wed,  5 Feb 2025 01:29:59 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] rockchip: rk3399: grf: Fix enum typos for UART2
Date: Wed,  5 Feb 2025 01:29:53 +0800
Message-Id: <20250204172954.3364927-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Chen-Yu Tsai <wens@csie.org>

In the GRF header file, some instances of UART2 pinmux are prefixed with
"GRF_UART2DBG" while others have "GRF_UART2DGB".

Since UART2 is the default console UART and used for debugging, it is
more likely the name should be UART2DBG.

Fix the ones that are wrong.

Fixes: a2c08df3813b ("pinctrl: add driver for rk3399")
Fixes: fa72de10452c ("rockchip: arm64: rk3399: move grf register definitions to grf_rk3399.h")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

 arch/arm/include/asm/arch-rockchip/grf_rk3399.h | 6 +++---
 arch/arm/mach-rockchip/rk3399/rk3399.c          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/arch-rockchip/grf_rk3399.h b/arch/arm/include/asm/arch-rockchip/grf_rk3399.h
index dd89cd205056..e6125d6bf540 100644
--- a/arch/arm/include/asm/arch-rockchip/grf_rk3399.h
+++ b/arch/arm/include/asm/arch-rockchip/grf_rk3399.h
@@ -466,18 +466,18 @@ enum {
 	/*  GRF_GPIO4C_IOMUX */
 	GRF_GPIO4C0_SEL_SHIFT   = 0,
 	GRF_GPIO4C0_SEL_MASK    = 3 << GRF_GPIO4C0_SEL_SHIFT,
-	GRF_UART2DGBB_SIN       = 2,
+	GRF_UART2DBGB_SIN       = 2,
 	GRF_HDMII2C_SCL         = 3,
 	GRF_GPIO4C1_SEL_SHIFT   = 2,
 	GRF_GPIO4C1_SEL_MASK    = 3 << GRF_GPIO4C1_SEL_SHIFT,
-	GRF_UART2DGBB_SOUT      = 2,
+	GRF_UART2DBGB_SOUT      = 2,
 	GRF_HDMII2C_SDA         = 3,
 	GRF_GPIO4C2_SEL_SHIFT   = 4,
 	GRF_GPIO4C2_SEL_MASK    = 3 << GRF_GPIO4C2_SEL_SHIFT,
 	GRF_PWM_0               = 1,
 	GRF_GPIO4C3_SEL_SHIFT   = 6,
 	GRF_GPIO4C3_SEL_MASK    = 3 << GRF_GPIO4C3_SEL_SHIFT,
-	GRF_UART2DGBC_SIN       = 1,
+	GRF_UART2DBGC_SIN       = 1,
 	GRF_GPIO4C4_SEL_SHIFT   = 8,
 	GRF_GPIO4C4_SEL_MASK    = 3 << GRF_GPIO4C4_SEL_SHIFT,
 	GRF_UART2DBGC_SOUT      = 1,
diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 1ce43c6f0d40..562d666ea092 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -136,7 +136,7 @@ void board_debug_uart_init(void)
 	/* Enable early UART2 channel C on the RK3399 */
 	rk_clrsetreg(&grf->gpio4c_iomux,
 		     GRF_GPIO4C3_SEL_MASK,
-		     GRF_UART2DGBC_SIN << GRF_GPIO4C3_SEL_SHIFT);
+		     GRF_UART2DBGC_SIN << GRF_GPIO4C3_SEL_SHIFT);
 	rk_clrsetreg(&grf->gpio4c_iomux,
 		     GRF_GPIO4C4_SEL_MASK,
 		     GRF_UART2DBGC_SOUT << GRF_GPIO4C4_SEL_SHIFT);
-- 
2.39.5

