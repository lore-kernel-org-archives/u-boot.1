Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B760CD98E1
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 02:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D58D5848D8;
	Wed, 17 Jun 2026 04:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="j058IUi1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="g0tcTLbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C35B8493A; Wed, 17 Jun 2026 04:45:21 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEBD2848A2
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 04:45:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gg7WL0QYJz9t8w;
 Wed, 17 Jun 2026 04:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781664318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JIMKv+LK9izpLO3BZ7zSsO06uEpMHLzxg2QuXK8wk7M=;
 b=j058IUi1f2oehBKZXlauJy9YleYmreqeOzsVEJrKI5RpTuLtRnGWTA507fC3g3nGomZKb/
 ypd0ZDaBhoQQGf2cj2+TUsh/3nzd8B0PELaK0H/BmTYmIHJT7B7biio35nyNjobMe2hs9g
 8MQkU9obI5TihGLm5ijmMDhZ2sZ+zqJUndBhskt9XU4atOt2IcyMacBV4pKZRlh/LpLGPV
 twhIIp55VMUDc13S5v2PNWu1cvVYfUPc9S387zBShoHTlCDvbj4yMn0DgEgJthukO6IlWv
 PTotWsZ8SpfIEreZ5OBMeajHXuEMyVlLv5QIJHX70qiPj8C7uf6gmI9G3o+pOA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=g0tcTLbF;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781664315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JIMKv+LK9izpLO3BZ7zSsO06uEpMHLzxg2QuXK8wk7M=;
 b=g0tcTLbFW7XLiXUqEXy2A+/WyW/Vq+Hn5sKL7jdy2bHFF2tWqcYB5zFQnTmLMxNQtdj5Hk
 65VTV1sJoYgsQF5Mzoxs6yVUyG30UGpV9tJLqi6Pxs9NAdZQMDNj4tVoRL/LJyPaDjRDUC
 D/HVdvGhx5bC3SUc28DMxJ8TBlrqXNHkW34OjG7bPZPgKlk5WZMwo4o92aWNGhUtYUusxq
 OA9m4IZoW1EbgvmVKsj/Mp/RcmpcupKQtSNT6MeajWmfuU1n/ObdGTPnCKC5LujTwKOkyf
 GK/MjE4xhWLbJH7e3VrJ7wqr/wVj7VFCrnQpcHL4UYarz/F13NGhgkq9F5fhTg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] MAINTAINERS: Replace STM32 and STPMIC with N:
Date: Wed, 17 Jun 2026 04:44:59 +0200
Message-ID: <20260617024511.153241-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 85f19840fc23ae310bf
X-MBO-RS-META: u3zwc9gsbsugpzz9u7d6ba18trimw9m8
X-Rspamd-Queue-Id: 4gg7WL0QYJz9t8w
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

Use N: to match on all stm/stm32/stpmic1 files, drop the large list of
entries which represent the same set of relevant files and miss a
few in the process.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com
Cc: u-boot@lists.denx.de
---
 MAINTAINERS | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index edab1622bc4..c862b206a85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -623,46 +623,12 @@ M:	Patrice Chotard <patrice.chotard@foss.st.com>
 L:	uboot-stm32@st-md-mailman.stormreply.com (moderated for non-subscribers)
 T:	git https://source.denx.de/u-boot/custodians/u-boot-stm.git
 S:	Maintained
-F:	arch/arm/mach-stm32mp/
 F:	doc/board/st/
-F:	drivers/adc/stm32-adc*
-F:	drivers/clk/stm32/
-F:	drivers/gpio/stm32_gpio.c
-F:	drivers/hwspinlock/stm32_hwspinlock.c
-F:	drivers/i2c/stm32f7_i2c.c
-F:	drivers/mailbox/stm32-ipcc.c
-F:	drivers/memory/stm32-omm.c
-F:	drivers/misc/stm32mp_fuse.c
-F:	drivers/misc/stm32_rcc.c
-F:	drivers/mmc/stm32_sdmmc2.c
-F:	drivers/mtd/nand/raw/stm32_fmc2_nand.c
-F:	drivers/phy/phy-stm32-usbphyc.c
-F:	drivers/pinctrl/pinctrl_stm32.c
-F:	drivers/power/pmic/stpmic1.c
-F:	drivers/power/regulator/stm32-vrefbuf.c
-F:	drivers/power/regulator/stpmic1.c
-F:	drivers/ram/stm32mp1/
-F:	drivers/remoteproc/stm32_copro.c
-F:	drivers/reset/stm32/
 F:	drivers/rng/optee_rng.c
-F:	drivers/rng/stm32_rng.c
-F:	drivers/rtc/stm32_rtc.c
-F:	drivers/serial/serial_stm32.*
-F:	drivers/spi/stm32_ospi.c
-F:	drivers/spi/stm32_qspi.c
-F:	drivers/spi/stm32_spi.c
-F:	drivers/video/stm32/stm32_ltdc.c
-F:	drivers/video/stm32/stm32_lvds.c
-F:	drivers/watchdog/stm32mp_wdt.c
-F:	include/dt-bindings/clock/stm32fx-clock.h
-F:	include/dt-bindings/clock/stm32mp*
-F:	include/dt-bindings/pinctrl/stm32-pinfunc.h
-F:	include/dt-bindings/reset/stm32mp*
-F:	include/stm32_rcc.h
 F:	tools/logos/st.bmp
-F:	tools/stm32image.c
 N:	stm
 N:	stm32
+N:	stpmic
 
 ARM SUNXI
 M:	Andre Przywara <andre.przywara@arm.com>
-- 
2.53.0

