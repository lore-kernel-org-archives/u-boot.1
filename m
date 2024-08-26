Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF2BC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 09:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0627C8852A;
	Mon, 26 Aug 2024 11:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ixycV3/7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A0F0884DB; Mon, 26 Aug 2024 11:39:51 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68A8D8852A
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5jZPOm0n39e0UGUSA9eIJlNmpz+Vs1mQvKF+qgphnedgiAsD51WPv9qWXpNJbb8jftLET8fKDjXiPh5U49w/ff1zamntJwEkZcL8r1GvCV9hzQPsmp+YOkOx0y4e1MjpfqMg3LqLtyPUX2JxarafR6YkbZi84nqfULaYekWBNDOGt/+EWht+HRyEnbqlFwOcpmQaizdbEbiz8V9wDz2WBsehHoE25NDdq1JOzoEDMiq0B/YBT8haBPO64KrY6LYpZ16Cu3zsfRSAMeJ0sRiYl5yANVqko8hOkohi3CKdB4Ap3BKu7Hhiy81hy/KEwnqdYKbOSPNwqv9W5T4M0e/eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTlt0MWbSgWN0A4vGmJ5zTm/8PLqUtmynEl4RTKReys=;
 b=QCXunZgGXmBbygcX9mY5yTTDsTIAJDAbkdKQ/nApSDwE5zZz1uL6+q91+6wotzMxSIMX8hNQQQkHYUciQXT2dNopbIs/80G25K7z9s/o3/37vPCOYpfCIZNyc1ldzeelSTOfy9oj1WryGQyEEtSqxzTlxrl8cU68oN8nwLMrcINJLaU4fY7DNwHUWpELqHvBcZ3BGURKovuhJoisB2KAUiaGQHrsUz4jIcUf48H9h0SQ0HOnNcxaQaRDmf6cdBQPxf6ozrEbou6VofQh6Cc3oYqlPGNGDYQKxbSrrWbWrImSIKv1eODxskpqGJ/vTaYBrcUYSH9CRYGpWdaFJ1SMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTlt0MWbSgWN0A4vGmJ5zTm/8PLqUtmynEl4RTKReys=;
 b=ixycV3/7hsfBfAQgaCbaPP9GeYS9a2x5gUmC7lx6MkOHxW8eeQptKxjc6bJnJD4s5+/AmeAUcpiFgNjLVMMVClVS59q5bA5MXIP28TZs/zuhaWvFEDMcYpAH/XvRRJ+4Si/g2oKNnMnUuAmisDSCQKkCsrZ3EG0isKLPQe/s6dc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Mon, 26 Aug
 2024 09:39:46 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 09:39:46 +0000
