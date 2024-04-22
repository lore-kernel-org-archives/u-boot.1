Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDA3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 305B78839F;
	Mon, 22 Apr 2024 08:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="bjiTWbal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3EAB883AB; Mon, 22 Apr 2024 08:31:03 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48CCD88381
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767449; bh=VyztOiHe5h2tvfA7K6gC3D0x3WLDTPPg24tcb4jq474=;
 b=bjiTWbalkJLV0WDQQIkuJOs2+dNw5kmi23QfA0I6caGw1Twa0XbqBJ9V+cXn+e+zsMPvId9gY
 V2fKuFWqOTuBYdhAArs+GEXre5+4Qrjm4Tl/vZlHwYbtWWieQTQo2FVpwz+RIDOZ5cqWFb+MC3X
 bk00ThMddNQ6jbhij9AWv0xc22B8z+PLOaQTnvBLdA8IcZyPnprNGOjC10ARFflRDrql4PGsHa4
 BO5oNzM0y3XG3JgJtHFLKT5Hw4f9NW20iYjcWhBz3+C5ETRTxI2o1A8asxi7HcMrMZD5Pl5vMkM
 R9wFRjOhcdJ56xRguuWMSw657eRENhxm0WzKi560Qk2w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Weizhao Ouyang
 <weizhao.ouyang@arm.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 19/28] rockchip: rk3588-toybrick: Use pinctrl and aliases
 in SPL
Date: Mon, 22 Apr 2024 06:28:56 +0000
Message-ID: <20240422062936.681359-20-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6626041834ba165ad44743f3
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

Pinctrl must be configured for eMMC, SD-card and SPI flash to
successfully read FIT from all possible fallback media in SPL.

Include pinctrl props and enable the SPL_PINCTRL Kconfig option to
ensure FIT can be loaded from eMMC, SD-card and SPI flash.

Also enable the SPL_DM_SEQ_ALIAS Kconfig option to ensure that the
storage device sequence number matches in both SPL and U-Boot proper.

Fixes: 9fdd9a546986 ("board: rockchip: add Rockchip Toybrick TB-RK3588X board")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: Drop PHY_ROCKCHIP_NANENG_COMBOPHY, usb3/sata/pcie is not enabled
v3: Split Makefile changes to a separate patch
v2: Fix Makefile entry from .dts to .dtb (Quentin)
---
 configs/toybrick-rk3588_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 38fc7906eef2..8d773603db0b 100644
--- a/configs/toybrick-rk3588_defconfig
+++ b/configs/toybrick-rk3588_defconfig
@@ -33,8 +33,9 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
@@ -53,6 +54,7 @@ CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
-- 
2.43.2

