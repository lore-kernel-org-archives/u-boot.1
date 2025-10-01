Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237BDCCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 14:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 873F481D6A;
	Wed,  1 Oct 2025 16:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xos38QqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6678328F; Wed,  1 Oct 2025 16:51:30 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD65800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 16:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UecNphPa5eYzQFmG4RvgcpwTtZ/e999xGsBTBbFWRHYukhOcE9ZwgT8Fkxt65CepF/6nM01c2TpObO+XGSQgEA9NDpPZhIuWm9mSBAjJkQGVcicpsfzzwBLoTgQ6uTIlqREhEcw5CpsSz7w3IaSDA40+Wk5RsFHfzyybH/SLT9vJUQoGU5LkiWEOMlGuml7RuJ/VaOgl4uMcZIFyDHRUc5xnYbO+6Y0JIKEhKqhS8fes4pZm44ffmTkYL27K+R6/cECPZ3W3YHZfV/2pl95I64Jrk/Gko+6N+qtP3wdcYlOI7icLJp2kfKIZXig6eKUwzkYkRpPvrSynCeYPSmNxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t09yJ2H2vh7vZo3J4QphrpmoGfT3Q4hK5crt3BA85+A=;
 b=emYY/ooPMfKVX2SAl9t6EuoRi7rtKCDQ3GKHQSf3N59ZESv951WVf1Eng96meTyHi/TVC3YVud2wBGZw/d4+HshFS7apZp+urq1Wz+G5i38buXjpJwX8GurPZiHlYe48lMSDrXlI/8pERDe6DmOvwTXaQR2EwUf5oZiV5p3y2GTZYjOh03E79V5z6oZvSEZORrhKDvRMzEu4y35PIlS7LudfhlC0wH0RCdC24lPYs9n0FpWMUgdpidcfjB7ZQhlSKKcdfjSohVwSIJPACCItXb5+p5FrS5MdM662XJmWCrG/CVVZ4mGQXN4dFnbhjvG2GkKx1DHLj+3Nx9tv+H3NoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t09yJ2H2vh7vZo3J4QphrpmoGfT3Q4hK5crt3BA85+A=;
 b=Xos38QqLjBm6uGCLPxNJc9zO5uSwITE8JSZgtH5NyqFfA1HT+bmwByT9Pf6bSBdVbBZxn7vilL/Dd4uP4qxA0eXLZzoKLfU3xSPxV7N4vHMCJExnklKKrjuEcUFbGUqKLZaVlKvn/9i01Z7MJRTqO4w4dx91b4cBQ5zy8oPi6/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 14:51:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Wed, 1 Oct 2025
 14:51:21 +0000
