Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52EEC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:17:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3AB680A0A;
	Wed,  5 Feb 2025 14:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kDr6KUQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B92805E7; Wed,  5 Feb 2025 10:57:50 +0100 (CET)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCB9B80207
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 10:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-ab7430e27b2so439398866b.3
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 01:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738749467; x=1739354267; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S9xhTOqPLQLz1DrbLgy0JHAbfkh3CFcUkq1N0+0sOZ8=;
 b=kDr6KUQKDZ2OFTXeYS4lGGv/TbeP1nqmyqHrOh6OCXC6/ENJXkkmK7Amd85K4r464s
 g4nX24BcxLwJBV6lPBygeGp29hdjkIqq/mQNa8mxOyOvN2xkqDHOmbcfbTbIZCIG66UR
 AqiLh1QXpW/Fip/YTelmSa7D710c75nfqgQOCqUfQbw0y8Br2cnSsa8OiP9Fm9g6GvtB
 nB0EzOiW11zoEjIn52uPs8H365pAOijZYXG7eLjLMOcnfSi6wiUWqEMLo3KEVuRWAcEJ
 yhkHQxcu45XzA3vcUMOKt8FQN85gATz+cw9Y3VCoNW/UktS1Ah65T5b/atjWrhhrfN5n
 s8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738749467; x=1739354267;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S9xhTOqPLQLz1DrbLgy0JHAbfkh3CFcUkq1N0+0sOZ8=;
 b=P5JVBRka71Ctq95SD5xlbQD7gQGRbbbt/mAMTrhE6jPNaTQJlbQaVcJM4UUzufT337
 1AgLY7api2IDxg/6i+7jTbDVA/Pb6jQdkF3uDp8r/+M50FlokK0euseTB95MY8I9ehFJ
 t6yMGuy6EfeQ8FFfpki6Nlcynr/VhQ4dEYpyXMmL//pfIDzegPIfJp5Jl5f2IP3R3TDr
 YoeXeVwDGlp25eq81ZJLKgQd4YrvBvMs5R+o/2OokV63BfYTTurDeL3RscO/+3Jn90bH
 MLEUBs8JbOqmyf3VtGPNXtCiN9ICzBbt9W3TbOD5NzdV3nFbaFpOQbkHlAahQGAdCVPE
 K5fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLV591W/OWXXaTf97X9/JCARVt2SRAvcJgXj6JtKoSHi6A9eBYVmMqsdftEcrCPt6J0ARlWt8=@lists.denx.de
X-Gm-Message-State: AOJu0YwTAp2jTeSniXW3ySuEFpbPzTXX+ae7xJdfWsUBm9QNbfXlPFPT
 n4oS2xGmbfgRwtXUz6eAaWBoPLr9qYpPPQ92dx06iGBcQ1dXzLeGIB1lihHvh+U=
X-Gm-Gg: ASbGnctfVieEGURYk01fIK5t1o4SdVjy7QBg7Zqn/MI4hflQ9gfjEZlc0Rb9JdnGFpK
 NndT1nBF74IPZE/ELtRlfNVrD2lDvOGQDGtdREjG3Pd5Pa7Pzagd3gVdr58eFdkNwZh86bzuGyk
 6MEQC1H5zBbD0bgmlqRsZAW3HRDYy0UN1Axzrfv8OqwNbQ2P1djDBJarapdIr22XIbjHRnlQRwL
 2nFRTaKXWpeZIS7H9WweGXJOK8W5X6cfAK5ZcMe2FqJKVZReL9Fvjf01/uee9iMN0BrkcH1LDVd
 TUfEwPDTqkrH3+m24NpItyO8207wiMQTa4G6WK/qzUbjz5qliWMgitvIiYavGzTK/ppN
