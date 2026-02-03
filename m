Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C854E8305F
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:59:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC2B83FF9;
	Tue,  3 Feb 2026 08:59:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="JwkX6S+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0A784008; Tue,  3 Feb 2026 08:59:45 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012042.outbound.protection.outlook.com [52.101.53.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B01DF83BC9
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpteOy1/gyHIi02bh6Sa8X8IQ3QldSrhIFHz3SjQgsyu0/RvbZDvwoFp32uysRlV9udFlnyxFsimR8NTRi3i2S6itQ6TDICIJRyZlQGoWdBWytOqbt3jyc2ZePM9vdZspix89yXgqh9STeUQtcppGafHuNKE/H7gK27uEi4np3pDEkuOV0BVzgy1moeWRCz9WWM2gAl2CL6rOqEMHun/8k9PeVsPurm5U/dyNYWKWoZnOwjg1U0fVvQccFqxR9sj6+3SAKYRJL6hORpqN9EgwYnjO/M9yAk5iCX8MzTMWlycW5JaQ8oVlD8UDNIYY7uKpAI5kCf966W/y5LgamftHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15ACQyKRiDHnQ1zQeVqIuolN+pKchQb8yotRv5NGSSg=;
 b=PuG/kcj9+VdyS/oJm6yHo1YHaX07+JTnF1t3FD4CGls2MUs4JGRGo4ONMssL+nkXFBn/Idf97HnUqibFZVaNt4n3aApvNQTj/u3D8oL1WiCqU2z0pJn5AX83VMFc/zh/vyEKOCp1vrh3yPVU0j+RJ2tXD5lZYe+3EcIvJUyrlxxWu7WYgNfdccvBhQ22CmsZzZw9p14ZqNNu72xz413xVfeSJNIovlEEJCXiOPo0/dxLHT/3Ty8r+UryzXM1DhZOhOilnv1e0YbVhVNrCj1i0Uquu5uBLgvf4zKhrvGNvNJLQzqYuMU9mscybg5kUa21mAOlHCWZjpvA1QOzhnnbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15ACQyKRiDHnQ1zQeVqIuolN+pKchQb8yotRv5NGSSg=;
 b=JwkX6S+sy1u7/KIjB8ze+VIz3hMOER1/WljY399NXrPS3XMcpGXc1xj7vI8l8jmcmxaFOzFX6K04AY8FbRT5MBea/ZHAGj3eIa233B/Tq6xQ1DaaMjN16Jf1K7AvU7McwUZ9RU6yRS4xAyK2BAZBRPKCZjhaMyXGyvm7hP7JwsQSSEzIqYLdak2U7+78OuaHealEZY0cPnBr10PYH5Ezi3RLLDnWqZ6JRQXrUrjaIF3AQTSJdMs3I1UmF7W38m7AYuriJPBvhstfVrxUfJEhQVilg7F3lZXrHgT3OKMC1dIFQkIDpx5qaAqB9RxtzrhguFracspKXO1IJPZB8gy5mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH5PR03MB7791.namprd03.prod.outlook.com (2603:10b6:610:211::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:59:28 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%5]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:59:28 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] clk: altera: agilex: Exclude AGILEX_L4_SYS_FREE_CLK from
 enable/disable operations
