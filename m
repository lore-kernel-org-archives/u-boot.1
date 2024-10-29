Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5ADD3A672
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 16:37:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDCB89186;
	Tue, 29 Oct 2024 17:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="seWyNneN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E9689186; Tue, 29 Oct 2024 17:37:27 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8DC891A8
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbf0e6414aso27839816d6.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730219842; x=1730824642; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S0quZp5ar6M3SU077WJMIUPfGNu5nQmUI5GRHWy9SGU=;
 b=seWyNneNp5esqPxN7yp2kBiTYaidjArKMYdloUDj1eRzJAP6mCsPDIko9FMJ667ue+
 QD7z1D7YmgfukXkebEIXQ6qZwAQ6yLMhjqF1Dw9aVBOMu/YhCP0CfLzvn/r8cOjCot9Y
 alcKJDiuhKsSprRknFpU8aOGZwo/JlQVrTi44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730219842; x=1730824642;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0quZp5ar6M3SU077WJMIUPfGNu5nQmUI5GRHWy9SGU=;
 b=lrwog0GWguSn4ns7wPko4/X2TRmW4kg1dddnphTpebE+kWtvltvlD0WmLUsjsUlfee
 UViAHVWyxSLkCL0qnCM/ndF/mGxu0sE09Rl8TG8MToS+RmrXvyX6i8t8CvI3NYOcdfxe
 9+rSlGaQhwfsHIDtWiT7h8++nXx96MVqlIqoRnCX9NONoVWLBDJyKpnEd3VpQ8PGiQES
 WuDIFXNZ99zNvxTnO7/DHnTB+SJxzpe3Hvn+Z4rdM4ZG0wFANUOuoYeDZRUUxcGPQi6Z
 MHZqFFUPiYHM5jPOMBK+sg9TIJekiqFL78cqPdvO99qnBW7kF94Cs9gTrlGuvGXZExoj
 jgTg==
X-Gm-Message-State: AOJu0YxEjjC/Iv7nMcQTXM7rkG7FF/4uOqpiObw8lZF72vtEH/9vln8A
 YcdQYckdYlccUGEBXz3RZy5lIScowijQhCpVMA1OEuc71FkulITrgQ062qI1sZA=
X-Google-Smtp-Source: AGHT+IEynMDBuF2m0n72nsqkRVZE6vN6eZ48EXd7FYQijZ8bqm5rbuz34+ab0u4awRfQVUPBITQY4g==
X-Received: by 2002:a05:6214:43c9:b0:6cb:c487:24b5 with SMTP id
 6a1803df08f44-6d18583946cmr186059706d6.32.1730219842466; 
 Tue, 29 Oct 2024 09:37:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a0ac03sm43330626d6.91.2024.10.29.09.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:37:22 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:37:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20241029163719.GC4959@bill-the-cat>
References: <20241029010611.175198-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="antu7uwuEUSzBVAF"
Content-Disposition: inline
In-Reply-To: <20241029010611.175198-1-marek.vasut+renesas@mailbox.org>
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


--antu7uwuEUSzBVAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 02:05:47AM +0100, Marek Vasut wrote:

> The following changes since commit 3df6145db0ed3430a2af089db5a82372bea3f4=
d5:
>=20
>   x86: Missed removal of CMD_BOOTEFI_HELLO_COMPILE (2024-10-27 20:11:36 -=
0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 400d06cb86a074dbd23cbb7f1210dad26f392807:
>=20
>   mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi (2024-10-28 16:=
27:34 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--antu7uwuEUSzBVAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchDz8ACgkQFHw5/5Y0
tyzY0gwAhmo6H4acGpuk7ByfW7QVp4CyCtBRtLTC/kTi0/GJkthnPRPlUDNK5K0P
uKU3RdZbOco6rWf1okk6ohp76VQ/j76/maxazEn+6SjpkLhPyNkyH6HLdb6MwUdq
mF5MOv0cqgGzv+b7CNiuhMr1EiPch0kyBugZ6h37vbtFwzuoVYhg6A5GJ6gonhs7
MrH8wl9PZ8+MocoT22W7gZ7v2bvJ2MawNOUBOJpVs684eP2shqXXRsA69l0T9dxt
Lp9znnByYYZqopT6LKDBTK4ItM/LhpEimAAclRqevzret5bU11Em+1RwONJ2JQk9
462XfcXz9UYiW5N8bYTzlrWMwHyDtm+9n6QSYCa8JpiK9zoDnsdHPPvBNCEQ2DcP
6PpniUOS2I4nNIDTP13gpC0k/MwQmdi+8hc0Z/RNwuOCm1jm24jWB3aGHCxJY93e
AnBCcgFvCsjvgLuf0T8ArH+TAre9/rDliWDtkKB7/AAMeAFd2Vuk2gTN6L+M0EOQ
tLqTCmPX
=Gr1r
-----END PGP SIGNATURE-----

--antu7uwuEUSzBVAF--
