Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37392E909D9
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 16:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDAB883E76;
	Tue, 17 Feb 2026 17:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="c5diunwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB95B83E4C; Tue, 17 Feb 2026 17:39:25 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F8483D3D
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 17:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7FC6F110AE3; Tue, 17 Feb 2026 17:39:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1771346362; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=9kX00FeFvYRxEGbhmndT8dtKrBi8TJ02s07Q04R7YpI=;
 b=c5diunwGgFc/wpf9ZxrUiZE16WFb+9ANUWeSfw2X0bfoCDuwtQnWGQyQkq05xWlvgnH8S1
 1xxn0KvmzsPQJEAZJyuXvV/rPj2Cc3HxF7B5MLJRZYi3/bUOWaO87710kwuU5Usn8eMaDx
 urQS/0+C9tiUkP95ExIjuR0x7XaQ5S0PzcMlbsyrbJL6TJq+78ifEc1bVnobLTfCUwEDeN
 8Nl74/KtNeBxxf7xrkWud4QYKrf1yAGVx+6SMWkKQ1OyoOLCEk9rBOQmwy5uKqqsTA79oF
 ZwWdx8JDWIQ12TFvCF6O0X+P7UOgwRt6mPN6pAQaf4AWd9mj3BB8Ce66NiSgqw==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: [PATCH v3 10/11] siemens: capricorn: rework bootcmd environment
 variables
Date: Tue, 17 Feb 2026 17:39:10 +0100
Message-Id: <20260217163911.31878-11-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260217163911.31878-1-hs@nabladev.com>
References: <20260217163911.31878-1-hs@nabladev.com>
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
  the second update would overwrite the last working bootloader.
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
Reviewed-by: Peng Fan <peng.fan@nxp.com>

---

Changes in v3:
fixed long line length in environment file as Max suggested.

Changes in v2:
Added Acked-by from Peng, fixed typo in commit message
Added small fixes in Environment from Adrian: It fixes a serious bug which
Adrian detect. It occurs when a broken firmware is applied as a downgrade.
The old bootloader ended up in an endless reboot boot loop. With this fix
also the old bootloader is able to reject the update and recover. Also
slightly reworked bootcmd.

 board/siemens/capricorn/capricorn_default.env | 90 +++++++++++++++----
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/board/siemens/capricorn/capricorn_default.env b/board/siemens/capricorn/capricorn_default.env
index c150025c882..10d612b04fe 100644
--- a/board/siemens/capricorn/capricorn_default.env
+++ b/board/siemens/capricorn/capricorn_default.env
@@ -1,17 +1,23 @@
-altbootcmd=run bootcmd
+terminate_upgrade=bootcount reset; setenv upgrade_available 0
+altbootcmd=run terminate_upgrade; run toggle_partition
 baudrate=115200
 bootcmd=run flash_self;reset;
 bootdelay=3
 bootdir=targetdir/rootfs/boot
 bootlimit=3
-check_upgrade=if test ${upgrade_available} -eq 1; then echo  upgrade_available is set; if test ${bootcount} -gt ${bootlimit}; then setenv upgrade_available 0;echo toggle partition;run toggle_partition;fi;fi;
 cntr_addr=0x88000000
 cntr_file=os_cntr_signed.bin
 console=ttyLP2
 dtb_name_default=default
 ethprime=eth1
 fdt_addr=0x83000000
-flash_self=run mmc_boot
+flash_self=if test -n "$fallback";then
+		echo "fallback: $fallback";
+		run terminate_upgrade;
+		run toggle_partition;
+	else
+		run mmc_boot;
+	fi
 flash_self_test=setenv testargs test loglevel=3 systemd.unit=test.target; run mmc_boot
 hostname=capricorn
 initrd_addr=0x83100000
@@ -19,7 +25,7 @@ initrd_high=0xffffffffffffffff
 ip_method=none
 kernel_name=Image
 loadaddr=0x80400000
