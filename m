Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9504E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 17:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B7C5869DA;
	Sat,  7 Oct 2023 19:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VZOB702u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F19864DD; Sat,  7 Oct 2023 19:25:27 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93C7986A26
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 19:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5a22eaafd72so39503377b3.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696699520; x=1697304320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fzJZDjPIEN93DWLlEuMsaZ37M+q/vUw3ByM+b8f8A0c=;
 b=VZOB702uiQayKKwcf8WH/Ubc0s7qfbBsnMVdv98IvDZsbyuG909XqrknEeBsX7d2X6
 SVZE7RBOX1Kc+nzWF/oNOvbu1PSQrYsLY/6QlpKRDaJXjmMQ023+yzANggyccmD29z+B
 0n7yCnl/C4OycMRlBamxCFQmJDxKIqSPtpymo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696699520; x=1697304320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fzJZDjPIEN93DWLlEuMsaZ37M+q/vUw3ByM+b8f8A0c=;
 b=i1J3Q0GXR+q6CMvkucfKJgSFiZRgDvWl1TH38w0uwtKWNRBIWMOGBsAfJVmJUh1KWV
 P1mi60vfrJjcdsMk8JoCFUw26IEqMy7b2xW7wpr84eabbqMghBtLpRAf0h6ZcfvIcznQ
 hMyzrHzvzFkccUDR6RFN9tTax8HM4F3+JStaUyiGcm2fFl8G6G0L8FL1+XncQ0ndoekt
 2qakvE+qICDluABrmRKoILg8qC2146ZjtH7FTc+5slAuSfCVP4JzESv2SgXsgHyGjQg9
 hk4RSCey+ks8d+dsPFx5zolQkJBzlXh827Lkhdf2AdOoeeyZNULYuqm/olE+aIHirHiO
 iUBA==
X-Gm-Message-State: AOJu0YyZU2qvAvPOjHX5Tlz6vuXtxibs+miokZZwPO3EiS9fnLlfSsBl
 uo5ctXNv3b+DzMArkKFSuej0Gg==
X-Google-Smtp-Source: AGHT+IGewKQvjyIORdJzLCP8uDlX7D/HdZ6XmMUwDvZBbdUoY2l/Qe+WzsSgFbNzMHYjxaIEoZlgUw==
X-Received: by 2002:a81:52c2:0:b0:59b:1bf9:b2db with SMTP id
 g185-20020a8152c2000000b0059b1bf9b2dbmr13018192ywb.13.1696699520030; 
 Sat, 07 Oct 2023 10:25:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-429b-02e7-f294-8f62.res6.spectrum.com.
 [2603:6081:7b00:6400:429b:2e7:f294:8f62])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a81de4d000000b0057a44e20fb8sm2171347ywl.73.2023.10.07.10.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 10:25:19 -0700 (PDT)
Date: Sat, 7 Oct 2023 13:25:16 -0400
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
Message-ID: <20231007172516.GH2227687@bill-the-cat>
References: <20230924232658.GM305624@bill-the-cat>
 <CAPnjgZ2-ORog-+Onh1McptpMDrzccVc+BfByCMjp93wLqAms6w@mail.gmail.com>
 <20231005145350.GQ8465@bill-the-cat>
 <CAPnjgZ2Mbx9H_ve_F_gq_eqt2hvwmYF455-0PHB31fV5m9HN2A@mail.gmail.com>
 <20231006021616.GB2227687@bill-the-cat>
 <CAPnjgZ3sTQNQJCpuZ4doJJH=t=mLxXaAYQR8kVXorOfqn2t5CA@mail.gmail.com>
 <20231006165504.GC2227687@bill-the-cat>
 <CAPnjgZ1GZ+Ryt2=_Sf0Z+XM+V58Ty4UmdrAo2bW-Ubs9s19=Ww@mail.gmail.com>
 <20231007010053.GE2227687@bill-the-cat>
 <CAPnjgZ3Pss6uOhnopo4Yn0digdNs1niNqqrJHRmnrbDvehT1hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9g6HhpWIqkh4e52b"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3Pss6uOhnopo4Yn0digdNs1niNqqrJHRmnrbDvehT1hg@mail.gmail.com>
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


