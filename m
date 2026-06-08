Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF42ACD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC4783EEF;
	Mon,  8 Jun 2026 10:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I4R9e8UN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF5F8405A; Mon,  8 Jun 2026 10:49:01 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99849807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Su/MadY9LC61qdImDpHg9La97ZIVyhdE5VviZ90dXzVhTJEYU4hQa65q5dWwy1I6JzvVRsZtJXc2Q3AXdq0L1O5576fzj1yQNqSYjWMMXOChwrTF2yZ31jGgqTjGoHQf11qHAXSmOUqCFioGTJmWGmwoTRiEzPg7D7ESWcAapYXzS/0qEl6hoZ61NEuSFan1q54wQsSrZKuepgjscYlMrhVBWhNrSztOFyDqNsldsSlDYII5QLEe1KR7uy3UKUqtYY5AqJCZW+TrklX/niH/ZQhvYFBg1nx9TRn+Vek4Dp67w/0LyM1YSFj5XWUiHn9j9FlGkxbj1iaDsrUE83sJqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9Fa8WcwHel/EH2gROXwM5qc+0BBsLQ7mgu9MMqDUcY=;
 b=dt+rVz59u1bW5m53rpDjvHzZS+fvZs5N+LLMJ8+5yMyRuzls1ssbTlFyV4t5RtHGiuTDo7Ejk3BqpOZqd41pjtcCu3l9jEmX6HXaWPyPE/IEN/GrulcPvrQXAB6Qixg3fJnNmMPUS1npLTz8llKS5PFywi3mWyZjInc2A6uR/afNbe6WtGL+etLyFZOQvH1zCf03yEcEKI8BQZorNj8fee0Fz4/JDXzA7cD4EXOqfCqoKQuT6/N+B2dtoPODwACPujT5pvYTmcSOeIVQ6swOqSApUx/kepKQIj/qpBe87OJxFALV790aRdnkdv6B25o20xxRIrpgIRVoY4OnyiICMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9Fa8WcwHel/EH2gROXwM5qc+0BBsLQ7mgu9MMqDUcY=;
 b=I4R9e8UNbtUpBgHNmHjnnZ77PRlv2++a7G/Xh1RdZ2Ihi2BFp4Qv6JZMrOsRPhfgwAPiJFXMKseOTzb73gZcN7KSAMyChnT8RR64WWlSzabQzKRE92aapKIWLLiYx5VcRtRQN0/hR4Q0fkk5u1n03SOAwEa+yxicGP1oHD3vbWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 08:48:53 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 08:48:53 +0000
Message-ID: <590c93b8-2571-4334-8f3a-143974290c27@amd.com>
Date: Mon, 8 Jun 2026 10:48:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] reset: Introduce reset_reset.*() API
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com, Simon Glass <sjg@chromium.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher
 <hs@nabladev.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1779709539.git.michal.simek@amd.com>
