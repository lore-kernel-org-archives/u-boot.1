Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02EEC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 13:52:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5466287214;
	Mon, 15 Jan 2024 14:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705326721;
	bh=Wsu6N1l3qzr353GZz2Hbc+zh6mwFVOSrtLsKo+ztkx0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kYr+nMUm1+zvCh8o7kA5AXkbNtEbV/aK3aQdV0F1EWNJ95ubqvoBXxE4pCe9DNHog
	 R6yc96IBW2OCAFXA5gHO2HcLbkO6q9SVQBpz/eYtRPCbsPYrqrHZNnv4xHcrq3jzmh
	 P032Q0kaEYdjJwuu945LIn5O2L5wwfduRao7MwrP/dFvc6m1qkYrFrUNV6UyzXFUaK
	 o80RF4A6+tsEnJVZpo4ZvFalCnsgHyYgt4MzJD0Zxy+aQI7s30Qi8wbFlHHUz5R8jO
	 w9GewYquh8vpLgIEzFYBQXyEMlUnc5Wi/YdQxjr/HTtAywC/abQL6p7J8X53nhwPOm
	 PymEqLWO4dvzQ==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4B16386D82;
 Mon, 15 Jan 2024 14:51:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705326719;
 bh=Wsu6N1l3qzr353GZz2Hbc+zh6mwFVOSrtLsKo+ztkx0=;
 h=From:To:Cc:Subject:Date:From;
 b=EXL8rjsAMs5ciPsZAltlbHfR7bq2zJi2hiL1YzWzTSBRYJJIfmFpVFAUeLBU/6iSC
 7Pqt8uhJYfFHsQoZrQfnPtGN0Ze4FPeqM3BClSrwX+AWLYpdy+aqjjJAn4yFsrdf8b
 /QAjrQ4ZtSuW5dJUIJcZGb9CZhztCZ1bn/I4u5stn3fZW3sYcf9tU0GvcE3MFSViED
 i8/61++WS+zGompdf1bVL41qV/BnYzzunxv5O7HONWKgCSVB0zMNIs0WnWgpJAhTy1
 HJX6jxdxXXQe/0vbvJ3Ha9ebdIS9Y/qDg3Pr5Y4luwtCpXyFNqHHKqu0GcS8DPqZt+
 0NbhY/G++R69w==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 NXP u-boot <uboot-imx@nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3 1/3] arm: xea: Move XEA's environment variables from xea.h
 to xea.env
Date: Mon, 15 Jan 2024 14:51:28 +0100
Message-Id: <20240115135130.2789123-1-lukma@denx.de>
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

Changes in v3:
- Remove customer's default IP settings for production (hardcoded
  values)
- Add missing dtbfile env variable

 board/liebherr/xea/xea.env | 139 ++++++++++++++++++++++++++++++++++++
 include/configs/xea.h      | 140 -------------------------------------
 2 files changed, 139 insertions(+), 140 deletions(-)
 create mode 100644 board/liebherr/xea/xea.env

diff --git a/board/liebherr/xea/xea.env b/board/liebherr/xea/xea.env
new file mode 100644
index 0000000000..b87b7e5801
--- /dev/null
+++ b/board/liebherr/xea/xea.env
@@ -0,0 +1,139 @@
+bootmode=update
+bootpri=mmc_mmc
+bootsec=sf_swu
+consdev=ttyAMA0
+baudrate=115200
+dtbfile=imx28-xea.dtb
+rootdev=/dev/mmcblk0p2
+netdev=eth0
+swufile=swupdate-image-xea-upd.itb
+sf_kernel_offset=0xA0000
+sf_swu_size=0xF40000
+ethact=FEC
+arch=xea
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

