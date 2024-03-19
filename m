Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15013C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 06:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60AE088062;
	Tue, 19 Mar 2024 07:17:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vZ1DplUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 328F388053; Tue, 19 Mar 2024 07:17:43 +0100 (CET)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AD1388063
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-47651248841so1779246137.2
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 23:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829058; x=1711433858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pufA9AUbxXiccbemcJH2GyAuo21K1/WDkjqkT5hHj4g=;
 b=vZ1DplUnVS+Cvr8+El2VVmnybOGmJVdxmL14tG8c25ujX4vnrNnMalQC/zR43lSXue
 lBJsHgESyhS8jias4eESLw0dC8dltdUlDC+pq7liwjAToH/boxGLXf6ll1WOVOQIQlBF
 aZklasLSmfq4L6fiam0eNAnpMGnQEDNVtCDqBAdUqKmy+rt0s5c12v8yPNIRs9Jel1Mx
 h5px1b1INKAsNOHrLwYaSLblBU2TQuLiLkJFscVXLp1NxOzfEKkIqdbW4YSM+ttwkOpC
 nADbtQGy0S1yA22FpiTb0VU6g7KILDV78XvqAeZmEFofrtYXoRKGEpAsnN2J7O/kc7wt
 m+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829058; x=1711433858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pufA9AUbxXiccbemcJH2GyAuo21K1/WDkjqkT5hHj4g=;
 b=wdrABjL5McPILBQ1jakEa6n+t37J01DuzLyOZoLYnIwpCmVcuK76jsk/lrc8wjKV3o
 gTNwLpyp5ErcM8QO+Xe2Je2NXJQWz91fgowy7EgOKoDZ4wSLBvoSlrv9TSvfYCFG0YFH
 8FQQG3R0b1AmxaUsdsoUpmJZzilYc6hzKfSSMjXdpIvRVbIIpchd++3/Jr/iKevTw42w
 vEgHQvA+eAGS284A2luLC9eiwR9XVGdm4ghRVNZIeJFwiS0jTaQInahAT28mk3XcwVVf
 +eMbSWbh7orkd2iSCPiPkFHQlgvOXDgLIZfwKrg6kzQ6xGUhBHjB/1eRWwkE9AeRbEM0
 3tZg==
X-Gm-Message-State: AOJu0Yze8jGtplr4fTkicqh2RWTF/J4PV4UVinubtLJtFXINQy374R09
 DYBIoyt58cLPQLtl6Zd+cnJ+P+hwExjP8xhZOe7WeNwY63gipAHzBxYgOxV6vc0f8jEf92ociTQ
 QBMB/e0IdKylgq5Qaba4dLAQO05L34hTr+I8/SQ==
X-Google-Smtp-Source: AGHT+IFDgcyFKwOtT9HM+XGA5EZ4F8ocpRUeRMsW6g/j9r3rEBHYfNo/wtCuLkEouVF9EgI8XbrVa4/HfUcovWVTTqs=
X-Received: by 2002:a05:6102:2403:b0:470:3ece:b431 with SMTP id
 j3-20020a056102240300b004703eceb431mr9464333vsi.4.1710829058371; Mon, 18 Mar
 2024 23:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240318145958.8099-1-marek.vasut+renesas@mailbox.org>
 <20240318145958.8099-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240318145958.8099-2-marek.vasut+renesas@mailbox.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Mar 2024 11:47:26 +0530
