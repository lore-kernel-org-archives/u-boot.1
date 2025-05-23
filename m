Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60150C54ED1
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 14:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF864832D8;
	Fri, 23 May 2025 16:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jTwXwvHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BEE3832F9; Fri, 23 May 2025 16:59:26 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD51E83236
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 16:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3fea67e64caso24077b6e.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748012362; x=1748617162; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gtGcX7NnQn+8Rpssf8jemmlBwSabt6LmbF7fVynj2zM=;
 b=jTwXwvHv51UvulxTh/ujIBcAA37wbqPkZSdwyWL7lo06TBJpNobvl/RBq/UL4DtT9h
 9tH9DsWVLVBv4yOmEZY6j/g+X95FbfFuK2s3TArWBiPmpy5Sq3Zv+4tplNg1NNa5x4ZQ
 2l62qe/h8C2h2GkV2p1yt/rxeZCpsArhjMCz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748012362; x=1748617162;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtGcX7NnQn+8Rpssf8jemmlBwSabt6LmbF7fVynj2zM=;
 b=vf5VUgdenN6kF05vN/c6m3z23jwLZZ7LBgbtG3+4gUgAp8Lib3jhNf+Unmza7n6pwO
 cZAtt5dZUYnAe8VobO/LZkc0YP3EBV2Zjj6Cx6bC5R4yeuXG54efiFI2yddsa72baY8b
 1h6SnXlLw4kWGk3ufsWRgSYHwRw+qDnrWbBhIyBBRbzCMVWmeWefECCFoY2VureByHfm
 ZOl/JKbSxfJwYltc7uM27sG1ZqBT8YSj9RrCd+hC5q18vE5YhT8r4gIRiHioXDvCzNQ6
 sw2IoWSK3OWxUBlxyC0Agpg/5WIV1GT/ohEvhfvVLiJ1rjB+P59gNH6T6euOuDHd2w60
 XQyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm42CXoGT5VIGgNTY/fQ3Npy0DoZf+ndlzESJ+RD6OrNploN/iR10UX6EXvzqEu1RIn1c4vJM=@lists.denx.de
X-Gm-Message-State: AOJu0YzVY65Avwo+txTKXcRjdyPmiaDIg2tzaUvdNR5M4laL1hlfPvbV
 FcOaJV0XTAef2t61s8eGYJ8u7ZXA9gNcbjRFCbnQlbO3aAMioUOy6W/foJDjBqN84Q8=
X-Gm-Gg: ASbGncuT+zAFhHWei2roUzTlg55s58jbyWGzNAbkzGF1f2jsF87VOR2SUQxCy4pguIy
 hpeK4cyxV7s7zItjVJ5flfdsTZzul1qK+e3+LLTksSiTvIWpHzX/VdrfQRTqyOXpsLYYDPXMy9A
 SItsoL1sx7SpdrZAIIuqucP85jgcKRQPEdB+eKOSDOGB594amFat1E7Nw6ZkfUP5kpnuY5HSX1F
 2B3uuK/WpHbcTRwndiSk+QsPA6nOrB6EtGJCASwigNgv9jSmW5QywVZDdtIAHYhuMyNuDDzWx/P
 Bbl5C22u5yQCikZ2cQsrEG0iomcUZOq/iXqmjplsekiT9lu5nkvhba4oCI+he6wok/I8TcpAQaL
 X/flV1J5EqVlj
X-Google-Smtp-Source: AGHT+IE9ANLDUoeGqsLecwVaUGRFGRIbH1A9ZE0ypT239/QCI11bKagi5CG0yvsNCGrSQwae0sCpcQ==
X-Received: by 2002:a05:6808:2f18:b0:401:e721:8b48 with SMTP id
 5614622812f47-4063d9ae166mr2563374b6e.8.1748012362398; 
 Fri, 23 May 2025 07:59:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d98cbbfesm2939818b6e.41.2025.05.23.07.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 May 2025 07:59:21 -0700 (PDT)
Date: Fri, 23 May 2025 08:59:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Beleswar Prasad Padhi <b-padhi@ti.com>, afd@ti.com, hnagalla@ti.com,
 n-francis@ti.com, jm@ti.com, u-kumar1@ti.com, m-shah@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 6/6] DONOTMERGE: arm: dts: k3-j7*-mcu-wakeup: Enable
 split mode for MCU R5
Message-ID: <20250523145918.GT100073@bill-the-cat>
References: <20250522071828.285462-1-b-padhi@ti.com>
 <20250522071828.285462-7-b-padhi@ti.com>
 <20250522144505.GK100073@bill-the-cat>
 <20250522154832.2phhu7i4e2t5dnrn@mountable>
 <c99863f3-2b55-46e2-8079-64b1aa7f9437@ti.com>
 <20250523115400.s5ikojqjueowfxpn@cubicle>
 <20250523140932.GS100073@bill-the-cat>
 <20250523145447.6wxixpi4qrnle7sn@sandstorm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YTdQdNFUvNtl5g6A"
Content-Disposition: inline
In-Reply-To: <20250523145447.6wxixpi4qrnle7sn@sandstorm>
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


