Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1B4CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 06:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A46A984683;
	Tue,  5 May 2026 08:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="M6HG1Rcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9063E84687; Tue,  5 May 2026 08:17:34 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BA358467E
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 08:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7W2wtcod2MTdXKUmlzaxhfEpPDobwzITSXSpqN+BI4Rih6NrCP9OGRLvEv5ApSXbXPEZTffODpJVpfHOTOeZFeMkEcoQit8CYifB1qErcB7bxPaSAnpxpeNwXKmZlY5SUUeMx6dT6+R0EoXSMV0S3aO6dA395fdTJ2ulYvF2yvGWI1lGW7reFZrS6i7znzQ1C20LT97ydKpt1RwJsSHX5TofoLaefbCH/UNeB7psWfSBQbn1ly1+26PanoZFVGMFc0ARCux4Tl4vgMPA6l7ISNVvKTA0va1bXPkn/LmYHYwOClAdVD55n9kAVd1tZ0seQaDPQT7A657vbrOYRwhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF5H+d/z57ctnPbdYHcxSiB4EARIwyaI4o6EZGVt3ms=;
 b=I+S5NrQkt8QGApRhUbdXkjYE1yzDOmQdZPXjLb2ZSaeoKemu4Dr2qY4Rmxz+t+rV90VingnovspI2ERoEavb9K8j9xX77qgfZHZjJBbaH3NzbRcwhsXbq3PQKQOle6dj4MjGEtbtiVgc/47AdxI9oMNcHfHgaRqYfgiXDJYM0df0X7OXCSppxJowucgCViQvZtxcbIvCvg5+vMgCyGfKDKscUUDjB6oNko5Jm/Gk/llZNSi9+s5xSokQlDHjyCu8g4hUU/0ezMC4H63bCrAmCk55VcWie5X1o1QD9d/x59sltpcQKCrmdWHlTIP6fcvC+lurkZURv9ppeuZsbhJDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF5H+d/z57ctnPbdYHcxSiB4EARIwyaI4o6EZGVt3ms=;
 b=M6HG1RcqgRvv4acQ/3wbr+PiUeixiUKP/Pffdau7kHDap/fClpv6MCEyeNCh88jG7OFqTlvi7dYsHLgFydFMV9+y/4jfWnc7TrXuRv/hFjjiEEvX0niNwAdImg+rbjlI7554IWdLsP80Ss68EZDhuqCwH3ZE/DWZYxUWs//+c7GNrrxot0G0/JrQE4Zd3C0/NSlxDN2Qk3dkmLE3vSmpN+4t328wJQ46E8ZUEgRmTnX72GsW624FGFwzZlw9zNfotGXt8Ejsh9NMG7zFR8q4cBKq3QgPomTE00500Znt3Er3kHY5486tyW3KabCQEFq0yCAwEG6RkR+w8TwMd823hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB5551.namprd03.prod.outlook.com (2603:10b6:a03:279::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 06:17:28 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 06:17:27 +0000
