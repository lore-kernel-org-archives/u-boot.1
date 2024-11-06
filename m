Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6F4D44D51
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 11:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3097988FA8;
	Wed,  6 Nov 2024 12:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z9VVTUQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A663188FA8; Wed,  6 Nov 2024 12:47:31 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D8B48862E
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 12:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcXVao967RTJUgHuKW8xxVkUxLZdn80uGM39cmCXdXiQJbQAhufHQ0JpNk963n2XSorKoZzBk+tkB2gt7cWLm4pX/mmbpYm+qcnYbglOlDKpJN2wuKEebMqLZFTTjzTepzQtmKj45sz05CrzCyvU4Hm7gN5jJw570I8W4a17nLhmcpC/vsjCAPK8hpCnTEJCj2a4r1aTzS0pdR0GtCM/U8JAWjWpm3JnhNZWRoH2xKxfobdmNPR8N3RX03BPHx/G7xiH95OyoKJJUxmZw1BXE6H8GOufn2xXau+8yMRDRukIMIXpvDJCK54OTYwlSD0O/DubhRtI/ETpI6lZGJsBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHrWR0+En2hCs1Mbd7iWiBhm5RytFtpWH1/Od2dfcqI=;
 b=eE9NzTdN8s0XW5vfmymuz3X8QEqKZDBbocogsc9h6L7KvLCvr4p8YIATDBJIJQ7CIpISDH6eOAWwvvufZqLCBwv99mkzas48y2acyJw0m18Sl3zZuYLq41LQBS5TlnnJKqsq3BT9DGNCeqS3QZlcx7T77JKRdeIlz8NF12v8/j88DZpHiOU/IRuvQPHXb/SrIOsrJ3tiExy6IIZKYAFRCq/9SoGfTw/jFlX3KPUNeG0jhRbqOxGuyv0ktt5y4naOIsnIj9l14K7kV2fBpCN40yS0OtgqQ4qPyhD0qNgbH/LHAzRGCA7uQR62vwLVHSdu3i5/J5eJKN0ddXoLvhqeoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHrWR0+En2hCs1Mbd7iWiBhm5RytFtpWH1/Od2dfcqI=;
 b=Z9VVTUQgtp1UbcYujNigh7kzh2lkegxwzBSBhzTEyl+Ooi9r16wF9FpdSIq+ooVDk2hBNjg0Im04Ih7/0648cNlDZ1R0QmFKcbWltWxmMjSVvf6CjLjqj6By3NwBbuX2c9DHQhyzl0XLREx8lx1DFMLOsvGp7mEOpyIAMDOFT9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB6492.namprd12.prod.outlook.com (2603:10b6:510:1f3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 11:47:22 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 11:47:22 +0000
Message-ID: <f52cea21-8171-4fa3-9fb6-b8e54344fd0d@amd.com>
Date: Wed, 6 Nov 2024 12:47:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cadence_qspi: Refactor the flash reset functionality
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 git@amd.com
References: <20241028092430.19841-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20241028092430.19841-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0026.eurprd05.prod.outlook.com
 (2603:10a6:803:1::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB6492:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ce38b1-70ab-421b-6c72-08dcfe58c658
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dkk1QmRSQndsQy9mLzB1aHA1OEN0VDQ2VlRBcXRHQlJCRXZFaUJvV2svSC9T?=
 =?utf-8?B?NUhmWGNnNCtOU1d1S0tJUnRKL2JnU0xsQTlVU1Y2V0NwdVpmWEd6cEU0YmhD?=
 =?utf-8?B?UGFYZE9XZ1QwamdNdXVHWm5RU055RWFlSFBrL05MMkhTYkNrQWJNWjkwYkF2?=
 =?utf-8?B?S3NSaXVhZzR2VHp1YXlSdVgvdUhXZ25kSkRabHRQUHNmcFcwOUl3VkVlOW13?=
 =?utf-8?B?cnFHQWp1dDQ0bjNtNS84M0Naelk0OGZGRXgrRDdOSHhnVXNRZC93U2NvY0FN?=
 =?utf-8?B?OXgvT1g0dnkrcEF3Rk8zNjZRaXg3ZDRvb09YVDNpQUttZDY4N0dOeEI5T042?=
 =?utf-8?B?dksvUHowM21pdkpTejU1UTg4bEwrQ1NxK3FMalZlNmxvZmlMYUkyVXpscjhs?=
 =?utf-8?B?SVNsY1d5blJjWUEyeXRFSnJreWxJRngzeW9zSG1YL0VMUkhuQXRSOFQ2aWQ4?=
 =?utf-8?B?NjNtN2FFcXhIVUt3dkUvb2o0aWdILzQyYlF1MXBmWVpVN2xsUmpwci96RWJU?=
 =?utf-8?B?eVpWZFNMckdVeGl5V2hQbVhvTGZ3TDBNNXl5MjFUS1Z1cUlPSm5LQjNudGVR?=
 =?utf-8?B?TCtkZGkxSFVDTUhZMHFzTTVuS0dnb2YyMmJXR0pRZUtRdEVWdlFVM3diOEs0?=
 =?utf-8?B?SlVJZ2NjOW5LWE5vMUdydVpEKzZlNzlKb29Fb0s3WVFSckVMN2lCdkQrZW1Z?=
 =?utf-8?B?bDJMUXB1ZUZ0eVdYbnN6anM0LytWY0EvRGlpdTN4RkJPdE14OWVUbnFtdm5I?=
 =?utf-8?B?dERiOHlrWVFZelVYZCsvNDl1aUxvRlZLcCtxa2NOWnV6V0cvNGJtUFhocVpq?=
 =?utf-8?B?MENIVVFpVWwycGFGbmFNVlN4Ukd3djJndGhWcERxSTFLOTc1YVhwbHR6SXVn?=
 =?utf-8?B?UzlxRSttNGtVQW0vV0NteUVsVDZhZzJrRjE1M0UzWWhKS2RHZ3FKUGN2bFVq?=
 =?utf-8?B?ZWwyalgrTWNIL3NNYkt5L3dEcURoL0lpdlVaRGlmcGhwSU5jSURIalhJbmV3?=
 =?utf-8?B?d3oxMU54dnF5Zkt1RUw4Y294SmdXTzVKcmZZd0hoMEhUSzExVE5Ia28zQ2V5?=
 =?utf-8?B?b095R3FrOTVYMjJiT0VBWG1rNG8zSXBvTDZQVFVKZjFlekR2MGNVQllKVGlT?=
 =?utf-8?B?VGpLM2k0SGlWUEI0eE56Ui8vT01tQ1VnZnNBejZvU0VUVTBnYXhzSlhqa0k4?=
 =?utf-8?B?K25OWThSMG41UGcwclF6WlptOXNFUSsyUE43K29iVGZYL01LQVNoaDlYRTQ5?=
 =?utf-8?B?anVSemZrZnI4NWtVOTN2U0V3T3J5eU9zK3NRbSt0R1p4WnhJVmtSMmxQTkFz?=
 =?utf-8?B?eG4wUSttTVcwME1WZEtReDhiaUg0RGkrVGErTmJzU0dycWxoTGJwNHk5ZFVJ?=
 =?utf-8?B?dTVtcEN3NzFFeE1HWGlaYXgzdi9HYnJjMkdETnIrSmwwTjhOUVIyR2xsbGtK?=
 =?utf-8?B?bGYreDZFc01oN0JMYXRYQlhSL1ZVZkFDcXFqZ3QxUGFwOE5ubm9ncEdEMlhy?=
 =?utf-8?B?U0NhT0x3VEl3UVhaMVNvdEozMFFTV2hzV0dVTE93UU14T2tNdzJtY1V2TUNm?=
 =?utf-8?B?a2ZTRGVob1kxOTArNTRLUWNwOFBqSVdnMmlaWUVVcmxxZG9SazNCb1hDRmJ4?=
 =?utf-8?B?MHg5VzFZWjRlSHJWTEIrTmlveDVWdU1YaTIyUFR6eTl4Szl3QnBBQ3gzUGV1?=
 =?utf-8?B?dWplNFA1R3dRdEdXYVppQ3dCNFNQRnRoeHNxd3g2ZGNteW9xcWNmQ2g0ZU56?=
 =?utf-8?Q?qAWM7x8HuZiVtwWGq6QUYk7yfyPgsffsqKla8/n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlUxbm1aZkxKd1F0cStOcndCak5ROGp5WjNrbml0NzdYdThySHFrczd3cVVz?=
 =?utf-8?B?SWthbzZCYjlaUy95bW5KRjhaRG1IWTQrQ2pPOTJERndVMk1JdWduMkl1dHlM?=
 =?utf-8?B?MFozWVRyVmtJUXBZaHBCMzBMRXl1cGhIUmZZNEEzdGxVbXFqZ1N0S2hSM0Z4?=
 =?utf-8?B?KzFPN3E2bm1UWmJXOW5ERURFMDdIQ3NLTktFa1FMbTI2RUoxS3RDUkRhZ1RJ?=
 =?utf-8?B?YTkzb2NVNlZWUWRRdGE5OUNjWGxDYTZmZnZGdFphS0NOa0kzdWd2WnZyR3JD?=
 =?utf-8?B?QTN2eWwrblJFZVRzNytPcW1BQ1RXVjhaaXM2cUhGcHNxTlFLNDR3VlJEM0wr?=
 =?utf-8?B?cUdiT0FURUNZempONVFmUUdkT1FKZ21RZURVSWNmVnBmclVIbEN2bzA0WVgr?=
 =?utf-8?B?VWpnZitla3huWHNFWGczcmtsbmdjaTA0WERyYWdKMC9LaXhOZFBHblNRNisx?=
 =?utf-8?B?ZlBNdVVtM2NqYldIbTRna3FReW9HNXBEWGlhdmMxaVhpR3g4Q0QrRU02U2lV?=
 =?utf-8?B?em4raUF0ZUtweFdYMDRhTmo2d3JSU0lFWjRrRU9vUmpMZGJjbC8rZG0yOS9r?=
 =?utf-8?B?MWh4UEkwWGI5UnJZNkMzalFxL3hjazR3RFVwaVdNc3BOdWZCczEycVdRdk5v?=
 =?utf-8?B?ZGl6OTB3ZVZiaHkwdlE0RGJsdEZBbEEzaENZNXZyK0VWZ1UwL3gwUklWdnZR?=
 =?utf-8?B?eHlFSlhNeXhtSVM4eW96ejhPZEJqNUNCNC9CUnowTlFXQkRxa1BHYWxjazhL?=
 =?utf-8?B?WlpuWERNVVYzSXhldm5MdnkrMVJ5YUhqemxyNFBsdWFCaHBMcGpvMDV2TFNi?=
 =?utf-8?B?RFRPUlI3WmlDVmRzVFFYNU5VRWhYYVdpZHdEanNsaTJqd1VUaVZZSzJNZGk4?=
 =?utf-8?B?SkoySjNEUG54UUU1cktQcG8xNDczVEF5UXp6c092U3F3YVB6N2NsTm1uVjNo?=
 =?utf-8?B?dFlsMGNIYXNkc1Nhc0ZDanVqempCSGJybFEvZHFUZS9qc0FTbzBFRFhiYno5?=
 =?utf-8?B?RjRJRmRaZ0QrY2hsVXJYMkJQSTdtZUI1bXh4S0h2WFE5dUYyWGcrQXBIQU52?=
 =?utf-8?B?cUpnQlE3d1RvRDNEZXdlQk1ob0gwZVRqYkhsVlljbVV0VVpEVmIraEtJRldR?=
 =?utf-8?B?NnNnK21DSUg1SkRzb04wTDI1RWtxeHZ3RnpiYlVMM2d4VHlxRlFXdkdJaENj?=
 =?utf-8?B?QkVTNTNHMkxTcnBlQ04zeUR2NGlneXE3NU4yR2p1ZFNJY2lFZUVLeTRjZzhP?=
 =?utf-8?B?d0ZTN04rRHBUQUxabTFSRWVUMTh6NUZ4bC9pY3BvK0s4WGl2TjVBc1RLWG5M?=
 =?utf-8?B?ZnZFQ3BrcG1CL2ZNeWY2TDZvZFNsSlRVSi9GTHNYV1g0Ly84MytsQTVVL0Qv?=
 =?utf-8?B?Mnh6Ym5FQ0FhamlPYWFUYlI1bjJtb09FejJ6SFRVUlVxaG9QNU45Zmh6Q0o5?=
 =?utf-8?B?RXlHTGIvMzdNbm5xWnNGNFJyOUNGalZpTFR4WGV0a2lJOXVkZmUwTDRWL3VX?=
 =?utf-8?B?UG1DUm5iMFdBb2JuQVowdjVrSEhacDhFVzlYUGhTb3V6NEUvRzdTemZqT0V6?=
 =?utf-8?B?aFc3SFoxVTMvV2lpYksvd1psbkQ3YmlxNEp3MHVDdnBXc2xSTG1PV005eHY4?=
 =?utf-8?B?QkRadUhvRWhhR2pNWlRVV0Vld3FxUktVSjI1aXEvMWh1d3RhK1ZLNVJ5Snc2?=
 =?utf-8?B?S3ozOVFJSC9rMEFuekdQNm14cEZIQ0ptUXBnc3RyMG1MTXByY1luZ3dQREZZ?=
 =?utf-8?B?d0R4L3h6N2ZWT3BlRlVYZkFYZ0RNSjROQ0JlUWc5Qmo1ck9yMTIvYzFWWHdU?=
 =?utf-8?B?bExyTEpuSGZ1cVRxelBCT3NkQkwycHFWcEZCNk8wL2ZMN2Z3L1dwY2tCT0Yr?=
 =?utf-8?B?VnNJQTJxUktlcGF0SldaVi8yY2h1ZXhISmdXdnA3MUJiMGc5eElEMkpPNEJ4?=
 =?utf-8?B?S01YSTNTdEgyVXFKeTM1V3hlUGlwZG1rYXRKWnFpM3pHcGFXSnVZeUtwTGhm?=
 =?utf-8?B?SzBVVEl0dWVCbUw4TlpzaHhxVXEwQzdtb3J5K1pZNEIzSVp2N1l2UXdoMldE?=
 =?utf-8?B?NSt2azU2NVdkTHJBMG9Tc0N3cjdYZUhYeU5xUlhDRitvZkZrcXJVTk51SGJy?=
 =?utf-8?Q?5qQvGroZMz/0ztuuuRF760p66?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ce38b1-70ab-421b-6c72-08dcfe58c658
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 11:47:22.0509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5pRFuQ98jDoYY4K1UfiqUHoj4226bBBncyW2slSvLN9sFBBAaeSDZBotyMX19+5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6492
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



On 10/28/24 10:24, Venkatesh Yadav Abbarapu wrote:
> As the flash reset is handled in spi nor core, removing the
> flash reset functionality. As the configuration like tristate
> and hysterisis need to be enabled by the cdo. Handle the flash
> reset only for mini u-boot case.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/spi/cadence_ospi_versal.c | 43 -------------------------------
>   drivers/spi/cadence_qspi.c        |  7 +++--
>   2 files changed, 5 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
> index 222f828f54..de51e4c37f 100644
> --- a/drivers/spi/cadence_ospi_versal.c
> +++ b/drivers/spi/cadence_ospi_versal.c
> @@ -125,48 +125,6 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv)
>   	return 0;
>   }
>   
> -#if defined(CONFIG_DM_GPIO)
> -int cadence_qspi_versal_flash_reset(struct udevice *dev)
> -{
> -	struct gpio_desc gpio;
> -	u32 reset_gpio;
> -	int ret;
> -
> -	/* request gpio and set direction as output set to 1 */
> -	ret = gpio_request_by_name(dev, "reset-gpios", 0, &gpio,
> -				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> -	if (ret) {
> -		printf("%s: unable to reset ospi flash device", __func__);
> -		return ret;
> -	}
> -
> -	reset_gpio = PMIO_NODE_ID_BASE + gpio.offset;
> -
> -	/* Request for pin */
> -	xilinx_pm_request(PM_PINCTRL_REQUEST, reset_gpio, 0, 0, 0, NULL);
> -
> -	/* Enable hysteresis in cmos receiver */
> -	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
> -			  PM_PINCTRL_CONFIG_SCHMITT_CMOS,
> -			  PM_PINCTRL_INPUT_TYPE_SCHMITT, 0, NULL);
> -
> -	/* Disable Tri-state */
> -	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
> -			  PM_PINCTRL_CONFIG_TRI_STATE,
> -			  PM_PINCTRL_TRI_STATE_DISABLE, 0, NULL);
> -	udelay(1);
> -
> -	/* Set value 0 to pin */
> -	dm_gpio_set_value(&gpio, 0);
> -	udelay(1);
> -
> -	/* Set value 1 to pin */
> -	dm_gpio_set_value(&gpio, 1);
> -	udelay(1);
> -
> -	return 0;
> -}
> -#else
>   int cadence_qspi_versal_flash_reset(struct udevice *dev)
>   {
>   	/* CRP WPROT */
> @@ -209,7 +167,6 @@ int cadence_qspi_versal_flash_reset(struct udevice *dev)
>   
>   	return 0;
>   }
> -#endif
>   
>   void cadence_qspi_apb_enable_linear_mode(bool enable)
>   {
> diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
> index 9c466f8695..f8c3fe8428 100644
> --- a/drivers/spi/cadence_qspi.c
> +++ b/drivers/spi/cadence_qspi.c
> @@ -258,8 +258,11 @@ static int cadence_spi_probe(struct udevice *bus)
>   		if (priv->read_delay >= 0)
>   			priv->read_delay = -1;
>   
> -	/* Reset ospi flash device */
> -	return cadence_qspi_versal_flash_reset(bus);
> +	if (!CONFIG_IS_ENABLED(DM_GPIO))

I think this is not the right thing to do here.
Because there could be boards which requires to do some other GPIO handling out 
of spi core. I think this patch is introducing limitation for nothing.

I would keep origin code and just move this condition to
drivers/spi/cadence_ospi_versal.c

M
