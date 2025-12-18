Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E11D68BE2
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 06:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C846583C2B;
	Thu, 18 Dec 2025 07:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cZChrCZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622F483C54; Thu, 18 Dec 2025 07:43:25 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E135E83C28
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 07:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrRVzgjyt840u4ejSc8TPmpqPNKK0iYUWW2FQpsjz69h7Y+RrSVnNUa/FGksMhbuBH1RyPOQpXdNH9RTW1+wZ1QcNbE3Q4wgWUzNGcbhDTD0BuyPQ+JTe7j+97WXKjTlu3bVWd79BfDWbY9H9ox8M7vCKc4rCofTtjb3ZV2G62OmTNuwz1cZ22QSoDRwBIbzxo7nARB4t3T2zLkEIWoPRD3nLM6ZVt0OjhbsnRw27xzAS6SRL3vFWEKD3gMFi4T2UzqgDvfc++9NsLT9QyGVpMBNWLkLVoeLshw0dzCIf281TDRB1FUxGKoSuXyBw9ae+HMzf3tIEAXJWgBgSBB1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AH9i5ybeB43RBnkYbpGlTDEFwAwZs5fqc6XTVCIqvGY=;
 b=eAIA3V92Rd8z1LvTEFat1MPOnxagAWHHbi89SOLmQ3JzYSrRO/0R6qWS0DToMSJqaqydI3jdgYTYUsk8Fv8iN663bWD3biYZvbwAKtpyyoSlE3S7LQy6TC7hAsw3M8vlif2M3sIotwgSysk3/zE4xOjfPkkUN2KFKagBvSgaZJDe2O7V1AH0ILQpVEeEx4b0dEJdsENd/IH3Vp+kAnxadGgGXZboG6CXXp4+uYUr3bJLN0LC8SqBL6q+2Ul5HGoYJwJvMcc+clbg7GUX4rG+Xurjkqo+YoP3w6nT0JyXD83i2xAfU1SaT9mp3Bb3bWoWGDWdsA3T2NPtH7zdWG7/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AH9i5ybeB43RBnkYbpGlTDEFwAwZs5fqc6XTVCIqvGY=;
 b=cZChrCZalyFZD0rlNztHgHaf1prOC05wkuXfecz24YukRNcpB2IMN11wHeA2lmcQyo3Sd7YftrdYMqmoQt3FpPM5exMvcwuBbe5udg2SGI7UeiDRapRm/IULUUULcrWfJsqcfiQKZtlO+pEBHwb/yFKSG/O31074jZWvYxB8u/Nx/TK+5CGbsFT0MlhwE463JP7ns5OxW1APJvV8w8kVDj5JAG/m2V8RrU+n7+Bkr6SNrO+m9lhxI5Nv4hgE2u2mo53xr/Reye7HuhMqvedhjYZdO+6u06/MXC73qazzcWvIanBzMp1VJpo4+2NHHKbG7NMOYJ1QcGHpNIqMcMIVLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MN2PR03MB5215.namprd03.prod.outlook.com (2603:10b6:208:1e7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 06:43:20 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 06:43:20 +0000
Message-ID: <a6a96fdc-3208-4c10-b65e-c3bdbe7f9657@altera.com>
Date: Thu, 18 Dec 2025 14:43:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] ddr: socfpga: Add ECC DRAM scrubbing support for
 Gen5/Arria10
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tom Rini <trini@konsulko.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
 <20251216084623.19589-3-alif.zakuan.yuslaimi@altera.com>
 <CAN7C2SCMJ4bK0eQc15zGtn1g9-EOuOucY1z+_AjLwrV6dbY3QQ@mail.gmail.com>
 <bdc886c5-c101-426c-844e-ef5b5eaac120@altera.com>
 <CAN7C2SCdBe_ZqT0U89mcEjQki6viQVcg4-VwT93oBkhFMUYUtw@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SCdBe_ZqT0U89mcEjQki6viQVcg4-VwT93oBkhFMUYUtw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MN2PR03MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 702e986d-ae64-419c-c090-08de3e00bb64
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0w0bGdUM2lydlIwemhDWjIwUUsvQmE0Yk1oK1J2Y0djUmZZZ1FkUXluNGtv?=
 =?utf-8?B?Qm9neWIxMmdaU2k0LzZBcjU1UUg3aGFsNERqS214amw1cWhRRkVWdGg3TGJJ?=
 =?utf-8?B?dE1IQld0SVNjN0tyUjhzYlpzcXZxNHcrd3llNS8vYkhEb2lGUGF3byswbWZT?=
 =?utf-8?B?QnFzZ1JFOTRxOWNjZzhXVlNHaWh0Um1UWGFlOHJLU0hCTTN4Ym85d1NJT1pz?=
 =?utf-8?B?ZnIyWFp4OEs2SnAxaUlmWWhXZFIvL2lHU2hpaFEwbTE0ald4Nlh1N0hOT3F4?=
 =?utf-8?B?aWljV3RQenlzNjFZZE01SVNEd1dzUFVDSnQza0RHQ2xtQTB1SUlmWGFOcncz?=
 =?utf-8?B?eW5MQy80QlQ5VVZKTmpmVDJNNlQzVmdnWk5OakFSWXdKV1hXayt6OFQ0OXFa?=
 =?utf-8?B?TXFHUjkzN1MzYnJrYXl0REo4K094WkZINHZ4RFladlkxYkhTeW1VQmMvcE9k?=
 =?utf-8?B?Z2JGWFd4U3JkOXVvSUFpMWRYaWVkb3Q1T3I1OEs2MHlWRmFjbFNvOHpvRFBF?=
 =?utf-8?B?aGN1RGtwaHpvV1ArOFlKRDdHYjNxeGVIZjFCVkc4anE0WHhtaWFLU28yL21h?=
 =?utf-8?B?SG5yT3lNYVF2UzljdWdPNG1RZmZMLzNaVDlWaUNrRW5iMzYxekIwcXR4M1lY?=
 =?utf-8?B?akFqaFE1NmhNQitZdGY1YmxTTGpxcGxZQ0l2NURvd0VsZk1zc2RCeHROR0N2?=
 =?utf-8?B?NTBEdlhLYk80ZUdLSzBxclh5VHZsN1RTYWxpNmJOVDQ4OWVSMDFGQThxV1FH?=
 =?utf-8?B?VjdXYjc2akJ3WkFqWGhyalc4ME5lYXZlaEw5WVlsL1BjTmFrUWJsVE5hazI3?=
 =?utf-8?B?ZkF5ZlRabCtld1NrV1I2MkVtMTd5OGxSeURacTBQRk1qbFZWYkJZekNTTXAy?=
 =?utf-8?B?aG80U1NZT0dpUEM3RjN2RlR2UWc5ZEFsZGFMNlJ0TkM3Nnhzei8vZUtZZTF2?=
 =?utf-8?B?bWRCRVJHMzRKSXNYSHQyQWlsdVV1OUFZS040aWduT25aUXRWL3FHSnRTb0dG?=
 =?utf-8?B?TE9CNStoZHE3UmU4Wmw0dGRLOFIzK0JOZXRBRXVsZk9GaElMY2dPMTNudllM?=
 =?utf-8?B?bXMwRXgyYVNBOFdqQmxoSTk5LzVyVkkxMHQ5L1JnVUpPREFsZmxOUWY2a0VJ?=
 =?utf-8?B?NDJVclIvbUw0YURhb0QvdzdEUHJpUkRaQ1RuaFJldzlKV3djL0pFMnBWMGov?=
 =?utf-8?B?VkdOZmlUNVREelU1WUY5dDI1RHNtQ3YrK1FOMFNscVY3czhoNXhLbzVMYmpk?=
 =?utf-8?B?a3N2eExEcW93SGFXc1VPaEE4RVQwc3g1d2sxSUNMWHZHNURwbXdNTkF0QXc1?=
 =?utf-8?B?T3VORWlPSXk5bkw3UU5VeXVsc3A3OUQrK2h5RmxpM1NqRXYxRVpqZ1p2M3Np?=
 =?utf-8?B?MXFjUmM5S3l3TFV6ZU45SjRHUHhCSW5RZUJLYzdyeWtLQjhJVFNBaUhYdDh3?=
 =?utf-8?B?SEhBZ05WUHlHcDd1Nk9BTGExQUZiRnFFdUd2T1Q2bGt6bFc4emhWMWNYSnZq?=
 =?utf-8?B?VXZtZEJkMUN5SjFPTU43cmJ1MHdDZE9GTmdmOVZMb1NiaXJPQTltUnpnL3RV?=
 =?utf-8?B?Y3BvSm03MHJMUWU5Q0EwMTAvaFlvSEFpb0NiWWNNd0xRcUhhemtVVEluNGR1?=
 =?utf-8?B?Rm9GUnRqQ1NnaTIzZ05udG9QaTZIbkVlTkdZelVwZThweUwwUy9mNUpoV3V6?=
 =?utf-8?B?Q0Z5ZkxscHJRUmJCOGhlTlVDWi9GSDQxRUM5cFIxS2Nnem5KTktFcWoxOGFS?=
 =?utf-8?B?L0ZPSzhhSTZJZGw4emUwbktQaktSRDE5ZEcvM2hsRWxtU2JibXU4N3hGY3do?=
 =?utf-8?B?V3g4SGF4cWRacWNwQ29yNlU4VHpSa2JaaFdvMG1qcHZ4VnA5L2JmRlNFS1lZ?=
 =?utf-8?B?a3l5aE1KTzZGeXRNMGxjanVUalVZRDBNaUplWW1qcGNXNUxJRy9pUXNzVDQ5?=
 =?utf-8?Q?y8xokEI11ADrY/mQR5lX2sCKNC19Ng1U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVNGMmpQYjloMVBnc1lsaUt3S0lzT1UwaU9iN3ZlTk5wVEk0bWRTWkVZK2Y3?=
 =?utf-8?B?TXdGM1lEUStibXR4WUxiOUNUTkxtZER1SGNyYUlhQnNWT3pIWDFuZXI2YVVN?=
 =?utf-8?B?eXBYWDlaNSsrZUZwaTJHTy9STXd4NXI4dGxkYUZFYk5DM1cvQkpsZEZpZytW?=
 =?utf-8?B?Mmp3alp4TnY0aTNabkNGM21VTHBjWHFwM2svVlk5ekZzdURhUzRwU0pDVUlw?=
 =?utf-8?B?VWs5QUE2VHgyWUhMZ0NPYXB3cVJ6VTJzREhnT3hPVnh2N3loQk40VWMrbTgw?=
 =?utf-8?B?K3RLZWpUd3o0NGtpSStzSnZ6ME5TL2RYNTd6SUpjdDhMbnRGYno2Vkc4UEly?=
 =?utf-8?B?d3VvSnZzeDErSU5qVEQzSnlDL2VjdHBLUk1mZGF5Z2Q2VDk3Q3NWVGxubTBm?=
 =?utf-8?B?M3ZoVUpnZ3ZTdEpRcTNaYkZJRWxkdnE1eTVpSGFLUlFNeWk1Sys3b2t4R0lU?=
 =?utf-8?B?U25jbWhTc1kzU0Q3R1ZsOTNEZjZBdGV6NUpuUmhRZEVVY0VGUFdBMTF6RjNH?=
 =?utf-8?B?VTF5bEd1UzN4ZFFPUkNjSERrUWVReldQNUxOOTlGN2Y0elBXVVprRU11M3U2?=
 =?utf-8?B?cXY5dzJ4MGVaSUE0WmRrMVc2ODR2NTV3cGw2YTZ4ckNSL0U1NXg1L1A1ZUFR?=
 =?utf-8?B?TEJ2OGNkRVhtYzRkaWFiMkxVMWM2Uk1CU1ZKQ3E2NzI2TGFqUERVNzdnd3M4?=
 =?utf-8?B?djNtSlV5b0lTNmNiVjY5SlBxVVZFWm5LeUJadGl1eTVHTUFsN1ZFNEdBOVlv?=
 =?utf-8?B?cmpoOHkwMnZpOUtseFN6Zzd1MEtPd3p4L0cwZnh1Tk9GalkwdnVYTGtQVmdZ?=
 =?utf-8?B?Vm9sbUloSFJTai9OUXJMeUQ4RzhKSG5PL1AzVlZzcUV3WE5GVlNLMm9SOVJt?=
 =?utf-8?B?VlVLSDVXNlBSZFFyWE5taVpxSUYwbTJibURFRXd2MndERDRhWlJjaWZEN3ZS?=
 =?utf-8?B?UDhWQkFJUjJGSzJxMGxHY0l3TVZidXRvUUZrVnNuSUVrZ3FnRG0zTG1rU2Jz?=
 =?utf-8?B?LyttS3E1VW9EZU91MGkyejZ6dmpSM01qYzF6UlZlRlZrNmpkNnFSaUV6SWR1?=
 =?utf-8?B?eThDQ0pIN1pWRjNZMDBnY21jeGtoaFcxY1JsUnhKdXlyK2ZNS0JwckJtVnpH?=
 =?utf-8?B?SU0xT0ZkNkNSQ0Yzc1VWQXRzSUxWcWRhcnhpOW1xZENrbmRqT0NRU096aUVt?=
 =?utf-8?B?YUNybmlSOUJRNmJLT1drOERKNURiVmEvR0RTVm12SVRpbmZDeGZENHRNSjhq?=
 =?utf-8?B?VWRsQ2htV0Y5S3ZWQUtnbStTaVJzSkswZm9lUGZHbi9qVjA5MjhlVWJyZ2Ix?=
 =?utf-8?B?ZDFLWjdLaWMvR1dRenl3QXVvRlNhMVVpTS9SUWZvdEdERWp6b3h2ZVZjTktR?=
 =?utf-8?B?cTl1T3F0Y1dUaTltSnZTZ2xFY2ZyY0NubkJCMTBXVStzWm44b21iVnZWcThL?=
 =?utf-8?B?SVQ5MmhTZnpLZFk1d2R1aHdzOXBFUU5Yd253V3I2VVpRSlk0cEo0a082emJD?=
 =?utf-8?B?V2ZoRXBOVml3VDVpWmZpdWpzeHZ4WmFxTWpLZGZvOTBNZHNkOHFIR0hhZFNQ?=
 =?utf-8?B?c2VjcUtrbkF0TXkxTzNyVGpMYmRqWitzajJjN0xlbGRDSHNpNzhzUHNla00y?=
 =?utf-8?B?YVBhSkJsd1UvZ3RWc2xxeWMyWjRsdDVJSGVvN0pqT2FORzYvd0IrUXU5dFNm?=
 =?utf-8?B?RkxQNEpseFlXMnM3VzNRTmNOeUxxWkEzOW9LSVhobkt5ek9NR0I4VG5jV0xq?=
 =?utf-8?B?a2luVVdPeGJPdU5KRC9MNHpMS0szVmdhVmMxdVg5b0pnQ09EV1VNWXN6VWow?=
 =?utf-8?B?eVVuUUNpcXpERE13NG94RE9BejlScHJ2YjVzai85dXl4NW5ZTWIyT1RZSnNh?=
 =?utf-8?B?M3BQV2FnYVZOWkljelJiV1lCRmxBd0NJOWp1elpnWVlmbjlHWTVqRzBaT0ZD?=
 =?utf-8?B?RjFEVmdBSDZoRS8yV1dhZ2x2d2N5S005QVI5WmNkYzVSUWVSYngydFpQRzcw?=
 =?utf-8?B?emF4OTI1SkdzQzdQRmRMam9RN0J5dVZGZEIxUGtkWU54MEcxeFViRmdkWVlJ?=
 =?utf-8?B?cTRERGcyWEZxVXlBK2NXSDdnOGVMejlJWE1KTUhTMzhjbVdWQXlyUkJpYk5v?=
 =?utf-8?B?SG5pNm1oMk1SZkoxNi9TVUpNNFExcm5IYXZwZEtpMHE2cDJNcXJ4UzNSRGcr?=
 =?utf-8?B?THZ4UFprcXRZczRTZ3JPMWJzNjFsYTlLOFFtK0JJZTE3VEFRTVlZSmwzRmhT?=
 =?utf-8?B?a09icWQwK3RSS2ZrdmFWMlAwTFJFRkZjN043NnRNRktHWDFUV3pFOFdMdW1k?=
 =?utf-8?B?SlBQdGFuMXpRVTFiTTJtazRwQUJseDNyVEFSRGVIUTlVbjNuV2I0ZlVFUXZY?=
 =?utf-8?Q?sNLdkWJPI6vymsCs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 702e986d-ae64-419c-c090-08de3e00bb64
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 06:43:20.1712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+KjG38PlvAn8JV9IBC+Mc+0Fw5ek5AHRRn2/2rCeg3ZQw5A5CoaNHcEX3C5IzCP9kyQtv5uY3+4ng+cXGuLY1TeuoXImPQqgml1BzskdTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5215
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

