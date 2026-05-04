Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BE6FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 09:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA108394E;
	Mon,  4 May 2026 11:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F75AiV1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF0A84255; Mon,  4 May 2026 11:31:05 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE4D480F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 11:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwguTYNMzKyR0iLMeisU8UVmKy5wQ+2MpBiUwt5P1GqqzzdXc1a13gW71cYdOxKOEKEex3GbIOBKkOCsPFgqmmh6EGfQHPWBOmB7bySJBuwSfDum2YQTYctu/nZnEmwYynQD6EFxncu2VyxfnsyxXm7mvatZ6Vk6b7677NSWw4444S695DFqSp1pN9QugyoFHY7P+jBhjYO+0X9uyVcEmR1OiILh+xkJkasUZnwR6o7mkS5ddga5sYPO/J2ERaBUJmNOJz5XcOzNJeIZcItJmaZBx4aS2dYlwvFCqesuAe2kds/E25T8dzwFSkLmLHdpXJ/XkvuP84EcFyoCehMbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLodNz35DdeVkuGFtaM+UejdnCmNC2Q8BjdemOtDNjs=;
 b=t9vJqs3HdLkhfd3vU9JAsb7k+R0QWytwVHXD/1rWKnMhKFa8ThyO3HYLkEvG6ON8tyWFLPW7aeH8HepkIK1DUkBAUG8zTRAPBJlb4XxeDQN3bnmKaDZ5MlbRvQU1+1eorxVCLmuiNgmpZVYc0muQpS1Ii31oaI3PnsZupAESBJ2IjMk9Wht+zN6SORlObOEhdqslInwdF0lWG7GA6hFdfIuCpjljoEscTOY6Je+KaW/4xpGla1hF3nxb8Zq0I69tcQRlShk45JQWPdmIgEsXwHqRMQa6+JFz0uWOdClWJiQH/KqX7v5j5ubqvOFZM0rcTyniONT5pnaSYRisJwSlEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLodNz35DdeVkuGFtaM+UejdnCmNC2Q8BjdemOtDNjs=;
 b=F75AiV1edTnY/fdCFQMfbLm+DZ5RDRzwLYG3OGCf1Xb23f9ml++kU6WoGHvGebUxvbjjeFwsKKydQTsWrQT0NYXqr/wZ3PU5uGilwyWujlpKqo04hwopYDDGAhoR14bfGVQHEzhiNzJ5+p84RG+NtNXMXaepuGHViTnq7AXjywQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:30:56 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 09:30:56 +0000
Message-ID: <c1199f01-e196-4fb7-bb0c-fddd0291ba03@amd.com>
Date: Mon, 4 May 2026 11:30:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Disable -fpic for SPL builds
To: Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de, git@amd.com,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>
References: <6ada697cef076eaed1971c4877c402a91ad5cb48.1777550346.git.michal.simek@amd.com>
 <afSDYX7hJWz6U2jN@pie>
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
In-Reply-To: <afSDYX7hJWz6U2jN@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0107.eurprd04.prod.outlook.com
 (2603:10a6:803:64::42) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA1PR12MB8644:EE_
