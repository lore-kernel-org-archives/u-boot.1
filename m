Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A45D3B7F0
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 08:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC1DA8965C;
	Mon, 25 Nov 2024 09:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vr7UPzir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 579A28965D; Mon, 25 Nov 2024 09:32:59 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEBFF8965C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 09:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+d3xzGAbCFZ9nrOF+3u3NTa3HnU9Vgq4amHD9Ded85tnLAu6oQztYJyZYh2PQxZH3t9uagdXSncOIzpRsAjYZEiULHlo0/JVSRzTOEDaqJJzKnL93HmeBrYU7xgrPh4SryUiRhbqRzbB1eQnz+pEGEk3mpjcvNbIHL8TEH08jddR0q5qSmv1zk5Dr/dr0fpLQcJ2SrSXelUkW0FEpcGEp0lZBCM6HAxCwdliq09uthQIThXH+8OITyjMk3NCFbMO6KianER2kWCl/CabObUguzwQdK20g5PonMztU0McNeVHE5arc2Gvacbc79TgTUzyRb7KKNzj5l2DT8aVqd2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o5udVYm+DMClwmtD5d5uW39IHC43RbJ9ZhxdXXG1u0=;
 b=K6U2PMwmhROmiTMJjuEuhLumzHl4rugbcKCcpJCEl2WW5abc+c1ApBA/5x0HMZlB4mR3JDvqy1ORasITST0NQ99fqhV/DG9GXaR+DLNjHp0WnOMtmohMlNIibFdN/6xk35fzVKRvRS2sBAQWMKBfj/TB2k4//pk/12y1T8yckdA9P0CPy2iZ2SjO+mbfBgqxpQsqn4kiktHJUgxLCoW0ebjuXoR3vfr38iAPjC96g7QE9RPTwEO5X+PIpy28RzkAMJ2RrJwsE8mF248dqDxH9se/foOxNa2Ozwh96b/FcG02E5Vg2Qi0Ls7CW7cWDNIjvVJNTAb/EG2dG7V3187m7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o5udVYm+DMClwmtD5d5uW39IHC43RbJ9ZhxdXXG1u0=;
 b=Vr7UPzir9kd/QIWSeS+PmQcd/aWjYScsGF14Ke+SdsmGmjkaW9P1hHlnM8GHSI+lAl0FCUsIpiiP1oK3+TnCBRY8MYsJTiX+RqvTJeEnASAEZvI1oeIRlAfhuKqQlNORkmxaLVR66tHf+/Z3KV2V1Lw0XeJYWxMmNiPDJAi62n8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Mon, 25 Nov
 2024 08:32:53 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 08:32:52 +0000
