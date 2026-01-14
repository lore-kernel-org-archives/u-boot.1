Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BC3D37E3B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B009830A0;
	Wed, 14 Jan 2026 15:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="RGfEs/eA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C48830CA; Wed, 14 Jan 2026 15:23:10 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35FAE82C7F
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVfiy1821bdR2mvfdvzFq0kP+9nrPRu5eSnebvZz96qdhkAWmwitppuvkZ6S+I1NQDGkqpZMkpAilVUFDdU2m6dbz3XB9hlT+3FGezyC15yuyFMoV0e2oClmFyentM+5HWvuCn6GyqhPx94feFG4kF9v40IUeHRDIt8v5w/j+zMXYYexT6LI7uS8odJgBHUBcZ7PX/e5AleD/exX4TCluLTamc5De73cMoGwCaXE3/65wPCdXdXX4JubO2cp8DuNe1X1cpb1xgoN0GjdwnVO/NzBGMfyXKCeSFdwaVOsVJnNwvNLJkUUQgpkpsqh/Cur8EIC3zLcgMAmhSiwOwq9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4/HblqZ023clAbCiABctnX0pR3jFEklmTVlA59VWEc=;
 b=brDPE7oWRexG6+C6ttdKbtAnrXUTRHMs6PMkNpHybTj3ZQlDhnZV19Co+UoDdtpaD9K8cBYZpdKi6g4SgLitWMyXmm7e2nZMdeh2/vWazuS/HCyS75xhsoFCIfPYtO8cl3u5eTmHsVHU49Dc6uLj13VwVaAPiYhHUdmYwFNvZl3V91xuYSpdwGK71E0IAJvBon92RfwQcYa1IHKji10wdwNtWlEcEfZvrqcrBOpB/QWvsGjEQ/xHg+9YzKVNcV8jYUIOEmUVm/CqR/UUAHqyxzH3RfHYhY7bC5Yrvb86EdUDodXDHQgn77y/qKU0mTxelgzUGyrbfm8JiQEP/Wh0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4/HblqZ023clAbCiABctnX0pR3jFEklmTVlA59VWEc=;
 b=RGfEs/eAhWnwBoXGJ6lFO0IMAxAGAD82gkp3VL535L82UKhP8tUzZpOizsUt/a9ldAqupzL4MM7UE/mzN5OMZ7Zap1R9P2NQJ34z4QjHvf610Ll+S04SZIKjMzx0pPcWKhcc2ERP+61dYnM4Ds9VuPzacJqJgEpGTOdKxa4e+x4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by GV1PR04MB10797.eurprd04.prod.outlook.com (2603:10a6:150:20d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 14:23:04 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 14:23:04 +0000
Message-ID: <a0cb3bb1-c9de-470b-9169-386b05eceb6f@cherry.de>
Date: Wed, 14 Jan 2026 15:22:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] doc_ cmd: add documentation for sm3sum
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260106141405.82637-1-hs@nabladev.com>
 <20260106141405.82637-3-hs@nabladev.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260106141405.82637-3-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|GV1PR04MB10797:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ce437a-4a1c-4105-bb35-08de53786e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVl4ZGdhN0hYTVVJTXptcXNYZXhaWDdvQUhxYm1hV2R4T2ozaFdHWTYzcEtp?=
 =?utf-8?B?UUNvWmtJc3JjZm5tdDkwd0hBNUJVUjBPVEtEMzJmUTB1NnN0bDladVFoTFQ0?=
 =?utf-8?B?dDlPRmdmbnN5UE80bFYzQWtQc2kwQVplMjVEZlVaZU9vYzhiTUczVUtVbUdC?=
 =?utf-8?B?Tno4SXZNbGFiSUEzTlV4TDIwc2orMzNwTFlCNzZaOENnV3JvSHRNQWlmNHJV?=
 =?utf-8?B?SWcwY2xOTkRPTm4xVXNjVzdCdy9kZ2MwSTZMdnpNWFZYMkFzRDA3RU5Sb0lK?=
 =?utf-8?B?TmFodlZlMzF4bXdZdmVsaldsbUp4RzZPZWNITlIwWU1kRkI4K252SkMzQ2ha?=
 =?utf-8?B?SEZDNEhSSnlXV2dNTnBCQ1J6TFZVaVllNDNzaEJrMmRFUW10MmR2VXhha2No?=
 =?utf-8?B?RXcyYXB2MHZ5VkluajZIbWt1V2ZjN1FETXNGZksyVWJrNXRWLy9zcU5GbGo1?=
 =?utf-8?B?enpRdXhSVXhOcGFVSUd2MlloT2FmNks1TXMwNDVCTHEveUpxamhGY1phWFkx?=
 =?utf-8?B?MStPOFhTZXY0VCs2WUJGbEVod0dyTzJjUnBUT0ZudzBLU1BFTVFQdEJRc2R3?=
 =?utf-8?B?RzV3NmJYd1VWdGF2RHd3Uy9lYlNwWDg0OEhheXFjQ2xFRGwyY0dYNDNlS3V0?=
 =?utf-8?B?VEhETDFaazJFQnh2U1pnb0pDRHUvWjl3NWpkY29oSFZBQTZKelFua2ZOUVlT?=
 =?utf-8?B?dnRzMmIzS250ZjVwRnhtTlZlZXk1RXpicE81WDdwR0h6ZmpvZ3JPbVpIVXpU?=
 =?utf-8?B?dzZsM2ZwNFd6c2tKOTcrdGh4Uk1DQm1WcXFSOFNJODVvdVpVZHBrZURLcFFx?=
 =?utf-8?B?bVN0MmpUeTdqMkFJYStuOGUwd3NCTEJkaUhXamJzdjhlUFo0dkhhL0lVdFd4?=
 =?utf-8?B?Mk5hMTlFZGQzbWs0U3pkbys5MFJVQW1UMTNSRjhDR0phQlJrMnFHRzZDSGg4?=
 =?utf-8?B?Q1NFWXErREhCcGpJbWFWUWRQdlhvcVNkektCa1B3a0V0Q1dwWGlDNDNzZUwx?=
 =?utf-8?B?dFlUN2I1VDc3dWx6aUduVURIN2VuVWhRNXVqZU14UFFwNTRyb28wYnBiSjFp?=
 =?utf-8?B?NWFrc2ptaTRKMnUrcXZqd29sMXc1ZjN5WFRtTzRDYnR1RkFVSTFMQzB0OGFI?=
 =?utf-8?B?bmVIQ0s2QmRyZ0p3Q1R2U1FtMmVsRnI0WjZJbXZWeHVaeThJcHUzRGlUdnBL?=
 =?utf-8?B?MVZ5Zk1UOUFEalFWemwwMW1PT2Mza0FCMjcyVFErbnFHblBpbTVpMitzcGFT?=
 =?utf-8?B?ZEZZVXU3MnkraUdnbEsxRlNYZG5pRENkamlSengvcEJMTkRvRW9rYUNDejlq?=
 =?utf-8?B?V28zTXVEN2k0dEh4MWtpREorYWpLSkk2NVZJQ0h1UHA5MTZrdllSK29rTzNW?=
 =?utf-8?B?SlBQeEtEMzJJV1N6eFRWRHdKQ0NCK1dDbTcvUG1qbzJtMXg2TmVIeGZ0YUYy?=
 =?utf-8?B?UU1STEF3NWpxVGlRRGJFRHNaNk84ZjEwNlhSQWVGdTRrRkF2VGNNWDdWUjdk?=
 =?utf-8?B?em1JVUdNTnp3Qkd5QmR6OElWUEN4QzN2VmJuR09sQm5MZnRETWtFWlFCZHo3?=
 =?utf-8?B?aGVMeitzTjJ4eCtScXE1ZWxhN2V4WkU2SG9ua205dUJ0OWZJQ0ZmMXFuZld5?=
 =?utf-8?B?SHppTElHeGh2azZmdzlKRmhXak56dzlQUk1zYU9mc2RPSHRoWXpKOUVXV1Vq?=
 =?utf-8?B?UVpDdXdGSk1tVXMrUXVPTzBWdlZ6SXAzSVB6REhlZDdNTDVPRkNPcW5LanFK?=
 =?utf-8?B?WEZlS2h3M3BVUy9EbGgzZVZtaWhJUXBZQlB3OUhNc2hMVXBqVmVZQVV3TW83?=
 =?utf-8?B?WGNSNFVpeURMUllKOExHNWZJUk1INVo5c3E0YjVYZGNiSXFRejBwNXpSNFNF?=
 =?utf-8?B?VVF0R2lhWFEzeElZdTJvTWtYWmZCYkx1QlBaNnRiaXpWSUgvSTI2d0xjWUNE?=
 =?utf-8?B?UVhjR0pPRnVzcXZUSDVSWjdHMThhekpzQXBZaHVLVGZLQ1dLKzdBc2g1QWFK?=
 =?utf-8?B?dzFMdXlvL2h0S1I0OTdNVzhvQ0xtanJtcm1td1krS3FyT3NLWGpLSWJ1STRX?=
 =?utf-8?Q?7gnbQ/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7142099003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFlPdUdJVzlCNWsyNi9LS3g3ZWd3YnBCUnJaVk1jQ1RqdkJyQjBFbW5weW8x?=
 =?utf-8?B?OE9aQ24vbGNTZjk4cXNsRldPdDFsbC9QYS9Zb0h5OCtkZHh4MU1saW5KNG1T?=
 =?utf-8?B?b0VQSzJkck9Fb3ZTK1RqQTA1OVYybndlb0VkajF5cEdjVUdJMm1mWWRjSXhH?=
 =?utf-8?B?eGtyd2I3cDFlRzZ4M2x5aGxueitVOUJZazJTM0RuMWVoQTVkUmtYT2xjZnB0?=
 =?utf-8?B?QlozUHl0SVQ4UjRYYzZ6aHhTeWR3cXJrNUN1MGxJNnEwT0IxeDNKbzBrUXRM?=
 =?utf-8?B?bmN4ZzRaQklDdUp2aWl4TW5maVl3amhza1RycEhPUk9JMDRTeVJpbDVRUTNG?=
 =?utf-8?B?eWgyQmJVWkhyL29hR2o4U0FjQWdWOTZ2b0wwenZyZzA1UDg3WWdsTUgrOHB3?=
 =?utf-8?B?M2UvdllHMFM4V0g5ZjJ0cXN0dVRWbVAvM2IzSU9oN0d3NnNER3VqUWhQWG5N?=
 =?utf-8?B?cTV1aFBJYkFvcWNaVDkrTFR2THpJRTJ4WVVHZ3lraW5YU0tHK2NTaUZXS0s5?=
 =?utf-8?B?bGtXTmNVUm5JUXFXV282RmV6NWJLTE10b2Rzb2VnbTJVVTNNVklvd0kvK3M5?=
 =?utf-8?B?eUUwZnhPMFVSQXk4alU0ZXJieW9GOXdwSEE4T0g1Wlk4d1FObllMSHc5Ry9Q?=
 =?utf-8?B?dVA3YkFrdVlSOCt4K2doWHB2VUsvUndVZzNjRzRhRmFiTStVTUwyakowTGlx?=
 =?utf-8?B?aytYY3lmN2ExeHV2RlVzZXRnekx6L2lRaW9yT3IwdHMwMnhGSVpnelFJYWtr?=
 =?utf-8?B?NmJIWk5EQXhiQUZ2WjROWWErQkhIRkhGVTRrZHlpUkl1SjZCMmRRSmNFdTZa?=
 =?utf-8?B?em8xRnJOLzBEZzlYRGxqaWIzU0JoNDFYM05xbnZ5VkVzOE1aM21KYmh5QVNI?=
 =?utf-8?B?NVdOaiswVkFCZ0pQMTNMTEFDZGhCWWlKU2pzc2x0MTBKZFBXYmFlK1dOemR5?=
 =?utf-8?B?REFYWTE0YjdjTmxOTFowVEZXd2k1Qy9zTUdtU1BHelllTWtQSVM2S1RzSFpZ?=
 =?utf-8?B?dEd1S1pzUEJSTk9uOEZ0cjRHUU5FdGtkTXN0WnM5NkZROWJTSDUyc3BvYmp0?=
 =?utf-8?B?WmRjVCtYdFdUTGNNekU1TnNwQllpM3htc2VhQjhNT0FPem9lR0YzczRlYlJ4?=
 =?utf-8?B?SEdDVFZGc282bmZxV2ZJYlN2MlpFOVM5L29RNmJENTNCNDVnRHpKclByb0dZ?=
 =?utf-8?B?RWRDRng0WmF3UDVOd1I5K2FpTi9xWVk1MzZQa3p3a3l1c2J5b0xOWFA5a1Zt?=
 =?utf-8?B?S2tZOCtLS3laejBLQ25pMGlpOGZrZVU5ei9aNkdwUWgxWjBYREZ3azhBcVpu?=
 =?utf-8?B?VlNaSFVJL1NNY2lLUUtaYmErV1h1Sjg1N0Vkc3FvdzgzZXNCOTB5MDdOUGt6?=
 =?utf-8?B?ZytKNGc3ZGRhMGNhTHN1Y0ZxRk1hbGw3OHMxdWtKMi9pZTRKbkk1VWRDc2Vx?=
 =?utf-8?B?cVJJMjNpK042SjFNalh3QnJwaWRtZ2VKaDRpRjd2ZGk2WkpvV3pMaHNUQmRo?=
 =?utf-8?B?ZVRIWUxhVEdTWUtFeTllRWx5bEtxSnl2ZUoxbFdWRXg0QVNwRnRIVmtaZjJo?=
 =?utf-8?B?eU0ralFSMWcwa01VQTJwWDQzMVJEcWc2NytRR3lXVmgwbzlmb01EWk9SejFj?=
 =?utf-8?B?NUJBcy9ESHJiYXl0N1hTc05uQURQS2o0ckcyVk1jN2NOU0J6bFlUYVcyQ1Bl?=
 =?utf-8?B?L0RhdVJXZGRvU0RYQm55SGVYbHd1dmY0V1V4c0ZROGZRTk5LMU1TS3dWOVJr?=
 =?utf-8?B?R1JXMlg0THFZemtVdU9aUko1RXM1dy9qVnJZSDlHdGdGbUN2Zm9BZ2dTOUZl?=
 =?utf-8?B?QWZodVVHdVU3NzFBNGRiWUUvdmNJWUFvTENHMElSSWdvS0R6ZFpoNDE0QTdm?=
 =?utf-8?B?emkxTEthVzlYM1FjWDgvWXFlODFvcEdnNGxPOVFxL0d4MHYrTVZJK2c0bHkv?=
 =?utf-8?B?Ui9xYUVzN2trYXhWVVBvQjlVS24vSUoxQVBlbmZKY2dOcnNlQzh3SlNJeGE4?=
 =?utf-8?B?TU9WL0UxVzhuWi8vZS8wdUZDaHdxbVpYTTB3OVFWdFY1YzBZTFBHWUZ0OVB6?=
 =?utf-8?B?NUlJSUZWK21RSXl5YTVsWmdIOHpSMisrQzhHdXhqQ1diRFAyejJBVEZnY2F5?=
 =?utf-8?B?eHlIYzc0SjF3Y2txejVDT3l4UWV1SmJKMWNxYWpWSkFCcTJ3ckxUR3JvQzdp?=
 =?utf-8?B?blNwTmxHTjB5K3JXaDE1VXVwRzNMMkFFSElvemlNZDlSMUFRMU4wNTFqbCs4?=
 =?utf-8?B?NFJxL1FEbFcxQkZ3VEtHWENGVVkzRWh5aDNOdTZJNkkvVDZhMEo4Y0xoMk8v?=
 =?utf-8?B?dk4ySVd0bVl3c0dmZVo4OWVHOE5Sck92bGpuL1hlYjI1YWNFZkc1dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ce437a-4a1c-4105-bb35-08de53786e14
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 14:23:04.1879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdVEKNfQI78BKLaA/uuj956eX6PD1Chi5VYDES0c51lUnyfJ6uAEzACEJqpkXc9KTzoJdqhn0HmZVWmH/MgLKBaLsWhD/Kw4Gf0/mFkQd3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10797
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