Date: Mon,  2 Feb 2026 23:59:24 -0800
Message-ID: <20260203075924.2492-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH5PR03MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e87905-1133-49a1-ac79-08de62fa2795
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DoRNAWbTK0pJPJyehF+ke/Hq6ajHECh2+xezBSPG1PyT1lP/iTRbB4YUJwjA?=
 =?us-ascii?Q?numC+yhbDJw8FWcXTt8WjuFr+uOFlZH+MnK/2xwswP6CRyMDqRbvRfNCHbom?=
 =?us-ascii?Q?h7VYY2F9zbdtgCUIQsNO74Wm0GxcWfOwikWTTDTMjtV9aJvFL0Rxt/opEdor?=
 =?us-ascii?Q?XY6Z8b+83YU3F33BReLRbkOJhNXUrn+D8d6Pm3LZshnwxp3WucEwaBP68j6m?=
 =?us-ascii?Q?HOoomtxqM1ubYRnRAFldkj3cqO1C25KbR0mnnFmhcaWjpx9c0MXCuiSA63jX?=
 =?us-ascii?Q?PbbojtQK/5bH8E5OJt2yqYknO6v6j7f291mYfPKqT58crwLSdf5q2DOjuPcI?=
 =?us-ascii?Q?g+AmBoM0kr4IdDIO6oc1m2pGE58k/F6/iUi9KGSTtWt/QA4tCkspRwM6vdqN?=
 =?us-ascii?Q?LO3MJEA4PgbMqItCCEy1JimJZb9a2MgCw03qLh9xwAAVXhGXtIC3EgKfXoIv?=
 =?us-ascii?Q?KUdbKl86W2gR3BtsOHCjD6YWriw8+m/LOo3g8fXdy3KhTrzc/Qe16KHNuBdq?=
 =?us-ascii?Q?Mq8tc7PqxEsj2GqNsG+I70XWmwsTJ8poPJFuPGq9UFmAErOYOQUnU5bQ8F3p?=
 =?us-ascii?Q?fGFQr9jz5cgBr9fuYY2KQvnAvSnpH83hfwu4Blhs2Sx5LOsy+Dh1Ry7NxPeL?=
 =?us-ascii?Q?4K2MEn87RB1DHLPgXcJX4eVqnZvmU62jm68kFBS1tjAQU4ameFfvqHXoOGoV?=
 =?us-ascii?Q?qtkVVr3Cus7ZqrxLkFH5sGYDnLdLX7PGdhJjTJQZv9ZVkakVq5lxbsNNn7N/?=
 =?us-ascii?Q?wpdC3HDyLD8ztTfjUZeu8VUmD/lgHjA9jkwys2sRASo5E0JIWlx2h3bivFHq?=
 =?us-ascii?Q?8rb8h7rz08OAvXWPSYtWZZVO2Qv61mvXG0p/mIDkh9JJ99Li0KnT2SMqtW+6?=
 =?us-ascii?Q?tAagyGdlhL6dBttJYiT2Ptk7TFuRjCr+t47Qb7wDdxAPcgz6ivBbqAmWqF1x?=
 =?us-ascii?Q?kXLoumft+HcZTf8Z9dEhTBOWqTVEzcXnNgO148YVbI7wg3umrWLcaJzLpoxk?=
 =?us-ascii?Q?DOaZR7Hkj0E9v6YDb4oI2zJrObfSHZ71BbPfTwbpwhGICv8Nj9BypMOb1ZLk?=
 =?us-ascii?Q?pThIYvoz5+v3GwRzNB1yiMP4nlQvEW5a3gIqwqVvsdSXcpoZtWmt2SXdRxF1?=
 =?us-ascii?Q?LSvn7qUuZq4RRl3NWv6RDcjuVOAQA8X987waTUhGMH49S3T90Qk+Se+9AhV1?=
 =?us-ascii?Q?sBfpiJZdyfrmaTPrt2MqMzIoKeTrHp+v0jnx85nF0CiPp0n7wsp+u3PWk6G/?=
 =?us-ascii?Q?5mLehxyj3ydVyh7XmEsyoiQN0rBeXOatBZw1g94op396bEVFYxp6RD48/Y62?=
 =?us-ascii?Q?eqmdqhDuFoNSHMDt/2fnMH7Jm2gJdEMqa4rj+7taB4c5A9fMvGuY2yh8B07T?=
 =?us-ascii?Q?CM3+L0F6Z2o0HMejoLcTQijRSmPKvzmCzPxgRC8b9EyzdKtW9HlDoyg1wasn?=
 =?us-ascii?Q?Llfp5z7Ri3AbXUMBpXVaQ27RYKih7N0PlPb90GpZ6FdhbaczVb4YC53W0sn9?=
 =?us-ascii?Q?3BKG1Lu6HHNuQsj6IfKukoEAq1NVudTmW2jCuJAHg/KwQePsXHwSNke9tSuC?=
 =?us-ascii?Q?trIYw8k4Q/S+QtDpMHI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QayMIhRg3oLOP8qUsUldQ2oLWMe/ySAUMFmDgC34t/Wg1xQPl3inda9zJPZk?=
 =?us-ascii?Q?iJc2KljNcIV8+SH9iaCGb4ojKPZOvsk2pmoAyAGFznQ0S97SD7X5pJcRG+P6?=
 =?us-ascii?Q?zHOc2ixKl+NOIhqky6Y7uXHA5GqMAZSb0ZEZtyIrPEaMnTMfEbTyfN5shv3j?=
 =?us-ascii?Q?bpEqbGNkPiJYBkVfUzsZUMZYeBWLkjxLjvfjteidn1IVTjPqS/Wy5t9193/e?=
 =?us-ascii?Q?5h2evZAzxreQ/jv0vnx5AwnQWj621uYpDQJWWKecQgcrJeCnLMKBPuw7EKMz?=
 =?us-ascii?Q?3wPWqnKwiaD8cdrNoNRfXZmZ8m7MBkj3590GdCFHH5kDmQ8n5cTRbyihwNW+?=
 =?us-ascii?Q?xmnW8XdJc6IfeGPNavUaEDVuLVsibvJ41xE3tjgURAEONkkzOtQSEyX5DTKW?=
 =?us-ascii?Q?QGuNwWodZkrLKGDU9bIGWlj6idec25g7ihq8HC+zVybPCF/vGSeE7xv/iYgp?=
 =?us-ascii?Q?mlviOuVukmduvUpMBEGqa00+CtsuzTJsgch37c8LAvh1gJdRmoOEvyMf9MSO?=
 =?us-ascii?Q?k2OJZRuuI3UFqVLEQQrc2Buoov/LP3XRVu53TTIHQO+3XeJ+Hz5H2IRsmAvM?=
 =?us-ascii?Q?ROLwyPPg8IR8mQ7+mFvJcxTm4AFhV6l0Y2x8uwEmmM7MMDZh5TPUyXbw1QW0?=
 =?us-ascii?Q?rlGU7hEbq6ed6hN3/4x07wHpigdsiwC2mPN1k3H0imlhsJBuZb0NU3uuQg3e?=
 =?us-ascii?Q?GPuBDmN3dxc9lrW82SXCXI5xBZupFQSSGNvic1YH5VifkgAZTIWhG1pvUNEA?=
 =?us-ascii?Q?2pgEvEpYCeAc0Ju95D0zV0W+XuElc/kdMG6fogFsoGVp1O4VjBn6JCzcXmFx?=
 =?us-ascii?Q?h3uq/zWaEjOd6NpmRGOIAdXB/LfFN+h9tdZMjK82ZvEzZWoNqU4zWmEPk/kO?=
 =?us-ascii?Q?sm+J1iWralC1hKmv5nnhaPX49JgZ9nsWmR8mLDK/nKC/66fuRewiSVGpL97C?=
 =?us-ascii?Q?WWh6KPA9ODsWYbFcWPmFHOv+FRUJEJci5uxAWqCcK8dX7jNCTGfvtdmAWj4H?=
 =?us-ascii?Q?xMDTxDyPSJ8Rq35Wq/6cBY7i7lQlx+8AkKtsqXXrtNxNjSAu4/lPbOI/9n+t?=
 =?us-ascii?Q?ZXjZKsflvjbnjXOni4oR+8+7R6xA8SLOoZlR6JaBK8Mtb8UJVjNezktc63U2?=
 =?us-ascii?Q?Yr9t01J4lkvKsxLrjmxB0+bBj2EjY8/yjssmw1drbyfxc2yMKhI3GKO7QLUV?=
 =?us-ascii?Q?5FMghpM6K+hcY3i6ZLuCPoUg9ol7/cCnslKG1TzzJm++vQl4N3a0Jl+VthXG?=
 =?us-ascii?Q?WQRtqxcJnUGfbCNdRc3XMSb5q264e2ZWMISx1aTJ9826AtN49gzSK4qVDzc+?=
 =?us-ascii?Q?+qqFSNpGdib0JgUlZM0gmbVSfhr9ESNhWepuFWi3F3n4EImF2GChHKoahrDd?=
 =?us-ascii?Q?/1Up491CZRyr9bvvvqNLTTj2kd9mvoyqYZxN6eZUvJF/D7LuVC0Bufeipaaa?=
 =?us-ascii?Q?oZOnBqspbEaL5Zdyy5exdkRHUXsGexfFquoFVgkAtDfXk4ajxCRXp9dEtnAS?=
 =?us-ascii?Q?CU4gGoWwYGNs6ID3cS/D7ql81FMa7bP7hsX8k3tTQOMd3J48FsQUroN0rYqz?=
 =?us-ascii?Q?XuRy8yaVLKTYiPjv7J0zW9l6t/lqUmmtCMVD+B/87fOkbcAm7d5Hjf5PwRUp?=
 =?us-ascii?Q?ebFt+1qjYinaQLKU/KkNRRIOx17Br4I+4SWwXYgnUzXABPEB+QtWvkvS4TfE?=
 =?us-ascii?Q?JC7jd9s8+HwOkYTSLAHhDAhs1Ma8DdqPcC046tA94yxt6ucwjkfCjE3opjMH?=
 =?us-ascii?Q?dHZ+IZbeXKC/UfxPquu0gOhy7qAyuKw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e87905-1133-49a1-ac79-08de62fa2795
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:59:27.9926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QPJUXA8e3xxLR8lJo8k4xzl5Z344+c/QxMTIEA7kQfXv6kttiUScSgjjs3OpG9f+A4f5fcF73H3AQToCnEPcbXLMzPNLiDDt6yIZndZ6Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7791
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

