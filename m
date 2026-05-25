Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0213CD5BB1
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 13:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D62D846AA;
	Mon, 25 May 2026 15:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m4hKAoP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12D90846D3; Mon, 25 May 2026 15:10:58 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B44D58460E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:10:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXpHqvPtNQFn6WQkCJHjeN9ggUlR84L1XjFefwiKfIUa2RAdOjWBb8ggAj3xS4DiF9pZCFbDkfLzjhd6QCf3X2cUprne5NEbh/7fv4ksf7mteqczD6Y83NroqIWMZgVUQ7G0RtxI6B8U6zAZ0e4QTBv2i+wO1/gnoJzGmYwP4GOV+cswnMkMzKB6L+JETBHVQePWSKmTFoK3KAYkUMZRkHYDijuFEYh2jQu8FL1v05oohZ6jecroqdQaI9pnb1ggKZIuyEP65qfBe2UVo4BTwwL3ngT9H+ft78H5f1VmKUu2VQUMs5EF9xsT1fh3yJ9n+Fm4uJqQeX+XWUpvlSG+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l77gdvrkDbRuRZuLQBtGjEXH+FrWXAqr5Gkvy17qtI8=;
 b=nDjzWdZGHsK25kOfucOXdgLYImVCuQxrofI0AdqnkbyU3X4ko7mrua6bgOy0pnTBcTMMr7V+FQ3rzECpEzkmWVz9XRnSW/6ArC0pX+x486L1M4avqIgMOBAwQy6fhIVFKRJmQJt9dmIdPN16LUuojAM+qlJqkNbxrXbMqOEZLdyc3G06YxMK4qm6GtulXwlCjUe/aqWV5/iu2qEPapWnTVg6MCqy7ERMnJetiNr8JeicAs0w96zZtUJsyh746h8/Bd11ubWsfo8SxFxyFpU4EumvTk7fhgGtr73wkTySNCEkwfK9kdTcxupbZr/zCWmw+obY5cZoymC1OHxjUVHllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l77gdvrkDbRuRZuLQBtGjEXH+FrWXAqr5Gkvy17qtI8=;
 b=m4hKAoP3p6md8GlYd94C4SlpgfeZBKH+Yhn4VfvHg450q67F0prR8LneOosF2aA9wJm53hUzZrZPzXRexDyiXCG0ExlKBuhhxudvRR4d2sRD26UGRks2nLcYfLmkjmEnw5lGVp1Qe0j+N+Gegk9U0NZ2eIFzlz7kUM8rHh2Ilag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:10:47 +0000
