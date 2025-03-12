Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7AEC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:38:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 511D7805D7;
	Wed, 12 Mar 2025 09:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MNyp52g2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7340C807D9; Wed, 12 Mar 2025 09:38:04 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 912A3801FB
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avRPqkTpO0XkSWZ7c/MwhDo25t0P0xbniylWtuhdk+LfPq50Vj9Yw0t/I1+tfNQG6xTYQtNtth8tlkqkxC9eS+Ujqoisr6g+SnOlKaB3NFKJYJfYSONuGAfKHiuCc4RzXiLXua/0+iRoI2EMEH1N27nADTiXYof4XK8SWtSA9RDWoF2aGKbH6V2AMHyp1A/qD+Znd5OFGwTCQWSlwfIPEuJOlgeyRNQiJqFuIOj6j7cPFdjdSrcIr/TNhc86VUrx2iWvaUlT31/dVlA8iYAWSQ0mck1kL9w2A83bgHay0DwvCEl4nn1nJuScDhDr4DCGyjcOcgH1ET9k4bJFvr6uvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQIijBJb0lPlmeH0b+IG9WB3IJ825LqpTP4devgJDAI=;
 b=EOlWxTXAQ3DdQN1XP2qd12Rtmeb8Z6s4lMFL7Ibg1rCYp6tw3pGHU3Od6FLiHSX6qiECKdbUU7QO/D5fWy1FaN3oPoiVTleW9JLUYCJG/0Ouv7MqRO3/6alU1rw9FZSSuGHh4jrN3AaYV0jRQm34GWdINdDiQb1BFMEXUqp/2KOfNoUSQETBCS9KKXQl/HiFHMbmw0v0bACyw2eLc8ec8XRxIQBRkLCEYyLIdHjVHuFePA5TI2I51pULRFop5C6GhnBMyB4+L6tHLwgYTIIVWCHj78XTIb0KDNzZDXlo2DBEfooxm3gJbTgdvYePe5PqHjDc2OPhgZS7G9SCvYam6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQIijBJb0lPlmeH0b+IG9WB3IJ825LqpTP4devgJDAI=;
 b=MNyp52g2BwosV25tXsO6TGzmcPuR6um254IIn+2dgyRb76k+gsKfS1wVzqfkcjFCRwgP7s2Yd694ZFStR2Rebt+Mpon+uVFRe6j3RFJi40Cx97VsFHNcLs/fFgaTx55430okgXU0WmuDtcNQmJEF9FDGRIBdkB4Dq7PUwaQtatM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:37:58 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:37:58 +0000
