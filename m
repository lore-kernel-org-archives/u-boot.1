Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A2BCD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 20:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47F0A84713;
	Thu, 21 May 2026 22:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BsO2xvQH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EkJ83HGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D209A846FA; Thu, 21 May 2026 22:17:52 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5A284874
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 22:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gM08G3HWjz9vWh;
 Thu, 21 May 2026 22:17:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779394670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u4OB4G0cCzJCosPoExybrWM4PVJh3mK7/0PbjarS5WA=;
 b=BsO2xvQHiBAJIlmP0Y+E+EC7ulF/LjoRa+wVzXQ3+Z4TuJKUzmx41jCNo7AcOWnU05d6ij
 9rdFJkjK/VftKA7O8PoJMS41yp84mWERg9awmv3UoJ76WiJMK+kSNU6n83zjn+/YKrxGXA
 GQTb3vrOnu/G8mrMprf5kqBqFutKJ831kcYUyYTA4RCiij6O6OM6SLI5FYaitUEYlnW7Wm
 JKCSTiu5jkGWYJohlI+e+rRuMjH1KRTUshEnHf1qp0sOfG15Q2U6H4+Ko2+1vkw+4s/sRU
 KtP1NcPrRxdsFbNNYKVkXW3wSKRi2qZ0+vG9/XiZLw5FaYwoNNQibo0zsFhlBg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=EkJ83HGG;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779394668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=u4OB4G0cCzJCosPoExybrWM4PVJh3mK7/0PbjarS5WA=;
 b=EkJ83HGGWNv0Nsa9oEgS/7tyPeC6LGy3Dm/4+9M4+mtqUSyCVJzWgbeH8RMxZvCQkaeUa9
 Jyn1HaBPVvWQJWTcKx4vXUrS4pK9DARyMN4mpJP4AgbhxNE4ml2FdsI0Vyk7dB4rceWsmg
 WlR5/N4Dz5wCu8BbAAg9HJz0xEOQf1Dhgmlg0RiSJIpj5VdGSvxljZRxdx02OzLthkVeFk
 YMcnDAPtmFjVSBiIWFHjgGNzjQ2Z1ZEHBu7djepWldgfSBUYGPXrnwn6jnV8AMwVYvT/9X
 4yGQcj+M4vxEkvLH5w9bhBWKLjcWoW50+8pibqfiObhuDju0DV4le0R0bIwyCg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] MAINTAINERS: Replace Amlogic Meson with N:
Date: Thu, 21 May 2026 22:17:29 +0200
Message-ID: <20260521201745.43997-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cb7ac008a357675ce42
X-MBO-RS-META: kjw7nz94icjd3ud18n1ur5buiu4nqe1q
X-Rspamd-Queue-Id: 4gM08G3HWjz9vWh
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

Use N: to match on all amlogic/meson files, drop the large list of
entries which represent the same set of relevant files and miss a
few in the process.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 MAINTAINERS | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5eba287a980..4c52a9645b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -160,27 +160,8 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 S:	Maintained
 L:	u-boot-amlogic@groups.io
 T:	git https://source.denx.de/u-boot/custodians/u-boot-amlogic.git
-F:	arch/arm/mach-meson/
-F:	arch/arm/include/asm/arch-meson/
-F:	cmd/meson/
-F:	drivers/clk/meson/
-F:	drivers/serial/serial_meson.c
-F:	drivers/reset/reset-meson.c
-F:	drivers/i2c/meson_i2c.c
-F:	drivers/net/phy/meson-gxl.c
-F:	drivers/adc/meson-saradc.c
-F:	drivers/phy/meson*
-F:	drivers/mmc/meson_gx_mmc.c
-F:	drivers/sm/meson-sm.c
-F:	drivers/spi/meson_spifc.c
-F:	drivers/pinctrl/meson/
-F:	drivers/power/domain/meson-gx-pwrc-vpu.c
-F:	drivers/video/meson/
-F:	drivers/watchdog/meson_gxbb_wdt.c
-F:	include/configs/meson64.h
-F:	include/configs/meson64_android.h
 F:	tools/amlimage*
-F:	doc/board/amlogic/
+N:	amlogic
 N:	meson
 
 ARM ASPEED
-- 
2.53.0