Message-ID: <CAFA6WYOTEPToxw=RJLHTSSvNxuVRaLFBZEveLTNeGYs5wLa8_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: renesas: Switch to using upstream DT on
 64bit Renesas SoCs
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 18 Mar 2024 at 20:30, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Enable OF_UPSTREAM to use upstream DT and add renesas/ prefix to the
> DEFAULT_DEVICE_TREE and OF_LIST. And thereby directly build DTB from
> dts/upstream/src/ including *-u-boot.dtsi files from arch/$(ARCH)/dts/
> directory.
>
> The configuration update has been done using the following script:
> ```
> sed -i '/^CONFIG_DEFAULT_DEVICE_TREE/ s@="@&renesas/@' `git grep -li renesas configs`
> sed -i '/^CONFIG_OF_LIST/ s@r8a@renesas/&@g' `git grep -li renesas configs`
> ```
>
> There are SoCs which are not included in this patch. The 32bit SoCs
> require further infrastructure work. R8A779H0 is coming during the
> next upstream DT synchronization cycle as it is not included in
> current upstream DTs yet.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-renesas/Kconfig         | 1 +
>  configs/hihope_rzg2_defconfig         | 4 ++--
>  configs/r8a77970_eagle_defconfig      | 2 +-
>  configs/r8a77970_v3msk_defconfig      | 2 +-
>  configs/r8a77980_condor_defconfig     | 2 +-
>  configs/r8a77980_v3hsk_defconfig      | 2 +-
>  configs/r8a77990_ebisu_defconfig      | 2 +-
>  configs/r8a77995_draak_defconfig      | 2 +-
>  configs/r8a779a0_falcon_defconfig     | 2 +-
>  configs/r8a779f0_spider_defconfig     | 2 +-
>  configs/r8a779g0_whitehawk_defconfig  | 2 +-
>  configs/r8a779h0_grayhawk_defconfig   | 1 +
>  configs/rcar3_salvator-x_defconfig    | 4 ++--
>  configs/rcar3_ulcb_defconfig          | 4 ++--
>  configs/renesas_rzg2l_smarc_defconfig | 2 +-
>  configs/rzg2_beacon_defconfig         | 4 ++--
>  configs/silinux_ek874_defconfig       | 2 +-
>  17 files changed, 21 insertions(+), 19 deletions(-)
>

