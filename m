Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E30EF99FD
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 04:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB8BA83AAB;
	Sat, 14 Feb 2026 05:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PkYoCcCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCBB683CF2; Sat, 14 Feb 2026 05:52:41 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6B783642
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 05:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MaUpIgSuqz4lZStCNYwO8sOJiLUTUlRFo8yuuuHvGkraLNic7p1rXhMcaaqgdbctGdsMjN/CUMhdqiBBSyfBCgPCzeTPFcgi6C6UjVCgghNGbru66XVwXlQrt/Vi6Ihu4Ma76n+Jic8HZ67L16vgXI5aJRuKFG421U3fFJTWXLWZ/PiYYAGRKUeSVPr0h+1OhidMkuqL8q4K+4lp6Ji6+OHaGuN6GwizTXqqyTyi+YSPWb7M1kccyQJioUd+/7wCRMRZkdbkNqUDMiWFMK4m1b1uaZ62EEK464VVYCmDaanTNa9OgMlPluOIk8dNDQ2CgZS7T68dvJTWgIHmllCsHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihjwiye3e4QDuxaOSSsehExasg8AwW3OoKj2ElCCTZg=;
 b=uljbK09j3IIzHVODb1EeR3tnQE8JQlqb4Kjdaqk1DNhgH4Q2sLorCsvWM0KWPLRkI9BEtp2D3C22p882hZBzy0ljbu7K9KZU28fI7Ajomq8csaZ+D7DK0o35NDdghmoZc7rwJgis5x80A8ob38dZOVSG8y6mdxz800Idp9lR7dPk+gb6y8l/Aw1cYsRDDiosCnwrP1/8OhuQ1XVkjWG3gXlhbHjYv1EY1fUFg8F8xCygSeomoE9E4+xsfcaaMh9EanjC9zSgfBZpPHpnf56G7zzUwZXgrG96DyzBOkKyoJg8+8cViBEXKkbsfU8RlNXmfzilEMyQBfYD3JA4+sVWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihjwiye3e4QDuxaOSSsehExasg8AwW3OoKj2ElCCTZg=;
 b=PkYoCcCGGp03idEeQnWZ9FTA8eIRzE8H5nKmi2JI7WlFN2nJD9P0tzTUS/hx2H3vxsV/5r/tbdOS7hL1IvfRp4V/9Jla9ckxFWPrujka+MqdD3NZ69WXYLdiiAQkXLLfWhQhUvI5IS3WM01ITGd5eF8ML0lC3VRXaYsSOh939X1Q6H3mzCUH+YTFK2rmK4/z/7H7vVuUDwv1PWU4lROk1gZ9rXnl+MabeBPk90XOnj6Fx7inypVVJRmmX695GP0K+XZpd3p2FlT6YYfF0oQd4zc95w8Rb0bNJ98ViJ5HIEXX1CWIJqP74oGgSo9Nt6IKLMSMAdSqsq1qORKBYi8+TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA6PR03MB7829.namprd03.prod.outlook.com (2603:10b6:806:42d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Sat, 14 Feb
 2026 04:52:36 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%3]) with mapi id 15.20.9611.012; Sat, 14 Feb 2026
 04:52:36 +0000
