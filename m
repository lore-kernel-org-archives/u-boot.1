Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EEACD98C5
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD798499A;
	Thu, 11 Jun 2026 04:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nfGJr03p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D0584908; Wed, 10 Jun 2026 15:36:58 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B10848D1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C53153F640
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781098615;
 bh=Kxoy0t1TK1x7S+gGrmMw3O/rOPeeIeMtPUi8ruOAd5E=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nfGJr03pyexje9+SU0+Y7efOD3cRGzeV4zSElYcXTsommkVfiaHAzx2TVx4Klv8a4
 lzLTdJ31PlL2R9oC4DNeVT5tYcRrM25UZQV81GmXh7Wn3Dehkhs2byihc7cyw5jL0K
 vA2nIXUnVDV8+1+0elqYf1ttzO65OVyEWPQMJjoOOEnauZJygl6oPIJ9b/TFOSXMQ8
 wFSNuK42u9+zAPAvwz4LpoU6DdrMqYqgKA6hS3IP/D2KHvdrF1pn285rXSHDUoq4Ga
 TDh/1AII88NlveYRHZvPLl7W2GRl+/Zbf/8wW9W012FY6RQ4X/eabD1DaC8pn5UNea
 IAgU6L9Q7eVKgHzMgjp43sapl7P/7nvMpGy1y/yGKdgNHNU2HAQ650uvqH9pM59ln4
 F4QxAAkfDy9+nyAOwVq+cEtFiLYwlpkLW09kzVqy9PZ+x4ETNtgmNI9jnsJlvARCp9
 DMrivJ9rlzTUHJEH7KIkDepNzkV2H0KRN7sjVowlypZ0Kd84DbykSrUFDhB1/jZgfn
 rU+ewemjdvWB5RR610uxcreAZZZ1mIO9JC7wSXjMidaGWRcUEgo5WtcXIPYMVyOeyr
 DEvJu++nE8VdBHlW9Xzsom4T9xAOnBSY1zCeEP8fnpIa9xvWxIMy+Nohmy0d4OASiN
 E4dAcY4Ju7jBJAW/o6TGXbic=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bf1dece2ecso69500185ad.1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098614; x=1781703414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kxoy0t1TK1x7S+gGrmMw3O/rOPeeIeMtPUi8ruOAd5E=;
 b=epRfbT8+H0yBM2mjG4IoZgsH3D6WPVWerlgnRtPPkYjILwD1hR4yZ7am2+Uumfj0G+
 JaWs0+Zde3/SXGenVaicENjZjyrc0Jkq+WDKU0UtY1+d+z72Y5K8zVGhHuQ273lqYkea
 fDzy7F9ereEnV8tTtjl2oRDwVZPSYCsU5+sbh02lUJOJRPqynTKGT17wIf/DS7cbWLNr
 8wjCn3V9RG74UuXCmO66Ykv9ybEtOotwVpEAMNSWAoQtAssMRWm5XajhtUJKHBQcDuAO
 EUmCPFpz/h1LuqUEsbsdap6WRQCVdAm7rEXIm3Hi2+YHlyLctt6n50BqdGJp9eKEi2/P
 hcgA==
X-Gm-Message-State: AOJu0Yy+kC28j4VvQB6k5bE5EN5801yASIDT4dkxMPmwiwLjduBAU8yI
 Ta3lWtQxPwCiYdaG0MLxe54sPMpkNC4u1qq5tabOz38mwA/HjLRnhjolMoE4RwidJmNGqDjOScD
 RJhpfSRV4RQYnMyaBshJPlqZLwlcgk7BNI871XUkK9/RinHvX9OFzxioX6ngYeo1IyeT3tlZe2S
 yrafs=
X-Gm-Gg: Acq92OEa4J8em5mg5Ue4BaHk2mlIACmG4QDZAf9l2s7e1A2lTdIShMTgdkXDZXM1X10
 6Dwn2UXVzx+YnrS+2u/3eGYDSR9NQIsKxoBgTijjK90rMktlxFBxhEfmJCsEyrpv1G8oJxdGSRX
 tMpfHp7y8GDx2hr4TDQ5xOnbnLHC6lNfpzpHNT7wPFofQpbbQ9fqEON0xJ6atBH/jZTjcuRZO2L
 NxWc1ca1Cu8ZUYQx1rchrDKgl/VW6q5T3f7HjBOrIW2APQAe3SQ25yMVMR55rpCsvqQLObTqXKV
 1zXvkcIeIuOcrbP8E28s1Yg3QNVxmMPH2NDWB3pDjOyFl+YhA8i+RWTtRWHnkmwvjweyENSqZf2
 jBAmtD+vGT3HAGwcMa1YW+nzv64KZrbN1lO8UfxSJ8b2VG4F6OARz7+h8ncfz8cHwRDwwSiVlcw
 y7nl3djvZhhfT+xuvxNC/cX6Du0w==
