Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BEFDC0219E
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 09:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C7F80EBB;
	Wed, 12 Feb 2025 10:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="KoYwP9/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEDE80C83; Wed, 12 Feb 2025 10:31:39 +0100 (CET)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B97C80C7E
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.henrys_ext@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OlhjQX5NtOwo0cENz2UYQTIHUSoFZHGBj65QEvNvxtEdaQ7Jlrr9LcY9ZWnI18qGeVZoBncydrO1/VtijpbMXf1YbkmWkdKDkuc16Q2f5PJ2UdzXT4A2ngqO1F8hOyDtM/u4sEXUBmDWHDg/fvFoibFUOSZbpZuhBPNH6S9C+lPV8s8O76Tk4mv+dRERvWX8+2iNCZXfbU6AXeZO5UW1ZnsPE0vGsVV3XRNxBcdRb66IoJLseltWU4lMpfBW4TnZgB74ftNEfEfT+d/VuKUQueJTwH/jzjFp8QmNPbno9QzgH+RvRWLpPrNi7XVEX/lukNUKbQDsje8NDtcPRKrNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qEIozGbDBzihvGz3IcA6YBqJnhy+El3TeuWysxRTIA=;
 b=dhqvI+/UKQftV5xs239CoJ77RVDUqH3tno17APP3VFYA8ozniPtkslLOTjsxQnJ1CEguhN0tIdA/urc/S2vZsGpGYKlri+38Ncbna9CcLGOjqrxkPNBN4V3kDNEd8k1RBCByt88hb3hupoWlMhPVm6lkzBEKr9QuGwLLkZmzKUBOjjj1Ac2UE91r7MCLwC1mG4KyZdnWSi1iTpGAfgVqZXWbrN05AxbGf0i3dJ5gehFmyammt21xosYD/O/vnQMLUeJIla/KjH6AbACMdQh1O9GC+HQHU6cdjQeW9EC/qAPAzH3d53GNN2xEOe/vYNgDp1vHNe/xJwMekAlKDMYU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qEIozGbDBzihvGz3IcA6YBqJnhy+El3TeuWysxRTIA=;
 b=KoYwP9/a6VgO1F5qvymjKfCBZqRK8DhgU1JBJURTjw/3AhbUbdi55godvX2Sn3i+7+oQQQNRGvOZFL1ACjBVQXi2ubkaqVmNnnbOiKGsF6kGTi856wV9AsaULzvJiWpZ/5QV+VYaB9h8nqXD0qhCPFH9BNhvUEjju9Gha7lukeysdI4B4LLI7znFRoaSUsNc1fomhWT29js/pfHn71M6QTtzVvxL8m7Gkamfcl5c1DYW6e5GgyzVmygpK59ySLMvwS97eTMgj0GNc3rj8fnBcB/HUB+pf9Vp8Ouw5UAcCMGMcpiqnfq0B312InturVuNzDkterhH1mhL6SzIGLgq0w==
