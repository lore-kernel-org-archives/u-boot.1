Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30660C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 12:12:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C191A8750C;
	Thu, 11 Jan 2024 13:12:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1704975121;
	bh=XIkzFMPW6nAFES5cL5m2e88PPMC9l/uyalB9TxFFNGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nip+nBYIF8sefEQKlACeH13whCVO9mm7Ava1h2uAJi08Z61Tq1+T2vYQod4GFbyfu
	 yXo0OxVwgCFaTpjuxO8Go0E9AL8wuhIN7kSUXamjjkCUkcsbUxgwlERezxBTZCGCdK
	 mwZmRJW2fUjzrHExUE0nMviZXjP/oUjlvtH/V25r4wDfY5IQZpT43rin2mxxXJW+Ns
	 MoI59Dm59otREiMJ4uE8W0uYEB6mDpR+PFPiSU9CRoQDUSg+qHnv0y0Sg1IYNh6IvF
	 t6T9dfvxwwP/LoGVxjDrHcbqKZ1qBSToUPp6h/ck+2ZCt1pbSRA45Nva1CnNSlHYJa
	 N2uUQRE8kdoYw==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2402A86406;
 Thu, 11 Jan 2024 13:11:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1704975118;
 bh=XIkzFMPW6nAFES5cL5m2e88PPMC9l/uyalB9TxFFNGQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=FJLOgaNjo7pBu12hyNpBDxe09i9zsJINnR9R55w1lxuyfh8AblS40Oe4Y53jXj05y
 QI45cVMwvvaHhRdFVqQOGfPtKcF3c8lyLoP52v3nidCn42n9wuxTpb3+WoYTfs9VCC
 AHnIznpBhwC1m6Ny1cOrKi3inQrop+6mPcDyj7WpKmZWKpIngcKSyCpg4r7xmeTu1O
 +B+nqANhuIMqvHT6tufAo6D2Bg0ZgPtSskTlpGU1qUUTmxmc138jlXTOFhUi9u/CjZ
 owPyQQtoWEerHrd0aUEgwcWchaHDIakavxuaRfQMDwo9BnfMdXkF8YiQHrWMcZEWFv
 CY2OcEIkiVDmw==
Date: Thu, 11 Jan 2024 13:11:50 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, NXP u-boot <uboot-imx@nxp.com>
Subject: Re: [PATCH v2 1/3] arm: xea: Move XEA's environment variables from
 xea.h to xea.env
Message-ID: <20240111131150.58928307@wsk>
In-Reply-To: <CAOMZO5BgwgWPs2mn78bAC4uVQ9Dgm4mWcS5==EnRuZtOuQ6SwQ@mail.gmail.com>
References: <20240111110611.2051821-1-lukma@denx.de>
 <CAOMZO5CtLSkRPb-3RvS77za-y5zwkBirH4gGE_kwqLNao9bdSg@mail.gmail.com>
 <CAOMZO5BgwgWPs2mn78bAC4uVQ9Dgm4mWcS5==EnRuZtOuQ6SwQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dGsSfY0bND3Ry=sKpukMuUf";
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

--Sig_/dGsSfY0bND3Ry=sKpukMuUf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> On Thu, Jan 11, 2024 at 8:16=E2=80=AFAM Fabio Estevam <festevam@gmail.com>
> wrote:
> >
> > Hi Lukasz,
> >
> > On Thu, Jan 11, 2024 at 8:06=E2=80=AFAM Lukasz Majewski <lukma@denx.de>
> > wrote:=20
> > > +serverip=3D10.8.217.79
> > > +nfs_serverip=3D10.8.218.113
> > > +gatewayip=3D10.8.209.250 =20
> >
> > These IP addresses should not be hardcoded here.
> >
> > They were not present in xea.h originally. Please remove them. =20
>=20
> One more thing: xea.h had:
> "dtbfile=3Dimx28-xea.dtb\0"
>=20
> but  I don't see dtbfile declared inside the new xea.env.

Thanks for spotting it - I've forgotten to remove it after moving
forward to fitImage.

I will remove it.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/dGsSfY0bND3Ry=sKpukMuUf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmWf2wYACgkQAR8vZIA0
zr16+wgA3eT2kIZfiL3EVVmEkjIdoZ+pZVqwVOzTRcJcJi/uXzsFn/7MZrRnnRIp
LBy3Ol0m3cIm0m5hs1y3Y4glSYJQg0NUYCMsCYb6YNyDSm2JMyYoRNIqTGYcsshF
/p28xwE51lvT0IFsoSh5L0XQBaduiSFd6p2GYliKcJsmMb/wRB74zOOFI0syhvmr
56hYuOqSgRpeBPpta8DQFobZBXKbKxV9zQPlg/eKoPSN6sGRicHlHMjGBZPk3e5v
cqKRqcxOfeTVo1rYvB21fd3QREsCPF3Sy0EyDWFG3P0MdLEg7ykauxhpZYlBDoEa
1EkW84LVzYFzcd4NX+zMU4vGu8tikg==
=qgmG
-----END PGP SIGNATURE-----

--Sig_/dGsSfY0bND3Ry=sKpukMuUf--
