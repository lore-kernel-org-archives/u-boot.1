Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA6FCD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:54:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77D4984974;
	Thu, 11 Jun 2026 04:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FpBf8pdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1C8B8490B; Wed, 10 Jun 2026 15:36:54 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BAB848D1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4EA9A3F5D9
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 13:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1781098612;
 bh=1C23A5axFlpmjHp0rlZZHEeStdXFiPzC4qnRf5reXDY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=FpBf8pdY4AuW2IdAurdIvMDaI/WwKPSBXB+z8Z0CjRsyefX1sr+EiuZpMPZ/UqAZu
 zQa1HFKkqyFlf2991UBXF77B04QSCYclVm++s5abtVwmm1LZP9FG47vUBrgvqrxbTc
 +XeMSsPaOnaTDi/rzC/83w1FdfNFOKDRpUsksnwi7Qlu9ek9gWSjgMYX/lZiWsOact
 aWgDijcV9I/LurImGnSnJ912Q7aOU5ZsSLxXgakHKnkISe9gCsabVfb9YzWyMfkInV
 fcfWQe2V4rkIQJKnEayzGnsU4s3gTvpBT4Bke1jf1zMaN0s7w0iI6/4zv8J8SfABYL
 pvzXu5S+7XzkVucvpSXUOfki22NR4bHaBxb9nKMyiYyQZb4ECYquNlhi4KnsccZP0g
 vSIZnDJDpbp4UpSZ8Mt+/1eDubdoGh8fqYGiU8ftPMVbxIKhdLKFLLghHPtktl2zH4
 NS6e0PCSzc0b/APL1MVyHdf4ayHOpLSmNJr6fZIdgWLg/ikcYA6Dn9Ao7ZudgISITw
 o6of8rqBdUpoYaR4XiYoblPekQ/BEA3kgHXgFcc8WeENI+ovCXF5N3ML9d9vvcmoav
 nd6fSuHLRd4OnaCh0VaiXuCfZza/BN848tq1QReJ6Cr67Wgv45syt+iGD6pGIPeyP+
 riG9fZ8GJ3UnkVfRhfmeygO0=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c2d65d9792so880725ad.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 06:36:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781098611; x=1781703411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1C23A5axFlpmjHp0rlZZHEeStdXFiPzC4qnRf5reXDY=;
 b=obKkKfkIopv5aF9GJWl9vzrZaBAWlGI/4AVxtwmAhPmdUKxwS6FhdO7mec1JvdEaaK
 hOqkzIVdWinNFDm21j5ULGZ9y+C0KQlj/Ccrp+cUH+pWZ5XlaJ3JWpnT7pmXLm+YPIIV
 uLmSqPkNDCcGGmyCaQbwIR3U4di10YJGcpQX0X4eCHPOxGFQGFbb9JC76FTTivRDI+HA
 axGVaR/xCfOFksyw1/sPp1/b6gHL5gAVp/7gp9ROYp0//ZD9H69lTf7i/UGgryDPjIbN
 wSWPH58cBCXfgDDaR+Zm+jIBAqLXZ/ipgjElVRb7mvHDA+k5ejdriQNLn7K0ov3GVlg/
 1mZA==
X-Gm-Message-State: AOJu0YwXDYO/wUkhG8MMLFh7cXLLCi9XW3m7Py03JVTT4rZ3CFzqJoUK
 ZfP+2XResXYp1yzNM19+xjX9DvynxM63TLwgAlFNxJ61NGOjONpzBcwQBN5nupROIaqoayfropU
 nDjhtv8vcMPNmnbT6YmxBOZ1HfomWkdRdjNyLwa+/Pfe+9nuRIGDh3LG0itoL1BNjT8jZwNVeGH
 6nHHc=
X-Gm-Gg: Acq92OGD0qbxW26RVTK1dPzXTGifAzNlcTxpEuEK586WEzIvZbeL39NHpdgB+1kK6Vb
 fYbyaeY+vrcLs2V9c3Bw4+vCeUbKHVT0bdun0HwosdjrN6O5kZIwB3jWhMFezefQXfhWcRYXI2f
 wlbNitORlGeq/mK2makAABxY74JCDvBDg6N3aaV02mC0q+Qb5GARgPOpRlZcNA9UIsFROhuMxeh
 pT817T9+/GYOtiJo+gvy/mUcP5YYMJqr0s6gNCqnvddWEga4kXAIDSXgg+FHvhTtbUbek0+wGgc
 W29fxtCwyXmAR+DkS1Yir77pfOIRtr3SdxVJFvySA6BWwz2L6+I/84k6eZSNyzbdKxXOwoveAub
 0YLRU644RVvp+YNBzzsSGXh7JkfJTxywxmJLbU8sRQSskC4FxC/SOZLdcsl3BQsXg563dewhGus
 yt3btDvN/HBr7uKxV10eFSooCm/A==
X-Received: by 2002:a17:902:fc47:b0:2c0:eee2:fc45 with SMTP id
 d9443c01a7336-2c1e7b2f6c7mr310268545ad.4.1781098610830; 
 Wed, 10 Jun 2026 06:36:50 -0700 (PDT)
X-Received: by 2002:a17:902:fc47:b0:2c0:eee2:fc45 with SMTP id
 d9443c01a7336-2c1e7b2f6c7mr310268115ad.4.1781098610328; 
 Wed, 10 Jun 2026 06:36:50 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16629d042sm257367375ad.60.2026.06.10.06.36.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 06:36:49 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v1 2/3] mx6ullevk: Move environment variables to .env file
