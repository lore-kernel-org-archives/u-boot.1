Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3621C87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCA60839B5;
	Wed,  6 Aug 2025 07:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="vkV21TjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D46A83979; Wed,  6 Aug 2025 05:22:49 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D47783950
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 05:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPOwv5CsYX7gFWPSMga56T1drMmbc8zwQjj8tlLzNixRxUl+okat+EJRaPGThTO+t6q6w0Al0wGLm8UWyVNiUc4D1cC8idz2PdjxTknauMwQHWJlodkK46NQK5VOkKzYD0eeHrwruXZKSoYct1v9YayX5qACfucV2g2EqXl4vqYuXE9ZPE7KXs9nMf3kee6H5ynOVv7e9gUbCyMq0gfvF+L4NsOMy5bBEWnV60UGKV9XxynaB/pVGjQaCG3XihpfkAFWAutd/pBuqzyRVfDr3XrhIF0N40SqOpVB+zGuW/h63iyhwFi8fy/m8grpB+64+KarU2f5wz3oAprFQ81Gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPv1iX8m3cMdkpAjzGGbXqSdj1OONLXuhPb9m6MZSJU=;
 b=tkzXGIkz8H3/xqTK9XqLgqd4mImpA7KrSoCPhyUPBNRBfcPkl/RWVOrKBz05muiwSDbEH+tt4uRfjASOE7u83V0quaxMFlH92HAcDtQq4rPaE3hXKV7Pz6p+m1MD0Ycd2nrKRpaj34jP3wYCpQgbkTs2pKjjnVfZF9y3KDNQqabjTOnqE+Owgkpq+1E2JMneb0+Js5j04Wlf8hkylhX8DR0Q7QdXRGfYUMiTgHKSqcy2cGylwIYGXlN1MhNdYi9tu+BPQxDKPuPo9u+ICGqL8Y0tCVXpButoa33fXxV24zuKL+08JRMzR/au7Bht/L4/jeW+dHZNoLTPq+msIxFbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPv1iX8m3cMdkpAjzGGbXqSdj1OONLXuhPb9m6MZSJU=;
 b=vkV21TjPYqP78rvgXBYWRpwezJaaAb3TcgI3QO1D90YTtO3ZmpefJZDpi+Aryjer3QY5phog1UELnQoBDhI5H1h47xE2G/hqEJrFljM79e1aM3nafTx3U0TyP6ccqJILu8LlQCCKshfsPTqTeu3R4TIIRm1u3WS2qNOp1Hcx/5DIdqlo7HWI0C5Q6ng+o5RNKM6RrvgzzQNzwY5hYMvsxMaSfeZK0LPAfXJ1uBTGlxZYNvU3LCckdUK32QTkl7ZM+YHywc2TPxyaEAcBj8klE9RZbe7DEAZ1FoYFrffv1emqGpAFntfR2AUe7dne5NzMNolIgGgHVZEP/jU19a46tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by MW4PR03MB6346.namprd03.prod.outlook.com (2603:10b6:303:11d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Wed, 6 Aug
 2025 03:22:41 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::3145:43b1:92d7:f7a4%6]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 03:22:41 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mahesh Rao <mahesh.rao@altera.com>
Subject: [PATCH v1 1/3] arch: arm: mach-socfpga: smc: Add dcache flushing and
 invalidation in smc_send_mailbox()
