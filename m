Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52CBCDD56E
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 03:01:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5B68908B;
	Thu, 19 Sep 2024 04:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Lg5n5sT9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2632789057; Thu, 19 Sep 2024 04:58:55 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A25189030
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 04:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK+5ZsOZrG+wUSefrn8HNQuo0uwSXSF4ZSUfL13fyKYH11uPlAabQtQI2x/DMPAyE0678nx66ofV5B2vfY6Xr/My5GCYuG+7VwAZzPW+eWmuwT85ql14/mb0ycMDxuUPFyFFK3AWPDTWZ8F+o3S+f33paw51WO9EZWd+wZoDn/P7o5bn7D2Fgp5tf2Y3/G6siZPVhIRdtXbgUcVomUiP6WV03bdi1Xm3iCIaMeSKJYQwviKSzA9KAkj4jirwnqMncntkKwslZ4Alo3yLVWCiYMg4HKS7l3m385rq9LGfXtoG/gxAm1R1iwLAbJg4i7m4KrN6TxDUCcBHNPTw2YYNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOzEUvo7I/DFtxEp4b+VsMBd1oJzXLTq02ZgJXwZ6KM=;
 b=Z/TwPYjSHzX850aZVPplVbR1Cm7/MnxWr3dyUyvhQPaGHbgIvpbWatn+jvKasgNvilxrDtKb4MIyuB/NhkRTcXmdradtHNBXTag41WoGUx7i1ydRNg09EVQ3E7P/Pz/4bsbOv0K9J6hKB6KvYZq8j/mPP8jwCooL5pbXt/2Fqwm88hYcbWqEp3MIFPs+wPY1nkL1U+2a7Y40soY83BRgzSb5OztncybOynV0/oADmb6ciHd3+eI6/+rSDOTIMbazwcEifk0nQnSBC7/O7oBfaKszZ9hx5RRHJz/TnYlmvQ7+/bYL0Euori+iKNxrysp1RW0VROBs9vVZ2t86Da+S3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOzEUvo7I/DFtxEp4b+VsMBd1oJzXLTq02ZgJXwZ6KM=;
 b=Lg5n5sT9mOL8aNck4OHb98M4fxeYr8fP7HLmETcM0HJew7UkBp2JiGpoxqDfdQ3v21F69fr9ANlTTPUnIww8J1gT625LvMtLmTwPkEifzs60Zn2uUDu+RzESow14ycCqzqh0sGvycGZznkd4qPJVhZ7GP9nR6Uy9GSDCVvvoYz+QyWh+VloXYjCVhyjHupfpSVvh24AEgI/MktT71Zs2IUrR+OvDXgkz9fyqy/BuNkq/HewfwoFAIS1mD4OBskSIuMxK80kYM1ZyxA0wokP21LuQsRWA8J+vEvuSPbQSqZUAg+Y9gZ0o/bmLLNcJ+u5IDnX81y2eR9n136t68Gc/AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8867.eurprd04.prod.outlook.com (2603:10a6:20b:42e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 19 Sep
 2024 02:58:51 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 02:58:51 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 12:01:37 +0800
Subject: [PATCH v3 19/21] imx93_evk: spl: update pmic settings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v3-19-80f9786cd1f0@nxp.com>
References: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
In-Reply-To: <20240919-imx9-update-v3-0-80f9786cd1f0@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: fbd18788-91a2-4339-0660-08dcd856fdbf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHpWZ2tFQWRuYVhLd3ltWk52VU5ZYmxGaGMycmh1UHV0aXY3dzY4WllPanRW?=
 =?utf-8?B?eVdzQ0JQeTFiakJZNlo3b3lOc1J1WmxwMzVKalpSQkVCekhFQjY1aXN2djJ6?=
 =?utf-8?B?Tmt6UTFKTDZkMStWdVBCUGltRkJDWjJTTmpUSzd2NXlLc1pGeFpxck9NZjlu?=
 =?utf-8?B?OTVySTFBaTdNTUlKVUpjT0JXQWdFbElYVTZzOE5DejBMbDlMalZtVUoyaFhx?=
 =?utf-8?B?QWQ2YndKK29vMU9OeUVFdURmNzVxMFVnd3N1UWc4b2xwTHpmS0lLbGRPS0s4?=
 =?utf-8?B?RndUVWY4Y0J5QllPcDBGNDluTU9TaG1QWnFTbXVLWHJJWVlVN0lqNEI5WlhD?=
 =?utf-8?B?dkJUSjhqUlJjMEg2NGJ3bmFLY2duU0duQUNFZ2lsajJyOGkwcVVmOWdDdHBl?=
 =?utf-8?B?djJJRTBZblNidTRHa3N4TVJmTmE2VDJxUDFTbVkyOE5UYzhCMC9XNmE5dDJy?=
 =?utf-8?B?STdSaVpmUFo2R2pXa1BVQis2M0FpSFZrS0R5OHN5UlFOcTRwcklUeTZsZWkv?=
 =?utf-8?B?YjUvL2hzc3ZlTk81cDFjNGMyTDVNSmZWeU8yTGxINTRhbjhGZVJjRFlXLzVt?=
 =?utf-8?B?WXFxcExySTMwNVJlSnN6dlhPOUM4WjViZ1VuMEdleTczOFZVQ3Z5aTgxQWJL?=
 =?utf-8?B?VjlYdmtrcVlxWXdpdWFhTS96TVl0MG4vYzVZem5aMUdmMU9UTW5YcXQrcU9Y?=
 =?utf-8?B?d2FzdkdUVnY3Y1UrTlo3U2pvSFNvZkZUZmJXWTBqdENFdlhZd3lMZFlZYXFu?=
 =?utf-8?B?aUxJZHIxVVkvTllWZmsvb3kxWW9rMjJvYVRIa2pjMnQ5Z1daSkpiWWtQQUFv?=
 =?utf-8?B?K2dMNmZkdDJPc1pNT2FpUCt5RlBBTlU2ODRtMHBwS2lZQ1l2NmVPank2Yjlz?=
 =?utf-8?B?cVZ0YXVTc3Zvb1YzVkQ0YnR5dE1RMUJiTU4zTDZycEhNNFUveFFxY041ZmdR?=
 =?utf-8?B?dXZKZ3NzNXJKRjRVUngyNFg0TnFxWkRuN2N6Zm5KNXplUkRtNWJkVEIxY3l0?=
 =?utf-8?B?L3ozOElMUnJydml6NEtITkFIK3lFYmlHUzhnNGMvVXY2ajhXLzVzbHVETlZJ?=
 =?utf-8?B?VUNkU01uMnRjcXdFSldXN2FjZlBpaTFpNFZIMVVlL3BCWTZTSzYwMVIrY3JV?=
 =?utf-8?B?Vzg4cUtzNkR2MjV3QWx5M3lYRUc2djI4WEhpNmhzRHJKSS9oM2FtUnFGMWlG?=
 =?utf-8?B?d3ZnUmkzU2g4bE04ZHljVUlqLzcwNTArY1lLci9oSFZRTmdGcUtSdFF2OGo1?=
 =?utf-8?B?V3FMdXpJZFpXWEMzQmRDenlvOTJnTVhveGxxMnR0bklTeGNrZVpSK25NQ0J5?=
 =?utf-8?B?OXVQY2dRcGs4YitlZTdUbmxkQ3hCb3dnUExzMndVNGV4bElSMFkvbTFVMG9m?=
 =?utf-8?B?azlaNWQzYWtQY2J6Zmo3SEYwcWRqeVNsWUpvbTI5cmJ1Y0NjL2ZPVk5Xdk5D?=
 =?utf-8?B?NFdNVk5nbFZaS09VMEZiM1ZTR215UUxJbVJ6M0RNNFoveDBYZVZxdXJCZlE5?=
 =?utf-8?B?Wk1PU3U1T08vQzA3YVp2cUVzZTZRcWZBVUVIRngrRGhKbFFKSUFOUmJZdFJE?=
 =?utf-8?B?TjVjLzhJSkFYSmNyZnp2dzNXNGtWUHBSTFY3cHhwbGZ4dEE2bHdPWXlOOXFZ?=
 =?utf-8?B?QzgwdlNmZW9Kd254SUpWZ1ZhcG50MVBLWTFKQXZsWU9zZktvMmp2TEszeFpr?=
 =?utf-8?B?cUsyTlV4UlhvQVhXMlBVbnpvdTVxeTdoTlBud1pnM0o1Qkk1UXk2aWg2cm50?=
 =?utf-8?B?TDQvd25xUGdhZUQwQUMxNHFQNDNTeXVmdFMrblJqaWNkMTYwRmRtdGpkVjl4?=
 =?utf-8?B?cXEzWG1RR0F5VnJvTkhvaUE0Ni9vWmlBMW9DZmx3bEpST0ZmdURqcXFkQUJq?=
 =?utf-8?B?TEhuNEJaVEpvNEhuaFM3TElZNmpSOE5TYlNYeWJWdzBQOUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djFPcVlBQkhZY3AwaStydFg3L2JNY0puVkx4YW9XalY5cFhId0FKR0tFTDNx?=
 =?utf-8?B?Y0VKcmN2K0h5OEtPWm1rVk9xUjl2eENuNmxMSm9WMmVFSHdGYnU3OW84c0Rw?=
 =?utf-8?B?RXZlL2hvSDM4aGM5aEJSZng2dm54clhqNVovYm9NUlJkejBwUzhPL3gzbm1U?=
 =?utf-8?B?blJmSHpCVVIvWHBmZzJUNmJkaTZTeENaYmJodEdsNnVZdG9QclVpVjkxSFQz?=
 =?utf-8?B?UTBZSzAvWlhQa0sxN3JicnpwdTJPSzhENllIak9kRmVkRTdYejRUK1l6UnFE?=
 =?utf-8?B?ZTRyRGRzaUZGZE16YWtvaTBOMVVOc2w2UHE3VC9vSVBuemkrZ2EyYmJwWnJy?=
 =?utf-8?B?SFBpd1dPUmEybVluZ0ZuZi9GaWdYbFVxNzJnVUtydjUxZGk4V000YkhBM2Rr?=
 =?utf-8?B?S1gwR29leWZlcUZKRUIyZkZTOGFJYnFGUFFXblhLRGw5c3dxMzU0Z0MvZHJm?=
 =?utf-8?B?YldpeUtNR0VybWtvTzBtaE9EajdGaFVNc2tUV2dwSmtjS2IvSnVZR3V2aGVL?=
 =?utf-8?B?SGhpci92TmxSMkduK3NCMEEzRUxJQTFnRzM4M215ZDc3bndpMnE1bmtIK3BY?=
 =?utf-8?B?RXg1Z0VaUEVoSWs4a1MxTWwxUFdLeVBnOHphc2tTVnEyN0Q3VUF5MnBvbnJH?=
 =?utf-8?B?Z2IxekVqcmt2UVdTZFRSMkUrRGYxZE9IeFVjd0c3cEpIZUN5NlJHSzBqSGV1?=
 =?utf-8?B?Wnh2bUhhcHdjekpHRVdnaHl6UW5RLzdrV3ZPK29TcWh2VEd2bXhaM0JFTXJV?=
 =?utf-8?B?S2dLUW5kUVE1cjZvK014VFhyVU16SmlQalR1cVNUT09YaTZWd2dHQkxmSE11?=
 =?utf-8?B?ZThFRmJTTW94RDNvOWRzR3lFK1lLZUxOejE0eUwxbktzT3FOQjM1eUtWNmNY?=
 =?utf-8?B?R2gxbzJiZWhpbkZMdU5vZTdHaFFCODg3dklSK0ZwRUxmbHExOGQvVWlSbmFy?=
 =?utf-8?B?NmhpQ3E1UER6L0hmMWJ3M3BUblpneVFCTnRnZVcreitTMUhWMXhUT3NyS1ZM?=
 =?utf-8?B?WU9xRDI3ZTZrcGZUVW1xUEI4OVBLbzdyNHNnMzJLL3h0ZkdHTU0vRmxMUzN1?=
 =?utf-8?B?d0VvNngzZTh6Q0VDVnFOODE4K1lxVnNYc2szWWJmS0tJRGMvMEkraHJyNmYy?=
 =?utf-8?B?clByNWg1NGxoTzR3Z3kvUXlWdnFNMmNnbTFYcEJpekVsdzlGUjBkcmdTZ0M1?=
 =?utf-8?B?RmgweWF3NUZEUWs3YlROU21KK0NHcWRZdVlPRFprTitvZEZyTDJFSXdpeklX?=
 =?utf-8?B?anhlLzFNK3dKbXBnQzV0SXhlNFd4WkRNVTFmdjZRbXprS1V1a0xYVnBPVU1Z?=
 =?utf-8?B?TW9wamtEbVhRN1hUZ1ZzbVZWTFg5Z2xDSWZrRmVqRGJGTDdTMFpXaHFMdG5M?=
 =?utf-8?B?cFFiYTBPWWpHeGNTT3lrSWlVNm13MEdQUHZUWGQxQmVXMVFLRG1wZ3pXRW9R?=
 =?utf-8?B?SEpNcHJhUjRkNTFDak9NRTFrdWxqeVdCdXB6K2NDQ2lqZkFKQU8vMDJjdjd5?=
 =?utf-8?B?Z1p4M0lOUlc5QUVFNDYybmNjWGhzNnE5SWdiOTJVWWFhYmRBU0orelRwK01p?=
 =?utf-8?B?R2VaU3ZEY09jRTUvU1psYkVQL2FrZ0ViekNKM0dDREN3K1M2UHQ1cllBbmkx?=
 =?utf-8?B?THN2MlRCdGFoNVFLYitMbU1VMzF2enBGUzdVWWIrcUV4WHVOaGNIREJ6UENP?=
 =?utf-8?B?NW5xUEJZMCtlZmVwV3dlNTNmSnJIaTdCOFVZS216eUJyVDFQUGN6NnJWY3Ay?=
 =?utf-8?B?YmNTcTRCbk1mWTJCbjdiaGVRVTRyMXY1cEExbzhBTk9VR01qK1lxL1BhYld3?=
 =?utf-8?B?ZU4zeVh0M256N0pUWXFQZGZFRHdxMTJYSWRVeldSelAvZU1xWmNsMVpsVHdF?=
 =?utf-8?B?b2V1U1ljdXRCaGdndUhNNDVTQ1BTY2ErelpaMSt2TnpkaGFLaDBKV214b2xW?=
 =?utf-8?B?d1VzOVFLbUVhakx1WWdYODUvMjllbitrVlRvZ2RaQWZ4UFZLaWdVSnJhZjRh?=
 =?utf-8?B?Rlk3b28rMzU0SzdYbDN1YWhieUlQcTl5VHF0NXNjdmVHWXdscndvUGlNQXJG?=
 =?utf-8?B?TzllNVhkWVdiL3A2WVZGeTFDQjNreGZLS2h5eHhBSnN2d0dTRWJGZ0I1d2Zm?=
 =?utf-8?Q?zSqaZa61nB+lDOFceDRZEn0ot?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd18788-91a2-4339-0660-08dcd856fdbf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 02:58:51.6621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP266ODrF1mzhjb63NPVSlFgd6EFKrXrkHdQZ/sP74R/6e/UeinVxnUfkvDTAotpY5FICvKKrPQckT3CrjEvIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8867
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

1. Use runtime voltage selection for LD/OD/ND mode.
2. According to latest PE/TE report, the voltages of VDD_SOC for
   LD and ND mode need add 50mv margin, so LD voltage is 0.75v->0.8v,
   ND voltage is 0.8v->0.85v.
3. Use TOFF_DEB to differentiate new trimmed pmic and old pmic

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/spl.c | 42 +++++++++++++++++++++++++++++++----------
 include/power/pca9450.h         |  2 ++
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index 2ad7489ada7..503286ce3af 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -62,6 +62,7 @@ int power_init_board(void)
 {
 	struct udevice *dev;
 	int ret;
+	unsigned int val = 0, buck_val;
 
 	ret = pmic_get("pmic@25", &dev);
 	if (ret == -ENODEV) {
@@ -77,20 +78,41 @@ int power_init_board(void)
 	/* enable DVS control through PMIC_STBY_REQ */
 	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
-	if (is_voltage_mode(VOLT_LOW_DRIVE))
-		/* 0.75v for Low drive mode
-		 */
-		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x0c);
-		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x0c);
+	ret = pmic_reg_read(dev, PCA9450_PWR_CTRL);
+	if (ret < 0)
+		return ret;
+
+	val = ret;
+
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		buck_val = 0x0c; /* 0.8v for Low drive mode */
+		printf("PMIC: Low Drive Voltage Mode\n");
+	} else if (is_voltage_mode(VOLT_NOMINAL_DRIVE)) {
+		buck_val = 0x10; /* 0.85v for Nominal drive mode */
+		printf("PMIC: Nominal Voltage Mode\n");
+	} else {
+		buck_val = 0x14; /* 0.9v for Over drive mode */
+		printf("PMIC: Over Drive Voltage Mode\n");
+	}
+
+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB) {
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val);
+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val);
 	} else {
-		/* 0.9v for Over drive mode
-		 */
-		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x18);
-		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, 0x18);
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, buck_val + 0x4);
+		pmic_reg_write(dev, PCA9450_BUCK3OUT_DVS0, buck_val + 0x4);
+	}
+
+	if (IS_ENABLED(CONFIG_IMX93_EVK_LPDDR4X)) {
+		/* Set VDDQ to 1.1V from buck2 */
+		pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x28);
 	}
 
 	/* set standby voltage to 0.65v */
-	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x4);
+	if (val & PCA9450_REG_PWRCTRL_TOFF_DEB)
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x0);
+	else
+		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x4);
 
 	/* I2C_LT_EN*/
 	pmic_reg_write(dev, 0xa, 0x3);
diff --git a/include/power/pca9450.h b/include/power/pca9450.h
index b8219d535ad..f896d829d37 100644
--- a/include/power/pca9450.h
+++ b/include/power/pca9450.h
@@ -54,6 +54,8 @@ enum {
 	PCA9450_REG_NUM,
 };
 
+#define PCA9450_REG_PWRCTRL_TOFF_DEB    BIT(5)
+
 int power_pca9450_init(unsigned char bus, unsigned char addr);
 
 enum {

-- 
2.35.3

