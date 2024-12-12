Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F90E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 14:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E90801B6;
	Thu, 12 Dec 2024 15:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UlTEl+/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71FF4801BD; Thu, 12 Dec 2024 15:42:45 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94117801B0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 15:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoFI0sDQF5sepXAjYZR+KwnULJpHkibKxESgprxOvpCbjpogikM559Yd+6ph3d1ezVDWE8+UBYscPanE/SCjEAtSyIudnW4Or10PXKwGZlDJknD13k3iqV8fHECs4hzd5PaZkLzzNQVeAih0sjn04zErcFdp/oH/rceteBYj6+29Bbg0MbJsG1beWRz6iNDXrHAH6lHV4pi3eBoSd5jxNTaJSzHpf0ttIZD7owIVzBdRYU9EuCUDg+wOMF5v9GWDGrpSvpwxu6HWcnQLNjn4Cdgv6wOqaNBTUu6qOye+FLKErxPGriGdNt5tQVLORR2Sk0nZieycFhzgn0oI1CpiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOLkO8uvCbdJwMpyzFi1WtWG0PR6oOfCPa3eBtGPj+k=;
 b=BCOJ+jbLTiRxSVvjp6+8LEueETKZi/DF+PfzvdWcMWVUKwMJ1BuqAO1gelgJpIVtVZw2kKroDYDTEFNZZgoxuosq946bXS+K9LogddVEN99z6l5AQgvSzJadaPQsTHsiM05gIKAtaediZWZ8f5+CalSeIyW9XsWUHORWt1SekF2zowI6sThw/in0gGyuGr2OvwL3CKx/N/mL9z5hvH38+4jaDJIUJrQ0XzpyJwIBtAg/4VtlWn2/y3XsHzWyaOF51J9n4+cuRPmd2iOkQ/dYexteGj3kMhdloCsvBhGK1sqEwJ9N7NkKfIWzM8avHutyi/GlqeKTUitC1FV2ByXozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOLkO8uvCbdJwMpyzFi1WtWG0PR6oOfCPa3eBtGPj+k=;
 b=UlTEl+/FC0jmxA0I1UjNvm57dUdK1wGMfoe4BCUzjcpxLieGYwEh5QZvNFFRRXETFYa40ux/lPqUuYN0SIcQoJDz91vLZrYakVtBaQ9dQZdxKUokstj+/DSN+5LAg+rCUyOiGZbbSqtmML5Nbn09ivPZLRzCx5zVTCPsbE4geLo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 14:42:39 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8230.016; Thu, 12 Dec 2024
 14:42:39 +0000
