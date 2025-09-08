Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4977ECA1016
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 16:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D6883106;
	Mon,  8 Sep 2025 18:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rb2UmpSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D23830A0; Mon,  8 Sep 2025 18:20:52 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493388309E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 18:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-32314296757so1666417fac.3
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 09:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757348449; x=1757953249; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N99Gn+slsOorn4FfP2IKz3XFdAqi4n3rX6CEToJeVzw=;
 b=rb2UmpSg1E6BD7/hPO70AqfxJRk5HoVVDro1a+bhmy5xExE7SuamthQINEXEeyqvgC
 lvE/xVqTq/GA5dg359eOF4f5XsNo+eSlgTlF/Sn8Qgx2d95+i3cnGOjFr+i1Tru4c1va
 nHYI2MDy74NCVnMOMd6HGe3BMw2Kcnxq3IHmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757348449; x=1757953249;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N99Gn+slsOorn4FfP2IKz3XFdAqi4n3rX6CEToJeVzw=;
 b=urquvTs/zRAgNPBWXPHqH+EmTE/0DJZUfT8WZchyoxYx6aaRSSwQejw3mhG50EmCSN
 hmrHh5SePq5y/5QIWnkkvx8Pk2x6120IAkk/H04fqnlGcEryX6m9lzDMjbQSWsW98VqS
 arNH1m80hWtT4c3l7uFA2hwUJvgWxxCsL9EDE9KZSOE1XFxDrtPw+ffQ1ul6t0oUR5fK
 0SxXRXd+VhSkJ8vvL8YKh1H5F5HbrxMVvRVZRWZkX6R2FT4VZdmcPQM3CgjFK6hiLKOX
 03eXObIjCdwnwsLIrNtnF65biZ3bqPJZcCuXZGoyzfUJeV8l8zF5vCLAALlz9TtSM5Ig
 ToZA==
X-Gm-Message-State: AOJu0YwMRFVCwKv+pskzNMcqx6oQ6vNqxGoXtighEU69aaYc8hbX5Nz6
 mAfH6vQUs+rTympJib0XeGmdkz97ZUCDHs3QCz8mpH5WwC3opE6rk3ZKpGnMo5X2H3JCQkfpnAN
 lF9vvlQ8=
X-Gm-Gg: ASbGncsNQc4hj6iTTIScRD57NNJCxiVgChGieLVwEtfsr7e0kK+q+loe7Oyiqg76orD
 yOzLqjC761WjIQKd8MdrZNnU+XGOlXEKTS6pJimSob8JGS9V0L4VwgpV/ALYcD2x86zv+ifrWni
 jpHDKW2DuudjaswyMWE+xi8M9eRhMvGLTJWOqjWWa9AhxQWsdejpnMMq/REe+3AXqW51gyNao7y
 gZYdisIgtIgMHMnC15Whwt567AK9dwJd4X6mxvu/RIprDLdGeGa2ArK+3ab+dxucOIYYijA5Ipa
 hn4YwmUtkSO1AUx+PXLtpKKCkkuvMgtNeHuT9MJHjOWW8G+W43TTGMfskI3wAXKXqTstOh6Hetz
 6SXOHGGyRr9TeaEw/tZhe8oufmXQU0lOVtw9YMdWYCZtoI9EIvFEYEAcosUoRjoAlyw0=
X-Google-Smtp-Source: AGHT+IFydACGbNN7CkkH+OJbkwjce+qPyRcB+GQFj4gQnfIP7bK3SMxIprDJA5p9SWwfdcqSt7rh6Q==
X-Received: by 2002:a05:6870:2056:b0:2b8:fab0:33c with SMTP id
 586e51a60fabf-32264a20441mr4497981fac.23.1757348448966; 
 Mon, 08 Sep 2025 09:20:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3223f6d0bdfsm2564509fac.8.2025.09.08.09.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 09:20:48 -0700 (PDT)
Date: Mon, 8 Sep 2025 10:20:46 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.10-rc4 released
Message-ID: <20250908162046.GS124814@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="58Rlp/BZ5LacDbGu"
Content-Disposition: inline
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


--58Rlp/BZ5LacDbGu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and I have tagged and pushed things out and will merge
this to next and push once CI completes. One thing I should mention up
front is that in terms of project organization, we're moving ahead with
SFC and they'll be joining us on the community call that follows the
v2025.10 release itself. I would strongly encourage anyone with
questions or concerns to join and speak up, or reach out privately if
desired. If anyone knows of regression fixes that need to be picked up
still please reach out.

We're continuing with a community meeting following the release
and once again this is the same time as the previous meeting. The
meeting details itself are:
https://meet.google.com/btj-wgcg-euw
September 9th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a rough changelog:
- Enhancements, improvements, fixes and new platforms on atmel, tegra,
  rockchip, stm32, renesas, samsung and TI.
- Documentation cleanups

I continue to plan to do an rc release every two weeks and the final
release will be 06 October 2025.

Thanks all!

--=20
Tom

--58Rlp/BZ5LacDbGu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaL8CXgAKCRAr4qD1Cr/k
CvtcAQD1w105br40HMBtXtEYjEtCTVi0E60qhmrsD9b7oAEwxgEArdZ0XF4suOKl
1f7QAgCo0Ht/1yx+pQGF6DsRcqU63gA=
=0TjL
-----END PGP SIGNATURE-----

--58Rlp/BZ5LacDbGu--
