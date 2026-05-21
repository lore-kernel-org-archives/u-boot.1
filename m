Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBD9CD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:20:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0EF84843;
	Thu, 21 May 2026 17:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="hzALXp/R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0079784704; Thu, 21 May 2026 15:54:50 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2AF3846F1
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LB1n5u1703724; Thu, 21 May 2026 09:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=TG8r3
 MS0FtGykujYAIKtokefnd2DFNLdx6AF1U2PZbg=; b=hzALXp/RBoJg4qesS13wn
 UyoQlxRo6WldjJdreo3fogGI6DSyneoVKy3voQS/FJ+KgN9ZOnJI5aIyWeJaD/AU
 Mg1jg1zBM67UVkx8kv3xOvDdhbSNQb0J2EW7IKHFWKubXlj4t9i/ezpmf7yzCH6L
 3uV2RdDeA2Z6sTNmkggyHmuXwpTrSRNTQL6BhDnmQfVjLE82lUK2oaQcjznSu6A0
 aFY1l2jWPTsmE5tMha0BGKYiescxeCoy0Emes5PJhpLTmb4iMA+lzOjJ79u95ONi
 05xqrw3pNwN+8b9gjVWOldovZdNGeDioRSA5fyIVt5dhf1EWfcGy0+mNYSVlJvlY
 Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9701eb8c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:44 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDshDl046927
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:43 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:43 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:43 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkql016286;
 Thu, 21 May 2026 09:54:36 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 09/16] mach-sc5xx: sc573: Rename EZKIT board to EZLITE
Date: Thu, 21 May 2026 09:53:20 -0400
Message-ID: <ab62bcfcffe375ce2d6c4ff2684b0d6f3b8d45df.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX89O1LhPJApUo
 KuMJYPBscsTQ2Ao0Sr3OcS072haSAia1p84IeJX5h1lCHGBF0jnG2ms2AycPJTQXvZ/mnK/3Moe
 CUVQqzjmEvFsdFM2fZaSH06D5qdeG5d17MTMWuJB+RneVpmbpliywdRyVlgg49uniCzXjIu23HZ
 vu7IiVx/TMJLRJIKm2f+MbvhmVZX0rTvNPxrOYjmMss0FocNXjBnmCIdQauGC47evWsCKKL+VGa
 cZHc6kFOu21y2w/rGlksb6qZnL5A4uvgPGq1y84R6dkLq1UPcl3LTaW9tEUkfjhg08Mfzq768+L
 j3x2vBl6V0igk+fPtFgUgdigEntkpyLrE0eXOmCFhWstAm5imAM7esjXR+ra2Wv7Ja8D0pbq9AE
 fvMbzPjioec5z1zUo1FnJV3OO4qkAYoBoX3c0aR1x99TVhlNegmIbvIc2lCct0eOjxrqapBvwBY
 nWVeAICB8waG2Ho7exw==
X-Authority-Analysis: v=2.4 cv=CsaPtH4D c=1 sm=1 tr=0 ts=6a0f0ea4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=QrZw4ZbjVa1RRxhk54oA:9
X-Proofpoint-ORIG-GUID: YrEjGvil_udo6dC1qv50I68H6nhxYHcs
X-Proofpoint-GUID: YrEjGvil_udo6dC1qv50I68H6nhxYHcs
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

