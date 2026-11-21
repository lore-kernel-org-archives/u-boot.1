Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E96606A320
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=euSBslOG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C174F606B1;
	Sat, 21 Nov 2026 22:35:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FX3Bv3uygvxb; Sat, 21 Nov 2026 22:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D6C86061F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795300509;
	b=bC75QrMl0nOlBeXbnqXfBIiR4hdcvAEHKvaqSMU6ZGXDHymdO7WKL0hcWyu7/ChCGIjK
	 6fi1Y6u7lfmKSdHu6PGoT27Nnh3oSSrFDqoqtCOoBi2nNXdg/3TuFbPX1+VPkxDSj9n/C
	 ABBqMolIwedGr/+dP8Y+FW5Z01kp5OWtJpYkh1zDmtPcpUtv8wXuZdPwhIWSNselCxBJn
	 gez4gdcThMvt/uVK8PkbC5G7qL7cl1YAPxJ37zy2l2AcoaXEP8mrHs4L4f6pWZ0//iXOD
	 i0riViMhAc6OHCiSG5rfpf91cqGc6AScMRtGWaJWuD9duxWEE6f28EMOMcpPUIeZATQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nflOSq2xh6evPuVTaxDD8/LD+8ZlkWLFxVH9apSPBgo=;
	b=K+0aPUs/aNLKtSW9X++Mtq4OgZCGxk8WayqEBVcT1ht2uUIP9fB42eaQhLXkP3O8rS+E
	 3QrWzwGeYNgL1qsbjOJx3vCGP3ZWcmQv8OyAIGQykFdUjVcsk5Sqq1xf0F2Wn7laagMxi
	 q4Ek1niB+JCexcGvPQhtLKzz1CF4uRuB38CSQt6ci3FDAYY9tmsQkZ2PDim4AOXM2cZOu
	 jKZQC+wP5F+6oHuNy2FbJtH8H0dPLwYJc4Vt5/iQZtE6hs57PucpkKctHwxhTuQxoZ1tf
	 HNZlgAA4JOcTiPl27GgT61qeWtKRgdfAtAFwz+tPMqVCr+4lp7WaXsGmS96Fncq9VRA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795300509;
	bh=nflOSq2xh6evPuVTaxDD8/LD+8ZlkWLFxVH9apSPBgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=euSBslOGNItJVPPeYOhcp+G9Yw5haPFDP4FWE/2STy6rlBwSRfZhXwddyp7dBfxU6
	 poUdW2O6XkCxXqTdTNDSY4p+4voiG3yoLdVQJzw92/R1ZYnf1xLxib66mwvGxKnvrf
	 da+m+XaADkblft8hS9YyVpuhT1JChufPcKo6zBaN43VOj/B2zEIFf11S3R1VSNqqEV
	 4TSua+zZe3AE1BkslNFYH1GYsZjLxD05w2CpfzKEytVzz5yYREVScd7THL4atl/nGi
	 t5SrV6LsWHSnUYijC8s26VOrw2OcyiWfQ5Qoocd2x9lI3MFw3k8B6dD0quoDkL9Bun
	 Jz9NRGHWIxnuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D6C86061F;
	Sat, 21 Nov 2026 22:35:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 95270499
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 86B5080E15
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fU31NeJRNiyu for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 22:05:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8B38E80E0F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.233.101.22
X-Greylist: delayed 404 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 21 Nov 2026 22:05:22 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.233.101.22;
 helo=leonov.paulk.fr; envelope-from=contact@paulk.fr; receiver=<UNKNOWN> 
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B38E80E0F
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 22:05:21 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 8088D3700F66
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 21:58:34 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 059D1B7F136; Sat, 21 Nov 2026 21:58:32 +0000 (UTC)
Received: from shepard (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id 2D851B7EE70;
 Sat, 21 Nov 2026 21:58:32 +0000 (UTC)
Date: Sat, 21 Nov 2026 22:58:29 +0100
From: Paul Kocialkowski <contact@paulk.fr>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] net: sun8i_emac: exclude the FCS from received packet
 lengths
Message-ID: <awIUBe7Y3znD9C8A@shepard>
References: <20261109-submit-sun8i-emac-fcs-v1-v1-1-fb0de3d8147c@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EBsqxu9YRqyylhtA"
Content-Disposition: inline
In-Reply-To: <20261109-submit-sun8i-emac-fcs-v1-v1-1-fb0de3d8147c@gmail.com>
X-Mailman-Approved-At: Sat, 21 Nov 2026 22:35:08 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--EBsqxu9YRqyylhtA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James,

