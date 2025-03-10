Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36565C28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AAD68122F;
	Mon, 10 Mar 2025 13:39:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ov57wq+C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA310812D9; Mon, 10 Mar 2025 13:39:00 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C12811C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6febbd3b75cso31651777b3.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741610337; x=1742215137; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LwziXEujwuukb1ObUcbZazDAHuj5LSMTd5kltWavAXM=;
 b=ov57wq+C2WKU67ZG0TVdOlvIIP6/JMUi8b5tnw4FtlK6ALHTs/Q1RnB11V/JpvYNe4
 uS3N6LvZLLz0ZqBXL4xKqWJQLPkPQCtgG4i67dM+juq7H3+i8MuG2gw04rvITzkDKksP
 0WnGGewK+I6wLXmppWWUeSmg5vwrxqPFuYX5p8uUyhDA/v9xfXbVEY+hetINI2IUBmrg
 HNVVH5sGvD0XAjCR05a2M7ssnWcDMJmgvOUjepmLEt97qKhXNNqqpyGih+IWHPSO0c75
 VuVxjP6/62h0NGUO0GrdxmWUIMr+zVZqyEH85Jhdk+DvEfdJzgXhYCFHOkq63SJ6vroF
 JiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741610337; x=1742215137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LwziXEujwuukb1ObUcbZazDAHuj5LSMTd5kltWavAXM=;
 b=JE3PFHCLIeOFxKV4MkHFsXKrp8v1ReHjXpgoYVqUJDuKD52gQO9YdYzCzv3ZpWgJwo
 nA+WfLTl4gpcMTdYhqhOP6g27YkK1WQz95edtpOWlvGhoBpJk2y0LFaCpY5vEUWf9TjX
 gXX5hOZ3iMwMJrP29Oou2KQ6IBo/U7oUlIXCLTlmfRn0Tw93sqzh+gp/inSAngm5gPFr
 Xkkfu+JV0ujFY74SjX/OS4z5d0ruIogVFcgOVgtm5GwlJRt14SkulV4E5rVBqPMS2nMC
 sUFVJSPLF/0TfBhHEyQV1jctPT0ytx6xl4UJT+RSU12Cz3TektxvmHgnY5SBgjjlifLW
 0F8Q==
X-Gm-Message-State: AOJu0Yw/DKeHzTB+ApEtOsSEurIYKV6L0tCLXBgUBHA/CJdev/YowFNZ
 ZrDDzwmXdWUBSEMtyoOv0mdUKfQvwcSP+MtWgg7PkYOtnZfKOgK3J4f6W4nDoQI2lbjPn0N7Bkx
 ZUDcDMwrCgZifXgwOSxHrWdvPaAsniop7Nq+Reg==
X-Gm-Gg: ASbGncvJ1Nk0ONEM4jdu2lnHM/HLa8scGELuHHY+bv4cIRRgbHYLVkmloR/mmTPZO5Q
 HgkP5+f7O++S2tQwRWy55JxQ3UL7MxRJP/8MlGstLuKc5Lt3AG++2rElybXw3fiIB4Jv+ZTscsO
 XLGrBe9lXJ5XD+RNp9JHmT5DfuPws=
X-Google-Smtp-Source: AGHT+IHpvdmTgkUzX3mUqvQSHtMJ45iKTUIQ3iTzGX3PWiXPV1HQLAaNUjHJMVlhGLblt3gUQMrUAMmzxN4gHV5hhfQ=
X-Received: by 2002:a05:690c:45c1:b0:6fb:1f78:d9ee with SMTP id
 00721157ae682-6febf2fa005mr182880707b3.15.1741610337184; Mon, 10 Mar 2025
 05:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-5-jerome.forissier@linaro.org>
 <CAC_iWj+kn1Ah98XthW_kGmNQHjKy=VEL9kd+PjVKV9phwJeVcQ@mail.gmail.com>
 <4c723e83-5287-4c94-8859-e1c49d6af927@linaro.org>
 <CAC_iWjLbpU-1NW5YzxuEauAizjLS1iB_tjMiCBWu2tbjuf189A@mail.gmail.com>
 <684ad95c-eff2-4ed4-a305-670977eff7ed@linaro.org>
In-Reply-To: <684ad95c-eff2-4ed4-a305-670977eff7ed@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Mar 2025 14:38:20 +0200
X-Gm-Features: AQ5f1Jql1yDKIK4xiHx7q2wBOA3k-ZZmIqlUxbF1rT1AAe0PruIMsZxYaSIMZEI
Message-ID: <CAC_iWjLwbtqLmr71rqEuM2c01LNe09W7xVdZvT9XCH+ivsjd-g@mail.gmail.com>
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

On Mon, 10 Mar 2025 at 14:13, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 3/10/25 12:52, Ilias Apalodimas wrote:
> > Hi Jerome,
> >
> > [...]
> >
> >
> >>>>
> >>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >>>> +       cacert_initialized = true;
> >>>> +#endif
> >>>>         return CMD_RET_SUCCESS;
> >>>>  }
> >>>> +
> >>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >>>> +static int set_cacert_builtin(void)
> >>>> +{
> >>>> +       return _set_cacert(builtin_cacert, builtin_cacert_size);
> >>>> +}
> >>>>  #endif
> >>>>
> >>>> +#if CONFIG_IS_ENABLED(WGET_CACERT)
> >>>> +static int set_cacert(char * const saddr, char * const ssz)
> >>>> +{
> >>>> +       ulong addr, sz;
> >>>> +
> >>>> +       addr = hextoul(saddr, NULL);
> >>>> +       sz = hextoul(ssz, NULL);
> >>>> +
> >>>> +       return _set_cacert((void *)addr, sz);
> >>>> +}
> >>>> +#endif
> >>>> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
> >>>> +
> >>>>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >>>>  {
> >>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> >>>> @@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >>>>         memset(&conn, 0, sizeof(conn));
> >>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> >>>>         if (is_https) {
> >>>> -               char *ca = cacert;
> >>>> -               size_t ca_sz = cacert_size;
> >>>> +               char *ca;
> >>>> +               size_t ca_sz;
> >>>> +
> >>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >>>> +               if (!cacert_initialized)
> >>>> +                       set_cacert_builtin();
> >>>> +#endif
> >>>
> >>> The code and the rest of the patch seems fine, but the builtin vs
> >>> downloaded cert is a bit confusing here.
> >>> Since the built-in cert always gets initialized in the wget loop it
> >>> would overwrite any certificates that are downloaded in memory?
> >>
> >> The built-in certs are enabled only when cacert_initialized is false.
> >> set_cacert_builtin() will set it to true (via _set_cacert()), so it will
> >> happen only once. Note also that any successful "wget cacert" command
> >> will also do the same. So effectively these two lines enable the
> >> built-in certificates by default, that's all they do.
> >
> > Ok, so if you download a cert in memory and have u-boot with a builtin
> > certificate, then the memory one will be overwritten in the first run.
>
> No, because the downloaded cert must have be made active via "wget cacert
> <addr> <size>", which will set cacert_initialized to true, and thus the
> built-in certs won't overwrite them. Or did I miss something?

Nop I did, when reading the patch. But should the command that clears
the downloaded cert set cacert_initialized; to false now?

Thanks
/Ilias
>
> Cheers,
> --
> Jerome
>
> > This is not easy to solve, I was trying to think of ways to make the
> > functionality clearer to users.
> >
> > Cheers
> > /Ilias
> >>
> >> Cheers,
> >> --
> >> Jerome
> >>
> >>>
> >>> [...]
> >>>
> >>> Cheers
> >>> /Ilias
