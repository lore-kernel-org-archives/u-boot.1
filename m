Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F733C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7CB8833D;
	Fri, 26 Apr 2024 17:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RYVOhqPF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E675488499; Fri, 26 Apr 2024 17:48:26 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9494B88300
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a55b93f5540so306069366b.1
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714146504; x=1714751304; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1/ByOszdTENFKCigGlzOw2hDHK1AfUHXzvSAHOZ0h+0=;
 b=RYVOhqPFXbs1Rb7uevAg/oSpNNXJ+zGNRqwzyEPpfqUT9yBVglVd0qSPFqRyh8N/Ys
 MaAtJOUYeIxfnXf0g0MMrFBmxJhayavSzGp47rQdmq2Slg1gWNBK1Ob5UB52kf/VqlKf
 y/zslvJLex7HV61LVJS6j/cMl+t0EpuKmVAxJlkeqCfu0c982ENJ+e6vHa0H3ci60ziU
 aKtMTaEthJrnZ9dOpoWvDDhNzH4F9Q3IZEq0JSmjTMxnMUuSOwTs40SmfKFuh/+N0Dmb
 d8q1p2yVaDWVCj61K60+wPx5QwX5xhUMzGsYCA199jQQ2ueGvuXqzR9U2Eqa3UNE+yax
 edzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714146504; x=1714751304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/ByOszdTENFKCigGlzOw2hDHK1AfUHXzvSAHOZ0h+0=;
 b=XnTtLUeXV6/Y01kwwWSnwj6dtdybDKOMRUqPi+SoOqHzlf89SEFN9owXkygrNhQKKL
 mxjJeEoA3QoVOOrdlomN1vw3rSTeC57ZcIdX6SANy2W6ALRbG+qa3oSXmIRucze+lAJi
 FDrmH6IQ87lk2sZjFXwtlGrB4hVBur8FHLIlWKuEr3qgkD1In9oF8OKLQ3naetYCV7Ir
 2EhequdtuN9Bm/XJbESXdpElpJQgC+UXsGxOVoNQ3kkBFx0pRkGR6tDMB0HFYjGUY/Ys
 HM40Ud6ohR9ZFgG6HZwnulerICe54he5zqTJ8ZVI3Z9ugehT623GdLkit44XAlJCLkzv
 borQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyjXsA5PCTy+HgnEZLvTx4h6jYfVQKaMizIL84YvUh/dBMfBSKgOPLy9cMHqWX7teTIpcPrTEZsn4zplkDyqIBtqglYg==
X-Gm-Message-State: AOJu0YzQ7XGMHDmp/FCf1ObrhPxA7HXvQf2EjIawFl4dSDqTmEjRCicN
 daYD5FmPcMsdF5tiXfl5fGn0Z9Bfby04X1Biqqamlb8xAQnE9JsWUIEK8MjnfC5aI4xdcWxYdpC
 +VwI39n4jZ1kgvo2LMRK/QnfI0N6C6u78QhMkFw==
X-Google-Smtp-Source: AGHT+IEB52zfh5q3xWvfAdJbcz9b9X9HyR3+lJ07YmqSfihVeaadkg81yWP0yGSPyMnqnw0+y8SOYEqfiAs53Wnrr/U=
X-Received: by 2002:a17:906:4151:b0:a58:7239:4cf2 with SMTP id
 l17-20020a170906415100b00a5872394cf2mr2086522ejk.52.1714146503960; Fri, 26
 Apr 2024 08:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-3-heinrich.schuchardt@canonical.com>
 <CAC_iWjKg9NDKnoNa-V+H+5OOJe2uYsHb0vXM0+-QdCxUctiksg@mail.gmail.com>
 <aac7887b-b123-4006-bbcd-4549e8e44a54@canonical.com>
In-Reply-To: <aac7887b-b123-4006-bbcd-4549e8e44a54@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Apr 2024 18:47:47 +0300
Message-ID: <CAC_iWjL4umEBcEkZtjeWgfnrHV3oB3qECD0xYAY6qjphKb4umg@mail.gmail.com>
Subject: Re: [RFC 02/14] efi_loader: library function efi_dp_merge
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
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

Hi Heinrich

On Fri, 26 Apr 2024 at 17:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 26.04.24 16:30, Ilias Apalodimas wrote:
> > Hi Heinrich,
> >
> > On Fri, 26 Apr 2024 at 17:13, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> Provide a function to append a device_path to a list of device paths
> >> that is separated by final end nodes.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   include/efi_loader.h             |  3 +++
> >>   lib/efi_loader/efi_device_path.c | 31 +++++++++++++++++++++++++++++++
> >>   2 files changed, 34 insertions(+)
> >>
> >> diff --git a/include/efi_loader.h b/include/efi_loader.h
> >> index 9600941aa32..a7d7b8324f1 100644
> >> --- a/include/efi_loader.h
> >> +++ b/include/efi_loader.h
> >> @@ -944,6 +944,9 @@ struct efi_load_option {
> >>
> >>   struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
> >>                                         const efi_guid_t *guid);
> >> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
> >> +                                    efi_uintn_t *size,
> >> +                                    const struct efi_device_path *dp2);
> >>   struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
> >>                                        const struct efi_device_path *dp2,
> >>                                        bool split_end_node);
> >> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> >> index 46aa59b9e40..16cbe41d32f 100644
> >> --- a/lib/efi_loader/efi_device_path.c
> >> +++ b/lib/efi_loader/efi_device_path.c
> >> @@ -270,6 +270,37 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
> >>          return ndp;
> >>   }
> >>
> >> +/**
> >> + * efi_dp_merge() - Concatenate two device paths separated by final end node
> >> + *
> >> + * @dp1:       first device path
> >> + * @size:      pointer to length of @dp1, total size on return
> >> + * @dp2:       second device path
> >> + *
> >> + * Return:     concatenated device path or NULL
> >> + */
> >> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
> >> +                                    efi_uintn_t *size,
> >> +                                    const struct efi_device_path *dp2)
> >> +{
> >> +       efi_uintn_t len, len1, len2;
> >> +       struct efi_device_path *dp;
> >> +       u8 *p;
> >> +
> >> +       len1 = *size;
> >> +       len2 = efi_dp_size(dp2) + sizeof(END);
> >> +       len = len1 + len2;
> >> +       dp = efi_alloc(len);
> >> +       if (!dp)
> >> +               return NULL;
> >> +       memcpy(dp, dp1, len1);
> >> +       p = (u8 *)dp + len1;
> >> +       memcpy(p, dp2, len2);
> >> +       *size = len;
> >
> > Can't we just use efi_dp_concat()?
>
> efi_dp_concat cannot be used to put a device-path end-node in between
> two device-paths that are concatenated. We need that separator in the
> load options.

I am not sure I am following you. It's been a few years so please bear
with me until I manage to re-read that code and page it back to
memory.

What I remember though is that the format of the DP looks like this:

Loaded image DP - end node - initrd GUID DP (without and end node) -
initrd - end of device path.
So to jump from the special initrd GUID to the actual DP that contains
the initrd you need to do an efi_dp_next(). Also, efi_dp_concat() will
inject an end node with a DEVICE_PATH_SUB_TYPE_END type if the third
argument is 'true'.

What am I missing?

Thanks
/Ilias

>
> Best regards
>
> Heinrich
>
> >
> > Thanks
> > /Ilias
> >> +
> >> +       return dp;
> >> +}
> >> +
> >>   /**
> >>    * efi_dp_concat() - Concatenate two device paths and add and terminate them
> >>    *                   with an end node.
> >> --
> >> 2.43.0
> >>
>
