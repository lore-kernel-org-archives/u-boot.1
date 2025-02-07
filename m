Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9AAC0219D
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 22:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44FDE80756;
	Fri,  7 Feb 2025 23:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kZAZhf8/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6793F807AE; Fri,  7 Feb 2025 23:50:35 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1835D80017
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 23:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e5b1c7c31b2so2163010276.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 14:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738968632; x=1739573432; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/whP3d62I90sO++3pMNg6PtsrcsCXH0SIMmmc2yd5jQ=;
 b=kZAZhf8/9aeSijQUQfplz4o0LdbooFbIQWarbdOXyGz4XkSlb7TjpQ2BqI4PWd1E7d
 OksPjJXwtAEQdJGvtPdbawVO27rCLFmbNu6q+N4ddqiBi+ihWK44cadIVhYv/tDFkI26
 I9FGCfFhfQ6AjWNtS4snC9Y6dN8PhL0kK3q2BhXm+n6tUWRtQkOxsrgbAeePJASkIQzH
 5m8x4nwBtP0WiNLBuahjVhkUS3yMo/ktHQnR43i51CzHW8s+qHuW5dZB5pRE7722R6YG
 osqDYRUyg/aeXf1HfC/uzQJn4GnHTcYgMy7W2OBaywIL7npXL6q2REf1R1Feq49xhA5x
 9pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738968632; x=1739573432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/whP3d62I90sO++3pMNg6PtsrcsCXH0SIMmmc2yd5jQ=;
 b=uza/Az1AM3kX3kJvhiGcZ1GntzDGrj6rDL2AeGjz4mVXSd0ZGz/vRg3TuOQAENbr8o
 DUw+WZmhLl/rGkfFwYLAisp5v/CQmYU6SeqVV6Sm36/HuVkDis2X5h2suoIfjC7dyD13
 kqC4AQZwHJ0WapScxpHFL+w1lhX8JvzrwLFLRU3cBctxwv5UrpULvZUfuMPDiY3hKT9Z
 bhGJ8AlVcUpW2+msKQHGRiYPPSiAy7/NofKNgb8NKhh8N5D19AuADXR5g6thhF7zHfwq
 4kgJUtke0nxvq/SO5uzNrxA0UwtVH2e98BJSZi7XTlYG/01AVkvpgNXXaLKrQ7Cs2vIm
 mFlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrEXSxkpVWo1aXgxILe46EJhakOM0t8IpHSL7tsuSNDcyn5zwKZsGITFSS3llT6ux5Vntf+ZY=@lists.denx.de
X-Gm-Message-State: AOJu0YycEAstrqaLevl4Q6pasO9uKCdmJ7FIBoLbRwcyNrPy/Ng8Ovyw
 bX5BzY9cIwbTdw4nA2+/5RbfYTkYzkgfM6iKpz9KltZwxO3qmzCWSwMATZ8p4TzvJdXiSh6LxZP
 +EEUIYybhq23mxTpDDYL4nSFw0poMjlJQtlVaww==
X-Gm-Gg: ASbGnctOsSbcc050/oHhzyssxIt9//nWm98vOTS1p0LENW42jZi50oDvbzEhKMU2WoC
 hxQrCvhJ5kYCMhR6UHJq5jg+TQKin8HE3UA6z7W3+XA4kAHj6n+tzen/2UL9VuzZnh8FCPOxl
X-Google-Smtp-Source: AGHT+IGjnW6jFV3dGSZ24b1tuqVaOuh2v2c2d4gqyH1zHPP5EQGIL+72Ir4WZiVwo4aT8IguSJTYj8iCLdXcuprhDew=
X-Received: by 2002:a05:6902:1a47:b0:e58:36ad:a1ba with SMTP id
 3f1490d57ef6-e5b46c7d767mr4675898276.16.1738968631853; Fri, 07 Feb 2025
 14:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-2-semen.protsenko@linaro.org>
 <420bb6ae-adf3-41ba-a6a7-1553a1eabf81@gmx.de>
In-Reply-To: <420bb6ae-adf3-41ba-a6a7-1553a1eabf81@gmx.de>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 7 Feb 2025 16:50:21 -0600
X-Gm-Features: AWEUYZme17PVxOkr1k-2l_DuZhsx2DpviBflKk4-u6lT5k2u5gBTpTX1HnrXKFo
Message-ID: <CAPLW+4nce16YmzJT1djLJ21kMF+BMuR0LCQ7o8byvV61qxSKjA@mail.gmail.com>
Subject: Re: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jan 13, 2025 at 1:37=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 1/12/25 04:42, Sam Protsenko wrote:
> > Free memory allocated for 'order' (array of bootmeths) on error paths i=
n
> > bootmeth_setup_iter_order() function.
> >
> > Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeths sepa=
rately")
> > Fixes: 10d16faa436c ("bootstd: Detect empty bootmeth")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >   boot/bootmeth-uclass.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> > index 5b5fea39b3b3..ff36da78d5a1 100644
> > --- a/boot/bootmeth-uclass.c
> > +++ b/boot/bootmeth-uclass.c
> > @@ -133,8 +133,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter=
 *iter, bool include_global)
> >                * We don't support skipping global bootmeths. Instead, t=
he user
> >                * should omit them from the ordering
> >                */
> > -             if (!include_global)
> > -                     return log_msg_ret("glob", -EPERM);
> > +             if (!include_global) {
> > +                     ret =3D log_msg_ret("glob", -EPERM);
> > +                     goto err_order;
> > +             }
> >               memcpy(order, std->bootmeth_order,
> >                      count * sizeof(struct bootmeth *));
> >
> > @@ -188,8 +190,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter=
 *iter, bool include_global)
> >               }
> >               count =3D upto;
> >       }
> > -     if (!count)
> > -             return log_msg_ret("count2", -ENOENT);
> > +     if (!count) {
> > +             ret =3D log_msg_ret("count2", -ENOENT);
> > +             goto err_order;
> > +     }
> >
> >       if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && include_global &&
> >           iter->first_glob_method !=3D -1 && iter->first_glob_method !=
=3D count) {
> > @@ -200,6 +204,10 @@ int bootmeth_setup_iter_order(struct bootflow_iter=
 *iter, bool include_global)
> >       iter->num_methods =3D count;
> >
> >       return 0;
> > +
> > +err_order:
> > +     free(order);
> > +     return ret;
> >   }
> >
> >   int bootmeth_set_order(const char *order_str)
>
> bootmeth_setup_iter_order() is called when the `boot scan` command is
> executed. The command can be executed multiple times, shouldn't we free
> iter->method_order before reassigning it? Hopefully the field is NULL if
> not initialized.
>

I think it's already taken care of in do_bootflow_scan(), when it's
running bootflow_iter_uninit() in the end of the loop? The relevant
call chain looks like this:

do_bootflow_scan()
    bootflow_scan_first()
        bootflow_iter_init()
            memset(iter, 0)
        bootmeth_setup_iter_order()
            order =3D calloc()
            iter->method_order =3D order
    bootflow_scan_next()
    bootflow_iter_uninit()
        free(iter->method_order)

So bootmeth_setup_iter_order() is only called once for each 'bootflow
scan' execution, and it's always called with iter->method_order freed.

> Best regards
>
> Heinrich
>
