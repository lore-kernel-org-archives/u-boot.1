Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB975CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:26:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 260E782DA1;
	Tue, 26 Aug 2025 00:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wpg52AuT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45078307F; Tue, 26 Aug 2025 00:26:56 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF5B80819
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-30ccec928f6so1477864fac.3
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756160813; x=1756765613; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NHddIs3aCVo59g5QL+M68LsF5hF8ej4MV/XYRM3A/hk=;
 b=Wpg52AuTg4dE92VAi2FhFfxU4NNdZFVHUYMOTTxdfq5SQi0SOiabkKiJ1e/ONK/IpP
 9kUfkeobFkBcm9RsMlhE3hBt7x7ajv1jJYkWx7PRHUBQ+5UbZET80GRFIDfTxLHvLzbA
 JF13cFHY3WaLxpi12gH+e8xw7JXe/+VIX//8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756160813; x=1756765613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHddIs3aCVo59g5QL+M68LsF5hF8ej4MV/XYRM3A/hk=;
 b=MjhrlVfTcuWHZTLwc+2eZETAxbvza3zSxRRV/exBxMzu9VNXfvdWLBKc8/qvvSKv3o
 r6yBA0HdMzAy9y604q6N7Tkukqq6dX14fBH8OBTy+lSOwxo84d/x3uEm1/JHAtRchun5
 AqpwqOBXz1hVUXLau1Sd3Qk0DznaA3iz2E4BykpBwTZ9Ij+TkwFx9CUiyHoS0rI7kMUY
 jwAKQL/MczTCPc2uep4UO601fCqrpwxL7yEfM7bzW30rWXOmT1bz4JqSX/86EK5EPmnh
 4beP88KWA4hPT8jCi0+vv98qhW1m1gNtlwKnqxPZ2uMe+XWKYfu3+0Sn8rP/ba5NxG/7
 ggJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCsViJUYQ9P/v+f8P9IdOJdgrpgKh4ZTwNZDkzLZGuhgNTj1IEM45i1GSM0IZHQ039h3xWiuo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7zs26xZjedfQqXYyR+rRUlLWXlEhaAt/jdhjy5UMvrxD16eLh
 tBewJbiEoM/MVdpB676RUJiRYJ/Vby0tL5DnWe4uIxqDOowM90V9gQ4Rh39B999cHRM=
X-Gm-Gg: ASbGnctj0X5QIuLIxme2M9x/nudDBhPQZflmt3tCDwd2CCUkkwASYNH3xP+sJQMTevB
 3hE0iE/wH1cdI9aWjktBXLo7btx0nldiN5gw9M0l4WNKrEewxCHX7IP8H5J85ptZLqCDcPXZ0Uy
 VoFlI6mpNjwST5RtXfsE0fHAHJrui/+g/oxyk7wP6frAS3aK+WXSsZOesfBkjavIoHqS/IDLQ78
 j8w8d2tBCUIg1E1gnBWH+FDXHC+5Jy08eqZ1PrPIvwOK3upxv8z3FLxQQZN3ex+nUxyJX40qQir
 eyd9Ha6wR69Wr2ULE5nDTJrMYUcN+fGmuktUx1BYAoklsDAAnJ5gX2u87Gk5JsEKw9Z15cAjhHj
 pckZG9xuETxWAxp8A7tHpxbgE0bMLWxfNA3hSz9QmHMmwoKQAG6IKi4h+
X-Google-Smtp-Source: AGHT+IGVRR+OwtmlDcV6TyF686Y3+uTQbKuM7y4rhsyZICbA3kZ0hZF7S20Mz7L0r006DTr0qiEKZA==
X-Received: by 2002:a05:6871:207:b0:30b:4a87:bb96 with SMTP id
 586e51a60fabf-314dcb54a38mr4983588fac.18.1756160813143; 
 Mon, 25 Aug 2025 15:26:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-314f7d98e29sm2049550fac.31.2025.08.25.15.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:26:51 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:26:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/10] doc: Add riscv to the list of architectures in
 tools/buildman/buildman.rst
Message-ID: <20250825222649.GW124814@bill-the-cat>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-7-adrianocarvalho.pt@gmail.com>
 <b8fa5fa1-0028-43e5-bb14-db94fd16bf3c@gmx.de>
 <CACAHuLDQ9gp6G1KnbPTH2bcdFChY4x_M1HC0fJU-SJ0ozkghKA@mail.gmail.com>
 <CACAHuLD=fkEKq9e83f3ePQHO1N5dnVsRuFHwR6U12jv2EBJnew@mail.gmail.com>
 <20250822214045.GP124814@bill-the-cat>
 <CACAHuLDXaAuWTey1iFw4NUCq=kysuy4PKLWXRSypGtdK4XprVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KfWUFwsjoAy9f6mw"
Content-Disposition: inline
In-Reply-To: <CACAHuLDXaAuWTey1iFw4NUCq=kysuy4PKLWXRSypGtdK4XprVA@mail.gmail.com>
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


--KfWUFwsjoAy9f6mw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 10:59:05PM +0100, Adriano Carvalho wrote:
> On Fri, 22 Aug 2025 at 22:40, Tom Rini <trini@konsulko.com> wrote:
> > [...]
> > There's a few things well out date at this point:
> > - The output from '--fetch-arch list' shows what can be downloaded from
> >   kernel.org. Keep in mind these are public toolchains, for the Linux
> >   kernel and are also fine for us. That's why it lists so many more.
> > - The section "Check the available toolchains" should be replaced with
> >   modern output, and you need to pass -v to get such verbose details now
> >   rather than simply a list of what would be used.
> > - The section "Install new toolchains if needed" should be replaced with
> >   output from using an architecture U-Boot still supports such as arm64
> >   or riscv.
> > - The "toolchain-alias" parts don't list what aliases one needs and
> >   since 'riscv =3D riscv64' is needed, rephrasing that earlier part of =
the
> >   document should be done too.
> >
> > Thanks for working on this area!
> >
> > --
> > Tom
>=20
> I hope you don't mind that I'll leave that to a different patch series.

Yes, that's fine. I don't know if Heinrich would prefer to just take a
small patch here like you started with, or defer until reworking the
whole area to be correct again.

--=20
Tom

--KfWUFwsjoAy9f6mw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKzjJgAKCRAr4qD1Cr/k
CjedAQCooHxEz/gi9oDccY2/U9CO7nm8uUaTsE1Kg5LHTvVFGwEA3SE1uh3RMIn0
RvWG63UFVfJfaia0SOe2UHauBTmYdgM=
=nSL1
-----END PGP SIGNATURE-----

--KfWUFwsjoAy9f6mw--
