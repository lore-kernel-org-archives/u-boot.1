Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D310CAC5A5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 01:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5422383666;
	Thu, 25 Sep 2025 03:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B5vy4WNA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16D9D83666; Thu, 25 Sep 2025 03:06:24 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D19E18368E
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 03:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8c3414ad279so18150839f.2
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 18:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758762379; x=1759367179; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WWZ6ZVacj+GjvBRaV2BF+psaqpAz3ZL4Rmk3KrS5LvI=;
 b=B5vy4WNAZgLlrahmu777jKTlM+K3i+oxFgnZ8zXdo9y5peXOKANu3wMNhz1qRXr48G
 r7+AvslTHALKZmLW+wGqrxBIOU7GukBVudQM458xfNWtWtjuwJN7E2jQcNwfUCzlZYib
 hxD9LWLBnTSPC7mv/sQMUfFTHNBGYJkadGdEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758762379; x=1759367179;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWZ6ZVacj+GjvBRaV2BF+psaqpAz3ZL4Rmk3KrS5LvI=;
 b=PtdI5tgRrGFT///zwZm9rr15EngnqsTGCKeBa1JFRK1jjYy35fCzU3zJ5r4TNJBhll
 GpB0s0VPbBKV2l0TDjiW1mMHjZkf8VDGKyK0RL1R8frwuG8tD6YGsJOkRS3cFLXGKeq7
 dg1qHGA7yAi7JbEbduIOEJBRdTLPENbozujQKsaXv6r8naYBAaa240Nst29zJVd/bSJz
 MpGIftNtD8ypgwNg0q87p1t4oJSgIjoMRPvf+vmSTLjrIWmJMxpXcO7nKO9uOv3/UrTT
 o1RFU7WPR1i1crvoH+2z+QG/x4D+BJIgq7SjjifXG7UgLsBbLzGVgbp62X/xML2mcrXi
 ErmA==
X-Gm-Message-State: AOJu0YwA4FCtOsCfjyMUoLak7mbawzGEdW9jN6jN/fTNayPeyIuYfb37
 CBUuNM5S+ygTXLzOZjGUPfu8cm3UXl4dPFhw9g0BDiWF0fKa7Z2leK0oCX3Kg414Ibc=
X-Gm-Gg: ASbGnctm37RFbGti4cnMRiHPnweEElJMGdIBMhhJbPEWqp72oZxoCnlWlDe832SiA2s
 tOOUTsCvf5ToU7q2Td4RkEAV1VwD9CN7Gq5eANWh88uyFOq4QWOFUuI1El489xkJ0AHUprrN/nV
 p7uZATTBHZh4e1j+BW1LkTBURSF8ZhabEex7U25f0RJ88EKVI9nBwM8mzyjD798z7xL7pKzx8mO
 393oqQlYi4059Z/L0tl1RE2rzlyvAMaTpXYC8X9iD5xB80IX4kbrQXsed/bbBzAuerJSgEUciJe
 JStz+80xem+CjhAZKHHlgHPpargpDRY+Tijsgy2it4rIFEXVlXnCSRKhIYa32Tc/8q/yOzzUpy5
 5P4tU/Bbbl08UowEK1BYEULMdMG1++heQycuFnLjBZg+b924mrQrm9+/w
X-Google-Smtp-Source: AGHT+IGlt/hSo8d4I7QaL3Jfk2O3Ub045eyUU5AnIo1xkpDVoroJGfBOsJXqLgeFKvfZ+/WOKfds0Q==
X-Received: by 2002:a05:6602:340e:b0:8fb:813c:7015 with SMTP id
 ca18e2360f4ac-901652e109amr304173639f.14.1758762379424; 
 Wed, 24 Sep 2025 18:06:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-9041364504dsm21345939f.27.2025.09.24.18.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 18:06:18 -0700 (PDT)
Date: Wed, 24 Sep 2025 19:06:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Bootstd for sunxi
Message-ID: <20250925010615.GK197373@bill-the-cat>
References: <CAFLszTg1=XAnzoBEtduADXLS3xQxeNh1Dn_77Dc_V3bTUhhFzA@mail.gmail.com>
 <20250924163413.GJ197373@bill-the-cat>
 <CAFLszTh7so42FH2pms7dqzXFSz0vbOcab-GRmFCOaqLe2DL6fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HVmHoE7pSdG/V/7v"
Content-Disposition: inline
In-Reply-To: <CAFLszTh7so42FH2pms7dqzXFSz0vbOcab-GRmFCOaqLe2DL6fw@mail.gmail.com>
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


--HVmHoE7pSdG/V/7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 06:34:53PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 24 Sept 2025 at 10:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Sep 24, 2025 at 10:28:45AM -0600, Simon Glass wrote:
> >
> > > Hi,
> > >
> > > After the discussion on the call this week and Andre's suggestion of
> > > putting FEL as the first global boothmeth, I took a look this morning.
> > >
> > > I created a new v7 series without the 'efi_loader: bootstd: Drop
> > > bootmgr for sunxi' patch.
> > >
> > > It seems to run OK on a Linksprite_pcDuino3 but I'm not sure that is
> > > enough. The FEL boothmeth is first, which is good. But Heinrich did a
> > > series to reorder bootmgr which hasn't landed and specifically I had
> > > concerns about this patch[1].
> > >
> > > Given that Heinrich can't make the calls, I'll talk it through with
> > > him separately and reply on this thread. For now I don't see much
> > > benefit in sending the new v7 series, but I can if desired.
> >
> > The biggest blocking part of the sunxi series became that it showcased
> > the more generic problem with integration of EFI and standard boot [2]
> > so yes, getting that resolved first is the next big blocker for trying
> > to migrate more platforms. It was unclear to me then, and still unclear
> > to me now what the value is in exposing more platforms to what I believe
> > ends up being a less than optimal experience is compared with what they
> > experience today.
>=20
> I'm not sure about the less-than-optimal, but I suspect this is the
> bootmgr kicking in and checking the network. Heinrich has something
> for that and I'll talk to him in a day or two.

Well, that's not how [2] was summarized, but it's hard to know without
anyone being able to try it.

> > But since no one can actually test things out and see what is or is not
> > different with the switch, yes, you should post v7.
>=20
> OK, done! Something wrong with CI, but not sure what.

It seems something is going on with docker.com.

> > [2]: https://patchwork.ozlabs.org/project/uboot/patch/20241113150938.15=
34931-4-sjg@chromium.org/#3418689
> >
> > --
> > Tom

--=20
Tom

--HVmHoE7pSdG/V/7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNSVhAAKCRAr4qD1Cr/k
CiUHAQC/gKCrk9ufosZvJAvPdMHQAscejzSYH5j1AYaMybiLRwD/YTXvwC6RrKKZ
SR1dVhHaTrVscYEGqHXm+i2j6m/JJwk=
=gk2J
-----END PGP SIGNATURE-----

--HVmHoE7pSdG/V/7v--
