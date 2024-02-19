Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F637C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 18:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD5387B84;
	Mon, 19 Feb 2024 19:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="wuLaaecO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E6AB87CE8; Mon, 19 Feb 2024 19:38:16 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC4187971
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 19:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYn04nf0Nh+EAQvRgqwq7R3PqiT8+E9WAnG2i94XoWmXoVeJ6pvHPBy5O3RsmFft+osv5s3TzFXIMzLIQFX1VgWhW3rrhjutgC63yfR4ys5cQxU7fD5t+o6v6CIfE5GtyVOCN3K2LH63zmhzFXXxUz3bVoVDhej1IWPEFcMAFydJhScQShQ4Lusk1qf9DiCCQY9yYCEePG/cxfho2cgO9CvuiKgwdM1xUuKhDeRw6sQqa6g0GLwt41vAL+CIzLpufCkFgDDv+lODQY7x2HJ8MVBh64EYuVikG0l6dlxmOQBI5Ikjc+/hj1SNKbXz3yOOI+lkngM9zI3cYIkYdN7VCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4B9S6H3y4TY0IBJSMU1g27Q6j7bhdhznvIfdbvN3YA=;
 b=anBXk0QFDIH6utKUwxVjJY02H3EckTObzSQcnko9qdYkAHGeNq3mb0OZBoFd9mOucZTSslI84qvrkFb0dcw8RZN59SxQYNmywwqQbp7pAFbMijG1m24lI+L22NGntImMnZSuEdUnCd8+JMO0Qzfw6DWWcwRSWgqvdV9+3BWnM0eBuJgTLtbWgil489s47wETNgisXSAlYSOIiyK6h0Dpek8ZQBYHvZ/LzOjq2MXWvfjiRH/RrJejySewciSAEl70K4vd/2mSQzyEKV0qaP9MF168pazqqoAy/2DmDq3Bv0MSahgqYftkNUYKoZ1EKbPbhcgX4a8CY05u24yKpmd0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4B9S6H3y4TY0IBJSMU1g27Q6j7bhdhznvIfdbvN3YA=;
 b=wuLaaecO0DpsO3beO/9tBZ6OvcaAvAsxQrK78LiuGCFHIF/YQqGe6ZRKCUhKuflItNZbwio4rxZ7NNuverd/+1XqsfczCFBcHIAS8zKVxdG+IN5DUTmt5AFmm032NGGn45/hGjRdrLc9FUVHHhcF5skpJ9nreZkOPNtW8E/nhAEWTvsyUnWf5GVf/ARVjcNHrdCnbrZzMwQ7i++xK7NeWEyRbt6rX/UhulqQAq7E2CvZP+rXWhCw/3Yty07DU1lHq4yaE4hu/8GYJdN9rgVlZR3B6a2pNe82fvKCOWKxCfSruJlnE5d3CdDnk3txdopbyQMVxbgHsqh7alJQiU0Ajw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6409.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Mon, 19 Feb
 2024 18:37:57 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c463:2929:b52e:f171]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c463:2929:b52e:f171%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 18:37:57 +0000
