Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85E6CF6495
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C9188EC0;
	Mon, 30 Sep 2024 03:51:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VGp+v2+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13F2D88E89; Mon, 30 Sep 2024 03:51:01 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97B2988F1E
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a0cdd77dbeso13331495ab.2
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661043; x=1728265843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcDqcDTsZ20nD09LRtltheeAl7uxCcWPnRtw5/eoBig=;
 b=VGp+v2+Mo9V5qD8xv0FQgHpIMnO0Bm7atSJKhxClFTivSANzylQ+5oKzKBQSFZrI/b
 X2E/4kbz/z3Q4s60q2OKu3IlJptacpUT4Ir64Eq40FobJaJWrfa6Fx6W0tjZJI870tP4
 C4aRQR02GVrdlhq1DWZeqX8jvcr1FnjWWaJ2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661043; x=1728265843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcDqcDTsZ20nD09LRtltheeAl7uxCcWPnRtw5/eoBig=;
 b=HgFTt/T7olLFN/1AqAhfvN4yTYFPhRtnydSYV0fVQ2k7czW9tIEgRQjTmhfmteOr3g
 ahr2i4bcvZL7l7QPN9Qx6jYcmWbqQgiGKfBY7qmnvha+kIHyQIUEo6Sl+vJ7CbeK2GZV
 Sq9d8zrvg0LTcFfWHnp4b/UuCNNIP5qNS6f/BQG2TeJJ7j5OXqiJqyqS7FFLIsTx2+iX
 4BBNtFpwzCqx9/SCCK472y9grjHS+95myXG1dKl3mWpZ3cyOiZPTEOi9HWReMP3Bju12
 K/SL8bGd9iVTccq7dpvUGRP4SaEg41qNb+G0sKB5ZsbKb+SbYwvJuZ9DC9WKkUr5R8/3
 KwTg==
X-Gm-Message-State: AOJu0YxIp4CSq5r5rFybuoEWRwvinqfra+rV47+eik/BNT0rjmVR4Nrh
 v+KksR7Bs34ss7BPI8kVY5BHdvDKSXMzOuUHZPmMBo65V9AK2d84X+KMDO23rHRZCv1P7FMM3yA
 F/w==
X-Google-Smtp-Source: AGHT+IEuNYb6u+rDphiCE9yoee1SILg5Sbbz1W1dIY8VrO5NWDhFit0fC3WBuPIR2OZBJNhUClyhhQ==
X-Received: by 2002:a05:6e02:190a:b0:3a0:9829:100b with SMTP id
 e9e14a558f8ab-3a3451be445mr75058315ab.21.1727661042481; 
 Sun, 29 Sep 2024 18:50:42 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adam Ford <aford173@gmail.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Heiko Schocher <hs@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matteo Lisi <matteo.lisi@engicam.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Oliver Graute <oliver.graute@kococonnector.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, Phil Sutter <phil@nwl.cc>,
 Qiang Zhao <qiang.zhao@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <sr@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Teresa Remmet <t.remmet@phytec.de>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v3 26/33] include: Use CONFIG_XPL_BUILD instead of
 CONFIG_SPL_BUILD