Received: from IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db]) by IA4PR12MB9788.namprd12.prod.outlook.com
 ([fe80::aac5:ae06:3bf1:36db%6]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 13:10:47 +0000
Message-ID: <750f8990-0d4c-46f7-9800-201a65daeb5e@amd.com>
Date: Mon, 25 May 2026 15:10:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] configs: amd: Enable capsule update and DFU support
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Tom Rini <trini@konsulko.com>
References: <20260514103845.1761891-1-padmarao.begari@amd.com>
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
In-Reply-To: <20260514103845.1761891-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0003.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::25) To IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR12MB9788:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f1fa01-f444-44e8-fbaa-08deba5f096a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11063799006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: ouLmvO5cnhhkci1HgomljrTIAzBRRZFLF1dDUH1FXZdtidFMTFcY0go5fKgZ3vJiGstB33N5pbmi0MijHLqyH5ISzcr11AD/CFcFFnxaYosgobB/wHc8MC+9i/xXSU8Lk72J6eUKCtl7TO9cS5vaAyFD9qSKpSHN55XqKTnVMbeUigDaNtMxD08dEiSS/6Y+H+3yg52vO5tTD+UZWFEBkS/SQH33n0+1/pckSDAxYZgplbNe2gp+YuMcDuoXmxN/bzTxVuGaG3bKXtiIdSHVv11s4BXQT/916rUebo8GUflI2vV/AnfDJtRZC9WtGDD5i67hMcGlcGZ3q2FIFkr/zg4rz4fLCKeoeAohoq1xUZgeSUG8vt6upLdSF2IZHKaNesVvwdOITam5nFhQFwwn3FuX69lDxDGIBdJ3u3kkMz3mPzIy9qb8ilZGd23RbRo6V2hElDAQYwK0QrImuDIQHgay/g6JM2xaPDv67L+SLUDoNTXLi7Hk3u+OiVW36xi6GwmPn4t/0vfXYHVObL8E35V3JlyyRmXCEDWNFYFC/oOxR0BhoUAoh358ZEpEpAdEb5bMPkj9NyhnRgtzO6bcqHKF0VuFEoKRueG3C4XkkziTQSdQ6+hJdoLLVcDUx61HWKdCiEePnVOl3ACd18YLCaBjmxQ8naoacjXkFt8JaJaArzu7ZUPLGrlBANrrl8Ft
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR12MB9788.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVdtbUd1UVJENHdsdUp6bCsvVlE5TXFHdW5RQmxzN2VhVmxQcDMyVVVMY1R4?=
 =?utf-8?B?VkNPZjVMQWd4dUN3U2NSM0ticnFuZnFuUmwzNTJrbVlJRXFxZjJDd0I4c3Bn?=
 =?utf-8?B?b1FVeVFXTi9raE9uaUlJbktOOGZlMzlZZDNyM3EvNERhV3ROTlR3SytyQ29P?=
 =?utf-8?B?YWVZSGVUL3A4ZW9Wc3RYZTZ1NlIrcW5SeTZkVU9YbUVTMERsVG00aFZYL3FE?=
 =?utf-8?B?WmxzNURpSWlWanIwRlkrK09kVklIaDVmWGRLUXJkOG9MamovN0ZueS9YL2VJ?=
 =?utf-8?B?eVl0QWc5VWxHbTRCNHE5elpadHZ5Q0ZkZUtVdjBKWHdYMXBqQjJBTDhiWU14?=
 =?utf-8?B?TVpRYkNWVGdNRVFJR08rYXRYUVhWajFFV0dMSTBDWmV5b3ZYN05pbnU3WG9Y?=
 =?utf-8?B?L2Q4a011bjR4RTBrSkg4WTFnRjZKQzY2bC83RnhLUFZtN2xhdktVTXlMVzV1?=
 =?utf-8?B?aGpRVUtJUjhZWTgyZW1vVUVhMTR1am9DV1YyS0ZPVWtBMDhTeWFNbFRZWldq?=
 =?utf-8?B?L3ZyckFZclVHenJJakNubFduNDRJRFQydFVhazliTGxhOEtGL2FqT2lxZXZH?=
 =?utf-8?B?VzdiYTB1UTU4c2FVRk53SVg0V1B0czNvbmtBZ0lTS0E2N3A5cG5VWHhhT1gr?=
 =?utf-8?B?THJJaDFwcHBpaUdhVHUyYzl3SDVsWVpsKzJxUlZRQXJCMERLWVJlTEQzMWY0?=
 =?utf-8?B?ZGhtM2FVYU1ObDVhY2x3NEIwdFdVK1FPRDVIOTJsMWRsK3dmU3lpSnl5WDF4?=
 =?utf-8?B?bFRCMzByMkc0ekppRFFOZExtVWpYdTRYYmNUazVaU1dUNjZzVEJ6WkhEWkdQ?=
 =?utf-8?B?ejVQL0dHRkp4V0ZHVjhuamc4QXovV0x0SzVEUVcvenQ4V1FsVmdWWjlNeTVv?=
 =?utf-8?B?TnBITWJPS04zV3lIVFJMak1xRFIrUzgrd1pNc0RUaEZTaHgybG5wT2hMT25k?=
 =?utf-8?B?UXJIQThITlNmdGliYmFkWFJBUWE5a0J2RGVtR052TWxyTWZwdjREdkVzRGgw?=
 =?utf-8?B?bW5WcXc2c0g4b2dWalp3eTAvMm10a3NVQTIxZTdzaVlKZjZRRlByR2dUL3cx?=
 =?utf-8?B?bWdBSFNqTlFWR3piZGd1bkRBcld3ajhlLzlSUytMS1Bla2k4UzFpRzEwRzA1?=
 =?utf-8?B?b1hYMzZ0c2VaZ2JNRlloOUp5Q2JmWEt0cHAwL1BoYlNaWWpnSXBxUXdMRnMy?=
 =?utf-8?B?NWltYmQyQzdOZDFsV2JyQlF3QXdyb3VCRDZocmhNVXdMaHZDajNJMm1uanNH?=
 =?utf-8?B?MlFpK1NReXJqVWJ5Tk5RZ1lERHBFSXFJWXZ3ZDc0eVZJaEhGZlAxSzV2MnpP?=
 =?utf-8?B?WHFGV3ZYZFN2VDZCRmZ3NWY2bkRlemZhMzRyWWcyUEY1a3h4d0xMUG1hMVdI?=
 =?utf-8?B?MzFZVWttUWovank4cUllSEFXYXZqemVic1p5YVoyM0J5VVJ5ZTNWcVNDVU9H?=
 =?utf-8?B?U0RJOHFOT2x6bXB0UlV6YS9jNkJCMGVsdXpreTF4M0xET3FBeEw1RnZVNVI3?=
 =?utf-8?B?TTViYnJTbitYL08yU09rNWlCa05MeXNJWEpFVm14SzhrWVpCUHQyY013bUhj?=
 =?utf-8?B?T0tqblZKQ3VKMmRlZUIrbjNwZm9lM3BuN2hQbXNkcmZpZ1BvN0NObnI5ZWVo?=
 =?utf-8?B?MVFEVWwxYk1LYmRWYUxOMTkxaFgxRWl0MVhoVEREbE1zakVDWCs1S0ZDRGNY?=
 =?utf-8?B?V1l3alUveXVYYUtLTStUUncxQm1CSVBqS2M0M3hoa1BqSldDOUFjSnBLd0RD?=
 =?utf-8?B?NXdERm1FS09YbXo0UjJDUzhtdU10c2cySktWUHFJNlU5U3ROSW05Q1RQS0Ux?=
 =?utf-8?B?WCtFdHNDMUdFTU5CU1hZcGJoMU1hZGZRNVBnbFQ0R2EzUjdDNDlFSElubEdO?=
 =?utf-8?B?ZHVSb2NGNW4rYjhKR1hoVEx1eDVYdGl4NFl3NGQrZVEvYVFGK2Z1clpONWhm?=
 =?utf-8?B?eDFZYWRWZUFoQmErVUVuOElHcHBOSWV2Ylo3cTh3RkdaQ3JHODdEYU0wcTFk?=
 =?utf-8?B?VHhBekl2bnIyajlsUjY4Tk9DbTZmN2E2Sk5raWoyOERYNEk3blZ3WFFLWGN2?=
 =?utf-8?B?cGpDMW4rQ3pDSS9PV1lnMVBERHpOTWlGcTR5SDZobEh4bUt5T014YkxnbFBa?=
 =?utf-8?B?ZkVGUHgvWU0wdjc0aU5CbGJoVHNUeXlaT2hXc0d6SmVqeWFhTkV2UjUvTWlw?=
 =?utf-8?B?ZEcxeXpRTTlqRUFkUW82TzhPZm1VdlRvVDNjU3VVTVBScXliZXo5dXh5cW5u?=
 =?utf-8?B?R2ZtTnpSOUVXOVBTSkwyeDhnT1p6RGNLV1FTTG9iMER6UVJyOWQxbEdNdnhH?=
 =?utf-8?B?dDVvSTF1SkxnTnhVenNwWFlvMVFGbzk0Zlk4ZkNVOW9TSnBCZWwyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f1fa01-f444-44e8-fbaa-08deba5f096a
