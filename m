Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4EDF5545C
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 05:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A0683E96;
	Wed, 25 Feb 2026 06:24:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hvlYDoJs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 004A583E36; Wed, 25 Feb 2026 06:20:34 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8DB783D8A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 06:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTNjWvxxp14oXkXxAhvqnzcVFv1SLXHVumhO3RRu6LHc6nW4EYvIjBBUokklIuu7LC5USp7XmtkSiOE3uEzo/QynQTE9ecMnLWO80SfEY3phwPSAJywrgoatZODknZmN7TGnHUcAZxCRaV8knh+VZZYqcNsxYPQmuUQN+2rPu5mta4yHrrFE0C7KDOrF1kBMfCc4qYlo8+JocfxcAgVBygYYgSiX+c0LhbZXyCdTXY1bf6tZNf+o+6O31RVwY5OO6Xwz1Xw1hLINpLS7Af2LTmjIKGZ1KgBJMgHlqHZgjUOZapJ3OTpZkOkY8Zryn8G+PChKQXd0IzlM3UQmYjttcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMPnTDtHOIUwsUy1991BD3R4fRs3Ge8J94TD+ewa6KU=;
 b=fYbAaqc4ceaMA82q4pubAsymjG4mOGGg2punXv6ffllngY3O1mBkS3bK7vUi1LaSFVv4i+l2AQSznroVz4V1S+inrr6a9IU58asgNsSxqeJCaK/JSxEuVrsuXjUHsaCSHETHqZd2+sWir76VaMdOL2gEDRfJHJb4rxWh9dpiW65K59K8y8Lhf8qcPqpc3KdfvOqEmL1KlUFQ+tiRpVC1hQW10J0S++mFE4NsD0lHRzSelWFBcyf8RsP+RMP3nQhY6VQjcomyBW8Wr05qeFw+jS9XTNjsh/qmpjGGTcSofK8JTVnsg/yXezP10YQ1pI9hZJsciKEMrhex3wEehTwSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMPnTDtHOIUwsUy1991BD3R4fRs3Ge8J94TD+ewa6KU=;
 b=hvlYDoJs+c4VJeeOg0ScjXgsraghFcqJau/KekVVBrY8Dv7RLqPLipdgqVGFMkv925ZdPVyiRfjD9z9CIEJNDiQrGOfugw68GQSmG+8bd6aSHF4mkCjp9uvzksf3+AC+ygr5+bHUD76EDy29w73S3S+67DNtN/0i5AmDwnaC4rdQfN5bgWaZFz356WddaTXKlYs2cobyHdH6U6bMbB2BrEtMW0DBYHbZWTfMwc4EPhCv4+Vz8x1MYvUsw6eQimUj+rdd0nbvDlUb9uebJIKnE0VWThFErcMXm6/0rWXbf3SG79dwpwa9Nj1MDe2+SLhMPzIabeb4O+ZclsdwwxLK+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BN8PR03MB4914.namprd03.prod.outlook.com (2603:10b6:408:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 05:20:28 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 05:20:28 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH] arm: socfpga: Remove confusing timer related words from
 watchdog reset
