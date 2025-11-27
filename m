Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F08D111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 19:27:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 799CB844C7;
	Thu, 27 Nov 2025 20:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Lei5tlLW";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NDdg32h6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED0B8444D; Thu, 27 Nov 2025 20:26:51 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC91844BF
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 20:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dHRJ92WW8z9tB5;
 Thu, 27 Nov 2025 20:26:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764271609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=raocU1ex9nqEhfI7QjjUAeYvFLLiW/ew8b26/MT/U9A=;
 b=Lei5tlLWY0tk4q26IH+OyoQVZmrUPKFY+InAnrO2JdB21whZC/7Z5HV281LZIQXMsTqrsh
 p2Y7MOgtbNqMKrKWiguWZky86DTfuV/sjjb514fO6V1Qw//e4b+AdLDOpgI9j2Ip0y+7KV
 xKUq6I3+cws9hjCyPnLBBAFxseGJ4KXTuHfuYEyIW6XR87QESJ3z4jFzrCRnYiF5P9XxPr
 qT2J9upqLaTisJOY10+oWsfIUVo5zS7tn0p/Eryxje0ft/QAQolJRUdIFz/O3onYt5RoAi
 RgPvFOi5AsgxJOtvGmA7jaMHil3zwWn/k6+Jc+AtxMOQeB73xxHSNDP9LxejBg==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764271607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=raocU1ex9nqEhfI7QjjUAeYvFLLiW/ew8b26/MT/U9A=;
 b=NDdg32h6mZSOrjEFMJSnvdgUWbP4Cb1BW0bHKrViH1fBGFOFoG1P/UX2/jgc8y0QEfxxKT
 xiJk75JM1Vs12TLmrx7zKJCAWgrKzKDjSRUwtnORTgdHbZQPjvMAPAGWFYpnK7qFKUx1Qz
 IyGU8BSVQTC+QUu3Rs1MaM9t8L6eCiw3g/zIHniytCIk76PYI2pGImdnjzTQWbVy8O7C9z
 yvTmJ+lOBJD+QVtclY+PxwMu+eEBm6DienqFadvCSaVaqueMNgntOZm/wBT7dwwZF2pfa/
 9BDrKUhBlD1NdD6FQCwAy/ezyAgusqw/9FM2aaXB0zUBsPn35ypyzgkOu339Mw==
To: u-boot@lists.denx.de
Cc: fedor.ross@ifm.com, Marek Vasut <marek.vasut@mailbox.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 2/2] imx: Eliminate IMX95_A0
Date: Thu, 27 Nov 2025 20:25:22 +0100
Message-ID: <20251127192633.79935-2-marek.vasut@mailbox.org>
In-Reply-To: <20251127192633.79935-1-marek.vasut@mailbox.org>
References: <20251127192633.79935-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fxxghhbxzeuiom79sz56t3ab5b4pfgbn
X-MBO-RS-ID: db90627d3efe150093a
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

Instead of ifdeffery in DTs, simply generate flash-a0.bin for i.MX95 A0/A1
and flash.bin for i.MX95 B0 and newer. This way, both SoC revisions can be
supported and binman will fill in missing blobs into flash*bin if they are
not accessible. This makes U-Boot generic on i.MX95 A0, A1, B0 and newer
once more.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "João Paulo Gonçalves" <joao.goncalves@toradex.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jacky Bai <ping.bai@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
NOTE: Compile-tested only
---
 arch/arm/dts/imx95-u-boot.dtsi       | 49 ++++++++++++++++++++--------
 arch/arm/mach-imx/imx9/Kconfig       |  3 --
 configs/imx95_a0_19x19_evk_defconfig |  2 --
 3 files changed, 35 insertions(+), 19 deletions(-)
 delete mode 100644 configs/imx95_a0_19x19_evk_defconfig

diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
index 591cb317508..01f3bf9b172 100644
--- a/arch/arm/dts/imx95-u-boot.dtsi
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -47,7 +47,41 @@
 			};
 		};
 
-		imx-boot {
+		imx-boot-a0 {
+			filename = "flash-a0.bin";
+			pad-byte = <0x00>;
+
+			spl {
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+				boot-from = "sd";
+				soc-type = "IMX9";
+				append = "mx95a0-ahab-container.img";
+				container;
+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
+				hold = <0x10000>;
+				image1 = "oei", "oei-m33-tcm.bin", "0x1ffc0000";
+				image2 = "m33", "m33_image.bin", "0x1ffc0000";
+				image3 = "a55", "spl/u-boot-spl.bin", "0x20480000";
+				dummy-v2x = <0x8b000000>;
+			};
+
+			u-boot {
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x8a200000";
+				image1 = "a55", "u-boot.bin", "0x90200000";
+			};
+		};
+
+		imx-boot-b0 {
 			filename = "flash.bin";
 			pad-byte = <0x00>;
 
@@ -56,25 +90,14 @@
 				cfg-path = "spl/u-boot-spl.cfgout";
 				args;
 
-#ifndef CONFIG_IMX95_A0
 				cntr-version = <2>;
-#endif
 				boot-from = "sd";
 				soc-type = "IMX9";
-#ifdef CONFIG_IMX95_A0
-				append = "mx95a0-ahab-container.img";
-#else
 				append = "mx95b0-ahab-container.img";
-#endif
 				container;
-#ifndef CONFIG_IMX95_A0
 				dummy-ddr;
-#endif
 				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
 				hold = <0x10000>;
-#ifdef CONFIG_IMX95_A0
-				image1 = "oei", "oei-m33-tcm.bin", "0x1ffc0000";
-#endif
 				image2 = "m33", "m33_image.bin", "0x1ffc0000";
 				image3 = "a55", "spl/u-boot-spl.bin", "0x20480000";
 				dummy-v2x = <0x8b000000>;
@@ -85,9 +108,7 @@
 				cfg-path = "u-boot-container.cfgout";
 				args;
 
-#ifndef CONFIG_IMX95_A0
 				cntr-version = <2>;
-#endif
 				boot-from = "sd";
 				soc-type = "IMX9";
 				container;
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 8a01b9045dd..f5e4c364087 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -25,9 +25,6 @@ config IMX91
 	select ARCH_MISC_INIT
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
-config IMX95_A0
-	bool "Support for i.MX95 A0 silicon version"
-
 config IMX95
 	bool
 	select ARCH_MISC_INIT
diff --git a/configs/imx95_a0_19x19_evk_defconfig b/configs/imx95_a0_19x19_evk_defconfig
deleted file mode 100644
index 9376f11b151..00000000000
--- a/configs/imx95_a0_19x19_evk_defconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-#include <configs/imx95_evk.config>
-CONFIG_IMX95_A0=y
-- 
2.51.0

