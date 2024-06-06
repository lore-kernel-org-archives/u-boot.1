Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B399C27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9B6288395;
	Thu,  6 Jun 2024 14:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2b5LybM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B379688274; Thu,  6 Jun 2024 14:07:45 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15D6088395
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:07:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/THweyEm9T3DGqgnpL5L19a3u75/CJIa3Ma+DaXhjEhA7dZsk31/f+Wj4Lh8EE4UMevKL50K3rs6mWrRArfXwMTkY5L4riuMSf16aXnMFmfl5rcL1V4YigYdgVxQr1y01235NDcuMOLumoW0JUyUs2jAYvGPY3MdqWn/d3RlIogk24hiI4y5Kh4vmdkLoRbz2z6vzjf7i7jZ1/hGtG2aij58nuwzE3sYtZVfPqd47ZAW5P1OSA7utkBFTsTxqaFyqK741upY1Y891vsGdxIHuneNIpIKD/WrYeaqSUgN9ijCkZxIKtLzLbSZAtFVm+/LyQHYX/FOR47ADpS4SRvYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu2RjVyxGtHjgTWvsMSHIDT6hM57EQyoqfEXWTWgDiI=;
 b=cZ7ijPbepozlKHrw/gv7XkMTBZfP1WRluSNOEBd0XW5vu2ed2FYe+5uD0ocG8SvKxRdtxq+O7hMJ2Xmpffpb6WuT93GqErM/Im1137yPx0a+mBeCQa8ot4xhVJDkeEjEee+2fTB72BZyjgJShmEWdKVTQ4I8ShIxvDLkUi72+j8LKWSUaiRpiRHWp6v/yKRtbQsmvRWtr7Dt6Qg3S5pSHOV0WuxpNllXF0pw0cHAnU62sepxgmrVjDqKjNGjPwEuXqc97MqdGQef20pkonEXdFqoM/XHKdtlUU16PdSF51irjrpvOCspUMjujTuaZ4RGxi8ZQbTgJa2v57yyATtoig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu2RjVyxGtHjgTWvsMSHIDT6hM57EQyoqfEXWTWgDiI=;
 b=R2b5LybML3QC3svj/QzGbraW94abQxQECFq8XkSNUg2igOI2jv/LMb74nuJB7oxP0xPq1j9gJM8KbG6IUzGVENxt6+JMJUHvQjBGAOj3bKXTkSweAe7O/wqE8KgsgNicxDYCj/4pkXWIgGXfVsvhzwnHpPuLAEuXhCwi33G1eUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 12:07:37 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 12:07:37 +0000
