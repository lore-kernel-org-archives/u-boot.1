Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E05C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 09:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2880A8891B;
	Mon, 26 Aug 2024 11:01:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CBlupWdp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE71C8895B; Mon, 26 Aug 2024 11:01:42 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FEA988846
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/AJisU5XsmgMN2YtgL/LZpxE/N7Cwid38LfVPOzlreR0ZkD+7ZZrc05L/OBKTeDYbRFz84Riwegk3U6uYLQKvlLcHBTUds+i4YoFHjRjF40bxFKgv+PBYIyTW9N1/haJYxj19B/zroRnkeq82hiOzbJe52V/yenJzAntcRDp0/96p91vxd8baDXII0XOi0PosTg/ypCgiyTqvdY2th82CThQnJd0xHEJdOKi/OAYacIOvHFok0U+MefDCJ279Uzh2Y7+DvFqC5qtK6J6009ncCLAOyuJxUHVLFonBeKjO4AeBKE2t0/8rC110DGEMRqag487ouMc3ZAdYfDzU8Xpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GLb11AqHgyGsgWYKMzDeUvn87SX4aE1w2KzB2tvMNo=;
 b=s6DcdDiP9oxOZnVuEoEi6Eoc4dLERl7Jhx9ilXp1uZ5Fs+mpsc3Ziq6fQF4HlJrx8wZ1NilXWz7f+2BBhqqpqheZCph+IqzolhjDJAfohkb3GFyc8zar5Xx2qebRfkr5UJolPzNF+Iwsdxln5rJiGLDEcKs6eNlqHS5LXYQ/nsTRKEcgdcTc4SFojSdReRbPTbkbWucqSy/f11OPVxMGNPp4ep9pLgWcLaRW9Z0W3htQkXjrJOH4Nbbrw/poK+oD43bnCSmBj+zA9rQvFbpz9T1lv+YO8IzqA4QH55QZmtsS/0vvQjrb/ZU+F+qlA7skB9g07z5/+B8RmRaS/MeKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GLb11AqHgyGsgWYKMzDeUvn87SX4aE1w2KzB2tvMNo=;
 b=CBlupWdpb+LHlOm48YE7E3jhgSdevbUixxT4cO/VARlSXjgqgHLZj20qdIO0AUHpZLQjILH5ppASvw+DsyxNGYNUe8dUJ8NME9G9J7SFtCt7BUyxmWQSUowRtx2+jmrAM4zh6+u6zBrz0bROf2xANKO+9SNlKWI+ebav+EbM1XI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 09:01:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 09:01:36 +0000
