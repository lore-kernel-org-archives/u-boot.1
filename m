Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1612C71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 06:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FFD782CF8;
	Fri, 20 Jun 2025 08:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3rk4oeAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7D5982CF8; Fri, 20 Jun 2025 08:26:18 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E245282D17
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 08:26:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKi5xyJ1+gNc+qpMwU/269ZCK0WjFwvkcHPgaEf1AgQ48Wg8YqBYhg5sp8sU2RbnyeONDx6thOSXMVXX6q19he2mwMUYfylAjKpGlVCXeqJCeQ6OgbnPaEfqOf/h3SO6jxdtiKTZbdXkmMIQ0JFqVlA3QzWPVHfFLZcvAgSCoEN4CZRcDx+WdKL8v5aM3dhsXOaDTHw4o0lIJEGUKbmrlOcEDxOvtAdOgcJuzAmMQSvk+w4XuXZhKDJPCenJY2+0NuzC4WlGkEy2ggWMThv4LyVWPDiTZYqNbtTofc6iu2580i6d8WTyi9IUn6m4TBhrel3VM02cqRk5emf3kWndkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVwVLIr+aBzdzzffXCW1UpYfJ+d5H1cK5WBj0Q5xO4w=;
 b=RrZfYTMA9BzDaJI6sAyNGwwNPckmHaMSkQzgJPu4IBrCAm+zn0s2ZB5l37gPdLVBmK1T4StXIUU8aqAlce4XJPY4owZtfxob6bUPJ/dAwoUvyQa9nvaV7TIAp224k7/OBbUvyORI7XDrY1ffIEk3M9vMo+8OUqBJj6kEGtMebFC8F47jWMExV66AuNqp6Hwi+w4VOJTBZwpwLjO8TLDHA+HxtKV4NRXit13moiFWQoBzdUkLywcXWtTzOqFUlJ2dQStZcAxno1oVJsxGBHac5KGFDgyLOvx2sFaiCpYiKyW0x+uTJb/9ySiUOTpYjrVI3HwKza4eVDl4aNixDVsVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVwVLIr+aBzdzzffXCW1UpYfJ+d5H1cK5WBj0Q5xO4w=;
 b=3rk4oeAWllfaoD6/0FuiXaW7MmBcBWyGCDHyNEct9NM8g9TQR4oiWmR3BVZlGijDQPCoqMFA/Tu0JxQOGPpBUKHakvOONTBuf6M56IATt44YkF9txmxZFPF7MrKf4r0OKmFyOSZRHpetuseyA+rdCPofOBGXETpJSTiIgqbltvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8321.namprd12.prod.outlook.com (2603:10b6:8:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Fri, 20 Jun
 2025 06:26:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:26:07 +0000
Message-ID: <c6e4593f-fab1-417a-ac50-a4b0218793d3@amd.com>
Date: Fri, 20 Jun 2025 08:26:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] fdtdec: apply DT overlays from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, venkatesh.abbarapu@amd.com,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250618145930.2652304-1-raymond.mao@linaro.org>
 <20250618145930.2652304-7-raymond.mao@linaro.org>
 <9a5ed161-0420-4656-9fcf-6d122d4f6c0e@amd.com>
 <CAEfUkUL5L6YVbWtZrjitKuRPbs_3-=nr4i_1xtppi6CcXhhv1w@mail.gmail.com>
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
 CwIEFgIDAQIeAQIXgBYhBGc1DJv1zO6bU2Q1ajd8fyH+PR+RBQJn8lwDBQkaRgbLAAoJEDd8
 fyH+PR+RCNAP/iHkKbpP0XXfgfWqf8yyrFHjGPJSknERzxw0glxPztfC3UqeusQ0CPnbI85n
 uQdm5/zRgWr7wi8H2UMqFlfMW8/NH5Da7GOPc26NMTPA2ZG5S2SG2SGZj1Smq8mL4iueePiN
 x1qfWhVm7TfkDHUEmMAYq70sjFcvygyqHUCumpw36CMQSMyrxyEkbYm1NKORlnySAFHy2pOx
 nmXKSaL1yfof3JJLwNwtaBj76GKQILnlYx9QNnt6adCtrZLIhB3HGh4IRJyuiiM0aZi1G8ei
 2ILx2n2LxUw7X6aAD0sYHtNKUCQMCBGQHzJLDYjEyy0kfYoLXV2P6K+7WYnRP+uV8g77Gl9a
 IuGvxgEUITjMakX3e8RjyZ5jmc5ZAsegfJ669oZJOzQouw/W9Qneb820rhA2CKK8BnmlkHP+
 WB5yDks3gSHE/GlOWqRkVZ05sUjVmq/tZ1JEdOapWQovRQsueDjxXcMjgNo5e8ttCyMo44u1
 pKXRJpR5l7/hBYWeMlcKvLwByep+FOGtKsv0xadMKr1M6wPZXkV83jMKxxRE9HlqWJLLUE1Q
 0pDvn1EvlpDj9eED73iMBsrHu9cIk8aweTEbQ4bcKRGfGkXrCwle6xRiKSjXCdzWpOglNhjq
 1g8Ak+G+ZR6r7QarL01BkdE2/WUOLHdGHB1hJxARbP2E3l46zsFNBFFuvDEBEACXqiX5h4IA
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
 If49H5EFAmfyXCkFCRpGBvgACgkQN3x/If49H5GY5xAAoKWHRO/OlI7eMA8VaUgFInmphBAj
 fAgQbW6Zxl9ULaCcNSoJc2D0zYWXftDOJeXyVk5Gb8cMbLA1tIMSM/BgSAnT7As2KfcZDTXQ
 DJSZYWgYKc/YywLgUlpv4slFv5tjmoUvHK9w2DuFLW254pnUuhrdyTEaknEM+qOmPscWOs0R
 dR6mMTN0vBjnLUeYdy0xbaoefjT+tWBybXkVwLDd3d/+mOa9ZiAB7ynuVWu2ow/uGJx0hnRI
 LGfLsiPu47YQrQXu79r7RtVeAYwRh3ul7wx5LABWI6n31oEHxDH+1czVjKsiozRstEaUxuDZ
 jWRHq+AEIq79BTTopj2dnW+sZAsnVpQmc+nod6xR907pzt/HZL0WoWwRVkbg7hqtzKOBoju3
 hftqVr0nx77oBZD6mSJsxM/QuJoaXaTX/a/QiB4Nwrja2jlM0lMUA/bGeM1tQwS7rJLaT3cT
 RBGSlJgyWtR8IQvX3rqHd6QrFi1poQ1/wpLummWO0adWes2U6I3GtD9vxO/cazWrWBDoQ8Da
 otYa9+7v0j0WOBTJaj16LFxdSRq/jZ1y/EIHs3Ysd85mUWXOB8xZ6h+WEMzqAvOt02oWJVbr
 ZLqxG/3ScDXZEUJ6EDJVoLAK50zMk87ece2+4GWGOKfFsiDfh7fnEMXQcykxuowBYUD0tMd2
 mpwx1d8=
