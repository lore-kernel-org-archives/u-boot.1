Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943CEC3DA63
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE4288361;
	Fri, 26 Jul 2024 10:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4r7Npggk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6B8884C5; Fri, 26 Jul 2024 10:11:03 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89F7987CF8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+RtQxzjg52LTONDCB3VEhlQdiyjju5I2WWg3TXNOaBiZ815WWzEuqLLV7zkcBUEl157M7c45lMobWTMzTJGBG5xsKn5/Lx8lt3J1W4B9m432LTiEuCOgHt39fE8EAS7M/tBJegDUmnf8hg3jr/M0UK4SKYWi+X0Tg+5pTU7OkAzybjXhI7ngxhuQw4ff2ObSZh9EhZT4aYGYkmSoqOA61AHsFVSK6V1MehSGnMIQ6b65g7BI5b6IXtZfDLCTxEpG7dNXWPZIt40C/usngSPsU+tcwAyVy+qIOGXifycNRpcc7jtvJlG++pjvq1oe8gBqucHIYB+RiIOaeqo/pFH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRdySEe5QhdMeJRR58sXy6I22YrAA1ZxZwlxCd4nnCE=;
 b=oxSBMmftKuZ9YUM/zlg5B1mEhu1FxZgF0clKwGqLadTXx0RGAID+zOjfo1u1Xj0hvHBriwSxhNjLoC4kjmlqI58mOpeIp5Fv5+bYNAz0xXjP0Jey05O+Yhyd3taYqMqawZUYj0wFmZxt/eqnEsKEl3Gb3tH6mVntFpm+39s1imHdtWL0Dng+flM/P0qcW69bzTmtwHfqjPg4n4p4kzNwLgGKtqYLjOJVrI/jPTpr3+jtM1an5eTpqwmFavEo8y0uXKv9mcsekNRap56Hi4t0MRP9sXfqN6udTHWAwkLxB2xr5yIMps5Bj+xNWIGFpjOqqhO7JCVKAfpzJfMyoieBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRdySEe5QhdMeJRR58sXy6I22YrAA1ZxZwlxCd4nnCE=;
 b=4r7NpggkRU5pgN0zskX2NxkVIE4atxFVR5rN2WbO7eiqdt1xEIH08HUf6nePsbo3Zvm3FNmQtbJWM18sX/iQWM3qv/k1P37awtsVdSRti2kJVFNs9wAnZZiBbhx7cwxDykuDImk7YFoIVv/of9UXaPMP62henINPDQgMIyr5oSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 26 Jul
 2024 08:10:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 08:10:57 +0000
