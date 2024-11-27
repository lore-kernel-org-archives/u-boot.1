Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3573DD609B6
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 08:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC47892B8;
	Wed, 27 Nov 2024 09:45:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nn4/oiX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DEE6892B8; Wed, 27 Nov 2024 09:45:41 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 092CB89076
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 09:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK2TrLKbp2J3P6pk0xYiB2C76+Mb2wre8Z8qkHq2GREfgfWVgic4U9ucfEFAnP7ao51DUGLaSqEPujB+2IjtATmG4/PwSOVHVUf74W+O0H1+gR3G0LPY9KJgFfd7lu73IU8HPVXq33j2nPtOo25SMYeBxdcrG9VepmnDL78L/RP7Uejj2PIlFcfX4tc1NEizpcNp4cBco/KqP2gqzODBBvR9+SsGk01dFxYBU05PmoLCIJcoZoXGu+O9cX5WACqaRYkyRWbs0vNhRWrHpNmGRWVhdCn1xZ5QcbHJ0Te/SWVN6/de90W6nvwRAPrc0jAQAlbSIEk3+ksgvjhhyNkYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+i/VVL/lujbzCoOZvsAFMNrC57zxxMCYNLwnPF6atY=;
 b=wSimHmV2UUHLfz13ekyx+IgptEUD410YcPxoOyd1yoq0Ef79fQ8tkc053xwFoXpoDvS2+XOFUh3DvimatRdsI6ZMVt/PWr8hfuv/rFlIT4mRpb+oT+K5NfGFGp6RwvWuJRu1wSh5PmiPs/LJ8BNNBrWNds7hGUnjlDLIJsO6By44U54/KARt3PVrkWvWn78WCR0vRAltq/gtD+EdnkA+x7ppt6NVuRVtnzpvLxUTrAIQvXBTJlVPh/wj9jRkvllz9L1m7wcA3l5Vb3h+2GbKGlN91N0trptFl2xRvqZfE1ZgM7IAj/CzefXQHPVp77CdLIZi7523zCWv/z1HZXX5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+i/VVL/lujbzCoOZvsAFMNrC57zxxMCYNLwnPF6atY=;
 b=nn4/oiX1lMJz9EKKDkrk0BoK9QyTdq+dPXdGHmtUsmTfiuS9nHePuN93VjkWrdug6kls1FhTl2lfJNcw4GWrb5R6mHuh45kPj3U8DfHLZN7MK7G8UhKcRpcgunArIPYJPazbSwsYExpPcxSst0ChSX8ZU4VfhCNgw8m6T9jICKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB9282.namprd12.prod.outlook.com (2603:10b6:610:1cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Wed, 27 Nov
 2024 08:45:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 08:45:35 +0000
Message-ID: <79758ab8-8e47-447f-b7c3-744267402612@amd.com>
Date: Wed, 27 Nov 2024 09:45:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/py: zynqmp_rpu: Fix tcminit mode value
To: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de
Cc: padmarao.begari@amd.com, venkatesh.abbarapu@amd.com, git@xilinx.com
References: <48f75577f6735a0d14105658e89b625d45537bb1.1731672024.git.love.kumar@amd.com>
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
In-Reply-To: <48f75577f6735a0d14105658e89b625d45537bb1.1731672024.git.love.kumar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: f5166cde-b529-4ecd-c566-08dd0ebfdc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SlBNOGVpTkxXSkhLcVRWZ2V0WWQwRWFrUnd0TzRZS2lLRXBjUmZZejJldU5L?=
 =?utf-8?B?UWROb3lsenJJa3ZjS1BtaUkvaisrcVhmc3VEb3Z5bTZ5dkVRUzZlU2l0WUFW?=
 =?utf-8?B?aHdHVmJkLyt2SzBYZkgxZzA5V1ZRdW8vbW1nMGhkYm40c3h5MDMyZDIzbkkz?=
 =?utf-8?B?VVp4WTlVcUFHSUlVVCtRbnpBeXlDcTlwaXo5QjR0aWNUYmZxSGsyZ1hwdWRr?=
 =?utf-8?B?emtlNmJEdVpsRjlrL0tRLzZSS0Fqbzl6WnplSXBiOVZiajAzRWtGZERHOHRn?=
 =?utf-8?B?SGVJYWdYb2hsditkUzhIR01Od1AzWjFMQXdWNlB4eFdERWdkYU1tV0dRcElp?=
 =?utf-8?B?OHlOTXc2c1BSU2VZbE84MDdLT215bWIvM3NnVmJ5VE54WS9jSnF6N3FwR1l5?=
 =?utf-8?B?MEI0R24vbG1yU3RlaEFGcFRKclJmVHIvd0ZxdHZxV2pnb3kvWG93aUhrZHhO?=
 =?utf-8?B?Nm5WOWdHcEJkVWp5TXdrZHhRRkExQ0lEa3pTY0VhQ2I1ZldOVWo1U0dOWUdh?=
 =?utf-8?B?WVBFN1J4dzVkbVB3YTNLS2FVb3dhT2xGOElrbFFuOElZWWkvZkZLYmhBVVBC?=
 =?utf-8?B?V0hmckFaMkszNGwwSmQ3aDl2a2NtRlVKKythVmFUcG15QVg0cW1WaGZIbFZI?=
 =?utf-8?B?Tm10a3ZGZ2VpNSs0TEpZSUt3RVBOa0o2SE05U3BrZUlKV0NwVzdnZUNxVEl0?=
 =?utf-8?B?d3Y1ekIvTFFlazdFcy9rdHB1RmNaWHBMRTBuamY1RUZSZjlSQ21aYWx5WTVN?=
 =?utf-8?B?UnB3T3ZSS0lKK3VwQzBkQzgreVJTQS9sMWxscVpCeDdEL0JjemRzR2xQUlA5?=
 =?utf-8?B?MGFWSEpqWnNwc2JkUUgyY2p0cFFQaGdoOEFCbHRnMStRZHNKYjRVYkdQd0pV?=
 =?utf-8?B?MjRPQ25TR0dUbGxoRzY5S3JkR3VsUnZkeHh5THRqMlJHbU54Ry9LZEsyNlND?=
 =?utf-8?B?aERYTFFETkIxV3p2TUJOVUF1ZStXb1VhOWhLdU9LSkorSEdSZHFzVnQzYm56?=
 =?utf-8?B?Qm00ck9OUVFKM2ZmN1hpWFI5Y0dueWtzeFZ2NTRsUHl0OVZqTkF1L21Bbkc4?=
 =?utf-8?B?WlFTRDBmdmdHa1lwK3JsRVVTZ2hFQUtvVXF6aUZ2UWgyV2NoYXdBNWhFYkcx?=
 =?utf-8?B?SjQ4VmY2c3UxSis4TndENjRzQmZid2VnTWFYSzhUcjBnUGpQcGcvZGlJZURZ?=
 =?utf-8?B?RmZyY2VOSFpNWEVvU1JKWTFpM01YZjFxempEV3R3TGluTzNBdzNnNS94U2ZX?=
 =?utf-8?B?UFVDZ0tmdG9GTGIzWWRvUWtIUUpteFVmNDdaSUVHQlFNaGttMnB2R29oWUNC?=
 =?utf-8?B?Z2V5eW1iaFVRb3dSU0lST05qc2xzc205bjFtS2dYckNuUDJUTHUyU1F4WkZV?=
 =?utf-8?B?bjhydFpJSGhhTmw5a1pVOGFDUDY3eUtaQi9ZYkZQYW92WnlVT0J2WmY1U2JY?=
 =?utf-8?B?Qk0ySjdRcVhHdmpxZzFZSzJqK1dGL25BbnRjKy9GREl3WjlwTitmbTNlem00?=
 =?utf-8?B?TlNKc1I0SElkRmN1VnBFbTkwRlZxVit2RmdCTjVsNDVxZEZUdXRYL0x3NzB2?=
 =?utf-8?B?Ym8xK09vc0pTL00xMk0vZUgwVFBDVXpWM0tWMW9HWmFRSlZncXVvRDVzL0x6?=
 =?utf-8?B?VEcxYkM3MGNtY2ErdjRPcVJQTHkvT3NFUEtJRDVSMzNMSVZVR2ptb2lURDNY?=
 =?utf-8?B?Zm43emx2d1RsRDVzeHVOWU5kbmZOWEdqS3BQYkZqMmt0Vm1sUC8vUlh6YUpq?=
 =?utf-8?B?NTFjS3RacmVPOWI4dkJVSWhIL0x6eEZtbkZqSTVOWDVmRUdRUmN0N2xEczhl?=
 =?utf-8?B?NVlRWiszWWE4NmorRlI5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjBaZk4zU0VYV2V2UUJnRnRmWC9RUnF1djBwUlZZWXd3cmM5SnNMZ25hclFp?=
 =?utf-8?B?VGpKZzJkSTNpVW5hN0JTcnMwUFpqVUxjY0VVVXdjY1lWakxGdm8wcjBJVVlS?=
 =?utf-8?B?b2UxK0dCUjhReDc4NzliemdMTDA5ZUNDaUc3MVF3dEVLd2U3T1FON0VjUm1Y?=
 =?utf-8?B?K2tEWEJrdmF0T3dHNmgvbTFQeVQyaldPbWN0V3gzSDlmdk5sQWxmczIzZnU2?=
 =?utf-8?B?YUVtZVdtMk42ZFkyWUtOK01UZ05JU2NPdFJEVk9jbXNZUWlnOUVpd2doakRE?=
 =?utf-8?B?ZXEzVm45Q0dyTU50T3NFdjZ2RVhldldqdDM2VENvRkZNZjJsMFRqa3pjR3Ix?=
 =?utf-8?B?KzRENmxxVlFJTzhJSjU2akhDc3ZnY2pYMEhTSmtKT0QxRjNOd0hxb0lqcVN4?=
 =?utf-8?B?UjhLNnA0eitMMlIyRzV3ekRhaHk5d0FpVmlGcEhxVzl1ZE1qNVg0SjZVTkRp?=
 =?utf-8?B?ZllpVTRkZmNFTDh1Uk5sL3c4YWc1VnpZZ1V6VVhKUnAxWEEvRWdHdi9hWFRz?=
 =?utf-8?B?SENCcDZpOFlveXNFT3VLWjJ4TnZUak81enhGaU9CajZTODhZeWlxS0daQjB5?=
 =?utf-8?B?dkRXZmFIRmk3NDBRTlNubUY3STQxRTFLbWU0eHRYVWRsSks2LzdvSjlpamFN?=
 =?utf-8?B?SXlxNUFsdWlBMndFNko4STVBMTFiRGFpQWFtS3JBY2N3eUlJZWlDUDZBdldw?=
 =?utf-8?B?amJ3dHA3Z3NQTXAzb1F0Q2x5YVovOUJPa2tOM0hEN1B6YWp4VzIwLzR1MHBY?=
 =?utf-8?B?Wm1uZVpHbEg0NUhoSk1WWVBVRnNCQTd1STZiV2IwQ0wvd0FOVEIyTGJzbml2?=
 =?utf-8?B?aENvWE5TR1l3aXN4WEo4U3BCZXJOTjNuVWxNUmU2UEMwS3R0RGUxbnpLSkow?=
 =?utf-8?B?clFVVGJOSW12eFllcmN1OXFxc0hNVVcvMk8yZHBPVGlMbjBtRjV2M3BpaUgv?=
 =?utf-8?B?THBBSkxVdk5td2gza3BUSG5JT3FEUldDK1pMdjd3UmN2L2RTOFV6NDN6dUpC?=
 =?utf-8?B?R0QxVHRmQ2NueUFJQW8xV0hQOUU5dmRsSXBXT2xyVTRONjJoTHNWMXhZUEFM?=
 =?utf-8?B?QWZwYXJ6UWY2MGhkTkMvZ2VVWGJGVjVZQTZaM045Ni85eEJvQnh0R21ja3R0?=
 =?utf-8?B?eEw3WjZQTm9hc0VCc0liQnQzOHJYWTNzcmZ6TndvYlBDL0RNSlptSkoxTXVQ?=
 =?utf-8?B?U3ovOGRDeVZLeFJmRmwvTDNPVDNMQUt5Zm5UaXZwcy9EOTliRWNnT2ZwVzRE?=
 =?utf-8?B?ZUVnR3RlM1dvbVVMQmJTY0tGTWh0N1RSK3B1OWZwbnpCY01qOXgvVHhzQklt?=
 =?utf-8?B?ZDVjclhoZ296QnlWU1YrNk5qTk1CSW9xK1JzV2NYQzQ3YUJ1TUNUWE9hTFVu?=
 =?utf-8?B?a0JiWDQ1U2ptSGd6dS9KWGRuSnVsWTA0Rlo1NXlqYlYzaEZwUmtTTnpsMWg5?=
 =?utf-8?B?L2VYcXdlNkVOa1lrQnlGZE52NGFSdXBsUnJOUHlZd25UOUJpWjdGTzcyTjlZ?=
 =?utf-8?B?SjV6RjFSbCt4RW5HL1BuT2YvMEFvWGUxcFBtTHh1Wm1JT2E4ZXQ4MTlBeWMr?=
 =?utf-8?B?RC8wQTFCQTZwRHZnRG9yTzdiZ01mK0RhR24zSlRBYlAvM3I5QktMYWwxV2Ry?=
 =?utf-8?B?YmN3bWdrV0NHNmU5cXk3TWtzZ3AzOWVtSzk2QTRvdWZSWkxiUW9oc1J1KzZk?=
 =?utf-8?B?eTJEWVE2QmJIeWZoQ3VjWFF6NEwvQk5qYktRaW9sWFlkSTcwMVpTem1uelFX?=
 =?utf-8?B?bXlwaHI5dXJRbndEWFRHOVVvMHdQdmxYMHNkY3ZFQTZEYWhhZyt0Rzc2ZVJq?=
 =?utf-8?B?SFoxdTBLSGI4ZWRtekQwbmdrVFNuSG1WcHorV3hJUmhTQnQzRDlVUnFpLzJu?=
 =?utf-8?B?Y1EwQThhOTNBMURBN3dOYUxxR1JkZHJBUExaM0MyYWM3dDNEQ2hBei8xOXpo?=
 =?utf-8?B?T3EwaHdTQTcxV0RKUkFCRG5FMjJMZ2RTcExqMnJRUFVEbG1pUFdwZGJiR1VO?=
 =?utf-8?B?MW9SRGU5elphM1pmMmd0RUtZNmpucjhHSmduaStOUFN3cnBXWlB4ZWpQcCs2?=
 =?utf-8?B?cHhaei9waWJha0NiZmVVaHVHWXZMTUZWMk5KeHA2TStaZ2tjNnBROHZiM0JU?=
 =?utf-8?Q?ITxvdrigw3P93U1ZoxGTCI1Qq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5166cde-b529-4ecd-c566-08dd0ebfdc0e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 08:45:35.1031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFgA8Q8tGVbV9pakv6RbfBG+5bCpP/8b2T5uk+bzT4+NnY5r+wOUdQ8JNAlEabWP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9282
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



On 11/15/24 13:02, Love Kumar wrote:
> Update the tcminit value to string and number both as per commit
> 342ccba5586a ("arm64: zynqmp: Fix tcminit mode value based on argv") and
> also adds negative cases based on invalid command sequences.
> 
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> ---
>   test/py/tests/test_zynqmp_rpu.py | 84 +++++++++++++++++++-------------
>   1 file changed, 49 insertions(+), 35 deletions(-)
> 
> diff --git a/test/py/tests/test_zynqmp_rpu.py b/test/py/tests/test_zynqmp_rpu.py
> index 479a612b4ec2..22f687dd6d39 100644
> --- a/test/py/tests/test_zynqmp_rpu.py
> +++ b/test/py/tests/test_zynqmp_rpu.py
> @@ -70,7 +70,7 @@ def ret_code(u_boot_console):
>   
>   # Initialize tcm
>   def tcminit(u_boot_console, rpu_mode):
> -    output = u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
> +    output = u_boot_console.run_command(f'zynqmp tcminit {rpu_mode}')
>       assert 'Initializing TCM overwrites TCM content' in output
>       return ret_code(u_boot_console)
>   
> @@ -89,6 +89,13 @@ def disable_cpus(u_boot_console, cpu_nums):
>       for num in cpu_nums:
>           u_boot_console.run_command(f'cpu {num} disable')
>   
> +# Get random RPU mode between string and integer
> +def get_rpu_mode(rpu_mode):
> +    if rpu_mode == 0 or rpu_mode == 'lockstep':
> +        return random.choice(['lockstep', 0])
> +    elif rpu_mode == 1 or rpu_mode == 'split':
> +        return random.choice(['split', 1])
> +
>   # Load apps on RPU cores
>   def rpu_apps_load(u_boot_console, rpu_mode):
>       apps, procs, cpu_nums, addrs, outputs, tftp_addrs = get_rpu_apps_env(
> @@ -98,20 +105,20 @@ def rpu_apps_load(u_boot_console, rpu_mode):
>           test_net.test_net_setup_static(u_boot_console)
>   
>       try:
> -        assert tcminit(u_boot_console, rpu_mode).endswith('0')
> +        assert tcminit(u_boot_console, get_rpu_mode(rpu_mode)).endswith('0')
>   
>           for i in range(len(apps)):
>               if rpu_mode == 'lockstep' and procs[i] != 'rpu0':
>                   continue
>   
>               load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
> -            rel_addr = int(addrs[i] + 0x3C)
> +            rel_addr = hex(int(addrs[i] + 0x3C))
>   
>               # Release cpu at app load address
>               cpu_num = cpu_nums[i]
> -            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
> +            cmd = f'cpu {cpu_num} release {rel_addr} {rpu_mode}'
>               output = u_boot_console.run_command(cmd)
> -            exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
> +            exp_op = f'Using TCM jump trampoline for address {rel_addr}'
>               assert exp_op in output
>               assert f'R5 {rpu_mode} mode' in output
>               u_boot_console.wait_for(outputs[i])
> @@ -133,16 +140,13 @@ def test_zynqmp_rpu_app_load_negative(u_boot_console):
>           u_boot_console)
>   
>       # Invalid commands
> -    u_boot_console.run_command('zynqmp tcminit mode')
> -    assert ret_code(u_boot_console).endswith('1')
> -
>       rand_str = ''.join(random.choices(string.ascii_lowercase, k=4))
> -    u_boot_console.run_command('zynqmp tcminit %s' % rand_str)
> -    assert ret_code(u_boot_console).endswith('1')
> -
>       rand_num = random.randint(2, 100)
> -    u_boot_console.run_command('zynqmp tcminit %d' % rand_num)
> -    assert ret_code(u_boot_console).endswith('1')
> +    inv_modes = ['mode', rand_str, rand_num, 'splittt', 'locksteppp', '00', 11]
> +
> +    for mode in inv_modes:
> +        u_boot_console.run_command(f'zynqmp tcminit {mode}')
> +        assert ret_code(u_boot_console).endswith('1')
>   
>       test_net.test_net_dhcp(u_boot_console)
>       if not test_net.net_set_up:
> @@ -150,56 +154,66 @@ def test_zynqmp_rpu_app_load_negative(u_boot_console):
>   
>       try:
>           rpu_mode = 'split'
> -        assert tcminit(u_boot_console, rpu_mode).endswith('0')
> +        assert tcminit(u_boot_console, get_rpu_mode(rpu_mode)).endswith('0')
>   
> +        inv_modes += [0, 1]
>           for i in range(len(apps)):
>               load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
>   
>               # Run in split mode at different load address
> -            rel_addr = int(addrs[i]) + random.randint(200, 1000)
> +            rel_addr = hex(int(addrs[i]) + random.randint(200, 1000))
>               cpu_num = cpu_nums[i]
> -            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
> +            cmd = f'cpu {cpu_num} release {rel_addr} {rpu_mode}'
>               output = u_boot_console.run_command(cmd)
> -            exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
> +            exp_op = f'Using TCM jump trampoline for address {rel_addr}'
>               assert exp_op in output
>               assert f'R5 {rpu_mode} mode' in output
>               assert not outputs[i] in output
>   
>               # Invalid rpu mode
> -            rand_str = ''.join(random.choices(string.ascii_lowercase, k=4))
> -            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rand_str)
> -            output = u_boot_console.run_command(cmd)
> -            assert exp_op in output
> -            assert f'Unsupported mode' in output
> -            assert not ret_code(u_boot_console).endswith('0')
> +            for mode in inv_modes:
> +                cmd = f'cpu {cpu_num} release {rel_addr} {mode}'
> +                output = u_boot_console.run_command(cmd)
> +                assert exp_op in output
> +                assert f'Unsupported mode' in output
> +                assert not ret_code(u_boot_console).endswith('0')
>   
>           # Switch to lockstep mode, without disabling CPUs
>           rpu_mode = 'lockstep'
> -        u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
> -        assert not ret_code(u_boot_console).endswith('0')
> +        output = u_boot_console.run_command(
> +            f'zynqmp tcminit {get_rpu_mode(rpu_mode)}'
> +        )
> +        assert 'ERROR: ' in output
>   
>           # Disable cpus
>           disable_cpus(u_boot_console, cpu_nums)
>   
>           # Switch to lockstep mode, after disabling CPUs
> -        output = u_boot_console.run_command('zynqmp tcminit %s' % rpu_mode)
> +        output = u_boot_console.run_command(
> +            f'zynqmp tcminit {get_rpu_mode(rpu_mode)}'
> +        )
>           assert 'Initializing TCM overwrites TCM content' in output
>           assert ret_code(u_boot_console).endswith('0')
>   
> -        # Run lockstep mode for RPU1
> +        # Run lockstep mode for RPU1/RPU0
>           for i in range(len(apps)):
> -            if procs[i] == 'rpu0':
> -                continue
> -
>               load_app_ddr(u_boot_console, tftp_addrs[i], apps[i])
> -            rel_addr = int(addrs[i] + 0x3C)
> +            rel_addr = hex(int(addrs[i] + 0x3C))
>               cpu_num = cpu_nums[i]
> -            cmd = 'cpu %d release %x %s' % (cpu_num, rel_addr, rpu_mode)
> +            cmd = f'cpu {cpu_num} release {rel_addr} {rpu_mode}'
>               output = u_boot_console.run_command(cmd)
> -            exp_op = f'Using TCM jump trampoline for address {hex(rel_addr)}'
> +            exp_op = f'Using TCM jump trampoline for address {rel_addr}'
>               assert exp_op in output
> -            assert f'R5 {rpu_mode} mode' in output
> -            assert u_boot_console.p.expect([outputs[i]])
> +
> +            if procs[i] == 'rpu1':
> +                assert 'Lockstep mode should run on ZYNQMP_CORE_RPU0' in output
> +                assert not ret_code(u_boot_console).endswith('0')
> +            elif procs[i] == 'rpu0':
> +                assert f'R5 {rpu_mode} mode' in output
> +                u_boot_console.wait_for(outputs[i])
> +                assert ret_code(u_boot_console).endswith('0')
> +            else:
> +                assert False, 'ERROR: Invalid processor!'
>       finally:
>           disable_cpus(u_boot_console, cpu_nums)
>           # This forces the console object to be shutdown, so any subsequent test

Applied.
M
