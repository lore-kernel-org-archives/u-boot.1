Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C53BC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 10:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C182A848EB;
	Tue,  7 Jul 2026 12:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B+/H23IF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 285CC8496E; Tue,  7 Jul 2026 12:58:27 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D1B846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 12:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl33OEeOdXu9fWxd6rql/f8S3VEFRlzKG31n5YM1Q5y+zLeUqYo/xt4/kkFo/kmxS2SZiZVMJ42Y0AW9QXKUhrF0f1t2H6LE80EiS8Fu1tdinYRqOeTQNW15zRyXLp75pC0b98P9Zc3wMmRIltXMCDAtDmyasWizFihZQxiUlVpY+yewFVbo8rsZv8lfNigp8Oar7bejsngK9oymZepoXFfbgBxEHUcdM1fSUK774Ua/xQdH4D3s+2mGILhPKuHq0Udm1QNoEo8Xxv56IzEdMtCL8kNHCnC7Y6y4RDnbgWOsMBPwfHezGK79SH0PSV+PV498OAvOsvb4SWo+Us+vCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucinz0MLnNUisJJOErtKw1eWSRf3vauuwL+SXEzw054=;
 b=wQ3mAG8YWpoukgG2dRD2yyneHLs3jGAbETt1T6yRvNxXyho7hvGAlCcnhyotNgGW2+hwIHnFck6Cc+lpmAWwGBoA5qGGqugZKzVhwflwSbftxk9mPYRbuJTUKnvIP2u0CG1aCKRYwG5hLrysJ1i7QFmXV5GlB/n9H8rjKBRWtr65R1Sa1imq2KAePcrOnyHedTAMccvrAfAwQBjTiUnAwhG/iRgym0FYPICFm+46cJ6btL6Hgjl631Cn0dc2v2yEGy+F4HEP6sa7f0A5lfznkqq6NVicvyC7DqPbgO4OLxfrPPc50AGxs1HILdz4mVfTS3J2r3Jak4gNItJtTjiJsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucinz0MLnNUisJJOErtKw1eWSRf3vauuwL+SXEzw054=;
 b=B+/H23IFTnAKL6BDKokwOzuXh9CJdjDHyqhUcw4elsY6Wlm1MyufL8i+TRifSM6dQqrNJR0suGxu303eWniF/80dsOK2YJEgC3Ib45hw+2lciJz8gZJg+zWkZP0DDrI8+zGSN49OA17R5WOjzjiyVJ/9Y6bqxCy9RkVN4EzjK6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 10:58:20 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 10:58:20 +0000
Message-ID: <bc5f81fd-a553-4b44-82db-39aeb1622657@amd.com>
Date: Tue, 7 Jul 2026 12:58:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: zynqmp: DT updates
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Harini T <harini.t@amd.com>, Neal Frager <neal.frager@amd.com>,
 Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Quanyang Wang <quanyang.wang@windriver.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Rohit Visavalia <rohit.visavalia@amd.com>,
 Shaikh Mohammed Suhan <suhan.sm@amd.com>, Tom Rini <trini@konsulko.com>
