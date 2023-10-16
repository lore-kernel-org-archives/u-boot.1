Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251F3CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 13:09:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6436E86BB3;
	Mon, 16 Oct 2023 15:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C+8MuLe7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDD6186BC8; Mon, 16 Oct 2023 15:09:22 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8598A865A2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77575233633so327756585a.0
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697461758; x=1698066558; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iP3e6Xdld8PdmVh5YHRqiYgwxjKlxs504TMkGa4v1I0=;
 b=C+8MuLe7JJskgZAu46MtU90xlGuk+4EdbLTWvtc+FK+7xVvv+CkSpREdJD5n3Q3Z8I
 nu5E4QXn/PcqGwPYsqVXRz00ipWsw5cpxGGmWodKL+i7Gz0kfuvlz/lVNN75bnD/rWUL
 ZFNhpfX1lklvW+LzlDiJ7pjcCEIGf29aTWyQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697461758; x=1698066558;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iP3e6Xdld8PdmVh5YHRqiYgwxjKlxs504TMkGa4v1I0=;
 b=U7RRDmgSArxVeHZ8jxOyesVM8XDKkH43uD0HhUlSFB9gi/JepiDo3QW8mKytQUN860
 x8P/S/OxRr4wvLZ6BHu0v+mGKiMaqqcg1EwJdex+0IU6auO40Wg9srlCcqol5lzmdN6f
 /4acHhNolsCxn6g5HXRR44w3apeS3NUBGQS/idoJ1eyDAdEn+4Z1yMXjNIHEidlV6aYV
 UAEtSMBa69smbXbGmT/qGa+WNAmXD4S4M5MtMwRUHrIMu/udDYunWGPw1gX2W86nSQ85
 i/MVbOs6lkhmn25X0r6e89lkZ3/uDrXwh1oUWIiXbHbYa30oAggrcPTulqgzQ+GSZtkM
 OaDQ==
X-Gm-Message-State: AOJu0YwOA/h0cDjMAImFLqLQlI/I4b3j+aOEPIWipsjw9T1HkbbFS2HJ
 MCWJqKdweewknwf4Yn2FjBWWbg==
X-Google-Smtp-Source: AGHT+IEzathFEvCslS3MX44gOMhxEUeZvsXbs3A5fczjemOK6/Kn6IyeiGE34dKgzq9cHSk52N+y7g==
X-Received: by 2002:a05:620a:1350:b0:76f:2214:e2c3 with SMTP id
 c16-20020a05620a135000b0076f2214e2c3mr33583432qkl.64.1697461757947; 
 Mon, 16 Oct 2023 06:09:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 v20-20020a05620a123400b0076f1d8b1c2dsm2954702qkj.12.2023.10.16.06.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 06:09:17 -0700 (PDT)
Date: Mon, 16 Oct 2023 09:09:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] command.h: Add a U_BOOT_LONGHELP macro
Message-ID: <20231016130915.GD3119521@bill-the-cat>
References: <20231007191308.2222470-1-trini@konsulko.com>
 <CAPnjgZ0wo3pcTOgJ+9s53kNwnuxK0pHApmJbbmv7eJe_XDhrAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xeqegm9PRvBCFSf6"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0wo3pcTOgJ+9s53kNwnuxK0pHApmJbbmv7eJe_XDhrAA@mail.gmail.com>
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


--Xeqegm9PRvBCFSf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 15, 2023 at 08:39:44AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 7 Oct 2023 at 13:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > In order to be able to discard unused long help texts without further
> > linker lists, add a macro for defining the long help messages which uses
> > __maybe_unused.  This allows us to discard them as unreferenced as part
> > of the link.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  include/command.h | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/include/command.h b/include/command.h
> > index 34ea989b39b4..a836ea795ab6 100644
> > --- a/include/command.h
> > +++ b/include/command.h
> > @@ -322,6 +322,9 @@ int cmd_source_script(ulong addr, const char *fit_u=
name, const char *confname);
> >  # define _CMD_HELP(x)
> >  #endif
> >
> > +#define U_BOOT_LONGHELP(_cmdname, text)                               =
         \
> > +       static __maybe_unused const char _cmdname##_help_text[] =3D tex=
t;
>=20
> I just noticed this...do you really want the ; at the end? The only
> purpose I can see is if you want the macro to compile to nothing.
> Otherwise it is more normal to put it on the invocations, isn't it?

I'll drop that when I apply it.

--=20
Tom

--Xeqegm9PRvBCFSf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUtNfgACgkQFHw5/5Y0
tyxOmwv+KRR9t1pGxshvM4z6tL+qMXjcIvVDxZ18BDPKu/uZbbFTThyjl4ilHpy5
XR1ysSOFhTtKJnV7maCV9jaFqj0Yjr0p6wbPH6nEmL/EIx7IFMUGz6Q8Ok/Jqted
Mp3gKhtjjWPey3VNMDv38A+qbWRzvOYPRv+k/ymkweX+1rj7KiLFOWguzFFz9b5B
xLNsv4oGPYDaJIAyX8wn8PJtHc+ILHgl4zaIxrOOKYxQ7ctx5aykzndOeEQ9WIiS
sj+ncLFA2wNDjr8QABCeE7Jy51OgDdWuKR91tidzTCjjO4zWSJ8EgAFBSzPF7BWt
TYadX+2XXwrN4O9jVgc4HAQ0aLvzBVSumaBU24cdwepuGwZLO3pqeKQ6NJykUAZz
aWS96curXGsUQVkTomLeHzPWn9BLekCle5Uy5gcV+AUM2LSGWNrU3zki+4hESG/E
me3PeroQUG7VOMsrwDNzMST/8nAoAwcxKDdNXvNKs3fqMDINWQW6VGr5QQsnbz5A
fAqHq19J
=DHGT
-----END PGP SIGNATURE-----

--Xeqegm9PRvBCFSf6--
