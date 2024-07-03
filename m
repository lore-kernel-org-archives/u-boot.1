Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8484C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 08:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA40884FE;
	Wed,  3 Jul 2024 10:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MWcxw0vP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD7688585; Wed,  3 Jul 2024 10:56:45 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2DF884FD
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 10:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d841a56e1dso1579963b6e.2
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719997002; x=1720601802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PdFEZev/ILlQMBFWS32go+bvcnG5LBj5ok1H+/mhv+o=;
 b=MWcxw0vPW6Ovbdc7LuxC97JZlnm7gdyKORDu22B3sLE7gjv4JmRHsSbw/64IeCY6MC
 +4atgZS4+/cUz104icxbWg3RSlKIhva8g40r3zylW0mB7krEpHz2U9tE5gYFpcpC7/Nr
 WhyCJh/tL+rm16cqfOJHy7XvtblGSL+IldeMNQrauMbgccSDr9Pez//vMZLbaBSXvqer
 hSPjg3O8TWFWCFCL6xcEWSvOa2nGbL56IYhoc/4H7GAGUoMzHbRFUBTjgDiMHbfZxmrQ
 DNIrOIu5CvlcNQP0LAlQUC6uLYsWQ+qPTWB++Nrt5Pmt6xJtC4O3jAm/DG5jvxLbMoMh
 HRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997002; x=1720601802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PdFEZev/ILlQMBFWS32go+bvcnG5LBj5ok1H+/mhv+o=;
 b=A7GeKU2f16OI6bYvVxjjl6fRcOzLj7WqKSz+mqfWIYbmeo0cWnKO1QPUcZKjCf5zeH
 h+Ncg4hLC8ocydEtmOrw6xt28a3f1D4b+8NH/zxXz6uCtr42GiojmkwqJ4POS5gMzG0F
 eCwvmEAYtDLPHoCsR3YhRyGkiHKF49dPa4pQ2dJynf/IxypUvMHwIhWrE4jvMA74sr+L
 rpmSOdg8kCYlvICK9ZLCWyERD3MHsNqjEnt+Qg6m9CL7X67kcP/zRfHHNxtSr0YvG+nn
 y0t1iWkpLuWxG1tCVtXPE+WcczBiM/Ycr/CgOA1NLwk87CMg36of39CPkErgRS3P5DPK
 7tiQ==
X-Gm-Message-State: AOJu0Yx5hlJV+YTgcvrhW/zYKJlxQapTiPaHfIUoweJFZy7BLZIeWtOt
 U9LiB7UOm7CvfKmHdr7FxjzaN6gmFo97m2v+if6H9UfDE7rdrDQDtGuUMrrnQn4bNEmPtuWAuNg
 /T8APjpGA/OBWFstHbM2lVJD8d5rMp+DprFEo/g==
X-Google-Smtp-Source: AGHT+IGim+M+NBNLHWfoIDS2W6eovbOk3JTsmevVXAifv5DzITA3x1duSLxgrzJkZBKHi+p7P1J7XR2e34iZ+7hp1bo=
X-Received: by 2002:a05:6808:1408:b0:3d2:4fe3:50ef with SMTP id
 5614622812f47-3d6b51b660bmr16650564b6e.41.1719997002236; Wed, 03 Jul 2024
 01:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-9-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jul 2024 11:56:05 +0300
Message-ID: <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] hash: integrate hash on mbedtls
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
 Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Eddie James <eajames@linux.ibm.com>
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

Hi Raymond

