Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EF5C3600C
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 00:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4540D81DCC;
	Sat, 29 Mar 2025 01:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Go8fstA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58C78809A5; Sat, 29 Mar 2025 01:04:03 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E052B81A0C
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 01:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-726819aa3fcso1812915a34.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743206637; x=1743811437; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sTkfBgcM5w3VYHhN9poRXIeU04fkjJRVrAQ0K6tBZDc=;
 b=Go8fstA/zhm94gkMFvQ/qGigLad57GHq5Oxb48K4pX4/TgRKSRa9MXMGKH82qQc9yP
 XDuMCGOe2vjMPPUDuZxGdh7kyKnLCV+xuUsSM0OLwnbEv9pFdRYEbZ8KgdzhvPc7SAXZ
 dIogWJo/OoIqP6LG190YjdwB/D7dPnP3H8mQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743206637; x=1743811437;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTkfBgcM5w3VYHhN9poRXIeU04fkjJRVrAQ0K6tBZDc=;
 b=PCzSqZFyVpBVm4T1MFtBKjPLttC+2igz5R6xS4Ahl+vaYrhJ/ZdffhT7YrOe6G04fC
 e4F7d6MArdKz8ZFiHq0VIv00R9rVP5WtXPnIGKNi2sxgHWjy2WIPmL4GFYzQT4o2Q/Oi
 L5XBXXpp5OjGTIiQvSN/jl/zRgAyxnn1Pgfw0Bw51TGdW5GHclSjUHva7b8x9amwLs7s
 AQMLbtrA2JeWdvY3a7wgNvcFaMV0G0uoXylQthH2VC/WOJFw/3INAcpfsmVhaPxVWEI1
 PTDxjNfU87/mSQiAFT5CGS38tNx5AtJZwHnhAWOUxu9UuW0+Ze1XgxGwWRwAMaL2w3Ss
 kFSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOTZnZh+NucGLfSIdLPhWaC8fC48GxSh5CrSFykMGsj9DKqgqc1gXr0FXjg3xCXGKVMRFdMfw=@lists.denx.de
X-Gm-Message-State: AOJu0YyuyOp0pync+BnR1VYs8fo1pdYqBhJGKRW82+i4Bo8tIKsbu8sQ
 qvjYQcBgv2tWk0banXqLKkZwkDkZGQ3kbGvtA1Wq1gHcsvWSYjakJufYC6XQen8=
X-Gm-Gg: ASbGncujUuhYjuLIm/aQQ0nMs39Ptl7yW3jy6pJLbmEvufSjSL83sFKiijw14gJqj6C
 jlIBOnc/GuohwjoNp0Zby01MljGVRFpqpqK+uq5PG06/gxQkbAv3rmtCsfRRKeX+L5Vw7XcK3B5
 itCD5OrtB7HXi730+kQCJ4EJmsq1KvQ3dKC/Q0AulQt0ndLS77SaWWHuXeZ4IBRyxw0Fx3y6zY2
 wkKmsgGH/wqYRAW3D9nr0LI7k17fl9bLlKZ6BH5vH03ybMKYeIOd5lSWD7tzKs3qHkBDzIRzWlv
 sdN233qbAHq7utJUYkZEBEvx4XB+JfDiWIzHQ1YCcqt7UB5Kjs3MtWnR1btljOUPUmN3RKdpDLZ
 sT9n3qg==
X-Google-Smtp-Source: AGHT+IFsQ1NFRYiC2WrbskiFFcsYA8DVFLhvEJ4v8uRSHxuTXcFG4GTAc9nf8e4QynTYk+TqlyYu9w==
X-Received: by 2002:a05:6830:924:b0:727:ec1:73ab with SMTP id
 46e09a7af769-72c6381ce8dmr841852a34.19.1743206637443; 
 Fri, 28 Mar 2025 17:03:57 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580927f4sm563319a34.3.2025.03.28.17.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 17:03:56 -0700 (PDT)
Date: Fri, 28 Mar 2025 18:03:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/2] env: point fdt address to the fdt in a bloblist
Message-ID: <20250329000353.GI93000@bill-the-cat>
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
 <20250327231318.2713201-2-raymond.mao@linaro.org>
 <CAFLszTiATNSdLgJ-PCEFjyTbwsgxTXg06W4Lj3Fv+zYwtKWcEA@mail.gmail.com>
 <CAEfUkULhW6fi9119WwTuUq__77Ga_ORcDpXsDzh+vs73QZmbkQ@mail.gmail.com>
 <CAFLszTiXypPhg1RXng7P6CV9xLAEuSMg4B+gjr0c53a0SvS3sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="734+H+P9Fn4BU/eT"
Content-Disposition: inline
In-Reply-To: <CAFLszTiXypPhg1RXng7P6CV9xLAEuSMg4B+gjr0c53a0SvS3sQ@mail.gmail.com>
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


--734+H+P9Fn4BU/eT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:39:13PM +0000, Simon Glass wrote:
> Hi Raymond,
>=20
> On Fri, 28 Mar 2025 at 09:06, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Fri, 28 Mar 2025 at 07:35, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Raymond,
> > >
> > > On Thu, 27 Mar 2025 at 17:13, Raymond Mao <raymond.mao@linaro.org> wr=
ote:
> > > >
> > > > Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
> > > > is a default address for bootefi, bootm and booti to look for the
> > > > device tree when launching the kernel.
> > >
> > > I wonder if we can drop use of that environment variable at some
> > > point? It seems strange to set a variable to gd->fdt_addr only to use
> > > it later. Why not just use gd->fdt_addr ?
> > >
> >
> > First, the fdtdec happens in an early stage and it is not able to set
> > the env variable at that time.
>=20
> No, I mean actually drop use of the environment var, so we wouldn't
> set it at all.

The environment is for humans and also other use cases. It's not going
away.

--=20
Tom

--734+H+P9Fn4BU/eT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfnOOkACgkQFHw5/5Y0
tywY6AwAlBumEZFofeAU6XZgxlDD5gsate40othgTFZG5PrMYae92CAir0m5GnVk
AhklX9FDMQNxQKDg2wAcqyQQtdHT2aFfNZvP0mUJ8btq5D+ASrCN3D4ld/gFhK54
orJpqtH11EGRlbZnQWD7XLwiy3qxSa+fQS9mEmhW34ASf/VWPDFebsNDIWZy3J4m
vSxKCSIaeq4Z2Fd/nuN3v/uOBHPawnWAztnsZ8zl77hpAZl+zp9ZXNcTo4eHEEov
BpsbiGNLFt1TOPjpK2I7T6DneDOkGb3YO01VuXhFF3WQwgviPpy3w+UgcsLDYPHX
Odhsc2SNDPevgzN3QT5qNyroFeXF8/X2pb53LWFAocTyoHvsxkG+w6RNCc/B79Ne
SEKzsAU5gH9U0SHyBIXIR8Bc1YoYgoLCPT6UjN7WrSI5LIPo9Xevctv7Ye5Q0kqd
9dNUySddKnCft+CHVzdcrfnYFNh+6oSscSDN6x8MDjc+coFKMGG+jv+hfm6WmmFD
fEIQ6ZAL
=z7nL
-----END PGP SIGNATURE-----

--734+H+P9Fn4BU/eT--
