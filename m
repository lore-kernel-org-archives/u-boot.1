Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F63CC5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 18:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C4D82F4B;
	Mon, 26 May 2025 20:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="sC85JNCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9063382E37; Mon, 26 May 2025 20:03:51 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8835982F4B
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 20:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhO0zP8HBMQWpt+oOn1JInZbaJQrEL4XQIpOI4wnQD59H2IbnSe51JdFE2ti4wV3YDQBBNMSu8skoXpolGnKEAT5mTDoP/W6wDKwiMWOKTbeiLLAgdy2gedhPIPUA4evmdxV8m1jF8NKUoEgPbz1sKwp/exd5o6GbdDEaGPhGkjW382o9rClUH/UK+858Okp/n09kFjuVnArxzhkJru42sNkiUIq+r4y4kUIduL3WcJt17iIKuA+6dPPwXRVzpyh5y46LOkcUA7CDXjnyygcS5l/I+mrvyvfgXP0NGRzGt6k2SKpyoOPOAKtJRMUdysd1/lJX7Eyed0IgCYmfJskMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpJgyBBZHyjCL0nixazEc4930dgZAdWG8v5LZfvP/Qw=;
 b=i2khF2Q2XdaCJ7oUk3+rZ+mjxkup6AcIX4YYOIMZyy/W6eeqBSWmQQtvBW2hXciQuzHQBLf4gOe/f1mpDmb9NeAXLimaa2GvVmN/ZC7KGdq0JVeyyIWC19iXX0eZyVnnxswfMkCNwhi52kPQC8fZVDSLRvZ54uRKuwCSUbq+2JEe3SjVQwATrDH6hr8BF1bdmiVUwI3twhKj694bXciWz8hiei+KfusJFsFxoJjOROLg7Ett8YISCZ7mROoI6YmZbfLSO8ujasfFoK820gf50dS7sPlAvG2d0Nkt31e/0wrSz4LK6gPS+qMgbsC6MlYcB68h5Um2g+qdEQDZiH2nXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpJgyBBZHyjCL0nixazEc4930dgZAdWG8v5LZfvP/Qw=;
 b=sC85JNCKiUl9REJGxQC9ozLbC8t8lq95AjsAd8fwqZKZcGMWZG3sORG1o0rKj9tlA4ufWz54eP5Rf5xSdcEtkvWi/pWMSAD1Lvs0pRYJRxrKrP7CHjExnsVxVLWbkK6fNQe1fknHDgrBdecUDX4nKsb/7D/U2DSqRH7ei1wJwdqdTMcAobzRqGQKaEIhAucWQul6Wl/2027R4ODia22fG3SMqJSzcUkjFkGkTCDCACuv56bIAyK7lfIsi4w+dMqbFxU6jVcxfsdwdSp8wK6Fb2hn5hF+68h0lYMe4fQTe2Stf+E2+vdiNa/J7MOlPapG7ZO/Ild+zpi6e9b/w4LOnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by MW4PR03MB6379.namprd03.prod.outlook.com (2603:10b6:303:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Mon, 26 May
 2025 18:03:47 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8769.022; Mon, 26 May 2025
 18:03:47 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 3/6] drivers: ddr: altera: Fix incorrect address for
 arria10 mpu1
