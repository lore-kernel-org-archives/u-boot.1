Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06E2D38FE6
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 16:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B41680433;
	Wed, 14 Jan 2026 17:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WBV9zuWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21FD8063E; Wed, 14 Jan 2026 17:36:50 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849E280325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 17:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cj4C6NmeaKSEtb3tAa87Rp+tzSJhQ2Vfk14tDGfYh86cvQ3/jwY8GAROAHbWLBl5DJIWBT5VMh+IwSJGO1dLilwhL5P1aN7WsH+nLrtZQrYKDgbBgE8gzgX6heIRj+oygi+ePKLo+P2rCtmYn9BM+AM45vJc1akAchIrg9oAOCsGxcLG3PMvOH6nkxMyUBORQmhE03O/JjcJNFnnTyPKQzUI2pLyoZFo6pCdcx7IbfnuaFpAZctQh9cuLkdQokkRXzB67pjqH/9uOxtU32NqFq8wHDQPENcyBRKGZQtFDtjrOo+19Cf3POFX/vHSXbAHqR0ODt3j1cWyVexoRG/h/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uv9zR8AfBcZ8vqoF/kcSTpY1yAUNRR4o2QJibjlD9Jg=;
 b=aQOhDZ+Twcq4tE1bPfKnEQECNVUKrVZRKNJDwdSb0jFyyI4iFOrA7tct3qeGrwNWUbmTfma4yXtUl5orFmEA1nsUUnjuM78c9howO5J+JYiQUfB9wepn+mOwsHOrHNMOHjBJM4A93SVFiVndJJJWNkefvFOyGDUwxn+YHBEnGToi3fzmC/KFFtOcgnAImjvUpzOnL5yF3tU+ckCzb9teJei6aippXBwEjliK2z51wSWrWsFIPhYDX0VZiPe1sBtLGxNgVRuST/G/3zW/C1W/FQLhjOCmre+b51uJxWdjkMaBnVIYfJI1P43lUVpIrnT8HXtM9lt+Dtsu1tB0phyOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uv9zR8AfBcZ8vqoF/kcSTpY1yAUNRR4o2QJibjlD9Jg=;
 b=WBV9zuWX113p6fm1ckR62gmoaRXBt5ZYrcwu2dgiqj4soygzh0c48cr7KBBjceS/DlfjTKDuHg+tzHYk73gMRbozp1keBGuNocjnULpM068tK+UMWWr2hLzkQk2uEJquDhvtmrdcZeIVIwdwU2eO3NegGcxbVTBQ9HcAA96XSO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB11724.eurprd04.prod.outlook.com (2603:10a6:800:2eb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 16:36:44 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:36:44 +0000
Message-ID: <72dbeec9-448c-4828-a887-61a596e4451d@cherry.de>
Date: Wed, 14 Jan 2026 17:36:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] test: binman: Add test for pkcs11 signed capsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, simon.glass@canonical.com
References: <20260108141346.1663305-1-Wojciech.Dubowik@mt.com>
 <20260108141346.1663305-4-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108141346.1663305-4-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB11724:EE_
