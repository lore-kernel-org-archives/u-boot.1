Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188CECF9C6F
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 20:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4727D88A0D;
	Mon, 23 Sep 2024 22:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pg3/+9uy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46D25889C9; Mon, 23 Sep 2024 22:35:11 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF5B488B16
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 22:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6c579748bf4so45885396d6.1
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727123708; x=1727728508; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cd3RB0dX1LOkK4Yetw20bLRIOIAMHe8i1KxDuHdDOW4=;
 b=pg3/+9uy3H6Rh3tlBJttvqasucghunOfMFl8s2ynlefifAP2VL3NwBq5NnKXyofwkl
 Aq8HBwpRwM+zejpXkAcE5jeCssAtYx/RLEl8zzZ7Od6BH+y1fP2HyFJWvOBFJoHZO2O9
 wk16xiw6LaA3fuXEMpHQnYXeqKnkbXF+5z3KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727123708; x=1727728508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cd3RB0dX1LOkK4Yetw20bLRIOIAMHe8i1KxDuHdDOW4=;
 b=oaLAVuoJQBcynSobbX+XoSGi1pEJytk35dxN1/0gjz9eilnk6DMsiPe1l1t8SiZ5h7
 BD711YuX3J8BvhwGt/r8AUGRsEHtiCJVcA6IdLXJ4KchkL3cK9k01UNTY1r7Z9yTSGHu
 LAdtDzlHzt7VJY4aNrfEfLYnXkz5lwKHJM5JSnlgO+D3Ljq7ez5Nwi9QzYfUiPX/3n4A
 6LvpNzIKr3j925hUB/Dd4uA19W0OmJnKJUvMPbEN5xTfpHUGADaOyhpvg8rE4SypnthE
 xoBTCvDzsqJxROkTaud/HEDojgptEX3EvbwpI//Y2Sga0iFnhJmXfvLvfaGKywmfrTuJ
 RSnw==
X-Gm-Message-State: AOJu0YxvWzUhqboQTPucYOiFjcKoq3nsZbVd+TtxHVMbqyX6Hs5JB9WH
 qa136lQaMQfgFnGZn55vceRYkdKvmrgB9DxeovvCwRqDqswsfMDrJiAdAJYrOPA=
X-Google-Smtp-Source: AGHT+IE8i3Tzed/wJm18UFoO2Rv0gMHaCNAc66UjiImu/4hhT5OmdVdjEkNK7hfxV0tUufPU/AZT6g==
X-Received: by 2002:a05:6214:459a:b0:6c3:54a4:eea1 with SMTP id
 6a1803df08f44-6c7bc679aedmr238839556d6.9.1727123707694; 
 Mon, 23 Sep 2024 13:35:07 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb0f4a3e5bsm310466d6.20.2024.09.23.13.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 13:35:06 -0700 (PDT)
Date: Mon, 23 Sep 2024 14:35:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
Message-ID: <20240923203503.GP4252@bill-the-cat>
References: <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
 <20240626140752.GV38804@bill-the-cat>
 <CAFLszTj0h5w+sz796LokxgcfyRTGmHnQJ3OTDdoaoC61Ob=akw@mail.gmail.com>
 <20240627144214.GC38804@bill-the-cat>
 <CAFLszTixbMxDq7TvjPzc+Xup6biMmPvLP5CVPJLp7w94e0dd4Q@mail.gmail.com>
 <CAFLszThFL4BnoprJJ8qdSo8g_5Umo36yGp0ba4w=cAexgH9cNA@mail.gmail.com>
 <20240729181719.GP989285@bill-the-cat>
 <CAFLszTi-ajf+wbwxyK3Xq3Efnwz9y+8U7nL7MgLrNY2h=V7faw@mail.gmail.com>
 <20240731171719.GE3794063@bill-the-cat>
 <CAFLszTiSngoo_6-t7u+uPCsELHGkoRy4-5J_i_1v8rWfFpvMRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/pyYot3ZM6m0QJ50"