Content-Language: en-US
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
In-Reply-To: <cover.1779709539.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ec6c72-1330-492e-3c5c-08dec53ac4b0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sklbxlFHdpIyfIGnLclY2JwsH99jh1io+R0g1tm9MUdqs0yj3jsqFLqbeCvEI8z3lmpyXA/nHe4jbNa6r5E858kOnhvkRNOo2qgOMZTelm5i6U6M/ZAhAcUhhvOd6b7nMeNPQ5Fx6jCxh0riSG7Yd0/HP+tLKR34bR1OCPltpGsWT10L44adbqOLyOkXedSAlDWpt7fRLQYEOuO7aqxOjdtDRpXN5ocVfu+PpMFV04tabFmYeBgavgH9/ylIfCTVUMLQbWdJ/L2udYvEOxDIINXhwf4NTE7pjxVHvGPq2TQ3IhVWbuPdO//gXdXBM8KFJr8p3mRDDtbGSro8rjMI24YHh00ChKxjA9cXyiiFIf4xOFdruf61MS40RMaH546CS5azfJiksrB3WyLzEpFUYqTCiQB0VBJTG/oULoLceHB89yCiscFBEdU3e+NwEciu6JKormr7U0Z7lCZyyLc1cg6vrkGWlXV7dDXYuNbiD8g89Ir5dKTUFrC21jVTtTRGWrCb2oO2pKXukD4tYwkFtKYGTwH6fw+k1hCJAghLSbfQRrQznFDwK0yEReGAmCC8D15cqj5bjfQnuIK0hzcYydVK8P5gNoqgo8ilpy+OW9RZ+LUPdjyTdxYxiW+uyhUzfHkU2NkBdWzFoMY//d/BYx1I0/NBnXuCnBYDVkJACw0JmX2lK2w738aFnEcgq7Co
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXNjUnlQWDZ3bWVzbzlhcGFFaFJ3bWRsZ0hvS1E1STNWR25JMHNwMHB1ajA5?=
 =?utf-8?B?TFJyYy9JQ0c4MHRxd0tBWkJjancwNC8wcmlhMUlUUDVkR0toZlIrNUZqbWlD?=
 =?utf-8?B?NjRqRk5MeDM5OW9VV0lXVHJLZDJwcUdHUmMrT3NwSzZaWkdnYnhqM2tobEZo?=
 =?utf-8?B?NHNaUzl1QzM0SFZ5MHdoQ1ZzdTV0ZVhHay9zcm5IcEozNkhkNFBhQTd2cnho?=
 =?utf-8?B?UEQ3MFZybkp6ZHVvUHlnOTM2UEtDNzBsMmNOeHNQSHVhZWJXUnE4Y2QzY1hq?=
 =?utf-8?B?UElvWGdzeWw3WWhWUXhjdm93VkhFaTF1MHR6L29wQStncSt6NytmcHNTQ1hH?=
 =?utf-8?B?SkYrNGVKY0hVSUVDc29JMS9rWUFpMDNsZnYvUkVoc2N3T25hS2hwVFFCaUh3?=
 =?utf-8?B?ZkdXU08xVVJNNEEwQUZERXBFc2tuS29FNHQ1S3k2bjhlRlZFdWl3SFovVnpC?=
 =?utf-8?B?Ni9sM3VCVXpuU3BXNGNqakw5Z2VZdkEvaGRuaS9wS25RVnFocS9nYnRQQ0Zj?=
 =?utf-8?B?TnZNZlVvczFOUzl5OVMzQ3dacWdRNERyVXdKMlhpdllXNHVWZThvaFU2azYy?=
 =?utf-8?B?M3p0U2ZSTC9ORW9nK2c5ZkhoR0tQWnRYUFRqeEluZndmZGsrZEY2aEhoelA4?=
 =?utf-8?B?TnhsZ1UzRjRlK1FJaEFhdytaNEFPdzRjcVhIaGdHWStseEdRVmFBWHA4NjA3?=
 =?utf-8?B?YmNmcXZqU1U0NFNnWkRHVERhUS9aMHpiRVNFZ2IvMFhJUWZEcVhyczRRY1B3?=
 =?utf-8?B?NTNneDc3cEN4bE41bHJxOXdicnNHWm5MNURkL0h0czhkTGZhY1FiQkRVVW15?=
 =?utf-8?B?R3RvUTVyeEJPcFluMk5UYnhSek1mVnJsdXB3ZTRpRGJIb015Mm9pSUdLazJ4?=
 =?utf-8?B?aVAyWW11K0NwMSs0bFgrbUhWcjlIcS92Vy9BS09tTGJYMXVUc2ZMR3hMSDg0?=
 =?utf-8?B?Q2xlbVZMUlNjY21kZVJ6RXRKcDY0YUErbG9RNTNSaVQ0ZC9SZy8rUXhZcXdx?=
 =?utf-8?B?ZWpFZUFxZzg5Rkc2UllIczBoeXlCR2crYjE1OVVWZkpubFZTa2l0cGNVVFRN?=
 =?utf-8?B?MnhaN0wvMGFrRVp4dXloZk50eE9tS0NHYWI1VnFxKzhwTFNKSTVoMk82VndW?=
 =?utf-8?B?UlNsQUkrSFEyamJqWGxrZ2FqTnFtT1E4aXFmcUMzbXBsbEpGT0F3Vmo4NVRz?=
 =?utf-8?B?ZEowQWF3OUhISzNvdkhjWFhDK3lMVCtIeTc2UmNHOUVPNkduZnRrem5yWWZo?=
 =?utf-8?B?NVZLRXBHaHhsbGVlVmNOUnFJYjZ6cUxKcGNyRWNIMXNibDVLZ1Z0Y1AvazhB?=
 =?utf-8?B?Qm9RM0ZKdjJWVHl1RzVkN1BKNkpVOWY2RFZGKzNBTk05WHNlcDlUaUQzYldN?=
 =?utf-8?B?d2dhNXRlcURyajVyUVhpOFpFb2Q3bnNKR2VFOGpRaElGUjd6SjR2WVlzQkdk?=
 =?utf-8?B?aG5OTTI4TWJJTkJOUldNVWVXWDJoSUJ0Y09WNWVjeDIxL0J0TElGSWlTc2hC?=
 =?utf-8?B?YWxSNFlKTXQyL2lETmllTWZwVlpDeHpibERoYndqVDBxNTB4Rmg0a1QzSFgr?=
 =?utf-8?B?ZXhNUjh2WE0zSmJmaWlYUW9GaVo1dXM0RDlhZ3U0TUozekZ6ejJ0NG9aMmdN?=
 =?utf-8?B?c3ZnaDFSbDBmQzhGb1dmM3RRbjZlZTVOQWx1VlJqdGdOMnp6b09MaFY0ZTU0?=
 =?utf-8?B?N05kby9uL3oyUnBYczZWMEhnY0cvOENtT2djNjdiMUQ3bjFYaWphYnRaWVp6?=
 =?utf-8?B?WDUzTUhleFphaDVUTGRZeGgvcmJtWEFjNTFJbXdlVGdKZWZDOVBxbS9OZWg1?=
 =?utf-8?B?MHdQKzVhdU9td2xuRktLVFVVMmxsQWxRNXRjTmxCVFVleS84UWdmNXZROVQ3?=
 =?utf-8?B?RU9DejZQejFyc1QyUFV6bUViS0NRS0NPNU1VUVJmOStyZFk2YXlkWWY3aXFL?=
 =?utf-8?B?dU1PNGhTMFZpUkxqaE5xUlJEYjNwYzVHeU1xbkZHWjZYck8wQjgyYTUvTUVa?=
 =?utf-8?B?VzVIVzNBQkRKcHRYMTdkS2I2RWtKVEQyWFhyWnVxdXhEdjdUQmUxcWxNcmF6?=
 =?utf-8?B?M2tldlpmcTk2UXNnVTk0ZEVhRnZXbGttN2xwNHh0azVuVEU0cXdUbTF5MVlY?=
 =?utf-8?B?U0k5RTNQbjdJMjZVQ2t0aGZtRFpnVy9OR2w5cExxYTg1MjZFOGRlcUd5eGtV?=
 =?utf-8?B?TU5PZmQ5UW1abW1yd24yUFcwcFhsbDRzUXB6VnV2dDBoOVcyQ2JIUnZob0Vm?=
 =?utf-8?B?bnFYSDF6SmpEV1BVWXYyNXdqYW4zR3VOWWZXMnZ3RGw2Sy90M1dsT1Nsak1O?=
 =?utf-8?B?SlZ1QzJUUlpMcjdhWWEwOHRSNmlaS0gyRTY2bkFHeDdsVVhBeHNPdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ec6c72-1330-492e-3c5c-08dec53ac4b0
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 08:48:53.3010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObxXxaQSkyE3B4FNL51fVjlBSmaTFCXNhaTR2ifZYsKL23dbK2aub71o27qa8nI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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



