Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2801C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE11885A9;
	Wed, 29 May 2024 16:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m6RMm367";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7744885E8; Wed, 29 May 2024 16:41:05 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD50C885A9
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=md2/OshQTxdzojCaeuHIgceigDLOKmA5Zo3s/7MpBj7lrM9/vpZLvNv9rXamSOaBk0prYuZ32Qd89RBoeeg5xOJ9r+hoEQtOmdnDj8hYm3BvOFydwHsVCOOWBXVKmJBV884V65vWWs0loxFjG3HHmo7cThGnDK9HbY7Q96YY9gVGqYsVPkOX4yo6wcbIuOmXoyt7PO95kn0IU/isx0pn0gsDvT+8KSehuLVnr8eaB8xk68qDh8OIroz3Zk7Vn/FF1Gw+gGasotyVUjjKY0meZT4/w6d+Cx76E7rAHaQ95ofxU26S9JcrYPb89E2a/NCTG5kamPM5cOXmvl89XozOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnZUI4TGikNmfQlgGoR9YAwr4HQRrY878HXUoQyOy7s=;
 b=od23RUW1E3O971laqjXkbqEnhFpeuBAP4WprA+fZhNDLxsoIFmDw/CaF4BpPMnYEaEsMjmcp1OmarsVZVfJ36HsBclVs0hitvU8oiMpjg1J5GB0nUV0g0QuPc8NsncLUpsiUXRqYeDEHFlawLim3hOwEeCbkbKhHXySLqQJCdoGh0eW6sIPMOdBXTfB/lGTXVUusfL0ELRqFTu4nyI+HyKPUI/CsdwryWHU7w8oMptqo/CQ4vsMJ7ydGpsFSXX1XikmUrzDPs90NbzbvhAnHNP8OEz4KyAXY70CP6SUTi3KE9LBZXXW79VZ+6ue4F0bVRYLoQhiWBxxh80zvlw/xmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnZUI4TGikNmfQlgGoR9YAwr4HQRrY878HXUoQyOy7s=;
 b=m6RMm367onDtS+rzLt94Dm1ItICnKe1y9zO9hZXmf3LjqGyVacrVPQfrDmQJezx52vnlwWtmEkLcBkDI+uNGeeeBCEl+QsaIXwts/CBbFhatfF0oJu6rvEnab5MSLybhecg3apeymq6A/+GODfQhF4EbmvZfhy7ucs1VwgXq2tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 14:40:56 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 29 May 2024
 14:40:56 +0000