X-Google-Smtp-Source: AGHT+IHyx5nNoN020vWVxFF+L2q6WN7tmvzgJ64MeIqqn7/6emyFjKzLBRXNTeQ3iiNF7WjGPNl9Rg==
X-Received: by 2002:a17:907:3f8e:b0:ab3:85f2:ff67 with SMTP id
 a640c23a62f3a-ab75e237e65mr212780766b.16.1738749467002; 
 Wed, 05 Feb 2025 01:57:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ed29:9eea:a05:44fd?
 ([2a01:e0a:3cb:7bb0:ed29:9eea:a05:44fd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7216600e1sm581702166b.81.2025.02.05.01.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 01:57:46 -0800 (PST)
Message-ID: <ec13d51a-199e-4765-85e2-c74d4c2da8c5@linaro.org>
Date: Wed, 5 Feb 2025 10:57:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] arm64: Enable RW, RX and RO mappings for the
 relocated binary
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 trini@konsulko.com
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Joshua Watt <jpewhacker@gmail.com>,
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Evgeny Bachinin
 <EABachinin@salutedevices.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-7-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250205071714.635518-7-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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



On 2/5/25 08:16, Ilias Apalodimas wrote:
> Now that we have everything in place switch the page permissions for
> .rodata, .text and .data just after we relocate everything in top of the
> RAM.
> 
> Unfortunately we can't enable this by default, since we have examples of
> U-Boot crashing due to invalid access. This usually happens because code
> defines const variables that it later writes. So hide it behind a Kconfig
> option until we sort it out.
> 
> It's worth noting that EFI runtime services are not covered by this
> patch on purpose. Since the OS can call SetVirtualAddressMap which can
> relocate runtime services, we need to set them to RX initially but remap
> them as RWX right before ExitBootServices.
> 
> Link: https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de/
> Link: https://lore.kernel.org/u-boot/20250130133646.2177194-1-andre.przywara@arm.com/
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  common/Kconfig   | 13 +++++++++++++
>  common/board_r.c | 20 ++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/common/Kconfig b/common/Kconfig
> index 7685914fa6fd..dbae7e062b0a 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -914,6 +914,19 @@ config STACKPROTECTOR
>  	  Enable stack smash detection through compiler's stack-protector
>  	  canary logic
>  
> +config MMU_PGPROT
> +	bool "Enable RO, RW and RX mappings"
> +	help
> +	  U-Boot maps all pages as RWX. If selected pages will
> +	  be marked as RO(.rodata), RX(.text), RW(.data) right after

Space before (

> +	  we relocate. Since code sections needs to be page aligned
> +	  the final binary size will increase.
> +	  The mapping can be dumped using the 'meminfo' command.

OK

> +	  We should make this default 'y' in the future, but currently
> +	  we have code defining const variables that are later written.
> +	  Enabling this will crash U-Boot if that code path runs, so keep
> +	  it off by default until we fix invalid accesses.

Not sure this needs to be documented in the Kconfig help. Perhaps just
keep a patch ready and send it early in the next release cycle for people
to test and debug?

> +
>  config SPL_STACKPROTECTOR
>  	bool "Stack Protector buffer overflow detection for SPL"
>  	depends on STACKPROTECTOR && SPL
> diff --git a/common/board_r.c b/common/board_r.c
> index 179259b00de8..c1e9aa46e3fa 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -170,7 +170,27 @@ static int initr_reloc_global_data(void)
>  	efi_save_gd();
>  
>  	efi_runtime_relocate(gd->relocaddr, NULL);
> +
>  #endif
> +	/*
> +	 * We are done with all relocations change the permissions of the binary
> +	 * NOTE: __start_rodata etc are defined in arm64 linker scripts and
> +	 * sections.h. If you want to add support for your platform you need to
> +	 * add the symbols on your linker script, otherwise they will point to
> +	 * random addresses.
> +	 *
> +	 */
> +	if (IS_ENABLED(CONFIG_MMU_PGPROT)) {
> +		pgprot_set_attrs((phys_addr_t)(uintptr_t)(__start_rodata),
> +				 (phys_addr_t)(uintptr_t)(__end_rodata - __start_rodata),
> +				 MMU_ATTR_RO);
> +		pgprot_set_attrs((phys_addr_t)(uintptr_t)(__start_data),
> +				 (phys_addr_t)(uintptr_t)(__end_data - __start_data),
> +				 MMU_ATTR_RW);
> +		pgprot_set_attrs((phys_addr_t)(uintptr_t)(__text_start),
> +				 (phys_addr_t)(uintptr_t)(__text_end - __text_start),
> +				 MMU_ATTR_RX);
> +	}
>  
>  	return 0;
>  }

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
