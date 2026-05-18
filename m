Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E966FCD4F49
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 758418469F;
	Mon, 18 May 2026 16:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wyzBxCV5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2487184150; Mon, 18 May 2026 10:46:56 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF99D83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT+giD/e9v7cvEvfDFH6WsNoeDd4CnVfL8lWbfQ9OrKufOy3Ibhsf0/FNC5dWR9l1vrjyg3pcehLO4Nv+VY+jSbcxkX9tpCpFgWjxq7t9be3ZZ03jYnbgiQGBkOlvXXtlVAWShvWO1yX7kcjWJCrms6WDneKNa49tNsFD9VKxH6OuvfRYGeVkVzStqyjAZdz24BoyJN4YhhuBGylmni+d/EZOVgqfswB6/E4f0hKZsMCS334gZWGZ8gxoo9e7kKQsf2808wc7LqGwNcfcAGu7wZam5+Jy6M3HehTZvbBV4qYald8OE1UH/2VNqrrwXRF0vI7D0yDK+2tpX37q7XnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1zY29Q1MFN2461mVn9VCw4EIIhG41l70RA5o1wrslg=;
 b=hf2Z6W5c7Zc/RI9W5gmqlOzTPIPAlgF+agAHgN/MvLyrrhfUT6tYfkFmIhFd8b168lRJKvMUtJqDET3fxcHkFj6KTY8xGOngH7stYf4Ki5IyqBbMlA9hhD+gnGiqOcSKH4DI8Dz8Xo+KLdWkPicVTkgg3gSlD8L01QEzj5TXS9/SZ51ZwQTULhcUMHMfjeHJO81sPF655n+D+bauq+Vybd1nEjMyRvya6nTWpX+5OHcVC5mLT5xrlcrZkfmitBv6UERKKq/c67HTC05Cb2Rkzr3KHpPz14NRIOyJY82IcCG7AnsGAbDbzoaAz0TFeXBY95o7oF4EU0ZYSVM9hXlL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1zY29Q1MFN2461mVn9VCw4EIIhG41l70RA5o1wrslg=;
 b=wyzBxCV5jMC1l0zP6Y0g7yrq+iT5bBjj2bB8Pne6xXJ4IVbVAcwR5/1XFUV8Ks5kGaAlyEVn/VKROF0fI11GFEDdsQ5tlJsq1KlKR88g+7m+g+JOjJ3PAhOZrHQa+N5Y9gmDP8Km49L0qgZZOIVf5SAPORbZW3rkyVuBIeKQktA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 08:46:47 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 08:46:47 +0000