-mmc_boot=run set_bootargs;run check_upgrade; run set_partition;run set_bootargs_mmc;run mmc_load_bootfiles
+mmc_boot=run set_bootargs; run set_partition;run set_bootargs_mmc;run mmc_load_bootfiles
 mmc_boot_fit=ext4load mmc 0:${mmc_part_nr} 0x88000000 boot/fitImage;
 	if test -n ${A};then
 		setenv bootargs ${bootargs} rootfs_sig=${sig_a};
@@ -28,27 +34,79 @@ mmc_boot_fit=ext4load mmc 0:${mmc_part_nr} 0x88000000 boot/fitImage;
 		setenv bootargs ${bootargs} rootfs_sig=${sig_b};
 	fi;
 	bootm 0x88000000#conf-${dtb_name}.dtb;bootm 0x88000000
-mmc_boot_image=ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name}.dtb;if test $? -eq 1;then ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name_default}.dtb;fi; ext4load mmc 0:${mmc_part_nr} ${loadaddr} boot/${kernel_name}; booti ${loadaddr} - ${fdt_addr}
-mmc_load_bootfiles=echo -n Loading from eMMC ...; if test -e mmc 0:${mmc_part_nr} boot/fitImage; then echo fit; setenv fdt_high; setenv initrd_high; run mmc_boot_fit; else echo image; run mmc_boot_image; fi
-net_nfs=wdt dev scu-wdt; wdt stop; echo Booting from network ...; run set_bootargs_net; tftpboot ${loadaddr} ${bootdir}/${kernel_name}; printenv bootargs; if test ${kernel_name} = fitImage; then setenv fdt_high; setenv initrd_high; bootm ${loadaddr}#conf-${dtb_name}.dtb; else tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name}.dtb; if test $? -eq 1; then echo Loading default.dtb!; tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name_default}.dtb; fi; booti ${loadaddr} - ${fdt_addr}; fi
-net_unfs=setenv nfsopts vers=3,udp,rsize=4096,wsize=4096,nolock,port=3049,mountport=3048 rw; run net_nfs
-netdev=lan0
+mmc_boot_image=ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name}.dtb;
+	if test $? -eq 1;then
+		ext4load mmc 0:${mmc_part_nr} ${fdt_addr} boot/${dtb_name_default}.dtb;
+	fi;
+	ext4load mmc 0:${mmc_part_nr} ${loadaddr} boot/${kernel_name};
+	booti ${loadaddr} - ${fdt_addr}
+mmc_load_bootfiles=echo -n Loading from eMMC ...;
+	if test -e mmc 0:${mmc_part_nr} boot/fitImage; then
+		echo fit; setenv fdt_high; setenv initrd_high; run mmc_boot_fit;
+	else
+		echo image; run mmc_boot_image;
+	fi
+net_nfs=wdt dev scu-wdt; wdt stop; echo Booting from network ...;
+	run set_bootargs_net; tftpboot ${loadaddr} ${bootdir}/${kernel_name};
+	printenv bootargs;
+	if test ${kernel_name} = fitImage; then
+		setenv fdt_high; setenv initrd_high;
+		bootm ${loadaddr}#conf-${dtb_name}.dtb;
+	else
+		tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name}.dtb;
+		if test $? -eq 1; then
+			echo Loading default.dtb!;
+			tftpboot ${fdt_addr} ${serverip}:${bootdir}/${dtb_name_default}.dtb;
+		fi;
+		booti ${loadaddr} - ${fdt_addr};
+	fi
+net_unfs=setenv nfsopts vers=3,udp,rsize=4096,wsize=4096,nolock,port=3049,mountport=3048 rw;
+	run net_nfs
+netdev=eth0
 nfsopts=vers=3,udp,rsize=4096,wsize=4096,nolock rw
 partitionset_active=A
 rootfs_name=/dev/mmcblk0
 rootpath=/home/projects/targetdir/rootfs
 script_file=u-boot-commands.img
