Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A045CF8856
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 19:15:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C546588ADC;
	Fri,  4 Oct 2024 21:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sD+wAJrH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF5188C98; Fri,  4 Oct 2024 21:15:10 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C3FA88AC2
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 21:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so14371866d6.0
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728069307; x=1728674107; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W09rrDYuUBiX/otwULsya9N8kFz8RlUfaHZjr0+DRgg=;
 b=sD+wAJrHrsKTqX9coYRny3VDdFce7J2B6bV681idJYDEGVOLC9SLtbYNrd8VV25EU7
 aGVWEiGKrfFPsIIbZLUyNVUTayDMecfuK0jGkQ+7Oq/miyWZ9dgr86ewhtIfFZxLRnII
 spNv/NPLtrnYo0m/CV09mkI372IBYC1zmUDg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728069307; x=1728674107;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W09rrDYuUBiX/otwULsya9N8kFz8RlUfaHZjr0+DRgg=;
 b=OVjmeEI+MR9fuQkqLIx07LNqzy7CVAZ3cNFKzFDOT/0UYKFlSsafwSiEmEC/lT6frF
 EKQPxS5PWGndz9NeOHgyz7WkUK2CZ4QyycVjoPSFtVIKRGdJjuR4Sw+k3+Nq9L1/ugif
 bswZSh8FFT/tOCls2en82P3cCj0esC2frbs5JCgCxcqpUTq36Z9vINX0ZSXtPLMXyrJO
 k60EVHx2hfnnAiwQ/E56q0WyUBBbAw9vpoB6eoth8JFFx65qBTmQfba/aMrU/4N+qY+7
 8T+75ATP6s28g9AasT7GUSqA1Y4R1Rat5lVvsz+3/+ZAKKA7hlRjXomCC4RUvaQdsKhG
 dFmw==
X-Gm-Message-State: AOJu0YxNjuKw8T6CSnM9o/64CQ4BLMI2vtWHO9uMVMpoIqLkJmNSdJy5
 Y0lqbmJ8yzzLzgQgB0domyyfas3ktKQAQcbhYvIG118IDsrSRinAS4Slw3IV/Hc=
X-Google-Smtp-Source: AGHT+IGEpXYtafaUPfJKcr3ARFnyG0NDfseMRBi9kUnpMJhfHWhCWpAFqIrKnmjNaB0qDre3SpbiAw==
X-Received: by 2002:a05:6214:5d8a:b0:6c7:c6f7:48a5 with SMTP id
 6a1803df08f44-6cb9a47e144mr48303046d6.25.1728069306999; 
 Fri, 04 Oct 2024 12:15:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba475eea6sm1784616d6.113.2024.10.04.12.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 12:15:05 -0700 (PDT)
Date: Fri, 4 Oct 2024 13:15:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v11 00/29] Introduce the lwIP network stack
Message-ID: <20241004191501.GJ4737@bill-the-cat>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="25HinYAUWTbwUdo7"
Content-Disposition: inline
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
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


--25HinYAUWTbwUdo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 05:22:46PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot
>=20
> Prior to applying this series, the lwIP stack needs to be added as a
> Git subtree with the following command:
>=20
>  $ git subtree add --squash --prefix lib/lwip/lwip \
>    https://github.com/lwip-tcpip/lwip.git  STABLE-2_2_0_RELEASE=20

Tested-by: Tom Rini <trini@konsulko.com> # Raspberry Pi 3 (32b, 64b,
arm64), Raspberry Pi 4 (32b, 64b, arm64), am64x_evm, am62x_evm,
am62x_beagleplay.

And the Pi targets were built with gcc-13 and llvm-17.

--=20
Tom

--25HinYAUWTbwUdo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAPq8ACgkQFHw5/5Y0
tyyzuAv8CrW5Vd3Q74jF7uMLoIbiCxu52jBhzbMosot/04FeJ8CMYDff6jxmcgVj
mFPrA4BRVUU04m7tz/i29e6gOxrJwgJrGSOzUWJX4rTS6YhtrJvvKUdphPefnQR5
hygrvF7DKnITuAt0Nif1KyxNNCJq5IulvPtkZKCPiEv8ERklEKsp8WLcKTL0+Nqu
Rf+7QN4qhk/Lm3ANFZDgBKsqajCydTZy2h2XAjbp+fABv6SUlecLXD6PtyMPJVdI
GdSWFm5bbiyoroTbTmNnNKEEYLhQyLGoh3VmsjBnd5KKVRmyGWcoz93mImddye1J
6ktD4yXp+lP2D9pkBIRUEEJkiT/wkeXiavEcAzrvlQ5A0Refob8iZUFiLqwckAtO
6kGrBU0DD0tModJhUkCFe1nKvTJaBU3/W8HxBWn6KIZPoCXQyiVizO+AxUh9DnoB
gkSe8PvhwSV7jDG6NIlJ5cO5+Sd9Ddtjas/HqAlfC8J4kWgmW/Ugn7wzGKzVN6hV
fUVyIbRJ
=Fv4t
-----END PGP SIGNATURE-----

--25HinYAUWTbwUdo7--
