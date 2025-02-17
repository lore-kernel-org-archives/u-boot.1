Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A1CC021A0
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 07:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB8180F0B;
	Mon, 17 Feb 2025 08:04:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xpMRBw/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD6480F12; Mon, 17 Feb 2025 08:04:28 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06FD80C7E
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 08:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Le0ZD0NkiEwsbbYchth/bCLQ5ykmMKdgQtZaeqhxGvy7BohLQViEw50XjhKceffxNc24Ay9Qu/plgqpkwW+4PF2kSEJqntujvRxeySS79QAPz8ecpw6yThj6975Iz7XfACL0bl2DA9vXNYx9I0zYjl0gRNIMuTgTAu0Tu1zb3cnUsJqv0hPw9/lZBv4G2HdO0CdjqLKmlx1GN6M0wpbmFjNpm0ocBRyn3CZXfZ99Nhua5JNZtgNG9HhaBcOqvIpg3udP2zFjmWrvPcfhV2xAPtSMtnRrKLamgN6JABjdCt1a58+hqNgczrBWWbW5+wO86mOzxcas4PGo9RtrkNDOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLX2E42SSANY8rNchOvHDYaeW96rTS668BM5RXanN2I=;
 b=XWMSm+RDaFb5PdFCtaOqdZJuNN6fyHirHALGzO0frBA6YhUqMUaINmJplYbXF3hhFvLTqWlAmcRVGyjvEYZcIha+dCV9wyf1SWapssh/6bwvzG5RtBWrWzmEcDoVS2jPQYY6GTIJUPWgd4rio4IjjZpoDSSujAU6kh3DfKjmfubV27gCBc4yrIEjGreu117TTBqEz4EF1pLQcCtaz9amH9OJVexqtS/tUYK11mkKlw7y8fY9xUqx/2nKPjZeGqULCy56KXdYBI7FNxh1tdP3rlbye6PRzr0zfZIY0zAKEAfTf4Dmj7bPhbcl25lDNj9suLBGav6A+wwC2AdNqLtH/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLX2E42SSANY8rNchOvHDYaeW96rTS668BM5RXanN2I=;
 b=xpMRBw/TX8s5Faol4qU00XtpCB4MeFSIIx5TlA4uSQyQssechbWyJHYOOC2sWJTnLnrAsRGPne8d20IwdiSEk01VUFIjMlLhCqiW6qbLmSSWnomheLLoTJyu7EMe/VNcis3dmaClk1gUHNsTvo8DyIBcawGEdkikyH2IgtIbfvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 07:04:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 07:04:21 +0000
Message-ID: <2eda2b4d-3b46-4871-9cb1-2fe0471eb2f4@amd.com>
Date: Mon, 17 Feb 2025 08:04:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] EFI Capsule update explicitly sets dfu_alt_info
To: Jonathan Humphreys <j-humphreys@ti.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Aashvij Shenai
 <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
