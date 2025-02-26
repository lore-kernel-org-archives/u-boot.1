Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F50C021BC
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 09:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE2180805;
	Wed, 26 Feb 2025 10:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kclQek7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07DCA80F56; Wed, 26 Feb 2025 10:54:52 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E17608004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 10:54:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlQsKuSqV4D7qZfX2Tb21NmLPWhSz9a95ZOjCjeC8RDc+nawvojaQ12GCEfcnYMXM53wGE+ttF7QGhEt/SYdgF0rWd1R7fnmyqFuB2q7xShv8IizmWlymYO98qa5zz5LZsH8fYiOqajaYY8Eu36PZs6H1pK9A2ODNVkntV/2uysb/SnHaC0I+W2HWg6C2s5INS6sIe+8GFL+7h+sfeqw7Lov0NfsF5aW11lh/I3Uz/vMcBC/ghPgbcCMUOdVKClmtepZ+R7mYoVidOSL16UBCHv922TBcv9CzrwFxVrkGnfM8j38yW4+9iuKFLI6ynaIW+o1WNCx6qj4YLiM/EQfQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+7z9wodofrrsgY6Bp2iQ7VVEqzzc7dgLnidDDzcBXk=;
 b=CgzZcKHvs2fqynBdXfKB4nP0gPr3pD+HpNGkTsLX8mu2NRjV2+aRRvc/ZbgXYQ5rov+PmI94gPHPpevh262LMACqVImRFbEvEsNK8sarVkLyZnZm0NtSs1xuEQUyhuCJHhXP4UQR1W5oWAx7j+vKczY5Nc1jZji0U9Yj7ug3GMEoX3na1bs5BEUQW9MgO9sFqMxGuQIBPQn8Eg4Lo5s5Y4KNslXxEeT8PXPdSoA+9EAEDeNz5eA5inZWxp+3VtNY9t/vDsx5ZxIcFWsNgB1xXB0KnsQY7SLynSKyaj8Cbq/0JqdYgrIAFcb1xgfC1UXq8+xYK7HX3gj/7krR/4L0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+7z9wodofrrsgY6Bp2iQ7VVEqzzc7dgLnidDDzcBXk=;
 b=kclQek7xg3N2XknpYY9yztXICDRCMG3Vq6vtbt/CqU/bcQC5t8UXS5NUE38nRItLn+SWZrF7XDHNjVYhjs+uQykS1Q43Bv5+fXM7rdy5jx3xUCwiOkUTiBQCmoDoH1AybOO11xQlohCljphZEVd6GSKZu0IV7uqRW1UkXuiOeKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 09:54:47 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:54:47 +0000