Message-ID: <c5129f8f-5970-44eb-8bda-a6577bde41bd@altera.com>
Date: Sat, 14 Feb 2026 12:52:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] SoCFPGA: Update DDR Support for Gen5/Arria10 in
 U-Boot
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>
References: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA6PR03MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c58692-e889-4cca-0cf0-08de6b84decf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|13003099007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2VRRDhKcHZaUDhNNUZzNjRPNE0rdEpjK1g3T3JaeFZVbFNyVXluSGM1RTho?=
 =?utf-8?B?Z1BNRUdPMEZSd3RQSG9iNGUyNndtUmNxMmQ2SXl4eUovcHRGbUR4TXVQRlFr?=
 =?utf-8?B?KzVaeEZUelE5MDIwbXZDSjBkNHhuZUM1UzIxRnlNMEFoNXZIV1VMb3pKOTZR?=
 =?utf-8?B?b3hwSTdXa21WY1c3aHljMGtDTjNvSk1TdXU0cHAyUThEVEhieUxZUHNKOUR4?=
 =?utf-8?B?TlJFbCs5L1FQL05PSTRoekRGbnZLcExBL2pGYmkwWGtJcnIzWkd5bWtrQXlu?=
 =?utf-8?B?YUtQaUlVaThLbkhTWEwzcU9FZElFeEtYUTlKQnNZeWNVTnpyNThXdEg3ckJz?=
 =?utf-8?B?NW5xcUZCVUI4RjhWWkVEbFl4RVZ0YVRMZDR5NkNBaHVzbWt6dVo4NkRpemhW?=
 =?utf-8?B?VS9ZMit4ekJCOGZpbGxYMFBIdFYxWW03MmVmb1d6MGdNMEtIeHhWSmlYUlRZ?=
 =?utf-8?B?czJ5QSt3ZUU3SElvNGV4cjdUUjdVYXhudytKUndaY2tRZ3hWR29DdWlhZTF5?=
 =?utf-8?B?SzdLeTJxUmlORzhRUy9SUkM4NmRSWkRSaXdDK0pHZ0lvZ1hUODBKMG1OV1FY?=
 =?utf-8?B?M1J1OHhxa3BqL1owZHo4cnNQRjQwRGZ6TWpCSkF1SDVCejZoeFdPUVI1OWRS?=
 =?utf-8?B?T2kyZDlLRnpkemF4c1NPbDNZZVc3MHlZdStTNkdIRXdla1RwT2JlQ0VUM0JQ?=
 =?utf-8?B?U3BhNjMrY2JCUS9KYk9temt5UDhvbGRyRFhNRUJ1djMzeExMeEVTUWZiSzE1?=
 =?utf-8?B?Y2tDM3pJKzRjaXkvR3haQTVURjRmUTl5RW1aU2YyUGJpUXBuOUkxTURMYkUx?=
 =?utf-8?B?Q0FXZDIybkJpcTZCMnRvYWJvNTNhTGVkNXprWUFqbm91blRtTlQxWVR2NGJS?=
 =?utf-8?B?dXQreXBnN3VVZ1o3ZVNQNWdpcTFtR3VpR1pZN0MvTUNKV3BqMUxZMEt1WVU0?=
 =?utf-8?B?L05NTENqcVduT2VNVTZieUpnMEtCbXJmUk5vUzljRjUzbVdHMFl4QnZjQXJL?=
 =?utf-8?B?dk5zMGMyNUxXd2NSdjhQSGhSamJUUm9XS2pmbGF0OTN0S0NDRmJvRGxDWU1H?=
 =?utf-8?B?MXZ0eDlJeVFlclVzWVMzTFNSZDRSL3JKUWg0aVZObjljbHF1ODRxamQ0di8v?=
 =?utf-8?B?eWZKTXBQeVcydmF4L3dqOHNRTUMxUjRjZnRaWlhVa1pxcXRFcTViWlFwYm40?=
 =?utf-8?B?YXIzb2taNjgraGY3dXlIZkIwUi9Jbk43cVprb0NWK1hjcnFjVUtSY0lNSjRG?=
 =?utf-8?B?UFJnQTVubmlkblRadmVUVzJJZDEvZTdNT1NKSWpJbUJqZStCekNSU3BaRTcw?=
 =?utf-8?B?SGxOdkl2Q1l5S1ZuM1lQWW1RaXBxNU4wS2pTeWd4bWE0RDFiZHdTQitOQ3l0?=
 =?utf-8?B?Y1RtMi9QYjRUNkl1VGM2YVE2NkMxeWpOMmJ3cW9rb1JJUElTVERBaWZRVzNx?=
 =?utf-8?B?RVJ6K3IwTSthZVFMR3B0SWNXV1BseE40bHhuRlVtTndHWWM3UmtkNkpMd0Z4?=
 =?utf-8?B?MW5Tc3RZSjg0dmt6MGZXY21VbTc3OUpuTkZoNXA1eTdHK2tQYmFiTDJaa2lw?=
 =?utf-8?B?M0R5dHVUc3g0OVV5ZVA0NzMrN0EwMkRTcjNWd0YrQkcwU3Zic094L2prb2pm?=
 =?utf-8?B?RFhZT0tjU2ZLaDNwVStxMmhUUWQ2MUo3KzRreTRVLytGOVNKZEJDclNHZ3N4?=
 =?utf-8?B?VHlpM0VSWjE1YzJKOUdWcGJ4MkNzMlFzMXNXK2t3Umw0NktWSS9HWVQrKzRO?=
 =?utf-8?B?ekFYdkdnREFEQ0hLTEY5YkJDTzlHR0pSbEZTV0l6enVvNllCMFpuNjM4Nk9P?=
 =?utf-8?B?b2NzQXVadDJRdmlCZnVwUCtuMXU1L3RZWDBQMFdkb21PZTcrK2FVdW1uU01o?=
 =?utf-8?B?WU5WdStHRzJjNFE0MFhwU29PcHNQMndYeHhQM1I0ZXZPQi9LQk1BaG1hd3Vy?=
 =?utf-8?B?NWJodDU3eGFTOEJEdkJiSzFXakxleVFpcmdBLzFlMHUyNUVzby9VUEdXV0da?=
 =?utf-8?B?UzBkZnVzNmFuOVVtbTBpK1pFVHFLbU1Ga2xkZVlyUFoxTzVDNTJGeWZPNzVV?=
 =?utf-8?B?RzhUMlJPRVNwVkVEbzBFZ0tPaFpEZ3BvdlJtR1c1ME5LNjh1RlBTQ0FmbHBF?=
 =?utf-8?Q?9RB8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpId2p1c0JsY1lZc2YzR2NaNmtYVVMrS0Fjc1ZqT0N2UFJ4T05mdkoyZi9u?=
 =?utf-8?B?K3ROekFIQUNvQU0rQzJTL2V3bjU1biszdXhUWUVGUmpwTWQ3WFc2WUFmKzh6?=
 =?utf-8?B?Y1NFekJiNFFkWk9ZdTlIOFRadnJqMXJFWE92ZGJ4M21kOFpIMmh1d1lGeHhU?=
 =?utf-8?B?N3NhdWdMVUJRVjlpMm5iUHYwZnVIU3BMTm5WM2h4QVh3T3ppYmZvZTRVSzNI?=
 =?utf-8?B?K2hmL3BHbk9mdXRXaE9MQnVJNWZkMlgwdU5OV0JzaDlESHZ2aWZqckJ2enJj?=
 =?utf-8?B?Q05mWFo1SWNpNWllcXMrejFKOHBsQjVrZjhDS092eE5TTk45M1p3YTZKcVY4?=
 =?utf-8?B?UEhzTDgwbFM0akFyaGQ1ZXg1Nk0reEZabVlNQ2xpZXpvT2poUmNBZ2F1NXI0?=
 =?utf-8?B?UXQ4aWkwTU03Qnk2bi9UY3ZiYTc0YjBLVlBuMFpWL2FteEhVWEhtVUhnd3RI?=
 =?utf-8?B?WXVaTlJZY2xYUWhmUHorRXd0aUNxRzIveGx4OVNLR0FaTWFHSEhPc0dycFBS?=
 =?utf-8?B?elhRS3RrOVJaK3JCQmhzN2hMdlpjZGc1clRCelJsTS9TY2crVXAzMUtBanR6?=
 =?utf-8?B?c1FvNzNhQzlhRWlWd25nOUx6eFhjRllDZm42SW9QZVRPcm9zckVQVjlpYmF1?=
 =?utf-8?B?MkdEcFlDQlh1Vm9iMlNpSjBKNTZpMFNpcjhoV0YwNGpkZWNjSTY0ekMwTjJK?=
 =?utf-8?B?NUZIKzNLWkhRdWJtcU02bHkvazlBSjRROGhlYWliNkwwTlVzU0xzQkVqYm9Z?=
 =?utf-8?B?Mng1cnRBd3Brc083V2JGV00rY3pkZU91dU1wYVZMVFNmZTBrWld2WXpYdDBB?=
 =?utf-8?B?dXpBeUpzNTRBbXhkdVhGSXQ3c3Q4TFRMLzJQQWZ4cGI2ZUlpVWU5VkNveDQw?=
 =?utf-8?B?V3k0RUxnRC9tVXltY2QwMURwd1puWk5HT3NYMTgrSUtEYlBENXQrNHgwa1FX?=
 =?utf-8?B?V0MwdmZpaGJIMlJSeWtXb2NSRjMrSE0vL2laYmFva1U1NWkvVXFuQm5PS1pC?=
 =?utf-8?B?Ti9raWFnSlZjcTdLL252N1dubFhFMWMwRDJiU2Q0WlVkNDhBQWRITjJZUzZ4?=
 =?utf-8?B?N1VrUG5ad0lFR1Bkc3I0SHFGZ1ZRWUwxY3Y0STZRdFg4K0JOU3BOZk5wWWRR?=
 =?utf-8?B?ZU1GeWgycUgyTlRSSk1jUm8yeFlHV2d0NWVyQ3Nxc2lOMU9XMXdRd01vUlVi?=
 =?utf-8?B?VzlCMmlQVmp1a2ZIUEZiYTRIWGZrZWpYS0FjYXZxUEl2MXV4M21kOVdjSGZv?=
 =?utf-8?B?bm5QYkxMWmtGbExRY21EeEp1NXFPek00Tkg0Rzdndmlhb1UyQm5FSlBaSkww?=
 =?utf-8?B?L1kybjRBemVyemxQTEZBWi9OUVdQYm5sODZMUmk1Z3h6WjNzTVZLeFpVL3VJ?=
 =?utf-8?B?VEdhOVg1WlAxM3hhSVlKclJUMkxaVlE0eml3Y25kcG5IRFdDZUtWSWlsdHJo?=
 =?utf-8?B?ZnBNQlNSQWJFYjhpd1ZWQ2gzblFCa0luc3p0eHB6UmtRVW1iRGt0cGt6RTMx?=
 =?utf-8?B?Q1kyZTdBdWJPMmcrNjQ0ZlZpNURlS1dxMmd1b1FHRFFoWklFSHBlSXM5RVBU?=
 =?utf-8?B?YlpkMG5aY29PV2lXaFdGM0t2b3g2b2xyMU5hekhrRStjYmsrc0k2R3VFME1l?=
 =?utf-8?B?WUlvNlVkdHBKaWp0aDBUZ2hPZll6a0R5dnordWNsdWoxUXYwWXQ0Z1FrVTFY?=
 =?utf-8?B?LzdoYTZnQjRBNzVqdDNnazA5SEVINHpSK0UyMERSY25HbzJrM0JybVVwWWhK?=
 =?utf-8?B?NS9kWHZJMXQ1Wi9tcUQrQnk2T0hGOEtLeEVYWUtWY1gxOFhyRlkxV3NXMkFX?=
 =?utf-8?B?Y0NjeWhZbVUyZE02dTd0V2kreGcvVjhFWncweXg5SzlDUHYrRkpvbDJhOWR0?=
 =?utf-8?B?eUVkMU1ERjBoK1VkdFVIV0gzQnVqTzFMOTM2bVNXVEdyeEZlMkRHeVdQanoy?=
 =?utf-8?B?d2VCd082alBWZ2ZPYkhvbXZ6MDNZU1ZpVzhaTzVnTVBBQ2dpUXdzTWhvbGhh?=
 =?utf-8?B?ZHQwc3hDYlhaK3hVcWlmb1drZmk3cHIxdHZRd3ZCazFaMzZvd2p5SmpnQWt4?=
 =?utf-8?B?UWZycC9CdTEvcTNoRjZXcXpyQ0xsMXFOT1hBM0l0UElvVmNnZUJ1K1RxTlUz?=
 =?utf-8?B?eWRqMXROR3RWQnpBVFphT1lwU2R2a1NpSFNiS3BQSUhKT3lsa1ExMG1jUVRh?=
 =?utf-8?B?YUMyaWFxSStTaVZlaDlIR0g0c3N4dTVWZnowSVUzWm80SE5Md2hRMUFrVDRN?=
 =?utf-8?B?dE5zRnRmZWZMVzd1bk5LT2U4NW0zdGNQdVNITEtpY00rRzFFZ2J1MTdZa1RI?=
 =?utf-8?B?S20xUjJwVUNHcGhubUFRYnRrQ0xTUStBY3pNc2tpdGdjMlhYMmVueXg2Vkgz?=
 =?utf-8?Q?44m3aRs0kDyKymCM=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c58692-e889-4cca-0cf0-08de6b84decf
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 04:52:36.1052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QcCgWD0hfR7tBXPtMQZQ9w6kwh/v8q0Ki2FbwVVdguy7FAC5OQFF+1mm2TRdA4vO1KRsI2fCKyUCqX8Ble+0mnXsUqLcWCFomCl5M9lphc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7829
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Alif,

