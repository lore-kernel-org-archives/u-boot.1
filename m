Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65307C27C44
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55358840F;
	Wed, 29 May 2024 16:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gfovYSJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7991F883BA; Wed, 29 May 2024 16:31:25 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE958840F
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLRJ127CYuWkbYftZuoHUGIWLz1fqq+fTXg2jTJzY+cHZvvo0YLNRGonQlWxJVOCzNi/BU6VlDSGqs0QAniBzmAM+NCzenyJBvf5Ofoi3PNkf3nYKa3pSxUtOLzIbu+P+OFy53PGogbpo4h8EUuhIm/eJ/qM9RG0HHVnkXT7Fg95Npy+faAT57fIy8jWCxq1yBlRuLNCBsjYsf0sCKwRYJ2JgzRiWbLMI+SLwM+Yh519IExg6ZHuTKkmqL+6aMshHcaJMPoHz17tkbLmAP1HGiZS3y4bJ/tekPO0JgEkzkG62KKC9qsTgkrdsjGxELj5yParNMUhxd9pZQz0avX+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyeJeEV55A6/SOgVDc/ezF31X9DpspP6k/mJ2bjHST0=;
 b=nx3S6VnCvtq9Fc2sRU/ekKLLmacg1nEKx/+BNmvS4ihXkn2WYgBdLemZyU0uKyGb3Sv5PCZxWkSGxa5lJNMrk7iEF7CZc9uWthegKJU/nQyo89BtIYqj+3EhkTv8CSFRuLHT6HGxN/mcZn22V1umxyerKVWFSDBQe7J96yWdl9apBnhC5WuWazBnnkbpDhx6Kmo/cD1gp+W101B0COsIppiaS9By0ZdHLOotp7gTU6OLQtz5euPVUNQWgWvs9iuveGCF8DC3uwecg9LhtT6AzMG/13AvWwAToy6ZoYaOa7Yl7aw8+X4O+Z1+rJ1Lc1ZLFpnqtH6iG1hS+XFJbC785w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyeJeEV55A6/SOgVDc/ezF31X9DpspP6k/mJ2bjHST0=;
 b=gfovYSJxfNC+xCLowSqiYoeh7NM8BwCz6s3qiOHmKd8p4E4ovhcde+Hle4wQRRPX0CPW6ngXp5cgviDqTYaY0SZQTqYmB5ii7aSO6dTneaEkGuC+x+QvOlh8+nLUx6+sTNaVyftC1BOu6it7AI+hzELBDj1ccGcKXOiu3sqjowI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 14:31:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 14:31:20 +0000
