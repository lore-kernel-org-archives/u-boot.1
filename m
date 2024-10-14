Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2250D18130
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 17:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 099A388BB2;
	Mon, 14 Oct 2024 19:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Pl3Ea6eD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34CB488C9C; Mon, 14 Oct 2024 19:00:06 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9EBB87FA7
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 19:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dakA9uWDWMcxWKar4oWqgMQKk5OnQYBx4m9JW5uK/bvbM4aiM1n47lLqWlNJqruIQR6LcnFldM/B3vKDmea8Nt40nbbOtHqv1sdd+U24/tAVhaeQCrjJVOjudRrssMq65Z0hh7Y2syHzC+s3jsbU0jgMT52hKv8aY55Jn71t/NsFIQDNIiFPPKRa/epQi9le6vP5gu3M96mv/DQQLS+DlgrUQXu5aTibmnEr1Ls1ZEGdyLnKO+yDrk89h0owbXkRYOQvXTpLQfjaaYBPncK4r8OksVrdJ7fDEu6ve5Hxydz3lJpuBm/jxVfvAOIJqAx7I0PpyadVIN62XNLRtjTyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTJ4zkwJIt5EVp8UHBlJMIGqq7KR21YfDZC44ODZwpo=;
 b=arAnFau1Qtlp46DumKdBWQaORF0uAwb61T6KEcJN7jPMtB3OfUtcWSsI4yrA0jez1YIoOrIoS4yoITHso9Jn0kOwDSydVEwoA/mkBxEIhWeAm3HIDWUldVwgL5dPs6VCzO2w3f9Hx2BJnnVJdsRdV6X9s0gEZRvC+DpvZXS0J/lt+Nf+deZjgwob821UsPGEeFWpHVWFQchBj6IngCEz7Tz1HhB2MfgDowAEJEMpy+oxKNnWkHrrnDz8LIvMqrZmUlwpzK2KPWfLwpVRqKeXanN21DVIZVLT6Uqv1opJpp3FxPlJgZ/DetwYFLsgd/mz1DlPao6oyU3tCVINGK7avg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTJ4zkwJIt5EVp8UHBlJMIGqq7KR21YfDZC44ODZwpo=;
 b=Pl3Ea6eDgnpnn0aNNgI6jNIB76nTsbsVJfcTWdhGAUf7lGgQAND7V+pdKmeSqLNTbyugreDNWM1TdkzweA8fPObDWyFW7erNxr5apBuH1KZElpdB3KJREzVKUwsKZPtoPHI9wg2JPcvSAheW4hKxEuGA+CaZSBGSDgArPxPJSS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9478.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 16:59:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 16:59:52 +0000
