Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D02EC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7738787FC5;
	Tue, 20 Feb 2024 12:04:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="TTB4JT92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1418387F5D; Tue, 20 Feb 2024 11:36:05 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230EE87F75
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rcNTZ-00014j-2x; Tue, 20 Feb 2024 05:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=n5XNITTJ67SeIXDgLA6mh2I6m/PAWWXxgx8GIsYgdVw=; b=TTB4JT92MAyjK+fw+Pw/
 Y82/aDVY7v46h4f7jmoNbyvi4uu57EGCklJZ8UWQgDjJWClu2aeOBuTMZP5xFnBbIHpNGOodFOifo
 SJ53/kuxBcGjf7fg5QZkvNjjJ5lZ41IFX1t1TlY5bi1jQgXHcWeHmlhz44ZyUMjl/7VYX03W13b/O
 yR1BYCCPXbnjojdQg9tyEY0mr2CdGOQX895Ne86P5kmF5HUOSzfBCmPKJlFI1bI5PR94lW96hZvr5
 sRc0T70ltX5xB8iP0hG/0VtAvDmHw7pOxYeNPeButHQrIBRkZ1Aoep6+MBjtPYLJqgCBgwZ/Wie+4
 B5yqxJ1Fjrms/g==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 3/5] configs: imx93_var_som: Add USB support.
Date: Tue, 20 Feb 2024 11:35:04 +0100
Message-ID: <20240220103506.17218-4-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240220103506.17218-1-othacehe@gnu.org>
References: <20240220103506.17218-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Feb 2024 12:03:24 +0100
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
 configs/imx93_var_som_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index 71cd016d332..0aab222c7c1 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -70,6 +70,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_READ=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_BOOTP_PREFER_SERVERIP=y
 CONFIG_CMD_SNTP=y
@@ -132,6 +133,14 @@ CONFIG_DM_SERIAL=y
 CONFIG_FSL_LPUART=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_TMU=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x1fc9
+CONFIG_USB_GADGET_PRODUCT_NUM=0x0152
+CONFIG_CI_UDC=y
+CONFIG_USB_PORT_AUTO=y
 CONFIG_ULP_WATCHDOG=y
 CONFIG_WDT=y
 CONFIG_LZO=y
-- 
2.41.0

