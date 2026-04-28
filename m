Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9094DFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCA9846AF;
	Tue, 28 Apr 2026 09:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jRYhSOhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8872483A91; Tue, 28 Apr 2026 09:01:01 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3295084150
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:00:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCelex9/jVEre8YrTLsAFq2/0xVcrmjH+3VQGEBBqxwU3dz6PTEFdzBORHw92DC1MI4RWbzAqFedXHO9dTIi3GiyJvKbNVbx9ypFvu8dCO4wxwOUfjyHd0zDQgefIvKgwyU+1Nfxn5kI4ESBrbNPT2GulT72aberUuV62f1c1ruqL83eKxLhJPjb/3N6PP2aQF4vTN3Gk2xA6bgX0dDX1JV7AgRhEXvCXHcEwZrlBi9y8BbQdcBHlMoGpYMROSK9li5yufoNmDBe4s4vNQWnUjq0ozCT3iH6mUId0jHDkr1yVAwVMZxtBZ3Vvn9qdpuN6dTgw9Gn7i4y3vVL3MMr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ej17bh3UtQ+A9Pc79SOohWRNv9uBxh8hpS/wFeUcr8U=;
 b=mWpiONp5XEvTI7LN16kzoTAqBfmGJBIus72OIHnjX5xmkI1w8FmfuRvSEO29Dnt5RsuFaXocIAlGQ9zBGkaV4mCJM5+x32d+vwOI1xcmOSrJsEPR1uigya6B+1S4aJK93vwXfn5Zol4DFRFK1Xqs/a/lyCvofjxilTefNH7iwKqejimNCitryyo05vTyyGqOmpQRLus6MGLx8EAVyTjhIMsLgsrOMnJGWaXFUlkgTRtsyVO1kseFyXPFK2aPOdlFLeJUuPouFN9STqitfJ7VUyZe8cOGTDfi0KSGh+nwqYE4/gru6tTvhU9gSlggdT/+BVA2y21uLZyqFLHH/YMycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ej17bh3UtQ+A9Pc79SOohWRNv9uBxh8hpS/wFeUcr8U=;
 b=jRYhSOhVRc7QVtNDND7LIHpM3bFBmiTWAZie9Ldck96vXgzrmP86kooWi7ONLqj6KoxbFY4f8fHR3CcmC2tX2o9+ryRIh888vMGEF0MB5naFmIzjhBGfeARaemg3ZX1XjnZJk6p0/shSKGPxSDk6SaLsyYWe9+THiV8u9ApGoQSQweQ0sQZvlLovgclID4vFMGuKlLThn5sJXU9KFfIFTu8PoZ45cxYq+D675xXNgpfpiIli/NXfa/cjQ3qfybpvb4AvvZJ58Zl5hBRybEDD44jhCYU2f8TcG/oYY/dGyPsmHPAgXFK0pf9sZudWLJ4l1lKmJi+GDibGgKqkyitY8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:00:55 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:00:54 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 6/8] arm: socfpga: n5x: switch firewall setup to driver
 model
