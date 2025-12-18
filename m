Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E71D6ACEE
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D670883D00;
	Thu, 18 Dec 2025 13:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964C283D00; Thu, 18 Dec 2025 13:05:18 +0100 (CET)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [83.166.143.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6847800AB
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 13:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dX8W02Lq5zVJW;
 Thu, 18 Dec 2025 13:05:16 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dX8Vz1lTnzZTW; Thu, 18 Dec 2025 13:05:15 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 18 Dec 2025 13:05:14 +0100
Subject: [PATCH] spl: fix incorrect dependency for SPL_NET
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-spl_net-deps-v1-1-e943f3899574@cherry.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MWwqAMAzAriL9drDVJ15FRESrFmSOVUQY3t3iZ
 whJAqHIJNBlCSLdLHx6BZdnMO+T38jwogxosXLoWiPhGD1dZqEgpkbb4KqiLCbQJERa+fl3/fC
 +H96LuLNeAAAA
X-Change-ID: 20251218-spl_net-deps-62072f51243a
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

SPL_NET depends on symbols that are only available if the legacy
networking stable is made available. It is however possible to build
U-Boot without a networking stack at all, in which case SPL_NET will not
compile. Fix this oversight by making sure a network stack (and the
legacy one) is available.

Fixes: 8cb330355bd5 ("net: introduce alternative implementation as net/lwip/")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 common/spl/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 3b7b6cafef8..ba434d5c46e 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1148,7 +1148,7 @@ config SPL_DM_SPI_FLASH
 
 config SPL_NET
 	bool "Support networking"
-	depends on !NET_LWIP
+	depends on NET
 	select SPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.

---
base-commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
change-id: 20251218-spl_net-deps-62072f51243a

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

