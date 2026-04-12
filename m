Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B870FE937E0
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 12:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D4DE83BC4;
	Sun, 12 Apr 2026 14:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="X0SV+KWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 338EC84181; Sun, 12 Apr 2026 14:13:09 +0200 (CEST)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5D6B83B99
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 14:13:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yangshiji66@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7VfFe93v7+roiiSH4PskBCWVXoMfEu/+JwQC0+z0LtfZpbyofDDaGEzTeNXSPc9WbR6cwlwY1BZY5TfHhV0U/4cgDTHYNIR5YlvGjimscxTKnT8LwkAxy3KyEhH+ZqDmjB5WTlhyY0m+brvjAOXXWhfxiGB+LMPzEOZNcUxtv+hNm8FXFWVNgA3Gd9q34uow/D+ZoLQwFL214WJDiEknTLR2UDzOMRJdZNUQg/LW+HQwFL8kvTRKfvTEePNkx8LSImeyBXNLgEmdXsMg2Uo/7JdDoVjGEji1F6IDJIFjXYUVkdZfsnF9NW21bIefRPlFaK8v4Qf0rhnaeR3YsW1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NlGLLJP8ElFcd2l0l//iGaQPJoJdjJMJA/pHD2lVCnw=;
 b=XOM+AcBGdNl8k/ePML4jMPWtDmAv6XDsVCcQKRK/SRjdKJFxD1pmPMQHD3jY23vTPqiN3bSbfBrndIRKBX7ESdznTsU0Lq5q4kfsovyRWFA7laA0GB8N2zXiCIFvpJumfZZKjzYU8AI0aKe2MmHLZ8WdcthU7iQkLYohVMHY3eMwSQdR8zN2+GVqahfEZ1Lp33jtlKw/SKgBlbtY3DmCkDUTWbWnkte5zlNKEJzMMImaSZlf8jy9O6VxZE09DvckrPujqN9uthznUkGsbIWjfEa5kYbJyxToq9KWkJ5BJAWhU3IdoPdsnsD14vJJaXt9WpHG5BPkpAUjgvpvqsauSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlGLLJP8ElFcd2l0l//iGaQPJoJdjJMJA/pHD2lVCnw=;
 b=X0SV+KWKZdv/ILTBVO24gIxOyCRvT5+EKc1CfY5T+kWf5bc705fS8AUEA1MIPenksxSfjTAopYF1BpmeTdtP8qL0kJrRx/R1QksXmzsc2xfazZxLrGBVlqLfvTjA7t8EzCIsUntho1lKpq/lLNhvRmPPYbD1BArpTAoQK6z8tijwe44kSHVdhqZyRlsCnALgPIfnEMH4wUMezx7+P1s8dThjjwmz318hM0Pbrt/V+QsU/EtcEP74Cgy2fWvhbiPCBwn4XpXyYV6QSJUYz2PbLdIGBQpbUpLYAwRHXA/aZ4fQAZxlllsPrVwme/TC7Sy+Y2TLbmSaFnKKjMFb5l5gUQ==
Received: from OS3PR01MB7802.jpnprd01.prod.outlook.com (2603:1096:604:179::13)
 by OS9PR01MB16423.jpnprd01.prod.outlook.com (2603:1096:604:2bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Sun, 12 Apr
 2026 12:13:02 +0000
Received: from OS3PR01MB7802.jpnprd01.prod.outlook.com
 ([fe80::cb80:ba8d:13b5:f13d]) by OS3PR01MB7802.jpnprd01.prod.outlook.com
 ([fe80::cb80:ba8d:13b5:f13d%3]) with mapi id 15.20.9769.044; Sun, 12 Apr 2026
 12:13:02 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.denx.de
Cc: Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] mips: mtmips: align MT7621 image blobs to 8-byte boundary
Date: Sun, 12 Apr 2026 20:12:25 +0800
Message-ID: <OS3PR01MB7802C722BA308D62F64EBD06BC272@OS3PR01MB7802.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To OS3PR01MB7802.jpnprd01.prod.outlook.com
 (2603:1096:604:179::13)
