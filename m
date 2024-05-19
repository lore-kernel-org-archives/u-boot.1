Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A7FC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 19:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEADC880FB;
	Sun, 19 May 2024 21:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="aaSXHKPC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BDA18817C; Sun, 19 May 2024 21:44:18 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B48C880FB
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 21:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeZ3KKeDl2VLIOyfGACvGbUcZknTSX5gyx/zr+V4BkGmdfYMIQdSWW2FHOMwhsEqrui4f+t+QrY8w27kAqSQLcdUjtMo19FqpSqPVN82yxYO2cWuN2ILU0/mbjYU+uLDxRSasSXE4X/xOl5fCy3eaJ6C00h/lE+W3URymO/6QQ4gJGU+01U7tYVT2ERp8tAL+a4V1pRJepda+G4IA3AdH2MSa4nXw256Laak+xGlW8iDNC7LeCOTfF2lPqL9qnfsqDtx1ga8mqP3qbBBPAlHyTJ+xcVsBuWER2zH6zo0Zt/hM3sPpUgogw9N5U10duD8yNgXjEqB72bNvypFG2VwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYNVXMPzSlSp3RTzJPcu693+Ql5xgOJsLPX5KGXBk3E=;
 b=KONH2UOLkS4eY4T8L5L0Pvpo2khvhDh8z2bpQg3OyvIc7xGDGUY+cJ2OKDrzsHjb8wbgmxX2jejUvNhZNx0h0ul5c1LoPA8Ka6CkjbC/EHgT75baM5HK+awJE9wwLEBnAjJ0RejeMKFYCZbEuXIY8Nmm4/fdLTvh14huGj0naFS1jPpaCBE5T9ieEI8a/M3SKgqbH4LBOfh04IbxU0ZI2UcecA+a5mfmz7Bhx0owzfOom7nm0iuC4L4ylkqECwE/rok9t4Yy0yEBU51x3cjYD9YhpTO2vMPqg+FSiZS2TfVMvxwiEGNz42AFlKZF/gXnohZJHsx6AyyLKHgowI5Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYNVXMPzSlSp3RTzJPcu693+Ql5xgOJsLPX5KGXBk3E=;
 b=aaSXHKPC0XESYc1Tzg8FgvNnWGG4eHo8l4QUXUz23lltz8d603lzIwA8zzAPzAKOT9Vg4YqsFpTtIFV0069T0nuLSTf6IP8ZMSwUdJ5w01Ex/wc7QkFEYv3neXJ94dcz+eVhsjmiU8Lo07JIZ+Bk40WnRrDtnXfOxZdDN9KHooI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by GVXPR10MB8899.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 19:44:12 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 19:44:12 +0000
Message-ID: <948d94a1-e97b-460d-8c83-4133eaebd2ff@prevas.dk>
Date: Sun, 19 May 2024 21:44:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cyclic: make clients embed a struct cyclic_info in
 their own data structure
