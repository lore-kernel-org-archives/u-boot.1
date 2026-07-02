Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E6C43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:07:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9172684A1C;
	Thu,  2 Jul 2026 16:07:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EPXZ59XT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 887A284A1C; Thu,  2 Jul 2026 16:07:15 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36AA1849D2
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:07:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6a1888969ddso971413eaf.3
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 07:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783001232; x=1783606032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JBL7yztnt1fjSfoMvVN9zgtpe67iC2imGtPtKFVrBkw=;
 b=EPXZ59XTvudzTcn/UZQ4OzV2m5qr48lvNIY4QEZAab969c86rT7pQB79r87JNQlJIy
 l3fDRDSRGf5WImqwNCS2I6WSMy/rTiM44DI8ezaDcxp+iVhCzIvWr7J4iS3UM9D1nDn8
 E26pKej0Uk1yM/twYVSRHWqRVVfjOyzpBQQ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783001232; x=1783606032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JBL7yztnt1fjSfoMvVN9zgtpe67iC2imGtPtKFVrBkw=;
 b=Y0dr15aF2R1GXXG90k05/TmKrib6of6ILsquc3XcxEJAcF3w2Ilxiu2m24FYIBZBPG
 X/BNhhTfkooT55GOxXGY3DC11zeo9W7aO/8O6qmky5KskCWFKf8VKZb+/+bHENPplS49
 l/KHpiA3RqZkrhic/3GWUBpdS+2aTyvQsUg99LxQgrkhTH/cOa5iiehVzlA3Tv8nBMJu
 MHZDgJHU2MN9N3vHiH5ZTxlfBzasCrT4DfcFhfOrigBz/CyWOAv9TpKibI1+dj3nPFZW
 IOogWZ6fDsUAuD5vVOm9dCbVm4tpweGbZVqPagVg19Ptu8PKU9XidP0IY+/WXNRi08Um
 vlSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/vm0h+Ox7KN6pzJmTnyyla5OsX6m7KqalP+iOiGbRPFz9Y/UUcSZl5MKG1k9IsbLN1q10/TlU=@lists.denx.de
X-Gm-Message-State: AOJu0Yygqo8XO4rRR49OpvBofIOwPXl85l1xHz5QehKYsvshfgFwJr3L
 g8ncIXx/aI/rrAxlVyNn+Nz4wKc+X1n0CYyokIckTVi/eR7TZOPeofJ4oCt/Vjs8avE=
X-Gm-Gg: AfdE7cluhjzPLhfnQ5AoKkDOsmY/CPYCZN9dGPlZVu822dnfQIVvl3HgzpHu8pvfSK1
 4lgujjrifpZ9/t7gklEWLBHh0Pwe9M/3FNz9c3Rk80fiyEq/OC/ee0zY3ihgwI8tETeUOKVKgi8
 MzbBP9F8lYl7z+RnemahYlII4HwFU40rndTQdB8BWu5WCtwl4zWu5/IyKLWTSgQUs2COsk7TNG4
 /egtILJl7VjErJ4pPaVITYM9iAu6z3TrnmdqYMe9syqoMTLycoPhHndWGJBNkbG5+ExzNUttA73
 cHSQwftSvQfBGR1qO2SKlUYgUj75LquNvPx0K6qRRw4E1kaNAsW2zULFT4YdjW17tFzz/nghB+m
 DE0D8OytF3+Eice2Y55v4Ia/f/0LxNYvZxYMJWR0CtJEhleE2Ux8qv8RTC+ItKrqJnd3IDNELE1
 GCo1uFebUA7NkryOfBVzILLCDFQcOhj94lx+Sb0HsEP7pb9YvZPS4zUiiWHziYN2hgbZzlYhlbb
 LSdsOyWseNhv+9bqIKLx+hUpEaxwj1tYR4gKg==
X-Received: by 2002:a4a:e917:0:b0:6a1:1fde:c853 with SMTP id
 006d021491bc7-6a3099a2fd0mr3736679eaf.4.1783001231814; 
 Thu, 02 Jul 2026 07:07:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a30ffce324sm2243788eaf.5.2026.07.02.07.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 07:07:10 -0700 (PDT)
Date: Thu, 2 Jul 2026 08:07:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Yao Zi <me@ziyao.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 07/16] LoongArch: lib: General routines
Message-ID: <20260702140708.GX749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-8-me@ziyao.cc>
 <20260701174940.GP749385@bill-the-cat>
 <1c9f6db6-4307-4860-851e-be46ce2382d6@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cnB1PoJ3qBUwxLGi"
Content-Disposition: inline
In-Reply-To: <1c9f6db6-4307-4860-851e-be46ce2382d6@app.fastmail.com>
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


--cnB1PoJ3qBUwxLGi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2026 at 10:24:28AM +0100, Jiaxun Yang wrote:
>=20
>=20
> On Wed, 1 Jul 2026, at 6:49 PM, Tom Rini wrote:
> > On Wed, Jul 01, 2026 at 11:17:59AM +0000, Yao Zi wrote:
> >
> >> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >>=20
> >> Add some common library routines for the architecture.
> >>=20
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> Signed-off-by: Yao Zi <me@ziyao.cc>
> > [snip]
> >> +#define CACHE_MAX_LEVEL		3
> >> +#define CACHE_MAX_INDEX		6
> >> +#define CACHE_OP		GENMASK(4, 3)
> >> +#define  CACHE_INDEX_INVWB	0x1
> >> +#define  CACHE_HIT_INVWB	0x2
> >> +#define CACHE_INDEX		GENMASK(2, 0)
> >
> > I was expecting checkpatch.pl to catch the double space here, but it
> > didn't. It did warn about a few other things in macros, which should be
> > checked out at least. And that comment applies for the whole series,
> > along with a manual check for other spacing issues, thanks!
>=20
> Those style issues are mostly copied over Linux kernel counterparts, shou=
ld
> we leave them as is to ease kernel rebasing effort, or fix them for consi=
stency
> with rest of the U-Boot?

Ah, OK then yes, we can leave those if it's a match-up with the kernel,
but should make note of that in the commit message when applicable, not
just the cover letter. It will make finding that reasoning easier in the
future.

--=20
Tom

--cnB1PoJ3qBUwxLGi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakZwjAAKCRAr4qD1Cr/k
CiJ8AQDumTVeWGiNoAMDNRDtr2MkwWEN/OnZhASpXyxJos29OwEAlvsSNJAAw3GM
PDyBdY6nFqD8zinwkaYN+J0ExFHc5QM=
=6QPB
-----END PGP SIGNATURE-----

--cnB1PoJ3qBUwxLGi--
