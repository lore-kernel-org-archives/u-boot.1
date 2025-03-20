Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D590C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B9E2806FC;
	Thu, 20 Mar 2025 15:21:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cHApol77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F88480540; Thu, 20 Mar 2025 15:21:30 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10EA6807AE
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-301cda78d48so1577898a91.0
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742480486; x=1743085286; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ivSCZU4ry6WYyZLhqWM6aWuWtjImGf3l5IWkiCfNENA=;
 b=cHApol77NW9t/9r1w+oKZJ3NKmu4CBe967ErOoiaH5L7RZnOa+SRZKpqsM7n1LGYqH
 oQSCcFVcVj51dinaUpOlSk7ASjyODlxaGUmyQa3wb2grcgtgY0yUV4AVbm00O1l2N8af
 A6lWiro59c8u90qYtarniKlxA8YgRt1ZeP97E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742480486; x=1743085286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivSCZU4ry6WYyZLhqWM6aWuWtjImGf3l5IWkiCfNENA=;
 b=c65YyLTFe2S3RdjdFsLKaXF1YTSx0w8qDe2q4ibLXT6H8R/BQRgAC/vESw5ONGFvZ/
 Z3mnd1QBoUjAyCYsWQl/G7OiBT6/L/m2yQiIEgpqv7WQjTovpUm1fOHkST+tToge/k8F
 4AHYWIBeFfQ0TzOWl93z7ITCAuqoZg86HZt4k/7+E5VsK2OXCGglPtNbkh0etqqhigYP
 y0AV+23xRhtqatlXbDcti7QSG/3ZzzoWeM6XftFLMMOGWTWaYh9arFwC0qRFnRWy/Em0
 EoY0v6oMAYJaSxWIf8XadDxOFAw4EVvU4MIJVecfefPxvNJlie6eo2VSkPiAm5XbgjlI
 ENwQ==
X-Gm-Message-State: AOJu0YwlRHh0Un2VCtSWPgRPQBJeser9Tt+RVbazn+LgSMlQqWDXRsX0
 fWsE5LYAfCp75x10QigrdhMoz7um+MnFuZf4udy8WHvX+91uFqrGiFZ5d8lv62M=
X-Gm-Gg: ASbGnctQsQtidvDhfdk+ePepqwglbHbiKyZ2k19kBaIY11rq+egz506z88k6jQXOhD0
 7P2Ec8ufLWGqv6fWOFgja3ia0ADjryinXiKSBdYU9K/Z5GR7FudgHVxi7a44BoK4NkrlSa9QExW
 7pdnPDplgo9uUu7h1JlkzrhWc5WghiUjRffbn0pETxUzlMNtFxi7wum8OdXu7OIeA3dplgv+K73
 4ouLy/HOCp2mfEm3NB3/6pC5hhiptDpW26yGJrQ+L8jgMXoKXOmowlszlvangmMXwwjjfAvxVHO
 oW4gFZqlQlE33II/Nw9a6VpfYq6CGEaFWKaCrvKlrIe0rQ==
X-Google-Smtp-Source: AGHT+IG5XTfB1sHPljPk2V4Ygzd//vZMNUENp22kHyEiEQwngNndsuXG24M5Mb3WlV/zqTj1qVSp0A==
X-Received: by 2002:a17:90b:1f8d:b0:2f6:be57:49d2 with SMTP id
 98e67ed59e1d1-301d52c3851mr6194366a91.17.1742480486358; 
 Thu, 20 Mar 2025 07:21:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf589bccsm3918958a91.11.2025.03.20.07.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:21:25 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:21:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 00/52] expo: Various features and improvements
Message-ID: <20250320142121.GQ2640854@bill-the-cat>
References: <20250319145512.2391122-1-sjg@chromium.org>
 <20250319145742.GI2640854@bill-the-cat>
 <CAFLszTig0NG2vDZsJkzm7oVRjpQhLxdh3g2Xn59AX=Ri=k_zrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YXduJx9WB4OhdG+S"
Content-Disposition: inline
In-Reply-To: <CAFLszTig0NG2vDZsJkzm7oVRjpQhLxdh3g2Xn59AX=Ri=k_zrw@mail.gmail.com>
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


--YXduJx9WB4OhdG+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 03:39:26AM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Mar 2025 at 15:57, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 03:54:05PM +0100, Simon Glass wrote:
> >
> > > This series collects together some new features for expo to make it m=
ore
> > > useful for boot menus:
> > >
> > > - measurement and display of multi-line text objects
> > > - internal alignment for objects (e.g. centred text)
> > > - editable strings in text fields
> > > - new 'box' object to draw a rectangle
> > > - highlighting of menu items, rather than just relying on a pointer
> > >
> > > Expo's boot menu is restructured so that it is possible to iterate
> > > through various bootdevs and update the menu as new ones are found. T=
his
> > > is more in keeping with how bootstd works.
> > >
> > > A new textedit object is added, intended to provide a simple text
> > > editor. Future work will complete this.
> > >
> > > With this series the boot menu has a better layout and appearance.
> > >
> > >
> > > Simon Glass (52):
> >
> > I see you haven't internalized the "don't post massive series" feedback
> > yet. Please, stop posting massive patch series. Figure out how to
> > logically break things down in to smaller chunks that can be
> > meaningfully reviewed.
>=20
> I could split this into two series of ~25 patches, perhaps. Would that be=
 OK?
>=20
> I believe no one else is using expo yet, apart from postmarketOS,
> except the trivial case of 'bootflow scan -m' but I'm hoping that will
> change in the future. I believe that Linaro is mostly encouraging EFI
> bootmgr and the text-based menu. That could be converted to use expo
> but I doubt anyone has looked into that, particularly as grub is being
> pushed as well. I did look at converting the existing menu code a year
> or two ago, but it seemed better to eventually deprecate it.
>=20
> Also, there is a following series which I split out and will post
> separately, but not for a while as I have a lot outstanding.
>=20

It would make sense to split expo out to its own series as there's not
likely to be any feedback there. All of the other parts of the series
already have something else in their subject and that would be logical
places to split this up more and then assign to the appropriate
custodian. Thanks.

--=20
Tom

--YXduJx9WB4OhdG+S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfcJGEACgkQFHw5/5Y0
tywYWAwAjuHa05REb9fyEzSj+HMfyDFe9UlxXBsScG+LmvVXxT/tmYkRoHI6tozf
lm3ZJRRUA5rs7ODRLB+FHlbcMPx0YBRPuczFscw8yJ9fR8lSwRqlWxphprviBvW4
4lK3VjfWlCrsY/JOWAc2enVH4r+Gz8qCCYevJA3WMj/C1zP40AxvAKlb465zNEp2
OarkF/dpO34qea7SPueTTArRO5eMta29n1Ay8QmsdLLQf1PfaZ0wL3kvp9F+p7/2
CANLUE7B+cY8Dj4qIGSNqHmW48BjB6TuVNCFvhEvM7EEBey2Mn3be6Rm53cYP36g
S3GVVMCR+wEXFMqzcFtRYSXd8dKiz6lRT82YZ5Ow+DklAuQvh7b5hkxATuwB/gwp
2o3kPl581hQiA/LaatY1rfb5wRopBeIkS4OCX2Siua/ru3RLz1fyf894kXIn6Tgp
GFDqh9XdVd+4FrU1PuHXuY2jPaEi6t1Tv7omp4dMj5thO7b5BES8akUXiJWQogBa
HoCLYSBX
=LnrC
-----END PGP SIGNATURE-----

--YXduJx9WB4OhdG+S--
