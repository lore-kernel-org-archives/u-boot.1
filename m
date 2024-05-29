Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC0EC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 06:03:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D1E88511;
	Wed, 29 May 2024 08:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L71rvBNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA0288554; Wed, 29 May 2024 08:03:45 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E05883A0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 08:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3/SyeJzgIR5Y9K+Gh224IVgWYD2vmrVOvREaY7DvU3gdl23TOms1kiZvZZg5g9B2WbfJrkpUCZTHy6RSHAk4QQik8ScOYNHflwXMS36O/rADqLLZCHkjBixM+KvPnUJF/BR6A5D1Lt7z2KiFR2OuHta026Ax1l9oihNOSh3PdI8P6p3RjFeN/xzOaUsjBDCUeDB3gPpS7zAMaeLmeFWdXMCCsLJQqg8Z5b3whMBGTDH1YfqPstKxBLCivcuiUdHJ5n4C3uDb+AV56U94GtC7EfrB3Nx7CWeaIBY5219lzrTy3GSA81IZsf6dF76bQbg9MYddl9ziwnPm8qSDYoqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoZ23+uokwRNyDzbMZ+6rVRtt7vB0SRlqQ2ymFRXXik=;
 b=EliiK75MzOQKv1DN6YFfqWQa738R7AK9wcIh1sKKCPFlYPfVnuiScRrQSyM3sUmS3W9xjw/NWOUYkrLWdkiSzp//UFylhSTmB/wvE6p0sjv3gB3Tl0h9oqBnuslP6oKukP4inJ0p7GHFoZkpOHqtcKt6IEBqWd6f1aHG4deimCqlPrUsLkmn6U+T/28KvaVmeaqKBVxqWQF0VLKgiO77zOVGXOhRe/9UWx7iJ7vSfWqX6Q5Lfv6v5hjXZz8zx26LCRfNw7zG1GRzGU3/O22NVnrFUVMtbXjI0spIMms+mYrIOhWflauaNw/Hts5i+CIqfa1hfLXIIa9xVe7CiavcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoZ23+uokwRNyDzbMZ+6rVRtt7vB0SRlqQ2ymFRXXik=;
 b=L71rvBNeFVaTZNena46ihiJCspTZ/6iPpmVLCpjbul4tnMw4pWS7hCAGyh5dpr3LsIRlRGDGBNw1//gHemFAFWMdXUx+ZxLK055AoD8WxYZAf+pG29m9vSSS0z/r/2Hohg6HOdDycmhfyvNkWvMzcV6BEq9cdOw+pxHRIGR0Ouc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 06:03:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 06:03:39 +0000