X-MS-Office365-Filtering-Correlation-Id: bc612241-6f27-4d56-53f2-08dea9bfd802
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: WyoJrFt6XEUasCJrOC7wA5ZHtvLLiB00SgKNYrxDNDo+tmZeaxkdlz3wsjDJy15XZnIMNd0ZcbksS1WnW1UOLfFTDmpntNoK2NpFRiSoZG2cBOEzAgheJwHABm5ikRpulmcRUr4ykwEvfa1ebn30VLYW+TbnWbE3f4jSaXVxvqaZ+ofygEYFGNWCSYdO1JViGm1NDsyvHetKFEFZs+6llM9skAiBKLYcOenz/hb8+0S0RbZk4xdkTTnuuejtJg5JDnxmCtPmMoJiLpT4PKwj7f6pdxnvbVfFvAjgxGK93sa7ZfQNTwpPtTpuzQg+psWOMjezd5+kXhsGD3U7EYZ3aeqmUdFWDu4TQRt1AmWbbOKz+/Hct/GOeBZeSom7gO4ALTMVfGaC2K5iLuUkTzg+KVQsCToWTgkCwZonfW7TL9ZkmDpDJi558tMLU5ng5pH7izGoLRCP2HxbAU2A4nO85dXcJlUyk/eGmACq4iGB+ejyaajG6PXCrtXrzEpRZf8RE34LUU297vvtb2mz2CwMddLPYrUoh2gUq0eawgwe0w2MPXbPdNSaeaNNB9YkCGjgxAg7Acl735qFARc6l1GcrNrSKjlCTHTfL+twqRmE03fG62LFf1CCX9ARZgFW4jaXwYqAYufJdlEJ7INkr5o/V6NCdReqVnELHKw0/L0HzVmdvA2DIyc+O3searYvU5KV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hzMDNEREtDempmSy9Kd085TTdiRXVINkh1NGhRZGg2SUZzbW03NTFYbCtx?=
 =?utf-8?B?OG4rNURrMzdsTS9lbGtnSGEwaUNBNkRGMEZMbUJma21BQ2RCcUFzTkJKL2x6?=
 =?utf-8?B?VnRZNWxJQm5zT1ZRN0k5NE1aekZYSmdyL2ozMUFCYmlFS2dyMlJqTnVtMTdO?=
 =?utf-8?B?NzRHS3hXTlpwNlVEUTk0NEJFM21XWm8vc0FxOXBWeEk3MlhUUjViNjRORnNO?=
 =?utf-8?B?L201c0o5UTJ5T2ZxOWMzYUcyZVRiYVZPSHQ4dEZDZE1BYUY4VXJ1UjZMcnRK?=
 =?utf-8?B?UXBwNGFRbC8zc2hpeGxsRm5TREtaNHA1VmM3Q2dLZStRZkRKU0pxN2FpVDkr?=
 =?utf-8?B?M1JtRWp0REk1OVJ6dHR1bm0wWmUvRFh4QTAzMnRwUjVFZjlucnJMdGtRTnlu?=
 =?utf-8?B?UlJaSmp0a3pUcTRFaGNIcm9ZT0o5SEJoZVgwQ3NocGFXVXc0RGFNbGY4bTNp?=
 =?utf-8?B?cWZKMWhhd1BwdnVwT2YxUHRlaGh3b1JOTHgzTm5rMzRpUFR6VFJQSlE1d1Iv?=
 =?utf-8?B?YWlQc0FWYjdIYmg5ZTdIWkQ1MmR3eW9kaWM1ZDdGaDRUdFc4VDVESWVZcTVD?=
 =?utf-8?B?M216Y0trQXc5R1ZRa0NRV25mczEvNDN0SEVHbllRaGpLL1o4dHFkU21sZEZo?=
 =?utf-8?B?akhyVytGVjdPSTZTckp5S2lTUlVnL21yaE1QUk1yRWNRUDhOK1ljZHVNVDlX?=
 =?utf-8?B?ZGVqdjZRTTc3UE9JNzJ0OVNsNWRzVGNUckF4b1ZTSzhZSnJwZ29idWhWQndt?=
 =?utf-8?B?aldDejZ3RTJYQk5QOGJnVDl6aTVHaWoxSVpKeTdKdWw3WGltU3JQYndkOCtB?=
 =?utf-8?B?QjlxbFRDNlJ3N0IxdTNGRXhnREFEZG9tK0FXNVRCL1Q4VHpmZE1ISENTOWhO?=
 =?utf-8?B?MTNkcWtsci8xTVRSMTdmK0dZWmc3eG9mektnV0RseUc0cmg0aVZ6cStTQmdR?=
 =?utf-8?B?dnhDaTdRSGlFUWU4OVBOZ2FsRTFqUWdlemFWbHQ0L3hpRXVYUkdHcjBLc3J1?=
 =?utf-8?B?UkxTRVczQUNMZWxYYTN5bktqWWFsd1d3ZTdzTlg0Q0U4RXZCbEpZVStoMzVG?=
 =?utf-8?B?N0tyTjhoTDRCM2ZhZUw3QU9pUjErSHlmcUQxTklwdkZubW03OTNtNE9GR0Zw?=
 =?utf-8?B?NGUvWitxUG5qWTRpcmhaZjhDdzNrUG91SDhPYW5jQjdzd0NSc2Y0ZC9abGJx?=
 =?utf-8?B?dVByb2pJWWIwMWR1K24xbjRXUEhScW9GekNzNWQ1MGwrNmdCbEdOQ3FpclRl?=
 =?utf-8?B?dmhtdzRKQm4xOHdYZldxN3EvRmYrYkN2RkJZVHJhNWlTbUQzT25VREw1cG9I?=
 =?utf-8?B?cEo1R25QazMzZTlsUjJvOTA4NXIzcXRUZVU4bmFvZGJQSmQyMDQ1UE9LSUhS?=
 =?utf-8?B?R0JDTjYvdnROMmp0WGZCTU91NWpxWkdWVHN4TXJkOGltaVVJQXhTWTRUY1Y4?=
 =?utf-8?B?dTJKQWUvWjVSV0pJeW82dkdXc2s1aEF5MG9YbCtQNXVibkpPVmowd2RDZWow?=
 =?utf-8?B?dnpWR0RrczhIdnJVMTZnc1A5eTBhcXVaREl6VENXVjYybEVGb3lnTzI1d1F5?=
 =?utf-8?B?a0V2NW03ekZLcTVBL29tbkpCS1lQRFJvbUh1ODd4YXZSUkhNZGV3RXZxQ2pp?=
 =?utf-8?B?Q1hlZDYxVXFCSXJnaFc0Y2tHQXNHV0Z6SUJJRDErWUJ6c1d5ZTFpQlJLZDdR?=
 =?utf-8?B?ZWJ0NERoZU5KVW1zc1Y4VG9HQ0xMWTVOdFFMNm5JaGpXVXpoUk0wcTBla1BO?=
 =?utf-8?B?b2tHNkx5RW1yR2lsT0hyd2RMdFNSbE9FTkZiOTdMcTJPWjZCZ29JU1QxczNT?=
 =?utf-8?B?cTBuM09tK00wWU9rY21oRTVjdkVQTlJtMnIxOGw3TVJ3V292NTdMWU9RSi8x?=
 =?utf-8?B?U2k4TmlFNGp0eDU2eXpLSEV3YzlzL1E0VEU0OVg0YklIRU5aYjNlMWh2TzhG?=
 =?utf-8?B?QWtCdTlIQWFFNVh2Q0tUdEQ3OXY0OTB4Y085SUpzM3lXT1dsVVA5YWZJYzVw?=
 =?utf-8?B?NkszZnVEV29MOWtGcWUrK3lpeEVhY2FJVDVldWVNZEM4d0RVVnlEUnBIaVBl?=
 =?utf-8?B?VExmanpVQlJkR0FoQUlzaDMrTkFadGxrQXVlNUdkb010OWUrSklJem85Y09h?=
 =?utf-8?B?TDRvWWFIWk9RSEFaY0NrMzJZNk9hV0hEWVV0eUNlRXczTmhSY0ZDSjZ1SVJN?=
 =?utf-8?B?UktzUVdMVGRIT3lBRWVTU3hHZXBobmdYNjU0ZUNDdnZGNHpoL1N3Q2loOTJx?=
 =?utf-8?B?VzRSZU5obXpLbFYzR3JzLzU3dURaaUV5MjFTY3lFZE1jNWE2UVV3ZXd0U2w1?=
 =?utf-8?B?S0RIeEZubzREV1hpQlZrK0FDbklZVTB0eDJ4bkZiZGlSWUZKWlY2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc612241-6f27-4d56-53f2-08dea9bfd802
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 09:30:56.2967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PE7ZvunKFjB/Wwmw1gG2zwmA+sVNJ3WfMB4wn4gJk08b6esRSC5rPAWOC8kr/Euz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644
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



