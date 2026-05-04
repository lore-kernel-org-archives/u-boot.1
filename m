Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B914CD3423
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 09:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA048394E;
	Mon,  4 May 2026 11:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ODO8Zh75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BF880F0E; Mon,  4 May 2026 11:27:17 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3BD78460B
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 11:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbnMuQX0M7t6QYpBoo1ae/WRvN+2RA1jWlvUAMd7aOnlhN9Bc87teRNnwng1bqWmpWEv0lh7Qcr/q3+KX3f7I9CI/im2ax/aKfM6FIBEj6Dl3vRKWNUQukH+8nqwguGfNIoodNsuFomFQfgo0Qeo7NUBsYnyZjgAKVVviUF5+y1UoOzPGgCtsL5P+diPPcbJWEtMe+Q4eE6RmY07jPIOKr70gwFfRkrD55t8SaOPEr28pt2JPyMwXwRGbZzoyVKvD119ZWUL0vfRRJifEvx9Da2JSpdYFo1HGf5HdVNB7LofyJbYiW1IMNrdN9/EBV9xC1DB/FeB1Shh0Gh69wSCRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/FSizymZhZnluq+rJsYO61NkOFz/nSus6RLmfu/Xxjg=;
 b=mtif1urWRXkdPj7impylsKi8GAI98jLEd9eiDuVSRBx5kDEU7b6ukLgXvPQ8fdhXskVHPKap4cGxwLb+ZrRmVTe40B1lABP/+7pMvdOpyNZD+sBAnpJbZx1qHsGufoOrS167Wp8/v3YnIydi1PGJ4zJa9Wb5c+uYUKnMHOhNi8H0A2YxAwcL22DiIfYwBzqvSLrO48LpXxKgqJrmVtwj+3sMNXd3kJfn3vh3TrGC5Nf3XEjLBbBlDjc/fZOBZl/iB4Nc0g1SNyK6aHXjv6OojsuV5sFl1qxcvOAn7zvnDcFzD/L7Am14TVoIJp7nbea4AFyG3bF3bCuoZEIuYAfGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FSizymZhZnluq+rJsYO61NkOFz/nSus6RLmfu/Xxjg=;
 b=ODO8Zh75UdJw0csqvKJY278BUZNcvg8N2/tnmLpLwR2kCyFgxZ+pQYRLuxB+wDnVS6i9fOOJ+9i0e0w1VXVfJ9BbIGqAIPfPrnnpDNKHQCKxDmtrhy5PrqCACiuL3cO3nJwi/4VW9GHYpqCyeWfnp/GTvha3NgaFKZMvXxq/A0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS2PR12MB9688.namprd12.prod.outlook.com (2603:10b6:8:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:27:09 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 09:27:06 +0000
Message-ID: <c588bb23-b4ea-45f1-b2ca-ec346d55e67f@amd.com>
Date: Mon, 4 May 2026 11:26:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Exclude ACLINT for TARGET_XILINX_MBV
To: Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de, git@amd.com
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Tom Rini <trini@konsulko.com>
References: <75160eb268d7a445e8483b357f7814bef30b12d4.1777550306.git.michal.simek@amd.com>
 <afSBgg0wWVBn5gju@pie>
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
In-Reply-To: <afSBgg0wWVBn5gju@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS2PR12MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 25320d49-8941-4de4-6d2e-08dea9bf4f43
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 3WGRr4tUxFB1WvcnxoQh/7IvtgzCDv0LwojHtrPMLM62yzFgXCKnbuLTVOF+/1FwRGexck6UDzEpvT7jzzQ2oOFyI2YOmaoLNnfJ8y7QG5pkjdTYYGRg01YQ0ZpUjmPtgGcrTCmwPP3b5CQzKugwZwXfWILbFnhObL9TKQphYaC0mp+GroND5ASIvjOSrlDJ6HEpYshyuTgYUM97bcHWLbzAlG5KfnkIwKIFnf+oqIOVl5te5GYFo+wRcc4YqSs0Og1Ahd+8SB6H7xYtvYEpSI+k7AZUFT3pQUjfJfraT7z8U50FCLoXW1J7UUIuJ8SggatKWMnm9Ac8aq4UsYCboKONcAoU+NSnJHFSgowQNyTneXTDrQTqs59uzRAqFI2vQ/oj0NvC22rJObs9nMa3niHhssRQL7Hw/oXBbr/tW9naJRjkTtxYytorScYX9jHiTL6w4LxGJ2LOUmFk5++dabYvxTiXkcEmAbUj2U9M+cIcLf1kNJXIbNne0PhjMZ18OweemHX6iSAYWIes8pcR3ZA7KPTW3hh6X1fUwopEFkvn6as1JNBsgZDdYfdRLpfNQtR+I3qgd3nbd5aBOcSpuQLPgq27hUbYxjfkkBQxm8Bu9L9AUxZRcbB5LcimQ/lpN9JIoEnULw7j5zBqLmD3+/HKZ8Spsh5SgRliGjiHTB5U4x+86hHECrm+tt3Q4AWb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OC9rOTVyM0VkTkpNS3BLN2Y2cllFZ1krc0o2QzdtNnNkZU4zTnBZVGFaVWpH?=
 =?utf-8?B?cDRZbVlFN0lySndVbUM5RUJ3MDBUeDFzMXdQV0Fkd0pHRFhUcEQvbUJDNjg4?=
 =?utf-8?B?NEVWbXJHdnFFa1RlbjBWc3hrRTdNb044U2puQzloL1dLSjl1czJUekZhcTlR?=
 =?utf-8?B?bzh5K0lMVVhjYXN3NFdOc0RMTytvTm42dmcxWmhTc2dMMXZndW1KcFErNUkw?=
 =?utf-8?B?Y3l6NHRvL3lNaWlpYVZuTDhxcUt0VDdlVDFBSDdQSGdwSGg3THpsRGQrSEVJ?=
 =?utf-8?B?VlRvZUlnemhyQ2h3aCs1S05WdjRrSjFUNzlqMWhJYTVUL0ZDUXVMa1FOejYw?=
 =?utf-8?B?M2pKSmRsdG41b1BGYlFaeVROSDZKNVdzVHR2Zllkd0JhVzJOTTNmejEvT1hS?=
 =?utf-8?B?KzVRQjFidDN5bTNkejhoQ3hWN01jUi85WHQ0WGNBUzgvZys5WGpxTGh0YU9Y?=
 =?utf-8?B?ZVFISzhjN04vWmlSbnVpajhlaGkrUHgyU2Z2ZkpML0JicGZ3L0pmbFBVOUV1?=
 =?utf-8?B?aXFSa21od29qemUwZHFnanlQZnJ1RnhndWlSR2k3RWIwWmJGcG5JOHA4R2V4?=
 =?utf-8?B?cy9FdHNmOHNmb05mWFErYTlOeXhRdTRweGVFZHB1S1ZhVm5oTUNwVkNuL1dZ?=
 =?utf-8?B?Y2RQYklmQ2wzc1FVdlZBanNKSXh3dTkyQWpUZUJFcFNJWWFkSlpnazZyNy9i?=
 =?utf-8?B?UlcrdytubGNJN1Rtck5INFZNVUdiTU5QVjUvRnpTczdTVWM1SHNZMW9SZ0NB?=
 =?utf-8?B?cWJJelowaWNOQm43MDBpUklZMFdSWHBzRlJUQlpXM3k4R3l3S1hpaGl4Njlo?=
 =?utf-8?B?RTJIcjZqM1lQSlRaaDJadUEvTlhlOVFaUUx1ZlA3TWFpc2dnYXFLZTVXTDcr?=
 =?utf-8?B?ay9CNWF6aCtBRUlMd3pjUSt3VVUxaysrc1Z2WHFHRzhLbG9mV3ZiSWI5RnZW?=
 =?utf-8?B?QjFUUHh6cDE4QnNLdWg1VnV2Y29qWXBRazVMd3pOZEZIUkliWDhHUDVkWWh5?=
 =?utf-8?B?UURTWUM2bXBlaE5qRnd1dno2TEtENHZ1SjZOVW5YS0c3R0lrTDFTK1pFVUd2?=
 =?utf-8?B?ZVk0OGs5Vlora1crVWxBT2t2WXJxTVFXeWloblZNZ2J1aUNQYW1vZis3dVpS?=
 =?utf-8?B?ZlRRelVjZUJwMDgxRk5Pem1tb0tRUmNHYUUybElIWUdXa3E0RTJ1a0tNSlk0?=
 =?utf-8?B?bXpmK3c5ZlVUcHNUTWNJaEQrWGxkVnlHRUlIcUNCNDdzNzJPb2FtL0IweU03?=
 =?utf-8?B?MzZEejF2OUdKQnlBOWFaV1Roam5WanloWlhNQVFOWVlVR0F6RnNQQ2o2aDR2?=
 =?utf-8?B?T1FJSGxWUE5abm0vWTFkMC9XSTJyZWlBUERISlplWXNUWHlEQVJ5NGhSUXB4?=
 =?utf-8?B?SW16UmtaR1hDVDdBSE16M2ExLytodXZwVFVja2RjWEJNQk5TUGIxa2tGSWJR?=
 =?utf-8?B?VDQwcnBneDhxMER6OWl6ZnE3eDdrT2REQmxCb3BpTDJDZ3R0eU9oV0Y1WjFE?=
 =?utf-8?B?NXNHZnA3OWIveG41ZzRKM2w4RzkxSmhnS2dzQzBCdzBCTFlmSi91ZjR5QTZN?=
 =?utf-8?B?aDVkaU5BRnNxQStqZnB4THd3SSt0NnlGclVoVFpNU244SmdzMFByODNXVm1r?=
 =?utf-8?B?K3RGbWlvOEVQMGx3K25hbDFlRS9xOUhVUUt0Ymt1SmVMSEk0QjNDZk1QLzlh?=
 =?utf-8?B?dWFLZ0JJeENmYXZGa0FNTzJEcFhjdjlRT2JoVng2NEIyb1hXYWNhemxRUUN2?=
 =?utf-8?B?My9aQXQ0QVVKeG5zZ3E2Y21lbklWTnN1NVFJZnBXR3FvejloSDFwVG1JVHow?=
 =?utf-8?B?VWFkUXQ5aE95V2ZqazFaN0FvMzFxMVhBd080a005Uk90RmVEUlFSZFFucnRX?=
 =?utf-8?B?Z2RpUllBbG9VRCs2T3RIcmpodjNTdmcyQUV1YU5zQ0lMdkt2alYxa3dFT1hV?=
 =?utf-8?B?SkVqUFhRaWtvQVhOdjAxKzgya1NHS201M2IxWHBacllaRWRFREhhNW9zVExa?=
 =?utf-8?B?UHdFK0ZwUEFGTG80aVErZlk1WUpUU3NvcEJmY1E3WVpYRldOaU94RERrOXN3?=
 =?utf-8?B?T2RLbHVsdHEzRCtyRHcvMUk0SVc2eXJxVjBjYXRXR05CVjYrcWR3Tiszamxz?=
 =?utf-8?B?QndZMDZGblNvTjA2VnlOTWtIcHowaTE3cGJxVW1wN0pMOWEzUHhXV0F4ZzdP?=
 =?utf-8?B?TVpqYkpTUGY4RHZPSlIwUWNmVGxNdER6L3ZoQTEyLzNoWGRYU1dDWmg3VVc1?=
 =?utf-8?B?bUtnYXlhYWk0MEpycWRGUmF5T29BNjVqUCtyRWYrS09HQ2pvMkg0OTNOYUYr?=
 =?utf-8?B?M3JEUmNVVTNrd0I0cVNTWkoxbFR2M1drMXJsMVBtOUNMOEFWVDUydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25320d49-8941-4de4-6d2e-08dea9bf4f43
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 09:27:06.8413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hImjrYWY8IL9VWv78hemDzYBgRz9TGQzIPuem4wCXAvM1/yzENLOZCJvCEbBmNv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9688
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



On 5/1/26 12:33, Yao Zi wrote:
> On Thu, Apr 30, 2026 at 01:58:28PM +0200, Michal Simek wrote:
>> The Xilinx MicroBlaze V platform does not have an ACLINT (Advanced
>> Core Local Interruptor) hardware block. The timer functionality is
>> provided through a different mechanism.
>>
>> Exclude both RISCV_ACLINT and SPL_RISCV_ACLINT from being implied
>> for TARGET_XILINX_MBV while keeping the default behavior for other
>> generic RISC-V targets that do have ACLINT hardware.
>>
>>     spl/u-boot-spl: all -1382 data -360 rodata -200 text -822
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   arch/riscv/cpu/generic/Kconfig | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/cpu/generic/Kconfig b/arch/riscv/cpu/generic/Kconfig
>> index 2baba2299238..8d53c69ba38c 100644
>> --- a/arch/riscv/cpu/generic/Kconfig
>> +++ b/arch/riscv/cpu/generic/Kconfig
>> @@ -10,8 +10,8 @@ config GENERIC_RISCV
>>   	imply CPU
>>   	imply CPU_RISCV
>>   	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
>> -	imply RISCV_ACLINT if RISCV_MMODE
>> -	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
>> +	imply RISCV_ACLINT if RISCV_MMODE && !TARGET_XILINX_MBV
>> +	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE && !TARGET_XILINX_MBV
> 
> Would it be a better idea to make (SPL_)RISCV_ACLINT visible and
> override them in your platform defconfigs? This avoids introducing
> platform-specific conditions in a "generic" CPU Kconfig.

No issue with it. I sent v2 with this.

Thanks,
Michal
