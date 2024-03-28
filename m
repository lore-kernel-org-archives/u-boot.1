Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4F8C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 13:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9725B87CF8;
	Thu, 28 Mar 2024 14:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711631008;
	bh=oZWB+UFKuj+K6qBh0CFJtiZrf5at1fai6kbPV9PUKGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tn655Yx62klyzQUkuigyTyZKJ43L+dLYSYw5svlrjC3q4lydyJhSRe7ystopeRETy
	 gqfvoPGqtCDeGUcwKMve71dZOjOKHazi9FV3e66UAFopNmmlC/LAoNWVjoF2wHth3c
	 77eDvBoX5dHR+SDvB/3PIu36v27u12oALqUaHhO2dwUcKV1zBHe7gu4Hs2U6Q0OpTE
	 xOlGxdYuIZ+H9fc11958WnU5eOBIziyGyv515a4/xHJOXkbm0ghVLCg4iwBpMOwdRT
	 RJ8V9ll//kfAHLjbwzGhlRydqrnfvT2I0mMjvx4wN5XiFqufaxdMHE9MXcyed69uDc
	 O9cSunnVLPfxg==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E4539879E2;
 Thu, 28 Mar 2024 14:03:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711631007;
 bh=oZWB+UFKuj+K6qBh0CFJtiZrf5at1fai6kbPV9PUKGk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=pedKNpZAxg3YxQhTCvmsJXdJWsFM454ydOd6EceAoQRCoqXklMzAdSomRrq21K4tq
 AKm4T6puvv5FwRmtrRX1RSOmqzTFx6UyPLzlipo1IdFOi+SSoU2ZZAvMR0NX0aBTwX
 TrLLKQGKbOkO2KdyQEzlwyolu+uGV0xulfk1dU/nvoP2XVh+LPulDNeEW/6r3a2z23
 2bfuwBpQJ5aEWlId8fVav97IBya10t2kp4jAQG9bDQDzEQ8v5DsR8l5XtEH/fzD9f0
 3xqDzopinGqhuL/MHHClK5X4G9EqJXra4Gqz9UkKfgHuahqOE0cqN9FfO+V2hSryU6
 u6Jyn9UyqsUUA==
Date: Thu, 28 Mar 2024 14:03:26 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, Marek Vasut
 <marex@denx.de>, Stefano Babic <sbabic@denx.de>, Fabio Estevam
 <festevam@gmail.com>
Subject: Re: Thoughts about U-boot binary size increase
Message-ID: <20240328140326.1de4fd34@wsk>
In-Reply-To: <20240328125840.GN3442575@bill-the-cat>
References: <20240328102049.10108d5b@wsk>
 <20240328121832.GL3442575@bill-the-cat>
 <20240328135522.4a07002d@wsk>
 <20240328125840.GN3442575@bill-the-cat>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vxJyxH/bynvVGrSk1pn6WTA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/vxJyxH/bynvVGrSk1pn6WTA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tom,

> On Thu, Mar 28, 2024 at 01:55:22PM +0100, Lukasz Majewski wrote:
> > Hi Tom,
> >  =20
> > > On Thu, Mar 28, 2024 at 10:20:49AM +0100, Lukasz Majewski wrote: =20
> > > > Dear Community,
> > > >=20
> > > > I'd like to share with you some thoughts about growth of
> > > > u-boot's binary size for SPL and u-boot proper.
> > > >=20
> > > > Board: XEA
> > > > SoC  : imx287 (still in active production)
> > > > Problem: SPL size constrained to ~55 KiB (This cannot be
> > > > exceeded). Board design constraints u-boot proper size to less
> > > > than ~448 KiB
> > > >=20
> > > >=20
> > > > When XEA was added (2019.07):
> > > > 	- u-boot.sb (SPL): 37 KiB
> > > > 	- u-boot.img 	 : 401 KiB
> > > >=20
> > > > Now (2024.04):
> > > > 	- u-boot.sb (SPL): 40 KiB
> > > > 	- u-boot.img 	 : 427 KiB
> > > >=20
> > > > (With a _lot_ of effort put to reduce the size)
> > > >=20
> > > > Hence, the question - would it be possible to take more concern
> > > > about the binary size growth?
> > > >=20
> > > > Maybe CI could catch patches, which enable by default some
> > > > features and the size is unintentionally increased?
> > > >=20
> > > > I'm open for any feedback and thoughts on "stopping" the binary
> > > > size increase.   =20
> > >=20
> > > I think that's pretty amazingly small growth for nearly 5 years
> > > of bug fixes and feature enhancements that it's likely minor to
> > > make granular. =20
> >=20
> > Those results are after using OF_PLATDATA in SPL and other tricks -
> > like compression of DTB in u-boot proper, so this caused some extra
> > effort to keep small. =20
>=20
> Yes, and I'm still pretty happy with that.

Ok :-)

> I would encourage you to do
> what I suggested, before turning on LTO (as that makes it hard to see
> symbol size changes due to the nature of LTO) as what you asked for in
> your original email is what I do, and have done for a very long time
> now, with 99% of every pull request / branch merge. I'm not saying I
> didn't miss anything, but I am saying it's a matter of specific
> changes and not a general problem.=20

Ok. I will check binman's output for symbol sizes changes.

> And if you hadn't previously set
> the options to enforce failure to build if hard size constraints are
> missed, please do so.
>=20

I will.

Thanks for input and help.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/vxJyxH/bynvVGrSk1pn6WTA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmYFap4ACgkQAR8vZIA0
zr1QUQgAhFjkK2SXalCk6e46NRyz9L3X+iZFaF041G61GfszCq6JzbZeRfr0GSwp
UcxoK2X5z1F9XpA3kIj3k2AriBcWMkSmkE0TaBiOHSRXT8PFrMnKGBAIEJM27w4g
Tk8osw9nSU2hh9ImpaWfulyS/8uzpZlV1SkQQX910T6FXJgP231vWK5Y02Po0iLt
urlmvJEdqr9EF/9QFuGCDzEVQDDriaocwnswxeKcI4qt445dviNZgTynwYNvMAEt
Wh3hPjQCbf1azKIfqOzBLEoww4df11ap+PhMSOPB3BkKjtRL687HbsSC49BAx/K9
onCFjVCCp6c4ZMyeph9YQNEGUJ9etw==
=zVSe
-----END PGP SIGNATURE-----

--Sig_/vxJyxH/bynvVGrSk1pn6WTA--
