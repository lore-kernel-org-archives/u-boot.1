Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41531C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:47:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36D48883E;
	Wed,  3 Jul 2024 15:46:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="JogWrTI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6E9887C7; Wed,  3 Jul 2024 07:42:34 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A912D88784
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985352; x=1722577352;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uhFKAB/3SxcBtLcnmQxJOxF36nYs4qUMO07YQDjTzBc=;
 b=JogWrTI1Mgs0EODCzb/JIoxKC8uXlS4XpFKYRL1+NKoqNXVXdav3aYIT3eaB5Us2
 0rYvkMZr1nw/aHRo+f7kqgb+Ql6HUgGzT8R7DrR2odRWohumWYZLvFQFCLgh0vzu
 lKGeUafcXtDfzh5wbP0aybUdAUHxi8sE0U9SR39KNHA=;
X-AuditID: ac14000a-03e52700000021bc-6a-6684e4c868e2
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 70.7D.08636.8C4E4866;
 Wed,  3 Jul 2024 07:42:32 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:29 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 2/9] phycore-imx8mp: Add overlay and bootenv.txt support
Date: Tue, 2 Jul 2024 22:41:55 -0700
Message-ID: <20240703054202.2812540-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWyRpKBR/fEk5Y0g/VfFSxa1npYPLzqb/Fp
 52NWixk3p7FZvDg2l93i25ZtjBZTJ21mt3i7t5PdovudugOnx/sbrewesxsusnjsnHWX3ePV
 gVXsHmfv7GD06O9uYfW4fmY7k8fxG9uZAjiiuGxSUnMyy1KL9O0SuDLufX/NXtArVfHuwxKW
 BsZXol2MnBwSAiYSnTdXM4PYQgJLmCSWXZbsYuQCsu8xSnQt+wSWYBPQkrizZS4zSEJEYB2j
 xNwrm5hAHGaBZYwS52YcYAOpEhbwkDjydTlQFQcHi4CKxNqWYpAwr4CVROeseywQ2+QlZl76
 zg5icwpYS0z+/RysXAioZuEfc4hyQYmTM5+AlTMDlTdvnc0MYUtIHHzxAupQBYnZ2yYzwoyc
 du41M4QdKrH1y3amCYxCs5CMmoVk1CwkoxYwMq9iFMrNTM5OLcrM1ivIqCxJTdZLSd3ECIoe
 EQauHYx9czwOMTJxMB5ilOBgVhLhlXrfnCbEm5JYWZValB9fVJqTWnyIUZqDRUmcd3VHcKqQ
 QHpiSWp2ampBahFMlomDU6qBcZZb/WsFz8ab2nolc4qcRBMFU5fP3v15Udos99IJKhNXcoU5
 X0jseXZMcDbDXa1fx04rssdEfsj9ZL804a52+/bFCQzSHX1/bPr1nQwFWU6u3J6cLbRGLKPt
 toxg/BwFQS6pGderItTTalZd/Xd7jmZPgoaqm1ukwYJnvyaWbeHUCF95kbFfiaU4I9FQi7mo
 OBEA/hI4MowCAAA=
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:46:48 +0200
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
---
 board/phytec/phycore_imx8mp/phycore_imx8mp.env | 15 +++++++++++++++
 configs/phycore-imx8mp_defconfig               |  6 +++---
 2 files changed, 18 insertions(+), 3 deletions(-)

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
index 7b16e8ef58e..e20a43e2674 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_SYS_I2C_MXC_I2C1=y
@@ -12,7 +13,7 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-phyboard-pollux-rdk"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_PHYCORE_IMX8MP=y
-CONFIG_PHYTEC_SOM_DETECTION=y
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -49,8 +50,6 @@ CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="u-boot=> "
-# CONFIG_CMD_EXPORTENV is not set
-# CONFIG_CMD_IMPORTENV is not set
 # CONFIG_CMD_CRC32 is not set
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
@@ -74,6 +73,7 @@ CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-- 
2.25.1

