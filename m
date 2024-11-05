Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A26AD2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B3789207;
	Tue,  5 Nov 2024 17:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vEH5+O8E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA10F8922A; Tue,  5 Nov 2024 17:01:56 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A673E891D0
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822506; bh=mTYB6ooyqe7SStlI2IDJ3I7HoBYRZ6+eh4Zvrd55RW4=;
 b=vEH5+O8EcwfHQphjawE9EZ2ElzkDlh8zRbKfvuzz/aK0scm1CiLsK4pqXDQsbYauWp5014fCp
 WmaLlatz9TQA8acLSvWa0HComl+nDI2XcvDTPq9QH2VYcbsnKG4HYBzfaAptwGAWx679s6AC3rq
 Rw6pEjvXHQEVHlvJUM+54M85GSve22CAXeKyw4BVh6F1xkMdXKaNYbL6wnIFi2c7LSvP44xe9D3
 31CeUBG7dGFCoZ6zlcDmiTCrJ+oTbbTyZjC/5BY+NiiQuJVdYxQm9D3MIawY7B4vlYEWJwGoB4L
 AXVk+dO2hOHY1g7mZZQ32cuqoBXCF6Gr3siEC/vd2y5Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 12/13] rockchip: rk3288-tinker: Fix slow Ethernet initializion
Date: Tue,  5 Nov 2024 16:00:35 +0000
Message-ID: <20241105160054.1373319-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a4168ff3e144e4725e1c0
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

For some reason the Ethernet PHY reset delay is set to 1 second, this
cause an unneccecery long boot delay.

Tinker Board use RTL8211E or RTL8211F Ethernet PHY, datasheet list an
initial 10ms delay and then a 30-76ms delay before accessing registers.

Change to use 80ms delay instead of a full second to speed up Ethernet
initializion in U-Boot.

Also enable PHY_REALTEK, DM_ETH_PHY and PHY_GIGE to improve Ethernet PHY
support in U-Boot.

Before:

  1,404,971    960,924  eth_common_init
  2,438,830  1,033,859  eth_initialize
  2,444,449      5,619  main_loop
  2,445,153        704  cli_loop

After:

  1,404,987    960,710  eth_common_init
  1,519,110    114,123  eth_initialize
  1,524,734      5,624  main_loop
  1,525,452        718  cli_loop

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
There are more boards having similar full second delay and a fix will be
sent to upstream Linux to correct this in due time.
---
 arch/arm/dts/rk3288-tinker-u-boot.dtsi | 4 ++++
 configs/tinker-rk3288_defconfig        | 3 +++
 configs/tinker-s-rk3288_defconfig      | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
index 7568b1495341..a6f6f14df93d 100644
--- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
@@ -16,6 +16,10 @@
 	rockchip,sdram-params = <0x20d266a4 0x5b6 2 533000000 6 9 0>;
 };
 
+&gmac {
+	snps,reset-delays-us = <0 10000 80000>;
+};
+
 &gpio7 {
 	/delete-property/ bootph-all;
 };
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index b7636fe581f4..05dca105d609 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -58,6 +58,9 @@ CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index e50424746c81..1bee0d094c8d 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -58,6 +58,9 @@ CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
-- 
2.46.2

