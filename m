Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DACC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CB3E82893;
	Mon, 28 Apr 2025 12:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="E5K0wgAr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9853C8272A; Mon, 28 Apr 2025 12:39:03 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C86482145
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oq1Qbp9i8S5bJBwrquqCeRFOzKcuwGebbCEawf9DyAzhunBvTdrpLHSjjqoj50w/KlBCn5R9usX9l7k2C5pDkUKUbzXhlk+/jGjz7Py9m1/YojXYlP+PXcTMXJGVZHxBlUQZGkpmLcS28RrgVlH7VWiNlSL4LtIc5XiWaFqt6598BC2FZWSxfZn9kn9UkwXAONOnATWsyGAKpFN7SQ+3gBUvc1ADdqEX3nh3Zu/WoLd1qXKYK3N/oUPz7n6qG8LEnywHbKedew6bp+Gib9NyOdazLBv7TpIfV7Y9H4iLXLChLqpvF+dPStmm9Z53QnQDMJpSyTcyozOYTH/bQ0WvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mChwcJJmHO8UxlNGhBS3lC4oKIm+rTjnLJvGTdnXyjw=;
 b=v8md6zoCACrhqaUV+BDgssvt9hZGXk3OvmF6PdduBcwgBWE3gkg42x4loawfXAQ4trs/Xs0AWOzKwSPSvX/WhLYvq6bmydRLBbIYvo+VHP75fc3Rw5rNz2NTZHVgfQTDX3shKLWq5OwNdbNU/n4Cj7zvBNnDsNrPYXqjTmeYySeaz3sI9TdjB8Hv///oqdPuSHRNL5wi/0gArEy0J/AwRYRKi3ejw6GHfAhvpRmjTJVX8VSD+8kiifhfuwb+SLghsuP93h6xX8TEzEaInNmS129md/NUdA1BidNwUbmzq4GoGmzVeBe4hyuGn38Z9ZIIFpLzaAau1UgYXramq1mD2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mChwcJJmHO8UxlNGhBS3lC4oKIm+rTjnLJvGTdnXyjw=;
 b=E5K0wgArQHjlhuSqsTjkzz7O2o/lOmDuR41QO5NJMKtt7SSlAjBeXlFGHLP7zOdwv7/2fCEZHkSDORUeCw6lN+R0UBhrJU28T401G6ianqc6QKoK3oqIfPgNfgdV1QKapLYDZ5D4EYWAdyh/8hhnnfYQmpYcbRz414JIcnsorUd0odvq7nMbwl/xpE3dsuLZUW2mfR3AfhHh05azwAWUb9xsImKzfVSYd7gR4lCxAtUTBzrhH5YQlpnq/rT0io3XCAcPHrijgTwJFYqwkyKv3SVH/juQDoo3SLWvrZ6x8hP1MUByUk3nyxdb+3dB3fKMIgsXd83L0+sqnSRLrZ0KNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 10:38:56 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:38:56 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:31 +0800
