Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA3BD3F06D
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:18:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0406183FAD;
	Wed, 28 Jan 2026 15:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lHSnnFRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F6B483FBC; Wed, 28 Jan 2026 15:18:49 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2E6B83FA7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g19BvCI7PerHBZyLHfq+sKbksuimshfvPGDjrI6cp3AQpMRL0EddoGMiezWkCmYUWm8OPfLPFCryTvHeHR3b/PiDwV261o/JzxalSaQYx1rM/y0b6Eoa9wAW3JB+KJWC5a70ZSQJzzFTh1qRE8SQYG60hS/UO5GoS7Svr7ZYi3uEbB5DDVjEAVcuJO8yYyEqyf/ac/nL2mgsHFT0OFu74uuogS6wxDLvieUMzTF90szlozH4EzZJAYytiyYiMuZP0Qdc6U8hXlnrWlHh4znc0frECtryLjmauvX5GP4uwx6d+5Toju4192M0iXurkrgL1mPeZvDX5dUda4mD0T6B4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8uGY4XE15wtdpSWBRPbYVQ5FnOg6xIJWv2tCeYEgHc=;
 b=DyytfD+LahF5TxyRTt6Ueau2uuiciY0C3TL5THqrkxE2/xYuwzGRD05I0nnN4Xj+HObFkWp1VcjRFearzBHtnMkPpgzE57/MioJeYvuD2aeiVXVQ/Y/VnJ1SH7phQzYzRjabmBSlEacChQeFADlzXh2HuJPIGEFHJEfqFy3gOEYghATMCI3RHotwlX0pfPcgFoWWe+MTMqEUd0LQKN42Y5uiddbwNtc+oZwUgak9k5sgQtZH9wfJRGUUFKsVCoSWI89oTsR99/OHtsI6OCNtq8QZYbaSmywumvpA8rUiwo3RGfiwWeg1SHpFt6UXF4mMGfmPdCNp2mjkzfOrjf6aRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8uGY4XE15wtdpSWBRPbYVQ5FnOg6xIJWv2tCeYEgHc=;
 b=lHSnnFRQtqcXv+cwU3+N7uXdsY9NHg94O61S3NVbvOEC07XoNfiU3yz2CotIsaxRgWLidd6ZUvpBecaMdBI3JfQnDhaYTVp0HJQ7hGvRLFsKCnVeXOHUCzSI3w5RJ32sTSeyPJSMFl745USjyfNn7H792DGCBrslK3KP4PkG0SI=
Received: from CH0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::33)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 14:18:42 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:116:cafe::45) by CH0P223CA0015.outlook.office365.com
 (2603:10b6:610:116::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.8 via Frontend Transport; Wed,
 28 Jan 2026 14:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Wed, 28 Jan 2026 14:18:40 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 08:18:40 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 28 Jan
 2026 08:18:40 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 28 Jan 2026 08:18:40 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60SEIY8I2087912;
 Wed, 28 Jan 2026 08:18:35 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <sean.anderson@seco.com>, <ilias.apalodimas@linaro.org>,
 <malysagreg@gmail.com>, <sughosh.ganu@linaro.org>,
 <philip.molloy@analog.com>, <marek.vasut+renesas@mailbox.org>,
 <james.hilliard1@gmail.com>, <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <bb@ti.com>,
 <praneeth@ti.com>, <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v4] tools: fit_image: Fallback to 8-byte alignment for flat_dt
 images
