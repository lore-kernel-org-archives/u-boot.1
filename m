Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2259BC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B8EB8334F;
	Tue,  8 Jul 2025 15:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZfWjqoKk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9C583371; Tue,  8 Jul 2025 15:07:20 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B72F1830B4
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l2XI+25HKSpB0nlCPe4ntWFEtPepMRjRoDRJqua96dVYP9IeETDV/n/7osD6b+fAEenvMS8fts4Z9/Nst2i4016EiCs3FU9YXtlHpWbQzizBuoPBFyR7UxE5PCkeHkBWtwDVVxzzB1LnOcpePXfuWOVjO0m2xX8O1yT5+jeAyryBnTgzNg4L27S8aB7eS1RTCcl47Mw7gwighxcfaYkASqu6KY6fhVRnjEdkpjT/sklKUHTJ0XPKgqppG/xUlDrXWs1Np3ZU3ixu7dbClzPOWz+H5svQ3x1t3PVZ+Dqqm4tY6pHyQdLVSRWjR3yrQkMKnRn/W2QIeAXLdz7gsz2jCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFlk1QtRAQgqYWF2s6if3QVn+vnKZG8RnKqnwSxhi0g=;
 b=tgY9IpWSpHI3rjvYwn1Ywhf7FAzgJbF9RpXFkn7eHGbnhtHVtX9kHLA9v1a35woKZhqvxlp037fdv9b2Ipz/Yxqxdeplvp8v+cLkPjzTajIVDyYBHhk/alUaozbjZ2vQq+b1YaNkw0Y977AhGped5AfC8ZdZDunR9gH1jeTHnLB4ILW9f8Xp1+Sh/GeDrYtsLywKS55FsUjV4ZMybm0yZGdiWoZbbcdrJTHc3m7/PSLs4+LyMeDS7AfbN7WcLUAPWksLlNwaXlUKwqe3bWYa1bT/WA+TkfZC/B909WoccdJgGYkiVKiyqK9NaHLUcnm9SqNHpK6WpEtDkjKiL7eZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFlk1QtRAQgqYWF2s6if3QVn+vnKZG8RnKqnwSxhi0g=;
 b=ZfWjqoKkS0HcfHY46Dn+HZO+dGVZYymKGSPBtJ5yfE3xgAsyec+Vq4yKHVYYLHy14a2J+yrCKDczqsP6VVnMjgdp6AiJr+p/2xqMoi3CuD8zxvkjK8O9IVo/hzxpDH9brA1bmzT0Jb1GHKZLOnxOhSwGFwMgG0vI8l3c63FstMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 13:07:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:07:13 +0000
