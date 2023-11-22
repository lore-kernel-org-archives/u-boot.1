Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7601CC072A2
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 05:23:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C90198747E;
	Wed, 22 Nov 2023 06:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TkqE3CaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29B738747E; Wed, 22 Nov 2023 06:23:49 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B97B187563
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 06:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5484ef5e3d2so6875057a12.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700630626; x=1701235426; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vfitGJCZ/IRY7+o6LxW1nKvplffSzyp8eFX2Y1axCcg=;
 b=TkqE3CaVNcoCex3AAn660Srv79QikE9W6Z1nm27a9sm+88IYbwXuxmGeBA4mOeDU/m
 3wpr1krXU8uG8me0OViuQl4t6PbwOCpkK7O/bKVYDlusN8rf86HnT/3rRHSEEhdz4w8T
 0bbUE3TJjLFxLEOkH97Qkw7Blj9l3daDUafyJOWaOPW0KLz1p4y79F68eYYJBp9p37h9
 ONisic8mZ7c/CQfnzDvX6IrofR6aZ2dEct1VKOeZJVCIWtM6WVzpcefPC3exvQKi9sGM
 2SqJhfZ97ZjAE7A+YzM2RbjsfhyUG0D2k5WiyHWnhoZKcn20utQQ2WI7MYNeZrhDbCsI
 L14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700630626; x=1701235426;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vfitGJCZ/IRY7+o6LxW1nKvplffSzyp8eFX2Y1axCcg=;
 b=fpHqXPAesbXAsmGLugv64f/cq/SuVYmCKPZwduinJS0M+N8qYIbTHQYiMbGVN5UWVh
 NCvMfT38VXWQgM4MDR4Yt00Ukw/1gFAlalNhei/Uwr45NiXtM2+YEqWIxrkHYN4n9o7d
 hfbdxD7a4wnOWj2I8GGZIECiUea9zon7DgwFFZiI8pLKeIsb3yhElI9YrZhyl0HZKhm9
 yeAY5O0Xc8GNEVmJDAOHJkMexqcOF/t899zQFM6oMZX41+jEmJSQ6BuBoh5jcu1qiV++
 zKRFTijFeRLUvEo91B3gOxMU4zChP6ZKHCBMrW8wrf/ILhNr6dFa83wQtkpMHdiFoGF1
 3kiw==
X-Gm-Message-State: AOJu0Yzu9nAmksTHw8FGUyscuBItwA05JQskdqfqTIkDfxGkZ+xVYNfs
 u+teNiNmHc+ne0mKkZlGVmehAWmWvSDH5iaOXDovu3FlnA+YjZiS1Lg=
X-Google-Smtp-Source: AGHT+IEDdwaj638PfVAz05YQKn1Vp3EMwiShWyWYY4SxSicLv/aFSW6F8L3NFzHTko5DM9EJd2hAUZ+pJkKvPRGoznc=
X-Received: by 2002:aa7:c1d5:0:b0:543:70c2:aa8d with SMTP id
 d21-20020aa7c1d5000000b0054370c2aa8dmr918699edp.15.1700630625998; Tue, 21 Nov
 2023 21:23:45 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
In-Reply-To: <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 22 Nov 2023 10:53:34 +0530
Message-ID: <CADg8p94EvJc6HNKvk2_XWaDb97u28vGfZasnv2je4yJw1k860Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

hi Simon,

On Wed, 22 Nov 2023 at 03:42, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add support for specifying the parameters needed for capsule
> > generation through a config file, instead of passing them through
> > command-line. Parameters for more than a single capsule file can be
> > specified, resulting in generation of multiple capsules through a
> > single invocation of the command.
> >
> > The config file can then be passed to the mkeficapsule tool in such
> > manner
> >
> >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  tools/Kconfig              |  15 ++
> >  tools/Makefile             |   1 +
> >  tools/eficapsule.h         | 114 ++++++++++++
> >  tools/mkeficapsule.c       |  87 +++++----
> >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 538 insertions(+), 31 deletions(-)
> >  create mode 100644 tools/mkeficapsule_parse.c
>
> This patch keeps coming back :-)
>
> Can we not add multiple capsules in the binman description? Why do we
> need a new file format? How can binman decode images produced in this
> way?

So as Tom mentions, this brings parity with respect to the other
capsule generation tool in EDKII that generates capsules. IIRC, this
is something which even Xilix was interested in, and Michal had kind
of gone through these patches earlier. Lastly, it would be good to
have support in U-Boot's mkeficapsule tool for generating a single
capsule file with multiple payloads, and having support for this
functionality helps in that goal.

Also, you might have noticed that, since your objection to the last
series, I have removed putting this in binman. So now, this aspect of
the capsule generation would only be supported through the
command-line invocation of the tool.

>
> Also, could we get sandbox to produce one EFI capsule as part of the
> normal build? I think that discussion trailed off.

Yes, apologies for missing out on this. Slipped my mind. Would you
want, say, all the non-signed capsules to be generated as part of the
sandbox build?

-sughosh
