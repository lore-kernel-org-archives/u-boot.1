Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37862C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 19:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA91F80BA8;
	Tue, 18 Feb 2025 20:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="djmyyX4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 632BD80BAE; Tue, 18 Feb 2025 20:45:38 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FCB880ADF
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 20:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2fc1f410186so245117a91.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 11:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739907934; x=1740512734; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PM1I/s0l6n0r4ThcS0WGZtCJDmkf0pPqd1FgD14//Zc=;
 b=djmyyX4EjPwDz+FHr+zJNymtmUFvWgtljMk+fj6NcA7XHNm399byGrD+S1W1IjtqXU
 1zhoPUZyEY7AIi2HFoUA+snaZBj58zvVTTent2izz+WPiYTHq+9NYnOxPo6o53PswfD1
 cWJhbBy3nfWJHRSaR+sd/842tiiGei99dY0Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739907934; x=1740512734;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PM1I/s0l6n0r4ThcS0WGZtCJDmkf0pPqd1FgD14//Zc=;
 b=K4xBZ8SbczsDiJw9uhC14QsjyLr8UMTpxrxI+CYMgownq8rroQw5kR+Owt2JLdg3h2
 suos8V5NDnDVg5y3VpUPR/sWugf8O9HefgtH3K95TikI1KG0bqs4ejkv6r2HT4FJCgIl
 ww1rlL07iebut4rM93JOHmL4/0UOT6D9jDmZRkEj41C8QHVeA5EzCZYYyE5xD28Kvg/P
 ii3hZrfOUqmqC5TBKErzWLrERlG/hXi1xIGtFqcVbd5Uj30orR1s4Jki30nk37IBisOC
 HnsW+7hVkRqoK/lIi2pUby8z2e/aneiPXSdYvmqrTOrVYLgS+vVYBb9UeVRNe6cbUeRM
 g9aw==
X-Gm-Message-State: AOJu0Yzkc/MdFwZKwa5hEwrNC9MJz38GQNT++ZxL2Y5zyRxmhBMOGRi8
 RNoGKMpYVXd9IcvrBKZQBuYw+96UF3vVyul8EDLIQLtTggPxSzVJGWYNLUwbdEs=
X-Gm-Gg: ASbGncvQuGor1MQKsvNWKWCCmrSElROVee50GyVXc03WJnjsotfpDDRvHhEnq+xSfgH
 qNAxXjql+zF+Gccz3lrN9eldEAd1nkeUoJ0QFRHiTfN/ppQxOfWS4U91SoALnXOPm6GuJY7HoKa
 G4BwDanjgAAw56SZdk91RAuv7R37nsAK+SSoxqvqHO5bX+gz5G6hcvFkr0bTJ3BPE/kpiTDhBv1
 cRWQeLZf+zm/Ak+Fk5MOAPLvR/hSJj0BUAZro5WueuheZfCccLRb+PO75SW87dFuOeNDa18JfXu
 49pslxFla6C4dQ==
X-Google-Smtp-Source: AGHT+IHEWpYSFzElRyR0TMVXIMpOdHfA6xlfgRmL4yDfYLwtwDK6WTt0lEgXuVdxQqbnDgrzqWN19g==
X-Received: by 2002:a17:90b:4ac6:b0:2fa:176e:9705 with SMTP id
 98e67ed59e1d1-2fcb4d18c16mr1529557a91.10.1739907934629; 
 Tue, 18 Feb 2025 11:45:34 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d534db68sm92537595ad.39.2025.02.18.11.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 11:45:33 -0800 (PST)
Date: Tue, 18 Feb 2025 13:45:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] tools: Fix handle leak in mmap_fdt function
Message-ID: <20250218194531.GA1543887@bill-the-cat>
References: <20250209145641.635650-1-maks.mishinFZ@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cILT7tQ0pOUYVFZb"
Content-Disposition: inline
In-Reply-To: <20250209145641.635650-1-maks.mishinFZ@gmail.com>
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


--cILT7tQ0pOUYVFZb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 09, 2025 at 05:56:41PM +0300, Maks Mishin wrote:

> The handle 'ptr' is created at fit_common.c:91 by calling=20
> function 'mmap' and lost at fit_common.c:127:=20
> Added call of free for `ptr` if ptr !=3D MAP_FAILED.
>=20
> Trigger was found by the Svace static analyzer.
>=20
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  tools/fit_common.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/tools/fit_common.c b/tools/fit_common.c
> index d1cde16c1c..135e105929 100644
> --- a/tools/fit_common.c
> +++ b/tools/fit_common.c
> @@ -123,6 +123,7 @@ err:
>  		close(fd);
>  	if (delete_on_error)
>  		unlink(fname);
> +	free(ptr);
> =20
>  	return -1;
>  }

This introduces:
/home/uboot/u-boot/u-boot/tools/fit_common.c: In function 'mmap_fdt':
/home/uboot/u-boot/u-boot/tools/fit_common.c:126:9: warning: 'ptr' may be u=
sed uninitialized in
 this function [-Wmaybe-uninitialized]
  126 |         free(ptr);
      |         ^~~~~~~~~

--=20
Tom

--cILT7tQ0pOUYVFZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme041sACgkQFHw5/5Y0
tyzX/gv+IImHmrG2ddogKJCEERschJ6/hfBrp/hcJ1L5mMY6549jDgfeYi46eO5G
6fIqeSlDTv8nebnZ9Wz6b07POBfi1I8/rvela0VeDZnbTtx1aE5MReBeQyhaUfAt
zbDqm0VovPxly0/qNmAaM96UuWDmNtNLByzGrjN4wLgGmulnQq39vWo8Kgslbn3y
lQ6Y6TzU1ACWzbBsrL/Cr4X2DmID315GBCSmDnnTNH2TPy1o4y1g4cyBmmOvQbp/
47zCNfQkTgrdjiTLFOud164GJOw+O1D3mquK3Zw1m7TnAU/pS6Ud9CSWvBRCY9EV
sAMGDcRy33O6a/fU+3S7r3KtN6a4ct3GKqhmCva4RKMQcdrMdLskKL9W722fHD/t
Ekh9qbhT92iNzl0T09GNi2o6xwKkyabxFVXGzW3Iq5E8bDlDr6748K8OCadkMhyf
Dcn0KP4nmg7nUEEUaCr/NFlIirM8c59PJfBjz4rOANgansrpTZuHQ8AJGb7+Rjro
ALtqpCB7
=EoIq
-----END PGP SIGNATURE-----

--cILT7tQ0pOUYVFZb--
