Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E034C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 20:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0AA787A72;
	Thu, 28 Dec 2023 21:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QuAAYXoP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C651087A81; Thu, 28 Dec 2023 21:31:19 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D3487A08
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 21:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5e9520f7275so42118767b3.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 12:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703795475; x=1704400275; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w4AHsw5ZJjiDzSL2CXyoUpKrxNNWflPUVTs/1qBhqEw=;
 b=QuAAYXoPgJrk85F5xmZYbalXs7cThrif1prurxNwEFGLTSuz67x1WKOOUBrLDxb29s
 vef2y3+KS+6jC5QTFR7u2vf5b3cer9LlPmX8R5Vwz3UcLDaWe0V/g5ztbwQavOl4ivhO
 mVqGqO7sPt++heQ6njkhq6YYdZP5O917jEQ/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703795475; x=1704400275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w4AHsw5ZJjiDzSL2CXyoUpKrxNNWflPUVTs/1qBhqEw=;
 b=F3cxq/vNQyU4jm7KiR6qm9Y0U68q8C14kcE42WhONGTYptZcOOad9fMYgsdceRU3ee
 FosHATVL0AmYeFxe0MfIAd4jIqNnzI5r0DXflvY6NhnGdRkepcxwnQHvqru5xjga+bJm
 khBC6L3BmeR5OMatyK/r91HzOJJh13ZHbr1/7oFDxArqA8Q639G3MD+PU9HvwBpxiD4L
 GRSZKMgBmMF+aO72fEuW6mZOuHUuvKmeJG5q9pOg/Ov/vZPbMmu0xGtNrD3uUL/oQ2Wj
 RytNsPuVWSTWKcvQrGe/ddUBHc1I3UTqc1GgJPB+0SsB0qfIfy1IQmB4Mzg6gUAf9yvD
 vWBg==
X-Gm-Message-State: AOJu0YxZdpTdWR7W3+OwHOfy+hoq7UlvW8cfGj2MdpZI3N2oTbgYrhoi
 Hsu/hHiGm6uohXeV++0qt8uUt2BKCcRFdg==
X-Google-Smtp-Source: AGHT+IHK1jZ5f6c0oB3hgjjQYMP65ZrZMuOyqlgO91cLbHAUuz5h+Mmy8nHQ2fKHY+gO3itjLYZAog==
X-Received: by 2002:a05:690c:2a45:b0:5ef:d4e0:3a65 with SMTP id
 ej5-20020a05690c2a4500b005efd4e03a65mr348188ywb.19.1703795475540; 
 Thu, 28 Dec 2023 12:31:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 p127-20020a0dff85000000b005d39c874019sm7725614ywf.66.2023.12.28.12.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 12:31:14 -0800 (PST)
Date: Thu, 28 Dec 2023 15:31:11 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de, mibodhi@gmail.com
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB
 builds
Message-ID: <20231228203111.GO2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org>
 <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat>
 <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
 <20231228155428.GI2652760@bill-the-cat>
 <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uuxlB8sBxPQSBDTs"
Content-Disposition: inline
In-Reply-To: <CAFLszTjqcJouv7Dyasjfx4FiNy378fFA+A-DP292yvPk8xOzjw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--uuxlB8sBxPQSBDTs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 07:48:06PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, Dec 28, 2023 at 3:54=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Thu, Dec 28, 2023 at 03:09:12PM +0000, Simon Glass wrote:
> > > Hi Tom, Sumit,
> > >
> > > On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com>=
 wrote:
> > > >
> > > > On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wrote:
> > > > > Hi Sumit,
> > > > >
> > > > > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@l=
inaro.org> wrote:
> > > > > >
> > > > > > Allow platform owners to mirror devicetree files from devitree-=
rebasing
> > > > > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm6=
4). Then
> > > > > > build then along with any *-u-boot.dtsi file present in arch/$(=
ARCH)/dts
> > > > > > directory. Also add a new Makefile for arm64.
> > > > > >
> > > > > > This will help easy migration for platforms which currently are=
 compliant