X-Microsoft-Original-Message-ID: <20260412121226.10540-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB7802:EE_|OS9PR01MB16423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b1ed910-2e7d-47e4-842f-08de988cd7ef
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|19110799012|15080799012|8060799015|5072599009|51005399006|461199028|5062599005|24121999003|22091999003|440099028|3412199025|26121999003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jSO5m55nPMTEbgJsHKObMxP1S0YY8b46Un8NtV15le5BY/BWXi7pEejxvfXU?=
 =?us-ascii?Q?sMi/u7HvDTGyrGkbDaztw/iU7Kk36xtz78j8Io+yeUH26aV4hBb3TXd9g5vO?=
 =?us-ascii?Q?DiwVQHmRXRuFSqpmsPNn76TSSba10bKKF36Pph4WYeqeaLeNrVEvBRTZJN7e?=
 =?us-ascii?Q?dhjLSbB8e5SGrCuuBjiB03AyN7/b50QvQgmj3yp9PqPOfnqZVAihPoCo4FbS?=
 =?us-ascii?Q?ZQGrZtV09Zc8LUmhQZtVm9mNJqVuvNWdBTLTbKIMK2kBRmdxnTgnGDH1UyKc?=
 =?us-ascii?Q?IDjNebfxCbowUuavoZlYdL1iR9ojqgI9taZzIFBM3k4iVKUUk7RGyP7xxOX+?=
 =?us-ascii?Q?MdP3wLZIhnFh6HljWsTwNSOMBhKqw1z28vrhsr8eth5LhvL5jk+y+R8Y2hKK?=
 =?us-ascii?Q?+UIfHOGxBQy7DxvPw5n7kj5ZEh4ONP8TYTXrF9rzUUUPLkEihE1bXcFKDj9w?=
 =?us-ascii?Q?/bc1eioqLmrMaia4tkaxDOwHMolXTSu0Sy0IQkDsy+09/a4YagNw5EcnIuFE?=
 =?us-ascii?Q?AOOq6IGY6af2fzX0Zw4KqdHtyvpUuLtYVperyA80Uh9U/SjpkH/Nvg5ZwXww?=
 =?us-ascii?Q?Gj1Bcrr0EhSr8/FYq9tepAR1oT0UxJvo0/3LxwlNJf+jKQsXOitYaYPjjRzv?=
 =?us-ascii?Q?RlQESja3NQ2sdOkar6a6DLBrLfiY5qaQem0kA1LXR2/1mowMND1JlykpkQZ7?=
 =?us-ascii?Q?JOoZ6d4kZ8oL3x9PN6FdsH1v2n3n9CXnOhkDTNnWS0OcjC/cGhB5Gw2myj4W?=
 =?us-ascii?Q?PKn8l4MHXNzppGCyAj0ggTWN3bdAApc3C3fUvJexij/gEpfP8yLIknDpzdHS?=
 =?us-ascii?Q?kTZTVTUvGJlwYLmfIsbTjJpOtX0AaKMbY73OJqMk0Tyw8PHaL5CehV8ukPxv?=
 =?us-ascii?Q?ilV3GmMHPeLQSMmWqGyo3kgZUqQYBW2Dz6xa27F++cOR5VOfoHfAVybFf3OR?=
 =?us-ascii?Q?TonrHpzk5zIug6oxCu4HHbKBdL5CAgFiXiLiCt0ikjWK7V+lzsZhB+ln1s0y?=
 =?us-ascii?Q?xllJ1SEDslTvTnh+35LppmYX5RHy0R1Ej/GDl4Uuit5gdmYB48nw+eT7TcjU?=
 =?us-ascii?Q?3GXzrDEY?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQCTMf7ulxZUcHXqnjZCofn2Z+tUjQCglePd6y/449ZEp5ewNzKR7d+Gc9P1?=
 =?us-ascii?Q?M5p6ct92dxcWy9cUNtytDVdJM3UY7N5U1M9mmkaxDe01lEAA3W570J7D5jW6?=
 =?us-ascii?Q?9zW1xyXnwYvoPkcLuOz5G8HIL9P3qnyoH0D87hS4zXZMBYBRvijlsfrTyFG7?=
 =?us-ascii?Q?mPWkSyNLffs82YShywTLvrgYrz76ckoNcYu4w95GDUn3cXDFI/X6eACDihFG?=
 =?us-ascii?Q?z6WNP0fIyKyBQL0DQPULRqzXTL6SAEyVd6rEKTt/3qQlXB/aM3thIoC7zGjk?=
 =?us-ascii?Q?54P8tPQZqOBrkYeU3MPizLe9QLtH+Y2KUmX5Aj8I7FxG8apVMl/bZ2x6Ht1Z?=
 =?us-ascii?Q?MPDLNXuND7JX1HOOHY5tmiYGgRxDFMBGPrWOnovWh+gI3v8sZ3LuYvcHcb1l?=
 =?us-ascii?Q?cVz1CGmP/Zt076rfI09Re3PIx0HUU/dmbETuTC+LUsjCy0uY+ouM6OdtokTb?=
 =?us-ascii?Q?Zfu4MYNsHk7Kh2TNc6BmogmjTXnkWpRzrHuXdKesQH010U3tk6Ev0fCCzd+9?=
 =?us-ascii?Q?BPOo4ZsMCulhqx9hYj6x8DAPrnvTG1gQa17kJECmFxCenlhXnjIk6EAuqprn?=
 =?us-ascii?Q?/kLFZFiYKfnq65cAtDzOFWLDi6KUNOLc+bfYCFI3+/l4DqeFDgIl0c1kr7Z1?=
 =?us-ascii?Q?HiotZVLxiJydEObpIBq6lqMiWlCZL5g5eYIufRL59XeqhJMXSdtO42N/KOlm?=
 =?us-ascii?Q?c1NWe8cAkyC7p5rxp1HsM0P7Zd5pDKJZZWv9QaDdVSLxkFHPw1/pnlvGRx1A?=
 =?us-ascii?Q?/wG6Pu30F65l0ncNG1tOYLUBsKpeI0c+BdcPkM//N1c0dFc0jcKnuVA7yYjO?=
 =?us-ascii?Q?zLOqJkJKqzYaPPy1nZ+++/oTmQb8wYR0Ayzw65a30DrWDJ1y9h1bU+h03ZaH?=
 =?us-ascii?Q?gjEWpsZrXTPzCHSkZOWQhGiWVQebJOaV3h/VBxyA4mzFCrLODYf9je4EUMvo?=
 =?us-ascii?Q?pjaXhUFyOZWuqE6j7Lebvcs4YCcH8D1gO85vuEPeBIM+1Q/gY5n1X9dbDwPS?=
 =?us-ascii?Q?upUDDZ4rJBSK1GGCwS9QU9ngoD9C5zVhAWaca57yws9z/F0e5kc8K/gT9ixC?=
 =?us-ascii?Q?tD2BeHpPYWaCRoBzAMvlcC19UJMYb5sCe4tqyO/ykqpGIeH+9L5SEUY5QIO8?=
 =?us-ascii?Q?v9H/VGmW6F1mmSUQ1TMQE2fKTRyBPHWfboElahnHlx3YUb4Jzee5E/PiznW1?=
 =?us-ascii?Q?qdxfY1dopJ9Tyzvgillrzd2z9u59uXxguggnty6maBtI01VWUxUU864Nv8bD?=
 =?us-ascii?Q?fJyqTgePU+w8hhISAhEnTsnKJ32viSDcRNf4oPUtgBCX3MubODJSQLnZdr4M?=
 =?us-ascii?Q?bZbHtXc+ICRjFuPa1lbWX4zZ6ypzOJOIVk4DKqO9Mn6TOG5ZIt2z4TMRjFOI?=
 =?us-ascii?Q?3Mi5ElreviVv8ocGEOTwPcpQsieb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b1ed910-2e7d-47e4-842f-08de988cd7ef
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB7802.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 12:13:02.5397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16423
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

