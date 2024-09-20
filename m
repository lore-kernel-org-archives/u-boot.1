Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C56C7883B
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 13:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A2518919A;
	Fri, 20 Sep 2024 15:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QeMnX5i6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04B5F891B9; Fri, 20 Sep 2024 15:00:04 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE8BE89163
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 14:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaXA7xRz/ECCQITHh9r0T5h3n5r1zDAsdD+3ewz4au1rEigKyxa+bX9VCOgu8OlVP+HQdbHlyEmwtowBbDoqGBdDGlzBTssrbxux/oa+q0S2HXNmyRzUWxBXyOniEBZOnLjD090Zf4r5+nHkaQ75amsy/a640sHVYiB3ucDRYm9kkanjKJZYsQfy80Jqu1ooumlmQfAo9ooW3sU/9WYAkhQIGdf69PTSJ5oW+rVYXqppCdFrhsOacClAzkfGr3tWZGunln1bMwU90DqFyMrxnbId8m0q9Qnl7UCEVV507ZFcCB3qLvAa71zPlBesp9cCG9anWvpJQTVUWULfZVD/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOP7U1ov7t7niVBYhilsXWBJ7sSCB0tYs2y/aOyak6Q=;
 b=T61q6Vz9ClqfiLFcTuKqa1jANaQMP3dSaq9xCguHBdD6PhS3JmmNuGwkHvkYj0stFbSMinKLTWzx/Eu4qPkVhrofjjTwO+Yww8svcTvH5awpASjSH6CEG/1kEFMLfyjxFQ6TDQC/ijnCzzy85de2QpSPiuPPA5Y3oaRj4QvTaABzQ6ZodlaiRQohEu/VenhWpx0i2gOrzOdCSEHAVrKvjZE2sTLlKN0CIdRcrqItADDbzKBgYciNRfr3PR5kXW5foTN55EsQiTj9tGp747E8/f0PRlofdBSAelo8y4De7VO1trhD/nUxKlO4u5NNgikXILPfD+ivoV+KWdbylEXQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOP7U1ov7t7niVBYhilsXWBJ7sSCB0tYs2y/aOyak6Q=;
 b=QeMnX5i6LmnHEVTYfcjVIRZ7srQHK+B+TmrJq/cl6I3TyQzm3+Yb0wJYx8GBmWIe9C0oCfFiJWQDZeh5nAYE5HZ3ryjWdV1FGvJknWh0BmeyvTNrWNp3K9dxMDfeuy7UWDvgIp+cDxTh/sf22wy85S6+6jzfubo1ppOGkkZvNR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.21; Fri, 20 Sep
 2024 12:59:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 12:59:53 +0000
Message-ID: <c06e3326-54c5-486a-b1d9-10e68af6284a@amd.com>
Date: Fri, 20 Sep 2024 14:59:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] fdtoverlay related changes
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
References: <20240906070808.1045991-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240906070808.1045991-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0047.eurprd09.prod.outlook.com
 (2603:10a6:802:1::36) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB5625:EE_
