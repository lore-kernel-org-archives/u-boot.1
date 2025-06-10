Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB9BC5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 04:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD2E182BF6;
	Tue, 10 Jun 2025 06:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="ovbr75UQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A53E782B18; Tue, 10 Jun 2025 06:51:09 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A597D82B48
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 06:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+F+tRg7RK5eMPV8Gd5H9ysyuWe2jZa1iEa0j2RXlzkWusMvpfMBOCBa4q5seZ1dBraJuhONybJHNJCqtSwdZ0e8CUYKEW3Qiadl7IWYntRWZka2A93axZu15rEsi9NvdoCCR0v6UJaKH9DHOFUBsN81xO5GFVF8+mwcAK4SkC8hVZ/AePnJfHScvUyxvDxAOb52QdpmQK1pqk+W2sxhHcGEJHj8kUjceYjiI9q3OuYB8DOShdT+usvy4eqoDF43dvWTK8CXoZgaVQ4TzhJWl0py6XnZOaGxvzQR+QS+7cmZSLLLIAZ+/BK7gI4pAXlNofyTfUv9hydofL0mPs+YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BitS+FCpblb77koXdf6N7Zw0r4BWMnbBHSzJJltT6X8=;
 b=OgEfQtXeQBVKVYhIdda0N8yCHtCUmq4gmG7tWzjYi8PGGTJ+3KYfHMS+RoWAptuo5r+yJchpH0Hm3sE9G8UOgDfXYwgft108bh1tBFIpoVeFwaFxfjemmwEe1YjBwEy2IOsSh6hb86+rUsnOCF7f3FPV27Bk0o5BdBuZ88Hs8JVSv8jl9adAR23/eu78Kv3XGR9GJu3NuWQk3BvPzQ1cxU45Fw3kFAEb8iAnHhGh0CpclpEejMN+NhLRzdVh5eoksb8igmapPtzBwIhRwPdk8oDIy4oFexTWPxEUpvXmOp/A/wavw848aocLoEMEW3gfDTWu2YHzWUT4urSGNjgaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BitS+FCpblb77koXdf6N7Zw0r4BWMnbBHSzJJltT6X8=;
 b=ovbr75UQlkvzoBuA8Gay9gUTukt8LKN1I/HQ8qVZWDyvADZ3VEDaovYLd5DZpVZdZmy2g0yPC0pZUKKdNdTSM6wphQJ4zl9R64L97uhWf9aphNreZ6p0dq12mPoIt2qL0Z3lqQlBt1c9bOaubT175gqspMeJRkKxPEf33UunqjrafzKRJhqerlo+hddCS8DbLDZBKb54jmwpsBFkLKwsvFx2Q0+vk07t3dYYYVP2RFSL7Pn+Di2i1XwKnzYLyAQcPga87i8ippo11ky9iHcVIgYBhsgGBF3ncHrkYphL1YM4NcmQTDyAx+vrmRnst5Lcw055/kXvv3wGCups56S8lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU5PR08MB10774.eurprd08.prod.outlook.com (2603:10a6:10:529::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 04:51:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Tue, 10 Jun 2025
 04:51:04 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 3/3] common/spl: improve error handling in spl_fit