Message-ID: <978a49db-4031-4f01-9be5-ff873948eef8@amd.com>
Date: Wed, 29 May 2024 08:03:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: Allow multiboot environment write even in
 saved environment
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240528143652.64489-1-kory.maincent@bootlin.com>
 <a7b20716-669f-4e52-88e6-426f5304c5bb@amd.com>
 <20240528171117.2986dacb@kmaincent-XPS-13-7390>
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
In-Reply-To: <20240528171117.2986dacb@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0035.eurprd02.prod.outlook.com
 (2603:10a6:803:14::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c573b6-bc00-422c-edd8-08dc7fa51619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlN3eCtWVDVGZnpOall1Vml0VTRYVnA2anVqc21xNnBCV0EzVU5TUHhWRkN1?=
 =?utf-8?B?aWhsbURwc0IyNzVOUDZoZFpQK2ZiczdBZFE1SW9WNnJPa3lmZlkzOCtRTTQy?=
 =?utf-8?B?TkQxa2FZb21ONXA3ZVZDL0FzOEZjYk9HTHRQZ0lxdHRqK3AwTS9qZjFoamJ0?=
 =?utf-8?B?Wjk1c3NpUW5vYU1nbDJWRUozV2JpOS9EOS9FSS9UazdmM1JPZHZ0ZVZVTGsv?=
 =?utf-8?B?MmhVaUhUWTM0Wk14ZTJLb3VMamk3VVdLYmZUOTZ2eDRKWkU3SFQ4VmN4c1Ja?=
 =?utf-8?B?TUJqTTZZMEZoYnhDdkRZamNoT0srRktFZkphRllHb0VnSlJBZ2FEVXB0a0gw?=
 =?utf-8?B?dldURE02dHlQSlF5YWwybUpyRVVQM1UwNUVXQzcvaUxhMHNlMVlpc2tIUXA4?=
 =?utf-8?B?M1BxK2taeldJK3ErSFlmbjJrT205THd1cWx4MlhlZ09BS1M0TllQcmpLeVlG?=
 =?utf-8?B?OGY1emVLWUJwWnZ1ek9IcEI3bWd5ZGdTTEFLL3B2MzlmdE1TV3RaOGZsLzlQ?=
 =?utf-8?B?VHF1b0Zqemx0ZkVNSUJpVDZ3aWpHV0NOOU0yYWdVMStvMllJNXd3WnRvUisw?=
 =?utf-8?B?d2NMdjhaQUkzdmZLWHFrR3lJQ0tRR3BKa3hWZEtncDVIYlFJbHlaNHBiME9o?=
 =?utf-8?B?RzljY1BGUHpKbHQ5ZCtBdCs5dnBtVCtydDdwNkJZb21tVnVSUEJ1bjdVb0F1?=
 =?utf-8?B?amtrOGIzL1NPak94OStpaDlaNTdmVmFPR3hvOWZyTWdmcmNFd29vYmcwWTE3?=
 =?utf-8?B?VXVvbW5OeEFnQTNhdkpGWm5XbVVhMFJCVEFkMktvU3hNU1d2cCs3YzdEeFhR?=
 =?utf-8?B?djB2Q2RYOFIvZ0oyUm5oSml2eWgyVzRNajlGZC81RDFQWjFHUkxxbkk0QjNw?=
 =?utf-8?B?L0RRRUdXb3pSdEcrZ3ZMdFo2ajFTbGRJeWdFOG1tRXlDRWZZVmc2NG5NTVpm?=
 =?utf-8?B?RDl6SXVsaWpYN3RTeU1mUXUzaklDaWRsY3hYODhUT0pqRnBEWlZFTW5mejJD?=
 =?utf-8?B?dko5QVJaS3pweHF3UmR3K1FIVVQySGVDYWwwVlhOQy9Ha09UOUxJMzNxSUxX?=
 =?utf-8?B?TnZmQzVRSlBiZ0JsVFFDMVZDNzhTVGxPOFBkcDc1VExVcDA1dThSNkp2SWVn?=
 =?utf-8?B?TkpVbGNsR1NSRXQ5Nm5QTEVvZ1Jvc2lDbEFmcVg5RzNrajdaZTNMK3R0eUN2?=
 =?utf-8?B?cHE1ekIzdE5KTkZ2MytaL3cvZytnYVk0R3UrRkVxaG00VnhVWUdtZHZrRDVv?=
 =?utf-8?B?dTBnTWNuS2lqdTkrQjdYVHc4a2NJSWV4cjk0SFptSE1FdmtTL3l3M2Z4YzRl?=
 =?utf-8?B?MmZoN1RxYTRSTnhBbXdHK09xc2xEZ0wrbGJOa3hDQ2JjZ1lDV3ltUVdJYTk4?=
 =?utf-8?B?cGFUVk5CQU96SUl3RXB0bVJiZnU4L3IvMElTQklCNmJwcGxqWnRzdjJucm1R?=
 =?utf-8?B?ZjVDNWpKcWR4amFVc0gyeEZSWXpGRWxKUW5QditxS3NBVmg5VWpJNW1kMk5P?=
 =?utf-8?B?NDhGZjRpYyt0aC9TTlVBMlRncmR4NGQzSVNpNEZJTkwxSXN6dHVjRGp4dytP?=
 =?utf-8?B?RC9mMmtPSCs2ZEUxR2lTTHJSMVZleDRFRWVudGNjMXNad1VyOS9qNWJXRVlt?=
 =?utf-8?B?ZkkveVVNb0ZoT3JLWDZTZzNTVXVHWTNybmsveTZ3QWQxbVlrcXZOSmdtU2xF?=
 =?utf-8?B?cGs1U01zWUh2YUp2TFgrbW9xZ3JiVmxVSm5aWktoTVBUQjJIRis2QzR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFBZWTQ2VWx6eDllSkhuRWNRa1lreGV1SC80UzE2T2UwTS9VaEovZlB4Q29N?=
 =?utf-8?B?LzZQbVV5dU1SMTgremdMS0ZlOXVaZFNEcDNoMlNWNjMxRHFQMS96ZlNvcmxC?=
 =?utf-8?B?SkxtdFA3RzBqYkVaQ1FpVGRuOXA0SURxTlArcnBGb0dXWjVZanRzdHh2UXZH?=
 =?utf-8?B?eDFHVE1lN2h4RElON1V2ekVMYmtwMTFjMkJjT3pVK1RHQkR4YysrZExSZ2dp?=
 =?utf-8?B?K0pWRTNFTE1uL3liVHp2QUd1WUFXc2tmeVVxZG44NGNGMlVlcG1iTTVlUnht?=
 =?utf-8?B?UjJYdFYrZlFMVlRtQ0d4NnY1ME1ucmpGUS9hTitITStUNlJyKzVYSjNhK2do?=
 =?utf-8?B?SW0xL2QwVmQ0VGJtd0xXSEZyYzNFVzRvZFErS2diYW4xeHI4TmhPY3pKL25H?=
 =?utf-8?B?Y1dMN1pDdG45MW5GL1QxQmRLR0FMbkhGbG9Yd29pNlVuQmJHQzVhNEtxdEhX?=
 =?utf-8?B?Z002b1RGMU4vVHlrSWFMTVBJTDVmektkVzR1OStVOW1oK1FhT2RoMzl3Mno1?=
 =?utf-8?B?cUFyM3lFVUN1QWpuU0I1dVNra01rUkdmMnA1dGg1cUJwTHFQN3FqTTg0TTdn?=
 =?utf-8?B?VFRlcWdCbUlyOC9VRFQwMUxxdk5TbXNEQTJzMWhwMmpUZGtocVNuMDNMTVBJ?=
 =?utf-8?B?S0JOTkhDRkltQk1nakxTZjJnTFpvZTRuUk4vbmlzQ1ROTUVueGY3U01nNDRG?=
 =?utf-8?B?S2VPOXVCS05obFVVRFpWVDNlOUFhaTYvVGRMczRTQ0YzeCtZNTFoN2NYNDZZ?=
 =?utf-8?B?MWhERDZkRHVpWGpyT1F3Rmd2L3EwREZRNHowOWk5OUpyVHB2Rm9VUVZqeHpJ?=
 =?utf-8?B?QTlqK1NNdU1MSkI1TmVGZWsyNU9ud2E3RU9JeUYzMmhqZDF1eEN5ZTNvb2Zh?=
 =?utf-8?B?Rkcvei9xRmw2SHdJQzlHZGNKaFBIVXpxczkrWWs0V1lsK01pM1kxcHJpOHpV?=
 =?utf-8?B?SU5iSGViYnN6cHcxY2FFT1N6T2lNb240UFQxRGpZYWJZa25aVk14aTlrd2Ns?=
 =?utf-8?B?Ym4vTEdzWnU4SC8wQm1QMlFiSHAxOUo0L1crTnpPWXNoR3NJT2M2ampydzdz?=
 =?utf-8?B?MVNBd0FDRGhsWm95a296S1U1ckdEOWxrR1ljT1Y1Vi8wYklRZDJOV3dMcnlv?=
 =?utf-8?B?ZXR5WkFYTGdUaXVvNy9jWGZTaTdBNjB4KzFsM21JVTRaM29HRWsxUHUvQTZp?=
 =?utf-8?B?Y0UvbU9vRVRFcUdveWFUQlcyTlBPaGR2amxTTWZQTXlIcU5iQnZsZ1BJaFpz?=
 =?utf-8?B?bXE5Mkt5YmFZWGI4VUdBa0pmWjBXY2N2VkxDREFSL3hZdXNXY1pUd3MyZFVS?=
 =?utf-8?B?bytDL0RCMDZVd3IwNHdKWGNhVGhVNSt5QUVNdExHV3lQU2FEZTBRSWFGbE8r?=
 =?utf-8?B?NDlIaTRHdmlXZUh0SFJCYytkS3ZENXlsKzdIdUlGNi83U0owdzZtTTBYZTRD?=
 =?utf-8?B?OStCRWQyaFRRVzBoT2VLOGRod0owbjR6SmNxKzNUdWFGMTZFY0cyb2dOb0Yy?=
 =?utf-8?B?YzZqRHByUU5SU0RabHNFSkNhN0JBSDA2N1Y4SlcrSEY5QXJoZHJ5TG5uelZY?=
 =?utf-8?B?ZnVQWTBub1RWWnA3V01kVko3TmlxcGJZbjJ0cGsvL29LVmlMc09lUloxamFU?=
 =?utf-8?B?TFhrQkZhcHVFSFZFcFlac1NKL3Y2L3BLZFo2b3NEU0NrbXk0NlhUNWlKdE5u?=
 =?utf-8?B?dmV0OHM5TnVEZDFyUWNiWHkrSklxM2tNNU1sVUFQWUpsZ014OTZsYVBEM2sz?=
 =?utf-8?B?cG5Hc1U0ZXI1cFZVa3lEcS9CWGhNaEtoRmJhcURBcGpJQTJETjZWREozYmts?=
 =?utf-8?B?U0ZoWHJMdHF1V0o3aU5mTmxJYlFsTHZNWnl2enlyWkU5VTBiNTZoUjRId0hH?=
 =?utf-8?B?NjVUS3NBWXNsamZ5ZlBkZm5KRFl5WUJBTmtDbDJtd2hGdm1oa3JhUUd2Wk1a?=
 =?utf-8?B?ZGFDeUd5YnNlc3NlNHA4UXlCWGJNcHA4UmpQTWxySFhXSk53ZEhkQ3ZJMEVP?=
 =?utf-8?B?ZjA0bi90UEtwYXVLNTczSEdyNjJ6aTRXM3ZqVVFzYXgxTy9LaHkyMDNUdWpJ?=
 =?utf-8?B?RW1WdEtkTmtyUXo2WGVjYzQyTTYzR0JhM2ZFUThKcTV1c0t3anRhdXpJUUFy?=
 =?utf-8?Q?5l9cQP5zNu2kbag8h9ivSSbQE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c573b6-bc00-422c-edd8-08dc7fa51619
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 06:03:39.9369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTY9BJgzSIVGJRqmbHCLJbnuUfEGqL2NcSKbvLTfMjPxc72x3HvajHH5/JlTW77i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600
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



On 5/28/24 17:11, Kory Maincent wrote:
> On Tue, 28 May 2024 16:53:42 +0200
> Michal Simek <michal.simek@amd.com> wrote:
> 
>> On 5/28/24 16:36, Kory Maincent wrote:
>>> Once the environment was saved, we could not retrieve information about
>>
>> nit: use imperative mood.
> 
> Ah indeed.
> 
>>
>>> the multiboot image used. When dealing with firmware updates, this
>>> information is necessary alongside the saved environment.
>>
>> what exactly are you trying to do?
> 
> Retrieving the multiboot information to know which boot000x.bin image we have
> booted. This would allow to check the boot status of a firmware update.
> 
>>> Move the multiboot environment set operation before the saved environment
>>> check to ensure this information is always available.
>>
>> that make sense.
>>
>>>
>>> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
>>> ---
>>>    board/xilinx/zynqmp/zynqmp.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
>>> index f370fb7347a..16292ed1c7e 100644
>>> --- a/board/xilinx/zynqmp/zynqmp.c
>>> +++ b/board/xilinx/zynqmp/zynqmp.c
>>> @@ -519,6 +519,10 @@ int board_late_init(void)
>>>    	usb_ether_init();
>>>    #endif
>>>    
>>> +	multiboot = multi_boot();
>>> +	if (multiboot >= 0)
>>
>> likely make sense to remove this check to because you want to have even
>> multiboot=0 too.
> 
> I don't understand, this check is >= so it supports multiboot=0.

Sorry my fault. You are right. It was there for catching the fault.

Thanks,
Michal
