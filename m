Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36440F357DB
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B63CD8366F;
	Wed, 25 Feb 2026 08:28:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hJS3r2Ur";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47D8583946; Wed, 25 Feb 2026 08:28:21 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 751E582A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id AA1C43F264; 
 Wed, 25 Feb 2026 07:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772004499;
 bh=hlk9HyQFLq8aQ7doGLflkwGevmgnNI7fmGo5Cu6+Qa8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hJS3r2Urw9FAZxEKmkXi1zIf7qgtg9bnpcqLOk9MIw+vPkO8zUyiSR8+HrKDbRdvi
 xxNQ7Q/b9MBpnKTOE6eWUs1ZccJijglTz0wupyPBpO/r+vBiLSVwSTmyxhpaZd4Z7f
 A3koDNOTqY1VvjUhXYnjT4aG0LcbQrH273bDxXunoUBtQZZLStLBUDyFGGSYxT8RA/
 9yoQPb95pY33Kc7TODcgEipU1a/riXPgt8/HxCS9t3prFuXDWFE8eVHU1Gqq1vAp9R
 4O9wWHDnasYKGZh+MrslmWUx9C3R5xdZ1NvsYn8cvBB/6Qy9FuaEAhcDsAQ9jhd0jM
 MNaCJRGdni1CNgh7ktVzAYPyNtNiC5jktA0kJI66XD2iLY4xtnAlnzG41UPkgFL+WD
 VeRlB/5258aYfxIdEL8wmf3L72l3sg7qFTj1rvN3Clsip3BY+ffQXnp2MYrunkd0Jq
 v1JKfAsL5OFvBKmGeGNvo/A/a1/O0kBgIbgvSo3NH+uqBn3mV2u++BbZqGBw16PJYt
 mA4emLewAtrwnMvD8kU25+2fG+1NP6I8Viwv76rIzWbvrW+kWJMJvMOR+jcXptNw6i
 Baet/cc/GqjM8UOmUJjB9as+AUgXP148eXuxc42+sA4gQtIE3tId3GVoAViUoSCWM5
 av2SpSebL3EQ7zugF/e2Q8q8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] arm: rockchip: don't use non-existent
 CONFIG_TPL_TINY_FRAMEWORK
Date: Wed, 25 Feb 2026 08:28:17 +0100
Message-ID: <20260225072817.50994-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Symbol CONFIG_TPL_TINY_FRAMEWORK does not exist.
Don't select it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/mach-rockchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 92bb4aa62f1..d00820b34bb 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -8,7 +8,6 @@ config ROCKCHIP_PX30
 	select SUPPORT_TPL
 	select SPL
 	select TPL
-	select TPL_TINY_FRAMEWORK if TPL
 	select TPL_HAVE_INIT_STACK if TPL
 	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
-- 
2.51.0

