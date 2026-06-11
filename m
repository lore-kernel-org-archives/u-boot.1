Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26447CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 956A5841C2;
	Thu, 11 Jun 2026 16:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oGkZH3QG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 184B98466E; Thu, 11 Jun 2026 16:01:16 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1506783FF5
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e6e2d54d3dso4318225a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781186470; x=1781791270; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3oRvlbwwQGpvMu+DG3jKspGQjqxh14zoCcm4x/N37D8=;
 b=oGkZH3QGoEJUoWevY9E9lL4Ybk1Wj0sCv0qonG+jAxroHmaxBnrTvm6j81QBBNiBZm
 QHV6EO0s73rbniv85IryeqRogB15EKVgCf9W1nnF6Oarjrc8O/MyJR/COIkQZupA7MYa
 /H/MciweTu/2TPjZceHzSYU4eKu2YbPGxN8IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781186470; x=1781791270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3oRvlbwwQGpvMu+DG3jKspGQjqxh14zoCcm4x/N37D8=;
 b=RGNWQ+yDgEe2huPtKXdRulhbU7ZsZcJUw8PYxMZpU6foqooskyWxUwtPc4zGWTYdpl
 BuLMWVqg/pICaQ1DZ0n9FpJBkfSQ85jHUvElFp3OoUIS2Ay9aKdy1NmSPP22CmRBlFEy
 H9XwnUWlqGsMbCTR94vvvt+C2wNq70NAwobmRI0nJkfWeyzLjUrvlbd0OmXSJ9zH1Oso
 qUKQ9ppjQ3FDtNGRtyUMcOqFhPfTvewc548PlFbmQ9agnl0IseWJBwCIpy7f4yBbOMSZ
 umiZJNpErKvh9iUL+CIgbj4k2/dBEYsjLfwduc1yB5sM1+tyj6nB0tpGF9b3+zewQbe+
 fb8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6F/Plz6sEpYkoFEX2eEX1DqOLKnbQC3fLk3OsmPjSjsS7tQcehztoaWLMCnOLmi2wfwnv4B8=@lists.denx.de
X-Gm-Message-State: AOJu0YyClvdH6d24Ty7FF9dSJVGu4BKYcQIW+ZBujyk7Jz5TVRD8cvh/
 /B3qGVEY9Y8OrBV2aMTvGVJD8tFpMUsDZLjIaaPRj1PGYa/Fv3a41PwicUyHG4U0hXA=
X-Gm-Gg: Acq92OFRxg4OKge5h+RBTczDZoaIH5eLscE+FBQVebOYSOUnBvDvgOU7KGOUWNmPjsw
 jXC3wFQ2zKWu/wIGEkhL27oBQDv1PtRYMCSZNdjLAIAHgVo8DGqcI10Jv2k4cBfBMtu9vhT2bQI
 GODAGgMu7LO2HKXAtAdnEgb53rLhyuk5Gv1414K2t907lyyG7UUNh9PCcE6zvdDbOGAOrQM0qSw
 V+dX/Z1txRxx+TBZw8Qe7XUe+2EtpY/WkJmioXhxxb/3Wo0/9aSNNmlWh/Etmo97onJvnNw2HRO
 8q8FaWu+8vO5TLtdSNM0ooSTEy3inA+cFH853AidLKNQBiRspzub22gvu16YM+yomw3Sk5oKer3
 QjR4k/q7Tcp/TkbtiapmqFitaI905ZidoOQ8ay6JOHTDiSlCNGzjM3NcqIBFGsEIpamaV1SrNDc
 zVV1tkxlIJoVpOI3rzANxeMtIEXs2xGDdL/PexSuTtOd+ztH/ZLZ9Qw2ZWRuXzsbsqmLLZ+0iDx
 pzsaX9cfHPCM/a1sB2xG8f3fU45P88MjG3l9uJu1E+X+fzLoOhESqYR6RY=
X-Received: by 2002:a05:6830:828e:b0:7d7:58b0:7685 with SMTP id
 46e09a7af769-7e7734e676bmr2481090a34.13.1781186468036; 
 Thu, 11 Jun 2026 07:01:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e7749c0d4fsm1241706a34.10.2026.06.11.07.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:01:07 -0700 (PDT)
Date: Thu, 11 Jun 2026 08:01:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Torsten Duwe <duwe@lst.de>, u-boot@lists.denx.de,
 Daniele Briguglio <hello@superkali.me>, Lukasz Majewski <lukma@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] clk: enhance clk-gpio to also handle gated-fixed-clock
Message-ID: <20260611140105.GI382693@bill-the-cat>
References: <20260528132206.2fe9f474@lst.de>
 <178118570728.472730.15075222884813417231.b4-ty@konsulko.com>
 <f706f118-b698-4ab4-8b19-9f3de0d10c31@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yHWFd9moJgKtW5hU"
Content-Disposition: inline
In-Reply-To: <f706f118-b698-4ab4-8b19-9f3de0d10c31@kwiboo.se>
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


--yHWFd9moJgKtW5hU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 03:58:04PM +0200, Jonas Karlman wrote:
> Hi Tom,
>=20
> On 6/11/2026 3:48 PM, Tom Rini wrote:
> > On Thu, 28 May 2026 13:22:06 +0200, Torsten Duwe wrote:
> >=20
> >> Devicetree commit a198185b9b5 introduced a new type of clock,
> >> "gated-fixed-clock", for which Das U-Boot does not have
> >> a driver yet. The required code is similar to gpio-gate-clock,
> >> and can be added using little extra text space.
> >>
> >> Use this code e.g. to boot a Rock5 ITX from NVMe
> >>
> >> [...]
> >=20
> > Applied to u-boot/next, thanks!
>=20
> Any reason this was applied without my review concerns being addressed?
>=20
> Please revert, or address the issues this patch have :-)

Yes, I missed them, sorry about that. I'll go push a revert along
shortly.

--=20
Tom

--yHWFd9moJgKtW5hU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiq/nQAKCRAr4qD1Cr/k
CuupAP458+Kh4KoTKWrzwXVa+eBVlOqSBiZAaHgSSLsT+YyHqAD/TmOKnrr6XaKW
82MXXXur2M5NKQbnFM2pzIIbuT87oQM=
=xUfN
-----END PGP SIGNATURE-----

--yHWFd9moJgKtW5hU--
