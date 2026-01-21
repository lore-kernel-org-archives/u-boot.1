Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BE4D262B2
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 06:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B518397D;
	Wed, 21 Jan 2026 07:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="O5oj4Gar";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD3D5839D5; Wed, 21 Jan 2026 07:54:51 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9778341A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 07:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tomas.melin@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynILlyFHXNzdiKZzrZNfl2O3d6uTgRhqUbQrUqNJM35zJXdYE4jbYELVNtQlfWzvHrmyeJQTdidzQsG2S4QP+2RyjVQ02N+q+XreEYvO8oJVsCC37SIOYuO4NHoar1wQzGSFN+sdiR9eaT05hzPm+tlfdJHUqamZ513JZGCDfimsLN2Yf9DtIJe/45cXEGNBgLyQWknWT0V9kuhpAYrCsXVX2eXS3GAazGPJC2eRHXMgogyJJj+5JBS6TZrsEmB21nadww20N5ebea5LIQ6cuPe3+vU1TkJpAijKM26uylEs6aODnEX/qLBChTaeMZDXAZQOWlqap06lzb8daSD0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAIq5PLls+CEiO6QwOOL1XhsVX0hPELykJbS1hm6RrE=;
 b=MBTKigpicLM3uFKMnoTi/TI0N6QkPHEfSiTEWJvaWIbEt3SVNwaJcE7mZ03Qkb82tuJPWwjso9m+wu+7I/jIWSnTjNTk6QYNivPVuWUYoiXaSiZpjJQl4+XxEY6vgcs1MdrHVDSJGn4/ep2rIE5U9vcMZiH09XFXozeZtEEoOI1fOttBr//4pNIqnG36OpYD01xKhQyp1jF3rgiaPmYSIeXIfuffLUgkrLUHhEDUvbH9BtbFWEASVdp2J+Fd5gYFi1yrqtOM6I5Pr/pVzTurNXb8yrHQQeKlFxGmOokjibKOV7fq7CI74+JwBttcyV528zWmGlSK131O5d45AV3UKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAIq5PLls+CEiO6QwOOL1XhsVX0hPELykJbS1hm6RrE=;
 b=O5oj4Gar3Xg8lP2NrvJuGIEzOKMvYolj9WoAu+DBX772NUCt5IyEQ7sCMAHmJzsdtOA+j6ykDZgIFXsUXXtuMTQupqxeKSWP2FzHyRR0YTqX/yAB7+F/1zDFKzts4Ha09tdYbuHaQLY8s61c3AePGJJr0Y+QKdytyOy8qIYUwklFS4H5ODWtkgedvqTeS1PV+iv7AdIf5VMahTTDedBdQU4mCHB3gqsKoZVEARnZrZtheMuje0bO7Nvm75p/RPaMiGK3MoZZxXX07RkV+n6J7DIWXXmCaXvkKOuEo2q04+4zg3rtSoZYchZa03pbe2Bu/mDse8BfwNpg+nKCPDQG+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com (2603:10a6:20b:6f0::7)
 by AM0PR06MB6497.eurprd06.prod.outlook.com (2603:10a6:208:1a2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:54:46 +0000
Received: from AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede]) by AMBPR06MB10365.eurprd06.prod.outlook.com
 ([fe80::4606:8e25:96e6:bede%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 06:54:46 +0000
Message-ID: <a10d44f9-028c-4b0c-8266-e681a6bed6e8@vaisala.com>
Date: Wed, 21 Jan 2026 08:54:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rtc: zynqmp: Add clock framework support with
 calibration fallback
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, michal.simek@amd.com, Padmarao.Begari@amd.com
References: <20260120110056.3640303-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20260120110056.3640303-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0042.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::34) To AMBPR06MB10365.eurprd06.prod.outlook.com
 (2603:10a6:20b:6f0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR06MB10365:EE_|AM0PR06MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: c76d914b-9a99-471a-c659-08de58b9f65f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0M0K3d3Z1F2dGNreDFobXlKTE81NHVDOVg1SEdTcGdTMFV2MVFXT0x0bzRS?=
 =?utf-8?B?M0pzMVVyQWZLSUtMVUxCMnZZWDN3SzhmVVVlc2E5bDBzZWlvSzRBa1RDVVAy?=
 =?utf-8?B?akpOTmVHNDFjWldzTy9LOXpGcERDV2ZITlo1UGxxNWdwT1FIMjgyOFZ4UjU4?=
 =?utf-8?B?dUo2eWtJYW5XNU0rSEpOQnEvY2NScXBJRXZBYjEzcXhDYlBXTjJiTFcrc3Qz?=
 =?utf-8?B?dXJXOWQ5bkNqL2phclNpUW9ra1Y4L0hhUkRIbTY3YkgyMTFvSHRNeEV6dGtt?=
 =?utf-8?B?UFFCU0JxaWR0OUpFcTVPamxsSXNoU1ZTWW9qcE93cTgvcFRhY0svWWo5NUJE?=
 =?utf-8?B?Uk0rU1NFTXZNVEg5N0ppR2phMVpNUmtmRE5rKzNGL1VMY2dmYXRtaXZDNi9u?=
 =?utf-8?B?YnhnVmRGKzRyU0dHM2IwVURZeXNIS1k0WTR6QmhVMUtFSmhDdjd0dFg3Wlhi?=
 =?utf-8?B?SkxacUpTdG9rTHg4QUVtUVppNmZlalBOUU9zSktxb0sxdG5TTDY2eDcrbTlo?=
 =?utf-8?B?TGNTMUl2ZEsvL0htQ1ZrUDR6S0RMT1dvU1lYa2w3RE0rc28xaGVZRUt2MkJu?=
 =?utf-8?B?WkY1a0dTOUhzQ0pneWpDZ0V6VVBLaFhsSXJRSGNNR3RZK3RHMTR1aXA5WkZD?=
 =?utf-8?B?RnpnY1lYbExKSFR1SXBSSzBiOHgyQm9iK0lNeml4Tll0OFd3amJQZHFCczhs?=
 =?utf-8?B?VkpzaEhKOHBMajlPUWZkS0xQN0xoUFlJTjNMc213em1tSmhlMTBPN2ZpbE90?=
 =?utf-8?B?WXVZaUNEQ0orMzBGYlpNeUJjNXdxamZDa0g5ZldLa1hEYmdKR2RDbEVXTHBm?=
 =?utf-8?B?QTlnY1lqOEZjU2FoZVloRURaazU3azBzSitYZTZNS2x2akVIU2s2RjUwTkpM?=
 =?utf-8?B?UC91Q05BRXAyRUZoMk1XQ0tDK2VpT1dwT2xLbVY0OEZCMkpndUgwdU5jWUNo?=
 =?utf-8?B?Q0MvdElEa2RMMkxJU3J5RXdGaGhGZ0kzaGxEMG5TK24zRmRsZnp4TDM0Vlk2?=
 =?utf-8?B?UTY5VHdma3ZEWThWVW9ST2R1UkgvdXZmSzYwbUFNUzViUGdMditNVUpnMGM3?=
 =?utf-8?B?NGNXOVdnYldRTTBNRFhURXRsVTZJNUt4Z0hoYy9IdkkvM3JKbDNtN1AzdXUw?=
 =?utf-8?B?UWZaZ2Z2ekJ2dXRYY0Q3ajlIREtzN21GcnZaKzcxTjFVK2pvMytzd0pkSS9u?=
 =?utf-8?B?c0d6d2I1dndORlUvYjB5Y3hncmJZVWUvMG1YYzlsRkRvWHJxV3JQdklKNnRE?=
 =?utf-8?B?NEZ5T05LMmtiY242OGlGRmU0NmpLR2tjVHEzdXpKTnVBRUpEelUvam5TUHdh?=
 =?utf-8?B?VVR5S244eFNtSzVFUXh1TUpCdnJ3N1JVOUlVaVVuUm5FN1d1UHlWVXZROHBJ?=
 =?utf-8?B?cGQ2MnBVblNQQ0NuTmNWWmIrMnNxWVA4RjZuaW91YlJCTVhQNXVyam1VaWZR?=
 =?utf-8?B?TUJ0a3NzNnNTZEZkS3h6N0tWRHRCalh0cDgrOFBlcS9nOXFtMkNwU0pBZzVF?=
 =?utf-8?B?aDZWNi9NNVZ4cEQ1MzQrbnA4TUtJV3ZML2ZvcUdTdkNXeXJDdGxwVE0zcHNl?=
 =?utf-8?B?NncycjNGbkRhRmxYNUVBd1J4eWs4cXNpL1V5elRTaGt5YllBWldEbGE0cGl1?=
 =?utf-8?B?RXBWQlB1VHdqbkJ2V01iUk1xakhhdFJiUnJKeVB3QWJReWxtalRlaUljTlZ5?=
 =?utf-8?B?V041VXdDTkFYQloyOGhXZU5wVjUzVTYzK0VDNlZVWkpyRklOTVBLK285Tlhy?=
 =?utf-8?B?TEZYVCttZ0FIckpGSUtBd1N3UGNsaG5SUTFiejdFY04vUDh1N3BpVTI2QVhn?=
 =?utf-8?B?OGU1UkIvVVc0eFNBNEg0WklWdHl0WEpQWFA3Y01IS1FRSUpBRzZCRGFLUFRp?=
 =?utf-8?B?STBjWGVTS1Z3U0lmWUt3aERtcmdiVDB5eXdPaTdjK2NJZU1rdVp4LzNBOXFj?=
 =?utf-8?B?bEFTcUhocjgzSUNSZUZBcFFVZTRhdHV1c1VUME0rdWU1WHU1MVZ6MUtvbUxv?=
 =?utf-8?B?Vmo5b1U0QXFPc2x2Y0owNDVPcG9MdURaZEY5TFVXZnNaZTlpMWR2bHkzanJ6?=
 =?utf-8?B?bnRTN1hZUUNQUWd4TWpQSmVrTk8wVkZocDdGM2RCckxJZ3NRZ3hFdlVTMitz?=
 =?utf-8?Q?XjIg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMBPR06MB10365.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2R5UnpOZ0lYL1lURi9wZlNIbTRmc2FmR0pQbzQwRTFKZjkvYWdHOTM1QUFX?=
 =?utf-8?B?TGt2WGY0QUZ2VmtPU1d1RitoK2IwTVFNeENxak5RbFlWbGVWdkdjL0d3elJj?=
 =?utf-8?B?NXNoRGQzWldmUTNEL3VaRCtVVkk5SFgrQ3ZLREJUQlduYVJseExFUUd6YStI?=
 =?utf-8?B?RzdXVkxySHh1TXVWZER1QlQrR0FRU09UZUFvWHh2TENDdU5kRHhsVGFZdW13?=
 =?utf-8?B?RTZvRXk5QlhqMEh3WVYyMjRXRkFEL0FoZ0lDbk0xTFR4dHVwblJFcmsrOCt3?=
 =?utf-8?B?L2FSRFRkYmlaQUdCNWtSeEtwaVVocmJJMTdSL3I0NmxEZE1DalBRTk1NQ20z?=
 =?utf-8?B?bXdBc094L3NZY2hNQ0lBdllmRTAwdXZkVnZXT1hIWTZUalUwZnF3NkdlSXZD?=
 =?utf-8?B?QWNhblVERllJOHBJQlBuQ0dtWnhOSHNXV0NvVGVkcTE3eUdYUlBGK1Q1dTFj?=
 =?utf-8?B?VTEvY1hIZFlSc0haQWZFdWY4dk53TSsyK05JZTVUTWZzVkdFZ0xQTUFaazJS?=
 =?utf-8?B?dWNSUWxSeEFDWkJjQlhvL3JDSWdoaXVqV1p3T1lJRGthcW5GN0Fvb3NHTVFU?=
 =?utf-8?B?S2dtQmtEWXZSdm1Ud2ZZQ0ljcXA3TUpwRGtXV1dpd2FQTkdabThxZWpOS1Nw?=
 =?utf-8?B?K05taG1UcVlKNS9LazE4WkN6eWZXK1N0anpBdWFwc3hBaDJBcnJKNDF4Q2xi?=
 =?utf-8?B?VTl0UzlkaTJKcWd1SitkQUNsSmowQk10SzhsaEFZOXpVQVB3a2oyckgycER4?=
 =?utf-8?B?RnhXMWhxNDN3ZllEWTg0OUw1cVNtQUVoL1VuYlJ1eE4zZjYyNzdQTWdwUUJZ?=
 =?utf-8?B?U1ZmVXFEMXZ4ZDFrTjd0VmhLZktCT3lvK0pScWpFOEg2a0NhV2k4eVBTUTVT?=
 =?utf-8?B?MFZwWkNHRUY1ODJFUVZiZWJsUUUxc1hnVy9MczhTbGhNWmR6NERyY081YXVl?=
 =?utf-8?B?R0EwdFdYRzdJMWlWS1JIRFpoRGdPeE9vNkZRRkVRSWpITlMzbHFycU8vQS8z?=
 =?utf-8?B?RTYvdHFESGEwRmo2YlhicmlJY3hyMTBlSkpnbUs3MCtPdDVCRW44SmhHNHNC?=
 =?utf-8?B?bWxPeWorbFVvckd6dFIxdkhDR0EweWFCeUJpRnBaeHl4Ujg1UzRGRlhyUWNR?=
 =?utf-8?B?aW5QMFdTTlBlZHFaZU5DYWtGQVJRWkxYTGtGbm56cGJQbWt5azh3YWlJT1RM?=
 =?utf-8?B?Y0hNcEI1bFhIVTBZVUZneG5GOXhNb3F1bCtuczhoUEp1b2diTEdXV2Evbkkz?=
 =?utf-8?B?UEZtcXZZdGQzNHZ2ckhsMElTOStmK2ZMOU9zQkdOZzNUQVpldFdMaFhhbzNR?=
 =?utf-8?B?cXptdVIySXlIM2owVFhFRjRqeUl6c1VKaE96aVRjcXQrcWJPdytyZ2xZeXFs?=
 =?utf-8?B?OU5wbWFsdUFDOG1QMldPNjRDeUdYZENMUVdhdE4xbGlMdmg4S2twYm1xYWNE?=
 =?utf-8?B?ZVhMZnJBc2hHcEcxTStQVDRhbjk2WW94S2tzbTFUYmlEejNuY3YrNThIL05F?=
 =?utf-8?B?ckdERDdOUFM1WHlvV3JSTE5ZcjZmczd4aXU1N0FnM0NuZ1JPdStOQ3ZDajNL?=
 =?utf-8?B?d1c4dzgvRVlCZS9aSStMRUlqRkJvVXBrVSt1a2FwTEUzd0JEK0I5eUMyUVlt?=
 =?utf-8?B?NklGdUlBc3FzVzFvd3hIYjk2Z3UxSmw5NGJ1UHdjZk12UVhQQUNLRE5ITGRJ?=
 =?utf-8?B?c3ZOcGpidmxERGFpTGw4dVQ3b2xoUEpCVmRWZEltalhsRVBCWkJOYVpSRUxz?=
 =?utf-8?B?Z0lXbjNmbjZLbVc3TDlFbXE0N1RWVjVsRWhyRCtndWp3MGVhU0lkR3c1bUVI?=
 =?utf-8?B?SE0zU2lQRStxK21uVzVmMTJDM2ZnTjhZTElkN1BTVzVQbWRZMUtTMnNNL09w?=
 =?utf-8?B?clBJL1hnYjdYRWs2U0lBMUZMMkFFTDNCSVJHVVpvZ2toV0IzdWJhZ1BOcVl3?=
 =?utf-8?B?U2ludm9sRzdVRXgwcXdGL1dCK2lYdmhlTTFXWHdhc2hSNjkvMzBmbmNTZXIw?=
 =?utf-8?B?S3ZpTzFmMW5kMFNvNWpBamtVUkxSbXJLWkJrZ25TOHZCaUthQzBuUzhmK1Uy?=
 =?utf-8?B?N0JlYzR1Nk9mVlgxRjI0ZFlURndkV2krNm1KR0p2QVgrd3VEL1p1amxsSmhJ?=
 =?utf-8?B?VkJITE5jc0FJTm5sdFp5MWNMZzNaeVBiS2xOek9LSkI1S2ovYTl6bUdPYUxh?=
 =?utf-8?B?azVaSE1icDFuN0JpUERYMC92MCsrbmNBNjVkSmQycS9xT3plOXErZVRoVzhO?=
 =?utf-8?B?dkhLbDNyYWJ6a2xoelVGWnIxSDhUUFVxWGkzY2xHdVErVkRDYU56U21PeUdn?=
 =?utf-8?B?K2Nwb3NpendHaUo3MkdyTXJSc203RHc5S0kxOEN6QmIyNDA1YnRSb3VpZ3Br?=
 =?utf-8?Q?aLwFfH+kAzJLaAnk=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76d914b-9a99-471a-c659-08de58b9f65f
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10365.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 06:54:46.0061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyr83KDJtXRorR74n8mK1o7kkUVNibrvg4vIoPPLG++2oDHN8OphAzkuoe8DAytE1GVRcjPJzaVuZQM0Y2AIkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR06MB6497
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

Hi,

On 20/01/2026 13:00, Pranav Tilak wrote:
> Add support for reading RTC clock from device tree using clock
> framework also update the default calibration value to 0x7FFF
> as per RTC specifications.
> 
> Falls back to 'calibration' property if clock unavailable, and uses
> default calibration if neither is present. Only writes calibration when
> hardware register reads zero.
> 
> The calibration write previously in zynqmp_rtc_set() has been moved to
> the probe function. The earlier implementation wrote calibration on
> every time update to clear the tick counter, but since calibration is
> now dynamically configured from clock framework or device tree during probe,
> it only requires one-time initialization. This avoids repeated tick
> counter resets and unnecessary overhead.
> 
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>

Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>

> ---
> Changes in v3:
> - Reorder includes alphabetically
> - Update the commit message
> 
> Changes in v2:
> - Rename variable from clk_freq to calibval
> - Handle case where clock node exists but has no clock-frequency
>   property
> - Treat invalid clock frequency as error instead of warning
> - Move calibration validation outside if-else to apply to all code paths
> 
>  drivers/rtc/zynqmp_rtc.c | 64 +++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/rtc/zynqmp_rtc.c b/drivers/rtc/zynqmp_rtc.c
> index 15122a04838..4fee75bf9cf 100644
> --- a/drivers/rtc/zynqmp_rtc.c
> +++ b/drivers/rtc/zynqmp_rtc.c
> @@ -5,26 +5,30 @@
>  
>  #define LOG_CATEGORY UCLASS_RTC
>  
> +#include <clk.h>
>  #include <dm.h>
>  #include <rtc.h>
>  #include <asm/io.h>
> +#include <dm/device_compat.h>
>  
>  /* RTC Registers */
>  #define RTC_SET_TM_WR		0x00
>  #define RTC_SET_TM_RD		0x04
>  #define RTC_CALIB_WR		0x08
> +#define RTC_CALIB_RD		0x0C
>  #define RTC_CUR_TM		0x10
>  #define RTC_INT_STS		0x20
>  #define RTC_CTRL		0x40
>  
>  #define RTC_INT_SEC		BIT(0)
>  #define RTC_BATT_EN		BIT(31)
> -#define RTC_CALIB_DEF		0x198233
> +#define RTC_CALIB_DEF		0x7FFF
> +#define RTC_FREQ_MAX		0x10000
>  #define RTC_CALIB_MASK		0x1FFFFF
>  
>  struct zynqmp_rtc_priv {
>  	fdt_addr_t	base;
> -	unsigned int	calibval;
> +	unsigned long	calibval;
>  };
>  
>  static int zynqmp_rtc_get(struct udevice *dev, struct rtc_time *tm)
> @@ -70,13 +74,6 @@ static int zynqmp_rtc_set(struct udevice *dev, const struct rtc_time *tm)
>  		 */
>  		new_time = rtc_mktime(tm) + 1;
>  
> -	/*
> -	 * Writing into calibration register will clear the Tick Counter and
> -	 * force the next second to be signaled exactly in 1 second period
> -	 */
> -	priv->calibval &= RTC_CALIB_MASK;
> -	writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> -
>  	writel(new_time, priv->base + RTC_SET_TM_WR);
>  
>  	/*
> @@ -107,15 +104,6 @@ static int zynqmp_rtc_init(struct udevice *dev)
>  	rtc_ctrl |= RTC_BATT_EN;
>  	writel(rtc_ctrl, priv->base + RTC_CTRL);
>  
> -	/*
> -	 * Based on crystal freq of 33.330 KHz
> -	 * set the seconds counter and enable, set fractions counter
> -	 * to default value suggested as per design spec
> -	 * to correct RTC delay in frequency over period of time.
> -	 */
> -	priv->calibval &= RTC_CALIB_MASK;
> -	writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> -
>  	return 0;
>  }
>  
> @@ -128,8 +116,44 @@ static int zynqmp_rtc_probe(struct udevice *dev)
>  	if (priv->base == FDT_ADDR_T_NONE)
>  		return -EINVAL;
>  
> -	priv->calibval = dev_read_u32_default(dev, "calibration",
> -					      RTC_CALIB_DEF);
> +	ret = readl(priv->base + RTC_CALIB_RD);
> +	if (!ret) {
> +		struct clk rtc_clk;
> +		unsigned long clk_rate;
> +
> +		/* Get the RTC clock rate */
> +		ret = clk_get_by_name_optional(dev, "rtc", &rtc_clk);
> +		if (!ret) {
> +			clk_rate = clk_get_rate(&rtc_clk);
> +			/* Use clock frequency if valid, fallback to calibration value */
> +			if (clk_rate > 0 && clk_rate <= RTC_FREQ_MAX) {
> +				/* Valid clock frequency */
> +				priv->calibval = clk_rate - 1;
> +			} else if (clk_rate == 0) {
> +				priv->calibval = dev_read_u32_default(dev, "calibration",
> +								      RTC_CALIB_DEF);
> +			} else {
> +				dev_err(dev, "Invalid clock frequency 0x%lx\n",
> +					clk_rate);
> +				return -EINVAL;
> +			}
> +		} else {
> +			/* Clock framework unavailable, use DT calibration */
> +			priv->calibval = dev_read_u32_default(dev, "calibration",
> +							      RTC_CALIB_DEF);
> +		}
> +
> +		/* Validate final calibration value */
> +		if (priv->calibval > RTC_FREQ_MAX) {
> +			dev_err(dev, "Invalid calibration 0x%lx\n",
> +				priv->calibval);
> +			return -EINVAL;
> +		}
> +
> +		writel(priv->calibval, (priv->base + RTC_CALIB_WR));
> +	} else {
> +		priv->calibval = ret & RTC_CALIB_MASK;
> +	}
>  
>  	ret = zynqmp_rtc_init(dev);
>  

