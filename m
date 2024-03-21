Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E57C54E68
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 11:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2058188047;
	Thu, 21 Mar 2024 12:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="Btu5jTyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3355A8809C; Thu, 21 Mar 2024 07:58:06 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 607E2880BF
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:57:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rnCN9-0006GY-1J; Thu, 21 Mar 2024 02:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=3rJkn90Ud0M9/jeFir4Or+zAvffnOM2Up/YugEsUMaM=; b=Btu5jTyU5PU6pX7TmN0d
 FZNnVFuUnhAhsv/sNxbNY6VHtW6weoGj2k4paFlPOQOJRBi6h8qt89MmAwGBrKteg56d9wsq+Htb9
 Mrsy0ZG+4nObTlDKWvzM4jhtdw+R0YNZAy3SbsKoD1Fa46Z1bWwrMu/Pm3gzs0LCq3dGfXpw6N3f5
 uJYGAXfOJzEf42QEE6978uzh4k6mgBaBqFIPIzxTJLHijeWMva1YoDFVbkLuPdSPdwdTY0GKw9HsS
 yXZtNAwo1bRy5KbIlILq3PmW51sFw/sqYXQYKpxlZhY4NpuPuEJqsLw7INE1Im4YVdME/MUerFiF9
 iDuS1C1JKzkYmw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@denx.de>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Yannic Moog <y.moog@phytec.de>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2 3/3] configs: imx93-phyboard-segin: Add fastboot support
Date: Thu, 21 Mar 2024 07:57:42 +0100
Message-ID: <20240321065742.32441-4-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240321065742.32441-1-othacehe@gnu.org>
References: <20240321065742.32441-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 Mar 2024 12:32:10 +0100
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

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 configs/imx93-phyboard-segin_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/imx93-phyboard-segin_defconfig b/configs/imx93-phyboard-segin_defconfig
index 0345e7deeab..54215c51c08 100644
--- a/configs/imx93-phyboard-segin_defconfig
+++ b/configs/imx93-phyboard-segin_defconfig
@@ -94,6 +94,12 @@ CONFIG_SPL_CLK_IMX93=y
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
 CONFIG_DM_I2C=y
-- 
2.41.0

