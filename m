Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1688C28B30
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 08:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6894E812D9;
	Mon, 10 Mar 2025 09:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tvg0LOLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027CD81417; Mon, 10 Mar 2025 09:08:16 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D818129F
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5l0Ixvn4AJcB0LmBgA42dpZPR3c+Ti9M9av7K/hm01FeGwUV0fhp6AHe8+AjIA3mSR/X0FWDou4A5D3yvCL648TrVRB1mLJBTNnBIypqheY8txe6plbx5Yyq2nCqGf5bq/bF5cPLQ5Oiv4GxYeSILjAWQWXfrLbTiX5XYye09dvQ5jGI06Pb+HegIAEAPXvuoSxvesp4yo+NEUjLcdnhsaHUPmHKPHQWJUVCmtRBahaM9xVEjQpTlf/fAD+02cfXJLCUbqdlKgjTSKZlRafrD5zUowAgegz1duA89kSe7uJJhNMoAa0/GjUPdLPX/8fhdY3d0oKusaSCrbJd6fkYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7/j+FXkzDkoE5xM/7/1hLj+0qW9L45BlD7zgETKcos=;
 b=w0Sy+Wzx75uqsM+byw0clJwpMIj7smG3Y5cg9wuwItMmXCFzWfbK12HW/yyfUbDkceWOQ5HgIgRZL+3fefeqIC1A6Phwqm2eQwJcroMjn9VfkVRCFOEkah2fLLgoQHS4YNWKomHrw0cFxKkiUsk+k5d8SJ/HovzT2POqkbFo5H8fiIftL/4fh5Pp2aZijR/bhfDfCl5uNasxrM3/nE4Rwlab7al0pUuPbfV5+Jdw6lArnEn2Zl2qhAffWllGrRX905EFbacHlEmL4LBgvAg/CqV/fkfOiUlUvIYOc6Q8TURksQZyaWJGKxlL+okAtGn5mjUftaORlhGUwmLIZ4KWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7/j+FXkzDkoE5xM/7/1hLj+0qW9L45BlD7zgETKcos=;
 b=tvg0LOLXfqnlyhOYZmlkwzjM5zCIQ7Z29pYOU1e/DiOAFk8Xtfx+3x54ApQxVEpR8ZopD38IoS7ybfj68AGW7nCKlW8SFPeDrA1tFizfOK8zm5TwbVohA7D9rrc0OtgGrLkCwhFrL3IAQpb95Qa54rrIx/EXKkFIwpekFwUElsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:08:09 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 08:08:09 +0000
