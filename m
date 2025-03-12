Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71ACC28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 08:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71A108168B;
	Wed, 12 Mar 2025 09:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zI5P6uM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18410805D7; Wed, 12 Mar 2025 09:44:00 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09E280FB9
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 09:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olew0Ep3DplxCwixbZjGZ/cSRQptZL3WPMqnWKq7jGZo96td9l3HoL5BhQciHbmfpJcgMFU9yEp35Lo6+O50ZoZDsU4KFmuHYTMR6uvdM+5G55OrALxZHqoe7pwjaPT3NwCaNot84T20NJf9hIQ1Zu2MhpcZs0Rtvm5iZldQT2NzpnLlRHEy5gzgQroAgKC9BTe++rksFjrlzcRWK6IhFihe2NxyotH+/WHfRE+WG/NAwAouWlyx3zWV6iK2J8QNVqvkiywjZXJvOX2d2DGJbMjqN9pgCHRGyquIosEsJ1IpQlRweSUtpYi4vuI90EfeUA4c7dhTz4YLKkB55lnLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNxa5TqtnRyjMqLlMl7Ys4JbtnxU4J9l7zXx6fSaGtE=;
 b=q/cM2fe1k6eVIGbgChT82+vqqCf5Ww9FdGz5J5q9sXawjncDmgN0hulC63xH2fyF3WRwlnQzYRjZ8HEAJtUvI5WGY7Y104zIEXfsEvphThRByKI4631dBHGD0DlcF7pOn2aNosbCeOuWON9n+RD5GPv6cPGsL4Yz7zjKOeIaebk0Wyc6EBaBNEfzEgqSz7QO/MMVEUPZgec5w8IIP1Oj6mao0lcOZztfSxVMfIOkxWmMeJU2Wo1OAwJ4kqjEAliFp3ymVn7wmldErAtAYHzAOnfzQzQIjv7yifhjJ7x3KkbOuw1KIqHGQs1G0yKQ2xk5vjrshIGPyxoZL4uPZLlqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNxa5TqtnRyjMqLlMl7Ys4JbtnxU4J9l7zXx6fSaGtE=;
 b=zI5P6uM+qVzaoNAEZLtf6y6IM62KVHjxQ2FiN/UazzG5211QSKICyvAUpBqt+LPkDeIZe4d5DHFYnla8+LPHLWXj6jyRWYdP38DkdRN5snxCoEkcKHu1aQ3g3JbAs9PkaUf0I7m22WkVGoGgALugLi8okz7n0Gk+uNMjYEoPkEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:43:53 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:43:48 +0000