Date: Tue, 10 Jun 2025 07:50:54 +0300
Message-ID: <20250610045054.1038235-4-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: d600354c-a2d9-4daf-5fb7-08dda7da67f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gJH3Df3URGXDCZ8E8yPiAXD/gy3BQqVkGsuz90GmhU5nR0X3QP+rnf2a/EZo?=
 =?us-ascii?Q?861K611D6fElNiKBEdgqzrr9AaXqDJ1YqLx7qmpCvMkD0RVqK2IbmI6COdFQ?=
 =?us-ascii?Q?52o9sz7HvRJt9J0ewsFcgJ39JLB4RVXTnOKy9RN2rlXyV/kcAB7G7+eeFie8?=
 =?us-ascii?Q?PAecpX5MPfhF2FLwYM+9GDCLkOBzkfbdz0eBzUiVMqtLeATNLi0bJ1t7RF3d?=
 =?us-ascii?Q?Kzdtsqpz74L+PG2OOW3z50XJpO2Zq45+kw3dlDUHDhHDKT2CpDP0OucLU6UL?=
 =?us-ascii?Q?xgGmqh8RuSoJ3vwUeayY2Fu0l9VKXhV3tJ8+u41QFVe/SZOezJqCWMmIuDk5?=
 =?us-ascii?Q?jfizkGXfLDip6L0fnhW9OKRPqidhXYN3RbEInQ7rV4T35JZO/BzdjhHM5d7j?=
 =?us-ascii?Q?wg0+lX4yHe1xfMAWM4QYqQqoyoRdyhsA7RxWHXxnL0ciTRUdgXERU5vwSZHJ?=
 =?us-ascii?Q?eoayFd8d15m/BtModm8fonbzP/ZOUzPSq7RJe/3zLfKg0wjJgsEnZwGIJyrE?=
 =?us-ascii?Q?8QDUipfFvx+Af2G/rjOfM5JbXVPSCrVL4BOmkHdtje5+/+cq1I0gjA2YADR4?=
 =?us-ascii?Q?7piCqCMNCrIkevHyY9aXifWvCUExvFdsc1H2lj1tAl2vXyHzKT2iuOcoe9g3?=
 =?us-ascii?Q?CswOjxHZMmLEdeSaUNo9+9wgXIfHKyeLUqhUsK+E4nYYtK+odeXTGUtxV+Lg?=
 =?us-ascii?Q?uKACpkGUQoNjaWIcXCnLEdmYxlFmaCbYiBWeaNlZJ017XUlTvJtdw64GmK9g?=
 =?us-ascii?Q?AfC56UJ2IZytOzAcIxWqWFXYJ4QyRKSh9OvCo9g6aSMxGl/ks4QrT1Wc00aH?=
 =?us-ascii?Q?bIkeUf2kvXjRMAgMlwSjlIAFvkO9zUSYbgpniZhhH0cIORic6oJtrQw7clCG?=
 =?us-ascii?Q?zm8oAriVHclzJSPUD8AHfiiqnWX/MQb+3EL7EZGVezdxsWZP/2jL7lEdZYs9?=
 =?us-ascii?Q?tXrAeYNXPgN4WiHf+oEuvSd39jqFUbXGJSCpaJAcgK1tADsnKjjiluly5lHp?=
 =?us-ascii?Q?SGMVPqnjHK7yRMBMjZ+Hvg60t6T5E2Ze/YuoYAGLhZvCT0FEuN5suEKWQo5d?=
 =?us-ascii?Q?JuMZBsHsHHKsOH8VLfZd3wB/D5IPtO5l8B4Rs1AGrjZ9jCHx1HHdnJBlKZhZ?=
 =?us-ascii?Q?GW6ttqVFMjqKLDLmnzBz6DJnvQnGmPSNLwmmJQTlskmo+m8VX3Acn3TlxzIF?=
 =?us-ascii?Q?9qLuLV2o/ZG+YPzHxlHH7pN5sa+oXVDUabE/sFYgeXjxp/Qycq4N0njlYkoX?=
 =?us-ascii?Q?3g7+p2F/YVWOKbNGvyj4bR+9r5s/IBYSEvuY+F+6Lwzh9l4FFfGyBunx0fWu?=
 =?us-ascii?Q?veGjCs9WYMp657L81+bFs70X/iv8Y8xos4xaMx90Qv0oww3tuej5DsaPdjbE?=
 =?us-ascii?Q?JYc4diIv2ctXuweK7nDtO5SyP7mfStBOTD00mB1LgFdD0nZHkWYpSIDWtkwJ?=
 =?us-ascii?Q?eKcbbPiMnUhaff0OkSpbI4xfLww7JY9KVWCIXkwsZdgsg27RTrqw+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FWDnjXH3aJUsGHZ95F1Q/YApsXU3r9A/omWbXCVjVRj9RVIp7JcabSabg0Hu?=
 =?us-ascii?Q?uxJx26+ulyqgll9sCd9Q7JmEi7eUWdX/YRmhS7ERRRpIutaRY0P+JxWwcTQE?=
 =?us-ascii?Q?PD+YQPDX54C1XKthXwS3ccKGFkzARZRVgQTUHY3pKKaNDVwtgnNvt6y2Wg/H?=
 =?us-ascii?Q?KlcXMh1Ajab0ajaDxIo4jfwsrAIDxiyhukt7fCYCRMuncPvsMT/fNcnZTWvj?=
 =?us-ascii?Q?drU+baKbQcyYEu9GPG2XBfTvLS4B5HVLD3aKHwqkFNxmQAOVriBdQmg1AUjT?=
 =?us-ascii?Q?rWiIbIo2947WCahO+B/afX3YCoxuN1lwqnRTYS8Cacm/WCanN26qBH1CKgfM?=
 =?us-ascii?Q?mjN6fWRQEYJaK1uFS7AKsttrtzSkNhkEgErK45rNv6SIx0UkOEiaHFTvt93q?=
 =?us-ascii?Q?W/M6b8KODfLlF9jx5cBEvD0epGCkcX1QbS0hJkdvp4aX4Y0cePdhVLJhg5Ng?=
 =?us-ascii?Q?cqKEnlNSTegucsFbeyyWyDjzq7H/tZwP62D1KkuYM2i/1d+cEosmOHxfXK/W?=
 =?us-ascii?Q?Ql+DT57ZhQ/7pLdzcutni+H1t1a0PBziXSEOrziBHLycQIAK83mHYou1ZBH7?=
 =?us-ascii?Q?txWymrPxapIxDoV2VHxbWbBqbCnE2a4m3pT3LiWHabTLbmR/F2DgvY9cKQP2?=
 =?us-ascii?Q?nJZTCnEriawA2twQyIF6b325E8CWEgI4htwnhiPN378IjVLb+4qu9gegpuXy?=
 =?us-ascii?Q?CY41AUZQEZ+sZqdygcxJHY1B8MgS3il2G909YyyMGv6j6wemAJN5h+fUysFz?=
 =?us-ascii?Q?cOANF5J4rUWzabS50NyBrNZfTh+J9ybLxgpB2Y3Jzpeo8BMUBaNAotZobc/L?=
 =?us-ascii?Q?kRMLn43QosifhPC7ZQAdEqW82fV5LiJ91NfaxsndaXzd/WdyPvFhZVgI4YVJ?=
 =?us-ascii?Q?SX9VcCN/8ZIHTP65wN1h96LUIXpAPRhNPEaTk2X1BM8F3MGteYyhjWS6Ec+O?=
 =?us-ascii?Q?VCP2FDwDMA+bCH28330hAsIYD7T44J1xY6aP67AvMUSaVYVTyPnK0PXGGXSf?=
 =?us-ascii?Q?apWlvKRus0dmHmGYSwl1gA+Z8SdpuC6ZPgOL5JjP72UsDeK6x52uMfh5ZaIg?=
 =?us-ascii?Q?cRY6YByeIhpBEFTM9My+whT9FGaE3iOP7k6uP4xcgSKbtBaHlTCjX+M5TivK?=
 =?us-ascii?Q?ZZFHtKP+VIFmXE4xj7fKvxUK6+9VLo+TYmZ5Kgo79DKhTWwvBy54jvrHnd49?=
 =?us-ascii?Q?dE9HT+ktCptsVjWDTv6Q8mnqRicnyGOPGGVXdDq7thHTIMy4v15ReNqFpQTc?=
 =?us-ascii?Q?srLp0VUq84FpvPwmf+K43c/5trmnHD2Hp7lh2ltoT1h9v8tY5gK+RCfGBLVO?=
 =?us-ascii?Q?oH/FQCMjprjON+8x0YmQXdc+pIiWy0cwmB5nuqY/AohBnhtxrAJtsamVdq6k?=
 =?us-ascii?Q?1XkNgwU2P979yO6lPEaeWfo1EsglBMCSC7/T/CG5h3/w21CjlHqWo1MlL/Bk?=
 =?us-ascii?Q?UPDJ37hs7kIEWMqGs6mYd/PtVvWk9QVEUO/mkgFkbJ718Z+vRrmkjK5vpWjK?=
 =?us-ascii?Q?VyllMu78s8TLa75YIDeBrTHp7FP6jtRBm7MDAM46ncd4R3G5CClCAaeUWeGq?=
 =?us-ascii?Q?3iYuxGVmS79rL5S2UpzgTRV5999Y9YyTU5eGnhfCSmrgxN+rYVYnLWPlMJX3?=
 =?us-ascii?Q?XyU0IKGo4kUP+ZiqAi3lJoE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d600354c-a2d9-4daf-5fb7-08dda7da67f5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 04:51:04.7108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxOXwJP/Z8ojhHYM8uEFygjrCshjZHh4s+PJQ5Y/UUnenI8ZTMa2Zg1hNSeqQSb1IpiMdd0fuYo2cZURFpB8E21htuWQi6+133KHRnK1FjE=
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