On 5/1/26 12:41, Yao Zi wrote:
> On Thu, Apr 30, 2026 at 01:59:07PM +0200, Michal Simek wrote:
>> When building U-Boot SPL for RISC-V with position-independent code
>> (-fpic), the linker fails with relocation errors like:
>>
>>    relocation truncated to fit: R_RISCV_PCREL_HI20 against `symbol'
>>
>> This occurs because SPL's linker script places .bss in a separate
>> memory region (.bss_mem) from .text/.data (.spl_mem). With -fpic,
>> accessing global variables uses PC-relative GOT addressing, which
>> fails when the distance between code and data exceeds the 20-bit
>> signed offset limit of R_RISCV_PCREL_HI20.
>>
>> The main U-Boot binary requires -fpic for runtime relocation support,
>> but SPL runs from a fixed address and doesn't need position-independent
>> code. Disable -fpic for SPL builds while keeping it enabled for the
>> main U-Boot image.
>>
>>     spl/u-boot-spl: all -1187 bss +4 data -2631 rodata +2440 text -1000
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> 
> I've sent a similar patch[1] to fix issues caused by GOT addressing when
> building RISC-V ports with LLD, and got feedback that without -fpic
> CONFIG_SPL_RELOC_LOADER might break, but don't have the time to
> investigate it further.
> 
> Maybe we should coordinate on this. I'll take a look on
> CONFIG_SPL_RELOC_LOADER first.

Thanks for pointer. I understand Heinrich's point and no issue with it.
But I expect this feature is something what should be enabled (or should be 
possible to disable it). We need to stay with SPL below 64k limit and relocation 
is adding too much overhead for nothing for us.

Would be good if you can find some time to look at RELOC_LOADER and please keep 
me in a loop.

Thanks,
Michal

