Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB491C021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 09:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A46E801CF;
	Wed, 26 Feb 2025 10:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZpqJ8Msp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D054C80F12; Wed, 26 Feb 2025 10:54:14 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F408004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 10:54:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzCgsrEbPH0aHEa9eCGKE7fK3hwjlbUVulFw2FAaQIq0n6HbotndviI7tz78DQHidMdbohpW7BXEYF30gFAGw5YyM8/pmiUlpAtVWPYFc4N5O/doS3NhX9xaqLNFdInbPTr+ezikonNmg3FnB6/oKDJtcxRJ1sghnxbGd74KGzAfDuG6zYlCl4m56jjOLu+W8YcFBskMK804i8v7/25M308tynJ5h30dUmE6Adc3NfSSJHFcGYnUN5CMGUWvW3qj/ujAO55pqEDXBOl8FySHFngmeuKQzXl15abDjfhVA7x5ZzIvLLSkg3nQBsSlg9EsJKLJNuXxOK242ZNzxJyKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8+yK/e5XlH8nQLKgqRMm8oQKVI8rrOazrNMT4QE7DM=;
 b=SUvTTazPNPprkap6YR3XphSs4QgbqvV/HpmZVmEpFBGUsG56BMEiyT5im/pmq7ukMp26QvpeguyBcH7/UhHuknj+lrcFpSO0bFeFAUn2mezxPZMXoKV9OjZ6xJeiBsvV+sb7MKgOAXDXnAtYi0qaJiqb+r7ccstsxmIraYQSx3R3LrrCD7fvWa/TW/RXYLIoqh7mX5zp2Ga59sqbr+MdFzTfL0Fy6jyCLQ54A481LRQYG3lX0mJaJOUMIoO9PkaOnDu/qEID2aHMDJUV877BIlItGy54LAm3rjsxyXl40IaRH4bAPF/b+owjixIF+R4XU9sDLEzMHFxQ6e67LoqD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8+yK/e5XlH8nQLKgqRMm8oQKVI8rrOazrNMT4QE7DM=;
 b=ZpqJ8Msp6CyBqZPQYrnyesBpaLbRlzNCQFJ8RgTWQBXv8mW1fDvlKDNDL/d3U/hh/Qr+6iZBAV7PTGTlWMyWxmsx1yht3kcYZlAWaOxLR6yuB+Kobn+hOby/VT4aXPUg4s5L9NoY9mT3s/ic/vddPQKsPtNf6+ZrMIOhXM/8xKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 09:54:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:54:10 +0000