On 16/12/2025 4:46 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi<alif.zakuan.yuslaimi@altera.com>
>
> This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria10 platform in U-Boot. The changes include:
> 	1. Update MMU/dcache setup across Gen5/Arria10 using common driver
> 	2. Add ECC scrubbing support for Gen5/Arria10
> 	3. Add DRAM size checking for Gen5/Arria10
> 	4. Assign unit address to memory node in common SoCFPGA device tree file
>
> This patch set has been tested on CycloneV devkit with SDMMC boot and RAM boot (TFTP & ARM DS debugger).
> Tested on Arria10 devkit with RAM boot as well
>
> Alif Zakuan Yuslaimi (5):
>    arm: socfpga: Consolidate dram_bank_mmu_setup()
>    ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10
>    ddr: altera: gen5: Add DRAM size checking
>    ddr: altera: arria10: Add DRAM size checking
>    arch: arm: socfpga: Assign unit address to memory node
>
>   arch/arm/dts/socfpga-common-u-boot.dtsi       |  2 +-
>   arch/arm/dts/socfpga_arria5_secu1.dts         |  2 +-
>   arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts    |  2 +-
>   arch/arm/dts/socfpga_cyclone5_de10_nano.dts   |  2 +-
>   .../dts/socfpga_cyclone5_de10_standard.dts    |  2 +-
>   arch/arm/dts/socfpga_cyclone5_de1_soc.dts     |  2 +-
>   arch/arm/dts/socfpga_cyclone5_is1.dts         |  2 +-
>   arch/arm/mach-socfpga/Kconfig                 |  1 +
>   arch/arm/mach-socfpga/misc.c                  | 31 ++++++++
>   arch/arm/mach-socfpga/misc_arria10.c          | 26 -------
>   arch/arm/mach-socfpga/spl_gen5.c              |  4 +
>   drivers/ddr/altera/Makefile                   |  4 +-
>   drivers/ddr/altera/sdram_arria10.c            | 57 +++++++++-----
>   drivers/ddr/altera/sdram_gen5.c               | 38 +++++++++-
>   drivers/ddr/altera/sdram_soc32.c              | 74 +++++++++++++++++++
>   drivers/ddr/altera/sdram_soc32.h              | 11 +++
>   16 files changed, 205 insertions(+), 55 deletions(-)
>   create mode 100644 drivers/ddr/altera/sdram_soc32.c
>   create mode 100644 drivers/ddr/altera/sdram_soc32.h

I will need to drop these patches (1/5, 2/5, 3/5) for now as it causes 
the U-Boot SPL file size to exceed the limit on several Cyclone V 
variant defconfigs (see CI failure: 
https://source.denx.de/u-boot/custodians/u-boot-socfpga/-/jobs/1379031).

Please consider restructuring the changes so that Arria 10 and Cyclone V 
are handled separately. Arria 10 has a larger OCRAM footprint, while 
Cyclone V is much more constrained.

The SPL size overflow on certain Cyclone V boards must be properly 
resolved before we can take this upstream.

Also, please make sure to run the pipeline tests and confirm they pass 
before resubmitting the patches upstream.

Thanks for your understanding, and please resend once the Cyclone V size 
issue has been properly addressed and the pipeline is clean.

Best regards,

Tien Fong