Message-ID: <c61d2b52-141f-4936-99b8-6f9c25679581@amd.com>
Date: Wed, 26 Feb 2025 10:54:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Show major and minor silicon version
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <20095339334fe07f373ffae3bdbfec51f5a00dc7.1739882585.git.michal.simek@amd.com>
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
In-Reply-To: <20095339334fe07f373ffae3bdbfec51f5a00dc7.1739882585.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 319eac3d-181f-4e84-f5a1-08dd564b9a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVJwTkZYQzNWUWV3Z0w1a1BwTGpZWVJDb0tPRGpVT1NtaVFQL3YwcWNxdHc3?=
 =?utf-8?B?YjkvYlppQ1d4UU5meXFCblc0MU9WRDd3Qk5vUnNBRHFnUUcyb2l1U2NzZjlZ?=
 =?utf-8?B?YzBIQnhoNzhCeWJWaEpGY25LVVFmUnRsWHc2a1g0T0xGWU5MMFhmS1Q1ZUMw?=
 =?utf-8?B?aXIvZW5HZkMxelhqbzlPbDZnRk4wQXFnV2F5eDRqL3E1WElubFU3YWphMGFS?=
 =?utf-8?B?dm84bGdzR2plV1R4VkpnY1FZSjZkdWVmU1I0U0Fpb01rL3kxaXlOQ0swTUJv?=
 =?utf-8?B?Zm5ZUDQxek94d2xQVDZmQVhnVUI4V09VS0pDS2hoWlBaWGt6am5yUTdFc1R3?=
 =?utf-8?B?MVM4QklCcnUya004eXk3MGdVUWNjUEVqL0NxbTljeldkbG9kT0xnbVBkVWZG?=
 =?utf-8?B?TTE0aUdOVUh1Mm82a1V5S2tFNTJySjIrZ0d5NVB3V1NpTUlUdFBNT2NzV0hu?=
 =?utf-8?B?cDZaT1ZMNnlZVlMxWlhHaXMxdTJLUERpRzZ2TGFBU2hRelF2RzJ0VFZPYU5J?=
 =?utf-8?B?NytsUlV6RjVvUmYwSHE4NnlleWFSckdyQWd4R1NHUUdHSXNoUUZCb2lsYitV?=
 =?utf-8?B?RGRwUWdBenZvYmRXcmhRS1A5MHdZSWV0elY3ZnpScnNhOElZMkdIQ05Uc2VY?=
 =?utf-8?B?Q05GUWo0b1EzemZQUFluYXBHbWxqY1hxK2FidGt6L3pzd0VKU21iUG1lcmZq?=
 =?utf-8?B?MW12Skh5QnRiYjg3NDdGTExDSkQ0NWJUMGRkN3RZRE9RZEJIZ3hacWlTTjZI?=
 =?utf-8?B?a2ZqQ2k1djFVVHhoaFVtVWxtZ2NlTTI1WVh3aTAxT21Nc3JpSzFDSkFMTVlJ?=
 =?utf-8?B?QnRpalVGWElWZ1FxQXU1YUhWcC8vRjBuL1h3dkRjNnRyZUU1TWQvQ1NjUEdS?=
 =?utf-8?B?dEhySUhBRWVtSkg0c3QwYTlLL1lia3pLSnBKZDU4LzhvK3E0dWJRZ2lSVnZL?=
 =?utf-8?B?MGlydDRUNFZEU1MxbWFaallod3JhdlA3R2lBSnZXVkZvS3FNVXBqNE9Kc09T?=
 =?utf-8?B?RFZYWm1HMzBiYnZQbGFpWXFrTHJpaTVBVCtyUWs1TDFUcE1GcWN1OWlXTlJx?=
 =?utf-8?B?MU5NeS80b0VWUGx6RlJxNXR6YS9xRU5ybC9pMlcxaHNQS1ZPWjZoYU1xZnRI?=
 =?utf-8?B?TjhXNVhCV3diVGY0by9DaW9tbDk3MTcxQXNldzJaQ1Rodzg3aXU4NDEwdWVE?=
 =?utf-8?B?ZWdaOGNCVHlqM2t6SzRuZC9HMVNsbGpXN3FUM0RHZEF1djQ4dnZvM0R6SEFm?=
 =?utf-8?B?Tk11UFZDdFJOS0dxcEF4cTZWa1dFNFZuWDZnSGpaN01ZQkxjL0dTMkRLTmMz?=
 =?utf-8?B?YVFFMXhURitMcEdNbFcwbkFDekxDaDZWOHZNKzk5SVB0dGtSR2g5U0FZZ0tk?=
 =?utf-8?B?ZjVwYytIYm9ia1lDV0VyblF3UUxySXZBVWIvZW9EeFRjTURTcXdwWEsxTDVD?=
 =?utf-8?B?ODR5ZWloVHFVcFFheTU4UkJkWklkQ0RlL1pPdSt2ZlBvcTBncjhBR1pqV3pD?=
 =?utf-8?B?QjlKQ0dLb3pEQXhzQUZGZEd4NzNmcTBkNHI2aFYyTWhOQzFXSmQvWGkxdzZa?=
 =?utf-8?B?Q3RnTGNWUU96RHlnZnNpMS9uV01GbGpKaUVJZVVUdmVRSnBjbjh1VTE2Vzdx?=
 =?utf-8?B?cS9QUG5xeWNBZEw4MDk5bFRGeEZqZWhIa0Uyc0hLTkNYZlJrdDNURi9UOCsz?=
 =?utf-8?B?bERhWVF5VXBzaFhBWWs5WFN5NFRGZE5nTzdpcDBoSThVM3V5alg5M3NnSWpJ?=
 =?utf-8?B?Y3A4Wjcra3pYSjZwdDJrVGc2eEkxa0VJSGJPTTY3aXdscE9LOVdwOGRJK2ZL?=
 =?utf-8?B?eHdBMmRmV3FJMkhmUExEc1pkc2tWeTNQN0JCMGJPT08zUEMrNXpDK3NlY0l0?=
 =?utf-8?Q?D/5l6sXGXDiPP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmNhTHcxQmhJWmVtajExeDVWSTdwSWlRT2hINW03T1F6dUhZR2R1VXhhUm91?=
 =?utf-8?B?RFhrbFZ2aUl2eVpodzVJZEtxLzBDMEs3MjRKTStHVXNlU1c3M1ZFbmcvMDNM?=
 =?utf-8?B?S0JpRkdqL0YrQ0RocXVuQlBsWUVsMzIzRHZzeG9GTUM0L1VlNCtFcVZ5YlVm?=
 =?utf-8?B?VzNNSUs4RHpMS3hQOVJmbDJXSk1xY04zSVpleFk5TzJSUnQ2b2c3UEdDclhI?=
 =?utf-8?B?QXB6OWlZOGc1OCtkSHYrcFRFcEt3bmFTZEd1NW9HczhaK3l4M3g0MG5GK21G?=
 =?utf-8?B?RkJNQ1h0VWJxMEowbUJjMWVpUmhMTlF1TzRnekNTNDVWeHkxUXNZNFNXVmd2?=
 =?utf-8?B?NHl5YWJwdUwxR1FUWWs4MGFGbk1lT2EwRVQrL2NrWkJlOVFGa0pVUmJuWU9k?=
 =?utf-8?B?SmtjK1RMbkl3SStyTTNGN0VFZ09jTHQ5eG1vUkllTWVVckNsdEtuaTJwcU1B?=
 =?utf-8?B?Sk16RVRobStmWnQxZU1VWUNhMmpRWm8vQTA3dllhazZ0TkorSTMxZSs2cXF5?=
 =?utf-8?B?ZEE0cE03Nm1ubEwxUVBzcjJOK21kdis2cHhaZ25uOFZrQzFlUlhadnFSUThu?=
 =?utf-8?B?YWc0aGNpcFJFc0pFbXFEaXk1UHYwRzU3bWRJZFJFcFVycXZPeXU0US9KM291?=
 =?utf-8?B?bG1UNGgya3EzRjlWZnduQWtJR1ZoVXlqbWJRZG5udDE5aXZuLytWZkJuSFNO?=
 =?utf-8?B?N1JoOTZNa3QzRUhlbVF6REdYRGhiNXdtSE9CWE82WFRUZGNqOWxlQlkyLzdQ?=
 =?utf-8?B?ZURKN1JHL1Y1TnhFRjhOQjViZi85eWZqQUlZTWpMN3lHbzliRm9UeTRQb1V3?=
 =?utf-8?B?bXJJRC8yUFJsTWMzeHVrUUdUdmZEc2REdEZYc0tvNTAwZG9keE0yNWc2b1lu?=
 =?utf-8?B?QXZvejNHcysxOFZHVTlUV3NFUDJQMXVWSFJ5eVZjU0dVS21SNlNaRzM0dnVh?=
 =?utf-8?B?VGhwd1djUzZ2WDVOL1RGNms4dm9SVzNncjVDSVdLN0o5QVlkZzhrRE5sblZt?=
 =?utf-8?B?Wm00a3dTMHlNZGhtZUJOazU1T1IyR00xVE9sRFFVMG04TXRrRW0wcmRpQ05W?=
 =?utf-8?B?bll2NFVCTUZCSTMra1daQm5WeXhWblhTT3dWRkJ1OGwyQ1lrZDJ1VXZnNFB0?=
 =?utf-8?B?QUpHL0VJQzlQaHBnczh1Y1VRQ0J2VS9HQWROU1pFTlQ2c0RzdXlLdmsrbVp2?=
 =?utf-8?B?N3dNcFRVc2lPQVAvMGdyRzdmdjBXaFk4a2RVMXB4YjNWL1c0RTJZUUlNSkZy?=
 =?utf-8?B?NHZyeUh3UGN6Wng3emFpZE55eGtrVzkzb1k3cXRDOWpFYmo4UFpnSnJJRGM5?=
 =?utf-8?B?RTdjQmc3cng3MERWaEY0MGY1L0NQMWk5d25yUG5qai8rSkRvcXJUZHJwMjRF?=
 =?utf-8?B?N3M0clM0TUZVNkxETGlnSU54Uk4vMzZ5M0Q3SmdacUNUSDhocWV3eTYzbEN1?=
 =?utf-8?B?OENYU3JYRDQ1THIzUjZsdHlFaXM1V0VraTVZd1UzVGVlK2RmOTBwVGxRYm4v?=
 =?utf-8?B?RjIrUVBVblZ5UVJqS3ErMzFHeUNkSTJyd2llSE53Q0tta3ZHL0FVbDJDc2Rt?=
 =?utf-8?B?a29JMTVveUNGS05NK0Z0MDlnYjJzWUptbkdOdnpkaTFXY3grbmM4MDk4TUth?=
 =?utf-8?B?VXV3SVZhbHVYTzUxc0pJdllpS2Z6UnlMdGFSN2cvTlJiNWVhVUZOek0xaFZL?=
 =?utf-8?B?OWZpSnVUSFNnd1FGbjJVOXdaVkhVWTEvTk8wa0MvUWRtRHNxSWNXMTV0ZTVY?=
 =?utf-8?B?M3RTaXB5TVVGZy9FME1ZUjhUMTBWUHU2citCM0FtOUpNbU9MSDI1NE1EamRs?=
 =?utf-8?B?dEtkUzN3Q0pXem9ZSWpKT1MyMkNNRnpvNFJjcHJLSEgzMEVYODNWc1dZUVlT?=
 =?utf-8?B?VFdWVkx1N0psY0pGNHhWck1Kcmd0dlJsMm84NmxRWGZaekdoWkR1dkpROEpQ?=
 =?utf-8?B?Mngyazc3ZEtnTHVqdGFGR1JlREdGTHAzVEpra0RiNEY4cjAxVjlCSXBOUUt6?=
 =?utf-8?B?WmRCdVpURHM1SnNZODFQY2RnMm9kbkRwbmlIbEEvcEJDWVdmbFllUmd1Nzh2?=
 =?utf-8?B?Q2c3VjdrR0grYzF1dU9sR01xQ1NoWTcwSmtjOGsvRUZQVnlwV3lTK2s5V3JX?=
 =?utf-8?Q?+ppoPslaM5cemhiGMGvABHa3X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 319eac3d-181f-4e84-f5a1-08dd564b9a6e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:54:47.2168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crFRcOZ6sGe2rhUq+n5VQ5/vk6PC5X8Jb47/9ldIe+lJYAc4qyHRFMidVlxgGsxS
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



