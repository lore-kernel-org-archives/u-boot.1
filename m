Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4EEC4725D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 11:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16C7687A4B;
	Thu, 11 Jan 2024 12:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704971194;
	bh=pkKdlSrqyL9/S8Lutqau0MQcWDJBcoh6KpI4PysurG0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=efyt/nr4Ad9Stls2lB0Q4hg495PSBaKopX4sbOWNfxr9tYWycOXzcbp4oEmpxhi9a
	 Rv5xFzfypnNIjz4QKjjr+NGs0HAOVcgddSG2bJl4ItWE5ZmNnz/ZKWHaL/bvnWeLXs
	 HNPnMQ5szjbG8xW/rkcHeW403D3KjO1U1YpbfpA+HQW2m8eK2ruL950imMdXqivBoL
	 hFMul/nDlXpLWlwnJSBFc7cYJrC7fMxEOdEyhtmCTDlBxfXRKb1ywMcz+GwD01qYTk
	 7TRg9dO8vq8n8cHMuywYQNGv0JqT4+U3IH9t+Bl5N/QqKkGPGgNpYXBFLh5V5bBXec
	 QORfcjNtp1yJA==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A960C87887;
 Thu, 11 Jan 2024 12:06:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704971193;
 bh=pkKdlSrqyL9/S8Lutqau0MQcWDJBcoh6KpI4PysurG0=;
 h=From:To:Cc:Subject:Date:From;
 b=jsdTvPJrcRwsU4eCpK9rd50jGO4t7IgKao2ba8IoGJUAjcKXoWAe/i10nPujtp01B
 EkCy35w0H2QMDojjNXE+cWPHY4bJ1hNFH9rUGngBfFwAGQj2Z+Gv3bRnOiGaojOuH8
 B9+W2i7ENWKV8mTIB+SXcWay7dt+gkUePBshSYM9sdmkO0btcsW+9aielrOmBPFkBx
 OadPw6jMOL6RRxrUx2zy9kLWnjBQCYrLSDX84rYhn1w8kRG/isBkYmmzlnHTBhdAm3
 QEp4PBj1NzNy9Iq13vrClC/MyF7es7C55TIu2yawYkLUewkH91u6CwM13ELu2L3Xoh
 Par9ns5egI3cw==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 NXP u-boot <uboot-imx@nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 1/3] arm: xea: Move XEA's environment variables from xea.h
 to xea.env
Date: Thu, 11 Jan 2024 12:06:09 +0100
Message-Id: <20240111110611.2051821-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
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

The default set of environment variables from CFG_EXTRA_ENV_SETTINGS
has been moved to a separate file - board/liebherr/xea/xea.env

Adjustments done:
- fitImage support
- SPI-NOR layout re-organization

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

(no changes since v1)

 board/liebherr/xea/xea.env | 141 +++++++++++++++++++++++++++++++++++++
 include/configs/xea.h      | 140 ------------------------------------
 2 files changed, 141 insertions(+), 140 deletions(-)
 create mode 100644 board/liebherr/xea/xea.env