Date: Sun, 29 Sep 2024 19:49:49 -0600
Message-Id: <20240930014956.1434060-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use the new symbol to refer to any 'SPL' build, including TPL and VPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Split into several patches

 include/asm-generic/global_data.h              |  2 +-
 include/bootcount.h                            |  4 ++--
 include/config_distro_bootcmd.h                | 10 +++++-----
 include/configs/P1010RDB.h                     |  4 ++--
 include/configs/am335x_evm.h                   |  4 ++--
 include/configs/am335x_guardian.h              |  4 ++--
 include/configs/am335x_shc.h                   |  4 ++--
 include/configs/am43xx_evm.h                   |  4 ++--
 include/configs/am57xx_evm.h                   |  2 +-
 include/configs/capricorn-common.h             |  4 ++--
 include/configs/cgtqmx8.h                      |  2 +-
 include/configs/da850evm.h                     |  2 +-
 include/configs/dra7xx_evm.h                   |  4 ++--
 include/configs/ds116.h                        |  4 ++--
 include/configs/ds414.h                        |  4 ++--
 include/configs/gardena-smart-gateway-mt7688.h |  2 +-
 include/configs/imx6q-bosch-acc.h              |  2 +-
 include/configs/imx6ulz_smm_m2.h               |  4 ++--
 include/configs/imx8mm-cl-iot-gate.h           |  2 +-
 include/configs/imx8mm_beacon.h                |  2 +-
 include/configs/imx8mm_data_modul_edm_sbc.h    |  2 +-
 include/configs/imx8mm_evk.h                   |  2 +-
 include/configs/imx8mm_icore_mx8mm.h           |  4 ++--
 include/configs/imx8mm_phg.h                   |  2 +-
 include/configs/imx8mm_venice.h                |  2 +-
 include/configs/imx8mp_rsb3720.h               |  2 +-
 include/configs/imx8mq_cm.h                    |  2 +-
 include/configs/imx8mq_evk.h                   |  2 +-
 include/configs/imx8mq_phanbell.h              |  2 +-
 include/configs/imx8mq_reform2.h               |  2 +-
 include/configs/imx8qm_mek.h                   |  2 +-
 include/configs/imx8qxp_mek.h                  |  2 +-
 include/configs/imx8ulp_evk.h                  |  2 +-
 include/configs/imx93_evk.h                    |  2 +-
 include/configs/kontron-sl-mx8mm.h             |  4 ++--
 include/configs/kontron_pitx_imx8m.h           |  2 +-
 include/configs/librem5.h                      |  2 +-
 include/configs/linkit-smart-7688.h            |  2 +-
 include/configs/ls1043a_common.h               |  6 +++---
 include/configs/ls1046a_common.h               |  6 +++---
 include/configs/ls1088a_common.h               |  2 +-
 include/configs/msc_sm2s_imx8mp.h              |  2 +-
 include/configs/mt7621.h                       |  2 +-
 include/configs/mt7628.h                       |  2 +-
 include/configs/n2350.h                        |  4 ++--
 include/configs/p1_p2_rdb_pc.h                 |  4 ++--
 include/configs/phycore_imx8mm.h               |  2 +-
 include/configs/pico-imx8mq.h                  |  2 +-
 include/configs/rk3399_common.h                |  4 ++--
 include/configs/rockchip-common.h              |  2 +-
 include/configs/socfpga_common.h               |  2 +-
 include/configs/stm32mp15_common.h             |  4 ++--
 include/configs/stm32mp15_dh_dhsom.h           |  2 +-
 include/configs/ti_omap3_common.h              |  2 +-
 include/configs/ti_omap4_common.h              |  2 +-
 include/configs/turris_1x.h                    |  4 ++--
 include/configs/turris_omnia.h                 |  4 ++--
 include/configs/verdin-imx8mm.h                |  2 +-
 include/configs/verdin-imx8mp.h                |  4 ++--
 include/configs/vining_2000.h                  |  2 +-
 include/configs/xilinx_zynqmp.h                |  2 +-
 include/configs/zynq-common.h                  |  4 ++--
 include/env.h                                  |  2 +-
 include/env_callback.h                         |  2 +-
 include/fdtdec.h                               |  2 +-
 include/image-android-dt.h                     |  2 +-
 include/iotrace.h                              |  2 +-
 include/linux/kconfig.h                        | 18 +++++++++---------
 include/mmc.h                                  |  2 +-
 include/mtd/cfi_flash.h                        |  2 +-
 include/net.h                                  |  6 +++---
 include/part.h                                 |  2 +-
 include/sdp.h                                  |  2 +-
 include/search.h                               |  2 +-
 include/spl.h                                  | 14 +++++++-------
 include/stdio.h                                |  2 +-
 include/sunxi_gpio.h                           |  2 +-
 include/upl.h                                  |  4 ++--
 include/vbe.h                                  |  2 +-
 79 files changed, 125 insertions(+), 125 deletions(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index d6c15e2c406..644a0d77873 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -55,7 +55,7 @@ struct global_data {
 	 * @cur_serial_dev: current serial device
 	 */
 	struct udevice *cur_serial_dev;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/**
 	 * @jt: jump table
 	 *
diff --git a/include/bootcount.h b/include/bootcount.h
index bc06e17c9fb..847c0f02d98 100644
--- a/include/bootcount.h
+++ b/include/bootcount.h
@@ -120,13 +120,13 @@ static inline void bootcount_inc(void)
 		return;
 	}
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	/* Only increment bootcount when no bootcount support in SPL */
 #if !defined(CONFIG_SPL_BOOTCOUNT_LIMIT) && !defined(CONFIG_TPL_BOOTCOUNT_LIMIT)
 	bootcount_store(++bootcount);
 #endif
 	env_set_ulong("bootcount", bootcount);
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
 }
 
 #else
diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 2a136b96a6d..0a4e4b8ff85 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -63,7 +63,7 @@
 #define BOOTENV_SHARED_MMC	BOOTENV_SHARED_BLKDEV(mmc)
 #define BOOTENV_DEV_MMC		BOOTENV_DEV_BLKDEV
 #define BOOTENV_DEV_NAME_MMC	BOOTENV_DEV_NAME_BLKDEV
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_SHARED_MMC
 #define BOOTENV_DEV_MMC		BOOTENV_DEV_BLKDEV_NONE
 #define BOOTENV_DEV_NAME_MMC	BOOTENV_DEV_NAME_BLKDEV_NONE
@@ -198,7 +198,7 @@
 #define BOOTENV_SHARED_SATA	BOOTENV_SHARED_BLKDEV(sata)
 #define BOOTENV_DEV_SATA	BOOTENV_DEV_BLKDEV
 #define BOOTENV_DEV_NAME_SATA	BOOTENV_DEV_NAME_BLKDEV
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_SHARED_SATA
 #define BOOTENV_DEV_SATA	BOOTENV_DEV_BLKDEV_NONE
 #define BOOTENV_DEV_NAME_SATA	BOOTENV_DEV_NAME_BLKDEV_NONE
@@ -305,7 +305,7 @@
 		BOOTENV_SHARED_BLKDEV_BODY(usb)
 #define BOOTENV_DEV_USB		BOOTENV_DEV_BLKDEV
 #define BOOTENV_DEV_NAME_USB	BOOTENV_DEV_NAME_BLKDEV
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_RUN_NET_USB_START
 #define BOOTENV_SHARED_USB
 #define BOOTENV_DEV_USB		BOOTENV_DEV_BLKDEV_NONE
@@ -412,7 +412,7 @@
 		"\0"
 #define BOOTENV_DEV_NAME_DHCP(devtypeu, devtypel, instance) \
 	"dhcp "
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_DEV_DHCP	BOOTENV_DEV_BLKDEV_NONE
 #define BOOTENV_DEV_NAME_DHCP	BOOTENV_DEV_NAME_BLKDEV_NONE
 #else
@@ -433,7 +433,7 @@
 		"fi\0"
 #define BOOTENV_DEV_NAME_PXE(devtypeu, devtypel, instance) \
 	"pxe "
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define BOOTENV_DEV_PXE		BOOTENV_DEV_BLKDEV_NONE
 #define BOOTENV_DEV_NAME_PXE	BOOTENV_DEV_NAME_BLKDEV_NONE
 #else
diff --git a/include/configs/P1010RDB.h b/include/configs/P1010RDB.h
index 9efae58ce90..20fded56b77 100644
--- a/include/configs/P1010RDB.h
+++ b/include/configs/P1010RDB.h
@@ -43,7 +43,7 @@
 #define CFG_SYS_NAND_U_BOOT_SIZE	(576 << 10)
 #define CFG_SYS_NAND_U_BOOT_DST	(0x11000000)
 #define CFG_SYS_NAND_U_BOOT_START	(0x11000000)
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define CFG_SYS_NAND_U_BOOT_SIZE	(128 << 10)
 #define CFG_SYS_NAND_U_BOOT_DST	0xD0000000
 #define CFG_SYS_NAND_U_BOOT_START	0xD0000000
@@ -290,7 +290,7 @@ extern unsigned long get_sdram_size(void);
 /*
  * Config the L2 Cache as L2 SRAM
  */
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_SDCARD) || defined(CONFIG_SPIFLASH)
 #define CFG_SYS_INIT_L2_ADDR		0xD0000000
 #define CFG_SYS_INIT_L2_ADDR_PHYS	CFG_SYS_INIT_L2_ADDR
diff --git a/include/configs/am335x_evm.h b/include/configs/am335x_evm.h
index 67f46562539..19d3c72a6f1 100644
--- a/include/configs/am335x_evm.h
+++ b/include/configs/am335x_evm.h
@@ -75,7 +75,7 @@
 
 #include <config_distro_bootcmd.h>
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <env/ti/dfu.h>
 
 #define CFG_EXTRA_ENV_SETTINGS \
@@ -181,7 +181,7 @@
 #endif /* !CONFIG_MTD_RAW_NAND */
 
 /* USB Device Firmware Update support */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define DFUARGS \
 	DFU_ALT_INFO_EMMC \
 	DFU_ALT_INFO_MMC \
diff --git a/include/configs/am335x_guardian.h b/include/configs/am335x_guardian.h
index a8fa61c7e50..96efd38594a 100644
--- a/include/configs/am335x_guardian.h
+++ b/include/configs/am335x_guardian.h
@@ -16,7 +16,7 @@
 #define V_OSCK				24000000  /* Clock output from T2 */
 #define V_SCLK				(V_OSCK)
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define MEM_LAYOUT_ENV_SETTINGS \
 	"scriptaddr=0x80000000\0" \
@@ -70,7 +70,7 @@
 		"setenv boot_syslinux_conf \"extlinux/extlinux.conf\"; " \
 		"run bootcmd_ubifs0;\0"
 
-#endif /* ! CONFIG_SPL_BUILD */
+#endif /* ! CONFIG_XPL_BUILD */
 
 #define SPLASH_SCREEN_NAND_PART "nand0,10"
 #define SPLASH_SCREEN_BMP_FILE_SIZE 0x26000
