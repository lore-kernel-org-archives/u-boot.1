Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862E4C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 07:47:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5CFC8826D;
	Wed, 22 May 2024 09:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FUi/6h5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D4F8825A; Wed, 22 May 2024 09:47:13 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B4F18826D
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3E0PCBjNKkotoFzUKYwu0rKospnXRe6KuRIj+dO+IgIOKE0ajax+QKbn08KUc2UsB2t/YGrsX6hLTy/Ai9wpQ743uD0yD9lCjEOLQJnykPZtAfR1u59gg9T8CAOSOjMb0k+fxc2sUmZJFXVjpS3yA9CfTQy9YjxDSScRK3KCAmnQPTP9KfK8KcbWPamTEIbJuaPmqupNiJOZiEM53y7VprlsFCCAiQT8jswv+FMradMRpTweZhyr1d9flQjbogQ9qpaHgCyNPwvefEK6+a1GTwUYMLvqC4lURzkRZQYg5RRlynxWhS2F1AnMo3xXrwFMpI5RpaTHPQNcGnJRErGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02Y38rZuBMXlBmge/nyO1fLWUyMt+7C4NPiSriHhCp0=;
 b=eP2nSSMUzxe3CyvQmeTtkM8A9ijNFK4YZHt2t98h2N7SoVcTqmyQZ5MNSPdz7fhpzkYBp6ji/eEHMU9mq7FRGwqWggV7ldBooXkZduAcTxSzHSPpMWhkcbA+oW5ix1ECPCPWlw8rwe9QHZyiMSi95yiEypSTI90muSnvUjA9lzUJppOU2UjL1kAuAMjQES6urGJmgbrJ4XRLPPROelrq+yarPOJ5ffT4kXI7eOR7BBKr5271rAVD6qnPaRvz7zEfUn7rLL3CSxH1ugz6UC5bDNC9U6hH3S1Lf5dEGixnnn+4oGErw6TeCsGdJDrcFkrtipkIDZewIoVlSPkamXTGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02Y38rZuBMXlBmge/nyO1fLWUyMt+7C4NPiSriHhCp0=;
 b=FUi/6h5bhg2G1DYaNbaFxfXhSJrwaAq4mYWlxjc6F3c8NyoHdvCXiDPmNWMJZHfdPgR7GtKlmMHhNsaiL1L/x8VYDoqyzESv/lnJamcv4GRPN933yZ3XV9WAdZ63M+Do1BdkKxccdkMfyORR1tanEs0LFvpouhKCmEIK9V5Tnvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Wed, 22 May
 2024 07:47:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 07:47:05 +0000
