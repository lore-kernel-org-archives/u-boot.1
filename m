Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C18C0218C
	for <u-boot@archiver.kernel.org>; Sat, 25 Jan 2025 23:39:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7496680F56;
	Sun, 26 Jan 2025 00:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kHcH9xMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7368880F58; Sun, 26 Jan 2025 00:39:33 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB5B80F53
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 00:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d41848901bso6642641a12.0
 for <u-boot@lists.denx.de>; Sat, 25 Jan 2025 15:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737848371; x=1738453171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ybj83ZdR5BDYxKiKuqNZQndE1iam45/AzBGRor3+g6A=;
 b=kHcH9xMY1uP8RSEw3YxkLV4SHk3cz9yyynJgQAmeXMdaMWqcGCug2P9X/OgtLxGTrG
 ygc4ez8BXi8nxv63CPdpVKLPdJhqm6A5ol6oyaWvXA+S5F4yf19Yv8g3fwTPpS354Ids
 vcwYQzVKwcrheVhaDk/zd7g6uSPilnAvRNLoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737848371; x=1738453171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybj83ZdR5BDYxKiKuqNZQndE1iam45/AzBGRor3+g6A=;
 b=R0xD1W/ziRYwQXwEGPbQR7uICrWGSoalUyG4M78FMqtZpCz6ZOU2ouvRxaiiPvcUdi
 IjKh+bLOBZl2GWHaQuXUCSOunX8s2i9X8woJrcH2MXmL9rOAbrFKDCo5FE6xnOBEydVa
 xjWlvABjFNqt6M9+rOpuStE63eri8yS3D+FIkSBzT4bWsFRlHnsGYRpLEXetM1hpjeZr
 6z5bVJyEgYQH5AW5unMqO8vFN28x5A4Z4Ql8DTtFDUalnMv1PDZTaQ/FJqNquzo8H5NP
 ooghjASAYW5urTaHXGWyrPwg520LytiQWRkyDp0/dX+neRac2EMfBwwyKmQJsDfyn+Dl
 Dg/A==
X-Gm-Message-State: AOJu0YxrCjIfShiZZZ/kurYMkZFV+1go6HL6Sqx/U363j3fYz0G59deJ
 FoLqS9ijbafjClzL3rV46FBsEWCtq+XP53RYHa7AqsIwnvGAWIthOZ/ep7zK/uy4DSYg3DjUwWl
 5dclgCxTJnUtYVTMu5wazJ8nnrQCTCMeABCK+OUtOnUrb/kY=
X-Gm-Gg: ASbGncs8Jkf4sOUcHAYFGAwngqvpGinDeT7d1OPxD3CcTyWHjy6UWpELHm7w2+KKBN2
 gKFqrjCLzwBSa/oUnNnfQSVbVMyW3X1lyOkI8QVKCTGCe099vfc9b2PXp/vw+5Wk=
X-Google-Smtp-Source: AGHT+IGpWUzyLs2/uLsdcit7qhkZtlo0mxaWCwhQrOB3MEku8WtD/N4PGjZa+nJoSHRx+Cxit1G/GvWZZavw1dFmH+Y=
X-Received: by 2002:a05:6402:274f:b0:5d0:e9a8:4c96 with SMTP id
 4fb4d7f45d1cf-5dc07db8e80mr11056668a12.9.1737848370871; Sat, 25 Jan 2025
 15:39:30 -0800 (PST)
MIME-Version: 1.0
References: <20250125213150.1608395-1-sjg@chromium.org>
 <20250125213150.1608395-4-sjg@chromium.org>
 <20250125214317.GC60249@bill-the-cat>
 <CAFLszTg+ZFn55j31CZMisvjg-e25R+q57pW-Dt-6zFqjSVwwtw@mail.gmail.com>
 <20250125230200.GM60249@bill-the-cat>
In-Reply-To: <20250125230200.GM60249@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 25 Jan 2025 16:39:19 -0700
X-Gm-Features: AWEUYZlUSwvupM0PxzrZAyfjihT921KW-VQbbxCx6TbiWuQtIjYFBLT4yCcIK2E
Message-ID: <CAFLszTiyE+9x+dRxznic__y1P2XDcFFiMn1_9w5HqF_v3AQHMA@mail.gmail.com>
Subject: Re: [PATCH 3/4] test/py: Show info about module-loading
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

On Sat, 25 Jan 2025 at 16:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 25, 2025 at 04:00:05PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 25 Jan 2025 at 14:43, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Jan 25, 2025 at 02:31:38PM -0700, Simon Glass wrote:
> > > > It is sometimes tricky to figure out what modules test.py is loading
> > > > when it starts up. The result can be a silent failure with no clue as to
> > > > what when wrong.
> > > >
> > > > Add a section which lists the modules loaded as well as those not
> > > > found.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  test/py/conftest.py | 33 ++++++++++++++++++++-------------
> > > >  1 file changed, 20 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/test/py/conftest.py b/test/py/conftest.py
> > > > index 5096c20ed65..23435b7db3c 100644
> > > > --- a/test/py/conftest.py
> > > > +++ b/test/py/conftest.py
> > > > @@ -286,19 +286,26 @@ def pytest_configure(config):
> > > >      ubconfig = ArbitraryAttributeContainer()
> > > >      ubconfig.brd = dict()
> > > >      ubconfig.env = dict()
> > > > -
> > > > -    modules = [
> > > > -        (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > > > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > > > -        (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> > > > -            board_identity_filename),
> > > > -    ]
> > > > -    for (dict_to_fill, module_name) in modules:
> > > > -        try:
> > > > -            module = __import__(module_name)
> > > > -        except ImportError:
> > > > -            continue
> > > > -        dict_to_fill.update(module.__dict__)
> > > > +    not_found = []
> > > > +
> > > > +    with log.section('Loading lab modules', 'load_modules'):
> > > > +        modules = [
> > > > +            (ubconfig.brd, 'u_boot_board_' + board_type_filename),
> > > > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename),
> > > > +            (ubconfig.env, 'u_boot_boardenv_' + board_type_filename + '_' +
> > > > +                board_identity_filename),
> > > > +        ]
> > > > +        for (dict_to_fill, module_name) in modules:
> > > > +            try:
> > > > +                module = __import__(module_name)
> > > > +            except ImportError:
> > > > +                not_found.append(module_name)
> > > > +                continue
> > > > +            dict_to_fill.update(module.__dict__)
> > > > +            log.info(f"Loaded {module}")
> > > > +
> > > > +        if not_found:
> > > > +            log.warning(f"Failed to find modules: {' '.join(not_found)}")
> > > >
> > > >      ubconfig.buildconfig = dict()
> > >
> > > We won't see this warning normally, only if some level of verbosity is
> > > used, yes? It's normal to not have both u_boot_boardenv files for
> > > example.
> >
> > There is a '[-] Section: Loading lab modules' section so you only see
> > it if you open that.
> >
> > I feel that test.py is a bit cryptic at present.
>
> I don't follow you, sorry. Open what where?

I mean that the section is collapsed unless you click to open it (when
viewed in a web browser).

Regards,
SImon