Hi Heiko,

Typo in title, should be doc: and not doc_.

On 1/6/26 3:14 PM, Heiko Schocher wrote:
> add documentation for sm3sum command.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> ---
> 
>   doc/usage/cmd/sm3sum.rst | 117 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 117 insertions(+)
>   create mode 100644 doc/usage/cmd/sm3sum.rst
> 
> diff --git a/doc/usage/cmd/sm3sum.rst b/doc/usage/cmd/sm3sum.rst
> new file mode 100644
> index 00000000000..3b157779a0e
> --- /dev/null
> +++ b/doc/usage/cmd/sm3sum.rst
> @@ -0,0 +1,117 @@
> +.. SPDX-License-Identifier: GPL-2.0+:

Use the canonical version:

GPL-2.0-or-later

c.f. https://spdx.org/licenses/GPL-2.0-or-later.html

(Do not end it with a colon either).

> +   Copyright 2025 Nabladev

Seems like we typically use a new comment for this line

.. Copyright 2025 Nabladev

I **think** the copyright should use the name of the legal entity (so 
likely "Nabla Software Engineering GmbH"). But IANAL and I personally 
don't care :)

> +   Written by Heiko Schocher <hs@nabladev.com>
> +
> +.. index::
> +   single: sm3sum (command)
> +
> +sm3sum command
> +==============
> +
> +Synopsis
> +--------
> +
> +::
> +
> +    sm3sum - compute SM3 message digest
> +
> +    Usage:
> +    sm3sum address count [[*]sum]
> +      - compute SM3 message digest [save to sum]
> +    sm3sum -v address count [*]sum
> +      - verify sm3sum of memory area
> +
> +
> +Description
> +-----------
> +
> +The sm3sum command calculates the SM3_256 Hash from a

