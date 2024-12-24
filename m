Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EBAE77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 06:58:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37EA80711;
	Tue, 24 Dec 2024 07:58:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ipXlfwuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AC4A80786; Tue, 24 Dec 2024 07:58:09 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9684980708
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 07:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e3a26de697fso4004788276.3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 22:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735023485; x=1735628285; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8LpWH06MiZSQdvpjZfX+fnWeR9tVdyvLk0aJB34NrBc=;
 b=ipXlfwuSJoT626z13u/ZjIBdQwPA3JSVQKUF8iqDNYR2WfmR2VhYkTDcOa7Wlm9cTV
 ay0aJ3xG5ZOgQ8/N+/CPC8wEWeaaYlHaZ9lvbfyd6Aou0woAJ+1WnY6C89JuzFcSlDVA
 Njp6HLF4s2Rr2S3lm+oFXXeKgOTomHlDODVx5aYQCKlB0G1HLZhPR3r/FHDTjpF4zF2R
 30/cQ5dpt20QNoubJOqcvWWtNs1VrSZAs+eIqGYWfzR6NDK5bQ7nyhdd+eNG+nJD6wN8
 eZ7HBQVIjJzqfQENNEPOEII6HwKGhjW/zr/T8ps6jwMBTyl2vQieLfIA9oOte64EVIcf
 pDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735023485; x=1735628285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8LpWH06MiZSQdvpjZfX+fnWeR9tVdyvLk0aJB34NrBc=;
 b=G0+olEx83L+ght+AH3ankQvsaOZxz+UixLHZOF+GdKaomJzH3l2UoeabsaLQDzQa4W
 vNxSvsH7l6XvvYnz0+MXZSpfUBFJ+AeMUaLitenJ+x/7uGI9tqOZYqK3IQC4S/BvIOOu
 +nSZaO/5OsWACJ1+4tlSJr8xcySKquZ+vHnw/iGit60aNGpIPN7LSP5MBkgxstxpJ6TT
 Z0YGVuUZwbcnJJzyfvvAdqpwpaYsKyRi6NlRQRVrl+1CX+NeEezo7jqJ4WuWpCsl1ezH
 4ZQ3W1u93KaOJkmneyVfVM/z6P8WKnwsDOACyTdbw5z2cJTwfWjUcoC1080+9j2Cafpa
 QERw==
X-Gm-Message-State: AOJu0YzooFIRug+jOqfkli4p8KM0JYEPnUBZOC4F3/yCckdTmgwVqjWg
 YOJAGp9IgssiC/YzWDLHw6coF2+ZsmFMfwC8m9Wg8de2LhukP73BKL8ocvJ+5iCc3NObVRh++RW
 Vt97nwVzgtz7asFbP9H8rX8Di57I3nsDXwzNYkQ==
X-Gm-Gg: ASbGncsxPGkNSaeAxv69BoEv94lHbhw2uI+N7KoAIvTwxudgJCf1tL9v00DtsIOHw64
 pRYVm4Uj0yG2SQzdJTgu0Q/N3CPEUndV0koaWCQ==
X-Google-Smtp-Source: AGHT+IFabS26Xj8wIdoSW1lCF0tQa+b0+RkfA8aTZpzdspeIS3jdKz9GCNA+a8mFstDhprvqgZCVKUeRLB9lt3WlhkU=
X-Received: by 2002:a05:6902:2848:b0:e48:d51f:448a with SMTP id
 3f1490d57ef6-e538c4274d8mr11738541276.53.1735023485433; Mon, 23 Dec 2024
 22:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20241223144737.554992-1-raymond.mao@linaro.org>
 <20241223144737.554992-12-raymond.mao@linaro.org>
In-Reply-To: <20241223144737.554992-12-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Dec 2024 08:57:29 +0200
Message-ID: <CAC_iWj+JjZXDO9PywmC-gnK=Gj1Ff_qL2N9GLxWYXbQOHDsAZA@mail.gmail.com>
Subject: Re: [PATCH 11/11] tpm: add kconfig control in tcg2_create_digest()
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tim Harvey <tharvey@gateworks.com>, 
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

On Mon, 23 Dec 2024 at 16:49, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> To allow disabling algorithms for tcg2, in function
> tcg2_create_digest(), each hash algorithm operations should under
> the hash kconfig control to avoid building errors when the algorithm
> is disabled.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/tpm_tcg2.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> index 64563d7871..85f9d3c9c5 100644
> --- a/lib/tpm_tcg2.c
> +++ b/lib/tpm_tcg2.c
> @@ -96,9 +96,15 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
>  {
>         struct tpm_chip_priv *priv = dev_get_uclass_priv(dev);
>         u8 final[sizeof(union tpmu_ha)];
> +#if IS_ENABLED(CONFIG_SHA256)
>         sha256_context ctx_256;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA512)
>         sha512_context ctx_512;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA1)
>         sha1_context ctx;
> +#endif
>         size_t i;
>         u32 len;
>
> @@ -106,30 +112,38 @@ int tcg2_create_digest(struct udevice *dev, const u8 *input, u32 length,
>         for (i = 0; i < priv->active_bank_count; i++) {
>
>                 switch (priv->active_banks[i]) {
> +#if IS_ENABLED(CONFIG_SHA1)
>                 case TPM2_ALG_SHA1:
>                         sha1_starts(&ctx);
>                         sha1_update(&ctx, input, length);
>                         sha1_finish(&ctx, final);
>                         len = TPM2_SHA1_DIGEST_SIZE;
>                         break;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA256)
>                 case TPM2_ALG_SHA256:
>                         sha256_starts(&ctx_256);
>                         sha256_update(&ctx_256, input, length);
>                         sha256_finish(&ctx_256, final);
>                         len = TPM2_SHA256_DIGEST_SIZE;
>                         break;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA384)
>                 case TPM2_ALG_SHA384:
>                         sha384_starts(&ctx_512);
>                         sha384_update(&ctx_512, input, length);
>                         sha384_finish(&ctx_512, final);
>                         len = TPM2_SHA384_DIGEST_SIZE;
>                         break;
> +#endif
> +#if IS_ENABLED(CONFIG_SHA512)
>                 case TPM2_ALG_SHA512:
>                         sha512_starts(&ctx_512);
>                         sha512_update(&ctx_512, input, length);
>                         sha512_finish(&ctx_512, final);
>                         len = TPM2_SHA512_DIGEST_SIZE;
>                         break;
> +#endif
>                 default:
>                         printf("%s: unsupported algorithm %x\n", __func__,
>                                priv->active_banks[i]);
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
