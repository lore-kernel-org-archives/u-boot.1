Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E866FE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 18:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B9B805EA;
	Tue,  7 Jan 2025 19:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D028805E1; Tue,  7 Jan 2025 19:07:02 +0100 (CET)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16A878036B
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 19:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje.mihanovic@skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
 by mx.skole.hr (mx.skole.hr) with ESMTP id 8350683444;
 Tue,  7 Jan 2025 19:06:59 +0100 (CET)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] serial: ns16550: Add Intel XScale support
Date: Tue, 07 Jan 2025 19:06:21 +0100
Message-ID: <4975523.31r3eYUQgx@radijator>
In-Reply-To: <0f39cd7a-c64c-45b6-9e69-4612b884c15f@denx.de>
References: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
 <20241231-coreprimevelte-v2-1-6a5445d92d11@skole.hr>
 <0f39cd7a-c64c-45b6-9e69-4612b884c15f@denx.de>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr; keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBG3/QdYN8x
 S1t2umMK0xk1JFj60DBQJmiSHOAhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJEK0xk1JFj60D1GABAJVSorZdMOlrp/oQtCSH/G53NE56x/JHA8VX+ZQBd/H3AP4/EcUf6eef
 DUxVMh2bdkmuQKsVZGgOGiXpMksrVntWBrQpRHVqZSBNaWhhbm92acSHIDxkdWplLm1paGFub3Z
 pY0Bza29sZS5ocj6ImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSH/AhsDBQkJZg
 GABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw8A/i4lPOL7NaYoYePDq
 l8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xqh2MRcNmJCHA1YhWAbg4
 BGaJIc4SCisGAQQBl1UBBQEBB0DEc9JeA55OlZfWKgvmRgw6a/EpBQ8mDl6nQTBmnd1XHAMBCAe
 IfgQYFgoAJhYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSHOAhsMBQkJZgGAAAoJEK0xk1JFj6
 0DG5MA/iuo4l2GDEZ1Zf+XaS//8FwdXDO9nHkfbV2MHjF4NZXwAQDroMzBdMcqVvc8GABFlTTgG
 j7KrRDz2HwWNyF8ZeprAQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Tue, 07 Jan 2025 19:09:06 +0100
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

On Tuesday 7 January 2025 12:30:40 Central European Standard Time Stefan Ro=
ese=20
wrote:
> On 31.12.24 17:49, Duje Mihanovi=C4=87 wrote:
> >   	{ .compatible =3D "ingenic,jz4780-uart",	.data =3D PORT_JZ4780  },
> >   	{ .compatible =3D "nvidia,tegra20-uart",	.data =3D PORT_NS16550 },
> >   	{ .compatible =3D "snps,dw-apb-uart",	.data =3D PORT_NS16550 },
> >=20
> > +	{ .compatible =3D "intel,xscale-uart",	.data =3D PORT_NS16550 },
>=20
> Looking at the Linux 8250 of_device_id struct I see this entry:
>=20
> 	{ .compatible =3D "mrvl,mmp-uart",
> 		.data =3D (void *)PORT_XSCALE, },
>=20
> Wouldn't it make more sense to use this compatible property instead?

I was going by the logic that intel,xscale-uart is more generic. They use=20
identical platform data, so it would be no problem at all.

Regards,
=2D-=20
Duje



