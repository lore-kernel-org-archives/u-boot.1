Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A13C021A9
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 14:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52E9F80C8F;
	Mon, 17 Feb 2025 15:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NSeJdhPH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FEDB80C98; Mon, 17 Feb 2025 15:36:42 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 109928083C
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 15:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOxT8W5fSzmUumd2sLgPAOqjCYv9gtuqvUeRyDIdFukdLoI9IGJoaxbwodTH8Zmf1YeX9a0Y4nwamBP5K3hae6GJPEoBsIrL+FvmKsfe8VPMIvQXYWJFKhhQcCsAPsoD/5nvpO5Y7ZRW4ZheZ02bjXP03+NLvhIcqc8vd0oSUKUzIrnGD1X//+Ki7hJ2g2S+rdKAxg7q6AKMPnXgHROoN9WwJnH3af0BS9uRo7KLp3Wi2vTQhfCpKKKv9FKHJGzrKwd7yTF53AMRTsut3GCQfBU/nHldBP/rSg0mjM+tgZ/Tddtt1atRXNGxv6IktLgN0mf2DJBYrydl19oymwa0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKWLkcFQAkql86iIQ9vxqLw+GV5HnYttXDdw1E/hCYE=;
 b=O8v5JatspWceABj963MLLDeF3PPFjQ6PF2vK+/POdgrbKRfAabd8bSv+wU6Szj4COuDDoAKYLWZxbDdyp/CxmhY+0XmpDDZvIg+G3Z9+8ckz01VToBixDPyGNWLIz5ohg5Tlgzs/Sj7Iot9aHEoBdDbTqbcK5Y1v4pFsSV7d7oh9LuGJLbd2fFjcuHL8fV6frTZ+DAeYwM4Gr5siKg9Qe9Q3TWR8HomR37MSZZ6XDOeKnbeTxfqCAgm3BVGgw/Wp3cteW0VAlG3VjoM2xgxbL8spLnoFqa1mKosetTy15s1h3uc4/oh6yHMpdq3AxjJezupWQy2s4EDMRcxcTjwI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKWLkcFQAkql86iIQ9vxqLw+GV5HnYttXDdw1E/hCYE=;
 b=NSeJdhPHqel6pG1Dl8dqPEBQfgGHmmBc5RLHjQ5hfF7d8DJzTBSwNJeQ3zS/zqc6R4Gxo5um/RVeG6wCij6GeQq1nVjoZTT3N4hejFXekJ2dCmCKriPqiGDzoYZwXMd5Anh8/iRCJs5lJZKQaSYrqU/z7Uk+iW+cw58Y8VaGhTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6410.namprd12.prod.outlook.com (2603:10b6:208:38a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 14:36:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8445.015; Mon, 17 Feb 2025
 14:36:36 +0000
Message-ID: <48e9613c-a1dc-4991-856e-62ef70924fc5@amd.com>
Date: Mon, 17 Feb 2025 15:36:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable mkfwumdata tool for a/b update for Kria
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Srinivas Goud <srinivas.goud@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <641e7759275cfe673ffcee2000a6c34224f0c5d5.1738910629.git.michal.simek@amd.com>
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
In-Reply-To: <641e7759275cfe673ffcee2000a6c34224f0c5d5.1738910629.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0236.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 227c9878-3402-467d-2900-08dd4f607b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anJLVXpaOVVCejE2MUo0cjdKM0VHRHl4ZjBONTdsVXhmelRaMTk1RnhZdVlw?=
 =?utf-8?B?b1EzZDUwcEowZGtlSnBCd0ovc3l4VE8vRU5pcDlBbjVBbDBqYjluYlNlaFJD?=
 =?utf-8?B?RmZwQVpnbVpFaTUyMG9BbDVOMDE5anY5MFVMQ0dibk9wZGg1ZGdQVHRraFRo?=
 =?utf-8?B?STcrSUVFay9SUFNrVEF1QXQyamRyZ2lhUVR3UGhvbXQ5Ti8wMlZoWW9tWXJW?=
 =?utf-8?B?elhhY1lPY3RYR2g2c2Z5MG4rV0FSS2loZ1ZLTk8yTWZ5TW9oNVFrWWplZmtr?=
 =?utf-8?B?T2kzSzVlTTlXU0dJZFZNRnF1MHd0VVV6NlBObUxrLy9Pb1pnMThGd01pcFBz?=
 =?utf-8?B?ZTZRMDZlRWk2TEVQNHZaeWZWTSt6ZUJZaStBTkhsSEM1bVM4bmlOKzNMclhN?=
 =?utf-8?B?VTlWcE54eTNGbWo4bFZZWjdTZVhwQzFFMkpDbFFUeDJuaG5uUTdKeEg3Y3p3?=
 =?utf-8?B?K3BoelB1L2wzbXBUTE55anVReUZycVlKT3JvLzgxRytldlRHRVNSRDIxYjNZ?=
 =?utf-8?B?SVNzRnloWEwxdTVNY2NpV0Nrd0UyS3RoSW1TMllOanRSWDZpa3hqMTdkQVNw?=
 =?utf-8?B?T1hMbzF5azh6QUpSUU1NTS9lN1oxR1ROZlFrSGZMQlpFZDRnR2VJYSs3LzEy?=
 =?utf-8?B?akIrK1gzc1hLNU40SlU1dTdYNVdPdTFNVGphRWkrRkUyTWMwV0ZwQTBEeWhK?=
 =?utf-8?B?bW5EMmZTNkRRUWd2L0ZJRTBoSTNqM3o4MFVPMHZBRmI0VUlMOC9ZQXl3Rm1m?=
 =?utf-8?B?L3F6Y1FsdXJLajdCR3V1NHpYTGxYaHlFL0Y4L3puOXczeG92MXlwRHQvdzJY?=
 =?utf-8?B?TVlyYTFjRnJmK3lJb0JIRUpZTUZ2K3FBUXRYZmhLRVVyeWJJQ01uU1FwR0lt?=
 =?utf-8?B?emM2ZkU0NnlpVWtXSUdOS05Od2Z1UVFNaWtLR0VCb0hab3czUmJySFFsdWFN?=
 =?utf-8?B?Mkc5OUtBbms3WElPSUxLOHpQdkFqOHNUYXdlR1Qwcm1DenVZd1NhTURMMzVo?=
 =?utf-8?B?Mkk0UDhDd1lpeTVFTkN5Y3M4M3dyTCt4NW9EckFGb25mRkZEaGVKUEUwaGN0?=
 =?utf-8?B?RGRKRWY2dHpXekovMnFzS043VHBVdDdUbHl5U1NDaEpoMTJzYVdWVW4xUWp4?=
 =?utf-8?B?OUFKMVpySXdkNExEVEk2dGwzS09ZQTN4Tk5SVXdEcGJocGcyTGU5M0VGOUxN?=
 =?utf-8?B?Y0wzK3ZjT1QyTWNnTmh3OGhvd0FNQkwxM0lHYlBTZTZSNlVsU3pEZU0zTldl?=
 =?utf-8?B?cTRVUGJ1Q21RdFNvdFF2cmx4ZmVySXlHRm9EWmk2c1VYQzAzY0NVTTV4dWdj?=
 =?utf-8?B?bC9IMHIyQWhxRHo2MWhHZHE5THZLazJpMmg4NVFhTmZWaGNrRElSbFFVMXFr?=
 =?utf-8?B?QzBzOTlKelZqb2d3VmVxUjZxeTA4YjYvOFM4ZUJzeG83QVdKRTJxWXJxRUFi?=
 =?utf-8?B?bGRCUDIzbWtxSkJnVC9zQnJBOTBuSWFDL3Q3eWo3aXAzdVV2R1h2SFB0TjBX?=
 =?utf-8?B?cC9IM2dJZEJzWSsvcnBIUllTejVJelNiOHZVQUR2cnpGRGhFSkNWbzdFWlIx?=
 =?utf-8?B?cjZOWXRQWVZqVVdTOTVGOHh5NVVQVGszYjYyUmNKb0hndHczZGFaQ1VubXlB?=
 =?utf-8?B?blBZYkxJNFVKN1AxMVJjcFVVZFZGeXVUVHl6dk13T3FHZ0YvMjg0eU9NK2pY?=
 =?utf-8?B?eDJwVUFnVW9ML2szU1JlNFBTWks2VlpiNkQyNWxLamxlbEZjV3V3UXNpL1lj?=
 =?utf-8?B?Y1RVOTRjODl2dUJFbU9tTitFM2hVUEUxbTcvNnptV0kzbEM4VnBsZ2pNc2Yy?=
 =?utf-8?B?LzF5Ti9kQlE3M1kxQXhXNkxBSlZjcGhJLytxenZvL2ZINXZOUTRkSURncDVi?=
 =?utf-8?Q?tTdzAjffbIYL3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9Ib2hVVVhMUXo2ZnFuZ09iejRqQTA0VWplc3RmbTNYRXZuNUV1aUovdkZF?=
 =?utf-8?B?bStjTThtVVlxNmQ0MmZLZVhwM3NSK3BCM09GMUY5WXlFclVBYnpRekZzdmZY?=
 =?utf-8?B?NTVKZlNyTUwzMWZYb0krQmxnbWE0Z1FJYk0wc3VqZVJVbTdRMldlZkMzTVc2?=
 =?utf-8?B?WndoUUZjZ0FSR2FrVWZNbWp0d1g4ZENxTzRteVBac3pEcm1BaGFtbG5LU01m?=
 =?utf-8?B?ZEYvUXBPRHI5VmRGK1c1cmhDZjM5SDZMRFBHMnQxeFNJeldReS9LZUxreHYw?=
 =?utf-8?B?MGt3MzhYRFYzVDRpRWZSeWRMd1hXVVAyTlFMNXFWYWc0Wmt0OEFIN1ZNR3lH?=
 =?utf-8?B?Um1JVG1CQ2EwRUY4dk5Ucmt2R1VLWHRNMGRDUG95Z0hYNWdVdlVCWU5zQW5z?=
 =?utf-8?B?clFUWlFycUo1T0RDOTBwWUxBZmMvNWpPUjlZaEQ5T2VDdXFBemh1OEZHRG01?=
 =?utf-8?B?eERHbDM1YkZGNHJEQXpPSVRxZ0Q0YmdSbnVRZStkaEZSN2lJa0xzWm45Q1M1?=
 =?utf-8?B?ZkkwdEIyTmV3OURuelBvUXR6UkQvdTlXQ1l0b0o4bjVIaHEyeFdmWnRmZDF0?=
 =?utf-8?B?SVl6UXNZS3dCL0ZkcXlSZFJUNHFqTjUzT1VjWUM4di9EQlBwMGMzcHdJVXZN?=
 =?utf-8?B?bFptMnpJMUYva2NvTlUvb05hMXBadVhEbG9neTF6dDlpaFZGdGQzaFA3NEFP?=
 =?utf-8?B?S1NSRHdScXgvNG9oTTB4aXN2RzM0Z3ZNUzZ0WlRyMHV6NkJxQ04rRm9oTDAr?=
 =?utf-8?B?SFVWMy9vLzRPYUJmOVh5Sm5LWTNBVmVXWjlUbDViZkNTdE51ZHFFMG1YVWlH?=
 =?utf-8?B?a00ycVRlRnR0bnJTM2dFamFxRUpmYWRFMStxQ2tUSEJZWktVV2VRUzlIVE91?=
 =?utf-8?B?Mk9oUTZGckVoZDRsd3pEMjRuR0hncHA3cVJDajk5N0s4RzkxK3M0c0R1VHhC?=
 =?utf-8?B?UHZGMHNqYjZSeDMxUkJZUXB3R0gxVHNBWFdhL1IyVENJbDVUS25aWUR2Yml4?=
 =?utf-8?B?akk4UlBFNm9sS0JlT2Y1by9lekVrZ1ZBWS9KZ2dscENEZVludDlSWnlIQjdN?=
 =?utf-8?B?VXhWRUJKZEdZUFBxNHRqRzRnODBLd1N5NEdOZE1qRFo2R28ySlBhS1lCellv?=
 =?utf-8?B?RVV1WFc2ckIyYW0zbFRkaXloT3FMNnViTGVXMmY5OUdkU2tHS2VoN29PZU1v?=
 =?utf-8?B?VE9RTklmVVY4QWJpTGNDS1FGdXBlZDArWkRRRE16dmhqSGJ6RlNRcE9Rd2hk?=
 =?utf-8?B?bE1vMjdmT1ZLSzdNS1ZtTHdTRmhIYVdRZmtiak1KR3pQSVhaUUNCU0UrcU5J?=
 =?utf-8?B?c2dwODdQZWVTeWRISm41Y3orSCtvd1hKZ0NRSWEzK0ZxR3ZjeCtiSjhzRFlu?=
 =?utf-8?B?Szd0SUgrZ1BtM24zTUFHeW4zS3ZObVMrNVA5eUlWdk9xak9KbkllcEl1Tm1S?=
 =?utf-8?B?MDBBUXY5RHJFbURjTHdYS0tVZjViWE9Nc3VsY091bmc3M21WTWVpS1RUSmR2?=
 =?utf-8?B?NmlRRkR6K1FLZjBhc29laUJnMW5mOW9OQWsyMnFIcFhYMytIKys3TkN2Vm1S?=
 =?utf-8?B?U3RIM085OGNFM1FCQlY2aEZ2K0pYNTZRVUpFUTF3eEw2Ky9ZQ1FXNXVUMStH?=
 =?utf-8?B?ZXUzVmxkdjBSWXR5enQ5LzlTWDR1RmJLWlZFQ0NCVWt5TmQrUmdEYUxBYWJU?=
 =?utf-8?B?RkJzbjJmaUJITlBMTnFZRHJGZXJOL2NCVnhrN0xlS0F1SUgwdDFDWHJuUUdp?=
 =?utf-8?B?QnYwbmFET2hYZEJidmZ1dUlGS251TERZTkZ0UnZubjU0S3JHdkV5TUVRVmpV?=
 =?utf-8?B?eHRQWkdJbnZKWEhhTVgzNzJCeFNEVkFXU3VDbEdObnVyTjNQTC9Fc29RVTVI?=
 =?utf-8?B?WDBZdmZrSm5zaVV0di91OGtkSEF1QVVNS3YwR0xMRjlTaFJPNUJzay9YdURB?=
 =?utf-8?B?U2hMclF2ekRLWDBxRExHQXlkZEE4MmdMYzdFWmpheTRmSHdqaDZMNHlTSlBE?=
 =?utf-8?B?VFEzODVWSVMvOXJtbGk1VXRtR2Q2R0h2V0xLRG5aQ3MzY1ltYzE0ZXBvT2ox?=
 =?utf-8?B?dEtabUo4SnYxak5wUENhcGN0VjVUdTNtbktMdzdad3JYdkk1bEgyUTFWTVJ6?=
 =?utf-8?Q?z/N6pmmlD+BKHgo1STBrnYBCP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227c9878-3402-467d-2900-08dd4f607b32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 14:36:35.9659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6shdEqvOptOC2K5K1S7cQmjkVkLk/hCf0KYrr3sbU3pjvlmlNaYwTymsSQiSyWeI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6410
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



On 2/7/25 07:43, Michal Simek wrote:
> Build mkfwumdata tool by default for building ab mdata structure.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_zynqmp_kria_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index ad46c091c4a6..1e8ec90ff533 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -224,3 +224,4 @@ CONFIG_PANIC_HANG=y
>   CONFIG_MBEDTLS_LIB=y
>   CONFIG_TPM=y
>   CONFIG_SPL_GZIP=y
> +CONFIG_TOOLS_MKFWUMDATA=y

Applied.
M
