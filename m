Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDD3CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8395480B9B;
	Tue, 19 Aug 2025 06:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="W/ngpRJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF8882977; Tue, 19 Aug 2025 06:53:16 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF5C80B9B
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRuvV4RZKmNvvx+FjRRExvYZWvPA7duMDdorc2rKymdAYyK6btvQFSEETb4vSzWsPja3niAq8HrgbX8ajDSe69QBzmNNauF9DO5+Ux+LU6c1+EfyMTqvzeXbO+S+JJXGuSrlsw0eEPHU22TyAWmcABshzCZXLlXOiNgbyLfRTlKdkKwv5jQArMxR9hY7JcTrAFFg5fN1sfbxBHNBad2HuWqyHvlpA3PEsfeG/n5H6/JePQPrnJr5M/h47VN+S7w+FxUlPgPRiorv2h/4/UAWbjpcPvIo0wCWBF3+a2e+ryjGOQZU/tMDdOQkSPxJvQj8QXFfiIVd6o9/jxpOMyIWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXJSLyUuEYoRDtvoSqlHG3i5xR65s2Z8DBLK0eaqCLY=;
 b=WFr61qV8V7f6JvY7U5N/FDIzUAzmKYjmmztGFxtp2HrYH2BwJQCVQS4tZA1gYQe848LjfvZalC+EMUyBEDm6rvH65Kqg5PRNImg5g/ATEQHWRgBzEGa6/0PtIfeovxbMXk/YMteLHglmHbh64uyK1NfKoaRH5JT6IPW64w5IupZ7X7vp3jNK1uD5JTL+2goWpcQVn/+dQSsinEKzqc9IZEQEDrnkxhKXGa0AA8AsEnVGMfWA8CBq9DX8HUpQciHzloKexCrKkwqyf+loGKB/tpxAAraWJ2M3setxWKHWTRoCO+7CRTjKzQ32md44pK+Ji5p+F/RG+oG/QVuKUHB9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXJSLyUuEYoRDtvoSqlHG3i5xR65s2Z8DBLK0eaqCLY=;
 b=W/ngpRJyaGYE8pJweQtGeEXtmOUxUhFg4pvg2V26ySAxYsjAg8RZmxnYnEJNi3FRxdLplzYRN4nj/CWr2v+GHAAHEDYzT2MZ9AC9XI8jr2zg3uwxFkepkI46bflqpY05tSuvx0ajHE4c3zX8KiE/J+Ds0V29UhwCFo2ztztCAIp1FTzak8L++a5TQq7AscOW8ZLX5/EgzQ1JdRCrfOR4Ax6A0KLfXK7RyBzdENd8G1x/6NqsNd4OAAugC41eCTEAYtFiz4Kphl8cZ2d+8bnlUxQMz71QEsTLnSB5Chw+zvs4Dw/H5g0EzBG+yrBsz9Zz8P8+Bb2jh6eJ3PlXx/SBsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA6PR03MB8000.namprd03.prod.outlook.com (2603:10b6:806:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:53:12 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:53:12 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH 4/4] arch: arm: socfpga: Move SMMU init to before booting SSBL
