Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41C5D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D10883A8D;
	Tue, 20 Jan 2026 15:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="K1tLSzzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC7F83A8F; Tue, 20 Jan 2026 15:49:31 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 844DA83A6A
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaklBy3jD45+H8gCfUkmHVQ+eWEH72C/ka8KHez8Z9S5QuLI3H5UplUFG7GWYfu3VEd8kxuFEw5zli7hpvpiBHdRi7LqaocwdqQxTcJDUK+OfKbiWBuGcp0kvXtiBrJxkYgjpARvJi9IRQ0urnV3oah3d7LcbY1S91DFR3pSEhHydhUKDbRelo3zExUN/hEXGXWowILISRY5/ab3U2arVazZFfpaOL5hEcFhc8zdiig+HSiGBduIY4iLEqMr+lGc1Kc0ikNZKlJNdA51ipCVkWunpjG4zaLj5UlVWTfADX/p2SXxj2eDLvjTq8yZ6BI6T//t/q2qkTIyh3JUQVDGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCgAVCgsC5Qlt1KVSNhY3JOwNxAWvA+yh3RgAPfRw9g=;
 b=n8GvCs8SzFs8dF51je4FWbOK9LCta/gv6Q+KW+ojcuno0bZZnbWgol90/BJ6fKc9o492iemdAZQHMKkXOgd4vkVnsF8PlbqgEzah2PuLGc5B/TYsHLFrkUXdfZWXw2JbMw6pYP+xg7h3aJfzup/yfUUjEVrwNp681XJ6H/4hdFltpPnfyA6V0yEyOdVUq8LlBRzruNRDYmo5Gb32ZZS2szJ5DHL2z4Xe4LMfqUAdH0Mm0yU5O6B0iUeHK0LPGZMXYovkR+frMc+WTp7UCtR/SQ5hTCcdL7IbLkvbqNgfCY1va8DW3rk24JWzDJNS4OI7zzcLTugmBCt3yB/ro28RYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCgAVCgsC5Qlt1KVSNhY3JOwNxAWvA+yh3RgAPfRw9g=;
 b=K1tLSzzFgC8gITfVxgGKMOP05AADjn5uz5urnx6QVNvVs7oZp+h4dnGYjjDySJb8dP3ZP//uvnrZsrv1QxdNMA7kuJjI8w5+g8bkGnvkbdtP6pzsUe/xPWiSCf4bcvteMDLRGFIpmN5kbA7/EO/wFUsmExO1lEswKmHQVXrNxW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA1PR04MB10961.eurprd04.prod.outlook.com (2603:10a6:102:492::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 14:49:25 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 14:49:25 +0000
