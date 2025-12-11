Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248F2D41C20
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7C083C08;
	Thu, 11 Dec 2025 11:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="kQDhDzAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C7F83C94; Thu, 11 Dec 2025 11:57:33 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22C783BFE
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuCMNqGhiRbJaPFj822Gayi8VXGpBGWcaJZl0WBfNkYOxmBfUD5Qyc6WM65Vt/3n3t84Q6crrbIkbYfVs1naQHoLJKLkajUJbdIgnHgMBkNdZ88xtqlO3TsJ0R+L0ISyExG+wM/9+U8jzNg0YKikqCX8aiAANS6H73sRq3qeNlvi0UMEQLJYzJbuC0rRo2SgtPxSBFYYnPRb6MmWwQUYpIsBbhMF0mCWwBbiS+1kKr/VCNfJpVRtzpUmyo5xF/Mpk7Iu8GooTzlcpPDJ/yVgW2+UDqYZtPmjw0Ox591bn5CLui0aeJaq6sndclgJRUVEHpKVuRA1zTepW7zhHrnRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aY2cuDY8lqQ57UNJyocwOUqmbQpJSiy0VOAPZ/7RZ3g=;
 b=ddg6CvvyIiyZmmFkUqcrZRCM1a+Xh7m5XbH6GVppK0spVN7muN9sUf9plgqhvBEC7Ts7WkGwGfB+qV051IVvKguVYat2nfBrS/Nk84qifNwa5GDfghclCUwZoEJ5AbwLoNkqJyyyfZEu0oz2jpFhFtoyNwLQWStyBzaQU/tI/ZUMmlazfw9GhvP9pNAQ8M2/zhXAR1Q34bifKj6O+6sBOnBxCS1ngeX9IcOmgOHIodvGlCkKrqfAmiR2MhCgfO6UXGTIZGsb3koZSQ/RkW7jTxaFUnJ8kGai0CjazVlCMLRGrQ+IX8pFLZQgQhor/8yMfLkHShyBzUHZBdvav/bj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY2cuDY8lqQ57UNJyocwOUqmbQpJSiy0VOAPZ/7RZ3g=;
 b=kQDhDzAaIPwTKaYGzaMq4s3vxOmvn5XksYkE8dFWLDur13bbEWlbWRccAlo+R3zg9PhKhYTcN853kzgwlSxMwBvEj0tp/F76P3qySSVnTsa9DgIS/TsvNmSn68Zcpi5poqyykxLXqkhpH8VbNxAGDR4Mgbaonr0+CUwmE5PMh7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AS5PR04MB11322.eurprd04.prod.outlook.com (2603:10a6:20b:6c7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 10:57:29 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 10:57:29 +0000
Message-ID: <7fa7ee4e-94ab-4338-bb01-481a68768922@cherry.de>
Date: Thu, 11 Dec 2025 11:56:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk356x: Stop overriding sdhci/mmc aliases
To: Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
References: <20251209211807.497095-1-pbrobinson@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251209211807.497095-1-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0007.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AS5PR04MB11322:EE_
X-MS-Office365-Filtering-Correlation-Id: 5024410d-82c6-4767-7615-08de38a413e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWZsck4ySFVlZytVRXlYL0xWUHhJb2xUNkM1S1JqbmhtYUZxcFRIM3I4N1B1?=
 =?utf-8?B?cG1OUDIvZGl2d0ZvY1lKMENKTVZTeG15MXZqUll2MzFiZjZSUFN1cFFkMHNa?=
 =?utf-8?B?eno0bzdZcDZrb3VGZncxN3lJaENDaHRORG1icTVNMWMvbzlkQVFud0hUMXp1?=
 =?utf-8?B?cXhkbjhqcXhJcWllWFVKVmRxVzliVFFIL1hRTnUwUDdDZWxHNUJmcGlsSVFX?=
 =?utf-8?B?OGxGYSt6aU1tRldBQnhnQittVWFHMkZxTlUvLzJMMEViVzFES2ZocUtkcFJu?=
 =?utf-8?B?NVd2NmZTK0M5dE5USEdXSktqcGtBVC8vaGlpbHdOaFBrSjk4ZjZlYlZPZnhy?=
 =?utf-8?B?L1NFU3RrNDU3VlpBL2wvcGt2N0UydGpJRmdqS0pkWGxmRUtLZXRFNWVKRmRt?=
 =?utf-8?B?VFdQZDNTZnpZSU9zY1dGZkxiQ3gvN0VheWdaY1ZFMmFTbWNnM1VybkJFZlJE?=
 =?utf-8?B?OWJUSTVZNmpEK2R2eU50b2xMc1VKT2FhWmFCTEFaeFV0cXd6SFFSbW5VeDE1?=
 =?utf-8?B?d3p4OFY2RlAyeFNxcjczME95anZMSUtoYndqVXpZVTFlazQxOEJMWTdaSXdM?=
 =?utf-8?B?MFZmS2RucEk3dFIrbjFEV21SYXBlVnhwU2hiVlNkTi9OWmNTeFdpU3dwajJC?=
 =?utf-8?B?TXVxQ0psK3R6enMxT2NqNFIvWTcxWEpUVHV1YXlPVjZrM2d5N2I1QmVNMkQz?=
 =?utf-8?B?R2ZCRDZvbFQzY21RajZWUHQ3dUFtdkkvMEs3dDN4aXZEdmFraUtDTmhWcm1r?=
 =?utf-8?B?dTJ2VkUzeXRxdjA4aklPTHJuT0FwVVpmN1I5MmsxcGt2ZmdxQmppTFh4WUlx?=
 =?utf-8?B?QU0zZGJzaTM2b095TjFIWVRSUk9taUdvdTBVS0toSGpQZnNOMkI4YTk3Sm9V?=
 =?utf-8?B?SktKSFlnNkpabEhiYW11VUhGejRickVPNFZFZkdMOGg2andmcExNZG84VFJS?=
 =?utf-8?B?YjRHRnZvOWFqRmRwTEZ1Z3hjdlFJQXBFSmw2c3hOMmtUNlpQSjlpMkh1SUxt?=
 =?utf-8?B?OThRRGZMc2JxUng2Z3R2T3lvWkhmcUZSWEU2RTRmSEM3cHFqdGI0c2J6TUhD?=
 =?utf-8?B?VDI0bXRnNVlzUWFCOVVDelpWUHZrbW1LZDcrNitCWHpMZ1VEZkNEU3Jyd09l?=
 =?utf-8?B?MmEwcXNiNEhWUFRENzdWS2xJeWZWTm1RUzA4VVQ0eUVRdUtMeGs2Sm02S0c5?=
 =?utf-8?B?YjU3UlNselJBZlQ1OVRjUzdjaTM0V0hPTDZINzZRZkhvVFR4Nmh3T1dCRUpZ?=
 =?utf-8?B?VDIwaXBtZGFjcVVEUkU1ZmltY1BvV1N5UlBvcEtiUEFXdmNXOHIxMlF6NEc3?=
 =?utf-8?B?TXEwZE0yeVA3SjU0dCtkaDlFN3dpNWwzbWhMYitFaVUxWkd3V2NiYmh5YUNV?=
 =?utf-8?B?UHBSZWJaODZFVStVYmhZTThBMEMwWTEyRUF2dEhWSFJ1VCtLa0JWbndsVEVu?=
 =?utf-8?B?ZFhEemg4WTVLTVYxU2szUTJ4cVBieVVBWHJZZWg4eXdYQVlFb3VFdFJmTDFK?=
 =?utf-8?B?Tk9SdzVNVU1RQ2UzS1FsNjRGTS9JY244WkFLMkVkUisyUk1tcXJySm1WMGFi?=
 =?utf-8?B?cHhmM3p3MkpGNUgvNlhRMGRDWWJsUkQvRHlDd05zSmJuc2VPU2R4ZTdxVm1k?=
 =?utf-8?B?bEVwRGhpM3ArMGhHM05rMWNjNzByLzBBK1N1ajZ1dUdTZHBSTXJsRjVsQUVs?=
 =?utf-8?B?Slc0K25objBETWc1TU5xaktHdlg1ak1kYnlIZDFsSVgrMG11dkJwQmZZSUtt?=
 =?utf-8?B?RENCVTV2cEVoREh2MmdSR3BqSmpMMTh0ZVdDbjNIeGlCMVFQSzVaMkZsNnJD?=
 =?utf-8?B?MTdSb2N4Q0w1aDF6Y1g4N2t6TDJuS0xDM1FXK2txT1lHUFhwODhSU1F1cXBz?=
 =?utf-8?B?Qm80MU1QK2IzVnoybHdQcE8wQVdEeWVQOU5ITzFUT1pzS3J2NzZ5ZXhYb2Uz?=
 =?utf-8?Q?XYjFjM2yO4NZPROlVvz6d4lcRK1zNTqJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTkxWHpybTZkdVBocFN3VzlLNldvcFFoMkFERmJBalV0QU1aNytPUDQwOWFl?=
 =?utf-8?B?bzdTL3RNZHlkaUJEc2lFUEsvQnl3b2V6cHJvQlljS0lkYTI0RzRiRWtmT3o3?=
 =?utf-8?B?MnYxSUN1SDVpS0U2YkZVWG04YWlLNVN4dXlRZXZSbFhqTS9aSE9GNzRHVkdj?=
 =?utf-8?B?YUJCVlRXR04vWldBbDFzSHZBUnBnWld6Mm9zL0tieks1bkVnUUlTWXZHUDVw?=
 =?utf-8?B?T3dkU1ZJbDluOHVvbGladC80QldEaUIzM05vOXFBUzJjTlRmN2FKSDVKRnhk?=
 =?utf-8?B?Q2d0ZjhldkRrUE9LUVoybS8zU0NkNnRicjA1cEdEQzA4VFVOdlREMU4rVkFo?=
 =?utf-8?B?R05xTDJMOUROaHEwN3BlTjRsSEpIa2lvRXN1UzZUUkg4MTNLOXlTazVEbGFv?=
 =?utf-8?B?aUhBTkN2YzRtMWgwODhGalZzL3Y5aTEyZUwra1JITnJtMUUrQlNkS0J1Q3dh?=
 =?utf-8?B?TWhQZFplM014bnY4T1VVcitRa09rQU9IU1crVnhMcFNyV3B6TjJNbElrNFdG?=
 =?utf-8?B?b2FvUE9TUkNKYlBRQkVwYWJwdjYrMDBoMUppR1RrNUsva29DRndkMUMzRXlW?=
 =?utf-8?B?bitFc2ljRHdHNFU5ODJkbmp4bTQ2akFsamlaYmdyeEE5ZmpvWnJ5R2NXcndS?=
 =?utf-8?B?VzE2bUsrbXg4VTlEaGJFNHJiVHpValZYb1RFelVZN1ZzdHMrVlFoSDZKVGtC?=
 =?utf-8?B?aStoYWJacEk4bHBPcEorQUlmemUzaUllTVFQWGxhZm5qK0ZLUnN3YUVNblZH?=
 =?utf-8?B?SmFxTndiTEF1WU00NWNTUHBLS3BJSkhIVENEcWNmUW1VdkZ3QlVYbjNCWE1j?=
 =?utf-8?B?aHlHbC9sUFJPNUhLSnZqK1Rib3FTcU9XREtwNzFDT0hubkwrc2hHWklOWGp5?=
 =?utf-8?B?RFZ1Z2N4eGFtSDA1NFp3dS9jeDRsUmpVQTREbmZxUzA3M0dGdkMrQ3FneU1m?=
 =?utf-8?B?ZHZ2SjRhTFZhdTNab0h1RkVuRkNPbUovSzUyOW5sa1RMNkhkamJpVUM5cnFI?=
 =?utf-8?B?RzN4YktNaHVxaEdoaC9nVlprclRHNExPbjJWYVBhY0phU3dvMkF2V1Rta2dI?=
 =?utf-8?B?TmlpSnpjL01CY0Jta3ZFVnZ6cEd5aEFaTWFTZk1wM2ZEMGRwQ3ZNeFdRQTQ2?=
 =?utf-8?B?Rk1aelI3UHpZbS9hVFh4Sk8vV2ZLN3FFVmpxV2FoSlBKMGhNMTE1ck9MR1VX?=
 =?utf-8?B?SXdpVy91UEdTRnFub04wS0F5TElaWnRiYmVaWlpQK3pEdnZzOGc5ajlZUEdS?=
 =?utf-8?B?SDVIenR6ZWUvOUF0Q0E0dk9kYVlZcEJMQ1lRQ3BGekJYZzQrUDhoVmFNdFdV?=
 =?utf-8?B?ZkszMURVcTlaVlBlSnQ1TUFJZk9NYlR5b3NRSkhTTVZGUURVeXk0c3A3U3ZH?=
 =?utf-8?B?Tk85M2ZuTkRkSHUrK1FFdldKazRjQ0cyZkVITlBzNi83d3lRemlwS3V5ekpI?=
 =?utf-8?B?cDNUMnRuQXJCeElPeHpDZjFtaU12S2RWdUUrQ2lTUWttdEZYMzZRZHJZVUxv?=
 =?utf-8?B?N1VOb05pSmgyREk4aDRWRXA1aDl1RGF4cjBnTG0vSDFHaWJ6dkx6S1loMkl1?=
 =?utf-8?B?QmtMWU1Ca0FadzdWUUpKV2VXWEU4MklWN2swKzJFSGRqcUE5Uml2U00zUVZo?=
 =?utf-8?B?eVphMHMzaW50a1pHSHVXK2h5OWZ2WmtXYUdmVGVydldYVmZPQk5hZDBKa254?=
 =?utf-8?B?Q3k5Z1pwNGEveitNRlhkZTdYWk9QY3Frd0F4OXR6WXlQNnhoMExNNENxRjJt?=
 =?utf-8?B?czVwN043VU8xWVRjdlVueEU5MWJnbXk3c1BDcGhuYmwyWk9seEVoMTZxbVJt?=
 =?utf-8?B?ZnkyMXBaUUhEeHB1U1RHVmkyTEdyVU55YkhvQXBvWjlWS0d5QWRnUVRsck13?=
 =?utf-8?B?RCtrLzhpVnN1dVRPeEpBQTNyVXNwVGxDdVJHZm9PQnJRWDVORUIrSm95dzdD?=
 =?utf-8?B?TlhNSWdncUxqU3pvSmJnSUhHdWFCZldMUk9wR3dQODNuUUMvMWt0bXNLanBY?=
 =?utf-8?B?dUwwek14RGxVQlE0WFdsZzJnbkRYSXpxUkRiYVNscTVPU082elJPL3BkRUVr?=
 =?utf-8?B?dXFsRDZyUy9kcGFmaVN3S25yVzkxZjNnOUFMS1NNQzZtNjUweHFwclVweDV1?=
 =?utf-8?B?bXNwNFZxOTJLTkpnczIvaDY5c1l1ZW5GREZnWTFYRkQ4NGZuSzRlMWNpa1BG?=
 =?utf-8?Q?yCbFNJAmrCI+yZnDAl+JEFA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5024410d-82c6-4767-7615-08de38a413e7
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 10:57:29.4116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AeeIHf324PKNHwD+SqgXw5+9vzwFj0NNc/TQurAMLHz/IgeuapPqxDuvuylzHopS4Zo33dOx2m12Aw6HfZSl3mczOtczEKSDAv9VDXK6gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11322
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

On 12/9/25 10:18 PM, Peter Robinson wrote:
> Upstream device tree has rules where the aliases are board
> specific settings, no SoC settings. Looking at upstream
> rk356x boards there's a lot of variation in the setting of
> mmc0/mmc1 based on the device so we should not be overriding
> this here and now we sync to upstream we should just consume
> those settings, to do otherwise confuses users.
> 

Do all boards with DM_SEQ_ALIAS config set have these aliases set? 
Otherwise the MMC device index may change between reboots.

While this change is appropriate, we should care to not break users just 
for the sake of being correct. The easiest check could be to build all 
rk356* DTB before and after your patch and see if it changes something 
and for those boards whose DTB changed, whether they use DM_SEQ_ALIAS in 
some U-Boot phase or not.

Cheers,
Quentin
