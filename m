Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529BCC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 14:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64136849F3;
	Fri,  3 Jul 2026 16:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XJnYPy1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F63849F6; Fri,  3 Jul 2026 16:11:47 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803A3849F0
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 16:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-440df1c768bso313716fac.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783087904; x=1783692704; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JrckreneNuf+f4h0QU3wTD+tkk3tNX02WR6MQ7zY0f8=;
 b=XJnYPy1vav8V2q8QC0cs3i49ds1C7B9J+KGUhj0KZggRZ2zYtvMjjKVbsI1cqaySgO
 UZNi32v4NO62dggnFasT2ep2GhhOJD6yoxJczutO1djpd7LxtIGSMBy2Gai60HchB39E
 eEjdVpfG+ur+KdBITLqh3hJGrmoJZLXzFr1W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783087904; x=1783692704;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JrckreneNuf+f4h0QU3wTD+tkk3tNX02WR6MQ7zY0f8=;
 b=ZS+EdhlfsRcxGh3FJtNuitk0OTEB+B5LT2x+zGtlx/xTa9cyWorokeRzH96ybjzNbY
 bzYIWaIs0RpuOil5z96YJWwa1u+CKU0kBzOpIazdu7B+eSuUuRxR6hhCu3oBbO4XpIMz
 ya7aK+s8Cd2XfRsIU/KEWnZ+++j5ZSLGHpslYJySyqtYv5TlPj+tBZks5buH3KUmrQgl
 H/kWD0CF4YuQ1hu1X971bVQdjB+PQwtaY0AurSb5zmQupG6x4nx65HN/wzlBnqhsEsRm
 2NJ5iSo9l7Nc+g6pa9MmaYp3qqn0t6gf3Elx7FFv6t9bpUbwaa6muVNzBTSp02ROME5p
 VwnA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/3tkwk3LxFG2s7914HVpCy7whjkdABplwkQiX1wGtBFTHaXJ0vME/uXK9zS0uwGj7qn98FPI=@lists.denx.de
X-Gm-Message-State: AOJu0YwhToQX4myXWNyy3sswh6XghVk/NIxqJQg/fniLcUKikUayorhL
 Mat8JC1FhnFqCGSAoteGmTfTpOsdU1T9dV/IU45/q8hPBfPPetO3TanJtdB/TdUy66I=
X-Gm-Gg: AfdE7ck545yXR/LNdtlw3M1C7RkzFjLo6PNnzr2KIAPJWqgAue07UPlcTlicSqSvOwY
 6d2OYuFZZtIyz5/M/uDmB/TtWmNdRLmAkLlhnORv5+U2aL/6NYPQXmv+RIGQS9OQcqjAwZ8eZl4
 L0FqbsVI9KybIES+YHmtqMcS0I+xJcuPYEEatceiuWip2nuaKqJF3SgfADklXpfzXuUwHSYIJa8
 +KBiRHnRQ4BEaY3JvVVnnhuVHmgCuuGTcnTU1aDY6PrIOpH4MBx6jx44bZa8Hl4yvL2iMUwNtWU
 7QnntsMiar7XUbrQ/QC/ar6mz8Gqr8cv1wbQjuHh70grVanW49Qy4J0iwB1+vh2p1+fw8pwQcJX
 sVc7ZPXrLhUa5xbzM1/Xeb/cD6T/02RIotKGHPHjHnseEoMOWlaYPE9Zp0NfabrW54ew/P2AyjD
 U8DeU9lboTRLgx/orfVxuxgVvAEWnFrg1Cpqe8RKsGW7Yth9qe4wTKRkjGxehEFUfsr9A7vABUN
 v3/5t32DeMGAl8AXbgmKR4yqllmV3MmSV861Q==
X-Received: by 2002:a05:6870:9723:b0:44c:6af5:4a33 with SMTP id
 586e51a60fabf-44cb45c3c73mr6230799fac.24.1783087903970; 
 Fri, 03 Jul 2026 07:11:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb5db92dsm2006556fac.13.2026.07.03.07.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 07:11:42 -0700 (PDT)
Date: Fri, 3 Jul 2026 08:11:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Takahiro.Kuwano@infineon.com
Cc: ssunkkan@gmail.com, vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] mtd: spi-nor: Add Dosilicon DS25Q4BB support
Message-ID: <20260703141140.GI749385@bill-the-cat>
References: <20260614134406.542-1-ssunkkan@gmail.com>
 <5787d9d649b34f74b66a56a067da9760@infineon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8EJIesesLld05RXQ"
Content-Disposition: inline
In-Reply-To: <5787d9d649b34f74b66a56a067da9760@infineon.com>
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


--8EJIesesLld05RXQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03, 2026 at 08:11:48AM +0000, Takahiro.Kuwano@infineon.com wrot=
e:
> Hi,
>=20
> > Add support for dosilicon ds25q4bb (256M-bit) SPI NOR flash.
> >=20
> > Datasheet:
> > https://drive.google.com/file/d/17UFJa5_3imH0YmWlRGTQYhO2JBXf4Klk/view
>=20
> Do you have a link to vendor's site? If you have, use Link: tag just above
> your Signed-off-by: tag. If not, please write this after the '---' separa=
tor.
> I don't think it's good to add a link to share drive in commit descriptio=
n.

Yes, this is not a good idea, we need a link to the vendor, somewhere.

> > Signed-off-by: Ssunk <ssunkkan@gmail.com>
>=20
> Could you sign with full name?

Just like the linux kernel, we don't have a "full name" policy anymore,
so this part is fine.

--=20
Tom

--8EJIesesLld05RXQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakfDGQAKCRAr4qD1Cr/k
Ck+dAQD5zCBOK4v64PZrt5Cfz0ZQhOcsjpRY7Xy1Il7HN7rK0QEA6IbLleDK+GXA
Fc2EsileZbtQP/8Y3wEaauAXXkx9XAE=
=N+AL
-----END PGP SIGNATURE-----

--8EJIesesLld05RXQ--