Thanks Marek for your adoption of OF_UPSTREAM. FWIW:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
> index 2ac867612bf..aeb55da609b 100644
> --- a/arch/arm/mach-renesas/Kconfig
> +++ b/arch/arm/mach-renesas/Kconfig
> @@ -14,6 +14,7 @@ config RCAR_64
>         imply CMD_GPT
>         imply CMD_MMC_SWRITE if MMC
>         imply CMD_UUID
> +       imply OF_UPSTREAM
>         imply SUPPORT_EMMC_RPMB if MMC
>
>  choice
> diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
> index 88c7ed1b98f..149ce0bac0d 100644
> --- a/configs/hihope_rzg2_defconfig
> +++ b/configs/hihope_rzg2_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_OFFSET=0xFFFE0000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a774a1-hihope-rzg2m"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-hihope-rzg2m"
>  CONFIG_RCAR_GEN3=y
>  CONFIG_TARGET_HIHOPE_RZG2=y
>  CONFIG_SYS_MONITOR_LEN=1048576
> @@ -40,7 +40,7 @@ CONFIG_CMD_EXT4_WRITE=y
>  CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
>  CONFIG_OF_CONTROL=y
> -CONFIG_OF_LIST="r8a774a1-hihope-rzg2m r8a774b1-hihope-rzg2n r8a774e1-hihope-rzg2h"
> +CONFIG_OF_LIST="renesas/r8a774a1-hihope-rzg2m renesas/r8a774b1-hihope-rzg2n renesas/r8a774e1-hihope-rzg2h"
>  CONFIG_MULTI_DTB_FIT_LZO=y
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
>  CONFIG_ENV_OVERWRITE=y
> diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
> index a3f695e4238..fc39412f65c 100644
> --- a/configs/r8a77970_eagle_defconfig
> +++ b/configs/r8a77970_eagle_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0x700000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a77970-eagle"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77970-eagle"
>  CONFIG_SPL_TEXT_BASE=0xe6318000
>  CONFIG_RCAR_GEN3=y
>  CONFIG_TARGET_EAGLE=y
> diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
> index 05c8d0e3868..bcd70b768ee 100644
> --- a/configs/r8a77970_v3msk_defconfig
> +++ b/configs/r8a77970_v3msk_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0x700000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a77970-v3msk"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77970-v3msk"
>  CONFIG_SPL_TEXT_BASE=0xe6318000
>  CONFIG_RCAR_GEN3=y
>  CONFIG_R8A77970=y
> diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_defconfig
> index 9e11c1b27ee..65eb563a712 100644
> --- a/configs/r8a77980_condor_defconfig
> +++ b/configs/r8a77980_condor_defconfig
> @@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0x700000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a77980-condor"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77980-condor"
>  CONFIG_SPL_TEXT_BASE=0xe6318000
>  CONFIG_RCAR_GEN3=y
>  CONFIG_TARGET_CONDOR=y
> diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_defconfig
> index f61574dd02d..38f9da445dd 100644
> --- a/configs/r8a77980_v3hsk_defconfig
> +++ b/configs/r8a77980_v3hsk_defconfig
> @@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0x700000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a77980-v3hsk"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77980-v3hsk"
>  CONFIG_SPL_TEXT_BASE=0xe6318000
>  CONFIG_RCAR_GEN3=y
>  CONFIG_R8A77980=y
> diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
> index fe4134226ac..f3cf2f8835d 100644
> --- a/configs/r8a77990_ebisu_defconfig
> +++ b/configs/r8a77990_ebisu_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_OFFSET=0xFFFE0000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a77990-ebisu"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77990-ebisu"
>  CONFIG_SPL_TEXT_BASE=0xe6318000
>  CONFIG_RCAR_GEN3=y
>  CONFIG_TARGET_EBISU=y
> diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
> index a964d4ea51e..ae722724e27 100644
> --- a/configs/r8a77995_draak_defconfig
> +++ b/configs/r8a77995_draak_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_OFFSET=0xFFFE0000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a77995-draak"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77995-draak"
>  CONFIG_SPL_TEXT_BASE=0xe6318000
>  CONFIG_RCAR_GEN3=y
>  CONFIG_TARGET_DRAAK=y
> diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
> index 6681cb0088f..40097f9dc34 100644
> --- a/configs/r8a779a0_falcon_defconfig
> +++ b/configs/r8a779a0_falcon_defconfig
> @@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0xC00000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a779a0-falcon"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779a0-falcon"
>  CONFIG_RCAR_GEN4=y
>  CONFIG_TARGET_FALCON=y
>  CONFIG_SYS_MONITOR_LEN=1048576
> diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_defconfig
> index 942e0184412..9ab46a4d5e0 100644
> --- a/configs/r8a779f0_spider_defconfig
> +++ b/configs/r8a779f0_spider_defconfig
> @@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_OFFSET=0xD00000
>  CONFIG_ENV_SECT_SIZE=0x40000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a779f0-spider"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779f0-spider"
>  CONFIG_RCAR_GEN4=y
>  CONFIG_TARGET_SPIDER=y
>  CONFIG_SYS_MONITOR_LEN=1048576
> diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
> index 4cc6203e54d..abc9a3ba611 100644
> --- a/configs/r8a779g0_whitehawk_defconfig
> +++ b/configs/r8a779g0_whitehawk_defconfig
> @@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_OFFSET=0xFFFE0000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a779g0-white-hawk"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779g0-white-hawk"
>  CONFIG_RCAR_GEN4=y
>  CONFIG_TARGET_WHITEHAWK=y
>  CONFIG_SYS_MONITOR_LEN=1048576
> diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
> index 7368708195d..ff317e7c4bc 100644
> --- a/configs/r8a779h0_grayhawk_defconfig
> +++ b/configs/r8a779h0_grayhawk_defconfig
> @@ -72,3 +72,4 @@ CONFIG_SCIF_CONSOLE=y
>  CONFIG_SPI=y
>  CONFIG_DM_SPI=y
>  CONFIG_RENESAS_RPC_SPI=y
> +# CONFIG_OF_UPSTREAM is not set
> diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
> index 22d649296e1..3200e3933b0 100644
> --- a/configs/rcar3_salvator-x_defconfig
> +++ b/configs/rcar3_salvator-x_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_OFFSET=0xFFFE0000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a77951-salvator-x"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77951-salvator-x"
>  CONFIG_SPL_TEXT_BASE=0xe6338000
>  CONFIG_RCAR_GEN3=y
>  CONFIG_TARGET_SALVATOR_X=y
> @@ -48,7 +48,7 @@ CONFIG_CMD_EXT4_WRITE=y
>  CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
>  CONFIG_OF_CONTROL=y
> -CONFIG_OF_LIST="r8a77951-salvator-x r8a77960-salvator-x r8a77965-salvator-x"
> +CONFIG_OF_LIST="renesas/r8a77951-salvator-x renesas/r8a77960-salvator-x renesas/r8a77965-salvator-x"
>  CONFIG_MULTI_DTB_FIT_LZO=y
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
>  CONFIG_OF_DTB_PROPS_REMOVE=y
> diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
> index 8349f070ba4..c5cce826efd 100644
> --- a/configs/rcar3_ulcb_defconfig
> +++ b/configs/rcar3_ulcb_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_OFFSET=0xFFFE0000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a77951-ulcb"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77951-ulcb"
>  CONFIG_SPL_TEXT_BASE=0xe6338000
>  CONFIG_RCAR_GEN3=y
>  CONFIG_TARGET_ULCB=y
> @@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
>  CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
>  CONFIG_OF_CONTROL=y
> -CONFIG_OF_LIST="r8a77951-ulcb r8a77960-ulcb r8a77965-ulcb"
> +CONFIG_OF_LIST="renesas/r8a77951-ulcb renesas/r8a77960-ulcb renesas/r8a77965-ulcb"
>  CONFIG_MULTI_DTB_FIT_LZO=y
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
>  CONFIG_OF_DTB_PROPS_REMOVE=y
> diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
> index e4e597f995a..7a1224b3f07 100644
> --- a/configs/renesas_rzg2l_smarc_defconfig
> +++ b/configs/renesas_rzg2l_smarc_defconfig
> @@ -9,7 +9,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x80000
>  CONFIG_ENV_SIZE=0x20000
>  CONFIG_ENV_OFFSET=0xFFFE0000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r9a07g044l2-smarc"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r9a07g044l2-smarc"
>  CONFIG_RZG2L=y
>  CONFIG_SYS_MONITOR_LEN=1048576
>  CONFIG_SYS_LOAD_ADDR=0x58000000
> diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
> index f4b63adb41e..4aabb1fe03e 100644
> --- a/configs/rzg2_beacon_defconfig
> +++ b/configs/rzg2_beacon_defconfig
> @@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
>  CONFIG_SYS_MALLOC_F_LEN=0x2000
>  CONFIG_ENV_OFFSET=0x0
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a774a1-beacon-rzg2m-kit"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-beacon-rzg2m-kit"
>  CONFIG_RCAR_GEN3=y
>  CONFIG_TARGET_BEACON_RZG2M=y
>  CONFIG_SYS_MONITOR_LEN=1048576
> @@ -39,7 +39,7 @@ CONFIG_CMD_EXT4_WRITE=y
>  CONFIG_CMD_FAT=y
>  CONFIG_CMD_FS_GENERIC=y
>  CONFIG_OF_CONTROL=y
> -CONFIG_OF_LIST="r8a774a1-beacon-rzg2m-kit r8a774b1-beacon-rzg2n-kit r8a774e1-beacon-rzg2h-kit"
> +CONFIG_OF_LIST="renesas/r8a774a1-beacon-rzg2m-kit renesas/r8a774b1-beacon-rzg2n-kit renesas/r8a774e1-beacon-rzg2h-kit"
>  CONFIG_MULTI_DTB_FIT_LZO=y
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
>  CONFIG_ENV_OVERWRITE=y
> diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
> index 93902e009b2..4c94d016454 100644
> --- a/configs/silinux_ek874_defconfig
> +++ b/configs/silinux_ek874_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x10000
>  CONFIG_ENV_OFFSET=0x3F0000
>  CONFIG_ENV_SECT_SIZE=0x10000
>  CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="r8a774c0-ek874"
> +CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774c0-ek874"
>  CONFIG_SPL_TEXT_BASE=0xe6318000
>  CONFIG_RCAR_GEN3=y
>  CONFIG_TARGET_SILINUX_EK874=y
> --
> 2.43.0
>
