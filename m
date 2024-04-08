Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8C5CD128A
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF8B487F78;
	Mon,  8 Apr 2024 14:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CT31uOxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9945987DEA; Mon,  8 Apr 2024 14:59:57 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC12088069
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 14:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHqmtaJMhiehmP5JeGgVO2bD4bQSTqhKhGx6y6lM/9Grjvt09WmKDfHFeSblbHZzeHV3T/P41btu3Ga1NrSXY/R+OSfjmVT8qwJHRZe2dUxNodAf4u1lzdbLUDXpV5BjcAJioNud0SuyO72CUpJXr3oSUiTcPp7mDvfEpArIwLJ80Ht8zxVdYpFtXpz+wn1voWRhBKiJiISVswzVE9wU9blY8Jm/EcnXOEWn3/TcyR/5wlBROkW7Rsy4quGZDY8HUmriwkcOhfZ0J5EdqAvJ4+NpDGN33TVu2xakRLjOdD192sKUU0TAu7bebXLLMdJoqVNZnToMydLaNQPKN/7YHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a23U942dASFK7n5b4/LKvkhQfJmU9PYmLInk3pVLH4=;
 b=YHRlEVA5xWEukZSFl4bEgYGlsHwsAOgQfxMsJPwuLZ8UngU+H30McFFtm7560ArZq//69iEbElKqugjO8f7iTXRY8kNO8qq3XnRidJ3Je9dnlAvNVkYo1LGS/0ciMLwSDyySYyzHCPBNWL5pKfYTChFEHt4OmvFEQKgxjAvsnkJ4oV43tfaPvvEv1HcYnofDEAzHRjk7eliufQLRAzfh+tUUMcBbZMad0QpMVtj72AELkD5ja1Ht0c5T9tXf8QhxrpZLMFhzNzRO+K5gxs3FuMBpD4KzSRTY6QcrkEUT/hoICa+9OQWcBX6cwj1LimNlW99zQD/nKbX2C1hFOEoYjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a23U942dASFK7n5b4/LKvkhQfJmU9PYmLInk3pVLH4=;
 b=CT31uOxN7SyuzbwXsZmxAc8+oaIYggIAZkTaNP/h2kcwYmq/+L/SyYuNmOenVVXucyA+1SOtBny9ONca9VK480G/TJ5cOTy2Q4TAbtw1/brSAk8NBMxWH/3fEd8F+6joeJzi/55OIq9/VpiaTzpR1uuEGDOMInGSzhWjlZxvYlI=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 12:59:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.046; Mon, 8 Apr 2024
 12:59:51 +0000
