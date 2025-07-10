Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DC2C83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B12BA8362C;
	Fri, 11 Jul 2025 00:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fJ+Gu4jg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D19836CE; Fri, 11 Jul 2025 00:25:18 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90D79835C9
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73cdce0ee0eso377240a34.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752186314; x=1752791114; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+50ZvlNVNwEClzQyfMBvFtuoqgiUyrZYgZERo//SWeY=;
 b=fJ+Gu4jgtSr9x8Pnc8dVOfrKP5/tH2sx6fHQF4eZcll8cnLJRqweZCl4ivNlgdO+ia
 OGUkSn1k1kZHOU5eWMWfbccG6M/H3vbpi0tzMU2sfxn17Vaojc2Djqm+qhFd9pb69X6v
 NNIELcmAzvm0S5ag030oMXhpHFTYJfby6POUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752186314; x=1752791114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+50ZvlNVNwEClzQyfMBvFtuoqgiUyrZYgZERo//SWeY=;
 b=kA4E3Ys8fyNkv/nOGtu15o2xdirHj500HEnUdPU9SjV8JtLxvIBcPReW5AVRlzeget
 iTCS1sYil+yxT5GPjqMkV99hSGdYDJ6/9wbBiJXA9vS0NqUtZNwEvz4xbVEUmceG7093
 KUoavoWd7+KA1GvwuEOiO91LXjvYqwcdM3+WRaX36VV7zSvkj3j+Bt7dzKhbcvkCu4Xw
 fDj8I4uzMMiRxDEvT/HlxzmepHaygEX5mtkJ8//G0rka3T4cKLPleg1pAKGqoH5lXMZg
 aQ03IrIga2PZT9OBM/k4ru7YBN4EmjJqmu7EIE6rWfZ+RNyERmslxNjlpFWuPumZivp+
 LEJw==
X-Gm-Message-State: AOJu0Yz9yt1a4PbctSudpvQjWG5rpe+Ivid/DKdf06Z4iFcYWAFXnGAs
 M6FCvvM/ZQujo12WPM+cnUtsZqjAr7hYfQMqcNTkwmCUeUboNyPOgkVdlhVesaP8ENDk3cKlJdI
 JIASVeOw=
X-Gm-Gg: ASbGncsUYDwdGXtKp8G0t25NhPBCeKliCVTQkHIdzsbr8p6ty0OhRJB87feGLXV1/kJ
 /aR7c8P0PlTrpXpcUu+dLSfsrnz1Nzr8ADitoMyUktWw6tsoTv2WV7BP7tyB6g/Zn/iUkzj2UZw
 nOej7m8wgxDhCeLTIvxd2AVy20JSo1PYwqok+9M/Bxe0KoNYAAeQQ5bZPHtO5Rs5mdOQSf/wYYW
 3qjvnzz7KnW7pQ3CPxPQ53vRPj1Blj5QEYTM+UDQfug+hE9aWioCpwD/BmqFkCqXuhpn5zHpOgy
 6l68S7oIhYcINKaMskTQPt2h1cO8/PflsmNfEAqPiyVWWyQxfiCyN9IAMo1KSzyzjICYHmijkkw
 AqiNx9V6gmlUePRknmSeBJ2YZxTWBPbamNDfyG6ooXygesgstnoykAGdFxS1ClkobgO8=
X-Google-Smtp-Source: AGHT+IG+TUBMftVFPxySv3uF2FJchy+s93fBPvvvrpQWLLCG2YwII4hI4wi+T95pFSfScgH+mLTCVw==
X-Received: by 2002:a05:6830:4990:b0:73b:2682:5b2b with SMTP id
 46e09a7af769-73cf9de1fafmr1122430a34.8.1752186314322; 
 Thu, 10 Jul 2025 15:25:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf1064f51sm353639a34.3.2025.07.10.15.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:25:13 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:25:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] scripts/Makefile.lib: fix *_efi.so dependency to
 PLATFORM_LIBGCC
Message-ID: <20250710222511.GD6424@bill-the-cat>
References: <20250710145903.GB6424@bill-the-cat>
 <20250710144445.335480-1-mikko.rapeli@linaro.org>
 <aG_XXm3Cvm6DJPQy@nuoska>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="af1uEUZlO7datqVS"
Content-Disposition: inline
In-Reply-To: <aG_XXm3Cvm6DJPQy@nuoska>
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


--af1uEUZlO7datqVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 06:08:14PM +0300, Mikko Rapeli wrote:
> Hi, moving patch review from oe-core list to u-boot:
>=20
> On Thu, Jul 10, 2025 at 08:59:03AM -0600, Tom Rini wrote:
> <snip>
> > I cleared you patch (and moderation flag) but I don't think the above
> > works in all cases since PLATFORM_LIBGCC can have a number of values
> > only one of which is that file.
>=20
> Right. Should I make the dependency conditional to
> CONFIG_USE_PRIVATE_LIBGCC like it's set in Makefile?
>=20
> I don't see another variable for lib.a to use in
> scripts/Makefile.lib

Yes, that's my first thought as well. But that might also fail when
CC_COVERAGE is enabled. So you might need to adjust that logic too.

--=20
Tom

--af1uEUZlO7datqVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhwPcMACgkQFHw5/5Y0
tyzhmAv8DoJRBokDffGFskx+FkI2DQt7NakIaJFifqHC/C/2R1ElaS3pxklWh1Ls
3ioFUuZat4xA3Tz0Gsici2rGMmPuqj2jQyrxJrYXEgLp6hFxf8L/nP/tBuPlH1Xi
CoS4ulaODCzmkxAtYU6axqQcCH09qNxhNOKfof/aR+MG6L1/dHtYv5GwDpCQ8VTA
rGuzZhfnHlAcP3LXKCIp64Nxt3V+mDjdP5blgIWcfQZpzo44Hwbyl+5y0oNhXHfA
Dol/A/98gd91hnzbPGH6r+BXsxxWGNYYWp4huUICkotknXKBwfPROu/sCOQgOsng
z3wvfdPmsmoJiuU7weVp3Vql/JKjRCQJy90KWYCU69oDUKXCmc2Zzot94TbQ9E3k
dRUcQhVFaRcK/t7N8atfudBntkMXxqObf4hjsvXPXDe5sX29POYaEp7qI6O5wM7h
kOqEuIeatQ9K0C9RJ5+4q0uFV3rxbjeiySobtUaCV6SqBDG6PsEYo9aUcDiSNOM4
58sk+iQ7
=VmNw
-----END PGP SIGNATURE-----

--af1uEUZlO7datqVS--
