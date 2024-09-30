Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B828DCF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 06:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E2D188D9B;
	Mon, 30 Sep 2024 08:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="x1b0FPAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0B3D88CA3; Mon, 30 Sep 2024 08:10:52 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8574288D86
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 08:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fi+N8dhsI/MppeHGyRjgOuIrA9d+pWW3dunjbzCIsSxo2gO6ZCjdsx6n7A9hKm5EotEKZKkJbM/sbfCosOeYiPOxfuYszAejsAfOGmKOGi8Xs8F2zzkRNgh49TsWPA6wVJ2nhADw+x00QA9k/9+eFHdKDPU7bYlBrEiDHxhcdguhYsMPltZhV2vdTCNR5LZ8p78BVBScNc4LRkCHDtsfex+1WNy0Ci3acBiB6/Aagl/KMliPqY7FjDiNOIlMY6WiGOYjJN9833iXQ/J9lez8MHICi6MmCyDJxm7QibRYbLlHHrtcKTLVyG86rRPx+dNIiivyyPhxcWEDsRxRTwDmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZ5gHPCki3DrtehWaQffz6uR8xnid9W9HSP9y/d/o+8=;
 b=IqyYLcnP8j5lldrL1rNoNHcMuNZJ/oAvjz0Y79GVnMNUVEHcpX/iKb2nH/fJ2ipWlV70uHLd4WEhRb8w1iWWWV47twf5hOcFsk7EZ1RJ85CdZWznAHq7z+ccWdTQqJvGloDWIpCDSh9ZJ9YnDS+U+7b+za4RfbKAX7pO+JO0v8yy6DEleMDST9Y0LLW+yBi+8ZkE0ER25UdbFB4kH27nttPw6ASNopAHdgew1/Xiwa1wksc4Ii/gGh4hpMRwtjL8VHLlTk+y3wfW9VtMQ04mPpwiQniwHUnH+JXj2/9CqZITyTJu2hHVl6QI/ZheUY3tnuJP5Nu3X8f4QECOKTO9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ5gHPCki3DrtehWaQffz6uR8xnid9W9HSP9y/d/o+8=;
 b=x1b0FPAp6a1u0RQNrWX1vZcUnWVUZ7cYf85McGj9vY7pSlqIHq3Cweg5AGbW24G5/cqzKD8jUXGJLZu9nClPxFJpxivUzsUeQ9H4UvN6gW1uJzim7gAL28IntYQaEonlycC78YxSq3ZPIvLThpfComePW0P5eiKe5suHlog9nmQj3u9H83kEPfh8Jw1lJNR/pIc6W3/GqxuX0IEUDOzDTjY3qF+1BBsJWbQnON9bMrTIy7cyHSbcgKOSqYIHI6PrHpci4OOUu7IWoojlL6OHVSvkYxUcJSyuS/o2dYgy3MdPlS1Jta9h6TJ7lpjavUi3pigjcMg79qQuTE9es2c03Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB5819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 06:10:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 06:10:46 +0000
Message-ID: <67761100-c52d-4949-8da3-8783782c44da@siemens.com>
Date: Mon, 30 Sep 2024 08:10:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dts: Add ability to build DTOs only from
 arch/$(ARCH)/dts
