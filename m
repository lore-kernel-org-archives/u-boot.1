Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFD8CE8E8B
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:28:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50A089065;
	Thu, 24 Oct 2024 17:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 867CF89015; Thu, 24 Oct 2024 17:26:13 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 44C1A8902F
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.11,229,1725289200"; d="scan'208";a="226888023"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 25 Oct 2024 00:25:55 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.183])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 58BCD4009439;
 Fri, 25 Oct 2024 00:25:46 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH 12/14] renesas_rzg2l_smarc_defconfig: Enable networking support
Date: Thu, 24 Oct 2024 16:24:46 +0100
Message-Id: <20241024152448.102-13-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
References: <20241024152448.102-1-paul.barker.ct@bp.renesas.com>
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

For Ethernet to work on the RZ/G2L board, we need to enable support for
the ksz9131 PHY and enable random MAC address generation (as no MAC
address is programmed into the board).

We also enable the `dhcp`, `mii` and `ping` commands so that Ethernet
functionality can be tested and used to boot Linux.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 configs/renesas_rzg2l_smarc_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index 7a1224b3f07a..991818e797ea 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -26,6 +26,9 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
@@ -40,6 +43,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_CLK=y
 CONFIG_CLK_RENESAS=y
@@ -49,6 +53,8 @@ CONFIG_DM_I2C=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_PHY_MICREL=y
+CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RAA215300=y
 CONFIG_DM_REGULATOR=y
-- 
2.43.0

