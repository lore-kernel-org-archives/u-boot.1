Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18892CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 22:45:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7758848DC;
	Sat, 23 May 2026 00:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GO9X9wrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5260848DF; Sat, 23 May 2026 00:45:08 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD4B848DC
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 00:45:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4042905015cso6640236fac.0
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779489903; x=1780094703; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v/M8tVtzrmh+5qTrfKDAW5Hb2JckTXhyatYNMUtaUlc=;
 b=GO9X9wrA7IyMjXk/TBbn9n3w8dqZ+vQ3CcsOHACo65PdX5iePl1jPnulElDsqIveXU
 38+7eDDsuAaAPyzs85E8jZRldEXjyLwcuHsx1jgkqbMVX2dYHIBGbqni/mfevm8qFrpD
 GHTC8jSck2SUPyq/DQra+qQpZdwXOhZQCBFto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489903; x=1780094703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/M8tVtzrmh+5qTrfKDAW5Hb2JckTXhyatYNMUtaUlc=;
 b=sKsiM2aLed+m4XQUIGZ+9NDIAcB8wAoIWMjQpBNACiEaMBgosVfqfSZuX4YdVuI/vT
 IpCtcti/ZypXFljHfK8zMmqGV/Ke/s9q+Y/r/C/qaJ90ehNcTVtccQdly7/InAWNpsTg
 AsHzX050XuQ1wQbNuc0IrygpwQCm1GlBlVAE7JW+/mTzbI0avBC3zi1Y5Jov4nfb1d3K
 sp3InptHwPJpj5b6qKA/CbSrOSKAT49S9ci5+vNgSl/q3da/wGTqFyFKIwa/J8gib5i3
 Jb+ry8nAr+Cfpsoqxlaz/JO46i+gKW1S0ox3a+x0Q1RnJNdKaasHmmQZHwP2i+meBBRm
 26bw==
X-Gm-Message-State: AOJu0Ywwg2CB6lHuV6nkdKZYespa8meqxlIgRJxJYDfKUZeL4ch/u9zs
 b8VMAd4UhR1ClBwuIXKgmYC3y/c8TBO3Q5OnsQG1KBJoCM4KN2wTbJeEbt2oDN0R+1s=
X-Gm-Gg: Acq92OHQArZFKcDLEYQOFdJqlex62KXqh0e938t95sYQHafxAGyCBGoWsUFUsLfGsmN
 ugOk05zeF18egwruD481f17oV01FIYuwWmgqfCPym45J1ywqbNOEg6JcwEp/UxRIC5U+akxMxZK
 ClM07x3BMiipuZh8DnuY0VSgIv9Q30a52yH9bGAVan8lv6AmbtdPgBbxXjrdtxQAsdT4eEi1+RP
 CA7GTz26wN6lguiD6U9ngRuu4ZHgORr+ohRC8VeJFCrFMlh6ar4h0CXmSlvUjhGo0/odLXQEnr9
 mMxeduEXMkGJxboPYasN19nkpsVnzvrrUEWfc/YWTjlzJNGKY9JBHEdzSJu4ICcSIG1w7Y3fQkC
 QLQdIt1GbGkXi6JktU0LW80nEKva3oKjdnFHUX5bhO0US9g/VwxR+NwoJwfMJ01oBj2He0Pv8EB
 s3mfexrDqcAjruaVreJylepWX0B2748PBkcX5dPyVZmf7QZjb/ZSv9FEdse6bpyhI6pg2JBtiBm
 YYbqaQOotvJQGIoV03DtpqvfdAw6R88X5azc1XVhCmbug==
X-Received: by 2002:a05:6820:607:b0:69d:513e:1a71 with SMTP id
 006d021491bc7-69d7ed041b6mr2940300eaf.60.1779489903469; 
 Fri, 22 May 2026 15:45:03 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d83709124sm1499326eaf.5.2026.05.22.15.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 15:45:03 -0700 (PDT)
Date: Fri, 22 May 2026 16:45:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [RFC PATCH 7/9] test: avoid use of special characters in ELF
 section names
Message-ID: <20260522224500.GD1858239@bill-the-cat>
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-8-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ecHEuQ1qmVgSXl6N"
Content-Disposition: inline
In-Reply-To: <20260522212756.3169222-8-ravi@prevas.dk>
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


--ecHEuQ1qmVgSXl6N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 11:27:54PM +0200, Rasmus Villemoes wrote:

> While the use of the ! and ~ characters currently works, it is a bit
> hacky, and conflicts with later patches that will require the
> arguments to ll_entry_start() to be allowed at least as assembly
> identifiers.
>=20
> linker_lists.rst actually describes how one can do what the test
> framework wants to do: We have one "outer" list, ut, with individual
> "inner" lists (each suite). In order to be able to delineate the outer
> list using the ordinary ll_ helpers, we just have to make sure that
> all the inner lists use the section name ut_2_<suite> instead of
> ut_<suite>.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ecHEuQ1qmVgSXl6N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahDcbAAKCRAr4qD1Cr/k
CtTBAQDi9KlkBXJSInQuMDZkzccTtSClrNRswsml87TkpGLoogEAtlJrnsDkVuwA
pV5Rtj9u1hVp+uiq69cv8zgmGAFieQ4=
=PHMB
-----END PGP SIGNATURE-----

--ecHEuQ1qmVgSXl6N--
