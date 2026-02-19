Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8FFE9A02C
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 00:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D5183A47;
	Thu, 19 Feb 2026 01:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="gUYwRMs/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71E3C83C19; Thu, 19 Feb 2026 01:18:16 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EB483936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 01:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHq9T1CrfBNg0iP8+hZPEBzR7NNdxEzaJsjEcW/HseKru2uYx6gOeOV0OQnQjY1rYpj2SZTs/DpoAvAa2f2ISkch1/SaNB1SwarAlf0oZADjdngnvQHKPTBQPbkFrCBuc5WQzLtRGLB5KV49o97lFl5Vh7eT11ecRHh6QXdHUr6iglMSxVG1X5lrXViHVGfwxXhF9iXskl8DXflLrnQnr/kzxy7eYlphxyA+6xkJhJ1ze5w/8pw1g/7vIyad/sT+Qsx0aSryZb16nmTJ9pvaElr1OJ2ulrF/FRbU0ZlFCXTBYbNFOCHsMD+lncrqKlU10UC1bhLVKzuq0IIInE6rZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCYTSBhekcXz4tH81z06g7jukC/sJEyjPkxw3EZfoQY=;
 b=hLkEk5+/cC+luZC7ZHdLXndiOrZhTr4MFYlBLHSdiU2ZO1/vQaQ/XCX1U9zt2u2XXCEUDAnuGuOlbCqbBuVAbuvKnc7AbcZ/BnXbkzEfoNe2d7mT/M0V4lNcx2Wm+Ds2BfQUGDzXD96p7XNLjVpW7njTFD/rG2aYWhZubhW+9kIUk1v5xTq3JaeQloJrp7BFDtUF54pBDEeRuP/l0UqmZtlS2Ttkl5STv8al+cYrNrttdOW7FPbY96sYa7jm22/P/nLKmS7Ck3qwUX0NPeS0D9stKtITd3nqbqDev4A9AESaBYDnhL7yhIp0Kd1MmK7uPXeUmzeFbhWiWFAqwp/0Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCYTSBhekcXz4tH81z06g7jukC/sJEyjPkxw3EZfoQY=;
 b=gUYwRMs/FRvuBVLoLFIGoid8T5woA1HDzOAi2CApEIpwkmB8xgOiKYhEov1EmMMng5P/2Tm9deGaKKSxjdWk8JQ6+zF0s5DvYQRIoXM/8UudGx+N4pJNBUCfQdIWcF/AoAXX6l4zC+p7cLltnIR84NBK99f4Qsx1eVrLrru3A/vbYDAmgyS5OcgCzneyCQvV+nPSi4fNWXu9US6AD3NIbySiAWzBXu99tiLoY25Xbaf4zs5rxASPdhFHQYR6yZdsC29vDCynAmuDFfai5e9vm6v8oW2hTZw5UoqseYEK8Qyp7wIBQINX+nn3Vxg+CQ5a84+Qk/pSkZJLVXynioVHwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15)
 by PH0PR03MB6677.namprd03.prod.outlook.com (2603:10b6:510:a8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 00:18:10 +0000
Received: from SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8]) by SJ2PR03MB7072.namprd03.prod.outlook.com
 ([fe80::7d1c:7fcb:cd62:6cd8%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 00:18:09 +0000
Message-ID: <4b6327d1-681d-46a4-b672-6d53fbfa1e89@altera.com>
Date: Thu, 19 Feb 2026 08:18:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm: socfpga: Add call to
 socfpga_sdram_apply_static_cfg()
To: Sune Brian <briansune@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <CAN7C2SC4GTf004JyBeeVtnBPo=BvqorCy87ZFTNV4RkWFOJKbA@mail.gmail.com>
 <b25f6c14-7db2-4517-a3ab-e2c55a52818c@altera.com>
 <CAN7C2SCC9L30S2BNYUzRE1jRJeQ2H1d6fq_Hgsu7uPge_QgsYw@mail.gmail.com>
 <CAN7C2SAOLdokAaVcuMPWMTS4HsY-4d2dhnkwLadqsGS2qAsKaw@mail.gmail.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <CAN7C2SAOLdokAaVcuMPWMTS4HsY-4d2dhnkwLadqsGS2qAsKaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To SJ2PR03MB7072.namprd03.prod.outlook.com
 (2603:10b6:a03:500::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR03MB7072:EE_|PH0PR03MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9cc969-e296-42b7-f02d-08de6f4c5c69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDBwQmsrK2Q1VndXQ1VxUUZ2L3o5MVdqTnh4Mm9tN0c3Y0lrVWo5NFp4R3di?=
 =?utf-8?B?TDR6TU5zU0wySjNCNUxxaGVaRjRFR25ETjZiSGd0VEpqVGM4dDdVK2tRVEJQ?=
 =?utf-8?B?d29FRzNqU0pDc1ZDWloyWTdKNmNXSFZ2Zmk4aWlrN2lWbTVhQ1l4Rkp2VGxR?=
 =?utf-8?B?SzE1eWh1TjdXNUtqMVI5OUxuNW5xOHl6UkdYb0xNNDlMRGFmTUtMd3FQdURn?=
 =?utf-8?B?ZHN3ZEJnQ29HQXRUV05vWm5UdnJ6TzkwUllGem1PTklGbCtBckpOTzd5Vjc1?=
 =?utf-8?B?UXJSaDBSRGxYc0ZFMjNRWWNWbCtmQTBmaFVmSXdGeHV3MGNWZjBwSnFoT3hT?=
 =?utf-8?B?TDRuYnM3dVFvZ3FHSE1ZMGNzeVl0RXByR1YvWnhscGtFRzNRcXBvaE5jU3B5?=
 =?utf-8?B?bkNKcXFCc2tYVFdKazJtNkZSNEZzWC9LNm5VMzk0Si9SY2svRi9XWEVEdGNF?=
 =?utf-8?B?NXkvd2FqV3pvYkRhZ3NrdytwWWtjV29OWGxyU1BmUm1ZRXZ0WDBiSlMwL3Jq?=
 =?utf-8?B?RmJhNE9OVytRb3BVWUltR0Jja2d6YUZqNnA2cFB6M3JvcUFNVEhYcC9tUThF?=
 =?utf-8?B?MDh0Sk9rWjI3aVpTTEFBY2p6Q3FIMHp5Wm5GRWxXNG1Kb0cyMVVZR0pEdENq?=
 =?utf-8?B?OEttTTFGdGxPL05HanprQVFJaHp0bjJXb29JNGdHWHlFK2RTZG96amxhR0gy?=
 =?utf-8?B?ZmdnVGNHcGhZYVRmRU5WOWFwTlUySE1nalRZQXpRaS9xWkhEVmNad3dFRlc2?=
 =?utf-8?B?MndkYWF3RlRIME50VEl5ZjNMc2EzeUJBV014blJzcjJSTGkyTzFBemVHYWdi?=
 =?utf-8?B?Uis1VWNlZHUwZVZacFNJNXZkalRlVVdKTGNiaFpGWm5yWHJ3QStOd2x6c2ph?=
 =?utf-8?B?ZkhVQzF3c0NWaE1mVjA4VDJQYU11QXdKSzRhS0l4UmtPRWtzbUdNSS84UktJ?=
 =?utf-8?B?VzFIdzVyNmxmSGVkUGlwSStZNmlodGt6YzFWWVdoTDVCTGcra0FqRHY0VDJ5?=
 =?utf-8?B?NEJubHZiSi8wdHdFV3JXMmRaakt0c1JZaUhRcXZhNHQ0OXRaVWlORTN2dkt1?=
 =?utf-8?B?cGgrTGJPcE05Q0tuUkJqMUVQYXlSTU4ydGZTaFZ0S3ZucHZmdWxxcjhqaGtN?=
 =?utf-8?B?WSs0ZjdvcHFhaHlqQ3hpV2N1TXVzei9pSGxQNEp4bGdVb1ArUlRTVHJLWmNt?=
 =?utf-8?B?SXd5bHo1ZjVqanZLYnZmbUdxOGNSMW1FTHhiSjJ6b3hEdVVKMDhpWnQ4ZlIr?=
 =?utf-8?B?ZUhRUUI1cmhGKzAvTk83N2FqSFA5S08zNXRycDlKNjV4YWNJdDFFVVJMS3M2?=
 =?utf-8?B?OHNpWTJNZXlFckw1dStUdUVWQzg0MmpVNGF0dFRtanlTMkY4dzMrOCtHSXYy?=
 =?utf-8?B?cUo3VjNNYzBLREplTDdvQjhLSEpWWEVTQWV2NDNtM3ViUHUwUVBXeHEzUGJD?=
 =?utf-8?B?WGtudXRabk9kcFJrbXl5SHVCQlpCMmt2b1NaSi84NEd3cTlJTjdsWFZVVk1p?=
 =?utf-8?B?MVYyZTY3dTBicEF0TDNvWmJNN3ozVFNtOEEwVy92RnRXekI0VWpxZ0Z1NXBK?=
 =?utf-8?B?U1hES0VONHZBa1Y0NnFLZzNESmYrWkVKNWFHQ1dJTHYvYnJ6UGhQWTByMWNL?=
 =?utf-8?B?aElubnNXdEdJQk9IbkFvdXpRZDY1L0JLWS8xc1plcXYzODFobVU4YkhNZFFV?=
 =?utf-8?B?MEZnYVlhR0dNbHVnVFppKy8xbmE4NFdVcEQrOW81VkVmMXlXMkdubVE1aldh?=
 =?utf-8?B?bWNlSm9yRkV6L3dqbFRPLzJGMDVBWUIyRklzdUhWeVpUQktPOGFqNkJpWGdP?=
 =?utf-8?B?L09oVlRyaDNlbndRajhZT0pxODExbE0xdEU0VWZnbituWkttYi9lbjhiVEpM?=
 =?utf-8?B?a3ZYcThHZmUrZks0UHVKb2lOeTZ2SGtYRVdxRGRQT2dCSXhheGFBc2Y4RXEw?=
 =?utf-8?B?KzEyUDJ3bjRydWc4ZGxkTHZRL0tsYVRKWldoMmdhMVd5QnVSeWQySUM4dUt3?=
 =?utf-8?B?dmtKWFBXZi9rUVRuUm1kc1VpZlE0SG0rb3lMNlBZN1pHa2dtcVNZM2gyQWtJ?=
 =?utf-8?B?WFpzOEJZOTUyODgwOWhLa1hNOU9YNUFMR2hWWmd1S1F0WmRFV2hvQnhxVGtW?=
 =?utf-8?Q?9AUM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR03MB7072.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U29RTkJFQVBTVHM5VEY3ZWhsRWpmNmJGOXd3VGRmdE00WnJGNmNrcTN1bmlK?=
 =?utf-8?B?NHh3RURlMktnaU1ycmpRKzYyV3VNdGhnbVk2bElIbElSUkF4dFVwUy9NRE5j?=
 =?utf-8?B?Y1U3TWRhL1hhREo0eFhvRlRCV0Y2QXEzU1EySUxhdVIxU1k0cGFWUkIwZW5K?=
 =?utf-8?B?bjNNZVl2dDNTUHMyZklPYW1ya0c3VVFFYmJXQUd4b2dtcEdFL25CNmtGczJ6?=
 =?utf-8?B?UHpHQVo4QmRsUkl5S3B0UjVtSTJXNjhUeWtVRVZuUk92UlVzRFJxcExJZ0xr?=
 =?utf-8?B?S2xnMzhpTmR2cXRZa0FyV05MNi9vZG9FTndGN1pJUFNxLzZQakZ5SjdpR2Nn?=
 =?utf-8?B?YkdqWFlUUHhYUnhvNFk3ZFZ0cE9NOUJBY0R5a1JvR2NLRFFTT2VOa0wxTWNj?=
 =?utf-8?B?aXJ3U0ZZN1JyWERpN1dMNHRQRHkvNDdVV1AxdS9XNUJPOUpnaUc3ZTRoL3A5?=
 =?utf-8?B?ZVdWb3FnNmI1KzRvZWs1NmlPTXhVMXByT25BalJ2THlZK3hlVEZscHp2bi85?=
 =?utf-8?B?cVhYdERBVGxhVDcrSTc0NlhiU3U0cWVwZFdDOWF6RVlUb3RMdDhhZ0lWV3F2?=
 =?utf-8?B?RHZ4ajVDUm93NW9CWWxwcGIvYlVkTmQ5YWxVODAvMm1lb0hPTEQ4eDFlRGE0?=
 =?utf-8?B?VVFRTHR2SFhBRkgwWDRyZTFxRUlrQTllMEdDaVYvNUhXYk1MYXYrVVFlVXN6?=
 =?utf-8?B?MXBlNWlIaUhzVW5WbnFXVlZyRElFUExRbXJsKzVhTC9Qc0ZFVUoySmQ4Sytw?=
 =?utf-8?B?MlY5UXdGSTh0QUg2VTQzRTdqbkdFK3FDWS9xWnRoTHhiU3hrMlA5dVUrNzgz?=
 =?utf-8?B?cUlWcDZ6Q3F3MVJnK3o4NlAvMU9HZUtFZkx5VWhwelNxZ3BGdEZBVjZpSHg0?=
 =?utf-8?B?aFFMNnZZRi9CMGVWNGpSNDRJVWZKM3JmeWI1UmNGSW5LZldYUDl5Nlh6NUdx?=
 =?utf-8?B?aEFTMjNsVGRqWDFvMmk3ZGUxZ3pEeFU4UTA5VVZLRkk1WmpjOVBLQ1VqWTNN?=
 =?utf-8?B?S3pEVTMreklUdTBtSWZJcHd6bENjT1NyWHVTR0VFb05qY2lGVCtHd3pQUWdG?=
 =?utf-8?B?WGhoV1VTRXNBS3YxWkFEcXIvMGMxM2NHT1hubzZHa0V0U3RDZ0FZd1l5czBY?=
 =?utf-8?B?YW82V1ZyWEZaMGI3R05NbVJIOWNoaXcya0lZY2ZoSTNJT1BhMGR3ODBzVjQw?=
 =?utf-8?B?Zkc5QTllTWtHVGEwWlZYeUdiQVlUMzFRek9UNlBHSC8vWkV1M0xycktwZVFE?=
 =?utf-8?B?OVo2VGdQNEVjK2g3OStqUmNQNll0aFpmUHFXZEt0YzVCNUVjQkFiYllFUmZ2?=
 =?utf-8?B?dmtncjkyaisrK0kvVmJmKzZwSzRsL0tZWjZRTlBaeGFSd1hYODB5T3NybTBY?=
 =?utf-8?B?S25jWllzZ2RBODMvOERqK3BvYlRhaUdkUndDcjNlWVRUcURlcVVkUWZNZ1NN?=
 =?utf-8?B?ajZLRjJmUUJTVTJ1aDFqR2RGSE5ld0RmRzVqcmpMNzZhYmhIYXVJc2RCUU5h?=
 =?utf-8?B?NWp0ZW9NS2Y1aFpYbkt3L3JqZjNMVkN6YkpENmFGSDk1Zjh4UTNNTW1ZbEpq?=
 =?utf-8?B?KzNjaHVhVkxXOENqTGc3ZnA4VTRUOFM5M292WGM2TE1qSHBoc2RyWGxNZVJP?=
 =?utf-8?B?aUR5OUd1QjNLUnJNSGJjRnY5Rk9wYmczYk5CN3JaNWlxRHZUZnF1WjJHWExW?=
 =?utf-8?B?eHk1djY2MUpTL0QrV3hnTGhpTGhra1VWM3JiMTFVQm1LakZXQ2dDcHdRUUJW?=
 =?utf-8?B?UW8vcy9rVmVhQ0g4cFZKazdZZEFpVFNSZWtSS3BQS2ZOcjJ5QlJwL3NlRTBW?=
 =?utf-8?B?bEpudzlYUFZVSEptN2VuNTJGZnh6cmhrZ252aE5TUkllQnA5UVBIZ1VrSmlW?=
 =?utf-8?B?SnhNL2dBcnBaL1NOMHoxbGtiZVVCZVRlWVczOEEzWGhLNUJMYlcyR3FqOGpp?=
 =?utf-8?B?Y2NZdFV2T2g3MC9IZzBpcUxKMk1kT2FBdUZyS0dnUEhwVklPN09XYkwya2F1?=
 =?utf-8?B?TUpDSDJ2SGtXeXBiOCtkVjhFS0c4Um1EZjBKT3d1U0dIUjMvR3VDT1dwVHhJ?=
 =?utf-8?B?WnNPdmxzcjVBWEswMEpuMzM5Ly82cHpBS0FyTlkvbU9sajdpZU5iN3RWSGxZ?=
 =?utf-8?B?ODlHMHE1Nmk5cGdDUTlURzdleE5nOTJVblQwcjVRZ3lXaGJ6K094bWxwYzFU?=
 =?utf-8?B?bUxBMnZ4ejM3NjdRV0NYMkV4WFJULzN5NVpsK0NNbmJTZ2VadVZJdXlEMytp?=
 =?utf-8?B?R3NscGliZGM2ZHFQWXI2S3Y1RXJMSkUyVmMxa1E1UXhmUUtSM29mNGJuTVNV?=
 =?utf-8?B?YTJZZUZpZjZZVmJ3NnA0UXZ1ditVblREZzRsMFMxSUhPR1FpY3o5TEljWGNm?=
 =?utf-8?Q?DsDpCg7rSJyO+RKU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9cc969-e296-42b7-f02d-08de6f4c5c69
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR03MB7072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 00:18:09.9185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JuD/ApSSUeRI9AeK5TORHIfvFO0lRA9ygL1zsWTjayTjcYs/GdTl4O0f2AxDlqwrgvnDEYrpfaLEsGnPNevJx7H7o9HaP0/2ukybX+Ale4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6677
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



On 13/2/2026 5:00 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> On Fri, Feb 13, 2026 at 4:44 PM Sune Brian <briansune@gmail.com> wrote:
>>
>> On Fri, Feb 13, 2026 at 3:18 PM Yuslaimi, Alif Zakuan
>> <alif.zakuan.yuslaimi@altera.com> wrote:
>>>
>>> Hi Brian,
>>>
>>> On 6/2/2026 11:09 pm, Sune Brian wrote:
>>>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>>>
>>>> Hi Alif,
>>>>
>>>> Since 2025.05 to the latest master.
>>>> I do not have any issue as you mentioned in this patch.
>>>> Both RD/WR are used on the FPGA2SDRAM SDRAM2FPGA.
>>>> I tested 256 AXI3 or split 128 AXI3 x2 which is the maximum
>>>> that GEN5 Cyclone can support.
>>>>
>>>> Not too sure what is missing from first place?
>>>>
>>>> Thanks,
>>>> Brian
>>>
>>> Based on the CycloneV address map which can be found here -
>>> https://www.intel.com/content/www/us/en/programmable/hps/cyclone-v/hps.html#sfo1411577374877.html.
>>>
>>> Bit 3 of staticcfg register has to be set to apply all the settings
>>> loaded in SDR registers to the memory interface, in this case the patch
>>> ensures the SDRAM controller applies the latest configuration after
>>> disabling FPGA SDRAM access.
>>>
>>> This is a safety and correctness fix for re-initializing the memory
>>> controller in the proper sequence during FPGA reconfiguration.
>>>
>>
>> Hi Alif,
>>
>> Before I plan to undergo a test we got to understand why w/o this patch
>> SDRAM2FPGA works properly w/o issue.
>>
>>> If you have the time, can you help to test this patch with your setup?
>>> Although unlikely, we want to be sure that this patch will not break any
>>> existing GEN5 boards out there.
>>
>> I might be wrong, I think static cfg has been done already?
>> Does the code here if not wrongly understood already finished that static cfg?
>>
>> ---> Quote start
>> void socfpga_sdram_apply_static_cfg(void)
>> {
>> const u32 applymask = 0x8;
>> u32 val = readl(&sdr_ctrl->static_cfg) | applymask;
>>
>> /*
>> * SDRAM staticcfg register specific:
>> * When applying the register setting, the CPU must not access
>> * SDRAM. Luckily for us, we can use i-cache here to help us
>> * circumvent the SDRAM access issue. The idea is to make sure
>> * that the code is in one full i-cache line by branching past
>> * it and back. Once it is in the i-cache, we execute the core
>> * of the code and apply the register settings.
>> *
>> * The code below uses 7 instructions, while the Cortex-A9 has
>> * 32-byte cachelines, thus the limit is 8 instructions total.
>> */
>> asm volatile(".align 5 \n"
>>       " b 2f \n"
>>       "1: str %0, [%1] \n"
>>       " dsb \n"
>>       " isb \n"
>>       " b 3f \n"
>>       "2: b 1b \n"
>>       "3: nop \n"
>>      : : "r"(val), "r"(&sdr_ctrl->static_cfg) : "memory", "cc");
>> }
>> Quote end<---
>>
> 
> I forgot to quote the func call location:
> 
> void do_bridge_reset(int enable, unsigned int mask)
> 
> During boot users are supposed to use bridge enable to
> control the needs of the HPS <-> SDRAM or H2F F2H LW etc.
> When calls if I am not wrongly understand it will reset and
> simply do that static cfg and simply do not require additional
> calls.
> 
Thanks for pointing this out, Brian.

I understand that you saw potential redundancy in this patch's explicit 
re-application of the SDRAM static configuration, which may already be 
handled by the existing call to socfpga_sdram_apply_static_cfg() during 
bridge reset.

I would imagine your current flow works as the current code already 
applies SDRAM configuration changes at the correct time during boot or 
bridge reset. However, there are some cases or sequences where this 
apply step could be missed - such as during partial reconfiguration.

This patch would then be needed as an extra safeguard in cases where SDR 
registers are updated manually or outside the typical bridge reset sequence.
> 
>> Thanks,
>> Brian
>>
>>>
>>> Thanks,
>>> Alif
>>>
>>>
>>>

