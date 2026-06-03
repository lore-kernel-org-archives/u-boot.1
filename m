Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D84CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03540848D8;
	Wed,  3 Jun 2026 17:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KtdJdMdQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA49B83FF5; Wed,  3 Jun 2026 15:47:48 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A93EA839A8
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 15:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bec429c2bb1so562240266b.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780494465; x=1781099265; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iwm3yqulNfObvtIWa3iaqlPrx1emxQIkSxtT97GbDpo=;
 b=KtdJdMdQKLmRYubOydSQn1ZV9WC4uz0TZC1tG8qJnY0bh8Mvx/9njYsP7UUsOwLaZE
 VDSRdhjmNfscPl1trJDUvj3XVME+PCf9ou9jzr1XuWBRhOXAQeaWmtEA1Xuzy4tOyeZ8
 IXhfaFF5JXJkS/BIqtFrCnp7f9/c14gcP73aLPvk1VzF7NDy7Sqpv6mGBd9v8qWZea7a
 slV/Qgzr06SoYRaB28iIClmZezWb3948tyo2wiif7qpuWCc7g9upV9pN9zpBUR4zaoWS
 VuWx+PeNZWSvZ7Qg2pFsLrD8QJMLPIw/SNz7uNa8bCvMdROv5i/8lJCDvP//UOoTAr5O
 hOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780494465; x=1781099265;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iwm3yqulNfObvtIWa3iaqlPrx1emxQIkSxtT97GbDpo=;
 b=k1T3l0kJynqBNKnZVpT4Z52nYNZAdGowAAyqJUlVPzkwTnLWey/XaaTgvyU4/EnysQ
 0kV8YdkOet9nDhfnnb8CWv4umg8Sk11NL1W2OrdA0pYqqtCha+2F6niqpd1Sm8vS68ej
 AsifUE2YYtNJ55ZTCGaIGJdYcQSbx4fQ/xuFcfOpEHwRdBWpBbyR4xlOQDCYoFC18ObA
 qLZZZrbPv0NgSy1w30RkDtFgc6gMjpBQFCLEtvXIN1FpD9PrS1HSr0sTkGpqOsbU0efX
 qSTRv+JUihZUdHxxSWp6bTUnXcHQc+82vJzky9wumPosDUE36/CvMnqW0K8BXqu36U/c
 8R+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+5khyE+lVU1Zub8B4W5Expsxe3Qkt1IdCgPpPUSmmgMSO3Swv4j6r2LGJNGpMRY8FoBzslrmU=@lists.denx.de
X-Gm-Message-State: AOJu0YyAOiFsUZB27kRtdrNV3GMj8lV61GNhp665VSo1jd7dM2L81Q+K
 kXn8W8v8t7l22AAwUKqiGKCnLF5xBT++bPe2GB6G7TOEkZlqvnWy+h+7sfLG/m2KL/Q=
X-Gm-Gg: Acq92OGAcYRyFcBnVGnR4aN4Bp5pr5ItJmHLWc+3vmpanQV+6xLCu7QcvyyK8gO1h/F
 DBEpksYlHGdgDsuS+AE/aa+weuoaCGJAkGY6UWNaf2vBDRcVBVApV0dnLHD4UG7+X7CPdp7y1ko
 lkyyIKhjmAiEhwMeCae75G6fyFMqhUrJtYFnrQRwW1USnapFm4wpv6StEDGstq7CnZttd3GeT6d
 CwUb9Rpmwb7pPhYMUF3PFnKmcRt15bFsE9yZEF/aeW6A049UL6Ae859Ixq+BY4TWcTjaLf4jcMQ
 y8UEqs1gKfEvJwG4G9lmEauvKOPdIRqMjPeaxmL9uwOuMyQ97U8qoikoA7NSkyMAqFLUvnUANSQ
 OOxuONxNXsxK56k7bpfRbetXc5NeaEvdrJ7n9tfJ0Sx3OHttZ4x1m71hVeqROml2hePwm1LHbez
 OO9heLp62q/7a2+kr/eaNdXeveSFen9JZIsgrDXxdlVkJ3L1TVxLCuL81oC+vyCXwXuz445zpWV
 c+191zbvx8jbw83oqFp8Lo=
X-Received: by 2002:a17:907:7296:b0:bee:c13f:7ec0 with SMTP id
 a640c23a62f3a-bf0ac20ee35mr199278266b.8.1780494464928; 
 Wed, 03 Jun 2026 06:47:44 -0700 (PDT)