Content-Disposition: inline
In-Reply-To: <CAFLszTiSngoo_6-t7u+uPCsELHGkoRy4-5J_i_1v8rWfFpvMRA@mail.gmail.com>
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


--/pyYot3ZM6m0QJ50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 04:13:57PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 31 Jul 2024 at 19:17, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jul 31, 2024 at 08:39:30AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 29 Jul 2024 at 12:17, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Jul 28, 2024 at 01:36:09PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 28 Jun 2024 at 01:33, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 27 Jun 2024 at 15:42, Tom Rini <trini@konsulko.com> wro=
te:
> > > > > > >
> > > > > > > On Thu, Jun 27, 2024 at 09:37:15AM +0100, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Wed, 26 Jun 2024 at 15:07, Tom Rini <trini@konsulko.com>=
 wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jun 26, 2024 at 09:00:41AM +0100, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.=
com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass=
 wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsu=
lko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon G=
lass wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Some configuration is now in variables with a C=
FG_ prefix. Add these to
> > > > > > > > > > > > > > the .cfg file so that we can see everything in =
one place. Sort the
> > > > > > > > > > > > > > options so they are easier to find and compare.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > ---
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Changes in v2:
> > > > > > > > > > > > > > - Add new patch to update u-boot.cfg with CFG_.=
=2E. options
> > > > > > > > > > > > > >
> > > > > > > > > > > > > >  scripts/Makefile.autoconf | 2 +-
> > > > > > > > > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > diff --git a/scripts/Makefile.autoconf b/script=
s/Makefile.autoconf
> > > > > > > > > > > > > > index b42f9b525fe..65ff11ea508 100644
> > > > > > > > > > > > > > --- a/scripts/Makefile.autoconf
> > > > > > > > > > > > > > +++ b/scripts/Makefile.autoconf
> > > > > > > > > > > > > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf =3D GEN   =
  $@
