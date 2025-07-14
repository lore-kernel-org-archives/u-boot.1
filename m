Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F308CC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 09:38:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5484282CFA;
	Mon, 14 Jul 2025 11:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GGGYjdvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF7882E52; Mon, 14 Jul 2025 11:38:55 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D09C382B07
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 11:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+ToCgLHxodgbZwBKoR2MprYPWkN5ibtcOigQufhaxu06vo3nZQibwa1qVMm4rxcHcu6hzY5mmU/8Uw8n7wkAdyqbvTe6qWMkIJMbY8mp2BVYKaFUDGucCKQ3wdnT/knUmIEnvSu3UjsOyOAI+QX2ivRSYGrQ+jBH+6j7AnBw0ik9KtBGXEUhCdTh63oV7yFA8HWmNd9ZFGY2eBCJlGk3e7e97mCXS1w3LKqWl862Q3VO7vmiBx5w6UjEGitxH3YvT9C/1y9CtAhSd68DQHWQDdfIJUNYcj4WZ4UdcOemVstQTZcduHywN5gus6o+ChGN4Zhe1GblXGwko/EBROFNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cHyG2E1+skECNTg2CicSm45DXr+EgNdykQTCB7OLmw=;
 b=HSxubXYgMMCkFapIX318sC2NElL8TmTB1mCWEtA4lUOsefH0TDW8zv4u4aA/aWmOqMZa1inL9d5wdWtwEmUi3ER18dlqwrM7OwYKXEmFmn60mYd0LZArrleMW/a3KwTYtjmt+KuNdXyrFqVUWO/1DvfMvzvR3b22V1AJiA/OOqpQAVJT9HnaQ08YHalJeLvwrpWgkjlHRm7557AXKk8HqkLM1L8aWoV8mkrUXw57oGIKejriZkoZOKX8l7uTxlp4DEofSO04TMoHhHsthDp/mBPSORFT3hU4Subd5ZvZCXG6DaoDpuuQNXzAz4NU0/3T5KsT+XWDUHwzmeUuFIe0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cHyG2E1+skECNTg2CicSm45DXr+EgNdykQTCB7OLmw=;
 b=GGGYjdvgi+/mwl5/FBZbRoMaxgK4C0IgUvFAyky8Kd69gDeofgQK1Hph8uFR+MlfPoRU14+Rztuxey3yCUNglrC3bi/3g9aqU7Lmc86un1zgBMDl60vQOtmVmSlZr2Zq1bjPRceMPuTgkIw9AF1JxnNHubgLQZKvnyau0LF/B0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10815.eurprd04.prod.outlook.com (2603:10a6:10:585::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 09:38:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 09:38:48 +0000
Message-ID: <bc1b66ee-5035-4ea2-bc5f-48bc155f5a79@cherry.de>
Date: Mon, 14 Jul 2025 11:38:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add support for rk3588 MNT Reform2
To: Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
References: <20250630102524.127970-1-pbrobinson@gmail.com>
 <CALeDE9OfDKLoHmbwOdUnB=GKph2vzZDAFqpcgtX5rbcH_qXg_Q@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CALeDE9OfDKLoHmbwOdUnB=GKph2vzZDAFqpcgtX5rbcH_qXg_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0077.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::30) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1067236c-7d7d-46b0-8b8f-08ddc2ba3bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0VRd24veml4aUlnZGF5UGROc0lMSURjZmw4SSs0TVh2OWhHSGVPaFdHTnFu?=
 =?utf-8?B?cVFMWi9ibENrVm1UeXJjZHAwRGhPaDRxZTZzTkpKc1lDai9iWkg0c3A4NGV0?=
 =?utf-8?B?TnZVVzFld250cTBhbGR2dWxBdHkwVUlraldDbUxlNjFLWjFiQjBOaU0xaEt1?=
 =?utf-8?B?TU45dHpPUW5XeEdhbW43SHBLdzU4RXIzTEgzK1oycytTRXF1U1lPWHBaTDFp?=
 =?utf-8?B?WVAxdkVpZnRyZFFtMmlOT0d4UEo0QzAxd29oaCsxbnpHVU5TVDBYOHRidDBj?=
 =?utf-8?B?Zjd4RVdWNW1pUkROeUdWK2RYSC84eUFydTNsZFoxaGtsa3hxY3R0L1BaOUIr?=
 =?utf-8?B?anYwUHhjUXFqS21rM3J2VlYwRlZDRTMwSUhZT1UxNzRHa2R3WUFnWkc1OGZy?=
 =?utf-8?B?dW9MWkszdi92a2xUK2t4QTJlV2JpbjYrb3hYQzNTVzRLT1Y4Qm14RE9ZY3hy?=
 =?utf-8?B?dzUrejRPOElNaERyZ3gxVGhnVCtaVWExN21RYW96ZHE4MWdKVENCM0lRWVZl?=
 =?utf-8?B?QkRqV0RIcTRKTlZpRGo1VHhRbHFmMnV4MVJvUjEyUTdpRDhKM2s4bG9VL0to?=
 =?utf-8?B?am5WY1NCTkFrZU9vMkg2R2M5SjYrazRPeTdtR1N3cmZnZFJvdDRvQXQ4Wklk?=
 =?utf-8?B?Rk9YbjMzVUszVFNqV3dER29MNzZSTnNZVGthNnREWkU3RVlXV2g5T29ZR1cz?=
 =?utf-8?B?MUZyMTNVWkl2dnZZRGpwcVBFYkpTOU54QWg1QnBxZGxIb2J3QWtyUkZxTEhW?=
 =?utf-8?B?UlczL1pFcUx6S1FBSktQVW9YWFBzSElRM3dUMi9pUFVhd2c5TWdGN2xzTzBI?=
 =?utf-8?B?N0ptQUJiRTVRK2VVaFkwRS8vNjJMaE80WjQrcW0zY1V1WXY2eUdyWld5OHVY?=
 =?utf-8?B?aFhzblMrUTQ0djhXVXYySm1Sdm1kZHJVNUhYVWZ0OHkxd3h4eEozTlN6RXJm?=
 =?utf-8?B?SG9oUWRLdk1QNmZzbEhRMm1UREtvdmFVY1BROVRjYkdFY2w0eVFlcFpqUEtB?=
 =?utf-8?B?Z2JINTNvQjJneUlSaDVLMDJsYTN1emM2eWpNM1JnUktLM1JpWnExa2NEcmxD?=
 =?utf-8?B?L3RCWFlrSVBvRkFrbk1kc0gveGEvOHpRdVVrT3V6b2pZd0VUUEl0RGJmcDc0?=
 =?utf-8?B?cE5nQmJKMTVGbk5PSDB1RlB5UWphL1cwUDVQdEt2VHhIL1Q5OVE2MGtDYWNW?=
 =?utf-8?B?NGp6SlZsbWxlL0xLSkM0NjNhK3E2UDRtVk1kVFFOSzRpdVhsekR5SmMrNTdO?=
 =?utf-8?B?SjdFYkRpZzIrYUJ0ZkNqVVlZeUdIc1RzOXgzakV5aFRLdFRFR1ZtQml4dHVy?=
 =?utf-8?B?bXg2aXdEK2FlU1pUMzFQNHJqRFd6U1RRdEtJR2dMVE91WjRhaHByK0VRTTc3?=
 =?utf-8?B?N2pCNmQrWDBINzBiUm9UeUV6bUkxL3Z6UUxEM2l2amNLWXEzYkJWK2FKQktY?=
 =?utf-8?B?bmdwZlRQaTZLOWtIUTJSaUFhQXhBWlFiOWUzbWtrMUk0ZE00ekVnMG13a0RT?=
 =?utf-8?B?eWhzaVZ3RGtIR1NoMmFpNGl0YmpnRWJaRmFUc1hrQys3MXR1UVdLRW5sNHYv?=
 =?utf-8?B?SVJUbEpseVBiM3kxYXlWSzhxbVBNUitoTE8xTEJTZ0ZLNkJCY0pLbklKVDJx?=
 =?utf-8?B?bUZId1pTelhSUThrV3FRRStVK2ZyMmtidmtsb1IxZCs0R0FleTNRYVRUeWZo?=
 =?utf-8?B?N2JOVXMrQ2RKd3QwdUpMNmZINThrM1hmMk1IQldPMlQvTzRUV2pPWlIzbjgw?=
 =?utf-8?B?azRRdDZFMytoWmVVdnVTbmNKTmNLRGl2dTA0ZUJIZjl0Y1RYaHRqd1lBTmUx?=
 =?utf-8?B?bDFwSVJrQTBlcTJMSjFUMi9DQXdvV3M1MGg4Njk1R054dTd3S0Y4cEdOcnNF?=
 =?utf-8?B?RFQ2ejVsT3hJeUZCZkFUS0hCYVlOSGFuTW9yQjd3M0U3a1QxajdoUEF2LzVX?=
 =?utf-8?Q?ywvTjQIXPtM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlFnZmIrdXQzckgvS0Fmc2k2a0ZzajVSWlFuSnZmVlc0cS81VHB6RzRldGQw?=
 =?utf-8?B?NlI0OHJSdDhoMUM4eitmNHdtWkNkbGZCNHhQOGcydXc3YjE1OFBpN0xmVFVL?=
 =?utf-8?B?SDhQcWFSSVcyMEdlWGJGK2xuY1FsUnlGRU9aNlVpNGplSlhZVVd3dnIwRHJJ?=
 =?utf-8?B?ZUp3VFUrOW9qckh5SzhPYmJZa2FuYW9nbGZDVjV1eGJPdVJYelltN0JFNmtQ?=
 =?utf-8?B?NE1ObHhBNVY4Qm0xckpXU3lscU53MUk1aE5ndmtQTElNUDMzK3drZWhHRm9x?=
 =?utf-8?B?NEZwTUhCR3N1dERPQ3VoY2s5ZjRHS3R3cjRBajBpMHMvUEkvUjMrZmJieGV5?=
 =?utf-8?B?SWUzNXhSZG9WRUtwSDcvczhoNjFKaExBMjVPL2NFRWtRbFFrM3VRQmpDYVNF?=
 =?utf-8?B?RHdMTDhLS1VVbWFkSjlaUXplZ2p2K0pPbzNZMmtkWXdpdXdwUm5mWTZNdHo2?=
 =?utf-8?B?THhjM2l3V2luelRnVE9uV0FkcXg1bGllZXVpZ3hUZ2E5YUVma2xHc044cUZ3?=
 =?utf-8?B?Zm0rcStONHRaTEZ5MFArZDFjZzczWWx1M3NmUGFCZ0lvbkJuQktRN080V1Ey?=
 =?utf-8?B?dnlWRlpPYVZHdGVkUVpEdUZZS2V1V2p2WXQ0WnFzSFphdGYvTWsrb2xodmhz?=
 =?utf-8?B?VXVSSGsxV0cwazg4Q1Z5RXE0U25HSS9NczkwWHBKbmkwalFYV3V4S2NMaVMv?=
 =?utf-8?B?VkxONWtaTFNudzFGeTlwaVAvSjFTMm0vMjhNU0xRb2xSL3B0ZW0wY0JYVHhi?=
 =?utf-8?B?OHp6VElBWXN1WVI2eFl1T0tMb1I1TitxY1NEOGdKbk1hOUdyTkl6OXJ1ZTBl?=
 =?utf-8?B?WnUyWDBsQkFLV0dhR0p0UXRnYjBrMnU1QzhGT3VKcHlrN3FtVDN2OVZHSkVV?=
 =?utf-8?B?R1VLRWtrV2Q2cmw4VTd3MWxMOUpXcnYzMDh6VHlDeVBLYTc2NkE5ak5wQmg4?=
 =?utf-8?B?K25tejNRbmVaR3hYdm1WR3BFNUUvaUxQZGtTWWRNZUNXb0NMdDFKNk9Iakcy?=
 =?utf-8?B?ejZxTXJqTnl6NXFsMkR1aXFHVnJZZmlqYUZ6dkJ5WFJYWHM4dmE2dDZXYUZl?=
 =?utf-8?B?K3NpTFFVS1dvc1cza29NeGRYclliakNjbjhoRG9qNzRqNXNpcU9tc0ZHMzlV?=
 =?utf-8?B?VW5UTkdBcDBhemVBTWQzVlFDbWlneXg4RGxWRkUyRk1ENFlSNjRCaG5JaVI5?=
 =?utf-8?B?T3BJSWt6OWV0dVdCaWRBaVRDWEpUS3Q1dS9mZG4xNk51bWdWYTJ2UUlCUnZo?=
 =?utf-8?B?bHNQK1BQeDRhaFkrTUhReW54aFJ5ZnBidldOQ2M2cGUyT0drMEliTDZYYjlt?=
 =?utf-8?B?R0l3NmpTTlZFUmFPSGhlOHJVdmJyaC9rbVpkVFpYdVIrMy9Gc004enZtcGdv?=
 =?utf-8?B?b3NyUUlLa29tSjFZaFd5bTBvL2UrKzBBcm9iek5EZWhLaVZjVDFoeEttczYw?=
 =?utf-8?B?eCtQSTRjU3JLUWMycy9GZG5mWlJHclBvTk1uNElIcnFkaVkzSmFSRFJQMnpy?=
 =?utf-8?B?T3VqTWZJaCtlZkR2ZGtXNTl5NVdOcDJTZjltZXlxcTkrTVRKbmI3L0tObkFa?=
 =?utf-8?B?UEEzdU5JOWVPdkxFWnZnbHhseFltKzIwS0N6WjdCRU5adlpwMGowWVM0OW1D?=
 =?utf-8?B?SUNmT25aSXlkK1J0WEo0UElkTFg3STlmb1lrd2E3WjE0V2w4LzVzV0VOc293?=
 =?utf-8?B?Vjc4U0RyQ0l5Q0NlSDRNRGpPbzRsaWFwczA5K3FkcXI1MWFPVHd1VFJDdC8r?=
 =?utf-8?B?ajZnQ3FlbnRCZzI5b3NidW5DNTQyWDFnUTg0NXA0TUsrMStidmlhakNQNFpl?=
 =?utf-8?B?UEh0bDhndmJMeWxPbHhRNzdoZXo2Nlh1dmhhTC9JM25TNU10Z3liMDRIZTRY?=
 =?utf-8?B?Zk01UEpUTU51MUZodDRPakxJVWRsODV5d2l3VFU3enBzU1FMdDZZYmZ0VEdP?=
 =?utf-8?B?RmlkQzBmZ0NUQzlOMS8wSlhhNEJ5QTU1cW5sNklXWDVSY1BUMU1GRHZmMXRU?=
 =?utf-8?B?aFFIVnIrK1p6Y0JJQ0x1dUtRMHkyVVZwVDBPbE5WSUxodG9YbUhXUDBqNWhF?=
 =?utf-8?B?SEFUQlZYQ1plRG9ZSTB2TXBrRFkwM0ttaTdHQTY2a1BVMlpQYVhBb0lad2x0?=
 =?utf-8?B?aW01MDk5UFpZSUFKcDNPYkNmSGVuaFRvakdCdHRwanNkbFRpMG9FZ0VDVVlV?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1067236c-7d7d-46b0-8b8f-08ddc2ba3bbe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 09:38:47.9829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1Qr/hcZk1YYeJTo/0Tm9lgiVEFGkcCEBYkQVyF4eVk87PVVCJoGv9SzfUim/7rJ2XazRLF6DCN1hM+uF7aKzvL7HNxTr6NIQVkQM2tLpKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10815
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

