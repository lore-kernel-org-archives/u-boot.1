Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429B7ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93C4E8902F;
	Tue, 10 Sep 2024 14:48:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Yc8AeTvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BF889052; Tue, 10 Sep 2024 14:48:51 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68BA8902B
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:48:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSe/mArAS+plqGk1kMiSjf4M77nODe69fp5rA5vMIi8ZA28m70FsaFsLeOh1u1/1a2hA5TaqpBTo16wQvW6B3GPOsstRJTXdqY77n51XWDDYpzz+JpbXirvGJ3ny6KVKykdmSaKBegv0x3QK+Q43lVA+ack9r5KroVZcBvhes8izb+vFXShzQG5QFbk602h7KBNZ7Q0sPNZUnZEiowFXn3Q4OKJbrZZZvf5tk6t8NQSyOR/YYEOkGmBYvPQLemQPD5WcgKjtrdxYFIhmIMvVBnh9wgbVTnamMrMvYhz/Ofa5QDqWvOoRWa2yStbttpSpkTE7NLKr1zhNqh71srPnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m14+LaWy3KZP6s2IUwDm8UDh/93PeqTHnGXrWgi5NiI=;
 b=Tg+N9NR47ixztYkoUO4QEANGdfMemFj0UuFZ4+E7+O2/0qleZu83dtGZ695YJQASB6f68IIL7S8nlls+8g4btOjCC7JfRvTA+fG6W8MS2SsGm6zqb0Ku/JFtLDD+OK0vYuIiROZP0Lt+l+IyKkNMKHqQGhUkxkekoasgU1b8dbUKzJ2Pftxwa7Yoawa5XAHbhyMW0PuwZfD/cpIB8jgHX7TGsCqDIbZMYVRyZlFj1q72A8vM4RDfaTa8LvXX/KXQMJv0LPRF2SfzvrI9pkiYqzvnHh6na7/ZWpqdJsZJvuS1RC8OmTg2R1mZzteOTYFvT7x3YJewxyNNcS274NBWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m14+LaWy3KZP6s2IUwDm8UDh/93PeqTHnGXrWgi5NiI=;
 b=Yc8AeTvJ14DTpSefXMwDRCSndb1D0A26rkDz5OXI6Opu5UZqy0eEca7JAneod6hntV++nxprHyh3DWqMovejTXDN7ouADveK0FQIo+43ZhxgAwoB0IPuDf2yH+ZX/OzWJNEgjjGeB/zkgiSPxGAN18soSfG6TKZJIQmodIuy+wpiQ3klEfPJ57R3D0Ro7KqWR8K/SnmiXjYX6tLzonNMlQKcgBOSf+EmkcBLZfuYuVIpt3ouygOsBmn53Wmuft+xm0T7pOde/4GLR0FTUVVsUFlAz4dtFwQLQFUiF9Hafy1yI5Z0CEFfpxCHD5smW+WyfUWn8kr7SUmXoQrDlbiWdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:134::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 10 Sep
 2024 12:48:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 12:48:14 +0000
