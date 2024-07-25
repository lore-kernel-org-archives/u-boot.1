Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEEBC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5FDD882DC;
	Thu, 25 Jul 2024 11:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD6A586E85; Thu, 25 Jul 2024 11:32:58 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927C7882BE
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zhiqiang.Hou@nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 59BAF20058A;
 Thu, 25 Jul 2024 11:32:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 207A42005AE;
 Thu, 25 Jul 2024 11:32:55 +0200 (CEST)
Received: from mega.am.freescale.net (mega.ap.freescale.net [10.192.208.232])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id
 C75F2180222B; Thu, 25 Jul 2024 17:32:53 +0800 (+08)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 festevam@gmail.com, sjg@chromium.org
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 9/9] configs: imx93: enable the 'cpu' command
Date: Thu, 25 Jul 2024 17:53:31 +0800
Message-Id: <20240725095331.14245-10-Zhiqiang.Hou@nxp.com>
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

Enable the 'cpu' command to display the CPU info and release CPU core to
run baremetal or RTOS applications.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - No change.

 configs/imx93_11x11_evk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 2246715d822..93ab0b9aa30 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -52,6 +52,7 @@ CONFIG_CMD_ERASEENV=y
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
+CONFIG_CMD_CPU=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
-- 
2.43.0

