Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71A8CD4853
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 17:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096B48865D;
	Wed,  4 Sep 2024 19:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="UhJ1w60x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C090889AA; Wed,  4 Sep 2024 19:16:59 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::60e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB12388481
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 19:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7f21QpU0QbLaKWRiMuHki57DJLxkezXqiLUd+2DwnAOYiq0s2p99VlAXs26S5Gzpmq9fxNd8nwjNL8Xz/Q0Z66rflYH+vMYhVcqNj+apMJIZ/xjJhgxeAzrICgQb+vx3wxTSNKyMFejjZWJZtuFtVnmqtFq8xVb5n3gtOlNgpCgo/RUQ5ysOHgW5zVyjwyk3MKba907ZkfCG1vac+3QJjSZ24MVZPoVMTcErWryQ+56yFg0/Qt8Gl4rMoucivfXZQh02AkTBukDdY0q74ID2k/e0IeKr9SOMdp0wRjCD2WIj7cZBfsNwk7vyJNTM/pPMg3ONAPhaEy8dz2c0C3u7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeT+ofoDwyEHCx/u2Rt0kd61+NJwXPtBEwqbdJrwBWM=;
 b=pouMStEZOTyb4NNSccZjWOFz4HMOa1AMfgfizfapRNBzdG8Pf+df3od2zquuo4XVHt1/ULtj6qXwm9JNoztpY8MRPWiXrBT/144ykX+I3R6mfWCb2IiZB8ZXPvaxP2yFlR10eOilHdLeqED9t8/eXg6C15oKxhpM+fnO9JPr+YQluEC0KWhDcQ1aWsec4PdRgviBbHGjvt3p27sgomp26HOQzLKrXgzwKQLMArvLFoKtR8Tf8rFS5xPrSTGyy8RFqbKwuhX6klbkeJxO4erWWH50X9x+FNw/FA9RkGNh9hteoXOsGz1t+3DRv1Fu+l2KDCvV+W5MWNxFhnFbARNgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeT+ofoDwyEHCx/u2Rt0kd61+NJwXPtBEwqbdJrwBWM=;
 b=UhJ1w60xsuou739R5OH8P94HHnhS/G9GcWMfT4ZB6IaHCVxnwXyzgT4nsvCPIjqXsy8xed9eNKQrSx0AjRCuKEEUvgLcPOEQj4YJ3Y+FpOwW9pzlhswZqRJhz/esVRbRWn+TCrqNA5z+tMSQvMJ6/wdzkGHCPt5wa4sfWf5HpHDhG/98Kw/fHrbIKJ45U4d+Hxh2Faeng8jL/WCzcQYQbOwbtxfba6ENHgXYHxgYfaz+uv4s+cZuQO3KkDblXY11ldHSIT2MMzyBdOg0YNj8+m5s8J4tSRonJvFRttoz9DprUHpGj8mcQ5X9HC2gXz/21wZyqCxr41kv6jY+KNc7Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 17:16:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 17:16:53 +0000
