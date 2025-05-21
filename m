Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18663C54E71
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 14:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971EC82EC6;
	Wed, 21 May 2025 16:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3xLox1ha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A2B82F03; Wed, 21 May 2025 16:43:46 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33DED82E66
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSqU0f0Eejqs4ntMLZCo/8IIcH++J+JUky8VVSdneV87oL0eHwtNAhdcWHIv3zw0gHKlcxmi4cDrCGR9HMuS3HmD+BoWmlpU5C2heCI2/nQf/AL8WMz4rj2NVd8SnpBLe2PvDf8bqPCxT40Od1+/QhR3/5Lp7KpFQRg2Wm5twFiBUX0zE3p+9AoAJeeuPGscGo6cUgwRbdSlTcua7R+SX0uHp/91rSiMcooTSUJmeCT3RopBitVAwU8i+45vaN85YiHyNAzg33BCLNe7ws3ucytcmQwEceaLVtMa0H+j0cV0WtSBgYTaqXUPx6yrLp5g0TgHsrZtxi9v6bJFYdzk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SgsAR3ASt1FqEMfh4hop0/i6PUwSK3HPdG/QcdFdzs=;
 b=kJVybjTToyIf1Hk/U9+hHFOd0xrkvWln3OefFSVNP5TeBFmVadl4StYvP8udPHN12uGVY4Qq+Un3Zbg/bfDU+U08W9oJ5ApJWYisEPXlGv1dgTLk+jXaEBD5XfrPeQdfQqnpkDmcGcYpFidVHwacIaoF6Rtcxwu1mxMCO/WkLWGz50G7jsfFBOANPR/dp08ayiw+svvJkBgY137ZmSq3FwDYp+x+FMEl9oV5/C5ZiGhvqnXX957a+Hwuc7M2rgx77Iie8q5fjzvFTqMC51KaItXicSZbMJ/6sJQ0JNtJh1IY8GuoTfAPz6xsvi1YNHK4ov9kV2JapvWdKj9r+e99bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SgsAR3ASt1FqEMfh4hop0/i6PUwSK3HPdG/QcdFdzs=;
 b=3xLox1haH9Z4xJodCJSn36tv/gFE+qMeonR27qUFHPDR6Rb5q/D8mXIAxeH35juCLhVufgAZTIVrn06WkJEoMKON3iW5oe5qUjG0VU0J1vix1wHgUbLvuzUb+TK9P9FWXuZK2IFjUVBjBuMCjLBjtDqSKiJyqkZT7ZmUQtHJLBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 14:43:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 14:43:40 +0000
