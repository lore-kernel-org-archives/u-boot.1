Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8FFEE6428
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 14:34:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D2184073;
	Wed, 31 Dec 2025 15:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YER/jQKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3C184027; Wed, 31 Dec 2025 15:34:13 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C2E684073
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 15:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-65d132240b5so6194308eaf.2
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 06:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767191648; x=1767796448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vqrIjvUpTdp345H36M7dDpx58LTMHZSzrBj00yme6EA=;
 b=YER/jQKR3mmobNpkEL9MJVpsAZgW30sqgZYKUaEep6Ii5cOm6gAFladGK2zrLOzgvH
 F6mQOYOqRJdnxspfjB3NqvL0cm8wrOCCNF77uBT0lP8Fv9dobyiB2FIZZ1eW633bOEfu
 PliQr6WQe3lXDC5hcujAknDReQRYdEqrx0h/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767191648; x=1767796448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vqrIjvUpTdp345H36M7dDpx58LTMHZSzrBj00yme6EA=;
 b=T+6tYhj01ilwFUzc0MeKsNp1kDs0+egJgV6QlcCQ0zLSXP/2A6QL0uIbPnD0Qc1GSd
 qu1Z8+ZWjtPIBEPASEWbE4LLMidbdnWhIlx8MKpGWe/LYLwTTuA4DS0mFyh4qcVBGj5E
 I0uHHceP/NLxgBxowEz30njXI8MGUqoUm1+s+4HyhABc090fpDMqy0cc5usVAqP58m6Z
 6zKaUE/gqH+rrjDZZPjYCNksCL+AW4Sz9GvYjaTJ/L+7f7bognDHBkSNrikQhhOCq3QN
 ZEqBoYJPIPT7kdJ0eGXqraSYPBQroF0eZkpgJXkQCaUz9EyVTpcent2+IJTGeP3m/WLG
 14MQ==
X-Gm-Message-State: AOJu0YwggEsjzmOPNHZr7PULUPiXAHWt2sQIK6AWgN0e4lOInBaa8ayf
 aYtA9sGYQaT6XrunlkDu9EbryxKMVJ8GUbe9Eldo438O3P1QLrGmxfBGEW262H51Jun2x3nVxKG
 RwzgWWVE=
X-Gm-Gg: AY/fxX4zm+xa0/pM5S2P8xL5ogWlczkkuk6lfhsIq3RtxCes5AkjZc5G4FbKBvndsKQ
 157MAONI4Jh0TZaia7bbptElZvhvzq+i1weCQm0UR+p/ddyxNnQuIbuTgIkT2EsYO4UTjtsB9Z4
 3+PKcZQHJu/5F/KdnjbXXxTIBsufM+hk62Mzip4Xgx2k8NySa5jklAIkAwd6xiOYoQdN1i5jgDj
 VYeWbhI5qyyty3EkyBnrA/s6fCc9a1HsQPB3BrAhGUrZLiqpE4Yv/8oNaFTHBY0XzQql4CGjA2H
 FMG0NpVJlT7lKaZvuyJ1sz/aSgjjH9Gt4WR1k84hOC1kkuI3yywTE4fJI/x9nh2ElSqFyOHAJkm
 FlSr0tHEPg4/K2em+5KvsXnkNTLaQilFr8VeYs3RjqhRkBId3F+6aBIzvo3LedBmUaum3e4EbBl
 vtEOjA9sgS7sKSeL0Y/rQq4CHgCoGfGeHE5a0AmRU0p7ZxsOkjX98BEr+8u/0sP/6XJ647+EUYq
 h2B3j8GlAWCJ7jWg/isK4ZY7jQ9cil097kVNz8=
X-Google-Smtp-Source: AGHT+IF0C8R9O8aEtEp6kvqjkdmYsE2Mekm2V27dPa4i0olvHM8yP7ZJyMxo07kGY2CYjvbHyg3FDw==
X-Received: by 2002:a05:6820:8512:b0:65c:ff20:a3b5 with SMTP id
 006d021491bc7-65d0ebee5e1mr8840102eaf.77.1767191647952; 
 Wed, 31 Dec 2025 06:34:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f723ab6sm22557411eaf.17.2025.12.31.06.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 06:34:06 -0800 (PST)
Date: Wed, 31 Dec 2025 08:34:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Jun Chang <jun.chang@metanoia-comm.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Subject: Re: [PATCH 1/1] board: mt5824: Add initial support for Metanoia
 MT5824 EVB
Message-ID: <20251231143404.GX710860@bill-the-cat>
References: <20251230030328.215240-1-jun.chang@metanoia-comm.com>
 <20251230030328.215240-2-jun.chang@metanoia-comm.com>
 <20251230153115.GR710860@bill-the-cat>
 <e4a70eae-37fd-4648-bb17-66975c6d09af@metanoia-comm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rPFMCsGM+vLjMHS/"
Content-Disposition: inline
In-Reply-To: <e4a70eae-37fd-4648-bb17-66975c6d09af@metanoia-comm.com>
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


--rPFMCsGM+vLjMHS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 02:32:45PM +0800, Jun Chang wrote:
> On 12/30/2025 11:31 PM, Tom Rini wrote:
> > On Tue, Dec 30, 2025 at 11:03:28AM +0800, Jun Chang wrote:
> >=20
> >> - Add RISC-V target for MT5824
> >> - Add board defconfig and DTS for MT5824 EVB
> >> - Add SPL and U-Boot board support for MT5824 EVB
> >> - Add DDR init for MT5824 EVB
> >>
> >> Signed-off-by: Jun Chang <jun.chang@metanoia-comm.com>
> >> ---
> >>  arch/riscv/Kconfig                    |   4 +
> >>  arch/riscv/dts/mt5824-evb.dts         | 232 +++++++++++++++++
> >=20
> > What is the status on upstreaming this device tree?
>=20
> The device tree is able to boot to U-Boot with shell prompt by the JTAG.

Since I wasn't clear enough, I meant the status on getting this in the
linux kernel tree so that OF_UPSTREAM can be enabled and we use the copy
found under dts/upstream/src/riscv instead.

--=20
Tom

--rPFMCsGM+vLjMHS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVU0WQAKCRAr4qD1Cr/k
CjI9AP0ZRE4b9qQ2w63UlWQSTf3uPpGXJwWm/7T29hU0iNxvoAD9FidW3jBtvgtE
59wW6f6pPGyi5LEEdQEKn868Y834FQ0=
=ynZg
-----END PGP SIGNATURE-----

--rPFMCsGM+vLjMHS/--
