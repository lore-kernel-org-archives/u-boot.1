Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AA7E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B1AB80288;
	Tue, 17 Dec 2024 09:32:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="cZvJAQ7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3FDB8021A; Tue, 17 Dec 2024 09:32:23 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39ABF8022B
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 09:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFTOolOsy51ENSK/658yzPpd3oNZHsqrV+1ydJKXs+0VmxDIHPvAfDf5IBSjEEFc5KksOkA149VqTGjaBnpBqTKEx6+1+O4qGjvvd7snGC8SfEzKOhf/h2fhacmnicKBXtN0t3cDXnbwNLNEnH4yxdzZeebI6GRY8NgDb+lnP8iAJ/PoRT/DRFX5Q01aI9YicJBtEH8vWM3cTRez2hc34HIbpMSLpeAjG8bxl8585XUZvw49CRb3DhQHAD3IzwlF0d5JOOKKGYWRe8w2JDQFDFQsi0Z5VeWUQZnl54I2gt+nDRT/tcLC8+za21X3nHBkZzER6tQJI4RCIGy7V5jblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9zxPABgNtn8TEy3f7ndOaLMehngj+o79iSXDAkmbYA=;
 b=oTicxnGLhaK+on9JBXK6eBPEnny3EdjTnG/x19PwZ+Eh/4wlXzHAqtIUTRgieZqVb3rWjNN9RZSOalhqICzhS/ElR2LFenYFuj7fh1FXPuQxBNGSKhgCyPGJtH5xdBeHblLZJC6kjiqeZrPcEti6AJZyr+o/B8164ABuUgM4bPXChfGYH5KgayHWNGtyjYpQQoOwEguihPVCxgLWD4gGRJOsGW70BDHm6RGl11KDnfwOJGh6Mo2x933NdU8nfnw/BzPNfCYjKcSVtzMm8QIIhiWEL8mu04agxb8zjA2V2qplH2l15ltia/htW/i6srd3yGZGbrDLy+pWP/N6SX4PBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9zxPABgNtn8TEy3f7ndOaLMehngj+o79iSXDAkmbYA=;
 b=cZvJAQ7fnzXcex+DfKgsUbK4IXEs9eMwKx8W9Y8LTlyk9dD6g4sfmrbnYJzAO53+PjZj0EpS/mMDSXWjX6WZzOweN/zdf/D9Ut5QLAy0iTxI2IYgLp6m9AXA2JC/ac2YcS0DXxM2VuH98PiMTptTpaAVflUVs1AjgCndyT0FqdkD/xx8fDhI+hYcz4Mtjfjtimv7vFkj9x1tcQrA+OIAZPe4SNYP2mKyiI+UREXPEDbgjnPncS+azTyUkVwBw8fXVvPJsNHTa7EiHPnGWcLAor1xGBGe/tyXxjMd8F9OzmxoKBvVM5u7rlBtX9rEM7Dqvm6SRNbAw5jAPonhmZfU7Q==
Received: from PA7P264CA0278.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:373::16)
 by MRZP264MB2668.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:19::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.23; Tue, 17 Dec
 2024 08:32:17 +0000
Received: from PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373:cafe::25) by PA7P264CA0278.outlook.office365.com
 (2603:10a6:102:373::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Tue,
 17 Dec 2024 08:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B8.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 08:32:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id AF783202E9;
 Tue, 17 Dec 2024 09:32:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v5 2/9] tools: renesas_spkgimage.h: use
 linux/compiler_attributes.h
