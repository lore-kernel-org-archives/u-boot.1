Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D206CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB80842D0;
	Fri, 10 Oct 2025 13:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="hdnt6WSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 434BB8425A; Fri, 10 Oct 2025 13:59:04 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 578C6842AB
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 13:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZSmgcQSzdYEUpLgO+Snk+qU5SYiwUTwZQzUktH7cS3KrFB20ND8zcShl1/VBAnjwBzCDigmVPoEuUsXBbz0kIYx8YitrQWOLv9g6ayTkZpg5S9+85jC2j4bA4cDR2eTemc6uMHCdceTzNvCT6ndDJbFyEKovu1l8S7SUcxRUfb93oQAlENY+rrZ0UkiyU17ZgQAM4oLXFskpxe5up/d8ppObGNGMqObehudCGkruOLJtPQ1CnbOYhiqGNsLzgklnUMEIRSNCTDPoPLab0aZRogJ/yHzAmdT/xhw1k4XbQMxHu4T0ma9ozGU+nqFFvs6bqVM0hIz98gOsQqGPtLZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1I4TTTiDqK2qN+U76rxSsudVvQxbczZ9H8gSjoO4qh0=;
 b=vAjHjDski0eyjlKe79RP1GEGawlQGPy0lxRVc+BgQEZwiuHukOVV+ponHA/4m4HV3r1PJtRnm6OZhFrbG8TDygzvo8GgRT5TTPK1JJpUQg0h3J4yV5n3/ahjn9RjnRH2yH3iGe6aI1ov3OuZm8RlMAxVi0KS4DXyBIg1HgPkxZGV6iD+f8t+Jr+4QtMDYs/Vg5/rEY7BqV70ZskNdZWvVB7ErGZ3jrWzdTUJ5qm5faO2QAEwaNXN4HbTykhRqONN6uJfqYhbV1+sMEVMSO5FkX0JUnaOIMbAFqP7V4yQx8wa3sqQRhZp9YioBSlb70TO7zeyGTaJ466Wqov9MRkfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1I4TTTiDqK2qN+U76rxSsudVvQxbczZ9H8gSjoO4qh0=;
 b=hdnt6WSL1j41BIt8rSO2399alB2vPCAtERj+uiIkRlBY7k/1b+qvyxpU2f61A0iZ3xxd9/lLfXqoriVCjlrF7b2jp8tUbL7GbxwyVLMRy8OxqkYCqK7MUD+m4F1ELKOQgIT4/q3O+IEA9NHyM1M6f8fnTpQ+btIZMUuJ4a80Q2Rwb5PQkqRxncEtUXbauqRbmF941Jq5Ue6qSEg0wCAITsPMtF2NEVSvLX7erMyp9c+ODoyeWZFMxmN63s4DLdO733D9CR7+ndD7QNuKSO5qWGvnxCstwCylD6+zuYgmQmfMdYbusOe69rBXYyW5I1meZ27NyNGjtocwhpicV7APJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5586.eurprd08.prod.outlook.com (2603:10a6:20b:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 11:59:01 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 11:59:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v7 20/24] mtd: spinand: Add a ->configure_chip() hook
