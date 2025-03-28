Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEF6C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 14:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69AFC8129B;
	Fri, 28 Mar 2025 15:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eaBEU4yr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 840D68144A; Fri, 28 Mar 2025 15:55:22 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15BBB810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 15:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXKnlqLDLLg/glJ9Pe8J9NEvxF5T1GYXZMCiXGrjzOHu3K7j5FL6Bc6+FdJJo6PYA2oS33dIqxDvuNCxpAmrrNtYcZnSOsZiDtH79EgbR3H1WI9bdwrrlqbMvLWfUg6v8zLeAIzZQbYmgyQFZ9S073rthit34aIWmi2lkooYIJuwUl5lInKXAcnXgaKi0QsucVNXMJgTA5zgppkrpkoUs9mgySDd8hluU5otSFJpqVAu46Y9PMC/oatEword0Wi5hwQfqyNhy5AOrv8qDHOb9uwAoIPU6ZG34yeGLbM84U+aS+ExqsD1DF7w4q0ajnO6GfBjbzt2guShbyBzTmfLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tTwIiIXdVPqOYaIEYXqtHqgMeOBrTdxx1BXjkukpM8=;
 b=aSoNx/Ns+K7rVlswZw8JhIOLZFaxHafceNN3b6hq7p0Hc7EvU5fOWz7MiUEVvvqM6VNb5eqg01SGaBEliuyjxs3KwXo4y9a/TJTHaUuwtfWJBRw5QFvFjSBz/IbimGMOxMQPkIw4M3AFJxhaza58hxqWKv5NOfyQwJY2Bi1c3Q60IUGbFYrcRoI0mTE+PKQOJ5DgonkrP/sD06SwpS+UekfAhb6JOpHi1YGmcJD5x+R2y+4Rt//yrAIKNQYp+CTB5BUDIyvGvC+ejMbpAhAnYaIJfr6pfmHfoqtIuvC2A5oBc7zAYkAh74964y5bVxge6f7QV6AXEIOLPnTJbYpEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tTwIiIXdVPqOYaIEYXqtHqgMeOBrTdxx1BXjkukpM8=;
 b=eaBEU4yrAvPDkzaH1YuH/2UMXuSAmUEIfMJCDyZ4P76kmj25d95MV/y0S8lddy6BmkQ5haFx/B3LAfW8E83fbQxjySQTmsqw685fMp0b38PekSP91uMaroXCaSevlSy5Vr+pbKjzDnT8AaTyLonm1BsqekFw40yimdiHV2+hOgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 14:55:17 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 14:55:16 +0000