Message-ID: <c2e836f9-bbdc-4f99-9df0-216bf2737759@siemens.com>
Date: Tue, 10 Sep 2024 14:48:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: frank-w@public-files.de, Sumit Garg <sumit.garg@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
 <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
 <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
 <CAFA6WYNdS0jZ1iESfCErX92SOL2fJSRNNLZ1a_7jHoSfOUrdgw@mail.gmail.com>
 <0ff5653f-60e2-49ee-b68b-d86801aa1d66@siemens.com>
 <trinity-13f6d284-1ea6-4a53-ad60-847791f0c127-1725470974423@3c-app-gmx-bs17>
 <331b4f3f-6b4a-470b-897d-03ac09fd9c0d@siemens.com>
 <CAFA6WYM7n+cbFFrN8nH67pYCGo9ENn5Avv-2QOMA4U_ws+9ogw@mail.gmail.com>
 <62a7a500-0d56-49db-8e6f-b88fc4c84328@siemens.com>
 <F8A56817-F488-4B94-8ED3-1A29EACAD137@public-files.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <F8A56817-F488-4B94-8ED3-1A29EACAD137@public-files.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bcb7a52-c847-439d-e06a-08dcd196d60f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UjNrTFdvRlZ2ZURvZTBRRzhEeXYwU0NjeVJHb3BvdzhIaGtEOXdGL1NveVQw?=
 =?utf-8?B?aUtuVVVyM3NIc2hSR0phVE9GaGhPNXNaNVJjOVkyUU5UTVVDeUE4VTBiNkh2?=
 =?utf-8?B?QjBhYzhvMUxEVW5FY3pDNWFPR1JMRWlKZnQrSlJQWjRDbVRkcXFuakJqMGxr?=
 =?utf-8?B?ejRJTU9tMmtuNzV1TU1ySldpazN2YkI5NzFsUDZuUTVTOVp4NUdJU0pWWEM2?=
 =?utf-8?B?R0RtMU40T1FtT2VGcWQ0RG9meGJWSTlkTXd4bU11aXE0YlhGTFNXN1JCeDR3?=
 =?utf-8?B?L1FsZWFBZXFWQUxKd3ZiU3NuTTkvWnlKbmFMT1BDcHB1VlhtVUJEUlJkeFRi?=
 =?utf-8?B?SDJKT2V6R3poMXRCT3NncXdjWjh0K1NpNStDcUlMdS9BM1FFQlJlY0lDamc3?=
 =?utf-8?B?RTJ4Rm00QStWMWVoNnhDaFE4VDhLb1BCYklldWZLSTV6dS9JNEVQam9LR1lo?=
 =?utf-8?B?dkJRWU1BcUN2U1A4SmlqdE9ob1NqRTFjek1yTmZHQkVTOEhtS0s5YjFBSHFE?=
 =?utf-8?B?NWJtVHpuN0I0WTBFRVRhSVkxOUJBZUdtR3c2ZEo4N0c0MjMxbmhKM1grRlNz?=
 =?utf-8?B?T21HZm5xUjFMWml6dXdwMmdQSG9UaHlieDhXQWRLYk1CV1laQ2dhWjd4TDdP?=
 =?utf-8?B?M2hicHl5UzJnOEJ4Z2Y2MEF3b0h4cUQxSXdpVnU4T3JBQ2wvaHRHRi8wZHVH?=
 =?utf-8?B?ZDZjN3dielhidi96UTNvUGF1bzl0QXJ3WGFBZE52NnMxcE1zZUU1M1BoTzlL?=
 =?utf-8?B?eTFJeERwS1hlU1ppVzU2R0o3N05xVEJDOUJKUGNXNGpKYzB6NmIyRzQvRWNW?=
 =?utf-8?B?NUpEQUI5Z1lYenBFTjhrd2lpK2owYlRUWU9MQ2V6R2VJUkxFMmJuVWlJbWtw?=
 =?utf-8?B?UURZWnNXbTdFbFA0dW5PLzU0RStRNEZ0aUNxcUVULzdsRGRmVDJCOTNrMzlx?=
 =?utf-8?B?K2pPR3A4TEVoVDlxb3M3MCtkZTgvTmdMNHVpWnowYjROdm1wakNEbE8wVVlv?=
 =?utf-8?B?ZjJjdEdzaWFEQXBIYzVRTVVGaCt6VmlLbTNnQ04vc0RXTVdwblFXM1NOVmFz?=
 =?utf-8?B?cHh0NnI5WmdPSHRYS29EM3JNY2xDSXdIZ0FTOGJMRUZ3dk16L0wrUE9XdFJX?=
 =?utf-8?B?WGI0Z3VQWDFTZWlGYko3dHJ3NFRNaHNsZGlzLzRlcTVqUEoyRFRGUUxOcnlW?=
 =?utf-8?B?WDhVdld3YnJEWXlWN28ra0h6UHl6NW1EakdDYmZyb2VuZG9MUkttWFo2aDJ3?=
 =?utf-8?B?ODNrd2MyYkQraUhKOXExbDJ0bGNnVVMwUUNRYllQNTJrSnhieHNySW5YY0pR?=
 =?utf-8?B?NTFudHJTMWNid1A5alQ5VXIzWkhmS2ZhT0c1RDN0dC9iVFhTaU9TWHUzWExF?=
 =?utf-8?B?eUJja0xRWDJxZStONExxRlhKcE5VNVBPWFpreldnNHROa3doaHl2M1g1Q2RI?=
 =?utf-8?B?NGI2aFVXcmFja2tZT3UreFh4VWVzVTNUWEVSU3hJNXRLY1RKSEw1QndaZVpk?=
 =?utf-8?B?U3l0S1FMczVBcDQyOSswSk4rcjZpK21mcmxDREVmdUN3RHFPNUVlR3ZKaDNN?=
 =?utf-8?B?WFRFSTREaEpuUDRhMXRXdmo5NEYyaUI1a1BqSnRITHNZWGtvbXBQVTUwZnZs?=
 =?utf-8?B?YUw2S1luOFc1aXUvSnRXdTdhbkpkeVlndmUxZk41MThEaU1wRlI3cDdRV1J1?=
 =?utf-8?B?YjdhTVIwS2pla3pMbC9sRWdjZWxUNml6RlpuRGRuWUwzNGhYVEM1Uk5nUVNQ?=
 =?utf-8?Q?KaXZUo6vF0w/ceJb2Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElYaENWMXloRjRXaUwwVEh5ZHpjanhMV3BBbEd3ZXJvVVB4MzJMZUJZQ2Za?=
 =?utf-8?B?TVNZSVJKL2ZPSEkvMjVVM3pQMnJOemhISXg5L3NESVJJWUgvMWlVMEIxTlZM?=
 =?utf-8?B?Q2ZOdHZrZUlabkpzOFU0a3MyYkMzbFJhQ1FSVXVCVi8xZmY5TGIwYVdFUHAw?=
 =?utf-8?B?dWFxWE95c05BM2xYcGRTRjlYWUdRQTRRNVJFZy9qWlp2bndmSitzS0hrRGpG?=
 =?utf-8?B?UWxKSUl2alYybWR3UWtpQU5ycXZ2TEF2djZ5R0k5Um1SeE9ScEhyRkQ4WTh0?=
 =?utf-8?B?U28wL3RvUkxZYWw5aURscmt2OHlYak9MeHAxTWp3NUZVaFc3QTJkaVFBN0dq?=
 =?utf-8?B?ZU1XZDY3VTB5QzRHZ1RremtWdERUYUxTUTBKTjNDY2c1T0M0Q1EzMVVhUmhE?=
 =?utf-8?B?VjFyUzVpamdGZ09UanhxZWV3R1RNdmczMmhlMmh6MWhZYUZ1M2c5K0lDRDNM?=
 =?utf-8?B?dlIzMExHVy9oQWRjc1FJL0x3OUZ2ZmF1aDArL2E5NTFXNEtCcWlBdU9yQjJH?=
 =?utf-8?B?MzZEcjJjMDUySUwvZXI2TEhWMkhSQUVLSGVpdkxVUTJidTRuVTRBa0tCVDhQ?=
 =?utf-8?B?bE9FZDNHY2JDWEpPUW1LMk1scml6S3U5UXUzVk5jOE1sSnFFQlgwcXhSbzhp?=
 =?utf-8?B?dzdZdjRrZzU2UkxHclQ0M0k0QXpOaXV6eHBFN0lETmg5V2dKcUM3Q2g5WDEy?=
 =?utf-8?B?YjltcTRrUUlxR0REL2crc2lmaUpLSGV3bjJsRGhCbnRFRU92NGRaTmpoaG5r?=
 =?utf-8?B?Vm5HcmNyWXl5cjhZT3ZzODNTSzNna2VPVFVOV0ozb1RyWkxPdjc3ZTRJaW5T?=
 =?utf-8?B?TmdlQzNKMXFwTG9NNVZMY0FiVUxQYVhWQ09oaHNKZDZEbUdXMURDbnFTbW85?=
 =?utf-8?B?TjZXaC8yRjA5dFVMbFZWcWc2N3FwRFhTdFdmS1laZjF0ZUxjSEhsZnQ0NGpq?=
 =?utf-8?B?Y1NyMFdmaFBmazRpZkFDMnJZQlBSZkozZUJFTHhJakZzK2Yvd2YreE1ZNWVW?=
 =?utf-8?B?emN4Ri9McjdJUEFkeG55Z2RCRjJEU2Y2VlJYQ3ZtQVFuYkR0a1d4YXRZYUU0?=
 =?utf-8?B?cTBDZVFZSkJDYlBhcVA0cC96RVVvVm1Qd1ZCUUFsYUkya3BkeURYUkxnVlRE?=
 =?utf-8?B?d0xHU2RPSHc5bm1sYW9JUkl0RWVLTTB1QzAzMVdaU2ZEcjFCdy9aSlRMd0h4?=
 =?utf-8?B?cWlFK1MrajRVM1pCeHkyTkdWZWkvcGRaNTk1Qmk4MUNpMjF0bXVzVDMrR0VX?=
 =?utf-8?B?ZnROSFpSMDg4Vy9zTmt4T0FMZ3V1Wk5PdTNzS0pEVlFJWjNKRWpvdGR1UTVN?=
 =?utf-8?B?WjlGRnZIclkyNzFSTUVxZFdLOFdSZlpRNXVmY3Ezc2JZaUFyVHFZY2h0Qllv?=
 =?utf-8?B?SzBrYWFZdmVkZDRQMkJqaldES1hDd3c0eDYwemZha04yWkpnTUdXS2s1R2Ry?=
 =?utf-8?B?bUZoL1FpMlAvTm1SNE96MjBCejdqeitBY1hIUGY0TXNDdmVDTnJzQ25MSnpu?=
 =?utf-8?B?RnlBQm9OUVlHTzVSYUZ2RzdabTUvcEZuZkVUWEZFOThYbGwycHZValJQY2h0?=
 =?utf-8?B?eEE0NnlrTGRDNGNBaFpDQ2JlRUMxN2lCakZXdmRpSHE2dy95MlROUVlXbHVW?=
 =?utf-8?B?UHpxWVpqKzhvb0NQNjNRaTQrcXNxeHdYOWNlUE5OckoyR1ZHTXI0a09IYVlU?=
 =?utf-8?B?WWlZdTNIOHV5KzNiUkZUcEZFb1RFTzNTSUdXMXhzUTdNYlp5MktDMnBkdk9X?=
 =?utf-8?B?MFdoaWFEMGJtS1JtdEN5ZG9LRUZGV21vWTRLUVlNTHJEa0dLbWh3b05EMUN5?=
 =?utf-8?B?VHVhbkJlU0czRzdJZDErazNHL0o2TTZSREhNVkpjWkJaWjl5b1RzTXAwSTk0?=
 =?utf-8?B?NTVWYXFDQno2YXl3T0JvckNBbFNOTXh2cEw3ZXhWRWIrKzBvZ01hT001SEwr?=
 =?utf-8?B?amVnazlxMDl5K0pCbnBWeFFDNEFYWVhRMFQwL1VLSEE3Y1g0VkhzN0Y1SEhi?=
 =?utf-8?B?TmRTcm95andHZ1JFZEJTNDIrVkJPYlRXdG5uR25lNmVxMkQ5TmJMcG5QQ3lQ?=
 =?utf-8?B?TTFXMmdzZXcwbXNOMmFsMVRnZ1dacjBTN1hSdjFPQzhpckFZeU05dDFoeDU3?=
 =?utf-8?B?YjVFcFRrTFNiZERZVHlBVGFheGNnZEFDWVpvdDhZbEcyYmxXd3d5Mno4YUNn?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bcb7a52-c847-439d-e06a-08dcd196d60f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 12:48:14.7419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpuIa4+xjYIBM3z2TU0ILU6F8FB+NMNhSIzjFHeY7ueos3MvgsNxLXnKwr6pxqanPA/uGlMqwJuMnq9qXZF11Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3672
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