Received: from MR1P264CA0190.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:57::13)
 by PR1P264MB1758.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 09:31:34 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57:cafe::13) by MR1P264CA0190.outlook.office365.com
 (2603:10a6:501:57::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Wed,
 12 Feb 2025 09:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10
 via Frontend Transport; Wed, 12 Feb 2025 09:31:34 +0000
Received: from sah2lpt245.. (unknown [192.168.72.253])
 by proxy.softathome.com (Postfix) with ESMTPSA id AFA5720059;
 Wed, 12 Feb 2025 10:31:33 +0100 (CET)
From: Paul HENRYS <paul.henrys_ext@softathome.com>
To: u-boot@lists.denx.de
Cc: paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org,
 Paul HENRYS <paul.henrys_ext@softathome.com>
Subject: [PATCH 3/6] boot: Add support of the pre-load signature for host tools
Date: Wed, 12 Feb 2025 10:31:23 +0100
Message-ID: <20250212093126.3722186-4-paul.henrys_ext@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PR1P264MB1758:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 83c2d9bb-5a44-4038-5035-08dd4b480a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bq16IHuEh8x86lNA2YjvZB91OtOFV7J0x+SB04IdE3958pwOVR5PfvMQVY+k?=
 =?us-ascii?Q?fr7uwxrgmeS+VhOG75dGqNGQb/kcSbLFcW9/A7tuKR9FzIcb6lfPYdEocsxt?=
 =?us-ascii?Q?yqYDjwZqlD3dIvceZfhQqAiQpVyYdKjTvrvpMQ1Xwirxa4cmyxzaQ8hmU0Fk?=
 =?us-ascii?Q?VPtr1oYEQmVMbbISE/DE3CVrp18jdxbtiT7cjmg1/eKSXBJ/CeJ9OpS/6yP1?=
 =?us-ascii?Q?Oy3H8llbXBAZRAUTDj7m4pHVpMveGdmbnvAE3dqpc8jCIqb4jXRegpZQKunJ?=
 =?us-ascii?Q?7s6P8ZD3oBruG0quE9TDjcKZWbayPTV/scIuwGQE6nGxok8n/jDkrzx/gY8j?=
 =?us-ascii?Q?UAQVo5SZQfzCa4SfxBiTnN6f47cuHy0ysfcQ7K2g2C1STYUmI6CWe34ZbGz2?=
 =?us-ascii?Q?c8MGPp94S6DB+t2RjsnOOE9XAyYeZH7MR69qKUgL3e9qCqOobBRGfEwtKcCR?=
 =?us-ascii?Q?NCLSXHMx6Io7XsC/6kiSi75WQH0Enktd3n1qKdy6ukbMjCE1ZIuWKPV3p16T?=
 =?us-ascii?Q?Tzg3nDtGnpbOCGeIc3p10va0GuyT7e3iC2ttSdHLLD2jrM5KKAc1EVWuIU8T?=
 =?us-ascii?Q?5iDdFMI6DOkZedCgMRp9r83WGMn46pxmz67FTwrn+U3VMh9xeHsgVFj8IrX1?=
 =?us-ascii?Q?SNw0noJZTj+nyI/P0AyEExFvC7EXf0BjIkfjA6j+ryQTNGl+6J5aLbUBLzD/?=
 =?us-ascii?Q?JK9ali1QDUi8zNM0QDwlkZ3DU0kS9sYfbdITmjZqPCMXrAFLGegbw4S2XyE2?=
 =?us-ascii?Q?5atCW36pxKwdvaNaOdW3qARte3pjVu1+VJ00qij6Rz0GYEDL9PI4y9HzWLkk?=
 =?us-ascii?Q?qyT3GYb0WZ4DQzEw77EqlQRoyaDCVxe1pNn6AqRZZgULjZBfiAP79nQbk7ZC?=
 =?us-ascii?Q?fKEODi+u8YZZj0vMIHBqvMIOgBQUurIBB30s0XvJSpcRlFIGQkMzFnd4/8pR?=
 =?us-ascii?Q?SRJZEXwC/ASjteCGYo3vSsz/mq2HsbcN1P/WKiBe9AyZUwYAnd1aCBtldfUq?=
 =?us-ascii?Q?wXzg8kEgje2j4YErrt0RLoro7Nj/8nGU6zac8ie/5GdGgamAL7mjfWGSvv1S?=
 =?us-ascii?Q?sEDmBiwU4dQ9MUTBOlk70gGYmtuOsUrD9KSutOtbs5oynxUzZZ8JBmSTh/gh?=
 =?us-ascii?Q?gmY16QAqfqWwWfL0O+vJflWnqqHLb6L6arrOE4edrnchHAgQJ8+B4xrq/3at?=
 =?us-ascii?Q?Y+q5uwIMshxvE0vuOcrkG4/QTOqxnYYVaKF94LLkGnOTv4d1lBssYWW3WUJ+?=
 =?us-ascii?Q?XVr6pBd95xeX0yY0COSjYoAbHL8Pq3TynzCKFQRj2W0E4I3ALf3vk0KAzhLY?=
 =?us-ascii?Q?g+Q5SNrJTc5oPABkL12YuWKuFtchYfQFT9kb5EORHbPsEG7BKEV20zlUU1wj?=
 =?us-ascii?Q?PAOG8plLh8utlPxCZZ4K3VBB972H7POOehBvM9MZJ5zg5SF6wbm3hR4ckkf5?=
 =?us-ascii?Q?KNJWBKffx88KMDBtgUY5ET3YtcHRblvQL4BgpaczHDqB0c8MJJExsiaqfSOp?=
 =?us-ascii?Q?DCYVGjKjlcw/zyM=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 09:31:34.1304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c2d9bb-5a44-4038-5035-08dd4b480a79
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1758
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

Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
---
 boot/image-pre-load.c | 57 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index cc19017404c..adf3b341a20 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -3,13 +3,24 @@
  * Copyright (C) 2021 Philippe Reynes <philippe.reynes@softathome.com>
  */
 
+#ifdef USE_HOSTCC
+#include "mkimage.h"
+#else
 #include <asm/global_data.h>
-DECLARE_GLOBAL_DATA_PTR;
-#include <image.h>
 #include <mapmem.h>
+DECLARE_GLOBAL_DATA_PTR;
+#endif /* !USE_HOSTCC*/
 
+#include <image.h>
 #include <u-boot/sha256.h>
 
+#ifdef USE_HOSTCC
+/* Define compat stuff for use in tools. */
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+#endif
+
 /*
  * Offset of the image
  *
@@ -17,6 +28,47 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 ulong image_load_offset;
 
+#ifdef USE_HOSTCC
+/* Host tools use these implementations to setup information related to the
+ * pre-load signatures
+ */
+static struct image_sig_info *host_info;
+
+#define log_info(fmt, args...)	printf(fmt, ##args)
+#define log_err(fmt, args...)	printf(fmt, ##args)
+
+void image_pre_load_sig_set_info(struct image_sig_info *info)
+{
+	host_info = info;
+}
+
+/*
+ * This function sets a pointer to information for the signature check.
+ * It expects that host_info has been initially provision by the host
+ * application.
+ *
+ * return:
+ * < 0 => an error has occurred
+ *   0 => OK
+ */
+static int image_pre_load_sig_setup(struct image_sig_info *info)
+{
+	if (!info) {
+		log_err("ERROR: info is NULL\n");
+		return -EINVAL;
+	}
+
+	if (!host_info) {
+		log_err("ERROR: host_info is NULL\n");
+		log_err("ERROR: Set it with image_pre_load_sig_set_info()\n");
+		return -EINVAL;
+	}
+
+	memcpy(info, host_info, sizeof(struct image_sig_info));
+
+	return 0;
+}
+#else
 /*
  * This function gathers information about the signature check
  * that could be done before launching the image.
@@ -106,6 +158,7 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
  out:
 	return ret;
 }
+#endif /* !USE_HOSTCC */
 
 static int image_pre_load_sig_get_magic(ulong addr, u32 *magic)
 {
-- 
2.43.0