Message-ID: <b02310cb-ac56-4fe5-9b72-f145563e2145@amd.com>
Date: Wed, 29 May 2024 16:40:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drivers: misc: Add driver to access ZynqMP efuses
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>
References: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
 <20240515124125.732487-3-lukas.funke-oss@weidmueller.com>
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
In-Reply-To: <20240515124125.732487-3-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0273.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c922003-f310-4b9d-dc0e-08dc7fed5953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXVnOEJIaE0xaUJuYUZxOVYzZnNON1I0dnd5L2l3eG9yb2xMVHFWTGUwUHlX?=
 =?utf-8?B?TEVSdmZ0WGJKNGRLU0tQOFQ2UFJYcVJHK1FFdE1mTXlkb2dVNzRKSjlaMG55?=
 =?utf-8?B?eEppQ25lbHkycVRtMEhLQkJsOTZpMnlET1ZFazRpVHN5QmdreTJ5UVFHdEds?=
 =?utf-8?B?SktxSC81elg1NGpjaU42L3J3cTRtU2gwb2JOZWk2QW5Zelk5NlFNR2ZWK293?=
 =?utf-8?B?NkpFbTNvUGwrWUtqMXRxa3BoY0VaMmkwdDZ3Y0dsT25FUVJCU3NpTS9mSm9i?=
 =?utf-8?B?Tnd4SWh5Rm5jclRQTndxbERmY2VKSThhak94ZFpndTE4SEQwd3Q2ejRaYmg0?=
 =?utf-8?B?eFowYmgrUWw2NzRPVFhHTHJqTy9vZzEzQTU1V0xubDZMWGxuRUZIcjJSQTBu?=
 =?utf-8?B?d3BUT200dEt3dDc1TnBhM0VDMVlVbzQ3SmR4WXlZUUhVQnFuOUx5YXVGM0s0?=
 =?utf-8?B?RXFQUzB4Q2d2WGZHQ0VOUEw3dVRxY0VVbzdGNStlYVdHWVpiOEQ5T1o1ZU9F?=
 =?utf-8?B?YlFxTGp0bE5GTEV2QVlDSThEWm1OTkNqT3k4amNjVWlHTTdBYk8wUWEySTYy?=
 =?utf-8?B?RnVXc08rSE1jeXM3WG5IcXpIRWhVU2ZaTlhaT0lVa3pxc29oQnA5SW1mdHk5?=
 =?utf-8?B?NVo1Sm5QNXZZUGZtdWxOTExwTzBzcW5QbWlBdHR3K1d5Q1V2R1B2YzdhL1pB?=
 =?utf-8?B?YkhrY3NGaXBEeW9ucE5Qa3Q4UXBWY1VxbDFERit4UGtVclBBck9mSjhjRUor?=
 =?utf-8?B?OWdEMHFBMHdxRjJqS2NqMXFjMFpRMWFwNUlERitvNzZSV1VMemVad3hodVpv?=
 =?utf-8?B?d0pTZDZhWmZjc2NPUklaUXVKL3NXQys1Rksxb2FBc1BHUEtNc21pU2dtTGU1?=
 =?utf-8?B?cjdEOGJ6QWtCaEVzUWtKZk5CZU5lVDUrY3UwOUdISlV3aHZpY21pZEQrV1VP?=
 =?utf-8?B?N3kzb2xudWVscnRFaEpHWmhEQ3hXNnppWjJFN1l6ZDhsRm52dnp5S1ozYjBV?=
 =?utf-8?B?QjBLeGJuU1VMeVdJMG9wamY0eGEzL3BzY1FYdlo1VGtoS1NYSFg1S1ppVFFh?=
 =?utf-8?B?cmgzSXpPVnBuVUlDdFBwbW83SExzWllPUWQ2eU9HSDRvYjRjZXhrdXhOWVNP?=
 =?utf-8?B?citzZ0NJajlFalNHSUc5b21PWWtYWUUzQ2hGUjh0N0U1RUtQTW5wSlZvaG1r?=
 =?utf-8?B?SFNvdW53MjZwNUFQS2YwSGRJNHM0ejB2aTNoa0xtbGYxdFdRNDltS0ZUNzB1?=
 =?utf-8?B?eGZiU1JOL05YTXE2V0VET0d2VFhjWndNMDFXN044WGI3TGFvbi9nK1E4RWsr?=
 =?utf-8?B?TkxUN3JrUEUvcGdxbGs3YThqMUNTdStFSlNXMG1BK1BhcktaTEg3Sm5KdmpX?=
 =?utf-8?B?eVh3TkdmUW1MTlNxazd6RmRNdld2UFl6UE8zMUlDaW80S3BtRTRDUEljdHVy?=
 =?utf-8?B?UEJqczR2eHg5UktLL2J3WGJFenZaajB3aFN0VWdicXBGN0hjREVnc2x2Q0Ur?=
 =?utf-8?B?QS9GQnBTTG1CZzZQNDR3RlN4ZHVURVpnV29xQUhEVlg1MiswZ3ZwSXRWMUti?=
 =?utf-8?B?UGVRK1pwNFRQSTR3UU1nRHhhQUkvR2pvWVR0V1pOZG0wNkw4NG93bnh2aEI2?=
 =?utf-8?Q?AL6I+NGcaYLJihj7Zk6D9rJF7d0m/vRt0E17TGKEwJtw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjVvejIxZi84WWxQbHdVT1IxT1pwSjk1M3A3WCtHUUFaQnNhVHd6WlFvd1BS?=
 =?utf-8?B?V1JGa1VoeXRmeHE1dDNjWm9mYlZUeDMxMnc1enlOVFg3b051b2kxSzNqQ2Mr?=
 =?utf-8?B?QzgrUU1VZ2h4NllKdVBBQitaQWZZL0gvT3RxZkhmSDVMd0MzRngybTIyYUd4?=
 =?utf-8?B?eUV0N2psbUtUZHlVVWZaUkYxT2h6YlBIMTBFcDRwVFpEaElJdjRrekxONkxX?=
 =?utf-8?B?NU1maU4zWm9RREVoL1UzS1l4WElnazFJOWczaFMrdXlYTWZPalY3Y0tWcVBM?=
 =?utf-8?B?VUU3QlUvTERoK1IzeWNFQzlJV3hwRElQaWR4ckJxY0pEYXJ0QktpNnVWWnVC?=
 =?utf-8?B?UksyWnU3Zm90cHg4M1k2QjRRY1B4NWt2WE1WU21uVmVkVkJYNVNjenNaNWdv?=
 =?utf-8?B?NTZsZkNCcnNsVFRjOEVvdE5GbmlwUTFGN2x3WTFaU3RWOHUzcFE0ajRGenNL?=
 =?utf-8?B?SHJxNWtTcTQzK1FvcFdjeGtyWmV6d01LQzVmSjU4a0pBMThPa3FvUFd0SnhY?=
 =?utf-8?B?bDJrU0dEQ0ZHS08xTHMyN1ovVWdwQlppSk95U1JCTldmVUpZNHk0VHNNRmZy?=
 =?utf-8?B?RmU2VU9tNUZqcHJPb3pCZjVJOWpETE0xenp0NXp0aXJhSmFHY29VVXpGaGtP?=
 =?utf-8?B?Mkh6NG4vcHVWVzVFd0VoRTFXUlgwUU1NT2NuZUcvNURJQmZ4VkhVU1orNEdq?=
 =?utf-8?B?UG5RUktSOXpEektFZjd2Y29QcDhJQ1p2WEVwUWhmSXlyS0tlNmplVUNJM3RY?=
 =?utf-8?B?WndHTEl6UHpqaml1bHN6K1dpZ05aeWNYWnRMRVUrRzFMcXhHUlFIOVFFWml0?=
 =?utf-8?B?T3FuR0VVektKL3FNVm5wVkQzNjFobXltaTVVenV4ZFFIc2QwbVdvSDk1MG13?=
 =?utf-8?B?QW50NVZTZ3lRayt6YXorN3o3RHlBanQ2R2RDY1ZhRys3VXh6SzhuOVArMVlv?=
 =?utf-8?B?dWsyR0FpQU1YWXFQOXc3OHYxWW95cDZHSHE4YUZ5Vy9NL1hocjhEODRlb1NC?=
 =?utf-8?B?SXBNOUlnWHRUd2o5eW1BdEo0SEozdEl3dVFhR1doM0FKY2V2Uy9NOGFFbVRz?=
 =?utf-8?B?Zmtxb3BRR0RWYUV2dVBmRjJibjZxbjFSdTR2aUVsSjRPcmt2NVVQTGt4STBD?=
 =?utf-8?B?ZkhpNDRmdVRFem5PekdQeVluM3JUODJabkN3bWRkbUxLZFBwaWZHRHNPOWRu?=
 =?utf-8?B?QkUxVzZJZHE0UW5jclNRODhydEozdGkzN0FWRWpqbEFkVmRvUHNWOVFTZ1VX?=
 =?utf-8?B?d1ZrU3ZLVGMvd2o2VklMMEQyRXF0bWJPUGJ0OU94SC8rQTVqcW0zMnNiMnJN?=
 =?utf-8?B?YXVSTks5WURuR0dMMFl0TG1STHkxUmY2K0ZkQU02N2FhRktmMWdTZExvWnAw?=
 =?utf-8?B?US92K3Z0UzZSQVVXd3V0OENSOFJVay9JekFwRWJLdTVIMXdKaWhJOUluaWpa?=
 =?utf-8?B?bTBTT2hzV3ZlakVkK3JNVDQvMlNGeVZEOVVibGJsbTRwUmQyUWM1VEZLc29D?=
 =?utf-8?B?SHNKbzFidFV4eENiVmJLMFYrV2ZEWmt1YVFHbDFTNUEwUEU3NExVMGdOZ09t?=
 =?utf-8?B?VDRtN3I3S3B0ejNyamNTbThIeTIxM21uU01IZ0dCMDkzWEY1NFdjVjBNbFdM?=
 =?utf-8?B?MjkvNG9STTQ4RzRYNzErUEdObUV0V2thZnhtOWZrS0Nud1BBay9LMjZHUk9z?=
 =?utf-8?B?eTRmTlNtdFF3UTA2Wmx5WUx3aW5FT3haS1pBSXpoeWZpMVg4MWdIVE82eEZa?=
 =?utf-8?B?ZTRFbUZZY2h6M0JmRkUzUkJRb2t6ZThTYStabjluUFRCNGZxdm1obU54NmdT?=
 =?utf-8?B?NHZ3am5zRzJLZnltenFxY1VDN3FwUkVkSGJ5b0QzejdVd3dyWldFZ0pLNW05?=
 =?utf-8?B?VDc1NlNWemZhdkdUd1BCWDNqK0lONTU1ZVVqR3BKWWltc1BTdlBvakl0bXR5?=
 =?utf-8?B?VEdVRkUwcmxJQm9NN09YK1F4SHFaOGR1WEY3VWZUeFhtVnh0dXYvTzMxcnA3?=
 =?utf-8?B?ajJPeFB2WmRpa3djU2RCYWF4MWQ4Sm1DTVc1dzdTczgySmxVVVpOSk95SWJo?=
 =?utf-8?B?SEc2VE1vZFpKSytpMTBuNitkSHdjbU9PbUNRdmxOaUQ5REhEcHZqNDhSMC9Y?=
 =?utf-8?Q?bKrG4+Loawhr1/7LSzNOOBcu+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c922003-f310-4b9d-dc0e-08dc7fed5953
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:40:56.4672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PYqGPmNejdqAfAYBtP7AJgNWMGc+KUqEksSmmqHSyikyeidetf/z0OzB5jXkLqB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
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
> Add driver to access ZynqMP efuses. This is a u-boot port of [1].
> 
> [1] https://lore.kernel.org/all/20240224114516.86365-8-srinivas.kandagatla@linaro.org/
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> Changes in v2:
> - Drop vendor specific fuse cmd, use existing fuse cmd
> - Minor code refactoring (reverse x-mas tree)
> 
>   drivers/misc/Kconfig        |   8 +
>   drivers/misc/Makefile       |   1 +
>   drivers/misc/zynqmp_efuse.c | 324 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 333 insertions(+)
>   create mode 100644 drivers/misc/zynqmp_efuse.c