Message-ID: <a021154b-6739-4748-8604-b9c7375890ab@amd.com>
Date: Fri, 26 Jul 2024 10:10:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal: Remove undocumented cadence,qspi compatible
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Tom Rini <trini@konsulko.com>
References: <13ccfe6b447c426aad06edbf0b8e52fd1eb97ee3.1721054349.git.michal.simek@amd.com>
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
In-Reply-To: <13ccfe6b447c426aad06edbf0b8e52fd1eb97ee3.1721054349.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0041.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 030253c4-553f-4fab-4758-08dcad4a7a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDl2UHMzRzlGY21yTklVMEFVdUN5dGoyVWNDcXpQNHhROFgyamRYcmtIc3cv?=
 =?utf-8?B?QkJrUi9QV3ZQUnF3bE9Mem15bm9VdnJ2MG9jeVNUa3hUTDFhQUJmS2RsUTRj?=
 =?utf-8?B?cS84aHE2eXJCVCtYQm1ORkF1VjBwTGxmWjhGNXJCNktZMWNjakVzME5TaW9y?=
 =?utf-8?B?WERCTGhMZlFqZlJkaWFGa3NBRHlBdUEyN2xuSEU4ZncwNHFRS3p5RGJOVnpJ?=
 =?utf-8?B?MGRxUHE5TVpSRVpaY0RTN1QvekZuV3BHaDBqblYraTZtVDdKUTdhenNGY2w2?=
 =?utf-8?B?VVhLekZ1WUFMRHg5d0hBUmMvK3JSUVByeWxCcUhHWnVPR1BGdnUweFUxYTYv?=
 =?utf-8?B?MytqdW9xS1ZkUCtJcUw4bWdadXNoQ3FBMTkwN29waWNtdDZTa0hVUGdGZ3Uy?=
 =?utf-8?B?YVlGK0lqdTZZU056bHdqRVAvejZCUUpuUm02Smx0YWhka3FINXd6bUpmK1Y3?=
 =?utf-8?B?WW84cjBkVzNmZUZOSU9kdG5hY2dxR2pOT0psR2M3SExDWjFhb3ZRZGhtSFB1?=
 =?utf-8?B?Zll1NWo1WjdqQU9HVU5HQVNLc1MrR3Rrd3RBbTF0K2NDc2dKckU5c0NaeVpo?=
 =?utf-8?B?MDZaWXVuOFp2anhLZHMrM2lqTFQzeGt6MTN1bjRuSHo0VzRvbTFCbUtKeGQv?=
 =?utf-8?B?ZWh3TjFoZ2pZdGJobFdvUkdzNVhvbHgyZzJ2bHVOZjZlVEY4aVJzYVI1Y3Zm?=
 =?utf-8?B?WWdYRzVqZ2hNdnEyN0dtUDNoeVNMTk1nMGpSZ3piTlhQM0hSQnVKOEhxSlh3?=
 =?utf-8?B?cDc2Rkl4MUVpMFlQN1plaHVwQVVLeVUxSWRsQzJGNmN6NEJUNVVVUEJOYTc3?=
 =?utf-8?B?cWJXbjdhSTE3WU9oenRhLzhnaE5OTzB5QVdBNEN4S3lZZm5HMmlJd09JbzhF?=
 =?utf-8?B?ZUNwLzAxT3JIcTBSU3o1emowbkFPdDhwMUVLQnIwUWJiakZXUjN6TUJsbWxX?=
 =?utf-8?B?RXhCVGo4M1grRTREakpkdE9WWnZFSnFUYlNFdlZGaGRja3RRdkZnZWNzRTNP?=
 =?utf-8?B?Y0VsWGc5bjlVVFQ3MFdWYXg2YzRrVnBZZUtjQ1FObXFaY3FtWWF4T01JdThi?=
 =?utf-8?B?dWJkVTcrTHZjcEV5eW5BRmZFd251RW1ldFpRK0daY1FnRjUrQlBYSGoyUi82?=
 =?utf-8?B?S3puWEhQNk5FYTk3cGlqUGlYdk52TVd1MUxYZ2ZsWWhsclhmT1EwNTRKRjd0?=
 =?utf-8?B?aXdaRjI5MW5XQ00rUXgwREFiM3d4MkxhTGtCb1kvUndBUjJsaHk5dzVpR0NG?=
 =?utf-8?B?SEpyUHg1aFJUNXArL1NNM29CYU5BR2dEZVdRcUJKUmNyUGwwOFZmdFBXakRI?=
 =?utf-8?B?QkhvNTRaNWE2ekFjNU1ocUZyRktoWUxSQWNnMkk3V096cEg4Yy9LaHJRMWJy?=
 =?utf-8?B?Ri9JZFE2SkEyMEdwTFVac2h0Y0toYmZzU281T0VyUnBFRkRWUDZPVmp0OFdq?=
 =?utf-8?B?bWZKQ1pFZjg5T1Y1Z1ovWjBKT0pwL1VVazhqY2FBUm1aS3FZSk5pNW1jeFRT?=
 =?utf-8?B?bzd4VExGeTBDT2M5UklqQnZucUtFTWV5Um9ORDBzb2V3MGhxMGEyRjFJQnpl?=
 =?utf-8?B?YVhGNEo2MUtPMVd6MlptMnpwMXhJYmNVdWJFT1hIUGJRMHNrRVBlbnNOb00z?=
 =?utf-8?B?MWVwYmR1VGtmRFNadnNsN21ZdDZwVHlpamdycUw5V1pYMU9nbUNJcFl3ZUpJ?=
 =?utf-8?B?czN6UTQ0bEVUY2dIekpxOHBHQkhURHYxWHRsTXAzL21hVWNYRWF0MHhhbktv?=
 =?utf-8?B?T252TU5XRXpQZ216ekRnblhBNVJsclFnTXpMdHNFcUZjdklmMTZQTUdjL1E4?=
 =?utf-8?B?dGRxZE5tYmk4RTM1QUNPUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0p6aW9TL0NwVnAxTFRyeXlXR1ZCcWt2dXN3bGViK0Z2MTJSc1dudko5aG1y?=
 =?utf-8?B?d2RJd0tZUGs0ZWM1TFRCQ1h5STJZOE1VanlVYTVub1JZTHF4VlgxWm9HMUxL?=
 =?utf-8?B?MlN5VHZ4Z3Roc1lsbXIxWGF0TXUvekVnNjZzZjFIVG5IMjBWUkZ6dzFRNnk2?=
 =?utf-8?B?WmVxRnFxZ0pOR0UrZmx4ZVhZKzJ2NVUzWm5hcmtnZ2UrTTB2T0x0RVdweFVa?=
 =?utf-8?B?SzByRjJqOXNXTlB2ZWFmOGFQb3p1QThuZWxlSlZiRmFkMEI0SHBmLy9hUUFu?=
 =?utf-8?B?cjJJSjlXRjRDN0NoeHFkVmphUHBkTFp4NDlGZ1p3aGVoRjJyQ2VkUzd3aC8w?=
 =?utf-8?B?OHhCRmFxZWpDTmJWZUdHUGhPWWRZNG5qWDJITzZNSzhIdmNBaXRneE11Q2x2?=
 =?utf-8?B?SE5UTDFXdG5PQVV0T2o1UHZVZ0VQelYzRXdmMUV1R0M1aVVVclJXLzlnRGJD?=
 =?utf-8?B?THpBUzlVaGRVaWtTY0hkcHdQRVlvc0ZDSlljY01WbDZoK1JzSWErV290UEpF?=
 =?utf-8?B?cnZPQ0hSQVlicmVXeGcwaDBQbFFRaC9QRVJKdFBoSWFhZnl4azhnRGx5aTF5?=
 =?utf-8?B?VmdxL3RnbXJ2Ym1wczB1S3Vzd1RydDM5U1d3ZWl0TTd5M25HNml3dGdOcW5Z?=
 =?utf-8?B?S1NUM0EwWGpxaDhhdm1iNnBzRFRPa0hEczlDYnJ4ait0VDUyd2N3OXNrYWtr?=
 =?utf-8?B?U0pZUW5GSUs1Um43WXg0TFd3NW52UXZITVpQMjltZHFvMlZXZ1NPMys5OGZu?=
 =?utf-8?B?TzhoRTFScmFTY2NYZ2pVdTQ4WmEwNlRpRUxNVEJsTGF3c2xoVWhoWGdZOUhS?=
 =?utf-8?B?MXhzZGJpNkRUbzNWZitBbDhlcTBsUGNVemtKallJVDJKc1NmOTJZMTVHaW1X?=
 =?utf-8?B?QkhzYit2NzNPOGFLSnBvNnFpM0dib1o0NDNSbWVMdy9OQnNXMm9hR2Y5c3A5?=
 =?utf-8?B?cXUvZitoY2NJaFVOU1pLOWNPZDZ0cy80bElHUkk0T3JSM3hJaisyZmhPRyt0?=
 =?utf-8?B?SUNqckcyaDhrY0xiQ1kwaGc2NFRDaU9DaHRPdFM5Y0o5VHQrbkQ3NUMvRFcw?=
 =?utf-8?B?b3kvQzZQNWlmWUhFZm9SNSs1NGZFenpMSCtYYjZya1NSVHRiNGsvQ1RvcVRB?=
 =?utf-8?B?U0svTGRyMldyMnFhNmFCOHZ1TGFmQjM1QnFZbjFJR3dyakhrQVp0Rkp4YXRl?=
 =?utf-8?B?QkNSNzY1RzByNnY1L0hCRHoyK0M2VjJ5NG5wYVlIZC9vVWhmUVhjMzBTNHZu?=
 =?utf-8?B?QlF6d1dLc015VkpFVnZYMjBXUkhwa01TUytNVlBPVklKd1Zya21LYWM1MXYv?=
 =?utf-8?B?V1JpK0pIT1Q1T3JHWUJpQWNkdkRBVWMydkRyNEdleWRLQmFPT2l0SjZucDYw?=
 =?utf-8?B?dWluYmlUNGJReGJ1cnpocUVTNWFpNTdNMnM4THlYdUMxWTFkbThvVE4vS2Nx?=
 =?utf-8?B?VnJCRVVQNStkNlk5eVZzWng3SEd0SS9lM0IzL1BERy9abDhHNEZPcGdGL1hC?=
 =?utf-8?B?TWgrdDNUZW51WjRmMXdOVTZkc3p3eWhOSTdrcG13RmxSbStHSTlVaFVtK05J?=
 =?utf-8?B?UFA4ME9CS3BJTGtsdmYwTDBIbzJXaURva3FrVzZ4dVM3VEVma3ZqSFZMUVJ4?=
 =?utf-8?B?amZtai9TMFJVUFpoeE9WRWY2V0JvUWw5d0k1b2YzVDJiZ0w3OEJCY3F6RlBP?=
 =?utf-8?B?ZjJOMXQzUnVveHNNSUZJWXEvemdaYkc1YlB0emd2RHZ2RzNVQTQzWXhzaHlC?=
 =?utf-8?B?bzFBSVBpK0JXMlpHOTVDRm1NMzlTMjdzK2pKdExTem53azdITkYrUVl4eG90?=
 =?utf-8?B?R3lRSWRLTEN4Ymx6akhMdHBFS0dXc0ZZRWdBZnFDdWFmS1cvQmlha0s1eTdZ?=
 =?utf-8?B?YWV5Nm5ici9kZkVTV3RLVnh2SE51Ny8yY2lveWVLZXRaMmo2bWxDRUs5b2FO?=
 =?utf-8?B?aVpOL2F6cTNGdzBydkFsZzVXdjg1TGpMTEFFM3FKM1hoQkxFS3MvY0JmOUI2?=
 =?utf-8?B?cHVvNzJQYkhYU1hEUVluOWlhcUgxcjdvZE8xa1pFYnAwcXI2QWxENFVlcVZU?=
 =?utf-8?B?eHNoT2dFdkZMbUhETTBod1BiWnBvRzZmek1wZXBBalRxTHlVRHp6MFVHMzVm?=
 =?utf-8?Q?wnHoyrvFu2sfMge2v998QKVLh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030253c4-553f-4fab-4758-08dcad4a7a9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 08:10:57.8275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVQjCVPgCLWPjZxTn/sSukvZOYjZVyVJXNbrHG2LakYiVlDXUu0OyyAZtsX5oDyj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
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



