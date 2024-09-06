Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0227CE7AB6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 06:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA3088CF5;
	Fri,  6 Sep 2024 08:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IBi6NXIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB6E088CF6; Fri,  6 Sep 2024 08:35:39 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1353588CF2
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 08:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHApmtSIhZOAnBX4qk8PHXmhYbdMOxKK/EA8EVsyVL0Eo8FMURqFVhNFWxQ7PI7CtR7W2aAORud3QDBJvPotpOlBSx89DZO5zaldPtiriLQyJ1DRxAPB0khLtKij0siXcHoCSg8j6Q1tm76DsZ/39DTZpFVRQA9lHVocpqYQFowGfaSXTJR40LrOCfy8pmLmTsvr9xpWfc09yOT9vEGz00E6Ag27AFGxrABwjZT5f/dEXI0pN9kyQb0s5YGbhAFBkfinsaU21FJm4xtfwWCyRotJcSWMVAttYT0X95Yo1Ixm5aXFg0uV9WV1+ueOxYx38Asl5RUxsBUuvKt4OjfB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiWQkqdmtewWeFlux7gjJ356t7FnuiWQj0koWTztIs0=;
 b=MaDYRKaqpDZy9wyAWPDHN9HPcir90I2e8OdawfvRTt64rV3dQCb3JsexqzbNHB2Fsmuk9Hkn+a5XnUgcIUuiD7P3HweFxPzPDLHCTTg1IvMT0EdAuA36Upz7Ybrv2a8RQjLeXdv28sE6Ij9ENGfZr6C/1aqd2W24CeJ+ETjOEv5x8gjKKwwyk1kojjq9zHCozABw+7oqlxWAbQtMK8Q+KvD2VCzkCTOInHP3/4r5shKcJd1odo2pYq4xZ4KFRCyTczUKh79/0af2vLvmR6XpiZzg3hL+/kHOuXubvLLZeLoJeVgGdUFfcl+/k0jXvS2dcYa7TXzpfYZf4pbbCCWvKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiWQkqdmtewWeFlux7gjJ356t7FnuiWQj0koWTztIs0=;
 b=IBi6NXIJ8ygmjSCLq4YIM741XFQgeyqbX9KlLmTBvjc1E4w2kD+9Gtkev5rUf1FPAUfJ6ESsr7qoUyBk+qlcCv/5OBd9RR5SviHfga0Olb4GhX8aLxiqbN5rUzBMPKKE33CEtfGLlIOn0MNy0G1rFg5jnff25jSVhgENa/3LWrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 06:35:33 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:35:33 +0000