Date: Mon, 26 May 2025 11:03:25 -0700
Message-Id: <20250526180328.13644-4-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250526180328.13644-1-nareshkumar.ravulapalli@altera.com>
References: <20250526180328.13644-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|MW4PR03MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: ca052a92-a826-4bd1-1b72-08dd9c7fa975
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qIEu+XD3nX8PKz/i7yaqz7r+4KnFBNerz11aLRP3S6XbOaZkbHQ6rOYkPjZZ?=
 =?us-ascii?Q?CxCb+Fg3zqZzcOkYVjn6D+fmGpluJvJ2PNs35XdeHaGn2emL3SHsZzgm4S8H?=
 =?us-ascii?Q?rYQ/51gFJvaeV0rKYU5fMwbvvg9936DWd+lQxLTVpRuv8PTmUPsef45cGKph?=
 =?us-ascii?Q?P1XVPi6ag6ndPvvYlUMLNHFRKltSi6tE3aJOy8q43Vzk41E7mI92lTBklldE?=
 =?us-ascii?Q?jCdbQ5KPjovTn8EexhNoy62pCnEA8h79IW5Ay0SpBXml7eEySDoS1jR003bj?=
 =?us-ascii?Q?tNphIQGVkShSgjN6DPj83wXFHEFIJk9GBPZRZCvFzYOJY84vPV4S76EPy/bG?=
 =?us-ascii?Q?P9l9qwxzVhV31AAJLcx2Dm6IZZVy3sT9R5FKtoEwXBsKrmI5f11j+p9uhmrd?=
 =?us-ascii?Q?J4nMJv8/EGta+UQX3lst3LgBmtnrI333S/D5qyBnoMXSNQzlBiTOTXcvj/VP?=
 =?us-ascii?Q?52qffr6Vxq74o5TLayIrcmbZMyJH5a19rVzdwx16IZmhTUdmamRdKU1+pqp4?=
 =?us-ascii?Q?icB6qKjY45HYXJkWG66nLnReSMPyiYbOpeQHZlL8YKURz4KrWGDWB+QuYJ3z?=
 =?us-ascii?Q?B+mlrGqF7c+gnlqsG24NAsxolc6vQuk1qj2LVpbIj9V5KN4MhKw105L5B3B5?=
 =?us-ascii?Q?/D7C8rEO2qcvYMnaeLfVKOSGDujsAyJFSgjozujE5i37uJunN3xpp0/O948P?=
 =?us-ascii?Q?fxsJ8aPMpzTCAS1Yitx4+K2VHdSX/qkM4K6jpgzBgTVraFULHu1qzVaCPGN+?=
 =?us-ascii?Q?6WZebWjoSlxbEjO66KjOED0F5/iAt9fJCucuWXmy06NE5j4wULya0WXHWz/i?=
 =?us-ascii?Q?YEh8aK4hWE2rg+h7YNlvRYZd1cSc0WSAb/RrB7vRiLtI2GdLK2N4UH3cJIfh?=
 =?us-ascii?Q?R0PalrxT5WWKotLxiG7cExGPiJAHYsf6aquvwzNTALieEyacbgsCV/pMFlFu?=
 =?us-ascii?Q?gU4fv3SDpued1JLW6ZkeXPtjs6pHCp3r/VEnsTUgsj735LW1Z3fAbOm5ZwaV?=
 =?us-ascii?Q?MYQ0dIWJT/V4lkCJyO8dixkvb6NVk+ahARYemf3wttiR5J5ukwUq6LQM/k7/?=
 =?us-ascii?Q?ByK7Vl23f+cAHOxpESTJPIh+wedMS7P7K65Tus3+of1BxDp1ENfyWlJL+m+v?=
 =?us-ascii?Q?kBL9EvgzYpPqagsjHIIKm49pfBKnVWRD+E6pxJQ7TNTpCBelwbQOSo3WUnRs?=
 =?us-ascii?Q?nYw3pQjs1HGA1Rj9r+L98erDsre2bxscvZsBFfrq1W93gv2rARySMbb6CcyO?=
 =?us-ascii?Q?1squ5+/rDQeu1FnfPvzCm1lrpI67oCZggqYLqP5exxEekwKUxIbtL/gHTb33?=
 =?us-ascii?Q?971hAxo1OEJdleU+QMv49kOlxUNmtctisdB5+is9QaILQi6whU/NBxeMtZ9P?=
 =?us-ascii?Q?Q/7IfmfcJLJcg7fD13g1R0Vg8VNIEwUiMuJB0rrdMKdXSH0QBpsucXPKceWk?=
 =?us-ascii?Q?2/07gouyfuk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MsSmuZMQUSmnJA59nry55m0htk8WS9vfs0Zue00VOPVifeIfPTqSAtoc8umh?=
 =?us-ascii?Q?3KeqCHqH+ZPfcvc8LUgfK87FGSdEwIZVQzskw7fq+cV4nYKdp+0TQjn71adJ?=
 =?us-ascii?Q?UjUSCd8QRlshIgUq7Y3TSg07BaRxZkBslI2ZIU3gvR/LGLf7CQpHBjXYBg4J?=
 =?us-ascii?Q?cndT65eZYVx/s9t2sLZC3cMuBM7RzJdROFm6ugBzTG+g3VymlpzcDEd1xgvT?=
 =?us-ascii?Q?jN4kw+8i4QYWdchGi48f/+VP6B5p35EHPWCiwUIzM2GDRx0dyPM32Yzwsl8S?=
 =?us-ascii?Q?7WZTJBRWmLx/3YLDrt/M+r7JBIpjYesD4DswNeXqmUYFrRqERwkjcgwM00o1?=
 =?us-ascii?Q?+UNzp/Amec/SQn3H9iMVjpxk4O8+U86feLngwordrS16AJBHFMAdwx7mbgsO?=
 =?us-ascii?Q?NkeqPg6zZzQrjaXtKr4wgQTVL/JkofOhUrl+BcQc/k7efRiy4A1LgcjybLES?=
 =?us-ascii?Q?YzRIBIpbV3QvvkOThgxqAlIjlsjEnmxkAx9wuwdufY/jEVy8hqbRPOF7czA/?=
 =?us-ascii?Q?xTRCUNQ2LYb2GjTCYdvn7j2cYVdY/4MUcgIIv866k0cmg8HG8gDn3WWezJeM?=
 =?us-ascii?Q?CwsqwtY1FcG80kKXECss7rVVa08twc8xzd+gUczdOPM2/jt9F4duw/ZO/oWW?=
 =?us-ascii?Q?6DoTZlvhq3DzzLyZIH2NEdFkut3CrOdluPEkdlV4RGPdNF+8A+NN+SyYUjfL?=
 =?us-ascii?Q?QSI4XxIvimCGIrtsxtdz+IMcg8BZ955EL5hXdh3wC/CpyniRxylKOMoaXKHQ?=
 =?us-ascii?Q?W8LEOXiQzFtZrgY5BLVmcRKnWCudFNcGKmtDT0XbssizkXDggNpNNiBxz5We?=
 =?us-ascii?Q?vwHh9HJSJzsXEdgnxv8wuzeiAGppPX41uvBD2iYJYWEi1gXnldbM4xDm3USB?=
 =?us-ascii?Q?4rAS1xwp1sfLf7ULzaWZO0o8cNbWKYmf2UyHZhZl31KpKt3g+5kdcjU7riUL?=
 =?us-ascii?Q?rYdw5sFctfmFOoPOHGFOAMVG4kx6QIxFCmDym4y4aEahXa9mzrjV36nj5u62?=
 =?us-ascii?Q?2j6Ii3wQ2vYIiQf7e0inlBd0Qgm/Ag3b/+aEdzpvVnjCVG/8d9/sW+Nh1agH?=
 =?us-ascii?Q?gaEwd8rFq8JYCn5+pYBU0PGJ+ccwl86A38+xD2WpwJrgyIjbKUXiC8MFTAMa?=
 =?us-ascii?Q?C1RjU6Kq1VEZgmNgQ8/AnI1YUmfU5f0whLkYikotBdbhZr4tpNPejOG5lgQC?=
 =?us-ascii?Q?Ac3oU/9u77JQehRNvQSsEZBHHX8W9xdp7Zj9Nt1aH/TUf59j7fPsctTezQ+8?=
 =?us-ascii?Q?pa9UJ8n7EBTUwH3V5bIjaFo2cS0NsaHxPt1sda0G+iAeh91glXHhbKzx48JB?=
 =?us-ascii?Q?qxGpob1o6dlVj5Gqg8pg7m7Wj9UqJZFKzGQmXyc0IaCMYoUqRzHK7b0fa/OW?=
 =?us-ascii?Q?HdQJ7UUN8YubxnkMAuaqqPwG5nbALutSpKFSK+WnRbc+LXPIkH9tyTXqaFKq?=
 =?us-ascii?Q?E3AqC5CiybWD8/2Gu4kcgb7Ko6zAx2eJkdqokab4+eKcA+Gk7lx7qdjObfhM?=
 =?us-ascii?Q?kmfE9ksonT1aQFhnHOJ8exxr9/gdFjnDT8gO9aChCTT++oZXz3t4GIFv4neg?=
 =?us-ascii?Q?pMkE18zI4LgtBqhVA5wPJ4fQ5L/q6yoETG3xb5HyXV5midmpLmSWvxYzEtWH?=
 =?us-ascii?Q?n8+2ECWmgnBjVPJz1rREBo8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca052a92-a826-4bd1-1b72-08dd9c7fa975
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 18:03:47.5430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3RxUdy1Dvyeu8DPL9XVm63WRtZgbePzH/OorZ8EKp+YSc5eu4+h4ylmNdfs7kcylwUu5GIVcJ4joITrdTboYArEMqHq1XElhd50OnyBbB3/M0POzIlEIYPKtCsYhMhD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6379
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

SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS is added in
SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET() macro already.
Remove extra SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS in mpu1 address
computation.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 7d7bea153c8..ba6f0f4160f 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -477,7 +477,6 @@ const struct firewall_entry firewall_table[] = {
 	},
 	{
 		"mpu1",
-		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS +
 		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(mpuregion1addr),
 		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(enable),
 		ALT_NOC_FW_DDR_SCR_EN_MPUREG1EN_SET_MSK
-- 
2.35.3

