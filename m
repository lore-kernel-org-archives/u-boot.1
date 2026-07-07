Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FDCC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 10:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FF60848EB;
	Tue,  7 Jul 2026 12:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ABc1pul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F3488494B; Tue,  7 Jul 2026 12:50:23 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4777E846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 12:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ox7F6EoO34k4WnHZtGTEpj72LSGzS761t7yBjXVxgW/9ZbNK8XA++CMl0QnljrbRq5wlctWd0ri/zH9gI3x525zPg+O4N3efQYuxtGkohxvuMNXeIbs1jK54+Y6/nW/El1jMCCxEMkOb0sH5XcgKO76jSAZyWJzKH4jvcWo2kH0xW7BeBy9D8N994aghWkUUELQF1Q6sNv+3FBb4ypAc3Dbu4eNB1S9L6EdHghwCnJHVfqejEsFOMSJITR5kDLSx6mihXQrbuSFYJ7/N9MCNxbLCupvcu0N2l5fZx15K/emmPm6ICzgUSmzTrQsnrTO87iLDqPD7kFtXsykc2hdXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X63jFZaJy2xTynyHn5UBVOMwPBuT7bYY7aelekVoOg=;
 b=X6O8lkAy4HHamg2Q9az6iEBQVqhdwk+ZAEl9ZssjKVBO3mQ4c9A7TItc9nmdGJgBfK2FKuOypiFgRwM1mB9V7+9cSBFvlDLC66PHATiGTTPfet7xrmM2INWiYA+WgLFtCL0gUwRdVcD7IUef3kuLwd7LnT4u5HU1Rx20MqfpIZxN+pObCKFniTuMP/IVjgBiR6JgHklaaNXFSYv9IX6SFzGLoRrdrgbwhzdLhtW67TPzIM2Nz7AdvY6X8zx1ZY/6KqZG9xB8OrePIvP42I0+C2ei0683Hoeh1jLVnMG4t+d0glBUa3o3iyGpACsYzB2OtAQKaGYpWogPWjNXwvYRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6X63jFZaJy2xTynyHn5UBVOMwPBuT7bYY7aelekVoOg=;
 b=3ABc1pul6FjkWM29ueeP3NycHp6VlAN5b3I4URzak+qyMVtFq/qHUNjFycu3jbYh2ra6qCf77klGpyGtrIfbbA6H5m7QPBrFGwf/B0Ot4drK53YVOHS99pt0rq8sQfoRrv2VJzID/byquBedjYH9cLF7PBPV5sJQY/0EOW/F8C8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 10:50:13 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 10:50:13 +0000
