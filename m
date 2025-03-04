Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD21C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF6CC80BAA;
	Tue,  4 Mar 2025 17:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D7CB8004F; Tue,  4 Mar 2025 17:38:08 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id B9FDC811C1
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: 9fZYiLA4RWCSA76Ftt8+bg==
X-CSE-MsgGUID: CZPsGt55QrOE9aZj+/2Mmw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 05 Mar 2025 01:38:04 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.7])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id D458F4024200;
 Wed,  5 Mar 2025 01:38:01 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 5/5] renesas_rzg2l_smarc_defconfig: Enable USB support
Date: Tue,  4 Mar 2025 16:37:35 +0000
Message-ID: <20250304163736.89326-6-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable support for USB 2.0, USB 1.1 and USB storage devices on the
Renesas RZ/G2L EVK.

Also enable the 'usb' command to support USB scanning and debugging.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 configs/renesas_rzg2l_smarc_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index 7a1224b3f07a..b1d970b6b7eb 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -26,6 +26,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
@@ -54,5 +55,12 @@ CONFIG_PMIC_RAA215300=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_RAA215300=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_STORAGE=y
-- 
2.43.0

