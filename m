Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BB9C8302F
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 04:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E101C81FEE;
	Tue,  1 Jul 2025 06:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="It22vuSm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0F882B18; Tue,  1 Jul 2025 06:55:06 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 395428006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 06:55:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1z+5sDQsTe9BU+v+isLczUdQmBwxJmgLQ6TowqFX2hLHcCLii6COiWz5raaffWlia7qPKXwKk10iaOLzil+XYJLmSdOiGKwavQGVygywm+6DfbcCU1oMNgJJKQ7KE8lH0/YdhGUOrLkedXGep+ERJBkQcGzvqAWEO/n2rsDQNSTJruVsosf+jrAgdkONJoXYvXh79m33lTZA1hhN3d/EJDRXFAyY+BPy+uJgOFJ3kWFpggq9YxcJzEJIFp52koztKT17+bZGWaZNbI1sbTGGGShkYnNQHu75anMpwcApd4Yge3T7zh+UwM5WtHoKfpNzsuX3actAIfyGgqvlsE/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFK/+UP44VYBCVy9BYbvqFixusdG315jRB4786Sa88o=;
 b=UyWLjurFhib9bcv5Zgr2D5+05s3D/DjEfjoXEcxPc1P95IN+TUcMfRXFh0qCSwMBPqPfL+Fo+YYmJZT/qqxQV2UUHml4WPmwfcQuYg6nT0U257Ep7Eh1YkVVmQ4I3YDRQdRorqTQjUtdsF3b6czUo4Kze+wQo20x0E0Ap6SMgrxAF5glFRZbUvZ24QEVQu2cC/ttyXhAJY6kh3penmpH5vVJWHVYS82Y77N6FaAWYr+UPUjjdIaEvxTEr3GmadpFDg83qwT2gtN3VuGKe2n+ULlGozf3swIIjtICoxtlkqwy1sFbyCFsLjLHcNaLiLZKaCtmT66eOrCMk+kHspKV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFK/+UP44VYBCVy9BYbvqFixusdG315jRB4786Sa88o=;
 b=It22vuSmjFZkg0SadLAB+xT3zc5oKTCJ38YQwkiw10+WcACGV00hRpCVpLWUAGJaegL+l4WJAqxFRX7tFhTjGa7XJWpklJ7ryCEEH5e5RHOX2yr4Lh2nRJ3mSjiTwF12X/UsUCUGmWmnib/0SZZG3N1H9Vo1rEDU5e6gqzIRNSPT/DoC9CItvR+f/xT1G/wNV6BGwg678jC/V2vGTqjto8wpE9C8gA5fZnJ9qyEBoiAHwXeK4aCgdrXaVmomw5DER3kxA9yQgyM/dwYETcmnN28C8pzUYVHCsWkXi5K5ZqfUf/0Uq8herdOM2bpGOlngjP9im+weW5yPJv5eYLM3dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by SA2PR03MB5850.namprd03.prod.outlook.com (2603:10b6:806:118::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.33; Tue, 1 Jul
 2025 04:54:58 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8880.024; Tue, 1 Jul 2025
 04:54:58 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] arch: arm: socfpga: Fix header file includes
