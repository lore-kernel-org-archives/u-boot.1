Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E53F94CCB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 06:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6181084255;
	Wed, 22 Apr 2026 08:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NYuxmsZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C79C8352B; Wed, 22 Apr 2026 08:05:02 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E2983BC8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 08:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCJksbGFakac6ziIETq33iAadEkAPMXS9D2F9CUcQz6QKpe5yVuqu9vXmGSeGXE9xmH54eriB0edOdkIe5jzrxQAqx4cAbvPcV4ZVCkIc0x5K1kjliM5S8dcQ6FTOSh1zse7Ma6qqcN1IuKIe91+EUNVt9iTy088o+QdVXxfgkueiue6ahQxdbP782KhJw5lXMW76BT42BRCdkEbiamxyJOqM7/iWXpBSCClwv6A8MQkqyJqYH8/BIrDCiJYa5spqG4zGtAy4xwqbfG7S9a5mbkenk6CMaDYlvS6lqOBHqM2pI2GYLIDST8sIe10wbx/tZ7wjStVCMWjcuxS8zEWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwXL7LSRqhB7tM+hs6qBlBtTCCVCeTVepAPi1d8cTFs=;
 b=rFQoHeDbbBmRwqix7wbuuA8qxhmYGxeSKtYPVTrDqEXPXfFRC4cS7IG9OjgV4fnoEZyhT4o6nu+RkO8Ba0aHLzr9cTGRaN0P5FAGfzZSNv2AVIzxvPUFPyhfYlc1BzB1mUFIOnit55ge5xqccOIvl2bUdsfgokfCZgO07/2aYdEQfaz18ik7Ti1ycNPc3NdK4lzs81TYsD4BCzKrGWcEHXLkgQbrqoZx4Z6Qw7tWXp2wA/Tp4+7IWGzO//ahPBVfcuWiuOeUvcUWUzGhb/tDiC58VUw5T36f1i2aawswH3oVFXw7uKci+lMddN/376UJK0VEOZ4Q8K6kbkNTAko6tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwXL7LSRqhB7tM+hs6qBlBtTCCVCeTVepAPi1d8cTFs=;
 b=NYuxmsZOXzQ5vDmE8sxBuzmnoXR1NH+5Uxw+6MOCudPjxq9kepSGj7YH+ccfNOZ8wu8g/SgTPijYiAqaGOTG1XJoFEgtKdMj0nRf6Vm8jPedoHCpqpFTn1Gn7eUcEE8lpNy8oW4JHAamv3Ycu9l2nf4h/lLFQn0SmzG7pS+5nMieOHMQKIEdvcr9OnTHMM7qxoInFWi2Db9h1r9jHzyKIOFOf2jSzv36Kj3a5BY7QlIuToJ7kbNGPsSTNyfMGFPnfp8f0u955nQfnYhRJ0O0IYErgoLujLD9z9PcPBt/Ffy4PtoWhhPjlC0NsoBjEl3aNsaFmKvP/aLk1lZ9f89XWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS0PR03MB7726.namprd03.prod.outlook.com (2603:10b6:8:1f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 06:04:56 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 06:04:55 +0000
Message-ID: <33279917-7f3a-4a33-83dd-0c78ed5e88ed@altera.com>
Date: Wed, 22 Apr 2026 14:04:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Improve handoff prepare on SoCFPGA
To: Sune Brian <briansune@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20260421004719.73491-1-briansune@gmail.com>
 <CAFLszTjJOfcddrdbN7oMPGAVZJRmj689-1bN5bY2gGiFdc=RGg@mail.gmail.com>
 <CAN7C2SAJYbMFmRorV7w6XphPh24iuTTeobW6q66Dk9_q1s61jg@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <CAN7C2SAJYbMFmRorV7w6XphPh24iuTTeobW6q66Dk9_q1s61jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DS0PR03MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fdaaf8f-f268-4753-a26d-08dea0351384
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|11006099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: DNTvN7OLQrfX6vwm7TT49M0vVStRYd/KS0F7S18Cbi0Mxu0ebihXaXUk7g6pio4DxIsfcKesqWE+xX6hktLRYARMtQC+WA0aOz1zn4ZouuBm4iyXTMqKR++wdnij3HreilUGOUKFxMalG7rnEjJ6x4DiLNMVtmYYeUvfgoP2VZMY0NjH09N+ykkRrxyiZSQhA9ff1mOXFOzZxJ2xBzERdlKauJ1zUBz1neYv3v1xn+4c+85Ay10V8rGU1BEZVcz19c3qW8S8NOq+j83xz3MyoaTPkI3n1xkeY6Jxt5jM1Ac7yh/npa7b7G5QKxsjchZuml98LRhkyTTOjwuhZvpJbnsJw/7w4SpS6A3IYJN68+8dLEk82633kGHI3axKRTKBr32DFwI6BhrxetpbxM9mWTayPZxt/F15kdai7lK1BrdsVMbrKiFK90IHhs8siYgNsK9x14VwDqccIpZbrnX+6UEXqX3/EtFX/2rWileZIwoJVsNqaz9IBpC3hxnVpAsfMf8xG+XGauHODL2ox42zbdCM5GYM4BOqYXik92IeCD2ZwXqthmpZ0um1NGIlSK34Wf3iZG4YihmsDGhKHkqyTCbMwLdNEg+I8wzufwSivPGI0LomArHUCRt8kZsePwGL1yHbTTzebRPJZdZDi6DawvbAm5NojqDkhQknI1YOcLEYdK07E2ON5zN7e14DN1+rYHZN+yvCiYUylp4d7k9PXOOLwmB875bwNPy0aMsV11c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(11006099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3l2UTdXUzk0cmwxRmY4UGxSV1g5MjhUSFV1MCtEeXpmcGhKZjFtNjNLRVN1?=
 =?utf-8?B?UVkzMkovN3NwekRJOUZBTWduMDR5L2VtSkRDUGRLZW5HcFUrdUp5bTlTSlo1?=
 =?utf-8?B?UEQzQ3B5aEdaMHlERmtIOW9qUExTWW5VVmhvM2Z1ZmdpaDJiRGl6ZmpVV0FZ?=
 =?utf-8?B?NlZvdVdXV1JNMCtjVEZDaUJpdjRYanRRRTYwMkhSb0oxVmlEemdOdVVOYWQ1?=
 =?utf-8?B?d3NNeW9YT1F1UWxyNkpHZWJaTnlTSFRqcmthZ292eXFuQmI0U3RXNy9yeEZk?=
 =?utf-8?B?UFl0WGpYcWk5QTd5VHZWUDRBVDg3dzR6OWZwNnZZVjBrSWJpRDVsMFBKZGlL?=
 =?utf-8?B?azl6cWhFN3lXTE0vTWpaRG1FNFNsZlNrVGoxSXNmQlpaR1FrbEh5ZDJ3Y1JN?=
 =?utf-8?B?dFFDWE94WHNTUGRTRjJXWHZkdUozU3hKQlNMenVSNGg4OWtkZjFxcDE0VVZP?=
 =?utf-8?B?ODhEV1cyTFdHVjBRTzkyNStNL3hmY055bGRUZmlZK2JZV0Z3ak9wU0tVN3Nz?=
 =?utf-8?B?clN3c3hhVkRpZ2F0RXhDRzRtbXk2MEJoVTRMQ2hoRTdXVjZOb2hwTk83eUQ1?=
 =?utf-8?B?ZVpIQlJ4aGY4ejU5UGNvTDZlc2xESnFzQVpRRHVpZWpxK2lzTXdHRWNOazlL?=
 =?utf-8?B?aUFUbkVKbTR2Wjc0Nmx6RVpOb1BZdDJYM3ZmS2NuWThFZUdab01VbUFMMFk0?=
 =?utf-8?B?M2NCbkJCaVZJN0RiNExRdExaQ0k4dFVyMHdOMjc5VFV1c056QTFjL2M2dzli?=
 =?utf-8?B?Qm9XckJNYTVKQmVndVV4cDY2SzhaaEMvMnBhaXdEZUZoTFF1ZkVKblZSZDRm?=
 =?utf-8?B?YnRDVWtlUGx5L0luVUV4dGhRbUhXUkwvVVFibmxjRS9rRkJWeHljVTRBZ1h3?=
 =?utf-8?B?SlBWYjdPRGpGZTlsUEMxUHJURVhzQjhFZkVrSVR6Yzh6eWZTOWZkQUJVUVZm?=
 =?utf-8?B?endhTmN2QmR2Sk5pMkxBVzZMcXl5SEZGbHhUbWY5czdvK1VmalJLVXo2WGtP?=
 =?utf-8?B?dlEydVJmZWY0QlZOMDY5azNCNGdBT2JZOEVyRUc2NGVtS3ZHZzBnUXhLS2ZP?=
 =?utf-8?B?ZGJ3cW9jNkdHdWpJaUZqdmpOdTEzd1VnZVVNV2FDeC94VG54U3F3THVkQ1U5?=
 =?utf-8?B?Z29zeDRldVE2ZWhTMmZnVTU1WE1mUzhhSzRnZlNFdUhPaGlpQXErb2JVUTds?=
 =?utf-8?B?VjhPWjlDL2xxRVBKRWp4dDEyZVQxaW9hSGcyOFpSbGZnQ0pxYldaNnhtajBh?=
 =?utf-8?B?THp0cERMcmZFdkpmVitVWWo1enpkKzhISnRRRWFSMmtoTmNTOVlzb1pTNVha?=
 =?utf-8?B?VE54NjFJYkhQMlF2blRFa01mdXZ2dWNteHM5L3BIRkRabGFvNC8xaWEvOXlh?=
 =?utf-8?B?Vm1UVXpPQjBFWHlPSTU0SDlsRWFlOW43MUR5RVl0a3BSOGdab1p6Qy9sWDBM?=
 =?utf-8?B?dUIrSU5WdGVYbWM1bFFxaFMyNG02MWR5NlQyQ0NaemRQdVZOWUdFVzNsOHpQ?=
 =?utf-8?B?Qmkxb1lEcFpITkorbTkzNXkxdndOYjdDaDJiZ1B2QVFmUFQrTis5UG1QcVhv?=
 =?utf-8?B?cTVZMk5YU2dJd3lIcDhxOVJqL3U2YTFvMUNIQTZzU3p2UUEyWk0wVE5uSTdT?=
 =?utf-8?B?S2xOdG5DK2tSb0tNN2lHRkR1L293S213cWFoWlVWcnZLTE91eVZ6bDVzUUFw?=
 =?utf-8?B?L0QvQkhLUlZpaEZiUU9ibTliRWovUzBibUpUN0RiT3Q1aXkyVWduWXVhQld1?=
 =?utf-8?B?NHVYUTdJUUpFR0pnd2RYeTFhUGY5OWdzVWNIbGxMSkdVU1RibWkwdGswU0Rs?=
 =?utf-8?B?VG1YTmFBaFlOYmRkZHk4b1lST01sTjBSb2d3cmpxNy9aU2ZIZHJZOHB3QlhH?=
 =?utf-8?B?THRseklOY0cySXhSWHdZMDdYTy9vOERNQ3lTb0hURElOS1lDZEM0QUlzd3NM?=
 =?utf-8?B?M21PM3BJV0JmdVNRcWZrbTJ1bGdoSW94UDZXbXVBR3dKeDBkRlo2WWRweTlM?=
 =?utf-8?B?KzNiM2hPWjRkSlFsK2x3K1Q2OWJaWFlXUFBNdER0N2lWQ3RTaFR5bHg3ay94?=
 =?utf-8?B?bFdZYVhlS0hHaVlSUU5keTR6V2xMdWZhd0pxYzdSMG5maU5YdFoyZjFiNDBW?=
 =?utf-8?B?K2dVTFp1SGxyNW9MaGxDSUZhK3YvNHRYRnNHVldZVFZvbVF0UlJIMGNSTkhN?=
 =?utf-8?B?VzNZQko1V1E4L1IzaVBNM20zT2IxT25JZlRlTjBBcHk4SEdzMDdiZXpIdjUx?=
 =?utf-8?B?eUVLV01mTmlXUSt3b2RxbEVITExHOEV0SUhlZ1pLUTU4aEs5dHpKTVFwRDlC?=
 =?utf-8?B?QndrZHZoenBWSDJuamVXN1RNK2pnOUExZnU1U2dSdGhTOGVpeEVZV040MVZx?=
 =?utf-8?Q?ORp4mYteLe+3GvKs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdaaf8f-f268-4753-a26d-08dea0351384
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 06:04:55.8803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNbqV4ZmfHaAKH1SxbB9tuBFAbu1AMbmdkbOeYusPAB2Y5C+6XFYrXCacE9c8r9Kz1ERn8L74BA4DLB5ekex2dTU6R9trr0HPiLiHwvalqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7726
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

Hi Brian,

On 22/4/2026 11:13 am, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On Wed, Apr 22, 2026 at 10:54 AM Simon Glass <sjg@chromium.org> wrote:
>> Hi Brian,
>>
>> On 2026-04-21T00:47:19, Sune Brian <briansune@gmail.com> wrote:
>>> Improve handoff prepare on SoCFPGA
>>>
>>> There are some cases that the Python scripts
>>> are run and the qts files are not replaced.
>>>
>>> This patch introduces:
>>> 1) TMP folder for Python script
>>> 2) TMP folder will automatically remove on exit
>>> 3) If PY script fails, the replace will not conduct.
>>> 4) Only when PY script passed the replace with keep
>>> or without keep will be done via NEW HANDOFF_KEEP=xxx
>>> 5) When keep is selected the old files are renamed to
>>> xxx.h.handoff.<timestamp>
>>>
>>> As such this ensure qts folder h files are properly
>>> updated.
>>>
>>> Signed-off-by: Brian Sune <briansune@gmail.com>
>>>
>>> arch/arm/mach-socfpga/config.mk | 27 ++++++++++++++++++++++++---
>>>   1 file changed, 24 insertions(+), 3 deletions(-)
>> Reviewed-by: Simon Glass <sjg@chromium.org>


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>


Please roll a v5 with:
1) Commit message: imperative tense, add a short v5 changelog vs v4,
    spell out "Python", and fix the backup filename in the text to match
    the code (.h.handoff_backup.<timestamp>).


2) HANDOFF_KEEP: I am fine keeping your current semantics [OR: please
    adopt Simon's single test ...]. Either way, add a brief comment in
    config.mk next to the recipe stating: unset => remove old headers;
    HANDOFF_KEEP set and not 0 => rename old *.h to *.h.handoff_backup.*;
    HANDOFF_KEEP=0 => remove old headers even when the variable is set.


3) [Optional] If HANDOFF_KEEP= (empty) should not mean "keep", adjust the
    shell logic or document the current behavior.


With that I can apply from list.


Thanks.

Best regards,

Tien Fong

