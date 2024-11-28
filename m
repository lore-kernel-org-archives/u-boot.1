Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BF4D69113
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 14:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5934089D50;
	Thu, 28 Nov 2024 15:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cMc1rch4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F6DD89D08; Thu, 28 Nov 2024 15:53:43 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EC0789D50
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 15:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXk/E6wZ0IVCymnOgcQrJWDxrpUYF4YFDfwDZsnBL0FBxjrCkC4+OkzHHfMHVNvSwAttIqWSy5xTf3B4Gdm6xshcLrgho/EdEaw16LJEil7oZCM5SgJj/oMl7ihRo53Pm27rtwESeKNvah/Fobi9p/9eo5KfAR1m6Pnm7DPCwsTVQ/D6a42V4PVxttJpFdX5ejXIRTHuTUAkAJtzgN3N690X6yVw/O60uiUATtgRTbo98IQoLP37svZhzLvFeX6AzMewbepvdgSo0Djta71VGtCOvVKc8gHt5FYvM6uEE/Mj2ryv6c1hL+iFPbnFdKGYrhPg0xHwoc181+oA39ENug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVAMR4z1yoHk5FiNxYbp5iATiVqOu2BftupyHAN7JFI=;
 b=PRHQ4g3Xqlf0bmFsm+A+riMrVmUJFXd7wzqRwnpTxuuK5QQbD6RVJPXFcw/X8AboF8jh1mKR8V3/1WUpf+eWwTFmCWaXSeYIbKC27nn4N1MO2dtlhmz18gVO2eiJNXIF5OeiE17wrsW02lUaEB19ZTNnhKOMzRdkviWeX21SyRBYtiYEgAz+9gPR0FwdFrRNtaBJ/4GfhdR4A+dP6nHn8EWObuu1+LkMKP9wspSrD8oq4IWPBg60h40IX4tQhehg1YNBaPAj4GaqUBz92IwpyTpARUwFoiNIqjf/dSs94MOL6r0M0TOT1yO4h37qAV3r7UBIyB0r3/cqbRUjggwbDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVAMR4z1yoHk5FiNxYbp5iATiVqOu2BftupyHAN7JFI=;
 b=cMc1rch4kGXA72aLHvnbzFrZ+eRWado0Yzs7Fp2VJNufeHd8PfXrluxJAeOxMK2S3EHO9v91pVTU298gDjEOJKyiN+ateIhCTFlD8cF4XYWXAufwmXMTsYPeaIMugTrLBLdIYXiH74ulwLqKUtsP9drug6nBWIWjQjRJzsEYlfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 14:53:34 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 14:53:34 +0000