X-Received: by 2002:a17:902:d48e:b0:2c2:50c7:58a0 with SMTP id
 d9443c01a7336-2c250c75ab0mr178510855ad.23.1781098614243; 
 Wed, 10 Jun 2026 06:36:54 -0700 (PDT)
X-Received: by 2002:a17:902:d48e:b0:2c2:50c7:58a0 with SMTP id
 d9443c01a7336-2c250c75ab0mr178510605ad.23.1781098613835; 
 Wed, 10 Jun 2026 06:36:53 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16629d042sm257367375ad.60.2026.06.10.06.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:36:53 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v1 3/3] mx6sabre: Move environment variables to .env files
Date: Wed, 10 Jun 2026 13:24:24 +0000
Message-ID: <20260610133336.15999-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610133336.15999-1-aristo.chen@canonical.com>
References: <20260610133336.15999-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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

Move the shared environment from CFG_EXTRA_ENV_SETTINGS in
mx6sabre_common.h to a common text environment fragment in
include/env/nxp/mx6sabre_common.env. The mx6sabresd and mx6sabreauto
board environments include this fragment and add their own console
setting, which is the only board specific difference between them. The
eMMC firmware update variables remain guarded by CONFIG_SUPPORT_EMMC_BOOT
inside the fragment. The now unused CONSOLE_DEV defines and the
linux/stringify.h include are dropped.

The generated default environment is unchanged for both boards. This was
verified by comparing the output of scripts/get_default_envs.sh before
and after the change, which produced identical results.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 board/nxp/mx6sabreauto/mx6sabreauto.env |   5 +
 board/nxp/mx6sabresd/mx6sabresd.env     |   5 +
 include/configs/mx6sabre_common.h       | 122 ------------------------
 include/configs/mx6sabreauto.h          |   1 -
 include/configs/mx6sabresd.h            |   1 -
 include/env/nxp/mx6sabre_common.env     | 114 ++++++++++++++++++++++
 6 files changed, 124 insertions(+), 124 deletions(-)
 create mode 100644 board/nxp/mx6sabreauto/mx6sabreauto.env
 create mode 100644 board/nxp/mx6sabresd/mx6sabresd.env
 create mode 100644 include/env/nxp/mx6sabre_common.env

diff --git a/board/nxp/mx6sabreauto/mx6sabreauto.env b/board/nxp/mx6sabreauto/mx6sabreauto.env
new file mode 100644
index 00000000000..31a16905ef5
--- /dev/null
+++ b/board/nxp/mx6sabreauto/mx6sabreauto.env
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+console=ttymxc3
+
+#include <env/nxp/mx6sabre_common.env>
diff --git a/board/nxp/mx6sabresd/mx6sabresd.env b/board/nxp/mx6sabresd/mx6sabresd.env
new file mode 100644
index 00000000000..3608e931665
--- /dev/null
+++ b/board/nxp/mx6sabresd/mx6sabresd.env
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+console=ttymxc0
+
+#include <env/nxp/mx6sabre_common.env>
diff --git a/include/configs/mx6sabre_common.h b/include/configs/mx6sabre_common.h
index ef2848b71f3..d3a57a10a16 100644
--- a/include/configs/mx6sabre_common.h
+++ b/include/configs/mx6sabre_common.h
@@ -8,133 +8,11 @@
 #ifndef __MX6QSABRE_COMMON_CONFIG_H
 #define __MX6QSABRE_COMMON_CONFIG_H
 
-#include <linux/stringify.h>
-
 #include "mx6_common.h"
 
 /* MMC Configs */
 #define CFG_SYS_FSL_ESDHC_ADDR      0
 
