Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD0DC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 629CE88A1A;
	Wed, 17 Jul 2024 07:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LqElZ6KA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A0D88A26; Wed, 17 Jul 2024 07:11:58 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54CB9885B5
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721193116; x=1723785116;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ONIHYt9ldwToTGWiOZOUAKIPJcitM1msoNdgYKMq2TE=;
 b=LqElZ6KA7auplEMXmelI9VjFK0Y5KvIeZYRMES14XGWRCrC1tXkZtxjdw8MGG2iR
 TDn3hSySH8Db/MQHJuZIFbwxAAbd+t3dokWY6Bb1TYq/78KXmA1OjcKqogcTP4ly
 6gJ7Z+44w63mmTQqhbDRRrppQpCRrmFLInLs6TCKgAo=;
X-AuditID: ac14000a-03e52700000021bc-e5-6697529c5eb5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 4E.7B.08636.C9257966;
 Wed, 17 Jul 2024 07:11:56 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jul
 2024 07:11:54 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <t.remmet@phytec.de>, <d-gole@ti.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 2/9] phycore-imx8mp: Add overlay and bootenv.txt support
Date: Tue, 16 Jul 2024 22:11:27 -0700
Message-ID: <20240717051134.1538180-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717051134.1538180-1-d.schultz@phytec.de>
References: <20240717051134.1538180-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWyRpKBR3dO0PQ0g4cNfBYtaz0spk7azG7x
 dm8nu0X3O3UHFo9XB1axe5y9s4PRo7+7hdXj+I3tTAEsUVw2Kak5mWWpRfp2CVwZj7aaFlyU
 qFh75z5bA+MBkS5GTg4JAROJWR+us3QxcnEICSxhknhz+S4zSEJI4D6jxMdbHCA2m4CWxJ0t
 c8HiIgI+EkdbN4M1MAt0Mkqs37eACSQhLOAtcfffMzCbRUBV4s6/BvYuRg4OXgEriSMNGhDL
 5CVmXvrODmJzClhLLL54G6xECKjk8INAkDCvgKDEyZlPWEBsZqDy5q2zmSFsCYmDL15AnaYg
 MXvbZEaYkdPOvWaGsEMltn7ZzjSBUWgWklGzkIyahWTUAkbmVYxCuZnJ2alFmdl6BRmVJanJ
 eimpmxhBAS7CwLWDsW+OxyFGJg7GQ4wSHMxKIrwTGKelCfGmJFZWpRblxxeV5qQWH2KU5mBR
 Eudd3RGcKiSQnliSmp2aWpBaBJNl4uCUamDsZT4hesXc8J0iQ9KTHyWy534++++bsvNT2feJ
 P2Rni9v81FQ33DrlcnxKTuPXwFvZl3rW9MpMCl/pYK5iP7/Qer0dW2uv0D7xqJRyq7xQpSsi
 072/mXzy9FDZpxS0febdwDouW74zx3ZmNfbsvVKm7VcrtbNh8dYescPqlxgvd0SYtW0QtlRi
 Kc5INNRiLipOBAAiNSA9XgIAAA==
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

From: Benjamin Hahn <B.Hahn@phytec.de>

Add support for loading bootenv.txt as well as loading and applying
overlays during boot from mmc and net.

${no_bootenv}: Prevent loading external bootenv.txt environment. Use
	       ${overlays} variable directly from u-boot environment.
${no_overlay}: Do not load overlays defined in ${overlays} variable.
	       Overlays loaded over the extension command are still
	       being applied.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 15 +++++++++++++++
 configs/phycore-imx8mp_defconfig               |  4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/phycore_imx8mp.env b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
index 7f6c5fd2c76..4ed5dc7e272 100644
--- a/board/phytec/phycore_imx8mp/phycore_imx8mp.env
+++ b/board/phytec/phycore_imx8mp/phycore_imx8mp.env
@@ -1,4 +1,5 @@
 #include <env/phytec/rauc.env>
+#include <env/phytec/overlays.env>
 
 bootcmd=
 	if test ${dofastboot} = 1; then
@@ -16,6 +17,8 @@ bootcmd=
 		fi;
 	fi;
 console=ttymxc0,115200
+bootenv_addr=0x49100000
+fdto_addr=0x49000000
 dofastboot=0
 emmc_dev=2
 fastboot_raw_partition_all=0 4194304
@@ -32,8 +35,14 @@ mmcargs=
 mmcautodetect=yes
 mmcboot=
 	echo Booting from mmc ...;
+	if test ${no_bootenv} = 0; then
+		if run mmc_load_bootenv; then
+			env import -t ${bootenv_addr} ${filesize};
+		fi;
+	fi;
 	run mmcargs;
 	if run loadfdt; then
+		run mmc_apply_overlays;
 		booti ${loadaddr} - ${fdt_addr};
 	else
 		echo WARN: Cannot load the DT;
@@ -51,9 +60,15 @@ netboot=
 	else
 		setenv get_cmd tftp;
 	fi;
+	if test ${no_bootenv} = 0; then
+		if run net_load_bootenv; then
+			env import -t ${bootenv_addr} ${filesize};
+		fi;
+	fi;
 	${get_cmd} ${loadaddr} ${image};
 	run netargs;
 	if ${get_cmd} ${fdt_addr} ${fdt_file}; then
+		run net_apply_overlays;
 		booti ${loadaddr} - ${fdt_addr};
 	else
 		echo WARN: Cannot load the DT;
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 8dd4963bdc0..da7fe612ca0 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -13,6 +13,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-phyboard-pollux-rdk"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_PHYCORE_IMX8MP=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -51,8 +52,6 @@ CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="u-boot=> "
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
@@ -76,6 +75,7 @@ CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-- 
2.25.1

