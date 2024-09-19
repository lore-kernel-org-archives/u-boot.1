Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17FBBCDD56B
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 02:59:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41F789026;
	Thu, 19 Sep 2024 04:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oL7a6oDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F18288DB6; Thu, 19 Sep 2024 04:58:28 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F6288FC1
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLEebeOmEKAbHtKFItBIkn8lp7TdWPm23SwFMjkiWWQ9ZzEHkcPjNPcxwpgKxT4RbznM4K//AAS6LCvhKUsqqL4YlX6AiajTp+Fe8APXuvt1Ox9ZasFwD4OVld9168cem4SwE8UMelnDh1CuCEBC4Bdl4TxjuI08BY/wcv4KS+YMoDhUxt77Nm50psLKrinblxqgsUVOj1/wvfJtnpduwCszgPQXGARNanJq5fIg+K9aoDczH0nUOL2aTj0AhXa+xCGF3G4NoZGFcRKSCzUrA24AO1FgsnS0mdBHklfSuNWi2jIeygIOFyCw3pL6P+3Yz/NVrcJENq2fxb/nfskgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8Q70aiX04tSdbtmVAxHhkMD5Pz4LA5BBdHiYQXJOCo=;
 b=pK2t6Ay7VHEGlj61ZAxwz7NLe7P914mkEvOvfM+guR+7AnO0/Fb41O4UKoyTcPV2vuKIbFgxBxJlvtHeLTjIpKnR4Uj+cSa0pWi++rt6qZQn4gWfSUzNHYeNUUBlndaXIyvT0xrrsD1DEBO08Az4IMZJn6W55KL0MW2dE7D2oxz9WLO387/HA2R+Ge7gStc/EB0WrRTDDmpKuBNuWUy6g5Jvnvq3b5R1N9tNPtxQVhhD7c7nLi7ArKIfZIu2NHC6/qWBJZW7lz9Q4XAFJVOGR7SpQ62EB76Xjsxmnj4v/Vy4PnqZ72HRiyf23Owkx7eexUPl7omj+ideQA/0Rm7JFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8Q70aiX04tSdbtmVAxHhkMD5Pz4LA5BBdHiYQXJOCo=;
 b=oL7a6oDUYAJjpajlAkAXZ0QzYg4ZG0xf/GuIsBsi0vJxxQws9A43e7vvC8DoqjLaPXherTWJKtVrKpbw+7CnMZklUmnHH4D3mcbxBR7qSaavI4dOPRYA/iWHtGmjdijwx6SyUDFkxBCq+rzv3hwSh/Gm9UaEmni5N80LiWTtMCFgAkEHUR18qkkumo8Xznb5ubE7qLv2lRdFwywS6knqKjltJT3ByZv2I+v2FUPqR+M4vDtjLIpUlE8LPqHLVi+OcCX/k8NondCb/6qWbjV2zOTo4zHVkZUr2SrQ17DQGiUk9k9YQKdd8qCFEj5hTiLBoyDn4LQRI++Ohwus9qORgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9986.eurprd04.prod.outlook.com (2603:10a6:102:380::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 02:58:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:26 +0800
Subject: [PATCH v3 08/21] imx9: soc: Add function to get target voltage
 mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-8-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9986:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d94377c-611d-4f00-2edb-08dcd856ed7f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjBYbjRvTWFaazI5MUVvNWNpSUpGTWw1R1Qwa2cwUytGZG9WYkRYQit6dito?=
 =?utf-8?B?SkR2SDFsVUUzWjlZaXRvRm1hYkt2ZHR4YmVsUjFUK1dZSGE4SldmZjlJazNh?=
 =?utf-8?B?dUpEOGVBVkZOTDVHSkhyM0N5OUZ4bnp4bDc4alN6SnhNeUM4L3l2MTJIbU9y?=
 =?utf-8?B?dHE4aWdUTUM3Qy9MM0NDV3N2Qy9meW9EQmpWUUNLVGdUZnVTSEZzZWY1OGpM?=
 =?utf-8?B?aURaZDhKV3RsQVdGNXRsUkZpUmZHeThaTG5sZktqQUhUQ1kxOFFPNkJ2eWpP?=
 =?utf-8?B?Q25mVHowM1FCSTNmNzRqNzFFdS9RZmNUZlljcWMzUU1uZmYwTWdkZlVDWSt1?=
 =?utf-8?B?Q3VGTlZabVBUQXVVNGlzY3ZSS1p0aG9OaEdWU0dZeTVGUWRmNEdnKzhtaGhl?=
 =?utf-8?B?eWp0VnJGWi8vZkVKZEwzMHBxbHowSXVNSGtZeFZqcFpER2xxNURoMFdoYW51?=
 =?utf-8?B?SFU3SEJrM2JFNEFCVytRRVZYbGE2Y1c5VDVqNGtUY1BlcG9PR0R0ZlNmVXQw?=
 =?utf-8?B?YUJiY3M5TVZQR1dyNzlZWWNhd2JSYTRTdVU1MlI0aGd4OUNjM0t5QklSOHB1?=
 =?utf-8?B?dXhpcXdZQThtcHZVaTI2QS9lMkVvWEhCYkVDNE9EWWljczR1c3BBc2YrSSsx?=
 =?utf-8?B?cGJibkpXSlpiTENVdXMzZzZnZTh2V2QzdzVIVzBsSTZ6QTFLeSt1VmpDT0hv?=
 =?utf-8?B?NGQ1OWdUQkV2WktkVURieXdwaTN4bUxRNUhmRG1EUzJvNk1sayt2V0w3emwr?=
 =?utf-8?B?L3FGNUlyK240eEptejRkWUdXcFpYL3MxV0pFRk1EMUpaRjRUZ2s1b0MzRnFj?=
 =?utf-8?B?V0p3ZFI3b1djMnhmNUI0N0RRdUFTbm1waHMwemp1WkJNRnJlSExxbzFDNGJB?=
 =?utf-8?B?RUpOMmt5ZGMwTGprR3NWQWRQUit2dWM4dXptU3EzSXdZOTFEb0RMR1pFSkQz?=
 =?utf-8?B?OVVxWGhQTHhCaXBUZXgwekNGTWJlNGlMaFRqVlpGb0psTHBlTnlPdk1TMUFy?=
 =?utf-8?B?WE5KcGRENzIwaDYxNUJzVzN1QVhGclJZNWRNQVNGNHAxNGVwU3FyS1hsS25M?=
 =?utf-8?B?cXYwSkIwSzRDZmdlcmFjVS96YVJpRkpQL1ZmeitRNmZ2WUxKZGx5L3J5RTdn?=
 =?utf-8?B?T0NEZk0yZGpEdGNLTngvWjZUUElYcThnVytiQ0Mrd1lnN3FBcVVvTlJqT0Ev?=
 =?utf-8?B?VTBUK3dVa0FsMVpoWU1rSGptbEZiRXMrQ1VqVlFkNGMvTWNHMGNTVDZBVHZh?=
 =?utf-8?B?WEN2Q3QyM3FoNjk1b0ZxVnFlc3VBbXZUakY2dlZoQ1hsQWlyM0QzYkxVa1FE?=
 =?utf-8?B?WWwwYlB4YjBSS1JReUR1ZjgzN2EvQVVHdEN3RlBNb0YzUENMSlorQ2F2cnZG?=
 =?utf-8?B?VjZYRWMxbitSQzN0ZWF1V0VlTjZGUEQyRGZZN3dHUDAzTlFOT2Y0K1RZMnh6?=
 =?utf-8?B?K0ltcGVoZ0tQYkhqbXlYTnFaVmpWeTRWdHVPcGIxQmg5YWhXTU56YVN2MEgv?=
 =?utf-8?B?Vlp3aUIxT2F1djhydFV0cW0vQXlHSnU3WGo1TmErWXhHNHlLMXFSN203d2JB?=
 =?utf-8?B?Zlh1V0xNNXM4bEhoM0xqRUZPMUFuTGw3TjBHeERmL3lUVDl2aFFLSHdGQjNE?=
 =?utf-8?B?ZjVGbjFRczVYMGZpSnlDSzBKMXRscUh2R3JhOEpHWStEOUM1Nkl4TEduZzN5?=
 =?utf-8?B?VE1SdUFldGRQcXh4WVI4aXVYcHlia0ZYUFo1dzlFZ2hzZkNtYWx4b1J4b0Z5?=
 =?utf-8?B?U2VKNlNwRGpCUHNqcHEwMTI2bm9GWHlxTVlicm5vNXJWY3ovQ1ptdXZxblFP?=
 =?utf-8?B?YkxoNEV1QlRJcW1sR3hOcEV6dTJJZWdtRDlmWGRGNzAvRlk5bDU2WFNGM0tR?=
 =?utf-8?B?R0c5Qk13MDUwbzJiMGFCOHJucHl0RUp0STdhQjVSWmwxaUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0I5YkhBbUNpVVhGSUN4ZmNaK0dKVVBLK0o4TnFKckowZUNBYlQ1MjgxR1F5?=
 =?utf-8?B?NVFwS1p3elFKN0o0cURwbzJ2RHlGa0ZaNVFxcnQwV1YzT1M3V0w0U2EvL3J5?=
 =?utf-8?B?UnVqT3d0VStGY3EvUDV1cTR3MzRGb3A1VkZGZzlDU1J5dmZFcWFwM2F2SFZV?=
 =?utf-8?B?MFJVM2ZhQlBFeHp0OTN3U3R2b0NiVG1HTldqcXVaWWIwR1Q0TTBqV05qM0xm?=
 =?utf-8?B?K05hV3JscWRQRkJXdHRYU3lSVjM1ejNZaXhIRWFWWlVMdjRkTEpwK2tHV0tU?=
 =?utf-8?B?SW1idEVvWE5KWWhJYkpyQ2hVTFJFcjBMSzluSTh4S0pKU0trTjhuUWJGbExy?=
 =?utf-8?B?eFg4a0RzTkZBYm9VT1hlbURGTW0vSThkMlFSK0JhWGtYZWtwbWxnMjlwa0ZJ?=
 =?utf-8?B?QVRWREc1RC9ERlZ1eStJM2haSmtlTEw4ZmlJdVZXRnd3TzZYSStQNjdMKytN?=
 =?utf-8?B?Y1Zld1g5aThydldpZUZsODgzS2Yvdzh0b1JicDBtODRVUUMyYlBDWkJYVVk1?=
 =?utf-8?B?TDRCQ1l2MXZ1UmpYdnBvUFI1ejN4Q2EwMHFGN3ZnMkZWV2VrY01vMmpFdlBS?=
 =?utf-8?B?eHF3aTNlZXhiTVpTUFVvcnNyYmhyVGVhakVVL2dMbXUvSUVlN01TRlQ0dk5Z?=
 =?utf-8?B?eXF0K3R1dERKWklvWDcrcXNCVUhkaTBXQzN1eXNrSDZJc21uYjdoREFDTG5o?=
 =?utf-8?B?OFdtWUxYMjFzNzNZMnZVT0xTY1ZObUdYbXUxNWVDRnFhZGV5NG1ZNEFJa2ZO?=
 =?utf-8?B?eDJkajFiMmZkRXN1YmRPa3B5cG56QjhWM2NMZDlQYjdnZGlHMEhsZXNJMzFj?=
 =?utf-8?B?bFNldlIzU3VFQXlveDF4dWpDMDdMUEVlcEppUHVkdU9EZ1lhOW1xczRHMTNX?=
 =?utf-8?B?ZUhyNHNweEZVME14NXRaRjYxQlNLSmRpWnIyUmhvRDRZWjB5MTV2NjVLWEZm?=
 =?utf-8?B?NkI5SHZaL2ZrWGNiR0NlMFRzQ0taRVVtWlFlMTBGTWttKzVSeEpCM094Ymdn?=
 =?utf-8?B?MGJObTFxM3lSU2ZSNWVXUXlVM1FsVnE1bTNvKzJQZlhZZk4zaXgrcVlPRUJ3?=
 =?utf-8?B?alpsUXhzOUlrVUowazlwWStMZThsL3ZqakN6TDNjMCtzL2RjNkpOVGVIdHE2?=
 =?utf-8?B?T3c4TjJKbWkxVXV6ZHpmd3NlaWdWSHB1NVlNamVLYjFwMWMyN3hZZXRTb0R5?=
 =?utf-8?B?UkJ5TENGN0dManBFSG1ZRHJhYWpvRGhiU0lZc2E5MnBpb2hpWk5ocVZwbEY2?=
 =?utf-8?B?WmFvTzBvTTJKTHpNSndvNXdqM0ljaklNY2xvTEk2R3JvY2RURWhWYkd5ZHUy?=
 =?utf-8?B?U3lybkNSTzVBbTJXcWh4Qjk2ZVd1VHhaUFFYZ0JZSUt5cnpBbkEzTkVNTGha?=
 =?utf-8?B?bXVvaGIyOEpRc1FxdUJXaHNWM2hoRmhkTGxPK3RsRVhOQWZxa0p2WjNWT2dC?=
 =?utf-8?B?QUZJTG1mNUxiS0d5RzVVRDVPOVRUcmdQWjJmLzlDa080djl1bjZyblo1RjBk?=
 =?utf-8?B?U25tdFFaMklWYWlrcmZhQUVGblcxY0xkWFpMaG5UbWpsVlRuVzMvVUFRSXB0?=
 =?utf-8?B?TnVRVmZHQmV1QkdFS1VhcE05M2tZV0g1dmJLbmh2TmYwQllzcERTdE8rbE1R?=
 =?utf-8?B?SnNUWHFabEpqODBqNDZZL2IzcnV4cXNPWmJQYWdWZXJqSk1Nd1pORXJJeXdw?=
 =?utf-8?B?UU5LL0xsQ01zbHpLa1lMQTBQZVFvVWhuQmpkSHd2UmpaUTFxU053ZndRLzNk?=
 =?utf-8?B?ZUhSVFJFaVl6NE5WaXIreUh3Qng5cS80dCtRTVM2TndUREtGTmJDRWE0UGdR?=
 =?utf-8?B?ekhNamtwQTQ3VVdkMmd6MUJEbE9aRjkvcnhQcEwrUWdDZWVHQWNmTE1PRFhP?=
 =?utf-8?B?d25JUERVckJ3Z0lWcS9ISkNhYmlsM0haQyttcS9tSjdMd2YzNzd3UmxEdDNo?=
 =?utf-8?B?UEFiZVNseHV0bmc4UzhIQmFCSkpLTGkvY3B3NmJ4cDRQRDZDSTZ1dlZBNzdE?=
 =?utf-8?B?bnV1U0xURHEyTWdBTVVmMFNVTDU5cmUyNUY0TXl4ZWpsZkM2amhGTXR4NnVn?=
 =?utf-8?B?ai9RdHdlYTFpbFdaNFNRRkhTbWNYQVVZK1l0NThyMW9JZGQzZm9wTVYxWE1I?=
 =?utf-8?Q?DqV5dXAzXoKWDdWHPGbFjk2ud?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d94377c-611d-4f00-2edb-08dcd856ed7f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:24.4220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OgCCkm5hPdeHdWwh8ccEJcx6hJqF3OgxphqLY2kcvDDciOLodooUy9XV62Hs6qna08s8h82du0rQ2mjRrnUBsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9986
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

From: Ye Li <ye.li@nxp.com>

Replace the static CONFIG_IMX9_LOW_DRIVE_MODE with runtime target
voltage mode by checking the part's SPEED GRADE fuse.
SPL will configure to highest A55 speed which is indicated by the SPEED
fuse and select corresponding voltage mode.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |  11 +++
 arch/arm/mach-imx/imx9/clock.c             |  31 +++++++--
 arch/arm/mach-imx/imx9/soc.c               | 107 +++++++++++++++++++++++++++++
 board/freescale/imx93_evk/spl.c            |   2 +-
 4 files changed, 143 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index 2f7a1292758..e4bf6a63424 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -8,7 +8,18 @@
 
 #include <asm/mach-imx/sys_proto.h>
 
+enum imx9_soc_voltage_mode {
+	VOLT_LOW_DRIVE = 0,
+	VOLT_NOMINAL_DRIVE,
+	VOLT_OVER_DRIVE,
+};
+
 void soc_power_init(void);
 bool m33_is_rom_kicked(void);
 int m33_prepare(void);
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
+
+#define is_voltage_mode(mode) (soc_target_voltage_mode() == (mode))
+
 #endif
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 0abf4579a1e..1433e68874d 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -603,7 +603,7 @@ void init_clk_usdhc(u32 index)
 {
 	u32 div;
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
 		div = 3; /* 266.67 Mhz */
 	else
 		div = 2; /* 400 Mhz */
@@ -700,8 +700,7 @@ void set_arm_core_max_clk(void)
 
 #endif
 
-#if IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE)
-struct imx_clk_setting imx_clk_settings[] = {
+struct imx_clk_setting imx_clk_ld_settings[] = {
 	/* Set A55 clk to 500M */
 	{ARM_A55_CLK_ROOT, SYS_PLL_PFD0, 2},
 	/* Set A55 periphal to 200M */
@@ -728,7 +727,7 @@ struct imx_clk_setting imx_clk_settings[] = {
 	/* NIC_APB to 133M */
 	{NIC_APB_CLK_ROOT, SYS_PLL_PFD1_DIV2, 3}
 };
-#else
+
 struct imx_clk_setting imx_clk_settings[] = {
 	/*
 	 * Set A55 clk to 500M. This clock root is normally used as intermediate
@@ -762,9 +761,18 @@ struct imx_clk_setting imx_clk_settings[] = {
 	/* NIC_APB to 133M */
 	{NIC_APB_CLK_ROOT, SYS_PLL_PFD1_DIV2, 3}
 };
-#endif
 
-int clock_init(void)
+void bus_clock_init_low_drive(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(imx_clk_ld_settings); i++) {
+		ccm_clk_root_cfg(imx_clk_ld_settings[i].clk_root,
+				 imx_clk_ld_settings[i].src, imx_clk_ld_settings[i].div);
+	}
+}
+
+void bus_clock_init(void)
 {
 	int i;
 
@@ -772,9 +780,18 @@ int clock_init(void)
 		ccm_clk_root_cfg(imx_clk_settings[i].clk_root,
 				 imx_clk_settings[i].src, imx_clk_settings[i].div);
 	}
+}
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+int clock_init(void)
+{
+	int i;
+
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		bus_clock_init_low_drive();
 		set_arm_clk(MHZ(900));
+	} else {
+		bus_clock_init();
+	}
 
 	/* allow for non-secure access */
 	for (i = 0; i < OSCPLL_END; i++)
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index ba04abff262..52aafcbf99c 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -615,11 +615,99 @@ int arch_misc_init(void)
 	return 0;
 }
 
+struct low_drive_freq_entry {
+	const char *node_path;
+	u32 clk;
+	u32 new_rate;
+};
+
+static int low_drive_fdt_fix_clock(void *fdt, int node_off, u32 clk_index, u32 new_rate)
+{
+#define MAX_ASSIGNED_CLKS 8
+	int cnt, j;
+	u32 assignedclks[MAX_ASSIGNED_CLKS]; /* max 8 clocks*/
+
+	cnt = fdtdec_get_int_array_count(fdt, node_off, "assigned-clock-rates",
+					 assignedclks, MAX_ASSIGNED_CLKS);
+	if (cnt > 0) {
+		if (cnt <= clk_index)
+			return -ENOENT;
+
+		if (assignedclks[clk_index] <= new_rate)
+			return 0;
+
+		assignedclks[clk_index] = new_rate;
+		for (j = 0; j < cnt; j++)
+			assignedclks[j] = cpu_to_fdt32(assignedclks[j]);
+
+		return fdt_setprop(fdt, node_off, "assigned-clock-rates", &assignedclks,
+				   cnt * sizeof(u32));
+	}
+
+	return -ENOENT;
+}
+
+static int low_drive_freq_update(void *blob)
+{
+	int nodeoff, ret;
+	int i;
+
+	/* Update kernel dtb clocks for low drive mode */
+	struct low_drive_freq_entry table[] = {
+		{"/soc@0/bus@42800000/mmc@42850000", 0, 266666667},
+		{"/soc@0/bus@42800000/mmc@42860000", 0, 266666667},
+		{"/soc@0/bus@42800000/mmc@428b0000", 0, 266666667},
+	};
+
+	for (i = 0; i < ARRAY_SIZE(table); i++) {
+		nodeoff = fdt_path_offset(blob, table[i].node_path);
+		if (nodeoff >= 0) {
+			ret = low_drive_fdt_fix_clock(blob, nodeoff, table[i].clk,
+						      table[i].new_rate);
+			if (!ret)
+				printf("%s freq updated\n", table[i].node_path);
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF_BOARD_FIXUP
+#ifndef CONFIG_SPL_BUILD
+int board_fix_fdt(void *fdt)
+{
+	/* Update dtb clocks for low drive mode */
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		int nodeoff;
+		int i;
+
+		struct low_drive_freq_entry table[] = {
+			{"/soc@0/bus@42800000/mmc@42850000", 0, 266666667},
+			{"/soc@0/bus@42800000/mmc@42860000", 0, 266666667},
+			{"/soc@0/bus@42800000/mmc@428b0000", 0, 266666667},
+		};
+
+		for (i = 0; i < ARRAY_SIZE(table); i++) {
+			nodeoff = fdt_path_offset(fdt, table[i].node_path);
+			if (nodeoff >= 0)
+				low_drive_fdt_fix_clock(fdt, nodeoff, table[i].clk,
+							table[i].new_rate);
+		}
+	}
+
+	return 0;
+}
+#endif
+#endif
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	if (fixup_thermal_trips(blob, "cpu-thermal"))
 		printf("Failed to update cpu-thermal trip(s)");
 
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
+		low_drive_freq_update(blob);
+
 	return 0;
 }
 
@@ -943,3 +1031,22 @@ int psci_sysreset_get_status(struct udevice *dev, char *buf, int size)
 
 	return 0;
 }
+
+enum imx9_soc_voltage_mode soc_target_voltage_mode(void)
+{
+	u32 speed = get_cpu_speed_grade_hz();
+	enum imx9_soc_voltage_mode voltage = VOLT_OVER_DRIVE;
+
+	if (is_imx93()) {
+		if (speed == 1700000000)
+			voltage = VOLT_OVER_DRIVE;
+		else if (speed == 1400000000)
+			voltage = VOLT_NOMINAL_DRIVE;
+		else if (speed == 900000000 || speed == 800000000)
+			voltage = VOLT_LOW_DRIVE;
+		else
+			printf("Unexpected A55 freq %u, default to OD\n", speed);
+	}
+
+	return voltage;
+}
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index e5807134bb2..e4999baa95f 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -77,7 +77,7 @@ int power_init_board(void)
 	/* enable DVS control through PMIC_STBY_REQ */
 	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
-	if (IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE)) {
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
 		/* 0.75v for Low drive mode
 		 */
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x0c);

-- 
2.35.3

