Return-Path: <u-boot-bounces@lists.denx.de>
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916B3C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 04:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F77A82B97;
	Tue, 10 Jun 2025 06:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="D/eobkUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DB80805D7; Tue, 10 Jun 2025 06:51:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on phobos.denx.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
 DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
 RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
 autolearn_force=no version=3.4.2
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825C282B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 06:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmqaItOSAuGEm/wBHILQdvimSD4Mx26PI6zGi0eo0IbmdIydauJ3Q4l2IMDZYUOCGhdUQHN9tqGGRItoTkniymHu9Am3L6A9Qg9Ii50cvMezof4DSJrMbOxsp3lkQ6RzUpj8OLgevoexwB0HpFnCsokJ7MDrvxobKIoKJ/4kwKcK1rRORB19d52cAAPiLrY7x4AeOj64bX9u+EQ3MvRsvvuim8+0W96qud6AfopMoK0yZa5ICWzxxo+bBsixYNRK9FQQr0uO6fYyV08zcgTZRTG3ABDyi8xr/vB7uKVCw049CSy0I1mmyDDiNGMyu1vJG9rck5yRb/oLVabrusKFJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSDTaRn2vIzO8sTpy56vni3OnDHjqZEulmga5AmlQR8=;
 b=gVzX0gtbSNI378CEOfILKfAqtbAxFvAG8ELJAMjmL0ZxdafiyoiuhtT6klXF8g2KoeH7eJ1FEbApCNBzwQMSfx77LraDyvYSSvuvt/rHet228I9ulmxOcxR3LVzbPq8lR1LzIR6DTTDTHB+m3IMEETfpYDc2sIZ4mjZoIPUYvolFo8SfJeVqF2iCgyZS0qud1EvytrwjsJB79he1M1GzJKQwz6CeU28oBj4oZZpoIvCfN0QvgH+v/oHsHD3KUBj+qQW2P7u4+D+W/g9zWWPoStraXrvc1v1pytYcms8JIg92Ic56QEKa45SAuHiVP5rPrugXhWWvAoJcPhRb79ZfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSDTaRn2vIzO8sTpy56vni3OnDHjqZEulmga5AmlQR8=;
 b=D/eobkUmhuoSb5wZR6Fj5x3dmQxQV2bV09X4HX/zdeLVk1GzCpz50p0E3t4VFfJzTJp2v813i7dVQH8/l59uSWhlmwW4kJlBggoyLje4xCyuSJBdJfERXeqGfDEl9Bmg7m5CrdukQ6mo8nrRIpKB8pqN4WILsV8RT5qlNwqp32QQCLDaCMYY72KrKQe1C/s2meh59uG9m1UQCcXcnyayNyxnzIpAqyTzi8/leQF0rzaImAO3nwHrjZYHsxsQ1rWPL1WT6qdmHF4jD3NIibmDBPsnlm3nzFSUdk4sY52pXuVaTeq+dObz5IUdbwDMiJchgqkj0ewqDEgLI4HGS3GywA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU5PR08MB10774.eurprd08.prod.outlook.com (2603:10a6:10:529::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 04:51:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 04:51:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 2/3] common/spl: handle properly images with bad checksum
Date: Tue, 10 Jun 2025 07:50:53 +0300
Message-ID: <20250610045054.1038235-3-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
References: <DAIKOVEG1GGS.2LH5IT55T3CGW@ti.com>
 <20250610045054.1038235-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0001A03F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::484) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU5PR08MB10774:EE_
