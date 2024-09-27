Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882D5CEBF63
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 00:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B01589001;
	Fri, 27 Sep 2024 02:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fs766I3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C55588FC8; Fri, 27 Sep 2024 02:22:45 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFEA788ED9
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 02:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7a99e8d5df1so136430285a.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 17:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727396562; x=1728001362; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D00eGuOxlGgoDy186OZLBidfXU7l4HdF8F1aAHIXuGY=;
 b=fs766I3Po3v+UFiphYcXmx5KrmfZye3X3JJdyB1leR4lnKSNtNU7nqXODpOiv5KN1Y
 Q8YSNfCS1aRt0guscxAziqyMPgqcvtLTEfurR+R2+eZpJL3VHAnl1xR8aTU7Fc8eWwh1
 C0YJFqYfTovsFk0jWwYy6v4HTr9ND1KdaTgxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727396562; x=1728001362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D00eGuOxlGgoDy186OZLBidfXU7l4HdF8F1aAHIXuGY=;
 b=bqpa6zsAu7zs2PUVXzFAtizRgjK4GnD5IcjS8YIrcc+kxN1sdJUiezG6/bFudHREj9
 iYT5MjrESOnaW7Jn0esi3zeOsjW+ZPJ8iRz44fFywodho97sMBFXrXTXKVQa/mzWofhp
 U/ezTdnmoZTwODkAPDandcRruv8x+Qle0IXjDso/2evnoVx1fCJfyey6Nx2VxSsNRcOK
 lElx3Xhq8pha2Kr1iIENo3hiCT23pAg2RMOuEEpl1qsZhbS5bR0rSnsfsSZHwzFLl7MV
 CmaSXJT7DnW6e4NKRl994lcDy/1sGTMFDD6D3g5LFxdN6TdyPASeVl3+TOgreSfgBkR7
 Cm8A==
X-Gm-Message-State: AOJu0Yz+uBPS5WeNyhv3lITzL4LXNkalZowii3F50BcxfuB55dASAIvL
 zuxN0wJuG4aNax2MaLixE74apWvyg1VDljsYGE4yONscvMf88Qpq5rLpy74xPH2FbzvJ54dmZx6
 HNhY=
X-Google-Smtp-Source: AGHT+IEu6hWtxM/uEvv5kOgaC1zZi3rkTwf6CcL2zsc6KG1eIH/E3yPyWdvF46ex6ZvzxtAd7WrvVg==
X-Received: by 2002:a05:620a:4042:b0:7a9:beaf:ce61 with SMTP id
 af79cd13be357-7ae378c0e93mr205500985a.45.1727396561703; 
 Thu, 26 Sep 2024 17:22:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae3783d25esm37103685a.119.2024.09.26.17.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 17:22:41 -0700 (PDT)
Date: Thu, 26 Sep 2024 18:22:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v6 10/12] sandbox: virtio: Disable the sandbox virtio blk
 device
Message-ID: <20240927002238.GQ4252@bill-the-cat>
References: <20240926220226.1265965-9-sjg@chromium.org>
 <20240926220226.1265965-11-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qwXjNL7JxyGSAsfH"
Content-Disposition: inline
In-Reply-To: <20240926220226.1265965-11-sjg@chromium.org>
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


--qwXjNL7JxyGSAsfH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:02:21AM +0200, Simon Glass wrote:

> This is not implemented so cannot actually be used to read blocks.
> Disable it until it is implemented, to avoid causing a hang with EFI,
> which probes every available BLK device.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Issue: https://source.denx.de/u-boot/u-boot/-/issues/37

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--qwXjNL7JxyGSAsfH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb1+s4ACgkQFHw5/5Y0
tyz26Av7BCH6CpEeZMPlM62B6xKF2m2BZeM4RrreQ7e2wtjGkuLUWIgk6Ytr2mTh
15YQbcwAAUoIub0pu+w6lx6EQLrSTvS/Et/Wdh4BbNeR+b5jiQZOuYAQGA9MtzVl
hDtemO4wHwHuj/SGFe/iKUAIXnJZ8ldfXba+9HaTcgYkM1dt4qCYz6ckQAQRXsxS
gk/MgWEvCXax7S/uBNkNSZHlhlOhzH/05E/E2QDzwU5iuaZaw+qDDas+6p0ENajZ
y3BFyXt9hz0EDAfkJzYazE/6B/srbfBGLK7qCJyEJZHAYon3zUWw9HzpOTb3RC2L
6IwsLW/CDcoBAZ59KzhuuZGWUC6mNuEmqcmrHBKxF3PbFmcvggbljRYyCw9QvDZR
ZZ2Wgj8MRR9ktwPUifuJ5YhQ4uSnAyVqwGPWaBDs48f1UZVvYbBIj5fwKfW9hxiA
aUq3aH2oSAxKOCvw6PtXjva/BLe5WmJ4e+7nm9qewcaa5cBGUuTmdvPBzxhLP5S0
hIAjmu7p
=rA1Z
-----END PGP SIGNATURE-----

--qwXjNL7JxyGSAsfH--