diff --git a/board/liebherr/xea/xea.env b/board/liebherr/xea/xea.env
new file mode 100644
index 0000000000..7dcc122626
--- /dev/null
+++ b/board/liebherr/xea/xea.env
@@ -0,0 +1,141 @@
+bootmode=update
+bootpri=mmc_mmc
+bootsec=sf_swu
+consdev=ttyAMA0
+baudrate=115200
+rootdev=/dev/mmcblk0p2
+netdev=eth0
+swufile=swupdate-image-xea-upd.itb
+sf_kernel_offset=0xA0000
+sf_swu_size=0xF40000
+ethact=FEC
+arch=xea
+serverip=10.8.217.79
+nfs_serverip=10.8.218.113
+gatewayip=10.8.209.250
+lwe_env=
+	if dhcp ${loadaddr} ${hostname}/${lwe_uenv} ; then
+	source ${loadaddr};
+	fi
+lwe_uenv=env_uboot_xea.bin
+do_update_mmc=
+	if mmc rescan ; then
+	mmc dev 0 ${update_mmc_part} ;
+	if dhcp ${hostname}/${update_filename} ; then
+	setexpr fw_sz ${filesize} / 0x200 ;
+	setexpr fw_sz ${fw_sz} + 1 ;
+	mmc write ${loadaddr} ${update_offset} ${fw_sz} ;
+	fi ;
+	fi
+do_update_sf=
+	if sf probe ; then
+	if dhcp ${hostname}/${update_filename} ; then
+	sf erase ${update_offset} +${filesize} ;
+	sf write ${loadaddr} ${update_offset} ${filesize} ;
+	fi ;
+	fi
+factory_reset=
+	if sf probe ; then
+	run update_swu ;
+	setenv bootmode update ;
+	saveenv ;
+	fi
+update_spl_filename=u-boot.sb
+update_spl=
+	setenv update_filename ${update_spl_filename} ;
+	setenv update_offset 0 ;
+	run do_update_sf
+update_uboot_filename=u-boot.img
+update_uboot=
+	setenv update_filename ${update_uboot_filename} ;
+	setenv update_offset 0x10000 ;
+	run do_update_sf ;
+	setenv update_mmc_part 1 ;
+	setenv update_offset 0 ;
+	run do_update_mmc ;
+	setenv update_mmc_part 2 ;
+	run do_update_mmc
+update_kernel_filename=uImage
+update_kernel=
+	setenv update_mmc_part 1 ;
+	setenv update_filename ${update_kernel_filename} ;
+	setenv update_offset 0x800 ;
+	run do_update_mmc ;
+	setenv update_filename ${dtbfile} ;
+	setenv update_offset 0x400 ;
+	run do_update_mmc
+update_swu=
+	setenv update_filename ${swufile} ;
+	setenv update_offset ${sf_kernel_offset} ;
+	run do_update_sf
+addcons=
+	setenv bootargs ${bootargs}
+	console=${consdev},${baudrate}
+addip=
+	setenv bootargs ${bootargs}
+	ip=${ipaddr}:${serverip}:${gatewayip}:
+		${netmask}:${hostname}:${netdev}:off
+addmisc=
+	setenv bootargs ${bootargs} ${miscargs}
+addargs=run addcons addmisc
+mmcload=
+	mmc rescan ;
+	mmc dev 0 1 ;
+	mmc read ${loadaddr} 0x800 0x2000 ;
+	mmc read ${dtbaddr} 0x400 0x80
+netload=
+	dhcp ${loadaddr} ${hostname}/${bootfile} ;
+	tftp ${dtbaddr} ${hostname}/${dtbfile}
+usbload=
+	usb start ;
+	load usb 0:1 ${loadaddr} ${bootfile}
+miscargs=panic=1
+mmcargs=setenv bootargs root=${rootdev} rw rootwait
+nfsargs=
+	setenv bootargs root=/dev/nfs rw
+		nfsroot=${serverip}:${rootpath},v3,tcp
+mmc_mmc=
+	if run mmcload mmcargs addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+mmc_nfs=
+	if run mmcload nfsargs addip addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+sf_mmc=
+	if run sfload mmcargs addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+sf_swu=
+	if sf probe ; then
+	sf read ${loadaddr} ${sf_kernel_offset} ${sf_swu_size} ;
+	setenv bootargs root=/dev/ram0 rw ;
+	run addargs ;
+	bootm ${loadaddr} ;
+	fi
+net_mmc=
+	if run netload mmcargs addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+net_nfs=
+	if run netload nfsargs addip addargs ; then
+	bootm ${loadaddr} - ${dtbaddr} ;
+	fi
+prebootcmd=
+	if test ${envsaved} != y ; then ;
+	setenv envsaved y ;
+	saveenv ;
+	fi ;
+	if test ${bootmode} = normal ; then
+	setenv bootdelay 0 ;
+	setenv bootpri mmc_mmc ;
+	elif test ${bootmode} = devel ; then
+	setenv bootdelay 3 ;
+	setenv bootpri net_mmc ;
+	else
+	if test ${bootmode} != update ; then
+	echo Warning: unknown bootmode ${bootmode} ;
+	fi ;
+	setenv bootdelay 1 ;
+	setenv bootpri sf_swu ;
+	fi
diff --git a/include/configs/xea.h b/include/configs/xea.h
index 04ca5aa12a..00d6274873 100644
--- a/include/configs/xea.h
+++ b/include/configs/xea.h
@@ -25,146 +25,6 @@
 #define PHYS_SDRAM_1_SIZE		0x10000000	/* Max 256 MB RAM */
 #define CFG_SYS_SDRAM_BASE		PHYS_SDRAM_1
 
