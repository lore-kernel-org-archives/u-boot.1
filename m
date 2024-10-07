Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6805CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 07:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBE888DBA;
	Mon,  7 Oct 2024 09:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mr6wu8xs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83F3288DA4; Mon,  7 Oct 2024 09:31:52 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7129A88D5B
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 09:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FbZYmRkwC3AZiLU2U+IYHJDaWnuV8grjuAjNxbUL/D7ilYt/6asO0Je7erb3/AB1c9Xzy86S2XspMSCg50qDhB2BM3iZNUIO/HWJ39ZOtkPnYvwLdp//cgB8hYwBKMVTQNUnE2nL794s/88Ej0vuEDUAfzCEiyqmX9nj/xg3UdLtoJ5dB2AYUQdn308dv84kzwg3OQJiZ+qTbkOZUXNIIyyFDLIuCZJHG+GHcALRNvh3SEw4cUJGxDVd+4kGXkCYwQUvnjHPW/iigYMApDvgQgi/9xOoiPU9LU/nBy2+xbkh6aiDo64BJsuQnFeFi026AXorlHI1txx0wQrAKmX6Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/scyZI/ehWrmK4e/E3ixgZQ8BGvb3dObP4JZr5juq2E=;
 b=vGoZ0PG0CuMbg+1UGNtukXTLzvPjnxFImeWOlIhmOTiBVE8X88qBYXshTCH/wIUFigBj6EEZKyhPdzlNnbmswxtJd3kVp2E+H0EejMiGMbm81sIO/0gT2ZOR6LLRCxHKYhVIWjAEQt3xC2jhd0XJTryu8IqWA2G0jelstirzhA2Bj6ObXMzSkUKTcVflYWjzpMGFBYTKiYHP3zTBFmuLnyiQaojDP/djQFTznaJ8IaniJ1/N/N21t3Ot4zdeJmmKJISfj5pecleQ33Gl+ekndiDjAoYznkrOClxGq2AG2hi/40RUBjdAAKOFepu3KEA0oHqJE9FIK4oaMQE/T+wv8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/scyZI/ehWrmK4e/E3ixgZQ8BGvb3dObP4JZr5juq2E=;
 b=mr6wu8xs9+KNE5ZMGzuaRL+f6kZBo0fK0jgLoYsmrv6+ZuB9fwJe8k16+MD0UlmfTx34QOnUKSfp+5Yyz2kPQFb3e/7+IRiwk1ZOsuKH+eKaJKeZhKywYa8kvGW2RlkbkfaMF/JgbEETucpdYCb3eHWX+Ql/mcKc6f+rOEL4HmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 07:31:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 07:31:48 +0000
Message-ID: <f0690811-e19c-47d7-8fd8-95b67c485805@amd.com>
Date: Mon, 7 Oct 2024 09:31:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: versal: Wire USB0 in distro boot
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
References: <f148161ee489d19d708df1b4fa7477821e06bb55.1727694230.git.michal.simek@amd.com>
 <9715605c232ce38a36a200204c14208b9d76cd83.1727694230.git.michal.simek@amd.com>
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
In-Reply-To: <9715605c232ce38a36a200204c14208b9d76cd83.1727694230.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0036.eurprd02.prod.outlook.com
 (2603:10a6:803:14::49) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4307:EE_
