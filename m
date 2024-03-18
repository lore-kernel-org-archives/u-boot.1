Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27897C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 17:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53CB788016;
	Mon, 18 Mar 2024 18:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="IbT7A0zy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E54DE87E86; Mon, 18 Mar 2024 18:17:13 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F37A88004
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 18:17:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rmGbh-0007HT-0i; Mon, 18 Mar 2024 13:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=/0uwXweHSq6uKpmcn54/+cNYgh1+sExIGUJPp7nqtOA=; b=IbT7A0zys80TVLmrlzfZ
 i3xZvl+edymM9q6elCABIpMpnpbZQoQD1avQyEdMDRl9hCV9Bl139PEGPI51O/BIpy28Rhog8EChh
 jhPNwX6EgDuPPiJNUUsHzCIrb0q5zrQg/2GQSlTMqidToguVDMGXbrOgghN6rspCsO+KjXn1bCdC0
 17pvSOWfRkfSh7OvMDrgJYUQ2tggOl9pxOl4tn3I52Hd0nmphBXsQJUtR2s/33ekZm5UWOBXMHcUd
 /u084XBd8Vjz4+9wGY3RxjkBDYY8B/d4y7n3JaZi+sv+5yVibb1QMxe2L7DYSZyXpg6Y7ft6LCUVg
 R+P5pGLWKbrIdg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 2/3] configs: imx93-phyboard-segin: Add USB support.
Date: Mon, 18 Mar 2024 18:16:35 +0100
Message-ID: <20240318171637.12664-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240318171637.12664-1-othacehe@gnu.org>
References: <20240318171637.12664-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Mar 2024 18:43:33 +0100
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

Enable the `usb` command and some USB drivers.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 configs/imx93-phyboard-segin_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phyboard-segin_defconfig
index 24f9bd553aa..5acb987b817 100644
--- a/configs/imx93-phyboard-segin_defconfig
+++ b/configs/imx93-phyboard-segin_defconfig
@@ -23,6 +23,7 @@ CONFIG_SPL_STACK=0x20519dd0
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x720000
 CONFIG_CMD_DEKBLOB=y
+CONFIG_CMD_USB=y
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_LOAD_ADDR=0x80400000
 CONFIG_SYS_MEMTEST_START=0x80000000
@@ -132,6 +133,13 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_TMU=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
 CONFIG_ULP_WATCHDOG=y
 CONFIG_LZO=y
 CONFIG_BZIP2=y
-- 
2.41.0

