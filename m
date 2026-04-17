Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0652F8DFE3
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 08:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66B7584258;
	Fri, 17 Apr 2026 10:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="dIab2Nc4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B49684258; Fri, 17 Apr 2026 10:31:56 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C24D841C2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 10:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkmmIx4UagEMB4ix9/Nwgoi4IBMjV1dWDmPI6hkllqWeuYQpau0P4PezgpxcNJeCQX24Fjuazf0DpJqhPoO0pKC2EmImFEkAA+IBT/5TErRSmwwLvPzyHI4kNnVrhxytixy/igT3/jTF4Ahrd5LsHc265zoWgNmFNjqq/K8JS7vsX61yANf787fZpGei1cz2uK0HvpAvqRAEkVjEUb2rlj27HoPLt5CP3lpHbASmRIYU2aIUBLmOc/8DtkZzfd1ZIlPwWSbRxn9WqaUyt0D5QvKbGUCPUYVioomxthudTZz5N8+13n9eE3ZWPHbkVrGnVuzPR0Osl6+UAIJGuujsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9esJl5CGtKNj6r/mDhrymTHLuTeTwW9vewxqkMS4tc=;
 b=YCCc9kU/WDoxaLQRAkzEPBuyg1PXAdylqONPha7Ppu94O/1RT0DvWMi2XBiRGr5JAdw793rB6HnnOzd2uTUgW0vZvE+JtoVl2PmEEnod9tetxtPNLTYG+e7BOKuSW5I0ZeDmK+4UElzusaACUTlHJugrWTBF8D5Q4z0VSWMFj8CXCx1KCz0rWfqBZEGG73UWg5b8lJ0q5H21mvuqvxxbcSnWNEDahxrRlThykl2r3Mj2RGKrLs46aT37yZjAeNqeU310QjfMPUoFNeie0oqbqq4qXGYusoa3EFb6JK6rw/Qi/Y4j9yLlDdoy8AidJP9yVo0aIp9BCCYyQJwlnV68WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9esJl5CGtKNj6r/mDhrymTHLuTeTwW9vewxqkMS4tc=;
 b=dIab2Nc4kmYVMHqCFgxmr/jLNgNnB086hpO0kPhRb0hj4qdf+aDwZ5fUa2VkYuaqTik07NxwWgG2vkskST/XglkwJwWjOfIMoGeBq02siubSCSi0mkmFNh33lEKhA3mb7luhGf8tchiJrkNkNmYWimhqfht6E9OQgBUX8OEcVCG0krrJzIdAcS+rfJLZKyQvegK7U8f26T4MLJVsTBxLJS2B0WrfCW3DDmHPIrniuac3tXUPv1GTF7ixwhLE4GhFzDw6AWqd6aNlkPf7XgmRkgGld65ETcDoj9I25AMj+oC5lB2cUtMNejrsT+CMMWMxSh+eVgbY8fe6mP+PvOuHrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH8PR03MB8297.namprd03.prod.outlook.com (2603:10b6:610:2ba::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 08:31:49 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 08:31:49 +0000
Message-ID: <c9bbd137-0416-4ba5-87ac-8cbe5de15e48@altera.com>
Date: Fri, 17 Apr 2026 16:31:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: socfpga: Setting the image magic value to romcode
 initswstate register
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
References: <20260325054411.13071-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260325054411.13071-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CH8PR03MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: f390b8d2-5114-4374-6bd2-08de9c5bc4a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wlqRO63iqYE+HumCjAAqWrlyOuFJ587hUAAo3TZf9rHTHBRJgSpnLuKyRC3VXaiaKJUjAxXcb6VsDE5SydXOjieXyEr1GtoWCNoh7jVCtl/8/wRlwXdGF4IMLa1SgCfAoECgJT1ym67Ez/vm9V9sMq9wCmDlgGYe4MwRt+URU+cjd7Qj92Npq4LERenv2fuv6mOfP66+/gGy+czTMVM8IzGPOpETNWaWVeRx1S7FT8pxRSjD4Nwac9GIIhxTAe6ysXzFOAwcjH9sDTnrVc6uStPxPI2JEivVnzBZ3LtoIs6NW5eRS8VHO6dzxAav/MQNTwQmd/Zi9AHQe4K/6mE/rZGYaZbpu3fQ2lzrcIfNXiYFdRWeVv3rDVI1qjfgnLBGrEaZPzIKCeoMWSgrSt0prVLhvqoZ87DdT47KtZyT74KbUNeCRi/JxLax5iV7P43iZKcUl/tJgtBeDCYe5Bsr9CLQk4xqclsxqecOs/fCRn2KZ9FHKWl7xf+x6g3uad4yRONrHoB5n616pGB/iGcIedjjRWVeS4qyyAdIknwHADs9xA9Io91QEvyX5ad9+y0vbP0EIw10PUOnVHhax46pMUl1OUI0d5CX6nTRB3ekYdFvzcIhEe5z/j8s9Jfl6ADaHlcy7vDD54QYEdWZbEeAaW4vM+ZBrILGhMZWAL5MPhwIP4D6QW9rDLXt3dGCWHJRf2pNXIk/uR1rxkbsKeW5Ycqjg9kj2QFx2PpoU/JS5cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3J1SjJlZ1RQdHBKRDdtekNSR3ZYOHYyYWZpYTBGMlVQT25jOEZhYWMyQk8x?=
 =?utf-8?B?ODhSanVZQUVGano4TE1aMWM3b0NIYjRFeWNPckFMRS9mZC9xZDkvZnJyRThC?=
 =?utf-8?B?dm8xY3NrZmxvUG5GM1ZYSFFxbHo5RHgxRDdHRGZxM09teWU0Y21vNjdHQmNl?=
 =?utf-8?B?Rm4zSnVkdWpVZ2ZtUllxUEovYTlrNjRrcHIva3dXVWlOVUJ5WnJvbDF1cFlw?=
 =?utf-8?B?d0l5OHp3K0xwVExRL0pxN0dhZEhWQ2VoK2hNQ1hvYjdhRGV4RFBIb2FDaXdn?=
 =?utf-8?B?NGlCWUQ5WU9TUml0cm4wNWx6SW45K1RLTWl1QjRiMkdHVUVRRWdSb2ZtVXRO?=
 =?utf-8?B?akJSQTZZazdiN08xOGFVcHMza2Jqb3oyS1lHNHdRQ2lPeldtYmlqSThTSTAr?=
 =?utf-8?B?eFBKeDVCcW9oVkJ3Tzk5TUFzSW5vTDRQVzNKRkltZkZnaHpBWmI0K3gyaTVj?=
 =?utf-8?B?cEU1Q1V3YU5ySWVsdHBoODlHUUZHTGpaOGJEMi80N0w4Q3M5a1pYcmNyaGRX?=
 =?utf-8?B?am11T3EwbEhuTndHdkFKbTlNdFQ5aE5scUpReGZrZThGbXIyVGpqVm0wTExy?=
 =?utf-8?B?VnVqNkpXQytsd0Q2UTlPbDFaU1ZFN0k4c3M5amNnMXVWSGZXSm9uYmlab2VS?=
 =?utf-8?B?bVpSRG9IYXdNUnZQeGh0R2hhWi9rUGkyOUZoWndCZlRFbHVUWGxCbFNBMVBC?=
 =?utf-8?B?UXRCS0F2SGNQMVZtUzc5QkVDNk5GNWd6YVB4OXoxamltOWgwb1VQNFRoSTZZ?=
 =?utf-8?B?bDJMWmp0TlF2VnAySTROY1Z4Z2gzTmRwUkRxQTIveDliUkN3YVR0Z3RkWlk5?=
 =?utf-8?B?d3pHZ0RHNjhkYjRidW9DVFZFaVllenpLZGxHbi84SFJFNktqV0V3bmFZbk9Y?=
 =?utf-8?B?VFBWN05jUHVQb0V4alpVcStGWVc4RTUyeHFhU1Z5OWV4eXRrYytkNzFOY0RL?=
 =?utf-8?B?dkZUK1Y4cEIwVlpVSlNxMFBWSmpFZ3JIU2t4SFBFOWVMUGpvbnZPS2lodkpC?=
 =?utf-8?B?Qks0UFJHN2gyTDBVYTlUU0dTZHNDaGQ2NURrd0ljWE9GWEt6VTkrNU9QMmtU?=
 =?utf-8?B?SUJpWFdSYkFUR3BheXF3UVVTbDFZbW93SUxRWUdQL01SUy9VbUxxNTVTWStS?=
 =?utf-8?B?Y0x3cVlMOXU1MGdMR3VoRHhmVGt6NThGMXgvSVdUQ3pPUHVSeThid2lVejZq?=
 =?utf-8?B?SzhJWitpSWNCeWRvYlNzMFRpNWg4N0lYZDNUR1VISllaNENGZzR2TzhYck1l?=
 =?utf-8?B?U094Q1kzRVZQZ1R4SjhLZ2dvcXZnQ3ozakFqLzhiK2NqcWZsYXVZdURIcTI1?=
 =?utf-8?B?YSsrYWNqQ2pTZkwzdURjejdueDQxMTdicm9ERDZnb25NSFZ3WVlFdHMxT0d0?=
 =?utf-8?B?TFRmU3JCdzM5ZU4rSUFsVThyU2Z1Z2tqRDdCR0FZWGp5bHVVaXh5WEhaZXow?=
 =?utf-8?B?Z0ZNTWJJUnIxV09IVlRFVjZieG50WnMrcVR3dlEwMk9BU0pITTJJM2FZYTdo?=
 =?utf-8?B?My9aSzk2cE5Rc0NTU0VhWVNhblZucG93YU53azgwNUNKMUV5Q2dBQ2Z5UjR6?=
 =?utf-8?B?eWl5TlQxNnlBelVwdDFtRndNOXNqVGV1NjIrYUVEcjZPUVJLdXAyTHRlUjZu?=
 =?utf-8?B?eFJsN0JBankyajd0MXZYeC9iR2xQdi9XOFVjQzVOM2hxMmd1K0EraElFR3Mx?=
 =?utf-8?B?cTYwOUd1UXlFZWFDSGIzSFpKb0ljRkxGYU9JZFVWeGVOKzZlZVo1VWI2Vzc4?=
 =?utf-8?B?L09MejRBK0NLYTJtbXhDY1RmWlNxcGZkdGdNdmZmWVdvK09ZNGJDaXRFVzJS?=
 =?utf-8?B?bmQ1S3N1Y24xN2NOZ1F2Nk9tQkx5dGROQ3loRzQ5WHNiek01eUxIS1dIdFh4?=
 =?utf-8?B?NlFKQUFaaTd5aUE2aW54T0Z0cmR1VmQ3WGg2R1JMNVlJS3pweHplVXBKOExw?=
 =?utf-8?B?TVBabjFIdlRoc1A4OEtzZ0tSalJsek9YRHJpMEl1K1M3UHdHODhlQThNUTdE?=
 =?utf-8?B?Z25rMXc5UE1ObXJ0bjBFVHRxVmRTWVlicExUZ3hMdG5UbUpUR0doYytSV3Qr?=
 =?utf-8?B?VUpmUWR4QW9rK1EybmoxdU1mRVNRaks2dFBVbk5yS1Fna01oKzd6NlBoY0dE?=
 =?utf-8?B?MEUzNnVWLzNKakY4V1BoNzJkQnlMcXhqTTNaanY3SGRTOFMzM084S1l4aWw2?=
 =?utf-8?B?d0RCWERqUThTQWxEVUpnMkk2MGRFRk56OWlEdzFLMnBYNXh5eDVyWkhncVJN?=
 =?utf-8?B?WWJvTW1SNXNFaDl1VFJEOTFpNUtuZTdVNEVNTGJyZ3A2ZExsUjcrU2JlM3lF?=
 =?utf-8?B?bkx6c1pOc0J0a0l5c2p0M09hOHpEMktwMWlEcFFqaHRieWdkM013VHpTYk5N?=
 =?utf-8?Q?5qZBICgWoS9SqWXI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f390b8d2-5114-4374-6bd2-08de9c5bc4a6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 08:31:49.3359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvAe9NiqVzMC3LHlz13OD0ONjm+rmpn3dlOclTI11MTZ43lMRmyWGFSb03YyVWHpXik6ctFCEkTeFN3KhQGRpDKFlmtpYN9HD6v2ApcV5HY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8297
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

On 25/3/2026 1:44 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> The romcode_initswstate register need to be set with FSBL_IMAGE_IS_VALID
> value if the current FSBL image is found valid, otherwise BootROM will
> look for next subsequent valid FSBL image when warm reset is triggered.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/include/mach/system_manager_arria10.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
> index 0afe63e647e..346db78aff2 100644
> --- a/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
> +++ b/arch/arm/mach-socfpga/include/mach/system_manager_arria10.h
> @@ -37,6 +37,8 @@
>   #define SYSMGR_A10_ISW_HANDOFF_BASE		0x230
>   #define SYSMGR_A10_ISW_HANDOFF_7		0x1c
>   
> +#define SYSMGR_A10_ROMCODE_INITSWSTATE		0x20C
> +
>   #define SYSMGR_SDMMC				SYSMGR_A10_SDMMC
>   
>   #define SYSMGR_SDMMC_SMPLSEL_SHIFT	4


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

