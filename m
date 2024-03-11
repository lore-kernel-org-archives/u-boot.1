Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6DFC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D6ED87EB2;
	Mon, 11 Mar 2024 14:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="pt+rtVQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA61087D50; Mon, 11 Mar 2024 14:04:22 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AB4687DD5
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710162257; x=1712754257;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UmKdmJBh4A3rUsr19fcU2wlcyCEHx1q6KTM90YonRwU=;
 b=pt+rtVQBivgWwIeC0HHqKoSjstiotQHYnW3AT4CXoVD6EvauKW8aBZaNMHF1F/RF
 p3rkNSLD5SVv9M/jYUqWlq2TnOvAQkMAK3P1kGYFfx1MOw8flkYR5ucHVv9Bcpbs
 3kZmW/jZmUPrzutuACBA3m4comsX47iFPOOAeYPp8mU=;
X-AuditID: ac14000a-fadff7000000290d-0a-65ef0151473d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B3.93.10509.1510FE56;
 Mon, 11 Mar 2024 14:04:17 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Mar
 2024 14:04:17 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 1/5] phycore_imx8mp: Move environment from include/config to
 board
Date: Mon, 11 Mar 2024 14:03:56 +0100
Message-ID: <20240311130400.4023780-2-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311130400.4023780-1-l.anderweit@phytec.de>
References: <20240311130400.4023780-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWyRpKBRzeQ8X2qweQLlhYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgylnZ/Zyo4
 JVtx8lM7YwPjdYkuRk4OCQETiVnXTzB1MXJxCAksZpJ4vW01O4TzmFHi2c+frCBVbAL6Eitf
 LmIBsUUEXCR+Ld0DZHNwMAuYSUz4nAwSFhYIkvj78zg7iM0ioCoxfXMfM0gJr4CNxL1tohC7
 5CVmXvoOVsIpYCsx68FfZhBbCKjkzaaLbCA2r4CgxMmZT8A2MQPVN2+dzQxhS0gcfPECql5J
 4s6pX2wwM6ede80MYYdKHNm0mmkCo9AsJKNmIRk1C8moBYzMqxiFcjOTs1OLMrP1CjIqS1KT
 9VJSNzGCQlyEgWsHY98cj0OMTByMhxglOJiVRHhf67xNFeJNSaysSi3Kjy8qzUktPsQozcGi
 JM67uiM4VUggPbEkNTs1tSC1CCbLxMEp1cDYsLGCpcpnlu2tChntBbmRhVclBXl26suWLzB/
 ND9X6PO72zmHjH9GObzX/uhrYf75eo/4u1cv9d7wTNPNmsI3R4p5TU3zl0tVB3d4WCXk+LPV
 rsl5ZeCYequmwWvZ7/D6e98q5pd2Hp8RHrnf44acmHasEq9Mh+ThFc3rbqeaH+SS2iQ7L0WJ
 pTgj0VCLuag4EQAId2BNXwIAAA==
X-Mailman-Approved-At: Mon, 11 Mar 2024 14:06:01 +0100
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

Move the environment into the board directory and convert it from a C
header to a text file. Sort the variables alphabetically.
No functional changes.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 .../phytec/phycore_imx8mp/phycore_imx8mp.env  | 45 +++++++++++++++++++
 include/configs/phycore_imx8mp.h              | 43 ------------------
 2 files changed, 45 insertions(+), 43 deletions(-)
 create mode 100644 board/phytec/phycore_imx8mp/phycore_imx8mp.env

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
new file mode 100644
index 000000000000..6d15b7f3dc9f
--- /dev/null
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -0,0 +1,45 @@
+console=ttymxc0,115200
+dofastboot=0
+emmc_dev=2
+fastboot_raw_partition_all=0 4194304
+fastboot_raw_partition_bootloader=64 8128
+fdt_addr=0x48000000
+fdt_file=CONFIG_DEFAULT_FDT_FILE
+image=Image
+ip_dyn=yes
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}
+mmcargs=
+	setenv bootargs console=${console}
+	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
+mmcautodetect=yes
+mmcboot=
+	echo Booting from mmc ...;
+	run mmcargs;
+	if run loadfdt; then
+		booti ${loadaddr} - ${fdt_addr};
+	else
+		echo WARN: Cannot load the DT;
+	fi;
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=2
+netargs=
+	setenv bootargs console=${console} root=/dev/nfs ip=dhcp
+	nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=
+	echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if ${get_cmd} ${fdt_addr} ${fdt_file}; then
+		booti ${loadaddr} - ${fdt_addr};
+	else
+		echo WARN: Cannot load the DT;
+	fi;
+nfsroot=/nfs
+sd_dev=1
diff --git a/include/configs/phycore_imx8mp.h b/include/configs/phycore_imx8mp.h
index 11a17be7fe1d..206c4d50d276 100644
--- a/include/configs/phycore_imx8mp.h
+++ b/include/configs/phycore_imx8mp.h
@@ -13,49 +13,6 @@
 #define CFG_SYS_UBOOT_BASE \
 		(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
 
-#define CFG_EXTRA_ENV_SETTINGS \
-	"image=Image\0" \
-	"console=ttymxc0,115200\0" \
-	"fdt_addr=0x48000000\0" \
-	"fdt_file=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"ip_dyn=yes\0" \
-	"dofastboot=0\0" \
-	"fastboot_raw_partition_bootloader=64 8128\0" \
-	"fastboot_raw_partition_all=0 4194304\0" \
-	"emmc_dev=2\0" \
-	"sd_dev=1\0" \
-	"mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
-	"mmcpart=1\0" \
-	"mmcroot=2\0" \
-	"mmcautodetect=yes\0" \
-	"mmcargs=setenv bootargs console=${console} " \
-		"root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw\0" \
-	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
-	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}\0" \
-	"mmcboot=echo Booting from mmc ...; " \
-		"run mmcargs; " \
-		"if run loadfdt; then " \
-			"booti ${loadaddr} - ${fdt_addr}; " \
-		"else " \
-			"echo WARN: Cannot load the DT; " \
-		"fi;\0 " \
-	"nfsroot=/nfs\0" \
-	"netargs=setenv bootargs console=${console} root=/dev/nfs ip=dhcp " \
-		"nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
-	"netboot=echo Booting from net ...; " \
-		"run netargs; " \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"${get_cmd} ${loadaddr} ${image}; " \
-		"if ${get_cmd} ${fdt_addr} ${fdt_file}; then " \
-			"booti ${loadaddr} - ${fdt_addr}; " \
-		"else " \
-			"echo WARN: Cannot load the DT; " \
-		"fi;\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR	0x40000000
-- 
2.25.1

