Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C66C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:25:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A30AF87AB2;
	Thu, 14 Dec 2023 17:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D21187AC0; Thu, 14 Dec 2023 17:25:50 +0100 (CET)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70DFF87AB0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.93)
 (envelope-from <tharvey@gateworks.com>)
 id 1rDoWw-00BWP7-DG; Thu, 14 Dec 2023 16:25:46 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/2] configs: imx8m{m, n,
 p}_venice_defconfig: add arch_misc_init
Date: Thu, 14 Dec 2023 08:25:42 -0800
Message-Id: <20231214162543.1200276-1-tharvey@gateworks.com>
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

Enable call to arch_misc_init in order to probe the CAAM driver.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 configs/imx8mm_venice_defconfig | 1 +
 configs/imx8mn_venice_defconfig | 1 +
 configs/imx8mp_venice_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index 01cfb96b0ee2..04b738f5d9c5 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -31,6 +31,7 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="gsc wd-disable"
+CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x910000
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 5d2e5a471cba..2f55a5b90fbb 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -32,6 +32,7 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="gsc wd-disable"
+CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x25000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 730c359779ac..d9c7018eeb8f 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -32,6 +32,7 @@ CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="gsc wd-disable"
+CONFIG_ARCH_MISC_INIT=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-- 
2.25.1

