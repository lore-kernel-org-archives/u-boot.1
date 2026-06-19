Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9BFECD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6572384A45;
	Fri, 19 Jun 2026 16:49:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KkOj9Nek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E996A84A45; Fri, 19 Jun 2026 16:49:46 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143C1849CA
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2bWghFJ5T2QROPVWULmv9odqFGn8PXwWJiMtRu4989dA073rNNXfEYGu1ATxqKRjq1vYO6U3MBU1kjYoojAdQvnerDafXy3aYVMIWwg941+hW/1DpacDzLciCEgJJ1eXbZ81EvTG1FsNtoQC89mZP/fNA0NLBlTWXZCuGZhcBM+fW97DBxlxyPjvxB6X9/nefykLd6J/nkp2uwSDqF/MfPqwrmNae0ND5gbwyyRItZ6z7NvJNVk5PqiO81EN4d/6JAoBN24UoCFiO9lEbw1DNyCKTU1ClY9CDfTw7ll41FoMDiEfhXB8cHEW/OUmmikZP6xfboHZRXMyIkmdS7QIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh7Li3o/yIaDpr3p3sKeQG+rgFDGDoR49VODiol8FKQ=;
 b=Vg2MoCdwxDiDff84JM6s8KUqoVaBZrzC8iqYXVs02lMD+AwsizkJ4nK5NJHbtAd7PME4sp342Dr/9QQECfSZfm5w6qNOfbAY5mzmexZAJPpuhrvSNbp+5L50tpgJU9hy+/Nu/Q9z/8ZsQ503qofqy3fTvapbIkgStO68VLu8z6R015dZCRwTLAMwYFRa3vDTDJFwnyyL9D1QO/rIObQf9K2t8Vz+IzYp9JK+ml/SceOYo5JO0T1u34/gGSfiPfpmqBiLjbp8DwSStnBjgye3QD2YTkio+XV+dPW/11pE0C98sjlWqUYl0zE0EoJxSsSgBRViiH8NjTg8KLJdcYt0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh7Li3o/yIaDpr3p3sKeQG+rgFDGDoR49VODiol8FKQ=;
 b=KkOj9NekKkSwK8AlTxaTmHVGSCo+/fRtoQ6fXCvsM9uaBLXyY41OARyKTukxKL4CMPEsr/VjdDYgiXI+hNuIZ2/mxnmhl5RvippWu89Z6PpJ9Sjzfvkbg/KrqhI8XMnMZE0It/3nsV8y6kEfL9q+8dZ6jtGtPkxExgtgN0l4QnGbxOnan4sTCtJWXl7FZHnGkogDi+vyAyQwVgthIYdvYdcWu53i4o1vQ57EIzdAB/qGoFP0SgZBWQyqS5G5H90nG0usL3SGV2kji/8C1fci+uzqTxQDiSMPBfblZo9ShtgrBXwUv65K8gI65PII+9QQM9cZhoxhkVZGaPQeVrH8UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB11827.eurprd04.prod.outlook.com (2603:10a6:150:2d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 19 Jun
 2026 14:49:43 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 14:49:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 20 Jun 2026 00:06:08 +0800
Subject: [PATCH 6/6] imx952_evk: Correct CONFIG_DEFAULT_FDT_FILE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-imx-gz-boot-v1-6-143c60a572b7@nxp.com>
References: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
In-Reply-To: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB11827:EE_
X-MS-Office365-Filtering-Correlation-Id: 27f5ebe9-6f68-4afe-49e5-08dece11ffcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8WmorV/YhtT+ka+qYTVPamlO7CxnFjNDE1X/F6Ov9tdS72oZ+xp+BPLEC5roMQDwiPPqzBILlIVTSRV4D62rWRozQAh5RTBi9HsApefLMBvFEfN89RT8V1fKPX5QoDCi5Spc9EgnN87LdtEcpgwEKnaQYM8ndcqeTq+CHnepHVzNKI0+JxA+nMcJm0LPxlSt1s7JLVQgxTlu9tz4MACN1aRC3wc/Ph+9+xwKPifIWyfNpwsTjGdqBIlaYVc8Bzc6YErknfU79ObIWXRRg5wFwSr+wZnasHhK0xjq9u5Lr+CMd5/cUPsX6d92XFD7ZsjE+Fd6OaZjUP3xvpZBbc63k5w2X0Tb9fdEI34puUKyMHQV5poImazUxVSCN7EpHsVLqjKIqbtM0+xn0Op0cJmpUEuAZANNWIhFy0Z2rzmr4JrIAIK54r4wanIoFapKTl4fecPiK02jbgk0aaUoRCrdCn1bxI56ebF/lYkDYt3e1GOQkpJfpZFHhGPXKG8UqCGTQlQ8ZYPW/pRbFiQ/bSusvCVcV9V+AbksxYifWMVfdNu6OxyBgK0inubgHkFLbtEgQn+Do7upjvA/siUuaui5XAdyrEoLLhYQ9BxyiMD3IHofgjeFm2leD0nnOorT15stI/TfpfhA9IRGtGo6ARCHKZVJqH48voFhLLDdKGPYUH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5kU1psaHFKQ3Z1aWlpUVdLWjRMK283c0dDTzZjRWpuditEUkpFMm14WFJu?=
 =?utf-8?B?akxsOFY2UTZhL2ZUYXBKSjdzWlFzYngvaUlsWnB3c0tRaUdpSWRJZStwb2ZW?=
 =?utf-8?B?bnJjM2h1MEVGaElQRHczL1RRRXJUUmZleG01eVpJQnJuaVdCdThLM3R1ZE5R?=
 =?utf-8?B?SnBhWlhRWm02VFVMbURrTnlWaDBZYlNGbU1UZ2tMZmxyVFdTS01kOE5WR0pq?=
 =?utf-8?B?MUxBWTRmbnlkVnVEaGFKQ1RGdVhkUzlJVTdGemppVEI1VHgvMHoxZjFNVUZ3?=
 =?utf-8?B?Q3o0ZGY0eHRrVVBiR0xRdmVnbzM5b3Q0aURndVIyUHFXTlhtdmZqTDNGWE9p?=
 =?utf-8?B?MmNMNlRCQ0FneGR0SWN2dE9mcWVuRUE4YnlsWnJuaHI5VFFmQlp4T05VUkdR?=
 =?utf-8?B?RncxbXlkdFYxU1dwY3daZkJjd0EvL3lPcmJHRUpldGF2djZobnNkTFB3Znc3?=
 =?utf-8?B?bVEyRi83ODB3aFJvOFpXWitiVWxDWVdBSk5ZRlRRZUFoT2NTQm0ybzduS1JZ?=
 =?utf-8?B?SGFKT01oM212R1pVTTFNZzFzSlVPN3kyRVNuV2NaUVA5REs3Q0loN1Q3YUpt?=
 =?utf-8?B?TzFKTjZibVpOL2ZXM3loRmJUVHhNMloycXhhTVBhVmdOREdsWHhKME1VMWY1?=
 =?utf-8?B?Y2dvK014di9FZEEwZjg5WFVaSHBjMkJmQ0ZWQ3RTLzRkTGM4N2RvNk1RdHU5?=
 =?utf-8?B?Z3plNWtGQUN6R3lRSnlUVXpXSDExS1BxRUN2RFlWamJBTmpiamo2S3dQQXAr?=
 =?utf-8?B?RktSQSt1M3pnWnNjaG9YbThEYUJDOXpOT3c2b0FvWGkvWmcrTWZGdUdOTlhV?=
 =?utf-8?B?R1NPODkrWUh6dVYrMVEvTURQWWQyK1lPZ2lWYXNJZk1QeUVQV0dSZjkzOTZD?=
 =?utf-8?B?anVjMk5mVXdLeWZ2VER1ZVB6OU9OWVVoN2UyVVVFeVY5MFNtTFdVYVpsb0cw?=
 =?utf-8?B?S0JqZUNCUTNFUGNNUDc4eDJmL3VyRHZUcDBWT3ZKWnMzQjhidU5jY1h2WGY1?=
 =?utf-8?B?TGVXZzJpOU52OXBvazl0L25tZURlUXFOWkZwZ2I0a05SM2xyd2cyYTc0MEY5?=
 =?utf-8?B?azR5ck1UQkJSOG5ZUTNMdEd5MzQ1NEJ0Q1F1M2ZPRlNBNU9LbVlLYkJGWXhP?=
 =?utf-8?B?THVqdU0xVXNDazJ3NEdUc2YzbkhXMUgydm53UlQyRWJyU3ZVTnhmdG9zSGwz?=
 =?utf-8?B?TXFqK01RTEdlbkZjbTluZk40OEtER2d1WUdYY0hYazFrZTdMazVzYWZUeTE0?=
 =?utf-8?B?WlhncHRyV3luSGxaSngzWmQ2a2FDS0VMb01Rbmc4alJob05XWlM1TDZNdmFs?=
 =?utf-8?B?dXhiVUV6MEhJTk9RN1dadDQzZGpQY2tyeDFJVG1RZ2hFZ0hTUzI4UlN5cC9s?=
 =?utf-8?B?QUpWVFNWS1lrdGxLamYydUlReGhlRnRGZ1Y4c1BOdmxhdG8zcVZJb2EvQzdj?=
 =?utf-8?B?bUxtWUFURnNOeTlLdU5ybmprRGZXTk5la2RwMyt0Wk9NYmNzdGUyZmh6V0pI?=
 =?utf-8?B?Y01GYUlidUh1OWpxWGlFWDJQS3FrNjZ2aE1kZzdob2pyMFoxdzVvSnI2Rkd3?=
 =?utf-8?B?Nmw0VHVtK3FmdzZRU0hsc2tzRVZTOXQrcSt1MjNueU5rNnVYRm1KWTI3WXZN?=
 =?utf-8?B?QzlmRDNCQ1Z3YllSSCtFOEhTQzJ3dFgvQWI3ME1MY3JoUVJOS1IwNkZRdUFI?=
 =?utf-8?B?VDdQNzJFUDVyMTB6bWpKNGRBWmliWmNDTmM2T0lSSkRTdDNhK1Fmd05MTFZP?=
 =?utf-8?B?czVGMWkwcU83WngrYWlMWjJUOFp0M1U5SUpDNndIbFNJOFRsSDZOK0tYTDFP?=
 =?utf-8?B?dEUrWXVGeFhVVC8wQzM0RjNxVE1IS1R5K0xJNFQzVmwzRHgvaHhocjJXMW5t?=
 =?utf-8?B?YkIySzdMTFNFZ2lIWlVMNlFQcUUvL2c1ZlJTbnY1cUc1Z293Qm45NmplR0JS?=
 =?utf-8?B?NXpWOElDTkZlR0xzSFJhVEdLRTYrZnp0R1VWZUdaOFBhelN3Z1oyYmNlUkJp?=
 =?utf-8?B?UnF3bTUvMGtmbXJuaFhKd3ZJVnBlYkRiVmhwRVZ0SHNCWDU2NzcwSnI3aUZW?=
 =?utf-8?B?cmR1bW9IcVYrSlQ4bHF6ckdVMXptTlJFUEhOa081bmVST0xrZ2xFYWtOOWFI?=
 =?utf-8?B?eXFTc2kvR0dlTHJyd29oRWdMOUR0Q1JUakNOSmx3UnpjY2ZqL1hLMnJJREsx?=
 =?utf-8?B?bU9DMGgwcGd6REc3UFczT1pnSkhNNDRYaU54SlNKSFdyTkNlbzNFYThzbVFY?=
 =?utf-8?B?YkxpYyt5U0s3d2o1a3BaYUU3UXRLZVhBVGV3NVN6QWt5K0Z1QjFiclA2VXpR?=
 =?utf-8?B?QXlrY2V0cUhDNGNXWGlsQytHakcwaWZISUUzUHg2QWJaYTFZQVRjaTQ4K1p5?=
 =?utf-8?Q?Kj7iUu9AG70wDvAQHeYU/BFHObkRfoo6IBdeI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f5ebe9-6f68-4afe-49e5-08dece11ffcb
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:49:43.5887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SNs6QO+e+UFG0C8MCTDV2sqv1uLY1MBuy1XkWtjAJkh1HWJerBy8LDFwSRCPkkLESOWwrYE2OIl27oL9zFB5WPhKD9mcSRfGDyJMcnUE9LsYv60iH1SMm0XG56KG+ISy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11827
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

From: Peng Fan <peng.fan@nxp.com>

The device tree is not stored under freescale directory when booting
Linux, so drop vendor name.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 configs/imx952_evk_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/imx952_evk_defconfig b/configs/imx952_evk_defconfig
index b74df3a5d5f..9c12d2b32ac 100644
--- a/configs/imx952_evk_defconfig
+++ b/configs/imx952_evk_defconfig
@@ -35,7 +35,7 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
-CONFIG_DEFAULT_FDT_FILE="freescale/imx952-evk.dtb"
+CONFIG_DEFAULT_FDT_FILE="imx952-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y

-- 
2.51.0

