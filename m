Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A141CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:11:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D387C885B9;
	Mon,  2 Sep 2024 12:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FZNVwtm9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA58884C3; Mon,  2 Sep 2024 12:11:37 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 561C488785
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q027gBT16i0dEK0S4+YJgDanZuehTwZ09/NtphwITYsVbEj8svbFFI3NJbwFVZbosxKODq4y7S0e194ybAevMRf0JC0qeMlqSRO5AswQy8v9NOOdKV+zZyugd12wFhU/S/43h9blUqfAIRVPRGvf/AIszJpn4oqxZO+4h63u6nyjcYOSuDUWIXxpNl+zPhhxA8Z2FktFt2m05NegL8kBhEYZct5JcTDlxZvrhOfPDX9Ojkft3xBmW2tBExGWB7a0IbYBNdRJKxikf76LM+wUpg1Pt0zk/xvNMxJRWr7gHO+SYlCBSjQPNz6L0cfs8ExDmskt/U1KcMOv09bGQSK8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoZStYTS750+x72Ehonc0bYdxM2qgQikxMtQlZjN8WE=;
 b=Z7kAO3n7qSPMHhJstZZE4iqpxLuBurHKr+mF4evg27OkVA3BOhWFxbtUaolkRHO/4oyR6bgFRoX4boUCLKsLnUFcxwljGeTPKLDVSTm38O/UDonlFwCxIXvVnPwPcBAvf9xzLmoXEmEUSda7H9PJpn1+4/Duin8v+r9yhi7c15HAMYHDRtKtWOfWpT3pnOfJNU/kK/UwiOaQSXCZ2vEMkxjnY1j+qINZGE8SgIu8fsLNaqu8G9ldQdc+DkZfreH7fLzBoNca8f8u1Xz8uAsqzLruipwFDGoNfCum23e0PZgd4/7g5mYfeeq6AYOXQdUP8P9lD7oS80xpbwMfM2cVFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoZStYTS750+x72Ehonc0bYdxM2qgQikxMtQlZjN8WE=;
 b=FZNVwtm9fKL/YaMOJYMgtrM3p9HoeY9MFDNUvbudwVi4BBWM7G4ErOi3Vs+4cHoBVdKs89ZXYeJIqZqWeNGJScNJFI7wXEpoNRotczQ8Pz36ue1EsEhVpBb6wUDZilb8iySURuGYmN72d8oPeuO6bA12MWZWsONWLl6ifIPHTrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:11:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:11:31 +0000
