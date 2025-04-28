Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE9DC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 22:20:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44CA382153;
	Tue, 29 Apr 2025 00:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LRvR6i34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BD418219D; Tue, 29 Apr 2025 00:20:35 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A2880FDE
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 00:20:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-606668f8d51so1274446eaf.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745878831; x=1746483631; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=50JI4P1ZIAzFEseasNSB3qURmlEcvzEGCCqSqe588Dc=;
 b=LRvR6i34cF3aeTml2Tb6LwO2vsgnurMTtB3R2SWB1BomOedcIFUZKuPj1Venno0zhi
 O28myPaH/tsiKlvG8SigakR7Sa9yXd4oH313Dp2oQNRQKkjoODN+85rM+SV8b3VjyvHF
 0M0sqTkhhJNxKMsUWv8Q2EQGKot6bAa9WxbpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745878831; x=1746483631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50JI4P1ZIAzFEseasNSB3qURmlEcvzEGCCqSqe588Dc=;
 b=WNl4kPNpjKtiRDMfuxvA/7irxpMdtDx5qClHNybcbN3Kbe5CaOtfxoYvcVwzrkjI6l
 2oAy3MOk2y7xrySrmUK3G1DwtUCaaTTljod3aQhft3PqXkPS3MBHQeveJ18EYYIB0BQI
 ht2MUj268qi0CI1fgUdmA64jc/FeYhGSni5ulOzgaBz/s/3cS8wezDfzG9uqyztv7EjA
 M4vlkWE/WcDn8Te8O2eqsa644bzk24PLfENQoCi21nZ1zqGHC8mzCdXeFPbOHWViygtE
 jjy4t2YSxaahGS0lPWtQOZnnsZIl/vQF3kZnQ5QFzi2VBJQtq8jC/hyQM8CS+dqfS5c2
 xUpQ==
X-Gm-Message-State: AOJu0YxxkK4cEG9zQ+o9fdmg2K7FNPQFcqh6w7/xYsYuH6NsiTa/NAYh
 GOr1wuRYTim5XXMe1HVTKxcPlfRTuyIORWiZgW50jmM4mvA1QvWvMqECzBjwofA=
X-Gm-Gg: ASbGncs0mtkhqqUK+arfM+BBRyxjY1hVjl3UcvIZEFGFtzqULOTRYFbHwgmXR8kHPnY
 nugJu+eMYtS9XcKDpeW6hjmfyaUNlw7Ysfz3+t2EP8Vmb85tfyIW7eQsOHTnC6NvYkgVdohObt1
 dzTjhjR0QVbw+wzkBKtVt65ODaxlpfX5DIn+DOsoFJ4gluigpS/IDudAdGF9BTJ4OgWxYTJ8hKl
 m+fN696Bsj8bqjnPBN+bnltoJ/b0XakbVzuJu9xwqmP1VaTeIG8HqXCf5hLskF/xFhc4nOwCC4g
 z8MqFShNCe73I+mFldqGLhQQfii0Q/iyAZxeqazPqEDl03GQvU5s1d38XQJRBXiIB6dmSFofM+U
 v+Ac2npVPnmM+
X-Google-Smtp-Source: AGHT+IHjAXPX2atBvbz6LQaV/qjnemcvffeis3RGeCsV8l0wLC0FjZrW3BUiv+i5/2fztt0cj/z/eA==
X-Received: by 2002:a4a:cf0b:0:b0:603:f521:ff26 with SMTP id
 006d021491bc7-60684d2f0afmr631460eaf.1.1745878831673; 
 Mon, 28 Apr 2025 15:20:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60686ec81f4sm22830eaf.11.2025.04.28.15.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 15:20:30 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:20:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: Re: [PATCH v3 14/17] coreboot: Move timestamp parsing to generic place
Message-ID: <20250428222028.GJ5495@bill-the-cat>
References: <20250428192427.3877612-1-swboyd@chromium.org>
 <20250428192427.3877612-15-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3XDNX2yFAT4NkWXL"
Content-Disposition: inline
In-Reply-To: <20250428192427.3877612-15-swboyd@chromium.org>
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


--3XDNX2yFAT4NkWXL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:24:21PM -0700, Stephen Boyd wrote:

> Move the timestamp code out of x86/cpu/coreboot to lib/coreboot and make
> it generic. This lets us migrate the timestamp table from coreboot into
> U-Boot's version of boot stage timing and use it on ARM based devices.
> ---

You missed your own signed-off-by here. It seems fine, but I don't have
the depth to review it in detail and provide a tag.

--=20
Tom

--3XDNX2yFAT4NkWXL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgP/ygACgkQFHw5/5Y0
tyziFAv/ek6zTVgOwDOVb2XICDURg8jT3tAxAfxW+GwkarJ3xHuONSZeZkK+E37+
D7l3uTGlG34mQ4WVOJLhG9cIkbOOjg2p+6gyzI0A4Y9rpB952E5c5yKTIW8jgltq
uoQuxMeRYZr0S3vu6Z0XklsbPdKpIeLfvjrujPxf0E43Z01D1r+zM6ADsBnZyQR4
m6BPQXo8EouEE/lASWGwinc7vn9KRdePARjOihf1a/3SecaZTqyte+eOX6aia1sk
Vk48p2wUC1JZ6zCl69nWbdQkEFIgI2uN6el/mTDb9tNePnNUn527SaEs5YaNdk8N
PVTjgEqRjhYh6k4r+Uia5Jj+MWuICB0HM8vfoXMxCh49Ur+5R5CJT8HiMHMmrrv6
me9NUJD1rnwUqKyJPUC7sPuM1x8X5KFIJfcX79SYBL+xsArQN5OwvddjGFWtDrKv
dVYXStjBoaXsy7p39Ef1IN6MIRElxqzBzjz1OxpXDEm+T4pY1RdSezm7cXQi+2MR
kbKDqVKr
=+dG/
-----END PGP SIGNATURE-----

--3XDNX2yFAT4NkWXL--
