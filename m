Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395F6CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 317518206E;
	Mon, 29 Sep 2025 08:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rmMZaMa/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60B4482A9E; Mon, 29 Sep 2025 08:11:56 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC988144A
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 08:11:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceuhr8m/JlTyLjrw/ghZFvmCFLIqShkWOBW3OleQaw5xJuXKCND0hiqrfG28mIXK0z1s4xi8yI35vnCQ+EnHRwW8EEb2dl1qoU/7TTXaWqy9HXAyRBFCWn8aVa9YDyUj32llE1w46nJQOjqL8hyi4USP7B6oH3uQLugujFtoOUlcMhwPnxQEoUZNbpStdpKAhKXufSCjVsWdl49Jur0OaYB/nHDlCy6WqMr2qSoe+trwnhhMVIKOcw4NiH7HUwKiNtRw/cHOJyrqUDpU+zwuOo4XQnpf0mxTBdy5B0lcAMXOsYwxe7ELxyWm0muMyQ5ADBzpNpuNCk7tfjnwVzFJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAYv2TVdRLUq+GOnxDMUmjf1qHPYUEt2gPc7585Ir7U=;
 b=kg84eL7LVbx7eJcSZqVJm7ULTSXm+iowyGNPzxK85EhBpu32p7mwqFG1RHubADe9d9pn7OYOH4qzKvzI2Tgf3YwWzqothi4l9J1CMsAjxhs26vhUlJY7iUz+Ua8LXyKs2d6RpZuX93mEEAyOb+DzT/vPn4Y5N6jmeuUmXu8QTBuvX8SaR5jKKwJHiHIyY+DCzlfNff+vcOfaTkNdY5VjuaHZe+byPMWatsbAs661oGn6NDElt2IG/YC8d+JNhtIDL3OVG7h9YlSqJBDnHbww4TlhMhJgyUWDsGODwRh0NrwEeOouk0O21DZI4OstMVWAkJhI/nn+mbb3Q3Gnj43UIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAYv2TVdRLUq+GOnxDMUmjf1qHPYUEt2gPc7585Ir7U=;
 b=rmMZaMa/Z/EpLq74waG3ceagVPDYAsSgn+q7OLGPiiiJo69o0QzkMKw1bU1aXa+LTyacj0L7JIJi3FuNuJobB7VlT3IRMgqx2lP+U+zlLzCvZnwaVbpojXOWpzvUvPyweti7k5fePdgdIGwB2YhkHNrKAjm/ETlWIiDOFjoeDuw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 06:11:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Mon, 29 Sep 2025
 06:11:48 +0000
