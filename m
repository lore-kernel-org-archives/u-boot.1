Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BCEE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 12:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6AC7893C7;
	Tue, 10 Dec 2024 13:41:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="frrlLgib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C50689265; Tue, 10 Dec 2024 13:41:10 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C121C890D0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 13:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNSfpdhQpbjdQC462ztyBMOZYZ7ighGIw08Whft2RnJ8mpUaHINGrPh89J0PvsKN9LXl0CxZbVkH5dxMfsm8Pqp4JrRi1bFRg6inBMKFbec3M83huG5QlFaemd3leQ0KFzjySd3Y3gTP/7PcXmV9U+9cG95AA2q7gm96Ho3fuYnKqTUyJb2DRr9omyi8GfX2EekOMObZ2nDX/Yflxr4f8wiVd5y3XNjwDXWBYoxv1k4lx8BBuyyw9o35iZILw0xOpfNOb+NBHNk4Nu1+sODqaceK5rvgSQkFlFpAhWzYF94/nxnjQO7bLsjxgMrcoZRG3evT7JN+tSc4CNNLicVoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omg3eea18y2HqfjfqBSmo7dY3RFNBgFPCOPCIhuv4Jw=;
 b=irVmUMMrD5watsvWTGDLCUgYWvylswcFBof9hdDVy6554M/xJFXMnYG9snqVWc1tpS3HYk36tfZb5hgL9rQusK5YJxOGpR2n6dzXdplqmYwLwp7nHGEMZjw8KloynW4aHHD2dRm88Eo9lrORdBbMT9SNMptEhVqpl8MgytXdqhOKQNcVsqX3GFvGmIQcF4uD3ZPtfRGRNyS25ijwL+qvWKS6/Q4zW/iBhxlvzUhJfsq85eTDYm7ZGT/XfSuEHJ5AZKMx5QJtaYlMFmgarzCXXaSEaCFFPwuwZv/D1+sSkV3hB69Yjz3gg+DXmXXHtrjIc/COyrTehvXNZr07AATBdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omg3eea18y2HqfjfqBSmo7dY3RFNBgFPCOPCIhuv4Jw=;
 b=frrlLgibi10tPmH94i8Q+HsIWpinjNdC5NpUbE++eVHkYMzEyY048fsvnorxLIjbI/N6LvG+Adrll6gZQsSAwbq3+hFWJjLsDF70QUoj7ZKk1lTb9t8Ad98N2q/k989zpqjDwhNNjE7x4gG8ao9Ynyvg4n+U1HQ5CqgAXRs1gic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 12:41:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:41:03 +0000
Message-ID: <3ed2af58-9e45-435f-aba7-a07f775f76cf@amd.com>
Date: Tue, 10 Dec 2024 13:40:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] common: binman: Calling initr_binman() when
 BINMAN_FDT
