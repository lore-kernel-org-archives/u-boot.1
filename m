Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB29C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 08:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44BF875DE;
	Sat, 21 Oct 2023 10:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ie0CfqVT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD9E3875DF; Sat, 21 Oct 2023 10:43:42 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2F2875B5
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 10:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40859c46447so1668375e9.1
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697877818; x=1698482618; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OAGGLMwCmbGPNbRkvDipjHIApb+V+R1x5xXub+KvhU8=;
 b=Ie0CfqVToCi4ucu1ACiQyKNmJ0CJGP3+XlgTVk51rZy0Z36MWxFgeNcSRGqVMvzAFY
 DIFh/LCP6nkZJwaarPpEM0f1axlmx6AIYdpo49KPRGkRytPbN74l9QDwOXavYxJmldus
 NF5VrNFZ6nVp86lijX1UemGnMRknYoz2hCVDnrDb01SUmrLciG7HlIlhE2GmNP8oOHQ6
 0ITMEOqRoPK1x7SR1HTbr8kh9opikdbwkHT+5QScuyr0bgzZE/I6sr/4bH5Q450ifpgr
 kfrvvyAYsGkcsBNsVZg3PmKaoDKyDKZhtqKVBr1uAh9o3X5YKIme7ukahV4l8g0VO2RF
 FybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697877818; x=1698482618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OAGGLMwCmbGPNbRkvDipjHIApb+V+R1x5xXub+KvhU8=;
 b=dWnXPDIeStOtS3/S2vAVs7/FwcnzThmMhg7tlO1BpbduUtSao56lB9TAbKhnRREr6y
 EnznihMnyoBrOO9Rd+4MhHPxEaQw59+l9bMo0cA4AqFaz40nckRg9zdjjHPADHZYVMrN
 aXEeYSC15CU3J2JU+r8YGPFuUyNwFR++nx7hPkNFvsbkiSUuwrtVtSgg3NrntafI0UTG
 Up1s1DFyDJGn+3XCTyW0LdQwAI3rCXW0YeIX53koZqQ5opeQoL/7+V3/5nuVU/+Mxng+
 Phx2oAdL39rd0A/qG3TnLmsadpVVYw5L9KmYW8qBgKSchoSsC/V1J3FpIuI50lPNYaZe
 Helw==
X-Gm-Message-State: AOJu0Yw6UefOrF66Vig26q+mOZL0iECoDvJ40H0Rqn6iHbbSgTIfosHU
 2mHC3K1bu0V28e4LL0FhYKcJdg==
X-Google-Smtp-Source: AGHT+IGncrc2U+AMycV28ntrluKKF3Xz6dFvmA+udFwnolyLpEdfGtSFd0ei7Cyloum+jXfqelHHfg==
X-Received: by 2002:a05:600c:3583:b0:408:4095:6f0c with SMTP id
 p3-20020a05600c358300b0040840956f0cmr3381399wmq.38.1697877818105; 
 Sat, 21 Oct 2023 01:43:38 -0700 (PDT)
Received: from [192.168.67.234] (92.40.196.242.threembb.co.uk. [92.40.196.242])
 by smtp.gmail.com with ESMTPSA id
 o27-20020a05600c511b00b004067e905f44sm4068409wms.9.2023.10.21.01.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Oct 2023 01:43:37 -0700 (PDT)
Message-ID: <c4212389-6d0e-405d-bbc7-10c8278ba1de@linaro.org>
Date: Sat, 21 Oct 2023 09:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smbios: arm64: Allow table to be written at a fixed addr
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20231021004522.53311-1-sjg@chromium.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231021004522.53311-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Simon,

On 21/10/2023 01:45, Simon Glass wrote:
> U-Boot typically sets up its malloc() pool near the top of memory. On
> ARM64 systems this can result in an SMBIOS table above 4GB which is
> not supported by SMBIOSv2.
> 
> Work around this problem by providing a new option to choose an address
> just below 4GB, if needed.
I may well be missing something here, but I don't quite understand the 
justification behind the original patch [1] which caused this regression.

I'm currently preparing support for a few different Qualcomm boards 
which have different memory layouts, so far it's been possible to avoid 
having any fixed addresses, so the same u-boot image can be used on all 
of them (with just a different DTB).

As I mentioned before, efi_allocate_pages() seems to work fine from 
install_smbios_table(), I haven't delved into the code too much but I 
wonder if this could be an acceptable solution?

Barring that, could we use an environment variable to pass this address 
in? Although I think that might not be a very desirable solution.

I appreciate you taking the time to prepare this patch and CC me. If 
nobody else objects to this patch then I'd prefer to avoid blocking it. 
In either case, I'd greatly appreciate any input on the above 
suggestions so that I can implement a solution for my boards.

Thanks and regards,

[1]: 
https://lore.kernel.org/u-boot/20230920030027.1385833-16-sjg@chromium.org/
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   lib/Kconfig                 | 17 +++++++++++++++++
>   lib/efi_loader/efi_smbios.c | 12 ++++++++++++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index f6ca559897e7..a77f2f3e9089 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -994,6 +994,23 @@ config GENERATE_SMBIOS_TABLE
>   	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
>   	  the devicetree.
>   
> +config SMBIOS_TABLE_FIXED
> +	bool "Place the SMBIOS table at a special address"
> +	depends on GENERATE_SMBIOS_TABLE && ARM64 && SMBIOS && EFI_LOADER
> +	default y
> +	help
> +	  Use this option to place the SMBIOS table at a fixed address.
> +
> +	  U-Boot typically sets up its malloc() pool near the top of memory. On
> +	  ARM64 systems this can result in an SMBIOS table above 4GB which is
> +	  not supported by SMBIOSv2. This option works around this problem by
> +	  chosing an address just below 4GB, if needed.
> +
> +config SMBIOS_TABLE_FIXED_ADDR
> +	hex "Fixed address for use for SMBIOS table"
> +	depends on SMBIOS_TABLE_FIXED
> +	default 0xffff0000
> +
>   endmenu
>   
>   config LIB_RATIONAL
> diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
> index 48446f654d9b..84ea027ea48c 100644
> --- a/lib/efi_loader/efi_smbios.c
> +++ b/lib/efi_loader/efi_smbios.c
> @@ -61,6 +61,18 @@ static int install_smbios_table(void)
>   		return log_msg_ret("mem", -ENOMEM);
>   
>   	addr = map_to_sysmem(buf);
> +
> +	/*
> +	 * Deal with a fixed address if needed. For simplicity we assume that
> +	 * the SMBIOS-table size is <64KB and that the malloc region does not
> +	 * straddle the 4GB boundary.
> +	 */
> +	if (IS_ENABLED(CONFIG_SMBIOS_TABLE_FIXED) && addr >= SZ_4G - SZ_64K) {
> +		addr = IF_ENABLED_INT(CONFIG_SMBIOS_TABLE_FIXED,
> +				      CONFIG_SMBIOS_TABLE_FIXED_ADDR);
> +		log_warning("Forcing SMBIOS table to address %lx\n", addr);
> +	}
> +
>   	if (!write_smbios_table(addr)) {
>   		log_err("Failed to write SMBIOS table\n");
>   		return log_msg_ret("smbios", -EINVAL);

-- 
// Caleb (they/them)
