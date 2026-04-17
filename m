Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC05F43699
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8673B843AF;
	Fri, 17 Apr 2026 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZhrMtsDr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SJ/r0phq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED2AD841D5; Fri, 17 Apr 2026 06:23:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE9A83BC8
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 06:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H0fVKS065708
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2r0QLp+znJWbrfYtVkWnJ/9enp7z4yk6r3oZqEOmTwI=; b=ZhrMtsDrzV4wo7N2
 uMIr58uxBHfkaBlDuapQNV1yHc5Sy1L5LxPUfRExnMtBee4V8C7fBdV1zCwAnjHR
 YqEgIAzgwX1GTZvXlbMdDtNAK8oGjRNLUaUJdc/2DlUk/SfIZ7FzaWB//TMBQzTQ
 d1P4Yej0yvEI9hLEtLhcL9CY4aASgrVmhFRZIqo6qC+ZTt6iU6GVwhj8a7TKXlGt
 zTUELtsFdotcMMUDIRaW3oeLM3GhEmtSF2IDNd1PJkOAHdlma1yVT44j4BMvNiXg
 riKYINp/6zTxjF8n1shZna0f34AlfHL1mj91EPlmVgLVar5as0Kqt8NhEaZmt6Yz
 McdRZA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk3af20q3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 04:23:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35845fcf0f5so392841a91.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 21:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776399781; x=1777004581; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2r0QLp+znJWbrfYtVkWnJ/9enp7z4yk6r3oZqEOmTwI=;
 b=SJ/r0phq3j2M8s4O25g9kJqFCdICfkqbDim+ceZRg7I6LBVPOvsb4xqVZnMwZaPc3K
 h3Kyymb5uKKqkxxkCbRmLxNVut4TUSlK3Q5ynuY98gPi5gpI6kvVivz0EA1IuCPcN9Tn
 L6nPA5JHBFDPi0wcIyguYyH9An/bRbkxVmTVxb31Kp83/JvO+/5kYKrMv9KIcb4Af1Xr
 00+uE7pWLKruGEeWeeEPQ4SUUTlfN97vjcjC8oGUMr7pDeIHXgLURkiL7XwsTFrjepS/
 Sju4TAjo6jp1RI5RvfMydw3Mmib35o+4VED9yUfYxQ6Ks2XOgWxthsW1YF3Tmy/uL3WM
 OIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776399781; x=1777004581;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2r0QLp+znJWbrfYtVkWnJ/9enp7z4yk6r3oZqEOmTwI=;
 b=Y2yCPLtxTkUtEAMCdAaw7pUz228cGAPYygYi72Y6ook9gCKi8F72IChq7Krcq9X2bu
 G0kTti0xRFThYgVXWvVnZ2mjsXMo+qWjpasoUzNbKtC5LqfV5q4dRCob5HSjY0cOPAHN
 Tf8CHL6MoK1dYYHqRQcmSTniRlSPp3wh4tLNaRVjKaVmngcMq8IMfU/YWZs2Z2sZhviV
 mHGbkyAivrQHdWmMblqTtXCeTeWAyMyHy0CXESqZON6nmfyaMpLQPzqS9UQVcUZEyvwa
 hKDyr8KpmY2jrcGLWbk2YU0+zYWlDgG4CUqhTnVOXPvYUfDpixNa9GKw91bh0S/r9RVi
 YsLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UCk+E+pEoIZtJdBH/p5jAf9A6ZtqEyfG65jkm/WEdMpZICoP9PQwKva+C6vppn82jQ068+GA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy44gNlIgi6wC2yyaJLixxW1g73tUY2+rSQM7VmJa+9Z0gFCddr
 RJaHMiEMRZ0zoBsP4WiqbiqyUUDVxb1LpcybkaKLwJAgQFCVP/3sZ2H7wh3regP9brjPIb0iAX3
 a2stXOXZ8iOseFotwZJbM62cy3jAOTWVp+ugKXAIq/2So6HyE/a7j0z1b