Message-ID: <8341e1e4-b5da-4c2d-833e-bcc45cf5e8a9@cherry.de>
Date: Mon, 14 Oct 2024 18:59:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Mainline kernel bad magic for Pine64-A64-LTS
To: Louis Holbrook <accounts-uboot@holbrook.no>, u-boot@lists.denx.de
References: <Zwwg4oXUq6aWlk69@holbrook.no>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <Zwwg4oXUq6aWlk69@holbrook.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR2P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: a60df4ce-2e3c-4d08-3d29-08dcec719f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEpiZzh5RVZ0THVRbXJjaW5uM0FDNGFoQU1jalNYTWtNMW1ESjNOdll3NXBW?=
 =?utf-8?B?T215anFybHBvM0l2UVZrZ3pjaFoyODRDNzIxZFJHczZ6UmkyOFduV2RzN0kr?=
 =?utf-8?B?Z3F0bzFBU3dTYWZMckdvNmh1bmZ4ZFh4TTQ1eTZIdEJMRjNVUTFNYnZTcTQx?=
 =?utf-8?B?RitMR3c4aE5udGVMTGdmT3d5TmszN24rMkg5VDhEcmtpa2IzSXQ4OUo3VXNX?=
 =?utf-8?B?R1ZUaDhsK2NwT2dqYVBPYVpkVHNTSHl6U254U1oxVVgzWWRXOVFic3BNMUZT?=
 =?utf-8?B?VHhlazN0T3lIa09zRk1PZDNpMEQ4SmcxS1p0aHZEKzJ6Zy9lQVRRVzB3OE5o?=
 =?utf-8?B?Vk8zbDl6eXhaRFZFTm04OUxBb1g2d0EyVTZsTVZOWFZzTXpTMXVxa2tiaEtE?=
 =?utf-8?B?MHpJUHppTE1NZmwxZElNMVdZOWQzTGM0Q05NMy9WVkh1ajcvYnFtWU5waTBK?=
 =?utf-8?B?NDRxaWYwdEJtME9GNGFkZWlSWjczZnEyaGozUTYxeUwvUDF0cHR4bjNMbXpM?=
 =?utf-8?B?a1hjdjhUQkVvTUhQY3NNcUdNZnlLR2NHcEdiUXR4OWZkejZBNTFQUFp0dS9p?=
 =?utf-8?B?NXVCVktVL1pFeFh6RThhQzU2SDY5cFNWU2JzV2xVckxuckdCWTJZcU9hUzRL?=
 =?utf-8?B?NVBFVGIwdGlFTjZkbklMWm5SWjUzV0VETmpNWmtRZktiMkIwQTZ0Y2xqb3A2?=
 =?utf-8?B?VkxMeThzM0M5cGRkRldINEVreStEYzhQWWtaeEZvcVJYcnVVNHU0TWY2UGNW?=
 =?utf-8?B?TFJuQVRtUVl2WmlUeUtvN2l6cmI0dldwbnIyTjI1WitpMk9ZS0NHSEo1bHRo?=
 =?utf-8?B?dlY4SGhSUXRZS0JBcXE2cHBObkttTGo5QU1GSy8veG5ka3JFYmVrNjlWK0I2?=
 =?utf-8?B?N0E4SVdiVGNuTDJLbGh5UVBDYWhvNlFWTmNpZ0c4clFBb1F2bUdublF3TE90?=
 =?utf-8?B?VC93TmpMOXVuSmxOdXZsc245eDR4Q2xUNmZVc1dXN0xKY3A5Wjk1bVBiTlVk?=
 =?utf-8?B?ZVY5eHdUR2l0cnBNZGpJZWloVC8xYkhvYWd6VUprU29lZFI4NTlJWmhFT1Vv?=
 =?utf-8?B?Wi9JM3BHT013VnVXKzNoRnFRZEc1bDNMYlVnNXhyL0FFM0I4OXpLZEJsWFI1?=
 =?utf-8?B?aG5FUnNwbTY4WlAwM1JtdGVnL2JUUGxKVlZwbHVnaTdlYzhEOXZUdXJZRDJu?=
 =?utf-8?B?ODJrR1kwZjJvdFJMOFo0TGI3Z1pFSkpMNWFsb212Qzh0RVkrbXExdWVzYlha?=
 =?utf-8?B?bEdGb0tzek9OT0dqQzE5MlliTFhyNUlFWWh1U09TZmZFY3drNXRmMHVFaFFD?=
 =?utf-8?B?WDNkcFNoYkMxcjJLcDFJcmZ4Q0hDVDVzbE9sajYzamdzMUdYYS9Dd2YrRGRL?=
 =?utf-8?B?cTZldTlhQ0F0ejZzZ0VMZm5qc3d5a3hQOWZiOXRiOFVMajYxaVZnUHRVRVky?=
 =?utf-8?B?aUEyZlZwZjdiN09ZT2F2cWtyM2czcUhiaFFvVHk4WHZkZFE1OUE2OGdKdTBa?=
 =?utf-8?B?V1EwSjB2NHpTRHpnQ0JnUk9ROHE5Q1ZHN2czZGxkUkhRTjIvV2RPR2E5MmRP?=
 =?utf-8?B?ZGUxbSs2c0Ntb2VMVnJodG94OVN3K0ZGd1Y2enRTaFgrNkZkOHlmMUNyeGNp?=
 =?utf-8?Q?+XHL7Zr9j0d3a6VCEqJ+E5doxOHF/r7KBlULxYyE917Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHZJTmQwZHRPY2Q3czFwb1p0UUpEalMwS3ZFM3B2K0xiZzI1Q3BTZVhSUDVK?=
 =?utf-8?B?K0lyaGIzTXJjaDl1NjZPNkFEaHJ2Ym1kV09BNUtMbmdvVG82SXIwRktCVGlB?=
 =?utf-8?B?MEdiSEFmNnVjSlpjb1dzYmtWdU1aRDJ6WnozdWZDM0ZUbk9qenBrVHI5MmhH?=
 =?utf-8?B?M0EyN0l6NUhTbzZLYnpCemNMU0M4WitDV2RTUFRlUFdib0lvVVNzdWZ2VWdJ?=
 =?utf-8?B?Sm12Y3ZtQk00VWRJb0h6R2pzRXpmaWExOUIycDM2SUV2S0R4UUY0US9uTlI4?=
 =?utf-8?B?YW50dys1Tkcvc2JkNjZ0bGEwb2syYldJOVdTTlZOaGtxdWlBVThuWXcrN1pD?=
 =?utf-8?B?R0pnZWUxZzNwN1A3dXluSjNLN3FKaERKWFNkQS9VS2dIdis0d21YVFhaZWFS?=
 =?utf-8?B?MERkVFJhb3VtOFlLRjNEYlNOaEVRNDRTOHczc0VwK0tZQ2g4ZEhxSFNDZytt?=
 =?utf-8?B?VDhVc3J2MzlKTVh5SGdaMHB5TVBoM0ErMmxIRFJieExxWEU2NzBkOW9VYU40?=
 =?utf-8?B?eURXOGJTYzZQTTRYaHBLenhCSksyellkVFRYZVZRRm9aaVh4dW9qT01NQjAy?=
 =?utf-8?B?bG5MRFhZaXlIUTZlMG5uVHo2ZXFocUQ4dlBoVERadHR4cEdtQ0lMaW1lZ1VW?=
 =?utf-8?B?NGhhOVRNbHdiZFUydXg1U2RnZm15NG1VSGtoWWNtaE9FK3M3T25DRE9oVHVJ?=
 =?utf-8?B?ZFl2bFV5Y0lXb284R3R6NnI3NnhQVXpkYWZiQTVHMTRGcENVczhCYlQ2NlVv?=
 =?utf-8?B?SGJFMy9RR05uNnlURmdzZ1dUSmRUUVdMOEcwZlJhMnZoZXpYeS9BNGlkNCsz?=
 =?utf-8?B?WTNoSDc4bVhCOXhtNnVEcGFrbmdtRjRzZXBGM2wyN2NuU1dlNFBTeG81ejlm?=
 =?utf-8?B?Z0Q4cmkyZSs1T01TdlJQTUt3WnpqdmFtNnVvbzhXMnhmN0I5TTIwRVVVa1BS?=
 =?utf-8?B?RWFrTXd5TXBBNVhydGV4a053TXBNbWVNRW56Rk1ETVpHRnY1Y3NsaEhrelNo?=
 =?utf-8?B?TUZtUmt0dFFqMjMxWjJvTEJQYWVDRTdJeTRkYmJlU3FIaW9jZk9JcysySEda?=
 =?utf-8?B?TFd3MGhEMEFMRkR2MTRJQk1TM2Zscnd4aVYwR1RDSlpDNXhSTThlL05NSHhS?=
 =?utf-8?B?dXBEeTlSOHppWXVtZGdPbHlsN0R6SFBKbGR5NmxmM3Fnc1RHVHV5Zzl3L3Mx?=
 =?utf-8?B?d0NZV3BWYVQ2SzVsYngzT0MrQmFGT29lNjRwUm5Wa0ViYStYRnY1NlMrNlpz?=
 =?utf-8?B?cXNobmRKY3IzNTdUM0N0SWNFQVIzVm9WVE5HSGh2K2FCYkhJM1dHTHFUQ3RV?=
 =?utf-8?B?WVpwK2Y0TkFZTWpTYWhvNkcweWl4cjFTbXhqVU0xaVhTWitEMEpCZ2ZGdlpt?=
 =?utf-8?B?OGtCNzNCZGpWcmdYS01KR2NiRk9DbFhKSGgvRzNuOEtsUnY0L3JSVi8wZnlz?=
 =?utf-8?B?cjZuazJrUUhqVHhkUDYyK1NVVE8vUllzZ1JCRDlhSlE3WXhOSkUvdVMvaEx4?=
 =?utf-8?B?RHZaVlVjUEJyMkdRaC90U2VUM045T0FvTStGeEpBdzBWQjlJQ0RoamY5Rjcv?=
 =?utf-8?B?RFEvMDNKM2lmeHlrVDg4ZTJPQlQ2dGdKQmZCQmQzeGplSHNpaGxOVWVxWHNC?=
 =?utf-8?B?QVV1NzZMWFgyQ214cGpMNHIvRnd0UzhIRjFCby9QY3kyc2wwYkhxaVh4b0VD?=
 =?utf-8?B?WUhlUjFUdDMvaUFBWmVKUXpRa1dXVlM0TXJuV0xuODJhcHBhWlUxNG5nYXR5?=
 =?utf-8?B?Mmt5aUxNV1dUSVdzbGF0dFhUejRLa1d3QTcwelI2Q0c3dFAybXRySllkd1k1?=
 =?utf-8?B?MXN4WCtoOVJjUXhGK280Yk5sc2ZhT0pwb1IvanMvV1dhOVRYTVV3RzVyTjl3?=
 =?utf-8?B?MmRUMjFHVi9IbDYyK29DSUZDLzFNa3hHQ3hwVXBacUJobWlvQkQxKy9jN1dJ?=
 =?utf-8?B?M2Y4T0RrZ081STdRdkVEZ2ZlNTRHenErbDZVaWlRRlBYUFo0aFpxSmpvMFFj?=
 =?utf-8?B?c3EwbWpGb05MbWlMZFEzOVlBQnhKSFFEM1JXQXRkTzBuYkFRSTJKY01LZFU0?=
 =?utf-8?B?NXM0Z1l1RFpNQ0NBblVSdm4wQ3F1eUJqYTVNemZJZXY5RElrb21ERlJNdHZK?=
 =?utf-8?B?QXhsM1JRbDV3NTRwdXBqdXRLMWU2L0pkc0RBTzRxNThnUVUrbzNUeG9Udzdq?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a60df4ce-2e3c-4d08-3d29-08dcec719f24
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 16:59:52.7520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tq5tyatx0PSroM7Cn9NjrdKeehxpsXs5ca+d+/KyJyH2T+H6kTvobCBSBtod5IJ2nZZQ4W4vntftXNpiC/8fLzQ9FSROsHQtDhp0VvWc+VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9478
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