In-Reply-To: <CAEfUkUL5L6YVbWtZrjitKuRPbs_3-=nr4i_1xtppi6CcXhhv1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afe164e-a779-421e-1a8d-08ddafc35731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnpyTEhBa3IwaTlDVHo1cklOUE80U1NueU1EcVZheHpVRVhXZTdCN0FzekZF?=
 =?utf-8?B?Vk80MUUzNlNJWVZXVVYwVW1ObC9tc1h2RGc0b0dzbnE0VFlUZ3E2ekJ2bWhD?=
 =?utf-8?B?TnFEVGlvMDQ1MXN4alpaZExpKy95bkxSZWxCLzRreWxyaGgxQzJGaGhRT3dT?=
 =?utf-8?B?UmppU3J2WTl1VDNGWWF1MVNiL1JwUTZCODdRbU5wUEtHdmE1UjcweU40azV0?=
 =?utf-8?B?U0RoZWpoc285akxySmVXeVlpbkF1cVFOdW9xMUkycThsaGRhUERiVnBsZTQv?=
 =?utf-8?B?LzJQVUMwR3BqbUlSUUdtQ3V3bHNuMEhhdFBZQ09TbE1DSmFsK1lwOURaamVU?=
 =?utf-8?B?TllETjBXdURVQWgwZEFsTlRPSjA2ZzAwVjhUeXJTV2o0S1RSRCtRZXdIdXVP?=
 =?utf-8?B?YlZPeGoxbjNSSERobUIwNHhUSUZISWo0T1RuMUQxRWcxcU1ZTXUzUEdHeita?=
 =?utf-8?B?ZVlWb1ZYL2I5aWtiTVJNQVRGdk1PV0lTOW0wTHF5Z3o5VnNlM1NFTFFOU0Qv?=
 =?utf-8?B?c2NzQUIwWkdvWndJeTNKWnIyT0lvNlB5dm8wTjRZZlc1STdQOVg1WmNYWGV1?=
 =?utf-8?B?TVhDUzEzbVVMclhhbnVJNlM0ekswY0xGekpiNGd5bkE0K1craE5qczNuWTZy?=
 =?utf-8?B?b0N3ekR2ODFSdnJNTHM1elZrNVY2V2p5bVFLamk4QkV3TzlQM21nMjVMK1Nq?=
 =?utf-8?B?S2g4RG9ZOUdUaGVUK0JmZC83Rk5rZHdyWXNtVmJsZHZMM3JPbjZOVDRoYTJN?=
 =?utf-8?B?TmtlbVVTWDRrbk1wY0k5VXRYY1FOLzRSVTJ1R3RBRld3dHgwOGVwUUd2T3JR?=
 =?utf-8?B?WGdtaHljYitYNnNlWEc4MWlERnFQWHQ4SjEyZEFWdUtYQTJDNUVjU2J5VDRy?=
 =?utf-8?B?a0tKSjRDLzVabTVyKzArWlVGcXVlTkhDcWQ3aXVnQjE5cXkyb2Urc0JiN05L?=
 =?utf-8?B?WGYwb2NvVnFEbnpMRGd3MllvYlZkOXdHWDdSMWdpTExUTnNMNDY3c01kUVdG?=
 =?utf-8?B?ZHBxaTN0THh4QUUvREt3WGdUVkFWT1FmUzVtY2VsU1pGU0lPSVpVU2l2anNo?=
 =?utf-8?B?cWZ6RXNGVmRrdkJTV0pNcHR1ZzJ4Z0JPWFV3eXRESzVzYnN2VTJCak5uYVFB?=
 =?utf-8?B?Qm16M1dPaUhWZHdyaWJleWNybVh2YTZuK0dDeEttY0sxL1B2enBFRjU2bjNl?=
 =?utf-8?B?d3hEeUFNci9kL1Rpa2VzdTVJZmkyb0ZockQ5OGdkWUZteW8xb2RGL005MnZ3?=
 =?utf-8?B?Z1RFNG02QXgrSTdoWXkxM0FIbFBhb1R1a3ZUV2x4NTVjSzNWbWdwQnRBOEhn?=
 =?utf-8?B?dnNHMDNoTUlrcm50cFV2N0M5bG5pR3gxTi9lK0ZoMld0WDUyNjBmeWpvOFMr?=
 =?utf-8?B?VUI2TEtZMkl4aEhTZk1JVnRMend3U3M5cmMwY2xiVnpmUnNRYnZuNlhJbUcy?=
 =?utf-8?B?QklEWVlRTU9VWTNNanZUY0tEUU1IcUY1Qy83dVo0QjFKdGdzWGVYVVdQeFVI?=
 =?utf-8?B?aEkyVG5wdnJ4dUhHY2hWSnYwbmdZbmFQQUh6WDlPc1FVa1JHZjVvMGo5MUhE?=
 =?utf-8?B?TzAzNnBKbk1PSnRVbTBwTlhKREZxanZBVlRWanNPczhxR1FodXo3M2M2aFQ2?=
 =?utf-8?B?MTJLRG1XZEIzNUNWdXRLTUUrVnQ0dkp5Y1FHaGFSZm9xUytHSzR6NGNBYTZy?=
 =?utf-8?B?WDJia1ZDYTRBQytiT2kxeStrVHRIVTZVcTZoSDd1ZDNrOXhhZ1VNWmt6VWN4?=
 =?utf-8?B?ZlE1OEJUMTFHbUdzUjQySnRhSEoramgrSklNS1gxeEhxZ2JSQkdWbzdSWDdC?=
 =?utf-8?B?dDZ1N1laUVVMN1ZieWEyMk9LUzFKR0RpdnpNVzgrZ3RhSC93NGNrVkU0RUVq?=
 =?utf-8?B?SkZ1U21mVU5FL3JuOW05WUhKQms3c3VOWEdEaHppOTk2eTRVMnJVRE12bUw1?=
 =?utf-8?Q?1ECL0o0mUJk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0FKY3l5UENQV1REMVBWVzJ5Qy9UTnlXcWhRN0NOYUhicm5PUThTMXZybi85?=
 =?utf-8?B?ZnVWSHkvVHdid1AwSlRSNVhRVTJDQU92YUcxS2hzQnA5KzFTUHh6Vnlmb0VW?=
 =?utf-8?B?ZGJsMkFqelZ1NHJHMjBNVG5nek53VUdBOG9XbFYxVXlJVDJlYlJHdTZucGo5?=
 =?utf-8?B?a1hhWUR4N3Bkd3RhaVhkZWQ2c1ZCNHhlQ1JQOWlHc1BNdHl5S2owYXJrcWRl?=
 =?utf-8?B?N1AzRUJIZGZTMGdJalpZa1RGZ2dORkV0aTI3NlhDV3Q1WnFkZXJ0TVgzVDho?=
 =?utf-8?B?SDhSOVZjMGhTcXRvclcwaTRpZmlGN1A0YzRvdStvZVFWRjdkMGFFeUFGMmtF?=
 =?utf-8?B?Y0E2Zi9JVzJBOG1hUnovWjlCb1FrQ2Y1cWlyVnVsNncrb0tCWDBldWg1eklH?=
 =?utf-8?B?WW1UVkx0aVBrZmhZb05JU2tDb24vSEdiZ00zNzBTeHd0RU5jMU9VazVPaG9Y?=
 =?utf-8?B?dk9nMEpTVTVmWFNBSXFSN3VRTndrcjZmUHBzMjI4eGNmUFM4ak05eDF6dytF?=
 =?utf-8?B?SnVMRkk3WW9Kc1JuNzF2SWdSN25sYVNlM2JmVGgrajVXaTNkenNCb0RHc1Fx?=
 =?utf-8?B?dlhmRndTOXZYUkJMN0ltY01oNFRJMS83YnhaK3VHV1dWQUhldVQ2M2lkZ2FD?=
 =?utf-8?B?QUhrMHJZcjljdDg5eHM5QWdlaEpXQ0NhMmRaTXV6bE1hZlNjYzVaVDFpYVZl?=
 =?utf-8?B?WThKMG9KQzNNMHRsMGNaakgzSWdDTzdpZ0ZoeGJHMXNHRTVscC8waDU2bkl0?=
 =?utf-8?B?UTNJVFY0T0VKdnNvV3J6Z1BwZnExV3R5K3JUTWlPd0FpWlhhRmE4emZqSkx0?=
 =?utf-8?B?VVJMRU8rTkl3Y1YzWUxNcU9ZVDZUZWdFMWVJLzE4QjBIUmUzL1pjdnBnOHhG?=
 =?utf-8?B?Mm1ET01hMWlueUR2bWY4WWRQKzVPVTJ4MHdiWEQ4dmJmMS9pcXMwVkVwdmJG?=
 =?utf-8?B?bFpTYzArN0lKM2YzL0Z5Tm9XVFlwcnFXTWRpMHY4WlVSbHVOa1BPalNwQjM5?=
 =?utf-8?B?MVlEUTBJajYxKzZsOUpxSHg5djJmWmJvMG9uNnREeHU3TlBGU3RKTENPek9m?=
 =?utf-8?B?dXlRTEJHOEdyd0NheWVpaTZjMkRkeDlSYUhJQ1pNU3lRVzFrQngwYjZtTGlk?=
 =?utf-8?B?ekx1bnl2RVIvTnliSnVNTTFpSnl3aHc5T3VWQnJPOVRMS2dUZ0FsS3FvWFc4?=
 =?utf-8?B?VnNMWDJpbVBldUtQWEFFdldrcHFqNmZ6OEZndlNJeDNsS3FybEhPdEZiQ3Q5?=
 =?utf-8?B?cTYyelpLUVdHekx2eEg4aUhZbEErUURnajVpMmwwYVpWMExZdThUVnowMWNw?=
 =?utf-8?B?MkJ2RGJHT09ZcmxPREE4UjdlbThNUTB3N2pFZ3l1S2RqSFExUGRHZ0JyVDRw?=
 =?utf-8?B?UjJIN1dJRHIzVjZRNTNyZlllQ1F0bnpnZEZTQTdLeWM0S3B1bG1SVENwTGNK?=
 =?utf-8?B?eVR5TmRHb0RyUmNsa0cvSHhQNFlUODR6SjRNNjJqMi9uMkp6Z2hXSjdISncx?=
 =?utf-8?B?aS8zSWpiY3VYU0FDUlFnemVRWk5mSWsyMGsyOWpMVXpxRzFmN0dnVGp3QVVs?=
 =?utf-8?B?RFFiNkozemZzOUFabUxYNXFnQ1hpeGF0bkNyS1R5aXZ0VU5vMVpMSmV2WUR1?=
 =?utf-8?B?RVRMR1dYNEh1b0MzMDJQODlHZGRDOEZEUnpVaUxaU0U3c01tdjZhZXY4Nysw?=
 =?utf-8?B?UUR1UDJTMXowNVBybkMwNncyUHB1MVVHQnlPZmg5RDVseEU0cTFmYUJkaWNr?=
 =?utf-8?B?VndIZXFsVUxTRVRuU0p4Ym9tV0srNDhJQnoyamFvdmZlTTlSUWRTS3NkcWpk?=
 =?utf-8?B?WGRuLzlaWXQ3RjM5aWlDcE5pT3JKOG9IWUhsVDZnNGkvSXRoQUFPaHJoSHFT?=
 =?utf-8?B?L1RNNDZVY29jUkowTFhUL3VDUFVrUE9BSElhdDduMDZSbG16c3V1TS9aZG9J?=
 =?utf-8?B?MGZMYzBwSGJxMHZGWGtJMjFEOCtxUHJiQW5idis0S2VncFRsSkJ4QUJOcFhn?=
 =?utf-8?B?b21qZHNwWnAwNE9ybVJnU2p6LzFOOFFidU5xdVFSQ09tek9LMmxlTkYwYXA1?=
 =?utf-8?B?NzA3aW0wVXA2R3NhS0FiYVdaRWFncEUyVUJ3UHk0KzdkNkNBMEdNSkxHY285?=
 =?utf-8?Q?EzBAsbk1V/t+65mTJwONUMasQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afe164e-a779-421e-1a8d-08ddafc35731
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:26:07.6023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjseLjjaORNMAV94O3PQM54kVquxLAYak8tzGi9p+K1z+CZlzlwxy7LySciWoX1P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8321
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