Message-ID: <476510ce-8a1a-4ed1-ae98-04beb9c75607@amd.com>
Date: Mon, 8 Apr 2024 14:59:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Introduce spl_soc_init() for SoC specific
 initialization
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Devarsh Thakkar <devarsht@ti.com>, Fabio Estevam <festevam@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Yang Xiwen <forbidden405@outlook.com>
References: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240327121153.2455126-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8253:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxJZPTcyd9UB5v2A1NR9zNnd8A+w3N4PChyg7pghqtbEeR9otikDDyILvCKcM3BtH2U+NmGnx92CwgVaTDpPmLiMZzaUhdlAYrXR70Zl1JqwdQrxDPAO3pmefeEVR4k5H8XXpm7uvb7cY5Nt5Eh/McBZECJnackrU0suUW/98p3Lwe7e7qkwRTez1JGDA/mVEA0S1XojQs7i3HOVh2OJ4Hrpe+TEbJTe53fVza7FhutHVQyPGQF4uyDCejtMwFh5kYWgKsYkz+hWyAkRZIGaZf367Fb+gebIkFWkh+RV+8O0mK4BAlnUXeyTmrigI47yaQa+L+cOCZohTh2oIztW1T8JAlZbRZIdkbGPzXf7vgHvwXA8EsJY/erORix/bT8kVYZz81CQAhDlGy96VnDsqZsH6IR5qalabCZgyi36C3HQH63ZT+rg03mcq2Tj1HZsTYboGP1MWScsXLRS9tR78bjn4dtxE3OCK2hSu6wzQsgaBiJp3HtKE75xsOhbAZDf/jk648931Bg48iD3DXZWwZEHXIE1+THaFrPQj0bj0i6hl//fnVChrasxMycPRnjDnEp8Kf7xCYXgb0CGW2UdU1u35eZERFyGhHBJM4f33ANQyzEj+HBS4tBtoX5WouK53x18TrMKvLvEqAQw/uh5KQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29kVHk2WWozVENaNGhFbUw0bXdqeG16MjZveG0xaVdDdytLSGEyVFJkSTNB?=
 =?utf-8?B?Vi85UG5udFVTOGRib3NTc1VCNmZqQUhqcFR6MFdhc3l2R2txbmk3cWpKK251?=
 =?utf-8?B?VVRvbmk2Unh4TFhFazRQU3BSV2x0YzIxOGw2bDZTampoQ3RheFZMTmJGVTVY?=
 =?utf-8?B?K0x1MGVqRGdjTlJiR0NMVGV2cnc2SDdFR2x3Znp5a2hPK25oNjFFSTdoMFAr?=
 =?utf-8?B?d1JsQ0dsZXVBS0p4U3J4cG5lWitDN1Y1V0tRUEwyOHM5WUo4Qk9hU0ZsUmh2?=
 =?utf-8?B?aEVXbkd2L2xUZEFtTWRBWlc0YU5zVHdSTkZwbWxES1FUN0U0TzFkQWtHOCs5?=
 =?utf-8?B?VDFZRUpvK1VkcVJSVVFSenNUOEFNSGUvT01DTU5sM1FnTW8rZVR3T1RicHJp?=
 =?utf-8?B?M2I5RWZ2eDV1eTR3L2xLN3NuRXpDVTZ1L1NDYU1ndWtCUTAvaEtqZ3krMFUz?=
 =?utf-8?B?eC8zaVVCaE9wRlRlTmtNSHhBS3duK2d4aUxLcU5RdkVweUhMQS9rMXNCMlNY?=
 =?utf-8?B?d3hjZnpuY2pGcVd2SS9CR1ZJbFVmWGFkWlJDVmI0ZDBPVlNreG9hazh6UWJh?=
 =?utf-8?B?Ym1aYit2VnU3T2paL3ZzSy9OelVqYUI5Q3hxUHJvTmhOWW9VbDRIOHpFWW5P?=
 =?utf-8?B?dGRJN2hWQ1gzVkR6NldyVnNYbWs4TVdxNnBYTVJDdWpHL3VsN3BWRkoyeFEx?=
 =?utf-8?B?eEVTSEsva1RsR29JNjUxS2FJbWRMcERyQ09keDlDWWI1ektBNUZmdTFHSWpm?=
 =?utf-8?B?TTBtV2UrcDh2YVpvOU9PQmpQeEFVWFFrYVplWXYzUHVzeFFaRXI2L3ErREdC?=
 =?utf-8?B?Y3RjSnhIRzlOVDUyVEJXeXBOaVFYbzdKVTVUcHJGZGZBRFFOaFZDOEQraG1t?=
 =?utf-8?B?T2hVU0dOSTBJZ0VDSGMxaHBVbW9NcjczVG8zbzhiR0R5VWFzQlR3a0lwTC8v?=
 =?utf-8?B?ODBna3R2ZVdVa25wYjF5YnBTRm44VXR3ZEQxcjduYVN1U1R5dVBaLzRTc2RF?=
 =?utf-8?B?OEIvM1pmUEk5VGwyOE9oRG5jZlFzZzdFQzBuSUs1eDhxUnJsQUJUT1gvUFVo?=
 =?utf-8?B?V21CaXZoQWFCWS90MGJFUWZXS0dFUkxMcDJxcVBSdkdBTlczN1hiUUJEZmdh?=
 =?utf-8?B?eUdzMEE3Y0lhdmRFUE53STVjK0pxVTEwTVNBL2toclZCMGdsSlJBTi9zMDBP?=
 =?utf-8?B?Um9rcU9Nci8yZUMwSFVEYm1lVGtEQmNwcTBwWGJGaGNBenJzMVVSbkZEeXNp?=
 =?utf-8?B?Y1h5OWorQ204TlpRUC84RHpQSUxOa0IyRU0rZUtNWFhLMVRyaVMvZlpGU1pz?=
 =?utf-8?B?WStNM2hEUHBkbnRBeXJKVDRnMFdhWEdCQTdaTXYxTmt5VURDWFpuS2R0ZmtO?=
 =?utf-8?B?Yk83OXpFL1VLNXRhMnVyeHZYdWlDSk5xbU9DUWpLbjNqU0hKR0pFcE5IcFJC?=
 =?utf-8?B?Z21GODJydmQ5TTVqeFFzbm5tUzdtSi9RZkZYS1hJL01tYjMrL1JFa0hkZHFK?=
 =?utf-8?B?d3VtRkFGU0Y3dVBrdTAvT2JCdGhqS2NMVEZpMVBEZGhMRjUwc05ZdWFiQmVw?=
 =?utf-8?B?S2Q3SnNic2NoZ3p3T1dLSC9GK3RuYlJ5MUxEOFZjR0VNMm03bUJBTEFvWDly?=
 =?utf-8?B?SnlNMEJKNnJYNnBHWWxTRmtwZHNiUjdweHpnaXB4TE43L3U4ZFdoSFRqamlH?=
 =?utf-8?B?bkFjSncrWElnbnBhb1lGUDdBSzNHTTdMaTQ2NlVjc2cyMnlUbEhYMnl5RTdQ?=
 =?utf-8?B?elJ1VHptN3ordVNSVFFWb0pJb2t1SHgvd3pCR3hoRFNBRXVLdXNvODUzUFlr?=
 =?utf-8?B?Q2dndmVLNlVuTG5xbW14bXdqcEZ2SDRnbnNBekRqN1FiZ0xQMnR4UHlqR3du?=
 =?utf-8?B?UW50N3pRNGhhYlhtWk9qTm81Q0g4U2dVb09IODFaaU13YmFKWmF5Zm14RzVX?=
 =?utf-8?B?MlJHeFlYaERDSytoUHppS25IZ2pCYjhJdjZ2YWFiQThSSlhRSDJ2S3JETzN6?=
 =?utf-8?B?UDVKamhoa0pFZkl3VVdHbk9iMlJmSlhUWkNnVXgrSTZZOHp5VUlUMlhHUG4x?=
 =?utf-8?B?ZVpJSElvV0NVNVF5N2xFRDk2Zldydm5DbmxkT2k5TVdoTFV3OURiaXYvdnJr?=
 =?utf-8?Q?jgWpn5K0OL12LoPrOgpjRZ39s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91abf8ed-7954-40c5-2c16-08dc57cbc756
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 12:59:51.6526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7HoOlfmUwuoka0oBj5JO/GQ1IvFcln6ZjEpEwhA7QGH8AirKyvMU4SxiHrrvKY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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



On 3/27/24 13:11, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> 
> Currently some vendors use spl_board_init() for their SoC
> specific initialization. This prohibits board developers from adding
> board init code using said function. This series introduces a new
> function in order to separate SoC init code from board init code.
> 
> 
> Changes in v3:
>   - Rephrase Kconfig description and correct minor typo
> 
> Changes in v2:
>   - Change spl_arch_init() to spl_soc_init()
> 
> Lukas Funke (2):
>    spl: Introduce SoC specific init function
>    arm64: zynq(mp): Rename spl_board_init() to spl_soc_init()
> 
>   arch/arm/Kconfig           | 4 ++--
>   arch/arm/mach-zynq/spl.c   | 4 ++--
>   arch/arm/mach-zynqmp/spl.c | 4 ++--
>   common/spl/Kconfig         | 7 +++++++
>   common/spl/spl.c           | 3 +++
>   include/spl.h              | 8 ++++++++
>   6 files changed, 24 insertions(+), 6 deletions(-)
> 

Applied.
M
