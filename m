Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61328C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 15:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF3EB82B7E;
	Mon, 19 May 2025 17:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="T4F27zcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E6482BAA; Mon, 19 May 2025 17:49:18 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F6982B4A
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 17:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DRd2Z/+sFb+lrIyYW+ml51DVXCJUSVLbpErsHSssyPdslSG2N3wYp09x9XIRHrkFGgKBR2xckhtHbA27VOEheBy4rfE5reurN7V12fqqiQijtvyokV9VUHdG8MDoxa+YTLo2Q1Amh8qewdBFW1xlqAdT6ovbBuj2Dat6CMc/gmVmVMc91nmMmNzHV8yNokIbUdAFMRjW/Yq7w3neADyPoyZnU3TQMyU8k7nPOJyqOYDI/qhh5SLyHHShTKlPxJ7mdAoB0+iKwwAaxeJue1KDRu1PRhA1ujHTZarIg/I3y68zFDvgYx5RhaIHszI5lVHmmmubKh97yFBNqqU1GCAxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJHNX5qoSGfImPNcmKl1P9s4RxGeb5nWFxN8LlUfWG0=;
 b=kqxogdGrwEptoppMjukQwrL9POXpAfQxdcuEsoh0GaEFWJzjModqJTvXj+S+RkIMyKZQ0ytN1jL928WK8yQ1JECiqu/1tqEZJ0KHhW5lKGzgBJMbZQqC0jSaiQNzpFGaT9rEXtfQBz0IR3IHJkNt9EhmkU4ad37fnUoxGDDkIRTNA47t1QKE12XwHuZLBMkIircvx2JhX2uxA6hVq52l5srKLXrt5BnXaRn3nfJG8wibkeyC90GM6CMqiYbaSiNyiHWgmuDFafJchZzpZNaWalLDYFC41FlnnU4MJ6ylSMmWjwxr84rAbgHp2SzAJtxu8mrzGtPWP9R+CfBx0rotTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJHNX5qoSGfImPNcmKl1P9s4RxGeb5nWFxN8LlUfWG0=;
 b=T4F27zcIcmmLAODuVw6i4tqXULD5ixpeWUDJWqkZZcINuhk2YQF7m6idhwzpzArQy3lqg2j6LcWhWsb8WHMsohUj3VAUl/kR1nGZuoQpxKbBXBD4r3sqroH1Kk0oN5PtxKrWhvd9FVvVCt3Xg6hncKlAr+CCrzXkjv0eDf/hsiw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8285.eurprd04.prod.outlook.com (2603:10a6:102:1ca::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 15:49:13 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 15:49:13 +0000
Message-ID: <d41b216d-4e59-4bbb-a723-d0260e238b56@cherry.de>
Date: Mon, 19 May 2025 17:49:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] efi: stub: Define debug uart functions only if
 CONFIG_DEBUG_UART is enabled
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-1-dec6c8391f01@thaumatec.com>
 <20250519144835.GB3396848@bill-the-cat>
 <c90e00c2-ffea-4221-92a5-2cc8e1923dc8@cherry.de>
 <20250519154304.GR100073@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250519154304.GR100073@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0401.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: b04fb276-0ea3-451b-6a99-08dd96ecb3f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUZqQ2VRN3Z5RTdEVFhobFdZNEV2aXNROHYvN2VjM0hpR2N3clB1SXNQK3py?=
 =?utf-8?B?WHZyZm41MGZ6TVdsazUwL3BLOGZlMmdKNmJXL0NuNXpGSlM3VjQ0WWo2aFpj?=
 =?utf-8?B?K3JOVkdOZFEvWXJjVXFmTWI1NWpoeUpENUVOWFFJT0VLUkljZE9sYnZsTUFm?=
 =?utf-8?B?Q2pzRzl1by9LdWNjeXR1UjQ4Y0pybGFVMUV0dHkxd3I5elo1U3JQRGJPL2h6?=
 =?utf-8?B?Yng5M2s2RHp2TnhKRW1WMjVxbDhzcnA5c1BSdmhnNlhqdkhlRW1NendzVnM5?=
 =?utf-8?B?MHE2YjRTVmd6VDBpczc5dVo0ZHBEN3hpK0g4OEY3MlVPSmRhUXZCcXd2K052?=
 =?utf-8?B?Y2ovK01UWXRkVGRyd05ZVCtRVlVDTHJFSzhoRnBnN1RQTzNLODB6cUtBVUxx?=
 =?utf-8?B?NUZUOXJNZlN5Z3hvcWFxcDhhVjNvTHhrdDRpOVhPQ09TTSthQzE1YkhiRlJD?=
 =?utf-8?B?OTIrZkJzMER1THJodkVrelhhcUJjeE5BQnRyQ0t4MDY2MTlseGovUG1LQS9C?=
 =?utf-8?B?UEdScXQ3Q3p6TTVQcVhzQ0ZZYlZsTEs5amlCT09iNG53enExZ1NEdUxpcEph?=
 =?utf-8?B?K21MaFB6RVVZeDRKY2VRZVJ1bjU1bnJqcFlwdVlnL2xheFNWNDM0ZEpNY2dC?=
 =?utf-8?B?OXNmajBreThhN01MSW1Ea1U1WnZKVG5tQVVIL3FyOVpkckdzcmNlSFN0R0Fv?=
 =?utf-8?B?ckU4ZDdraThqWURXd1Izc2tlbFlnRnBoa3Bha1ZXV210dDQ0a3FXejQ0ZTdS?=
 =?utf-8?B?eTlXU3lGQkVPU2srS1AwK2RUb0h1SFE1RmxQVTJaVGlCQTVyS2hYTGxEdGRV?=
 =?utf-8?B?dEoyZzMybGozTjVkZFR3NmZOT1pQM0FsbG9rM2p2V3hETG5FRmgwejZ3OHBJ?=
 =?utf-8?B?SDE0bERiOXZWNkRvR1dmMjB5OTJiUE10SUVMcTNrQlpGK0QvY05yZEZGK0Ri?=
 =?utf-8?B?RU5QUkV2a2pHUlNSUlVBWDNPZHBNL2JoNExGbkp3WDNWVjNHaE85U2xCVkFW?=
 =?utf-8?B?TDZCY2NnSm10ZDBCOVNoejVyNDlId1FGbTI5TkdabWhqSmx6LzA1MzRielZ1?=
 =?utf-8?B?ZWNhU2g3TG8zUEk1OVZiUXRCeU1MOHFjOWdaYXlJRWdBRzc4Lys1WjZ2c0o2?=
 =?utf-8?B?ays1UjUvd0hGajh5ZENjN1YvTk5TR2I3bVFTUTlhbjNYWjJOYTZtbWIwc1FH?=
 =?utf-8?B?YndKTmQrM3p1Ymx4SUxZSE1oY2h4UmZKNmlqdGtEZDV0WGFuVm5MVExuSXJj?=
 =?utf-8?B?Y2psSzJDN253b1NkYU5Wdzc4Q1o0a1VNaTVYN0tFRnBkdU9TNkExWFNhY2tX?=
 =?utf-8?B?aVVLWGJWdUw2dkU0TnpWSGhFYVFPWnB2MFVheFl1aE5VRnIyYU1XK2JaMlow?=
 =?utf-8?B?TEE1YXJuZEVTampqc2ltZ29YbzZhcXdSRHp3VE81UVBIdFVUcHF2ZHFid2xP?=
 =?utf-8?B?Q0FTNTV6c3o1Mk0zMzd3TjNZdkJ2VGE4MTlsemxRT2FZS1VLUkRDRGMvbnRu?=
 =?utf-8?B?UjVUTUNYSWorOC9HbC9VRU1NQ2pTdTZKTTZtSlZFakxwbHhEREYzeDhDamtR?=
 =?utf-8?B?RU16RFIzcUpqdTdSVG5lWjRjckZyaEliejh2dm50ZGlISStEQjFRRFdBakRU?=
 =?utf-8?B?YXpuclNvSTMzMjRIM1NublVBTkdZVjl4Sk5SZjl3NkplRGtqSm1lRjRjWlBT?=
 =?utf-8?B?UU9ZWFFNbkJDWDRBLzdIdjBHWlJxSE1NWnoyeElZVnQ2LzRyYnVReUVuZGFH?=
 =?utf-8?B?TTJBRFlFd2ZiZzZEcnlrZUg2cEY3Mlk3aVFONEFYNSsrUCtJb0p4ZEZoMTVJ?=
 =?utf-8?B?Q2VVRWV1NWN2NGMyMVFPeUZqVGdPMXpBdnNPYTBPVUh3eXRlOXA1b0lBRXg4?=
 =?utf-8?B?eDdiNHpTK2JFSGw0S1IzWkNrZ2JGK0NYL2k1Q2ZwcDJWd09VTVZhMm53b0Vt?=
 =?utf-8?Q?1jX4emctrII=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJ4bzVjSE1ieHpHVkRSZitZbXc5ZFc0Qkh1STQxS3JwYWxDQ1pXQVI0Rk4w?=
 =?utf-8?B?WWZDb0ZVMW9lejFncWVGeFRTTDAyaVZnVU5oYVE0V1oxTUVWcHB4QXN4enBz?=
 =?utf-8?B?eHZXVHlRQWRDR3pqK1ZmYWlYWCtDOWNJNzZvNkVXYkFQLzJNeVRxMjJZNE9x?=
 =?utf-8?B?dzBJY1hpVjlwNFhOdTVZTW1TejEvNHZLd3VMUVJFNEQyS01TRWpSTUR4WlU4?=
 =?utf-8?B?QkVCMDE4KzRNcjF1U3UrVk0yMTM2OW5hUitZODVNclhaTVNEV3Q3WVNCZ2xn?=
 =?utf-8?B?a3pzZndUTi9TVkFBSUFHTm5ReXZZT05BR3hleTNxOFU2Uzg4S1Z6NXJabzBE?=
 =?utf-8?B?WkF5bHJPMlkzeDJSQUcxbW9XeVpUVGlTOXRRY0ZVaW51TFZIOWtlN2hzNnE5?=
 =?utf-8?B?K00wUklKY0RwYXZjbEdJRjBPRUtPS0pkeFBTM2w4SzRncThnaTJobWZuV0pV?=
 =?utf-8?B?YzZmNm9WSUdSZTNnWVBpTUdvMEc3UkhobzgvN0ZhbWdXZGVTYUxsM0NBenhj?=
 =?utf-8?B?cVhlMUY2VnlIbWlKQXhKeGV6ckRHU3Q4aWF4ZDZzVW1BdXA3ckpQcER4U3hr?=
 =?utf-8?B?NzB6UVB6SzNyZUhQWUM1YjFRUG03V2xYZHQ2cUd6VC96eDhBbHI5UnNCREJ3?=
 =?utf-8?B?N2FMdE1tZTJ4UUNyN2V1ZkJCVFhCM0R3STNiUlkyV1ZQNXJSMnR3UnIrdG1n?=
 =?utf-8?B?clNpZzdTUWpEVjA0eG1ZbUlERkFJK1cxcFVvUlE0a0VDeFpoWENiVDZnWXQr?=
 =?utf-8?B?MDVJVHRmbHNrUCsyUTh5QWlZRVJKVCsrWVcvY3ZyRVJUMnlWcVNlbVU0L1JC?=
 =?utf-8?B?YnlNd29qYXo4UmJBUjk3NGp0TWJ6SjNtZTlFSy9jQWZrMTA5cHo1dzZlaUFW?=
 =?utf-8?B?VTR5eHFTMmk0eDVaV0VkOWhJbFZNMVNMaWxaQTY2OTd1azhDM0ljMFMxS3A5?=
 =?utf-8?B?UGREbmZJWTBvUUttWUZCeUZwMDgvZFY4QzVkT1ZSVEZYODZCdWtnQWNyYXRD?=
 =?utf-8?B?VWxTZVhWVTdWd213anNOUnpmTkl1c1E5a1AxRXlUb2h2dEMxN2ZqUzIvcUdC?=
 =?utf-8?B?SHFkRUlWSG9PdmlDQ2FPTTUrRlRkdmxLeHVXTk1UdHA1Ky9yR3N0dUZKNlJS?=
 =?utf-8?B?MXZVY1M1QTNCd0xxdFpRWTNkQ0NlNjlBTUJqRWoySk9zTG10M3ZMb2ZqMFVh?=
 =?utf-8?B?dU15aUxKU0NRcHpKY2ZWNllkN2JHOG9PM0V2QW4xQWVHRTl1T25USUp1YkpR?=
 =?utf-8?B?Yng5NFZuRzhMQnphZTROYUtabXR4clFGS21GSUhPazF1eStTTHpRdjdxM1c1?=
 =?utf-8?B?MllpejUvdHZRdStZZHlxSHpRbmRMajVHdmVMUVQxMm1BbFVIcHF6aUEzMGhS?=
 =?utf-8?B?NmQ1TjBQaHJUUUQrWnJOMk15TXFkSlpBRzU5NUpMVzNpRmNCWXVQdTh0bHJi?=
 =?utf-8?B?dE13STk3WncwSW1tdVZaR2x1VFdXa09hYXVHZm13bHVVcWQ1SWhmNFlIRDlP?=
 =?utf-8?B?WTZWN0cxaUpPWVkzbTBnWlRlZE1xMm1zcTFNSWNkU2lVSFpoSTliQXczT1pZ?=
 =?utf-8?B?R3IrTjFKUXdFQ2JGeW0vV01OQW9NZGRyR1NCa0pGNzZLUXpkV0Z3empYb1J0?=
 =?utf-8?B?UWs4WHVkNFp3bmdKbUxkdWNjcEl3V01YSGlWazhjUFlrSXhZVm1nRC95cHg5?=
 =?utf-8?B?cVMvNFdXc2pOSVkyNHJYZFp0NElZbkJOQ3U4VExLZXZnR2w4cTNNNUVhcUFD?=
 =?utf-8?B?TDRieFhqa2RtZG45UUlkc3ozQVZpdFZ3blYxRFZidmJNNVM2c3pUY1pEZjVr?=
 =?utf-8?B?cUFFcjJmYXpVQU16MmVUOGlza1o0VWV4Yi8ra012OHd0c2pQb1lPcy8xTUNC?=
 =?utf-8?B?cGdpaUpIaWtwbXpBeVNrUGJXSFI2SlBKV0h2anYyNEUyWnJVdzJCQzJlWE5K?=
 =?utf-8?B?eXdoTFpwYS9sM09XNS9xaTFPOWJmMFY0bDBlZ3JLUlcybWhCWkc1LzNVMEt5?=
 =?utf-8?B?ZStiekVPNDd4QVRqZ3ZpOVB5V2Y4UCtpdkdrRXc4ZFFqdG5GWFFPWUpuNzRB?=
 =?utf-8?B?Y3p0UFhBcnhOQmVibHp1R3ZvTU81aEtHL0grTnlLclVadXE1ZEdIU050L3Bu?=
 =?utf-8?B?NjNBd0hKdzUzcU5yNE4wY2xQNXhmQWw3akNaalRNZlkwVDhZdllxYXFjUEo5?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b04fb276-0ea3-451b-6a99-08dd96ecb3f4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 15:49:13.3474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD8jBAW2LMyx1BMbE+ax9M/JQ0fMqZCANGLMzWBQ4ox9daGg1YMNfoR8ozEptMN83BGz+YAeZ8UMvEvCXw5N/QmmfZiixId0ExO6DkhXUU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8285
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