Message-ID: <e0fe836a-c6df-48ec-a900-6d3b7865c786@cherry.de>
Date: Tue, 20 Jan 2026 15:49:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools: Fix error handling in fit_config_get_hash_list
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB2805945B3C37DE7E15F9FB45DA88A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <BESP194MB2805945B3C37DE7E15F9FB45DA88A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA1PR04MB10961:EE_
X-MS-Office365-Filtering-Correlation-Id: ac31d574-31b5-418c-a328-08de58331b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVNMYndHbEdHNk5HZUNBdWVIY0JsQlRiNWpGckExb3RDbkN5ZUhDZUlNWFhH?=
 =?utf-8?B?aFZKY0ZkWXZENEJ4RW0yUTFiS3hnUW1PbS9GZjV1cEpBWTNncFJyZXovVXdq?=
 =?utf-8?B?QUVGV2JEc2xiQitzU2JYdEZYTnhlWEVDY2FVNHJFSDVDMG1icUl0Ui9rNlJC?=
 =?utf-8?B?b0x1UXJtMEg1eEc0TVNVRTVZMG8rM01UeW1IY3RYMzBUbmVhY1pCMTFUS2JX?=
 =?utf-8?B?WG5rbStiLzM2NTdRNkpsVW5pZHdBeE9yU3M2QlhBcUpSMkROanZVWTN6YTZL?=
 =?utf-8?B?N0U4TGYxbTBCOGtOd2hjSVI5d2RxYVloTnFMRHpaMnBHTE1idVFYODA0T2FL?=
 =?utf-8?B?SHFRSGRMY2FzMERQLys5MkIxSUFRdm9zd1NRRDZCbXh6MmtyY0Y5S3FITUVF?=
 =?utf-8?B?dFNJZFRDbzB3UFVpeUV2Y0lXb3hNaXE2Zno2TzlkdmtPdTVnYkRSKzRFdXlF?=
 =?utf-8?B?M0lYd2RGbzlCQjdtazZ4OHVFbVpwT0pkazdQaHNveFpkUjQ0Y3pqZ2hKVmJS?=
 =?utf-8?B?YktXSWJkeE4vdGl1VjFaQ3V0Z0VoZTJ2ZHovNEU3U092UE1LRTlpWlBicjRr?=
 =?utf-8?B?U1JFNVRnc3dWQ0lrYndabmtvSC91SVBmWWlpbVpLbzgyZGVjeWxtdmJtcUJC?=
 =?utf-8?B?TGdHb1gwanM2SFBIV2JtY1d2aFFmRXlwUExUN1RjYzh1L1RuSTZuVDA3VndC?=
 =?utf-8?B?Vk4rbWdOZXV1T2ZZQm9DSHRPeDRYTUJRUzlTQkNIUGVzOEdmVFNDMnExQ2JB?=
 =?utf-8?B?WFhQR0Zya0lmNGVCQlNramRicTNMd1cxSGV2QjhBM2NHSno5ZVJmRklWUW1q?=
 =?utf-8?B?WndKUjVEQzNBUU9wM2t6MG9pUGJENVFmaDZMRENaL2sxWmNlTDNIelhQMFla?=
 =?utf-8?B?TnZDRThJelcyL1RWZCt2bEdmbmVqZHBkWFZHcXFucjBKajZibEViSFd6bVZ6?=
 =?utf-8?B?WjdwOE1tVlF6ZXNnQVhmVnhpdnNVTXZnbzBXc3dVWFZUSGFRenZidnRsZ2VR?=
 =?utf-8?B?bUhWd1d6KzN4YW0ycmwyWXFma210emF6bk5GTHFZdWFvZU9qb0p6RGEzZit3?=
 =?utf-8?B?R01ITlRQWXNwekxNRlJMOGNLbVlvV09jbUtOQUxINXA2MXZLK1ovaFl2UFBG?=
 =?utf-8?B?ekRKb2dkSFhkSUw3cFp3VXc0QmNmdGNNVEFoWGNaa3JyT3IxcVhpU0o2K0lV?=
 =?utf-8?B?QnpSaExzbGpsc0dscnZ2WUloRjllVTE5R2ZiSEh6cHZGbHE5dWdNTUpaSktK?=
 =?utf-8?B?TVM2SXNPc0FWM05vL2xXZkRjN1ppYStJSDNKcTJiL3NFR09lRHVLV29GWnor?=
 =?utf-8?B?R3piaFNRMXRVSEdnVmROSnBLYnFQSEg5ZHU0VHc1QVo5R082blB1eHU4ZjBu?=
 =?utf-8?B?UmQ0YVJqYjM5S1ZUcFlUK2lzY1JsVlBSWnNMQllSQlcxeGVRTmxpOWMveUo1?=
 =?utf-8?B?Wm5GMmxXMVhIWnBtQ1g0RFA5SitoT1Vrd0o2aTBNME41MWorS3ZxOXk2SHlP?=
 =?utf-8?B?R1RENDRGMzA1WTRNTzJtR0NYV1ZRcmhwR3M0VitkZ0JHSUxEdjFxMzZtRTRa?=
 =?utf-8?B?T1ozSUVMbUtrVWhCZXB2QjI3Y1o1VHpBNmNYY0dHcmU4MWlWTDhlaElvSnJx?=
 =?utf-8?B?NDVjcC9uZW5pK29tbEo2MGVweHNwWHZyQWk3YkhMaGlkNkN3ZjM1bmhYVVpj?=
 =?utf-8?B?dlRUbmhjUng0eXArQy9ZbFJiSUN4VU5hVHRGODZObU1iVTIrVXo1azJPR3RR?=
 =?utf-8?B?RmR0eEtlK3RiVzJNcFBqam9XeFFmTk9pd29TNi90cEE0MnJiZXpKSkpDNVFW?=
 =?utf-8?B?OHlJQ2RqVDYzc2RIQW81OFA3bTgxMDFsTDNqeFcwOUZNa2xYSzNDRFBzeEFI?=
 =?utf-8?B?M2FzVkV6c1lqMzMxS1NVdmFxTHZvNWFRMzhMbkF0V1hDelBTWXp0SmRDdlNs?=
 =?utf-8?B?WnNoL1NQViswUmNPTDcvQzBLbm5OZlVGNnVsL0NETjEyVEtlZnlxSXQ5RXhT?=
 =?utf-8?B?KzczOHQ0Wmpsazg1YzNRdFo0QVBUdFJlYTcyS1VVdm95eEQ3TVgxd1F0Znl5?=
 =?utf-8?B?YkFlVkM1QVpoQzRESTMrZDlEMUhyaC9EUDRibEsrNlhUTWM2aitnSHlwRlJB?=
 =?utf-8?Q?o11o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7142099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTlWOWRmdUxrZkc0QXhtSFIrN0habFVnUmJ4NW1MYWE4MlBpaXFtSFBaYUhV?=
 =?utf-8?B?K25nTGw3dFVFNGRSZ251NnpIZWY3a0VpNGhYY01MTzRQNGNTcmVLRnJtTFhw?=
 =?utf-8?B?cFRjVnhVQjlhUnVwZTZ4ejVDNVo2bEw5SE5NdXRQSkhCL2NDOWhoVERZYmpW?=
 =?utf-8?B?VnJWbVdHakR5NUcvWGpEZ1VlSTNhS3B0UjhsbWhiTTUzYzRTOURGK3dKU0VF?=
 =?utf-8?B?ZlBBeWJVNDVmOFV5ZEUvTXRyTkpPTFhOR2VqSUN2b3hGTUVlcTVmeW5EaGZy?=
 =?utf-8?B?SDJSSHNsWjU0cms1TklrQ1JXUVB4QjlyQlZkcVZ1WTN0QWdLM0p4SmszQVlu?=
 =?utf-8?B?UlpZTXlSVGRIU2pXQ1h4THI1Y0NYY3B1cWM2bE40eENkbmpyQmNuM0tESjVB?=
 =?utf-8?B?SlZoZjRQck1nVXJmc1NKY09yQ1MwS2oxQ1NXTTgxTU1iNUFnQW1FK2Zad3Jx?=
 =?utf-8?B?dk1leTdraTR3OFNxM2xNSXRNd2xnTVF6elQ4SDFRYU5vdHg5MzN3a2VzYmNI?=
 =?utf-8?B?SDM3VWM2RnNlRXVBQW51T0I1V3Yrcm9qeGVQV0pMbVhPdkhXZy9hVHRHNWxR?=
 =?utf-8?B?OC9zcW5NUUFVM3dQc3JvaytvZDRnL1V1QTZkTE5UYm80d1VYemtIVVhwZnpz?=
 =?utf-8?B?K1BZTUR5MEMybVJUOG9zcVh1U0JEOHRxVzVxRDRvdUtuSWh3RnZOV2I3MG1x?=
 =?utf-8?B?SzhUc0wveEdRNDBoUDFHVHJWQ0k2dm1URzkzdUh0aXlPZjVRSC9jZG1jREpv?=
 =?utf-8?B?bFc5dUdPeDRQekdkV0F0OWt0YTJtZlRMOUVTY3c2WGlHVzltSGUvb3ZQaGk4?=
 =?utf-8?B?RzJUMTRuT0xtZ0dDWDZ0enVpM3VldXk1c2NrT25BUzJjSXk5emliWXFDV2ZN?=
 =?utf-8?B?MDRPUTA2TjVrM2NRdy9nckxWUTVMTEx6Und1RktwK2NXSFU5OVpFejFuZTJq?=
 =?utf-8?B?ZHV2Vmd6UThqTTl0MGpPQzQrblR6U1Noczc3L0hUajYwczM5dVJiV2pkemFy?=
 =?utf-8?B?WGNNWlA5Y0MvMkdycnpHeFVYWDZxZ1NINmo0cVFlcVRIOTR4cndzZE9yYlpG?=
 =?utf-8?B?R3FWR1BpVlpFQW1zRlNtVWZRVEs0RGliNlhqMXZwYVZ2M0t1b3RWUU5lN0ZS?=
 =?utf-8?B?RlFkQVg0RDk4VWFlRUI3NEQvbC9GRlRaRlFWSWJwbUQ4S1lKdy9ZWEV3M3A1?=
 =?utf-8?B?dlZmTUVBK291S25meHk4QTRKTWIyRHN4dGsyOEdsN005Nk5CZzB1cEFwTldm?=
 =?utf-8?B?eklMdzcrSUE5cGVaWU1GaHVTUEdUVUJmSWQwRURxM2d0NFVlbFhhSU5ZcTh4?=
 =?utf-8?B?SWNEdFdmTStnYTQxeEhJU09IbHZGb29aZHBFNnNaT29PVjRUKy8wOHgxb1dl?=
 =?utf-8?B?UFU1b0YycE5QYjI2VWhYd2ludGYya2dTWGtxOXNiYVNtaWIySXJZYXVIS2V5?=
 =?utf-8?B?dDgxZEFFZlhiTWFpbjh6ZlBiSkxOZzk4cGVTSFhHaDZqQW5udmpaWDNxeW5n?=
 =?utf-8?B?Z2h0WEY0eGZpTFVLaUJzNmZybGh1RjFvSHZQbW1vVHRMZ3lSNUdNaUNKVHpJ?=
 =?utf-8?B?TjY4VzJVWnlaVlVlMzJVY3F5RWVlTGxlVG4rYzFRaHVWL3BpVGF2ZkVTTHJK?=
 =?utf-8?B?TllFYWNkaWt0NHRBZzhWeTErT0gxRzhYdFh6OEM2clpmR1h0aUVSK0dGMkt0?=
 =?utf-8?B?NGVlbHFLNnFpRHBtRUZUMGQ5bndVdXZGSXhjTmhHY0VVWmRxYWVpYkwyZkFk?=
 =?utf-8?B?VStrTzRKcFlXUFE5ejFTRTU1aHlraTZvZ0ZOTU9jMzIreU1vNDMvV3FLY2I4?=
 =?utf-8?B?dFY2OW9NbzlwUzF6YkFEd2lSeTBEdmZ0TitUS3EvZEFncU8weUZjZUlhck44?=
 =?utf-8?B?eWRwSjBwMUJqR2pYSnMyZDR5bUg1NXVqL3I2MTRBMzcxbmV6U0RtV21hNXpj?=
 =?utf-8?B?TWlwcllkV3dQREZBamJPVVN6ZGRPaUx5MWZRdEpYN3oyU3V4K21YUElWS0U3?=
 =?utf-8?B?V0lnZ0p0Q0NyeWw5S3dPKzdqbHpKdUV4bjlpYkYrd0dmNXFaMnZjU0p0aGtv?=
 =?utf-8?B?c09vUVNEMW03c1RnUCs5SXpCN3llM3ZsTllnMHJQU1c5bDBzM3l1TTBLaDJV?=
 =?utf-8?B?aDhnNWF0eXhCWTZ4VHRwWDd0YXlJSitZZXZ5Q3BkZjd6NWVpRXN3dW5kd0Jj?=
 =?utf-8?B?YXNTOXMrMWloRFB2YlMxbHZqNDdVSlpqZ2hkQ3RscWxCZytKQ3NndE5YbXEz?=
 =?utf-8?B?YUJkVXdodmQ3bzZpamZEd3lLZ01LOHQwakJ2ZGNPSDcrdERybmMrc2syc0tJ?=
 =?utf-8?B?M2NaeHZWV2NlRnRmR2RiMUtZMHYrc0FVemtwbU1pTDlUMzA2ZE5XcXdFY1dY?=
 =?utf-8?Q?D0XUNPD14GhkzoMR0lXGmeWq3U8qMxoL6ycwN?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ac31d574-31b5-418c-a328-08de58331b1b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 14:49:25.5398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSqAabfI6YYBsHx4VrDAVguT7uhbamBC/QRIfjyne4bTVvyoo89fG/iYXL2+4gsfxislssIQ9JdaPLtqndt/S1B06XP0iS0Zn8q91PPNn0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10961
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