Date: Wed, 25 Feb 2026 13:19:11 +0800
Message-ID: <20260225051911.14324-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BN8PR03MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: baa32eb0-69cb-4035-bf77-08de742d967f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vpwa9j+560mUcDAoOaLodjSflu+JtEPsfhkkN+R7ZyU/hFkbdwakLnj9WJGA?=
 =?us-ascii?Q?9yZwKGgn1IMfiWZLyTWyIh85tidcV8Bj7M29a8O7J3BnJXUJ9YTJIDBjQiAR?=
 =?us-ascii?Q?0aZ/5bKEx2fwZN6iFD9bBWii4PZ0Y6/myCysR9j+lLeQPao+NIzARU3BUcFH?=
 =?us-ascii?Q?EyO7q1QzAU3siu4UVgmebRx0jPdnVrSAaFnnpK2zj+ZZR5/Hwz8eTjPnvoYe?=
 =?us-ascii?Q?KosBkI6gnC7WhyB2ABiYDACdWCzJqZsn4Z24V7Y+2cb34ZkZ4Ga/eU5QW/w0?=
 =?us-ascii?Q?e182Tretm0tAtT1nu2CMYbj2FTzuWDn58MJXyqtAXh8XyII7jqWF/6Ai74S8?=
 =?us-ascii?Q?xR7jvTwUgN3w8tQzXpFYBCO5d4yFd3ApXpaml83jIJf1jHTII19yEeK0vxXA?=
 =?us-ascii?Q?QfGdbT5XP4bWSUT8fJ2N61ZYdad5h1dR0sXHD0ao+qculJbjG7JdKGkM2Kar?=
 =?us-ascii?Q?GLs+XRFZ/qjsn+iMIxTHuI6zZp1RQq2sQ9L1IpVEWiQvU45lG9CSHddjoyvp?=
 =?us-ascii?Q?OXbLvoqOSniPCiliYtH6ygjaOvtYN9wQtkOp9A0NOjfFA4z+qcgxbWT/vXFv?=
 =?us-ascii?Q?zQhM70V5ZFoeg7I45kom7nPJuL7+oflYfH/lfCbKKxsplm0Q9vB1Ki/cOF95?=
 =?us-ascii?Q?WK8zcUATrqKpQeAHoJJtWPw2d0WkPVTIVW/4PFguA0YEcSuLx9/DJ+GoWLEn?=
 =?us-ascii?Q?9j+xZHhPJLmGnBgW3HmhLEHFsOP7fXlAIHYkAEulz+U7fqMhg84jy1s7AtZ+?=
 =?us-ascii?Q?EuqTjbiOrdYo8Mdv1jyr8lgawwtOzZDbTQAll1jyBEhdss4k5dxSyPEe+pFY?=
 =?us-ascii?Q?wwU1msTjiACENUaSg8yZKeAMVvnG4FyAx+zs8N3XM14z9uXVYz8hvHRoRolF?=
 =?us-ascii?Q?uZmBof6z6+DB3KBlwrU/i82naOrdRwx81/H7xKySeCL2GdvRP1xJVmFJdQS3?=
 =?us-ascii?Q?eWph+bYo4P7hnCqzsHP/PmEacqPynm/fP4haWS/H9cSLR1jqebF9RJ7L7vB/?=
 =?us-ascii?Q?lyn3CrBg00fwnytxYgV8km/Lkr1Xp8QpLE8qeAKFQdmVbyqIO07Qj5F3Qfmj?=
 =?us-ascii?Q?qEd+tJRkf0Za+nsGKG2VOPkJOyRpZOGXUsQdPu9nO7Z2Axwv2+zk9sdnEw6W?=
 =?us-ascii?Q?nLEScy4zYVZaCcLKvr7hx/yf91jemllWuSVNPNTRiGoC8BppLEEobQdhdSFe?=
 =?us-ascii?Q?ThAkhxfEc+Qk/I0QwewtTb7e0MJ55qA7g+xJzIZnEn2U072QeFP27tUbtobT?=
 =?us-ascii?Q?MEjLX1sPAW8Hy0vbtyj5yvqnD1Mxe6aKeIgR3Z/0LXqeD/FxrErZs8Pf/GZQ?=
 =?us-ascii?Q?XESiQe80FdXg5Np3oFbln6cn9xNAgsYnrLVSfmK+jevcqRpTLVipaKICOT9y?=
 =?us-ascii?Q?BBGzA46+gZtZHRibWNDtO16ppUG03XAmXPdKW2AX8KnkJIkg1IjScIGclwqf?=
 =?us-ascii?Q?7BqAS92Uwzuyj1w0irULGw2E/mhM40jhGmw9kr17BcS3R49+eI23D+nc6Slk?=
 =?us-ascii?Q?O2e9/8Rn5jXz//dUVrNFk2OFHcb19ZbxKsoz7/IDYm+lKTai7TOQi0vUzVxx?=
 =?us-ascii?Q?jI+EvbA6D55wiB9bKZU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89TTVp1V9BZI9b3oXy+0UnNi/uNTPTJfr7H5wdYYFmWovktYIsLU93jyOmCe?=
 =?us-ascii?Q?58QzOl7IgVnmsCMcaxgUY6zpQFvK4mhg6/vZgbHZgMsOQZFODS9iLcBzeowt?=
 =?us-ascii?Q?AstjpBEwMciPtw0JGYgRmZgXz9m9vXPHzIat/fKhsyo/UGlyTBeOVc+AeeQw?=
 =?us-ascii?Q?ucH840Xg2bCtyZlghIsjxw7iRLAIL7Cb6ZMWGfJfBDATiDsyJDOjk32REyhx?=
 =?us-ascii?Q?TdWWg/WQS6AWO+hiJtE2jxL744JIGrGm6G6I0pzMqFP0IcaO7zVjQSAESpNN?=
 =?us-ascii?Q?YkXzoLtcCRX8afPkLPL8idTVg8BV6Zzq5F2DU+j5iEgNRnUY5vwbkSP1QW75?=
 =?us-ascii?Q?b8dYRSAvqz+eku1wb/l3ZqgcEf8vLi1CqxP4y9jHRNbIfF1SPlCBC2gzT9WM?=
 =?us-ascii?Q?Y8RWnSwYAO/Uql4hORyLTzK1AuLy8hgcMk29Wcoh+rBYlsr1Fzelu/XfLQ7j?=
 =?us-ascii?Q?+FJjQ9YH4Ash/ETANUvkWmluyGrNUUuSOobrQaYDs83yIUmkGSzuw3JRH0Oc?=
 =?us-ascii?Q?i5Q5wm072X7CxfSGg6jBMl64u8R1kMlspFImEx0SvanUDpjKP/CM7EbxrLL3?=
 =?us-ascii?Q?QBYfQjALOrEb4zABogeqWQvIc1283tAEsbwE+cJHAO/xBt+PNvTK5a8bBLX9?=
 =?us-ascii?Q?6P2JLcXgKZCzpHePUVtBawoQ6eMQygusPyrK7+FT7oDHOwJ5T2HPQOuAzucU?=
 =?us-ascii?Q?CSybM8lIQsfwxxQYZQlB1B8jllAKEFgSpBEo1N0RtDz+qnuJS6qvBY3apl5f?=
 =?us-ascii?Q?rWcG/alHTXKUKEUcmCphSIHqIQ5V5jROwuo+9LdpCogQfUY2spHDnDDq6vKR?=
 =?us-ascii?Q?5SIP3RGmjNmOniMmBZnpnJYZfx/22GIrbwbHL/cc5vF5a2/bsiy/kEpknOBi?=
 =?us-ascii?Q?EXhZCBVdLEJZt50vS2566ahtQ+zbi2bnlQo3gwBR/+QvA6XQx355LzbGwMMO?=
 =?us-ascii?Q?ee26siepuY/TX0y65ohS4kIZkwup+op2vRcNYjRyWtbgQWjl0yPS/LIfRPRL?=
 =?us-ascii?Q?mChhk+UGP6nQzM2OCJavcf4P1lVaAN04665FdQBU5gJIADGWTFngKy3uiQmp?=
 =?us-ascii?Q?vS21jb2oelj0TmlgpnKhaB1HHNSSw+aHsnc38yOJe4glvJ5cC2WSUIzGpII/?=
 =?us-ascii?Q?/IGBxwYe894dK7JtbguwAyb94+ooBumrIPQCJuzoaz7q2HhPCPhEXNmEERtg?=
 =?us-ascii?Q?8TZ98iEFAgMjsgyJSIKw5hASLqmmUSq+NEuSW84B+nUL8uV45T4kdT/Q6lin?=
 =?us-ascii?Q?nTO3L7wWnf/KQYQrEeXrol15oRZ/aLhaIssbDR29yuu1PPIGcdzGs5Y0gA+F?=
 =?us-ascii?Q?MSIh+bueJtcFnYm2fuwe4WHSjP/htOqqyjJyF+v36xYpvrnNztm0ITkALqJ1?=
 =?us-ascii?Q?oKZIUC9pV742ih69uCXIJB0u+efMugvZeyFfheNAs2PFL5Kk73vu4pz47QjG?=
 =?us-ascii?Q?S0XcvF/DJ34WWikai4tAc77rdeR6VdtUIQ3r/xOi48gb58sffAkl4/5hw7Wz?=
 =?us-ascii?Q?v9pKSL0Nyuscrqp1peQJJUeXfHBYu1tkPFluhFQ0O4MZf5RWgiJcb7nFzRvf?=
 =?us-ascii?Q?SC5uvgHxWJjaj3ApbtH2Prwn+K9cJIx16YM4tcL3iXeuwWGhyuMlxQgH828h?=
 =?us-ascii?Q?4fzixJg76ry8bucdb0pTQKg6A7qpYjrDmZ637qFmIFpByGUjV1Q02TyVJi1K?=
 =?us-ascii?Q?qdiXbBEEGnPzOGbz5XTpBTa5+21uoyM+gHhKIzud33ZXJ/B8gFVtcKaao4fE?=
 =?us-ascii?Q?9YPpICYnWy6pAfr4dr2RiAuEeKxAQW0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa32eb0-69cb-4035-bf77-08de742d967f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 05:20:28.4266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfIb7NIa/Sc3lNhDAO0T1Us9AMNtVDG5lkX3pmu3KAESItCerGMJFil3Ip4fi0ct4owaLJYTWOmsIG8ceUi3bHRk6R4mBQiUo3HCz0k8kC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4914
