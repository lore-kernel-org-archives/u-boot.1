Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A49CD116F3
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 08:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 112E283F70;
	Wed,  3 Dec 2025 09:53:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="du92Mp9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0E4783F5B; Wed,  3 Dec 2025 09:52:56 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A3183F6D
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 09:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTjpXzGuCYOYUvBv/re4K5INDADUXl1dEKYqT/7SPqRpf/+fYdj6/hebxATIha3CbteqoW1TIR6xvDGMJk5pQ61Wn+ZusbTPt1JuQH5BSCUTZL39+QHBdDBKVVbbQfOTdU+a0D9maMmylftGDDijWtZNzmC6OH/xd6ifBGMqivqoEj/aU5jRY+pdnjM4exB3XvB2oKzVJy/ZWc2aun7gRueqTytL3FrZujgzM4wHyJFJtPGyRV9jLD6v99hE2eGm/SXbW4tQZO2JYXcjfRzed4geGraNDLw6VdmsTtqP1hrNdWaE3Yloe4xlZJQYMWGGKPTtEAz7+F30cN++fAnDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldHgXDUW7mxm9/61Rc1NTkTbO/pQEkBvauwQsiesR2U=;
 b=C6gLF+2F3ySMj3C8oQc+NZ7+pwvg9hdEY4k/3EvbLAt10YxvxrplTH8fz7TliuzDT2CG6Q18TDE66kWIDH0LmUSXhqIBsyeWjiYRS0DrsMVrupNlUFDoOs/7nQbZJfYT356bced9cBp4NDKwOkHhJYlq09i2zUr/nVnvI93PAw9PgKhqbgeVC0/Jsvk07F1pIBf9zzfN8vNvDN7vEX74+RET3F0TOYSxH5B43FTzagcljZm/onckL3qiT8UYeXKOekJBEw132u4wmckQj6DBUEdrzmycXLwfNAGseZ8fgwXqi97LwNRUgE5PvJUm3am3ymrsdcBiDnfsOk1QMPE1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldHgXDUW7mxm9/61Rc1NTkTbO/pQEkBvauwQsiesR2U=;
 b=du92Mp9IAmWtFu0pwZIWQnzVeABYAIyHPNDEBPaobVTcYvBh9sRqGFq0IikCGXNcHWW+k0j/8OEH/611fF+jdNnoSPM+/d8mu10B5vMp92bmwRug/HzFRagO3A728pYP98DuoBn68nlXSx4mnA1G8Ib/x3PWgc1atpRnsRlm5tHquzfhTPDe69BRxDJYWpLTaIKvkl6lRr0In3XO3fec7PEc6TiJnRkh+9bGo4agDCFmbpRnMhj8CoHOKMt2QYUX92OJrXVjhYC4E4Mwf23x/otjELWfVutrbrpTTgb+6sdGv31iVz+Z1T06DxB6erAKarYUz6mHpGbwhhF8ftSflQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA1PR04MB11407.eurprd04.prod.outlook.com (2603:10a6:102:4f7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 08:52:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 08:52:52 +0000
From: alice.guo@oss.nxp.com
Date: Wed, 03 Dec 2025 16:51:41 +0800
Subject: [PATCH v2 2/2] imx8ulp_evk: Switch to use devicetree imported from
 Linux kernel release
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-imx8ulp-v1-2-c05ced433033@nxp.com>
References: <20251203-imx8ulp-v1-0-c05ced433033@nxp.com>
In-Reply-To: <20251203-imx8ulp-v1-0-c05ced433033@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Garrett Giordano <ggiordano@phytec.com>, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Johan Jonker <jbx6244@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA1PR04MB11407:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c8dca9-c06a-46ac-7c51-08de3249577a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|366016|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NjYrWG5tYWgzdFRKK3FqTzhaSllxQ1Y5aEdYSmlGNG1CaFM2ZTBnRXZ4NVhr?=
 =?utf-8?B?WnQrRWRNY0p5NEZGbzZqdklsai9Bc2pwaGFzZDlVVkZBekdSRnQrczM2ZXlJ?=
 =?utf-8?B?VmV6T29qbUlTMHA1QTlVbU5PYU44QW5LT1RHY3FWcU5TYjhQbXduS1h0bG9F?=
 =?utf-8?B?L1ZyaGlGd0tkTFI4RjRhTWdTZWRxMFFDeCtuVWExZE4wYlk3RW0xeHNqUTdh?=
 =?utf-8?B?eXZxTmZiMUV5L0NPanJNV1IxUkFHeEsxWkYrSm51WmZ4bXo1UGp1cElwd2dH?=
 =?utf-8?B?Qkg3UEEyenQ0Z0ZrbVRyZFBoZzdOMU50WWRDdjJ4WStmYXEzbGo4WFNlQ3po?=
 =?utf-8?B?MlVWUGJsdDRoeDYrR3B1b05sNXZOUFpHVXFtdCs4SVdzT1E4NVVNM1NlNzVx?=
 =?utf-8?B?M0lOKzhPL1FxUkthWDBlQ0h5c255c2NiQlZ1TFJVTTBWdlZ3cU8yYkFZalov?=
 =?utf-8?B?a205V0N3ME9kZ1JtV1FwTUlyeE1YTXdtZGlWeVl0R21rckNtVTZwVnRVTmxY?=
 =?utf-8?B?SlZUNFgwVE9EdHBZUmpuaXJSMTRYQlFNOHFrZVA5eXF0dVNZNWNveE1EdUU2?=
 =?utf-8?B?a1NJc2VvdnBhWjh5SjNLVFlNUE1URm9DV2hBNnAreVJGREU4a3Y5OVp4WjRX?=
 =?utf-8?B?aDl2Q2NNb09ySGZneUFLL1VFMDdjVExRUHBqdUthdHFmeEVQcEt1RS9vb1Iv?=
 =?utf-8?B?eE4zWUY1UzFFZ2N0SXJTNlVnYTRtZGtYS2JVbVBMcHBYeEg4ZWpPUC9BYzQv?=
 =?utf-8?B?YWxQdEFyalNhS3g4Y2p1Zk9hRTBVZ1JaTHJBK2twcHR3RDdKUkd2clE5aklQ?=
 =?utf-8?B?N3pscS9HN0NVMHRmbU1zaUZvUThscGNqWCtLRW90QXhNVzYxcTlmOHdiZ25Q?=
 =?utf-8?B?YTUxTG85UHlTdW9GbEx6T2FRNzBLd1BGY01HVDdOb1JmTyt3OE80WHN0WFpE?=
 =?utf-8?B?T1ZFV2hpSVp5YStlcUFpN2NPN1l5R1ZyVlZVcEhsZXJ6ajhmaVppM2ZJZU5P?=
 =?utf-8?B?cXZoYlJ3VkFMK2s1NFBvdjFqY0FoN1N3UXVkb0JldURndE51N1FpOFpuVVhW?=
 =?utf-8?B?YktJR041TGpuTlQxRTlPajhkQW5TaHpOek1kb0JYVFNtSEpNZHNJT3k0Ync2?=
 =?utf-8?B?YmZ5VFZEOGlCWkRtUWhiM3JPVHczL2pPYlpYVm9VVE4rajJNQ3lFbXQybCtj?=
 =?utf-8?B?YkdYUlhvQXhlZDIyTmk1OUdVUXZob2Y2OXNoVWIzK0FWWk1LVVRuWWNNbW8w?=
 =?utf-8?B?amJ1RHVqOUFOOCs0eThkTklhdExsTXQ4ekNPQjh1WjA0Tndka3pzNkV3cnZy?=
 =?utf-8?B?RXBnY2hLRENGN2FzWVVkNWcwbFhTeTJMTGJBOW9DdUdxdjlKZVQ0aVNnUnFE?=
 =?utf-8?B?MnJXWFlEU0FKMnVMZC8vcG41TGFzdC9hU2FoZERJaktFTzM4ZVljSm0xbmJn?=
 =?utf-8?B?bHczOGc4UXVlYWlRS2xXRVR6SVBJdTAxRkVkUVd5UDk3M0dkM3llRnM5L2dV?=
 =?utf-8?B?UklNTnc5UWE4c3NuRnB1bnY2RG5nd01USHNaeDQzM2Z3L2h0MHVPN25DQ2N1?=
 =?utf-8?B?TmE0T3Zod3dySHl3dHJtdDVyS2NWT3hycVRNTDdiL1B0QmlKVjBRUit2TDIr?=
 =?utf-8?B?cUFkSXJiaUZOU25NdHBvTGg4MUs4U3RXRlBDUWUrQ3M2RjU4YTZBR0U0OEhS?=
 =?utf-8?B?Q0FYYVU3Nm5Bd0hwdFo1SmM0VkZRcFhuNWVzdDZFM2cwTnhKOUVMd2RPd0xq?=
 =?utf-8?B?cWp4U2ZIVXpuclNNajRpSElMdmFPLzVqNnBjdHZnQVlOTDdjYTBsNjNJdU9w?=
 =?utf-8?B?UGl6a29JNHJsSzFMYU4vTmR0K004SE56NjFOdE1GdTMvdmxJc3BBalk3WGlH?=
 =?utf-8?B?VWxDRWNXLzR6aGVLdlRWVEZHM3ZrMEF5c1BvazVrbWlkM0JXS3lrV1pNUXNv?=
 =?utf-8?B?SFNSMklrSkUvU2VmZkxvYlBZbWRlVjVFdWZiRUw0TVV1bUZCd2NkK2NwZDFV?=
 =?utf-8?B?Y2FPelBhM2JncWZqdWFVRGU2blB4amhOWXpGQ0NwZlo1b0FlOVBoV3hkNHZi?=
 =?utf-8?Q?Q4nTB7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVZ0bXNqaHk5TmMzUHcvQmtybDlSeHJObE9TcWlhaVBiTGRxamdabnBhS1l1?=
 =?utf-8?B?MDVEZDZDa1cxVmM2ditFdkswb2FhVHQyYnFncG5aVXhBSFM0TzdSYS9oYnZV?=
 =?utf-8?B?TU5DMmFZN1NnRUJUTHFBeUVJK0pXOXdLK0JyT2duZ3VvWDBaWjRrYjdlNXBy?=
 =?utf-8?B?VUlhYm1RUVhUTXJXS1E3VTBVdUt1WmlmZWNDenNyby9rZTRNdDQrS1lEYklV?=
 =?utf-8?B?VENTVWQ3SFFma2xzV3JIbW40V0E2QlNtSzZ2UUNQdnUyUGNXRDdzbVJJcURY?=
 =?utf-8?B?bEowODZyRm9mcHlhRWFRbHBNQXhGbWt2bmZZcGpycytkRUF6MVliaGlyb25i?=
 =?utf-8?B?OTZtS1NEYS9sSXJ2UWl4dEhJL01wVVpHbXVrTE9PajZyNFB1UmtvSkNSbSsw?=
 =?utf-8?B?Y0t2bXBMSjdJNzlwWFRJaUdKTDdpZFF2NkZUeWx2c3RNVVlSNWY2eDliME1h?=
 =?utf-8?B?aGdwWTZKMmZkRllqKzJXc0hyM3dxQk0rTTRtUmhObVhIZlRSdjZ3b2huTWsv?=
 =?utf-8?B?NnkxbC9kTkF2aGF6SUEyYTQ5Wmttem55UjJXMG5xWjJmcUM5TGs2WkVFckd5?=
 =?utf-8?B?Nm1RU1c0dFE1a3lNS3RBbUVid2NoRW0yZW53bzJXdzQ1QkNGZkFORFN1QUsw?=
 =?utf-8?B?elNrMU8zOWRtSnJQVkFZUkVVQnIzTWlQbm9LRlVmVHc3RUNHQ0p6dWRCMnpO?=
 =?utf-8?B?SVN2MUlTYTE2Sk5LTG5rczQ1WlYyNTd2RHdTVURDQlR0TDU4ZkpwaDRUWWJR?=
 =?utf-8?B?RXI0YWMxNEtxRnIvMTRRUGkvYWRMZk5QQ3NYSUcyZlM0ZDZIWjEvNmlZVUNK?=
 =?utf-8?B?dm9kN2ZUa1RCMlRidU81Y0YwRHdhMXUzUWlESkFDWEdoT2djTDVGL1ZmZ0Yv?=
 =?utf-8?B?TndWTG9MVTZWVklrOVlBY2pMUTNQQ3VNcnFZWmUwTytaYnpEOUZwcGlTTG1L?=
 =?utf-8?B?U3k5dTRSZEVncXJLZUtVQ0ZsMks0UlI0ZjNwTmVqWU5INGJqVlN6SWhaYW9w?=
 =?utf-8?B?Rm0wanZVYXV0MnkzUlhRYnhNNjNNc2d5eGtqcWtlQ3Zmdll1Z3pSU2k1WGVR?=
 =?utf-8?B?bFRBM3RKV3VuWkxrU2RDWlNVYlhUZW1uMHJTVlVqN2IwVEU5TklVT1dKMDUx?=
 =?utf-8?B?eU1WUEkzazFjbmNKaks1Y1paNFJVV2JaNEtrYXBTb2Q0bC92SnlUOGd4cmh6?=
 =?utf-8?B?MTRGSXNFUFR0eXlFald5eXp4bWR0Q1VHQ0MrVUFJRTAwTFVjVnJRWHBwMzZ5?=
 =?utf-8?B?bHBPVFVmbGxyMjNtL1AwQURJODNYV2FqczNkekVjYWlKNEJ1NTc5dDVKbVpJ?=
 =?utf-8?B?MDdENE9PVzVMQTJjaEdsMmEwSit5RThoWWZ6Wk5YZVQzMDhBdkhnNHJLNUdk?=
 =?utf-8?B?QnE5ZVRObk5ua2MvRnZhKzJVN0VaQXZqOXRMUzdZWGV6QmpKSVgyOUhubUUr?=
 =?utf-8?B?djRmQ3JOc0QvVm1UTklXdHNFakt2cGNrTHgwOElMTElRcDBoQm1JVlZUd2NI?=
 =?utf-8?B?OEVMb3QwUW1POE1ZNU9tSFl6ZjYvbHU4REJZTFdzS292K2hCVGNjMHY4UlRD?=
 =?utf-8?B?eW9CMWdsa2JLdG5MTEFPakllbmpFMFQ4YWVsWDZQSXVCcDNyNG5IY2dXZTZk?=
 =?utf-8?B?MnRMdWZGR0VEKzFMMmM4S0t0UHlBeFNscGowQklFR2xXOWxTOVlYMTlDL28r?=
 =?utf-8?B?UG44MDY5M3JQUHZ2R3JaZVI0bktQSmNrOVkvc2JwSkxIZWlvWForTUcwaXE4?=
 =?utf-8?B?UlZTOWNlZXdNTnhaMnEvalRSVkNnVURkQ09vWUVDc29MbDNtVXhDaFMxYTR6?=
 =?utf-8?B?TkxVZWtCSzh6SkFmN2I3MkpHRElQQ3dFZ0hRSk5IUnJxek5EV0ExVlo1ckdO?=
 =?utf-8?B?L0dsZHZzaTRtYk5EMnRKT1lYcmVTSzBNTHRoTU5vTnZOSFJaUHFhd01OZSts?=
 =?utf-8?B?aERJRGI1azY3NmwzRjVFcldmNHRsRllWU3hUQlN0cElSNWxxTGd4VnRDa1lW?=
 =?utf-8?B?TDNqcXlOR3FiUndLam5TcmZkdG0xZEc4SUhNWjlmM2g3WTlwVXloWldVdTN0?=
 =?utf-8?B?Q2dpcGlaRzJtTlFZT1NlSkJMamdTM24xaW4vbFBScFpESGNXTVhlNThRNlV0?=
 =?utf-8?Q?nlGOYxFhJY5nTldVBWke6Rx/Q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c8dca9-c06a-46ac-7c51-08de3249577a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 08:52:51.9758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inxWEXbc2+MCQLg8fHHHhHzMvmVwXUCDuAPVyTlDsYXmEVF0sdErQg0gPcOlhqjo8sZUnyjSpFxPVnjHFNbt5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11407
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

From: Alice Guo <alice.guo@nxp.com>

Enable OF_UPSTREAM for i.MX8ULP EVK so that devicetree imported from
Linux kernel release can be used.

If mailbox@29220000 is enabled, gd->arch.ele_dev will be set to this
device for communication with ELE firmware. This is incorrect because
mu@27020000 is the MU used for communication with the ELE firmware. To
prevent misconfiguration, disable mailbox@29220000.

The driver model for watchdog timer is not enabled yet, so disable wdog3
temporarily.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/Makefile                |   3 -
 arch/arm/dts/imx8ulp-evk-u-boot.dtsi |   8 +
 arch/arm/dts/imx8ulp-evk.dts         | 125 ---------
 arch/arm/dts/imx8ulp.dtsi            | 476 -----------------------------------
 arch/arm/mach-imx/imx8ulp/Kconfig    |   1 +
 configs/imx8ulp_evk_defconfig        |   2 +-
 6 files changed, 10 insertions(+), 605 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 865ceb65f9a..b7ece30d1a3 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -880,9 +880,6 @@ dtb-$(CONFIG_ARCH_IMX8) += \
 	fsl-imx8qxp-mek.dtb \
 	imx8-capricorn-cxg3.dtb \
 
-dtb-$(CONFIG_ARCH_IMX8ULP) += \
-	imx8ulp-evk.dtb
-
 dtb-$(CONFIG_ARCH_IMX8M) += \
 	imx8mm-data-modul-edm-sbc.dtb \
 	imx8mm-icore-mx8mm-ctouch2.dtb \
diff --git a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
index 2782dc7dd75..860994129ae 100644
--- a/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8ulp-evk-u-boot.dtsi
@@ -22,6 +22,14 @@
 	bootph-all;
 };
 