would be good to get also 3/3 which enables
CONFIG_CMD_FUSE=y
CONFIG_ZYNQMP_EFUSE=y

in zynqmp defconfigs (virt and kria) to have it enabled.

> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 6009d55f400..c07f50c9a76 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -298,6 +298,14 @@ config FSL_SEC_MON
>   	  Security Monitor can be transitioned on any security failures,
>   	  like software violations or hardware security violations.
>   
> +config ZYNQMP_EFUSE
> +	bool "Enable ZynqMP eFUSE Driver"
> +	depends on ZYNQMP_FIRMWARE
> +	help
> +	  Enable access to Zynq UltraScale (ZynqMP) eFUSEs thought PMU firmware
> +	  interface. ZnyqMP has 256 eFUSEs where some of them are security related
> +	  and cannot be read back (i.e. AES key).
> +
>   choice
>   	prompt "Security monitor interaction endianess"
>   	depends on FSL_SEC_MON
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index e53d52c47b3..68ba5648eab 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -92,3 +92,4 @@ obj-$(CONFIG_ESM_K3) += k3_esm.o
>   obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
>   obj-$(CONFIG_SL28CPLD) += sl28cpld.o
>   obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
> +obj-$(CONFIG_ZYNQMP_EFUSE) += zynqmp_efuse.o
> diff --git a/drivers/misc/zynqmp_efuse.c b/drivers/misc/zynqmp_efuse.c
> new file mode 100644
> index 00000000000..98a39c1ebdd
> --- /dev/null
> +++ b/drivers/misc/zynqmp_efuse.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2014 - 2015 Xilinx, Inc.
> + * Michal Simek <michal.simek@amd.com>
> + *
> + * (C) Copyright 2024 Weidmueller Interface GmbH
> + * Lukas Funke <lukas.funke@weidmueller.com>
> + */
> +
> +#include <compiler.h>
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <zynqmp_firmware.h>
> +#include <asm/dma-mapping.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <misc.h>
> +
> +#define SILICON_REVISION_MASK 0xF
> +#define P_USER_0_64_UPPER_MASK	0x5FFF0000
> +#define P_USER_127_LOWER_4_BIT_MASK 0xF
> +#define WORD_INBYTES		(4)
> +#define SOC_VER_SIZE		(0x4)
> +#define SOC_VERSION_OFFSET	(0x0)
> +#define EFUSE_START_OFFSET	(0xC)
> +#define EFUSE_END_OFFSET	(0xFC)
> +#define EFUSE_PUF_START_OFFSET	(0x100)
> +#define EFUSE_PUF_MID_OFFSET	(0x140)
> +#define EFUSE_PUF_END_OFFSET	(0x17F)
> +#define EFUSE_NOT_ENABLED	(29)
> +#define EFUSE_READ		(0)
> +#define EFUSE_WRITE		(1)