On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Integrate common/hash.c on the hash shim layer so that hash APIs
> from mbedtls can be leveraged by boot/image and efi_loader.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Use the original head files instead of creating new ones.
> Changes in v3
> - Add handle checkers for malloc.
> Changes in v4
> - None.
>
>  common/hash.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 143 insertions(+)
>
> diff --git a/common/hash.c b/common/hash.c
> index ac63803fed9..96caf074374 100644
> --- a/common/hash.c
> +++ b/common/hash.c
> @@ -35,6 +35,141 @@
>  #include <u-boot/sha512.h>
>  #include <u-boot/md5.h>
>
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> +
> +static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
> +{
> +       int ret;
> +       mbedtls_sha1_context *ctx = malloc(sizeof(mbedtls_sha1_context));
> +
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       mbedtls_sha1_init(ctx);
> +       ret = mbedtls_sha1_starts(ctx);
> +       if (!ret) {
> +               *ctxp = ctx;
> +       } else {
> +               mbedtls_sha1_free(ctx);
> +               free(ctx);
> +       }
> +
> +       return ret;
> +}
> +
> +static int hash_update_sha1(struct hash_algo *algo, void *ctx, const void *buf,
> +                           unsigned int size, int is_last)
> +{
> +       return mbedtls_sha1_update((mbedtls_sha1_context *)ctx, buf, size);
> +}
> +
> +static int
> +hash_finish_sha1(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
> +{
> +       int ret;
> +
> +       if (size < algo->digest_size)
> +               return -1;
> +
> +       ret = mbedtls_sha1_finish((mbedtls_sha1_context *)ctx, dest_buf);
> +       if (!ret) {
> +               mbedtls_sha1_free((mbedtls_sha1_context *)ctx);
> +               free(ctx);
> +       }
> +
> +       return ret;
> +}
> +
> +static int hash_init_sha256(struct hash_algo *algo, void **ctxp)
> +{
> +       int ret;
> +       int is224 = algo->digest_size == SHA224_SUM_LEN ? 1 : 0;
> +       mbedtls_sha256_context *ctx = malloc(sizeof(mbedtls_sha256_context));

I prefer sizeof(*ctx) on all the allocations. Also since it's a crypto
stack I prefer a calloc (sha384 for example will allocate more bytes)

> +
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       mbedtls_sha256_init(ctx);
> +       ret = mbedtls_sha256_starts(ctx, is224);
> +       if (!ret) {
> +               *ctxp = ctx;
> +       } else {
> +               mbedtls_sha256_free(ctx);
> +               free(ctx);
> +       }
> +
> +       return ret;
> +}
> +
> +static int hash_update_sha256(struct hash_algo *algo, void *ctx, const void *buf,
> +                             uint size, int is_last)
> +{
> +       return mbedtls_sha256_update((mbedtls_sha256_context *)ctx, buf, size);
> +}
> +
> +static int
> +hash_finish_sha256(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
> +{
> +       int ret;
> +
> +       if (size < algo->digest_size)
> +               return -1;
> +
> +       ret = mbedtls_sha256_finish((mbedtls_sha256_context *)ctx, dest_buf);
> +       if (!ret) {
> +               mbedtls_sha256_free((mbedtls_sha256_context *)ctx);
> +               free(ctx);
> +       }
> +
> +       return ret;
> +}
> +
> +static int hash_init_sha512(struct hash_algo *algo, void **ctxp)
> +{
> +       int ret;
> +       int is384 = algo->digest_size == SHA384_SUM_LEN ? 1 : 0;
> +       mbedtls_sha512_context *ctx = malloc(sizeof(mbedtls_sha512_context));
> +
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       mbedtls_sha512_init(ctx);
> +       ret = mbedtls_sha512_starts(ctx, is384);
> +       if (!ret) {
> +               *ctxp = ctx;
> +       } else {
> +               mbedtls_sha512_free(ctx);
> +               free(ctx);
> +       }
> +
> +       return ret;
> +}
> +
> +static int hash_update_sha512(struct hash_algo *algo, void *ctx, const void *buf,
> +                             uint size, int is_last)
> +{
> +       return mbedtls_sha512_update((mbedtls_sha512_context *)ctx, buf, size);
> +}
> +
> +static int
> +hash_finish_sha512(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
> +{
> +       int ret;
> +
> +       if (size < algo->digest_size)
> +               return -1;
> +
> +       ret = mbedtls_sha512_finish((mbedtls_sha512_context *)ctx, dest_buf);
> +       if (!ret) {
> +               mbedtls_sha512_free((mbedtls_sha512_context *)ctx);
> +               free(ctx);
> +       }
> +
> +       return ret;
> +}
> +
> +#else /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
> +
>  static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void **ctxp)
>  {
>         sha1_context *ctx = malloc(sizeof(sha1_context));
> @@ -143,6 +278,8 @@ static int __maybe_unused hash_finish_sha512(struct hash_algo *algo, void *ctx,
>         return 0;
>  }
>
> +#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
> +
>  static int hash_init_crc16_ccitt(struct hash_algo *algo, void **ctxp)
>  {
>         uint16_t *ctx = malloc(sizeof(uint16_t));
> @@ -267,10 +404,16 @@ static struct hash_algo hash_algo[] = {
>                 .hash_init      = hw_sha_init,
>                 .hash_update    = hw_sha_update,
>                 .hash_finish    = hw_sha_finish,
> +#else
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> +               .hash_init      = hash_init_sha512,
> +               .hash_update    = hash_update_sha512,
> +               .hash_finish    = hash_finish_sha512,

I don't have strong opinion here, but you could alternatively define
sha384 wrappers for mbedTLS and avoid this ifdef.
In any case I personally don't mind.


>  #else
>                 .hash_init      = hash_init_sha384,
>                 .hash_update    = hash_update_sha384,
>                 .hash_finish    = hash_finish_sha384,
> +#endif
>  #endif
>         },
>  #endif
> --
> 2.25.1
>
