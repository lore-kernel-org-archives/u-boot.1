Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180A7E80ABE
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 11:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7729586EA4;
	Fri, 29 Sep 2023 13:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PSxiXu4S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FCF686EB9; Fri, 29 Sep 2023 13:44:43 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D69086E6B
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 13:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59f6e6b206fso120640457b3.3
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 04:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695987880; x=1696592680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FygbQ0ksbuSCoM25ZIYdVHw9KEqbOMcYFrqPwPtrBIk=;
 b=PSxiXu4SGkLMa7eBCUUtuLs8ZJiQPwDrz5vx3MDKs1nqreT3nmURe6+MbkJsBfTeSj
 n7caiRkpfdfgob6rbVGSAm8iHEpSRKQ2dd9ILIOZBtVBZ9A0Ib/0bEG6Ri5QkiKKZG7L
 daM4FOYEasuGnfdxDH3dfmUHlDvBfQ1UBSbMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695987880; x=1696592680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FygbQ0ksbuSCoM25ZIYdVHw9KEqbOMcYFrqPwPtrBIk=;
 b=W75AJwIuJzevVIMciLyyMqIjKG3wNk6gmFflKwfmQa1JXS6f5YqZWhH74aE/RDVSg+
 8wa5wvkJc28qHfB98wz2NmEj4bvVIpvOKwpDGacqt7uL9gvbXaK3Tb2oGgQFQIE9/P1f
 U+Kt/Sb2FtyhpfLIVTt3XrtUkUHzg9GCad/ILbY0eVA5I9SRFKX3U72zycSiN2b0kmOp
 I1OZyKE8ZbuCN6O/7hkzc1P108+J7Pwhr8K2OhBto9ksK7D+OGyWXqHPuByNNCDMASSE
 5FTpRlSnPwZCdK4JW0s9gn73YSo7cgqo7YaJ9SICX+afr+4Ah2j8ACA/37fn0A5pARUr
 EnJA==
X-Gm-Message-State: AOJu0YyysmhdcimF5vuE9ib6/Vj41+k96UZX7jvZUCQIPnPJRDiBPNf2
 WvSFjjlqTaj8pTL/e/XC6NrH8A==
X-Google-Smtp-Source: AGHT+IFmwCpvQMTz+oXVOt4WpwtE2lkHqgz8dszSBvmeEFWoff3h1HkgEIhGXA1v2Yy4eiAEaxJzww==
X-Received: by 2002:a0d:ca08:0:b0:58c:9651:8f with SMTP id
 m8-20020a0dca08000000b0058c9651008fmr4221897ywd.10.1695987879890; 
 Fri, 29 Sep 2023 04:44:39 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a39b-08c7-b2a8-b94f.res6.spectrum.com.
 [2603:6081:7b00:6400:a39b:8c7:b2a8:b94f])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a81af49000000b0059f802fad40sm3433279ywj.22.2023.09.29.04.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 04:44:39 -0700 (PDT)
Date: Fri, 29 Sep 2023 07:44:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>
Subject: Re: Please pull u-boot-dm/next
Message-ID: <20230929114437.GG305624@bill-the-cat>
References: <CAPnjgZ32+7B0SVvpE+r_c9ZyCXpkFErRJRf0uCAx-aCMuJc2ow@mail.gmail.com>
 <20230924211451.GK305624@bill-the-cat>
 <20230929092345.7h3wevfzyqwaznvt@ula0497581>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="J/S2s0HHUQ/9X+nd"
Content-Disposition: inline
In-Reply-To: <20230929092345.7h3wevfzyqwaznvt@ula0497581>
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


--J/S2s0HHUQ/9X+nd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 02:53:45PM +0530, Manorit Chawdhry wrote:
> Hi Tom, Simon
>=20
> On 17:14-20230924, Tom Rini wrote:
> > On Sat, Sep 23, 2023 at 01:52:55PM -0600, Simon Glass wrote:
> >=20
> > > Hi Tom,
> > >=20
> > > This is for the -next branch
> > >=20
> > > https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/17836
> > >=20
> > >=20
> > > The following changes since commit b05a184379631d13c4a49e423aa1324dc1=
ae6158:
> > >=20
> > >   Merge tag 'x86-pull-20230922' of
> > > https://source.denx.de/u-boot/custodians/u-boot-x86 into next
> > > (2023-09-22 11:16:22 -0400)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >   git://git.denx.de/u-boot-dm.git tags/dm-next-23sep23
> > >=20
> > > for you to fetch changes up to ae84514feee209091d331a8baaa344ed8d8e90=
5b:
> > >=20
> > >   kontron_sl28: Use u-boot-update.bin instead of u-boot.update
> > > (2023-09-23 12:31:25 -0600)
> > >=20
> >=20
> > Applied to u-boot/next, thanks!
>=20
> The following merge breaks K3 boards somehow, All have the same failure
> signature, putting the logs here of J721e for your reference.

This is what Roger has figured out here:
https://lore.kernel.org/u-boot/20230820220316.3517102-1-jonas@kwiboo.se/T/#t

And please note that both j721e_evm and am65x_evm are working fine which
is why I merged the series.

--=20
Tom

--J/S2s0HHUQ/9X+nd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUWuKIACgkQFHw5/5Y0
tyysYwwArn9F79qPipIAVPxwPttcbuXrU3y4uDR0EUZ1o2PMmbkswQsr4NEyuamU
QOZqBr/C2PP3OJwFppRyeb0rKehhqWZSIBjNBAdwW0nplvVNFHJf70zRJZU5vmZ/
m4kzmvt4rfpnytWkuDIkXZVX1JXBFrw8IpdRub4HQ9Qlxx8vxYgrd3TXZB8LNpxe
Dh4iPe6E9lXLdwaf0Ufd+Hvu8pWXNiYGpKVp5KSyBF19D1QCsBIATUIYyXeMYVth
IBSAGR/yiPcQ3j8niyGVDjjAcunih+T84Zc1yuV7cT6zGqXWftnjj77TAM93vkE1
bsgYyy6p3VOh52PCQTZ9LvZ04j/rGs3q9gF90WTSxHcmLkW1WwwjUg9TmgLbqOuU
nWjeN93wXJniaa8AGq1OUb4X7buuq1gvftUGfKXc/+MRvARoSfTkY4ULhDBz4emQ
ZzTJvYh6PKqxDttkBeTorvqlP8s5wrxXwR1Znkgw69CPcPYRg5+LiZ74Uo94X2D0
m9+exC5s
=u8nr
-----END PGP SIGNATURE-----

--J/S2s0HHUQ/9X+nd--