Message-ID: <5cf2c7a1-4766-4343-a037-3893a03f14df@amd.com>
Date: Wed, 22 May 2024 09:46:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>,
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240521205955.3569600-1-tharvey@gateworks.com>
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
In-Reply-To: <20240521205955.3569600-1-tharvey@gateworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0105.eurprd04.prod.outlook.com
 (2603:10a6:803:64::40) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 27612c7c-c31c-4743-484e-08dc7a335ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFVGQTNBYkx6VEphWGk2Tnd1QTRBVVpuRW91ZVJoUjR4UHBRYXRsQUdNQ0pZ?=
 =?utf-8?B?UUpqT0V5TDBkZ2E4TnJrOHNqa3JISWZ1V3M3MnczM2dTRVhzbmViZlhKRDlV?=
 =?utf-8?B?OXFMTlRhTmQyUmNJbjhvRGZuTVFhV2JqcG1BTDUxeHFvK0dLY0hoVVdoOWFx?=
 =?utf-8?B?UDVCL3dUWmdmcmd5dHpxQmRWWTk1aGFhT0Vmckd2RTFRUmlnMWJkSzhqSXJV?=
 =?utf-8?B?VW5zZXpKMGhHRmlvRFFkOVdLYmlGMU1XNU9TNlJJVXdRZG9ocjVXZ1Fub2JD?=
 =?utf-8?B?bU03dGNYYk94eitvcFIvOHN6a3lLWDBvNUtpaG4vcVlnVDc4WGhWTzZ2QkJh?=
 =?utf-8?B?YW9UV3lpZm1INUpkdHNXdmdJR3FTRStFU2ZST29QMGxxNUN1REdpaFdlQUJ4?=
 =?utf-8?B?WDA2RGkya3lTZlBneTdMYk1uTkg5WHBibVU2endzZk9aQk5CVldQVncwVGZ3?=
 =?utf-8?B?Vk9MMDM2VHNadVFMbnh3U2VqVEhRc21GUUl1YVN4VTZsa2ZTeVUrSEkrZFlm?=
 =?utf-8?B?UTdpY3RUQktiaFdWK3d0V3EzRTVJS3R2WHFQSEp1a1FXdXBkckNRT0FUYkhp?=
 =?utf-8?B?RHFPdjR3NnIvS3ZoNlBEQ1lvR3lYdzMvVldVdlltc0lDMWdUMGYram5idXlt?=
 =?utf-8?B?SXU2WlNUM1pvZGlidVBZa0hoMFQvcHhJK3BDN3JTOWZVTmMrR1BtSjVkNHJS?=
 =?utf-8?B?cWtHRDZ3OWZYYWMzNksvZ0g0M2Uxc0lYazkxaUNvVForNDlOYTQvMVhRc1h0?=
 =?utf-8?B?SWFObFFORENvUFprZDNXbEM0c0VLVFlZb1VvNmhHTlM1UG01dnlRalorMjNQ?=
 =?utf-8?B?eHpMQVpkdUdVNldhb2k3RXo2cUpBSEoxU1daQWg0VXUrVEhVdDZzc09xdVN5?=
 =?utf-8?B?V0NYWmtibnFocVZVcm1Ud0RwM1hPbTlaSXRNNGhVbzRpcWtOeHlOOVFkYXJw?=
 =?utf-8?B?RUpsMVRmNWFFeDNNKy92OTJlTU1kMVZ3TDExME9LbU1oSnJXczZ5dW1ZU2pC?=
 =?utf-8?B?bFF4c3hJQS83RWhBbXZUY3NFVWlCSVBxVTVycVY0c3FDeFhyNGhIOGZoVXFo?=
 =?utf-8?B?aWhCNHEyQVhTblA3S0pPR1RYb3ZtOS95Q2J2S256LzNlL1JFTy9SeCtqVE04?=
 =?utf-8?B?OGRhTkl5UkNqZGRCRU1Nd2IrWWdiOUlEWXRTYXhEckliNlUxaGpRRXpNWVFk?=
 =?utf-8?B?b3d0WGlDN1RmYmNNQ0IydzdkMmsvWnBVT2RVRldKemN0czBqYnp3RnZjQW5k?=
 =?utf-8?B?WVVROC9XeFRjd25GK1I4L1dBdmpmTFYvQVlMcTdLc2tmUlZITmlQSzR6SnMx?=
 =?utf-8?B?TkRJV1pYY3FoUzdqclIwRC8ra3pyNklBUk5GejAxQUdsN0tsUU0rUzVEUThZ?=
 =?utf-8?B?enY5NENIcUZoR3JmVzRQanF3VnRHcXdmRzUvWXFsK2o5S2dqSU0zTmpuOTdz?=
 =?utf-8?B?a2Y2b3FQOUdpWTBaU280aEprZ3c5ZS9oU1l5bjdpb1BHdGNQUGZrY1ZqTWNu?=
 =?utf-8?B?UDBoRXlzcHBZbXEvc2NhQ0NxUG5QczZac01qNGhOM2NKdjZHQThzNHJvc000?=
 =?utf-8?B?UVdSSVNTaTlyZUJ5cDhJSjg4VWlTcCtpaTZ2eFI5amt0b0tvRmc4RHVZSTBs?=
 =?utf-8?B?cFg3YlZkYUVydlhaUDhUeS9YUWhxN212Ni9GcExPdFdXMWwxTEFlTElZT041?=
 =?utf-8?B?ZEp4dHNKR3ZiTnBpU1FORVdIRC9GdzQwemNWN0lwdmJsL1lhL0lUOHhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzB0SGJJUzlEbXpvTHRVc2YzUW9RNmNNdndTd05xRkVmM1RhYmp5akJETDls?=
 =?utf-8?B?eXljK285ek5JWmZXVXh4OTRyUnZhK0ZUNlNWWm1YWHVFdmNoY25EdVFpUUxJ?=
 =?utf-8?B?WTlnUGlHUUVSajlrUlNaSmVQSEtDSDZub2hVQ0dMazNab2RSSFpQdjduK0tx?=
 =?utf-8?B?RE53bElCWjRzenBDVFFaN0ZLU0dYa3JJeC9aZFZORFUyMENUb0ZuVzlJdHE0?=
 =?utf-8?B?MTVjZ2VvUE5DT2FUeWxkaVIzL0VlektBcno5b1RXK2txdSt1MVlXejdPWkt5?=
 =?utf-8?B?WHlEalZmQ3pnOGR1MXRKQ3JndG1lNFkwa3p5WGkyUlFyWUpyUSsvWjNXbnQy?=
 =?utf-8?B?K2NNN3hsMnVzQ01zclBibTZWSDRIdklCdHFpNFgvR05iSUtBSSsyZ21vbDgy?=
 =?utf-8?B?bW1YWUYrY1NzNnp2c2pNVDFnbS9hUXo1U25scDZWQzdKTDd4RTVVTGhVbHR6?=
 =?utf-8?B?NVMrWEpUellMN0p6VVpsZDRPT0Z1U2xYTkVxc0p5d1VZNGh6QTBxYXh2NHgw?=
 =?utf-8?B?aGxmdFJIM3BEVHVZQ3Q1Z2YxVVA3MXhzczBJQ1FDTzF6eWlmZXg4dVVTS2RZ?=
 =?utf-8?B?eGw1WjZEVU9odFZMSU5mR1pJOFNQR29uYUxndEhseTJjbHhWRm5jaDkrMGsz?=
 =?utf-8?B?OGNBVXpXUmRiV045Z04xdDBEWEFGbWpLUGs4cWY5SzFRbUh3YWxheStUa3Rt?=
 =?utf-8?B?VGl4cUVTcWE3ajRVOURoSXdIRDg3N3dsRXZzNTMrb1Naa3ZjamtmN3RNeFVI?=
 =?utf-8?B?VDlHY3M0aldmVFV1QlBodUFoQkVpbnZQNjIyeW5qQkQ0Z3ZQajMra0c0Umlr?=
 =?utf-8?B?Ty83WjVMLzc1a2E4dGpwYVpCVGpKbG5VMnF1WnBDeHZwNklJRGF1M2NsVWZk?=
 =?utf-8?B?anNsZDVWQUV1SXJqV2ZHclFqQnA0cStjUkhjWm1Qb1hVWGkzQTdVWXdFNmRr?=
 =?utf-8?B?VnRIMjF4OWd5VVAzUTJibUVJR2xablhUejRxN2lET2xuRUl4SURkNEd2OUlz?=
 =?utf-8?B?eTlFVXlSVFkrSVlKMVl3SmVqTERyME4rZEE3dE91ZUtqVjY0Z1ZhM09EVnJQ?=
 =?utf-8?B?Y1d6RUtHbWhBRDR0bUdnUEhIKzUxM3h0T3pYMHI3NmFBZSsxdTFDSG8wNlZV?=
 =?utf-8?B?TDhtT1JwQ2FMRkF4QWMzY3gvODdSek1PTmtWYXR6MHpPNnFuSG5WZlpJWTdM?=
 =?utf-8?B?eXdlTWlTT1lUSkwxMkNVQ0pBUFNFMWRNZTlLeVdFTzBuTmJuMUh3YmJhc0RY?=
 =?utf-8?B?YU1HN0hOUnA0aVZBZ1NBM1d2dkFiV0I2UDNvbzBMNjZVUXBYMjdZTVVOWjND?=
 =?utf-8?B?eUZQZ2F1TDB2ZG1OQTd5ZE1ua3pMMDN1b1ZjM3BlK3ViWXJaVjdOeWxyQWxq?=
 =?utf-8?B?ZmpiLzRGL2RjeldhV0hBTm1CcG1EWlo2aWh6bWpFUVV6VnYxalhzRWpHYUVp?=
 =?utf-8?B?dUFVNWQ4Q1hIZjltUGo5a1h5T2s2eEsrd1NkR3NHeGt0VnVESXhYV3VwL2Zy?=
 =?utf-8?B?OHQ1blhOdUNoV0FHUlBSVlE0NmpBWUNwUVNrVjZTWHBieHBWUlFHYjQrSlFM?=
 =?utf-8?B?RHh6dDFlZVd6YkVseGhmSFVLT0o1TzFrNGtpM0YvcDZSUmxkWWdEUXNwcGVt?=
 =?utf-8?B?dFIrbHFVZWVha3JGTC8yRVNhcGZrTHdEcldva0swUy9wS1owZk5uUWV6U0hw?=
 =?utf-8?B?eVZxQkl0UE85NUhEckJ3Vk9FRUVJaHczOGV4SVFMZzJ6TVpVclZ0SEVsMWRH?=
 =?utf-8?B?MjVHSDdZb2dyZ2hvYWx4b3R0ZGJYRXdESVdmamRUQkJ3NWZUWUZzdUZHWUxK?=
 =?utf-8?B?U1pIVUZjaUpUZDNLWUFCM2hVWTEyYUxvYmpmL0tCWlFELzlhVTJ4RFg5d05p?=
 =?utf-8?B?Zm12M3ZUVkVWQUJyT0dYeFZNS0k4REFvRWdlMW9sQVArYTRqRllaRThMNHZ2?=
 =?utf-8?B?Mis4WWIycUtrdXVJU3I5TjhwOVVUUXZKT1k2dGQ4alhrWkkzUmlHSk9FZ0ts?=
 =?utf-8?B?UWtjSGE2cHVaNkdwWHJuWWxGSGYxa0grTG45SzFDNVNiWmdaL2pzTGh2ejRX?=
 =?utf-8?B?ZnRzOVNYT3ZJZUhueFhPUTF4SVNFYjRSSVZHZGFNdTZZeFU5UVIwVXFGOUt2?=
 =?utf-8?Q?G3JtwGz1Rb8ynd/etIKQYJ3V0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27612c7c-c31c-4743-484e-08dc7a335ff9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 07:47:05.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WY+1tzJXJXVpSEuQyz4v8cTxW4Y1/OZsO/iVVTEd/EnS/IcU59XoPQBB46bSp8T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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



