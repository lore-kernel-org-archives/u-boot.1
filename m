Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9944BC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 11:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC4AF81E72;
	Tue,  3 Jun 2025 13:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="C1n0EIew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C27E822D7; Tue,  3 Jun 2025 13:55:04 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9CC7822D7
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 13:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+M6f7001j1C+hL3Zr98h+gr7i3OTmLqK9NZyAFZN+3auIX4Nv47uYFHPg99ZuVKdDgM3KyfFMw/fUde8osZ0YsNjS2gjL050jD6orbuq22c9VjfCAsHjhdk96x6u3jXStcpLmAtbk+rM1gwUwZ33EmIRIYM0kSJv8yUdtVb2HZH6VTNcwHFYDipLsVKwvjz9JmQPyePdlLe5daN3SD3bEFlDZT/JPAJD/57pU0Mpmisaw3Xzeki3vzaYnhWB/xk5A2pT8P0qT/UtPHLZT2GDyVtPXe4Sxj7Yhcr6RLAF8EEFOn+1+PinZde4zJvnftuHWtpMR6v6J6VgUPZGpfZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDO85wbjYwwBjycoc5ThMwSGB8IbBb9mNGV3aGjzRo0=;
 b=EFC2JOpy8wWu3n4t9aIc7nahZglr7eaKvY2nAe9cMubYaKIuLqjy/chAxwtMfUPoKwWCLIcfN8gJtqiIWFwz7txyLAgvjRIAPJ8yxFOqOkNB7JtRl4C2kDU9Whn8TeA75NGNUZkiHyLUqaE8742q7EdYN5vpIHVvkD5HEGcRC808oQoMoFRMkvyJxNecpu2vG8bsQb26+Qauo6aNd0YvBhCRVHHcDTTCANc7CNxehwa9tUpcyR2Ay9+1Fv0q4Pp17ErgUTU4nyab/v+cJX6mUmlfwNayZUwGp/JLd0PDPVumyb0+/tsCaW4Y0wPRxkgZm9yweRh/r2fl8jmd8v+vJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDO85wbjYwwBjycoc5ThMwSGB8IbBb9mNGV3aGjzRo0=;
 b=C1n0EIewabrSgn/oF+2GgQCZD1dsEG3ao3KEs1AmxWImTQ9FcQF3RIDYwhDkcFKUjFXcRZuT5wXs/n+upqRpEAqjaf2uiTsEXZ+OKz2dI8dpSRyySDl3I45tZy/hRloducetwFJCOVRdc4r3BaiFbHY4wiXZMS+iMM4F1gw0DdA81qyA2brZjrAbbAPwpjwab1gb5mV4R1BDgmNpR7LupV3ayoCgyGqfOFlekoS4HUcOFo3FWKv0g+9A2BRJYnnh9TSxIOK0MFbYJaUAuAJ9v+u1jS+8xa5uLhS5cOmKBwyFpW5AevmyGr0TOg4FjwSwB7G5IYjgnpT7TGHckl2B4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by BY5PR03MB5000.namprd03.prod.outlook.com (2603:10b6:a03:1ee::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 11:54:57 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:54:57 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 2/7] drivers: ddr: altera: Add valid RAM size check for
 arria10