To: Sumit Garg <sumit.garg@linaro.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Lothar Rubusch <l.rubusch@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
References: <20240927214955.394224-1-marex@denx.de>
 <20240927214955.394224-2-marex@denx.de>
 <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAFA6WYPPXDJC4kSiBAR=jL-Z0v3a8+=_=+hLx+Ug0+yu407y3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e54e1c-97fc-4d40-1ac0-08dce1169f8c
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUxqUHI4OE1uZlNHNGEwRE9mVmNwTEMyaFJUS1luRjN3aTBhV0x1Mmhrc09t?=
 =?utf-8?B?RGNscm5aS1VwblRDYmt0R1FSbDRQQ1NiWE9MQm95NDl5Q0xCRU9tdlBKcVlO?=
 =?utf-8?B?MDN4QlROalVpQkRpOUpBSURDSHlIWnN3RFVlblVhVU0yeVlzQ3VHcEZoTE9D?=
 =?utf-8?B?SlFTYnBMM3A3bS8wbWMyU3FsaURmRy9ZaHhIbnB1NWprYzdqL3ZXbWZ1ZDZw?=
 =?utf-8?B?K1pCc1ZRMUJGM2FESXhWcks0NmtUMjBqNVB1UkpCbnRzYi9HVDRlazJNdTVu?=
 =?utf-8?B?OEN3NW5ka1RlQnRHS3M1Y0hPZjFmT3orSVUyWk01MTVobUpKUUlIWFhRaUF2?=
 =?utf-8?B?QkFOcDRud3BWbXNidjdYWWg4eThEUitNYWhJQU8rdEJtSjB6QTlUYUh2ZHcv?=
 =?utf-8?B?RHBSVHpxYmlDemxYNXVoTzEvdlBrb3hzTk9HWEwvSXBRRzIzRmVWekFFMXFC?=
 =?utf-8?B?SkhYODRMY1RHaVVGbXRwQkhESHZoRituajlxMkhZVDJ6OCtlbnhndW45UzBj?=
 =?utf-8?B?aGo5OGxqRmxwSjIwK2JLbEtBTmR3VDlUQmx2RkpjL0U0SkRoTGk1WVVMODgr?=
 =?utf-8?B?ckczdTU0dEtpS2hZTVFqYm1kVGs5MVYwSUl0bEl5Skp3QWxieU5XbVh0RXlF?=
 =?utf-8?B?Ylc4d3pQckhzWXRMNzJhWEM2TERUQkVjNEhPMEIzTDlubFRsY3I1K3FoNFAy?=
 =?utf-8?B?YTlhUzN6T3dwSjJRZTlUTGFQbW5tYXhMMEYyM25oQXUzTE96aEE0NHpFZEpS?=
 =?utf-8?B?MDQ3Wk5aeWZtYkh0bzJlT0tpTHA4eFY4c1BCRzE1ZG43dFRXbUZneGlpbVhT?=
 =?utf-8?B?d29WaXhkRzFNYVZjQ2hIQUhscy8rUDJzaGdMVGxrejc5aUh6WGFIbEhOdnJC?=
 =?utf-8?B?OHRnbnVrUFVKcmo3UFJZYU5zb2xBL2xubEp4OFM5a2JlbHVZZTRZZDFOTDli?=
 =?utf-8?B?NUJibnNJRW03cEpqMGtrK3BwMGRKM2JvOUQ0L09HNisrOEJySzVmN2g5T3Nr?=
 =?utf-8?B?RmhiZVFjTGpoVFJIbERYcDlURnpIWmx1M3FjKzd4ZGZFYVJKRlprc09kVEJW?=
 =?utf-8?B?cWRyaWV6NjJPbFZrZ2tveWk5VnlMVDAxUWhOS09PVStOK01ydHd3cWpEYm9u?=
 =?utf-8?B?OUE3aWN0cGFDQSt0THk5ZUk2cGs1ZVhzck1SN0JEQlRaS3NtNUQ3bkNna1V3?=
 =?utf-8?B?OVI3ZTZqRVh6UStmMzYvazhQMjNiUkFOaXpXTk04ZnRQSWRKVjcraW1FODVx?=
 =?utf-8?B?ZmE2SXpuSHNHV1dOazg2WlAzT1JOOHNkRitVVnhYZnc1d2MzcXFGTGtIR0N4?=
 =?utf-8?B?elBXekNOTWNSNkl5ZFJWZUhOYi8xUHNXaHRWZVNub2dxd0V3WnBsb3ozbHVw?=
 =?utf-8?B?em9UcytpRWRNRDlZWWVQcCtuVlV4UXpzMWJZR2FTekdlbmpSWFJleHQ5Q2FO?=
 =?utf-8?B?Vk9zanpkVUJ5VG43T3pybG9ITG1kTG5KVlFDVzU0eVFDN2FueXYzdjZ6LzY3?=
 =?utf-8?B?MndlSkIrL0lUOENrTWpsa0R3d2ZibHdQUEF4SEx4S1NQeGxES09zb2F0QWhD?=
 =?utf-8?B?RWphYUpkNDk0eEcvTUQ3ZVlyLzhHdm5IZlRBYVpaMmljelRxZFJGZEo0amwr?=
 =?utf-8?B?aEtBbkVSU1loamJBb1pwQmxMZ2RRU2t0RVNQbzQ1bU9Zb3Btdk9FQ0QwcW13?=
 =?utf-8?B?aGYvK0VyVktOUnhxSU9YREFqQUdrOWxCdUhjNXg2YjU4SlZOQ09aQy9aamxN?=
 =?utf-8?B?U0VBU3FLOWc4MTNtRkZyODh5RU5sRDdDODQ1RGpQRWl0WG5ZUHFnK25VUjRX?=
 =?utf-8?Q?kd4Zid8+YDaACZs0SS5TuL+CiHRXUhxzuteBU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUlhbWFqZ1VzVmU1a2I2ck84RXpVMkttS1MwZmsyVTBYdmFYTmF1ZDR2NDJu?=
 =?utf-8?B?dHEyem1pNS9ieDE5Z1pBZUQwZVczWHE4TXBWeGcrRldwS1pMSndweTEyM2dH?=
 =?utf-8?B?UEN1aEhlcWVwb05vbEVWdXFpUnpZY0VFT1JvRlVkUy9RRS96UFhoR3Fpak9X?=
 =?utf-8?B?RUNSaDRUMW1kdis4UnpXVzVzNkgvUGljeUc2VXhlQmVkUGJISkxMZy9LRk9v?=
 =?utf-8?B?OXZNWnVxeDVhTTZzcmdxa1I0eG5Rb0FCSUZGVlJtOHJWTnRWTnpyQkM3Tkho?=
 =?utf-8?B?dU9wbzZ4ZXB4ZHV4L1JCKyttZHo4eHI3Zm81azFqMFBiUHpIdnhWaXNNbVEv?=
 =?utf-8?B?TkppYjZVc3dJU1RaOUY5bDJFTTVieE9vNmRHTWpZWG1uOTNGYjBGNjdxcFBI?=
 =?utf-8?B?bDVrTHdZQ3hWUGJ3Zko0ZkxZM1V2SGZmdlpFTUZwcjhlWlVRQXoyb1BPVUxY?=
 =?utf-8?B?eFJid0hkakdYWjRGdnJSQ3daT3pLOXNobUZSbExobTVFZW5VTThPRGpjY1VS?=
 =?utf-8?B?Y0dQOXJBbnM0Z1JYV211Z056Q2tVZ1pZdEJCRExUWE1jMUczeDl2OWsyV1Ux?=
 =?utf-8?B?anQrMmZ6L3Yybm9wQ05WeFU2Q3hhclR0djlCMTBiLzFMNThiT1J0WURPNDRa?=
 =?utf-8?B?QktmMG9BWHlBczVHTXFxV1NpU3VNVHJ2Yll3WUpFVFRJckFsU1ZwSWJvczNl?=
 =?utf-8?B?THAyNmppU1FxMGl0bWwwU1ZKWFo4aXhqYmpyM20wOUJSQ2U5WUdiYk5PRE4x?=
 =?utf-8?B?MUMvamUwODBEVVRsV3lWSVFYZjd0RzdXSzdRNEc5aHBNOHhudjVLQkcxNi9Q?=
 =?utf-8?B?Z3l4bVloNDhBQUZDbFBxUTJWZUdna2dRZGdRM0NVdjRzN2ZVTk1WeFFmekt2?=
 =?utf-8?B?U3VqUUx0MUYxNlVyMVJ0NkxVb1FmNWUrWFo1Zk5rbVZ2cVlOY05xdW1YRVNm?=
 =?utf-8?B?dEwvNmpTdzhUR05MRXBSVVh6Ukdqc1pSVWRGdllTQkpyVitZVHltekdPcXhD?=
 =?utf-8?B?SW05aUVaSjgwbTgwbVN4UUlrRG11S2ZSbTI0alhhUDJsdyszcFZJUS9HMWQ2?=
 =?utf-8?B?bnZ0SWNLTXFjRmV5UlBpTTVPN0dGZ3JSOGtBVmNRdXhJVW1pem16S3crWU4v?=
 =?utf-8?B?VnF4aG9BeVhvRkpWVURYZ0FQL21NbGlzNGdjVGZmc1RKd3JWQS9RR1dLZDBP?=
 =?utf-8?B?UW5sYkhHVGJpbmRoRlV6eVlUVXMrM0ZDTkJWNThmTCthR2ZzdTR3cERuRkFY?=
 =?utf-8?B?N21CU0VhNExiUXFXazFWRUdYMVRjY3BBY014dWpvZ0lnTUZFQlpRSVRYY1Rk?=
 =?utf-8?B?VFVobUl5T2lmRnBRdlpUa3ZXNWd1UHp0Z2xnM1crOWVZVHgrR3V5ei9ZYVQ1?=
 =?utf-8?B?cFJNa2kzY040T0ZjWEJmczhkRjNPa0tOU3BFZFN4VDYvellXY0JodXJqNWMr?=
 =?utf-8?B?VnFiRnZUdU5HRnc1L3F2Y01yRDIyYlBLaFlMVC9aeEtTbnJOS2owekhSMldz?=
 =?utf-8?B?cTFBZ1ZCVHVtbnVLeW9kT2tvbmlmYnU0cE9BNDlWb21nMWRQZTY1WWIwUm4r?=
 =?utf-8?B?Tmt1RjluQXBJVVZHWG1NWm43bERWVzZKczg4bS9tZGZJTElEYTJRRzBtc1Y3?=
 =?utf-8?B?ODFwZHBhMSsyRU1DQzhSV3dyYldYMHZzRnE2c3QrV3JNdkIyWVNGOHJvOU1q?=
 =?utf-8?B?UUZHWVZmUU5tOUErcFhlbURCUUhSOUl4V1RsVUJ1VEhSaUE4NFNzTGZJZjNH?=
 =?utf-8?B?bEJ6MUsrQm1iZjh1V0dwR3pxSGtVNmU5c21hRGdkWndPQVYxWlBrWWtHZy8r?=
 =?utf-8?B?SlFpN0V0Q0x3blFWSDlYSE51OE9nSGRSVmpIVTJtOU1JMEtGcWM1dHY3bkgy?=
 =?utf-8?B?dGVkWFlWeTB2NUFtSThWSWZwR1BGRytqOHpGWEhEWE05TTcrRC9TTlJ1dFph?=
 =?utf-8?B?MFkweVByQThBVjZlOGh6UHR4K1U3QUNiclNtWmtpNjZYOWNrbWdmaEZvWDRl?=
 =?utf-8?B?WnFJU3dGcGE5U3g3UXl1WFBoeG4xc0dnczNqU29WTm5BTXA5NkNmbVRteG1L?=
 =?utf-8?B?Q0prekc4cUhDcTRvS09kd2FWSHlZZzlNUTcxNk5CWWpIQ1Q3dWxBd0p4Sm81?=
 =?utf-8?Q?eVw8ePkjva5sHFWMgA9YO/Zw0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e54e1c-97fc-4d40-1ac0-08dce1169f8c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 06:10:46.2975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkHzghJMG/jkKhlHLk3L0v3npZwtzjPYfFHqg25omRREydZY9R3NuM2a4ZEKsat+hipYT/k/XFLw8+mh0l5ylQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5819
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

