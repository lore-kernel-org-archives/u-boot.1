Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE26CD37B4
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 12:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F3D889BD;
	Wed,  4 Sep 2024 14:00:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CdtBB49X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1293F889C3; Wed,  4 Sep 2024 14:00:17 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F207888363
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 14:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkIjwDvjFjLX9JFCxp5eu1dNFwWXHGpT4YuyuGjA+JsPZSe30dbwIpbK4u+8fsCxAinHIhAfqZjd4faTw/Y/0Hi64OBEGZxFD/C//OSO/S9vMJolOAfx2hWygrPVIPQpmlLc4qxB2WWjRkuv0V/5qUpCFS+y58dnCAyN5LtYGDYctoXpEoC+J25vMGBjY5H5tU/C8Lho2iX9D1KZq3dqhPtuDv+FnkkJNSB3FcRpgILxfR6kgEWfUAINKoIRhuiHtVWc7ykT/WV2awoohtYz/lGsN2lOHaqqzY9jsD7fg1Z9z6wb8UTIyz8WYdXe0hHUrfng/vq2WBtx0r4FTxXVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdOxfzw31MnMTr1QDX27KTc/H5b7XtZ6ePzVDZv/u34=;
 b=ZSEWd6YHFYdl+JjYXsY8/NpvJ8qrQMPubZmanLIbrLwGo54s/1MIT+ZceEJEfVBTDPrqEMcvAfkLrYC0jVl1UWzH4psjPXD1Mf0Y/ZxMfiduTKch+TP7IvX2CFnjA3JJe2KER0bDbmSZIln5BQaO69hvSpcq6wqL17jlHCbMTWnCTl68NR7OnGYl9Wrrl9ZJhkBDwrYhfoa8cz+N7TCWWEnVMA6q2mGyavOGy3J5Y72vjfPjvDBdEnVBMz0XO+HfgrlOnKlmce9FLrW07GIXIpM0Wst7/+6TTO3GmimDaF9i3dkU7Tw5l+kYdCBjLo2DYfJiSuzENBT5Q+dZaYRgog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdOxfzw31MnMTr1QDX27KTc/H5b7XtZ6ePzVDZv/u34=;
 b=CdtBB49XGH/5uWeGmH7IKAvZpDWZyl5fbbYHl2r86iu6P7ap03qJehJENOE8XnE6RaxpZCule0QfxcrnQAn7Pp2+WMRgoYOT8ZYQ6ftMmxkTS7Y2m5abvEiSn3GYhv0gJvMyHcO4xY0hJnY3UznqymtkBKFHBRBtrOc5t0wZkyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 12:00:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 12:00:08 +0000
