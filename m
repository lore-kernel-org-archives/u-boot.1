Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7275C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45CB588128;
	Thu, 28 Mar 2024 11:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="TNziN7tk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E978811D; Thu, 28 Mar 2024 11:49:41 +0100 (CET)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D69B8813C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCrwsZ3Oet0eHlFS+XO1cENdrI5V7X8A3ew4Mvy9jfb+RnLcn7W3RRQJxJNck4dVv8PGbZ7JyNgH/Me2+iLsnIPFogHBJ9l74Xhnt3NtPQubXgBaqIM7nSOa3ScG83b0IYmja7CdEhMCCOBjacGx13bg1LZB4IhICKAhZPBuFx79xmbYMj7Cju8tQ1G1V6wfSSyOEHtkHjSj2iU/o538fOvCmfTxJWQcud9ANrNjRQPQJGJUWjT1L4uHvFEQAahK6y3KRRJFnPrqInXweurn8Zoih3IxmGRzOlahHcUQzfFamybMxrl1uwz+rEMlXEtcNLXkmjwGgxc4Tqmor8as+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEdh4PAKCPHQrgzsFkOwFMLriEHmUCUJEBoVlDiV1YI=;
 b=dhVX4jA3QIPgQChDvdjLjxV5jfFPdIhSIY3fJTT6NeJmb57LlgXGPY0D1xk/hsF7TMx0bnrSQ2rbMunAwHFJlCoP2vZR+fF2BhrnOJp39gFvi31flfDnKeNbG9oB4l4d/zP1PQUz5RtjZAEePlhvKLa6PyJDICyss2KcP01Rp5Q/m0a7mW2gLQgI0s04CwH4fEf/LZSLqel/tbOWKbR+x0PC8cYw6JchesL3odPq0MLrmSalkGdOJXz+IZOgWbbv2z9Er499aBjxLa0yJnT5xlA8ksS8tly8C+TQiBAb9CXehFMzVv8Vqfv7gvGaOS/OZkCVzB4TNhgK4LMdwiD8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEdh4PAKCPHQrgzsFkOwFMLriEHmUCUJEBoVlDiV1YI=;
 b=TNziN7tkeSvK4MWd6XHlVG4V/p6uq9b5udm+9REL+fRJURCrIHIaZU/3J+eIdW5RHgq8C4pjqvVEunq5e/5t1GD+5sDuYs4Ud4RRIhjV8AqKiuBHu9oIhT3BO5iyk/L8MAoYTuZhtGZc/KtDN3RKVMJhWwy44OU0Re4+kMDDatw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Thu, 28 Mar
 2024 10:49:37 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::3da1:cdb:7bd8:750a%7]) with mapi id 15.20.7362.035; Thu, 28 Mar 2024
 10:49:37 +0000
