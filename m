Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB584C61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE1B7865A8;
	Tue, 21 Nov 2023 23:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jHVHDMOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F1887582; Tue, 21 Nov 2023 23:24:46 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03666865A8
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6779fe2b7c6so21910876d6.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700605483; x=1701210283; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UVNKTQbGg31uJLQa1Qv5jiDWDH1Do9pXGbYUeY2jnic=;
 b=jHVHDMOFCg/ZZhNI1aEQDjD5Kths+z5LRYqBAKUtO8vXk0cRpBZdubnn7zuiROn2l5
 +Wk5wu8a4cEaRjzxHIBtf6E02BpAqtN2KJe1NNj84UXkok7unR1LEHzUWnwmnXG41jj2
 PyJpXtOxo/DptQ2MmHhvn2/OgCDtH3W0y1Iw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700605483; x=1701210283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVNKTQbGg31uJLQa1Qv5jiDWDH1Do9pXGbYUeY2jnic=;
 b=oKJxEkMM7ps+9aOMzRnG85JM/kNq+ebNqz6VDDNctBMRwEiuDRSGxR2hbDp0AzstH8
 KxdBzQXbY/7U3EYFHaJmxcOTwwGbW6crXgr6Geg85/1yfn6c5+gHtLEXcErmZzc4UIes
 vwMp5zcO8UCU1ZSIguNgzfMusWYUVCS3aPm0bGsxYlKVkayA/TZ76aRqHcaxIzZSDsQK
 cZ2LxUmt2Jx9bvkEYC8FeyC0UFeRfb2NsKhaEuSFMdisJzxmZEzKfKn3iOZH6HLPtJuQ
 //uT/lQ1qtbxGKCirfNUPDyeggCxJ+596UJ8lKZ4vx3vxqH/ppwrDqzFnBTxmBfp/w1H
 S/+A==
X-Gm-Message-State: AOJu0Yw/tCfKluCdsKq4BD+vsaD9pjEzE3DxkY5xsY0LCyJvAKGZEF1F
 MhY2AjhnT8PorEQ7wVmP8DjkHw==
X-Google-Smtp-Source: AGHT+IEgMEZjhymHWwaVw7USCLcohhdNFooL+FdZbIw3EK09R4mhp78he7UOTh9N86ILPypRpxBL2Q==
X-Received: by 2002:a05:6214:e8d:b0:66d:2ae0:44cc with SMTP id
 hf13-20020a0562140e8d00b0066d2ae044ccmr583296qvb.21.1700605482781; 
 Tue, 21 Nov 2023 14:24:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 u21-20020a05620a0c5500b007759a81d88esm3917446qki.50.2023.11.21.14.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 14:24:42 -0800 (PST)
Date: Tue, 21 Nov 2023 17:24:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: Re: [PATCH 1/4] tools: mkeficapsule: Add support for parsing capsule
 params from config file
Message-ID: <20231121222440.GM2513409@bill-the-cat>
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-2-sughosh.ganu@linaro.org>
 <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A48GM2EqPOpW9I0c"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1croWnY9nYYEjiJZB1kO4SB_+aQOb6_yhYJcj-McfuAA@mail.gmail.com>
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


--A48GM2EqPOpW9I0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 03:11:50PM -0700, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Tue, 21 Nov 2023 at 00:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > Add support for specifying the parameters needed for capsule
> > generation through a config file, instead of passing them through
> > command-line. Parameters for more than a single capsule file can be
> > specified, resulting in generation of multiple capsules through a
> > single invocation of the command.
> >
> > The config file can then be passed to the mkeficapsule tool in such
> > manner
> >
> >  $ ./tools/mkeficapsule -f <path/to/the/config/file>
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  tools/Kconfig              |  15 ++
> >  tools/Makefile             |   1 +
> >  tools/eficapsule.h         | 114 ++++++++++++
> >  tools/mkeficapsule.c       |  87 +++++----
> >  tools/mkeficapsule_parse.c | 352 +++++++++++++++++++++++++++++++++++++
> >  5 files changed, 538 insertions(+), 31 deletions(-)
> >  create mode 100644 tools/mkeficapsule_parse.c
>=20
> This patch keeps coming back :-)
>=20
> Can we not add multiple capsules in the binman description? Why do we
> need a new file format? How can binman decode images produced in this
> way?
>=20
> Also, could we get sandbox to produce one EFI capsule as part of the
> normal build? I think that discussion trailed off.

I believe part of the answer here is to support the config file format
that other capsule generators use. Do I recall this all right, Sughosh?

--=20
Tom

--A48GM2EqPOpW9I0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdLiUACgkQFHw5/5Y0
tyxSEgwAgFNtIy3QCjQmzmi/YWgszNaYcB0q0pnm/c8xZNXgdGr3VcxMizqqzsA3
/qWQQRQQyNoO/i7DdGOyRyiXpXYxc0MNszOykNBtQ24ePGCA5Ga2qYBxb26mIXTv
ND6ltq9RjUKC4tJlfXg//r72CB253Nae+EZvGH4U78Ak/Msnb4Kc/eoV18/pURLm
Q4OE1nPWAn/S+GuDLTRsk3GE33Ykr86WDMz0CtGpwoNvL9RdcIh9O3MW0hpIVa5s
c1e64eK2LRZ6DPM89px2152P+rtsOzh7O4vGo1Ohf3R61W21crJ3L47V2hsSZ2CV
hnnRs8bUp/0WcCiJFU8ud39q7FFjQ44bwRl/na/ZUyNrLMwYWfBglDI45rX+CGil
IlKXY3qhZ+6GQ8XS5YeaqD7GGqvSlKv6QSHTEnzEXnkTnpIUTNddhvQYoE5L9lE+
e7FhEPolWTw2X3lW/5Jd3rSngKXsjaMKlcHbHFl67E2ua4au2IAOht+5/udph/kr
J5harfa1
=SrEP
-----END PGP SIGNATURE-----

--A48GM2EqPOpW9I0c--