Message-ID: <0ff5653f-60e2-49ee-b68b-d86801aa1d66@siemens.com>
Date: Wed, 4 Sep 2024 19:16:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
 <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
 <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
 <CAFA6WYNdS0jZ1iESfCErX92SOL2fJSRNNLZ1a_7jHoSfOUrdgw@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFA6WYNdS0jZ1iESfCErX92SOL2fJSRNNLZ1a_7jHoSfOUrdgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: fd4e7687-3faa-46e3-10aa-08dccd055f2c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REdHRHZJOWJpa1pLa3ZiZXZkV2xHZTdpK0RUM2E1cWdWRk5sRythYVhEbEti?=
 =?utf-8?B?bUNtSTJTOHg1eUoxdksyaE5TTUgvbGc2YjY3Sm9jYzJNeWJGSHFwSTBxb05E?=
 =?utf-8?B?azI4YkZjMDJTL2kzYW13TjE0TERLaVVKaGc3Rk5jK3AzVUZUWjUxZnQ1N0F1?=
 =?utf-8?B?NWhCbG5icVgrSVp6ZndsNnpIMHpLQzNxSmVuWmQ5WkJWWEFZM3o3MFJJNkY3?=
 =?utf-8?B?cmF2YVlHSU43ejFKQzBwWFdlOVA3MTFKVERFK0xxa3FNT2hLcTZqQmZUVzFk?=
 =?utf-8?B?RHVxbVo5dnpISnBHemcwYlZRODZXemVBRTJLU2RIaVQ2azFBKy9vRUJtMGtW?=
 =?utf-8?B?Z0RCcTFFbzl4RmVsU0Jxd2YyU1NlVjQxcFBhQllaTXQ1OU9UMHhUdmozMS9G?=
 =?utf-8?B?LzRJSXBpY09sWkR5VHhmSGRIOFRkRjVLODkveUN6TVRBYzJ3RkdRV0huUGpq?=
 =?utf-8?B?bjIvV0ZGaXdLWU43ZUdmQ2pYaGQ0ZDBNUEc3em5JZG9uU0dyYWFCaEcwMXdF?=
 =?utf-8?B?di9BcUdickJCcnEwR3kvbkJQSi9UMVFZcTc2eU1NNzV6UVR3Wm5NOVl1Y0NU?=
 =?utf-8?B?dHM2L0RrZGtKOUJoU1hXTjBGK1JuYytsQjBvN1llSTFhb1VXMU5iYVNUMDFx?=
 =?utf-8?B?OHVSdXp0a2Z2OW9nT1diTDBMUGdaY1BSa3dWeGt6MWVnQ1g0ZEZiMFVORjBk?=
 =?utf-8?B?cHVQMVdTY1kxdldqTVRCZlR3ajQrS3daS016K2ROWnlUd01TZ0N6eERRU05W?=
 =?utf-8?B?bnR6MVYzRTFhTHZ5bjFEN2hMT2kxOUlReWFPTmdSRUwycTN0L29kNUcyOWpL?=
 =?utf-8?B?WWVUNW1nUGNDSTVZOW1QdjdxbEYxMXhuSTBGZ1pMcW92dFZORG1DZlc3RVQz?=
 =?utf-8?B?SDkzbWQ3REI2eCtXOU5jRzZ6d01CZ3BQejVOejEvazV3U2QxL0N0ZkZrMHAy?=
 =?utf-8?B?VWY0dlF0ZTNsZk5BSmlUejBDOWczWG5yNHlTOFQ3aHZFZENRSFNMZnIzbTF1?=
 =?utf-8?B?TnZJOEpYMG9vVUwvR1RJTXVxZmFpcEF5ZTBmRm5penFaM3lLOEdxbXR1Vjdt?=
 =?utf-8?B?WHhROGdWamJQS3pveEF3ZWpCVEhkeTZHblBqRXpOY1dod1lFOVY0bFY0dDJq?=
 =?utf-8?B?cDM2SDJ2YlBydFdnYmlSMEIya0dWMVMxTkx5YnBFZzlkcFI3TDU1Tk1NSURE?=
 =?utf-8?B?RjRQcFNHdjdpOU9wSjY4bUlnMlduMDJYeVQ2eTVrU0tQbGUvZFRrNnZCUyty?=
 =?utf-8?B?cmFHdnNCcVdGaWhxb1RnTDcyTHBDa3A2bzl5amlaeC9JZHVwd3dyUVdQUnlm?=
 =?utf-8?B?VWZtNVdpVmIvZlR6NnNDd080UlZ0MWdjTVpLZHBnWVBvNkk0Y215MStjczNS?=
 =?utf-8?B?dGZVWjUxWnZ5a0MvVEUyelZGTk1Ta0I3bzVLajhjckd6MFRQdWFjbjJtQUxi?=
 =?utf-8?B?NHROTVFqcllmSWwwaE1GT2xLY1RKVXVWdU9acm9VQXpWcWoxZjBia0J2VENm?=
 =?utf-8?B?aExtRGdmaG1CZm1wRVUvQ2RwOHNnQWVQTlpFVW9IY1UrN0c1QjgrbXQ4cysw?=
 =?utf-8?B?VTd4MzEwU0RVeTZ6NjN4dWQzWjRPUVpSVTVlK0c4SDQ4QTBoVk1TMGJDYW9K?=
 =?utf-8?B?dG9Eam1kbzQ2WGF0WkpHdHdMUVU2NXdydUUzWmd5aDZPeTc1L2VXM3JTMDZz?=
 =?utf-8?B?Y1Y3QUVTYnhsWm02eTY4QkZQRGo3R0RITWRqV05Qc2VpeDJmdVlOSk1nMENj?=
 =?utf-8?Q?HQztWnaL+ujVcqasMY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXR4czRlM3pDZWUzWXFWQ0NnTXpjUlFwUHRaMGRDUnBhVFFwT0hxVzdSWElu?=
 =?utf-8?B?eEl3dFAvZ2tqSmhFVHJRZ3BZd2tPbGIxQ0YzS2QrclFza2VDQ1pFMHZIM05N?=
 =?utf-8?B?QlBpNVhSdXVXNmVvVkJidzE4OHl3SzRrVzE1UzV4TUpLcVgwOWVyTHBRSXJm?=
 =?utf-8?B?OFUrODhKRVFMUWN0Zy9YQksrcHQzTDVDODYrbGt6dWhENVRIYjd0b1dmQStR?=
 =?utf-8?B?WGxVTjY1N00wTGgxSFlsOSsvTXZkMHNtNFo0bitoZGZqNm5uZUxjYWVZUitB?=
 =?utf-8?B?Z2xlTjNYOUlhNDM5VVBLckNhdCtOeDBlMmdaUWxOL0djUi85bS9iajg5a0No?=
 =?utf-8?B?SE9kTFJkcy8wTU5ZTnhVWlpsNkdxWGdMN3llcXR4b0NzcDNab1N2M0gybWYw?=
 =?utf-8?B?V2EzajJHeXpNV3l1RWtEMUtDcytlbzFuaXJ3TVNvcXFwWnE4WEc0cmNNNDMz?=
 =?utf-8?B?TVV3RFJHMVVSUHBhMmFTN0szZEZxN29GVW9HOTRYTjBvdUwwUUJ6bCswbmZE?=
 =?utf-8?B?cU1BTTFhbjIwREFnTUd6dXliZGVuUUl5ZVlOSFBDUVYwaFZ5SS9GbmFCL0Vo?=
 =?utf-8?B?Nm1yamNYeTQvUDlNQnhBZUE2d21yYzkrOWtHME9LSGs3K2xmbmZVZ1F6MUVO?=
 =?utf-8?B?R3lmU2JCRnUxSTZqWU41SFBMSEZPaUMzVHQ5a2NjV1NXTC9Rd1R3SXNXQXdP?=
 =?utf-8?B?WUhxMnBoV3Y4UGp2enlwNlpsaEZIN3orTXArc1oyVmZ4WFBBTThvZFRHSG9W?=
 =?utf-8?B?U3pNakxpVFNpcy9INDhzcU9rQzZJOERkVzZ2eE96c1V4b2M5YjdqSkZtcENv?=
 =?utf-8?B?OHl0c1VJemRrVm1BOGRvdXNPODM3QWtTTmJEN2x6L0VYUTluRzN1RFlaOCs5?=
 =?utf-8?B?NW9CczNXdFUveXRmNXArRnRIdzFxNnpOV0lFQjNGVEF4ZU5EV0c5bXZBeEZN?=
 =?utf-8?B?QWU2YXdrMC8wNWlMUnAyRFpTQ1cwMFNqcVBqek5tcXZ6ZUQ0SVhFalhEYk45?=
 =?utf-8?B?TEttYVJuK0RKYlN1QVhGYkFnR1R0c05HVnRVMXpFWW01bE03dzd5SGdndHZy?=
 =?utf-8?B?THZXcEI5cjFXSjNTSE42TW1IUW9VMndIdFIxRU1sV0x2N05NTU5VYUlrYkF3?=
 =?utf-8?B?K3RIbFJMRE4yc1VUbTg5RWkweExPQnhwaGM1UVU4Tm9EWVhqcnljNCtuZ3RF?=
 =?utf-8?B?bTVpcVgxS2trKzlrVkdoNEpSVTJnMDI3US9HNzBVRzdDN3FieUVZWVREb0Nn?=
 =?utf-8?B?bHF4YitySS9PTlN2MmZMcW5KbWRGbm5ycWRYOERHUjczSXNLOTBkU3FqeXU2?=
 =?utf-8?B?bHJ1aDg1K1EzUGF6YW1aNG5pVmJJSDhXZEtCMnJsS2xHUTJTRXZzS3R5UE1K?=
 =?utf-8?B?V0ZmamZRNjRha3pzNmNDdTRuZURHZlQ1VGxVOHFFeHBqdys1R2lRRWRQTDQ1?=
 =?utf-8?B?bjdZWnErdEtQcllRUFRMdHZxakhBOWVCYnlka0RGNklOZ1pyaFZxcU05N0ty?=
 =?utf-8?B?RlFSMlZmQjZRZWs1cE0rUzRteDBneU5majUxRmJneksxRFpZaWtBNE5SWFNC?=
 =?utf-8?B?VGVhWnRzNFFHMExmbDArWEpWUFNnWGZoN3FqZ0hpckM1OFFCTEdFTS9tMXRV?=
 =?utf-8?B?WTJoODJtK1VSanhPSjY4Y3pKcTRqUGdaSVpmbXYySFZFY3lhR2ZaZ09vY1lP?=
 =?utf-8?B?VDI0Yk1vWlFWdjVVZUFYYi9KNlFSblNEN2phQWNjcG95R3ZqZGtjL2Zoc0tB?=
 =?utf-8?B?TVJpSDlLOEJPd211VjJERjA4STMzcTdyNlFjRnhVcURpNjQrbERnNWhrOFU0?=
 =?utf-8?B?U0dwVFBPeXhhamV4VlpsOFFDQWlGTS9qY3hnOU1vbXRkVFBUenF3ZXlnRlJm?=
 =?utf-8?B?eDg4MWt0azBDWFZjTGpVdXZoUEVjbGMrUGpqdFhUWWFiR0ZvanpITWhDY2xk?=
 =?utf-8?B?cWM2RUdRTzIxSHpiZTcxN1lMdlZ2dTQvWWVsbE4rcjk5M0VnQkhVNDcvSm8x?=
 =?utf-8?B?L0pWNThGODNCNjVNUjc2bFd5eU9TTXlKeDRiTE14UERYTzBiWTROQ2NxMWNV?=
 =?utf-8?B?RW1GSHVhLzZyYXgxdFpnbWlxa05VOG9aTUNyNWpvNGVZUS9mL1hpSUMvOTRi?=
 =?utf-8?B?QnZrTzJLbVRFc0tDZ2Yxd2tJMGlIU1A1Tm95TVAzVVYrYmN2eEVjOVhrdkdU?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4e7687-3faa-46e3-10aa-08dccd055f2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 17:16:53.5879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJ7NDMYq5rmQEwSgET9jCs3czrjAYf12riHritq2cbCJrMnaGAxNoAQjnTdSvCA4ZKODNkVYo7U0UlCOYyWiuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7513
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