On 17/12/2025 3:50 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Hi Alif,
> 
> On Wed, Dec 17, 2025 at 3:27 PM Yuslaimi, Alif Zakuan
> <alif.zakuan.yuslaimi@altera.com> wrote:
>>
>> Hi Brian,
>>
>> On 16/12/2025 5:46 pm, Sune Brian wrote:
>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>
>>> Hi Alif,
>>>
>>> I have a question on sdram_arria10.c
>>> Why spl_gen5.c requires:
>>> static struct bd_info bdata __attribute__ ((section(".data")));
>>> with gd->bd = &bdata;
>>> But on arria10 this is not required, it is done on another file?
>>>
>>> Thank you,
>>> Brian
>>>
>>
>> I found that removing these will cause failure to boot U-Boot SPL after
>> trying to reboot from Linux, SPL will keep on looping during DDR
>> initialization.
>>
>> This could be because of the missing board info in the memory, leading
>> to a failed initialization as gd->bd is not set up properly after a warm
>> reset.
>>
>> SPL runs from the small OCRAM before DRAM is available. CycloneV has a
>> much more limited OCRAM space compared to Arria10.
> 
> I am referring to the A10 case here. Maybe you confused my previous question.
> Why I am asking this question is because both A10 and GEN5 aka C5 use
> the same soc32.c. Hence, the ECC will require the gd->bd-> to be defined
> in order for .size or .start etc to be used.
> 
> +       start_addr = gd->bd->bi_dram[0].start;
> +       size = gd->bd->bi_dram[0].size;
> 
> So your dynamic means it is well set up before the ECC init uses those
> variables?
> As I am not finding, gd->bd is not set in the a10_spl.c at least not
> really distinct as "="
> 
> Thanks,
> Brian
> 

