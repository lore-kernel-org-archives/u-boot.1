Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221AFC5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 19:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A576C820EB;
	Wed,  4 Jun 2025 21:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="e0MmoxS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B36382B33; Wed,  4 Jun 2025 21:56:30 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FD9B82AAA
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 21:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1A7OLAX689EWabyFJXqTmc/koms72hRPGeRSqELKTq0K0M4KyrbkuezILb4MOXoqWEwgXjTZ26R8gF3hZz7gGjIlQEsve0eJmAIKRtf4N6XV6xcV/T/NaE9cS8WwSuSFJ6ULcQAgyYEMXbGZLdd9VCv8TUsA1QJYtZcgPrPw36lIgjYFohsRk0jJxsTUM5DWSMoOlrYYPKJmtC8txhc5Ybez5tTjTMr8OLzXZPj1uxOpbQNUpP0+hfTTYxiwEBi0Li5JP67jT/znAr0uaocv6ot+7e88f1HvfSb9uifRS2Km9LfcZ1MFVObCcfk/hofRyvjWrqJ7MaMx8+BRBus7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FYUPTD3zYQ/XSXg5lYYXoD3n/PXxLNw00QwkNS65Vc=;
 b=N/CKB5CpUeiZO5XwVKRMVx57UZ45do7kuG1tI5FCopO4EuTRJ219tUX3uRMltfRAbjpXkleM527r30X5nIw4zWZjA0YwTFHXAwn9kphtNpKLpIChy329fGEbVmwlbWCw3TykCQQ3ChVQCvKHHIzhxb4Vm9aQv0ImrPyA7QiLh/6fNMXUQEqFxLGwFDCYjJ2Ak2VDQCSij3xDkJWeukoSjl8USCPTmtnHDhMU9UnGUoI4o9QWVCoA87BWlRU+5fglnqLcZ+nK8vbkYyoQ9JMR7k1vKO1VSmdMymQn2cvQ1PEM6tyDAIWJDYCLF0kntdWN6EBEvfKXH9EuG/WVgum1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FYUPTD3zYQ/XSXg5lYYXoD3n/PXxLNw00QwkNS65Vc=;
 b=e0MmoxS83CgRWHsXoSOC5KtTihX3xQMlS3mt+bj2PhqtShkMd92GupJuNl0xXF7Od4ZjhrqdEmhdoU0uoUMkOSS8YTN6zYwpVc/0VtnKhjU0lbkB96Bv407ynn78PiIyXnnZG7g8vjEWgoSkJrt7piM8t//0aw3hZYV7i5j7fbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6940.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:30b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 19:56:26 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8769.025; Wed, 4 Jun 2025
 19:56:26 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Rick Chen <rick@andestech.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 uboot-snps-arc@synopsys.com, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 10/12] lib/trace: drop volatile qualifier from "save gd"
 variables