diff --git a/include/configs/am335x_shc.h b/include/configs/am335x_shc.h
index dedef91ba59..55d5190b221 100644
--- a/include/configs/am335x_shc.h
+++ b/include/configs/am335x_shc.h
@@ -20,7 +20,7 @@
 #define V_OSCK				24000000  /* Clock output from T2 */
 #define V_SCLK				(V_OSCK)
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define CFG_EXTRA_ENV_SETTINGS \
 	"loadaddr=0x80200000\0" \
 	"kloadaddr=0x84000000\0" \
@@ -117,7 +117,7 @@
 			"setenv mmcpart 5; " \
 		"fi; " \
 		"setenv mmcroot /dev/mmcblk${mmcdev}p${mmcpart};\0"
-#endif /* #ifndef CONFIG_SPL_BUILD */
+#endif /* #ifndef CONFIG_XPL_BUILD */
 
 #if defined CONFIG_SHC_NETBOOT
 /* Network Boot */
diff --git a/include/configs/am43xx_evm.h b/include/configs/am43xx_evm.h
index 87ffa769d15..036995cbb48 100644
--- a/include/configs/am43xx_evm.h
+++ b/include/configs/am43xx_evm.h
@@ -35,7 +35,7 @@
 /* NS16550 Configuration */
 #define CFG_SYS_NS16550_COM1		0x44e09000	/* Base EVM has UART0 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /* USB Device Firmware Update support */
 #define DFUARGS \
 	"dfu_bufsiz=0x10000\0" \
@@ -63,7 +63,7 @@
 
 #include <config_distro_bootcmd.h>
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #include <env/ti/dfu.h>
 
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/am57xx_evm.h b/include/configs/am57xx_evm.h
index 4b4362ccfd8..aa31f3b05a0 100644
--- a/include/configs/am57xx_evm.h
+++ b/include/configs/am57xx_evm.h
@@ -18,7 +18,7 @@
 #define CFG_SYS_NS16550_COM2		UART2_BASE	/* UART2 */
 #define CFG_SYS_NS16550_COM3		UART3_BASE	/* UART3 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define DFUARGS \
 	"dfu_bufsiz=0x10000\0" \
 	DFU_ALT_INFO_MMC \
diff --git a/include/configs/capricorn-common.h b/include/configs/capricorn-common.h
index 9dcacad2fc0..1f61b2b6af6 100644
--- a/include/configs/capricorn-common.h
+++ b/include/configs/capricorn-common.h
@@ -13,10 +13,10 @@
 #include "siemens-env-common.h"
 
 /* SPL config */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x00120000
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* ENET1 connects to base board and MUX with ESAI */
 #define CFG_FEC_ENET_DEV		1
diff --git a/include/configs/cgtqmx8.h b/include/configs/cgtqmx8.h
index 98d4d8cf4bd..0d338389cb9 100644
--- a/include/configs/cgtqmx8.h
+++ b/include/configs/cgtqmx8.h
@@ -11,7 +11,7 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x00120000
 
 #endif
diff --git a/include/configs/da850evm.h b/include/configs/da850evm.h
index 416aa96366c..8db849c6d09 100644
--- a/include/configs/da850evm.h
+++ b/include/configs/da850evm.h
@@ -157,7 +157,7 @@
 	"console=ttyS2,115200n8\0" \
 	"hwconfig=dsp:wake=yes"
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* defines for SPL */
 
 #endif
diff --git a/include/configs/dra7xx_evm.h b/include/configs/dra7xx_evm.h
index 633ec1f32fa..96dcd731cb6 100644
--- a/include/configs/dra7xx_evm.h
+++ b/include/configs/dra7xx_evm.h
@@ -28,7 +28,7 @@
 #define CFG_SYS_NS16550_COM2		UART2_BASE	/* UART2 */
 #define CFG_SYS_NS16550_COM3		UART3_BASE	/* UART3 */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define DFUARGS \
 	"dfu_bufsiz=0x10000\0" \
 	DFU_ALT_INFO_MMC \
@@ -37,7 +37,7 @@
 	DFU_ALT_INFO_QSPI
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #ifdef CONFIG_SPL_DFU
 #define DFUARGS \
 	"dfu_bufsiz=0x10000\0" \
diff --git a/include/configs/ds116.h b/include/configs/ds116.h
index c2326596811..2f2bc43269e 100644
--- a/include/configs/ds116.h
+++ b/include/configs/ds116.h
@@ -18,7 +18,7 @@
  */
 #include "mv-common.h"
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define KERNEL_ADDR_R	__stringify(0x1000000)
 #define FDT_ADDR_R	__stringify(0x2000000)
@@ -39,6 +39,6 @@
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	"console=ttyS0,115200\0"
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _CONFIG_DS116_H */
diff --git a/include/configs/ds414.h b/include/configs/ds414.h
index 95256575583..431a78de416 100644
--- a/include/configs/ds414.h
+++ b/include/configs/ds414.h
@@ -43,7 +43,7 @@
  */
 #include "mv-common.h"
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define KERNEL_ADDR_R	__stringify(0x1000000)
 #define FDT_ADDR_R	__stringify(0x2000000)
@@ -80,6 +80,6 @@
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	"console=ttyS0,115200\0"
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _CONFIG_SYNOLOGY_DS414_H */
diff --git a/include/configs/gardena-smart-gateway-mt7688.h b/include/configs/gardena-smart-gateway-mt7688.h
index 1b97ae22fc6..a89d298b525 100644
--- a/include/configs/gardena-smart-gateway-mt7688.h
+++ b/include/configs/gardena-smart-gateway-mt7688.h
@@ -15,7 +15,7 @@
 #define CFG_SYS_UBOOT_BASE		0
 
 /* Serial SPL */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_SERIAL)
 #define CFG_SYS_NS16550_CLK		40000000
 #define CFG_SYS_NS16550_COM1		0xb0000c00
 #endif
diff --git a/include/configs/imx6q-bosch-acc.h b/include/configs/imx6q-bosch-acc.h
index fab5063b73f..64ddbf711d3 100644
--- a/include/configs/imx6q-bosch-acc.h
+++ b/include/configs/imx6q-bosch-acc.h
@@ -92,7 +92,7 @@
 /* SPL */
 #ifdef CONFIG_SPL
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_SYS_FSL_USDHC_NUM 2
 
 #ifdef CONFIG_SYS_BOOT_EMMC
diff --git a/include/configs/imx6ulz_smm_m2.h b/include/configs/imx6ulz_smm_m2.h
index 9da98d0af27..44a3fc02e8a 100644
--- a/include/configs/imx6ulz_smm_m2.h
+++ b/include/configs/imx6ulz_smm_m2.h
@@ -14,14 +14,14 @@
 
 #define CFG_MXC_UART_BASE		UART4_BASE
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(NAND, nand, 0) \
 
 #include <config_distro_bootcmd.h>
 