Message-ID: <dc2c0bd1-3aa7-4347-a4d6-5754a40e5b7e@amd.com>
Date: Wed, 4 Sep 2024 13:59:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Miscellaneous FWU fixes
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
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
In-Reply-To: <20240830114057.891069-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0105.eurprd09.prod.outlook.com
 (2603:10a6:803:78::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: 003b0d29-897d-4f97-f969-08dcccd91f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aElkbURxWFhveCt4NkgyMnV4bS84bFd0VmRRTDhnVmRpR0RxTUVocVRpTHVs?=
 =?utf-8?B?SUxJWVZYTTFNTW1nbzNqVG9SWTZjRTlOdTZlM2w4cUw1T0JFWWJQVWZpdU9P?=
 =?utf-8?B?ckRLYjBxOWU5TE5uN2tVcC9kMmQ0VjJ2ZXdncjlMbmo5OHdpdm9vRkRpSzBn?=
 =?utf-8?B?a0g0djNWdWpMdmVrY2djekdpT1FoQUxVelQzemswaS9BdGVtKzFKTmtRRWl6?=
 =?utf-8?B?MFE1VkZtY3c0OEsxa0pYQmJyOVJVN2JLbm12bEJvZ0dYeHJrR0J2dklQWS9T?=
 =?utf-8?B?NzIyWjhBbU43Y3NWNk5xY25xTkxUYmhXd1RKZkZrS1djMnFVbkxOYWJ2czhy?=
 =?utf-8?B?QXY3dVhaM1pFYVVONVJ1WkVocmtsT0U5cHROVkV1NzNRR0FtL1IyRjl1U0l4?=
 =?utf-8?B?THBWSDZrU1AvMFBjQmYrWGdpekcxb0EwTyt1dGt5TDdmTi82RDVxK3RsbGtT?=
 =?utf-8?B?NmFnRlVBb00yckRKcGxYRjlOcWZoY1RMWFh2SnZjaUcrVTVhZzBKMWdXWkRk?=
 =?utf-8?B?VG1UNmZWQTRtaks2ZVB3WGhyck92cFQrdEVlbTJtZ1VEblV1V256T3l2RU1K?=
 =?utf-8?B?SmQ3UVVvTTRzTndGR3Q3dGhXeE92dmxmZlpzVDRDclI2RVpXcEZjeFpEcDRz?=
 =?utf-8?B?R2xxUE5Jak5VU1NTRjVmWlZabW9pUFlMeEk1YUNwTUZsQWlHeHRwZFRhQzFu?=
 =?utf-8?B?V1VlYS9nT0UxcTVWOFVlYjlHc0RqL3B1YkJiblNQZTVDL29Hdng2WUcxQmt5?=
 =?utf-8?B?NUNSZGJ6OW1tS1J1amxKdWhiU0J2RWZlTHA1WSs0UFIxM3h4cnN1ZWo1UzM4?=
 =?utf-8?B?OXhmK2xFbHNCOHRpM2dsN0pqU3BhS1hFcjR3UFpUK09wMXZpd1hFWVFpNWdD?=
 =?utf-8?B?b0FJT2JhVnNWTjRBSVpzZm9hOHllTGRZS3B5NHF3WnE4WDZGV1NRNFdlZTZK?=
 =?utf-8?B?YUtXQ2VSZUR3OGQ2aFlWNXRkM2pGQ1hOdzVWSUNNQzFwSnFsUnZzRlhVVVlu?=
 =?utf-8?B?MEFxcVR6MHdKQWQxVllXaTVMdHArNExhY2pPVkRZcjVFRnB2aGIyVXBKL1Uv?=
 =?utf-8?B?MXl6LzVraGh6a01jVUd3dFE3amovenRlK0VjNXpWMHppMHFaUGNLS0IrNmdH?=
 =?utf-8?B?bTlacStHRjd4NEJsL0o0c1VCaTgvck8yMmRmVXpHNWhObmVXbGNwd0tkS3pY?=
 =?utf-8?B?WSs0ZW9EWnNKQk4veDZMeFUrL21sV0hwWXM0SXFvUkdvV2cwbDF1KzBKT0I4?=
 =?utf-8?B?cnVoaUlFMkJHeVhSTEFjVG5sKzBTb1ZMU1lPNG5VemI4aWtmTFRBZk1oVVda?=
 =?utf-8?B?OWFkM3orKzlrc1lRS3IxUHBONGNWTzJ4aytvRmdaUkFYR0VyUHF2VEViTDVQ?=
 =?utf-8?B?a3dDaEl1SmIzNWZvbDdBNEtYajZEQW5DUmhvbi9qK0FRUjJTMldaOHRqU2xZ?=
 =?utf-8?B?V1dVY2RqL00xRTc0VkV1UENtVmJ0dFhOZkxuaTZzdXF3Skw0a1Q5YXdFd1Rw?=
 =?utf-8?B?TUlncHpsQTE1ODk4c0o0Y0hhRHJCd0xMSjBlMTJLVmFVYnVGZ2tHaVFDRHBh?=
 =?utf-8?B?bW12K1VoVVJ4MTNWMHJPeGFuWkgxVWh5dlZHMlF1OGEvQzliQ1lhQ2VTL3Vs?=
 =?utf-8?B?d2dTZGNGNGdsM2ZaeHpzQUJybFJPcy9qWkZwc0RCZ3hpN3BCcWl2VE1IQmFV?=
 =?utf-8?B?bytLbUxLOFpZaVpQdXhpTEZzQkhnbWF6MnJHeWNsTWlHbWpPMngxb3dMUUFD?=
 =?utf-8?B?cHlyWnVDVVJQcml1c3IvTmVGTU51K3RxN3VjRlBsSno3ZWl0SmlVYnh4MTNv?=
 =?utf-8?B?N3VMOWhXNnRiRzBKVDBYQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitTTnRYQ1A1OTJlb2FGSVhTa29sakNndHlQeDEwdHcySmxZS0hUc0M3VXJX?=
 =?utf-8?B?L2JXeXJPVkRpRUwvMVRYN1JaTEJWNWlZSU1lRkFyZTJ2ZXQvM1pLQlVtQWgy?=
 =?utf-8?B?ZHlUN1JMdHdrRkh0WitIbVpTb0FvT1YrUUxpMjlLQkxVempObThKWVI3MmNj?=
 =?utf-8?B?TlhwaTgyVExhazlvQW5pSDM0Vk5kbEt3RUlBWkxGdk1yNEF0R0htWkdBdmd5?=
 =?utf-8?B?aGZ1cmgyNFlTUForL2thQ2FJeEcyZEZwYVY4bzExWEdTTzRVV2NxNEphbDFy?=
 =?utf-8?B?aEpuRFA1RDRyR1JWbTBJUVZIV3NobDlWVm1UR2RJSXQvRlZ4V0V6Qlp4VVlt?=
 =?utf-8?B?Q3ZkbXlkTlR2eWZWdUp0OC9sNUJ1RDRGY0VBeW5CWDFCWjB1UzZRWnkwNVFa?=
 =?utf-8?B?YytKSTB0MGI3K3pvUDVPQ1VxMWhIeXJOYkRZeU1yS2dKbnpLQjlNUmlDMG5j?=
 =?utf-8?B?cnpxcjYrZE1ZTUtTblp6emZVKzJ1UHd5TmFRWnQwN3BET1M1K3d5M292NTJK?=
 =?utf-8?B?OEd2QXlLakdiemNZcE1JbEhQOHFWUzNqQU1NZzdLbEpBQTByWDlkVlE5dkha?=
 =?utf-8?B?V2I2Qys5RzRjOEtBaVlia1lNV0xRcExxWUJCMC9iZENVdTVURk90MksvblFv?=
 =?utf-8?B?OVdsNVlOemRoeTBjYUN4R3hZRHp5RTUyQkZhZlVJQkpPaTdSOVNrdDREa1B1?=
 =?utf-8?B?clZ1NWxjcHJ0eHUvZVRLSU43UHcydXFKTTI3VXlXYlpuckdINW1TTUZzb2Mv?=
 =?utf-8?B?K1BWN2ZQMEZTOWkwWGJkY29WYVEwUWRlekhKRHhKZWFSeGk1bWUxRlpWSFFa?=
 =?utf-8?B?VnNPUFVTS0llaXJ4c2xpenAzVUMyNTYxZ0lXRXI4cDJrbXFBYlBnQUtRQy9S?=
 =?utf-8?B?YkFPWDhyQzJJMENYZTVIU0VmZlJodXc4R21HZEtHVDZSM3hnd2dpYStTSWxT?=
 =?utf-8?B?cm56NTdJUC91RGxrMS84aTR2VVlBU2NVc2M2cjF6cGVrbFlnQmMxWHYweW1x?=
 =?utf-8?B?enBYSWdpaGpuRkRmZFFWc2JKYnRZbHR4Z1VXOUNCZ242Zkd5c010VWdDQ3Q1?=
 =?utf-8?B?Ti9JUWhBUHpyYlpydGhVemFHdTlndFZSVldrSEFFcFExSGJSeVQ5WWk4d2w4?=
 =?utf-8?B?OHowS2cvcW5vU2c5STFhN2ZpK2pTcWZCckNITVJjN1g0YVF5eVJLRDVCRzZD?=
 =?utf-8?B?cW1rTVZwdFZURFhMeUhDRmNiRDgvemk1WnR3aXQvU29FY2dRVjByRUhaVlJy?=
 =?utf-8?B?VXVOZHRqbHQzZjhGb2dmMEZxY2JZYjNacjFEL1JFaXVmQnUyZVdOVGU4Q3VP?=
 =?utf-8?B?ektNQ3MxUkF0R1RrSyt0UTRrbStReDAxY0ZTYUZiSHgxa0lWVk5aeVJFVW1U?=
 =?utf-8?B?Nk5vREhjZFczaWREaGFUaWJMOCtmQVZEd0dxemNwNGJoS055SXFWdWlaYkpK?=
 =?utf-8?B?UE8wTnJLTHNJRitrektjbk5JUHo1Mk5EamRFUUVVTEdFZmJxNmZKblNVRTZu?=
 =?utf-8?B?bkpHcWk4YVZ6cjVuaGZNOGRYSXFkSHZCcTBpSjYrSm4ydnBja2xoL1liSnhN?=
 =?utf-8?B?SUsyZDZ5RVg4cXg0b1g4QTJSa2IvTktHL0VwTUZSam1UOFUxdFU0SWZyNWVj?=
 =?utf-8?B?cTdDNU9Hc2lsbDVPckNUNzNsTG9IZ3hZenU2dVdSRnFvc1F3MmZuRVB0S3V5?=
 =?utf-8?B?bHVsbCtwWWtSUFRhZXJnYzdnT1ExU2kwVVVlaWkxSHZ5ZkpkVS9UU0ZQYVM3?=
 =?utf-8?B?Sk1rNXJzQmZFQWxVRW5aNHpSNytDMFNLVzFDWFJZZm1jV1dDMGdSZHpIbnZx?=
 =?utf-8?B?UE04ZE0xNnlNV2YzOHNKKy9wU1VUNmcxRkJvWUhXc1hwMTNLMHpmcXpyeitJ?=
 =?utf-8?B?RldaSmYzckR3Y2hrMzVHa09hWDc5dHFwaVJnZ3luUy8xNG1vTVJVT2VXYklr?=
 =?utf-8?B?S0J4aTNvVGJ0V2RpdlFWS2tiWU8wTHBRVkhwaTlua2NmZFNzQW90OHRKQlJC?=
 =?utf-8?B?OTQ0amF0a2E4NWpEVjhyUFcvOEZBVmh0T2JaZFV2WURoYVBzMzdHVVhiSUM4?=
 =?utf-8?B?Y0FNVmZNRjJtNG1NVDd0ZGFHQm16M0JXYzU1VDJsNFR2MW1kQnZaV1JPUUpK?=
 =?utf-8?Q?7VLk/lBj9nwi3Cjt+Nuo+ycjg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003b0d29-897d-4f97-f969-08dcccd91f10
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 12:00:08.3623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wh+TBvCuQdS+Ydun2YCHkwffGDpp8+DqSm9NQ9gRfmEu+IuUsopU74QlDZX69TEn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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



On 8/30/24 13:40, Sughosh Ganu wrote:
> 
> The following set of patches are miscellaneous fixes and some
> hardening of the FWU update logic.
> 
> Sughosh Ganu (6):
>    fwu: v2: perform some checks before reading metadata
>    fwu: v2: try reading both copies of metadata
>    fwu: v1: do a version check for the metadata
>    fwu: check all images for transitioning out of Trial State
>    fwu: add dependency checks for selecting FWU metadata version
>    fwu: do not allow capsule processing on exceeding Trial Counter
>      threshold
> 
>   include/fwu.h            | 11 ++++++
>   lib/fwu_updates/Kconfig  |  1 +
>   lib/fwu_updates/fwu.c    | 31 +++++++++++++++-
>   lib/fwu_updates/fwu_v1.c | 18 +++++++--
>   lib/fwu_updates/fwu_v2.c | 80 ++++++++++++++++++++++------------------
>   5 files changed, 99 insertions(+), 42 deletions(-)
> 

I found one more thing.

I did this change

diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
index fbc2067bc12d..dab9530e499c 100644
--- a/tools/mkfwumdata.c
+++ b/tools/mkfwumdata.c
@@ -293,7 +293,7 @@ static void fwu_fill_version_specific_mdata(struct 
fwu_mdata_object *mobj)
         struct fwu_mdata *mdata = mobj->mdata;

         mdata->metadata_size = mobj->size;
-       mdata->desc_offset = sizeof(struct fwu_mdata);
+       mdata->desc_offset = 0x21; sizeof(struct fwu_mdata);

         for (i = 0; i < MAX_BANKS_V2; i++)
                 mdata->bank_state[i] = i < mobj->banks ?


to break desc_offset location. I generated mdata structure and write it to 
primary mdata partition.

This has been spotted by (my debug) which is the reason why I did it.

	if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
		printf("mdata offset is not 0x20\n");
		return false;
	}

But I got one more message below which

mdata offset is not 0x20
Both FWU metadata copies are valid but do not match. Restoring the secondary 
partition from the primary

But this is wrong. 0x21 there is wrong as been detected but sync code detects it 
as correct one and by this break also backup copy.

Thanks,
Michal