To: Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, git@xilinx.com,
 neal.frager@amd.com, Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <cover.1730452668.git.michal.simek@amd.com>
 <f79dc1fbf796dd5ad290f6080608ee68d7652cfc.1730452668.git.michal.simek@amd.com>
 <CAFLszTiWOdsS8=pm7aSvyC2QYiXbbsciz2yb6s9YPV1FeFFrgg@mail.gmail.com>
 <2ee46698-87c9-47e3-8951-41ac3c50331a@amd.com>
 <20241209153216.GJ2457179@bill-the-cat>
 <CAFLszTjb23qYBS2YDWjTJDFtJ2OnZZ5OQG56i9DBu_NeUT=FzQ@mail.gmail.com>
 <b5145a88-aea0-43c1-8fa0-fe533bd9d169@amd.com>
 <CAFLszTgR7A5N5NOpE0HX0j-DqQ5QqLR=391Y5tEJ00HPFfshTw@mail.gmail.com>
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
In-Reply-To: <CAFLszTgR7A5N5NOpE0HX0j-DqQ5QqLR=391Y5tEJ00HPFfshTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: a053a088-1d37-4071-3dec-08dd1917e83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVludVdZVlA0YlIxYStlbkJKYnd3S0dZUXNXZUhQYU9iVGcxalkxU081bnZL?=
 =?utf-8?B?QVpBM1QrbXFnelJJU0hkeE9pbHlaUVNVZnBzdCtGTC9JclY0a052eWpvNEpt?=
 =?utf-8?B?WXFOeXVCSEczUVNmQTBneVVWdFRFK3RYTkNmOUxwV0VMbEluQVNyY290a0NQ?=
 =?utf-8?B?VHBadVVVRkVXR0FJUWhVM05iYUMzTWJNWm9jNmErVjRmYlp0MzFhNm1zd0ha?=
 =?utf-8?B?ZDNoSytOZXhlNWhBQTVySTh0ckQ4ZE1laUNtWTlnOVJrcGhDekZTUkNsTTQ5?=
 =?utf-8?B?bm9FV2lwa3JYL0tMTCsrbDVYei9hNVg2dHF3OUtkTVpoemtwWlp5aERmOERQ?=
 =?utf-8?B?TDNGUWxkZnllNDBzcVFob3F3N0Q1VXYrWm9GUHo2ZkVXZS9lWm5vZStra1JK?=
 =?utf-8?B?WTIrQTJWeHVkZGtHa2J1eGk5WHdaNjFnZ1dzUklMRzVNYjVNRzBZRmNnZjlU?=
 =?utf-8?B?NHZ6WXFNSFNpUnRJRDlubHpReXRxaGVTWU1UWWQyTWY2M09DdlAzNSt4TnVO?=
 =?utf-8?B?TzI5cTc4ZHd0L3k0U3grMlRERjgxNGlQK2dXMitDaFNyQ2pnbmVUTzBNS1VG?=
 =?utf-8?B?bTJoMERmcnhQaVFWbkxzeWJKUk9hZzU1YmcrNWhzSU1iU3YxckNuOFJieHYr?=
 =?utf-8?B?dzFnYzh4ZUlCOXgxWUQzclpkaHBvQS9WSW4rWjVpdFR2ajgxYysyV1BaRzZt?=
 =?utf-8?B?bllvMTdKOGhueHBkekloNGpDU2c2Y2ZUbnFGaFk2SjVqaWVJZWMwb2xxZm1x?=
 =?utf-8?B?Nmt1T1l6eFdDYll6L3NkaTNHQU9KRXpWUkE1T3dLZkJFM1Y0NkdqY1kzVGNo?=
 =?utf-8?B?TmdITmVINGsyWDhqOW4vL3Q3bEhISkxVYlpQdklGRFI3ZUFCZTQ0MjM4aFdN?=
 =?utf-8?B?L0tVekRQcUNzZ2VJeWl0RSs0WHBBZko2cjRQSXlxNCtway95emk4azN5VHJi?=
 =?utf-8?B?KzdEUXlWNTVKVzhDU3NNam5KbS9MT21hWXVzNWh6RFlXU2R2RFdRRk1mSmxC?=
 =?utf-8?B?VDdudERaMzhOTkFlN3pPbDJ4VlVjNTNHbmltNHZudHd4Yng4UWVaaERPQllN?=
 =?utf-8?B?ZWxJWVRWdXJKYlZvWHBSbENPOVY0b1R2Z29iQUlRNUMwN1FoOGNpQVdidGlv?=
 =?utf-8?B?SlB6WGNNRG85QVBoZ1JIY1hDUTdOZlRJbXJ5SFJxS1FsUjhiYWtuczFBcW1B?=
 =?utf-8?B?Q0lPTU43R0ZPWklxWUFRQ09TVi9VSDRhajZ5YmoraXFuRFdWZVN0OXFya0Vo?=
 =?utf-8?B?cFFyQjU3VURSZWZRUWc0cGNjdTIrakxoWmVGeURiRnh0UU44NHI5YzQwRXlK?=
 =?utf-8?B?QXdOZHRUc0JnOStPVHRobm8rNHBJNUpkblZyc3pQNWhjRDJmRUROcXJDcEdP?=
 =?utf-8?B?SkZBWXdySVJoQVl6ZHR0a2NOSUZkdzd6U2lwbTlhbEUzRGJjb25wZSsrK2R2?=
 =?utf-8?B?aXl5S3orYko0S1JTb3l3SE9zTGNZRWNZUy84TVVpTFJTUVIyWkVFV01DVDhk?=
 =?utf-8?B?MkpiSDVJWkc4WHFjanFKQzdsdU45bzJSSmIxV2FUaExOTGh6ck9HOCtpUU1y?=
 =?utf-8?B?U045bUlBNk8xcWtJbjFjd0U1d2laaGZTNTYxL0lBQ0pjMkxrMDlEMmNhSVBF?=
 =?utf-8?B?YWhZdCtjdUtTSGw4TVFkY2tzc3ZEMzZlSXRaV2RKM01mYWc2bHBmNlhYbGZ6?=
 =?utf-8?B?SE1ZQWhRZkRieE80anhFOVJXbk9qcEszMHY3NVd5aXFMblRVTTQwakxSZDBa?=
 =?utf-8?B?dUZHQ2dFSkRUbmtyTHBzMWl6bGZLRER6YStzM0ZiL2ZDTlUvSjZtZmNBRkov?=
 =?utf-8?B?RVhNclFLK1UzS08yQ1FGZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWluZ2kwUVNmSHJoVUtONC9HbjZna3dwM3pWUDRndENSeFo3MXExcHY5cVV4?=
 =?utf-8?B?d1J4dkdJdTdXQldkYnhoUmx1aUxCdk8zS3Axc1RyNWNYZm9TUzJNcGFFeWxs?=
 =?utf-8?B?QjJONmlCaXY4TlZLRHVVM1FqNjcrcFdTSTZ3QnZvQTg4SmNaMTB4akdFNFZ2?=
 =?utf-8?B?cEs4bUFOYk81cmxvYXJpZGxQVUhqWTd2R1MyQnJ0OUFzSDVFOERZeEU4dGNE?=
 =?utf-8?B?VEZ5RWRORTBUdGZaUytFSC9SVkRaZXovTXp1K0VYcjBQc2lUNjByZHZhdFVr?=
 =?utf-8?B?TXNheEtmQTBzU3pKUnRmM3BkekhPNkMxeElySy9admM4cU1hSC9KNVlkMTlF?=
 =?utf-8?B?TjB3TUxjR29ZMEZxNktGU2duK080SU94bmJXWHlQTklkTHFtL0o5QkdRSUJp?=
 =?utf-8?B?YmJ2TUhQUHdveVhLekRoTEVtNGlsS01STmx6YTFyOGhqLzNqcTZ0ZUVEemZp?=
 =?utf-8?B?d0RXTTgvcXNzZHBhWC95Yk0xb0Evb2ZyL1dXRmNXVzZCeHRnckY5UlBpZmZi?=
 =?utf-8?B?TXlwdVNtYzdLSXlrdTZFckFTTkJsMXRaY1ZIYVZDVHdVZ2JZZC9nWFBiRVpP?=
 =?utf-8?B?US96cU9VQ1RqQjJKK0NraXJyR2VCdnRaTEh0TFRPdlB0Zmw3bmI2VStITjN1?=
 =?utf-8?B?ZmhNSkxMT0N4bkVrZjE0bTJQKzNYTXJRWUU3MDhZa3NPQUNnMWRVRmFnTjYy?=
 =?utf-8?B?cXEwTUUyVGtsbnFkWnNwNXg2VUZMUkJXVlRrTlI3dzVlRlRsSHEwNGFqS3dk?=
 =?utf-8?B?S3Q5UTV6UjM4RTNvQzI5endZNERhQlE4WkZiQVpCNUlWdUdkUmdyd01sQWs4?=
 =?utf-8?B?RFJRVFJ4YTl1Y3ZoTlAvZS93UkViM2ZIL3NuTDNycVFiSXIveXdUazJlcHcx?=
 =?utf-8?B?Z000Z2d3Wk1YSXdtYzBLVE10YldnZUhzNnJaRGZSZlRzRkN1WnU1YzltakY4?=
 =?utf-8?B?K3FhVWZLcHhaRk5aaFhsaDJjSDhGN0dYR0ZXTEF1eVJlZmRJdHRKSUFmbFcw?=
 =?utf-8?B?Nk5TL1duMHE5amRXT2xZVCtoU25xYVNVWkRBNmhSMmlBQ2N6WCs3U3pZUkti?=
 =?utf-8?B?R1VRNTI3YU82ZGlORGhQcjNxeldnU0hKTjd0SXBKMFRYT2Ywc3JHdHlYTmp2?=
 =?utf-8?B?WENETndGV0R6U0JaUFk3UGJsRFBpam1hUCtzU2VWVlBzeThqOC9MNzBnVXhL?=
 =?utf-8?B?cTF0eHo0UnlaeHdaVE52S29UL3BtaXYrZlFMM3k2a1pHODFPZW04NjhOaWdi?=
 =?utf-8?B?MEJVdS85L2Z0cDBwOC9zSWRUa1VKVlhJbEVyaWMzMWNNTTkvVmc3WHU5YUVB?=
 =?utf-8?B?WmYxRk5iblFnUmw1d2l3TlVHNlVORGxDNkg0RTIxSkdhOHZ6eEovcFJ1QkxC?=
 =?utf-8?B?bklIUnd0WGhXSHdVZjNvUFpYc3Zta0EvbCtsN1hMWWs3aWwxL1BkeFR3YmE5?=
 =?utf-8?B?M0w5bVg2UzNZN1hlbGkzK05FSU9oUWMzSVIyVjhZQ1pzZTZFUEc5eWZ0eTh2?=
 =?utf-8?B?NVpjUFZmaTgvSFBuaTJRQUZsQUtmYUNUR1o0N0Q0OEZqQXVuMnY2SHRsYmFQ?=
 =?utf-8?B?blplbk80c01hYmh1K1hNUVRuWExHREVqeEpaQndDNFVJS0ZMZzh5UUx3WTkv?=
 =?utf-8?B?U3puNDJ5NUFQRmk5ZWlvQzNTdVMyZFVjU2xtNG8zUjZyektKQ3ZNQ1NhdlFx?=
 =?utf-8?B?RWJwcUN6ck5jOTJ1anE1anhlTHkxZ09YdWg1SHdoeG1vUDdvOWpkblpmeU42?=
 =?utf-8?B?QnYyWHRFaEZpanVKWjhOeE9oWk56WHJJQ2dQdHlwZlBXWkV3T1cyUmNqbzlF?=
 =?utf-8?B?YjBUaWdyUCtUWE1aVEN1Y0FEaTZ6OGhoc0xUOEM2dlRWKzM2NGtFSXEyVE5s?=
 =?utf-8?B?TENFbnFIUDRET3FlL2l5WTRMMmFrRzRnbnNTUVorWkUybW5OYWVFbU91UHFj?=
 =?utf-8?B?Ui9BRmU5dlNxRmtZMTMxSXd2M3FIcVc1LzhGYUtIUUVOY2ZBaFVXc1kyV3VU?=
 =?utf-8?B?dVlxcGhHSkZWTy9PaFhFM3hTVEpoVGVIaW1NbzJDQmJBNVZQakxJUXllTW9Y?=
 =?utf-8?B?RUJGTmpXZ0Jxc0ZuVkc3UDJQeEwwWTUwWHo4L3g3RDhqS25jSHo5anpRT1R4?=
 =?utf-8?Q?szo9KIGMgWNUQLtrY9KVYmq2p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a053a088-1d37-4071-3dec-08dd1917e83e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:41:03.0665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uD58JRPaNzoVFR88JBmugKQqtEJIqUlCDcEqJ93R//nMNVgEAyINtF3Ua6ORdMpY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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