Date: Fri, 10 Oct 2025 14:58:21 +0300
Message-ID: <20251010115825.1531775-21-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010115825.1531775-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0139.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f7706b-350f-465d-dbd4-08de07f466b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|1800799024|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/8+XYNoHthS3wHGGQY+rHjb7CBXPsT7EMxGSnzc2SiQJI4ZNnZITm3J9fqBi?=
 =?us-ascii?Q?h8kBfG3oH74nRK5+HEBNGPJd+kNt12G2/xqS86/e3XHs2glboOfXNxa8R+uR?=
 =?us-ascii?Q?LC1DtK7QWmMjLW6vaYfGbtw3ZWyhn9DjhTpn2oyuwvWxAbD0RxMV18rNa4eW?=
 =?us-ascii?Q?OmeZlPqe0ZTMSa8KtDkE+vfrmlMEydAFsCB5jcuzpTWPmaOC8aFHGBDwqD+M?=
 =?us-ascii?Q?5B3+D+mW/VIreUwzjd4GdNyqfWjOTtCw+m7XSib5avgYlE7JbICFhvy6JDIv?=
 =?us-ascii?Q?8a/zB1fMaQHQEDwqZ9JTxTl1SCgxsYu5L2jPNgniIxjLYlAt/wULL1pxl5F3?=
 =?us-ascii?Q?LHxYqQZqnVknY+c5nlZa+MAIzrXActEbc4I6wYyDzYs7tyX9V+SAhGq7YJj0?=
 =?us-ascii?Q?LZGT8s9pNi5Ti6YlhzAc1Apqkg+2KlKwoDGm/+qMqFz+wY7enHM0AikrjWnM?=
 =?us-ascii?Q?I8sE7/C+evfAlR49KQzuS2Dbmx9xQbeGYGMswO6ouM0qv5Oq/P3ZdBimiaCa?=
 =?us-ascii?Q?D1h3vdIMV13Pzaqzrjyp9YkGUXKEYIP+r647XKL+g3guALb6KU8VuTI8Jqp1?=
 =?us-ascii?Q?s0PfJa4mtN8sVZxez5Fw0/zBgs19t50qtuMm3Tuo4hoS6+YggctVJpdpdYjH?=
 =?us-ascii?Q?vDOPLe2fuwgeEFOn+FoG94PHQ0tYClSbExo8XgWGB/rlFKvdq6azKiMA4uqK?=
 =?us-ascii?Q?BrKiYJ/ZgvfJJHvyTxjeZ+In2YtnqCs1IfFmqdiDxT/P1lIFRaSK0XtsrUpS?=
 =?us-ascii?Q?fV/DayXgmsVMZk74ye2kaGCMyqktqobRg98qcFC0WpHh3qhj/zT03PkPawe3?=
 =?us-ascii?Q?nfMQ5HHMAqnMbLMcVLzr4nsE6/daAmgT87iMzsPAC2xSxs8Cdx0bk1XoAqIE?=
 =?us-ascii?Q?NNDNZ+8TJWlO7zIUItR5xGijpQYXog/ZWLg8KxMAYVyTho+lWGHNQykUZKqu?=
 =?us-ascii?Q?yxCdbhlKDS4SQAORnnjOVVA/pV5JaZ8Perer4h9ixm7M9+1xXgzM0TWXg3Fa?=
 =?us-ascii?Q?96svo/SS6eOxLTJBTwqksacC599EMB/e+53tuQyjP3wMuOE4Z7MhNEmYlbbG?=
 =?us-ascii?Q?0PYhdOF2HPuC/tQ2VWT6lIifixNA6a/D8Tif5E7V31ksQMTiqKmQQ5xqGKAq?=
 =?us-ascii?Q?Tsv4+KWnihUcqhb37PFULmgRgAFAjCxfR+nWX1Qju7czpKKSqcZg5V8tSaUm?=
 =?us-ascii?Q?oPjnbPVvz8NfiONIjdrXV8slkVQ3NhgPdQPZkTXjTel2PAq0R4A17Wdckmfs?=
 =?us-ascii?Q?3mDaz+l2cC7JnbF7zk0pgt0XSjeOJ+lHdedkFysE6wa8e+mbSrsTiQ1LuaAe?=
 =?us-ascii?Q?Xp0OA0BvJUY8Qgads1YcgGUwoNcSYekfqdAiQvt90MrJBcKqHedk/URBq6CK?=
 =?us-ascii?Q?8XwkbLyuVlBo8J0E2FjaSr13BnwknHL84QU9TqVfyqZhjhr42m0gWyIf/U02?=
 =?us-ascii?Q?0pQkU8TtTIhuOf7iPmi5URcxMUU+07w2hAkWLbzk+Cgh/xfPkopidCLBxZ4Q?=
 =?us-ascii?Q?ZHm70lSLfVpqKtf7+y7E4u7RUojEk8b8gFqBOj6YWvk9W9z5Rn7rORmkaw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(1800799024)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PhUlPhOfbkvU8/Z2yrIz9OqcvbJ5Ux8ViWl/5gcGIkoJAUMvPxX6bUZLK3gp?=
 =?us-ascii?Q?rhFSmrXBhy6YexIRAb+3LdY5E8C2jMGDROYjIuiNGZix9fAaXCBxfqJ6DQch?=
 =?us-ascii?Q?8UeneSdC7BAoGd6GA1aB0xymv39+LDswTt90dNqsPM5Uv94rE6npKSazO9I7?=
 =?us-ascii?Q?llYamc4EbrrGzWh+md6MnAn/dVJrVLyV4gYK401MmvsLBQrPUND0Ja2SKlKW?=
 =?us-ascii?Q?nWdtFCSMVQPzl4pK10OxA+eIF5ldqEA47QHWdZCvGX8paIRY0ZoU6gBnyGSD?=
 =?us-ascii?Q?xzV6dzTjS9dMIBlYjlZvZPppIAkgij2MxMFYANhpEJPbEj2BSRcUUa/NSW0N?=
 =?us-ascii?Q?qgreZM7+Xx97Dg0RdwKeZIg+iF38bBapBGq8q8xgXmgiYZ+9Cun5Qxi5R3Yg?=
 =?us-ascii?Q?GffMggtuq+sDKbmvTosvLcVulUh9o6TKo2il7W5fwrB8sY0CmnWvXhQ0jgkx?=
 =?us-ascii?Q?hWXWz3Dea+6M4pZW1xozhgqxVZcFckTXI64FrnBSpxMecdOuqVd/bVIwANCP?=
 =?us-ascii?Q?0BOctF+puARRyRxQwIBV7NchdkUjk0E1NjKeO9fPQc6sEnVuL/4jDOjaEATs?=
 =?us-ascii?Q?+R6hfdYHQalsvuwF0XnknEApLILhXqY8DJKI+f2B1Iz/3LUGoqmU4SW8xcbx?=
 =?us-ascii?Q?qLwhz7GHxsYNY/l1ncJ2Xu9YiReIhlY9m6jKszBZQ5lxSs/N7YKC5mIENJ35?=
 =?us-ascii?Q?MZ7GnijuY62hp5ICC9ui1V1fQwE66B/ZqJSBarublyQTHvgDALXxw+jBiMVJ?=
 =?us-ascii?Q?pRam5tVI+AQeXZSw4nen+xbBk/tTlzo1HiKNbEyxM5qWTzQsRz2U0pdL2IJb?=
 =?us-ascii?Q?UJE4n4Od2olu0Rn3Gx/hsgl+tal2wcC5Nq/Z2Gn1ORrJojONERKTf5d0XyoN?=
 =?us-ascii?Q?m340U+gxCVydwRk6Yp9QFwb2KVFq9WYTewKYFLQ0RFmvCGJME/a/N7J99rKe?=
 =?us-ascii?Q?0OrRabM7hgO5VoMEJbQhxI/gGXXYSkD6sE8mPg8BTS8Mg7Zc2xFWsUWeLHGZ?=
 =?us-ascii?Q?86mect3/hk0JBJgHks19VzdoAOYJOfmHCsseVxl59/OcIEFsxptCCXXOPy9Y?=
 =?us-ascii?Q?AhoCBC+V/1YPg+mJ0/9nXDW2QKlkBuOvGuvB7PAgvuURL2S9i5bxoiKEtNp2?=
 =?us-ascii?Q?EB45QX87tHVMkLfdw/9BrVfoL9iUFgMdmyca0sjlb2eKrcU7rStPtFRC0/dp?=
 =?us-ascii?Q?7juKzIad46qsrpSYKCgrn+A45xcVFGKbcdOgJqAT5MPw2JOmuY8MVSuPcnPr?=
 =?us-ascii?Q?MhgWkZUiU5CJwcSrJiVdZtJjkIx3dMCuh8CGBlkofSbd5n6sxOzKYwYWw6DK?=
 =?us-ascii?Q?3kCe/T3Qt50XoGHyBvxknuANDr9ilHlGN9sZGuV3fT6fdfJ1Wl3yiINScdEZ?=
 =?us-ascii?Q?8uaki7gyZ+lFkM9twSbDgPJg55Unyp6UDSQpIPcv0DGiRwMMqjjBUhG6T9OI?=
 =?us-ascii?Q?tSMEzq6kHRjaah6W5g63eZ4k+Vtg3TYPAnYS+P+ojASn7J822tifs4K8J/c7?=
 =?us-ascii?Q?01iFRqXJcQSxjnoB+gxIBSK0Y+VN7slaO0B4eMhLXtQvJuJwBE1wKZrmwgP2?=
 =?us-ascii?Q?iPwdOGCkDWQqwR3lfU5uLzbvaSK/ZhxenMJumJentm9itKTfl5mD5D7277y1?=
 =?us-ascii?Q?CH4ksVVsUHCk44QLPe/wO1U=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f7706b-350f-465d-dbd4-08de07f466b6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 11:59:01.1524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZqyyN3HNslbR3l1i+Yv1rdN7K1qbe+hhJCuwAVYliK8gx1R+6ts6v1Qb5k9NqJ/vpQMR0g8EJbQTULHIXFLwjmc9eKVOevEwtek3eDsTtnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