-set_bootargs_mmc=setenv bootargs ${bootargs} root=${mmc_active_vol} ro rootdelay=1 rootwait rootfstype=ext4 ip=${ip_method}
-set_bootargs_net=run set_bootargs; if test ${kernel_name} = fitImage; then setenv loadaddr 0x88000000; fi; setenv bootargs ${bootargs} root=/dev/nfs nfsroot=${serverip}:${rootpath},${nfsopts} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:${netdev}:off
-set_bootargs=setenv bootargs console=${console},${baudrate} target_env=${target_env} ${testargs} ${optargs}
-set_partition=setenv ${partitionset_active} true;if test -n ${A}; then setenv mmc_part_nr 1;fi;if test -n ${B}; then setenv mmc_part_nr 2;fi;setenv mmc_active_vol ${rootfs_name}p${mmc_part_nr}
-tftp_run_script=tftpboot ${kernel_loadaddr} ${serverip}:${script_file};if test $? -eq 0;then source ${kernel_loadaddr};fi
-toggle_partition=setenv ${partitionset_active} true; if test -n ${A}; then setenv partitionset_active B; mmc partconf 0 1 2 0; env delete A; fi; if test -n ${B}; then setenv partitionset_active A; mmc partconf 0 1 1 0; env delete B; fi;saveenv; reset
+set_bootargs_mmc=setenv bootargs ${bootargs} root=${mmc_active_vol} ro rootdelay=1
+	rootwait rootfstype=ext4 ip=${ip_method}
+set_bootargs_net=run set_bootargs;
+	if test ${kernel_name} = fitImage; then
+		setenv loadaddr 0x88000000;
+	fi;
+	setenv bootargs ${bootargs} root=/dev/nfs nfsroot=${serverip}:${rootpath},${nfsopts}
+		ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:${netdev}:off
+set_bootargs=setenv bootargs console=${console},${baudrate} target_env=${target_env} ${testargs}
+	${optargs}
+set_partition=mmc partconf 0 v_mmc_part_nr; setenv mmc_part_nr $v_mmc_part_nr;
+	setenv mmc_active_vol ${rootfs_name}p$v_mmc_part_nr
+tftp_run_script=tftpboot ${kernel_loadaddr} ${serverip}:${script_file};
+	if test $? -eq 0;then
+		source ${kernel_loadaddr};
+	fi
+toggle_partition=mmc partconf 0 v_mmc_part_nr;
+	if test $v_mmc_part_nr -eq 1;then
+		mmc partconf 0 1 2 0; setenv partitionset_active B;
+	elif test $v_mmc_part_nr -eq 2;then
+		mmc partconf 0 1 1 0; setenv partitionset_active A;
+	else
+		echo error mmc_part_nr $v_mmc_part_nr;
+	fi;
+	saveenv;reset
 upgrade_available=0
 emmc_dev=0
 sd_dev=1
 mfgtool_args=setenv bootargs console=${console},${baudrate} rdinit=/linuxrc clk_ignore_unused
 kboot=booti
-bootcmd_mfg=run mfgtool_args; if iminfo ${initrd_addr}; then if test ${tee} = yes; then bootm ${tee_addr} ${initrd_addr} ${fdt_addr}; else booti ${loadaddr} ${initrd_addr} ${fdt_addr}; fi; else echo "Run fastboot ..."; fastboot usb auto; fi;
+bootcmd_mfg=run mfgtool_args;
+	if iminfo ${initrd_addr}; then
+		if test ${tee} = yes; then
+			bootm ${tee_addr} ${initrd_addr} ${fdt_addr};
+		else
+			booti ${loadaddr} ${initrd_addr} ${fdt_addr};
+		fi;
+	else
+		echo "Run fastboot ..."; fastboot usb auto;
+	fi;
 fastboot_bytes=124c00
 fastboot_dev=mmc
-- 
2.20.1