+&mu {
+	status = "disabled";
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
 &per_bridge4 {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/imx8ulp-evk.dts b/arch/arm/dts/imx8ulp-evk.dts
deleted file mode 100644
index 7aec1706382..00000000000
--- a/arch/arm/dts/imx8ulp-evk.dts
+++ /dev/null
@@ -1,125 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2021 NXP
- */
-
-/dts-v1/;
-
-#include "imx8ulp.dtsi"
-
-/ {
-	model = "NXP i.MX8ULP EVK";
-	compatible = "fsl,imx8ulp-evk", "fsl,imx8ulp";
-
-	chosen {
-		stdout-path = &lpuart5;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0 0x80000000>;
-	};
-
-	clock_ext_rmii: clock-ext-rmii {
-		compatible = "fixed-clock";
-		clock-frequency = <50000000>;
-		clock-output-names = "ext_rmii_clk";
-		#clock-cells = <0>;
-	};
-
-	clock_ext_ts: clock-ext-ts {
-		compatible = "fixed-clock";
-		/* External ts clock is 50MHZ from PHY on EVK board. */
-		clock-frequency = <50000000>;
-		clock-output-names = "ext_ts_clk";
-		#clock-cells = <0>;
-	};
-};
-
-&lpuart5 {
-	/* console */
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpuart5>;
-	pinctrl-1 = <&pinctrl_lpuart5>;
-	status = "okay";
-};
-
-&usdhc0 {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_usdhc0>;
-	pinctrl-1 = <&pinctrl_usdhc0>;
-	non-removable;
-	bus-width = <8>;
-	status = "okay";
-};
-
-&fec {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_enet>;
-	pinctrl-1 = <&pinctrl_enet>;
-	clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
-		 <&pcc4 IMX8ULP_CLK_ENET>,
-		 <&cgc1 IMX8ULP_CLK_ENET_TS_SEL>,
-		 <&clock_ext_rmii>;
-	clock-names = "ipg", "ahb", "ptp", "enet_clk_ref";
-	assigned-clocks = <&cgc1 IMX8ULP_CLK_ENET_TS_SEL>;
-	assigned-clock-parents = <&clock_ext_ts>;
-	phy-mode = "rmii";
-	phy-handle = <&ethphy>;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		ethphy: ethernet-phy@1 {
-			reg = <1>;
-			micrel,led-mode = <1>;
-		};
-	};
-};
-
-&iomuxc1 {
-	pinctrl_enet: enetgrp {
-		fsl,pins = <
-			MX8ULP_PAD_PTE15__ENET0_MDC     0x43
-			MX8ULP_PAD_PTE14__ENET0_MDIO    0x43
-			MX8ULP_PAD_PTE17__ENET0_RXER    0x43
-			MX8ULP_PAD_PTE18__ENET0_CRS_DV  0x43
-			MX8ULP_PAD_PTF1__ENET0_RXD0     0x43
-			MX8ULP_PAD_PTE20__ENET0_RXD1    0x43
-			MX8ULP_PAD_PTE16__ENET0_TXEN    0x43
-			MX8ULP_PAD_PTE23__ENET0_TXD0    0x43
-			MX8ULP_PAD_PTE22__ENET0_TXD1    0x43
-			MX8ULP_PAD_PTE19__ENET0_REFCLK  0x43
-			MX8ULP_PAD_PTF10__ENET0_1588_CLKIN 0x43
-		>;
-	};
-
-	pinctrl_lpuart5: lpuart5grp {
-		fsl,pins = <
-			MX8ULP_PAD_PTF14__LPUART5_TX	0x3
-			MX8ULP_PAD_PTF15__LPUART5_RX	0x3
-		>;
-	};
-
-	pinctrl_usdhc0: usdhc0grp {
-		fsl,pins = <
-			MX8ULP_PAD_PTD1__SDHC0_CMD	0x43
-			MX8ULP_PAD_PTD2__SDHC0_CLK	0x10042
-			MX8ULP_PAD_PTD10__SDHC0_D0	0x43
-			MX8ULP_PAD_PTD9__SDHC0_D1	0x43
-			MX8ULP_PAD_PTD8__SDHC0_D2	0x43
-			MX8ULP_PAD_PTD7__SDHC0_D3	0x43
-			MX8ULP_PAD_PTD6__SDHC0_D4	0x43
-			MX8ULP_PAD_PTD5__SDHC0_D5	0x43
-			MX8ULP_PAD_PTD4__SDHC0_D6	0x43
-			MX8ULP_PAD_PTD3__SDHC0_D7	0x43
-			MX8ULP_PAD_PTD11__SDHC0_DQS	0x10042
-		>;
-	};
-};
-
-&wdog3 {
-	status = "disabled";
-};
diff --git a/arch/arm/dts/imx8ulp.dtsi b/arch/arm/dts/imx8ulp.dtsi
deleted file mode 100644
index 06ce5f19aa8..00000000000
--- a/arch/arm/dts/imx8ulp.dtsi
+++ /dev/null
@@ -1,476 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Copyright 2021 NXP
- */
-
-#include <dt-bindings/clock/imx8ulp-clock.h>
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/power/imx8ulp-power.h>
-
-#include "imx8ulp-pinfunc.h"
-
-/ {
-	interrupt-parent = <&gic>;
-	#address-cells = <2>;
-	#size-cells = <2>;
-
-	aliases {
-		ethernet0 = &fec;
-		gpio0 = &gpiod;
-		gpio1 = &gpioe;
-		gpio2 = &gpiof;
-		mmc0 = &usdhc0;
-		mmc1 = &usdhc1;
-		mmc2 = &usdhc2;
-		serial0 = &lpuart4;
-		serial1 = &lpuart5;
-		serial2 = &lpuart6;
-		serial3 = &lpuart7;
-	};
-
-	cpus {
-		#address-cells = <2>;
-		#size-cells = <0>;
-
-		A35_0: cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a35";
-			reg = <0x0 0x0>;
-			enable-method = "psci";
-			next-level-cache = <&A35_L2>;
-		};
-
-		A35_1: cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,cortex-a35";
-			reg = <0x0 0x1>;
-			enable-method = "psci";
-			next-level-cache = <&A35_L2>;
-		};
-
-		A35_L2: l2-cache0 {
-			compatible = "cache";
-		};
-	};
-
-	gic: interrupt-controller@2d400000 {
-		compatible = "arm,gic-v3";
-		reg = <0x0 0x2d400000 0 0x10000>, /* GIC Dist */
-		      <0x0 0x2d440000 0 0xc0000>; /* GICR (RD_base + SGI_base) */
-		#interrupt-cells = <3>;
-		interrupt-controller;
-		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	pmu {
-		compatible = "arm,cortex-a35-pmu";
-		interrupt-parent = <&gic>;
-		interrupts = <GIC_PPI 7
-			     (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
-		interrupt-affinity = <&A35_0>, <&A35_1>;
-	};
-
-	psci {
-		compatible = "arm,psci-1.0";
-		method = "smc";
-	};
-
-	timer {
-		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
-			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>, /* Physical Non-Secure */
-			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>, /* Virtual */
-			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
-	};
-
-	frosc: clock-frosc {
-		compatible = "fixed-clock";
-		clock-frequency = <192000000>;
-		clock-output-names = "frosc";
-		#clock-cells = <0>;
-	};
-
-	lposc: clock-lposc {
-		compatible = "fixed-clock";
-		clock-frequency = <1000000>;
-		clock-output-names = "lposc";
-		#clock-cells = <0>;
-	};
-
-	rosc: clock-rosc {
-		compatible = "fixed-clock";
-		clock-frequency = <32768>;
-		clock-output-names = "rosc";
-		#clock-cells = <0>;
-	};
-
-	sosc: clock-sosc {
-		compatible = "fixed-clock";
-		clock-frequency = <24000000>;
-		clock-output-names = "sosc";
-		#clock-cells = <0>;
-	};
-
-	sram@2201f000 {
-		compatible = "mmio-sram";
-		reg = <0x0 0x2201f000 0x0 0x1000>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x0 0x2201f000 0x1000>;
-
-		scmi_buf: scmi-sram-section@0 {
-			compatible = "arm,scmi-shmem";
-			reg = <0x0 0x400>;
-		};
-	};
-
-	firmware {
-		scmi {
-			compatible = "arm,scmi-smc";
-			arm,smc-id = <0xc20000fe>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			shmem = <&scmi_buf>;
-
-			scmi_devpd: protocol@11 {
-				reg = <0x11>;
-				#power-domain-cells = <1>;
-			};
-
-			scmi_sensor: protocol@15 {
-				reg = <0x15>;
-				#thermal-sensor-cells = <1>;
-			};
-		};
-	};
-
-	soc: soc@0 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x40000000>;
-
-		s4muap: mailbox@27020000 {
-			compatible = "fsl,imx8ulp-mu-s4";
-			reg = <0x27020000 0x10000>;
-			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			#mbox-cells = <2>;
-		};
-
-		per_bridge3: bus@29000000 {
-			compatible = "simple-bus";
-			reg = <0x29000000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			mu: mailbox@29220000 {
-				compatible = "fsl,imx8ulp-mu";
-				reg = <0x29220000 0x10000>;
-				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			mu3: mailbox@29230000 {
-				compatible = "fsl,imx8ulp-mu";
-				reg = <0x29230000 0x10000>;
-				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_MU3_A>;
-				#mbox-cells = <2>;
-				status = "disabled";
-			};
-
-			wdog3: watchdog@292a0000 {
-				compatible = "fsl,imx8ulp-wdt", "fsl,imx7ulp-wdt";
-				reg = <0x292a0000 0x10000>;
-				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_WDOG3>;
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_WDOG3>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_SOSC_DIV2>;
-				timeout-sec = <40>;
-			};
-
-			cgc1: clock-controller@292c0000 {
-				compatible = "fsl,imx8ulp-cgc1";
-				reg = <0x292c0000 0x10000>;
-				#clock-cells = <1>;
-			};
-
-			pcc3: clock-controller@292d0000 {
-				compatible = "fsl,imx8ulp-pcc3";
-				reg = <0x292d0000 0x10000>;
-				#clock-cells = <1>;
-				#reset-cells = <1>;
-			};
-
-			tpm5: tpm@29340000 {
-				compatible = "fsl,imx8ulp-tpm", "fsl,imx7ulp-tpm";
-				reg = <0x29340000 0x1000>;
-				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_TPM5>,
-					 <&pcc3 IMX8ULP_CLK_TPM5>;
-				clock-names = "ipg", "per";
-				status = "disabled";
-			};
-
-			lpi2c4: i2c@29370000 {
-				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x29370000 0x10000>;
-				interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPI2C4>,
-					 <&pcc3 IMX8ULP_CLK_LPI2C4>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C4>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpi2c5: i2c@29380000 {
-				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x29380000 0x10000>;
-				interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPI2C5>,
-					 <&pcc3 IMX8ULP_CLK_LPI2C5>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPI2C5>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpuart4: serial@29390000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x29390000 0x1000>;
-				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPUART4>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart5: serial@293a0000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x293a0000 0x1000>;
-				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPUART5>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpspi4: spi@293b0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8ulp-spi", "fsl,imx7ulp-spi";
-				reg = <0x293b0000 0x10000>;
-				interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPSPI4>,
-					 <&pcc3 IMX8ULP_CLK_LPSPI4>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI4>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpspi5: spi@293c0000 {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				compatible = "fsl,imx8ulp-spi", "fsl,imx7ulp-spi";
-				reg = <0x293c0000 0x10000>;
-				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc3 IMX8ULP_CLK_LPSPI5>,
-					 <&pcc3 IMX8ULP_CLK_LPSPI5>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc3 IMX8ULP_CLK_LPSPI5>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-		};
-
-		per_bridge4: bus@29800000 {
-			compatible = "simple-bus";
-			reg = <0x29800000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			pcc4: clock-controller@29800000 {
-				compatible = "fsl,imx8ulp-pcc4";
-				reg = <0x29800000 0x10000>;
-				#clock-cells = <1>;
-				#reset-cells = <1>;
-			};
-
-			lpi2c6: i2c@29840000 {
-				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x29840000 0x10000>;
-				interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc4 IMX8ULP_CLK_LPI2C6>,
-					 <&pcc4 IMX8ULP_CLK_LPI2C6>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C6>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpi2c7: i2c@29850000 {
-				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
-				reg = <0x29850000 0x10000>;
-				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc4 IMX8ULP_CLK_LPI2C7>,
-					 <&pcc4 IMX8ULP_CLK_LPI2C7>;
-				clock-names = "per", "ipg";
-				assigned-clocks = <&pcc4 IMX8ULP_CLK_LPI2C7>;
-				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_FROSC_DIV2>;
-				assigned-clock-rates = <48000000>;
-				status = "disabled";
-			};
-
-			lpuart6: serial@29860000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x29860000 0x1000>;
-				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc4 IMX8ULP_CLK_LPUART6>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			lpuart7: serial@29870000 {
-				compatible = "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
-				reg = <0x29870000 0x1000>;
-				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&pcc4 IMX8ULP_CLK_LPUART7>;
-				clock-names = "ipg";
-				status = "disabled";
-			};
-
-			iomuxc1: pinctrl@298c0000 {
-				compatible = "fsl,imx8ulp-iomuxc1";
-				reg = <0x298c0000 0x10000>;
-			};
-
-			usdhc0: mmc@298d0000 {
-				compatible = "fsl,imx8ulp-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x298d0000 0x10000>;
-				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
-					 <&cgc1 IMX8ULP_CLK_XBAR_AD_DIVPLAT>,
-					 <&pcc4 IMX8ULP_CLK_USDHC0>;
-				clock-names = "ipg", "ahb", "per";
-				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC0>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step = <2>;
-				bus-width = <4>;
-				status = "disabled";
-			};
-
-			usdhc1: mmc@298e0000 {
-				compatible = "fsl,imx8ulp-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x298e0000 0x10000>;
-				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
-					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
-					 <&pcc4 IMX8ULP_CLK_USDHC1>;
-				clock-names = "ipg", "ahb", "per";
-				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC1>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step = <2>;
-				bus-width = <4>;
-				status = "disabled";
-			};
-
-			usdhc2: mmc@298f0000 {
-				compatible = "fsl,imx8ulp-usdhc", "fsl,imx8mm-usdhc";
-				reg = <0x298f0000 0x10000>;
-				interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cgc1 IMX8ULP_CLK_XBAR_DIVBUS>,
-					 <&cgc1 IMX8ULP_CLK_NIC_PER_DIVPLAT>,
-					 <&pcc4 IMX8ULP_CLK_USDHC2>;
-				clock-names = "ipg", "ahb", "per";
-				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
-				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step = <2>;
-				bus-width = <4>;
-				status = "disabled";
-			};
-
-			fec: ethernet@29950000 {
-				compatible = "fsl,imx8ulp-fec", "fsl,imx6ul-fec", "fsl,imx6q-fec";
-				reg = <0x29950000 0x10000>;
-				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "int0";
-				fsl,num-tx-queues = <1>;
-				fsl,num-rx-queues = <1>;
-				status = "disabled";
-			};
-		};
-
-		gpioe: gpio@2d000080 {
-				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-				reg = <0x2d000080 0x1000>, <0x2d000040 0x40>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pcc4 IMX8ULP_CLK_RGPIOE>,
-					 <&pcc4 IMX8ULP_CLK_PCTLE>;
-				clock-names = "gpio", "port";
-				gpio-ranges = <&iomuxc1 0 32 24>;
-		};
-
-		gpiof: gpio@2d010080 {
-				compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-				reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&pcc4 IMX8ULP_CLK_RGPIOF>,
-					 <&pcc4 IMX8ULP_CLK_PCTLF>;
-				clock-names = "gpio", "port";
-				gpio-ranges = <&iomuxc1 0 64 32>;
-		};
-
-		per_bridge5: bus@2d800000 {
-			compatible = "simple-bus";
-			reg = <0x2d800000 0x800000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-
-			cgc2: clock-controller@2da60000 {
-				compatible = "fsl,imx8ulp-cgc2";
-				reg = <0x2da60000 0x10000>;
-				#clock-cells = <1>;
-			};
-
-			pcc5: clock-controller@2da70000 {
-				compatible = "fsl,imx8ulp-pcc5";
-				reg = <0x2da70000 0x10000>;
-				#clock-cells = <1>;
-				#reset-cells = <1>;
-			};
-		};
-
-		gpiod: gpio@2e200080 {
-			compatible = "fsl,imx8ulp-gpio", "fsl,imx7ulp-gpio";
-			reg = <0x2e200080 0x1000>, <0x2e200040 0x40>;
-			gpio-controller;
-			#gpio-cells = <2>;
-			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			clocks = <&pcc5 IMX8ULP_CLK_RGPIOD>,
-				 <&pcc5 IMX8ULP_CLK_RGPIOD>;
-			clock-names = "gpio", "port";
-			gpio-ranges = <&iomuxc1 0 0 24>;
-		};
-	};
-};
diff --git a/arch/arm/mach-imx/imx8ulp/Kconfig b/arch/arm/mach-imx/imx8ulp/Kconfig
index e96e34651ce..d64cfca0408 100644
--- a/arch/arm/mach-imx/imx8ulp/Kconfig
+++ b/arch/arm/mach-imx/imx8ulp/Kconfig
@@ -28,6 +28,7 @@ config TARGET_IMX8ULP_EVK
 	select SUPPORT_SPL
 	select IMX8ULP_DRAM
 	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
 
 endchoice
 
diff --git a/configs/imx8ulp_evk_defconfig b/configs/imx8ulp_evk_defconfig
index f8a87dde5cf..469ee928129 100644
--- a/configs/imx8ulp_evk_defconfig
+++ b/configs/imx8ulp_evk_defconfig
@@ -10,7 +10,7 @@ CONFIG_ENV_SIZE=0x2000
 CONFIG_ENV_OFFSET=0x400000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx8ulp/imximage.cfg"
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx8ulp-evk"
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8ulp-evk"
 CONFIG_TARGET_IMX8ULP_EVK=y
 CONFIG_SYS_MONITOR_LEN=524288
 CONFIG_SPL_SERIAL=y

-- 
2.43.0

