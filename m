Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E790C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 05:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DFF082132;
	Mon, 28 Apr 2025 07:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745818154;
	bh=C7clxjjB6K05pmhI1qGdW5/t90Mhh5QyzvvYUfGcJlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bKsjP/t0zxmy1Jh0mvlb2EdSV8v1ceB/F9bToykLrIznCvj1/RQJQLHImLGeX1bpz
	 Ayw8ocn59xZddN3IOPOOgrRGyRcf7zNPZq3GcFWAd2mIpswlyzXrS7HhtOU/ptI2sK
	 c/TKT+bsssiE23Qqb8XuaiJnUIhbQZiFSeY8YHo9HWCbeGq/vaGMhDW9qDRyNVFNzB
	 ffQJELA30zpSO6mtKt9XeiBr2o9DWNsfofxGLW8QeVCxSw1Op68f8OuVw1Y8k0xqrx
	 40o80Ehmu6jSY7HaDOZe0N1pQPUnJ7q/4qDHQH/M3l2eDD0iZLclclt2BoUHihBJaP
	 zJkB0a2id6whw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1DB82116; Mon, 28 Apr 2025 07:29:11 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6392E820F6
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 07:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="gDw4YleW"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 592BB10293381; 
 Mon, 28 Apr 2025 07:29:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745818147; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=C7clxjjB6K05pmhI1qGdW5/t90Mhh5QyzvvYUfGcJlc=;
 b=gDw4YleWR1e3ln36RILPbkjvx9zik1qnPE1OyYGNI9G5ueC8Sc3yMZ4R5XfDRCd1/TfTjC
 8FhW/cOnF7cJdJLtxHPE8jvUdWoYZcwjhkNX6sSKe2NTclLlT/XvL3uYi71QnGCo8wjPLv
 eo7oAFMEddDelWtnXNBC7tE0F66r9I3rIQB+fAh/DgcM9B6Vnwethgsq7Ag6m8Rdv2Pype
 IoaEivwEEC2gz0JsUyqBDxUzgLMTSyEWHeoTYfULQszcEq/zZxszlcoMKKb5hrKibCVwv0
 CctcbTqZH4dBOCtq26q28hsdGwRl7go9GSZCt17afZNOrgZVkkqTKtglL86Yjw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Heiko Schocher <hs@denx.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Tomas Peterka <atheiste@seznam.cz>
Subject: [PATCH v2 2/5] siemens: capricorn: enable text based default
 environment
Date: Mon, 28 Apr 2025 07:28:54 +0200
Message-Id: <20250428052858.100083-3-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250428052858.100083-1-hs@denx.de>
References: <20250428052858.100083-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Walter Schweizer <walter.schweizer@siemens.com>

enable text based default U-Boot Environment by enabling
CONFIG_ENV_SOURCE_FILE

and adding default environment file:

board/siemens/capricorn/capricorn_cxg3.env

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Walter Schweizer <walter.schweizer@siemens.com>

---

Changes in v2:
- removed ipaddr and serverip as suggested from Fabio

 board/siemens/capricorn/capricorn_default.env | 49 +++++++++++++++++
 configs/capricorn_cxg3_defconfig              |  1 +
 include/configs/capricorn-common.h            | 52 +------------------
 3 files changed, 51 insertions(+), 51 deletions(-)
 create mode 100644 board/siemens/capricorn/capricorn_default.env

