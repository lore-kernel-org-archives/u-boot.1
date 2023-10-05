Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A79E92705
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 14:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE4E386ED4;
	Thu,  5 Oct 2023 16:54:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h3gMIZM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A17686EDF; Thu,  5 Oct 2023 16:54:04 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5982C86EDE
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 16:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a2379a8b69so12043497b3.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696517633; x=1697122433; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VjbYhOAt/YNDDaDTXsrimMZRlXkFQEwpct9VUjGHujg=;
 b=h3gMIZM99f7p0nkzAgJrBFRDRaJNXLDBLb+4gxx+npKpUZPuO1HeNdR/97KQrN49dh
 I6f4uK4SdMLKXqnju1nrRsTY4idE2M93S9IV5ayAELS4gq4CUAImhJC363y378YHVsNd
 KS3O1sNf/x5rfJGwQifSR4zVCM4dXeItjgHhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696517633; x=1697122433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VjbYhOAt/YNDDaDTXsrimMZRlXkFQEwpct9VUjGHujg=;
 b=T71cJdlqilsXDm5cMi23/4f8ZzRtsvO+Xx9vDPNptcSWC4wTf8WZztDLR7whW8kR+m
 dwFNzkv85+qTh+07yQjtbnzGPlb1Q6hnjk4hohDKD6VWDzwRDmI9VK8kgxmMEjXLpnOn
 n4Nve5vlOPXs/94EU1slBzbkkmmsQtvaWNCmgaJSxJbfngoaAFpdV0/RxocbZLUk5eTw
 oos9VMqBbqt02Y4iFrk6On7HeS4oRw7SJLK7xxxzK7KNy4YInSP8f2CpP3pnYJ7xmUUz
 gfWlDXWLKh2/ORT6tr5QKBSp7C7zgcz2NH66YytvQKpmMkbz/ylCOXDOo9Xr9SiqfNy6
 sxzA==
X-Gm-Message-State: AOJu0Yw/WS9KTmUsa6jTHyxlJdLysAQOHHLvzCPkjQ2Pl8aYMfmHII+A
 pAfsz1nQ0OHLQr21fC4I9hZiCHwujeP6sv2mT2wpug==
X-Google-Smtp-Source: AGHT+IFBNTskLVxrGPXwJ1A2gj9IqTb9yti0SIHa8xNrGTq9gDNpAUVO+0Wxp2vyipdEqldxD/pYMA==
X-Received: by 2002:a81:6d48:0:b0:59f:4e6d:b56c with SMTP id
 i69-20020a816d48000000b0059f4e6db56cmr5652552ywc.22.1696517633135; 
 Thu, 05 Oct 2023 07:53:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 r126-20020a0de884000000b005869f734036sm560996ywe.19.2023.10.05.07.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 07:53:52 -0700 (PDT)
Date: Thu, 5 Oct 2023 10:53:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Fabio Estevam <festevam@gmail.com>, Leo <ycliang@andestech.com>,
 Michael Walle <michael@walle.cc>, Michal Suchanek <msuchanek@suse.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Rick Chen <rick@andestech.com>,
 Stefan Roese <sr@denx.de>, Stefano Babic <sbabic@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 05/25] treewide: Correct use of long help
Message-ID: <20231005145350.GQ8465@bill-the-cat>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-6-sjg@chromium.org>
 <20230924232658.GM305624@bill-the-cat>
 <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3WAuJ+cuHDAcGqDL"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
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


--3WAuJ+cuHDAcGqDL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 07:23:47PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 24 Sept 2023 at 17:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass wrote:
> > > Some commands assume that CONFIG_SYS_LONGHELP is always defined.
> > > Declaration of long help should be bracketed by an #ifdef to avoid an
> > > 'unused variable' warning.
> > >
> > > Fix this treewide.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > [snip]
> > > diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/cmd_dek.c
> > > index 6fa5b41fcd38..25ea7d3b37da 100644
> > > --- a/arch/arm/mach-imx/cmd_dek.c
> > > +++ b/arch/arm/mach-imx/cmd_dek.c
> > > @@ -393,11 +393,12 @@ static int do_dek_blob(struct cmd_tbl *cmdtp, i=
nt flag, int argc,
> > >       return blob_encap_dek(src_addr, dst_addr, len);
> > >  }
> > >
> > > -/***************************************************/
> > > +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
> > >  static char dek_blob_help_text[] =3D
> > >       "src dst len            - Encapsulate and create blob of data\n"
> > >       "                         $len bits long at address $src and\n"
> > >       "                         store the result at address $dst.\n";
> > > +#endif
> > >
> > >  U_BOOT_CMD(
> > >       dek_blob, 4, 1, do_dek_blob,
> >
> > This really doesn't read nicely.  I would rather (globally and fix
> > existing users) __maybe_unused this instead.  I think there's just one
> > example today that isn't "foo_help_text".
>=20
> Hmm, what do you think about adding a __longhelp symbol to cause the
> linker to discard it when not needed?

Well, I don't think we need linker list magic when __maybe_unused will
just have them be discarded normally.

--=20
Tom

--3WAuJ+cuHDAcGqDL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUezf4ACgkQFHw5/5Y0
tyyfxAv/Rzerxchv9zt5z6QoVeWO1UcGiai3TTMp0/WCwHa9LiPp4ltbRbWggVdw
Lx4t1JvUeClt0yk+5GRofoaxAvQm5Rah6NvA7Ima3b7wfvHDsSq/ir3G4Yb6EGmN
uwMLeF5/POkaXyHssQK5dZtIEvKmOE+fPEstDQ3egLkEHfL+hswmrv+HmJKVVt3Q
PzwgCCkEy06Gl58zGkSzXsibWLWYmAwQR8DgFqvidfs4fhoSvkYXiZKddZybI0Bd
qsp+FbhOuyYyqMQzVqsgZxKygZoI2GBAryYhEhZPlNQAfnjwtsjkzzlWJJzQivmx
OIQ/VKi3KI9dV2WYo/hgOZnbih27LtGwCcSpUTEtAp++G1LIPkiVaPwtgm40gWzq
xNx7mx+DILiBhAyu73hrjOPKhH141pINTif2eldZOfIkHbzZTI6V28fgL/ZhRRyq
lxSJOEespA3KH2C0RCW5L22v94QDORqg12VDjn+E7a/13QgKzy+x7zQ4LNg826O0
XH58CCsm
=gGR9
-----END PGP SIGNATURE-----

--3WAuJ+cuHDAcGqDL--
