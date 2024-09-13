Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30542EEE26C
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 13:02:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F798885D;
	Fri, 13 Sep 2024 15:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H1g8TO/K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F33788D59; Fri, 13 Sep 2024 15:02:24 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F31C8870D
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 15:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXDyvxGlj6OqdFTLkG4MkKDCHEbuNgRrXzZMLuSaqYM4/0//NBBweAxaOJ1y+h549iYLwl70NN3QJwZACTcuXYF5mH8OpyxcJMwk8thARqNDc5VE8v6ms16bnaB09ZQ99kGRmMWRGhEYyQaXkSadxWH6BJYskXom9+y0OxD+2odPQ39o0/pd1raPds0Mns0uTGPVgs9T1uAe9FkHRFyb30rgqPIGaksGSMM56FrUtN7qCReV62IDeHHbYrz3DmvAf/R3eSwWYoaK2I1lef5dVtiZDHcUjbUgp5iwP+8ZoedEbUeEqq9ER1IYcgaXn/GOE+W0ZjalswNS0N4Vb3zrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFqfPuPlCTzXR4xAesuukJ6lJaE5/DPmJqVzdnl8hfY=;
 b=bUeiGJT6DZNqSA52optwCNWY95My3QDKqEdkqnx1SN67RwEVHXFwR12X24oPnaPr9eSc9qm1WRGqZRJ8IKq5jMdQJrduJVwUCdeMDaDyRH6U7NssiflY48Ce+xj2ywgM10ruIGmVGzgY76rAVz9bZ162wh4H+M+c2YeuZPJDWyJdV7YkAN7Pw11fBdNAGdpmsUr4NnDtKgkpl5ZAHTvjgFuT/JWGtK/JfLodnU29kNrIJ4/OgtUhYb6PoxDiPJ//mktV5Q+tjwghVxF4phOpNP02BTY0pjToEWHgOTwQcgtgr040QGQifFuybtKSO77ngU/oJBKPQzyM/PMUcxTddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFqfPuPlCTzXR4xAesuukJ6lJaE5/DPmJqVzdnl8hfY=;
 b=H1g8TO/KgK4I+h9l/GSv0aQRqj8+jPPL/lNUnDsrf7wB1lRXvtEV+KtLEJFWzskhWQ479H0x9bpLfwYqLMmlZ4C/RkzN0O2pTS5Xo4oWWrvq3kSQR0jR4OU76D3NYL0aRhc3MBy0gxnmv4WFT6Z5CL3YwLX3Cq09cYKIbahF/B8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Fri, 13 Sep
 2024 13:02:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 13:02:15 +0000
