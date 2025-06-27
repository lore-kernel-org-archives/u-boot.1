Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A868CC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 20:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3E98806D8;
	Fri, 27 Jun 2025 22:00:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wi0TojIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC0FE8006D; Fri, 27 Jun 2025 22:00:24 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68ADE806D8
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 22:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2db2f23f174so1668272fac.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751054419; x=1751659219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fql1Nwfk+y1pprWPP+H5Ev6C87t04J5xsfAJLv9Lv3E=;
 b=Wi0TojIBm3i+lS+auUfa3BGEfThTjiDJFbDGRk4C4k2+zQxCKIxhXSATqE8rAu00kB
 vn6Ga48HLuWfKFqkok2mY0Um8/nO//YOWk2xlj7E2ykqFyUelSAVzIOj/EZn2FpFL+Up
 iedcSGrK+UxG4ubWxNC8hY1OO6Z7Z1OFYjUlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751054419; x=1751659219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fql1Nwfk+y1pprWPP+H5Ev6C87t04J5xsfAJLv9Lv3E=;
 b=FbkRnO2rpputFP6/RTh+VWtjaSjgUOOSUps4f/4OmUPGLyq9mIbqSGFOIQN3oyC7E4
 DmBWFGr3t6KPNue4GHbRgCi+MEbe+iYdqMGgz0qF5u2InAvvkuiB5Z1LVLth3W+AYoAn
 MfkVYdo9wzU/CjhFwQm1lK5o73QMb8kGIzVX6hrnx6g9QtYnXcyAQJzNnI2kgxoImiij
 aao7I47Eww6joifbwfSvIzd34Po6GdHV0At1iVSQP4HQpTKfZZ5P1vKHz8HFIPe7/E7d
 s8Q/rmSpLwPSHt6wtjIah8IflpvpKkZUvkAErLrWRcUC4RCJxQuopgNjX57gbYuwk2I3
 9C6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNSMPrVK0noqCywoSJug++z+rq2YMcWuV37ax0300f2ZfwrkscMnACEn5UaHTXDCHKz3MS0Po=@lists.denx.de
X-Gm-Message-State: AOJu0YyDWNRzYVGbTu0d+dRwmL3sB255gtknf1P4nJyjR1My4nOD8qS/
 DB/9pY2EC/ZJ/V+AO1zohPfVKPxVUL5ryzCMnLCxQM0y/VpPmAZfss/q1qziggbx0Hw=
X-Gm-Gg: ASbGnct61eMXdIP1FDZruCoUALX+CuyqWNZ8W9U6+JYjnzMMH30AldysfwsAyNNLkf9
 oabxJx8ea5LMsnxsl1sygC4Rxd8jJGdDxRi2nMG4UlAy7sDSzx0Sy6prx2Bz7nMNDa2J+oWQiwY
 GwITGjKd3OWWAS/SAc79SPPqzrtivPoGK5h0ITZIw6U67+sYmSskHNWgCpc7rpRGTImS5N+BYVB
 Ok1C0hDYp/2KADiVjjLb6eSsK9r5F+pxC1OSXcnS3ZMUlvrdSajJ3HL9flyiayR+Ewm5MlSY1rO
 Hn+uVn4fmcSj26v1blYMLCpIqaDfeAmT8XOYBRtNElNH2qWL3MMVDsW/5eWOPDqFIisxUxTEeAX
 44ikz4Vzs5zXXGkNZfLyQ7PKEM/yvqMeCRA==
X-Google-Smtp-Source: AGHT+IF4w34J4V1PpMx1SYPTDeiWD5VtLa/zqQ7yIIimkTMrp0hyGuvJ7jj6hMIJ9qtLxUPIaKHzYg==
X-Received: by 2002:a05:6870:a448:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2efed4b9862mr3105483fac.12.1751054418893; 
 Fri, 27 Jun 2025 13:00:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5a35sm1039324fac.2.2025.06.27.13.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 13:00:18 -0700 (PDT)
Date: Fri, 27 Jun 2025 14:00:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH v2] binman: migrate from pkg_resources to importlib
Message-ID: <20250627200015.GI4003484@bill-the-cat>
References: <20250627-pkg_resoures-removal-v2-1-86b277b02552@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iPyp22gfxVT546/3"
Content-Disposition: inline
In-Reply-To: <20250627-pkg_resoures-removal-v2-1-86b277b02552@phytec.de>
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


--iPyp22gfxVT546/3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 09:07:36AM +0200, Yannic Moog wrote:

> pkg_resources is deprecated, use migration guide in [1] to migrate to
> importlib.resources.
> Keep the Python 3.6 backwards compatibility.
> This also fixes the binman version test which failed for setuptools
> versions that print the deprecation warning.
>=20
> [1] https://importlib-resources.readthedocs.io/en/latest/migration.html
>=20
> Reviewed-by: Bryan Brattlof <bb@ti.com>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
> Changes in v2:
> - rebase on to next
> - Link to v1: https://lore.kernel.org/r/20250610-pkg_resoures-removal-v1-=
1-97a269446d35@phytec.de
> ---
>  tools/binman/control.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

This still fails in CI:
https://dev.azure.com/u-boot/a1096300-2999-4ec4-a21a-4c22075e3771/_apis/bui=
ld/builds/11529/logs/83
and also Gitlab. Please see
https://docs.u-boot.org/en/latest/develop/ci_testing.html and make sure
CI passes before posting v3, thanks.

--=20
Tom

--iPyp22gfxVT546/3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhe+EsACgkQFHw5/5Y0
tyxxMgwAi0CDxUpPoPh7vIZY4K3v0cbcVRlkP4UzbY5otYrCFNT4yQevddjEZEpi
4EZso0/BszVXL1bRJhPIyR1EIUW2hrQ6vL2RrgXeFO/Or7bYPLoUU2Q5xJn6XiDZ
dpV5V2vSkQrEcqvcB2noyWK0DbGHpUuBddQSgyFo6vGxsPrfjZMePmtBZFXFQ9Py
XMqurEp1lLgtMJw0GLaWcHFAowa05zh5vm8NFfuf5of5055B/tUrtJBO573/qkSI
QxeT8eKrO8fgFjStbUXjmyGozZakSl6VhHAQJoxcjB9qE6KZOr4pmcm+K3XXoyFY
kvR57AgygjwiImJiRcVB+ZN2NskGlJU7AK9zPviZKgltIicLXOYmTq5QNO7t1uPk
wrtjtvnf0VgtEHCKf796I7bw+y8keeG7rMcHiHA9Q10lgzRfOGpAy7a07JLp0RBO
vRij5Wp8vad2fLDr5Ppdm3/tNwX4sxUg8yZr83A3vchHWt3K9C5XaUA0xk17XJaB
va4JyOER
=Q3uH
-----END PGP SIGNATURE-----

--iPyp22gfxVT546/3--
