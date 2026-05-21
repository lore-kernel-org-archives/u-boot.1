Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A9FCD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1293384705;
	Thu, 21 May 2026 17:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="keECYfim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3809844CF; Thu, 21 May 2026 15:54:52 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F290C846E2
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LAZGp51703748; Thu, 21 May 2026 09:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=CTdwn
 XLshRbe+lnEIqvjl9x20Dp7FAVkbdEltMVY7o0=; b=keECYfimZu+7g146WcpQZ
 OkDXk5kN/ZVLKH71r42SkN6VNy/+z9hHkXus6j1w2VI6RS6E0LEBiaFJMxqiMqa/
 82nwFQAxYIF126yWUu3FCQdHxZlTSQVSxVuo6LgxTJFYwBiC6TDDWPERz7QzWwf4
 n4v2iyZavyUFfoSyAVn62I3FqwLEX0dqIybWMBvmXufoV3CPU2V4yK4kQYlYyK4j
 7KHmyP9yhWbVv+44hw20smO3lDprVsVOdTuKErfkG3r1b0G4YZOTZrpMKZVLel1F
 Tt7RhjBLY43UoV1F1LB3fayKQeWVtKB+mmp6hJoPp4Xelqmr+Os5n94A77MRRb1V
 Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9701eb8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:46 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsjFB046936
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 21 May
 2026 09:54:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:45 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqr016286;
 Thu, 21 May 2026 09:54:38 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 15/16] arm: sc5xx: Add fdt_addr_r, kernel_addr_r,
 and ramdisk_addr_r
Date: Thu, 21 May 2026 09:53:26 -0400
Message-ID: <5bebcaba232121eaf5a230e3942e68d7a949f1e3.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfX+mmGtjjI4a/G
 yzKAgzBzgihNBn3JW37GsVusqDOo1sYehmZPcoAYpip0dAPtB8Z9Hiir3c7DzOnSnP5fV2UIokd
 orqgzGVJVenlUDiXryKbEh/Qomn2N2JB1XIW+d0cu5x2/iGrZwICEulBQXY3UKoSaSTKUkCvTlS
 +7ELfL/qUUcyJMdtMsA63XbgU2lsVDxphXgGcdpmko5BO8aZ/b/TsRTbRaRhOcVLLu5Exe9ZI0d
 WXXQrv+I5qX0c+bViL+CgLHxOOa2gC9VYtLevfPDDZVe6IS5QFaWDR230t2tCAJv/2HrMgXwPAk
 gwWBf8gEof4i023Xe7jUpHuPNTUQCqwjbvrZt3Xtt89mf9CsXvxu6lNtueIxUMVIpaxmkBT4Jem
 vWl3nlGCwc9qyqVDKvnAdAgJ33wJ42+7wz8uUyhsASdGSzqJWtjugtjZrK/6pVW9DaYPZS1HFbd
 LDzZo7KW1RajvXsmVkQ==
X-Authority-Analysis: v=2.4 cv=CsaPtH4D c=1 sm=1 tr=0 ts=6a0f0ea6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=7RIsglaIw3vzAkDy98gA:9
X-Proofpoint-ORIG-GUID: mMARxVtLb3X4KOzBCY2PRNQwDeIbiNHX
X-Proofpoint-GUID: mMARxVtLb3X4KOzBCY2PRNQwDeIbiNHX
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

Add fdt_addr_r, kernel_addr_r, and ramdisk_addr_r to the SC5xx boards.
These variables are currently unused in the environment but will be
used in the future once support for booti commands is added to the
SC5xx boards.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezlite/sc573-ezlite.env         | 5 +++--
 board/adi/sc584-ezkit/sc584-ezkit.env           | 4 ++++
 board/adi/sc589-ezkit/sc589-ezkit.env           | 4 ++++
 board/adi/sc589-mini/sc589-mini.env             | 4 ++++
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 4 ++++
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 4 ++++
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 4 ++++
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 4 ++++
 8 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
index c909b3b476a..bc1fdf293c2 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -3,8 +3,9 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
-adi_image_offset=0xd0000
-loadaddr=CONFIG_SC5XX_LOADADDR
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x84008000
+ramdisk_addr_r=0x85000000
 
 #define USE_NFS
 #define USE_SPI
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 0b8035ca6b1..ed25fc599a1 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x8a308000
+ramdisk_addr_r=0x8b300000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 00f90c7942e..3a1af951260 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xc4008000
+ramdisk_addr_r=0xc5000000
+
 #define USE_NFS
 #define USE_RAM
 #define USE_MMC
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 13079ed7527..a21bb4e2200 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xc4008000
+ramdisk_addr_r=0xc5000000
+
 #define USE_NFS
 #define USE_RAM
 #define USE_SPI
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 324bfae4571..a8f6def9f58 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xa3008000
+ramdisk_addr_r=0xa8000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index 324bfae4571..a8f6def9f58 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0xa3008000
+ramdisk_addr_r=0xa8000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 324bfae4571..da1ff295b0e 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x9a200000
+ramdisk_addr_r=0x9c000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_OSPI
diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index ab1acabef53..3f65fdabe18 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,6 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+fdt_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_addr_r=0x9a200000
+ramdisk_addr_r=0x9c000000
+
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
-- 
2.34.1