Received: from [172.18.178.88] (ip-185-104-138-128.ptr.icomera.net.
 [185.104.138.128]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf055500875sm154275066b.53.2026.06.03.06.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 06:47:44 -0700 (PDT)
Message-ID: <4ee71802-c673-4044-9f82-b2222d9527ef@linaro.org>
Date: Wed, 3 Jun 2026 15:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 12/16] mach-snapdragon: parse incoming ARM32 ATAGS
To: me@samcday.com, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Stephan Gerhold <stephan.gerhold@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Eugen Hristev <ehristev@kernel.org>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Anshul Dalal <anshuld@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tingting Meng <tingting.meng@altera.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Lukasz Majewski <lukma@denx.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Jens Reidel <adrian@mainlining.org>
References: <20260601-qcom-armv7-v1-0-05a08d87e476@samcday.com>
 <20260601-qcom-armv7-v1-12-05a08d87e476@samcday.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260601-qcom-armv7-v1-12-05a08d87e476@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 03 Jun 2026 17:58:06 +0200
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

Hi Sam,

(CC list definitely needs some tuning on the next revision XD)

On 6/1/26 10:12, Sam Day via B4 Relay wrote:
> From: Sam Day <me@samcday.com>
> 
> Many (often fused) bootloaders on older ARMv7 qcom SoCs do not support
> FDTs at all, and instead pass along ATAGS in r2.
> 
> Minimal support for parsing memory info out of these tags is introduced,
> so that we can support mainline devicetrees, which expect the bootloader
> to populate /memory nodes.

I think this should go its own armv7-specific file. It would probably 
also make sense to just have a separate implementation of 
board_fdt_blob_setup() since it's already really quite complicated.

The SMEM series will do a bit of rework, in the next spin I'll probably 
move the caching stuff out as well, maybe I should also take 
board_fdt_blob_setup() then the file can be arm64 specific?

> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   arch/arm/mach-snapdragon/board.c | 119 ++++++++++++++++++++++++++++++---------
>   1 file changed, 91 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 627b566d178..753983467a0 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -11,6 +11,7 @@
>   
>   #include <asm/gpio.h>
>   #include <asm/io.h>
> +#include <asm/setup.h>
>   #include <asm/system.h>
>   #include <dm/device.h>
>   #include <dm/pinctrl.h>
> @@ -175,6 +176,67 @@ static int qcom_parse_memory(const void *fdt)
>   	return 0;
>   }
>   
> +static bool qcom_atags_valid(const phys_addr_t p)
> +{
> +	const struct tag *tags = (const struct tag *)p;
> +
> +	return tags && tags->hdr.tag == ATAG_CORE &&
> +	       tags->hdr.size >= sizeof(struct tag_header) / sizeof(u32);
> +}
> +
> +static int qcom_parse_atags(const struct tag *tags)
> +{
> +	phys_addr_t ram_end = 0;
> +	const struct tag *t;
> +	bool atags_end = false;
> +	u32 words = 0;
> +	int j = 0;
> +
> +	memset(prevbl_ddr_banks, 0, sizeof(prevbl_ddr_banks));
> +
> +	for (t = tags; words < SZ_16K / sizeof(u32); t = tag_next(t)) {
> +		if (t->hdr.tag == ATAG_NONE) {
> +			atags_end = true;
> +			break;
> +		}
> +		if (t->hdr.size < sizeof(struct tag_header) / sizeof(u32))
> +			return -EINVAL;
> +		if (t->hdr.size > SZ_16K / sizeof(u32) - words)
> +			return -EINVAL;
> +
> +		words += t->hdr.size;
> +
> +		if (t->hdr.tag != ATAG_MEM)
> +			continue;
> +		if (t->hdr.size < tag_size(tag_mem32))
> +			return -EINVAL;
> +		if (!t->u.mem.size)
> +			continue;
> +
> +		prevbl_ddr_banks[j].start = t->u.mem.start;
> +		prevbl_ddr_banks[j].size = t->u.mem.size;
> +		ram_end = max(ram_end, (phys_addr_t)t->u.mem.start + t->u.mem.size);
> +		j++;
> +
> +		if (j == CONFIG_NR_DRAM_BANKS)
> +			break;
> +	}
> +
> +	if (!atags_end && j < CONFIG_NR_DRAM_BANKS) {
> +		log_err("Provided more memory banks than we can handle\n");
> +		return -EINVAL;
> +	}
> +	if (!j)
> +		return -ENODATA;
> +
> +	qsort(prevbl_ddr_banks, j, sizeof(prevbl_ddr_banks[0]), ddr_bank_cmp);
> +
> +	gd->ram_base = prevbl_ddr_banks[0].start;
> +	gd->ram_size = ram_end - gd->ram_base;
> +
> +	return 0;
> +}
> +
>   static void show_psci_version(void)
>   {
>   #ifdef CONFIG_ARM64
> @@ -227,42 +289,52 @@ static void qcom_psci_fixup(void *fdt)
>    */
>   int board_fdt_blob_setup(void **fdtp)
>   {
> -	struct fdt_header *external_fdt, *internal_fdt;
> -	bool internal_valid, external_valid;
> -	int ret = -ENODATA;
> -
> -	internal_fdt = (struct fdt_header *)*fdtp;
> -	external_fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
> -	external_valid = external_fdt && !fdt_check_header(external_fdt);
> -	internal_valid = !fdt_check_header(internal_fdt);
> +	int ret = -ENODATA, setup_ret = -EEXIST;
> +	struct fdt_header *internal_fdt = *fdtp;
> +	phys_addr_t prev_bl_arg = get_prev_bl_fdt_addr();
> +	bool internal_valid = internal_fdt && !fdt_check_header(internal_fdt);
> +	bool external_is_fdt = prev_bl_arg &&
> +			       !fdt_check_header((const void *)prev_bl_arg);
>   
> -	/*
> -	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
> -	 * Bail out while we can still print a useful error message.
> -	 */
> -	if (!internal_valid && !external_valid)
> +	if (internal_valid) {
> +		debug("Using built in FDT\n");
> +	} else if (external_is_fdt) {
> +		debug("Using external FDT\n");
> +		*fdtp = (void *)prev_bl_arg;
> +		setup_ret = 0;
> +	} else {
> +		/*
> +		 * There is no point returning an error here, U-Boot can't do
> +		 * anything useful in this situation. Bail out while we can
> +		 * still print a useful error message.
> +		 */
>   		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%p)\n",
> -		      external_fdt);
> +		      (void *)prev_bl_arg);
> +	}
>   
>   	/* Prefer memory information from internal DT if it's present */
>   	if (internal_valid)
>   		ret = qcom_parse_memory(internal_fdt);
>   
> -	if (ret < 0 && external_valid) {
> +	if (ret < 0 && prev_bl_arg) {
>   		/* No internal FDT or it lacks a proper /memory node.
>   		 * The previous bootloader handed us something, let's try that.
>   		 */
>   		if (internal_valid)
>   			debug("No memory info in internal FDT, falling back to external\n");
>   
> -		ret = qcom_parse_memory(external_fdt);
> +		/* the prev BL arg is either an FDT or ATAGS */
> +		if (external_is_fdt)
> +			ret = qcom_parse_memory((const void *)prev_bl_arg);
> +		if (ret < 0 && qcom_atags_valid(prev_bl_arg))
> +			ret = qcom_parse_atags((const struct tag *)prev_bl_arg);
>   	}
>   
>   	if (ret < 0)
>   		panic("No valid memory ranges found!\n");
>   
> -	/* If we have an external FDT, it can only have come from the Android bootloader. */
> -	if (external_valid)
> +	/* If we have a prev BL arg, we assume it came from ABL */
> +	if (prev_bl_arg)
>   		qcom_boot_source = QCOM_BOOT_SOURCE_ANDROID;
>   	else
>   		qcom_boot_source = QCOM_BOOT_SOURCE_XBL;
> @@ -270,18 +342,9 @@ int board_fdt_blob_setup(void **fdtp)
>   	debug("ram_base = %#011lx, ram_size = %#011llx\n",
>   	      gd->ram_base, (unsigned long long)gd->ram_size);
>   
> -	if (internal_valid) {
> -		debug("Using built in FDT\n");
> -		ret = -EEXIST;
> -	} else {
> -		debug("Using external FDT\n");
> -		*fdtp = external_fdt;
> -		ret = 0;
> -	}
> -
>   	qcom_psci_fixup(*fdtp);
>   
> -	return ret;
> +	return setup_ret;
>   }
>   
>   /*
> 

