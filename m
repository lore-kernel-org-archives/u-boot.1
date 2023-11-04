Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF63BC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 13:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2758704E;
	Sat,  4 Nov 2023 14:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sFFmu82O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE1B8703A; Sat,  4 Nov 2023 14:57:34 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A2E870C8
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 14:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77a277eb084so185048985a.2
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699106247; x=1699711047; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CKpP9X07Qz63lWc6PLSdbLx6rPl0GKZmls9FD5fjFGE=;
 b=sFFmu82Ok8Fqm+b+nwwbU8XPH78roI1qTlmsfcGGslXP2Mv8GuqecAf+lnkRHbpBFb
 ibG/Ly/bbY41M5+zy7FM7XRABRpiLb3uojFUxQlJSs3eWLOD+JbGIy4NhUJEDrvJGMBd
 W6aAiZiAMWmAdgFfQKO5RQo+Qxje5ZbjDofd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699106247; x=1699711047;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKpP9X07Qz63lWc6PLSdbLx6rPl0GKZmls9FD5fjFGE=;
 b=qTODfmMxv5COtNMuHnaGeaBwiCFazOExuJS5UbE/gvsRsek2lwBAaT1IRrDwJSGtPC
 uWxQp++2F6jhwQV6+vllf+J7NV/daiGQUgxIM4qPk8KlxRBK3PGUzvwFfhaeDi5ZJQQt
 +hc2OSkNyX+ZpPkQsrdaeNLZ+b6/A6hIH9m7FbhZOBl2ObqQjxoDj/6Lr5R6PIREGMP7
 LrjMQ9nfKnVUfda+Lvvv1Hx1OOMUjQvKu+93TGw01ijbN4Xr/slf0qVOhDr2J04b1NQj
 rOxDY80o/5hgZpdOWv423nam9av41bkcFpz25F0cMgvZeUxKLm4STC+DUpgRIz7FKCcK
 gFqQ==
X-Gm-Message-State: AOJu0YwNLndVXgTal98nvWyfjMCS94c4X1J0pqEIC9a7VepkNL8dgQXB
 lHp5sqO/O+mdCEGYlTG0uUYtlg==
X-Google-Smtp-Source: AGHT+IFEA5QYO6CA17vW8PLiUdG/A+18ckStsfGlFxEijwVbK2h+2jap/LqY16i73dKVFkUCwjPSCA==
X-Received: by 2002:a05:620a:6744:b0:767:8e6:f46f with SMTP id
 rq4-20020a05620a674400b0076708e6f46fmr20020353qkn.19.1699106246777; 
 Sat, 04 Nov 2023 06:57:26 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 c8-20020a05620a164800b007742c6823a3sm1602502qko.108.2023.11.04.06.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 06:57:26 -0700 (PDT)
Date: Sat, 4 Nov 2023 09:57:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/6] sysreset: tegra: create arch specific sysreset
 driver
Message-ID: <20231104135724.GB496310@bill-the-cat>
References: <20231024074908.199903-1-clamor95@gmail.com>
 <20231024074908.199903-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KcdeulXO7VzZyH/9"
Content-Disposition: inline
In-Reply-To: <20231024074908.199903-2-clamor95@gmail.com>
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


--KcdeulXO7VzZyH/9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 10:49:03AM +0300, Svyatoslav Ryhel wrote:

> Tegra uses built in Power Management Controller (PMC) to perform
> CPU reset. Code to perform this was located in mach-tegra, so lest
> create DM driver to handle this.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

For the series, applied to u-boot/master, thanks!

--=20
Tom

--KcdeulXO7VzZyH/9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVGTcQACgkQFHw5/5Y0
tyyqvwv+Kg6EHWyJsvo2SEfLlsWaEhWtcNv0eyhHmNqxqUUWYVsAg2X8F5S897PF
lXo4WbGHccpV5vUAM2eG4XXjvmT1Od2gkTx1KxM147RFnQE5QPdYalJLt6rMtr25
DkZ+b8Pmj6S8hclhSpUvFQsPP5lnBwIleBas0hGbw5GYw2FVs91wpvMEKpqtXMWL
k6F5fAZCjccrg6pKW8UYYnHa73flnLx7x4y9RbqUuWeIqgICEpPOsq5YECgXNZpC
w1F8nJnQ2StmTvUPvStiE6r/ve7tAnn0hKyQdzL0cC/+UBgkMGShS4yTINGewePe
CZU/vvPBBh+a64dceDGYJBhwUQQN7QT1I4eK7BmJYppkQvrfFjx/M0jIWc6JRMNp
tun0u5ZIhZcwTu8C7SBl59gdpPDYdyuIYd9ke8PaXV7ZmHSzQxfMFJSZKki0e5eu
KhpIi7Phgh0/tVPTlgIXxr9GQS/1YU2yXTAIPSxnVbND9B6AQIcCn2q4ir+97t2Y
wsGvujoq
=H24Z
-----END PGP SIGNATURE-----

--KcdeulXO7VzZyH/9--