From: Ye Li <ye.li@nxp.com>
To: sbabic@denx.de, u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH] arm: imx9: Fix MMU map table overlap
Date: Thu, 28 Mar 2024 18:49:18 +0800
Message-Id: <1711622958-62199-1-git-send-email-ye.li@nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 9083581e-1a63-476a-d91d-08dc4f14c366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDet4YI2To4aHK1yucEXZroRPM36Zq8UXTksUqd928y0u5zDubyswII29jMB5mWk4KR9xNtIHyj9LeDHRB3AELixyCibzyYuD/T4FRMwhWe3FEKpvCsz4Z187K9kxiwe1cZQGklzNLLaqm1AcgewTdJQPxvRiKrUf5UbLQ/jCS4hof8hkocU6CNZQ4C9EHwIseClHJQm2iNZj5FQLgnPAQ17ZzR0xrGaud46xjaa+R7ZCG/bQBsfD9D2SbSPtpgYErA1/lp9wVLKTtQT76IihxEJjWufT2FzMI8c6XafxQNJajejK9Ec1Ksu6UCyjqDVDgW78Nb/wB/HxK/mT4VHLYYyawKvTeA4dTP2Xf70+SPd4u8ZWTwEC3WzVZbg3sfS4Rl3YBygkIPvZIaT4X7dBeWruJd+4d0yjyACu1qMtG+mrgP6lzCcmInrhcClRm69zYdBKMz4fVFkKoEvLv10nTyfIWKo/qmEBGYQ+vYVDK5Y1WvJxHaLZpmeMFLZJWLJmOBQc2aBViyEk/S6MzDQ9oMrHeBM3Jz/ZNMjX0WJIjbUsv0BfVS9yIR+wP3oWhxWvHQojE3yku6vv6OLkYllhdfjcrkcK2WjdmdlK0PYD8lErBY1DLCb48XMhufyQkoxOTZgQDdeNp6Bu4nFCWBJEixKv/871s2AwYtpEmRujX5ebbX/3oObaGWbNPLcp/l2oexk91FgmNJOOScYJcxBg15fJc/YXmA7YCF8uLfH1JU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UtAC95laDlKNJsmHaqPSzh21+HjUCW8yjaL6zZ91cHVCXBu/DVhx1E8e3uor?=
 =?us-ascii?Q?3mjdqCUScgKdcE2SCQv9Mh9Qdyr2E7o2NkEVrGjpiKRXigF+h7lGM0+XGHYB?=
 =?us-ascii?Q?iFSMJ8pAjKjE8X8dVfsuqN24kj23BROgQh5g7fOW8h5qiBxMp7kXrVRmILF7?=
 =?us-ascii?Q?WSvFcCa1Xr6lU0PfcLPMMwXD/Faw5d6ZKzNXE3XDGGc8lp6WNVFyWblafURo?=
 =?us-ascii?Q?ecqZSVz5MgTrpNZxj/gEE6QNmiYHI5Tl7rWXzwRxdHH97ifdCi0q6cMbsLhy?=
 =?us-ascii?Q?CEdpmqoy8RNzRiAFNMduUarYBgfMEO0qHJW8pMj4FH6Sc3RJp+NpfE6cvACm?=
 =?us-ascii?Q?lZj8Zw2XhO/pn+rRiq1kb/oblbE+Kh8uJXre/Iwh4n/qYDYw0RWw0fBejDBY?=
 =?us-ascii?Q?AZr2NEdOwZGZNfw7rZML9kbZMu3y88zbbdxEJTJ1/l/9Ac+FAYj34Btb3Jda?=
 =?us-ascii?Q?w6/+/b4qgRpIbk00FGgFV5odT+nSmRfR7RFRbPSRBiRsYjOMXlSA3jeFhtTU?=
 =?us-ascii?Q?Dfw/UcomIMOeJzm5PHwMKenSriYualFZ/vmlxDCnY4ZABgMSI6HqkClIjI4M?=
 =?us-ascii?Q?U9DoruPsi6BmFa060iMIkxq255DoL9VWPtjpg/oZA+AM7FKIEn5ueKEMlnF9?=
 =?us-ascii?Q?MkbBiakguy/vF9RJtbDmb404hwkwiaZBa17I6l7nlLvW1MrSSudmtGL/AkKq?=
 =?us-ascii?Q?zccdmm+bTy1Vkp0rux5/6VCeyZi8QwiELWCgepC1O5eYtMS800bxik5UrLxx?=
 =?us-ascii?Q?Ph7eKyMAOlwK2kocajlyNCKbiMMSuOn7vfQvTgZYbrUFgC2QQ0sMY8dcQJCp?=
 =?us-ascii?Q?MT9m9UHvEgtPR6CwF2FWx4DJFNn8XfQdf1G5lasc7wm4J/RDvcK0V0sDAKHn?=
 =?us-ascii?Q?Uj09Q51BOW3OHwRrXiKoXFTumeXUST9VzsIyfZ31HMF45ImVK57iKZSUVUBe?=
 =?us-ascii?Q?1u9/FC9jm3gO6UbFOJ9R4BkgxxhWPs5fK/H31XcZ6jqEtiswWbCyP1shIL9L?=
 =?us-ascii?Q?LjWSYhMhYM6p3r/z1cGSMFEUxFSmxBPdl7lhbJgBqbe2HX6HcHXJwgJK9Aqw?=
 =?us-ascii?Q?zADgYjxF9ZRIHQKFDy/tqGNUKz7crD321QRni/Pj3lsYjBPbWS5lCfVL+8Fu?=
 =?us-ascii?Q?9HYBDZQeI044vDFTF6H5cdVN4UQGLvJtPiElers+YfpppXQjX2vEcJkCRLF4?=
 =?us-ascii?Q?lPCzsoedEN3lUTbFTPwa2TNWoZoZgwD11hx6CYdt6iMDhW4xShDdlxgS+0Vv?=
 =?us-ascii?Q?PAJ8sQoAp4m2zchT74qptA5ia1qv4fhk2n59STikPRNUAb5XNsnrRf7vSeR1?=
 =?us-ascii?Q?Vw89wWD2Z7s8SMI2PC3iFN1PNXGwwberElJH6RU++ssrelaQoe8vgu0dv8yK?=
 =?us-ascii?Q?cx4PMjnhW7z3sfMsZoJeIvf5xE8I902x5vFawSqI4GC1jXWGBWlgN7KPdfCL?=
 =?us-ascii?Q?UZw5rsZkcRgU+QbF5yQzBPzsr659+VsWCrkvChiFdVymIqFmt6obiJ76R9Yr?=
 =?us-ascii?Q?NemzQD17I6R0WEG9C8BzzhJLE0Ha/bgrt0u3DhuxifKDp6+quKx0EO01cypb?=
 =?us-ascii?Q?Gj/GR516QGDVoIKJUZkzTeNpf9+QFnQac6qdzDYn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9083581e-1a63-476a-d91d-08dc4f14c366
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 10:49:37.8746 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSeUU43zbOKxgAVawJ5AAUOv4wMxUc7RNnhff6Hpnahk1GBoFKhxkAg6SqdNsIdV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745
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

The size for flexspi AHB buffer space is wrong, so correct it.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 15e87b8..2117489 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -262,7 +262,7 @@ static struct mm_region imx93_mem_map[] = {
 		/* Flexible Serial Peripheral Interface */
 		.virt = 0x28000000UL,
 		.phys = 0x28000000UL,
-		.size = 0x30000000UL,
+		.size = 0x08000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-- 
2.7.4