Date: Mon, 18 Aug 2025 21:52:37 -0700
Message-Id: <20250819045237.18142-5-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250819045237.18142-1-nareshkumar.ravulapalli@altera.com>
References: <20250819045237.18142-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA6PR03MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: c53fd215-f294-48cf-37c9-08dddedc4cfc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KncYLiBPmIm/ltwgDtwtrQySmSOJ6ALi+B+cGM0TDrHGN+ksyfu36jPL0oVa?=
 =?us-ascii?Q?vAS3B5fDR3zeWhJ/rhvrgSiVCn7ZikHt72EvnFXn1elpcFYWP+UujFcT6CMu?=
 =?us-ascii?Q?YeZRveHF0VEwTSh+fLv6KU7f1HG5VPdHtDpyWDpH+k6ufI9vRwrK7bq3/tRp?=
 =?us-ascii?Q?R7ZFH38WgV+9Qtq40U2Z+YQ7u1rQ0OZJR+TiG+pzl0YMwVZzvrzJ+6qN+672?=
 =?us-ascii?Q?6fwpPZg7ArM8sbVHhzRLkoC4fWARVYPi7SWjJAOgqf2YkeFOpBNxj2RR5hxN?=
 =?us-ascii?Q?oqIlrmLL9YeWWVW5JfB2YVoCfx5lzizWaORMXtH/DCi+SmVOM88GJuNhrV+4?=
 =?us-ascii?Q?8W98oW9VOl/rybiYGrCXHEdxWB9K1VAADpW1ySOe4gZsMVuN8wG6i+b0MvY8?=
 =?us-ascii?Q?LVwelZ9HwmBBjeqnocbU1kvR9IAo13VekI1DFqgJVImsYOUyOXCuyr9m26Qt?=
 =?us-ascii?Q?riOwRSdt9HMCrjRsqh0zkqRGH1kKhaiYBMf8Dojv07Ceiox0nHuSk1Y/XNey?=
 =?us-ascii?Q?BieNerw1JQfQTrkKWs2KMuYkgaSdGX9haEvfxvU7H4+h4d36tTsSj/RRQE3E?=
 =?us-ascii?Q?MXZh9f0tQTARjC1NkAkfzMYVitf27cXqIuYOENKUGzv4I9IGhhcEj5G1gmT5?=
 =?us-ascii?Q?Ns+829Rk7bMUShosrWOoAfCvhwyU7VAxGix4lMhD0fuv7811UYdH90H2XcUo?=
 =?us-ascii?Q?B5NufyeuqIafU07D6R6IFlthomE7pCimLvspZ7mC7zyOKHBvAZyq4V68kA68?=
 =?us-ascii?Q?xzK6dqVvDFTE3DACkPz95+9w76+LhCazlJcJHhm4wB0P554s7ULNmlQ7Jyp8?=
 =?us-ascii?Q?npiYYwy5OWUs+bJ8dZwxSWgwmyOALY11u1F2VtwYN4pWAe6LxyXe7YFETOsk?=
 =?us-ascii?Q?bz09gtqBIUfsgZ67LQPD2UfDS+E1T+GYCnr94CxSI7cyL7BA3O3fbLzb1ZCl?=
 =?us-ascii?Q?ngIlVFcdT97S3GxCJwDRQW9xUhWni0KT0+k63rdQXMbIreQvb6vpQOZ9KXWV?=
 =?us-ascii?Q?njUklxJgmTA4ZQB5OyBMK/+GrJMrKeEdFbtfgEHxU24dPPVs6KarggwJUhKv?=
 =?us-ascii?Q?FjdW9ohi4qJHfNyuhs/qwXTrYHQfeoFz8WP9lNYZTG3RMiiA/hnoQOpz40yA?=
 =?us-ascii?Q?vJ6TcnfeCcQBxL5G96SWuSek1fxu/B6v7vqdxQc3A1SsoFuiAZKe+Ay62Ldd?=
 =?us-ascii?Q?ugi/Pj4Nb8emYHV1CWc3t8R53azjr6MutO5308vONSSUSSZ5dJED2Q83sNpr?=
 =?us-ascii?Q?ZAQy+ZGz/19dZto+dfKbI1Qjz/pki722GQMTA5ttsFDfD0anAOELDbiiN5U9?=
 =?us-ascii?Q?kOt/asnzL+vczItDj4h6LR54hGd9HhQArJO39d29S/UzThZ1kOhHjU0020DJ?=
 =?us-ascii?Q?ZZALDA/OGjJigOjBl6G+DTVF8kMP0ik1IWfWyBaVEZ3gC0mWInRY6xq82hmw?=
 =?us-ascii?Q?8yyVEkcxc9c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DORSKOfa44XcSrpX1nwABUT3H/cmtVjVv3E54LGOERu59HDOfK8CMunzhOQI?=
 =?us-ascii?Q?RQcXnQCRj5R4caevzj06LbVQGbya0ImZxgaucpG5/Iku97dKhFfD1wMUE6G3?=
 =?us-ascii?Q?lzw3PkPUI3PiOvfocjD4NsDAeaPL+7aPoyBpc+hwQXkJsy0/kotHKE02IiFZ?=
 =?us-ascii?Q?T7/eABkwnc7S+CCWSXh0Lqs/4QHoLUOlsRLY+dWq09KTyWBfSd14I6tj4kxp?=
 =?us-ascii?Q?F/YU1z2saBSXHdiD2lO20HdTkBt3Xmm0sdnKXruWzFjhVR69OplewbqCNSQx?=
 =?us-ascii?Q?G12xhTK5O9+2cxMJj1KiZ8nY745KJa4H7s4iZU5oWkHsG0luFOE1+6cZy+4n?=
 =?us-ascii?Q?qGN8GOJo57X3ZXOyTYJaNSGXC53HZ9JID+jpysbWk9cAToDljruSQ5h3uFLt?=
 =?us-ascii?Q?ClkOMW/SvEwQI0ZK+fpNbAbk7Xzt8ekA8oSger34HCmccmtT9jPT3zb0UvZ2?=
 =?us-ascii?Q?RcybC4V7+EtbD0X1ArLVp9dsfbSJf/LRSwo02Bbj94ZSI5Nrhmk1u2/To09C?=
 =?us-ascii?Q?RokYRDiY+FROxisYijWTFC9Y7GI3dk3vFjpzWyddYHmN80CyLmePJAD2sUoY?=
 =?us-ascii?Q?u68E/V2DZxxcYf3UeSfibdEfaONjpp7kvDnmGzdVfsr8XLCsoFGLRQGkCh+b?=
 =?us-ascii?Q?fD24T+EmFN6FScYOHaLCs7IytVcR2IoExi7ubaNQcL6VDAhyAah4ixQzkwD/?=
 =?us-ascii?Q?KGtJlj6+YysgUG76g8FL3vNivIuatjtVM2k36fakXDwUUXKS+XdrXY66aESs?=
 =?us-ascii?Q?vlkcDwAViKOAmuBYYzp1KY8NMUSnWJ04qW+XVsaxIjih2gvDidYQHnL2MXlf?=
 =?us-ascii?Q?uxDDkxvbzA1jQ/VwkoEjGGguu/nUC5bOEc2nvsC+OgnFIDqXiwV52RVEr0vn?=
 =?us-ascii?Q?aWp70ZE7F1NxFZPeQx6KKsyRsf07IkVj8MdbtuFfuvboGQEEfDz9vwSUC1K7?=
 =?us-ascii?Q?hgfhtL52jct7PpknTX0J308vttdR8UYEaU/cJKjANQzT0ipe8Xgmku+95TOc?=
 =?us-ascii?Q?9SgE2ktXE8A99lB1gq/sa8ALILlSB5QtaM+6mOB/G/g/dpyxFzVw6U5RDUms?=
 =?us-ascii?Q?XN6FnCbUb7VEmX/8+d/CMjKL7JHQbTWdCOYMyuEE3bOlIvRrhUYxJ+zJ7KIv?=
 =?us-ascii?Q?dbB0g+dIV/OEszLEgEoEfcf2oUNP4d9yNjNbam8Pr/faWBs8+lugGVIQXOtO?=
 =?us-ascii?Q?yxy3MJeXFfMNX+cQcYzYfIjZnF0lEy/RdiPlpMOqov+DXiv5FUzxYAf5CWmz?=
 =?us-ascii?Q?1HjC8UTZaH/HJcyIqLsKl0gDnE1VBoELaXOUF+uQHG2b7nfrlWG2erPzVpOE?=
 =?us-ascii?Q?c6JIiVeNmKqZYyLEhasJvDz7OxzR278ZD9G+mqhNibc8oOmzsS9DQvkBnrhr?=
 =?us-ascii?Q?29wy+pt3O4te6fLcY7QLzXFPpXHTWpPbM899wv8vo7J1xFLCw+hgbZjh14Xx?=
 =?us-ascii?Q?vA/P88sQnJ/yiz3DTUNCWHPdRCalt0MzGNVMLftpOpZnTUTooevVSxiaqSku?=
 =?us-ascii?Q?VRUYaskzUzomeE1tSZbOLPLkWsVlg9nTAXgSsfYWLidNNtAafz6/3/a04n9O?=
 =?us-ascii?Q?jezpkTjNu7tTz0yZ+8fYEkpfs4bltmySX3J9UhJ/E8o/5TLJvTiisg5KinhY?=
 =?us-ascii?Q?1AxnYG0eisMbGAZyaNWWUrk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53fd215-f294-48cf-37c9-08dddedc4cfc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:53:12.3546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jNdmduE4cjHW1ANS3C52DYkcghkEooQznQDI4pJwT95vQdRUN5/iH3VEHyQUSZj9wWXl6XsLcT+twv8fVMImR+URBsUVootGrtQu+4q8CKx9/UAU34fYsbZDiIcmOHTj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8000
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

