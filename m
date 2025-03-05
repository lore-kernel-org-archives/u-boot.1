Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8B0C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 05:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1120A81426;
	Wed,  5 Mar 2025 05:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="THpXzoAP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AEEE8141E; Wed,  5 Mar 2025 05:58:58 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B5C807B1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0MlVNnUw3IOK2BV55kSzHuvOy4zBZZ/QwENpxlYYth4ESvJxVtQ6685kEc2Cb1WHBtrFgQQdeD/e5AJH2Fj/+7dEXa9WRa7WwHLPXh7xmy9Rtxzx78kNon0TtaZsenK8eA1+eehxCi8ZmsdGNCCYvvqcRPEdadYdS+ohdj74y3EVXY3w3mThmKHOqyXRf2rdN/3hNzUbDxSodsfcWCEAOVmpnWRBzC8lZw3Ja7hBMC3VbhQySZz7iKsJX3tAEExsmZ4zl1hAOkxjCIkXr0CvMeezeqM857vs8gSgmmixfSAzkiaKj55Qx3Mjy9Sm4QQZPXi1AWkm3vanlccfOEavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DvQ48NqSr540NL4BYC8KWAow5vEtE8iPAKXFvFWIxo=;
 b=IvcU8iaE/Dh98BY7rUy3KSNUsxI9xz5cKYNrHafmjPxA6ppJ6RA76Iebc5Vw/iz9WKehrnuZHUEzum91mjNDl7RU85ncedfMU41EV7Yl4xD5q29jhALDcC8bfuERcgRxtkD6A4muI/SsdQEqrC1RYVJWj5Eevca+6sj2NCMfldGCmDAfSzdo8Ccf2Crd0sTBYMrBJHdrMDz/M1ds4c2L+JoS7eHT9TEiTah1uQKg0t6stdT2d6B8IZoh/w2IHEwJWL+FV7Ib93fEQfNrsbvE0CEs0dpYzULzGaLAS0NLYpRZEyrOBm2x7l5N8qK9QJa/3ckYaDlu8WlKuOP2lO7W2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DvQ48NqSr540NL4BYC8KWAow5vEtE8iPAKXFvFWIxo=;
 b=THpXzoAPaa4ZESbq+2iPY3u3XpUpQQBOG9Y/moewIR2KrC9G9rux8K33d1fnHXTSECG9yQzgQlCYfddlzfUegBk1cH+yGwatn0sBw7SSrXMWLrBQHnS2V4lI2yBd3kAvCw4uzztSylemtTax8u+vioi4ZJvwaOyAvf3gRGPKK49mI6w6ByZa/F/V4WeLXk+CXBqhV0H2Ge8Md/ub0htkZf18+IcLHN6FSSahcc73tmF3eN5EMOeJLgLyek8V/zPzxP5OPcYqIMMtl7dd6YZzeYRy/hfFi6FgkK+QerbA/7dF3nbmCVn5qCe32JSr5FtZsfpIVj7BNtWNsRh/HrUNjw==