Message-ID: <dba0d25f-121d-4146-a78b-ac3beeeb1531@siemens.com>
Date: Mon, 19 Feb 2024 19:37:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
Content-Language: en-US
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Andreas Dannenberg <dannenberg@ti.com>,
 Romain Naour <romain.naour@smile.fr>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
 <87f154591fee4979570e78cbc8c73eb0a56469eb.camel@gmail.com>
 <e6222770-cbcd-45e2-94fe-eb55fb0a2f94@siemens.com>
 <5679ced7e927e1eb858a47d25abbd4025b4b67b7.camel@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <5679ced7e927e1eb858a47d25abbd4025b4b67b7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 29a5a9ff-2451-444d-8364-08dc3179e473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hKJ8x+6ITECYsp7AOi9MLqhymgTCczlSfapf2vDL+r7y0gO62hFjt6schfsDOyEEA6XlO+b92TFtBk19fQUMZRS/60TENFe96NAZ/sBJwpgyzbC6xjOdh5UGR2dcStpi9KDxAzIBj5c33KZQDLbmsEGbCDgc4U1STKihLv41Cr7HuJtUjwh1cMJ6zXAr0uLJOPfwThuP6UcKBZGR1fHPym0dHiZi4yfH8m0I/Tvk+mWt9rpJUfUGu0YhICK3qJ8XdFVjNtIdFuojwBYKi0mt5vfRsGjJ4QSlxRAcdM/5VLtwOz8uCYqGV0e1DMBMGPYFNOlaMAtsZRY1DgZv4sOmvCQ58kCcqWEn8M1rjlhOdUsvxynBv47CUXzxm58ICVAklj0/1j3V1sHO+TF+8cu50ZEj9lObf/7Yl1Drih0wQjRgS+ffbwgLDCIh8gjsOXlZcItrfIqEEFJklVUi6v+GZQK8UFOSubTW3U7IgXE1sg0XN+cjXXPkoe2vJihcNpSg01/mJbZnt54UZ0e2ZQCxfobWD8y1ZUwLrwhuzKm+AY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVlxeGhmSGFVbDV4MEF4dWEyL2RJNys5bHdBWk5vSDlqOUNpbGMxVVNFREp5?=
 =?utf-8?B?UzYxWFk5bkJ0YlcyMWk2azdobTRNNGdRcHZBT2hqRmNwc0NKMiszemx1dzdw?=
 =?utf-8?B?WTg4RW0ycjA1bTFEcEdxWEdTSTdqcG9ub3JRSEJzT2dUcFI3Q0szaVhJWlJ4?=
 =?utf-8?B?dkdnOTh5NnFlUkszaTEyOThWSjliK3ZyeWw3cStsWDBYeUhhM2tib3JNbEx6?=
 =?utf-8?B?TTg3dUJXWGdwMUJvRVFtLy9nbHY3K3hvdjczdDNoWVRzVHkzcG4zd3ZmTzYv?=
 =?utf-8?B?TzI5RVFmeVU4M3JZVVZjampQK1RwaGY2ay9KNzNuQS9nTGZ1TzFiSXA4amNK?=
 =?utf-8?B?R2JHUS9KdUZKbDVFcWlpUTdOT05CNVMrbjE5Q01HNU02ejRYMFJXdDI3L3o0?=
 =?utf-8?B?NFRCbG02dUxYbCtXd1RxZEh4eGhZakl1dkxBUTBQL2FZV1E5U0JCQTh6Y0Vy?=
 =?utf-8?B?YzF6U3BjSmdzM3p4QXBpSkd4U1B3Wm1DUEloK2NpUmJSY1NNdHRzaUo4aE5C?=
 =?utf-8?B?VTh0Nkl6ZjB4cVlTUU1tT29qMHFpZVdzdDA0SUVnc3BNaU9FbitNODVhYXE4?=
 =?utf-8?B?Y1V1VTRSYlFYWEZhU1FtUWZVbUhGa1pFNjI4SHZocFUvdGVkK0xrSjg3OFNz?=
 =?utf-8?B?STR4dFFFcTEzYWVSTXdqRWl4eDBFclFNWm1DQXI4a3lyR1YxVGtmSUpMQmhw?=
 =?utf-8?B?THdVN1cyTXFJbENMaUJ4ejJVa3VJRHNDS0V2eExRWThTeEJBbFU5SVJxM29G?=
 =?utf-8?B?dzhvazVubm1iNlB6dVpnY2xiLzNucVdpcVhVb0FSNm43alg2RGw3dHhjRkMy?=
 =?utf-8?B?RlIvaWZ0Z2dLa2FKd0RIdGNYTWpGWDgxZW1wZ3JOek9sdGtlV2x5YXpCR25O?=
 =?utf-8?B?RkhidHZKeXhqMzkzSTRvby9tMjcyc3BUTFNYRnc1ZSt5VU9xLzBKQ2FPK2VC?=
 =?utf-8?B?alBIUHFoQkRCcDd0QTdvR05FZVZYMGRQVElmdE4vcUlmc3ZqTldrejBIczUx?=
 =?utf-8?B?WkExdWpzS292WnRHYjBXR2t5RmNNZDViajQ2UVp5R1pPQUltOHFtSE14VHdH?=
 =?utf-8?B?VmpPNldWOW1qalRhRDRGZGtUTTF6V0Y0YjFtU09pZ0xXUXVRNEx5Q1hyU3lZ?=
 =?utf-8?B?VFB6L1dQWXlpTXM1eWxaYVJVNWdQWG1iaDJuVStiWG5MWm5CTVVVNzdtcTFY?=
 =?utf-8?B?MlVWdVVMTGpuLzlWbDd2MDN0d3E5R1AyZFFyVEFXR2RXdDNIejdtQVRYUFQ0?=
 =?utf-8?B?TlFvcUF1NVM4VkZTMUFkRkp4TmM3U3dqMlZhR3ZaVHdyQklIWS9iUWQwRFlC?=
 =?utf-8?B?ejgyRUxtZjVDNjVJbkkzRlFINHQ3OWlubnJZVWtPNStVS3BScVVhR1BsOHdH?=
 =?utf-8?B?YXQ4cUZ1VWluVENWU3hHMUhWWFlFbnBmajZZRmJGbE1YTXRZbXVvd0k2YXg3?=
 =?utf-8?B?YkZvcklXUWdkdEhaLzBaNzhUaDNPTFlrSEtZMElMd00xcmg1THl4bUR5bUVq?=
 =?utf-8?B?UlJVd1JuMGc1WlVVd3NFWW0veG1HQjB1UDRnblRndXpocUpPM3Vvd25iMWFJ?=
 =?utf-8?B?SHFhRDRKL3FVV2hTYzdna3BGSDIvZll1YTlCbXRqV1RXU2FDM2F6STFnZFZB?=
 =?utf-8?B?R21SZ3hhcllzUnU3cVRmNzF6c0NTRUtWUEhNMHdrbnZtTExZRjNxTEt5ODVO?=
 =?utf-8?B?SHpHazIxT0x5aWtTWXFqTE9DdzAvYXM3VVA2akU0eFVzekRnN1Z1RnovUVMz?=
 =?utf-8?B?MC9kYm5aRnpxMnZUR2xrNjVHc21TbGp2L1dPanRMZGgzYXhuL25lT1BWU3lY?=
 =?utf-8?B?MGdFc2tSUFYyRjBpdmNoVC9XVTFKMTlJZk1vajFrZ1NuTTVqQlFWcUk4UndY?=
 =?utf-8?B?NTF0RjdhSGF0OGlub1B4dzRoNlludVUraDBmQWlpd2N5Q05OdXFKK09MZUwv?=
 =?utf-8?B?c2NGd2FZbFNBdTg4eHREdjFhTVMwRjVpUFVoeCs5VFFTU01ML0xpS1VsdTZJ?=
 =?utf-8?B?NlBwYmFXK0JENldsdHZuYkJPaFJrTmFZMVI2SmI0VHJEZWVRSVhkd3o0VVdP?=
 =?utf-8?B?UStwa0R3a2h1dENXWDZVSmRGYTFwQ3hOekpPa1JyWTEwMmE1SktoUU5VUTQv?=
 =?utf-8?B?Mk1janNRUkt6Zm53d2paTk5ZOTdlYmkrR2lTUlppODZkLzIrRjI2QWw3b0g4?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a5a9ff-2451-444d-8364-08dc3179e473
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 18:37:57.4852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vI/ddOlSARDCYrPzudeG5+bVaaU7X4/QBqfOAQ44pRydrT4d6tXWKiq6fHyW/WzmcLk/dtQATZ15VWLwhrnqdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6409
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