Message-ID: <dcd0002a-5856-4741-9b9d-887876c8e14b@amd.com>
Date: Mon, 26 Aug 2024 11:01:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] sysinfo: Add sysinfo driver and data structure for
 SMBIOS
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Alexander Gendin
 <agendin@matrox.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-3-raymond.mao@linaro.org>
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
In-Reply-To: <20240816154658.1866186-3-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0031.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::44) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 7458afdd-196f-4348-6bd1-08dcc5adb0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vk5NUE9jMnhJYzQzaGErS3pLQ1VzdldxWlBpZDUzNU9mcCtzbVZSWTVMQ245?=
 =?utf-8?B?bnRVeWJBNXMyTEoxSitrZmxNODU2anpCclVkTGJ3SlRaUHkvaHkxdExWZlE4?=
 =?utf-8?B?aXFBSjdhUjBhbk0xaXgwZjVyTlE4KzdaUGtNVUE1aHNQdUtRWFFua0JiQVpZ?=
 =?utf-8?B?UFlITVFwaE1YWGRtUThRZFlUaitaMUZsUFBnUlR3U2hvUWgzRkxYTmhXakRD?=
 =?utf-8?B?dytpekpNMUtnNkU4OVl3TzZsMU82RXRSVHVXWU1QeTUxUmZBNEgrOEhMVDBw?=
 =?utf-8?B?TkVqQldsb1lZZXY0OW82bURSd3N0M1BJSXp4RFFZVG9hRThDaVZ1NlR6aFhQ?=
 =?utf-8?B?Z1J6Y21MQVRRTUpHUnEzNC9yRS9Ka09TdExJWXpYT1ErclVpazMxdTlScjVh?=
 =?utf-8?B?T3FOd3RlcDFseGpnZUNTWVVsdzZ5Rm1HaGdaSUFZd1BCSnZuT0d2ak1jb0FQ?=
 =?utf-8?B?Y2xsejZSREN2WDd4ZGFYR05ZL1p6b3NYT0w0cHgvd0xWMkFhT2JkVjk5YmNK?=
 =?utf-8?B?MEZhZndxQVJwN1FWM0tDYXBYSWdiZ08rS0lJQTBsdlh0WlE0QmlyRm1CZklC?=
 =?utf-8?B?OWcxVFFSK1pPZGNXUFFyZXYyUVRUMm9VV1BNYW5OWXhmRENPZTU1MFQrRkxR?=
 =?utf-8?B?ZlRwTDMwVUhJbXdrYmhDS0psbGMySDZleW1jR0NkTmdhWjRwdEwvVVRaQVBC?=
 =?utf-8?B?ZUJqK1BMUEx2SkhUM2J1STZvZHhkc29ZMUdUUDRBNUdVdGFBNndtS29xY3A2?=
 =?utf-8?B?cFZ0Q21LSXhjSGNUVlVvMTdkc1VsZUdpQUJ4eUZSTWFBc0hnaDJpNEY4WU56?=
 =?utf-8?B?UkRHRVhQMm5nMnVMMzFvSzBFeGVkR0Zqd2RiRVhmaHBUSVpidE10WTdsTi9q?=
 =?utf-8?B?Wm5FYTBJZUw5WUlLRFY2c05GU0NHRnh3czA0WENzTEtTOEJCOW5ZbU5hRUR3?=
 =?utf-8?B?eFFybzdTTGFuMjM1UW1YMHZDVmpIN04yYWZLdUU0UlVoc0FvaURibWx2aTZC?=
 =?utf-8?B?c2ppNEtRTEl0SHgyOXE0K1kvWDZxVno4NHZ0dzl6bjFPSXFaTDA1WW5BeVFr?=
 =?utf-8?B?ZHFwdHFiYzF6M1A0eU02eWcrWlhPWmhmV2ozQjRPR0lzaHNtZzl6MVVZMFBa?=
 =?utf-8?B?TW5Ib3J6emhVSW85VHVoaTMweWswMW5LNnd3Z09UWVN6MXo4YWlZN0dZYjd3?=
 =?utf-8?B?RmVaRGhPcnRBUUc0TGZxSHVjVW9KWksybENFR01kbzNuVCtXNzNiOTBUNm81?=
 =?utf-8?B?aGxJYVo5d1JEM2NXbkpjTFJKazJiM1RZdFVDU2YrZHN4Nlc1RldTZTlyamsv?=
 =?utf-8?B?L3VIME54STIwU25ZZXY1aS8vbGRna2VKTHNmVWZkWENRby95bE4raTVmZFpX?=
 =?utf-8?B?dVVOWnZOWnNhR2ozcmpCRk4veWpHN2VFVFBjTStVMll4SFVtd1drLzhCMFRF?=
 =?utf-8?B?MnlyL0RRaU8yR3ZsQUsva0tDUWdzT2MyMGF3Qm9HTUl0cmRwK1p4cXpnM1VI?=
 =?utf-8?B?MVJEMWJ5cVJxZVU0c2plVnQ4ckdNck4yRXZjZnhudzVyYTJBVU9NcVYrR3Rw?=
 =?utf-8?B?VTBlSDl6ZFVJeGZKNkdOcnFhY2Z4bytnN240QWQwM2pmL2Jvb21DaGpjaUtZ?=
 =?utf-8?B?RGV2OWVaVnloeEVOaktvNEtRU0t5YVdodVB1K3lCNi95em5sZFJMSGl3NlFp?=
 =?utf-8?B?V1V2RXNFRkdEcnY2UnkzQlNRamRwc3NSbXJUNmJFM1hSRUtxMiszemwyMURY?=
 =?utf-8?B?RjJtc0ZaRGdYNnllb21nNXlDL0IwU3BId2J1d1BVODNKVlYrZVBRWENUb1NW?=
 =?utf-8?B?a2FnWnNPUFhrTDQzSU54Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjRmbVFHdTFmQ2JFa0VqSVNaN2pYdWczSWxmR2t5R2ZhRlBHVFFlbGhsRXdD?=
 =?utf-8?B?WitkSWxrMi9qSFI0bnpuWTB3aEk3dlFNeFErUnozNmduaDhrQ2lKZmdXaTJm?=
 =?utf-8?B?dzZLMzRhSmFOenJxWElHaVBVZG90NkJVK3FGL2RoYUZzR3p3ayt6UHpRVGx0?=
 =?utf-8?B?WWRJYXd3WTdvVVJxeHlFS3lZclAySVlucC8zZzRCYjhORWZMTGFXclRjYzBL?=
 =?utf-8?B?WnF1Sk1qeVRHTVVPN3FHZFY1Nk1kdUdLS3ZDcDlmb2VlWFVHdHRhVjBSbkI3?=
 =?utf-8?B?Sk4vbzdqTDNhRGw5cmhKQWFIcGo3QnhaWS9MVmFvUlk3K21GbnkxWHBNVUdu?=
 =?utf-8?B?QnlhNFVKQTdHcVZKNmM3Z0xDYnAxUktEUmdUVXk2TmE1WUpRL0FjYlRDMHU5?=
 =?utf-8?B?YmpuM2JWK3VBSlJGcHFPaUlGT1BXZmE1UzlBMTdqMVJ2VTFiT0p5NXR3Q01a?=
 =?utf-8?B?NHc0My96bTF3ak85R2F1QVpxRUdldzlMVnNhSnVzNmVxTWk2b0FueEEycDR3?=
 =?utf-8?B?WDNkUm5sTFR1Tm90OHhMQVpwTjBWV0J1VXdmYWZyWUswUTBOZ0NSbFJ5L3lE?=
 =?utf-8?B?bzVtOGZMMVRrRVhMVjJySWlQdmVGM2I2VHdodFJ5V2l1emM3ZzVCdURtbnRN?=
 =?utf-8?B?OE01ZDUrMXJ0eDZValdrU25ONmFCcEN4QU5hVmE0NlZ3LzIwQ2RvYzViYzg3?=
 =?utf-8?B?S085cTdCdHU4cTl5VmVORlFZWEkwMlVsakNlWEdGaUJhWkFqcGxGS095UmJq?=
 =?utf-8?B?VjhRbHFrV0NndmM1bEYyZmYxV2Q0Szl6b2hMcVAxdzVmdG9WVi9vN2VIZmZj?=
 =?utf-8?B?MGhFUVM1Q3VabzAzVWZTUzZWc2Z1Uml4YUdqV085TVpqUitCU24za2dFMlBy?=
 =?utf-8?B?OUN3V25oeWU0eFZneG5ud2RZdWZuaC9ib1hQNEg2NUliTG81bjVzUDdpMDVX?=
 =?utf-8?B?VmVUZURvVXZPOTJwbHNaeURjZGt2UUZ5RFp3bW5NS25wZktrTUcvbk1DZUh0?=
 =?utf-8?B?SDBHQ1NPYnhLenowZE82QUkrQnYwa0JEbWl5Ni9md1B0Tm92L0liRDVXb0lJ?=
 =?utf-8?B?UmJ3WnBtSnhTbnNaNTErbUE0UVV4OWN0VVYvUEJBc2xLU0hmUmRQQzMvdFA4?=
 =?utf-8?B?R0RKck14UVpLNHZSZVNQWE9sTTFIcUVOcDZhQWVyeUpudFIyczJudFhOcmp1?=
 =?utf-8?B?d2JNZHJQN094WHo2MUMwQ1ZkNVYwTkp6Znl2dGFhbDNrM05lTzlaTkdZdW4r?=
 =?utf-8?B?ekJva3MyK2RiOVZkbmEvRkM3TXk1KzJ5TFgra0xlY3hZQXZxQ29FZWxJRG9B?=
 =?utf-8?B?akwrdFlVb20wWlhXbkttNlNETjd2S2V1SElpeUs2WWpqenhDYmhxd0liTmNN?=
 =?utf-8?B?SDRNWmxhSlpGU3dyM0ZmdnFuUlNJWHE3U0x4aTlPcGdYbUtzZUEwUlpqcXox?=
 =?utf-8?B?d0VnSzU3MXM4NEhmSlRmU2hsWkwwUXpxUzhKL3lPcitnZjNrb3F0R3NiK1BW?=
 =?utf-8?B?Rm1ZRUV0endnQWtzcmppYnl3UzFuYndSL3NrUEZDWG1UTmRWbFFFQzNBR3lY?=
 =?utf-8?B?QzVkTEJoREZQMTVpNGNwU0luV0tUQ3FaQWw0ODRmM3drYVYyb3V3QzFFbWRx?=
 =?utf-8?B?Qmx1STlKUlR1bk5VcEFPSS9raVFLTXdpWnVjMkVNNjBTcS83b1NvTUFQVTlQ?=
 =?utf-8?B?cUMvbG9oRnByTmdEazh1TnlvbkdsL016MVhkK1g2cjJpTlJWemM2b2wxc1dF?=
 =?utf-8?B?Q3hnT0cxaEZpMVNIVVFqaHhiRGFwTlhnRWQ2MGpJNDA5T3F6TytSYnZTQlR1?=
 =?utf-8?B?NmlKL2QrckpOMGwwZUdzOW9FNVZXV3NnbTd4bUpMamhxUjlKSkVoQnV1eFAv?=
 =?utf-8?B?MTJLMnEwNFhDZmJYZ1J0WExKQW15WkJCL3VadHkxQWZPMVdPTjUzaXliOEIy?=
 =?utf-8?B?My8yRGVySmhyZStTbVNZWFpQMEJ2M1Bta1N4Wkl1eWlOcWJPU0RYeENKRkFl?=
 =?utf-8?B?SWdSd3FEWUU0anBVclF2YVgvVHJlcWZPWlNJZXBCWkY4VGp1S1lFRXVoNEVN?=
 =?utf-8?B?NDZ1WDFhMjRjZVlWaGlJZjF2M1BsVm5lZFdaQXJvVHg1S3ZBWGQxOXRISE5M?=
 =?utf-8?Q?EqG3+r6LjxQM09bRXcQ0ff1KW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7458afdd-196f-4348-6bd1-08dcc5adb0d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 09:01:36.7492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWNrEBLEo0XgsgYBqdYSViG5JTCrR9mtOPznFSPmXKWoV9HuDuzQbi6sjRLtGA3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
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



