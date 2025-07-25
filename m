Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F65C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 14:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFFF1839A7;
	Fri, 25 Jul 2025 16:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s7UUvdir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B836D839A9; Fri, 25 Jul 2025 16:00:43 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA5583987
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 16:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-61593d5f92bso1096777eaf.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753452040; x=1754056840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rbm3VVSKUzNDS3ZR1PJ/Y0lM4T+Bpj/t/Yi2IhHj27o=;
 b=s7UUvdirsZtLWTQFszvJhcXyNbtZZ85hz5vNTdO3sKJCb+4zqmfvfG8+EhcI1/ttAs
 UXDICOhGE3/e5L3zpF1/1BEbN9Qx2BtyeS9RueNd0u+qwzkJA7NUKgVhoEOsSfOsdoQa
 sGDXQNP4YJWsyGazDvlsgV0lQITLd26m49VXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753452040; x=1754056840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rbm3VVSKUzNDS3ZR1PJ/Y0lM4T+Bpj/t/Yi2IhHj27o=;
 b=gV1BVELzIz4Zu/3bcRrEdOhjlqw6Ez3P67Ll55Lu/RruajyIozODhTOmaSgn0QI0jF
 c9scq9xiv+5kvve4PRQmDU42oKRrrb8n6TtXUbBaj99Ln1mh4SOMmWiQJROus2c55WeW
 2h7ijQqqjf/JfQoJENcr/9DKyxT1EqHZIy5/gZQCNOePFiBqwmkEHTbn/N96uo8kawhx
 uRwL4z44j/TUjRGXARVDcurAcTt/jRc37IFlSlZN2vcxZVAlhZom8kTV955tzNGNNlet
 9j7NmsEqi8NEvYiO59SWoTAKaqKbyzHHrsEhQzFbUfqN+o17MUTsSSSX6+6GqFRjmmQ4
 dYhw==
X-Gm-Message-State: AOJu0YyBgfM5R/CCxp5NUHFX0a0LFtLRggTE3VsU037RnNHKHNMPF5a4
 KDrvszSat342IFgpiOo3GigxG2Hrnn4oruMpgdeEQYFxyKKOOv30k78LNWDAEKBRd3k=
X-Gm-Gg: ASbGncu8wX+03HaTnCzpIUGZEgSH+o1EkK3suoYIIo2WC7fHfUTWGVCahWoxxI3L9RN
 bbZjBR20aXcgYMzhySVCIUc6doEXTDBH8wrj1KWfBChu2bAWh/nvra9GQPjvA4IYyJ51F8BQ0SD
 cVFHo4yDnLn2oe75JDOsAt2La0bmrX97iVCSjwdK1BMx0AF4zXzkuZyhFAKWZ58I7zGAvHJt3gq
 vMSxEIl/h5u3OdePKaRGYmuNrXwjVA7MQaAYp//AXTd6ylT+jj/jY0MU1ByLf6p/IMG5C7rFFWX
 riK7jI2N7jQKM7jUsedTst1O7wRlhIL5kUGu0K4CGb+pgvEK5HnJWNnj4LmdwvyuEOS7PzY29kM
 XYIIs1/zETf9ytn1DaaJlivGY82Atomml8Ei1wdtDfY1I29P22aa8ziqR
X-Google-Smtp-Source: AGHT+IFKm6X+AzNqTc1p+I4l63xo490wv5d8BBbk+6rJ3CSOTGpL72Agn814KVN+FeF2w5BtrGO66w==
X-Received: by 2002:a05:6820:7612:b0:603:f521:ff26 with SMTP id
 006d021491bc7-618fe15b148mr2897382eaf.1.1753452039486; 
 Fri, 25 Jul 2025 07:00:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-618fb4d493esm507860eaf.28.2025.07.25.07.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 07:00:38 -0700 (PDT)
Date: Fri, 25 Jul 2025 08:00:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>, Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 0/3] fpga: Remove lattice and ACEX1 support
Message-ID: <20250725140035.GD1807455@bill-the-cat>
References: <cover.1753442748.git.michal.simek@amd.com>
 <20250725-residence-stingray-818201348f2f@thorsis.com>
 <5d481eb2-801e-4771-93b8-e2c6877df4d6@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZCGg5MT5mMzHWCEr"
Content-Disposition: inline
In-Reply-To: <5d481eb2-801e-4771-93b8-e2c6877df4d6@amd.com>
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


--ZCGg5MT5mMzHWCEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 02:03:12PM +0200, Michal Simek wrote:
>=20
>=20
> On 7/25/25 14:00, Alexander Dahl wrote:
> > Hello Michal,
> >=20
> > Am Fri, Jul 25, 2025 at 01:25:51PM +0200 schrieb Michal Simek:
> > > Hi,
> > >=20
> > > when fpga drivers were enabled via sandbox some coverity issues came =
and
> > > make no sense to fix them when there is no user of these drivers that=
's why
> > > it is easier just remove them completely.
> > >=20
> > > Another candidate for removal is FPGA_CYCLON2 which is enabled only by
> > > mx53cx9020_defconfig.
> >=20
> > We use FPGA_CYCLON2 downstream with devices containing Altera Cyclone
> > III and IV or Efinix Trion T20 chips.  These are _not_ legacy devices,
> > few quantities per year, but still produced and sold.
> >=20
> > If you need board code to keep the upstream support, I would need
> > to talk to some people here if we can upstream our board code, or at
> > least some of it.  That might be difficult though, so if there are
> > alternatives, please advise.  O:-)
>=20
> CYCLON2 is enabled in one board that's why it is fine until that board is=
 around.

Heck, we can just leave it on for sandbox *but* that does mean someone
needs to step up to maintain the driver part. The report is at
https://lore.kernel.org/u-boot/20250725132645.GA1807455@bill-the-cat/
and it's that there's some dead code. It's also been not quite 3 years
since the last "real" change made to the driver by you, so are there any
other general fixes / improvements that should be upstreamed? Thanks!

--=20
Tom

--ZCGg5MT5mMzHWCEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIOOAwAKCRAr4qD1Cr/k
CioXAP9PkWE0Ku8rqu8ZLYTR3Wjdp+lrE/RKFpTNx9ONq8/wfgD/amA17K6its5k
03609aaeJmTS5F3TT7WMbWrjaOQRHQQ=
=FQ/u
-----END PGP SIGNATURE-----

--ZCGg5MT5mMzHWCEr--