-#endif /* !CONFIG_SPL_BUILD */
+#endif /* !CONFIG_XPL_BUILD */
 
 #define MEM_LAYOUT_ENV_SETTINGS \
 	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
diff --git a/include/configs/imx8mm-cl-iot-gate.h b/include/configs/imx8mm-cl-iot-gate.h
index 146f7945719..6ed4a6fd3fc 100644
--- a/include/configs/imx8mm-cl-iot-gate.h
+++ b/include/configs/imx8mm-cl-iot-gate.h
@@ -14,7 +14,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x912000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/imx8mm_beacon.h b/include/configs/imx8mm_beacon.h
index fa20651d2df..2ec7f3d8b6f 100644
--- a/include/configs/imx8mm_beacon.h
+++ b/include/configs/imx8mm_beacon.h
@@ -21,7 +21,7 @@
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/imx8mm_data_modul_edm_sbc.h b/include/configs/imx8mm_data_modul_edm_sbc.h
index 9a5e5bd009d..d323f84ac7a 100644
--- a/include/configs/imx8mm_data_modul_edm_sbc.h
+++ b/include/configs/imx8mm_data_modul_edm_sbc.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x930000
 
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/imx8mm_evk.h b/include/configs/imx8mm_evk.h
index 9dd63fc1196..3bbbd900dd4 100644
--- a/include/configs/imx8mm_evk.h
+++ b/include/configs/imx8mm_evk.h
@@ -22,7 +22,7 @@
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/imx8mm_icore_mx8mm.h b/include/configs/imx8mm_icore_mx8mm.h
index 2158b0af74f..145dab91215 100644
--- a/include/configs/imx8mm_icore_mx8mm.h
+++ b/include/configs/imx8mm_icore_mx8mm.h
@@ -13,11 +13,11 @@
 #define CFG_SYS_UBOOT_BASE \
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 # define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 2) \
diff --git a/include/configs/imx8mm_phg.h b/include/configs/imx8mm_phg.h
index d2d7ffa0f5b..038d3a7ce3f 100644
--- a/include/configs/imx8mm_phg.h
+++ b/include/configs/imx8mm_phg.h
@@ -14,7 +14,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 #endif
diff --git a/include/configs/imx8mm_venice.h b/include/configs/imx8mm_venice.h
index 66816618b0c..ed09dd09bcb 100644
--- a/include/configs/imx8mm_venice.h
+++ b/include/configs/imx8mm_venice.h
@@ -12,7 +12,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 #endif
diff --git a/include/configs/imx8mp_rsb3720.h b/include/configs/imx8mp_rsb3720.h
index b82e35f4963..8b96f7fd1e4 100644
--- a/include/configs/imx8mp_rsb3720.h
+++ b/include/configs/imx8mp_rsb3720.h
@@ -23,7 +23,7 @@
 	EFI_GUID(0xb5fb6f08, 0xe142, 0x4db1, 0x97, 0xea, \
 		 0x5f, 0xd3, 0x6b, 0x9b, 0xe5, 0xb9)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x184000 /* malloc f used before \
 						  * GD_FLG_FULL_MALLOC_INIT \
 						  * set \
diff --git a/include/configs/imx8mq_cm.h b/include/configs/imx8mq_cm.h
index 2bbd6b1680f..ccbb0f85559 100644
--- a/include/configs/imx8mq_cm.h
+++ b/include/configs/imx8mq_cm.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x182000
diff --git a/include/configs/imx8mq_evk.h b/include/configs/imx8mq_evk.h
index 9eefc31dc6f..666f46ac105 100644
--- a/include/configs/imx8mq_evk.h
+++ b/include/configs/imx8mq_evk.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
diff --git a/include/configs/imx8mq_phanbell.h b/include/configs/imx8mq_phanbell.h
index cd73a72d2b7..3bc4b0034e8 100644
--- a/include/configs/imx8mq_phanbell.h
+++ b/include/configs/imx8mq_phanbell.h
@@ -9,7 +9,7 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
diff --git a/include/configs/imx8mq_reform2.h b/include/configs/imx8mq_reform2.h
index 7fa441a8a83..40f96a5f219 100644
--- a/include/configs/imx8mq_reform2.h
+++ b/include/configs/imx8mq_reform2.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
diff --git a/include/configs/imx8qm_mek.h b/include/configs/imx8qm_mek.h
index 4d5abe2d073..842184bcae2 100644
--- a/include/configs/imx8qm_mek.h
+++ b/include/configs/imx8qm_mek.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x00120000
 
 #endif
diff --git a/include/configs/imx8qxp_mek.h b/include/configs/imx8qxp_mek.h
index 93999509948..1b6eb2b81cf 100644
--- a/include/configs/imx8qxp_mek.h
+++ b/include/configs/imx8qxp_mek.h
@@ -10,7 +10,7 @@
 #include <linux/stringify.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x00120000
 
 #endif
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index aa9da19a11f..9308f5234f4 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -11,7 +11,7 @@
 
 #define CFG_SYS_UBOOT_BASE	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x22040000
 
 #endif
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index ce6567e2af6..53fb8c9b1ba 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -13,7 +13,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x204D0000
 #endif
 
diff --git a/include/configs/kontron-sl-mx8mm.h b/include/configs/kontron-sl-mx8mm.h
index 3a129c5cce7..72a28a6a413 100644
--- a/include/configs/kontron-sl-mx8mm.h
+++ b/include/configs/kontron-sl-mx8mm.h
@@ -10,7 +10,7 @@
 #include <asm/arch/imx-regs.h>
 #include <linux/sizes.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <config.h>
 #endif
 
@@ -39,7 +39,7 @@
 #undef BOOTENV_RUN_NET_USB_START
 #define BOOTENV_RUN_NET_USB_START
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 #endif
diff --git a/include/configs/kontron_pitx_imx8m.h b/include/configs/kontron_pitx_imx8m.h
index 3dda7b66806..3f52d00d6c8 100644
--- a/include/configs/kontron_pitx_imx8m.h
+++ b/include/configs/kontron_pitx_imx8m.h
@@ -12,7 +12,7 @@
 	EFI_GUID(0xc898e959, 0x5b1f, 0x4e6d, 0x88, 0xe0, \
 		 0x40, 0xd4, 0x5c, 0xca, 0x13, 0x99)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x182000
diff --git a/include/configs/librem5.h b/include/configs/librem5.h
index 876b02f4da6..571c7724eaf 100644
--- a/include/configs/librem5.h
+++ b/include/configs/librem5.h
@@ -41,7 +41,7 @@
 #define CONSOLE		"ttymxc0"
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
 	func(USB, usb, 0) \
diff --git a/include/configs/linkit-smart-7688.h b/include/configs/linkit-smart-7688.h
index e8f7a59c401..ec1aa14be01 100644
--- a/include/configs/linkit-smart-7688.h
+++ b/include/configs/linkit-smart-7688.h
@@ -15,7 +15,7 @@
 #define CFG_SYS_UBOOT_BASE		0
 
 /* Serial SPL */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_SERIAL)
 #define CFG_SYS_NS16550_CLK		40000000
 #define CFG_SYS_NS16550_COM3		0xb0000e00
 