Message-ID: <4b3bfc41-2513-42e1-b86f-f87d001ef057@amd.com>
Date: Wed, 1 Oct 2025 16:51:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Smatch reports for zynqmp video driver
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <21c8099e-a2ba-4361-9351-221e10deae80@linaro.org>
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
In-Reply-To: <21c8099e-a2ba-4361-9351-221e10deae80@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0064.eurprd03.prod.outlook.com
 (2603:10a6:803:50::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cd6244-4624-49dd-bf89-08de00f9fc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0ErZWdGd3RpTE1hdlVvREVhYmkrOS9IaFpJcXo3Z2tIR0lQTnRIRmk5amU1?=
 =?utf-8?B?aUFISTdBWERwcndQZ2UzS3ZXdkFwWUo5NDdQaVF5M1ROZXNBZEpxeXVlWEw2?=
 =?utf-8?B?aUZXT3RIN0Rxd0VZL1B5YUh1V2Y0UFRScWtzWUlKdFBNZ3g1NzFONHFQcHc3?=
 =?utf-8?B?aWJVVlU5clpoMEpxRDExVlB1L24rcGpNWDl3dng3QmhXeFh4ejJSdW1lYXBK?=
 =?utf-8?B?MGdDZXF6WGNaM0g0YzRqc2xyWFRXVkRyYXdRSXNlNTR6YnpMMmh1OWxLWGxv?=
 =?utf-8?B?U0pTMVVmelQ3NzNYWGNHR1Z1Q09zNEdpSFE2MzJPVWduaXVualNsZnZQRDRj?=
 =?utf-8?B?RllyNnpKZmlHcG16UEpMc2t2em5lVXlnaE5nYU51NGJDOUtwMFduR2tXRFVr?=
 =?utf-8?B?cjdxT2U5cm54cEJnTk5vclY5aGkvK2ZnbWZ5eW0reWVKem9jbjFNRVFaS1o4?=
 =?utf-8?B?M3hNNXpORzcyd0pNNWE3bUxtV1M1bWt6alNEM3I3RHgvbmNVZDNKUzdmVTZn?=
 =?utf-8?B?R3JBc3NXdC9CdGZuWXZyYkxkbXc4UWR3N0lqZHBnRHhFWFBuVHpmYVc5bmx6?=
 =?utf-8?B?VHZ4QWRvSFhZYjVoTWlXUlRmZThLbmgzOVk2cFhxRys0RmhPaGhXNGRqTFYz?=
 =?utf-8?B?L0t2dENOWXZkQnd3cjNHT2tWRVgrbHBtb3U4ODduNjNNa3VxcU9keXZqdHM1?=
 =?utf-8?B?cFlhTWhJcnJkZXpjU1pQNzBENmR1ajA4VGF6TDZsdExQcTBaR21pUkNyRDVI?=
 =?utf-8?B?VzdaVTRTMFdmbW1oWGJqSTlPVXIzUkgzbndXRlRQVEsyUDFZNzZKK0pBajg0?=
 =?utf-8?B?ekhhM3ZyVlU3ejB1d0ZBd1FnY25LY3VET3VkdXluelNneHJjZjkwN25SSkln?=
 =?utf-8?B?L2dvTitjWkE3UkFSbk5nck12MjFxczNhR1RYZzFHQzdGb1BJUWhFSzlqNlR2?=
 =?utf-8?B?SUNJYSs1NkNPdUc1VGQvd01DV0tBZC90ZEpYblY3SDFVRmZIV2dmOVNoaXFL?=
 =?utf-8?B?dDUyMldvWUJNMTU1OTMrZC9GbHdSbEpNekllbDhONUFDVVVXMGZva0cxZVZT?=
 =?utf-8?B?YklXaXFZWHdMT1N5L3U4bHlBbU5uTk5XVlg0K0RPUy9Yc3h3cVFlQ1J0aFBh?=
 =?utf-8?B?aFF5alhBY0JmNDBmd1h0QkpYcTRQYTkyNzBXMWtTb25aQW5YR1dSZ0VkcUtO?=
 =?utf-8?B?Qzd2M1h5YXNCY2ZSZmk0cWV1NjJLY2RndlJyMktSR05sYVNraTk2LytXMFpo?=
 =?utf-8?B?SHlMdDBkQ3BZZXBmVWxYQVJ6MEhNQk1YSGUxWlBFTTJGSkxGVlpsUnBZeWto?=
 =?utf-8?B?aGJMK2p4WTFWTTZZKzhuY0Q5VjhTdm9pYjNnYndCL3JWcCtYMXQ3T0N2UFE2?=
 =?utf-8?B?TEprRUxCZmMxWkEzTG9LN2NJMzJKUlk3eUJzbzd3akRFT3MrbjBlUnNWVkRu?=
 =?utf-8?B?c0JoWlByRzFVMHc3R3VvMUswM3BjUXZLSmlPak9ud1dNNW1Jajk4cUlGaFV1?=
 =?utf-8?B?Q3VPdEVJSWlqMHVUMFUyK0VNS0FYZ2gzR3BSVlp2bko4cjhMZUFSRStMU2Jq?=
 =?utf-8?B?MjlhYmZyNmpPMDBVakZId0RSdm43WXRwQWdIWFJFd1BpclZWK0pRcnV5bXV5?=
 =?utf-8?B?bzhnNnBQL2RDeDRPcFlvM1RRazJsK0VQT3lPNWFvUUVEZHNFVitxTHBLZFp1?=
 =?utf-8?B?SS9FNStTem9xMjg0Z3BqclRoWWl1MnR4d0d3U1pQbXJvbnViTXEvQm9BMHBI?=
 =?utf-8?B?K0pOV0U1WGROb29jU1NNcTBxNGIrdGkrSjlPT0dGVjZCd2VsNExaVmJoMFY3?=
 =?utf-8?B?ZjROYTJQZ29JZ1VJOE9BZEdhUG1CL1FJYnE1bGRqNUhvVzZuK2s0U0xlZEpG?=
 =?utf-8?B?WnZNWlZqbDc5ZXFKMVBTR2FmaEN4OEVnTFErTnlrTXB3STQ4aGRPSnlMM1pI?=
 =?utf-8?Q?WgQd2wgyTPjx2QPhffpMiDSsMCsM8WCo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTh3Mm1UQnV5UGtxN3kySXlua29zZFI3Wm0wZFR2U2hXakZnc1VLQTU3UVpI?=
 =?utf-8?B?U3lDWmVPZHRIRHFGVDkrL1IycGx2NWk4bXNUZUd4M21Nd0U3QjBqdDVkeisz?=
 =?utf-8?B?cXNNUjRSY0NjSHBIcFlROFpWVk9ndmtVc3cxN015YzZlUW14Z2ZITDZMT3My?=
 =?utf-8?B?eDNPSFhyV3M2Tk4yQmJKRXhFTHMrREpxUjlacjJ3YUhHZ3RPQ1M2ZGhYeVpx?=
 =?utf-8?B?MVk4Y0ZnWjYrRHlRUkl0VzJwVHNVREROOUsyNDRBL1JMWmFXekx1OGpxRG5I?=
 =?utf-8?B?a2JzWC9tb0VqMGZxc1lOWGplT1ZHSEYxMk1FRjUzdmF3bjNXZVdHdXBCSXJ1?=
 =?utf-8?B?VUFaWjAyVTNGMFJZRlFHbzl3Rkd6cDRTS3FRQ0VNaFNOTHBoR1lsZklJbDEz?=
 =?utf-8?B?SWx4cU44QVUrNXRCRnFXWFAzWUMxbGMyQzR3VXZmNEtQL1R6aVJ4b3N3cUIx?=
 =?utf-8?B?T3lqL2NCb3NOSWhONGp0bkprTS9QdDAyblJOWHlZT0dPanF3WmxqQU1FaUhm?=
 =?utf-8?B?WFIxczNJdHpRQktjSnRQc1NYRVlMeEFLUHJYc0hVL3BPOFdPdWJqQzlob3dK?=
 =?utf-8?B?cFJTUnRRdHZBVkhNOGZiMmlUMmNzMEZMc20xK09wNm5lR0g2M2tuMnUrL0dn?=
 =?utf-8?B?UnJxTDFIYytmaUN0ZTJ2RG9KY25udDF5RHdibjRaYTZabzhPcXI0aXFJOVI0?=
 =?utf-8?B?TlBuc1NmM2VuM01QbXlhclcveWFIZzhtQWpXMCt6eVlCTTY5RHowQXQyVDVa?=
 =?utf-8?B?cUMrU2tBRi9YL2Rzb2c2Q2RMMWJXQzV0allaS1ZhMmdyUnlhUVBBNzF5cWlx?=
 =?utf-8?B?TmZrMGVoQUFCSjRqNUxWUEJlVTlEdU5zSkIzMHdubmh5SlZES3V3dTd1MEx1?=
 =?utf-8?B?UFZvUmFYVUZaaTF3STR4amJxNVl6dC9vaFF4NnprSkQ3ZnkrYzdROE5UclEw?=
 =?utf-8?B?OXBPb3RKRFd1YkZXZGtveStsY2lBSDdkNUVnU0xic0d5alVGbHc4aUUrY3Ey?=
 =?utf-8?B?c0FKcmxIVTg0N1c4T0cxdTZSSnBHeFFlYXMwUmFCWHBWSUZVK0gzR2lKL0dq?=
 =?utf-8?B?U2ZtYitlNCtOdE1LTXhDWnZKZmptS3RackNCbmUvWlRBZVNqQ3Y1N0RRK2ht?=
 =?utf-8?B?YVBBZHp5VisxcER3U0JQazNhbWU2M0loTERvRkw4M0hMMG1Oc3g1N3FTRkJw?=
 =?utf-8?B?V1dZK2NPYlI4ZnkramlSdTZKaUFRTit6NGd0M25sNVpITXVmeFFsd25BdUhY?=
 =?utf-8?B?bmxaVWlha2kxWnNiNEFwUEdqaHduQkpOUU9pWXo4QUI0cWFJeWllYkxQZXZl?=
 =?utf-8?B?T2ZCMThZY24rVnFaWnllNCtucHZodEJOSjI2QWZYRGlCSndkU2xBRkZOOCta?=
 =?utf-8?B?Q2dOK2NrNlZCN0VlRnZGNkEvZXFCUXpjQzc4M2lxY2xzREgzOHFVOUgrVHpy?=
 =?utf-8?B?aklncTgwb1ZSSXZGNkJmYmFlSmZnVnR6S2FpRXNLYzByNElISmFOUWVyM2lu?=
 =?utf-8?B?ckxlSjBGTUdKTXBzb0NMZDZHczFCSW9wNFZFNDE1UzNyZmhwZ1BsMms3dXdk?=
 =?utf-8?B?bzg5Ylh4eHltMG5sZ0FVd1FiNHJiN1pSdWx2eTV2V0ovSzIxT2Q2c0puaGZw?=
 =?utf-8?B?ZjRWM0JKZlNxcDEwWFVyQUExUm5kZi9Jc2dDVHZPVWZoU2wxQm5PaDdqY3Er?=
 =?utf-8?B?eGhJUVE4Y1FBRE9JNm5lbCtQS0k3WEhLa21sc3E1T1VDNTcrZnlRMUdUSWxv?=
 =?utf-8?B?QzI0cFVLR3AvNXBvQ1hmN1pySWJ3OEZGTm9HQ2ZLaGlXditHY2pMUTczdXFj?=
 =?utf-8?B?K2JrRkdxbkhVZEhDWjBmWW9QYk05UlpEd05oNUJrZGdBUFJBOXZ5WkFIV0Z5?=
 =?utf-8?B?VElrc2twZnRYY1M0dk54SG9xSE5HNlRrRkZ6RTF1NUVZQXN3QW1Va3kvRVJa?=
 =?utf-8?B?eWtEYUhldWc4MGl3b245MTNzZ2xkUkpLeDNTZ1diWnBMNk84MlJXYW1tQ1Js?=
 =?utf-8?B?czRROVdZenJyNFZzbEZXTXAxbzRueVd0QkQ4VndVcTlCL1dtZ2Z4dkVxalFJ?=
 =?utf-8?B?R3R6MzJ0RFF3Nmw1MTREbDhLS3BUVzJyQTVjZ1VJS2VNd3RyOC9Zbk8wbVNO?=
 =?utf-8?Q?qVTGh/s/7noLMnzSqFGfl3MPg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cd6244-4624-49dd-bf89-08de00f9fc3f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 14:51:21.5194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKeYYBt9/UOZ/RLmgo6ta497XiTKYxF44Vthi+77Ni0jGrJM8n3q+zPo6q5s1HEF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913
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

Hi,

On 10/1/25 16:03, Andrew Goodbody wrote:
> Smatch reports the following two issues
> 
> drivers/video/zynqmp/zynqmp_dpsub.c:271 config_gfx_pipeline() error: 
> uninitialized symbol 'offset_matrix'.
> drivers/video/zynqmp/zynqmp_dpsub.c:277 config_gfx_pipeline() error: 
> uninitialized symbol 'csc_matrix'.
> 
> Looking at the code, offset_matrix and csc_matrix are only initialised if video- 
>  >is_rgb is true. It looks almost as if the code for video->is_rgb being false 
> was never written. So I am not sure of the correct fix for this.

Thanks for report. This should fix it.
Do you want me to send a patch for it?

Thanks,
Michal

diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c 
b/drivers/video/zynqmp/zynqmp_dpsub.c
index 52af23c3c835..442036e93f72 100644
--- a/drivers/video/zynqmp/zynqmp_dpsub.c
+++ b/drivers/video/zynqmp/zynqmp_dpsub.c
@@ -262,10 +262,12 @@ static void config_gfx_pipeline(struct udevice *dev)
                                                                 video->sampling_en;
         writel(regval, dp_sub->base_addr + AVBUF_V_BLEND_LAYER1_CONTROL);

-       if (video->is_rgb) {
-               csc_matrix = rgb_coeffs;
-               offset_matrix = rgb_offset;
-       }
+       if (!video->is_rgb)
+               return
+
+       csc_matrix = rgb_coeffs;
+       offset_matrix = rgb_offset;
+
         /* Program Colorspace conversion coefficients */
         for (index = 9; index < 12; index++) {
                 writel(offset_matrix[index - 9], dp_sub->base_addr +

