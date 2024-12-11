Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1E4E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 14:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB0E80274;
	Wed, 11 Dec 2024 15:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="CyAA8MWo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 619C8802A1; Wed, 11 Dec 2024 15:56:56 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E627980269
 for <u-boot+nodisclaimer@lists.denx.de>; Wed, 11 Dec 2024 15:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kyeab6tG5REMcPdgDcAQASu87WAOrl3uK9s2TnN0ry2y/kuUNKh7Lgf/b0eE9/LGv0XkwhthsORWCIz9n9KybWemtvFAUZfP1P1sK72aN7+gfkF8JIdx1ZHg6oCt0bfW39AxTH2RXc4gfyQ8gztz2TzBJX4HZZXAFJRYr3tj42VIhiKtK/jTEMuvW+702kA0aX0gwegDgbUy3DywvXHTC4pzPIrfz9BX1xNUn/wIEzsDu0g7NaEUiv13RAYyccbMK0WYFT4jytMwO7wkAhQEP0hj+FnFC6bvKkScMzLqMcxWXFO/36pvA7ewso2Xaqiw0sAMwhDIJ0z/EjLf2uXXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9COhnv1wOASEbx7KwVE2Y5+yXyHpMFAY+KcfXkvaHg=;
 b=HO2ca+vTaVWgtKXsnKFzg56q9078oBwnHJHJkxX9ks1Or1M90HGaHaQn8F/HwEtZXT2deXki7icWWUAGh1I3Z5B5j51FPFinSt0m9pbeSPZ6Q0CbIFIm4LFKplmRDlKnCLHwN3yeir1CJXQYOzN+g38lxiqreRbkE7qn0FRg+b4gDnwmh9sgH7mTBiKxhTxhuRYny+sO5b3IxnOXuchaWRtvpvXRu7fY9KPFyqu/A22cEfhWM8TbMxecCoUku6orPw3E+umGN49LE4z0RXcA8HAxCiYS4w5XR0G8zTq2T2CrlGMFqvGaUphnX7MXjYiF+CXgL7MixKAhtwZKdfq7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9COhnv1wOASEbx7KwVE2Y5+yXyHpMFAY+KcfXkvaHg=;
 b=CyAA8MWo5EKvetXjWIwW+SbRuZ6teKZ9MjDuQUVmWHVpwiYuZ93iKNI8eIEXoLDNTf2LNhGWuPR7m0hlo5Gt5CwqJ7s5uzWlt3oqaF4lp9qtZTOcS+Lyn0IYDLaNlrBcIclRYvhDhEQledeWWCrrXskbpz6qYO8JiEQxgjxTKMxXGiBspNNT3KQ95oBEVC+u5PxLXTPFypQM1p6QRKpH09xnLNcrFYb5yfwUF7E5IKp++Wjsb1Zp9UAiIwB0iIkXRO+XZB08Hebj5HOSQFODW7hLjRt6EfX49lwBclnmpKUNyAnWvQnoy4eAoXzghc2t85e6+2AOSD/bkOc4OpLDUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by MR1P264MB2770.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:37::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 14:56:51 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 14:56:51 +0000
Message-ID: <318f2d15-82b0-4ff1-bae5-f5603c49e1bd@softathome.com>
Date: Wed, 11 Dec 2024 15:56:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] lib: sha256: add feature sha256_hmac
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241209094159.8355-1-philippe.reynes@softathome.com>
 <20241209094159.8355-3-philippe.reynes@softathome.com>
 <CAEfUkU+7+mjckwERnr-rk2YO8z+VfT3EJKfNO9nOYHivyi-g=A@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkU+7+mjckwERnr-rk2YO8z+VfT3EJKfNO9nOYHivyi-g=A@mail.gmail.com>