Hi,

On 6/19/25 18:22, Raymond Mao wrote:
> Hi Michal,
> 
> On Thu, 19 Jun 2025 at 07:39, Michal Simek <michal.simek@amd.com> wrote:
>>
>>
>>
>> On 6/18/25 16:59, Raymond Mao wrote:
>>> During FDT setup, apply all existing DT overlays from the bloblist
>>> to the base FDT if bloblist is being used for handoff from previous
>>> boot stage.
>>
>> More technical details would be good to have here.
>> Especially that the way what you are using is to expand DT
>>
> Agree. I can add more details in the next post.
> 
>>>
>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>>> ---
>>>    lib/fdtdec.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 56 insertions(+)
>>>
>>> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
>>> index c38738b48c7..3a218d8c94a 100644
>>> --- a/lib/fdtdec.c
>>> +++ b/lib/fdtdec.c
>>> @@ -1687,6 +1687,60 @@ void fdtdec_setup_embed(void)
>>>        gd->fdt_src = FDTSRC_EMBED;
>>>    }
>>>
>>> +static int fdtdec_apply_dto_from_blob(void **blob)
>>> +{
>>> +     int ret;
>>> +     struct fdt_header *live_fdt;
>>> +     size_t new_fdt_size, blob_size;
>>> +     int expand_by;
>>> +
>>> +     if (!CONFIG_IS_ENABLED(OF_LIBFDT_OVERLAY) ||
>>> +         !CONFIG_IS_ENABLED(BLOBLIST))
>>> +             return -EPERM;
>>> +
>>> +     live_fdt = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
>>> +     ret = fdt_check_header(live_fdt);
>>> +     if (ret)
>>> +             return ret;
>>
>>
>> Why is this needed? You already have gd->fdt_blob which has been checked.
>>
> You are right, these can be skipped.
> 
>>
>>> +
>>> +     ret = fdt_check_header(*blob);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     blob_size = fdt_totalsize(*blob);
>>> +
>>> +     /* Expand the FDT for spare spaces to apply the overlay */
>>> +     new_fdt_size = fdt_totalsize(live_fdt) + blob_size + 0x400;
>>
>> Some notes about this 0x400 would be good. Do you see issue if you don't use
>> this value? Is file DTB after expansion actually bigger then origin+overlay that
>> you need to add 0x400 magic value here?
>>
> The value 0x400 is arbitrary and it really depends on the DTOs.
> When applying a DTO, it may create new entries in:
> The structure block (nodes, properties)
> The strings block (all unique strings, including property names and values)
> These new entries require extra space, not just equal to the overlay
> size - because:
> Some parts will bring in new strings, which get appended to the string table.
> Also alignment padding might require more bytes.
> What I am concerned about is that 0x400 might be not sufficient for
> those complex DTOs.
> Maybe more bytes are required.

Valid concern but it should be described in commit message to also say that it 
is just a number based on your experiments but maybe it is not enough.


> 
>>
>>> +     ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
>>> +     if (ret)
>>> +             return ret;
>>
>> You do resize inside tl list.. That should be described in commit message
>> because my exception was that this location can be read only from NS world.
>>
> I can update the commit message with more details but why should it be
> read-only? At least I don't recall if the spec says the TL is not
> expected to be updated in BL33.

It is not about if should be read only but about it can be because it is 
exported from secure world. I understand why you are doing it but please 
describe it to make it clear.

Spec is saying
"TL relocation typically happens in later phases of the boot when there is
more memory available, which is needed for adding larger entries."

> 
>> I didn't run this on HW and likely I should do it to understand this better
>> but isn't this moving CONTROL_FDT entry to different location which will have
>> bigger space for applying overlay?
>>
> Do you mean to move it to a predefined address like existing
> CONFIG_BLOBLIST_ADDR with more space reserved? I am open to it.

I don't want this because I don't want to define address where it should be.
I want to have one universal bootloader which can run from different memory 
locations and relocate based on information in DT/TL.

I just want to make sure that description declare that properly how it is 
supposed to be used.

> But what I have to say is that the entry memory can only be marked
> with void, no reclaim memory mechanisms. This leads to duplicated
> memory ranges.
> Other than that, I think dynamically increasing/shrinking the size is
> more flexible.

I have to take a look how exactly this is working. I though that you can reclaim 
that memory back. We plan to have limited space (6MB) for TL. There are going to 
be multiple DT overlays inside. It means I don't want to be any close to 6MB limit.


>> Isn't it also worth to check if existing CONTROL_FDT has enough space inside
>> that new overlay can fit there before resizing it?
> By default each entry only contains the actual size since bloblist
> (aka transfer list) is designed as a compact data structure and there
> should not be a waiver for CONTROL_FDT to carry additional spare
> spaces.

Right but you can build dtb via dtc -S/-p to add additional padding. It means 
dtb will be bigger which goes to TL and should be possible to fit overlay there.


>>
>>
>>> +
>>> +     /* The blob is shifted if it was following the FDT */
>>> +     if (*blob > (void *)live_fdt)
>>> +             *blob += expand_by;
>>> +
>>> +     ret = fdt_open_into(live_fdt, live_fdt, new_fdt_size);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     ret = fdt_overlay_apply_verbose(live_fdt, *blob);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     /* Shrink the excessive spaces */
>>> +     fdt_pack(live_fdt);
>>> +     new_fdt_size = fdt_totalsize(live_fdt);
>>> +     ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, new_fdt_size, &expand_by);
>>> +     if (ret)
>>> +             return ret;
>>
>> I didn't try to run on HW but don't you need to also adjust gd->fdt_blob to
>> point to current location where fdt is?
>>
> gd->fdt_blob is already pointed to the one inside TL, it remains the
> same, only the size is changed.

I though that you are moving base DTB inside TL list. Isn't this the case?
I have to do closer look and debug your code to understand it better.

Thanks,
Michal

