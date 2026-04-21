Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAD2F327CC
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 09:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3024C843C0;
	Tue, 21 Apr 2026 11:18:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rVNU931F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F733843FA; Tue, 21 Apr 2026 11:18:01 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47D148439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 11:17:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ar/l/3I6iNpjtkK72ekN3bBmcW1dLwBYGjCBWIwcfr7K2N1dugMqKE1bhwI97++7lpGkaqgz1Hyv+AtXPprBTh4H5W4WnyVT112CZi/zN1xVLl/QAzPuY6Y3upffjPlpH/4/yb5uqwNOoZrKw1bNp06GA3nIQrtdy8lJj8DcXmYwRQ/0TI24Pemy9Kez9yOSmQMPrqzl+cp1ROsOPCEpOuyRX61ryyBMBBkfjaCsgdJ4WHm6e31m/KGHV4AFdkDrXBE+3IwATW2bRbbhcDKfqaLqjprlyakr7s3Cma62+HgGqpPHQy5W8ad968raUM0YGAf854mQI84DWfK7ngWMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdzjnfzkxrRrubQ4/PNrQnYqCPG4rRxlwpKMQ7oRC68=;
 b=BZK4xDOKko0MGKIclG495xNr3CPx4p0p621Qfz+Whb/60ZccggqeagAQ/y3YPdF3/eCE/yBnk+7vmtsOIRfYEySzgb7O7v2D4HlDc/n5uqIQLmlc1Zu0QUiIOEaojxy3hM0WcPhLqvOohksHeqA5hd/ysP7pTyKps98/fXIeX97hLwlmV0WmfzNYNDOjxSGna9Vtylt75reuyjTTvNaPvq8mZkWlAwU83ZoVjxqkZ1O7ZFvwPoYwligVUBDo/mcF98grmrdW1Aj1J/VeXweuyoGTgha9nq8QtVltBxelLOIHMX0j4QBJm2Sr1hdFYupfEdWa7YXkiBdhNk92I+5TMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdzjnfzkxrRrubQ4/PNrQnYqCPG4rRxlwpKMQ7oRC68=;
 b=rVNU931F7aM/cVCx8RxghG1CeLwI7F4CWWSJYRbxdCzOHBizDT+5kWtEoPpmlCBbTXdGbGQGc9QDUeRfKIgYm9+7gCM9aJ3Bc3wR3j3ewKB8X93LVfyATOhh+3cza4kO9PFD3kQBKV0+gecBBSzykwL1iqRYkRED+0IcR4ofYYV7nkJKRhhrBJjwxcYsezb3f2kixsBSLcYE9yJTylAW7twnGvlQ5bkYBrfGpbZwPAaLTp7qJwJxZZ//O3hTOnlT+I7p/WO8kd3rJhHbdLUw+Tg/JBa4lx+Htd5NEg7cwD/NrVtAKLNWSLr0UlLMNQFHSox6bd05JZr0f3muRqwGYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SN7PR03MB7085.namprd03.prod.outlook.com (2603:10b6:806:353::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 09:17:54 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 09:17:54 +0000
