Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA36C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65647888A3;
	Mon, 15 Jul 2024 16:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aXiGe0CP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29EED888A3; Mon, 15 Jul 2024 16:13:18 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB881888B2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7044bda722fso2594879a34.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721052794; x=1721657594; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E5RNt94Ppt67UEmkuZDJqK9wTuavVNQsQgp5V4FTyOA=;
 b=aXiGe0CPQR+6vUgKksCJC12xjxBYgj1kyqhnaSCTHA4E5iIqgSUYqq8p0dTd6Nt8ln
 8mS2Qg9aTqCBcucNG1rswa/EpeNhlWYNfzf/fg72+uiLZm2padnFK8nI3r9RE2mhpVoI
 NSXY9/z1RzCXh4ogtgCGc/YGS4h99XnLstn+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721052794; x=1721657594;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E5RNt94Ppt67UEmkuZDJqK9wTuavVNQsQgp5V4FTyOA=;
 b=tNOpFQ6M637uOcrqN0SnbfCuLvPn0YpKdZkB1dL6dfC9BmWGReWbTVdV+g68gGTunC
 UF3sCVrUPA1OeEU3dodfCSA3+DQ5oyRoSaoPinHU8r2pAZ+8vYSDTmiEGJsTs3TEUzHH
 uEs62xQf/G2iSlBnXRuYBxK7pg4g07aLok3BCYXSSk+UWkvcAEuJLu1qqj3Y1jAiYvyO
 DxIqqme4PjCeem+Z4wn9VYkMc2sS4TLdBqI7Fdu1GV/ZDBMfg7f1fIHEKiChMEWvDVe5
 ucaqHGIpBqpNngoV7vBlsQFtFAZGTZWsvNBwmqygOZOFf01vpuNFP3yfNJ0fYLG+l8rR
 ZoXg==
X-Gm-Message-State: AOJu0YxZlJLSlAGxYtWB4xpHZ+tBz3sPJSLUMpNQ2GExI6gbevJQdSsK
 q78U3tUgW00ShXSOuu3Lc7XYkGGXQegA33DhKqQH/xupOop3TUgQ8RaB+O/FciY=
X-Google-Smtp-Source: AGHT+IH6IL4NbuSclArQd95sg8mzDxlNH0xkp1p6IRYJh6xhSg74AlSpGVjnoTlFq132eG2nWVC5xg==
X-Received: by 2002:a05:6830:1e8b:b0:703:6434:aba8 with SMTP id
 46e09a7af769-70375797557mr20902186a34.0.1721052794394; 
 Mon, 15 Jul 2024 07:13:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d20cb3sm965430a34.70.2024.07.15.07.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:13:14 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:13:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PULL] u-boot-sh/master
Message-ID: <20240715141312.GF38804@bill-the-cat>
References: <20240713193523.122675-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hkAH9GcBeqFM3Jy6"
Content-Disposition: inline
In-Reply-To: <20240713193523.122675-1-marek.vasut+renesas@mailbox.org>
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


--hkAH9GcBeqFM3Jy6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2024 at 09:35:07PM +0200, Marek Vasut wrote:

> The following changes since commit b182816c1fb436916661949213c543bf4d4225=
0b:
>=20
>   turris_1x: Normalize Kconfig usage (2024-07-13 10:42:15 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
>=20
> for you to fetch changes up to 5485f53289b37aeab4bf20c3980927cfc3dbf247:
>=20
>   dt-bindings: clock: rcar-gen2: Remove obsolete header files (2024-07-13=
 20:08:09 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--hkAH9GcBeqFM3Jy6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaVLngACgkQFHw5/5Y0
tyzIHAwAgvC/KMIgK2yzMctrKgHOy0k2rVyYewZDaeQlbMSTX148f4rEKaT34zAB
KepM7Nzvdyuu+zpu/Y4R/C5XKuLv+nXKdG8sUbmOOBnKlyicb5g/KA7NXFtvcm3d
UBi92opVPoXsnk8WgcFpFl2IIRATwkvnBIbCduorjJkMlFaGTulWXO4N+UDGCoBj
+2VW8t73vlq+31Hp4egf0Fhb/b8FzHUoZ1JLQnWqpWwQhc+Iv+/Q4u2ZJ/jZHLr4
HQ1iZwar3bayx3l7yzIfwH2fjFLCVxCP955TdcTbUuzqJEH+vAQGmj7IslnIVhfx
C2BI4v6FKXkxPfPmCvWsdZc0/IXuaMOfYyOtPSLmqXjpCP1QwHgfFveaHVNg2IJm
IACVT6HU9t23xmM1wBTEnkfq9mQLqdQQ7WmB0zyiGjIxGGu+WPmtlgGgn6Hv4WEJ
bP1JfE/AM+XE7gekZ5Q6AsNdLkPqac5igO7j0R2DZU6iOFMC90qLr8Y+6rfrEZCb
E3jwecKh
=rw2x
-----END PGP SIGNATURE-----

--hkAH9GcBeqFM3Jy6--
