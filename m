Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A04C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA0BB8835A;
	Mon, 22 Apr 2024 08:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="C1LIW2YX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 930BA88329; Mon, 22 Apr 2024 08:30:24 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0435F88354
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767402; bh=2I5r/LfwxR0pE1GUOH3TxjU1vSUeWQLEh7XHvREh+Ag=;
 b=C1LIW2YXwHnAa1T/tBKctiNSA7bMwVp4qEUayT4sDwgXooUK99oF/hP6pUaDcpClD7TjA+vEN
 CAb4HKgeZSXw3yNzEzOP2qw6u9k+ASzWSZXGGvFX7RroSAJjfKBkpfpBEkPJfPFfl/B2oMWEb0M
 4XWzTPuAi0PTq/OnO2E0KJbfo2BzZ61L2ejUYCoLpZFyGdSP6Nbt8lQxPEnZI2+nsDkuXE4T1Qw
 5s8oukhFaOzP9zOq/Z3gKXRP9lhkriE2A1MELg0pGG86fxwqU1c4TAzR/7UNcxL9SRuBRZhSTyf
 t37/fZLweyNTNr1VGleOJQpzuChcnZNRucd2Ls4Pt1tQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jagan Teki <jagan@edgeble.ai>, Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
 Eugen Hristev <eugen.hristev@collabora.com>, Jonas Karlman
 <jonas@kwiboo.se>, Elon Zhang <zhangzj@rock-chips.com>, Joshua Riek
 <jjriek@verizon.net>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 05/28] rockchip: rk3588: Drop REGULATOR_PWM Kconfig option
Date: Mon, 22 Apr 2024 06:28:42 +0000
Message-ID: <20240422062936.681359-6-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 662603e934ba165ad44742b9
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

RK3588 boards do not have any pwm-regulator compatible nodes in DT, drop
the superfluous REGULATOR_PWM Kconfig options.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
v3: Collect r-b tag
v2: No change
---
 configs/evb-rk3588_defconfig         | 1 -
 configs/neu6a-io-rk3588_defconfig    | 1 -
 configs/neu6b-io-rk3588_defconfig    | 1 -
 configs/quartzpro64-rk3588_defconfig | 1 -
 configs/rock5b-rk3588_defconfig      | 1 -
 configs/toybrick-rk3588_defconfig    | 1 -
 configs/turing-rk1-rk3588_defconfig  | 1 -
 7 files changed, 7 deletions(-)

diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index c8db04c076ef..68ecbc54b807 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -52,7 +52,6 @@ CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_PHY_ROCKCHIP_USBDP=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index 307a540f4249..bc2d70421ee9 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -40,7 +40,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index 9ef2bb21fffa..8bc75a5f0dd9 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -40,7 +40,6 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index b2a66d3f2db0..ee2521f87ae5 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -64,7 +64,6 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_SCSI=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index ac4f1ebb4c13..8af56baf04d7 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -75,7 +75,6 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_SCSI=y
diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 6ee92e943138..38fc7906eef2 100644
--- a/configs/toybrick-rk3588_defconfig
+++ b/configs/toybrick-rk3588_defconfig
@@ -53,7 +53,6 @@ CONFIG_PHY_REALTEK=y
 CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_BAUDRATE=1500000
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index e18ced721789..77aacbc64b6c 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -81,7 +81,6 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
 CONFIG_PHY_ROCKCHIP_USBDP=y
 CONFIG_SPL_PINCTRL=y
-CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 CONFIG_SCSI=y
-- 
2.43.2

