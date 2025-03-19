Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCEDC35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713C781B42;
	Wed, 19 Mar 2025 13:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB32F81D3B; Wed, 19 Mar 2025 13:04:34 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 67C71819B1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 13:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: NBIfqL0VQ+6FDGLpIrJA5w==
X-CSE-MsgGUID: 2RyPOJ/CSZCgwKEW9l5QQA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 19 Mar 2025 21:04:31 +0900
Received: from rz-ub2404.betafive.net (unknown [10.24.1.74])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3EC4E4016D69;
 Wed, 19 Mar 2025 21:04:28 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 4/4] renesas_rzg2l_smarc_defconfig: Enable networking
 support
Date: Wed, 19 Mar 2025 12:04:00 +0000
Message-ID: <20250319120401.8297-5-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
References: <20250319120401.8297-1-paul.barker.ct@bp.renesas.com>
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
index b1d970b6b7eb..6ec151218ebe 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -27,6 +27,9 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
@@ -41,6 +44,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_VERSION_VARIABLE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_REGMAP=y
 CONFIG_CLK=y
 CONFIG_CLK_RENESAS=y
@@ -50,6 +54,8 @@ CONFIG_DM_I2C=y
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

