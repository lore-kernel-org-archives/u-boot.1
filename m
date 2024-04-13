Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66E0C4345F
	for <u-boot@archiver.kernel.org>; Sat, 13 Apr 2024 18:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A229488233;
	Sat, 13 Apr 2024 20:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Bm3YK8/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881C588225; Sat, 13 Apr 2024 20:15:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C92E8822D
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 20:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ef8c=LT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713032131; bh=EITcr7M67b/zFOMPKGnLUQkJzc/T1PX6CVRrmeHXoSM=;
 b=Bm3YK8/Q9jjVUFKr9FdNsQtCQuILSBchU5Vwi9N796FXrmTNJhlXxVPHEYu0BG1BZe7RFhuy7
 ErgJO/jKZuW+rVyw5ONWOdgFMrZs8K73CYEEpWTeucwyajJZPl8wb80WJ7Av429c0YEP8NABsKF
 1T7kvPguUN5gBawt60VNEzW8VziPLuxmcZI3IkQIAb203mPKES2nzsyw+niQaJ5Ek1wX3ljxg3l
 +44va9tOknCvc8nwcWioNJfXEVayxcTRQdnH1R69WZrYFoeLWKsU5GfiL/44yxV2RnvacwTlxDv
 Q1VOt4wB7mQUbqvlksNwCY+OYAKqUa4/YjZb4oh4+UKg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Elon Zhang <zhangzj@rock-chips.com>,
 Weizhao Ouyang <weizhao.ouyang@arm.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 15/23] rockchip: rk3588-toybrick: Add missing Kconfig
 options
Date: Sat, 13 Apr 2024 18:13:49 +0000
Message-ID: <20240413181425.1384357-16-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240413181425.1384357-1-jonas@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661acbc26fbb975d49a654d9
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

Add .dtb-file entry to Makefile and enable Kconfig options required to
configure pinctrl in SPL. Also add missing PHY_ROCKCHIP_NANENG_COMBOPHY.

Fixes: 9fdd9a546986 ("board: rockchip: add Rockchip Toybrick TB-RK3588X board")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Fix Makefile entry from .dts to .dtb (Quentin)
---
 arch/arm/dts/Makefile             | 1 +
 configs/toybrick-rk3588_defconfig | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 38d259a7035c..d5393429f6c5 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -180,6 +180,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
 	rk3588-quartzpro64.dtb \
 	rk3588s-rock-5a.dtb \
 	rk3588-rock-5b.dtb \
+	rk3588-toybrick-x0.dtb \
 	rk3588-turing-rk1.dtb
 
 dtb-$(CONFIG_ROCKCHIP_RV1108) += \
diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 38fc7906eef2..0168e014103e 100644
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
@@ -53,6 +54,8 @@ CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_SPL_PINCTRL=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
-- 
2.43.2

