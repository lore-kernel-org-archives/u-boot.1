Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9979FEEF25
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 11:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F06A483A41;
	Tue,  7 Apr 2026 13:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FVKwZTiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 834A484034; Tue,  7 Apr 2026 13:20:20 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F2DD8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 13:20:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/S00wI2qkzjOLsTqq+KgohtJrSAanW+IiG6JTIeG0QlNHrOeSy5a471R8lh+kTcfYc8+XXCtV4zDqut3qEduoi2UyfU3A0jGJ/KHix5tE6BsfO2EnLGzzRqOPVSMCY7KS47mG7Y36QbvUzKiZAKnESQxHCpHATJ5XJrJS9UfEC0YUuzCji82yKF/D6whuPQu09SIDmKfZX04BrCR8gkbWnoGE4MmL2QCGsIqWjGmsyr5YA0olQrazgUSCBxvHfBKx5XJPQ9tEBGHEvZbKuFYWE+l0SINmIzvEskeyWuB8tZMq2fJM500qzub2GtyhcecjMqOqC33X50itWEVmXwng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb6+yOY6LW/ohAVds1ymIhbUqKDSTAeW0/3+T5GhkYM=;
 b=b33GEX+2mPoeg8Pm3bm/84xrOMY/Hvg/t9riSERKtlOU0cAznBTkSWuk/ARXhI4N7YNtxTMsAfrmpUqo4JFqlLHG4ayS4sYypJJVwwRNlS3Gm7t1eTKtZ+9OOC7gd/Pj0DlbmTcLLw9ujj7tSUB7R8912kNFPRW3kBsNI7xFdRTgqtY7R4uJO+wm+z5GVIT1Cl8vszRlnTDzKv1i8UmbcnZDYZyKFjXAhSvwia4D41TfiwCvqumCRbgDVPvzdvfpaOZQYZgmCfE0WswPpfv1UHSUiqH6Ecey37wk2bXo26RWm9BDG1cELO0EOfuLDz0u3gUFctfG+YkJQdwoTmx4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb6+yOY6LW/ohAVds1ymIhbUqKDSTAeW0/3+T5GhkYM=;
 b=FVKwZTiFAPkBnPwAFy2l0fSQSKSxAKZ3yXTo7yWhgFI4ud51ShPt0rx12DjJdPI7ri4falpf5fn/+WOuPQyaOW9oHROoc9l3V9Dm6VSqijX2039CuxAJ+EdR6Kt2N4oN3qEjZsEwolyacdVOuJea+RFwTd5ltWmtRzxcBNnZP8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 11:20:11 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 11:20:11 +0000
