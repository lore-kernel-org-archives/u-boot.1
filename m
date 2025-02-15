Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63187C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 12:18:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E83F580E88;
	Sat, 15 Feb 2025 13:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YmxB89bL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 627D280E88; Sat, 15 Feb 2025 13:18:02 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB2F80C6F
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 13:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5de3c29ebaeso3803756a12.3
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739621880; x=1740226680; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cazztR7L7I5VDopKcpsf4Wf8nV3BQXotEqBdETJfGrM=;
 b=YmxB89bLx9mYGKWgdEOJ5pLfa5qCXeFWoNVc9JpzpEa98o43ZapXgDcxBoRHTo6y7J
 7RgT6d6RiE2pNd/q/Zhwyvbj1ActbodBfw0ULzYz2Gq8PbWvvgeMKMfRI4+ciF2GUOyH
 Eid5KmIskMKKcUkWAEhSMnfCFE2+LMn7tjECo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739621880; x=1740226680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cazztR7L7I5VDopKcpsf4Wf8nV3BQXotEqBdETJfGrM=;
 b=inXXaQpiQYsxWVcpB49a+QI1L0IErDFyozkk/lyOoeML6eiia5dxqqolBDIwJQcDx5
 Z4z5eH5J7jtumKn2JiM2LuBX89XlOmwJwHUgCX0RYoeGgHu6MF6cFrqM3qW1sXepKByv
 cRr4sijQsXBJZ+D6B9SP5RZbJOS+XfXc7Oja+jV5SjhQh9QCbv7votdLO0d88DBd0Qa+
 0n8fVRBPYZTolEsv/kfwO+0sKglEfog0E+NTkOWVvxXwI9soZN6A+PZDbO+gFf6IlIlN
 9X/zhZgcycejban0LtzECMKSH1lDBBgaIfA/7J99AM3FCraSrYYOXeeZPNxMJdbmmmBC
 iWZQ==
X-Gm-Message-State: AOJu0YyTSydAiN4A/zNXb7x24p989T8QvkSqfQeREXpayTN/IoxDJAgv
 EJXXAh5Y87WAiL0Mhwx/B7Ic4HbiLT788zm45UG7daayWXn4/9TI6h+oPzcoE3sqEzL6jWE0I36
 iIPP8a7ZjuqVfTJwi95YUDDnZjz6M7raMwIlq
X-Gm-Gg: ASbGnctXgsRbiO11muY3ZnFJLkH5hejlKKt1YLjmiwpaMdwA3AmiC7JoChGiMzSrl0E
 t0tGZqgE36vc96F6kDb8Z3OMrAh2dm5MbteZphU1vUzCaMKR1aylkbrynFGZM4NP1zzGxdQMPpw
 ==
X-Google-Smtp-Source: AGHT+IESaSs3toR3/MwdrI/krmv0SP2uhIDeMAxWY7dEOAmwMtnCnmp0Asy+R27fxZd/MLU5m/jjM7qdwI9cDjB4gTw=
X-Received: by 2002:a17:906:c10f:b0:abb:6f30:32c3 with SMTP id
 a640c23a62f3a-abb70b29567mr231534666b.24.1739621879811; Sat, 15 Feb 2025
 04:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20250209160725.1054845-1-sjg@chromium.org>
 <20250209160725.1054845-6-sjg@chromium.org>
 <20250210155252.GL1233568@bill-the-cat>
In-Reply-To: <20250210155252.GL1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 05:17:48 -0700
X-Gm-Features: AWEUYZkF3RAJ_UbWbh5Y3GhQ3F0S3mittiBy1PE0We5h5aLQZsuzyhhTSuMZ_Mc
Message-ID: <CAFLszTh=AuLyxUhpR5FbWbvS6xkwnnhA1Hf-nuMd+7=wOZZyNg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] test/py: Show info about module-loading
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, 
 Stephen Warren <swarren@wwwdotorg.org>
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

On Mon, 10 Feb 2025 at 08:52, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Feb 09, 2025 at 09:07:18AM -0700, Simon Glass wrote:
>
> > It is sometimes tricky to figure out what modules test.py is loading
> > when it starts up. The result can be a silent failure with no clue as to
> > what when wrong.
> >
> > Add a section which lists the modules loaded as well as those not
> > found.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  test/py/conftest.py | 33 ++++++++++++++++++++-------------
> >  1 file changed, 20 insertions(+), 13 deletions(-)
> >
> > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > index 8d0e786ee5c..e59897c1f78 100644
> > --- a/test/py/conftest.py
> > +++ b/test/py/conftest.py
> > @@ -289,19 +289,26 @@ def pytest_configure(config):
> >      ubconfig = ArbitraryAttributeContainer()
> >      ubconfig.brd = dict()
> >      ubconfig.env = dict()
> > -
> > -    modules = [
> > -        (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> > -            board_identity_filename),
> > -    ]
> > -    for (dict_to_fill, module_name) in modules:
> > -        try:
> > -            module = __import__(module_name)
> > -        except ImportError:
> > -            continue
> > -        dict_to_fill.update(module.__dict__)
> > +    not_found = []
> > +
> > +    with log.section('Loading lab modules', 'load_modules'):
> > +        modules = [
> > +            (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> > +                board_identity_filename),
> > +        ]
> > +        for (dict_to_fill, module_name) in modules:
> > +            try:
> > +                module = __import__(module_name)
> > +            except ImportError:
> > +                not_found.append(module_name)
> > +                continue
> > +            dict_to_fill.update(module.__dict__)
> > +            log.info(f"Loaded {module}")
> > +
> > +        if not_found:
> > +            log.warning(f"Failed to find modules: {' '.join(not_found)}")
>
> Since no platform contains all of those files this is too verbose.

So perhaps only show the message if all files are missing?

Regards,
Simon
