Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3919D715C7
	for <u-boot@archiver.kernel.org>; Sat, 24 Jan 2026 05:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0629583CD3;
	Sat, 24 Jan 2026 06:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="jKwWyWW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E2683C01; Sat, 24 Jan 2026 06:55:11 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCB483BF4
 for <u-boot@lists.denx.de>; Sat, 24 Jan 2026 06:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D2D5A10F279; Sat, 24 Jan 2026 06:55:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1769234105; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=K4nDSA77l7N51N0OI1oZlVrl5sR+IoF3hWHOGxDhMjQ=;
 b=jKwWyWW56Ad29RQzm+Et43vt4shnvIq4QDApQFDBn9lZvTILlhL/KHCP8YLCGiBTELO42u
 ZNWk474XulwoFh3LW38qNKVh4Tj9MB+8jEHy5Oz+Co1mPrjrHY8vzJXkyfHDrG76/Qhjt1
 ajOHjzbxLG22QtIYIrm5UPfzs1CripgNQ+ZzAvf6ViBxSMZA/I6n/rNGqVqKswESAtFGaI
 5n3fm1UUDbzVcr8R4bnB7m/Nfro8Bw4In74kGLvohP4vQb5JBDuQYlZapmlC7lIbKzV+Id
 461466yoRtq4aTs2tQ8dXXzIAy990x+mWfZyj4Wt5jN1Jo1rCk/M11Ew9pvGjw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v1 10/11] siemens: capricorn: rework bootcmd environment
 variables
Date: Sat, 24 Jan 2026 06:54:51 +0100
Message-Id: <20260124055452.8799-11-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260124055452.8799-1-hs@nabladev.com>
References: <20260124055452.8799-1-hs@nabladev.com>
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

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Rework the boot state machine to a significantly simpler and more
robust implementation. The basic idea is to revert to the previous
partition whenever an issue is detected during the boot process.

- Broken SPL

  If one of the two SPLs does not boot, the ROM code of the i.MX8 SoC
  automatically starts the second SPL from the second boot partition.
  For example, if the system's active partition is A but the SPL from
  partition A is broken, the ROM code automatically uses the SPL/u-boot
  from partition B.
  Proceeding with this boot procedure would lead to booting the kernel/
  rootfs from partition A, which could potentially successfully boot
  the system and allow the user to apply the firmware update with the
  broken SPL again. This would lead to a non-bootable system because
  thesecond update would overwrite the last working bootloader.
  To prevent such situations, zigzag boots are detected and the system
  reverts to the previous partition rather than booting the kernel/rootfs
  from the currently active partition. Detecting zigzag boots is done
  via the new fallback variable.

  To make this state machine even more consistent, the partitionset_active
  variable is no longer used to determine the active partition during
  boot. Instead, the active partition is always read from the eMMC
  partconf registers.
  For backward compatibility, the partitionset_active variable is still
  updated whenever a partition switch occurs. However, u-boot no longer
  relies on this variable, as it could potentially be out of sync with
  the actual partition state, leading to situations where the ROM code
  of the i.MX8 SoC would be out of sync with u-boot.

- Broken kernel, initramfs or rootfs

  If the upgrade_available variable is set, u-boot counts the number of
  consecutive boots via the bootcount variable. If the bootcount exceeds
  the bootlimit variable, u-boot starts the altbootcmd instead of the
  bootcmd. Previously, this logic was bypassed by assigning the regular
  bootcmd to altbootcmd. Now, the altbootcmd is used to revert to the
  previous partition when the bootlimit is exceeded.

The netdev variable is changed to eth0 by default. This is what the FEC
driver uses on Capricorn boards. For devices with switches and DSA
subsystems in use, the netdev should be set accordingly by additional
logic in the environment or u-boot code. This is not part of this commit.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
Ignore checkpatch warning:
board/siemens/capricorn/capricorn_default.env:4: warning: line length of 118 exceeds 100 columns
board/siemens/capricorn/capricorn_default.env:37: warning: line length of 130 exceeds 100 columns
board/siemens/capricorn/capricorn_default.env:40: warning: line length of 321 exceeds 100 columns

 board/siemens/capricorn/capricorn_default.env | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/board/siemens/capricorn/capricorn_default.env b/board/siemens/capricorn/capricorn_default.env
index cf5bd09a4da..9d2eba0181f 100644
--- a/board/siemens/capricorn/capricorn_default.env
+++ b/board/siemens/capricorn/capricorn_default.env
@@ -1,10 +1,10 @@
-altbootcmd=run bootcmd
+altbootcmd=run toggle_partition
 baudrate=115200
 bootcmd=run flash_self;reset;
+bootcmd=if test -n "$fallback"; then echo "fallback: $fallback"; run toggle_partition ; else run flash_self; reset; fi
 bootdelay=3
 bootdir=targetdir/rootfs/boot
 bootlimit=3