Date: Wed,  4 Jun 2025 21:56:10 +0200
Message-ID: <20250604195612.2312979-11-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604195612.2312979-1-ravi@prevas.dk>
References: <20250604195612.2312979-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0029.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::17) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ba08e2-c82e-4ddb-c6f1-08dda3a1e408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3SNgX7kZ0phvx8qVVT4o6WzCwm0s/RF2By4NMEiYQzPTdu8RgvVyd8QuXAMc?=
 =?us-ascii?Q?1I+2A2uHE7U/0pX2VZjucZBtzrOqjpGlsfLj+iCfcocgMO9WMX6jOmEAHwMu?=
 =?us-ascii?Q?6N3C9dHgE+Ub88qMM0y/ZipvYW14vxh5zbnWP+ZY+ikWRJjgJhzew0i1/EBX?=
 =?us-ascii?Q?F+dkpa4RQx4bw//yKL9tya9FW4GuzD4FxyLd7MVxxmEnaq4GMfhzKU5Oi1Jl?=
 =?us-ascii?Q?yR7ggjKeirWjjEcO8dbJpU8YyiTrTR66YAiL/yOZyXPCnzSVVvbRnzrxVLUx?=
 =?us-ascii?Q?f4fq/X2OKVIhQtcr8fTr6dAl4pxHVWCGSm1N5dJHXn4cGt8KW3zT0w9e5gvl?=
 =?us-ascii?Q?18VIedXVN6RL+a/ScbAtSB53RVHgfx5yIYBvBlFwYUDCCfNk9KKkpKEnAuM3?=
 =?us-ascii?Q?LTBU2ln0a19BD5w6VTuqJ0++vewDlkR22EnqaDBT1dul37nWKh3boeqegtBk?=
 =?us-ascii?Q?9+wQVjOhQgMTa5WvSI4bAF3aqO80r/LZ7lMnwNh4zgurTF/KaWeYSj+sADWL?=
 =?us-ascii?Q?XZ/dbaq8P5V7n8sFN9/NJV1NfL0fbv+RS4yN5qnhzrB6PWuh3TFV+78pEYRB?=
 =?us-ascii?Q?Nk4c1NaCZuZHnPhFk5ZD07twrnSUrNLiGEf26HEcIRn+76JDLm+F/ekk1yiI?=
 =?us-ascii?Q?EcZjbv5RCk+xrxiZ+PmlAYxkvnacrLI0KfW+VNab117CaYT306rqwUcIbkZU?=
 =?us-ascii?Q?5EnxG7FfTo9nZ2NvM4MOdGSSsxYO+c3KvfsejpOcVGQOlh8j0aUd3yjo1Ee+?=
 =?us-ascii?Q?sBiJ+ROBU0oX1KHaWP5tVFYmaI8JYq8R4y+ZkHldx9KoZZwikECvNshlgxGl?=
 =?us-ascii?Q?+OrzaU/cBeatFWAkr/8UdCq+ZIVIeZuyRxZhC+7J7NBE3BgSQKD2ip0WuR/9?=
 =?us-ascii?Q?882AfYadr7UadrgVsl5IJs6ODX1PXYZhOYdcU+b1dAq1zvOajdhBswF3nBdP?=
 =?us-ascii?Q?7I5FdbIM82kQmJnumdWFIAbddRPe3wHe+uC1+XomN0UdJjlMEfDpBmw14P8S?=
 =?us-ascii?Q?ea19ZURoqaVtGbCMAwju+AGFjsY8aqd7F1D7tUhcrNyfua0goTiNPRpGkhec?=
 =?us-ascii?Q?2XXV3XWfyu8qcwo6rFWoxhdhk8tsqJFaaHCpy3GQKS7g/vfvnDZv5GD/mvrV?=
 =?us-ascii?Q?fVVIXEcf/O8JaltKdpxBTNiqOedAJqKupA/GiehZU4sXC57TyT9+MZG4o1Nv?=
 =?us-ascii?Q?oHFVVDVBodyaKv+n8nC8PjiCckGZn9R6vcjofkPiMMW49L/lO+SuClPXNt8K?=
 =?us-ascii?Q?6mnceCF0aqS7fZva830ryMJrDmimDL+tmiqCjhtm4OBmzirZWgDPEXNRsxZL?=
 =?us-ascii?Q?aIG8bOxGuEY3iQNEe1aupSIxE9mdm58XwfZrkGzvAhOIyUgVRH3gX2LOr0s8?=
 =?us-ascii?Q?Tpwk6DIui1TUuy/Mxu4emZtPXW2kUqhBlar3g4mGZBy6woiEMVDCzK5EqhlU?=
 =?us-ascii?Q?3dcoY8N9VIS1g0sGshUTdyDQgw99c8ECxBcG2xEpGhO8AUOEHrF03w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSxr75EFqufwm2y6tdd4fRT9nZNYGuF6ziK+h5Sz1697bJqrIjXimaNubwx9?=
 =?us-ascii?Q?TQr+4PEbwAtDIhlz8Qk0JR+Vd2EwU4zCPWL8e7yqcPI/XcOlZDg5hDawduJd?=
 =?us-ascii?Q?iXlnZlTrQJmbDlaJ1fk4F6QBDQPgrnGoR0l4YrRCI1CIlGyMz8iG6av4o4Do?=
 =?us-ascii?Q?Ih1huSEfQoXSR2vO32kw0OpbuVElameS+pQmhv7J1nfp1jSswi/2WZNKOa3I?=
 =?us-ascii?Q?ZJczMDdqay6I3U2O3FA8lcZasT3He/HM+Vd7/HIV9PwvGSxi0CiW6h+RsPc6?=
 =?us-ascii?Q?HcxJNwqCZ8npLR05xU2csweu/mbGWLuKCBrq8ZUxteUtAju2F3b+0n5hi3Ws?=
 =?us-ascii?Q?1OEj8C3H87JkqHOTG565N1xrC+wUY8fAoAuHQWG6qQ3OxzV5UoCCNZPZ2+U4?=
 =?us-ascii?Q?cY/FSYJE9NZUab+bd/0rsUiG9Ff5126z81xcadafHX+P7lWqtG2bubhWkKjE?=
 =?us-ascii?Q?NE07/HxiKb1p7tWWKjviI8uxzipnU9RdksFqKrRkdgBAOib1oX7q6Apquwg9?=
 =?us-ascii?Q?tvf2IdM6ew/q0/v98kShSxNsLvDjuWbNYyIEXV9ysRL1b/lM+SANlkdbwVCl?=
 =?us-ascii?Q?o8pdNmLJjDU5DB0z0PIJZTlLemUjYli22wOui+b3YJkBEh9YyworFgiZ9PHD?=
 =?us-ascii?Q?SvsLuER43W5ehGdPcymdxvheJ6j09cgs1DiKgsp+C6D8Ohlsry+ATq4DH90e?=
 =?us-ascii?Q?etPaGx9n4edpTkGAQ4tMFQw17Fbn8rWN0zvKX0CgwZWGYjVsIkZp0DFfCYyw?=
 =?us-ascii?Q?MLqsIeTE/V+sCaT7MFGqlPOH1x/rjWC2dEdz/PBnBKzF3jShDJ0bgU+krQ8+?=
 =?us-ascii?Q?E5bdOHTd0KVTKnCxQp+VhK5mvWiQHhUdIsLiofB1Eemf73Q5Z0/TTFydU5NU?=
 =?us-ascii?Q?P5sDaphZD6YjxRPi0y26Qh5r09bZQwOYW1nDPZz/uXD5ECN+0Mz1C7YWN96j?=
 =?us-ascii?Q?f2icqdOBxkxu/x0GZTdJuX3lJyWx0WQfGpjFISiEWlxsso/UnpxebD2AW6J1?=
 =?us-ascii?Q?iAhmKJRAnFgS0HydUIynOjdqCQH755HwmQNB1DiCYdd6WOzqF9ZnJZip6QPg?=
 =?us-ascii?Q?Ek4r2utlhUC6v6F/oK3ZdhvWe3cPofhZwUa1RN/lHfdeqKGnO6s/fkYUslQd?=
 =?us-ascii?Q?sxkfgxWTOjiVg2EVaM1fauoSgByejxfdpc+2+t4jM8VeAZTJ80UpzuOXOzzN?=
 =?us-ascii?Q?dg9Q96NM0CZuoRyh1JMfhcUqFq6HXvwy4AouPyFj2/Nog8RRf8lYYmauq+dU?=
 =?us-ascii?Q?CbQy+wRltXwqOo+n4oAAPoz/TdmaJEw+/O2DxKSiATpKfQAKGgVK3o9H8TQi?=
 =?us-ascii?Q?JxHHVC6I0YjHYFrO7BW61tAzT9WiVgLQjoWd0qGfIuAbeyFQnT4J0/3/cVDE?=
 =?us-ascii?Q?jfk7lnN3bwgZ2Ox1hcmymKLtVjKYWvLFLrSOH9A6rzemNs3pFhmVQAYIUtwY?=
 =?us-ascii?Q?KlRkMPvV0SrfgFRVqbr40F47+TKIT06zsD1GsvuzXR91UyNm/6PC1RneTe/B?=
 =?us-ascii?Q?wSlnACU6AqKQPWtoNSBqcVLvBwBpnG4dBcmuofOns/iz35K7N0uvoC6j2wjc?=
 =?us-ascii?Q?PVUCjWYWdtXFabis+RVY3IOeTjlYvBZfNALuoIN3rX3DxyBCWTi5eIwzGODy?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ba08e2-c82e-4ddb-c6f1-08dda3a1e408
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:56:26.8322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJhkbhZgt5Hl11IKaBtN7Z0D2OlnoykisfqrsGaGp2JW6YIsP3jObq6PE2MJedijJ5ciM6kWaqtSla778DcMejV01+X9c7Qq19uwCwiUM+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6940
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

The global gd pointer is no longer volatile-qualified, so drop that
qualifier from these bookkeeping variables.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/trace.c b/lib/trace.c
index 1d5f7dec979..3d54dfaddc0 100644
--- a/lib/trace.c
+++ b/lib/trace.c
@@ -66,7 +66,7 @@ static inline uintptr_t __attribute__((no_instrument_function))
 /**
  * trace_gd - the value of the gd register
  */
-static volatile gd_t *trace_gd;
+static gd_t *trace_gd;
 
 /**
  * trace_save_gd() - save the value of the gd register
@@ -86,7 +86,7 @@ static void notrace trace_save_gd(void)
  */
 static void notrace trace_swap_gd(void)
 {
-	volatile gd_t *temp_gd = trace_gd;
+	gd_t *temp_gd = trace_gd;
 
 	trace_gd = gd;
 	set_gd(temp_gd);
-- 
2.49.0

