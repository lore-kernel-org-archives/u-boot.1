Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE11C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 17:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD75288A40;
	Wed, 31 Jul 2024 19:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CwfuESvQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 754C988673; Wed, 31 Jul 2024 19:17:26 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0B28881B
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 19:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7094641d4e6so1937786a34.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 10:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722446243; x=1723051043; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=30DKcDEdeHHPup459baqOK0ep1aiFfaKXwcFXMgHpdM=;
 b=CwfuESvQ7zT321RuAsEP38V2MWxMzZU89zlOOAxR85lPGPJkeYMLqGBaK6zeAPCvKT
 gryXqbuJq8JtKfn735JCDZ0NK+ZX+fXnGHekh3yG7wX+Vxmbbb3bYVxi1oh9rtZSaqoV
 tEUcKqeU7Gko2H1ThTA87CnlNDuuJ/ikNCsKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722446243; x=1723051043;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30DKcDEdeHHPup459baqOK0ep1aiFfaKXwcFXMgHpdM=;
 b=uCytDPZEPLugDw2feFmVqANikW+XRkksq6+nFE/9jOHYV5jRjipM6JkS1ncxAGEsGb
 /TohhZcbvF3jeAkPUdxmoEns9zwClB0C14P429oDE3KW3Ks9Jxegr8BY56BsM8n6XN4r
 E8WsgTMvDmzaaJcQpZs++wzgG+IoVtbkm2fNPhq45IaZzah8Te33NF13Ki2cVnaulE5i
 XoYDaphNgt1BtdTn3TdX1SWbwKwNYGmXFW/XsMFBNWhj2YqB0CavNYgA0cWU9ZLuNaQc
 y0EBqxmtUZdWc8U3DL/rpbo7muOiIubYn7304WQDFyojSK8wMbbN2Ty0XvfIDACcWkgy
 frvQ==
X-Gm-Message-State: AOJu0YxH9Oq06cCeeyWmXOI9JWSeZx/D/sx2UubwjY/2JSinNkQQMrjQ
 Li8nm6MCpNvFFURwqjbpYn/iNv60y9AAInf2U6AMcgBoqIf1OGROyZODwG8ww+g=
X-Google-Smtp-Source: AGHT+IFTmAMexkYR7qGp43nuxOl4Ndjtv+ZIe3TFe/UfXQq5sCqMMygztD1rMJi/TMspkpEkybpndw==
X-Received: by 2002:a05:6830:6383:b0:709:4882:d001 with SMTP id
 46e09a7af769-7094882df11mr17327961a34.9.1722446242757; 
 Wed, 31 Jul 2024 10:17:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7095ad4e8d1sm974464a34.13.2024.07.31.10.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 10:17:22 -0700 (PDT)
Date: Wed, 31 Jul 2024 11:17:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
Message-ID: <20240731171719.GE3794063@bill-the-cat>
References: <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
 <20240625141427.GO38804@bill-the-cat>
 <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
 <20240626140752.GV38804@bill-the-cat>
 <CAFLszTj0h5w+sz796LokxgcfyRTGmHnQJ3OTDdoaoC61Ob=akw@mail.gmail.com>
 <20240627144214.GC38804@bill-the-cat>
 <CAFLszTixbMxDq7TvjPzc+Xup6biMmPvLP5CVPJLp7w94e0dd4Q@mail.gmail.com>
 <CAFLszThFL4BnoprJJ8qdSo8g_5Umo36yGp0ba4w=cAexgH9cNA@mail.gmail.com>
 <20240729181719.GP989285@bill-the-cat>
 <CAFLszTi-ajf+wbwxyK3Xq3Efnwz9y+8U7nL7MgLrNY2h=V7faw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+ffDYp3q9yilMZlO"
Content-Disposition: inline
In-Reply-To: <CAFLszTi-ajf+wbwxyK3Xq3Efnwz9y+8U7nL7MgLrNY2h=V7faw@mail.gmail.com>
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


--+ffDYp3q9yilMZlO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 08:39:30AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 29 Jul 2024 at 12:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Jul 28, 2024 at 01:36:09PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 28 Jun 2024 at 01:33, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Thu, 27 Jun 2024 at 15:42, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Jun 27, 2024 at 09:37:15AM +0100, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 26 Jun 2024 at 15:07, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Wed, Jun 26, 2024 at 09:00:41AM +0100, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass=
 wrote:
