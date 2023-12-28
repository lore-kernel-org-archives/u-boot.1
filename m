Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E145EC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 14:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C948774E;
	Thu, 28 Dec 2023 15:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ri9ZUucU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5126187A45; Thu, 28 Dec 2023 15:10:36 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13FCA878FA
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 15:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7b7fdde8b98so279571239f.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 06:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703772631; x=1704377431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=njh+aNp27+6eT5lNaMpgrVp0TK1l2Qz7DEouTHmZZNc=;
 b=Ri9ZUucUoMEQnnpmjlNwa/JxsO9xke35tujtD89jr3JEz18iGXXJUmn80ecrneK1mB
 iLNw2UVXGUNKnP6TDDpX0j2NRPU66T3yjIOu3iFqMOpOXn8ATeZ7EGZJCQ2x7pApgekp
 gX9iXTrkyAnoWYsfHYH6WxUzQCDk6/ero+lSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703772631; x=1704377431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=njh+aNp27+6eT5lNaMpgrVp0TK1l2Qz7DEouTHmZZNc=;
 b=v0PYu4OLAK+lJbbfHhh/zXbgk9cVi09ZsNnkfJjYfOBdoiburX0qYrMOeWlepyd2+r
 YcEacrQEgh4QwfLFY8EHWlhfClgZzeMrrBtT6XKvSX4ZQtpXiM2rh5rUwcgU6faGHDRQ
 FQ3Q+gWUpTFJMQOD7i/vUldMmIeBWJPtqjo/n++dmlORlG9EQ8RSKfH1O7407kyDs+6N
 SMm9L9lDDjEtyO3hMAEkpfxJIhBU1atwmYTfTPI0kVmN2grhh0ewunToN+R9fYbXfUGZ
 Wwvwj/VMru2qcYaknQ1j1DvIa7alU7bkwnhhSsHrwlA3haouNTn4FBjxCA3hRjkJbAuH
 svAw==
X-Gm-Message-State: AOJu0YyV25OCVyaeP6XpMDlKOPr/HfOdiaRwCHyKloDUdDXIOob+wszM
 RlTugXgM5dWMcNI8f6mp1X/H5NJSK+fa0g==
X-Google-Smtp-Source: AGHT+IHul2zGf/joRFQUaDfZ1+mB82NQf8CRPY2VtuzgZ9n1EjOdempm/7XS5UAUtbJRRtQ1ze7lNg==
X-Received: by 2002:a05:6e02:1445:b0:35f:f59d:f132 with SMTP id
 p5-20020a056e02144500b0035ff59df132mr8854393ilo.34.1703772631562; 
 Thu, 28 Dec 2023 06:10:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 x125-20020a818783000000b005e868b1b395sm7436888ywf.100.2023.12.28.06.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 06:10:30 -0800 (PST)
Date: Thu, 28 Dec 2023 09:10:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de, mibodhi@gmail.com
Subject: Re: [PATCH v3 5/8] doc: devicetree: Updates for devicetree-rebasing
 subtree
Message-ID: <20231228141028.GC2652760@bill-the-cat>
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-6-sumit.garg@linaro.org>
 <CAFLszTjW8FBYtcb-kiZ-8rUdgMd96KgZWufh1ig+mQ6wq-sGgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cSZgqe/eSdka4DzY"
Content-Disposition: inline
In-Reply-To: <CAFLszTjW8FBYtcb-kiZ-8rUdgMd96KgZWufh1ig+mQ6wq-sGgg@mail.gmail.com>
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


--cSZgqe/eSdka4DzY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:37:09PM +0000, Simon Glass wrote:
> Hi Sumit,
>=20
> On Thu, Dec 28, 2023 at 11:59=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
[snip]
> > @@ -68,8 +68,21 @@ a binary file. U-Boot adds its own `fdtgrep` for cre=
ating subsets of the file.
> >  Where do I get a devicetree file for my board?
> >  ----------------------------------------------
> >
> > -You may find that the Linux kernel has a suitable file. Look in the
> > -kernel source in arch/<arch>/boot/dts.
> > +Linux kernel Git repository has been the place where devicetree files =
along
> > +with devicetree bindings are stored and maintained. There is devicetee=
-rebasing
> > +(dtrepo_) which maintains a forked copy of devicetree files along with=
 bindings
> > +at every Linux kernel major release or intermideate release candidates.
> > +
> > +In order to maintain devicetree files sync, U-Boot maintains a Git sub=
tree for
> > +devicetee-rebasing repo as `devicetee-rebasing/` sub-directory. It is =
regularly
> > +kept updated with every new kernel major release via subtree pull as f=
ollows::
> > +
> > +    git subtree pull --prefix devicetree-rebasing \
> > +        git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devic=
etree-rebasing.git \
> > +        <release-tag> --squash
> > +
>=20
> This is an internal detail and I believe it will confuse people. Can
> you put this in a section like 'Resyncing with devicetree-rebasing'
> and explain when this might be needed?...almost enver, right?
=20
I think this means the wording and sections need to be clearer, in the
document. It's unlikely most users would need this (but I can see
downstream cases), but I need to do this at least once a U-Boot release
cycle, and I want to make sure it's documented on how to do it.

--=20
Tom

--cSZgqe/eSdka4DzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNgdQACgkQFHw5/5Y0
tyypzAv/WiiZe8q4rknbg593JPwyIO8Gwf1lbP6VJ0G+WuJYXTRskajVOzcRRHRs
m5613Vd6FpzCpMdWUuUUGYnWNWniS+y6+RevdJCg9NeB1lrrrytu78c+CUfc4TyW
gO3lrq05b2ZddNY4HmQUjt/HKTAzbmAexxcyI8fxaFlLrfijLJ9aqlqLYrJgRBEp
+XpEvCRwxZXtPJx3mjmz9mzzh+izVJ5cjMHMRhVwFOlnFdImucfDpCW3kzISkqWb
2LcG23lGJzxSvRd7I0vl7TIu2tyeZEdPJW6vuEmuY66+0gb/IwpWESN8KAva1H+3
BYglO3zLy8V7wh9MQcKU94IAPFT2Pv3R8Tu9xcpnx+Tgm0X2HLN+vS9W41oDaypg
yECUp5z7O2JXZIxGkXxubZ/oI122c2JF2m6ChSOhFzVDhYk4NYZ95hb3kS4aNxSh
BjaYu3vrBoUN5TIUgl2cxv0NLne8e/qAupITmXdVT/gg1ES2ICOJ5lsXYNM7CCxJ
p3BPDQ7W
=l3Pi
-----END PGP SIGNATURE-----

--cSZgqe/eSdka4DzY--
