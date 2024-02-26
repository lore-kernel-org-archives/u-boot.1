Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537A3C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B7987F4F;
	Mon, 26 Feb 2024 18:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="EPgEi319";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AEE487BD6; Mon, 26 Feb 2024 18:37:43 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E14B87EAB
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:37:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1reev6-000716-8r; Mon, 26 Feb 2024 12:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=/bzIk+g59XHmrc8jxVX8Am29WIFS9MRIAo25UJIjUXo=; b=EPgEi319kKoNrStwm9bt
 k82eSBA6wq2Oxnq5/74aYDYeKOGj98rwF0UuOtcbsPii4WdL+yp5WPkB5XiYs3eZtldOdnQHCweQy
 oOKHliERBbEUczUgV6lcnPDxcE5DbSVOFWOjUk3JuVUBMTi8v6burF1LVfOEHh9N5zwvPvYzpYCoW
 ChZ5lI0tMuOBpU1AaCww1e7m9BcxBt7MqsWJXN7ej4EY+gJkD3Z+p68RbFUX2lY8VPv2nnepwJRL7
 GWpShdKntaG603yD6TYLVt7L54s+twXpjGNMZ7gq7ttoJvFvtU3sWK2aQa9zd40ADKLp8SFz3DRK2
 ILShP893hwog2g==;
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
Subject: [PATCH 1/2] imx9: Fix OP-TEE support
Date: Mon, 26 Feb 2024 18:37:18 +0100
Message-ID: <20240226173719.25629-2-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226173719.25629-1-othacehe@gnu.org>
References: <20240226173719.25629-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Feb 2024 18:45:46 +0100
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

This fixes OP-TEE support by:

- Adding tee.bin to container.cfg
- Starting ELE RNG in SPL

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm/mach-imx/imx9/container.cfg | 3 ++-
 board/freescale/imx93_evk/spl.c      | 7 +++++++
 board/phytec/phycore_imx93/spl.c     | 7 +++++++
 board/variscite/imx93_var_som/spl.c  | 6 ++++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/container.cfg b/arch/arm/mach-imx/imx9/container.cfg
index f268bc9eb2c..72fe791eae6 100644
--- a/arch/arm/mach-imx/imx9/container.cfg
+++ b/arch/arm/mach-imx/imx9/container.cfg
@@ -7,4 +7,5 @@ BOOT_FROM SD 0x400
 SOC_TYPE IMX9
 CONTAINER
 IMAGE A55 bl31.bin 0x204E0000
-IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
\ No newline at end of file
+IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
+IMAGE A55 tee.bin 0x96000000
\ No newline at end of file
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index a98ed69db88..2fd5559195e 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -20,6 +20,7 @@
 #include <asm/mach-imx/boot_mode.h>
 #include <asm/mach-imx/mxc_i2c.h>
 #include <asm/arch-mx7ulp/gpio.h>
+#include <asm/mach-imx/ele_api.h>
 #include <asm/mach-imx/syscounter.h>
 #include <asm/sections.h>
 #include <dm/uclass.h>
@@ -43,6 +44,12 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 
 void spl_board_init(void)
 {
+	int ret;
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+
 	puts("Normal Boot\n");
 }
 
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index dabc5316f33..16303fc187a 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -11,6 +11,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/trdc.h>
 #include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
 #include <asm/sections.h>
 #include <hang.h>
 #include <init.h>
@@ -34,6 +35,12 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 
 void spl_board_init(void)
 {
+	int ret;
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+
 	puts("Normal Boot\n");
 }
 
diff --git a/board/variscite/imx93_var_som/spl.c b/board/variscite/imx93_var_som/spl.c
index e6db4eb562b..36e17219d63 100644
--- a/board/variscite/imx93_var_som/spl.c
+++ b/board/variscite/imx93_var_som/spl.c
@@ -20,6 +20,7 @@
 #include <asm/mach-imx/mxc_i2c.h>
 #include <asm/arch-mx7ulp/gpio.h>
 #include <asm/sections.h>
+#include <asm/mach-imx/ele_api.h>
 #include <asm/mach-imx/syscounter.h>
 #include <dm/uclass.h>
 #include <dm/device.h>
@@ -47,9 +48,14 @@ int spl_board_boot_device(enum boot_device boot_dev_spl)
 void spl_board_init(void)
 {
 	struct var_eeprom *ep = VAR_EEPROM_DATA;
+	int ret;
 
 	puts("Normal Boot\n");
 
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+
 	/* Copy EEPROM contents to DRAM */
 	memcpy(ep, &eeprom, sizeof(*ep));
 }
-- 
2.41.0

