Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD35EC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 08:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26A8888473;
	Thu,  9 May 2024 10:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d2h8Ka6S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BEFA88477; Thu,  9 May 2024 10:32:37 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 773AB8844F
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 10:32:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59e4136010so134555066b.3
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715243555; x=1715848355; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oj2Ytlm10JhpIaMpbg/LnXUnnDVzcFny3tMwEX/rYDA=;
 b=d2h8Ka6SVd/T8ww7N60Qazu+Vq2vlA3GKgQw71EG6XJabz4iRzZgXmf6f0Sl9bltCb
 MKTK8kEV3wUKdBxngGNnWj5+QPKawxUCUk2+5/pHYL1Pv2mh0ngDP86FSQnqOsxOx8hc
 MEceslT8QNvj5nzHtDNljlIwHqNEOzxqq/iMzBHJ5wMRMtlgVhHueRJLpGAtw72HfItR
 IOzySu84IgnhrE+9fc83+VQ3Eba270+ZMxSxJoPN3MwB9rcDUV/gzY+UDQa6/DdHRdBv
 VT9iv4seWiqPYYMXn7J0xFwM+BXpf7QWXEJ0seRtFUJKri6ZxTz594tVOiNHNJo/7ZEJ
 gvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715243555; x=1715848355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oj2Ytlm10JhpIaMpbg/LnXUnnDVzcFny3tMwEX/rYDA=;
 b=DlZ1Et4ejgWIVFl5YLKwgnD7XJYpbAvjnn+qTAUy1GbAwggOZKYiUZt8haTfF0a5F0
 N+GENUI0LvhUVWyD5lcrzoOt4OTdjQPWUfqRsOucvKh0JV9QwiYw3wxXNmNgs1d1KSx4
 YuAFqeQ2twnT8RamP2VhOZ37Yo9MuuSpaQJCc8IOwzJ4Yrt3obQe2vx6IptluRQnSzKq
 yEIOEyNI/Yp8zlwbr/uyvaIh5K/ahChl804RFRQO5PGFTMZFhg3yUWgeu2Asddgq2lrt
 glt0w4AxC8IvDjUUrlBTdHkMjftuDfUM7OiGQrAuBx9+d+MtieCPbYirwswqm/IE3YPW
 Q1JA==
X-Gm-Message-State: AOJu0YzmkwowAPR9vmV2CdMK+GWvAWXSqCVW5D6Z0daB+hJpX/nB4G4c
 uClupnw7h9yVzZ9FgFHuMSUwPc+W2v3Rne0hPNYpGjjOROcU1IeJ7hvJBJJd0iiNCpaNc/9XIOJ
 +QcNRBhjxzp6dnrnFamwpThPuyucaiy9gerzRDuhR2t0NNeqmMmGwTA==
X-Google-Smtp-Source: AGHT+IHTwzf7MsXUv3G8pq5kppklyVxOqnPV3j1IR8Pdbou1d2Q5Goq1ZjoRACz484IkfVLhYwO72ed6QwMYsFBdbF0=
X-Received: by 2002:a17:907:7fa7:b0:a59:aa9d:3142 with SMTP id
 a640c23a62f3a-a59fb96b90dmr378564166b.37.1715243554923; Thu, 09 May 2024
 01:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240507175132.1456512-1-raymond.mao@linaro.org>
 <20240507175132.1456512-11-raymond.mao@linaro.org>
In-Reply-To: <20240507175132.1456512-11-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 May 2024 11:31:58 +0300
Message-ID: <CAC_iWjJVcrWJqtrZ_pXwya3ARN9uHJeX-K4ysZe-QbCUv=0u5w@mail.gmail.com>
Subject: Re: [PATCH v2 10/28] hash: integrate hash on mbedtls
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Andrew Davis <afd@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
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

On Tue, 7 May 2024 at 20:56, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Integrate common/hash.c on the hash shim layer so that hash APIs
> from mbedtls can be leveraged by boot/image and efi_loader.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Use the original head files instead of creating new ones.
>
>  common/hash.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>
> diff --git a/common/hash.c b/common/hash.c
> index 3d6b84de473..6b8815da237 100644
> --- a/common/hash.c
> +++ b/common/hash.c
> @@ -36,6 +36,132 @@
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
> +       mbedtls_sha1_init(ctx);

The alloc might fail. What happens if ctx is NULL in mbedTLS?
If that's ok, add a comment to explain why.

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

Since we are trying to save as much space as we can, you could pass
this value directly to mbedtls_sha256_starts()

[...]


Thanks
/Ilias
