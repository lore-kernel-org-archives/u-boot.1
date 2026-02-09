Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407C7E7E0BC
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54CC2805D7;
	Mon,  9 Feb 2026 18:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KkOWwruq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E0BE8397D; Mon,  9 Feb 2026 18:43:20 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8F380325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-40438380b88so3104911fac.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770658996; x=1771263796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wIBsWMkXIXwhfZRZ7hLUzEc5gSmm9xZq2QUCifteoN4=;
 b=KkOWwruqvsYIKtgmUjVKKQsJ9lzD+H+WP55SBT3mbmcT25QV9DyDt/kaQZSR6KlPf2
 T7Am2d3TN1YVu4yyaW0DQF6AsjWzGBRslvRivIA9hs07ETbuQBQau+s8J8jnjUPef8yL
 UPQDlScTxRfn6dk3C/1L+zEMVDzyPAx7HRUBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770658996; x=1771263796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wIBsWMkXIXwhfZRZ7hLUzEc5gSmm9xZq2QUCifteoN4=;
 b=RGmBGIdy92/3zV1aCXcJi2edEw9mVMfSn//nzB6s6WLhaSZQI0t4T8mym5tAeOj63z
 fJ/gM1ch3VJEtZqe5oE5gJGpO3JTUivihhSOAWWZC7lmjQc0VXWkeOW6Ua03iqqBpw5e
 p/FrsDfJagKq9PIEBW/XoONQ9Do+gJHmnOIgIlHCbZ+bNkkT3MmUuRXOD7qH+t8DuuWS
 PgIbUKKQfAH/f6wi64196FTF0fQqA8cQNADzYB1NSgUPGEMFr7LHSo0d7KJXzBMNNuBR
 JIrkPucNzE1Rc1QBF2/Vu0LRiGYpUDeog+EwvAIs1prVeyfNj2JOIjN97J7Zo3HvtJZO
 +lmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWabb0sck6/eoOXEWGXIlM3z4YLIAvArIbRMl2klsrmFiv1amsUu83Be0my2DvHOVfvxR6XFh4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8d6+5iiGEVUAVfY0wjJ8OShnCQMFiucvZOuXe/5aWQi5Lvf+6
 hukDEM+TVr7niKQeXpzA77FvGCHRLcyfVwQI0Y7zePZwNJ4Ek/9tFZu465TlsnKVf+Q=
X-Gm-Gg: AZuq6aK00sxueIbdMSlHyodLTWs85/EAivQUrMCHtGBKjs3IsnaXZliAFXIr1gLIAGe
 F4G8v4v4NFLWOld/Xdi/2NffFIshz4Ob2rg4qQsHg+svVyPDsWyy0XHKygfuBLplF3OqGo0jnsI
 4cr6KU/UZLD1HwuYaij0J3Q1/SaWFdbDQewnzTa253Yh1DexwxG/H2cNpAmgy7ZT8tDIVSIr+nt
 mywvXs7HXtUJLnbVRj/1Jwo5DC4xpDPkSxQrVymhQWNdyxvqvXBtSvTijC0nDw/1UmhSI3lHCfi
 OVYhWexJeaihDuccjbYEHV9nzg1AutOmLYC7ZmtfP8vH3ZJpm2kB2nWAP0JU876MyVLZOLtHCKB
 7yC6GBdntdEpRaxZokJtoSco2dgT0M0ddzi7zDFK73VsQSVMxF/QpcnkxIH4ZrYCxDaxpd+WF0/
 76abzjm+GcSIue3LMaTG4jZIATx0psj0fAwGSoO6S6ArSDy6EgOUiiuvmNZ2W8UBGVeVjRB2+LN
 kcyzi3+qIxj/VBM44uSOG2WNLe12p+3j10J4VQ=
X-Received: by 2002:a05:6870:d24e:b0:3ae:f15:5dfa with SMTP id
 586e51a60fabf-40a96f938acmr6459099fac.28.1770658996049; 
 Mon, 09 Feb 2026 09:43:16 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a996429c3sm8035804fac.12.2026.02.09.09.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:43:13 -0800 (PST)