X-Mailman-Approved-At: Wed, 25 Feb 2026 06:24:43 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

It's confusing to have timer related words along with watchdog reset
dessert function, because the function is only release watchdog from
reset, so it has not related to any timer setting.

Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h | 2 +-
 arch/arm/mach-socfpga/reset_manager_arria10.c              | 4 ++--
 arch/arm/mach-socfpga/spl_a10.c                            | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h b/arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h
index 26faa628a05..9aacf3e2c62 100644
--- a/arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h
+++ b/arch/arm/mach-socfpga/include/mach/reset_manager_arria10.h
@@ -12,7 +12,7 @@
 void socfpga_watchdog_disable(void);
 void socfpga_reset_deassert_noc_ddr_scheduler(void);
 int socfpga_reset_deassert_bridges_handoff(void);
-void socfpga_reset_deassert_osc1wd0(void);
+void socfpga_reset_deassert_wd0(void);
 int socfpga_bridges_reset(void);
 
 #define RSTMGR_A10_STATUS	0x00
diff --git a/arch/arm/mach-socfpga/reset_manager_arria10.c b/arch/arm/mach-socfpga/reset_manager_arria10.c
index da335f4292c..54ab7b13439 100644
--- a/arch/arm/mach-socfpga/reset_manager_arria10.c
+++ b/arch/arm/mach-socfpga/reset_manager_arria10.c
@@ -108,8 +108,8 @@ int socfpga_reset_deassert_bridges_handoff(void)
 				 mask_noc, false, 1000, false);
 }
 
-/* Release L4 OSC1 Watchdog Timer 0 from reset through reset manager */
-void socfpga_reset_deassert_osc1wd0(void)
+/* Release Watchdog 0 from reset through reset manager */
+void socfpga_reset_deassert_wd0(void)
 {
 	clrbits_le32(socfpga_get_rstmgr_addr() + RSTMGR_A10_PER1MODRST,
 		     ALT_RSTMGR_PER1MODRST_WD0_SET_MSK);
diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index c20376f7f8e..320e090e57b 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -266,8 +266,8 @@ void board_init_f(ulong dummy)
 	cm_basic_init(gd->fdt_blob);
 
 #ifdef CONFIG_HW_WATCHDOG
-	/* release osc1 watchdog timer 0 from reset */
-	socfpga_reset_deassert_osc1wd0();
+	/* release watchdog 0 from reset */
+	socfpga_reset_deassert_wd0();
 
 	/* reconfigure and enable the watchdog */
 	hw_watchdog_init();
-- 
2.43.7