Message-ID: <1bf05e73-3ef2-4f15-87ab-64c32d60f924@amd.com>
Date: Fri, 6 Sep 2024 08:35:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
 <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
 <CADg8p95OdP5DE39VO+2uu28q_MeYFD1qqUZOvoAXQwUztBGZmA@mail.gmail.com>
 <6f1e9198-e9ef-46e3-afae-62b3f84d97c6@amd.com>
 <CADg8p97A+CJjmEtiVVU3S4GLvEie2FFNi6nN2Ho4ZtAceddJ=g@mail.gmail.com>
 <17fdf962-20b7-4bb9-93ba-bdb7335c4762@amd.com>
 <CADg8p979GVQ+bk4RYUmE94Fnd1jQ6sv41V82ZRW=+gjRhn6dwA@mail.gmail.com>
 <41f4766b-7861-4608-905f-9717e6fdc230@amd.com>
 <CADg8p97-Nbn0AsnL4Tu=375uoONmPSgr9Yj0MnEB5u1O8P0AEg@mail.gmail.com>
 <db7aaa38-d66b-4575-a50c-0b1bdbcda9eb@amd.com>
 <CADg8p95Sg9ASrTOXOGJz8-HcFxuadRL6K9URYAQdZGCZ9NPgQw@mail.gmail.com>
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
In-Reply-To: <CADg8p95Sg9ASrTOXOGJz8-HcFxuadRL6K9URYAQdZGCZ9NPgQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: 50aa1863-8f7e-45f5-8a22-08dcce3e1c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amp1aC9KaHRnUzNGWithVkQycmNmM2toYzEvMEw4RnpUMVRaazlyUk5lbVFr?=
 =?utf-8?B?QWpnUFR3TlA0ckYrTFRjQzBmU3d5WVNYV3NWOUcrNjdiamJHZ2JIRnVkT3Uw?=
 =?utf-8?B?cmQ4cmpsenNkZ0VDOHJvMlFzY2Uyd3JIZkdNcFVmYzExZ1JkY3lrQTBCN09y?=
 =?utf-8?B?VzdBWTJzejBvM1pxNWxWM0E1c013WkpjSDlJL1N5SkF3YktjNXlmbFRMdXpJ?=
 =?utf-8?B?a25KUkZRQnlBUGZ4QnZYbTZ3OTd2aTlocjJxSnJqd1FkWFMrcE4reGtCWmJq?=
 =?utf-8?B?UjFDeS9wL0tQT3AzTTFockFIYUxrUFpMcGlaT00vcjNibnhkZDZqWlI2YVlQ?=
 =?utf-8?B?U3NOMHpldytndXRFNS9CYkVvbkZONU8zWWoycGYvNmVISXRrMS9GdVdONXRE?=
 =?utf-8?B?QUlBc3o1WlRaWWpPUGhvdXA1K0Y1Q05tZk9EZ2pwRTFnMVJaM28yUnBRYnJo?=
 =?utf-8?B?R0xCaSs1aWNSRXpMbFowOFJCMW9IdDJIZmxxWFVzV1lQUTYxZFFITm81d2tw?=
 =?utf-8?B?M1lVZ0FzRWdKaWdCdFdqbVZSZnllNk5UVEVYNTk3U0czbm9CYm10aTZZOEUv?=
 =?utf-8?B?YktqNlhIUzQ4YW1PaDlPQlhqSm12ZzNRTGtyQks0TitLRnJMaTMwazNBcllN?=
 =?utf-8?B?Z2txUTYrZE5xWWtrUlNXUytCZUhvY2xXaVM0dmwyd1U3eXJWMzh4NVV4dGZa?=
 =?utf-8?B?by9wNkRoUTJ6NEpOVUJjMTB6aTZKY3lWSTFONnl3SWJ0Y1d1QXR2dUVKd0pS?=
 =?utf-8?B?U2NtTldtd3RlcU10bTR1TlRIZWhDODJuWjBWWjExSStZNENoMkpkMWwxcW1p?=
 =?utf-8?B?Nk1Zd1VOVkFRZllDcjlxNWd0ZXRQV29FYTNTdjJrRnp2SFR6SE5vZ1o0V3N3?=
 =?utf-8?B?NTBDS1pCbVhjanpoSU9SMmJtRXFveXhlS2F0c2VYT2lOc3FodDVuRlJiZWk0?=
 =?utf-8?B?Q3ptZUh1dFBySHpxbE5lTWliQXBYeUYzaEtsNzZPUHVTQlhPT1I0dnN0OWE5?=
 =?utf-8?B?M2ljbHoxcFBVNm9pQUNmeFBsT0tEc2dsRThXVjF3dzA1WE9QSXEyYVZFRWJ0?=
 =?utf-8?B?cHBSR29hUFNUN0tCU2lxOFROV25hT3dCanlqc1k4VlJrS1o4aWFwMDNOVnJZ?=
 =?utf-8?B?d3N1RDdqaWR6WEtOZlRCbWJDSk5JaVZIU3AxOEZ0U29iTGozQklPb1ZyeGlh?=
 =?utf-8?B?N1RCQlhYWE1mUzZ5anRud3I3dG5KSjVzUTErWUJIeFFWRW12T2FpOHVMNGpp?=
 =?utf-8?B?R3hIcUZrU2NBWTZ4dlFBcUlRMjc4Q2phUk9heW54S3pDRnBkR1dBcXVuVVcx?=
 =?utf-8?B?blhzMnY4bE03U0YrSk9IcEVlZml2VXEvUHVnWE0xbWRoejBBeWVSMGI2Tnc2?=
 =?utf-8?B?VmQ4dHVXMVBZRGREKzZuZ2ZRdDBNYlZKdkM5TDVVZDdVNWR5QjhBN2F4MEJJ?=
 =?utf-8?B?T1MxVlVpd052aUthSS92Vy96bWFsdElkWENnRGZDZkVHaWs3NUlGRjlZNG9Z?=
 =?utf-8?B?aEtOZzFML011MFdiZ1o0QnE1SmxyQ1kydUQ4TEs2ajhZUTAwdjc2ZXk1NEhY?=
 =?utf-8?B?RkZlYzh5d1paQ2tRYzliM2JtWmlRcGRqWHJIaXIwc1VEWnZDWmo1R3dqSUth?=
 =?utf-8?B?cVBpS1NaUkNCQnpFWlVILzQ4cHBvVXBrZ2Q0a1k1L3cyNmhjTERKQVlwZXBB?=
 =?utf-8?B?S0ZXSlA2VEMrWmlmcXJ3TC9GbmpiTDNMcGdPY1NqQVVNb2lsa3lpYXkvbFlN?=
 =?utf-8?B?dkprbjVObTFnK0hjemtCOEtXMjYvc01lclJlRDZnUkFtTGRaWFF2UG1uKzN0?=
 =?utf-8?B?Ny85UFlQOEZwc0hkdzVwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xTaVVmNXV6SzM3NTBVVXVHYVZUSEJ1c0lEVnZrbGJnTCtRVkxqUzFIL0FU?=
 =?utf-8?B?bEVhMldKR1p5QWZVWUk1Sk01THVmbDlpZDU2NTN1dkc4TEVWeXdEVGJYNkdP?=
 =?utf-8?B?Ui82bUsremFzZkdxK1VvSmJZN1EzZlYvOERYelpJTTlJd3E0QnpUK2R1QkdP?=
 =?utf-8?B?TE9HckRab1BaSXQ4V3FmeXBNcTMwS3pkUWxsVHE5aXNsYWJ0WXVUQWRrTnlR?=
 =?utf-8?B?MFRCVjR2SUlaYURFNk5udzBlbFJ3L0ExTHFPVjRKVGZCMUZNSE1KSXpRNXNo?=
 =?utf-8?B?UHY0bTRVQWR4S2pEZ212UXYzbmVpZGYxMG94aGZqNExzcE5SZUNQaTBMY2Fj?=
 =?utf-8?B?K3pKM2FpTG9tUnhESTBuT1BEMVdMWjB6SFF6WHZ5V0lFVEo5em9BYkJTaFFQ?=
 =?utf-8?B?REtRVGZiREdrY29ndmRJbU1kaG5OR0FYR1diWFg3bmgrS09ZUWZFZWZiN0g2?=
 =?utf-8?B?cXYwbDNXbVlFa3ZZbld4bzRJcm9xTktvc1NhZ2FheUdmNHJHNzNuQkxjMkxH?=
 =?utf-8?B?czRZN3BQcEFqNTF0ZUJWWjR2cTBrR2JUWFhTdTJmc1p6cGhUR0hVOFA3MHNz?=
 =?utf-8?B?dnFWNDkyTEhuZGUwOHQwZHFsMWVQV0htQ3Y3Y05ZQ0x1WEp1Z1pXcUVoaVB6?=
 =?utf-8?B?Nm94SjBnQlhudTJSR1g3Z1NYQlpPT2JkVW0rb01Kd1FPTnp3TU5JMDdTaGR5?=
 =?utf-8?B?ZHRzQlNMaGR4WUxaaVhBVXQ0cC9LcGl2TjZqZzZxY1g3dE5iSTQ3RGw0b0JR?=
 =?utf-8?B?OTYyUkxtNC9DdHlFYlBNMHdYYkQvYWxRSFU1UkMwbFpGVmo1SkZIT2RqN0dE?=
 =?utf-8?B?Q3EzK2J1YU43MmpuY0JHT3FEZkR4TW8rWjExY2Z6Q3V6dmxjNFYxWndkSk5h?=
 =?utf-8?B?MkkrT1BIemlqY05JdE9XUU5zSXQzSU9Kc0VRQVp0bk1zdUpIMlRhUStjUUVx?=
 =?utf-8?B?MGhFWFRvdzhCMEo4NU5XdlBRQ2RuaVRobWtVTVVkbUpjK2o5Vk1CdHJ4MVhO?=
 =?utf-8?B?UGF6bTJGNW1DNDF6MUlGL3p2NjBiSjF1Z210R0pGNy96WFp3T1FpTE85YXZP?=
 =?utf-8?B?QmlCSnRvOVNiS3Y2UFVEbmZQSnVnUG9uNXVIL1ZBcmVtNUh6Sm0rcU5YSDll?=
 =?utf-8?B?QXVtR280SVBtWWtjczFTTGZtMWVDcGxsZEp6dmc0NjM5bFg5Ym9HQ0t3ZFFM?=
 =?utf-8?B?VEpXVzFIR0JhaGd4d0REM0ZHY0x3b0VkazBpVlYxb3FvZENxSjVjTm5PaTFz?=
 =?utf-8?B?ZW1TYnpUL2hIUU9JZmJXSnEwWVM1YWo3empnMVNLR2NjTm41cWFWL3BETS9B?=
 =?utf-8?B?SUNEZUJ5bHhnUWhwRUZpWmxyYUZmajJKMWRwL3lockFPbjlqbVRMUm96QXVO?=
 =?utf-8?B?dkFpWkhKYS80VDg2emJERDN6dDNVU05Mb1JudlhOUVhCV1QwQSt5a1V0OHVX?=
 =?utf-8?B?M1FKOFRLNWhxM05rRjE0ZmNWTHRldWQ3YmpLbEVHcjJIdkY4SHd6L3ZnekJS?=
 =?utf-8?B?Umx1VlhaSG53V2o5ZnZENTBXWHcvM0hMb0tyM29ieGtKY0JqR255cm5MVXZ0?=
 =?utf-8?B?T3dwdnUvK1VFL2g3c1RvYWRadWg3clp2aTRveTROSCtnSnZoR3REa3JrQnlV?=
 =?utf-8?B?TWVubjBkT2M5ZEZRU0krR3BabUNBRjVMR1h2bG03OUd5SnVCM0pnc0ZEeVFM?=
 =?utf-8?B?UjkrOUdwa1FCdUFLYk1sbCs2bVp5WWFCSmZDTHEyb0l3eEk1b1lvM01XVkNO?=
 =?utf-8?B?c3lnMGFTbGJBVy9uTVlJL0xBNW51VFl3RWU0aVE0TWpXWGF0Vm9aTDNvTnBq?=
 =?utf-8?B?cVN2bUgxNGdlNVY5My84dTBqa1NQbjFSd1dvcXJJU0tvc2p0MnB5ajNuTmZE?=
 =?utf-8?B?c1VQREp5VWFJUDRGYXA0SmRmNTA0NGFEcmJZdUo1RzMyNEVPUzdzTWx3RkhF?=
 =?utf-8?B?R0daMkQ3eEVtcityRlRrNTNuSm80dGxqZkorcDMvakptV2FHWEh4MFE5c1ls?=
 =?utf-8?B?VXVwQXQzQk02ZVFobTJuK09GWXE1WHo4Z1F2UGoyUGlvOUhZa0ZXNnNaKzlK?=
 =?utf-8?B?MWJwQXJ5d3NTWXdnaTJHMFBQM0ovaWQ0ZjNkWFg1VDFhWVVwTEsxbUNaREJ5?=
 =?utf-8?Q?rIbHL9dOZwCPSb0ezB+A2rUe7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50aa1863-8f7e-45f5-8a22-08dcce3e1c17
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:35:33.5064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFcB0lQ8Z42EJ/edoNDiydDUMUm61aDD9Z77L6J20sNrTkDtO06oMyC3/tYTmK8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101
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