diff --git a/include/configs/ls1043a_common.h b/include/configs/ls1043a_common.h
index e500a7d80ff..a02c752bbcf 100644
--- a/include/configs/ls1043a_common.h
+++ b/include/configs/ls1043a_common.h
@@ -8,7 +8,7 @@
 #define __LS1043A_COMMON_H
 
 /* SPL build */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SPL_NO_FMAN
 #define SPL_NO_DSPI
 #define SPL_NO_PCIE
@@ -19,10 +19,10 @@
 #define SPL_NO_QE
 #define SPL_NO_EEPROM
 #endif
-#if (defined(CONFIG_SPL_BUILD) && defined(CONFIG_NAND_BOOT))
+#if (defined(CONFIG_XPL_BUILD) && defined(CONFIG_NAND_BOOT))
 #define SPL_NO_MMC
 #endif
-#if (defined(CONFIG_SPL_BUILD) && defined(CONFIG_SD_BOOT_QSPI))
+#if (defined(CONFIG_XPL_BUILD) && defined(CONFIG_SD_BOOT_QSPI))
 #define SPL_NO_IFC
 #endif
 
diff --git a/include/configs/ls1046a_common.h b/include/configs/ls1046a_common.h
index 867b098a073..53ef5975a28 100644
--- a/include/configs/ls1046a_common.h
+++ b/include/configs/ls1046a_common.h
@@ -8,7 +8,7 @@
 #define __LS1046A_COMMON_H
 
 /* SPL build */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SPL_NO_QBMAN
 #define SPL_NO_FMAN
 #define SPL_NO_ENV
@@ -17,11 +17,11 @@
 #define SPL_NO_USB
 #define SPL_NO_SATA
 #endif
-#if defined(CONFIG_SPL_BUILD) && \
+#if defined(CONFIG_XPL_BUILD) && \
 	(defined(CONFIG_NAND_BOOT) || defined(CONFIG_QSPI_BOOT))
 #define SPL_NO_MMC
 #endif
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #define SPL_NO_IFC
 #endif
 
diff --git a/include/configs/ls1088a_common.h b/include/configs/ls1088a_common.h
index 34085eeecc7..cdf281947dc 100644
--- a/include/configs/ls1088a_common.h
+++ b/include/configs/ls1088a_common.h
@@ -7,7 +7,7 @@
 #define __LS1088_COMMON_H
 
 /* SPL build */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define SPL_NO_BOARDINFO
 #define SPL_NO_QIXIS
 #define SPL_NO_PCI
diff --git a/include/configs/msc_sm2s_imx8mp.h b/include/configs/msc_sm2s_imx8mp.h
index ea5c93ecf69..985b1ca91e6 100644
--- a/include/configs/msc_sm2s_imx8mp.h
+++ b/include/configs/msc_sm2s_imx8mp.h
@@ -20,7 +20,7 @@
 #define CFG_FEC_MXC_PHYADDR          1
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 1) \
 	func(MMC, mmc, 2)
diff --git a/include/configs/mt7621.h b/include/configs/mt7621.h
index e6dba707195..636d62dd883 100644
--- a/include/configs/mt7621.h
+++ b/include/configs/mt7621.h
@@ -15,7 +15,7 @@
 #define CFG_SYS_INIT_SP_OFFSET		0x800000
 
 /* Serial SPL */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_SERIAL)
 #define CFG_SYS_NS16550_CLK		50000000
 #define CFG_SYS_NS16550_COM1		0xbe000c00
 #endif
diff --git a/include/configs/mt7628.h b/include/configs/mt7628.h
index 1df06811d65..ba876ac3029 100644
--- a/include/configs/mt7628.h
+++ b/include/configs/mt7628.h
@@ -13,7 +13,7 @@
 #define CFG_SYS_INIT_SP_OFFSET		0x80000
 
 /* Serial SPL */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_SERIAL)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_SERIAL)
 #define CFG_SYS_NS16550_CLK		40000000
 #define CFG_SYS_NS16550_COM1		0xb0000c00
 #endif
diff --git a/include/configs/n2350.h b/include/configs/n2350.h
index f98b9f8582d..c789df55bfb 100644
--- a/include/configs/n2350.h
+++ b/include/configs/n2350.h
@@ -18,7 +18,7 @@
  */
 #include "mv-common.h"
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define KERNEL_ADDR_R	__stringify(0x1000000)
 #define FDT_ADDR_R	__stringify(0x2000000)
@@ -39,6 +39,6 @@
 	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
 	"console=ttyS0,115200\0"
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _CONFIG_N2350_H */
diff --git a/include/configs/p1_p2_rdb_pc.h b/include/configs/p1_p2_rdb_pc.h
index f5bd0913449..23d8917b718 100644
--- a/include/configs/p1_p2_rdb_pc.h
+++ b/include/configs/p1_p2_rdb_pc.h
@@ -98,7 +98,7 @@
 #define CFG_SYS_NAND_U_BOOT_SIZE	(832 << 10)
 #define CFG_SYS_NAND_U_BOOT_DST	(0x11000000)
 #define CFG_SYS_NAND_U_BOOT_START	(0x11000000)
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define CFG_SYS_NAND_U_BOOT_SIZE	(128 << 10)
 #define CFG_SYS_NAND_U_BOOT_DST	0xf8f80000
 #define CFG_SYS_NAND_U_BOOT_START	0xf8f80000
@@ -280,7 +280,7 @@
 /*
  * Config the L2 Cache as L2 SRAM
 */
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 #if defined(CONFIG_SDCARD) || defined(CONFIG_SPIFLASH)
 #define CFG_SYS_INIT_L2_ADDR		0xf8f80000
 #define CFG_SYS_INIT_L2_ADDR_PHYS	CFG_SYS_INIT_L2_ADDR