References: <cover.1782726386.git.michal.simek@amd.com>
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
In-Reply-To: <cover.1782726386.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c4c620-8438-4d82-8851-08dedc16a80c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|18002099003|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: G0a5hpAppYB/zhLY8fxr2Kpt/KczbKdPcDZ1qSkoRMvNWKVFGzQx2Pu3NxvmZQj8oP6on5DOAFa80jNs7ZFHvEmgdmsTD2NKUlUPkygf1OKGM0K4qm3SXU4pitUuSNyWr4t1t2rB+mIJrAGOBEuaBZ5rN6aim6DGZcACFJUYnvTX/PFgFwB/OPFcxfhsh/sPT6SpB6Ky89OPoEHQ9TNMGSCJz2Ucell+/X5/qphK26f+k7JD1OV3yKywNI3YL22Tn6/tUzqiF9Ximd/8p4pbDXPG/umsuy2rYXPg77TYO+Czu5Gz1jaJeuKjh6885QI02JlhU4Td1l4805/ZhWdU8UI/npgY/3kBeSJOpvnWDNVPhzVZ+MQHoACKXLlmjVvl1WMjb5s/q6k1eg4Tkhh0N3bBXm6VguYpy6jxhMze0IlxpozTY4XRQnQYOT8LsDUDJyvoZH+62DArWHKqNNReaCayxLJxL4RfeGBemx/T82MO7XDUfAoHjl5dFfOJx52DOM9KhV95PQ3298IbFKC/shTb+LTIhb6AmZo03lQ8wFe6u6yw3FqtNH2JfVHcE+T89uyWdsiN5zKboK6rCfs2vH+ak1kYE8RCpkGg5AhGDrnSqz6/4PWmmfCdZX82yojuRRJhfHKdLr1Rz7qMLtpvrCxO7meGaCFiJLO42G/iR9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(18002099003)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXVUdmxLMUlTNTV4L2RIdHFRQ1lyVEdHVUFoVWpwY3R0Yng1M09GNFJXYnky?=
 =?utf-8?B?cmpvY3pLRVhsa2dZSzFFU1Y5R2c0V21QTEtBeHhSQXlZSnlsNlhGTWRZUTd2?=
 =?utf-8?B?dFhqQ3o4M2Jsa2YyaVczaEpjaVhycUE1Q1dYZG85VDFzSHZzaEl1dDRBYUV0?=
 =?utf-8?B?MDZ0bEFsZGhJSTZzcFpaQnpSWDVMZ09IZ2h6SEZLdGtWQVFyNUpHU0NMZ0c2?=
 =?utf-8?B?cjgyMUJFQ20rUWRwYXdwVjBQZUxybkRNNjM5dVNXZnp4UmhnZ3VibENWZXF2?=
 =?utf-8?B?emNVSHpscERnbFRBUDhHL3FjUDI4Mm9RTytja0hvaEhxZTM1Njg1aHZRalp5?=
 =?utf-8?B?aWppdUYwaVVId00vaER1b0QvYWNGZXkzMFd5MDNwS2xIVHplNHBVNmI2ODFt?=
 =?utf-8?B?bDdkS0JZQ0ExbkhLSWt4S1owcW1kejZ1aTN1RjBJSElWek1TNmJ5ZUpYMzl6?=
 =?utf-8?B?VkRaMnZvK1F1Vi9JVjN2ZklZdEhWMEx2OFBadnVVbERpd3JxQ0wxVDUzZlQx?=
 =?utf-8?B?MjFWU2xJRFRCMTZ1V0k2VFY0T3hucHJUSjVUOW5jRm0yeVB2U1Q5M2g0TVkw?=
 =?utf-8?B?ZEd6MEo3eWg1YzRncFVKa0VsY1pQTjROMVQ3NE9DdFplenJGT2FSNzA1NjJm?=
 =?utf-8?B?QTk0TFJVS2pCVUt0ZHI5SGwzbHJBTFhvQ0JiOHZLZ3gwaHZOYTdJVUFlaDNW?=
 =?utf-8?B?azgrbDNPd1RLNHhGdnF0UjUwUzBWTVB5d3F3VVZBVk4xMmgyQThhZ0tMU0JD?=
 =?utf-8?B?K0Z6ejREUjI4MnhDcU8rYktrQXR5UHl2dmtLNXhmSUp3UnpXbUJFWUNXN3Vx?=
 =?utf-8?B?M0t6TXJpeksvam96eDBmSjQ2czRRUUFlNzg2MVpYcGhsbzZnTnJiand2ZG9I?=
 =?utf-8?B?ajdQTHFtNVc0bXdwUDVKUXgzSTNQYURUOEFyNzc1YXNBN2pISk9wcGw3VFAx?=
 =?utf-8?B?QnA5T09hbllEOXo3RG52akFhVitNajR6bmxSWld4WVNIemI4RzlKYm9HaVhT?=
 =?utf-8?B?RkRQYURxd0g1TGRrdnlCRkJ2WTFkWUwrN09jQ2Z3SW0rdWY3cWc2aDh2clRk?=
 =?utf-8?B?ZUZLT3IxZE5Rb2l6aWhUdmtzZVdpZ1BWV0JYZDFJNkpycFJMT0lkbTlYWU9L?=
 =?utf-8?B?dUpOU0x2TnlsdGdZSGxXdUNrUWt5ejlPUG5zcUNZYld2SVpZb0tyOTdBQnJU?=
 =?utf-8?B?eW5uMGwraUdXWWxLT3VOelkyNXFEcm1xNTRKTUhaaHdZWUEyZktndkVGQThI?=
 =?utf-8?B?WXJIdVEybzBJR0dIcnRFb280czlhUXo2YUJJenpzTCtCTmVtSlhqYndLc3hF?=
 =?utf-8?B?RjdEMWUrUXpCVDdSb2VSZjRZL1BLMk1mc2NSM1NIMFJ4NTROekkrZTN6VGto?=
 =?utf-8?B?VkF3TUhMeXFFREdyTGtWSjVFV1I5VU5YcHVmQTA2aHpNZUhNeEtxNERPN0lS?=
 =?utf-8?B?Z2xHSThnRjIwQTNQWWFCWDkvN1JSNTZkeXh5RDh3bXhiQ2xPdVBZNXlHdktU?=
 =?utf-8?B?RVFKbEpNN3dTTWF1RkkwMmY0Sm84STBjUXE4TzhnamFIb1hXc1RlTGZZcEkw?=
 =?utf-8?B?Q1M3ek9KUnlaTWxIZzMyVGdobVRpdVMwUTZHNk4zOXd3akV4aUJscTl3d1Bp?=
 =?utf-8?B?cWQ1MnZ6TUxNdXJJME92aGRLWE1wbWR4VnNYWTYwMjkxL3grQVphZUUzTXJ6?=
 =?utf-8?B?QnJvQ2VrY1I3T1pzaG5neEI0MGhSbGwxeUtSR3hhRkk0VzYwaUhtdGdvYjk3?=
 =?utf-8?B?WlpGK0ZYcWJkMTYwSHUzb05xck43bHNrWlpoTG15TmV0QkxCL0ZRVUZKOXRj?=
 =?utf-8?B?Z0JXV0d2SnREbU1xOFliRUJIV3BLVFFjNjZtcVJFak9ra2krTEFJeFFuR2ll?=
 =?utf-8?B?cnpaVk5ETUVHa29lMGRraTFJbWZxdTZFL0Q5MnRDdWkwT3Nlc2VESzNybzFr?=
 =?utf-8?B?WGZYb3NmSWRZRmU5NXJ2ME95azZaWGRhWkNKTHJ2WmlwZjFnSEMwVEJCalB6?=
 =?utf-8?B?SmRnVW1qWlRHOHhXbktRbzQyRC8wVTI4bnM3ZnoveUQ3RmpuLzFRUlB4bmJV?=
 =?utf-8?B?OTRXc3JBSFNKY2tON3ZlVlJHVlhHbDJlY24zYnRnTWlVeGdidHFFZjZrOFFU?=
 =?utf-8?B?ZjIzRXZ4WWFCcUprMHFoL2xrY0J5VzVFK2NrMGovajZwb0RFRWZNTHM0cTY2?=
 =?utf-8?B?eXRlanVxWGtxY0hQTE5ra0ZxK1hET0V2a3N6RGVPM2NTanlYVVRzbmVMelBV?=
 =?utf-8?B?WnVMRmhxNTYwV1FmS0JRWFlJaFN2aERGdFJqdDIzK0g1bGdFeExpTkJSdm00?=
 =?utf-8?B?ZzBBU1RMMnRZQ0JtQVFxeC9PanltR0V4a2RpMzlyYUhYbmZEZnBkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c4c620-8438-4d82-8851-08dedc16a80c
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:58:20.1236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVVULiDuR4YgxUlT57APjcguirvsHYYq6MESWCHIlarwYrIk/gynoXgQyUri13tJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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