Message-ID: <a6f291e9-635f-4aa9-ab6a-5cfa83604826@amd.com>
Date: Fri, 13 Sep 2024 15:02:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Miscellaneous FWU fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240909112021.1962801-1-sughosh.ganu@linaro.org>
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
In-Reply-To: <20240909112021.1962801-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 249c9477-8647-403b-c69f-08dcd3f44a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1cyR0NKQ2c3WjhOc3h1RTBSU0RjRExQa2poQVkzNWcyamlwTUdLaEZLVXJL?=
 =?utf-8?B?OGpoOTVYbzRaam9nT2ZCR3RhRk1nYWJLWDJzVDdEQW1EdFNrbmQvYUs2SmRn?=
 =?utf-8?B?eUQ5R2svWnhwNzJrTlV1Uisva2hhdXUzK2o2UTZvRHI0aGcxNUtVTGNLYi9t?=
 =?utf-8?B?S0syeDZ2UnUrMjRScEhLMjBnWDFqblVvWDRDK1BhY3RRRlpaeGhET0dDb1Nq?=
 =?utf-8?B?R1g1Vm44UXhDM09TMUUyeDhmWm0wbWZpbVVORkJFNnpqNXlBOUpaTGVEYnZk?=
 =?utf-8?B?bzF3eVBIb01sZHJoQjFJQyt3K2E0SCtSWFovRXZJZU1HaDlBT0F5RUpydi92?=
 =?utf-8?B?cGVYSE9TS3k2REdVdkkvZkNKS1BaZzgyWUR3dUxRSkhtaC9rR1d6dG4weGcz?=
 =?utf-8?B?N3VFdDFWaTMxUzR6UGVJN2E0aTROR2Rsb2ZoSERxSWIxaUt2SWxHMTFEOFJm?=
 =?utf-8?B?aGthMzE5WUZkcHNCd1JVZVVwR0lEOEhoMDVwMGp6Y0VEKzZpY28vcXBaeHhw?=
 =?utf-8?B?MjI4YWJQS2wyMFZ3QzFadk1lQVMrTENtMTdKV2dNZ1NsTjBTK2JWYWpCYjE5?=
 =?utf-8?B?RC9QTFhaYmZuVDJYNXQreGZJdUhLblNQd2hzSXcxd1h1MUhEa1hkNEVDaHZz?=
 =?utf-8?B?K3hQL1o5MHZseXdia1hCVEhRRDdXRlVoc252WHgya21oR3BzY3J2dFNwOHRz?=
 =?utf-8?B?aWpsVFUwWExFTXl6VW9IM0t0K045OVJISThsTUgwZ2pKVkF2V1pDK2JEM0dn?=
 =?utf-8?B?Uk1XVDloMU53dUtGdzVENUpEQTEvNkZ2bTJxT09Vb0EzdWdhV3JtMld1TjVR?=
 =?utf-8?B?TFRSazdDd3B1Sm5lTDZwdEVnWk5qSGhHM1gvTldwc0Y1ekFieDNDWkxJd3U4?=
 =?utf-8?B?bDBQUE9YdlZkblZ1U2dhVy9NcGdGbTZwalNhZzdhZEZFQWJWSEVjTnR4aUJ1?=
 =?utf-8?B?cU1oU0NHcm1ocWxMZmNnUk8rVTI5cTRDb0pGT2M0QU14K1d3NzBBNGxPMHUw?=
 =?utf-8?B?WlBsbG14Z0hOSStTZ2dQcEI5dUE2bjhVMzJORWdYWTJNbHgybzBYZDUwV200?=
 =?utf-8?B?U0FQcHVoY1BCb0kzYWlXa1NDd3pvditIQjREb2VxOTFxNW5xbm1KR3NuWnlP?=
 =?utf-8?B?T3pabndOeHJ3Tjg4MVlBd0JYZzE0UCtrV1VUbUZFaXBFeEZ4QXVLTUZwTlhk?=
 =?utf-8?B?elEwWGg1U0FpRnhaYTd3UktRa2dtTDljM213ZSsyRHI0SkRqYVNDbnhNSmxt?=
 =?utf-8?B?SWtaMjFqNGhWMjdwUGlsVVpqUER2Z3RFMXhWMnNvWFl5dEp4S1dQOTJLd2lT?=
 =?utf-8?B?d2YvOGFwa0RJZlAwZEZBaGVXb3hMSDhKYzEybGRmcGJZQ0lIZ3NNb0JPK2tW?=
 =?utf-8?B?SnBZU2RIeW4vcDhLNGZwSXZML1lhQ2pFOEhYM3RNTm41Syt0MXFtK2NRbitk?=
 =?utf-8?B?Z3NjWDhmVEVScnczVGE0TStjeWwwRy9XVUFDVFpGQVVnNTRnKzZpZEQxQkxW?=
 =?utf-8?B?YnhFQVZ0VFRILzk4T2tXNXErTDVOQllkUVdQT3BiL2tha1NwQjNNMXhXV2Jt?=
 =?utf-8?B?aTBXa1pTd05lVWxtWG9JT3ZRS3pMeXdhK280RGtlMnJlZnRWOFJNcEVBQ0dE?=
 =?utf-8?B?MFFuMk5zTUZnL1QzcGZyMzlEOVNNQ2pla2Ezb2VLK3VodUY5K05vT3E1S2Mz?=
 =?utf-8?B?WU90dkdkZ3YzWWRUSEY3Rm01cWc5RWd1UmpPMk1ka3NWM0lyTlNydE5zdy83?=
 =?utf-8?B?Qm42bTNHOVlkU1hIbkJpVllIR1RuZnJBTEVTczg3MkErUWR1WjhQVWhjOEFr?=
 =?utf-8?B?MzhObFhxeVBaeVJCUU9mZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JHWUJlTUhIRGZzRURPUlhkRzJuY3c2Y21WSEUwMG03djVnUHcvMm5XdFlr?=
 =?utf-8?B?VHE2R0dFeUZaNnlxQXZnS3J4ckptbFltREtrejBhdEEyS3JLL2NqTkxWdGZk?=
 =?utf-8?B?UjRSNTNsbCtPZEpLS0xGNlo4TzBKZnNjUTExcnM2TFBqQi9SbEV2MTVaMEo5?=
 =?utf-8?B?UDRCbTZBRTlRd0F6VXhNMG9qcHo5RVNQKys1clY5dmFCaEpDS2Q5WUJkOFdF?=
 =?utf-8?B?bjkwZzVHZC9QU0JZZkswby9xT0syNllVOEthWXFpbVduQzB2Zm9GMFRhT3U1?=
 =?utf-8?B?Tnh3UzNadEc4SC8vai9VZ1ZBQitzY2lyTnY3d3NIK1piaFJDa1Y4MEVidmhB?=
 =?utf-8?B?RmNRbFFTQ0c1UjZzQ0xPbTlIMEdxSDJmN3B4cmRHMTNXelhaZlFUYTRKNWRn?=
 =?utf-8?B?ZE5SblhjMTBLWlNLUVlnZ0hEWTVDb1U5WUZJdm1HOVRsQzJXWnMzckw2dXRa?=
 =?utf-8?B?QmExMjYranRKRnBFUGFHZHB4SzJwbGhETWVqNXh3dlFxdXlNcXJEaDFGVEhr?=
 =?utf-8?B?ZzZzQjl4eHpGNURjWWRqZ083NFJHNks1eCtMRTRZNzhPbURoY2ljQkhVUHdC?=
 =?utf-8?B?aUNoOFJHS1NBYkZuQXBuNG9mZUVYN1VmR3hBTUUvdnpEb3M0NFBSbUhCYUFW?=
 =?utf-8?B?UDJvbTlHRXVSM2tvYWhEc2k0YW1BcW81VkM4b0gwVkJ3b2s3U3NyOGl6TFky?=
 =?utf-8?B?L3lzeVVkbFlISmxSV0ZiT0tlUWZhaUsxVUMvZlE0WXI5SkxRT0lya1FiQi9i?=
 =?utf-8?B?NmNwN3lNdWU0T0JObkVrSEdGek93OTFBVGdTd01XRFZWUFFOQ0hzdkJESlg4?=
 =?utf-8?B?aW9lbUgxam5UV2NUV1M1SnRGZmlXWHV6WUtpVS9qcE05QzhvMWxDQ1hOVHZN?=
 =?utf-8?B?cWpjNWJtcTVvSXlGbS9MMENpN3BmamtJU0daQkNwVUxDbWk3cnBVc0dDQzNM?=
 =?utf-8?B?VkJFaHpKdytkU3pkYlVlVUV6VnVIejRWcTZMNjZsTEZrRldjWWRNMjM2Wlg0?=
 =?utf-8?B?MkRMa0piaHp3QlpjampWTDFZdUhMSDMzdThYaUJPa2gzRDQxKzU2anNUanQ4?=
 =?utf-8?B?enFHbk1oOWxpWHBqVEJxSmN2TnlzbHhXdHJhVXJXTVQxN2VsZFlMUXYwMFI5?=
 =?utf-8?B?cDZlVDhObXpxcmpQZ3U3VHpsanZVaERZclAydm02WWV0RjdTK096SFRtSTRQ?=
 =?utf-8?B?NVNTR1lob3FOSGdxb0U0RDdKYnFZaTV3MlpJalFqM29HY1lnKy94K0VEc2ox?=
 =?utf-8?B?V3dWeXdnTEtTTThpeWxZYktrVTF2S2wwdkhxNmpoR0g3ZGVXelJTQnIrbSs1?=
 =?utf-8?B?bk9ZdXJzUDlBWCtpZG5KSjEzVGdzK3VjeTk3NnJuSW93ZDI5TEpCUm80YUtF?=
 =?utf-8?B?YlBsT3lyR0VENGVNaFVCNWE3RWJMakttVm80ZUJJWHlQd2hwSXU3N3Z5SXhw?=
 =?utf-8?B?NDhWeTJPNGlSMWlHOW1mWmJDUmV4QXdFZ21pTXlySzhYZzZyQ3hqamVZejJx?=
 =?utf-8?B?RHBQTlFtLzJEbFhYR3Q2M0lWbEEzUUxmNGxkZkVySUNYTldRd2c3cDFISlMr?=
 =?utf-8?B?SERkbTNneFRUbW5QT2xZWldjclpzSlFheGlZMGdVV3hjNnhKbUR1aUNwS25Y?=
 =?utf-8?B?dWpRbTZGS3ljUXF1RzlzZmhwd095MUY1dlI2dUVvTzhwWFRtNXNqUk1ONmJH?=
 =?utf-8?B?VVBKUUFsQ3ZjTEplMStrbUhyT0lvc1Z3NFpEeUJHeVA3QzZqNjFIWTd4T0xT?=
 =?utf-8?B?d3lxb3lwWWRHUkUwemJxTnlaQy9SOEplS2s0SG1UQk5CNmNYTU16MnlTLzV5?=
 =?utf-8?B?NFZtRWwyTlB5YnNFZG9yUVlBekVFUFZ6Q2ZWUHlHOXFwUWo4NnB4VklIcHBa?=
 =?utf-8?B?MmVoREQrUGFzSURsZFp6bHBab2pSY29ka210UWhpcjJMamJEbjJGSk5SaHhi?=
 =?utf-8?B?K1VKYkJzM290QUtFdnllRzFXWU5kWTBlMUNsRXBiaHZTSWtneVZHcHdjQnpt?=
 =?utf-8?B?b1YyQWpFcjFTRUFwWm9UM2E1WXFjL2ZEY3VrMlMwYUUwSUh4NDNLTzAxQXkz?=
 =?utf-8?B?SE56WXdwRGtXR3NvcDJuMG55ZnBoVmY1WE8yOWdYcVVBaUVRQW5vNnVobUc0?=
 =?utf-8?Q?zov1CkfU8pjKkaAVQ6onNqOZc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249c9477-8647-403b-c69f-08dcd3f44a6c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:02:15.6520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALCcJo1h2VAR+1l0wDijOFs0J8lFo4oVr9mPCkX2uIFArVC27Bznz2yiHlahPBor
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
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



