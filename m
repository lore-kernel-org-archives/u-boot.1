Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1846C7EE31
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 16:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E3982D21;
	Thu, 26 Jun 2025 18:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NQ26O5wH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A37482D88; Thu, 26 Jun 2025 18:19:12 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E2B682B34
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 18:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-40b1f402deaso634126b6e.3
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750954735; x=1751559535; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bTCE4y4hVGvxzOmH7dQivQ6y6jFkcUmJFjjmBbK3F+I=;
 b=NQ26O5wHHqjge+pADTbGtDAabm/xdx8xuqe61Vwl3oWdnfzgMYejU7On8njLRfncYn
 yy8Vz9aw7NfQL+JbQdSDmD2yLHgORLEOFRYM+dVHdX3zvrMu+l9cB4NBDrOM6eQLWdnt
 v2tDXMX8EXPBCcVKygX82XTtWgcdFbiAcddaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750954735; x=1751559535;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTCE4y4hVGvxzOmH7dQivQ6y6jFkcUmJFjjmBbK3F+I=;
 b=Y3W3g/HOvIJGhWjn8U8wcRGDb6BHInqRodg6/CQTNu/m5j5D8SlbAMwBUeJ1XdleVx
 RdbLmBOEeDjgK1tM6ErX6saH3FU6KtLWTfZW3vttRRL0z1/SAzeNsCP0th2O4FH7k5JR
 in8FzcXJzyztOSvSAEq+diFqlC+UPcQA27gXW20iPvSmb0UKiVZZn8BTZW4Sfw5UZ762
 fCsmPOvQlfVZPBXwHp/ymvIupqrCmEgvTOakl3kB56hi5m4sdvVb2SFbAbEOumVohZaN
 5lL/Y4TIijhJ+Ovbrm/fyFaJrRzjYpKnII2dD/rvi/J4JSUG3aeH2Mr+d5EzsOBKZ8Hz
 eZ5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOAVCLswl1kB6vglslPKG6hlYNJR23uV318AJKk3amT2by+K9QCTZG0kDDEnJghCBEdHMJMGA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4KEXj/NaaO23LpObr+BqDuikf74cwl2WJ7JgDnDqXLZPcsjMS
 tFjuUf4hX8+PnaVR843UZbf/XT1PMsSgLc1gRPyNX6lWCF8P2KKwLEJxkoGl2pPRAvY=
X-Gm-Gg: ASbGncuaxrXe9IA+cw/Z86NuNPlsBta8xsiYGNBI5LvkS9YNtXok2ytdnjlhwme7/Dt
 PdcaPXIAJkJHw78sQbY9JVPXADeDPTCMS0MCnTMMyd2G6bf+41RKx8BXHMhglGF2E8IAsGSGb+t
 gWssU70HP9/wQxtAd+Dtkj4MWNQECko8lLApMOqrv7yWA0iB9DQOEDp+h3k07NpDGtu0Lbd9zCo
 uOgY8VQnZhwS2jHwtB0UD6R9LMjYaEC+Cxu57ljdTgaXkfn8Z04bFDU9/KxI2V/CvhLQh/dJfCh
 i6MgU/YzY/q/Nf3TlvH3m0BuHYP7Xi34dHZBgjMhByAux7SBLD7E/zW27NUQdjwbrdELuQVUEN1
 CLecWuiOpq6Y/JudtvmpUaI0=
X-Google-Smtp-Source: AGHT+IGynIvG+CxrDAWI+H2ZoWeKOdcLnUK28SFN3iLfYY6RBamqB4jF6K/9hMzznTCeM2qjmHk7KQ==
X-Received: by 2002:a05:6808:1789:b0:406:6f21:8161 with SMTP id
 5614622812f47-40b1c27d985mr3304719b6e.9.1750954734837; 
 Thu, 26 Jun 2025 09:18:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b85a0fbasm16610eaf.32.2025.06.26.09.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 09:18:54 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:18:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Subject: Re: [PATCH] binman: migrate from pkg_resources to importlib
Message-ID: <20250626161851.GA1850221@bill-the-cat>
References: <20250610-pkg_resoures-removal-v1-1-97a269446d35@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cMRZhKFILiVkzURY"
Content-Disposition: inline
In-Reply-To: <20250610-pkg_resoures-removal-v1-1-97a269446d35@phytec.de>
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


--cMRZhKFILiVkzURY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 02:26:12PM +0200, Yannic Moog wrote:

> pkg_resources is deprecated, use migration guide in [1] to migrate to
> importlib.resources.
> Keep the Python 3.6 backwards compatibility.
> This also fixes the binman version test which failed for setuptools
> versions that print the deprecation warning.
>=20
> [1] https://importlib-resources.readthedocs.io/en/latest/migration.html
>=20
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/control.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

I had to rebase this on to next just now and I thought it was right and
easy. However, *tons* of platforms fail now, so please rebase on top of
current next, thanks.

--=20
Tom

--cMRZhKFILiVkzURY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhdcugACgkQFHw5/5Y0
tyyE9QwAtnb18zlXjuIn3ilaJpMvLHIxvr+mW/PnPtiDQVc87qhYDA66qCvCcUwe
uVRUOLcRwToo03YIkm1ViZdf1RnjCplmcWgoTzlilDJEY0S9hBAupCuehGXZG/L4
YwmZKIuyrsTI8zVm0J0EsooOu/G79cNcUkpmHE9yOVuVpJ5rrrx+gc5rLoXCG9UO
NE9mwuejaB1XZB0mTiPvYBhG/rHmzsU2KfBy+wxC90x0EUuXVXELH3Gph125TBTi
P/uv75xKwq5We3BKQ+5eEwwI+VTIba/Z8SqCCwhCqw9nJKpvbEkNsjfhAb8LDIqv
vq5nOaazHbvErh4bSHhAHWr50ljmCRNVrEFdmok9BD7yFrIUjlhNyr0hke4ZBqoo
tlZTd835usFlNARzmkh355H2wHztML5sO9p5ktvrY+/BiCMYFUS2P8Y2xhlZfXkG
VD6JWb7RkFwIZJgj3Q+n5qj5x/xQNZdG/Uhztf3fx0Da8PvgU6qxK4pIRrF5sO01
goVGXs1Z
=z0C9
-----END PGP SIGNATURE-----

--cMRZhKFILiVkzURY--