Hi Peter,

On 6/30/25 12:26 PM, Peter Robinson wrote:
> On Mon, 30 Jun 2025 at 11:25, Peter Robinson <pbrobinson@gmail.com> wrote:
>>
>> Add support for MNT Reform2, it works as a carrier board
>> with a Firefly iCore-3588Q SoM.
>>
>> Specification:
>> - Rockchip RK3588
>> - LPDDR5X 16/32 GB
>> - eMMC 128/256 GB
>> - HDMI Type A out x 1
>> - USB 3.0 Host x 1
>> - USB-C 3.0 with DisplayPort AltMode
>> - PCIE M.2 E Key for Wireless connection
>> - PCIE M.2 M Key for NVME connection
>> - DSI to eDP panel
>> - 1Gb Ethernet w/ Microchip KSZ9310 PHY
>>
>> Tested using Fedora boot on USB stick and eMMC.
>>
>> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
>> ---
> 
> I forgot to add a note with this that the initial SoM and mainboard
> dts went upstream in the 6.16 merge window so should come with that
> rebase.
> 

You could use tools/update-subtree.sh to cherry-pick the appropriate 
patches and not have to wait on the 6.16 tag being pushed to 
devicetree-rebasing and then merged into U-Boot?

Considering 6.16 is likely to be released before -rc1, maybe Tom will 
merge the 6.16 DT tree in time for 2025.10-rc1 in which case you could 
just wait for this to happen instead of cherry-picking. Up to you :)

Cheers,
Quentin
