Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E8EC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 14:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79EE6809A5;
	Thu,  1 May 2025 16:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I5DJHszZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841AE809D4; Thu,  1 May 2025 16:59:25 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA4A8081A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 16:59:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-60634f82d1aso284722eaf.3
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746111562; x=1746716362; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HnN4hRYroK4NR35QiWa6Zr3S3Vo9ZwanspMifp7H0wE=;
 b=I5DJHszZhD5GRwhVBO04a11L0Fq0eExpg1RsX28T1qV5ZIUJNpXGU4IkLQJfFkajlg
 uLni9VTS9DBL2fhZZBLB44Hwn4IVU2wIpHkQmEHCpvGl53WauUnvcHjIO/1yWu563qug
 TVAiE/suq58k7h2ITeIuDanjGpSEy4kHtqSo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746111562; x=1746716362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnN4hRYroK4NR35QiWa6Zr3S3Vo9ZwanspMifp7H0wE=;
 b=VbE3rgpgPOwMIOmahJU0j7G5f5+yzt94BKgVwmU/OYHnyj+3PNwx4unjVZSBLntZbI
 y1gcxzBNJ9bVfTwFSWDOCupIqGHnofeI5y47nfGRqW7MkbuW9upi2GpcGX7CGff9lOPj
 1DbxhRsZfMJw1WhTMG6AU6eHnAWmm8MI7I9KHCXsEkdSI+GbG085PtFsFnMxDuc9fv+U
 cuIJjDOWX9mDD6nzFHgZU08oL0ScIjdvZ/jtnJ3xZQjOFZM2bzp7v4hz8VLTUnKSY+Dv
 zvNTXGUTG4N8EMjdMrhj3ZCn6kNai66pASjbQ6qdrstsd2ENHV2lDFe0cI6Kln5KEKmD
 WaiA==
X-Gm-Message-State: AOJu0YxHlFnL20c4rmhk1X4IQ8Gz/zFx5v10qaAPtoBtyVOLxEBM9bre
 h+EKpA81whMXR0DmYcFKW5x9TSDTNqw9tNWOH4RKQRvo/eo5QuBj1GFPo8tJD8E=
X-Gm-Gg: ASbGncv+M+dcC9Jx1+gg4Ls/rHzf5oqAXsbNTK1/2dUA0VtZwHN7fBzDMEsIKQIoss8
 1kCCBrtwxjTozVPztAMvPD34PU7PIOppfBqOq9wPqNOFKUjjKh5z9A+PL+B1JmFkBU3TFkDGoBN
 qoGjA7ho8nVLXyyE9PR92AnTmArINuxlWUD7Yzm2DRE+wIOidDVtDdjO4sm7u49QO6mPEoz+BrO
 rsmXahb8qEtSc1/3pC+79mVy2YVhH79qk1+Tmx5E2NDeEIMv2/J7HK0SrSa8RtmDPssNvAfMWua
 U1FNbzx4lsh4lMzgWcJ/P2WqpyFDeIrUCuST15/FaB2tIs8Wq+O1qvJ/QBgMAn/PcGIsgGofdtG
 j5w==
X-Google-Smtp-Source: AGHT+IE6o07plPD9hoWYVxYoa0CTGNphd3Xwx/ke5fwTbGaJkG8dxuK27NvL/k2qkQQGwcTlYGp7uw==
X-Received: by 2002:a05:6870:95a3:b0:2c2:b9cc:afb8 with SMTP id
 586e51a60fabf-2da69d38dd6mr3408270fac.7.1746111561668; 
 Thu, 01 May 2025 07:59:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0a438e8sm160982fac.0.2025.05.01.07.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 07:59:21 -0700 (PDT)
Date: Thu, 1 May 2025 08:59:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 0/3] booti: Remove the SYS_BOOTM_LEN limit for booti
Message-ID: <20250501145918.GF1261075@bill-the-cat>
References: <20250418125111.2193434-1-sjg@chromium.org>
 <20250418133315.GJ5495@bill-the-cat>
 <CAFLszTg45QDjKT=5JH=Cpoy6Efv8KSPQbQ6KnA8QE6nM_bk+xw@mail.gmail.com>
 <20250418140844.GP5495@bill-the-cat>
 <CAFLszTgBpMt+XsrDHQz18nF7nOAZevHLQC1Jwv=-1a9yFzoq2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eazVKrbF3xricCmp"
Content-Disposition: inline
In-Reply-To: <CAFLszTgBpMt+XsrDHQz18nF7nOAZevHLQC1Jwv=-1a9yFzoq2Q@mail.gmail.com>
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


