Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04159C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:05:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8409A800B6;
	Mon, 20 Jan 2025 14:05:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3xHl/Lno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B81800B6; Mon, 20 Jan 2025 14:05:02 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::629])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330BA80077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:05:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1yAz83TEbX8jxfLL/uakoPOoM6HGY3umzs00zwO3xQo6qO14DOBBm9oX/Bu5eTgrvLwZ5Q3qaVPCAFT67+1y6zs8qrmStAlhUXPFdYLG8KWQ/UP3dVXNThApNuqW/5N+ZFnwJ/cTeq0gLScA1E1xVHogVMgNolYXiYHhTiUNow3SeOpVT9uO1ipu+oaE1yf1BScbgcl4ltMpqupp7sSxSsG0HwcOA308GZSJhzOw/V+1UmPkP1b7m6+9niaS/u/M762bowfNTmt+BwURYWsvL9fyul+AXmdAwPYIirmrVCC47HXP0WB5KxndEBQ/OdFBNXBm4C0sJkzwUl9I2JIeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OAr0bFRnJiYrkGJybYKZR0qDvb+UDcVtoAStCqVTC0=;
 b=l/v9n9MvzWwiPahuisZKa30jFU08nUW0iv/qfqVrZnix6dkFKhtKwJlAEAR2j7sjekPs+3QGLy0sK7LDiNwWCvL74CFgQbyKK7SIjSIgp9MzKSn24/pkuQ3JlgVMoMCBnFFD6qKfPNkMHCHSS6GmHY9oTlaMdthV5ASpUlOW2kkg2v4zEkpFmBhul571EZ/ImNMBxqfYMQO11gsnK9L7thrT4aspF5WvVFrwQ8FStduhyPapXURuSzm+lfWNwo4H6qjwqcc6M+BqQ9meo2oEPJgEUp9AbTO1ldYDy635Q4Afy2GEV1iNP30CAXvx80QLKg4UZw8fQaK22HLDDQ3ipw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OAr0bFRnJiYrkGJybYKZR0qDvb+UDcVtoAStCqVTC0=;
 b=3xHl/LnoYLpv8oSUDNyA4r9cQhdgTiKxg370GKtLlbLxgMSLL5ze+QzitOVl4vPKL+PuP+L9/UfnWtn+HITrVxP3p64uHMiJjACCrvbB/xbvtfmpiun8TBY2QVSR9pWLs/vuP3xePEmbApHqunP7jlzxwX//WkzGM3FmJTP0YK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 13:04:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 13:04:57 +0000
