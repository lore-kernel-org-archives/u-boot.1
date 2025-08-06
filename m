Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BA3C87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 06:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 932AB83981;
	Wed,  6 Aug 2025 08:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="EYqzPacr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D6883990; Wed,  6 Aug 2025 08:53:13 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B03883980
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 08:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6ni80VfKQA8F1TJC5796IdqMBwmKUTeqc4h/bEKK2q+qU2lHVfTRNR3e3cGjooVBkvFXtgG3+cmKJCujVhSE5POUIwWOTKyBoxtc15xM9jc9iloKE3rbofLp6j4719MsBo+wo9L/iaaKkfZJffHJKNfMkHRMmYevFRojjt0Nk28rYY3Bh7P2QzS3rc7IrYnkjqVkAZJwGRZZSraj1KkzX04WtNmqqFaghF1oObGyR4tiSiKRl44mIPAeBI+nS9dXzHPYkux+LdlQOYSxKgX+LwonyPpqE/XZKpbxyENmyAz3+YD+ufjKvmooYUw9esiOjA3EM//G9hSaDfNGCIcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INTXzbleni/L8aPsFf8OX2IpkX1tLCZ42lcteXtW5io=;
 b=BFJ6/iqxwC5RYHJa3+wDsqtEuPT/qpjr1sWKwgNouO86+Yf2uYeNz13c/65i8Spx4/KkEdBS+SbW4auAjXrBZWJtOOjGxleLJeScIeN138sw5Bcr/cuouc02Wo+UWeL81s/ble9fJNea4mdNFF5XQThw/KwsZKZyIMocW3BXtGR5D37K0chza0whZlZ3Ksq2N9vcPCjVpGIb2Uo7SoNRplYnx4OXHDHRO+l7wyZD2L6JaGENp7t7wMjMg0xWnqD0C0oh+yPFE07nCnygrImDJhDccvIC5q5bNyg232vZxOjcaxEKKm3+SeW4ob4DMrk4FodxB3YQU57zSytNhP3UCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INTXzbleni/L8aPsFf8OX2IpkX1tLCZ42lcteXtW5io=;
 b=EYqzPacrT4It3hyxKswDfdVaG/bdxdufsZUCJn6n5/u7YdlT9rFKftExxZCoeeLrSU/NA7VYpghG9UTse2Otv1YqbLN5Lt5HIhOKhfYmnMdmVy0yNPBuM79M3aXY7+novfzpqRDsCfgwyPFfvj+QuYI87qLoXLH4/yjvRKceGJKa44kF+R0MIsS7vX7leGlN4/R511cauGZRsEMtreTbKTNHIgw9qasR6oFs1RWIhIOLWkiPnFNeof+avOQB/oQqitO9dr+eDousVrme3BxOZjQMjTg5iz6Kvn7vK3xXBZkxleQyAca4hpAVY3MO3udVnLnPnIdQRYiotYZ7ZMm2AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by VI1PR10MB3136.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 06:53:03 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 06:53:03 +0000
