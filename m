Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A90CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BFB7846FA;
	Thu, 21 May 2026 17:19:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="jVvsklIg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 055CD846EB; Thu, 21 May 2026 15:54:47 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A44838341A
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LDmLAj416902; Thu, 21 May 2026 09:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=r/qsR
 HrgWzq/ZLTa4cVn7mByevdHfSiKwg13ufacnbE=; b=jVvsklIg7dVxCjNxWwamc
 KD9F9XCkG7A8O6Sni4XfFzgkPwRxTZRUEk0w/ZVobs8Hm1jLIxk2eDMgrq2FQAeH
 wJx00cC7fIxE8H51kQG/AgyLkVisjhZsiU9KO68cwLEMWzQmdeFIgQXdAyPFP80s
 BTbPkloTvF8PDm1pwCzWjaF5/1JS9N7DOQCzXlBtNRH5CFB/WpnkBEaYP33mQo8U
 aSK9uzDXP6pfcs/fSWj8Rupwji7SSMN36H+1Rjxze47InwrNum1Jm265Hr/CQlV6
 eW7HjPIbzhjXgCs0eP8wxRnLAh1SW0j9OZhfG1Ab40coXwWA9Ntrn1vQgYfI9zbW
 g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9e6wvkpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsd9d046903
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:39 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:39 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:39 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqg016286;
 Thu, 21 May 2026 09:54:35 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 04/16] mach-sc5xx: Update boot commands
Date: Thu, 21 May 2026 09:53:15 -0400
Message-ID: <d3b98dcbd83ceb85703eae6bfd11e75aa12d67e8.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: GQFUutQ2AUoyS2y7gbrNBPTlpQKRNvqj
X-Proofpoint-ORIG-GUID: GQFUutQ2AUoyS2y7gbrNBPTlpQKRNvqj
X-Authority-Analysis: v=2.4 cv=K8gS2SWI c=1 sm=1 tr=0 ts=6a0f0ea1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=bHaOnd0h0ngxQsdsuAEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfXwqUEbkFw8+Dp
 5D6DFygOGA34lk8nWZnfsQtvjcszTWP0awmGfy6zThTtlleDk7rXOgkMjAnlAUq6QDZIr2JYZgQ
 zzUZ2qCx5A6vJfzNro+d2msP8tOYrjYrqFYq3y+sZogWC+0pXoy9SxJrjYmRcN/e7FTLtGV9cb6
 fdWYM+d32Xak5Me6uFvZH7fh7flMGGsIG3trtpwNY7cabYv3olFFTsiBKnJXnsBItj0CduGgqaK
 Uc1k8SMQ8mXdYxyw01p2twPuIlGiXOzstk04kIJ8RO9SbQKuFeBnyMF/hqV6i4jILqR4nwnGISK
 FGkdwSt65vLQcozUsRRiovG/RfFncRTI7u0j1y1AyKIywOlaROOXWfntcmrdWegMY8IuYoWo+fA
 4pUDal14BxpsiTovYNl1tCdZCZZrNbEw2JPDcag4HKExzBkGF1P8pHqslbo7PNXYFrVJIFpdnYx
 mMYW75oCa92dM3N9Kcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210140
X-Mailman-Approved-At: Thu, 21 May 2026 17:19:00 +0200
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

Update the default boot commands to match the expected
bootargs in Linux and new SPI partitioning scheme.