Message-ID: <9501e34c-7339-4fad-9499-ea559aa03abe@amd.com>
Date: Mon, 10 Mar 2025 09:08:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: versal: add firmware access to PMC multi Boot
 mode register
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
References: <20250305134845.3182193-1-prasad.kummari@amd.com>
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
In-Reply-To: <20250305134845.3182193-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0076.namprd02.prod.outlook.com
 (2603:10b6:208:51::17) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: a99cdec9-1511-4030-ac28-08dd5faab202
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWZ0WERqb1g3WnFDZXAzN24yVjJLYlhENFZ2U1NsTHpkbEYzRE0zbHRzWVZF?=
 =?utf-8?B?cGVENHEySzFvNkN5SUN2OXoybVkvUnhlN1crT2gyOU1Dc3pjaFo4aFhhMFhp?=
 =?utf-8?B?cnU4RE9jV2ZWWUtSWEs3UEc1eC9LMDBoTmtqbTRNOW9heUZQQ1poT1pCajlK?=
 =?utf-8?B?Nk9TbTRCREQvMFpySWxDdkJGRDZhNXhwb0NOb004OFh1WTZxMmVtUmxJRDNY?=
 =?utf-8?B?ZGRIT2d4aWZuSEE4MEJmT0dzcjNHZ2cvd0IvdFhlU3F5SHVRYVFBM0tvSE5a?=
 =?utf-8?B?SXlRMlNmSm03MmFkY3ozVnRQUW5xUmN3cnBNRld5b016aGFxWFVyTUhsc2g1?=
 =?utf-8?B?aFN4WHNpVUVLeXkyWkNHb3RuNUFUMk5KbFBLYzFCblhyUEg2U3ZueHpnVHln?=
 =?utf-8?B?TUY2aWNSeERaU2V3SkUzMU90UzhFSFVNTjZUQU9WV3F2OS9sVk1jYTZPc1VR?=
 =?utf-8?B?OUhaRDZIaHhJY3ZpY2IydXFDSy9nb0JQMjBGOVdTd2VTS0RMKzYxOUlRMzV2?=
 =?utf-8?B?WTlKblVQa1RteERaaEZjMS96SlJORFJaeGFGZ0FNbHE1UjdkYXNSYzVLbUtF?=
 =?utf-8?B?em11NEZLYVNxdk1TU2NJUEp3Q1RkSzQyWHhKdHpWb1FuTEhvNzVwNjdDcnJ2?=
 =?utf-8?B?OHF0ZFpCb1ArdGZyUkNZN2dCREhHSHZubzFod2lob0pLa2cxTDJjUEJlQUlN?=
 =?utf-8?B?YVc4VXNlTGY3MUNnblB4VzVQdnpEU1pmNUZMdzlRdWhVdEN6YUFvVjFERWcz?=
 =?utf-8?B?c0pzRFB5c1IwZDFhZVRwWVpwVy9SZzJlUWdPRlBzeVRTYnFQNS9rMUx2Y2ln?=
 =?utf-8?B?Wm5XNGVzcXc4SitONFJ3WkZhK3pGNDZWbHBhQmM5SHdVS0VHcmNTeW9yeHlQ?=
 =?utf-8?B?Q2IwRkxwU3VGbmpjUmo3bktDdXNsOE82LzZEeXpSYVkxakhpYzlZUWh4SE02?=
 =?utf-8?B?YVRhR3dmMURPWndVNFJHSytqdStQa0xremxJK3paMFFFSVZCdXV3a3NZdEF3?=
 =?utf-8?B?VUtwNFpoK000V2Z5SmFrbndHWVRoSFhReC9iY1JxRU1McGQvOHRMSEhOQnJM?=
 =?utf-8?B?ZHBhZUJhdU0zVTdDcGQxQlFtbUw5Ym0wQnN6YmtmVGpPSXdnZkdEUVJFZ1FQ?=
 =?utf-8?B?UGxocU8xVXlMdjlWZm05NVEyWVh2Q1MwSjZjNklBUUVuSDgyS2wxTEFQNjEz?=
 =?utf-8?B?cTBvdTFxTEFjZllmcjgwSlczSkVvSW9zdlJJbzdScExaM2dlcXRUWHBMZyt0?=
 =?utf-8?B?aXJTYUhiZDR5ZlI5OFFXdWVpYTRqTzhDLy9Pbis0em5lUlJlWmtrRmEzM0ZZ?=
 =?utf-8?B?aEYvSWpKTHlFRHBEc2ZLZ3k3cTFRRUxKSUJXa0hoN1dINnZqOTVMYStDS1VE?=
 =?utf-8?B?Z1U5NStqa21uTjBHT3kwT2czTXo2bER5SFo3L0kwTFRBbHZTYkU1UkM5dG9Q?=
 =?utf-8?B?L3hTRTVnZkF2L1pPa01UajJBb0lqVnBsUnhadHFXODZxRDByWkNCSXphN3hi?=
 =?utf-8?B?QTRQUHpBcTVXdnNTV3hyTFJBcVBrWTBSdEhucTRkcERKZWhDNDRHbzZaVm1L?=
 =?utf-8?B?OEdudkRQNXRNQkttbVQyU1NPR3Y0cmRDKzEzT1k1ZzhSNklib2pNVitiRTJV?=
 =?utf-8?B?b2pKS2lLaUR1QlBNa3hEMlJZaWRtZGRyOW43TlRkN3ArZExEWWRGSndSenlv?=
 =?utf-8?B?MjZ1Q1JuRWUrNG1ub2toSGVWQlhIY2NjeEFCdGhKcVUyeG44N2dnWFJRK2NM?=
 =?utf-8?B?VTFZT1d6NjFjUU9VbVFEd1FwTGs0QTJDVVREVHMvaFlYdmsvRi92c00rT0VK?=
 =?utf-8?B?Q1p6NFkxV0xlNmdpR1BML09nUWNZWEdyaEpzZkUxd3NyZ0s5U2c2QmhKb05D?=
 =?utf-8?Q?0Olc1HTTa8RUz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0t4RUdKN2hlMXpzUU1MTzJscFNPb0ZWRW9OVjhCVi9rNW1rc3NyQkJLOWxI?=
 =?utf-8?B?YnI5cHJ1WGduOUFpM3haaGU3Uy9NNk5ETWttZWtveHk3M0dvbHI2YkdHWk9n?=
 =?utf-8?B?T29xczBkUGhjMVIvVGxkN3h0L2FEQXBIcXovZ3Y1NUJ2aHhJOU5oK1BabG9D?=
 =?utf-8?B?eDJMbDJoRnArYnpoRHpRRGo5NTB0Z0t3bERNWDFWNDQzbi9kc0ppSFJmVVlt?=
 =?utf-8?B?bEhucXRNRFlJeWNDV3RZK2FUTmpWbStrMzJFYXB5NEdRb1R2SVFNMVY3WkRt?=
 =?utf-8?B?MWxZVWtTb3N1VWVBNWlPL2VIa1JNeVZVSXE0ZFo1anJadEpGYTZFUnVuT1Nh?=
 =?utf-8?B?ZEJxMmlidEsrYnR3VU9QL3JDK09hVTBmck1hNkx3c0JOOU4zb2hkdm40eDhp?=
 =?utf-8?B?WUlReldJbnZKbFI1amVVcWVIcENDUlpWQWoyZzNYblBRR0F0NGtNanZISjU2?=
 =?utf-8?B?Yk45QUxlRE5Xa2oybjArTTMrVzRlSnd4L25rMitobG51eTdWRTNMVkdvVzhX?=
 =?utf-8?B?dXdneEQxT2ZQbjZXaVNROVE3aDNxU2tKRk1WaVFQeTJjUzlObEZYNmwweGMw?=
 =?utf-8?B?ZVhEV3UwQVBtU0N5TnhFRkRmeEZnalRYaUszK01XTndlSStlWFZ0UzVVc3Bo?=
 =?utf-8?B?SGEwcmVuc2dIMVdYVXRqMUdMTlhpQ1Z3NVp5YVVQSGtLUUdjeitJMy9ZalRz?=
 =?utf-8?B?WitGclBYclhQKzBMVWRtcDI1bk1XZkdYQUNZaGpndkgvMVVCdjl1WE4vMkNJ?=
 =?utf-8?B?ajVjZFBWNlYxWCtiaUx5dEtVdCtXcys0WkpVZHAvYU1LOVRuQ2NGTHAxMzJS?=
 =?utf-8?B?VXZYQnJQWGJNdnJkVTNRUDlzR1ZXNFJSR3IvamwybDEvbCtuYWY3Q1BNZjhw?=
 =?utf-8?B?QlNhd293Sk5ZNFVwaVdXRHRUMVB2YXBlWWN3ZWlnODcwdkJTODJmM1lLR2F5?=
 =?utf-8?B?RkNkY3UyeGxwZlFPaWVOcmlPM1EzblBPNm0vUFhXYVdjQVNXMkFnQ0owOE5T?=
 =?utf-8?B?MzNXYThyN2RIS0p3OFNZSmhLMTBIMzJ6ZENwMGUrdnZOcU1xTXdQWnd0UzEz?=
 =?utf-8?B?SzdDV1NXeEMzYU40WXJVU1hZRlQvT1ZEV25TTm5EbmluN0pJdkc1Wjl4SGtw?=
 =?utf-8?B?Q0ZUSlEvK2RVOERNTFcwYmp0UytwWGlZcHFPM1BWSFNIRHRuVTRiZVFoZExx?=
 =?utf-8?B?RG5DVWRONDk3UGQyeExkVjNuc0FJTndJSVBTYmxKbjNvTVB5b0srejJiVVJZ?=
 =?utf-8?B?bmlwTHZ5ZGZZL3NXd0RiMGtlNCtvTmUrcHd2Z200UzVESXlIQnVDK0k1MHZj?=
 =?utf-8?B?emVHaUFWNDNUdGlDa29SSWRNQnAzd0lhcW0xWDhSMjBmMlArMHVMaHc5a2hD?=
 =?utf-8?B?OERGNG5EcXdJZzF0Y0VCYW9ZSDFYOGF5dFRYU2lkUktCcE9CWFIwVVBLTzlC?=
 =?utf-8?B?OWFQUjVpTmYyTzE0SElmS2VUS1cybEo5NHg5L085c1VrbXZ2UU82VUdRdDdN?=
 =?utf-8?B?TjVPN3VuUDQ4a2dCZDJlTktjdDl5bm1sOHNpRGpaKzVMK2hVWWc2eXhZRVYr?=
 =?utf-8?B?OFBtMEl2czY3YlRyVlc0TkNPakVDeWdMc3RwTWRGZ0tFbVRrd1lnZ2NzbFZx?=
 =?utf-8?B?WUhLUzdTSGNIUURsVlFDcXNrSGxUdHdYYkVhZk5ndkZFVlkvUHpsN1g1dlZZ?=
 =?utf-8?B?SEUxQ0NhZTdYcXJSQ2tQODRScGlZcWFuT05MK1JaSWkyT2xLTXFIRC9aWW5F?=
 =?utf-8?B?Y1h4T2pySXNhRUVGQitQK1BQZTYwREhXa24vanowK280enU1VStlRjBscGxv?=
 =?utf-8?B?VXRzVFdzSko4SDZTcFMvWC9LVXNEUmgvZ0crOFlWMExuVGI2Rlk0ZFRtekRM?=
 =?utf-8?B?Q3N5UVFkVURkb2hJSkhaUHZIOSs2TmUveXhhVUg2WkhGTGtuOUk4SmYzSHFj?=
 =?utf-8?B?a1luVnVGTERiWDltYkQ0dnZEbWlFZmZUd0pCY3gyQWR6TFQxYlBYbVEzUWFR?=
 =?utf-8?B?SlFRYTZocnZNSWhZQTFYNG0wZkllZ1pzMERHRHBsa1dwbDlyaVF2Zlh0RGZt?=
 =?utf-8?B?QTg0UnB3U3QyZzFiSzA3emEzV081MXc1eml3VERzRlgzOWc4Q1RzQkdZQms0?=
 =?utf-8?Q?JgwghUEc2HR1KWBRn2O8vYfa9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99cdec9-1511-4030-ac28-08dd5faab202
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:08:09.3409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sVA5bG/8M3Gq5tvmeYV3cZQ5GHAmwQjGuQx2l3FOdcoSL20fGWslShNhk82nqc4k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
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



