Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57112C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 09:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAA2186B4E;
	Mon, 13 Nov 2023 10:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pR7MfdvG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A7386F87; Mon, 13 Nov 2023 10:06:52 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3AD486B0A
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 10:06:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bowufYF0TsMUKCawFUMDwBGn026/83qtmKjR8teA7di8gLWAR1IbkIMSZpoh54CsE1yQw4DTW1cZQetEbUN5banzm2zdAYY6pKj42a5ykNihrIIIzQAwdgQ58uepl8zU6MFTpb5X3/BxTeg0idfNO5yX4nVKk/OOGf6dA3JCHN+VTOP0QaituIOgYqyIFhf/2ZOPVMLhLREFmbu+Em0gwet0dPM0CklFXGcp+QUXVq8aYLM1Tfv11Hh9vfM3KPIsFUNwIW8fIyWKaU1wk2NgH++R1NxAzmqAGV1KNYXO5zV3ddA+vJLYnJ+sdR+knmzHhf2BCtcthJNbYfxOkqYwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjZJ8Dft7OE0I8YObcv06Zu9ilqAW4SVjJ1MZjJLRpU=;
 b=hxgF9FHSjTIOYONJs8idzc/dv2CC6Qa0T4dczsMrD4tuQKu3lOU0KvIeuZAjcG6gPOcsRJ996l/vYnoJ2J+eufJHrv4VEgt8e9wAGjdMvqV4Ka+yABQT/j81BbIQsVATEhtGiAX+hFXLe+WNcWwE76JZSA/mTTxZgI8fdjPjrYn6F8a6zTzWKYddEYOz8f7OpDlkxxYAsZRTWZpxIqeFXsVGPc8XJQ8xUJhKPwBz3/AtYZNot2/gCypcGHF/dXlc3Zj1fFVkZStZHGsBUujgBc2ZHGJmRHL2KkD158GvqcriTBnBotOJhvchgFCukkjG5erGCeJjBEDnekt/upZ4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjZJ8Dft7OE0I8YObcv06Zu9ilqAW4SVjJ1MZjJLRpU=;
 b=pR7MfdvGy2TsNPpam1GDTElNRv0WuHtrebnCu8E3MGE6zjnsitqkW1FuDmgJSkUkuNVnFTPEI6xv194ikzMlAYeGj5XXirfNx3xew81K4stG0vjYW9vaNot/2ahZgSayEtn3QTorH9ke3md9H69xxCiTvp79W8nHqacQwImvMuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 09:06:45 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 09:06:45 +0000
