Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33425D43354
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 12:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48A488925A;
	Thu,  7 Nov 2024 13:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iQ80gn+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04908925A; Thu,  7 Nov 2024 13:01:27 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C322C89258
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 13:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+uJO4dOynA+zb3ZSii7FWWtiTx1kwVBaIHb0QFQz+dTHviDw0aqnc6PbXAZmG3y5ikX/vWCVHGL34nRybzoNnHKZVmpZEQyf6Uze8iDajXmCe5JGgmvRoWhR2ZO+XJIiy+GOGSh3U2aSB19zEP8XbpxYWVBfOFEPE3Ky9EuRQqJHIApDSMABaGEV6Hy/wyNL+dLvZSBlkw5k64j59ECALa0NuPReakbsyyYLBwjsQbi4y8nX5YJyFt+nLUs9G9eCFNqOA/2xO5Z7TcJlndTKXC1ix1UPGOmgIZEs0QXL+d/wecHrTEYVzE+bnHRNdd5KgiJJ5wgP90P8W7pBu7tdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9Eq62oXG7xBftMAEt+ZnoyEHDcRKyoknLcm0gKZl+w=;
 b=Jk4vZmS4VuMsE8se21r2SVHuDBFu1rR9qRb7jyQCNFdIiV38Y/F4frTfwu9tFSNIMuDmRfk8Q+Nihn++A6OOIxQCI52kDXs94b6vuFKdUKL3Sb2MozFebpEQCq00qlLt3sPmuDZ/RLDkSGqaxk1Mx5byr8PuobuID5cUROPcAtZlSVjM9aU6RLqJYdNx5EGX+ujrc7mSOWyI9RfQGUMfAbE6iqtrG0qTO80rx3JZk/RAYA++fjGuxmYtVnvwJW6NAENNLWQMJKfWr9OuKZT4G9jpibCJx7Apa8+jgx7raTkv8ANujXLmcVSWma/BzcowshthmNgSfZ1f+7a+H0UGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9Eq62oXG7xBftMAEt+ZnoyEHDcRKyoknLcm0gKZl+w=;
 b=iQ80gn+OyxyoIb+0P/vsFqZcPfshqFPaFlAc8I7PDFoVvDR2prDIh4PNL/bqp/ldqb0gAc48/7c1vGCiFoMA4bTaYbEOC5z7NZAKWcKezcUjZvQRdI5fOVZBz+kUlLpBTUwtoO35HWG3Yy2g3PeYF253uzaXvtbo6snyaZkBGOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10405.eurprd04.prod.outlook.com (2603:10a6:150:1d8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 12:01:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 12:01:21 +0000
Message-ID: <f4f66f6c-3b96-4529-a90c-cd3a0b900a56@cherry.de>
Date: Thu, 7 Nov 2024 13:01:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk3588: Implement checkboard() to print
 SoC variant
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20241102203746.3631481-1-jonas@kwiboo.se>
 <20241102203746.3631481-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241102203746.3631481-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10405:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f9c14e0-4ae3-4e66-590c-08dcff23e52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUFZUWRRMU5xdE1vY0RVeTF4dlpycGN2dFBTNXJvWUJWODZEcVJJM3h4Q29r?=
 =?utf-8?B?cmFyTWVhaGQ4Z3FBY3dBeitSczdva0FrU29TTzh0R0VOQVRsaVoveU52OVZS?=
 =?utf-8?B?RUlZRldKUGFwRUJReXJQMU1UYm1ZUkdJeEszaE0zbjFlSjVBNkwyYnE0Z1Z2?=
 =?utf-8?B?blhBMkpHSWlJbE5Ld2JtSzFNVVErMDdvbFR2eEd5ck53NU5mOTNSOXpiTnZG?=
 =?utf-8?B?bHJQQml5VWpzby9CY0hWWXV5bHRYL3UrbllkMCthQWJQVlNsTGpOT1oxUmdz?=
 =?utf-8?B?dHA5MXgyWDJ6S0pGaC9ySUdWcDJ0cnYydm4zZjRobGVPaVRocUcwUVZ6U21L?=
 =?utf-8?B?WDNZaGs2ZCtkalp4aHdveVBvdmZnZUpNN0ZpanhzRWRyK3pKVkFKeVFpWnh4?=
 =?utf-8?B?Q0dYMjRPVzdxRnJ3M3B6NkZaSUd0WWNUbU5YN2dZK2R3OEN2TStqakllMHVI?=
 =?utf-8?B?SVBPNXBLNm12V3NRQmFyWEMvVUtxQzdxTHk5K3cyNTVjZ3F3djlGN2pQSURl?=
 =?utf-8?B?MjBaMG85R1I1dGJxRmpzZll6Mit6bDJCTlF4alZmS280NndUOSt4NjVTa0lt?=
 =?utf-8?B?emN0MmRic2VpSU11THRDMHZabkVxQ2x6dEpQK0RYMDhzeDluUnRMMUlRdFRv?=
 =?utf-8?B?K1htb0tMVDQzdlM1R2ZjQWNaa3hBNm5TTlUxM1RLRW84RUFoamhMWm1RTytH?=
 =?utf-8?B?M1NndEFzdDlGcGIva3QrRE5aeVhvNXplcFZGUlU2ZlBJcjdOVXF5M09ZWEZI?=
 =?utf-8?B?N3BWOERxUndpY053dFFjVW5hZkpEbHl5aWFPdmZWL2g5QmpTcFB6RUxkN3BG?=
 =?utf-8?B?N0ZJKzdZN1ZZTUVieEFtcFY4b1AxaVJDNG1ZRmdkbW92aVNVWU5PalNCcE5F?=
 =?utf-8?B?OHBzbTJ3S05ZNndnOXU5N3YrM1NPc0lwb2xWeWJ0ajdxSnJwb042OWJJbUJY?=
 =?utf-8?B?c005eVlRRTVPaWJMNS9UcnlDVWVQTVAvUFBEM1NlUlFTVkZyWnRlckdPMThL?=
 =?utf-8?B?SG1iU3kwOFRiemFVd2ZoOUpCWk1DbEQrNlN1a0xmTjBSMEhEOVNzcGI2UEtN?=
 =?utf-8?B?SWlCQVpkNzF6SElDTEFsSGI3YTVobWZ6UGtuNVlLQXlXd0o0eU5GbGdHdS9h?=
 =?utf-8?B?aGFhNy9TOVRSQTBOV09xYWF5QkNOYlY3MzBPMGxCQk5jVldDQ2kyMTVUb0h5?=
 =?utf-8?B?ZWEvVFhGTUJyU0hvQTBrRUlwSmpwb3dVZjdwSGpDdkJ2YzMxdUJpbUlxZDh1?=
 =?utf-8?B?bC9mVzBWM3ExY241ZlYyem1mbkZJODZBR0dCQWZkMHRZUDhaUktMdjM1NlZI?=
 =?utf-8?B?Z2hWSGZ6dnAvNEYvd1A0Q2x5TW1MOUMwZ0oxN2lwOGVBVFhzS3Iyek1tNlJa?=
 =?utf-8?B?c0t0TUNrT3JNdFJvNEVicFFHdCtCZXVWRkpDV3p2NkFBMWRSdUI1OFlYVlVH?=
 =?utf-8?B?THg4Y25oMmRXd3pzajNGZm5XQXdoeThIK1FqMnBMT1gwak5LQWRUb1BwNmow?=
 =?utf-8?B?OC9QK0w3ejdEaVQvUWo1MDltSE5QWHJvcWw5SlpNVHh2Z2liQkFkQmh3a0FB?=
 =?utf-8?B?TjFreWE0dlhhc0VENldwZEkvWHVTUzgwcGhxUEVuRVUxWkxDSUdscjZLWjhL?=
 =?utf-8?B?MWNBYkVqaWczMEphM0U3N0J1WHBDM1luWHZLMlZUbDRHM2RVaVlSa3c5WXBF?=
 =?utf-8?B?NGxCQk1RWk90Z0dVaFJCRjBWZEVJL0hwcDE2aS9Zamp0c1RqcitjS3JhaUFR?=
 =?utf-8?Q?MfFJzT+BwU+LpGpUjobaP6I023WH7Q44vOXccJj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXVKOThyWG5BREdHOEExK1NHa2VFcFVISFFmc2ZkclFGQUQ2QmR5bXlyVjlp?=
 =?utf-8?B?RlVQaHJBTHM2ZEpVODVUTU5vTGh3YjJsSHlKVjYrN1lGTGVtditFdnhHWmUv?=
 =?utf-8?B?cS9WSk1pZncvN3VFS1FTeGJURit6YnVVWERweTZKYVdaR0R3LzlzSlcrc2FV?=
 =?utf-8?B?YTd2M2xJcERHTGdhWDhUc1kxVm9nOFNqd0NqTFJkb3VoS1MxY0V2ZWFuZUJm?=
 =?utf-8?B?Qm9za2JjRGVZM0R0b2xQdC90TVNROGpRQXJHMlk2ekNydGxLUVpxQ1NVRzFW?=
 =?utf-8?B?ckdTU015NmRUUnZBbXpEYmtOZUgvT0IzajVXQjN1R1M0UVFOazQxUlhxNllT?=
 =?utf-8?B?Ylp5TFlMdXgyVSsvY1lMQkppaXVkR3M2OFlFcUMydFhmSmd2QiszS3Zwd2lz?=
 =?utf-8?B?QWlFVWY2ckVwajZmdENiMzhMMFdzREw2aDZFVFQvMWFKdnpySVZsSm1uWC83?=
 =?utf-8?B?YU5qamtwVEJTQVhOV1JxdjN4R2RLWFZ0Nm13dHBkekZaWXR3L010WHlNL3hS?=
 =?utf-8?B?Yzl5VEozUUE2ZWRKd0VqSmJqZ3FZbCtpK3l2c0dIRis1K2NFN2FzN1JEZ2VM?=
 =?utf-8?B?bGJ4di9iRTl4L2dWbDhTbzJHb0J3dFRCVVg5N01CK2s2aVFNVUk2cGRUMlNk?=
 =?utf-8?B?d0ROMEd6RHB6REFsNGxyQ21EQ1NpTDF2YjgxdExPWjhCVkp1QUEwcFFlbjhr?=
 =?utf-8?B?eGtCOXMwY1U1ak9qL3ZDN0Vyc3FGTWNzRjcweFFSQS9HWFBxa3hBdzRNb01B?=
 =?utf-8?B?WUxXcUwvYTNYVWl1TlNOWVlOb0luSnRJTlVFaCtTR2x3REJidTV4RGwxVEY3?=
 =?utf-8?B?RVcyVXdnbFFRZS9TZ2V1SENSTXlSdzR0WkhCd0FBYnE3clFIVXZhcFhsOWtL?=
 =?utf-8?B?b3B0NjUxMGhhYzI4NzljZ1Rrdk1YNkNWUTFXYzhVN0ZTUU5lZ0piNm5hS292?=
 =?utf-8?B?WEhPSEJ0SVVPajFic3RTOCtFYi9aaUF0SUhDOG8rT3RJdGhlTEtlSVJmbSs4?=
 =?utf-8?B?L3gyeFdsSXR5L0M2MGhVVkVlM0tuVFBsZE5vSGFDeUUrakF4TlYwR1FBSEtY?=
 =?utf-8?B?ZTYvNHNHQlVKVXZ6dXhHay9NOHZYb2h0akhuK0MrUk85Yy83b2YxaUN1QWN4?=
 =?utf-8?B?OUF4YlFkdDV5UUtGbHBxZ09Cd2l4a2FjVjEzQ0pVaTd4azFOUldTbEtoOWJP?=
 =?utf-8?B?Y1lyREk3ZUFBeER1N1BUVGdwaE5Qbk9jNjIrOXUyakZpRVF5MXFJUEFZaTd2?=
 =?utf-8?B?Nk56dURnVnl6Rk1ucGthOTdiUHZ2VVR3bkRYbVl0RzlzUnAvcHNEWjZyZHdX?=
 =?utf-8?B?cGYxcEJ0aThhUFl6ZmVpWmFISlg4Nm1WTFgzQ2xKcUpwOGZJT3Qyd2FMQUFy?=
 =?utf-8?B?dzNSZHZJQjA3MGU2eTdGMWg1REJXTGNzYncxajhIWWpwdEJuRTQyMXRNYW45?=
 =?utf-8?B?VkpBTHlpekxGODgrYTkrQUdzTHoyRU9PMm5sd2ZHc016WlZyRmlIQ1NSbGhG?=
 =?utf-8?B?VkhlVEhKZ0FaMnlPWlNuVU04eFhDUktxWXJOS3Q0dWNpUmMrY0JPNWhjajJy?=
 =?utf-8?B?SkdsWDd3SHRFTHJ4UDhUSVhpMzNHWDRCRnpzYjNBZE41azZDYitIK1IyNkhY?=
 =?utf-8?B?Z2dqZVordzRVcWFBSUcxQ3JtWlRrZVJnOGVyVUlYMzFWc1FuQ1NIMVpnRitr?=
 =?utf-8?B?cGFCMnVKUDhRamlMbnFMcVRsZ2dvdzBUeDVjWGQ5N09yRzB2QWw3eUhXVnNH?=
 =?utf-8?B?UVROeFRpVVV0YTdPcW56QnMxL2FyZmlyb0lXckxUeGFhdkFzdjdkb3ltNGhp?=
 =?utf-8?B?eUFPcHRJV00rZjdPdDlEMkFiVGR4a0JnalJiL2I2ME1aT2Q4WmhkTEpQK0xj?=
 =?utf-8?B?RG9iSWJDbDdWaGdieG5aTVRVSk9xbHFGZXViWkFiMlNtdVdhcHVabERET0pm?=
 =?utf-8?B?NHVUQS9pT1R2dDZFMEpEeThpRWhyNjduQWs3bWR3OEx1bmJTak85T0Fnakt5?=
 =?utf-8?B?Z0NrY05qSExxQ2ZJSnFGOXBsWDlHQWpxd2E1alpDamNwZFVKNXlLZmxWT0JH?=
 =?utf-8?B?WjFDQ2tncTVkSSszU1Bmdzk0MGlhRGp5eGZ0N1l0aGptMHRIbUVoOUNkOHc2?=
 =?utf-8?B?N0c5U1dJTkxCL3IwQUJ1Q2RZT0YxSzZGWHVlMGxYamFkRnpHYzZRTnVNUHBz?=
 =?utf-8?B?Ymc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9c14e0-4ae3-4e66-590c-08dcff23e52b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 12:01:21.5085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hocrjD93Qh9YLQ8GoANfjUbP2uZos2WhePPmJI+5M2n3l5lu5dvuD1hWLffFRtiyASlsdoPsRl3JOWr/hSXbSDvdcz1b6kE6FPnbyRBXOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10405
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

Hi Jonas,

On 11/2/24 9:37 PM, Jonas Karlman wrote:
> Implement checkboard() to print current SoC model used by a board,
> e.g. one of:
> 
>    SoC:   RK3582 v1
>    SoC:   RK3588 v0
>    SoC:   RK3588 v1
>    SoC:   RK3588S v0
>    SoC:   RK3588S v1
>    SoC:   RK3588S2 v1
> 
> when U-Boot proper is running.
> 
>    U-Boot 2025.01-rc1 (Nov 02 2024 - 20:19:01 +0000)
> 
>    Model: Generic RK3588S/RK3588
>    SoC:   RK3588S2 v1
>    DRAM:  8 GiB
> 
> Information about the SoC model, variant and version is read from OTP.
> 
> Also update rk3588s-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
> where checkboard() is called.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> - Update commit message
> - Update code comments
> - Drop generic-rk3588_defconfig change
> ---
>   arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 58 ++++++++++++++++++++++++++
>   2 files changed, 62 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 09d8b311cec5..8880d162b11c 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -69,6 +69,10 @@
>   	bootph-all;
>   };
>   
> +&otp {
> +	bootph-some-ram;
> +};
> +
>   &pcfg_pull_down {
>   	bootph-all;
>   };
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index e2dac2a5b806..f9da7a6f1477 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -4,6 +4,8 @@
>    * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
>    */
>   
> +#include <dm.h>
> +#include <misc.h>
>   #include <spl.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/arch-rockchip/bootrom.h>
> @@ -178,3 +180,59 @@ int arch_cpu_init(void)
>   	return 0;
>   }
>   #endif
> +
> +#define RK3588_OTP_CPU_CODE_OFFSET		0x02
> +#define RK3588_OTP_SPECIFICATION_OFFSET		0x06
> +#define RK3588_OTP_CPU_VERSION_OFFSET		0x1c
> +
> +int checkboard(void)
> +{
> +	u8 cpu_code[2], specification, package, cpu_version;
> +	struct udevice *dev;
> +	char suffix[3];
> +	int ret;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_otp), &dev);
> +	if (ret) {
> +		debug("%s: could not find otp device, ret=%d\n", __func__, ret);

We should probably start using log_debug instead?

I guess with #define LOG_CATEGORY LOGC_ARCH

at the top?

> +		return 0;
> +	}
> +
> +	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
> +	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);

This will fail if CONFIG_MISC=n which is neither selected nor implied 
for RK3588.

I tested on multiple RK3588 Jaguar, and the commercial (RK3588) grade 
ones all showed RK3588 v0.

The one industrial grade (RK3588J) showed RK3588J v1.

I'm really not sure what this version number is for. If even Kever 
doesn't know what it means, I am not sure it makes sense to print it?

FWIW, the Linux kernel now exposes different nvmem devices for each cell 
and since we have a cell defined for the three OTP ranges you're using 
here, maybe it'd make sense to use that instead of hardcoding the 
offsets and size in here? Not a blocker for this though as I don't think 
it brings THAT much value to those fixed NVMEM layouts.

Cheers,
Quentin
