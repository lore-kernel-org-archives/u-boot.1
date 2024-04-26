Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96741C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 109C8885AE;
	Fri, 26 Apr 2024 16:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mL95mvbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40611885C1; Fri, 26 Apr 2024 16:30:43 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75ED3885B4
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso309932866b.2
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714141840; x=1714746640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cBdRNFG20vbkGwAnyhpfObqkcwzf8jPk9V5XGXcUZRc=;
 b=mL95mvbYGF1jpIfUAGcWA2lZ5wK1dOrL+QPwZ0CWf+TCdnynzKtWOYP3MD9gFxog0X
 1HGfEmrDoWhyi/Er6rhfm5JMnZ+r7s6ZQC10pk2TRWfgoxrHv1fZbTwszDh9vifVSvJo
 kUVnB9csHeykLBRdxHjZgIb8RzLOGHSL68RXd5f3GEnRxdOliC/ub1ZVBE5LGARrwIq5
 UoLNE2Iy+5hWBiFrAvwjoakQNy1A+iB8ELRlnDaE4yGqjkWFvZdo2IUbhBxze/RaNxRU
 cIhQGYcnXJDdsFpS6ohzISSr++6fEx3AubXmGcgUbS2Z2gzAUISBm27wmODet0iKp/8X
 ikEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714141840; x=1714746640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cBdRNFG20vbkGwAnyhpfObqkcwzf8jPk9V5XGXcUZRc=;
 b=wbmYv9qTpntDYSDIjouS37B+Duj6bWHrlcAK95UlRQo0mBGgDS4qQ07tsLEbHaOBSt
 v9CJQsrkxYFdts9MRGDBrhNi7pU0W2yQ4QXLlWst2rWgg47XtpmduDpinljDmFUq+ffN
 07iUsAiVcUKLL5qm6Jl3D5jrqDxVas+DKa6c/vBKaBITnOPnD+Bw0UAlIozeXjdEz7vv
 l/w8bvXyALyFSo1iFKKJ1cDeTG6pHRjju/ZcgsD59cFRu5woEJEcoRqINZQhF976O5T5
 ZSMnbAHVOtg2q/gHfl4bl71mPNYZVzQHK7AmLcQI3ZxyK8UjXav2bPR3Cn92Pl0K8FSf
 wKzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpiixP8f1Udm3rswZ74vAtk+QnNPmsTe3UxijTCqHPJ2E7Iglt1k6sjwyE6XdGVaG1MYW6W1lf/GcCLr59YRxW1r8Gcg==
X-Gm-Message-State: AOJu0YyRSBJtH20BETJiC5YigOwxZbucp9mmBsuHdZa/vYfObRyn8yzf
 gCNip9vU3wwQT+63+GneUoIdc7qkU4Mo4DazQWg02gGrrC9n9gKHo3x2/ujZ+98NuvOSOU5GccE
 RR+BPyyYxr48YgLAnCIEu6i9+iOcUDFYIK6c9Vg==
X-Google-Smtp-Source: AGHT+IE1mmATu5F2Ts2Qic89nZJ6qVil1HaccUPg2gnjB2XEBqDZNbC1JRHQt/8ha9kYv1uNjR3dk25bXpBxW8uUNpA=
X-Received: by 2002:a17:906:2416:b0:a52:19ea:8df0 with SMTP id
 z22-20020a170906241600b00a5219ea8df0mr2298350eja.66.1714141839908; Fri, 26
 Apr 2024 07:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
 <20240426141321.232236-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240426141321.232236-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 26 Apr 2024 17:30:03 +0300
Message-ID: <CAC_iWjKg9NDKnoNa-V+H+5OOJe2uYsHb0vXM0+-QdCxUctiksg@mail.gmail.com>
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

Hi Heinrich,

On Fri, 26 Apr 2024 at 17:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Provide a function to append a device_path to a list of device paths
> that is separated by final end nodes.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_loader.h             |  3 +++
>  lib/efi_loader/efi_device_path.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 9600941aa32..a7d7b8324f1 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -944,6 +944,9 @@ struct efi_load_option {
>
>  struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
>                                        const efi_guid_t *guid);
> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
> +                                    efi_uintn_t *size,
> +                                    const struct efi_device_path *dp2);
>  struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
>                                       const struct efi_device_path *dp2,
>                                       bool split_end_node);
> diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> index 46aa59b9e40..16cbe41d32f 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -270,6 +270,37 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
>         return ndp;
>  }
>
> +/**
> + * efi_dp_merge() - Concatenate two device paths separated by final end node
> + *
> + * @dp1:       first device path
> + * @size:      pointer to length of @dp1, total size on return
> + * @dp2:       second device path
> + *
> + * Return:     concatenated device path or NULL
> + */
> +struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
> +                                    efi_uintn_t *size,
> +                                    const struct efi_device_path *dp2)
> +{
> +       efi_uintn_t len, len1, len2;
> +       struct efi_device_path *dp;
> +       u8 *p;
> +
> +       len1 = *size;
> +       len2 = efi_dp_size(dp2) + sizeof(END);
> +       len = len1 + len2;
> +       dp = efi_alloc(len);
> +       if (!dp)
> +               return NULL;
> +       memcpy(dp, dp1, len1);
> +       p = (u8 *)dp + len1;
> +       memcpy(p, dp2, len2);
> +       *size = len;

Can't we just use efi_dp_concat()?

Thanks
/Ilias
> +
> +       return dp;
> +}
> +
>  /**
>   * efi_dp_concat() - Concatenate two device paths and add and terminate them
>   *                   with an end node.
> --
> 2.43.0
>
