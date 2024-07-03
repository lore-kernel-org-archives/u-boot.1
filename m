Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3CAC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 07:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D847C88249;
	Wed,  3 Jul 2024 09:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CCqslOSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 460148838E; Wed,  3 Jul 2024 09:40:22 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DECF98811A
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 09:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c980a9fe88so105637a91.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719992418; x=1720597218; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E48P8ZWqeOrjlI1DE1iq7okZwU9HRvLVH7QAlZlK/sg=;
 b=CCqslOSkKK4XGDM17CoipzGzpfF3bz+2HsI6m8YV30AxEUw23IAJGvzoXUHkQZi/Gc
 +kawP5XJEXTCM353tJ3/y4066QxPSmUqn0WR5Bi+b2zF/OXcZQI8Rso5RS5IwIkDEOw2
 ggFIsc7gK1XAoBUPtyNiMrSZzSH4I27QdtswMq9DGOxaiQ9uBzcP+QyBG5vZ+nzwyFSP
 N4LtmyTpDcfBfP8l1JH/2niyQOO+oNO8E57mexJapfwo8+OaigJAlyBnY8IKgPZjUW8u
 L+RApoksIH80OjQ9QFFaNYVEkHDntUBp+D2+9rZWxvT9fzHkfFoLCZKNxSSq0jHsfUWe
 JROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719992418; x=1720597218;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E48P8ZWqeOrjlI1DE1iq7okZwU9HRvLVH7QAlZlK/sg=;
 b=szxDZ1ZTzObgkK/S/3qlN5BAUyiOJ/EjiimmwiuhCLk+EXGdWfaYZ0Q8EvVUfE0NEn
 hJY38D6nQPIc34u6qgZ6waBBb4jfRw85hGcWFxpox9S2D3QDkbuXkMAu8Uy8MyWcdgOs
 rFhfdPjexetcUNuGZuTLFvi9sLyUnjJhnyoRtnTjp4E1NsRb71k4y7kv+LjOCZKIuTY3
 RNTaNP9z2S7bmHkWsZeyI2TfCNV9uPL/kZwj1BXg8JW9jAxSMqq2uGpEVo7q/LGNCAMe
 esfujBnqgnxK8OLHMVrhBLM5ep04ffZ6V6PyrEHOoLJWpi3lRDPXkCow+UBeOZ/LvxAu
 vb5Q==
X-Gm-Message-State: AOJu0Yyn2gfmOqC3kQHeIPMhxr8Ndq7Cw2FOoMsBIsYUqfEictErVayH
 ZcoCYqT6nr0vvXcr0ssnPF2g8c/k5eNYHWlb/hzs7SzOX/krXuRnTKsLWqqIkD6ZYdn2jz48sp5
 MxpS3l7rSNd+rNYIgOi3CvYgRTgsLgoOS3AQIeVIaf2momHm/qPh79w==
X-Google-Smtp-Source: AGHT+IG+l2dOyuFROiMAHiJHAfGXbPhh0O0Av+3w7bNowFY6bJOyXDh0aN2q15+xQsbAGEBfMvdBpCqSkSiIeCT3xE4=
X-Received: by 2002:a17:90a:38e5:b0:2c9:74af:62ef with SMTP id
 98e67ed59e1d1-2c97ad03be5mr1560375a91.10.1719992417075; Wed, 03 Jul 2024
 00:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-7-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-7-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jul 2024 10:39:40 +0300