Date: Mon, 30 Jun 2025 21:54:48 -0700
Message-Id: <20250701045448.9622-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0058.namprd11.prod.outlook.com
 (2603:10b6:a03:80::35) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|SA2PR03MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: ca72ed66-e8ab-48f6-eb8c-08ddb85b6d96
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/7UTNL6N3xLrAohd1L2vwgzmzs7xLAETRHWG1rrs5w7qTdx5R3BMlw5ChxyM?=
 =?us-ascii?Q?RRd9euHvcheXu3cqnejyON6Et0pBCr/S+OgNTZcfjP4t+i9xMg93ORxL82LN?=
 =?us-ascii?Q?PLIOYRmqEQ8sLvtKnsjTZ0xvF6Hl4v8cV4CiVTzBEeuy+VrQ1H8tDYQVjvjv?=
 =?us-ascii?Q?NDq78i+/ALZUhJyc3aZuy2LVOqC1Kpv6gQfzbbjD+lONapvFtAWaMmPk7hW/?=
 =?us-ascii?Q?CCDVsDbtFwheC2w1CH8cn4ejUu3fDe1YVHvtXyYueCRJq2mSEu2WRxDNLJEY?=
 =?us-ascii?Q?Lr9we/L6m6lv9/lKxR1gFxL3IphVJnShWjSFrofN4KgbNpIrwMgKgEMw8AaG?=
 =?us-ascii?Q?8nQC94h1A+OV75xKDyqvjvWZYUvF7y5BUFoFHf7ONWkbF+IdeR6JfP0LpjZf?=
 =?us-ascii?Q?wRGcWyOU8h0MDKP+pc7NS+KnoEuXx6GXO7uczIqK79Y9ZogZ/0SfAKaDwgMF?=
 =?us-ascii?Q?6sJjg+wfinTfAv2sCq2E4RrgXLnUJDqAtr1qbpxvQIm+Qj0ORbvvcVkXJfWr?=
 =?us-ascii?Q?QFQQwyzXMnMhSODf9A+02XKnNXAEyFzCDJLE95mHen3VCJmASa6T+YC3O1rE?=
 =?us-ascii?Q?edUX885+Cq6dsECBrdPgXnbvc5B39xiQ+ht1Tgz7qdhhMonZTZMBCbU9OOAq?=
 =?us-ascii?Q?s1cKnPDwYjzmLLnp6W4UBzdpN0wYAkZC1IOgYO/yysXSkvgpL8lF3IqeW/5w?=
 =?us-ascii?Q?VUUFXiBct8vUII62WUSlqoH4C+MltP8qeh7fup6VF4FQpV08lYeumMJEPI09?=
 =?us-ascii?Q?5drh/t84Qhb3ovLguqiYrhQUooMoExDVqrJFUQbp1Dwk5VJ9is5+hmGwj+UT?=
 =?us-ascii?Q?oMP59z0A+vQBfbPqqZdJC3dUnzLrB/ZrPQ+Q4JWHyOr1UUjm60COo9xH0wcO?=
 =?us-ascii?Q?/amBgqEk4Z3kQrRnacxKxSIlOZ3KvEue2YSfJ+0BnljbGDHFJyR3bl9afgui?=
 =?us-ascii?Q?5FYKLFo/mr4gq6tAK66Lg3bQMqPjnhliqHseg8DHhbiHwuA6KlTk8PB86a9F?=
 =?us-ascii?Q?7Mi1hywOYtLoNYBR+O2nlOZn2DHWMj1UR0tiTEAauBhluUAScuW4ktMn3wlb?=
 =?us-ascii?Q?gDS6DMHx6aC8tODURKOh+R/y8QtZW8hrtnlm465vNuX9FHbBAGDRqRZQNkSH?=
 =?us-ascii?Q?cueg6q0SimYTfthfrCdmb3C7MfWMFQYsRS5z9ECYimETcBazmO88a7g9ZU0R?=
 =?us-ascii?Q?6Z1k9kO9XoB74fcYooFhl5xCOg13lUa0ZUs4TR0bPR1odbugFrAayBXpd0kZ?=
 =?us-ascii?Q?I0um0vbglXf/7UgbRtoQ3TF0VwQ+gUYJ9hopfZBtsMRznFj5k2M4IYQYaCxd?=
 =?us-ascii?Q?gddgaOdmEgbj2no+slDmgHnyCK4mtzsFGeF74EBxh6bu1nfhPqg60otg9cQv?=
 =?us-ascii?Q?TRJcEK8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ZZyOPyaNGJUTwWfMqHNQhbOS5+kwgyWHrosYRMo5R5VxP++yj1714uIoxW0?=
 =?us-ascii?Q?49AD2qG6B+a38Q1wfopUZ+3WyrxUUz0TsR4a+X3rBWAkFmlPx5GDXFZQHYI+?=
 =?us-ascii?Q?QqZ+Y7+C1HKhOEFy7kJEvDwpFp/qSAR9tKR0+HS0hj2Vo6Y1z16+PY/wYcdQ?=
 =?us-ascii?Q?wjqODv3klDkXxFb6ejr17rAKcX6dkJFTJgCv/dlpZbLjgmzpx+c1y5ykYxHt?=
 =?us-ascii?Q?OvLT6HGDLyTuI+540Y1utj8w3wTxE02XjCl31lgB5ewSc8aKXPLBMjMwMSrS?=
 =?us-ascii?Q?dfAUgHByjGHMLD8SojPx5Pd5s1RVEgt0yoCCTuI9gEulYZ0gmxAcCbZdr1Kd?=
 =?us-ascii?Q?M16BRoDS1AMECCI6sXyPrLKiC+w5kBLfYw5ekhId7LLMPmxRQLbACA6Miu61?=
 =?us-ascii?Q?JstZgnb9b81ajm5+txRkr6q7HjP8fWBrfcWFRMWLjG3VY16lnWdnMnnNhicu?=
 =?us-ascii?Q?h8KGsiLWd7cSNjGq3A4YVLs38AQTZvE6QdMGXYbqhAyiSWZpEQe5odA25Mel?=
 =?us-ascii?Q?6vNknk+Ty13EpSGtDF3WjI4JMEMzZJh3PG0Aat6yU3bliFGnZWHMqTeg0r7J?=
 =?us-ascii?Q?slRnHT7kHPpNt5OA8ikLVXC4jw28OV7nJq9nmL5P11fIlh1NEzKV/MMeUzxX?=
 =?us-ascii?Q?zwlBe888bvmYlrXDjBvLPGuZd01SkXgW+Oogplf75/HRHR5Uhf9uIsz3gg7j?=
 =?us-ascii?Q?oJm1RItRlOSIG2Ev4rvX0ptYvNmGOzR+LESvkubgkePsKuYjN4Mw6H+rNyBl?=
 =?us-ascii?Q?hvDVcYQp+ouk2BC9y1Zxn5k8aTFRcMWe6q35Yk5XnEzMRqB77BC3L+nFF8Tg?=
 =?us-ascii?Q?FtWsieuu5hKOXUppDOnW3ixc23hDAd2drrKja3M3V1c85WSUMzw+yEfz/m47?=
 =?us-ascii?Q?s/Wn4AH1pADzLBW+IO12piaUXcsGiadGIuc2hgwpDUDIku5+IGf4/zp683cK?=
 =?us-ascii?Q?yNMGd9MREmt7MNEgnTajqQ9Y2/v8pY+xbTQ3VkwvAdI4ScQeDwpfK750fEMq?=
 =?us-ascii?Q?DjQ57RzXhgx1c2rXTu1yQGNh6NuP6uQP4dOtHpa0y9d9JvZG2EBtSNdyE7Ed?=
 =?us-ascii?Q?71OFwooPpAXqaCLzBYfcINUtWDI1dJ6r4Oijfu3EXJoKk1d5UaszE3dKRAQD?=
 =?us-ascii?Q?UVFAaS1w162YbnIwXmitxfqEWh52PmMRTe0qValCpQ/Pw3CdrBx3HL0AYfZI?=
 =?us-ascii?Q?Aj2iX//85rax5s78D/6oGy80cjV852MVA7h3fXnqqwZp+jGxQB7s0B7a93TE?=
 =?us-ascii?Q?81IeRYE4B4zb32fwBhG3WUpnapnWVkWt5GRiaxma5+pdY3WWlyBcI1s1OD0w?=
 =?us-ascii?Q?NmluPSPKp+Tc6glGVfodRlXKCfZb6/KrI2p01Cn5PfR3ycTlqWOz757xcTh1?=
 =?us-ascii?Q?3y0OTZrC2bow48lmlWCIKBw1/06AFU7PbLSTvzgzhPiuRQz34mOJN3NBxNX8?=
 =?us-ascii?Q?5WFYn7Op/70KbjAgcxw7kckfFs0zRz0Gk6GefwvaqpKb82RJJMT+hgCAWrmv?=
 =?us-ascii?Q?eel858BLFlES7OSriKIlOcYPeQUwXqLJ1XliqcXPSOfSIS9ZBrLK76Wzmjpv?=
 =?us-ascii?Q?k5XzggVxOtF48IukX8XRHWjGKupTpf0DmtLNnUB8ARRzw/FXVwWsWGNrrCyI?=
 =?us-ascii?Q?cRcinaOmjRwfr3aWArE1SrE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca72ed66-e8ab-48f6-eb8c-08ddb85b6d96
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:54:58.0023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NujkvznZu5YrsTkafkoLtO/7wWAHBEn3peCF/qiOTBwKmjoSbpKKVVc9I6JyCrYoXiqsI1AtYXFGqLbKPyqiuJpPIZAW/JEdvcezNiwWYt09wUXuj2htbFsm5iSzb2Ud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5850
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

Appropriate header files are included according to U-Boot
coding style.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/secure_vab.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/secure_vab.c b/arch/arm/mach-socfpga/secure_vab.c
index e931f1043b3..9bad2873a49 100644
--- a/arch/arm/mach-socfpga/secure_vab.c
+++ b/arch/arm/mach-socfpga/secure_vab.c
@@ -1,17 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2020 Intel Corporation <www.intel.com>
- *
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
+#include <log.h>
+#include <malloc.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/secure_vab.h>
 #include <asm/arch/smc_api.h>
 #include <asm/unaligned.h>
-#include <exports.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/intel-smc.h>
-#include <log.h>
 
 #define CHUNKSZ_PER_WD_RESET		(256 * SZ_1K)
 
-- 
2.35.3

