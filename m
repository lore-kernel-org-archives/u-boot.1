Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897E4C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D8E78820F;
	Fri, 22 Mar 2024 12:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n7HgIcpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBDD8820D; Fri, 22 Mar 2024 12:58:33 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F345A881BC
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:58:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBV2e4rIYGLR2eD0ixhz/zigXkk95k7j4Tq8KMDv8MBgVByTSTZeJkTESqyFxVlRl4JCTm4xEaHSbFGvCGgJR3ZAits2Nh42nBGQO8spTw4dcUlT9ztOl5J7ThogtYIch10i0y+NMBKoNesXye8kqsTwLfurdJ9lask+FDufAF0dauLYsNXmuGgr4J3H7OrS81+Rsk4aYm1oOATkTwfCHSyIFSpjRNv1TM/nxR9CXbu8XyJnBVKjpI41HJ2GiEcTwsJ4JwgeqwoC2+5a0E8+PTr5DNIsYIcAJh5BH8fpt2vaXOWoXZI3R85N0YafCX0LwU9WaaQpuwBTQgVunbjvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxNGhvUn0nnrmTtZVDTQMp/yDIWCS4MTJmXfNnw8L0k=;
 b=Ic/MwR+GyTBabhf+gBIjhkKboqdbpONocRua4PKCHBRbre0F2BhXhFZfd9QqJI9p+PUd1RmCRykEsFr1HfHNuQ4RGNoL/gmWXRs672bX0gizm3O6Zh6uvFxGD21d4pgey5OvUkydyqKMsKy51rdMD/Qdga9UyKyWgEdUBq836c45S1XuuKgZMj7lH64BwdeP2ZAEPG5eTzseZr+fD2K7MyypLfeZaPy13JLQddV5Qchnyal8zFZ0uDdpQe/Qa89x0oBh5+DjaHDIPQCSctm7TooIPJS3O7zEgL3VwXssbz02xkIsPrCuGvIdBHZ7rkQd3fnBPq+GJNxiWB5rQYQ/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxNGhvUn0nnrmTtZVDTQMp/yDIWCS4MTJmXfNnw8L0k=;
 b=n7HgIcpCcrHTCwl7RVIHi3hVFzSnojmVXG2iUe8Kn/7CvtoZrNdS2ZIKfl8u5tVFCKUp04XSSDbttpLFuOHfWKve3vPPV3bkS+dKIRzTR0sN6b/LX8r5sGQSfF/vVVxO7Zq+7HKpDVTelXhavIWbSrnN83rVAsuqOfqYRTgxaqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 11:58:28 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::40b9:ca6b:89d7:f45f%7]) with mapi id 15.20.7386.030; Fri, 22 Mar 2024
 11:58:28 +0000
