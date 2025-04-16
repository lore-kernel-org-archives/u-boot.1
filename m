Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A18C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:37:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E13582E38;
	Wed, 16 Apr 2025 13:37:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xSxYo9YL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5183B82E3F; Wed, 16 Apr 2025 13:37:29 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2304082C96
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJnr+NcfuyC6YpCF8N2Z4zuOfOtTuw59oxRLnqgzutvsMgNHbmjZn7+qlL+QBmZxxK8H9KU3XZ0xR2JFFsdV/JGFRWXwd5QD09eqb9hwo3avpLMgPO0F88hdOFQyeMogQNriQqTyUWaBojyA6WA8r/RxQFfVDtECId9zy2i2O0ZpdbUlETml8gwGWEa+Gi2GeIBNHSdHYroGiCBY4hdef+Kaw1v+dDbLv/Al2CTstoWjYw6h6pRyHCvuCKGMkTna8YUwqwPUZ0PnSh6da4pYLHOWDcvwzBMewYvqdaDDCyaEAU/Elk/uXSmoaTdit4AEW4AlZnj5zQZswQ5zWOo/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzR2uMzPMr/gE0S53EJDtv3AoKNyM/th9vzaziCeg1Q=;
 b=NVvhHfN+3udDJgfDhXyQqI/9FWWxyFKGrKec1czgyP/1muoO/G2yJMcNKBG9Pq2tjqb484Krc6nXfaQxj2Bn5Y+srmJZcsdCVwqkgNTax1SZFDXvSk6NY/65GGoJGloPXfplajeXM69iU9eLe7rWrTB0scfAELxjMeD3m9V9bfi2BL6yHDR1ffq9wTB0KSRildR64CD0Dz2RSHpnzMlPVxpEt2mRQUMznsv+eAT16tP9MEGs3QF1TTq6+kMuQ1rt9tynuVESYLZNUzZvb2cMxN4ByMVXcbf2fskedKaUXL3Ij8E/2wMMFrsSlY+8+XDg0i3B6sRocmLOWDEdNzEqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzR2uMzPMr/gE0S53EJDtv3AoKNyM/th9vzaziCeg1Q=;
 b=xSxYo9YLG6TB5sItN8MYBXUnMp2HMHtSB1aJkQUt9l9ff/58EXPV//bZJIKYYlnS+SzHUalv70Gqve0nW4ZoP78eGzXs3HQKLKMxD+JdzoIQ94sebHccdiX5EjSdea/mtTzyTZo/a1eoB2/d7e8VYiJasx8T3nQRT1ADALVeE2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.28; Wed, 16 Apr
 2025 11:37:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 11:37:24 +0000
