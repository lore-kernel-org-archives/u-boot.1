Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19C0606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SqmqkiZn;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=gTHQkzEc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C48A80F77;
	Tue, 24 Nov 2026 10:41:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 93Yg8YeMxQf5; Tue, 24 Nov 2026 10:41:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DE73B80F66
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795516893;
	b=G2R87gCLvHfWusZ3Ccp71YnE/YekVl/ATgHXaGPGlaojC8Wedy6EVCJ28qblFyqQvb3Z
	 E9oCReJRKDx9185KjDM1InB0JrbGbAlC95Nr68A0TzZrjxsuMeZJ7c4Q7vhzuERYGpJRD
	 4uzHUoaHfmK7dSQVp43ptjDWfi6PNmlffueN4iKh2KqS4RSTOPJuG8NHuZWryBU5Cn4QY
	 BIXoJZw4DXsOHS815O8yKXWExAysqx9s9KCs8yNnO1quu3LkRxmPff6PLRKSaEcQ4MhLE
	 17aHWzWnbvLt9XX8T4q1GwQClewjD9xwfvRIYgiNKom/kuGV2gcOsbXTBLfxJO+FyTg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795516893;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Received:Received:DKIM-Signature:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 User-Agent:MIME-Version:X-Last-TLS-Session-Version:X-Rspamd-Fuzzy:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yx993H+ozR3bfSw2MgAalw7kFzjFkCqQ8yKSEYqzULw=;
	b=WB02RkFl6iToKhcXloAW7bAsKQ338oMxfFqEhYjUahlmyoNCh09l1133JlO6P2380WwN
	 xoLK4okex+hEJLbdHV8OP+CrExkEZUsmErUdvXxBR+LahI2t38lNlutUkLgZjOOmVGGO/
	 8d0wxnM4j07EyBOhWqJO7UUDpe5AzRMJnlOifRLWl9YiPmLjxZnUk92QkpMPKrfVqDGAr
	 b7gtmL9SkCJXZtlVLtYZ1yjaqJFsRiW0bHI5x0JGfpEHb0X/kp1Z4hKoQq9lAyZotH28R
	 n1b6nx7sTaet4wX2rG9fuxTu3CsZEgkYrho/MjtZAyemvca61U/LwARBlGkaIWt8Bng==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795516893;
	bh=yx993H+ozR3bfSw2MgAalw7kFzjFkCqQ8yKSEYqzULw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SqmqkiZn0q37YP9nazqpU+7xFeJPu2oB3v+s4GDOZsJzBl+Cc7XkGCYsXYHgZ8myl
	 bo5LqYFawW2wKbzWp3/NTU9riFogHB7vMWr0pTvvcXNnhMoR3kEc2lY/L2ugxeYuxn
	 PPKTiC2MXfjLT+38WyPTFSIR0YWItUAHYM1gjBcnVcggBP1FuAURz1LHnC0KQztVJf
	 4f+KuD2TOOeI4dVruR11wZpB0Jk6MFGoO+pD5MqJiYjFN/4yR6h0Cw3Wk8bpyU1h3u
	 XwwDXULKnqn51kBMrOtDU6Co9S6GDMabbdw3E3ReL5uw4VDbMoz7DHKb7K/GVwOat0
	 ctv7+D4fQW4zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE73B80F66;
	Tue, 24 Nov 2026 10:41:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 076D9D43
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E15A44077D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id baH62rPIy7xY for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 10:41:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5F81740775
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=thomas.perrot@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org; spf=fail smtp.mailfrom=bootlin.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=gTHQkzEc
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F81740775
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:41:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0830A84717; Tue, 24 Nov 2026 11:41:24 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD4584409
 for <u-boot@lists.denx.de>; Tue, 24 Nov 2026 11:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.perrot@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 702CBC4CBEA;
 Tue, 24 Nov 2026 10:41:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F2B8D601E1;
 Tue, 24 Nov 2026 10:41:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 00CA711E6ABC4; Tue, 24 Nov 2026 11:41:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795516875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references:autocrypt;
 bh=yx993H+ozR3bfSw2MgAalw7kFzjFkCqQ8yKSEYqzULw=;
 b=gTHQkzEclCw43eFOm2BkjyTJ7c6UQUWhKCJfJZcTOYHRMXwzrmiOkNZInsH2zk0SGH6ZZ+
 Ms2RihAQLlaHiL5ulCHeixKwpjo3XBQVKzeJhYjO8P4WdubVcKkTdQiMPIO3yn/UkrPr5a
 /G/5jMYkrqGCbTJR89UGaRuvSejoJLcHG8ZWs91ckLxgkw167F6mKwDAg1YoRwuUuQzLmt
 Nz39eWhtR1WpWBNaCSf1PdtdlJ376bajykeHCJEJ0PedoZ0hiDOo7tHLo1yB0dz4SsguhK
 N/GBAaA7rXy4hyk728Tgeimvd6aUXm/y3Uh+dEkxDIOjfWBnI9sYPImcEhKXiw==
