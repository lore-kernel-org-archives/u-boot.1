Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8053BC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 166B3806C9;
	Thu, 23 Jan 2025 15:43:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N6qOtCfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91224806C9; Thu, 23 Jan 2025 15:43:30 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24831801B0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:43:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7be3f230436so88058185a.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737643407; x=1738248207; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZDsGflF7VJwu6BkT8ElwsxJ9UH4pKNSas7cHwoaSMI4=;
 b=N6qOtCfgI+Thn4BhhczlB8MPjGwN5kW60HOYE5YkaLS9hdOPVS59HmxY+ub49aCxl5
 8QQHqJqLVbJK3w04gPJZb9J71xZMowh73FE6XuHFVMy7KchGgnMGNXNtcA2+G7GOlftn
 CqMxvfafAe4qfpaWLrz1fjCuUSref39QNx2lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643407; x=1738248207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDsGflF7VJwu6BkT8ElwsxJ9UH4pKNSas7cHwoaSMI4=;
 b=FRi8CVJJB5B6dmOa2JU6re9Kv7LxC3//hOfntpDCy34DvzaIS5EOOlzpiXpJ3uKy+6
 biQ+Y8fjUWBQ4EX+7M+ejd/SzQLl8B6U9IVSC7QdvN75HErihMdkb5w0Jf3Km9GboD1W
 nbzpi0mLfkf+ld4LguDFwaJeInLrcrtXK2QLuvJyff65sIScHiaYZIiSLhQakj5ojTXU
 K206Zra1wNHyB3Y5g7H+2CUVXFipkRV5nDzWYKl8Teughsw+oPKIReQaywhMPfUQg5TB
 fSuXMe9obb0xpkd94o77F9O1KqzCMtCfOq4vB5oXAdrsDazG8XAugUYRzmztJvIlCn7q
 n5rQ==
X-Gm-Message-State: AOJu0YwOtWHpCFZlHu0snDgkxEpK7nxjZqwmBP1AM1EwZ3Mu9P++dmHe
 N+i9Ijnnkf67yBbZZEwCkLuRA0oTwEmSgzWr1h3GiSBA4pARueu6yPYiSvJBeME=
X-Gm-Gg: ASbGncuacC2SoJILhbzxHd7X9KiYJVhF0+D1Z5FmMgotZ6kpgUNCc6Oh0T4GhuofCLK
 2un7mT36b123fX6xrgY37C5cT+eJPBQ+gP+wejvH6zobb6IWtl4EZnItJWDoR0dFXca90QNOGwT
 xHx27NrqBYE4wHq0AHhfP13pVpaUdGkcuGXO8rPBuYCGQNJiWiNsQJaQfgzoJVWHCNM1Qzydcbm
 xYWxPKv6ITMCKJjzcmLSy5e9PKM3lfcK/1uFxqnUrPfUMA0OfMsJZqYyaIpqlJQNLx8mTfIFGRl
 GJgt
X-Google-Smtp-Source: AGHT+IHx+ZbdhOqPMo45u1CjZphHZgql9QZHRdOQEAozoXxCoxX2R40uw7lnDqX8ggIddagYzliM0g==
X-Received: by 2002:ad4:5c63:0:b0:6d8:8fdd:9791 with SMTP id
 6a1803df08f44-6e1b21a2665mr405821006d6.25.1737643406941; 
 Thu, 23 Jan 2025 06:43:26 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afbf3638sm71334556d6.4.2025.01.23.06.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 06:43:26 -0800 (PST)
Date: Thu, 23 Jan 2025 08:43:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Gendin <agendin@matrox.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julius Lehmann <lehmanju@devpi.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Massimiliano Minella <massimiliano.minella@se.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH 00/28] test: Complete the suite migration
Message-ID: <20250123144322.GK60249@bill-the-cat>
References: <20250120215340.617194-1-sjg@chromium.org>
 <20250122172449.GP3476@bill-the-cat>
 <CAFLszTi0n45THjqvt9GfDfTJxr0aAB1+r0M8EzAhGdoV4eYr3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HOg2Z/PW1SDJap/b"
Content-Disposition: inline
In-Reply-To: <CAFLszTi0n45THjqvt9GfDfTJxr0aAB1+r0M8EzAhGdoV4eYr3w@mail.gmail.com>
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


--HOg2Z/PW1SDJap/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 07:38:24AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 22 Jan 2025 at 10:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 20, 2025 at 02:53:00PM -0700, Simon Glass wrote:
> >
> > > This series completes the removal of test commands for suites. With t=
his
> > > it is possible to declare a suite (including init and uninit function=
s)
> > > without needing to write a command.
> > >
> > > It also adds timing for test suites, so we can keep track of how long
> > > things take.
> >
> > This causes ut_dm_dm_test_cmd_mux_list to fail now:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1001470
>=20
> Yes, I saw that as well, but i figured it was unrelated. There's
> definitely something odd going on in the tests :-( Have you seen any
> other such random failures?

Only the hash md5 one I've mentioned before. I didn't bisect this one
down to a specific commit since I was testing other things.

--=20
Tom

--HOg2Z/PW1SDJap/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeSVYoACgkQFHw5/5Y0
tyxJKAv+JrNI88rZ46V+Lcz9aIWS2Aj6LgQHsk45KW6aLGaD3bO6Hx+MkR064B0a
8AJS8km6puQKUjz1TsLOk1D5FG3SCqaEOrJzHX0RvUfqCSDBTw0tbU+W5xgc0FrQ
iue9aNLehGJs5XsQCwd8bdxJRlqjkCxU7guG7Dxpr3nWHnM6NpgfJ2+NgCMcE8v7
p/dIJAwPyvFp8ST9Hs85h6Kz1AiYD4fpM/r7Bs4I9H/RfDJ1Hb/NwScXp71zQguA
rfB4TOYrqbEDgNW6qm9/b7Mkig3a17aA56E+GTVxIK7bsPgdJLt7c+PH2xP33n6a
BDsHoa6VtLyHDogOn/RDaNPe7C7SgToxczdFl10+nWl7+rIm13werd1ja22/VTqV
zc3kM9YuS8D2vLHDBkfckdkZs+MqroONvrFX+AXUPVPi5xUXzdncFbyBhSN1YFPI
ykLERnOosYL2cQqHPyc9HUN2ao82bQF9WTk03PRPv+Hc5/+JT6ph2eHx6DaYBoo3
xUQgeJFW
=xwuD
-----END PGP SIGNATURE-----

--HOg2Z/PW1SDJap/b--