Subject: [PATCH v11 08/21] clk: scmi: check the clock state/parent/rate
 control permissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-8-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3a2b5b-ec82-457c-ecd8-08dd8640e0f0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGhGMDZ1enE1WkV1aTZJY09hZ2s0MmxQdEdKM0Q5cW9BTUxMYnNqWTlCU1VB?=
 =?utf-8?B?a0dOUlI3ak90Q3d0bmZ6KzVHZk9uQUVCTzZYWHNGRERwcXJncmJPcmVuRFp6?=
 =?utf-8?B?VmJXWHhaSlRHMzY4eTdubGJXZHVWVG1mdTJGNTdnZGdUT29ONmFxYnhOMFha?=
 =?utf-8?B?aGlHMWJiSUFQS2pUQVN5am1YcU95R2tJSXRQOVhybVh4d2RnNTJ5OTJzNUhw?=
 =?utf-8?B?RzBtbmFjTUxUYmJ1QXp1R015WklGTGloSDdmVFI2VFc4aUdRNTJCZVBtRVBy?=
 =?utf-8?B?SFdVenJjRGZpdnVMcU1ENGhHYWNibk9rVWtyRFVSQWh1MVlwTm0wVnpPVEYz?=
 =?utf-8?B?QWZhRGtjVHZTY0ZqWXdia3BUdVJGSEhnbzlWWGZaL005aDk0UlRHYUZ5eXEv?=
 =?utf-8?B?UEdSUTFLNVJnMVpDdjI3eVpwY0xJeGIyYThZbVcrZTZ3RFhqNCtmSnQxVVVG?=
 =?utf-8?B?VzM5VVZsZmNBQnlSWlkvdVVBU21ObzQxWHoyWnUrcDFZVnVIbXpkalg2YjEr?=
 =?utf-8?B?aVBmT0t0NTNXRWVZelpiUXpSYkU2bWFrZmw5WFRYMFBGaGhHdUtyNSsyMlFJ?=
 =?utf-8?B?eTFvRHhOL251N2VRR2pjSVhkMFZHUmI0SGpKc1JROU9MaVpoRHZZYmZKQ0NU?=
 =?utf-8?B?SFZPcTdLcmlrbEx5Z01EQ3VCSVpGaFdxN0c2MFYxdTF0ZUd2KzlhKzk5K3N4?=
 =?utf-8?B?Ni9nTFZzRlpYSHF2Q1dTU3Z5UnJ0SEtvYjZjQ3RzVmYwUC9lTTk4U205bFdH?=
 =?utf-8?B?NHhPYXlJRVk5a0dDOHJqQ3M5L29HQzVaRmdxZVc5T2drVW9MM3VTcVV3bW05?=
 =?utf-8?B?Nzlpdk50NWx1LzdwZkZZdUxYM29iaVYwTjJjZlVncllnRzRJT3NNR0Y0MmJK?=
 =?utf-8?B?STh2NlRpSnpnRlk3TWJhV1ZBTndpWVNNakRXbGg5MVpvMHlKeTJqb0kyNlNp?=
 =?utf-8?B?T2czRy9zYmNUWFdCSjR1cVBYaFR6OWt1dWpvQlVIV2F1TVVXeXJEalJydXEx?=
 =?utf-8?B?RmwxVzlSY0w5bmViOXdFMGxuYksxeGhSTVpFSllJSkVYUHZtL3l4eEt6TWpD?=
 =?utf-8?B?UkgrdmhmSUZhM3c2UzVRelBxN1dLR0NmUVJVVTZnb1VyRkR0YVRHUTFndjMy?=
 =?utf-8?B?cGZoT0E2ZkxyclpiUXpBcWZyU0ZIaHp0L044ZFJETFJEVUhnVDRieHl0L3I5?=
 =?utf-8?B?UXRhU2FGV2swYUMwWU84R1VLQTBTWG42OEs5KzQzRDRmQm0zZTZkYXI1K21n?=
 =?utf-8?B?OU4rTHhZWjd2Y3dnbHM5NkF3OXpWNWcrR01iWGFLWENOeWdJdUpPQzZ2ZzRL?=
 =?utf-8?B?d1BMTklNNXdlOWhHc0lSbituVVlEZ2kxS3JTKzY2enNaN3h0c1BFMlJCT2dD?=
 =?utf-8?B?TFc5S2RkeFF1V3lwN0FZeU5wS0xEZG9PR2QxRTlhSWorRDAyd2F0TmhqZ0Q4?=
 =?utf-8?B?eitUZVp2d1RxVzdIelZ1dlQxZFFnU3dPRC82UzZXN29CT0hHTDF1UzZ4Unhs?=
 =?utf-8?B?N3FRTWV2SWpOSHROVUIwVFBpQk9TYVUvbWRMNWZNQko2S2dRUzVvNVBhUHV2?=
 =?utf-8?B?aWV0cmdkTlVTMXhWbWFoUEhVOCtMT096aWg0cWpVdFdhVmhuOFBLMC8xdFZP?=
 =?utf-8?B?TWZibXprNEhYbmsvSXR0amVhdjd5TUlOeFEvMkZZL3EvQVhXZlZDMWM5V2Nw?=
 =?utf-8?B?NUgyWGNWekNLa3pwcmhsa0llRDBwemFzV1pyNDJXZFZFeGF1T2hSK0RuclNL?=
 =?utf-8?B?cFhrVEpUWi9McEowMkpvYzRTZnMxbFNDVEJMQi93eUEvc3Y4TWZJRHFKankr?=
 =?utf-8?B?TTF3U1IyZU5pQnNhU2lzN3Jsb2tDVzZwL1hnOWhsUzBNd1V1SU1Cbk85amRi?=
 =?utf-8?B?K0lNVnpCUVdhbjI1Z0prSEJsTXpRNzdHcE0yMG5HUUNVU0RLNlVpVW43bVFy?=
 =?utf-8?B?MHZQcFIzRFJoVUJVeTNQWFIwdWhmZ3BtanRJSHovTWJNS2pvOVBkalAvUkVj?=
 =?utf-8?B?a2tWL0tXd1F3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUs5bDBMVkFZWHNsRUlNVlFlY3RwTFhubDhmekVvOUZQZE84c3RQa3g0WkN6?=
 =?utf-8?B?dUJUMU5hUUNmemhqb0UrTE9MV1pXSExLOGdJRjBYNGdOcDRJa05jc0RHUHRN?=
 =?utf-8?B?Njk3cS91T1RMWlM1NThoK0NLUWlhVXc1bmc0S3pwQURLaWRBbnh5NlJWWTBB?=
 =?utf-8?B?M3J4L3dkc2FuOXVha0NvMTR0elR3T09lNDhnMWpuc1pxbU4wZmluZFZIRExI?=
 =?utf-8?B?YVQ1dEEzY1M5dHc5TXpweVpOK2Q0M2Rna3pPQzdHMmJnUWhDUWpSRldLdTVa?=
 =?utf-8?B?b204NHFkT1hXdnp4T1haN3BDbHc2WlVERmd2enpoNTg1UWFNVGlzTUdGNzdl?=
 =?utf-8?B?Z1d1c3lRbUJ1WnNlRiszcVNHSWxacDRvUHBHcGlnV2ZucHhsVUVwVys1SSty?=
 =?utf-8?B?aSs1djBKR2tFNWlPN2QydDJBTnVaZE9nYTFVVUxSQ0pOSThNdDIwaWxGS09h?=
 =?utf-8?B?R3hhNjJqTFhrTkNGb0dWUEV6Yzl2TUZmWFlSRDRBM3RNSEFwVHhrWnhPSTBN?=
 =?utf-8?B?V0lGa0pBdHJMZ0pHU01xdXRUc3ZLSW15Slg2b05nYkh4VjJnOXByK0N0WEc2?=
 =?utf-8?B?WWVUbExNbnVrRThkSHJCbEc5NmtiUFlKcUFYMDFrZ2QzM1JtYkpDQVQ0dnlr?=
 =?utf-8?B?M0FVRngxcWpxOHo5WGhaUlIrcWczSEhZVTZQaTNOMUQ1UUZOSWF0blVtc05S?=
 =?utf-8?B?Z0RYWTgydnRuMklkdWNnazdYanpLYmlZamJNdk5kQ1ZibHdLaDluS3A2ZFVy?=
 =?utf-8?B?cDVXVytXMXRqM3kwZTBZZWY3Q3JOUFpkT1ovbWFnK05wa0twdkxVM0xnMTlL?=
 =?utf-8?B?aUNvYkt6RjUwMStIUFRHOVlQekE4c0FMRHZJNFFEUHIxOFRzWlJJck05SURm?=
 =?utf-8?B?R1pGYW9UZVdaY21PaEhPeDJPaGkrZHZoODJKbEwvckN1S2Rua1l3endBQ3dL?=
 =?utf-8?B?QzVxa0kzeEdqV2dFZThONEtUdkRiN0Y2c3ZkY2M5alAxQkVqYkRGbDJXVDFW?=
 =?utf-8?B?VzNhMjU1UFJzTGJaSEJaSGtkRFl5eW5JNnRXSHdpY3RyYnBuSnZLTUxOSWZQ?=
 =?utf-8?B?SCtSZnZ5S09pS2tDWEhyYmMvVlFSMS9PMCt0Y21wd3BKalgxT1U1UFBMcUxP?=
 =?utf-8?B?QXJ2bjVGWkFSWi80eE5LV3Z4aTdsSkQ3Q1o3U2xXRzRuSjBQNE5UZkNkQyt5?=
 =?utf-8?B?cEdJWk1VR3RvTzZGbk9nSWgxMEZ6d3R0WVcvSUs5MkRwNXc4NDRZV0JqMGxE?=
 =?utf-8?B?bThWQlF6RDgwTFdJL3pZME05cm5wZ3prUm12aHhLV2JacUJFbE8xOW13MDFl?=
 =?utf-8?B?bksyajJDRUlCZEVzcE1HcXdzR29jZWZqZjZxTEcvRnFEc1RTc25ZWGlYVVZ5?=
 =?utf-8?B?YzgvTXN3b1R2OUZRbUtmYS9BVlRlSE1nVy9hRUNONDJCZnFxVnF1ZENrRStU?=
 =?utf-8?B?TUZmY1RwdXdycFd3ckdteE5CSWdpaGhGd2ZOQ1NnZTIvTUJXcXorVlU5a09l?=
 =?utf-8?B?RW9BYXNUalBvWUY3cFZYR1lYWGJWMmJxM0xjOXJhK3lGWDRDenRLYW1PdE5O?=
 =?utf-8?B?LzREeVl0OS8weUZ4THMrY2xRdmEvWExFUnhubkFoQ2QveC9TVWJKWGVtZVJY?=
 =?utf-8?B?UHZmRHhnQjhFN1ZoSk1WbWhqNTNOK3lTNGI4Ym16bEZuRUgxMnZ0WTB1VUVW?=
 =?utf-8?B?dnlzSWNXd3NCM2ZnYjg5S0lrTWI4cmxXZ2V0bURzanZTb056MGZndENES0hu?=
 =?utf-8?B?SVBhNlJXdkZTdUNSeGt3NlpmM0taQmNVSGMxNkczWFBEdERmU2NsWGhGT1B2?=
 =?utf-8?B?RGl4SnpXRXY5OFoyZ1JjSFp1T2dzc05JSzRnTzA0VWhvbUhRV25yKzNVdll1?=
 =?utf-8?B?ZmxrakhXb0c2cG5lcXQwanRwSEIvSW00ejNVdHVaR3lwUVFIREZ2TTE4eEhE?=
 =?utf-8?B?NXlXQWt6S3diVHNtKzFYL0MxendsQXZ6K3FabHZJNVM3VUY3WktyUStLMGcr?=
 =?utf-8?B?TTl2VkF4bGVqdC9Eb010TFROTzdqa0Y1OVpaMlZUdUZvQjJibkZaUDV5c0ND?=
 =?utf-8?B?aEZseWRPMG5lQk5ITDRJZG8vOUZnUmt3aFRidUtON25uUnZ2bnp4aDI5Zk5T?=
 =?utf-8?Q?T7eeCHdrVee42Vhysjfe15hz9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3a2b5b-ec82-457c-ecd8-08dd8640e0f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:38:56.8385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92ojqIfBmRVzsB08RiiM+vXegrQnQFfFEvPnnRK4acI2t6fNwuaQXvrbzx9ttZawVF832i1+sJdEv4FonYP39w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
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

