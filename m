Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72143C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 010B887D10;
	Thu,  1 Aug 2024 16:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722523625;
	bh=+2GM9clpU8m8b64y2ipJUF1rSdIUlIdVkmWok+WMCbo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iwc6SNcKSaDpjM0ivHgNzPv54KSmst1k/ZHWZk47c5uCyvztelgrSWjdLVSKyaNLX
	 XtuTZYU8/FyyQWzwQUzOtOtVJAVpRqRrh9xSx2rzSSN88aDKtTepq5/ru5mmLIaqpI
	 7E1Zg2cnckHqbHyH8DhtbBEJLcF/4CX+JqVZoHbWsw4bjS+JOrxsJLcI9DiEGMTvZp
	 QHSaJ0bX2CSQZCvR4BQp+8D9BToYtZXUqX9go7mQnMjfIxA8yNPHhyRj/lTJazC3lj
	 393BxlYN/qr/zU3UvFfbkpklvF1EBj0AuP2xqdhtspIGy/l98/SATYtRHAR2D/uChw
	 4nQJ51AovhxGw==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4DAA0807EC;
 Thu,  1 Aug 2024 16:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722523623;
 bh=+2GM9clpU8m8b64y2ipJUF1rSdIUlIdVkmWok+WMCbo=;
 h=From:To:Cc:Subject:Date:From;
 b=ReT4FEovm7H1QtVBXUvQNYeGKYENxG+Ddx2CvLqtbszyCtB/aa5cA83MwQmVgUShJ
 wXKXGikJ2dDXb4jgaXKL8gnH4MKn9or3ZXpASPqw7j3og7Hx+6cL1IUwbi95GzgaCY
 9NFYqB/JtgOWLBiQpN0ayDQvNDQ5X0c+3Xm1jkHZXp4nH8Fi6rmqrARJ5xamOkMOOz
 uUfQlKtLvl6VlyvdUBu/C9A8UEumKgiMHxZyNxZgRryiIz25TsnK0cXxlHwexHYjCp
 S9+SbMTiYJm6ayEPCkMF0D0dsjUYJcjQIe+Xzb6QIPKJHWaKgNq/2Uf5WlV9aKLES4
 Ycs+ykIeN5qFw==
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <t.remmet@phytec.de>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Cem Tenruh <c.tenruh@phytec.de>, Martyn Welch <martyn.welch@collabora.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 2/2] config: Adjust Phytec imx8mm module config to support
 NVME disk
Date: Thu,  1 Aug 2024 16:46:50 +0200
Message-Id: <20240801144650.1635599-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

This change adds support for PCIe connected nvme disk - phyBOARD-Polis
base board.

One needs to call following commands in u-boot:
> pci enum
> nvme scan
> nvme info

And then ones to access proper file system (like fat[ls|load|write],
ext4[ls|load|write]).

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Remove not needed adjustment for CONFIG_CYCLIC_MAX_CPU_TIME_US=1000

---
 configs/phycore-imx8mm_defconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 22d419024f..a2d79a6aa7 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -12,6 +12,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mm-phyboard-polis-rdk"
 CONFIG_SPL_TEXT_BASE=0x7E1000
 CONFIG_TARGET_PHYCORE_IMX8MM=y
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -23,6 +24,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x2000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x3E0000
 CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_PCI=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
@@ -59,6 +61,7 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
@@ -110,10 +113,15 @@ CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_GIGE=y
 CONFIG_FEC_MXC=y
 CONFIG_MII=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_IMX=y
+CONFIG_PHY=y
+CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_DM_REGULATOR=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
-- 
2.39.2