Message-ID: <18262c85-9bf1-4c4f-a4c6-7590c491c4f1@amd.com>
Date: Tue, 7 Jul 2026 12:50:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] configs: versal2: enable I3C support
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, padmarao.begari@amd.com, Tom Rini <trini@konsulko.com>
References: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
 <20260701102754.345049-4-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 xsFNBFFuvDEBEAC9Amu3nk79+J+4xBOuM5XmDmljuukOc6mKB5bBYOa4SrWJZTjeGRf52VMc
 howHe8Y9nSbG92obZMqsdt+d/hmRu3fgwRYiiU97YJjUkCN5paHXyBb+3IdrLNGt8I7C9RMy
 svSoH4WcApYNqvB3rcMtJIna+HUhx8xOk+XCfyKJDnrSuKgx0Svj446qgM5fe7RyFOlGX/wF
 Ae63Hs0RkFo3I/+hLLJP6kwPnOEo3lkvzm3FMMy0D9VxT9e6Y3afe1UTQuhkg8PbABxhowzj
 SEnl0ICoqpBqqROV/w1fOlPrm4WSNlZJunYV4gTEustZf8j9FWncn3QzRhnQOSuzTPFbsbH5
 WVxwDvgHLRTmBuMw1sqvCc7CofjsD1XM9bP3HOBwCxKaTyOxbPJh3D4AdD1u+cF/lj9Fj255
 Es9aATHPvoDQmOzyyRNTQzupN8UtZ+/tB4mhgxWzorpbdItaSXWgdDPDtssJIC+d5+hskys8
 B3jbv86lyM+4jh2URpnL1gqOPwnaf1zm/7sqoN3r64cml94q68jfY4lNTwjA/SnaS1DE9XXa
 XQlkhHgjSLyRjjsMsz+2A4otRLrBbumEUtSMlPfhTi8xUsj9ZfPIUz3fji8vmxZG/Da6jx/c
 a0UQdFFCL4Ay/EMSoGbQouzhC69OQLWNH3rMQbBvrRbiMJbEZwARAQABzSlNaWNoYWwgU2lt
 ZWsgKEFNRCkgPG1pY2hhbC5zaW1la0BhbWQuY29tPsLBlAQTAQgAPgIbAwULCQgHAgYVCgkI
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
 03fJOwh+82aQWeHVAEDpjDzK5hSSJZDE55KP8br1FZrgrjvQ9Ma7thSu1mbr+ydeIqoO1/iM
 fZA+DDPpvo6kscjep11bNhVa0JpHhwnMfHNTSHDMq9OXL9ZZpku/+OXtapISzIH336p4ZUUB
 5asad8Ux70g4gmI92eLWBzFFdlyR4g1Vis511Nn481lsDO9LZhKyWelbif7FKKv4p3FRPSbB
 vEgh71V3NDCPlJJoiHiYaS8IN3uasV/S1+cxVbwz2WcUEZCpeHcY2qsQAEqp4GM7PF2G6gtz
 IOBUMk7fjku1mzlx4zP7uj87LGJTOAxQUJ1HHlx3Li+xu2oF9Vv101/fsCmptAAUMo7KiJgP
 Lu8TsP1migoOoSbGUMR0jQpUcKF2L2jaNVS6updvNjbRmFojK2y6A/Bc6WAKhtdv8/e0/Zby
 iVA7/EN5phZ1GugMJxOLHJ1eqw7DQ5CHcSQ5bOx0Yjmhg4PT6pbW3mB1w+ClAnxhAbyMsfBn
 XxvvcjWIPnBVlB2Z0YH/gizMDdM0Sa/HIz+q7JR7XkGL4MYeAM15m6O7hkCJcoFV7LMzkNKk
 OiCZ3E0JYDsMXvmh3S4EVWAG+buA+9beElCmXDcXPI4PinMPqpwmLNcEhPVMQfvAYRqQp2fg
 1vTEyK58Ms+0a9L1k5MvvbFg9QARAQABwsF8BBgBCAAmAhsMFiEEZzUMm/XM7ptTZDVqN3x/
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <20260701102754.345049-4-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::9) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 966b303e-ebd2-4706-2615-08dedc158605
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: GC8CFd79ek0yQisB7VsUVr2zbr3DvgVTNJOHwgEQB2eV9wrQQjC0fVeYaItlzgIX5Rt7WHIxV6hfhRHRhKM0gxRJidgbqkXbVIBdacme1GradXsTbzmZxBGaGRzVwYbBDnmunbEWLUU2SZ2xTSuTD1HZp6nm+XOiyRjICUDqvqCzTZy+FNBExzMEVUxyGnMpHT5H4ZZ//22iayxQs4eEH1JvtqSi3f5O0CQC5OrxbPrnYREi2QNW0PNMEup4rRPi5S4SjyiPw2iiLEoc9wk/RvA6vcuRwuRi7Qj66oK9zGvCYJ46fWvfLSunBa+HufSd4jDypzf2qaepE1OE0OFqOZVzqsQMXxRn8k5+GI7b43/29KKglgN+kb7xiP7toAyWyzGVe58mTjSv3cPDuQwow86aHyUAinm0qnuJUcygjaAtn7WWTUD20CZPS6kRQEsOfm9iWF967nt2hyVIadCAicrGUodQOghkdt9rwTvBXzjldKSmJa90yjeibwcwlP2uHaQI81eW28VoRLzwt8e6EFprLtZk3JX7rg5/WRteqctTQFVnpqhSeiv5r5xrVJeMZNsq2c2ORhqcYULefazalWGgDtehwe15gHjgVl5anFzeVlqJfMx01koXpdpmPNdOcWWW1PgxbGTIWuNOUUQNiwyzzv8moiDcQ6bIdQ+pHjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3V1SVhVdFQ4OHJ3V2NhZmhQRHl4bjJObzBSc0xiRjhmN0hDSlBWMjVIaTNT?=
 =?utf-8?B?ZlJHQXR5MFQ4Yi9CNjNPSkNRMTFGdkZSZnYrZXhzMm5tL1pPd3JQcjVTek8v?=
 =?utf-8?B?dXJQSG41VmVRa00vdjlHY1VpQ3A0U2ZFeFc5eWdzcXd4Q05tck5CUmNYWVhv?=
 =?utf-8?B?V1VKM3p6T1pMeEtRanJ6dG05ZGpjVnVUNmZja3BiUndMUVRPRGtyVU1FdThi?=
 =?utf-8?B?bDBHSm5lTVl5aGpDZ1lBdklqZ3lXOEdPditIeUpjTEw1SThYMVRlSGxENmJP?=
 =?utf-8?B?WVBlWlJUZkhUbW9MOW1SbE5URlVqNlJoYW9yb1VaOGxscTc2clVZQ1dhZS8y?=
 =?utf-8?B?Y21YR1ZjeFpPZS8vanh3Um1tWnpFYzNnVC9JMnBVQThIRVNNY3p4VFNscHRD?=
 =?utf-8?B?REZTM0p4SHJqdUtkS3Y0eFlUMmcvV1NJY2hvTHU3bGhNeXhjMFJFdEJVem1a?=
 =?utf-8?B?cFhHd2kvbG1KUmpkV2UyV0FwNXVrVG9yR2g2V01icm9PWlBMZUFLRzRRZ1BO?=
 =?utf-8?B?S2RaZ0w2a0RTMEpzMFFWNnloTjVqdUNpUFQ0OC9Lc2lXMGNreWZKN096aGdu?=
 =?utf-8?B?VkUxQ3lLT2RaekgreUhwaTVBZUNPV0RkVDE0ZnpwZ1h0amI2bnYzSjBsM1dL?=
 =?utf-8?B?TU5jN1NWZ05ZTGVpR1hNc3E2VWtyR1NBU1dJMEEycEJac29QQktLZVVPVERh?=
 =?utf-8?B?N3FwZVRydVFCKzFPQ2ZRL1NNWHZtb1NGaE1oalo2UHFIT1B4dnIvV0R3eUth?=
 =?utf-8?B?N3hjZ3ZFQUoycmd4MTY0Y1pheERpcVlMSW90VjBCaTR4bStYL2txbm9kNDQ1?=
 =?utf-8?B?ZG8reisxa0VsWERtUWhUSnkrNFNuQU0zU29ZanJxVk1UV095MFRzeFdTYnRF?=
 =?utf-8?B?b3lIREhkMTZhRW1KRXJMaFMzb2VHNW1aUFdmNEk0Qy8yekdXWHhWbmRDV0Zv?=
 =?utf-8?B?VXpLQlJId2ZnMVRSYytwbVhVRy9SV2JDVEhIU3YxMkxFNmNVZFBxaUlTOGJP?=
 =?utf-8?B?YklSclFyKzdpUE1NVEgwWE1WN1pCbjRLWWQ2czIwWFdEeHBqekVNVTVrNGJF?=
 =?utf-8?B?SzNCZ0NENGlkeDcxVGF0RjMxUEtHdndrZ0hNbWVuVVZCYTlLeWIwdVpqR3dp?=
 =?utf-8?B?ZXlxR2dXUmlLWlpkVnc2VGhoZE0rTXk2SUhFU05vYkpPVWVhamNDTE1qMWo2?=
 =?utf-8?B?dDZybDhBQVB5VXRveG5jRWU2T1FPNFR6VUh1eWk3WUdwc0k2ZGg4eDNQZHNj?=
 =?utf-8?B?UCtucWFtM2N1L3hDTVBxVk1UZENmdXY4SHM5WTdPcTJkQVBaL3hQc3NyYjJT?=
 =?utf-8?B?SE9NaGR6YktOVHN6VHJoUGVCZ1BKM1hpaENYTGh2NkxGT01ycmV5a3V3M0tD?=
 =?utf-8?B?T0VkYUdYWFBmMHhMQ1gwS3FndndsSWEyUXMrTzdUa2YrNFZmMnB5QkltRFpG?=
 =?utf-8?B?dmlKcjBXcGlwQmZtTlRJa3Q3ZEVBdUIrRnlMejZVRGpLcGlVb2JOSGxRNFVQ?=
 =?utf-8?B?UlRiTm1DOUpaRDFnVW5IUlU2c1FQeXNueklma0I2QlRTQnJhRy8wMm1TVnBU?=
 =?utf-8?B?c1lyYU45UkpJVWZvR1NTekU4VEt6aE1PbjlQalgyWnhhZWtUKzE5TXNvSWEy?=
 =?utf-8?B?OHlBUnFtRWlsSlF2c0huNmRlcE5lc3pBMU5lcThqeFM5US9HeWpPRGJucFhO?=
 =?utf-8?B?ZEpqZEpKM3FxRXgwY0Vza1crMTR4Z3lHWWU5c0c5cXlYejZ5RnpDaHU3MGI1?=
 =?utf-8?B?UDZsS1NsOTlvaklGZUswSis1Q081dWRpZDR5UTlMZlltaGZqRm1hYno0V3hY?=
 =?utf-8?B?aTAydG9PZkZvQnJTR1VpZVpoR0t5TXQrSEEyZHpsVE9GVGJHMC93UG1qbzNN?=
 =?utf-8?B?ZnVYOHZzeHcwTS9ncjI4V3YzNy8wclRNdGpVNWVrRGJVNUNzL2RNUWZSRy9N?=
 =?utf-8?B?MlBtM2I4KzZDSkdFZk5iK3J2ZVVzcTFaRjl1Q21JZVZJZFoydWZGOWFWTEhR?=
 =?utf-8?B?VnZIVWZZekJKNFpkZ0xsZTlIakNkZnpUUTk5YnlvNHFZUWFQNyt3R2VNY2tv?=
 =?utf-8?B?Q3VSRVEyZmE5dzBjZC9kNFdORFZUWVBKdDhPZy9KNnRCcHhRb0dFZm9SRTZW?=
 =?utf-8?B?VW1zSWhRaS8yNmNTTDFOQkZiZkV2WTl3ZFdHK0NKakJVamhKY1dwR1NjMTBK?=
 =?utf-8?B?UjFwdjJDSXdDNEROWWRtWXBlVVRPNkNNSHNlKzYzRm80V0VMRU9IaGI2WTE2?=
 =?utf-8?B?RHhNYTBaeU5zOWJGTkUxeEJrSGN1dngzYVQ1V3pRSHhNcjJIcG8zRUlXODJ4?=
 =?utf-8?B?S2VLS0RDaVp3VTd1YjhZWkwxRmtwb1h3ZmNMODU3UythbXNuSy9FUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966b303e-ebd2-4706-2615-08dedc158605
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:50:13.4864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn5cPuMiBXZdJkdxaphuguF0r8WXqkbFbANQ+Rvsjjyw1ykLNXs/XTXHLlrIZd/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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



On 7/1/26 12:27, Pranav Tilak wrote:
> Enable I3C controller driver and command support for Versal Gen 2 by
> adding CONFIG_CMD_I3C, CONFIG_I3C and CONFIG_DW_I3C_MASTER.
> 
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 61e3671ea4f..e14981695d5 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -41,6 +41,7 @@ CONFIG_CMD_CLK=y
>   CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
> +CONFIG_CMD_I3C=y
>   CONFIG_CMD_LSBLK=y
>   CONFIG_CMD_MMC=y
>   CONFIG_MMC_SPEED_MODE_SET=y
> @@ -93,6 +94,8 @@ CONFIG_SYS_I2C_CADENCE=y
>   CONFIG_I2C_MUX=y
>   CONFIG_I2C_MUX_PCA9541=y
>   CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I3C=y
> +CONFIG_DW_I3C_MASTER=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_ZYNQMP_IPI=y
>   CONFIG_MISC=y

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
