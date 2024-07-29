Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C17AC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 18:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4057B88815;
	Mon, 29 Jul 2024 20:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GHo01xIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8E4088804; Mon, 29 Jul 2024 20:17:26 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B671388815
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 20:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3db15d73f04so1979630b6e.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722277042; x=1722881842; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wdv6NIO+TEykA14YWBTliCL+8FfZUQX+OWloByNfIiI=;
 b=GHo01xIaAHjUvPPkrTgxWP0gIxEqKxtxucrgjVd9b+nUlnyDueL0TyGqSumDuwWklc
 RgdMSVUV0BDST+m9Jk6AVKxptkyGjLnPHJgusrjWtFHI1gzJiPWxEcUfWLbhdApyRi8b
 F34oU2CUhgaYr8tW0w0sl+ruZe00/+f4NnQ6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722277042; x=1722881842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdv6NIO+TEykA14YWBTliCL+8FfZUQX+OWloByNfIiI=;
 b=tZR42v5wEsU5I0Xb7qgqZB+8NskJ8imznY+urZn7smGC9k++csIOF3RZr/zvcqrPrv
 Zz/mO8iHPCZJbSrLr4NdEGqfD8vSKgGVJ9WoqVP3dP2gEPpulgD2SAAYCUDT6C3dA/P0
 9H6LvbwphvXdomMYh6pFeB7SGkYbpcjb0lG3z5J+pRic4nd8+viOTdNJrA2Pt71Ca8Ay
 2mTRZSg8w3xIqlid/sLGLAZ0grhy6kn1z0jt8zhh1FHstBgO1BE2XIpn3cuANOqW8WfJ
 hopt0ugrZlsL2qCDD86ifhmq36zdKOHAwSlT08trQdwoScdXopXgquqUqWWTzbVpb6QO
 f+TQ==
X-Gm-Message-State: AOJu0YwBKKHDYprvfyYBRREY3+WWYFJ8eH4E43pZNHQ2w4wkaw9+oEkv
 DCrvkj1qeZ9X90u7fylMxij6hprAaDjocQumm0RmO+bCgbWhj+COuC8xS2fBYMA=
X-Google-Smtp-Source: AGHT+IEQ6XE6GaYBs8Nydm+7ug2C08tZZgLjJtUoQnMaz2srXMq8835YrwvugakYlOYx3k0jKwG4Qw==
X-Received: by 2002:a05:6808:198c:b0:3da:aba0:8255 with SMTP id
 5614622812f47-3db236a7de4mr8122868b6e.16.1722277042351; 
 Mon, 29 Jul 2024 11:17:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db1351d84bsm2170851b6e.44.2024.07.29.11.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 11:17:21 -0700 (PDT)
Date: Mon, 29 Jul 2024 12:17:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
Message-ID: <20240729181719.GP989285@bill-the-cat>
References: <20240623203033.1566505-14-sjg@chromium.org>
 <20240624182931.GI38804@bill-the-cat>
 <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
 <20240625141427.GO38804@bill-the-cat>
 <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
 <20240626140752.GV38804@bill-the-cat>
 <CAFLszTj0h5w+sz796LokxgcfyRTGmHnQJ3OTDdoaoC61Ob=akw@mail.gmail.com>
 <20240627144214.GC38804@bill-the-cat>
 <CAFLszTixbMxDq7TvjPzc+Xup6biMmPvLP5CVPJLp7w94e0dd4Q@mail.gmail.com>
 <CAFLszThFL4BnoprJJ8qdSo8g_5Umo36yGp0ba4w=cAexgH9cNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mVxwi+SLfuq6LcoX"
Content-Disposition: inline
In-Reply-To: <CAFLszThFL4BnoprJJ8qdSo8g_5Umo36yGp0ba4w=cAexgH9cNA@mail.gmail.com>
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