Yes, just like you have mentioned, both Arria10 and Gen5 require gd->bd 
to be defined before ECC scrubbing in sdram_soc32.c.

However, unlike Gen5, Arria10 is able to leverage common SPL’s 
(common/spl/spl.c) generic fallback function - spl_set_bd(), thanks to 
the larger OCRAM which allows more flexibility for SPL to use U-Boot’s 
generic memory allocation and initialization mechanisms.

Thanks,
Alif

>>
>> Due to this memory space limitation, there is no dynamic memory
>> allocation in Gen5 SPL, therefore bd_info must be allocated statically.
>>
>> By declaring bd_info as static and placing it in .data section, we can
>> minimize Gen5 SPL OCRAM usage, as well as making the SPL execution much
>> more simpler and robust.
>>
>> Thanks,
>> Alif
>>
>>> On Tue, Dec 16, 2025 at 4:46 PM <alif.zakuan.yuslaimi@altera.com> wrote:
>>>>
>>>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>>
>>>> The SDRAM must first be rewritten by zeroes if ECC is used to initialize
>>>> the ECC metadata. Make the CPU overwrite the DRAM with zeroes in such a
>>>> case.
>>>>
>>>> This scrubbing implementation turns the caches on temporarily,
>>>> then overwrites the whole RAM with zeroes, flushes the caches and turns
>>>> them off again. This provides satisfactory performance.
>>>>
>>>> Move common code sdram_init_ecc_bits() to new common file sdram_soc32.c.
>>>> Preparation for Gen5 uses the same memory initialization function as
>>>> Arria10.
>>>>
>>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>>> ---
>>>>    arch/arm/mach-socfpga/spl_gen5.c   |  4 ++
>>>>    drivers/ddr/altera/Makefile        |  4 +-
>>>>    drivers/ddr/altera/sdram_arria10.c | 25 +++-------
>>>>    drivers/ddr/altera/sdram_gen5.c    | 18 ++++++++
>>>>    drivers/ddr/altera/sdram_soc32.c   | 74 ++++++++++++++++++++++++++++++
>>>>    drivers/ddr/altera/sdram_soc32.h   | 11 +++++
>>>>    6 files changed, 115 insertions(+), 21 deletions(-)
>>>>    create mode 100644 drivers/ddr/altera/sdram_soc32.c
>>>>    create mode 100644 drivers/ddr/altera/sdram_soc32.h
>>>>
>>>> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
>>>> index df79cfe0f7f..5c78a4c1fea 100644
>>>> --- a/arch/arm/mach-socfpga/spl_gen5.c
>>>> +++ b/arch/arm/mach-socfpga/spl_gen5.c
>>>> @@ -27,6 +27,8 @@
>>>>
>>>>    DECLARE_GLOBAL_DATA_PTR;
>>>>
>>>> +static struct bd_info bdata __attribute__ ((section(".data")));
>>>> +
>>>>    u32 spl_boot_device(void)
>>>>    {
>>>>           const u32 bsel = readl(socfpga_get_sysmgr_addr() +
>>>> @@ -146,6 +148,8 @@ void board_init_f(ulong dummy)
>>>>           /* enable console uart printing */
>>>>           preloader_console_init();
>>>>
>>>> +       gd->bd = &bdata;
>>>> +
>>>>           ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>>>>           if (ret) {
>>>>                   debug("DRAM init failed: %d\n", ret);
>>>> diff --git a/drivers/ddr/altera/Makefile b/drivers/ddr/altera/Makefile
>>>> index 7ed43965be5..b9e3302d714 100644
>>>> --- a/drivers/ddr/altera/Makefile
>>>> +++ b/drivers/ddr/altera/Makefile
>>>> @@ -7,8 +7,8 @@
>>>>    # Copyright (C) 2014-2025 Altera Corporation <www.altera.com>
>>>>
>>>>    ifdef CONFIG_$(PHASE_)ALTERA_SDRAM
>>>> -obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_gen5.o sequencer.o
>>>> -obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_arria10.o
>>>> +obj-$(CONFIG_TARGET_SOCFPGA_GEN5) += sdram_soc32.o sdram_gen5.o sequencer.o
>>>> +obj-$(CONFIG_TARGET_SOCFPGA_ARRIA10) += sdram_soc32.o sdram_arria10.o
>>>>    obj-$(CONFIG_TARGET_SOCFPGA_STRATIX10) += sdram_soc64.o sdram_s10.o
>>>>    obj-$(CONFIG_TARGET_SOCFPGA_AGILEX) += sdram_soc64.o sdram_agilex.o
>>>>    obj-$(CONFIG_TARGET_SOCFPGA_N5X) += sdram_soc64.o sdram_n5x.o
>>>> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
>>>> index d3305a6c82d..0e3a1d42f34 100644
>>>> --- a/drivers/ddr/altera/sdram_arria10.c
>>>> +++ b/drivers/ddr/altera/sdram_arria10.c
>>>> @@ -21,9 +21,14 @@
>>>>    #include <linux/bitops.h>
>>>>    #include <linux/delay.h>
>>>>    #include <linux/kernel.h>
>>>> +#include <linux/sizes.h>
>>>> +
>>>> +#include "sdram_soc32.h"
>>>>
>>>>    DECLARE_GLOBAL_DATA_PTR;
>>>>
>>>> +#define PGTABLE_OFF    0x4000
>>>> +
>>>>    static void sdram_mmr_init(void);
>>>>    static u64 sdram_size_calc(void);
>>>>
>>>> @@ -192,24 +197,6 @@ static int sdram_is_ecc_enabled(void)
>>>>                     ALT_ECC_HMC_OCP_ECCCTL_ECC_EN_SET_MSK);
>>>>    }
>>>>
>>>> -/* Initialize SDRAM ECC bits to avoid false DBE */
>>>> -static void sdram_init_ecc_bits(u32 size)
>>>> -{
>>>> -       icache_enable();
>>>> -
>>>> -       memset(0, 0, 0x8000);
>>>> -       gd->arch.tlb_addr = 0x4000;
>>>> -       gd->arch.tlb_size = PGTABLE_SIZE;
>>>> -
>>>> -       dcache_enable();
>>>> -
>>>> -       printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
>>>> -       memset((void *)0x8000, 0, size - 0x8000);
>>>> -       flush_dcache_all();
>>>> -       printf("DDRCAL: Scrubbing ECC RAM done.\n");
>>>> -       dcache_disable();
>>>> -}
>>>> -
>>>>    /* Function to startup the SDRAM*/
>>>>    static int sdram_startup(void)
>>>>    {
>>>> @@ -706,7 +693,7 @@ int ddr_calibration_sequence(void)
>>>>                   puts("FW: Error Configuring Firewall\n");
>>>>
>>>>           if (sdram_is_ecc_enabled())
>>>> -               sdram_init_ecc_bits(gd->ram_size);
>>>> +               sdram_init_ecc_bits();
>>>>
>>>>           return 0;
>>>>    }
>>>> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
>>>> index 3c79bb11802..7a0a043557b 100644
>>>> --- a/drivers/ddr/altera/sdram_gen5.c
>>>> +++ b/drivers/ddr/altera/sdram_gen5.c
>>>> @@ -2,6 +2,7 @@
>>>>    /*
>>>>     * Copyright Altera Corporation (C) 2014-2015
>>>>     */
>>>> +#include <cpu_func.h>
>>>>    #include <dm.h>
>>>>    #include <errno.h>
>>>>    #include <div64.h>
>>>> @@ -17,8 +18,12 @@
>>>>    #include <asm/bitops.h>
>>>>    #include <asm/io.h>
>>>>    #include <dm/device_compat.h>
>>>> +#include <linux/sizes.h>
>>>>
>>>>    #include "sequencer.h"
>>>> +#include "sdram_soc32.h"
>>>> +
>>>> +#define PGTABLE_OFF    0x4000
>>>>
>>>>    #ifdef CONFIG_XPL_BUILD
>>>>
>>>> @@ -562,6 +567,12 @@ static unsigned long sdram_calculate_size(struct socfpga_sdr_ctrl *sdr_ctrl)
>>>>           return temp;
>>>>    }
>>>>
>>>> +static int sdram_is_ecc_enabled(struct socfpga_sdr_ctrl *sdr_ctrl)
>>>> +{
>>>> +       return !!(readl(&sdr_ctrl->ctrl_cfg) &
>>>> +                 SDR_CTRLGRP_CTRLCFG_ECCEN_MASK);
>>>> +}
>>>> +
>>>>    static int altera_gen5_sdram_of_to_plat(struct udevice *dev)
>>>>    {
>>>>           struct altera_gen5_sdram_plat *plat = dev_get_plat(dev);
>>>> @@ -604,6 +615,13 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>>>>           sdram_size = sdram_calculate_size(sdr_ctrl);
>>>>           debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>>>>
>>>> +       if (sdram_is_ecc_enabled(sdr_ctrl)) {
>>>> +               /* Must set USEECCASDATA to 0 if ECC is enabled */
>>>> +               clrbits_le32(&sdr_ctrl->static_cfg,
>>>> +                            SDR_CTRLGRP_STATICCFG_USEECCASDATA_MASK);
>>>> +               sdram_init_ecc_bits();
>>>> +       }
>>>> +
>>>>           /* Sanity check ensure correct SDRAM size specified */
>>>>           if (get_ram_size(0, sdram_size) != sdram_size) {
>>>>                   puts("SDRAM size check failed!\n");
>>>> diff --git a/drivers/ddr/altera/sdram_soc32.c b/drivers/ddr/altera/sdram_soc32.c
>>>> new file mode 100644
>>>> index 00000000000..b8b42ef8e03
>>>> --- /dev/null
>>>> +++ b/drivers/ddr/altera/sdram_soc32.c
>>>> @@ -0,0 +1,74 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>>>> + */
>>>> +
>>>> +#include "sdram_soc32.h"
>>>> +#include <string.h>
>>>> +#include <linux/sizes.h>
>>>> +#include <cpu_func.h>
>>>> +#include <watchdog.h>
>>>> +#include <wait_bit.h>
>>>> +#include <asm/global_data.h>
>>>> +#include <asm/system.h>
>>>> +#if !defined(CONFIG_HW_WATCHDOG)
>>>> +#include <asm/arch/reset_manager.h>
>>>> +#endif
>>>> +
>>>> +DECLARE_GLOBAL_DATA_PTR;
>>>> +
>>>> +#define PGTABLE_OFF    0x4000
>>>> +
>>>> +/* Initialize SDRAM ECC bits to avoid false DBE */
>>>> +void sdram_init_ecc_bits(void)
>>>> +{
>>>> +       u32 start;
>>>> +       phys_addr_t start_addr;
>>>> +       phys_size_t size, size_init;
>>>> +
>>>> +       start = get_timer(0);
>>>> +
>>>> +       start_addr = gd->bd->bi_dram[0].start;
>>>> +       size = gd->bd->bi_dram[0].size;
>>>> +
>>>> +       printf("DDRCAL: Scrubbing ECC RAM (%ld MiB).\n", size >> 20);
>>>> +
>>>> +       memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
>>>> +       gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
>>>> +       gd->arch.tlb_size = PGTABLE_SIZE;
>>>> +       start_addr += PGTABLE_SIZE + PGTABLE_OFF;
>>>> +       size -= PGTABLE_OFF + PGTABLE_SIZE;
>>>> +
>>>> +       dcache_enable();
>>>> +
>>>> +       while (size > 0) {
>>>> +               size_init = min((phys_addr_t)SZ_1G, (phys_addr_t)size);
>>>> +               memset((void *)start_addr, 0, size_init);
>>>> +               size -= size_init;
>>>> +               start_addr += size_init;
>>>> +
>>>> +#ifdef CONFIG_HW_WATCHDOG
>>>> +               /*
>>>> +                * In case the watchdog is enabled, make sure to
>>>> +                * (re-)configure watchdog so that the defined timeout is
>>>> +                * valid.
>>>> +                */
>>>> +               debug("%s: %d\n", __func__, __LINE__);
>>>> +               hw_watchdog_init();
>>>> +#else
>>>> +               /*
>>>> +                * If the HW watchdog is NOT enabled, make sure it is not
>>>> +                * running, because it is enabled in the preloader and
>>>> +                * causing boot loop if is not handled.
>>>> +                */
>>>> +               debug("%s: %d\n", __func__, __LINE__);
>>>> +               socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
>>>> +               socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
>>>> +#endif
>>>> +       }
>>>> +
>>>> +       dcache_disable();
>>>> +
>>>> +       printf("DDRCAL: SDRAM-ECC initialized success with %d ms\n",
>>>> +              (u32)get_timer(start));
>>>> +}
>>>> diff --git a/drivers/ddr/altera/sdram_soc32.h b/drivers/ddr/altera/sdram_soc32.h
>>>> new file mode 100644
>>>> index 00000000000..85a951a5a74
>>>> --- /dev/null
>>>> +++ b/drivers/ddr/altera/sdram_soc32.h
>>>> @@ -0,0 +1,11 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>>>> + */
>>>> +
>>>> +#ifndef        _SDRAM_SOC32_H_
>>>> +#define        _SDRAM_SOC32_H_
>>>> +
>>>> +void sdram_init_ecc_bits(void);
>>>> +
>>>> +#endif /* _SDRAM_SOC32_H_ */
>>>> --
>>>> 2.43.7
>>>>
>>