Rename the SC573 EZKIT board to EZLITE across the device tree,
defconfig, board file, and related Kconfig/Makefile entries to
match with release naming. EZKIT was used internally before the
official product release.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/Makefile                                     | 2 +-
 arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts}        | 4 ++--
 arch/arm/mach-sc5xx/Kconfig                               | 8 ++++----
 arch/arm/mach-sc5xx/init/dmcinit.c                        | 2 +-
 board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig           | 8 ++++----
 board/adi/{sc573-ezkit => sc573-ezlite}/Makefile          | 2 +-
 .../sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c}         | 0
 .../sc573-ezkit.env => sc573-ezlite/sc573-ezlite.env}     | 0
 configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} | 2 +-
 doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml           | 2 +-
 include/configs/{sc573-ezkit.h => sc573-ezlite.h}         | 4 ++--
 11 files changed, 17 insertions(+), 17 deletions(-)
 rename arch/arm/dts/{sc573-ezkit.dts => sc573-ezlite.dts} (98%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Kconfig (92%)
 rename board/adi/{sc573-ezkit => sc573-ezlite}/Makefile (79%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.c => sc573-ezlite/sc573-ezlite.c} (100%)
 rename board/adi/{sc573-ezkit/sc573-ezkit.env => sc573-ezlite/sc573-ezlite.env} (100%)
 rename configs/{sc573-ezkit_defconfig => sc573-ezlite_defconfig} (98%)
 rename include/configs/{sc573-ezkit.h => sc573-ezlite.h} (79%)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d5dd0867622..1e8676284b7 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1178,7 +1178,7 @@ dtb-$(CONFIG_TARGET_IMX8MM_CL_IOT_GATE_OPTEE) += imx8mm-cl-iot-gate-optee.dtb \
 					imx8mm-cl-iot-gate-ied-tpm0.dtbo \
 					imx8mm-cl-iot-gate-ied-tpm1.dtbo
 
-dtb-$(CONFIG_TARGET_SC573_EZKIT) += sc573-ezkit.dtb
+dtb-$(CONFIG_TARGET_SC573_EZLITE) += sc573-ezlite.dtb
 dtb-$(CONFIG_TARGET_SC584_EZKIT) += sc584-ezkit.dtb
 dtb-$(CONFIG_TARGET_SC589_MINI) += sc589-mini.dtb
 dtb-$(CONFIG_TARGET_SC589_EZKIT) += sc589-ezkit.dtb
diff --git a/arch/arm/dts/sc573-ezkit.dts b/arch/arm/dts/sc573-ezlite.dts
similarity index 98%
rename from arch/arm/dts/sc573-ezkit.dts
rename to arch/arm/dts/sc573-ezlite.dts
index 4a3d1ed5c56..57604d707f7 100644
--- a/arch/arm/dts/sc573-ezkit.dts
+++ b/arch/arm/dts/sc573-ezlite.dts
@@ -9,8 +9,8 @@
 #include "sc57x.dtsi"
 
 / {
-	model = "ADI SC573-EZKIT";
-	compatible = "adi,sc573-ezkit", "adi,sc57x";
+	model = "ADI SC573-EZLITE";
+	compatible = "adi,sc573-ezlite", "adi,sc57x";
 };
 
 &i2c0 {
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index 70fab57fb3c..e311a8adf9a 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -25,7 +25,7 @@ config SC57X
 	bool "SC57x series"
 	select COMMON_CLK_ADI_SC57X
 	select CPU_V7A
-	select TARGET_SC573_EZKIT
+	select TARGET_SC573_EZLITE
 
 config SC58X
 	bool "SC58x series"
@@ -51,8 +51,8 @@ endchoice
 
 if SC57X
 
-config TARGET_SC573_EZKIT
-	bool "Support SC573-EZKIT"
+config TARGET_SC573_EZLITE
+	bool "Support SC573-EZLITE"
 
 endif
 
@@ -600,6 +600,6 @@ source "board/adi/sc594-som-ezlite/Kconfig"
 source "board/adi/sc589-ezkit/Kconfig"
 source "board/adi/sc589-mini/Kconfig"
 source "board/adi/sc584-ezkit/Kconfig"
-source "board/adi/sc573-ezkit/Kconfig"
+source "board/adi/sc573-ezlite/Kconfig"
 
 endif
diff --git a/arch/arm/mach-sc5xx/init/dmcinit.c b/arch/arm/mach-sc5xx/init/dmcinit.c
index 12052613feb..2026735cc21 100644
--- a/arch/arm/mach-sc5xx/init/dmcinit.c
+++ b/arch/arm/mach-sc5xx/init/dmcinit.c
@@ -101,7 +101,7 @@
 
 #ifdef CONFIG_TARGET_SC584_EZKIT
 	#define DMC_PADCTL2_VALUE	0x0078283C
-#elif CONFIG_TARGET_SC573_EZKIT
+#elif CONFIG_TARGET_SC573_EZLITE
 	#define DMC_PADCTL2_VALUE	0x00782828
 #elif CONFIG_TARGET_SC589_MINI || CONFIG_TARGET_SC589_EZKIT
 	#define DMC_PADCTL2_VALUE	0x00783C3C
diff --git a/board/adi/sc573-ezkit/Kconfig b/board/adi/sc573-ezlite/Kconfig
similarity index 92%
rename from board/adi/sc573-ezkit/Kconfig
rename to board/adi/sc573-ezlite/Kconfig
index 328563c1296..f3b848ef0f7 100644
--- a/board/adi/sc573-ezkit/Kconfig
+++ b/board/adi/sc573-ezlite/Kconfig
@@ -2,19 +2,19 @@
 #
 # (C) Copyright 2024 - Analog Devices, Inc.
 
-if TARGET_SC573_EZKIT
+if TARGET_SC573_EZLITE
 
 config SYS_BOARD
-	default "sc573-ezkit"
+	default "sc573-ezlite"
 
 config SYS_CONFIG_NAME
-	default "sc573-ezkit"
+	default "sc573-ezlite"
 
 config LDR_CPU
 	default "ADSP-SC573-0.0"
 
 config DEFAULT_DEVICE_TREE
-	default "sc573-ezkit"
+	default "sc573-ezlite"
 
 config ADI_IMAGE
 	default "tiny"
diff --git a/board/adi/sc573-ezkit/Makefile b/board/adi/sc573-ezlite/Makefile
similarity index 79%
rename from board/adi/sc573-ezkit/Makefile
rename to board/adi/sc573-ezlite/Makefile
index 0ea725b992b..77c55af6240 100644
--- a/board/adi/sc573-ezkit/Makefile
+++ b/board/adi/sc573-ezlite/Makefile
@@ -3,4 +3,4 @@
 # (C) Copyright 2025 - Analog Devices, Inc.
 #
 
-obj-y	+= sc573-ezkit.o
+obj-y	+= sc573-ezlite.o
diff --git a/board/adi/sc573-ezkit/sc573-ezkit.c b/board/adi/sc573-ezlite/sc573-ezlite.c
similarity index 100%
rename from board/adi/sc573-ezkit/sc573-ezkit.c
rename to board/adi/sc573-ezlite/sc573-ezlite.c
diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezlite/sc573-ezlite.env
similarity index 100%
rename from board/adi/sc573-ezkit/sc573-ezkit.env
rename to board/adi/sc573-ezlite/sc573-ezlite.env
diff --git a/configs/sc573-ezkit_defconfig b/configs/sc573-ezlite_defconfig
similarity index 98%
rename from configs/sc573-ezkit_defconfig
rename to configs/sc573-ezlite_defconfig
index 4320c73fd39..f6305451c27 100644
--- a/configs/sc573-ezkit_defconfig
+++ b/configs/sc573-ezlite_defconfig
@@ -47,7 +47,7 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_EMBED=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_USE_HOSTNAME=y
-CONFIG_HOSTNAME="sc573-ezkit"
+CONFIG_HOSTNAME="sc573-ezlite"
 CONFIG_NET_RETRY_COUNT=20
 CONFIG_IP_DEFRAG=y
 CONFIG_SPL_CLK=y
diff --git a/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml b/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
index df976c7ae73..ae3b5e6092a 100644
--- a/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
+++ b/doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
@@ -18,7 +18,7 @@ properties:
     oneOf:
       - description: SC57X Series Boards
         items:
-          - const: adi,sc573-ezkit
+          - const: adi,sc573-ezlite
           - const: adi,sc57x
 
       - description: SC58X Series Boards
diff --git a/include/configs/sc573-ezkit.h b/include/configs/sc573-ezlite.h
similarity index 79%
rename from include/configs/sc573-ezkit.h
rename to include/configs/sc573-ezlite.h
index 42e42f8150b..590a8f06fb5 100644
--- a/include/configs/sc573-ezkit.h
+++ b/include/configs/sc573-ezlite.h
@@ -3,8 +3,8 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-#ifndef __CONFIG_SC573_EZKIT_H
-#define __CONFIG_SC573_EZKIT_H
+#ifndef __CONFIG_SC573_EZLITE_H
+#define __CONFIG_SC573_EZLITE_H
 
 /*
  * Memory Settings
-- 
2.34.1