X-MS-Office365-Filtering-Correlation-Id: fdecb75a-769b-46aa-9725-08dda7da676b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tNJ4RZAA77zYVWvI0ZZay5u05LQsse+t1SsHnmjqcoEdmlC/Anpb92LzZLhG?=
 =?us-ascii?Q?fQq/Gl158s2m3QP0d+18iFy579v2ZrPBjtFZ+5A276U0ExmS3i4BA96BwmU5?=
 =?us-ascii?Q?ptlgvdhRcO5zMSPiThxvvOllRNVtRjjzYQvKCw5qi4pNgthP5BdA+YrePait?=
 =?us-ascii?Q?Wv60D+X3OgBqpwEDTnmHPjG6uu/ZQNSHoNgRhka170rfnF1gAu20V0wPiQq8?=
 =?us-ascii?Q?JfVNXNdFO8f4xpARO9dP2yzJJm1nxoNs9OqAn6vtWzgwI9CeopWJz5/0z2Ay?=
 =?us-ascii?Q?FpDK5tZM/TetTcenpoXZxTvg/Ku+m8p6MommpUdFVLVeDImC4zkPjsrU4qxU?=
 =?us-ascii?Q?ZaLYL42CODH8EVCTEz0vl8TK3MQIfFpGMAH2qIFwnjSZB1xPvDf1dK7zJ5Uo?=
 =?us-ascii?Q?a5hODyh7UaNRDp1CJ81FNrY6pH7J8/12eGk4bJaSueqWN2f9fDzB/NvkgqJo?=
 =?us-ascii?Q?Nc0TBUkRjZ8Gn6bPKGVwroGTiRUDvLav/9hebecA1pNVbiFtrFpk8razgiXZ?=
 =?us-ascii?Q?C4WlWkTFcfsNcyyctgifo6JTy9L8h+7F6VTZDTBD3jW/g4dSXhVCK8jCCn7s?=
 =?us-ascii?Q?t4I164g7ikksaVNkoIbpcJST3LcuNsu0/LuonXyStMpU+pbi4Yio9ULgBsrs?=
 =?us-ascii?Q?lqa0U5b47IJlRtHhv3KKNhnJObq6BYhBx1MMhEfnA35i4V6+C12BK+7mEUzS?=
 =?us-ascii?Q?zmXuE8vqexOT2051no4Xt5f6VNDyoB5CNtAZYFakGr2sFYJBlBMGIzqTfNFn?=
 =?us-ascii?Q?j94Ct45GQ+ArYoX4DEV4QCI+NrjAY3dCs5iGa3wZOVwqhCBpNmW8072ybChq?=
 =?us-ascii?Q?QMMvD4CMz222K0RPUKyDgRQ6LpuJeRlwUHa3h9cyj/7Py0BQiWkypS2eoqMB?=
 =?us-ascii?Q?Jd4NC3zsLAl7q8Hxvxvkf2PhSm+Z9zBz97uZOi10xlXtQxmerFPfq2+Jd5D2?=
 =?us-ascii?Q?HAG7NWXt66XBX8wqLJH9CUMol+iC6cIebMPUq/JaBiJbCJlSzG4medFMy7OE?=
 =?us-ascii?Q?ItEJJDZcmhonNlXiEdGqZ77RLgAneg/CkAD+N60L7tQiS7pS37Ytvfa1JMTp?=
 =?us-ascii?Q?e9204u7vbJn3ffYTTPtGMpbFuz7WO3eFvyImw8lg+6BjDH5151S+rfgUNETW?=
 =?us-ascii?Q?fMQmpRzySJLzLZ8yNpQEc9N96HzaJFxsPQrGanp7kdL1L/xwgtA76pgpEryJ?=
 =?us-ascii?Q?Z4IVMo0yhiY44AeZsru7Ev4bO03pBZvduqWa8yeyB9gpwCGdOgGqfzNHb6QA?=
 =?us-ascii?Q?peFEyPFVmW8Pg8c4CGNydSlfJsuSVLueKMltdd5WiZURgbTQw9+lc7qTK2RM?=
 =?us-ascii?Q?+EwFLPiJ3/EzYF6UreUHmqfJbcEUutQQhCzdqWEdTgTCJGEIQt95mVEVJDRw?=
 =?us-ascii?Q?FpAK32mpUEdqHD4GMKJ+eduuJHQo6M7w6V6OkNjKnRKxaQIOM5rDkJBDK8Ge?=
 =?us-ascii?Q?fDY1502k15iJQglLB3+6nzONhWGs4We6oOMggCHzzl76Y8sgUXg74w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4kRGHmNGW0LwFelN5UBwNy1xQSFbzsBiU9kwyLtjgcVcYagYO0iCPIFTskE0?=
 =?us-ascii?Q?+0Wpuuza/KmlnjL4ZyLsYIwa3JXTJPfXOZPBxO7/ZQeiM6tHBqSqZOLxWKWi?=
 =?us-ascii?Q?SyaRHenDGSGm0+wLt0Bt39cqWjs6AYz20olYGYrPJUgbwqkAGX9hZ8Ou365n?=
 =?us-ascii?Q?jATB+I+3wE2l++pyWsLT5vFquuQImBIRIicLehLT063TJIxBzv7C8dvEceYb?=
 =?us-ascii?Q?uMIpD43Hm0b7lhk8NTDuOukHvASo5ctauHYGmPRvQWz9xRCgQdIUAShggv83?=
 =?us-ascii?Q?L3wYjHpHnBhKLsNBim7yXLlDWp/jSPj6PCikG/fDNqwIt2yIzKYHnot717Gy?=
 =?us-ascii?Q?E+o1IBXcH7vyIgjSY298vK3fcaH+c2oyYocvdL8iN6x1MXL474QeqnMAdVuF?=
 =?us-ascii?Q?FPY5Y8VaPfD/HYtKo7fLC8vKDM64bufBJ71cLyARgrjkvk8wzrMdGMEWKV+T?=
 =?us-ascii?Q?BfQkX+R11hkOEEgsRx2BFm55CV12PaT8qaiC+8TcShC996LJmjhDr0O0XjRi?=
 =?us-ascii?Q?jKVPDXzSNhkFotX99pbGgvxPWsvOL42NycDXOudTVcHq83H8gN7wvUSdXnR6?=
 =?us-ascii?Q?6EqGsndEQ8xonUMqWMAMqPhGX4ngM67GGDykOAE43CpFdpr3goDUvCU+zo8N?=
 =?us-ascii?Q?XcFpFeBHCImc+SE73Zj3ZBXn/lBuwQ0DfCg+JdKquQ6HOEWexc0QU2G6A2QD?=
 =?us-ascii?Q?YAnw4+FIpuEw+7k3gArl/38S6+23xzgGPg8qIXqDLAI0UsEsyvPoH6WBBreR?=
 =?us-ascii?Q?fdMCTliXr6VxzWSTSAUDGxE21lSOps/qAJF2Xxi5dylIntQsf3S9mbXagws4?=
 =?us-ascii?Q?FqZHlFp0jR6c6qyj2s8ql4nUeFFrQBxSFDIO8OTg4gpBEmA26uMVdUffxXAI?=
 =?us-ascii?Q?zLxKHeFU+O+Uu8gCnPN6MNIy9DUgxlI0BrVeBD5gYk61Gu7LNkUE0ayOsY3l?=
 =?us-ascii?Q?1tN7WwA4nwGUeBXJk/fRKZG9cl1P4mTrsWDf2FPCDEIf3qoi7VK7rNccjk+i?=
 =?us-ascii?Q?PLM1mg5Q98pOacJ1EE/hV9Xy6Zm+5Z2rxjhI7henTXmPemab9m52ynFrfDVv?=
 =?us-ascii?Q?4ypGXDq1OUHe71fm86aVQGv1zO1QA7Hv40yr7VH5/y7wshOSItaPRiQVdAmD?=
 =?us-ascii?Q?vDGtQgW9Moz3nhqXnTe8TYu8SYG/GzXJchqxb4tisEFfb5i8MgxfpXPOtxjR?=
 =?us-ascii?Q?2hVOzuciD5Y4/I9EiGNNuSU1cLdnDZennhSCvW4VrlxSWy1GlaeFVPebDqTC?=
 =?us-ascii?Q?dDjuKDUcXjShw86muvqSLkHAO1QRNwxhEUC2NJ617GZae1X00v5SpupMPzft?=
 =?us-ascii?Q?27LuJBzi6CziS14yQduIeYXNxAK2XQ5IPZVEDoTivHgRowN8VC0TfXDE5ymE?=
 =?us-ascii?Q?bDbIc+GQzu2RI04RflKpw5h/krOAUrpR1ApyFlB4ML1DS1L7+Bq+btD6bnXv?=
 =?us-ascii?Q?MswMQVDERQf37MaAu+wHr+x7fRoLKSuiZqJXnIddL5dCCaBgi3i1b9mqzzCV?=
 =?us-ascii?Q?NgEHp8vs8+SHi31dCZQoEE6pvMORTAwgaCQVulrrC2Oag0FOU9HEx60KrvIZ?=
 =?us-ascii?Q?D3wTEZ13Eg4J2QoPKavJ/SrQz5bTcaUyegm8pWYn4X8qeJUfBaS+pWm1DRhw?=
 =?us-ascii?Q?sXX3R1SrUS+UbgiUWu6WOFU=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fdecb75a-769b-46aa-9725-08dda7da676b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 04:51:03.8460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3tdgeXFQoXCC1Fg4wCykJt3Pm4ZgYoxHidApEkEiQdmUtZlaTBmgMY4ez2FZ2NlPUkdKUJ3cNTWXamonqvQeFyGjqJkzlR7jjs0lnexqF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10774
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