Message-ID: <93b022d1-63ae-4b7a-aa62-6be2a5c2a7e1@amd.com>
Date: Mon, 2 Sep 2024 12:11:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [u-boot-test-hooks][PATCH] travis-ci: Skip the saveenv and reset
 test cases on xilinx zynq qemu
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, git@amd.com
References: <20240902095357.311-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20240902095357.311-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:803:64::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ee6fce-9702-4d65-7902-08dccb379e2c
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEM0bDZUaWNtd3dTT2RDTWJTUTJ2QURkdXBjUVF6NitLSElNL1R4MFUrUnN2?=
 =?utf-8?B?d1gvUW5KL0pNU01Tb3hhYXo1U2VrRXhlNThJdnN6SkMrckF4eEpONjRnQlJ1?=
 =?utf-8?B?WEJhSkFqUkxwV0JFSlZhWWwrN2NKOU41NThkdXQzUUx0Qy9QWnJZWGhUSHNi?=
 =?utf-8?B?bUJLT1lHUW1LMXMxdGlNYmhYMFhlN0Y3OTY1VDlvaHNMUUxxbWgrRG5TL21Y?=
 =?utf-8?B?L094ZjIrK0VtYVkrZVJhRHVBcGIyYi9KTHRaWmhaaFlLRlZ3WDNqV1haRkM5?=
 =?utf-8?B?YXhYdCtTVG1sZUowZTdXU3Z5RisvQkZtMURDaWQzQWpPTzZsUUVrMm1vRFlW?=
 =?utf-8?B?c0VKZmRPaTJKTU1OMmN2NDdQTWwrNTNwdExiTkE0RFhNZXlpV05uN2x3SGVy?=
 =?utf-8?B?Zm1wajJVQmNKRUJjMmtmQTFEcllvMm5YT1hzOUJlNzFHZVZqcUpFaGl2d3Rq?=
 =?utf-8?B?a01YRHh3YVFQY01XbnhDTmllUXlxd3kyVEJPM1phb3BYQjFmaGlmVkllUURZ?=
 =?utf-8?B?c2RZZitTZXllNnFab1ZHUzI5cms1RTREbEhGQTY4c1ZaYzgxaTVqSGFpVW9P?=
 =?utf-8?B?N3llUWNGMzR5RDR4WWh1c05wMW01ZGdUYk9ZWnVLRVY5Z2hHZjAva25jTjJ6?=
 =?utf-8?B?VE5HR3NCTVpBdUExQWZIdWdKWktwSGNUTm80Q1F1aUpjd1JZK2VYVXVabk94?=
 =?utf-8?B?YkZRL2ZLaVJqK0s1RmlGVFB4cmtsVG9OOTJCYVFWaTBCQWduTVZDbW5PU2hQ?=
 =?utf-8?B?Ylp4VmNQYmNISUhsZUwrVGttcjJVMWRWRmNTQ3hjaGZWeDhWTUNuWXNzcnpa?=
 =?utf-8?B?cWN0NHQvZnE4Qm95cll0QlYvTWdlc0tsRVNOeVY4V2dVb0N6cDlOV0VKeW04?=
 =?utf-8?B?cll0SXJYdWhYUUZybFRxNklua0VKZXU3T2Y5a0tvb0NheHlib1VhU0g3NGd2?=
 =?utf-8?B?MzBLYUord01qMWlTckJ1VUNpc0NZaExyR0c2dTgydjd3bythZUFwczErL2cw?=
 =?utf-8?B?OTgxVE1pNlhFazluL3Vub0hOcDVEVHAweEQ2WEZPcnhLQlVMRDlQNy9WajUy?=
 =?utf-8?B?aVhPSkROdEJEZGJIK1BFN0RyVEh5c1Y4a3pFaGx3bmpCNDQ0NkFGVFpXQ1Yx?=
 =?utf-8?B?eXdOZXRia0ZYNHhpSUoyYmF4ZUQ0MkN2RldFY1NjaXBkbVVRbU43Z0I3ZENu?=
 =?utf-8?B?YUZzZU9DY25hczhQZEdnNlRwY21LY0kxRUdKQXZpdHdhYVAxeWFSamJHbzQz?=
 =?utf-8?B?ajAvN3FTbU1oTkNZVEd1NCtyRzJtQitSRkdNTDZWZWsvMzRlamVQaVdYM0pJ?=
 =?utf-8?B?aGRHcUVybmFUaTNKc3RCWW4xQ3oyeHd5MHRMR2s3VFRmMVJtWTB3OUJYcVBE?=
 =?utf-8?B?Y1BUTUVNeHA4M29NeC9Hb2o1OWhsVmRKQ0t3bFpVbDVnY0FHbGNKUlE5VUlH?=
 =?utf-8?B?eFRaRjkxcGZqbmlyUEJvbEVIU2o2bTBoNnY0cTFDNlFJemtTRkJqOXJONUJl?=
 =?utf-8?B?eElsSjF5T09qQXlaalNDaDk3Q0MvQUlCcnpaRnZxZmxVazJPTm5LZDI3NXc2?=
 =?utf-8?B?dDJGTXJ2cmdUQlN0WHkrbktuWW4ycXg0NWVrM0J2Wm9vWWVsSXdWTi8yT0Y1?=
 =?utf-8?B?bVJpbHJJV01HUDVTYnBkV3AwRzFJZEVzaGhUNy82VUdxR05TUzErM1d0WWcy?=
 =?utf-8?B?S1JaOXNOZkg2dDAzanVHVXhJc1h5NnFhZXY5citNZGdjTEtxYUlGbDZpNTlC?=
 =?utf-8?Q?+Gq97iWGn2JcLa2yfk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnpKcmlHbDdNc1pXWjU5Rk55ZWFiQ0hyQ2Rza011VzEvY00vZHY4L1h6T3ZB?=
 =?utf-8?B?ei9ZL1BPSHIrUmFpbjY4eFVZTVBtQmhhRVJHYXJRZVBvd2d1SUxQMmt1NmdL?=
 =?utf-8?B?enJNK1RLbldIT3BuZmJKNzBnT21JV0d3R0xVQnkyTjErVEI1a1pjaVhJTlZh?=
 =?utf-8?B?c0pscXN1L1NndFUzQWlOZkFzMC82TU1PcXFIeVhUSE9KU0hiTzhxWDVMalU1?=
 =?utf-8?B?bWdKVk8zN1JmSHFxNmJZeHdFclNCUGpKS055UjJmRkkrZE1ZaER5RytQNk1l?=
 =?utf-8?B?ZDZ5UElqRlQ5aTNtUGMzMU1QcHRxeFEyU3RNdkZRdEdGT3gwN1lQOUkrNk1J?=
 =?utf-8?B?dnFQTmJYWXZxTERUM21BSmhadVp6dE1QNU5RY3Vxc052TXpmR2FEVUI3STdr?=
 =?utf-8?B?Tm1JL01oR2NlWDFuZC84by80K2xmMWdCRUkxUmhmTFRYQVRNMjl6S25rcTE5?=
 =?utf-8?B?ajN2UUd4ejBGZHdYcFE0K0cyYTJwV0krM1hrMSt1UHlhZmlBSHhOYldvdlVS?=
 =?utf-8?B?QWpQd2VQUVdIUUQwUHlmcVlZNWFsQUlWQTNEMXFwTHdZVWhvb3g0RGxTZGY4?=
 =?utf-8?B?Q0svTlM3dkd2bjJqYXZqVW9tMjVzNlRzRmVydHFsd2RUbzVQUjBmY2R5RjJQ?=
 =?utf-8?B?UTI2cXNweHpIamhwNllWYm1yTGNPaHpkWkV6Vjc4ZzJ4dG1Gb3RzY1p5VDNM?=
 =?utf-8?B?SDdNQWNQdGJYNDk5QnlsYjdhZmdWVytYakIvSVBYSUI1OHViYVZJNmFQa21H?=
 =?utf-8?B?bW80N0J3bG1nUTd0UGVBU1lwTEJ2YjBtM0dmNm9KTzZBVUNMRVUyMHFMam9D?=
 =?utf-8?B?SWdCeTIxdlE5Z2M0akE5OEZMNklKVldDZkhtOHhjbDJlRW1qNE10K2hwOEhB?=
 =?utf-8?B?UG4wZktUeFJyWnNGWlByWGg5NmczZGlzeXdYM3czTlRpQmNlM05wSjR2Sjc5?=
 =?utf-8?B?ZHZrdGFFMys0N0p6KzNqYTBabTdpMTVyVmU4Rkxwd0RIV0RCaTZyM3BOMzlp?=
 =?utf-8?B?YjJFR0VFN21VcnVFZlZ3NllFTk54YTFRckVRc3VGL0xNaWMrNFVoQWdjZ2xq?=
 =?utf-8?B?ek9TZ09qdWp0Lzh4ckZlSkJmV3FEaTFIK1Bicmd6dE95Y1Z6MENqczNVSzc5?=
 =?utf-8?B?WXIyUDEyTTZQd0FzajFLdFJIU21mM0hQWWxtZ1REWlp2WEE2WGViRUl1MzdJ?=
 =?utf-8?B?Q3V2bk1DY1N0NHR4VU9yK2J2VldPVmF6SjkrNWtrN1BJbkp1bHoyZWF2NEQ5?=
 =?utf-8?B?TFFpV1lUUG9vMEVpNXZESDgyNkVHV1YzdFdBMjlCU1puYjR1VlNxZ0hZTjVY?=
 =?utf-8?B?UlQ3WFN5Tm5DQ29FUE5YM2JKaHBYdDJOVjVxYURaaklhZ0hHMkczNkNlZWl1?=
 =?utf-8?B?am8zZGNta0FxRjR5MW5WSldISEFEWVM4MS9YTGJZSG1Ja0ZEOHZDS2lPUExj?=
 =?utf-8?B?SUsrNDFWbENUMm92VlBzajlpVC9QVVNYcmRhNzhRUERPaitUR25MSkpwYUZL?=
 =?utf-8?B?MkdYRGEyNWNqcjh2TDJRWU9XN3c0TXU2Q1ZpL2FpSXM3VXplR3RvNXlBY1B5?=
 =?utf-8?B?cUZTUjkxc2F1RXhLeE9GZm1FRDlKSllEdFBZc2ZVY2lhck5qUm83QjVnSzJk?=
 =?utf-8?B?Nm9PcDBGbUdWbDdIZHRmck5IeDAva05ZT3hZb3puZVViSk5nZG1Ib1JDbEl3?=
 =?utf-8?B?T0xmaE5MdXZKY2xRN0RBakxGa1FlUHNiN3B5UVFCaXMrZTJjRUE4OE9YcmJw?=
 =?utf-8?B?VjNDMENpRld6M2pZT3k5bzRYL3doS0xXSW9XMFEyb1NkZ0pwdFQ2WFgyUmFB?=
 =?utf-8?B?eHR4VnBuYzZGaVYreCtlSTBYcW4wMjU5a1dXRDJ2TDNqR05aOGxWWFVCdDY1?=
 =?utf-8?B?M1BURHN6OUJpMEltc2drS2Q3ZTJxb1NWQ2xHcitDTDJLZmRzTmZaODQ3TGdS?=
 =?utf-8?B?b2c0K1dtaVJUNzV2SWYxMTV2ZWtpeTd5WmtHSXVZNmluVWEvSEc1bm9uSDF2?=
 =?utf-8?B?cmZTcmgwNnhSWm5hVG9XY2FSVVliR1ZJc3VIRnkvbURLQnFpRUM1MWNCU0ZS?=
 =?utf-8?B?QUlObmlQTGVVQ0hJVHlSVmNSZXdVVVdnYlNzc2pNTjNQRlZ5Ykl5ZVlTVElC?=
 =?utf-8?Q?IwNrrFrktlT03kOXHf8wZvRXm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ee6fce-9702-4d65-7902-08dccb379e2c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:11:31.9404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6niOdzM79ETAqALBbVxdsYjtgPXi4NaRBnkMQSteW3/1q56YA2gfcD8j2Cgfi8D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
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