> > > > > > with upstream Linux kernel devicetree files.
> > > > > >
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v3:
> > > > > > --------------
> > > > > > - Minor commit message update
> > > > > >
> > > > > > Changes in v2:
> > > > > > --------------
> > > > > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > > > > >
> > > > > >  dts/Kconfig             | 11 +++++++++++
> > > > > >  dts/Makefile            | 17 ++++++++++++++---
> > > > > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > > > > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > > > > >  create mode 100644 dts/arch/arm64/Makefile
> > > > > >
> > > > > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > > > > index 00c0aeff893..e58c1c6f2ab 100644
> > > > > > --- a/dts/Kconfig
> > > > > > +++ b/dts/Kconfig
> > > > > > @@ -85,6 +85,17 @@ config OF_LIVE
> > > > > >           enables a live tree which is available after relocati=
on,
> > > > > >           and can be adjusted as needed.
> > > > > >
> > > > > > +config OF_UPSTREAM
> > > > > > +       bool "Enable use of devicetree imported from Linux kern=
el release"
> > > > > > +       help
> > > > > > +         Traditionally, U-Boot platforms used to have their cu=
stom devicetree
> > > > > > +         files or copy devicetree files from Linux kernel whic=
h are hard to
> > > > > > +         maintain and can usually get out-of-sync from Linux k=
ernel. This
> > > > > > +         option enables platforms to migrate to devicetree-reb=
asing repo where
> > > > > > +         a regular sync will be maintained every major Linux k=
ernel release
> > > > > > +         cycle. However, platforms can still have some custom =
u-boot specific
> > > > > > +         bits maintained as part of *-u-boot.dtsi files.
> > > > >
> > > > > My only other suggestion here is to mention that this should be s=
et in
> > > > > Kconfig, for the SoC as a whole. So I believe that means that it
> > > > > should be hidden, with no string for the 'bool':
> > > > >
> > > > >       bool  # Enable use of devicetree imported from Linux kernel=
 release
> > > >
> > > > I think we can just keep prompting for it now, to make the transiti=
on
> > > > easier, before this option just goes away in time, hopefully.
> > > >
> > > > > Also, this doesn't seem to work for me. Before this series I get =
these
> > > > > files when building firefly-rk3399:
> > > > >
> > > > > rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
> > > > > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > > > > rk3399-evb.dtb                  rk3399-leez-p710.dtb
> > > > > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > > > > rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> > > > > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > > > > rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
> > > > > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > > > > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> > > > > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> > > > > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> > > > > rk3399-rock-4c-plus.dtb
> > > > > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk3399-=
rock-4se.dtb
> > > > > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk3399-=
rock960.dtb
> > > > >
> > > > > Afterwards I get this:
> > > > >
> > > > > make[3]: *** No rule to make target
> > > > > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> > > > >
> > > > > So I set this manually for that one board:
> > > > >
> > > > > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"
> > > > >
> > > > > and get:
> > > > >
> > > > > make[3]: *** No rule to make target
> > > > > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.  =
Stop.
> > > > >
> > > > > I am not sure how to fix this, nor how this can be made to build =
all
> > > > > the DTs for rk3399, as it does today.
> > > >
> > > > Looking at the patch for amlogic boards, you need to make the link =
to
> > > > devicetree-rebasing inside dts/...
> > >
> > > OK, let me give up on rk3399 for now...that doesn't seem to work even
> > > with the link.
> > >
> > > Using odroid-c2 with -next I see:
> > >
> > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > meson-a1-ad401.dtb                 meson-g12b-odroid-n2l.dtb
> > >     meson-gxl-s905x-libretech-cc.dtb
> > > meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-n2-plus.dtb
> > >     meson-gxl-s905x-libretech-cc-v2.dtb
> > > meson-axg-s400.dtb                 meson-g12b-radxa-zero2.dtb
> > >     meson-gxl-s905x-p212.dtb
> > > meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro.dtb
> > >     meson-gxm-gt1-ultimate.dtb
> > > meson-g12a-sei510.dtb              meson-gxbb-nanopi-k2.dtb
> > >     meson-gxm-khadas-vim2.dtb
> > > meson-g12a-u200.dtb                meson-gxbb-odroidc2.dtb
> > >     meson-gxm-s912-libretech-pc.dtb
> > > meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dtb
> > >     meson-gxm-wetek-core2.dtb
> > > meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dtb
> > >     meson-sm1-bananapi-m2-pro.dtb
> > > meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-hub.dtb
> > >     meson-sm1-bananapi-m5.dtb
> > > meson-g12b-gsking-x.dtb            meson-gxbb-wetek-play2.dtb
> > >     meson-sm1-khadas-vim3l.dtb
> > > meson-g12b-gtking.dtb              meson-gxl-s805x-libretech-ac.dtb
> > >     meson-sm1-odroid-c4.dtb
> > > meson-g12b-gtking-pro.dtb          meson-gxl-s905d-libretech-pc.dtb
> > >     meson-sm1-odroid-hc4.dtb
> > > meson-g12b-odroid-go-ultra.dtb
> > > meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei610.dtb
> > > meson-g12b-odroid-n2.dtb           meson-gxl-s905x-khadas-vim.dtb
> > > $
> > > With this series (sort of, since I am really not sure how to
> > > cherry-pick the commits from the PR) I see nothing:
> > >
> > > $ ls /tmp/b/odroid-c2/arch/arm/dts/
> > > $
> > >
> > > This shows some of the files:
> > >
> > > $ find /tmp/b/odroid-c2/ -name "*.dtb"
> > > /tmp/b/odroid-c2/dts/dt.dtb
> > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-odroidc2.dtb
> > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-nanopi-k2.dtb
> > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-play2.dtb
> > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-kii-pro.dtb
> > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p200.dtb
> > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p201.dtb
> > > /tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-hub.dtb
> > > /tmp/b/odroid-c2/u-boot.dtb
> > >
> > > but where are the rest? Also, is it possible to put the output .dtb
> > > files into the same directory? Otherwise we may have some pain with
> > > binman.
> >
> > What do you mean by same directory? But maybe also, what's an example of
> > a board you think might end up having problems? Converting that in a
> > follow-up series is likely a good idea, to highlight and address these
> > issues sooner rather than later.#
>=20
> Today the .dtb files go into arch/arm/dts - so it would be easier if
> this series could do the same.