Message-ID: <2227136e-e9ab-48a4-94ff-d489416035d3@amd.com>
Date: Mon, 26 Aug 2024 11:39:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] smbios: ignore the non-existence of platform
 sysinfo detect
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese <sr@denx.de>,
 Bin Meng <bmeng@tinylab.org>, Kever Yang <kever.yang@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-5-raymond.mao@linaro.org>
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
In-Reply-To: <20240816154658.1866186-5-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::37) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6e0d02-442d-443e-0634-08dcc5b30587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnFpTXZtUEJydlZiNEpsUTRnd0IzNHhCZUZKU0RrKzFSZTJKcTV3SXRELzBk?=
 =?utf-8?B?RnlGV2xuQ1d5ZHBEc2VHN0crU0VrK01vSGF1YmZidnluT2NVQS9YZGlGTXFW?=
 =?utf-8?B?NCtyWGM3Y0ZlT0g4TTY3dFIzOGljN1ZVWTNWcHp5eVRxcm0ydDQ5WG1kZXBx?=
 =?utf-8?B?ZEsxYnZxQVkwMXQvV0F2TTl2NlRZMlNVWHJkKzE4VzAyTE9WdjRvSStmYkR5?=
 =?utf-8?B?RWJoSjNpL0FNNHk0L1hJM2dKL1BORzloMXBDQWs3dUZwRTQxWUZPWWgrN3pj?=
 =?utf-8?B?M2RnTDUxMjdrWHZhdjIxMTNOMi95a3dPYWZKczJlcW5lUVFNdElyaDM4Vzdk?=
 =?utf-8?B?ajFKRDZLOTNsRi82Z0V1QmlESkRPd2dKa2l1MEE4ejIzM1VCdmRtNVo3eTdX?=
 =?utf-8?B?Z1ZXTHNiUWMwQy9YVFY2UGlCSE9WWHFLTVhYWisrRmI2N0E2UXhWWWRrRytx?=
 =?utf-8?B?Z1ZWQUxPbm5MdmM3ZmRJalJkT2JKYkFZa3NXZURXWHMyTEQybkU1TFFYZHl0?=
 =?utf-8?B?MXo0QkFncnN1R084VnZVaVRzTUJWaWZaNW9TdW9rMlVSYTNDNC96TmdIdUF0?=
 =?utf-8?B?MHBsOVI2Q1c0ZmFMdmxTWjVFaHA2Z2M3MGZMMDlXNzlaVFdTTEgzbUN0STlK?=
 =?utf-8?B?czhGL3dCU29nMUxkZS9paU0ybEpBSGlxbGJMUE9XWndTaDFobTJUNHdTNmlp?=
 =?utf-8?B?TXh6Rk5sR281aDduQ2E0Y1pQNW1kNkxPdFQxd1FTUjhPTzZxRkJHSCtOU3lm?=
 =?utf-8?B?WW9LelNKb01QOTUwNGFGL3lxa0Vhb1pEQkpMTm93c1RLbkdMSEpKR0VsMGRz?=
 =?utf-8?B?ZjBqa25CVkYwYXF6SlFBaWhaSTR0SFdKUUhrZ01vam1vdUs0MnF6QTdiWmRB?=
 =?utf-8?B?RC9PeVU1alFYVW5DSzN2WWFhT24zdzNIQmRpWDUvOFh4VUhLQktrSVdtZVhC?=
 =?utf-8?B?YUlNUkIxVDIyb28xR2o4YUxRZldGSHhhWlFCZUxmTGJBUGFaYzZHaUNtaVox?=
 =?utf-8?B?SXZJbGI3cVlhcW9WZGY1YWNnV1RJTmNxQkhSamNCS25KSmhRRkFXZjFNNUtv?=
 =?utf-8?B?VnFRaVB0T2pNdi9kSU1NUGJZd2JGOVg2RmtvMThVeXFBY0gwWFFsNyt6WWhw?=
 =?utf-8?B?TktLYjI2dGgyVUdHbGJuVXBqOWxTaFA2MTNuQW9ORFd2VzdqeGgzQVZIQ0VW?=
 =?utf-8?B?Qzl1UlJMQXVseE01Qk5FWGtob0lCRklXQng3VEYyUlJYQTZwWG5HMVlHK0lz?=
 =?utf-8?B?dkMvMzI3TWp4WGlJR2lEQjhiaTh0VTFTRmM5OE1HV0syTWhBa0s2TlVaR2RQ?=
 =?utf-8?B?dmMyUnpvbE9iME83bXlvaXZHSGJ2clpzR1lUNkx3YUdCSmt6ODNOMHJXdTRw?=
 =?utf-8?B?c0xVS2pST05HZ2poWkY0NzNDY3FXTm51UFh4dmNxL1FZQmc5MzVxN202SXdx?=
 =?utf-8?B?c0YrQXBZYlMvSUVHV1Z3ZlFCVHJMc0MvNWVqb3FjVEhDT3RzTUVNQkVoME9p?=
 =?utf-8?B?ak1XdmJGUGpWTk9Cb3I1VUo5b0sxNGVTaXNOZlBOWjMxU0d4S0ZXeElTcDBn?=
 =?utf-8?B?Y1AvRjhWOHVaSzFPZW9NZVJuYW02ZjZxVHJHZ0dXQ0JBWFdCUXA2U2J1U3Y3?=
 =?utf-8?B?czMraGxhb1VRam9RTmY1WElpcWJsSkVWUUFjektnTUZVOWNZbTBqa1owM3VL?=
 =?utf-8?B?RklPeE91aC9henl4Q2sxeThtRjZUTDdQTEdtbTZlMGpCT2lXWWtaZ3NWeEEz?=
 =?utf-8?B?eE1jVUNXM2M1YTNSbjhHSEllRmNiMmNwYWtYNG96N3lUbEI0S1c0RzlwZmhK?=
 =?utf-8?B?bFFNVTN5VDBCdFdLR0pLZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3pxSTFQVW5IR1V0bjRYM0xkTldNOEYvVzVnbW1WK2NIV0NnNU4zeHVmT1pP?=
 =?utf-8?B?azlLWTRkRklsQXJhR2grL1BMU3l3NmpiUUpPWlFsdFl5MTUvZ1NlR3Q3NTIx?=
 =?utf-8?B?T2J1RmkzMHk0ZXhkYTdCL3hzQ25Nb2pTeURZSnlnVVFkS1Q0bWxTaDZsbCtG?=
 =?utf-8?B?N3VuMXhFaEp4enZYbjRXUTgrSTZhcndwT2ExL2pKMC9qQ3NScDFlWURTVnNr?=
 =?utf-8?B?S3JSb3BnN0w2Z2xjMjM5U0tEakRha2JibWNPTk1XYVlCY1A0TFRXVFZjTXN1?=
 =?utf-8?B?MWhUdERNTnJWZis2UWVWSmQ1ZWpuUU9WSm84ZEVNM3E2SXZWQXJaZnVKb0p0?=
 =?utf-8?B?WG5rZkhqbXFwcmZSZlRyM2oyTnl3dnJYcGZ4Und3R3NjRDY1cW1XTHlua2gw?=
 =?utf-8?B?dlM4NWh6QW8zOHY3QnNBRDJCc2QyVUJteXVrcW9Lb3lSVk50ekVVNFRjNkxY?=
 =?utf-8?B?Sjl0M3I1dXN2Y3E3Rjk4eFQxLzE4L0lONDhibC81YWJIeklmNlBRb0UwSzd3?=
 =?utf-8?B?bDBaWFkraGg1QVMzN2dhSFVWNGh5U0gzbEowUk8zS0dmUk9HVUFZWitxZTk2?=
 =?utf-8?B?R28zdm5DZ3l1dDBKcDlSTWIwVENDWlJuYlhlWUNCUEFtajJBbThCa0x0TXFv?=
 =?utf-8?B?OFkxOUM5YWRmMkdGNk9OSmJKbXMxRVI4WG5GbHpwNjRLNy9EOG5aUmh0TVZ6?=
 =?utf-8?B?WXVTemtwenhMSXh5MWU5SnMwZlpVS1NpQnpXQWpmS2JwQy9LQVhxclI2L1ha?=
 =?utf-8?B?Uk5DVlpXSGFScFBoL0dQQ2pCN2tZcFRTMEJIRkxJN0RRMlF3NFFuRmNlTG84?=
 =?utf-8?B?OTNWUWp0RjM1Um5tS1pDRjVJR2JQZFpheU9FV3pEWkVKd3FHUmpwZDM0dlR6?=
 =?utf-8?B?TGw0NGtaQkFZcjZONWppSDNIdE1wSTkzbzUyWGFGUEpNR0NySVcxTzIyTTRy?=
 =?utf-8?B?WXlvMURIVlNIRDBQdmtFdStjYVMydGNrMVJrUnQ3K1JKQUJLN0tHVVYzQ2hI?=
 =?utf-8?B?M2hWMyszQmR1QW9qd2toOEp5ekhRTlBNMkNIQVR1TVIvOUd3V0lDSmJQeFRC?=
 =?utf-8?B?TjVSb2tmMXUwUHNBQWQ5eFRDaER3ZlpaamRPMlZRemM2d1lib3NOZVphWEo4?=
 =?utf-8?B?eGxmUHIyMFB5dmowdkxCSnhwditwWGpiOEVQenpmOTZuSVFsNlhnS0prRldQ?=
 =?utf-8?B?T2ZHd0dBV2pFLzhrTGRzMHViWUM3VmZyeGh1bEZ2eG1iVG4yOVNxdi9Gb0Vy?=
 =?utf-8?B?TFJlUmkvbzVLSlFZRldRbzdmdC9OSDRia2pTdUwzMklBZ0h2dFVnSnNpNEtH?=
 =?utf-8?B?NU1zeWN1WnBNNXl3cE1KSU5MaGhnR0RzZ1lDekhKQU5VYVNvclB5bWw4S3Bs?=
 =?utf-8?B?S1RMNlRKeHIyNzV2WkJReFVXSlN2L0NOYnltUDFnRTZuWTU1dEZCcks4QlYz?=
 =?utf-8?B?S1dYak0xcTRRYWNBYm5OU2owZ2llZEtmK2JYcUkwU3p3U1VSQkhKNzZrc2xK?=
 =?utf-8?B?QkRKd3NhRHBQZVA2bGhvS1NpeGwzUEd4SS9wY2N4aHpDTWI1emFpamV2bnVT?=
 =?utf-8?B?bkRKSmE5VFBqNHg5amMrR0RIWUQyd2VmZWQ5dm1vWmI4OHJBQW1rYTBYSGRu?=
 =?utf-8?B?OXZYa0EvajRnNTl3ajFHYlpIeXdyaTA0Mkt4Z0hRMWFyU1JreU0zandaZmRp?=
 =?utf-8?B?YkpCYzlPSDFyb00wYmpDSGRmZ3BMY1FsbTR0RjcxN1U4ZSs2T3UzSkgzNkp5?=
 =?utf-8?B?OThXQXJ1NWRNQ2ovWFA2ckRiT3BsQTZXM09KM1VQVjBoRjBMT0lDQ0ZQQXVv?=
 =?utf-8?B?ai92TVo0Ry9WSW1HZ1RldFg1bjZFV2ZrV1lzbll6bGFIYkFtem4yd0pELzBO?=
 =?utf-8?B?RjBuNWJOeUt1amFhTDNKWEo3RWRwSlFoYWord0hYSE1ldXRsa01CNUM0b3ph?=
 =?utf-8?B?MGRNbU5SdEJCZ21UdzRubm5DNnpsUk9XY0FNeCtneEFWWmhlQno3NUVJeVhp?=
 =?utf-8?B?cVlzdXhyMU9XYndCczhWaE12cVBxQUNkWXJkb3IzSUltTnE3Mk1CZTN2cXhI?=
 =?utf-8?B?Tmp2SEpBYWhBc2JNbHV5elRlWGxidmZWdllCc0QvYXh4aTQ3ZHN5Mk5kU3pS?=
 =?utf-8?Q?Pp97G20lYn/NWgKWzHNaqQk9T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6e0d02-442d-443e-0634-08dcc5b30587
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 09:39:46.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXAz5fLOxdzdJesv7lIZKYumsZg7GdU/2wveuW5rzcb3QpCEtZthbUtqryya0PLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
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



On 8/16/24 17:46, Raymond Mao wrote:
> During writing SMBIOS table, implementation of sysinfo detect
> function for a specific platform is not mandatory.
> Thus we should not return an error when platform sysinfo
> detect function does not exist.

first of all you should avoid we and use imperative mood.

Second what you are writing here is not matching what your change does.

Simon did a patch not to make it mandatory.

M

> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   lib/smbios.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 8e481365165..2f1759d419e 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -825,10 +825,9 @@ ulong write_smbios_table(ulong addr)
>   	if (CONFIG_IS_ENABLED(SYSINFO)) {
>   		uclass_first_device(UCLASS_SYSINFO, &ctx.dev);
>   		if (ctx.dev) {
> -			int ret;
> +			int ret = sysinfo_detect(ctx.dev);
>   
>   			parent_node = dev_read_subnode(ctx.dev, "smbios");
> -			ret = sysinfo_detect(ctx.dev);
>   
>   			/*
>   			 * ignore the error since many boards don't implement
