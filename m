Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50336C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 18:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E8F88252;
	Wed, 29 May 2024 20:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kj77mksW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAECC88271; Wed, 29 May 2024 20:43:03 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85480881E5
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 20:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3c9cc681ee0so1143060b6e.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717008180; x=1717612980; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cjeqSJlqIlFhBnPuPVuz5j/aEwfKp5YFNIPW3qDtX0o=;
 b=kj77mksWqufW28h8mI+zfT1y9ZeKDikjO9Vx5vhIToepPShfFBHS+qPdKFnwB1/tJy
 g29h6vbs43Bk5AymbxuUi10KhBgum6sinJEcoYgD6W76D3+h/nTbsQWcqOGkLc0MTTu0
 9h8DGEEBx/z/2kZyTuCk+m4EERfsvbb5Yghus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717008180; x=1717612980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjeqSJlqIlFhBnPuPVuz5j/aEwfKp5YFNIPW3qDtX0o=;
 b=oFSdTdANoW36DYi7/z7ZKNY28tfRP39Eb8KnBtCfFO3yJCBU0QfFAqR65qVf4hC8I2
 HnD5452CbQCBSxxcdHJzSbZWmc4EOF9+2no+DBbt5AJyXhpVCAgnHvObu6nGDQEMbN+/
 rqiF1op/66dvfF7Ay1V3OD1X2Gr/9YLgSLXJcdWZ7UgY/yK4Umwmv2LNhPnOi2zRb+Gp
 dSBXqs8gYH9s++q7hcA3I093hLt69LxzIICKGnNtMRxnC5qEh3nvpfQzEvWwvpAvpMNc
 9daRmdLeCAYo+NUzUtHsiS1GLqrX5ZlRJocWNeCPZdrfAmGXeUkBG45TrouM4xm3GXAp
 6CSA==
X-Gm-Message-State: AOJu0YxI1mymy8VPd0GpX3oyNrZ0X7ZDUcDI+kE4XQpQzDK2NKNiQXY2
 D6/M6Eim+H8isMAaqNGmlRZRVUQSvdcv2oeeV0TxtrSfhfpejytJnNsDuVmTutk=
X-Google-Smtp-Source: AGHT+IHVmBpd0h43i8PUxozQjdZqQXWc4OKfuv7j4WTggbPUteR9qTEdIMLAJl5IXVdNnL8gYDXLbQ==
X-Received: by 2002:a05:6808:1983:b0:3d1:d348:d1d2 with SMTP id
 5614622812f47-3d1d348d41dmr5198653b6e.36.1717008180092; 
 Wed, 29 May 2024 11:43:00 -0700 (PDT)