socfpga_init_smmu() changes the L3 masters (eg: SDMMC, NAND and etc.)
to non-secure; this leads to failure when L3 masters tries loading
SSBL image to secure region in DDR.

Hence, socfpga_init_smmu() is moved to spl_perform_fixups(), so,
it is called prior to running SSBL.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/spl_agilex.c | 3 ---
 arch/arm/mach-socfpga/spl_s10.c    | 3 ---
 arch/arm/mach-socfpga/spl_soc64.c  | 6 ++++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index 95e092377ef..5567360fdbe 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -69,9 +69,6 @@ void board_init_f(ulong dummy)
 
 	firewall_setup();
 
-	/* Setup and Initialize SMMU */
-	socfpga_init_smmu();
-
 	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
 	if (ret) {
 		debug("CCU init failed: %d\n", ret);
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index 9eebeda308f..8fc9369776d 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -73,9 +73,6 @@ void board_init_f(ulong dummy)
 
 	firewall_setup();
 
-	/* Setup and Initialize SMMU */
-	socfpga_init_smmu();
-
 	/* disable ocram security at CCU for non secure access */
 	clrbits_le32(CCU_REG_ADDR(CCU_CPU0_MPRT_ADMASK_MEM_RAM0),
 		     CCU_ADMASK_P_MASK | CCU_ADMASK_NS_MASK);
diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-socfpga/spl_soc64.c
index 651d9fc9cb8..8cc56c58089 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -6,6 +6,8 @@
  */
 
 #include <hang.h>
+#include <asm/arch/mailbox_s10.h>
+#include <asm/arch/smmu_s10.h>
 #include <spl.h>
 #include <dm/uclass.h>
 
@@ -132,6 +134,7 @@ u32 spl_boot_mode(const u32 boot_device)
 /* board specific function prior loading SSBL / U-Boot */
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
+#if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5))
 	int ret;
 	struct udevice *dev;
 
@@ -140,4 +143,7 @@ void spl_perform_fixups(struct spl_image_info *spl_image)
 		printf("HPS SMMU secure settings init failed: %d\n", ret);
 		hang();
 	}
+#endif
+	socfpga_init_smmu();
+
 }
-- 
2.35.3