On Mon 09 Nov 26, 01:06, James Hilliard wrote:
> The RX descriptor length includes the four-byte Ethernet FCS. The driver
> does not enable FCS stripping, so subtract it from the length returned
> to the network stack after checking the complete frame length.

Looks like a good catch!

So there is a STRIP_FCS bit (bit 28 of register EMAC_RX_CTL0) that is
usually set by the Allwinner BSP Linux driver. It would maybe be better
to define the bit and use it instead of receiving the useless FCS and
tweaking the size.

However the mainline Linux implementation seems to assume that auto FCS
stripping (called ACS) is disabled (and does not clear the bit).
I don't think the unit gets properly reset by Linux before use, so this
could have bad side effects. There is a soft reset but only done for
chips without an internal ephy.

Feel free to check if this approach would affect Linux or not if you
prefer it. Otherwise I'm fine with the current proposal, but I'll see
what others think about this.

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>

All the best,

Paul

> Otherwise the wol command treats the FCS as an optional four-byte
> password when an Ethernet magic packet has no password. A four-byte
> password is instead exported as six bytes containing part of the FCS.
> IPv4 protocols generally hide this error by using their own lengths.
>=20
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/net/sun8i_emac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> index 41c52f56d7a..0199e2b5c30 100644
> --- a/drivers/net/sun8i_emac.c
> +++ b/drivers/net/sun8i_emac.c
> @@ -518,7 +518,8 @@ static int sun8i_emac_eth_recv(struct udevice *dev, i=
nt flags, uchar **packetp)
> =20
>  	*packetp =3D (uchar *)(ulong)desc_p->buf_addr;
> =20
> -	return length;
> +	/* The descriptor length includes the FCS, not part of the payload. */
> +	return length - ETH_FCS_LEN;
>  }
> =20
>  static int sun8i_emac_eth_send(struct udevice *dev, void *packet, int le=
ngth)
>=20
> ---
> base-commit: 1ed1749575f28b406c241218eb6a200574574a25
> change-id: 20260928-submit-sun8i-emac-fcs-v1-5b0185c991c5
>=20
> Best regards,
> -- =20
> James Hilliard <james.hilliard1@gmail.com>
>=20

--=20
Paul Kocialkowski,

Free software developer - https://www.paulk.fr/
Independent contractor - sys-base - https://www.sys-base.io/

Contributor to fully free software support for selected hardware.

--EBsqxu9YRqyylhtA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmsCFAUACgkQhP3B6o/u
lQy6zw/+IHUQF4Pt7Lk9Ymok6dhewkMssXZLMc3Fg02kPDZ5VLEKVhZ+YhNZR+hQ
SJdh+rNyPViulZwOeTTT2PbbC/lCGCGS0Fbds8k7jP+vQNtJWHxpkmtH8x1yyKKz
CUtbYvhb9jd474B90c63nZG/pLMtD6Qm8yTeuqRnbYqEzBSqjzWZFVptib6WzNx8
zO1wv935hEOIaOm1NjMHNJzhUtgqTYCtzgx29zRtBUR8YfUEKjoVfUAJyu2+OOqY
0vgka5VE3hjwAKXlu8D0ohA7RS/xTgKC6mdSybFldbqWp8J6oY/2zAqoKLJhZ9Ae
F4mknQXohJcBfi7D0tKZaDX8AbIrv5h1yiFeXL6R4Cwf9dlyKkhgqb5OmrYldmUB
zve7/BDpOakXxFNUGgTdtQvtO6sc09c5mLa3GRbi8vBvZZrUF31qu+y6HK2oxoId
QUWkOaOHXcIztrJndNDKANouLLmu+PU+BbF6mAewpTHGsoC6ciRuZTZil5RUTf2D
LZi1cDbvvK7bWdU765Sz8HKqELpkW/te/TAfKZKxIqy1QV19URXPWuuKcnkXqqJM
JLK9tKGfgMf1fl0Wpxg6QX0FgmYdUuDULOfSgZeAjh1YDkxpHaLmQm78OpwZkqMS
91ToWM6vcfZnBcmI42uMHnUTCC7PIR6rV43Xs3dDa8T2vX18aI4=
=GLZF
-----END PGP SIGNATURE-----

--EBsqxu9YRqyylhtA--