Because the environment is no longer stored in the SPI
flash, imagesize has been removed and replaced with a fixed
length read to load from the SPI. Additionally the partitions
of the mmc have been updated. The first partition holds the fitImage
at /fitImage, and the second partition contains the rootfs.
With this change, the imagefile environment variable has also been
eliminated, the image in the first partition is expected to always
be named fitImage.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezkit/sc573-ezkit.env           |  2 +-
 board/adi/sc584-ezkit/sc584-ezkit.env           |  2 +-
 board/adi/sc589-ezkit/sc589-ezkit.env           |  2 +-
 board/adi/sc589-mini/sc589-mini.env             |  2 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   |  2 +-
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env |  2 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   |  2 +-
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env |  2 +-
 configs/sc573-ezkit_defconfig                   |  1 -
 configs/sc584-ezkit_defconfig                   |  1 -
 configs/sc589-ezkit_defconfig                   |  1 -
 configs/sc589-mini_defconfig                    |  1 -
 include/env/adi/adi_boot.env                    | 16 ++++++++++------
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index 83cbe808efa..61381edab26 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 2640d97bab2..f676343a272 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index a098f0b9c2c..8a1b9a6e92a 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index bed2ddc944d..39ee0c54da0 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0xe0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index f629f7f2cff..12980f71ba2 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0x110000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index f629f7f2cff..12980f71ba2 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0x110000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index f629f7f2cff..12980f71ba2 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0x110000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index 7b13d6fc32b..d5364df1613 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,7 +3,7 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=CONFIG_SC5XX_FITIMAGE_OFFSET
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #include <env/adi/adi_boot.env>
diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index 7a0c7d04e84..4320c73fd39 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -6,7 +6,6 @@ CONFIG_SPL_GPIO=y
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_SERIAL=y
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0x83000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_CGU0_CLKOUTSEL=7
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index 7975a610ca3..52ab7c9337b 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -10,7 +10,6 @@ CONFIG_SPL_STACK=0x200C0000
 CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0x89300000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_BUG_EZKHW21=y
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 0ceb57f1f42..a249fe8df7b 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -13,7 +13,6 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_EZKIT=y
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 32678b63a9f..25285695367 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -12,7 +12,6 @@ CONFIG_SPL_BSS_START_ADDR=0x200A0000
 CONFIG_SPL_BSS_MAX_SIZE=0x8000
 CONFIG_SC58X=y
 CONFIG_TARGET_SC589_MINI=y
-CONFIG_SC5XX_FITIMAGE_OFFSET=0xE0000
 CONFIG_SC5XX_LOADADDR=0xC3000000
 CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
 CONFIG_ADI_USE_DMC1=y
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index 42f33ed83af..b4b725247f7 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -39,23 +39,27 @@ nfsboot=run init_ethernet;
 #endif
 
 #if defined(USE_MMC)
-mmcargs=setenv bootargs root=/dev/mmcblk0p1 rw rootfstype=ext4 rootwait ${adi_bootargs}
+mmcargs=setenv bootargs root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait ${adi_bootargs}
 mmcboot=mmc rescan;
-	ext4load mmc 0:1 ${loadaddr} /boot/${imagefile};
+	ext4load mmc 0:1 ${loadaddr} /fitImage;
 	run mmcargs;
 	bootm ${loadaddr}
 #endif
 
-#if defined(USE_SPI) || defined(USE_OSPI)
-spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}
+#if defined(USE_SPI)
+spiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_SPI_BUS:CONFIG_SC_BOOT_SPI_SSEL
 spiboot=run spiargs;
 	sf probe ${sfdev};
-	sf read ${loadaddr} ${adi_image_offset} ${imagesize};
+	sf read ${loadaddr} ${adi_image_offset} 0xf00000;
 	bootm ${loadaddr}
 #endif
 
 #if defined(USE_OSPI)
-ospiboot=run spiboot
+ospiargs=setenv bootargs root=/dev/mtdblock4 rw rootfstype=jffs2 ${adi_bootargs}; setenv sfdev CONFIG_SC_BOOT_OSPI_BUS:CONFIG_SC_BOOT_OSPI_SSEL
+ospiboot=run ospiargs;
+	sf probe ${sfdev};
+	sf read ${loadaddr} ${adi_image_offset} 0xf00000;
+	bootm ${loadaddr}
 #endif
 
 #if defined(USE_RAM)
-- 
2.34.1