On 5/19/25 5:43 PM, Tom Rini wrote:
> On Mon, May 19, 2025 at 05:09:07PM +0200, Quentin Schulz wrote:
>> Hi Tom,
>>
>> On 5/19/25 4:48 PM, Tom Rini wrote:
>>> On Thu, May 15, 2025 at 05:55:44PM +0200, Lukasz Czechowski wrote:
>>>> Initialize the debug uart only in case CONFIG_DEBUG_UART is
>>>> enabled. The _debug_uart_putc is used internally by debug uart
>>>> functions, so it must be also included inside #ifdef block,
>>>> otherwise it will cause compilation warnings.
>>>>
>>>> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
>>>> ---
>>>>    lib/efi/efi_stub.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/lib/efi/efi_stub.c b/lib/efi/efi_stub.c
>>>> index 40fc29d9adf7..5172cd78a7c0 100644
>>>> --- a/lib/efi/efi_stub.c
>>>> +++ b/lib/efi/efi_stub.c
>>>> @@ -83,12 +83,14 @@ void puts(const char *str)
>>>>    		putc(*str++);
>>>>    }
>>>> +#ifdef CONFIG_DEBUG_UART
>>>>    static void _debug_uart_putc(int ch)
>>>>    {
>>>>    	putc(ch);
>>>>    }
>>>>    DEBUG_UART_FUNCS
>>>> +#endif
>>>>    void *memcpy(void *dest, const void *src, size_t size)
>>>>    {
>>>
>>> I notice that this, and the uniphier implementations are the only
>>> non-inline ones. Is the problem we later conflict with your changes,
>>> perhaps because this wasn't marked inline? Thanks.
>>>
>>
>> https://lore.kernel.org/u-boot/d63d53bd-3f63-430d-b0bc-2379b7bded81@rock-chips.com/
>>
>> so essentially
>>
>> lib/efi/efi_stub.c:86:13: error: '_debug_uart_putc' defined but not
>> used [-Werror=unused-function]
>>     86 | static void _debug_uart_putc(int ch)
>>
>> I tested by adding inline and indeed it fixes the warning.
>>
>> Somehow the non-inlined _debug_uart_init doesn't seem to be triggering any
>> warning though.
>>
>> Would you recommend to inline the _debug_uart_putc function instead of
>> guarding the whole thing with ifdefery?
> 
> Yes please, and also fixing up uniphier for consistency (it won't have
> the warning because it doesn't descend to that directory unless the
> option is enabled).
> 

I actually added an #error in the function and it is compiled and 
doesn't show a warning, so not sure what I'm missing?

Quentin