Message-ID: <a9554ad1-5cdc-442e-9e9b-c2b67b089860@amd.com>
Date: Wed, 12 Mar 2025 09:43:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] topic: Use distro_boot for topic-miami boards
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20250311070124.20696-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f65ac4d0-e9fe-45da-83ac-ece4a1b82e5d@emailsignatures365.codetwo.com>
 <20250311070124.20696-2-mike.looijmans@topic.nl>
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
In-Reply-To: <20250311070124.20696-2-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: d1580471-4272-46f0-739c-08dd6142018a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXlMck4yYjB5bHNuQWViMTNpaFlYc0o4TkhFRTlselRadld6QS9IODVLZGtX?=
 =?utf-8?B?ZUNlNE9XcVpmSWU1czcvajkycFJvY1gwczhZSFRzOW5ENGZueUJPTC9rYjBU?=
 =?utf-8?B?MkhOSEJwNUZmWS9tS05RVGx5c0M0RjJXQmNmOGRLWmN1RVFseGFJUmp5bFFU?=
 =?utf-8?B?eFJkZ3FvVWJScHByc2NkQWFWZy9YanloODlvLzVFN0VjUkNVcisyR05IV0Iz?=
 =?utf-8?B?cTRaL2EvbzI4Umlvc3M4LzJBMExLdmNFYWFUYTRSOSttRG81ZmZWYXY3OCt5?=
 =?utf-8?B?dmRpNGJ0UGhTd0N6ZnlFWEJ6YlNhU25uZnBGdFp3ZnhRRER4Vll4SlZzR2xC?=
 =?utf-8?B?YURWVHFyNkI4Wm5ZYUJUNGQ0SGk3WHpobW5PNW1ES0VqWXZCV1dxTEc2ZXNI?=
 =?utf-8?B?eDdTNnBOeCtBcHVrYzBVNHhnUDltQzJSUnN4YzFpcUNnT2NIL3JiMVA0cWJX?=
 =?utf-8?B?TmJIemJNc0U0ejB2cTVoTTE0THdlRzlWbE50VDNuTWV3d1plamROemNDaVBN?=
 =?utf-8?B?clpSdU9HVVg4TCtnUlJnTXg4alVvVmFiZTBQdlhYYU5RTUtQNk1rK3lwZU5t?=
 =?utf-8?B?U0tOSXpINXgvMTBEelRMNnFuK21OT2JDUjk0aW5JNjBMQUI4cWFjNjg1d241?=
 =?utf-8?B?c3BqZzRXZE5PZSt5VDNRWnZyMXY1WDV3REVRT2NpV0tBbHNhaVk1SUg1TGJZ?=
 =?utf-8?B?UERwbGNETVpOdEFuTmxnZWIzRFcybE9qczdFd0NmTG5RamQvMUFSVWRVRU1P?=
 =?utf-8?B?MTZ6MGFjc0tQdG9NVXlYM3NHeC9rQlBGTW9IUlk1dUpIN1FvUDJxUGFodHNW?=
 =?utf-8?B?Q3d6OW1EUi9vWHB2T0xWbUpra1FzTktpN3RJZi9DY2swZVhaWmtuTjNUQUhL?=
 =?utf-8?B?b0FEdE4ySng1dndoSklSckVWeTB2eldtaHB5cjB1dGVhcUZuVGgyYzlKdTE1?=
 =?utf-8?B?ZWxKdFREdVVOT3cybnFDSTJLUnlkUE05S09CcTlxRVBvL2ttMERucFJ4eUNs?=
 =?utf-8?B?Q3ZGZHg4Z3pvTUhVWVF6NkRNWGc5a3ZMVlhWTXJRR3o1OHEvWmN6aUhOZ2Mz?=
 =?utf-8?B?UGUzbEo4NmJ5UWJrM1EvMVRCcEF4VXZQNEp5TW0xS3JBR3Z4V0o5dmJWc1c0?=
 =?utf-8?B?OUlpOTFBZjFlVHpOMjd4MEtvNjhiVjJOdzlVSEpkTkdaZ1RoQ3dWUXk2TTcr?=
 =?utf-8?B?MVpyTzA2RW9YUG8yS3RYY2doaEY4TlBLOUlud1g4OVlxc0hiLzNjV0E1cXg2?=
 =?utf-8?B?UUNFL3dYMVdKZUpDYzNtdnRPOStlYm44QnR4RysyQ2lCTEhWcXRsdkxSTVNF?=
 =?utf-8?B?U0ViYWNHRFdDZWZxQUYyTFJ6bTRtQkM4dTJRL0E2dGE3R2N5WCtZM1dpWEs4?=
 =?utf-8?B?YUVCRU8wVzdJWHNPdkdxRjUvRnFqSzRTNzRXUTdVWVQ4eUlqZ3NEWFNnS2l6?=
 =?utf-8?B?YjE5NU1tdUlsbE9TaTZsenFjNWxCYi9jdVJHaVZSTkFYQUVRYTQ0SUpabGZs?=
 =?utf-8?B?aFBqcllKZ0hta2NjVDJLV05uRmVUSURnZk4xVWJUMHdxNkJjVllJNFZTZFVx?=
 =?utf-8?B?a0xHclJjT3NKOVNqdXZSNUMvSlJmMjZMWnY2a3o2ZEk4MUhrU3BUZ0NxS3V6?=
 =?utf-8?B?TlZDZUNHa3V0bVhCNXNjWlJKUjlvNTVHTUJkUCtUaDh3RC9uVFpFVDZXdy8y?=
 =?utf-8?B?NXMxUlVMMkROMG82Ri9uSkEyWUlSVnlPVWthRTVTcjVxT1NjV0dYb3FESWN4?=
 =?utf-8?B?ejc5RDNRT0J5VUpXSzlnZHJ6cWhZZXZTY0FwcmRUNTRkR3o5VjB3SGt0Z1lS?=
 =?utf-8?B?cFVnM1RvbTFBWnk1ZVN6WW1SVUhiejZaR2M4WDF6dUJIcDF2QVNtUURhaHg3?=
 =?utf-8?Q?LRPAXEASVKSyl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzVjenhiYjZudjNBbklYUVVZeUw2S0VwWkUrTlR6VHhkcjZZOXFTQ3pyb2xJ?=
 =?utf-8?B?dDlGVnlIcXBBaEdCYjdqOE1pMjVtdmpaUnVURkdKUXIzZm04emIwaUcxNXB5?=
 =?utf-8?B?aUp4TWk1Vnl2enhZUTJXdG5wV3I2Rko0MEduTVFEeWZQNlFUNCtUV09wdzJC?=
 =?utf-8?B?TFJraWJPMnd1M3phd0JnN0ZIYllDQVd6WExjSlJMU3NHVTQ5eWxtb2pZbXA3?=
 =?utf-8?B?amZwOU1mVkZtVXozbTJyZE9JOGRsRnBZMlRUa3FpTnVMV2dxSXJKUHBLL1ph?=
 =?utf-8?B?Q2MxdUNwelJ0cXIzaTJSR1U5SDJ5b3RHTkdOemZDTDBQVkJHSThHd25FWGZI?=
 =?utf-8?B?VzJ6MCt5bkFnYWJTU3RPNnluSC9GQU0xdnB4b2JYTjdyVC9BYjJ6MXhDdDdm?=
 =?utf-8?B?YTRvMVFXMGdhR3IxczJRRHBxRVhYVjFqdlNHaVNiTTFJL091Rk5aaUppcjdp?=
 =?utf-8?B?VTZySEVTdGgyWDFiR3IyMGpOSXBBcS83R29naWtlaHlkZkkwdVB0a3JxZkJJ?=
 =?utf-8?B?RFlLTkNkNDBHSGpJSXo2L1ZSOWk3QVRUNmI5dUNrZVlCYy80U25iTGdjdkNN?=
 =?utf-8?B?SlQ4OWw4ZWN3bVM0Q0tyQWpiVEo5ZmhvLzN1Lzg2VmllclNBRHlCOEYzUk04?=
 =?utf-8?B?YWdVNmEwbzdGWWZnaWNNdElvMWRlNER1THBrUmVLdnZhRCs4RGsxK0NraGpq?=
 =?utf-8?B?cTFOYkk0SlpVK2lsODhCV3FHczB1RVoyRWZTV2ljUFA2M1FwdWJHSUtnRXA4?=
 =?utf-8?B?R2g5cXZWZ2xGa3h3VWtFazc2NTJkeXBCTFhyRW9aQmdJZGhnZmwrUDhETHIr?=
 =?utf-8?B?S00wc1ljUGh3Rk1YcnV5MEEwN2hCb205b3o5UldWUk9NRnFGYjZFTjR6S3Nh?=
 =?utf-8?B?YVhYVnB6bkNraTFoL241bzc4SlNwSG4wZkkzTDNla0F3TFNFd2dMRkU4bXdE?=
 =?utf-8?B?QUtIcWhzVFRZbmVCZXkrVUpUQm5Za0RZVGV0d3d2UmJiU2tWZ3dYLzNrRWRF?=
 =?utf-8?B?dEIxUTQxSUNxcy8xNWRVRU01YUpwNllvVi94WC8xWlFOaDcvWDNNN1Q1UkFi?=
 =?utf-8?B?MDlwb1Q3VkZyL3Zyak51S0J6NTRBUXRRSis2UzZUdEc1ai9XVXZDbTJjYXRH?=
 =?utf-8?B?YWFoeFNWamQzMTNEVFBXOEFBYks4U1M3VnpxVVpTWTJmdC8zYTNxc0ZjbXlQ?=
 =?utf-8?B?WEdiZU5zdXYxZTltNGpBSFl3eUR4N0hzaHMvZWJudHRFa3diWmtPaWVBRmE4?=
 =?utf-8?B?WG91L2l0YVgzMVBXK0tiVm81bkdYb1AxaTg3bzNUc21LR3RzekhQWG1lSHVn?=
 =?utf-8?B?c0dPMmtBRjRJYXNYRnVTcllrS3pvTjNrSlQ4YUU0WU9tK0FzaTBCVDdaZ29p?=
 =?utf-8?B?MnZKWm1XdHpXMnhFNzdJbTRTV2drYmNVZ2dWWjdZTzhHaDQwQTBnd3l2QnpQ?=
 =?utf-8?B?NnNOVDV5NjRyeWNVcFFTSmZQSndVT1BCNmFvUnVkcXdUWHZKMmlaVkpkVU1y?=
 =?utf-8?B?TVR2M085TU5LbXhtY3UxeERJUm1Jb2crUVR0b0ZKSElTemlvSUkrKzZzbXRP?=
 =?utf-8?B?Mk9hVC93U3RCWkk1NHlkWGJkTWl3bEptUEJzcDErWjhoanduNTFwMnVnZkt2?=
 =?utf-8?B?NGIrQ0VnYXAxNDFYMnZuUzZ0YlBvV2pJb2s1bS9sVldGcTJUakk3elhhZnM4?=
 =?utf-8?B?bWpTUEhmUkk5T2FRLzA0NVMwVzBKajJpVHpFYzhzdlJ1aEZDYnBwODdkeFJT?=
 =?utf-8?B?SlF1UEhyOEhuTndDR09EVXdTSDVSQUp0MEY3Y3l6Mzl2SFZhTytQcmRmUFhx?=
 =?utf-8?B?bWxhVWtOc2g2QzFrcEpvVVJBYjVYRFY3RmVnc1dRTGpVQWZRT1JkcmFiUnVO?=
 =?utf-8?B?eVVWRVk4Tm1JY0FjZ1lOU3M4b0JjbVBCRTV5SG9DN0ZPcFplR1Bxc3NHR3Nz?=
 =?utf-8?B?ZmN4b0RraGpsTFAxbnpwcm1Lc1BCS2g2Wmo5YnZ6QVJnZWMvNHZDVk90M0d0?=
 =?utf-8?B?aE1ZNU9pN29MVkNZUzJQcDl0K1BOa0JWUFBXNkNNbEt5dVBURnQxT1Z1RWpI?=
 =?utf-8?B?WlVxMVBWdXVxTDZ0eWpCMmZjQWw0RGIzbjNrcXljZHB3OVJpbTJSdVh6Mmds?=
 =?utf-8?Q?vBG8Q39cfgkn0brdYthCpnS1U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1580471-4272-46f0-739c-08dd6142018a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:43:47.9277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: br3fIA563ELJ29B+WtPZ4bjukiQAaDpdMGvGDtSvCYUctfsQoLFRzh79aZMfLE3w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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
