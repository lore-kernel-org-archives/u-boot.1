Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33ADCE7AF9
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 12:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DB9483F33;
	Fri, 14 Nov 2025 13:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="WH/gjSQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2773F8409C; Fri, 14 Nov 2025 13:04:19 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D3C83EF5
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 13:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoRnXuwh1ewMxdXjW/BEmomlg6FF6K/95htiqkfv8gQq9bkpGEiOso0KSiTrnJHdw2uWEv/PxJDrtAYci/q7DR5hwJNNFwMmctjfZm1tRcznO1d3AyVYfUfPOXUHuW27dxVt0VYYHXcExNaL/HytHg+B5TOprDBh8SeP/NlD26aPX7jx99VDo54tpu/FVlPiqQY2CINI0VK/+7DC7X7SLk1g8RPMItc+BCREcCyVjFx7I1484MM1d8f5vMCL4ld49mNjX5k0hihEHiQvufubUZ6DUGtADDyvd08mQ897XbTFLTE7kYpcy5NdpDaYjU3YJ78vpYdLzd3wYoExT454yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yL30IRJqHVOclIqXN1hgDwnNb4U4I1l6h9cARAdBH+E=;
 b=Ov7WyCgPGpLmOgj1o3P+dlLK9yJwOaEsumz8yvK0ntI3yeiJwhXXmZz/iQgde5RWZsKI5jC1KFEozND6+pG/vuNwscaxcvFcWhAhLRu0lcTR0df3c2EQ4+NSd29dKdOe4t/Nr6Lze5d7WEpiy3v7Ri1eUj1NsPT6fcby2HUEzm9FHgB3Gkdn7WYHYu+vJDoYRVti2rQ6x6iI9F2Zr6JW9j19SWjp932zVPYUy24hiFZfG/sWp4R8TrXDy/or5EQ/4CsghI6pQCRLrvSso8oLaRaeLZcJPdjhbiSlbNHDWkUbGz8FEEUjRcIoFxp2jgCVdF+6W7C3o26KsvVC6QOzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yL30IRJqHVOclIqXN1hgDwnNb4U4I1l6h9cARAdBH+E=;
 b=WH/gjSQZjIwceOPkRsI+8vdxXKkDoa+PtUQXcvQ6fLbzGAaPp0mSk1CKC8CO6ZJgPUs3P6mqk7HZj5DiboHI8F7s7i4e91cHRcupWBalxFDahs2pn2ffOItjB1U5K9GMeOrHdR0LC4CV4Hs2pLsiCDIw3y79g2s5vW6piCw4UiSBnTj1PM4Obf5IBUeBRbsC3cu9eZmEPZy2ZXJ5V0j141zDAn8iWIqzwGeL7bwmVTNleObCm7n5uWW2EJr73p3lGgnT6rx7WIdQChloj9ZdPo9uzYSggnvK4QkVly/oCbXoo0INgGknNX/WAuBLO9bWA93on1knQRCiYR8m7C7Xdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB9588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2f8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 12:04:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 12:04:13 +0000
Message-ID: <77f4cc84-9272-4af3-8694-66f60c01d755@siemens.com>
Date: Fri, 14 Nov 2025 13:04:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for
 system manager in Agilex5