Hi Louis,

On 10/13/24 9:34 PM, Louis Holbrook wrote:
> [You don't often get email from accounts-uboot@holbrook.no. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> (Also posted in pine64 forum
> https://forum.pine64.org/showthread.php?tid=19460)
> 
> 
> In an attempt to troubleshoot failing to get generic alpine linux to
> run on PA64-2G-LTS, I've tried to reduce the problem to the smallest
> steps that are legible to me.
> 
> When booting the kernel, I get "Bad ARM64 Image Magic" I can't figure
> out what this means, and why it is happening. Sources I have searched
> seem to be board specific, and found nothing on this board. I've arrived
> at a point where I cannot find a way to reason further about it, so thus
> I am reaching out.
> 
> I am currently loading the kernel and dtb manually at the uboot prompt:
> 
> setenv bootargs loglevel=7 earlyprintk
> fatload mmc 0:1 0x42000000 boot/vmlinux
> fatload mmc 0:1 0x4a000000 boot/u-boot.dtb
> booti 0x42000000 - 0x4a000000
> 

Make sure that those are absolutely NOT overlapping, i.e. you may be 
writing u-boot.dtb over vmlinux and thus corrupting it. I've not made 
the maths if this is reasonable with the addresses provided there but 
it's good general advice anyway. What I usually like to do is have the 
DTB right before the vmlinux, like 1MB before. No way a DTB is going to 
be bigger than that :)

I have never used vmlinux so cannot tell if you're supposed to use booti 
with it. I usually just get the Image or Image.gz from arch/arm64/boot 
and `booti` it and that should just work.

I also do not exactly know if you're supposed to be able to use u-boot's 
DTB for Linux kernel. Eventually we want to go towards this, but I don't 
know if that's necessarily possible today (but that wouldn't have 
anything to do with the bad image).

Cheers,
Quentin
