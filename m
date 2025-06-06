Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF1AC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 22:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49626828F8;
	Sat,  7 Jun 2025 00:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="osn/7/7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8704D82998; Sat,  7 Jun 2025 00:39:34 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98E89826AA
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 00:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SztqWmdYuaPPlZUrSIhP4P7b/ZTtaR6CuZnAyqz4o1/J9DC9I7uS4gOOQjBHrM7w4Dp4B1YWavg83BwfypTrcN29zA80gYxvotDPw3j+6n9PsrWG0epRk/oBuPu4da4awBMrfhAh20op9rt00y6RJ9raNiLVkQCQcdm127C9wOmOSq851HUOEDgB5o+eUPtPSHeiTYEW2fBrU/hvwEN3k7M58SKG0ZphMv0tdq2qtuhsyvx1rsKSPlw0RmR34WBJUB14jNzxq3+LqwZu/Sdrb7UXPG/uZaY6SAblEGM5Z1p+T6MTJtnZ75y6m6jXohHPt2p5pdQADra/v6K8dB+PIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d21gLfptpsKUIAAw7SMzMci/KRiAB++1w0ptcWpvK8k=;
 b=S0QfzmD4IUuT3VfePElKs4U9/toRLv1n8Z5JH8sHFPc1jcSzBZXmgvFEkirSS1RGkpzP01M0+Zg1aBnkxDQIRCXROdm66MJ3aGf8nKFJDh2sTv1JUBHrZwlRFy7n+Lg2FvXLuMHCuy1CmiJiP5eVmPjgmldvK7sPR6jNKn9XrL4BSUvfXmZxwWJCVSD4MlZhIn2U8QxijnPG83niE43rZUpFYQkgin6NNvZwh4rvNuebAIzqtSFYF2hYQW5wYsjQDK5DpUIWJa0Pdw/JInq3UeaOLOi4BOFRMXFHz0r29bJwuXkWGfyeI0Nfv3M5AdI4+vRGUN/EeS+D/cWlIuDusw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d21gLfptpsKUIAAw7SMzMci/KRiAB++1w0ptcWpvK8k=;
 b=osn/7/7rk0D6+MK3kFnJaEJpqnU+c5uXi1d+Mnh5lNMyeDtCGP0/7qVOtkYx/GWQllUJ2moE7+uBd9mUSHp7JW2Pa1F1YL46N3YQKzSgs9c1K32doQ8mpydxuYiB8iReSoB2h90ZFV3lPTdSBacezACXi3eMRiE5rwqIWIljt/sWhG7PW6K/VfF+96YLAeQ4WznM7Wv22EcATgrYG6+GW+II2/shPoCmGiZbBrbU1ZhBf/Fyy5os9rdG19HQxEzOem+5X1BCqZ8mAvPz+wvQA1xnfSYOtTAqXeGdoVPxwvFcC62724JCj6PYa/J+86aWT2yPj4dWqo8rB0mYCaIBeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6373.eurprd08.prod.outlook.com (2603:10a6:20b:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 22:39:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 22:39:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2] arm/airoha: reset_cpu() does not take any params