MT7621 doesn't boot on u-boot v2026.04. Fix it by correcting the
u-boot aligned offset.

Fixes: d9e183a04c92 ("MIPS: Assure end of U-Boot is at 8-byte aligned offset")
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/dts/mt7621-u-boot.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/dts/mt7621-u-boot.dtsi b/arch/mips/dts/mt7621-u-boot.dtsi
index fbac2ade25a..a6e585a0853 100644
--- a/arch/mips/dts/mt7621-u-boot.dtsi
+++ b/arch/mips/dts/mt7621-u-boot.dtsi
@@ -47,13 +47,13 @@
 
 &binman {
 	u-boot-spl-ddr {
-		align = <4>;
-		align-size = <4>;
+		align = <8>;
+		align-size = <8>;
 		filename = "u-boot-spl-ddr.bin";
 		pad-byte = <0xff>;
 
 		u-boot-spl {
-			align-end = <4>;
+			align-end = <8>;
 			filename = "u-boot-spl.bin";
 		};
 
@@ -90,7 +90,7 @@
 
 #ifndef CONFIG_MT7621_BOOT_FROM_NAND
 		u-boot-tpl {
-			align-end = <4>;
+			align-end = <8>;
 			filename = "u-boot-tpl.bin";
 		};
 #endif
-- 
2.53.0

