Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15D8D1F9A8
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 10:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F73D83B07;
	Thu,  4 Dec 2025 11:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="QDaSTxr2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2170383A2B; Thu,  4 Dec 2025 11:16:37 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74A0B83F24
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xB8wAzdnkkSOiSd92/Dvj6nX2emSZHqmPZjCZrlDIOhd/QHkk+m5+cvBcn5vKzC3m+C+VpR5DDX+Lja2+bflplTe8CMc3pf2lUe8T4ZsScO2cdyeU0v80JiXMOJBSZOtHIp6xCdvheMGrCWjzVNYhro2iWQCPqq34Gq1jAOh2RpqMQa6oATJHVrso5aObvChObDeVTDAjjLIKgakbLhZzVMMQ0o/YrQR75ysQiCCa6d4J+Q70UsKYkS4mPh3M5wtuZcXgBAkQgBGv3wjJcaTKayHCzo8AHCuhgv3498/FgoDgdWNBtytZl5mtEjfw7wzKTUEpLEB/maDYtODOee7rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kawJUHCrql0+Ty05/xNn9A4SE1GbMKSg8pReFZo7DTc=;
 b=sWpiPf7GXtQPX9FKiZ8X+gKXYyf3FuWyCOQCEewe+rUHZNs1IczLr8DsvliNDjWB/eekP6fuBRT+docI8VbOkQX6bh2LA1z4QOtnLIMOkCQnDToEdS5sdQt+jzfPsCK/TANWfw2Pc0hIKgc27n0KKFP6TgEXXhDf1ZzjZsf/gIeUOJ6m95ENQYnDrgg+ghvBhLbOqcr/w59d9ehR/8qAsx4qDuVxb5gVm9+l/cLsfxwViZVarUFWxd9I/Oxo402Obi6c+I56XafHTqt/kSuMIN3vHZ4ya2jCAYqplCgTuuudKJP7laCekCAqT71YQbqDUbwYHHhucsTLfPLsb2l5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kawJUHCrql0+Ty05/xNn9A4SE1GbMKSg8pReFZo7DTc=;
 b=QDaSTxr2PAPMFCIWujrraP2RTpkNZvNFls35y3C4B7JyUkYKI49a4/ywLB/8MVYAlWxYRIl/T1++7WjP3p60FUf4r7T4mg+QVSA2IhPOEiD8dCR9o3EV2HoMF+FVOn5qkRU33mJoOzuM4VMsqFgQawTVmazvxriphngK9A11YizmATyatTB87TbIBvLPR4xzBGVfpR1qFTKHW3V4THtn+emyQTPjKXfje4OfQH0+vNvskmTfIVT0rxCoCcug7S4DPQzpBQnjz35k/ha8ArZ3gjgbQBc6ing5IgQw5GfWPdeJ35IhlDWjGoS20p3CExGOaQwL2p5uUGhDG4BtN7i5YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY5PR03MB5267.namprd03.prod.outlook.com (2603:10b6:a03:225::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 10:16:28 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 10:16:28 +0000
Message-ID: <694d4259-aea2-4a2a-ac51-f40efd8f2e78@altera.com>
Date: Thu, 4 Dec 2025 18:16:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: socfpga: Permit EFI booting
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut
 <marex@nabladev.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
References: <ae68261d-57ed-4792-b464-b7243b309d9e@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <ae68261d-57ed-4792-b464-b7243b309d9e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY5PR03MB5267:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f31539-aefa-4b4b-93a6-08de331e301f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmJTekxzb1U3YnZCQ2FNRzMzbHhBSGl3Zm5ucitDais5ZGdHY01SQm5qZVla?=
 =?utf-8?B?ZVc0eUllUDFuRDhxSnVLVzg2cHhFM3pHOWFON0VtRGp6Ny9ock5VRHZnSXdu?=
 =?utf-8?B?RWNwWU5zdGIwTXlkMytCTXgxaVBKdXRDcG8waGZWRmRkdGVCY2lGbkZsWG9k?=
 =?utf-8?B?MjhoVzk1cSsrYVhRZ1ZUdWI2K3ZoU2VoWFY1bHFydzdjYlBTK3ZiSFN2YmNK?=
 =?utf-8?B?djlNNFlhS1RVRDBKeXkxZkJrajMzVUNSaTgwRnAxUGU5Yi8vR05uZDhzWlJO?=
 =?utf-8?B?VGFORlE5UUtqdmNxWkp1WDBIZlM0WFc3dGpHNnN2cmdwOEtIR0dyNkd3ZE9v?=
 =?utf-8?B?UXBmVlF6RWF0bDc1bUwxTm02cnp4RWFzOFdsUDZFVEJQMjdNVEJWOVJlZWFx?=
 =?utf-8?B?VTlhaXRqd2xBeUpqTm5Oem5zVmZlYU5FSGU0YWlwT0pXejBNMndVejIyQmZz?=
 =?utf-8?B?dWYxTlBzd1FRaVlZZjl4VzBZa0w1UUVJOFcwdWFUMG8wcVF1T2lFdE5mV3NU?=
 =?utf-8?B?cUtmWDc1SXZxN0pWSTFSaHVzNjNiektzK3pVN3JqUWNlSVlmQnd6ZUlGWHBE?=
 =?utf-8?B?bmU0eFlLWkViU2RXa01Yc25mOTlDeE9pMXRscy9Hd2VZS3FhMm9qeVNaa3gr?=
 =?utf-8?B?cUxjTTFIRzVodlBzQnhKWU9QQmsyUGRnN254NHBNRFIvZ0VmcUdFWW1WZXNT?=
 =?utf-8?B?aWpWUDI4Qy9LL0pUWjNFMUNaNDdhcW55UXpma1IwWWlPemtEMTlqZVFmYUhK?=
 =?utf-8?B?QllPa0IwUWpzUktubFg0S2xJOFU0TXhPS0Y1RGI4UVMySzJ5aUxkcHdaRDdB?=
 =?utf-8?B?cUgxQjMydjBBbDdrTHUyY0wyU0xZcys5NmxXaFYrS0dEMU53VFFHWHQwVVNm?=
 =?utf-8?B?STFDOThVOEV4U01VUldySTk1R2pCV2YzMk81RGpaN0M5dnltSGtOWWp0cVho?=
 =?utf-8?B?V3MzbG9LRnE5eGZUNEx2dUxBMWZpKzducHI5Zkc4MzJ6MkxtVjQrQWdZY0sz?=
 =?utf-8?B?bjAwekJhU1BJUmp6ZnJFODRzWWc4cm5YRk1qTVhvTjZWYUxtSGFtQVp2QVFQ?=
 =?utf-8?B?d0pQQ2FLeGF1MmI4ZDZGTkJsMFBOYUtIL2Y5NStDc3lIZGE3MW9rMGlRWHZN?=
 =?utf-8?B?VkZSS1hGeWNvODNZWXJXWlQ4OFdHZ2lHWEhaajk4d1gvOEJoMUtxakFZa3oy?=
 =?utf-8?B?b2k0V2lXYi9Kam05TXI1bHRUSkVxL2VSZUJPMEN3Rzl3S3dUcGhjSlNicHRO?=
 =?utf-8?B?MDVOaDMvdW1XNDhpS2xHM0E5VDlSMVdFK1RWV3Fnb1h2cThraTR0WnZMV0Fz?=
 =?utf-8?B?UEJSOWtkR0RqS2FJTmkzK0Z4Wk1MNjJpNCtjZnVDb0I5SSt0NWw4SHhIZ3dH?=
 =?utf-8?B?MlRram01SDlPcUNCa1hoZ244ZzliOGRZSnAvdzAyU2VzcVM5eW5rZHVLS25U?=
 =?utf-8?B?N0dzTjJQWE9SWXVsRjR6VHpXbTdsVWc0UStOSFJrK2ZmalpVVFJ1WnpZMUhY?=
 =?utf-8?B?UU55cUxUS0I3MS9rZDAyaEo5aU5mTmlyZFlSWjlFUWJRai9UWXRKTmtDTmRP?=
 =?utf-8?B?VjhxMERXT0tyaXRVZlVQSjhhSGYrUUpFNW1INzg3bTJFejkwQzg4TndlTjhH?=
 =?utf-8?B?QXVuNmN0TUtud0VDQWtkS25UZlRERkpJbVQ4Y05EbGpmcEVnU2ozb0hRVmxi?=
 =?utf-8?B?TnZhdW9lY096T3UzYThkTlZxbC9FbExYSzk5cHZ4WXpsdXFHUjR2ZkFrQkFF?=
 =?utf-8?B?NmVBZFNzekRleVVaUzJDTE1UbGRZRTJPbzdnc0t5QmVPZlY1ZmgwenpUWHlp?=
 =?utf-8?B?cFFvenQ0NlhKMlh4enpHaHpxbUVkU2V0eVNyWjBodnppOEJlaGN3VWM4S2tZ?=
 =?utf-8?B?cUY0Q3l1US9FQ3kzZ3BWUExpNEdpMjNBdSt0OHl1NnJKMFBmd214TVRhTE14?=
 =?utf-8?Q?HfE5Q1B9Ixzb0v8P2gYqTMSaAjt/EZd2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ykw5U3U4cG5YMnB3eWM2TG8rM0tkeno4YmxUckRpR3Q3eGxiZFdubW5Dc3E5?=
 =?utf-8?B?d1Uwdmo3bU52Z2pMSEp1d0dodzlOOVJnYnFLcVhaV1VodXBWOXd2V25KL2F4?=
 =?utf-8?B?d0Z6alpiQXU3TnNvNlRtSyt3YXFxRmd4cDJjNzhKY0ViZHBMbnp6WlhGMXNT?=
 =?utf-8?B?NjlRcEZsV0pTdE5pVlB5RnIyYmZsRGxEdWlIL29vemlwY1g4ZG1GbGdWVzBo?=
 =?utf-8?B?MXgxNHVLVzZndW1vaFhGc09VbjJ4ZmdoaGpsQ0NGcnBMeldXY3lWUDdDRWtz?=
 =?utf-8?B?R1g0MzZ1Mi9XMGZWS2l1bmNXaWkrSHFkWi9QYWNhWk1jcFFnbTN5cWpWNFN6?=
 =?utf-8?B?UmRXQVo1MU9tU3lINDJ3VUJSYjJEY1gvRGFVTzZnTjZ3RWYxb3QyL3pNbnQw?=
 =?utf-8?B?QzZlMXZrQzFlNCtOR3pHdHo4WHg1bGZFVG1VMERHNTNwcHRGamNZanNIci9U?=
 =?utf-8?B?VUR1VkN5djlyOE5UeW5ma0NGWnVwSWZuS2VEMThVWlVZVlZ6M3RPOHBTL2hM?=
 =?utf-8?B?NjQyRmtRNldFdXZkeUVUbHVZamZLT1k1WVp2V3NERmlrbHUvOU5uU3NwditD?=
 =?utf-8?B?R1dsL0VmNnZFeE81ekNSaGlYR0k0SWh4UjE4RFlyTFlpcFZQK2pUVk1JYjkz?=
 =?utf-8?B?Z0U5OHhWbzhuc3RmQWduUXFsbldBNjlXZTdHQVpsb21RUmRWbkxUODFkbnMr?=
 =?utf-8?B?MVFsQnQ1WCtHQUlwMWNxbzFiVmI2bksrK2pNT0EzUTBlc2FTaTVVbXcwZ1NL?=
 =?utf-8?B?WGRidXJqdU5qUkMzT08rc01MSFpXZGtKQ3F2VVA1U0VIODhFS2J6d29PdXJH?=
 =?utf-8?B?SHB4Vk5sT0lJNnptWU9DTXF3ZVFTR2pxMHVVS0k2dUJkWHpOaWZEN0NDL3F3?=
 =?utf-8?B?UlhRbFlKRk1ra0YvM2k1WnowNkVGUzBoK0NUWmk2cExuN29qRW9VYU8rQnFM?=
 =?utf-8?B?WkM2dVhDV1hsR1VjdDNCS3ovTWVUZWI5aU5IbmNXZ1NCdU8rQUxnUjBibU04?=
 =?utf-8?B?SjhsZG9tZlEyUS9ZL3FuVmVzQmVwd0VIb3BLbnNFL1lYa2xoME9VVGFwNSsy?=
 =?utf-8?B?N1MxbmVDZng5YlQ3RUdCbUtoN2toRkJOYXYvQ3VFK2hVVEoxTUlnRzNyemdY?=
 =?utf-8?B?OGxQbkpKVGpJbFBTN1IydTZLL2h5Slg4anJiV014Wk9lbUZ0bjNuSDVJWnVu?=
 =?utf-8?B?eVQ2VGNUZ3h6b3k1ekthQmxxWjlDZnMybEZKNGJzSmpUK0NiYUNPNmlpcWJv?=
 =?utf-8?B?TGM0WGdKMWZyTnExNzA5NUc1RGkrUWJTUG5xbVRiRlA5emJsZnlzekhGTHBu?=
 =?utf-8?B?b1drYVpwWWI0cmpLSVBvWWcyOWRUUlFNeUpvcWV5Ky9xLzVBNlc1MmNvUStj?=
 =?utf-8?B?bWFNZElvYmlkVWpMNEdJN1BxWkFxbXhvc1ZvSy8vbWFKSFl2Mm80VXhiZ29y?=
 =?utf-8?B?WFpzZ2Nzekw4U0RUZGgzamQxRUxWdEU1ZDNCL1kvWWZYb0szS3R4bloxbHc0?=
 =?utf-8?B?cGd2Y2RqUUFiS2pJUUNWdWFSSy83Q0R0RkQzRk5YTjhWVm4wMUVOUlpmaW5l?=
 =?utf-8?B?SzI3SzZpdDNCQmNQVU9oMm9hM2J0TnFNL3RmMUxsTldWeERXaGtIcGVGMFdK?=
 =?utf-8?B?Vml2cXJOTnE2dUtYZlRJMHFJWHo5aDIzNXAyWkVMUnBOZk1Ya3UrZjFDWXFT?=
 =?utf-8?B?QStqa0VlMkdyeHR4RURuVERZd1VhajE3cCtXL3pNZTF1bHF1eHFTUWRMdVps?=
 =?utf-8?B?cDRERkc1LzFmYit6bnZtUTNXTFpQMys5R3UyMnVrYWJQa1h0dm9ZVEYvM1Aw?=
 =?utf-8?B?KzF1VTVFTFlyMks1RUgvMmZINEltTGI0akY3czlJVWFBRE83TXpZSE9LSHVt?=
 =?utf-8?B?cTk2ZDhZRFZJSVJ6VGo3NEkxSmpmTDY5eXNzbzNqSmJWbzBLOTN2bXl2ZVZa?=
 =?utf-8?B?WFNSR1YvOGJGN2NMSXV4dml3Zy9zSTlRbEdRSDZseEM1WVFuN1Exa012T0tQ?=
 =?utf-8?B?OW82clFLUkFkZlQ3WDRvdmJVSGRjMXpDVEpMMG9qVHM3Ui9rbUZ3Z1pNRlNx?=
 =?utf-8?B?NS8zUXFwRGkvbFBqSVNqU0NGTzhHaE5JaGpnSTkxK0VSSUswYzNBTDIyOTFy?=
 =?utf-8?B?d3dQalFEak9TR2N5am4vek1KbjhlLzkrZ0NvRThmTWM4R3NoeW1IQTRSRVR5?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f31539-aefa-4b4b-93a6-08de331e301f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 10:16:28.7090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFXThAkZcfyGy3Oe0+LVg0xy0hNe1PAV5ZUC/kiPGrhcE7HGZK1aCyYMxf9C5TfjqE5rM9UScGXg6iDgUodDxz4ijuz/zOtzuzkxE08eVZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5267
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

Hi Jan,

On 15/11/2025 1:13 am, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Commit f369e1564cf4 turned those off because the SPL size grew too
> large. It also argued that those boards would never support EFI booting.
> The former is correct, therefore keep CONFIG_SPL_EFI_PARTITION off.
> CONFIG_SPL_ISO_PARTITION is default off. What is not correct is that
> those boards are limited to legacy boot - you just need a hybrid
> partition table to make both the bootrom and UEFI happy.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   configs/socfpga_agilex5_defconfig       | 3 +--
>   configs/socfpga_agilex_defconfig        | 3 +--
>   configs/socfpga_arria5_defconfig        | 3 +--
>   configs/socfpga_cyclone5_defconfig      | 3 +--
>   configs/socfpga_de0_nano_soc_defconfig  | 3 +--
>   configs/socfpga_de10_nano_defconfig     | 3 +--
>   configs/socfpga_de10_standard_defconfig | 3 +--
>   configs/socfpga_de1_soc_defconfig       | 3 +--
>   configs/socfpga_is1_defconfig           | 3 +--
>   configs/socfpga_mcvevk_defconfig        | 3 +--
>   configs/socfpga_secu1_defconfig         | 3 +--
>   configs/socfpga_sockit_defconfig        | 3 +--
>   configs/socfpga_socrates_defconfig      | 3 +--
>   configs/socfpga_sr1500_defconfig        | 3 +--
>   configs/socfpga_vining_fpga_defconfig   | 3 +--
>   15 files changed, 15 insertions(+), 30 deletions(-)
>
> diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
> index bbe712f8452..6347090105e 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -67,8 +67,7 @@ CONFIG_CMD_WDT=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIMER=y
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
> +# CONFIG_SPL_EFI_PARTITION is not set

Instead of adding this to every SoCFPGA-related defconfig, you can 
simply disable it in Kconfig. Set:

config SPL_EFI_PARTITION
default n if ARCH_SOCFPGA

as shown here: 
https://github.com/u-boot/u-boot/blob/69c8ea98a713f88f4a6ffad9df2a72b1a767f629/disk/Kconfig#L141

This approach avoids duplication across defconfigs and reduces the 
chance of missing other SoCFPGA platform variants.

Thanks.

Tien Fong


