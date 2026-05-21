Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB5ECD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 15:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83DB38482F;
	Thu, 21 May 2026 17:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=analog.com header.i=@analog.com header.b="ftmPdVYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33908846DF; Thu, 21 May 2026 15:54:50 +0200 (CEST)
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A320B846A7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 15:54:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Caleb.Ethridge@analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64L9AVtt1704036; Thu, 21 May 2026 09:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=wY8WZ
 uWT+N+c28+M/o+gmi5wEWgg52KsSC9dj4OJGcY=; b=ftmPdVYw5DmM1BP4a3MP0
 gz17AWZi5h4hEry7CCXnrxULUeCCRo36c3pLNrNqWvOKsdvBD6wNqUwxBdQzPNWB
 dpNG1OyH3Xjo1SwMneHgqpZqJPJTKy3ZgtJVhuCR0dxpKv9pRP/jZmf9x7l2Q4jO
 e2ZWaL64BXNO+Tw5UrO+InLc+2til35vNtrJPaefRth397npPrOzXZWkGw6e5L2P
 MdU+R2B5e5v/sWjB0JO6vXyksLT1tBomMpWKXlu4Eak+6jeZYAmTGxgx72HRtYFB
 zDn1e1Rccbsn0oegR73tFnUKR73MmQQpfgDzfZEI315G5yazCUxg4qWabXWKHD4Z
 A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e9701eb84-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 May 2026 09:54:42 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
 by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64LDsf6r046909
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL); 
 Thu, 21 May 2026 09:54:41 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:41 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 21 May 2026 09:54:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 21 May 2026 09:54:40 -0400
Received: from cethridg-sml01.ad.analog.com (cethridg-sml01.ad.analog.com
 [10.75.142.63])
 by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64LDrkqi016286;
 Thu, 21 May 2026 09:54:35 -0400
From: Caleb Ethridge <caleb.ethridge@analog.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <malysagreg@gmail.com>, <philip@philipmolloy.com>,
 <sjg@chromium.org>, <linux@analog.com>, <jcethrid@gmail.com>,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v6 06/16] mach-sc5xx: Add USB boot command
Date: Thu, 21 May 2026 09:53:17 -0400
Message-ID: <bc352a4612f57251c9a23db878ed5a24108bda1e.1779370141.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779370141.git.caleb.ethridge@analog.com>
References: <cover.1779370141.git.caleb.ethridge@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE0MCBTYWx0ZWRfXxnt6+BbjovyM
 9inl6JRp6nD7P3SHRzvMcAfcFOLmvP1EBbhvF8oWG/6S8EmC6zgYG6/a2IRFO3UpymnIUPy1BFO
 BWGnFra/0d24CJ++CKYOtV2z2sVr7CGy/tytxB8UM4o93jrhCFi31ls+bukv/8+ep/wCyuRFxBn
 PKHDOE0R1ovzf6SpEjqVz23vXDLWju7ah6U7+cmovOTuHK1w0ceiUkaH5NN0UBb0yDSKJNvD5qi
 HkvBOxMS2+XmJWOWmVT8hgmukXW+EwBwQpHUUV2hqiQ5erftfHc29ioXPNq929IZpbcT3R7XL+q
 JKYw67HqsLRWvJDaasGsSU68sIdISgMHOHY7wcnNXXdmyEWT0FsFtmeXJrsb68D0afAilk9CpBs
 dKvSjxKkw0b2qIC827cZQ/H6/dhIE0mT29Wd+zyVHIwh/ESFqSnP40Df9dkfKisiKWsgwuCQPdU
 h98HA3BDpT/LIGBXbzw==
X-Authority-Analysis: v=2.4 cv=CsaPtH4D c=1 sm=1 tr=0 ts=6a0f0ea2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=vv5AZiUBpKRcpChx8O8A:9
X-Proofpoint-ORIG-GUID: UIwbOydjP0mGfZ5Fr6CF3BZVwkA8sLRt
X-Proofpoint-GUID: UIwbOydjP0mGfZ5Fr6CF3BZVwkA8sLRt
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

Add the USB boot command to the environments
of the boards that support it.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezkit/sc573-ezkit.env           | 1 +
 board/adi/sc584-ezkit/sc584-ezkit.env           | 1 +
 board/adi/sc589-ezkit/sc589-ezkit.env           | 1 +
 board/adi/sc589-mini/sc589-mini.env             | 1 +
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 1 +
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 1 +
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 1 +
 include/env/adi/adi_boot.env                    | 8 ++++++++
 8 files changed, 15 insertions(+)

diff --git a/board/adi/sc573-ezkit/sc573-ezkit.env b/board/adi/sc573-ezkit/sc573-ezkit.env
index 61381edab26..e1ad4f3716f 100644
--- a/board/adi/sc573-ezkit/sc573-ezkit.env
+++ b/board/adi/sc573-ezkit/sc573-ezkit.env
@@ -10,5 +10,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_SPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index f676343a272..7e70f5e200a 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -9,5 +9,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_NFS
 #define USE_SPI
 #define USE_RAM
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index 8a1b9a6e92a..b8d9b1ef362 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -10,5 +10,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_MMC
 #define USE_SPI
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 39ee0c54da0..560efeeceeb 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -10,5 +10,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_RAM
 #define USE_SPI
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index 12980f71ba2..ef47640320d 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -11,5 +11,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index 12980f71ba2..ef47640320d 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -11,5 +11,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 12980f71ba2..ef47640320d 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -11,5 +11,6 @@ loadaddr=CONFIG_SC5XX_LOADADDR
 #define USE_OSPI
 #define USE_RAM
 #define USE_MMC
+#define USE_USB
 
 #include <env/adi/adi_boot.env>
diff --git a/include/env/adi/adi_boot.env b/include/env/adi/adi_boot.env
index be4d8521ac9..00757fe7c99 100644
--- a/include/env/adi/adi_boot.env
+++ b/include/env/adi/adi_boot.env
@@ -67,3 +67,11 @@ ramboot=wget ${loadaddr} ${serverip}:/fitImage;
 	run ramargs;
 	bootm ${loadaddr}
 #endif
+
+#if defined(USE_USB)
+usbargs=setenv bootargs root=/dev/sda2 rw rootfstype=ext4 rootwait ${adi_bootargs}
+usbboot=usb start;
+	run usbargs;
+	ext4load usb 0:1 ${loadaddr} /fitImage;
+	bootm ${loadaddr}
+#endif
-- 
2.34.1

