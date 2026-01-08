Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B3FD185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4125A841D7;
	Thu,  8 Jan 2026 14:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wtCWLtvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B9F583A26; Thu,  8 Jan 2026 10:53:10 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32E2483A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5seXT1QatpXUzp7liIr62lkXvAgZHlTxKTJAWXef4fdhesqWt7nbMm8hq3a3lnFkbo2WwXCKS7y0dARbJZ1YOdJSugLBNwJJyE95SOdQlyc5ilqpIdcSxE9a0DOfMZwQc1Fg4w0Ma/f35bLuTW9qCXo3QozfA7uBuenRsV3X8WExDJLVnNsnKx8P4nzZphiX5VpKo3Eg0qFmbtuT23YpRg8MUN5xEHs44sPFxV+xMtof15FWDmTHMgYh4AIg6suY3+pr6zHA/8I03Tol+nCO0ZGskyYEO+Ix/xfS35wiJeXV43G1gXYuG4cjF11qfJfmUr3BI3/l1rhBD0ZQMoTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDuI42hnwzeIp9gT3znhBG9oUXo90A3b94P2J63pLIA=;
 b=PP/dbTf9XkqLDbcGQVRXSOtwthn2jlMCMr9R/NLZiv+dz04xB1OeTMCaely/v7FgNAP4M2KCIs8XS3UwER5u9l5QQLs7PtjcGzkCOnaDtPxcTYipvkCyqFI/bdwoxlD+sTR2QXYLYO/a42mA1QapEKobz+iNkOLJQHMeOa9lRSBryZ/mfk7uFCxvufX7/XQbJF6lfK2BsOEvrglm1li4lAI79gYKLJPpHQ3sNxYufDaDcA6Hp8Q+1oSvqh5vZrCsS9Hlw/0qUWhxrzQCyDw94MTXKXmoCa2KGFGgipj3a1xmvD0wsN3hNZMhndW9AzFIL8D/1jxwHD8sRzUikDatPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDuI42hnwzeIp9gT3znhBG9oUXo90A3b94P2J63pLIA=;
 b=wtCWLtvWhfrkOH+pdkJ+ysB/nwQhqFJMyh5W6n6oDluDWYr3mkKT6Q0hsmbb4sL5DNDaqtjkFVtV9/E0WyU9bcPklEuwC+D2TUtUHcTrIARcIBp+HnoBVqUNXHoc+e9cuujdJJhrKgDKMhWIUroOkfgoZO+Qfk1oTVVTMzuVbaVLi8wuXqyWNUKRLMeaU5j7SAFczWsEJ6UE+GrXUQ0IKayKX8jr72Q+JVecXOx6kU8mhHy74wGgqHioI0wd7bESY2NPUcWPRUT2iuWllQULGHOVYdAIUjrQeIwBcKxsRy2HRXeZqfB4ByAKIlNN+2PnRTz9U5hD04Kwimv+ai/TOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV2PR04MB11681.eurprd04.prod.outlook.com (2603:10a6:150:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:52:56 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:52:56 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:49 +0800
Subject: [PATCH 04/13] imx93_evk: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-4-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GV2PR04MB11681:EE_
X-MS-Office365-Filtering-Correlation-Id: 67445ed1-89a4-4acd-ab15-08de4e9bb2dd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW4xUUV2cUpra3RoZVZERXl0dVM1SDZ6RmhaRjBjbTA1azkrcnJqUmFSVU5y?=
 =?utf-8?B?V1NHMUVwamZtbVhlYmpPSGkxY2k5Vy91MmV6SnJnVVRnUEx4VFVCbTl2bFlz?=
 =?utf-8?B?QjN2V3R3OUFrN3VPTUpwYTlrb0VyckRtNGo4cE03REREV2pvOVNJcEM2cTBv?=
 =?utf-8?B?emNadGpXRVphV2RxOXZrRUx6VFJ0YVZ3REFnNlZqVGZ5YUpDcW4xZ1poN05Y?=
 =?utf-8?B?dTN3S1Z3WndzcWZqVVpKMmlWZWJvM1NzbHZtSzdyVHRYa3hvL3JYZ25hVVBH?=
 =?utf-8?B?WnNoMENWcUkzd1pkcUdxOHVVNEZZNGg2OFJIYTdOMFRHZXlOdlVYckgzbzhX?=
 =?utf-8?B?K0cvL0FMcVdhQVZ4ckFTMHRLRGlSZHllcnBERElvZVUwRXVFRkFWMzBnWUZV?=
 =?utf-8?B?bUs5ZFFmcTVRdG03TXE2VGk3eW1FV2J4VXlobjVyeHRtR1NubHdMbUtUdWJx?=
 =?utf-8?B?WHljek96UFAwRGRHZlNDejRiTUFKZFk4MUY2ZW5kNlVsUS94VXp5a3QrWVQ4?=
 =?utf-8?B?Y0pSWTNWR1dXMTlsYmlDejYxUGp4WHcvZllCbnl3ZUJmUm42Z1QzZXVPL05H?=
 =?utf-8?B?SWg3ZkpzZm9odHNLNWl0dnV6TG4xNmRvVUhlNWJQdFQya29yS3B6bm1WcEpy?=
 =?utf-8?B?bXNYbFVheW1QV2FvSGxVR2Z4USt6TmxuamZOK0RXeEJHMVc2eGNHRC9VUGZW?=
 =?utf-8?B?Y1ZZTUxYNVNONDBWTXV1SGJOL293aWg1Y2UwSk5tY29ha01uU2NrNG14MEFx?=
 =?utf-8?B?MWhLZkRvYlo3bk5kMHIwWmVSWEd2bWhvL093YUJrVkkwZjQ0ZlNHbUcwRFdI?=
 =?utf-8?B?YWxnMDVUSjEzT09EdHh5MVg2ZXpFVG5wNkNtL0hIWHN4MjFuYzRRejhMMTZa?=
 =?utf-8?B?eFNMcjg3OWdNaGV1MDZPMStSbHNIbkh0MDc5Kys1T1FjUFU4Z3VBMFFNUHlp?=
 =?utf-8?B?SkpDQ25ncFBKU2dtV3R5MUZiRE5HMFI4bHQ3MWlZQno5bHc1OFJEbytCc3dX?=
 =?utf-8?B?UktEeGNYSlBJRmh6NCs3blhZTks4RmpKYjgwOFFCdnNOMUZ0d3o2N0tKRkRJ?=
 =?utf-8?B?WmNBQUFjZHpVMWZzMXVPc1NVRkRDdXBENnhOZjIzN2xTVXFuT1FGS2JGdGJj?=
 =?utf-8?B?RDVOZ2ZzQ2VrdHZwWGN6bzVoZE9JL21ybGZ3MUt0UmgrV29EM28xeFhJamN5?=
 =?utf-8?B?am44RXR0K0lQL1ZoaHdBcHlJY2kvR1JKT25JdmNsZ0NpVFg3SE1KY2VaR0hm?=
 =?utf-8?B?bXE1VkVqYmZITjA1bGZzdnNKZjVYRlVqVWV1eWY4cDd2aUN1UzZOU2R1TnV4?=
 =?utf-8?B?WGcvWko2WXlLU2JhaXF3bmwrdXlLTFg3dnM1eFlLdFFUUG11L1p5QnpsUzZF?=
 =?utf-8?B?THIyWkRTeWJjTERsSjlvQ055alY4VXJ6dmhoMU9EK1c5bHRha3dwcVpIWTVH?=
 =?utf-8?B?NXphSjJmeWxsZ1AvS0U4ZU9TYXR2Q01VL3VDN0g1MEN5RitCRlVra3ZFNkdv?=
 =?utf-8?B?NXhjTEowUXZDQVpnNy9JZjVNSkZkMm9EME9Obk80eUNIZE1sTmw5QlFQeDh2?=
 =?utf-8?B?dzVWTnVZQTJ2YytwQisxWldjMnVWV2d5R2k1NHQ3TnMxYkpJU3VMVWNnM0xI?=
 =?utf-8?B?SnJnd2NnY2tJdGxRVTZuOU1YMS84cTFaZlVNQkg4bGhhTm4rYWR0OXNrQ2hp?=
 =?utf-8?B?SjE0VzJLYVB6MmI0U3dmY0UzZGcrVGlZSjgxaXkzV3hHclgxMmx0dS9zdUI1?=
 =?utf-8?B?VFBHaDZobXFJSVQvTFN6Unl1MmEvdW5UM0NqditIeksveWR1VjZhZ3NiOEF0?=
 =?utf-8?B?RVVHVGw4QjJLTndqcndtRkE2WFBLZWhyMXNxcFdIdU1LcWwzaWZXNGFEQ0Rp?=
 =?utf-8?B?clprVTMyczBpcTRwa2UvcHZId1Byc01aV1QzZ0JvSmVPcS9lUTJSVDd2OU1V?=
 =?utf-8?B?eldyVlE4dVcxdTQyOVNadTRtRWlzcUc4aXh1YlR3Si9TZllkSFQ1UHNZdEMy?=
 =?utf-8?B?cEpWZFVlN1ZVK0ErckRRMUlQZzd6MDNNYXB3UjBIdThYWG9Ha3pEWjB1SWZw?=
 =?utf-8?Q?+mY0r6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1pjWm9NK2xkQjFhcmtiY0lEbU13MjNocEM3Und0SmJKOXR5TFZHazJBR242?=
 =?utf-8?B?OUo3eC84Y29DUzhjYVZOT25DMVBOZ2dtR1lrZUh4T05iY3JCaStqbzErL3g3?=
 =?utf-8?B?ODZaRGoxOHNEOVNubHQvMERPU2Y2Snh6dURtVkppazEwall6NVc2Q29RdkEz?=
 =?utf-8?B?UVNuRnpqVTh3V0NCdHVxOGFiQnBRYVQwKzFNV3lDR0lQVDg2aC92YVJ5dTJD?=
 =?utf-8?B?bnNRVDZwQy9RRVI1UU1hZXFjT1g5bGVaZENycVo1Q0tCR2s3dDRyR1M5d0dq?=
 =?utf-8?B?NTVaTkdmZlY4VytVNWJiUm5JUEZzT3JkSlNFNG52TE51bzVmbkk1SVRsUTBJ?=
 =?utf-8?B?d3dtdXhIWjBWT0g1Ti9mTll1V2laUnZNR0dhWU1Sa2RBUTZKQmpEcTROdE1R?=
 =?utf-8?B?RmIrT0lqR1dLMWNyQ09LMmJTWkl3M3JDK1VRWFdKc1k3bmFpcDFKSU1MRXVS?=
 =?utf-8?B?MHJUNGpnODVnVXFhR09WL1VtczdSenhWN3IzZjRxRVdXZHFMUFYrakdMYnpL?=
 =?utf-8?B?dlVSQ0dXUEZGUlNFVmxBQ1Y3UTdITGxRNVhDT2Q0MEpqOVVxTmk4Nk9mZDdY?=
 =?utf-8?B?RXpKTWhXdXJ1ZEx1TW1xTXo3Ty9PTGFJN3NqbXVMY2NkM1VtSHo1cm5SSmR0?=
 =?utf-8?B?R1ZrQVZJcWFHUnNBenVMcUtnVUxDaGVWWFFLL0FEdld2VmtEWFRrL01Mb0gz?=
 =?utf-8?B?REd0NDZPRnA3ZjNtbVQ3azNkZFAvRDhvMGVtTTFmVnJHT2VHOHJpUWZ2YVRC?=
 =?utf-8?B?REVzb2h1a0JhckJpQmlJMlRFZ0RZeklQZXRLWFFUc25CSk1iYTY3ZmFRY1E0?=
 =?utf-8?B?T01DcHRxcWltM2dCTWlOdVJHK1hMV1Y0WGZ3YW04T2hWTHkrSXZDUlBqR3lG?=
 =?utf-8?B?STFrWHNhTFpjQ3YrQUhhRGxONjlzTUZlRnpac244WXNNYTJOWVBEcnBudldG?=
 =?utf-8?B?bjlLWTN3Q1lMeFE0NDJDTG80akV4STVOV3FNOUh5UGMxZFhOUkhDb01SNURF?=
 =?utf-8?B?TWc5QTNMbE5DQ00yTkRQMlJWQ3RyY0hwLzZvU21nN3ZaQlR3eFJudHl0cEFC?=
 =?utf-8?B?cno4SnV5MFhCZUFoQUI1N0QxQlpENlo0dWJMV2I2K2p6bnJyYUF2dXpqbW4x?=
 =?utf-8?B?T1V0czFhaGFFRHNsYlVxSURyTkRhR05XdXp3VEMwNlVkdXA2TjRmc0d5bGk5?=
 =?utf-8?B?K29VMEk2cVdPNUhGRVNvdXNEcFp2M1Q3OCtrakdwdUFHWmtKZWtlYjBvc0pm?=
 =?utf-8?B?cnVZS1BPOEJxa0kvYTJOd3RUQTY0MVJKemJlbkdKdS8yclhPTVh6bjBUQmNH?=
 =?utf-8?B?UXk3YVhLQW1iYWNXSnVIb1ZkY2wwZTF3YkFWSDFZSHBheTQ2aUU0S1ptM1Fm?=
 =?utf-8?B?Vm9KTkwrYVlzcWtOVE5DaVdNcVpBWWVHMFBsbXRFNUpROHNaOW9NNHU4WHZ3?=
 =?utf-8?B?cFdIOEZhc3d4ajFRcmFmN3VwbkZCWHF6clgvSTVnblY2OFNobHIybjNFMytl?=
 =?utf-8?B?NDN1YlJiNW0yaHl2VlV1b0NuMW5jK1FhSEtYcmQxWSs0anI2eUpjejR1a1RQ?=
 =?utf-8?B?WGU4QzY3TzNTNVJUYlNhV0R1Z01QWUZWRWZuR1BFVkZhTDhHMGpKOHAxTmJS?=
 =?utf-8?B?Q0RpYzhIVUhxcEF5SmJFU2xKRXRHem0rTXJ0YVR5OHNTaVRJOUY0c1gyOVlp?=
 =?utf-8?B?VGJPKytjMTZZMVZ3b0d2OExIdnhiQ005RUZSR05BUVpsNW9VMkpEZEl3LzU3?=
 =?utf-8?B?dUxtYzdYcVJwdytxaExZb1NTZzZ4cVFyZm0xUC9pTVJaTGM4WndUcTZSVk4v?=
 =?utf-8?B?Q09yZHJUK3pZUTVaclZ2emd0eHdHakcrRzJoaHdKL0h0UFlLYlVKYWNsNlVk?=
 =?utf-8?B?WG5CUjdZUjE3NFNHWTFiZU45blpTeVZ2QTU1cHk1ZjRVcFVvb2VNek9rWFhp?=
 =?utf-8?B?YWM5L0d2WkxReFJSYlBsMEJTQ21FTGV0b1ZrV3NYRTdZM1QyYnk0TThacnJs?=
 =?utf-8?B?VkZWSlRUR3UzQU9JK055b2FpQTUzbStqZUoxVGlRbzIxa2ZZei9KNTY4bE9F?=
 =?utf-8?B?RHpnOWo0cFhYTWJxelNWY05zamkwK3RnUHU4VVNZV2h0bWlYRVBoaFpjeHNG?=
 =?utf-8?B?RTZDQUlMY1ptUGZtcXJQc25mak94RmhhWnpLUDExcHhzZURlSnd5dlhnZVlE?=
 =?utf-8?B?UkpHVjE1TnZtVmhaTjU1M1g1WmQzQy9ZalZCUHVTOE5xZklOcUNQNUZjMU5j?=
 =?utf-8?B?NjFxc3BPTVBIVTVaamRoak1oVDA1VHdiZGc1UWppV0VrZ0s4QzhHalN3SnMr?=
 =?utf-8?B?a1h4M0E4RmhFTjhWMytHaTErZEpQeE16dXVSd2h4YnZoR2JDZi9MUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67445ed1-89a4-4acd-ab15-08de4e9bb2dd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:52:56.4086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VwkkEw3PP+BTGMdBj0QmTwfrywGazEjtgoCZrWH2GPP6y/pxzHFk3MbqhcJhbDrNJWB9fMutgVw4nbxXSXUTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11681
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

No user of "gd" in this file, drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/imx93_evk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index 4c58272523a..0278ef9805f 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -6,13 +6,10 @@
 #include <env.h>
 #include <efi_loader.h>
 #include <init.h>
-#include <asm/global_data.h>
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
 	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \

-- 
2.51.0

