Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41169C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 09:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76AC282CF1;
	Fri, 18 Apr 2025 11:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UmtP94zp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387B4830A0; Fri, 18 Apr 2025 11:12:51 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 069B282A16
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 11:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWmZA7t3tZmclHxGTN8AL4EtXgMwNdK2DwtqHbaZVs8CbqiX4K5AlldkUoY/Ko4UbyFt9pc7J5gGrcZjswgRGwaSSawlFfC+RiE48BWK0aZ+Z9SnJ3Tn44AjDWTIQ2Xk7JfDCDcNLM3QXKKF+fc2yM6CAX8MjNb5MMBY2Cmroalj2UsCWDxkK1ijJP9eg+3uhJxt9V/OHz/XjYVTf0DTExbG7jG+nMETdeAUjUI8bxLUbpcRwHg0qrY2VhmIDLsgpPnwWHNBOVSHmnktW+GDmcNQ/PRek+DC4CcfcmpRq+UmNrdWvcdGozU3sE11Us9klRAKr+jYGgJQiZ9tSrjC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+n5PsenY8DbzntH9ji1qe+Jf1HlNYlsrCAGUsFd0hU=;
 b=XnGrA57WgMBXBQvLJokAakKANeSbhVA8rok5ttYvPRayoM9t3v/x7vEMSnUBxJwzyQJc6Z/UwuadcKbNzzfmaI6NCDTH1n/6F5Ths8T8moON70Ye0uNo5ai4CKYkqmC2rm0Rtwjvha6jxzzvXV31nBRytjXCLRiJzG/Ion/MxQ/ofUuR5R+MLQx/SaCSaoUHB6vIvjX1Lu4UgI4jRXXVYQEgaWry35N3fsk059Ue/iWdyzW81Gc2ihDbX3htN1N98MyPZVZfi/tpGgxjZSY6ZfQAFMovPxTTWpVdW03KUgbvGrqRF+yC8pIamd/1vQfc3hXcj7scoFeBzgxTkIJS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+n5PsenY8DbzntH9ji1qe+Jf1HlNYlsrCAGUsFd0hU=;
 b=UmtP94zpj10I5Q0qLOXLXkFooeCfXd595NHWSgnVPWuynzBwwof9ShlbWYSdIdLtLBP529TM1jtINu89Q31AiwIlt0U94tVjAQJ4lzszJBhQlgOiHh++f9yWdxuAJ7jnyu7/PqYa5lzbr3O2dfJ89whEqQEhhq7Xvu4Wz66JIhpvaH3q7jsK20uX/iYqvltQwL60afkEcE2PAK1g7rofuvUvH/jNJM1iEwlYWksve4C3DDKqmfmjbGPAivUktjkZHV/M9LNNRr0YslK90qb/Jqs+NwLzYowK4qZ7pDSYCs+xvfegblv2hXxMaoOyXcYfisCHEWjtsCcKlECVlCPX0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SJ0PR03MB5727.namprd03.prod.outlook.com (2603:10b6:a03:2af::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Fri, 18 Apr
 2025 09:12:46 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%4]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 09:12:46 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] arm: socfpga: soc64: Update SoC64 CPU info