Date: Mon, 9 Feb 2026 11:43:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 n-francis@ti.com, s-tripathi1@ti.com, k-malarvizhi@ti.com,
 kamlesh@ti.com, vishalm@ti.com, d.schultz@phytec.de,
 w.egorov@phytec.de, ggiordano@phytec.com
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
Message-ID: <20260209174308.GG2603314@bill-the-cat>
References: <20260209083855.GA9367@francesco-nb>
 <20260209084529.GA12200@francesco-nb>
 <20260209100851.abaf46pr77uq46zi@ula0507357>
 <20260209101635.GA28492@francesco-nb>
 <20260209172546.GA281089@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zxM54LGCVKZxq+Y0"
Content-Disposition: inline
In-Reply-To: <20260209172546.GA281089@francesco-nb>
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


--zxM54LGCVKZxq+Y0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 06:25:46PM +0100, Francesco Dolcini wrote:
> On Mon, Feb 09, 2026 at 11:16:35AM +0100, Francesco Dolcini wrote:
> > On Mon, Feb 09, 2026 at 03:38:51PM +0530, Suhaas Joshi wrote:
> > > On 09:45-20260209, Francesco Dolcini wrote:
> > > > + Bryan, Anshul
> > > >=20
> > > > On Mon, Feb 09, 2026 at 09:38:55AM +0100, Francesco Dolcini wrote:
> > > > > Verdin AM62 and AM62P are not booting anymore with U-Boot 42b3ee7=
fa524,
> > > > > everything was fine with b5213bbfdcb1.
> > > > >=20
> > > > > Looking at the commits between the two revision, I would say that=
 the
> > > > > issue is with this series https://lore.kernel.org/all/20260127081=
652.506357-1-s-joshi@ti.com/
> > > >=20
> > > > We have also commit 3382d75f7a6c ("arch: arm: dts: k3: refactor com=
mon
> > > > nodes to k3-*-r5.dtsi") that might be the root cause for this issue.
> > > >=20
> > >=20
> > > Hi Francesco. Unfortunately, I don't have Verdin line of boards with =
me,
> > > so I cannot reproduce this issue. This is also why I wasn't able to t=
est
> > > my series on my end and had requested board-specific maintainers do t=
he
> > > same.
> > >=20
> > > Since I don't have the boards, could you run the following test to he=
lp
> > > us ascertain which of the 2 suspected commits actually broke the boot?
> > >=20
> > > * First drop my AM625 Verdin patch, and compile and copy the binaries,
> > >   and boot.
> > > * Then let my patch remain in the tree, and remove Anshul's refactor
> > >   patch, and try the same thing again.
> > >=20
> > > This could help us ascertain which commit broke boot, and we can try
> > > fixing from that commit.
> >=20
> > Sure, I can bisect it.=20
> >=20
> > Do this difference in the logs
> >=20
> > Failed to set clock rates for '/a53@0': -22
> >=20
> >   vs
> >=20
> > Failed to set clock rates for '/a53@0': -61
> >=20
> > ring any bell?
>=20
> The boot failure start with commit 2ffab9da9142 ("Merge patch series
> "Firewall ATF and OP-TEE memory regions in Sitara"").
>=20
> With commit 24338c81ec2f ("arm: dts: k3-binman: Use configs for
> ATF/OPTEE addresses") the board still boots fine.
> I have some concern that this commit is changing something, however
> CONFIG_K3_ATF_LOAD_ADDR is 0x80000000, while before in the dtsi file it
> was 0x70000000. I tried changing it back without any positive result,
> I just got an EL3 exception.
>=20
> Any more test I should do?

Should I revert that firewall series, at this point?

--=20
Tom

--zxM54LGCVKZxq+Y0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYocqQAKCRAr4qD1Cr/k
CuVBAP9v43FOQPg0oa05sJa+SuxYjqOjFicbf2XsN4R5LEKhhwD/VA7EdP/ITHEP
8hHlFA4igTMUJlkRemon7vgEgNkrsgg=
=AB3C
-----END PGP SIGNATURE-----

--zxM54LGCVKZxq+Y0--