X-MS-Office365-Filtering-Correlation-Id: 21c4c51c-914c-4a3b-5ebb-08dce6a21a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ME16MU9VdVVpWXJGUmlhQVY5OGZqQzFVM0VBTFVJV0ZBTHltQ2ltdGhERkF3?=
 =?utf-8?B?QjNGOHg4SnBlZ1h1SThkcVhwT0NvejJmMkxITGFUd25ha2YzTEFkU2hrYUZX?=
 =?utf-8?B?M2h1Ukk0RThIK0VabWp1VjhkN2xFMDExRGlLSnpVRWs0Q1M5U2lVMTFyanJW?=
 =?utf-8?B?cUpqQmtvbWRlMi9Jdi9wVkF0disrMFBoZnQ1ZUovT3lVMlZpNklkWHFYa0t3?=
 =?utf-8?B?bmU0cHIyMGk3YURXTExTV3BhNXdXWGFTdUVZeXBIK1YzMDJlNzlaKzNGbGRM?=
 =?utf-8?B?clNwdUNCRzZtaE5RVkQ2eFpRTHc0TzVHdnk2c0dUV2hhd0FIUzNjQnAvalcz?=
 =?utf-8?B?d3lHaDRsSDRpQ3lVaTU1dGxLb1hiSWtSNGtITC9nMzdXay9wc1dING8waHpV?=
 =?utf-8?B?THN5QzVGTGs2Z0Jqb3JVc2c5c1F0NUt4N0tnbVN4dlN3ck5aNFJUaldFVHlB?=
 =?utf-8?B?WE5CMW1jU0VJL1NDUW5IMWxJWVdZRk8vVVdWakg4RmxlQXdnaFF4aXRock5S?=
 =?utf-8?B?S3VNVDZQaVVYTjhTMUNMcWgrWSt1ZENOMUM4QVRqWFdpdGVwbWRUeWYwMGRF?=
 =?utf-8?B?MnBNRm9RRG5XR290c3VSQ1ZPb2o5WmR2czJQOCt6dUNSY0N4U1F5dHFjMXdq?=
 =?utf-8?B?UHBqNHp3ZE90M3A2YUo0dUNKUkVwN1grV3ZJZnltNWR2S3E2Q0trT1FyNTFQ?=
 =?utf-8?B?cVVIUjM1akNMbVJxeGxubjJqUzg4RWFTd0hScEZ5U0h4alZCajRXNmxQZlRN?=
 =?utf-8?B?dXdZUTgyeTNsakFLV1Z1VlBCblZHTGthMXZFNWdiRUlpL1JQb3VEWDNZVTVC?=
 =?utf-8?B?b25JSUJUWmlSVVJpYkRaUmVTcGU5d2szSVpPUG5zb0xjY01jc2I1MllUZHI0?=
 =?utf-8?B?VlFudDc4QU1aUnd0N1FOV0RlTTV3MXlYZ1FIa2N1N2ZWajhGWlk1Y25uTnZk?=
 =?utf-8?B?aUd4ODhhak9TeUlLTWQxeTV6Vzd6emoyWlJoNWwrNzI4TlU0RmxOdFArRE5Z?=
 =?utf-8?B?d0loZXoxZTBVTWJ3Z3JxazQ1WEpwWEpwRGk0TU9LU3VVZEczc3J0YXJxc2hD?=
 =?utf-8?B?M0hWZi9SWWhMNzI2M0lkRWFZTGlwK09UL2lMRnlTbThiMkVnRnRYN2RCaHhP?=
 =?utf-8?B?WHVWRktsaXpTWVRLV2czdHBVc294djk1bkM5SUNNWVIyS1hqOXZJWVhMQ3RC?=
 =?utf-8?B?REJvNUM5QU0wZVkrWG5CaWI0VERENGgwR2xYdzVjb2U2U2ZGV0dBa09Vb1pP?=
 =?utf-8?B?dXViK1FYTm9PMEZKS3g1OHVRbGRxNVJ3NHBYcVBrUkZPQVZEajJlREh4SGZK?=
 =?utf-8?B?cXVManlaYis4SzlXd094d0tOb04xaFIvMnBjblFEY0p3djFwZysySXZWR2hY?=
 =?utf-8?B?UDhlTXplUTRzUXdCZmx0UVcwUkNTdGlPRjhPeW5SVXI2ejlCblhBTTF1bHF5?=
 =?utf-8?B?S2lCdnRvZDBoeE5jdFR1VlRYcmQ4dTJudWZzblZtdk9IQ0szLzJPS3JxWXhl?=
 =?utf-8?B?RUNudzRmWUNUTC9rd1lHSWFvM0h5YW03S2djQ3NqTmtOUFBMbG1hNTFLbVFK?=
 =?utf-8?B?ajU5a2NTemxVWTZQTXRWVWt6RkF4UlhjRUlrYzRpWTR4MVR1enZna1psTS90?=
 =?utf-8?B?S2RvR29EdXdTaytlbFIyQ05MQmhpT3dCcHc4eElRYUg3Q1B4SUZXSVp3dk81?=
 =?utf-8?B?cS9XeXBGcExqaXNlSzhuWGZXdG42WmVSR3N4SllVZmxCMllKY3duY2xBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFNnWXBUeWliQ09BQnlzVjFWWjh5MkZiMk1wVjRGSFc2Qk1mSjBTcHBta09O?=
 =?utf-8?B?RjhkVDQ2WDFzSkRhaTNTQktyWGVoQzV3WGNhZHlVSno5dlZRQytDai8wSWhY?=
 =?utf-8?B?RHhWS2FrRDhoZlp3RVNnT0JOQmVvdk02L3h6YXhUODY3SndLOTlTUkpqRmV3?=
 =?utf-8?B?Ly9WTmxFMVpJeHppazhhRzlWWUN1TFNTd3Z2d1hmNkVOajRTYms2Qy8rcVVP?=
 =?utf-8?B?VkYzakNlTkhLTGlucXNTOFovR3c2aTZiNjZYU0puaks1d3RsdUFEdTdtSHVL?=
 =?utf-8?B?d2IxcXFSZEJ0Ync3Mmh0NlI4TTgrcUVWTFpDMExKUXhKR1lKMFZwSlBmVjNG?=
 =?utf-8?B?a0N5czAyWnpJdkd6RGJUcGVHYmVteWpMcG5Objg3ZXhWL0lyQmdLbkc3bTB3?=
 =?utf-8?B?ZFcydkZFbnlsN1IvYUR0dE1ObGJ4MVQ1SEZ1SGE0U1VMK0wxL2tBTFlpei96?=
 =?utf-8?B?WjI2ZmtMVVZEVmdhSnExZGU2c1IxZjlKYytLQldPTzhTZFU1NHE2MjEwOEtL?=
 =?utf-8?B?bkR5K29UQVp5WEttU3ZBZ1h0ZFJ0Y0F1QjVzQTFMWXkvNDZnWWMvS0YyY1BO?=
 =?utf-8?B?aWVJQXR0TDVTOWEzSnF1TFRxVzExcE5KK0hobDlNSHVHR2h3NklId2Yydmp0?=
 =?utf-8?B?STNqbk1waDRuTDEvaWZpSkU2TG5zRVYrbm9UWjRVS1RVTHNWTTJyWFllUmpn?=
 =?utf-8?B?TzQyV01UTjVJRDhweXJHVm45ZnZKSmtIZXNrWUFPSnhvY1FySXBjZ2pmUUxq?=
 =?utf-8?B?ODJ4YTU1UG9CbkRySjk4RVdOV3lwbWxyQU1SeTBLM0RsRkRhK2gwaW5lQk5s?=
 =?utf-8?B?TDhkZlA0L2cwRFFwelFWNjZtZHMrbVFwVC82THFPSVdwNGpJS0gvSEVFMks2?=
 =?utf-8?B?cXMwYWxjVTgyZ0g0Ty9UaElBdFBXQk1IczhybDR1enExb3hSUVQxa2x1UUFm?=
 =?utf-8?B?N0hyQXp3eElMVURRN0lkQ2xnWGNYNDB6VUhYNlI0V1dJendaYk1GZ21QbWhv?=
 =?utf-8?B?K0I2UnBHdTQyZ29JaG03M2xUUHJlc0dGemdva2Z0VzZKWWNvZ3l4MDFkUHc1?=
 =?utf-8?B?SlhXVmd1Mnh6RWxsOXhUYnEyS2gydEFKYmFHTzVBdlR0WFpBV2Q5US9keGRV?=
 =?utf-8?B?RTRkc3E4NklFSUhiV0t0Wm94dUY0T1Y3OUN2cTZLQXJJeEFyTkE1T1lvaFph?=
 =?utf-8?B?VEloajZaM0lHK2prNzFablBqVGd6R2NWV1pxYXc0Q1R4T3NtWDFkeHVZSDBw?=
 =?utf-8?B?NDdtRGdTU1g2VkExY2M0dmF0dGFHUHNnKzdIRjRUNDJNMnd4VG8yV0VSNXY2?=
 =?utf-8?B?NDg2ME82bUoxUCs1cjNKOW1EQVFvNUsvTVhZNlQwMnpkMkM0K2MvM0lRSDlw?=
 =?utf-8?B?RmFiTGZhdXhFU3kvdjU2NzBIS2pCWmVjNUN5YWQ1LzJ6dXY4OENQTzBMM3VT?=
 =?utf-8?B?VmxSWUcvMlNXRnZsZ0EwR0ZuWFZaUm5oZ0MxQTFCVDFoTnJDQ0dUeXQ2Q0lD?=
 =?utf-8?B?TUFhcVFGdXp5bjIyOGNDbTB2bGdQdWtqK0NLZmhWNC9UNFUvQmMzY1ErS1Nt?=
 =?utf-8?B?MFJQZHlSY2JQbmNQRWFLeTRzN2VteWM3Z1J0bU1HZkkyeEh3QlM4NHVsVVBj?=
 =?utf-8?B?MVJxVUg5UWtzZWNlS3JieUJVcGhCek5XaUNXWWdTRG56NTluZS9handtOE92?=
 =?utf-8?B?c0pBZ2RlTU1KMHZxdTJVemx0cEhvbzlxN09SaEoySDlYdHlKUGNZV2VLODdH?=
 =?utf-8?B?bXp1OS8vZVB3YWZtamVNeEhid29oNC9JWjViQ1RkVWhWV3NDSHlUV1ZlUDh3?=
 =?utf-8?B?LzJiMU1DVEM4UytwaEdHSm5EV0JTWmNORFF2UVFoY2Y3eksweHB1OU9RUXpa?=
 =?utf-8?B?NjFzYzRybEJKUlR6aC9SYlk3dFdCTlhBSnROM3lhOEpObS9KZHlaMjNMZVN4?=
 =?utf-8?B?bFltRWdEWXRLSEQ2Wi8rSkl1aytDb2ZrNjhWb2tGMHZYcjZEVFZUbndJRXlh?=
 =?utf-8?B?cnFpUm5YeFMrOUpTNzRSYTQ0RFE0RFU3WWpyN0NneEk5MDgva0JlaXZhdDJz?=
 =?utf-8?B?bEhzVm01Z0FqL1ZEYVFkNU05am5pL0N3ZUorQTZyNWtqRGpYVGtEZmI0S0FO?=
 =?utf-8?Q?et48pOi52wPMfivbeJM5ZCstf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c4c51c-914c-4a3b-5ebb-08dce6a21a2a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 07:31:48.0059 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AeIMxsgzHST38sg0AeeKd5E/9sz0Aev4x5JygSClZa350l7jRauSm2pM3Zm7+W3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4307
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



