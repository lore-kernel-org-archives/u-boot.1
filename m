Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56641D44D77
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 14:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9A988C7C;
	Wed,  6 Nov 2024 15:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wu5eYra4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5227C88E63; Wed,  6 Nov 2024 09:38:02 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C24E788D09
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 09:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEItoTCTnWgvxnbJn3rzKw2k73oCKrhm3k8V0a6/rGYtCSrO97dMwItGGWHCRc0AR3aeVyHcBBei/krGtoWFN8vVW7m1hvqwyWnazusOHXoS/1cQUqRF8kYQ/AI/d0HF6U+W2ShuK6w+jkuXdFvFkZHB4rHENecVWNf1oW4yhPjuEd7VqaIJz+tDI8cCmwDDzjwBKaHcWFP6Dagm9EoBbWkpQNNqC3rgNq2DZu2Z4VTeYsAz7498wLDrQp2L/veKh1ZzJYyy8LWNb/GY/p6whfnHB6fry/hV8xr8ZLrYyNmLMZBkwM7UvP/+G7+doTvKfMkUIrjogcBqv1nG7zjOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qst7JowRIxBXZsvCASxqC0QbKeVdCBFjMTFw8lrqVak=;
 b=nrTjpe8NOabiXGv+3f4GZEyV9T85bI9AS2ip65irdmPrduww65uK8b6C941OVSWNAV8ixSwwZjA0alR6e28l8Bo/k52TI/kaK+pl0xHcQ1ccE4Z265N3lpN4OuFvZCy5gxtA4acIh9fAbgRCqyMjtax1KhR2Wkur5TwgsQk7Pd7dsOZxfPIL9NctgsVYz+DyR9p2S1FLNHllV+bG4Wrx/EVFssyCapPC71WuNvsFDLCLJA8vag1zO31IEan1B1SlWK0kuafXjfC3IzA/yDdqMmn7omfvPk+MlyPZWAQqZ8VndH8EsXuQXiUxqw7znnljLuPKGJUtGAYExsqWzWqW5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qst7JowRIxBXZsvCASxqC0QbKeVdCBFjMTFw8lrqVak=;
 b=wu5eYra40Os9+6kgRPOI9bpj2DMPF4c5akNptwfg9r4nMawmRF02s67irYnBwdRmJxqnjduqa/bN0a17pLQJsvQfiVKl+dDT14hAtdEbMSWMg30JgjQp8Zxj4R/OrH+mn/uKKEkOuX3LIy+7A4gmuHDGEIrBwdadG3y/KqY0aPo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 08:37:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 08:37:50 +0000
Message-ID: <027b700c-0f9b-4ff8-b42f-ae8cfe1bd26b@amd.com>
Date: Wed, 6 Nov 2024 09:37:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] board/BuR/zynq: initial commit
To: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20241029085258.1740289-1-bernhard.messerklinger@br-automation.com>
 <20241029085258.1740289-5-bernhard.messerklinger@br-automation.com>
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
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJkK9VOBQkWf4AXAAoJEDd8
 fyH+PR+ROzEP/1IFM7J4Y58SKuvdWDddIvc7JXcal5DpUtMdpuV+ZiHSOgBQRqvwH4CVBK7p
 ktDCWQAoWCg0KhdGyBjfyVVpm+Gw4DkZovcvMGUlvY5p5w8XxTE5Xx+cj/iDnj83+gy+0Oyz
 VFU9pew9rnT5YjSRFNOmL2dsorxoT1DWuasDUyitGy9iBegj7vtyAsvEObbGiFcKYSjvurkm
 MaJ/AwuJehZouKVfWPY/i4UNsDVbQP6iwO8jgPy3pwjt4ztZrl3qs1gV1F4Zrak1k6qoDP5h
 19Q5XBVtq4VSS4uLKjofVxrw0J+sHHeTNa3Qgk9nXJEvH2s2JpX82an7U6ccJSdNLYbogQAS
 BW60bxq6hWEY/afbT+tepEsXepa0y04NjFccFsbECQ4DA3cdA34sFGupUy5h5la/eEf3/8Kd
 BYcDd+aoxWliMVmL3DudM0Fuj9Hqt7JJAaA0Kt3pwJYwzecl/noK7kFhWiKcJULXEbi3Yf/Y
 pwCf691kBfrbbP9uDmgm4ZbWIT5WUptt3ziYOWx9SSvaZP5MExlXF4z+/KfZAeJBpZ95Gwm+
 FD8WKYjJChMtTfd1VjC4oyFLDUMTvYq77ABkPeKB/WmiAoqMbGx+xQWxW113wZikDy+6WoCS
 MPXfgMPWpkIUnvTIpF+m1Nyerqf71fiA1W8l0oFmtCF5oTMkzsFNBFFuvDEBEACXqiX5h4IA
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
 If49H5EFAmQr1YsFCRZ/gFoACgkQN3x/If49H5H6BQ//TqDpfCh7Fa5v227mDISwU1VgOPFK
 eo/+4fF/KNtAtU/VYmBrwT/N6clBxjJYY1i60ekFfAEsCb+vAr1W9geYYpuA+lgR3/BOkHlJ
 eHf4Ez3D71GnqROIXsObFSFfZWGEgBtHBZ694hKwFmIVCg+lqeMV9nPQKlvfx2n+/lDkspGi
 epDwFUdfJLHOYxFZMQsFtKJX4fBiY85/U4X2xSp02DxQZj/N2lc9OFrKmFJHXJi9vQCkJdIj
 S6nuJlvWj/MZKud5QhlfZQsixT9wCeOa6Vgcd4vCzZuptx8gY9FDgb27RQxh/b1ZHalO1h3z
 kXyouA6Kf54Tv6ab7M/fhNqznnmSvWvQ4EWeh8gddpzHKk8ixw9INBWkGXzqSPOztlJbFiQ3
 YPi6o9Pw/IxdQJ9UZ8eCjvIMpXb4q9cZpRLT/BkD4ttpNxma1CUVljkF4DuGydxbQNvJFBK8
 ywyA0qgv+Mu+4r/Z2iQzoOgE1SymrNSDyC7u0RzmSnyqaQnZ3uj7OzRkq0fMmMbbrIvQYDS/
 y7RkYPOpmElF2pwWI/SXKOgMUgigedGCl1QRUio7iifBmXHkRrTgNT0PWQmeGsWTmfRit2+i
 l2dpB2lxha72cQ6MTEmL65HaoeANhtfO1se2R9dej57g+urO9V2v/UglZG1wsyaP/vOrgs+3
 3i3l5DA=
In-Reply-To: <20241029085258.1740289-5-bernhard.messerklinger@br-automation.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0106.eurprd04.prod.outlook.com
 (2603:10a6:803:64::41) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2da7c7-c7f6-4617-b1b2-08dcfe3e4c07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXAwUU4yVVJPb3h6WnBFYkpIbnp0ZENoNDdkTndEUlNtak1pZ0x6SjU0RE1k?=
 =?utf-8?B?cHJ6WXBYbW5PS1djckFveVgxVzFhNnlGU0hxNHNrZFB3dnBCMGI3S2h6dDhK?=
 =?utf-8?B?YmdZVnQvbFJ4TlFQVW9wWmgxUWh4bFI3cndVMldBZmlXSXNhOTc2UEhXb294?=
 =?utf-8?B?c0xNazAvWXh6QkpKcXV4UVRTRjJvRkp4aFV5QWlqSG1aaXREaXVvVTB0UEll?=
 =?utf-8?B?djZKVHVjYmhQMCtPV29HRzdlYzFkOUlta251UzJjbTQyZWlQUi8zQ0s2UTd5?=
 =?utf-8?B?SjVtZmkvb2hKcjJ5dDM5dWZtSkhreDNMeWZ1enRGRWtZV0tUWWdRWFptUHBm?=
 =?utf-8?B?TjFwS3dqRWowcWltb1MvWE9ueVEwaE4zYnRzVW53MlB2NURPT0dUdU5SS1Y1?=
 =?utf-8?B?U2l6Y1NDUEZEUHgwSWhhZkUrRzdrNnloQ2ZwdkFaMEE1dlQzelgveHlxNnNV?=
 =?utf-8?B?TFMweTJYU0dwL2syTkFHNFdwQmdndDVuUkh6eC8zNjBYMTRCUjI5TUJpbmc1?=
 =?utf-8?B?Uk0xVHRMRzF5MUNDWWpRcCtHVG9raWZndHRBN3Jzaytsak1makZrNWJRSWU4?=
 =?utf-8?B?cVNjNTBBc1habVY0M0tnZ2FYbzRnVlVnZTVSZHZOQ3dZOEgrczg5WGs0RDc5?=
 =?utf-8?B?a2R4eFdzdGR0a0hRWDhnNW05QXlPK2NVcDhId2tRVWVST21ZMlViS0tUZ0tp?=
 =?utf-8?B?bTNkMVJUZFFkTUw3YnhDUjVPeFh6VERpUEtCMks1M0VTUWVUOVdnNFV6ZEZ5?=
 =?utf-8?B?WWtZbEtQQ3pIMklCTlJUZ3dOV1A0QWNnYlUvWkhoM1hxNkwzbC83RnhWeDll?=
 =?utf-8?B?b2JKS3JQZlZQb09wL2twK0YzdzA5QlpGZHNncGVpOTZHaDFYWkxKTElDRkYr?=
 =?utf-8?B?cjVqcFV4ZGRkRmJjQ2x0cUR5NkVDZzg4bERNYVQ5V29iY1BmbStZMDhiY1V6?=
 =?utf-8?B?YzAzdURTVVZaYU5ka3JrN0RGK1djcjZBNzJST0ZXVWR2aTA2dlYzdUFIbWJW?=
 =?utf-8?B?MVMzK01VVStNUkZabjM5V2FRMUEwNlBIeU9lZHVjaWJVVW1ZRlVTY3BNaHFs?=
 =?utf-8?B?NVpFZFpHandRNVlFVnMwYTBVUjdVMFF1MXBkVHM4U3A1ZnZQQVY4UXEyZHRS?=
 =?utf-8?B?S0E2cjFBajJucHpvT3B4bzFTaVhTSTNvQVdRNzFmMFowQVJ4enU1Y1M5YUFK?=
 =?utf-8?B?akJFSDlyUWlHVUw5dHBidzhvZXQ3RjFJcjFBQnhSS1cxMWNiUXFtVkxMSHVT?=
 =?utf-8?B?OCtSTFh1UFpiT1cxajNvZ2dPVTF4akQ0amNsVU1tTXBQR1d2VnhiTmN5Q1RN?=
 =?utf-8?B?cjE2RkMxVWtsSHZIaEdHQysxaWVXeW9lZ0t0ejhDWUkxbVVyY1Z5OU9YM1lk?=
 =?utf-8?B?anN3UlMwK2FNSzJDTytrMVF4UUw1VmlqSUw5cTVxemJ0TkM5TVY1QUt0RmdN?=
 =?utf-8?B?WEs4NVg2WVRpQUFmd3ZseDMvTjY3Yk9laFdGVEIyNXBCNG1lUDgrSjF6MnZt?=
 =?utf-8?B?Nm1lK3l1MzlnLzE5cHpKbUZyRmp1L0VUbnl6QjdHbUc0cGEzZGUwZ2pPK3Nu?=
 =?utf-8?B?dlpSaDltZ0g1TWNSLzVkQUxUNS8wUXZUL0hVZlRyWWxvV3hGSnNXUlR3dlVR?=
 =?utf-8?B?QkQwTlpFVFVaR0lHcElBeGlzMFU5T2lSU2ljcHJJRVJMSjFJY0VmSHVtU3RP?=
 =?utf-8?Q?DM/SvISL/xMLzsTg0nMT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnhjb2o3K3RwcjVyNVFXSkhCK0FYa0crTGs4ZFNqS2dtWURLb3dzOWk3V2JD?=
 =?utf-8?B?TUYyckR0dGxQeHhDMjVTWitmak8rN3VtcEJUaGZ6WlYyM1hCaFdjU0ZuSThX?=
 =?utf-8?B?am5MSVdSYnBhekZINGI5Q0hQeUswUWRLeFBveEp1Y0RwTDRIRCtFVHYrbEYw?=
 =?utf-8?B?WWkxSkdWR2hJSGlOMUZSb3VZdnhmRDBnaG5CTTBoR1ZremJ4dkJjNmt3S1li?=
 =?utf-8?B?eUV3VWptbEpCRVI0c2pNVk9LNHFjejNIUXlDY2dvWE9SQWZxQWZUbWdwS2ZW?=
 =?utf-8?B?alFnSDJtVFBwK0JCSHVtdldnL1dET1FTUDE5TDgrWFNNeCtmeEJrKzl3eHBB?=
 =?utf-8?B?eG5MZXhZM0xGNWpicm01aDM5MlNPTEhYaUY3SjJBTkV3VUpQYVlISndnKzdB?=
 =?utf-8?B?S0k4bmd4U05nRmRLSzUwVExDNi9vNGlhbC9oTXBYNk1Ba1U1bWRpcVlRVUM3?=
 =?utf-8?B?MERtMmQxdEwvMU4xL1hOaTgxS0ZvVWt4Rm1mbk9IMHhveUdEVENua0tzMmYy?=
 =?utf-8?B?S0tCa0ZxSjRSM0RRRGI1cGpwdHFuZlVsbUZsV09uMjNTTzd3ZExNZjYycWpQ?=
 =?utf-8?B?OHF0YjZsRTMwMTIzdTBQR2JSNGJLanRrQVhHanZJaC9TWVhPcnVwZUtYMDlU?=
 =?utf-8?B?NFpYeFM3L2dNN3owU3hXVGpOeitlWndyNzlkSE5OZmFNQTNNWW5Qc0E1VFV6?=
 =?utf-8?B?K3k0T2FRZnFLUGNieDUzL21OeERFeXJwb0RuS1luSFhiZDFzZVlzN3dlQmZk?=
 =?utf-8?B?SklGZ3dKU3BFVko4WWFEM21ma1RsM2RZcVlYSnlLN0Y5Q2RYSUtBM1kvUkhY?=
 =?utf-8?B?SHhxaU5ZUkI5cGtYV3JSTk05VW1uUHFRL0JUMlhSeFhLVEppVnVlK2xydTds?=
 =?utf-8?B?QzZDZThVVHp5ZTdYbGNEMGdubnpTN1BLVmo5U1A0cFIvdW8xb1BUWis5c3Q1?=
 =?utf-8?B?TkUwTjNMMjFEdmtRVE1FdzdYQUM2UmIzanJYT1ZwYlFramZMV3V5WUR1ZW5K?=
 =?utf-8?B?YmQ1Y1dLU0dmTXVtc25UVldOQkdOMDNkWDJYZjNCYmJOakVyUEpqeVhGckZq?=
 =?utf-8?B?UjFOaFJENS9HejZld1l3TDJEZ1E2RVlRSU5FbFBjS0phb1VHUU9FODFicEk3?=
 =?utf-8?B?VXJsbEVjdHVvYS8zZTMrV1dINjNkbW8xK2R6blFCTmk5d1QweHEzd1dlRkFI?=
 =?utf-8?B?enJ2TmNXUDlnVTR0RVBxaStUakF0YWR3QkJTVVBDb3hoWnM0ZXIwMkV2bHhs?=
 =?utf-8?B?NmhQZjZvQVA1NW5iV1Q0UG9lY0dvM1l6endsZXRtNnlGZ05OampDTmlPdFZk?=
 =?utf-8?B?L0NkK0ZkOEpjelAvOHBnRWdBemxmSlF5QWVxRFlDS1RNY2IxQ3pZeVBpVDlQ?=
 =?utf-8?B?VU1DUzIzUFRxckN0eHg1andIMzNNak1RaFhWUlg0U2xzcVBSRmoreDRxZE1n?=
 =?utf-8?B?bE9ySkhsOGY1STEydzk2Qkg0aG9ES1hDakV4ekkwOGxHejBRZlVXckJHajVx?=
 =?utf-8?B?SStMN3ord1lHL21Oc0ZaNU1LMmNXNTR2bEo3eU1kU2ppdS9KZm9hTTdVM0RO?=
 =?utf-8?B?N0c5QkN5Ym1vMEpZUUkzelBWRjV3VzNhUWhZNHlhUGlnT2VMRHQzMHppc1hQ?=
 =?utf-8?B?RVVjRkpoZy9yK2xSRkNERUplQjRkY3RabHJ2cXJ2K3FjOE5iSWVpRUNySHBJ?=
 =?utf-8?B?ekMxc2VNeHVGVXppTzZXOHM3ZFdIN0oxMTJJL1h1MERybXE1eklSLzg2T29Y?=
 =?utf-8?B?ZTZHbFlsS0FBblNYcm8zOXhjek5KSnRPMVMydkZndWFTQ2hEV3FzWkZpSVdj?=
 =?utf-8?B?L3E0cjVtRGo2QkQzaHNGV05LVk1KNUNPUUpka0tPbGp5cmdjOTJYUnN0aDFH?=
 =?utf-8?B?MU1RYnZ3cnRUdlBORXV6cjBxZ1R6bEg0QnNLRW1sNDBwV0d3eU50eFplV05I?=
 =?utf-8?B?MzI3SndvTlplNGZHd2c4M3E0ZWtTa1pobDRFb1k2Y0dIUjkrSWJIZzZUbHQr?=
 =?utf-8?B?cTExdTdmQ3NEOWhhSjVPdUZGdGJSazlBWm8rQVRhWkxhVmx2V2JCMVJQM09C?=
 =?utf-8?B?U3BoQmw0RUhUVG5jWHRIUjl2YTVoZkVDVElEdGNTeU5nR0RFcnp6Z3ZpMU0r?=
 =?utf-8?Q?aKJa/7TSBhVDWS9SdiyFap3L9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2da7c7-c7f6-4617-b1b2-08dcfe3e4c07
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 08:37:50.5844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLySXi30v4YqQbJ+w2m5htDLW4Cm/iHqh10ruSeF58/qu3JrdUDXa6tR+b1dH2Kh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550
X-Mailman-Approved-At: Wed, 06 Nov 2024 15:13:43 +0100
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