Message-ID: <beef5a40-acb8-4f47-944d-d876f5634cdc@kontron.de>
Date: Wed, 6 Aug 2025 08:53:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@oss.nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
References: <pqr4l75nuc57vmrp4r3hjwjxi4p5dgwxlz7h5nrn77rfxwpfmr@dto7364jv2ei>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <pqr4l75nuc57vmrp4r3hjwjxi4p5dgwxlz7h5nrn77rfxwpfmr@dto7364jv2ei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0397.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::13) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|VI1PR10MB3136:EE_
X-MS-Office365-Filtering-Correlation-Id: 200b6ead-05f5-458e-18a0-08ddd4b5e382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekg0Mzl5ckFWdnB3N1h1OTBpK09KWTdPSlNodTZQQWJFSklSNEpSdW9OV1Vm?=
 =?utf-8?B?ZDlEeHNEdXlmSnlvdUxBcFhZTDYvWlFqZzBMR2NKclBZZ1MxMDFFWUd5bm5C?=
 =?utf-8?B?bnJOMGdjUzkvY3R5Mlg0dWhsK3dIMUsvMDhDNk1EQkx4SzRaaUlzRi9wbmtU?=
 =?utf-8?B?ZG5Td25GTzJQckMvQzBUR1Y4YVhkblhFc2tFNUNGL1l3ZWVtWFRnVkZ2QW1C?=
 =?utf-8?B?S3VuVEtOWVRydVkxUXZ2dnlTeGJxbjRYOXBTSUlKVnhtM3V4VHk3eUh4bXlo?=
 =?utf-8?B?RkJ2b1lScjRURXEzWHRBbUlLNHlsRGExeWlKckxoK1FkSlk1OGxJOWNpSTN3?=
 =?utf-8?B?NkFmdy9pY3IyWTliY3Y4eFhFdnM2MjZGcXEydXFOaysrMTI0SmczcjhvM3o3?=
 =?utf-8?B?WU12MmtuSE52MHRURVg0Q2ExQnZGRitOV1EwK2VkU1cwdEZTRnZsd09tSUsv?=
 =?utf-8?B?Y0lnbDdrSDZxTVo3emJBb0syaWl6UEdORU4zaVVXN2xkRHZMeWtsRkhzaXVS?=
 =?utf-8?B?ZVQvV0lqQUFSSk5La3l5R0YyeGozOUk1RHduMHFJbTE3bUY4QWVveDBvNStD?=
 =?utf-8?B?VVhFeVQzT2thV1pqNmp5aHN2aVRDczhwRlJhWUdQL0Nlcmx5RENCbjRtQjl0?=
 =?utf-8?B?TDFmUURPVW9XaDFibWRQenhZVmxpMWxGS0xKSjVqV2lmVmdyY3Nxd2JqMmRR?=
 =?utf-8?B?Vy82WnNtWHFWdHNjamE1WHpwSFpNcFJEWUdpeUVFN1I5VjRNQ20zak8xQmJr?=
 =?utf-8?B?TGFSc2hscWc3Wm5wM3hQaEl2UHRrME9uSkNQRWIzWFNGc1d1YmZWVTVyaFp0?=
 =?utf-8?B?ZE00TG1ldFRERWw1TTFqN2dpaFlZOTB2NGpqMVBKYlE3ckcvbGNkaTJpU0N6?=
 =?utf-8?B?a3oxYnJSQjdBR3U3bXB3WEtaR2dZTWtsNE55REdURHN3blFrM1BvaFB5YURD?=
 =?utf-8?B?SzZZdXpnOEdUeFdWMytxNkYwNnlvUWxBcjRHcEJOdG9BQjNXaS9LYWR1VVNN?=
 =?utf-8?B?NVdNaEhHc2NRdHlvQmpCeXBOUkJMUUdoNVhPbEkxaXZKVHBoUm9tT2NlK2RS?=
 =?utf-8?B?bUZCczF3WUlKd2NQbitXeEJuVTBwS083a0pabGd4Y3o2TmNhNTl1THIxTnZL?=
 =?utf-8?B?RjV3L3ZnZmxSQVorcytsTDczMU5FL1ZXQ1UzaU94VjQyRUwwQVFLY3V4RjFq?=
 =?utf-8?B?R0R3ZDJpK2ErT3pxck8zdXF3WkNDZEFwSFpQcXUxUXBFa1Vmay83cGdSWTNy?=
 =?utf-8?B?T054V2NjejQzeXVEUUVoaS9MSVg0YlFRQWptOE9TdXZzK2l4ZmVkamFJUzRl?=
 =?utf-8?B?Tjg0Sit1NG1QUnZ0N3Z0aE1VTWIrVDhuSnk3NjZrSE9iOTQzeVhleHBiVjZQ?=
 =?utf-8?B?QzJ1cU5qSDEyTGdMRWU0Zk11V2JOTlRMQXZ4VFRBTjI4YTBWczVQWVpaR1gv?=
 =?utf-8?B?RkhVSHozT3dwZk5rVW4zSjFFUklxVmdHRnFFdWtsa0dzRU5xUG1vZ0hGenNR?=
 =?utf-8?B?NFhDenRTL1dNRXNNUHBpZzRsWTliYVFBWjNHNkovMFd1R1JJMTA0dEU2NzdC?=
 =?utf-8?B?N1pSb0JSMjV3UG1FcTAybFNxdXdFTFk3VTgyaklVb1MrR0paemsrWEFWRWdi?=
 =?utf-8?B?cGF2bDkyeS9BY2tSeFQ2ODhBRmNnejlFUTFVS3ZkWFlwaUZmS1MyNGZ0aFVQ?=
 =?utf-8?B?U1dzSzl4Y08ySTFPc256SXUyNVpGK09TRVFqZENQNnRXMVpKNVhmN3FYTVdl?=
 =?utf-8?B?VDN4NHJKNTFvWXBKRWRoaldBTGlhTHd3dXduRHo1dS9XOEdUUFhhUzA5czFu?=
 =?utf-8?B?bUdVWkJXc2gvY1JzWkpKbzkrVDNzQTd1ZVFUTjhZSlF4Qk5SeWhHQmtJby9H?=
 =?utf-8?B?am1ySWU3NC9yaDZIald3UitYRmNWb3ZRWmd4T255R3Vub1ZnVVA1bkdveVZQ?=
 =?utf-8?Q?13mxuvNQKuo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0xiN1ovZVBWZXdnSS9yYmhkS3pMTU1OWkhOSkduQjhneWtmNE5WQWlxL1Bm?=
 =?utf-8?B?Q0dRc3J0empScTVkQjU0Q09LMGtOVVdUWmVHR3laVi9Gbzh6amRLcGcwZCt6?=
 =?utf-8?B?dG5BV0pWVXlUUUduNVdGanVKaHdXQVBjRjk0Y3BMblByTzdiNU52S1VoUkpH?=
 =?utf-8?B?QWQ0QXlOYXJNMERIWThtZVR1VEhsRnRJSm9Cck1NZFVUaXAzVFBVUG5ScFdG?=
 =?utf-8?B?a1dORUloc3FDT2RQNmlCM0l4eC8rTjdDcU91TjJqbE9XRjJKOE5aUkgzc2xO?=
 =?utf-8?B?NDZ3b0hhaUZtRFViV2lMVlBSbW8ycHZOOFpUcmtoMWJNWTQ3V3F2V2s4SGk1?=
 =?utf-8?B?NTlEUUVwVHhhblZZR08yMG1YSDdUZHpkbUtUd0ZxUkphdThudzR5aTFqL0Mx?=
 =?utf-8?B?VDNOTDNseUc0Y3c3cW9zMC9IdDNIa1lybGMxK3kxVVcxanUyT3Q1Q2hsVm1P?=
 =?utf-8?B?WmIwUzMrZ1lsWi81T0Z4aUF6bktJUkhqWDVONmY1Q2krZ0FnUVQ4akZ1amV4?=
 =?utf-8?B?OTdiZm04dmxRZmJPLzRUZnlCaFpjUDNkZEZBbjFONjQ1MWFDREhnam90VVpG?=
 =?utf-8?B?ZFpSMmh4VkVUb3pxbVNZUnZKUyt1cDlLNFQ2OXJBV3FKYm9GcUZnT3pDdnhk?=
 =?utf-8?B?VU5VdXpONlgra0pNRzQxU050YURXS0l6SnR2WTJiRjdRbU1va1JwVGt1K01C?=
 =?utf-8?B?K01vRjVxLzc5SFhodmFTOHNzMC9PcS9oNHFwWUFlVTNXaW9FdENFUTRsc0cy?=
 =?utf-8?B?WWVMN1hRejNMWGt0Z1RlMUw4Tm1zK1hjM09xYzY3eGZFS1ltZlVkZDM2WFQz?=
 =?utf-8?B?VVYvTFAwVGJDWlplRHY0Ry9QVHBIVnJnVUdTbG9jTXY3b2c0SzFodGsrYVNh?=
 =?utf-8?B?MzVKOG53NGxUQlE1ZHRwQUF5WjZPUkVNNGh3MVRyd0ZSWDZDYlJZWUNLdXFy?=
 =?utf-8?B?OW9YaDNFSE1tZVRGQi9rc0hYN0xsTFo0ZFdMODZkcTIzeHMyREIwaTBTTFVN?=
 =?utf-8?B?RzJWM3VDZ3VGbmxvWjR2R2J4Ylk4bnF6eHFHeW1sR2NReGMrSFE4Kzd0VTEr?=
 =?utf-8?B?emRYdDVmMERKVysyWU9Oa2R2WnlheHkxcnAydGNrS3FuZ1Q0Z29FUXlzOHI2?=
 =?utf-8?B?QnNxSUNGcUM2SW02QzUzSkJEMmgrazFFZEJhRmVCeUR2eWlGM3RsQ2JZaldw?=
 =?utf-8?B?K1NSYzhXcXY2R2NNeXpWdGNyTnFRSGNYTkluejZZOGFlUE1ZazJDWWJhZWdM?=
 =?utf-8?B?UmE5eG5jZm1qQVlPZ1FXUmsvL09iK3VRSlloMUtHTTdwVDB4Q1phMERJaEtL?=
 =?utf-8?B?Rmg4WnRoMzJBME1MQlA3QklrNnR5TEgwenRpSVFNZ3NCdlRlQ2tPOHZjV3R3?=
 =?utf-8?B?ckdWL3F5dC9VUVdaS0NDcnpFSlRjSWRFcUFOM2JVR0p4NHpiQklnQU1URDEy?=
 =?utf-8?B?ZzFxZ0Ezb3lacVFlMnB5WHVsY0JRTEhyZnFCaVJHSm1vOVVJUXZEVE9FZkFh?=
 =?utf-8?B?VnpjYzM5TWIreEpqUG1adUQwS0ljNUJVU0dBOXFrbHlhQVlZZkN2VUh5UDNK?=
 =?utf-8?B?bnB4L010ZjdYMmZuczM5M0RtSmxWWUVEcm5tWEs4UzEyZ1dFSEROWWpXSC9T?=
 =?utf-8?B?ZTBTTVpHNTFvYkZ6MEFZNXBiQ0w4T2JTcmR3K1lpRDdEWWpqUW9UUVNFaXVB?=
 =?utf-8?B?alQwYXhYc0FuYWY0UlF3MnVNZW5UUW12TG1HRmJYU2labmlUZVBSTDNkV3Mx?=
 =?utf-8?B?NkdHSFBEYmhGcSs5d1FDOU5DaDZWZGdnVUdEbXJSSklyWjhPcW9PR1h2eUF6?=
 =?utf-8?B?NEkzVkhYZlU0VXQrbHFsT0F0Rnp4WTVxdC82bTBPalZOQ1EvaTZFWXdBMGNZ?=
 =?utf-8?B?MFZBZS9CNmp6N0dQZG1Fd2Y2NmlON0NGQy9YZVd6QXhUT1djaHROdkFsVzZG?=
 =?utf-8?B?WW1oMTdQQkJwY0dSWlFqOVRZcmgzVytvaVJTeXZVMGs4Qm9uejBvVnFwL2pY?=
 =?utf-8?B?UFFMQ2U1N1ZmUURXK3orSy85MkJlM1h4akRydGlSVEZtUEVRSUxpd284SWdl?=
 =?utf-8?B?RTI3b216QnhyS2hCUGlEZ2puTFB6UEF1VGlxbmNKMFovZTVOSFNIc3lpNm1X?=
 =?utf-8?B?YVFZT1phb3BFRHdOY0l6MU5yWHI1dU9Va1BXL0NDS1VCeU5ZeUg0RmMyeE9T?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 200b6ead-05f5-458e-18a0-08ddd4b5e382
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 06:53:02.8983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzQg+2hEIzojYd3sJcjuKYkBfTN6QmfTqhS1TC6pPpuDPm7kBlwwVus5pnrCirl3P1RCOni9YutI0TlasfXzThJhDgoYl+Y4ujBDe+i5Mik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3136
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