Date: Tue, 28 Apr 2026 15:00:15 +0800
Message-ID: <20260428070017.16807-7-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428070017.16807-1-chen.huei.lok@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4202c1b0-f3a4-4589-fb81-08dea4f3e402
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: qDzwU5h7O1H9Z1jsufxQlgEqkwV4LEuDHsLWmBpyugiHR5RfYjZsyy0AARsTyq5J5nSZAFEZn+Yr1Ln9UFDpRdiDfTy+0PLqxF70cdoPWqhPVwZx7ScXWEZV4ytBt0lk2FGVbQ+3at/Y14iHUv3/5kFQJ4Ly6CWzRdEfFO8koDEzStGXQ7UWtgCJka73JjL6fItLpfbGrAjm3OwWQyOvlIwWl+EVjfwPwFpC6mV/Bs99RfOBDJqxAmrAvn5pUoaTL1n71X2e45Ks1jkSN0gZQaQ7nXcIdk4g5bAxz9fjsIMGzEhL9vuzA1TmRooy4d9Yg1GdkDjIeIBei3TdhKu32vvvHxHzpOsttaA1fZ1KmUZnPxwUg7OR4KhogQcXjgrq+YB5Hbk+SddTxEGmCCgk7Zvk9VwgU9gRei4P+JAJ3eU49rerJe5MNbPWNGstDB/Ivr0VriKeXC7yuNozcjK2RWedn6rN1SueZeqFt4hR3xdc3gcpmOs65SftOegsPqvbHSwraI9071Zrub1D43IP6Td3FQ154GUAHs9DeMYtRB4WOPsgjpODaQs9x3/+ffPxhDAIq0yYDmoX7N/w/nj+LzxD+9Y8wEJ3t9Ii9XfLc/zkPjYjiQpQPkV98f7wDk0XCB7GJ0qSYHWWHBWp3U+CI4jOB8cimX09f7lv+GbDwlAso1+3GniHQSFpm2+bsSpDFyk9vmFoyohl1d9zXV1rxzQad0dhEULRRHlIGZ8Y5vk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGz1+Vu/ahwDRmP5QJrZMKZGIBiplEjL8Qz0VaG9LkiqWltGileefpFq26KX?=
 =?us-ascii?Q?mHZDPCHhsC+vEZ7nDQLPd+wexk313YXdCqBmhbGSkXEeRsZAoF7EwWMarBPL?=
 =?us-ascii?Q?OxI3zfjtOQmgralFTg8USzpFq2V17m5yRTr4wzNt4oJJSieC0a7lySlafXj+?=
 =?us-ascii?Q?3AK68gzgZ0ho1OcLnwiYUgpZIwv1skvtbKwF2+56gSDsxAXxPTxeZEf9Arqe?=
 =?us-ascii?Q?KelZM5a2fxWUPx46kYlW6ksRdzYlcKbirwT3j0HI3snibLruyH0j2g7zKa37?=
 =?us-ascii?Q?Wa6oDjjGtf/UOY5yI4JhZwsWTNBPrdeA513DMnoVDZ4l6MxIbmtm6B9S+Non?=
 =?us-ascii?Q?NSzgIqOFh0f3QCy5PKkPWrHVCo7vE58320KwEDq0RhPAKEZT/rdxGfcqDnwb?=
 =?us-ascii?Q?r6+PxR14UlkvatDoNpaSFtBWINUXonprXoXKuoALQHLxcolVBXK1JOFBhjRw?=
 =?us-ascii?Q?s7y4uz4A5P3jcx9ot4AJ3OZHhBMlrvOnpI+nxF2OdSgO6YKdYBoKxdx5VZpW?=
 =?us-ascii?Q?OsCImQlby125TG07gN9BHyrqcu3qn1JOjest2OA1lsdN8HsLva5XWIBUQc46?=
 =?us-ascii?Q?zzZxJobhfmgIUTWxiwJwoseHyLPdGqCy3KtWRRqc2Y/XfanmVVEoUDQJ62a+?=
 =?us-ascii?Q?cbsYo0lRZnFqfUt4hr8RtlRZASTn8JaLfqGnDWYSXbyWe9y51sGBJ6gEMk2G?=
 =?us-ascii?Q?reeuFeMbkup2T8PkLw3/FBbhxlLse0nTF6tkOBXqhG+liy90Oe74D6U1Va1M?=
 =?us-ascii?Q?rRd/jpa3wWzHfoJ50lj6GFi4IaEiPL7J8p/fv5CdckKJFoRm/0gjbUkN7a6E?=
 =?us-ascii?Q?+vMFyTKBzZdhCRVW5RUtrrOJfodjn1fGfJNzyDO7a8+AovRe24RkpOE9FcRY?=
 =?us-ascii?Q?GgTRqdb4EJaVISWBDVJ4drfw2Cdm5IkV2yo8yPVQxYe2nuTs9MawYFMkfUOe?=
 =?us-ascii?Q?8EPOCI8e0KfZr3vSQGoBtQPsNe8Pba9HpEnE9BFUUiI0yTLpXJ4dx7d3pgn1?=
 =?us-ascii?Q?Dex+6Y9kfwTS/KbQflsqHDb5fksvPULG2fzCCZQFBMHvrxa6Wr9z1C51pAhn?=
 =?us-ascii?Q?FqaVc0YOsi/XYCfp6hyUBj/+R8IuiZwDDTT/SKfeJw/QddFpSH/PPSKfG2VT?=
 =?us-ascii?Q?sr/YkgGQi2G5ETmgqolQNtKYKlkEzh3NTNm58HEpNaHNJxmp9Ywt07VYeXs9?=
 =?us-ascii?Q?Ok7gitLNl+wBqpE7yd9zhfO5jN55AAzDCFR5snVQwnFoNsZjoYFuLklxTSVg?=
 =?us-ascii?Q?8jntT9eldHyOCCmXLvu9r/zJviAacVbHpKjxr5Bp9gqMQzP70SUU6tRu8xZz?=
 =?us-ascii?Q?ZRRoGx+A7ITEPDD6DD6Fn0AUrHQoOrMdev6fr12kTA7Xx9aj3gZvFPQdJYNu?=
 =?us-ascii?Q?VklEMUn5Wo/dLMOjQmJuM38PCkvRT5NYmHUA6R/JvQ7qH+ed1CWs+zEbpWEv?=
 =?us-ascii?Q?qG0AR6B3OtIJoTWDOR2+tJr+6wfRslT9TvwPcYdwBkTaWv3wytQE5ifezaPD?=
 =?us-ascii?Q?H8kS5fSqbqRd9nnZwEZ/b5p347A/TfVcFQncSE2wX+Nn5aEdSaZvORND157B?=
 =?us-ascii?Q?y3umwWUEK4hY7ERHvntJecN0hosw2GKH2JblYflbfDXFxL17uKViOnpg/hFG?=
 =?us-ascii?Q?jXsbDn9ViSB24jmyvRrVF5KgZh3ozSQPE8/gYLE0UCU/hJUJh45t9zB5yE42?=
 =?us-ascii?Q?x3V8L5NjKg0DXie+FWb2ti+QTrjqIaSUmkpIHDEjMEx8bMW1tnvdXxzxyZZ6?=
 =?us-ascii?Q?eJHHQEL+7Ua04ZLN+tDnAXjSitmZqyI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4202c1b0-f3a4-4589-fb81-08dea4f3e402
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:00:54.8034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkYbaqTxRvDfwgyw9Ex6XiSD6K2TdVlB6FnSD9kXxxP8aG8GmBvphQOp1N2Mf3tMmqkLj+HGeO7bTemlz5d1Y+OMOu3S8vw9gOUZRpFN8JE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Move the system manager and L3 interconnect firewall configuration
from a dedicated firewall_setup() function to using the driver model
(uclass_get_device_by_name()). This removes the hardcoded firewall
setup in SPL and relies on the driver model, making the code more
maintainable and aligned with upstream practices.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/mach-socfpga/spl_n5x.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index a49be837921..f776d0c0327 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -69,7 +69,17 @@ void board_init_f(ulong dummy)
 	print_reset_info();
 	cm_print_clock_quick_summary();
 
-	firewall_setup();
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-system-mgr-firewall", &dev);
+	if (ret) {
+		printf("System manager firewall configuration failed: %d\n", ret);
+		hang();
+	}
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-l3interconnect-firewall", &dev);
+	if (ret) {
+		printf("L3 interconnect firewall configuration failed: %d\n", ret);
+		hang();
+	}
 
 	ret = uclass_get_device(UCLASS_CACHE, 0, &dev);
 	if (ret) {
-- 
2.43.7

