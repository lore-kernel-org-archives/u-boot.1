Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9DBCD4F4C
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 06:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 685868811C;
	Mon,  9 Sep 2024 08:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cRjgcTrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003BC87DEA; Mon,  9 Sep 2024 08:49:36 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB3BD88D15
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 08:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJLKfV+Ooocvwuxobva3mfklQBMtGyqhfd4qFTRk9xTCdC/cbmbyLM2cYn+mGXq2Hm12qlC/2ySfJktUF3h9hjjWEpQfNAZMDWY8jdY0g+xHS/Mcd+1LkilArsbfkP6hjfcnTQpcRzlgoxuMcCd+zwXGVR7jo5sxConicxTAiIOaJbxUATb+gTiWKd7SKWC5hJ6f/gCksa0l9q+2XuDeGXLvV/ej1FFfag82IgpLsClA9NrC+lSFGQ+w3opLdzmO3Gp+iA/N90+nHwS1Ke8XUVNuE2h/7DRlk/oeOZcX71LvVdpE8FXcmIi4052IyujxVaktjNFaALdRed1L6Wq3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NwF/MBeIwzQAv2gpQfPt2RoLpmtIVISf8qsuKS+JMU=;
 b=m7AlNDSE51yu0lmKsIQFvOdtAuR8pOxGXITU0l1K2Kkd+jHWDjejfDN+G4w+MfOb6T1o6wT8FB3VUjX0G95yfDY5YOPeq+0pqc+2pw6MXT2VzTTEByJmVOc8DzTXCe4476XAKB5Ad5/1N/i4ZFSbpeeaEEKVOLx++nsiPcHci0T02ifY0X2sOGj4VA/6mODbXULwxyn3vdRGV1lIOA3oOk1AGx9qGYmjvii7trHm7cxnwDcuiANsvRpRYTLMYLRovXYPupQG7P7u8sjE4zvBlLGIZwjT6NkWi82WnspTlnQuQz3cJuO/QaDvTSEjc2LnuOJCExW1wSSeNOMvPCYwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NwF/MBeIwzQAv2gpQfPt2RoLpmtIVISf8qsuKS+JMU=;
 b=cRjgcTrddbAOiCpCVLCj8JScz0dI2gKz9pzDuVbDFoQoYEhi0kXwSaW1G4FH8B0SM/B183NPyUA/XePg1ICO1CXHfzOGveU3EwgWeVf7VVooMxiT/9q0mC/k6D9oi2e0zJWqyylseq0iEaL1Q8wV1C7oVyVC9IaWR/SudoN7VFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.21; Mon, 9 Sep
 2024 06:49:28 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 06:49:28 +0000
Message-ID: <8b9b48d4-36b9-41b0-89f6-b3f1f41e0d96@amd.com>
Date: Mon, 9 Sep 2024 08:49:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Deduplicate mx25u25635f entry
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Neal Frager <neal.frager@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>,
 Vignesh R <vigneshr@ti.com>
