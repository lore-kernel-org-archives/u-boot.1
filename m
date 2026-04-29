Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B60DFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 10:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A20E2847C6;
	Wed, 29 Apr 2026 12:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="dYJEHuk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0DA8484A; Wed, 29 Apr 2026 12:35:18 +0200 (CEST)
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [185.125.25.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CF3847C6
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 12:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g5DGC0BtjzBHs;
 Wed, 29 Apr 2026 12:35:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777458914;
 bh=tdqg9RYUcS8EK6pkixIm0Ndn7iqd2B5uTJufaQoAhL0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dYJEHuk03pdRKkQrvWPpFe7UwrZc9dG4uVIQHpv8dY30352t+Xz5hurOlycsyPySZ
 vzAsmnnIhHGlSY7mroy2hILWIpKEvcy77iSi9nfxaAuw+9bP+vxvJ8zbU34EV+hFAg
 pSiYKJ7n+f3+iGYxTJyoTPTIfoFwpfS83qpFL9juJPe+K9gMpsCzWIf87uRa+0ZFV/
 KESMyfxn4NXAnFopbhmREiPC+HAS3g1t6fkCBi4hE6zKDPSa9vOvOSjxZvzLiGmnRk
 OYoXo/W+yE8oCR7aOktyCb2i5Dpp2X18A9f7PjPeu0X9z5nCMa0oHO+aDusXcPnVEM
 daiLpA9VSETww==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g5DG96bVFzZtM; Wed, 29 Apr 2026 12:35:13 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Apr 2026 12:35:02 +0200
Subject: [PATCH RFC next 2/5] arm: ls102xa: use platform data to check
 Ethernet interface is not SGMII
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-sys_rx_eth_buffer-no-net-v1-2-396ef37ae93c@cherry.de>
References: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
In-Reply-To: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
To: u-boot@lists.denx.de
Cc: Tang Yuantian <andy.tang@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
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

tsec_private should, as its name suggests, be private. In the next
commit, it'll be moved from a publicly available header file to the C
file that requires it. ls102xa currently does not allow us to do that
because it uses the structure.

The flag is actually set if the Ethernet PHY interface is SGMII in
drivers/net/tsec.c, so simply replace the current check with the same
check made in drivers/net/tsec.c to set the flag.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/cpu/armv7/ls102xa/fdt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv7/ls102xa/fdt.c b/arch/arm/cpu/armv7/ls102xa/fdt.c
index 34eea22eb92..09092ea7b7f 100644
--- a/arch/arm/cpu/armv7/ls102xa/fdt.c
+++ b/arch/arm/cpu/armv7/ls102xa/fdt.c
@@ -16,7 +16,6 @@
 #ifdef CONFIG_FSL_ESDHC
 #include <fsl_esdhc.h>
 #endif
-#include <tsec.h>
 #include <asm/arch/immap_ls102xa.h>
 #include <fsl_sec.h>
 #include <dm.h>
@@ -26,7 +25,7 @@ DECLARE_GLOBAL_DATA_PTR;
 void ft_fixup_enet_phy_connect_type(void *fdt)
 {
 	struct udevice *dev;
-	struct tsec_private *priv;
+	struct eth_pdata *pdata;
 	const char *enet_path, *phy_path;
 	char enet[16];
 	char phy[16];
@@ -45,8 +44,8 @@ void ft_fixup_enet_phy_connect_type(void *fdt)
 			continue;
 		}
 
-		priv = dev_get_priv(dev);
-		if (priv->flags & TSEC_SGMII)
+		pdata = dev_get_plat(dev);
+		if (pdata->phy_interface == PHY_INTERFACE_MODE_SGMII)
 			continue;
 
 		enet_path = fdt_get_alias(fdt, enet);

-- 
2.54.0

