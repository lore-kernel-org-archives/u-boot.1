Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B76CC28B2E
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 13:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5B280107;
	Mon, 10 Mar 2025 14:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vh0M4y9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310CB812D9; Mon, 10 Mar 2025 14:05:04 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE4A88006D
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e589c258663so3616401276.1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741611900; x=1742216700; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xU9ucVMBLg4fIdSoTN3c99ECqLfRChVONadxbooI3mY=;
 b=Vh0M4y9Nvvsq/BUwZTw9ATgHK86PZhYGkh1fLNmVtf05gJn3xc/Bx84uyHvyH4CVdp
 5VOjGRm5IDuIia0tDH6sXkrTJSfSTOQBomQfsEIKk5wYA6sodriH0ISDrUjABb5rKNVy
 RElT7r311OvF6avyOsNkS2/UHKl7qA26CBPsF2RqFrpuaD+2OZ7X6sBMDPT0Tx9sRdV/
 t4RQ0AxO2PewLsHYdST/U3xijln7Ou238XK4416Sh0D9QobjEx5Epqr9W3hlz/M3CXJV
 8K3GB8DLAPk54BX04qRLBTCWC5loi/ftN8wdzzaRUrNWIRno0Gvjn6Mlo+kz6RZhEjlD
 S+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741611900; x=1742216700;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xU9ucVMBLg4fIdSoTN3c99ECqLfRChVONadxbooI3mY=;
 b=Wu9LUglCMtcT0pvvWTWa8YIo+gCnsW13gov7FQhs+8etCBxH7gCzJDBQ5cacHZSYoF
 66bq1VvQz4dZS7Y3GjE+hp67eGNTvBBty2YckuSM1de3U/ya0CF9O9B4T10UIsD6EbGo
 J+f8bogk89XzG38K2Vf8xrufjuCWOjY48LxBI/LX4o9bfOe8Rqnlp06Kf6eMqwvH//kn
 y/uPGqLtgWkwshS6RMpYrRlpn1oEv50LZ/7IzaSlC9zLv6YAuCbj4MSbR35V8pG7+Y2R
 5KdMZ3BxitV4iy7XGe0QAlxt/y0G5Yxt3QCXXdXrn3rDT9AOD4JrIMU5T6iL2omsa2BK
 EeDQ==
X-Gm-Message-State: AOJu0YyZ6agBQB32LXpNT7E7I3Fie364YJ1ltQ2Uw1Cut5nzATJGzYVZ
 sDth6E+FpjtHJltMaM021EJRBpnsLqyaxwlCEnDp4X64b+cW4myXsmzwSKbHyou/GDI1qY8ykQT
 5tJG7T9BcvZcoVrTNeHVBT1Sicn/9As9skn+tng==
X-Gm-Gg: ASbGncsSUQ2cBAF4t05G9cunEDmY0jlzmQDBcESsCXJhAuappRuGUDDPIRYRXqfngki
 FQF/v6qkeRUz+SjJD7PLc8YFe3G/CJzmPLliKMOm0VUYdENor+SlSvHdTt6x/lIvh1vQBg/GKEJ
 WE53exrsfnB/x2XFnBTUhIgR7Y4PY=
X-Google-Smtp-Source: AGHT+IEqvLVNgugm1CgEtEYogKMAaUW2p+2+zJvbsLuFZByHEnQ2HMywj66J6vDk9Nl03wHMm9Fa6XjLZZcKD4xzS24=
X-Received: by 2002:a05:6902:100d:b0:e60:6b6f:f5e9 with SMTP id
 3f1490d57ef6-e635c121fd5mr16942800276.10.1741611900582; Mon, 10 Mar 2025
 06:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250305142650.2966738-1-jerome.forissier@linaro.org>
 <20250305142650.2966738-5-jerome.forissier@linaro.org>
 <CAC_iWj+kn1Ah98XthW_kGmNQHjKy=VEL9kd+PjVKV9phwJeVcQ@mail.gmail.com>
 <4c723e83-5287-4c94-8859-e1c49d6af927@linaro.org>
 <CAC_iWjLbpU-1NW5YzxuEauAizjLS1iB_tjMiCBWu2tbjuf189A@mail.gmail.com>
 <684ad95c-eff2-4ed4-a305-670977eff7ed@linaro.org>
 <CAC_iWjLwbtqLmr71rqEuM2c01LNe09W7xVdZvT9XCH+ivsjd-g@mail.gmail.com>
 <baf67248-1d3d-4489-b900-e15b48ca4c1e@linaro.org>
