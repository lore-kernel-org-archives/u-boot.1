Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EC0C28B20
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 00:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45DB0810F4;
	Sat, 29 Mar 2025 01:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eBUDv7aU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C14A981951; Sat, 29 Mar 2025 01:06:00 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4231A809A5
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 01:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-72b82c8230aso796693a34.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743206757; x=1743811557; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rMz46kuYFf9beXQW3eAE7DatjlDTNLTmR59Lwy+kCAs=;
 b=eBUDv7aUrww00jiFz70b4aC+Tx2Li6MUACPLUIaSSSqG/JKU9nIcatGCp/BjR4MIot
 XJu4VwHrSluqBlQ9rEKhLxrxknd4rHlvG7v+pa2e05c4VbzquY++70yYce0Tm7eFJlzb
 cRRUITP5NcdI40K2fw2AFERSBU8ob2g6QVU9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743206757; x=1743811557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMz46kuYFf9beXQW3eAE7DatjlDTNLTmR59Lwy+kCAs=;
 b=vYMFwGANlDjNCx+JxbJlFGYSEFEQGy0vLCLxUIG3NctwZDqWlJ0X4lR/WFFgWO+PO6
 8lL+7stsRdKDordK3d0dpkgYcMvLXpho8HuuQRucHMBgd5IdKjw9xiZLxg9sQK/GfM/r
 qUOPu/AKaUHhKJtrobk2Sv5pcLyVZQbgQoWC1ktRJFLEUTo0Z2moGx96VR2rgQiDyyxo
 BG72fZaSrqecrxQjRVnFEVHYbOEMEQEKwmh+KoEJwmCYsNhrhx8A64aQE1Izyf/nLEq4
 5wYbkpEcECIXGUUncTBRXv5qIBI3a6MwbCkgRjCXWAUOy+9oPeGqzM6ZRJDCaxEqpBIs
 Ydbw==
X-Gm-Message-State: AOJu0YzcGr7vsr2Uj0DZ1k2JkUw4rFB3n/trzLo6aV5l6x/HsL9FxSbC
 GXd+mEu3kr2JXOje++N12VnJ39XjH6RZVQXdxIVcW2sXQZKMEsRshdKsUUCgV6U=
X-Gm-Gg: ASbGncs1BOhpFcJyAV9MKC4XpMfnQbBq4KkhGq5GHLFgxszGb0m5hIPMuDuL1MiP/oR
 2MUDl7tB1anKENWL6pQgyXyhJtFD6eE2VwS6Cl6Wazb6+y4Qgx8YZiGBZFRYxnYkVmeDDK+RVKW
 r0b7WaA/QVXcXmT9eaXdoM5qa7PL+im/4Wt3HgJ0CSZTmFW17Oefz/kL0JzE9v8nlczhG2TKR8g
 E4IinP9V3DQ/p+SyCMGlcOdMipHIZpfe+eXAxQkhIdoc9+ubmxuahOUxF41DGrAUs9aggBGjEJP
 hYtYyszZP4GVXoG3/pl8LypuUEa3xhNQZ73E9BcVDWJwC4alxJp89HPK4NQEeM7fhY//zIojGtm
 cXRfRuA==
X-Google-Smtp-Source: AGHT+IGD/O4BHkbLLi1KDgXTJOZc4CLiOSbmDhDZwCr75vlBogqp/HsOUzLjlGq+eM3+MEAi7ROC1Q==
X-Received: by 2002:a05:6830:4195:b0:72c:3235:3b99 with SMTP id
 46e09a7af769-72c63816ed4mr788789a34.19.1743206756834; 
 Fri, 28 Mar 2025 17:05:56 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c5828b38csm546788a34.61.2025.03.28.17.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 17:05:55 -0700 (PDT)
Date: Fri, 28 Mar 2025 18:05:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] dtc: introduce label relative path references
Message-ID: <20250329000553.GJ93000@bill-the-cat>
References: <20250328163115.642347-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R605kABQg3NXpTBJ"
Content-Disposition: inline
In-Reply-To: <20250328163115.642347-1-patrice.chotard@foss.st.com>
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


--R605kABQg3NXpTBJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 05:31:15PM +0100, Patrice Chotard wrote:

> Since introduction of OF_UPSTREAM flag, U-Boot's dtc must be able
> to compile Kernel's device tree.
>=20
> Since kernel commit 7de129f5389b ("ARM: dts: stm32: stm32mp151a-prtt1l:
> Fix QSPI configuration"), label relative path references has been
> introduced. These label relative path references is not supported
> by current U-Boot dtc version 1.5.0: (see mailing list discussion [1]).
>=20
> In order to support such label relative patch references
> adds following commit from upstream DTC tree:
>=20
> commit 651410e54cb9 ("util: introduce xstrndup helper")
> commit ec7986e682cf ("dtc: introduce label relative path references")
>=20
> [1] https://lore.kernel.org/all/20250115144428.GZ3476@bill-the-cat/T/
>=20
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>

Thanks for digging at this more. It would be good to make ourselves
compliant enough to move to newer dtc wholesale, and it is a
longstanding issue, but it's also as you saw not easy.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--R605kABQg3NXpTBJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfnOWEACgkQFHw5/5Y0
tyzhkwwAjkqYKOgAzpYf7lfQm77/IhdnwVPJiW53a+03kZZz3oneuTfQBdq6e+m+
LXX7DkXHXv8sa5OOB3MhWVZoV6k9CXZWsBRQyvd+/3zWGEWxMPzEXHYFr5PM6uAv
93MjbjRblsBI6NziTJ5Nw5Soj/qL7PwFadY9QEF/O5RBseElIjeOOlrkM17FwXnb
fvb+A9ATPi67h62nCtkfhYP7iQIS+lbjSWKFf3SaCUIYrq0FP3RrPx7+dI8mZgf6
KO0ptMOMHbSjmNr8l41TUM2bzmr5InW+zGw17XAjex/nCe6bZc9oYX1HNm0Vcg1Z
Y4hRZ+EDe2y807IabK71geOLZl8GdhlJCVqcs/2EidGy9ykFOUrKhAWicmtXfP4Z
jjBnavGaawhW+Wh8knsk1jkalyMRe55ko0Ij6VumGcFD/LbCbt1Bg62UiRXk+lTw
6Ma6BCd38MHbrxGSwz0EqDql9JYVzo7QBxh2LwbTt8qHhzlpktz+0yDaRpxzTNJ7
hLWjJ/iq
=Q+gW
-----END PGP SIGNATURE-----

--R605kABQg3NXpTBJ--