Are there variants of SM3? From what I understood, it's "equivalent" to 
sha256 in terms of security and efficiency, but it's SM3, just that?

> +address with length of count bytes. If the -v option is

Can suggest:

"""
calculates the SM3 hash of data of ``count`` bytes at address ``address``.
"""

which highlights which parts of the command must be specific by the user.

s/-v/``-v``/

> +passed to the command, it compares the calculated hash
> +with the hash found at address sum.
> +

s/sum/``sum``/.

> +The SM3 secure hash, is calculated as specified by OSCCA GM/T

s/,//

> +0004-2012 SM3 and described at
> +
> +https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
> +
> +Parameters
> +----------
> +
> +address
> +    address from where the sm3 hash is calculated

How is this value parsed? Is it deducted from the string (e.g. starts 
with 0x or contains hex digits = hex, starts with 0, octal, otherwise 
decimal), or is it a forced base? This needs to be specified.

> +
> +count
> +    length in bytes of memory area for which the sm3 hash is calculated
> +
> +sum
> +    address of hash to which the calculated hash gets stored

This is only true if you sum starts with "*" no? Otherwise it's the name 
of the environment variable where to store the checksum?

> +
> +    or if "-v" option is passed:

s/"-v"/``-v``/

> +
> +    address of hash with which the calculated hash gets compared.
> +
> +Example
> +-------
> +
> +create some data
> +

