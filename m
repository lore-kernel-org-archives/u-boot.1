Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FF3C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 105268329C;
	Mon, 11 Aug 2025 15:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nLQP+Hwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00445832DD; Mon, 11 Aug 2025 15:24:28 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F138311B
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zqp6s9oXdYZOnw+PJn2zpF7R0TbgBA7EIlv9W8WT42iqN/si4gdv2wGl0aIdoLSyRABuFbWDy4hwjZ72B1hQLWHca6CPG834mrzYABiCfDVCR5qPLqPqvwQ3Fz1bPBGENFTPIPMS8cvcV8mWBzoT1zVyeskHWNQf+gJ0ONzvikA5Pv6GQjOSWe4jUqcullu5ObNalWKms4bYWlGcBr3+ajPs0oxjox/TR8pNoC4+hV2nQz2dIksQ0Ds6PC9aQjWLZwJW48rcsas/+sLR5B5YQDVtsfIrFN3HHgwDXZzfWdaGGNmvC2m/KJ3mq3bZvtnlanWb+DDpB2OwKZu8xhV4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Gg7gUfc/8mo/GOYb92rfQxT9tqC5iOjV+k7RJE0nFw=;
 b=hhMqFKtfJOF5S7AJGk5rtHDVfyjpNOGRLhGxzPC1RWihNCoWS2SBgXP3/tmOkPxSZZRP/NKfzY4kszENUJ/6OFEFpXSBl5unqi6t/svoXQX8igR+9qHINJIiJqwCbAtKRSr9hUIQsUne6I/fcLZO/5BENKzltDoYv0QWH5cpFKnidig3T0mCdVkWigYSk9/oumdxubq6JcqAVCUWzMgwQEyOq/Z+VSUBdzMezIdZU+kpQIL+dM4+0zAHQcXq5XjP1KONlrSrIUuldB5b2UwmJaBezv40vEJi0Kn6Bl6wQ3zZ6jSf4OLw1h+uWPiMyQQcZXMpRLzoyCVe+Vaz1TS5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Gg7gUfc/8mo/GOYb92rfQxT9tqC5iOjV+k7RJE0nFw=;
 b=nLQP+HwaQ6F6dERL6USeyjRKkGb+D1BNsY9q6pxbw9uG2LpwFvr/Lb8eQBwmKgg/PM/llYh1JXOfO6C5diVTEINNlWrgK4VQLVZ8UFk5IJdKUhmuD1zzDAYhfTJOsV4Fk3zg2byFf815uinx1gcHMS4QqcQDxGrWSKJrkCnqEfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 13:24:24 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 13:24:24 +0000