X-ClientProxiedBy: PA7P264CA0230.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::6) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|MR1P264MB2770:EE_
X-MS-Office365-Filtering-Correlation-Id: 9497cca4-f008-498e-eb72-08dd19f40b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmFnL3ZZdEVwRHV6S1kzRGhvTzFSTWVRaG85WDJDcGwvc3N4dmM4T3pBM3Y2?=
 =?utf-8?B?NFJaR3kzRmZXaXJqOEIrQ2tFT0ZHcGZvWTBnNkxvWDdxeVNEYU9XK003VjRq?=
 =?utf-8?B?VGVsT2lnTzBRL3RCd3BtcStqR1ZHWVdQQ3Z4NSt4akl1OE11dXh2dG14WmtL?=
 =?utf-8?B?R1IzbkRYaDJRQi80YTNYRGlMcWR2T1JjaDBlaFlxb09jNEhIODhEK3hDbkxo?=
 =?utf-8?B?bG1id3pEcmRSRExMbFhuNVBTSnlvV0xvSFJIRkZQVkEzWVJVVVVrWVBqTUI4?=
 =?utf-8?B?K3M3TXpyRTJESGlFZE9qNUtzWnN3UWEzV3cxZ0V3ZVg5RWtnQkJtalViVnJj?=
 =?utf-8?B?RkxWUVRkcm1iOCt2aXU4cWNTQ21jTXdEcTZhaVVtUm5nTGVETlFaNWsrUEdV?=
 =?utf-8?B?YzJ0aFdjZ0dvK3M2MENmdzlPdlFVQldzMUh1aG54Y09CWURSVWtQZk5rTFVL?=
 =?utf-8?B?dlEzWG9VdThiSmVrUTRJMjJpcW1TK1pqdWRmbTRHYSsxMGY2Vk5nU0VEbStW?=
 =?utf-8?B?RHpYa3UyazMzUTk3N04vTTJ2MXZjU0ZyT0NSdjNpSHRvOW9RT09pQ3l2OStt?=
 =?utf-8?B?enlkZ1ZJelBjd3lsMmI1L3BhMGlBTU95MUZkbnQ3dFZqd1VNTk5XNkFQdERp?=
 =?utf-8?B?QTVITmFrbkE3dGVhSy9HalhGYW9aSmlkQjFVNmtubVJkb3ZBcVRla212b25s?=
 =?utf-8?B?Qncvd0RDQ0xjdEtkSXBibjY2R1lVbkhQVmZWYTdlS2pvZE1rYXVTSDRUZFha?=
 =?utf-8?B?NUtLOHQvbmFWZWFpMVJEZU05RHJyVmZJUnVOTFRSa29PU1dUQU9ZV3J5cmMr?=
 =?utf-8?B?dkRCNi9McXMzbkhiSWpHYmxhVjg3UG5XZThyeW1SRS81MGxXNFhZUWlPOEtT?=
 =?utf-8?B?N0c1dTVWaXJLN2dzU05XTEdRRnhwR2d0MkNMdlhDVTI4bElxQUdKSmtZVDdW?=
 =?utf-8?B?WWgvdDI5T2JkOHV3V3JUUmVOUkREOVJKZEozOEYrVjNXZzQvTUJhZ2RadVcr?=
 =?utf-8?B?RXFRVkhPUm5DZ0NSV2dvZm56eXRBd2trWWJ3M2xHWGU1UGxkZmg0UEcwbjRo?=
 =?utf-8?B?WWpqSlVPd2tkZ1FOeTQyOEZDanhDTzRGVTg1d3ZDVVFzblc5Y1FPR3N2anhn?=
 =?utf-8?B?ZmRqZUljdi91WEtHMVRGLzhWVVpORUJNd0ZLTkdIZXdvWVBrRVVwdkZ3d3VR?=
 =?utf-8?B?N0R5Tm1DTHhjMVdaVU1uNjRmUmVpYWVLS2FQWUM2REgzczBnd1g0UGdaZTBJ?=
 =?utf-8?B?Ty9xOUNrbGZrd1pOSHJzRWs3c3U2bjNDVnEvdlZwOCtpNVhWZUg1R2RYdGt6?=
 =?utf-8?B?elFVODFJS0U4a0pHdld4MTQzdm1XaXlnMWdDVE94RzI1eUVNeWV5YVdJTGkv?=
 =?utf-8?B?Z2hEQVEvb0d1UExjR2tVZmU1anAxeG45cGxkaEJtaWEvNUhyamY2TElXd0s4?=
 =?utf-8?B?ekNlRktOUFE2SXFyalQvMFdzVVgzKzM0WHltQVd0Zm5UTlE4dHpIQXJQcWFq?=
 =?utf-8?B?NE5QeW9RSW9jWUJhYmFsMXJYT2VzNUZZL1ZaSjZJd3VzUXc0dUppVDF0dHFo?=
 =?utf-8?B?Vy9PWENBQTNvWFQrTDNrSHZ1MzlRQUNHdzQwKytqT0NXSnU3TUhwL093V1Rq?=
 =?utf-8?B?VTMrTXNWWVFCaW1DSG1oVGx1bXNwby9PeG90R2tEZmE1ZmhNYjUza2xkKzhO?=
 =?utf-8?B?L3E5Nk5QdGYvRXQrYUVzeDdreWJQMHVwTFBETGpDMFhkZXEzVUN4QkRPemxZ?=
 =?utf-8?B?ZW9TdUhFaTVrYWVGQU5JWlpDMmkxbmlKYmRVSDYzNjc2dDdOeXArSHVwdUVR?=
 =?utf-8?B?aXhTMXF0L1BBd0J6T253Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkI3N3VLSXNXL01vWnpWbVNSQVB0THd1YS9hTmN5Nnd3Z2pVRWJkSWlhWU1E?=
 =?utf-8?B?ZGlXbWhvVWx1Ujk1RTdid3c4OGlZZWhSTmtiWmdpVFVnb0w3cmZQU2FQOVVM?=
 =?utf-8?B?QVVtQUlUTUxrV2E3R3d1UTNxRU1BdTBnOHhreUl2RzdocHM2Q2NmTCtieVhv?=
 =?utf-8?B?M1ovaFppa2hVTFFQbzFPaGVnUGVqaEdZcW5aQklwcldCV3luUjJHRzYwYVU3?=
 =?utf-8?B?NDFIa2RLbERESFdVbzFJNXhOdExtbG82L2VYMituRHFna2M0dDgveWt6Ym5R?=
 =?utf-8?B?S1VhelIyRGNleWtKNlRsTXpRZHZvcFV1R2FmTWY3RDZaQmpnVUF0UUZ5dlhL?=
 =?utf-8?B?Nm1HeWs0b1k3WHBuR1BNUkNGSFJkMXIwNWdoQVJXNW9oUnNiWW9Oelh3MWw1?=
 =?utf-8?B?OTFjSVQweUJ3M21rbHFkc29BaG9NREQyVndoQzFxMkhEcmdVRml6aUVwZDEz?=
 =?utf-8?B?QmFTUmRPYzRSZXhNcE1xWjhldUF5aGlibEVNeDI4RUxqcHRlVFNjdDFCb3E2?=
 =?utf-8?B?WHRnRzJFWXJCV0pCTEtuUFJDUFZwR1BoK3RqRTZVSmE4T01SY0RqajUzREZX?=
 =?utf-8?B?OE9hSll2TGZpbVdqcHVtTFZnd3h6eW1VV3lZRmtERHloTjJIRHdwSzdVQVgx?=
 =?utf-8?B?ZExSVXlmQkYyaDdOdFVTc0E2Ry9SV2EvT0d0NldHWFhqR1RTZkphM0J2c0Rv?=
 =?utf-8?B?TEJGbng0NVhVTjFFTFI5R1ZYbkhoS3YrUDlrbWMwWmpOTEl6WE94T0xHOXUx?=
 =?utf-8?B?VVhNVEcxMXFSazZpeE9xdmpxMjJSc1pFWjFvNEFuK1B3UEsvK2dvV1M3RytB?=
 =?utf-8?B?TGJLdFBTVUJhZGZMR2JTY2JEWVZyVjFNRFFaNCtBekZ0MHoxS09uMjdWNkxu?=
 =?utf-8?B?enVadlRLZEFTYk5DR1hrQTdscU9EZ1VMcVd4KzdXcDV4NEw5YUhvNEZZZGto?=
 =?utf-8?B?UGdmMGpKbDZOUWRQVmFHZ3VoVW1vZ0FVVk5ONHpOZHFtVjNZbUtBcGdXRHVp?=
 =?utf-8?B?NVNXeFRjazY1MWhFM3pJa2RRRXFLbEN0Q2NZaE5TemlKUkpXdlBxQVY4MENw?=
 =?utf-8?B?amE4aUFlbXoxeVVveHFoN3BHUlI5ZHo5elRWVDVVbkN4UXhNLzN5VWRoOU1D?=
 =?utf-8?B?NURka0d6SGlBQjZPTFhOWWtIeC9wWi93UHoyS1BNZFJ1NUxCZjdpeFVoa083?=
 =?utf-8?B?MHpwbDFmWTJGOVo3SEhlYlk4T0xPR1J6N3FUNG5hSGhNWlovUm01TG10UTl3?=
 =?utf-8?B?cWtaOEpwWFVnY2RwRHMvZGJuSFRJbzcwZVd3T2NxWHlPZUplcENPd0QreERI?=
 =?utf-8?B?TUxZS29FK0wxQ0JBeUJPRTZ5K2wxTlEyd090bjRSaHJqWWJtamVHVXJUckhW?=
 =?utf-8?B?NkxrQk91bFNDREk0RkdZWXF1dHl6UHlsck5mSXplRzgvTVJXU21QamhIVlNJ?=
 =?utf-8?B?T1NSdnZHNUU2MENiS3RjT0x0U24yVXVLcC94Nlp2QkIxVVlhRlR0L0JtR1du?=
 =?utf-8?B?N296Mkx0Ti9ldDhFSXlsWjROYkFvU0o2YnAyV3pYcFBoT1puekw5bWIzQytV?=
 =?utf-8?B?T3R2ejVjRE5Qd1hRUUhOc2ZuQmpnOHhNUkxnZ2pjSGIxQmN5dGsxSnd1QTUw?=
 =?utf-8?B?R0hjRkw1VDIwNlZQQ09FeXZwS3J6dk9yS0pabVo3bE90Qms4UURuRUkrVVNt?=
 =?utf-8?B?MUdCUUhidGRsTWhNZU5rR1NITERNZ2FwaVlJZVVXdmR2T2N3UlNzNWgrN0ln?=
 =?utf-8?B?NzE0eklhL3NQTzIva2FoQlJxVVBLNHMrUFNvR2FvQmdHVW82cmxmT3ozQXZa?=
 =?utf-8?B?QWZUTkhXNS9Ra2V1TFNSY2FJb2R1VHlyL2JkWTBGUGdIdjF1a2ZMZ2dPc1k3?=
 =?utf-8?B?VVBFaVlBU2FUNTNoVHBnZDdmZGtxOWRRUHhCTlRUc0FWbEpqcXBBNjZ6MEVG?=
 =?utf-8?B?TU5YR1lubjdhVlBVLzRpVnlHUDNVMFVvbDJpMkZRdEJ1Qnlld0x4cStnWkdL?=
 =?utf-8?B?VDFJYUtFOVQyZU9yV0d3azFoNFJSQjJndXl2Q2Yzc29keHhqRXRYTmVSM2lX?=
 =?utf-8?B?U2c1Zko1eGdteTlyOWZsL29uT0kzRXU1d2xqYnRNbnZNVEcyNkNxcmNoQzkw?=
 =?utf-8?B?azZNU2tnZmwxOGthbjJvNkxxaGY2UXFGZEpNdzQremRzeGlYd2Zsa3BvbXNW?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9497cca4-f008-498e-eb72-08dd19f40b52
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 14:56:51.0769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5GGW6Vi1wT3vSmw/5bpXRXQCWxYEkjtk24vrw6QKm6g+Qiv0Ks46YB9Jc16VgVFJkdzW/i+VXZIRdZop6l0G7/LU5XP4ji4x5mRt/iJdPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2770
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Raymond,