Message-ID: <6b467d26-a252-4a5a-8932-6844f12df660@amd.com>
Date: Mon, 18 May 2026 10:46:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/12] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
To: michael.srba@seznam.cz, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
 <20260516-qcom_spl-v8-1-69b55c9abffe@seznam.cz>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260516-qcom_spl-v8-1-69b55c9abffe@seznam.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c13b8dc-3bb4-4f50-b017-08deb4b9ff06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|11063799003|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: YYZpzlS9FDT49PXexHXDIsrPjsGY7fCtlnNVJHfRUGWrZ5JV57uBEV55iy6EKn5R0BJA3qr4hAEwh9TNOIMX2q1vxhRS/Khxrd+jc5P0/RD89YvXDqhUSsfNXxqw+7VK77A/swoP5uFFdwbDxc4UAVvh+iCRWVRgdsQk60XprZQDQ/yPtf7hZhpUSH5ChXvlVPn/89t61avQVIsqsEQNcdBR21NFF1YtQG0grX1X832Ps9IT/SD9277L+L35nZiUNHd2NZoTLg7i1Bo1kGxyrVXCKjpUCN9+5oc0v8xixrxmN88ImiGNGpozoccVJwx/qDYS1akgeJOBHUDrCW2L9LBCFwuKy4ZGv4N1tL507ciRJW6h2IiJgqcAnWNwUKjOFVmMuHeUKZiYA6EbZ4s/y2E2v8IGzNNRhRQMerxj+B7fAy7uRml6VDXGcGQHcQavhythkOATa7Y2SLa3LSlKicBIS3H87uPZfyF12ER2sgvaFdzReUqqftpcLJkzppCZEtgzFIOHxSISMZveWEh0AHrWq7r1OV6rzYt0bJEqBRVVns36THI5QUGbP/EiAUS515vW7URqnkwcjRrgnaTG9UzdfBgHZWxpSYNMFwOhbYyrJQUiYQN5hoWAOa5TNjuLbsAdH5TOUUXNAXmbP/my98p5aVmIbmKuNnPCEmmuGNhWYW99MI4pbmSyusBgtLgu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(11063799003)(4143699003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emI3eEtkWVZQbUZ2WDYrNWRIVGk5S3duYml1N0dVTlhoRVFHbjAvTkIxd1Ri?=
 =?utf-8?B?T01zM24xL0cwMGlQbWVZTkZ4OENudllDNU4wUE9wK2hkLzRFK2VNOG1YWUk1?=
 =?utf-8?B?OUFYaEtBbFczQVhIdEJWMlNUNHd4SW1SNkhNTGw0VnZMZUpXaE1lb1R0d3dV?=
 =?utf-8?B?NVZuYWxMOENTd0VRYk9QM2NEQXY2QXNJWEZxNHl4UjB2aE5IY1gyVnkzZ0NL?=
 =?utf-8?B?cXA0Z290RHBFMFNUYi9DdTdSSnBJSVB2T1BMak9PL1NnRXhieW9SdFVVSER3?=
 =?utf-8?B?S05NeWF5Mk1DRXNyL2FFRHF6T3o2ajkzclhIZ1AxVFIyZVRYL0hQelNaNkt2?=
 =?utf-8?B?VStWNG9HeG5WSEgyR2xPaUVuUkt5VEI4Wll6QTVBakRWcXo1SWh0akh2WThk?=
 =?utf-8?B?VTJrL3BLMndkaDd2cEI3R3B5MUdESHpMdEM1WUt3UkRlRkU3L1VzTEJUL292?=
 =?utf-8?B?RUJabGJESHRrdTllUk9qT1VGTFIyUmZHRFBsV0JzZ1RaSFFDOFZMWEhtTnlP?=
 =?utf-8?B?cnQwT3Q5aHg5OG9rdnNwWjZVK241N3orczJaQ044a2ZzcW9Jdmc1cENWSFZm?=
 =?utf-8?B?RzZRN2NwS0czcldhQ1NPMExuZFV6bXg2c0JNTVNXSnpzRkRLek5DK3c3VGI4?=
 =?utf-8?B?TEVyTU4rTVptaVlCQjlYSXJVT2xJRklLQjJUR09ZUHQ3V29ybDVXQU5GTnN5?=
 =?utf-8?B?bjZKVzdlZ3hoSHJrUktsUjNqRlZBSnEwUW8zUjRVdTNCZ0lSZktOSGVzWG12?=
 =?utf-8?B?YWNnWkNXUDltNTB4TzdlZHdjdmY5WThHOWlSNndCa3RLVmtIL2ZkUzhIK3Yx?=
 =?utf-8?B?WE5LeFRheEdvT0t0UUt5SDZYMTZUdG1Fam9acWpPK3k0SEFiZHdXcFlXcjVL?=
 =?utf-8?B?YlpIM3FrMytDeEwySDlOWi9mVzM2djJIVmNWbU82SVZOMnNiUDEwTmJTaXgx?=
 =?utf-8?B?K2FZQkJnOWIzWElmSzJaZzlZTklxb0ZwSWI2TzhoSVkzYkN0MDltRDEzeTls?=
 =?utf-8?B?Mk05QVFMOWRMUlZDNzhVaHI0NVlTR0ppRzhSWUJPU0FndDVwYVlUSWpKeTl5?=
 =?utf-8?B?R2htdzhSNjFoWTFBaERmcUxod01ZK04rQmY2UlJQWVpIQ3VVamZPR20zcnMy?=
 =?utf-8?B?cUdpMUxpcTdSbCtRRW9jZ0JBcHVTNXdoYnVLTzFUb0lFUVBmRXQ4UXQ0VTFQ?=
 =?utf-8?B?VzVCekdabmxIQ05NeCtJVVFENUlsLzFPZzVUSHppdzRQZnJBMXo0dHAvZWhI?=
 =?utf-8?B?dkQ5bzgvOGtOaHVaYmhkMWt2d0NTUm43c1ZSK2t3RjBYQkthNXdJS2hlS0Zm?=
 =?utf-8?B?N2ZLc2VMVzcxcXc3REpxUzhiMzFQSnJnazQ3M0l1TElKZ2YxOGF3alAzazVQ?=
 =?utf-8?B?L3FBRFdlOGpnakZDV29jMXprOFVTbEYvYkRuMGYxOUlwVk9EdkZoaCtqRFE1?=
 =?utf-8?B?MHhKWXNEZnJodm0vM3N0TzdRZUlQenQxcmkxV0hRbUxXbHVIRW5icFFIeGxl?=
 =?utf-8?B?WTlWWTdMOUNBRUxtcnVkdnUzSEg2cXFVZVY5WDRuTjJocEFOU09lUHFHOEov?=
 =?utf-8?B?Q3pLOExvYkRHS2swUFNocXZ4Y3Rkc1VtM0RGWHRMc01kNTJlL0tqVndOV0dF?=
 =?utf-8?B?MXphb1RqS2l2TWxuWDk1U1NXNWNTeUdoaWN0NFI3V0N4dWQ3aStyRWw2Y2l1?=
 =?utf-8?B?Z091djBEOVFiZzFjaWdsQm5TNUFHamNkWmE4Q2kyNVFwUnVkOHVEazFyMWgw?=
 =?utf-8?B?ZFQ2TFNWaGdpN3NnbG9EMkI2dTFCZXpadXhyVGtGQVNyWUJRSjZXZTQvZHh3?=
 =?utf-8?B?QzdBcU4wbjQ5V1lWN0E1dG5aMmFFL2gwRVp4d3hINmZXSEYwNm40MGREYzI2?=
 =?utf-8?B?dFRnVzFpT0YzTk1mWUVWRFAyNTJJYzNIR1czdkVsYW15QlluVFovMnNNeWdG?=
 =?utf-8?B?aGNOUkNIbDY4Z1BQSjQwN0pWRENuWmhya3lNdzRudWRXNHRrOFJBNmtieU50?=
 =?utf-8?B?TmlLSko1WXRlanNaZGtiWGtRWGJITXVlWXFnbCtDTmMvTkpwMis5aWx4T3Q4?=
 =?utf-8?B?S1lvNGpKVDN5ZFFqOVVxRDVtakJUcnU1bC9sZVVJV0hKNGoyVVVmTkpIUFhU?=
 =?utf-8?B?eUFSMGR3Qkt0Z3QvcU0yZmEyOXVrcWM2aEpnMDIyYWpzalk0Y2pGcjJLYVd3?=
 =?utf-8?B?NGtlUE1LcXhiVUs1aXlVeWp1WDl2a0Y3RWpiOGQvdnF5OUdnVWpKQ3NZaXZ5?=
 =?utf-8?B?ekJTSzVhelUvZUhocVdMdEloSlBYaExXNGtqeTQxc3ZObmpqTjh3RUE2NTB3?=
 =?utf-8?B?eWNOSWp5aVdTdnBFT082VTNOS2M0Z213WE9jYWJMRzRWSjhydFY3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c13b8dc-3bb4-4f50-b017-08deb4b9ff06
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:46:47.4977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldVR8jcx1xyf9lZYYoVr3krjgU4VUZ/x1xdJlqLUVslVjO74nx4+R48F/LFYVrHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
X-Mailman-Approved-At: Mon, 18 May 2026 16:52:36 +0200
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



On 5/16/26 20:19, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> Some platforms (e.g. at least Qualcomm) use the ELF format in creative
> ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
> specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
> as the default).
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>   Makefile           |  9 +++++++--
>   common/spl/Kconfig | 12 ++++++++++++
>   2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 552328f9f2c..b8a3fe0bf81 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2008,12 +2008,17 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
>   quiet_cmd_u-boot-spl-elf ?= LD      $@
>   	cmd_u-boot-spl-elf ?= $(LD) spl/u-boot-spl-elf.o -o $@ \
>   	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
> -	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
> +	-T spl/u-boot-spl-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_SPL_TEXT_BASE) \
>   	-Ttext=$(CONFIG_SPL_TEXT_BASE)
> -spl/u-boot-spl.elf: spl/u-boot-spl.bin u-boot-elf.lds
> +spl/u-boot-spl.elf: spl/u-boot-spl.bin spl/u-boot-spl-elf.lds

Still missing FORCE here.
If you don't do it on risc-v you will see

   COPY    spl/u-boot-spl.bin
Makefile:2015: FORCE prerequisite is missing
   LD      spl/u-boot-spl.elf

Thanks,
Michal