Message-ID: <09e7bc07-46a9-41f4-914b-7855485ee090@amd.com>
Date: Thu, 12 Dec 2024 15:42:31 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] xilinx: Fix for v2025.01-rc5
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: f7aa2f45-2c29-44a2-d67d-08dd1abb39dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHBtTGdOeDEvUFl6VStPSytyS3FaalpEMDRmc3N0eWNaNUR3NkJqNFplV1RV?=
 =?utf-8?B?cW5RMlVIN3dzYzZiV2ZSeW9EQUtYZHVEdDZIM1NubS94Szk2K051UWRiTEkv?=
 =?utf-8?B?Y3hWdXJrZnZsTGFuOFJaWjl5dmZEZEQzbGRyVDFVbmw0RXZpZnB6QmRKZGM3?=
 =?utf-8?B?ODVxK3BlQTNBQitIWGkrb3F1c2xkenhoaEtqU3ZSbUF5YjdnN2ozWHFobDh4?=
 =?utf-8?B?VXZ6NUZBbDlaVHZHaVl4TlZ2Ujh2V3lHcFhZMVV0YVZ0anNmT08vdnNjS3JQ?=
 =?utf-8?B?VWF5YmpGLzZYa1lpeDhZZ284UXV3VkVyVjZFT0ZtcVptckNSOFZWemVyNTlN?=
 =?utf-8?B?aUpZOUNWRlZQNXFHcHEzTjV0OEZjcHZjT1orMUxyTUxtbXlZdGhrSm1jQkdL?=
 =?utf-8?B?dHA3M0JqRnVMVjRKWWhLYVJQanlnVXREWmFFUU0rM1RTR3hCYk5QOVBrOTZ0?=
 =?utf-8?B?ZVRFQitXQi9kbEVPTkF6bFMzTCt1eStEWVY1TEJmTkNaMXlGSEh0Tk9ZZVFW?=
 =?utf-8?B?SzJSUDU4T1l4alpBcTdLMCt2S29kcEUyemxEVWdkQVhpZEZzV05BeEJUcEt4?=
 =?utf-8?B?K241eFZwNVlmajh4dXUxR3JEejdpKzcvVWZxM1JzSWdnNG9CWkRYN2k4NWNY?=
 =?utf-8?B?dTl0VzVpOG82bmNnK2NTMjlPaXhVNGpSRXR4RGN3RG4rTVFTU2E1YlI5cFMw?=
 =?utf-8?B?ZWN3MVpOSE5hU09iNlBOdkZZQ1dwMFpPQ0JLOWtaS3RvMlJNWUxiSW5ualo2?=
 =?utf-8?B?NnFmeVVaOWxBWFdIRG5zLzNHSDZIOGJZZ2VOaVZ3SWNSR295QjR0cm1WQUJu?=
 =?utf-8?B?aGlHc2VodncyTC9rYk5JWVorWjJWZEhIcFRYVmdFdm1FKzVnZ2lMNnp4OVFX?=
 =?utf-8?B?LzFNTStDalRlNTkyZ1lyNDUwb0hLNE4xWWJvaHZNZ3N5UlZUYzVwRVNqNEpL?=
 =?utf-8?B?WVJtUENiSHZITXllNEpYR3ZteW01bXZRMTNKellqMjVVQ0dQT0ZEVjlXcE1x?=
 =?utf-8?B?VlpyL1I2Q0o5cVR4M0tsOTlFVzhTRmZOd1pSOFl5bnNxLy9ldDZiT2RjdWEr?=
 =?utf-8?B?V0tYVk9zS1lKZjRtdC80Y1dBVytGYmRFMXo0NjVyV29aYkt1QzJZbG83THN3?=
 =?utf-8?B?OXpqYkJZL1MxeU0zREtHWGxwV1IrcHlTQVFobjROalN0WUVVSVJlU1V6dEVE?=
 =?utf-8?B?dmltdWMvdmdjaUJDS2JUSmt6ckl3cTRFQjAwY3hjUS85WXVSNVQ2V2crSi9N?=
 =?utf-8?B?RzZuRkpqU3o0TlJwUEdHQzJNNWZva0RZRWtWNVJnRWtGU2hVYmwyTUY0Ymsr?=
 =?utf-8?B?TUJsRjNNZXJqenhXcllhZVRNOXRzWU8rUHQ0WEh5YzZvNGU4TjNlZVgrRllF?=
 =?utf-8?B?MTdRS3ZNc3JkdDBwRXNIQ20vSmxwc1lHWFA5dzdoajNJc1hlQTQ5NHdlajI3?=
 =?utf-8?B?MnNoMStZUWdLVGpXeHZqQTNVM09GSS8xV0E1VGVFR1ErMjBvRnBRcDdLbTZl?=
 =?utf-8?B?a3pINjZVQ1hjSnkzcFlWdVZ2M05MSTVGSko0TkxQYTcxL2I5cWJKR1hnYVVR?=
 =?utf-8?B?bkJHUmJWZS90YlBCUUVLL3hBb1JqekV6MkcxYmdnYWhDbk1PMXk0OTEzSVJn?=
 =?utf-8?B?QTJrdnJEWXhsNVdKSmZ3QkhyVUZXU0d3MnJVUk1KRkh0bmQ5M0dKbGpKdHR5?=
 =?utf-8?B?NW4rUG1DTDNSeEhveldIbDJocktxTU9CMTFnZXdCNGdsSnFvMjhNZHBneXFD?=
 =?utf-8?B?YTJqNXpzQWNzRndqdkhBdE41Q0VOV0R2TzdHNklVUUtHZkZ6dWJuL2poRzNQ?=
 =?utf-8?Q?tM7WWTJft531hhT4vgWoEy4mCOWC5NNdfq8DU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkxyOUJTNHJ1Z1pGZ255RFBNYUkyZ2l3NTlyUlNwM3QrdVpVVm8xV2Frb1c5?=
 =?utf-8?B?RmtQUGRXZWh0VTY5aXRCRnNibmlObjM3blBiTjlrZDdCd0VJZytkMzBiYTNj?=
 =?utf-8?B?UHZjUWgxa0xMS0dWaHRNd2VFdjNoWXc3cC9Oc1UzYzk2a0FqSUxXQnVPcFFk?=
 =?utf-8?B?aEdUYzdoZitvQjAyV1B0aE1iSkwrSnhPWDl1MG5YM1dQaUpEQXNEcGVaSGhh?=
 =?utf-8?B?MTQ4WHlqNDdzZDhjczRKRWtSNFNWd0hvYURMUjR5cDB4L2R2NEVtNEo1L21D?=
 =?utf-8?B?WU9PSzlpOHFVWVZqUjY2ZHBhc2p4WTBlQldOVERMaXFMK2w5NDJOSkoxUTlI?=
 =?utf-8?B?WmpoMktQWXVzNnNZakxTU2Zsbjg3Sjh4ekh1c2pHVEtzYUp6akFiT01yUHlH?=
 =?utf-8?B?MktqZDNvVGNFazJEblNoSUJheTRDV09nQlVjbFpxRXkxV1d6V0dTalZWRlU3?=
 =?utf-8?B?OUR0K1RYaGZDRTFMNVorWE0xTi9WS1RtQnBwWERzcE9MK2hvendmUGxKNEx4?=
 =?utf-8?B?WmdXYStXcFJpekdNajhDRlpHZE05VWEvTGdRRHl6ZjBneWJjWnRqRmFqc0RS?=
 =?utf-8?B?ZTg3ZzBZcjNHRWVvRUFyUGFLdzRaRHhQLzlvbnJZMm1jdnd1UE5LbVBxb2Nk?=
 =?utf-8?B?UFhDdXNxYzBxRVJpeTFxV0pvRjNrS3JFaHlaU1laODErZ3FjVE0rMTJ1bjdQ?=
 =?utf-8?B?YzBGcmwzNEFpR2dDOUZoSkxkWGFpMTlmUDVrS1QwVm9CdHkyUXFuYXlNL09q?=
 =?utf-8?B?dzFGUXh2SEtrcHVhcVB5K1VPSGVvR3BaeTRKVERUdVlMLzU1aURIUGVzcS94?=
 =?utf-8?B?SmpSVWVzUzhUNDVKSzFmc21GQWNkSTFVcEw0SGQzOXBvWVB2YTBJMTVQRHZp?=
 =?utf-8?B?R2VjdDVUcXlZSm9BV01DcXNjaTVQUUpMWkVLZGt1OEJPZWNESmZ0bFNObnZT?=
 =?utf-8?B?UWdKWE5Ra08xN29UaENYM0pMU2kvUzhybDZFNmoxVTdndU0wV0o3OTJiNkNn?=
 =?utf-8?B?YmtzclFPUUJmMWN5ZUt2RTVzLzZQOTU2U09XNjYyaktTUTIxb1dWaEJRQWQz?=
 =?utf-8?B?dFp2eTIrZit5aVViNkczSGJWakVGRGxxbzMweFlRUFBEanlEMTVXeXkzRHNi?=
 =?utf-8?B?NHRyQk0yZUtBbVN3ZUtUNVNja1NZcC94SFBVakw2dThkMlZHT0VmSnRuVzNv?=
 =?utf-8?B?ck15bnZSNGllM2JxcjJmblM2WjdqTjljZ2xRdlNVSDAyWnB6dXRtTVRvR0p0?=
 =?utf-8?B?TTlGcDBJYmtWeUlUWVQrVDhETDJLV0tESllFSkZSNmViQWRHRWlwWE8wY296?=
 =?utf-8?B?RDAzZWZ5MjVZUFBicENsaUgyVzlQZnFCWEVvRWUya3IxcVlJRTg2Z0h3cUxn?=
 =?utf-8?B?MStvb1ZBRmtyVHIvQlkrRUFncGR6d01BZXBqY3FMQnhHQjFTbmRtNFdZTkli?=
 =?utf-8?B?b0IzSG9xNEI2SHlFSHBhdGJDb3g2UWZ6aUFJdm5SclN2ejF6bmFOSGZ4Nk52?=
 =?utf-8?B?NkRndEVTQmJndVFqeE1ML2I1WU5YVzJHSHlEeW4ybkdkWXI3VTRBL2NUekRw?=
 =?utf-8?B?ckxwOUdVQjY2UTd2d3BjNkJ6cE1iUE1oQnV1cE16dG0vNGJnS2VzamJYOW9u?=
 =?utf-8?B?Q1lLMnppcElva2pUVXNVN0pZTHkwM0VhRUMyMmZQM0FLOVlQS0VUWUZjUmlU?=
 =?utf-8?B?YXlsaThqZlpkbVl4QlVIcExLRHk3QUNEVk5oVlNmc2dEakI2V3A1MkRwSDFH?=
 =?utf-8?B?U0VxS2dDRnNVOEltd0pySkFlRTJmL1RmSUc2bkxENnNkdjJnUEw5VHVSd2F3?=
 =?utf-8?B?STNnNjFXK3pDQVlSYWNKakZMcS9TWFZWZnEyNmxtMWZaU1BvM29iVlEvUXVn?=
 =?utf-8?B?WmJjNDRnYTF3blFNbHpFV3BkWUU3b0RzZzdYWmx3MG9NZGd5dFR0NUxab2JD?=
 =?utf-8?B?b2MrM1g4WjBqUGlvMWRVQ1JjcEhkOGxuUW9rVk1MM0pxNktyaFQrTDZoSGFt?=
 =?utf-8?B?emxOYWhxcEpQTzZvWjU2czArNW1HTEVIeWV4NDRkdW9tN1ZqMTcwZTQ1WEx5?=
 =?utf-8?B?Mm9rbEJFTVg0aWVGanJJdCsyblZQV2dsalBXT2YvU1lpcTJuUGNrLzBibWc2?=
 =?utf-8?Q?dyDJYYynCrxSQlF/d7qrKHubJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7aa2f45-2c29-44a2-d67d-08dd1abb39dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:42:39.0247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZnDZ0he7s2XGN0UOXYj6WeiNk0zC4HPnH6Nfm72bufTaejjXxzC9vO8mSYmuCm/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
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