In-Reply-To: <baf67248-1d3d-4489-b900-e15b48ca4c1e@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Mar 2025 15:04:24 +0200
X-Gm-Features: AQ5f1JqGDV0cMD1vabLW8wMjwUOmCfCMICnxFLr9q1EivZZ7gBDvAWOH2u3McOc
Message-ID: <CAC_iWj+FEusnb8jSkGSyLyjcM8ejJELtc1+swsTK6JKQ1+NG2w@mail.gmail.com>
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

On Mon, 10 Mar 2025 at 14:48, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 3/10/25 13:38, Ilias Apalodimas wrote:
> > On Mon, 10 Mar 2025 at 14:13, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >>
> >>
> >> On 3/10/25 12:52, Ilias Apalodimas wrote:
> >>> Hi Jerome,
> >>>
> >>> [...]
> >>>
> >>>
> >>>>>>
> >>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >>>>>> +       cacert_initialized = true;
> >>>>>> +#endif
> >>>>>>         return CMD_RET_SUCCESS;
> >>>>>>  }
> >>>>>> +
> >>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >>>>>> +static int set_cacert_builtin(void)
> >>>>>> +{
> >>>>>> +       return _set_cacert(builtin_cacert, builtin_cacert_size);
> >>>>>> +}
> >>>>>>  #endif
> >>>>>>
> >>>>>> +#if CONFIG_IS_ENABLED(WGET_CACERT)
> >>>>>> +static int set_cacert(char * const saddr, char * const ssz)
> >>>>>> +{
> >>>>>> +       ulong addr, sz;
> >>>>>> +
> >>>>>> +       addr = hextoul(saddr, NULL);
> >>>>>> +       sz = hextoul(ssz, NULL);
> >>>>>> +
> >>>>>> +       return _set_cacert((void *)addr, sz);
> >>>>>> +}
> >>>>>> +#endif
> >>>>>> +#endif  /* CONFIG_WGET_CACERT || CONFIG_WGET_BUILTIN_CACERT */
> >>>>>> +
> >>>>>>  static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >>>>>>  {
> >>>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> >>>>>> @@ -373,8 +401,15 @@ static int wget_loop(struct udevice *udev, ulong dst_addr, char *uri)
> >>>>>>         memset(&conn, 0, sizeof(conn));
> >>>>>>  #if CONFIG_IS_ENABLED(WGET_HTTPS)
> >>>>>>         if (is_https) {
> >>>>>> -               char *ca = cacert;
> >>>>>> -               size_t ca_sz = cacert_size;
> >>>>>> +               char *ca;
> >>>>>> +               size_t ca_sz;
> >>>>>> +
> >>>>>> +#if CONFIG_IS_ENABLED(WGET_BUILTIN_CACERT)
> >>>>>> +               if (!cacert_initialized)
> >>>>>> +                       set_cacert_builtin();
> >>>>>> +#endif
> >>>>>
> >>>>> The code and the rest of the patch seems fine, but the builtin vs
> >>>>> downloaded cert is a bit confusing here.
> >>>>> Since the built-in cert always gets initialized in the wget loop it
> >>>>> would overwrite any certificates that are downloaded in memory?
> >>>>
> >>>> The built-in certs are enabled only when cacert_initialized is false.
> >>>> set_cacert_builtin() will set it to true (via _set_cacert()), so it will
> >>>> happen only once. Note also that any successful "wget cacert" command
> >>>> will also do the same. So effectively these two lines enable the
> >>>> built-in certificates by default, that's all they do.
> >>>
> >>> Ok, so if you download a cert in memory and have u-boot with a builtin
> >>> certificate, then the memory one will be overwritten in the first run.
> >>
> >> No, because the downloaded cert must have be made active via "wget cacert
> >> <addr> <size>", which will set cacert_initialized to true, and thus the
> >> built-in certs won't overwrite them. Or did I miss something?
> >
> > Nop I did, when reading the patch. But should the command that clears
> > the downloaded cert set cacert_initialized; to false now?
>
> It's probably easier if it does not, so that "wget cacert 0 0" really clears
> the certs. We have a command to restore the built-in ones ("wget cacert
> builtin").

So right now if  a user defines a builtin cert it will be used on the
first download. If after that he defines a memory one, that will be
used on the next download, but if he unloads it shouldn't the built in
be restired automatically?

Thanks
/Ilias
>
> Thanks,
> --
> Jerome
>
> >
> > Thanks
> > /Ilias
> >>
> >> Cheers,
> >> --
> >> Jerome
> >>
> >>> This is not easy to solve, I was trying to think of ways to make the
> >>> functionality clearer to users.
> >>>
> >>> Cheers
> >>> /Ilias
> >>>>
> >>>> Cheers,
> >>>> --
> >>>> Jerome
> >>>>
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>> Cheers
> >>>>> /Ilias