Message-ID: <0ba5c795-8775-4bbd-998f-692095496a16@amd.com>
Date: Wed, 12 Mar 2025 09:37:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xilinx: Allow alternative boot strategies in
 zynq-common.h
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.39d305af-e006-447e-a675-c4e243ffeb48@emailsignatures365.codetwo.com>
 <20250311070124.20696-1-mike.looijmans@topic.nl>
 <84b5bf66-fb4f-4590-b6ab-fa1ee3011aa4@amd.com>
 <5f2f81f4-7248-40ea-969c-9f37686ba8a4@topic.nl>
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
In-Reply-To: <5f2f81f4-7248-40ea-969c-9f37686ba8a4@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH5P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::11) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d2c42d-2cea-4978-8b88-08dd61413138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmJicFQ2RlRhUnFWaGJURU1SVHcwKzJCNVQ3Y0VRbHc1TXFaU0dmVnk3R3lW?=
 =?utf-8?B?cE1Wa00zNkpVRGF6RExGa09QRnBYb2dHQU9QaUJsWjgxMEVHU0VISWRVMnE4?=
 =?utf-8?B?bVFHTEEyMGtVMUUyQ25ySVBEWVJVVWt2VXgvY0puS3JVb2F4NEEzMm1QMWRv?=
 =?utf-8?B?M3k3c05QMGFhbEY1SnVTdVJpdEFzWFdJUjFsRHl1T1IwK2trVWlnTGhiazVV?=
 =?utf-8?B?c1hjT25SSUlDSjBiRnRsZXZUaWFUQ0dyUVVmSllqQUxKRG9wbFc3Yk1Qdkxy?=
 =?utf-8?B?bERFUmFFdUxCZFdLckFvcndDV1FIelBpbUU1bkVUcVEvbE1pMlg3L3VOcU55?=
 =?utf-8?B?K1VPbXRUMHFINmhUQ21NZGkvUDRyK09jeURUbGFVNEpVVWVnYmxsS2QwT1Rh?=
 =?utf-8?B?cEhsR1UyUjd6K21zV0JPSmM4U29rRDJpaUdqTzhxdkptSEJDSmJSTjc4RDdx?=
 =?utf-8?B?MlE1blRNSHRwK3Y0aGVQTi8xdS9JbEplVUU1ckkydjlrZTJWQlRvOXdFekU5?=
 =?utf-8?B?cWI2ejhHVlRFMGdOV3lNUldndndCTWNLTkVINFBVMDB0MDFZWVJIQ1Faa1R1?=
 =?utf-8?B?TE1tWjFtb3A0Qm4xZWpZdURVbDBUazFrMThQSUNkNmppQ0JoK1BlTmZTZVNG?=
 =?utf-8?B?ZENDZnlXTDNrSlNRd0E5TGpJSE1HT0pFdklKaDZ0Y2o5L1ZhdEwrY3dwRnY0?=
 =?utf-8?B?NzdBeHZLaEFuQUdRVDZ0N0tNMFNpMG5mOTRVWG5HZW1vanB1aXNzNzhmNFkz?=
 =?utf-8?B?UW50eDZTb3BxdzJjVjNRcUptME1rY2dtUGhkNTUvQjJqbC9lWGwrVTA0WUZu?=
 =?utf-8?B?dW9uN0N2UE16Qm9HOUR6RkcxbTNHRmkzQ0JoaGREWjRNUjY3bEZXcUp2TkNr?=
 =?utf-8?B?THpUTWRKNUZBQUFtQTdyclhIeUgrMk4zYVBVVEpKc010YWY3N1h6ZDBPa01I?=
 =?utf-8?B?R1V5d040bDdTQTRBVlo0VDMvTHRUMmpRMjJyR3dKbTlHYU9jUUNCVHhyZlgz?=
 =?utf-8?B?UkViaStqRm43NndyZUxvS1k0RlZFZ0oydlBCUGpMRkdCTjMzRCtGUXZiR1Rj?=
 =?utf-8?B?enBVZ1ZQdk1mcmwxUm5ZQVhNdU5ETmdZS3lZNWtjS0ZyZlJNQkVSenBJbHgr?=
 =?utf-8?B?Sjd1aHpham1KTjcrcU1JNEtVVnBpN0sxdVpCUmkvNUZvYzRiVW02NUNoUTds?=
 =?utf-8?B?MlJ4dmFZS0RFV1V6cEQ4YlI4akxranV2MU1sNU52cVhQb2l0aEZGeWpHZmk2?=
 =?utf-8?B?VDZZb1RnUTFTdXFENWt1VWRyeEM4WndxR1lWQ3JEdG44U3dPTFJTb25wTUJN?=
 =?utf-8?B?aE9OZ0h4UkoxQmJDcXk3cjlacjBPRXVESDNPTDNNdmw0VkRZTnZ5VzNrWTZ5?=
 =?utf-8?B?UkMwR01rdHBDUUdxZUFtbC9ISCs0NERkNkZFZFAvS1ppRWwwZGFHeVk4Z1VZ?=
 =?utf-8?B?MkdSV2xWK2F2WTgyVXRxazRPclNCNk9GNEFTejBBODdtUldDSWJvR29nZ0xV?=
 =?utf-8?B?N09nZ2NoT01McXorMDM4UnRSdDJQYWYvRjA3U1dLVmw5WEVKUUVhclYyUmhI?=
 =?utf-8?B?eDRkSTJ2aGxsSUxmUTRiUktkbzB5emgvSktKWVNjYnpnSmJIRmVLZDRvaU54?=
 =?utf-8?B?YklHZE1tMk0xbElpLzNjTThkSVQ5dXRhOGdPSzh5dFFDU0JlM2JqbmU4cnU4?=
 =?utf-8?B?aE1NOWlQMGUwNll3UmZ3cVhzRVJIQTcydkZoV2RyVmY3VWtNUW1wZHBMeDd3?=
 =?utf-8?B?TjVVajkyV0l3eUlaWEd6N2JpaDd3ckNicFZFUS9KRzc4OEJBd3ExdVhBQlNZ?=
 =?utf-8?B?UDdXQS9yZlRtZkNhNkZjd2FqTWt6QlVHRzJ5S2lVSUhpYldDd2ZIZTJtc3B6?=
 =?utf-8?Q?iriEC8lQP/+UF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlBRazFDb25VU1pEUUpzVWFBNHFjanNtWHVkcnhQc2d6QnFobDFwb3hLSHN6?=
 =?utf-8?B?djJKSU5vVXJsZGJ3NWYrK3NsaXRsRFNrLy9kZmxkZGhCL1RRbkl5cWd4UWIr?=
 =?utf-8?B?bEd0V1QxdzRlRGJ1YnA4dURsRDVNTG41MTdxM3RudVppTXZFQ2ttb3ozZk5H?=
 =?utf-8?B?M29LeGpRRkJCc3F0RzBvM2k4WEYrRmlkTGdPS0RHR3VDd01hZjFJQU0wVXhY?=
 =?utf-8?B?MkpyYWthcWZ2YU5HWFFWWkp4dkFQaVprZ0V1cFlaOTRJWVZzS1REUFM3WDha?=
 =?utf-8?B?cmxFTzVQUWppWGt0Z05oZDJaMTRaT3UrK2MvbHo5eW1BN2YvcDBBeEZUZ2Y3?=
 =?utf-8?B?c1kxdnRXWHQ3a1MyQ2N0clRRY3N3NmtseEt6NXJIL0tLQXRvRzJMeW0vS3Mx?=
 =?utf-8?B?MHRZT3g5SjcyVHdOVnJpSzlnQUhtSUsyTjUyVGgrdkdCdFdhQkdZRFpFclhL?=
 =?utf-8?B?YkozUWpRZ1NncmdUUHdxK1FrZ2FKSjJRRjUwVVhLbkhnSjZYT1Z6Y3R5N3Bz?=
 =?utf-8?B?MnltVExHU3puOUF1eU8xejB0NWhzUWZtYzRtUWR1N1BHZ0FqWHJaU0JhQTBv?=
 =?utf-8?B?MDhtc2t6SFFvUHNKT2VGZXYzeUFYN3dLQTk1TGY3ZkkvejFSaFl4OFZjZjdD?=
 =?utf-8?B?TkF1T2wxN2tmeUVaV1N5eXBhempscXZDN0Nxb0hzOXJpU2t3VUpWRTVnYndL?=
 =?utf-8?B?NXQrbThkVmQrcGRMUzNuREo4T0NhTlYrMUY0cHRaRjliaGpRWThZb0xwME5P?=
 =?utf-8?B?K01CK1pIL2ZLSkZUTDdmeE1SaCtYbGZHbFJ2S3ZhbFJsN1RUQjE4UDhSNFo2?=
 =?utf-8?B?d0FQeGFwS0lySzI3NGROazNydFpJeTJMNlhKMlNuRkRXRjkySkdZeERienZI?=
 =?utf-8?B?ekFsZXRLbDllc3ZpV3g0WkJKTzlSRmVMOHBUc21ReWZOUWRHL0ZQa1hUU0lo?=
 =?utf-8?B?RXJXRmRnb1A3eEo3K3k0bFQyVUNjdkdLU2Zlb0JISlFVWkdBNXl5U1BVV1o3?=
 =?utf-8?B?UjFQSTIxYkZadVRpWlJsZGJWUW1oaXltZHA1ZndQMUZ3ejNLaU9nRVJBSW43?=
 =?utf-8?B?SkRxSi9zd2RGV2RadkZOeEM4VURORG5NSTV1VkgrWmhBUXUxUzV5Rm9vbmll?=
 =?utf-8?B?YTA5VEJrSUR1VDZKcmI4cGdwTWJQOW5RR0FiTk8ybEVMMmVndGxqazNEMmRl?=
 =?utf-8?B?bEZKMjlpV1RLNkN4RTBxc1BQQlB0dU52Qm80WXhYWWZ6NnpMTlp3amZEM3JM?=
 =?utf-8?B?MmxYTHJ6Yk9pQXVpVkh2NGQwTWc1YXBHRDhVNjdGMno5NXh4cXY3eDlZZlpn?=
 =?utf-8?B?RGJZRkRzamcwRVFqYjlMUUozN2FYQWhMS1dUa1RBdXF0YXJXZHhVTTRHcTlE?=
 =?utf-8?B?ckI1NmkvVHJyby92MmpGUW0yeUlpdEE3N2RSelpyUG5zY1kzeDNMZDFieVg0?=
 =?utf-8?B?WkY5ZzM4MkIzcFhqbkZwQTJBRCtwMEZkcTJPdFltbzkxWlMrQW9TaFRRV2xv?=
 =?utf-8?B?dXpBUnZ0ZkdDLzNobkZzY3FiVHVFRGRwVWhqSTdQeVI2YW8xRTFteU9rQ29Q?=
 =?utf-8?B?NHdGWFdtRGxoNHVGeUpucWw1MmJJT25ycHRlUkF5cnQ4cEVDVHFYNE5nRkF3?=
 =?utf-8?B?bXJWR0VLYmMwekU2Umx0emYyeXpVeXZGbGlSekNvY21kV0U2d2FVMWIvMHhW?=
 =?utf-8?B?NW1oTWhRSkNMN09HcVdUSnFnVFpJWFpWeUFmWjMxNnAzeEI3RkdwZHh1MEpq?=
 =?utf-8?B?TytrMWxPbXIzS1BBRHJJUURPbXNTTTZhS0MzUDJjRkFzVjFhWUVrRGcrMmFB?=
 =?utf-8?B?TVdCYWFTWFdGS21MMW93SUJUWkorV1pMWnBrWElONVJwWDNQYWtORGwzZklH?=
 =?utf-8?B?aTJZdnBWZWplQkZMNXZzdko2dGlYaHBzMWNOZllUQU1wU0lTaGZLNFZPN3do?=
 =?utf-8?B?OVBBTFM5aDFPaW9IOXZuaWRSWk05Nkd6TGJ3cERNbW9ybzNrT3FWV0ovOHhM?=
 =?utf-8?B?eVpFdjcrWUgrTXhtSkE1Y0tsRzdHZU5EYjhlUkxIbG1Hbk1USUtIL0oxc1BC?=
 =?utf-8?B?QlBGZXlYNmxnZWZWS0JCUmNGVkF4R29VM0MxRXlDaUUwd1pYNTZuSzd5bXkx?=
 =?utf-8?Q?AJr6ustlZ1JBXyBDztbgIYtEP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d2c42d-2cea-4978-8b88-08dd61413138
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:37:58.4004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MADzGuvIa+81/DtB3+HVOKJTKV+7QPKUo4/6iDJhyv+wkZGRg9kZ1m6rLpxYTx6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930
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