Message-ID: <054e0e7f-1f32-4370-a753-5193c8511509@altera.com>
Date: Tue, 5 May 2026 14:17:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ddr: altera: gen5: Add DRAM size checking
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
References: <20260428033230.7777-1-alif.zakuan.yuslaimi@altera.com>
 <20260428033230.7777-3-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428033230.7777-3-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SJ0PR03MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: 603d07f4-8563-4306-e0f7-08deaa6dfb24
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: rTIWLwKkC9lJzIwc0Lq9u80J3sivMW22aLUwBv67j9JTPvrGHk43Z4JdgIcEJD9HCM1MaAkRYqqxrVW4rtpPZlO3kD2VJ47PDJjhK+62Ztz2YAYCdW52xVfzNnUfi9z4/AKZl6ygdKbZgyj0nv6kYgoJsF9WZa4tEqmjQ167ENyvxc0rF8tGXtWPzG24XnAb7Merf4RTnmhHtqCK3OO+23fGsLa16UuxjQFp9IMAjdk/uYWbiIJCR9TrJWPVAUw+Df2As/4nZFOXZ6mnuMX8PC0jfLo4CUBQ6TQoYp1HfpvfeXqS987ReOtf4+f6pmx8aZUTX473C/cmHdqqlSmB06sovSYikCMd1rY7zQK0ivkqB4TbCNte7WWgCFvw6nmGyu0ov1oVwp9tupPnMdWn6hBYOe7QjszgLCuQ9NgZOtD2R/tZtik+BU8Qy4k3rmpxYoaUdE7I3jJ6QGdJxQ+WpMMJ/Nn6yDTOKliEIsieWL6VEWq4K1xQ5JFB7vIMeJwds5+hdPORaoBLG9sKypzv1TS2SMqWz4UlHuWntYA0iVRo4xSntaAb/tVlCpG+9fkE6DoYGBhWO5V+GBHYc2UX3xwF8R92DG8N171NnFbMbBvHMJw+aKSNNiVEMqGjtQpWupBWSQdNdj7NyYhsM7w5EkbgNpkiexRhfTOtPSYbi8eut44xPwXZg604MLE08Ato
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnlxLzMxR3J5WlFWaHpHWUFsTzBSZWFaT0kwbmlkRjM5c2JwZ3lXYXExU29D?=
 =?utf-8?B?QSttblRsQmRrbVBCZkJlb2RwL0hpOXhveDEzUWJyZEtYMndwTTlTcFNndWYv?=
 =?utf-8?B?eiszRWNhdHZGTDE0aEUxY3c4V3dkQmN0SzhDdEl3RzlrWDlXZEpIWmQ4T0F3?=
 =?utf-8?B?MXExaGlINUh6Y0pYemM3NnoxdEdTUC9PaW12SDhyNG1pTW1pYUpKVjlQZEtT?=
 =?utf-8?B?VDVDOEtCM0NyZU9MbFhyaWtDYmRBY1RkRXNxVU93NXlqWlM1ajFXb3c2RGRi?=
 =?utf-8?B?Q1B3TEtsMXV2a3BhbXY4RUV0VVlmNHF4TjFNVWFtR09saGdKV0tvdmhoQWE3?=
 =?utf-8?B?Q2doV2h1T0VkblFLelE3aUtadGtXbUdOaUovSjlrKzVBdDBwRFM2N1QyNDM5?=
 =?utf-8?B?bDZyOVpyM0crU1hhNmVoN0gwbU50b3RidjR5aFd6WDlTeU80K3ZOUDhlYUgz?=
 =?utf-8?B?ajR1ZXowNEhhWWhEV0tLdFR2Z3IyZWRyM0l3Vjl0M1NxNXhDUFR4eVkzYTM5?=
 =?utf-8?B?QWhlNVI2aFhVbC8zemJtWTI0bG1acGVhRXFxMkg0ZzZrVjM0NWJFQUpNN2RM?=
 =?utf-8?B?YVIraWoxRzRrVWd1ek9DRFdvVHJrWEVQdEljcXpaemswUFJDeWV4eWpBVGsy?=
 =?utf-8?B?eVFnWDdLRHhMcVRjdkQ0SnJyT2dWVWFuTGl5K1BCS3lWWGNuYTFHayt3TlFt?=
 =?utf-8?B?dyt0Vjc3RFVjRFlCczdLYXRYU3AveTR4ZVhlSk5WRjZvanJtQm9qcy9hSlhH?=
 =?utf-8?B?dmZkUWgra2s3SjFOdmpxMmpwT1hSb3dpR0RtcDFDdU5Wdk0yeVN4a1JLYXgw?=
 =?utf-8?B?aEFMTHJlc0pzSVM2T2Y2YnM0YzlhdGtRQm90ZURNdm83QmVSMEl6eThMWFVz?=
 =?utf-8?B?ZEtTN3AyaWhLQ2poTDUydmtpanFoQXF6a3JZYzFraG9KMWxGVFUzMnBRMUU3?=
 =?utf-8?B?ZUhXcFY4MEFLRWY1WG9PZFk5M1VEWUlGOUQ5cU83U2ZtZFlGQ1h5UWJZWEdt?=
 =?utf-8?B?T3Y3SHBQZHVNMjl2QjVFTzlZS0hyNkhQQnZLbEE1Z0ExVFJ4ZkdMZEs0S1Rm?=
 =?utf-8?B?YVR5UTBCQmFDM3NuZEdMK3pQem4vN3prRjFPKzVOZDUwRng1YTAxSXBGVDNF?=
 =?utf-8?B?VW9TQ2RsSmZ4MXc1Vnk2NTZDNnVqd1ZhUk1jVDQvQkF4L2FoQWtSSWE1emtG?=
 =?utf-8?B?dnIwZXVjM3dhSXIvZUtRSERnelZqemIyRCtIeVhTMHVvY3pPT3ozR2Fpbmc3?=
 =?utf-8?B?dXBzY0NKekJ4K1lvdFRJNGJ0NTZIUHAzMFdRZkZ6SXBJNGN2VDZmYzNhMkxq?=
 =?utf-8?B?T0RnZWRBZ1hWRFBkbFdLVXlnZnYwS3pTRWNDMzh5QTRpOWJwOEVBckNnYW84?=
 =?utf-8?B?aUtQdmwwb2hRZDhTOGRlNDhqZDRHTnVwcFZNWFdPcjdlWmNnRmd6MkF0TVl3?=
 =?utf-8?B?Vlpuc3JwelJYaW8yczd5KzdQOXllbFFrb0kwd1ZlZjI0aVJWVWxaUi9OL3o1?=
 =?utf-8?B?RWVXU0NOcFgxbnNvUFY2S09nRnVSTHF1dUZrb0V0dG5xMURJa0dOaVhHeUxz?=
 =?utf-8?B?MG0wcUFmYlNCb0JwVUF5V3B2cTFSdUhRYTF1UmoydkpOdnBQRFV1RTVKWWc0?=
 =?utf-8?B?V1FQQ1E4aXd1U2pSeXZiRVBzdGxIb0FsMFNSY0pwZFdnYlVBN1pjKzhxWllZ?=
 =?utf-8?B?azFjSUtvMm9CSGpaaW1tWWg1cnNoSytYOEhBK2dyb3NlTTNxOFAvR2VMS28w?=
 =?utf-8?B?cmF4UkF2SWJMa2YvN1hUdGhxdklWWW5JYk5VN1lrKzFDRzk0VmtRRmhMaTRh?=
 =?utf-8?B?Vy9lK3JJL2wwWFdSR25uL1ZDUTFMc016eTh5YTMwcXk2aE9YbU9SUzRpbEZ0?=
 =?utf-8?B?RFNiMXpRT2ZWdmh3M1VvZWNHQ2psTHZyUE0rSTREOHh0czcxVThGTGluVVdF?=
 =?utf-8?B?SnltNk5UeHUxeUxSam1iWHZ1clpONy81Q25TUWx2Yjc0RFY5YXNHTnp4NlN0?=
 =?utf-8?B?TE5LWUNCWEkrR3dhRllCR3JpT2hOd1ZuK3llbGRHMElUK2dleHJ4SEVaNHJl?=
 =?utf-8?B?Zm1uOGxtc0RzbGlnNGJ2dDlITm1YN1FpRzcya2JhSlV1NzZienZLVkNUbWxl?=
 =?utf-8?B?cUF1MGlaTkNPZ0ZlYnhzUm1XR1YrcnBSNlpxMVJVMUJ2OUYvblJwd1J3SXBB?=
 =?utf-8?B?YmNBNkozQkNGOHNSaVVzZUplbFljUDF6bDcvRE8vZEFDR3g5ZU1qYTZhV1pm?=
 =?utf-8?B?ZHlHOFFtdW1malNRWUxFRXpzU2QxZ25qV3gxM3ZWcFFmSHpQNWlHSGNHV2N6?=
 =?utf-8?B?SW1SbzFIQlZ0RGNjdUNTLzBjK2VET0lmVzNEVjJCMkRrZXJIVmdWTUJSZFRM?=
 =?utf-8?Q?gOP5vvQmaj/9UzTw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603d07f4-8563-4306-e0f7-08deaa6dfb24
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 06:17:27.6850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5txSeGWtEYJElXSUy8amEGU7u29p/FhnejFaL66cO4QlGSWVEpbaqKkn17dRbn3M4rVLMsRlgxpcMdrclBrZql43K+aijHzazkAwb43B7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5551
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