load_simple_fit() returns -EPERM for the images with broken signatures.
Unfortunately this may conflict with image loaging selection on the base
of boot phase. See commit 873112db9ce68c38984ff25808dde726f8dd5573
("spl: Support selecting images based on phase in simple FIT").

Thus loading of

	configurations {
		uboot {
			description = "u-boot";
			firmware = "atf";
			loadables = "atf", "tee", "uboot";
		};
	};

with damaged "tee" image may finish without errors. This may results in
board bricking.

This patch fixes commit 873112db9ce68c38984ff25808dde726f8dd5573
("spl: Support selecting images based on phase in simple FIT")
by replacing EPERM with EBADSLT places where it should be done.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 common/spl/spl_fit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index ab277bb2baa..321954a1547 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -200,7 +200,7 @@ static int get_aligned_image_size(struct spl_load_info *info, int data_size,
  *		the image gets loaded to the address pointed to by the
  *		load_addr member in this struct, if load_addr is not 0
  *
- * Return:	0 on success, -EPERM if this image is not the correct phase
+ * Return:	0 on success, -EBADSLT if this image is not the correct phase
  * (for CONFIG_BOOTMETH_VBE_SIMPLE_FW), or another negative error number on
  * other error.
  */
@@ -236,7 +236,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return ret;
 		} else {
 			log_debug("- phase mismatch, skipping this image\n");
-			return -EPERM;
+			return -EBADSLT;
 		}
 	}
 
@@ -475,7 +475,7 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
 			image_info.load_addr = (ulong)tmpbuffer;
 			ret = load_simple_fit(info, offset, ctx, node,
 					      &image_info);
-			if (ret == -EPERM)
+			if (ret == -EBADSLT)
 				continue;
 			else if (ret < 0)
 				break;
@@ -835,7 +835,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 		image_info.load_addr = 0;
 		ret = load_simple_fit(info, offset, &ctx, node, &image_info);
-		if (ret < 0 && ret != -EPERM) {
+		if (ret < 0 && ret != -EBADSLT) {
 			printf("%s: can't load image loadables index %d (ret = %d)\n",
 			       __func__, index, ret);
 			return ret;
-- 
2.47.2

