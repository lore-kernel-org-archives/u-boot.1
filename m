Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABEFD3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C08C83B48;
	Wed, 10 Dec 2025 08:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qO4Pv3dG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C29883CB5; Wed, 10 Dec 2025 08:37:43 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD68E83655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAxZAt2D7WDefuD2IuhCDsL3iFdfKGteDpt3BQqBbnwWmQfpvJwBdj5EtFwHcxKEdkNnwszf9ecQo9e3SVsit9tmugADmweoqyNCLa9X1F1o5IZeEGZMPbqBbzFOObkhI48g/VpndhxfiB5/J8mRjDx4IFYRijvblLFSl4rZrU1FnipQbFCgMVDzokZJGPauOpFEZAJngIkkGCLir7FtWc29bPd8guCO7YMK6hREyufjgpXXLgIFpqtNVCREuAv3BMAEg8q5G/2S7adtWy/M2T/Z7zHQwJiHQ/wj5WHYcna4Vq94owDUoc3DF6jERF4bXD6ky70+MUyeslFURCRSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqv5UDclhuRWShpPajWYAyIL+/vtuRWIsfOLRou9gr4=;
 b=MjIO9n2u8ztO9bPs840l5zNApz2VQkuJzMLAsYS91rF/EPBKnmW70NOcUYfbIeIBAuWQd1qdvtM3Fn3nqo5pINGghN5aM87iOx2HvIsxcu2CuD7y6eagAUxA504bW4LNodBpJMtOjbCkprbuyzwEXS14+t52QvHRcfo0i3XHmWq81vw/V4r/ErTFf1pIlI1w6Iiqvz+CqmbCWUyun6+1qptqAhKqASbTHEO60v7lhnd5m3sueFwMu2/QWpHT4pJCFAm9BYhPczUIeXRBgrddnZ2udie8zBl5BB54E2R4BGCaEqnEyPehNA6c2Dl1mMaPFtTvR6DoElDlJSBmBVlDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqv5UDclhuRWShpPajWYAyIL+/vtuRWIsfOLRou9gr4=;
 b=qO4Pv3dG+qmoHpQ1LpuywbPqlAceSzQ+ozZrMbdzbMjkcxw1gyT9CWS2xOO0LO2l9MIYedGGlasLJHcuO1SSYUGKyW9rTCpCd6RE1rqBtc1DDAHCchYq6GVJ9ns0/1zvMcE2/P3Qi2yRsLXxmeFFEzOo1ui2UXBQoKhoTVq+tOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 07:37:34 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:37:34 +0000