On 9/5/24 11:17, Sughosh Ganu wrote:
> On Thu, 5 Sept 2024 at 14:07, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 9/5/24 10:12, Sughosh Ganu wrote:
>>> On Thu, 5 Sept 2024 at 13:20, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 9/5/24 09:43, Sughosh Ganu wrote:
>>>>> On Thu, 5 Sept 2024 at 13:09, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 9/5/24 09:38, Sughosh Ganu wrote:
>>>>>>> On Thu, 5 Sept 2024 at 13:03, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/5/24 08:24, Sughosh Ganu wrote:
>>>>>>>>> On Wed, 4 Sept 2024 at 17:30, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 8/30/24 13:40, Sughosh Ganu wrote:
>>>>>>>>>>>
>>>>>>>>>>> The following set of patches are miscellaneous fixes and some
>>>>>>>>>>> hardening of the FWU update logic.
>>>>>>>>>>>
>>>>>>>>>>> Sughosh Ganu (6):
>>>>>>>>>>>         fwu: v2: perform some checks before reading metadata
>>>>>>>>>>>         fwu: v2: try reading both copies of metadata
>>>>>>>>>>>         fwu: v1: do a version check for the metadata
>>>>>>>>>>>         fwu: check all images for transitioning out of Trial State
>>>>>>>>>>>         fwu: add dependency checks for selecting FWU metadata version
>>>>>>>>>>>         fwu: do not allow capsule processing on exceeding Trial Counter
>>>>>>>>>>>           threshold
>>>>>>>>>>>
>>>>>>>>>>>        include/fwu.h            | 11 ++++++
>>>>>>>>>>>        lib/fwu_updates/Kconfig  |  1 +
>>>>>>>>>>>        lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
>>>>>>>>>>>        lib/fwu_updates/fwu_v1.c | 18 +++++++--
>>>>>>>>>>>        lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
>>>>>>>>>>>        5 files changed, 99 insertions(+), 42 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I found one more thing.
>>>>>>>>>>
>>>>>>>>>> I did this change
>>>>>>>>>>
>>>>>>>>>> diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
>>>>>>>>>> index fbc2067bc12d..dab9530e499c 100644
>>>>>>>>>> --- a/tools/mkfwumdata.c
>>>>>>>>>> +++ b/tools/mkfwumdata.c
>>>>>>>>>> @@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct
>>>>>>>>>> fwu_mdata_object *mobj)
>>>>>>>>>>               struct fwu_mdata *mdata = mobj->mdata;
>>>>>>>>>>
>>>>>>>>>>               mdata->metadata_size = mobj->size;
>>>>>>>>>> -       mdata->desc_offset = sizeof(struct fwu_mdata);
>>>>>>>>>> +       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);
>>>>>>>>>>
>>>>>>>>>>               for (i = 0; i < MAX_BANKS_V2; i++)
>>>>>>>>>>                       mdata->bank_state[i] = i < mobj->banks ?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> to break desc_offset location. I generated mdata structure and write it to
>>>>>>>>>> primary mdata partition.
>>>>>>>>>>
>>>>>>>>>> This has been spotted by (my debug) which is the reason why I did it.
>>>>>>>>>>
>>>>>>>>>>              if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
>>>>>>>>>>                      printf("mdata offset is not 0x20\n");
>>>>>>>>>>                      return false;
>>>>>>>>>>              }
>>>>>>>>>>
>>>>>>>>>> But I got one more message below which
>>>>>>>>>>
>>>>>>>>>> mdata offset is not 0x20
>>>>>>>>>> Both FWU metadata copies are valid but do not match. Restoring the secondary
>>>>>>>>>> partition from the primary
>>>>>>>>>
>>>>>>>>> The reason why this logic is in place is to handle the scenario
>>>>>>>>> whereby, during the metadata update, the primary copy gets updated
>>>>>>>>> correctly, but due to some reason (like a power cut), the secondary
>>>>>>>>> copy does not -- this is because the primary copy gets updated first.
>>>>>>>>> In such a scenario, the secondary copy of metadata can be then
>>>>>>>>> restored from the primary copy. In the scenario where the primary copy
>>>>>>>>> is corrupted, it will show up in the crc check, and will get restored
>>>>>>>>> from the secondary copy.
>>>>>>>>
>>>>>>>> But in this case - CRC of primary is correct but data inside is wrong because
>>>>>>>> offset is at 0x21 not at 0x20.
>>>>>>>
>>>>>>> How will this event play out ? Am I missing something ? When the
>>>>>>> metadata is getting updated, the offset will be written as 0x20, and
>>>>>>> not 0x21. And in case the metadata gets corrupted, the CRC check would
>>>>>>> fail and the primary partition would get restored from the secondary
>>>>>>> (assuming that the secondary copy is correct).
>>>>>>
>>>>>> It is not after update. It is initial state with incorrect mdata structure.
>>>>>
>>>>> Well, if the metadata partition is being written with incorrect data,
>>>>> not sure how we combat that (or even if we should). After all, the
>>>>> spec clearly states that the metadata cannot be protected against
>>>>> malicious writes. The logic that you pointed out earlier is to handle
>>>>> the scenario where the primary partition got updated, but the
>>>>> secondary did not.
>>>>
>>>> I don't disagree with you.
>>>>
>>>> Scenario here is that primary partition is updated with incorrect data content
>>>> (but still correct CRC). This is correctly detected that data is not right.
>>>> It means primary partition is wrong and shouldn't be used and it is not used.
>>>>
>>>> But because it has correct CRC syncup code logic is doing syncup.
>>>>
>>>> That's why I think we have two codes which have pretty much independent logic
>>>> what to do. If primary is wrong sync should be from secondary to primary but
>>>> that's not what code is doing.
>>>
>>> The scenario of "primary is wrong" will only play out in case of
>>> corruption in the metadata. The scenario that you highlight, that of
>>> the metadata being wrong, but the CRC check succeeds will only happen
>>> when the metadata has been maliciously written --
>>
>> yes. And I did it on purpose to check your code and all error condition you are
>> checking to make sure that code traps them.
> 
> The code should detect and fix any genuine error conditions that might
> come up in the field. Even the check for the case where the two
> metadata copies are valid but different is a scenario that can
> actually happen when updating the metadata copies, and there is a
> reason why we are assuming that the primary is the correct copy and
> should be used to restore the secondary. If there are any valid
> scenarios that are not being handled, they should be identified and
> fixed.
> 
>>
>>> if not, then the
>>> secondary partition should also be written with the wrong metadata,
>>> and the checks would then fail. In the case of the primary metadata
>>> getting corrupted, it does get restored from the secondary partition,
>>> assuming that the secondary partition is intact.
>>
>> When primary is cleared/has incorrect CRC there is no problem and recovery
>> happens but if CRC is right but data inside wrong code doesn't check it.
> 
> This is where I think that this is not a genuine "error" case. So, if
> someone has written a metadata copy with wrong data but right CRC, and
> only written this bad copy to the primary partition, how do we trust
> that the secondary copy is actually correct ? One can generate a
> secondary metadata copy where the primary checks pass, but the image
> information in the metadata is incorrect.

If U-Boot knows that data is not correct, based on it's check (in this case one 
incorrect field), you should never use it. If second also won't pass this check 
U-Boot shouldn't use it too.

If secondary copy pass all your tests you trust that it is fine. But if not, 
then you don't trust it.

And that's exactly what it is happening here. Code knows that primary data is 
wrong and properly detect it but another code blindly not checking it and just 
copy it incorrect data over correct one.

Thanks,
Michal