But that's just an artifact of not having vendor directories. I don't
really think we can sanely put the new object files in there, that's not
what anyone is going to expect.

> The problem I have described above applied to meson, so I believe it
> is clear enough with that. I wasn't able to get rk3399 going, but I am
> sure it would have the same problem.

I don't think meson has the problem I was asking about, which is what
problem binman will have, because the series to make binman replace the
vendor tools didn't complete? That's what I'm getting at, for which
platform is binman going to have a problem today, so that we can look at
what to do about it and evaluate solutions with an example in hand.

> The fundamental question is (I believe) whether to:
>=20
> 1. Build only a single DT for a board
> 2. Build all DTs for the SoC the board uses
>=20
> This series seems to head towards (1), which worries me. We are
> currently mostly at (2).

It's explicitly at (1) with the notion we'll deal with (2) down the
road once there's a use case for it.  Possibly once someone updates
exynos platforms, based on what you had said previously?

--=20
Tom

--uuxlB8sBxPQSBDTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWN2wsACgkQFHw5/5Y0
tyxthgwAqepY8x5Pj2tdU3WB1Cd4GfhD7j7xBM89TJ69CqL/7XEgTx1d6vvoZbvk
Seq+xsJIwS6x7zB8/5WSs8HDVZfmB+pnCKxtUyMZHw7QJhquXgXnKqExpmoKCzb7
HUAo1wftOzdhLkCSCEC5Wd6GwStOMxd0fiGk51Hjn6Fu2KCutsSrZYGX7xZPyuGY
2P8Zbnap0a2fL+UNI5c/dml/0pjlBJYt53oaypcbqpIGMvlKQCWLjpu7mu3n+Xuu
tk9Eosu0jRyhaLJ0ISOI72wfz0A+gJWJe9tIPzyNI2J5ZUfQouO7BSjsJjbfWkFA
Pmmu9TvieJYBPbXPXQk5SsPFAyeBkUYSeDBGRqw4VcfjK3BErt6K/1PiFnRI2odF
LPv7uSnc7gOQLpi6puFX332N1waDz+EYylHESsiBFDcHmB2B/5oVkggWO+unWjku
/ZZQk70eOO5cJVAGup81OehuBLcxWtTHPD1GHk68fjBWvj58+gZVfDvcCuy/FAw5
mRZecgwx
=1DUA
-----END PGP SIGNATURE-----

--uuxlB8sBxPQSBDTs--
