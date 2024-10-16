Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC0ED1AD3B
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E25C89003;
	Wed, 16 Oct 2024 12:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RLxMwvo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2849D88FD2; Wed, 16 Oct 2024 12:05:39 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF4D889041
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:05:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexthreed@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5d5eec95a74so2950028eaf.1
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729073133; x=1729677933; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnMYDobq7YEUR1xp4OdqKNcT2lCZdoC1tmxHPceWQTA=;
 b=RLxMwvo8jbSu5rbT1xcE03RjaQpJ8WS7BBoWLzy4zPSADmhSGOasTbpFWzINaChq/t
 VtdORs8Fu3cey/cqBwBZtjy/qppci/u2vrGSCO2UvhFh0hR9wM0UM6LAT9YAx15WL0Ue
 QirhAJaua59/O0CGeyVA0QuacQB1Vn8k5vPycNm5F0tOeOXjNdl11bMpa+UiBF+P43bS
 Sz0BeqbH04eBmoeQdf7czopXY35cBlh7A4hOQ+bbyPBu6hM+pxMzxvHWkpVc8/nTBhGh
 JzlZ6a/7ZomEnQ1rXy/ntY/zQl8C54DKxBYZSocQFrlvYRYeYjIsXh1IPJJm2FuA/f1E
 hlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073133; x=1729677933;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VnMYDobq7YEUR1xp4OdqKNcT2lCZdoC1tmxHPceWQTA=;
 b=ReVPz4hJhWEbJSMuhiQClNrf9zJ07QNlUEsSqsSbXJQ8Xz0VGeRzjXc2N/u6VF1/iu
 iSdRLgciESq49NxTYoAGH3Pc56ocqKpfTgJQ16Dgx4qqKmfW1JalNNk6y9v+UyMSZeKq
 7dywxjV60EcWi2+nWl9Or5z+ipTj1DQKNrvxhkVNEnh7Fvl4TGxTKhxkXE5kU1Z2djwn
 idNZDXKSCWx6wYFSDJrEBBlSaeSh5CHlVGVUdvD6gLc3sTL4RaNyXuGxI8mrAEareTMi
 NddnKOdVvaW2APRs+skKqivvnye12+tCTTi0QLjchphIMK08q+m51HSBPyGbU0VzS0m4
 2WhQ==
X-Gm-Message-State: AOJu0YxbOR9oi2HQ8vaiXFFsk8lxi2HhHpVBcQeJAsICCuk+oYJ8cRhe
 vAAzIJo4x5/t+RdoVdJJF4MMzRYwApRiq3K2TI/ULGjDnIjvY7N0rJi0EjrApscJThQVW9UEhl2
 dbW50mjddsqFC9zx0dFz36vX0qy4=
X-Google-Smtp-Source: AGHT+IEsnEkHhY/Eaf2r/KPZKKrqY2IonpFd4dBtJRH21QZbBWJKMdRfvPy+x5kW/PP2l2G1xOBsul2fvoZXBJBSVpo=
X-Received: by 2002:a05:6820:22a4:b0:5e5:c49a:b53 with SMTP id
 006d021491bc7-5eb1a1d42c5mr9908700eaf.7.1729073133330; Wed, 16 Oct 2024
 03:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20241015212831.61229-1-alexthreed@gmail.com>
 <2aaf029095b1ee30d0b40f60787e1a8c@manjaro.org>
In-Reply-To: <2aaf029095b1ee30d0b40f60787e1a8c@manjaro.org>
From: Alex Shumsky <alexthreed@gmail.com>
Date: Wed, 16 Oct 2024 13:05:22 +0300
Message-ID: <CAF4oh-NLijKrWWLT1s_KjE4L2t2KOn3Mt25=KJnAO6m=3WgZ8Q@mail.gmail.com>
Subject: Re: [PATCH v5] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Janne Grunau <j@jannau.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nikhil M Jain <n-jain1@ti.com>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
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

