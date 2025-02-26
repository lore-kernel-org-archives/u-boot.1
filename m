Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39287C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 21:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B97DD80F88;
	Wed, 26 Feb 2025 22:20:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XloLXBxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A565F810F2; Wed, 26 Feb 2025 22:20:40 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C48E80F12
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 22:20:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6e672a21b9dso3081746d6.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 13:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740604836; x=1741209636; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1+qOjy6pfGv30j5jq+vljT/HXJf0Q1H+ZKXGlYL+vAw=;
 b=XloLXBxc2LM4+d6Y9ovO5X5yCYraV+O50kDaCBexR269cr8GS/INsB17vV5Rkn1XGE
 kTqdeVgZu7F8rwREbluYbPgzGCuG5qE/G7gCEUFKzwhI22mGh2mS2Dbk/FFDSlrFOs/E
 RCzNr11Q//UacgwBq9XybDk0ZSimeO4axP5Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740604836; x=1741209636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+qOjy6pfGv30j5jq+vljT/HXJf0Q1H+ZKXGlYL+vAw=;
 b=OPRmOn29IjOR2qw8dBGuDE249FiafmRidb+SDf0PS3ZQeIWUEtvQi6fNqiCpamdeiS
 EQRBmPnvHxOtBSzwb4sxgHPg2qZsWY7Du/CdoRtXh6dHQqg39XBXGciWgD0NtYdNJeKw
 oUbH9O8OniviZ2pcbK3oyssmOK4paDsy2WdBf/AwX1xbqLEde9Vtl1wft8ZC4FpnmRn/
 +H6/pBHFB6a7LdVOye/g/qRy963F1e8mMgxOPMnZWwLzvocHgX08yDzf4PF5lTNMZS1h
 //1IwzK2oXG3MigZfRS2gUdCs/kVtgcNddrvSak4xfmVBh4uiRfBv7OGdi/PLK3IGUsH
 TWyw==
X-Gm-Message-State: AOJu0YzF86rDEI+5h4jHLfUHemN65QCUjO24Fe6FLn1ko1AesMWUgb2n
 8z2Gqg037hJm3AIQ0h7+6NtmXnfy6JrPgS7wtrUk/tFUHjSxkoYzCzKnQOwQ0wE=
X-Gm-Gg: ASbGncuMSw0LYPjDAH9GQcxgxNoJuj/xLZCtd2S8/8OaD0a5yA3fe8Usb9GTdqBAFa7
 yY7ff0hozSHYxEDEwkT5P1SN8k+dg6iat+WeaO1IWNnMYv3urdvPUCuWSlgtQy4UxcT97FcHcs5
 Lhj0tNj9cJUXwvZSTyyxF8D1lgNFh4OASOAxnxh11N0Ggo2zxDL8600/4/svXYu6ZPMRNfsmXzk
 +ambs5dBKTgOCbyT3pxiqaaXljv+37Chh30gKGwpUtnnn++hROJBKHeqHg/LatPafitbxHQ687m
 pfi83o8AIbT6Opoa0UUCC+/I
X-Google-Smtp-Source: AGHT+IE24vyA5XaOeLAnyTY5kjJbeLua7VJIRkKKDGOQwn2gqKlJOjzPqnL82/IrHKClYVXQ9Hnk+g==
X-Received: by 2002:a05:6214:518e:b0:6e4:7307:51af with SMTP id
 6a1803df08f44-6e8868fd61emr65255686d6.36.1740604835994; 
 Wed, 26 Feb 2025 13:20:35 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8976da278sm832766d6.109.2025.02.26.13.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 13:20:35 -0800 (PST)
Date: Wed, 26 Feb 2025 15:20:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Janne Grunau <j@jannau.net>,
 Jonas Karlman <jonas@kwiboo.se>, Lothar Rubusch <l.rubusch@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH v2 0/5] Syncing up on skip-at-start
Message-ID: <20250226212031.GN2640854@bill-the-cat>
References: <20250226162621.2681677-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nfNaY0GYsvogKlAK"
Content-Disposition: inline
In-Reply-To: <20250226162621.2681677-1-sjg@chromium.org>
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


--nfNaY0GYsvogKlAK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 09:26:13AM -0700, Simon Glass wrote:

> This series has the skip-at-start change and a few fixes.
>=20
> Sadly it also includes a revert for the dm_probe_devices() patch, since
> it breaks jerry (RK3288). I will need to investigate way.
>=20
> It is based on -next and I can send a PR if desired.
>=20
> https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/24835

This is otherwise fine and I'll grab it in a bit, to give time for
review.

--=20
Tom

--nfNaY0GYsvogKlAK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme/hZ8ACgkQFHw5/5Y0
tyy8KwwAkJKkFgFUlDtOjhaT0sB9S0W2wf8y3IgiM9JtgVNC4GgOc3ChtZGffVpq
G9f1iG3NmYCIIgo1yLiDto6/QNEQOgNjSTYZD20Q3sZIdQYnJjYP+pmuBciBoIuJ
gOTzhzi+QLNeq0sQjY/IMNTSSXCACtriaZVciSxkOTkr59P7JOcbsBsZJIiwBs/S
oU2mmV/mXvXIfg8GNdAutfoEVbMT4c7aKhjTObhp0IQKOHrZR5+XciSJbPi9L13G
CXAH+IOYY/xOZTc7iJXH1WA+cy1zCTsBzG5ee5kUnFLaIOZyuPlm+uWj96IeqZ7+
bPw2uz461x9fXC+2JcqnVyPcBXFg2gkn64r/eRdjMMx0/icrSc4oCETd3vr00ybu
DKjQgTkEWnzkTqCNeR8PyUisn9w1enkjRvkITD89NfMlaUDqeE0CBT5FVkzuB7jx
lUcsUgN+CjdQ+YtK00s2rCT8eRUOamq/cOCD1NerGfb8Dq3OXVn5yfQKXrH7gOva
ubr6Iyb6
=F3r4
-----END PGP SIGNATURE-----

--nfNaY0GYsvogKlAK--
