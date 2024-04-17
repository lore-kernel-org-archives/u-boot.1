Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08BDC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 20:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C1CE884E0;
	Wed, 17 Apr 2024 22:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68045884D8; Wed, 17 Apr 2024 22:03:30 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760C48813F
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 22:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from [68.189.91.139] (helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1rxBV8-006Zne-T5;
 Wed, 17 Apr 2024 20:03:27 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8m*_venice_defconfig: enable ipv6, wget and tftpput
Date: Wed, 17 Apr 2024 13:03:25 -0700
Message-Id: <20240417200325.3749018-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Enable ipv6, wget, and tftpput support

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 configs/imx8mm_venice_defconfig | 5 +++++
 configs/imx8mn_venice_defconfig | 5 +++++
 configs/imx8mp_venice_defconfig | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index cb6b97d097c1..c3fd4c45ab3d 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -62,7 +62,10 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_DHCP6=y
+CONFIG_CMD_TFTPPUT=y
 CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_UUID=y
@@ -83,6 +86,8 @@ CONFIG_ETHPRIME="eth0"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_PROT_TCP_SACK=y
+CONFIG_IPV6=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 0a4fba5f1ca8..21b68e3cc841 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -65,7 +65,10 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_DHCP6=y
+CONFIG_CMD_TFTPPUT=y
 CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_UUID=y
@@ -86,6 +89,8 @@ CONFIG_ETHPRIME="eth0"
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_PROT_TCP_SACK=y
+CONFIG_IPV6=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_CLK_IMX8MN=y
 CONFIG_CLK_IMX8MN=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 6e4addc7728f..187221d2ba63 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -67,7 +67,10 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_DHCP6=y
+CONFIG_CMD_TFTPPUT=y
 CONFIG_SYS_DISABLE_AUTOLOAD=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_UUID=y
@@ -86,6 +89,8 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_IP_DEFRAG=y
 CONFIG_TFTP_BLOCKSIZE=4096
+CONFIG_PROT_TCP_SACK=y
+CONFIG_IPV6=y
 CONFIG_SPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
-- 
2.25.1

