Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575E6C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 14:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B745D8818E;
	Thu, 28 Mar 2024 15:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BXfPPQVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F16258818E; Thu, 28 Mar 2024 15:19:04 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00FEB88188
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 15:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 028B9CE2B72;
 Thu, 28 Mar 2024 14:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E894C433F1;
 Thu, 28 Mar 2024 14:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711635540;
 bh=12XoTqCVB6OsA23jwH/GgKsouxYbvYUGpR/xFujmHd0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BXfPPQVSlOCWG/biejJlAraeeA7cJFtOMYtob4np7kjqjwKsTgs7WgrInEe8MLapm
 F6RhxfpCl/n8e51AYNNRq5qUpkhdSWzntPsdNMEOiJxGXF0p6I0awSZMqa0iS1ApJN
 XSG9nEtz/BFS2tCggL5zRZhRpEwCW3KsA3JfaoSKBjEV/eL7C0TKpbEDU2XBBJcnEj
 ZVe/ve+/VwZsMTfvioMnWzqb74SVm6o1670QDpDDHHegB0BEee6FQFoTMC2iXU/p3i
 Ba8nfI42vCc5Bb1GokqpG7gaxfeNH7wkEUuLWqhTr6Qvc1eYyFuBYRpb4sh0ZuZOqj
 JAHT9uISWKexQ==
Date: Thu, 28 Mar 2024 15:18:56 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-mvebu v3 11/18] arm: mvebu: system-controller:
 Add support for SYSRESET
Message-ID: <20240328151856.18f5a488@dellmb>
In-Reply-To: <16784d38-8456-40da-9ee1-180c10e8d905@denx.de>
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-12-kabel@kernel.org>
 <81922125-aa47-4be2-9e0c-c7dfd57c4ebc@denx.de>
 <20240328122133.12b0e83f@dellmb>
 <16784d38-8456-40da-9ee1-180c10e8d905@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 28 Mar 2024 14:01:22 +0100
Stefan Roese <sr@denx.de> wrote:

> On 3/28/24 12:21, Marek Beh=C3=BAn wrote:
> > On Thu, 28 Mar 2024 11:04:45 +0100
> > Stefan Roese <sr@denx.de> wrote:
> >  =20
> >>> +static int mvebu_sysreset_request(struct udevice *dev, enum sysreset=
_t type)
> >>> +{
> >>> +	struct regmap *regmap =3D syscon_get_regmap(dev->parent);
> >>> +	uint bit;
> >>> +
> >>> +	if (type !=3D SYSRESET_COLD)
> >>> +		return -EPROTONOSUPPORT;
> >>> +
> >>> +	bit =3D MVEBU_GLOBAL_SOFT_RST_BIT;
> >>> +
> >>> +	regmap_update_bits(regmap, MVEBU_RSTOUTN_MASK_REG, bit, bit);
> >>> +	regmap_update_bits(regmap, MVEBU_SYS_SOFT_RST_REG, bit, bit);
> >>> +
> >>> +	while (1)
> >>> +		; =20
> >>
> >> A comment before this endless loop might be helpful here. =20
> >=20
> > The code does the same as reset_cpu() in cpu.c, and the while() cycle
> > is not commented there. =20
>=20
> Sure, other code might suffer this undocumented endless loop as well.
> And again, this is more a nitpicking comment than a real requirement.
>=20
> > But we can add something like
> >    /* something has gone wrong if we reach here, so we may as well stay
> >     * here */
> >=20
> > What do you think? Could you amend the patch? =20
>=20
> More something like this:
>=20
> 	/* Loop while waiting for the reset */
> 	while (1)
> 		;

As of now I don't see a need for v4.

I may sent another patches regarding DDR training, but it will be
made on top of this series.

Marek
