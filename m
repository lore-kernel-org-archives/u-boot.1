Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1098BE81E1C
	for <u-boot@archiver.kernel.org>; Fri,  6 Oct 2023 16:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B46C86EB7;
	Fri,  6 Oct 2023 18:55:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lbHBFUMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A17B86EB7; Fri,  6 Oct 2023 18:55:20 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F10285095
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 18:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d8164e661abso2527616276.1
 for <u-boot@lists.denx.de>; Fri, 06 Oct 2023 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696611315; x=1697216115; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=axW6QS1zFdBZ0l8DKbKBDKAugBKnzmMhYTB45lAINUE=;
 b=lbHBFUMxyq3bCOkFOrJd6lMDQAmCRj6igFLYyiqZfuyF97oSz4QVXgV+TlvSXl7dY5
 Y7YFA567TOmKm1mN5dUUigCbMOhlCvGJTzgx3c5TO4vT/gwXzU0oSlk2H1sBXwnHRsoD
 EriNhtxbMU5JLNBTt07bVeSHciLTjpY9tMp14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696611315; x=1697216115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axW6QS1zFdBZ0l8DKbKBDKAugBKnzmMhYTB45lAINUE=;
 b=sLPgvnmanjVq+b151g75sWn/MdUBSx0A7tG1+G9LDSZA6efQ4gv8No0vNqiueuunks
 AxieLlAQjdJ/pPd0QLOjnWJRE8nx5d8Lw5jGQQig7RyMWEPnlCjk5zLEwDP7iEDv7iyO
 uy/eudtz7/FMa0RMVrrHEvjm1PUWy80nTvLkX8ExBUVOQSckbxsAtvuzpuAAx5tD9hyg
 tRA1FrJw9J0g16Yj+QJqC1j6YYbNQXZvmnGkpxY3vLdsGHyN06wDwpjWtjNfQHyEkVev
 sIWXXgNIHoLonYhuLPzWimKcbeHr1wjnQ6rcBXK6lMqqp/CEG9Y02REZQiPcDHz7FMoW
 JYDg==
X-Gm-Message-State: AOJu0YxXYHuL7oOuFThe8hSC4xWXdrdUhUOcFSd6GruvfUS6moAY/J/Z
 4Y9WFQqRlvD18wviw8fmYpzhIw==
X-Google-Smtp-Source: AGHT+IEaTYvFVwugTUiKUf3NYNHSGNoE1fj+BQevXAW9BkSZLi/OIuXdcVP8YH91p6ep5k8ulElqng==
X-Received: by 2002:a25:2d20:0:b0:d91:1412:b696 with SMTP id
 t32-20020a252d20000000b00d911412b696mr8029322ybt.3.1696611314589; 
 Fri, 06 Oct 2023 09:55:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-385b-0a87-6b23-cb7e.res6.spectrum.com.
 [2603:6081:7b00:6400:385b:a87:6b23:cb7e])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a259f07000000b00d3596aca5bcsm1151201ybq.34.2023.10.06.09.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 09:55:13 -0700 (PDT)
Date: Fri, 6 Oct 2023 12:55:04 -0400
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
Message-ID: <20231006165504.GC2227687@bill-the-cat>
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-6-sjg@chromium.org>
 <20230924232658.GM305624@bill-the-cat>
 <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
 <20231005145350.GQ8465@bill-the-cat>
 <CAPnjgZ2Mbx9H_ve_F_gq_eqt2hvwmYF455-0PHB31fV5m9HN2A@mail.gmail.com>
 <20231006021616.GB2227687@bill-the-cat>
 <CAPnjgZ3sTQNQJCpuZ4doJJH=t=mLxXaAYQR8kVXorOfqn2t5CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NPK+pq+qYwZqxflM"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3sTQNQJCpuZ4doJJH=t=mLxXaAYQR8kVXorOfqn2t5CA@mail.gmail.com>
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