Clock driver based on SCMI clock management protocol in Linux checks
clock state, parent and rate control permissions. To be consistent with
the kernel driver, add this check here. CLOCK_GET_PERMISSIONS is from
ARM System Control and Management Interface Platform Design Document 3.2.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c   | 178 +++++++++++++++++++++++++++++++++++++++++++----
 include/scmi_protocols.h |  24 +++++++
 2 files changed, 190 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index af5e8679003..af69850cdd8 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -13,6 +13,54 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+struct scmi_clock_priv {
+	u32 version;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	struct scmi_clock_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	struct scmi_clk_get_permissions_in in = {
+		.clock_id = clkid,
+	};
+	struct scmi_clk_get_permissions_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+		.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+
+	if (priv->version < CLOCK_PROTOCOL_VERSION_3_0) {
+		log_debug("%s: SCMI clock management protocol version is less than 3.0.\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol permissions failed\n", __func__);
+		return ret;
+	}
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0) {
+		log_debug("%s: the status code of getting permissions: %d\n", __func__, ret);
+		return ret;
+	}
+
+	*perm = out.permissions;
+	return 0;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -33,7 +81,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -54,6 +103,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -79,12 +129,48 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 1);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 1);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 1);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be enabled by the agent.\n", __func__);
+	return 0;
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
-	return scmi_clk_gate(clk, 0);
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return scmi_clk_gate(clk, 0);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+		return scmi_clk_gate(clk, 0);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock cannot be disabled by the agent.\n", __func__);
+	return 0;
 }
 
 static ulong scmi_clk_get_rate(struct clk *clk)
@@ -109,7 +195,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -134,9 +220,33 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return __scmi_clk_set_rate(clk, rate);
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+		return __scmi_clk_set_rate(clk, rate);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock rate cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
+	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	size_t num_clocks, i;
 	int ret;
 
@@ -155,31 +265,51 @@ static int scmi_clk_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &priv->version);
+	if (ret) {
+		log_debug("%s: get SCMI clock management protocol version failed\n", __func__);
+		return ret;
+	}
+
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -198,6 +328,29 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return -ENOTSUPP;
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+		return __scmi_clk_set_parent(clk, parent);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	log_debug("%s: SCMI CLOCK: the clock's parent cannot be changed by the agent.\n", __func__);
+	return 0;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
@@ -211,6 +364,7 @@ U_BOOT_DRIVER(scmi_clock) = {
 	.id = UCLASS_CLK,
 	.ops = &scmi_clk_ops,
 	.probe = scmi_clk_probe,
+	.priv_auto = sizeof(struct scmi_clock_priv),
 };
 
 static struct scmi_proto_match match[] = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 342a65ae7f4..519b906b4ce 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,6 +731,7 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
@@ -738,6 +739,7 @@ enum scmi_clock_message_id {
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
 	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF,
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero.
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

