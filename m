Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F0FEFB4D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 13:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38BB083E8E;
	Fri, 27 Feb 2026 14:19:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="oJ4z09Us";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5C0A83BB1; Fri, 27 Feb 2026 09:49:18 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD4CF83642
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 09:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGFqADVrFH3e70/yEudDTg4Z6jeP0M+lvVSP0QquqOTflsbiEpJUo4rfpstzbtnXSkZucZ0EG82/OerdHWGGNk67f0me79AbLlmNxE2UPYc2+lxGLsNsCKz+VLI7dQNZ/aAo+plSXhsQvaKpYtmbkwqF3C3RHVrU1NVWpqFLrNhe2PH6Kz3pW2loIOVsmqfN6ifhVE2XbIa4YVDm71++ZxmyrozNa/Pn9qfKznMsPaMgr9+x+BiuOKaxTiZg5SiULEtxciZU/P6c6XjFnh37NuXvYci44t7ACIhgyy8rMNaanngIDgpLzWOZqkxQBgSS8svoIlcNwQ7WHO6w36CY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DObcQLiQGvLDeGpYMWRRFV3Me8YMau4UTfBdbhrOxh8=;
 b=CmIm8cWE9otvtJh4TGuGg4bK3bD+jzTgwLmF6gnur3BSx0Sn/GSCex+WzuUty/cqIAYzJGVMNVqElF55nlt7cLjROr3Dmro0/L5r1k9+jYdWCTnCFSJSuIoQk6KxSUXlj4k+fhKjBQUG0DBWmnC9L1r5l8gKXLB6zxrv2/FXtIheBT05vtYYKTcrCAMyZi0Vwc1t0f++5CkVa2oDVPM8QpxO604xeG+MRVoOjCZ86vW2n4NIcz1aklV8AeEGIAY4DztY2bAtlkGjC2H/2UXo1NImCIej76TyzNjvzGysObUE+/DTm3/0hPUOv2aaw0cfqnRbsRNKvLZb0QSp2hHcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DObcQLiQGvLDeGpYMWRRFV3Me8YMau4UTfBdbhrOxh8=;
 b=oJ4z09UsStWemEu2iJdELnj+/pcKT7qZMPFrjeosp1T5RfYmt13VARiFT7mTy4BybJHYeaM/cawh0UaIsYqAk9dKn2q5b9Bzm+lAT37IUdBmjJZ1QYEP1a45ZcdmREVfsBaaK4KINIIB4HCNGmQ/7aedsAXnz+eK/buLzODcAi9dSMd6h7hamSSW9PM/GIjzdsoYmaO36T8Z0O4d+adkbBhKlCSGGuuNejSOKa0yEdRs4jtagWmq0pYiokwMRBXS2j394GvLefLDQcerssK8D9cIZzORaz01ULXLwHPO7nUNmcEKM0maf8a2Hp16+zJp8HhOdMtVPW0ERh+/G7tBpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by DM6PR03MB5228.namprd03.prod.outlook.com (2603:10b6:5:249::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 08:49:12 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 08:49:12 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Brian Sune <briansune@gmail.com>,
 Marek Vasut <marex@denx.de>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1] arm: socfpga: Gen5/A10: Enable Designware watchdog