Received: from bill-the-cat ([189.177.150.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ad63c01176sm49652246d6.116.2024.05.29.11.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 11:42:59 -0700 (PDT)
Date: Wed, 29 May 2024 12:42:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Stefan Bosch <stefan_b@posteo.net>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
Message-ID: <20240529184255.GC3714513@bill-the-cat>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <20240529165814.GQ2568172@bill-the-cat>
 <CAEfUkU+zKyaqc5tFy0rN3ofm3pRuckZX6PbD00VNtWQc5COZyA@mail.gmail.com>
 <20240529180129.GB3714513@bill-the-cat>
 <CAEfUkUJj5Y+uVmRXx+=DP-6O7dpNcMjSA1jADKaJo07RSsBjHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MFqWoyij8GDqnDmZ"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJj5Y+uVmRXx+=DP-6O7dpNcMjSA1jADKaJo07RSsBjHw@mail.gmail.com>
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


--MFqWoyij8GDqnDmZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 02:38:10PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 29 May 2024 at 14:01, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, May 29, 2024 at 01:42:16PM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Wed, 29 May 2024 at 12:58, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > > On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:
> > > >
> > > > > Port mbedtls with dummy libc header files.
> > > > > Add mbedtls default config header file.
> > > > > Optimize mbedtls default config by disabling unused features to
> > > > > reduce the target size.
> > > > > Add mbedtls kbuild makefile.
> > > > > Add Kconfig and mbedtls config submenu.
> > > > [snip]
> > > > > diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
> > > > > new file mode 100644
> > > > > index 00000000000..d6e77d56871
> > > > > --- /dev/null
> > > > > +++ b/lib/mbedtls/Kconfig
> > > > > @@ -0,0 +1,25 @@
> > > > > +menuconfig MBEDTLS_LIB
> > > > > +     bool "Use mbedtls libraries"
> > > > > +     select MBEDTLS_LIB_CRYPTO
> > > > > +     select MBEDTLS_LIB_X509
> > > > > +     help
> > > > > +       Enable mbedtls libraries
> > > > > +
> > > > > +if MBEDTLS_LIB
> > > > > +
> > > > > +config MBEDTLS_LIB_CRYPTO
> > > > > +     bool "Crypto library"
> > > > > +     help
> > > > > +       Enable mbedtls crypto library
> > > > > +
> > > > > +config MBEDTLS_LIB_X509
> > > > > +     bool "X509 library"
> > > > > +     help
> > > > > +       Enable mbedtls X509 library
> > > > > +
> > > > > +config MBEDTLS_LIB_TLS
> > > > > +     bool "TLS library"
> > > > > +     help
> > > > > +       Enable mbedtls TLS library
> > > > > +
> > > > > +endif # MBEDTLS_LIB
> > > >
> > > > We need much more granularity here, and to re-think some existing
> > > > symbols too perhaps. What we should be able to do is pick mbedTLS or
> > > > "legacy SW implementation" or "HW implementation" for the various
> > > > algorithms, and that in turn can have some higher level grouping to=
 it.
> > > > This should then negate a bunch of the Makefile work you're doing a=
s we
> > > > won't have CONFIG_SHA256 enabled as we'll have
> > CONFIG_MBEDTLS_LIB_SHA256
> > > > or whatever enabled.
> > > >
> > >
> > > I think we should use CONFIG_MBEDTLS_LIB_[CRYPTO,X509,TLS] for high-l=
evel
> > > grouping.
> > > Underneath, the CONFIG_SHA[1,256,512] switches (and other crypto opti=
ons)
> > > can be
> > > used as sub build options in both MbedTLS and "legacy libs".
> > >
> > > Take hash as an example, if the users prefer to use MbedTLS other than
> > > "legacy libs" for
> > > hash operation, CONFIG_MBEDTLS_LIB_CRYPTO should be defined as the ma=
in
> > > switch
> > > (the users can still prefer to use "legacy libs" for X509 by
> > > keeping  CONFIG_MBEDTLS_LIB_X509
> > > disabled).
> > > Then enable the algorithms they need (e.g. CONFIG_SHA256) - the algor=
ithm
> > > options works
> > > for both MbedTLS and "legacy libs".
> > >
> > > HW implementations with MbedTLS (aka, Alternative algorithms in MbedT=
LS)
> > is
> > > another
> > > topic which is not covered in this patch set (It needs to migrate each
> > > vendor's solution under
> > > MbedTLS alternative algorithm).
> > > Current patch set is focused on SW implementation with MbedTLS.
> >
> > The "easy" problem with what's in v3 is that X509 and CRYPTO are
> > select'd under the main heading.
>=20
> Not sure if I get what you mentioned, currently all MbedTLS options are
> under
> Library routines > Security support
> Do you think we should keep them in other places?
>=20
>=20
> > The harder problem is that we
> > intentionally have granularity for SHA256, SHA512, etc, etc and all of
> > that goes away with the current Kconfig option if you select mbedTLS. We
> > need to bring that back. And we shouldn't need to have all of the ifneq
> > statements in Makefiles because both CONFIG_SHA256 and
> > CONFIG_MBEDLTS_LIB_CRYPTO_SHA256 will not be true (Or possibly,
> > CONFIG_SHA256 gates things U-Boot's internal API for sha256'ing
> > something and CONFIG_LEGACY_SHA256 controls building lib/sha256.c).
> >
> > I think we should not introduce new ones like CONFIG_LEGACY_,
> CONFIG_SHA[1,256,512] should be used no matter whether MbedTLS is
> enabled or not.
> I understand your concern, I will bring CONFIG_SHA[1,256,512] back when
> MbedTLS is enabled. Those options should control the options in the MbedT=
LS
> default config file.

My concern is that we do not have the correct level of granularity, and
that can partly be seen by the number of ifneq(...) statements being
added around already conditional logic. We should have almost none of
those, in the end, is what I'm saying. We have a mechanism for
configuring the build, Kconfig, and that should drive the decisions as
much as possible.

--=20
Tom

--MFqWoyij8GDqnDmZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZXdysACgkQFHw5/5Y0
tyx+twv/R2Xtyl+DSCdgPSLDvzvPTfZs4rX1KwCMGPiNyX9Yh6AMqaNEsH9DuXBF
KSpIRxVcBboAmf4jbbYPB3izT2GCMHTQsQak2Ak1zmN58a+m/AbXsKVlS/+Lfcm+
VxIcCyZM8/Yes+hpZqqPqfT4DwwwYXa3xDQ2NH5w0UzvuUt11jIat+0WgBPXfBWh
9lX29a89e5DzdYhqY1CAS+5Lv2Z/Twx/zWz1bKD66anjBhYSDk9Cz1KkkpxuPj8z
k6LffyEIQyVZk4HqHV0i/1Tp1rsZ8DCnLlsWsUaly3VUhXe4cTHoR3ZzndODSwVF
uCT9Id3/VfmfkUK9fmwGoDajAy1YYRKOocXhfv11i8i3KnyzxiwElD8hKOYw9cRd
HHSjdYOkFWjxvwl6eg9JISTqPGRoRrLuOIZNqYqqZu5A8BGgMoaSXm9UDt8n3E5n
7JItyFMBXhp57dl6BqTl1D7RfFTAOvqBvBlkfNG+328TzA4YPvcJvEWdvWsAQ1YT
PSZuKKlc
=XB4i
-----END PGP SIGNATURE-----

--MFqWoyij8GDqnDmZ--