This fix a possible NULL pointer dereference.

There is also a risk of memory leaking within the same portion of code.
The leak will happen if loaded image is bad or damaged. In this case
u-boot-spl will try booting from the other available media. Unfortunately
resources allocated for previous boot media will NOT be freed.

We can't fix that issue as the memory allocation mechanism used here
is unknown. It can be different kinds of malloc() or something else.

To somewhat reduce memory consumption, one can try to reuse previously
allocated memory as it's done in board_spl_fit_buffer_addr() from
test/image/spl_load.c.

The corresponding comment was put to the code as well.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
---
 common/spl/spl_fit.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 321954a1547..912bd9c8910 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -703,13 +703,46 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	 */
 	size = get_aligned_image_size(info, size, 0);
 	buf = board_spl_fit_buffer_addr(size, size, 1);
+	if (!buf) {
+		/*
+		 * We assume that none of the board will ever use 0x0 as a
+		 * valid load address. Theoretically some board could use it,
+		 * but this is extremely unlikely.
+		 */
+		return -EIO;
+	}
 
 	count = info->read(info, offset, size, buf);
+	if (!count) {
+		/*
+		 * FIT could not be read. This means we should free the
+		 * memory allocated by board_spl_fit_buffer_addr().
+		 * Unfortunately, we don't know what memory allocation
+		 * mechanism was used:
+		 *   - For the SPL_SYS_MALLOC_SIMPLE case nothing could
+		 *     be done. The memory just could not be freed.
+		 *   - For statically allocated memory buffer we can try
+		 *     to reuse previously allocated memory (example:
+		 *     board_spl_fit_buffer_addr() function from the
+		 *     file test/image/spl_load.c).
+		 *   - For normall malloc() -- the memory will be lost!
+		 *
+		 * Please note:
+		 *   - FIT images with data placed outside of the FIT
+		 *     structure will cause small memory leak (several
+		 *     kilobytes),
+		 *   - FIT images with data placed inside to the FIT
+		 *     structure may cause huge memory leak (up to
+		 *     several megabytes). Do NOT use such images!
+		 */
+		return -EIO;
+	}
+
 	ctx->fit = buf;
 	debug("fit read offset %lx, size=%lu, dst=%p, count=%lu\n",
 	      offset, size, buf, count);
 
-	return (count == 0) ? -EIO : 0;
+	return 0;
 }
 
 static int spl_simple_fit_parse(struct spl_fit_info *ctx)
-- 
2.47.2

