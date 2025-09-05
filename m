Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B978CAC58E
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 07:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E5468341A;
	Mon, 15 Sep 2025 09:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Url87eMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622A383423; Mon, 15 Sep 2025 09:27:47 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D7298340C
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 09:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O36URHMqs+mpb0QmCdDV1jsu994bepO9fnyUHdaP6NdVmcLgdFeuWHa72VnRR/m0l2QQh5B4drTx2XgpFVCLkwcBrst+gz88dnNFHrfaphpITmS1i+T7bmKlJvWXvQnceVuD6RutJdIbnXCsA3Kd0XCnyydun265+wysauiXSL97wda7S/mNoDOCmTe9//UFY+4ZhLDpez21pqBIVajUSNgNIOUupDQIqAT9nCIW7RvncNk14n5vE0n9TiXFhrIuJQy8WtmlOWnlIl9Dq3xaMtfsvGCqGTQol51rJQ8H09/EGuUZBJL8R+H68Alwz7vqp1W6qQFWTa6+uQB7CGXZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0R2znsfSSNY19ZAAqGHY6ynt0u5l3zhbt779XhxpGbI=;
 b=AQk+uyMN3wfaYzpJ4aEvp2ju1Qrk4OY37pAEnnd9ai8CWr1ZYg7y1QQrHvGu2K5MVUOj61zDLQ5LSHoFqUF0t2MG7+rM6wsTeCcafQgLzQj5Pkq2q7WIvwMSasfLoK7xeonBLeYCKzFKLBJ8U9UJVLSnyxG8aFdtvXHchIPCEBfUvq5QLiKgQGI0lyzNsmap7l+qn9+C3lJl8suUlwfpQJv5uUVish097Sm5wVuHqCv9e8Z8t6/EVmJ5i/EgqvC7vyCjsy/iIs3l9s9fZIJfL4bYT+YI7bAO7U9EOjCmm0QodWNlEVLHRCRay8jjH/nm/k7LwNfCAYrTh/fBnc8vcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0R2znsfSSNY19ZAAqGHY6ynt0u5l3zhbt779XhxpGbI=;
 b=Url87eMXQsb1vkQaP2R+qKJdMQ6d/utdZrCy02Tihlqs1Mjx0eDPP2nI5Sgwpk9rjBAuY85N2ndM9viZlSZI9KPPONbHxV95+xyvawipkk4rMHs9mvUoDwM+AzftURPnRYoZfuk+AdlVhS7eFUXC2BjBEyp3bU5AO4LDCbtGVBRdqi3Tb9y4sgCirpIy7spizFkmAbAi8nfSSpObQBLY2qyMSSPapIeGZKRu8aV/8T6eGx9G46F+vBL77j6IiBrFE4euBGBACJqZ965G6E9+n71s8q8YQBBUNxGeHZYdpl/eutlSZOREZ/mjrbKMbGWuJD07yNMG3kuJSnqy/Vot9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DBBPR04MB7529.eurprd04.prod.outlook.com (2603:10a6:10:208::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 07:27:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 07:27:42 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Sat, 06 Sep 2025 02:22:03 +0800
Subject: [PATCH v5 1/2] binman: add a new entry type to support .bin file
 generation for the i.MX95 platform
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-imx95-v1-1-f2a5231c1d0f@oss.nxp.com>
References: <20250906-imx95-v1-0-f2a5231c1d0f@oss.nxp.com>
In-Reply-To: <20250906-imx95-v1-0-f2a5231c1d0f@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:4:7c::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DBBPR04MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fc4d0ff-1fa0-4171-1a1c-08ddf4295bb6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFFhZHlCNEdLcFdSdVNYd211Z1VGRi9Cc21ZbUUxRkoxWUdkaDFOR0M4K0ZI?=
 =?utf-8?B?dVg2TFpQM3BzYVd4czV1VnBTTTBRZ2JRSzdKaDZIbWJENFIzNkEwa0VlMTE4?=
 =?utf-8?B?dG91MGFJYUZDVEdWaTkvTVRuNVhIOFMvMzVaTUdQTWdVcGtBcUhOUTI5TmFk?=
 =?utf-8?B?T0tHR1BIem9TSnRvMHlvWmZDTHR6YitrVWgrN3JrSlJIR3ZFbGh3Q0U5OVZa?=
 =?utf-8?B?K3BKeXp4N2RRaXJ0S2wrQzlNdTQ3SHlpU3BYZmdFa01SRkROSE9iODlsR0RG?=
 =?utf-8?B?bzZXWlJVVmUrUlFIbS9kdms4Qi84NDFIMXhvME1oYUVIQWl4SEgrK0JvMkgv?=
 =?utf-8?B?VlgrajVJcmp3aDdIdjVPbjJnVDJLcW1GQ1E0VHZrQjJ1cGVETkl3UGhUSUls?=
 =?utf-8?B?d3NRcE45MlJ5cWR0QjF5RmYxdzdML0YvRHVtaFJHU2QrdHZCd1FESlI0Tzcv?=
 =?utf-8?B?VzhMT3poZjJNRjVHZHFLUTlCSUVxendNeG1Hd3ZxdXRhL0lnT3ZIVk1hWWE0?=
 =?utf-8?B?NEorUWxSTUt6czNETXpydXcrbDl3YWllWFM1S2J1UDhMQ3drajhzTlVBdi95?=
 =?utf-8?B?dzJta3c4TFB0c0llVDdxYmsxTFUrMFNmZ2syeG9TMkZCbUY0dmx6U0xocnQy?=
 =?utf-8?B?WWo4TVZGcEl6aS90akJWcU5VbTlKbENvUjFFbnRkNDRXb29BbzIzZ3hCUFhW?=
 =?utf-8?B?ZFdVSGlzaU5GNFVwL3NBK1BFeWJlTGs3QWdONHNPMEx6TXVlY0hkc3VRbGZU?=
 =?utf-8?B?dm1rLzlhL2xydTRUYlRibUdQeGJPM3NrM0xBaWpvUFJHZHJJREgrSnJqRUtE?=
 =?utf-8?B?SjRSNFEzeHlmR2UxUjlUejNtaWxqdGRiY0NrMGdDL2RmbEZlaUNzaXMzMDBx?=
 =?utf-8?B?Q05kWW1YQ2dNUERkajhPNVM5eXJIYnNUMzZYalY0ZFBGRVVmT0Yxd2JhbW0w?=
 =?utf-8?B?ZURRQzU0Rlk0Y28wZHpCd1Juc0FySTQvcVBnSW10UHRUcTdvSjVsKzJFekJY?=
 =?utf-8?B?MXUxWXdLVkNES3VycmYzMnNSZzllTU1Nek8zNlF4Vy9MVXVmTzdERHVoMHE1?=
 =?utf-8?B?UjJrZWRweE41ZkpiOC81SVMvZXEyTHhRKzJ4aWdEOHV1M1BDVHFKR2Qwd3Vt?=
 =?utf-8?B?N1BlZnVibzE5UnNleHJmMk9iZkZPblRaMnN1ckJBNzY3WmxIaWFxVVVNNUw4?=
 =?utf-8?B?eUJYNTV3d2RBd1FsUTdVMUNRVUdNTkhCdGpnWnBzR25Bek9HK0R1dGlVdlBB?=
 =?utf-8?B?WlhxMC81VzZZY1QyMVJxWlNjalJkS0dkMVQzdXpMUTcwQzF6N0c4Mk9jNkMy?=
 =?utf-8?B?dHF4Sk9rWWFMa3lNUTZ4WHVPdDdSMHIvMnN4Wm9Uc1V6ZklIV0E0V1hwOG5S?=
 =?utf-8?B?bitMWTNkYzRLbFFGVHNnSVphcTB3cEMxRXQxOUxPYXFROVlsMmtIY2lwWGdF?=
 =?utf-8?B?NytGTW9ob21kSXpEeDJyVmlZNGQ5UklTbzY1MDNNYTFoWlhFMTBCZnNMNzRE?=
 =?utf-8?B?UlRHVkdWSVRCRFBjZVNZODlxWHlWU0llUmUrTjhKUjdNRnlWVm5hUnZRckgr?=
 =?utf-8?B?eElxQlBOR3REQll5bys2bFg4anBZSndSbXJjN0w3bEE0Z2JVNUJXOGhHS2py?=
 =?utf-8?B?STNTemtpN1lrYjVvbG5IemM1a1BUNkY5S1MzQTU3MHBvdWthY0dIWW9PSGZO?=
 =?utf-8?B?WjFJaE9CeXpMWmpKNUJDcGFkajAyQjZPVSs2U3FwSHlPeTdJODdhaEsyUGE3?=
 =?utf-8?B?QjcxWlFsZHRjTnR6a3R5TjFqUHkxUmdwMEJvSmtObjU4VFQ5czVVb2tIUEx4?=
 =?utf-8?B?RVVLdVpiZ2VkSGhrS2dxbDE2clFHOHhxQUQ0UCtRSXRSdjdkTS9NNC9RbzRS?=
 =?utf-8?B?a1J6bE5nOU1wNXk4d2lBUWFzWjhvVUJycTU0d0dZbE5iZFhCdy9WQklMalVP?=
 =?utf-8?B?K1ZVZ3d2ZDNpU0MrQ3ZITU8yZEpheS9oRE1Xck1LMExaanZyMld3UWpGbldC?=
 =?utf-8?B?SkpnRnl5RERBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlF3cktVTFRRQUlDOVcvN2N1bHZsTG1IKzUwUzRlY1QzSzRndEpCbERwQzFT?=
 =?utf-8?B?SElRc3ZCK3dTSTBrcTN5M04wQlpDL0M3ODdlcW5aRXpVRnYyTS9UelBDWHFh?=
 =?utf-8?B?RFc2RHhLd09pQTBPVVJpU2QwNWIxazIweGt5ODJwT3hJY0cvMUdQb0wwSGcr?=
 =?utf-8?B?dXAwRklmV2J5Q3pzOFhtSEdWLzNKWU9MdkYwSUdDTG9Na0MyVHkzU1FKYjRD?=
 =?utf-8?B?eWNrb25aQ0tpTjBlaUpUZGo5ZUdxRlJLcDJHSG02bXNqdmRMQ1VDM2VsT243?=
 =?utf-8?B?cHVWWFU5L1dBRlNwZml2UEpPMUY1U1hxSW5TeGlROVNLWVdSMzdkY3BvYzJT?=
 =?utf-8?B?bnpiZmJhSCtUK1pkcWlXb0RlN0RQLzlQd3RkT2N5MENIRlpJN21CSUJRa2hq?=
 =?utf-8?B?QWprYlBsN2VrZkVVN09CclBxZUdPUnhZTnVhK3R0cmc0KzMwVndzeitIQ1B0?=
 =?utf-8?B?MEx4eEdoU09EK3JaTTRmVmJGcFJxT1R4eW1iYUt1amVrRC9vQXU3SE40aWVZ?=
 =?utf-8?B?TVh0WW9lZlFrNUxyTVhrK3E2Q01nbFdXRWx5cjZXQVQwa3EzMEx1Q0JRL1NO?=
 =?utf-8?B?T0tFM0IzcERKdUdMd01Gb09Yb0szd0Q3TjhEWWZia3BGb0JwTVpGdCtXcXA3?=
 =?utf-8?B?UjF4eXY5Z3pmOWgvSEZPQUFOdEdZc05DR0NRSm9iWnVHekJwL2g0ek95YTF1?=
 =?utf-8?B?Vzd0M21xSG5iQlgyMVZPR0F2SGN1Mi95U0tmUSs0YTQzc0xIWTNhRzg3Vkc3?=
 =?utf-8?B?cUdFb05nRkNYdmxFbVhuMUZsVFZFb3ZsQVRKSWY5M1paUzFXTkJyRUxHV0Fm?=
 =?utf-8?B?RmVYRDZqckJJRGtSQm9LcHNxVnFxSmxIam9tNENPRTZ4cGVQRk9IMStuYlZy?=
 =?utf-8?B?a0FTTkJUbnBFMmJsc2dlNk4xclRTeWZwTlI4Q1dOaHJwZUh3UjM4WHpmU3Jp?=
 =?utf-8?B?aDdKVzZDdlhxYnJ6MXB4Ty9EWjJYbnpXKytpdlZDYlRmNCsvUVhqbWlaclBH?=
 =?utf-8?B?encrZ05yQ1N4Tk10cGVjbS9RalpzbW5ROU9aT05qdHJHMzFXY1FDVExmQk4x?=
 =?utf-8?B?VEVzaTF2Y3lxaTMwYnhEbElvekhSWGZzd2s2UFZqQzZzL1l5Witpb2FCZHVh?=
 =?utf-8?B?ZHJaZ0h6bkFJSHRGUHV5U0pydWFiQWkzd1ZqNTNNR0pGR1N1bUs3NWQrUThB?=
 =?utf-8?B?NGdxMlpKbkZaTDNEMVZFVjVGdnlIcWlHTmdYZmtSR29BTHRrRlpDZGRocEFO?=
 =?utf-8?B?c3ovYkwvZVk2V3VNUG1jUFkxWm82eHRTN2RPQnJ0VS9BcUFJRnZVVGY2YjZj?=
 =?utf-8?B?aVZ3UVVrMU9ON1Z4VkRBSG9KUEJseUhhVTJtWHlmdlNyMDJyTFFxVXdzMWpQ?=
 =?utf-8?B?RVpWUnNvTlVFU2JIV0tjUGJCOWpDQkt3R2RRTkN4bjd3SitxczF4U1ZGK0d3?=
 =?utf-8?B?Y3Q0cDFJMkk0SzlVZmxOMWdGRVNONEZscFk2d21jcUx4c2RtWTcraE9pb2x1?=
 =?utf-8?B?bUZ5QUJNRjY4K2dEQkFYK1BBR25wOXhnRUxjMVRHdktDLzB3TDNZZU1WV01L?=
 =?utf-8?B?dHVWUnBrNkZzRVF1dWhZamU0ZGhWYTYxWTRXQjV5UXBud3pPRVQ1TzVUYUdW?=
 =?utf-8?B?VjdLRy9GMUFlcnVEZzVkeGVxM3JnOE1FOC9PbHlOeU9YSWFFeFRIMUFNcFdL?=
 =?utf-8?B?UlQxY0ZVM0hVZG9sWEd0OFhVYjR3ZXBvc294c3pSRDhLYXpRc3R5MEhzbm9l?=
 =?utf-8?B?SHVXRzdiOE5hTmI1WlFqdGFkQndZNTkzTVB6MTFhN1dxSlFRc0pxZTJ6b1h0?=
 =?utf-8?B?Q0NrWk5ORncwM1l6M0U5RzkwZzZ0ekxlb1dDVFQ5VUxhTDVPWllQQ3R0K2Nn?=
 =?utf-8?B?MGtQUkdXY2kxb0wyYW1PRkV3V2x3WTdtdXQ3MmFvS0xtb3NlQXQ4UnFZQ2Rs?=
 =?utf-8?B?Y2VXci9qMVJmTUd4OXpLR0JFZmdHekFvUjlBS21hbk5WUnVJTFNnM2RpTUxw?=
 =?utf-8?B?QlA0QTFBZVhkZVMvaVJzMlZkL3hBSjZTNEJDRWt6SUt6TjFMOXAyMm1mRlRG?=
 =?utf-8?B?ZnFrRDNXWmxOdUI0UWxBTFVEbVRqeDhETzgrOWhBNXBGcXJETk5wd01md2x5?=
 =?utf-8?Q?WEMRRB27Fa5Wd02XkCIqEX9r7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc4d0ff-1fa0-4171-1a1c-08ddf4295bb6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:27:42.8442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jho18KzdHnGQpygTKu66Qf6U6QV/EPvxGx3TAPLSxlHtz0yWT0JWLF+UWIeW6c3UfxekLItndGaS7eWPICSoPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7529
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

To support passing specific commands defined in enum imx8image_cmd to
the imx8image_copy_image() function, this patch introduces a new entry
type nxp-imx9image. This entry generates a plain text data file
containing the relevant commands, enabling flexible configuration during
image creation.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst            | 12 +++++
 tools/binman/etype/nxp_imx9image.py | 89 +++++++++++++++++++++++++++++++++++++
 tools/binman/ftest.py               | 11 +++++
 tools/binman/test/350_nxp_imx95.dts | 25 +++++++++++
 4 files changed, 137 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 12a39d070e4..8922d6cd070 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1689,6 +1689,18 @@ together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
 
 
 
+.. _etype_nxp_imx9image:
+
+Entry: nxp_imx9image: data file generator and mkimage invocation
+-----------------------------------------------------------------------------
+
+This entry is used to generate a data file that is passed to mkimage with the -n
+option. Each line in this data file represents a command defined in the enum
+imx8image_cmd. The imx8image_copy_image() function parses all commands and
+constructs a .bin file accordingly.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_imx9image.py b/tools/binman/etype/nxp_imx9image.py
new file mode 100644
index 00000000000..e0e806f2b7f
--- /dev/null
+++ b/tools/binman/etype/nxp_imx9image.py
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+import os
+from binman.etype.mkimage import Entry_mkimage
+from dtoc import fdt_util
+from u_boot_pylib import tools
+
+class Entry_nxp_imx9image(Entry_mkimage):
+    """NXP i.MX9 .bin configuration file generator and mkimage invocation
+
+    Properties arguments:
+        - append: appends the specified blob file as-is
+        - boot-from: indicates the boot device to be used
+        - cntr-version: sets the image container format version
+        - container: indicates that it is a new container
+        - dummy-ddr: specifies the memory address for storing the DDR training
+                     data image
+        - dummy-v2x: specifies the memory address for storing V2X firmware
+        - hold: reserves a specified number of bytes after the previous image
+        - image: defines the option type, image filename, and the memory address
+                 where the image will be stored
+        - soc-type: specifies the target SoC for which the .bin file is generated
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+        self.config_filename = None
+
+    def ReadNode(self):
+        super().ReadNode()
+        cfg_path = fdt_util.GetString(self._node, 'cfg-path')
+        self.config_filename = tools.get_output_filename(cfg_path)
+        accepted_keys = [
+            'append', 'boot-from', 'cntr-version', 'container', 'dummy-ddr',
+            'dummy-v2x', 'hold', 'image', 'soc-type'
+        ]
+        external_files = ['oei-m33-tcm.bin', 'm33_image.bin', 'bl31.bin']
+
+        with open(self.config_filename, 'w', encoding='utf-8') as f:
+            for prop in self._node.props.values():
+                key = prop.name
+                value = prop.value
+
+                if not any(key.startswith(prefix) for prefix in accepted_keys):
+                    continue
+
+                formatted_key = key.replace('-', '_')
+
+                if key.startswith('image') and isinstance(value, list) and len(value) == 3:
+                    file = value[1]
+                    image_path = os.path.join(tools.get_output_dir(), value[1])
+                    value[1] = image_path
+                    combined = ' '.join(map(str, value))
+
+                    if file in external_files and not os.path.exists(value[1]):
+                        print(f"file '{image_path}' does not exist. flash.bin may be not-functional.")
+                    else:
+                        f.write(f'image {combined}\n')
+                elif isinstance(value, str):
+                    if key.startswith('append'):
+                        file_path = os.path.join(tools.get_output_dir(), value)
+                        if os.path.exists(file_path):
+                            f.write(f'append {file_path}\n')
+                        else:
+                            print(f"file '{file_path}' does not exist. flash.bin may be not-functional.")
+                    else:
+                        f.write(f'{formatted_key} {value}\n')
+                elif isinstance(value, bool):
+                    f.write(f'{formatted_key}\n')
+                elif isinstance(value, bytes):
+                    hex_value = hex(int.from_bytes(value, byteorder='big'))
+                    f.write(f'{formatted_key} {hex_value}\n')
+
+    def BuildSectionData(self, required):
+        data, input_fname, uniq = self.collect_contents_to_file(self._entries.values(), 'imx9image')
+
+        outfile = f'imx9image-out.{uniq}'
+        output_fname = tools.get_output_filename(outfile)
+
+        args = [
+            '-d', input_fname, '-n', self.config_filename, '-T', 'imx8image',
+            output_fname
+        ]
+
+        result = self.mkimage.run_cmd(*args)
+        if result is not None and os.path.exists(output_fname):
+            return tools.read_file(output_fname)
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a90db3c9351..925c39a530e 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7906,6 +7906,17 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                          len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
                          IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
 
+    def testNxpImx9Image(self):
+        """Test that binman can generate a .bin file"""
+        testdir = tempfile.mkdtemp(prefix='binman.')
+        image_path = os.path.join(testdir, 'image.bin')
+        with open(image_path, 'w') as f:
+            pass
+        container_path = os.path.join(testdir, 'mx95b0-ahab-container.img')
+        with open(container_path, 'w') as f:
+            f.write(bytes([0x87]).decode('latin1') * 32768)
+        self._DoTestFile('350_nxp_imx95.dts', output_dir=testdir)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/350_nxp_imx95.dts b/tools/binman/test/350_nxp_imx95.dts
new file mode 100644
index 00000000000..3fc2de44b4a
--- /dev/null
+++ b/tools/binman/test/350_nxp_imx95.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		u-boot {
+			type = "nxp-imx9image";
+			cfg-path = "u-boot-container.cfgout";
+			args;
+
+			cntr-version = <2>;
+			boot-from = "sd";
+			soc-type = "IMX9";
+			append0 = "mx95b0-ahab-container.img";
+			append1 = "container.img";
+			container;
+			image0 = "a55", "bl31.bin", "0x8a200000";
+			image1 = "a55", "image.bin", "0x90200000";
+		};
+	};
+};

-- 
2.43.0

