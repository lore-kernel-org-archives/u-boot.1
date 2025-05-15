Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF485C2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 19:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F9BE8129F;
	Thu, 15 May 2025 21:39:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bctqJF0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB4DE82A9E; Thu, 15 May 2025 21:39:43 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D24D880050
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 21:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad1f6aa2f84so277751566b.0
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747337981; x=1747942781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fqvmaZQFhlGQzJiBB3QfnUVpn+pEzCIAmb94uN6qLrU=;
 b=bctqJF0m2OyIOyYzCxtN+WGmqkq3wzpXf7lvu6K2yArSkwALDto2fHXDNYUvhSVXht
 W5uKMKKilZf7wD8WXzBj4MqhVez+33h7fu14ivpSwQHYB4pNF3y7pRCV9mNTUhwqcQCr
 lLwJMKLbjTU8RMWvnJocDgTD/vO7ooVMySizA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747337981; x=1747942781;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fqvmaZQFhlGQzJiBB3QfnUVpn+pEzCIAmb94uN6qLrU=;
 b=BuaGc4hUHfvoecDPbhWjPSkNNL+wFubS9hZUz1YpPmwSo3H6fH3sYzRxAEQGmHjZMB
 02HeSAUZApuRkFeKyO3gDxNI33BJaHn0jU255ZGRDaLLLhhgxW9MkLqrLj3UjGTpaNbo
 CSoVOxZPi5usUTb2+PzhyStrJ94H73Hz+uFBwyPtfG4QGbV3LnhkpkY60JmrlWz2T29u
 a3RSJs00dCQKxmasqI8Fj5a4GQK/47R9Kq14bO8mxZd8+5j/wA/nEtSbFsFvEGTrQ95q
 +e3Zs536R+tRD3To0YBTLF8KKCfGa8r+P2Sh8LgJXWzpucxlQ4zUl3lAo00UcLGt9FE/
 5wFg==
X-Gm-Message-State: AOJu0YxBvEFYojZYz48aGHNZFfp3RS+kjQPOA+Zwe+yhKHXOhCjEhCyp
 fO/Q3Mp4wgprdiDHmI0Eus1j6nNwhj19bWDoU++dDtzx9k2ud7/vsXyV+nuHLFh5GMmOIEzwsrw
 xdZeC4Qoi++5unWkVr32M+fFS9BuF+q5T8Y/W6bpt
X-Gm-Gg: ASbGnctCp36DwduACpwQyWDkxaWhjl3vH4+sgBxmK/bQYrvgq6NYsxjVW7Dy8wFBSJy
 tTaVeK86QMIGvd8Ca4ttSMWWNezrUJXZ3ZlynN10zr9jLYDRV8zgpl46Cp8BVSl2Lw34SjI8bjj
 KIJcs4+oj4t6JT1wXOfqx5hAJaPsbAJevrOMjatgRGzMI=
X-Google-Smtp-Source: AGHT+IE30AMNQQKybzCRuTQXGLkgqD5xWrcMDs+SaNBLf/UjyQ0XUAliJqMbXTEQZox+4g+5vCjkFrxapEYIHhTH9Ic=
X-Received: by 2002:a17:907:1b10:b0:ad2:242e:fe9d with SMTP id
 a640c23a62f3a-ad50f64a197mr470142166b.10.1747337981212; Thu, 15 May 2025
 12:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510134253.1581164-5-sjg@chromium.org>
 <3ae0c43b-8b6f-43c3-89d3-5773bef5ed23@kwiboo.se>
In-Reply-To: <3ae0c43b-8b6f-43c3-89d3-5773bef5ed23@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 May 2025 21:39:29 +0200
X-Gm-Features: AX0GCFuGvcTck4JlnBE2z1JYsJ0j5vQSvLUw-CVR07QbQ0iOm7_4EfGAGm6CbV8
Message-ID: <CAFLszThmi3Fqgp7u79fhToY_Jc4gXgd0y-sq1m+mefihEQotQw@mail.gmail.com>
Subject: Re: [PATCH v4 06/22] fdt: Redo devicetree setup
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, 
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>
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