References: <20240906211022.193224-1-marex@denx.de>
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
In-Reply-To: <20240906211022.193224-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0175.eurprd09.prod.outlook.com
 (2603:10a6:800:120::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8e2dcb-9152-4649-0569-08dcd09b8cfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHlWMXRMU1Z0cVFtcTdJUWRCVU9kQk9FeDh5QjBMRCtXMktvMUdjM1lqS0hQ?=
 =?utf-8?B?b3M3T1NpNE1YVmY2YVd3dVA5dUF5cWhteDc4VTB6UmRDMW5oSERscTQvS1Er?=
 =?utf-8?B?aWpyVlF4Z0w0T1NqcnoxMlhkclI0V05OeExPcXBrMkliSTd2NXpOT1lUdWlv?=
 =?utf-8?B?dVFpSUw0WE8yNFJEWC9IS3RGUjZJRDZGUDNIaDJMaDI1K1RwVTFaNWNYQWNW?=
 =?utf-8?B?eGFLYnNlNE5UR2xLaFdWQ1lGRFg5TjN4Q2NXUFFrRUtSQUdEN1pxeFE0TzN2?=
 =?utf-8?B?YlVCVCtveTUwU2tMT2oyNEVUMFpjckJTTzZvWXFob2VXU2lEODdtVExPNkEr?=
 =?utf-8?B?Y09iSkJGcVg3UjFQa2V2YmhCem13KzlQcUN2Ri9TcGNzTVpGTjJ5WW44V2hE?=
 =?utf-8?B?ZFVCVFk3a29NR1EzaXQwRDNaUTlpeHlYb3VNMnh3bHkzTVdaNEtwTFFqQmp3?=
 =?utf-8?B?NENGZzRJTThmMjFkc0c0U0VUdGE0TDgrVm9jTGVtVWRmRWJwL0R0M25kZVBm?=
 =?utf-8?B?b0J5QXJiak1PbGZsNEZoUy9VWEwvckVRamNwck92eGlGYnUrV0sxTVhVM0R1?=
 =?utf-8?B?QXZDV0Q2Yi9JRzVYd2ZjTXVBbGhyTktycWFOOEJRNWRibGFzRU5WOXY4Z001?=
 =?utf-8?B?Ri84ODdqTWp1Vkt0d3NDR0xBb0tUV3pYbjVMNWh5Uk9sUEhpMFVkVzRYOFFU?=
 =?utf-8?B?aEdaRW1vc3NVSUhZT1lGWnZtUG5NU2JKU0QwZU4wWVByVlpoWGhDUlQ4TXZk?=
 =?utf-8?B?L1RncXJCNVVCUGl5NDJWQUM4bjFPWlBqT20va25PeHhNWURBa1NTSHVpNTIx?=
 =?utf-8?B?dmM5aVZTWXRKUXh0WWpQQWVvYmdSbHB0bjhSdHR0SEZWc3FMVnBqR0NlSjdv?=
 =?utf-8?B?TnJoL3hIbEJVeHJINyttOEF1bkJhNnFRaFRMTGIydnQ0c2NLOHA3VUFKMUZl?=
 =?utf-8?B?RG5HbzFWemdSOTdRb0J2SWRKNWt2Z0p5NmpVcHZqZkFWMlBqWVNyTHA2a3RT?=
 =?utf-8?B?aUNjeFZyTTBvSFAxSGRUT3JQUGNOTE8xK2ZCL1lPZ0pBZlpKc3BWbjZSQUFM?=
 =?utf-8?B?Nmk5UTRKL0UzZjJTR3FzWGlPeTd2SWhlekpMRGRUSncySUZmcWUzZHZqWjJG?=
 =?utf-8?B?NWFMNEppWGZ3SFoxd0R4T1lyZG5neG5FL1F2c21ZSFhFTDhJV01DanZqTWQz?=
 =?utf-8?B?ZDlCYWQxcHNHRnRCcnpoQzljdlZzcmQ3L014NE1sVUJ5M1BaZGV5bEVhK2wr?=
 =?utf-8?B?Tlp0dlVYZ2kxVzFRQlpURDB2VURMU2xvRlpBTWQ4a0VsNm1UYzY3d0NRekxt?=
 =?utf-8?B?TTJCVEV1eko4UHRaZkJ5ZVM4UjlNTForOFBEam1NaHVlQkhLeDZCNHVHbjhR?=
 =?utf-8?B?ZlRwd2ZRWDZiRzlCYzYzVzYyYnZydXo3dTFidDVtNWE4SVFYalZYWGZISDRR?=
 =?utf-8?B?MmVmdVVxWmlzZEc1bXdPbE93Ykd4eENMbVFORmRaWlRhSnpZekEwL1g4OGk2?=
 =?utf-8?B?QWFZMFM1ZEhkSWN0UGp2dmNCbjBtNTR5a0ZhWG4zNG1pM0dFd091WDlhUDMw?=
 =?utf-8?B?UGNBMmxHSU05aDEwQVZZWnBaSC9aWVJMMlpmTzlyYys2YWEwNDNpdHdYb2tE?=
 =?utf-8?B?SUdFNW5jd2J6Z1RtZjQ4Y0lHNGRTbzJxVThwUkp6VUs4dE13WDJhbVRSc3R2?=
 =?utf-8?B?ZENXdVdOeXQ3TkltVlBsMlpmWUljVitUU2ZoS3FSMk90V2NEQTJiOW1aY2Rl?=
 =?utf-8?B?WlhOK05ncm5NVldQRUtydWFNUTNlN3RMOHNZb1VCNm90UDZKQTJDMG9YQXV1?=
 =?utf-8?B?V01GUUFUaTY4TnFDdkNhUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlZDbFdURCtndDQ5WlJlTDhpc2pPcHNPK3lFRkR5U1RiNnNsbkREV3FZOGs1?=
 =?utf-8?B?VFR3eWxBNW1VK3ZHUStNb01ueFhIaWE3YnNPSVh0clhMckFSTlB6VEtGcXp5?=
 =?utf-8?B?MncweC8rbHJ1R296b1IyVDM5WTg0VklzQzBrVjRBZm9nOGM0NmRpczhydm81?=
 =?utf-8?B?aEZxSWQ5WGY0NE1kc0FmbXBNdXZjNXhKVmhVSHFrVGRvTkVlNlZCNWNselg1?=
 =?utf-8?B?N2pJb05CTjBreC9vWSsrYlZFL2ZPVDdDZHd2TjhWbDRzZkt4ZzM2N3Jod0R5?=
 =?utf-8?B?Zis1eTdKQWpsODdrNDY4YnFPbjRReGY0T3dzeGdhQVZyWElRRVBSYVcxdFFq?=
 =?utf-8?B?Y1dXVUU5TU5TN0tQU0dycS8zaUNOM1ROc1NoQUswZ3NPcXhPd2JaTmlsSC94?=
 =?utf-8?B?WXlVYThjeHh5VzFLT2UrNGRRdXd5QzNneWFSN1F0ZmZCcEJhTmMxMisxV1Zy?=
 =?utf-8?B?WXd4OGhJVjR4bzJlc2pwNW0wbDF0MHVvMmg0d0pZREZkaDFoY0toZDhPNnQ4?=
 =?utf-8?B?SzE4RnQ0bXNlWmFMenZWUlNLdmlKWDZxanRjZ3A0dUxYY0ZTeHJ6b2lYT2F2?=
 =?utf-8?B?bElzUTFBcnNMS1NkYmtHcTRNNE9yU2p2MEFJNkZpUmJZRkl2NU5KeWtlcllS?=
 =?utf-8?B?Q1RhcEFXUkNrRHc0ZkVoUEtQMHUzcGRRTGRzYkhRampnOXlzSW5lTzYzQVUz?=
 =?utf-8?B?N0p3WVM4WExENFZEUGZMWExoWXRlRTZubG1pbDQ1azVHZ3ByK295OE9WWDBQ?=
 =?utf-8?B?djRsWE42KzgwZHFkM2RzekVHMHJQK0F4ellIT2R4dXd5eis2WlF3VWRDOG8y?=
 =?utf-8?B?cnEwdmxUMVJSOUY2QWhjMDdWN1lTZms5eHBxRmxWVUZVU2NqK3NoOWNwMUF2?=
 =?utf-8?B?bGVYdVYweXdrbEpkd21NRm1IekhQbkFPdTdGZzRMUDRZWFNHSkZCdDR4alJZ?=
 =?utf-8?B?M0JSZzZmcGtXaHFwZUhpSXlWS3VSZURGQlVocjhGWk5ia0R0OWE5WGxrYXBR?=
 =?utf-8?B?QWVlNTZJK2xzOWxUUC9XNEdPZmkySFNSeEpWaUoyWlQ1VHRvUGdta05EdEdi?=
 =?utf-8?B?Y21yV1cwYnhNRVgwbnlXNDdiRVNiZi9ITkhhcERkSGRpWXJqdnFyNWp4b3Zr?=
 =?utf-8?B?cWJ2c3orWEV2bXJXNlQrL3IyajV1cnBnQWNjWHU0WXVvUmNMT2F4QXh5Y05F?=
 =?utf-8?B?ZURpYStoSjlIeUE3VGtKcHdzODN1dUo2SWUrNGoydElOSjlSYWtyQnM1WVpO?=
 =?utf-8?B?eVM1M3VPK2R1L0ZhOGtmeWx5OEdWWUpvaVg2U2pRNzZDOTlmMThyU0NESVU1?=
 =?utf-8?B?d2x2MlN2SWU2YmgwdHoweDhQUG8zalZhYlQzOWNDdWxMd1gxc0ltd0Q3K01S?=
 =?utf-8?B?MHRqMWVtK3NWd1lxWVZEWEIyZFR1d2oyL2NlMTF6eTZWVlVNNmEraWdnelkw?=
 =?utf-8?B?UDRJZWFHUEF4VTJWaHBKN3lDWmdydEFsUkNNYU5vb3ZKdVo1ZktIaTk3UE5D?=
 =?utf-8?B?MDI2aUpGSG5NWXBYQWVHS0JpaXlRSWFnQmZMd1VuKzhsNmRJb0FVeVA2cXo0?=
 =?utf-8?B?UG9aT1RoS2FuNVd0cGs0ZXBSdW1VdlBjTldiQkc0cG5aOVZsVjdRY3dVMUJw?=
 =?utf-8?B?WU5VNFJlS1pXR1NGdFVMaW9GSGJhaGIzK3lzRGg0TGdQR1c0cmRSY05rMTFG?=
 =?utf-8?B?NUtYU3RJNkhCOXZZSDBLSjYrNWdsRkV4ZW1GNmhSRVNhL2l6bnpiaXJiOXpa?=
 =?utf-8?B?Uk5FL1VUT1lwNEIxcjdpTWU3MTE0c1ZBckUwaW52dEZIUWh1cXI4cWpMZVQ5?=
 =?utf-8?B?Z2VVMmxrTE1uaC9Td0JnczZGd2NmLzFUaHNTOHk4bVRuSk4vbUl4aGpEYlNN?=
 =?utf-8?B?dE56MSs5aXRMdU1wemNERG52SGdmNHlzNmM0Mm04ZW9ZV3A4QmtYVkdndkpU?=
 =?utf-8?B?Q2VQYitpZDhhVGdJN05yRGNzc0RVbXIyc0dwb0d4Qm0xWWVqRERPeWFiVVov?=
 =?utf-8?B?VzU5R2MxaUtGV1VnODI3ZkthSmd2eGpBbndPMXozN1k2T1lQZlVrOUxLa2JO?=
 =?utf-8?B?Y3dCYnNyVElGZlF2OXhZa2N5QlN6bFlkbmtFckZaSzNKR3dDWk96cVhqcFl5?=
 =?utf-8?Q?TFXHfKZY9XfCysj0sAIDn9lWY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8e2dcb-9152-4649-0569-08dcd09b8cfb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 06:49:28.5853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJLWtDYHUdMebN0we7hGsvGNy7uetolBwRe8qV1+cUqUb9JioI/4kkJdGcKJNG4l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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



On 9/6/24 23:10, Marek Vasut wrote:
> The mx25u25635f entry exists twice in spi_nor_ids, remove the less
> complete variant of the entry and keep only one copy of it.
> 
> Fixes: f0084f1dfdbc ("drivers/mtd/spi/spi-nor-ids.c: add mx25u25635f support")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Jim Liu <jim.t90615@gmail.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neal Frager <neal.frager@amd.com>
> Cc: Prasad Kummari <prasad.kummari@amd.com>
> Cc: Teik Heng Chong <teik.heng.chong@intel.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/mtd/spi/spi-nor-ids.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index d1389e681d6..5582a978ab5 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -258,7 +258,6 @@ const struct flash_info spi_nor_ids[] = {
>   	{ INFO("mx25u6435f",  0xc22537, 0, 64 * 1024, 128, SECT_4K) },
>   	{ INFO("mx25l12805d", 0xc22018, 0, 64 * 1024, 256, SECT_4K) },
>   	{ INFO("mx25u12835f", 0xc22538, 0, 64 * 1024, 256, SECT_4K) },
> -	{ INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K) },
>   	{ INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
>   	       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>   	{ INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
