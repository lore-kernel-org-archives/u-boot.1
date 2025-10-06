Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868FACAC5B8
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 10:50:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04963836D2;
	Mon,  6 Oct 2025 12:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RYDeSyTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE4C83734; Mon,  6 Oct 2025 12:50:48 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFF5835D0
 for <u-boot@lists.denx.de>; Mon,  6 Oct 2025 12:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y00GRgZpy/l4bLzsZrp95/WCd8aCxFeBTXKYIIPAh12LBfMIrWHBueiLwgm96PDLhLcvLG6nA6po2I89BbY2xjcrBz/4pbcJIzEkqWXsmu0BteuesWLH0hNWVVcO1+4WBdY1s68Zw/hzr/pUULfEPvHF9NOfjJqm8GWyGVpnINh2ECLiHWehpCOEqwi6agppxzwfImiJ5E7hNqvolETjV3piYEQlSeFYHXvYogpPzfwhUnyG7i6ypx6NBD5cdcFS1BRxlkqTPGfSg3EPYjbM537+NDROeX6QslTZ8sgpvPiCBJb4PhXecFKuMSq3z0Vjgh5uo35U+HNDsPj/KMQ8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiLKE9kfnjwNzBFl2X6ubTEIsjk8Turr2u/OL61k2ac=;
 b=dDDr35mez1F0dsllQ4WZe4U0UhM7u5raz/ceHvLFUxg6YmnvCStMK+eK+edHofDhL1fzcLCPQE2l3rdoxgMAVtkrRvMOFbdID3DfcpLXeWIwMTI1xa9/DqRFhPJCafk+nuEVY6t4GBAh5GVEjxLYMYIuYTDVzLVsDSGUHIckUjfqv+6bJCEWyAyfSU2W4LlyPjuFZbGOJfg4gD6BaJSmq9nT3+rlowZBkRCYNxe4GiqBO/dozUtLqoXdt0LNHGCr/kGdEP1HRiQ9KmMnCOQyMxWbXsxFovOJ9+e2jPTKudAJxexlP7QCZOS8SvqmantGgNjVyf0xnWs4vhm3evx+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiLKE9kfnjwNzBFl2X6ubTEIsjk8Turr2u/OL61k2ac=;
 b=RYDeSyTJFT7ameiWry3mCHWATSMcHv5w1MbX4k8wDeD2OrNN5yOG8PxBLyvWwVpLRqwuxwg0djWaaNOGY7zlUoP1Erm5cIpgoiSTOmiYLCQBoj/UVUHcp6N0blGhW8sPiRGNIMIogsk8VU5yRmpBMM3A57P1ZcJs69HZMpDFeEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8611.eurprd04.prod.outlook.com (2603:10a6:20b:426::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:50:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 10:50:40 +0000
Message-ID: <72dc4f3a-9313-4ab5-93c9-3f70174cb645@cherry.de>
Date: Mon, 6 Oct 2025 12:50:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: Add support for rk3588 MNT Reform2
To: Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Xuhui Lin <xuhui.lin@rock-chips.com>,
 u-boot@lists.denx.de
References: <20250926163000.657437-1-pbrobinson@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250926163000.657437-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0297.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 3087cb85-86e9-4a8a-23e0-08de04c630b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0hYcklBSFpkTkFvRWFHWU5ZMlJkcEtpZCtWK2theTJhcVRXWnNCTTB3c3Ry?=
 =?utf-8?B?MWo4Wm00aGkvTG9qWm83MFhLcXdpN3hqNGs0MHE2OFBqcXlCVVpCWFY4SFRV?=
 =?utf-8?B?a2YzeGlnby8reCszK0R4NUl2SHlqL2JhRHpIWGN6NldDSlVXdzZGcnhMVGZB?=
 =?utf-8?B?Zm1oTWsycE1qMUR1anF5UW42ZGFnTzVnY0tZbmMyalJlc0lBY1A0UU8yUXov?=
 =?utf-8?B?NkRjeitPYlNPMUpRQUpqVUpQcnBaMFpHaGZpa2xCeEtFQlliY2ZmZnI0aDh0?=
 =?utf-8?B?YTFtL1VQQm4velZtSy9FamxvL011WUd0NVFEUW9ZejJYZ0lDM3E0d21WNlRK?=
 =?utf-8?B?UHd0by8wNHdHL3JNNDBUYitlcXh5TzV5M29XdzlvdmZ0K3VFRnFIQ0o2UHRr?=
 =?utf-8?B?MHpqbThYTVBMMmtsYktIMzJ4MEZNZFlNaGs3RzVsanB4VTB6ekg4Y0tlUnZ2?=
 =?utf-8?B?b2dKT09oWEQwMDFORGRCNXZxSGtLL1dBeW4xQm14WTIvMzVmV2ZFTjVoZUxv?=
 =?utf-8?B?RUl1dzFPb2RPYzZMVVM5TUdaTHJyY3FaaDNzYlZkT3g1MkFWZEpZcWpIQUhC?=
 =?utf-8?B?UG43WHFmYkF3OXQvUzloMDdqYkdPU08wN0tGczJQYi9BaGlyU1FEOTY2THBu?=
 =?utf-8?B?RFRYbnhSTWlwVEFJRHpTeEREVmJEOXg1RTRKcHdiMnFQK2xNOUhVMVNOOHRy?=
 =?utf-8?B?QmRDSkw4WENBSmhqUDltWGxMYmpJbXhZV3pQb2R2WE8wM3I5cStiVHUxNTVD?=
 =?utf-8?B?T0dNTGZQczlMOWxkMS9iY0h6RTYzSmNwV09lMjhsNGZrQ0FyNFF0SHhTM29L?=
 =?utf-8?B?bklMeTJxUy9HZUQyRjFDT3pENmVJYzZLYU9hWDFEdkpEVWlxa21rVU1yVGpn?=
 =?utf-8?B?UC8yUzg3S0xyRWw4Rm1sNFU1aFJTYTNPTERyMkh5Y1hKQ1IxWEFvSFc0TjM5?=
 =?utf-8?B?TEdHUnd5OGxnNVpUZ1p6SFFwaHkvNzFjZ1RuZmtlbHRiWllZUGNUbmorR203?=
 =?utf-8?B?bVo5ZHhzRGlBS21uKzBrWXFjUklNdFN5M29nV2hQS2RDQi9pdFJqby9JaGRO?=
 =?utf-8?B?azdkQ2g5d3BKS09tSFREQklOcmdRcjk2QlU5T0I3S0ZaM0wxRVY2Ym51SzFl?=
 =?utf-8?B?dng0WlFtYlVZald6cVhQRkFNRTV4R3pBL1BNT3FCSkYvb0dDU0kxbGFnRllp?=
 =?utf-8?B?RytaemNRaCtQMW9HZXFWdXhwSGJqc3h6WmFrWG9KMjJDTjFTVUMwWUNBTFNq?=
 =?utf-8?B?dkFJb1hjUGozcVF6NDBnOGFIakg4VWVIV1luL2krbXNlZVpWOTFBbGdWTWdv?=
 =?utf-8?B?emplUWIrLzRTNWdMV3RQM3lnMnVGTkY3L3M1dWVLeDRnNDZkV3g1ZHdWREg2?=
 =?utf-8?B?Z1UvQklCUHFySjR1Unl6dmpKUWc0SkNPOUpVNHAyK1RST2NJMXNKUWhOcEVX?=
 =?utf-8?B?dXd0S3d5MGxRNGhSeld5cHN3cDF3ZlVIeVFjNEJodXNHdHBabDdsekpXY1p5?=
 =?utf-8?B?QklDbUxzOFBYcmxiL1pCWVFRWlM4c1MvZ2JXdm5weDZrNnJHYk1MUkkra25X?=
 =?utf-8?B?dDBmUjZWSWJ6N3AzQ3Z6NjluN1hNczNHQ1YzTXZwcEpJUWlSanF4eFpKekt0?=
 =?utf-8?B?bjdCWFRSQWpyYndkNTU2Ukl1U3ptc2RUaC9tTUNPSElaenFSQU9jdlBPYm54?=
 =?utf-8?B?cW9YamNHUkFPNkR6bERQMlZ4ZUlFc1pkRmNnM2hYcDF3MUZVZmhtMXFqaHRY?=
 =?utf-8?B?RUltTnlSUDBQTHdLNW9EcnlXUGV4cjNUQm9QNzN2NGNNeVRJcVkrOExCSjJZ?=
 =?utf-8?B?T3crNjFMN2tmZHZqbXFnUTJsbEdwdVk5VWpYTi84RDFWTCtYZGhYblhLMTJR?=
 =?utf-8?B?WXo4L3g3bEgxamxjMm9FMUFPd29FS0hWNGdiKzg5V1VjZXhralEySmtrUkNl?=
 =?utf-8?Q?9OI8RG4chmPe5YFxhcbs/hqBtq7yXaNw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXBzUWZzTndXbGI5T3pFS2ZCM0J5WVJzeHlVNERTRkg5ZlZYVlNmTDQrMGxN?=
 =?utf-8?B?dzVnQkkxa2k5RmZ0UG8xa0pQZ3JZa210ZTNPK3dJL1VXZk5Nc25Mc1AwOGFG?=
 =?utf-8?B?Z0tJSkc2U2M2USthK1F4cVZheVZzelpJVUduWUpRM3BxK0VCc2ZXbmlBNHhy?=
 =?utf-8?B?SmZSZlp4RC9HNTYwaHhyL2xqUEFrY0VTWk0vUU85RHBJOWV0TFpyRTlXQlF3?=
 =?utf-8?B?UHZqTGNOR3FVOW4zdGM2OEluVXZ1RVhvSVlwK3dxTDZLalFpWlEwajhKditT?=
 =?utf-8?B?MkhUMm1XV2pIR01tUGtWaWhxamlBZHRhV1I0YWNNbHpYVE81bFpMa2x4K1hC?=
 =?utf-8?B?YmZSYnVCcmg0cFE3QytTOFNwK0tDa1Z4R0xCK3AyRllLMkJUOUFwQktxVXgx?=
 =?utf-8?B?K3c3dTNoZitXTkR4OEVNeG9WRU4zczVCNHJZUWhzTk9Zcmhzemk1Ty9STVRk?=
 =?utf-8?B?bWVYYk03eTN2VHAxNjl1cWNJWHU5MGVsaTgvcmt3QzlYNThXVG9KVmlSY2dx?=
 =?utf-8?B?WU8zM2RCRjh4TWRWWkxPbExBQjdvTU5RSXJ6MisxSUxiZlpGZEQvSlMwd2tL?=
 =?utf-8?B?Uit2UTBwNkNKWm1Ia1h0UE5vL3VTa2M5QVRkcUpjWWpWaTdGTHA2enl1RXNJ?=
 =?utf-8?B?S09BZHlDTEoyYmV1bFNMbkJUSVlMK2lhaTJxWHpYYzFJSWl4RW5XY09Idlpj?=
 =?utf-8?B?ZFZTdkpveVVTdDZIYkJmUGRORDBtcXN2Z21wWXZ5emJPSTdYWHJHQnVQUU5y?=
 =?utf-8?B?aWNjSVdlZTl4VFRTOUZ1b0FkTkhyem9odXFRemt2YSt4MG9ZTXIybWtLR3lo?=
 =?utf-8?B?S1FoZ1IvNlg1R3Z6Vld6cHFzUGpsWUNaTGlocWhVdjBRT2NsbThKVmNkTFNv?=
 =?utf-8?B?a0tmZlIxMk9kTUlRTXJzQWNYVkJIcUEzeHRYNE5LNFNzL2xZWEd3U1ZFSGFC?=
 =?utf-8?B?QXRJOVBxOVA3aWM4OGVRdkJSeG1KZlRueU1XVm5CbDEwZkYrdHhYQUZxR3ky?=
 =?utf-8?B?SVREZHAvcHN5Ym5LUkdBcGkyaXNlSmJTbG9mdVhqdVJJVkJ6S1N3N3E5ODJ4?=
 =?utf-8?B?aXRvUGw2Q3J0Y2N3N05OakdHQjFCRHpGS0c3bjl6TEhTSDMwUUJPMDVyMngy?=
 =?utf-8?B?NzBCeE1ONUlXT3lNMTlHUS9rTzhNRmROUmQ4OW80V0xFaHFYYmFMY2ViTTBS?=
 =?utf-8?B?bktMWDhoNlljL0ZOQTFoN1RJWGU1WWloRlZFM2MwY2VVZ3g0Z1lzbE53RHJO?=
 =?utf-8?B?MUc3VmFZVEJnd3NWODlya1h2QWRCdnkrTlc4N3JJdktPeTN4UWI3MWhrQkJT?=
 =?utf-8?B?VnVZQldITUxhTC9KeGdYcnRBUDREejdoYm1HRnpkRFRSV1g3Mjk0OGNyM3lw?=
 =?utf-8?B?dTNOMzBqdjJiN00rM0t0VTVsWmxVTnhyZHFYSzFpU2VVcmtJdzdVblAwb0lo?=
 =?utf-8?B?ODhMMDFsTmZoRElISlhtUSs5ZDA4UDJSZjEzU1NSaEdUeHdhSG9YZDhzQmRJ?=
 =?utf-8?B?QytOMXhYL2NXbVh1NUM5R2VsSG14TDMvZk1VOGlRYU9FM3hkTlpYUHRpek1H?=
 =?utf-8?B?Uml0Z3JoVEdsdi85clBQNFYzaUJWRW8vNlpNWUEyWHVkck10VjV2c3VkZ3hH?=
 =?utf-8?B?Z09uRmFzSVo2L1FEQk1uL05pTC9GeWhjR2hFUWliVGpudGI3REJudXpLeU15?=
 =?utf-8?B?cHJLbzFUeFRSVmhTMGRhQk9EYzhyY2RlWDcxcW5Ca3BBcHFNRXpjbTRoTThC?=
 =?utf-8?B?bFV1VUlJUXU5UUNwWm1pVXlxdW4vd1oraGFyNEdtK3RpM253T3VlVVlPdFpi?=
 =?utf-8?B?REUyRXY0NW5QcVhTREJTSWhlSm9NdlhXSzZyVWFnenFHUHlGek5oUTB4WmdC?=
 =?utf-8?B?YUJWeWdvTWg3ZFdaRE9wSC9mQ0J5M0twYTF2d0RUSDVXK3BFSDdOZkN6TTNX?=
 =?utf-8?B?anpLNnJKS1BZaXNaai84L091NzdkOGlWemhWYXRlcyt1NTd2c0RlbkpEZjZE?=
 =?utf-8?B?Um9Cb09keFVmeFNYTVpqU09NNENaeHFmMnlTMXpJMlNYV2RDV3dDRGRmZDdT?=
 =?utf-8?B?MVVTTlJHdWdzU1NLUlJhTUlPQlNZSlFHb09wbmw5MTNvUUNPR0pkeTdZTDFP?=
 =?utf-8?B?aXJiWVRPMDVHVVhyV3QycGdOMUtpbTFKWGFGYSthNy9QK01TVFpDb29tdGVB?=
 =?utf-8?B?Q3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3087cb85-86e9-4a8a-23e0-08de04c630b4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:50:40.1720 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyWNq5cLOmFDMZ1vw5H6w8G3Ehl9w6Kg1XvM8HEfbU8QAYAE265zb9iAfInqVZqsPOftkjXhq/zVhb9aJreMpyaD03Xp10LQvQM5LUHO+F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8611
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

On 9/26/25 6:29 PM, Peter Robinson wrote:
> Add support for MNT Reform2, it works as a carrier board
> with a Firefly iCore-3588Q SoM.
> 
> Specification:
> - Rockchip RK3588
> - LPDDR5X 16/32 GB
> - eMMC 128/256 GB
> - HDMI Type A out x 1
> - USB 3.0 Host x 1
> - USB-C 3.0 with DisplayPort AltMode
> - PCIE M.2 E Key for Wireless connection
> - PCIE M.2 M Key for NVME connection
> - DSI to eDP panel
> - 1Gb Ethernet w/ Microchip KSZ9310 PHY
> 
> Tested using Fedora boot on USB stick and eMMC.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> 
> v2:
> - DT now upstream
> - dropped extra -u-boot.dtsi bits
> - Run synconfig
> - Minor other cleanups
> 
>   arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi |  3 +
>   board/rockchip/evb_rk3588/MAINTAINERS       |  6 ++
>   configs/mnt-reform2-rk3588_defconfig        | 84 +++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst             |  1 +
>   4 files changed, 94 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
>   create mode 100644 configs/mnt-reform2-rk3588_defconfig
> 
> diff --git a/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> new file mode 100644
> index 00000000000..e1bdd5f98c5
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-mnt-reform2-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588-u-boot.dtsi"

As far as I know, this isn't needed as it's automatically included if 
rk3588-mnt-reform2-u-boot.dtsi doesn't exist, c.f. 
tools/binman/binman.rst. CONFIG_SYS_SOC is set to rk3588 when 
CONFIG_ROCKCHIP_RK3588=y so that should work just fine.

Cheers,
Quentin
