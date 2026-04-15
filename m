Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2488F419A5
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 13:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45CB583B99;
	Wed, 15 Apr 2026 15:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bNM9lYAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EEA184178; Wed, 15 Apr 2026 15:13:18 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D8A883936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 15:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RubT5ato1Zwt1wfsQ5P/Zn2CmBFYcCqko/6G2S8L45wfQ/HPLGhnfvMDcTZ+kTfJ5YKKHrV1mgmmwQY4n3mWQw1Pc6najBC/lJbyTdlR3Ar9QTPx50F82vRWNnRHVxOoCK4raiUK+tMZEV3HFS3n0G8gq56V23OugYsPkD5OCt4I+BPCzknZ4XJ+98E12km9THuKRW2w9VnuyL76dL5B6duvAqqQwNQFDVQw7aHHocNXi+DNTzgyiEuZbTvSz1hWdIg/rHtoqNqbuMphrxgowTb8SpTczg7rwFn3VARbCmmucdF9gf4dqYu2MW+We0tYbj1WhgCv9WiQJ3U73Np93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhsMn2lhHVZzvkDGjHatF9VGl7b/2CshfvY4x68ekRo=;
 b=r5jQWz9ocPgL646nn5LsLV71Ys43hdy9aoyNllaElzA4mZ2vfoqCcnM9kop88szID5x+8pLYNb03PrQ3bZDpqtVPH99O0Y18dlfgdsYKDIfMjnEl2WUqzDbPEZLU3kV20WfjrRONNK31uCpYl9ffiz96Knlo2vapsZqSD7nT8s9lg0ooTKzQvovVqrEE7q3IkqkEJsn7Lyym4a7aCKDszHkuyc+1ztZPCWuJj2/yK0f3br2ojKzvFpeR7NsyZn8xL5dPA96nRkW20c7g8xLHYwbQnTen+CbTgXvWcuzldihRYQbUhYQN1FGSjauPIZmR4n0PeYMHm/rALsKfVlKTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhsMn2lhHVZzvkDGjHatF9VGl7b/2CshfvY4x68ekRo=;
 b=bNM9lYAExl+VMSEmZwPTvVOjbd1SmaSQV2UiBOVCnBN1w07yAAsChXqaXBTcDyN9MbBE7X62OmjNV1B4wjc/yu5mLADtTfPSZttb9yff9SkHChronnHfeQO/4JeoPlEQogjKr4/Iy+uEDQEzPWJBgBu7Q0Rs6kc+l90tAc+O6Vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 13:13:10 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 13:13:10 +0000