Date: Tue,  3 Jun 2025 04:54:37 -0700
Message-Id: <20250603115442.19971-3-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|BY5PR03MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 65ca59c7-7e77-4624-388b-08dda2957632
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?flTH7+jFQ5hfpK5L9YTxrUJJ8ekXqYZyCSClASvACdhBOfH/XqKH2t1XGprB?=
 =?us-ascii?Q?7n+wC/FHZtZRUqmZFrQN8kasu/dCykontSL+Trr3CjpAOAdgYzw0F3SupQqn?=
 =?us-ascii?Q?WQrqTN4QLKj24bM1kmN2HMnAvjJEC7fC4pa+5hKfDO/0dJr/5PelXrXceXqg?=
 =?us-ascii?Q?FGzuHLR+rcab48xB628klMHviUmbPUvbGvc/FeKRtPuJZsFp+RzXiAug2zS4?=
 =?us-ascii?Q?QAGoE9GUPy76bA7X53Hoh9d/YqcO2kc6rOer6sD58ML5FH34S6374NcHvhzs?=
 =?us-ascii?Q?5/5anchp9sUbYmQFKy/c57R/TJ47a7+EP7lawoKqFfR9w8zngBl9yUqlg0zL?=
 =?us-ascii?Q?BOcJvUsTs0nAfQu3GAPAXj7MRLcufYaBg7/gj9nnfjZgi3bBvEwhsSGNuOlA?=
 =?us-ascii?Q?M9XCGwqEukOHGJr7aV3neOStKoedkNszCd9PDhuYubB9/+LjlyukLrFlIXKv?=
 =?us-ascii?Q?rCqmA+Ua3qLfsmGc+FGVWv1qgyjJ7WwBv0hs5qNSLnoafCvUpzEVTGYBh2Ml?=
 =?us-ascii?Q?qSIcR/rRxZAMEChGLwRVlZf5X3i3FhU+mT5WBRfuMwTIdtlyJB9DbuYllomG?=
 =?us-ascii?Q?aHzhc0RnVVx2+lAKzXrR6OOMFsICHmNphT4f42GLjTU/SyJjXp3qsxGXh3cE?=
 =?us-ascii?Q?Ponm93tPpcWE5VKv9G16ufm847L+UlDmQDgPwAmy6OQprwd5nhP5i9Am1gKC?=
 =?us-ascii?Q?zj2tHd9wo33GEaI1kjVTrKBiLOcl3G1oErqKKji6UaxzE7kZg3yX5jQpgaQo?=
 =?us-ascii?Q?pXGH3Bsp+g4GbkGSra0AHjjIHngTlGxsR6Lyj4M63Y9SwToS5/bNnrWR5mhN?=
 =?us-ascii?Q?3jKv6bmfhOUyLG5qCHCMBa2FlSd/mnDRHXemYhhiCoBhBIPV6zJVXgo8g5F9?=
 =?us-ascii?Q?ufR7NZM0oKRkd5i5p7jPl9+CBjFjTDuvMEuKKthAjU/eHCSYpQPdFTUfUiAR?=
 =?us-ascii?Q?p5fW37mnvx+Ia2pLyQHDpNa/wzuYWIDi93TUm46fKvyCLCXhepOfKdJrVMhH?=
 =?us-ascii?Q?LnYCRk6wnmgijuLUokzzQSoXfNFYmWW+st5pgMFUHtYjckQ+bF9o8Rdv+o9r?=
 =?us-ascii?Q?fr4cRcn1ly+3KoE1lV3/NmbTrG0qMOy1RdDc7wl2M6SXwiG3YPE4QZQydHql?=
 =?us-ascii?Q?WM9zHix7GP/3yMQOe8GSN2fOknWBPKR9GKhVL4qoUN/pwGdL594+qAsHHM6a?=
 =?us-ascii?Q?rKTNFpxRFT0ek6vVHMssq9TE52ebiuoqn3vkp6VALR9R4TpEDxKBLqp4WhjH?=
 =?us-ascii?Q?KG4saIfyDOx1wH8JGHEATrveFm683SZotYQ3SadbdrvUD0XK4d9VI4ofmVVx?=
 =?us-ascii?Q?uQ6LwdxrCiKB+92KvvSBkaAddz023ZFNmWHmAxQuXS2jz2k+JlJekArrtDjy?=
 =?us-ascii?Q?/dYrEQkfNXYaLZgU4pnJ9ZEYXDIPQHur6F2JcybqCFy2mXnDzS08z0VDuMvR?=
 =?us-ascii?Q?Pyi2DaMs+xA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ixj4j1NLLjAZEv69TF4IdwNNga9qVdnaVJZs5rdqZTeAgRc6e21p7ITmSN4N?=
 =?us-ascii?Q?9kkesWhIjVbXD/HA2fJPxcaQWSHZyiavkmeYudUtbNYbYSdzrW6wLJN+Ykpi?=
 =?us-ascii?Q?2DMFyGBBURoHY/Vl2+JRXJPUPCbggMSKwl0IbLhV0WPzEN9izAE5F9PUVDqY?=
 =?us-ascii?Q?xgaVhR7K01/+BCujLTcKWx6Uw82yHOEg/Q3aiivVjuhGYSFFKtTOvZm50xVz?=
 =?us-ascii?Q?c1pVSU3Q2Jb10s8ZRApzGS5zV4sT728XfihoiVRWnibNP3qofTjQ7ZJkGvAe?=
 =?us-ascii?Q?gK8KuaNTdvGYVTdjLBbXLwo7wSoXR3zUZ+ObMliK+/nUE6xjUO7k1qQMzDsn?=
 =?us-ascii?Q?a+bvAyzQW7In+dz9fvZRPee9PtNFkOu+vZQq8gnUVo1/76LmpnGXBb/ltvbf?=
 =?us-ascii?Q?47BuOeOT7iJnjLu+NORpU0SMluIw1QG4AO0SUZglm3zVRdrRTQyh//cDhEOu?=
 =?us-ascii?Q?0y+cOyWCfrjyX33PA/1Y4ndff5QlMRdUYJzUyYSgmxBQBNebgcRCVUYJzwGa?=
 =?us-ascii?Q?vmfuzcT0FAXlK0HxMsI8NP+dur71RtGyH8v15Yv0nPRnyNLkf0ukqSUZw4Sn?=
 =?us-ascii?Q?YVRoXpfsioSdJTl4utGU9m3SJxFQVX7T9Vf3C15ozOrjcEg9xgLvPX3JOJxP?=
 =?us-ascii?Q?qIzXeg6SGa6pUvsqa7JdSwSXaGYhgp0ZTpCUtnG6hcC6HqZNddnfxY13/Fuh?=
 =?us-ascii?Q?O61hmrJAgdKgVdjZW9IMKnXN/YF0EaOaD2N7Zv2gj5MgcuUu25EP9JO9MU3H?=
 =?us-ascii?Q?1ECtt7qmWNasBjbjEv2foHZeUJXui0pqh8YTBLYTlByd7vRISdcBKHZsgJPz?=
 =?us-ascii?Q?ZpioVwjAaHYaKEcheoQsUKZfyyjplubPAFQZ6YJRBFdMAPOgJmSdOg8TEKe+?=
 =?us-ascii?Q?dQOuF3h4fmDH424zLcVMwshHlAFw6AeAtycBfmqUH/lfzN9tKR4oSIte6yyd?=
 =?us-ascii?Q?V7EWknK8tPnEdR64mcqJVVsee+Hi6eyalcFqolhtQhjTeuWvdGi28samJJmb?=
 =?us-ascii?Q?nhyCQRof+auK2SWru+bhu69KTm1+UdjVK0Ks3Xka2SuTe/w3y+TCzZli1AjJ?=
 =?us-ascii?Q?QHPJPu9hmwMD+wu7vqK8zbV1EZTdGn6K6MjBfSYLVMwOcP+eKwmISgzYBFaB?=
 =?us-ascii?Q?rMwT3E47tB4kak9dufYj83YkCtLbgAtd26O1CzGLa1FRl267nvJdCTFY58Jq?=
 =?us-ascii?Q?rZpBECamIZrhgJrwHA1rQXdyF9476tWJYY60eAdSBNLqCL+RYQiSXJw4tN26?=
 =?us-ascii?Q?m9hUosdZQytYOTaQIW9Wzf2BtNmmH6oNKtQoqAHVOCM97Yw/N0kgiYddfhKl?=
 =?us-ascii?Q?6XH3ja+mJ2UqQYF/NA0lI6YyUNnqdFgMQ+eVR8KGltdjhB2qC59m9XshpGHP?=
 =?us-ascii?Q?EvMit1arqeiuY8X1Hrq01BL+a7TgSKy6l3kAy6Ut3dpg3urUS0IsN0fppGUL?=
 =?us-ascii?Q?Lh5JTTmdU9GS7/B32aHJ4pa9oEMUtkgrxuToVGjz5sGTUpvTsuWybKfx68bT?=
 =?us-ascii?Q?KkA0wWE9SeKungReO8qvzGfv+/RNXZS76+8fgbIaVemAYInn8DzptIu1jI52?=
 =?us-ascii?Q?aLYMv+DjbNg+c/TGxcEpx1H6EhI4IFceu6GcLMxv1uTDVYqwZvGEiuwx1GDL?=
 =?us-ascii?Q?Mx6GGZvY1y6taFISYo44S9I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ca59c7-7e77-4624-388b-08dda2957632
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:54:57.5276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfoZ30DQZNF68QoY8RLRhLSZpCwpgChhpvnNBfN5Q72K2fpiipEpf60CsDTlRIC6wTZ5kAxvTuqdt0wmlvR7QR9UuuOWVSA1DJXOu/g7BMfNw4KfToeLHVvpg3QYKbr2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5000
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

Add call to get_ram_size() function to check memory range
for valid RAM.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 088dc1cb33f..7d7bea153c8 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -22,6 +22,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <hang.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -668,6 +669,22 @@ static int of_sdram_firewall_setup(const void *blob)
 	return 0;
 }
 
+static void sdram_size_check(void)
+{
+	phys_size_t ram_check = 0;
+
+	debug("DDR: Running SDRAM size sanity check\n");
+
+	ram_check = get_ram_size((long *)gd->bd->bi_dram[0].start,
+				 gd->bd->bi_dram[0].size);
+	if (ram_check != gd->bd->bi_dram[0].size) {
+		puts("DDR: SDRAM size check failed!\n");
+		hang();
+	}
+
+	debug("DDR: SDRAM size check passed!\n");
+}
+
 int ddr_calibration_sequence(void)
 {
 	schedule();
@@ -722,5 +739,7 @@ int ddr_calibration_sequence(void)
 	if (sdram_is_ecc_enabled())
 		sdram_init_ecc_bits(gd->ram_size);
 
+	sdram_size_check();
+
 	return 0;
 }
-- 
2.35.3