Message-ID: <4594325a-f240-4a6f-927f-6aec53cfa830@amd.com>
Date: Mon, 13 Nov 2023 10:06:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] drivers: xilinx_spi: Probe fifo_depth at runtime
Content-Language: en-US
To: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20231111173121.92889-1-mchitale@ventanamicro.com>
 <20231111173121.92889-4-mchitale@ventanamicro.com>
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
In-Reply-To: <20231111173121.92889-4-mchitale@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:802:2::38) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 082f139c-b723-4fb7-a233-08dbe427dc66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wt4n/zCvkKnHCIbUHMv3/rCo6Lagdr20l16902pjnsboAnpE744x/I0Z1Ilmqgay6iNmPxeN7YIrI07jR4oAhGiKwZcJdki7z46oHLWZy7xLw46njrf5/9loJ6s7TYLfcAMHapriyj6TqzFuxhkhlyuZ0qZiWlZZj/NN13Afco1oqlc8toygutYrey/G8fl8qoURP+Ok9UM2BeiLf2rU91ks02WBtv7xXitLOD2aoTWPVt/Pi2lB5mYJ9rthGQZQj/2xexT9f8sVZ3Cf9YchXrTz1IfwQezyaNOVqc8ETXtcp7sA5QjPagDexRXXdjWIou3lHuFFv8g9StCM8o9eWYdn2P4eLAVVRLMq7aO4D1wkHonIp/943oTTJ3pwYaNjq+EN3L+CzUwuQxufqV2yTdbLDhAYEm5w0tPCgkzce3HP9S3c8Pty2JKjO0yY3QyFgXcYjR8GU90JApgBHbgrL8yVmGHBgCvY4c9hoOzSl6sWRqfpbEPbaVG/809wo7wW7QuM9BFLDox93RU9N36SD5DytA+g7i2bDHv1vO4ct/yPcrArp9JPB/GlKVbciUkp2I0aPoo6cPBSAGkG6x7DBCMrHcDhEl3OrYPRjbekfR6OaAR9VjbU1o6WJj+iA1ba
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(44832011)(2616005)(5660300002)(86362001)(31696002)(41300700001)(26005)(110136005)(54906003)(66556008)(66946007)(66476007)(6512007)(316002)(83380400001)(38100700002)(966005)(31686004)(478600001)(6486002)(36756003)(53546011)(6506007)(6666004)(8676002)(4326008)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdkaWorS2xuKzlENkMvUDAzUHdrYnV1OTFveGNwYUZqWk5CK1ZucHFCTjB0?=
 =?utf-8?B?UU41QXoyYmVOMTh4R1ZEOGNWSzlrN2xLZUxYS1ZRQ3JmMWhySlhwRUdFaHZY?=
 =?utf-8?B?VkU5b0ducFdYN3oySlF4anpRMXZRQXhiV0hQTThZM0tHQ016YXFpWkU5QUVz?=
 =?utf-8?B?UjdzMXN6Y0hvMXRLVnpvc3ozc0xsRnVYYVQzY2JIWXU5bk1rUDF1OTlGVHd4?=
 =?utf-8?B?TS9ZbWJRMWJWSHlQM2RNWDJ4RzkydjVNd0M2WUp2Y2pIWHFzOXB0NlB0emYr?=
 =?utf-8?B?NWNwTURISFlKaVZXZnVnM3JtVmpQZnF0QisxV0tYTnpvZFN3cHRiNC9tVnR4?=
 =?utf-8?B?MzkrNDRmK2dFVlpjbE15TGR1Q1BqSERjOGljVEJJalNGVUx2eU1oNHAvcDBv?=
 =?utf-8?B?YjBGRWFVZW8rbkxTVG1XcCtpQWZPNjhSVTNoSlV6ZGNkR2pxbGZOTnFSZXJy?=
 =?utf-8?B?eU5pQjRPamkzMVJSSGliMHg4L1o2MUNuV0pHdXVJZ2xkaE0vWE1BVVJZL1NL?=
 =?utf-8?B?Ny95YmQ0VU5tR0tnczJLODU5VHBkTmhQc1hkZjU2RjlDTFpNSmhlRTlvTkJ4?=
 =?utf-8?B?b1lIdGgvV2FnMzJYN2QyMXFFQ2tiNEg3U1NJUk9DVnlJSExvNjRHenNJK0oy?=
 =?utf-8?B?MXliRjhaSjdidjJNc0ttaW1GVG05RVI1bkJRQXhmWnRneEpLOHdTb3dwdHhs?=
 =?utf-8?B?Rzd0YVZCNnJlcmRhNXVNVEZTQmZkb2txRGxkWk1wVTgrdXc0K0hlLzZTZnFk?=
 =?utf-8?B?c09wZFdpUHVTMndIbFJlZ3NpWEFEU3VWYzV2MG4yZUVvNDNEOW1sY3BySVFU?=
 =?utf-8?B?QktlSEFFSjdjR1ZZUkRQZVdXTFI4RnlubXRicUxQWHRQWGRhcUwrS1F1U3dH?=
 =?utf-8?B?WFRuMTJuSzZZdGl2U2NqbC9kQkFXTERqY2kwL2RzT25FZlZkOHRqaVlBOWlD?=
 =?utf-8?B?L0dmSVNSbGVULzc4ZXFWdDQ2QUpoWVkyeFRkQ3BzdVFsSFRCMjJvTGh5Y1Nv?=
 =?utf-8?B?d0Fxc2p5L1lBRWM3aytzWjdYSXJKVllKZG9QemxOUWd1N0ZKQzJ5Q3J6c013?=
 =?utf-8?B?MXVMVjNCd0FNeVlidzBaTGFRN1VhYWJZNmppM3VPeTBEYWk3UlE3aWVJZ09S?=
 =?utf-8?B?RExyVUZxTzdEOCtFVEdtTnUyc3JnVWU2NGVaekVMdnhDRW1uaEgyM3pydkVG?=
 =?utf-8?B?UHRCeDVSUmpWT3lBQk5rWU9wa2Vjd1VueFdjd09lYXo3SWlybWRkRU55WU1S?=
 =?utf-8?B?UTFEbUJvMTdsNGZLcDN6QVlEaGl6TXh4TEtpR09SMEhNZGtPZU4wSEZaQ1Zr?=
 =?utf-8?B?RHpIc3VaeVovWG04cXd1aGUveGozbE00WnM0UEpKRlhmUHZwQmVqRVRpcnM4?=
 =?utf-8?B?UXBrWUxieTVuV08yWjFVYStnWEtMbGRXZDMrQkx4RUVjNFV2MWpGdDhvM3Ft?=
 =?utf-8?B?VGc5SWt2MWdTR2d0S09KQ0tvb3p3WnpzOXBxNlFmd2VvdG5GOWExclRENmVI?=
 =?utf-8?B?TklyT0d4S1VBbWxJYzlSQkpYRldyTzJrRmRFZVJ0aTJmeXVidDJEVkQyVTJ4?=
 =?utf-8?B?cTBVQzNnelVtUkdLSFpTQUlFcnJEY2dBRW9ZTWh4S29VZ1lyUCs3T2NsRU1j?=
 =?utf-8?B?L2VuMDNSNkdWZUgxNmNXbDkySWJKeGZ0OU1kZ2x6VTZQTGxPdDRNSFJnQUVT?=
 =?utf-8?B?djl6OSs5UEtVQSt2aEtXWGY0RVJ5emNobXd5OXY1Y2JSMmo1bENoNTlzM2NW?=
 =?utf-8?B?b2J3S1FnalF0ZmI4d1VqZEZ4Rm0zOVNzMEFxUFYrTll4Q09NMjRRQi9ob0w2?=
 =?utf-8?B?RDVka2FKZlJUNEx4cDdOMmpkSVplTUJWNFdkaXFteVBsSUhIN0MweGI5ZnhJ?=
 =?utf-8?B?ZU9mTkFFalA1S1pkdXd5Q3A2VjJYVFR4SDVqbzNqTGFhYVhzWHFwcW5GenVl?=
 =?utf-8?B?b0l4eVZ5dWpEMXpsK1lheWVBdWdrdnNyZ3RYMXIxbEdmV0RBUldtNHNOOHQx?=
 =?utf-8?B?R01qbVZHOWFaZ01RRUtCTkJqSWs2MVpTMzlybkZvNnAzVjNQN0hWTkFMdlpm?=
 =?utf-8?B?UjV2RTBQbUttQUpZaWl3YXVsQlZrM3JpOGQxWUI4dVhaYzVtVERlTkhoR3pn?=
 =?utf-8?Q?GyiNcTiKyTfEyhhSHw6z7hC4k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082f139c-b723-4fb7-a233-08dbe427dc66
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 09:06:45.6616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRltz6v9T+YPnvlireNMULuDPChOE0SBAnzJGTgEIJnbrVmOAjTwrQt1wRlUOPFG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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



