Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED2ECD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22688341A;
	Wed,  3 Jun 2026 18:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P0G9/Zhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983C083FF5; Wed,  3 Jun 2026 18:43:50 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7853A80433
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:43:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68b482888c3so1415092a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780505028; cv=none;
 d=google.com; s=arc-20240605;
 b=jP9G+Ad2x1ZgoSfWidGzhsiS2jwQ1+LQipnQeCM3Sd0YLMZeWHJlut9bol7Ou7j7wu
 ZnOL3rowaCMbGG6nhY5AuZBBUy9SPMfVUNnFAKdoVkh3tgTCdMW8YQkfaldBgLvK1TBd
 Q6UfwBiqmNXKy7TdbEenDxpjWDsCxpEUzgCFYBW1foN/tly70f6ld6CmYc64QJniQWBJ
 V9MesQunM3FvmxjMshdXVYoGLqqvj/EICpi9b1ZSaC2Dgbo913B+VKI43ZdrSDRjoxzo
 LOKE2EU9mWVaLoL8hUXnx4fS0IgB2EUvgE6GRZqPAvQXMAQPf+63BJ983/TBYhIOauN5
 +WEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DUlmzIN/0RPQ+249f2ZZ84EK2MT5Ti3W8RmNCR6zK9U=;
 fh=541SGUfY4ChWDMJtIzol1UckrVCUIgmG0/b7Gr0ixNQ=;
 b=WpUdobm1GftfViGMTuscrOUd7dDHfvXF+zLS0el+FrF5XB+43JLShQYytT1PSSMc+3
 2PnoCq6nCOncFBWx8yx+hffbLJt6f2IuOqTqcyKxkpjk/A+dnrrpBAcl9q7QRn3edf4l
 wFuHRFRwS1aa2e6A6zmGkt5uWnKDzvrfOZcXf5kYRNpUutZ2KZwdFf1YM9E1KdFXFzGq
 3nTxxYjCdOsDpu26zCN01acJtqqJj49IdsjlH3QF4RrBBXAhby2/sj3ru67QPSAWxy5s
 eVSslNqb7PQOJPvNGTR9SFYXzM+oSqWSNUtqujXhYnxqWOPGDfFwzumwVNUOOh8CnzWS
 LwYQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780505028; x=1781109828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DUlmzIN/0RPQ+249f2ZZ84EK2MT5Ti3W8RmNCR6zK9U=;
 b=P0G9/ZhsCm+7oON8KJbqRx59RRjga09DXoUh035CCp66B8S1aBQf2m0W9T5T2GP3zC
 JUOGUPqvcOC2vI+z703ullRVytlIplLJO3gEhK/TvbELxTuS+WoQ/fq/a6V+hv746ScH
 9VimX9brvPEMDHZ8BYiN0MIchg9UEJojdj0CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780505028; x=1781109828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUlmzIN/0RPQ+249f2ZZ84EK2MT5Ti3W8RmNCR6zK9U=;
 b=Boil7u4Sc+ujRCcy5WPYZz4dYzQaK9343BVazi61nAxqpx82nlT4NAMoC/i2SOqcjX
 o+T9qnvbNGl19m6X5gUu/ri/dx4vkIuABLM31YchJgdCUX14AfxSj0DE58z8veK+ydLl
 ifULO3qXAqzJDnMbU1lMuIza+28aesA3WH2RyNDjqObuD0msYOhKb2dhCDXo0qMteoOQ
 8CJ9T4Ec4FFi/Oht+y4cdckTIVQClNANX98PCV4H0T4uNgeLrzH0EhBeqARRYmlBrySt
 SFpcn8/PC/iPCAqj0NKkLaUNhhxcfab0E711FaEHWksr3HypiY8ea8pRLqasAXmMcxlE
 C6ww==
X-Gm-Message-State: AOJu0YyHO8DOzbAQJheVZUk+BMKG+slMGaTYXAsqLuMKvZJKRJ/IV+gK
 nWRFZ5p3VcZe+gwrgPxFjU8BQk7DIlYyQz1FQ0AmCEWIiv7bVn7ziuwrQ30xjBG0GBtUxooBcXW
 M/vK3aw4jq/TTQAm6SOtKrEvQGqaJhCCfexzEq0bu