X-MS-Office365-Filtering-Correlation-Id: 8309bc87-943a-4ce0-8f8e-08dcd9741e4c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXBDaWJ1WjlLVVpOYjZXcnBxQm1LTVdUVjlvTnhnUnduQ2Y1eVNtV1FVbm95?=
 =?utf-8?B?cmREY1ZGUlU0K3gyTWJ0UEdvWUVkcHNIN0grT2pqbDJvWlJXU2U3bGhGM3JW?=
 =?utf-8?B?RWdqZy9JZEJ3NUFKNTRQclhMUjBuMkJTNlExYjBoQ0RIVXdpSVVsN05hdnBS?=
 =?utf-8?B?czI5WjIxZnRYd3Z5akVYeER5bTZrWlpSVzlibFhwa3VBVG1lU3pnQysvNVFI?=
 =?utf-8?B?aXRyU0IvWkQ0U2FvQ01wYmtkQWJtbkxUVUFDL3RWTlU0bmc3UWFxc0g5L0Ri?=
 =?utf-8?B?VmltRnBzNVo3R2FITFZ5bG1MK1ZVU0tIS0hPbEJtMEpJbnR0OS8yeC9nNWNo?=
 =?utf-8?B?ZEhGMHNCM0RBbk5FcU82Y2VUWmMyeDlpRHZ2UGliZzI1L2xhMUtLakVxdjFN?=
 =?utf-8?B?WWR0cjg1amtuOTI1TlF6c2xJV0dnZ1RkLzRxVzk4WjVWb1hSM1hialY0ZTRC?=
 =?utf-8?B?NFV1SVJ0WXpHSG5pRHQvVjFQKzFxdUo3emRPUFVSdDJzN3pIcW5iZDJwYUdo?=
 =?utf-8?B?M2RQdFdmaDdhaENRcjJVUmgxRG1IeEMveVJXVDcxWnNNWHFkN0V4RkV4MlJn?=
 =?utf-8?B?R2lFalFhU1pzK0xZT3pvalJSN0w4UDRvSDNscjBDSnEzQTVyS1crTTI3bHdw?=
 =?utf-8?B?OURZVlg2REVFUEtSaVpoWTNaeXJkemlNdG1ianc2RUxUQ1pLVVE3L3o2QmR0?=
 =?utf-8?B?QkZMVGJ6WDlmVGtBSXp1SVVNbC9vZFpxaW9vVG9PNk1rYm8yRnVId1QwRTNk?=
 =?utf-8?B?czJvb0NSS2RUaG9sZ0xqVy9DNDlXWWhzSEI2a3VjampSNzFYY0NKVE9PRlh5?=
 =?utf-8?B?WHdtVjkzOU41c2QwbGdqbEtEY2c3ai9aOTNhOVhjOWpVdXBXdVVhN1l2c2hH?=
 =?utf-8?B?N1BCM2RWOUFxQkMzV2cvb0VQQXZvbWxDN3RaZWxPMTduSnQzdU5obmdsNGtv?=
 =?utf-8?B?Nmx6bnI0RzZ2SUVUQTRBd21GSG5tZEh3aFZOTDN6ZTlrM3RTa0NiL2szZU9u?=
 =?utf-8?B?b1hQUmFBM2ZweWZsbTBySFBDcTRxRU5nYlNQODFieVc1L244aGJvSCtkYUxL?=
 =?utf-8?B?RFhJUHI0aTh1aGNJK3dNYTlPMkNLTjAzOEFHVzlJOUtuTDMyb1RMQTl5OEUz?=
 =?utf-8?B?dmxJbGVEVFArSnlKZUpuZlB4dnlJZ25kdXFuei83WjFSR2ZMUkM4amp2THpK?=
 =?utf-8?B?QVN0YXl0OXEyRkpMaUhDa3pkaUxEc0pQUTNDRHJoWTBUVmNVUWFJK3ZLQUQ4?=
 =?utf-8?B?bU5JL2NXckYvMEFCaTJhamhNdm9aSE4rYmZYWXVJQ2xUempiV3hrV2tLdkRC?=
 =?utf-8?B?WDJVSEFhL2VKUU11WlJlRStHT01LTHpKdWVLc1dObHRGNDBqN0NlWCtvVlpp?=
 =?utf-8?B?VGVaOG1xVUFHU1pNNThGRSs4N2hyRmU0TmpEODVWUzY3MmVqVmlpWUhhNm5M?=
 =?utf-8?B?dWdFeTBuNURjM3pkM0RWNFFUMHBEZHpGQTRZQk1xcUMyR2VCZnNKWEZzVktw?=
 =?utf-8?B?WXBwU2lSbDZFWnZBaVhtTFFoZThkdTdCKzNXdnl5cnJNMVQ3Ky8yUk0wYUli?=
 =?utf-8?B?MFhZcGhqNmJudnFLVWIvdGl1am5VeGd0ZnllaWJHK3luVlF3d1VOMEJGRXl5?=
 =?utf-8?B?aUlvVExGQUJEcHdhRzZWb0xKT3EycmNMdDE5UE1CdWJEeWllQmduc1VaRmUy?=
 =?utf-8?B?RnA4MkFYTXJnNnNQeGgyQ0cvRmxTRkMvOWg0d2RoSnNxY05ML1dMUjhOd2Z6?=
 =?utf-8?B?MDVrNXdPOVpCVkRQNDBZeW1iNWpaMCtIUUkwNlZJTzk3T3h5d3E0V0xlaEVU?=
 =?utf-8?B?U3p2VUMyMVhONEt1MWl4UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWtsWEJubjFqd0tEN1M2UmNZRkNzMFhKRk96L0FNMHdZTnBRV0h6aWI3NHVE?=
 =?utf-8?B?T2Zrbk42UVNVT3Y5NlhTWjhZb2prY3pPTGZhV1NzbnpYZEtVQVQxWWtOc0h3?=
 =?utf-8?B?Ylova1c5YWJYV1Z5ODIzUkJyQ3k5ay9IR21EbEZFcmF0ZDQrT09ZQ0RCWlhi?=
 =?utf-8?B?TUhLSEljN3hpdC9VdGJoK1FqRGdKNk5tL3VWcUFsL2M3WTZrdjNnbWRhcXhB?=
 =?utf-8?B?MlFPR1JhNmRjS0t4a1BjTnM0M3JEVmJnVFpPUTdpUlJ2MWhKenByM1d2enJr?=
 =?utf-8?B?SC9WT0p5OTY0ZkZjR1BqNGVwZUF3M0Q2Y0hiUmRCMm1HUTQ2bVlRS2NqRkJC?=
 =?utf-8?B?bTByOGFKcXN2TW5zd1RvcnREdmtaWFZqc2t6Z1hvYlk2ekZ6dlNQdjR6Rmhv?=
 =?utf-8?B?ck1TY2VyQ1RDRmh5ODk3eURpaFNORVVDVzdNT2VabE1MNDBGbUlnTUEyZ2hC?=
 =?utf-8?B?VTRadkNMdk4wQlBwTmdLNXBNR0ZiV0tCVGU3QjdNMzNvYjBsZVRuRnV5VTRR?=
 =?utf-8?B?TnFFWmRMU2tFOHM4ZnRMRElUT1VxK2JqdEZralJYZTZ0YXBGMXVKMnZIcTg4?=
 =?utf-8?B?TzE0VFpyaUFaRVZ2TTd0d2taTFJpT3c4d0VsUzc5QUdqTDdSZndRdXIrdytm?=
 =?utf-8?B?d2JrTXdFN2pwSmxRSmFjM2hUV0FjeFduREdLVU93dzZoaXhqSHIzdkVtUE03?=
 =?utf-8?B?YW1MZmxhemdjMFRsdDNhaDJ0d1QwR1BoQ2Qrb01ncWhSOUZSL2gxV0doRWN1?=
 =?utf-8?B?U0xGNUNkVEF1Yk5hTnRRQVBHSHZNMjVDOWJkbVRHSGJ2RzBJaklYVmNZUCtm?=
 =?utf-8?B?QkUrL0JyUjlVR29YVEIyVkp2MFdNV0lUbGNGMTRzQXV0bER1YjNDWVRSZ3hB?=
 =?utf-8?B?T1ZaRzNmSGQreG9SWUZlOEFvMmFmZVJIdTU1ZU1sU2F0dWlMN0FuTkZwSk1D?=
 =?utf-8?B?QnQ1T2tRd0FHbTlGY3ZuNzRnNWZHWXE2bGtrdk1Vck5lNzk2elFZcS85emlh?=
 =?utf-8?B?RzBlOFdaTWdSb1RUdS9KKytRdUNhNDM4YkxtZjlCK1VyREpvLzFyLzdkWVVU?=
 =?utf-8?B?Y3B6a0NmdW91MitxczJya0VyK0JCQVpnT1JsNS9IcjBBWHlTOW81cWlYbEl4?=
 =?utf-8?B?R1JVWCtlV2hyYVRYOGpYQTEyM0NtcmY1WUZldFBxblVPMzlBUHlvUFZRVFZ2?=
 =?utf-8?B?d2V2ZDNNcUUvMFJFSjdpT1VEQytQMy9HRXJxVnd0YmV1OWNoRE1BMzdSdVNC?=
 =?utf-8?B?WlRDQmJML3l2QlpJRHZCRkk3SFRyazB5S1BQOVVBNDBQTWJIQXNmQW4wZ3BL?=
 =?utf-8?B?UXRRSlJMUWlKUzVRcCtGQ0FjSWhrcWN0a0xnOXV0T3o3cjhOZ2NGaGtjWTE4?=
 =?utf-8?B?UVpWcWQxa3RHdkxoUVhTUXRmOGdneUxKLy9FSGJyWi90dzRiQVZrUnhlMDVh?=
 =?utf-8?B?RGNraFI3T3VlK08rMmF1WnRrN0djN0V5cHZiTGVFaFc5bmNXSklxME1lZndj?=
 =?utf-8?B?cnRSUDM3M2FSZkM4eUhSY09vWTJQSzJxVjMwYmhsV1lOWHNDMGxlQkd4Z2Fo?=
 =?utf-8?B?c25JUGhESVF2NTRXaS9wRmVnMW9MU2dVY3R0STlIQlN4ejhOZTMwM3UrcTVJ?=
 =?utf-8?B?RENsVW5TZWduWlY4N1dKV1FMUDRwaFp0OFZjdnl5bkpraVA1MEkzNW80UmFq?=
 =?utf-8?B?WjNWS05ValJZQTJML3N0RWdaYzUrVis1UmthNkhqdjd6TXZWalZIaG5mRXdq?=
 =?utf-8?B?RGtQUWxmV2dSTDFzUWF1V3NBcy90M05ialpraU8yM0Rzc1pmdGNUTTdxMyto?=
 =?utf-8?B?MklXNCtGQ3AxdlBHWTFseDBoUm1peDViZ2FiL2VrRlRab010U08wdXlPR0Mx?=
 =?utf-8?B?aEVBdUtoTnJubG9YNEwrT2hpRE93Yi9uOUN2OHdMSzRXdVV3TktVUVZJSVdZ?=
 =?utf-8?B?MG0yMkNGcWxzVFh6b3lRT1BzNFlKR3Q1U3JRVnlnRkhJMVBFWWpjM0FWY2pU?=
 =?utf-8?B?MEhtV3NpUTZZeHJScUYrdWF3NGdBYUFYQXNzNEFtWVk1Rzg4TUs2bmFhWlFh?=
 =?utf-8?B?T0ZJakxOTmZhcG5pQWh6ejA5RHBMeWFMRWJUQ090cWp3czhXK2dKQ3V3Qklh?=
 =?utf-8?Q?kKzxyEi5EH9ps5ztFA3/lQUH/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8309bc87-943a-4ce0-8f8e-08dcd9741e4c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 12:59:52.9962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mr6UUHSd7ltCApfRKTX/+aH0Ud7D/bFwv0at/gu0YDdXHu7BpZ9ajc1KbC57RAqS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
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



On 9/6/24 09:08, Prasad Kummari wrote:
> Changes in v2:
> - Corrected commit description.
> 
> Prasad Kummari (2):
>    kbuild: cherry-pick kbuild fdtoverlay changes from linux
>    arm64: zynqmp: Remove overlays and add new dtb entries for ZynqMP
> 
>   arch/arm/dts/Makefile  | 78 +++++++++++++++++++++++++++++++++---------
>   scripts/Kbuild.include |  4 +++
>   scripts/Makefile.build |  1 +
>   scripts/Makefile.lib   | 27 +++++++++++++++
>   4 files changed, 93 insertions(+), 17 deletions(-)
> 

Applied.
M