On 27.08.24 12:39, Sumit Garg wrote:
> On Tue, 27 Aug 2024 at 15:05, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 27.08.24 09:13, Sumit Garg wrote:
>>> On Mon, 26 Aug 2024 at 18:02, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 26.08.24 09:10, Sumit Garg wrote:
>>>>> On Mon, 26 Aug 2024 at 12:19, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>
>>>>>> On 26.08.24 08:44, Sumit Garg wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Wed, 14 Aug 2024 at 22:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>>>>>
>>>>>>>> On 14.08.24 11:41, Jan Kiszka wrote:
>>>>>>>>> On 13.08.24 14:52, Nishanth Menon wrote:
>>>>>>>>>> On 11:16-20240813, Jan Kiszka wrote:
>>>>>>>>>>> Hi all,
>>>>>>>>>>>
>>>>>>>>>>> I'm trying to migrate the TI AM65x IOT2050 boards to OF_UPSTREAM but I'm
>>>>>>>>>>> facing issues because I need to still build the u-boot-only overlays. It
>>>>>>>>>>> is also a bit weird (but works) having to specify
>>>>>>>>>>>
>>>>>>>>>>> CONFIG_SPL_OF_LIST="../../../../arch/arm/dts/k3-am65-iot2050-spl"
>>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Actually, this does NOT work: I just had a long morning debugging SPL
>>>>>>>>> which no longer started because it picked the non-filtered dtb. The
>>>>>>>>> filtered one ended up in a folder outside of the u-boot sources because
>>>>>>>>> of all those ../ and hard-wiring to dts/upstream.
>>>>>>>>>
>>>>>>>>>>> for our spl dtb.
>>>>>>>>>>>
>>>>>>>>>>> Are there means to still build certain dtb[o] files in arch/<arch>/dts?
>>>>>>>>>>> I'm a bit lost in the Makefile forest.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Sumit: Any suggestions?
>>>>>>>>>>
>>>>>>>
>>>>>>> Apologies for the delayed reply. I was a bit busy with other high
>>>>>>> priority stuff.
>>>>>>>
>>>>>>>>>
>>>>>>>>> I would really like to hear some better proposals than my local
>>>>>>>>> workarounds to far. They don't converge although I already patched some
>>>>>>>>> core Makefile (overlays are building now).
>>>>>>>>>
>>>>>>>>
>>>>>>>> OK, I side-stepped the spl issue by using one of our variant DTBs for
>>>>>>>> spl as well - happens to work.
>>>>>>>
>>>>>>> That's good to know.
>>>>>>>
>>>>>>>>
>>>>>>>> For the overlays, I need to add
>>>>>>>>
>>>>>>>> --- a/scripts/Makefile.dts
>>>>>>>> +++ b/scripts/Makefile.dts
>>>>>>>> @@ -1,5 +1,7 @@
>>>>>>>>  # SPDX-License-Identifier: GPL-2.0+
>>>>>>>>
>>>>>>>> +include $(srctree)/config.mk
>>>>>>>> +
>>>>>>>>  dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
>>>>>>>>
>>>>>>>>  ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
>>>>>>>>
>>>>>>>>
>>>>>>>> in order to then be able to do
>>>>>>>>
>>>>>>>> --- a/board/siemens/iot2050/config.mk
>>>>>>>> +++ b/board/siemens/iot2050/config.mk
>>>>>>>> @@ -5,4 +5,12 @@
>>>>>>>>  # Authors:
>>>>>>>>  #   Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>
>>>>>>>> +ifneq ($(CONFIG_SPL_BUILD),y)
>>>>>>>> +dtbo-list = \
>>>>>>>> +       k3-am6548-iot2050-advanced-m2-bkey-usb3-overlay \
>>>>>>>> +       k3-am6548-iot2050-advanced-m2-bkey-ekey-pcie-overlay
>>>>>>>> +
>>>>>>>> +dtb-y += $(patsubst %,../../../../arch/arm/dts/%.dtbo,$(dtbo-list))
>>>>>>>> +endif
>>>>>>>> +
>>>>>>>>  flash.bin: all
>>>>>>>>
>>>>>>>>
>>>>>>>> Does that make sense?
>>>>>>>
>>>>>>> A switch to OF_UPSTREAM means that we build all the DT artifacts from
>>>>>>> dts/upstream/src/ directory with the only exception that we include
>>>>>>> U-Boot specific overrides via *-u-boot.dtsi from arch/<arch>/dts. In
>>>>>>> case of overlays, is there any reason for IOT2050 board overlays not
>>>>>>> being pushed into Linux kernel repo? AFAIU, overlays are also
>>>>>>> describing puggable hardware so they shouldn't be referred to as
>>>>>>> "u-boot-only" overlays.
>>>>>>
>>>>>> We are using the overlay to massage the DT presented to the OS based on
>>>>>> firmware configuration.
>>>>>
>>>>> Agree and more than that I prefer the firmware to own the overall DT
>>>>> and present that to the OS.
>>>>>
>>>>>> So, those two belong to the firmware logically,
>>>>>> but - with some disclaimers, we could also try to upstream them.
>>>>>
>>>>> For historical reasons, Linux kernel source tree has become the
>>>>> defacto upstream repo for DT sources. So it's better to contribute
>>>>> there and sync back in U-Boot.
>>>>
>>>> Will do ASAP, hope to hit at least 6.12 then.
>>>>
>>>> Still, this will delay our next patches for U-Boot by many months. Also
>>>> for that reason, a plan B for U-Boot local DTs should remain, no
>>>> left-or-right policy.
>>>
>>> Yeah, the U-Boot local DTs should be used until the board is fully
>>> supported by the dts/upstream directory.
>>>
>>
>> This is not what I mean and won't help: Given the longer pipeline, it
>> should remain possible to carry also local changes after switching to
>> OF_UPSTREAM and while waiting for upstreaming to be done - if ever. We
>> are missing middle ground.
> 
> For local changes we already have the middle ground as *-u-boot.dtsi.
> Also, cherry-picking [1] from upstream rc* releases is pretty
> effective in shortening that pipeline. However, building DTB artifacts
> from multiple directories is going to make Makefiles messy and in turn
> will be difficult to be consumed by packaging tools like binman. Your
> Makefile change demonstrates it too. But if you can come up with a
> cleaner solution then I will be happy to review that.
> 
> [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
> 

OK, our overlay sources are on their way into mainline, will only take
until 6.12-rc1 to get them here. To accelerate the preparation, I ported
that change to a local branch - just to find out that OF_UPSTREAM has no
clue about DT overlays so far. And it is not just that there are no
build rules for them (that was quickly fixed). It's also that there is
no way to trigger their build for your u-boot proper.

Are there plans for addressing this? I'm inclined to revive my patch
that allows to augment dtb-y from the board's config.mk. Better suggestions?

Jan

-- 
Siemens AG, Technology
Linux Expert Center

