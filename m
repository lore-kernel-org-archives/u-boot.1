Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D3BC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 16:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3498806D8;
	Thu, 27 Mar 2025 17:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s5eXmfeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C672E806FC; Thu, 27 Mar 2025 17:31:37 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84338805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 17:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso12217365e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743093095; x=1743697895; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fvx4gexM9QHbY6Gtpe+Facdq12qGap7L78TQQzVUyAY=;
 b=s5eXmfeIEbgYC5l3utRne+IlCqivFb88CHN1+rw9QH87AKV77GuCLpdPH12xHdLLTt
 jLZ4Aa6BMZ2aH6b2PnL2YjJU3uUPRxLykOGY2RvSvEmWR5QIc9QmwHLqmZF8PvE4GxWN
 6auaADgG6cd2rSR5/xNSgK2Tr5eWulJjtFtkJcKOC++/gDZwakwKpII2opyNx+vCsQFb
 Dr1EZP5wKPwSvONECgvPAdj7gcN3e6owj3qmJCKxh73pZrkJmHCiOf3sDLhXktSKSD4Z
 poJ9gyVgrMzErYm8gP/hwdWcRdPe1VPfulbmbt7ZOzfO4k7Na9EJqDOV1Q0xt4HPkTX8
 JH7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743093095; x=1743697895;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fvx4gexM9QHbY6Gtpe+Facdq12qGap7L78TQQzVUyAY=;
 b=e2V5CQOiBXRfweI3ZZvtjqqv6JZ0pyrQdLelBRQTH+Y7wmGSZ7SYQURMcgzdB0GUxh
 uokKPcrmWMSs6MVDagqQHlqx4N0+4zY3wOvhBKbnnfeioBkWYo7kUHTmuJfwgQI3ZO6y
 2nAEnoJRFkzeIMeHMYfgGggnx+he1dm/cW90O7zxf9TqMVyv1JYIE+foPAUI3FIj9a0y
 w8sEWcxHVlGrUjsPTSLROSUVKJoZTcU0j/HPcQphm0f+V5xNWWrrRowKAQlHVSNIjSru
 s77xpgjLHIqSwU3GFd2zuze/upzxkDiLume1papb5jtrH2lJLhQjtFNMwqpoOA1ZX/9+
 JxqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUycptQ1QObDnrl03nVNfy4DgIHuTQIFaTaua9+jzWRFIkuQhkMdno5Ixsa73UzXDr+WA3mfQM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy16obRA2a0bMSH4Dy/3HdeOKnvL39Kw51aJd4nmjTY4pafQalw
 muyO/NA+wMAGzhHU95wo3jfdlz6824NgNWlQBV7CPexWDtgzhP2KVC5ELlXwlU0=
X-Gm-Gg: ASbGncvkP749boOasLYNTxOY1iOckPBdfbYcfvKZ82B9qZwq7rR6e9EoiHaqow9KfXs
 Ga9lfQeU5GnlfQlZ2Em1XVtsrg4GgdVZsbc4OdiU8JFKNgUR7h1uH7vlLpROZFvO5u0eRNfvrfg
 +nobm053UGlTQnuKWpEoz0Hv/TXOgPQ2wFffWh6qgVDqScL1CB+kNcO60dHnd/X4i0DhF4szfFb
 yf3xuyw468ROPf/u9Xz0tq2zxTbFb6JAbSRkepRFPRnAG0tXfa6Txy9nXdTqUd+smNu+M7EcjGm
 wctSbx4z+DuopYolWLIGzYGzMu01NgOmfZynCBTWCgWRknc45+9iJP1VGSQKjJg7ALD1HSF5L2o
 =
X-Google-Smtp-Source: AGHT+IFwJz9TDWy5VXfQUGV8oZR8NDbvJTjJ5Lf2PboDSwEnKWrWihKY577y0Q82inynF+RjLXCbfQ==
X-Received: by 2002:a05:600c:3553:b0:43c:f3e4:d6f7 with SMTP id
 5b1f17b1804b1-43d850c9bddmr49203325e9.31.1743093094781; 
 Thu, 27 Mar 2025 09:31:34 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82f7c82esm42360305e9.37.2025.03.27.09.31.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:31:34 -0700 (PDT)
Message-ID: <b40c0037-33bb-44b0-bc24-f4cadc9f5d1d@linaro.org>
Date: Thu, 27 Mar 2025 17:31:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/29] efi: arm: Omit the ARM start-up code in the EFI
 app
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-19-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-19-sjg@chromium.org>
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



On 2/15/25 04:22, Simon Glass wrote:
> This code is not used with the EFI app, since it enters through a call
> to efi_main(). Remove start.S and crt files from the build.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
> (no changes since v1)
> 
>   arch/arm/Makefile     | 2 ++
>   arch/arm/lib/Makefile | 6 ++++--
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index cb87a684754..2e569b330d0 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -104,7 +104,9 @@ PLATFORM_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs))
>   
>   libs-y += $(machdirs)
>   
> +ifndef CONFIG_EFI_APP
>   head-y := arch/arm/cpu/$(CPU)/start.o
> +endif
>   
>   ifeq ($(CONFIG_XPL_BUILD),y)
>   ifeq ($(CONFIG_SYS_SOC)$(CONFIG_SPL_FRAMEWORK),"mxs")
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 14e3990925a..9500ba6fddc 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -7,19 +7,21 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o \
>   				    lib1funcs.o uldivmod.o div0.o \
>   				    div64.o muldi3.o
>   
> +ifndef CONFIG_EFI_APP
>   ifdef CONFIG_CPU_V7M
>   obj-y	+= vectors_m.o crt0.o
>   else ifdef CONFIG_ARM64
>   obj-y	+= crt0_64.o
>   else
>   obj-y	+= vectors.o crt0.o
> -endif
> +endif  #  CPU type
>   
>   ifdef CONFIG_ARM64
>   obj-y   += setjmp_aarch64.o
>   else
>   obj-y   += setjmp.o
> -endif
> +endif  # ARM64
> +endif  # CONFIG_EFI_APP
>   
>   ifndef CONFIG_XPL_BUILD
>   ifdef CONFIG_ARM64

-- 
Caleb (they/them)