Received: from CWLP265CA0273.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::21)
 by PRAP195MB1507.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:292::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 04:58:54 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::9c) by CWLP265CA0273.outlook.office365.com
 (2603:10a6:401:5c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Wed,
 5 Mar 2025 04:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 04:58:54 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Mar
 2025 05:58:48 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <ggiordano@phytec.com>, <d.schultz@phytec.de>,
 <joe.hershberger@ni.com>, <n-francis@ti.com>, <afd@ti.com>,
 <nmorrisson@phytec.com>, <d-gole@ti.com>
Subject: [PATCH 11/13] board: phytec: common: Add phyCORE-AM62Ax
Date: Wed, 5 Mar 2025 05:58:36 +0100
Message-ID: <20250305045838.3614661-12-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305045838.3614661-1-w.egorov@phytec.de>
References: <20250305045838.3614661-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PRAP195MB1507:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c90d85-7268-4776-acf3-08dd5ba26dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dhfhcSoAGDiRcok5KfkzzhlOarcGVmrU8W253Zu7R625QaN9aJVrivf/lsAP?=
 =?us-ascii?Q?GkE4dqm8l3Y0eD4JUMMmsgJCjeQlLC4YV/rb5u+RBdsonLtVxn7ErAT4kV6c?=
 =?us-ascii?Q?Q4RS1Iu2AB66RYeXwJkx0YyyK5+iHBAzDxZ0pmp4LiRSaRSwzOHhApn80Nhf?=
 =?us-ascii?Q?i2KgimzZOA2sZwr72rJKnseDBzA2N3HiKgB8QI8cpiH+wQKwkhIXQbt82rOm?=
 =?us-ascii?Q?MHHYXH3DSav6SHM621E/cVwnRaWyFnNXbVWmNj1Arq2j1MLWNIxqTM7LcWvx?=
 =?us-ascii?Q?9U3HVYtsEPW6TxhHW73nJlIBQGt6PvAtNgCAwQfDCuyfhr6fSk8sl01iHXqK?=
 =?us-ascii?Q?+PnwbRs3kCI0R0XAcJiqKt8fxMGEUUDJzCAql5z1ACahnoC9c307Li4uo+Wq?=
 =?us-ascii?Q?3JjgPZWiX/B3+TTcF/JuaZ1l8/mesn8xD/js2tVAcOo5xQhgOntYi3grEXD0?=
 =?us-ascii?Q?rUL1Q611Dymr475v4987Gq4uSJpbPDuNN71jVw00Ksz7bMTWFeebYJ3ChXnV?=
 =?us-ascii?Q?VkekbJbuVMMdmPDj/oXvTZxz6JwfIVZEnkfMloeVnxzA+zIfVDs/OJ0i1LJx?=
 =?us-ascii?Q?bJ4/AbjluMld5YNT4UHf4y3S1+8h5pdMBkn8TXytvKqjvKUZUT03B1vaG7/W?=
 =?us-ascii?Q?brwL12jL4c+qMKHkMW6HukBPGxtrM5pdrGukyh9tvZJeKioM236o3OcHojRr?=
 =?us-ascii?Q?IagrVrad/lqF8Rt//L6Wv80nEFRbFvfPw9nnUTZRj8II8QXLnNn91E2hZ+Md?=
 =?us-ascii?Q?NOzo67J/z4YVcnaR6jI4slu656Zs4xx67GswN4iP2gRDqFaWu+jgKwvtMbE7?=
 =?us-ascii?Q?JJBZm1gORLoaKbv56B6DWsSeyXEpDnL/95oDgWSRttius5mAg4mnHnnFVFK9?=
 =?us-ascii?Q?WIBIHnXSJyYAHgZPLknrc0CL7O5jvFo0dvhswM4UJ48U4VPdlzBRe7lMyTc5?=
 =?us-ascii?Q?A5Y/MGcoS0KQ7F00zjL0vylQD9yE1WqHTGCaU0+Dty4VqhcEdIkj9FIn3CcB?=
 =?us-ascii?Q?WOlrQdydzgEi4GrODZzsUSbEQiDpgzqrQHZVYmUa3NwUaD2NBJ5vLBPhluD6?=
 =?us-ascii?Q?nFI5dNPZnP2exQaj7MRs3oEVs2gH/fmbGsEYrnd/c43NIMEO2ABkUPLqZpVl?=
 =?us-ascii?Q?VkVsPWb0xnmVUq24vVgIfYsT7yQwvdFh0jfA/xImvYp0kgkISrg5bMX1x+Ai?=
 =?us-ascii?Q?E11juN/HH9+UXy085Vj+xRwnMhhM5aLc7zqet/iC7kRZFglZpJAcLzCxNMDk?=
 =?us-ascii?Q?dxNZHMWeZClZGvfKIS+hw1FTPRk74y5de33qZyMLg1WILu2pQQUk+3qG+5BQ?=
 =?us-ascii?Q?c9SuOqdZ2FOOVIuyQlep8BbGi8pfGdgs8ony5DV0DgrGfXltKm9sLeP8IL6E?=
 =?us-ascii?Q?j/WAfYEy/b5/Xm7JoNG3lMNMWmEusFICdS7m5NPJc7K7OkIjuQP825khJWl+?=
 =?us-ascii?Q?lodIEiPeMpZ1BBezBpVPN6oJuePlTn4Jqq/fdpAOv3AxloJZLCHHMK/Dsyzq?=
 =?us-ascii?Q?S3B/NY1z7nt4fZk=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 04:58:54.1256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c90d85-7268-4776-acf3-08dd5ba26dce
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1507
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

From: Daniel Schultz <d.schultz@phytec.de>

Add the phyCORE-AM62Ax to our common board directory to
enable our SOM detection for this product.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 board/phytec/common/Kconfig             | 11 +++++++++++
 board/phytec/common/am6_som_detection.c |  5 +++++
 board/phytec/common/am6_som_detection.h |  1 +
 3 files changed, 17 insertions(+)

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index bc5511707ac..65451a3b20d 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -38,6 +38,17 @@ config PHYTEC_AM62_SOM_DETECTION
 	   Support of I2C EEPROM based SoM detection. Supported
 	   for PHYTEC AM62x boards.
 
+config PHYTEC_AM62A_SOM_DETECTION
+	bool "Support SoM detection for AM62Ax PHYTEC platforms"
+	depends on (TARGET_PHYCORE_AM62AX_A53 || TARGET_PHYCORE_AM62AX_R5) && \
+		   PHYTEC_SOM_DETECTION
+	select SUPPORT_EXTENSION_SCAN
+	depends on SPL_I2C && DM_I2C
+	default y
+	help
+	   Support of I2C EEPROM based SoM detection. Supported
+	   for PHYTEC AM62Ax boards.
+
 config PHYTEC_AM64_SOM_DETECTION
 	bool "Support SoM detection for AM64x PHYTEC platforms"
 	depends on (TARGET_PHYCORE_AM64X_A53 || TARGET_PHYCORE_AM64X_R5) && \
diff --git a/board/phytec/common/am6_som_detection.c b/board/phytec/common/am6_som_detection.c
index 7930ab42d1c..f5de5de4821 100644
--- a/board/phytec/common/am6_som_detection.c
+++ b/board/phytec/common/am6_som_detection.c
@@ -11,10 +11,12 @@
 extern struct phytec_eeprom_data eeprom_data;
 
 #if IS_ENABLED(CONFIG_PHYTEC_AM62_SOM_DETECTION) || \
+	IS_ENABLED(CONFIG_PHYTEC_AM62A_SOM_DETECTION) || \
 	IS_ENABLED(CONFIG_PHYTEC_AM64_SOM_DETECTION)
 
 /* Check if the SoM is actually one of the following products:
  * - phyCORE-AM62x
+ * - phyCORE-AM62Ax
  * - phyCORE-AM64x
  *
  * Returns 0 in case it's a known SoM. Otherwise, returns -1.
@@ -41,6 +43,9 @@ int phytec_am6_detect(struct phytec_eeprom_data *data)
 	if (som == PHYTEC_AM62X_SOM && soc_is_am62x())
 		return 0;
 
+	if (som == PHYTEC_AM62AX_SOM && soc_is_am62ax())
+		return 0;
+
 	if (som == PHYTEC_AM64X_SOM && soc_is_am64x())
 		return 0;
 
diff --git a/board/phytec/common/am6_som_detection.h b/board/phytec/common/am6_som_detection.h
index c5c6e179da6..0b3c9c8e1ee 100644
--- a/board/phytec/common/am6_som_detection.h
+++ b/board/phytec/common/am6_som_detection.h
@@ -11,6 +11,7 @@
 
 #define EEPROM_ADDR				0x50
 #define PHYTEC_AM62X_SOM			71
+#define PHYTEC_AM62AX_SOM			75
 #define PHYTEC_AM64X_SOM			72
 #define PHYTEC_EEPROM_VALUE_X			0x21
 #define PHYTEC_EEPROM_NOR_FLASH_64MB_QSPI	0xC
-- 
2.34.1

