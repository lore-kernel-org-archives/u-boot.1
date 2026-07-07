Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2700C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD8984A90;
	Tue,  7 Jul 2026 18:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="UsRHK2e4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B846584A5B; Tue,  7 Jul 2026 18:09:45 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::8fa9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48339849BA
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQG24jxzZ4;
 Tue,  7 Jul 2026 18:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440582;
 bh=Bc6GTahNdoCPZHUsL90w2pjpqHymQYC0QRsQdO0Lp7I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UsRHK2e4TTr0l89BCbiR137Yyrz8Er/53ZWX6wBPW6fR8R/I2cWXcddIWgHUtIESi
 CffRz6S0U8KgsEQWzLNnwB582teyvhNLG4E7wyvAdxeR4oDIAPkB2oCoewFeBX+X26
 NQAvvub4w6/JooU5ukKPttw+K+NqH3PTrArmL95LTguXkVybkySJ7JocjxxHeDUr12
 NAZs90TdRDYjU55vnP5/ZDj6H8lvt0+/OWYgyGpDcy5cKcQF1Ogr9CrMUMXxW1xwwg
 nmQjdFoWmngrIHp8UTmcjQf0bgOUtY5jcIPej8QQVjyO9tgy/KleYn00j9PYiAaTY6
 9IX9xZje48ogQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQF2MBNzZdw; Tue,  7 Jul 2026 18:09:41 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Date: Tue, 07 Jul 2026 18:09:15 +0200
Subject: [PATCH 01/12] MAINTAINERS: remove redundant entries for ARM ROCKCHIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-rk-custodian-v1-1-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
In-Reply-To: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
To: u-boot@lists.denx.de
Cc: Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <u-boot@0leil.net>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Tue, 07 Jul 2026 18:37:14 +0200
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

The ARM ROCKCHIP entry already specifies an N: rockchip so we don't need
to repeat a path with F: if it has rockchip in the path, so drop it.

Note that for some reason get_maintainer.pl doesn't return the exact
same list before and after this patch.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
 MAINTAINERS | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45e9076de671..e2c78ce39161 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -574,12 +574,10 @@ M:	Philipp Tomsich <philipp.tomsich@vrull.eu>
 M:	Kever Yang <kever.yang@rock-chips.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-rockchip.git
+N:	rockchip
 F:	arch/arm/dts/px30*
 F:	arch/arm/dts/rk3*
-F:	arch/arm/dts/rockchip*
 F:	arch/arm/dts/rv11*
-F:	arch/arm/include/asm/arch-rockchip/
-F:	arch/arm/mach-rockchip/
 F:	board/amarula/vyasa-rk3288/
 F:	board/anbernic/rgxx3_rk3566/
 F:	board/armsom/sige7-rk3588/
@@ -590,25 +588,14 @@ F:	board/mqmaker/miqi_rk3288/
 F:	board/phytec/phycore_rk3288
 F:	board/pine64
 F:	board/radxa/
-F:	board/rockchip/
 F:	board/theobroma-systems
 F:	board/vamrs/rock960_rk3399/
-F:	drivers/clk/rockchip/
 F:	drivers/gpio/rk_gpio.c
-F:	drivers/misc/rockchip-efuse.c
-F:	drivers/mmc/rockchip_sdhci.c
-F:	drivers/mmc/rockchip_dw_mmc.c
-F:	drivers/pinctrl/rockchip/
-F:	drivers/ram/rockchip/
-F:	drivers/sysreset/sysreset_rockchip.c
-F:	drivers/ufs/*rockchip*
-F:	drivers/video/rockchip/
 F:	tools/rkcommon.c
 F:	tools/rkcommon.h
 F:	tools/rkimage.c
 F:	tools/rksd.c
 F:	tools/rkspi.c
-N:	rockchip
 
 ARM SAMSUNG
 M:	Minkyu Kang <mk7.kang@samsung.com>

-- 
2.55.0