On 6/29/26 11:46, Michal Simek wrote:
> Hi,
> 
> sending some patches to integrated the latest DT updates for ZynqMP SOC.
> 
> Thanks,
> Michal
> 
> 
> Harini T (1):
>    arch: arm: dts: Add RTC clock nodes for ZynqMP platform
> 
> Michal Simek (3):
>    arm64: zynqmp: Disable ina226 iio-hwmon nodes
>    arm64: xilinx: Add missing newline in kr260-revA
>    arm: dts: zynqmp: Fix space indentation to use tabs
> 
>   arch/arm/dts/zynqmp-clk-ccf.dtsi              | 15 ++++++-
>   arch/arm/dts/zynqmp-e-a2197-00-revA.dts       | 20 ++++++++++
>   arch/arm/dts/zynqmp-g-a2197-00-revA.dts       |  6 +++
>   arch/arm/dts/zynqmp-m-a2197-01-revA.dts       |  6 +++
>   arch/arm/dts/zynqmp-m-a2197-02-revA.dts       |  5 +++
>   arch/arm/dts/zynqmp-m-a2197-03-revA.dts       |  5 +++
>   .../arm/dts/zynqmp-sc-vm-p-m1369-00-revA.dtso | 20 +++++++++-
>   .../arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 16 ++++++++
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso        |  1 +
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso        | 40 +++++++++----------
>   arch/arm/dts/zynqmp-zcu100-revC.dts           |  2 +
>   arch/arm/dts/zynqmp-zcu102-revA.dts           | 18 +++++++++
>   arch/arm/dts/zynqmp-zcu104-revC.dts           |  1 +
>   arch/arm/dts/zynqmp-zcu106-revA.dts           | 18 +++++++++
>   arch/arm/dts/zynqmp-zcu111-revA.dts           | 14 +++++++
>   arch/arm/dts/zynqmp-zcu208-revA.dts           | 14 +++++++
>   arch/arm/dts/zynqmp-zcu216-revA.dts           | 14 +++++++
>   arch/arm/dts/zynqmp-zcu670-revA.dts           | 14 +++++++
>   arch/arm/dts/zynqmp-zcu670-revB.dts           | 14 +++++++
>   arch/arm/dts/zynqmp.dtsi                      |  1 -
>   20 files changed, 220 insertions(+), 24 deletions(-)
> 
> ---
> base-commit: 3819bbedb39a31a0f872540dac5ed6076d39c026
> branch: debian-sent3
> 

Applied.
M
