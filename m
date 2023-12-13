Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B88C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F053787827;
	Wed, 13 Dec 2023 21:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h1ksS8e7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A475187827; Wed, 13 Dec 2023 21:42:58 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3606387855
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5cece20f006so74159877b3.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702500174; x=1703104974; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rLn9aXwK0PQALIrQ38672U0o8mgv6ygGXLfqOfj/b5o=;
 b=h1ksS8e75YFeQZIefz5kHsuXNtaZcaacc3U0YL5NmTCVs35IZf0bgxo3FtJfG0PeEy
 g2eOE5dXT9Ydc3SRSMUZkBcCsqKqN/Yo0Z8scw3cWw92ccVzeSNieTjY4BmnwMQXuSmD
 ltnxsVYnP0tiNrEI0FjyqPBTBUmxbVLrPWbbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702500174; x=1703104974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rLn9aXwK0PQALIrQ38672U0o8mgv6ygGXLfqOfj/b5o=;
 b=NgAmZQpN8aOGpOqEJw2TNrGlGyQtwFF6wcNkc7eFMgrrAY/+QUO1chYpPLuNE24qoj
 3ZsQAub/Os/AzZ625WRMqvsog09gOz2iqBUhW0kc4iltd7GNPLB+RhI3kGbsuXh1h0Oe
 LKyAMytX+gaUZSWo+2z/wq7PqShqH3vu0kRaA/KLxGR/neeZWtIYop7pI5KkIde1FuaS
 JTCA2XbroZO9YJWTawO55Xujk8RbKIPKT7nqNYrbc8HQrv91REpBGz/oNyR6BWbgyvhQ
 gz26Zp6yrXY9uxgqGDweWcGSOmipoKY35Bt4CkO2Mth5uij3y4Ktfxy7RQX0jV79GMUf
 UqkA==
X-Gm-Message-State: AOJu0YyTBpW1M/9G/5GaZLHVIANRRNpG9IMWv59s3hP8KsYsVL9tSW0O
 uFrQWhFBIH0HlJf1HhKC2n9sqhSnmH2Viq806V4=
X-Google-Smtp-Source: AGHT+IE7MGORCpF/GiyBVZtdvNl2X8X07sFC8nmGUpyauw+V0U9hdveJkcqZSaIhfSZA0YmVpo9SGA==
X-Received: by 2002:a0d:cc02:0:b0:5e2:cacb:d0b6 with SMTP id
 o2-20020a0dcc02000000b005e2cacbd0b6mr1195681ywd.21.1702500173822; 
 Wed, 13 Dec 2023 12:42:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d78a-ada8-3cce-fa3d.res6.spectrum.com.
 [2603:6081:7b00:6400:d78a:ada8:3cce:fa3d])
 by smtp.gmail.com with ESMTPSA id
 o126-20020a0de584000000b005e20fb37fd4sm1471056ywe.3.2023.12.13.12.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 12:42:53 -0800 (PST)
Date: Wed, 13 Dec 2023 15:42:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
Message-ID: <20231213204250.GJ2513409@bill-the-cat>
References: <20231202153400.537050-1-sjg@chromium.org>
 <20231202153400.537050-2-sjg@chromium.org>
 <20231209154839.GG2513409@bill-the-cat>
 <CAPnjgZ0TxjEf-CvN_jC-c_7yVMb473YAjy-GH=Zrj6wwb4fqFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yOFPDHyGpE/RLd9D"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0TxjEf-CvN_jC-c_7yVMb473YAjy-GH=Zrj6wwb4fqFA@mail.gmail.com>
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


--yOFPDHyGpE/RLd9D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 12:50:02PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 9 Dec 2023 at 08:48, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Dec 02, 2023 at 08:33:48AM -0700, Simon Glass wrote:
> >
> > > The cyclic subsystem is currently enabled either in all build phases
> > > or none. For tools this should not be enabled, but since lib/shc256.c
> > > and other files include watchdog.h in the host build, we must make
> > > sure that it is not enabled there.
> >
> > This part is what I see as the Wrong Direction. There's some code we
> > really need to share with our user space tools, in order to not
> > copy/paste the same code. In turn, this code must be as user-space
> > friendly as possible. Maybe even we re-factor things a little more, if
> > needed, so that we _just_ have the library functions in common files,
> > and u-boot or user space only files have the make use of logic. I don't
> > feel bad about tools/ needing:
> > void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
> >                 unsigned char *output, unsigned int chunk_sz)
> > {
> >         sha256_context ctx;
> >         sha256_starts(&ctx);
> >         sha256_update(&ctx, input, ilen);
> >         sha256_finish(&ctx, output);
> > }
> >
> > (and so on for other algos) as a duplicate bit of code. Much less so
> > than I do about adding <linux/kconfig.h> to a direct include list (since
> > we should never be doing that) so that later on we can if
> > (IS_ENABLED(..)) the existing code.
>=20
> Bear in mind that we have the CONFIG_TOOLS_... options entirely to
> deal with the need for tools to enable features in common code. This
> SHA thing is a very small part of the code, compared to common code in
> boot/ for example.
>=20
> So is this really a win?

I don't follow you here, sorry. We share lib/sha*.c with host tools for
generic mkimage functionality. I'm fine with continuing to use
USE_HOSTCC as the guard for U-Boot / userspace here. And I don't think
switching these files from:
#if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
to:
	if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
improves readability of the code.

--=20
Tom

--yOFPDHyGpE/RLd9D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6F0MACgkQFHw5/5Y0
tyxjUgwAtuqJdH5uJ1fnCBDmarI8+6I/wcr/X7+dNDmaWHAvPSHE/kZKvSA5+4LQ
jexJt3peLZwDWgpnVpOjXeECsvSt/UHLkgPvloAKh04XUtr/ZZVbCwC7LlGd4nDD
51P83lkVLf188gx9gpgJkdFBZUJdcffbtsbbrqSXP1jSBjKllT0Ap3kp/JxHiB8B
S6A6xGHKC6l4Ttj/BtwDzH3Pl2N06VZkPXVDO/zOFVyy4qC7jeuKz/hR52gR1wfc
lRlupBh7EQIIhGyYIyyJUVemOJEYn2yJz2Gucx8PmLFHfo4A673u9sNmxdL4dR7Z
8Zi64qeD3ih+5LuErZU+CMltm3dzIPLBdtIm5fOP3l3fjA09Dj4yyS0Gv5hwhAaZ
5TfEmEmqToLfKpDMBKXzkwWbePsMnkIb2pgr8k0gAhMsuzw/oJbLerfyjsqwJcsu
+X7d8afu2iSw/VVPL5hnTiXXQ5GlRLTbyIWCW7SB1dvBHR1Q/rF/kC4Q/TxRTy04
LT2KtOU0
=uGNc
-----END PGP SIGNATURE-----

--yOFPDHyGpE/RLd9D--