I did compare it with the latest upstream version and there are some differences 
which don't need to be there. Above macros for example

> +
> +/**
> + * struct efuse_map_entry - offset and length of zynqmp fuses
> + * @offset:	offset of efuse to be read/write
> + * @length:	length of efuse
> + */
> +struct efuse_map_entry {
> +	u32 offset;
> +	u32 length;
> +};
> +
> +struct efuse_map_entry zynqmp_efuse_table[] = {
> +	{0x000, 0x04}, /* soc revision */
> +	{0x00c, 0x0c}, /* SoC DNA */
> +	{0x020, 0x04}, /* efuse-usr0 */
> +	{0x024, 0x04}, /* efuse-usr1 */
> +	{0x028, 0x04}, /* efuse-usr2 */
> +	{0x02c, 0x04}, /* efuse-usr3 */
> +	{0x030, 0x04}, /* efuse-usr4 */
> +	{0x034, 0x04}, /* efuse-usr5 */
> +	{0x038, 0x04}, /* efuse-usr6 */
> +	{0x03c, 0x04}, /* efuse-usr7 */
> +	{0x040, 0x04}, /* efuse-miscusr */
> +	{0x050, 0x04}, /* efuse-chash */
> +	{0x054, 0x04}, /* efuse-pufmisc */
> +	{0x058, 0x04}, /* efuse-sec */
> +	{0x05c, 0x04}, /* efuse-spkid */
> +	{0x060, 0x30}, /* efuse-aeskey */
> +	{0x0a0, 0x30}, /* ppk0-hash */
> +	{0x0d0, 0x30}, /* ppk1-hash */
> +	{0x100, 0x7f}, /* pufuser */
> +};
> +
> +/**
> + * struct xilinx_efuse - the basic structure
> + * @src:	address of the buffer to store the data to be write/read
> + * @size:	no of words to be read/write
> + * @offset:	offset to be read/write`

a little bit different description compare to upsream linux

> + * @flag:	0 - represents efuse read and 1- represents efuse write
> + * @pufuserfuse:0 - represents non-puf efuses, offset is used for read/write
> + *		1 - represents puf user fuse row number.
> + *
> + * this structure stores all the required details to
> + * read/write efuse memory.
> + */
> +struct xilinx_efuse {
> +	u64 src;
> +	u32 size;
> +	u32 offset;
> +	u32 flag;
> +	u32 pufuserfuse;
> +};
> +
> +static int zynqmp_efuse_get_length(u32 offset, u32 *base_offset, u32 *len)
> +{
> +	struct efuse_map_entry *fuse;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(zynqmp_efuse_table); ++i) {
> +		fuse = &zynqmp_efuse_table[i];
> +		if (offset >= fuse->offset &&
> +		    offset < fuse->offset + fuse->length) {
> +			*base_offset = fuse->offset;
> +			*len = fuse->length;
> +			return 0;
> +			}
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +static int zynqmp_efuse_access(struct udevice *dev, unsigned int offset,
> +			       void *val, size_t bytes, unsigned int flag,
> +			       unsigned int pufflag)
> +{
> +	size_t words = bytes / WORD_INBYTES;
> +	struct xilinx_efuse *efuse;
> +	ulong dma_addr, dma_buf;
> +	int ret, value;
> +	char *data;
> +
> +	if (bytes % WORD_INBYTES != 0) {
> +		dev_err(dev, "Bytes requested should be word aligned\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (pufflag == 0 && offset % WORD_INBYTES) {
> +		dev_err(dev, "Offset requested should be word aligned\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (pufflag == 1 && flag == EFUSE_WRITE) {
> +		memcpy(&value, val, bytes);
> +		if ((offset == EFUSE_PUF_START_OFFSET ||
> +		     offset == EFUSE_PUF_MID_OFFSET) &&
> +		    value & P_USER_0_64_UPPER_MASK) {
> +			dev_err(dev, "Only lower 4 bytes are allowed to be programmed in P_USER_0 & P_USER_64\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		if (offset == EFUSE_PUF_END_OFFSET &&
> +		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
> +			dev_err(dev, "Only MSB 28 bits are allowed to be programmed for P_USER_127\n");
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
> +	efuse = dma_alloc_coherent(sizeof(struct xilinx_efuse), &dma_addr);
> +	if (!efuse)
> +		return -ENOMEM;
> +
> +	data = dma_alloc_coherent(bytes, &dma_buf);
> +	if (!data) {
> +		dma_free_coherent(efuse);
> +		return -ENOMEM;
> +	}
> +
> +	if (flag == EFUSE_WRITE) {
> +		memcpy(data, val, bytes);
> +		efuse->flag = EFUSE_WRITE;
> +	} else {
> +		efuse->flag = EFUSE_READ;
> +	}
> +
> +	efuse->src = dma_buf;
> +	efuse->size = words;
> +	efuse->offset = offset;
> +	efuse->pufuserfuse = pufflag;
> +
> +	flush_dcache_range((ulong)efuse, (ulong)efuse +
> +				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
> +	flush_dcache_range((ulong)data, (ulong)data +
> +				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
> +
> +	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
> +	if (ret != 0) {
> +		if (ret == EFUSE_NOT_ENABLED) {
> +			dev_err(dev, "efuse access is not enabled\n");
> +			ret = -EOPNOTSUPP;
> +			goto END;
> +		}
> +		dev_err(dev, "Error in efuse read %x\n", ret);
> +		ret = -EPERM;
> +		goto END;
> +	}
> +
> +	if (flag == EFUSE_READ)
> +		memcpy(val, data, bytes);
> +END:

this has also changed and was commented by Stefan before.

efuse_access_err:
	dma_free_coherent(dev, sizeof(bytes),
			  data, dma_buf);
efuse_data_fail:
	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
			  efuse, dma_addr);



> +
> +	dma_free_coherent(efuse);
> +	dma_free_coherent(data);
> +
> +	return ret;
> +}
> +
> +static int zynqmp_nvmem_read(struct udevice *dev, int offset,
> +			     void *val, int bytes)

please check variables types.

> +{
> +	int ret, pufflag = 0;
> +	int idcode, version;
> +
> +	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
> +		pufflag = 1;
> +
> +	dev_dbg(dev, "reading from offset=0x%x, bytes=%d\n", offset, bytes);
> +
> +	switch (offset) {
> +	/* Soc version offset is zero */
> +	case SOC_VERSION_OFFSET:
> +		if (bytes != SOC_VER_SIZE)
> +			return -EOPNOTSUPP;
> +
> +		ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
> +		if (ret < 0)
> +			return ret;
> +
> +		*(int *)val = version & SILICON_REVISION_MASK;
> +		break;
> +	/* Efuse offset starts from 0xc */
> +	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
> +	case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
> +		ret = zynqmp_efuse_access(dev, offset, val,
> +					  bytes, EFUSE_READ, pufflag);
> +		break;
> +	default:
> +		*(u32 *)val = 0xDEADBEEF;
> +		ret = 0;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int zynqmp_nvmem_write(struct udevice *dev, int offset, const void *val,
> +			      int bytes)

here too. offset for example

> +{
> +	int pufflag = 0;
> +
> +	dev_dbg(dev, "writing to offset=0x%x, bytes=%d", offset, bytes);
> +
> +	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
> +		return -EOPNOTSUPP;
> +
> +	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
> +		pufflag = 1;
> +
> +	return zynqmp_efuse_access(dev, offset,
> +				   (void *)val, bytes, EFUSE_WRITE, pufflag);
> +}
> +
> +int fuse_read(u32 bank, u32 word, u32 *val)
> +{
> +	u32 base_offset, offset, len;
> +	struct udevice *dev;
> +	u8 buf[128];

128 is correct number but would be better to have connection where this number 
is coming from. MAX size is 0x7f which is 127 but that connection is not visible 
from it. I am fine with the comment to say it.  Please look below.

> +	int ret;
> +
> +	memset(buf, 0, sizeof(buf));

I would call it before misc_read not to waste time in error case.

> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(zynqmp_efuse), &dev);
> +	if (ret)
> +		return log_msg_ret("uclass_drv", ret);

Above c&p from Linux is using dev_dbg structure and here you are using log 
infrastructure. Would be much better if you can use the same.


> +
> +	ret = zynqmp_efuse_get_length(word, &base_offset, &len);
> +	if (ret)
> +		return log_msg_ret("efuse_offset", ret);
> +

And here please check that len is below 128 to make sure that we never overwrite 
stack. Other entries can be added and it should be spotted.

> +	ret = misc_read(dev, base_offset, (void *)buf, len);
> +	if (ret)
> +		return log_msg_ret("misc_read", ret);
> +
> +	offset = word - base_offset;
> +	*val = ((u32 *)buf)[offset];
> +
> +	return 0;
> +}
> +
> +int fuse_prog(u32 bank, u32 word, u32 val)
> +{
> +	u32 base_offset, len;
> +	struct udevice *dev;
> +	int ret;
> +
> +	ret = zynqmp_efuse_get_length(word, &base_offset, &len);
> +	if (ret)
> +		return log_msg_ret("efuse_offset", ret);
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(zynqmp_efuse), &dev);
> +	if (ret)
> +		return log_msg_ret("uclass_drv", ret);
> +
> +	if (word != base_offset || len != sizeof(val))
> +		return -EINVAL;
> +
> +	ret = misc_write(dev, word, (void *)&val, sizeof(val));
> +	if (ret)
> +		return log_msg_ret("misc_write", ret);
> +
> +	return 0;
> +}
> +
> +int fuse_sense(u32 bank, u32 word, u32 *val)
> +{
> +	/* We do not support sense */

avoid we - imperative mood please.

> +	return -ENOSYS;
> +}
> +
> +int fuse_override(u32 bank, u32 word, u32 val)
> +{
> +	/* We do not support overriding */

avoid we

> +	return -ENOSYS;
> +}
> +
> +static const struct udevice_id zynqmp_efuse_match[] = {
> +	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
> +	{ /* sentinel */ },
> +};
> +
> +static const struct misc_ops zynqmp_efuse_ops = {
> +	.read = zynqmp_nvmem_read,
> +	.write = zynqmp_nvmem_write,
> +};
> +
> +U_BOOT_DRIVER(zynqmp_efuse) = {
> +	.name = "zynqmp_efuse",
> +	.id = UCLASS_MISC,
> +	.of_match = zynqmp_efuse_match,
> +	.ops = &zynqmp_efuse_ops,
> +};

Thanks,
Michal
