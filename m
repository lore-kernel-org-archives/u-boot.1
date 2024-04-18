Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92214C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C4688620;
	Thu, 18 Apr 2024 14:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tidylabs.app
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tidylabs.app header.i=@tidylabs.app header.b="KbF3gDvK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D8788560; Thu, 18 Apr 2024 03:46:11 +0200 (CEST)
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021D48852F
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 03:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tidylabs.app
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=justin@tidylabs.app
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4VKgbg3dbyz3w8V;
 Thu, 18 Apr 2024 03:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tidylabs.app; s=key2;
 t=1713404767; bh=I7IvUUchUfXPXUVjSJ6uSRCDH1w4kL4borSRzoDBidM=;
 h=From:To:Cc:Subject:Date:From;
 b=KbF3gDvKJy9qkjVWiRBxHzy/unfZeL5lEJ8aLNSwNyFjWu49XrAIaF060EbvngGxN
 dVaBU1F9DGL3JF/SyGKFt/mrA3ZM2hw3P1sRa320txzFjLMYDwSPKsmrvEbieYfdcx
 /+ixBmdHDhHOGxoHNflg0qwnP+7jxLVNLQJ1kdqbo1vogtpanNBZ+KO18VYwD6quUf
 HSX6Uk1YCJFT6yBWqgaPkMGhbc+eAzpVPcHTjF5U2ZZsBH/zs2GGUlttToLcuOQds4
 +31kWIZSFtZnUFG/tmvOZ+pC4XVmoI0TR2j0dGcux6mbccLjA8zGcJzZc6zhW5Dw1G
 pQhVDu8HaDdTg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4VKgbg2xcgz3w7q;
 Thu, 18 Apr 2024 03:46:07 +0200 (CEST)
Received: from mx2ecc.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4VKgbf683Wz8sb3;
 Thu, 18 Apr 2024 03:46:06 +0200 (CEST)
Received: from Justin-Air.lan (unknown
 [IPv6:2602:ae:15a3:7b00:94a0:6d3a:265b:af9e])
 by mx2ecc.netcup.net (Postfix) with ESMTPSA id 6ADDB1A002A;
 Thu, 18 Apr 2024 03:46:01 +0200 (CEST)
Authentication-Results: mx2ecc;
 spf=pass (sender IP is 2602:ae:15a3:7b00:94a0:6d3a:265b:af9e)
 smtp.mailfrom=justin@tidylabs.app smtp.helo=Justin-Air.lan
Received-SPF: pass (mx2ecc: connection is authenticated)
From: Justin Klaassen <justin@tidylabs.app>
To: u-boot@lists.denx.de
Cc: Justin Klaassen <justin@tidylabs.app>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH] rockchip: nanopi-r4s: Fix ehci usb error
Date: Wed, 17 Apr 2024 18:45:29 -0700
Message-ID: <20240418014552.5773-1-justin@tidylabs.app>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6ADDB1A002A
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: KNiNKiZFfxhC1IWWlFLZaPwf5fopALF4mHuXsP5C7PP1Ca4=
X-Mailman-Approved-At: Thu, 18 Apr 2024 14:50:43 +0200
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

The ehci_generic driver always failed with the error:
Bus usb@fe380000: ehci_generic usb@fe380000:
... Failed to get clocks (ret=-19)
Port not available.
Bus usb@fe3c0000: ehci_generic usb@fe3c0000:
... Failed to get clocks (ret=-19)
Port not available.

This error is resolved by enabling the CONFIG_PHY_ROCKCHIP_INNO_USB2
and CONFIG_PHY_ROCKCHIP_TYPEC driver options.

The CONFIG_DM_RESET option must also be enabled, otherwise the
ehci_generic driver will fail with the error:
Bus usb@fe380000: ehci_generic usb@fe380000:
... Failed to get resets (err=-524)
probe failed, error -524
Bus usb@fe3c0000: ehci_generic usb@fe3c0000:
... Failed to get resets (err=-524)
probe failed, error -524

Additionally the u2phy1_host device was previously disabled in the
nanopi-r4s device tree and must be enabled to avoid a crash in the
ehci_generic driver:
Bus usb@fe380000: USB EHCI 1.00
Bus usb@fe3c0000: "Synchronous Abort" handler, esr 0x96000010, far 0x0

With these changes the usb ports can now be initialized correctly by
both the ehci_generic and xhci_generic drivers:
Bus usb@fe380000: USB EHCI 1.00
Bus usb@fe3c0000: USB EHCI 1.00
Bus usb@fe800000: Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
Bus usb@fe900000: Register 2000140 NbrPorts 2
Starting the controller
USB XHCI 1.10
scanning bus usb@fe380000 for devices... 1 USB Device(s) found
scanning bus usb@fe3c0000 for devices... 1 USB Device(s) found
scanning bus usb@fe800000 for devices... 1 USB Device(s) found
scanning bus usb@fe900000 for devices... 1 USB Device(s) found
       scanning usb for storage devices... 0 Storage Device(s) found

Signed-off-by: Justin Klaassen <justin@tidylabs.app>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/dts/rk3399-nanopi-r4s.dts  | 2 +-
 configs/nanopi-r4s-rk3399_defconfig | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/rk3399-nanopi-r4s.dts b/arch/arm/dts/rk3399-nanopi-r4s.dts
index cef4d18b599..a992a6ac5e9 100644
--- a/arch/arm/dts/rk3399-nanopi-r4s.dts
+++ b/arch/arm/dts/rk3399-nanopi-r4s.dts
@@ -117,7 +117,7 @@
 };
 
 &u2phy1_host {
-	status = "disabled";
+	phy-supply = <&vdd_5v>;
 };
 
 &uart0 {
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index ea01d323541..d8c34dc48cb 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -5,6 +5,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-nanopi-r4s"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3399=y
 CONFIG_TARGET_EVB_RK3399=y
 CONFIG_DEBUG_UART_BASE=0xFF1A0000
@@ -36,6 +37,8 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_RK8XX=y
-- 
2.43.0

