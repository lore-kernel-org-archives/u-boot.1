Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498C4C9EC7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 12:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA57836D3;
	Mon, 12 Jan 2026 13:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uZvg5xOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E270838A5; Mon, 12 Jan 2026 13:06:45 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E4080FA1
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 13:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7XySsaRVU6QLfiT+Vfwfq8OVubGqXXwEoH8piBSVxQxMrt2cm3uZDKF3S5AhoJ2UlCD9Mjwd+9K4Fm/xQpq5aZO0llM5DPVDTPhGzxjxnaF5Z064GPUch6v7GRcY6IR57aO/LfWLOqLAh/G5ZBJDloDmFofMooMSz9fBoV2rgs2NIEeZ2e//kK5y23f5uQzT8GcY2PwkqBnUQYE8giqmT8waKQ3X8cs5xpcgO0LKXurh7ImwFaIIf+P9lv5gB2IAVb+G7qJg3hEJOOqmV0YdH60leX9XSxo9wp4Rtn48OabYDAtTTya9LAVHQrc2wVe0i7iIWhGZ0/mLC5hG1rxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KlVH6nVxC85sJV68IsyWVEU2krXkrAgIj+qD4FDF8Y=;
 b=LLWmEn9CGU4018XtoEZ+ILINft1gEPc2DOwlBdTX+O/Kpbh9tP+J8W0ZK7/2Zx49GncVpHvCyB5LEvMXVZuwvPQbxAp2pwY0IRHgrluPKVZJqw8mpY0o1hqtHXywIBZshgDNxMeXVbiOgAFm1LoRqSZoGN3OFTdca5N1O2XFfEVq3VlUz7cL3buVdIMvjRT+t0wdBL8e7aG2gWnTNNgp0y9X/W4lBPpET6wMM/QdUH8c9JBRLie7AwR/UNAzZsr2fcUomBhBYoQd634Y1Xz3GiYjRhC2pHyeGUeajbsAMbSZmRBKlBKU8Si37r6mc4JCHcAylqVdwwQbjYtn92t2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KlVH6nVxC85sJV68IsyWVEU2krXkrAgIj+qD4FDF8Y=;
 b=uZvg5xOMsBoEx7sPn+pyP1qXSgqhiff4GxWwiz0Y9nBuUG6gXxxymEegvna6qRdrJ/6Dms3n1szTtMITp4zfvHNmUa6VaZ1+RTgi0vOdxsIMYCRID/DUcPRPnxSFDTz5clKjIDN5NZXTc6jwm+0r+Ze3GBGH0EwwHbLx80FNurw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 12:06:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 12:06:40 +0000