On 5/25/26 13:45, Michal Simek wrote:
> Hi,
> 
> the patchset is adding reset_reset.*() interface which is common
> in Linux. And implement it for ZynqMP.
> 
> Thanks,
> Michal
> 
> Changes in v4:
> - change reset test logic
> 
> Changes in v3:
> - extend function documentation
> - align commit message with implementation
> - new patch in series
> 
> Changes in v2:
> - Add delay_us parameter to specify delay between assert and deassert
> - Pass delay_us to rst_reset op so drivers can use it if needed
> - Return -ENOSYS in stubs when !CONFIG_DM_RESET (like clk.h)
> - Fix line length to stay within 80 characters
> - Add reset_count field to track reset pulse operations
> - Implement sandbox_reset_reset() for rst_reset op
> - Add sandbox_reset_get_count() to query reset pulse count
> - Clear reset_count when reset is requested
> - Update tests to verify reset pulse actually happened
> - Pass 10us via parameter
> 
> Michal Simek (5):
>    reset: Add reset_reset() and reset_reset_bulk() API
>    reset: Add sandbox tests for reset_reset() and reset_reset_bulk()
>    reset: sandbox: Cover reset_reset() fallback with second sandbox
>      provider
>    spi: cadence: Use reset_reset_bulk() for proper reset cycling
>    reset: zynqmp: Implement rst_reset using PM_RESET_ACTION_PULSE
> 
>   arch/sandbox/dts/test.dts          |  10 ++-
>   arch/sandbox/include/asm/reset.h   |   3 +
>   drivers/reset/reset-uclass.c       |  34 +++++++++
>   drivers/reset/reset-zynqmp.c       |  11 +++
>   drivers/reset/sandbox-reset-test.c |  14 ++++
>   drivers/reset/sandbox-reset.c      |  58 ++++++++++++++++
>   drivers/spi/cadence_qspi.c         |  16 ++---
>   include/reset-uclass.h             |  19 +++++
>   include/reset.h                    |  49 +++++++++++++
>   test/dm/reset.c                    | 107 +++++++++++++++++++++++++++++
>   10 files changed, 307 insertions(+), 14 deletions(-)
> 

Applied.
M