> > > > > > > > > > > > > >  quiet_cmd_u_boot_cfg =3D CFG     $@
> > > > > > > > > > > > > >        cmd_u_boot_cfg =3D \
> > > > > > > > > > > > > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM i=
nclude/config.h > $@.tmp && { \
> > > > > > > > > > > > > > -             grep 'define CONFIG_' $@.tmp | \
> > > > > > > > > > > > > > +             egrep 'define (CONFIG_|CFG_)' $@.=
tmp | sort | \
> > > > > > > > > > > > > >                       sed '/define CONFIG_IS_EN=
ABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > > > > > > > > > > > > >               rm $@.tmp;                       =
                       \
> > > > > > > > > > > > > >       } || {                                   =
                       \
> > > > > > > > > > > > >
> > > > > > > > > > > > > I don't like this because whereas "CONFIG_" is en=
forced to be set only
> > > > > > > > > > > > > by Kconfig and so always all reliably set and fou=
nd via a single header,
> > > > > > > > > > > > > CFG_ stuff is not.
> > > > > > > > > > > >
> > > > > > > > > > > > OK, so how are CFG_ options found? I hit this when =
trying to find the
> > > > > > > > > > > > SDRAM size on rockchip 3399 and I could not find an=
y way of figuring
> > > > > > > > > > > > it out.
> > > > > > > > > > >
> > > > > > > > > > > It's just another define, there's no uniformity to it=
=2E For some of the
> > > > > > > > > > > SDRAM values really we need some build time way to gr=
ab some information
> > > > > > > > > > > out of the default device tree.
> > > > > > > > > >
> > > > > > > > > > Can you give an example of a board that could use this?=
 I looked at
> > > > > > > > > > the devicetree for chromebook_kevin and don't see a mem=
ory range in
> > > > > > > > > > ther.
> > > > > > > > >
> > > > > > > > > OK, wow, I didn't realize /memory was optional now. But i=
ndeed, I don't
> > > > > > > > > see it in the dtb file. That removes that option then, sa=
dly.
> > > > > > > >
> > > > > > > > Well, we can still require it, so long as an error is produ=
ced if the
> > > > > > > > property is needed but does not exist.
> > > > > > >
> > > > > > > "We" who? I don't feel like we'll have a lot of traction with=
 linux
> > > > > > > kernel folks in requiring /memory to be added to the dts file=
s on
> > > > > > > however many platforms don't have it today because I'm going =
to guess
> > > > > > > it's added at run time, possibly by us, with the correct size=
 and we'd
> > > > > > > be asking for statically adding things half-wrong like a lot =
of
> > > > > > > platforms used to do (and in turn rely on U-Boot to correct t=
he size).
> > > > > >
> > > > > > Hmm yes of course, the firmware is supposed to add these
> > > > > > properties...that's how it gets in there. So we need to stick w=
ith CFG
> > > > > > (and perhaps the RAM-size prober) for now.
> > > > >
> > > > > Coming back to this patch, can we apply it? It provides a way to =
find
> > > > > out the value of these CFG options, which otherwise involves chas=
ing
> > > > > around header files.
> > > >
> > > > No, because it implies that there's a consistent way to know what a
> > > > given CFG value will be when there is not. There is no equivalent h=
eader
> > > > to include like for CONFIG symbols to know that you got them. You're
> > > > likely better off trying out "ripgrep" which I have found to be much
> > > > faster than "git grep".
> > >
> > > Hmm it is really hard to know which files to grep!
> >
> > It's super easy with ripgrep:
> > $ rg -g *.h CFG_SYS_SDRAM_SIZE
>=20
> All that does is show me lots of matches. I'm not sure which board
> they relate to. Some of them are obvious, but quite a few have header
> files common to many boards.
>=20
> >
> > > Could we require that config.h includes all the CFG values? I'm just
> > > trying to find a way to bring a bit more order to this area.
> >
> > Well, some of them could perhaps be Kconfig symbols instead, it just got
> > too tedious to untangle some of them. For others (not
> > CFG_SYS_SDRAM_SIZE/BASE, sadly) it goes back to my idea about seeing
> > what can be pulled at build time from the default device tree.
>=20
> Hmm, yes. I am not sure how many are in that category. Linux often
> seems to use tables of data in the code, since it doesn't care so much
> about code size. So finding bindings for some of this data may be
> tricky.
>=20
> I suppose the SDRAM base/size could go in the DT if it had its own
> binding, e.g. in /options/u-boot - but still many boards would want to
> determine the size at runtime.
>=20
> With text environment and a solution to SDRAM, perhaps we can require
> that new boards not use CFG_...?

I don't see doing anything further to CFG_ as particularly important
right now, honestly. The majority of symbols are in legacy things and
then it's just a few symbols that no, really, there's not a good way to
get this information other than a define.

--=20
Tom

--/pyYot3ZM6m0QJ50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbx0OoACgkQFHw5/5Y0
tywGLwwAlLH6mFI9cCsNRsxY7o0WEGZcFpsfQ9tVVNOa0rFoPc1R2eo3Vq5QNFm5
ij/v8XUFTn6e8IMLoaYPpJ/WNt9ME4WQJpyqxqtcYPpjd4s0JA9eaV/Y27Wzgymg
KUSi+sKJa3M9jBUKrhLsIImB4nS/DkJw3HoLNZJZl0KDqqWjMTUkdoY1cXywOVwg
FgClQebv30TgW3Y3SlCbEI3+6E+HC0T7rH9maIJEEFJWUhEP8oEasyDNUlXXFage
UYHhY5jMD8wEWteBFRefaqyF6sMlJnwUtS0XWZT068hsxRJ8r+HGvLJFeS2iMril
/vQaLr97wJgrI2iaIO4/+SdJ8xf+qZKlAD1ITmZ/3wXAN36ZybRv2yrgL/NJlQOv
mHIdfZv+tgCw1E+zFdTZ/Fk94WyL7uGH0OLGepuknDHHT0S0QDZXmS8JmU7WObro
ZvF5dp/sw7DImfovf1gHDArwRc/TaMcwoHCE9p7UTxmjCMUGyd+BfV4RkR/lH9xo
l5osxZ4I
=2/hd
-----END PGP SIGNATURE-----

--/pyYot3ZM6m0QJ50--
