Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C2CC3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 17:58:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3AD82385;
	Thu,  3 Apr 2025 19:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EF/9EIAg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B498215D; Thu,  3 Apr 2025 19:57:56 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74738212F
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 19:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac73723b2d5so231263766b.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743703073; x=1744307873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lmnj+rf0SewLknOTDjtSHhY67gbmThmG2w7dumwfepE=;
 b=EF/9EIAgm8YIWm9FAB1YBw9C8+hUBGzpeX95Oy2kosNVer8eCqPKKmDaq9NDDwjzhm
 XZK3T8Lygj0b0MjL7GgUSTmSv+WFDY3tR8imL/lT9s0BQURoGh/5Xgl1mhIcUNwHtCCU
 pRe5FsEPlEv+JetvzX58Qw8R+gKdE03zh0HSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703073; x=1744307873;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lmnj+rf0SewLknOTDjtSHhY67gbmThmG2w7dumwfepE=;
 b=aDRzkiSNIBVfnffTGd60xfNO4FeOK+5l62txCJsEZl8N+fbP+mc4h0v4rlnD3lfnii
 QFY+GAHsYhxeJmSl2kntE2Y7NTAoU8OOHvY/ISm5Vn8ZFWvFYUgf5yvo+cP45/6t173B
 M+LIbTTIVQc+Ji3Ddd74+Cg2J48tWjyeMHj7AvUDD1n6vOBrnTYgAUghsNh3Gu4918VA
 uWuwUIw3KPyzTB/dlbyCzsfyVzRIbRPLrO/zR1N5jYcvZybr84zJzJNJrSv6Q86JhFGO
 MjDENk92q24a5Kr63jComVo9Kgae34L3lhhrPPE7fayF8seFrHsh7HQhRc2gFcW93odP
 67zQ==
X-Gm-Message-State: AOJu0Yx2QqdpdRKLj6eWm+M7Lxpi2KU7vU/UHVhWop/i/Y55w3CeoYtG
 6ZFePWiR2AFFe7c4b49EWP7es3JZBgoHUs3KKvMno/kc/SAbsHril1QU8A5IIKNaQ1XzNjmMDds
 y3ZjBPlSgWn0eh46/Ijfb2g/Mlesg+n+TaPhl
X-Gm-Gg: ASbGncsvamTLtyNkHwsTsqZgfMmHF6rZEOqyDJZT513lYiBGlsiHghDa+9vL04/hJPA
 GIqbBKqdJpjGgC0Om0ClOQs5u3te4b+LolGXuISN43j8LfweAXIY5dcquJEdAJVrLu5e4mPKJEv
 GGWsaMwYBwcWUvMO9vYWKHMYjJhf09l2aD5D4NBHY=
X-Google-Smtp-Source: AGHT+IGj0CzpZje4DZYny/1h0o82V0ZjEtQEftXgoE3U1t/snYFwJvfdb3QBShlKV6mzdR+EF6eFcmykVXwim80huu8=
X-Received: by 2002:a17:907:c0f:b0:ac3:991:a631 with SMTP id
 a640c23a62f3a-ac7d19a1618mr46703466b.34.1743703073036; Thu, 03 Apr 2025
 10:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328154401.3563921-3-sjg@chromium.org>
 <CAEfUkU+zzsxR7xwY2E4APG9LWK5XJXToLhG1SyC6LQBL3wvo7w@mail.gmail.com>
In-Reply-To: <CAEfUkU+zzsxR7xwY2E4APG9LWK5XJXToLhG1SyC6LQBL3wvo7w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 06:57:38 +1300
X-Gm-Features: AQ5f1JrTULX1FndZMKivXRINJKsL9z9tVEQ9l7z3tVUt2ZY7Mc-lYjCU-fodxUg
Message-ID: <CAFLszThCJN0geUyeUSkO8QEQbqRJcTUrHnNDMUJRQQ2WYsTo-Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] fdt: Introduce OF_BLOBLIST
To: Raymond Mao <raymond.mao@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marex@denx.de>, Matthias Brugger <mbrugger@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, mason1920 <mason1920@use.startmail.com>
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

Hi Raymond,

On Fri, 4 Apr 2025 at 04:34, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 28 Mar 2025 at 11:44, Simon Glass <sjg@chromium.org> wrote:
> >
> > Add an option which indicates that the devicetree comes from the
> > bloblist.
> >
> > After discussions with Tom, it seems we are comfortable with introducing
> > this option, ensuring of course that the transfer list is properly
> > supported.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  doc/develop/devicetree/control.rst |  3 ++
> >  dts/Kconfig                        |  8 ++++
> >  lib/fdtdec.c                       | 66 ++++++++++++------------------
> >  3 files changed, 38 insertions(+), 39 deletions(-)
> >
> > diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetree/control.rst
> > index 0233945f8b6..d80f4d420a9 100644
> > --- a/doc/develop/devicetree/control.rst
> > +++ b/doc/develop/devicetree/control.rst
> > @@ -137,6 +137,9 @@ If `OF_BOARD` is selected by Kconfig, a board-specific routine will provide the
> >  devicetree at runtime, for example if an earlier bootloader stage creates
> >  it and passes it to U-Boot.
> >
> > +If `OF_BLOBLIST` is defined, the devicetree comes from a bloblist passed
> > +from a previous stage.
> > +
> >  If `BLOBLIST` is selected by Kconfig, the devicetree may come from a bloblist
> >  passed from a previous stage, if present.
> >
> > diff --git a/dts/Kconfig b/dts/Kconfig
> > index 6a5141b56e9..04359a4d7b2 100644
> > --- a/dts/Kconfig
> > +++ b/dts/Kconfig
> > @@ -167,6 +167,14 @@ config OF_INITIAL_DTB_READONLY
> >           If initial DTB for DT control is read-only (e.g. points to
> >           memory-mapped flash memory), then set this option.
> >
> > +config OF_BLOBLIST
> > +       bool "DTB is provided by a bloblist"
> > +       help
> > +         Select this to read the devicetree from the bloblist. This allows
> > +         using a bloblist to transfer the devicetree between U-Boot phases.
> > +         The devicetree is stored in the bloblist by an earlier phase so that
> > +         U-Boot can read it.
> > +
> >  config OF_BOARD
> >         bool "Provided by the board (e.g a previous loader) at runtime"
> >         default y if SANDBOX || OF_HAS_PRIOR_STAGE
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index f09c9926a7a..833f8aca3ce 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -1689,55 +1689,43 @@ void fdtdec_setup_embed(void)
> >
> >  int fdtdec_setup(void)
>
> I think a better idea is to use BLOBLIST_PASSAGE_MANDATORY, see below
> pseudo code:
>
> ```
> if (IS_ENABLED(CONFIG_OF_BOARD)) {
>     /* get fdt from board */
> }
>
> /* allow fdtcontroladdr to override it */
>
> if (CONFIG_IS_ENABLED(BLOBLIST) && ... ) {
>     /* try to find fdt from bloblist */
>
>     if (CONFIG_IS_ENABLED(BLOBLIST_PASSAGE_MANDATORY) {
>         if (no_fdt_in_bloblist)
>             return ERROR;
>
>         /* override fdt with the one from bloblist */
>     }
> }
> ```

See my other email on this. With OF_BLOBLIST we actually don't need
BLOBLIST_PASSAGE_MANDATORY so we can drop it.

Regards,
Simon