Hi Tom,

please pull this one patch to your tree. It is fixing issue on Kria SOM when SPL 
flow is used. Display port driver is touching IP registers but none is getting 
IP out of reset. That's why adding support for reset fixing it.

And the commit 1a48b0be93d48f9ec5498297ec775fb572d3d150 "lmb: prohibit 
allocations above ram_top even from same bank"

introduced regression on SOM
ERROR: reserving fdt memory region failed (addr=7ff00000 size=100000 flags=2)

but this series is fixing it.
https://lore.kernel.org/all/20241211021703.2333-1-semen.protsenko@linaro.org/
That's why would be good to get it to v2025.01 release.

Thanks,
Michal

The following changes since commit b841e559cd26ffcb20f22e8ee75debed9616c002:

   Prepare v2025.01-rc4 (2024-12-09 16:09:28 -0600)

are available in the Git repository at:

   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2025.01-rc5

for you to fetch changes up to 8b81010a2fe385524b58bea9116f1b6954c3d2bd:

   video: zynqmp: Add support for reset (2024-12-11 12:40:13 +0100)

----------------------------------------------------------------
AMD/Xilinx changes for v2025.01-rc5

- Fix reset issue for SOM

----------------------------------------------------------------
Michal Simek (1):
       video: zynqmp: Add support for reset

  drivers/video/zynqmp/zynqmp_dpsub.c | 6 ++++++
  1 file changed, 6 insertions(+)
