Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A828E6F069
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 15:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C10A488B55;
	Fri,  1 Nov 2024 16:28:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="NK1hxghe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1E7E88E42; Fri,  1 Nov 2024 16:28:23 +0100 (CET)
Received: from smtp-out.freemail.hu (fmfe27.freemail.hu [46.107.16.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E76B892E5
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 16:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from localhost.localdomain
 (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4Xg4WQ29BwzDkS;
 Fri, 01 Nov 2024 16:28:18 +0100 (CET)
From: egyszeregy@freemail.hu
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, festevam@gmail.com, peng.fan@nxp.com,
 =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v2] imx9: Improve boot mode autodetection
Date: Fri,  1 Nov 2024 16:26:18 +0100
Message-ID: <20241101152618.1118-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1730474898; 
 s=20181004; d=freemail.hu;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 l=3195; bh=T1MUV51UFA8F5MtMBLiLG8IrE1RxL2mxoV/WX3RfWWQ=;
 b=NK1hxgheb7DDatH1BihbIi6zB+oYPEIohK6pPXqUM3KNGgKs5u4AKg20f3T/5LM8
 pht9GWHNOC4FQ7oN6QYJxz96OY+egMnMu7muGp3mmatksJeKVQUj3JXvOWTCQqp+M0l
 VdVjSEoOO8qprBZeUa8LzUWSQOSKSPF83jo/Ldg259WgcT8U1KNamSaIEvqT1SRl12L
 nDC7iuy3IVorL/WZZndWl9D3phiYapo8t3PCq8BYgVKVeyAyfXwk2jsEIwT7KybZXrW
 wkS479+JC1Y4x75zjbGVUey+q+rHztS22xDkK6EryA2JQvWupYxvOM/zfNhGrEqXuYK
 mrybID0/5g==
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

From: Benjamin Szőke <egyszeregy@freemail.hu>

Improve "mmcautodetect=yes" boot mode autodetection to able to use it
if CONFIG_ENV_IS_NOWHERE=y is used for i.MX9 SoCs and i.MX93 EVK board.

If both CONFIG_ENV_IS_IN_MMC=y and CONFIG_ENV_IS_NOWHERE=y are in the
defconfig, CONFIG_ENV_IS_IN_MMC=y will be overiden default
CONFIG_ENV_IS_NOWHERE settings.

Goal is in this patch to able to use the boot mode autodetection
if defconfig use only CONFIG_ENV_IS_NOWHERE=y option
(without CONFIG_ENV_IS_IN_MMC) for any i.MX9 SoC.

Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
---
 arch/arm/mach-imx/imx9/soc.c          | 12 +++++++++---
 board/freescale/imx93_evk/imx93_evk.c |  2 +-
 include/configs/imx93_evk.h           |  8 +++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 7c28fa39e14e..21e0e7dd1e80 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -42,12 +42,18 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct rom_api *g_rom_api = (struct rom_api *)0x1980;
 
-#ifdef CONFIG_ENV_IS_IN_MMC
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
 __weak int board_mmc_get_env_dev(int devno)
 {
 	return devno;
 }
 
+#ifdef CONFIG_SYS_MMC_ENV_DEV
+#define IMX9_MMC_ENV_DEV CONFIG_SYS_MMC_ENV_DEV
+#else
+#define IMX9_MMC_ENV_DEV 0
+#endif
+
 int mmc_get_env_dev(void)
 {
 	int ret;
@@ -59,7 +65,7 @@ int mmc_get_env_dev(void)
 
 	if (ret != ROM_API_OKAY) {
 		puts("ROMAPI: failure at query_boot_info\n");
-		return CONFIG_SYS_MMC_ENV_DEV;
+		return IMX9_MMC_ENV_DEV;
 	}
 
 	boot_type = boot >> 16;
@@ -69,7 +75,7 @@ int mmc_get_env_dev(void)
 
 	/* If not boot from sd/mmc, use default value */
 	if (boot_type != BOOT_TYPE_SD && boot_type != BOOT_TYPE_MMC)
-		return env_get_ulong("mmcdev", 10, CONFIG_SYS_MMC_ENV_DEV);
+		return env_get_ulong("mmcdev", 10, IMX9_MMC_ENV_DEV);
 
 	return board_mmc_get_env_dev(boot_instance);
 }
diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index 341831a7d30d..c9171df330e2 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -58,7 +58,7 @@ int board_init(void)
 
 int board_late_init(void)
 {
-#ifdef CONFIG_ENV_IS_IN_MMC
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
 	board_late_mmc_env_init();
 #endif
 
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index 53fb8c9b1ba8..260a5043d537 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -27,6 +27,12 @@
 #define BOOTENV
 #endif
 
+#ifdef CONFIG_SYS_MMC_ENV_DEV
+#define IMX93_EVK_MMC_ENV_DEV CONFIG_SYS_MMC_ENV_DEV
+#else
+#define IMX93_EVK_MMC_ENV_DEV 0
+#endif
+
 /* Initial environment variables */
 #define CFG_EXTRA_ENV_SETTINGS		\
 	BOOTENV \
@@ -42,7 +48,7 @@
 	"boot_fit=no\0" \
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
 	"bootm_size=0x10000000\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV)"\0" \
+	"mmcdev=" __stringify(IMX93_EVK_MMC_ENV_DEV)"\0" \
 	"mmcpart=1\0" \
 	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
 	"mmcautodetect=yes\0" \