Message-ID: <8262e4d8-d8c0-4d7b-b1f2-f5f04d7d33f6@amd.com>
Date: Wed, 16 Apr 2025 13:37:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: versal2: Enable boot from UFS and USB
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <cover.1744273853.git.michal.simek@amd.com>
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
In-Reply-To: <cover.1744273853.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0269.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5049f4-1190-4719-9eb2-08dd7cdb0ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emNGZGtWSVlmaThtclpuUnZGdjU1U29ENllVTlFrK3FOZ2tncG1zeXpmUHBq?=
 =?utf-8?B?cVUrSGJxUlB1Wk51cFlodS9VWHg5SEFiSTI4NUE1RVE0VXRtdldTSFJSMUJX?=
 =?utf-8?B?M1RKQ2RaMkEyQjhUZnEwQThYRU5WSHJCU2QzaGdDbk5NT3dLWm1rSG1iaWox?=
 =?utf-8?B?L25VWFNQSWx2NUZoaEZMUTlXOGxSQzdzekd1cjZaeVYvT0g5RHNtcTl0dnB0?=
 =?utf-8?B?alp6UnVKM3NQWEtJMVk1Q1gyUVhwRDhWUWdSaFBBd0F2NEE4VGwvR1RDV2Ni?=
 =?utf-8?B?NjA5NmFwSkFpQ2xpVEUrZ3FQSkYyWW5SSit5dWkwc2d5c2lLMHRpZjlBSFcw?=
 =?utf-8?B?TExTblFFUklZbXdYOVRYZElSRURROWlSOGRLM2FPOHVTMXRPckcxdmFIRHdL?=
 =?utf-8?B?cjRuM3BLZjBMMnhoUHFyY2FYMHhQcm56a1NoblZKVUF2dDFmMC9taWNjdHFK?=
 =?utf-8?B?ekdGaXNpMnJXdzVndHNsTVNEcUR1dGk0cFJKNXBsK2JObEE1SmJqMDh3OURB?=
 =?utf-8?B?YnFCVmQzM3REOWZQR09idDJVL0dDQ2RzdU42Rko4LzA0QVNTdmpUbVRPaEJV?=
 =?utf-8?B?RjlXbUdWTGgxcDB4akd0Zzg5VGNjOUNUVWpVYTZCeGN5OElmcHNaOSsvdjNv?=
 =?utf-8?B?Z1FZZzJ3UWVNbUFSek9IZld3Mzl2WTV3UG1HTFFQTUU0MXRlYlpaUXdGZVhV?=
 =?utf-8?B?QlA0eHhMYjRGdjdkQlZHc1pDUGpMS0t2aU5odnllWHhEeVlpTjN6Y0lRVUYy?=
 =?utf-8?B?WEcwU203TExTdTR6VWJtSHhvd0RnQnNwUUtZeXZOTXgzRlliYWUwdnNuKzQ2?=
 =?utf-8?B?VjFCVkJpMURWc1BsSHd5dEU5ZUg3STBWbkxJMW5RYzZWd2cwZmRtSUNJZVBG?=
 =?utf-8?B?bXFmZU1ZTmRYK3F5VC9ncXp0ZDAzYXd4bHdldVRja1M4ZktOVzlOM3gyWGVK?=
 =?utf-8?B?WmtIb0w3aU9VbjFOYWlKU2w1OGZKbmxEQWxUQzBiZWJqL0p6L3pUa3BZNzUy?=
 =?utf-8?B?bzQzaUFQVjl6M3dzeityZXp0Y3A2cTV3WTA2VnNZSVVHeE9GMXlDY1BJVk8x?=
 =?utf-8?B?eUxwSUpuZnBxMEkybyszTlp0YmN6RmluNm5LU1I3MVlMSGlpQnlDdFNlelJp?=
 =?utf-8?B?UWpKWjY1YWw0QmxjaGE0aGdBenU2Z09wV1ZsRklsdE5VdHVyZXUzNHVaaGFl?=
 =?utf-8?B?L3FHdnExeHAyMFlmczFDYzR3QUo2U1k5aGorYy9sQ2hRMFBueG15ZG9wblVm?=
 =?utf-8?B?b0IxbHI5MUJ6bGY2VWQ3VDdIVURSVUxibWhHOFN0ck5FNEE0U3pzb2t5ODVo?=
 =?utf-8?B?cS9TVVhEM2ZjUEphMWFkOUpjaXRDaERtN2hXNno5UzA4WE9DaEZzVC94M21z?=
 =?utf-8?B?T0QzWnpVdFA0YzFhMll2RUZ6RVR3UVpmeVFUZG13ei9nWnRyZnV5TUtiY3lJ?=
 =?utf-8?B?Z0RBeDVrNllMTXZSRFdJcHlEaFVJZ3FaTjRQZlNhdno0Y2ZITzNvQ1Z5bHNR?=
 =?utf-8?B?aHhZeC9lK2hpZHc3WlNCTWJ4UEl3TGhqL01MZk9jYThKeVJQSWRoc3ZMRGFC?=
 =?utf-8?B?Q0RWMWxyc3FDVWtxb2NvdmpCd2VqSGQyKzF3TEhkY2pzUXU3Vk9BaE9FekZD?=
 =?utf-8?B?Mm84SDF4QUdWY3NDOGxFWFhNVWlvYmViZmlIZ0Q3S2xWSFViS2FiYVk4VFVj?=
 =?utf-8?B?dUdQMTJhVzBWWXBDZVBtZDdXY3Vrd1huSW9WenVaeEpmenlHRDZlQ00xZHBN?=
 =?utf-8?B?UFhKWFZJQVB5eWhpZ2lvM2Y0RDdkNktDZG92MU9jMEtodlhCdk84eGJpTnZO?=
 =?utf-8?B?amd6R09sdjZOdmNBZ1hGN0VNN2VqWnNhdk16bHN3bnhqaXdJVlRBOEpMa1VG?=
 =?utf-8?B?SnNIZGg0OGZEWDc3SDFRTXdMd21wdk8xL2tsdmE2WUtkUitkbTdVYWpFcUQw?=
 =?utf-8?Q?krefUlVZ56o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnZVZVpSRmpxUkRZNkppSGVKczQ0bzhWOVZ3NjFkWTMzNk91UWthQURIVjBI?=
 =?utf-8?B?a05MZ0pTVkoyYThVbXN3QUJDTjVIbVgzN1BrRUMrdnA3dkJtZW9KVXJWMzR0?=
 =?utf-8?B?RnpuOFlBd2JvWndKY1A5RXgxeTdabVlkeEVDVWFUekg1ZSszaGk1bmJtV3Ny?=
 =?utf-8?B?Zldyb0VGM1NMUUJVVUJlLzYrK0U2cVdXd2ZMT21jRmV0aFNqRUY4eVNzTlpl?=
 =?utf-8?B?WHBZbTRNSmorRUdhNnc5RGdIRlp6SjQ0N0dLN3RwWmVrQmdSOUgzVGxwQTl5?=
 =?utf-8?B?UE5GSWVYUUlWY3JHZ2R0WXpEQ0RtNldndGlOS3ZYNTNEZ2ZYZWVBZ3Vtd2RW?=
 =?utf-8?B?YUJXVlNQSnhoblNJMW5LQnBsYkM0alc1bW44WGZiMmdmNmxOS2FRdGpKNW9v?=
 =?utf-8?B?Wm5Sem5HMng3a1UwQ0pjT0ZQWlBmMGhnb0ZqZmJkRGR3SXRVaDFrUUVCaCty?=
 =?utf-8?B?Skh2OHZMVmY1SFNCM05ENkk1cU11NmlkK2FLYSt0Zng4eUFKZjBlVjE3QWpq?=
 =?utf-8?B?V21NU2tsT0J2N1Y5VmJBT2czS1Z0ejdRRWlZaU13T2gvTWJzUUEvUW1aaTJJ?=
 =?utf-8?B?THRYTDZ1YzdlU0VXMERXSnI0K0tGYnN1cTNCelhqWGw4RW9kM2dSQVBobzQ1?=
 =?utf-8?B?L1BsYlM3ZFR3S3RXNmk1MGs2ajh5ajlSUitkbTArSnozbWRvS0pjNXZ3eUo5?=
 =?utf-8?B?NnZoSGdpMnM5ejVQei9pR0tTcDVtQ0JLTm5weEh1YWZDVFpsSnZ3YlNMNEFW?=
 =?utf-8?B?VnRNSkg3OGkvbDY4bnBRMzlydThleVcxZnRDWC9Gd1ZxZmF1cy80S0lrV0s4?=
 =?utf-8?B?OTVrd1FEaTVvSkd6MjBPWG9GMFgxaFZ2d1FKWk4vb1czemhNOEoxM0lhRDg3?=
 =?utf-8?B?LzJmZ2xtQlR0azZSWk43ZzNPaTlTMjRJNXE3WTJUQ0F2cWVWL21nWUZzdEZ2?=
 =?utf-8?B?RTU2KzhZWUdsWUY3ZHJOMTlMQ2o2bWs5ZWtvZWIvUGhsTVVqbnQrWGVQcElD?=
 =?utf-8?B?KzNjSDNpWnZWMzd5MHRBa3lTeXFDektJMFpSMVlscmo5ck1tM2J6bnVyMHpy?=
 =?utf-8?B?UTdSS3F3eXJjVFJXOWxiWCtMdHpCS1ZMRzFGZE53MWlWVSt3SzN5cGo4TmY1?=
 =?utf-8?B?UGNuNjJ4SDNNYm92TlA1NG5EUzVobXFrN0x2cWx2T3BwbTdMaUluMGs3b0Ur?=
 =?utf-8?B?NlQ2alo1MzB1V2xZRS9iRXJVQWozcmlLTW16cmp0K25rRjcydjVxVE5iRVEw?=
 =?utf-8?B?OWJmMTYyTy85YnFVeTBmY1dGWUtvUGN5R0wyaDlpTVVUamhkanJIVk4vZVlQ?=
 =?utf-8?B?ekY0UFEweFQvcWlEY2FmeUZKSlBHTUVneVhFbjg0VUYvMGFTcWppcThHUWFM?=
 =?utf-8?B?NUU3RXV6aUZvamZ4aWxLUHhwUFJiWTlBVUkxVmRtN3Bkd1VWTWI4ZFdXY3Mv?=
 =?utf-8?B?TzVSTUpYY0ZVQ1hicWcrNUVwVXJabnZXNDltTVVLeFQyWXN5UjlYL1pzM1ND?=
 =?utf-8?B?YnRSZk04bGw5cmw2Q3BmOG9KU1lmV2czVGVKRG1TbmRRY0NxVEp2eXFkRDdm?=
 =?utf-8?B?Z1QzRWwzSzZBekYwQlhVTlJEbm1qMXFNS1JpVnVUbTVTd29EcGhYM29xN0Rr?=
 =?utf-8?B?N3VZMm9OblF2dE1xc0lEdjRDWjh1dzB0b3pyeFVvU1YxSXlIZ2F3UVd4L2Ji?=
 =?utf-8?B?VTFqRGNkYkFQaEhEaWp3aWdBeXV5Y21NQmtFMHBOYmd6UHhLWUZucFJkOG5M?=
 =?utf-8?B?NENlMEVydjhtMVJZMmNMNyswalhyMHh1OUVtOVMreDNTV3dHcHlpUi93WGlI?=
 =?utf-8?B?aXJHMzlTTWF1ZkpIMHYxaTV5ZTYzalgyck1pQldmR3pTTXprQkthbnBtTmQ0?=
 =?utf-8?B?eW9yNHB6ZHkrVEhtaWgyUkZnNWJ4RkRzaVRYRVI5d2FYVXZEdlNseEsyb0Zl?=
 =?utf-8?B?bUpaTHZDVDBxa3d6OUpqV254WVN6U2EvcEErZXJ3VWpSOTdnQkZlb0Q1ZXFh?=
 =?utf-8?B?NGtPeEp3Ym9ycEdnTVFjdnF0YVZ5am1KOEk3Q1I1WldMNUtRTTNXWnJsS3k2?=
 =?utf-8?B?cG5rUjNCYlIrZXpFcDc5MTJ6azA4VGFiRHRacFU0bVh0V2FZcElwQUNrK2dq?=
 =?utf-8?Q?NKeBqV4BHNJewnwea2jyRc7sX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5049f4-1190-4719-9eb2-08dd7cdb0ef3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:37:24.9512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1onWYYUF8Q16je3OaKh3ZPMqOY7UPgrAxVPw7KnVJDyZS/gPDIe9lHMlU3C7ih1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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



On 4/10/25 10:30, Michal Simek wrote:
> Hi,
> 
> these two patches are wiring support for USB and UFS. It is still done via
> distro boot because we didn't switch our platforms to standard boot yet.
> But investigation is planned already. To bridge the gap between wire it via
> already available distro boot.
> 
> Thanks,
> Michal
> 
> 
> Venkatesh Yadav Abbarapu (2):
>    arm64: versal2: Add ufs distro boot command
>    arm64: versal2: Add usb distro boot command
> 
>   include/configs/amd_versal2.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 

Applied.
M
