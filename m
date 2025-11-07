Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82898CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 16:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D422783D2E;
	Fri,  7 Nov 2025 17:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pschenker.ch header.i=@pschenker.ch header.b="Qlx/SmK5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF1D83DAE; Fri,  7 Nov 2025 17:01:20 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA1B83D0C
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 17:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=pschenker.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dev@pschenker.ch
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d33hG0vgSzk2F;
 Fri,  7 Nov 2025 17:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pschenker.ch;
 s=20220412; t=1762531277;
 bh=jVlxNDbNMBG2mjUH3QGZTU5+uUp3hyiPwoG8gJyxMfM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=Qlx/SmK5tr44N6qW90k33GrkjqaQHIla/HBUANiwaKh5Kj5KcAf9joKa66kxJLNVt
 Wv4vGcdEcUmOBL5Z254bcMs1vhvBcco2tK1so/0EBZZFmSIjbIre4tRSEHzidjN4sr
 VoVrxlgINh8vomc8SznR/Htei6Eb20Esy/cpwIWU=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d33hF136fzNbY; Fri,  7 Nov 2025 17:01:17 +0100 (CET)
Message-ID: <f429996a374f31d2d9dcdbcb8f143de18b512549.camel@pschenker.ch>
Subject: Re: [PATCH v2 2/6] remoteproc: k3-r5: cast size to size_t
From: Philippe Schenker <dev@pschenker.ch>
To: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de
Cc: stefan@embear.ch, Andrew Goodbody <andrew.goodbody@linaro.org>, Beleswar
 Padhi <b-padhi@ti.com>, Daniel Schultz <d.schultz@phytec.de>, Hari Nagalla
 <hnagalla@ti.com>,  Neha Malcom Francis	 <n-francis@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Date: Fri, 07 Nov 2025 17:00:36 +0100
In-Reply-To: <57ada562-c774-4ef2-8739-b899e5df416e@ti.com>
References: <20251107130216.3084134-1-dev@pschenker.ch>
 <20251107130216.3084134-3-dev@pschenker.ch>
 <57ada562-c774-4ef2-8739-b899e5df416e@ti.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-4xbZQsuOR0KfkE4r7Zf5"
User-Agent: Evolution 3.58.1 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
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


--=-4xbZQsuOR0KfkE4r7Zf5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Fri, 2025-11-07 at 09:24 -0600, Andrew Davis wrote:
> On 11/7/25 7:01 AM, Philippe Schenker wrote:
> > From: Philippe Schenker <philippe.schenker@impulsing.ch>
> >=20
> > When compiling for R5 core with CONFIG_REMOTEPROC_TI_K3_R5F,
> > passing 'size' (ulong) to ti_secure_image_post_process() caused
> > a type mismatch compiler error.
> >=20
> > Cast 'size' to (size_t *) to fix it.
>=20
> If the size of `size_t` and `ulong` are not the same this doesn't
> really fix the issue, just silence the compiler warning. If ulong
> is smaller than size_t on some platform we will read data outside
> the variable address when de-referencing.
>=20
> Might be more correct to assign size to a variable of the correct
> size first, then pass a pointer to that.
>=20
> Andrew

Hi Andrew, Thanks for your comment. If I understand it correctly and
explained in different words: If size_t is larger than ulong unknown
memory could be accessed. Isn't it very unlikely that this ever
happens?

At least I did interpret your first comment that way.

Anyway I will send a v3 to really catch all cases.

>=20
> >=20
> > Signed-off-by: Philippe Schenker <philippe.schenker@impulsing.ch>
> > Acked-by: Andrew Davis <afd@ti.com>
> >=20
> > ---
> >=20
> > Changes in v2:
> > - Added Andrew's Acked-by
> >=20
> > =C2=A0 drivers/remoteproc/ti_k3_r5f_rproc.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c
> > b/drivers/remoteproc/ti_k3_r5f_rproc.c
> > index c738607c1092..e7bd97a9088b 100644
> > --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
> > +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
> > @@ -341,7 +341,7 @@ static int k3_r5f_load(struct udevice *dev,
> > ulong addr, ulong size)
> > =C2=A0=20
> > =C2=A0=C2=A0 k3_r5f_init_tcm_memories(core, mem_auto_init);
> > =C2=A0=20
> > - ti_secure_image_post_process(&image_addr, &size);
> > + ti_secure_image_post_process(&image_addr, (size_t *)&size);
> > =C2=A0=20
> > =C2=A0=C2=A0 ret =3D rproc_elf_load_image(dev, addr, size);
> > =C2=A0=C2=A0 if (ret < 0) {

--=-4xbZQsuOR0KfkE4r7Zf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEPaCxfVqqNYSPnRhRjRDjR2hoXxoFAmkOF6QACgkQjRDjR2ho
XxrboQwAyI3mRk41wXIGoXJFcTu8x88RmewsA1VTM8CfkKBd5NqZqqDQVp1pfTI2
6yXb8sNgZXEG8Q2G5WYdHx4gMdsa16Jgy1/GKa6oVT2wpAtx9ErVJdvfxCiVbMb/
tOBFQEtCnaynEmqlRTcAzZYVKdbUsMa5GZdpDMnkgYvKwBoj/AboLdsQA1PeF5u5
q4LzDf8PpejjC9ST8BE9O8REyMF8YG5SXVm/9B7XC22Qdz1W3ec0CBV6HGM7NY09
jLXwI0bMGnQqFCIcZr4F+U+x9bSgu6LbW7G+3f0qdw9HAsjwgwharHh6kVaTrGy3
mfjMLJI6qyj2nIOVDFvBO0aa7nLvl6P4eEKJBPRsipNq/352ZEqCh5Gxg0XlBhmy
M9yCF7E9H2npkM/IikgHdzIk/oNz3+WeiOaE73gchL6AzB2xsoA/MMd7NhAzQtm8
alJ2WO61lk+b+sg6n2EPaFw9IEd1FdYN75PIDATdO3FrINuPzv1yEKKzqaCloYej
Y2Hgpr5V
=arKJ
-----END PGP SIGNATURE-----

--=-4xbZQsuOR0KfkE4r7Zf5--