-/* Extra Environment */
-
-#define CFG_EXTRA_ENV_SETTINGS					\
-	"bootmode=update\0"						\
-	"bootpri=mmc_mmc\0"						\
-	"bootsec=sf_swu\0"						\
-	"consdev=ttyAMA0\0"						\
-	"baudrate=115200\0"						\
-	"dtbaddr=0x44000000\0"						\
-	"dtbfile=imx28-xea.dtb\0"					\
-	"rootdev=/dev/mmcblk0p2\0"					\
-	"netdev=eth0\0"							\
-	"rdaddr=0x43000000\0"						\
-	"swufile=swupdate.img\0"					\
-	"sf_kernel_offset=0x100000\0"					\
-	"sf_kernel_size=0x400000\0"					\
-	"sf_swu_offset=0x500000\0"					\
-	"sf_swu_size=0x800000\0"					\
-	"rootpath=/opt/eldk-5.5/armv5te/rootfs-qte-sdk\0"		\
-	"do_update_mmc="						\
-		"if mmc rescan ; then "					\
-		"mmc dev 0 ${update_mmc_part} ; "			\
-		"if dhcp ${hostname}/${update_filename} ; then "	\
-		"setexpr fw_sz ${filesize} / 0x200 ; "	/* SD block size */ \
-		"setexpr fw_sz ${fw_sz} + 1 ; "				\
-		"mmc write ${loadaddr} ${update_offset} ${fw_sz} ; "	\
-		"fi ; "							\
-		"fi\0"							\
-	"do_update_sf="							\
-		"if sf probe ; then "					\
-		"if dhcp ${hostname}/${update_filename} ; then "	\
-		"sf erase ${update_offset} +${filesize} ; "		\
-		"sf write ${loadaddr} ${update_offset} ${filesize} ; "	\
-		"fi ; "							\
-		"fi\0"							\
-	"update_spl_filename=u-boot.sb\0"				\
-	"update_spl="							\
-		"setenv update_filename ${update_spl_filename} ; "	\
-		"setenv update_offset 0 ; "				\
-		"run do_update_sf\0"					\
-	"update_uboot_filename=u-boot.img\0"				\
-	"update_uboot="							\
-		"setenv update_filename ${update_uboot_filename} ; "	\
-		"setenv update_offset 0x10000 ; "			\
-		"run do_update_sf ; "					\
-		"setenv update_mmc_part 1 ; "				\
-		"setenv update_offset 0 ; "				\
-		"run do_update_mmc\0"					\
-	"update_kernel_filename=uImage\0"				\
-	"update_kernel="						\
-		"setenv update_mmc_part 1 ; "				\
-		"setenv update_filename ${update_kernel_filename} ; "	\
-		"setenv update_offset 0x800 ; "				\
-		"run do_update_mmc ; "					\
-		"setenv update_filename ${dtbfile} ; "			\
-		"setenv update_offset 0x400 ; "				\
-		"run do_update_mmc\0"					\
-	"update_sfkernel="						\
-		"setenv update_filename fitImage ; "			\
-		"setenv update_offset ${sf_kernel_offset} ; "		\
-		"run do_update_sf\0"					\
-	"update_swu="							\
-		"setenv update_filename ${swufile} ; "			\
-		"setenv update_offset ${sf_swu_offset} ; "		\
-		"run do_update_sf\0"					\
-	"addcons="							\
-		"setenv bootargs ${bootargs} "				\
-		"console=${consdev},${baudrate}\0"			\
-	"addip="							\
-		"setenv bootargs ${bootargs} "				\
-		"ip=${ipaddr}:${serverip}:${gatewayip}:"		\
-			"${netmask}:${hostname}:${netdev}:off\0"	\
-	"addmisc="							\
-		"setenv bootargs ${bootargs} ${miscargs}\0"		\
-	"addargs=run addcons addmisc\0"					\
-	"mmcload="							\
-		"mmc rescan ; "						\
-		"mmc dev 0 1 ; "					\
-		"mmc read ${loadaddr} 0x800 0x2000 ; "			\
-		"mmc read ${dtbaddr} 0x400 0x80\0"			\
-	"netload="							\
-		"dhcp ${loadaddr} ${hostname}/${bootfile} ; "		\
-		"tftp ${dtbaddr} ${hostname}/${dtbfile}\0"		\
-	"sfload="							\
-		"sf probe ; "						\
-		"sf read ${loadaddr} ${sf_kernel_offset} ${sf_kernel_size}\0" \
-	"usbload="							\
-		"usb start ; "						\
-		"load usb 0:1 ${loadaddr} ${bootfile}\0"		\
-	"miscargs=panic=1\0"						\
-	"mmcargs=setenv bootargs root=${rootdev} rw rootwait\0"		\
-	"nfsargs="							\
-		"setenv bootargs root=/dev/nfs rw "			\
-			"nfsroot=${serverip}:${rootpath},v3,tcp\0"	\
-	"mmc_mmc="							\
-		"if run mmcload mmcargs addargs ; then "		\
-		"bootm ${loadaddr} - ${dtbaddr} ; "			\
-		"fi\0"							\
-	"mmc_nfs="							\
-		"if run mmcload nfsargs addip addargs ; then "		\
-		"bootm ${loadaddr} - ${dtbaddr} ; "			\
-		"fi\0"							\
-	"sf_mmc="							\
-		"if run sfload mmcargs addargs ; then "			\
-		"bootm ${loadaddr} - ${dtbaddr} ; "			\
-		"fi\0"							\
-	"sf_swu="							\
-		"if run sfload ; then "					\
-		"sf read ${rdaddr} ${sf_swu_offset} ${sf_swu_size} ; "	\
-		"setenv bootargs root=/dev/ram0 rw ; "			\
-		"run addargs ; "					\
-		"bootm ${loadaddr} ${rdaddr} ; "		\
-		"fi\0"							\
-	"net_mmc="							\
-		"if run netload mmcargs addargs ; then "		\
-		"bootm ${loadaddr} - ${dtbaddr} ; "			\
-		"fi\0"							\
-	"net_nfs="							\
-		"if run netload nfsargs addip addargs ; then "		\
-		"bootm ${loadaddr} - ${dtbaddr} ; "			\
-		"fi\0"							\
-	"prebootcmd="							\
-		"if test \"${envsaved}\" != y ; then ; "		\
-		"setenv envsaved y ; "					\
-		"saveenv ; "						\
-		"fi ; "							\
-		"if test \"${bootmode}\" = normal ; then "		\
-		"setenv bootdelay 0 ; "					\
-		"setenv bootpri mmc_mmc ; "				\
-		"elif test \"${bootmode}\" = devel ; then "		\
-		"setenv bootdelay 3 ; "					\
-		"setenv bootpri net_mmc ; "				\
-		"else "							\
-		"if test \"${bootmode}\" != update ; then "		\
-		"echo Warning: unknown bootmode \"${bootmode}\" ; "	\
-		"fi ; "							\
-		"setenv bootdelay 1 ; "					\
-		"setenv bootpri sf_swu ; "				\
-		"fi\0"
-
 /* The rest of the configuration is shared */
 #include <configs/mxs.h>
 
-- 
2.39.2

