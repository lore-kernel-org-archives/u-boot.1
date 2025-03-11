Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE62C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 08:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A2D807D9;
	Tue, 11 Mar 2025 09:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pn8dAsN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF39C8083E; Tue, 11 Mar 2025 09:04:10 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A415807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 09:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH+VJFP08faRMdZXRBI6ejQcTzPTfGk5Flv/7+eM0XNKzKq9EhFhk64rwc73KM8Ceo/qS35HytzRlx7gIe2fBQO9VnOKjFU1UvCrUniOfPqQffM5nLqqaFFmq3qoMwT3rH7EyIYfyohugiwa102hQMCYR209ie4Y89w9FelqCZkNcV74hTtyTuQliogrwDfs1bDvZ3KwF33pFRjUHwiPdhDE+9bRYTkY9MY+ATnXEs5tXNT4keJKo3xz6ZUawqLXoBGpSXGirb6x/m+SNhddDAZBdvunqyVB+tgAAzEIe1eOe46WX81bx6yLxlE/aF7MLJudCXpoQSD/G4rFsWR4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyX4Ts0EGGA1ASvkc3WMEFPQ3ItNGEL++JKWtEkmHEA=;
 b=tiHxI7q4m2UXEvF/wEsWLb/MD/NGtr8zf35SbyfyZZUDiycIcTKgxstrK5CdwyF0XyGVdabSuynyr71y5v0gvXXnp7vmFo2Ix7azusXCpPmzdHeUVRHzO9GWW3cctKA3cHI0igDdom892JfeOgj7iJ7FAODnIQFlFefennkR3qMuwPIedKhkMo0a3RKrubdL/PqNw5XO+fvuL3v8GJ4SNaVY3h5hgn6tZlLUdP3DCyXxMcuuQ2xbAvrn6KGzjw/3dErtXmDXct0yxyjZy5KU51KH65zRBJhGinxAlK3M0ye2Ho+7WBoj8IstjKG9PG/KZtDQMaqOf9K9l/w6Gpg2ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyX4Ts0EGGA1ASvkc3WMEFPQ3ItNGEL++JKWtEkmHEA=;
 b=Pn8dAsN+njfYb6Rhsl6DDacx1hmWrjpjiegmnVyQ2/+BezwtyaCETD4N8vIfuSlVFRSJB1GqGidqWvEZT3ls5/eUV43utY9lbCq+0T329Yd75ilTuKfp42eMlyD5UyYNP4j8io4JNGdiAw0qR5NNhjRhDzp9Td/aRapnCEjXRXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by IA0PR12MB8905.namprd12.prod.outlook.com (2603:10b6:208:484::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 08:04:06 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 08:04:06 +0000
Message-ID: <84b5bf66-fb4f-4590-b6ab-fa1ee3011aa4@amd.com>
Date: Tue, 11 Mar 2025 09:03:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xilinx: Allow alternative boot strategies in
 zynq-common.h
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.39d305af-e006-447e-a675-c4e243ffeb48@emailsignatures365.codetwo.com>
 <20250311070124.20696-1-mike.looijmans@topic.nl>
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
In-Reply-To: <20250311070124.20696-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|IA0PR12MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ee08c4-9a90-44c8-7268-08dd60734b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekh0SGZacWlTWnU2Uit5RHg3ZW00Z3REYW1Bb0tkaU5vcnZKajQvbVlNVmtq?=
 =?utf-8?B?ZElSTjVua1F5bVJzUGJNbldyemh3WlBCNnNVeU8xWHp4Qjk1WnZ2Q0hydkVr?=
 =?utf-8?B?S29WQ2Q0ZVlaQ1JHeXFTZW5Qb0x1TEY2cThBREtuUHFMYkhGWUE0SHNCTjl3?=
 =?utf-8?B?VGRlVXJvWDNBKzkxWHo0K0QwQmFpZjBZUkNZZ05GTVlwTXpvOUc2THZSdmpy?=
 =?utf-8?B?WWZUc2Z4aFhKckJIWFpjb2FlMmxGZHN3dmFoWWdCVE0wTjhETkROZGJOZUJh?=
 =?utf-8?B?RHQzdlVzUzNOeVdCdFVQZjQ3b3RJK1I0cEpqZVVqTm1YN0xVd3dtN0JqUnhD?=
 =?utf-8?B?cFp3Q21XdHhKM0JtYmpXZUVFS1d5NEg5TnF4d0pDelhEcVRxSWsyRHZpbWJ5?=
 =?utf-8?B?bDJxdTBIN3RWNi9kNlNvNktvclVvNDdaRmdKL3h2S3VqUDFIUFZIVllrdG9u?=
 =?utf-8?B?cnBPQk1PY0ljZFlDUXBZeVNhajhCUVJYcnh3bHg5ZTBjbXJLT01jVG9lbUVJ?=
 =?utf-8?B?dDRiU25nNzFucENyUkdoekNBdW5nYmt0a0FRcjlZR1lrMXpjQVd5MHM5dzBp?=
 =?utf-8?B?cXB5TWJjWlhPenVpcEgwcXdWbkRmb0M0Y3lBRGdzTXpYY0wzdVpUR1NORDJL?=
 =?utf-8?B?VmdsQ0phc01nVng4SUUvbW5RSUZUSFJEZDNuNVhiY25oUkhxY1FHQWxzaGFq?=
 =?utf-8?B?bmQ1NmJFSkhjTzYvWW9QN09DVSsxZTJ6bG1KR05BTy9rd21VNWg3QUJLK25H?=
 =?utf-8?B?aWFYbXB0ZVRUMVpnUjVpSFVnOWlWNUlUODdLZ2R3REZIMFNLUDYwWG1IZk5z?=
 =?utf-8?B?Q1lFSjB0Q2dMS2dzWXBEUTM0UjBSdkR5REg2S1pYTWZhN3hydFZiWUFpdldh?=
 =?utf-8?B?MlhSMW5ZN1o2RlhTVkJLRzRLZjk5QlpYREtUOURQZ0htZmV6RU9zc2duWGdN?=
 =?utf-8?B?dUJ4VkdWcG9IbVM0NStvZWtKdDhmOWhObTZHVlN5eDl4WUdMem0wZ2NaTktv?=
 =?utf-8?B?T21vRmpJNjZ4aGh5UWYxamlyRWFCQ2pDcXNsdUxGaFpMa0dqZll6QjU1bVRR?=
 =?utf-8?B?Q0g3VEtZZVFEbk9QNlh2SFdGcThzbW9ocTB2ZWZ0b0NvVHBSZXVIdnJjcDFN?=
 =?utf-8?B?Um5SQ2kyMzJwbzVVOEVBeGJFdkpmbjB4eGV4VUNBd0Vub05zK05IU2k5VDZ2?=
 =?utf-8?B?Z3FqTDJhL3cvZjJJR2h0dDhkck5ZSVM1WmgvOUtGejFkcU5UT2Z5UlU0REMv?=
 =?utf-8?B?Njk0TUJoaXpIbDBNbU5rU1J4RG1hTXpyVU93R2IrbUFuNDM4SmJJSEQ1Zy9X?=
 =?utf-8?B?NUp5UkFacU1WZSs0ZUxNOFMzREp0aDU5SWZlVi8rUEVQR0IvcE5qcTRvYUph?=
 =?utf-8?B?SFUwd3Noa3dCMXJGZFR0Zk82akFUaDNhcXJJWFJycW8wbThrZDYrRzVOK2kw?=
 =?utf-8?B?Ry94Z0Y1TDd1ZTFNK2lxbVA0WFFKU1lxMVAvcjlmZy9FdmZhYlFFMnhOdVd1?=
 =?utf-8?B?U2lORFdMcmJhM2NRbmNpdFdKaERwVm96cUxCSFZqYllRaHgyZVhGaUt3UzZa?=
 =?utf-8?B?V0VrSUdUWUxhdlFEUVN1cjlSOEt4b2tuNklrUU1TcXZsLzVneUMyeW9DT08w?=
 =?utf-8?B?Yk5rQWZMbzVwWVM5SzdNcVpCRVNaRDBNdVR3dm5iaEp3d1FXR0psWHVJVm9B?=
 =?utf-8?B?OFV6YUE2LzJXRnVxNGR0V3lNOW9jVWYxL2M2U1ljeTJKb2xLNnJySElNYzBu?=
 =?utf-8?B?R1NzTFc2emUxbHI0enJqS2xFSTY5MGk3Y2dnNS96SVpJQzF4YVdlYXNhTkZm?=
 =?utf-8?B?RzVGL2RtanN1a3g1eTJwWE5zNmNzQlcxQUNZOVdvaUNyZG9acndncUZDSm9s?=
 =?utf-8?Q?qQG5ONAwlVD15?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blkwUWtlL1pKZ0xrT2RpMG4rUktWNXJJU09STWh2algydi8wNzd5ZlhtYXdi?=
 =?utf-8?B?cExKQVAwZHNOMCtkZmpabGZOTzJjR0xLaFMreUxQMDlLdTF0OFNNckx0Nndm?=
 =?utf-8?B?blNFemZVQ1E3UTBBSjVIRlAvMDkrYjdnTnczZUwrN2xiQmRPVCtsaGtDOWlk?=
 =?utf-8?B?SXR0THZGMnhaWWEzbkFwSnVpQnJvakswRUYwMG1zYmc2VzgyUjZFOG5QQ2xO?=
 =?utf-8?B?QTVoc3lmeThIcEdRRTlQQUVqb0IwbmtRdWFHaDhGV0habGt5Q2NERjJ5d1NH?=
 =?utf-8?B?eVdaUlFObTlmbDBzdjhoRU5TNElsZmR0cEx2SjFYQXhnbHg2YkYvZDJQYUVZ?=
 =?utf-8?B?TDJQQ2pOZlZwa2ZEeFhmUXdoNFBRYlMva0M2OEFRb2YvL1Y5Wnc0aFM1Nkk2?=
 =?utf-8?B?T0l0NHlEUzVINkxSektlWjFsMXJoVTdkM0pVeEJhZFZJNVJmSGU3ZVlYeFlC?=
 =?utf-8?B?UEZZU0MwbmRqcG9YajNwU0N2K1VVd1lwcmVrbktCMVFTc0dVVGdtNlJxSUtC?=
 =?utf-8?B?ZWc3bWtYM040ZWZYUjRHSWs2QmtTRmJhSTNpVFlHMUtKQzNDRm8zNUxNMUdM?=
 =?utf-8?B?azYySW9ZNjVmamNQdDVqRjF2cnBnYVVnNEdJb1dMT2czSTB2Z0xJK0lzVllw?=
 =?utf-8?B?MnBUelVwSXllRXRjUzd6T2lpaThVNll1dWpBUzBCWE52K2hLUEpnSGhOR255?=
 =?utf-8?B?dG81bVhsdlN1YXhTemk0MGRORHQ3eS9VVmlaQ2xwK0RaamdwQUJUVndxZzFh?=
 =?utf-8?B?TjdmaVd4MzhLMmtXOHNNcitmS09HY2JISE5MMW92YXZFRE5WbFA4clFiTHRH?=
 =?utf-8?B?Rm1KZGZ4QzQxa2JQT3A1OVJDbGVUcjB4OGRMYUFwNTdaakFMMm83VUdnUDFY?=
 =?utf-8?B?MDNyVXZCaU1EY1VWbjNQR293bTI4bVl3WW5sbzBZaUNtdzlZbm5DVy9jQldZ?=
 =?utf-8?B?d3BMQzJyV1doUTFHZVJaU2R4S2hudzNuRi96WnQyeTNsaFhuY01OOTI0VEU1?=
 =?utf-8?B?S1RVb0JrMWtCcXFpTVl3cENEemFrU1Q2S2pEc1BHdTZmU0VicGk5ZTBzV3lC?=
 =?utf-8?B?RVVyaTlCeXdtRVZXdUJORU50TnJWMzBYUHhzRlloWTNxS0ZIMnFtYXNsUFFO?=
 =?utf-8?B?ejd6VFNpVWZuNEZzQ1Y1QUFBMmJCTjUwSWRNVW14Q3I2b0lwRWlITHZ2bDY2?=
 =?utf-8?B?RFRDVlA3NDdmVDQrZ25mTEV0eDdmUVNSY29FSER3aWpDeHNkeDExQnB2UDN6?=
 =?utf-8?B?aDliRFdJVWhqQXVuQitCSzdFN2pheEJYZWRtZDg4WG5QL25EdXp1SnI2Nk8v?=
 =?utf-8?B?a2dvZ0l0YXRYQU4vSUpGSzc5aWp0MDhjU2lGMzI3T3JPODBjcXorbnFHSEY2?=
 =?utf-8?B?SmJwc3FNZzdpVnI2NXhiZFd2R0ZITXc4TUxuN3lndW0xTzJPWkljYTBQZ052?=
 =?utf-8?B?Mzc5eHV1clZPdlZjRXR0U0lROUhFazlOYmdJd3pMNHI4VkpWSkVmSjgyY3FM?=
 =?utf-8?B?eXBQcEJRM0RtQ05KbmsrMmhrOUxiMnhsMTF3UVJKa3Rmdk0xTENTYTNlOHM2?=
 =?utf-8?B?dTdUMFVJOVRsVGN1MExlOVVZbU9NNUZobHM0SDR6ZGtRZWRvaVEvVVR2QVp3?=
 =?utf-8?B?VkpTRFU0elUzUHVvYjFGVHNFRWEvclNZS3YzcWt2bHpCS2RHWGF1bnhxeHVR?=
 =?utf-8?B?MGg4RUNTOUFqMWhtMEJnM1FUcVVrNmpwbmt2WnQzMW1DVDVpU1o2VHluZm56?=
 =?utf-8?B?S0h6cUlCM20vWHRtWGg3bnB2anNiNUtPWjROZDhERmZaajI2ZG1ocC9qNHRY?=
 =?utf-8?B?Y1EzdCswaXRoN3dxNG5UVE5GQXZaT3VQVXpqVFlYZ1B1eFJHVjVQNlFYMHAv?=
 =?utf-8?B?N0FwbHRMeUQ4a1hpQm5hYlh6ZXBScUF2MDZrQktSTTNKQ1RaQTRiNmR3STla?=
 =?utf-8?B?YjVOdlU2TS81MGJFUkR3Nng2WjkzYWVPWXVvWlF3bkczZEt6b2hRZTE4T2Rr?=
 =?utf-8?B?TWR5blpoN2k5MUtXbW12d1hkR25YSG1VRnpHZEgvVjZpMUd6N1dvbHlDMzhj?=
 =?utf-8?B?emtQSEFpVWdjUU5YSFcrOGJtSGErd0xJWERNc29sRmVEYVlZSkp1bmdDdFRt?=
 =?utf-8?Q?xcdtHIAhhUZeTnVnAyT6lqYxP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ee08c4-9a90-44c8-7268-08dd60734b64
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:04:06.0766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YshHR2mj2EP+COrvgB8NKfXsi/qt2/JTBSQhU8ytt55ATkamo7D8Aqwz+iDT0PqM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8905
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



On 3/11/25 08:01, Mike Looijmans wrote:
> Allow config headers that include zynq-common.h to provide their own
> (distro) boot strategies. This is implemented by skipping the section
> when BOOT_ENV has already been defined.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>   include/configs/zynq-common.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/include/configs/zynq-common.h b/include/configs/zynq-common.h
> index 37c77aa1611..ad872c9d922 100644
> --- a/include/configs/zynq-common.h
> +++ b/include/configs/zynq-common.h
> @@ -48,6 +48,9 @@
>   #define BOOTENV
>   #else
>   
> +/* Only use this section if no BOOTENV has been configured yet */
> +#ifndef BOOTENV
> +
>   #ifdef CONFIG_CMD_MMC
>   #define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0) func(MMC, mmc, 1)
>   #else
> @@ -167,6 +170,9 @@
>   	BOOT_TARGET_DEVICES_DHCP(func)
>   
>   #include <config_distro_bootcmd.h>
> +
> +#endif /* BOOTENV */
> +
>   #endif /* CONFIG_XPL_BUILD */
>   
>   /* Default environment */

Why are you sending this again?

M