On 17.02.24 12:36, Alexander Sverdlin wrote:
> Hi Jan!
> 
> On Sat, 2024-02-17 at 09:42 +0100, Jan Kiszka wrote:
>>> U-Boot 2024.01 (Feb 15 2024 - 01:43:17 +0100)
>>>
>>> SoC:   AM62X SR1.0 HS-FS
>>> Model: Texas Instruments AM625 SK
>>> DRAM:  2 GiB
>>> Core:  56 devices, 23 uclasses, devicetree: separate
>>> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
>>> Loading Environment from nowhere... OK
>>> In:    serial@2800000
>>> Out:   serial@2800000
>>> Err:   serial@2800000
>>> Net:   eth0: ethernet@8000000port@1
>>> Hit any key to stop autoboot:  0 
>>> switch to partitions #0, OK
>>> mmc1 is current device
>>> SD/MMC found on device 1
>>> Failed to load 'uEnv.txt'
>>> Scanning for bootflows in all bootdevs
>>> Seq  Method       State   Uclass    Part  Name                      Filename
>>> ---  -----------  ------  --------  ----  ------------------------  ----------------
>>> Scanning global bootmeth 'efi_mgr':
>>> No EFI system partition
>>> No EFI system partition
>>> Failed to persist EFI variables
>>> Scanning bootdev 'mmc@fa00000.bootdev':
>>> Scanning bootdev 'mmc@fa10000.bootdev':
>>> Unknown uclass 'usb' in label
>>> link up on port 1, speed 100, full duplex
>>> BOOTP broadcast 1
>>> BOOTP broadcast 2
>>> BOOTP broadcast 3
>>> ...
>>> ---
>>>
>>> I suppose TI's BSP has older U-Boot... So it's not providing necessary
>>> script for BOOTSTD, I suppose?
>>>
>>
>> You can make the BeagleBone boot via EFI, but it requires a hybrid
>> partition table (ROM loader want DOS, EFI needs GPT). A Debian
>> integration with this can be found for Isar [1] in this series [2]. It's
>> only using upstream sources (plus still one u-boot patch to get wifi
>> working).
>>
>> If you want legacy script booting, I suspect you need to flip some extra
>> switches explicitly by now.
> 
> Thanks for the hints!
> I'm wondering, if this was a deliberate "let's stop booting all the
> pre-existing embedded distros" decision? (buildroot, yocto/meta-ti...)
> 

FWIW, I'm not seeing other boot methods being specifically disabled in
beagleplay in 2024.01 or even newer. I didn't try the result, but this
may actually be some other issue and real bug, nothing obviously intended.

My personal observation is that continuous integration testings with
all-upstream components is not really a common thing. I saw that with
multiple active SoCs from various vendors.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

