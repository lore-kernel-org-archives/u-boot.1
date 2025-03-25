Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E1BC36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 17:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35978810E8;
	Tue, 25 Mar 2025 18:01:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bf0WXo81";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12973810E8; Tue, 25 Mar 2025 18:01:53 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1520781026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 18:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227aaa82fafso64673015ad.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742922107; x=1743526907; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8uhAmNT6aWMZVsgyYwQC1I7NGJOfuCx0J0DuA6hEygE=;
 b=bf0WXo81B3K/0wD7mF+YAFYxSEttRjJybuwiR6L0Us5aXt2xSGvhU22H4Y8SGM3/jh
 t5r49wuNw5Pf+1zXs5hrx3V6wAYDXNnjvAjMnDaFLN8aRIKqRA1N+x6xHWmSjugQM7Fg
 zqATPd/h2Xn8GpeDZa29pTZuKsqrDf78yT+Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742922107; x=1743526907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8uhAmNT6aWMZVsgyYwQC1I7NGJOfuCx0J0DuA6hEygE=;
 b=gDwmrPqADALYgvQo0lhKFMGU6nJbDo3j13P69FKe8qjkykBlNZ1N/u0tQ1QQ1S8DW5
 pIj73Th3hJJkDXkTVRMZ1n1CYf8CM9HBC911g/It7tyJfS//OFsQ+dj5gv/XYsDSsHMX
 /fh9rgWYtFlnbQM7TjvocVpGHHWI8PX06wUAynzE6Lnz3qelaR16FNKkSfF9Ur2I7QpB
 TaKS035UzAjMiilSwj5b0CZqshSdCbHykn9rhIg6ewW2Sd0I8b1SxcvRwOutBU2W8cVa
 M4CplgrMWKUPIMMxaZ15v0VlUsRFJEES0hGWtE4g6pDEipceGdkoksnfM70fzN8oqAFP
 rvQw==
X-Gm-Message-State: AOJu0YwDu45kqfAhjST9p9VnjyAMohyJX9GQU+NfRiXAUB9U3AhDKMY+
 FDjOaDXgOoHbMqdLqZkAPsDo6D/8kxqmIYnpM3UkwKCNmNKaZTveNxvCBdQpTHE=
X-Gm-Gg: ASbGncugXrFvqTYFIl6MRncRzXtSgAkP29ab09hV5q3qIIjZoYnI9MMqfkwnBurC2Ee
 wvMGG5p4Y2rlbkeP6sAjURt/TqtehxNshejz+53p6fcTfFTsF37DBw3OvOWbSCsuJaWVIJ0LnsD
 FsWFipc9G9eahJc90di/VDByrSzVxAJn6fg3pmV4d1qjRGp4hGx1tgjwalKDlV0tX4abUpUmloR
 +HRW3BxOYyBG5m93f+SERqZKsDV/x0IQBPmx0KKl8DNA/AFxGtqTR8Dv8d1VR5IRMFhM+vFxfO2
 5oq/60dqNs6rDk6zoxOHejDxIX0lyNwroyQILWJ0hGw=
X-Google-Smtp-Source: AGHT+IEZOUjVhNN+AKsyA/3n7o60Ki7AUcPhXRWE8ma5wmEnY8k2p+E75tNaFPOXgXCWalH+xcZHUw==
X-Received: by 2002:a17:902:f608:b0:223:6657:5001 with SMTP id
 d9443c01a7336-22780e07af5mr328494605ad.40.1742922106932; 
 Tue, 25 Mar 2025 10:01:46 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227e4bace33sm16046175ad.140.2025.03.25.10.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 10:01:46 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:01:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/8] env: Rename OVERWRITE_ETHADDR_ONCE to
 ENV_OVERWRITE_ETHADDR_ONCE
Message-ID: <20250325170143.GJ93000@bill-the-cat>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VbNdtRRLiOlVzyqE"
Content-Disposition: inline
In-Reply-To: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
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


--VbNdtRRLiOlVzyqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 10:55:21PM +0100, Marek Vasut wrote:

> Rename the variable and add ENV_ prefix, so that all configuration
> options which are related to environment would have an CONFIG_ENV_
> prefix. No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--VbNdtRRLiOlVzyqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfi4XAACgkQFHw5/5Y0
tyyKeAwAuLCNqbTD0P+6o/P6ymhMyP59E+MdJaqZ7OG7vYX0BQ7QuBffZRGMAvSH
M2vSoCR8kyp2slc2snOVygQuOCYyTmJCKIQwybYDZHnQZODJpg2lviY2njukFf/7
LJgjxg5EDo/CLW0YirvgbCpdkh3ljIefpaQQJFxjrQW1joRd8HynZPwCIThT8ski
NujaygOA4zm+dMk/0pzXZfkukppZpPkyU4Cyew94yXlc6We/YK7R+k9XsUbgHHmY
B7trfV09Oc5es8sR8hjB2l+gIye2mwGC5zBiKoBJ5004q5N2ZoS2dujdOjxXEFDW
ovSF/JNcFTWwDYUt1IhAXHPiZ2TSCqXAI8C0uhFYoy9m5SbNUEfb/sHEfIwzLeVb
zB6QvXCNlVYm5yo+6gfGWAYZEfRmrnRjJDeMMGgNtfR59inGrTmD+EGHlxmbxAQD
KzhUIYYWcstrDN0OA34N2YYgwcNdfSeugqzLtCOkhqcwpSCy/8JSPeCHSkBxaJ09
MsYf4dh6
=OXkc
-----END PGP SIGNATURE-----

--VbNdtRRLiOlVzyqE--