X-Gm-Gg: AeBDieuNLr2FNxzLcbHAh1hHRuB4YuA29KwKKz3phhEABEjTptE5u7cYSqo71/aOQb6
 DE2EzJmQIC8s/DVe1Z15kBXutnwtKpVmDqWfZ/4mbVUdDzbJHDMPxeWw5PBxVaZLJdlQrQJN8hg
 ZOMzABoGxTNWBCIToc9kZQBph994/XyAGEf6vLKKTrESYPtxRDnbmsZqQJyQtX5lWqn5qBL30HA
 ODnYZj0J44EfsTGAKulQ7f5x/ctQRJWTVDg5RY8+u5R4FrPh5En/YzV37Crtif8NqqleVNVyMDX
 81krhPzJOvaz4GSUJLntCjwQlS4gPiX8LGEVEr/XuGS6oo3scVsa3WSpL2E25wEXnkkrKt5WJns
 Izjp5ZoK3SLptnHuPyWgz2bgJaawk64OJc0azW77R1JgA6lwtHVbuTfIn/i816kfqapQ=
X-Received: by 2002:a17:90b:52cf:b0:35f:b9f1:fded with SMTP id
 98e67ed59e1d1-361402edcc2mr837353a91.12.1776399780386; 
 Thu, 16 Apr 2026 21:23:00 -0700 (PDT)
X-Received: by 2002:a17:90b:52cf:b0:35f:b9f1:fded with SMTP id
 98e67ed59e1d1-361402edcc2mr837303a91.12.1776399779688; 
 Thu, 16 Apr 2026 21:22:59 -0700 (PDT)