Message-ID: <fe7ebd31-d7a5-4698-834f-687aa3183e8b@amd.com>
Date: Mon, 12 Jan 2026 13:06:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] phy: zynqmp: Port several patches from Linux
To: Sean Anderson <sean.anderson@linux.dev>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Frantisek Bohacek <rutherther@ditigal.xyz>
References: <20260106215501.727524-1-sean.anderson@linux.dev>
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
In-Reply-To: <20260106215501.727524-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: c04241b9-9af8-4711-2d11-08de51d30b0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0wxQXRTZ3B5eXd6VFBDelByZngrTGlnV3Rpek5EbGJ3cW0yY3hteW1OTnNn?=
 =?utf-8?B?SmM0WlBmS1RXMVBtL1I3U2dxekFGK2ovalRHUnBpNmdKcUl5aVZNM1h1SEk2?=
 =?utf-8?B?aVYxcUl6V2pRKzZOQ0xqRjczNE9GVW1UYUxQK2RnbzJMaWhkQ1lKZW11SDhw?=
 =?utf-8?B?S0g4UEViN2RkYktTOXF5VkQybE9iQUJRdExiMjMzaVZFc3Y3U3JydFFOb1lE?=
 =?utf-8?B?dWYwdTF0a0NxSEwzNkNVTEkyWFJRWktzRUdYbUlzcWRZL2IreGNjeWc2c0RG?=
 =?utf-8?B?b1lsTitIWFpVVWdOamQ4Z0ZwQ2M5OWFkN3hNcUxRbnZENWdYcUluSUF2S0Y2?=
 =?utf-8?B?b1YyT1BXcXFmOENLbDFJUmRYems5dGdLNzduV1Z2dW5sODN0dDhlUmVDM1Rl?=
 =?utf-8?B?UWI4bkhlVDcwTytrTk1VeWNVQmNtbW9MSnZya0d6QnMvVlMvanhHNmlReEg1?=
 =?utf-8?B?OXdLZmdCRlJtWFhNZngxQUdDTEgrUFR3N2JocFRtMUtCUGpSS1Q2cllWN2Rq?=
 =?utf-8?B?ZjBmOHNtc1J2RVZsa2tKalZRKzNyaHYxeVlmSkw5cCtQbHNmSlJWc3ZnR2xQ?=
 =?utf-8?B?VEVWVThuTHR5ZkVwTVhaK0R6UHJJeWVZaVZtbzJIbVV5bDN0Y2dhS3F2Z0xT?=
 =?utf-8?B?K2h3bnEzbjlRaENVTnhNM3k4STgwK01TU01ESG1HVk1KVTgySzZFSWhmZ0oz?=
 =?utf-8?B?NnlvK2JzVE5JckZrbFhZR3dMb28xZVRLVVF5NDRKcy85T3EvQXNsMVpCYWpk?=
 =?utf-8?B?MDExb0wzWWNodTdDMno5WXFBNno2ZkVuZVdqU2I1UTQ2a2c3OFM0U05oRkRt?=
 =?utf-8?B?QXRkTStQVGFHelBoWXN1UkhZWUQ4cDBNU1Rad3NncUpFU292RXJyRlRUOWtD?=
 =?utf-8?B?d2Z1aGppcm91OE14dXROeVdGcHd0QlpremZpN0kzdmkvdWdpcVdSc0x6R3Nx?=
 =?utf-8?B?UXBFbEVXK1VuUWtsWVQrS21hVWNzOHl0Qk9EdUdaR1U2Z0dhenR0ZUNvYTJj?=
 =?utf-8?B?WlA0K01wWHl0Sm9HTFk0QnlvaEgvdlEzWE92RjRHc1I5WUhWeXJSR1NYQ1BS?=
 =?utf-8?B?T3d0QkpXcUUvZS9YQ0JSSURKdDNjVTE1ZHFadHlCb2FKdSs0RFIrWkEwZ0Nk?=
 =?utf-8?B?UTJGMXRKcStRWVdmMjdzVGtkY2NrbmE3MVJZM2NRZ3R3MnBRQjY5NlIzUHFN?=
 =?utf-8?B?cXFxcFhyNEZBd21LNkxUNUFERE5XNzUwMXc4aEhkZ3RrOUJadWNzV2ErZkxk?=
 =?utf-8?B?ajlDd3NKbk1NK3JiMTVSenQ5QmR6WEJxOVV5dHdOSzZPWkhNMS8xN1ZGZkJr?=
 =?utf-8?B?QUo4c0hiSzUrM2NaeVgzaXBiMStlVmNScnovWDdLUjkwRStzaGJxdTRiYlVj?=
 =?utf-8?B?QU5URnJCelY3YmNTd2dNVldDcGF5Wjh3SWVHNHFNRUIwK0dVSmpmVEc4U1BI?=
 =?utf-8?B?TkEvalhSU1Erak5LR2swSmRNNlNHdlFMRkRpQ3VUR1dycDQwOHlYVkRieWI5?=
 =?utf-8?B?N3hFSnR3NXR6MEZNYnE2aklOOFROWVFkZ1V3K3ZtV0doZ01wY1Y5eFA0Q1JJ?=
 =?utf-8?B?L1dxMkt2WjQyWWxlV2NTWUwwK3NydU9RcHI3ZFI0bDdyc0doa3J2cGtqbnBs?=
 =?utf-8?B?Ym1OaGhIQUFOdkZIMmtJK1htTHVRS1VlOFFkSkRNeUxQVlAvV2ptU3RPaUV3?=
 =?utf-8?B?SHB2Z0VkWHRXdnE3ak54WXVYZmxKMUk0RkhQSDFobStLbm5sVXlRMEszL0hC?=
 =?utf-8?B?LzExMVRHQ1hoSjMrSzZsT1dsMURHY05LMzQwVXJhTGdSRnl0ajBPcloyTmR2?=
 =?utf-8?B?NHB2Q0FWOEZiQWVyaGtWRkpGSGRhYjR3K2lYTmRPbVZwS0k1bUg0U0orSlAv?=
 =?utf-8?B?aEpCeXo4enRNbmdGNTdXNVI3TnNFdmM0MnFNSVZTTDZ0MlNKLzJQQUNPRDNM?=
 =?utf-8?Q?Ty56tN7iwRloJsMx2ANWl36qzuDVNnsV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEwzWG9iUDA4cU1NeERsaEUyRUpoK3RTSElueUxTcTlQM1hvaTIrN0hSZFpH?=
 =?utf-8?B?dlFabUNCUUxNOWFmek1lRVBuN2JhbjlJVjRZR25Gc2M4VEJOU2tkcFJlNXNr?=
 =?utf-8?B?TTJBNC9Xb1Zyc0grUHhYZ1lYQkxqMnNKZ2l3eHc3TzUxRm40V2pQVGNqNENJ?=
 =?utf-8?B?MGg0WWZabFRwWmJsWlkydCtlOUVSMkl1RXo0YWtOVHZUald6dDk2OUNZZ1hP?=
 =?utf-8?B?Lys3TlJTZGZXWnNnM1c4R3J2OHFJVE9GS2lJL29MNWFPWWhuQjA0ZUxoK2xP?=
 =?utf-8?B?SG5WaXlNUy85OUwwZlJseFJFd3NoeFJXVkxPZURjVWZNd0VWcW9yN3pkRFA2?=
 =?utf-8?B?Q0x1N0J2empEV21BZDlZMTR2aXpEa1ZVM09HdS80Q3g4SjU4Q0d3aG5ONzlr?=
 =?utf-8?B?OFBDUmNtOE1HTTJ0YjhyVWh4WUdVbmIwUW5yNTdINnJYTmVrTnlzMTMyWXo0?=
 =?utf-8?B?SDM1WWxmeGpKWnlGWEIvcWlnelAwSWx0K0ZnZCtUckpLcDhsTWNGaUlNOUZ6?=
 =?utf-8?B?S3hRQi8vZTQ4S0Z1Qm91TmtHU3RXdG5GRUNSS0gwWE8zT0taZzA0a3ZzRU9w?=
 =?utf-8?B?aFRMUnJldjd4cGRteEREVmFXUTF5bG9ZZ0o4Ry9qd0NQV3FpSVE4dWlIbkMw?=
 =?utf-8?B?NDI5NDhZN3UyYlIvcjUwU2tuREdWN3NOczEvQXJTME0vT2pCTUZUN1M1dGF2?=
 =?utf-8?B?YWdlSDFWL1ZuNzlRZzRaUXdsOWJ0Q05PTmFpMVFnYmdOSVhSTUVtcWFnVEdB?=
 =?utf-8?B?S2dqSVRtRGR5MjJBMk5wTUorUE9qeEI3STRaSUdCbjQ3clhXWmtZNkVqVG8v?=
 =?utf-8?B?aE5ocWgwNEJiSERVdUE1a3RWZDZqT1BXeEQ2eWNEU2FDMTZTSDNNNFg4cVVF?=
 =?utf-8?B?aEdkVHpJQ3BldXhPS3ZPdXc4Tk4rNUVXYnNHRFF2ZW1TaTJVTGpRcVUzSzR6?=
 =?utf-8?B?WFloK1FpK0dCVTY0RGdRbnQ2cm12ZlZkQm9IUnhQYlpmdU5YY0ErU2VtMWlG?=
 =?utf-8?B?bWtBL3lhRlRrZlo0NG9tWDFVQUgrZWtZdVA0RVR1SlMwK1dYRHowM3FqNmFu?=
 =?utf-8?B?dGYxSVdsOFZJQXZGai9KWCt5bVZHS1JkTXVUNWdnakpsQXp0TzlNYUpsQWVD?=
 =?utf-8?B?eVRsakJIRncwZXRmOGJkenBzTmhqUWt0SnJZL1ptZVJ0OUVqSll5OHlCRVUz?=
 =?utf-8?B?ekUvM2VGVEF4RnVjOHBIZnduMU9LZVh2dzNlbFFRTDQzYVVSWFVqMkZHNXd3?=
 =?utf-8?B?QndVVGIrRWxEanozLy9UaGtWOWFWVHZmejFjYk5EMXlKd3NEYUora1VoY2FK?=
 =?utf-8?B?OVpEZEYyY1NaempOYTB0MmZSR1lFMll3aW13dkdZeDgwajZibXJveng0Zm5N?=
 =?utf-8?B?RmtLeGlDdXlWL2piSktMMDhpZlRsT1BmNGpqLzhFenJTcFpUSXh4cVRNWWZn?=
 =?utf-8?B?K3JzVVFZbTNnaDVLa05ZVmtMYmYrSUo2cFpnclQ0ZHF0Umw4ZE5nMmNHVG9w?=
 =?utf-8?B?TVNnaGpaa1Jkc1N2bXZ2U09ORFBkTU94L1BocEl2dVFUdlAwWXJ1RmMrWVlw?=
 =?utf-8?B?ZmFWRlRuWmVrVTlOclZDWkJKbzIxMGpjUzg3cVNwclVqWXYrNmRmd3pnekZq?=
 =?utf-8?B?dnlPUEphVjVwQmo5L1FXNnNTY0tOU2tjMzVKVWkrL3Y0YmxmYVgrcjVnNXN6?=
 =?utf-8?B?WWJIeDhHTW01TmFXbGtyNEJxOUJYaHlEMjhyWE9iWVZiVHZzUVdjTjdabGZ3?=
 =?utf-8?B?bjJWdHAvUXBGeWJ6ZHhaK2NVZnRrVFMrV3VzdUFRWHpJdlE1R2o4NkJ2NUFt?=
 =?utf-8?B?L096NVh4a2I4ckhzbkxZbEhjZWQ4VkpvcjJacXN4MzkvVFlOekZSSXhHQ0k0?=
 =?utf-8?B?MXdPSDRyc3VvUklRcE90aDU1TUJNMjVDYWVnUEVqOE5UZ3ZDejdrSExnbWF1?=
 =?utf-8?B?Yy83VUl2ejZ5aVU2VmNiK0hvZW9BMytaQXc0YVhVdVNHWGNSM1BpUy8xa1VR?=
 =?utf-8?B?NW9oRWovVnU3MUYvMUZuSjRTUVc4UkhrcnRQUk5acXYxaTBjNlRMMWRPc2Zv?=
 =?utf-8?B?WG5YaFk4QzcvWnZKOTk0amZ1L1ppb1J6VDVJQ0cxSXBSOFVEM3BZS0hQWHd1?=
 =?utf-8?B?VUl2S0JVbWQ0Y3luM0gvNFdRc0VHc1RJcUNLM2hlUTBROUwyTi9zK1lvYzkw?=
 =?utf-8?B?cE0zelZTbHJ4RVk2bittYkNtRytsTWFreEl3dGhiYmc1RC8yR2htN1B1ZVZN?=
 =?utf-8?B?T1F3UHZHamNIeXRoa0VYRWVhWjlYK3JqWTdPUmlNbThCS3k4dVNZM0E3OHJE?=
 =?utf-8?B?RTNqV2Z1eVlSNkExcEZ3a1E5RTdhZWdkdHhyVjNpN29UN0FNL2RIdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04241b9-9af8-4711-2d11-08de51d30b0a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 12:06:40.1040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ux+ZVIGCLE5G+ViT21j9eS1ScukX8ICoAmNa7bqXsgLbHsZ8PjR8Kf6ZF0i1PnZl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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



On 1/6/26 22:54, Sean Anderson wrote:
> This series ports several patches/fixes from the Linux driver. In
> general, I have left the commit message as-is, only added . The
> exception is patch 2, where I have removed the original fixes tag and
> added one appropriate to U-Boot.
> 
> 
> Sean Anderson (4):
>    phy: zynqmp: Allow variation in refclk rate
>    phy: zynqmp: Enable reference clock correctly
>    phy: zynqmp: Store instance instead of type
>    phy: zynqmp: Only wait for PLL lock "primary" instances
> 
>   drivers/phy/phy-zynqmp.c | 178 ++++++++++++++-------------------------
>   1 file changed, 65 insertions(+), 113 deletions(-)
> 

Applied. But I have removed duplicated SOB lines.

Thanks,
Michal
