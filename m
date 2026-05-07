Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD5DCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 10:37:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3161984A7B;
	Thu,  7 May 2026 12:37:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="oLKqTlo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5DD684AAD; Thu,  7 May 2026 12:37:22 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FD484A93
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 12:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gB7wv1BYtzvd8;
 Thu,  7 May 2026 12:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1778150238;
 bh=LZpBuLs3IJQt4DgOFNkF7RhWh16D4HVj7MFeh5CqtR0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oLKqTlo6yTrhEmVPem/+LUKMxk51BweWhkIQNRIWj/DD18EbOtX7yC0xp/CgBsl9l
 OvKFzlCzT0/ra0RB0BVt4D3DsHn38XmRcFeYGtF4f5NIpjoGgVENpvuQI8TErGK05u
 hAMaB3Lm07BVnUf1D/effhVZ9Cp5nQPFvd9sp9BBbx57RPp0Jh10g1HO5pH6PIBJUt
 Y2ciC/qa0y0BL3lPHg4kCLyrqloLkxLs5wAUqjPcIh4beFkFBXJx4PiLG09YY43Se3
 UC55Q/Ts0cJu+bR+56YNSG3KpCBvDdeL2c2fmV4mOl3RNbTpDmaia5eyAAIbJFYn1F
 IaFc/G6TrHnxw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gB7wt1kvyzTtc; Thu,  7 May 2026 12:37:18 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 07 May 2026 12:37:09 +0200
Subject: [PATCH RFC next v2 2/5] arm: ls102xa: use platform data to check
 Ethernet interface is not SGMII
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-sys_rx_eth_buffer-no-net-v2-2-cd7ef934bf42@cherry.de>
References: <20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de>
In-Reply-To: <20260507-sys_rx_eth_buffer-no-net-v2-0-cd7ef934bf42@cherry.de>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
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