Message-ID: <b672e123-68ab-4772-8b7e-01b3fe916fa6@amd.com>
Date: Mon, 29 Sep 2025 08:11:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Fix DTOVL warning about graphs in kv/kr260
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Rohit Visavalia <rohit.visavalia@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <576630cc9696e21bef15bd1f0ca35e396adc4eca.1758529693.git.michal.simek@amd.com>
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
In-Reply-To: <576630cc9696e21bef15bd1f0ca35e396adc4eca.1758529693.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0255.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7500:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b742b0-3476-4a87-7833-08ddff1f12bd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGh0SDZocjBqNS9lVk9nNG1MTUl3ejRvUXFIdlJxZHdYdktXTUNRRU4vOU1Z?=
 =?utf-8?B?M3l0a3o5eTg3Ni92QXJUNTAwU3Z2VkhxTXIyaGhMWTdManBKc2UzK2dCc0E0?=
 =?utf-8?B?c015M0lsSUtxMmVwWnJMOGVKUVNlVkgrUTIvSGZwNVFBd2VidUFLSnpoN0Zs?=
 =?utf-8?B?QUVKLzFMcytpZXFVZHFoTDJnTHlCOEE4RE1IMWloK3UxUjJFa2VuSkdmT1hk?=
 =?utf-8?B?Qks1WVVQM0VvSktvY3dSY0txRnBQck93L1R6azlHaVVBdzJWVEJpc3dqQXl2?=
 =?utf-8?B?WG4yelRRemJINWhzd2Qrc04valhSSVFpcitQaHB6cXg2OFViSGd6S0lWcThx?=
 =?utf-8?B?WEtKa1VqditvNWRlYkIvTjZVek5EVjVtYnJ4SVUyTkw1Rkd6UldQUHgvd2tY?=
 =?utf-8?B?aTdGZXRQY1VaaEZPUllrNlBpamcvc0psMG9wTWlMT3lPR1M1SzdzUlFNU2p6?=
 =?utf-8?B?bkJ2OExpcVJIY2QrOHovaUZvMXNUdDJBOHdYWkZoM2V1ZG1jOEFXSVBhUDZM?=
 =?utf-8?B?VGJ3d2lodXFFaHJvNWtoaUUvaDVVRloweHFZYTJucDUrbGRZb2lDd1llMFVB?=
 =?utf-8?B?by9aN2ErN0RZVzVLZVRaRjg0U0lZWmIxcXM1Z3NwcDFhdjZYMnU3M3JrMVI2?=
 =?utf-8?B?ai9iUXlta3l5eUltMlZ5TGUvVWlpclFOYnpnYWdUMHB2bW8rNmE5QUZyQ0xk?=
 =?utf-8?B?TXVnNWJjMGZMdXdVY2lpQ0FmWEZYc0ZpWWJ6SWlPL0pvVkNiWEF6eENEQkdL?=
 =?utf-8?B?S3hCbVRYVVVkd1NheDdweCtYWU5hMHcvM1pLREpJT3lteGIrTk5wWFVyWFFE?=
 =?utf-8?B?T0VFNWpYU3FzOVJGV0xnUUhING5FQysxSXM5YkdOWEFXdFA1QzMwQTBzSUY2?=
 =?utf-8?B?MktIZ3BZbHh5RUswM0hlT3lyZWo4R1hXYU1ZVFF2TlIyOGh0eTlLVGNLUDFR?=
 =?utf-8?B?cjVTNW41ck4yUXJpRXNsY0tqcE5KUjNoNGxkZFpuZGlvR3IvY0xKL3BkT1ly?=
 =?utf-8?B?dEw3Y2x5R2dtR2Zib2lyQTZLMFJ1YmhWRUlhNmVucElSaDBXNXEyV29zK05I?=
 =?utf-8?B?c2tXM216NnFhZXkxM01kYjF2Zmw2b1ZnU1pFNXppVlh1MmNweUdlclhRTjhG?=
 =?utf-8?B?WE9oZUNKWEx2dnB2VWFjSFBmTFlYMDRFZ2R5Rm5oSlFQMDV1NmdmM2pIRytW?=
 =?utf-8?B?SnpLV01DWmx5QWJJOXYvMzh6QjJ2c2lYZnkrQ2tGdnlNbFZSd0NFTWpsdVBp?=
 =?utf-8?B?MkxjL21oNytVYWFxNDBQNlEzM3Q0d3NMVUFWTVZVSUhSdmNkWW5zblIvZ2Fw?=
 =?utf-8?B?RUNCbGRld3JWUWF1NDNTNm4xc1ZKcDNYL0NuakdTOC9DSSsxNDVMV1FDL3BT?=
 =?utf-8?B?enJnbFg0NWdoVGhJRnVoVGwyMGhZNUlKWnRVV1Zidk00WmlWYUxWZXJKR1BT?=
 =?utf-8?B?SHVQb3RGZHJzSDE4Rk5Ib1RiNEVweEI5bnJLL3hRUE5GZmVPVWQ3V0xHcDZ0?=
 =?utf-8?B?aU1KTWxVOGRpTmtsbUR1TVY2U21aWG1nb2dyR3YxY2FIUHdONTlZajZwTkdE?=
 =?utf-8?B?KytEazZVQU5aRWc2ckYwVE9XTlhrQ1ViejdWTlA3K0IvTEtDcDF0SEVJTzhk?=
 =?utf-8?B?ZWJ4OFdCREl4NXZOZnlhZUw1V2srM3JWMkd5QVZFYXVHQ1o1M2NJa2VNYzYy?=
 =?utf-8?B?N3p4V1BWMEtvTGt0NXZpUG85bEJmOGsvaEh1eHZzQllGakdrUU1JbTFneTZ3?=
 =?utf-8?B?UzhoMk5vV3JZVTJiV0FSOXFJNWRIZ3NsMzJHTHFzQWNSRGhFK0srNEdCeTdY?=
 =?utf-8?B?M1d0S1J4Q3J3NTBsckpySlVSREttUVU5RGZZK1ZHekwvTjZkemkrbU5JN3Rv?=
 =?utf-8?B?VlNoYXNSTHJhVnp1OVpVendIVlM1QS9WYUdxT0JoK25BUVRsVlVPaFh6T2tV?=
 =?utf-8?Q?lQFgmLhyUqbkhwaSAeuCKvgxt9D4artl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUNibHZjZ1ZoWGFyMFVYajNXcktqSXhxNXM5TDdTYnNvWFhpUmNSMmxTdlI5?=
 =?utf-8?B?Q1M1T0tLTXU0YmpCSTBWanFoRUJPTGFQUUE2dkhIaTFoTHpldk5PcmRGU3p3?=
 =?utf-8?B?ZHIwMHpQbjR6U3BzTGtyNUdKUmxLaDRpZ1NGdGpSeGc5RllvNG1odXFOVS93?=
 =?utf-8?B?bU1iSGxERDA5QWJyRndROENTTFVWcWxKejdUN3IycVBUYkg4d25HYzN2RUcx?=
 =?utf-8?B?VVd2Zk45OFVkMlFEekF3Z0g2WUdocXpEVWhudGhjL1I3eWtwYmY0QWg2cUV3?=
 =?utf-8?B?Q0tnS1AzYTNuaE5GRnhxaTcrTjNER0Fab05hMTNOcVNzdThUb2JZbGpnQmJH?=
 =?utf-8?B?ZTU4VWVJNGFEaVJmZTFRZUNtNWNGMGVFM0VJbE5uNDhSeGhhNEpMR2pnZHB4?=
 =?utf-8?B?UjZZeVFHYmpkM083c0t5SkN5aVhkSExJY0JzRC9vM20wM3c5a1hrZ1hPOWEw?=
 =?utf-8?B?MFVsOVoyeU41ZEN0NkR4bVhNUnppVU1CYUd6WmZZK0h6RmdKdnN2dUhETDJz?=
 =?utf-8?B?QjltOVB5UWxtOUF0SGJXQkVLbWlnN0lwWWNyUmlLMFZCTEFXTC9Sb0k2Z2wr?=
 =?utf-8?B?c3lCbzB4cDI4cG9BUUhtZEZJcm95cGxrRERQMUhlU21YTllaMWFzTjQzWkE1?=
 =?utf-8?B?aDEwTFA0MldjdnVmd25KdHVRK2laUFk5UHBKKzZNbkUycGt5QTExYVNENVNS?=
 =?utf-8?B?N2ZYTWFGUGg5M0duL0RzSGJ4UTlKRHFmN0dCQk9VbkUyZjV2T1lzSTlrR3Zt?=
 =?utf-8?B?bmJGSTFadm1sSy9xMG1ObnN6M2ZJOHd6OFhYRlBWb1lnYUZLbUxxSFJoZmZI?=
 =?utf-8?B?dDNEdFNMS0ozOCtXVUttQ3VnQ0g0b3ZWRSsxMmZCTERMRThWMVRoTjQ5QWln?=
 =?utf-8?B?aEJ4d1dHSThaNEVqbkxqV09wR3NJVTJnbEhnQm1iMFFhYkFwNVNpNlBkQi9S?=
 =?utf-8?B?Z0VCS2QyMlEzdUVoeG12dGdXSlZ1QU9GZDkwNWtHREdWSEF5WXMyR1RMTzR4?=
 =?utf-8?B?OGhWOVVJTnlQR3ZoZG53bG9qZUo2MUpaaGRDemZTSDQ5ZVBDOU0xQWlWQm1I?=
 =?utf-8?B?MVVLMERxdXlxaGRyK3lwODk4YldwZ245RVlJSmh5a2JzRDk5T2t2M3JNalI5?=
 =?utf-8?B?UXB0blk3ZmFaS2hTY2NuQ2ZNTnpvZHRHOGZHTC84bGp6YlRrdVF5aHNHVGc4?=
 =?utf-8?B?dm5TWnlLSkdtb1ZtNjNQS0Q5R2ZCeWYxU0orZ1dGL21scVZDL29oZHYzN0xk?=
 =?utf-8?B?RUgxenorUG54UFdJV1JVSkxNWWRGQlJDbHNmMFZzVnNLZ1htcC9qUnliSkh4?=
 =?utf-8?B?cUhqb0hhQU9nd2J5R0FURmN4TDlZd3docnpkQW5SZnB3VWJnNVVnYlFKMGtV?=
 =?utf-8?B?TGVJNEcvaUFtTng1dWdocldwRncwL1dPUlZkdGZsZVNNWnNmcTBpZXFHSUZF?=
 =?utf-8?B?LzJXZEdtdWhIWmxpOVdUdFpmRFJsRlZyK1ZSakpCM0NIczFaQWhxTHc0Z3pJ?=
 =?utf-8?B?T3pQbTRhSTlVNUdhbmJMdTI1N0Z2UElKM1kvVy94dmdoNFBjUm83bzcvaEhF?=
 =?utf-8?B?QzBZSjhzVVVsT0xDcGZTUTBaSk5VdllOWURiSFkyM1Z0Vjg2S3NCYWFqNVJ4?=
 =?utf-8?B?WWZSNFRnUVdVV3gxSkRrVnJQSXRSWWlrUE1MTklDOS84NVRLbS9pOW5nNGxZ?=
 =?utf-8?B?SldrZjcxbkdsMk1oRGV1V0t4aWNuTjlzT3NWc25CdGlLK2lRaVFMVzVVRG83?=
 =?utf-8?B?eXhBbjlEaldyOGhwUEZHdG5jaGFJVE43V2FVRmhodXkxZEpMVGhxVXVwV3hV?=
 =?utf-8?B?ZWMxeVpONjFKLzR0bGtvK29qdHVYMTZSdGNwajBkSC83MXAyWEc4aUdjdzds?=
 =?utf-8?B?SWlPQUpoYjZhaytTdDBMQ284LzZNUisxY0RRQUxRL2REQzdnL0dPNUtBVCtk?=
 =?utf-8?B?cG53U2puZGdnRXdZbHZaUEM2N21sbjk3NFZ0czdUVkRzWnRCanA0RkNSWlU3?=
 =?utf-8?B?N2RLUG4zTk5uN2J2dmFwMU01eDh5ZDFIbUJLMVM2eFphTHF2elNHUkdQS1Q1?=
 =?utf-8?B?UlJ6MG9XRTM1RGVSR3RPWkk0ZENIUVE0T1podHA1TW9POTREaW9PUGh0S0h6?=
 =?utf-8?Q?9EC1n6uL4wuuDV2do+PMssGKg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b742b0-3476-4a87-7833-08ddff1f12bd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 06:11:48.3322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwOqWEFsSgeoamWcqDIDjbQhYqAarYRnssAfJYFNrr5IphGlUKVaq6FDPX2GNjNu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
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



