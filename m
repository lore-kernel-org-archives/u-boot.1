Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FA6D3C54C
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 06:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3878388995;
	Fri, 18 Oct 2024 08:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oTi0GBGx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08AEE89241; Fri, 18 Oct 2024 08:02:19 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA5888975
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:02:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIW/GvtmRr2tnBrXpZtc+0Eyn1hDFW0UoSG4EVYivW44TKlz0wffMgxmJWzyq8uCSx1miwQ0/j/R9XKu4H6Uhg8/e72KSC7dyZyrWiEXX3VZZjxk4tczSCQxt1VI/1h9oJOC8ngMf+83S0ebiYVfkLvxE6q6z4t9yIe9tN54fdH/R4eWJgQpWn7yKVIAcrCUYK4ePSpwQX3j7sKJMOCBdYZWgnwvXM81JmKm2WU5t/IbxxEylxSXLhSRGkKS47ZoyBjFNpcG5ujvfxDOmexIlx6Z9xsBbRitJspu3LysgIEoWOrRXIgJPLTj+82aUrJApqR+Mlh0jjAa7ZDDsVlDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGNW1lTAAzsML1eDC+Cjc2entE31uz7AKWxV6+vkWUc=;
 b=jo4Q6ESYIaNIe5knz6VxYO29tLD2TbtAPCe1ZVhbzCMzK1MWYOB1uvDlrrcEo3m9hf5TVB5+OxOtubOcP2Y9kun3WCtcvoklwajSZWsrAmIbxoGktgIqE+aiNu8njLnjo7O6IDnXBB32Y1RKWu0Kp0/joPrC+KzZqj7LTjNTsRyLxDc2p2+L71WO2MQI+v7ErES4A9s291HmvUkh6wT+oLL0RyqvvqQ9hDN9occZk1n0XbWV9hfaiaxOCT5zv1W650rmF00bd6I8yofAZ8LNSsDkF7fhmzqIqmCnewlkCNrRxW0Kjn1Tinse/I5yOtgBFM9NP30TU+XUuZK6ICPlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGNW1lTAAzsML1eDC+Cjc2entE31uz7AKWxV6+vkWUc=;
 b=oTi0GBGxKq9SZ0QrORqKu8J3b28B20n36dBLNOtzmli+bqc0r53yKZcErrdOPil7Q/VoOCaN5QAqUpCkuNAj+l0RgPDNDgyXde76+aTGhM2UBx6slZKA/RY1zo5z5IdI/XnsjwJmMkQ4qof/zfLgggDQe3fO1qBkKy25noyNMuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB8261.namprd12.prod.outlook.com (2603:10b6:208:3f7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 06:02:11 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 06:02:10 +0000
Message-ID: <8fb86992-3e3a-465f-aada-0c532e0732e3@amd.com>
Date: Fri, 18 Oct 2024 08:01:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Add option for pointing to external description
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
 <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
 <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
 <CAFLszTjYOoNcMc7MTA-RdR_mKwM+8t=yKRpuYZSfqOvVBA1_PA@mail.gmail.com>
 <a0077320-9c92-44ec-9614-3de1fc1d36a6@amd.com>
 <CAFLszTjt6rrHUzg=evPS5-FyvMrZ1DocwyVc9x1Pq2K9XMokCg@mail.gmail.com>
 <6e7f9046-2e7f-479a-80e1-59e7b20c48f7@amd.com>
 <CAFLszThYOt+MtHbxMLLEy5SK_ZfGJvLbp-azk9WOf57VejyQKA@mail.gmail.com>
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
In-Reply-To: <CAFLszThYOt+MtHbxMLLEy5SK_ZfGJvLbp-azk9WOf57VejyQKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0205.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB8261:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3acab3-7fb7-4a8a-29f6-08dcef3a67a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFpnTUtPeEwzYTIrT1dONCtBOFBab2QwMTlPU09IOXhZSDNpSzJndzJvVVBI?=
 =?utf-8?B?S1JQWVlYOEcrWXVMcHJ1ZlJqbHQ5Wk1YQzYzek1JN1lrdTZIeFVJRjZSNG5r?=
 =?utf-8?B?eUFZWXVkUWdTWlYxcys4K1pYVzZCaWgzSWNHQnhOL2ZlMzRFRG9FUmEvMkpo?=
 =?utf-8?B?Wjc5ZmEzWk05ckZnS1Q3RzFKMlhiN1dVOW1qOEV1a3VWZmtxNkRjTkt2TlFZ?=
 =?utf-8?B?MGI0MEZSNXNaV0FJTVV2OUJlVEliUlphaElTclhVVmtjQmYydHR2S1ErSXNw?=
 =?utf-8?B?R1V0Q3dUbnZZbTRqa3NmbUpYYXlrVHFaWHNPa0ZvUjYwbEJJK2lhOHFiMzhB?=
 =?utf-8?B?clZXWjBjZ2tFSTUvUFFsUmxSaHdpeWRFWFJjcTBqQVUzUk5EZUNYTWovRkNV?=
 =?utf-8?B?aGJzb2pvSjlEM25wMXBMSkUxU3FHQlBiWC84K21xRmFpakI4ejlQMEFGTXpj?=
 =?utf-8?B?Y2RtVGpUTlk2YmYrTktyeElQb2I1QS82c29FUXp5dThCU3ZUZHRVK0wyVlVi?=
 =?utf-8?B?UTM4VDhBZG9icEVHcXFiRk1yaWFZQzR0bWZGdDBObjBpd3NjR1VRNDVQTFZa?=
 =?utf-8?B?UjJsTDh5LzNKNFhlSnR2SkRDbnlrcStiN0ZkRVNxazRyODVYZFhJSEljUWdy?=
 =?utf-8?B?WTAzNU9UcDNSTFN5ZVpuVXpCTjkwQ0tveE9WZXE1N0xTR2xsRkg0REpwVWJh?=
 =?utf-8?B?OXJBdEhQVVMvWlV5S25xemg5cytZOS9YTUYyN3RHanJmUlNKdUI3ODZaWEJE?=
 =?utf-8?B?UE9SbVhjdk1KblB4UVArREJzSnlab1F6TzQxU2tQVlNEakxSRW1SR0tBb3dr?=
 =?utf-8?B?SWpsaUZJVUFhbE14cHRjNTRnNVM1UzM0bTAyRCtCdUtXcW9Zc2luUlptUlhh?=
 =?utf-8?B?Q3l3QUZNT2VONENCelFZYXROOWM2SnFRL3k5Y2drN1FqV243WURtSmIyTmdW?=
 =?utf-8?B?aGo0c1ZmaE5yemIrR0lTeFVPVENuUkJ2MjFvVGQ4dUpEd04vRlE1c000N09s?=
 =?utf-8?B?TGFvTXFWZ0JVR295QXJjVmg1bHUvU3Jscy9ZTWpZKzNxRUlFa3Iva25CMnBx?=
 =?utf-8?B?cHBQY1BLalNkOFFYL28yNFhSUERxYlpMRmlHaHB0MlhTekR4cVBmdjhoRURE?=
 =?utf-8?B?NVlLNjJYcXVZdC8wVVBtSER3MU50alo4V05yM0syOWtLNG9MdGtRNG1nUlZC?=
 =?utf-8?B?RTNPWDhrTEpRbklBSWVKNU4rM0NjaUNnZHlBL24yNDh3MEgrN1J1bHhrUnU1?=
 =?utf-8?B?UjJSSCtHc3U2UVV6aEpWRHJaNUJOMk45QkN2OHdrZVRDa3dFWXY0eUdtZndV?=
 =?utf-8?B?RXBsajlIVzI3alVXaGJrbkZwVUpYa1M3YUdvejI2S0hBMjVlaCt1R1FmSlI0?=
 =?utf-8?B?MzQxRGs4b1pOV0RnL0NxVXJCbEhGTW5zeVZyS1VuK24yTEpnWGhnWkV6VjFo?=
 =?utf-8?B?eHNteFFrbnpEUzMxdUZHODdBcWhDNW8wUGtCWDJRK0tvWXJYY1BtUXdUbzA2?=
 =?utf-8?B?Ly9PU280UFRjMFVkSWRwK0lIVDdHRnhSWDBUOVp5OTB6Y0s0czJMdjBJWTRP?=
 =?utf-8?B?M3BhU2FrcExMV3lMYXhyTE1Ec2NTZWZYL2VMUEIySkZrMXRHUHM4cTU1SGFh?=
 =?utf-8?B?R2NqbSt3a05pKzVGdHFrbVVsOHM2TW9NUDJDUTAzQ0Jsbjk3Y21LTTdhVXI3?=
 =?utf-8?B?b1RlS21tK0lPZGJTVjFLbXZaOGgzVEdqWTJxaVdCdlNMWkdzVEw2ZnIvNS9X?=
 =?utf-8?Q?c83sZh49ToWZwmlmshlswvCEWmw//o3d5+ocLBO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTF2Z2pWdVg2aFJ0YjdTbWd4OXAzSjFERURyK1RRdUdhdWFxdmlVOXdUc2dM?=
 =?utf-8?B?YkZ1Tm81d1RrQVdWOHVlNysvMFRudUUyTnJScitXVXFHT0dadlRKcm4wL21Z?=
 =?utf-8?B?TWk3Rzd0eXRDeEhSN3FjMkZHeGoyNHpqVElQaHVKVncxbHpvdkp3TUpna0Z0?=
 =?utf-8?B?bHlWd2p1VnMrSmN4ZjRVbmZXSExURXZDZ2wrYXJpeTJ1Q0dHZHlocnJWdkoy?=
 =?utf-8?B?Q3V4YWlZT3NXNW1qNnd6VUVQMWppaWwwU0RKSVluK21LQmFrQWFGRXlCUVBt?=
 =?utf-8?B?TklydmpSNEpnUVF0TWlXbXlzZnhHekErNHV2Rk5NN20yYks5NlBSUEJmM0ZI?=
 =?utf-8?B?OXVxaFNpaExISTVYMVpqcjFSM1dMT0FXUHQzRVlsQUV2NmNMTjhjRjRSUjhs?=
 =?utf-8?B?Qk1kSU0wSGpOUmhwdExSTXpzYnRUaVVxWHhFTUEySk5sRkFwMTNPWGVoRXM0?=
 =?utf-8?B?dTc1VHlMRGR5MmFIK3RNWm15WDBPWFI3dTJNRjRvUVhONEgzNi93Qm5VOGVI?=
 =?utf-8?B?bytHcXhJYVBxRDZySCtYUzhnTkxxdzdPWTZxMVZDUUk2U1k3VHBtcGZmNVhL?=
 =?utf-8?B?cW4wT1dxb3pOd1NEN3FvY3VyTXM4N05oa2JFZFV3QWRpNmZxVFliZUw1ZlAr?=
 =?utf-8?B?N0IrSHVYc01LZzlyclBGZVA0NndRS2pZdXIwVmo1cWt5TEVIR3ozYjJxNlBZ?=
 =?utf-8?B?YXFEa3dJTDhYc3NMVUNlaXBBMk9nMnZwR0lKY2twb21RVmpZelEzTGp3TFdX?=
 =?utf-8?B?OEJta1hLbnZZWURqNHFURFJWZ1l5U3Z5VDByMk5wMnBKTWJBRHdMdE5VYkZT?=
 =?utf-8?B?OWJqL0Z3UHBnL3VVOE5EMHJxdG1pQVp0Mmt5RW03Ulk2aVMxTWliWWpCNUhH?=
 =?utf-8?B?NS80WmsvWGtJNzhXbHdtYlpHb09GVXYxdk1ocFFtWnNHalZSSWxDbFA0RjRM?=
 =?utf-8?B?R2drZUc0a3QzSGxCWjJ5aVBlM0hDcDRnR005d09ndkpxMUJRalN6Y25hS1A5?=
 =?utf-8?B?ZnkvTjdRTzhWclVuTGsyakRZL0hFNFpGZHNhMXU0VUZJeDBsZE9qVlRGUHE4?=
 =?utf-8?B?VWZSaE1HKzd0cExUbCsxa0txL0VqZWVLbEVURXNOdU9Kb1dwcG8wcW9MT0Ni?=
 =?utf-8?B?MXpwbkFBelJwZXhkcXJlZ3RrVURKNzhLVXVGK0hkZVdOc1BKNHdCeTJuRDZm?=
 =?utf-8?B?K1RwZ1RQb2luVjFpbW1kcGN2RWd2YlpPUWJ1M3V2bS9iUy9tRk5LSENSSUNZ?=
 =?utf-8?B?RCtqL3BEVGlTKzhTZXE1T25xL2sza1huZUV4ckpRSFYrdmFnaGhDWkJsL0dv?=
 =?utf-8?B?Qm5OVVpwVnpBMWdsdXpKT2xMcTJIRzdFNTZGNlN2cnY5OFdqTEMyTjF0cmlr?=
 =?utf-8?B?bytNYjRRdC9UdzV6N3lnOHYrUTlHalNydUlEY0tESi8xOVFMSWZic1Jpbkcy?=
 =?utf-8?B?WllnOU92QWRRb1VzaitNaGNXZTVRNTYzYWhlNVM3WEdYUGZlaWgyaVJodkRu?=
 =?utf-8?B?ZkJjSUV4ZDg5ZEpVemRtdlo1M2kyQThCeUV6SXBOdXY0UzJpU2NoV2d4UmM4?=
 =?utf-8?B?cGd4QWRDRlRwekxrTEdMQjd6aHZqZndFemw1bit3bUN0eFE1VHNTck5RdG00?=
 =?utf-8?B?dGpUTXJTTzVScTlrWnpHOTN6OGJ0WlVzVVNKeDdielR2LzgxcXBwTUhta0oz?=
 =?utf-8?B?TlJFc0w2S0RoQU5ueTdMNW5UelZWMUpBbGNwWVQyRkVXZWIyUjN2ejdHejg1?=
 =?utf-8?B?TXpESUkxNWExeC9TcVo0WVpFY2NMdFh6K0J0ZlFUd2I2UnZjaUViWEtkajhu?=
 =?utf-8?B?NkRnTzZzRG5INkV3dlJkMGFpYk1HQ3c3QUtETlVrSUl1VGVibWpaQzV0aExq?=
 =?utf-8?B?VGIrSS9sUXoxUm5PQnB0UVpNWjZzTjVsTE5qbCtTRzVLTDNaVFY5blhRZWlh?=
 =?utf-8?B?Nml3VGk1dFVadi9za2NhWkttRzFEU08ydUF6cUNKVFh6aWVabmlVdjJVVURC?=
 =?utf-8?B?Sml3em9DUkJRTlljU2NYYXJ1NnNtekdoRU9iUnNPSndIUk9sZndCbFMwc0Qz?=
 =?utf-8?B?TE9FYjRWYjl5Qnd2NjdNeE00TkhLWVdqcUpmMlpCdWhQdVJCSHNBRnZ2TGpz?=
 =?utf-8?Q?27azVh1bsH1N19beQPhpQiSev?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3acab3-7fb7-4a8a-29f6-08dcef3a67a9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:02:10.8417 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcNe6axeg6GRQwQXNxRo5ANbSqN7DxLK4ygTgjFO+oEQrQ/v6q6+pG9Fy+Awuyjr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8261
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

Hi Simon,

On 10/18/24 01:23, Simon Glass wrote:
> Hi Michal,
> 
> On Wed, 16 Oct 2024 at 00:00, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Hi Simon,
>>
>> On 10/15/24 14:48, Simon Glass wrote:
>>> Hi Michal,
>>>
>>> On Thu, 10 Oct 2024 at 07:03, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 10/9/24 23:14, Simon Glass wrote:
>>>>> Hi Michal,
>>>>>
>>>>> On Wed, 9 Oct 2024 at 07:21, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> On 10/9/24 03:55, Simon Glass wrote:
>>>>>>> Hi Michal,
>>>>>>>
>>>>>>> On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com> wrote:
>>>>>>>>
>>>>>>>> Adding binman node with target images description can be unwanted feature
>>>>>>>> but as of today there is no way to disable it.
>>>>>>>> Also on size constrained systems it is not useful to add binman description
>>>>>>>> to DTB.
>>>>>>>> Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
>>>>>>>> target from DTB for binman itself.
>>>>>>>>
>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>>      Makefile    |  2 +-
>>>>>>>>      lib/Kconfig | 10 ++++++++++
>>>>>>>>      2 files changed, 11 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>
>>>>>>> Doesn't this defeat one of the purposes of Binman, i.e. to document
>>>>>>> images? We do want the .dts to include the image description. What
>>>>>>> sort of problem is this causing?
>>>>>>
>>>>>> We have two boot flows.
>>>>>> The first one (default one) is using Xilinx FSBL for SOM initialization with fit
>>>>>> image (DTBS) + u-boot.elf + tfa.
>>>>>>
>>>>>> The second one is using U-Boot SPL instead of FSBL. This flow is used by
>>>>>> buildroot for example.
>>>>>>
>>>>>> In perfect world I should describe both of these flows. I sent description for
>>>>>> the second as RFC here.
>>>>>> https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com
>>>>>
>>>>> OK I'll take a look.
>>>>>
>>>>>>
>>>>>> but it is also reasonable to describe the first flow but I really don't want
>>>>>> both descriptions ends up in the target image.
>>>>>
>>>>> Why not? Knowing what is in the firmware is one of the goals of Binman.
>>>>
>>>> If this is single binary composition with clear layout then likely fine.
>>>> In our case where we target evaluation boards which can boot out of different
>>>> boot devices it will be more confusing.
>>>> For these I want to generated all images also for testing purpose not only
>>>> images which you will burn to qspi.
>>>>
>>>>>>
>>>>>> The second part is if you look at RFC and how fit-dtb.blob is composed. It is
>>>>>> one DTB + DTBS which are composed from overlays.
>>>>>>
>>>>>> xilinx_zynqmp_kria_defconfig has
>>>>>> CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
>>>>>>
>>>>>> That's why binman node should go to this DTB but because other images are
>>>>>> composed with overlays binman node is spread to all DTBs inside FIT image.
>>>>>>
>>>>>> It means one binman description is in fit-dtb.blob 14 times which is far from
>>>>>> ideal.
>>>>>
>>>>> Yes, but I think what you are saying is that U-Boot doesn't need the
>>>>> description, so you don't need it to appear in the dtbs in the FIT. Is
>>>>> that right?
>>>>
>>>> Yes.
>>>> I know that there is a code around it but as of now I don't want to use any of
>>>> this feature.
>>>>
>>>>> If so, then I think we should add a way to remove it, in Binman,
>>>>> perhaps with a property in the top-level binman image.
>>>>
>>>> Works for me but keep in your mind that for SOM this should be removed from all
>>>> combinations and for me it is easier not to add that description there instead
>>>> of adding it and removing it.
>>>
>>> OK, I think you are saying that the description is repeated in each
>>> .dtb since each is built by U-Boot's build system and then they are
>>> added to the FIT.
>>
>> yep
> 
> OK, got it. I think we should add an way to make the binman node optional.

I expect binman node is optional even today. No binman no means no image generation.

Also I have one more use case where adding binman node can be misleading.
With our FSBL boot flow only u-boot.elf is taken. If binman node in appended dtb 
is there people can think that bootimage was compose by binman but it doesn't 
need to be the case. That's why I want to have freedom and move decision about 
composing images to end users.


>>>
>>> But what is to stop people from not bothering to fill in the binman
>>> description in U-Boot? I worry that vendors will have instructions
>>> like 'build U-Boot with the in-tree devicetree, which has no binman
>>> node, but pass this option to use this other file (not in mainline,
>>> just our special vendor branch), just for Binman's use',
>>>
>>> Where do you plan to keep this other file?
>>
>> In u-boot repo of course. And all configurations which makes sense.
>> And pretty much if vendors wants to hide it they can no matter of this patch.
>> I understand your concern but vendors can do it today.
> 
> So what value are you going to use for BINMAN_EXTERNAL_DTB ? Is there
> a patch for that?

Sorry I see that I didn't include defconfig change. In SOM case it should look 
like this.

CONFIG_BINMAN_EXTERNAL_DTB="arch/arm/dts/zynqmp-som-binman.dtb"

I had it as the part of SPL_FIT_GENERATOR removal.

> Perhaps it should be renamed, since it suggests that
> the file is out of tree.

I am fine with renaming it. Do you have any suggestion?

Thanks,
Michal