--eazVKrbF3xricCmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 01, 2025 at 07:06:03AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 18 Apr 2025 at 08:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Apr 18, 2025 at 07:46:59AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 18 Apr 2025 at 07:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Apr 18, 2025 at 06:50:59AM -0600, Simon Glass wrote:
> > > >
> > > > > This series restores the original behaviour of extlinux booting l=
inux
> > > > > 'Image' files, which is to ignore CONFIG_SYS_BOOTM_LEN and instea=
d uses
> > > > > a limit of 10x the compressed size.
> > > > >
> > > > > It also adds RISC-V support, since it uses a similar format to AR=
M64.
> > > > >
> > > > > Future work should integrate the code in 'booti' into main 'bootm'
> > > > > logic.
> > > > >
> > > > >
> > > > > Simon Glass (3):
> > > > >   boot: Add a function to check if a linux Image is supported
> > > > >   bootm: Add RISC-V support in booti_is_supported()
> > > > >   booti: Allow ignoring SYS_BOOTM_LEN with the booti command
> > > > >
> > > > >  boot/bootm.c    | 31 +++++++++++++++++++++++++------
> > > > >  cmd/booti.c     |  1 +
> > > > >  include/bootm.h |  3 +++
> > > > >  3 files changed, 29 insertions(+), 6 deletions(-)
> > > >
> > > > This is like pulling teeth. We aren't ignoring SYS_BOOTM_LEN so muc=
h as
> > > > it was never relevant here to start with. The documentation
> > > > (doc/usage/cmd/booti.rst) has explained that we use 10 x
> > > > kernel_comp_size for the limit. The "bootm" namespace has largely b=
een
> > > > about uImage (and then FIT images when not using it's own namespace)
> > > > images and not applied elsewhere, which is why bootz/booti handled
> > > > things outside that namespace. And then, still, this series doesn't
> > > > unify cmd/booti.c with your changes, it just introduces duplicated
> > > > functionality, which is generally understood to be a bad thing.
> > > >
> > > > So again, please do similar to what you did for cmd/bootz.c and that
> > > > report and move the existing functionality over. We can then look at
> > > > cleaning it up (which should look like / abstract what we do for
> > > > compressed FIT images) as a follow up, in order to make bisecting a=
ny
> > > > regressions here easier down the line. Thanks.
> > >
> > > Well, I still don't understand what you are getting at here.
> > >
> > > The existing functionality for booti is already there. Marek added it
> > > a few years back. Can you please be more specific as to what
> > > functionality you think is missing?
> >
> > With:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250409155723.431102-=
1-sjg@chromium.org/
> > You moved the functionality from cmd/bootz.c and over to boot/bootm.c
> >
> > You need to do the same thing here.
>=20
> That code is already there. Here is the code you are talking about, in
> cmd/booti.c (which is a hack, BTW)

Hey, thanks for insulting my code, BTW. Best way to make sure I really want
to take your way of refactoring the code, rather than the way I asked
you to.

I'll look at this again tomorrow.

--=20
Tom

--eazVKrbF3xricCmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgTjD4ACgkQFHw5/5Y0
tyyY/wv/dQqwJWGKFgbMDs9RpwB1y6vzBtdXzYkQn9BANQwx53nyDwbUQNJ0Ex4j
IQUMaKRNMABL0Q17k62kMztDdSaex1zeSsA0JmR6W9DUqqfzrx4fVMwbk310/mbw
7piVciK75U98yQcdPkE02VmM7SVshKn67DZhfn+jq9ETFWDU2ChWV42ngYTjybq0
0aPKthV9x82sNR44genM5Ik/c2Q+XEJkAMZ2CXkUlcd4Y0AVLWySpbQcb/ueBthX
WUQqKemLQLi0OQfSErur2+ulRwcERsXrSZqCQnjxHfAsKufsxRKiace3Y8/gGvdz
OW/+IpAwtROOESW2aGwHDf0nBBdZlnoikOzrp0Dx2jabByCqoHPwpVjJH/2Ls7KO
Sj85IVhYDATp78roB/0zEm7HehShpRGssyNyJJEde6FruRuvrvXuuC1ZjiU2tm9d
T4JQcpddwfAXdPxxeTmX00hnAqE55C1JOvTrS/ldjmt+Qbi9+O+1FM1WGoo+cuK3
Ac/AJbL2
=H9Er
-----END PGP SIGNATURE-----

--eazVKrbF3xricCmp--