--mVxwi+SLfuq6LcoX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 01:36:09PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 28 Jun 2024 at 01:33, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Thu, 27 Jun 2024 at 15:42, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jun 27, 2024 at 09:37:15AM +0100, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 26 Jun 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Jun 26, 2024 at 09:00:41AM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wro=
te:
> > > > > > > > >
> > > > > > > > > > Some configuration is now in variables with a CFG_ pref=
ix. Add these to
> > > > > > > > > > the .cfg file so that we can see everything in one plac=
e. Sort the
> > > > > > > > > > options so they are easier to find and compare.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Add new patch to update u-boot.cfg with CFG_... optio=
ns
> > > > > > > > > >
> > > > > > > > > >  scripts/Makefile.autoconf | 2 +-
> > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/scripts/Makefile.autoconf b/scripts/Makefi=
le.autoconf
> > > > > > > > > > index b42f9b525fe..65ff11ea508 100644
> > > > > > > > > > --- a/scripts/Makefile.autoconf
> > > > > > > > > > +++ b/scripts/Makefile.autoconf
> > > > > > > > > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf =3D GEN     $@
> > > > > > > > > >  quiet_cmd_u_boot_cfg =3D CFG     $@
> > > > > > > > > >        cmd_u_boot_cfg =3D \
> > > > > > > > > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/c=
onfig.h > $@.tmp && { \
> > > > > > > > > > -             grep 'define CONFIG_' $@.tmp | \
> > > > > > > > > > +             egrep 'define (CONFIG_|CFG_)' $@.tmp | so=
rt | \
> > > > > > > > > >                       sed '/define CONFIG_IS_ENABLED(/d=
;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > > > > > > > > >               rm $@.tmp;                               =
               \
> > > > > > > > > >       } || {                                           =
               \
> > > > > > > > >
> > > > > > > > > I don't like this because whereas "CONFIG_" is enforced t=
o be set only
> > > > > > > > > by Kconfig and so always all reliably set and found via a=
 single header,
> > > > > > > > > CFG_ stuff is not.
> > > > > > > >
> > > > > > > > OK, so how are CFG_ options found? I hit this when trying t=
o find the
> > > > > > > > SDRAM size on rockchip 3399 and I could not find any way of=
 figuring
> > > > > > > > it out.
> > > > > > >
> > > > > > > It's just another define, there's no uniformity to it. For so=
me of the
> > > > > > > SDRAM values really we need some build time way to grab some =
information
> > > > > > > out of the default device tree.
> > > > > >
> > > > > > Can you give an example of a board that could use this? I looke=
d at
> > > > > > the devicetree for chromebook_kevin and don't see a memory rang=
e in
> > > > > > ther.
> > > > >
> > > > > OK, wow, I didn't realize /memory was optional now. But indeed, I=
 don't
> > > > > see it in the dtb file. That removes that option then, sadly.
> > > >
> > > > Well, we can still require it, so long as an error is produced if t=
he
> > > > property is needed but does not exist.
> > >
> > > "We" who? I don't feel like we'll have a lot of traction with linux
> > > kernel folks in requiring /memory to be added to the dts files on
> > > however many platforms don't have it today because I'm going to guess
> > > it's added at run time, possibly by us, with the correct size and we'd
> > > be asking for statically adding things half-wrong like a lot of
> > > platforms used to do (and in turn rely on U-Boot to correct the size).
> >
> > Hmm yes of course, the firmware is supposed to add these
> > properties...that's how it gets in there. So we need to stick with CFG
> > (and perhaps the RAM-size prober) for now.
>=20
> Coming back to this patch, can we apply it? It provides a way to find
> out the value of these CFG options, which otherwise involves chasing
> around header files.

No, because it implies that there's a consistent way to know what a
given CFG value will be when there is not. There is no equivalent header
to include like for CONFIG symbols to know that you got them. You're
likely better off trying out "ripgrep" which I have found to be much
faster than "git grep".

--=20
Tom

--mVxwi+SLfuq6LcoX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAman3K8ACgkQFHw5/5Y0
tyzwtgv+L1+7UgksEi7uYzwNTUzw+314om+SNsXppsoSnNCyzM0c9/RkihC2YW3/
8FgkX35GYS/apJiw3l/nHh2xtxfqnsCIs7/NeukYi/0yUJ8wCYADslLMZjLnhxMB
eYparOwQa4qSR4256v7ZlKxzD5lfv3kK7Jt6uX5CLH6BrTn8FDCWcPGYOpfWWK8t
5QdX8nySNYTG7xSuNAQmp7xXyH5x6/Aj3Di83ym6J1tV6EwiPHWeo3dYT68qW11g
E/+bRIhmtrmfXvV23/AzQWTFf8rSC1j3ZxKYZFmEbjeEuZ5cEeb43qiPHk55rg+G
KJWoiRpw/CbDtaC21lyopqGhx4phJ5j9ugB3nD/tlTDsiywjfUpqd8UBL+h2zk3X
Mn3gBYHUX6BCmUbhAdog4yg5jZSGIf6PZiCspYlHZ57scNxzyKFgpCFHeyyyEYlj
P1IxcuSrDLwhvSzTqBdyJ7lz4anN8mNzo54/qPVETWVAWZaZTGt2oa9IcFiCIy/I
ltRvdtvd
=zPVa
-----END PGP SIGNATURE-----

--mVxwi+SLfuq6LcoX--