Date: Tue, 17 Dec 2024 09:32:05 +0100
Message-Id: <20241217083212.70330-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217083212.70330-1-philippe.reynes@softathome.com>
References: <20241217083212.70330-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B8:EE_|MRZP264MB2668:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 55641ead-6da3-45b9-bacd-08dd1e7550a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ISzysS+OlyayPcNP7wL1s8PZGzwe2fTZZv6aNi7CmcQvbM1N56DPR1syEedy?=
 =?us-ascii?Q?80A+v1M4WEwJdgHiZo2UJWpRD9g/p0xcx9oMdxswLY9aZgGtZVEkrp9yJI1U?=
 =?us-ascii?Q?4mynDLz/T5ZoRUR2RTjm3PM0Al19fB2KJxIJrxg401+kLE08kNxJtqpU4cDI?=
 =?us-ascii?Q?sn5NDwAowK9SM/HiiksBpuPZ7LJAODS88/3CJM+0oRHVkK4NgTu7knTtaeVz?=
 =?us-ascii?Q?Z5L4OKRQqZnk/NSj2ROMqDql/sauuxan5FAw9/rgSBj1e0qkVYlKULW0Xn7O?=
 =?us-ascii?Q?rzg/1lnkKHndr/T+Pc6I3LycSauCp8PejgSGpbw+9jw1f3UAguu4ixb5YKa+?=
 =?us-ascii?Q?QasRNfF/h9APACGM4kcnLpu6qkKh9RxCKH7LU/urICjgdLeGOp3Wkmc4uXAt?=
 =?us-ascii?Q?WMs7LXFMlVMNlcNE3d2tYkByavOso4VqnWBrbgFDcRceoBvsME5v53M0FoH2?=
 =?us-ascii?Q?l8dUjaEGaibgytrDdvbocKUMvvapMMRIrLJuMGWKuckokQtNyq0vI8V817gM?=
 =?us-ascii?Q?zHKNpQkP5MCTv6DkiSBH+c8sOIIb9ktCNTVjbmXkRPEHxF19mt5LnCreIcQw?=
 =?us-ascii?Q?lPhV+D5dvVQoEk6cnSufC860wlaNquj3Y4vZNmQc3e1y46EWB14egS4Q1Phc?=
 =?us-ascii?Q?LvpDWEkrBswLU+I1XBuXSaLb2qQDj4pyxWF21eVk4KpNToHtXmMedUFPMGvD?=
 =?us-ascii?Q?UyD8SUsCK8vIeE8iLc7UnPnI+ND1ck+1zJ9tcNnQlMUdxozNwtjk8ZgdXIqI?=
 =?us-ascii?Q?R6URRZlKwoRAzVzngwfdM5482KTt2wGmpTL2vdkQ/G2WBY8imWFeGE5kzMFO?=
 =?us-ascii?Q?TsZ1VwD055gwK75NgHdoZuToU2/nAuP8duvmnoEx1G60GgO3VH9YFVlD2BNC?=
 =?us-ascii?Q?vPmvq4R6kzT6IpwATEcF0PTpCq8wNEDrEGLw2jO7Zp7a56vxjDdc1dZAPZFI?=
 =?us-ascii?Q?Qc3+M8R1okZtYj/oL5O/98ugWmQt5ZVccWc5ujVRUfw5WqSlDQIHvVwS2vjW?=
 =?us-ascii?Q?gN9oybHg9yXCWZUgWPBnq63dcQsbXoDc8Ob8plaRfyGkPY3XdpQSBRspio3T?=
 =?us-ascii?Q?WcHg0HRdkJa5LoThrZDXXQkl9+bzBiYnQHL+C72hrhlQ/Cb9KugeW5RDbood?=
 =?us-ascii?Q?rFYUZQWXqeFp32tuWHumGSyB1kd3zRn2UMn0ovWfk7wBrFMKgZ2SnA200nha?=
 =?us-ascii?Q?O9mztPxXiaSy3bt39c2xsGijjHA8A9acY+7igkQKxkMbkLvzc5BxpsRZTsvR?=
 =?us-ascii?Q?JwPP0o1ZlxuOTgmN1el/lxDsCz/9uZbJjhknkVOKgqKM7moMdveMbkum9bWW?=
 =?us-ascii?Q?EFrBTc24vOMFmTdmlBZC5wJtZjCAZpGJZO7zUH+L7STEAU6xrmmwFy2C3Ffv?=
 =?us-ascii?Q?rAaSlXZjsku3aDxYhShDAM3zO2Ceq6LxMLXv/JzpW7PFY/6vJOidcehKxMBf?=
 =?us-ascii?Q?iVwCQJzikd/R4xVi/yv1FKXLY5ZimZQy+0L3g+/p+cgq6pdbfckzhVCLeHpP?=
 =?us-ascii?Q?/VGQaKOMn0Qr0uY=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 08:32:16.9367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55641ead-6da3-45b9-bacd-08dd1e7550a5
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B8.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2668
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

The attribute __packed was defined in the file
tools/renesas_spkgimage.h but this attribute is
already defined in linux/compiler_attributes.h.
So we include <linux/compiler_attributes.h.h>
and do not define __packed.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 tools/renesas_spkgimage.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/renesas_spkgimage.h b/tools/renesas_spkgimage.h
index 367e113de9d..83ec567b0d4 100644
--- a/tools/renesas_spkgimage.h
+++ b/tools/renesas_spkgimage.h
@@ -11,11 +11,7 @@
 #ifndef _SPKGIMAGE_H_
 #define _SPKGIMAGE_H_
 
-#ifdef __GNUC__
-#define __packed __attribute((packed))
-#else
-#define __packed
-#endif
+#include <linux/compiler_attributes.h>
 
 #define SPKG_HEADER_MARKER	{'R', 'Z', 'N', '1'}
 #define SPKG_HEADER_SIZE	24
-- 
2.25.1