Date: Wed,  6 Aug 2025 11:22:04 +0800
Message-Id: <20250806032206.16688-2-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806032206.16688-1-boon.khai.ng@altera.com>
References: <20250806032206.16688-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0027.prod.exchangelabs.com (2603:10b6:a02:80::40)
 To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|MW4PR03MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f20a667-34c2-4d9d-36e4-08ddd498805a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TuzjkeQpqUo4gCW8lEDbYf9O20CavAXgXT0rQ54L4bdrFRlrFYyaveCgJ1Un?=
 =?us-ascii?Q?bLfAceiFx4TJxgUCCKkQPqo4WPYWOyLxUYRskSIgUCHiQSQrmiTFY+an6uuv?=
 =?us-ascii?Q?QXEwec7mLaMLIvj/ZjedsYSXu2xdUCPnARnlzAB5qKYkn0adTSbF4ca4JRAP?=
 =?us-ascii?Q?ak4od0bWqY0J4O9AqUeGYpFnmMGdT+9/F/8XGacBdvkLLvMHmR9OpfGNoy4W?=
 =?us-ascii?Q?vT1EHHVwu0T6RsvE7lvuVmYaQT33wFizb5fS7Dm0hKy7NFe0X6Ynp6cAIaVi?=
 =?us-ascii?Q?bBIxZ9XoYpI/bDAPM71Jo+norW6wHzkoujTAko4Al0LlpPDMksRegy6d1K2K?=
 =?us-ascii?Q?CRwQaxtdSuKRDTDskvw4wBfwnoTQwKaworBmoOiIfsWTWt5pIWeCn/uG8umz?=
 =?us-ascii?Q?QH46XPGwzC0qzoeY2KXbFhcF9pVhqMdrrg0ZWGioGebm9nnza0c1Q7wUjpw0?=
 =?us-ascii?Q?gAEAU0G3jklDuvLCHz42/cP6YL6mjCy87lM6WcuAwy8+RHgz2veTPXMfaIWJ?=
 =?us-ascii?Q?6Tg7qwDYu88iKReZ3SCLIBdqnc7Yrba+p9gobYQNO3niDEzhwlrjhmPl6E+I?=
 =?us-ascii?Q?6BDlPnYO/bskaIronTlYtjwSsTrt29CdJ+e6hY2q7WGEMVa2RGrwwX5PDX/X?=
 =?us-ascii?Q?dmVvDVdkcD/xJiKX0L6o/AWyLlY9fAzHxitC73a90MCGDgzEpXw0Sj9eXGPQ?=
 =?us-ascii?Q?GHc+eTAQ7Wd+6cMBL4CnP2XJN3CbLhSRd11gpgHOrOfPRbKOpdgtSUpcucC7?=
 =?us-ascii?Q?Qq1LBgr32m2Mc9XvgfUNAbHHe9MoMEELR7e3UmL4OAI5lles4XkR8JiA7Cmo?=
 =?us-ascii?Q?lRRujQRBwwrUPYTn8to3+PSdqiO3Fb7wuUteRZx7M1hPmDNWwnAjuHOuHH2E?=
 =?us-ascii?Q?W7A/Gji96MzZbRFgns0qdUhs2jqEKXhAWR4Yf4Tz1q7nQZvWuNAbKUl9pAsM?=
 =?us-ascii?Q?g0Z98lpXh6f9dXEy5O+CBrUXHyhR1ER9+hOwzQeIbCzlB0udo6cDUXL31pLN?=
 =?us-ascii?Q?4Xe5hiosxK/WkPE9KOnOg/ILuEimxQq1WR+pUzf43huGCBe/UayTaccvfPt9?=
 =?us-ascii?Q?8iCY74VzJUsxcfwqMkRGbL+T8YE+9btjx94ErTDn3p2CybQtjhhh5X3+cXnC?=
 =?us-ascii?Q?xJW+eI80LgwmhR51lDKEGS3hYBPt0ptYJoTdUHjTTQZVcp9H7DE6u4I/goBB?=
 =?us-ascii?Q?fGNBUBsMWZTkgm1RW3WpyhDrEDYFMjf75BY8YNuw9Qz9vyeZSz3fcsTeBmmN?=
 =?us-ascii?Q?Dx8Ycyz7y9PLS/yWDRjx5wJqSjOcy/K2uSs9tUrcKteuVzGmvJ9QEuSEL3DT?=
 =?us-ascii?Q?gUbGEIC290qnZaj5qMs8X8qy+ctZiInujs4naxB+T+WcGUQqq6IRJ0X4eoMM?=
 =?us-ascii?Q?SUuLSrKa2XA3sYLW511LoGdHY97gNPC2sa/7C+aD02RSkPyBwffhdXaGCA/Y?=
 =?us-ascii?Q?7Wexi0MV+/w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z1L04FhsSYJVdrZJNbqFhV79ZnBxs5P1JKxMOmuSYKJ20nsC642IDIk8/6QB?=
 =?us-ascii?Q?E9C+qRLmJOAkCztQOoDURTP8dNb920D8fBufKFL1t3Suk89zEI2njzBNcdAG?=
 =?us-ascii?Q?TZ2W384NScW7/8+EsIZ8T1hQmlWCK7zJLM85Wul4XafhC9YvlePsyNSZAl2n?=
 =?us-ascii?Q?KxpBEa+IYHQIyAuA6J07rpF42s8yqqmeukN+27E4JhAPty2tpFYaRRxiwxWB?=
 =?us-ascii?Q?IgWx+koRCjVr/PJ/BmceFBJ+P3mld4aPFUCgN/bb85MwAvKeYigCJ/xw1IM8?=
 =?us-ascii?Q?LpDeTpiP7GKhl2XUeqIwK/5hMYhq/42PxrotsOIRB1QG5SzyeySJKMzer9AZ?=
 =?us-ascii?Q?If5CGTPVwHTl2LQhlvCRfgkEXDuuIKNWOpyHkwbxLRKN+5KsM5Aot4w6qhc/?=
 =?us-ascii?Q?+RmTwb+il6O6Z5j+5ZHrUHqY5/GtwWeJ1Qq/yQnlriM4UWC8qyWHlW6sro0V?=
 =?us-ascii?Q?aNMQquWcYlaED0rx4cGV5FCly/sj3D+SCPo2YajZfjzbpm1XxixocGHSrTlW?=
 =?us-ascii?Q?xW6nbmFo/0fp6H/xxKxZsNIDlXSBqYzyubNrclMN7iGU6hH1y8jz2tT726xQ?=
 =?us-ascii?Q?4N56jFYV94wEoe7p2XnTbaiq40E/goegAsmqv74UZkp8cSvvgJpaXAXpP+ss?=
 =?us-ascii?Q?lE6f6HM7Vos9Wv+v3/5iufBZLAl16Aq6vf9/8D6Z3Sn/rK3EttD47RzF+vWK?=
 =?us-ascii?Q?SwdM/FvLm5VtXTiKMRN/QadKGOQOZY87f5m4kMEUHaNT/W6w95PWTHn9VgA8?=
 =?us-ascii?Q?ntih2FYNIbRil5Pp3Kbwd3iAc+btwE0GEzucY4mvLBIyJ8nIwL2DPcpSZneV?=
 =?us-ascii?Q?6tcYZ8KE83Cha4Q51ZKpPyBn5Whm9rdy+5REEPDHATxOgZG3YjpwF/N2tj1W?=
 =?us-ascii?Q?V8fWzsEF2bkKBdggnf1OybCx4PosI0f3OywgHivuZr1s7ZBXTqHAOlf+nkEj?=
 =?us-ascii?Q?tID82bhrcz3QaNk+t4u2UrSPBtP7NZxu6J57Klzai6NGYJtWR6/XLJ9XMMYR?=
 =?us-ascii?Q?UhYdOu3G+U8vRQYVy0c2fCyfdvInu4aoJ+dAEpU5HM0hXDcPHcuUhRH9wgxe?=
 =?us-ascii?Q?yNYdGTwRFksEgfZCq1698qtlreKRfPWGghRxD7PMt14CyNbTugdolbL/HUJH?=
 =?us-ascii?Q?K0MaiyIsQXl9e/164PvXD8t9SRfVLbrQAez1WZVRJ7Og4eaitnschzrPrxdt?=
 =?us-ascii?Q?1uwLcxZLjSqaagd+SdmhYeG7hbs0Ap+4d9IsV3KRvWympEVXtGztfPlyj6rA?=
 =?us-ascii?Q?pSNMngTQXInZc3jCVr34Z0IyWDmz8AxEqhBGLouX7wm+pCyKzFtCbPC+VvtS?=
 =?us-ascii?Q?kLAnNfKJ/JsCAxzTpKt3SwkyE4pDVf67xpVodzU1sroQO6+KYiHo8J/SqkYG?=
 =?us-ascii?Q?rghaXSXAhTHD3UHcLIH08t1ZGyx75ZMVPlQ85I2XwWqzNcz2ZHayGO1LIvis?=
 =?us-ascii?Q?DHQfMfZGpEd7H1OiEqHxWKg7zuWlSfypHDvzPrXENlQCWzag5Pd9POpKEgSC?=
 =?us-ascii?Q?6ULgr4SlWJ1wGznb7nuO3PXMpaCJaCiY5VAC8ZBN/16QzpM25OJoMFtbEmxX?=
 =?us-ascii?Q?A4JeOJ06IF2uF1JDjFK4frOckvrDcsLb/uMJhD58?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f20a667-34c2-4d9d-36e4-08ddd498805a
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:22:41.2891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFmR9hsFkavuoJMfZbpv7QRadQ/KJ2xGoZJzjKj7uGUOjiYvpkKJReWfdYhIdnaMtVjy9TpJW91fHJZTiDRzdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6346
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

Adding the dcache flushing and invalidation in the smc_send_mailbox()
At the same time replace the use of u64 with uintptr_t to ensure
compatibility across different architectures and correct the
pointer arithmetic for buffer end address calculation.

Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/mach-socfpga/smc_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_api.c
index b212a94b321..a531030f5be 100644
--- a/arch/arm/mach-socfpga/smc_api.c
+++ b/arch/arm/mach-socfpga/smc_api.c
@@ -57,6 +57,7 @@ int smc_send_mailbox(u32 cmd, u32 len, u32 *arg, u8 urgent, u32 *resp_buf_len,
 			 resp, ARRAY_SIZE(resp));
 
 	if (ret == INTEL_SIP_SMC_STATUS_OK && resp_buf && resp_buf_len) {
+		invalidate_dcache_range((uintptr_t)resp_buf, (uintptr_t)(resp_buf + *resp_buf_len));
 		if (!resp[0])
 			*resp_buf_len = resp[1];
 	}
-- 
2.35.3