Am 31.07.25 um 20:47 schrieb João Paulo Gonçalves:
> Hello,
> 
> On Mon, Jul 28, 2025 at 11:25:04AM -0300, Fabio Estevam wrote:
>> What confuses me about João's patch is that it was not tested against
>> the mainline U-Boot.
> 
> In the end, the code is nearly identical between the downstream and
> mainline U-Boot.
> 
> On Wed, Jul 30, 2025 at 08:35:40AM +0200, Frieder Schrempf wrote:
>> I have the below patch in our downstream fork to fix the issue mentioned
>> here for i.MX93. It is derived from Fabio's patch [1]. I'm not sure if
>> it's correct, though.
> 
> We are also doing something similar on our branch.
> 
> I have two proposals. My goal is to prevent the board from hanging when
> booting from USB if CONFIG_ENV_IS_NOWHERE=n (since the current code
> assumes it is always enabled) and/or if the environment is defined
> elsewhere:
> 
> 1) Imply CONFIG_ENV_IS_NOWHERE for i.MX9 (as mentioned earlier), to make
> it clear that it is required by ARCH.
> 
> or
> 
> 2) Doing something similar to what Frieder showed for USB boot (which is
> almost the same on i.MX8MM/i.MX8MP), but preserving the current
> behavior:
> 
> diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
> index 13f13ca7d105..f973652d0cbe 100644
> --- a/arch/arm/mach-imx/imx9/scmi/soc.c
> +++ b/arch/arm/mach-imx/imx9/scmi/soc.c
> @@ -635,7 +635,8 @@ enum env_location env_get_location(enum env_operation op, int prio)
> 
>         switch (dev) {
>         case QSPI_BOOT:
> -               env_loc = ENVL_SPI_FLASH;
> +               if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> +                       env_loc = ENVL_SPI_FLASH;
>                 break;
>         case SD1_BOOT:
>         case SD2_BOOT:
> @@ -643,10 +644,16 @@ enum env_location env_get_location(enum env_operation op, int prio)
>         case MMC1_BOOT:
>         case MMC2_BOOT:
>         case MMC3_BOOT:
> -               env_loc =  ENVL_MMC;
> +               if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> +                       env_loc =  ENVL_MMC;
>                 break;
>         default:
> -               env_loc = ENVL_NOWHERE;
> +               if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
> +                       env_loc = ENVL_NOWHERE;
> +               else if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
> +                       env_loc = ENVL_SPI_FLASH;
> +               else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
> +                       env_loc = ENVL_MMC;
>                 break;
>         }
> 
> With this patch, I believe Peng's concerns are addressed, and it also
> works for our use case.
> 
> What do you think?

On first glance, this looks good to me. If possible, can you please also
send a patch for i.MX93 (arch/arm/mach-imx/imx9/soc.c) to align the
behavior of both platforms?

Thanks!