Hi Simon,

On 12/9/24 20:27, Simon Glass wrote:
> Hi Michal,
> 
> On Mon, 9 Dec 2024 at 11:34, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 12/9/24 16:47, Simon Glass wrote:
>>> Hi,
>>>
>>> On Mon, 9 Dec 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Mon, Dec 09, 2024 at 04:26:15PM +0100, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 12/6/24 20:20, Simon Glass wrote:
>>>>>> On Fri, 1 Nov 2024 at 03:18, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>
>>>>>>> Calling empty function when BINMAN_FDT is adding +64B for nothing which is
>>>>>>> not helping on size sensitive configurations as Xilinx mini configurations.
>>>>>>>
>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>> - new patch
>>>>>>>
>>>>>>>    From my perspective there is no reason to call empty function. It is just
>>>>>>> increase footprint for nothing and we are not far from that limit now.
>>>>>>>
>>>>>>> ---
>>>>>>>     common/board_r.c | 7 +++----
>>>>>>>     1 file changed, 3 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>>>>>
>>>>>> This is a bit odd, though. Do you have LTO enabled?
>>>>>>
>>>>>
>>>>> yes LTO is enabled. And there are other candidates like this.
>>>>> Is LTO able to fix function arrays which is calling empty function?
>>>>>
>>>>> (without this patch)
>>>>>
>>>>> 00000000fffc0eb4 <initr_of_live>:
>>>>>       fffc0eb4:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0eb8:   d65f03c0        ret
>>>>>
>>>>> 00000000fffc0ebc <initr_dm_devices>:
>>>>>       fffc0ebc:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0ec0:   d65f03c0        ret
>>>>>
>>>>> 00000000fffc0ec4 <initr_bootstage>:
>>>>>       fffc0ec4:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0ec8:   d65f03c0        ret
>>>>>
>>>>> 00000000fffc0ecc <power_init_board>:
>>>>>       fffc0ecc:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0ed0:   d65f03c0        ret
>>>>>
>>>>> 00000000fffc0ed4 <initr_announce>:
>>>>>       fffc0ed4:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0ed8:   d65f03c0        ret
>>>>>
>>>>> 00000000fffc0edc <initr_binman>:
>>>>>       fffc0edc:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0ee0:   d65f03c0        ret
>>>>>
>>>>> 00000000fffc0ee4 <initr_status_led>:
>>>>>       fffc0ee4:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0ee8:   d65f03c0        ret
>>>>>
>>>>> 00000000fffc0eec <initr_boot_led_blink>:
>>>>>       fffc0eec:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0ef0:   d65f03c0        ret
>>>>>
>>>>> 00000000fffc0ef4 <initr_boot_led_on>:
>>>>>       fffc0ef4:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0ef8:   d65f03c0        ret
>>>>>
>>>>> 00000000fffc0efc <initr_lmb>:
>>>>>       fffc0efc:   52800000        mov     w0, #0x0                        // #0
>>>>>       fffc0f00:   d65f03c0        ret
>>>>
>>>> No, but maybe Simon would prefer if we marked all of the could-be-empty
>>>> functions as __maybe_unused and did:
>>>>           CONFIG_IS_ENABLED(BINMAN_FDT, initr_binman),
>>>> etc in the list instead?
>>>
>>> Yes that looks better.
>>
>> But we are talking about using macro inside array at best with using #ifdefs.
>> Or maybe I am not seeing what you are saying.
>>
>>>
>>> Michal, see also [1] in case you can work out why it 'stopped
>>> working'. I could have sworn inlining the function was a win when it
>>> was applied, but no amount of toolchain juggling could make it be a
>>> win when I came back to it later.
>>
>> Are you saying that it worked in past?
> 
> I wasn't able to verify that post facto, but I believe I do remember
> checking it at the time. If you read the original commit message:
> 
> 47870afab92 initcall: Move to inline function
> 
>      The board_r init function was complaining that we are looping through
>      an array, calling all our tiny init stubs sequentially via indirect
>      function calls (which can't be speculated, so they are slow).
> 
>      The solution to that is pretty easy though. All we need to do is inline
>      the function that loops through the functions and the compiler will
>      automatically convert almost all indirect calls into direct inlined code.
> 
>      With this patch, the overall code size drops (by 40 bytes on riscv64)
>      and boot time should become measurably faster for every target.
> 
>      Signed-off-by: Alexander Graf <agraf@suse.de>
> 
> Despite this hopeful sentiment, I seriously doubt any improvement in boot time.

I am not able to replicate this observation on arm64 or riscv64.

Loop unrolling is not happening even if you pass -funroll-all-loops flag.

Maybe different toolchains should be used to see this behavior.

Thanks,
Michal



