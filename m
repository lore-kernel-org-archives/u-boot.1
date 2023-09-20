Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A14C04FE4
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 18:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44CE86BE3;
	Wed, 20 Sep 2023 20:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lThjiiP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 797E486C0B; Wed, 20 Sep 2023 20:51:23 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29ED886BF7
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 20:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59c0d002081so1874237b3.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695235880; x=1695840680; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BI7B2ZNKkBrbdRJH+RbM4ShPd2tklFLPo0kGZfSzeMA=;
 b=lThjiiP4cPKGh50ZCXbQZUl/2gFfPrv6Oc0r9LjxHabY5QAUoULaMRL8a9Kuz9Qrxs
 cI8TtPzSjWBxL7iQTGrxKco5CjRb2hICKn/axmOSOw25Uze7X5ftUuh8iEbsTlSHM05S
 Nt9eFd6Q9cBXUrXMm1xRsQatejzVieXAAUUE9l2Fo/ADSdS+tyfs+a+bxkvrozQfOdb6
 4m1gl4H4lMMhAA3irAUTjHRuvwrTHCBdhYEZy2pOxhuajLZgpNj6iUsjW7zymw5yEEoN
 4ms86101sNY7x7bGp6fUB64ttkr1Koq+QBJ140aN97uLzsujwZAofSkD8u8AHPVzeZU+
 cN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235880; x=1695840680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BI7B2ZNKkBrbdRJH+RbM4ShPd2tklFLPo0kGZfSzeMA=;
 b=bJV57xvsp6MvHkiYhZEeXuhYZZXo17o3lcTWATgnwcedrOgWIMopFzszdBugWEK49f
 V7sAC/P/kc61B6v7VLevlhQ+EoLAT7H0OFjoLvSzbxGqrss4++R7gX3cePGF5Dlvb7Jv
 ihtbZNf8BLUK0lhFdFRQsJpItbcmOXIL+8Uk1b3j5Pf9GOD43CqYAtmD6dPhChyaTF9Z
 0FBPPF8sJTb5lXZDvWftxyW8yiUod4Vux/3yP5zeLvti/zu6iH41aWByZ2BdIPAb4SFS
 061eqVREOam/UUz1W6XmtS3uXsNbwpyB4k/2b+eynd16dgXlcBwl7CNOJ3j9ABCLrPw0
 zfzg==
X-Gm-Message-State: AOJu0YxEcPQFZPnfBw/hic0yaBgXN6IKiFW2LEfzxLajnGfW2cnRbTrN
 nZRBqGIJ1E8+RoyBB1mvuPWYzEM22HhjY3jQICiRSg==
X-Google-Smtp-Source: AGHT+IFt5TSeRgRzUpeQiUhbTT1DPNiRMyI/eUCBwIxQvYKt4pj2mJ8JCds7y63BXE+tcN4XwJGUE964IVvMQu0hfYA=
X-Received: by 2002:a25:680b:0:b0:d7b:985b:278f with SMTP id
 d11-20020a25680b000000b00d7b985b278fmr3454009ybc.16.1695235879742; Wed, 20
 Sep 2023 11:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230920074225.1130769-1-linus.walleij@linaro.org>
 <20230920142252.GO305624@bill-the-cat>
In-Reply-To: <20230920142252.GO305624@bill-the-cat>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Sep 2023 20:51:07 +0200
Message-ID: <CACRpkdYqO1nH51VxjbpnPjaPy7eHaMDCSP5tWBDB1SB3R0cCcQ@mail.gmail.com>
Subject: Re: [PATCH] bmips: Add Inteno XG6846 board
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
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

On Wed, Sep 20, 2023 at 4:22=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> > + * This is a diet version of the device tree from Linux,
> > + * suitable for U-Boot.
> > + */
>
> We shouldn't need a diet version of the tree.  If it's reasonably done
> and stable in the kernel, we can even move towards just passing the
> U-Boot tree along to Linux.

The device tree is not stable in the kernel.
It exists in OpenWrt and the creators of the bmips target are
kind of absent for the moment. The reason it is not in Linux
is that the "switch ethernet" driver and bindings need to be
upstreamed before the device trees can be upstreamed.

But I can try to bring in more of it for sure :)

> > +++ b/board/inteno/xg6846/xg6846.c
> > @@ -0,0 +1,6 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) 2023 Linus Walleij <linusw@kernel.org>
> > + */
> > +
> > +#include <common.h>
>
> So basically just an empty object file.  Can we just _not_ have
> something here, if we perhaps don't set SYS_BOARD?  I assume if there's
> just nothing here the link rules fail.

Admittedly my knowledge of U-Boot internals are not the
best and this is a bit of a copy and paste job from
board/comtrend/ar5387un/ar-5387un.c which looks like
this and sets a bad example I suppose.

I guess you are asking me to modify U-Boots build system to
make the whole .c and Makefile inside a board subdir optional
so we can delete all such empty boardfiles?

Yours,
Linus Walleij
