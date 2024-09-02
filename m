Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B93CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 08:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E69D88A02;
	Mon,  2 Sep 2024 10:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JsRwDnLz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA36488A12; Mon,  2 Sep 2024 10:57:31 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D12D0889A2;
 Mon,  2 Sep 2024 10:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7+CsfHe+0ackx4tkh4X21g4qD7x6lwI5V1r1jMwl0YZo5V8ikWNLZaZbtuV4vZfd+3ni+AWLNrSpi7WZB9QjJ1L/OXCac59PL5eCpcYHgRNnl2u9bfY1WWVZnIFrLfQhmV1Ckite2Y4916gCQvzCwwz1kO/eSINK95eZekuEUvQqPmUiEtIkKNKjXDiERGF+fEcqpeKWnBhflFxzDUSbFhZl0oX43JfYzxX3vSFHocMr/Gfr6A5tca0hhMYCMpKKw1msX+UytxCBi0FjvKydfvTFUnn0WRj/NmTYCzE0m9+PVFEwFWQvBJUGfoEQRmOfaxhfd8b4FjVmw/Dr+pVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+r37c5qGQvk8vuUifBBVP56usDgUjQI1OyWmrPzJTY=;
 b=xQU6Qq1nQV+vHElDxFK1A6AWlEmO8Pi+Bw6ST/8b7D/9vLIlmW988FlJyVzCNvSTJMJnAmNx4Cu9Ld4WMFv2ClfQrnf17BWSh9BdDwHVLNEvcgxj0iLZ2sNhlU5jH9MAZoYKKSEZ+4gTg0ojXvDEQY4ZSBLsEfUp9+JAs+u4OcgJ7gnk77Fnhs3WdOJRixptfIlutY0Ira/rdz8v8b5Ma/FxaOw2jMDLO24jMYTxfeGPbZOIlwOyq2hR0ygLIqbohXt81aMhVsPWpAappSYrSPzcjwbrYuRyhjFrX/9uVDh2l6nEVcXY0prbh2zG607suBfkbfUUfJhXwEFHH0oZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+r37c5qGQvk8vuUifBBVP56usDgUjQI1OyWmrPzJTY=;
 b=JsRwDnLzvMRBIEMH09MKPBJ86wu25V0KakQA7e7/LfeJR48yZxDxItgusYVcJuzwq1B/9VvjlcGrk/x3gZo4ET2kiqyLntW2lIdhoMYQ1aqOh/6fsOwFO5HXjjAszMXaJGSuRmtwSO0sq45/3XSXF6ecHyf78luHEDKJ6chgeL4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB9018.eurprd04.prod.outlook.com (2603:10a6:10:2d9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 08:57:26 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 08:57:26 +0000
Message-ID: <dd2e2ce8-9825-4bce-90f6-7e08fe7e3da0@cherry.de>
Date: Mon, 2 Sep 2024 10:57:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: xPL terminology
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
References: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
 <20240827165025.GN2479150@bill-the-cat>
 <CAFLszTgD6aeYziHHJrsbYgP+eWTR6GJ+BJNvoitPZCyJpyV-8Q@mail.gmail.com>
 <20240827214330.GP2479150@bill-the-cat>
 <CAFLszTiywgEjTB2s4Zmz4vcmqLhRXLcbTnJGyig3b38c9Y2KUw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTiywgEjTB2s4Zmz4vcmqLhRXLcbTnJGyig3b38c9Y2KUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0342.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB9018:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d57384d-ebf6-421c-d161-08dccb2d4440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UThZTlk2djlQSDY2V2JZZTMycnlJcDQ3azQ5Q1VmYTNZOENsRmRwNzl1ejFt?=
 =?utf-8?B?Umc4R2UveGsyZEFacnFnMk1ZS2owanE0dnNIT3lTdzdmRThocnZHUzJlU1Ra?=
 =?utf-8?B?VVphZVVHZU5YdU4ycnJwWFMwaGZyWWhMTTZlWUZKUVBNaG41ankxZG1uemxq?=
 =?utf-8?B?S3IrYUJQQ0FrUUsyUXI4ck5KbzdHTGVXQ1hCMmVjTFg1N3VRS2hYUnJMeVZp?=
 =?utf-8?B?akxNMzAzNDBwa2dsdHpLbkFyUDJjeFNtT0kxeGQ4Y1ozK2M1bXVteXQyZUl6?=
 =?utf-8?B?bFlMQjNkek9Ya3diSGNraHBHcTdiWjJPQ3Npck82WUJ0UHZTa29JWlRzK1JS?=
 =?utf-8?B?V2UzcERJQnFSUFp6RTJWVjViZUNMeFNXa1JwbndlTTdZUjg4dDFJaXAyQTZO?=
 =?utf-8?B?ZlBNUU1CQnR5bkY2TkpJN2xjd1l1NzNEK295YmlKYTdXMDJiTm1zOEpHMHNq?=
 =?utf-8?B?M2hnZm5USnh6bEozSDFxR1JnUi9Cb1BsdHNXTlh5bFM3eXZhdGttMllEMnVM?=
 =?utf-8?B?cFc1S2JNOXVvR2k1SUxUUEw2UXcyMk1uMEtPRjFwUTVZaDcwYllDazg4T2Ri?=
 =?utf-8?B?alZMa3dtbGVzNXRhSEJCREJUTVFrek9xSGQvOSsva3JSV1Z2c0w2SlZBQ3JF?=
 =?utf-8?B?ODN6ODhpRzBTeU5VWnVqVmtyTWg2UXJZREFRQlAwSTYxQU4zMUxFZlpJZHZ2?=
 =?utf-8?B?NEx4YW9EQlptUzY1SVhIQjRTRzgvWE15MU5KeE96L0l0Z0M3NyswZEFGNGpD?=
 =?utf-8?B?WFlKZHNZMURxWXdsejg1MTFuUDNLSjdoZDVKbndPb2YvcnpJU1F1Q1pma0RO?=
 =?utf-8?B?cE5HNXAzVkMyL2RxQmtxM2p6MitQVm80MTFtNTdZYlhELys4NUd2QXlRaTly?=
 =?utf-8?B?dVdVam1vam1Da1l1Ry9NMzhkck43b0pEWHZLaW5mckQvQ2NzbDJ2bFB5M05n?=
 =?utf-8?B?R3hoZmQzZWkxaHpXRXF6WlNhOVFvOEV1RytvWGVTSld4YjlCQkpFWmgxN1Er?=
 =?utf-8?B?VjhVdjdkTHpKeVpZWGNSbjFxTVQ5NTNlWWsyeFY5ZFRwVVdJNjJRaUxnUThB?=
 =?utf-8?B?Q3l0MFRlTU1UT3lMbHFLZWNuazdBOXppYmlnRGc0dWNZaEFndXFnYXd0REhQ?=
 =?utf-8?B?K1ZPV0N1YkJCMEUxbCttM0tCN0NoMGNKcXQwcm1sQTI1UVFSUTdoVnlmMU0z?=
 =?utf-8?B?cGcyRGhpczBrTnJGUEU2TCtLb0lJMmFJUVZxcTRYazFjTzBNVlJwenFGK0xI?=
 =?utf-8?B?STRhVnJLRXlEWkFFTFQzMEpQUW1mbXo0bkxNc3d0N1pxQldhcU1yQmg5ajRj?=
 =?utf-8?B?ZG00RUdGMWVNRTNzWHhiZlJoeUxNREYwbGcyMWJiWm9CblVaT0d5NjdSZVVt?=
 =?utf-8?B?QWc4NWhYYkhtQ1RQSDdaUHpTNlYxNXJTOUs0REJXb1JqNlVUK3Fmb1hiUVBp?=
 =?utf-8?B?bXQ3dXBORXMwRmI4NnQ1NjVDSXowVncvWW5PaVAxNmZnaGRvMzJVRUQvYXli?=
 =?utf-8?B?bm0rdUVzNExvVldNamxNVHB6Qy8xL3daalkwZ2xGNTd6Y3R0TmIvOHJmWFJx?=
 =?utf-8?B?OGNCaEZSbWZxN3R5NnZUNm1HN25nTkt3VnNZRmk4cUFLRHF1bExIYTg5dmZl?=
 =?utf-8?B?WVhhUWV1U2xxVTBsK21yM1E2c2JqTzBkODI1ajRmdytKcTUrd1V0Y0l1dU5B?=
 =?utf-8?B?THdVTzNiSUdVWm8wOFI2cGwybEErRmt5ZlVPWGlKTjNFRFhLWGNpUUxhWGEr?=
 =?utf-8?B?d0JSemJlRVRCQVFzRGdMTEFHNTYwZ0lvQVVKd0cwMDNhR0NZbHhhVjdWKzlT?=
 =?utf-8?B?RmR0U3VPaFRDVkg1c1NvZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ZBSng2WTExWTl1WnpuT25CL2FOQmdqQ2JFVGpuNEVjamErSG1JcGlPM0h5?=
 =?utf-8?B?QmhzL1gvNU1CUUZycDcxa2JNT2REbGIzWmdWNzAyRkRwWGl1NnQvNEVTUkw3?=
 =?utf-8?B?MUcyWkkxOWdlQ1ZPbXNHcWFTeDNuUEJlNWp6V1k3NTBpYlM3c21vWUl5NTB3?=
 =?utf-8?B?S0dlU09TcWRqbUdMNjg4dkJpeHBua0lFeVhUZU14Y0NMUW1SbCtyQWhXUmdB?=
 =?utf-8?B?Ynh5MFA3SEZPTDhIbjEwcE1tcG1kRE9EeEtvaFl6SjR3eWk0VmVpdjB0eVc4?=
 =?utf-8?B?NWFqclBkNzYwRXBPelFCamJmZGFDQnBSSjRMTjBkRy9sL2IwL01IdnNza2Ja?=
 =?utf-8?B?MTVaYXhmRmhkbVpsVlJrOFlzSSt3aWNIVndndStWbk5iR0lvSE5SMUZ6Ykxo?=
 =?utf-8?B?Zk1icHN2K0NLbm4xNEQ5NXBBZERKTTNPRmlPREp4Q2V6YmVGREdwR2s3YlQ0?=
 =?utf-8?B?QUdpcWJRUGQ0VzRRL2RwOE9ZeVcrenNheG1YRko2UXBNbXVmWGdSM0l5WGN2?=
 =?utf-8?B?b2ZybE5xbDRpR1NUMzM0N3lWYy94RFJ4aStYbHFvZk9ZendpR2t3YWY2S2dR?=
 =?utf-8?B?eVFOS2tMZUZ6VlNpc1h0ak50NFNFTEZoVExQYVE0dkpYWXNCdldyNjN2MGpk?=
 =?utf-8?B?YmhIamlISkFtb1FLcDZjaTE0V0VrNE5rK2QyT044MTcvaG9OZGFhVU9CdVUr?=
 =?utf-8?B?QlQ4N25DRXQ1ZFdCeHRnZndhYmg0K3ZrSkRjQXMxcHZmbmdmS0trWUhuVURN?=
 =?utf-8?B?NXBTOE02QmFnQmd6ZHM4KzVudXVEWUYzTVp0WHl0aEUybHhoYkRCcDZTMkp1?=
 =?utf-8?B?UUE4UkIvcVlZOVJZOWlLN0FjalArbzdRN3M4RlQzWTZYMWdmT3ZMamZ0VEd4?=
 =?utf-8?B?djYrelBVZS9ia0YxcTRrend3clh5dU5zazg0aEo0RjVYeWZhblpFbGZRSEw2?=
 =?utf-8?B?ZUJ4bWxiZ3dIWDBicTV0ZHQzMERaN3VTNm1UbWUrb2xva0x4dXByUVF1RXdy?=
 =?utf-8?B?YXhUbWlyV3Q1OVlzUHBBd29jbGxCeWthL01JUGZiVEpKTDVpZ2czQ2NWNmRP?=
 =?utf-8?B?RWg0VlAyZERiK2FQemo1c3AwZUlYbDAxQ3FjMGJSUTVCM2o0dmpwandnSGZk?=
 =?utf-8?B?UmY1ZXF0Z2hYSXB5VnN1Q0hRYU1FNU9aWHFBK1hMMG9uMHhFSzZ6UDUvL2Jt?=
 =?utf-8?B?eURYOHJ3SHVYdXVTdk8wQzEwN3diclM2YlV2a0taNGxCOEZqYXN4UXpkSkln?=
 =?utf-8?B?Ni9PTVI1aE9kaW5ZRjNvS1JudkorTGxPcHZIZnZLcnZ2c1JxdTJ4M3NwSUp4?=
 =?utf-8?B?SjZ5cWJWNzhDT0ZFVlExb0pBUFRpTkk2QW40K0Z4bVNuR1ZVRG1CTU8yTGlE?=
 =?utf-8?B?N3JwUHdnc1pkTzVUTW51d3l0dzV4YUJId2t3WWo1S3ErT29yQWE4UXhwT0RT?=
 =?utf-8?B?S1YrNmVEbDBkcTVhM1J5M2F6dXlCbmpFVkJRb05HRC9ldWFvZkZTOSt4L3J1?=
 =?utf-8?B?cDJLVkJndFFWS3ZqOVA4cWJwcWZQVlR6Y2JQY2hpdmVEbGx0MUxsRlVpUXJZ?=
 =?utf-8?B?TnhobjZnUVMvMWE4b1lGeklvZTBOUG5iS0pVOE5BZXhpN1lQdWFLS3NBZ0tQ?=
 =?utf-8?B?U1lxKzMzUXYyN0R1NDhaMDNjYnV5ZDFDbkQ4dC92LzQvdjVjdm1nZXJIa0N5?=
 =?utf-8?B?STdyM2FQcHdicmI2NEs5NE9lMWlLakttd3FZNlhrcGZ6NzRycDZwbmVmWFor?=
 =?utf-8?B?UWxXZEw1WTlvN2NjRmRWMHdlWVdiZmVrWGJiWkJ6OGdzeW5YWmxtVHVScjZa?=
 =?utf-8?B?UDlReFcvUGVWN2U4TEFvaGlCVFRGYjdPVmVEYU1XQi9aQ25wVjExV2hzMVhP?=
 =?utf-8?B?S3FGRmJzZXlYbHNTUDl1TE4xWWYxaTNNTUhVbFZzRXJ4K1hKR1YwZXBUeXpL?=
 =?utf-8?B?SDQxdjFGUW04Y2p2anN0Q1Z5WVhPU0FKU3IzRGI4WlRuWDZYOHZhS2FlNG5W?=
 =?utf-8?B?SzJiUDk3aEhhcEpEVDkyckZENUZJRXkrMTN2UTlvK2dxcFBkNWo3RDV0RnBL?=
 =?utf-8?B?QVZsRkYxRTFLNGpOS2x5NE9PWWhWcGF4V2JQRFYvWUk3UzdoRTN3cHl3N0h6?=
 =?utf-8?B?MGRRVE9wMHljK011KzFwQkVwVW5UUFMxbEo1TVM4YnRxek5CUlNpU2d2RW1n?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d57384d-ebf6-421c-d161-08dccb2d4440
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:57:26.5449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EXxBw4WE5CA1XRCTKbE15UleQvfKico3lJHmzGOx/sbyJ6Yqa7qEsGl7BXtARwITtTNkgnLvSqsObx2/rxlonOWdTzDTcPWxyfAXmtEmasU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9018
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

Hi Simon,

On 8/30/24 3:06 AM, Simon Glass wrote:
> Hi Tom,
> 
> On Tue, 27 Aug 2024 at 15:43, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Tue, Aug 27, 2024 at 01:24:59PM -0600, Simon Glass wrote:
>>> Hi Tom,
>>>
>>> On Tue, 27 Aug 2024 at 10:50, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Sun, Aug 25, 2024 at 07:07:23AM -0600, Simon Glass wrote:
>>>>
>>>>> Hi,
>>>>>
>>>>> We have the term 'SPL', which has a dual meaning. It is both a
>>>>> particular phase of U-Boot (the one that loads U-Boot proper) and a
>>>>> generic name for any pre-proper phase.
>>>>>
>>>>> You can see that in a few areas, but for example CONFIG_SPL_BUILD is
>>>>> enabled for TPL and VPL builds, not just SPL.
>>>>>
>>>>> I propose to rename the generic term from SPL to xPL (meaning any PL
>>>>> phase), leaving SPL to just refer to the phase before U-Boot proper.
>>>>>
>>>>> The symbol would be CONFIG_XPL but in documentation we would talk of
>>>>> xPL, with a lower-case X, so it is more obvious that it refers to any
>>>>> phase.
>>>>>
>>>>> What do you think?
>>>>
>>>> I still worry this is just another part of the long symptom of needing
>>>> to re-work how we configure / build as we have 1 case of "build things
>>>> this way" (full U-Boot) and N cases of "build things another way" (SPL,
>>>> TPL, VPL, UPL?). And really we need a way to short-hand
>>>> "fooboard_defconfig" means "fooboard_spl_defconfig +
>>>> fooboard_tpl_defconfig + fooboard_SOMETHING_defconfig".
>>>
>>> IMO my XPL series does this, at least for some definition of this. I'd
>>> really like to get that in as it would make all of this much easier.
>>
>> Yeah, what I recall of your XPL series was that it made a lot of changes
>> I didn't like and highlighted what I thought was that yes, really
>> Yamada-san was right all along and we need a different way of
>> configuring + building.
>>
>> I had even today thought that we could possibly
>> get away with some shorthand where if for "fooboard_defconfig" we _also_
>> had "fooboard_spl_defconfig" we knew to build in ${O}/spl/ the spl
>> variant. It would be harder for cases where we have "fooboard_defconfig"
>> and "fooboard_hs_defconfig" that both need "fooboard_spl_defconfig", but
>> it would cover many cases at least. Anyhow...
> 
> We should discuss this sometime as it has come up once or twice
> before. Given the dependencies between XPL and proper and don't think
> we can sensible split into separate files, let alone separate the
> Kconfig. In fact I still believe that we need a small Kconfig-language
> addition to support this sort of thing and avoid duplicating the rules
> everywhere*. I believe I might have even done a patch for it. We got

I thought about this already, one of the issues being that it is not 
guaranteed that the dependencies for a symbol for xPL will be the same 
for yPL nor for proper, so we still need a way to override those from a 
redefinition of the symbol (or any other mechanism). I may misremember 
but I think one of the most straightforward issue was that most (all) 
proper have DM support while xPL do not necessarily have to (and there 
usually is the xPL loaded by BootROM, limited by SRAM size, that does 
not have DM support).

But this has been a big pain of mine, with proper symbols usually being 
properly configured wrt dependencies and Makefile, but a lot of corner 
cases missed for xPL, especially wrt Make rules.

FWIW, I've always been confused by CONFIG_SPL_BUILD not being for SPL 
but anything !proper (to the point I always have to check whenever I see 
this symbol).

Cheers,
Quentin
