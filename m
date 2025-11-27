Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BABCFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 07:41:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 897E584307;
	Thu, 27 Nov 2025 08:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="eXMvo/qk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C658884308; Thu, 27 Nov 2025 08:41:10 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA5483923
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:41:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMOkIae23F5FClwdib4/SMF7uINPENi0sxcLEdakZmwD603PzAnAJgL8f410YTqclEXoxzuPNq958aRky1zcsazkXYPZ7OkioHr5tgN1UW9pe7pFu8ZOLr2uvfjDiP4q1m5cUMMat5H7QjiQNwy2iasrIjtLRZexJJe/Fsc6Gr11voAZYmHWnQb00OAFsjWYMydpujwfRw6C9NnkHSt4Wqv0/i19e9VikGd62o5KR3o5ns9p1zMcOfSZTVWH26CzuzVnhFUXaJY/KBLmhWB5ZNFEaCR1SbM/ccbfrQxquuC+ZgdLZXjm+zuZeKsIdxDVRFjTyyWDitDD+FwowDJeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjQSH0ocW0Gdb298KjoiNL2q7hYWSoU/o8Ep2pOesvg=;
 b=sH0m67KRi823fgxT1+8V5MJ5krMgA/eNCuey6riY0/xfv7fKXUZfXK5vMimezyYBaTUiChLLFEkjNrVbz+ZlLHiAlriM1aDjCDDs/ieIy7Ol8u4qnRQfDqzqXhj3PyDcQ3GAe+JD68knf7zCKr4/2hsQt/zaf6LBNb4pxEyFj1d6ul+fV9jEFuF4RC8rCo0/jTJWsQqHIKBQdHzBGPhgQDUOi/2Z3joEpRFZCXralFi9BB5xFE2qWR9gfPvkWKwDXpTWA+wkH1l172Ygj5zZUqx5cCn6iQ7jEcn89YKYBnBknDEtV9SZHZqWmhsCZryy0OJ+HbqMcTqNNwMUEMQmGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjQSH0ocW0Gdb298KjoiNL2q7hYWSoU/o8Ep2pOesvg=;
 b=eXMvo/qknC6tSvFVUUOz65oVWBKVSkLU2JKATsrApeaIJD1q9KbHPTVeKTYdLScN6gEgullV0p9gWTWOQRfDqkktmOYLM6ePSV0/CsvJR+zpZ83tjgPaF0HifwzeY1VTOABVmZyiGAMKD2CHoO4uN6hPSK8E0kDwvBhrs1lzH7gAG6FRagsuq25qiaNDstUuRTdiMc58xPP4ov9v7E8InLIO3AonvklktnkxOQ3oSn/YBSZTmwXXk7WNMObpA5HZUVkxJtXBSLIToigstMUQx6cCGEzWMKGoZF9H74ehueNIsb8lPrchpqi6CLebxiUV0rya7f7xqldP/BfGD4dlAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 07:41:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 07:41:06 +0000
Message-ID: <93dd7ec3-a681-49f8-8072-3f986e97561b@siemens.com>
Date: Thu, 27 Nov 2025 08:41:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] spl: mmc: Respect sector value passed to
 mmc_load_image_raw_partition