Message-ID: <CAC_iWjLaXO3er64fviAqSPMVfa1bJDh739BFqVa8=8ov3JkV3A@mail.gmail.com>
Subject: Re: [PATCH v4 06/29] sha1: Remove sha1 non-watchdog API
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Ilya Lukin <4.shket@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Tue, 2 Jul 2024 at 21:26, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> We don't need an API specially for non-watchdog since sha1_csum_wd
> supports it by disabling CONFIG_HW_WATCHDOG and CONFIG_WATCHDOG.
> Set 0x10000 as default chunk size for SHA1.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v4
> - Initial patch.
>
>  board/gdsys/a38x/hre.c |  2 +-
>  include/u-boot/sha1.h  | 12 ++----------
>  lib/sha1.c             | 13 -------------
>  lib/tpm-v1.c           |  2 +-
>  4 files changed, 4 insertions(+), 25 deletions(-)
>
> diff --git a/board/gdsys/a38x/hre.c b/board/gdsys/a38x/hre.c
> index f303793b63b..06856ea36d3 100644
> --- a/board/gdsys/a38x/hre.c
> +++ b/board/gdsys/a38x/hre.c
> @@ -166,7 +166,7 @@ static int find_key(struct udevice *tpm, const uint8_t auth[20],
>                         return -1;
>                 if (err)
>                         continue;
> -               sha1_csum(buf, buf_len, digest);
> +               sha1_csum_wd(buf, buf_len, digest, SHA1_DEF_CHUNK_SZ);
>                 if (!memcmp(digest, pubkey_digest, 20)) {
>                         *handle = key_handles[i];
>                         return 0;
> diff --git a/include/u-boot/sha1.h b/include/u-boot/sha1.h
> index ab88134fb98..36c3db15e22 100644
> --- a/include/u-boot/sha1.h
> +++ b/include/u-boot/sha1.h
> @@ -39,6 +39,8 @@ extern "C" {
>  #define SHA1_SUM_LEN   20
>  #define SHA1_DER_LEN   15
>
> +#define SHA1_DEF_CHUNK_SZ 0x10000
> +
>  extern const uint8_t sha1_der_prefix[];
>
>  #if defined(CONFIG_MBEDTLS_LIB_CRYPTO)
> @@ -81,16 +83,6 @@ void sha1_update(sha1_context *ctx, const unsigned char *input,
>   */
>  void sha1_finish( sha1_context *ctx, unsigned char output[20] );
>
> -/**
> - * \brief         Output = SHA-1( input buffer )
> - *
> - * \param input    buffer holding the  data
> - * \param ilen    length of the input data
> - * \param output   SHA-1 checksum result
> - */
> -void sha1_csum(const unsigned char *input, unsigned int ilen,
> -               unsigned char *output);
> -
>  /**
>   * \brief         Output = SHA-1( input buffer ), with watchdog triggering
>   *
> diff --git a/lib/sha1.c b/lib/sha1.c
> index 7ef536f4b5d..81412283b49 100644
> --- a/lib/sha1.c
> +++ b/lib/sha1.c
> @@ -304,19 +304,6 @@ void sha1_finish (sha1_context * ctx, unsigned char output[20])
>         PUT_UINT32_BE (ctx->state[4], output, 16);
>  }
>
> -/*
> - * Output = SHA-1( input buffer )
> - */
> -void sha1_csum(const unsigned char *input, unsigned int ilen,
> -              unsigned char *output)
> -{
> -       sha1_context ctx;
> -
> -       sha1_starts (&ctx);
> -       sha1_update (&ctx, input, ilen);
> -       sha1_finish (&ctx, output);
> -}
> -
>  /*
>   * Output = SHA-1( input buffer ). Trigger the watchdog every 'chunk_sz'
>   * bytes of input processed.
> diff --git a/lib/tpm-v1.c b/lib/tpm-v1.c
> index e66023da5e6..a6727c575fd 100644
> --- a/lib/tpm-v1.c
> +++ b/lib/tpm-v1.c
> @@ -871,7 +871,7 @@ u32 tpm1_find_key_sha1(struct udevice *dev, const u8 auth[20],
>                         return -1;
>                 if (err)
>                         continue;
> -               sha1_csum(buf, buf_len, digest);
> +               sha1_csum_wd(buf, buf_len, digest, SHA1_DEF_CHUNK_SZ);
>                 if (!memcmp(digest, pubkey_digest, 20)) {
>                         *handle = key_handles[i];
>                         return 0;
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