On 30.09.24 08:02, Sumit Garg wrote:
> + Jan
> 
> Hi Marek,
> 
> On Sat, 28 Sept 2024 at 03:20, Marek Vasut <marex@denx.de> wrote:
>>
>> Currently the enablement of OF_UPSTREAM results on the build system
>> searching for DTs only in dts/upstream/ . There are platforms which
>> use U-Boot specific DTBOs applied on top of U-Boot control DT during
>> SPL stage, and source DTs for these are located in arch/$(ARCH)/dtb.
> 
> I would like to understand the need to maintain DTBOs separately from
> DTBs. Why aren't we pushing DTBOs to Linux kernel sources as we do for
> DTBs? Jan recently pushed those so-called U-Boot specific DTBOs for a
> TI platform which were accepted in the Linux kernel upstream. This
> patch will just deny the ability to build those DTBOs from dts
> upstream tree. IMHO, this takes a step backwards on the whole notion
> of OF_UPSTREAM.

Exactly - I was sent the other direction (get DTSOs upstream), and I'm
now only waiting for 6.12-rc1-dts so that the first round to make use of
that can be integrated into U-Boot [1]. Anything that would prevent that
here is not welcome anymore.

> 
> If we really want a middle ground solution to allow migration to
> OF_UPSTREAM easier then we need to find a way to build DTBOs from both
> directories (local and upstream dts). I would imagine that will likely
> complicate building and packaging DTBOs.

