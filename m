Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86326C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E437875D1;
	Tue, 21 Nov 2023 03:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g2S7/FfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0811875FA; Tue, 21 Nov 2023 03:17:30 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62121869F6
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5cb8440a23cso2635547b3.3
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533043; x=1701137843; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p9jCbjBSD+Mzk35hIUv1mzA96HqU/7gK1Ja2Iesfifg=;
 b=g2S7/FfWuSMDHGY+Bu+We8aTaOH272vjOGbsZXOvjQxXgY9kYNihSqlYuKu6+Snq5+
 uoqvoh8/i5hwsQ/XmxKOFJscYj6mNvIZdjYDkN8bPPH3Q5jAw74M7E5ur8bzLeNSWNIc
 Ks+zA8Q3pFMyKG78vfzdbGmolPRHl02ivUXGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533043; x=1701137843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p9jCbjBSD+Mzk35hIUv1mzA96HqU/7gK1Ja2Iesfifg=;
 b=SQBHIBHqow7ShDIjSn2FBBP7Mu8AkvqcsgJGnFTGzMVVhKMItQyVqY3POoLHLUJXHG
 oksdhm784iB/lhv3Hu+9DVQelgIh2MdDp6OUcHe+KgurjWSauaJ8+FrFHawiAPPANIwd
 58IaRkb8mTlND+l2QRvURDgS7/zdy+vEoAFx7RVGAsoHehLlyXAlUk64QZO7DhHmja8H
 Mj+c4NFSxNW8H78hzMT3Xk8IjViCnb5AaakfaIVeWfbGJecdcemN8E7Z0SZ+aL9Vu41d
 TBy63HBtgHav/GZy8Hp2WeHbOI7cvLUxQnL8P0bS0RXmPrXewh0sHZ4MliU4iNwMbZl6
 CkfA==
X-Gm-Message-State: AOJu0YxCWK1JGoUjzO5tACcPg6kXr51l7VCqydQOE1J2htF0PeUWsOKL
 nWOMbVrWo5FfkTcAk2B6FE5FAuZOivNRFVS7LzM8dbbVZub8rbOmMPU=
X-Google-Smtp-Source: AGHT+IFXD1vgSVB0IJjygUZUZCUdGipGtKJXkL8OUOLXpTUmfsdXcWBPpAjc0Dm0On67+GlG8CdA4eXOLkksPt2ktxs=
X-Received: by 2002:a81:6c16:0:b0:5b3:46f2:fbd3 with SMTP id
 h22-20020a816c16000000b005b346f2fbd3mr9364214ywc.7.1700533042955; Mon, 20 Nov
 2023 18:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20231118210547.577026-1-sjg@chromium.org>
 <20231118210547.577026-8-sjg@chromium.org>
 <CAC_iWjKgDKb_S6+LySsK2AdzgLcSnSfEeBChTOO+4j8AdPuPLg@mail.gmail.com>
In-Reply-To: <CAC_iWjKgDKb_S6+LySsK2AdzgLcSnSfEeBChTOO+4j8AdPuPLg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:11 -0700
Message-ID: <CAPnjgZ0b0L9-RjamP2U15=8Rrx5NiZ=TmEG+zyAUarbTVop3CQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/32] bootm: Simplify arguments for bootm_pre_load()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
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

Hi Ilias,

On Mon, 20 Nov 2023 at 14:02, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Sat, 18 Nov 2023 at 23:06, Simon Glass <sjg@chromium.org> wrote:
> >
> > Move the argument decoding to the caller, to avoid needing to pass the
> > command-line arguments.
> >
> > Add a function comment while we are here.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> > ---
> >
> > (no changes since v1)
>
> [...]
>
> >
> >         if (IS_ENABLED(CONFIG_CMD_BOOTM_PRE_LOAD))
> > @@ -785,7 +794,7 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
> >                 ret = bootm_start();
> >
> >         if (!ret && (states & BOOTM_STATE_PRE_LOAD))
> > -               ret = bootm_pre_load(cmdtp, flag, argc, argv);
> > +               ret = bootm_pre_load(argv[0]);
>
> Is there a check for the validity of argv[0] before this call?

It is always valid since argv is NULL-terminated. So at worst, arg[0] is NULL.

>
> Thanks
> /Ilias
> >
> >         if (!ret && (states & BOOTM_STATE_FINDOS))
> >                 ret = bootm_find_os(cmdtp, flag, argc, argv);
> > --
> > 2.43.0.rc0.421.g78406f8d94-goog
> >

Regards,
Simon
