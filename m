Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392ACC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 01:25:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F08E87720;
	Thu, 11 Jan 2024 02:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BImEAN1h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BAEB86406; Thu, 11 Jan 2024 02:25:38 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4178F87720
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 02:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bc4f49a3b6so5238137b6e.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 17:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704936334; x=1705541134; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWKjTeuug3bkJ3sLrdZ73R68PBFSJsOVm5vY5YUa3vE=;
 b=BImEAN1h9xURjftylf77YPWVvdXeQoXxx/wOnqXwdyDj8w70uHyDZ2z3mJoKZvml73
 hwAuc/uwIpvPqwE7pW3ryIWw3HPZpX1dGh6AicmOrsDxm4FeSUlGMr1s+qZQH7/rdBLm
 46b226pv0QLXgN9yvdo7hXiYs2zmlqVLxkJqeWK5R6D7KL8BTChfFKOVWFzHyVoCMrke
 YGHL7YAHTUcU66qVK1Q/qipXeGfbNXd2aG2cDezB2t4o2vvZSihyQNUqAR4GqyGAolUk
 AoP2e9rVpiTEQd1sNiWwS0M5y95pKG+p5kltyROWBjwpob8D0Omd7hVpYOLj34cIHww9
 87UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704936334; x=1705541134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWKjTeuug3bkJ3sLrdZ73R68PBFSJsOVm5vY5YUa3vE=;
 b=pL8D63d1ELG9+w7lsCKNoeTXgXbX6BWAQvs7nwdjzcFtiTpNQNi5e4J+J/j7oM+u5R
 rzS4zvKNhCs9uERuOgBghmb6ZCfJlb2RHnItjdaji4gzqw/8pZKxFvrB0JJl39nnDSHL
 Kkrv7guF8Oc9VQ8KfH+e3ekl3kn7nz9mx26AnkVdFKI0+ZCv4hs8asszKmrBBsVrhq7b
 qGcGbES5+M+OS27nVh6FOjykuvq/fZqZW8RADqwWoKOD2I5jpUZCO5giAqsVfQ82A/ea
 v+TCNaQ9g6YLjZGeflMoEflV1zayYS08r1kiH0CxwHxNPFi1dnHaj1zvZMco7ZQwGsW7
 g+bQ==
X-Gm-Message-State: AOJu0YyROMb0aNXAjPhL9u3or/bc2lAQlYOBqKrij66ToDUoAPicppNO
 py0lKDLRyvjhVhlupjpKxIeLUO0XB7x3LPtogM1ZZj1CnSQoiQ==
X-Google-Smtp-Source: AGHT+IGrCcjXCHjeXEXSjzzhf0u74WDoIGhRA7yPpZ6+EcwOMudkFNS4UQdqAi2yMWo5nZ9PcdMqQcu28mrr6GsKM+Y=
X-Received: by 2002:a05:6808:2092:b0:3bd:31b2:d240 with SMTP id
 s18-20020a056808209200b003bd31b2d240mr665669oiw.14.1704936332417; Wed, 10 Jan
 2024 17:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20231213031646.28828-1-semen.protsenko@linaro.org>
 <20231213031646.28828-5-semen.protsenko@linaro.org>
 <CALrBrZ0_mxw1k=mg2NXNKWufMfzSh7J4Ku4OzJb3_OsB-JFOJw@mail.gmail.com>
In-Reply-To: <CALrBrZ0_mxw1k=mg2NXNKWufMfzSh7J4Ku4OzJb3_OsB-JFOJw@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 10 Jan 2024 19:25:21 -0600
Message-ID: <CAPLW+4kwXy58KUaDBPE_u4zCbtvhqrEo9RJYYAcrcjNZ9kCzSg@mail.gmail.com>
Subject: Re: [PATCH 04/13] soc: samsung: Add Exynos USI driver
To: Minkyu Kang <promsoft@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Dec 27, 2023 at 3:11=E2=80=AFAM Minkyu Kang <promsoft@gmail.com> wr=
ote:
>
> Hi
>
>
> 2023=EB=85=84 12=EC=9B=94 13=EC=9D=BC (=EC=88=98) 12:42, Sam Protsenko <s=
emen.protsenko@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>>

[snip]

>> +
>> +/**
>> + * exynos_usi_set_sw_conf - Set USI block configuration mode
>> + * @usi: USI driver object
>> + * @mode: Mode index
>> + *
>> + * Select underlying serial protocol (UART/SPI/I2C) in USI IP-core.
>> + *
>> + * Return: 0 on success, or negative error code on failure.
>> + */
>> +static int exynos_usi_set_sw_conf(struct exynos_usi *usi, size_t mode)
>
>
> The value of mode is same as usi->mode, but is there a reason to pass it =
as a parameter?
>
>>
>> +{
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       if (mode < usi->data->min_mode || mode > usi->data->max_mode)
>> +               return -EINVAL;
>> +
>> +       val =3D exynos_usi_modes[mode].val;
>> +       ret =3D regmap_update_bits(usi->sysreg, usi->sw_conf,
>> +                                usi->data->sw_conf_mask, val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       usi->mode =3D mode;
>
>
> This will obviously be the same value always.
>

Thanks for the review! Yes, you are right. This code was copy-pasted
from Linux kernel. So at the time I thought it was better to leave it
as is, for backporting reasons. But now that I look at it, this won't
be too helpful. So I'll get rid of it in v2.

[snip]