On 3/11/25 10:32, Mike Looijmans wrote:
> On 11-03-2025 09:03, Michal Simek wrote:
>>
>>
>> On 3/11/25 08:01, Mike Looijmans wrote:
>>> Allow config headers that include zynq-common.h to provide their own
>>> (distro) boot strategies. This is implemented by skipping the section
>>> when BOOT_ENV has already been defined.
>>>
>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>> ---
>>>
>>>   include/configs/zynq-common.h | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
>>> index 37c77aa1611..ad872c9d922 100644
>>> --- a/include/configs/zynq-common.h
>>> +++ b/include/configs/zynq-common.h
>>> @@ -48,6 +48,9 @@
>>>   #define BOOTENV
>>>   #else
>>>   +/* Only use this section if no BOOTENV has been configured yet */
>>> +#ifndef BOOTENV
>>> +
>>>   #ifdef CONFIG_CMD_MMC
>>>   #define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
>>>   #else
>>> @@ -167,6 +170,9 @@
>>>       BOOT_TARGET_DEVICES_DHCP(func)
>>>     #include <config_distro_bootcmd.h>
>>> +
>>> +#endif /* BOOTENV */
>>> +
>>>   #endif /* CONFIG_XPL_BUILD */
>>>     /* Default environment */
>>
>> Why are you sending this again?
> 
> Sorry, forgot to mention. Sending it in a single batch shows why I want this 
> change... The first one got out because I forgot to say "-n" to patman, but it 
> was fine as it is, so I didn't recall it.

pretty much this should be v2 and you should reply to origin one that it should 
be ignored.

And in connection to the patch itself.

I think you should do it a little bit differently not to have complicated if 
else if endif endif structure.

What about just this?

#ifdef CONFIG_XPL_BUILD
#define BOOTENV
#endif

#ifndef BOOTENV

#endif

M