Message-ID: <0315f6fe-7fc6-4213-9686-f19cfdf1a405@amd.com>
Date: Mon, 20 Jan 2025 14:04:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [U-Boot][PATCH v4 1/5] fpga: fix alignment on fpga cmd usage info
To: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, u-boot@lists.denx.de
Cc: ada@thorsis.com
References: <20250120124402.1501320-1-ibai.erkiaga-elorza@amd.com>
 <20250120124402.1501320-2-ibai.erkiaga-elorza@amd.com>
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
In-Reply-To: <20250120124402.1501320-2-ibai.erkiaga-elorza@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0226.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0a4fdf-a913-4c19-c3ff-08dd39530a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2NKVGdJeE5kNFV4aXRackVWVks3RHRrRVVBa3pRZkd5T3F0YmFCaGZXSk5l?=
 =?utf-8?B?ZHlRby9mQUl1dW80bVJaTW5DUEllMWdMa1FndG4xVFkxTlZldWMyNWwvZTFz?=
 =?utf-8?B?SldlTlhIU09kRFBMekUvWUdlWFFJaktDbGJtOWt6UVI2eFBIVE5XK0g0TGpz?=
 =?utf-8?B?dlBpcUU0VUw3SHhxUlYyNkMvZ2Q0aFFuMGlmVy80VG5VSnVGeFBaeTlOYldF?=
 =?utf-8?B?Z1Bia3ZvYkV6WW5Rc2FpNCtvRVIwb2ZNSUl0bVB4bXl0WE40MDhSUkU2ejlG?=
 =?utf-8?B?RFdrTE9hbmh4aDM3V1hFbWNoR01RYzVKWG1rL3B4YXJFSkdTbzQrd0tTUDN5?=
 =?utf-8?B?ZGNJSm5hZmNERGQwdFlaUlNsK0hya3FLTEpTZUZ0MHpOZnNmazhRb3duRzJT?=
 =?utf-8?B?TFRHc3B2a1dpaDZuYTR2Y1VrWjJadStuVmlKeC9JWEhQY3dXL1IxVG5nRURp?=
 =?utf-8?B?bytFc2w3ekhxTmdrNzBiZmMrR3l4NWQ5dWJtUVU3U1hKbldsUmJpZTBUbXRB?=
 =?utf-8?B?Y0w2Y010NzNNdVVCTDFMUS9wd3FKNDBFbjRORUJCeFFsMlg1cjJkVzloeW1k?=
 =?utf-8?B?VmZkYWRBdDM2ektUUnIvZ21KbGpZQTB6eUFITy8vWjdoQW4zbWhldnplMERL?=
 =?utf-8?B?WkdsR21pSFRYYnErVzZFcTJmaG95WXdrRGRCQi8ySlpNVFRwaW5KSmUrckRU?=
 =?utf-8?B?Y3U4aTBBS2JLai9KeHEyeGUzOEc1T2pvbm5oMkZkZEpKTkpOaFNpMktpUkNC?=
 =?utf-8?B?U3Jmc0NqNmQ0MFE1TlQyWSttRVZYVmdpelVaa1AxeUI2MmI1anQ4N1pCem1u?=
 =?utf-8?B?MG1wUmkvMXRXQWI5alBlbGN4ckdRVUkvVU9OZE13WStFZHpuWnhSZ0lVWWlH?=
 =?utf-8?B?ZVFkc2VFWUtsUnNwRnFjR3BjbmFQNEhJMGFXNVkrSmtMditFL0pCekt3Nk92?=
 =?utf-8?B?L3RablczMXUyVHlFZ2E1WVF5VGtSaHY0TWxZOEZMVE4xWENwOUxzaUNZT3g1?=
 =?utf-8?B?MHZkbXhtSVU3SWF0QlMyQmMydTNmcGpJQ2EvcG5EZzhUM2pGdUR3emZZSy9Y?=
 =?utf-8?B?c1V3WTJSOVNKT2IvMGo0UUx2Ri9NVjFpZXE4MkRNcVRreUJpNkY1YXVOQm45?=
 =?utf-8?B?TXRvREpkV2dobWp3U2Z4MDFQaFMvVUhVWEYwZ3J3WVhXNkNxcExTd25ZVE1L?=
 =?utf-8?B?YzM4L2RnUVRiT3VsbitFRjdjdGJxTThJdWNUWTdtcGhBbW5MTllzWjBpRU5l?=
 =?utf-8?B?Zm1pc3I3TW5DanZYaTdjTEY1TXdZNjVRemJiSUhaYmwwTjJEVkJWUWpxd3Zs?=
 =?utf-8?B?SWFkaWRTcC8zUTAxbDJZWGdpSE5uTngzMkp3Wjh4RnRWUFZ5UmJlSkpvVU9W?=
 =?utf-8?B?QXA4OEI1QUg1UXpIWmlMSVp3ZjJjL3ZxZEhIZUtIM0F6MFFOUFBPNExyanEr?=
 =?utf-8?B?amJhTFpYbTY0bDQ3TFFFejVvNmdSN00yMEw0dWR0cXRxSS9QZlhxc1A3bjF3?=
 =?utf-8?B?NFRNbGtBZzh1d1ZjMTRTejNLeE5vWkNqZkQwUTBqVjFNQ1NZMUN5VlR3Yk9h?=
 =?utf-8?B?U2ZUZW1nV2lWV1FNbWh0Mk52THFWZzFIUVE5d01JNGluMkFuU1Rmc3lzcmFq?=
 =?utf-8?B?cXltV0tNWnRuZitXa3hBbjVVdVVGb2xIaVN4akhVL0g3M2ZDa09CNkVmdS94?=
 =?utf-8?B?cjB6aGlHeUlmUkd5UDNaNWs4TldZUmFGZEkzWTJ4MlhEVWtOSk5DUmxmVjZQ?=
 =?utf-8?B?RFRqWk81NmVNRHRibWtjRU9MZTdhczl3QzdOcE9nUE5LMThIRFdMTVJIbll0?=
 =?utf-8?B?WHJ5YkZvM0kwMVIyQVdtbWszYzY1dFF4OUxFOWJ4eEtZVFVtZXJnUm1oT0lB?=
 =?utf-8?Q?wyhbR6tvJDitI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdkTWhqbzFzZkw4cmxIaGkrcjNwU29pU3JKQlRVWk1XSVkrUVRKU1hmZE9H?=
 =?utf-8?B?aCtjWHd2Si9XamsxQ0pEQXFESVE5UDdYRmNBVTcyeUtpaWJuODJQWmpGbkxn?=
 =?utf-8?B?YjdXNGM1YXR2cVhWZ2YzbHJHUnJZSzhwSmxxNzJDbUIxZHlHTTlIdHVXVUpK?=
 =?utf-8?B?NGUwTjFvZHFBaXRjSVBxb2VTRk1JbCsyelpmd0RJcjVBUmh3NzA5TEF1Nno3?=
 =?utf-8?B?TGk4WGlsS3pkc2F2aVYzU2xEOStKWFpTUEdZVzkvN2RkS1ZNdkJBOTJhWUlG?=
 =?utf-8?B?UDZlR3FvODY3enpDWWNNRDVGOFdJV013czZFRUFsQURvZW5USDZTZ3JxTGE2?=
 =?utf-8?B?VTdmeVIxYkJtQTdabjRZcXNscVc1NjFVOFdMYmphbTkwYkZ5SlZMYWNmMERJ?=
 =?utf-8?B?a3pHRGZvUUZIWlNkdlFyMnRUZ2VLdUduZndEeWZkUDFpUkZPbTFaNXA2S3Mw?=
 =?utf-8?B?T0VpUzAyYzJFMllHYnFma1ozWS95SHl2a25Rc3o3NFNHL3duc2NpeTQ1SHVW?=
 =?utf-8?B?WTExMmhsRHp4djBUdldaWGlFVVpIREF6V2h3REF2SUNiN0IxSzZlWk1yZXo3?=
 =?utf-8?B?SDVCZWRjSWh2RWFVcURvelR4R25MWWh5dHpVdmdHRmkzZUh4OEZjQTZrRWhM?=
 =?utf-8?B?cm1UK1FRYm1jQXV6N28vc0paUWEyZE5YVXRUb05hVkViMGZnM3lTaENRYXhH?=
 =?utf-8?B?LytGZGpuUTViZndTbnNwU0dJQ0kwMUg2VFF6WHRsa3FhbEJGbkV5RlhMVEdr?=
 =?utf-8?B?c2Z5WkdZOEhSbTFwVGtyTkN0cnFMRnNXY1MxRVEzUnNMa3NnVHoyc0VaSmkv?=
 =?utf-8?B?b1V4SUpmUmVIRnBWc2pEWXBMaElWNlY4c1M4dlYydXlQNWtMTkMyZ1NOQWRL?=
 =?utf-8?B?SThjNkUza0hPR2hWQUdnOEdiQ0FrUks1dUIrVFFUMDh5R2o4T21vc0N4RHhp?=
 =?utf-8?B?TjhBSldIbFVBbytUVlhjS0NYMURCUDB4UzFNNnpNQzFIZnFidlpxZXVEYUFl?=
 =?utf-8?B?cUd6MjVFOTVzekFWZkZMaWZONmt1ZVlCbzRRUjI3cG5LdzJsVnVLc3pVRWFL?=
 =?utf-8?B?Tnhsc3RBM0U4NmtsSFRUSStmVWFDQVAvWWtHblkzeHh5VVZad3l6V21qYmpx?=
 =?utf-8?B?Z2dUemNWbWhiazhRYXVBaGI5Z1VkUENILzRyQjI4N2VwYmFSQ0MxY2dZN2Fa?=
 =?utf-8?B?Y3g2YnBnSXlsNk1oaUIzWDlESWc2cWhlc2x2WmlqbitDMmNUSCt3NEpMOHFz?=
 =?utf-8?B?OVdKcFU4OGhXYU1uM0pScy90dmo2RGZ2YU9pRlBFdHk5TTgweDZIS1lhcFcy?=
 =?utf-8?B?MWt2ejgvNHFabXQyVWpwMEllNFB4ZG5oalFnWkZWZGg1VDRsc0hLaGwwaEMw?=
 =?utf-8?B?TEk2Kyt3MFM4MTR6R1N2b0NUWEhvdXFPS2tNemJKUlAydGFTTFFoSW15SnBV?=
 =?utf-8?B?YjErbHRKaDQ0blRxTldYenRjS25sbGhBdVhMM3FRYXBqb0ZMR2I3WjBrRWhp?=
 =?utf-8?B?cHJNUVEvbnBhVVEzbmZBak1Bek9NanBHdVA0MjFPU2VNNDZWbm9YZHFlNXd5?=
 =?utf-8?B?TUhpWlkrbThZcXhseDgrWERzd080dDZlNFA5NDIyaHY0UVZQa01mbVM2bmFK?=
 =?utf-8?B?bzdqMUVJbG9zcU14aXVsUGlkTDZvSFdNb1UwVkplTTc4RjVCOXFYc3dycXU2?=
 =?utf-8?B?QWdGWTdPUG8xV05MWmppWFcrRDZTUlp2b2VUYjJaclptWmk0V3I3cklkUFJ1?=
 =?utf-8?B?VEZ5Z1crdnJ5bGZzTWo1SGF1MExFTjA5TUdNcnBzOWd5dVpzOEJsVk9aQUY4?=
 =?utf-8?B?M1JpQThwUVFUTFpqdVA3Q1ozZE1Da0pOZUVjRGpISTZlclpydlJjeTJ2VVAx?=
 =?utf-8?B?Z2w2cEl2SVBRcmp4R05TQnkydjR4eWp5L01kM3Z2cXFrNEJQNitYQitzb2lv?=
 =?utf-8?B?OTVGanVDVU5ZalJ5ZUFMSThWSm1hWUF5ZytTVmtFSlZDSmxIRUs3d2dMWjRj?=
 =?utf-8?B?NlNlWlpxdHVCQWlIVnhjV3BIZ3BKMjRFSThEK2dzeU5NZWQrTTk3TnQ0ZUQ1?=
 =?utf-8?B?SDJDTjRXSDE0UmNMNFFKRDZONkR2YnFVeC9TMStBRHJVSngxNWNGVG9UNUpM?=
 =?utf-8?Q?A8NLBQg3AQoeOZYBk3nxLsbTw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0a4fdf-a913-4c19-c3ff-08dd39530a2d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 13:04:57.4655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3ZDBIZe9shGMHGeBEWFy1d1CqxeDUo9MgK7JqLUTu9xx514Brjvps9qXst45ijM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
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



On 1/20/25 13:43, Ibai Erkiaga wrote:
> The current implementation generates some alignment issues as well as
> some overlapping when all the fpga command options are enabled. The fix
> is intended to improve readability of the usage info.
> 
> Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
> ---

You got ack for this one but I can't see it here.

M