Received: from [192.168.0.7] ([183.82.26.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36140fc5946sm743685a91.3.2026.04.16.21.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 21:22:59 -0700 (PDT)
Message-ID: <47e34f39-e247-4d37-9fb2-2d6154615fc4@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 09:52:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/10] mach-snapdragon: Add initial support for IPQ5210
 SPL
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, tingting.meng@altera.com,
 anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, mkorpershoek@kernel.org, h-salunke@ti.com,
 alchark@gmail.com, dario.binacchi@amarulasolutions.com, ye.li@nxp.com,
 andre.przywara@arm.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, adrian@mainlining.org,
 n-francis@ti.com, wens@kernel.org, jamie.gibbons@microchip.com,
 justin@tidylabs.net, ycliang@andestech.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 richard.genoud@bootlin.com, michael@amarulasolutions.com,
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20260416053928.2834699-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260416053928.2834699-7-varadarajan.narayanan@oss.qualcomm.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20260416053928.2834699-7-varadarajan.narayanan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA0MCBTYWx0ZWRfX6Hg28A/Fbi0A
 DcFrA7xZLEUd3Cv9LKkDkohlwXsajnqkNBcT7MFV1AUxWDjp5xaSmOolxcrHlAB2h9MWr9NAxQX
 IuTpcxtqorGFwrfIeUQ3US22zLuYONc7xRHQsSPXo77a1qOrknCb9Tx1q6ykLyTSRPiAVGAplpr
 p8lHeF9QvjbXoLttq05PLg56y/dJcjq884fkTDQTCk6KfECU4AOppImhQmCodnE/b7SyAuCAbZ5
 xQX7+veMLZqQKg3DsvPbtORfxtkNf8bBrQCaa2qwEpOPELwA2uuOt7UkWjoOCIPURUw0x8iez9J
 +i01v0jfSq7jkxRu3sEYG5nyXocxn4ZB8Gj5C71BnLXVmkMEgS72JJNmhfDuL3ZSdhKydwu6Qe3
 0UYaWcCSksHshWhuZOM1nvSaM4vOuX8PXQQ1QgdguzD/rntYR79Kb4FkE1TMTBxMEUwAvg33LW9
 nuJkwkHWOf/eqbgjCgA==
X-Proofpoint-ORIG-GUID: gLtMJAELDG1cI1o9gz5PFIoQP_E6QkXV
X-Proofpoint-GUID: gLtMJAELDG1cI1o9gz5PFIoQP_E6QkXV
X-Authority-Analysis: v=2.4 cv=DfInbPtW c=1 sm=1 tr=0 ts=69e1b5a5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9hs5VSNKt7knCDU1iup7yQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=XOR_1qRmtGoOTDvSA80A:9
 a=O6mRQTBPUV7GYTyk:21 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170040
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

On 4/16/2026 11:09 AM, Varadarajan Narayanan wrote:
> Add basic SPL infrastructure for IPQ5210 SoC. This handles basic serial
> console init, identifying the boot media, loading the additional
> firmware binaries to setup DDR, TFA and eventually jump to U-Boot.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
> v3: Move SMEM updates to separate patch
>      Loop upto if_tbl->num_entries instead of MAX_ENTRIES
>      Remove invalid 'if (!fit)' check
>      Return failure if qclib_post_process_from_spl fails
>
> v2: Remove couple of unused local variables
> ---
>   arch/arm/Kconfig                  |   5 +-
>   arch/arm/mach-snapdragon/Makefile |   3 +
>   arch/arm/mach-snapdragon/spl.c    | 640 ++++++++++++++++++++++++++++++
>   3 files changed, 646 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/mach-snapdragon/spl.c
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 03416c55265..54fa4cb2dac 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1135,12 +1135,13 @@ config ARCH_SNAPDRAGON
>   	select SPMI
>   	select BOARD_LATE_INIT
>   	select OF_BOARD
> -	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
> -	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
> +	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
> +	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK && !SPL
>   	select SYSRESET
>   	select SYSRESET_PSCI
>   	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>   	select MMU_PGPROT
> +	select SUPPORT_SPL
>   	imply OF_UPSTREAM
>   	imply CMD_DM
>   	imply DM_USB_GADGET
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 343e825c6fd..70a2ce585f2 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -2,6 +2,9 @@
>   #
>   # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>   
> +ifndef CONFIG_XPL_BUILD
>   obj-y += board.o
>   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
>   obj-$(CONFIG_OF_LIVE) += of_fixup.o
> +endif
> +obj-$(CONFIG_SPL_BUILD) += spl.o
> diff --git a/arch/arm/mach-snapdragon/spl.c b/arch/arm/mach-snapdragon/spl.c
> new file mode 100644
> index 00000000000..8cc28bbee82
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/spl.c
> @@ -0,0 +1,640 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +#include <hang.h>
> +#include <cpu_func.h>
> +#include <init.h>
> +#include <image.h>
> +#include <spl.h>
> +#include <spl_load.h>
> +#include <asm/io.h>
> +#include <asm/system.h>
> +#include <asm/sections.h>
> +#include <atf_common.h>
> +#include <linux/err.h>
> +#include <dm/device-internal.h>
> +#include <part.h>
> +#include <blk.h>
> +#include <dm/uclass.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#define QCOM_SPL_TCSR_REG_ADDR		0x195c100
> +#define QCOM_SPL_DLOAD_MASK		BIT(4)
> +#define QCOM_SPL_DLOAD_SHFT		0x4
> +
> +#define QCOM_SPL_IS_DLOAD_BIT_SET	((readl(QCOM_SPL_TCSR_REG_ADDR) & \
> +					QCOM_SPL_DLOAD_MASK) >> \
> +					QCOM_SPL_DLOAD_SHFT)
> +
> +#define QCOM_SPL_FIT_IMG_PARTITION	"0:BOOTLDR"
> +
> +#define MAGIC_KEY			"QCLIB_CB"
> +#define MAX_ENTRIES			0xF
> +#define IF_TABLE_VERSION		0x1
> +#define QCCONFIG			"qc_config"
> +#define QCSDI				"qcsdi"
> +
> +/**
> + * struct interface_table_entry - Meta data for blobs in QCLIB interface
> + * @entry_name:	Name of the data blob (e.g., "dcb_settings").
> + * @address:	Address of the data blob.
> + * @size:	Size of the data blob.
> + * @attributes:	Attributes for the blob (e.g., save to storage).
> + */
> +struct interface_table_entry {
> +	char entry_name[24];
> +	u64 address;
> +	u32 size;
> +	u32 attributes;
> +};
> +
> +/**
> + * struct interface_table - QCLIB Interface table header
> + * @magic_key:		Magic key for validation ("QCLIB_CB").
> + * @version:		Interface table version.
> + * @num_entries:	Number of valid entries.
> + * @max_entries:	Maximum allowable entries.
> + * @global_attributes:	Flags for global attributes (e.g., SDI path).
> + * @reserved1:		Reserved for future use.
> + * @reserved2:		Reserved for future use.
> + * @if_table_entries:	Array of interface table entries.
> + */
> +struct interface_table {
> +	char magic_key[8];
> +	u32 version;
> +	u32 num_entries;
> +	u32 max_entries;
> +	u32 global_attributes;
> +	u32 reserved1;
> +	u32 reserved2;
> +	struct interface_table_entry if_table_entries[MAX_ENTRIES];
> +};
> +
> +/**
> + * qcom_spl_jump_img_entry_t - Type definition for image entry point functions.
> + * @arg1:	First argument passed to the entry point.
> + * @arg2:	Second argument passed to the entry point.
> + */
> +typedef void (*qcom_spl_jump_img_entry_t)(void *arg1, void *arg2);
> +
> +/*
> + * Global QCSDI address populated by qclib_post_process_from_spl
> + * Placed in .data section to ensure it persists
> + */
> +static u64 g_qcsdi_address __section(".data");
> +
> +/**
> + * lowlevel_init() - Early low-level initialization.
> + *
> + * This function performs very early hardware initialization,
> + * specifically disabling the MMU if enabled by PBL.
> + */
> +void lowlevel_init(void)
> +{
> +	unsigned long sctlr;
> +
> +	sctlr = get_sctlr();
> +	set_sctlr(sctlr & ~(CR_M));	/* Early disable the MMU */
> +}
> +
> +/**
> + * qcom_spl_error_handler() - Centralized SPL error handler.
> + * @arg:	Generic argument (unused).
> + *
> + * This function is invoked upon critical errors during the SPL boot process.
> + */
> +void qcom_spl_error_handler(void *arg)
> +{
> +	pr_err("Entered the SPL Error Handler\n");
> +	hang();
> +}
> +
> +/**
> + * qcom_spl_malloc_init_f() - Initialize malloc for SPL.
> + *
> + * This function initializes the malloc subsystem using the memory region
> + */
> +void qcom_spl_malloc_init_f(void)
> +{
> +	if (!CONFIG_IS_ENABLED(SYS_MALLOC_F))
> +		return;
> +	/*
> +	 * Set up by crt0.S
> +	 */
> +	assert(gd->malloc_base);
> +	gd->malloc_limit = CONFIG_VAL(SYS_MALLOC_F_LEN);
> +	gd->malloc_ptr = 0;
> +
> +	mem_malloc_init(gd->malloc_base, gd->malloc_limit);
> +	gd->flags |= GD_FLG_FULL_MALLOC_INIT;
> +}
> +
> +/**
> + * qcom_spl_get_fit_img_entry_point() - Get entry point from FIT image node.
> + * @fit:	Pointer to the FIT image blob.
> + * @node:	Node ID within the FIT image.
> + * @entry_point:Pointer to store the retrieved entry point.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +static int qcom_spl_get_fit_img_entry_point(void *fit, int node,
> +					    u64 *entry_point)
> +{
> +	int ret;
> +
> +	if (!fit) {
> +		pr_err("FIT image blob is NULL\n");
> +		return -EINVAL;
> +	}
> +	if (node <= 0) {
> +		pr_err("Invalid FIT node ID %d\n", node);
> +		return -EINVAL;
> +	}
> +	if (!entry_point) {
> +		pr_err("Entry point pointer is NULL\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = fit_image_get_entry(fit, node, (ulong *)entry_point);
> +	if (ret) {
> +		pr_debug("No entry point for node %d, trying load address\n",
> +			 node);
> +		ret = fit_image_get_load(fit, node, (ulong *)entry_point);
> +		if (ret)
> +			pr_err("No load address for node %d (%d)\n", node, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * qcom_spl_get_iftbl_entry_by_name() - Get an interface table entry by name.
> + * @if_tbl:	Pointer to the QCLIB interface table.
> + * @name:	Name of the entry to find.
> + * @entry:	Pointer to a buffer where the found entry will be copied.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +static int qcom_spl_get_iftbl_entry_by_name(struct interface_table *if_tbl,
> +					    char *name,
> +					    struct interface_table_entry *entry)
> +{
> +	uint uc_index;
> +
> +	if (!if_tbl) {
> +		pr_err("Invalid interface table\n");
> +		return -EINVAL;
> +	}
> +	if (!name) {
> +		pr_err("Invalid name\n");
> +		return -EINVAL;
> +	}
> +	if (!entry) {
> +		pr_err("Invalid entry pointer\n");
> +		return -EINVAL;
> +	}
> +
> +	for (uc_index = 0; uc_index < if_tbl->num_entries; uc_index++) {
> +		if (!strcmp(if_tbl->if_table_entries[uc_index].entry_name, name)) {
> +			memcpy(entry,
> +			       &if_tbl->if_table_entries[uc_index],
> +			       sizeof(struct interface_table_entry));
> +			return 0;
> +		}
> +	}
> +	pr_err("Interface table entry '%s' not found\n", name);
> +
> +	return -ENOENT;
> +}
> +
> +/**
> + * qclib_post_process_from_spl() - Post-process QCLIB image from SPL FIT address
> + *
> + * This function performs the same operations as qclib_post_process() but
> + * takes no arguments. It gets the FIT image from CONFIG_SPL_LOAD_FIT_ADDRESS
> + * and finds the qclib_1 node automatically.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int qclib_post_process_from_spl(void)
> +{
> +	int ret;
> +	int entry_idx;
> +	int images_node;
> +	int qcconfig_node;
> +	int qclib_node;
> +	const void *fit;
> +	struct interface_table if_tbl;
> +	struct interface_table_entry qcsdi_entry;
> +	qcom_spl_jump_img_entry_t qclib_entry;
> +	u64 entry_point;
> +
> +	/* Get FIT image from SPL load address */
> +	fit = (const void *)CONFIG_SPL_LOAD_FIT_ADDRESS;
> +
> +	pr_debug("QCLIB post-processing from SPL: fit=%p\n", fit);
> +
> +	/*
> +	 * Find "images" node in FIT (get it once and reuse)
> +	 */
> +	images_node = fdt_subnode_offset(fit, 0, "images");
> +	if (images_node < 0) {
> +		pr_err("Failed to find images node in FIT\n");
> +		return -ENOENT;
> +	}
> +
> +	/*
> +	 * Find "qcconfig_1" image node
> +	 */
> +	qcconfig_node = fdt_subnode_offset(fit, images_node, "qcconfig_1");
> +	if (qcconfig_node < 0) {
> +		pr_err("Failed to find qcconfig_1 node in FIT\n");
> +		return -ENOENT;
> +	}
> +
> +	/*
> +	 * Find "qclib_1" image node
> +	 */
> +	qclib_node = fdt_subnode_offset(fit, images_node, "qclib_1");
> +	if (qclib_node < 0) {
> +		pr_err("Failed to find qclib_1 node in FIT\n");
> +		return -ENOENT;
> +	}
> +
> +	/*
> +	 * Initialize the local interface table
> +	 */
> +	memset(&if_tbl, 0, sizeof(struct interface_table));
> +	memcpy(if_tbl.magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
> +
> +	if_tbl.version = IF_TABLE_VERSION;
> +	if_tbl.num_entries = 0;
> +	if_tbl.max_entries = MAX_ENTRIES;
> +
> +	/*
> +	 * Add QCCONFIG entry to the interface table
> +	 */
> +	entry_idx = 0;
> +	memcpy(if_tbl.if_table_entries[entry_idx].entry_name,
> +	       QCCONFIG, strlen(QCCONFIG));
> +
> +	ret = qcom_spl_get_fit_img_entry_point((void *)fit,
> +					       qcconfig_node,
> +					       &if_tbl.if_table_entries[entry_idx].address);
> +	if (ret) {
> +		pr_err("Failed to get qcconfig_1 entry point (%d)\n", ret);
> +		return ret;
> +	}
> +	if_tbl.if_table_entries[entry_idx].attributes = 0;
> +	if_tbl.num_entries = entry_idx + 1;
> +
> +	/*
> +	 * Add QCSDI entry to the interface table
> +	 */
> +	entry_idx++;
> +	memcpy(if_tbl.if_table_entries[entry_idx].entry_name,
> +	       QCSDI, strlen(QCSDI));
> +
> +	if_tbl.if_table_entries[entry_idx].address = 0;
> +	if_tbl.if_table_entries[entry_idx].attributes = 0;
> +	if_tbl.num_entries = entry_idx + 1;
> +
> +	/*
> +	 * Get qclib_1 entry point
> +	 */
> +	ret = qcom_spl_get_fit_img_entry_point((void *)fit,
> +					       qclib_node,
> +					       &entry_point);
> +	if (ret) {
> +		pr_err("Failed to get qclib_1 entry point (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	qclib_entry = (qcom_spl_jump_img_entry_t)entry_point;
> +
> +	pr_info("Jumping to qclib_1 at 0x%llx\n", entry_point);
> +	qclib_entry(&if_tbl, NULL);
> +
> +	/* Parse the interface table to extract QCSDI address */
> +	ret = qcom_spl_get_iftbl_entry_by_name(&if_tbl, QCSDI, &qcsdi_entry);
> +	if (ret) {
> +		pr_err("Failed to get QCSDI entry from interface table (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	g_qcsdi_address = qcsdi_entry.address;
> +	pr_info("QCSDI address: 0x%llx\n", g_qcsdi_address);
> +
> +	return 0;
> +}
> +
> +
> +/**
> + * spl_get_load_buffer() - Allocate a cache-aligned buffer for image loading.
> + * @offset:	Offset (unused, typically 0 for SPL).
> + * @size:	Size of the buffer to allocate.
> + *
> + * Return: Pointer to the allocated buffer, or NULL on failure.
> + */
> +struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
> +{
> +	return (void *)(CONFIG_SPL_LOAD_FIT_ADDRESS);
> +}
> +
> +/**
> + * board_spl_fit_buffer_addr() - Get the address of the FIT image buffer.
> + * @fit_size:	Size of the FIT image.
> + * @sectors:	Number of sectors.
> + * @bl_len:	Block length.
> + *
> + * Return: Address of the FIT image buffer.
> + */
> +void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
> +{
> +	void *buffer = spl_get_load_buffer(0, sectors * bl_len);
> +
> +	if (!buffer) {
> +		pr_err("Failed to get FIT load buffer\n");
> +		qcom_spl_error_handler(NULL);
> +	}
> +
> +	return buffer;
> +}
> +
> +/**
> + * bl2_plat_get_bl31_params_v2() - Retrieve and fixup BL31 parameters.
> + * @bl32_entry:	Entry point for BL32 (OP-TEE).
> + * @bl33_entry:	Entry point for BL33 (U-Boot/kernel).
> + * @fdt_addr:	Address of the Device Tree Blob (FDT).
> + *
> + * Return: Pointer to the populated BL31 parameters structure.
> + */
> +struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
> +					      uintptr_t bl33_entry,
> +					      uintptr_t fdt_addr)
> +{
> +	struct bl_params *bl_params;
> +	struct bl_params_node *node;
> +
> +	/*
> +	 * Populate the bl31 params with default values.
> +	 */
> +	bl_params = bl2_plat_get_bl31_params_v2_default(bl32_entry, bl33_entry,
> +							fdt_addr);
> +
> +	/*
> +	 * Fixup the bl31 params based on platform requirements.
> +	 */
> +	for_each_bl_params_node(bl_params, node) {
> +		if (node->image_id == ATF_BL31_IMAGE_ID) {
> +			/*
> +			 * Pass QCSDI address to BL31 via arg0
> +			 * This address was populated by qclib_post_process()
> +			 */
> +			if (g_qcsdi_address == 0)
> +				pr_warn("QCSDI address not set, BL31 may not function correctly\n");
> +
> +			node->ep_info->args.arg0 = g_qcsdi_address;
> +			pr_debug("Setting BL31 arg0 to QCSDI address: 0x%llx\n", g_qcsdi_address);
> +		}
> +	}
> +
> +	return bl_params;
> +}
> +
> +/**
> + * qcom_spl_loader_pre_ddr() - SPL loader for pre-DDR stage.
> + * @boot_device:Type of boot device.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +static int qcom_spl_loader_pre_ddr(u8 boot_device)
> +{
> +	struct spl_image_loader *loader, *drv;
> +	struct spl_image_info spl_image = { 0 };
> +	struct spl_boot_device boot_dev = { .boot_device = boot_device, };
> +	int ret = -ENODEV, n_ents;
> +
> +	drv = ll_entry_start(struct spl_image_loader, spl_image_loader);
> +	n_ents = ll_entry_count(struct spl_image_loader, spl_image_loader);
> +
> +	for (loader = drv; loader && (loader != drv + n_ents); loader++) {
> +		if (boot_device != loader->boot_device)
> +			continue;
> +
> +		ret = loader->load_image(&spl_image, &boot_dev);
> +		if (!ret)
> +			break;
> +
> +		printf("%s: Error: %d\n", __func__, ret);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * spl_find_partition_info() - Find partition information by name
> + * @uclass_id: Device class ID (UCLASS_MMC)
> + * @device_num: Device number within the class
> + * @part_name: Name of the partition to find
> + * @info: Pointer to store partition information
> + *
> + * This function provides partition lookup logic for MMC.
> + * Return: Partition number on success, negative error code on failure
> + */
> +static int spl_find_partition_info(enum uclass_id uclass_id, int device_num,
> +				   const char *part_name,
> +				   struct disk_partition *info)
> +{
> +	int ret;
> +	struct blk_desc *desc;
> +
> +	if (!part_name || !info) {
> +		printf("Invalid parameters for partition lookup\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Get block device descriptor
> +	 */
> +	desc = blk_get_devnum_by_uclass_id(uclass_id, device_num);
> +	if (!desc) {
> +		printf("Block device not found for class %d, device %d\n",
> +		       uclass_id, device_num);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * Initialize partition table if needed
> +	 */
> +	if (desc->part_type == PART_TYPE_UNKNOWN) {
> +		printf("Initializing partition table\n");
> +		/*
> +		 * Prefer EFI/GPT
> +		 */
> +		desc->part_type = PART_TYPE_EFI;
> +	}
> +
> +	/*
> +	 * Find partition by name
> +	 */
> +	ret = part_get_info_by_name(desc, part_name, info);
> +	if (ret < 0) {
> +		printf("Partition '%s' not found\n", part_name);
> +		return -ENOENT;
> +	}
> +
> +	printf("Found partition '%s' at partition number %d\n", part_name, ret);
> +	return ret;
> +}
> +
> +#if CONFIG_IS_ENABLED(MMC)
> +/**
> + * spl_mmc_boot_mode() - Determine the boot mode for MMC
> + * @mmc:	Pointer to the MMC device
> + * @boot_device:	Boot device ID
> + *
> + * Return: MMCSD_MODE_RAW to use raw partition access
> + */
> +u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
> +{
> +	return MMCSD_MODE_RAW;
> +}
> +
> +/**
> + * spl_mmc_boot_partition() - Determine which partition to boot from
> + * @boot_device:	Boot device ID
> + *
> + * Return: Partition number to boot from, or default partition on error
> + */
> +int spl_mmc_boot_partition(const u32 boot_device)
> +{
> +	int ret;
> +	struct disk_partition info;
> +
> +	/*
> +	 * Use common partition lookup function
> +	 */
> +	ret = spl_find_partition_info(UCLASS_MMC, 0, QCOM_SPL_FIT_IMG_PARTITION, &info);
> +	if (ret < 0) {
> +		printf("Using default MMC partition %d\n",
> +		       CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION);
> +		return CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * spl_mmc_get_uboot_raw_sector() - Find the raw sector offset
> + * @mmc:	Pointer to the MMC device
> + * @raw_sect:	Sector
> + *
> + * Return: 0 if the image is at the starting of the partition without any offset.
> + */
> +unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc, ulong raw_sect)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_IS_ENABLED(MMC) */
> +
> +/**
> + * spl_boot_device() - Determine the boot device.
> + *
> + * Return: The mapped boot device type,
> + *	   or BOOT_DEVICE_NONE if the device is invalid.
> + */
> +u32 spl_boot_device(void)
> +{
> +	if (IS_ENABLED(CONFIG_SPL_MMC)) {
> +		printf("Selected boot device: MMC\n");
> +		return BOOT_DEVICE_MMC1;
> +	}
> +
> +	pr_err("No boot device configured\n");
> +	return BOOT_DEVICE_NONE;
> +}
> +
> +#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_SPL_FRAMEWORK_BOARD_INIT_F)

I think support for CONFIG_SPL_FRAMEWORK_BOARD_INIT_F config is removed. 
So can we remove the check based on this config?

Regards,

Balaji

> +/**
> + * board_init_f() - Main entry point for SPL.
> + * @dummy:	Dummy argument (unused).
> + */
> +void board_init_f(ulong dummy)
> +{
> +	int ret;
> +
> +	memset(__bss_start, 0, __bss_end - __bss_start); /* Clear BSS */
> +
> +	qcom_spl_malloc_init_f();
> +
> +	ret = spl_early_init();
> +	if (ret) {
> +		pr_debug("spl_early_init() failed (%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	preloader_console_init();
> +
> +	ret = qcom_spl_loader_pre_ddr(spl_boot_device());
> +	if (ret) {
> +		pr_debug("qcom_spl_loader_pre_ddr() failed (%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	ret = qclib_post_process_from_spl();
> +	if (ret) {
> +		pr_debug("qclib_post_process_from_spl() failed (%d)\n", ret);
> +		goto fail;
> +	}
> +
> +	board_init_r(NULL, 0);
> +
> +fail:
> +	if (ret)
> +		qcom_spl_error_handler(NULL);
> +}
> +#endif /* CONFIG_SPL_BUILD && !defined(CONFIG_SPL_FRAMEWORK_BOARD_INIT_F) */
> +
> +int board_fit_config_name_match(const char *name)
> +{
> +	/*
> +	 * SPL loads the pre-HLOS images from bootldr FIT image
> +	 * as below
> +	 *
> +	 * In board_init_f() - Matches "pre-ddr" configuration node and
> +	 * load the images mentioned in its <loadables>
> +	 *
> +	 * In board_init_r() - Matches "post-ddr" configuration node and
> +	 * load the images mentioned in its <loadables>
> +	 *
> +	 */
> +	if (!(gd->flags & GD_FLG_SPL_INIT)) {
> +		if (!strcmp(name, "pre-ddr")) {
> +			printf("Selected FIT Config: %s\n", name);
> +			return 0;
> +		}
> +	} else {
> +		if (!strcmp(name, "post-ddr")) {
> +			printf("Selected FIT Config: %s\n", name);
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +int board_fdt_blob_setup(void **fdtp)
> +{
> +	return 0;
> +}
> +
> +void reset_cpu(void)
> +{
> +	/*
> +	 * Empty placeholder for arch/arm/lib/reset.c:do_reset(),
> +	 * to avoid "undefined reference to `reset_cpu'"
> +	 */
> +}
