Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8362FC369D5
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 22:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8410182918;
	Tue, 29 Apr 2025 00:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FBM/P8Md";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C6482918; Tue, 29 Apr 2025 00:21:07 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A39E880FDE
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 00:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2d0d25cebfeso3655568fac.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745878864; x=1746483664; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8sbUA0WsEvtWbjFyt0xNYVDgNVy/aD4uI9lAQ7wcQ2g=;
 b=FBM/P8MdCE6Z1pLbpMKFq10e/+OsNxCxqvCtvXlOP923y7TNNs8/v2DZjbMbVKLyBt
 9LSKQ6zobO3MrkWM+uQoOnNl+amz2j0h5+hT9kCvO7MNmorKD7PkMZlkRKFs1fTuFmm1
 gqLc39M4w9r9T7uedJaklPfqVpQqAqx2HqoGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745878864; x=1746483664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8sbUA0WsEvtWbjFyt0xNYVDgNVy/aD4uI9lAQ7wcQ2g=;
 b=ebCmdM5OTmM8UM9sgAbOYsNZLzeHHsLtmAfCgXWkCdob+WA/wYTYqJyUcmKS1BRTcN
 f9VOLhZXMdrxJqyb+CbQqwSD7ThI+IYDPEl/hMQPpwEKjDXfUusjTVPeXtCsuIMn7NGi
 JVo8wtg8zF8DKXK0WC3mIaRnxlvAYUPi8tS6mksrUR67WFZcC8hGeR/UHnUWVQU5Yh1c
 0yfqxJ6YJsguJxQJHY4eGzOp0j5L7QbuAVxnwZPQCHBf/JEy9iC9ye8Ht53DbmMCXlhh
 8/q+TalmgFQxKyHWjrzAmdF7n74IHS0CuPRx1uLC5hnoZ7EOunf8nv4Cbt4GcpyhJofF
 ysuw==
X-Gm-Message-State: AOJu0YyyjNtIr3FSQsUkZwwl18aBoFIuRrOBuiLZuIe9ueZLYjytdh22
 D18xgrt6PdQkytijQs/qsXgek34id3CXQcYrCj3vgGWG5h0+GItcZkd0eL90OX4=
X-Gm-Gg: ASbGncuIbYSE3aRls0gAlv1DddgvQTejanJRJ5VPkAdQzIip2Mt3+OvB0/7x5YYG56r
 St4ew0//lNVIFt7NR5WXvqaVpALsCBWjOZbmfVF1hdAmq/ZNqc1RBEv3VgX0d+Qzj+sRL/H9Ts6
 NjSeiAU/XBj7DyQbrkKXKNnujfTPyWkd0HGwb1OcYBVDwXMxN9uDjhICsnb8H45wXPKMWzZj2nn
 UZRMKrB/mP//hCpuUM5ruU8AyX/HXI05+E0VfGqT8T1sGwo+ZDo0bE3LJqE8wfMl8g+j7hqQfy+
 xzy88AAa8BeQz73tNv9FIaa/dqIxx50zPodcZAOtI99Ug8YdBcswkrYkfkHN18sBaN3P5wTEKIi
 xlw==
X-Google-Smtp-Source: AGHT+IGYQoY2+zeIoQ3L9ulELg4Cdneg1NU7I/NkE1ovzt7cTNJTy3GZWzBOWPfBIEdZMcGKcLEYkw==
X-Received: by 2002:a05:6870:b022:b0:2c2:2d0f:40a3 with SMTP id
 586e51a60fabf-2da401c9004mr752281fac.31.1745878864262; 
 Mon, 28 Apr 2025 15:21:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d973b7889esm2530174fac.31.2025.04.28.15.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 15:21:03 -0700 (PDT)
Date: Mon, 28 Apr 2025 16:21:01 -0600
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
Subject: Re: [PATCH v3 09/17] cmd/cbsysinfo: Skip the CMOS 'option_table'
 when not present
Message-ID: <20250428222101.GM5495@bill-the-cat>
References: <20250428192427.3877612-1-swboyd@chromium.org>
 <20250428192427.3877612-10-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oQllR6CekXee55rh"
Content-Disposition: inline
In-Reply-To: <20250428192427.3877612-10-swboyd@chromium.org>
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


--oQllR6CekXee55rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 12:24:16PM -0700, Stephen Boyd wrote:

> The CMOS 'option_table' isn't populated on ARM devices running coreboot.
> Check to see if the pointer is NULL and bail out if it is.
>=20
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--oQllR6CekXee55rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgP/0wACgkQFHw5/5Y0
tyxingv9HrvN/cJfKtFRbwgGYwSHNhoqmcUMg2bAeV1Qh9E353ey+wkQ/4cuQ+Zf
axNvfIvvoKIhoeVVznIEgxqt+Ga2dZjqrLLnwpT1M/jYQhgX0XnkFcwruSgABsCJ
sv82PSxqmnTaIM/jyTc379GQhvaAqD/IeLDrRpg9JzzGIryjUVmeheOzdhfwqEre
k/u5R4FpfywB8ZQTiEswxfk/RHZ458xA1V/bWm1/tspq1izpTs2HGhP6Lf7t09Ll
LMTrs0ZQH3inEI8eT0hjdEm8D2sltTim0Jnevh+iy2pChotzUEUIpPFr4Rw7i+Eo
jpF7I1vyxcN1rYtrwqu9hEeUN8uDBiGjNpzwpbbOPNISgr6oXycYM6a/+pRvs998
kdCxfkGZXeHFOBOWVwpLAjVNwTN0vla0nXjG3nkvEPMZd2KSwjx1qB5/dyIiCv4w
ofPocq4YhW2eOIjxOu+SV/Azmqu9tgkNE9XxFCQpbOwJEmcbjwWZAbbTorAYQ6+W
G1WPtLSZ
=lxqE
-----END PGP SIGNATURE-----

--oQllR6CekXee55rh--