> Adjust configuration and devicetree so the topic-miami board actually
> boots.
> 
> Replace the custom scripting and just use distro_boot. Override the
> standard zynq routines.
> 
> The board attempts to boot from SD card first, and falls back to booting
> UBIFS from the QSPI NOR flash.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>   arch/arm/dts/zynq-topic-miami.dts |  33 ++++-----
>   configs/topic_miami_defconfig     |  20 +++++-
>   include/configs/topic_miami.h     | 116 ++++++++++++++----------------
>   3 files changed, 88 insertions(+), 81 deletions(-)
> 
> diff --git a/arch/arm/dts/zynq-topic-miami.dts b/arch/arm/dts/zynq-topic-miami.dts
> index 8307a2ef9dd..29f0a4f8280 100644
> --- a/arch/arm/dts/zynq-topic-miami.dts
> +++ b/arch/arm/dts/zynq-topic-miami.dts
> @@ -11,6 +11,10 @@
>   	model = "Topic Miami Zynq Board";
>   	compatible = "topic,miami", "xlnx,zynq-7000";
>   
> +	config {
> +		u-boot,spl-payload-offset = <0x20000>;
> +	};
> +
>   	aliases {
>   		serial0 = &uart0;
>   		spi0 = &qspi;
> @@ -35,6 +39,7 @@
>   	status = "okay";
>   	num-cs = <1>;
>   	flash@0 {
> +		bootph-all;
>   		compatible = "st,m25p80", "n25q256a", "jedec,spi-nor";
>   		m25p,fast-read;
>   		reg = <0x0>;
> @@ -44,24 +49,12 @@
>   		#address-cells = <1>;
>   		#size-cells = <1>;
>   		partition@0 {
> -			label = "qspi-u-boot-spl";
> -			reg = <0x00000 0x10000>;
> -		};
> -		partition@10000 {
> -			label = "qspi-u-boot-img";
> -			reg = <0x10000 0x60000>;
> +			label = "qspi-boot-bin";
> +			reg = <0x00000 0x100000>;
>   		};
> -		partition@70000 {
> -			label = "qspi-device-tree";
> -			reg = <0x70000 0x10000>;
> -		};
> -		partition@80000 {
> -			label = "qspi-linux";
> -			reg = <0x80000 0x400000>;
> -		};
> -		partition@480000 {
> +		partition@100000 {
>   			label = "qspi-rootfs";
> -			reg = <0x480000 0x1b80000>;
> +			reg = <0x100000 0>;
>   		};
>   	};
>   };
> @@ -74,6 +67,14 @@
>   &i2c1 {
>   	status = "okay";
>   	clock-frequency = <400000>;
> +	/* GPIO expander */
> +	gpioex: pca953x@41 {

it should be just gpio@

M
