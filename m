Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D87E9A02D
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 18:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5EDF83C32;
	Tue, 17 Feb 2026 19:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RuoKZPOa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0EDA83CB5; Tue, 17 Feb 2026 19:14:05 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84C0783981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 19:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-463f00cda04so883519b6e.2
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 10:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771352042; x=1771956842; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+N4JbbQiuu2nMFvuZBiBaMVOt7NGzdC5HOMwdMxZFXo=;
 b=RuoKZPOaDatearIASoFqt6/rApV/sAdJKbJ45UsGPY1cB0CsoVzQm0d55KlA12MEAQ
 14WNlkEIOF5wQ8IPuFKKeavlXMQiIEDiH2Br7D7/xEPjIcFLBtrHA9dgjD3QAfO73Z72
 o1d9bUsqcG32n5RNqqlCILFHpG29kzGSnGl3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771352042; x=1771956842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+N4JbbQiuu2nMFvuZBiBaMVOt7NGzdC5HOMwdMxZFXo=;
 b=I01XcspatQ/JcYfhDCpX4k514FwjOXBEMHK9iYPfCfxEbzBQcQ4BhUESIel+1reapp
 jipxQv2VP/DH/zbUd4xzb/Sn6HrEhg/sx2fcOwEKIamo1w7DAvLbklu+Dfyq8KkBpXXR
 GrfdCAkC7LFWk5Dt8aEAK48gnrO2FnhU/o/Uz6lPpoYCSAQywkpbnsgPDNJqWrq+iGl6
 ZSbMeAE+Nqr29FgdW+Q8CLjnVtRXBRBPaBoSVj7zYn1CNLTTAaoS8M5nTnDC6YCLGLaM
 bHll+RBp59CdhipbvgiryTO2rzUi8SH8klbs38T/rntHDnb8N4pLIIQvekainfDsGjHq
 NHhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8d4bZP3gMLcAsuwANgMxb85Tt1CozPC3FHve2Xq8diC6vtcjOSLtAOfT5ftKBVZ/0ZY4MMV4=@lists.denx.de
X-Gm-Message-State: AOJu0YzvvrXS9pw9mLxsRW2wC6DXv7i+n7SY7yjZwsybrEWxgWH3zSFQ
 /ElqgS2rz9GNTcUMzsMzG1bj/UJYM0xzxmBXK6UkGkNIsnIP5XsNYqT4T0IOlN8xSOg=
X-Gm-Gg: AZuq6aLowxyR5jt6KpAp7KmMdd8sxZWSWMAFmFBl8d8Dcf9yWJ1QCBn005MW6qZKtmU
 q7R8aESttLNo63mvxyfhZl0RMO0OrKViN8qKCfd84UOlMiJeTjvbYA4FzfAeWuakWWrrAN1AhEz
 wHXreForuWvbScw6jqbO+tt58j3V8VQOcXY8Wm0R6GkxMAdHp4ZkIREtJ5egB6DPXkz0Mr0eXqE
 wUcZPP6a5L7Y5TMj/FMF8h+fa8ibiinHvySUUG6QT/9s9xke/SGBvuvIR4FKbA14DSthQh4Lh1L
 a5oTGY4/yXcqpWGFPwkGeOWzDgkvHoXXTTrqbdqqX1HZlVcf2tfdGti+GccS3CdemFxR+SK3u1l
 8uHa+F85AbbRBI8BZ3DhC/RfvgdS+k51vBg1iYJJgKJCFbEDjHajBqQMAVZql+GGYwQYpWcvpHv
 CJbjJQQPxEhQeFBgkCr6lllei66yam74e7ntcRepGGyOLcmtarvvvUfTJeTFbmYpM6H7/qxeoNb
 S0pJiqiylUP26my2oz1rMJZfCI+YJO9REJa/CaVSjiySCNhFZo=
X-Received: by 2002:a05:6808:2e48:b0:45c:9975:36e7 with SMTP id
 5614622812f47-4639f280dc3mr8750659b6e.67.1771352042058; 
 Tue, 17 Feb 2026 10:14:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm12596426b6e.3.2026.02.17.10.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 10:14:01 -0800 (PST)
Date: Tue, 17 Feb 2026 12:13:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <20260217181358.GE2747538@bill-the-cat>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dzNNQQVPg5tLcPt7"
Content-Disposition: inline
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
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


--dzNNQQVPg5tLcPt7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
> Hi all,
>=20
> This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> embedded rootfs" firmware model, along with the underlying infrastructure
> to load FIT images on-demand directly from storage devices without copying
> them entirely to RAM first.
>=20
> I would like to discuss the design with U-Boot maintainers and fellow
> OpenWrt developers before submitting a formal patch series.
[snip]
> Three storage backends:
>=20
>   - Block device (eMMC, SD, SATA, NVMe, USB mass storage, virtio)
>   - MTD (SPI-NOR, raw NOR, raw NAND with bad block skipping)
>   - UBI volume (SPI-NAND, raw NAND)
>=20
> The "bootm" command is extended to accept a storage device specification
> instead of a RAM address:
>=20
>   bootm mmc 0:4         # boot FIT from eMMC partition 4
>   bootm mtd recovery    # boot FIT from MTD partition "recovery"
>   bootm ubi recovery    # boot FIT from UBI volume "recovery"
>=20
> This infrastructure is independently useful beyond the OpenWrt boot
> method. Any board that stores a FIT image directly in a partition
> (rather than as a file on a filesystem) can benefit from on-demand
> subimage loading.

For the user interface portion of this, since this is implementing
bootmeths, this should all be handled under bootflow/bootdev/etc
commands, and not adding further options to bootm.

Since you're also talking about an A/B mechanism, looking at the RAUC
support may also be helpful as that's another widely deployed
methodology we support now via standard boot.

--=20
Tom

--dzNNQQVPg5tLcPt7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZSv4gAKCRAr4qD1Cr/k
CnU3AQCHurH3twGxK7GLDIJkXULL0WQd5bnWoe+LE3XjgpD35wD7BC8DMavEqR3b
k73/2WRlfTvYCvcJE6vFj1PJgckjeww=
=sBiX
-----END PGP SIGNATURE-----

--dzNNQQVPg5tLcPt7--