On 9/22/25 10:28, Michal Simek wrote:
> DTC is generating warnings about missing port like:
> DTOVL   arch/arm/dts/zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtbo: Warning (graph_port):
>   /fragment@5/__overlay__: graph port node name should be 'port'
> ...
> 
> That's why change description and add it directly to dpsub mode to contain
> full description with also port.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 10 ++++++----
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 10 ++++++----
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 12 +++++++-----
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 12 +++++++-----
>   4 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index b92dcb86e87e..88396d089f43 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -154,11 +154,13 @@
>   	phy-names = "dp-phy0";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 1>;
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
> -};
>   
> -&out_dp {
> -	dpsub_dp_out: endpoint {
> -		remote-endpoint = <&dpcon_in>;
> +	ports {
> +		out_dp: port@5 {
> +			dpsub_dp_out: endpoint {
> +				remote-endpoint = <&dpcon_in>;
> +			};
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index 99ad220d13d6..e041a962d89e 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -155,11 +155,13 @@
>   	phy-names = "dp-phy0";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 1>;
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
> -};
>   
> -&out_dp {
> -	dpsub_dp_out: endpoint {
> -		remote-endpoint = <&dpcon_in>;
> +	ports {
> +		out_dp: port@5 {
> +			dpsub_dp_out: endpoint {
> +				remote-endpoint = <&dpcon_in>;
> +			};
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index d7351a17d3e8..fbbebbea80cb 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -3,7 +3,7 @@
>    * dts file for KV260 revA Carrier Card
>    *
>    * (C) Copyright 2020 - 2022, Xilinx, Inc.
> - * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
>    *
>    * SD level shifter:
>    * "A" - A01 board un-modified (NXP)
> @@ -131,11 +131,13 @@
>   	phy-names = "dp-phy0", "dp-phy1";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
> -};
>   
> -&out_dp {
> -	dpsub_dp_out: endpoint {
> -		remote-endpoint = <&dpcon_in>;
> +	ports {
> +		out_dp: port@5 {
> +			dpsub_dp_out: endpoint {
> +				remote-endpoint = <&dpcon_in>;
> +			};
> +		};
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index a4ae37ebaccf..87f94f8ef9d8 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -3,7 +3,7 @@
>    * dts file for KV260 revA Carrier Card
>    *
>    * (C) Copyright 2020 - 2022, Xilinx, Inc.
> - * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -116,11 +116,13 @@
>   	phy-names = "dp-phy0", "dp-phy1";
>   	phys = <&psgtr 1 PHY_TYPE_DP 0 0>, <&psgtr 0 PHY_TYPE_DP 1 0>;
>   	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
> -};
>   
> -&out_dp {
> -	dpsub_dp_out: endpoint {
> -		remote-endpoint = <&dpcon_in>;
> +	ports {
> +		out_dp: port@5 {
> +			dpsub_dp_out: endpoint {
> +				remote-endpoint = <&dpcon_in>;
> +			};
> +		};
>   	};
>   };
>   

Applied.
M