Message-ID: <95e3101f-3026-4459-94db-38ae58c4e66f@amd.com>
Date: Wed, 29 May 2024 16:31:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Add eFuse access for ZynqMP
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
References: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
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
In-Reply-To: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0210.eurprd08.prod.outlook.com
 (2603:10a6:802:15::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: d798e11c-c926-45f7-d8eb-08dc7fec01fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWlrWnJ4VXlpTGxpVUQrQ2hwTTFNMEsxTjU4NzRna2RVZHdKNzZxc2NrSmEx?=
 =?utf-8?B?RFBBVzZ0dlJRdTkrSFJhWGI0RDB6RHVJY1dreHVHTVZzQlBmaktwU3lWMnR4?=
 =?utf-8?B?WjJacHQvZktXeGoxTGF1SjYwcFpMY2VLcHpveEphZDBVQjhMWmQyY3kyK1Nk?=
 =?utf-8?B?ckpabGM1NHQ1SFZnUGd1STNpcnBtVXE4aUZjL2N3NXpnajNCTkxoMDBPakJk?=
 =?utf-8?B?SUVoMlh2RWZpaFU5WGsxTzdqR0lNb1AwdTRpWmh6b1pTK3MxbG9MRGRJcGUx?=
 =?utf-8?B?UkIyeUh1QXU0SjFIcWlVL1lBZWNkRmxMOCtleUk2RWZqeGh4d25PNE5LU1d3?=
 =?utf-8?B?RFREYURvQnlvU21lQ0NFQjBCcVlRWGdKU3diQlJSbUJjS3FIajhvSk1rSFYw?=
 =?utf-8?B?QXVMQ3g4djlKT3NIbkRJaGlwaUI5a09yUFg0MzJxdVlyYkxrekJGa0xoYUI1?=
 =?utf-8?B?Y05jV1NvRXNuRjFVaXJzNXRqanpJUCt6ZXdVK1lsRTJDMGdhZmY4MmlkV0Zk?=
 =?utf-8?B?OFV1T2tZaTl1aVFNbGFDTkNUNHpQNkFLR0tqYnd6ZjE0WlFYeTFEbzNtN0tp?=
 =?utf-8?B?cDdlZ0JvY21xb0tqdW1NMEU2YVdTeXpzK0dOY09OU2xuR3I1QWY4Z0dXQkdj?=
 =?utf-8?B?NkhmdU1xL3RBcC9EdTF1aFBJWldOWXY2YnN3MXl3a3NVZTNaalhpZ0lLVW5E?=
 =?utf-8?B?Z3BpbnlnK3psdElxS0xMLzV6M21GNnpiZXZ5ZytIMjBhdVZWeVlqcG5HczN1?=
 =?utf-8?B?TlowajExbmRMWll4dzkzUDZjSXA1czlYVjk0dGpiSjUxS2xValRmZ1dnVjUz?=
 =?utf-8?B?NW1yOVBKa3NrS3lBNWZQYWlWZEZ5dXhyclNXZFppcHVmK1lTeUxEQmFNU1BE?=
 =?utf-8?B?bWJYZmw0bk94OFNYakZTYzR5VjhwL3dSdWhvNU5IenJVeFYrUi9QMFlicmpw?=
 =?utf-8?B?bVAzMjgxSGh6bGtBeTdRWTR4cTBBemp2M2s3UkMyTWg4eElEMWgwMWJEb1Z3?=
 =?utf-8?B?YnI3RG1kMk93OGZmL29oY1RvejIzYzdON01UOEpnZStwVTJTcTNsdDR3Q0h6?=
 =?utf-8?B?d0o3Mzk5K244UTZmT0ZOcHZ1RWZENXpsS2tZL3NkM3plQmp1Y2dCOWNOeDdS?=
 =?utf-8?B?Ky9RWm5kVjZpZXRDb2tPM3hGMlBKN2JFaFJVb050bkpUMVpVVS9qOHdLN1RG?=
 =?utf-8?B?dk1MQWk4cVhWNjNMMzJGVzZmZHg3ZGdtbXNJaFF6S20xN0E5cDJtaDd5V0pk?=
 =?utf-8?B?WVNCNVdMc0RtbFJLQjdVdXB6amx0UnRnUzczbFRkeGZTQzZQZW8ydUlXengv?=
 =?utf-8?B?ckdkOVVabmZsZTJTUDZsTVB6NEcvQ3RsUnQxUzNscGZlUTdQY3RDVVFxRHFL?=
 =?utf-8?B?cDhRcVZYSUdGTmFHcWV6TmVNQjFxdzV0NVNYR3RnYVU4UEoxVnhVNmJCdDVz?=
 =?utf-8?B?WC91VEp3eDY3bUFIM3IyTVpLdllJZTBwM3BWamduM3pIdTljNmpWRGJ5Tlo4?=
 =?utf-8?B?Z0NPQThRU29FdXRkdGpCZU5YbW15TWNyRGs3a01lTHdPRndRME4veWNDZlk3?=
 =?utf-8?B?N2hnTFAvRkRqa0gwYVp3bFM2c2dpeHcySlo5cGpjSzVkNk1hQi9Td0ptd0JU?=
 =?utf-8?B?SzZ2SkpvTldPWXAweUhOcGRFVUNXcXlJTTdyanlsVlFNZGhiMlhEMVlFOGpN?=
 =?utf-8?B?elIxWDFDbDArUnZ3S0cySHM2YzhWd3lsTVB6VkRVbnIraUNDeEErb3NBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OE9qVWZCUHltSC83L0NuQTFVbDhJU2RwUU04ajl0anpKZVQvQjhlTHlPckMr?=
 =?utf-8?B?QkJsTEhLU2dLbG9WdW9VVTVwR056NUFRbElkMWl3NnN2SGZJT2lsbTJ6Z2hN?=
 =?utf-8?B?NS9rVjhqNTRaQ1dwanp2akFhVXlhVXZtbFBxeHJEdG9keHBybkNJYnhkdGZZ?=
 =?utf-8?B?STBpRUZ2NGpwL1d4VHB2Qkp0NGFRVmI2TmJGTHd5NFV6bExHK0dpZWtLV29s?=
 =?utf-8?B?VVV4NEIxSFZvSzdhY0tmcG11K0VWTUR4MjJseWhCVXRxZVlEaUxUemlZdW5S?=
 =?utf-8?B?OGJOcDdPRFJaczB5OU5OS213dnJRRmh0RGtZbzJpRU9Idi9pNHNTeSt5S2tV?=
 =?utf-8?B?S0FNNDMxQ2xEQVBrSE4zVkM1NWV5ZEZNL0dYVXJnMTZkMmtDbzdTbkFNbjVu?=
 =?utf-8?B?V1RZL0VlVHZoM0IyaFBKVWpNWngvall4VnVNUjdpMFhCeFZDcEd6VjFVZUw2?=
 =?utf-8?B?T3FSek9XV2JvRmJmK2RxM0hFQ1ZlOGk0ZXIra0syV0hoT2V0VVQrdko1czBh?=
 =?utf-8?B?TTJTamlycldrOG81cXRwVVd5ZTlLRUU1RG9pcXIvUHRGMTVWd1V2NW9PMmc2?=
 =?utf-8?B?a3BKQ1RMaFJOTkFabXQzT0NUQ2tZWHMva0lJb3JhcDAvOTZCSm9iVStnNEpl?=
 =?utf-8?B?M3I5aEdpVFZ6VTB3MjJwbmFNTVdORkpHZXIvUDVZU3l5a3dkNW5YalBZd2lu?=
 =?utf-8?B?dmF3NVVIZUpLQ0ZjNitOejdxTXhWT3JZMkJuaElBa3hUenZDdlNzdEJoRTY4?=
 =?utf-8?B?c2Y2WHVWSnBYcjA2eVRDUDREYmVJSVNUUFlpVFNBbHFKRTJZcW1FWlAwSGlk?=
 =?utf-8?B?RXJPOFkyWjlFRHVGb3o4NGxleERrZzg4bzBKK1dDY3dyUmJMb0hyUGhYTmRx?=
 =?utf-8?B?Y1c5REV3T1hKUmpoc3JCT0NrbFlESXpxWC9zSm5ERjd3M2s5OFRqZDRlNFZ6?=
 =?utf-8?B?SWpqUWdqWlQ5emVReUQ0czlCNnNMY1JsYnpPNnUyNVhuYlY3TnhIQzlDN1g4?=
 =?utf-8?B?OWRqRTI1ODUrQXE0amV5eUxrOTFJMG1xMFRnWEdWcUdWc1pqSTlWMW5ZMnVy?=
 =?utf-8?B?OVNiWUZqSkJFejU4OERtZ0RZTEtzZUxEaVpBZGk2YlYzN2pDTUgwYlNMaENX?=
 =?utf-8?B?azU5VkF6cCtSclRBM3lIOTNpK3ZlOHFlK2RnWndkU2JsamVrcUlBYkpQcUgx?=
 =?utf-8?B?eEYvL3ZTMEdyd0IyLzgzb2tZaWZsS3RVdnRodWpDVmU2d1NtOEVCRXBqdTU2?=
 =?utf-8?B?MXBJcE1tRHNFMDY4UjdQbHpYdWFMNUFBVGZOMHpvck94bFlPNlJzcGNQbXJ3?=
 =?utf-8?B?K0FnVE5mUXpDQklaQTVUT0dvUWpvdC9JR0kzU2RxTFBNMVZYZWdQcUJ3M3F4?=
 =?utf-8?B?TVc2Q1RjdDJrcnRKNnFOa093anpZYTJLSjlJRHlxWE5SV2gwRGw4bU1BRC9m?=
 =?utf-8?B?aVBCajZGbFREd2JCd3VpUmxyMkkzRDVKdDBaVTRxQmFqV0FTK2hjekh0YjZG?=
 =?utf-8?B?Ym9mcEFOaHIxYkdZakMyUkpsV0liM1ZleFl5U1NGaUdGWG45N2V3eStEOW5R?=
 =?utf-8?B?NFpDTzc3VFNJZ0FZcEZVdUFCT3o3NkFUVldJS0N3djV5NkVaQkxUS2hETEhq?=
 =?utf-8?B?MTRYRXZnc1oyL1cyT0Nic0RMSVUwdldIT2lhdmhleWhmdk5jaTJDUm5LUGNu?=
 =?utf-8?B?R0pKeG9Ka0kySFdBNTFza1ZRQnpqd1ZDb3BVVFVGaVk0L1Y3RVhxZ1hPcTZQ?=
 =?utf-8?B?YjlKbUI3TlRncTM1Q2tHeHZ3cEdvNStwNmlkREE5OE56VFh6Q2xjdmVXVFhG?=
 =?utf-8?B?V3RSQTdzU0kwSThuN2E2QTJ6K1ZQQVVPZS9PeU80dmp0SHg3cDJ2L0kvTjZw?=
 =?utf-8?B?ckYwUExHVG93OUp3SWR4TXJzQkNPSkRySjJyOXdKQWFqS0IyUVAvVWhDUUM0?=
 =?utf-8?B?VzlEemxXOG16T1Y0SFZ5Y2tKNFdwRGtKQWpLRDMzTzhNLzM1VjMxOXM0VTlD?=
 =?utf-8?B?b05XR3NpN0l2L2daQVM5UWNSUThPNUM2aGpsQnNtMXE5TmZFN1YwV2t1aXdy?=
 =?utf-8?B?NE9SZERNK3l1SmVGQ0xFb3RSWjg5U3c3WVg3MktkSnFHK1ZjbXhqR3pnVXc2?=
 =?utf-8?Q?FlS8K2WIfRkCrZBTq0Ffdv37N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d798e11c-c926-45f7-d8eb-08dc7fec01fa
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:31:20.2957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5oIkRl+T718Eb7nsdQv2UyNhZ3a4clTODZ71XXV6xdMjJqC1Pl8Vx3+GxU442TW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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



On 5/15/24 14:41, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> 
> This series adds a driver to read and write ZynqMP eFuses [1]. The
> driver can be accessed by the 'fuse read' and 'fuse write' commands
> 
> Example:
> 
> => fuse read 0 0xc 3
> Reading bank 0:
> 
> Word 0x0000000c: 3cb16685 013af244 40000000
> 
> Note: Accessing eFuses requires eFuse access to be enabled in the
> underlying PMU firmware.

Can you please put this note to 2/2 commit msg?

Thanks,
Michal