X-MS-Office365-Filtering-Correlation-Id: be551756-28b3-4022-03f4-08de538b1ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkgwYzJyMnViWmlRUkF3ZlNOVkdqWGQ1UjBKSXErank4MkpuYjRneXpmanpU?=
 =?utf-8?B?cm8wajNvdkd2bHdzRFBkdFhEYmUxQnhpTHhMdTlNdThENllpbjVpQ2JVSjRh?=
 =?utf-8?B?WitiaStuWWRIQ1g1QTNYcVo1YitMT2FVbU9KRkVaTk9KdDBxL0Ixc3FhNkhJ?=
 =?utf-8?B?cExjSFZPd3JUSm8xejd0SE5jSDBuR1JGLzlST3ZhUVNLWGlOQTkyVlFKQlpM?=
 =?utf-8?B?OENKWXZBRU41WXdVekdmMkZzYTFNZ2dyMHAyaUFZVnNJZVNFNmtrTkVjTitD?=
 =?utf-8?B?RjlKYVJRTkdyZUgvSWV4NUZKM1o1SFJyMFJVcm5rM0pjblVMSC9zYXNkb3gw?=
 =?utf-8?B?aUlSTGxNL0hweVJlNUZDT21jMXN0MnlCZjlQai92MkJZK0NhazNTaElIVitD?=
 =?utf-8?B?c2JrNlZpSkJ5djJDTUowQ3ZxdVUxY0hJdURyeUdmYWpGOU5qcWppeXpXUnpF?=
 =?utf-8?B?UXZkQWdIb0xuNE83Y0hzVitTd3pXa29PRFNtT3NoYXBqQWd4OWpSRThsb1Z5?=
 =?utf-8?B?N0hURUFSOVRFQWJHb2lUQktaeFhZazNoM2JLcm95S0taU1hDRms1RzZpU05M?=
 =?utf-8?B?NDM4UkxRK1ozY2xySi9ybTdSYXVBS3NDTEsvUXo1aFVoajBHSEMxdlBFWUln?=
 =?utf-8?B?MDZRVXExNWhUTmc0T2pYQ0NMWFdIUGVSekJFM0ZLZ3dTaFFTR2dPQXA0Smg0?=
 =?utf-8?B?UVNhTU5IUEs2ZEtOS2ZBV0xaK3A4TXBDbTRhcWhPQ3Z3c3BSRWQzS1FoaHh3?=
 =?utf-8?B?MzR3SU1wM2g2UDNzcmRQaGlSZzN5R1BwYmNmejdxR1pjdGxZT0k0SVEySzk4?=
 =?utf-8?B?OUViUTlMVlVyVXByVXpXdEtvNGNOZ3dXOTZsUnF4eWdNSE1KVyt4bURnNmFu?=
 =?utf-8?B?eFVHWjg0Vi9MdGVXRUpwSFRGOXV4UDBQa1ZtZkJ4WndYRHR1dUMzdXByNmsx?=
 =?utf-8?B?Z1NjSWhtaytlN2Q3MXg2ZklTbWZjb1J5SmlZUm5mVmVzSlMwU1FNdjRQVStL?=
 =?utf-8?B?UmpHdzV4ZzcyRnlFVXphUFpLVFBNT3F1UjBrZG1wOW90Vy92VDR0RklFZ1RM?=
 =?utf-8?B?eGcyN0Q4S2JIdy9aakFTejRmcTQ5VWJHYzNOREM2ZHlvTURpSFUwMCtMVFd5?=
 =?utf-8?B?REpzU1V2REk0dFJCQjFOOHh1TkhGV2lGTitLZTFyeUtnazJOQ0lYUk1xV0hx?=
 =?utf-8?B?TWxld3lYaUJ1dnhCTkJ1b2dTazZFSzdYQXJ5REVUTCs3R1lIWDZ2cUorR1pp?=
 =?utf-8?B?Q1FPNkJMdVB4WHJMbmNjajBMNjl0cFRZRERJSVVMY3pzYk9nOG1ocWV2R0tO?=
 =?utf-8?B?ZTU3SEI5RW4rUFR2TWVzb25KN3c4OWJtRnk2bWNvOXFjaGRyT000b3VUcjUx?=
 =?utf-8?B?MVdaak5UK2xITzNEYmlsSEg5cWNIMmY1MGNGQVlGNjdWZWVzVWVaMkk0VWJE?=
 =?utf-8?B?emRhQ2NhUnNaVkxMeXFyLzhGbC9hME9lb1hWQ05xSWlpV29lYXdTTkpnVXVs?=
 =?utf-8?B?RzUxN1VkbllTQk5McjdvUzMybG00MWUvLzRyQklWbTBGZGtvanMvUEtFOW44?=
 =?utf-8?B?b3RHem81dnpIVnFsTTBHejVTQWVVclVBR1g4K2dCaGUrcjdFb1E3Q1BLaWhz?=
 =?utf-8?B?RDZjYTh0cyt0dmlqeWkwUm5WL21neGZ0ZVlKVmFqcC9ubHJ4bFg3WXZJM2M3?=
 =?utf-8?B?Ni9UNHlpdjNiUDh6czVlMTZBRzZrY3duUm5tZjF4RUhPL3cxTHRMK3RWSjRO?=
 =?utf-8?B?RE9LRlExeUROSUNzbW1xdFgxVmJWbkNiS0NpQnVKWm9qSm9LYW5QbXBmb3VQ?=
 =?utf-8?B?Qm1MMEttdmZQdWQ2Rk9yMmkybjY2U2dPaFVxbC9RejNIeW5CUmxQdXljQkJp?=
 =?utf-8?B?V2l0cTRDZ2tub2N6UWlRMTNaeXlQeHhMZW9mL0UyNHMwVHdWckptcUVJeXMx?=
 =?utf-8?B?VW1YdTl2ZWNGd291aFVweG9RVUgxV1ZGRWNtZmxkNDU5NThDSXJsWjRBV3Bv?=
 =?utf-8?B?bmtURXJFeWl6VUFVa3JNcFhjb0tzc2RnUTdhRWtMSEltNmdZekRyOXovRGtD?=
 =?utf-8?B?U0VQb0hvQ1dEci9mZVp0Sk1kNFhSbjMyYTVRSFk4SHlTSkNaNE5yWUNON1Vi?=
 =?utf-8?Q?p0Tg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(7142099003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVQvTXhSbzJZSWIwUGJsNGFXa0tUV3ZoN3ltcjlhZFdSdFJVbEdERGpwaGtE?=
 =?utf-8?B?Qlh6TVo2MzF3UHVlQTRBeXZIOGdzQUdvd29uNlpCTVFBa05TaVdYRkpiRmVq?=
 =?utf-8?B?dGhveXZ6emw5TkJrR0RhckpWSDNseWpnRlRZdWlXeExkVitUVms1TmVwNFla?=
 =?utf-8?B?VU11NXlrUUE1SXQ2d0lOYUZPaTFleUFFaER5WHg2endmRDFDL1RDWTROOEoy?=
 =?utf-8?B?RGZLWEpwK2EwMjRabXFHRVB1WncrUFMwYkVJd2RLcHNtTnVYQmVlVnZFcm41?=
 =?utf-8?B?d3BnWk9wa2g1NElWTjNBZG01MXMzZjlIN1VWRWttZHRkRXZNN3BOQ285MVBS?=
 =?utf-8?B?MWxJZzBYaytOM2xLMjlITGU5QXAwK2Q4QlpmdUpFNXJCaDlncG1UcVNRQjBF?=
 =?utf-8?B?TnZleVZUZ1RyTEppTUlqRjhEYWZrUG1QT3NvS3ZQUC8vZFZVZHhQMlRGOXRk?=
 =?utf-8?B?dDRkNVF0ekZqSGtET3FNdVJuUm5VSHRIbWJKZE1FNlFpL0FJNUpoQUloSExw?=
 =?utf-8?B?Z1JzeUF0WkJYK2RVUzkwVk10TXo1OWhMakUvaTArb2tjRkhqWlUyajlta3dv?=
 =?utf-8?B?My9HbTlVSll5TmpPMTZoV3VTdVhLc3dwcC9PSE9OdXZmTVlIRitDVnE4dlU1?=
 =?utf-8?B?VzVDMXl1YVlSK2VUWWFSKzJMVkJXSmpxajh5S1I4NUliRXlGNVZZOGI0U3J6?=
 =?utf-8?B?YXdVbUJ3WWczamhSdUZ3eS9BWGZwbGxEVXJNQlZWYk1oVVd3dDNyZ0MxSVlT?=
 =?utf-8?B?dkZnVFBoTUZxL3BpbEUrNUhocmQycVFOSzJrZEdWQ1BjdE1sVWxpMWFPQ0Er?=
 =?utf-8?B?NE1NSGpnR2tJUGRWYk5RUnVlZGRGVWRxRXNSc0JHdTcrT1FJU3dqb0dsZmcy?=
 =?utf-8?B?SDl6OEJ2emgzc3hOcUJzaWZ4cExtbmVkWGF2SkhsVlowQ1VLTU1PZXFNQU1R?=
 =?utf-8?B?dWZNbUoxSzc1emUxVlREZWxwUk9xMHU1eU50KzFzRE5ML0ExekEvalRIWThS?=
 =?utf-8?B?WkNPcVBxODg2NExpYWMvNXQ5UjM1TFhPSDlLZUFjTkhpZFZ0WjQ3WTZiV2Qx?=
 =?utf-8?B?VEkxMWJrcWxyK3pWOGpld3VNdGhQdC9YUlViSXRMOHNJZEswcmhKSWFLMysw?=
 =?utf-8?B?M2FCbFN3YjE5Qmwra0FYbGdYSWVIZ2FKMTBGekJ2NkpIalNCNnowUEF1RGk0?=
 =?utf-8?B?azlJamFyYmpod1V3bkJuYm9HQVl4bG9wL1I3K3I2dDRaQkhsUFhBdjdSNjVq?=
 =?utf-8?B?ZlpwRFloOEtaU3RnYjhtYmd5dm9FTzk5d0Fhc2xDSGdkRUR6dktLNGRmemZS?=
 =?utf-8?B?R005VGJJeGo2dHhUenEvYnAxMEVWRlVOaEkvRzlXRVVubmlkc3FwOVB0UlE0?=
 =?utf-8?B?a0UxWlhrUDVxNmszMzgxMmEzTkt4ZEVJQk9yUEc2RVdKbmlEeGh5enZnbTNu?=
 =?utf-8?B?VHlOeW80ZkhZR1F1dmpKa3k1bFQ0cEdqVVdiRmdaMndZbVlWbnhOSFd1THNj?=
 =?utf-8?B?RjNIdEVKd1NpNkVtK0VvaDVTTTlTemtSRFBuSmJKTmFQS0VVeDNaWTB1b1Mx?=
 =?utf-8?B?TCtFSkkrUC9OdVRWSDZCUzczWklzUVF1WXV6dUY4MURSVExjWVdVWXdBeGda?=
 =?utf-8?B?MmtGMVhtM3VmdlZ4bUw4Ykc1eFlMc3lSandreGtURlU0WndpaU1aM0swRGdr?=
 =?utf-8?B?TndlVUxIczkrNVJtMVNqc3NFWEptZk0xTVJGSFlacjVsQkdDaXZWZndEcjhh?=
 =?utf-8?B?bGoySlNURFl6Y0RMNDY1cnpHK1pUQlUwbjdGaHdENnFlOW04SGFCc1pwRS94?=
 =?utf-8?B?VmpuUExXVmZQUFhJYmpyZzhUbGVaaXpZZ213cU9ON1N5R3VKZVRxUElBM1h2?=
 =?utf-8?B?ZU15dzBtWHczektrSDBMNGdhbklmUFQwU1pxQXBsa0lVRXNBRnpaQ3AwWjVB?=
 =?utf-8?B?NGEvUXFmRUE2QWNFV2ZPZW1hT0RadS9CWFdjcEUvTEYxOGdTZTJGSWwyQmlo?=
 =?utf-8?B?OVlZQlh5Q3pNRStGNXZsR1NSenhUbzRXYUc2UlEyRUFyRjcwcnpTZWREeFdZ?=
 =?utf-8?B?bExua25FV3V5emR3WTc0bkNkSlgzcE1WWE5zZ2QyL0J6RWl3UGxpRytuRmVm?=
 =?utf-8?B?M3B1WnB3ZVd3aWt5UUpDdDBISDRvbzNnT2FISHdVSUdUUnB6eGhMZURJcmZt?=
 =?utf-8?B?dWI2cHMvb216czdBK0NCQ0FRdTdIOGlUMTk0NVZKemFIcmc5Q05nK3FjNm9B?=
 =?utf-8?B?QStPSkcwZFFjLzRmSjJ5VUhybUpYajJhT3BUUFNLMlNWajBiR3JaN2g4UWVV?=
 =?utf-8?B?a09MOTlacWo5M1NsZUEvWU4wUklObURzQWtMNDl0YjY1RjVGQThsUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: be551756-28b3-4022-03f4-08de538b1ab5
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:36:44.7614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q8/ZyuDR3TJ11Y5QIPNoMWgtDcL6K55BDn9ZEA+n8vHSe0V9SFBSw/Kev0Lh5BZEYxR7nez9nXdzVsTKADZMVC++O79kzf9gKbWfmFD9bWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11724
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

Hi Wojciech,

I didn't see you had sent a v3 (going through my inbox from older to 
newer :) ). Please ignore review on v2, i'll repeat it here.

