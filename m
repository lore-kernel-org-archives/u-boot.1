Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4C3CF58CD
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45FF5890F3;
	Fri, 20 Sep 2024 08:02:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SDmC+slV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E0189315; Fri, 20 Sep 2024 08:02:52 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94877890EC
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCvuTRsPpaH1TRfVHmUt9hj949WkxmbJJxQ386rI8668lHF4NzLmMcnvFzQO041L7f/fWlcTgtGk4GsfQCGocukxym4ND2PShfbvSCBvAy4jgmqh0ZZGCRAjgl7FTcQwbVcMsftO8V+5bFraaKRWbZff0ytZVClECHbbTBxnrV9kicWF37298ZogN7s+/XgLbGoRvN/8maA/vyq0kW6ZbpgvHJcGmMM8IMpHzTOmwMQAetIkcGEazXfS2hleAkv/du+0ZIld7FGTF5i1B3gz00n2q7TRzzPz61HYIaC+qaEyfh5cKBUa8gXwklRogQJmkqHzN2zsoUeEzFu8MBlefg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etIfJ5rL6tjd9CFpFAqB08bf5FTxZGDuQH+NOD8ZMDs=;
 b=L2kBRJqWFj4vcKGgyYfF+GPOagyYIZlbpKYwVQgKKJCzU0bDA6js0OTZLG6FHOW/EV/HdZQ7u6TffbeNJ1cpx3ASYz/vAwzknVVsy/+QJKeUyqNYolhFxM0GkYabGr68Pi633XyeG0qB3+thcSCXOfld/EkLhryFnYTg+O83H9qcVhpKIgqVpPvxWAJjeqpQDGzTyT6XQP3WsteEUHDPYd1IblVJdyQ8ebgLFEY2jHKjoe0oO9osNHunQ+TlelzkOAsYiGAgFkRnN8taM9+UndOLQGRk37y47ydBqUCFQN8qJrffphgOThU7kIzAgiu2sHFVsOL90Aam9u2OsAc1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etIfJ5rL6tjd9CFpFAqB08bf5FTxZGDuQH+NOD8ZMDs=;
 b=SDmC+slV369VKlTkDYAbnCPoIklNXQh6cMLFZ96sFYxge+aGLRafB54eESJ5vJhNByJ1A53s2oO3DiSC4RbVJJxY0rRhzLgCGymyrB67vcR9EhK8ayFThH7gnuj/x90d5Dj5jYpri+GLKnZie8KaqZQwGEcl2YGLFr4A2dm0zQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Fri, 20 Sep
 2024 06:02:14 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7982.018; Fri, 20 Sep 2024
 06:02:13 +0000