Message-ID: <ad935cbc-9f53-45b3-870e-5b51149b2d4c@amd.com>
Date: Thu, 6 Jun 2024 14:07:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: zynqmp: Update the usb5744 hub node as per
 binding
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: marex@denx.de, fabrice.gasnier@foss.st.com, git@amd.com
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
 <20240605100221.3571-8-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20240605100221.3571-8-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0215.eurprd08.prod.outlook.com
 (2603:10a6:802:15::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b40b44-0930-451f-550a-08dc8621417d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWJYRGJzVW1wQXNaOCt0dTVJanVQaEtsQmtQaUZVVlI0Ykdid2FqRnRTam5u?=
 =?utf-8?B?VjRtNzYzSHY1bTRYSVVMQzdVMVo4OFIyQWVUdzRyNjJiVERmUmtzbWZHZEFp?=
 =?utf-8?B?Q0Y2TFUrdUZ6OEFGcFlqWXY1b1RhK3hDRExsZ0JhR2RrcGF0TFNSL1o0dWZL?=
 =?utf-8?B?ZDZCbUMyU2gzaEkrb0dVb1I2MDVDNVdYTzZwMzNSM1FFNENMQ2tvZHBMM05E?=
 =?utf-8?B?cktQSDVlbTh2anJvNTBvOGY5cWlvbFBTb29mWmsxMUJmUzIxK2l1NklnS2h6?=
 =?utf-8?B?ck9zQmsyMlgrWG5FdWdqQzNYMi9neks5N0hySldvZFh6bmNRTkdPWTJEcHgx?=
 =?utf-8?B?N1BMaTVnU3BMRGN3Q3dCWmtveUhDbW5xZms4eXF5REtKRFpVZCtDdXJZQW9J?=
 =?utf-8?B?b2t4a1lMZ3lQWW5DajFBZVVMb0d1WS93aEpaMC8zazUycU1HWE5KcGF0UzUw?=
 =?utf-8?B?UC9QVmFlRTRmRVdCMm84cThWZURDdFZvWFdUWFBmUzRRajcxVzF4RndyYzhX?=
 =?utf-8?B?cC9wRVFSRW50b2VOK1NhbXdxL3U4VUY1K09RWXAvSDBDKy9kUThUMEVHQzJw?=
 =?utf-8?B?MnRiSGk0cU1qdnhSajZrTkVzVkZrNHdjUDhSTFdjNmtlTGhoc0tkS2JqOXh3?=
 =?utf-8?B?MXU2NFByZnU5NDRqa0xQSlRJUzVPNnJDcjFBYlNNc3B4MGFGeURKYnluUnB4?=
 =?utf-8?B?d1ZWY05ldzBTQWxBQm1KaWRKSHhEdHJSaXBmSXBoZEtRbW9GZDFBTklRdjJR?=
 =?utf-8?B?TXFlaE5EUzZUNEVUNUlpV0lxVjJZaVpKeHJPbzBUTndiYlpqWEwrS3MxdDdU?=
 =?utf-8?B?S2FFdUlsSU5oWVByMHlwZzJ4OURQdDFrcWJqYlBHamlra0lGdWwxZTJCS3Fu?=
 =?utf-8?B?RkZkZmdBVHV4cTZVTldyWUswRzNYUGVJMEU4OUIwQVZPTnJlVmRVVkJYMFQ0?=
 =?utf-8?B?dnIrUVZPc2pLN0ZlYkxvbS8yNkpMVzhCcDB5YXZXdDh2RHREMEdvYS9KRjVw?=
 =?utf-8?B?TjJycU5HMG9DN2Npa1VXT3FPa1Q2OU16Zit5TDhTVnJ1WVlkYmxaQXMrcGtU?=
 =?utf-8?B?WUdYSlErRDRsVkkwYVZ0YzFSSkVReHd5RktJckQ1RlE2Z285dUtOZXZKYUt2?=
 =?utf-8?B?djlZVXhaR0hNanNlZG8xOU1mTDMyc2R3dGt1aXFPSUVJdWNYT0Y2RXdLU3RJ?=
 =?utf-8?B?Y2dKZjJ4Qy9rZm5hcE9RVlJZK0JRZ2E3S2FyY3JoRmlhbkpKSU1URXRsRVln?=
 =?utf-8?B?SER2VmhjSU4xSTBKUDdBZWF5UlgzSllzTjQwM1FXU2FEMFpJbGdpUDhlSXVs?=
 =?utf-8?B?eDRQOWJFRGVMZS9lUVlhMjB6SkNveXNSWFBpaXpBSzd5VHJLeFh6K0EvVGdK?=
 =?utf-8?B?L1k1elp5MkdMeEcrSklKd1Y5K2FRNTRBWjJUcmozaE8xK0VMRTM3SEY3VHEy?=
 =?utf-8?B?VXFmZGxaZnhpcDBwVkh5RW53a1djMTg0MDhvejRkcG1Jb3U4czZKYjhZTlRk?=
 =?utf-8?B?WXk5R3BwZnRQNU9EVEZFb2o2OTBicFdvcUd0NGR3bjFGeS93ejBHdGdraDBl?=
 =?utf-8?B?bE9mY2hIeEtVNU5ZYWdxWElrWE5seC9qSkFpTTMzNFVMWjdWNnoxaGRhbndy?=
 =?utf-8?B?N2Y1S0s4T3NVWjA2Z3RzMXRuM29sWTFTU2pJdUMyY1dibDNOSWY1KzdsU3RG?=
 =?utf-8?Q?Kp+M26i4USPw6bXZ0S+T?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3V4NWtsSmVrMGJvckhhMEdackQ3SkVhY1hPVEk3c0paYURRTFlRaGZDMlNM?=
 =?utf-8?B?S1oxcHdnQk9VeTU1WDFLVDFiYnlVQTNPRDNRSUxMakg1RmtHUjk1dTVCOW15?=
 =?utf-8?B?eHlPbm1qQkVrNktmeDIzL2ZIYlI2T0xLa2lPd0tNdzVJV1NLWjZRQUpFMEhk?=
 =?utf-8?B?K2U0SXIyVHRJeVkxM1lrSHVOMklIelVqS1Z2bHZ2TGIzeVlHVmpZa2ZWaFBo?=
 =?utf-8?B?Q1huQWhpbHFBbEtjdks4bG4zM3V1dXYzUWljQjNuV09nQ2gwVEthZHBmdzVm?=
 =?utf-8?B?UmF1THkwUU8vRFdWVmovNWJ5YlN4TXNLK2VhWk4xUjk2aEtWS1NTRFp4eFQw?=
 =?utf-8?B?bEk5b29XZS91VW5ueWZXMUhzcldTd2h1R3MwU2EzM2dETEQxK0thRGVPUnh5?=
 =?utf-8?B?SVNwUDBZaUFkOEhtMWQ3ak0wOG5CTVUrbkkveXVONlVHMHBKUWNPV04rT21h?=
 =?utf-8?B?bVVnSFo4TEZ3Zkh0L04xcTZtamlZQno4WFA2bjYweUZ5ai9DSWo1WVl3alhz?=
 =?utf-8?B?ZjU5N29kNkZIWC92OXoza2dhcWR4T0w1dlpNN0QyTE5uTHc4TkI4SWJic0I0?=
 =?utf-8?B?ZFRQbWxVZVVlK1diSGg5RmN3aDZBSm1oVjEvM2NKbzB0a3R0VXppMGx5YUtt?=
 =?utf-8?B?TzV6TEZxMVZIcVFORS90eDlPRlI5UjVFM21Eb2YrbEMzUG8vYndwb0NNZEVB?=
 =?utf-8?B?L3lFRG1zN0NYRG5rM0w2QWphcVhOM0FZUE1WNFRSREh5UHdqYVdDSHY5Sndj?=
 =?utf-8?B?bDNQbzJrVEhWcG9wV3pvVXBmMGQzSHNaQU9ZMW8vY2M5SHJ0SFVjZFdWeSsx?=
 =?utf-8?B?bUlSQUdOZFozNUdMRFhOY3o4Y0F5amN0UmtBYWdIM2wzUUp1Y0lIQmIySU1L?=
 =?utf-8?B?U2NNMXdJdnNVMkEvR1l5MjloYXY5YS9aKzlJVURZLzdkV21nbEJTa1JnTHFi?=
 =?utf-8?B?cStnTHJ1NEovL3FrMklUN3lwTE9PRGVNMHlGcDdIQTRST1dUL1FTQVduT3JT?=
 =?utf-8?B?eGRxOEd6bWwydHB2WE5Gd2p2c2I1SWMwb3ZQbE1SakN1WVZWOUtFUUsvUWpT?=
 =?utf-8?B?WWZ4SXN1OHNoUmdxOEt3dFF2R2JJckpOM0s1eERvbzhaYmszK2hWamlDbHIr?=
 =?utf-8?B?dGdhL0RQV2plYml6d2V5T1lYT0s3VFpNYVNnWXM3VjdTY1NMc05qN29kTWlR?=
 =?utf-8?B?MlFWelNXR0E3U3RMRnI0QlZqVGlJcmpPbmgxN0VmVlhSankwMG1WTzNhcDR0?=
 =?utf-8?B?YTdWdWErZ01ZYVpWd0xuOFVQcG1IeHg2YkQvZ3YzZ2psc0g4WG9zbWpOaTl2?=
 =?utf-8?B?S1R5Z3ZrVzUyOFB2Sk53c2gydWpPeER1aEduQm40YW1YczVsRXRwODlPekZQ?=
 =?utf-8?B?UllaVitUOE1PSW44QTJuekt5SFpRQVU4Tkt3MUFOeEI2bmR3dkxwSkJyYkh2?=
 =?utf-8?B?ZUk0OGhKZnlvYlNHVnUxNWxqakhqNGpmcTJNb3p3cnNBM2RFU1g1cmsrMS9m?=
 =?utf-8?B?WG5mWDNWdDZUcyt4d3JsbEpNSWVVeVE5SThuQ0pSdjdNSVBYazY3cm1qZXcw?=
 =?utf-8?B?ZHdWWUdtMnVSdnRIOFJwdEdLSUNtMmhSRGduUDZkWHFSdnhvV3pwNHdLdUN3?=
 =?utf-8?B?L0dMbFZCZ3owNE13MUZsMmhZYkVueEZEeDhGWGpTR1V6KytZZTBvOXhvYTJI?=
 =?utf-8?B?QXpTSnQyY243RVpBdWNVWnV2ay90a21ueTZGZzNuaHNJRUZONTRZVXBJR1hE?=
 =?utf-8?B?YzdBR0pEZ0N1bnUyWXk4VnhQS01iSittbTlsR2ZCUWl6L1JmWFVockZCVkhK?=
 =?utf-8?B?MzZGYVRRK1NQSy9VNWNWRVBpMUh1QnQ4YjdFUEY3SXhwZXlKaHhJSDlTMlhH?=
 =?utf-8?B?V05VbGNjaTBVMmtIQTJmUFZ3K2MyMUVOZk1oWXRPUXVHKzc4OEU2SWJ0Szk0?=
 =?utf-8?B?cFRlV0Z4bi9uOVdzcWNLaFJFL2k0elJmOFV4M2VHQ2tnWTJjS2NwTHN4ZHc0?=
 =?utf-8?B?amw1WFI3WU41R1NtRmpoUlAyN0NrM0hURE1rTTNvNDlKQjlMcUFzQU4rMlZp?=
 =?utf-8?B?TjVVR29BS2VGaXpiV01scjllaG1BOC93VUx2SDEzV3J2VExaaTlxQUlMVHlF?=
 =?utf-8?Q?0JLKSn+WqZMx/UBlZ3+5Q1YDV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b40b44-0930-451f-550a-08dc8621417d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 12:07:37.4795 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9J6j8LtdyopPffd59wB8MSfzLCyOAev9kWUqrNTdzjs7T2uiTiMSQrGvzUI8tcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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



On 6/5/24 12:02, Venkatesh Yadav Abbarapu wrote:
> Updating the usb5744 hub node as per the latest upstream DT binding
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> tree/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml?h=v6.8.8
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 48 ++++++++++++++++++++++++++
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 48 ++++++++++++++++++++++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 18 ++++++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 25 +++++++++++++-
>   4 files changed, 138 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index ce7c5eb6d34..18e9d308de3 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -105,11 +105,19 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <0>;
> +			hub_1: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		usbhub_i2c1: i2c@1 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <1>;
> +			hub_2: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		/* Bus 2/3 are not connected */
>   	};
> @@ -164,6 +172,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &usb1 { /* mio64 - mio75 */
> @@ -188,6 +216,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub1_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub1_3_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub1_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub1_2_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &gem0 { /* mdio mio50/51 */
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index 0a0cbd2b69a..5261e793c14 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -117,11 +117,19 @@
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <0>;
> +			hub_1: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		usbhub_i2c1: i2c@1 {
>   			#address-cells = <1>;
>   			#size-cells = <0>;
>   			reg = <1>;
> +			hub_2: usb-hub@2d {
> +				compatible = "microchip,usb5744";
> +				reg = <0x2d>;
> +			};
>   		};
>   		/* Bus 2/3 are not connected */
>   	};
> @@ -184,6 +192,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub_1>;
> +		reset-gpios = <&slg7xl45106 3 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &usb1 { /* mio64 - mio75 */
> @@ -209,6 +237,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub1_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub1_3_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub1_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub1_2_0>;
> +		i2c-bus = <&hub_2>;
> +		reset-gpios = <&slg7xl45106 4 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &gem0 { /* mdio mio50/51 */
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index 561b546e37f..0ef0357bd29 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -142,6 +142,24 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &sdhci1 { /* on CC with tuned parameters */
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index 64683e0ccbb..92d8851eb8a 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -92,7 +92,10 @@
>   		label = "ina260-u14";
>   		reg = <0x40>;
>   	};
> -	/* u43 - 0x2d - USB hub */
> +	hub: usb-hub@2d {
> +		compatible = "microchip,usb5744";
> +		reg = <0x2d>;
> +	};
>   	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
>   };
>   
> @@ -146,6 +149,26 @@
>   	dr_mode = "host";
>   	snps,usb3_lpm_capable;
>   	maximum-speed = "super-speed";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	/* 2.0 hub on port 1 */
> +	hub_2_0: hub@1 {
> +		compatible = "usb424,2744";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		i2c-bus = <&hub>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	/* 3.0 hub on port 2 */
> +	hub_3_0: hub@2 {
> +		compatible = "usb424,5744";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		i2c-bus = <&hub>;
> +		reset-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
> +	};
>   };
>   
>   &sdhci1 { /* on CC with tuned parameters */

There are other changes which needs to happen here. One is kd240 and second 
remove usb description from usb glue logic driver but let's wait for Marek to 
look at onboard-hub part. 6/7 and 7/7 should go through my tree anyway and they 
are here pretty much for description purpose.

Thanks,
Michal
