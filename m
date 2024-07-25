Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB817C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65F6F8807C;
	Thu, 25 Jul 2024 11:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E120E871C9; Thu, 25 Jul 2024 11:32:56 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B15A48789F
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B00E1A1484;
 Thu, 25 Jul 2024 11:32:54 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 431CD1A0541;
 Thu, 25 Jul 2024 11:32:54 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 03E521820F77; Thu, 25 Jul 2024 17:32:52 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 8/9] configs: imx8m: enable the 'cpu' command
Date: Thu, 25 Jul 2024 17:53:30 +0800
Message-Id: <20240725095331.14245-9-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
References: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
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

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Enable the 'cpu' command and the depended imx CPU driver to
display the CPU info and release CPU core to run baremetal
or RTOS applications.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - No change.

 configs/imx8mm_evk_defconfig | 3 +++
 configs/imx8mn_evk_defconfig | 3 +++
 configs/imx8mp_evk_defconfig | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index ff33d1532a0..8b04586f861 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -118,3 +118,6 @@ CONFIG_SDP_LOADADDR=0x40400000
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
+CONFIG_CMD_CPU=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 2402e9e8bfb..ee7a5e90883 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -105,3 +105,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
+CONFIG_CMD_CPU=y
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index f5ba022b075..31760699916 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -137,3 +137,6 @@ CONFIG_USB_GADGET_MANUFACTURER="FSL"
 CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_IMX_WATCHDOG=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
+CONFIG_CMD_CPU=y
-- 
2.43.0