Message-ID: <a247ea02-6518-4d26-acf4-5581e50a6d73@amd.com>
Date: Wed, 26 Feb 2025 10:54:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] versal2: Fix .*get_bootmode function name
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <bd8cb2f9783bda47663927f78bf0bf908393334b.1739882445.git.michal.simek@amd.com>
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
In-Reply-To: <bd8cb2f9783bda47663927f78bf0bf908393334b.1739882445.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c212a15-c77e-4e65-b746-08dd564b8476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmZFRGFuMUhuSERXcFVBTEpUQmFvS2xKNnQwOEdyQWZ3cXVKVVV3QjJBQkly?=
 =?utf-8?B?elVWTWZIb2d6VHQyRHVkZmhZZFMxdmsrK21CS2s3cnRvNkJuTjQ2MTc0NXVB?=
 =?utf-8?B?T2FYMGtBODdNcTVKWUswUktwR2dVazZncURDemw3YUFmZUxZcUNEMVN0VmVs?=
 =?utf-8?B?Ly91M3dJbGs3STVtNC84RzNMVXFnak9aUjdtLzh5V0U4M3JpSDd0THNvT2pF?=
 =?utf-8?B?Z2lFbEFURTNHeUlma2thTGNzSnVqVGMwYXpBNnNKSS9jV3Y3MnRudFlIZjkr?=
 =?utf-8?B?dk1qSE1vOE9TODZpaHNkZURnOFVQSzJxajBpZHo0NlEyT1A4cXRTKzQwTDQ0?=
 =?utf-8?B?RFVQTE9qVStibmVFY2dHeW00TWVEaitIaGFTajNMSWNtV0RUM2h3ZFhScEZ4?=
 =?utf-8?B?eGNMekxyT0U5cEtkV0JhWEhlZlhVcWJzWk96ampyR1pUdVVBenFuM1FOdmJZ?=
 =?utf-8?B?alJ2YlpSUkpPVjZlNzQzVFE4YjFNUkpubzE3V3pwZDZuZGhTYjg1NW1Wajlw?=
 =?utf-8?B?Znk0bi8vaHZXTEtEQ29JWWZPMnc4MjFobDlQKzNnaDFqa2dzbmRtcDI1U0Rk?=
 =?utf-8?B?c055K1p2RkRoLzFyZEFYU2RNTDNmbWtKekNXMmd2NUhqemV5cldPMExrMnNx?=
 =?utf-8?B?d3Nqc05aVjJpY3lpQ2ZTQWpyS2Y3QjdNek43YlBacGYvY2t0NVpGTHlNbnla?=
 =?utf-8?B?VUh2TnZnVGZOYzErb2VZRmlOaDZsTmp4clNjRzV1aVQ3M1hjUkoxSEFHR1Ez?=
 =?utf-8?B?UmRyVnU2N2gya3VDU2c1TjF1RzA3R042WjkwcGkvSVlGNmEwVmF2RnlDbmJh?=
 =?utf-8?B?eHJpOEMyalM1Wm1BQUpJZ09zK3MzUkJ3TGdRQzlmY0x0RnVLbVlRZW1FTy9B?=
 =?utf-8?B?RTVnNlJrTkdqNzArZS9sVnRKRHpsZG9OQW9kRUxBdU5WZ1hjbFBGb20yY3Vz?=
 =?utf-8?B?UXNlcVBpeFp6Z1dzUzMveEhnOE0xdEdadm5EaHRwcTNHV3JsRnVGNG1tRE9w?=
 =?utf-8?B?blFnMDhDWDVtVTJxalRqRG1TL3lIZ0JVMDVzdlFZUjg1dWE1dzZJOTkrSTIx?=
 =?utf-8?B?VTVHMzEwQ0wvSUg5ak5IcWM1dXRzWC9lcmVHVGlYMU1aS05KdERldm5TMVcy?=
 =?utf-8?B?dFdYckxEeXB6RG9pNGZiS0pBODhnbG8zUlRhamwwaDJuTmJTUEtYYjl6M0wz?=
 =?utf-8?B?aXNnVGhQR1VTa0JoMU03TmNUbGtxMjJ1Yzc3RXU0ZVBRcitnakc0ekNQS0M0?=
 =?utf-8?B?K3NEZkRneDlONWt2YzZsbEo3QXNRS0NGM1FzRmhqUHBhZmdRRTBqdEdqdFl3?=
 =?utf-8?B?UFhCSnJBNlkzWXlPaWhoS1pwR2JFSnJWdUNVQVlzZWs1b1N4TE95MnZ1cGt5?=
 =?utf-8?B?ZGtoM1lacWppRGtPV0pab1F4K09HWndkQVRFVi9HRDZQbFVlQjAwaC9IcUN2?=
 =?utf-8?B?WUxRNnEwUVVFOExES0ZhOHRHcWtVSyt6dkdBd0h3U1dHd2NxbStYdkVGbjZQ?=
 =?utf-8?B?c1JueFhnK1o1WWkrYVpENkdmaE1TNGFaMFBmRzdkWjA0SzZuazNrelFncjJv?=
 =?utf-8?B?Mjllc3JZNzRiZUJuS2ZBbDVqZGZWdGdjQ3dhcGRsQ21ReCsyWTE0Rmw3WjF4?=
 =?utf-8?B?VDE5Vm9TM3ZHWTAzUmU3R0g4bDVVUXNnZktLRGh4ZDBmb25vbzRYU0hTY2Qx?=
 =?utf-8?B?TVZnSFZlUEJyVnNOODdGM1FnbThPNFhXclRFM0Y2WU4vZXh5ZDZwOTAzNWJn?=
 =?utf-8?B?NEg3L1FyYVlPRy9Tc3kxeVRxcWZIWTRLbFl0K2w1N0dNcHBKSVhYSDZxZkp3?=
 =?utf-8?B?dHJZSjVrblJySlIyT0s0alJzQmxMK0pBcE1nL0FJTFNvRVp5K2xKZy95Wjkr?=
 =?utf-8?Q?80K2Vn9tSxf32?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZndsSkh0UTlLdVhzUmtWbWF5cGFtM0g0MmpBNExQcGR4T0QvMzh0RWpROFZ5?=
 =?utf-8?B?Q1JJV0ZYQjFMOUxjdjB4cmdvY2M3Sk9XeXcwanVjUWk2cmwvWXFYd0tLQngv?=
 =?utf-8?B?NnZhT3VHaC82VmhGcFNxbWZ0YmZkcVNtcTBFSjVrNlI2cU5kVUt0R3pMczRx?=
 =?utf-8?B?bGJucVRucUxlYmhBRnpmZUpmdDArUHNOeCtoUTJjWnVJTyt0Rk5NLy9vc0Zk?=
 =?utf-8?B?QWthRzRxWlpaT0JyRHk5MDJPS1dCcVlENFJydmZDNFNpMkdrQURRRHVwODZx?=
 =?utf-8?B?WDVqV2pGejhIK2RhWGc1cHRDaWtsQXVhNGpDYWF6czRWOThBM2VkZWtpVU9z?=
 =?utf-8?B?blZ5K2lyQVROVnNaNkRHVWgyaGNxTGluYnJHdkp4SW1vQXg3Mzk2YlA2MGJE?=
 =?utf-8?B?NHgxSmxwWFppdm4ybVRySmg3VGIvZlJFcGdjeFMyVGQvRi92dGlLZ0k0Y3VH?=
 =?utf-8?B?a0tqbjdUMTRPK0dzTUdEc3lvcmw3OER5b28wUTJ0QzB0YS91N3M2eUpFUUpj?=
 =?utf-8?B?VWdSQzJaSHBLTmJ0R1AxOE1DeDhCajUwRi9RVDFTcUt2YThQYTJmaVkwZFRq?=
 =?utf-8?B?QkFQV2Rwd0s3aG4wTmVIL0RRdm1keUgvamdPbms4WS9kUDNXWGlEenlwb1pk?=
 =?utf-8?B?RHdKT2lMdGhMOGxhWXVnY01xc1BqV3hmM3BmWXl2WjFYSVNJaVlPbzZDWmt2?=
 =?utf-8?B?SzN0ak8zM0x3VS9McUZDZXcwcVBQR3JQa2s3alZvNDZSQ28yYzN5U0dObjdm?=
 =?utf-8?B?VGZvNTlpQTFXYzA0cElUSE02MzdEVDM0MmZZSExxMDEzc2ZjT2JZOTRVUmZM?=
 =?utf-8?B?U0hMQUp0Vlpta0g2T094YVdsc2thdG1ZcDk1VTF3dkFJcnVOZkUwdGQ1d1Nq?=
 =?utf-8?B?aWFvSFp0M2UxT2NGMCtCQzNYTDhoMlQ3aXFzLzdwclRXL0FqZ0dOM2V3MU44?=
 =?utf-8?B?Q1lnTEo3dGw4aWUwOUxPVGRkWHRMM3E4eWpBQlVYSGdISlBDQUpxcEVCOGor?=
 =?utf-8?B?QjBCQTdMM1hkRWp3MmVFdkZZWXZIcjREc1d6d0FWWW5CSTRkdVFRa1pzQlF5?=
 =?utf-8?B?VVIwNGo0RXdiRFhrNTJrZ1JZNGpmWkxia01GaTVZMFpXKzBLVWo5THhscnNJ?=
 =?utf-8?B?ZDdQUGI4Q0c3d1pnbHJmNlI5Mmg5K2hicE5jMkpyV0ZDTWJmMlNCVm5oUjAy?=
 =?utf-8?B?d29FY0dmcTBSY0src0llSitFaVp1ZlJJUzJka1pSOXJEZkY2LytUaTh6TlZO?=
 =?utf-8?B?a1c1NWZBVFhoKy96akhFYTdHNDdyU2gxbkVGN20wdnBLZGhUTGlrem43U3ov?=
 =?utf-8?B?MHVVRWtCRVV3Q3FUamtjbGFaME93bFUvL3FNTXRZMTlKTFBZZzJ1cnpOQVRM?=
 =?utf-8?B?dy95S3N4eVF1SWxXMkMwV1M2cUY1b1NaNnBqeXMzODV2Zm9QWW51d1hvaUdJ?=
 =?utf-8?B?L0x1cUphc0ZUR2FtcHlUcWN0YUFRbXNEVnNqZXVGWFJQdGMyMVk0cmdwZGFq?=
 =?utf-8?B?c1p3c1huSDlmL1ZrNmQwVWpjUlFodDhmaGlzMTRWS09qd2I2VXBvekppSkVy?=
 =?utf-8?B?eDZoSk1SNW1FUkd4aUN4YXVhSmRqbjRvMVJNRG9wdVVRTkhsN0FsK09INXU1?=
 =?utf-8?B?S0Y2SE1haVEwRWNxWi93ZHV1ZXppWWVGU2NlaG1sdFBGbDNJVDRteVZsa0N2?=
 =?utf-8?B?QVAvYVNNMW8yZW9kTXhTWUF1dEk1aE9XNTNlL043bmNrL1dPaktrWE9Mem5Z?=
 =?utf-8?B?eEIwQW03aS9qeHZQaHYxcFZHVDd2TUJTZmpwaDljRFA3RlVKM3FJWi8yQjQv?=
 =?utf-8?B?QzF5ajZpQWkxanJIcFBvTXcrdW13V2lheXp5a3RodnJ0UWRhcSszcnpuMGFm?=
 =?utf-8?B?aEM4VEMydUM4UjdjcjE4cEdLMk55MVZqT3lsdnZLYmxqTUZtTytPNytoT2ZL?=
 =?utf-8?B?WXE4MTBmRWVNbFBNZ0JuSDk1TnFSeTZrT05adktFUDVRYzhHNlJjOGgvTVRR?=
 =?utf-8?B?ZlQ2N0wyWTNWaGFhMldwRkFodzJHTytxTGJFWFovRGZNSTZOTEN5NndhU2Ru?=
 =?utf-8?B?N3g5WnpkcnBSYUd0eWtkNUVJZmhjVkJTejZsQTByVzdJaVcxMUlBN01ERE1B?=
 =?utf-8?Q?4uB3O0oEh25YntA7r3lx4Dyur?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c212a15-c77e-4e65-b746-08dd564b8476
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:54:10.3713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDbS1RdZLt6J8Ld4bpgY2rZ0bgy0DZPKLR8LxGsH5zYZ9niCXffCFK1waMRm2HxF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
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



On 2/18/25 13:40, Michal Simek wrote:
> Function was c&p from Versal NET and should use soc specific name instead.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/amd/versal2/board.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 5651d516a9e3..d3e6547eada9 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -149,7 +149,7 @@ int board_early_init_r(void)
>   	return 0;
>   }
>   
> -static u8 versal_net_get_bootmode(void)
> +static u8 versal2_get_bootmode(void)
>   {
>   	u8 bootmode;
>   	u32 reg = 0;
> @@ -175,7 +175,7 @@ static int boot_targets_setup(void)
>   	char *new_targets;
>   	char *env_targets;
>   
> -	bootmode = versal_net_get_bootmode();
> +	bootmode = versal2_get_bootmode();
>   
>   	puts("Bootmode: ");
>   	switch (bootmode) {

Applied.

M
