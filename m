Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04B3CD1283
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 19:06:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F19DA882AE;
	Fri, 29 Mar 2024 20:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vUVo33TM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3097F882AA; Fri, 29 Mar 2024 20:03:53 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8654B8828C
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 20:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=52ff=LE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711739022; bh=DGJUl37u6ly6SFS7XMOBX1ZKNyktZPnkagC4CM5WG3w=;
 b=vUVo33TMWQIJRxuo8HQWepFxkf0zhi35er6yMeC/+o2u2Bg8t6YVs7IL0QSzNE7s97zo9bjrv
 56UEDf/VJfgpFbU2j30icD4jxuKB+kXOEWgYvHuGw3tPoYAE3g2ACknZ3BOdMeJzO7pHj6CELwH
 dtFp5chqCsebqm6QeZh+JJTM2MgNmBJIZKm6Se1Jbbx0m+UEiU+ixN5uoPOlm610GG1WmHbCtqC
 HAEeyBrkATmrCngqOqyeymBZF+UM3Jw+Jk0lsRFNHk2ej9NzfRHfla0AS2zl8wg2LV+thv9HPD1
 w2otYBME3NZCCU2ohJ1/phCdcVQzJy6UJ0PgKVLl5XeQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 16/19] rockchip: rk3588-turing-rk1: Use dwc3-generic driver
Date: Fri, 29 Mar 2024 19:01:57 +0000
Message-ID: <20240329190224.3613471-17-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240329190224.3613471-1-jonas@kwiboo.se>
References: <20240329190224.3613471-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6607108cc77850cc7d0ca192
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

RK35xx boards are expected to use the dwc3-generic driver and not the
xhci-dwc3 driver.

Remove the USB_XHCI_DWC3 option to ensure that the dwc3-generic driver
is used. Also enable DWC_AHCI to support on-board SATA.

Fixes: 153ac950a599 ("board: rockchip: Add the Turing RK1 SoM")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 configs/turing-rk1-rk3588_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 77aacbc64b6c..e486f0597813 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -52,9 +52,8 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
-CONFIG_SATA=y
-CONFIG_SCSI_AHCI=y
 CONFIG_AHCI_PCI=y
+CONFIG_DWC_AHCI=y
 CONFIG_SPL_CLK=y
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
@@ -90,7 +89,6 @@ CONFIG_ROCKCHIP_SFC=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_PCI=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
-- 
2.43.2

