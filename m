Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF163C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:24:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3498B84C25;
	Wed,  1 Jul 2026 19:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OdLn+FyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0B084C33; Wed,  1 Jul 2026 19:24:35 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14E5E84C19
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-44868d6a066so306448fac.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782926672; x=1783531472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jDx6/ZG5EhtTZoQaJhL3nnYVLDO0tIZFR9DW/eKqhQ0=;
 b=OdLn+FyXfpzTd1jch64yepMbuEqLCQvl49EYCkY6VnmS+JEzrsGP18hRRIJYYwnlER
 yj2Zsaabn6W3z/NzPKUBFrt3HWisyNx+2SQ7CKZ1aP9kBSazT/bc9NrnlXp56TM+jxMf
 CEDYT02pUuPDi3ue8HVqfZqBOTAO4cH3VTLEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782926672; x=1783531472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jDx6/ZG5EhtTZoQaJhL3nnYVLDO0tIZFR9DW/eKqhQ0=;
 b=Yf4p1Y7zXO8O+ZrWOgJhVJRTU9wMRa5AYyoXpBMq8F8jNI84X4N2hfnW3sUe+Jvq7S
 s0fyJLNZgvg87mpJOWDdYaSo+AepxYkKolkagJ69DvjzcOg88YOzhE0B7AJCTYgzU4Op
 pZZ0Wmv4xvInDtd4S2JKRAQKgcf+FNHMXd3S01pMrFAwNUZaHIflGn1hTYJLBwP0XUVZ
 C1fjvXUojp7HHD8BDynQ7A3MsffgbQZ0CvetAeadPIJw5yaO7WjJ/2G+Cz12DuLNy+kU
 xCTtBrarhE+wtny+G6ZdFpo+KCqklzGXzM8ncdHJLOhB6elgFEuPtjq4Uhbn2sdD+n8P
 3J5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9A2afwGFX+VFEwyqQTOu79p5hc6Ij4t9B7I+OUX/4mqk9FxrcRfxOqx6Ev1ET4XwJ2a97N9rs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx5JP4nVmytXkAtPXBSPND4WqCAF8MMeEnnikU9QQvO46/Nr8C
 nJuhY3Vkw2RXNpec+YfMcTAGa0lh61I+L+cdBzfIkloSCUC4ggJ1BpeHmCorf7UWE7SyyWePyEj
 LQgkj5X3J6A==
X-Gm-Gg: AfdE7cmgQ6u/7S+rcnROBTzk5TyH7l+iKXh3Xs1cKA2dMAzA3/ZE+Y3PAqKDXWVcApQ
 g8O2x/pdMnwq3YC6AK+7j1BInNVf/eJKblw9IwvRb/hfqD94gvHQVrJlvhgzufXNR2F3GsVpKk4
 8tWgnhff66A8uDDlzAxH64CAt2v5Yuh0ofPyKXRJRA5Bbw+z0TWvsP9pmWKR5KdhQiXdU1h/IV8
 bRbTamXnrqQInmTyKO5IAijYYfL9Zy8H1WfyLq5gsz/ZxfAH0RZ4oAzk90d7eNhNjf+t1LTQMSQ
 kXhEK3M6K7qRwuQxu8DPGquE56PRyIx2C0jJzvLjC/HP22cHYj514WWI6JXZ/b6deQ40KFqUO+H
 AHlnlX093hl+0STM0NsKV5YgvwJJfM9I8LjjgbdZdRoXkOhQLt8+dNiPr4zP3oEeD2ploP9yv6U
 HNZfxJAg/ZFhvjzKYET3dc+wa4pq/cyDARgreascJ7DpzijMCTlHKY9fALoGJmv5Ka0lVsK8FHb
 3vLEaZAf0IbPXN5SyDAuUh8WQ/kxnpj9PBAIQ==
X-Received: by 2002:a05:6871:2b05:b0:43d:1689:ed9c with SMTP id
 586e51a60fabf-44cab5d6565mr1464215fac.18.1782926671648; 
 Wed, 01 Jul 2026 10:24:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbed29e7asm299691fac.13.2026.07.01.10.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:24:31 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:24:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] get_maintainer.pl: tighten up git contributors cc list
Message-ID: <20260701172429.GL749385@bill-the-cat>
References: <20260701095003.212997-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H8hOnGIxW68GMd2U"
Content-Disposition: inline
In-Reply-To: <20260701095003.212997-1-casey.connolly@linaro.org>
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


--H8hOnGIxW68GMd2U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 11:50:01AM +0200, Casey Connolly wrote:

> get_maintainer in U-Boot is configured to include contributors and patch
> reviewers from the git history in the CC list, going back 1 year if they
> have contributed more than 5% of the patches.
>=20
> This is well suited to some core U-Boot code that has a long history and
> doesn't get much love from any dedicated maintainer but for newer code
> and board code in general as well as defconfigs it can be frustrating
> for some contributors who do not wish to be CC'd on patches as well as a
> general issue when dead emails are included.
>=20
> While it would be desirable to just remove the --git flag and encourage
> those interested to configure lei or just add themselves to MAINTAINERS
> it perhaps makes more sense to phase it out gradually.
>=20
> As a first step, reduce the time period that will be checked in the git
> history from 1 year to 6 months, this still offers plenty of leeway for
> contributions to the last 1/2 U-Boot releases. In addition, bump up the
> required percentage of contributions from 5% to 15% and reduce the limit
> on the number of "git maintainers" (i.e. unique S-o-b/A-b/R-b tags) from
> 5 to 2.
>=20
> These changes should reduce the size of CC lists while still including
> recent active contributors.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Cc: Marek Vasut <marex@denx.de>
> ---
>  .get_maintainer.conf | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/.get_maintainer.conf b/.get_maintainer.conf
> index f916cfbe480e..302fcee9699f 100644
> --- a/.get_maintainer.conf
> +++ b/.get_maintainer.conf
> @@ -1 +1,6 @@
> ---find-maintainer-files --git --maintainer-path=3D.
> +--find-maintainer-files
> +--git
> +--git-min-percent 15
> +--git-since 6-months-ago
> +--git-max-maintainers 2
> +--maintainer-path=3D.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--H8hOnGIxW68GMd2U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVNTAAKCRAr4qD1Cr/k
CseDAQCjTA7wUm4UVZ2EXalxyKhvSCzvPBk62MSDwCJ2YumtcAEAmXov+v7GD9V9
YpYl/0mAkS56okL952biaHkqBBYhOQM=
=4iGo
-----END PGP SIGNATURE-----

--H8hOnGIxW68GMd2U--
