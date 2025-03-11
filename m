Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88870C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 20:59:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C10817A5;
	Tue, 11 Mar 2025 21:58:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E2081898; Tue, 11 Mar 2025 21:58:16 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 18923817EC
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 21:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: A000nSD8S7KttPJpzvt0HA==
X-CSE-MsgGUID: BIKvpVVIQLiZ7vykCkOuOA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 12 Mar 2025 05:58:13 +0900
Received: from rz-ub2404.betafive.net (unknown [10.24.0.12])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4E94A40285F5;
 Wed, 12 Mar 2025 05:58:11 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 5/5] renesas_rzg2l_smarc_defconfig: Enable USB support
Date: Tue, 11 Mar 2025 20:57:47 +0000
Message-ID: <20250311205748.2492-6-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311205748.2492-1-paul.barker.ct@bp.renesas.com>
References: <20250311205748.2492-1-paul.barker.ct@bp.renesas.com>
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