Message-ID: <c2179c02-2e58-49f2-b281-aa6aa7bc3292@amd.com>
Date: Fri, 28 Mar 2025 15:55:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: amd-versal2: Use raw read/write for SLCR/CACHE
 registers
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <ee2d1ad2e07e96f1948ab6ffe8f3c50a3b8f9be9.1742462001.git.michal.simek@amd.com>
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
In-Reply-To: <ee2d1ad2e07e96f1948ab6ffe8f3c50a3b8f9be9.1742462001.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0151.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::44) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: d9c12fa5-027a-4eae-d8a7-08dd6e088d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SmVDeDRxQVB2YjRKS0w5NUxYaGxndWdCbFFoSFhFWTVuQW5vdXJFcWhWcHhP?=
 =?utf-8?B?WVozU2h4Z1ZJMUdqemhack0vcXMwRWl0N2pXMkpFRGp6U2J0NVdRZEozN2Fl?=
 =?utf-8?B?QzYwbm9hdTE3dFk5Z2lwb3hiT1k1cW1EaW5nekFwVVlVekJ5bU1yb1BXR0li?=
 =?utf-8?B?eURvM1NsYjNrVXFiOU9TTUZPYlkvTjUrMmsyS09XNVJLell1SXQyYmRBZXJ0?=
 =?utf-8?B?ckhRbkcwSUpOK2JkdG5mVmVaWHA0dWpORkRmWXFxWWdINmY2WjFQQm1VTXlL?=
 =?utf-8?B?TFUxZWNlOVNGZHlZWklyUjdwbUY2NTVIQ0NhNG1yU2R2c0FvNUliK0ZJUGpr?=
 =?utf-8?B?OFFFZnlJNVYwRXc5M1hqQUtsOE0zVHZYSUFrYmx2M0QzR1VxNjJ3NVdPTjFq?=
 =?utf-8?B?YytBNk5mNk9LN01kUkJjaU1ZcHlja0laWFgxVTJ5S1RVWjdlVTh3NEdEQk1t?=
 =?utf-8?B?NEhVK2twOURqbTgrRXR4UTNlMDJybUdwMmQ5RXVFUzBRdytZbFRHOEwyN3Fs?=
 =?utf-8?B?aERBc0JkcFl1dkFDckdncmgyMVpSdmRhYWd5NHZaaU1iKzFTaTJ5SUlxQlp4?=
 =?utf-8?B?dEc5ZFFZTzE5bEFFNUZOejBMRXFtRld4a0diNjRMbmxHNERNNHlXN0NUU1pE?=
 =?utf-8?B?bUtERkpjTlJxZ0xxcHpvQUQ3dUcwZjdpQnZRZDlkOHBRRHJsdUpGSDMvUmZB?=
 =?utf-8?B?R250TVJ4TGRSSXZlMVc5a0xJUmR2M09kbmZXVUUwdDhQSzhHNU93WG1zbU1U?=
 =?utf-8?B?bXAzNWtVbTY4dUJKOU9INlJpV28yMko0NElTWG84b0EzTUNBV01KaWo4QVhC?=
 =?utf-8?B?a0hGUVhXaitLejlUZWRMaHYzQ3ZIelVhbG9Ta1lhTWF6ZnZTWG80K2lnTzBo?=
 =?utf-8?B?Y3hhTGY0RXZWM2lMR3lpRFJxelhNWmprMEJtT2VlbmlJRGJ5TGczYmJtTEs1?=
 =?utf-8?B?WGRYa0h4Tk5US1BpMG9MSTZhVjB5b1hjcjFsYkRjOThxQUJOazdvQlhYL3p6?=
 =?utf-8?B?WEJzQkdLd3ZHUk93NHR3TVRPbUc3eXp3cnlaRzFwQndNWnpBZzZGK0d4VUhI?=
 =?utf-8?B?Uzg4Z0ppM2dkeDhUK1FUUmxqRld2UjEzT2dGSWlLVy8wZzR3eHZIU1VRSkZh?=
 =?utf-8?B?UFVTanFNdXdHUDZWTHpUOTZwbjhad3VWZDZNSmw3c3dtTTZzMFIrZElZUUlq?=
 =?utf-8?B?YlJ3UCtzalN1aHJ2UCtyQjlJbC96aE80OWwybC9IWU5Mck5jK29qS0F4MkZC?=
 =?utf-8?B?aitoRmxTZFo3dmx0N0MwYkFITmlCQ1ZuaEJ1N01peTdRMGRWeGZOb2lPblZG?=
 =?utf-8?B?L0d2Z2RBbFZmbUJuZk1XQ1pZZXNYZW9LTHFwMUhTbzM2aFJGeG9zdnJROC9B?=
 =?utf-8?B?dE96ODVHSW9qeENBaGRxbzBSY1FQankwZmV5b2FYOVBQZUQ0WTA1bWRrUUly?=
 =?utf-8?B?djFyNG43ajM5djBSNURCR0paaCtma1gvQU45eENCTXAySXhxKytHbUhaMUF3?=
 =?utf-8?B?ZkU5VUdWci9iaCtzRjArM2JVazM4d2dlekkvbWNFZE9UWEpuUitybXAwM1Nj?=
 =?utf-8?B?KzEwNXZWNVpxdmc4M2JKc0VTb2tBSG51OXU3eER1MDdUdXZ6QnppWlJ0ZGg0?=
 =?utf-8?B?aDFnbnVMZ1d5VEF6NXF1K1pYeU1ubjNyYXI3aGVINEZNMGl1Tkh1V0R4S0Fw?=
 =?utf-8?B?c0lCWWxSUFlXd0xtWVdBMjZkRVBtUThFVENkWnByUEZqOVMvZE1lSzcrTklD?=
 =?utf-8?B?em9oZ2NOVjFCTW1BNVZXb2F0VFFZdzdSaGdJWFdneEtTNWIzVDhOcVlMK2VI?=
 =?utf-8?B?R2NmRWM4K1FEOTNHQmpUUHJEUkJDT05wNmM1cGRuQVhaaWRaanZsSUZIWUZB?=
 =?utf-8?B?dG9UUnBVTk5FNm9ENlpRcXZ3aVBueTk3KzJnUXVvM3QxOVRjOHFKOE9jeGg4?=
 =?utf-8?Q?aeP0yoU2zW0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDMybjZpcGdkaFFKNFQxVllHbnJTaEx6RFE0VDRTc3o5NEptMjIvRUNaVUkv?=
 =?utf-8?B?bEdoeE9EOVpXVjU3OUFjdWpxQXJnQ3I2NWNGUmpyVkFlUEppODdCZWdIcUdt?=
 =?utf-8?B?MSs2ek1PWXVlS1J1ZC82THhHV0xwU2xrK3M5clJaaVgrZ09YN3Ntekdwc1Q2?=
 =?utf-8?B?bG5mbEpMZU10alN0VGV6ZnBlREljSnVINm1LRzBkd3NQY0xRUTRTU0FpSm53?=
 =?utf-8?B?a0xqQWJyaXdjcUJ4aDhvODJQZDZJMkg1ZE0xY2tuRE5sWkJtSkhtSS9EMnI5?=
 =?utf-8?B?QktKeFo3ZGpNQlE3K05IZ21YQWFUNjdkeTVUd2Jra200eUoxVGRhY2s0M2ph?=
 =?utf-8?B?aVFpMzdpakJpTzJaTTRnNXUydjgwREx2YzlBWStFWXJLNHVuNy9SVkVVQzd3?=
 =?utf-8?B?MTdnd1ZuYmp5T2JmeXIvcXgxMzZMMGhPTURJTVF1b1FHeFlIVDhFWVlmTm1p?=
 =?utf-8?B?MGExc1E2NEhhelNvaituaVI4aklWcXdpME5pQ25GQ3hRVHVjQXJNYlZiMmNz?=
 =?utf-8?B?K1Roc2lOWGpCa3Z2dnMwV2oyL0tBdFlEeGxWK0pSYU9lbW9vZmdHb3VFSUcy?=
 =?utf-8?B?c2x1NmFFRkNEdUdhbjlOSEQxWVM5elFRbGJmOG1RV3NrS0kxdUZNVk5McW90?=
 =?utf-8?B?Z0NJTXVHRkdGVGh3UDNpRFNvYWxoNG5pRFI3b05KMDY5RmVIbTlWV0JXMktJ?=
 =?utf-8?B?SlFPbDlObW0yL3ptdkhtazMvdW96NGFyRVNyMWxVSHJGcG1OdGFoeXdIVStn?=
 =?utf-8?B?WS9mTDNGWmFzL3NRb1BLdkdYcitPbTJxY01OVWJzc2prWUh2K2RkZ3BHZThO?=
 =?utf-8?B?UkdFUmZXcVhwbGdONmNrZDFQR0xsMGZUemdUekwzV2prTm96bFNxQ0Yxb0M2?=
 =?utf-8?B?SmNPRTg5b3JkMlkwOTZjSFJTYTY0NDhuNkZHK09nenBIWEhwcGgrYWQ3TkJT?=
 =?utf-8?B?N2VsemtPazdBc2tLZHh0WnRNbDFuU0E0LzMwM1NEcm5nb25aRE9JVndyMkZa?=
 =?utf-8?B?MzcxeVBDQmY2VklPZHc5Y0ZQVXhnZTZoNHRGR3ZzMVViV0JuTzVGVnZKZ3dR?=
 =?utf-8?B?SFdhQkxuL1ZxeFI2Q096OVVHQlN4WmNTUVY5QXZtdzZMdUJFMlVTa1dBWTB2?=
 =?utf-8?B?YSsxbUR1SDNEVTlkdVNOVGpuKzRkUTdQdXduN3NoK2NEWTFiYlRraDU5QWNk?=
 =?utf-8?B?dEJqS1J0RkxxOUF1VFhtc0pwUi9JcXZZM0kzVm1lVDU3d1oxYWxiN29XYlR3?=
 =?utf-8?B?UGFpODRUV2Z1SnRseUErYjNnalR4eTR0WFozWExuZjAySGw1ZDc3am0zUnpH?=
 =?utf-8?B?TS8rK1A1TlVTcXppWWRDU3VCTWNwdE1QTkRmdjg4RWpsT28wbGlyTjMzejR6?=
 =?utf-8?B?ZjVubXdmUEhCZWE4NVc0MDBwdVVjdTR1UjI2azd3WGg5NmRHUU4vK1h2dElO?=
 =?utf-8?B?UWp0TVc4M1YrUGNoYmlIMnFKemsyNWk1aHN6T0pta2x1OEI4RnhPNk5iRjBL?=
 =?utf-8?B?aysxWnpEWGZtK0hiS2xsWEFFRUZVQ0pNSjZjVjhBVkJaR3Q4VGJDYjk0dWdQ?=
 =?utf-8?B?MldHTHZ3Zy8wNkk0d1JabDB3MytyOGsyUWVTQ3h2VFlJNTRESDhoMCt1UnlH?=
 =?utf-8?B?T3RhYnY0dnFQK2E2aEpVNWluZ1RLakx0YUtjSktzMHAwc2VGd09aZjBnKytn?=
 =?utf-8?B?REpzcjJPbnJoM3QwMTNQV1NPYkhNWUZwWWZhNGxOQmJnM2c5Z0JpbzRBUkhr?=
 =?utf-8?B?OHlBRDk3clp2Q2JxbE94T2JoVnMzbmd3S01ibWVwZC9qU3UzZ1dyMzE5Sldm?=
 =?utf-8?B?eGw5TkNOVDlKVVVHVDBmSEVHcnhpbys0NXFHZEdqaG5ocEdsWnE4TEZiYVhl?=
 =?utf-8?B?b3U1NjdHdVU3VjFxSCtVbzl2aExPUmtjZFFmUGpCNG9ib3VMTTgvb09Ra3VZ?=
 =?utf-8?B?SEtlSG1ENWtaTTk2RUphVy9yeUpYWW9xOC9obENqNFFxakw1anp6WVVRbjha?=
 =?utf-8?B?SGpxRDVKNllrNm9ycmFaME1uT2tsZTBBeE5SYmZPdXpWNUhaMzBhQlpFRDBt?=
 =?utf-8?B?MTNwcDZYNGtDem8xYi84ZnMrckJjNzJ2TmtpRHNtWFFSWWJnWFVlYUZnT0U0?=
 =?utf-8?Q?ihzoPEInh8HcL3CjoOykffOw4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c12fa5-027a-4eae-d8a7-08dd6e088d62
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 14:55:16.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46tgugqIpcFd8apntm35Ho7d8x9HUmcjLp0dXaRiqyv1lJIfE/dUQVy51B4Z6bnQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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



