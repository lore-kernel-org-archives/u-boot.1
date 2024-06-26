Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB39C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 14:08:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507C3881C3;
	Wed, 26 Jun 2024 16:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bjU7lIxQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D788826B; Wed, 26 Jun 2024 16:07:58 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53022880AD
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 16:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5c1adbcaad3so286821eaf.1
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719410875; x=1720015675; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pPArSBLcxuCEe+iEZKybD2YBIFKjxEIz+RIC2cR6ARU=;
 b=bjU7lIxQcYR4tktm8gZXTBPSASWKDg69wZDvmLXrt0QxZVT9jSHpyAuuvrDm6nhnFG
 KSa4oacC4XjoIDcpr6bEkd4L3y6aBhdzd3lJchsIJD08Aolaw9+Rx7iMeqBQeq+9TmYN
 60kKA06SH9yYOiNkja5yFSbwgCgyQf/hy1jWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719410875; x=1720015675;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPArSBLcxuCEe+iEZKybD2YBIFKjxEIz+RIC2cR6ARU=;
 b=AV0QaocG0BEgyO1Lcg6+toXDaQ9b6XJXjc/6BlKQsl+Bc3WkjAFBxLVGhndxFMdBgn
 pt2vh2rYkWnDDdYmlikGvcVAX7AbvVLwNzeJ0SU2mIclfRs6qa8Tc2CJHedw2CIux2eH
 pr3Ca8iRu1wM82Dpf96Mv/YFA7QmnvWahVH6WY9QlH/nA5ybkBj/XA09iV2E9GxYZczd
 /LoYYRbWWGGIRpFNTNwz4OOJ+gU/hDDJMdVulByICE7MlzV9zdBKdPF+iJU7fHKu6M42
 LWDi/b1Npm7Dv8cAo3CQiJvk8++wW/1aMcsBPDE1EOrD9Gr+K6iBHYYyHe2kQtI5DMLg
 oV6w==
X-Gm-Message-State: AOJu0YyDAmDoRWNkadLpwM4ypXvoH4+TNRB+YTOmsdnot7tZIwpV3obf
 f0EmELPkQW5H6l2hl9zshZkvQR4r8+wRlzlk1chQWd2NmNKpUO8t91+wcRhKfuHu3v9K/6oIlwZ
 dwCIfUQ==
X-Google-Smtp-Source: AGHT+IFpaiRmADQrOmfEwPHCXOQLiHu/morEvq30nCXfv1Ph2me0tElBdr/hc+Zi4GYLiF0zqWT/fg==
X-Received: by 2002:a4a:b543:0:b0:5c2:279f:243f with SMTP id
 006d021491bc7-5c2279f25damr413516eaf.1.1719410874960; 
 Wed, 26 Jun 2024 07:07:54 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c22a10ea27sm60633eaf.10.2024.06.26.07.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 07:07:54 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:07:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
Message-ID: <20240626140752.GV38804@bill-the-cat>
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-14-sjg@chromium.org>
 <20240624182931.GI38804@bill-the-cat>
 <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
 <20240625141427.GO38804@bill-the-cat>
 <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pin3O9TVLiFYkYRK"
Content-Disposition: inline
In-Reply-To: <CAFLszTi1i+OrAyoyqRLZAuKzGTmAgNQ9Gwtn01XxVLvGmzZLcQ@mail.gmail.com>
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


--pin3O9TVLiFYkYRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 09:00:41AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 25 Jun 2024 at 15:14, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wrote:
> > > >
> > > > > Some configuration is now in variables with a CFG_ prefix. Add th=
ese to
> > > > > the .cfg file so that we can see everything in one place. Sort the
> > > > > options so they are easier to find and compare.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Add new patch to update u-boot.cfg with CFG_... options
> > > > >
> > > > >  scripts/Makefile.autoconf | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> > > > > index b42f9b525fe..65ff11ea508 100644
> > > > > --- a/scripts/Makefile.autoconf
> > > > > +++ b/scripts/Makefile.autoconf
> > > > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf =3D GEN     $@
> > > > >  quiet_cmd_u_boot_cfg =3D CFG     $@
> > > > >        cmd_u_boot_cfg =3D \
> > > > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > =
$@.tmp && { \
> > > > > -             grep 'define CONFIG_' $@.tmp | \
> > > > > +             egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
> > > > >                       sed '/define CONFIG_IS_ENABLED(/d;/define C=
ONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > > > >               rm $@.tmp;                                         =
     \
> > > > >       } || {                                                     =
     \
> > > >
> > > > I don't like this because whereas "CONFIG_" is enforced to be set o=
nly
> > > > by Kconfig and so always all reliably set and found via a single he=
ader,
> > > > CFG_ stuff is not.
> > >
> > > OK, so how are CFG_ options found? I hit this when trying to find the
> > > SDRAM size on rockchip 3399 and I could not find any way of figuring
> > > it out.
> >
> > It's just another define, there's no uniformity to it. For some of the
> > SDRAM values really we need some build time way to grab some information
> > out of the default device tree.
>=20
> Can you give an example of a board that could use this? I looked at
> the devicetree for chromebook_kevin and don't see a memory range in
> ther.

OK, wow, I didn't realize /memory was optional now. But indeed, I don't
see it in the dtb file. That removes that option then, sadly.

--=20
Tom

--pin3O9TVLiFYkYRK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ8ILgACgkQFHw5/5Y0
tywHcAwAoSROinjDCXJihz+ZYE5zAMh8CfBN9agvNXKuma9ultLtFBRZ/+wMT3yz
22D7hL3Pq5Fab3xv3NFxw6inP/A9/yXepvrJ07Ste6Qhu3yYuZI25RR22FiNHd2s
tUuu7NGumYh54HbN8jOGEfhXX0sue5XdvkWtaBb+RUHapl5QOrBy/WBiWYY7Zwxn
m4LtQeqQdalh/dekMnJl4Ab0ujDWWNNV7c0z+hvXWxsOkHmku0sx7/+LnFcATeYI
S2y2djD9/O4G0aDFFsaoNkgqD7+JZZcDIuLf5xffFFUb+KKcgVNcAES89JSSpOEu
/hTpCjr56Ge8ZgCfG2eS+lQ7iNwMgRlEuay2nVB/CtT8oNuGowdCLMyDAZ27hIrT
oDpEjX07hZTMrhLKTxOMXVmCVsMZ7jwV4LuzOmMPgzxr+ZRWm+/jKf1YHBdzoNzx
T2jd38zywK3QueHIV0S3zHz4MZ+a7aFVHna7GStNMELcfYsnS645P2eeqO3cFFzn
QxILJOyE
=bt5+
-----END PGP SIGNATURE-----

--pin3O9TVLiFYkYRK--
