Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93101D462B3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 14:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCBBF89049;
	Wed, 13 Nov 2024 15:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kmfWAKkT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4579C8958A; Wed, 13 Nov 2024 15:43:11 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5643388F94
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:43:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9ed7d8c86cso1238588866b.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731508989; x=1732113789; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a1I/D5ZwELYJJ+WwauwzmhP2Njua5rvBapkIzIIFEG0=;
 b=kmfWAKkTjYjraxAny9fPHMphTM2c9gWCjNxW03tMoYUHjPTc6oXDhGNQivBpfs/WNV
 tOSRzAPhFkU3h7w5jWRdjm3zccMVA5W0OqWLttj42nY+foIdT0QzTXCrpIESVxnPavde
 gWIW72zIokJk91gMKp4ngdZZeTnpgGTVPf9ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731508989; x=1732113789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a1I/D5ZwELYJJ+WwauwzmhP2Njua5rvBapkIzIIFEG0=;
 b=b89VVkj2M0R4tps1pFDlhIAoVsPx5psg0f1ZbCFPbaa+7TEgZbcL/HirkF789/UYL9
 701NeAxFs8tdl+R7aUiTw2a4ZUmadtQROAWOlbmegEOJHKL5acHB+Ehu+fNq3qJEVXnE
 xCupwAL9ZuzsPeyASpMeyJAp0TGoued7wnB9CBDnOsFh5n922sWTpqv74vhp1yB3elCj
 gB+ZZ+EONWCMcUrxBkC0N2p6zs3AULUqUpcQ3qmoXsWuEe0xK6aNpDuQU3KqR2FIqJyl
 2UPW0RzXCe2hHAdAsQlphozyfgB7+qiec0Vo8Yi9yshIskio5CXxMCB+EUn5/XNAK8UX
 Nc8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKPMpUga6mYz0236w+vwmGHJ5t3i7O8z/jk1NcI1pJWWP0IHCRY5uBS8vm7tTy/Mq+nqzGGtE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxcm2dtU3ac5PwrXpkB2qz5i20rySDIhXUg/3EUDIIEKsxaYqOn
 K+7+vCyTfqIUNZpWyiqXTZsI0DAvFpbpZCuTkGcxbxZSdn5ZmJPdaMubgvNhYYFhT3j5YfefxgM
 9RwgWGESrC1YNPKOuzUa0eM8oqBSTdDF5eWFv
X-Google-Smtp-Source: AGHT+IHdFwk+L15XUPePapdtkSfgoP+t7Cp5NehS4zN9cFxwUGTC+Y33Ecm8Xr09LF9lcOpM2JTWO2clJ7pPgkmL0ng=
X-Received: by 2002:a17:906:9c83:b0:aa1:e60e:6fe6 with SMTP id
 a640c23a62f3a-aa1f8039a10mr331934866b.12.1731508988638; Wed, 13 Nov 2024
 06:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
 <CAFLszTjhzw8i-28V+V8M+v41x5Y46vqeDOW+DyCP0JOKdszf7Q@mail.gmail.com>
 <20241113141233.GK3600562@bill-the-cat>
In-Reply-To: <20241113141233.GK3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Nov 2024 07:42:57 -0700
Message-ID: <CAFLszTi1j9_waTPUs06CXcHRYnqKjDW9NPrc=sYkW70Cs7pMTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] lib: provide function hextoull()
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

Hi Tom,

On Wed, 13 Nov 2024 at 07:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 13, 2024 at 06:39:43AM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Sun, 3 Nov 2024 at 15:42, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >
> > > We often convert hexadecimal strings to hextoull(). Provide a wrapper
> > > function to simple_strtoull() that does not require specifying the radix.
> > >
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > > v2:
> > >         no change
> > > ---
> > >  include/vsprintf.h | 13 +++++++++++++
> > >  lib/strto.c        |  5 +++++
> > >  2 files changed, 18 insertions(+)
> >
> > Could you add a test?
>
> We have tests already for this. But they weren't being run, which is
> covered by 4/4.

I'm not seeing a test for hextoull(). Where are you looking?

There is a test for hextoul() in test/str_ut.c

Regards,
Simon