On 10/29/24 09:52, Bernhard Messerklinger wrote:
> This commit adds support for the brcp1, brsmarc2, brcp150 and brcp170
> boards. This boards are based on the Xilinx Zynq SoC.
> 
> Signed-off-by: Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>
> ---
> 
>   arch/arm/dts/Makefile                         |   8 +-
>   arch/arm/dts/zynq-brcp1-u-boot.dtsi           | 110 +++++++
>   arch/arm/dts/zynq-brcp1.dtsi                  | 146 +++++++++
>   arch/arm/dts/zynq-brcp150-u-boot.dtsi         | 129 ++++++++
>   arch/arm/dts/zynq-brcp150.dts                 | 187 ++++++++++++
>   arch/arm/dts/zynq-brcp170-u-boot.dtsi         | 113 +++++++
>   arch/arm/dts/zynq-brcp170.dts                 | 153 ++++++++++
>   arch/arm/dts/zynq-brcp1_1r.dts                |  29 ++
>   arch/arm/dts/zynq-brcp1_1r_switch.dts         |  30 ++
>   arch/arm/dts/zynq-brcp1_2r.dts                |  22 ++
>   arch/arm/dts/zynq-brsmarc2-u-boot.dtsi        | 110 +++++++
>   arch/arm/dts/zynq-brsmarc2.dts                | 172 +++++++++++
>   arch/arm/mach-zynq/Kconfig                    |   1 +
>   board/BuR/zynq/Kconfig                        |  13 +
>   board/BuR/zynq/MAINTAINERS                    |  13 +
>   board/BuR/zynq/Makefile                       |  15 +
>   board/BuR/zynq/brcp150/board.c                |   6 +
>   board/BuR/zynq/brcp150/ps7_init_gpl.c         | 284 ++++++++++++++++++
>   board/BuR/zynq/brcp170/board.c                |   6 +
>   board/BuR/zynq/brcp170/ps7_init_gpl.c         | 280 +++++++++++++++++
>   board/BuR/zynq/brcp1_1r/board.c               |   6 +
>   board/BuR/zynq/brcp1_1r/ps7_init_gpl.c        | 280 +++++++++++++++++
>   board/BuR/zynq/brcp1_1r_switch/board.c        |   6 +
>   board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c | 276 +++++++++++++++++
>   board/BuR/zynq/brcp1_2r/board.c               |   6 +
>   board/BuR/zynq/brcp1_2r/ps7_init_gpl.c        | 283 +++++++++++++++++
>   board/BuR/zynq/brsmarc2/board.c               |  32 ++
>   board/BuR/zynq/brsmarc2/ps7_init_gpl.c        | 282 +++++++++++++++++
>   board/BuR/zynq/common/board.c                 | 239 +++++++++++++++
>   board/BuR/zynq/env/brcp1.env                  | 106 +++++++
>   board/BuR/zynq/env/brcp150.env                | 116 +++++++
>   configs/brcp150_defconfig                     | 123 ++++++++
>   configs/brcp170_defconfig                     | 122 ++++++++
>   configs/brcp1_1r_defconfig                    | 122 ++++++++
>   configs/brcp1_1r_switch_defconfig             | 123 ++++++++
>   configs/brcp1_2r_defconfig                    | 122 ++++++++
>   configs/brsmarc2_defconfig                    | 122 ++++++++
>   include/configs/brzynq.h                      |  21 ++
>   38 files changed, 4213 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/zynq-brcp1-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp1.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp150-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp150.dts
>   create mode 100644 arch/arm/dts/zynq-brcp170-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brcp170.dts
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r.dts
>   create mode 100644 arch/arm/dts/zynq-brcp1_1r_switch.dts
>   create mode 100644 arch/arm/dts/zynq-brcp1_2r.dts
>   create mode 100644 arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
>   create mode 100644 arch/arm/dts/zynq-brsmarc2.dts
>   create mode 100644 board/BuR/zynq/Kconfig
>   create mode 100644 board/BuR/zynq/MAINTAINERS
>   create mode 100644 board/BuR/zynq/Makefile
>   create mode 100644 board/BuR/zynq/brcp150/board.c
>   create mode 100644 board/BuR/zynq/brcp150/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp170/board.c
>   create mode 100644 board/BuR/zynq/brcp170/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_1r/board.c
>   create mode 100644 board/BuR/zynq/brcp1_1r/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/board.c
>   create mode 100644 board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brcp1_2r/board.c
>   create mode 100644 board/BuR/zynq/brcp1_2r/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/brsmarc2/board.c
>   create mode 100644 board/BuR/zynq/brsmarc2/ps7_init_gpl.c
>   create mode 100644 board/BuR/zynq/common/board.c
>   create mode 100644 board/BuR/zynq/env/brcp1.env
>   create mode 100644 board/BuR/zynq/env/brcp150.env
>   create mode 100644 configs/brcp150_defconfig
>   create mode 100644 configs/brcp170_defconfig
>   create mode 100644 configs/brcp1_1r_defconfig
>   create mode 100644 configs/brcp1_1r_switch_defconfig
>   create mode 100644 configs/brcp1_2r_defconfig
>   create mode 100644 configs/brsmarc2_defconfig
>   create mode 100644 include/configs/brzynq.h
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 65176c8fb8..e532beb265 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -250,7 +250,13 @@ dtb-$(CONFIG_ARCH_ZYNQ) += \
>   	zynq-zturn.dtb \
>   	zynq-zturn-v5.dtb \
>   	zynq-zybo.dtb \
> -	zynq-zybo-z7.dtb
> +	zynq-zybo-z7.dtb \
> +	zynq-brcp1_2r.dtb \
> +	zynq-brcp1_1r.dtb \
> +	zynq-brcp1_1r_switch.dtb \
> +	zynq-brsmarc2.dtb \
> +	zynq-brcp150.dtb \
> +	zynq-brcp170.dtb
>   dtb-$(CONFIG_ARCH_ZYNQMP) += \
>   	avnet-ultra96-rev1.dtb			\
>   	zynqmp-a2197-revA.dtb			\
> diff --git a/arch/arm/dts/zynq-brcp1-u-boot.dtsi b/arch/arm/dts/zynq-brcp1-u-boot.dtsi
> new file mode 100644
> index 0000000000..3e1d157abc
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1-u-boot.dtsi
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +#include <config.h>
> +
> +&i2c0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	bootph-all;
> +	spi_flash: spiflash@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +&brd_rst {
> +	bootph-all;
> +};
> +
> +/ {
> +	binman {
> +		bootph-all;

this is likely not needed.


> +		filename = "flash.bin";
> +		pad-byte = <0xff>;
> +		align-size = <16>;
> +		align = <16>;
> +
> +		blob@0 {
> +			filename = "spl/boot.bin";
> +			offset = <0x0>;
> +		};
> +
> +		fit {
> +			description = "U-Boot BR Zynq boards";
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot BR Zynq";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "DTB BR Zynq";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "BR Zynq";
> +					firmware = "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +
> +		blob-ext@0 {
> +			filename = "blobs/cfg.img";
> +			offset = <0xC0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@1 {
> +			bootph-all;
> +			filename = "blobs/bitstream.bit";
> +			offset = <0x100000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@2 {
> +			filename = "blobs/bootar.itb";
> +			offset = <0x900000>;
> +			size = <0x600000>;
> +			optional;
> +		};
> +
> +		blob-ext@3 {
> +			filename = "blobs/dtb.bin";
> +			offset = <0xF00000>;
> +			size = <0x100000>;
> +			optional;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brcp1.dtsi b/arch/arm/dts/zynq-brcp1.dtsi
> new file mode 100644
> index 0000000000..d4b442070c
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1.dtsi
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/include/ "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "BRCP1 CPU";
> +	compatible = "xlnx,zynq-7000",
> +		     "br,cp1";

it should be vice-versa.


> +
> +	aliases {
> +		ethernet0 = &gem0;

this is not needed. No sw is using it.


> +		i2c0 = &i2c0;
> +		serial0 = &uart0;
> +		spi0 = &qspi;
> +		mmc0 = &sdhci0;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyPS0,115200 earlyprintk";

earlyprintk has been deprecated. Use earlycon instead.

All three above are also below and won't comment it.

> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	brd_rst: board_reset {
> +		compatible = "br,board-reset";
> +		pin = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		se_green {

run dt-schema. They should be using names follow certain pattern.

> +			label = "S_E_GREEN";
> +			gpios = <&ledgpio 0 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		se_red {
> +			label = "S_E_RED";
> +			gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		rdy_f_yellow {
> +			label = "RDY_F_YELLOW";
> +			gpios = <&ledgpio 2 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_green {
> +			label = "R_E_GREEN";
> +			gpios = <&ledgpio 3 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_red {
> +			label = "R_E_RED";
> +			gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		plk_se_green {
> +			label = "PLK_S_E_GREEN";
> +			gpios = <&ledgpio 5 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		eth_se_green {
> +			label = "ETH_S_E_GREEN";
> +			gpios = <&ledgpio 6 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +#include "zynq-brcp1-u-boot.dtsi"

-u-boot files are included automatically. You don't need to do it explicitly here.

> +
> +&amba {
> +	ocm: sram@fffc0000 {
> +		compatible = "mmio-sram";
> +		reg = <0xfffc0000 0x10000>;
> +	};
> +};

This is already in zynq-7000.dtsi

> +
> +&clkc {
> +	ps-clk-frequency = <33333333>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	ledgpio: max7320@5d {	/* board LED */
> +		status = "okay";
> +		compatible = "maxim,max7320";
> +		reg = <0x5d>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <8>;
> +	};
> +
> +	pmic0: da9062@58 {
> +		compatible = "dlg,da9062";
> +		reg = <0x58>;
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +	max-frequency = <25000000>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "okay";
> +	spi-max-frequency = <100000000>;
> +
> +	spi_flash: spiflash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor", "spi-flash", "s25fl256s1";
> +		spi-max-frequency = <100000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/zynq-brcp150-u-boot.dtsi b/arch/arm/dts/zynq-brcp150-u-boot.dtsi
> new file mode 100644
> index 0000000000..f2771dd9bd
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp150-u-boot.dtsi
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +#include <config.h>
> +
> +&i2c0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	bootph-all;
> +	spi_flash: spiflash@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&gpio0 {
> +	bootph-all;

do you really need these for booting? Just asking.

> +};
> +
> +&brd_rst {
> +	bootph-all;
> +};
> +
> +&rs232_en {
> +	bootph-all;
> +};
> +
> +/ {
> +	binman {
> +		bootph-all;

same here


> +		filename = "flash.bin";
> +		pad-byte = <0xff>;
> +		align-size = <16>;
> +		align = <16>;
> +
> +		blob@0 {
> +			filename = "spl/boot.bin";
> +			offset = <0x0>;
> +		};
> +
> +		fit {
> +			description = "U-Boot BR Zynq boards";
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot BR Zynq";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "DTB BR Zynq";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "BR Zynq";
> +					firmware = "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +
> +		blob-ext@0 {
> +			filename = "blobs/cfg.img";
> +			offset = <0xC0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@5 {
> +			filename = "blobs/cfg_opt.img";
> +			offset = <0xD0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@1 {
> +			bootph-all;
> +			filename = "blobs/bitstream.bit";
> +			offset = <0x100000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@4 {
> +			bootph-all;
> +			filename = "blobs/bitstream_update.bit";
> +			offset = <0x400000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@2 {
> +			filename = "blobs/bootar.itb";
> +			offset = <0x900000>;
> +			size = <0x600000>;
> +			optional;
> +		};
> +
> +		blob-ext@3 {
> +			filename = "blobs/dtb.bin";
> +			offset = <0xF00000>;
> +			size = <0x100000>;
> +			optional;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brcp150.dts b/arch/arm/dts/zynq-brcp150.dts
> new file mode 100644
> index 0000000000..f8cdcb35d8
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp150.dts
> @@ -0,0 +1,187 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "BRCP150 CPU";
> +	compatible = "xlnx,zynq-7000",
> +		     "br,cp150";
> +
> +	aliases {
> +		ethernet0 = &gem0;
> +		i2c0 = &i2c0;
> +		serial0 = &uart0;
> +		spi0 = &qspi;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyPS0,115200 earlyprintk";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	brd_rst: board_reset {
> +		compatible = "br,board-reset";
> +		pin = <&gpio0 27 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	/* Put this pin active high to enable RS232 debug serial */
> +	rs232_en: rs232_enable {
> +		compatible = "br,rs232-en";
> +		pin = <&gpio0 52 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		re_green {
> +			label = "R_E_GREEN";
> +			gpios = <&ledgpio 0 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		re_red {
> +			label = "R_E_RED";
> +			gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		rdy_f_red {
> +			label = "RDY_F_RED";
> +			gpios = <&ledgpio 2 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		rdy_f_yellow {
> +			label = "RDY_F_YELLOW";
> +			gpios = <&ledgpio 3 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		se_green {
> +			label = "S_E_GREEN";
> +			gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		se_red {
> +			label = "S_E_RED";
> +			gpios = <&ledgpio 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		plk_se_green {
> +			label = "PLK_S_E_GREEN";
> +			gpios = <&ledgpio 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		eth_se_green {
> +			label = "ETH_S_E_GREEN";
> +			gpios = <&ledgpio 7 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		user1_green {
> +			label = "USER1_GREEN";
> +			gpios = <&ledgpio 12 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		user1_red {
> +			label = "USER1_RED";
> +			gpios = <&ledgpio 13 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		user2_green {
> +			label = "USER2_GREEN";
> +			gpios = <&ledgpio 14 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		user2_red {
> +			label = "USER2_RED";
> +			gpios = <&ledgpio 15 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&amba {
> +	ocm: sram@fffc0000 {
> +		compatible = "mmio-sram";
> +		reg = <0xfffc0000 0x10000>;
> +	};
> +};
> +
> +&clkc {
> +	ps-clk-frequency = <50000000>;
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "mii";
> +	phy-handle = <&ethernet_phy>;
> +	mac-address = [ 00 00 00 00 00 00 ];


not really useful.

> +
> +	ethernet_phy: emio-phy@2 {
> +		reg = <2>;
> +		max-speed = <100>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	ledgpio: max7320@5d {	/* board LED */
> +		status = "okay";
> +		compatible = "maxim,max7320";
> +		reg = <0x5d>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <16>;
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "okay";
> +	spi-max-frequency = <100000000>;
> +
> +	spi_flash: spiflash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor", "spi-flash", "s25fl256s1";
> +		spi-max-frequency = <100000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +/* Since the gem0 clock is configured EMIO this dummy entry is needed */
> +&clkc {
> +	clocks = <&clkc 16>;
> +	clock-names = "gem0_emio_clk";
> +};
> diff --git a/arch/arm/dts/zynq-brcp170-u-boot.dtsi b/arch/arm/dts/zynq-brcp170-u-boot.dtsi
> new file mode 100644
> index 0000000000..73c49a7c54
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp170-u-boot.dtsi
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +#include <config.h>
> +
> +&i2c0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	bootph-all;
> +	spi_flash: spiflash@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +/ {
> +	binman {
> +		bootph-all;
> +		filename = "flash.bin";
> +		pad-byte = <0xff>;
> +		align-size = <16>;
> +		align = <16>;
> +
> +		blob@0 {
> +			filename = "spl/boot.bin";
> +			offset = <0x0>;
> +		};
> +
> +		fit {
> +			description = "U-Boot BR Zynq boards";
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot BR Zynq";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "DTB BR Zynq";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "BR Zynq";
> +					firmware = "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +
> +		blob-ext@0 {
> +			filename = "blobs/cfg.img";
> +			offset = <0xC0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@5 {
> +			filename = "blobs/cfg_opt.img";
> +			offset = <0xD0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@1 {
> +			bootph-all;
> +			filename = "blobs/bitstream.bit";
> +			offset = <0x100000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@2 {
> +			filename = "blobs/bootar.itb";
> +			offset = <0x900000>;
> +			size = <0x600000>;
> +			optional;
> +		};
> +
> +		blob-ext@3 {
> +			filename = "blobs/dtb.bin";
> +			offset = <0xF00000>;
> +			size = <0x100000>;
> +			optional;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brcp170.dts b/arch/arm/dts/zynq-brcp170.dts
> new file mode 100644
> index 0000000000..52a1375dc5
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp170.dts
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "BRCP170 CPU";
> +	compatible = "xlnx,zynq-7000",
> +		     "br,cp170";
> +
> +	aliases {
> +		ethernet0 = &gem0;
> +		i2c0 = &i2c0;
> +		serial0 = &uart0;
> +		spi0 = &qspi;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyPS0,115200 earlyprintk";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		re_green {
> +			label = "R_E_GREEN";
> +			gpios = <&ledgpio 0 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		re_red {
> +			label = "R_E_RED";
> +			gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		rdy_f_red {
> +			label = "RDY_F_RED";
> +			gpios = <&ledgpio 2 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		rdy_f_yellow {
> +			label = "RDY_F_YELLOW";
> +			gpios = <&ledgpio 3 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		se_green {
> +			label = "S_E_GREEN";
> +			gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		se_red {
> +			label = "S_E_RED";
> +			gpios = <&ledgpio 5 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		plk_se_green {
> +			label = "PLK_S_E_GREEN";
> +			gpios = <&ledgpio 6 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +		eth_se_green {
> +			label = "ETH_S_E_GREEN";
> +			gpios = <&ledgpio 7 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&amba {
> +	ocm: sram@fffc0000 {
> +		compatible = "mmio-sram";
> +		reg = <0xfffc0000 0x10000>;
> +	};
> +};
> +
> +&clkc {
> +	ps-clk-frequency = <50000000>;
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy: ethernet-phy@0 {
> +		reg = <0>;
> +		max-speed = <100>;
> +		ti,rx-internal-delay = <7>;
> +		ti,tx-internal-delay = <7>;
> +		ti,fifo-depth = <0>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	ledgpio: max7320@58 {	/* board LED */
> +		status = "okay";
> +		compatible = "maxim,max7320";
> +		reg = <0x58>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <8>;
> +	};
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "okay";
> +	spi-max-frequency = <100000000>;
> +
> +	spi_flash: spiflash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor", "spi-flash", "s25fl256s1";
> +		spi-max-frequency = <100000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/zynq-brcp1_1r.dts b/arch/arm/dts/zynq-brcp1_1r.dts
> new file mode 100644
> index 0000000000..c78d5b9cfe
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1_1r.dts
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +#include "zynq-brcp1.dtsi"
> +
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x8000000>;
> +	};
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <7>;
> +		ti,tx-internal-delay = <7>;
> +		ti,fifo-depth = <0>;
> +		max-speed = <1000>;
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brcp1_1r_switch.dts b/arch/arm/dts/zynq-brcp1_1r_switch.dts
> new file mode 100644
> index 0000000000..5006a9333d
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1_1r_switch.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +#include "zynq-brcp1.dtsi"
> +/ {
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x8000000>;
> +	};
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "gmii";
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	fixed-link {
> +		speed = <100>;
> +		full-duplex;
> +	};
> +};
> +
> +/* Since the gem0 clock is configured EMIO this dummy entry is needed */
> +&clkc {
> +	clocks = <&clkc 16>;
> +	clock-names = "gem0_emio_clk";
> +};
> diff --git a/arch/arm/dts/zynq-brcp1_2r.dts b/arch/arm/dts/zynq-brcp1_2r.dts
> new file mode 100644
> index 0000000000..80e43ff93c
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brcp1_2r.dts
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +#include "zynq-brcp1.dtsi"
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy: ethernet-phy@0 {
> +		reg = <0>;
> +		ti,rx-internal-delay = <7>;
> +		ti,tx-internal-delay = <7>;
> +		ti,fifo-depth = <0>;
> +		max-speed = <1000>;
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brsmarc2-u-boot.dtsi b/arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
> new file mode 100644
> index 0000000000..3e1d157abc
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brsmarc2-u-boot.dtsi
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +#include <config.h>
> +
> +&i2c0 {
> +	bootph-all;
> +};
> +
> +&uart0 {
> +	bootph-all;
> +};
> +
> +&qspi {
> +	bootph-all;
> +	spi_flash: spiflash@0 {
> +		bootph-all;
> +	};
> +};
> +
> +&gpio0 {
> +	bootph-all;
> +};
> +
> +&brd_rst {
> +	bootph-all;
> +};
> +
> +/ {
> +	binman {
> +		bootph-all;
> +		filename = "flash.bin";
> +		pad-byte = <0xff>;
> +		align-size = <16>;
> +		align = <16>;
> +
> +		blob@0 {
> +			filename = "spl/boot.bin";
> +			offset = <0x0>;
> +		};
> +
> +		fit {
> +			description = "U-Boot BR Zynq boards";
> +			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
> +
> +			images {
> +				uboot {
> +					description = "U-Boot BR Zynq";
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;
> +					u-boot-nodtb {
> +					};
> +				};
> +
> +				fdt-0 {
> +					description = "DTB BR Zynq";
> +					type = "flat_dt";
> +					arch = "arm";
> +					compression = "none";
> +					u-boot-dtb {
> +					};
> +				};
> +			};
> +
> +			configurations {
> +				default = "conf-0";
> +
> +				conf-0 {
> +					description = "BR Zynq";
> +					firmware = "uboot";
> +					fdt = "fdt-0";
> +				};
> +			};
> +		};
> +
> +		blob-ext@0 {
> +			filename = "blobs/cfg.img";
> +			offset = <0xC0000>;
> +			size = <0x10000>;
> +			optional;
> +		};
> +
> +		blob-ext@1 {
> +			bootph-all;
> +			filename = "blobs/bitstream.bit";
> +			offset = <0x100000>;
> +			size = <0x200000>;
> +			optional;
> +		};
> +
> +		blob-ext@2 {
> +			filename = "blobs/bootar.itb";
> +			offset = <0x900000>;
> +			size = <0x600000>;
> +			optional;
> +		};
> +
> +		blob-ext@3 {
> +			filename = "blobs/dtb.bin";
> +			offset = <0xF00000>;
> +			size = <0x100000>;
> +			optional;
> +		};
> +	};
> +};
> diff --git a/arch/arm/dts/zynq-brsmarc2.dts b/arch/arm/dts/zynq-brsmarc2.dts
> new file mode 100644
> index 0000000000..4a80e62015
> --- /dev/null
> +++ b/arch/arm/dts/zynq-brsmarc2.dts
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2024 B&R Industrial Automation GmbH
> + */
> +
> +/dts-v1/;
> +/include/ "zynq-7000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "BRSMARC2 CPU";
> +	compatible = "xlnx,zynq-7000",
> +		     "br,smarc2";
> +
> +	aliases {
> +		ethernet0 = &gem0;
> +		ethernet1 = &gem1;
> +		i2c0 = &i2c0;
> +		serial0 = &uart0;
> +		spi0 = &qspi;
> +		mmc0 = &sdhci0;
> +		can0 = &can0;
> +		can1 = &can1;
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x0 0x10000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyPS0,115200 earlyprintk";
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	usb_phy0: phy0 {
> +		compatible = "usb-nop-xceiv";
> +		#phy-cells = <0>;
> +	};
> +
> +	brd_rst: board_reset {
> +		compatible = "br,board-reset";
> +		pin = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		plk_se_green {
> +			label = "PLK_S_E_GREEN";
> +			gpios = <&ledgpio 0 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		plk_se_red {
> +			label = "PLK_S_E_RED";
> +			gpios = <&ledgpio 1 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		rdy_f_yellow {
> +			label = "RDY_F_YELLOW";
> +			gpios = <&ledgpio 2 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_green {
> +			label = "R_E_GREEN";
> +			gpios = <&ledgpio 3 GPIO_ACTIVE_LOW>;
> +			default-state = "off";
> +		};
> +		re_red {
> +			label = "R_E_RED";
> +			gpios = <&ledgpio 4 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&amba {
> +	ocm: sram@fffc0000 {
> +		compatible = "mmio-sram";
> +		reg = <0xfffc0000 0x10000>;
> +	};
> +};
> +
> +&clkc {
> +	ps-clk-frequency = <33333333>;
> +};
> +
> +&gem0 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy0>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy0: ethernet-phy@1 {
> +		ti,ledcr = <0x0480>;
> +		ti,rgmii-rxclk-shift;
> +		reg = <1>;
> +	};
> +};
> +
> +&gem1 {
> +	status = "okay";
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethernet_phy1>;
> +	mac-address = [ 00 00 00 00 00 00 ];
> +
> +	ethernet_phy1: ethernet-phy@3{
> +		ti,ledcr = <0x0480>;
> +		reg = <3>;
> +	};
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +
> +	resetc: rststm@60 {	/* reset controller */
> +		compatible = "bur,rststm";
> +		reg = <0x60>;
> +		hit-gpios = <&gpio0 84 GPIO_ACTIVE_HIGH>;
> +		cooling-min-state = <0>;
> +		cooling-max-state = <1>;	/* reset gets fired */
> +		#cooling-cells = <2>;		/* min followed by max */
> +	};
> +
> +	ledgpio: max7320@5d {	/* board LED */
> +		status = "okay";
> +		compatible = "maxim,max7320";
> +		reg = <0x5d>;
> +		#gpio-cells = <2>;
> +		gpio-controller;
> +		ngpios = <8>;
> +	};
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +};
> +
> +&sdhci0 {
> +	status = "okay";
> +	max-frequency = <25000000>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&qspi {
> +	status = "okay";
> +	spi-max-frequency = <100000000>;
> +
> +	spi_flash: spiflash@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "jedec,spi-nor", "spi-flash", "s25fl256s1";
> +		spi-max-frequency = <100000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +	usb-phy = <&usb_phy0>;
> +};
> diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
> index 265e9ce588..db20f11323 100644
> --- a/arch/arm/mach-zynq/Kconfig
> +++ b/arch/arm/mach-zynq/Kconfig
> @@ -61,5 +61,6 @@ config ZYNQ_SDHCI_MAX_FREQ
>   
>   source "board/xilinx/Kconfig"
>   source "board/xilinx/zynq/Kconfig"
> +source "board/BuR/zynq/Kconfig"
>   
>   endif
> diff --git a/board/BuR/zynq/Kconfig b/board/BuR/zynq/Kconfig
> new file mode 100644
> index 0000000000..dae22b9e58
> --- /dev/null
> +++ b/board/BuR/zynq/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# B&R Industrial Automation GmbH - http://www.br-automation.com
> +
> +if ARCH_ZYNQ
> +
> +config TARGET_ZYNQ_BR
> +	bool "Support BR Zynq builds"
> +	depends on SYS_VENDOR = "BuR"
> +	select BINMAN
> +	select SPL_BINMAN_FDT
> +
> +endif
> diff --git a/board/BuR/zynq/MAINTAINERS b/board/BuR/zynq/MAINTAINERS
> new file mode 100644
> index 0000000000..79b5f0a877
> --- /dev/null
> +++ b/board/BuR/zynq/MAINTAINERS
> @@ -0,0 +1,13 @@
> +ZYNQ BOARD
> +M:	Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> +S:	Maintained
> +F:	board/BuR/zynq/
> +F:	board/BuR/common/
> +F:	include/configs/brzynq.h
> +F:      arch/arm/dts/zynq-br*

alignment.


> +F:	configs/brcp1_1r_defconfig
> +F:	configs/brcp1_1r_switch_defconfig
> +F:	configs/brcp1_2r_defconfig
> +F:	configs/brcp150_defconfig
> +F:	configs/brcp170_defconfig
> +F:	configs/brsmarc2_defconfig

Regular expression?

> diff --git a/board/BuR/zynq/Makefile b/board/BuR/zynq/Makefile
> new file mode 100644
> index 0000000000..fed40b0a06
> --- /dev/null
> +++ b/board/BuR/zynq/Makefile
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier:	GPL-2.0+
> +#
> +# B&R Industrial Automation GmbH - http://www.br-automation.com
> +
> +hw-platform-y :=$(shell echo $(CONFIG_DEFAULT_DEVICE_TREE) | sed -e 's/zynq-//')
> +
> +obj-y := ../common/common.o
> +obj-y += ../common/br_resetc.o
> +obj-y += common/board.o
> +obj-y += $(hw-platform-y)/board.o
> +
> +obj-$(CONFIG_SPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o
> +
> +# Suppress "warning: function declaration isn't a prototype"
> +CFLAGS_REMOVE_ps7_init_gpl.o := -Wstrict-prototypes
> diff --git a/board/BuR/zynq/brcp150/board.c b/board/BuR/zynq/brcp150/board.c
> new file mode 100644
> index 0000000000..45db60ce0b
> --- /dev/null
> +++ b/board/BuR/zynq/brcp150/board.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *

remove line above

> + * B&R Industrial Automation GmbH - http://www.br-automation.com
> + *

ditto

> + */
> diff --git a/board/BuR/zynq/brcp150/ps7_init_gpl.c b/board/BuR/zynq/brcp150/ps7_init_gpl.c
> new file mode 100644
> index 0000000000..2f536b2733
> --- /dev/null
> +++ b/board/BuR/zynq/brcp150/ps7_init_gpl.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <asm/arch/ps7_init_gpl.h>
> +
> +unsigned long ps7_pll_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000110, 0x003FFFF0U, 0x001772C0U),
> +	EMIT_MASKWRITE(0XF8000100, 0x0007F000U, 0x0001A000U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
> +	EMIT_MASKWRITE(0XF8000114, 0x003FFFF0U, 0x001DB2C0U),
> +	EMIT_MASKWRITE(0XF8000104, 0x0007F000U, 0x00015000U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000002U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
> +	EMIT_MASKWRITE(0XF8000118, 0x003FFFF0U, 0x0012C220U),
> +	EMIT_MASKWRITE(0XF8000108, 0x0007F000U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000004U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +

remove line above and the same below.

> +};
> +
> +unsigned long ps7_clock_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000128, 0x03F03F01U, 0x00203401U),
> +	EMIT_MASKWRITE(0XF8000138, 0x00000011U, 0x00000011U),
> +	EMIT_MASKWRITE(0XF8000140, 0x03F03F71U, 0x00500141U),
> +	EMIT_MASKWRITE(0XF800014C, 0x00003F31U, 0x00000801U),
> +	EMIT_MASKWRITE(0XF8000150, 0x00003F33U, 0x00001001U),
> +	EMIT_MASKWRITE(0XF8000154, 0x00003F33U, 0x00001003U),
> +	EMIT_MASKWRITE(0XF8000158, 0x00003F33U, 0x00000802U),
> +	EMIT_MASKWRITE(0XF800015C, 0x03F03F33U, 0x00A01403U),
> +	EMIT_MASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000168, 0x00003F31U, 0x00000801U),
> +	EMIT_MASKWRITE(0XF8000170, 0x03F03F30U, 0x00400800U),
> +	EMIT_MASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01FF844DU),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_ddr_init_data_3_0[] = {
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006004, 0x0007FFFFU, 0x0000103FU),
> +	EMIT_MASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
> +	EMIT_MASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
> +	EMIT_MASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
> +	EMIT_MASKWRITE(0XF8006014, 0x001FFFFFU, 0x00042E1AU),
> +	EMIT_MASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D154D4U),
> +	EMIT_MASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
> +	EMIT_MASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
> +	EMIT_MASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
> +	EMIT_MASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
> +	EMIT_MASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
> +	EMIT_MASKWRITE(0XF8006034, 0x13FF3FFFU, 0x00011674U),
> +	EMIT_MASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000777U),
> +	EMIT_MASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFF00000U),
> +	EMIT_MASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0F666666U),
> +	EMIT_MASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
> +	EMIT_MASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
> +	EMIT_MASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
> +	EMIT_MASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
> +	EMIT_MASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
> +	EMIT_MASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
> +	EMIT_MASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
> +	EMIT_MASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
> +	EMIT_MASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
> +	EMIT_MASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0670C845U),
> +	EMIT_MASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
> +	EMIT_MASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
> +	EMIT_MASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
> +	EMIT_MASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
> +	EMIT_MASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
> +	EMIT_MASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
> +	EMIT_MASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C000U),
> +	EMIT_MASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
> +	EMIT_MASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
> +	EMIT_MASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
> +	EMIT_MASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
> +	EMIT_MASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
> +	EMIT_MASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
> +	EMIT_MASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C5U),
> +	EMIT_MASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
> +	EMIT_MASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
> +	EMIT_MASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
> +	EMIT_MASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
> +	EMIT_MASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
> +	EMIT_MASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
> +	EMIT_MASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
> +	EMIT_MASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
> +	EMIT_MASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
> +	EMIT_MASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A6U),
> +	EMIT_MASKPOLL(0XF8000B74, 0x00002000U),
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000081U),
> +	EMIT_MASKPOLL(0XF8006054, 0x00000007U),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_mio_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
> +	EMIT_MASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000260U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
> +	EMIT_MASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF8000740, 0x00003FFFU, 0x000003E0U),
> +	EMIT_MASKWRITE(0XF8000744, 0x00003FFFU, 0x000003E1U),
> +	EMIT_MASKWRITE(0XF8000748, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF800074C, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000750, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000754, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000758, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF800075C, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000760, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000764, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000768, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF800076C, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000321U),
> +	EMIT_MASKWRITE(0XF80007BC, 0x00003FFFU, 0x00001220U),
> +	EMIT_MASKWRITE(0XF80007C0, 0x00003FFFU, 0x00001220U),
> +	EMIT_MASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000321U),
> +	EMIT_MASKWRITE(0XF80007C8, 0x00003FFFU, 0x000013E1U),
> +	EMIT_MASKWRITE(0XF80007CC, 0x00003FFFU, 0x000003E0U),
> +	EMIT_MASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_peripherals_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000180U, 0x00000180U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_MASKWRITE(0XE0001034, 0x000000FFU, 0x00000006U),
> +	EMIT_MASKWRITE(0XE0001018, 0x0000FFFFU, 0x0000007CU),
> +	EMIT_MASKWRITE(0XE0001000, 0x000001FFU, 0x00000017U),
> +	EMIT_MASKWRITE(0XE0001004, 0x000003FFU, 0x00000020U),
> +	EMIT_MASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
> +	EMIT_MASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
> +	EMIT_MASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
> +	EMIT_MASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
> +	EMIT_MASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
> +	EMIT_MASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_post_config_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
> +	EMIT_MASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +int ps7_post_config(void)
> +{
> +	return ps7_config(ps7_post_config_3_0);
> +}
> +
> +int ps7_init(void)
> +{
> +	int ret;
> +
> +	ret = ps7_config(ps7_mio_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_pll_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_clock_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_ddr_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_peripherals_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	return PS7_INIT_SUCCESS;
> +}
> diff --git a/board/BuR/zynq/brcp170/board.c b/board/BuR/zynq/brcp170/board.c
> new file mode 100644
> index 0000000000..45db60ce0b
> --- /dev/null
> +++ b/board/BuR/zynq/brcp170/board.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *
> + * B&R Industrial Automation GmbH - http://www.br-automation.com
> + *
> + */
> diff --git a/board/BuR/zynq/brcp170/ps7_init_gpl.c b/board/BuR/zynq/brcp170/ps7_init_gpl.c
> new file mode 100644
> index 0000000000..533d332bb5
> --- /dev/null
> +++ b/board/BuR/zynq/brcp170/ps7_init_gpl.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <asm/arch/ps7_init_gpl.h>
> +
> +unsigned long ps7_pll_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000110, 0x003FFFF0U, 0x001772C0U),
> +	EMIT_MASKWRITE(0XF8000100, 0x0007F000U, 0x0001A000U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
> +	EMIT_MASKWRITE(0XF8000114, 0x003FFFF0U, 0x001DB2C0U),
> +	EMIT_MASKWRITE(0XF8000104, 0x0007F000U, 0x00015000U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000002U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
> +	EMIT_MASKWRITE(0XF8000118, 0x003FFFF0U, 0x001F42C0U),
> +	EMIT_MASKWRITE(0XF8000108, 0x0007F000U, 0x00014000U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000004U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_clock_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000128, 0x03F03F01U, 0x00203401U),
> +	EMIT_MASKWRITE(0XF8000138, 0x00000011U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000140, 0x03F03F71U, 0x00100801U),
> +	EMIT_MASKWRITE(0XF800014C, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0XF8000150, 0x00003F33U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000154, 0x00003F33U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000158, 0x00003F33U, 0x00000502U),
> +	EMIT_MASKWRITE(0XF800015C, 0x03F03F33U, 0x00501903U),
> +	EMIT_MASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000168, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0XF8000170, 0x03F03F30U, 0x00400500U),
> +	EMIT_MASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DF844DU),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_ddr_init_data_3_0[] = {
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006004, 0x0007FFFFU, 0x0000103FU),
> +	EMIT_MASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
> +	EMIT_MASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
> +	EMIT_MASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
> +	EMIT_MASKWRITE(0XF8006014, 0x001FFFFFU, 0x00042E1AU),
> +	EMIT_MASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D154D4U),
> +	EMIT_MASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
> +	EMIT_MASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
> +	EMIT_MASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
> +	EMIT_MASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
> +	EMIT_MASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
> +	EMIT_MASKWRITE(0XF8006034, 0x13FF3FFFU, 0x00011674U),
> +	EMIT_MASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000777U),
> +	EMIT_MASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFF00000U),
> +	EMIT_MASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0F666666U),
> +	EMIT_MASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
> +	EMIT_MASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
> +	EMIT_MASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
> +	EMIT_MASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
> +	EMIT_MASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
> +	EMIT_MASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
> +	EMIT_MASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
> +	EMIT_MASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
> +	EMIT_MASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
> +	EMIT_MASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0670C845U),
> +	EMIT_MASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
> +	EMIT_MASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
> +	EMIT_MASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
> +	EMIT_MASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
> +	EMIT_MASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
> +	EMIT_MASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
> +	EMIT_MASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C000U),
> +	EMIT_MASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
> +	EMIT_MASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
> +	EMIT_MASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
> +	EMIT_MASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
> +	EMIT_MASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
> +	EMIT_MASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
> +	EMIT_MASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C5U),
> +	EMIT_MASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
> +	EMIT_MASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
> +	EMIT_MASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
> +	EMIT_MASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
> +	EMIT_MASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
> +	EMIT_MASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
> +	EMIT_MASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
> +	EMIT_MASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
> +	EMIT_MASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
> +	EMIT_MASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A6U),
> +	EMIT_MASKPOLL(0XF8000B74, 0x00002000U),
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000081U),
> +	EMIT_MASKPOLL(0XF8006054, 0x00000007U),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_mio_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
> +	EMIT_MASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000260U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
> +	EMIT_MASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF8000740, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000744, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000748, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF800074C, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000750, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000754, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000758, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF800075C, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000760, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000764, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000768, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF800076C, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000321U),
> +	EMIT_MASKWRITE(0XF80007BC, 0x00003FFFU, 0x00001220U),
> +	EMIT_MASKWRITE(0XF80007C0, 0x00003FFFU, 0x00001220U),
> +	EMIT_MASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000321U),
> +	EMIT_MASKWRITE(0XF80007C8, 0x00003FFFU, 0x000013E1U),
> +	EMIT_MASKWRITE(0XF80007CC, 0x00003FFFU, 0x000003E0U),
> +	EMIT_MASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_peripherals_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000180U, 0x00000180U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_MASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
> +	EMIT_MASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
> +	EMIT_MASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
> +	EMIT_MASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
> +	EMIT_MASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
> +	EMIT_MASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_post_config_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
> +	EMIT_MASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +int ps7_post_config(void)
> +{
> +	return ps7_config(ps7_post_config_3_0);
> +}
> +
> +int ps7_init(void)
> +{
> +	int ret;
> +
> +	ret = ps7_config(ps7_mio_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_pll_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_clock_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_ddr_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_peripherals_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	return PS7_INIT_SUCCESS;
> +}
> diff --git a/board/BuR/zynq/brcp1_1r/board.c b/board/BuR/zynq/brcp1_1r/board.c
> new file mode 100644
> index 0000000000..45db60ce0b
> --- /dev/null
> +++ b/board/BuR/zynq/brcp1_1r/board.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *
> + * B&R Industrial Automation GmbH - http://www.br-automation.com
> + *
> + */
> diff --git a/board/BuR/zynq/brcp1_1r/ps7_init_gpl.c b/board/BuR/zynq/brcp1_1r/ps7_init_gpl.c
> new file mode 100644
> index 0000000000..5293775d3f
> --- /dev/null
> +++ b/board/BuR/zynq/brcp1_1r/ps7_init_gpl.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <asm/arch/ps7_init_gpl.h>
> +
> +unsigned long ps7_pll_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000110, 0x003FFFF0U, 0x000FA240U),
> +	EMIT_MASKWRITE(0XF8000100, 0x0007F000U, 0x0003C000U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000300U),
> +	EMIT_MASKWRITE(0XF8000114, 0x003FFFF0U, 0x0012C220U),
> +	EMIT_MASKWRITE(0XF8000104, 0x0007F000U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000002U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
> +	EMIT_MASKWRITE(0XF8000118, 0x003FFFF0U, 0x000FA240U),
> +	EMIT_MASKWRITE(0XF8000108, 0x0007F000U, 0x0003C000U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000004U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_clock_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000128, 0x03F03F01U, 0x00700F01U),
> +	EMIT_MASKWRITE(0XF8000138, 0x00000011U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000140, 0x03F03F71U, 0x00101001U),
> +	EMIT_MASKWRITE(0XF800014C, 0x00003F31U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000150, 0x00003F33U, 0x00001401U),
> +	EMIT_MASKWRITE(0XF8000154, 0x00003F33U, 0x00001401U),
> +	EMIT_MASKWRITE(0XF8000158, 0x00003F33U, 0x00000A02U),
> +	EMIT_MASKWRITE(0XF800015C, 0x03F03F33U, 0x00A01901U),
> +	EMIT_MASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000168, 0x00003F31U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000170, 0x03F03F30U, 0x00500800U),
> +	EMIT_MASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DD844DU),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_ddr_init_data_3_0[] = {
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000084U),
> +	EMIT_MASKWRITE(0XF8006004, 0x0007FFFFU, 0x00001040U),
> +	EMIT_MASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
> +	EMIT_MASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
> +	EMIT_MASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
> +	EMIT_MASKWRITE(0XF8006014, 0x001FFFFFU, 0x00040EDAU),
> +	EMIT_MASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D258D4U),
> +	EMIT_MASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
> +	EMIT_MASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
> +	EMIT_MASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
> +	EMIT_MASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
> +	EMIT_MASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
> +	EMIT_MASKWRITE(0XF8006034, 0x13FF3FFFU, 0x000116D4U),
> +	EMIT_MASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000666U),
> +	EMIT_MASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFFF0000U),
> +	EMIT_MASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0FFF5555U),
> +	EMIT_MASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
> +	EMIT_MASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
> +	EMIT_MASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
> +	EMIT_MASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
> +	EMIT_MASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
> +	EMIT_MASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
> +	EMIT_MASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
> +	EMIT_MASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
> +	EMIT_MASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
> +	EMIT_MASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0690CB73U),
> +	EMIT_MASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
> +	EMIT_MASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
> +	EMIT_MASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
> +	EMIT_MASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
> +	EMIT_MASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
> +	EMIT_MASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000000U),
> +	EMIT_MASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000000U),
> +	EMIT_MASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
> +	EMIT_MASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C400U),
> +	EMIT_MASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
> +	EMIT_MASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
> +	EMIT_MASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
> +	EMIT_MASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
> +	EMIT_MASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
> +	EMIT_MASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
> +	EMIT_MASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C6U),
> +	EMIT_MASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
> +	EMIT_MASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
> +	EMIT_MASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
> +	EMIT_MASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
> +	EMIT_MASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
> +	EMIT_MASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
> +	EMIT_MASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
> +	EMIT_MASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
> +	EMIT_MASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
> +	EMIT_MASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A8U),
> +	EMIT_MASKPOLL(0XF8000B74, 0x00002000U),
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000085U),
> +	EMIT_MASKPOLL(0XF8006054, 0x00000007U),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_mio_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000800U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000800U),
> +	EMIT_MASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
> +	EMIT_MASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000220U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
> +	EMIT_MASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF8000740, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000744, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000748, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF800074C, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000750, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000754, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000758, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF800075C, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000760, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000764, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000768, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF800076C, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000361U),
> +	EMIT_MASKWRITE(0XF80007BC, 0x00003FFFU, 0x00000360U),
> +	EMIT_MASKWRITE(0XF80007C0, 0x00003FFFU, 0x00000361U),
> +	EMIT_MASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000361U),
> +	EMIT_MASKWRITE(0XF80007C8, 0x00003FFFU, 0x000012E1U),
> +	EMIT_MASKWRITE(0XF80007CC, 0x00003FFFU, 0x000002E0U),
> +	EMIT_MASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_peripherals_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000180U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000180U, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_MASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
> +	EMIT_MASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
> +	EMIT_MASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
> +	EMIT_MASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
> +	EMIT_MASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
> +	EMIT_MASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_post_config_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
> +	EMIT_MASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +int ps7_post_config(void)
> +{
> +	return ps7_config(ps7_post_config_3_0);
> +}
> +
> +int ps7_init(void)
> +{
> +	int ret;
> +
> +	ret = ps7_config(ps7_mio_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_pll_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_clock_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_ddr_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_peripherals_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	return PS7_INIT_SUCCESS;
> +}
> diff --git a/board/BuR/zynq/brcp1_1r_switch/board.c b/board/BuR/zynq/brcp1_1r_switch/board.c
> new file mode 100644
> index 0000000000..45db60ce0b
> --- /dev/null
> +++ b/board/BuR/zynq/brcp1_1r_switch/board.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *
> + * B&R Industrial Automation GmbH - http://www.br-automation.com
> + *
> + */
> diff --git a/board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c b/board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c
> new file mode 100644
> index 0000000000..4ee388be20
> --- /dev/null
> +++ b/board/BuR/zynq/brcp1_1r_switch/ps7_init_gpl.c
> @@ -0,0 +1,276 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <asm/arch/ps7_init_gpl.h>
> +
> +unsigned long ps7_pll_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000110, 0x003FFFF0U, 0x000FA220U),
> +	EMIT_MASKWRITE(0XF8000100, 0x0007F000U, 0x00028000U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
> +	EMIT_MASKWRITE(0XF8000114, 0x003FFFF0U, 0x0012C220U),
> +	EMIT_MASKWRITE(0XF8000104, 0x0007F000U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000002U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
> +	EMIT_MASKWRITE(0XF8000118, 0x003FFFF0U, 0x001452C0U),
> +	EMIT_MASKWRITE(0XF8000108, 0x0007F000U, 0x0001E000U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000004U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_clock_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000128, 0x03F03F01U, 0x00700F01U),
> +	EMIT_MASKWRITE(0XF8000138, 0x00000011U, 0x00000011U),
> +	EMIT_MASKWRITE(0XF800013C, 0x00000011U, 0x00000011U),
> +	EMIT_MASKWRITE(0XF8000140, 0x03F03F71U, 0x00500141U),
> +	EMIT_MASKWRITE(0XF8000144, 0x03F03F71U, 0x00500141U),
> +	EMIT_MASKWRITE(0XF800014C, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0XF8000150, 0x00003F33U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000154, 0x00003F33U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000158, 0x00003F33U, 0x00000502U),
> +	EMIT_MASKWRITE(0XF800015C, 0x03F03F33U, 0x00501901U),
> +	EMIT_MASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000168, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0XF8000170, 0x03F03F30U, 0x00400500U),
> +	EMIT_MASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DD84CDU),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_ddr_init_data_3_0[] = {
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000084U),
> +	EMIT_MASKWRITE(0XF8006004, 0x0007FFFFU, 0x00001040U),
> +	EMIT_MASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
> +	EMIT_MASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
> +	EMIT_MASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
> +	EMIT_MASKWRITE(0XF8006014, 0x001FFFFFU, 0x00040EDAU),
> +	EMIT_MASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D258D4U),
> +	EMIT_MASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
> +	EMIT_MASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
> +	EMIT_MASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
> +	EMIT_MASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
> +	EMIT_MASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
> +	EMIT_MASKWRITE(0XF8006034, 0x13FF3FFFU, 0x000116D4U),
> +	EMIT_MASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000666U),
> +	EMIT_MASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFFF0000U),
> +	EMIT_MASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0FFF5555U),
> +	EMIT_MASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
> +	EMIT_MASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
> +	EMIT_MASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
> +	EMIT_MASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
> +	EMIT_MASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
> +	EMIT_MASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
> +	EMIT_MASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
> +	EMIT_MASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
> +	EMIT_MASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
> +	EMIT_MASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0690CB73U),
> +	EMIT_MASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
> +	EMIT_MASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
> +	EMIT_MASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
> +	EMIT_MASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
> +	EMIT_MASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
> +	EMIT_MASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000000U),
> +	EMIT_MASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000000U),
> +	EMIT_MASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
> +	EMIT_MASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C400U),
> +	EMIT_MASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
> +	EMIT_MASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
> +	EMIT_MASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
> +	EMIT_MASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
> +	EMIT_MASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
> +	EMIT_MASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
> +	EMIT_MASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C6U),
> +	EMIT_MASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
> +	EMIT_MASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
> +	EMIT_MASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
> +	EMIT_MASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
> +	EMIT_MASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
> +	EMIT_MASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
> +	EMIT_MASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
> +	EMIT_MASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
> +	EMIT_MASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
> +	EMIT_MASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A8U),
> +	EMIT_MASKPOLL(0XF8000B74, 0x00002000U),
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000085U),
> +	EMIT_MASKPOLL(0XF8006054, 0x00000007U),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_mio_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000800U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000800U),
> +	EMIT_MASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
> +	EMIT_MASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000220U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
> +	EMIT_MASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF8000740, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000744, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000748, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF800074C, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000750, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000754, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000758, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF800075C, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000760, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000764, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000768, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF800076C, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000361U),
> +	EMIT_MASKWRITE(0XF80007BC, 0x00003FFFU, 0x00000360U),
> +	EMIT_MASKWRITE(0XF80007C0, 0x00003FFFU, 0x00000361U),
> +	EMIT_MASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000361U),
> +	EMIT_MASKWRITE(0XF80007C8, 0x00003FFFU, 0x000012E1U),
> +	EMIT_MASKWRITE(0XF80007CC, 0x00003FFFU, 0x000002E0U),
> +	EMIT_MASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000300U),
> +	EMIT_MASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_peripherals_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000180U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000180U, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_MASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
> +	EMIT_MASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
> +	EMIT_MASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
> +	EMIT_MASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
> +	EMIT_MASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
> +	EMIT_MASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_post_config_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
> +	EMIT_MASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +int ps7_post_config(void)
> +{
> +	return ps7_config(ps7_post_config_3_0);
> +}
> +
> +int ps7_init(void)
> +{
> +	int ret;
> +
> +	ret = ps7_config(ps7_mio_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_pll_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_clock_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_ddr_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_peripherals_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	return PS7_INIT_SUCCESS;
> +}
> diff --git a/board/BuR/zynq/brcp1_2r/board.c b/board/BuR/zynq/brcp1_2r/board.c
> new file mode 100644
> index 0000000000..45db60ce0b
> --- /dev/null
> +++ b/board/BuR/zynq/brcp1_2r/board.c
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *
> + * B&R Industrial Automation GmbH - http://www.br-automation.com
> + *
> + */
> diff --git a/board/BuR/zynq/brcp1_2r/ps7_init_gpl.c b/board/BuR/zynq/brcp1_2r/ps7_init_gpl.c
> new file mode 100644
> index 0000000000..69118ac7ac
> --- /dev/null
> +++ b/board/BuR/zynq/brcp1_2r/ps7_init_gpl.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <asm/arch/ps7_init_gpl.h>
> +
> +unsigned long ps7_pll_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000110, 0x003FFFF0U, 0x000FA3C0U),
> +	EMIT_MASKWRITE(0XF8000100, 0x0007F000U, 0x0002E000U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
> +	EMIT_MASKWRITE(0XF8000114, 0x003FFFF0U, 0x0012C220U),
> +	EMIT_MASKWRITE(0XF8000104, 0x0007F000U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000002U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
> +	EMIT_MASKWRITE(0XF8000118, 0x003FFFF0U, 0x001452C0U),
> +	EMIT_MASKWRITE(0XF8000108, 0x0007F000U, 0x0001E000U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000004U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_clock_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000128, 0x03F03F01U, 0x00700F01U),
> +	EMIT_MASKWRITE(0XF8000138, 0x00000011U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000140, 0x03F03F71U, 0x00100801U),
> +	EMIT_MASKWRITE(0XF800014C, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0XF8000150, 0x00003F33U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000154, 0x00003F33U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000158, 0x00003F33U, 0x00000502U),
> +	EMIT_MASKWRITE(0XF800015C, 0x03F03F33U, 0x00501901U),
> +	EMIT_MASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000168, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0XF8000170, 0x03F03F30U, 0x00101400U),
> +	EMIT_MASKWRITE(0XF8000180, 0x03F03F30U, 0x00101400U),
> +	EMIT_MASKWRITE(0XF8000190, 0x03F03F30U, 0x00101400U),
> +	EMIT_MASKWRITE(0XF80001A0, 0x03F03F30U, 0x00101400U),
> +	EMIT_MASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DD844DU),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_ddr_init_data_3_0[] = {
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006004, 0x0007FFFFU, 0x00001040U),
> +	EMIT_MASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
> +	EMIT_MASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
> +	EMIT_MASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
> +	EMIT_MASKWRITE(0XF8006014, 0x001FFFFFU, 0x0004281AU),
> +	EMIT_MASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D258D4U),
> +	EMIT_MASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
> +	EMIT_MASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
> +	EMIT_MASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
> +	EMIT_MASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
> +	EMIT_MASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
> +	EMIT_MASKWRITE(0XF8006034, 0x13FF3FFFU, 0x000116D4U),
> +	EMIT_MASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000777U),
> +	EMIT_MASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFF00000U),
> +	EMIT_MASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0F666666U),
> +	EMIT_MASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
> +	EMIT_MASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
> +	EMIT_MASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
> +	EMIT_MASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
> +	EMIT_MASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
> +	EMIT_MASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
> +	EMIT_MASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
> +	EMIT_MASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
> +	EMIT_MASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
> +	EMIT_MASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0690CB73U),
> +	EMIT_MASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
> +	EMIT_MASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
> +	EMIT_MASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
> +	EMIT_MASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
> +	EMIT_MASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
> +	EMIT_MASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
> +	EMIT_MASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C400U),
> +	EMIT_MASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
> +	EMIT_MASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
> +	EMIT_MASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
> +	EMIT_MASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
> +	EMIT_MASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
> +	EMIT_MASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
> +	EMIT_MASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C6U),
> +	EMIT_MASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
> +	EMIT_MASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
> +	EMIT_MASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
> +	EMIT_MASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
> +	EMIT_MASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
> +	EMIT_MASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
> +	EMIT_MASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
> +	EMIT_MASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
> +	EMIT_MASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
> +	EMIT_MASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A8U),
> +	EMIT_MASKPOLL(0XF8000B74, 0x00002000U),
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000081U),
> +	EMIT_MASKPOLL(0XF8006054, 0x00000007U),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_mio_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
> +	EMIT_MASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000260U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
> +	EMIT_MASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000738, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF800073C, 0x00003FFFU, 0x00000740U),
> +	EMIT_MASKWRITE(0XF8000740, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000744, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000748, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF800074C, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000750, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000754, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000758, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF800075C, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000760, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000764, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000768, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF800076C, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000361U),
> +	EMIT_MASKWRITE(0XF80007BC, 0x00003FFFU, 0x00000360U),
> +	EMIT_MASKWRITE(0XF80007C0, 0x00003FFFU, 0x00000361U),
> +	EMIT_MASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000361U),
> +	EMIT_MASKWRITE(0XF80007C8, 0x00003FFFU, 0x000012E1U),
> +	EMIT_MASKWRITE(0XF80007CC, 0x00003FFFU, 0x000002E0U),
> +	EMIT_MASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_peripherals_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000180U, 0x00000180U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_MASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
> +	EMIT_MASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
> +	EMIT_MASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
> +	EMIT_MASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
> +	EMIT_MASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
> +	EMIT_MASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_post_config_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
> +	EMIT_MASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +int ps7_post_config(void)
> +{
> +	return ps7_config(ps7_post_config_3_0);
> +}
> +
> +int ps7_init(void)
> +{
> +	int ret;
> +
> +	ret = ps7_config(ps7_mio_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_pll_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_clock_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_ddr_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_peripherals_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	return PS7_INIT_SUCCESS;
> +}
> diff --git a/board/BuR/zynq/brsmarc2/board.c b/board/BuR/zynq/brsmarc2/board.c
> new file mode 100644
> index 0000000000..0e66f1fe27
> --- /dev/null
> +++ b/board/BuR/zynq/brsmarc2/board.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *
> + * B&R Industrial Automation GmbH - http://www.br-automation.com
> + *
> + */
> +#include <linux/types.h>
> +#include <i2c.h>
> +#include <init.h>
> +#include "../../common/br_resetc.h"
> +#include "../../common/bur_common.h"
> +
> +int board_boot_key(void)
> +{
> +	unsigned char u8buf = 0;
> +	int rc;
> +
> +	rc = br_resetc_regget(RSTCTRL_ENHSTATUS, &u8buf);
> +	if (rc == 0)
> +		return (u8buf & 0x1);
> +
> +	return 0;
> +}
> +
> +#if defined(CONFIG_SPL_BUILD)
> +int br_board_late_init(void)
> +{
> +	brdefaultip_setup(0, 0x57);
> +
> +	return 0;
> +}
> +#endif
> diff --git a/board/BuR/zynq/brsmarc2/ps7_init_gpl.c b/board/BuR/zynq/brsmarc2/ps7_init_gpl.c
> new file mode 100644
> index 0000000000..f142320ebd
> --- /dev/null
> +++ b/board/BuR/zynq/brsmarc2/ps7_init_gpl.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <asm/arch/ps7_init_gpl.h>
> +
> +unsigned long ps7_pll_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000110, 0x003FFFF0U, 0x000FA220U),
> +	EMIT_MASKWRITE(0XF8000100, 0x0007F000U, 0x00028000U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000100, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000120, 0x1F003F30U, 0x1F000200U),
> +	EMIT_MASKWRITE(0XF8000114, 0x003FFFF0U, 0x0012C220U),
> +	EMIT_MASKWRITE(0XF8000104, 0x0007F000U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000002U),
> +	EMIT_MASKWRITE(0XF8000104, 0x00000010U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000124, 0xFFF00003U, 0x0C200003U),
> +	EMIT_MASKWRITE(0XF8000118, 0x003FFFF0U, 0x001452C0U),
> +	EMIT_MASKWRITE(0XF8000108, 0x0007F000U, 0x0001E000U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000010U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000001U, 0x00000000U),
> +	EMIT_MASKPOLL(0XF800010C, 0x00000004U),
> +	EMIT_MASKWRITE(0XF8000108, 0x00000010U, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_clock_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000128, 0x03F03F01U, 0x00700F01U),
> +	EMIT_MASKWRITE(0XF8000138, 0x00000011U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF800013C, 0x00000011U, 0x00000011U),
> +	EMIT_MASKWRITE(0XF8000140, 0x03F03F71U, 0x00500801U),
> +	EMIT_MASKWRITE(0XF8000144, 0x03F03F71U, 0x00500141U),
> +	EMIT_MASKWRITE(0XF800014C, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0XF8000150, 0x00003F33U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000154, 0x00003F33U, 0x00000A01U),
> +	EMIT_MASKWRITE(0XF8000158, 0x00003F33U, 0x00000503U),
> +	EMIT_MASKWRITE(0XF800015C, 0x03F03F33U, 0x00501903U),
> +	EMIT_MASKWRITE(0XF8000160, 0x007F007FU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8000168, 0x00003F31U, 0x00000501U),
> +	EMIT_MASKWRITE(0XF8000170, 0x03F03F30U, 0x00400500U),
> +	EMIT_MASKWRITE(0XF80001C4, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF800012C, 0x01FFCCCDU, 0x01DFC4CDU),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_ddr_init_data_3_0[] = {
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006004, 0x0007FFFFU, 0x00001040U),
> +	EMIT_MASKWRITE(0XF8006008, 0x03FFFFFFU, 0x03C0780FU),
> +	EMIT_MASKWRITE(0XF800600C, 0x03FFFFFFU, 0x02001001U),
> +	EMIT_MASKWRITE(0XF8006010, 0x03FFFFFFU, 0x00014001U),
> +	EMIT_MASKWRITE(0XF8006014, 0x001FFFFFU, 0x00040EDAU),
> +	EMIT_MASKWRITE(0XF8006018, 0xF7FFFFFFU, 0x44D258D4U),
> +	EMIT_MASKWRITE(0XF800601C, 0xFFFFFFFFU, 0xB2024127U),
> +	EMIT_MASKWRITE(0XF8006020, 0x7FDFFFFCU, 0x2B08B290U),
> +	EMIT_MASKWRITE(0XF8006024, 0x0FFFFFC3U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006028, 0x00003FFFU, 0x00002007U),
> +	EMIT_MASKWRITE(0XF800602C, 0xFFFFFFFFU, 0x00000018U),
> +	EMIT_MASKWRITE(0XF8006030, 0xFFFFFFFFU, 0x00040970U),
> +	EMIT_MASKWRITE(0XF8006034, 0x13FF3FFFU, 0x000116D4U),
> +	EMIT_MASKWRITE(0XF8006038, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800603C, 0x000FFFFFU, 0x00000777U),
> +	EMIT_MASKWRITE(0XF8006040, 0xFFFFFFFFU, 0xFFF00000U),
> +	EMIT_MASKWRITE(0XF8006044, 0x0FFFFFFFU, 0x0FFF6666U),
> +	EMIT_MASKWRITE(0XF8006048, 0x0003F03FU, 0x0003C008U),
> +	EMIT_MASKWRITE(0XF8006050, 0xFF0F8FFFU, 0x77010800U),
> +	EMIT_MASKWRITE(0XF8006058, 0x00010000U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF800605C, 0x0000FFFFU, 0x00005003U),
> +	EMIT_MASKWRITE(0XF8006060, 0x000017FFU, 0x0000003EU),
> +	EMIT_MASKWRITE(0XF8006064, 0x00021FE0U, 0x00020000U),
> +	EMIT_MASKWRITE(0XF8006068, 0x03FFFFFFU, 0x00284545U),
> +	EMIT_MASKWRITE(0XF800606C, 0x0000FFFFU, 0x00001610U),
> +	EMIT_MASKWRITE(0XF8006078, 0x03FFFFFFU, 0x00466111U),
> +	EMIT_MASKWRITE(0XF800607C, 0x000FFFFFU, 0x00032222U),
> +	EMIT_MASKWRITE(0XF80060A4, 0xFFFFFFFFU, 0x10200802U),
> +	EMIT_MASKWRITE(0XF80060A8, 0x0FFFFFFFU, 0x0690CB73U),
> +	EMIT_MASKWRITE(0XF80060AC, 0x000001FFU, 0x000001FEU),
> +	EMIT_MASKWRITE(0XF80060B0, 0x1FFFFFFFU, 0x1CFFFFFFU),
> +	EMIT_MASKWRITE(0XF80060B4, 0x00000200U, 0x00000200U),
> +	EMIT_MASKWRITE(0XF80060B8, 0x01FFFFFFU, 0x0020006AU),
> +	EMIT_MASKWRITE(0XF80060C4, 0x00000003U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060C8, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060DC, 0x00000001U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F0, 0x0000FFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80060F4, 0x0000000FU, 0x00000008U),
> +	EMIT_MASKWRITE(0XF8006114, 0x000000FFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006118, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800611C, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006120, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF8006124, 0x7FFFFFCFU, 0x40000001U),
> +	EMIT_MASKWRITE(0XF800612C, 0x000FFFFFU, 0x0001D400U),
> +	EMIT_MASKWRITE(0XF8006130, 0x000FFFFFU, 0x0001C400U),
> +	EMIT_MASKWRITE(0XF8006134, 0x000FFFFFU, 0x0001BC00U),
> +	EMIT_MASKWRITE(0XF8006138, 0x000FFFFFU, 0x0001C800U),
> +	EMIT_MASKWRITE(0XF8006140, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006144, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006148, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF800614C, 0x000FFFFFU, 0x00000035U),
> +	EMIT_MASKWRITE(0XF8006154, 0x000FFFFFU, 0x0000007AU),
> +	EMIT_MASKWRITE(0XF8006158, 0x000FFFFFU, 0x0000007DU),
> +	EMIT_MASKWRITE(0XF800615C, 0x000FFFFFU, 0x00000080U),
> +	EMIT_MASKWRITE(0XF8006160, 0x000FFFFFU, 0x0000007EU),
> +	EMIT_MASKWRITE(0XF8006168, 0x001FFFFFU, 0x000000CAU),
> +	EMIT_MASKWRITE(0XF800616C, 0x001FFFFFU, 0x000000C6U),
> +	EMIT_MASKWRITE(0XF8006170, 0x001FFFFFU, 0x000000C4U),
> +	EMIT_MASKWRITE(0XF8006174, 0x001FFFFFU, 0x000000C7U),
> +	EMIT_MASKWRITE(0XF800617C, 0x000FFFFFU, 0x000000BAU),
> +	EMIT_MASKWRITE(0XF8006180, 0x000FFFFFU, 0x000000BDU),
> +	EMIT_MASKWRITE(0XF8006184, 0x000FFFFFU, 0x000000C0U),
> +	EMIT_MASKWRITE(0XF8006188, 0x000FFFFFU, 0x000000BEU),
> +	EMIT_MASKWRITE(0XF8006190, 0x6FFFFEFEU, 0x00040080U),
> +	EMIT_MASKWRITE(0XF8006194, 0x000FFFFFU, 0x0001FD04U),
> +	EMIT_MASKWRITE(0XF8006204, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF8006208, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800620C, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006210, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006214, 0x000703FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006218, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF800621C, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006220, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF8006224, 0x000F03FFU, 0x000003FFU),
> +	EMIT_MASKWRITE(0XF80062A8, 0x00000FF5U, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062AC, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_MASKWRITE(0XF80062B0, 0x003FFFFFU, 0x00005125U),
> +	EMIT_MASKWRITE(0XF80062B4, 0x0003FFFFU, 0x000012A8U),
> +	EMIT_MASKPOLL(0XF8000B74, 0x00002000U),
> +	EMIT_MASKWRITE(0XF8006000, 0x0001FFFFU, 0x00000081U),
> +	EMIT_MASKPOLL(0XF8006054, 0x00000007U),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_mio_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B40, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B44, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000FFFU, 0x00000672U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000FFFU, 0x00000674U),
> +	EMIT_MASKWRITE(0XF8000B58, 0x00000FFFU, 0x00000600U),
> +	EMIT_MASKWRITE(0XF8000B5C, 0xFFFFFFFFU, 0x0018C068U),
> +	EMIT_MASKWRITE(0XF8000B60, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B64, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B68, 0xFFFFFFFFU, 0x00F98068U),
> +	EMIT_MASKWRITE(0XF8000B6C, 0x00007FFFU, 0x00000260U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000001U, 0x00000001U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x00000021U, 0x00000020U),
> +	EMIT_MASKWRITE(0XF8000B70, 0x07FEFFFFU, 0x00000823U),
> +	EMIT_MASKWRITE(0XF8000700, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000704, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000708, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800070C, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000710, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000714, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000718, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF800071C, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000720, 0x00003FFFU, 0x00000702U),
> +	EMIT_MASKWRITE(0XF8000724, 0x00003FFFU, 0x00000700U),
> +	EMIT_MASKWRITE(0XF8000728, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF800072C, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000730, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000734, 0x00003FFFU, 0x000007A0U),
> +	EMIT_MASKWRITE(0XF8000738, 0x00003FFFU, 0x000016E1U),
> +	EMIT_MASKWRITE(0XF800073C, 0x00003FFFU, 0x000006E0U),
> +	EMIT_MASKWRITE(0XF8000740, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000744, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000748, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF800074C, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000750, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000754, 0x00003FFFU, 0x00000302U),
> +	EMIT_MASKWRITE(0XF8000758, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF800075C, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000760, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000764, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000768, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF800076C, 0x00003FFFU, 0x00000303U),
> +	EMIT_MASKWRITE(0XF8000770, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000774, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000778, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800077C, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000780, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000784, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000788, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800078C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000790, 0x00003FFFU, 0x00000205U),
> +	EMIT_MASKWRITE(0XF8000794, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF8000798, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF800079C, 0x00003FFFU, 0x00000204U),
> +	EMIT_MASKWRITE(0XF80007A0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007A8, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007AC, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B0, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B4, 0x00003FFFU, 0x00000380U),
> +	EMIT_MASKWRITE(0XF80007B8, 0x00003FFFU, 0x00000321U),
> +	EMIT_MASKWRITE(0XF80007BC, 0x00003FFFU, 0x00000320U),
> +	EMIT_MASKWRITE(0XF80007C0, 0x00003FFFU, 0x00000320U),
> +	EMIT_MASKWRITE(0XF80007C4, 0x00003FFFU, 0x00000321U),
> +	EMIT_MASKWRITE(0XF80007C8, 0x00003FFFU, 0x00000340U),
> +	EMIT_MASKWRITE(0XF80007CC, 0x00003FFFU, 0x00000340U),
> +	EMIT_MASKWRITE(0XF80007D0, 0x00003FFFU, 0x00000280U),
> +	EMIT_MASKWRITE(0XF80007D4, 0x00003FFFU, 0x00000280U),
> +	EMIT_MASKWRITE(0XF8000830, 0x003F003FU, 0x00380037U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_peripherals_init_data_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000B48, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B4C, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B50, 0x00000180U, 0x00000180U),
> +	EMIT_MASKWRITE(0XF8000B54, 0x00000180U, 0x00000180U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_MASKWRITE(0XE0000034, 0x000000FFU, 0x00000006U),
> +	EMIT_MASKWRITE(0XE0000018, 0x0000FFFFU, 0x0000007CU),
> +	EMIT_MASKWRITE(0XE0000000, 0x000001FFU, 0x00000017U),
> +	EMIT_MASKWRITE(0XE0000004, 0x000003FFU, 0x00000020U),
> +	EMIT_MASKWRITE(0XE000D000, 0x00080000U, 0x00080000U),
> +	EMIT_MASKWRITE(0XF8007000, 0x20000000U, 0x00000000U),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_MASKDELAY(0XF8F00200, 1),
> +	EMIT_EXIT(),
> +
> +};
> +
> +unsigned long ps7_post_config_3_0[] = {
> +	EMIT_WRITE(0XF8000008, 0x0000DF0DU),
> +	EMIT_MASKWRITE(0XF8000900, 0x0000000FU, 0x0000000FU),
> +	EMIT_MASKWRITE(0XF8000240, 0xFFFFFFFFU, 0x00000000U),
> +	EMIT_WRITE(0XF8000004, 0x0000767BU),
> +	EMIT_EXIT(),
> +
> +};
> +
> +int ps7_post_config(void)
> +{
> +	return ps7_config(ps7_post_config_3_0);
> +}
> +
> +int ps7_init(void)
> +{
> +	int ret;
> +
> +	ret = ps7_config(ps7_mio_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_pll_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_clock_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_ddr_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	ret = ps7_config(ps7_peripherals_init_data_3_0);
> +	if (ret != PS7_INIT_SUCCESS)
> +		return ret;
> +
> +	return PS7_INIT_SUCCESS;
> +}
> diff --git a/board/BuR/zynq/common/board.c b/board/BuR/zynq/common/board.c
> new file mode 100644
> index 0000000000..bdcdff4f54
> --- /dev/null
> +++ b/board/BuR/zynq/common/board.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Board functions for B&R brcp150, brcp170, brcp1, brsmarc2 Board
> + *
> + * B&R Industrial Automation GmbH - http://www.br-automation.com
> + *
> + */
> +
> +#include <fdtdec.h>
> +#include <miiphy.h>
> +#include <netdev.h>
> +#include <asm/arch/sys_proto.h>
> +#include <asm/gpio.h>
> +#include <init.h>
> +#include <i2c.h>
> +#include <dm/uclass.h>
> +#include <command.h>
> +#include <binman.h>
> +#include "../../common/br_resetc.h"
> +#include "../../common/bur_common.h"
> +
> +#include <fdt_support.h>
> +#include <spi_flash.h>
> +#include <fpga.h>
> +#include <zynqpl.h>
> +
> +#define RSTCTRL_CTRLSPEC_nPCIRST		0x01

0x1 or just 1

> +
> +__weak int br_board_late_init(void)

it should be also in header which is not.

> +{
> +	return 0;
> +}
> +
> +#if defined(CONFIG_SPL_BUILD) && CONFIG_IS_ENABLED(FPGA)
> +const char *fpga_paths[2] = { "/binman/blob-ext@4",
> +			      "/binman/blob-ext@1"};
> +
> +static int start_fpga(unsigned int bank)
> +{
> +	struct spi_flash *flash_dev;
> +	void *buf;
> +	ofnode fpga_node;
> +
> +	u32 flash_offset, flash_size;
> +	int rc;
> +
> +	fpga_node = ofnode_path(fpga_paths[bank]);
> +
> +	if (!ofnode_valid(fpga_node)) {
> +		printf("WARN:  binman node not found %s\n", fpga_paths[bank]);
> +		return -ENOENT;
> +	}
> +
> +	flash_offset = ofnode_read_u32_default(fpga_node, "offset", ~0UL);
> +	flash_size = ofnode_read_u32_default(fpga_node, "size", ~0UL);
> +
> +	if (flash_offset == ~0UL || flash_size == ~0UL) {
> +		printf("WARN:  invalid fpga 'offset, size' in fdt (0x%x, 0x%x)",
> +		       flash_offset, flash_size);
> +		return -EINVAL;
> +	}
> +
> +	printf("loading bitstream from bank #%d (0x%08x / 0x%08x)\n", bank,
> +	       flash_offset, flash_size);
> +
> +	flash_dev = spi_flash_probe(CONFIG_ENV_SPI_BUS, CONFIG_ENV_SPI_CS,
> +				    CONFIG_SF_DEFAULT_SPEED, CONFIG_SF_DEFAULT_MODE);
> +
> +	if (rc)  {
> +		printf("WARN:  cannot probe SPI-flash for bitstream!\n");
> +		return -ENODEV;
> +	}
> +
> +	buf = kmalloc(flash_size, 0);
> +	if (!buf) {
> +		spi_flash_free(flash_dev);
> +		return -ENOMEM;
> +	}
> +
> +	debug("using buf @ %p, flashbase: 0x%08x, len: 0x%08x\n",
> +	      buf, flash_offset, flash_size);
> +
> +	rc = spi_flash_read(flash_dev, flash_offset, flash_size, buf);
> +
> +	spi_flash_free(flash_dev);
> +
> +	if (rc) {
> +		printf("WARN:  cannot read bitstream from spi-flash!\n");
> +		kfree(buf);
> +
> +		return -EIO;
> +	}
> +
> +	rc = fpga_loadbitstream(0, buf, flash_size, BIT_FULL);
> +	if (rc) {
> +		printf("WARN:  FPGA configuration from bank #%d failed!\n", bank);
> +		kfree(buf);
> +
> +		return -EIO;
> +	}
> +
> +	kfree(buf);
> +
> +	return 0;
> +}
> +#endif

newline

> +#if defined(CONFIG_SPL_BUILD)
> +
remove line above.

> +const char *boot_gpios[] = { "br,rs232-en",
> +			     "br,board-reset",
> +			     NULL};
> +
> +/* spl stage */
> +int board_init(void)
> +{
> +	int rc = 0;

no need to initialize it.

> +	int node;
> +	struct gpio_desc gpio;

reverse christman tree order please

> +
> +	/* peripheral RESET on PSOC reset-controller */
> +	rc = br_resetc_regset(RSTCTRL_SPECGPIO_O, RSTCTRL_CTRLSPEC_nPCIRST);
> +	if (rc != 0)
> +		printf("ERROR: cannot write to resetc (nPCIRST)!\n");
> +
> +	/* de-assert peripherals reset */
> +	rc = 0;

any reason for it?

> +
> +	for (int i = 0; boot_gpios[i]; i++) {
> +		node = fdt_node_offset_by_compatible(gd->fdt_blob, 0, boot_gpios[i]);
> +
> +		if (node < 0) {
> +			printf("INFO:  %s not found!\n", boot_gpios[i]);
> +		} else {
> +			rc = gpio_request_by_name_nodev(offset_to_ofnode(node), "pin",
> +							0, &gpio, GPIOD_IS_OUT);
> +
> +			if (!rc)
> +				dm_gpio_set_value(&gpio, 1);
> +			else
> +				printf("ERROR: failed to setup %s!\n", boot_gpios[i]);
> +		}
> +	}
> +
> +	rc = 0;
> +
> +#if CONFIG_IS_ENABLED(FPGA)
> +	unsigned int bank;
> +	unsigned int bmode;
> +
> +	rc = br_resetc_bmode_get(&bmode);
> +	if (rc) {
> +		printf("WARN:  can't get Boot Mode!\n");
> +		return -ENODEV;
> +	}
> +
> +	/* use golden FPGA image in case of special boot flow (PME, BootAR, USB, Net ...) */
> +	bank = ((bmode == 0) || (bmode == 12)) ? 1 : 0;
> +
> +	/* bring up FPGA */
> +	if (start_fpga(bank) != 0) {
> +		printf("WARN:  cannot start fpga from bank %d, trying bank %d!\n", bank, bank ^ 1);
> +		bank ^= 1;
> +		start_fpga(bank);
> +	}
> +#endif
> +
> +	if (rc != 0)
> +		printf("ERROR: failed to setup reset gpios!\n");
> +

This whole function looks weird to me. Because in case of error you are just 
continuing with other steps but up2you.

> +	return 0;
> +}
> +#else
> +int board_init(void)
> +{
> +	return 0;
> +}
> +
> +/*
> + * PMIC buckboost regulator workaround:
> + * The DA9062 PMIC can switch its buckboost regulator output
> + * between PFM and PWM mode for eco-purpose.
> + * In very rare situations this transition leads into a non-
> + * functional buckboost regulator with zero output.
> + * With this workaround we prevent this with turning this
> + * feature off by forcing PWM-mode if auto-mode is selected.
> + */
> +static void pmic_fixup(int addr)
> +{
> +	int rc;
> +	struct udevice *i2cdev = NULL;
> +	u8 regs[] = { 0x9E, 0x9D, 0xA0, 0x9F };
> +	u8 val;
> +	unsigned int i;

reverse christmas tree please.

> +
> +	printf("PMIC:  fixup buckboost at i2c device 0x%x\n", addr);

is it useful to see this before you get even i2c bus or do something?

> +	i2c_get_chip_for_busnum(0, addr, 1, &i2cdev);
> +	if (!i2cdev)
> +		return;
> +
> +	for (i = 0; i < sizeof(regs); i++) {
> +		rc = dm_i2c_read(i2cdev, regs[i], &val, 1);
> +		if (rc == 0 && val == 0xC0) {
> +			val = 0x80;
> +			dm_i2c_write(i2cdev, regs[i], &val, 1);
> +		}
> +	}
> +}
> +
> +int board_late_init(void)
> +{
> +	ofnode node;
> +
> +	br_resetc_bmode();
> +	br_board_late_init();
> +	u32 addr;

Move it above.

> +
> +	node = ofnode_by_compatible(ofnode_null(), "dlg,da9062");
> +
> +	if (!ofnode_valid(node))
> +		return 0;
> +
> +	if (!ofnode_read_u32(node, "reg", &addr))
> +		pmic_fixup(addr);
> +	else
> +		printf("WARN:  cannot read PMIC address!");

Isn't it easier to create just driver for it and do basic initialization as the 
part of probe? It should solve the issues with getting i2c bus, etc.

> +
> +	return 0;
> +}
> +#endif
> +
> +int dram_init(void)
> +{
> +	if (fdtdec_setup_mem_size_base() != 0)
> +		return -EINVAL;
> +
> +	zynq_ddrc_init();
> +
> +	return 0;
> +}
> diff --git a/board/BuR/zynq/env/brcp1.env b/board/BuR/zynq/env/brcp1.env
> new file mode 100644
> index 0000000000..1ceb294b4b
> --- /dev/null
> +++ b/board/BuR/zynq/env/brcp1.env
> @@ -0,0 +1,106 @@
> +autoload=0
> +b_break=0
> +fpgastatus=disabled
> +/* Memory variable */
> +scradr=0xC0000
> +fdtbackaddr=0x4000000
> +loadaddr=CONFIG_SYS_LOAD_ADDR
> +
> +/* SPI layout variables */
> +cfg_addr=
> +	fdt get value cfgaddr_spi /binman/blob-ext@0 offset &&
> +	fdt get value cfgsize_spi /binman/blob-ext@0 size
> +
> +fpga_addr=
> +	fdt get value fpgaaddr_spi /binman/blob-ext@1 offset &&
> +	fdt get value fpgasize_spi /binman/blob-ext@1 size
> +
> +os_addr=
> +	fdt get value osaddr_spi /binman/blob-ext@2 offset &&
> +	fdt get value ossize_spi /binman/blob-ext@2 size
> +
> +dtb_addr=
> +	fdt get value dtbaddr_spi /binman/blob-ext@3 offset &&
> +	fdt get value dtbsize_spi /binman/blob-ext@3 size
> +
> +setupaddr_spi=
> +	fdt addr ${fdtcontroladdr};
> +	run dtb_addr; run os_addr;
> +	run fpga_addr; run cfg_addr
> +
> +/* IP setup */
> +brdefaultip=
> +	if test -r ${ipaddr}; then;
> +	else
> +		setenv ipaddr 192.168.60.1; setenv serverip 192.168.60.254;
> +		setenv gatewayip 192.168.60.254; setenv netmask 255.255.255.0;
> +	fi
> +
> +/* Boot orders */
> +b_tgts_std=mmc0 mmc1 spi usb0 usb1 net
> +b_tgts_rcy=spi usb0 usb1 net
> +b_tgts_pme=net usb0 usb1 mmc spi
> +
> +/* Boot targets */
> +b_mmc0=
> +	run fpga; mmc dev 0; load mmc 0 ${loadaddr} arimg.itb &&
> +	run vxargs && bootm ${loadaddr}
> +
> +b_mmc1=
> +	run fpga; mmc dev 0; load mmc 0 ${loadaddr} arimg &&
> +	run vxargs &&
> +	sf read ${fdtbackaddr} ${dtbaddr_spi} ${dtbsize_spi} &&
> +	fdt addr ${fdtbackaddr} &&
> +	bootm ${loadaddr} - ${fdtbackaddr}
> +
> +b_spi=
> +	run fpga; sf read ${loadaddr} ${osaddr_spi} ${ossize_spi} &&
> +	run vxargs && bootm ${loadaddr}
> +
> +b_net=run fpga; tftp ${scradr} netscript.img && source ${scradr}
> +b_usb0=usb start && load usb 0 ${scradr} usbscript.img && source ${scradr}
> +b_usb1=usb start && load usb 0 ${scradr} bootscr.img && source ${scradr}
> +
> +/* FPGA setup */
> +fpga=
> +	setenv fpgastatus disabled;
> +	sf read ${loadaddr} ${fpgaaddr_spi} ${fpgasize_spi} &&
> +	fpga loadb 0 ${loadaddr} ${fpgasize_spi} &&
> +	setenv fpgastatus okay
> +
> +/* Configuration preboot*/
> +cfgscr=
> +	sf probe &&
> +	sf read ${scradr} ${cfgaddr_spi} ${cfgsize_spi} &&
> +	source ${scradr}
> +
> +/* OS Boot */
> +fdt_fixup=
> +	run cfgscr; run vxfdt
> +
> +vxargs=
> +	setenv bootargs gem(0,0)host:vxWorks h=${serverip}
> +	e=${ipaddr}:${netmask} g=${gatewayip} u=vxWorksFTP pw=vxWorks f=0x1
> +
> +vxfdt=
> +	fdt set /fpga/pci status ${fpgastatus};
> +	fdt set /fpga status ${fpgastatus}
> +
> +/* Boot code */
> +b_default=
> +	run b_deftgts;
> +	for target in ${b_tgts}; do
> +		run b_${target};
> +		if test ${b_break} = 1; then;
> +			exit;
> +		fi;
> +	done
> +
> +b_deftgts=
> +	if test ${b_mode} = 12; then
> +		setenv b_tgts ${b_tgts_pme};
> +	elif test ${b_mode} = 0; then
> +		setenv b_tgts ${b_tgts_rcy};
> +	else
> +		setenv b_tgts ${b_tgts_std};
> +	fi
> diff --git a/board/BuR/zynq/env/brcp150.env b/board/BuR/zynq/env/brcp150.env
> new file mode 100644
> index 0000000000..8607263b51
> --- /dev/null
> +++ b/board/BuR/zynq/env/brcp150.env
> @@ -0,0 +1,116 @@
> +autoload=0
> +b_break=0
> +fpgastatus=disabled
> +/* Memory variable */
> +scradr=0xC0000
> +fdtbackaddr=0x4000000
> +loadaddr=CONFIG_SYS_LOAD_ADDR
> +
> +/* SPI layout variables */
> +cfg_addr=
> +	fdt get value cfgaddr_spi /binman/blob-ext@0 offset &&
> +	fdt get value cfgsize_spi /binman/blob-ext@0 size
> +
> +fpga_addr=
> +	fdt get value fpgaaddr_spi /binman/blob-ext@1 offset &&
> +	fdt get value fpgasize_spi /binman/blob-ext@1 size
> +
> +os_addr=
> +	fdt get value osaddr_spi /binman/blob-ext@2 offset &&
> +	fdt get value ossize_spi /binman/blob-ext@2 size
> +
> +dtb_addr=
> +	fdt get value dtbaddr_spi /binman/blob-ext@3 offset &&
> +	fdt get value dtbsize_spi /binman/blob-ext@3 size
> +
> +opt_addr=
> +	fdt get value optaddr_spi /binman/blob-ext@5 offset &&
> +	fdt get value optsize_spi /binman/blob-ext@5 size
> +
> +setupaddr_spi=
> +	fdt addr ${fdtcontroladdr};
> +	run dtb_addr; run os_addr;
> +	run fpga_addr; run cfg_addr;
> +	run opt_addr
> +
> +/* IP setup */
> +brdefaultip=
> +	if test -r ${ipaddr}; then;
> +	else
> +		setenv ipaddr 192.168.60.1; setenv serverip 192.168.60.254;
> +		setenv gatewayip 192.168.60.254; setenv netmask 255.255.255.0;
> +	fi
> +
> +/* Boot orders */
> +b_tgts_std=mmc0 mmc1 fpga spi usb0 usb1 net
> +b_tgts_rcy=spi usb0 usb1 net
> +b_tgts_pme=net usb0 usb1 mmc spi
> +
> +/* Boot targets */
> +b_mmc0=
> +	mmc dev 0; load mmc 0 ${loadaddr} arimg.itb &&
> +	run vxargs && bootm ${loadaddr}
> +
> +b_mmc1=
> +	mmc dev 0; load mmc 0 ${loadaddr} arimg &&
> +	run vxargs &&
> +	sf read ${fdtbackaddr} ${dtbaddr_spi} ${dtbsize_spi} &&
> +	fdt addr ${fdtbackaddr} &&
> +	bootm ${loadaddr} - ${fdtbackaddr}
> +
> +b_spi=
> +	sf read ${loadaddr} ${osaddr_spi} ${ossize_spi} &&
> +	run vxargs && bootm ${loadaddr}
> +
> +b_net=tftp ${scradr} netscript.img && source ${scradr}
> +b_usb0=usb start && load usb 0 ${scradr} usbscript.img && source ${scradr}
> +b_usb1=usb start && load usb 0 ${scradr} bootscr.img && source ${scradr}
> +
> +/* FPGA setup */
> +b_fpga=
> +	setenv fpgastatus disabled;
> +	sf read ${loadaddr} ${fpgaaddr_spi} ${fpgasize_spi} &&
> +	fpga loadb 0 ${loadaddr} ${fpgasize_spi} &&
> +	setenv fpgastatus okay
> +
> +/* Configuration preboot*/
> +cfgscr=
> +	sf probe &&
> +	sf read ${scradr} ${cfgaddr_spi} ${cfgsize_spi} &&
> +	source ${scradr}
> +
> +cfgoptsct=
> +	sf probe &&
> +	sf read ${scradr} ${optaddr_spi} ${optsize_spi} &&
> +	source ${scradr}
> +
> +/* OS Boot */
> +fdt_fixup=
> +	run cfgscr; run cfgoptsct; run vxfdt
> +
> +vxargs=
> +	setenv bootargs gem(0,0)host:vxWorks h=${serverip}
> +	e=${ipaddr}:${netmask} g=${gatewayip} u=vxWorksFTP pw=vxWorks f=0x1
> +
> +vxfdt=
> +	fdt set /fpga/pci status ${fpgastatus};
> +	fdt set /fpga status ${fpgastatus}
> +
> +/* Boot code */
> +b_default=
> +	run b_deftgts;
> +	for target in ${b_tgts}; do
> +		run b_${target};
> +		if test ${b_break} = 1; then;
> +			exit;
> +		fi;
> +	done
> +
> +b_deftgts=
> +	if test ${b_mode} = 12; then
> +		setenv b_tgts ${b_tgts_pme};
> +	elif test ${b_mode} = 0; then
> +		setenv b_tgts ${b_tgts_rcy};
> +	else
> +		setenv b_tgts ${b_tgts_std};
> +	fi
> diff --git a/configs/brcp150_defconfig b/configs/brcp150_defconfig
> new file mode 100644
> index 0000000000..9a2b2b6a3f
> --- /dev/null
> +++ b/configs/brcp150_defconfig
> @@ -0,0 +1,123 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_VENDOR="BuR"
> +CONFIG_SYS_CONFIG_NAME="brzynq"
> +CONFIG_SYS_L2CACHE_OFF=y
> +CONFIG_ARCH_ZYNQ=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_INITRD_TAG=y
> +CONFIG_TEXT_BASE=0x4000000
> +CONFIG_SYS_MALLOC_F_LEN=0x1000
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SOURCE_FILE="env/brcp150"
> +CONFIG_SF_DEFAULT_SPEED=100000000
> +CONFIG_SF_DEFAULT_MODE=0x3
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x20000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="zynq-brcp150"
> +CONFIG_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x10000
> +# CONFIG_SPL_MMC is not set
> +CONFIG_SPL_STACK_R_ADDR=0x800000
> +CONFIG_SPL_STACK=0xFFFFFE00
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x20000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
> +CONFIG_SPL_SIZE_LIMIT=0x20000
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x30000
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +CONFIG_ZYNQ_SDHCI_MAX_FREQ=100000000
> +CONFIG_TARGET_ZYNQ_BR=y
> +CONFIG_SYS_LOAD_ADDR=0x2000000
> +CONFIG_FIT=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x4000000
> +CONFIG_SPL_LOAD_FIT_FULL=y
> +CONFIG_SYS_BOOTM_LEN=0x2000000
> +CONFIG_BOOTDELAY=0
> +CONFIG_OF_ENV_SETUP=y
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="run b_default"
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="run setupaddr_spi; run brdefaultip; run cfgscr; setenv bootstart 1"

don't you have it easier to directly setup preboot as the part of your 
env/brcp150 file?

> +CONFIG_SYS_CBSIZE=512
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_CLOCKS=y
> +CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
> +CONFIG_SPL_CPU=y
> +CONFIG_SPL_FPGA=y
> +CONFIG_SPL_I2C=y
> +# CONFIG_SPL_RAM_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
> +CONFIG_HUSH_PARSER=y
> +CONFIG_HUSH_MODERN_PARSER=y
> +CONFIG_SYS_PROMPT="-> "
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_BOOTP_MAY_FAIL=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_NET_RETRY_COUNT=10
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_FPGA_XILINX=y
> +CONFIG_FPGA_ZYNQPL=y
> +CONFIG_MAX7320_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_CADENCE=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ZYNQ=y
> +CONFIG_ZYNQ_HISPD_BROKEN=y
> +CONFIG_DM_MTD=y
> +CONFIG_SPI_FLASH_ATMEL=y
> +CONFIG_SPI_FLASH_EON=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_ISSI=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_SPI_FLASH_SST=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_SPI_FLASH_DATAFLASH=y

Do you really have all these flashes on your custom board?

> +CONFIG_PHY_TI_GENERIC=y
> +CONFIG_MII=y
> +CONFIG_ZYNQ_GEM=y
> +CONFIG_ZYNQ_SERIAL=y
> +CONFIG_ZYNQ_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_ULPI_VIEWPORT=y
> +CONFIG_USB_ULPI=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +# CONFIG_SHA256 is not set
> +CONFIG_SPL_CRC32=y
> +# CONFIG_SPL_SHA1 is not set
> +# CONFIG_EFI_LOADER is not set
> diff --git a/configs/brcp170_defconfig b/configs/brcp170_defconfig
> new file mode 100644
> index 0000000000..bab0393999
> --- /dev/null
> +++ b/configs/brcp170_defconfig
> @@ -0,0 +1,122 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_VENDOR="BuR"
> +CONFIG_SYS_CONFIG_NAME="brzynq"
> +CONFIG_SYS_L2CACHE_OFF=y
> +CONFIG_ARCH_ZYNQ=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_INITRD_TAG=y
> +CONFIG_TEXT_BASE=0x4000000
> +CONFIG_SYS_MALLOC_F_LEN=0x1000
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SOURCE_FILE="env/brcp1"
> +CONFIG_SF_DEFAULT_SPEED=100000000
> +CONFIG_SF_DEFAULT_MODE=0x3
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x20000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="zynq-brcp170"
> +CONFIG_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x10000
> +# CONFIG_SPL_MMC is not set
> +CONFIG_SPL_STACK_R_ADDR=0x800000
> +CONFIG_SPL_STACK=0xFFFFFE00
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x20000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
> +CONFIG_SPL_SIZE_LIMIT=0x20000
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x30000
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +CONFIG_ZYNQ_SDHCI_MAX_FREQ=100000000
> +CONFIG_TARGET_ZYNQ_BR=y
> +CONFIG_SYS_LOAD_ADDR=0x2000000
> +CONFIG_FIT=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x4000000
> +CONFIG_SPL_LOAD_FIT_FULL=y
> +CONFIG_SYS_BOOTM_LEN=0x2000000
> +CONFIG_BOOTDELAY=0
> +CONFIG_OF_ENV_SETUP=y
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="run b_default"
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="run setupaddr_spi; run brdefaultip; run cfgscr; setenv bootstart 1"
> +CONFIG_SYS_CBSIZE=512
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_CLOCKS=y
> +CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
> +CONFIG_SPL_CPU=y
> +CONFIG_SPL_I2C=y
> +# CONFIG_SPL_RAM_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
> +CONFIG_HUSH_PARSER=y
> +CONFIG_HUSH_MODERN_PARSER=y
> +CONFIG_SYS_PROMPT="-> "
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_BOOTP_MAY_FAIL=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_NET_RETRY_COUNT=10
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_FPGA_XILINX=y
> +CONFIG_FPGA_ZYNQPL=y
> +CONFIG_MAX7320_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_CADENCE=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ZYNQ=y
> +CONFIG_ZYNQ_HISPD_BROKEN=y
> +CONFIG_DM_MTD=y
> +CONFIG_SPI_FLASH_ATMEL=y
> +CONFIG_SPI_FLASH_EON=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_ISSI=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_SPI_FLASH_SST=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_SPI_FLASH_DATAFLASH=y
> +CONFIG_PHY_TI_GENERIC=y
> +CONFIG_MII=y
> +CONFIG_ZYNQ_GEM=y
> +CONFIG_ZYNQ_SERIAL=y
> +CONFIG_ZYNQ_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_ULPI_VIEWPORT=y
> +CONFIG_USB_ULPI=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +# CONFIG_SHA256 is not set
> +CONFIG_SPL_CRC32=y
> +# CONFIG_SPL_SHA1 is not set
> +# CONFIG_EFI_LOADER is not set
> diff --git a/configs/brcp1_1r_defconfig b/configs/brcp1_1r_defconfig
> new file mode 100644
> index 0000000000..f1cdef07f1
> --- /dev/null
> +++ b/configs/brcp1_1r_defconfig
> @@ -0,0 +1,122 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_VENDOR="BuR"
> +CONFIG_SYS_CONFIG_NAME="brzynq"
> +CONFIG_SYS_L2CACHE_OFF=y
> +CONFIG_ARCH_ZYNQ=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_INITRD_TAG=y
> +CONFIG_TEXT_BASE=0x4000000
> +CONFIG_SYS_MALLOC_F_LEN=0x1000
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SOURCE_FILE="env/brcp1"
> +CONFIG_SF_DEFAULT_SPEED=100000000
> +CONFIG_SF_DEFAULT_MODE=0x3
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x20000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="zynq-brcp1_1r"
> +CONFIG_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x10000
> +# CONFIG_SPL_MMC is not set
> +CONFIG_SPL_STACK_R_ADDR=0x800000
> +CONFIG_SPL_STACK=0xFFFFFE00
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x20000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
> +CONFIG_SPL_SIZE_LIMIT=0x20000
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x30000
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +CONFIG_ZYNQ_SDHCI_MAX_FREQ=100000000
> +CONFIG_TARGET_ZYNQ_BR=y
> +CONFIG_SYS_LOAD_ADDR=0x2000000
> +CONFIG_FIT=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x4000000
> +CONFIG_SPL_LOAD_FIT_FULL=y
> +CONFIG_SYS_BOOTM_LEN=0x2000000
> +CONFIG_BOOTDELAY=0
> +CONFIG_OF_ENV_SETUP=y
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="run b_default"
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="run setupaddr_spi; run brdefaultip; run cfgscr; setenv bootstart 1"
> +CONFIG_SYS_CBSIZE=512
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_CLOCKS=y
> +CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
> +CONFIG_SPL_CPU=y
> +CONFIG_SPL_I2C=y
> +# CONFIG_SPL_RAM_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
> +CONFIG_HUSH_PARSER=y
> +CONFIG_HUSH_MODERN_PARSER=y
> +CONFIG_SYS_PROMPT="-> "
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_BOOTP_MAY_FAIL=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_NET_RETRY_COUNT=10
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_FPGA_XILINX=y
> +CONFIG_FPGA_ZYNQPL=y
> +CONFIG_MAX7320_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_CADENCE=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ZYNQ=y
> +CONFIG_ZYNQ_HISPD_BROKEN=y
> +CONFIG_DM_MTD=y
> +CONFIG_SPI_FLASH_ATMEL=y
> +CONFIG_SPI_FLASH_EON=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_ISSI=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_SPI_FLASH_SST=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_SPI_FLASH_DATAFLASH=y
> +CONFIG_PHY_NATSEMI=y
> +CONFIG_MII=y
> +CONFIG_ZYNQ_GEM=y
> +CONFIG_ZYNQ_SERIAL=y
> +CONFIG_ZYNQ_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_ULPI_VIEWPORT=y
> +CONFIG_USB_ULPI=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +# CONFIG_SHA256 is not set
> +CONFIG_SPL_CRC32=y
> +# CONFIG_SPL_SHA1 is not set
> +# CONFIG_EFI_LOADER is not set
> diff --git a/configs/brcp1_1r_switch_defconfig b/configs/brcp1_1r_switch_defconfig
> new file mode 100644
> index 0000000000..a3f9aedc1a
> --- /dev/null
> +++ b/configs/brcp1_1r_switch_defconfig
> @@ -0,0 +1,123 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_VENDOR="BuR"
> +CONFIG_SYS_CONFIG_NAME="brzynq"
> +CONFIG_SYS_L2CACHE_OFF=y
> +CONFIG_ARCH_ZYNQ=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_INITRD_TAG=y
> +CONFIG_TEXT_BASE=0x4000000
> +CONFIG_SYS_MALLOC_F_LEN=0x1000
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SOURCE_FILE="env/brcp1"
> +CONFIG_SF_DEFAULT_SPEED=100000000
> +CONFIG_SF_DEFAULT_MODE=0x3
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x20000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="zynq-brcp1_1r_switch"
> +CONFIG_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x10000
> +# CONFIG_SPL_MMC is not set
> +CONFIG_SPL_STACK_R_ADDR=0x800000
> +CONFIG_SPL_STACK=0xFFFFFE00
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x20000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
> +CONFIG_SPL_SIZE_LIMIT=0x20000
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x30000
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +CONFIG_ZYNQ_SDHCI_MAX_FREQ=100000000
> +CONFIG_TARGET_ZYNQ_BR=y
> +CONFIG_SYS_LOAD_ADDR=0x2000000
> +CONFIG_FIT=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x4000000
> +CONFIG_SPL_LOAD_FIT_FULL=y
> +CONFIG_SYS_BOOTM_LEN=0x2000000
> +CONFIG_BOOTDELAY=0
> +CONFIG_OF_ENV_SETUP=y
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="run b_default"
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="run setupaddr_spi; run brdefaultip; run cfgscr; setenv bootstart 1"
> +CONFIG_SYS_CBSIZE=512
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_CLOCKS=y
> +CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
> +CONFIG_SPL_CPU=y
> +CONFIG_SPL_I2C=y
> +# CONFIG_SPL_RAM_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
> +CONFIG_HUSH_PARSER=y
> +CONFIG_HUSH_MODERN_PARSER=y
> +CONFIG_SYS_PROMPT="-> "
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_BOOTP_MAY_FAIL=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_NET_RETRY_COUNT=10
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_FPGA_XILINX=y
> +CONFIG_FPGA_ZYNQPL=y
> +CONFIG_MAX7320_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_CADENCE=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ZYNQ=y
> +CONFIG_ZYNQ_HISPD_BROKEN=y
> +CONFIG_DM_MTD=y
> +CONFIG_SPI_FLASH_ATMEL=y
> +CONFIG_SPI_FLASH_EON=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_ISSI=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_SPI_FLASH_SST=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_SPI_FLASH_DATAFLASH=y
> +CONFIG_PHY_NATSEMI=y
> +CONFIG_PHY_FIXED=y
> +CONFIG_MII=y
> +CONFIG_ZYNQ_GEM=y
> +CONFIG_ZYNQ_SERIAL=y
> +CONFIG_ZYNQ_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_ULPI_VIEWPORT=y
> +CONFIG_USB_ULPI=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +# CONFIG_SHA256 is not set
> +CONFIG_SPL_CRC32=y
> +# CONFIG_SPL_SHA1 is not set
> +# CONFIG_EFI_LOADER is not set
> diff --git a/configs/brcp1_2r_defconfig b/configs/brcp1_2r_defconfig
> new file mode 100644
> index 0000000000..fcdb3e631d
> --- /dev/null
> +++ b/configs/brcp1_2r_defconfig
> @@ -0,0 +1,122 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_VENDOR="BuR"
> +CONFIG_SYS_CONFIG_NAME="brzynq"
> +CONFIG_SYS_L2CACHE_OFF=y
> +CONFIG_ARCH_ZYNQ=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_INITRD_TAG=y
> +CONFIG_TEXT_BASE=0x4000000
> +CONFIG_SYS_MALLOC_F_LEN=0x1000
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SOURCE_FILE="env/brcp1"
> +CONFIG_SF_DEFAULT_SPEED=100000000
> +CONFIG_SF_DEFAULT_MODE=0x3
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x20000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="zynq-brcp1_2r"
> +CONFIG_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x10000
> +# CONFIG_SPL_MMC is not set
> +CONFIG_SPL_STACK_R_ADDR=0x800000
> +CONFIG_SPL_STACK=0xFFFFFE00
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x20000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
> +CONFIG_SPL_SIZE_LIMIT=0x20000
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x30000
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +CONFIG_ZYNQ_SDHCI_MAX_FREQ=100000000
> +CONFIG_TARGET_ZYNQ_BR=y
> +CONFIG_SYS_LOAD_ADDR=0x2000000
> +CONFIG_FIT=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x4000000
> +CONFIG_SPL_LOAD_FIT_FULL=y
> +CONFIG_SYS_BOOTM_LEN=0x2000000
> +CONFIG_BOOTDELAY=0
> +CONFIG_OF_ENV_SETUP=y
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="run b_default"
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="run setupaddr_spi; run brdefaultip; run cfgscr; setenv bootstart 1"
> +CONFIG_SYS_CBSIZE=512
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_CLOCKS=y
> +CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
> +CONFIG_SPL_CPU=y
> +CONFIG_SPL_I2C=y
> +# CONFIG_SPL_RAM_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
> +CONFIG_HUSH_PARSER=y
> +CONFIG_HUSH_MODERN_PARSER=y
> +CONFIG_SYS_PROMPT="-> "
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_BOOTP_MAY_FAIL=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_NET_RETRY_COUNT=10
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_FPGA_XILINX=y
> +CONFIG_FPGA_ZYNQPL=y
> +CONFIG_MAX7320_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_CADENCE=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ZYNQ=y
> +CONFIG_ZYNQ_HISPD_BROKEN=y
> +CONFIG_DM_MTD=y
> +CONFIG_SPI_FLASH_ATMEL=y
> +CONFIG_SPI_FLASH_EON=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_ISSI=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_SPI_FLASH_SST=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_SPI_FLASH_DATAFLASH=y
> +CONFIG_PHY_NATSEMI=y
> +CONFIG_MII=y
> +CONFIG_ZYNQ_GEM=y
> +CONFIG_ZYNQ_SERIAL=y
> +CONFIG_ZYNQ_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_ULPI_VIEWPORT=y
> +CONFIG_USB_ULPI=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +# CONFIG_SHA256 is not set
> +CONFIG_SPL_CRC32=y
> +# CONFIG_SPL_SHA1 is not set
> +# CONFIG_EFI_LOADER is not set
> diff --git a/configs/brsmarc2_defconfig b/configs/brsmarc2_defconfig
> new file mode 100644
> index 0000000000..d3bf1202d5
> --- /dev/null
> +++ b/configs/brsmarc2_defconfig
> @@ -0,0 +1,122 @@
> +CONFIG_ARM=y
> +CONFIG_SYS_VENDOR="BuR"
> +CONFIG_SYS_CONFIG_NAME="brzynq"
> +CONFIG_SYS_L2CACHE_OFF=y
> +CONFIG_ARCH_ZYNQ=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_INITRD_TAG=y
> +CONFIG_TEXT_BASE=0x4000000
> +CONFIG_SYS_MALLOC_F_LEN=0x1000
> +CONFIG_SPL_GPIO=y
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_ENV_SOURCE_FILE="env/brcp1"
> +CONFIG_SF_DEFAULT_SPEED=100000000
> +CONFIG_SF_DEFAULT_MODE=0x3
> +CONFIG_ENV_SIZE=0x10000
> +CONFIG_ENV_OFFSET=0x20000
> +CONFIG_ENV_SECT_SIZE=0x10000
> +CONFIG_DM_GPIO=y
> +CONFIG_DEFAULT_DEVICE_TREE="zynq-brsmarc2"
> +CONFIG_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x10000
> +# CONFIG_SPL_MMC is not set
> +CONFIG_SPL_STACK_R_ADDR=0x800000
> +CONFIG_SPL_STACK=0xFFFFFE00
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x20000
> +CONFIG_SPL_BSS_MAX_SIZE=0x80000
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x600000
> +CONFIG_SPL_SIZE_LIMIT=0x20000
> +CONFIG_SPL=y
> +CONFIG_ENV_OFFSET_REDUND=0x30000
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +CONFIG_ZYNQ_SDHCI_MAX_FREQ=100000000
> +CONFIG_TARGET_ZYNQ_BR=y
> +CONFIG_SYS_LOAD_ADDR=0x2000000
> +CONFIG_FIT=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_LOAD_FIT_ADDRESS=0x4000000
> +CONFIG_SPL_LOAD_FIT_FULL=y
> +CONFIG_SYS_BOOTM_LEN=0x2000000
> +CONFIG_BOOTDELAY=0
> +CONFIG_OF_ENV_SETUP=y
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND="run b_default"
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="run setupaddr_spi; run brdefaultip; run cfgscr; setenv bootstart 1"
> +CONFIG_SYS_CBSIZE=512
> +CONFIG_SYS_CONSOLE_INFO_QUIET=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_CLOCKS=y
> +CONFIG_SPL_MAX_SIZE=0x20000
> +CONFIG_SPL_PAD_TO=0x0
> +CONFIG_SPL_SYS_MALLOC_SIMPLE=y
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
> +CONFIG_SPL_CPU=y
> +CONFIG_SPL_I2C=y
> +# CONFIG_SPL_RAM_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
> +CONFIG_HUSH_PARSER=y
> +CONFIG_HUSH_MODERN_PARSER=y
> +CONFIG_SYS_PROMPT="-> "
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
> +# CONFIG_CMD_LOADB is not set
> +# CONFIG_CMD_LOADS is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
> +CONFIG_BOOTP_MAY_FAIL=y
> +CONFIG_CMD_EXT4=y
> +CONFIG_CMD_EXT4_WRITE=y
> +CONFIG_CMD_FAT=y
> +CONFIG_CMD_FS_GENERIC=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_IN_SPI_FLASH=y
> +CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> +CONFIG_NET_RETRY_COUNT=10
> +CONFIG_NET_RANDOM_ETHADDR=y
> +CONFIG_FPGA_XILINX=y
> +CONFIG_FPGA_ZYNQPL=y
> +CONFIG_MAX7320_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_CADENCE=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ZYNQ=y
> +CONFIG_ZYNQ_HISPD_BROKEN=y
> +CONFIG_DM_MTD=y
> +CONFIG_SPI_FLASH_ATMEL=y
> +CONFIG_SPI_FLASH_EON=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_ISSI=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SILICONKAISER=y
> +CONFIG_SPI_FLASH_SPANSION=y
> +CONFIG_SPI_FLASH_S28HX_T=y
> +CONFIG_SPI_FLASH_STMICRO=y
> +CONFIG_SPI_FLASH_MT35XU=y
> +CONFIG_SPI_FLASH_SST=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_ZBIT=y
> +CONFIG_SPI_FLASH_DATAFLASH=y
> +CONFIG_PHY_NATSEMI=y
> +CONFIG_MII=y
> +CONFIG_ZYNQ_GEM=y
> +CONFIG_ZYNQ_SERIAL=y
> +CONFIG_ZYNQ_QSPI=y
> +CONFIG_USB=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_ULPI_VIEWPORT=y
> +CONFIG_USB_ULPI=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_SYS_TIMER_COUNTS_DOWN=y
> +# CONFIG_SHA256 is not set
> +CONFIG_SPL_CRC32=y
> +# CONFIG_SPL_SHA1 is not set
> +# CONFIG_EFI_LOADER is not set
> diff --git a/include/configs/brzynq.h b/include/configs/brzynq.h
> new file mode 100644
> index 0000000000..e2ebb2f100
> --- /dev/null
> +++ b/include/configs/brzynq.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Config file for BR Zynq board
> + *
> + * Copyright (C) 2024
> + * B&R Industrial Automation GmbH - http://www.br-automation.com/
> + */
> +
> +#ifndef __CONFIG_BRZYNQ_H__
> +#define __CONFIG_BRZYNQ_H__
> +
> +/* Increase PHY_ANEG_TIMEOUT since the FPGA needs some setup time */
> +#if IS_ENABLED(CONFIG_SPL_FPGA)
> +#define PHY_ANEG_TIMEOUT  8000
> +#endif
> +
> +/* Use top mapped SRAM */
> +#define CFG_SYS_INIT_RAM_ADDR	0xFFFF0000
> +#define CFG_SYS_INIT_RAM_SIZE	0x2000
> +
> +#endif /* __CONFIG_BRZYNQ_H__ */

M