Le 09/12/2024 à 17:06, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Mon, 9 Dec 2024 at 04:42, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds the support of the hmac based on sha256.
>     This implementation is based on rfc2104.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      include/u-boot/sha256.h |  4 ++++
>      lib/mbedtls/sha256.c    | 38 ++++++++++++++++++++++++++++++++++++++
>      lib/sha256.c            | 37 +++++++++++++++++++++++++++++++++++++
>      3 files changed, 79 insertions(+)
>
>     diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>     index 44a9b528b48..2f12275b703 100644
>     --- a/include/u-boot/sha256.h
>     +++ b/include/u-boot/sha256.h
>     @@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
>     digest[SHA256_SUM_LEN]);
>      void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                     unsigned char *output, unsigned int chunk_sz);
>
>     +void sha256_hmac(const unsigned char *key, int keylen,
>     +                const unsigned char *input, unsigned int ilen,
>     +                unsigned char *output);
>     +
>      #endif /* _SHA256_H */
>     diff --git a/lib/mbedtls/sha256.c b/lib/mbedtls/sha256.c
>     index 24aa58fa674..1b9fc1a8503 100644
>     --- a/lib/mbedtls/sha256.c
>     +++ b/lib/mbedtls/sha256.c
>     @@ -8,6 +8,7 @@
>      #ifndef USE_HOSTCC
>      #include <cyclic.h>
>      #endif /* USE_HOSTCC */
>     +#include <string.h>
>      #include <u-boot/sha256.h>
>
>      const u8 sha256_der_prefix[SHA256_DER_LEN] = {
>     @@ -60,3 +61,40 @@ void sha256_csum_wd(const unsigned char *input,
>     unsigned int ilen,
>
>             sha256_finish(&ctx, output);
>      }
>     +
>     +void sha256_hmac(const unsigned char *key, int keylen,
>     +                const unsigned char *input, unsigned int ilen,
>     +                unsigned char *output)
>     +{
>     +       int i;
>     +       sha256_context ctx;
>     +       unsigned char k_ipad[64];
>     +       unsigned char k_opad[64];
>     +       unsigned char tmpbuf[32];
>     +
>     +       memset(k_ipad, 0x36, 64);
>     +       memset(k_opad, 0x5C, 64);
>     +
>     +       for (i = 0; i < keylen; i++) {
>     +               if (i >= 64)
>     +                       break;
>     +
>     +               k_ipad[i] ^= key[i];
>     +               k_opad[i] ^= key[i];
>     +       }
>     +
>
>
> You are assuming that the key length is at most 64 bytes.
> But according to the HMAC specification:
> If the key is longer than the hash block size (64 bytes for SHA256),
> it should be hashed first to produce a shorter key.
> If the key is shorter than 64 bytes, it should be zero-padded to 64 bytes.


good catch,  you're right, I've missed this part.
I fix it in v4, and I also have added more test unit.
btw: the sha1_hmac has the same issue.


>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
>     +       sha256_update(&ctx, input, ilen);
>     +       sha256_finish(&ctx, tmpbuf);
>     +
>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_opad, sizeof(k_opad));
>     +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
>     +       sha256_finish(&ctx, output);
>     +
>     +       memset(k_ipad, 0, sizeof(k_ipad));
>     +       memset(k_opad, 0, sizeof(k_opad));
>     +       memset(tmpbuf, 0, sizeof(tmpbuf));
>     +       memset(&ctx, 0, sizeof(sha256_context));
>     +}
>     diff --git a/lib/sha256.c b/lib/sha256.c
>     index fb195d988f1..66224c92dd9 100644
>     --- a/lib/sha256.c
>     +++ b/lib/sha256.c
>     @@ -300,3 +300,40 @@ void sha256_csum_wd(const unsigned char
>     *input, unsigned int ilen,
>
>             sha256_finish(&ctx, output);
>      }
>     +
>     +void sha256_hmac(const unsigned char *key, int keylen,
>     +                const unsigned char *input, unsigned int ilen,
>     +                unsigned char *output)
>     +{
>     +       int i;
>     +       sha256_context ctx;
>     +       unsigned char k_ipad[64];
>     +       unsigned char k_opad[64];
>     +       unsigned char tmpbuf[32];
>     +
>     +       memset(k_ipad, 0x36, 64);
>     +       memset(k_opad, 0x5C, 64);
>     +
>     +       for (i = 0; i < keylen; i++) {
>     +               if (i >= 64)
>     +                       break;
>     +
>     +               k_ipad[i] ^= key[i];
>     +               k_opad[i] ^= key[i];
>     +       }
>     +
>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
>     +       sha256_update(&ctx, input, ilen);
>     +       sha256_finish(&ctx, tmpbuf);
>     +
>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_opad, sizeof(k_opad));
>     +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
>     +       sha256_finish(&ctx, output);
>     +
>     +       memset(k_ipad, 0, sizeof(k_ipad));
>     +       memset(k_opad, 0, sizeof(k_opad));
>     +       memset(tmpbuf, 0, sizeof(tmpbuf));
>     +       memset(&ctx, 0, sizeof(sha256_context));
>     +}
>
>
> I understand now we have duplicated 'shaX_csum_wd()' under lib and 
> lib/mbedtls.
> That is because at the time when MbedTLS was added in, _csum_wd() is 
> the only
> duplicated function and it is a trade-off comparing with creating a 
> new common
> file for each algorithm.
> But it is not the case if the number of these duplicated functions is 
> increasing.
> Do you mind moving them into a common file with the one you created?
> At least for sha256 with this patch I think.
>

In the v4, I have moved the function sha256_csum_wd() to the file 
sha256_common.c

I plan to do another serie for sha1 and sha512.


> Regards,
> Raymond
>
>     -- 
>     2.25.1
>

Regards,
Philippe
