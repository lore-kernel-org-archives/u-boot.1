Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44E1C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E7C0877A1;
	Wed, 20 Dec 2023 13:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jYCiEKSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8BE9874D5; Wed, 20 Dec 2023 13:55:02 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661D087600
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 13:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50e558e16e7so340908e87.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 04:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703076899; x=1703681699; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sAJbfHQCZYXu8fk6eohVIqnOKoJ0IgXNifbLuZz5qPI=;
 b=jYCiEKSuzxW3N2/EVmkODY7yOAI9rv2SyLnrchMbXllXcsGyiTN/ReNEDVIFdI8tYy
 lif5LplD9YkMncBbHAF03XScvBTzwtlITClErlMpPjbZlgYcP6hWNn+OS8utGLJfwol/
 CaVqW9+BBZ7dniH6U0qciTBavktj73WPol+5hRg6JSByuegneoGcY0WDyEd8TV30CfI2
 /L0UWr4W5cML/nAvmGfQ4R8ZlSeTmkh6UEiNmzHhSa4QA8+ALBpDU1U2FJxQyqtPh3L9
 T4bvVhl+fKbXqfN6EUH63q/05vZwQMY7XkwebZL7HYjSTEtWhEW6KRrSl4EoFKEB46VR
 tNEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703076899; x=1703681699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sAJbfHQCZYXu8fk6eohVIqnOKoJ0IgXNifbLuZz5qPI=;
 b=GwzROoMkiqZy+/XzIULH0MnlZucHBsNLl6UsDesNYOthTrUsSShgvUieeUpk5Ys42C
 U6IIy7HjfQFV0HDn9mwU4yXQypbzPuRwfKGbq2ZZd2OXCKo2T+qqMzDOEf9kIysKrXMk
 8wZKUy51jLp0jIKOoOXDyggInckG7U+IpczSgC5hz2ZDnTfW4QkKO46pa59Mz49oOzGc
 95lXu+aGmcOcNo0bpd/op6E2162eTU/bDM8dsIe6d2KWGtNBOspLbKQ3DH1tPmxxZRoK
 D9Yj5lgStg0t3tUZqyPwEuUkLXueCcUAWd1FAZfOyx96SHQNe9TspsVUij0f/qv3caGU
 6tJA==
X-Gm-Message-State: AOJu0Yw7m+CwwPdJNSO4a1DSGaZEAYHxy9Hlih+XrfsHJj0Fodap6xPP
 IhWIVIclOrR6yFfy3+70XLNnNArmu5ug3vIuAZEIfw==
X-Google-Smtp-Source: AGHT+IE3wz/tI6Rvxh8SDq522GINGR7JcRFjM9A+t/19hoa1Id+iPeQZyspsMOUyT7CO6i/nClFb1f2YVFqxxiwyd/I=
X-Received: by 2002:ac2:5b03:0:b0:50e:3879:8222 with SMTP id
 v3-20020ac25b03000000b0050e38798222mr1585439lfn.21.1703076899384; Wed, 20 Dec
 2023 04:54:59 -0800 (PST)
MIME-Version: 1.0
References: <20231219211114.393193-1-raymond.mao@linaro.org>
 <20231219211114.393193-2-raymond.mao@linaro.org>
In-Reply-To: <20231219211114.393193-2-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 20 Dec 2023 14:54:23 +0200
Message-ID: <CAC_iWj+Ld1Tpw4pyZ1P=GS6We_+CfUFvDC7HmDTug4x2fDmMFw@mail.gmail.com>
Subject: Re: [PATCH 1/5] bloblist: add API to check the register conventions
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
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

Hi Raymond,

On Tue, 19 Dec 2023 at 23:11, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Add bloblist_check_reg_conv() to check whether the bloblist is compliant
> to the register conventions defined in Firmware Handoff specification.
> This API can be used for all Arm platforms.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  common/bloblist.c  | 15 +++++++++++++++
>  include/bloblist.h | 12 ++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 625e480f6b..232ca4c6ce 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -542,3 +542,18 @@ int bloblist_maybe_init(void)
>
>         return 0;
>  }
> +
> +int bloblist_check_reg_conv(ulong rfdt, ulong rzero)
> +{
> +       ulong fdt;
> +
> +       if (!IS_ENABLED(CONFIG_OF_BOARD))
> +               return 0;
> +
> +       fdt = (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> +
> +       if (rfdt != fdt || rzero != 0)
> +               return -EIO;

What is rzero supposed to be doing here? If its only valid value is !0
why arent we checking it earlier?

Thanks
/Ilias
> +
> +       return 0;
> +}
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 84fc943819..b5d0f147f6 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -461,4 +461,16 @@ static inline int bloblist_maybe_init(void)
>  }
>  #endif /* BLOBLIST */
>
> +/**
> + * bloblist_check_reg_conv() - Check whether the bloblist is compliant to
> + *                            the register conventions according to the
> + *                            Firmware Handoff spec.
> + *
> + * @rfdt:  Register that holds the FDT base address.
> + * @rzero: Register that must be zero.
> + * Return: 0 if OK, -EIO if the bloblist is not compliant to the register
> + *        conventions.
> + */
> +int bloblist_check_reg_conv(ulong rfdt, ulong rzero);
> +
>  #endif /* __BLOBLIST_H */
> --
> 2.25.1
>