Date: Wed, 28 Jan 2026 19:48:34 +0530
Message-ID: <20260128141834.2322865-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: da8f60b4-2e41-46cd-e4ad-08de5e7822f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ilMwLAV77fMXcQYoRdiKch0EHy0zBD4j/ZUHsPOzxPle5kzTq0E0GZpZVSbM?=
 =?us-ascii?Q?2xpOwRf+hR2sT+iLmpJhAgGUna7Nn+ObCe3YwrKg2+F6M1swtjueaK+7OAX5?=
 =?us-ascii?Q?Y80bSFI8AoGaqxWyn6NaqQuALsjZrn//Vu7Zj7r2hXT1Kp2rt9cdcSWFlQ/O?=
 =?us-ascii?Q?NzawZ7Msgx5PjA7EsmxUZndzrgA75Peu60YX41XfQBaxKpvrgKGXSZ+0w3zh?=
 =?us-ascii?Q?J4svoHecNWuKW3rqBPnd7DL1XxqxK2yduG8Kc4RFJCWhTNtYpNsGlovMC5Xi?=
 =?us-ascii?Q?Lz0KoYwZ50Cy5PoN26XZ7cYrh/MqU0sc1wSNGTWlKEw7h9y9w+J9v5KSTgTc?=
 =?us-ascii?Q?9uez/9XjiTICP1JOlWElY3PlMGz2Nhuc+OqCax6c7TEgrHsH6XPWBiOdTg9s?=
 =?us-ascii?Q?L9iKPOi49tSuzipsxh4WE4huTZHocxSEKg7hlgCom50LPpqvmbD83uPJBB3C?=
 =?us-ascii?Q?RrsmcpI2R2NSrarQlt+KZTMRnwnzLhO/ktlNnIpxOVhDmo3s5FJkp+Yv0ezC?=
 =?us-ascii?Q?mBvPmtFVQw+yJ6AnF1Uv4mUvyDrSSewKLVeyc7iLyc+af8ZzEG/KVtOlnfg1?=
 =?us-ascii?Q?8RLgSuQxcktEUan7PB7O99vOsm8rBbkNlahAv3TY3NxklJpbJGESwaulvprm?=
 =?us-ascii?Q?BSK+Cso4c1JEd8q5aULKxl2bE0nDEj96nmftgEx4mJfitjgsUpG/FCTGk9dI?=
 =?us-ascii?Q?Q7u+AgPSxgLuOapb3g8M4xc9SWpKnr5omyQ9G0Pf265cOTxpvmNSjWO+YK7n?=
 =?us-ascii?Q?1W6jOsQBntOGEWu/+WG7HpaObafkGxAdB+tNkccLmSVaME3WcxHbHyaY4xrd?=
 =?us-ascii?Q?CFF0AlOpemy7OiJNcdUIAIwRJ0JL6MW+YQfn2wT3FYB4EQQw4w1kGxCsRJV4?=
 =?us-ascii?Q?XEwAqm/uVTac3h1ztlTdSljLp/FEQ10axke1fx4EwQh6ntZr3rW4zWivl4Q9?=
 =?us-ascii?Q?DvsQKLnoJIbeKgQVd1K1xrDzy689lcos6li5pccrofWYae80vbVvtXV+WEdV?=
 =?us-ascii?Q?nt+EgQg6zFIO8MSnYng5EDTmanc4WAPzAzhyz5xJYgpDGbhfZ4b6gIuqA3dW?=
 =?us-ascii?Q?uTy2vmgi9W3UmdW3tytrOkPjKzjbfSDkHCkWqxEN7/WLaAdVy2B4yQNSwriJ?=
 =?us-ascii?Q?Gk9gZXxVXg0hS3nWj5r4nY+GmhdSzEtGrk21ayOS6qkTN1+poyUarUbWfj2t?=
 =?us-ascii?Q?Ptu56DKAwZZxIdz/mHi8w++PodRMwpHWpsj6X0jCNNoY0m0Qlh4NFVPqcVjv?=
 =?us-ascii?Q?oNQaavCQPdks+qU8gDmI6WMc0N46teou+21zwf8L6ajMhPuCnd4k0Yrsqb2R?=
 =?us-ascii?Q?Ghia3i8fSw6I//HqXy/C793UC8vLMiASPxjCERixuGMjTmeOM0jAbMO81CSq?=
 =?us-ascii?Q?wNec0PzumTcRlyjdM3qOMPF4q3wbNtCs5hxfI2ZSa8l7owtPMy1g6qSr4ImM?=
 =?us-ascii?Q?6Q64qyBZj27MtIQuZJ8uRzq+iUeDyPt9i9mPG/8bA9hQgRhUFgnZ4tKy6c1N?=
 =?us-ascii?Q?yVQObLpux5EFXnQv1OUhan9L5+HYmSt+sq0i9MjlN3yzYZAmsvkij2yhMIu3?=
 =?us-ascii?Q?5trSc/HY1g4rocr8Si6VoHRlHvssR1d9gQg5KqnJqKZxFyKE+kZRL9LGI458?=
 =?us-ascii?Q?CIzdL2JT+A/fMcVYMj6iSMB9OfM6k3IlVnocDxd3V73Khk1mekeD/D3JO6tz?=
 =?us-ascii?Q?PV2q64TtB7YCWMRHQWrxAAxElMI=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 14:18:40.7535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8f60b4-2e41-46cd-e4ad-08de5e7822f2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
packed inside the multidtb.fit FIT image. While the individual DTBs
and the FIT image start address are 8-byte aligned, the DTBs embedded
within the FIT image are not guaranteed to maintain 8-byte alignment.

This misalignment causes -FDT_ERR_ALIGNMENT failure in
setup_multi_dtb_fit() when locating the next available DTB within the
FIT blob and setting gd->fdt_blob, because of the recent libfdt
hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstream
version v1.7.2-35-g52f07dcca47c")

To fix this, check the image type when extracting FIT image data and
set the alignment size to 8 bytes (if not already) only for flat_dt
images. This ensures correct alignment for device tree blobs as per the
DT spec, while also allowing different alignment sizes for other image
types within the FIT.

Reported-by: Anshul Dalal <anshuld@ti.com>
Closes: https://lore.kernel.org/u-boot/DFJ950O0QM0D.380U0N16ZO19E@ti.com
Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
Testing Done:
1. Boot tested on all TI K3 platforms.

v4: Changelog:
1. Align only the DTBs to 8-bytes, other images in a FIT can have their
   independent alignment. [Marek]

Link to v3:
https://lore.kernel.org/all/20260122172247.2995437-1-b-padhi@ti.com/

v3: Changelog:
1. Default to 8-byte alignment for DTBs in mkimage instead of
   passing -B 0x8 in build command [Marek]
2. Remove previous R/Bs.

Link to v2:
https://lore.kernel.org/all/20260112101102.1417970-2-b-padhi@ti.com/

v2: Changelog:
1. Carry R/B, Reported-by, Closes and Fixes tag.

Link to v1:
https://lore.kernel.org/all/20260109190026.58464-2-b-padhi@ti.com/

 tools/fit_image.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/fit_image.c b/tools/fit_image.c
index e865f65a400..f842c845771 100644
--- a/tools/fit_image.c
+++ b/tools/fit_image.c
@@ -682,9 +682,17 @@ static int fit_extract_data(struct image_tool_params *params, const char *fname)
 	for (node = fdt_first_subnode(fdt, images);
 	     node >= 0;
 	     node = fdt_next_subnode(fdt, node)) {
-		const char *data;
+		const char *data, *type;
 		int len;
 
+		/* Fallback to 8-byte alignment for DTBs if unaligned */
+		type = fdt_getprop(fdt, node, FIT_TYPE_PROP, &len);
+		if (type &&
+		    len == sizeof("flat_dt") &&
+		    !memcmp(type, "flat_dt", len) &&
+		    align_size & 0x7)
+			align_size = 8;
+
 		data = fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
 		if (!data)
 			continue;
-- 
2.34.1