Message-ID: <c895a993-b7d7-4951-a45e-14078e56f366@altera.com>
Date: Tue, 21 Apr 2026 17:17:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] spl: s10: Enhance watchdog support in SPL for
 Stratix 10
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260403022513.9446-1-alif.zakuan.yuslaimi@altera.com>
 <20260403022513.9446-10-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260403022513.9446-10-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SN7PR03MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: a08673fb-401c-4988-f733-08de9f86de52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: bojVMa4lIylfEP3tfBEdSj9XG7NNVYhefI75D1gtQj7f8Anwp9fVzb0qWEPVpIZywAbbgLFPShTg/muZsh9KjCsD1wCjiIP6vTxCM2XlWwBOkmD/qLUoS6KzQ4TtqxJvMKMLpT02ju0Y4MNfGfWpjvLp0LUtpDnVA6eAkGSXuXUzhhYh97fyhOm+k/wm9v+uEhW776D7cq06NL4jsWUTJ7lpb4lXrCKLegi3soar2eXxk2ButjDzaeepixTYvEVUPfIGKav4vchR5+Fx2j3U61g4EraEZG0PvA3A3P6VZjYVW9jt316BSEhLbIH3a6UR4rKdwzROyl63turznc5e2CJk+7y4EKEqKYOEOMus0wUD4ih+j//KnJq3zvcknPElgypUdYfqOPpb6wtj+5Vzd2fVs4DJYLiDtaGrABb6/qU9W/Yc/pZdK181e3rsFYLa+CMkPReG1/uMK2d8yrKhdDRaA5Q5LFq45CtqaayNxWs13KzjQMxbTQppEZUVAC/TcZ3bCyyt5Nl3DqQsbR0HOcScA+wL5D+JXqKfqy+y5SuN4b6Ogwi8FtgUoUFn5wFYJj3XWSC5uqCezKid4bUaqwt/PILvvSlD3l8AKawuGmCxTExlyQ/POTWTjvsPCOFXGvdLAW8QVNbbkzfMqMbmtdAxXpjAuKcn3uYZj4A3/KYJoOI6KABeMI3xPR/0Rp4tLwNHyBwWzgf9TpdVYVaN0NCEZ9v3mtbGPF3T9qeRf98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkkrSVFpeE90YUZlendUWUVGdTlCSUhGMHhqU0t6Mzhubm1IR2luazI1WW1Y?=
 =?utf-8?B?NmxkRmdYME9VaElVc2RkcFdUbXdyVC9YQ1hxdHU0MnNQNmJoSjZweStBUWYw?=
 =?utf-8?B?TUtWbnZhclVSL2Zlai9mZzJCZHZqN1BEWGhLZWxaZmVveWIvYVJnQ0hnWVVp?=
 =?utf-8?B?ZzYrd2F1RWdjL004ZVdDT1NpNC9hNUJZbzBPcVd2V3RwS3BKMmhLNGRENXJ0?=
 =?utf-8?B?WHFKT3BCNitDcU9VZzJyTFNvSkoxcGtPdWZrdnZ5ckMxSmNiY1FTbTh3UkZY?=
 =?utf-8?B?UEt0NERNRUFUL3oyTi8zVUhXcnVEK2ZEWVFrQ1pHdkRURFV3dk9yL2lZVkhM?=
 =?utf-8?B?aXZXeUpZQ2prNi9SSE50cm9QZkpKeEtoeURtNys0L29GR3NsVEtPMEtJeHdq?=
 =?utf-8?B?N2xaUFZBSmwvTVpqVk9VRlJrOEtZaHpTbVBLQWFIVEZlbWtXN0V1RmtaMDlt?=
 =?utf-8?B?NGJkclNadXdDeDVjdmRPZndPcU15ZjArRWs0bVg1dW5mZHBKZ0hvdGczUUxy?=
 =?utf-8?B?cDM2ZGxXNktvM1loblRnMm1Zb3lIb0E5WWFPMFlvNzllRER3MUpzbm80VDNM?=
 =?utf-8?B?VGFocjdXbDY4Y2cvaGx3M2I2Skc2RGM4S2s3UlZqYXNERndhKzBEUGs2OFR1?=
 =?utf-8?B?RUpxTWxGcXZtUUh2bGFZVzkyU1REOFpHcGFlTEtFWDRLdmRHeVpvcWFwWnNu?=
 =?utf-8?B?SkNuaExZTjM3Vjk1bnVsVnBjSVc5Z3ZYbDZ4d1lQUHpRMVlKSGV5ZTc3MkVx?=
 =?utf-8?B?bWNlWS9tdmhCN3JHUk5rQlRHRk1WZEJqTjNxektBb3FSUWowUkhrYlYvNm1h?=
 =?utf-8?B?aVR2WXBkWG1vOFg3MGNUMVdpSzNRQk0wWGd3eUkwbEREL3VGamhCOVFLajV4?=
 =?utf-8?B?WGlyRWM3RUd2TFgxWmNpa09uRlVPYk5QcE1raExJdGVVOGNWWEFvNDVkZUNR?=
 =?utf-8?B?UFpna2ExdG1mNTZRa0MzTUZRVHJJYmxta3gvSDBuOXlDSWViZXJHSGRsUjVh?=
 =?utf-8?B?ellNaDNtT0lpMjZHZCt0T2dBYUxCcElxdGNKVXlMek9YTVI2SzdybUxMOFQ1?=
 =?utf-8?B?RS90U1I5NS9zZG9ma3JmcjVBeXA1NDg2cW9NckpLSDkyNERrc0FJc09BbkZr?=
 =?utf-8?B?QUw1dmx0akwza3UxTE5nN0VtbFdqcnphQmYzb1o3VVlVL2NUVEo3SXd2Rmp5?=
 =?utf-8?B?SlZxci91M3ViOE85TzVvV2M3d3J3VE40UFZ1Y1VJajZnZTgvWWJSNm92QmtI?=
 =?utf-8?B?RHhEMzlpbHdSMjRTYzVJajRkUitQTEN1ZkVyRGtqalRHQzB1NWVXQlJxVEhS?=
 =?utf-8?B?T0hqNzNNTzZ4eEt6NStPaWN4clNUektoOHVNY2RJbzQxaWNpYUtRMjZhVHlO?=
 =?utf-8?B?VVY2QnZMMVNJMHZ6RXhHNi94QlBRYUxkdkk3bE1VbzVCeHJocHRuOC8xRFBZ?=
 =?utf-8?B?TWNTWnBMQUQ3c2FwRXQ5RkJaZ05mT1Z5OThORFFLY3ZSRDY1UzlUdmxjTTZy?=
 =?utf-8?B?SmljUmlIcHVuVTQvMWRBZlcrLzFmWk85Z0o2ajRIY253alcyMENLeVV6eWJK?=
 =?utf-8?B?ckVvWkNBZXNtNzUyYXNQSjlvUUIxblp6dXhFYWl3KzNiOVh4RUNPa0VtOFpu?=
 =?utf-8?B?aDZKOHhMY2FnczFHby9EVnVLOVZRSHZsQXBVZzhCRUUwb1h2ZDY5YitsMFRG?=
 =?utf-8?B?Z0RvS3VUcS9jQ3E3T2ZKVjFjMDFhOUJ0cGk0a2dhVjJnRWVibEozZ2NHTnE3?=
 =?utf-8?B?QjVtRVk1QnR5QjRFVUFDTFFCbDUxOU45UW9DNWtiVk5zTFZTRGVnNnc0MXhp?=
 =?utf-8?B?RllDMGxVdGZFRi8rL1pMTnVYZHBnTVF6dTB0cmN0WTdDdXFQR3kwOGxOdzBl?=
 =?utf-8?B?Z3dMVHZDaEQ5TUhxdEE4RmtLSlNvTC9ORXpGRmw5dEk3SjgvWVRlaWhnbEV5?=
 =?utf-8?B?M3dGd3pTdXhXZHZWLzkzY1V4NEIxeHJHY2M1SjlISThpcmpKc3NVM0xPZkhZ?=
 =?utf-8?B?Qm9wVldCdjJNRHV5R3Q4eVdvLzJOejNKTUFmdklCZGNsRGEwVStFQzZYL042?=
 =?utf-8?B?ZitZZ1I0dk8vb2hhc25VV0p1TWxSN1lqOVFYWjhtaHg2WGNieUkvR291a0s1?=
 =?utf-8?B?SHZtMGt1czFzQ0hSelhEWlpwUEFKM29rZzF6VE1aVytXTitKTkJ1YlJTb2xn?=
 =?utf-8?B?TUpKMTlZVmplOUxIYUJ1Nmc4K2ZDdmtJcDBHOVdTRHNybnpJamFiSHNwR3Rp?=
 =?utf-8?B?YzBZVy83cHFFb2RhU3JycE41TllUMnN5d1hYTnNHbmNMa1p5SzFRZmUzdnQr?=
 =?utf-8?B?cEw5Rkwzb004WkFhZTE3Umd5N1hQQWZOS01vb014WWdJM1dlajlHYklFR3I4?=
 =?utf-8?Q?Oy3lwZvWMIIcg3YE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08673fb-401c-4988-f733-08de9f86de52
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 09:17:54.1287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6emttNd7ldN5HYkeE5ExD5vdy67i+3serYxUdQDUxSByAeFa3RiNYHgJhh0/YYDLvdSbc6pkCwNuiKSYIbcw0nMBb4OnQhkin+A8OtF44E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7085
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