On Wed, Oct 16, 2024 at 4:22=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Alex,
>
> Thanks for the v5.  Please see a few comments below.
>
> On 2024-10-15 23:28, Alex Shumsky wrote:
> > Increase rng-seed size to make Linux happy and initialize rng pool
> > instantly.
> > Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but
> > u-boot
> > currently provides only 8 bytes.
> > Linux 5.18 and probably some versions before it used to require 64
> > bytes.
> > Bump min value to 64 bytes to be on a safe side.
> >
> > Boot with 8 byte rng-seed (Linux 6.11):
> >     # dmesg | grep crng
> >     [   12.089286] random: crng init done
> > Boot with 32 byte rng-seed (Linux 6.11):
> >     # dmesg | grep crng
> >     [    0.000000] random: crng init done
> >
> > Linux source references:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/char/random.c?h=3Dv5.19#n551
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/char/random.c?h=3Dv5.18#n236
> >
> > Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> > Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all
> > Rockchip devices")
> > Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> > Reviewed-by: Marek Vasut <marex@denx.de>
> > ---
> >
> > Changes in v5:
> > - add docs
> >
> > Changes in v4:
> > - fix typos and code style
> >
> > Changes in v3:
> > - reword warning
> > - increase default rng_seed_size to support older linux as well
> > - reword commit message
> >
> > Changes in v2:
> > - add env config knob rng_seed_size
> > - add warning for small rng_seed_size
> > - 12-character commit SHA in Fixes
> >
> >  arch/arm/mach-rockchip/board.c | 11 ++++++++++-
> >  common/Kconfig                 |  3 +++
> >  doc/usage/environment.rst      |  5 +++++
> >  include/fdt_support.h          |  3 ++-
> >  4 files changed, 20 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-rockchip/board.c
> > b/arch/arm/mach-rockchip/board.c
> > index 3fadf7e412..ca6404776f 100644
> > --- a/arch/arm/mach-rockchip/board.c
> > +++ b/arch/arm/mach-rockchip/board.c
> > @@ -472,9 +472,18 @@ __weak int misc_init_r(void)
> >  __weak int board_rng_seed(struct abuf *buf)
> >  {
> >       struct udevice *dev;
> > -     size_t len =3D 0x8;
> > +     ulong len =3D env_get_ulong("rng_seed_size", 10, 64);
> >       u64 *data;
> >
> > +     if (len < 64) {
> > +             /*
> > +              * rng_seed_size should be at least 32 bytes for Linux 5.=
19+,
> > +              * or 64 for older Linux kernel versions
> > +              */
> > +             log_warning("Value for rng_seed_size too low (%lu) and li=
kely
> > insufficient for the Linux RNG initialization\n",
>
> Please consider changing the message to:
>
>    "Value for rng_seed_size (%lu) too low, Linux kernel RNG
>    may fail to initialize early\n"
>
> It's more compact, which is always good, and should be a bit
> more precise that way.
>
> > +                         len);
> > +     }
> > +
> >       data =3D malloc(len);
> >       if (!data) {
> >               printf("Out of memory\n");
> > diff --git a/common/Kconfig b/common/Kconfig
> > index 957de0c5c0..c1d06f5045 100644
> > --- a/common/Kconfig
> > +++ b/common/Kconfig
> > @@ -927,6 +927,9 @@ config BOARD_RNG_SEED
> >         new seed for use on subsequent boots, and whether or not the
> >         kernel should account any entropy from the given seed.
> >
> > +       Default seed size (64 bytes) can be overridden by a decimal
> > environment
> > +       variable rng_seed_size.
>
> Maybe reflow a bit to follow the column width above.
>
> > +
> >  endmenu
> >
> >  menu "Update support"
> > diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> > index cc33d3ec0f..253b25a002 100644
> > --- a/doc/usage/environment.rst
> > +++ b/doc/usage/environment.rst
> > @@ -323,6 +323,11 @@ netretry
> >      Useful on scripts which control the retry operation
> >      themselves.
> >
> > +rng_seed_size
> > +    Size of random value added to device tree-node /chosen/rng-seed.
> > +    This variable is given as a hexadecimal number.
>
> We've come to a conclusion it's a decimal number, right? :)
> So, please s/hexadecimal/decimal/
>
> > +    If unset, 64 bytes is used as the default.
> > +
> >  silent_linux
> >      If set then Linux will be told to boot silently, by
> >      adding 'console=3D' to its command line. If "yes" it will be
> > diff --git a/include/fdt_support.h b/include/fdt_support.h
> > index 741e2360c2..02561eab15 100644
> > --- a/include/fdt_support.h
> > +++ b/include/fdt_support.h
> > @@ -202,7 +202,8 @@ int ft_board_setup(void *blob, struct bd_info *bd);
> >   *
> >   * This function is called if CONFIG_BOARD_RNG_SEED is set, and must
> >   * be provided by the board. It should return, via @buf, some suitable
> > - * seed value to pass to the kernel.
> > + * seed value to pass to the kernel. Seed size could be set in a
> > decimal
> > + * environment variable rng_seed_size and defaulted to 64 bytes.
>
> s/defaulted/it defaults/
>

Thanks, fixed. I'm not good at wording.