To: Marek Vasut <marek.vasut@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <28ff4f1c094e15ef1f301bcbf409ef628c9cca91.1763140421.git.jan.kiszka@siemens.com>
 <bb6bf23b-c036-4d6e-b55b-02b55b37e740@mailbox.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <bb6bf23b-c036-4d6e-b55b-02b55b37e740@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dd997e-d7e7-4101-c381-08de2d8852ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWx3RkY1WUc2anh4RHRweGhUZ3JoVEpweUlpZ3l4dmRBeXpsZE1aNWp0OFlu?=
 =?utf-8?B?eU01R1NZZGE4Y0RkSHpNWFVXY3gzaldYQ3haenNSdlVlano3YUNnOFA1WVcw?=
 =?utf-8?B?NFQ2US9vZGNJblN0aVpnL2FDcldaZi9kWDI5d3lxeDhNK1lmNEN4UHZHRFVu?=
 =?utf-8?B?aEdQOGVvU3YybzF2OXoyVzJHUUI2bkpHUWZXQ0daNlZnUHlKc3orVVBrQ1Nr?=
 =?utf-8?B?aE5odlBHc25xMEQxUFpleWNCY0cvR3BpelJGY3VLakhkUUp0eFdlNFliREtH?=
 =?utf-8?B?REFTUTJ5R2w2QklIcUdxSVR1Q1JOTnNHdFBrTjlHL0hZRWpjM1cxRm1paFdH?=
 =?utf-8?B?TURHRk5qS0pQeU4vc2p1N0w0bjlmbTBqOFNqNUZYVW9oMTRVcDY0Tk0wVE94?=
 =?utf-8?B?VjFrZlpUZ0tsZ2ZNQ2dnYVFqNHZQMitXd3ZEMWJ3Y2dPNmVBamJ6M0UwNUlw?=
 =?utf-8?B?ZGw3ZlhFeExBZEtUUGdKbWRQUWc1RG5yazRhMy85UnZHb25GckdOb09IeDRO?=
 =?utf-8?B?UFdyU3ZJL0Z0L1VoMkZKZ2wvRUtOWDZBazBXZmZzaDByQ2IrL0xINjhndEZO?=
 =?utf-8?B?anY3Q2ZxZ0lRUllkTElBa2FrNmM0ZER0T09ndUhacEt0ckZvQTVJWW9iVDBM?=
 =?utf-8?B?QWRoZVNTYklEc1lpdDc3SU5Hem1reVBTQ3EwQ3k1Ti95VzUxZlZsYXNBaHZO?=
 =?utf-8?B?aHgyaDhsbEFPOXNBdGFqSmhxUDhJa3ZrcVE0dzcyU2lvZGN3YWczbjN4eGVv?=
 =?utf-8?B?QWtLaTJoZTJNZGlxWUs0YWI0bXRLaTlqM1Y2RHBkcnNKcERaMHE4T1lRVi9V?=
 =?utf-8?B?SGlkU1BsUmR6cnUvOXRVaXQ3d1FrT0xoR0k2Z1Q0MFdBZE9vbmd5Ni9XL0Zy?=
 =?utf-8?B?dWczZjhHblZpQnNYR3kwUHdSQ1k0bkhDa2RkVVlXUTNqd3l5UU5NZTdhUjhT?=
 =?utf-8?B?eSszK2RtdHlMOXlqcTgySlVCa1MrUXp0VGtIQjltTEhVaHc3OXZHWFozVmJQ?=
 =?utf-8?B?azFkRmtmaGRjeE1nY3lIOEFjcW9GM2Y2UTNlNElrMFdsWjFYRDZoLzVkZmVK?=
 =?utf-8?B?ZnF3amJrcDZQQm9nNzRERFR1Vjg2b29lNThzSlFrSmh2ekVXTmFqMVRvL2w1?=
 =?utf-8?B?ZkZrRHlDd3c1NzJSbnFmYmtraTRwTjZtQ1lXSDlmV2NWZmhiUnIxZWg0d0l6?=
 =?utf-8?B?UWkvb3FONHlMOTMyNDZCU0xIRkZIVnF1OTVIRmNQaTloUzlOQVlsNDlOZ1Jx?=
 =?utf-8?B?K3lFSERyalVWVDBVOWhmWFFFRmtWZEpudzZXZG5BeW51d05hdVM5R1QvOEZL?=
 =?utf-8?B?NnFpZmJ5b2ZhUTdnSjV5L1J4cDhEUzlpVDlEOXBNOWtaUlhUWm1vOEVUci9r?=
 =?utf-8?B?dS85dHlLdzVCdVJwUEo1KzZDMjJkZXR2c2FoTklyaEFid081d2dGTFFMVEJG?=
 =?utf-8?B?UCs2WjNVZ0dORG9jN2o2Qys2bHRBOExRNVlIa3RRbGR1azl3RlY5NElTOCsx?=
 =?utf-8?B?UU12RHRHeld3MlpuU3BZVS91QVZ0YmlNVDNReFR5bGozcHNVaUhDWFdiRVpn?=
 =?utf-8?B?a1Q1KzVYV3lmOVJSVGxDdFRTajBnZ3VVOGlueW84TlhONDJab0JTRVNIKzds?=
 =?utf-8?B?L1RTbHFjQ2RPTEduNWN5YU5SLzY2NU53eVN4MzYwUWd2Z3BYWnZ6djloMysr?=
 =?utf-8?B?TFVIRXAxWW8vREN4Smx5b1J5Mlp3NlFpYmM4VlFyZlNtNmRQVmlGYWM0OUtP?=
 =?utf-8?B?OUVqTGh1am1TYjExRXNLbEJ6WWZoRlp1bXBSVS9yT0hnbzBRN2FVZjNUK2pp?=
 =?utf-8?B?dmltbkJDRFdiems3cThqWXBiYUhYUVQ5c1J0bTZnMWVWTGdJeEJyS0xxcDNk?=
 =?utf-8?B?clRsWUcrR0drM01qS3grTkFqSFdIVkdnM1h0MXZDU1NORGR2TmFPTnMvZkJK?=
 =?utf-8?Q?Z7ZtRuzzbIwR7prdAL4WWc8fUd/3cb1p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnpXNm9JVERRMU1HTXBUZTM0cUdyMTBWN0FoOHgveTBiVXltTExPcEFiU0pQ?=
 =?utf-8?B?aDBFR0NqSW84alV5cElKYWhiMUdHQm5SdjljWlJxTEsyK0wrR09FQkcyNTBE?=
 =?utf-8?B?T3dzemZaR1UzM0dqdVNQd3NZU1FadDJ5b0doaWRJSVFYSUtxTWFGYXFQL1VU?=
 =?utf-8?B?N3FWUkVHUEdiRTVMK0E3d3NIdDVXK0E4My9LbEFabENWZlFyaXpnZk1CaHJS?=
 =?utf-8?B?NGlPQktsZnZuQTFPSU1UbDY4UGUzYURybFUyODdMOGxaWGRjdllIVGtNR0kz?=
 =?utf-8?B?Z0dYZDVxNnFITUE4K0NJM1VjUWs1RGllaVBEZVdHK2NTUy9nbTdCaFh2cmRB?=
 =?utf-8?B?enVVaEUyZHBZdVM3dk8rMG5rdmtBTUd1WkR4Z2lPWG11cFBhcE80dmlJU2Rr?=
 =?utf-8?B?UFQxZnlQdVVTMVZaRm1pL21HekZNOHcrejlpY2FMZE40RUFlandwcnl5QTBE?=
 =?utf-8?B?cmpHck9xSUxhZ3RCSit2ZVMxdDVrb3QyeGhvNk9oZDFLUzhDYzQzVjVidmI1?=
 =?utf-8?B?S21VVWV2bmkrelJtTjBmYkdCb2ZSWjA0TFl1VHFnY0hzdXUrVDV4d1RibHVn?=
 =?utf-8?B?aTdRL3lNRVVPcUpBRjJxRi8rNWxJTkZLOWJmbmtmaXNkaDBRTHZYeUdyV2xa?=
 =?utf-8?B?SXBHdkJHSjN1d0tOWWN0WWx0bzZNczEvWU1zOTZWR3IwcHczSEswV0dvTXFH?=
 =?utf-8?B?eXBxaDRkZVJ5b1Rab1RHWnVKWDlRa2gvT2VOcWdXcmVZZnQydnN1NUxWVUxQ?=
 =?utf-8?B?aWFvSmtuMWZQUThNM0ZzU0plaU5zeDdpWldsdlg1a1pDcHByZ3FiWHdQMHZp?=
 =?utf-8?B?dFJXcVhBN3pTeU1aSGRpMnhzUktNK2hZUUNrK1NRUFFFTTh3V1cxdkNpM2JW?=
 =?utf-8?B?WW1ZS3JIelpyY0hhdzIyVTVNNVRuTzBVMXpNejFNblRYUlF6RUZucnc3Vlhw?=
 =?utf-8?B?T1ZLU0JLRzB0cmUxWXFTeVp6UGdTTlNZRWdKSnRVdlo2Z0dNVUFFcmthLzVN?=
 =?utf-8?B?VVpaV1dTWTErZEFIcmpoZjM5aUNZTTROdUxNNVRMOVpnajQ4VUh2KzdvK09J?=
 =?utf-8?B?djN2a2lrWkdnQnRvc0YvWTlJSzBtSWtUaDZVaXBsc084T3p5clk4L3lWR0t0?=
 =?utf-8?B?VHFrdXhDa2V4MitnWS9VWG5QVmZCdWFCeW1KZkxDS20vNjVsYS84WjUydVpR?=
 =?utf-8?B?Z2tDbys2VlJweUdkWXRlTlVXNEtQSENJbCs4Q3F4MEh5MEVza2w2OEs4RUts?=
 =?utf-8?B?TEFCYXpTYzN3NFp6Y3dydVdvdzBYQUhVeDVRbCtEUU9lUmhlSHB0cGZFTkZG?=
 =?utf-8?B?SGpDQVpMQkg2YWxlQ0tQc3YrS0QyWnFHZVRSOTJnNkRLdnRzRis0a2Q1bmgy?=
 =?utf-8?B?UlpmVkVwaUJjMmZvZWxBL0lldzVXbnBLdHBZUldRL1VQZzdtWFpRVmNqQTVl?=
 =?utf-8?B?UWEvWEFiTW1SQ3ZaZ2lmZUtZY21BK2xjQW9uaWZGVFUxMlkwNU50dVUvOTFO?=
 =?utf-8?B?Y0kyUFAvUC9yc0dSUTl5b3VrVmpsYm9aVittVEF2UVFYM1hFcWcyYTJLQXBH?=
 =?utf-8?B?VjM1V3E1K2pWUGd6RjY0ZFU3RGVNd25BakhQYW5OZTFIcUIxcW1MTGNtTVJx?=
 =?utf-8?B?OFd0eW50S1p6Lzh0WHNHV2RvWjhwa0lzN3RCNXZpZndhUVdub0phVVY3V1Yx?=
 =?utf-8?B?T1VvWFRzckd5YVZTbHVueEIwODZhU2haRmYycXd3dERkRjdzNGtBSTVHRmN6?=
 =?utf-8?B?UnhYOTVYSGFFWXZJWGROcEpqUzViZ3RQNHA4YXlKSlF2L1pyVXBTd0YyWDN3?=
 =?utf-8?B?dVllZVVzWDJrUnQxRDV1TEROM1k1dklEcnlLWkttZlJ5RHUydzVPZjUycjQr?=
 =?utf-8?B?SjFDeWQ2c2tQYjBDcFh1ci9zdUk0VktQazNiUStCM3VESktiYXZwVlo1c3pG?=
 =?utf-8?B?b0FtdktLbzFaYTZPK1pOOHJUUHRGcUVLTjhZYnJUcFFrR2Zrd2ttbTFPWGVT?=
 =?utf-8?B?WjVmUjZ0M1RVV3F1Z1cwZzREcjRWUkgxVTN3Ymp6bENtOGJGV3ZBdEZ2ZlNy?=
 =?utf-8?B?aGowdEZQL016R002dUZIRUF1MkFCOVJxdFRhb2l6Y2VVc3pQS3JMaWJQVEt0?=
 =?utf-8?B?VjlpUmxWaVl4dU5xdWxSUUt3U0RnelNzbEpjd1I2WjZscnVuaVhmRWlKdSsw?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dd997e-d7e7-4101-c381-08de2d8852ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 07:41:06.4823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNJVVepkmgsey48zFLqtURNMnNe30o5yAaMpOblh0gnSZxzVt6zSIerWL0l2Mpr4cIM/f6nm3XnW06G8F++34w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4068
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