On 9/9/24 13:20, Sughosh Ganu wrote:
> 
> The following set of patches are miscellaneous fixes and some
> hardening of the FWU update logic.
> 
> 
> Changes since V1:
> * Squash patch 1 and 2 in the earlier version into a single patch.
> * Have a single check for image descriptor offset, and have a log
>    message mention that image descriptor mandatory.
> * Use a macro FWU_IMG_DESC_OFFSET for the image descriptor offset.
> * Use the enum names for primary and secondary partitions from fwu.h
>    instead of defining new macros.
> 
> 
> Sughosh Ganu (6):
>    fwu: v2: try reading both copies of metadata
>    fwu: v1: do a version check for the metadata
>    fwu: check all images for transitioning out of Trial State
>    fwu: add dependency checks for selecting FWU metadata version
>    fwu: do not allow capsule processing on exceeding Trial Counter
>      threshold
>    fwu: print a message if empty capsule checks fail
> 
>   include/fwu.h                | 11 +++++
>   lib/efi_loader/efi_capsule.c | 11 +++--
>   lib/fwu_updates/Kconfig      |  1 +
>   lib/fwu_updates/fwu.c        | 31 +++++++++++++-
>   lib/fwu_updates/fwu_v1.c     | 18 ++++++--
>   lib/fwu_updates/fwu_v2.c     | 81 ++++++++++++++++++++----------------
>   6 files changed, 108 insertions(+), 45 deletions(-)
> 

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