There is already a manufacturer hook, which is manufacturer specific but
not chip specific. We no longer have access to the actual NAND identity
at this stage so let's add a per-chip configuration hook to align the
chip configuration (if any) with the core's setting.

This is a port of linux commit
da55809ebb45 ("mtd: spinand: Add a ->configure_chip() hook")

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/spi/core.c | 16 ++++++++++++++--
 include/linux/mtd/spinand.h |  7 +++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 3e21a06dd0f..25e7a38a874 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1251,8 +1251,19 @@ static int spinand_id_detect(struct spinand_device *spinand)
 
 static int spinand_manufacturer_init(struct spinand_device *spinand)
 {
-	if (spinand->manufacturer->ops->init)
-		return spinand->manufacturer->ops->init(spinand);
+	int ret;
+
+	if (spinand->manufacturer->ops->init) {
+		ret = spinand->manufacturer->ops->init(spinand);
+		if (ret)
+			return ret;
+	}
+
+	if (spinand->configure_chip) {
+		ret = spinand->configure_chip(spinand);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
@@ -1363,6 +1374,7 @@ int spinand_match_and_init(struct spinand_device *spinand,
 		spinand->flags = table[i].flags;
 		spinand->id.len = 1 + table[i].devid.len;
 		spinand->select_target = table[i].select_target;
+		spinand->configure_chip = table[i].configure_chip;
 		spinand->set_cont_read = table[i].set_cont_read;
 		spinand->fact_otp = &table[i].fact_otp;
 		spinand->user_otp = &table[i].user_otp;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index adfb5f3ffbc..94f324741e0 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -398,6 +398,7 @@ struct spinand_user_otp {
  * @op_variants.update_cache: variants of the update-cache operation
  * @select_target: function used to select a target/die. Required only for
  *		   multi-die chips
+ * @configure_chip: Align the chip configuration with the core settings
  * @set_cont_read: enable/disable continuous cached reads
  * @fact_otp: SPI NAND factory OTP info.
  * @user_otp: SPI NAND user OTP info.
@@ -421,6 +422,7 @@ struct spinand_info {
 	} op_variants;
 	int (*select_target)(struct spinand_device *spinand,
 			     unsigned int target);
+	int (*configure_chip)(struct spinand_device *spinand);
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
 	struct spinand_fact_otp fact_otp;
@@ -453,6 +455,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target = __func,
 
+#define SPINAND_CONFIGURE_CHIP(__configure_chip)			\
+	.configure_chip = __configure_chip
+
 #define SPINAND_CONT_READ(__set_cont_read)				\
 	.set_cont_read = __set_cont_read,
 
@@ -521,6 +526,7 @@ struct spinand_dirmap {
  *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
  *		the stack
  * @manufacturer: SPI NAND manufacturer information
+ * @configure_chip: Align the chip configuration with the core settings
  * @cont_read_possible: Field filled by the core once the whole system
  *		configuration is known to tell whether continuous reads are
  *		suitable to use or not in general with this chip/configuration.
@@ -569,6 +575,7 @@ struct spinand_device {
 
 	u8 last_wait_status;
 
+	int (*configure_chip)(struct spinand_device *spinand);
 	bool cont_read_possible;
 	int (*set_cont_read)(struct spinand_device *spinand,
 			     bool enable);
-- 
2.51.0