On 8/16/24 17:46, Raymond Mao wrote:
> Add sysinfo interface and definitions to support SMBIOS type 0 to
> type 4.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   drivers/sysinfo/Makefile      |   1 +
>   drivers/sysinfo/smbios_plat.c | 270 ++++++++++++++++++++++++++++++++++
>   drivers/sysinfo/smbios_plat.h | 104 +++++++++++++
>   include/smbios.h              |  12 ++
>   include/sysinfo.h             |  58 +++++++-
>   lib/Makefile                  |   2 +
>   6 files changed, 446 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/sysinfo/smbios_plat.c
>   create mode 100644 drivers/sysinfo/smbios_plat.h
> 
> diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
> index 680dde77fe8..3e478f87c23 100644
> --- a/drivers/sysinfo/Makefile
> +++ b/drivers/sysinfo/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_SYSINFO_GPIO) += gpio.o
>   obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
>   obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
>   obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
> +obj-$(CONFIG_SYSINFO_SMBIOS) += smbios_plat.o
> \ No newline at end of file

doesn't look correct.


> diff --git a/drivers/sysinfo/smbios_plat.c b/drivers/sysinfo/smbios_plat.c
> new file mode 100644
> index 00000000000..adbc8cf3cf2
> --- /dev/null
> +++ b/drivers/sysinfo/smbios_plat.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#include <dm.h>
> +#include <smbios_plat.h>
> +#include <sysinfo.h>
> +
> +struct sysinfo_plat_priv {
> +	struct sys_info *t1;
> +	struct baseboard_info *t2;
> +	struct enclosure_info *t3;
> +	struct processor_info *t4;
> +};
> +
> +/* weak function for the platforms not yet supported */
> +__weak int sysinfo_get_processor_info(struct processor_info *pinfo)
> +{
> +	return -ENOSYS;
> +}
> +
> +static int sysinfo_plat_detect(struct udevice *dev)
> +{
> +	return 0;
> +}
> +
> +static int sysinfo_plat_get_str(struct udevice *dev, int id,
> +				size_t size, char *val)
> +{
> +	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
> +	const char *str = NULL;
> +
> +	switch (id) {
> +	case SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER:
> +		str = priv->t1->manufacturer;
> +		break;
> +	case SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT:
> +		str = priv->t1->prod_name;
> +		break;
> +	case SYSINFO_ID_SMBIOS_SYSTEM_VERSION:
> +		str = priv->t1->version;
> +		break;
> +	case SYSINFO_ID_SMBIOS_SYSTEM_SERIAL:
> +		str = priv->t1->sn;
> +		break;
> +	case SYSINFO_ID_SMBIOS_SYSTEM_SKU:
> +		str = priv->t1->sku_num;
> +		break;
> +	case SYSINFO_ID_SMBIOS_SYSTEM_FAMILY:
> +		str = priv->t1->family;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER:
> +		str = priv->t2->manufacturer;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT:
> +		str = priv->t2->prod_name;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_VERSION:
> +		str = priv->t2->version;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL:
> +		str = priv->t2->sn;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG:
> +		str = priv->t2->asset_tag;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_CHASSIS_LOCAT:
> +		str = priv->t2->chassis_locat;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_MANUFACTURER:
> +		str = priv->t3->manufacturer;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_VERSION:
> +		str = priv->t3->version;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_SERIAL:
> +		str = priv->t3->sn;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_ASSET_TAG:
> +		str = priv->t3->asset_tag;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_SKU:
> +		str = priv->t3->sku_num;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_SOCKET:
> +		str = priv->t4->socket_design;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT:
> +		str = priv->t4->manufacturer;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_VERSION:
> +		str = priv->t4->version;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_SN:
> +		str = priv->t4->sn;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_ASSET_TAG:
> +		str = priv->t4->asset_tag;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_PN:
> +		str = priv->t4->pn;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!str)
> +		return -ENOSYS;
> +
> +	strlcpy(val, str, size);
> +
> +	return 0;
> +}
> +
> +static int sysinfo_plat_get_int(struct udevice *dev, int id, int *val)
> +{
> +	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
> +
> +	switch (id) {
> +	case SYSINFO_ID_SMBIOS_SYSTEM_WAKEUP:
> +		*val = priv->t1->wakeup_type;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_FEATURE:
> +		*val = priv->t2->feature.data;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_TYPE:
> +		*val = priv->t2->type;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_NUM:
> +		*val = priv->t2->objs_num;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_TYPE:
> +		*val = priv->t3->chassis_type;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_BOOTUP:
> +		*val = priv->t3->bootup_state;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_POW:
> +		*val = priv->t3->power_supply_state;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_THERMAL:
> +		*val = priv->t3->thermal_state;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_SECURITY:
> +		*val = priv->t3->security_status;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_OEM:
> +		*val = priv->t3->oem_defined;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_HEIGHT:
> +		*val = priv->t3->height;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_POWCORE_NUM:
> +		*val = priv->t3->number_of_power_cords;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_CNT:
> +		*val = priv->t3->element_count;
> +		break;
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_LEN:
> +		*val = priv->t3->element_record_length;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_TYPE:
> +		*val = priv->t4->type;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_VOLTAGE:
> +		*val = priv->t4->voltage;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_EXT_CLOCK:
> +		*val = priv->t4->ext_clock;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_MAX_SPEED:
> +		*val = priv->t4->max_speed;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_CUR_SPEED:
> +		*val = priv->t4->curr_speed;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_STATUS:
> +		*val = priv->t4->status;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_UPGRADE:
> +		*val = priv->t4->upgrade;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT:
> +		*val = priv->t4->core_count;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN:
> +		*val = priv->t4->core_enabled;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT:
> +		*val = priv->t4->thread_count;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_CHARA:
> +		*val = priv->t4->characteristics;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY2:
> +		*val = priv->t4->family2;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT2:
> +		*val = priv->t4->core_count2;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN2:
> +		*val = priv->t4->core_enabled2;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT2:
> +		*val = priv->t4->thread_count2;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN:
> +		*val = priv->t4->thread_enabled;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sysinfo_plat_get_data(struct udevice *dev, int id, uchar **buf,
> +				 size_t *size)
> +{
> +	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
> +
> +	switch (id) {
> +	case SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENTS:
> +		*buf = priv->t3->elements;
> +		*size = priv->t3->elements_size;
> +		break;
> +	case SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_HANDLE:
> +		*buf = priv->t2->objs;
> +		*size = priv->t2->objs_size;
> +		break;
> +	case SYSINFO_ID_SMBIOS_PROCESSOR_ID:
> +		*buf = (uchar *)priv->t4->id;
> +		*size = sizeof(priv->t4->id);
> +		break;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int sysinfo_plat_probe(struct udevice *dev)
> +{
> +	struct sysinfo_plat_priv *priv = dev_get_priv(dev);
> +	struct sysinfo_plat *plat = dev_get_plat(dev);
> +
> +	priv->t1 = &plat->sys;
> +	priv->t2 = &plat->board;
> +	priv->t3 = &plat->chassis;
> +
> +	if (!sysinfo_get_processor_info(plat->processor))
> +		priv->t4 = plat->processor;
> +
> +	return 0;
> +}
> +
> +static const struct sysinfo_ops sysinfo_smbios_ops = {
> +	.detect = sysinfo_plat_detect,
> +	.get_str = sysinfo_plat_get_str,
> +	.get_int = sysinfo_plat_get_int,
> +	.get_data = sysinfo_plat_get_data,
> +};
> +
> +U_BOOT_DRIVER(sysinfo_smbios_plat) = {
> +	.name           = "sysinfo_smbios_plat",
> +	.id             = UCLASS_SYSINFO,
> +	.ops		= &sysinfo_smbios_ops,
> +	.priv_auto	= sizeof(struct sysinfo_plat_priv),
> +	.probe		= sysinfo_plat_probe,
> +};
> diff --git a/drivers/sysinfo/smbios_plat.h b/drivers/sysinfo/smbios_plat.h
> new file mode 100644
> index 00000000000..3576f492ecb
> --- /dev/null
> +++ b/drivers/sysinfo/smbios_plat.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024 Linaro Limited
> + * Author: Raymond Mao <raymond.mao@linaro.org>
> + */
> +#ifndef __SMBIOS_PLAT_H
> +#define __SMBIOS_PLAT_H
> +
> +#include <smbios.h>
> +
> +/*
> + * TODO:
> + * sysinfo_plat and all sub data structure should be moved to <asm/sysinfo.h>
> + * if we have this defined for each arch.

But why?

> + */
> +struct __packed sys_info {
> +	char *manufacturer;
> +	char *prod_name;
> +	char *version;
> +	char *sn;
> +	u8 wakeup_type;
> +	char *sku_num;
> +	char *family;
> +};
> +
> +struct __packed baseboard_info {
> +	char *manufacturer;
> +	char *prod_name;
> +	char *version;
> +	char *sn;
> +	char *asset_tag;
> +	union baseboard_feat feature;
> +	char *chassis_locat;
> +	u8 type;
> +	u8 objs_num;
> +	void *objs;
> +	size_t objs_size;
> +};
> +
> +struct __packed enclosure_info {
> +	char *manufacturer;
> +	char *version;
> +	char *sn;
> +	char *asset_tag;
> +	u8 chassis_type;
> +	u8 bootup_state;
> +	u8 power_supply_state;
> +	u8 thermal_state;
> +	u8 security_status;
> +	u32 oem_defined;
> +	u8 height;
> +	u8 number_of_power_cords;
> +	u8 element_count;
> +	u8 element_record_length;
> +	void *elements;
> +	size_t elements_size;
> +	char *sku_num;
> +};
> +
> +struct __packed processor_info {
> +	char *socket_design;
> +	u8 type;
> +	u8 family;

packed is nice but I think you should use pahole and look at them to see
where you have gaps. Because I am quite sure you have gaps there.

char * is 64bit
then two u8
and below is another pointer which has 64bit.

Or 32bit arch it is the same.

> +	char *manufacturer;
> +	u32 id[2];
> +	char *version;
> +	u8 voltage;
> +	u16 ext_clock;
> +	u16 max_speed;
> +	u16 curr_speed;
> +	u8 status;
> +	u8 upgrade;
> +	char *sn;
> +	char *asset_tag;
> +	char *pn;
> +	u8 core_count;
> +	u8 core_enabled;
> +	u8 thread_count;
> +	u16 characteristics;
> +	u16 family2;
> +	u16 core_count2;
> +	u16 core_enabled2;
> +	u16 thread_count2;
> +	u16 thread_enabled;
> +};
> +
> +struct sysinfo_plat {
> +	struct sys_info sys;
> +	struct baseboard_info board;
> +	struct enclosure_info chassis;
> +	struct processor_info *processor;
> +	/* add other sysinfo structure here */
> +};
> +
> +#if CONFIG_IS_ENABLED(SYSINFO_SMBIOS)
> +int sysinfo_get_processor_info(struct processor_info *pinfo);
> +#else
> +static inline int sysinfo_get_processor_info(struct processor_info *pinfo)
> +{
> +	return -ENOSYS;
> +}
> +#endif
> +
> +#endif	/* __SMBIOS_PLAT_H */
> diff --git a/include/smbios.h b/include/smbios.h
> index 00119d7a60c..60e28a89af8 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -154,6 +154,18 @@ struct __packed smbios_type1 {
>   #define SMBIOS_BOARD_FEATURE_HOSTING	(1 << 0)
>   #define SMBIOS_BOARD_MOTHERBOARD	10
>   
> +union baseboard_feat {
> +	struct {
> +		u8 hosting_board:1;
> +		u8 need_daughter_board:1;
> +		u8 removable:1;
> +		u8 replaceable:1;
> +		u8 hot_swappable:1;
> +		u8 rsvd:3;
> +	} fields;
> +	u8 data;
> +};
> +
>   struct __packed smbios_type2 {
>   	u8 type;
>   	u8 length;
> diff --git a/include/sysinfo.h b/include/sysinfo.h
> index 17b2b9c7111..6c9de7744c1 100644
> --- a/include/sysinfo.h
> +++ b/include/sysinfo.h
> @@ -42,18 +42,74 @@ struct udevice;
>   enum sysinfo_id {
>   	SYSINFO_ID_NONE,
>   
> -	/* For SMBIOS tables */
> +	/* BIOS Information (Type 0) */
> +	SYSINFO_ID_SMBIOS_BIOS_VENDOR,
> +	SYSINFO_ID_SMBIOS_BIOS_VER,
> +	SYSINFO_ID_SMBIOS_BIOS_REL_DATE,
> +
> +	/* System Information (Type 1) */
>   	SYSINFO_ID_SMBIOS_SYSTEM_MANUFACTURER,
>   	SYSINFO_ID_SMBIOS_SYSTEM_PRODUCT,
>   	SYSINFO_ID_SMBIOS_SYSTEM_VERSION,
>   	SYSINFO_ID_SMBIOS_SYSTEM_SERIAL,
> +	SYSINFO_ID_SMBIOS_SYSTEM_WAKEUP,
>   	SYSINFO_ID_SMBIOS_SYSTEM_SKU,
>   	SYSINFO_ID_SMBIOS_SYSTEM_FAMILY,
> +
> +	/* Baseboard (or Module) Information (Type 2) */
>   	SYSINFO_ID_SMBIOS_BASEBOARD_MANUFACTURER,
>   	SYSINFO_ID_SMBIOS_BASEBOARD_PRODUCT,
>   	SYSINFO_ID_SMBIOS_BASEBOARD_VERSION,
>   	SYSINFO_ID_SMBIOS_BASEBOARD_SERIAL,
>   	SYSINFO_ID_SMBIOS_BASEBOARD_ASSET_TAG,
> +	SYSINFO_ID_SMBIOS_BASEBOARD_FEATURE,
> +	SYSINFO_ID_SMBIOS_BASEBOARD_CHASSIS_LOCAT,
> +	SYSINFO_ID_SMBIOS_BASEBOARD_TYPE,
> +	SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_NUM,
> +	SYSINFO_ID_SMBIOS_BASEBOARD_OBJS_HANDLE,
> +
> +	/* System Enclosure or Chassis (Type 3) */
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_MANUFACTURER,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_VERSION,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_SERIAL,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_ASSET_TAG,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_TYPE,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_BOOTUP,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_POW,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_THERMAL,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_SECURITY,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_OEM,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_HEIGHT,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_POWCORE_NUM,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_CNT,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENT_LEN,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_ELEMENTS,
> +	SYSINFO_ID_SMBIOS_ENCLOSURE_SKU,
> +
> +	/* Processor Information (Type 4) */
> +	SYSINFO_ID_SMBIOS_PROCESSOR_SOCKET,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_TYPE,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_MANUFACT,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_ID,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_VERSION,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_VOLTAGE,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_EXT_CLOCK,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_MAX_SPEED,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_CUR_SPEED,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_STATUS,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_UPGRADE,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_SN,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_ASSET_TAG,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_PN,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_CHARA,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_FAMILY2,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_CORE_CNT2,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_CORE_EN2,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_CNT2,
> +	SYSINFO_ID_SMBIOS_PROCESSOR_THREAD_EN,
>   
>   	/* For show_board_info() */
>   	SYSINFO_ID_BOARD_MODEL,
> diff --git a/lib/Makefile b/lib/Makefile
> index 81b503ab526..1829647e83d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -42,6 +42,8 @@ obj-$(CONFIG_FIT) += fdtdec_common.o
>   obj-$(CONFIG_TEST_FDTDEC) += fdtdec_test.o
>   obj-$(CONFIG_GZIP_COMPRESSED) += gzip.o
>   obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += smbios.o
> +ccflags-$(CONFIG_SYSINFO_SMBIOS) += \
> +	-I$(srctree)/drivers/sysinfo

I can't see reason for this. Why do you think make sense to keep header in 
drivers/sysinfo when you can move it to include/ directly.

>   obj-$(CONFIG_SMBIOS_PARSER) += smbios-parser.o
>   obj-$(CONFIG_IMAGE_SPARSE) += image-sparse.o
>   obj-y += initcall.o

M
