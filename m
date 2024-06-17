Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5772C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B206882E2;
	Mon, 17 Jun 2024 15:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tJYALQ5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E116882E5; Mon, 17 Jun 2024 15:30:52 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1211A88271
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbbjfC+k+mLtoUqyNb3N7jnJ79lMGKZCv7CTajpPu1kYUTveQCsYUw03ppr4/AaozKCn9GkQIIkJQbPV6kjdnS31j5zeOjuwMMlJ+7xRJWkxWWYuuTzdW42SpLCEc7T+fc4tS96FlgFxMI+sqwXgS7ENPnqItUJY55CdWasi15KjJKFJNIP9Bz9KNCLJu92CcnRBWKJjm4vibS6HdSoh6jxK2KQwjzrcJWugPlFtHYMdBYHf/SU7yIvsd51BTXe1qpskbV4K3tmY8qHQ0VRa0MJQJSgqX9wSXrRFGGePg8aR7YX//gbYpQdy/95kEjBmya7DLsgfcam5CGLhhqptsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFANDMsQKVjZM3z7Nkr0yzXGYxNeUep2jSXEtkLdj+o=;
 b=DJkOhonGCsajRkIz3fB6t8G5TceqA69jVIyzVxyyF8FBnUVvAf3gv4PahkSWtfSs8AUjwzZIkKXvpPEjjSd4k6lmf2oswXLrrGT90voYe0Ox4hjLb/7cvu2gdUi8Nz0fL7qcaHx45aWSkoMkqKMuQNb67mrJZz7SvrXC6Ig+spD7jnYUQHxwsX67bScB227spdKDfzSzoXijAzDZt7mdL9U3W8g//JD45MJ4Y68trGN/kxDW6neGSvB4DLx5HBk6zRMsJC/Sl+z1dl+XnCixkyTSC4CTC60EP8sxNVdPrIQX7L2d9+a8+t7lhPEsQTfXm2ORYsFpSA1X86jDm0AK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFANDMsQKVjZM3z7Nkr0yzXGYxNeUep2jSXEtkLdj+o=;
 b=tJYALQ5JYSeOj3Z9+RWcvtnkcMdvuXcrfwElPF2B3UO11VFjZUnIchZFONBZGsc068pFbUmt9Ts9TavkSMkiCD71QWXb0ie+tWA1/itMugUnrKBC6OEkdOvZbJ2W/R/qTScJkO294QVR0tSewtqHcnx0CfsBoaiPWUsV3nHTVjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8753.namprd12.prod.outlook.com (2603:10b6:610:178::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 13:30:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:30:41 +0000
Message-ID: <0a8d9727-708b-4999-a70b-42ed0be2eb43@amd.com>
Date: Mon, 17 Jun 2024 15:30:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: Add proper dependency on ZYNQMP_FIRMWARE
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Andre Przywara <andre.przywara@arm.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
References: <c3ca38fbb2f4e6948a5ef95b369015de96259709.1717685091.git.michal.simek@amd.com>
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
In-Reply-To: <c3ca38fbb2f4e6948a5ef95b369015de96259709.1717685091.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e32289-8404-43bb-6f2e-08dc8ed1af13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlpwbXppMW95TGdRY0dXZWxlcU1VOXY1WjdRcUtQT1FtdDJMU0RISVBPZXVV?=
 =?utf-8?B?TjIreEx6RWFaaVhDZWJSSytXZE9Fb3NyL2xCQjVyenVFT0lVQ3BQdWFxQU1N?=
 =?utf-8?B?NHg0MElMTWZXb05rM3JFQ0M1eDMwdGRlUlppKzIwdzJnWjJ2VzAwTjFORE1o?=
 =?utf-8?B?ZTBJalBneGViWXU1Umd2N1Z6NE9sSG83aVMzVk9JREJRQzBzSW5sOG8zTHp3?=
 =?utf-8?B?SG40amQ5c1VQS2hMb3ZVMzlGWEk0ZDdrUjFzQ1ZmR1dXZW16S1dVaENtZE9i?=
 =?utf-8?B?ZEVaWXZjRHdzcTEwK2F0anB4Y0dJS1orLzRjdHgyVkFCeUZDRlJmR0FycTdK?=
 =?utf-8?B?czJJMEhxKzNQUVFiWUxteUpxVyt5V0VYbnFFOVA0VkhsNUdneVJlVGNSSTJp?=
 =?utf-8?B?Z1lLWnl3d0J6M3hRYUwza2Nxc1ZhSzRXTVRTdUFZdmU5enBndmd5QVI3SGta?=
 =?utf-8?B?b1Yzai9QR2FwRTFQZHdWUG9DYkQ3QWxuaFdlckNyZG9uYnl5VjlZS0R0M1Ry?=
 =?utf-8?B?UVc5Rk53MTEydFV0aVVZYnUwWWZWd1dtd3JXclI5RmpSV1lnMThCbTFPMDAz?=
 =?utf-8?B?THY2dHZnRWpadDFVNG9wUTdPWnBVMkhISGk4UTFpR1hlUkd6VEZlUUdpOHRT?=
 =?utf-8?B?YTcrRzErd0YrcnJiWS9Bb3hVb25jNDkzdU9pcmdwa1hCZkl6RWlkOUM5N1RS?=
 =?utf-8?B?M0ROZGdlUEtZcEkzSlpVdWxub3c1RHhjZGhRRUkvVk85OGFpOHhYNWpxZ2VB?=
 =?utf-8?B?VndPVk11d0c2ZDQ3QUsvRU1oNDdiMTlYdC82NEdHaXJhMVlya2g5NlFsK09M?=
 =?utf-8?B?WHo5UkFrOWVXdHEzV1NOTW1najhkblZTSDFYTmZCUGJZbnpFNVVWMEt2eHdQ?=
 =?utf-8?B?YjZwcktGRTFVRHNKMGY5N2IvNzY5bmJMQkhiVUxsZlU4ajRPazAzaG13TTh1?=
 =?utf-8?B?NzVyc01La0dhLzhyS3hZY29peWdjT3k3c2ZKVng4MldCMkRjdmUvUktXUmla?=
 =?utf-8?B?VHpyWkFLU01yZmg5N1M0ZStBaVMya3F4eWdEVEtlSjl0MDlmTTNLNlBRQ1ZC?=
 =?utf-8?B?andzbkRkOWVYdDFKYW5tZGZWTVNuVUhBVE5oMWZEQVNaM0FWTCs2eXBteXZ4?=
 =?utf-8?B?eTZmRGFCeit1THRsQjA0ZWY5dUxsWFUrSXJ6QnJVT3pSalRZWlVjNVUycVhK?=
 =?utf-8?B?ek5vN0FpTHE4VndVYWEzZlZJc0U0VzBxOERpVnRJMml1MDZoZmpJWWppRXdo?=
 =?utf-8?B?ZFhZenhDRDBlWXVPQS9sd2I0MWhTOXRyMkZ5K0lSOWlnQWd6bi94YUVRNTU2?=
 =?utf-8?B?dS9BNWV2SU5DR2VTRGRxZUZCSnJnZ1AyY3FDcnJtVHp0VXFHc05iQThaZkZq?=
 =?utf-8?B?U3FqNVduNFBidDBsREFJMFVjZXBIU0NOMUVEUHlJZEVvV3hZWFgvT3NXN3RU?=
 =?utf-8?B?cWxiR2Z3Mm5wN255V1djZ1ZiU05nenhiS3VCNEF6SWhsamF1Z1I3V0c2bDhj?=
 =?utf-8?B?K1V0eTFMNW8xYmVxVk5odm1jb2tDSmxDdEhlYmFJeFdTK2Ywb3lCak5hdjZE?=
 =?utf-8?B?TnBaQ3ZJSUIxa0dnN0ViUytBcnljWm5HTmY1SVB0V2dMVU5jK1ZGL0lmK1M5?=
 =?utf-8?B?V2N0Q2krbzF0YTFZc1lRLzRoQUt3MEZvYmQwZ1UyaE9aM3NHV05XUG1Jcml3?=
 =?utf-8?B?NWQyL3psY2VsVjRMVzJkcmlidVlBbVl3dUFTRHk4TjdjbXVPc1hyS1NkNXNZ?=
 =?utf-8?Q?JxdaSZNYXyMFPUbiVlykuEi96vBBLDK699QE8pX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(7416011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU5HeTBjZDRrUmk3M3hLUERxR05OS0dZT1p2OFM3MUtyblNlZktOUzdXb2xv?=
 =?utf-8?B?alMwd3FtM2JVcUpyOHVCdEZjZGR5dTlLdUJwQXV5YUo0U3Z2aXhoL3JLUXNC?=
 =?utf-8?B?WU1MazFHRThFcUl3d3RzeVRNYTFtVlZBK3Nvak43NE9VNDNqc0NPSWRBTnZk?=
 =?utf-8?B?MTR5TjhRZGYxdWdrZnE3dnVjQ2NtNlMyck9Oa2dQTHAzcXpBWGx1TVo5bTRv?=
 =?utf-8?B?ZnBtNG8rMzRCS3hwRi9TbUFCbHlBMDV1QXg1MDFCanlmWURzZDJRWDNSTHRX?=
 =?utf-8?B?em01SS9DQlRZOHFmTXBYeUpMTFg1VkJtQU1vTkVURnR1WFdacmRIc2N4dGxF?=
 =?utf-8?B?a1JMZmt3THozd21nbytpMjQrVU1iTGZwTzJCVmx4eWNtR3hCMng2R2dUdmhD?=
 =?utf-8?B?bnh0NSt5VHU5U1grRkQ4YVpzZU0vVnRYcVdnd0tLaGpoR0owODFoNWJJNkx2?=
 =?utf-8?B?MnVzT2JjbE1DS1A4eVg0dVkvbEJLb1lzSVJlRXRYQ0FaUkcxakhKd05JM1Jq?=
 =?utf-8?B?bVU0UUhWeEpUUldTMWVQUXJ3aVp4V240R0VzbTViSzg4VFIrL1Z6V0I2eWpF?=
 =?utf-8?B?Z29CaU1RMHA1K01wZ2hhS2ZtQUUwTzRCOXRhOHZ0SUhvMkN6b0VQM0Z2b3VU?=
 =?utf-8?B?WGF1NDNYV2RCMVVyajZJNXlUMmsxRVFzYy9LK0t2dmRGSkJxdklSUUx3Tk42?=
 =?utf-8?B?dTVBc3haNGJUME1xRkJIblVNVzFiamdWd3Exc2U2YUhlN0F2ZnE1VXBPcTND?=
 =?utf-8?B?ZStka0hRaEFMNzRsaVhsZjdaWGNaWVZ5Z3FJa0ttQkdLZ0NhYURlZndNcTJN?=
 =?utf-8?B?SjNDdFJiS1BYVklXdzZYdkE3UlY1Vjk3NmF1cGFjb0s1NDNhRUxockU1SXM3?=
 =?utf-8?B?U3luYW9WeEhNUDBMZkVoYmFzcVZ3c3hJbFFQbjhhNDEyS1VNWEo0c1RJZjU1?=
 =?utf-8?B?ZlV1dHZmZXQwaEhKcENCNmRqS1lmZHVUSEVEMUluZXBEak5pSVhmMTNTRTVj?=
 =?utf-8?B?OUkrTFV3dXBIZDQwNzA3T1IzcTQwZVQ2Wks1U1JWQ3JZNFJvWm5tTjRFQkx6?=
 =?utf-8?B?TWdCMGNDcnZxYjdFZDlRNzRSR1hBcFRxSkFDWFkra2pidWZxdEtOU2hSSG9E?=
 =?utf-8?B?M05iNFJUbG1sOWZQV2xXSThiWEZ2V2NXNmwycVF4ZVQ3cERsYmdSMzk3OUVx?=
 =?utf-8?B?cGVlZ01zMDlFaXNSY2N0VzFBWklIU0N0TWhyZUtzU3RhQzd4b1NRczIwSFdo?=
 =?utf-8?B?YUpjTTFXOEpqWWIxRERncFRWTW9Mcm4rcjlTc21qTXp3cys2QzBabmUycmxs?=
 =?utf-8?B?bFQxQVd1QjIrYVNXOU5raVViekQ5SGJrNnNhK0pId250Q05NbEFLSG0yN0tq?=
 =?utf-8?B?cDVXUkFtT1FkTmlKZFVrUEYxZ3YzeGdodXlXYnlrL0xiVGQ5WjdoWlVRdmh1?=
 =?utf-8?B?T25OOGRXQjB1eHlXTXFzTEQzTm52dndnYzBBY28vcHNSK2s3Y21SeklpRGs5?=
 =?utf-8?B?YUtTSGVQVndyTHg3a2xBaWp0ZldRd2dYRk92eEN3dHdRbEw4akZJOUlxSll0?=
 =?utf-8?B?OGRaT0lJM05sQ243K0VDQlkvUzRCSHZGcWVQMy96VWJaTjJpZkd5MUcrK1lI?=
 =?utf-8?B?T2h6ZzU4RUdmbUtDSEpRNGo3Y29NTkd6aWJlWldZanY0VE81SEFNZUgwSGVo?=
 =?utf-8?B?Wnh0eFVWcDhtb3ZIT0hMcWN1RVhoaVZIcDgreEhndFlDMG1rSmtYTU5YblZ1?=
 =?utf-8?B?Vzl3L2UzWlZsN2ZldktWdndOSVJ6MGpHMFB2STJ1TUo4eklSbnlxVXMrS2Mx?=
 =?utf-8?B?RFJSWHJSZDRxdXllYmpDN0FmUmY4ZHE1RUs3WUluWlV0dlFJOXBTTEdrTGxo?=
 =?utf-8?B?SDJkTXVlVXM3Vmo4RE8xUU9TdTlQbGVNSmhJLzJKTU9zQVZIREx6Ylk0aTlu?=
 =?utf-8?B?T3liblhLaVVFMjJoOFAwRkNsSmtuMzU2QUhFYk93TGprbzh5OUx1T25EN3l2?=
 =?utf-8?B?ZWpxWHJZRkxIdnhXZk1DWXlRSENhZGwzK1dBbFRyUlBJKzRuSm1ZVUE3dmJL?=
 =?utf-8?B?NDFwUUdnZzJ2WGpLUVdhZDkzVjRBRWk2ZHE2Vy84Nk9UamduN01oZGl0ZHRQ?=
 =?utf-8?Q?vWabl+L2+/Pb9FcPxKcp9S32f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e32289-8404-43bb-6f2e-08dc8ed1af13
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:30:41.8744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNxPPhmIukd0A6BJLS106wFntSthD1LSc+VNfub2tE2mx4kFy7ONpGlPHwtZoUg6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8753
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



On 6/6/24 16:44, Michal Simek wrote:
> ZYNQMP_FIRMWARE can be disabled and driver depends on it that's why record
> this dependency via Kconfig.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/gpio/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b050585389bb..93c5125fed9b 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -639,7 +639,7 @@ config NOMADIK_GPIO
>   
>   config ZYNQMP_GPIO_MODEPIN
>   	bool "ZynqMP gpio modepin"
> -	depends on DM_GPIO
> +	depends on DM_GPIO && ZYNQMP_FIRMWARE
>   	help
>   	  This config enables the ZynqMP gpio modepin driver. ZynqMP modepin
>   	  driver will set and get the status of PS_MODE pins. These modepins

applied.
M