Date: Sat,  7 Jun 2025 01:39:23 +0300
Message-ID: <20250606223923.503086-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606210805.GE1382132@bill-the-cat>
References: <20250606210805.GE1382132@bill-the-cat>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0027.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::7)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: d95e8f64-e69e-456a-6400-08dda54b0055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pluhTyFxfsEyYv1Wf9+zfvQqWrzxIV4iCmn9o5qYmDJKRHTXZu518TogywIT?=
 =?us-ascii?Q?rwKXBc81mStRZefoty965xE29wK5svZr/gwkRNTKUUYe7OoORHxYTkXvOD1H?=
 =?us-ascii?Q?qDzLcSvpqImXvfbmR57NI+T8Wdr+xN1uzB6Fo+QVBnVggEm6XbADFtifITCV?=
 =?us-ascii?Q?Ia4SxG1iDHQU+atjb9pKl7CY0quFKetRGwjaipP7/effSCfSRLGpGG6KyLZW?=
 =?us-ascii?Q?ySFYGlSnB8y0X2EfKD28UsvsiSTTjLkFIBA8K5/1vdHnY0QoQBv1bDpP9sDO?=
 =?us-ascii?Q?0YAB+IzR4QyMViHW1XBDeY/ekQmc5/J89xjf+a6q4GMJrRPh12im3Ye5X4Gk?=
 =?us-ascii?Q?ckKPDqOHlkdYXW5O5szWd8q9YD+7i2Gfu9UKdMz5NAHfm0i6NzotL4CFaHYy?=
 =?us-ascii?Q?Wko2Aq2SH9mMcPvqA6dn8XLGpn2Jg/sG9d8Zv0ThJZPMdfHoZ/Fkvaj5xdHz?=
 =?us-ascii?Q?PhthgX908wc2YYK14qfK2I9p46YZJFwfqTQMXobMqvHz+LCWCAueJA35iIW4?=
 =?us-ascii?Q?QFdpNrf3LBCerQKPgHCn7vjQlNO+O7mDOH6n7zTzkhrBeFC/alWqYZ3Oqj98?=
 =?us-ascii?Q?IMHBr1mFZag+CapOtSUgnC5QhLNyTZqIgBWu/6T6bNlEwaSo0HoM635RxC/Q?=
 =?us-ascii?Q?/h7SURSf8RXNefoUna+X/vf+NpyzqsEjifHV2eYFwxlYM1c2JPVgvj/SMzH5?=
 =?us-ascii?Q?R7uIsVP8vJQ3B4LTfDFp3LxQs0Tt6WYtR51LHNx538M0Y5fp+oKTqN+VPf6Y?=
 =?us-ascii?Q?v/dGB/79Fdin8rjCW/+SdNmdsZuzzX4DB54ls4agDU/e2K7dp2ltgR8YjqIh?=
 =?us-ascii?Q?PN1sKjJiV+EEIkYInf55mfjlF1UfZGB8Wz3FX3lRrA7XJlJnq4h79XuRfngo?=
 =?us-ascii?Q?kQaGuG6L7kTpo1MJCgYJkLSNUQnlzYCr78GvB4qWsi/fzKPWFH8t+ASauOAe?=
 =?us-ascii?Q?UvFyj7/WD1znrFyQOuNzyLM4OAgBZ915JOgt7Fk38gGIBsZXEYDfGuW/XvS2?=
 =?us-ascii?Q?xDxTp98eZFIsaT3Wa3jzOmtHWEQ+/0gHYOxRLHy3AvAHx8sJd1JDZU8JNlgJ?=
 =?us-ascii?Q?kSu8ZCNPCjptjnHkGHUq+oc5WXgKeduzfXUioEFeWS8f4pRhSYbESfwVuJBY?=
 =?us-ascii?Q?Nm5hpgI50BBl7lAKwRTOa+sZefQgsXxxd2SBBN65QTkpx7FpBqy6AkQ+zvvV?=
 =?us-ascii?Q?0RvRp54JWO6pcLkLSakHk1Po7ch/kHKUlpPd+Kr75PVfOCqd8OkRPh22dK/U?=
 =?us-ascii?Q?YBRrON1pj1CMdmucCiDUhNEwSjmC/gA25amGpPo4fDQKAcyV7oAObgqlYVLQ?=
 =?us-ascii?Q?x6P7M4kef4ajTQ86l6WjL9+BvYI0AuODzXjyjeyNrA/Fo0ASwFIqE5Qh6UdO?=
 =?us-ascii?Q?fJHFnImaD2Zl3I+x4+HAQF5D2vBFATu3NxKihoyDBnm2CAvP1IKv/FlOxSiY?=
 =?us-ascii?Q?hMaxF60zG16OGJTXhkiMOMKmSztFOH/h6VWIsQPqrUiTjdb/kHWYBA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pMWOokghUFmb3A2Dy6ypwrXtI4mT6JeLAQSoG6aarrFdK5m32oEHb59dllx5?=
 =?us-ascii?Q?nc0NEdLzCinpua4jKw7nzgsOeeRM10U96+SUOA7hZfJOhXbBQCdtqkr4yQTR?=
 =?us-ascii?Q?V0gBs2oPFFtrHiMJNWdGYMnbdaEK5tr/xPyjQEm5PP3ivQcaJD7G/2PDdZKA?=
 =?us-ascii?Q?/QJcDcM8QjevJeMuLUp0EphzwVCRGwJWKADXgnk7Oe/qO2ZRVsiMdim9pbrV?=
 =?us-ascii?Q?kIBMBhuiVXOMi0CCTRWFo2/3BZ65/Ssat9rao6uOwOHoNCIRLbdanOM199jS?=
 =?us-ascii?Q?IQENv0kfSdvN5s6sf+SNuxtgQV3QSZYyj4vpWUGk6znH6LzCB+mx59cIWJPJ?=
 =?us-ascii?Q?g3+5Ss1nVOeJuordl2LsronwrGqxnLGCJpsycZIco9GnZwrGc9C6TYxxahHZ?=
 =?us-ascii?Q?3KXHhQhMjCntt2S3yO7L5bZf13H0XPeBPILJOY3n41NtG0vi+7xr4B/k8h/E?=
 =?us-ascii?Q?MWrO98JoXSams6mG2uyEAaoCPoALRzit8mMpc4HK9HmhMXWbR5gfgYWo8TjI?=
 =?us-ascii?Q?5JSk+0uJcHoBeB0ECDD/NI4csxVBPyQ/jVyuNBHxHs++y5BHGwchNa5BQ45i?=
 =?us-ascii?Q?nI8IOQHEgw+VENtxt69KnwWkebIkPZsIflh/bzCe5kcsLSC0g0Ve4uE+aHMH?=
 =?us-ascii?Q?r3GVM6uKyCqm9fDcmL2YteMrgG1w94KSA3lH+dDETpO2G8nPEiNVbURP0+iX?=
 =?us-ascii?Q?oFBxk5WQ1c4U9GTdYszUtH9AoMku3oYSd18fiEfeDa0PBFh26NrYZCxBSUZI?=
 =?us-ascii?Q?bzIOaH+iUCF1sc11e/l3Ed2UlA9zpX0nJFOPnj06aJVhd5WHFQYSoQCGtaSm?=
 =?us-ascii?Q?K0quuGBFO9klnmU5F58SYJsq2U8sRtyEp6c4pvhwF+t8ug6vdgnIhxsUzSbv?=
 =?us-ascii?Q?NG3XU11uP5e/jLJyNnw8cB5jFv6ME/2MzymyNF+Drz++N0ZpBDIuFWjHrzoX?=
 =?us-ascii?Q?Ed5fAfR2Swlf54HU2i2yImyYKyufbBhXOBW1ocpHgtnzUbkho39PTxSVs1eE?=
 =?us-ascii?Q?yYOjbUFKpjAd00wuxJAj9SwGHmo0ORLMYsy31r/2AgAumScj952CbAJCbnGj?=
 =?us-ascii?Q?X4R6z0SclsgjK1AhUqT1SsEuz5VMXYZsL5IDPw32LJZdocvXXH0niNBJ4nM4?=
 =?us-ascii?Q?8npnoquqUL/KNleiOMzZOlGp8WbniiPdji3eoRby9/5ZK4jCVrnXAdpIMUey?=
 =?us-ascii?Q?9PggxcY5vheC+BtTKsRgFrUpg919/M8bZH83e53B7qKx30wELc6tqqj8ns3A?=
 =?us-ascii?Q?yspH4hAyeJqCK4DMHuruAP8VBCQ6zEg4Bhwh7YlXQEIQ5O12GOgmTMpqxnTh?=
 =?us-ascii?Q?VmUrSro1HFN1zfSHaj/Vd8HhKrLsxlZoDAuHOGmiHGckwJNCIfcXlfvF2xWg?=
 =?us-ascii?Q?jyg0GMuzyza8eBACyOkbyNIAHQaLWu3SwNNS+MFmDSU3MVvkxHDdPbZ+/DGq?=
 =?us-ascii?Q?f5ru6Xl6n2UjjLtcqSr8ktKrecG1jHN6Hp8sG+Pqbw1zwR4Fj6CnHlD5cy2M?=
 =?us-ascii?Q?K8KpUw4Bh5FUZZgzYjPGJrn5EOIXqKPl0QgQDGSv+FXY1ykIapho+uTY61nn?=
 =?us-ascii?Q?IUk/hyYa20a1Z+1gXCxWwPO/WTrV3kG4fKze8j52bBB7PKV5WLIr7HpcgRLo?=
 =?us-ascii?Q?JhDI5tWeGhrb6StNLcYwaWw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d95e8f64-e69e-456a-6400-08dda54b0055
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 22:39:30.6119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fI/4zJf5rawZbuwxlq/tacPGdcklGgHkm0W6j1ArbVwE5TZRNgfr1Ed2tSqRlL26qvD5sUKFvhVMUuB3/sKIwm7qRWXHKHJkz55re88jTCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6373
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

According to include/sysreset.h the reset_cpu() function does not take any args

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
Changes v2:
 * add sysreset.h include

---
 arch/arm/mach-airoha/an7581/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
index cefe9c6db9e..d149e0ee3c8 100644
--- a/arch/arm/mach-airoha/an7581/init.c
+++ b/arch/arm/mach-airoha/an7581/init.c
@@ -2,6 +2,7 @@
 
 #include <fdtdec.h>
 #include <init.h>
+#include <sysreset.h>
 #include <asm/armv8/mmu.h>
 #include <asm/system.h>
 
@@ -21,7 +22,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-void reset_cpu(ulong addr)
+void reset_cpu(void)
 {
 	psci_system_reset();
 }
-- 
2.47.2