diff --git a/board/siemens/capricorn/capricorn_default.env b/board/siemens/capricorn/capricorn_default.env
new file mode 100644
index 00000000000..4c26e9d43eb
--- /dev/null
+++ b/board/siemens/capricorn/capricorn_default.env
@@ -0,0 +1,49 @@
+altbootcmd=run bootcmd
+baudrate=115200
+bootcmd=run flash_self;reset;
+bootdelay=3
+bootdir=targetdir/rootfs/boot
+bootlimit=3
+check_upgrade=if test ${upgrade_available} -eq 1; then echo  upgrade_available is set; if test ${bootcount} -gt ${bootlimit}; then setenv upgrade_available 0;echo toggle partition;run toggle_partition;fi;fi;
+cntr_addr=0x88000000
+cntr_file=os_cntr_signed.bin
+console=ttyLP2
+dtb_name_default=default
+ethprime=eth1
+fdt_addr=0x83000000
+fdt_high=0xffffffffffffffff
+flash_self=run mmc_boot
+flash_self_test=setenv testargs test loglevel=3 systemd.unit=test.target; run mmc_boot
+hostname=capricorn
+initrd_addr=0x83100000
+initrd_high=0xffffffffffffffff
+ip_method=none
+kernel_name=Image
+loadaddr=0x80400000
+mmc_boot=run set_bootargs;run check_upgrade; run set_partition;run set_bootargs_mmc;run mmc_load_bootfiles
+mmc_boot_fit=ext4load mmc 0:${mmc_part_nr} 0x88000000 boot/fitImage;if test -n ${A};then setenv bootargs ${bootargs} rootfs_sig=${sig_a};fi;if test -n ${B};then setenv bootargs ${bootargs} rootfs_sig=${sig_b};fi;bootm 0x88000000#conf-${dtb_name}.dtb;bootm
+mmc_boot_image=ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name}.dtb;if test $? -eq 1;then ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name_default}.dtb;fi; ext4load mmc 0:${mmc_part_nr} ${loadaddr} boot/${kernel_name}; booti ${loadaddr} - ${fdt_addr}
+mmc_load_bootfiles=echo -n Loading from eMMC ...; if test -e mmc 0:${mmc_part_nr} boot/fitImage; then echo fit; setenv fdt_high; setenv initrd_high; run mmc_boot_fit; else echo image; run mmc_boot_image; fi
+net_nfs=wdt dev scu-wdt; wdt stop; echo Booting from network ...; run set_bootargs_net; tftpboot ${loadaddr} ${bootdir}/${kernel_name}; printenv bootargs; if test ${kernel_name} = fitImage; then setenv fdt_high; setenv initrd_high; bootm ${loadaddr}#conf-${dtb_name}.dtb; else tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name}.dtb; if test $? -eq 1; then echo Loading default.dtb!; tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name_default}.dtb; fi; booti ${loadaddr} - ${fdt_addr}; fi
+net_unfs=setenv nfsopts vers=3,udp,rsize=4096,wsize=4096,nolock,port=3049,mountport=3048 rw; run net_nfs
+netdev=lan0
+nfsopts=vers=3,udp,rsize=4096,wsize=4096,nolock rw
+partitionset_active=A
+rootfs_name=/dev/mmcblk0
+rootpath=/home/projects/targetdir/rootfs
+script_file=u-boot-commands.img
+set_bootargs_mmc=setenv bootargs ${bootargs} root=${mmc_active_vol} ro rootdelay=1 rootwait rootfstype=ext4 ip=${ip_method}
+set_bootargs_net=run set_bootargs; if test ${kernel_name} = fitImage; then setenv loadaddr 0x88000000; fi; setenv bootargs ${bootargs} root=/dev/nfs nfsroot=${serverip}:${rootpath},${nfsopts} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:${netdev}:off
+set_bootargs=setenv bootargs console=${console},${baudrate} target_env=${target_env} ${testargs} ${optargs}
+set_partition=setenv ${partitionset_active} true;if test -n ${A}; then setenv mmc_part_nr 1;fi;if test -n ${B}; then setenv mmc_part_nr 2;fi;setenv mmc_active_vol ${rootfs_name}p${mmc_part_nr}
+tftp_run_script=tftpboot ${kernel_loadaddr} ${serverip}:${script_file};if test $? -eq 0;then source ${kernel_loadaddr};fi
+toggle_partition=setenv ${partitionset_active} true; if test -n ${A}; then setenv partitionset_active B; mmc partconf 0 1 2 0; env delete A; fi; if test -n ${B}; then setenv partitionset_active A; mmc partconf 0 1 1 0; env delete B; fi;saveenv; reset
+upgrade_available=0
+emmc_dev=0
+sd_dev=1
+mfgtool_args=setenv bootargs console=${console},${baudrate} rdinit=/linuxrc clk_ignore_unused
+kboot=booti
+bootcmd_mfg=run mfgtool_args; if iminfo ${initrd_addr}; then if test ${tee} = yes; then bootm ${tee_addr} ${initrd_addr} ${fdt_addr}; else booti ${loadaddr} ${initrd_addr} ${fdt_addr}; fi; else echo "Run fastboot ..."; fastboot usb auto; fi;
+fastboot_bytes=124c00
+fastboot_dev=mmc
+mmcautodetect=yes
diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index 530b1f47695..5f09ceee8bc 100644
--- a/configs/capricorn_cxg3_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -3,6 +3,7 @@
 CONFIG_DEFAULT_DEVICE_TREE="imx8-capricorn-cxg3"
 CONFIG_IDENT_STRING=" ##v01.06"
 