On 9/30/24 13:03, Michal Simek wrote:
> For unknown reason USB host hasn't been described for distro boot that's
> why wire it now.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/configs/xilinx_versal.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/include/configs/xilinx_versal.h b/include/configs/xilinx_versal.h
> index 212dc9df2a2e..64f123424cf7 100644
> --- a/include/configs/xilinx_versal.h
> +++ b/include/configs/xilinx_versal.h
> @@ -48,6 +48,12 @@
>   # define BOOT_TARGET_DEVICES_MMC(func)
>   #endif
>   
> +#if defined(CONFIG_USB_STORAGE)
> +# define BOOT_TARGET_DEVICES_USB(func)	func(USB, usb, 0)
> +#else
> +# define BOOT_TARGET_DEVICES_USB(func)
> +#endif
> +
>   #if defined(CONFIG_CMD_PXE) && defined(CONFIG_CMD_DHCP)
>   # define BOOT_TARGET_DEVICES_PXE(func)	func(PXE, pxe, na)
>   #else
> @@ -118,6 +124,7 @@
>   	BOOT_TARGET_DEVICES_XSPI(func) \
>   	BOOT_TARGET_DEVICES_USB_DFU(func) \
>   	BOOT_TARGET_DEVICES_USB_THOR(func) \
> +	BOOT_TARGET_DEVICES_USB(func) \
>   	BOOT_TARGET_DEVICES_PXE(func) \
>   	BOOT_TARGET_DEVICES_DHCP(func)
>   

Applied.
M
