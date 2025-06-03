Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900BCC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 19:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F27982103;
	Tue,  3 Jun 2025 21:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V13LN2yg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86B478283E; Tue,  3 Jun 2025 21:23:52 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC67807B1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 21:23:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-408e0986303so1096589b6e.2
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 12:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748978629; x=1749583429; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jy39uYAefOW1xSeiH2g823KYtoP+Vd4mbznsBV97j2E=;
 b=V13LN2ygcmo1jHIB3GyXfsuu9PILXHjLxoIUDJhZCVwIWnc1ngKgRa0l7n/kYDUPPG
 aAvjaD54aq7Mcygw2kEwCYGr7wTBb13pQ/t8RLFV0cc4DQXpmFaSjYM+XbjqStRA5gMo
 +vhFwyL9H5+cNHnfkyT7QKKQfl5GnmfGi63WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748978629; x=1749583429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jy39uYAefOW1xSeiH2g823KYtoP+Vd4mbznsBV97j2E=;
 b=T3WnYFw6+hW7G61MzivTvvreH/d3VVSthPNQ+lW/NH2bls/1VYTaffLSAi2PEsUcl3
 N0IMpfJMW1GhNabiSD7w9DWcQN5E8Hxib0gArKuSFGaLEdMoyUpPH+9FfBp6fL2TELmw
 Re0p/6EIvDYHH+bUs5is4zguBUnuiFrGYrDnUCTxT75rsh17LOyZX0fJ3ICg5QS6nub2
 KqevfLJlxs5Tv8DZlUeg5pjQv2U87A48SBpm3KooBVajV2JQC5PAr52Lu4tssXLSGhPb
 +PufVQmW0OD6xJppQ/tJflf9a4vSqLy1hRAzj0f/UTUFSV28IuwETgO7dMG0UglLeYG6
 f7gg==
X-Gm-Message-State: AOJu0Yyqd6pLa3a+GSAlC98AKscJTDYb+SnGNEvEgVzWXjZVwcjhkGtj
 ZKHbUIC08YRyUC49eV1wIRHeaXO8ABfJrpsOyJD5pwo29m9d/2pVcxT48hlAkgEEoXA=
X-Gm-Gg: ASbGncu4qvHDXXL32rwGabUmYd0p1FUy+7YJmTrD8U4VbpooYtgkB16E2J/oxBoj5Lk
 yv8R4ViXky/OzWbzGuew4mUG9HFma+0HDx7yiDBn3xeEyUuQU/fWNIpMUp7inMN/R4tpppZDZzY
 U6pL87ZYNdEZUr4wUyBmurhaKnQiZlvfK6Tw9zM/7ZTgy4QYg43504jX1GWUY/2Cj8jqlDCnj9L
 M0yS48WsJ9KeWOdeZhbmXw6AfOxtqsoTWBEWWNw+20bn2Ff4zYVM0YpPufo+qx2Kr63TYiOOqdq
 4zEE5Nt53/UCtzyafF1bAuWAADO+qpPn2sgicL0qpSTVbEke0rn1vnvgQsRNGT908DanYvab+ZN
 sFg5TGYd4nZ2zhvENWjGykH4=
X-Google-Smtp-Source: AGHT+IGk7EV80d+2xapEqH4KrY7dVav0N/fPmsdyXu8vVCD5SMZpcpUBh0qRqMeSpg83dbZwcgVbmQ==
X-Received: by 2002:a05:6808:3991:b0:406:6884:a84a with SMTP id
 5614622812f47-408f0ec4183mr258189b6e.3.1748978629142; 
 Tue, 03 Jun 2025 12:23:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678bf36f3sm1938975b6e.7.2025.06.03.12.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 12:23:48 -0700 (PDT)
Date: Tue, 3 Jun 2025 13:23:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
Message-ID: <20250603192345.GL1382132@bill-the-cat>
References: <20250603151401.1709532-1-raymond.mao@linaro.org>
 <20250603154748.GG1382132@bill-the-cat>
 <CAEfUkU+7BaEcmQ1NL2TSMLpHYQt1DhPLKZPtkB_Fd6u_Oq4qEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PI2hFMeUUE/k8tGU"
Content-Disposition: inline
In-Reply-To: <CAEfUkU+7BaEcmQ1NL2TSMLpHYQt1DhPLKZPtkB_Fd6u_Oq4qEA@mail.gmail.com>
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


--PI2hFMeUUE/k8tGU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 02:00:23PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 3 Jun 2025 at 11:47, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 03, 2025 at 08:13:58AM -0700, Raymond Mao wrote:
> >
> > > This patch is to solve the sandbox building error:
> > > $ make O=3Dbuild-sandbox -s sandbox_defconfig
> > > $ make O=3Dbuild-sandbox -s -j2
> > > /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined referenc=
e to symbol 'pthread_kill@@GLIBC_2.2.5'
> > > /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symb=
ols: DSO missing from command line
> > > collect2: error: ld returned 1 exit status
> > > [...]
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  arch/sandbox/config.mk | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > OK, but how do you get this failure to start with? What host?
> It failed when I started any sandbox unit test like:
> ./test/py/test.py --bd sandbox --build -k <any_test>
> My local host: Ubuntu v20.04, x86_64

We don't see that normally, is there something odd about your compilers?
This is the kind of thing which should be failing everywhere, but isn't.
Thanks.

--=20
Tom

--PI2hFMeUUE/k8tGU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/S8EACgkQFHw5/5Y0
tyyBbwwAkWyZ6Fx6K/Qooby7C54u/A/lGVagCA2QOfradxtJLUpNck3alZNGTOLN
aWwqEu22UIFAkbgSbGsN4RR9PO6DdpTqSffq2KsMNm6lCUKbHxFDt08JiHkmQKRD
reWPDTouCFNgMXAOLnWFe2sOReDgzY2bfhamF/NC5RL5Oh18aVffWJpB2z6bEsXf
YExb5jMPNTjEFiKZcwalOpe/MiFeGN0CdhGs9p3oQjcLoM6xqHYtPD0lHD2cpLNx
Ck66GMhC2ssOc/ijZwGx1MVkSGonoP5KruPLudAUnZPXuC1gSBvQ32uXYN4KPyUe
TVh2qg78BDoEcU7ZUsjsD0Xvq2/PWGTsKnO9HM7dxLJ/TXIuTDkKcxtbvsb2EYDJ
63iYlJwCz4xKBY+5dy9xVdJbKrm7rLq3xKTdXCJqMQ1u9BkY7JzcFR/mQojUKe6T
mKld1WUDMHQQ5YGkXFi/rAjL8EHgP6X5ntmlzK6ujWYh0dAwaQRvbfeW52pQhr0q
kSPcjiWE
=Ge3p
-----END PGP SIGNATURE-----

--PI2hFMeUUE/k8tGU--