Hi Francois,

On 1/19/26 3:47 PM, Francois Berder wrote:
> If an error occurs in fit_config_get_hash_list function,
> one needs to free the node_inc string list.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   tools/image-host.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 48d69191c92..635a75afe5c 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -924,19 +924,23 @@ static int fit_config_get_hash_list(const void *fit, int conf_noffset,

Aren't we also missing an strlist_free() before the goto err_mem?

I would suggest to rework the error paths so that they all end up with 
the same logic and make it harder to forget about freeing the list, 
something like:

"""
diff --git a/tools/image-host.c b/tools/image-host.c
index 54df86316ae..8f9343f65d9 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -894,8 +894,12 @@ static int fit_config_get_hash_list(const void 
*fit, int conf_noffset,
  	strlist_init(node_inc);
  	snprintf(name, sizeof(name), "%s/%s", FIT_CONFS_PATH, conf_name);
  	if (strlist_add(node_inc, "/") ||
-	    strlist_add(node_inc, name))
-		goto err_mem;
+	    strlist_add(node_inc, name)) {
+		fprintf(stderr, "Out of memory processing configuration '%s/%s'\n",
+			conf_name, sig_name);
+		ret = -ENOMEM;
+		goto err;
+	}

  	/* Get a list of images that we intend to sign */
  	prop = fit_config_get_image_list(fit, sig_offset, &len,
@@ -923,13 +927,14 @@ static int fit_config_get_hash_list(const void 
*fit, int conf_noffset,
  				if (allow_missing)
  					continue;

-				return -ENOENT;
+				ret = -ENOENT;
+				goto err;
  			}

  			ret = fit_config_add_hash(fit, image_noffset, node_inc,
  						  conf_name, sig_name, iname);
  			if (ret < 0)
-				return ret;
+				goto err;

  			image_count++;
  		}
@@ -938,15 +943,15 @@ static int fit_config_get_hash_list(const void 
*fit, int conf_noffset,
  	if (!image_count) {
  		fprintf(stderr, "Failed to find any images for configuration '%s/%s'\n",
  			conf_name, sig_name);
-		return -ENOMSG;
+		ret = -ENOMSG;
+		goto err;
  	}

  	return 0;

-err_mem:
-	fprintf(stderr, "Out of memory processing configuration '%s/%s'\n", 
conf_name,
-		sig_name);
-	return -ENOMEM;
+err:
+	strlist_free(node_inc);
+	return ret;
  }

  /**
"""

What do you think?

Although.... I'm wondering if this isn't just backwards. The caller is 
already responsible for providing the strlist pointer AND freeing it, so 
maybe the answer is simply for the caller to *also* init the strlist, 
something like:

"""
diff --git a/tools/image-host.c b/tools/image-host.c
index 54df86316ae..fd56e603114 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -864,7 +864,8 @@ err_path:
   * fit_config_get_hash_list() - Get the regions to sign
   *
   * This calculates a list of nodes to hash for this particular 
configuration,
- * returning it as a string list (struct strlist, not a devicetree 
string list)
+ * returning it as a string list (struct strlist, not a devicetree 
string list).
+ * The struct strlist must already be initialized.
   *
   * @fit:	Pointer to the FIT format image header
   * @conf_noffset: Offset of configuration node to sign (child of
@@ -891,7 +892,6 @@ static int fit_config_get_hash_list(const void *fit, 
int conf_noffset,
  	 * Build a list of nodes we need to hash. We always need the root
  	 * node and the configuration.
  	 */
-	strlist_init(node_inc);
  	snprintf(name, sizeof(name), "%s/%s", FIT_CONFS_PATH, conf_name);
  	if (strlist_add(node_inc, "/") ||
  	    strlist_add(node_inc, name))
@@ -995,11 +995,13 @@ static int fit_config_get_regions(const void *fit, 
int conf_noffset,
  	sig_name = fit_get_name(fit, sig_offset, NULL);
  	debug("%s: conf='%s', sig='%s'\n", __func__, conf_name, sig_name);

+	strlist_init(&node_inc);
+
  	/* Get a list of nodes we want to hash */
  	ret = fit_config_get_hash_list(fit, conf_noffset, sig_offset,
  				       &node_inc);
  	if (ret)
-		return ret;
+		goto out;

  	/* Get a list of regions to hash */
  	count = fdt_find_regions(fit, node_inc.strings, node_inc.count,
@@ -1009,12 +1011,14 @@ static int fit_config_get_regions(const void 
*fit, int conf_noffset,
  	if (count < 0) {
  		fprintf(stderr, "Failed to hash configuration '%s/%s': %s\n", conf_name,
  			sig_name, fdt_strerror(ret));
-		return -EIO;
+		ret = -EIO;
+		goto out;
  	}
  	if (count == 0) {
  		fprintf(stderr, "No data to hash for configuration '%s/%s': %s\n",
  			conf_name, sig_name, fdt_strerror(ret));
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
  	}

  	/* Build our list of data blocks */
@@ -1022,7 +1026,8 @@ static int fit_config_get_regions(const void *fit, 
int conf_noffset,
  	if (!region) {
  		fprintf(stderr, "Out of memory hashing configuration '%s/%s'\n",
  			conf_name, sig_name);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
  	}

  	/* Create a list of all hashed properties */
@@ -1035,19 +1040,21 @@ static int fit_config_get_regions(const void 
*fit, int conf_noffset,
  	if (!region_prop) {
  		fprintf(stderr, "Out of memory setting up regions for configuration 
'%s/%s'\n",
  			conf_name, sig_name);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
  	}
  	for (i = len = 0; i < node_inc.count;
  	     len += strlen(node_inc.strings[i]) + 1, i++)
  		strcpy(region_prop + len, node_inc.strings[i]);
-	strlist_free(&node_inc);

  	*region_countp = count;
  	*regionp = region;
  	*region_propp = region_prop;
  	*region_proplen = len;

-	return 0;
+out:
+	strlist_free(&node_inc);
+	return ret;
  }

  /**

"""

instead?

Cheers,
Quentin