X-MS-Exchange-CrossTenant-AuthSource: IA4PR12MB9788.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:10:47.6862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAAg/udVF9GeopI5dJw9/s8FWPElPW3FpftYXVJWUFHQLDua4JEbZP007MKeKqZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919
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



On 5/14/26 12:37, Padmarao Begari wrote:
> Enable EFI capsule update configs (EFI_RUNTIME_UPDATE_CAPSULE,
> EFI_CAPSULE_ON_DISK, EFI_CAPSULE_ON_DISK_EARLY, and
> EFI_CAPSULE_FIRMWARE_RAW) and DFU backend configs (DFU_MMC,
> DFU_MTD, DFU_SF) for the Versal Gen 2 virtual platform. Increase
> SYS_MALLOC_LEN, SYS_MALLOC_F_LEN and SYS_INIT_SP_BSS_OFFSET to
> accommodate capsule update buffer requirements.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 61e3671ea4f..00ccc81a83b 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -1,10 +1,11 @@
>   CONFIG_ARM=y
>   CONFIG_COUNTER_FREQUENCY=100000000
>   CONFIG_POSITION_INDEPENDENT=y
> -CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=0x200000
>   CONFIG_ARCH_VERSAL2=y
>   CONFIG_TEXT_BASE=0x40000000
> -CONFIG_SYS_MALLOC_F_LEN=0x100000
> +CONFIG_SYS_MALLOC_LEN=0x4000000
> +CONFIG_SYS_MALLOC_F_LEN=0x180000
>   CONFIG_NR_DRAM_BANKS=36
>   CONFIG_DEFAULT_DEVICE_TREE="amd-versal2-virt"
>   CONFIG_OF_LIBFDT_OVERLAY=y
> @@ -17,6 +18,10 @@ CONFIG_PCI=y
>   CONFIG_SYS_MEMTEST_START=0x00000000
>   CONFIG_SYS_MEMTEST_END=0x00001000
>   CONFIG_REMAKE_ELF=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_CAPSULE_ON_DISK_EARLY=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>   CONFIG_EFI_HTTP_BOOT=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
> @@ -81,7 +86,12 @@ CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_CCF=y
>   CONFIG_CLK_SCMI=y
>   CONFIG_CLK_VERSAL=y
> +CONFIG_DFU_TIMEOUT=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_MTD=y
>   CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
>   CONFIG_ARM_FFA_TRANSPORT=y
>   CONFIG_SCMI_FIRMWARE=y
>   CONFIG_FPGA_XILINX=y
> @@ -106,6 +116,7 @@ CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ZYNQ=y
>   CONFIG_ZYNQ_SDHCI_MIN_FREQ=100000
>   CONFIG_MTD=y
> +CONFIG_DM_MTD=y
>   CONFIG_DM_SPI_FLASH=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_ISSI=y

This is not thread but I have applied it as the part of this series.

Thanks,
Michal