On 7/15/24 16:39, Michal Simek wrote:
> Compatible string is not the part of dt-schema and also not used by U-Boot
> or Linux that's why remove it completely.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/versal-mini-ospi.dtsi     | 2 +-
>   arch/arm/dts/versal-net-mini-ospi.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
> index 1abe44f40426..8735292a1273 100644
> --- a/arch/arm/dts/versal-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-mini-ospi.dtsi
> @@ -36,7 +36,7 @@
>   		ranges;
>   
>   		ospi: spi@f1010000 {
> -			compatible = "cadence,qspi", "cdns,qspi-nor";
> +			compatible = "cdns,qspi-nor";
>   			status = "okay";
>   			reg = <0 0xf1010000 0 0x10000 0 0xc0000000 0 0x20000000>;
>   			clock-names = "ref_clk", "pclk";
> diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
> index d511b823754b..a9bf7cc42484 100644
> --- a/arch/arm/dts/versal-net-mini-ospi.dtsi
> +++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
> @@ -50,7 +50,7 @@
>   		ranges;
>   
>   		ospi: spi@f1010000 {
> -			compatible = "cadence,qspi", "cdns,qspi-nor";
> +			compatible = "cdns,qspi-nor";
>   			status = "okay";
>   			reg = <0 0xf1010000 0 0x10000>, <0 0xc0000000 0 0x20000000>;
>   			clock-names = "ref_clk", "pclk";

Applied.
M
