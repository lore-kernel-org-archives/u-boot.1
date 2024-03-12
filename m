Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6694C54E66
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:00:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE3487F10;
	Tue, 12 Mar 2024 10:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VE+TqUjg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8373F87D0B; Tue, 12 Mar 2024 10:00:10 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564E087DB0
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710234007; x=1712826007;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UmKdmJBh4A3rUsr19fcU2wlcyCEHx1q6KTM90YonRwU=;
 b=VE+TqUjgxXvjFV0yf5221Drck/Fi9Fkf3eagksu4g3Y+wOFdm2909qoVBim5aHEF
 a8P8u9lBIoJ6kAH4lqaRlYQklav+k6sZ4UhVXdGsnVmLQBdikQWGrY7xQfiwebaF
 p2/87M2aX2oDtoycp5O3uyWGTY+6hgnLWD1tTOMrCDQ=;
X-AuditID: ac14000a-fbefe7000000290d-fa-65f019977004
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C3.97.10509.79910F56;
 Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 10:00:06 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 1/5] phycore_imx8mp: Move environment from include/config
 to board
Date: Tue, 12 Mar 2024 09:59:53 +0100
Message-ID: <20240312085957.902398-2-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312085957.902398-1-l.anderweit@phytec.de>
References: <20240312085957.902398-1-l.anderweit@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWyRpKBR3e65IdUgzPrWCweXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlLO3+zlRw
 Srbi5Kd2xgbG6xJdjJwcEgImEtdefmDpYuTiEBJYzCTx4/g9KOcxo0THz5tsIFVsAvoSK18u
 YgGxRQRcJH4t3QNkc3AwC5hJTPicDBIWFgiV2Lr0HCuIzSKgKnFy00QmEJtXwFri8rWJjBDL
 5CVmXvrODtLKKWAjsXqiI4gpBFRy9EYURLWgxMmZT8AWMQNVN2+dzQxhS0gcfPECzBYSUJK4
 c+oXG8zEaedeM0PYoRJHNq1mmsAoNAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2CjMqS1GS9
 lNRNjKAAF2Hg2sHYN8fjECMTB+MhRgkOZiUR3tc6b1OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ
 867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MBa7/26uCl73Jce20PhkD/+OGYKvF/7l7XW8cXPO
 GXbnjN5ej3Mqpq1LWq+srQhTl1hlfuvuziJz1q1F0cYyb/zTn8y7sE1mQvGVrXdnVj2+xMUs
 /eP405Zw1TX5zUfL1ov1XdzDK5BTPPvLMZ0Zzu3vOAIkrPPPfrTb+nl1wwOpxDkr1mf/26DE
 UpyRaKjFXFScCACcyjlQXgIAAA==
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