Message-ID: <98275d4d-0644-4fc8-9ff6-8d5b8622fd9f@amd.com>
Date: Tue, 8 Jul 2025 15:07:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: tudor.ambarus@linaro.org, j-humphreys@ti.com, marex@denx.de,
 jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com, p-mantena@ti.com,
 git@amd.com, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20250702065717.3871435-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20250702065717.3871435-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0068.namprd08.prod.outlook.com
 (2603:10b6:a03:117::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 59194a77-79d0-47fe-04d8-08ddbe205b3e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTljblVRSmk0ZmM5YjZOWmxpUmhoQTF5Qm4raThSb0JSN0k2TXNCaWcrVEI4?=
 =?utf-8?B?ZkdlNkgxdHZHUDBxR0M0aXFubmZvZEl2UC85WlRxamFrUWZxWXYreDR0cDB0?=
 =?utf-8?B?ODFRZUV4bnBoK0hQbHFXTDBGaHdnamdzYm40L29ud3hSU2xoK3R1SVhGZWtr?=
 =?utf-8?B?TlR0dDJZVFlWQXlQVFBuY2V5RjRhRmRBNFRBL0dBZjlMMk5ySlFucGZjN2Fo?=
 =?utf-8?B?UWp5NGNINFdwVnJVdi9SZ1pXM0xMQ2swTjNYR2ZUcGJzWmVmKzB6S1BYeWcz?=
 =?utf-8?B?aEU3S3dPakpSYzd2TUxrS3JNc1QwQ0NBUVlFbjIzTHBKTnlIcTZvSHJlODQv?=
 =?utf-8?B?d0ZlcENlMVlTSHJoeXprL1FPMzVRNVJnOFQ4bVgwd21kNW1iZFp4bEd2VUFH?=
 =?utf-8?B?S0hhOUtZSUlyVWpyYnlBcllxc3NsdHU3dm5aNkh2c0JHaE5ZMGswNDNSczBS?=
 =?utf-8?B?WWs0S2Q3aDFkVjNMQ0ZDK2JGV2ZLWFVDRlhQSk02Z3VjQlBOUVMyZGVxdHBQ?=
 =?utf-8?B?UUNlSktNQnM2SlJDd21SaGdEQWVPWDJUbDRqVDFpL25xVmVISzlxeWh4ajZj?=
 =?utf-8?B?SHVKa3B0U0R3T0d4UXZ5N1Q0WjhNRzRubHlVbzFTcE1UVU85aXpnRkJ5MEVa?=
 =?utf-8?B?K2ltQjlDRGk1WFhCSVRPcTZJS3JZRTUxMjVHeUxObFliSXBxQ1F5b050ek8z?=
 =?utf-8?B?MzcrQWNLWUNUQjR4YmZzUnJUR1VjdmQxYmV2MkdzOFV4ZWVkbTlDUXBRZ09a?=
 =?utf-8?B?cTdZNUF4eDFkdHRyRXVrSk43Um5SdU1FeGRtZ2IweHlTekt1UkIweVEzWS85?=
 =?utf-8?B?V1lyWmtCcjk5N2FZV2tOd0tXUEJSN0JWRzl5RWJoY0xhNDRXYkpWOW9yYncr?=
 =?utf-8?B?WGwxa0ptTEpwbjIwa1liOUtwcXo2THdReDdiRTZneWEzR0xkc0p4RGdEN2xN?=
 =?utf-8?B?bUlIN0hKRXErd2lLbU92SU16YzUyYlBIclp0Sld4a3M5WFBZK3hMZHoxemxh?=
 =?utf-8?B?RG9XZVA4NW9SbHVtbmJjR2U4Z2FhNzRSUFkzQWJ0YVRxamsrV1dhUEdPNWov?=
 =?utf-8?B?QjIwS1o1THErSmpkWm5CYXl4Y0tQUmtQa080N2pGWE1td0FvRlg1UDliR3lZ?=
 =?utf-8?B?c2FOdTl3VStQTkZPcEFJb0dGeExOakhyV1VTekk4WmZZaHpSUlh3N1BFL1hL?=
 =?utf-8?B?WkxOdmZtYXBrd2RhSTZPaXdubEJFT1lTcFRDeG9TTER5TkFxQ1RDQ3U5ODdQ?=
 =?utf-8?B?SW9wNzgzUy8zcWhsUlp2SEFKdU5hRlZ5TGFEY1YrWTN6SmxCS084dUxoSjZD?=
 =?utf-8?B?TU1QNHBGMEZOZEgzeVdKY1JsMjMvWlJDcEhQUlJvZVNLaXJsVzFON0Nucity?=
 =?utf-8?B?bnJxS2MvTmZJdjZETEcyb3V6aS9JZkcwa2tiT1dZcWhPMmZCeGdITXI5aUFJ?=
 =?utf-8?B?Q1J2VGE5V0IxMDlIK2lOTGJXNXJlczlEcnZZN2FuV2JNeTJWam5sUjFDVFpy?=
 =?utf-8?B?SUJoc3l3Q2Q3NFVsV1NHa0d1aWhyS2xXSjQrZ0FBcGxxa3QralJhRHJyQ2hV?=
 =?utf-8?B?WEZHT3FuT2JBelY5ekxsSytMWWtma21Ham52eVBxOWNVa0RycTIyTTZvSXEx?=
 =?utf-8?B?b1hPSzNOYjN1STA0U2IzdzF3b1EvZDNnRkprNTZFelpyNnhlTThRcHNTL1dN?=
 =?utf-8?B?NU9BOWxLQzJZRU5RVm9xSWlib01wQWcwN25JdURJR1Iyb1c3NzdaRmJxZmpk?=
 =?utf-8?B?VVp1RElsYkpmVjhyQzI3QWw0b2FmQzFtUzVUK3NwRGxiNFppZ3JmRW5KajJz?=
 =?utf-8?B?RW5EN3NlKzZ1bnBGTTFRT1RNWVd6RldQWW1BTkhrTC82dGRjQ0ZIdUdZNmRS?=
 =?utf-8?B?SzZyRG81UjFWUXQzR2Y1THFOOUl2amxmQWxmeEMrN0U0b3JybEY5MnNSUHdX?=
 =?utf-8?Q?HyuXZ+ZL7VU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdOajdrL2wrVEpLR0VmT0hpUFBFNkQ0STM0Y3p0MStSUWIyVExERGNleHB3?=
 =?utf-8?B?UWhBUHRQTEptZnNEQTk3NmVZRzJxYjZZSXIyWkdZdjlxcFUyeG51R0UxZ0NW?=
 =?utf-8?B?Y0dsMHRITWRYV2JCWjMyZnZESFdyN2hTUXVZNy9pNDY5aGhDbWxyQ2FVUkxh?=
 =?utf-8?B?K01ONjVxR3FqZXBwSzNiTnpaTWE5Q3FGUjFYM211bkdEUTEyUFlkdDlZYisw?=
 =?utf-8?B?N0ZpWkVQQnlzM1Z1WXhqVytIbjgrc1k0UGErTkNSbmdrVDg4MmpkR1h4Q2Ir?=
 =?utf-8?B?SVpKcmhFK2VoLzZGN2NlYU9BQktJd2k2TXZSWnRvM0tpMUN0UUQxNGNkVW9t?=
 =?utf-8?B?NkRRTXRoNUs1elVFTXRBQ0Y3RlFubjRkUmdnbTFXcytmN3o1VkpOWmtjNnQr?=
 =?utf-8?B?eFI0Tk9qUmphWnROcXdyWGpkbHBwVkhrZXJJYlgzcXFpMGRJTFhVakZ4dVlK?=
 =?utf-8?B?R2JYY3NWaUZsTU10bC96Q25RdFQ5L0dGUUZocWIrTjlBV3ljM1RaTEVuTElM?=
 =?utf-8?B?NXM4NDg0b3duc0w3NHhlTVArekpOc0RaMVIwaFhETzNFdzNvcmlTUWhKOW8z?=
 =?utf-8?B?YTlMb3ZuVVpsdk1IQTdIM0VQbTdhanljWC9oeVVBL1pFWVYwK1lPaklyNWxL?=
 =?utf-8?B?WEw5OWo3KzYzQlc0N1VsakV5UzFVQ3N1anFKT3hra3N2QVBHM1pYQ3gyRWM4?=
 =?utf-8?B?ZWtRUkZkbmdZdktJbVNRemtmWTRwUGR6RkYyOFNXb2NJT3hXclFWYkorcDRK?=
 =?utf-8?B?QldrT1IwdDFOc05VSitDVHZ2Rng1ME9zTDJJN2lTQlRaeXQ5OTZrY25zcVBz?=
 =?utf-8?B?eFBKR3hiRklqM01RaVo4M01ZS2JBdXk5YkpOa0YwMmpyMlVqeklrUXpEV1RL?=
 =?utf-8?B?aFVUa0NmM0hUeVNwdFk5TnM0aXhUaHdKTEh6L0VWb2dhR1lhQVJJUE9hRk52?=
 =?utf-8?B?WkQ1Y3lDdnM5NGpKOUZjWlcrd2VoQlBEbXUyNjVIc2dmV3Q2WVozVzF5dWFj?=
 =?utf-8?B?bHRNclZyZC9MWFRoNkJ2K0JseVE2SmcyNm90VmowWjNGSHdXNlBTVi85cE9y?=
 =?utf-8?B?SE9Pc2ludmNDNTNGWmxOcGlCNWRXV2huY3dPdVJNMWl1L1FyZWgxNHU4YWMr?=
 =?utf-8?B?REhLaVVOdkREdkhxMDM5SU9GMmdmeUJISitscFhlMzRhTHRCL3VkcXMxZ0Jn?=
 =?utf-8?B?RmhVN3dLTWdMWWpTczU4UGx2dXJNQmh6QVp2d0l3a2pMYXU4TFBqMXk3dG10?=
 =?utf-8?B?S3I5QmRCS1dvT0lpbVhGRkk0anhYWXVtU2ljM0cwS3VUUDBHa3dxM0xYV1lK?=
 =?utf-8?B?U1BENDkxNG9kcTAxQ0h0Z1lyNEl3SDI2bUVNL3ZhRWE0bituM1dIMGwveUwv?=
 =?utf-8?B?Mk52SjgwR0tPYU9sTDhGOFlZQ290d0dzRCtuYk9jbEtjM2NTaldrRU93Q3dz?=
 =?utf-8?B?ay9zL3l4MUsyTkg3VU9vQ0NmTUh3c1k3NXVydlNwdWdETS9LSndoQk02dEFh?=
 =?utf-8?B?S3luMEVsWW1sajB5SnlmL3c3czVMblA2NzRzWGRuUmRIQSt0WU5ET0NoelJT?=
 =?utf-8?B?OW1LOE1jYitRWHZHK2tYUHhRVjJiaFhjQ2YzK3lycHNyZmNObEkxLzFDU3d1?=
 =?utf-8?B?a3YyTW9nVEtSZXI5SWRxWlJlY0ltMy9FdXlwTnEySzczL3JrQWJTV0tnZVpT?=
 =?utf-8?B?enYzVk15bHptU3JkUHFDc0pSMHA1OTcyME0ydDlxdzVkQnRpbXMwRUFnczBX?=
 =?utf-8?B?V0Z3aDdDbVlCRGptS2NMdFN0a2MvNEtWOThDN1A5M3oyRzZBUFA2NU1laDFR?=
 =?utf-8?B?OW5ISGkxWGpGV1F6RFlOMDVZaWwzbG52aUd1NXI5dXFkVmlkekxTbFQ0bUx5?=
 =?utf-8?B?eGpFbDNJNHFtOGtGMThoaGNhNkxwMm5XYUlESVAyc1BtRFdYOWs3Y29EYUZk?=
 =?utf-8?B?WlNHekp6L1J0NjNHT0thZHBqajVTQjFwd0owRkFPdTRONTZ6RmZUdUhzNmU4?=
 =?utf-8?B?eUJHMDZvYnZEa3RiZHIycEV0Uk1qTWU5YlRJWXkvYVYva0lSM2RRQW44d1lX?=
 =?utf-8?B?OHk1Yy80RmxLNnJ3Vkt3azF3dUo0UWhtME5YZGhmanhJNkJqTmc1Rk9iS2Mx?=
 =?utf-8?Q?c2hhKRSsL6Uthbzek7EZMLW7f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59194a77-79d0-47fe-04d8-08ddbe205b3e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:07:13.7273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R2EbOV341lEzZPPln1qToD4uOS1L+eg8G9pWm4PIQepeAo/rUL3zVDILIGdnmum4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562
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



On 7/2/25 08:57, Venkatesh Yadav Abbarapu wrote:
> tshsl_ns is the clock delay for chip select deassert. This is the delay in
> master reference clocks for the length that the master mode chip select
> outputs are de-asserted between transactions.
> 
> The minimum delay is always SCLK period to ensure the chip select is never
> re-asserted within one SCLK period.
> 
> That is why tshsl_ns delay should be at least one sclk_ns value. If it is
> less than sclk_ns, set it equal to sclk_ns.
> 
> Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/cadence_qspi_apb.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index 65fb2d8f9fb..4696c09f754 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -303,6 +303,10 @@ void cadence_qspi_apb_delay(void *reg_base,
>   		tshsl_ns -= sclk_ns + ref_clk_ns;
>   	if (tchsh_ns >= sclk_ns + 3 * ref_clk_ns)
>   		tchsh_ns -= sclk_ns + 3 * ref_clk_ns;
> +
> +	if (tshsl_ns < sclk_ns)
> +		tshsl_ns = sclk_ns;
> +
>   	tshsl = DIV_ROUND_UP(tshsl_ns, ref_clk_ns);
>   	tchsh = DIV_ROUND_UP(tchsh_ns, ref_clk_ns);
>   	tslch = DIV_ROUND_UP(tslch_ns, ref_clk_ns);

Applied.
M