Date: Fri, 27 Feb 2026 16:48:56 +0800
Message-ID: <20260227084856.21468-1-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::30) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|DM6PR03MB5228:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1bf91e-8758-4b0b-ce99-08de75dd13cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: m6nQUrZezyKt2hzMYoZ/5HFHbRdfAqgaumsMYU0Pd7enmk9R8kSBNSzPR/5rLEGshjDwPqhA4WT8pjF1cFKzRMnMdAT9aBC9+Swtc25g/Of1stEpWlqcIJeuCOQ5WVrIwPEIZzpjcGwLILYcaSQOwkRJdd/XKtVefactyTOO1fSR5EFFDTrGDZSHQiEihEckYpaH5DtbDzXiBKgLYGrc2swj/202tRBnjGMHlpvXFauzhzA4WDVY5k0ALBVQ6kewaHTRJBLomJQn/APFzYY+r0vdEazamJlEwPZ392SyfzT/b1FbiHvjnLT2Pw/UOGhF6FJR/p+flrNgZs1UiCV7beQjHNgpWeLg8MgtQdx3jpNkqzGAEOXKdGy21+rdMcDwcAHOj9e1uT7Uh0hTk8oLtcGrt3slFajY6o0LPzJcfc7NJEI66e5ls50yB9IIpEfDPu3U6mBPGFQYNk5FqPxg4mKbFuNrV6VkRZZq9ruEJ3tYvsxzDgvFy916nOgBNfyCob5BjF4ZC8flGyuEwo9/0BBaaWBlfBhOVqLT6HBmBAEOlINMQVfZwKUyuu2QWAzHYJgFYlGe9ADDa4Ia+Sxbyab5YCD+STBUY8vxWQ6z+OrYdiyTUX2Z3R3HztRux2dXb431nwt32WrNSJS+klfEaDz+lkgactbfPCMH5r29JLfobTEtTiVHS2bkT9C+SuEBgH4fytmC8o1aAvq1aBMwdZ7mOb6QASB7F4t/dhypthE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vnNtwYXUNqLghOHppJbezt/tbJ2pu8RtH+AIpHmt7pHXoVeouiFXMeDCGhUZ?=
 =?us-ascii?Q?c1bLYIhh1iLc/KvTdlu8qLVh27/DAzu2HfDFE/XORj1QInUNTDYelWpzSc3Z?=
 =?us-ascii?Q?ZdFeWX0kSk5R0Im2jqH2XR7VMBkMgAdW1r6RQ5JNSFrDHDa1fGVLemuf21TX?=
 =?us-ascii?Q?3moWafvJgjxrIVSGczoOaE0fkcud4nSpC3XwuXch22i1ggPKIjyjG72pvono?=
 =?us-ascii?Q?b62SkZVMpSnDEc1JeEFCOkL4I+Bl9c319O0PkPgRnykVZ04+yudst1VUOvDC?=
 =?us-ascii?Q?dr7LJK/bZ9LeUfOuve5rQMdVzPhOG38hK/MYBYGSNXJ2HVUr1PScsgpYuFKV?=
 =?us-ascii?Q?iNnWM3IQeDLVru+dFY9IGuTD8sHW5kTBtrkHdGZaqrfXoe7VEE8eR212p7C0?=
 =?us-ascii?Q?ehfZL+MmwnH3GFxhrBxlsG1loMC4zR7nGAdS3rxT4+vr93rZvw6tZSUjVd4h?=
 =?us-ascii?Q?rX1i/DTLvV1PFZkUHn+LZHo48YnE0TzmdzwETFrSzeuoES4YLoIdYee8j0k8?=
 =?us-ascii?Q?wXZK+X3pUI+01wSIt+zYh2LQEXmSEb3e8foBikp83Kv1wG8b2+I1URpBKKQb?=
 =?us-ascii?Q?/0F1N66YJF774ZTJq6Gqly0oUlB2laxxFiwEgbO/F7gQ2NwV7USXjMXKCEsr?=
 =?us-ascii?Q?XvD3SiHGBKc9pu8sDA3OAAySGVh/SqOVkvN4UK1c7JIqdKHeKDunuCmTwlX2?=
 =?us-ascii?Q?L4ikuaQCIWnOyT4b2Z3FQSldZO6RdfW/88NuTylDLSiNa+UxaizBQakxKwZh?=
 =?us-ascii?Q?TvpAt/waOGP9CG9sMadZYt0bxG+P0yoJXcHz5uIXAmtPEzmO71JUcByKyOVn?=
 =?us-ascii?Q?597xPwr2PZwITCnBf0BtQ2ZaDgooBsdrpm3eXTJZnZcSUCVuisdu53qsyWTo?=
 =?us-ascii?Q?GqUcv6BJDpt9vD2h4XFtpiyzu7D0hI3A9CXLBrIPeze2flJY+PCdtEFDYyEE?=
 =?us-ascii?Q?2Nhzdq3oMjbKZVZ+/phJZzmE65VMxa1GxNEZ8WlnxVX8LR7yYndDSZBDSvHC?=
 =?us-ascii?Q?ORVxPVLtxC94/+zO5XF5mEJip4GTu1eGNzHJiHJiJVHmUTkKhJuLDHkKBG+a?=
 =?us-ascii?Q?yXBep34+cMbThWZhtKfbr4+UjEECb9gelkHGQCDLOaqlFdtHEAw0dN/wxxPe?=
 =?us-ascii?Q?QCjXO2GMnzMZNg9mQLpkivdeYpo8Oup6M4pBbUb6C3S3NSnaIc6TSqssR8RW?=
 =?us-ascii?Q?Hp639fIJLWHLAP83FvlMRSXgW5GlMg3MD2M7NFvZFTSbf/er22rrgwfkDpo5?=
 =?us-ascii?Q?3Y3xsW9yQbItRDylESLOpzMHLuIBLxh1wsFPT3DfafWjJNnaN1OFa4tAxANV?=
 =?us-ascii?Q?AQV7UX61NDg+msiRR9x7NTk6i4GN0M2bRL9oV4d600lhMsbz/vjTZataPhpV?=
 =?us-ascii?Q?HZfz7uyFcq5hHGPUIkBkfxs7onViQz5LPsiBCVaqK3D7RJzPM5r1WzSaUyqF?=
 =?us-ascii?Q?3c8cv0B4nGu2FYOt6EXFPrt7cmXzEie36jA8rihhEBnrLJVm3Ag3CTveWzSb?=
 =?us-ascii?Q?1+IsGOms2yOXlErcK/lfmI8NdHZVnXn/KnrQhuTiJdkyXkpAVVxAbUHJLUdm?=
 =?us-ascii?Q?CRuzw5ewxxrzVfgCWQhkgydjKmXrYQxAqcWVsKHCD2e+Y+FXUHNonEhemov+?=
 =?us-ascii?Q?RzUOWqk+GUePoqStI8jm292fqI0KlE6/q7MqawtA4WhPqh//2nNuvh9q8K1E?=
 =?us-ascii?Q?lrPpK/w1aH89NbwnBdDvZwJpvFZJWFsvzW7SOitSnXcDBOnKvjV6UamL8YjM?=
 =?us-ascii?Q?erutkDZJ9g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1bf91e-8758-4b0b-ce99-08de75dd13cf
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:49:11.9190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozJ07WGC8D1LLpcbTTTgtVp03kh6ayAoLay7CIXdPNkmXu+fo2a8LabOg1orvj29dVJ+6pgyIMctu3U4yhPE4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5228
X-Mailman-Approved-At: Fri, 27 Feb 2026 14:19:56 +0100
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