On 10.09.24 14:36, Frank Wunderlich wrote:
> Am 10. September 2024 14:08:07 MESZ schrieb Jan Kiszka <jan.kiszka@siemens.com>:
>> On 10.09.24 08:38, Sumit Garg wrote:
>>> Hi Jan,
>>>
>>> On Thu, 5 Sept 2024 at 12:08, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> On 04.09.24 19:29, Frank Wunderlich wrote:
>>>>>
>>>>>
>>>>>> Gesendet: Mittwoch, 04. September 2024 um 19:16 Uhr
>>>>>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>>>>>> OK, our overlay sources are on their way into mainline, will only take
>>>>>> until 6.12-rc1 to get them here.
>>>
>>> Glad to hear that.
>>>
>>>>>> To accelerate the preparation, I ported
>>>>>> that change to a local branch - just to find out that OF_UPSTREAM has no
>>>>>> clue about DT overlays so far. And it is not just that there are no
>>>>>> build rules for them (that was quickly fixed). It's also that there is
>>>>>> no way to trigger their build for your u-boot proper.
>>>>>>
>>>>>> Are there plans for addressing this? I'm inclined to revive my patch
>>>>>> that allows to augment dtb-y from the board's config.mk. Better suggestions?
>>>>>
>>>>> Hi
>>>>>
>>>>> i hang also on this part, in my case i build the dtbos for the vendor and try to use fdtoverlay to merge base-dt with the defined overlays.
>>>>>
>>>>> see commits till July 11th
>>>>>
>>>>> https://github.com/frank-w/u-boot/commits/2024-07-bpi-ofupstream-all/
>>>>>
>>>>> this fails because the target for fdtoverlays needs targets for the dtbos (have used the fdtoverlay target from linux)...
>>>>> but i build then without dedicated target (while building the basedt).
>>>>>
>>>>> maybe you can help solving the "small" problem in makefile.
>>>>>
>>>>
>>>> This is close but not quite the same scenario because I only need "our"
>>>> dtbos, and there is no need to create dtbs with them applied (they will
>>>> be used during dt fixup in our case).
> 
> Where do you apply the dtbos? In my case it is
> necessary to build the dtb with overlay as we have
> no way to detect which overlay needs to be
> applied.

In our case, during ft_board_setup, thus dynamically:

https://source.denx.de/u-boot/u-boot/-/blob/7b2d4ecd7f6593771dd3118c8bab525d727a91e0/board/siemens/iot2050/board.c#L474

> 
> We have overlays for different mmc (sdmmc/emmc)
> and spi (nand/ nor) settings which cannot be probed at runtime (or at least we have not found 
> a way to do this).
> 
> 
> Maybe someone can help getting ftdoverlay target working in uboot with the dtbo list.

Yeah, that would be another path that requires additional work. Sorry,
I'm not familiar with those details myself.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

