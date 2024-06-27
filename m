Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BB8C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 14:42:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D41988591;
	Thu, 27 Jun 2024 16:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Me7udVhj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C894D8852C; Thu, 27 Jun 2024 16:42:19 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1BC687AEC
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 16:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3d566d5eda9so448581b6e.0
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 07:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719499336; x=1720104136; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dBXO0ig0SlUnyL2wB5BnzFHX0Z8qFt8LygJ/zVRzWYo=;
 b=Me7udVhj8dwF1GKgBHZC/wBuPAtGltJkFnFo+nZum5/jmsNFm3079oKMaUyp5QMVXp
 zPOHNIX4Qq0EfPvRlJPd/lP5PxZrMSwLCleg7Y9C8c1UmfJ1WlqEoDeWjEnZemwv/VaJ
 hCgcRGayfzcpx+r0B8rUY7gGvbDsxDLMQCp04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719499336; x=1720104136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBXO0ig0SlUnyL2wB5BnzFHX0Z8qFt8LygJ/zVRzWYo=;
 b=ArT43iWPUKGUPaXglWg6Dniy8ILtlCIT+cOCuIGuwTfnEjzCFb9oVGXo/Vji/b7QCv
 BIHe6UyXEPNVabOhRFLi7AHDwgSU/WIaNbr1Hy27Uj6zAsl1gkUA37FXRHBa4cUXZrRV
 MNMAPMlIRrwk8Gw1hGi0G+RCtV1tA8qsFiR8KrKELj7xui6knsZKr7CccVu6hP38+2ya
 DWL5fBBLbpc/jXPvtqLzzwn0HmOo5ypA6tuNd/0bxvDgGbKvc0uU582PCVSypJZ2jg/H
 NoqVWT1i3u+s1YBLY1CNJ6FEd+JX9XoPP0b0MyKpnNWUJM38jYHai/ogPN6btGVGFPLi
 KoEA==
X-Gm-Message-State: AOJu0Yxs+dPMZOTB3sQENqt6KsZrWOc4fnbHS6B/Xb1GjUBdSaUQBYxv
 B2yuUbxxVyPl+zagMSW3nIz41JW4sxQgLCmiGmPW7mSp7Ey46TkDbmyhq4qHXg0tW250hQPEkOZ
 qEE5aGQ==
X-Google-Smtp-Source: AGHT+IGI1AtaVcNRQBGnzqi/KyKsquQR/2CnXZebJQ9La2AMwVNhSGw3bvnqyXrdRXCjaMuYABNEjw==
X-Received: by 2002:a05:6870:9216:b0:25d:b48:3652 with SMTP id
 586e51a60fabf-25d0b489846mr13772188fac.44.1719499336281; 
 Thu, 27 Jun 2024 07:42:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25d72be3446sm371675fac.29.2024.06.27.07.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:42:15 -0700 (PDT)
Date: Thu, 27 Jun 2024 08:42:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
Message-ID: <20240627144214.GC38804@bill-the-cat>
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-14-sjg@chromium.org>
 <20240624182931.GI38804@bill-the-cat>
 <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
 <20240625141427.GO38804@bill-the-cat>
 <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
 <20240626140752.GV38804@bill-the-cat>
 <CAFLszTj0h5w+sz796LokxgcfyRTGmHnQJ3OTDdoaoC61Ob=akw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZYfyxTWfTi4n1Cw1"
Content-Disposition: inline
In-Reply-To: <CAFLszTj0h5w+sz796LokxgcfyRTGmHnQJ3OTDdoaoC61Ob=akw@mail.gmail.com>
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


--ZYfyxTWfTi4n1Cw1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 09:37:15AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 26 Jun 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jun 26, 2024 at 09:00:41AM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wrote:
> > > > > >
> > > > > > > Some configuration is now in variables with a CFG_ prefix. Ad=
d these to
> > > > > > > the .cfg file so that we can see everything in one place. Sor=
t the
> > > > > > > options so they are easier to find and compare.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Add new patch to update u-boot.cfg with CFG_... options
> > > > > > >
> > > > > > >  scripts/Makefile.autoconf | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.aut=
oconf
> > > > > > > index b42f9b525fe..65ff11ea508 100644
> > > > > > > --- a/scripts/Makefile.autoconf
> > > > > > > +++ b/scripts/Makefile.autoconf
> > > > > > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf =3D GEN     $@
> > > > > > >  quiet_cmd_u_boot_cfg =3D CFG     $@
> > > > > > >        cmd_u_boot_cfg =3D \
> > > > > > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.=
h > $@.tmp && { \
> > > > > > > -             grep 'define CONFIG_' $@.tmp | \
> > > > > > > +             egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
> > > > > > >                       sed '/define CONFIG_IS_ENABLED(/d;/defi=
ne CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > > > > > >               rm $@.tmp;                                     =
         \
> > > > > > >       } || {                                                 =
         \
> > > > > >
> > > > > > I don't like this because whereas "CONFIG_" is enforced to be s=
et only
> > > > > > by Kconfig and so always all reliably set and found via a singl=
e header,
> > > > > > CFG_ stuff is not.
> > > > >
> > > > > OK, so how are CFG_ options found? I hit this when trying to find=
 the
> > > > > SDRAM size on rockchip 3399 and I could not find any way of figur=
ing
> > > > > it out.
> > > >
> > > > It's just another define, there's no uniformity to it. For some of =
the
> > > > SDRAM values really we need some build time way to grab some inform=
ation
> > > > out of the default device tree.
> > >
> > > Can you give an example of a board that could use this? I looked at
> > > the devicetree for chromebook_kevin and don't see a memory range in
> > > ther.
> >
> > OK, wow, I didn't realize /memory was optional now. But indeed, I don't
> > see it in the dtb file. That removes that option then, sadly.
>=20
> Well, we can still require it, so long as an error is produced if the
> property is needed but does not exist.

"We" who? I don't feel like we'll have a lot of traction with linux
kernel folks in requiring /memory to be added to the dts files on
however many platforms don't have it today because I'm going to guess
it's added at run time, possibly by us, with the correct size and we'd
be asking for statically adding things half-wrong like a lot of
platforms used to do (and in turn rely on U-Boot to correct the size).

--=20
Tom

--ZYfyxTWfTi4n1Cw1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ9ekYACgkQFHw5/5Y0
tyzFJgv9H8WEjDcEeMH9AyAMWtpmJ1F5oryclJjhMgG9TbF1I1JhFnmTqFCGmL/3
ud5OjA2BU+nvXzV0FgTnHBXIeFIrXokXsscqUWnimC+TnZYSI5TfNAVH4H7C41pV
iqOx6hsyaDRL0W68ERi9qfS7EgvWSr1JChhhM31mMfJ7ULN+3FxJIDCw2OS2C14J
yc3NMK3IYOl0hAy2Z5ju3vV2SjF4cXzE161amrKXb1bOK5h12QyH+UahFhUKZULB
1WDoXkhR+48DOYkMx0fdJh7SIwkmMcDFCAndwEPFfgE3lq50UCYElTOyycVWJIBQ
lm55Lv1NGCsJ4CJjglL6cmGnzu2qzpPQ5/+aaYJYx2l4OkZXD1CeDHXwkumoC9Db
1yiJ2h56uWgCW++aMTEoJRBESHljjfQQurD43q4UTBr9TxfVhcYERjMH0/ZFLkkt
gPii/2t6jPqv2B+PRPmvZNodq5df9fykulk0c+qTwNOLWQm2SP26jOLT+oZ473FP
r333Jjjp
=m6or
-----END PGP SIGNATURE-----

--ZYfyxTWfTi4n1Cw1--