On 3/5/25 14:48, Prasad Kummari wrote:
> Added extended support for retrieving the PMC muti boot mode
> register via the firmware interface, which is preferred when
> U-Boot runs in EL2 and cannot directly access PMC registers
> via raw reads. Ideally, all secure registers should be accessed
> via xilinx_pm_request(). Introduced the secure
> zynqmp_pm_get_pmc_multi_boot_reg() call, which uses
> xilinx_pm_request() to read the PMC multi boot mode register.
> 
> BootROM increments the MultiBoot register (PMC_MULTI_BOOT) read
> address offset by 32 KB and retries. For SD and eMMC boot modes,
> it can search up to 8191 FAT files for the identification string.
> A 13-bit mask (0x1FFF) is applied to PMC_MULTI_BOOT_MASK to obtain
> the correct values in BootROM.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>   arch/arm/mach-versal/include/mach/hardware.h |  2 ++
>   board/xilinx/versal/board.c                  |  8 ++++++-
>   drivers/firmware/firmware-zynqmp.c           | 23 ++++++++++++++++++++
>   include/zynqmp_firmware.h                    |  4 ++++
>   4 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-versal/include/mach/hardware.h b/arch/arm/mach-versal/include/mach/hardware.h
> index 9d1c2f0dcfc..b5f80a8e3a9 100644
> --- a/arch/arm/mach-versal/include/mach/hardware.h
> +++ b/arch/arm/mach-versal/include/mach/hardware.h
> @@ -87,6 +87,8 @@ struct crp_regs {
>   #define JTAG_MODE	0x00000000
>   #define BOOT_MODE_USE_ALT	0x100
>   #define BOOT_MODE_ALT_SHIFT	12
> +#define PMC_MULTI_BOOT_REG	0xF1110004
> +#define PMC_MULTI_BOOT_MASK	0x1FFF
>   
>   #define FLASH_RESET_GPIO	0xc
>   #define WPROT_CRP	0xF126001C
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index 3046fd7e5f0..6c4a2f5ead6 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -60,12 +60,18 @@ static u8 versal_get_bootmode(void)
>   static u32 versal_multi_boot(void)
>   {
>   	u8 bootmode = versal_get_bootmode();
> +	u32 reg = 0;
>   
>   	/* Mostly workaround for QEMU CI pipeline */
>   	if (bootmode == JTAG_MODE)
>   		return 0;
>   
> -	return readl(0xF1110004);
> +	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3)
> +		reg = zynqmp_pm_get_pmc_multi_boot_reg();
> +	else
> +		reg = readl(PMC_MULTI_BOOT_REG);
> +
> +	return reg & PMC_MULTI_BOOT_MASK;
>   }
>   
>   int board_init(void)
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index 2adc132b4cc..584397ba29a 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -218,6 +218,29 @@ u32 zynqmp_pm_get_bootmode_reg(void)
>   	return ret_payload[1];
>   }
>   
> +u32 zynqmp_pm_get_pmc_multi_boot_reg(void)
> +{
> +	int ret;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_READ_REG);
> +	if (ret) {
> +		printf("%s: IOCTL_READ_REG is not supported failed with error code: %d\n"
> +		       , __func__, ret);
> +		return 0;
> +	}
> +
> +	ret = xilinx_pm_request(PM_IOCTL, PM_REG_PMC_GLOBAL_NODE, IOCTL_READ_REG,
> +				PMC_MULTI_BOOT_MODE_REG_OFFSET, 0, ret_payload);
> +	if (ret) {
> +		printf("%s: node 0x%x: get_bootmode 0x%x failed\n",
> +		       __func__, PM_REG_PMC_GLOBAL_NODE, PMC_MULTI_BOOT_MODE_REG_OFFSET);
> +		return 0;
> +	}
> +
> +	return ret_payload[1];
> +}
> +
>   int zynqmp_pm_feature(const u32 api_id)
>   {
>   	int ret;
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index e7275f72fac..5474f66078c 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -458,6 +458,7 @@ int zynqmp_mmio_read(const u32 address, u32 *value);
>   int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
>   int zynqmp_pm_feature(const u32 api_id);
>   u32 zynqmp_pm_get_bootmode_reg(void);
> +u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
>   
>   /* Type of Config Object */
>   #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U
> @@ -504,4 +505,7 @@ struct zynqmp_ipi_msg {
>   #define CRP_BOOT_MODE_REG_NODE		0x30000001
>   #define CRP_BOOT_MODE_REG_OFFSET	0x200
>   
> +#define PM_REG_PMC_GLOBAL_NODE	0x30000004
> +#define PMC_MULTI_BOOT_MODE_REG_OFFSET	0x4
> +
>   #endif /* _ZYNQMP_FIRMWARE_H_ */

Applied.
M