Message-ID: <6936652e-171f-4156-9fd0-1d6f6ff5e7d6@amd.com>
Date: Tue, 7 Apr 2026 13:20:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add PCIe and NVMe support for AMD Versal Gen 2
To: Pranav Sanwal <pranav.sanwal@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20260327121015.996806-1-pranav.sanwal@amd.com>
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
In-Reply-To: <20260327121015.996806-1-pranav.sanwal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0238.eurprd07.prod.outlook.com
 (2603:10a6:802:58::41) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: d038c54e-7ca4-4c7d-ccf7-08de9497a1fb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 08xDjkr1IAj+/CV7tP+puFAxC22N2qG3nFwGYmM5yXTRi7MSkCpGrcRfVUtMp6dHL50arxT6nkfhz5o6WJSayxFZ+xCtORgUvcasV9UEmCookWM7n2Aj71lW7HVxCrxpqAWfizmQLEyrKQBNtJnAzjniXf7ZVetT6UtFkg8t2G2gSM7J60sBFF94STfwh7vU3C+NfR9z3451Z0HEdqoYGyFAajYOFqyqNNAtNYHVsZK1WOBP667RIqrGyOGnBL6VRltAltD6L87S+OBRl39ENFQggv+wLTsoyqOsgH7FuEQUfBwd4BJCQcE/gvdI5rFAZZ4cSXuwmEeIzoVMnYQQNvnVFHGNKHVsEDZicglBqOrMIO8zqKa+14H7waIt+eCBKL8T3v1OY5OC6VKTdSI7fh7O+UmcsP7i4tCZhChLNGwZfcXYOgiZdpFvyk4qZof4wAlAafBw61EjALRC/BvXyFXow1GuTAJa9b0f6ofHGBLa8vhl52IP0qwiioNyKa2IEjgCSWiAX3feI48yH1PIteWMiZDVeMg2z/h+bIZoZ9u5DmaENs63Q5wcJT7mNBWXuYCBZhRcYFqq6kNSL7WxtNyrEc9j2Mr2b+hGIK1HEU/pSLd/uueOXuRrDDY32ecy0wWRYzBhX0tpIhji8VXERT+UCm9H82j7/+3Id/1VFMl1B5n+XduA7w2kUmP8PnGD5+E8OcEdvgOZJ42m0M7KuEQQ/7YhuSpL5T1dSusqgUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpUTlpiVTBjc2o3Rkh2UGpnZXhwaWJLMmh5UjF1TXk1MnBUNW1XMkFMaEQ0?=
 =?utf-8?B?bk5lUXBFMzdqSHRqYlRwUnJOTkFqaGRQNWtTeVlTaTl2cFYxbFZTTTJyNmJv?=
 =?utf-8?B?OTJSNHhVUjRhMWVQbU1aa2VUdlhvcGd6U21SMFhMeHBNRlRoMTJOL0hudmpW?=
 =?utf-8?B?U2RhU290cUZQVFhSQXRFcWRQRjMxV0xvdjY5UVNTRUtNZzV4SGpSbHZvRndZ?=
 =?utf-8?B?b0pRR3JQUTFFY25GYkY4WFVlR1FkMHhLV3RMb0N4ZDZseXpXOXBhWXBBcGtn?=
 =?utf-8?B?NGNhTjBXTHJYS0VrU3BaaDBUQWlYbGF1Q09ib1AwcDF5clphMUV5YVlQT0RY?=
 =?utf-8?B?VFp5b1VvL1hJbmJIeGN1NmhvTmVCMGpUTzZybEF1dUh5b0s5aXN0MnlpOUhh?=
 =?utf-8?B?NzlJY2Q3SlgrN3J4R0lmUGhjOGtaNE1mT3NidGlheC9HZWFmNzZ2dllBZ3h5?=
 =?utf-8?B?ZnlwL28xdWdyMDcwc1pjbDNFdlNJd1lQSGhvdUVET1dJT0JNR3hZYmtmQnhw?=
 =?utf-8?B?UGFiVDlZNFVtTCtCZVRQMnJJOTBtbXN1RGhSMndhWUQxREdPb0dJLzdkaVdK?=
 =?utf-8?B?b0JucC9hYklkWWRlY09pQkYweVVONlE1cmFod3ZqcjI2bjBnMzl5bm5SYm9W?=
 =?utf-8?B?ZmFZOWJOYlY1ZlFYRUJ1eGhYYlZmcG03L0t3SmQ0aGJ3T2k1SkxtVWR2YWNO?=
 =?utf-8?B?NnlsV3cwNm5hd1JRL1QzVEUwRVdOK0FWMEQ3OVdWSUVlemI1OHY5cGJaUWNP?=
 =?utf-8?B?OFlOUDJ2V0h1ZDY4WWxrTjE3UWRiYmM1anVKa3BlYzZjdmR6eUduUW5jUDNs?=
 =?utf-8?B?UnNkZUxJKzhxZGdBcGJvMThub0dMNkF2eEVEbHh2Tmo5ZE5QSm94YVJtZ20v?=
 =?utf-8?B?cTZSaVZFUHB0UXpxZWNzUExKSjlUbUlCWnZ2cElMWFBic2U2Z1J2bldHeWs4?=
 =?utf-8?B?TENrRmFFZTlnMkk5WFpuTjhHLzRQY2szNHJISnhNemRYckJIb3M5YlhTNWMy?=
 =?utf-8?B?Z3Z5UTNjbmpNbGhLMXRDaExmUENVUzdhQkN4VlZtR1JhRXM1Y0dJbGlRYklh?=
 =?utf-8?B?U3JqdE5Dd3BTT0JpMjlqRkFoUE05Q0dLSUxsWDJJSWlCN3N2NjJZTlFJNG5i?=
 =?utf-8?B?a3lhOGdLaVZEYk1OSXNNa2MrdDFHdW9seWlubVg1NWpyZUdGeUtiZGNrZ3Bp?=
 =?utf-8?B?QSs0K3NnencvZ2N6aFhkTStXREo3alU2NE93dlV2WHd5QXVGeXRpaU45Sk4v?=
 =?utf-8?B?RjNhR1NGUWpDYWVzV1Z3TDBWY1BoQXJrb3k0MkR2dDZkbkxpUFY1RXJJN29u?=
 =?utf-8?B?b0dhSmJJMk5kMjYvTEthRkcwa2tIdlNzbEViVWtZbTZsbjBiNlpRQTQ2RFZm?=
 =?utf-8?B?V2NBK2FEaFJJYS80eDhBUG5TT2JQeUVNdFNHWGlzcHVnMGhFSE1yWVV3d0Zo?=
 =?utf-8?B?WVdvUTRiVzZCWnhRbUVwVWJZbVdZbU5POURhcXh4Rmxad01xR2s5dHRFdlhl?=
 =?utf-8?B?bXJQZTRLdFdQd0UvV20vZG5oNWZ4c0kzZnp5Tm1QQXVESitjMWIyLzhIWnQ3?=
 =?utf-8?B?RDFxRUlpK2hZMzFUTDVwc1p1MmtXZTlqQThnazFPa0lVYmo2WGVZak9DU0VV?=
 =?utf-8?B?UU55aHdXSjh4a1dLREVqenZJNDlHWWdNMmcvK3FFYnhoVldlUmllak9KbHRi?=
 =?utf-8?B?UW5xWGRwNEJRRWRjQVBmY3B2L2NPRXZFeG1ldVUxcmVyVkdDWkxZVkUzVmUw?=
 =?utf-8?B?M0thdmZsVTBPMHNLY1lLZStNSzFET2ZaYXl3Z1VlTk10Mzd5bmZvT0M2RTFs?=
 =?utf-8?B?OHErSi9McWg5djJUYlJLcVdDdVZGcTJ2ZHlnT0RTMitRR1V0L3YzamhKaXho?=
 =?utf-8?B?dHVubEdhQzZJbEppNXNibCt5RFFmNFQ1R2k1Smp6WlJDNzIyREo4UUMxVDVm?=
 =?utf-8?B?eENuRC80VmZyc1hrTzRKa0tmYXcrdnNrcUVjcHQwVjRQMXNIczlpRmJsZWU0?=
 =?utf-8?B?OCtuSllSUnNKRy9pZ1plbk5PaCtzdVJVeXFudDUxTmdyNHRsdGR5MHQ5WnhJ?=
 =?utf-8?B?dWo4NnpyTmY5UzY2YXk5WW9EaWxkb3VJT0FyMS9OODJBaVNUMmgxSFczMThj?=
 =?utf-8?B?VjN3aU1XSHRSa0E1eEJYWnl1eEFaWkl2SUg1RUhDWU1ldVBmdEd0UERDT3Vu?=
 =?utf-8?B?eENtSjM3eWJNcWdWVXBjK1B1Z2ZpWE5aeUk5ZFdvVERnY3kwZHpHSXNVVmtW?=
 =?utf-8?B?ZEFvemZxem5IVGU4ZFdldUJuRGJtMDg0NUFtUzd0YmxsVXVyOUJMUGJidExo?=
 =?utf-8?B?eHdZNDBpUU5nMms4MlZoOGFPSnVjSm1yd2ZRdmFHNk1na1k5S3Bxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d038c54e-7ca4-4c7d-ccf7-08de9497a1fb
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 11:20:11.3601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMqWhzjpsGhIJ7csLrGtAn2IhGvUsbZzidqLK5za2op724/1HsVcHqOzpMwXwgbh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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