To: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-2-alif.zakuan.yuslaimi@intel.com>
 <DM8PR11MB559296B2DEB7CB7AA6253B7BD2C52@DM8PR11MB5592.namprd11.prod.outlook.com>
 <0c48f4de-0da8-4d95-8070-f4382ef344f8@siemens.com>
 <a35f16ba-5334-45c2-adb1-e0b6291cd004@altera.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a35f16ba-5334-45c2-adb1-e0b6291cd004@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0010.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 04ca9d03-2e87-44a6-df74-08de2375ed7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWhEbDA5MVNxdkpEN1hQSndMc05UZ2dTcFhQTGhzZXVlV0RiUWFhM0JmbVFQ?=
 =?utf-8?B?VVd4ekNWTTZ5cithSkE4UVlEVjhUZUhOUk1xNXpNTWZFNUt3MkxuTlJ6SERh?=
 =?utf-8?B?Y0hOY3pnVmRDMVhyWDNuOElCT1hEOU5oTFhvOVo5VUxlT2xicTFiSlUyQ081?=
 =?utf-8?B?SEhhSm90djVZT0gxblBnY3drM0s0TjQ4MzJzKysyQVNCdGdwenZxWHNnVnkr?=
 =?utf-8?B?L2NOUHpnOVlVUFVCbEsvTG9UNVNFZUExKy92NXZudm9COHZndG9rd0cyUjMw?=
 =?utf-8?B?S0gzM05iV29RTmUzUnhRQkhPaEpXYnpYZzBvQnhnRnptRlFOM1JsZkF1QnAw?=
 =?utf-8?B?Uzh6SDd2K3Jsbnp4ZEszMFIzSU9WN2FiY0s4WUJGMitidmZQZGFzSWcwK3VR?=
 =?utf-8?B?eEZ0ZmgvK1NIREo5cHB2M1R3QW5Qbkl3cGtreFRjQzJuTmFCcWlzeHZQWnND?=
 =?utf-8?B?QTJvL1hqZGhlcjZwNWJORFJveXZFWXhzWHNQdjNVRWx2UDBiR2VBL2R5Tm1T?=
 =?utf-8?B?USt3eVpLVTkwbmJ3U1lZS1FVaHdDZ2djV1IxK1ErRnJ2a1FtMlF1Nk1iZkNl?=
 =?utf-8?B?NE5Kei9qWnNFNkkwTExsbnkyNXkxWHc1RjBPSEw0cVVBOE4vMHlER25hK2FV?=
 =?utf-8?B?VTJ3TkFQd2NYSUVyNStZYlZtNlB2ZUZlZkpnS1VTK01HempKWHJxYzk3YUhk?=
 =?utf-8?B?M25tZmoyMnc5S0cvSmhZemhPVFFKRnVWcTJDR3JhT0Jkdk1LaEZVYzJxcDJE?=
 =?utf-8?B?MytHNEEvcnBwOG01dFFqNFpLeUNmelhNQVh3U2krWURIYzlmZ29sa3YxM1Vq?=
 =?utf-8?B?czlDTTl3bkttRS9jQTJMeVluVE1pNHZlc0N3L3h0RUZ6ai8xb2FKNnkzdmZG?=
 =?utf-8?B?Z1VQdDVlN0VQRy9YODZJZUY5b1UxNnVVN1ptTjJQNzloN0FWT0Q4ZXpBbFJx?=
 =?utf-8?B?WHV1U3IxV3puY2x2dEptU2ZQMS9mSENZemR3Z0I1OWVKS3ZoYmhjZkUvS0J3?=
 =?utf-8?B?S2VjR2ZnSTBSL2hkR3ByL1ZYSkZZK3ZjYWlJSTdJM0Nxc3REd2NsakRFdjAz?=
 =?utf-8?B?aVpqa2dwZHk5czMrRzlsQVdNUzNzYVlPVTRNanlRWm1KWGJGSWNpYWVBN3dX?=
 =?utf-8?B?VE80Q2llN1pnR2tIVkhtSEo3bUpsNHZ5Mml0RUpGd2liRk9lZWR5S3QvckRi?=
 =?utf-8?B?blllQTdXS2pxeUhINGhsRW16Wmx1R0tqNWtySEJ1TUNwUUdpTjZQWjRwVW1u?=
 =?utf-8?B?azEvUXJxcWk4SkQybEZ3YzAyU2w5Ymo5ZWJsRFJlRVRRWG9uemh1Z3BjWTNZ?=
 =?utf-8?B?VVd3QWtTMlpmSDQyNUtPR0ZiZnNqSGJ6ekNISC9uWU82U1crdDRiSUtWeFdi?=
 =?utf-8?B?T1ZpbEpLbjdrLzhGR0tHTGNTdXhhbUZOaVd3Y28zc3o2Y2l4VWw5MDFxVDlB?=
 =?utf-8?B?aUhiS0ZDTndGdDFnQXVxL0tGK1BNMHpOZlJzbW1ENDk1NzJUUUZBUzBrZG5Y?=
 =?utf-8?B?Ynprc2RQZEZtYmZRYlhYSjRTUnhzSXFaYkxLblRaWG55dlJMdlRUOCtsTkNL?=
 =?utf-8?B?TzFrSjlZVUROaEpZeTJsRVc4bTdZTDFPMnRoNnNkQTNvdzFLWHg1U1Qzam5q?=
 =?utf-8?B?MC82S1ErTXVoZUZldDlnRzZhWXJPZWszVTNhRWhDcTk0d3l5eGE5R1VwaVhp?=
 =?utf-8?B?ZW5TUXNKRUlNOU5VdGF2dkhhNk50SjVYWEtJQUZTQU9jbisyMWhuNUp1SjRp?=
 =?utf-8?B?cTNWY1ZSM3NkN1FLZUJDMGlHN3N3d0Y1M3EwdWk4aExSUCttSGh0MDllZHY2?=
 =?utf-8?B?UG4vTXdzN0xvQVpBMkFoZ1FvZjhERFp4N0FPdjFudkdkM05KdnZrNGpMYjJ6?=
 =?utf-8?B?Tk1VNkJlR05wS3JpR0NRMnlHN3ZJM1E3NzdXZ2h0UUZQdzdhMm9VNG84VXFN?=
 =?utf-8?Q?e492o1Q0oFngD/V4XqXd8uOSJgre9+eQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDRFbm5PbzhoUW5UL3VZOVBsYnlXa0JsWVRHMlp6K25xemtWU2N0MlhzWUZ1?=
 =?utf-8?B?MEd4Ym9ua1FXUXBMdWRjYkxLWUZLa05XQ1ltdzNWNTdxY2ZUeDFxNXdwWkN0?=
 =?utf-8?B?Uy9SakJ2OTJnMkd6aXZ3Wmd1QmlOT2lGd0pPWHY1OTNnNEN0KzZuY3VDYW9q?=
 =?utf-8?B?anNQS1BsblMrL0lxd0RCN085ODlRSnVzRzI5YjB0L2kvUEVFY2VqTVpSL0hk?=
 =?utf-8?B?SDZIanpHL1dlM0FtK05oTXl0SFhMRmNVbVFrd3VKTElCTWN3eUxzM1NPcm82?=
 =?utf-8?B?UCt0c3oyNWJ1Yk4rZk5iZWJDcEFwUHExa1RBU0c2YW81cW9iNFdubGMveE9U?=
 =?utf-8?B?WnZyOHI2eTMzNFJKd25VeTArTHNveUFUNm5xM2ZJemNZSjBDRFRxMk1lRVJI?=
 =?utf-8?B?MklCQjJlUEp4VFNpSnRGUHJYekVaMDExa0JIRS9OcHdlWDU2aE5hYlczeGpj?=
 =?utf-8?B?R3BqbWUrd0Q4bDduR1hsZWREaUpiRHJ1cit5NHlUYTNCcG9DTUhRWmZiRGJj?=
 =?utf-8?B?bkQ0VEJSRjUwMEtabHQ2L2RkVFVZdi9TeWFJdG5vZlgyK1RVUThITnJEOEgw?=
 =?utf-8?B?MUpscy92d0E3R0FncEJmU3FpT29ER3g2MlFTVHhSS25mZnlwdGx4U3ZTbXBu?=
 =?utf-8?B?NjA4TVVPZ0psODhnODF2M1M0YnZIVDhvWm9nRTM1WmpmTCtsNnRkaTlFeG9I?=
 =?utf-8?B?Y0xGSlZ1eUZFTDgzQ2doU1V1SzlhSTNrUnptUE5USEgyeEFrZkVDV3l1Nnhr?=
 =?utf-8?B?QTFyT2gySTd2UlJ6WXF5WEJJYlVOZTBDbzYyaXVWWW14R0tNTklTNU5vNUVD?=
 =?utf-8?B?eE82UHhRRTJOb2VrRlMzbHhtNUNkem9ScDBBakl2TFJiYStRQk9vTXJKSjFi?=
 =?utf-8?B?bzNqWmlnbkV4K1lLb2RucjNjbGR0c3JEVkdxS0pYL1JuZlZ3L2piRjlXUTlH?=
 =?utf-8?B?Zi9YdFI2Vk1YeEV0bk9wWnI0MndtRmdVbmNmaXQrSEp6UFNDZG1odlJLSXlm?=
 =?utf-8?B?SVpvanhYWlg3OUFJWDFoelc3V0JZeWVxUU0xbExnQVFnM0hVemJLb29PQlFh?=
 =?utf-8?B?bUpESi9VWVB5QkNpKzlKT3pqQmRqTldBSVVGbHFsYkF3OWVycjYzUEZva1RE?=
 =?utf-8?B?cXN6RzZXWGVIL203UG9wdFdWbEF0MTRlWmI0S2FNakJYMkpsRXF2bEJ6NFov?=
 =?utf-8?B?NHBKWG5tdEpsQ1RKVGRoUCtvT1p4NnpMMTZwYkFZNnJQQW9CMlkzU05HRUhl?=
 =?utf-8?B?RE90c2NqODJVSTkwWUppdHJYZ2JCV3U4WHNtTW9HWFV0ekdRQlpETWsrWUI3?=
 =?utf-8?B?WlF1NEliNDIraHdmVDY4VzMzcnRlcXlXRXdYNjVOTDJHdktWMGRxdGY5eVlW?=
 =?utf-8?B?bm5BNHRsSHlHTmpMSklKRVdOU0ljZ0xtNGJUK3p6YTI5ZmoxTll5Tmh0RUxm?=
 =?utf-8?B?MVBybGNib2Z4azFrWXVpRVFjN1YxalBndWVGaFRyUENvdmhRVmxJQlZ1UC9p?=
 =?utf-8?B?eDlzVmJtUUdZaWMwQzRycGRjRzBIK3ZqTGJ3Y2NUblFMQWVrMjlUMnZGTVZn?=
 =?utf-8?B?WG4yRnRUdDgweGZwVEJYMFB1K0dUUFR4L2JvR083eFl4SUhmR1NpQ0RHMVVZ?=
 =?utf-8?B?QzhTd2I2UkRxMm5zYm1hTVkyc3IzRFRYdVpDcFhmaU9NREpUMnJ2SlRuelRC?=
 =?utf-8?B?TjJpZGcvRk9ROThtcS9CNFI2RnVEc3NWTFFmaEp6SzIrTWhFRDM5VWFmMnBl?=
 =?utf-8?B?MklteDZNeVpFcUFOeEwyT1ZOZDVNTEJGYXczd0JjNHJ4aStZUFZKaHkwMENj?=
 =?utf-8?B?SWVLTEw1UTV0SmZJSWxPZ2Rnd1dLSWdmV2xrVnNMOTdJT0NjeDFqWDR0bHJz?=
 =?utf-8?B?MG5ZOS80cTcxNGUzb0Jic0VUeHVOWjJSdHB2NnhsRE1Da3JEMm01L2VhMTBn?=
 =?utf-8?B?UUNPOC81Z29xSnhJOFhEQUcxTkJMYmhBeWF6MU5Yc2RrMHl5RVVWWFlZUFJn?=
 =?utf-8?B?SjlMOXRkc0p6dDg2WmU3b0drMWFRbWxGRmN6dG0xRllDWi9yVzAwS0poM2FU?=
 =?utf-8?B?K211RDRRbWRmNGpySWsxU01pQllVdXF1QmYvbDVvN3o1VVg4V2RYT2xYK24w?=
 =?utf-8?Q?QBSbdQyIHo7hnpAJh4NeIKnjO?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ca9d03-2e87-44a6-df74-08de2375ed7c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 12:04:13.8248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6eZzEchRBmuXYAqQPexoRQpB+oLytSnCK9YsQX9RPO7vEGnjRDS40ryG6fQy90aiJ5SjOGLJIr244mvhUzH7wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9588
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