Cc: u-boot@lists.denx.de
References: <20250213195351.3518305-1-j-humphreys@ti.com>
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
In-Reply-To: <20250213195351.3518305-1-j-humphreys@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0119.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 758dd8e3-8e3e-4b1e-d463-08dd4f214dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDJKd01kdUhsMU5sdE9ZWGJGeXovUTJlZWdhWkVXa0IzcFFMcHB6SEltMU56?=
 =?utf-8?B?c0p3VU4zMnk2NjNpaGlnK0dONjNOdWkvMHM1SHhKVjhSaE12WmdYdnUzYUV6?=
 =?utf-8?B?MGpsR3djaFhuSnpGUnpPVFhkSDVPYTRiYUt2SGhoTklNYWVqcEdRZFNLalZC?=
 =?utf-8?B?NUlRZndwKzgwTkM5bnBMR2hHRzg4eHhCMFpiRk51STFBbHJsd05UUC84T0Jq?=
 =?utf-8?B?WWZsYld5UytVK2pHeXNhZExFZ3pOWWZ2SEoyZDJEZytRVXZlSExBMUgyd21h?=
 =?utf-8?B?czVXTWFmOFFiblY2a2NsNGxYV0UrMXB1b3JNNXBrZ3VSdmZaU2xycW1XL2FP?=
 =?utf-8?B?S2FzTHJvUTd0KzFFVktaK3c4OS9SODJIUnZWYkFBa2h6NVFBbTR0SE8rS3c1?=
 =?utf-8?B?VFFzd1VHdFRwWE93M0NadVNlZDJ3amg2MTJBMnIvcXdiU0V0dkxIOVZWRGdy?=
 =?utf-8?B?VGRjV0FvbVhodGVXd255Slg4bkhuT2JWalI3b0RoL3E2eE9uQXVFcGZzTU4r?=
 =?utf-8?B?Y29tdGxVVlBjd1N3QSszUE03bXBTM2YyTndlcUhhbVBPTitQc1J6UWZyRGE4?=
 =?utf-8?B?bUFsbHhMUnhvVVlzOUcwQ0JzekpBcjZlazhPMThuTjVma2V4QXdYcTdQS044?=
 =?utf-8?B?ZzBkWEFTV2tDMHBkbVJnbjkvU3NmTmJCcmdNaTlCTDBKVEFLWm9wdm5WeS8r?=
 =?utf-8?B?UjVyOGlGalEwNlNucEdFTTlvSEp4ckRwd0tQMUk4a1o3NXJXRm5kSkZQUnNi?=
 =?utf-8?B?bGNXQlhCV1VhbFNMZ09LV2N6cG1hUElNOVN2MUNhTUptc3o3S1NudVJGUHA0?=
 =?utf-8?B?N1N3YkFOZUN5MGYxWHhLMEMram14Y3MwcmNkY3JaUGorQm5RRVlySnJhaURi?=
 =?utf-8?B?ZTF4RmovYkZneGd2NmR0YjFqZ0hGY1pmbmZtOE54NVM1TUJGaEJyTEJ1YzNW?=
 =?utf-8?B?RW5qb25CNlpjRFo2b25ocTBkbzFQb1NsLy9Oc25WcDJDWUk1cTYzb3BkMncw?=
 =?utf-8?B?aU5GRDdSa2RINUpUSmE4eDcvaFZrOHVGaUdzNWxOOW9XcjBSRWxJM2xpenRv?=
 =?utf-8?B?eEt4U1BwWVVCTFJMQnlpN0hab0ROZkxsY3NQak1xS1pmWGxiR202VWY1Qnk2?=
 =?utf-8?B?RWcwdGZCVk9KWTJ2RXVVc1FsTDQ4Zis2K2lkV0QxSENZQnQxQ0FWellwTmdG?=
 =?utf-8?B?T096dDZ4dFJ3dWE5eGI2N3pGR0ZGMHRMQWt3bTlIdSt6YTBUTlIrd0t2NmtK?=
 =?utf-8?B?SGpjUWlHTXNKM2pCVVpzcVZXT0NTQkxaWm5RaXdaT09FOUNKRFBHK2JWZVdF?=
 =?utf-8?B?SjdRRDN2M2FIejd4eEJ1V2pNZmtERnRZNWtWcWkrQ3NtOEVwdXd0a1JJdTg5?=
 =?utf-8?B?UFQvL3MzdlFSblFxZFVhTU1NRkNyOWFNblhvaWZ6RFh1ZEZvT0FYSmdLbHo5?=
 =?utf-8?B?c3BsbFNWaE4xTExqZStVUEpZa2U5RTFXNHZwM3RTT2x3anY2ZlE5bUpmVGt3?=
 =?utf-8?B?bUt3STByb1NHZUMrZk9UK0xBN0c3a3Jjc1B4MmFHZzN4NnNHWE5yMXNVRG5V?=
 =?utf-8?B?ZmR2UFAxZDVWQ1JUblRVZ1FTTmJ5d24wUFA1ZWJyWklxaks2cVJvallONXcw?=
 =?utf-8?B?cWU0ZkhKZVlZQ2YzaUw0SGQyS1BKUlVwaDBzeVIvOGROeDF4QVl1TTVTdmk3?=
 =?utf-8?B?aTdrNkthY1BBTkNobVNsSWxYaktPeTFXNjZTTXh6YU1xc0ZmLzNHVm1RQnhV?=
 =?utf-8?B?Vm9hUGxJWU5mMFhDYW9yaWlydFJ6bmtOald3SmFYS2wvT1psQkhLd04yOFla?=
 =?utf-8?B?SWx6T1RYMi9oM2FVUnVtcVpuWFlEU1NweGwycWovODkycDdzY1huZVROYUZL?=
 =?utf-8?B?M2txOERQVUQ5ZnQ5cllQczY4YmpraVFXNFpnYXBKcDRreUErdUZodWJqWkh5?=
 =?utf-8?Q?PbtRiSp9sqN7K52Y1ApsgdTBpVlE8PzE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emh1Zm5odzNlZ2YxdG5tY05zRWh5eVpISGw0dHZpMURyYmpVM25TZEtRUThH?=
 =?utf-8?B?eHJ6MXBJSnVEdnh0dUEvbCtwOU9aTDJRRjRReW8xQzlxZUVIRktseG16UVNR?=
 =?utf-8?B?Um1XeVhaaGFoTFdwcktWazJKZDRQUWQ0am9QRi92RnJJM2s4dXM0NElNTk5i?=
 =?utf-8?B?eXo4NklPbWpHWXZmaTNObXBGdXBmcFprZ1gzWFZaK2Y2NjlublpGVjRzQ0pU?=
 =?utf-8?B?UnViWFJtNEs0eFVraEdqSHlqeFNGbXEwRnFVbDlwNFlPbFZCMHJmb29pWHRC?=
 =?utf-8?B?RmxleWZwMkNNYWZJdFdLekVSbkhEbFYxYnVYa3YvcGJOT2ZEMUUydmlpVWJH?=
 =?utf-8?B?UStwWFlIZ0VzTXhaQzZQNkhLY2xUV2NsS3FZaU1nVWRLeTk2Mk5Bd2NmMXpk?=
 =?utf-8?B?dFpyMVZ2M0JTc0ZrakI3Qk92NEgyTEI0dlMvd1RVTGxsMHBwcy9vRVNzWVY0?=
 =?utf-8?B?K0NIL0hpT1l2MGttaXlKS0tKR2lPZnlUYVhCUjh0WUlLaytMZklCNTF0NFE0?=
 =?utf-8?B?NFJheEZqTVcra1RUSHVHUXJ5eTlpVHdob0V4YXVOMkIvZnZJdEo1U0JmRmJY?=
 =?utf-8?B?QUpULzJDNG9QSCtTRTRTZmpVMzNUQkZyc1dIQXdmWTMxNDJ4YjFjd1lxNnJz?=
 =?utf-8?B?YlBkeE9kc2dPaTY5VXhBYjYwSHZvbnJ5WUszck5BdFY0czFGSkJWU28wMjhW?=
 =?utf-8?B?eUxPTVkva1VkUHZaNkU4VU5VeHAxMzVPUE8yVFdJMzd3RGs0bk50K21OMDIv?=
 =?utf-8?B?ZDdrZmF4NWFOb2k4dExIcU8zWmZ0SnJZQnVlY1ZOQVpUa1UzTk0zcWpmZi9r?=
 =?utf-8?B?VzBScjIweUZySThzSGoxbE1yN010Q3NiTHJDUDhlemR4Ry9meFQzcWREVDk2?=
 =?utf-8?B?K2l2TVpyVXVOb2lQenNkUDNQUnJ5ayt0cXB0Z0xFa0dnQytMZDk0Y3hnc2dE?=
 =?utf-8?B?ZjEveGgxb0lrU3BrUDdrQkt3QW9UVFJOazRXZlFLNlVrQlV6N053U2RRcWZk?=
 =?utf-8?B?NU5iZEJkVStxbGJyWVdOMHVmWmxabGg2K0hmem9HV1ZzeVFTNW1kWW9jRTRy?=
 =?utf-8?B?b0liU3QwRUNoQzREOXQ2S3JCa3hBOEc4WVZKNU1WbmIvcWxUeVJWbDgvNVBZ?=
 =?utf-8?B?aGNpSVVBT1ZObTJmVEtYMmlLbDhOT00xakkzSk1LWU42SXpUcmVYTGtrWmtN?=
 =?utf-8?B?NkJEcXdGUExyVEFHQmhJOFVWa2Z6aWJETytoYkJHY3FBalFvQ0Z3TnIvRld1?=
 =?utf-8?B?SkJSM1pmNjBCSzlFREIyZWxVRzIxMndZQ3l2ckcvSjlqWXFlSTNqaU8wYUda?=
 =?utf-8?B?UHJYeks2dkhIcmpqdG00bXNZZFdYQmtTYXRDVkdPeC9YVloyLzZjcXI3UjNP?=
 =?utf-8?B?S1VialdNL3JZWTRqRC9NUmdQLy9pM3lGeUJjcnJZTjhwMmgzRDM0VXJyTXFx?=
 =?utf-8?B?SEk0ZDNlYWtNbW1xQlpxS0JORnJTR3paaHJYZHM4bEcrbnhFMWd6ZHVMSHR6?=
 =?utf-8?B?OG1WS0JHUTlBSm95R0R5eCtsOE1PKyt4U3RINUM5WVY0aWpIdGFiQ1YyWDls?=
 =?utf-8?B?N2NQaXIxYm5uaVp5SU9NRW9YaG0yRXNOdGxxN0E5SnVZUmZZRUJDNm1JZ1JY?=
 =?utf-8?B?RzRlM2ozMXp4RE5MazR1M3hRb1NxdWNqL0Q4RVBqaW52NTlmVGN0bGI3OC9z?=
 =?utf-8?B?Y2E0UmNLampRR0w2RVVtQnRabnBZejc1dllRbC8vZld1R0pSK2twU0FGQXFT?=
 =?utf-8?B?UllzS2RQc1QxMFNSY3h5TDlPVzZXOThkMEFkWUNQNWUvQkU4MEE1ejNGRWow?=
 =?utf-8?B?alUzanNUQ3NPb1NvckxpN1hnSTdwSFpRR0ZyOEZkWGNEMUxRMVFoajlpbTZq?=
 =?utf-8?B?ektrTUxodHh1bW43Q3Bhc0FqN1dDL0xSYmhxLy9LcFR2ZzM1V1A3d0xSN3FP?=
 =?utf-8?B?aVRDQU1SbzRiV0MzYTAyWmJpaE83c1RadldSQ3NUdFpGdTk5amRyV2lWYXN1?=
 =?utf-8?B?dU9TelNMME5uVTdsYTNlNVNDTFg2YXB6YjRVUVREVFJOelhZbWlrNnQ2aU1M?=
 =?utf-8?B?aHRKZUFRTDUyS0NMSFltRzkweDNwS2x2dEFGODNReWljV1VDaWZqQXRnekZO?=
 =?utf-8?Q?qKyrA5Uf0uAlaIPKVOC/YGygW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758dd8e3-8e3e-4b1e-d463-08dd4f214dd3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 07:04:21.7489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVdb8m48CA6745phjBR5zkxQ+r/2jLs6k8r6V7Hp6vz72+N7tQUzbXaRjBdeO9uq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514
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



