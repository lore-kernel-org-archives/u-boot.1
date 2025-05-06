Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E604C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 16:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61C3820F6;
	Tue,  6 May 2025 18:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n3TpAwTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0757582153; Tue,  6 May 2025 18:52:29 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1C8381FAB
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 18:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3fea67e64caso4279335b6e.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746550345; x=1747155145; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l1cR9BqR6k7zw4XMQhujKG6u1bX4htoQq2QeA9tyYTw=;
 b=n3TpAwTWffHhKyuL3dQ4VRVGOm+IUfvWYeXScmwlNjkhh7geIcZR3gqli8weGp/wNa
 wWi4/zNpAJ0X76yA4+YNP5IgIFMwHRArCVunuTDHUspqHK77i0PlQ4gsQJqeuhrmOyfP
 uoIpwsCFWotG5sykhz//20c4saNLaw1QbnRHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746550345; x=1747155145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1cR9BqR6k7zw4XMQhujKG6u1bX4htoQq2QeA9tyYTw=;
 b=g04I8VY1hPnXUpjWx2KjeCno8fMZAwAaQBjotPBfEkEJaxSjbrQHyy+Jdi41fEo8Sl
 RM7yOJonxeHp9o3+uFs29t7XViyurJGlWDZod5CrG7nf+RVP8rn1pPeii6SDLE4Tsc7f
 HjNvfBFvnqDBKwfcK2jxfOYBLpocd+LeGl+gAth1GvSV2TEN9DyFe/6lsYS8z5yqKfAB
 kmhsTUp//hP3pX120WuiNq7Q8HvNMGqSEgXtv9W+KWEJz6CuCrGueLZGvgYDfvj2Bg3E
 lkzXQfxLMblDW8C7Z/yKt33ELAFDNQnfHWmAOyKSKOPIMquUHt7hOFb+KPCoDmNqU6Nb
 sfaQ==
X-Gm-Message-State: AOJu0YxKObjzmy78amh7BJGQRJ0LqOna6DeqBwCrCXECBCHzi/ziu0iu
 w5beKxTHe61ooARqUKtSxQkdANh+uAiw+xBKNg3uaOeKMZuLPDaeM9TRBmwewwA=
X-Gm-Gg: ASbGncuUMZAQz3hqcZOq7xkS2q8NdUmsbcHaW7o2/9WMsgfrXuvQnP94BXkQh8fIxpz
 4r9dJMwqtToDc9ZMRmO6XCKjHZgIWld/deQRJlkH77xlU2nJAMzqGDtOnMu0V5c3JhC9j7w/jkC
 XgUPPJMkwLp1w+stn2idtZ1yX2XzzeRb5IrDfdpM2HPONoAlPEK+YJjkoy5YPXOctmRtl6d/VBK
 SZo2b44sZWo/iRuxT4/Gyfn6Nr4gvw4Ie677WwzMXIOTrR21m/v65K/6LDUek82z3AJgJmBeLPb
 bG7Y7hGaC3fW+SuZhVcKp3uFiCgcGTeYPmKL9Kerj4zbTBykjYVeG2LFe1S3sihwIKygUcMpHQp
 0dg==
X-Google-Smtp-Source: AGHT+IEeKpfvYkWfuDTMHyDO8r0Mz6CkdCcRfEYS6Gi+IUkkmTT155TYZKO8om7fJTQ5FJIpRWckOQ==
X-Received: by 2002:a05:6808:e82:b0:3f8:4523:2697 with SMTP id
 5614622812f47-4036f0daceemr15488b6e.37.1746550345532; 
 Tue, 06 May 2025 09:52:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033d9c0fb2sm2750713b6e.13.2025.05.06.09.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 09:52:24 -0700 (PDT)
Date: Tue, 6 May 2025 10:52:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 01/11] cmd: test: add support for =~ operator
Message-ID: <20250506165221.GB5430@bill-the-cat>
References: <20250506141035.385756-1-ravi@prevas.dk>
 <20250506141035.385756-2-ravi@prevas.dk>
 <20250506164931.GA5430@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Brhgc0GZvA5uSjMS"
Content-Disposition: inline
In-Reply-To: <20250506164931.GA5430@bill-the-cat>
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


--Brhgc0GZvA5uSjMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2025 at 10:49:31AM -0600, Tom Rini wrote:
> On Tue, May 06, 2025 at 04:10:25PM +0200, Rasmus Villemoes wrote:
>=20
> > Currently, the only way to make use of regex matching in the shell is
> > by using "setexpr [g]sub" command. That's rather awkward for asking
> > whether a string matches a regex. At the very least, it requires
> > providing setexpr with a dummy target variable, but also, the return
> > value of setexpr doesn't say whether any substitutions were done, so
> > one would have to do some roundabout thing like
> >=20
> >   env set dummy "${string_to_test}"
> >   setexpr sub dummy '<some regex>' ''
> >   if test "${dummy}" !=3D "${string_to_test}" ; then ...
> >=20
> > When CONFIG_REGEX is set, teach the test command a new operator, =3D~,
> > which will allow one to more naturally write
> >=20
> >   if test "${string_to_test}" =3D~ '<some regex>' ; then ...
> >=20
> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>=20
> We should also mention here (and then in docs) that this the same as the
> =3D~ operator in bash, which I only learned about now as part of answering
> my own question of "Are people going to expect =3D~ to do something
> else?".
>=20
> With that,
>=20
> Reviewed-by: Tom Rini <trini@konsulko.com>

Oh, and we should update doc/usage/cmd/setexpr.rst at least and we
should have one for test as well, but don't, yet.

--=20
Tom

--Brhgc0GZvA5uSjMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgaPkUACgkQFHw5/5Y0
tyydyAv+OWi1DffXPrAKgt2TTbdgnWaeRb3qWPKYtQH+2iZZg1V0m70vnDoW5WxC
NlH5w8BeWODdvQHyrTOXYrhcoXag1IXvOBwGJxNJntEcCmo038gZ2LVkkFVDT4DP
kJyNJfK4sulehh68PsidPihzdUvlehO502Yq6orz4F0sWZiaJsfasuPKYe38IDFH
cBSnCcpvk57lefdT30qOOGLAObOHsXyv+29LsWKrnTp9NQLgP1RFEdzS7iFb3YjI
4FotuuJxU5kgaScgiHVA3/IFPLoRh9HK0KRVLD7dSzmdJT+IDU4dfm6hUE3mxK2H
INCk/JHsUCtXYHgXV7YD7JTcymE4w6FY17qMSlV9d9jgeoc+JDOS1x31rX1gw9Bh
P0CL4CABwt0SXvILmIsQW9yb8iBdg99pa9odB30QrwDJPVZqQv60BXbbD/pbNUQ4
2DQ2Ce61XkLegSK/pvAEJE7jHaN2KmPBWgBqvzma20l6f9Nh1O3qrDPCwFL2gnge
3OhXu76D
=+O2M
-----END PGP SIGNATURE-----

--Brhgc0GZvA5uSjMS--