Message-ID: <65412ca1-275f-44dc-9f6d-1bd468d38ca5@amd.com>
Date: Fri, 20 Sep 2024 08:02:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] configs: versal2: Add support for AMD UFS platform
 driver
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 git@amd.com
References: <20240920041651.18173-1-venkatesh.abbarapu@amd.com>
 <20240920041651.18173-4-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20240920041651.18173-4-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0077.eurprd02.prod.outlook.com
 (2603:10a6:802:14::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: ac90fa55-8836-4ff5-c43e-08dcd939c5d6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUZtNmh3aXVnKy85VEVWSFBqQVZ2cFM2QUl5RW5CRHBYbUZiaytYdjRFamly?=
 =?utf-8?B?cHhWYnlVcmZjUEJGeThTbmRMNncwekNmekV5WDdFSkJyVmFUNHZKZnFISmZ2?=
 =?utf-8?B?ek94dk5sVk52ZDQ2VXpyelFQYkhVMnkxNmlwY0VNazh4clJHOWxWUVIvQWJp?=
 =?utf-8?B?WnFrZ3JuZlZEQitNNDRjallITW5DVWpQbHl3NzJtR2FEd2JwOUM1Uk9Yeng5?=
 =?utf-8?B?Z1RUUVJuRVZaZzZtc3p5ZDUwQnV5Zk9PMHEzay9hM2x2d2ZFa1hVb0RnR3ZI?=
 =?utf-8?B?MlcrNGhORFJ1aytlNnpHdzUyMzBhdmxoUTRiQlUxVzBUMTZ3U1pKdTkzYkpz?=
 =?utf-8?B?NktNUUNWMHc1c2lwMzVYMXhyWURNeGhxWW8wRExkUWJSN0wyYlVwMnB4RjZk?=
 =?utf-8?B?c1YvL0RCVjV2U1g3QkJHU1dhNlQ0K3dBcjFaaXJ2Y1haMlI0QkZtYlp1MEtP?=
 =?utf-8?B?dEE0Mk05Y2dIN0pWOFlPcFNaT3JwZGtjdmR2QjJzb0ZHMksyY1lFWnNZeWxT?=
 =?utf-8?B?aXI3QnFqWjdIcU1hR3BKRWV3RXFNaU9zSytpd1VYbGh5SHlES2Q4ZUg3K3Ra?=
 =?utf-8?B?SVVFMWU0QjBIOUkwZDhRcnN6N21IRk16aTBLUGhPR05SQVFOeG9oSCtGZ3Vp?=
 =?utf-8?B?eXVuNmIxOUtpQ2dvR2lJYm4xUklOazdvSXJYWkxQTThpSmFIdWw0d3lXc21Z?=
 =?utf-8?B?VmlEcThjNDM5RmtBRG1BSGlYeklNS1pzYnVhd3JrN0U3dWdoa0JBU0cycFpX?=
 =?utf-8?B?SlR5UVFXRkFhSkRrSEk0OGhLa1hEZi8rdTcwSDRJRDlVWkQ0czJlbFRDTnp0?=
 =?utf-8?B?RzJnSE9ycVc2YjlPTUw4QWkrTm8xbzdBbzgzdkdjNEY3OGtXeFMxbzBuR1hS?=
 =?utf-8?B?YzdOanMwb0x2bys4aXZkTW9DQzVRTzYrc1pjYmRyOW9nb0k4UFgzczlXTkxB?=
 =?utf-8?B?aDltQURtTzNGZ1J6UEJCNDNmTTZReEZNMm5SQWNJRXkzZ1llQjZMRjNhQXVU?=
 =?utf-8?B?R2dCdU5IUVFjYlIrZzhFZDQ4OUVMTnlrN3JaYUU3Mmdhc0o1cVRBc1ozUllZ?=
 =?utf-8?B?WGNFOXZUL1NGc25kU0hVb2hzd2RwQTk3RzBsdGVkUERNTENJVDBGQWlRZlg5?=
 =?utf-8?B?c0d1UUdSa2paTGpJSk5GdUlDdnFpTHBTNTJudWJYKy90djZPUmRHWjJZd3dN?=
 =?utf-8?B?VFJFTWIvV2EvRUJpbUp0dDZnYVVNM1RuSUc2ZlBpVzBTalNrVTVJRGd4d016?=
 =?utf-8?B?N0tXZmt1UlY0eTB3ejFwdWxJOXpvUFpZdnp4c2IvbTdFYllLMzV0ZlBnTktU?=
 =?utf-8?B?ZE41ckt5N1Y0bU9yVHoybTgwaVU1QWtHMzQzVC9CZUNReUxpbmNESzdlVS9k?=
 =?utf-8?B?ZnZtU3BvMmphaGx2cldiczJTWjlySnVEb1JSNU5XWXdaMnd4NkdERjRhZ0dL?=
 =?utf-8?B?b2tLU00rd3JLaU1GcUJ2b3hGNmY2WngxZ3BaMHRoNElrcFRPTDNaaENJRzVo?=
 =?utf-8?B?UVRKd2M5WnpsT2RUdk1LU1YrVldMTHB4RlE1cmQ5Mkw1RS9ZUzBnaEtrUGEx?=
 =?utf-8?B?WHcvV1dXVHN2dW1mcDd2R0I2Y1ZkcjRwWmRTdkM3UWk1Y3F4RFFYK3pMK1Jz?=
 =?utf-8?B?TFdTQ2NEZ05DcUhPbjZqY2gwRlN1SmQ5WVd3VldWeGUxcE5TVTJ4ZDR5VzFW?=
 =?utf-8?B?c1JkUnlmcWlQSkk3SUNobmNuTzlCYnlycWNSTHZJYWdTbXRIQlZDOFRrNEY2?=
 =?utf-8?B?M2JjNGIwc25LdHQ4a3Z2MzR5K3ZNbXJsTkhLVTZPdEtCbzQzemd6bVU1cktu?=
 =?utf-8?B?YnREL2lZNno0eUtTWnZ1Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFdWdjFUVXIyeU8zeng4c213cHBqMW9DcjZvK0s5R0d1VWtTeWlrdVh0NSti?=
 =?utf-8?B?a3hYUnNOQmNQaytxNy9kdExCZytOSGR3bUthcFQ2eDk4MFJXVkxocGNkKzd6?=
 =?utf-8?B?WjRDQS8yWWJZcGduVmU1MkM1eTAvbmxIRnJ5VE9UenBGRXhtNkNGQUhHYjNH?=
 =?utf-8?B?eWZUMUxTZ29jclZyWkhoVzhPWkVPdUd1TUpPVlpwRnZ0T3ZXVWp0Yi9KR2Nh?=
 =?utf-8?B?T2VUQWdEY3o3cjlaZklwdWMwWHg5cUV6NnpPTnFVNE40WDVDeHIzU21mYVZk?=
 =?utf-8?B?MGVGb0pGTEl2bi9ueHJDZm5BL0xJOXFHNEY5Y3AzV2FJcnpiTitvRGtvV242?=
 =?utf-8?B?akVGSE1NUXN6Tk15dGF3VjI0dUU5U2FWeGlJcWNCMkVVNkZyTUsyZTRGZ0w0?=
 =?utf-8?B?ZlVUbkhDM3RiKzYzbnJTQmx1WmtSanEvV2VuaisyajBXbk55NTJtTTlpSnU5?=
 =?utf-8?B?cnh2RCtsY0xRaXd0Z1JkOEhwR0sreDBHazNFdFMxVjBuNk5IWUJwK3J6bGpR?=
 =?utf-8?B?NzJEK0ZDNGpaMFNzVll0eTZDNUFOV2t4Y0h0eEdxM2t2YlQ1U2ZhTC9qNFk4?=
 =?utf-8?B?SXM2UFoyL2piQXFNZllJeitHcFMvNUlUUy9IdTI3bmc2TCtwUTBuRmRDSFRv?=
 =?utf-8?B?aXAybkxBSTVETlE3MEZXK211dUJTSEx1Zkt2eUd6WkROQURyTnpZUmJaMEZu?=
 =?utf-8?B?Q3dJNmlDekRQUzBOZzV2WUxFTjExY0Y4OU1BMTZ3bGtvMngxZk1mNEhhdm9R?=
 =?utf-8?B?MFQyRnAvS1ZTUmg4OTFsYUtWaDdRdkZwY3QzY3RIN2FRSlVlOHExd01nbndN?=
 =?utf-8?B?VndmbUZXZDR4RGRPR29UK082aEtKREpaRmlQUWdXcStZdUZQV1RMeDluaDBh?=
 =?utf-8?B?NFVFeU4rb1ZFZGE4Z296RDdrNFNScWQ1aUdjcHFTYWVwOTlNdytDY1NxMkxr?=
 =?utf-8?B?R2I2LzAxcEpnY3FrMC9nRnhjMDBrWVNoRjNYSmlHbTdzWitkY0NzWkRwQVZO?=
 =?utf-8?B?dE54MmRadzJBeFg0YXVLL1ZGRjhZbVluRSt0Sk94cmJUL3R0aTBlejdlK2Rn?=
 =?utf-8?B?ZzBHUWNLVlQ5YWFLcU13R2EvWlBJWXVueHBVeGZJdGtiVDk4RXh2TUNuYWVl?=
 =?utf-8?B?T1FFVVNJMzk2SjdGaXByOG1VcFJtZUlxWTc4MUg0eTZBM3JPQ05vNXJxWDZT?=
 =?utf-8?B?YlBzcVIxS3o2TGtkcTNQeUI1UGF6Wk9KTVVyQVV3NnpNZFYraGl5eUJ5ZnFL?=
 =?utf-8?B?YnVHcVZQOEgyeWR0SFk4SDFOZHl1MXZ1UThUUGxaREJaZVdiZEhiR1dxUndX?=
 =?utf-8?B?UEp3alZPRDFUMzd4cDNzREZ2RVJyeU55dkVWcU90c3hzMmlPWEkwMEFHR0hB?=
 =?utf-8?B?VEZ1dWNnSE9rYW5JYnlvbVRISnBnZ1c3eldwbFF2QVFQZ2pWR3Y0QzIrQWNp?=
 =?utf-8?B?MmFGeTRuY2szS1RXV3RaakRFTTVObVBndXduQ29FSldXQnRBdE1DLzF1czdm?=
 =?utf-8?B?L1d4QnZ1L1c2NFA2VEJ5QU9EbEJVaUxzL1RMbENLZGVURVd3U01TZkg2RUVu?=
 =?utf-8?B?SkFYcXZOcnREdlpSV25KMlQ1OGExYXI4ZmxaU3hTVm1nRlRSaEZ2WllzYUYz?=
 =?utf-8?B?MEFPWUU2bGxiUGVzL2ZlS3l0c0hBYkF1ZTcwNG40ZFBja3dGLzlaWWdjOWY5?=
 =?utf-8?B?WUQ1QjFZbS9sL085VWU2V0FxbVhXTm5yOTdqSDFVWUFZUGh2MlNISlVHUzRT?=
 =?utf-8?B?NGord2t3VTV0U1hETkw5SGZTa1FQbmk2RVV0aTNjL2VkVTZNK1J2MGlxbHBk?=
 =?utf-8?B?aFoyMk9DMXVPaGpLeE1GZ3UzcVNBSjFzZWhybGEzaUFXQlpLY0dJUmsrMVpQ?=
 =?utf-8?B?QzFEQU1HR2dEaUJvdlJpTzBIMmE1aXJTWVFJQmlpSW1aclY5VVJ0Q2ZTM0tq?=
 =?utf-8?B?ZjJNZ0xFNjJsL3BPMHNleGJSTnh4aWhZVzVtR1lnZ01UQXltZjVFMlVKSTRh?=
 =?utf-8?B?bC9Qc1FiM040OWd5d0ZXb0laYi9JYk5oSXF5TkZMZDBXUDI1VlZqTkozTzhE?=
 =?utf-8?B?RnY0YXpjM0hTaytITVhIWGVkUkZoY3U4OWxqN1hTMk9WVHRSaGNKendCdVFZ?=
 =?utf-8?Q?/Pr1AMiBZJIHqQdcJfLH+funL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac90fa55-8836-4ff5-c43e-08dcd939c5d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 06:02:13.7841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6jlwXp6u+VNFmtS13SzJCFqWj1bJrG3LD67vPM5tTrKcGJ0SeW9MllQ/MyJ5Dyn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
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



On 9/20/24 06:16, Venkatesh Yadav Abbarapu wrote:
> Enable AMD UFS platform driver.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index c4bf77186c..666d76c449 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -145,7 +145,7 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
>   CONFIG_USB_GADGET_DOWNLOAD=y
>   CONFIG_USB_FUNCTION_THOR=y
>   CONFIG_UFS=y
> -CONFIG_CADENCE_UFS=y
> +CONFIG_UFS_AMD_VERSAL2=y
>   CONFIG_VIRTIO_MMIO=y
>   CONFIG_VIRTIO_NET=y
>   CONFIG_VIRTIO_BLK=y

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