--NPK+pq+qYwZqxflM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 07:03:17AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 5 Oct 2023 at 20:16, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 05, 2023 at 07:41:49PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 5 Oct 2023 at 08:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Oct 04, 2023 at 07:23:47PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Sun, 24 Sept 2023 at 17:27, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > >
> > > > > > On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass wrote:
> > > > > > > Some commands assume that CONFIG_SYS_LONGHELP is always defin=
ed.
> > > > > > > Declaration of long help should be bracketed by an #ifdef to =
avoid an
> > > > > > > 'unused variable' warning.
> > > > > > >
> > > > > > > Fix this treewide.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > [snip]
> > > > > > > diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/mach-imx/=
cmd_dek.c
> > > > > > > index 6fa5b41fcd38..25ea7d3b37da 100644
> > > > > > > --- a/arch/arm/mach-imx/cmd_dek.c
> > > > > > > +++ b/arch/arm/mach-imx/cmd_dek.c
> > > > > > > @@ -393,11 +393,12 @@ static int do_dek_blob(struct cmd_tbl *=
cmdtp, int flag, int argc,
> > > > > > >       return blob_encap_dek(src_addr, dst_addr, len);
> > > > > > >  }
> > > > > > >
> > > > > > > -/***************************************************/
> > > > > > > +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
> > > > > > >  static char dek_blob_help_text[] =3D
> > > > > > >       "src dst len            - Encapsulate and create blob o=
f data\n"
> > > > > > >       "                         $len bits long at address $sr=
c and\n"
> > > > > > >       "                         store the result at address $=
dst.\n";
> > > > > > > +#endif
> > > > > > >
> > > > > > >  U_BOOT_CMD(
> > > > > > >       dek_blob, 4, 1, do_dek_blob,
> > > > > >
> > > > > > This really doesn't read nicely.  I would rather (globally and =
fix
> > > > > > existing users) __maybe_unused this instead.  I think there's j=
ust one
> > > > > > example today that isn't "foo_help_text".
> > > > >
> > > > > Hmm, what do you think about adding a __longhelp symbol to cause =
the
> > > > > linker to discard it when not needed?
> > > >
> > > > Well, I don't think we need linker list magic when __maybe_unused w=
ill
> > > > just have them be discarded normally.
> > >
> > > Yes, perhaps things are in a better state than they used to be, but
> > > there is a linker discard for commands at present.
> >
> > Yes, but __maybe_unused means we don't get a warning about it, and it's
> > literally discarded as part of --gc-sections as it done everywhere with
> > maybe 3 exceptions?
>=20
> Actually with this series we get a lot closer to that. The problem
> with the status quo is that disabling CMDLINE doesn't disable most
> commands, relying instead on discarding them at link time.

I don't follow you here.  We're talking only about the long help.
There's already an option to enable/disable it.  When disabled all of
the long help text should be discarded, because we reference it via
U_BOOT_CMD macro which in turn cares about it, or not.  What's missing
is a U_BOOT_LONGHELP macro so that instead of:
#ifdef CONFIG_SYS_LONGHELP
static char cat_help_text[] =3D
        "<interface> <dev[:part]> <file>\n"
        "  - Print file from 'dev' on 'interface' to standard output\n";
#endif

We do:
U_BOOT_LONGHELP(cat,
        "<interface> <dev[:part]> <file>\n"
        "  - Print file from 'dev' on 'interface' to standard output\n"
);

Which then does:
static __maybe_unused char cat_help_text[] =3D
=2E..
;

And we discard the text automatically due to --gc-sections.  We possibly
haven't already been doing this since back when we first started using
--gc-sections there was a bug in binutils that caused text like the
above to still get combined in to other objects and not discarded.
That's been fixed for ages.

And the above macro would also let us clean up U_BOOT_CMD macro slightly
to just omit the longhelp option and instead always do _CMD_HELP(_name)
inside the macros.  It'll also make it harder to add new commands
without a long help by accident.

> With this series, it looks like we can in fact do that, so I should
> remove the discards as well.
>=20
> The one proviso is that this does drop a lot of things we want...e.g.
> BOOTSTD_DEFAULTS cannot be enabled due to its use of 'select', meaning
> that common filesystems are dropped. So we'll need more effort after
> this, to allow (for example) bootmeths that don't need commands to
> work correctly. But I think this series at least provides a better
> starting point for teasing things apart.
>=20
> So OK I'll go with __maybe_unused for the ones that need it, which
> isn't too many given that many of the strings are just included
> directly in the macro. It is considerably easier than trying to be to
> clever about things.

Yes, this series itself has a lot of problems that need to be addressed
before reposting because I don't like "hiding" that network stuff no
longer works, and I also saw that DFU also silently failing.

--=20
Tom

--NPK+pq+qYwZqxflM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUgO+IACgkQFHw5/5Y0
tywWagv5AZXIpO2nBIing3RUscNxmWJApSgTxKkZrOm1fsZNA+kXlA9ySI+10vgh
fq+FOA9qMguw8eClQq14DqqtjOV3N2eeAbzbsBT7oRd5BaFBfVwYZgyjbwN1LHTT
gusiOf+Wm+fOSH1OMAhsJlH9DMTFILLjXqZUsOuDaqcUNHSnFccaUW4KvB//19OQ
EUeaKn2te/5cs1qr+ZTkNe/cnJEo0q90QJMyXtNYFcJ/5PYqxEw6t6/2jnINL0YP
attcFMZ8cHH10PSdM7kQ1MsvDivBH/3PMrSst+jgi963/XMUpbAOAhdO0qliLfTT
Ikd24UFSow0+CI6r5+1B2U4xxICe6qR9lUiRKHrKCgMNypqwQfq8ZsJdD3EtNAVI
WnJBiqpgd4k77KivJw/iHu7ULElU27qnuXekC7/1ww2dJmUqBcmtHNHYBZEcbWMp
5VK+4TwMoEhVc5Ikz/74mUe4rZ5S1BPwnje8ezCHu02/sBTAdBUOh2dLJAVlWQYH
A1Tu3E5J
=LDv3
-----END PGP SIGNATURE-----

--NPK+pq+qYwZqxflM--