On 3/27/26 13:10, Pranav Sanwal wrote:
> This series adds PCIe host controller support for AMD Versal Gen 2 SoCs,
> enabling NVMe boot on boards such as the VEK385.
> 
> Patch 1 introduces the driver (pcie_dw_amd.c), built on the existing
> pcie_dw_common infrastructure.
> 
> Patch 2 adds the required MMU entries for the PCIe DBI registers.
> 
> Patch 3 enables the required Kconfig symbols in the defconfig and
> extends amd_versal2.h to include BOOT_TARGET_DEVICES_NVME in the
> distro boot target list when CONFIG_NVME is set.
> 
> Pranav Sanwal (3):
>    pci: Add AMD Versal2 DW PCIe host controller driver
>    arm: versal2: Map PCIe DBI and config regions when PCIe is enabled
>    amd: versal2: Enable PCIe/NVMe support and add NVMe boot target
> 
>   MAINTAINERS                        |   5 +
>   arch/arm/mach-versal2/cpu.c        |  16 +-
>   configs/amd_versal2_virt_defconfig |   6 +
>   drivers/pci/Kconfig                |  11 ++
>   drivers/pci/Makefile               |   1 +
>   drivers/pci/pcie_dw_amd.c          | 250 +++++++++++++++++++++++++++++
>   include/configs/amd_versal2.h      |   7 +
>   7 files changed, 295 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/pci/pcie_dw_amd.c
> 

Applied.
M