-#ifdef CONFIG_SUPPORT_EMMC_BOOT
-#define EMMC_ENV \
-	"emmcdev=2\0" \
-	"update_emmc_firmware=" \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"if ${get_cmd} ${update_sd_firmware_filename}; then " \
-			"if mmc dev ${emmcdev} 1; then "	\
-				"setexpr fw_sz ${filesize} / 0x200; " \
-				"setexpr fw_sz ${fw_sz} + 1; "	\
-				"mmc write ${loadaddr} 0x2 ${fw_sz}; " \
-			"fi; "	\
-		"fi\0"
-#else
-#define EMMC_ENV ""
-#endif
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	"script=boot.scr\0" \
-	"image=zImage\0" \
-	"fdtfile=undefined\0" \
-	"fdt_addr=0x18000000\0" \
-	"boot_fdt=try\0" \
-	"ip_dyn=yes\0" \
-	"console=" CONSOLE_DEV "\0" \
-	"dfuspi=dfu 0 sf 0:0:10000000:0\0" \
-	"dfu_alt_info_spl=spl raw 0x400\0" \
-	"dfu_alt_info_img=u-boot raw 0x10000\0" \
-	"dfu_alt_info=spl raw 0x400\0" \
-	"initrd_high=0xffffffff\0" \
-	"splashimage=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"mmcdev=" __stringify(CONFIG_ENV_MMC_DEVICE_INDEX) "\0" \
-	"mmcpart=1\0" \
-	"finduuid=part uuid mmc ${mmcdev}:2 uuid\0" \
-	"update_sd_firmware=" \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"if mmc dev ${mmcdev}; then "	\
-			"if ${get_cmd} ${update_sd_firmware_filename}; then " \
-				"setexpr fw_sz ${filesize} / 0x200; " \
-				"setexpr fw_sz ${fw_sz} + 1; "	\
-				"mmc write ${loadaddr} 0x2 ${fw_sz}; " \
-			"fi; "	\
-		"fi\0" \
-	EMMC_ENV	  \
-	"mmcargs=setenv bootargs console=${console},${baudrate} " \
-		"root=PARTUUID=${uuid} rootwait rw\0" \
-	"loadbootscript=" \
-		"load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script} || " \
-		"load mmc ${mmcdev}:${mmcpart} ${loadaddr} boot/${script};\0" \
-	"bootscript=echo Running bootscript from mmc ...; " \
-		"source\0" \
-	"loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image} || " \
-		"load mmc ${mmcdev}:${mmcpart} ${loadaddr} boot/${image}\0" \
-	"loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdtfile} || " \
-		"load mmc ${mmcdev}:${mmcpart} ${fdt_addr} boot/${fdtfile}\0" \
-	"mmcboot=echo Booting from mmc ...; " \
-		"run finduuid; " \
-		"run mmcargs; " \
-		"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
-			"if run loadfdt; then " \
-				"bootz ${loadaddr} - ${fdt_addr}; " \
-			"else " \
-				"if test ${boot_fdt} = try; then " \
-					"bootz; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi; " \
-		"else " \
-			"bootz; " \
-		"fi;\0" \
-	"netargs=setenv bootargs console=${console},${baudrate} " \
-		"root=/dev/nfs " \
-		"ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
-	"netboot=echo Booting from net ...; " \
-		"run netargs; " \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"${get_cmd} ${image}; " \
-		"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
-			"if ${get_cmd} ${fdt_addr} ${fdtfile}; then " \
-				"bootz ${loadaddr} - ${fdt_addr}; " \
-			"else " \
-				"if test ${boot_fdt} = try; then " \
-					"bootz; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi; " \
-		"else " \
-			"bootz; " \
-		"fi;\0" \
-		"findfdt="\
-			"if test $fdtfile = undefined; then " \
-				"if test $board_name = SABREAUTO && test $board_rev = MX6QP; then " \
-					"setenv fdtfile imx6qp-sabreauto.dtb; fi; " \
-				"if test $board_name = SABREAUTO && test $board_rev = MX6Q; then " \
-					"setenv fdtfile imx6q-sabreauto.dtb; fi; " \
-				"if test $board_name = SABREAUTO && test $board_rev = MX6DL; then " \
-					"setenv fdtfile imx6dl-sabreauto.dtb; fi; " \
-				"if test $board_name = SABRESD && test $board_rev = MX6QP; then " \
-					"setenv fdtfile imx6qp-sabresd.dtb; fi; " \
-				"if test $board_name = SABRESD && test $board_rev = MX6Q; then " \
-					"setenv fdtfile imx6q-sabresd.dtb; fi; " \
-				"if test $board_name = SABRESD && test $board_rev = MX6DL; then " \
-					"setenv fdtfile imx6dl-sabresd.dtb; fi; " \
-				"if test $fdtfile = undefined; then " \
-					"echo WARNING: Could not determine dtb to use; fi; " \
-			"fi;\0" \
-
 /* Physical Memory Map */
 #define PHYS_SDRAM                     MMDC0_ARB_BASE_ADDR
 
diff --git a/include/configs/mx6sabreauto.h b/include/configs/mx6sabreauto.h
index e491af3e927..b5602def87d 100644
--- a/include/configs/mx6sabreauto.h
+++ b/include/configs/mx6sabreauto.h
@@ -9,7 +9,6 @@
 #define __MX6SABREAUTO_CONFIG_H
 
 #define CFG_MXC_UART_BASE	UART4_BASE
-#define CONSOLE_DEV		"ttymxc3"
 
 #define CFG_SYS_I2C_PCA953X_WIDTH	{ {0x30, 8}, {0x32, 8}, {0x34, 8} }
 
