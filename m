Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56B6CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:34:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8218493A;
	Mon,  8 Jun 2026 15:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nqd4Eroh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBE683FEC; Mon,  8 Jun 2026 15:12:40 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6980E84895
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1E0041A37C8;
 Mon,  8 Jun 2026 13:12:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E4F9F5FFB7;
 Mon,  8 Jun 2026 13:12:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B29A6106A28BD; 
 Mon,  8 Jun 2026 15:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780924356; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HyiZtXtOS3Wjwk0Nb6DLFWDl80/Ze9EfOrcFdS+wXso=;
 b=nqd4ErohnP+K5287UE8Hnm3hrtcdn+mmMyyAQ9r9gk5353na/WQZ2E5ACWVWBzQqV8ota/
 Bwy8+OTyJgUFg4ZY140PR3nJsIgbSztO1RMBnlWjYZ/mPNvhQw8yjcUMS1LMK0j4QZbKC6
 YRZyb9g4lIHSoVJAdnfjAi8jiDJ0Zzp7rfuLRFdLLlngNmh3uS/77zqv5XAFELN2w9fz9d
 MbyteXUxfaNqSh5Y5UhtGK5nYKcy3o7UDI/itl6kPzJl4rseduN1J5OBtRwPvE9a6wQDtn
 wNvQZ7nWsaJPk07S4ZyjyMpoiUxbnD4mxORsHjLB56D1Xc+EFFy6ZtKmb+T21w==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Mon, 08 Jun 2026 15:12:00 +0200
Subject: [PATCH v3 4/6] configs: omap4: remove unused boot target devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-omap4-support-v3-4-8595ccd203f0@bootlin.com>
References: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
In-Reply-To: <20260608-omap4-support-v3-0-8595ccd203f0@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:33:31 +0200
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

This include file isn't used since the omap4 support has been dropped.
Since this support is about to be reintroduced, this file is going to be
used again. The upcoming support is minimal and doesn't include network,
therefore leaving PXE and DHCP in the BOOT_TARGET_DEVICES list would lead
to build errors.

Remove PXE and DHCP from the list of BOOT_TARGET_DEVICES.
Remove the LEGACY_MMC macros and the findfdt script that looks for
no-longer supported boards.
Remove the empty #ifdef XPL_BUILD

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 include/configs/ti_omap4_common.h | 40 ---------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/include/configs/ti_omap4_common.h b/include/configs/ti_omap4_common.h
index 7a333090b18..e4b84719c86 100644
--- a/include/configs/ti_omap4_common.h
+++ b/include/configs/ti_omap4_common.h
@@ -35,25 +35,9 @@
 /*
  * Environment setup
  */
-#define BOOTENV_DEV_LEGACY_MMC(devtypeu, devtypel, instance) \
-	"bootcmd_" #devtypel #instance "=" \
-	"setenv mmcdev " #instance"; "\
-	"setenv bootpart " #instance":2 ; "\
-	"run mmcboot\0"
-
-#define BOOTENV_DEV_NAME_LEGACY_MMC(devtypeu, devtypel, instance) \
-	#devtypel #instance " "
-
-#define BOOTENV_DEV_NAME_NAND(devtypeu, devtypel, instance) \
-	#devtypel #instance " "
-
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
-	func(LEGACY_MMC, legacy_mmc, 0) \
 	func(MMC, mmc, 1) \
-	func(LEGACY_MMC, legacy_mmc, 1) \
-	func(PXE, pxe, na) \
-	func(DHCP, dhcp, na)
 
 #include <config_distro_bootcmd.h>
 #include <env/ti/mmc.h>
@@ -73,30 +57,6 @@
 	"uimageboot=echo Booting from mmc${mmcdev} ...; " \
 		"run args_mmc; " \
 		"bootm ${loadaddr}\0" \
-	"findfdt="\
-		"if test $board_name = sdp4430; then " \
-			"setenv fdtfile omap4-sdp.dtb; fi; " \
-		"if test $board_name = panda; then " \
-			"setenv fdtfile omap4-panda.dtb; fi;" \
-		"if test $board_name = panda-a4; then " \
-			"setenv fdtfile omap4-panda-a4.dtb; fi;" \
-		"if test $board_name = panda-es; then " \
-			"setenv fdtfile omap4-panda-es.dtb; fi;" \
-		"if test $board_name = duovero; then " \
-			"setenv fdtfile omap4-duovero-parlor.dtb; fi;" \
-		"if test $fdtfile = undefined; then " \
-			"echo WARNING: Could not determine device tree to use; fi; \0" \
 	BOOTENV
 
-/*
- * Defines for SPL
- * It is known that this will break HS devices. Since the current size of
- * SPL is overlapped with public stack and breaking non HS devices to boot.
- * So moving TEXT_BASE down to non-HS limit.
- */
-
-#ifdef CONFIG_XPL_BUILD
-/* No need for i2c in SPL mode as we will use SRI2C for PMIC access on OMAP4 */
-#endif
-
 #endif /* __CONFIG_TI_OMAP4_COMMON_H */

-- 
2.54.0