-check_upgrade=if test ${upgrade_available} -eq 1; then echo  upgrade_available is set; if test ${bootcount} -gt ${bootlimit}; then setenv upgrade_available 0;echo toggle partition;run toggle_partition;fi;fi;
 cntr_addr=0x88000000
 cntr_file=os_cntr_signed.bin
 console=ttyLP2
@@ -19,13 +19,13 @@ initrd_high=0xffffffffffffffff
 ip_method=none
 kernel_name=Image
 loadaddr=0x80400000
-mmc_boot=run set_bootargs;run check_upgrade; run set_partition;run set_bootargs_mmc;run mmc_load_bootfiles
+mmc_boot=run set_bootargs; run set_partition;run set_bootargs_mmc;run mmc_load_bootfiles
 mmc_boot_fit=ext4load mmc 0:${mmc_part_nr} 0x88000000 boot/fitImage;if test -n ${A};then setenv bootargs ${bootargs} rootfs_sig=${sig_a};fi;if test -n ${B};then setenv bootargs ${bootargs} rootfs_sig=${sig_b};fi;bootm 0x88000000#conf-${dtb_name}.dtb;bootm 0x88000000
 mmc_boot_image=ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name}.dtb;if test $? -eq 1;then ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name_default}.dtb;fi; ext4load mmc 0:${mmc_part_nr} ${loadaddr} boot/${kernel_name}; booti ${loadaddr} - ${fdt_addr}
 mmc_load_bootfiles=echo -n Loading from eMMC ...; if test -e mmc 0:${mmc_part_nr} boot/fitImage; then echo fit; setenv fdt_high; setenv initrd_high; run mmc_boot_fit; else echo image; run mmc_boot_image; fi
 net_nfs=wdt dev scu-wdt; wdt stop; echo Booting from network ...; run set_bootargs_net; tftpboot ${loadaddr} ${bootdir}/${kernel_name}; printenv bootargs; if test ${kernel_name} = fitImage; then setenv fdt_high; setenv initrd_high; bootm ${loadaddr}#conf-${dtb_name}.dtb; else tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name}.dtb; if test $? -eq 1; then echo Loading default.dtb!; tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name_default}.dtb; fi; booti ${loadaddr} - ${fdt_addr}; fi
 net_unfs=setenv nfsopts vers=3,udp,rsize=4096,wsize=4096,nolock,port=3049,mountport=3048 rw; run net_nfs
-netdev=lan0
+netdev=eth0
 nfsopts=vers=3,udp,rsize=4096,wsize=4096,nolock rw
 partitionset_active=A
 rootfs_name=/dev/mmcblk0
@@ -34,9 +34,10 @@ script_file=u-boot-commands.img
 set_bootargs_mmc=setenv bootargs ${bootargs} root=${mmc_active_vol} ro rootdelay=1 rootwait rootfstype=ext4 ip=${ip_method}
 set_bootargs_net=run set_bootargs; if test ${kernel_name} = fitImage; then setenv loadaddr 0x88000000; fi; setenv bootargs ${bootargs} root=/dev/nfs nfsroot=${serverip}:${rootpath},${nfsopts} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:${netdev}:off
 set_bootargs=setenv bootargs console=${console},${baudrate} target_env=${target_env} ${testargs} ${optargs}
-set_partition=setenv ${partitionset_active} true;if test -n ${A}; then setenv mmc_part_nr 1;fi;if test -n ${B}; then setenv mmc_part_nr 2;fi;setenv mmc_active_vol ${rootfs_name}p${mmc_part_nr}
+set_partition=mmc partconf 0 v_mmc_part_nr; setenv mmc_part_nr $v_mmc_part_nr; setenv mmc_active_vol ${rootfs_name}p$v_mmc_part_nr
 tftp_run_script=tftpboot ${kernel_loadaddr} ${serverip}:${script_file};if test $? -eq 0;then source ${kernel_loadaddr};fi
-toggle_partition=setenv ${partitionset_active} true; if test -n ${A}; then setenv partitionset_active B; mmc partconf 0 1 2 0; env delete A; fi; if test -n ${B}; then setenv partitionset_active A; mmc partconf 0 1 1 0; env delete B; fi;saveenv; reset
+toggle_partition_fin=bootcount reset; setenv upgrade_available 0; saveenv; reset
+toggle_partition=mmc partconf 0 v_mmc_part_nr; if test $v_mmc_part_nr -eq 1; then mmc partconf 0 1 2 0; setenv partitionset_active B; run toggle_partition_fin; elif test $v_mmc_part_nr -eq 2; then mmc partconf 0 1 1 0; setenv partitionset_active A; run toggle_partition_fin; else echo error mmc_part_nr $v_mmc_part_nr; fi
 upgrade_available=0
 emmc_dev=0
 sd_dev=1
-- 
2.20.1

