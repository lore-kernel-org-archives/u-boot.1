Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB3E107BCE2
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB0DC8436C;
	Fri, 13 Mar 2026 22:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ivv7mCxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C845784376; Fri, 13 Mar 2026 22:10:48 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65970842DF
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:10:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d7422b4ff1so1201746a34.3
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773436245; x=1774041045; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N7fhGePOkOQ+oOR/NczBNNaWDnbLfEmxSkfsEb7IHRI=;
 b=Ivv7mCxXB90xCngID2u6iC8VMnwE5qO6uTb955rO6dUFLsB3eW1fekFlh0cmRP+oHC
 L+Vsu9+WRjzG50fO55VFKzbQSjgwC66h6yCnZPEUkrzHcuZLI/1442MX1dcf1KhRWB+l
 NLQr61iEQPALfLneAdxwOTo3oe8xGXm78iEe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773436245; x=1774041045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7fhGePOkOQ+oOR/NczBNNaWDnbLfEmxSkfsEb7IHRI=;
 b=RISiPkLSHTzw9OCUM4tCCdznUwpRwMxZI7yvEXf6A7DQy80vICPcgSMxYgDWPpb8Wx
 doCNMg51gncj14Pe2ShdP6MMAsCr4vcz7SbuynxUJ4JvtqNl/7y2AI8X4vckzXdPLyyy
 MPMcZUg+QkgfUHLZOLGRDDrYzPAgAFkA2aJwrMVuOGO3U/pPecMVG6vVuRKhxjuIHbug
 B4nGf3a9/wZuWRURNJMTg7JR4H5K+iIXBR6npx5YMjLkWDuegYbi3TEgzDZuTxwHKAsj
 LE1E4wGdImkwdfnwhxp/lzrGdKOO5leCczvCaOW6y6SNM4c2K2dyQ1Gd9umTh4QKn0F2
 pnqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYWbb7dCXzv0hBwyl59fPcdiHundgIj97iSRh7jeRpQzEitp0D0eGumy2HfqmwcZ38T8ou4hA=@lists.denx.de
X-Gm-Message-State: AOJu0YxqUeVIPY9ASFNkOhLMnJApNZfa3WHKWTsUB1RYEnxWQqbs7wYV
 xA5/8WNzYv8dypHenr4pi43s5jBW4K5Nfu/AznBW8eg7cr+52WDvr5d8Kko20JobJO8=
X-Gm-Gg: ATEYQzysMci3wz0ceZAFTziZhjOYlqtdYLBPlCe9xWZ2D5wAvPvRtjK9qeKMtwukf2I
 Yh/oDaz1Ln84y+m4PdNjPOaBi9T+WaVb3L5KlXo/QFzYk88qbmTsHHj9ht69CVIL6kmQsNu1sO9
 dh3nFcZ09NcrAS40t5ItCi1Mq8UiDVujQA9Aaw8o4116mnA8XRKBln3mYWDen67qPSNG21Ljw6Z
 IEy0KA9yhZuMqv2qVQ+nrEuzUJQeHSJfey1AVuZTC12IL4tF9xMGB2squzjW/JUUPKH0IV+VINH
 fciyCxDM95zYbXSuQ1rFCTXht1ubNHrNhv7bC8YTpuwFqFAMaHiBNWUuQ7wov7h7Ewl3QNSIoXI
 dQ+mNwbLmrLda8DK9WAEbucpRvw08sMPJsOG/GQqXeDJo91+ojA93qB2yxrBfvpIj0hM5Bzo/lC
 sWhFIMv3djHHXPZ9fH6OXQHhduEEzbp86haTAEWDGECEvQYF4yDB6+DPWWTrsQYMfiu+2Y6IKQF
 VP9dm9RqXoGFokchXFKcnc5tI4mGfnrVHowF7sQeyzAWI1F
X-Received: by 2002:a05:6830:83b8:b0:7d7:5362:6daa with SMTP id
 46e09a7af769-7d782549871mr3108089a34.27.1773436245114; 
 Fri, 13 Mar 2026 14:10:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5e9f53sm9757160fac.13.2026.03.13.14.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:10:44 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:10:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
Message-ID: <20260313211041.GI502704@bill-the-cat>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <e8148f39-39ba-410e-b353-9b75dca79266@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1lVcw6QJkyekat7n"
Content-Disposition: inline
In-Reply-To: <e8148f39-39ba-410e-b353-9b75dca79266@kwiboo.se>
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


--1lVcw6QJkyekat7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 10:06:15PM +0100, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 3/13/2026 9:54 PM, Tom Rini wrote:
> > On Wed, 28 Jan 2026 00:48:40 +0100, Marek Vasut wrote:
> >=20
> >> Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top=
")
> >> and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even=
 from
> >> same bank"). These are based on incorrect premise of the first commit,=
 that
> >> "U-Boot does not use memory above ram_top". While U-Boot itself indeed=
 does
> >> not and should not use memory above ram_top, user can perfectly well u=
se
> >> that memory from the U-Boot shell, for example to load content in ther=
e.
> >>
> >> [...]
> >=20
> > Applied to u-boot/next, thanks!
>=20
> This patch break RK356x devices with 8 GiB RAM until following patch
> also has been applied, currently only the fix for RK3588 got applied to
> next.
>=20
> "rockchip: rk3568: Include all addressable DRAM in memory map"
> https://patchwork.ozlabs.org/project/uboot/patch/20260309210234.521070-1-=
jonas@kwiboo.se/

Ah oops, I thought it had all been merged. I see Kever's tag on it, I'll
grab it directly right away. Sorry about that!

--=20
Tom

--1lVcw6QJkyekat7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabR9UQAKCRAr4qD1Cr/k
CkeQAQDNTEAB7/u7MuuZBDjB9uomMo7w+7L3N1O4ciFptlhYQAEAmdQH/i/QcoG6
SPR7JVgSiBiJwdvEVUKw8Li2B5fvSwE=
=yv9j
-----END PGP SIGNATURE-----

--1lVcw6QJkyekat7n--