Message-ID: <5895b4c3-900d-46f7-b3f9-ad6f6f5c4609@amd.com>
Date: Wed, 21 May 2025 16:43:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: onboard-hub: Fix return type for regulator APIs
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, git@xilinx.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <a2d520f14efc30fc28ec59881205e156dabbfcd9.1744350937.git.michal.simek@amd.com>
 <fd4fb3ed-5988-476d-aea8-2c5a58bda9a3@denx.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <fd4fb3ed-5988-476d-aea8-2c5a58bda9a3@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0101.eurprd04.prod.outlook.com
 (2603:10a6:803:64::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a846fa-d2f3-423e-31fa-08dd9875e0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2JGbUQ5N29kYVdqdytKN2pnWkZaSmJoNXR5UTdDT21WUFB3MXRPSFN4RHVt?=
 =?utf-8?B?MlhjazJET0RDM1AvYUUwY2dWem90U1RsOTdMUUJCZlFSVjJvT29qMld5TUpp?=
 =?utf-8?B?UU5TekZXRG44b0MvNDRVa29JdS8zVk5QeWZnZmMvdTZPODVBY2xFMFhtYlVY?=
 =?utf-8?B?NnMyQUVMRldIUnpIVFhrQzBvb2dSaWhDbE9QSUt5MS9sWjVSVks1TC95TFlx?=
 =?utf-8?B?aVFKRjdpdzZnS0dYNlQwNzN0cUtXZW1LZ0U3UmhOaCtKeExZLy9OUlg0ZVhX?=
 =?utf-8?B?MklkY00yRitQTzQvVEl0SitpSWVpQytPWEFXTWRwNmdEekQxSVBreHBkdW5t?=
 =?utf-8?B?SFJnd1VEMSt2dm40TnllWDJpRVc4d1gxMmYxZEtOZWNvc3VrZHhhdWJIMjU1?=
 =?utf-8?B?Z0tta2NSN2ZwRXNVK0t4U0VnYitwSjNHT2VIUW44M0FxK1c3UXNMNjhCdG1q?=
 =?utf-8?B?SWloYWZreVAxbXBjSGR3ZEJkQ1kxMFliTXNqeENLN3RRNEREWnNmdnhjUmpu?=
 =?utf-8?B?NGMxeVFzazRZN2VHWk9pZUhOVEVQOHV2UXlBdG1ubUE4T3hjVnNpOWFhM0Nn?=
 =?utf-8?B?dVhXdWVJdjRFU1dSOEV3L21uWVg2b0NIWDBrZUlBOTNWNkt2b0R3REZXN0RF?=
 =?utf-8?B?RGJVZXZXbDliWU1MWmxZaDJVZ0ZlMzhBdC82QWFaQXZCY2hmTFBXUTFVcUY5?=
 =?utf-8?B?SkhnbGJjRkQ1UkFVNjR5QU94OGVZcHpiaDBJR3NkblNpNXVLTUJTZExrcU5Q?=
 =?utf-8?B?VUZGdDhqSWFEbmFzcWR1Z2Z4WXdPNWw1Tm1BYi9sWXZGeFBDOEZFU1B3eVh5?=
 =?utf-8?B?OHN6SllicnB0VDJsNEhmbE5KZ1U4anIwZnN1cXhRR0lUMnJ6dGNpWTRRTG5o?=
 =?utf-8?B?QXlNUWtFUGlGb0xaTEtUcGx0bVptZW1IckE2TngyMGNTTlBHRDNQb0NjNHJU?=
 =?utf-8?B?V0lxN3k5STQzYjVwY1ljd1ZNWldOcnFkSzJKeVNpa1RSeHYzajJkZTJZalFz?=
 =?utf-8?B?OWp3V2FTYWdzcDNJb0JCaUF0eXYrUjVUazBpN3E1bFFnUEhpVTZYOVg5T2lC?=
 =?utf-8?B?bG5xc0xsNWRUSWllT2RHZ0R3OC9ES3FVYlJMZUhiaTFoeDNpTk9jWUdnRnNB?=
 =?utf-8?B?UzJQaEgyWlN5cklSWlFGMXhrM2V5bFd3dUhoazhuM3IwbE03bUdEU2hQUDJo?=
 =?utf-8?B?cXBDbGprZVF3S2p0aS9Kbms5aW1VVFRsUXliZDkzeUVVNUtNZVUxa1dLSjR0?=
 =?utf-8?B?bXQyT2UwY1h1ejZVUVVBRVRPejJBZEdvU0JuNEV4SVJzdHNGUHFvMFBoaEtX?=
 =?utf-8?B?OWY4UlVMTnNKaUJPaW15VUJaR05qdnNSRkYzNmo0TDVmdU5Tbkh5KzJ4LzBI?=
 =?utf-8?B?K0hZNnlHSDNxbFA0TkEzcW1qSTh5T0czbkFZU2M1TWZDd0xwc0xsbHkrL0sr?=
 =?utf-8?B?cVZUMEI5eHNRSW1hK3dvZXdneHdRYklWWXAzb211VE5tMkNoM2ttenFJUHFR?=
 =?utf-8?B?eGlQZEZhalFPaVNVQTNKbWtlbXhOa1MwZUswcFJEejFmWEJYTytxMnBBNmVK?=
 =?utf-8?B?UWV5Y3dhWFFVV2ZqM2RRVzFlM1Z6Y3V2S2RMTEY0TXUwSXl6RElOSXkyZ29r?=
 =?utf-8?B?NjZpbjJxZ3YyQjhNbkIwbkwyVUwrKytvaW1XdW1ScTZTSFhnQ3hGMUFuVThh?=
 =?utf-8?B?MHlKTTVLd2lhRnMweHFUa1pIT1RNdnpvUkJ2U2hkUDFIcDN6T3Btc3R0dzNL?=
 =?utf-8?B?RTFhdXZ3RzVrQWhrT1hvbG90UVdTaERXalNFM0wwYmhWTDQzb2FSMW5keHJ5?=
 =?utf-8?B?Q1ZYVDdiaWlOVXBPNE9CTUFqajJvNTJNTVE5ZSt0NlM2TnBRenRaTDFsMFJO?=
 =?utf-8?B?emZJOFE5VllvdlNaUWVwZWFEdVR2L2I5VTFvWlRZZFVWK25NckZ1VXhTajNN?=
 =?utf-8?Q?4KtAULqbbFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlZubjhxaTlEcmROYTBkSkh3MUpGVTFEdVdjaW1PQUVKZHphWVJIWWJhMll6?=
 =?utf-8?B?N1VMUDdvUCtUZS9VdFlFL0V6RDJzVW5HUzFuRHVheXV0eDR2OUZTSGFLaVAw?=
 =?utf-8?B?S2dwdkcxSWdRdEpoODZHMUZSSjF2V2FLOEFvK1ZLWEJ4VTQ0cy9XZWh4aFF3?=
 =?utf-8?B?ZDBzTmlnb1NobzF4MmhvRW45VDZvVjE4ZkE5Unl0S3Yrc2xFWlZxajJZOWpo?=
 =?utf-8?B?SFBldlZReEZMRWs3b2hOQ1BXS2ltTU5FSGxGOVQ3ZXc3U2hSQUd6MlBQRE1N?=
 =?utf-8?B?eWtLV0hNaEUxSlhsKzZrdXJWdlkzMGp5dWFWMHVXVjFzUWF2bWMzZXhPZ1h3?=
 =?utf-8?B?a1loc2JBdnppdnJLY29qMnV6ZE9nNUsvL0pUdXVadUVBSSs2NllZb1I0clhm?=
 =?utf-8?B?bU5pNktzdmhYWVF1clVzWHhHaWh2djZ6U0pjKzVNMlFCUzVGdDVXdDBLRXBk?=
 =?utf-8?B?SG8ybVA5YTZ0U3Z1b25FMEwzaExqandRb0UvZ1ZHbGZYaHVqUFZIWlB5cmQx?=
 =?utf-8?B?WGFQdFlDTlZHNWVwVjJqRW91SWJkVFAvUXhUcDFPT1JqT1hBTFFVd2cveWND?=
 =?utf-8?B?cTJ4WUZjbHVwTlEydzF0MnBGSVNMd1Y4WmUvNnJ3MU5qVzdwbjNya25JTVF6?=
 =?utf-8?B?bWZTT2ZvV2ZybkY2c3dpSS9ZTjJBcmRyMWh2b0lnVXYwc09VSER4a2tRbXBH?=
 =?utf-8?B?bmZlTzhtaE5aRDcrUDBQeUM3VGIzZklsUXBvM1Y2cjFNWmRoaWY1NENTTlBL?=
 =?utf-8?B?Qmx3TWYwdTBiSThIOTNjS2UvNkpTaDVTK2xHSkp2ZEFBbDFIZEJyeVJac25M?=
 =?utf-8?B?S2J4eUNDSDI3S0dCSCtIdUtCeURHUWZuWHhqQ2FwdUYyc0o4bzdhR0UvRE9I?=
 =?utf-8?B?eDliVnA1WVdYUytTWFBRaXd2eVhlSkgxaHl2K0UvU3dvc0JnZ09MbW11VUgw?=
 =?utf-8?B?WDN6Q1drenlOQ1B3L2EzaDFLVkxmaktsT3dtS3doV2tHcmIwTFZyWU9LSElK?=
 =?utf-8?B?QUdKcXRyWjEvQWUySkJjUEIvd3pOdlNCdGhLSDVxL1Y2ZmFwVEFjSXg5R2lN?=
 =?utf-8?B?QTBjL0NzWnN2YlM0eSsrRkhqVXk3cnQyNjlKZjR0aU4zL0wveXhVNklpVVQw?=
 =?utf-8?B?eCtIL2Nnd1lVK0ZMb1hRMi9GT01lbXBmQklwam5kbFJsaFJWZmdUQVk1QTA1?=
 =?utf-8?B?YUV6Q3NQaVZDN0Q0Tk5PbXhoVnlxY0c1L3l1dTRINFhlbWx0S2RQZWNlbUFk?=
 =?utf-8?B?YlZhbXVwN2FLaUlhempXbmFkTGVSZzJNVDErZFF5SnlUcG5NNER6d3NDQlpT?=
 =?utf-8?B?L1M4SlVtem9iUThWM2R1S2c0ZUNKTThQd0p3dXhTMUc5VitObEtkUExWbXpN?=
 =?utf-8?B?UWVzY2NXc1ZXa0s4clByV0N5MnRuSm5qN0JjcU5yd1N4dnZCQ096TnV4clNY?=
 =?utf-8?B?ODQxSUdNYTIySUorQytBa0V6UVY4a0hrNmpCQjYyeEVmcFZ6emE2Sm1TNnM2?=
 =?utf-8?B?anQ1R2t3Z1dMYWFhTzhIc20ydHF5UDNXYjRJL3M0MkVqMGV5b0VTcVdTVUty?=
 =?utf-8?B?NWYxdm9YS21uL1pYa2ZNOTM5L2pZcVlKd3dHWW41dmtYK2ROaHJwcS96Z2Fi?=
 =?utf-8?B?SGg1a2oxVDVnaTg4MGFSMEtMUzdyYWtVODV6MTVJTERUWlJ6LzNDN3BYVVFH?=
 =?utf-8?B?eUxBMHZHNDc4WlJxK0x6TDFpeThZcmVYaklRK0NBWllyUnFyb25aTE9pcmY3?=
 =?utf-8?B?TWlZeDVUc0JXWm1RdVByMjZ3MmF1Q1ZuYnJhc0pqYlBCaU1OSWV2RVRiYlJF?=
 =?utf-8?B?SEpCWnVqbE5PcnlVVFZCNDlDT2U2RVdKRU45NlB3MmM1QlZvb0NBUm9OUDE3?=
 =?utf-8?B?THkyVk9SVUNzdWJBdzMxdStocGlKZ2lUV254bXVqSitxQnRxV1V4b3RSUG5M?=
 =?utf-8?B?Mkt2ZHdmaGJtOGxBNjJrL25LOHpsdFVISTVpaDRKMHdreWs4cnRZK2VxYUFL?=
 =?utf-8?B?Zm1GSVJaQ1FuWVlhdzNLRXBLK3VkK0ZjMUtneGdFY01DYm5BVXhla3VDY2Rn?=
 =?utf-8?B?N1Q5MnArcTBhNlorUzZqOWxUS0w1ajJ1UWVTMERtdnJGY1hzWkY4L2Z3VE9l?=
 =?utf-8?Q?G2OOCI7+plwBis3GZ5z4RSbkE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a846fa-d2f3-423e-31fa-08dd9875e0b3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:43:40.7785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcUCeptFahG3WW6tA0mxx2ftyBcNKNickC8rFgozVQ4BWHSsqKJIis6WebvfKhtB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999
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

On 4/12/25 22:52, Marek Vasut wrote:
> On 4/11/25 7:55 AM, Michal Simek wrote:
>> From: Padmarao Begari <padmarao.begari@amd.com>
>>
>> Apart from ENOENT observing return value as ENOSYS when
>> !DM_REGULATOR that's why cover both configurations.
>> Changed code is not working as operation should be "&&"
>> not "||" (ret != -ENOENT && ret != -ENOSYS).
>>
>> Also fix the remove function where the regulator_set_enable_if_allowed()
>> function is returning an error.
>>
>> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

are you going to pick this up? Or should I take it via my tree?

Thanks,
Michal
