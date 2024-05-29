Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F01C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 05:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1596387F3F;
	Wed, 29 May 2024 07:33:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rE6PjYbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29E3C87F33; Wed, 29 May 2024 07:33:15 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC548857C
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 07:33:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-48a39b54e22so583600137.3
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 22:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716960792; x=1717565592; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/pNJ6JiRB5CiMQ2kbPTYEz5ZAn3vWj1i4ThL7npZjYI=;
 b=rE6PjYbSQzaFjEAifbb0r+W1bpIDQfI898m+mztLDrbwpC1OlrSMCNRoWret3dObC9
 OpOUeEtdtGFa78UNC4hlrZw8bINrclHVVilk10KUW92dCxko51Loy0axHpYR8SMfimcP
 1cbFokbHArYG/UEfpZz0QTciMd9kzykW6fQYRHX2BwoWuBIcJjVn6e/spQqdh22TcWHR
 p9xPZH8bz6GeczP4nac0iT0YQBOVm0PT6oUc6gTRtKnWarhfjqcf+sJEvgxpazil9oBf
 Sk5/+4QwnnYmC1GY4+SrCzGMYuViJC7LcsVgiCGVgKjHJef8Of5pMBL7mvWXhP6LOeX+
 WkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716960792; x=1717565592;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/pNJ6JiRB5CiMQ2kbPTYEz5ZAn3vWj1i4ThL7npZjYI=;
 b=oUscRtjgqL1AzHy9WyP4YW4mthRvtDzHahYkbHyNEc/bpPwFNxikZAlukk+WyD2v34
 +R8TeW+DCfiLGc9LqqwfPuo0vyUGsZHXvG+NPRSzUsFdQJ01xj1WUbmhr99Tae0N4/gv
 U+lIsZZjILIQKr/M+eYV01hpc6erg4oi3OuWI8EnqDp+xG7xEqxGuNyKbtsIKWlh00yW
 XYZqDGcqDjTuJ2LkgdSzyiLyoc/pj10DQKTFHiBJ9P6t1uHU+lEgecwKJs3SMIOmHb1M
 VhHFKxRFPs3xH4auhjmH4iEDk6tQAysEhlQq7105ARhyppO1zRbdvft/yyBTf5MAG+jU
 XSmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKlR8+inmZq6f4VUkt8pqFA5rr1MjuQyXTsrkehAMcmXBIv1lwaY0kxoDcHXR5Qd1/XDO4kHKnh1VrXgJxh8TD0SK/ig==
X-Gm-Message-State: AOJu0YyLj0+Y3/+y3L5zbYJ80+KMVp3Ylb4QyUsMX6CF83lrFx0IRdOi
 7aK6cl26eWx5ypKMUavBzKo8Dw4Bm48nL92eaUeX5xOsM5LwpTyq2JsDjwHsHLlzIvaTYS1UrVL
 ii6W5f6//1t8ld9WrKWppxU0moD441Y2b35emMQ==
X-Google-Smtp-Source: AGHT+IHZ8WxoQXvxw6AoXzQh8GiFD07JV0s555erOK9nu3GiF224BCgpME7iYahoB4QnVrd0qWT/d/VXXa4pth3hVnE=
X-Received: by 2002:a67:ec4d:0:b0:47b:6d0b:e893 with SMTP id
 ada2fe7eead31-48a386a4939mr14516747137.28.1716960791710; Tue, 28 May 2024
 22:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240528-topic-sm8x50-pinctrl-pinconf-v1-0-54d1e9ad7dfa@linaro.org>
 <20240528-topic-sm8x50-pinctrl-pinconf-v1-1-54d1e9ad7dfa@linaro.org>
In-Reply-To: <20240528-topic-sm8x50-pinctrl-pinconf-v1-1-54d1e9ad7dfa@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 29 May 2024 11:03:00 +0530
Message-ID: <CAFA6WYPA1a7F52VKpwnS4cFQ_wbYk5niz6mW48u21rB4TqVc1Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] pinctrl: qcom: add support for bias-pull-down
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Neil,

On Tue, 28 May 2024 at 14:02, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> Add support for bias-pull-down as an alternate of bias-pull-up.

nit: s/alternate/alternative/

>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcom.c b/drivers/pinctrl/qcom/pinctrl-qcom.c
> index 3c3336e7635..4f4e9a83949 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcom.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcom.c
> @@ -44,6 +44,7 @@ static const struct pinconf_param msm_conf_params[] = {
>         { "drive-strength", PIN_CONFIG_DRIVE_STRENGTH, 2 },
>         { "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
>         { "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, 3 },
> +       { "bias-pull-down", PIN_CONFIG_BIAS_PULL_UP, 1 },

Did you mean PIN_CONFIG_BIAS_PULL_DOWN here instead?

-Sumit

>         { "output-high", PIN_CONFIG_OUTPUT, 1, },
>         { "output-low", PIN_CONFIG_OUTPUT, 0, },
>  };
>
> --
> 2.34.1
>