On 28/4/2026 11:32 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Add DRAM size checking compare between size from device tree and actual
> hardware.
>
> Trigger hang if DRAM size from device tree is greater than actual hardware.
> Display warning message if DRAM size mismatch between device tree and
> actual hardware.
>
> get_ram_size() uses size from device tree. So, it has consistency with
> other device families.
>
> New Kconfig is introduced to enable this implementation only on the default
> CycloneV board as this will increase the SPL size which will exceed some
> Gen5 devices' SPL size limit.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   arch/arm/mach-socfpga/Kconfig   |  9 +++++++++
>   drivers/ddr/altera/sdram_gen5.c | 27 +++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index e2fdd6bb30f..830585a72cc 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -6,6 +6,12 @@ config ERR_PTR_OFFSET
>   config NR_DRAM_BANKS
>   	default 1
>   
> +config SOCFPGA_DRAM_SIZE_CHECK
> +	bool "Enable DRAM size checking for safety"
> +	help
> +	 Compares device tree DRAM size with actual hardware. Hangs on
> +	 oversized claim.
> +
>   config SOCFPGA_SECURE_VAB_AUTH
>   	bool "Enable boot image authentication with Secure Device Manager"
>   	depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
> @@ -111,6 +117,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>   config ARCH_SOCFPGA_CYCLONE5
>   	bool
>   	select ARCH_SOCFPGA_GEN5
> +	select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
> +	  && !TARGET_SOCFPGA_EBV_SOCRATES && \
> +	  !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>   
>   config ARCH_SOCFPGA_GEN5
>   	bool
> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
> index 3c79bb11802..1c3c70ea8ae 100644
> --- a/drivers/ddr/altera/sdram_gen5.c
> +++ b/drivers/ddr/altera/sdram_gen5.c
> @@ -5,6 +5,7 @@
>   #include <dm.h>
>   #include <errno.h>
>   #include <div64.h>
> +#include <hang.h>
>   #include <init.h>
>   #include <log.h>
>   #include <ram.h>
> @@ -15,6 +16,7 @@
>   #include <asm/arch/sdram.h>
>   #include <asm/arch/system_manager.h>
>   #include <asm/bitops.h>
> +#include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
>   
> @@ -22,6 +24,8 @@
>   
>   #ifdef CONFIG_XPL_BUILD
>   
> +DECLARE_GLOBAL_DATA_PTR;
> +
>   struct altera_gen5_sdram_priv {
>   	struct ram_info info;
>   };
> @@ -604,8 +608,31 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	sdram_size = sdram_calculate_size(sdr_ctrl);
>   	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +	/* setup the dram info within bd */
> +	dram_init_banksize();
> +
> +	if (sdram_size != gd->bd->bi_dram[0].size) {


Building socfpga_cyclone5_defconfig with only patch 2 applied produces a 
binary that NULL-dereferences in the RAM probe. Not bisect-safe.


Fix: Move the bdata declaration and gd->bd = &bdata assignment from 
patch 3 spl_gen5.c into patch 2, making patch 2 self-contained.

Best regards,

Tien Fong

