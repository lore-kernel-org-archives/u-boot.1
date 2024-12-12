Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024D7E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 724C48031E;
	Thu, 12 Dec 2024 23:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="GWH7c/a0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79B198031E; Thu, 12 Dec 2024 23:10:57 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 116FF802F2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734041450; bh=/VsA6szMy7OBm0Mj6GnntfzmErFjNKPFIaf8TjFgCPo=;
 b=GWH7c/a0bMwY/A0D5bmVJwBsb/wORb/I2noamAy1UWdmnp7RBpbLZheitAZbld8A0Xo72kN8Z
 QMvqsSlRqVKDUcsRK6UTOHtbQQtvhneKLKXyL5HKuOra5Aths4hfDjA0PdWaUlJYe3n9AyvVbr7
 sTOost7dzngYodLBj3RW55qYv1jJL6TOCFRlnXttaAb9H8djLtfGR6ysKnu9vZaBGE37GJysQmJ
 6Q9OnmBuO1z2gZomSB6XpjOriRHLWNsRqApqs8lC35syruxwV3Pt+ITJDiETDGnZS8ORl1zIkHx
 DWj4gFKnf+zP36H1S12O2FRsdaercl6SZTRj1MlPyW6Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 10/11] rockchip: rk3288-firefly: Fix slow Ethernet initializion
Date: Thu, 12 Dec 2024 22:09:43 +0000
Message-ID: <20241212221000.94501-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212221000.94501-1-jonas@kwiboo.se>
References: <20241212221000.94501-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b5f69a511ed8f0b3fc8cb
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

Firefly-RK3288 use RTL8211 Ethernet PHY, datasheet list an initial 10ms
delay and then a 30-76ms delay before accessing registers.

Change to use 80ms delay instead of a full second to speed up Ethernet
initializion in U-Boot.

Also enable PHY_REALTEK, DM_ETH_PHY and PHY_GIGE to improve Ethernet PHY
support in U-Boot.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-firefly-u-boot.dtsi | 4 ++++
 configs/firefly-rk3288_defconfig        | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
index 13f5be27a969..b7d13bcb860d 100644
--- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
@@ -48,6 +48,10 @@
 	bootph-some-ram;
 };
 
+&gmac {
+	snps,reset-delays-us = <0 10000 80000>;
+};
+
 &gpio7 {
 	/delete-property/ bootph-all;
 	bootph-pre-ram;
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index a79e217c7adf..95fb20b8b24c 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -58,6 +58,9 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PINCTRL=y
-- 
2.47.1