Message-ID: <bec13c53-2919-4bd6-b5ba-b1d7f0683ebf@amd.com>
Date: Fri, 22 Mar 2024 12:58:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Add MTD partition handling for
 dfu_alt_info generation
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com, ilias.apalodimas@linaro.org
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <c0d35e3b51064a31d2f1b6a0233976624826f1d2.1708705093.git.michal.simek@amd.com>
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
In-Reply-To: <c0d35e3b51064a31d2f1b6a0233976624826f1d2.1708705093.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0075.eurprd02.prod.outlook.com
 (2603:10a6:802:14::46) To PH7PR12MB8108.namprd12.prod.outlook.com
 (2603:10b6:510:2bc::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5802ad-627a-4759-e968-08dc4a6762cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrTTwVd6wLcyqzspbOmPR+ryjMz8WTr3GXhMGc6WJ8JyREK3ETWGBAOWTQD3Ww0AVwhs83Tp7Bqw/KNs4MqH8AxU/bOH1KiQ1JwDDXXVUOuVcRdn2bQ0zAfyaT/m6rwDhUgaCJpPRilmKjyuaC4VaUCCorTy0Ta0kLocfoTMrEIWiPY1Y04RhUDhcgx6TTfZAIRRZLkxMJ76hfd5cVbszCv7J0XqwUGQ8coykk0oTd8u5r/N5BBRfLPiXugJkXuSgIkUPRdZ+0t5qgLut8erAM6bLiew2OYxMZtb4FG7XLWwX7IoGjXIhBI9JAq/MI7mGcDCXRddpqdQf0XkUOpGyp3AfBNdt8erNgH4F827PAlWSzoTbJJ4hz1lV90sn5VSAZyf3UouCXzITO9J5Ol/a9a8060cApTG7JgqI3YYYiXrisAzB/Pdt2FDUWq7CAkNB4mAIok+tw6zBzbwe3pkFU39UyL570oSRGfgfdAw73FBtNnq47Ix6syuG+xIvATYesnsmWKghPScxMnNTc7Yb07O5tV80lP5P5r5bCmP8ha5iaLJnfj/engx/fCpOu7vP03k+IjQVs+AYbzhonGoATwFpCyixMAeOk274oNN/J0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVRoSDdITnNOZVZsSXJTY3JMdWoxaytxUG1vSkFrK012YWl3KzBWQUp0Rm5r?=
 =?utf-8?B?Ymk3UUVzK1RwRG1udUl1b2I0WkRaakxvMVd1dlRqdFVidE1VS3Jpd2dnU2s5?=
 =?utf-8?B?Nk1LTzFkMnJHaEFOaEszWld3K3BERUtheUdXekVTOGtyZHRYRHpQWWRJSmt1?=
 =?utf-8?B?bXR3blVZcTgrb3FpTEpoZ2tZUzRiNkl6YkhFM0VFUE5VR1FBWnNlY2pMemFu?=
 =?utf-8?B?ejZxenBMdEp0dmQrd1F1eUZyQUZpSHJKV1dFbWhLY2huSE1Wb0krWmtvS1Zt?=
 =?utf-8?B?ei9yaCtoL3RpT1dKM05oS244eFlEcGNjM2V5MTk5cUVtaVE3QVJOUFk5a3dP?=
 =?utf-8?B?Q3hXZkFnU2dUTE9XZXUveCt6VlhRaWF4Y0VERzkxOW85aHV4Uk5TZ0ZJcXMy?=
 =?utf-8?B?cllkaVdpbStDNTNIU1h5Z0FvNVlVUFZYR2Z0cVdoQlNTNlJNZFVCaUJXd09M?=
 =?utf-8?B?MWJqdlJzOEd1aTYxVUlxcXNjTFZYdVpic05sVlk2UVUxcW5rbWpPa1BYRy9Z?=
 =?utf-8?B?VVEraFJSbEJjRlB1K2ZRMnkwMkRzT0hXVmFwS2dhVU1iU21laWRpeXdnSlA0?=
 =?utf-8?B?VjNWTG8zQW1vVjBNRWZvdTJiOVVLOTl6SW5HWStuMmNIa2s1MTM0NzRTTzQx?=
 =?utf-8?B?b0QrRklJNE1QMHpvRDN5V2l2ZGxleitSS21veTBtNlFHcm9uUndtMjkrdXI1?=
 =?utf-8?B?S2N4RE9vdlUrbjVYUjVpR04yTklaWG9qTXFsYmUyMDNrRXZ2a1NBTlBtbE93?=
 =?utf-8?B?NlVkeis1RzkrSlRvZmtjOFpiNzd1ODdJa0pZWnpiSkoxMDJMUC9EdjNsM3U0?=
 =?utf-8?B?ckpUeHBoSmFDNTl1UG1rM2xoTGtheHNUbFBtajFsUDRsQVpxdmFPaVRQVHFa?=
 =?utf-8?B?Wkl2dmRjNWZycmhIVTBEOG9ROCtrcGMrbWNFa3I0YmFNRlVKSEYxc0lNaHJp?=
 =?utf-8?B?VXMvV200bjlxWXJEejg1WUdvQzljQ0gyU0o2aWtvdlU5SWRqMWtucUdOMm11?=
 =?utf-8?B?Nk56cUZQM0VIZlZmVG9jL2NOL05LVUkzWUd2MkJoNFYvOVhaNFFIUGdpSlEw?=
 =?utf-8?B?Qkd0d2NQNHNkWCtYNldNTzVtVU1LaWxZNkZqVjI4L2VsTmFGNERXaGVFaVYv?=
 =?utf-8?B?WEo1QjZYK2xKMHlLaUxqMldKYktCeWVQWmxKaCtKR09OcHNYd0tsZEhrZTds?=
 =?utf-8?B?N3A3NXFQa21KVzlGb0d1UXRDekQwOGRmSFNhNWI4SzNJM2JObGw0aUM0ZmND?=
 =?utf-8?B?ekgwQTRhbHU5dm8wRVdqSFl6amt1aGFuMWZJSUFib2VNOXgyUUhIR2JsMFF2?=
 =?utf-8?B?bHRWSzUxRHFJc0JLOFN0azMxeWUxK2pFdy9qZlRSSGYvK3FzOHoyQlRSamNv?=
 =?utf-8?B?RU4wNEk4Y2pITDJzeUdRaFVNa3RtdHJYbXpVZUlDb0Vqdlc0TjdkLy9GZ2V4?=
 =?utf-8?B?b0Q3eE5YdXFrNnh5QVQwWEJGbWlyWTRHU2FSamdDWTFJV2F3VEpoSDk2NVF2?=
 =?utf-8?B?OVJKNGU2SytoQTVWcmxnR3dYVU5xclR0L2MrN2JscjkrdWRjQzBoVEVtYVgr?=
 =?utf-8?B?Nkk5SWN4ZXYyUmFLTlFINXpIOHVKZlpkcEFWZEF1VGQ3SWdyakZTQWZSYVVi?=
 =?utf-8?B?Q0RLMXJFNG52V0pJRHduczhSMUJzWGVKWE02SDkxTjdzdmZZQUU3UlVpR3d5?=
 =?utf-8?B?UVlFdDZuNHhXZFpmWGhINTJ3OXBtZVd4dEMreURFNmNud0ZUUTVla2luRFJD?=
 =?utf-8?B?bmU3UDIzTDJPRFdmOTlaSWNuelpEUFJoQm1yTmt6RFUwZnoyWi96aURlTzNH?=
 =?utf-8?B?WDNzZ3QxaXR5TGp3VXkvK0xaRDVjK1ZtL0FSYzEvNjlHMjc0NFMxQUwzejFx?=
 =?utf-8?B?elhHZWlwMlFpc1pXZUhFeWI0TkVhajF4U0hrYW1ibGZVYVVhQ1psZjl5R1Jv?=
 =?utf-8?B?NzZkQ1NSdEpCeUJtNTJ2M1hhVFpiY3U5anBtMEd3bmJLTm9vd1ZVOE9xTFlZ?=
 =?utf-8?B?eXlRU25RWFpja1Z6QS9yQTM0ZExadGhWYWhzd29MUHBwdHYxWFFEK1M3Tllu?=
 =?utf-8?B?cUwxQXBxUTVVMlNmb2JYTVZ3alB0QW55MzhhN1ZRb3p3NHNQeTFENlRBNCsv?=
 =?utf-8?Q?wsxav0WNTQpWQqlPpeG0IiK3O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5802ad-627a-4759-e968-08dc4a6762cb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:58:28.3329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iDgZCjitliJiiM0QgJs7MpNwNbwM2Tqd7SMJ/70RolPLOHkbw57HZmTSkk/r/Dy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
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



On 2/23/24 17:18, Michal Simek wrote:
> Generate dfu_alt_info generation based on information from MTD partitions.
> mtd_found_part() is trying to identify MTD partition which code is running
> from. If partitions are not defined and location is not found it is going
> to previous behavior.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp.c | 52 +++++++++++++++++++++++++++++++-----
>   1 file changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index ba49eb7be229..eee89284de9d 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -626,6 +626,31 @@ enum env_location env_get_location(enum env_operation op, int prio)
>   
>   #define DFU_ALT_BUF_LEN		SZ_1K
>   
> +static void mtd_found_part(u32 *base, u32 *size)
> +{
> +	struct mtd_info *part, *mtd;
> +
> +	mtd_probe_devices();
> +
> +	mtd = get_mtd_device_nm("nor0");
> +	if (!IS_ERR_OR_NULL(mtd)) {
> +		list_for_each_entry(part, &mtd->partitions, node) {
> +			debug("0x%012llx-0x%012llx : \"%s\"\n",
> +			      part->offset, part->offset + part->size,
> +			      part->name);
> +
> +			if (*base >= part->offset &&
> +			    *base < part->offset + part->size) {
> +				debug("Found my partition: %d/%s\n",
> +				      part->index, part->name);
> +				*base = part->offset;
> +				*size = part->size;
> +				break;
> +			}
> +		}
> +	}
> +}
> +
>   void set_dfu_alt_info(char *interface, char *devstr)
>   {
>   	int multiboot, bootseq = 0, len = 0;
> @@ -667,15 +692,28 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   		break;
>   	case QSPI_MODE_24BIT:
>   	case QSPI_MODE_32BIT:
> -		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> -			       "sf 0:0=boot.bin raw %x 0x1500000",
> -			       multiboot * SZ_32K);
> +		{
> +			u32 base = multiboot * SZ_32K;
> +			u32 size = 0x1500000;
> +			u32 limit = size;
> +
> +			mtd_found_part(&base, &limit);
> +
> +#if defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
> +			size = limit;
> +			limit = CONFIG_SYS_SPI_U_BOOT_OFFS;
> +#endif
> +
> +			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> +					"sf 0:0=boot.bin raw 0x%x 0x%x",
> +					base, limit);
>   #if defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME) && defined(CONFIG_SYS_SPI_U_BOOT_OFFS)
> -		len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> -			       ";%s raw 0x%x 0x500000",
> -			       CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
> -			       multiboot * SZ_32K + CONFIG_SYS_SPI_U_BOOT_OFFS);
> +			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
> +					";%s raw 0x%x 0x%x",
> +					CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
> +					base + limit, size - limit);
>   #endif
> +		}
>   		break;
>   	default:
>   		return;

Based on discussion here
https://lore.kernel.org/all/561f9d0ee96ebb6cd674042f269f280ab68fbbac.1708705118.git.michal.simek@amd.com/

I will send updated version of this patch.

M