On 11/11/23 18:31, Mayuresh Chitale wrote:
> If the fifo-size DT parameter is not provided then probe the
> controller's fifo depth at runtime. This is ported from a patch
> in the Linux Xilinx SPI driver.
> 
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Link: https://lore.kernel.org/r/1422029330-10971-5-git-send-email-ricardo.ribalda@gmail.com
> ---
>   drivers/spi/xilinx_spi.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
> index b63cda2091..99ae5be291 100644
> --- a/drivers/spi/xilinx_spi.c
> +++ b/drivers/spi/xilinx_spi.c
> @@ -109,6 +109,27 @@ struct xilinx_spi_priv {
>   	u8 startup;
>   };
>   
> +static int xilinx_spi_find_buffer_size(struct xilinx_spi_regs *regs)
> +{
> +	u8 sr;
> +	int n_words = 0;
> +
> +	/*
> +	 * Before the buffer_size detection we reset the core
> +	 * to make sure we start with a clean state.


nit: can you please remove "we" above? It should be written in imperative mood.


> +	 */
> +	writel(SPISSR_RESET_VALUE, &regs->srr);
> +
> +	/* Fill the Tx FIFO with as many words as possible */
> +	do {
> +		writel(0, &regs->spidtr);
> +		sr = readl(&regs->spisr);
> +		n_words++;
> +	} while (!(sr & SPISR_TX_FULL));
> +
> +	return n_words;
> +}
> +
>   static int xilinx_spi_probe(struct udevice *bus)
>   {
>   	struct xilinx_spi_priv *priv = dev_get_priv(bus);
> @@ -116,6 +137,8 @@ static int xilinx_spi_probe(struct udevice *bus)
>   
>   	regs = priv->regs = dev_read_addr_ptr(bus);
>   	priv->fifo_depth = dev_read_u32_default(bus, "fifo-size", 0);
> +	if (!priv->fifo_depth)
> +		priv->fifo_depth = xilinx_spi_find_buffer_size(regs);
>   
>   	writel(SPISSR_RESET_VALUE, &regs->srr);
>   

When above fixed feel free to add
Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