diff --git a/include/configs/phycore_imx8mm.h b/include/configs/phycore_imx8mm.h
index 0910ae2d870..e74a3f184c6 100644
--- a/include/configs/phycore_imx8mm.h
+++ b/include/configs/phycore_imx8mm.h
@@ -14,7 +14,7 @@
 #define CFG_SYS_UBOOT_BASE \
 		(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/pico-imx8mq.h b/include/configs/pico-imx8mq.h
index 422b89a3dd3..3012f64c0ae 100644
--- a/include/configs/pico-imx8mq.h
+++ b/include/configs/pico-imx8mq.h
@@ -9,7 +9,7 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /*#define CONFIG_ENABLE_DDR_TRAINING_DEBUG*/
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
index d652ae4ca34..c5bcd7dc5e8 100644
--- a/include/configs/rk3399_common.h
+++ b/include/configs/rk3399_common.h
@@ -13,7 +13,7 @@
 #define CFG_SYS_SDRAM_BASE		0
 #define SDRAM_MAX_SIZE			0xf8000000
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #ifndef ROCKCHIP_DEVICE_SETTINGS
 #define ROCKCHIP_DEVICE_SETTINGS
@@ -38,6 +38,6 @@
 	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* __CONFIG_RK3399_COMMON_H */
diff --git a/include/configs/rockchip-common.h b/include/configs/rockchip-common.h
index 9121bba3738..9b8ab3cdf20 100644
--- a/include/configs/rockchip-common.h
+++ b/include/configs/rockchip-common.h
@@ -11,7 +11,7 @@
 #define CFG_CPUID_OFFSET	0x7
 #endif
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define BOOT_TARGETS	"mmc1 mmc0 nvme scsi usb pxe dhcp spi"
 
diff --git a/include/configs/socfpga_common.h b/include/configs/socfpga_common.h
index 4838bfd4f13..2acfdc7df4a 100644
--- a/include/configs/socfpga_common.h
+++ b/include/configs/socfpga_common.h
@@ -117,7 +117,7 @@
 /* SPL NAND boot support */
 
 /* Extra Environment */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #ifdef CONFIG_CMD_DHCP
 #define BOOT_TARGET_DEVICES_DHCP(func) func(DHCP, dhcp, na)
diff --git a/include/configs/stm32mp15_common.h b/include/configs/stm32mp15_common.h
index 29a1197b5ae..af6dd4a8095 100644
--- a/include/configs/stm32mp15_common.h
+++ b/include/configs/stm32mp15_common.h
@@ -33,7 +33,7 @@
 #ifdef CONFIG_DISTRO_DEFAULTS
 /*****************************************************************************/
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 
 #ifdef CONFIG_CMD_MMC
 #define BOOT_TARGET_MMC0(func)	func(MMC, mmc, 0)
@@ -129,7 +129,7 @@
 	STM32MP_EXTRA \
 	STM32MP_BOARD_EXTRA_ENV
 
-#endif /* ifndef CONFIG_SPL_BUILD */
+#endif /* ifndef CONFIG_XPL_BUILD */
 #endif /* ifdef CONFIG_DISTRO_DEFAULTS*/
 
 #endif /* __CONFIG_STM32MP15_COMMMON_H */
diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
index 6fe6e7b9b8c..0f466711cae 100644
--- a/include/configs/stm32mp15_dh_dhsom.h
+++ b/include/configs/stm32mp15_dh_dhsom.h
@@ -10,7 +10,7 @@
 
 /* PHY needs a longer autoneg timeout */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_EXTRA_ENV_SETTINGS						\
 	"dfu_alt_info_ram=u-boot.itb ram "				\
 			__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS)	\
diff --git a/include/configs/ti_omap3_common.h b/include/configs/ti_omap3_common.h
index 45f7179f035..4a7474ff3f9 100644
--- a/include/configs/ti_omap3_common.h
+++ b/include/configs/ti_omap3_common.h
@@ -31,7 +31,7 @@
 					115200}
 
 /* Select serial console configuration */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_SYS_NS16550_COM1		OMAP34XX_UART1
 #define CFG_SYS_NS16550_COM2		OMAP34XX_UART2
 #define CFG_SYS_NS16550_COM3		OMAP34XX_UART3
diff --git a/include/configs/ti_omap4_common.h b/include/configs/ti_omap4_common.h
index c4f116aabf8..7a333090b18 100644
--- a/include/configs/ti_omap4_common.h
+++ b/include/configs/ti_omap4_common.h
@@ -95,7 +95,7 @@
  * So moving TEXT_BASE down to non-HS limit.
  */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* No need for i2c in SPL mode as we will use SRI2C for PMIC access on OMAP4 */
 #endif
 
diff --git a/include/configs/turris_1x.h b/include/configs/turris_1x.h
index 3d398a6c1ec..c05614950c7 100644
--- a/include/configs/turris_1x.h
+++ b/include/configs/turris_1x.h
@@ -63,7 +63,7 @@
 /*
  * For SD card builds without SPL it is needed to set CONFIG_SYS_RAMBOOT
  *
- * if CONFIG_SPL_BUILD
+ * if CONFIG_XPL_BUILD
  *     if CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR
  *         define CONFIG_SPL_MAX_SIZE = (CONFIG_SYS_L2_SIZE+CONFIG_FSL_PREPBL_ESDHC_BOOT_SECTOR_DATA
  *                                      * SZ_512)
@@ -121,7 +121,7 @@
  */
 
 /* Initial SRAM is used only for SD card boot in first stage image */
-#if !defined(CONFIG_SPL) || defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_SPL) || defined(CONFIG_XPL_BUILD)
 #define CFG_SYS_INIT_L2_ADDR		0xf8f80000
 #define CFG_SYS_INIT_L2_ADDR_PHYS	CFG_SYS_INIT_L2_ADDR
 /*
diff --git a/include/configs/turris_omnia.h b/include/configs/turris_omnia.h
index 302194bc90f..03a12d519f2 100644
--- a/include/configs/turris_omnia.h
+++ b/include/configs/turris_omnia.h
@@ -31,7 +31,7 @@
 #include "mv-common.h"
 
 /* Include the common distro boot environment */
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(MMC, mmc, 0) \
@@ -86,6 +86,6 @@
 	"bootcmd_rescue=" TURRIS_OMNIA_BOOTCMD_RESCUE "\0" \
 	BOOTENV
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #endif /* _CONFIG_TURRIS_OMNIA_H */
diff --git a/include/configs/verdin-imx8mm.h b/include/configs/verdin-imx8mm.h
index b018bbe29dd..c54383b886e 100644
--- a/include/configs/verdin-imx8mm.h
+++ b/include/configs/verdin-imx8mm.h
@@ -12,7 +12,7 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR		0x930000
 /* For RAW image gives a error info not panic */
diff --git a/include/configs/verdin-imx8mp.h b/include/configs/verdin-imx8mp.h
index 0b88e95603d..bff417fdafb 100644
--- a/include/configs/verdin-imx8mp.h
+++ b/include/configs/verdin-imx8mp.h
@@ -12,13 +12,13 @@
 #define CFG_SYS_UBOOT_BASE	\
 	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 
 /* malloc f used before GD_FLG_FULL_MALLOC_INIT set */
 #define CFG_MALLOC_F_ADDR				0x184000
 /* For RAW image gives a error info not panic */
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 #define MEM_LAYOUT_ENV_SETTINGS \
 	"fdt_addr_r=0x50200000\0" \
diff --git a/include/configs/vining_2000.h b/include/configs/vining_2000.h
index 2cf7bc70d8d..752b23d055c 100644
--- a/include/configs/vining_2000.h
+++ b/include/configs/vining_2000.h
@@ -47,7 +47,7 @@
 /* 0=user, 1=boot0, 2=boot1, * 4..7=general0..3. */
 #endif
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define CFG_MXC_UART_BASE		UART1_BASE
 #endif
 
diff --git a/include/configs/xilinx_zynqmp.h b/include/configs/xilinx_zynqmp.h
index de0db7bb63f..bb0db7c5ca3 100644
--- a/include/configs/xilinx_zynqmp.h
+++ b/include/configs/xilinx_zynqmp.h
@@ -183,7 +183,7 @@
 #endif
 
 /* SPL can't handle all huge variables - define just DFU */
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_DFU)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_DFU)
 #undef CFG_EXTRA_ENV_SETTINGS
 # define CFG_EXTRA_ENV_SETTINGS \
 	"dfu_alt_info_ram=uboot.bin ram 0x8000000 0x1000000;" \
diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
index 03af859c951..37c77aa1611 100644
--- a/include/configs/zynq-common.h
+++ b/include/configs/zynq-common.h
@@ -44,7 +44,7 @@
 
 /* Boot configuration */
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define BOOTENV
 #else
 
@@ -167,7 +167,7 @@
 	BOOT_TARGET_DEVICES_DHCP(func)
 
 #include <config_distro_bootcmd.h>
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
 /* Default environment */
 #ifndef CFG_EXTRA_ENV_SETTINGS
diff --git a/include/env.h b/include/env.h
index d2a5954ded8..01c3eeae7e2 100644
--- a/include/env.h
+++ b/include/env.h
@@ -44,7 +44,7 @@ struct env_clbk_tbl {
  * For SPL these are silently dropped to reduce code size, since environment
  * callbacks are not supported with SPL.
  */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define U_BOOT_ENV_CALLBACK(name, callback) \
 	static inline __maybe_unused void _u_boot_env_noop_##name(void) \
 	{ \
diff --git a/include/env_callback.h b/include/env_callback.h
index 8e500aaaf80..5121ae07fd9 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -85,7 +85,7 @@
 	"serial#:serialno," \
 	CFG_ENV_CALLBACK_LIST_STATIC
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 void env_callback_init(struct env_entry *var_entry);
 #else
 static inline void env_callback_init(struct env_entry *var_entry)
diff --git a/include/fdtdec.h b/include/fdtdec.h
index e80de24076c..555c9520379 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -143,7 +143,7 @@ extern u8 __dtb_dt_spl_begin[];	/* embedded device tree blob for SPL/TPL */
 static inline u8 *dtb_dt_embedded(void)
 {
 #ifdef CONFIG_OF_EMBED
-# ifdef CONFIG_SPL_BUILD
+# ifdef CONFIG_XPL_BUILD
 	return __dtb_dt_spl_begin;
 # else
 	return __dtb_dt_begin;
diff --git a/include/image-android-dt.h b/include/image-android-dt.h
index 9a3aa8fa30f..d255744e8cb 100644
--- a/include/image-android-dt.h
+++ b/include/image-android-dt.h
@@ -13,7 +13,7 @@ bool android_dt_check_header(ulong hdr_addr);
 bool android_dt_get_fdt_by_index(ulong hdr_addr, u32 index, ulong *addr,
 				 u32 *size);
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 void android_dt_print_contents(ulong hdr_addr);
 #endif
 
diff --git a/include/iotrace.h b/include/iotrace.h
index d5610426cc8..5527c984fd2 100644
--- a/include/iotrace.h
+++ b/include/iotrace.h
@@ -42,7 +42,7 @@ struct iotrace_record {
  */
 
 #if defined(CONFIG_IO_TRACE) && !defined(IOTRACE_IMPL) && \
-	!defined(CONFIG_SPL_BUILD)
+	!defined(CONFIG_XPL_BUILD)
 
 #undef readl
 #define readl(addr)	iotrace_readl((const void *)(addr))
diff --git a/include/linux/kconfig.h b/include/linux/kconfig.h
index 2bc704e1104..a59f2a61e6a 100644
--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -40,7 +40,7 @@
 #define _CONFIG_PREFIX TPL_
 #elif defined(CONFIG_VPL_BUILD)
 #define _CONFIG_PREFIX VPL_
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 #define _CONFIG_PREFIX SPL_
 #else
 #define _CONFIG_PREFIX
@@ -53,8 +53,8 @@
 /*
  * CONFIG_VAL(FOO) evaluates to the value of
  *  CONFIG_TOOLS_FOO if USE_HOSTCC is defined,
- *  CONFIG_FOO if CONFIG_SPL_BUILD is undefined,
- *  CONFIG_SPL_FOO if CONFIG_SPL_BUILD is defined.
+ *  CONFIG_FOO if CONFIG_XPL_BUILD is undefined,
+ *  CONFIG_SPL_FOO if CONFIG_XPL_BUILD is defined.
  *  CONFIG_TPL_FOO if CONFIG_TPL_BUILD is defined.
  *  CONFIG_VPL_FOO if CONFIG_VPL_BUILD is defined.
  */
@@ -106,22 +106,22 @@ long invalid_use_of_IF_ENABLED_INT(void);
 /*
  * CONFIG_IS_ENABLED(FOO) expands to
  *  1 if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
- *  1 if CONFIG_SPL_BUILD is undefined and CONFIG_FOO is set to 'y',
- *  1 if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
+ *  1 if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
+ *  1 if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
  *  1 if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
  *  0 otherwise.
  *
  * CONFIG_IS_ENABLED(FOO, (abc)) expands to
  *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
- *  abc if CONFIG_SPL_BUILD is undefined and CONFIG_FOO is set to 'y',
- *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
+ *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
+ *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
  *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
  *  nothing otherwise.
  *
  * CONFIG_IS_ENABLED(FOO, (abc), (def)) expands to
  *  abc if USE_HOSTCC is defined and CONFIG_TOOLS_FOO is set to 'y',
- *  abc if CONFIG_SPL_BUILD is undefined and CONFIG_FOO is set to 'y',
- *  abc if CONFIG_SPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
+ *  abc if CONFIG_XPL_BUILD is undefined and CONFIG_FOO is set to 'y',
+ *  abc if CONFIG_XPL_BUILD is defined and CONFIG_SPL_FOO is set to 'y',
  *  abc if CONFIG_TPL_BUILD is defined and CONFIG_TPL_FOO is set to 'y',
  *  def otherwise.
  *
diff --git a/include/mmc.h b/include/mmc.h
index 0044ff8bef7..e4b960b7294 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -726,7 +726,7 @@ struct mmc {
 	u64 capacity_boot;
 	u64 capacity_rpmb;
 	u64 capacity_gp[4];
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	u64 enh_user_start;
 	u64 enh_user_size;
 #endif
diff --git a/include/mtd/cfi_flash.h b/include/mtd/cfi_flash.h
index f4aecaac75f..be292e3ceb2 100644
--- a/include/mtd/cfi_flash.h
+++ b/include/mtd/cfi_flash.h
@@ -163,7 +163,7 @@ struct cfi_pri_hdr {
 #if defined(CONFIG_SYS_MAX_FLASH_BANKS_DETECT)
 /* map to cfi_flash_num_flash_banks only when supported */
 #if IS_ENABLED(CONFIG_FLASH_CFI_DRIVER) && \
-    (!IS_ENABLED(CONFIG_SPL_BUILD) || IS_ENABLED(CONFIG_SPL_MTD))
+    (!IS_ENABLED(CONFIG_XPL_BUILD) || IS_ENABLED(CONFIG_SPL_MTD))
 #define CFI_FLASH_BANKS		(cfi_flash_num_flash_banks)
 /* board code can update this variable before CFI detection */
 extern int cfi_flash_num_flash_banks;
diff --git a/include/net.h b/include/net.h
index bb2ae20f52a..dc8b5e9cc34 100644
--- a/include/net.h
+++ b/include/net.h
@@ -683,7 +683,7 @@ int net_send_udp_packet(uchar *ether, struct in_addr dest, int dport,
 /* Processes a received packet */
 void net_process_received_packet(uchar *in_packet, int len);
 
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 void nc_start(void);
 int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 	unsigned src_port, unsigned len);
@@ -691,7 +691,7 @@ int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 
 static __always_inline int eth_is_on_demand_init(void)
 {
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 	extern enum proto_t net_loop_last_protocol;
 
 	return net_loop_last_protocol != NETCONS;
@@ -702,7 +702,7 @@ static __always_inline int eth_is_on_demand_init(void)
 
 static inline void eth_set_last_protocol(int protocol)
 {
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 	extern enum proto_t net_loop_last_protocol;
 
 	net_loop_last_protocol = protocol;
diff --git a/include/part.h b/include/part.h
index 797b542ef1f..92662677551 100644
--- a/include/part.h
+++ b/include/part.h
@@ -439,7 +439,7 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
  * We don't support printing partition information in SPL and only support
  * getting partition information in a few cases.
  */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 # define part_print_ptr(x)	NULL
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
 	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION)
diff --git a/include/sdp.h b/include/sdp.h
index 5492f9c47d2..0a97f28073a 100644
--- a/include/sdp.h
+++ b/include/sdp.h
@@ -11,7 +11,7 @@
 
 int sdp_init(struct udevice *udc);
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 
 int spl_sdp_handle(struct udevice *udc, struct spl_image_info *spl_image,
diff --git a/include/search.h b/include/search.h
index 7faf23f4aca..3952198a0df 100644
--- a/include/search.h
+++ b/include/search.h
@@ -29,7 +29,7 @@ enum env_action {
 struct env_entry {
 	const char *key;
 	char *data;
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	int (*callback)(const char *name, const char *value, enum env_op op,
 		int flags);
 #endif
diff --git a/include/spl.h b/include/spl.h
index b2978d8bbaf..3fc50cd9195 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -53,7 +53,7 @@ static inline bool xpl_is_first_phase(void)
 		if (IS_ENABLED(CONFIG_TPL_BUILD))
 			return true;
 	} else if (IS_ENABLED(CONFIG_SPL)) {
-		if (IS_ENABLED(CONFIG_SPL_BUILD))
+		if (IS_ENABLED(CONFIG_XPL_BUILD))
 			return true;
 	} else {
 		return true;
@@ -92,7 +92,7 @@ enum xpl_phase_t {
  *
  * To include code only in SPL, you might do:
  *
- *    #if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+ *    #if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
  *    ...
  *    #endif
  *
@@ -104,7 +104,7 @@ enum xpl_phase_t {
  *
  * To include code only in U-Boot proper, you might do:
  *
- *    #ifndef CONFIG_SPL_BUILD
+ *    #ifndef CONFIG_XPL_BUILD
  *    ...
  *    #endif
  *
@@ -122,7 +122,7 @@ static inline enum xpl_phase_t xpl_phase(void)
 	return PHASE_TPL;
 #elif defined(CONFIG_VPL_BUILD)
 	return PHASE_VPL;
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 	return PHASE_SPL;
 #else
 	DECLARE_GLOBAL_DATA_PTR;
@@ -137,7 +137,7 @@ static inline enum xpl_phase_t xpl_phase(void)
 /* returns true if in U-Boot proper, false if in xPL */
 static inline bool not_xpl(void)
 {
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	return false;
 #endif
 
@@ -166,7 +166,7 @@ static inline enum xpl_phase_t xpl_prev_phase(void)
 	return PHASE_NONE;
 #elif defined(CONFIG_VPL_BUILD)
 	return PHASE_TPL;	/* VPL requires TPL */
-#elif defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_XPL_BUILD)
 	return IS_ENABLED(CONFIG_VPL) ? PHASE_VPL :
 		IS_ENABLED(CONFIG_TPL) ? PHASE_TPL :
 		PHASE_NONE;
@@ -239,7 +239,7 @@ static inline const char *xpl_prefix(enum xpl_phase_t phase)
 }
 
 /* A string name for SPL or TPL */
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 # ifdef CONFIG_TPL_BUILD
 #  define SPL_TPL_NAME	"TPL"
 # elif defined(CONFIG_VPL_BUILD)
diff --git a/include/stdio.h b/include/stdio.h
index e7325795533..d42fdd2728c 100644
--- a/include/stdio.h
+++ b/include/stdio.h
@@ -9,7 +9,7 @@ int getchar(void);
 int tstc(void);
 
 /* stdout */
-#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(SERIAL)
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(SERIAL)
 void putc(const char c);
 void puts(const char *s);
 #ifdef CONFIG_CONSOLE_FLUSH_SUPPORT
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index db3742c0397..122987c395e 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -206,7 +206,7 @@ void sunxi_gpio_set_pull(u32 pin, u32 val);
 void sunxi_gpio_set_pull_bank(void *bank_base, int pin_offset, u32 val);
 int sunxi_name_to_gpio(const char *name);
 
-#if !defined CONFIG_SPL_BUILD && defined CONFIG_AXP_GPIO
+#if !defined CONFIG_XPL_BUILD && defined CONFIG_AXP_GPIO
 int axp_gpio_init(void);
 #else
 static inline int axp_gpio_init(void) { return 0; }
diff --git a/include/upl.h b/include/upl.h
index 2ec5ef1b5cf..4d0eca88047 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -320,7 +320,7 @@ int upl_read_handoff(struct upl *upl, oftree tree);
 int upl_get_test_data(struct unit_test_state *uts, struct upl *upl);
 #endif /* USE_HOSTCC */
 
-#if CONFIG_IS_ENABLED(UPL) && defined(CONFIG_SPL_BUILD)
+#if CONFIG_IS_ENABLED(UPL) && defined(CONFIG_XPL_BUILD)
 
 /**
  * upl_set_fit_info() - Set up basic info about the FIT
@@ -367,7 +367,7 @@ int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc);
 static inline int upl_add_image(const void *fit, int node, ulong load_addr,
 				ulong size)
 {
-	if (CONFIG_IS_ENABLED(UPL) && IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (CONFIG_IS_ENABLED(UPL) && IS_ENABLED(CONFIG_XPL_BUILD)) {
 		const char *desc = fdt_getprop(fit, node, FIT_DESC_PROP, NULL);
 
 		return _upl_add_image(node, load_addr, size, desc);
diff --git a/include/vbe.h b/include/vbe.h
index 5ede8181b98..56bff63362f 100644
--- a/include/vbe.h
+++ b/include/vbe.h
@@ -41,7 +41,7 @@ struct vbe_handoff {
  */
 static inline enum vbe_phase_t vbe_phase(void)
 {
-	if (IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_XPL_BUILD))
 		return VBE_PHASE_FIRMWARE;
 
 	return VBE_PHASE_OS;
-- 
2.34.1