+CONFIG_ENV_SOURCE_FILE="capricorn_default"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth1"
diff --git a/include/configs/capricorn-common.h b/include/configs/capricorn-common.h
index 4d95f3fd79b..7120a44d186 100644
--- a/include/configs/capricorn-common.h
+++ b/include/configs/capricorn-common.h
@@ -10,8 +10,6 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-#include "siemens-env-common.h"
-
 /* SPL config */
 #ifdef CONFIG_XPL_BUILD
 #define CFG_MALLOC_F_ADDR		0x00120000
@@ -36,57 +34,9 @@
 #define AHAB_ENV "sec_boot=no\0"
 #endif
 
-#define MFG_ENV_SETTINGS_DEFAULT \
-	"mfgtool_args=setenv bootargs console=${console},${baudrate} " \
-		"rdinit=/linuxrc " \
-		"clk_ignore_unused "\
-		"\0" \
-	"kboot=booti\0"\
-	"bootcmd_mfg=run mfgtool_args;" \
-	"if iminfo ${initrd_addr}; then " \
-	"if test ${tee} = yes; then " \
-		"bootm ${tee_addr} ${initrd_addr} ${fdt_addr}; " \
-	"else " \
-		"booti ${loadaddr} ${initrd_addr} ${fdt_addr}; " \
-	"fi; " \
-	"else " \
-	    "echo \"Run fastboot ...\"; fastboot 0; "  \
-	"fi;\0"
-
-/* Boot M4 */
-#define M4_BOOT_ENV \
-	"m4_0_image=m4_0.bin\0" \
-	"loadm4image_0=fatload mmc ${mmcdev}:${mmcpart} " \
-			"${loadaddr} ${m4_0_image}\0" \
-	"m4boot_0=run loadm4image_0; dcache flush; bootaux ${loadaddr} 0\0" \
-
-#define CFG_MFG_ENV_SETTINGS \
-	MFG_ENV_SETTINGS_DEFAULT \
-	"initrd_addr=0x83100000\0" \
-	"initrd_high=0xffffffffffffffff\0" \
-	"emmc_dev=0\0"
-
 /* Initial environment variables */
 #define CFG_EXTRA_ENV_SETTINGS \
-	CFG_MFG_ENV_SETTINGS \
-	M4_BOOT_ENV \
-	AHAB_ENV \
-	ENV_COMMON \
-	"script=boot.scr\0" \
-	"image=Image\0" \
-	"panel=NULL\0" \
-	"console=ttyLP2\0" \
-	"fdt_addr=0x83000000\0" \
-	"fdt_high=0xffffffffffffffff\0" \
-	"cntr_addr=0x88000000\0" \
-	"cntr_file=os_cntr_signed.bin\0" \
-	"initrd_addr=0x83800000\0" \
-	"initrd_high=0xffffffffffffffff\0" \
-	"netdev=eth0\0" \
-	"nfsopts=vers=3,udp,rsize=4096,wsize=4096,nolock rw\0" \
-	"hostname=capricorn\0" \
-	ENV_EMMC \
-	ENV_NET
+	AHAB_ENV
 
 /* Default location for tftp and bootm */
 
-- 
2.20.1