Message-ID: <81f40a6691836bc14adf1e0f808f689d164918b0.camel@bootlin.com>
Subject: Re: [PATCH 0/3] riscv: Add support for the BeagleBoard.org
 BeagleV-Ahead
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de
Cc: thomas.perrot@bootlin.com, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Conor Dooley
 <conor.dooley@microchip.com>, Jamie Gibbons <jamie.gibbons@microchip.com>
Date: Tue, 24 Nov 2026 11:41:09 +0100
In-Reply-To: <auniBY7vN13FsebY@pie>
References: <20261017-dev-tprrt-beaglev-ahead-spl-v1-0-f9dfdff50f59@bootlin.com>
 <auniBY7vN13FsebY@pie>
Autocrypt: addr=thomas.perrot@bootlin.com; prefer-encrypt=mutual;
 keydata=mQGNBF+/ZOUBDAC2DghCjZvmgYcve02OG7dGZ7Iy58uEwne3LB7w7nRwdAxKw7ZaiVqwY
 O+yNGVi+GVx7oA6Wn4pv46z+QDRLQiq6OseuXhkSGCg7U/yBCUq12B/GRGO1Qt2Qi1mJJT1s+1qZ5
 Gxv6Nypz9qKVn94GM2bR1hXBga0t87vBpebThOHmX5d/0dqIcVxRCM7onNb0dDyRoVgLS5rBhQzrL
 CMrJaCy39xZUy0J1SOlH4Mgk6EhJIPYY4wlzikGX6urg+Tc9EjGd78ry0e0p5U5qgjFR5QGJDy1Gn
 U3CfwbT9sowdCASDbQDUoltlv2iWJCLa0xl97KVchCa0pr7HKbFA3J5SLKqFYUBCkFL+5WudYlz2n
 XxiUgyviMQxyK+ij66kEi6/2zFDAecd43pHV7790ptqZBC3Jc67Emj7Vo3ShX6RXPPxxbeCTOF2uk
 I45aJ9XcVFH/MFE96NjXj8uahnIsiTPyuCUoJu8tj7TSQyue874qJqVQvqlFyt2aZYJZ8ruq8AEQE
 AAbQpVGhvbWFzIFBlcnJvdCA8dGhvbWFzLnBlcnJvdEBib290bGluLmNvbT6JAc4EEwEIADgCGwMF
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSHQHfGpqMKIwOoEiGfwAsFcf4K7QUCX79mdwAKCRCfw
 AsFcf4K7fhbC/wP0kSl6id2E/K3+UdXk6CLMVRbCFLCREzQs5WFpQ6l/I0WGOamhrOgegdszheiVF
 orlUP8d37XSpFAqydhKGaN78V5Dps0Wmwm4lIlS4MtQXJtSLUHXDJLIZLW0pw8tiPLKsd1o/yDkXE
 dnpsjJTRG6SdDSHnyOB2/gh4p+yTaLytFdARk/r4/P26+L+FiH0fFl+RnBt19LPklfKgeDc7GwIif
 ja+nIWpp3W23DAUuI6xduEut25Q89yu7Ci8CliLfAiLy9bIGjBQWU2Y+1/j/7KuPj6VbBsZWLTZY0
 hUmpJSTnWAqc9SMsNxo7NSQuddgviz5e2tqucaRqxP02FGzNa8U4NAKdWaXrlHG5Dglj9XH0DK+SH
 +c96qqFewYD8VPQ6XAGxQcXbrtJmiMor1R2DfziispLRvJcfYs8xqabbCtoS3ouXB9XRi8hn7A2kh
 ME1ryS+Oh63JshXHnw6bmjCpVd/p+fGLIGU6A47pJOpviKR4jEO84pl2ejtDZ3Tc=
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-Z22/tENOrNVvbmNiig9C"
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Fuzzy: 9305407a5397f019ded38fdac93561475e0906013a9f0013509c768f0ef202b4392cb5bd37b2adbee48c06d67c8001961caea3bf96e394ce9b25c335bcc33c34
 (rule=local; flag=13; prob=0.78;
 queried=4931812b7169e4fc9c73049809faf2e4f48848a6fef05d1da802ea9bcb13df734bac1895edf5bdddbf68c768937bb66eeab4166f4bc21069c46a3c5de41ce16b;
 added=2026-11-04 19:44:12)
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-Z22/tENOrNVvbmNiig9C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Yao,