Message-ID: <5c0a7fa2-132a-4527-8a34-c30b5ce83254@amd.com>
Date: Wed, 15 Apr 2026 15:13:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fix 10GBE support for AMD Versal Gen 2
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, padmarao.begari@amd.com
References: <20260410093018.1461732-1-pranav.vinaytilak@amd.com>
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
In-Reply-To: <20260410093018.1461732-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 1343c8d0-6c2e-400b-e045-08de9af0be1d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: m5prHvYv9MzaaZTXQwZHknRRm/5xuXiN2+CbWEsC1uMrb7xKXnCIGkhm/RRa4Fs5R0o6r1ucVgpg8qHph2wL3JLmjIbLWUqCNuBae1ZR2xyLvnkKKjHc/r5BcHpeqecZjsYhU4J5TGFWfTCF6IlRhlBkIUrVo2h8TYQ17ku+E94r3hvhMy/BPg5XKcQd++MZ8v5a4WQGnrh/qgTLQE5BvlxPEDt5iUIxnYb8VM3vKAP8BQ0IG55MmILNEu4wV4f/z2GF4ZbXNxuy6h28ysEhhxcb0Qh7HrN1J7lqBDtjlUcoMWpiWQFtIeFS0gsrK68h8qXK84raQEvw7aEf8cxeKIAHzrXvWxjh16+uQrqSEIZeaFALb/HTkVSdR5qJZ4bPxa4VxLiLlS/rzvECzQRldvkhfkiCqGH7os+UfIhcATYaw+BHLu/dGG7+OEBAK9hQOcs5jvsVsOu7+OtgKVOkziRX1OetB7rcmYx9joBwsAG+HYH0pEcrTj7J32qPg2/UgvrSRwrdkVJ/lANgtUJ2TkhRowL5vXNkqBoGqX9qUcy4YwsCOGwW6d9FkTG79zsu9/jQPdj7X+V8skHMDV4/e/+DLdXtwECdfBAzJm7/q9K+UrHF+chuxsK+9Cve6SlsTBzqWvymEsN+ZBs52ovjNlXvrI2XOm2C8F9sM8DaeUtF/7sbu8gJyB5+WkJkGi2vnlxIpYi+2iHKPeEWqOHUASmTD57BM4Re52nzSitfjEk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkZubGxaUHRjSE56Q2dTc29KU2UvVkYrS05udGNjK2drUUNoMTdBM2NYZ1A5?=
 =?utf-8?B?ald6dWx1Yk9kcWt3VWpReG03aVptVkttcFh6bHFTL3hIUTZWR2RiVW9JN2pC?=
 =?utf-8?B?WExWYWs1M1hHWklIeDZVY3lSeExUbUJkdTVESnh1cEgvdUNtdlVMalBFR0ZO?=
 =?utf-8?B?VU96OWwxU04yMTQ4eGtTUlovT2tuVEVpWE5PVjQxSk45NGp6RWwwcjFsZk1k?=
 =?utf-8?B?RmJXQVp3ZU93amxpWmdOd0Q2UWpLUUNnbzUydjA4Sk9qeTg0bWMydXY1RjFC?=
 =?utf-8?B?SWJXeHkvOWY5dEZaQ051cFVkSlFwN2hiTWRRWitpMENRZCs0NFlNU2h3dFZB?=
 =?utf-8?B?cWRMems5UnBvcWJTRUNEd1Q4cmFOeGw1eFhKNmg2MzJYOUhoMUJ1azFhUkkx?=
 =?utf-8?B?eXNkdERQRE5SdUpRbmdyZUJGRmNaVGhPNDR2YnBJYkZiN2lHUGNXTUMxSUxq?=
 =?utf-8?B?RVhEeVlZMmVGckpSeG5ZTndIaFRGT2RlODVQcDdzV0UrKy9rOHJsSmlhY2pG?=
 =?utf-8?B?TFIrTlFJNHdHYkxPSEI1N3BBKzVEOHN1Vk5PWmV4NG1XZ1FuSkFudUNMM3B4?=
 =?utf-8?B?K01uVXVRWUVpNXIzVHJrZUpQd3YwR1czaUp4aE1td3lEcDZZdTkwUFRxeUNQ?=
 =?utf-8?B?djltSFFFZ096SzhTanlrVWhKYjVrWXB6ZkY1WVFxZTVrRURGZlQ3MTRiZlc4?=
 =?utf-8?B?OEw1czBlVUE0SzNOWUpzL0V6MWg0b3BJVUlyb3JhSTI1UTc0S0JxWFlvQ3ky?=
 =?utf-8?B?akU1SlgwTnoydFRYcnJ4NUVudWE4Z2g0eXFoREVPdzNTemRSbjc4M1FTQWRO?=
 =?utf-8?B?WVRDWjRqTHI0eEhNQjVNZUZLS1R1VHExclRXUHVvcy9WYUN5WStLZWowL2I4?=
 =?utf-8?B?Y1QyY2xiT2Ntc0NRSkgySVBtR2wxQnlVZjJTVkZpWGFCSUpTWlZqcFYrV3NS?=
 =?utf-8?B?TkNPNVY1Y3BucHY5SHB4amQ5YlErNzlNVkpWOTFTMS9aRzUzelEvUWkzWW96?=
 =?utf-8?B?MGV4OUpZcE00YzZxVkZnQWZ3dWVlVVA0eWJwU3YvelY5bkFuOGMwZ1BQRHUy?=
 =?utf-8?B?YTlBUlNwNHBFeUpCWVNtNGE3cUdJdVcrMnlJVG1FcmtqcUpTcjZkd3YvY3NJ?=
 =?utf-8?B?TlFCVHFEYnBEeExZU1VWdHlxRHlyV2NTYmg0d0ZBcjAxVFA4VkpxaDlmV3pz?=
 =?utf-8?B?WFVWcmpqSldGSVRoWFlLQUIweHZZdlJFcXp3aExIWEVYQ0xFUW9qd1ZvRnBx?=
 =?utf-8?B?TGNZcldxMEFZV0VuSkdIVEI5SnVsRG9tb3Y4SHlwUUJVZVJLVCtreElnZEZj?=
 =?utf-8?B?NFNPeEdYMmF1UkRMVEUrZHNOUW5MZkhCV3laaHVCNldUWUNGQTE0bVU1eWxY?=
 =?utf-8?B?VXcyNG1mUTJWLytXckYwcnVIRWVOdjNrajRyUFR1dWY0a2lMb0h6UThWS210?=
 =?utf-8?B?RWdqb3JkTWRuRnNJSFl1aEJqckZubFlBWExpc2RlZHdlZk56a1FyRXBwc25B?=
 =?utf-8?B?VmJqUFRmaUduU3VLVk9veEpkYjY4S2trZ0R1YklGc0FneUVlMmJScnFBTy90?=
 =?utf-8?B?clZUb1VvWmhRR0xvMHB6aUJkUjFodmJPZU8vdXVVbllKVjB3SWZVTDBZaU5u?=
 =?utf-8?B?R0xFQk84djExQmExYWxjeE55R3VTRXdwQ0NGVmFUTjVLK0VFbzIyRkNnM05k?=
 =?utf-8?B?SzBlaWtBOFprUnl6R0xReWdsN2w4VXlzblhDNnVGUkN3bWpBTjZYbUxPU0VD?=
 =?utf-8?B?N3hTMkhmVGNGUUcxSUdpQVdKOWkrREtyTWd5RmdQVHBoMEo0eXpET2RGYWtS?=
 =?utf-8?B?ck91dS9nNk9HRnVJazBVWkFQUFJ2MTlTaGlPbkFlbzBuVkY1VkJGQkQ1ZTRn?=
 =?utf-8?B?SS9YMkNWMUE2ZGhiMnVDam9MZ0xTTGV6ZW5oNmF1c3BoV1BXSHFaeEpRR2pm?=
 =?utf-8?B?UWtMRVNtaFBmM0dDeVpGRU9jWUdUTW9oa09PV05uWlFVVU5NTnNtZUM4NGkx?=
 =?utf-8?B?azVjbG45VG9pQ3M3dnh4Rk01RjVMOUxFRUY1bTcrR0RBU1dWNDVNQWYzM2Fi?=
 =?utf-8?B?V3krLy94NmVCaEpTN0VTY0lnRmZwR0pyYmFzQWFLMEtCcXpRZklnVlcybkI4?=
 =?utf-8?B?dXpzVllKcGtCL0VMQ255OXVuNmxIeCtMZCs4bU5LU25jVkZIZXFiL1htbmJU?=
 =?utf-8?B?M0lBdHN3SW1IQVV5OCszRjNGRXV3ZUhDSktld3g4ZlZueWpiUUhpYkY2UlJQ?=
 =?utf-8?B?amkzN3pOWXljcTh3K09jT3I0RTQ0ZGt0ZWFWam5SMUdVNWFOaTB3WWdDL2hw?=
 =?utf-8?B?K0ZCVmpxTEFvL1Nwcmp5dllCdU5adW8xOUhaeVMvejBQOGw2NHA5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1343c8d0-6c2e-400b-e045-08de9af0be1d
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 13:13:10.7604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcQ8DUDAnZkub5mR6/h3ZKyhJJ83VQGKt47zo3ClppP8s1RYG5SAQh1Soq6R2yt4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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



On 4/10/26 11:30, Pranav Tilak wrote:
> This series fixes three issues in the zynq_gem driver required for
> 10GBE to function correctly on AMD Versal Gen 2.
> 
> Pranav Tilak (3):
>    net: zynq_gem: add SPEED_10000 case in clock rate selection
>    net: zynq_gem: set 128-bit AXI bus width for 10GBE
>    net: zynq_gem: reinitialize RX BDs on every init
> 
>   drivers/net/zynq_gem.c | 60 ++++++++++++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 22 deletions(-)
> 

Applied.
M