AGILEX_L4_SYS_FREE_CLK is a free-running clock with no gate control in
hardware, therefore attempting to enable or disable it is not applicable.

Update the clock driver to explicitly exclude this clock ID from
enable/disable operations by returning -EOPNOTSUPP in bitmask_from_clk_id()
and treating this as a no-op in the socfpga_clk_enable() and
socfpga_clk_disable() functions.

This prevents unnecessary register access for clocks that cannot be gated
and ensures clean handling when the clock is present in the device tree.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/clk/altera/clk-agilex.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
index fdbf834bb2f..88423292c0b 100644
--- a/drivers/clk/altera/clk-agilex.c
+++ b/drivers/clk/altera/clk-agilex.c
@@ -728,6 +728,8 @@ static int bitmask_from_clk_id(struct clk *clk)
 		plat->pllgrp = CLKMGR_PERPLL_EN;
 		plat->bitmask = CLKMGR_PERPLLGRP_EN_NANDCLK_MASK;
 		break;
+	case AGILEX_L4_SYS_FREE_CLK:
+		return -EOPNOTSUPP;
 	default:
 		return -ENXIO;
 	}
@@ -742,6 +744,9 @@ static int socfpga_clk_enable(struct clk *clk)
 	int ret;
 
 	ret = bitmask_from_clk_id(clk);
+	if (ret == -EOPNOTSUPP)
+		return 0;
+
 	if (ret)
 		return ret;
 
@@ -757,6 +762,9 @@ static int socfpga_clk_disable(struct clk *clk)
 	int ret;
 
 	ret = bitmask_from_clk_id(clk);
+	if (ret == -EOPNOTSUPP)
+		return 0;
+
 	if (ret)
 		return ret;
 
-- 
2.43.7

