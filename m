Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDCEC3064D
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 14:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B70B28845A;
	Sun, 30 Jun 2024 16:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tlXmVLA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE398842C; Sun, 30 Jun 2024 16:57:57 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E60738845A
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 16:57:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-700cbdd90fbso1422508a34.0
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719759473; x=1720364273; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4QvRDFzDEIB1oBNZ6/DpUoALnSFaBcTLF1JyYaGHp0U=;
 b=tlXmVLA+rIRThhPx/PQu2w+P8TvJ66QWcdpEHPQtEXKXubEtMjp9zu16TL7Sijh8Ro
 U5b5XUQGxNUpWa9I3Qs+kKr9TdsQEJnI8fGcAY7661Ijjm+K/FdSIqTg0PjWWyxy216G
 IiEewk2JnMt+1DLAixVwe9JGeilpGd9oTPGfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719759473; x=1720364273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QvRDFzDEIB1oBNZ6/DpUoALnSFaBcTLF1JyYaGHp0U=;
 b=jlZQ2HLRKgu8yox9xDIXTq0CIiY9WtjXaJSFayaf7kMsM9pGtnTkwUuc6D+monoAIw
 nINQIGqwMCDBWkSqlUrsPP0ZhOaBrasfXSvMFUB6onmVuufOnTqRub1Q0w0mt2kil6kZ
 pMsXWE/aWop2axWK6N3S71eUMPpFmUJumoQOtpfyy23yZZ+wCu3K0B9CS72Oc4AciNO+
 o1uauZYchKAFVnwneVz84CN/zb+KfNNskvBxRKMQtzVCi/XVUJfu3Df5XmHuH3nWSi/a
 FhB2S2D8AGbdhm4OEaJOl4yu5aUMB+mKzmBD1FYE42CjGu6fqbhpKInz43GZCnXPjD8B
 QD5w==
X-Gm-Message-State: AOJu0YwMrbDXoDFKEUuXo4kHgXsWAySgbmalLv4Vx6VSo5FarkPziSYe
 iYSo9AG35ofguOqcjAKZH2PCoLVbCFriu3PWs/p4C/GimysgDGOWVtJJzyYHQU8=
X-Google-Smtp-Source: AGHT+IFGbxb/uSl33MVnrAXchE5MXqHlFy5q0rbeSN0jMOaEHsWgjqXcuxUxdA6jQSbaLLFqevrOGg==
X-Received: by 2002:a05:6830:1484:b0:701:fd08:905 with SMTP id
 46e09a7af769-702075e239cmr4043597a34.13.1719759473558; 
 Sun, 30 Jun 2024 07:57:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ab1690sm968436a34.18.2024.06.30.07.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 07:57:52 -0700 (PDT)
Date: Sun, 30 Jun 2024 08:57:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Paul Menzel <paulepanter@mailbox.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>
Subject: Re: [PATCH 1/3] pxe: Add debugging for booting
Message-ID: <20240630145750.GI38804@bill-the-cat>
References: <20240619123453.720600-1-sjg@chromium.org>
 <171945114145.3478677.13570700547612365560.b4-ty@konsulko.com>
 <CAFLszTiaqv7CXZg639JybryyaUerjJX=vn+gdh2nCeEPB2PH6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P9/2k9qjP3YFtOk/"
Content-Disposition: inline
In-Reply-To: <CAFLszTiaqv7CXZg639JybryyaUerjJX=vn+gdh2nCeEPB2PH6Q@mail.gmail.com>
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


--P9/2k9qjP3YFtOk/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 29, 2024 at 07:56:00AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 27 Jun 2024 at 02:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, 19 Jun 2024 06:34:50 -0600, Simon Glass wrote:
> >
> > > Show which boot protocol is being used.
> > >
> > >
> >
> > Applied to u-boot/next, thanks!
>=20
> I wonder if this could go to -master since it is an important bugfix?
>=20
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D411595&state=3D*

It doesn't apply to master and v2024.04 was also seemingly broken. I
think it's clear enough that it can be cherry-picked in places as
needed.

--=20
Tom

--P9/2k9qjP3YFtOk/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaBcm4ACgkQFHw5/5Y0
tyyI1Av/Zj29YkUqZGhaMjsHe+cBSo41XRiG8shvdpdUuIa7hcONs/e3rqoNkqwC
KtLPnGVhwgju3ZvO65hd8POIu/YqhYelWY9xbZhcpVV5HHbbqtCn+k5Coku4rqeT
27F3JHai5KVKixFsy3hRXhWNRwLtiz0QMz06+G5jp5Uqkj6/Mnv5C//JvcoIao5+
KhjKguRl8l3a4qTMPi75t3fOVIjfj0cuBu+sId3gVdUghQrVWjhPzWI5Bmy1MWAy
8K3SfYtpoizCClveQoRE8EsU7tXsqdazt/TW4AQsbQFLSAHasK6emaCR3kuiq7gt
G7LJMM3zsXafMzsrlYQqfr9ObtglusQ6n3dAJ+vL94aYzZ59IPjpM1W8tp/WBPU1
iBGdV+zcDnOLs3H6HiNu62YtH1AsjhfqWf9cMfWrhV6E7thEkZBXoWcglJ0rNMWI
MEx38GWvtVIPc6KOfBosY7A1z6Ng6adhLEBuHJqUzqFEuS2XBJa1Xiw/60lvhhyJ
75xoAk65
=0eUQ
-----END PGP SIGNATURE-----

--P9/2k9qjP3YFtOk/--