On 1/8/26 3:13 PM, Wojciech Dubowik wrote:
> Test pkcs11 URI support for UEFI capsule generation. For
> simplicity only private key is defined in binman section
> as softhsm tool doesn't support certificate import (yet).
> 
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> ---
>   tools/binman/ftest.py                         | 42 +++++++++++++++++++
>   .../binman/test/351_capsule_signed_pkcs11.dts | 20 +++++++++
>   2 files changed, 62 insertions(+)
>   create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
> 
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 21ec48d86fd1..ad5c2d63900a 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7532,6 +7532,48 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>   
>           self._CheckCapsule(data, signed_capsule=True)
>   
> +    def testPkcs11SignedCapsuleGen(self):
> +        """Test generation of EFI capsule (with PKCS11)"""
> +        data = tools.read_file(self.TestFile("key.key"))
> +        private_key = self._MakeInputFile("key.key", data)
> +        data = tools.read_file(self.TestFile("key.pem"))
> +        self._MakeInputFile("key.crt", data)
> +
> +        softhsm2_util = bintool.Bintool.create('softhsm2_util')
> +        self._CheckBintool(softhsm2_util)
> +
> +        prefix = "testPkcs11SignedCapsuleGen."
> +        # Configure SoftHSMv2
> +        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
> +        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
> +        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
> +        tools.write_file(softhsm2_conf, data +
> +                         f'\ndirectories.tokendir = \
> +                         {softhsm2_tokens_dir}\n'.encode("utf-8"))
> +
> +        softhsm_paths="/usr/local/lib/softhsm/libsofthsm2.so \
> +                /usr/lib/softhsm/libsofthsm2.so \
> +                /usr/lib64/pkcs11/libsofthsm2.so \
> +                /usr/lib/i386-linux-gnu/softhsm/libsofthsm2.so \
> +                /usr/lib/x86_64-linux-gnu/softhsm/libsofthsm2.so"
> +
> +        for softhsm2_lib_loc in softhsm_paths.split():
> +                if os.path.exists(softhsm2_lib_loc):
> +                        softhsm2_lib = softhsm2_lib_loc
> +

This seems brittle, isn't there a better mechanism than this that can be
offered by distros? For openssl, installing libengine-pkcs11-openssl
(and setting the provider in the OPENSSL_CONF env variable) was enough.
Is there something similar to that for gnutls?

I don't think this will work on arm64 hosts, c.f.
https://debian.pkgs.org/13/debian-main-arm64/libsofthsm2_2.6.1-3_arm64.deb.html

> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
> +        tools.run('softhsm2-util', '--init-token', '--free', '--label',
> +                  'U-Boot token', '--pin', '1111', '--so-pin',
> +                  '222222')
> +        tools.run('softhsm2-util', '--import', private_key, '--token',
> +                  'U-Boot token', '--label', 'test_key', '--id', '999999',
> +                  '--pin', '1111')
> +
> +        os.environ['PKCS11_MODULE_PATH'] = softhsm2_lib
> +        data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
> +
> +        self._CheckCapsule(data, signed_capsule=True)
> +

Don't you want to validate it's properly signed?

Cheers,
Quentin
