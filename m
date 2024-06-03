Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BCDC25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 13:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ADA288282;
	Mon,  3 Jun 2024 15:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="N2/E4US4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BAEF8830C; Mon,  3 Jun 2024 15:35:18 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F85F882AC
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 15:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZxZDQEh212axqYXYfy9C1NFebltoZPbGZsfOAu1VxNOW0gFxgQInTQ3+64jJuaE5yKPboz3RA7giXqJg2lxyOfnBL3CRecYtGy8Fiv3X+GN/Uk7Hbo8Y/6BvZbb30cERCFJdoylGvgGzOPVRlD9Ua8e+tzNP7+r8sNdiRbK8DWCQfvu4DhOzZCqVjXFzMWiQaoShg5kclaKvC2WwoiGHJFKge2U/AeT7yvuiuSioBPZBusHNVRxIr9AsVHytil6cVXyHNj2U029X+7Owu1JKnwgji195r3/a/nK2Uqvq1+T6u1Px7j7AajheeVC8mLtFLAV6jywyykXfxK7c/Mx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hy0xp9u605F/ZN5e/XpFCO++kmvwCE5YkVDi8w9KlFk=;
 b=QZdn8AeGJAEgiTrvHiKRwy9QVnKx0+E1ta28sfdyjeGffIHtug8qopEynqYSqD7wfFAXrnSJi3DDW5jVeJ0l6moY/dB33zavYlU3vrPOi9vpiUV12zd8XBsjJTQgqwCkMEoijr2K0uE5CLil6lDek8Xi8ESM1reQQ+Dg4DolJfAcU720agt5sz4BNwtbMbV5xh3BEyrxmTULsAao7lPA+JJ0XtM4j8hX4HraU7z1UHn4t7FLEXb762rZ0gPCdBOPW6ngK+l47dr9UPbDkihc4IESlT3ogLq+6F0diLq+2R1UKphMgp3cxYgZkay/khp8ujnxt2T6ucAKH5xeNyfRsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hy0xp9u605F/ZN5e/XpFCO++kmvwCE5YkVDi8w9KlFk=;
 b=N2/E4US45L/sSlBf12VrNfXe2Cl+IYUZkATAIeuv3ZeifNgz5hiIU578YIh1sqCdTva6vsuxao6Zyh+ockuVYdvwshc4WvmrBPIi0OKOQrktE4tUElei/MGiNRXUk/l+MmQOYGpqKzkntDJaPYQKik/l1AccME87p6JFN9yeq8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV2PR08MB8678.eurprd08.prod.outlook.com (2603:10a6:150:b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 3 Jun
 2024 13:34:57 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:34:57 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/2] xilinx: zynqmp: Enable reset_cpu() in SPL