+at address ``0x0000000100000000``

(do we need the leading zeroes?)

> +::
> +
> +    u-boot=> mw 0x0000000100000000 0x426f6f46 1
> +    u-boot=> md.b 0x0000000100000000 4
> +    00000000: 46 6f 6f 42                                      FooB
> +
> +and calculate the sm3sum from address and store it in environment

s/from address/of 4 bytes starting from address ``0x0000000100000000``/

> +variable hashval
> +

s/hashval/``hashval``/

> +::
> +
> +    u-boot=> sm3sum 0x0000000100000000 4 hashval
> +    sm3_256 for 100000000 ... 100000003 ==> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
> +    u-boot=> print hashval
> +    hashval=cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
> +    u-boot=>
> +
> +or calculate sm3sum from address and store it at address sum

s/from address/of 4 bytes starting from address ``0x0000000100000000``/

s/sum/``0x0000000110000000``/

> +
> +::
> +
> +    u-boot=> sm3sum 0x0000000100000000 4 *0x0000000110000000
> +    sm3_256 for 100000000 ... 100000003 ==> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7
> +
> +and now check if this hash is a valid sm3sum with "-v" option

s/is a valid sm3sum/is the expected sm3sum hash value/

s/"-v"/``-v``/
> +
> +::
> +
> +    u-boot=> sm3sum -v 0x0000000100000000 4 *0x0000000110000000
> +    u-boot=> echo $?
> +    0
> +
> +example with wrong hash
> +
> +::
> +
> +    u-boot=> sm3sum -v 0x0000000100000000 4 *0x0000000110000004
> +    sm3_256 for 100000000 ... 100000003 ==> cdf49da4e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7 != e33017bf2d9fe87b885d80c9a7c920be7e10ffb8c89036a1eb1503b7ffffffff ** ERROR **
> +    u-boot=>
> +
> +
> +Configuration
> +-------------
> +
> +Enable the sm3sum command via Kconfig option CONFIG_CMD_SM3SUM.

s/CONFIG_CMD_SM3SUM/``CONFIG_CMD_SM3SUM``/

> +The "-v" option is separate enabled through Kconfig option

s/"-v"/``-v``/

> +CONFIG_SM3SUM_VERIFY.

s/CONFIG_SM3SUM_VERIFY/``CONFIG_SM3SUM_VERIFY``/

> +
> +
> +Return value
> +------------
> +
> +The return value $? is true (0) if the hash is calculated or if
> +the created hash is the same as the hash stored in memory at
> +address sum.
> +
> +The return value is false (1) if there is a problem with
> +calculating the hash, or if the hash is not the same as
> +the hash stored ar address sum.

This matches the expectations I got from reading 
https://docs.u-boot.org/en/latest/usage/cmdline.html#general-rules 
(point 3). So I would simply remove the return value section in this 
patch here.

Cheers,
Quentin