--9g6HhpWIqkh4e52b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 09:37:07AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 6 Oct 2023 at 19:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Oct 06, 2023 at 04:42:44PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 6 Oct 2023 at 10:55, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Oct 06, 2023 at 07:03:17AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 5 Oct 2023 at 20:16, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Oct 05, 2023 at 07:41:49PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Thu, 5 Oct 2023 at 08:53, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Wed, Oct 04, 2023 at 07:23:47PM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Sun, 24 Sept 2023 at 17:27, Tom Rini <trini@konsulko.c=
om> wrote:
> > > > > > > > > >
> > > > > > > > > > On Sun, Sep 24, 2023 at 02:39:23PM -0600, Simon Glass w=
rote:
> > > > > > > > > > > Some commands assume that CONFIG_SYS_LONGHELP is alwa=
ys defined.
> > > > > > > > > > > Declaration of long help should be bracketed by an #i=
fdef to avoid an
> > > > > > > > > > > 'unused variable' warning.
> > > > > > > > > > >
> > > > > > > > > > > Fix this treewide.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > [snip]
> > > > > > > > > > > diff --git a/arch/arm/mach-imx/cmd_dek.c b/arch/arm/m=
ach-imx/cmd_dek.c
> > > > > > > > > > > index 6fa5b41fcd38..25ea7d3b37da 100644
> > > > > > > > > > > --- a/arch/arm/mach-imx/cmd_dek.c
> > > > > > > > > > > +++ b/arch/arm/mach-imx/cmd_dek.c
> > > > > > > > > > > @@ -393,11 +393,12 @@ static int do_dek_blob(struct c=
md_tbl *cmdtp, int flag, int argc,
> > > > > > > > > > >       return blob_encap_dek(src_addr, dst_addr, len);
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > -/***************************************************/
> > > > > > > > > > > +#if IS_ENABLED(CONFIG_SYS_LONGHELP)
> > > > > > > > > > >  static char dek_blob_help_text[] =3D
> > > > > > > > > > >       "src dst len            - Encapsulate and creat=
e blob of data\n"
> > > > > > > > > > >       "                         $len bits long at add=
ress $src and\n"
> > > > > > > > > > >       "                         store the result at a=
ddress $dst.\n";
> > > > > > > > > > > +#endif
> > > > > > > > > > >
> > > > > > > > > > >  U_BOOT_CMD(
> > > > > > > > > > >       dek_blob, 4, 1, do_dek_blob,
> > > > > > > > > >
> > > > > > > > > > This really doesn't read nicely.  I would rather (globa=
lly and fix
> > > > > > > > > > existing users) __maybe_unused this instead.  I think t=
here's just one
> > > > > > > > > > example today that isn't "foo_help_text".
> > > > > > > > >
> > > > > > > > > Hmm, what do you think about adding a __longhelp symbol t=
o cause the
> > > > > > > > > linker to discard it when not needed?
> > > > > > > >
> > > > > > > > Well, I don't think we need linker list magic when __maybe_=
unused will
> > > > > > > > just have them be discarded normally.
> > > > > > >
> > > > > > > Yes, perhaps things are in a better state than they used to b=
e, but
> > > > > > > there is a linker discard for commands at present.
> > > > > >
> > > > > > Yes, but __maybe_unused means we don't get a warning about it, =
and it's
> > > > > > literally discarded as part of --gc-sections as it done everywh=
ere with
> > > > > > maybe 3 exceptions?
> > > > >
> > > > > Actually with this series we get a lot closer to that. The problem
> > > > > with the status quo is that disabling CMDLINE doesn't disable most
> > > > > commands, relying instead on discarding them at link time.
> > > >
> > > > I don't follow you here.  We're talking only about the long help.
> > >
> > > I was actually talking about how the command code is removed. This
> > > series allows that to happen via Kconfig rather than needing a
> > > linker-script discard rule, something I only just fully appreciated.
> >
> > OK.  But this series as-is has a lot of problems and I don't see it as
> > more than a proof of concept.
>=20
> Probably I need to send a few version as this discussion is becoming a
> bit theoretical.
>=20
> >
> > > > There's already an option to enable/disable it.  When disabled all =
of
> > > > the long help text should be discarded, because we reference it via
> > > > U_BOOT_CMD macro which in turn cares about it, or not.  What's miss=
ing
> > > > is a U_BOOT_LONGHELP macro so that instead of:
> > > > #ifdef CONFIG_SYS_LONGHELP
> > > > static char cat_help_text[] =3D
> > > >         "<interface> <dev[:part]> <file>\n"
> > > >         "  - Print file from 'dev' on 'interface' to standard outpu=
t\n";
> > > > #endif
> > > >
> > > > We do:
> > > > U_BOOT_LONGHELP(cat,
> > > >         "<interface> <dev[:part]> <file>\n"
> > > >         "  - Print file from 'dev' on 'interface' to standard outpu=
t\n"
> > > > );
> > > >
> > > > Which then does:
> > > > static __maybe_unused char cat_help_text[] =3D
> > > > ...
> > > > ;
> > > >
> > > > And we discard the text automatically due to --gc-sections.  We pos=
sibly
> > > > haven't already been doing this since back when we first started us=
ing
> > > > --gc-sections there was a bug in binutils that caused text like the
> > > > above to still get combined in to other objects and not discarded.
> > > > That's been fixed for ages.
> > > >
> > > > And the above macro would also let us clean up U_BOOT_CMD macro sli=
ghtly
> > > > to just omit the longhelp option and instead always do _CMD_HELP(_n=
ame)
> > > > inside the macros.  It'll also make it harder to add new commands
> > > > without a long help by accident.
> > >
> > > Gosh this is complicated.
> > >
> > > At present the U_BOOT_CMD() macro just drops the strings...the problem
> > > with the unused var only happens in a small number of cases where an
> > > explicit var is used. I don't see why creating a var (when none is
> > > there today) helps anything? It doesn't detect missing longhelp, since
> > > this is already an error (missing argument). Sure,  "" can be
> > > provided, but your macro doesn't stop that either.
> >
> > The problem today is that 95% of the cases surround the help text with
> > #ifdef CONFIG_SYS_LONGHELP ... #endif.  That's why the rest of the
> > macros are the way they are today.  And that in turn is due to (in part
> > at least) old compiler bugs.
>=20
> I see about 46 #idefs for that and nearly 300 commands that don't have on=
e.
>=20
> >
> > > If you are suggesting a new U_BOOT_LONGHELP() macro, bear in mind that
> > > we already have quite a lot...each new 'top-level' macro results in
> > > more combinations.
> >
> > It really should just be a single macro.  I think I'll make an attempt
> > at this, to show what I'm talking about.
>=20
> OK thanks.
>=20
> >
> > > > > With this series, it looks like we can in fact do that, so I shou=
ld
> > > > > remove the discards as well.
> > > > >
> > > > > The one proviso is that this does drop a lot of things we want...=
e.g.
> > > > > BOOTSTD_DEFAULTS cannot be enabled due to its use of 'select', me=
aning
> > > > > that common filesystems are dropped. So we'll need more effort af=
ter
> > > > > this, to allow (for example) bootmeths that don't need commands to
> > > > > work correctly. But I think this series at least provides a better
> > > > > starting point for teasing things apart.
> > > > >
> > > > > So OK I'll go with __maybe_unused for the ones that need it, which
> > > > > isn't too many given that many of the strings are just included
> > > > > directly in the macro. It is considerably easier than trying to b=
e to
> > > > > clever about things.
> > > >
> > > > Yes, this series itself has a lot of problems that need to be addre=
ssed
> > > > before reposting because I don't like "hiding" that network stuff no
> > > > longer works, and I also saw that DFU also silently failing.
> > >
> > > Yes I saw your other comments. But I think this patch is the big area
> > > of confusion.
> >
> > This isn't the tricky part of the series that I'm saying has problems,
> > that part is all of the functionality that's not being untangled and I
> > think leads to the question of what exactly is the use case where we do
> > remove the command line but don't need some of that functionality still.
>=20
> For security and code-size reasons it is useful to disable commands,
> perhaps all of them. Quite a few features don't need it, but it
> certainly would take more effort to get a usable version. The goal of
> this series is to avoid people adding Kconfig mistakes which need to
> be cleaned up later.