--YTdQdNFUvNtl5g6A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 09:54:47AM -0500, Nishanth Menon wrote:
> On 08:09-20250523, Tom Rini wrote:
> > On Fri, May 23, 2025 at 06:54:00AM -0500, Nishanth Menon wrote:
> > > On 12:05-20250523, Beleswar Prasad Padhi wrote:
> > > > Hi Nishanth,
> > > >=20
> > > > On 5/22/2025 9:18 PM, Nishanth Menon wrote:
> > > > > On 08:45-20250522, Tom Rini wrote:
> > > > > > On Thu, May 22, 2025 at 12:48:28PM +0530, Beleswar Padhi wrote:
> > > > > >=20
> > > > > > > Previously, MCU R5F runs in lockstep mode. Enable split-mode =
on MCU R5F
> > > > > > > as the support to shut down core1 and use it for loading othe=
r firmware,
> > > > > > > while DM runs on core0, has been added.
> > > > > > >=20
> > > > > > > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > > > > > > ---
> > > > > > >   dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi         =
     | 2 +-
> > > > > > >   dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi         =
     | 2 +-
> > > > > > >   dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi        =
     | 2 +-
> > > > > > >   .../src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi   =
     | 2 +-
> > > > > > >   4 files changed, 4 insertions(+), 4 deletions(-)
> > > > > > Please don't post DONOTMERGE patches. If the series can be appl=
ied
> > > > > > without this patch, because the functionality is backwards comp=
atible
> > > > > > put these changes in the cover letter or link to a gist or simi=
lar to
> > > > > > show how to test the changes locally. If the series can't be me=
rged
> > > > > > until the DTS changes are ready too, please mark the whole thin=
g as RFC.
> > > > > > For clarity, what is the case with this series?
> > > > > While I appreciate the energy to get upstream,
> > > >=20
> > > >=20
> > > > Thanks :)
> > > >=20
> > > > > <vent>
> > > > > I think this habit of jumping ahead of kernel should be
> > > > > stopped.
> > > > > https://lore.kernel.org/all/20250522073426.329344-1-b-padhi@ti.co=
m/ was
> > > > > posted, but not reviewed or accepted. I understand that there is a
> > > > > latency in picking things up in upstream kernel, but creating chu=
rn is
> > > > > not the right way of doing things. It took us an year+ to get
> > > > > OF_UPSTREAM settled down. At least wait for kernel maintainers to=
 queue
> > > > > things up before attempting to sync u-boot with non-mainlined pat=
ches.
> > > > > </vent>
> > > >=20
> > > >=20
> > > > Actually the functionality added in this series is independent of t=
he DT
> > > > patch. I posted this DT patch here as DONOTMERGE just so that folks=
 can know
> > > > how to test the functionality.
> > > >=20
> > > > I understand your concern, and if it was the case that these change=
s were
> > > > dependent on the DT, I would have waited until the DT patch is pick=
ed up
> > > > before posting this series here.
> > >=20
> > > use gist next time if your intent is to show how to test it.. Let us
> > > continue the discussion on the kernel list for the dts portion
> >=20
> > So it sounds like the bindings being used here aren't settled then? I'm
> > going to mark the whole series as RFC for now then, if so.
>=20
> No change in bindings. Just the approach in this "easy to reproduce"
> patch does the change on SoC dtsi. I dont think that was the author's
> intent (and yes, i was confused as well). The question in kernel at
> least is organizing this in the right board dts/overlay methodology.
>=20
> Question then is: do we wait for kernel dts to settle down OR do we get
> the u-boot infra for handling these combinations ahead of the changes
> (more or less like do we do the driver fixes first or dts fixes first?
>  in kernel at least, we do the driver fixes first)..

As the author said there's no functional regressions / etc with the rest
of the series, yes, I can pickup 1-5 for -next in due time, assuming no
feedback on the changes themselves.

--=20
Tom

--YTdQdNFUvNtl5g6A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgwjUMACgkQFHw5/5Y0
tyyy5gwAt14xpEiomIxDHqP/WT55reKVb4j0DOEbIZOX0LvmzZNnoI8Ul+1xBy8j
uMUWTlN+Jvaz0j/vNYXYz2kiIxKs6+RgvWj0xA0Na2bE5wwTrtJdVKeHllGVbhnU
SNcExh2F3ux82fD2csRnA1zCx/+Pc5wdEk+ZwDwqydZdheP4NJPf7ssyUSUJwkjH
D80sZk/0WLA3WZOqhTpn5uEzn5a9o3xOGWazlZUQmACw0gzs63NEg/Bjd9Wlk5QH
wBzbpZf24JWJGNjXNw4aEgqgym8slZYepya9mNCL7GFa2Kd10BLf4cujs+ogcs4f
g+s87hB5nrZP3b2Vngg2kSqeEaJuIUlhmFGLRWSb128OFxwzHv1gLUbslLlw2LBZ
Q2zeINLhuhjUfWsHiziau6zxEcKom1TZIpBUhYXuau6xi92aL1wVbKB5KUH7OZMF
25Sh1oN5uQ1ix34Hgh6v5v7aF737hQMnSpEYIQ7gclQocrSqGYy4ruTknCUx6wIa
DN7Ajx+p
=liVb
-----END PGP SIGNATURE-----

--YTdQdNFUvNtl5g6A--