On 3/20/25 10:13, Michal Simek wrote:
> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> Update the firmware driver UFS APIs zynqmp_pm_ufs_* to directly
> read/write to the pmc_iou_slcr and efuse_cache registers. Replace
> these raw reads/writes with the xilinx_pm_request() API with the
> correct arguments once the PM related changes are done.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-versal2/include/mach/hardware.h |  6 ++
>   drivers/firmware/firmware-zynqmp.c            | 28 ++++++++
>   drivers/ufs/ufs-amd-versal2.c                 | 66 ++++---------------
>   include/zynqmp_firmware.h                     |  4 ++
>   4 files changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
> index a961032b4d5b..7ca2bbb7550f 100644
> --- a/arch/arm/mach-versal2/include/mach/hardware.h
> +++ b/arch/arm/mach-versal2/include/mach/hardware.h
> @@ -97,3 +97,9 @@ enum versal2_platform {
>   #define MIO_PIN_12	0xF1060030
>   #define BANK0_OUTPUT	0xF1020040
>   #define BANK0_TRI	0xF1060200
> +
> +#define PMXC_EFUSE_CACHE_BASE_ADDRESS	0xF1250000
> +#define PMXC_SLCR_BASE_ADDRESS		0xF1061000
> +#define PMXC_UFS_CAL_1_OFFSET		0xBE8
> +#define PMXC_SRAM_CSR			0x4C
> +#define PMXC_TX_RX_CFG_RDY		0x54
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index 584397ba29a3..2940181e83e9 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -5,6 +5,8 @@
>    * Copyright (C) 2018-2019 Xilinx, Inc.
>    */
>   
> +#include <asm/arch/hardware.h>
> +#include <asm/io.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <dm/device_compat.h>
> @@ -169,6 +171,32 @@ unsigned int zynqmp_firmware_version(void)
>   	return pm_api_version;
>   };
>   
> +#if defined(CONFIG_ARCH_VERSAL2)
> +int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value)
> +{
> +	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_TX_RX_CFG_RDY);
> +	return 0;
> +}
> +
> +int zynqmp_pm_ufs_sram_csr_read(u32 *value)
> +{
> +	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
> +	return 0;
> +}
> +
> +int zynqmp_pm_ufs_sram_csr_write(u32 *value)
> +{
> +	writel(*value, PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
> +	return 0;
> +}
> +
> +int zynqmp_pm_ufs_cal_reg(u32 *value)
> +{
> +	*value = readl(PMXC_EFUSE_CACHE_BASE_ADDRESS + PMXC_UFS_CAL_1_OFFSET);
> +	return 0;
> +}
> +#endif
> +
>   int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config, u32 value)
>   {
>   	int ret;
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index bfd844e41938..1c5ed538370e 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -19,8 +19,6 @@
>   #include "ufshcd-dwc.h"
>   #include "ufshci-dwc.h"
>   
> -#define VERSAL2_UFS_DEVICE_ID		4
> -
>   #define SRAM_CSR_INIT_DONE_MASK		BIT(0)
>   #define SRAM_CSR_EXT_LD_DONE_MASK	BIT(1)
>   #define SRAM_CSR_BYPASS_MASK		BIT(2)
> @@ -32,19 +30,12 @@
>   
>   #define TIMEOUT_MICROSEC		1000000L
>   
> -#define IOCTL_UFS_TXRX_CFGRDY_GET	40
> -#define IOCTL_UFS_SRAM_CSR_SEL		41
> -
> -#define PM_UFS_SRAM_CSR_WRITE		0
> -#define PM_UFS_SRAM_CSR_READ		1
> -
>   struct ufs_versal2_priv {
>   	struct ufs_hba *hba;
>   	struct reset_ctl *rstc;
>   	struct reset_ctl *rstphy;
>   	u32 phy_mode;
>   	u32 host_clk;
> -	u32 pd_dev_id;
>   	u8 attcompval0;
>   	u8 attcompval1;
>   	u8 ctlecompval0;
> @@ -102,41 +93,6 @@ static int ufs_versal2_phy_reg_read(struct ufs_hba *hba, u32 addr, u32 *val)
>   	return 0;
>   }
>   
> -int versal2_pm_ufs_get_txrx_cfgrdy(u32 node_id, u32 *value)
> -{
> -	u32 ret_payload[PAYLOAD_ARG_CNT];
> -	int ret;
> -
> -	if (!value)
> -		return -EINVAL;
> -
> -	ret = xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_TXRX_CFGRDY_GET,
> -				0, 0, ret_payload);
> -	*value = ret_payload[1];
> -
> -	return ret;
> -}
> -
> -int versal2_pm_ufs_sram_csr_sel(u32 node_id, u32 type, u32 *value)
> -{
> -	u32 ret_payload[PAYLOAD_ARG_CNT];
> -	int ret;
> -
> -	if (!value)
> -		return -EINVAL;
> -
> -	if (type == PM_UFS_SRAM_CSR_READ) {
> -		ret =  xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_SRAM_CSR_SEL,
> -					 type, 0, ret_payload);
> -		*value = ret_payload[1];
> -	} else {
> -		ret = xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_SRAM_CSR_SEL,
> -					type, *value, 0);
> -	}
> -
> -	return ret;
> -}
> -
>   static int ufs_versal2_enable_phy(struct ufs_hba *hba)
>   {
>   	u32 offset, reg;
> @@ -281,7 +237,7 @@ static int ufs_versal2_phy_init(struct ufs_hba *hba)
>   	time_left = TIMEOUT_MICROSEC;
>   	do {
>   		time_left--;
> -		ret = versal2_pm_ufs_get_txrx_cfgrdy(priv->pd_dev_id, &reg);
> +		ret = zynqmp_pm_ufs_get_txrx_cfgrdy(&reg);
>   		if (ret)
>   			return ret;
>   
> @@ -312,8 +268,7 @@ static int ufs_versal2_phy_init(struct ufs_hba *hba)
>   	time_left = TIMEOUT_MICROSEC;
>   	do {
>   		time_left--;
> -		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
> -						  PM_UFS_SRAM_CSR_READ, &reg);
> +		ret = zynqmp_pm_ufs_sram_csr_read(&reg);
>   		if (ret)
>   			return ret;
>   
> @@ -341,10 +296,10 @@ static int ufs_versal2_init(struct ufs_hba *hba)
>   	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
>   	struct clk clk;
>   	unsigned long core_clk_rate = 0;
> +	u32 cal;
>   	int ret = 0;
>   
>   	priv->phy_mode = UFSHCD_DWC_PHY_MODE_ROM;
> -	priv->pd_dev_id = VERSAL2_UFS_DEVICE_ID;
>   
>   	ret = clk_get_by_name(hba->dev, "core_clk", &clk);
>   	if (ret) {
> @@ -371,6 +326,15 @@ static int ufs_versal2_init(struct ufs_hba *hba)
>   		return PTR_ERR(priv->rstphy);
>   	}
>   
> +	ret =  zynqmp_pm_ufs_cal_reg(&cal);
> +	if (ret)
> +		return ret;
> +
> +	priv->attcompval0 = (u8)cal;
> +	priv->attcompval1 = (u8)(cal >> 8);
> +	priv->ctlecompval0 = (u8)(cal >> 16);
> +	priv->ctlecompval1 = (u8)(cal >> 24);
> +
>   	return ret;
>   }
>   
> @@ -397,8 +361,7 @@ static int ufs_versal2_hce_enable_notify(struct ufs_hba *hba,
>   			return ret;
>   		}
>   
> -		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
> -						  PM_UFS_SRAM_CSR_READ, &sram_csr);
> +		ret = zynqmp_pm_ufs_sram_csr_read(&sram_csr);
>   		if (ret)
>   			return ret;
>   
> @@ -410,8 +373,7 @@ static int ufs_versal2_hce_enable_notify(struct ufs_hba *hba,
>   			return -EINVAL;
>   		}
>   
> -		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
> -						  PM_UFS_SRAM_CSR_WRITE, &sram_csr);
> +		ret = zynqmp_pm_ufs_sram_csr_write(&sram_csr);
>   		if (ret)
>   			return ret;
>   
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index 82781dfd16bc..dc06abc52fce 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -458,6 +458,10 @@ int zynqmp_mmio_read(const u32 address, u32 *value);
>   int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
>   int zynqmp_pm_feature(const u32 api_id);
>   u32 zynqmp_pm_get_bootmode_reg(void);
> +int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value);
> +int zynqmp_pm_ufs_sram_csr_read(u32 *value);
> +int zynqmp_pm_ufs_sram_csr_write(u32 *value);
> +int zynqmp_pm_ufs_cal_reg(u32 *value);
>   u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
>   
>   /* Type of Config Object */

Applied.
M