From: Tien Fong Chee <tien.fong.chee@altera.com>

Some bootROMs enable the watchdog before jumping to SPL, so calling
WATCHDOG_RESET() is required to reset watchdog timely especially
in long looping. Enable Designware watchdog driver is required to
support WATCHDOG_RESET().

Gen5 uses non device model watchdog HW_WATCHDOG due to OCRAM size
limitation.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/mach-socfpga/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index aec0fb7b1c8..49920a8a4d5 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -90,8 +90,10 @@ config ARCH_SOCFPGA_ARRIA10
 	select SPL_ALTERA_SDRAM
 	select SPL_BOARD_INIT if SPL
 	select SPL_CACHE if SPL
+	select SPL_WDT if SPL
 	select CLK
 	select SPL_CLK if SPL
+	select DESIGNWARE_WATCHDOG
 	select DM_I2C
 	select DM_RESET
 	select SPL_DM_RESET if SPL
@@ -100,6 +102,7 @@ config ARCH_SOCFPGA_ARRIA10
 	select SYSCON
 	select SPL_SYSCON if SPL
 	select ETH_DESIGNWARE_SOCFPGA
+	select WDT
 	imply FPGA_SOCFPGA
 	imply SPL_USE_TINY_PRINTF
 
@@ -117,6 +120,7 @@ config ARCH_SOCFPGA_CYCLONE5
 
 config ARCH_SOCFPGA_GEN5
 	bool
+	select DESIGNWARE_WATCHDOG
 	select SPL_ALTERA_SDRAM
 	imply FPGA_SOCFPGA
 	imply SPL_SIZE_LIMIT_SUBTRACT_GD
-- 
2.43.7

