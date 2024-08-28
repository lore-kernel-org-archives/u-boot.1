Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2401C54E62
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 09:54:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE3A8884F;
	Wed, 28 Aug 2024 11:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oOjoGTNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF2B88A3E; Wed, 28 Aug 2024 11:54:07 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73903885D1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:54:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-201ed196debso58591645ad.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 02:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724838844; x=1725443644; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i//7EzwXJTN0zNSkD7Qnkmedk7TCveveRjXXn5kOzNE=;
 b=oOjoGTNytNSKU7lhUtDR1aDXGYcCBVbX5BIN4nxr+Q+uHW6TZzIhCCdpWVF3SXKlmK
 M1eiqxhQj4aYtTiHXia64HeB1oCaB/YiRZpISMQld3sIXRKOXnTRR5UnmsoEVzM4Hjqv
 dPnND7YDUQTdmGUSfQ5yk0NdzvqTWpUmRevUdLYwLnptWq7hdLER+xzu8kw4Y/em4jqQ
 Xaa7IPAavopvJf0R+R1V+Dsc0xHT3vlO+gvl8Rvw59GBW3dPcAibSZufdSKfJtW1YtHu
 0D1m2VbLg544PY65f2hzOvPoRW2lydZQJUlyZILJbmsFvwSBufqHDWso02PstEGENIYy
 Kg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724838844; x=1725443644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i//7EzwXJTN0zNSkD7Qnkmedk7TCveveRjXXn5kOzNE=;
 b=kXWDHzgDXaFSy2tOIdxD+IRPFW9ggVtnlfVf+QcLeTX/dHYIIyjjyJHh4ccy7SITSh
 VDZZ4n6N3jYe1gyv2J7g0TEPAqThLTJ9cTN5ah+YOEiC5+TJI9UJthbzPKFDd2Ngmv1f
 xwSmZwOD3Mxe5D+Cd+K9O0hTPCKW1dd4AAZNR+oImC6UOFR+qH2hZz+tLQtn6TGdashd
 PxAJ8JiOdVOdIVX6wMXUUrXnr52cWBsdMlolggnwQLLQiANVVfhdrQPsK+go2FZJF5Sl
 WXidnAE1cRhjEy12TR8mhuFl5em6Ve3/dqgiEzSplYYD71oVF7RVR3KZtWgiVrMjvC8x
 DXWg==
X-Gm-Message-State: AOJu0Yz+H4sqZZIAiTrdV15OXW9KZCxs28kG25PqMxf+Nfrq/izrXpG1
 X72kYVSqklrxbo+EEsPgcdFSt5tsi8HKWME8Le90ePyFsh4akT5Mjw4rsJ61Ryx1xv8qxni1hj2
 VnJkYkrPZQFpoDZUgEahHyarcrji9Wk2RHe6fIg==
X-Google-Smtp-Source: AGHT+IFPsG9VVhclMVJupgvL4eNUkRAPnB/Ke2LZowSiJtqdEgB6QBBBHCOuGzg/XO7b+S7LYKKI8RKq36Uk06zPD6o=
X-Received: by 2002:a17:902:ec8c:b0:201:cda4:69cb with SMTP id
 d9443c01a7336-204f9a6142bmr17304095ad.9.1724838843629; Wed, 28 Aug 2024
 02:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
In-Reply-To: <20240816214436.1877263-8-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 28 Aug 2024 12:53:25 +0300
Message-ID: <CAC_iWjKNFQA70MMiHbWwP9u-Qxs_O=yfE6QS0PF2TcmPD4MXMQ@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
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

Hi Raymond

On Sat, 17 Aug 2024 at 00:47, Raymond Mao <raymond.mao@linaro.org> wrote:
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
> Changes in v5
> - Add __maybe_unused to solve linker errors in some platforms.
> - replace malloc with calloc.
> Changes in v6
> - None.
>
>  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
>
> diff --git a/common/hash.c b/common/hash.c
> index ac63803fed9..d25fc4854c7 100644
> --- a/common/hash.c
> +++ b/common/hash.c
> @@ -35,6 +35,144 @@
>  #include <u-boot/sha512.h>
>  #include <u-boot/md5.h>
>
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> +
> +static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void **ctxp)
> +{
> +       int ret;
> +       mbedtls_sha1_context *ctx = calloc(1, sizeof(*ctx));
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
> +static int __maybe_unused hash_update_sha1(struct hash_algo *algo, void *ctx,
> +                                          const void *buf, unsigned int size,
> +                                          int is_last)
> +{
> +       return mbedtls_sha1_update((mbedtls_sha1_context *)ctx, buf, size);
> +}
> +
> +static int __maybe_unused
> +hash_finish_sha1(struct hash_algo *algo, void *ctx, void *dest_buf, int size)
> +{
> +       int ret;
> +
> +       if (size < algo->digest_size)
> +               return -1;
> +
> +       ret = mbedtls_sha1_finish((mbedtls_sha1_context *)ctx, dest_buf);
> +       if (!ret) {

patch # calls finish & free regardless of the return result of
mbedtls_xxxx_finish().
I think this should happen here as well

> +               mbedtls_sha1_free((mbedtls_sha1_context *)ctx);
> +               free(ctx);
> +       }
> +
> +       return ret;
> +}
> +
> +static int __maybe_unused hash_init_sha256(struct hash_algo *algo, void **ctxp)
> +{
> +       int ret;
> +       int is224 = algo->digest_size == SHA224_SUM_LEN ? 1 : 0;
> +       mbedtls_sha256_context *ctx = calloc(1, sizeof(*ctx));
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
> +static int __maybe_unused hash_update_sha256(struct hash_algo *algo, void *ctx,
> +                                            const void *buf, uint size,
> +                                            int is_last)
> +{
> +       return mbedtls_sha256_update((mbedtls_sha256_context *)ctx, buf, size);
> +}
> +
> +static int __maybe_unused
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
> +static int __maybe_unused hash_init_sha512(struct hash_algo *algo, void **ctxp)
> +{
> +       int ret;
> +       int is384 = algo->digest_size == SHA384_SUM_LEN ? 1 : 0;
> +       mbedtls_sha512_context *ctx = calloc(1, sizeof(*ctx));
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
> +static int __maybe_unused hash_update_sha512(struct hash_algo *algo, void *ctx,
> +                                            const void *buf, uint size,
> +                                            int is_last)
> +{
> +       return mbedtls_sha512_update((mbedtls_sha512_context *)ctx, buf, size);
> +}
> +
> +static int __maybe_unused
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
> @@ -143,6 +281,8 @@ static int __maybe_unused hash_finish_sha512(struct hash_algo *algo, void *ctx,
>         return 0;
>  }
>
> +#endif /* CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO) */
> +
>  static int hash_init_crc16_ccitt(struct hash_algo *algo, void **ctxp)
>  {
>         uint16_t *ctx = malloc(sizeof(uint16_t));
> @@ -267,10 +407,16 @@ static struct hash_algo hash_algo[] = {
>                 .hash_init      = hw_sha_init,
>                 .hash_update    = hw_sha_update,
>                 .hash_finish    = hw_sha_finish,
> +#else
> +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> +               .hash_init      = hash_init_sha512,
> +               .hash_update    = hash_update_sha512,
> +               .hash_finish    = hash_finish_sha512,
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

Thanks
/Ilias