Hi Jonas,

On Sat, 10 May 2025 at 17:31, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2025-05-10 15:42, Simon Glass wrote:
> > The existing logic for handling receiving a devicetree from a previous
> > phase is quite complicated. Simplify it in preparation for introducing
> > standard passage.
> >
> > Add a Kconfig called OF_PASSAGE which indicates that the devicetree
> > must come from standard passage.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Drop now-unused label
> >
> > Changes in v3:
> > - Add new patch to redo how a devicetree is set up
> >
> >  dts/Kconfig  |  8 ++++++++
> >  lib/fdtdec.c | 35 ++++++-----------------------------
> >  2 files changed, 14 insertions(+), 29 deletions(-)
> >
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index c544f948a15..57101bddabb 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -159,6 +159,14 @@ config OF_EMBED
> >         and development only and is not recommended for production devices.
> >         Boards in the mainline U-Boot tree should not use it.
> >
> > +config OF_PASSAGE
> > +     bool "DTB is provided by a standard passage, in a bloblist"
> > +     help
> > +       Select this to read the devicetree using the standard passage
> > +       mechanism, i.e. from a previous phase in bloblist using arch-specific
> > +       register conventions. If enabled, the previous phase must provide
> > +       the devicetree, or U-Boot will not function correctly.
> > +
> >  endchoice
> >
> >  config OF_INITIAL_DTB_READONLY
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index c38738b48c7..8559616873b 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1689,35 +1689,13 @@ void fdtdec_setup_embed(void)
> >
> >  int fdtdec_setup(void)
> >  {
> > -     int ret = -ENOENT;
> > -
> > -     /*
> > -      * If allowing a bloblist, check that first. There was discussion about
> > -      * adding an OF_BLOBLIST Kconfig, but this was rejected.
> > -      *
> > -      * The necessary test is whether the previous phase passed a bloblist,
> > -      * not whether this phase creates one.
> > -      */
> > -     if (CONFIG_IS_ENABLED(BLOBLIST) &&
> > -         (xpl_prev_phase() != PHASE_TPL ||
> > -          IS_ENABLED(CONFIG_TPL_BLOBLIST))) {
> > -             ret = bloblist_maybe_init();
> > -             if (!ret) {
> > -                     gd->fdt_blob = bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > -                     if (gd->fdt_blob) {
> > -                             gd->fdt_src = FDTSRC_BLOBLIST;
> > -                             log_debug("Devicetree is in bloblist at %p\n",
> > -                                       gd->fdt_blob);
> > -                             goto setup_fdt;
> > -                     } else {
> > -                             log_debug("No FDT found in bloblist\n");
> > -                             ret = -ENOENT;
> > -                     }
> > -             }
> > -     }
> > +     int ret;
> >
> > -     /* Otherwise, the devicetree is typically appended to U-Boot */
> > -     if (ret) {
> > +     if (CONFIG_IS_ENABLED(OF_BLOBLIST)) {
>
> This looks wrong, should possible be OF_PASSAGE ?
>
> Also looks like there is more patches in need of a correction to use
> OF_PASSAGE instead of OF_BLOBLIST in commit message and/or patch content
> in this series.

Thanks, yes this is not quite right as the rename happens in this
patch but the other changes are not until later. I'll send a new
version when the week is up.

Regards,
Simon

>
> Regards,
> Jonas
>
> > +             printf("Previous phase failed to provide standard passage\n");
> > +             return -ENOENT;
> > +     } else {
> > +             /* The devicetree is typically appended to U-Boot */
> >               if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> >                       gd->fdt_blob = fdt_find_separate();
> >                       gd->fdt_src = FDTSRC_SEPARATE;
> > @@ -1752,7 +1730,6 @@ int fdtdec_setup(void)
> >               }
> >       }
> >
> > -setup_fdt:
> >       if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
> >               setup_multi_dtb_fit();
> >
>
