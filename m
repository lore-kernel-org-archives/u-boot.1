Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC39C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 21:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E855187505;
	Mon, 30 Oct 2023 22:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g+uRGByl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7165E87508; Mon, 30 Oct 2023 22:35:40 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0D8874B0
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 22:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5a7b3d33663so50007687b3.3
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698701736; x=1699306536; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N7W8zE96IIcHxX+OPQBkDmD/nNHheFM9ViE10G3yblY=;
 b=g+uRGBylkJHoOkAVySdZLLxdNEroDY5l2u3J2K1+e3L+5YP0AyZNFb+M18jzEKbz/Y
 Q3flEYDcQG8lmeCyd0Z5rPNhM1yrSNDpy4tbgek/16BoNZgAZ0rKoYOK4ah8zyRuKqqw
 HX8p4uX+kqG5OJBAF/t5Cn5QUfd6SJM8JqV50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698701736; x=1699306536;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7W8zE96IIcHxX+OPQBkDmD/nNHheFM9ViE10G3yblY=;
 b=euS0UuP7pmkeRB1OCUyVEWMB4FESE3EA+3PmhpaJOV6YYzYQ/q/2kJSu7pKJVPznrW
 o6Tto4M88KcfFvL6hCTvb1Ve8kP4h2dCSw5bxCLQe5dVu4NQib/izGpqnMJgW6tO7mDZ
 EDYME8r1Glz/U0v4AiAj0pTX4Wyt7HQQOQk1Mq8PQFE0O1Ifv9fjYZ4xJV4oWTyd+01w
 iM3cviPvU7TR7BZ3SB35NuFF01kKl0w2BcfchAJnWm53VxlvzjVe0sJmjtCtHGmc9Fj4
 rMRpLd0pQQWb8DYI9w+seBAwsFZVC9sQ+tXgVKd6NjCpFJDELdC3OFZ+SZuTPQIt+xx3
 kQpg==
X-Gm-Message-State: AOJu0YwRyviV/iPyWqbsUtuvaKh7UMm5XgY5RIa5VaLNxNc5iaCY9CiM
 2U/qi24M+wR39yvcWd5S13XjTw==
X-Google-Smtp-Source: AGHT+IFqyPeWIGwKrkJEq12pNp4vRhABmZJGtoW2nft6uVI9jXhIEiWVZfxG/y2Tla9wnGIGRTCysQ==
X-Received: by 2002:a25:ad03:0:b0:d9c:a583:9db0 with SMTP id
 y3-20020a25ad03000000b00d9ca5839db0mr10099792ybi.39.1698701736499; 
 Mon, 30 Oct 2023 14:35:36 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 r13-20020a0cf60d000000b0065b12c7a48dsm3746877qvm.133.2023.10.30.14.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:35:36 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:35:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PULL] u-boot-sh/master_tmio_fixes
Message-ID: <20231030213534.GY496310@bill-the-cat>
References: <20231028155605.1983833-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wqb1Iv2Znv7ikM59"
Content-Disposition: inline
In-Reply-To: <20231028155605.1983833-1-marek.vasut+renesas@mailbox.org>
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


--Wqb1Iv2Znv7ikM59
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 05:55:35PM +0200, Marek Vasut wrote:

> The following changes since commit fb428b61819444b9337075f49c72f326f5d120=
85:
>=20
>   Merge branch '2023-10-24-assorted-general-fixes-and-updates' (2023-10-2=
4 19:12:21 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master_tmio_fixes
>=20
> for you to fetch changes up to 1332bdc2df7f71727e3cb9ca3f45b27b9e7b5531:
>=20
>   mmc: tmio: Disable 1/1024 clock divider on Renesas R-Car platforms (202=
3-10-27 11:21:28 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--Wqb1Iv2Znv7ikM59
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVAIaAACgkQFHw5/5Y0
tyzrxwv+KZ49g6J3rsq/vAOdmPF9DxGss1HOAuwDcNiFY0/peiRXts/3VDp9JZpZ
H4Wu+iZSDhtpLoXhPxGSvCmBN61+QpvhdF5FAZxiJvAwrvu/OkEzA2Eq8l3LZI0O
MZM5cuZerKgvpYxzbSnKFNRqtAJ/XKN0cMzwTcvhg/2Csgw97/Aaes4WckRur/hm
hPRa+GY2Dag6/8RkgbIM2JsXxthBvwNMT9pwmtJzwSm/9I0Ma8ybyjRnyomntZMN
DQ+tPXOAjbHnoAvuvDOJLpomT1aP87vMQQEk0X2hX6i5GPy6NUqZnBv1z/mhjZTK
L0crePPADfEt6mhebosdtRGCDMOSerJn5giNcC9wL37nUYBQnML43v5C2QZdxRf0
dbDTfSrzelgbNx9BXVuvP3MrHduGlSgD+QoApHajb9KH/gt7guqSblsGNQPao9nO
DAKxrKrv7QVOOhl2Qsr2GYg3VPmFqDuwkR/h9EmPA6Mq0v2o7ZWqm8V5UzJqlz+n
Vk4WEc92
=UVae
-----END PGP SIGNATURE-----

--Wqb1Iv2Znv7ikM59--
