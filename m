Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A681CC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:11:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 411AD87FD6;
	Tue, 20 Feb 2024 12:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="Y0L2dI/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4067B87D4D; Tue, 20 Feb 2024 11:36:11 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B06DE87F8C
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 11:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rcNTf-000165-8c; Tue, 20 Feb 2024 05:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=5N9XkB03bSP4zZ0rLeJDgLgJJy2/hRX9K/i0Ttf8aDU=; b=Y0L2dI/dU766ol9KAOck
 OziNeJjhz+F4agI5++6jrQ+zrVPztFCNFHdU3NWQiJOsCW5Aq/eFolcDMu1uUSqAF311Q6YBWv9NQ
 6Bp1hrXV+TGly5RE+wJg5ZZkfvejY3VFQQ6CvRzbUb6cdyhfHw6Z/oGNgH0lPCBVfAsVRxBQS1sXh
 0fsnOyrEYL4Z8g1qznoal0yW2sB8Q4gYFGoItATYt/OJxVk6ZPjMSLd5w8ErsBeu3uryXpuaNCw9V
 3eCJoULQo2dPI8ehYKDYzyy9HLferEqFIYIpa/6UNtRUGANA3/IMiBBX4+MT8F4Bkdmcm04zCcZeX
 1+EE3Wr6Sf5Fng==;
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
Subject: [PATCH 4/5] configs: imx93_var_som: Add fastboot support.
Date: Tue, 20 Feb 2024 11:35:05 +0100
Message-ID: <20240220103506.17218-5-othacehe@gnu.org>
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

Enable the `fastboot` command.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 configs/imx93_var_som_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/imx93_var_som_defconfig b/configs/imx93_var_som_defconfig
index 0aab222c7c1..60751a77037 100644
--- a/configs/imx93_var_som_defconfig
+++ b/configs/imx93_var_som_defconfig
@@ -97,6 +97,12 @@ CONFIG_SPL_CLK_IMX93=y
 CONFIG_CLK_IMX93=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x82800000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
 CONFIG_GPIO_HOG=y
 CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_PCA953X=y
-- 
2.41.0

