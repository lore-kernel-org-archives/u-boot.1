Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B347D44D6A
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 13:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF26B891D6;
	Wed,  6 Nov 2024 14:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UcaLIEtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43DF6891D6; Wed,  6 Nov 2024 14:51:08 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4308888CA2
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43162cf1eaaso78911975e9.0
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730901066; x=1731505866; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J8fhjsBO5i/iVrvfARPcSjJU2yF9VFPQ/eQY920tskA=;
 b=UcaLIEtB+EAtKDIrNOORSMvmi27I5vJ+snfPgv5/IOg5qtShVrMwKjrObwlhOLQ/hL
 BcuK+fT+WILVbzbzeIPDz9K5Riu7jmZKpOkOYNaC+afJM6dkfi7OuEWpchK2MF+8raug
 vKH/Q7AH73UcOjhj5KIABfpj7j9jGSRO3zXiCgjtPGTGq0UG+nfMnpcT5uEdD0/5J5Vv
 03dAgJ6FG/JptTrxp/KNBgjbh0XEgVb1pmWW8cls04KOWc2gq4vFZZ/kKWnHRZx44qq/
 Oey2VgZUdGJGTWEiDikLeuX+SXZ0WaXgrHenMC3Bz8WP4/D5XgvmQbSaUeQpWGAHcqfB
 Xxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730901066; x=1731505866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J8fhjsBO5i/iVrvfARPcSjJU2yF9VFPQ/eQY920tskA=;
 b=EW657L6IQJSnrojCQ2WcTo5ceneVI/PrU6N9+t7Qj5+RtThK2xW0CtrxYdbTCzTGkw
 VMI3Bgv374eUd9CIvL3q01CXjI2GJP675khZggWgQUOrQnsuaM8+kVtajTtcdCE083ft
 YJTW4owtUHDiW0o7ybGv9m6sHD9jQsRyMpGDMihB+6kes4lNanLg4GQGz33acH0S8P6O
 mL7H3e/1u10C5BpOorRv51dtpcGQ4Zof/wahKKdXno2HtIpNjgVoR5m6Qrmb5f9CnxM5
 gawGlbsMUnhoSFv/O3me4mUSBe/c+hhgMOf0hVxCc5LI+5o1AmtcmqPJIZOtc6GTEgVj
 Z33Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Ikbijr9ZbmveufXdUi3tEtcZoX9hMVNdzmYuXeaMoRvau4l5rvGoVOhbn5Q2yrTkHTjJTsg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyj3H3C4D4vQ8/AJsk5o9HWvXmQthDqc6Mt0PuE2AS9MhHKV6pp
 RU/AmgOMefP1Pdyb/Cjgfz9wnX5PHg2B9kAh7pYBuczgjHc8h8ESgtLyywY2toM=
X-Google-Smtp-Source: AGHT+IGMK+AvuukCeK5PjOvolOKQUabpSIozztKfjm4jUC3aIHHEC2jmMLPtff4pu40o/5irEVCQHw==
X-Received: by 2002:a05:600c:4455:b0:42c:b508:750e with SMTP id
 5b1f17b1804b1-4328324ae6cmr206695295e9.11.1730901065768; 
 Wed, 06 Nov 2024 05:51:05 -0800 (PST)
Received: from [172.20.141.182] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6ae615sm23200345e9.8.2024.11.06.05.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 05:51:05 -0800 (PST)
Message-ID: <7ee5b1a6-b2e3-4cc4-ae48-c306a76d8dd3@linaro.org>
Date: Wed, 6 Nov 2024 13:51:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] configs: Enable https for wget on qemu arm64
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-6-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241024112449.1362319-6-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
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



On 10/24/24 12:24, Ilias Apalodimas wrote:
> QEMU already has an lwip variant of a defconfig. That defconfig
> is also configured with mbedTLS by default. So let's enable the
> remaining config options to enable wget for https:// as well
> and test that codepath in the CI
> 
> Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>
> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  configs/qemu_arm64_lwip_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu_arm64_lwip_defconfig
> index d3d8ef16e668..754c770c33fc 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -7,3 +7,4 @@ CONFIG_NET_LWIP=y
>  CONFIG_CMD_DNS=y
>  CONFIG_CMD_WGET=y
>  CONFIG_EFI_HTTP_BOOT=y
> +CONFIG_WGET_HTTPS=y

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