On 5/21/24 22:59, Tim Harvey wrote:
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> 
> If we have DM_RNG enabled populate this value automatically when
> fdt_chosen is called. We skip this if ARMV8_SEC_FIRMWARE_SUPPORT
> is enabled as it's implementation uses a different source of entropy
> that is not yet implemented as DM_RNG. We also skip this if
> MEASURED_BOOT is enabled as in that case any modifications to the
> dt will cause measured boot to fail (although there are many other
> places the dt is altered).
> 
> As this fdt node is added elsewhere create a library function and
> use it to deduplicate code. We will provide a parameter to specify the
> index of the rng device as well as a boolean to overwrite if present.
> 
> For our automatic injection, we will use the first rng device and
> not overwrite if already present with a non-zero value (which may
> have been populated by an earlier boot stage). This way if a board
> specific ft_board_setup() function wants to customize this behavior
> it can call fdt_kaslrseed with a rng device index of its choosing and
> set overwrite true.
> 
> Note that the kalsrseed command (CMD_KASLRSEED) is likely pointless now
> but left in place in case boot scripts exist that rely on this command
> existing and returning success. An informational message is printed to
> alert users of this command that it is likely no longer needed.
> 
> Note that the Kernel's EFI STUB only relies on EFI_RNG_PROTOCOL for
> randomization and completely ignores the kaslr-seed for its own
> randomness needs (i.e the randomization of the physical placement of
> the kernel). It gets weeded out from the DTB that gets handed over via
> efi_install_fdt() as it would also mess up the measured boot DTB TPM
> measurements as well.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Akash Gajjar <gajjar04akash@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Devarsh Thakkar <devarsht@ti.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Chris Morgan <macromorgan@hotmail.com>
> ---
> v3:
>   - skip if CONFIG_MEASURED_BOOT
>   - fix skip for CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT
>   - pass in rng index and bool to specify overwrite
>   - remove duplicate error strings printed outside of fdt_kaslrseed
>   - added note to commit log about how EFI STUB weeds out kalsr-seed
> 
> v2:
>   - fix typo in commit msg
>   - use stack for seed to avoid unecessary malloc/free
>   - move to a library function and deduplicate code by using it
>     elsewhere
> ---
>   board/xilinx/common/board.c | 35 -------------------------
>   boot/fdt_support.c          |  6 +++++
>   boot/pxe_utils.c            | 35 ++-----------------------
>   cmd/kaslrseed.c             | 45 +++++---------------------------
>   include/kaslrseed.h         | 19 ++++++++++++++
>   lib/Makefile                |  1 +
>   lib/kaslrseed.c             | 51 +++++++++++++++++++++++++++++++++++++
>   7 files changed, 85 insertions(+), 107 deletions(-)
>   create mode 100644 include/kaslrseed.h
>   create mode 100644 lib/kaslrseed.c
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 30a81376ac41..f741e8957818 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -713,41 +713,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   	if (IS_ENABLED(CONFIG_FDT_FIXUP_PARTITIONS) && IS_ENABLED(CONFIG_NAND_ZYNQ))
>   		fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
>   

one more thing here. Please also removed unused variables.

board/xilinx/common/board.c: In function 'ft_board_setup':
board/xilinx/common/board.c:707:25: warning: unused variable 'ret' 
[-Wunused-variable]
   707 |         int nodeoffset, ret;
       |                         ^~~
board/xilinx/common/board.c:707:13: warning: unused variable 'nodeoffset' 
[-Wunused-variable]
   707 |         int nodeoffset, ret;
       |             ^~~~~~~~~~
   AS      arch/arm/cpu/armv8/cache.o
board/xilinx/common/board.c:706:12: warning: unused variable 'buf' 
[-Wunused-variable]
   706 |         u8 buf[MAX_RAND_SIZE];
       |            ^~~
board/xilinx/common/board.c:705:25: warning: unused variable 'dev' 
[-Wunused-variable]
   705 |         struct udevice *dev;
       |                         ^~~
board/xilinx/common/board.c:704:16: warning: unused variable 'n' [-Wunused-variable]
   704 |         size_t n = MAX_RAND_SIZE;
       |                ^


Thanks,
Michal
