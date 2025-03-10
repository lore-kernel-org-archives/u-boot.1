Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C547C28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 11:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D912811C1;
	Mon, 10 Mar 2025 12:52:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PlknT6tp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB0958122F; Mon, 10 Mar 2025 12:52:41 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFC58003E
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 12:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e6182c6d52aso2752906276.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 04:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741607558; x=1742212358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x4q8yno2KSsVUTcb9jWfpW8ROoXVAUu9R7Vb9qGABTM=;
 b=PlknT6tpRIfNDE5SWb4dyh4Z1K78XjCxefitnZryKUsdGYS8CU1JU1ID7n7M0EoiE2
 XQak3HsqIaFoWKblIKya0yZMuW8HwMtoQM14rLw/LvBEfL+XrKtpgh05NgZWy0LgV8T7
 n4Xk6CP6RtoWZMZIKrbRik69r+JGSSTspHBnUmnxIerqTFzdE4yIIeEAbkY+nCV9Bp5P
 SG3DkrdD6V6f7BjdZNa36/HSzq71CsT4oKYRBelFnf6LhrYUSNiPL2qL8YM3O1pzRBAQ
 ZDVFOKT8w8gBeTF2G8GftgnXiRNtVmjQZ+eIl2iLN+9OsCwWfkT4pKT6SoKRDwwdAUxf
 NyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741607558; x=1742212358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x4q8yno2KSsVUTcb9jWfpW8ROoXVAUu9R7Vb9qGABTM=;
 b=JIis3rmwUJXVXjE7TJp9k9wI6Pr88hF7JwYPdR5xGdJr8jUDc+kO+FEWZtvwBE8AAE
 IEJZmH4lD4mI3uxgYyUUyTizcLo6Pe1KogLMx4YJgM6v/09psf6JW2ZkOXvtwuX3/zDG
 487SpY9P5eeMpBsHVzC87FTYNzvrCSwb+iE50qDvS95N/MAr8w5y9uvlldf+/AaN8Vh5
 sKvBzfsmb9g7ppBl08FFgaYVueUKah4YKjM0dAIPoWjt7JD/o0DA8JN2lNZX0ZhjIiYg
 h+oJj5NNaGvmIf7gJSNtw8tDXIsmTgr4w3UaDMSR52Wj57TknfNtMS1RUMStxUI1PG9n
 Dqjg==
X-Gm-Message-State: AOJu0YzpvpjCtHQva6g42BuSNDD0t/Bfz8vdLmGcwHgaC/kIAIAiLrE7
 VyLcJitriAiScPRXotjBMFykTY9toMNqVz9C2NAttNZZVjC4yUnLkHI7qR6JMKPjpVJyOXUnM4M
 ycLwqoEa5NhtnQBPRC0YROgDbUoUP/zPoSfqu2g==
X-Gm-Gg: ASbGnctv/ue0jhwQAyZ5RWDHh3ZvvuGOSzbEqCqfe9eWj3tb72aHuaO+F9N4R/Yx5SS
 BjErzhH1OkymI3eJzY9qdzKjkzGPgiMDT941u7Q0k8hfd/bCHUH5shY4mkBRvlkk+RVyJp5tKcI
 Bn1F23Cvlmk3DfTX/q0zt1zFGDquc=
X-Google-Smtp-Source: AGHT+IEuBMIhStgv3CuqBuGlj1HEGMXUzCeUAzLPno22HtPpxnyXuALgEtaKAQnKke9naeiysyP7uDuUnjXlnNHWoPE=
X-Received: by 2002:a05:6902:260b:b0:e60:ad91:b1ac with SMTP id
 3f1490d57ef6-e635c135d23mr16725510276.11.1741607558516; Mon, 10 Mar 2025
 04:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-5-jerome.forissier@linaro.org>
 <CAC_iWj+kn1Ah98XthW_kGmNQHjKy=VEL9kd+PjVKV9phwJeVcQ@mail.gmail.com>
 <4c723e83-5287-4c94-8859-e1c49d6af927@linaro.org>
In-Reply-To: <4c723e83-5287-4c94-8859-e1c49d6af927@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Mar 2025 13:52:02 +0200
X-Gm-Features: AQ5f1JrfeRGpFSNg6h_VqDiH67TxqEqQOUGHrJyW8ZPAgEZAB9epJs6TPFQhLP4
Message-ID: <CAC_iWjLbpU-1NW5YzxuEauAizjLS1iB_tjMiCBWu2tbjuf189A@mail.gmail.com>
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

Hi Jerome,

[...]


> >>
> >> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >> +       cacert_initialized = true;
> >> +#endif
> >>         return CMD_RET_SUCCESS;
> >>  }
> >> +
> >> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >> +static int set_cacert_builtin(void)
> >> +{
> >> +       return _set_cacert(builtin_cacert, builtin_cacert_size);
> >> +}
> >>  #endif
> >>
> >> +#if CONFIG_IS_ENABLED(WGET_CACERT)
> >> +static int set_cacert(char * const saddr, char * const ssz)
> >> +{
> >> +       ulong addr, sz;
> >> +
> >> +       addr = hextoul(saddr, NULL);
> >> +       sz = hextoul(ssz, NULL);
> >> +
> >> +       return _set_cacert((void *)addr, sz);
> >> +}
> >> +#endif
> >> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
> >> +
> >>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >>  {
> >>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> >> @@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >>         memset(&conn, 0, sizeof(conn));
> >>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> >>         if (is_https) {
> >> -               char *ca = cacert;
> >> -               size_t ca_sz = cacert_size;
> >> +               char *ca;
> >> +               size_t ca_sz;
> >> +
> >> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >> +               if (!cacert_initialized)
> >> +                       set_cacert_builtin();
> >> +#endif
> >
> > The code and the rest of the patch seems fine, but the builtin vs
> > downloaded cert is a bit confusing here.
> > Since the built-in cert always gets initialized in the wget loop it
> > would overwrite any certificates that are downloaded in memory?
>
> The built-in certs are enabled only when cacert_initialized is false.
> set_cacert_builtin() will set it to true (via _set_cacert()), so it will
> happen only once. Note also that any successful "wget cacert" command
> will also do the same. So effectively these two lines enable the
> built-in certificates by default, that's all they do.

Ok, so if you download a cert in memory and have u-boot with a builtin
certificate, then the memory one will be overwritten in the first run.
This is not easy to solve, I was trying to think of ways to make the
functionality clearer to users.

Cheers
/Ilias
>
> Cheers,
> --
> Jerome
>
> >
> > [...]
> >
> > Cheers
> > /Ilias