On 2/18/25 13:43, Michal Simek wrote:
> ES1 silicon is 0x10 (16) and production is 0x20 (32) but correct number to
> see are v1.0 or v2.0 instead of v16 or v32.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-versal2/include/mach/hardware.h | 3 ++-
>   drivers/soc/soc_amd_versal2.c                 | 4 +++-
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
> index 42e3061a0aea..15085f941e02 100644
> --- a/arch/arm/mach-versal2/include/mach/hardware.h
> +++ b/arch/arm/mach-versal2/include/mach/hardware.h
> @@ -51,7 +51,8 @@ struct crp_regs {
>   #define PMC_TAP_VERSION		(PMC_TAP + 0x4)
>   # define PMC_VERSION_MASK	GENMASK(7, 0)
>   # define PS_VERSION_MASK	GENMASK(15, 8)
> -# define PS_VERSION_PRODUCTION	0x20
> +# define PS_VERSION_MAJOR	GENMASK(7, 4)
> +# define PS_VERSION_MINOR	GENMASK(3, 0)
>   # define RTL_VERSION_MASK	GENMASK(23, 16)
>   # define PLATFORM_MASK		GENMASK(27, 24)
>   # define PLATFORM_VERSION_MASK	GENMASK(31, 28)
> diff --git a/drivers/soc/soc_amd_versal2.c b/drivers/soc/soc_amd_versal2.c
> index 66bcb22b4fa9..8507da0bd228 100644
> --- a/drivers/soc/soc_amd_versal2.c
> +++ b/drivers/soc/soc_amd_versal2.c
> @@ -35,7 +35,9 @@ static int soc_amd_versal2_get_revision(struct udevice *dev, char *buf, int size
>   {
>   	struct soc_amd_versal2_priv *priv = dev_get_priv(dev);
>   
> -	return snprintf(buf, size, "v%d", priv->revision);
> +	return snprintf(buf, size, "v%d.%d",
> +			(u32)FIELD_GET(PS_VERSION_MAJOR, priv->revision),
> +			(u32)FIELD_GET(PS_VERSION_MINOR, priv->revision));
>   }
>   
>   static const struct soc_ops soc_amd_versal2_ops = {

Applied.
M