On 9/2/24 11:53, Venkatesh Yadav Abbarapu wrote:
> There is an issue with the xilinx zynq qemu qspi driver during the erase
> operation in dual parallel configuration, so skip these
> tests for now.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py | 2 ++
>   py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py       | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py b/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
> index 267285f..42685ad 100644
> --- a/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
> +++ b/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
> @@ -1 +1,3 @@
>   env__spl_skipped = True
> +env__saveenv_test_skip = True
> +env__reset_test_skip = True
> diff --git a/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py b/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
> index 267285f..42685ad 100644
> --- a/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
> +++ b/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
> @@ -1 +1,3 @@
>   env__spl_skipped = True
> +env__saveenv_test_skip = True
> +env__reset_test_skip = True


CI found bug in Qemu which is reported here.
https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/jobs/878781

as

----------------------------- Captured stdout call -----------------------------
Saving Environment to SPIFlash... Erasing SPI flash...qemu-system-arm: 
../util/fifo8.c:62: fifo8_pop: Assertion `fifo->num > 0' failed.

It is bug in Qemu and we have already asked our Qemu team to fix this but hard 
to say when fix reach upstream and then there is CI pipeline update too.
That's why the most sensible thing to do is disable these tests to be able to 
pass CI for dual stacked/parallel configurations.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
