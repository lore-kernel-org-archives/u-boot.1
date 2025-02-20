Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32A6C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5723E80FDA;
	Thu, 20 Feb 2025 22:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H/BfQm0K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B59080F56; Thu, 20 Feb 2025 19:32:29 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA51880077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 19:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220d398bea9so19025415ad.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740076345; x=1740681145; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=llv2J6MhlyHPtd1/3XR6fotUlrEw60s+AGfvaM/kCCo=;
 b=H/BfQm0KBfJVXpWArkfBjnQ5xVhM4jswKLqUKPUpNh39FWGDEPA6m1pDvvmuHMzWxW
 xUyybUj3RPHB7kn6lHTiwJyHi2KHgVWzekh8GFoA6y1IlGO/CRBF8eGbiJANhKeEnAB1
 Hf23gUXqMswu/khZNa1JjF+CAZHvSdWcbxRA0CO5nSX9MyK95X68Kzb+eB105cPADDW9
 0959ti0ZHEqfFFmj04hnjzGQcqjK/sTXLI4/uDreAEMo90mxp6C4tR2vCMXVZlE5TSHL
 2Z2FB8VG41ATgwVIubfZT9isd+utBzzCRkcFzcrTZas5ALvKE21tQb5aYqEYbSKNekZf
 aakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740076345; x=1740681145;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=llv2J6MhlyHPtd1/3XR6fotUlrEw60s+AGfvaM/kCCo=;
 b=tDqykhx7V6AKi6I3kK6kc0zp/9+1xAaMYo+CUA45OIOO7DrmNzUr7eOrc1+un8e4jW
 zedK22hdaBf9nTKdavi3yARiYTGua2I/bEa8JuCqhmtfMoe1XfFwwSQDLGCHuduB8Uai
 vAnAlLoLLuMk+SCxYF1Yam8lXmbz6+kY4D4qgEW9l5YnPWzVXI1TLfuPDuv6kc+Zn34z
 yAcstr0C/JjuRmUK6WUNs6kwg9bSbcP5iAlAj4yLHCbkIz2TuduvW5WWd3lcvvFmjZYp
 GntivMVriV1B5v6JES77+h//EWJL6YhYj3+XEdgmyweX4jSHNy7zNshTpI/06CntbgjT
 kxlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt1xRtDsrKCwlbKRV6vnEa0M3hyE1e/4D4TxIO9XGRkHLzd49FQwTiK21gJ2vUt3nGVwcJeW0=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+1lvqLta69cQ50HLZ/vTsjyiav4txaRh5DOnM2lCXPy0EJ7N0
 fW3M3GZVccKMVufNOfEcQduq3l83/tUXmcMtMvyxsjy3DFRjgO7zrtg3wK08F5w=
X-Gm-Gg: ASbGncvXuwwM97/BP/KvvfK95Ff12wGQKaPN2IsZQHibqj8HUoWaenB082d6Gdenfvn
 PhZzsaWQY3+MrkIASoXaU4f9XV7M7wGqP/czF88s6WL6IX+EYwX6cWVnMe4mMhtIDRwN2Iz9ojc
 xaIhh3zd4EyliEKn4f5qWZUbSSt5ANPSA4cOrw/v9vEEiP3aEMuWiRjhOqGof6nKRckP0khCIuc
 ISBIhQxjpKODk+6E7hfgRZqHDi5TEVfOeZjiD2slDn48l/dxmIxtpF07xHOYhBL9BY5doB8X3Qe
 l0rBeIEhbUCbCPXCiScIgVFFtug0h/gKyZwUk7JNvrMKOlb+HcKKliU=
X-Google-Smtp-Source: AGHT+IFzveJy42mOVTjmI4+aTcJgET5vWHDvm1BAguJRpNURoisiie3h1a8a+2OWbVJSI59yDsq+6g==
X-Received: by 2002:a17:902:f60b:b0:21f:522b:690f with SMTP id
 d9443c01a7336-2219ffbba58mr2174245ad.46.1740076344875; 
 Thu, 20 Feb 2025 10:32:24 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d53644e2sm125518575ad.65.2025.02.20.10.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:32:24 -0800 (PST)
Message-ID: <66808cbb-1252-4270-ba4e-cf0fb7413c2c@linaro.org>
Date: Thu, 20 Feb 2025 10:32:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] treewide: Add a function to change page permissions
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 mark.kettenis@xs4all.nl
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Tom Rini
 <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
 <20250220135506.151894-6-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220135506.151894-6-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

On 2/20/25 05:54, Ilias Apalodimas wrote:
> +++ b/include/cpu_func.h
> @@ -69,6 +69,23 @@ void flush_dcache_range(unsigned long start, unsigned long stop);
>   void invalidate_dcache_range(unsigned long start, unsigned long stop);
>   void invalidate_dcache_all(void);
>   void invalidate_icache_all(void);
> +
> +enum pgprot_attrs {
> +	MMU_ATTR_RO,
> +	MMU_ATTR_RX,
> +	MMU_ATTR_RW,
> +};
> +
> +/** pgprot_set_attrs() - Set page table permissions
> + *
> + * @addr: Physical address start
> + * @size: size of memory to change
> + * @perm: New permissions
> + *
> + * Return: 0 on success, error otherwise.
> + **/
> +int pgprot_set_attrs(phys_addr_t addr, size_t size, u64 perm);

Why do you not use the enum for 'perm'?
That's certainly the API you're expecting...


r~