X-Gm-Gg: Acq92OEURGQIQWqqXrx2gGXabq5IadwkJFDj8sJyFm1OUq16HWDOIpwqLTXRhgP7Wco
 0U7XIZVFy+zGbMMpBPBNEMX55q488gBZjQglQRlSnUjcI9zsBmA6/XQum9YXlgIFUL9rO2cO7/z
 6ftE/6igsr2FTOC4ZtNXdJv8pCQhco7BRvOaKSJQ07U6Lg9wj/9LQO4zUc/x+WmT68DCl+jeAhf
 KZVJtkMmK+5ZhPI1DnzdPNBFCcA3JmVAEtF2bKehE9tfMZUllSM7Le/dO1AHh+AoPEhQLoTRlqg
 WO5cmQBgGUf4csuQ
X-Received: by 2002:a17:907:6d11:b0:beb:2980:e2d2 with SMTP id
 a640c23a62f3a-bf1d1c83194mr15779166b.8.1780505026677; Wed, 03 Jun 2026
 09:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260528080356.399082-1-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260528080356.399082-1-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 10:43:34 -0600
X-Gm-Features: AVHnY4LEQqHrCfrkAR4qrUE3iuTMiG7crq-6jGiVCZGYhGs9A6gobyy10Txe_OY
Message-ID: <CAFLszThvtrgFCdvOa1-QYYcrefW=vt95jwMfr+QQykE8E1hg-g@mail.gmail.com>
Subject: Re: [PATCH v5] tools: mkeficapsule: Rework pkcs11 support
To: Wojciech.Dubowik@mt.com
Cc: u-boot@lists.denx.de, Franz Schnyder <fra.schnyder@gmail.com>,
 trini@konsulko.com, "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 David Lechner <dlechner@baylibre.com>
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

Hi Wojciech,

On 2026-05-28T08:03:54, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> tools: mkeficapsule: Rework pkcs11 support
>
> Some distros like OpenEmbedded are using gnutls library
> without pkcs11 support and linking of mkeficapsule will fail.
> It would make maintenance of default configs a hurdle.
> Add detection of pkcs11 support in gnutls so it's enabled
> when available and doesn't need to be set explicitly.
>
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> tools/Makefile       |  5 +++
>  tools/mkeficapsule.c | 95 +++++++++++++++++++++++++++++++++++++++-------------
>  2 files changed, 77 insertions(+), 23 deletions(-)

> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> @@ -207,6 +207,71 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> +{
> +     gnutls_pkcs11_obj_t *obj_list;
> +     unsigned int obj_list_size = 0;
> +     int ret;
> +
> +     ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> +                                              ctx->cert_file, 0);
> +     if (ret < 0 || obj_list_size == 0)
> +             return ret;

!obj_list_size

Behaviour change: when obj_list_size == 0 but ret >= 0, the caller's
'if (ret < 0)' check passes and execution continues with an empty
obj_list. Please return -1 explicitly in that case.

> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> +{

...
> +     ret = gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
...
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> +{
> +     return gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
> +}

gnutls_x509_crt_t and gnutls_privkey_t are already pointer typedefs
and neither function reassigns the handle, so the extra indirection
buys nothing. Please pass the handles by value and drop the '&' at the
call sites.

> +#else
> +static int pkcs11_init(void)
> +{
> +     fprintf(stderr, "Pkcs11 support is disabled\n");
> +     return -1;
> +}
> +
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> +{
> +     fprintf(stderr, "Pkcs11 support is disabled\n");
> +     return -1;
> +}
> +
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> +{
> +     fprintf(stderr, "Pkcs11 support is disabled\n");
> +     return -1;
> +}
> +#endif

"PKCS#11 support..."

import_pkcs11_crt() and import_pkcs11_key() are only reached after
pkcs11_init() has already failed with the same message, so these two
stubs look like dead code.

> @@ -243,19 +305,8 @@ static int create_auth_data(struct auth_context *ctx)
>       if (pkcs11_cert || pkcs11_key) {
> -             lib = getenv('PKCS11_MODULE_PATH');
...
> +             ret = pkcs11_init();
>               if (ret < 0) {
> -                     fprintf(stdout, "Failed to add pkcs11 provider\n");
>                       return -1;
>               }
>       }

Single-statement block, drop the braces. Or fold to 'if (pkcs11_init()
< 0) return -1;' since ret is not used afterwards.

> @@ -301,14 +352,12 @@ static int create_auth_data(struct auth_context *ctx)
>       /* load x509 certificate */
>       if (pkcs11_cert) {
> +             ret =  import_pkcs11_crt(&x509, ctx);

Double space after '='.

Regards,
Simon
