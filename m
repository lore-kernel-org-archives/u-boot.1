Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2D8CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E0AA846DE;
	Thu, 21 May 2026 17:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="M8vsBgGe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B885805D7; Thu, 21 May 2026 15:54:20 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2C8844CF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LAIkaa1703731; Thu, 21 May 2026 09:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=Qgsx5
 L2zyl9lB8aeX0zWE86InR6fpAtG+FlK9YWE2H4=; b=M8vsBgGeqBqh59iZYjPYK
 nr8XEi/rqWLXtVGMZZkPq43gl9faKg0Nlf42xfgKjpYXdR2u2QQU4raSvKQELYoD
 y5qUuTfiKE+oYgXQ3aWeQav6Tk5IO2oux720ovLJzgbgZF8fTzS8al3Zh8w8x+4J
 bjI6zfSKZB57aJljGM6A1NjPhbhTpXvve3GM4TnF9uLeoawBoS6XqlXRyalcfWfZ
 1NzvM9hBzWOs1bTcgeXcF13wGR4Al4Go0DLt5a71sQ48zpOvrck2IqygWLES6GCK
 ZNkpWLi2b+IWLiS9Rw0oiC0aBaNWsUmX1x9fO1sE/wMGaFitaSocdsn5uUQhXHv9
 A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9701eb6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsDQE046888
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 09:54:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:12 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqd016286;
 Thu, 21 May 2026 09:54:07 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 01/16] configs: sc5xx: Do not store environment in SPI flash
Date: Thu, 21 May 2026 09:53:12 -0400
Message-ID: <a8afb082dc0e92206ac0ff1315806b9c864f19dc.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX73ndxRje728q
 XNWuxBlWrvNgXZzZncAl5+pFzH88r+OtbxPiYmhdUChgQrZTPMktdQV3k6WB3aJLMqv3uVt+4/X
 dN4P8Ehf3he+F98mgWd0XoXsaB7NsCfiCKQmn1/JlvquHdBAVUIDLdUKM9z9UiAyG7TapvlPNef
 MV4ChtFVevn32qDWTjesKgLa7XJovnT77h8YI0mRy4cwCJndI9HVh8ylLTlc6ET4nqvTllpZ6IE
 ArbDR94NoTU6yYvcUl0S16iOOtOY5QUErh6P1IHn7KvoOR0Ufx/PGAxAOvQpyW26SzIwg4VQvMN
 XzcYyt7frBDHJs/M2orXSs/gDjAwhOGcXeY2llftCUtNCytYlZxxg54/4rLIed/YSeguCX5Nl6W
 waPURLk273YYsjHgaRtY6eTr9zb0HMHkH6bqBfbAFiEwX0yZBrjuk2q49sXl3lkcsKnx/2eg1+y
 W2fVsg01ufdo5VaMWZA==
X-Authority-Analysis: v=2.4 cv=CsaPtH4D c=1 sm=1 tr=0 ts=6a0f0e86 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=-db91ziRfMT5zVQ44LsA:9
X-Proofpoint-ORIG-GUID: zn_kTZsukNoWDO5lJo5ZhQic2VfRItoR
X-Proofpoint-GUID: zn_kTZsukNoWDO5lJo5ZhQic2VfRItoR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
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

Remove config option enabling storage of the environment
in the SPI flash, to match shift of programming boot media
to Linux.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc573-ezkit_defconfig          | 4 ----
 configs/sc584-ezkit_defconfig          | 5 -----
 configs/sc589-ezkit_defconfig          | 5 -----
 configs/sc589-mini_defconfig           | 5 -----
 configs/sc594-som-ezkit-spl_defconfig  | 4 ----
 configs/sc594-som-ezlite-spl_defconfig | 4 ----
 configs/sc598-som-ezkit-spl_defconfig  | 4 ----
 configs/sc598-som-ezlite-spl_defconfig | 4 ----
 8 files changed, 35 deletions(-)

diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezkit_defconfig
index fc4ce13cc70..976d8e0306a 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezkit_defconfig
@@ -3,9 +3,6 @@ CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0xD0000
-CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
 CONFIG_SPL_SERIAL=y
@@ -52,7 +49,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc573-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc584-ezkit_defconfig b/configs/sc584-ezkit_defconfig
index a8c6b9f1224..27f55804199 100644
--- a/configs/sc584-ezkit_defconfig
+++ b/configs/sc584-ezkit_defconfig
@@ -3,9 +3,6 @@ CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0xD0000
-CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_SERIAL=y
@@ -57,8 +54,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc584-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc589-ezkit_defconfig b/configs/sc589-ezkit_defconfig
index 9cd204e40ab..180b6904d95 100644
--- a/configs/sc589-ezkit_defconfig
+++ b/configs/sc589-ezkit_defconfig
@@ -5,9 +5,6 @@ CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xC203F000
 CONFIG_SF_DEFAULT_SPEED=1000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0xD0000
-CONFIG_ENV_SECT_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_SERIAL=y
@@ -61,8 +58,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc589-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc589-mini_defconfig b/configs/sc589-mini_defconfig
index 0908ab1708b..92c2741f701 100644
--- a/configs/sc589-mini_defconfig
+++ b/configs/sc589-mini_defconfig
@@ -4,9 +4,6 @@ CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xC203F000
-CONFIG_ENV_SIZE=0x10000
-CONFIG_ENV_OFFSET=0xD0000
-CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x8000
 CONFIG_SPL_SERIAL=y
@@ -58,8 +55,6 @@ CONFIG_CMD_FS_GENERIC=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_SPI_MAX_HZ=10000000
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc589-mini"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc594-som-ezkit-spl_defconfig b/configs/sc594-som-ezkit-spl_defconfig
index c62097a2ac9..c379de2c146 100644
--- a/configs/sc594-som-ezkit-spl_defconfig
+++ b/configs/sc594-som-ezkit-spl_defconfig
@@ -4,9 +4,6 @@ CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x8203f000
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
@@ -40,7 +37,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc594-som-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc594-som-ezlite-spl_defconfig b/configs/sc594-som-ezlite-spl_defconfig
index 39481351102..54b26ed85c2 100644
--- a/configs/sc594-som-ezlite-spl_defconfig
+++ b/configs/sc594-som-ezlite-spl_defconfig
@@ -3,9 +3,6 @@ CONFIG_SYS_ARM_CACHE_WRITETHROUGH=y
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
@@ -45,7 +42,6 @@ CONFIG_CMD_FAT=y
 # CONFIG_DOS_PARTITION is not set
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc594-som-ezlite"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index bf001459831..98256517b87 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -4,9 +4,6 @@ CONFIG_COUNTER_FREQUENCY=31250000
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x180000
-CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
@@ -63,7 +60,6 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc598-som-ezkit"
 CONFIG_NET_RETRY_COUNT=20
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 09fda4f4ecc..1c4f9309daa 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -4,9 +4,6 @@ CONFIG_COUNTER_FREQUENCY=31250000
 CONFIG_ARCH_SC5XX=y
 CONFIG_SYS_MALLOC_LEN=0x100000
 CONFIG_SPL_GPIO=y
-CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x180000
-CONFIG_ENV_SECT_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x10000
@@ -62,7 +59,6 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="sc598-som-ezlite"
 CONFIG_NET_RETRY_COUNT=20
-- 
2.34.1

