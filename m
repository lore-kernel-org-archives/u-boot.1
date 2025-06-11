Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FD7C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 07:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 012DC82B63;
	Wed, 11 Jun 2025 09:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1749626074;
	bh=y1j5NpUgQHXv5nbLsagzDBhCNyMdpnmG4n9NeYgZuXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NEoxgKRm80NFFgoAq55lJRR8QERWe+LimX9u5nkPjR0MW6RndP2/KrY2xWB6j/S20
	 W71Qifk6XODx1XAmhfMdCh2mOo3M6Rx6brenF7iYQRq1/9gpbrj4LMscCwmcb38+6C
	 Ud4gcKLfObCHD+LokrJZA2WJZCaIOD6Djw366PEJnyBocaLMr502bUnHPLEZs10ReL
	 1J7PfFiy1VGYKc9J53HXdpJoLniOLG4lClPLqSCSCHnH5JkN3W+bESzsq0/PUqmqgY
	 Q2R7YDq8djV8um4fpyVXGfQ9dS/CknryAidoqgZJbTtqSt+vsbDlgQTStb5ulYq6NK
	 lv75SrJLOMbew==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D9482B70; Wed, 11 Jun 2025 09:14:33 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F29B82B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 09:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BNJvd78/"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E50D71039729E; 
 Wed, 11 Jun 2025 09:14:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1749626070; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=y1j5NpUgQHXv5nbLsagzDBhCNyMdpnmG4n9NeYgZuXg=;
 b=BNJvd78/7+jimwTcxWKUotoJZYU+jmPDbKmm3ogCFZh7pokZgCPzH2cccVzNIHbZJ8uulx
 vKi7HdSc9lxBx1mTQ099nqACYgvceOxd/X/4OB4jr0gOBeiYyyVdpNeyFkMWljuTeBWA1H
 xcYrHDS522LC4CbRcC0Nt/XSUD5Of2pVfmfWzEb3L55jVxv91GG13ayO3ufEE34vtx0+FQ
 c4pwdQGf/umWWcLcJqgYPQ2G3I7xF7tieDDsA8KPfhCppteBWJZm1HFUDlY5FRzlKrV2nS
 Q9v/BmtktNQdZ+9T/fMrP3Pbd8fttr4mzJZ3Y3vZku97ygoWJpDUh0Kffhr4Ig==
Date: Wed, 11 Jun 2025 09:14:26 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Ivan Pang <ipman@amazon.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Casey Connolly
 <casey.connolly@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] dfu: fix dev_part_str for file operations
Message-ID: <20250611091426.2976d2b3@wsk>
In-Reply-To: <20250611050127.38011-1-ipman@amazon.com>
References: <20250611050127.38011-1-ipman@amazon.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Kz46/TVi2X5vs.EQvvsPh.n";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3
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

--Sig_/Kz46/TVi2X5vs.EQvvsPh.n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ivan,

> The third_arg for a dfu alt is read as an integer and is overloaded
> for different supported backends. For ext4 and fat, this third_arg
> represents the partition and forms the dev part string, which should
> have its partition in hex. This commit fixes dfu ext4/fat usage for
> devices with ten or more partitions.
>=20
> Signed-off-by: Ivan Pang <ipman@amazon.com>
> ---
>=20
>  drivers/dfu/dfu_mmc.c  | 2 +-
>  drivers/dfu/dfu_scsi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
> index c19eb919388..a91671755e1 100644
> --- a/drivers/dfu/dfu_mmc.c
> +++ b/drivers/dfu/dfu_mmc.c
> @@ -117,7 +117,7 @@ static int mmc_file_op(enum dfu_op op, struct
> dfu_entity *dfu, return -1;
>  	}
> =20
> -	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
> +	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%x",
>  		 dfu->data.mmc.dev, dfu->data.mmc.part);
> =20
>  	ret =3D fs_set_blk_dev("mmc", dev_part_str, fstype);
> diff --git a/drivers/dfu/dfu_scsi.c b/drivers/dfu/dfu_scsi.c
> index 9f95194784c..7ec34a8f7e3 100644
> --- a/drivers/dfu/dfu_scsi.c
> +++ b/drivers/dfu/dfu_scsi.c
> @@ -96,7 +96,7 @@ static int scsi_file_op(enum dfu_op op, struct
> dfu_entity *dfu, u64 offset, void return -1;
>  	}
> =20
> -	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d",
> dfu->data.scsi.dev,
> +	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%x",
> dfu->data.scsi.dev, dfu->data.scsi.part);
> =20
>  	ret =3D fs_set_blk_dev("scsi", dev_part_str, fstype);

Reviewed-by: Lukasz Majewski <lukma@denx.de>


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/Kz46/TVi2X5vs.EQvvsPh.n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhJLNIACgkQAR8vZIA0
zr0+8Af/Tg+gG+482EkcB731glAhbQkZQAkSOdRFwytUmvTdCOLrhH1dJLa0+0aT
gaF3ps2FdWchxFgUcfx5xjPQAxP373y3PPnBMsifgqY2MjnsxYZeX6H7iOBXvfvb
Mn/H2jpeQxYCwBRu3ZKJWqdfcBxqKObTyoK45PIi6vM9HHzkJzKRZRm9pwGHB04x
MSq5+SfKPkyksr4/Vel7NPlklqv76SXc1TNCihvdirwpxohrz2D5gzaEazCNJo+8
/NcKkd3CkXShO9desJe70amKsIBgqWP8eHSkWEFJrBoHH4bQetbdk4fGBi2U2pQV
K7qSws3l916+BNIB8eFn67aGY7YuKg==
=05l6
-----END PGP SIGNATURE-----

--Sig_/Kz46/TVi2X5vs.EQvvsPh.n--