> > > > > > > > > > >
> > > > > > > > > > > > Some configuration is now in variables with a CFG_ =
prefix. Add these to
> > > > > > > > > > > > the .cfg file so that we can see everything in one =
place. Sort the
> > > > > > > > > > > > options so they are easier to find and compare.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > >
> > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > - Add new patch to update u-boot.cfg with CFG_... o=
ptions
> > > > > > > > > > > >
> > > > > > > > > > > >  scripts/Makefile.autoconf | 2 +-
> > > > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/scripts/Makefile.autoconf b/scripts/Ma=
kefile.autoconf
> > > > > > > > > > > > index b42f9b525fe..65ff11ea508 100644
> > > > > > > > > > > > --- a/scripts/Makefile.autoconf
> > > > > > > > > > > > +++ b/scripts/Makefile.autoconf
> > > > > > > > > > > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf =3D GEN     $@
> > > > > > > > > > > >  quiet_cmd_u_boot_cfg =3D CFG     $@
> > > > > > > > > > > >        cmd_u_boot_cfg =3D \
> > > > > > > > > > > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM inclu=
de/config.h > $@.tmp && { \
> > > > > > > > > > > > -             grep 'define CONFIG_' $@.tmp | \
> > > > > > > > > > > > +             egrep 'define (CONFIG_|CFG_)' $@.tmp =
| sort | \
> > > > > > > > > > > >                       sed '/define CONFIG_IS_ENABLE=
D(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > > > > > > > > > > >               rm $@.tmp;                           =
                   \
> > > > > > > > > > > >       } || {                                       =
                   \
> > > > > > > > > > >
> > > > > > > > > > > I don't like this because whereas "CONFIG_" is enforc=
ed to be set only
> > > > > > > > > > > by Kconfig and so always all reliably set and found v=
ia a single header,
> > > > > > > > > > > CFG_ stuff is not.
> > > > > > > > > >
> > > > > > > > > > OK, so how are CFG_ options found? I hit this when tryi=
ng to find the
> > > > > > > > > > SDRAM size on rockchip 3399 and I could not find any wa=
y of figuring
> > > > > > > > > > it out.
> > > > > > > > >
> > > > > > > > > It's just another define, there's no uniformity to it. Fo=
r some of the
> > > > > > > > > SDRAM values really we need some build time way to grab s=
ome information
> > > > > > > > > out of the default device tree.
> > > > > > > >
> > > > > > > > Can you give an example of a board that could use this? I l=
ooked at
> > > > > > > > the devicetree for chromebook_kevin and don't see a memory =
range in
> > > > > > > > ther.
> > > > > > >
> > > > > > > OK, wow, I didn't realize /memory was optional now. But indee=
d, I don't
> > > > > > > see it in the dtb file. That removes that option then, sadly.
> > > > > >
> > > > > > Well, we can still require it, so long as an error is produced =
if the
> > > > > > property is needed but does not exist.
> > > > >
> > > > > "We" who? I don't feel like we'll have a lot of traction with lin=
ux
> > > > > kernel folks in requiring /memory to be added to the dts files on
> > > > > however many platforms don't have it today because I'm going to g=
uess
> > > > > it's added at run time, possibly by us, with the correct size and=
 we'd
> > > > > be asking for statically adding things half-wrong like a lot of
> > > > > platforms used to do (and in turn rely on U-Boot to correct the s=
ize).
> > > >
> > > > Hmm yes of course, the firmware is supposed to add these
> > > > properties...that's how it gets in there. So we need to stick with =
CFG
> > > > (and perhaps the RAM-size prober) for now.
> > >
> > > Coming back to this patch, can we apply it? It provides a way to find
> > > out the value of these CFG options, which otherwise involves chasing
> > > around header files.
> >
> > No, because it implies that there's a consistent way to know what a
> > given CFG value will be when there is not. There is no equivalent header
> > to include like for CONFIG symbols to know that you got them. You're
> > likely better off trying out "ripgrep" which I have found to be much
> > faster than "git grep".
>=20
> Hmm it is really hard to know which files to grep!

It's super easy with ripgrep:
$ rg -g *.h CFG_SYS_SDRAM_SIZE

> Could we require that config.h includes all the CFG values? I'm just
> trying to find a way to bring a bit more order to this area.

Well, some of them could perhaps be Kconfig symbols instead, it just got
too tedious to untangle some of them. For others (not
CFG_SYS_SDRAM_SIZE/BASE, sadly) it goes back to my idea about seeing
what can be pulled at build time from the default device tree.

--=20
Tom

--+ffDYp3q9yilMZlO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaqcZ8ACgkQFHw5/5Y0
tyziKgv+KSBpauV2qGIqvEOdyuCVzIF4lxKCwVn1WehiWGYsMZs8OrZh2y+6yPSy
iN9aSZiwqdV9xRZAJjmKejtzhjrowPrm+GNKCZGeOSZ2YKdgMci+489q6tU8+RIK
uOCyE7DUcfLk66tSLLyo3siAFZDPAF3HFA+MAJT0fvnxpRT81Eu1tx2o1srJWSrZ
L5Jo/JOiCW7tu2FRIGMXaxfJDUg6YQKq0D7n7u0+3Y7rrE97jmU4hcGvpOZHsOhX
9mDYYZrvpGtGOMDlmWnRN8fDO8KU337iCrCPNWFuo84jjAZSC9F1Czgvuc2uq/SZ
Gced6aS7E0NER09DQhny8iSK5X1YFrxr8p4lI7sg2+HcjedOCa0KC95LyR/mVsjp
1EkNhLVrtZCLfP8ag3VIxKVvxjv/j82uyO6amI9DsmrODs+Ck8fgFqMoP8pwMaWB
yH1eQvm2vJmR3XynxC2WIoAXvwM/9NlfIjJ0z6qxNNc8eVpY2apKcWRqnMfMNeX0
xzZ8vHk0
=kajm
-----END PGP SIGNATURE-----

--+ffDYp3q9yilMZlO--
