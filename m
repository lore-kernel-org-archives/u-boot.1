Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2374FC282D1
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 11:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53DA4801DE;
	Sun,  9 Mar 2025 12:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AqIFgeKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1311C8043C; Sun,  9 Mar 2025 12:34:48 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE68480107
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 12:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so2788468276.3
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 04:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741520056; x=1742124856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zz+do9nkm26Pt/DtPRPGCcaYxfAvckFey8OXSDskjag=;
 b=AqIFgeKIuCqoDs3PGEHFU+Lkjc+dctDvZHmx7dkBhQlxM+xh7Oce/u4fsIJghx00Ua
 LEZdZd+IFJQRKmDGXWLfkqo44FGzYTB96pSiG9gch3ugqoz26NnxKIdRwZIu4m2jby21
 1aZ18pHjGWsu5J16ZSQ3x9kyylLpJxJsAd+tP1AwkRXVT6rRXrTy6NBuFknikOf7YVEM
 m43wRULtOe58d/L8QZwHxG88ST1JDPGfpxZoEWqPHMaCM1Fna4An0vixD0K56hbT8x20
 FO2QfSVVyilnJLAIMIpgUQj6hIb+w63YHSUbxkqML2P+NTAQx59QN4sIHpFLShd60Pbx
 +LZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741520056; x=1742124856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zz+do9nkm26Pt/DtPRPGCcaYxfAvckFey8OXSDskjag=;
 b=Mh/WbVaFrjDxDBD4H/2AJjCIwIZGGyvsl/N50FEsF2FJYnZakPDhid0scfSVkG4FXX
 Fbomy88UQZZFnIS19k3deL201iML0+n0HWmjjGp6lmrGsxyLeT/TXRMnge/eyYJnYI3O
 W9qbefnhAJiVsJ7vEcjOBaYXso7I0FLQV476A2lRTKW8/B/t5SQnTgYagfeOJhnCUpcj
 AwGp5h8C1Ifiazjmf+Zm2sHwj0wuyz0NrElWBYEmh35Tww/UG2ycsL2VoyjAR9/Noh2d
 COXSa+ENt396s+Ow2UJEgJxPcD8lVAlhATQy6nDgo+TSoagQIwQYQLG+6EJRQADhb8dM
 1q9g==
X-Gm-Message-State: AOJu0Yy5HleZChIkW4uruQiyYVLuV4PN/o02EvsMm4qLFjo+4U4rqNNQ
 Zwu8eRnsN9+TWZRSeGtc9v4yrCMFucC+u6aEsfP9c62NDiAr+wx+9f+sZwfL5EEh+gwtezIKA3F
 FVlW6Hmmj6R9u5/yffFcHIwQE7RwX8VddvJVJjQ==
X-Gm-Gg: ASbGnctf32nc3qFixk0quta8BTlrREvp8WQDpVKpq08DfvucII/G1MJWd5dYS6YXukV
 XKsZ+rv5EN/APLHOd9SeGoeQZ/4ad/aY0a1NKH8c9b0ToHLUUHvpMSkxPkyjzDvHoJp98eFLC9v
 qqvvym7/qmUGLt8578Py0/YA4lP+3QaijhK6r8lQ==
X-Google-Smtp-Source: AGHT+IFkRM7DKRji22s2QZ0k2HuAATERg0pPUpnu7G6tfBzGV8Aa3gt7J3mZL0M0LDH4Rfr2+q/CEDNQ/wR0WY4jZM4=
X-Received: by 2002:a05:6902:3302:b0:e5d:d2ce:a40a with SMTP id
 3f1490d57ef6-e635c1d94d8mr11027275276.34.1741520056680; Sun, 09 Mar 2025
 04:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-5-jerome.forissier@linaro.org>
In-Reply-To: <20250305142650.2966738-5-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 13:33:40 +0200
X-Gm-Features: AQ5f1Jpz9RNVXImCpHteUyMGdWuzoc9AUy14Fb0kDXIfbwH0Phd3x6lXLYaZilE
Message-ID: <CAC_iWj+kn1Ah98XthW_kGmNQHjKy=VEL9kd+PjVKV9phwJeVcQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] net: lwip: add support for built-in root
 certificates
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>
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

Hi Jerome

On Wed, 5 Mar 2025 at 16:27, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>

[...]

> @@ -304,28 +304,34 @@ static int set_auth(enum auth_mode auth)
>
>         return CMD_RET_SUCCESS;
>  }
> +#endif
>
> -static int set_cacert(char * const saddr, char * const ssz)
> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> +extern const char builtin_cacert[];
> +extern const size_t builtin_cacert_size;
> +static bool cacert_initialized;
> +#endif

These are better off under WGET_CACERT || WGET_BUILTIN_CACERT ?

> +
> +#if CONFIG_IS_ENABLED(WGET_CACERT) || CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> +static int _set_cacert(const void *addr, size_t sz)
>  {
>         mbedtls_x509_crt crt;
> -       ulong addr, sz;
> +       void *p;
>         int ret;
>
>         if (cacert)
>                 free(cacert);
>
> -       addr = hextoul(saddr, NULL);
> -       sz = hextoul(ssz, NULL);
> -
>         if (!addr) {
>                 cacert = NULL;
>                 cacert_size = 0;
>                 return CMD_RET_SUCCESS;
>         }
>
> -       cacert = malloc(sz);
> -       if (!cacert)
> +       p = malloc(sz);
> +       if (!p)
>                 return CMD_RET_FAILURE;
> +       cacert = p;
>         cacert_size = sz;
>
>         memcpy(cacert, (void *)addr, sz);
> @@ -340,10 +346,32 @@ static int set_cacert(char * const saddr, char * const ssz)
>                 return CMD_RET_FAILURE;
>         }
>
> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> +       cacert_initialized = true;
> +#endif
>         return CMD_RET_SUCCESS;
>  }
> +
> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> +static int set_cacert_builtin(void)
> +{
> +       return _set_cacert(builtin_cacert, builtin_cacert_size);
> +}
>  #endif
>
> +#if CONFIG_IS_ENABLED(WGET_CACERT)
> +static int set_cacert(char * const saddr, char * const ssz)
> +{
> +       ulong addr, sz;
> +
> +       addr = hextoul(saddr, NULL);
> +       sz = hextoul(ssz, NULL);
> +
> +       return _set_cacert((void *)addr, sz);
> +}
> +#endif
> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
> +
>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>  {
>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> @@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
>         memset(&conn, 0, sizeof(conn));
>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
>         if (is_https) {
> -               char *ca = cacert;
> -               size_t ca_sz = cacert_size;
> +               char *ca;
> +               size_t ca_sz;
> +
> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> +               if (!cacert_initialized)
> +                       set_cacert_builtin();
> +#endif

The code and the rest of the patch seems fine, but the builtin vs
downloaded cert is a bit confusing here.
Since the built-in cert always gets initialized in the wget loop it
would overwrite any certificates that are downloaded in memory?

[...]

Cheers
/Ilias
