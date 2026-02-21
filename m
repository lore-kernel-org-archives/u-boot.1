Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4377EC61DFB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 18:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7270B83936;
	Sat, 21 Feb 2026 19:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pEfkf8g6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F06883A41; Sat, 21 Feb 2026 19:07:28 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D040801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 19:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-41576c5c01cso722814fac.3
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771697245; x=1772302045; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dWOAUGt/EB/UfjBeo6ZUsNaAM6xeVyiPyWsbWdDXTHQ=;
 b=pEfkf8g6+zr4TvFap3zJu29NEwsAo1nX142+6vAi4pjX1om6lSYtlAheuQa4SOImQY
 VT+iLjEjrL0jcN78rcaak2MPlZi78b1jxY04o5JjLmN5vbYMzXbVvYyCk6Qs6IHnekty
 32DFmO4N3zerW0+37ZH8kETV9jQjgoFskjTIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771697245; x=1772302045;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWOAUGt/EB/UfjBeo6ZUsNaAM6xeVyiPyWsbWdDXTHQ=;
 b=JGMN0Cp6I+W7SWINyJUVYzTRjuEczVgTQKWdX6O0qzZ57PaI8bVQCCqnEiXhoaJR76
 bkk9GKzxKoTanwvTojf5yd4UyFljWoiMl5zR+o4L5uoefSFxWNGShyjyN3VkUODG/CR7
 VPCqG59OJXtrg2/9VkumVXckB34yS7DM0mmunwiijyyVUIqWjghu5wB/qRvunZuAecN/
 m3DD/tQU/pntWBWhn3HWKtP9Ekm8vaSh3UtWJ5Hp2XFqHihewh8nbXVc1pxOo9rl+sen
 c8YV4nUDsuHjEZCmtOHg7JfFUPWkPDkEjBIleYb5F3LFMkhQehsPzqczK3CoztRt5GeQ
 hyvw==
X-Gm-Message-State: AOJu0YwlcNm4MVxHtuft7o2SNdA/bsITi8CyEopbOx9nyugY+ZEGC5Hn
 ohfpMvePRuYZngV1KDtt4PRd0t7KDaDr5cVjeAfIhBRZ29xXhDB40VzouV6a5DgGhk0=
X-Gm-Gg: AZuq6aJvFbuECyRwKE/TxdPENznzgEyEjyCz3BVT+HrieBPerszLe7//GUlHjmhEfpX
 OxftxM06zig2gvCvbjHsPkkaJrTI5JdtbD2pL0LgByRAoyvBiA80Pj/ngeCpodyNJkHvO16NaaH
 cTTWfkiD9iQ1Yx8Z4S9ZMsxCB2LfYSc/EtfvpyWT3wNERrNJoiOd6ovN0qCeqAr7EsV+SMcfV61
 IgEVl0Vdu2qgOB0DcWs6zjk1hYn+OZSQVwL2RVPCs+3iR0k0WHz2Dkk4MBS8h7bKU5vGbB0GExj
 8rHsnD49/hqG8BbEkQuNzwzqirgJ3IBDcCmshuCmTWMovqZWddDSxlTfppC5MLWakl0MNAzAMqp
 lEiB+SAMpj2IR5mA2dTK7V+5nLPEOyQGzDZycNU2VXx9ENsw/MMm+ERabAlWU0vTq9kxaMC9SGn
 tDo/jO1QmwCcLzduFxfC+EiHQ0HaxwryS/bgF2HZ+ybBYKJsz3Zlt8ZFPZQYgBFRHRhcjJ7k2h7
 gvEBE4e1DLyexNa7eVKMX+P5a5xLvxkCJaeG8qwib+MPPwkG9oYNIVA5l3itw==
X-Received: by 2002:a05:6871:c8c6:b0:409:5ad9:67d5 with SMTP id
 586e51a60fabf-4157b1398bdmr2456238fac.40.1771697244673; 
 Sat, 21 Feb 2026 10:07:24 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157ca3df7fsm3216415fac.0.2026.02.21.10.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 10:07:23 -0800 (PST)
Date: Sat, 21 Feb 2026 12:07:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Simon Glass <simon.glass@canonical.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH] video: kconfig: replace tristate with bool for LCD panel
 drivers
Message-ID: <20260221180721.GA3233182@bill-the-cat>
References: <20260221174522.3106292-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vYNlLBKHB+U5IE9f"
Content-Disposition: inline
In-Reply-To: <20260221174522.3106292-1-dario.binacchi@amarulasolutions.com>
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


--vYNlLBKHB+U5IE9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 21, 2026 at 06:45:10PM +0100, Dario Binacchi wrote:

> U-Boot does not support loadable modules, therefore using 'tristate'
> in Kconfig is incorrect since the 'm' option cannot be selected.
>=20
> Replace tristate with bool for the affected LCD panel drivers to
> reflect the U-Boot build model and avoid misleading configuration
> options.
>=20
> No functional change intended.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Thanks for doing the cleanup.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vYNlLBKHB+U5IE9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZn0VgAKCRAr4qD1Cr/k
Cs6CAP9x8hMQEFBFj/zXJRoJKjxTU+fQO/fnd9mpxlEje+bqmwD/QuXyvX1v13qZ
b1ObVOFYI67wumUGG0vORoTOhNVp5g8=
=e7k3
-----END PGP SIGNATURE-----

--vYNlLBKHB+U5IE9f--
