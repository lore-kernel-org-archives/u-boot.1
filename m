Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE6DCCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 07:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37FD683EBB;
	Sun,  9 Nov 2025 08:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="NWHeimNf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E4683EE8; Sun,  9 Nov 2025 08:07:18 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB5583EE8
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 08:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oefvxURRGuIA5FyRJKQZAl6DYJWvSAkeBpAeOMDhHwHKZ3MwQWbmdzSuBOkw67gNyzqMpk2dn3pT8gmM7JKbxfHsgcsOkKrdGbDHZau8rSPqmH7hDo8b9pJT87wf+Jn8u8h78ysybtTH9rZBW4UUoaBBtvw2ZivJvAqyZV1QXHOHMr+h1sGhWXlalufKvOX1O0WjIVpVhetptNYwyIbhFBbdc8VL4YBrc94W8X4eBq4AbTE259HbTteo1JJMJWps4KLssOZNiQlD/iI5QImJshd1VGgmuAw4irofoaoZ3RWDrtPusu+JbZ/HtSEt5ebbapwf7zGB7Ocg1+RuzgC2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipBAmxFALFWIX1FBcoS7IK+VrR6wQFGnRJ6dcd0UmCw=;
 b=TabRSxlbcnFuEwy0p7UgU8CVVjip/h5jEpOgGVce1/bWbpJZr5sRYs6jjCjAHmMDZAt/msrsixQQnlmhdpyptBOAzqPxUmOuFuTiiZwhxYC38S2t/0fxjcrnVBW6Cu5LN03k1QPCyi+TTKa326VxaijgLm38dfa7DCQXMSDBAJKdBhe4sYnEkEc8ieFxbLi0GStlH0hHIMtXnLRVHqz47NSDOlI5hOxAVOxf925W3dZN4NKkrVTQY57+6ssSJvVv9iT9tdEULfhnvoeDLDd0QtCOSzIX2fBcCGKrKkCmyzq945HGX5vukWVU9+z+I8eStyGgFglLSyDHex9eD6ohLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipBAmxFALFWIX1FBcoS7IK+VrR6wQFGnRJ6dcd0UmCw=;
 b=NWHeimNfXqlRhKUom2yZDQqvSZKisLw7gY8Li75oL+NQsu40KwhDhiTyMju08HLpmZNswMOJgfqAFTu1bbNb2hXH49LF2YkSe36qA65QOtPjby4SqzVxhI52Ty128a9PepAWkj1P9KVk3/IzUXEcz8QHcplMOkBje1+eMggnE9UcqihjVmFH5zi4IJrKprOfoMneCAeeKdRMV3vALK0Qu/iCT81d5EjZkkGTWl8ZRJxY4tSPwVMJz5RzSuKdEZ4h8P7P5yo2IE2puIgxjZgYRImbxazKjoAN10Jg+ah1lY4+U5/Od7+Vrcwtzg7DEI65A909iX7ju4pRgHKPIKP/TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB5945.eurprd08.prod.outlook.com (2603:10a6:10:1f7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:07:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9298.015; Sun, 9 Nov 2025
 07:07:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 04/12] spi: airoha: return an error for continuous mode
 dirmap creation cases
