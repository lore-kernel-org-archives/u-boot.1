Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA64C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 10:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 741FF82A4B;
	Thu, 12 Jun 2025 12:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HNVP6ivc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA9B82B70; Thu, 12 Jun 2025 12:42:09 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B73800C1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 12:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4533027c0ceso2862915e9.1
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749724926; x=1750329726; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=akKhKTQvvyHElMMF8GfVJfBOjRSWuZwAUT1WSgXj+n0=;
 b=HNVP6ivcHw3zbL8OMDb1Fv3cF9MudTb+FZKBN7xf/yLLFgJulcchotpT5zYweH3Uql
 KAom/8qgzqlC9nvgSv9Uix3uGJ07yag2GvlwSp0ms6NAG2Q1cfckVvj3kcv1FcAI7A9g
 cKFgDbXnJYFYNcSaiy+dh26syJtUerhepZPX8wDesA36NkweGC7iLPDMHBjyyotzue8O
 N/nVX890wNHKm8Et/4VsMyO3bMaqM4qhyMc1Mq0CR1l5Dw/8lbObjrKYXnbYmNw7OF3w
 6nlR1SB0oZb2T2lR/cgE37KuoFa4xoKcV5a0VyQSst0QrdGNQ+ZnRkNISnGH7bedJPMk
 y+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749724926; x=1750329726;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=akKhKTQvvyHElMMF8GfVJfBOjRSWuZwAUT1WSgXj+n0=;
 b=oNXepOKWOo9myQPIGAJiAionjfsPOh5pd1ZaHEs1holP3VFJkZyREgUbg2EGOaVtxj
 C9EHHH/S3A6xwVwaDyu3xX7nuQLjmyLSveM18OZjM6v7DIPPPL93pPCRSDsVS+3WCYDe
 gmdKcbzBNSDEj5Bo5Z8msJuJd65DhNcg8nm//qJ0dPKtMO50plXacRaJ6yuZzZ8El1k+
 up5lJFfU1Vlq+W+tbIHJf1GCRfkl8QIMSyWp8SrlhzZ7NNcTfl+lJK4oyTSXEYu7Zzwx
 N32UuddYh6C7Y1ZeuKKXh5qhQJi+U1XdVie5/6g82XOkz5g6KhAFEbZwDHwlOJITYVv8
 Nihg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCCiMYLlQaYxn1wYEm/CJamq7+H58WaaAwdUs4qCG2Uu5f/gXGBiGtS1DD532r/70l3VwKey0=@lists.denx.de
X-Gm-Message-State: AOJu0YyN4tqStPJtccStXQ7lOCLc4+RezXfG4zeR5tYivVIChLU74Lw/
 wGRQOaX9t3FsdrtEzb23X1RapU242vGBwD/ZDgYv+H8oUGJQq8ftjl4DYc9DhuqOglE=
X-Gm-Gg: ASbGnctLQny4Fkh9/Sux+Cu2tfvCw4eZxEwdJi15uCUs6ykdSai08LwqAjdwgE6u5s/
 cK1XW2BDf194/qhIFkytWMXeviXS30+BEgOGEB27gZ79LJCqvwgt29O+m0bMNnXhQ+VPpMhbv3X
 64Q4FZB4KvLwMCD1oa+Wj2mda1mmePdV4RQd01F7goz0DdxbgnHCWAwjvTNZb4e4HLbeDrhLIPr
 yFnxo8IhCdqR1jLNEpx8WAvfydRXyk4K1xneXBIKPLPQRtJTiqlWFhybvpgBpnkxqdYEWvwsjt6
 1r2C/v+IGfNpILhesBuGaI7EDVnLliisMyi+zajhvIyfwbBy/t/HY53n34Jj57/fFftFwDW8Cdq
 T6hbKoxvY6okiONrh7Q9/vmQIFT9dF3G3Efmz0g==
X-Google-Smtp-Source: AGHT+IFFqRNlV7fENkFnQlJ56SmktAgwDoZxY02t7oDKLuOqZnuxsT2LnKqZX++wtrZqwW/D/uSIcw==
X-Received: by 2002:a05:600c:3e84:b0:453:a95:f086 with SMTP id
 5b1f17b1804b1-4532b8c2bd7mr35222325e9.12.1749724926242; 
 Thu, 12 Jun 2025 03:42:06 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:1405:203b:89a3:c77a?
 ([2a01:170:117e:fc:1405:203b:89a3:c77a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532de8c2d2sm17414155e9.1.2025.06.12.03.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 03:42:05 -0700 (PDT)
Message-ID: <b53b821b-95e2-4887-a837-cc3e3236cd27@linaro.org>
Date: Thu, 12 Jun 2025 12:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix variable name of msm_clk_data in two drivers
To: Luca Weiss <luca.weiss@fairphone.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250611-qcom-clk-variable-names-v1-0-37615b74daad@fairphone.com>
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



On 6/11/25 14:08, Luca Weiss wrote:
> Just some fixes with no functional change.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Thanks :)

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Luca Weiss (2):
>        clk/qcom: sc7280: Fix variable name of msm_clk_data
>        clk/qcom: sm8250: Fix variable name of msm_clk_data
> 
>   drivers/clk/qcom/clock-sc7280.c | 4 ++--
>   drivers/clk/qcom/clock-sm8250.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> ---
> base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
> change-id: 20250611-qcom-clk-variable-names-0cb615817b3e
> 
> Best regards,

-- 
Casey (she/they)