On 2/13/25 20:53, Jonathan Humphreys wrote:
> For capsule update, explicitly set the dfu_alt_info environment variable
> before the DFU operation, and then restore it to the original value.
> Previously, the dfu_alt_info environment variable was set with the
> set_dfu_alt_info() function.
> 
> The problem with setting the capsule update's dfu_alt_info setting in
> set_dfu_alt_info() is that set_dfu_alt_info() lacks the context of what DFU
> operation is being performed (eg, capsule update, DFU boot, listing the
> alt_info, etc) so the capsule update setting was overwriting the setting
> for other DFU operations.
> 
> Changes from v1:
> - use log_err() instead of pr_err()
> - create a local copy of the original dfu_alt_info environment variable to
>    be used to later restore it, rather than just a pointer to the stored
>    value, because changing its value to the EFI capsule update setting will
>    cause the original string location to be freed.
> - even in the case of a DFU operation error, restore the dfu_alt_info
>    environment variable to its original value.
> - return EFI_EXIT based error codes if setting environment variables fails
> Link to v1: https://lore.kernel.org/r/20250203215351.2840144-1-j-humphreys@ti.com
> 
> Changes from v2:
> - add patch for xilinx boards to set the dfu_string member with the created
>    dfu_alt_info string for capsule updates
> Link to v2: https://lore.kernel.org/r/20250206154719.3032322-1-j-humphreys@ti.com
> 
> Jonathan Humphreys (2):
>    efi_firmware: set EFI capsule dfu_alt_info env explicitly
>    board: remove capsule update support in set_dfu_alt_info()
> 
> Michal Simek (1):
>    xilinx: dfu: Fill directly update_info.dfu_string
> 
>   board/beagle/beagleboneai64/beagleboneai64.c  |  8 ----
>   board/beagle/beagleplay/beagleplay.c          |  8 ----
>   .../aml-a311d-cc/aml-a311d-cc.c               |  2 -
>   .../aml-s805x-ac/aml-s805x-ac.c               |  2 -
>   .../aml-s905d3-cc/aml-s905d3-cc.c             |  2 -
>   board/phytec/common/k3/board.c                |  8 ----
>   board/ti/am62px/evm.c                         |  8 ----
>   board/ti/am62x/evm.c                          |  8 ----
>   board/ti/am64x/evm.c                          |  8 ----
>   board/ti/j721e/evm.c                          |  8 ----
>   board/ti/j784s4/evm.c                         |  8 ----
>   board/xilinx/common/board.h                   |  3 ++
>   board/xilinx/versal/board.c                   | 16 +++----
>   board/xilinx/zynq/board.c                     | 16 +++----
>   board/xilinx/zynqmp/zynqmp.c                  | 16 +++----
>   lib/efi_loader/Kconfig                        |  2 -
>   lib/efi_loader/efi_firmware.c                 | 44 +++++++++++++++----
>   17 files changed, 60 insertions(+), 107 deletions(-)
> 

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