Date: Sun,  9 Nov 2025 10:06:50 +0300
Message-ID: <20251109070659.801344-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251109070659.801344-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 85848dd6-97e4-4364-0ddf-08de1f5e9b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LdQ10W4m1eglTK4Qwj3kPS4V2o/vXCAqf+cdyxr7rjaNuax5hRN+DcgNVp0c?=
 =?us-ascii?Q?u24MpcFAL24UYENfQaUU1/WM8pQuceusbz6GmtV/qlflfMbqq5SzbLCcilsl?=
 =?us-ascii?Q?e+qs+o6IYCY/FnRv0eh3JTu7m22nqmuUMrTjWQk+lGqxLG8aU7Z0D6x9KQmt?=
 =?us-ascii?Q?Kn2zbvFvl/T8lRjJOAC21LmJZAFEqi4ZT7tsRXTbZrqxCTAqI5I37Dd1ZmaY?=
 =?us-ascii?Q?0DVj5ybpVdTtN0c0Vnrdw5UM9AnRyXWiWhvJttcNtZtAWbGWbbbuUvJHcWjT?=
 =?us-ascii?Q?HXnrx0C0y209qgCm46DiwtN+LKnvDho8imeLaUHVbAFYLk2oKMZH/i7m6wfi?=
 =?us-ascii?Q?+/LMU6XPEM3M5X/cKBcxGm1c5QepOoauPcZRHP3FVJyuuO4ijP0TaP2QDMXd?=
 =?us-ascii?Q?oyb2/SnjOQa0lUKX291s95FJVOWfYbm7oxy5kNSbnJITviNdqMRlLtW98fDE?=
 =?us-ascii?Q?kBDLL3TV8L6C2re1gyh7UOelPrFzj1WqO6vg1KXNnyBH9lalKeUM7ZK9l2NH?=
 =?us-ascii?Q?Rz3lg9RvBEYStJmXvmidqx8Ybwo13G0Uoggj2EyL5KjWXNT9NhtFc6v7l/b2?=
 =?us-ascii?Q?G38YMqgbCMvp9yx1B+B9it/uWgsjlXW82+3QacMqhDHS15qBhARgJ8MVj9rU?=
 =?us-ascii?Q?9OTJl0dar+9tGlEWBo3r8PPuz9ROeZN9MJgfHOcVc2Iw7kGGS/VU6g/OM5cX?=
 =?us-ascii?Q?xY/Gq+OpxJ4hBa54yu9RGSPAUztn09rly5P9N4EYQb/oVf/w0dBhcMoJli8x?=
 =?us-ascii?Q?XDWDj9+Ewpims/3OEYmROkMbJqxzSN7fKBa8ZVQp40wDIwKRTcvHk9G08bSI?=
 =?us-ascii?Q?/bCn6VfVJGSsQYG1l1llO8TAGo+UaavmbzfwWnY+AKx7HVE5q6RErZHSc2zx?=
 =?us-ascii?Q?qDrgYBM7CBVoXLlrH5TcdeiBkHYtqQIQdzBMDGhuEk+rFwfj4OcCEqtw7dOp?=
 =?us-ascii?Q?h0R5WxN6FUrAAIjF6j6EeCTupvSsgpThyZ0dZh/CkNFgZVnCH/8fkd47MIVJ?=
 =?us-ascii?Q?60BcsqaoVly6DAB9Zf+ErlxeCNfSViXXu7UIRh4nTwPbhv1fmmlt5BH0F1Z6?=
 =?us-ascii?Q?cVIdvjlY+ehcw+ExowKKpArs/Q4G252gkjBCkdskxIK2f05I/LvxT25OopML?=
 =?us-ascii?Q?KZfZFRLUXM00pniVqZfNKnMSlUu8nV+/kJZ168g+aLtaWKzP7HP8yB289Rfh?=
 =?us-ascii?Q?1uuoj4jUok4G7+3Djod+dzQlO24ytZZKjutHP5Jkynjr1e98NZnYs4S6Fpx0?=
 =?us-ascii?Q?xMgPB8dYGf6QJj0xtz6AfPwQBKFIzpNQuUKQj+S8O125lbil0Fe97uXFU9Gh?=
 =?us-ascii?Q?Y4ITYYcqVZ5KJXtXLf7rnvMuAYS+Iv8rOid9bgQYlepf6oRIXOBCtAfZqCtT?=
 =?us-ascii?Q?+oynGkNrop3/hDvDq4S3aYe2KA50vEeC5LbeR2qwUbB+78F9UyhGmtvLJ0UD?=
 =?us-ascii?Q?pDnf7BRLDZmXJCF+4C903rDTXfgDE2LowZHkVOXfWRrkAh5Ehq9ZrpGoqExL?=
 =?us-ascii?Q?rFc0U3YH5TaeV8pMDLqetZJcWe9ySk8qTNC+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2BvSJJ349pueDWtPUE6HF/+o7ogQP4wbBoxoHZAkoXBX3xJTfxzzKCALpNfd?=
 =?us-ascii?Q?xShvxJAOzQlxg02uLCkMMVfxzCccWsxf56v2ydWf+RhUlxebX69QSPeT4X2m?=
 =?us-ascii?Q?vb6mT8mZY/pc8PhNopdb6yj6OXCZKBcwlO5e8gvzKH8SziOuSZHTRsdadVHM?=
 =?us-ascii?Q?5xvKwSwZrvVcJ3tnGBAlVTf7GYA3sIErHoVTRwMlSg6SnNUuOCHYyq1qf0gM?=
 =?us-ascii?Q?6BGhZUp1CNaoflRG7S0b4kM53Rqljj35BdbGkQdfo5rUXp2zlf86T4n+5Li/?=
 =?us-ascii?Q?PGtDvGlxOzd811dM82959oSlUk9Ym8FiLFDVojpTafdciS2CNjk1TYvNOV8S?=
 =?us-ascii?Q?qEgCtsBnc5hkh7ZFCrrcrnbEDV13S36vUV56NhfnKl4za/8m0f/yKP+SLQd9?=
 =?us-ascii?Q?PV7EZZI7H33yMSK9IuRsDxFJQfKa05VFNOYht4WO2/sfSIbYO7t8qWNKn4Dy?=
 =?us-ascii?Q?HKEBhrEvmmW+EKubPP7jGgXYs062kwjzvP+sOkfCvr8vyTKs9mRQHyDVIdbS?=
 =?us-ascii?Q?6xQnVhAfnF8dcnF8VyKpKr9Qn3JtF+xZUBLq7+kkOFuFr+rVDbHyokLq+cCz?=
 =?us-ascii?Q?D9XLt1CROcDFT9pHnCRRqKZkR81FHwSMF3w2BtPRz1t9P25tmFJvinwVAGMu?=
 =?us-ascii?Q?BpD5Ky1ndSCA/691cpALuqez3guVRjbvpaKMC6kOypBG8nWWmlertQYqxz6e?=
 =?us-ascii?Q?4/wTq/R/BRmQCA1deghX9dkIi2b5rYD7noakts+A1F+J0s6kVE1PMZ0dF67W?=
 =?us-ascii?Q?91zSIxJOxbZdAZtOixrFl1vUfj8ajcFMDmEjUKoMbIxTfF3pxBuWum0oJtdm?=
 =?us-ascii?Q?xvQUPOheQxW+OaBWkp5yctbk2ZZaS9L3VQnEw6vvUKtEI+dfyC0iRDoDay4B?=
 =?us-ascii?Q?qvRuTFh3DziTE6nZXGDCAPfGe5ArD7Yc2Z7u9Z0Bu96hCZRdfdbCRp0RrTdI?=
 =?us-ascii?Q?PsJ7fwTACnmdzw+k8Y8yXdMfiHnyjWZFHpx0Jsp/PWwQVVKq6ftC0E8tjhH+?=
 =?us-ascii?Q?KdfLYXIqyn+bQytTVE01FQ6R58O3KX+BZek9Yu1N9j1QfFr+a842FxXTYnV9?=
 =?us-ascii?Q?CxCyBiJv8pzvPZXtMxybmBFfNFBeDJkt1vvKIIz0BZ4TkgOuuayYIzambeAS?=
 =?us-ascii?Q?6CHJFDz26mm5EB7uZnzMxm9yPNMYqCjIM44115WzjRikr/9q8q+dVzXikJdW?=
 =?us-ascii?Q?hf3jdyUfu59dxtQKW1ynTjxNCuSjR/KQCkRh9czPFBP5xvNEMRy/PkOg4Q4R?=
 =?us-ascii?Q?3UqOoMVv9sR6G/p4w9sY/tfFN7cV3GK3rWs1FTt59w8YLMINl40dTqTo1cmk?=
 =?us-ascii?Q?73gnMdy5gyzBFd1UGDyyPE4u4pwwbGsTyTJCdwQMx35YyN8pnmK6927mkxg0?=
 =?us-ascii?Q?njP35whSMt8bUv4EdKiwuMplqq3aIQESMJAQz+Sz/HOog0bvufwVbcFiurw+?=
 =?us-ascii?Q?pDO91APxDgKzihoXB3expfiQYgC6fX2CPtu3VmJSQaizTnSJ/Wjsf+DqpfBQ?=
 =?us-ascii?Q?CeUsnWrcmlkNQpeNCySh1H8OXQ3tNZSiPHHPdtiF6GHca2BBf/TwqUQQG/JX?=
 =?us-ascii?Q?4R/kw7tpg8RHp1Q6/iHDpKwE7u7ccZbRt5fcRX/+7csJCW2eOFaWPuShF8dx?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 85848dd6-97e4-4364-0ddf-08de1f5e9b78
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:07:13.0838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS1o2YMNQA9Qnab6IzAgEI5WueEjIDEJsHiJr6oKqfmDirGh+aYv3H4NNwibozA4RswsLdDm/eGjyHRCEHsMALItwvzctg6araK4zbkShj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5945
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

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/airoha_snfi_spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/airoha_snfi_spi.c b/drivers/spi/airoha_snfi_spi.c
index f72d11f5b19..bec4ec0bf00 100644
--- a/drivers/spi/airoha_snfi_spi.c
+++ b/drivers/spi/airoha_snfi_spi.c
@@ -630,6 +630,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->slave, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.51.0