Message-ID: <54cf5c1d-054c-4baf-b5d9-1775c31d49da@amd.com>
Date: Thu, 28 Nov 2024 15:53:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: zynqmp_kria: Enable the USB onboard hub
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20241126041238.1969723-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20241126041238.1969723-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0131.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ee8ec4-36b7-40a4-b614-08dd0fbc6e6e
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEloZmVaRnJ1d0VCT2NXZzBYNmtLNmFSTTQzM2JEUWJNOFFDbWcvaEttSi96?=
 =?utf-8?B?V2dKL1RYT2ROZ2V0OVFHVUVncU15eDlHV3J6RUw4VlNYek0zV0tTbG45aW1T?=
 =?utf-8?B?TmIxR3lnbDZuZnhjRFF2aWNHUkRYRm5tRjl0VWFhVnVDb0RpYis5aDlOa1lp?=
 =?utf-8?B?VXhIT2N2c1lWcGtJL1JvT1UvUHh1dlk1WkJ4Ry94ZW5tNklWcGxDenpJV0hS?=
 =?utf-8?B?a3ovN01QRVJDeU43eHVoVVlYcFU5cnpyYmpqb0dnZGhpZThyUXVwcUNJU0Qz?=
 =?utf-8?B?dXZCZGxld3ZZTDl3OXN6NGlxd2pjOG10ZlFIU25LclJQTisyMUQzVDNGSGdo?=
 =?utf-8?B?NGZoQVNmRzhiZHJyU1F3VWlFY2FvVTE1UWxQZGhNTWwxZFJDMlVuS0FiTFlx?=
 =?utf-8?B?MzBZcW1aQWZpOEF2LzB5NHpQTGJJQTd4M3ZOWG8waXBwOFNFT3JqVUo0Ukxk?=
 =?utf-8?B?RW9VK1RRajZ6clhrNmJUbUZnWmYrcUhpcE0wTVJKWFdNR0FRQlV6dnRoVDlz?=
 =?utf-8?B?OVdjZTBKVnFqdEpmQnhRRUpSQ2d0VEhHSW5sbUdzMS9KS1lwMFZPWUsxNm5K?=
 =?utf-8?B?ZkZ3T2lWcUtxZFNvUU1mVUU5MWlpWW1UeHRYYnJ6dTRsck4zVk9aQldWMEJ3?=
 =?utf-8?B?OGl4Q3U3bk54MFB3Q3hJMVY4b0lybGNPOGxDSmo3T1VCK1JlbGhyMGJxNXQ1?=
 =?utf-8?B?RU8wb2NKV3FnOGRaZmt3NFloS2ZyRWxIckFNRE1hVDlYVFlleUhtSGx2SG82?=
 =?utf-8?B?Z3dsbjUrUVNIdmZkYjNob0RmQTBMV2JHS2xteGhWVmNrdjM5STFSbk92SUJq?=
 =?utf-8?B?K3RpWm42RURiMTNTanNnL3VsMUxOY2xQTmxlWlZucThZaERPYnB0Yjg1TE9a?=
 =?utf-8?B?OGtXNHo0akhpMCsxbDFEUzdwcHNNd002OTJ1dTh1ZW9IbXNMRmlHM1JTLzVY?=
 =?utf-8?B?TkIxVXAzb2tlb21BRGZxVnBMWVZRcHlMc09hT1Rnb0xLL0krbEV3QlFmRW8x?=
 =?utf-8?B?eXhCdjJ6SGt6UW1PSlZsblIxVkNxd1J5eEs1WDdxc0lzbmN0QjVxcWVpYjhC?=
 =?utf-8?B?ZlljTFVWT09rT3pxc0tTSUdPdm5zUDR1TzYrWGNQdHBOQnpDd0lZZUgwaVJU?=
 =?utf-8?B?Z2RjVE95RDZ4VUpQK1V6bGRySUdXZWFGQzFqQ1IxbXFIbHlDcGIvdEx4bWJo?=
 =?utf-8?B?bWMrTWRQdGs2eXdialJWMERuNm5qdlAvMTB3UTlNNlFKVVhDMFV4ZGp0WFU1?=
 =?utf-8?B?NUplRThkaTdTQkRhZnYwQUxzaWllTDVVWFdoS3VvZVRXaWpNZFZHUEFiMDhy?=
 =?utf-8?B?aFRSbHNiZzYzYkRRZVZFZTZ0UUFrV3FuSXU2MCtCUzhiM25DZmkyblJrME9v?=
 =?utf-8?B?blhoYjRqMXR0S2dOdm1nRDl1M2VncHpwbDVHeVF0VldWQ0hQL1ZybERIRDgy?=
 =?utf-8?B?ZW1pODB5bDZHZ2FiaENyQlpVellHWVBxZlAzcklGNVUwN0tmUW1NaVZFRFZp?=
 =?utf-8?B?eUsyTE1mVjd5K0thY0JJOXpLdENIaWdRZ0V6b0FyVTk1UmRGSFo3YlJSZFNH?=
 =?utf-8?B?NUQvRERCTlhza1MwVlptUE9ieDdiSlpkdlJOclVtNFNMNVJpQXVNSGJ3bk1a?=
 =?utf-8?B?eXhpempsUW83TkVYZmlrcWFXV2c5T2RQS25LNFpXU3JrUlZlOGZySVFvblgw?=
 =?utf-8?B?NkZhNlowZ3ZKbFpsV1pLU2x1ZDZsclJLRTBkTTFBWEhncGhLRUN6dm0wM252?=
 =?utf-8?B?RHZrKytQR1ZIMjVVcG84YXJHb3dwZEZJVCt1bEIrUEhJT2l3VkMxVGQzazM1?=
 =?utf-8?Q?IAt8IJb+xaqrarFnidVw6MCbspWZmaHu4g1nc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHI4YnVIZ3V4SmpUYlNNSkxYL3VORzhVRFgvL3ExT3JkRFFpUjhFTUZKdDNt?=
 =?utf-8?B?V3B0UUpWNVUzN05lWjdROWhoMGRjSjM2YjZxSjVyVGRSb2NKTEhIT3BvNm81?=
 =?utf-8?B?elgrZ0hKTzY4Y0d6eWVRWHJFNmE2RzlPbzV2U3FuRmpRelA1TmgycVYxTEJ6?=
 =?utf-8?B?WEdtZVplK2p5WGc4UG44TzBCVTFyakNlQkg1VHQxeHQ0NEc0TlNQOFZwc2Zt?=
 =?utf-8?B?SDYxMFVnUHdqYno5QWh2eCthZGVoclhWZTFZbEhhY2NMTzJ4L2paY0szYTQ3?=
 =?utf-8?B?by8rSDN1eWdlaGpPSGxNdlNYZCtBUTRxZjhtSEFoWmRYL3hXcUZvdmp4MHAv?=
 =?utf-8?B?ZTc0NWhLNjU2K0RDa2IvUFNWZlFoT3FZZGU0a3dMS2YyVndQWlNDRjdvdkhG?=
 =?utf-8?B?bGtkWlA3OG5ENG00MG9pTEU1UHY5a25WU1pzU0hWZklNUXQ2VC9LdDBYTTFo?=
 =?utf-8?B?aGp6ZWJ3UjllNW1LMnJydDFSMENjY1RodHJobjFHalQ0dDBDOWpaR1JiVkk2?=
 =?utf-8?B?cThlcUNZalZtNDZzUEh3YXozaE5wZnl5Mjl0eVE2K3pvOE1vTDJrK3hXbGlT?=
 =?utf-8?B?RitFWXM2VzBsVU9iSCtoZkkyc1FHdU5KN0lxSm5YV1I3dE9EQTlDTWgwL2dB?=
 =?utf-8?B?eFdTSmxqM1VsM2lGT0o5THdHMHVSMHQvTmdxUk9rOVJCd3hRcCtKbDB6cUZ4?=
 =?utf-8?B?eWVXM0o4QmpSblcwOHJPV3U5dkthQkphVVUxbDZGVjk0RzBlbkF2UlJDbE9E?=
 =?utf-8?B?L0ppSy9TMXFwbUZXMFZuNXRXbG1HeHFSb3M0V1BTL1FYZjFwdk9ma05kTTZz?=
 =?utf-8?B?eElBOUFxek5LVGEzNVkweXJCS0l5MzgwWG9MTUkvTjNkbTBTcGJ5Yk9YQmxU?=
 =?utf-8?B?Q1JvY3RnUkxWUDJsN3ErMVNxQUNCUW9QUXJRNFdFZjcwbStkb0VLRGxSUS9E?=
 =?utf-8?B?eUlPbEJOZmg3SFVtbDdtcVZVViswdFV2Z3VRNTdBelkrL1NOWitZZ3ZZenR1?=
 =?utf-8?B?Rm9uUW80VDJNVVpkajhzV0lYRkdCVUQ1eEpYTEpldS90VVJkaVc3V2Q4NElj?=
 =?utf-8?B?SFg3YTVuV0cxQjUwbXNZUmdKRlZxdXUwUHlQN2JtVXZwVEFRZXhBRDdhSW45?=
 =?utf-8?B?YzFrVWE4OGY5NWxSZmRrSG1PdUdxRDViMnpiakJJb2VPRTkxU3ozbGZDTkt3?=
 =?utf-8?B?MzNHS0hydzJHcWtSZ2xRR2owRFlQcTBtRWsvWFh5a0pqUmpQajZsUHAyRjdy?=
 =?utf-8?B?eVJmRHZ0YXoyVWY2cllmU1dsNUU4dE5YS1JLOHFHVWFzSzVHWHBZTUdNWWls?=
 =?utf-8?B?ZHIwNXNFVnZuMnc3YWtXVHFSZTdRRlR0ODNQcTZRUkgyOXUzOXI4ZnVOSE5L?=
 =?utf-8?B?bmFCVkZDaVNtdkZreFVEUXV5RkxQNFRwWDJranZFM0IrdzVqTjdiVVNlQ3Ur?=
 =?utf-8?B?WVlNSTFQQVFYSHhTRCtXK25SaTg4Z1dPT1dmYWU4alVVSGNLUUlCbmZ3dVI5?=
 =?utf-8?B?RWFaQ3laaDBDOTNSUzEzYVpacDRidDV1THpuTW54WDBXZXJ1WHltWDNEd2lX?=
 =?utf-8?B?OCtldDBheTRaVHU5M1M0d0pRV3JXd3hraWRLcUcwd0xkazFYbzhLc3NiN1dY?=
 =?utf-8?B?RDJjZktLVkxKODB6aE91dG1jK0FuNEZ1RS9WUEc0eGI2TkJ5Vzc4UFFsRkI2?=
 =?utf-8?B?VnVNVkNnNklpM0lIMEduSS9tZjF2d3cvNlNnSURCT3dwd2Fvakhmai83b0lo?=
 =?utf-8?B?QkpPSnluWUU2STE3SjVhc21uMWpDT3ErejJhbS80UE9xUWlPSWFybzlnRTVY?=
 =?utf-8?B?NXJRejU2V2FIWUM0MU1EMVlqYlc2dTgxQnZ6c1BOMGNQa3lTODk3aXNwdGNX?=
 =?utf-8?B?bThLNnU1V0g5NWNFN3ZBakZyNHNsME1ORStnamZJalZRZHoxdVVFRUxpNUE3?=
 =?utf-8?B?M0lJZHZPVVYzMnpDS0hLUURqd2F1aFJiVDlhUnVjNHc3b1g4QW13dS9NRlBM?=
 =?utf-8?B?M21PSWpVVmlDYTF3UStJbFVkQ2hDSEF6dVZ1bVdXcFZEclRJZjZyS0VJanlJ?=
 =?utf-8?B?ZmdhclNORWkvN1QvSnIvV1IrRFFqelBlbDcrRUVxZitLeWhKa2YyRjJvb1ZN?=
 =?utf-8?Q?yC69phrr677RjJ4cPf0IQRLmp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ee8ec4-36b7-40a4-b614-08dd0fbc6e6e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 14:53:33.9854 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wvy9PU1JP+NFCJzHFi34Q5hvrIJajvmQ2GY8tR5xTLQp94REI+ItIgSgYiTDtoxw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
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



On 11/26/24 05:12, Venkatesh Yadav Abbarapu wrote:
> USB host support on ZYNQMP KRIA SOM needs onboard USB
> hub driver for handling reset GPIO and for i2c initialization
> sequence.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Acked-by: Michal Simek <michal.simek@amd.com>
> ---
> NOTE: The usb hub patches are merged.
> https://lore.kernel.org/u-boot/20241125041202.980-2-venkatesh.abbarapu@amd.com/
> ---
>   configs/xilinx_zynqmp_kria_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index e5ffc7076f..1707a7ecf9 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -207,6 +207,7 @@ CONFIG_USB_DWC3=y
>   CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_ULPI_VIEWPORT=y
>   CONFIG_USB_ULPI=y
> +CONFIG_USB_ONBOARD_HUB=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_GADGET=y

Queue to next.

Thanks,
Michal
