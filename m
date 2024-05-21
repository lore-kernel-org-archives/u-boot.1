Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FCEC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F9D8871D;
	Tue, 21 May 2024 18:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="htEkFc+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A49DF88778; Tue, 21 May 2024 18:47:05 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D12987FA7
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 18:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6a8691d724eso2538106d6.0
 for <U-Boot@lists.denx.de>; Tue, 21 May 2024 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716310022; x=1716914822; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DsB3KGP5CVuD+nyyraUDB5udqrRiwpAibAG+OAG6gGM=;
 b=htEkFc+7wEt9Rr6za2ZaehI5ch3ZUVNGsH4HxfW9rOT31ZHXL9DohKPEjUrLJ8+hKm
 pTq/D4tMJsKoXpZ3RFUxLk87d1DgjctBUoSoNzwyQkBwLFHBXdoLdFlXXpr5ZhfkL7t0
 7D2svDlN5ebwvImfJgYoFeOMD7QE6Df9m9s94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716310022; x=1716914822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DsB3KGP5CVuD+nyyraUDB5udqrRiwpAibAG+OAG6gGM=;
 b=CAz9zbsGWpLlcOa4A9NhZ58vQ5IMM30v77axwJzRWyL0iJbdijJTjE/hMD4u+ehxw+
 McH/kgh8B8Iw5cdc39xiMDpfITCJd6xUREPF+cADlcrsOrImEv3M7CkU7WdwPBTXDZEr
 QU2SnkcETgdMtjYsSlkUU/4q5XIIsz7symzI7OC8vt0jC48oF5gp9z1PhnWnjJP6MoJd
 mWUOEk2N50U/WkLPu42QFjjt9jgTe0FyHAa03oK4KY4wutLoDrABErnUfc1BNWEZ1BvA
 ey+CD/ew5zdS8MkfxSipv25/r+7+XHwpkdS2XYkssoDj3oFxyIweMTACNJXT1ZXwcuaY
 fqHg==
X-Gm-Message-State: AOJu0YyLxKh3lR+hlAstFDSWMShAX4WbivopismQKioi7zXPQa6mkmGr
 NwSb1qCelFw7TnG29rbnYScNS/UcZ21GgbbYuu30ERWeDYpsgbV1nSy4gkGdlboY2nmNCGcLxwh
 e0JQ=
X-Google-Smtp-Source: AGHT+IGD6zbT0N95s50IQWaMJ4wXGOTP+v90wsOHSvA+rH5af/WWpltroFWw1S+bjiJ4XFeNWPaVUw==
X-Received: by 2002:a05:6214:4291:b0:69b:2897:4fc4 with SMTP id
 6a1803df08f44-6a168240335mr427002016d6.58.1716310022388; 
 Tue, 21 May 2024 09:47:02 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a941c29753sm30533686d6.18.2024.05.21.09.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 09:47:02 -0700 (PDT)
Date: Tue, 21 May 2024 10:46:59 -0600
From: Tom Rini <trini@konsulko.com>
To: "Brunham, Kalen" <kalen.brunham@intel.com>
Cc: "U-Boot@lists.denx.de" <U-Boot@lists.denx.de>
Subject: Re: [PATCH 1/1] Added arm64 assembly for examples/api crt0
Message-ID: <20240521164659.GZ2568172@bill-the-cat>
References: <DM4PR11MB5296B1B9F0CFC701A8B11284E3EE2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <DM4PR11MB52961423BCE12552857A12A8E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
 <20240521162543.GU2568172@bill-the-cat>
 <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kP9kiI8Afegb1IeN"
Content-Disposition: inline
In-Reply-To: <DM4PR11MB529670F5CFDA6B4EDA7B7206E3EA2@DM4PR11MB5296.namprd11.prod.outlook.com>
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


--kP9kiI8Afegb1IeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 04:44:54PM +0000, Brunham, Kalen wrote:

> I don't specifically need API, but today this is needed to enable
> creation of standalone applications which does work on our ARM64.
>=20
> If the concern is fixing this startup code, then I can come back with
> a change to the KConfig and Makefiles to enable compiling the
> hello_world standalone example for ARM64.=20

But still, why are you doing that? Removing the standalone API itself is
on my TODO list, so understanding why someone would be using that today
rather than just making an EFI application would be helpful.

--=20
Tom

--kP9kiI8Afegb1IeN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZM0AMACgkQFHw5/5Y0
tyxLlgv+J5ioDSUe675uJmt/hawFyR12Ry1BGesXTzz6gbGd24+zEBp/Yd4DoTLq
RYNXTPJWE6BflhfUjuE8LQ7w6LXaiuF0h6uAOI/13gktQGmxAY5q5BvtPqHwA9f1
So0OzmXW3SJj5O/MBA7pWz/psLkksytH6ZFPRafjOj94YZkOCjgGzRlqWEkI213U
PVcwSJSP0QgtGCBbm+8rJEFcHtqMgh+cJpximebtbVDQ3B1XuReqRQJxllSNRk/M
gs/htR9Qi3+EgUaMsYtRhWKUCfZM8IcfmvB0juNqGP67yJtWwVPfMmz0Ah+fIElX
mM27VpVgQMaqCuf/9p6d0m3019hyg3Qf+Fa6hKcFtOBPMBZCxSyBOBjaNLSXksmV
9YqPJFqrcjrS40y7bJO9hmEpcHb+zokAtVw9qQQ9UzU0bBGLzGSLY2IhraOL9Mws
rKYLm9jtL1ggz6vaDdwqNRoobG8pCTJfKM+tkjxuldHSNAT2g+NEx6F4bKD335T+
OHkBcfbo
=mHdI
-----END PGP SIGNATURE-----

--kP9kiI8Afegb1IeN--
