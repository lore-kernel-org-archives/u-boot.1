Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD20C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 19:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA0B8881C;
	Wed,  3 Jul 2024 21:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="smlTibDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61B1888829; Wed,  3 Jul 2024 21:14:51 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01942883AC
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 21:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-701ef03185fso3361719a34.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720034087; x=1720638887; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MbJb9ge8IrFm8vvKKb2N90FO/IgkBmDDCGNS+83zUbY=;
 b=smlTibDZeU7F22Scm9rmebUYjxP0BVTBsSwmcUSkmU9L6d3J7m9/fvCAcaiUXan2Yq
 86gdXtH/fZP4QS2/uQPQy3D1rbznms/vTV4JCDGShtQKMx47Y4CK5HCgxD0EsrtX6bVq
 fzMjisnVZnHfrrk852ypdvrFeZhObWZmUtfaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720034087; x=1720638887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MbJb9ge8IrFm8vvKKb2N90FO/IgkBmDDCGNS+83zUbY=;
 b=sFDatkC+Ss2fk5RCVeKQbckOttsKZJPm6A16wNRDLamIOF19iVT7EdRl4kBDujeUKR
 QlSU13aF8lmi2FH6pdBnV4ZPpFW9/LIDxKxNNSJlPILqZR6erhkFAuvaDUe82ikQ2dZ0
 RQZEFYt8V+4r7MZUtEy1+frvuSe5Y759anpVRJnVAVKgTx+ImeerqR8cZ0Ik1P6v+4fW
 DDh7H3Kqn8YQHOsxEFlt3MuB4gg9+1ROMpup9EXBKzNmtEnMIOpiELeCgdOrR3A4u9zB
 v5QNnpeAlnmrAF+RW273Rex+V/b+lVVweYQ69EpczTo1nc59RGlj2uXOR9WO76t2VT9f
 AmBQ==
X-Gm-Message-State: AOJu0YxNXGG9fIW6Mfia/+pGILUdAO9tVivznHHfCcr8c98nCpuouODR
 kML6T8ICMDTcGklkxKOYEYNjeubRoZNHk08o2eV3j5u7Ue6PRXsIn9i1MQcBuq8=
X-Google-Smtp-Source: AGHT+IEa+yH5JzfG3qJokIgdKwkzUHkDSBQf0DfE0Ump0pe9QiiWxjuJ0Xgs9f1QNm4t9ndvkM9tJQ==
X-Received: by 2002:a05:6830:1e92:b0:702:2504:bad6 with SMTP id
 46e09a7af769-7022504bc92mr5073601a34.20.1720034087587; 
 Wed, 03 Jul 2024 12:14:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ab4f42sm2093236a34.29.2024.07.03.12.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 12:14:47 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:14:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-dm
Message-ID: <20240703191444.GD38804@bill-the-cat>
References: <CAFLszTh4oAz__Z+gLH+zRRVL3OU15TcgKo2fXA8SQj8NbLQwiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J9WdV5gQ8HxBXBsy"
Content-Disposition: inline
In-Reply-To: <CAFLszTh4oAz__Z+gLH+zRRVL3OU15TcgKo2fXA8SQj8NbLQwiA@mail.gmail.com>
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


--J9WdV5gQ8HxBXBsy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2024 at 09:07:58AM +0100, Simon Glass wrote:

> Hi Tom,
>=20
> This one is for -master and I dropped the offending commit. It will
> have to wait until someone responds on the MX9 bug.
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/c85a05a5d87ce=
6f077c41d7e63a4a7953ddb351c
>=20
>=20
> The following changes since commit 65fbdab27224ee3943a89496b21862db83c34d=
a2:
>=20
>   Merge branch 'next' (2024-07-01 15:00:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://git.denx.de/u-boot-dm.git tags/dm-pull-2jun24-take2
>=20
> for you to fetch changes up to c85a05a5d87ce6f077c41d7e63a4a7953ddb351c:
>=20
>   bootstd: cros: store partition type in an efi_guid_t (2024-07-03
> 07:36:33 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--J9WdV5gQ8HxBXBsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaFox4ACgkQFHw5/5Y0
tyzRqwv/XLwGlGZDkVj2SJglwx0/jcDEs6XyM48x5wmge5x+YSurP4+NGBdev4gF
cbshJ4Nli/fLl4JgkWHBOfS0fAF9S22Z0Ut6fvP0H2qRCih5LqlPAxObumyxDWes
JVoSGAff+3DD+Nxzaj9nwkWniJN1eB6cCuqC75Byd81lzHEYUwiyD70dy7ALL+He
tTTmRlYzog7Aui7LDQZ9HiRAO630hfGYJYAAwp8sdW8fFmHn1kDbtahf/kmuT0k+
VlbHaC1HMOGmsLxY3tDkDZeTJ+7MK+UXJIfgx0VR7vUHVdO5FNjAy3H37qqf7pvu
wU/ry1XTCSCZvXH4nDKE9K3AYDe7ax9+eCYAYyu6JTbBVkutPYCvWW5GLm6S89l8
9mygkF+gdBkYXPIF25ofi7hcwZjOZm30XeO332Cd4ZpaF5aSCG3ADDC6hEZhoClE
CkOpDGSGBytQ9FHLHgS38f5tpQqu5/sF1Le34jL6MsK4ZWKZVMMFWkUxdhw8rAVF
IcvUrC6L
=Ct+p
-----END PGP SIGNATURE-----

--J9WdV5gQ8HxBXBsy--