Message-ID: <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
Date: Mon, 25 Nov 2024 09:32:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
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
In-Reply-To: <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bf9bf08-33a2-41e1-4ede-08dd0d2bc0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlhoRHZzck5vTzZYUmxXck0vbTVNY2xGYWpHejRWSW1IeWtpVHFncGJKcmZa?=
 =?utf-8?B?RTQxU2hUTUhNTFNNNGF0S0RncUd0bTVHKzQvcXFrZ1FNL25uNElPNFlCMy9F?=
 =?utf-8?B?b2NTM1hRNG1nelFkMjMwNXV0b3FoOTlRWmxBcWNvVURNOWxkMjRFTnBPdDZu?=
 =?utf-8?B?U1B4ZHc4MEIyUHA0ajVYK0ExUGVmOW5KckRpd1NIdkkyblU3dElZUFozc0ZE?=
 =?utf-8?B?Wm9zKzJIVWVlTGtOZ0tYTk9EWkFCc2FMYUJ0ZXFWeFlQcHJ6anhlWktkYWsx?=
 =?utf-8?B?ZkthNEJ2dWVCVTJjT3pSbE1iU2FIYlNIa05SdjR5L3VUWHMyWXBvbnA3a1lZ?=
 =?utf-8?B?cFl3blVZZ0Q4Z2JIUFlMM3Z2K0lMNWxiU2xMM1U3d2JLV0QvaU10dmdsVU9x?=
 =?utf-8?B?c1h1RVROTndGc1NSVDd5ZDUvK3l4Z2IrYXNyYXVWaWVuTlkzbWNjU1JrMjhM?=
 =?utf-8?B?OFllWlJaK0RJZVFOZisvdkdPL2NLSTVHYUliWUJjbzVEcCtRbEY5QTJ6UlVD?=
 =?utf-8?B?VmlzRFpUY2RvdDJkN0lUdThJNytwTWZMQVpteG1vT0lNM24vVExZUWViZTlz?=
 =?utf-8?B?QzZVbVdwVS9xYjJGanVvc3JZamNUNGYydEVsWWtCTHQydDVWR01MY0tUbzJG?=
 =?utf-8?B?aW1jZXBDQkwvejIzNkhuQjd2eW1KZWdIT0RBK3BWMktZTWxWMWxIb0tZOFNF?=
 =?utf-8?B?bEZKdmEyRTc1ZHJLOSs1cFRwcUJGQ25VSG5jYjRpQndOWkhYM0FqZmtCaDhz?=
 =?utf-8?B?RVhodkM0eFc4dE1nM3RHS3hXWnQ3NWZRb2EzU1A5dmx2V3M3cTl1dzJVQ2w4?=
 =?utf-8?B?TzByclE4eUdzSUovbXhxZWYwVjdTaEM3MnFXWW5sbWs0Wk10Z3NHa3pmVUR4?=
 =?utf-8?B?MDNhL2dlcUdLdk9oOGRuY0tMdnM3cDAvMTlydU9Feldqak1jZi9KK1J3dEd0?=
 =?utf-8?B?dkI2Q3FPNFZSRi8yZi9IK1RSUnJndzNOMW5lb2NobG9Cb1MvSFAxa0lvZitN?=
 =?utf-8?B?a1NCdlVHYnZ5bHpGM2Q0bkV2Uy83SnVnY0p4NjFxQ0h2cTZUdUJKTzdZUjRD?=
 =?utf-8?B?eW1BdUYzWFU4cWV2YnRuazYwaXRFYm9NVFhyZzlrdTQwaXRzZzhDQlJQRE4z?=
 =?utf-8?B?OGw4RWQwN0wvTXUxdkFFamZHMUxoVmxwallCamdjSnRSRUo1WVgwWVpzaGRo?=
 =?utf-8?B?ZGZPVER1cUlaTERkbElRSjNpd0RJYW81NTlJbER1RUlvTEJvd2pBSHdpSDVz?=
 =?utf-8?B?MFNYRXU3U0xPcWNuNysxcy85YzVpVUhmMWxhVUw4RmRqNENSQktxR25VQXQw?=
 =?utf-8?B?NnpIbXpmcUp2bnJOWUhwMFVuMjd5cVo1cU95NnlrVVc4NzZsRjRKWnNMTldL?=
 =?utf-8?B?WHJOQnJYQnBHOXhLRXUrZFA1cWxkdmlWRzkyLzJWREc2U29tQlB5a0c2L1U4?=
 =?utf-8?B?SkI5eGRwNzI1Ujh6U3ZvSkQzbnhJRkxWeXY5ZkQxeiswR3lnUjBkR2swTW5Q?=
 =?utf-8?B?ZzJvcFBWUzBmVGRsU1pTS2lFbUlhVStBelE4RHl4UXBMU3lwdjh0c3VncGxy?=
 =?utf-8?B?U0JOUUdrNnpXbm9MaDBWMGVlaklFd2FiZGN5cWh0UXdFME51RjdZdWZPZWNw?=
 =?utf-8?B?YURDR1puRjdUQkJiK056Skg4KzVhWnQyLzB6b2duSlRkcFkvSkdGV0RSYXZz?=
 =?utf-8?B?ZWtqM3NydVdHSWFLVFBLWDdyQjY4OSs0K2ZhLzFtZko0NU12ZjBIMFpodEJ6?=
 =?utf-8?B?S1BlTlN6VnpvNDZQNWVwY2FCLy9kZk1sOGV5Q1MvRnFyYU9EelUxdWl5Tm5G?=
 =?utf-8?B?K1dxZ0tUV28rUU9Xb0lIZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejV6ZDRsL3BnbkoxQWtnUmdrY2hib0JnbnFmdnZHaWlwUnl1Y0NoUUNmWGw3?=
 =?utf-8?B?TDc1QnYwR0JnQzJnTkY1ZDZ1VlBmRTB3UTJwdWJUR21udytvc3hlS041Ym1z?=
 =?utf-8?B?bVovSzdyaFQ1VmRON01NMlZRNzdYcjdOQ1hFRUpYelcyM0MwSzlvZnArRHhW?=
 =?utf-8?B?OFFjT0o4b0s0TjdHNWVDa0hCclFObkNEaWVPa0dJem5seHdsOU1aS2QrTXRB?=
 =?utf-8?B?L2V0cSthMk1aWmV0SThUdkdIcTl6aWZDMnV3djJ6QXkybDExMFRSTkpDRDF5?=
 =?utf-8?B?ZEs1YkQzZUpVTTRRSnFJMXdZd0lRYlhUUjBvd0hISHpLN0NRMXFMak02eVoz?=
 =?utf-8?B?NUhtUlNxU0srY1p1RlpvWWZGN3JuZWtPZTlqSStock1QV0F2QkhIclp6SzB6?=
 =?utf-8?B?OEJicWJLU0x5anNDMzRBblVWVmtSeUF0VGU1RjV5UmZGZTRjenRyenlOTVo2?=
 =?utf-8?B?akg5cCt2TXc2eW5sejU2dHd5c2QxY2g0N3NwVVRiNklrdnduTWtzOEpUNkh0?=
 =?utf-8?B?TzdnZ2ZqMFhncC82NkJWb2hGT1N5R0t5c3FWSDBLazJqTEVKUnYyNmhBZ0dZ?=
 =?utf-8?B?VEwwVTVyYmUrOTZTQS9XczBER3dhRzZ4dWExYmdMc2VsWVdNVGtBR1FSbjdZ?=
 =?utf-8?B?S1VkRHg5WVpTOEtqM0EvNDRIbVZtUWRsczE0N2FKbkovVFNkWkduN0JUVVE5?=
 =?utf-8?B?eU9uSTd4b1dGTXM0QzlKSWE3OUdMNVNGMlB0ZWlheU45UktjRFBjUVE5Zmcx?=
 =?utf-8?B?QnQzNDZuYjlDZXVvVWQ2bVpjSWhWek4xcy9GUG9BUkYwY1MwRTZSOFVsUmlo?=
 =?utf-8?B?MVF0eitUK2lsUnVQMms5RUlpK2hUNjFySGltM1ZFTmFOS2xVWVlrQ2wyQlFR?=
 =?utf-8?B?S21EY0lmTisxWTZhd0dsL3lSZE5XZC8rd2k4RDBBSEc0TDJLS1NIdzJwZFlQ?=
 =?utf-8?B?K1BrcGhnL0FWbjNFd2wvaXBDRUhrRXNPVVRBNmNhOXFWTVowSGU3WG0vUUxO?=
 =?utf-8?B?cTlCOFA1UFA2bUdVV051bnZLNEUwSGxCSUhSTWRKZFFzaTFWNWlyMmk3c25j?=
 =?utf-8?B?cjdRcHJIWkhPaTVnSCtlT1lUckNncVo3allReUl1MzBrUDZEZWxXc3BSNmZq?=
 =?utf-8?B?TU9TWU5lamVjaUNBV0dYMnRNRnJzQzF1b1d0dDVoNHVJYnJEcStDc2FVTGtq?=
 =?utf-8?B?YjBvMXMyZktmMlNjQzRMTWlHMm11bkN6Smo5dnBKUERIWUtvaFdZQXZjY2p2?=
 =?utf-8?B?TXhEbWVPM2g4Q0RZZWlLVnlzU01tcGFockZDVFN0L3ZONUxrSiszS2FtN2U2?=
 =?utf-8?B?cU5Qcyt6SHROY2xGMlhhb2tndXJ1NUhIaXM2NEdJdkpvaGhuMjF1ZVRaWVNr?=
 =?utf-8?B?WWsvRy9oYy9uZ2I2VnlzajlWM1N3MGl5UFV6VUEwTDZlRnN6dTVlckJ0RjFs?=
 =?utf-8?B?YytXWmczMkFZNCtHOVZXQlliSnRxUHhrcmdGdTJxWGJYNFhGUlo2SWpYZ0Yr?=
 =?utf-8?B?NWZJclVFSTlPR01rSnplYTZ0WUJlSW4zcSt3a1JvWDRSTWhzTHVvVE1FRzFW?=
 =?utf-8?B?c090eVUrMmpYTHJPUUNnaVNLV09TZU1tUlBqQjN2RlU3bW1TemRGU1JQQSto?=
 =?utf-8?B?MGFOeE9FODNVR3U3ZGdRaEU3WXNIY2o2Zld1Y21uOE82eWZ2VWVpcytWRU5x?=
 =?utf-8?B?aXN4SVU2dnpDdktMOWtuNHg3NGtKK1lTSHJiTittN29XNnNDTld4LzhzbFUr?=
 =?utf-8?B?M2xYZTUrNUZPSlpUc3FqR1hTSTJIZWRVa2FUM3R1M2o0SmZLNWRpeVF4VDJi?=
 =?utf-8?B?cjFSVzRxcXlhVjdFWS81aEFkbEhXOVZrcjBWWmdjdS84OUVqN0V4eCtIZ1NZ?=
 =?utf-8?B?N0I4bkxqQzcwMkk2UzJha2tOeUo2d2hQcjk0V0t3OTcxWjNBc0lENWlIbW9E?=
 =?utf-8?B?RXNOdkV3dWZsRmVtRTNBNk5NL0dUMDkvNWE5NHRSYzNBR2Vzbm9RdFpLYXk5?=
 =?utf-8?B?cURoSEdNMnNvdjExbGdrSXJXUWhHVDQ2YlhPVlNRU1laYStFVHlpUk1nTjJJ?=
 =?utf-8?B?bnBGbFMxdFl2ZzBnOWtNZCtQam1DdmpCZ3UrbUptem1QcUdTclREdytTTXdP?=
 =?utf-8?Q?fR5bAH0WwCn4f8pvzgePP1eDl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf9bf08-33a2-41e1-4ede-08dd0d2bc0d1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 08:32:52.8933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e27dmoxjU04zEKhx1x4lrk9xfG2u3AkPkiYs2wh6p3IFnQG0YkjgJum+hItcCV99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
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



On 11/23/24 22:45, Heinrich Schuchardt wrote:
> The CI uses the following command to launch xilinx_versal_virt_defconfig:
> 
>      qemu-system-aarch64 -M xlnx-versal-virt \
>      -display none -m 4G -serial mon:stdio \
>      -device loader,file=u-boot,cpu-num=0
> 
> 'usb start' or invoking eth_bootdev_hunt leads to a crash when function
> dwc3_core_init() tries to access a register at offset 0xc704 (DWC3_DCTL)
> relative to the register start address 0xfe20c100.
> 
> Disable CONFIG_USB_DWC3 until the driver problem is fixed.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	new patch
> ---
>   configs/xilinx_versal_virt_defconfig | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index c8f166c1221..06a240173ba 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -153,8 +153,6 @@ CONFIG_USB=y
>   CONFIG_DM_USB_GADGET=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_XHCI_DWC3=y
> -CONFIG_USB_DWC3=y
> -CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_USB_ULPI_VIEWPORT=y
>   CONFIG_USB_ULPI=y
>   CONFIG_USB_GADGET=y

NACK. That's not the way to go. If one test is failing in CI disable that test 
not really support which is for HW too.

Thanks,
Michal