On 25.11.25 13:16, Marek Vasut wrote:
> On 11/14/25 6:13 PM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This function and the sector parameter evolved over the time. By now,
>> sector is influenced by spl_mmc_get_uboot_raw_sector which allows to
>> adjust the read sector with an offset that U-Boot proper may have inside
>> the partition. That used to work by chance if both
>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR and
>> CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION were enabled. Since
>> 2a00d73d081a they are a choice, and we need to drop the condition to
>> maintain this feature.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>   common/spl/spl_mmc.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
>> index d8ce3a84614..467114f8d9a 100644
>> --- a/common/spl/spl_mmc.c
>> +++ b/common/spl/spl_mmc.c
>> @@ -136,11 +136,7 @@ static int mmc_load_image_raw_partition(struct
>> spl_image_info *spl_image,
>>           return ret;
>>       }
>>   -#ifdef CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>>       return mmc_load_image_raw_sector(spl_image, bootdev, mmc,
>> info.start + sector);
>> -#else
>> -    return mmc_load_image_raw_sector(spl_image, bootdev, mmc,
>> info.start);
>> -#endif
> 
> Could it be, that what you need are two Kconfig options -- one sector
> offset for raw mode (default to 0) and one sector offset for partition
> (default to 0) ?

As the modes are now exclusive-or, I don't see that need. You configure
an offset, and that is relative to the different baselines. But use
sector mode only makes sense when a romloader forces you to hard offset
anyway. The SOCFPGA uses magic partitions, thus does not come with such
a limitation.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