I tried that, and I got the clear signal that it is not desired.

Jan

[1] https://github.com/siemens/u-boot/commits/jan/iot2050

> 
> -Sumit
> 
>>
>> Add dedicated 'dtbos' target which builds only .dtbos and not .dtbs and
>> in case OF_UPSTREAM is enabled, build this target for arch/$(ARCH)/dtb
>> to generate local U-Boot specific DTBOs.
>>
>> Adjust top level Makefile so binman would search for .dtb and .dtbo in
>> both OF_UPSTREAM specific paths and arch/$(ARCH)/dtb for the .dtbo case.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
>> Cc: Caleb Connolly <caleb.connolly@linaro.org>
>> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> Cc: Fabio Estevam <festevam@gmail.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Jonas Karlman <jonas@kwiboo.se>
>> Cc: Lothar Rubusch <l.rubusch@gmail.com>
>> Cc: Michal Simek <michal.simek@amd.com>
>> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Stefano Babic <sbabic@denx.de>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> ---
>>  Makefile             |  5 ++++-
>>  dts/Makefile         | 11 +++++++++--
>>  scripts/Makefile.dts |  5 ++++-
>>  3 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 525576f987d..fba8e48681e 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1194,6 +1194,8 @@ else
>>  dt_dir := arch/$(ARCH)/dts
>>  endif
>>
>> +local_dto_dir := arch/$(ARCH)/dts
>> +
>>  ifeq ($(CONFIG_MULTI_DTB_FIT),y)
>>
>>  ifeq ($(CONFIG_MULTI_DTB_FIT_LZO),y)
>> @@ -1377,7 +1379,8 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
>>                 build -u -d u-boot.dtb -O . -m \
>>                 --allow-missing $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
>>                 -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
>> -               -I $(dt_dir) -a of-list=$(CONFIG_OF_LIST) \
>> +               -I $(dt_dir) -I $(local_dto_dir) \
>> +               -a of-list=$(CONFIG_OF_LIST) \
>>                 $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
>>                 -a atf-bl31-path=${BL31} \
>>                 -a tee-os-path=${TEE} \
>> diff --git a/dts/Makefile b/dts/Makefile
>> index d6c2c9daf31..f872a867667 100644
>> --- a/dts/Makefile
>> +++ b/dts/Makefile
>> @@ -11,12 +11,16 @@ DEVICE_TREE := unset
>>  endif
>>
>>  ifeq ($(CONFIG_OF_UPSTREAM),y)
>> +local_dtbos := local-dtbos
>> +local_dtbo_dir := arch/$(ARCH)/dts
>>  ifeq ($(CONFIG_ARM64),y)
>>  dt_dir := dts/upstream/src/arm64
>>  else
>>  dt_dir := dts/upstream/src/$(ARCH)
>>  endif
>>  else
>> +local_dtbos :=
>> +local_dtbo_dir :=
>>  dt_dir := arch/$(ARCH)/dts
>>  endif
>>
>> @@ -40,7 +44,7 @@ endif
>>
>>  targets += dt.dtb
>>
>> -$(DTB): arch-dtbs
>> +$(DTB): arch-dtbs $(local_dtbos)
>>         $(Q)test -e $@ || (                                             \
>>         echo >&2;                                                       \
>>         echo >&2 "Device Tree Source ($@) is not correctly specified."; \
>> @@ -49,10 +53,13 @@ $(DTB): arch-dtbs
>>         echo >&2;                                                       \
>>         /bin/false)
>>
>> -PHONY += arch-dtbs
>> +PHONY += arch-dtbs local-dtbos
>>  arch-dtbs:
>>         $(Q)$(MAKE) $(build)=$(dt_dir) dtbs
>>
>> +local-dtbos:
>> +       $(Q)$(MAKE) $(build)=$(local_dtbo_dir) dtbos
>> +
>>  ifeq ($(CONFIG_SPL_BUILD),y)
>>  obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
>>  # support "out-of-tree" build for dtb-spl
>> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
>> index 1fe142f2bbf..f4d3a37010a 100644
>> --- a/scripts/Makefile.dts
>> +++ b/scripts/Makefile.dts
>> @@ -17,8 +17,11 @@ endif
>>
>>  targets += $(dtb-y)
>>
>> -PHONY += dtbs
>> +PHONY += dtbs dtbos
>>  dtbs: $(addprefix $(obj)/, $(dtb-y))
>>         @:
>>
>> +dtbos: $(addprefix $(obj)/, $(filter-out %.dtb,$(dtb-y)))
>> +       @:
>> +
>>  clean-files := *.dtb *.dtbo */*.dtb */*.dtbo *_HS
>> --
>> 2.45.2
>>

-- 
Siemens AG, Technology
Linux Expert Center