On 14.11.25 12:15, Chee, Tien Fong wrote:
> Hi,
> 
> On 14/11/2025 6:54 pm, Jan Kiszka wrote:
>> [CAUTION: This email is from outside your organization. Unless you
>> trust the sender, do not click on links or open attachments as it may
>> be a fraudulent email attempting to steal your information and/or
>> compromise your computer.]
>>
>> On 19.02.25 07:37, Chee, Tien Fong wrote:
>>>
>>> -----Original Message-----
>>> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>
>>> Sent: Tuesday, February 18, 2025 4:35 PM
>>> To: u-boot@lists.denx.de
>>> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
>>> <simon.k.r.goldschmidt@gmail.com>; Tien Fong Chee
>>> <tien.fong.chee@altera.com>; Alif Zakuan Yuslaimi
>>> <alif.zakuan.yuslaimi@altera.com>; Tingting Meng
>>> <tingting.meng@altera.com>; Boon Khai Ng <boon.khai.ng@altera.com>;
>>> Kok Kiang Hea <kok.kiang.hea@altera.com>; Chee, Tien Fong
>>> <tien.fong.chee@intel.com>
>>> Subject: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model
>>> for system manager in Agilex5
>>>
>>> From: Tien Fong Chee <tien.fong.chee@intel.com>
>>>
>>> Initial creation of new system manager driver.
>>>
>>> Add supports for the SOCFPGA System Manager Register block which
>>> aggregates different peripheral function into one area.
>>> On 64 bit ARM parts, the system manager only can be accessed during
>>> EL3 mode, this driver model provide user the high level access to
>>> system register and abstract user from low level access.
>>>
>>> The base address of system manager can be retrieved using DT
>>> framework through the System Manager driver.
>>>
>>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>>> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
>>>
>>> ---
>>>
>>> v1->v2
>>> - Implement system manager driver to move towards DT probing
>>> ---
>>>   arch/arm/mach-socfpga/Makefile                |   3 +-
>>>   arch/arm/mach-socfpga/altera-sysmgr.c         | 113 ++++++++++++++++
>>>   .../mach-socfpga/include/mach/altera-sysmgr.h |  16 +++
>>>   arch/arm/mach-socfpga/include/mach/misc.h     |   2 +
>>>   .../include/mach/system_manager_soc64.h       | 128 ++++++++++++------
>>>   arch/arm/mach-socfpga/misc.c                  |  18 ++-
>>>   board/intel/agilex5-socdk/Makefile            |   7 +
>>>   board/intel/agilex5-socdk/socfpga.c           |  12 ++
>>>   configs/socfpga_agilex5_defconfig             |   1 +
>>>   9 files changed, 250 insertions(+), 50 deletions(-)  create mode
>>> 100644 arch/arm/mach-socfpga/altera-sysmgr.c
>>>   create mode 100644 arch/arm/mach-socfpga/include/mach/altera-sysmgr.h
>>>   create mode 100644 board/intel/agilex5-socdk/Makefile
>>>   create mode 100644 board/intel/agilex5-socdk/socfpga.c
>>>
>>> [...]
>>>
>>> Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>
>>>
>>> Best regards,
>>> Tien Fong
>> This very likely broke all targets except for the agilex5. It definitely
>> broke the cyclone5.
>>
>> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
>> index 9d464307665..e0ed1b8e954 100644
>> --- a/arch/arm/mach-socfpga/misc.c
>> +++ b/arch/arm/mach-socfpga/misc.c
>> @@ -248,6 +248,12 @@ void socfpga_get_managers_addr(void)
>>          if (ret)
>>                  hang();
>>
>> +#ifndef CONFIG_TARGET_SOCFPGA_AGILEX
>> +       ret = socfpga_get_base_addr("altr,sys-mgr",
>> &socfpga_sysmgr_base);
>> +       if (ret)
>> +               hang();
>> +#endif
>> +
>>   #ifdef CONFIG_TARGET_SOCFPGA_AGILEX
>>          ret = socfpga_get_base_addr("intel,agilex-clkmgr",
>>                                      &socfpga_clkmgr_base);
>>
>> Arent't you testing for older designs anymore?
> 
> 
> You are correct , the patch as-is focuses on Agilex5 and does not fully
> account for older platforms like Cyclone5. Our initial plan assumed
> users would follow the Altera official release repo at https://
> github.com/altera-fpga/u-boot-socfpga , where we are gradually migrating
> platform devices, including Agilex, Agilex7M, and Agilex5 to the driver
> model stage by stage.

We never used downstream U-Boot, we rather invested into upstream
contributions - quality and sustainability reasons. We do this rather
consistently with our suppliers, BTW.

> 
> To clarify, as of today, the platform devices for Agilex, Agilex7M, and
> Agilex5 have already been migrated to the driver model. Older platforms
> like Cyclone5 still follow the previous non-driver model path.
> 
> We are now aware that some users are still using mainline U-Boot. To
> address this, we will update mainline to ensure that existing platforms,
> including Cyclone5, continue to work as before while maintaining support
> for the newly migrated Agilex platforms.

You cannot simply break existing support in mainline just because there
are some legacy vendor trees that still happen to work. If you confess
that you don't care about it in mainline, I guess your feature
contributions will be looked at differently here in the future.

> 
> We appreciate your patience and will make sure mainline remains
> functional for all currently supported platforms during this staged
> migration.

I have a first patch ready and will send it in a minute. It will not yet
migrate to the driver model but it should unbreak all the non-agilex
targets (I only have a cyclone5 to confirm that).

There is in fact more broken when it comes to loading U-Boot proper from
SD cards, but that's not your fault this time.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