On Tue, 2026-11-03 at 13:30 +0000, Yao Zi wrote:
> On Sat, Oct 17, 2026 at 07:41:20PM +0200, Thomas Perrot wrote:
> > This series adds support for the BeagleBoard.org BeagleV-Ahead, a
> > single
> > board computer built around the T-Head TH1520 SoC (4x Xuantie C910)
> > with
> > 4 GB of LPDDR4X and 16 GB of eMMC.
> >=20
> > Most of the work is already upstream: the TH1520 SoC support added
> > for the
> > Lichee Pi 4A (SPL, DDR controller, clock and pinctrl drivers,
> > binman FIT
> > generation) and the BeagleV-Ahead devicetree, which is available
> > through
> > OF_UPSTREAM. The board therefore only needs a small board
> > directory, a
> > U-Boot specific devicetree include and a defconfig.
> >=20
> > The one missing piece is in the DDR controller driver, which only
> > accepts
> > the dual rank firmware and fails with -EINVAL on the BeagleV-Ahead.
> > The
> > first patch makes it program the rank configuration and the address
> > map
> > from the number of ranks described by the firmware.
> >=20
> > As on the Lichee Pi 4A, u-boot-with-spl.bin contains the SPL, the
> > DDR
> > firmware, OpenSBI and U-Boot proper, and is loaded into SRAM
> > through
> > fastboot.
> >=20
> > The BeagleV-Ahead has a single rank of LPDDR4X, so the DDR firmware
> > has to
> > be generated from lpddr4x-3733-singlerank.lua, which is already
> > provided by
> > https://github.com/ziyao233/th1520-firmware, instead of the dual
> > rank
> > configuration used by the Lichee Pi 4A. This is described in the
> > documentation added by the third patch.
> >=20
> > Testing: the series builds with the Bootlin riscv64 glibc toolchain
> > (2026.08-1) together with OpenSBI v1.9, and produces a u-boot-with-
> > spl.bin
> > holding the SPL, the DDR firmware and the FIT image.
> >=20
> > The image was loaded into SRAM through the BROM fastboot interface
> > on a
> > BeagleV-Ahead. Without the first patch the SPL stops with "failed
> > to
> > initialize DDR controller: -22". With it, the DDR is initialized
> > with the
> > single rank firmware, OpenSBI and U-Boot proper start, and the
> > console
> > reports "Model: BeagleV Ahead", "DRAM:=C2=A0 4 GiB", both MMC
> > controllers and
> > the Ethernet device. The Ethernet link, the eMMC and microSD
> > accesses and
> > writing U-Boot to the eMMC were not tested. The dual rank behavior
> > is
> > unchanged by the first patch, but I could not test it on a Lichee
> > Pi 4A.
> >=20
> > Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
>=20
> lists.denx.de has been down for some time, and U-Boot has switched
> to u-boot@lists.u-boot-project.org=C2=A0for development, please update
> your
> Git tree.
>=20
> Please re-send the series to the available address, so there's a
> public
> copy available to everyone, and I'll continue to review, thanks for
> your
> patch.
>=20

I resent the patch series a few days ago:
https://lore.kernel.org/all/20261105-dev-tprrt-beaglev-ahead-spl-v1-0-ba747=
2d69ebf@bootlin.com/

When you have a chance, could you please share any feedback or let me
know whether it would be helpful to make changes?

Kind regards,
Thomas

> Regards,
> Yao Zi

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--=-Z22/tENOrNVvbmNiig9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmsFacUACgkQn8ALBXH+
Cu3UNAv+LO7Bpwb4nlOO/Ri6YNlO38sN8RN66DZNYZZHxGW61JPdNIG4cb3e2mqO
GSUifGBYjTwW4qOkBqEipdyindIIea+wca9Q8Td92Gr9C8Q7f5q4em3n5UxC5Om+
ptKNjSt729AzIPlasi6Evwr8JEXXgjMDaNb+lzt54z2Nh4jisnhOOM/O0A0cLmnA
fAdHe7nopJ14yUaPgchGmUcFIsLpWR9xX/ikIQDSGeQ3fb/J3KxaW4ZZkzGMeLCC
bhS+c2HmAUXGeYWDVFs4OVzbAPHeFlM8aRruaBaXJbOHOQeP222juv5mnu8t46wM
Fp06LcNoNtQNEe7W7mffu9t3UNhfDEWF2gJfunYFEUsOnsUto0c81pMPTbcDOYpP
b/3dH9Egct5g2K5e22igQRnzZoBUs8SSnyy6Zba9NOeEkv/j2lWuIGqldqAgSTYT
QH2HOyhwJ1g7sbrf38o5G0ebetE4K97+wvvsiW2B6BYOD3MN1IbIsbV6KWUg3bzj
oxCkpRHj
=n9My
-----END PGP SIGNATURE-----

--=-Z22/tENOrNVvbmNiig9C--