Hi Alif,


On 3/4/2026 10:25 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Watchdog needs to be fully executed in the onchip ram. Enabling watchdog
> before initializing other components such as DDR in Stratix10 SPL
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   arch/arm/mach-socfpga/spl_s10.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
> index ace029557f3..588dca4fcd3 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -18,7 +18,7 @@
>   #include <asm/arch/misc.h>
>   #include <asm/arch/reset_manager.h>
>   #include <asm/arch/system_manager.h>
> -#include <watchdog.h>
> +#include <wdt.h>
>   #include <dm/uclass.h>
>   
>   u32 reset_flag(void)
> @@ -54,13 +54,6 @@ void board_init_f(ulong dummy)
>   	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
>   	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
>   
> -#ifdef CONFIG_HW_WATCHDOG
> -	/* Enable watchdog before initializing the HW */
> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
> -	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
> -	hw_watchdog_init();
> -#endif
> -
>   	/* ensure all processors are not released prior Linux boot */
>   	writeq(0, CPU_RELEASE_ADDR);
>   
> @@ -80,6 +73,13 @@ void board_init_f(ulong dummy)
>   		hang();
>   	}
>   
> +	/*
> +	 * Enable watchdog as early as possible before initializing other
> +	 * component.
> +	 */
> +	if (CONFIG_IS_ENABLED(WDT))
> +		initr_watchdog();


Either move initr_watchdog() before the ALTERA_SDRAM block to match the 
stated intent ("before DDR"),

or update the commit message to accurately describe where it is placed 
and why.


Best regards,

Tien Fong