Maybe the biggest take away should be to do things smaller.  DFU
intentionally and fundamentally constructs something for the CLI parser
to use.  Rework that.  Same for the network stack.  Do some slight
re-org / fixing of more intentional dependencies on their own.

--=20
Tom

--9g6HhpWIqkh4e52b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUhlHkACgkQFHw5/5Y0
tyz0ggv+MfTck/ewZWdKQMJQSbnH4B16KrxdRiADQobvoz68CT9KkFqKCqcWFtlX
cIPPa4WwLhGaemH+oc6JjMqiypdqKszLxWmECdMHySAJQaxpGEpUhEsXWzvijyx7
HZbS9kQmaiRFrvN7PaAETzsBSvmT/LTi2HZDE7QB45fMiFSaPPDiPEdaByFRh953
FNp6dizmEE17bTf8bBRO51tZcyl3oQlZvYt2u1BpGz8P6qZm+9/7mFI74cjCHWFE
2BZFsqfuk5AUcVweG9w+5ShKNxuIKlqNZWsx78ud9UWriLooGFxhqJSQv9hduD6/
tRghd1JOIhV9eSkVuEI4ffSNxKuJxXcEDaV5REnffYNB2YRbCm8g6vBzK51NROR6
zRbbFWt8/YP0SedJ4jpWKOUg7PAT3dYd2HPy8jwNhFq3yjzoo8KCkRH5+errrCGu
rX5WsROsRbZo/YLZWMnHGJWXaKC6q8q8kgHWm2HI0ChokxIV43wj7N9DbRsfKT+E
lhOL6SRJ
=5tgV
-----END PGP SIGNATURE-----

--9g6HhpWIqkh4e52b--
