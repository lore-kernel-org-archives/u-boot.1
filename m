Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB231CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 08:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E038323A;
	Thu, 28 Aug 2025 10:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE3D583290; Thu, 28 Aug 2025 10:20:11 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EAB18323A
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 10:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:46304
 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1urXrc-001DXj-24;
 Thu, 28 Aug 2025 10:20:08 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] configs: imx93-phycore_defconfig: Disable CONFIG_AHAB_BOOT
Date: Thu, 28 Aug 2025 10:20:07 +0200
Message-Id: <20250828082008.2978900-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

By default, lets disable configuration option CONFIG_AHAB_BOOT=y on the
phyCORE-i.MX93 based boards. This option is only used in the secureboot
context which is not provided by default anyway. Lets remove it from the
defconfig to not give false impressions it is supported out of the box
for this board.

On the other hand, in the context of PHYTEC secureboot, this option is
selected by the distro which enables CONFIG_AHAB_BOOT among other secure
boot related options and tweaks needed to properly support it.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 configs/imx93-phycore_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index af149128ed41..53cd28dfcba6 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -13,7 +13,6 @@ CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-phyboard-segin"
-CONFIG_AHAB_BOOT=y
 CONFIG_TARGET_PHYCORE_IMX93=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
-- 
2.34.1