diff --git a/include/configs/mx6sabresd.h b/include/configs/mx6sabresd.h
index e34947c94d0..1ea08f835dd 100644
--- a/include/configs/mx6sabresd.h
+++ b/include/configs/mx6sabresd.h
@@ -9,7 +9,6 @@
 #define __MX6SABRESD_CONFIG_H
 
 #define CFG_MXC_UART_BASE	UART1_BASE
-#define CONSOLE_DEV		"ttymxc0"
 
 #include "mx6sabre_common.h"
 
diff --git a/include/env/nxp/mx6sabre_common.env b/include/env/nxp/mx6sabre_common.env
new file mode 100644
index 00000000000..5346cd4e953
--- /dev/null
+++ b/include/env/nxp/mx6sabre_common.env
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+script=boot.scr
+image=zImage
+fdtfile=undefined
+fdt_addr=0x18000000
+boot_fdt=try
+ip_dyn=yes
+dfuspi=dfu 0 sf 0:0:10000000:0
+dfu_alt_info_spl=spl raw 0x400
+dfu_alt_info_img=u-boot raw 0x10000
+dfu_alt_info=spl raw 0x400
+initrd_high=0xffffffff
+splashimage=CONFIG_SYS_LOAD_ADDR
+mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
+mmcpart=1
+finduuid=part uuid mmc ${mmcdev}:2 uuid
+update_sd_firmware=if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	if mmc dev ${mmcdev}; then
+		if ${get_cmd} ${update_sd_firmware_filename}; then
+			setexpr fw_sz ${filesize} / 0x200;
+			setexpr fw_sz ${fw_sz} + 1;
+			mmc write ${loadaddr} 0x2 ${fw_sz};
+		fi;
+	fi
+#ifdef CONFIG_SUPPORT_EMMC_BOOT
+emmcdev=2
+update_emmc_firmware=if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	if ${get_cmd} ${update_sd_firmware_filename}; then
+		if mmc dev ${emmcdev} 1; then
+			setexpr fw_sz ${filesize} / 0x200;
+			setexpr fw_sz ${fw_sz} + 1;
+			mmc write ${loadaddr} 0x2 ${fw_sz};
+		fi;
+	fi
+#endif
+mmcargs=setenv bootargs console=${console},${baudrate} root=PARTUUID=${uuid} rootwait rw
+loadbootscript=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script} ||
+	load mmc ${mmcdev}:${mmcpart} ${loadaddr} boot/${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image} ||
+	load mmc ${mmcdev}:${mmcpart} ${loadaddr} boot/${image}
+loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdtfile} ||
+	load mmc ${mmcdev}:${mmcpart} ${fdt_addr} boot/${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run finduuid;
+	run mmcargs;
+	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
+		if run loadfdt; then
+			bootz ${loadaddr} - ${fdt_addr};
+		else
+			if test ${boot_fdt} = try; then
+				bootz;
+			else
+				echo WARN: Cannot load the DT;
+			fi;
+		fi;
+	else
+		bootz;
+	fi;
+netargs=setenv bootargs console=${console},${baudrate} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${image};
+	if test ${boot_fdt} = yes || test ${boot_fdt} = try; then
+		if ${get_cmd} ${fdt_addr} ${fdtfile}; then
+			bootz ${loadaddr} - ${fdt_addr};
+		else
+			if test ${boot_fdt} = try; then
+				bootz;
+			else
+				echo WARN: Cannot load the DT;
+			fi;
+		fi;
+	else
+		bootz;
+	fi;
+findfdt=if test $fdtfile = undefined; then
+		if test $board_name = SABREAUTO && test $board_rev = MX6QP; then
+			setenv fdtfile imx6qp-sabreauto.dtb;
+		fi;
+		if test $board_name = SABREAUTO && test $board_rev = MX6Q; then
+			setenv fdtfile imx6q-sabreauto.dtb;
+		fi;
+		if test $board_name = SABREAUTO && test $board_rev = MX6DL; then
+			setenv fdtfile imx6dl-sabreauto.dtb;
+		fi;
+		if test $board_name = SABRESD && test $board_rev = MX6QP; then
+			setenv fdtfile imx6qp-sabresd.dtb;
+		fi;
+		if test $board_name = SABRESD && test $board_rev = MX6Q; then
+			setenv fdtfile imx6q-sabresd.dtb;
+		fi;
+		if test $board_name = SABRESD && test $board_rev = MX6DL; then
+			setenv fdtfile imx6dl-sabresd.dtb;
+		fi;
+		if test $fdtfile = undefined; then
+			echo WARNING: Could not determine dtb to use;
+		fi;
+	fi;
-- 
2.43.0