Message-ID: <b607f048-00a4-4c76-9560-d0f55542a47f@amd.com>
Date: Wed, 10 Dec 2025 08:37:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: versal: Get rid of xlnx-versal-power.h from
 bindings
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <a0f0154ef89929517c3217efe025e8021a910b90.1764233963.git.michal.simek@amd.com>
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
In-Reply-To: <a0f0154ef89929517c3217efe025e8021a910b90.1764233963.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:303:b9::29) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: ed53a8fc-c03c-40a1-d443-08de37befbef
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1RqMElPclU3R1pzakZBSFUzV3dzWVdPQm9nWTRXR2djYlBaV0Q0N2RRRmIx?=
 =?utf-8?B?OXA5aVM1OFJNd0pFekFtVHkxY2VUWkVDWWJNZmkyeXEvL0huY0RwYmxkdFZN?=
 =?utf-8?B?QVN0UW8ycnBpdmdnYXZJN3Y4Z3FLT3puN0FwMlBiZ1dwcjUxeUNXcXJZV2ZC?=
 =?utf-8?B?T2JnZGZDV3dHUDBLL1R0bS83SzI0anU1djl4MnB4RkVncTRpZFhTdVlKbEd5?=
 =?utf-8?B?KzNKOVBlakk3SGhGeUhLR2xJTldPK01yU3dRd1FRRnVYL3hRS1R5OC9EUUt6?=
 =?utf-8?B?VWxPdEkycDUyRkJCMUVXaEtyRXZzd0xXNHFQNEwrZXVuY2k5aHhMR0xGeFBs?=
 =?utf-8?B?TFk0K0Z1NXRHbzJ3M3dieTBuMHVyaDhPWUI4bFlBQi9uZU91YkZ4aEx0QkQ0?=
 =?utf-8?B?dkFQQkZkbDg2ZzVTcXE5emdKekdNNE9WZSthSHNGc3N6TFpYQzZDVnFxMHRm?=
 =?utf-8?B?VTdQVW80S29aNUFqNHdpVG1vL0xYTDhlaGsvQnI5NnhHNVZyV09pekx4VmVt?=
 =?utf-8?B?U2txUlRtVmtvdEljdkpDM1lnL3dmSXh4VmZ3WTUwcHZSRDF0Qkp1azViWmhp?=
 =?utf-8?B?TzErSjE1TGNVVDZjSHFoVkJRakppU2JZSk1DNjNvTCt2a2tPNVZWVGk0bEsz?=
 =?utf-8?B?NDNNdU9zaEZKbmtpUUczQ0xacXQrWGxuVWdaMzF4bU1iYkZ6K3psTHBGMkhL?=
 =?utf-8?B?YkFPNndoSGloSXAyMTl2eVRnYjhoVmVqVE1BV3dNdEl1NVJrbC9qVnAvS2My?=
 =?utf-8?B?U1RScmIzaDhlMTFUOGY1bEdONDBwZEpNYm9Ud21rTWZiVmExeG9mYkhMaHJF?=
 =?utf-8?B?NWRmK0srRUpJQW5Jc1drVnd3Vm1kUFNZRjRsUmhhNUJ6ZDVLWmcySS9lY0Jw?=
 =?utf-8?B?ZWYrT1JCcnRiZkE4U2c0NnZEOHlmbUI5NWFVY0xnZ3NFRUlyNHh3N2JseVVU?=
 =?utf-8?B?Ulprc3M4VXlONFByTzlIaTlFdkxkb2d0NGJLb2JTVkhEcnhONW9sY1NVOWU3?=
 =?utf-8?B?Lyt6SCtlYldNVTAyL2djKzRIVVhvN3AwbXVIMkJMVjV3VWxqMHJYM29uOUlM?=
 =?utf-8?B?aS95c1hCakdvbERNMENFaEoxYjhtcFRNbS9LbWtuREVxblVaWmtBMEdCSjJa?=
 =?utf-8?B?SHQzWFppT2tScklxbEZmQytoR1FJYUxJYnJSQWdzTkhqcXNmREo0Y2w3VGZs?=
 =?utf-8?B?VGF6c0VxMnJvMkl5bllLZkpJWFZLQWNmWnpvLzU4VlZsNWRnUGkzSFNOWXl3?=
 =?utf-8?B?dGEzM1ZBSTQ5amg0ZStiSElESCtYdHJNb0d6QU5WSjZvZ0dNRHV0d2xTNHJw?=
 =?utf-8?B?c200b0w0ZWhlQ2t0L1hXLys2U2NZUzhZbU9EdU55Z2tvL3VvVHNZaFRBcXN1?=
 =?utf-8?B?NEVETlAvV1krZnJIM0s2NytxRExnY3lpWmRyNVQzTktRYzZxWFZCV3pkRjdx?=
 =?utf-8?B?VVNnRXZUNzRZY3FDeDI2VXJ5bXpvVGJ0amFYWmducEQxYmxFOGJrb0lqZm92?=
 =?utf-8?B?R05Sd1R6Yi9IRHg2VzFrQmN6YlM1NWg1NGR2Y05oZEp0NFVZbmdkK0pHbXZx?=
 =?utf-8?B?ZXlBYkxpdVNVZ25DRTVOTStHZ20zK000dTJDTEt5SjMxLzhlWlhsZTZ2WEhR?=
 =?utf-8?B?NE10RUN3WXBQWWQxTGU1UXh2TnV2cEpGTVNuU3RTSmxDSDVxR1RYU0RsVVRQ?=
 =?utf-8?B?ZjlLaEt5WVBPemlZNDVzVS9BbmNlczNZT2JrM0hnL2cwTTFEc3RTTzhMRzRO?=
 =?utf-8?B?NnVUcWF0cnZ4RHhDVjJsSzhiM2JRcHE4cmw5VU9EVnpVbFYweitnWlliVzhS?=
 =?utf-8?B?eUM5TnJXNWJ1bDExdTA2TG1BMnp5alFQQzQrUHc1Q2hTSm0xNThWQzRhZHQ1?=
 =?utf-8?B?blNzSzNoRFpzcnk2WGZCMi8zMWRmRUs5S1hXbUFaZUdaQUlMaDdsRlpXbmZF?=
 =?utf-8?Q?wrBMuRCsP6aAVdcDlT1V7JT4bXCZ3f/8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDk4b3VPWml5a1pIcmJCYXZtZWhIeTdVWE01TWs1Y2NYTFRia0RBMUVpZ2Fa?=
 =?utf-8?B?QmhYWXBDUm4rVk5HUE9Fc3c3Zk5FbTduSEMzYnQvemh5WGM2TkRFVHljMUR6?=
 =?utf-8?B?cHM3elFVUjJrMFJiZGx6bEFXZU5NRmNEYUphSThGeWp2NWYwbDVveWo3L2ds?=
 =?utf-8?B?ZWhYZWxxd1MrUUxzdGYwaVdTTDE1RmZ0Nkc4bHdwKzFiVUNwemhGck9TR2t2?=
 =?utf-8?B?WGxXcmNsa2hwcjE2SnlxMlhHdVVLQWdzN2JPNEE3c25lcXU2MjNnaVZIajBo?=
 =?utf-8?B?bEF4TEh5OEVxWjVWejRPQldYTkhHTGpaVWFIcERRR1VGVDYwZEVCdURydllU?=
 =?utf-8?B?Y3RWMTFzTk9wYTdYN0hKVUVnWGtVaVZ0SlpEb3hVWktXMkpIbXdqa3dJNnBQ?=
 =?utf-8?B?aGEwRkROZDBmZlRFTHJWNENOM0RUb3dYK3NnenNPWnZBc2N4WVpEZWR6SXM4?=
 =?utf-8?B?TTRoU0lWWE1MRU1mNVk0enpCWHcyZXlydi8rM2xpdGJaQnNHK2NRL1p4WkVI?=
 =?utf-8?B?ZUJ0M0NJZWRhRjdlY1hBcTVzeUh1MzdMbnJQRFdaZ0hyeG5VV0hsRTBQdHp3?=
 =?utf-8?B?djFXS2dJUDdIaGM3LzFqcytXVWFCQVFjRU5BVW4zY2xXaEQ5b0xnazlWMCtL?=
 =?utf-8?B?dTEvWUgzTnNhdTkxdGpOaHJnazM4TVo4Wmhxd1BiMXFGUU16NEJDS3k3VHl1?=
 =?utf-8?B?dExuL3BkMXZ1NVl0eFVpNFBhMENndlJCSDhzZnJhMXU5dHdhL1pXQVREdkVh?=
 =?utf-8?B?dVAzd1prRG9mYm1HZmxMQ29ZNEtkU1NrSnFzNXVmRUZKOGI5aC80RVREOVMv?=
 =?utf-8?B?Ny9EOC9RY1ZZbkEwSjdOTUgyKzRNRzVDU0MwL0w1Vzc0d2JkU1BuVmg5WHIx?=
 =?utf-8?B?Y1hRbnhabXZ2MFFOVmJCOEkyMCtrMGNydEhDbFFJYzdobTUvUUVtbHI1Tm5s?=
 =?utf-8?B?b2diQmRTVWpzaFo5RUFTbFFrT0NCRzc3OUxSQ0kyR2NkMjFkdHpZZ3pmZkZF?=
 =?utf-8?B?QVJodTFJUUsrZlBHWVFjSmRjMGE4Ylh5cndMWVU3d0ZteTU0SHJiRTFjeVov?=
 =?utf-8?B?cmsxZWExQ2M2b0hwNXZnb3dDUGlxLzBDL2xYd2VoQWZNRm1yT0ZQV3pNbElO?=
 =?utf-8?B?VXBGMnNHbGJlWG1lREZyekMwREFiOUFvaHdRYTZKb3crMnNzYXU5RDN2eTl1?=
 =?utf-8?B?Y1pudXkwYjVNSk5iMWsyZ1oxSVVHZ0lGaG5YbksyblRFWU9YbkszRlVCTEt6?=
 =?utf-8?B?T3ppVGs3SExGbml2TlRXallBd3pKS2tjdUpGQ29QQjdybWM3R0x6STlsOW5L?=
 =?utf-8?B?a1BmWXBRWVNZWmV2T1hyVUIvQXhtNWs3d1RDbkM3a3B5YUFXVGI3cUVsTVFW?=
 =?utf-8?B?NDBwK2Fqb1JyL2dXTFJTK3djOUVwTHVmaGV3bktKdldkSkx6VldiMU1kdXcx?=
 =?utf-8?B?UHlEM051bzlZNXl3SDkrVVB3LytVQ2x2bVIxQ0t3TmQ2eld6VjNtZXhFTFo0?=
 =?utf-8?B?dkgwSm51UElGcmhmUTdBK0NGc2RZSnNpVTl3cDNEa0ZqZlNlSTdlWFRHMUlG?=
 =?utf-8?B?ZGRzckNFUGJRQytKd0l0MDZpbm1DZzg3RzNpUkZtSFBKTVdTWEJyeGpIQVJO?=
 =?utf-8?B?MzBERG9vSUJuaTB6bGlXUnBRQm5laW1tL3EyMWJ3ZmVXZ3g4S3BWN3pnQnh6?=
 =?utf-8?B?K2VjbFRaQnJ0R1VKMXh0VlA0NFNUY21SOEo3RzVEYnAzdFo3Mk16MGhQd1F1?=
 =?utf-8?B?c25CeFU1MDZRTWN3ZDhBc2hrWEN1YVV4TmQ4ZnRTczFIVFRGWVJqdzlEY3pW?=
 =?utf-8?B?MHpBaHFRWUFJc01ONG1UcXVsWjhxcXB5b0NEeFhrb3FoeElDUzNjS2crYTBx?=
 =?utf-8?B?ekw4NTNQWVd3RU1OTU81eW5WUWwyQlpRSmdOQ29hQzQ5cW1nQ1BnVlhIWUpr?=
 =?utf-8?B?VVVIYjhmL0FXOFlhM20xMkp3TW44dTI2bFlNbUF2Y0VHcTdOOXJqeitnSnVH?=
 =?utf-8?B?R0lEUUcvdmJ4SDNBUkpDZkNlTnhNTVRDTVpVZmFrSGxCd2c1a01QdmlxQU03?=
 =?utf-8?B?S1UwMlhxM0pMZXp5dHk4eVArTjdZcG9sck03OVJ2WFNtTkdpLzV3aGRldlFL?=
 =?utf-8?Q?Jg7pYUn3uOlUoVMKbS0YUbm+3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed53a8fc-c03c-40a1-d443-08de37befbef
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:37:34.4852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbCBN+gQ439My28SgXWUOjfj9U1M9DKlie6BaJt7/TsgkiRE5I4PWNLscGhnAMnD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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