Date: Mon,  3 Jun 2024 15:34:47 +0200
Message-Id: <20240603133447.173402-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
References: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV2PR08MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: cd956e63-c404-4f55-c155-08dc83d1f5a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YhQVfCflr0sbSCp6QQTOPYoZhkDsx0zKXZ1YJgLtFXECInoYnqofpbD19Ran?=
 =?us-ascii?Q?fqpSwb3t8QHjvJzjRC9a7dhdgeQKs7q8Xm4no7IPyBOw/w/gdgEKpTCesJMu?=
 =?us-ascii?Q?eoShs6i1d2t+b8O43cHhkh/j3FJpw/VAqHiUgyv2rvwzihH1n/t/tcDlNpKv?=
 =?us-ascii?Q?0ogZ/xYyzQCF6iacCFMT5pGa4XVXCIO9zlNq2zTEQIIUoRlIEorpGbJQZb+T?=
 =?us-ascii?Q?YXutTG6gRDIPT56Lj0UJCjp47efH/z+3ha7+BkzW2x5eqWXzpWmJlWrcqDio?=
 =?us-ascii?Q?tqmQYuMdZk4bYuI0HNNwk2OO168qwYQcJmLtXpsvXZbQu88HZ3DYgXg4oWZS?=
 =?us-ascii?Q?egPHBRfrIEDaThwMT4XeJdPAZHDrZ5WXxGSQ9tcwJ59bQE4mKxoBusaczf0S?=
 =?us-ascii?Q?TsLqRnYU0Qu3MBs++mNI2/QG6gtLpkULPC7pAD5EY256ROX0/8xBZX6e4cY7?=
 =?us-ascii?Q?Br1D07gMQECoNtI1iYO0lH7Hd81X0tf6elyZeMIbcJcibliwV3GqOy1UeP8U?=
 =?us-ascii?Q?dHO1wcwjky06RaRPMLwbdNVef7F2Lr/Bai9tCkebfcAf7wytKTFmjRYd0F9q?=
 =?us-ascii?Q?qMUsd5NdmgLoG2ER4wV/OqB84/W/oJA0TlOdjvv3CgHSDbnLHH1PU15mgOoj?=
 =?us-ascii?Q?nIm+dpWWtkX6qWH3WDnTarjf6s0HSIZnBAdj8R8X6rlGeQtyiB9ZxjRcKoLq?=
 =?us-ascii?Q?7vxmDkFgO20ad8OID0nTp2OLruDT+KUfTdLLl0FZ/WBwRoauD+MuuVa7djih?=
 =?us-ascii?Q?aubWaqN+i5hXQYzoOY9SebshDA8rOBgkpg5pqMyUnSyaQHem933hISWdJMQh?=
 =?us-ascii?Q?vb/LtnWIlWyKPIWENOUGJ1HFcuVH+chwmcS7LrZdrHwadT++Pu/u4Jpxm1b6?=
 =?us-ascii?Q?SXpPvdHJBjjn4u3kw4fuTqy0FZIQvk0Us7knBO0pTTqf6o1tucfss5/Ku05n?=
 =?us-ascii?Q?9v/rPshn76wcomb/4JQnZaCtyIqgoiloydc7LGejmKBiZzSTXXSXGzMwBrTr?=
 =?us-ascii?Q?KtzN7ND6b1Tc8VPTEnCSi3e8fZX/XlZ9F+3to0/6Ifp7bBU1FhjZq1AGMajv?=
 =?us-ascii?Q?ybjVh2bhgUr8ZEzCwxQshXaMPBvZ3D9sw+4wnQmpneAPZ0SjZmazu5INMzxA?=
 =?us-ascii?Q?xCKAg0KLBGVCJdC2oRqXMMPJWRNcyoskF+PWt8TnXP2FO+PZh1KlhNNdYVJk?=
 =?us-ascii?Q?E006v+IsOFoji2P5RQBb1vO3sY3rXRn1lZ58l/vuEjr1801Qmf0sc2uMNZ9l?=
 =?us-ascii?Q?V6nkLq2zBJag1woajAFUgMK6QzR2yFLFVycKNiCt3kZITIns7aG16Fipm+w7?=
 =?us-ascii?Q?2Lz97p1Bf+ieU+jThSTfo0rp7SQ9iJo4iGyHFlnnw2xbTA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmdSrjuNXtRrA6SKC5I/Ja9x4FXFLCRZQYafqAEnDlZUsWHa7zmiMWCk+vdk?=
 =?us-ascii?Q?Iw6ts6kdj6j8q5Vo2AnxtFh7ZRDxS4UYqOI44ps3zc9pePTHc0zEPqMGxa37?=
 =?us-ascii?Q?MGAMEaXTjKRlM+vKHR24gl1KyKJnhnnXyg5eASW4ypKI9JRmWyNYqlr3yw/o?=
 =?us-ascii?Q?3uERPMRFU+5pzvcFnKJMyclguCgWtQZWJ7/xFJ3Aok/9c4bIlaAjT2mBTO3T?=
 =?us-ascii?Q?Mq8AddRH6yRM+a0ZJJzg30gCrOO3mSp1VuiUqwPRPJNZg/9mDeKj5iop5kBU?=
 =?us-ascii?Q?vU+YBMmfj/vPQhK7DmXOileWMOcx1ovIEokna/589q6gfmAgWlks8P0UF2Ah?=
 =?us-ascii?Q?oAs6B/lfVgvU4FrAH9LujfuWZfeaUVo5cv/My1moyCi7ZOd6FlTYNh3WEas8?=
 =?us-ascii?Q?B9uK0gLAe5XApAIgcnSlgcL5rJ40g+Rzfr6IRRq+mhLM8PRgNZCUeIMrlYtB?=
 =?us-ascii?Q?7L5OXjdti3gqaYHSvtaVKl9IR99X9RQ/FfFC9qhrx6+J5GTDQEHUNWTYIcxx?=
 =?us-ascii?Q?YTj+Rw+BWdebBr+KtFhsCjAJ6O+tFGSrMAY+PvIlCZ0Flts3F12MNTYm5tpF?=
 =?us-ascii?Q?TI8xK3GlEIUYbgJHbC3jWqsj362oUFeh8ZseKdh6zbWweLAmy5wXqLb/j3Qe?=
 =?us-ascii?Q?HPczTwNePv4qM/V3P4euklvljSHM4EWOKLdSrhXUPZ+eZj7I5uYRBcM2H1d7?=
 =?us-ascii?Q?vO34iLIKU/0bYqp07gtG+Jg+xeYyxqs3XTKvsjH8sh1ABkNz8WTVAfN/05eP?=
 =?us-ascii?Q?6jsNf6Akq3Wvo1MLlyZuo+CSb85UQCYshlxWAk+YaT2OsZg4johaiKWGl40H?=
 =?us-ascii?Q?y0L0VGIxmgda527VDZhnJKWVriNr2Eg40wlKMXAp4DhPdBO/+faOEQ/TH2+Q?=
 =?us-ascii?Q?R7aw3OSTahRCZB+f0t8yOc9oBSqiIrvX4nC/9UOzDwn7yMXe5c5FdokTbgBs?=
 =?us-ascii?Q?8fNSoJjbxUGC7mkG4SQdZwpM+5Oby6huRBF16zOTqZGI2jnqQK2lWNA/X/oj?=
 =?us-ascii?Q?6Ld5Ll6QaeUWotlQPaVArzmN/sKposOly5HAnk/Q5EXwqL9k7P5iuTsRcPEK?=
 =?us-ascii?Q?KNu4mOpH9nZQUIiP9wb1dphx3au/xTeg+Pcz8DPSECdnoD/AfP7270ZWMmRo?=
 =?us-ascii?Q?4znmD1GWjaDi60t6T9coLQrJ1MTkWNehsQjMbBe/4iUUTMT9j9h8ZDWCaguK?=
 =?us-ascii?Q?5a6Yy0ynENGmvLQnEdahFd2FTWtW+2SKLtYHwfq2PtfzxqH3BFs5IpSzcae7?=
 =?us-ascii?Q?SkA7CcWDfr63AVUP0spzyeMer5+Hze3tPWTEucfmxcriLrpNaBSxTiTmV+6d?=
 =?us-ascii?Q?ixDN2JQ+8emwLaUZKgevoKhDpxdlGc7GzLoHKQsSwWfyZ5buTJoezWyC8S6T?=
 =?us-ascii?Q?idg4Zz4fRQ4cE0JiZsbPfEcSHfd42w0J26Rl+yDCAFX2uqWeAErQK8liXANX?=
 =?us-ascii?Q?KsB3pER5RbQyRWuFBZXXTr1ATYa6z9yu2I6eTttz5f2BgZx4DSUsahn/7vXV?=
 =?us-ascii?Q?Cbc2hehYGtAPMDosPa9ngc3NTA5aBZYMnCZHlv9nd0WA0jX2oRN6d+2r9Ga6?=
 =?us-ascii?Q?naWkj7zH0erRunUdkHJj6Oo6W/C9hCbvXM+Fhi21g2OnK3u2zRc9fuG5xxRj?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd956e63-c404-4f55-c155-08dc83d1f5a5
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:34:57.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3/4WWVHXAeHmQ4YK61hrvRPC65UnWND2Khb8KZ4HiPJwwuuRqKdYte1XQ+Bo7lvflDeT7yXJyB+MIZGSGiAYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8678
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

From: Lukas Funke <lukas.funke@weidmueller.com>

This commit enables SPL to reset the CPU via PMU-firmware. The usual
reset mechanism requires bl31 to be loaded which may not be the case in
SPL.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

 board/xilinx/zynqmp/zynqmp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 95a134b972d..99f5c178c1d 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -40,6 +40,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
+#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
 #include "../common/board.h"
 
 #include "pm_cfg_obj.h"
@@ -285,6 +286,14 @@ int dram_init(void)
 #if !CONFIG_IS_ENABLED(SYSRESET)
 void reset_cpu(void)
 {
+	if (!CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
+		log_warning("reset failed: ZYNQMP_FIRMWARE disabled");
+		return;
+	}
+
+	xilinx_pm_request(PM_RESET_ASSERT,
+			  ZYNQMP_PM_RESET_START + ZYNQMP_RESET_SOFT,
+			  PM_RESET_ACTION_ASSERT, 0, 0, NULL);
 }
 #endif
 
-- 
2.30.2

