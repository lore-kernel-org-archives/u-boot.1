Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0315C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 12:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 297CB83496;
	Wed,  6 Aug 2025 14:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VkkQD+0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10A1B832AD; Wed,  6 Aug 2025 14:40:50 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC72683496
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 14:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8gXUsLA4MFT0OtOnx7qRMCn0bjnOaqjJCx9GNJrDs7sZuk06zYHsTfTr12+z8WSx23SgNDjvaXICW95qeCaFBduTHAKB+0kx/R/nMM4TKK8uT4wCXIHZ9I0N8SesHtJHrmLNOrrJMSc0bL+ES8gUqhXucscGL+OPDJJiTwg40U46s+edXE/JzhESJxzJzZFMtiAmToK1672CTt6Gp4Sdo8zKODpq/zgwDUU03ej8Z5I4lYTHO3ewAHiF8o2D3V6XXHbkqvKD1GpFw3srvKbUBDtGqSoQyRXR07ZDicAWicoWg7zzGWJ1OHqo+pRqC8KI0NBcpp2ZznVlvwNDkBkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNhDLgEOQGqx+lsvxLbygc5MoXK/0SznCx1QdDFV4es=;
 b=V60yX/VhN8uxqRVeIsQqoVrCdTVwDFRHLSv1syTmBu8EPkNPB5EkfP0mTK/jLD6YKq3ktWInUlQ+PgPLl5IaHzvgoiTYik/jhgdH0uWULdNZS51nUVv6q0IC2VeulKbsAC7/YvHb6nsaF2pdAI61/tGPtRMtbYtZJk6GY1e2qk5qqfnkVtxjSHR9CeM8CdZiIFyAZEnZua3o1tA2oMCo2+WBN0vVHbrcNTq2kCKmrSc3v8PGPTuh0+H6nFDm3ophfBYTMJsaXStQpDRvbKgpeIXybMc1vrpp0Uf2Kjb9I6hkXAbUx53x48H8Nyn6+B8j0vxj50t++2B0iH8SvOiwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNhDLgEOQGqx+lsvxLbygc5MoXK/0SznCx1QdDFV4es=;
 b=VkkQD+0wDVf9/eJELBU+1IiAdtEUFMKktoqNQTwswC3UT5bQHOZH3ShYF8FOJh1bFpLbUPJXfV8XGvYMMZF7PHZjGNqcj1MwArsCoCbhIOpyTmYw7BHKkQGK8g3WM+arIrDqiQY/zEcwroCWLTwCrGpvr6JX2B+FtUHlxd1ynExg8MmzI2CIli36+sXKZAF49tRp+ARbZiNmrOWMTfPhEuWIwBUa6rkv/f6b5hvSrh/aOsyQ0q1E9UL9F1NNYM60TogJCcoAnbSHzC6Hc1dmVSCKYf+x07kisNLK0h/+ya9/mnSvyHMv2atArUgrjZrw1DQgoclDcDAXidXg+sqOxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by OSKPR04MB11391.eurprd04.prod.outlook.com (2603:10a6:e10:99::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 12:40:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8989.020; Wed, 6 Aug 2025
 12:40:45 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Jul 2025 07:35:00 +0800
Subject: [PATCH v2 1/2] binman: add a new entry type for generating a data
 file which is passed to mkimage with -n
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-imx95b0-v1-1-5cdae3764d21@oss.nxp.com>
References: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
In-Reply-To: <20250728-imx95b0-v1-0-5cdae3764d21@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|OSKPR04MB11391:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bab434-a69a-48e2-178b-08ddd4e67666
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGlZSTlQWGdQM3hrM1ZmM1JOaHB3NnY0VDlSUjJPZ1JRcndYZkE3RlMvenBx?=
 =?utf-8?B?RU1CUklRWDVZY0xLcmFnRVg3T3ZIbE1Zd2hjb245cnZzc1J6MzVseGg4UW9w?=
 =?utf-8?B?MjFTZW5seHh2U09IdGU1MkRoaWxVdzFoc0NVeGtoaDZhSlVvY1ltNFdyc2t4?=
 =?utf-8?B?Z2hacnV4SXpjTFdUaUU0U1FhK2xZRnBGeG5xUG1wQVNRNUJtTDVnNHFBa3Fw?=
 =?utf-8?B?YVppd290aDVzS0Vqd0FiakorbUJSOHRtKzBMLzlwYlV4SW1CM2VOekNZR1Y3?=
 =?utf-8?B?MEpPR21LRnJBT2d3eDhzSWZFMUtSc1dxa1pXdFNvb1R5Qmd5YmlLT2MyWFNz?=
 =?utf-8?B?clc3NnlzYytlejdYQ3Z1NzlQZXFxVCtERzJFZlBaWDFZcHRmc0VtQy9DbXNN?=
 =?utf-8?B?SVQ2ckIzNTV5RzZzS0FySXcyaHRqK1BQVThwMmtxZytmREhKNjNoRnRTbzA4?=
 =?utf-8?B?VnVtQnR1ZkZnbjIzN0szMHJQSWRJRVdUSWhodnc3K3dOeVRYSnArUXFPdnNj?=
 =?utf-8?B?NGJQQXp6bkxKM0FuTXlJQys4Q3lDWlVJYnVBSWlRZ05BMU52QnZ6YUZoNG9S?=
 =?utf-8?B?a2VIckdVdFZTVGlHQXNKcXNxQ3pRQ3BEbTlyRkNReVN1enRPM09iOHN4dHA4?=
 =?utf-8?B?dUVPbEU0eVdYeWlYc2ZPRWhiUVNOZzdFTnRJZmZvekx5K2d1dzMxRG9qSm81?=
 =?utf-8?B?QWFyMDF2U3dlRDdTTXUycldhNy9nbzdWUGJxamtrQ1NwQ0lzd0RMeVdVMUFs?=
 =?utf-8?B?RmRJRDhYOFdtVTlvSk9KRnVkbUxKR29RQlFCWmlMT2J1SUlaVVJ1T3FySHhm?=
 =?utf-8?B?OVhFV1FRU2kyTGtMSjA5SjR6QTVxQmlZVzNJZXpQMmY4RGhhbkZmS2NETmRH?=
 =?utf-8?B?VjJaY2tMRzBEMGkrWHpvZXlrY2pVcXBDcFVpOS9TZFlBYVBvZlZTdUhxcnhG?=
 =?utf-8?B?ZDlrYkYwanZYZHZhOXFzU2UzL0Q1aDNGQTJPK3NualhzMWRRUnBLQnBoRzl4?=
 =?utf-8?B?cTdYUk9VbDQ0VTVsdWNNQ2Q5OXVaMmoyNkYvK0dPczVsdzJDWjJYMFUzamU3?=
 =?utf-8?B?WjN0bFhnam9FbzdrRjg4eitnK2MwUHNzVXJoUW5Qd1cvclNpb0paZEYrbDRl?=
 =?utf-8?B?QUR1L0xnOG5UM0dMQWxqQ004YWx1bkhsc2creGlhaGpuTVdrSVIrSWdRZlB0?=
 =?utf-8?B?T1ExeWt4Y0NFWEd2RjJWMGgraTdYTzhlWkM3TVdpOWxmb2FUZDkybFJlVWdq?=
 =?utf-8?B?VUROVys5emNVeFRSdWpmRThXSUdrVGZIckFkVWFRSk1YdFNnNUJMYlRUZ3ky?=
 =?utf-8?B?bnBWY3cyZTNucStLQWJ3Rmc0a052ZUpzWVJvTmg0SXZFRVhrczZsTm9DaWww?=
 =?utf-8?B?ZEp6VDhXTVk3SU5iSmdqS2dIVXdkRXJic3pORW4xdXRwWnJKTkdReTV3VXdB?=
 =?utf-8?B?Y1BEejBtLzJwS2phZ3ZJcVlIa3k0cElZaHFEekdCS1dpdU1rdWdycXBMWFZz?=
 =?utf-8?B?QUEycy9oQzlnQldYRlFVelZjQkVZZy92Zk1FVnVKQXBNcjBVZmViMy9lRkJC?=
 =?utf-8?B?SFZSMjFicXJvcHNQUFFmNUU0MDU4SG5iOUovcHc2R3dnRVVabE9yVnZncGVi?=
 =?utf-8?B?MHNPbjgzNXBiNDhNeWh1cHNLc0EveTZ2c3FqckF1bGRib3o0YkJ6UnVvblZa?=
 =?utf-8?B?RnVMclAxa0JVZkxDZUcrdnNsZ3NaY0lodUhZdnNkdUZkNFluRmRQbzFLVzFn?=
 =?utf-8?B?QlE1MEh3QnR6S3dTU29SU0VzUFR1a3BuSGZJWGZ2eTdMbkJKSE5yUTZRYzky?=
 =?utf-8?B?c1gvUHJoU2JnYlQxT01pR2hnRmQ3dzFCemFVby8xZmIxMFZ4QWsvb3R1UWNu?=
 =?utf-8?B?UnBJcjgzNkdVUEpycVhkSmpTSTBoL0VxMUd4eWhNNUtwNE54bU1QM2syZXJV?=
 =?utf-8?B?MHAydmlLaFRXeVgrTzRsWUc4V0pwRkR3cEZ4UngzSHJ6VFdRMDR3enRsQmVz?=
 =?utf-8?B?RXhMbmNKRGt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1VaejhoeWVDKzZhalJoeHp6QkdKSkU1b0ErSUk4OG9ib1VnZWJQRXR4a1p0?=
 =?utf-8?B?R1RadE82OGovb25NQ0ZJRTlpVnZOenhmUEJzNEd0dXU1ZjZRbWZIZHlLWUFk?=
 =?utf-8?B?UHRoN09EK3NFdmFpcUFQQ0laaXlhOWRlcDBCUmdEUlZIVkZtTDE2T25GUmtq?=
 =?utf-8?B?d082UFVBRERyVHF0Z3htM3hwbU1mYzJsSkJHZDI1TTU5RnBBakUyYVN3NHNV?=
 =?utf-8?B?aEIxZnpVbzlBVUQ0ZTVWRGVJd3NaelF4S3Zram9neFZzSkhvZnVFUXRLbFNr?=
 =?utf-8?B?NThWVDh2dHhwYTduNEZudW5VWDYxc2MxdnVaT25sMXNBL0lzYTZ4ekRQWWRG?=
 =?utf-8?B?MUxuN2RRUkFsalN3dkVseEFhNEhYR05jZThwRmg3Tm45b0hraDQ4N3RVQXFQ?=
 =?utf-8?B?Z05zUFJ0djR1WmJjU01lR1RKZHVSS1g2Tml4S1ZIaTdmQU8rS2JvbVBEMm5a?=
 =?utf-8?B?b1VVekowTVRnYkc2RlgxeGVDcFdxZWRQZk5VVmY4WWFrR1NyY0xEeWxnRkFj?=
 =?utf-8?B?S2xHazBTeko4ZDFlMHluQ00zTnhuTjBGekhCTUpsK2JXcU9MZGJKSmJqNGdU?=
 =?utf-8?B?a1ZVQjEvclZvOXBJRjE5Umx2RGkvR3N1bGdOZ2lTcU5xdkoyMVRLak5HZVFh?=
 =?utf-8?B?akp4RFFjWVVkM2JlUGZaSTY2M2crYkVYR0NNY0R6cUI3NGFyYWV6eXh1UlVD?=
 =?utf-8?B?SytSaGVTMVFRZXhJNHQ1SjR5ZkNrUXdldCsvV0xwdEEybW9iQ2RtbGJ6Y0s2?=
 =?utf-8?B?ZGFYSUtTRmZhcXBmdHF6emxZQnh1WGN1SzVDTG53VkNBOGc4eWdtR1M2Lzdn?=
 =?utf-8?B?R0dlWi9MMWlvRFBNU2Q3SEhHQWVyT3p2OWgwY0JWYS9FVkJOcHVuUmY3dGVE?=
 =?utf-8?B?NURwY1krMnQwTlVHMEdRdCsyYXkyVWhrWko5aW9VaG0xSHhENFY4YUxCNGY3?=
 =?utf-8?B?Y2hOVFVUSXBOTEdHWWlhZDZpVUZ4YjVKalpHNXd3dEQ1QzZWb2xZQmJqeEtv?=
 =?utf-8?B?S0R3bFpCRWdkcTZqSFNNL0ptY0diR3VEMlFObS9Ed2Z3ZzY0TnJIWGV2THVq?=
 =?utf-8?B?YTBJcGNHQk5zeUlIK28rMy9tZW80bmdqeGYvR09KTnNEeHY4S1ZJNjJ3Tkw5?=
 =?utf-8?B?eUsrK2dYeVVvYUFLdmJIUGdiY0lNQTVTdk55bExEMzBPSkl2WklqKzVyejlu?=
 =?utf-8?B?NzAwblBYLzBxYVVjRGRtMlN0ZHpRSDhNTytoOVdMakk0VVQ5MWRYOHV5VE1B?=
 =?utf-8?B?U1krY1RTcktCK2ZJM0ZUZFBURU5GMVFNeHVnTG8wTW9VekF4NDFzTUdFakU5?=
 =?utf-8?B?UjQzVU9ZZitKM1kxaHB6ZFR0NVpUaHVmc3NVTnZFNkFPQ2lFKytvMGFJSTFJ?=
 =?utf-8?B?NlVNbjdlcHBtaldHZzZ5WEd0Zm9hQ3RNcWtJeWtFOFF5dmkxY2Z3aHROZytT?=
 =?utf-8?B?aUw2Nmt5UElucGNrdHFvM2RXWDdrWUppUzZMZWtJRVBtRUN5OXQ4b0xTK0ZF?=
 =?utf-8?B?TFR6K1FjT2ZIM09ObVYreWJuSVhrczRmcFFHSzZOY1lYWkhJNTlMSkhLSEEx?=
 =?utf-8?B?ZDY5ZTlHbEQ5d0tHSDFmSnJ5ajlDQXBXSmtUVG4rcVJkSGI0Y1h0VlFib3VN?=
 =?utf-8?B?M095bDkxM0Urakd0RmtVN2tBOU9HS1dPaE9oWkxnWUh6M3A0MnhlSnZ2U3BZ?=
 =?utf-8?B?QUcwM3hCLzZtMDRBM0pnVWUra3dKMUFhU1ZOTWE3cEdRQTNxTyt5bi9SQkJl?=
 =?utf-8?B?bjhuUzZ6cDNmUkxTRHJlamtTTldBTkZGcHFkbmcydnp0ZDROM05mMlE0WXd6?=
 =?utf-8?B?aXp3Y2ZaWTAvY0o2QXo3T3pRaTJEUmlMYkhyeHJHVE5hUkN0OHJFRyszVkhF?=
 =?utf-8?B?eHFLcUxYc3RlSmZwYTh6T2pJcE1sajdPV1pIQkpvWndjU1M2ai9OOE1yYUVV?=
 =?utf-8?B?ZkxEaENaQWNhVEwwRnBCTkZTSy8xd2YwQSs5T2luS25JaGtVd3hZQWlFZmZK?=
 =?utf-8?B?eExzZ2FuaFVGZlFpNTc5SDN4N1hxRnRLQ0djVmhzblVNQVpFT090dFBrT3FX?=
 =?utf-8?B?bDAvdndIaTlkUE9XQUo3Um5vVWNzZllnMDdNWHVTcDR1QVJOV21xMkNOblph?=
 =?utf-8?Q?TQF+OPiN9GnFfVJQPYE/wRwRg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bab434-a69a-48e2-178b-08ddd4e67666
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 12:40:45.2008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wk9hsYIWIQPwkIL5CSrJPdZYjcKAIeGOnEHVaDJUkPlmUNERsjOwTU4p7AHB1rrRaXrU0rU7Gla8il8wRbcHLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11391
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

i.MX95 needs to pass some commands defined in enum imx8image_cmd to
imx8image_copy_image() function, so add a new entry type nxp-config to
generate a data file includes theses commands in plain text format.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst                   | 11 +++++++++
 tools/binman/etype/nxp_config.py           | 21 +++++++++++++++++
 tools/binman/ftest.py                      |  4 ++++
 tools/binman/test/350_nxp_config_imx95.dts | 37 ++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 12a39d070e4..85e041f34ac 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1689,6 +1689,17 @@ together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
 
 
 
+.. _etype_nxp_config:
+
+Entry: nxp-config: generate a data file which is passed to mkimage with -n
+--------------------------------------------------------------------------
+
+This entry is used to generate a data file. Each line of this data file is a
+command defined in enum imx8image_cmd. imx8image_copy_image() function parses
+all commands and builds a .bin based on them.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_config.py b/tools/binman/etype/nxp_config.py
new file mode 100644
index 00000000000..1ac071cbadd
--- /dev/null
+++ b/tools/binman/etype/nxp_config.py
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+from binman.etype.section import Entry_section
+from dtoc import fdt_util
+
+class Entry_nxp_config(Entry_section):
+    """Generate a data file which is passed to mkimage with -n"""
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def ReadNode(self):
+        super().ReadNode()
+        path = fdt_util.GetString(self._node, 'cfg-path')
+        content = fdt_util.GetStringList(self._node, 'cfg-content')
+
+        with open(path, 'w', encoding='utf-8') as f:
+            for l in content:
+                f.write(l + '\n')
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a90db3c9351..6b04ea11621 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -7906,6 +7906,10 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                          len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
                          IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
 
+    def testNxpConfig(self):
+        """Test binman can generate a file in plain text format"""
+        self._DoTestFile('350_nxp_config_imx95.dts')
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/350_nxp_config_imx95.dts b/tools/binman/test/350_nxp_config_imx95.dts
new file mode 100644
index 00000000000..d4f62b2b3bb
--- /dev/null
+++ b/tools/binman/test/350_nxp_config_imx95.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		imximage-cfg {
+			type = "nxp-config";
+			cfg-path = "spl/u-boot-spl.cfgout";
+			cfg-content = "CNTR_VERSION 2",
+				      "BOOT_FROM SD",
+				      "SOC_TYPE IMX9",
+				      "APPEND mx95b0-ahab-container.img",
+				      "CONTAINER",
+				      "DUMMY_DDR",
+				      "IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000",
+				      "HOLD 0x10000",
+				      "IMAGE M33 m33_image.bin 0x1ffc0000",
+				      "IMAGE A55 spl/u-boot-spl.bin 0x20480000",
+				      "DUMMY_V2X 0x8b000000";
+			};
+
+		container-cfg {
+			type = "nxp-config";
+			cfg-path = "u-boot-container.cfgout";
+			cfg-content = "CNTR_VERSION 2",
+				      "BOOT_FROM SD",
+				      "SOC_TYPE IMX9",
+				      "CONTAINER",
+				      "IMAGE A55 bl31.bin 0x8a200000",
+				      "IMAGE A55 u-boot.bin 0x90200000";
+		};
+	};
+};

-- 
2.43.0

