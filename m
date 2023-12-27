Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77A6C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 11:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41F4187837;
	Wed, 27 Dec 2023 12:12:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JHl3WClO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEA7A8795F; Wed, 27 Dec 2023 12:12:48 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9EC8875C5
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 12:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e741123acso2596463e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 03:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703675566; x=1704280366; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=avpX313uus4YmAQ8ucXPDwPQvHYIGxUcYLLy/VoExZA=;
 b=JHl3WClOw9aisPgDFDpBNlSTzqh/d6+b4Bz8A+GNRVLljW9uGahMHxKi7eMoRYrQw4
 6Sn/+aYHZ6+zWp0K2jlU6DFrvYVYn/RNrcWl5KVnXeHy190JANPm2xYgRJ47fp/58JPU
 BETworiW6Aj+ty00xWE60oIO/RS42RsI5DiRDYHflmcYSZ+2ku16ZM+P+18vPcYwghCl
 fGWr9YKHyFVljFltjfsK6arBjvbifpGD7vz7ClrIPBr/tfZx8LKvDV6Gb7618e5SsMCB
 fbUQG0dSax/gq1yvR91Kk5D+Fuxhv1vl5Q/U06453kN6XA3gKbWnTDed/vLB/r79y5fw
 +3eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703675566; x=1704280366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=avpX313uus4YmAQ8ucXPDwPQvHYIGxUcYLLy/VoExZA=;
 b=c/HLTuZGPjxSle42yUPUQtf5klWhpD/fNXlBWMXRb62urepUi1b1eB86zGN5jR1RKt
 eqhQUqBuN0NNxWR96oTNgBc85yPbo2HwsmtJZAmJYKabpQ+QwgkkoSAhpZJPVWct0xH7
 /cIbGDtc6NpXHPLJ03hiv5rMD44PbDDGx8ZSFJSaT27dE0W1tyRALv0e/Fl4xtZDgR5m
 qBcosMH8yNRpCfY+ehJBBWalUTLsM76aSkQRxiVfJMy8o8MSIS4l4x7pRvWu6E90GxcA
 bM7AhmawdqMfz5VImeKqVUJNuRSEQABKsdK6s0DKpLSIvrTNTtNIshesRU6K2Z4hPbRo
 JqVA==
X-Gm-Message-State: AOJu0YwHc0qokT1+5Q7yNd909dR4C8XD+yk5V241ceh1uG97qiIG1Eld
 8fQDp9VH+GGW1hpox43ub2qBI6PT32HRYnsbnN+VrkukVVkoIycX1HMNXa3B
X-Google-Smtp-Source: AGHT+IEDnk62qRFPmaVIohisDO9cl7GqLbbcfwd+NNRasO4Z0+AFScoipEB6VE3oX9oDFaZZufhRlpYuCThb0S26o/g=
X-Received: by 2002:a05:6512:3ab:b0:50e:70b4:79d2 with SMTP id
 v11-20020a05651203ab00b0050e70b479d2mr2151206lfp.41.1703675566242; Wed, 27
 Dec 2023 03:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20231227074025.2178825-1-sjg@chromium.org>
 <20231227074025.2178825-8-sjg@chromium.org>
In-Reply-To: <20231227074025.2178825-8-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 13:12:10 +0200
Message-ID: <CAC_iWjK1pYu7YnQ09V3V=dngtOFpwFd3jFFA_+hkO=Zd7-oR9Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] smbios: Require the caller to align the SMBIOS
 table
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Simon,

I commented on v3 as well, but in case you miss that

On Wed, 27 Dec 2023 at 09:40, Simon Glass <sjg@chromium.org> wrote:
>
> All callers handle this alignment, so drop the unnecessary code. This
> simplifies things a little.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v1)
>
>  include/smbios.h | 5 +----
>  lib/smbios.c     | 2 --
>  2 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/include/smbios.h b/include/smbios.h
> index 77be58887a2..879b8a814b8 100644
> --- a/include/smbios.h
> +++ b/include/smbios.h
> @@ -258,12 +258,9 @@ static inline void fill_smbios_header(void *table, int type,
>   *
>   * This writes SMBIOS table at a given address.
>   *
> - * @addr:      start address to write SMBIOS table. If this is not
> - *             16-byte-aligned then it will be aligned before the table is
> - *             written.
> + * @addr:      start address to write SMBIOS table (must be 16-byte-aligned)
>   * Return:     end address of SMBIOS table (and start address for next entry)
>   *             or NULL in case of an error
> - *
>   */
>  ulong write_smbios_table(ulong addr);
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 7f79d969c92..cfd451e4088 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -563,8 +563,6 @@ ulong write_smbios_table(ulong addr)
>                 ctx.dev = NULL;
>         }
>
> -       /* 16 byte align the table address */
> -       addr = ALIGN(addr, 16);

I think this is wrong.  It will break SMBIOS on a user error. I am
fine replacing that with a check instead and error out if the address
is not 16b aligned

Thanks
/Ilias
>         start_addr = addr;
>
>         /*
> --
> 2.34.1
>
