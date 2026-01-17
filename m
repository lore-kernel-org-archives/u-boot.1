Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A605C98315
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 17:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7798F83015;
	Sat, 17 Jan 2026 18:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RaEUegnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E713F8367F; Sat, 17 Jan 2026 18:17:55 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E8D82BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 18:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6610ab85165so864378eaf.3
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 09:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768670272; x=1769275072; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lUSSdDP2129n3jUPYwiFOA3ExuJhIJCjk9hU8aYUEmo=;
 b=RaEUegnPxYhHdC7y+laT6xSnunpBl8bR097S88i381a2nh6BKXUmiMfolFN7JiLAW9
 8WghWnmdc2FXA/RhJFAjnWbd1fhKl2CwoD0Ai84J0LyKvKoTlBWpqg2xTkVvK4ozLO8p
 BlRQkFIOjIKu4R5dxdwwqNA2rqVKerOQbTvAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768670272; x=1769275072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lUSSdDP2129n3jUPYwiFOA3ExuJhIJCjk9hU8aYUEmo=;
 b=w9fDoJH7OErzXCwqvoBGdVUbNg7mo2HTSNI3T7FURMDu58N9ZkhzI0/0OKcsfsbKON
 MAc1dDnCGxBIURMNhoQJ347NyKH6oUoaEZijywR53fvTJlj9pACaipobIdOyVk+oT0Cs
 rFGD5LHZyKpejDz6YFOGxPm6q9Agyi2VZv2S5rlQdIDV84SF3QQ3JiO8tstQciwxctuV
 K2WBP7J2V8cb2nTC3upem7dYEDcEHcL4MsCh1m9ucCIns40aMithkNFbRC8bDUNfGtIC
 AH6yNcVwawE7f8tOjSCFiKJ9WzS23N223gJ6KxA4LS0Pe2YVb58cGR2OnJAGIOd2b972
 bZHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVW9pzREtIJXYSRJnmAHPqBP6iyZIKQ3eQCBHKwcLwMyuQtqSICwcq6qxdik1TtMnF7eCz+Sg=@lists.denx.de
X-Gm-Message-State: AOJu0YxhfYW6yJDTKESiQquXIPJ15737FW4VX6L0ZQLzgo0iHVgksnYV
 YNIIMTgLKVktBMJjHA8xqQdfHoe4X8tf5GqtOG1LQOvdCDR/tOPFoyYsDM0m5h7QFDg=
X-Gm-Gg: AY/fxX5GbjXT7SXy+kmKQKHxyHtJCx+E6pQEgq81LwE4aP2ZSfHSHMuHzY3FL2eP+pq
 etw591+5kDz2X3qSLWfcDt66K4Q08WF1zFy5MPbcjC2Pu3ips16UJoLMGwJSw+HgOnhmFiG9Uu4
 /HfgErS+zzVkoDOZY+HICRA0sAMbGVEO9DEhDVAi+Eu9SxDnLR5pVhRHfIIS4F4LplHevj1gJYL
 D84Cz2V7Ln/aZ5bkE478GoxFzhSUDdsj2zc+FjkqNMyIjbN10iNLHJAvC+cNgn1pYKtx2wGM5il
 7J/SVM/UF7Pq/aLZ8xiV3p5CiegIJwuE+MhHtBrcUs4Ob2l9iJiwvt5kgDwlc8tdY0+GvXmYooN
 c+Akc/KLBaVR5Zf99BA70TZT/vNjQ1dp/Pgo2lyDvjmljhG3Z534lc5/kurKwI1PR0pv96VV2Ed
 WkuA6uCjCFdzHPjlkWt15N5pjQm8yWhG6doLDxhihfHD28CKY2pjyxnsMEAlzsQE4sqGiCmB6gQ
 opalX+gXsESnJkBrgWpEktNBZi9RdDOvep0ymQ=
X-Received: by 2002:a05:6820:1c89:b0:65f:12ab:14ca with SMTP id
 006d021491bc7-661179c315emr2922297eaf.44.1768670272269; 
 Sat, 17 Jan 2026 09:17:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd1491fsm3825483fac.13.2026.01.17.09.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 09:17:51 -0800 (PST)
Date: Sat, 17 Jan 2026 11:17:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, u-boot@lists.denx.de,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] cmd: mem: add function for getting ram size for use in
 scripts
Message-ID: <20260117171749.GX3416603@bill-the-cat>
References: <20260117170855.533952-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j/FWGLLAxDm4RJup"
Content-Disposition: inline
In-Reply-To: <20260117170855.533952-1-linux@fw-web.de>
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


--j/FWGLLAxDm4RJup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 06:08:54PM +0100, Frank Wunderlich wrote:

> From: Frank Wunderlich <frank-w@public-files.de>
>=20
> Add a command for getting detected ram size with possibility to write
> to environment variable.
>=20
> example usage:
>=20
> BPI-R4> msize
> 4294967296
> BPI-R4> msize m
> 4096m
> BPI-R4> msize g
> 4g
> BPI-R4> msize g ramsize
> BPI-R4> printenv ramsize
> ramsize=3D4
> BPI-R4>
>=20
> board with 8GB ram:
>=20
> BPI-R4> msize
> 8589934592
> BPI-R4> msize m
> 8192m
> BPI-R4> msize g
> 8g
> BPI-R4> msize g ramsize
> BPI-R4> printenv ramsize
> ramsize=3D8
> BPI-R4>
>=20
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  cmd/mem.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

New commands should get a new Kconfig entry to enable them please,
thanks.

--=20
Tom

--j/FWGLLAxDm4RJup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWvEOgAKCRAr4qD1Cr/k
CuHKAP4rj76O9UXckZyG1eheO+cVdgtkNi4SOITF9MgP+p8YRwD9EsF4ixYoWXJS
WcZz2h9SAjYFQ9eYZQ6H6RNwn0nZMww=
=5pZH
-----END PGP SIGNATURE-----

--j/FWGLLAxDm4RJup--