On 11/27/25 09:59, Michal Simek wrote:
> Remove xlnx-versal-power.h dt binding header because they should be moved
> directly to folder where DTs are. In the Linux kernel this shift already
> started by moving xlnx-zynqmp-clk.h to arch/arm64/boot/dts/xilinx/ folder.
> 
> U-Boot is using only one PD_DEV_OSPI constact which is moved to
> zynqmp_firmware.h header. But handling around it should be fixed anyway
> because no driver should be calling xilinx_pm_request() directly.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/spi/cadence_ospi_versal.c             |  1 -
>   drivers/spi/cadence_qspi.c                    |  1 -
>   include/dt-bindings/power/xlnx-versal-power.h | 54 -------------------
>   include/zynqmp_firmware.h                     |  2 +
>   4 files changed, 2 insertions(+), 56 deletions(-)
>   delete mode 100644 include/dt-bindings/power/xlnx-versal-power.h
> 
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
> index e3ddf127e5a8..a00642d09d34 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -15,7 +15,6 @@
>   #include <zynqmp_firmware.h>
>   #include <asm/arch/hardware.h>
>   #include "cadence_qspi.h"
> -#include <dt-bindings/power/xlnx-versal-power.h>
>   
>   int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
>   			      const struct spi_mem_op *op)
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 2d2469565b5d..d1404e13810a 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -20,7 +20,6 @@
>   #include <linux/time.h>
>   #include <zynqmp_firmware.h>
>   #include "cadence_qspi.h"
> -#include <dt-bindings/power/xlnx-versal-power.h>
>   
>   #define CQSPI_STIG_READ			0
>   #define CQSPI_STIG_WRITE		1
> diff --git a/include/dt-bindings/power/xlnx-versal-power.h b/include/dt-bindings/power/xlnx-versal-power.h
> deleted file mode 100644
> index 51d1def67739..000000000000
> --- a/include/dt-bindings/power/xlnx-versal-power.h
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - *  Copyright (C) 2019 - 2021 Xilinx, Inc.
> - */
> -
> -#ifndef _DT_BINDINGS_VERSAL_POWER_H
> -#define _DT_BINDINGS_VERSAL_POWER_H
> -
> -#define PM_DEV_RPU0_0				(0x18110005U)
> -#define PM_DEV_RPU0_1				(0x18110006U)
> -#define PM_DEV_OCM_0				(0x18314007U)
> -#define PM_DEV_OCM_1				(0x18314008U)
> -#define PM_DEV_OCM_2				(0x18314009U)
> -#define PM_DEV_OCM_3				(0x1831400aU)
> -#define PM_DEV_TCM_0_A				(0x1831800bU)
> -#define PM_DEV_TCM_0_B				(0x1831800cU)
> -#define PM_DEV_TCM_1_A				(0x1831800dU)
> -#define PM_DEV_TCM_1_B				(0x1831800eU)
> -#define PM_DEV_USB_0				(0x18224018U)
> -#define PM_DEV_GEM_0				(0x18224019U)
> -#define PM_DEV_GEM_1				(0x1822401aU)
> -#define PM_DEV_SPI_0				(0x1822401bU)
> -#define PM_DEV_SPI_1				(0x1822401cU)
> -#define PM_DEV_I2C_0				(0x1822401dU)
> -#define PM_DEV_I2C_1				(0x1822401eU)
> -#define PM_DEV_CAN_FD_0				(0x1822401fU)
> -#define PM_DEV_CAN_FD_1				(0x18224020U)
> -#define PM_DEV_UART_0				(0x18224021U)
> -#define PM_DEV_UART_1				(0x18224022U)
> -#define PM_DEV_GPIO				(0x18224023U)
> -#define PM_DEV_TTC_0				(0x18224024U)
> -#define PM_DEV_TTC_1				(0x18224025U)
> -#define PM_DEV_TTC_2				(0x18224026U)
> -#define PM_DEV_TTC_3				(0x18224027U)
> -#define PM_DEV_SWDT_FPD				(0x18224029U)
> -#define PM_DEV_OSPI				(0x1822402aU)
> -#define PM_DEV_QSPI				(0x1822402bU)
> -#define PM_DEV_GPIO_PMC				(0x1822402cU)
> -#define PM_DEV_I2C_PMC				(0x1822402dU)
> -#define PM_DEV_SDIO_0				(0x1822402eU)
> -#define PM_DEV_SDIO_1				(0x1822402fU)
> -#define PM_DEV_RTC				(0x18224034U)
> -#define PM_DEV_ADMA_0				(0x18224035U)
> -#define PM_DEV_ADMA_1				(0x18224036U)
> -#define PM_DEV_ADMA_2				(0x18224037U)
> -#define PM_DEV_ADMA_3				(0x18224038U)
> -#define PM_DEV_ADMA_4				(0x18224039U)
> -#define PM_DEV_ADMA_5				(0x1822403aU)
> -#define PM_DEV_ADMA_6				(0x1822403bU)
> -#define PM_DEV_ADMA_7				(0x1822403cU)
> -#define PM_DEV_AMS_ROOT				(0x18224055U)
> -#define PM_DEV_AI				(0x18224072U)
> -
> -#endif
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index 72f6459b91c8..05df49f292a1 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -527,4 +527,6 @@ extern smc_call_handler_t __data smc_call_handler;
>   #define PLM_MODULE_ID_MASK	GENMASK(15, 8)
>   #define API_ID_MASK		GENMASK(7, 0)
>   
> +#define PM_DEV_OSPI		(0x1822402aU)
> +
>   #endif /* _ZYNQMP_FIRMWARE_H_ */

Applied.
M