Message-ID: <fe9042a1-20db-4011-8af7-e0eee51fab5f@cherry.de>
Date: Mon, 11 Aug 2025 15:24:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: renesas: r8a779g3: Describe generic
 SPI NOR support on Retronix R-Car V4H Sparrow Hawk board
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20250806144727.7006-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250806144727.7006-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9626:EE_
X-MS-Office365-Filtering-Correlation-Id: 6185b337-052a-4f33-87cf-08ddd8da63b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3J1YmcwSmlBUEZQK1psMENYOEppZEIvYkpaUHc5TWxFM2RtWlU4L0V3bVdn?=
 =?utf-8?B?eGVDQkU2THpsdktpWHV2U2FRNGFFN0pmbWJ2RlczQ2NkRGltaEFoVWtxbm5a?=
 =?utf-8?B?ZW1lQW9Uc3BMNGkwcEYxd1B5MnllYVBoTHVMRFBMWWZ0cndFemJSaWYvODZE?=
 =?utf-8?B?cktUOG9OMFM3cDlrdFNvUGd1UnNiMXB6L2J6cWh5Ky9MQkI2RXYxeUtSemZ6?=
 =?utf-8?B?YVEvem8zRllITXVIS3MzVkJLZGRlTzhPS2VFbkE1NW5NS21iSkNBeU1qQWRN?=
 =?utf-8?B?YjlMYmlreXBhOTVOcGg3Wm1ERjRVODd1REpRUlROdDBVMjI1NHF1YW5IT0JO?=
 =?utf-8?B?TVkxUnpJejY5ckI2cWw2aXRjNTNGL3FCVUk1czhsRENOTTJpYVlENitDYkRa?=
 =?utf-8?B?dTlxQ0ZCVVY4SE51cE9WSml6TnN2aGYvTndlbWpXZXlELzF5aGx3OUx0ZHdi?=
 =?utf-8?B?akk1WVpuVGRUWUZ6VnBsaTdKU1laMDNpSGVKeW1xRlFtSXpxUStkSlFzeWxC?=
 =?utf-8?B?Y1pFRE1hbTE1VlUyN3hqMHZNb1FoTGo4M3NwdFBlZTV5Nnlxd21kWEdkZzVC?=
 =?utf-8?B?bURldTAvVnpaSERkdy9XRmNxRzhVTzhrS21ra0RZNm56cTdMazRQVUVtMXZw?=
 =?utf-8?B?UFE5QXRxbFIwUk1ubEhTYTVsOFo3aG81ckFSNnRQbS9MY2NpN0EyRWpsUlpw?=
 =?utf-8?B?M01xWmVsaUVoMCs4cE10M0NOMmJmY3VVYkg2NnRScVFxVDY3M0Y3KytuRHhM?=
 =?utf-8?B?MEFieS8vRDVEZ2RyakV6M0hUQ2d0SnB5WktXQ1l2YVgyVUtxbmg4SDNWMEN6?=
 =?utf-8?B?TGpTK3BJT0RmMkN0czl5QkM4TnppMmpCNm0rT1h3cDN0aWUwRjF3MEhZaHJK?=
 =?utf-8?B?RXNma25RRVUxL3k3Vm9mOEVLakpYelp5aDdSTUZ6SHp1WHBXSjNlRS9YMTZG?=
 =?utf-8?B?THhpcnVHQUM3L1FreWRSYUgxaWI1UCtScWdIWnZtSWFuTWxqU0RDczFPam9j?=
 =?utf-8?B?ZlJxYnA0ZmNlQ05sV3Y1NlplSkIrWDIrWDJVeXBuMEZ6M09rRE96eDRmT3RR?=
 =?utf-8?B?VUlETDk5MnpSMjFOb0VpampTVXJwUGhPb1orZll3ZjV5Y3BXM09CYnVEZTdp?=
 =?utf-8?B?V0s5bS9DaDlqSHFacVp0bEFFcGxTYlhwUTlxMVhtSEdLQ3c1OVVBREdNcmVi?=
 =?utf-8?B?cURqMFNPcEhTMElHWEl5NDdYQ3U5cjJvWlRVVDRrRDllZGVFeFZJQm5jM0JM?=
 =?utf-8?B?dldrbloxMkF2SGNEd3dDR2VHQVBIdFBrcUdURDQyWlpzNTdnQ1RJKzF5R3Nv?=
 =?utf-8?B?UTFqTUtkbk1PZm1jS2dzWFpSdzRnbUE3VjcxUDRVbFliRENHbHIvWkRFWUIy?=
 =?utf-8?B?eVZXbmNjS000TDIzU1plZ2tlN3pnM0lXN1hoTFMrK3A1ZzAzS1RZeXFBZ0Zr?=
 =?utf-8?B?UDNSb1JWQnpZMUd0SHpjRVVxOGtpZTlUTCtkRVp4NktZUEV3dG9WZ3pEL0lE?=
 =?utf-8?B?ZG1wL1hyRjVjRHJHdDYyMmVPMktiQjhHalAxRDYxK2JKZlhHQ0srSndOTm5u?=
 =?utf-8?B?OUxRUTFzd1pNTUxzaW1IRWd2b1gwUWhFUXIxRUVCcERZQlR3S2MzSlZFNGw0?=
 =?utf-8?B?aEFObjZsVWE5eTFGZVhkTjhzMVk1QWZGN2hzeFFyUWR6SzNWcHJIZEk0VThQ?=
 =?utf-8?B?ZTZRT3VZc3p0VDVWQzdML3h6V3BuMFpVSHNIT3FOVlJQa2VHc1JTTzFhby9U?=
 =?utf-8?B?U1pTNU41anJ2c0hUQ3RqM0lwcGE1SUpHQ2xnKzB1SDJVN2k1UFVTM3lKY1Zv?=
 =?utf-8?B?SFNHSlRQOUtESk5wb05ZS01tRjBLNnlUTTZGRW9sYkI1RGhVS0lndlE2MC96?=
 =?utf-8?B?d3g2MmtITWFzY0JBYlVDK3h2UzEwd29ZMlpTcVpPUm1xbEIrRnFLeDdwMlAy?=
 =?utf-8?Q?w711jA94ER4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3o2bFM0ZjBZRUJtRXB6dmdNbGZBUmtwbTBvTnBEbW1zLzJRbTYyNE50ZU1H?=
 =?utf-8?B?ZVJZU3NldnU1NGFnc0JMRWhFODFIZ21YYUhGdGZZa2JjK1NNNktPM3Y3Uy9y?=
 =?utf-8?B?QndtUTdXWlZrSFAvNXRSQlhFRy9pcWo4T256RUJpVndCdHNOV3AvUDZVaktD?=
 =?utf-8?B?Y0cvMENhZ1MvQjZrL1hvTmt0aThvUncyQ0JhN3JlelU3THg5VHpSSWhsUUxy?=
 =?utf-8?B?TEY1bDRmOWliVWNWNXlkNkdmcE5BQ050clVXS2NoS0N6QnFNRHZKSjlsVWZO?=
 =?utf-8?B?Z1RQWjQ3aVZxdG1LbWdTNU5lNm8vaFBNZk1GVjM1bmx4aUtvSVgwVnZERkts?=
 =?utf-8?B?aytmM0xvdUhzbDZWRlNnNlpwRG1OSXhYT2VxTEVmbUtGSHpQY3RXYUliQitR?=
 =?utf-8?B?UnQ3aXd3OVcvdW5CWll2N0M2Sm1FUjR3eUVMTU9MaDZvRVBNU2p1THJxRXFo?=
 =?utf-8?B?c1RHUXpDdFlWY2xpTm5JYkE2Sm1ScE1QbnRMZGhVMzRwWUFuTEdsMndOeWN2?=
 =?utf-8?B?Rk9IaDNGZGM0RVVKMDRTZGlnYnVZS3NKdmRwaGVrdkREUU4rcTFKUUROODhD?=
 =?utf-8?B?VkYzaDR0OEtGMTZRZnovbEdrOW9LVzRpbHBBaGdmc2FxUHlLVS9COHhPUWVw?=
 =?utf-8?B?RkxWV29vWmFYcVdKeC9sYkVoZmREY0hETDk4NG4yOEZVbmxQSWlqZXZ3K2RF?=
 =?utf-8?B?R0M4QU44djRJTU5lS3FHTjBlcmZhYlhpWFludDlNa3hUaGFMVDFERUhiVlRM?=
 =?utf-8?B?U0xSc3FRRC9zMk5saW82T1Q1QWRubk81WnVoT0JpVllzQkFROGlab201Ymhv?=
 =?utf-8?B?bTBrbFJSQ3VzUWRwb1ZWUVpaay9mcm1NQ0czNHhvRW5KRk5JWkc0QnJKUGk1?=
 =?utf-8?B?Tmt0VGpxRTdjblJsNHNTZDZZVGJuNnJKa0NqdWwvOEFUZGwwYmFSNS9WR3Ba?=
 =?utf-8?B?RXhkQkxXdXJ0QWFqbHNKUlVsM1ovd1FuWjhrUmZQYUdSRm5NT2lVVHlPTE5h?=
 =?utf-8?B?WmFsbndrKzVLVHd4Wk1oZWlCL3d5eUlYTUlTa0FXSWIvaSt2L2FYKzg1bTlM?=
 =?utf-8?B?MFFMWWt5bEloQVc4N05IMWdXNHQ3VGVvOEw1TFNFTjhtUC85NE1rVGNVdVlG?=
 =?utf-8?B?Sk90dGZtYXNlaXJzLysvY2RCNnBvRVpPVGUvRUpQUTFHN2VxaDZxYURmK2g5?=
 =?utf-8?B?WEtvZ2lYamVtc3JNdFJicldBTWVKNUlueWQ4WkxrRzljelBCM0Z5WmN1eTQ4?=
 =?utf-8?B?SlFCNitQaUxBNHBuOWlNQnJFeTJ2dTMzRWxBT2NFN25HcXRidlR6TXV3RGU1?=
 =?utf-8?B?MUtITVl3UU8rNnlhbnNGSFU4cExlUDNpUUpmdkNPSEVyVFErMXhvVnNnUFpn?=
 =?utf-8?B?VHQxUW9aUUNKVDZoTVZvZ21Id1JOd3MrbDBmMG5PYXhsd2hNKzliQlF2Vjd2?=
 =?utf-8?B?QjhqbHU3U1MvZXRpVjFaMjlrWVNsWXNQSHJJREpHRTJOeGdRdldjcDQ3RmZP?=
 =?utf-8?B?YnRFbU5yMG1RcWFjaEtIVGRnWDIybWVUM1U5RzU3K2p1cENrODd3eWwzOHBw?=
 =?utf-8?B?T0d0eUNtanRNUGhZTFk4bjRBamE1cEU3Ni9jV2RoQ3k3NTE2b2NwQS9QYTJn?=
 =?utf-8?B?cjVJbmJFTDY0eWwvNEVLbHlya2F2YW0zR2RUaGtocUJRRCs4bWpsaHVEQlQ1?=
 =?utf-8?B?U2dqOWo5M3VSbkRlNHF3aW5IZGx1cW9JRVZDTWFBSFlmR0szdkp1NWpTbEgw?=
 =?utf-8?B?QytlWXYvVWd6d2pyWW5lZmR1UVhyTkVjYXNLRWJhcnJKcVUyeXFGbmVodks1?=
 =?utf-8?B?V1cwSkxqaUNNYkFldS9nSGtVQlNaR0ZDc2xVQURQNmNycngvMCtDOGpWT2pr?=
 =?utf-8?B?K1pxWFN5SWdsVXpBNnkrV2ZqRzBtc3d4cjVFb2E1Tkp0REZqZUlaVXJVSU9G?=
 =?utf-8?B?WnNEVnlEVVJHZlAyNFVpL3ZPWFgrQTltYTNQTXRIY0JqUnB2aFFJTm1sdzhO?=
 =?utf-8?B?R0hkdGhJbFltZEs2TGpxRWhVaDJzMTlvR0NtdzVDRXZXV1FWbGpoRW1zVVNj?=
 =?utf-8?B?aTZkZ1U3SlJGWTRiSHEzZVN2ZTlWeXVSdlZTR3ZnNS8yaFZVdGJoK3RNY0Y4?=
 =?utf-8?B?QncxQUVTWlhlaU13OUkybVVJbkpsbllWaStadW4ybjFaRmREeEZEbE1hUHZu?=
 =?utf-8?B?MU13NlA3d2pzVWtPc2FJWm9IU01DZ0h5RHdvL3hNQjlUeDMzVmc5YUxXM2xH?=
 =?utf-8?B?TWUyYUErTlBtemx3WnFXbGg0S2NnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6185b337-052a-4f33-87cf-08ddd8da63b1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:24:24.4700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVmp1WUGX9b875yeTHwBPFz2exqQTAIc63a6jEWaVHl1TirpdA0iy/yiOJTm3x6txTRsfWB+yC27umZK0jKy1My4OFmWxMJlYl1tEn+3g+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9626
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

Hi Marek,

On 8/6/25 4:47 PM, Marek Vasut wrote:
> Retronix R-Car V4H Sparrow Hawk EVTA1 is populated with Spansion S25FS512S,
> EVTB1 is populated with Winbond W77Q51NW. Describe the SPI NOR using generic
> "jedec,spi-nor" compatible, because both flashes can be auto-detected based
> on their built-in IDs.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Update commit message, s@spi-flash@jedec,spi-nor@
> ---
>   dts/upstream/src/arm64/renesas/r8a779g3-sparrow-hawk.dts | 6 +++++-

NACK, only cherry-picks allowed in dts/upstream. Please use 
tools/update-subtree.sh after it's been merged into devicetree-rebasing 
git repo (which is essentially a few things extracted from upstream Linux).

If you cannot wait, I believe you can have a companion -u-boot.dtsi 
where you do the necessary changes since it'll be included after (and 
thus properties take precedence if specified multiple times). Does that 
work for you?

Cheers,
Quentin