Date: Wed, 10 Jun 2026 13:24:23 +0000
Message-ID: <20260610133336.15999-3-aristo.chen@canonical.com>
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

Move the board environment from CFG_EXTRA_ENV_SETTINGS in the config
header to board/nxp/mx6ullevk/mx6ullevk.env for better maintainability.
The file is named after CONFIG_SYS_BOARD so it is selected automatically
without setting CONFIG_ENV_SOURCE_FILE. Drop the now unused
linux/stringify.h include.

The generated default environment is unchanged. This was verified by
comparing the output of scripts/get_default_envs.sh before and after the
change, which produced identical results.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 board/nxp/mx6ullevk/mx6ullevk.env | 69 +++++++++++++++++++++++++++++
 include/configs/mx6ullevk.h       | 73 -------------------------------
 2 files changed, 69 insertions(+), 73 deletions(-)
 create mode 100644 board/nxp/mx6ullevk/mx6ullevk.env

diff --git a/board/nxp/mx6ullevk/mx6ullevk.env b/board/nxp/mx6ullevk/mx6ullevk.env
new file mode 100644
index 00000000000..0fce3aaaa4e
--- /dev/null
+++ b/board/nxp/mx6ullevk/mx6ullevk.env
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+script=boot.scr
+image=zImage
+console=ttymxc0
+initrd_high=0xffffffff
+fdt_file=undefined
+fdt_addr=0x83000000
+boot_fdt=try
+ip_dyn=yes
+videomode=video=ctfb:x:480,y:272,depth:24,pclk:108695,le:8,ri:4,up:2,lo:4,hs:41,vs:10,sync:0,vmode:0
+mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs console=${console},${baudrate} root=${mmcroot}
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
+mmcboot=echo Booting from mmc ...;
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
+findfdt=if test $fdt_file = undefined; then
+		if test $board_name = ULZ-EVK && test $board_rev = 14X14; then
+			setenv fdt_file imx6ulz-14x14-evk.dtb;
+		fi;
+		if test $board_name = EVK && test $board_rev = 14X14; then
+			setenv fdt_file imx6ull-14x14-evk.dtb;
+		fi;
+		if test $fdt_file = undefined; then
+			echo WARNING: Could not determine dtb to use;
+		fi;
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
+		if ${get_cmd} ${fdt_addr} ${fdt_file}; then
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
diff --git a/include/configs/mx6ullevk.h b/include/configs/mx6ullevk.h
index 88b535e1bd0..a535163fd19 100644
--- a/include/configs/mx6ullevk.h
+++ b/include/configs/mx6ullevk.h
@@ -9,7 +9,6 @@
 
 #include <asm/arch/imx-regs.h>
 #include <linux/sizes.h>
-#include <linux/stringify.h>
 #include "mx6_common.h"
 #include <asm/mach-imx/gpio.h>
 
@@ -23,78 +22,6 @@
 #define CFG_SYS_FSL_USDHC_NUM	2
 #endif
 
-#define CFG_EXTRA_ENV_SETTINGS \
-	"script=boot.scr\0" \
-	"image=zImage\0" \
-	"console=ttymxc0\0" \
-	"initrd_high=0xffffffff\0" \
-	"fdt_file=undefined\0" \
-	"fdt_addr=0x83000000\0" \
-	"boot_fdt=try\0" \
-	"ip_dyn=yes\0" \
-	"videomode=video=ctfb:x:480,y:272,depth:24,pclk:108695,le:8,ri:4,up:2,lo:4,hs:41,vs:10,sync:0,vmode:0\0" \
-	"mmcdev="__stringify(CONFIG_ENV_MMC_DEVICE_INDEX)"\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-	"mmcautodetect=yes\0" \
-	"mmcargs=setenv bootargs console=${console},${baudrate} " \
-		"root=${mmcroot}\0" \
-	"loadbootscript=" \
-		"fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
-	"bootscript=echo Running bootscript from mmc ...; " \
-		"source\0" \
-	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
-	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}\0" \
-	"mmcboot=echo Booting from mmc ...; " \
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
-		"findfdt="\
-			"if test $fdt_file = undefined; then " \
-				"if test $board_name = ULZ-EVK && test $board_rev = 14X14; then " \
-					"setenv fdt_file imx6ulz-14x14-evk.dtb; fi; " \
-				"if test $board_name = EVK && test $board_rev = 14X14; then " \
-					"setenv fdt_file imx6ull-14x14-evk.dtb; fi; " \
-				"if test $fdt_file = undefined; then " \
-					"echo WARNING: Could not determine dtb to use; " \
-				"fi; " \
-			"fi;\0" \
-	"netargs=setenv bootargs console=${console},${baudrate} " \
-		"root=/dev/nfs " \
-	"ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
-		"netboot=echo Booting from net ...; " \
-		"run netargs; " \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"${get_cmd} ${image}; " \
-		"if test ${boot_fdt} = yes || test ${boot_fdt} = try; then " \
-			"if ${get_cmd} ${fdt_addr} ${fdt_file}; then " \
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
-
 /* Miscellaneous configurable options */
 
 /* Physical Memory Map */
-- 
2.43.0