To: Stefan Roese <sr@denx.de>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240516075314.1548051-1-rasmus.villemoes@prevas.dk>
 <20240516075314.1548051-4-rasmus.villemoes@prevas.dk>
 <7f45eeed-4bcd-4a3a-9663-133a20c182f7@denx.de>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <7f45eeed-4bcd-4a3a-9663-133a20c182f7@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0102.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::23) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|GVXPR10MB8899:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a6d7e1-7272-401e-2265-08dc783c0ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0dnTXhrUUhsMWFTK243TnJSbW55aE4xVTdYN3VaUGFrR1MySUNBWjNRU0RQ?=
 =?utf-8?B?Q3RPeVRxTlFIYkE2Tks3QzFMVVdpdTZQcHVUK2o5RjhEMHJGU3lSSERFUllp?=
 =?utf-8?B?UjRvMTZoQVJpZjN5dEgrTXQ1NHlYbjdCdEozWjEzSEpBcTBITnQybGxXa3Nx?=
 =?utf-8?B?c0J3YWt3aU9lZlpzZ01oMWZpVko5NWNpUXlndklaa0lJTWxKdWxVNTdZUUNN?=
 =?utf-8?B?Qkh6RStzMHdFcmR0VUdpbWIwQUxmQVpIcG5wWFM1eE5TcGdqT3Mvd3hYMllJ?=
 =?utf-8?B?ZytQaDNNa2tTQ2hyb0RFa3Q2YUpBZWkvZ2Q1MzgwbElmZW1BYkZDMmU4elFQ?=
 =?utf-8?B?WnQ4TlFLQllNZVpHajFOaVdSck0zT3JWdTdmeHh3WkV1TlpyS1l4d0FLZnpR?=
 =?utf-8?B?NE9HNWxOWXA5c2NEYkZFVTdLMXpNSXl1UmRVT0lFL1hRM000OC9RSkVQbUVq?=
 =?utf-8?B?OUx4VVA3UVFNd2JrSUFyYU95SElUcE93am45cmkrcUg1MnRmd2dQRGFXcDhI?=
 =?utf-8?B?UTJYRjI3d2UzUHdWZnlvWXdhTkNqNVYwQnBGcmRNWFpSWTh0bE82MUorZ0U3?=
 =?utf-8?B?UU9ZTisrblc4TDRRclN0L2UvUktBeXE4K2RRc0hwdlU1dEU4eElSeTZ0UnBD?=
 =?utf-8?B?ZThiUXEwdG5hcUorclFsYXhQek1idlRIZTh5YmpHL2VLYzJNeGU3WkZ0Wm0r?=
 =?utf-8?B?QWtBaWpFejZuY0t0RnR2QVVISXpzejh4U3p5cVpSZWNJNk5zZjdvdExRS055?=
 =?utf-8?B?ZjhONFpEcUx1NkN2NWdoSFBLVXkrOW05ZGlTeHZteWh5aEl0R3hkbFNKWjc5?=
 =?utf-8?B?V2RWT3RoVjBVQ1Y1TFFiVXNqK0ZDQy9rY0hmWEEzY3VrMU0ydkczQVlhV0M3?=
 =?utf-8?B?ZEF4SVA4Ym50MjJNSDRkVEtrdWJNK2R4aW1JOHFYRE1nZ2IrRmdNRzdCdlIw?=
 =?utf-8?B?L2xlK0RsaTFiSlZ3ZDdBYWQ2R2VKVFhqZGdXeW1wZGsvbHl6TGVzQzRnRXox?=
 =?utf-8?B?c1pvVHhIUHMybVBEQ1R2TmUzVGpURzhLNVMrSTVkU2djWnNvamFVKzM5bjJI?=
 =?utf-8?B?Nmx5N3ViUk5zVXhzTkdRUU9udFNBSXpVN2Y0MUNuTVhjbE1NaXZUYmJJRVR2?=
 =?utf-8?B?cXZ2UjlCRzhSRmFNUmRUQitVQTNMamp4S3grSDg3ZmI0Z3JaRDBCKzJ4QVVS?=
 =?utf-8?B?MHNBK1U3NUh0SGdER2trSFRydE1FSFBUZWhmallZaDhKQVdjaXpCYjNkUjNt?=
 =?utf-8?B?TUlza2R0ME9DTkV3dkQvQXdjYVpqQlRjbjA1bEY1VHRzY2pncDU2NFIvb2xB?=
 =?utf-8?B?TkVWM3dDMTRUTElQWlludlJRT28yL29Kcy9ENEQyVlU1dlltZThoaW0zVVMy?=
 =?utf-8?B?b09NekJUZjJOcndIN245Yk5rQWt0dVhPOFd1eVB0MWlZOHRtMEt5RXI2KzZz?=
 =?utf-8?B?TFF1UjhXZWpzcnVkUktYV1gxNHo2aTlRQjlpM2VwYU1kUDBMUndlV1gveGdj?=
 =?utf-8?B?aXIwczJSQUNkOXF2elNjc1NrRXR6Vk1uY0ZQUnpCamhCWDVXc096V0twQ3BT?=
 =?utf-8?B?Y0ZxQ0R5VkFwcytSeDRGZVhhNklDeit1ZkVBWUJObDRLejRLbUpKT2pBbTB3?=
 =?utf-8?B?M3Bxb1AvcEx1Mzg5YkRLYkRxaFF4WldJU3hKeGpRSTYwOHdNSkcxc3RnOFFI?=
 =?utf-8?B?N1dDQ2M5NytlTkdrVnZTOGt1eHg4VTJtR1JzclVnOWdUd2ZLRk5RdUFnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDh5TjlKdnY4eEs4RFhrenhiUkpBUVFSeklEZUpGOXYvS3dtcmtEOUJUczBw?=
 =?utf-8?B?am5YR3FhVmV5VkZ6WGp4eG54bHN4cDNXYzhJaTBLeHpCamZ4WjFiT3V0MnlX?=
 =?utf-8?B?ZUNXTW82d3FkWHRCcjJjNzBCbmttVmc3SHhKSlJyVG5RNW5KdnVqQmc1Mm90?=
 =?utf-8?B?YTVTTFhna2x6NTZqZll6UmlqQ2cvei94OGFXL3NlaXBqNE1CRTkvT3N6dyt2?=
 =?utf-8?B?TGM5SWppNnkyYk1YT0hCVXp0WVIxazRBZ3BmNWFTRGpacFZ0MEFuRC9xY2xW?=
 =?utf-8?B?dXA0WkxVSVpEa3ZYTDlHQnRXVUNaS1VsK3N6YWVJNzNDV2Q1YS9kR0VBTHFX?=
 =?utf-8?B?aGF1T2NMS1lpRytPUkZWNHZ2UFZXL0JSQzZJVFJXSGxwdjJhUFNWZXVTd3Bv?=
 =?utf-8?B?bHdKTmlFSFFZMlpGeUtQQko2Z1FmRmNjNHRFMEhud0FoTnluWlZMdHE1ZzA4?=
 =?utf-8?B?ZlFIWFM1RlBLRENLdEQ3d05wOWJUYUhEdXBna1RHNjdjbG04MGFhR2JEWGow?=
 =?utf-8?B?VytEazg1RWhQRUpZZVdwSmNEVy91QUR3cThTbDRrRnZQYmdTODlvOHhqTm5x?=
 =?utf-8?B?TlBwR2ZUc2ZneXk0TmxHdC9KZmNIVXFCT2UvZnhQdE5PcDFLZkJjbktJZnBs?=
 =?utf-8?B?aW5kQS9ib3NmYWJlR3FoRlUzdEhCVDRRU1pLOFRWdUdrVGI2K1ZucEhqcVFF?=
 =?utf-8?B?TGpua2JaQW9ZMGlLZHUxZW9odkx4SFN1cDdVN1BaVVd3OHczN29TVlBMTXha?=
 =?utf-8?B?bDJiWUZtODlnaVdLaEZwdExwYmJ3clVVMXR6NFJLSGlZcFFFT3FmSEI2RFBN?=
 =?utf-8?B?TXVydldMT2lFWjVWTUJsbnlIN2hnVDVLR3poYXI2ZWI1WDA4eDVsbnRiR0p0?=
 =?utf-8?B?NHpkUlpTcVloL3hkWXNDQVVVOHE4WW1IeE1najY5aHBMYkdmbk9DeHRXNExy?=
 =?utf-8?B?c3FEb3BCUE1zTFhYbmR2bWJwVEJYYkVMVTd3NWM0ZFJWUlJrLytNN0RGZ1Qv?=
 =?utf-8?B?ZktkYktCclpXTllhQlB0ODJJRTdqVC9SUXBKTUVlRjZCWDh6Rm0zVVZnNGJ0?=
 =?utf-8?B?MUh3MWZ6T0o1cEVVQ3Z0S1Z2RXpqdkd1ZWg0dGRxd3BRUERkaVVJaVBoOGZj?=
 =?utf-8?B?OVc3RGs2Nlc4eE1PSjM2b251SndIM0Joemp1T3hLUlFHRDYydnB1a3IycWV1?=
 =?utf-8?B?eE43SjFPNjhzRzJtVGZQS1g2MVpTQnhQYUtPQUtSQ3VWSGpvZ2VJMUxsTm10?=
 =?utf-8?B?R0NjSEc0djhLUmhVV01iTUNyYVRHMHo3R3VsWHM3MklQT0RwTlJueGdHY1dw?=
 =?utf-8?B?VFVyYm1EUVE0QS9pZVhHWUxDSEpWa1FXR1lhb05CTXVrQjFzaFRwdEwxR3Ax?=
 =?utf-8?B?Rm5teTVvYkhhU0JpMXljbThjWThneGUyRmdzMUpjL2cxRU5zc2VBTGFqS2E5?=
 =?utf-8?B?djdmUnBBSWtHOFYwaDJiTUhEQ21SN2swL1hZMExMN3ZRVTU3VEJsRkV3RGxt?=
 =?utf-8?B?Z2JXK051V0dwU1c4SHBvSUZxelZNaW5NeEFPSWFUM245WFhuN1VVeHc5ZHlG?=
 =?utf-8?B?RTloUkZpdW9VS1Q2NExWUi9lL21mMTIxa085bWZmTUQ4eG9CWWlJcE5ZZnJv?=
 =?utf-8?B?ZHFxOWVKS0lVblphdEd5eEp2NUswYzY2d2FFZmw2cjU0bEpWbFVnN0FtT0M5?=
 =?utf-8?B?eklTM21KSnh5L3BlSmV1VEo2UkUwaFh0TFMzOUcyeHc3M1FNM1AyMHF3LzB0?=
 =?utf-8?B?bmx6MzZ4R1pOa0hkRCtvZEljSk42bEI4M24weGk0dzRxNWhRcFc3Mm5LNWFL?=
 =?utf-8?B?WGdOcDRqTmMzRDlKcHM0VE1aN0tNYVE3dlZGcW4yZWFVazAwRnNIcE43WUZV?=
 =?utf-8?B?ckpMakp1ZjQ1bC8rMWpTZjVhY01CTllZZWJ4ZnJOY3dmVDZaU1hYZGpET0l4?=
 =?utf-8?B?TllVQ0VWSlBsd052Q2U3enFDcUpDTkRPMUJ0amNCdndqUGREN1B3Z2pHT2Vt?=
 =?utf-8?B?WEJCRStYbUZjWmZwNlFWdUMrcGZ1WVF3aVpUOG5McUlxZ1dkeXVvTll4OGxS?=
 =?utf-8?B?L1ZORVIvZ0Z2L0JLN3NOZ3h3c1JNS2EwY1dwVytSY3BUaXlaR1FOZUJhc0Iy?=
 =?utf-8?B?b29MSkhWdTJBNGUxRTQzYkN0dW5pZ1FyaFRERmNVdXdKbWF2Vy9mZlJkZFho?=
 =?utf-8?B?SEE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a6d7e1-7272-401e-2265-08dc783c0ed4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 19:44:12.3085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUUUNVBiX3L+isBV/XfvEXb2oP7R2d9dizpaY8EQ083TWvLrRtdYH/U49/lUUSZgFLecUm77F7SHXBbB5MEBNreUpG+AXo1kWG90gXFNbqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8899
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

On 18/05/2024 09.34, Stefan Roese wrote:

> This introduces some problems when compiling e.g. sandbox:
> 
> In file included from test/common/cyclic.c:10:
> test/common/cyclic.c: In function ‘dm_test_cyclic_running’:
> test/common/cyclic.c:25:42: warning: passing argument 1 of
> ‘cyclic_register’ from incompatible pointer type
> [-Wincompatible-pointer-types]
>    25 |         ut_assertnonnull(cyclic_register(cyclic_test, 10 * 1000,
> "cyclic_demo",
>       |                                          ^~~~~~~~~~~
>       |                                          |
>       |                                          void (*)(void *)
> include/test/ut.h:298:29: note: in definition of macro ‘ut_assertnonnull’
[...]
> 
> Could you please also change the test file accordingly? I'll then
> try to get this upstream shortly.

Whoops, I don't know how I managed to miss that when grepping for users.
Sorry about that. Updated version coming shortly.

Rasmus