Date: Fri, 18 Apr 2025 02:12:39 -0700
Message-Id: <20250418091239.5538-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SJ0PR03MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: ec230190-5c3a-4cc8-7d81-08dd7e592eca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cESL82cbCfylk+MiT5rLAEiL0EWrmh7z8UVtMAXn1u82Zb8J4FJaVKO2x5RB?=
 =?us-ascii?Q?FwCyl1F4nRcw2MivLJUh81ieluChwkjzGK7kX3PTr3JOHSrX4WGuiWlgHvtO?=
 =?us-ascii?Q?X4pudcFM5JgUMBEmsdxB1fEHbK1N+u+RJSh8L7S1ih4BuqSI8qpsRaJO5HYU?=
 =?us-ascii?Q?+/JlTmxAQSRNBY/8gJNjSK1axij65kbadCjVuXdQwZcq157njDL+4tvWtBcL?=
 =?us-ascii?Q?jMu3BShS59PTN+lurUXWilqX8tBV+a6N5UmH72cDbSXvI4DCG6PdvN51SgRW?=
 =?us-ascii?Q?XfpebXw/8AfpV+Z+zcFqBsGqy0jn0R7RS/zjul29IxpCFKSFNHkESJ/2gs3V?=
 =?us-ascii?Q?KbjjXLv5IaXEcVhj78LRInx0hHTtRer8MW53J1f1UbtGhXscOVFEWpc9aRi7?=
 =?us-ascii?Q?/m/XmK8+w1b/fHIhPqfd/8phLd4/w+fWjsLPm3b58BQFMPwGkBAyaDLqJ34V?=
 =?us-ascii?Q?p78qWW8SnwbwDZ215LsqQReaMZSaMN379dVD0nURJKkX5BtvNu0JNbjkb1bW?=
 =?us-ascii?Q?b0is2sv65L9u4q/lnrH+7E1dfyGfQoNzYfuOAH/gZ+Z8KHlLmPrzJrdKgaNm?=
 =?us-ascii?Q?5Bi+zUB+RhBBLq7aywiUMM4bfRCI8pT+5O3VtEw9RR+iSwtzu2+jp3yEIUWx?=
 =?us-ascii?Q?pc4REUGfgz48rGEOD79GrMjTmv81AtGSKEoYMlmc/oh1rKpMfQSG+FbdCTbv?=
 =?us-ascii?Q?z7gLHFsd0ljfBbXQBA2dS+ggB7HaFurrBUX/pXjpLHzpChRsjU5aqvodIV6E?=
 =?us-ascii?Q?pEBSw7ib87C4CpLeTRjO2W8Qo5rt699Tr1/owVR1lg6XPINU4GBwQ4JjUXKK?=
 =?us-ascii?Q?GOWq2MY8In263GhmOBTn5W9oDA5jSXkg6JcgSqSialjjDJKiihmNePWoZ8Fu?=
 =?us-ascii?Q?lsKZmhC2m/N9XIXkoNHmk6k2kkYoJWi023Xw4o1XoYzM7SrS3yssnqC2t+dJ?=
 =?us-ascii?Q?coCWGk94HDQ533XS91J0tik9jdRojUBPJMxXDSNCdONTu5BMccaWYUHl2Ihq?=
 =?us-ascii?Q?mQlxpnYnccmG4eHMOFCSDsSs7rbWtjsAS6Gaz4oh2gHGYwFMF3pxLWcq2FeI?=
 =?us-ascii?Q?XL+GKTOnoiQZhkG4HLtmglUJIHLTgKY4kuoqkaqbrhguttEOQO3RmC0Gz2W4?=
 =?us-ascii?Q?nYBxmlWmuyzCBF6UCjFF7WafMij2S5/dAr13xiyfmgefgWwA49F+IFgoR05d?=
 =?us-ascii?Q?apwVBx5H1ypYaGnIBNvKRLgoZ5FsNeDm4Ag2Ws9wELKBSbANZ/nVHu8u/5q5?=
 =?us-ascii?Q?C0DtmtGx34Pjk2CgxpFMQUCdndj2F7R+IIHsK+t1F3SxtpQ0W0hCpZeGf1oe?=
 =?us-ascii?Q?/h7Vpj4KoRaKOsiRzB2Ks6NJF2U6mpWPtLpQGZ6KMRFxlqf+25krGvx+a++U?=
 =?us-ascii?Q?wxfa8rkPqqFBHa9MaSfT6pM3ZD1ngwK1jbfRhRI9OfJChka3GGo3K6a8DEVq?=
 =?us-ascii?Q?h8Awy3nXLKA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?flEwxl8Gon00NBTE5M0tK1JkZZ0r02pVkawZCAGpCbKE0DyR+rLgT1pqcXG5?=
 =?us-ascii?Q?r7nP4nb9UJBhxWtklHHfB/ve7yUIkNs28TnlQf11Z0Lms3iCC2dUZ6iFBPbO?=
 =?us-ascii?Q?SLdbNRyOIh1nOwnIec1wksibYqgyCatapDKXkFYVdDeGOLEn+lau1mLTsviV?=
 =?us-ascii?Q?+ll/CaMPXsuym4e4apzpwPUC2+gs0OPtGDJQjRCzEgLdllPH4gmoimYwELGF?=
 =?us-ascii?Q?a1ppkkrHknZ4I8GwH17qQar50hr5tNBXWeav70Jncai6tDkwR44fjNT/5Z/I?=
 =?us-ascii?Q?1u5MKgnVtXaVhJgZGIkVoGkXE+0MHzckmtl00MjHcVHd16BKlo4DzpsePAOD?=
 =?us-ascii?Q?h5tNnKP2fSYG3aV7BmgYZ+UTUkfXMBppQWf69acWKi80uDNNWjSfg1tx5i0K?=
 =?us-ascii?Q?HjkzTNEND3TH60W82tPLu1IlfrPvtlqmOmxmPFY0vo37SplUMMujIdw5/3vf?=
 =?us-ascii?Q?MfLa6BKJX2o1gFJwMircf4pYHOKa/Bipc5z+tChs3PL8NjqvBO+T+MmGmbBP?=
 =?us-ascii?Q?KPfDEZhxEzb0DPbxU5A8CxU7+twglhyeWjiL9MtE4JlogV6pWz1cdLQrbI/h?=
 =?us-ascii?Q?V1BLiW7Y9cop4xd2H5YcVLeFd+rjYmVpr1msnzyZ2gsnuO0zJwjB80R/eZuL?=
 =?us-ascii?Q?Zrnij8R/hnjV3Apq266pUdD4Iog36fjjXd7gCaLM3RPWUmaFnwFII1S5JWXP?=
 =?us-ascii?Q?URtbA9mFcfZKlmN5dojZ31ZGH5LwWHXMHhbvPVQxrkRYxhwiD7OJMhgJlxc6?=
 =?us-ascii?Q?P12Xyo+leS4+j3yP36NbiukuUy0TvWHcrE1jSmZd3tjXiejGZ1J8JKLgmEld?=
 =?us-ascii?Q?e6z3brQvE4D/S50igpQj1UdQ1Ed51l7UIsgLAk79qxWbbAwsFI04BDwycGls?=
 =?us-ascii?Q?jX2eVjPQ2gn+gNnh/H4j11AJhjx6z5d7SdJXbJO8RR4Ddvnz2SYXdH1NOoML?=
 =?us-ascii?Q?yxT9570L48DT5XtpdOfyng7icLY8UZQkdpST6diDJ02/6InDP18NhIGTUAWH?=
 =?us-ascii?Q?exHqL8CuAP8c2CSYP1Xc2ifkLBbgiO0KmWsPG368Ku8Hoeereqw6fFSoOuLq?=
 =?us-ascii?Q?9aVO4G9Pkgem4Wzd/+BezGOsriFeu3jrD9fuw6r4ZpJztK/nEQV77m24+Uyl?=
 =?us-ascii?Q?8KnaNrsyCtjgoYStEDbeqEEvXNxWV2142PHQVpOALbyRf5QtDd1yz4CaU0gV?=
 =?us-ascii?Q?cahrmc/OUmTvzP6/pYkBtyO8Iz15SWDyNeCc35DyMFeAk9jK+pJCbb5vdQ5M?=
 =?us-ascii?Q?gXG3W0H6kH4w4UOhSMvVCMHmIoWK6b25y583/zI2RemJeHJUkqMa4fFPOmMG?=
 =?us-ascii?Q?WMWXrUTYM9npRTUX2dDBFCC1twkQaVbg8UzHtyYItmtuvP9Wc7tm33b3+Uz9?=
 =?us-ascii?Q?UYLuFqSpOnEzSHIkvaVbC7DMlU6WCpMPqVXFBsYAn2TvD8Mj3dSi/yMSnCq1?=
 =?us-ascii?Q?cMBe/HHNEhZ6jxLH/AFi8XuC8x3fxsbcajNOz7iQQ6sF1QdPGZovR0Na4MmP?=
 =?us-ascii?Q?kO1ijEF/PHs2OwoggWdDx3kulcYbaFGV7iq2nwBaTllNK3vY/t7Ijxb1vy0D?=
 =?us-ascii?Q?rmo0JN96NcTHQLwa3mj+P268m9RSS1X+CYMDQ7GdzY+E2ZudBKFpaFozuOBr?=
 =?us-ascii?Q?PmFV2d0+7/uSBT7+xLNwWmk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec230190-5c3a-4cc8-7d81-08dd7e592eca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 09:12:46.0097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hfVIcWFzcKPIQp4524ZlM5D8JSgOKhSFqaWGVl/ZVbqkcotuDzcNcWUcw92DTfKaS4KG024ruJYuT3L1sBUILeLbfByv271jfZ+3E+KwsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5727
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

Altera has separated from Intel as a standalone company.

Update CPU info printout naming from Intel to Altera.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 arch/arm/mach-socfpga/misc_soc64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index e0b2b4237e1..9fc8b9f2e06 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -61,7 +61,7 @@ void save_boot_params(unsigned long r0, unsigned long r1, unsigned long r2,
 #if defined(CONFIG_DISPLAY_CPUINFO)
 int print_cpuinfo(void)
 {
-	printf("CPU: Intel FPGA SoCFPGA Platform (ARMv8 64bit Cortex-%s)\n",
+	printf("CPU: Altera FPGA SoCFPGA Platform (ARMv8 64bit Cortex-%s)\n",
 	       IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5) ? "A55/A76" : "A53");
 
 	return 0;
-- 
2.25.1

