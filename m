Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6A7CAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 15:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B57738319C;
	Mon, 29 Sep 2025 17:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dAHsn9DO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EFF68329F; Mon, 29 Sep 2025 17:57:58 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D02C82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 17:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7ae21804971so1277713a34.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759161474; x=1759766274; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U7Jp3FXDfTMsGeaZT5xzVZ8WR8wVjIsG1rj62KIJdZE=;
 b=dAHsn9DOgWIkb+GIONPS5+cm8n4ONOPjHuPKd5nhJgKqjLe9atm8yOgdvSthHI/qPx
 L7cfix7gO4LfNri5TyjrbRdcrxwQw5UnhpJo2fmF8NdjMKSdeZmg+zI7cnjaHszUYppX
 yk6oyI5taxn3kqgsj7ef1zgXxauOHjIumK/ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161474; x=1759766274;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7Jp3FXDfTMsGeaZT5xzVZ8WR8wVjIsG1rj62KIJdZE=;
 b=kiIzmUlh8MT6xVe9P0h+I5pWjMsnBKVBo83XsRyW0/hMjF+ZeyKXSUFwA+op6VKDMX
 2WYo00Em9V/tj4S6Y/zs7iKSlvezpalxsQrS8gKI3sitn3b2zXeE60AJWLGS2zVgzKV+
 yYog+O0zPuNcInbTjNcHIfztmejaVX+uou2w/xtiWfWl4iVjR/ysudaVY6+OHQsOw+TN
 e0PRBaN1/BcWZUyCFMCRyj7xkoTe/x/BR9+u9D6XCwQvgQT8Pc7Stts9lgIv+aEy6oC6
 Nhye6CC7k2/FhJ9X8xGuDdqwFqTlHlWPjwW+IKxPFyp+iHEDiUM3lfU2Cp6LTCCAScmx
 Vb9A==
X-Gm-Message-State: AOJu0YyNPnNOcOuAyIuLcx2dgLctBH1DYI06boaOvKXowx+zsnqdmM5W
 FRbZ3jvYpncmbpYX/JelRGgOBPdN6zWkfBQVCRXFxddWARVcXRV/olwSnJjT6Ld+KHaIDgLoSwI
 H6Fd4jts=
X-Gm-Gg: ASbGncviFqf+vtzNbNi1XqqlI8czNtGp48NKCGYv1pzj/4Z27S6WkOztm3UK9Jl4JP0
 Vpa4MT7cgkyjBcVIvZAgxFc2WZz+Pnshdwm8wK9JbFP36sX3VItOkErZq9qiFz1jZXbudAI8ae3
 6WYvUykOBkg2sB6yYmG+ldPN2CIBuL7f+SS4yshCEpmEwVvD4rFnKO39UdV4O2Mn2xWKZI6+y70
 Z7hnsKlt1InV3ZTQqFvHJ+wO04J+lJiti0VVJ7LItEr6vbg8ElStcM2RaYQw9e4DWF5e10gFsGH
 y+U2D0PLGR8Z8zwvHdOPxrMjhIOJ/HnUDAtsDzZ+UKv3Ewp1PIjVq0XnM6RchaXgJJsj4pBLy+r
 GxCanv4tp1KNhDNbnu5n0Go64wKcnMaT+7aLkZ6BZlGomSbYuOxotI0y/
X-Google-Smtp-Source: AGHT+IFuel8BPdb2io1FMeMuHGMYgvyEtRLAJrrv7SS7BeMU82Ky8fsxL3ZSsEg4HeRSnqElFSPxPw==
X-Received: by 2002:a05:6830:2b0b:b0:749:fac2:92fe with SMTP id
 46e09a7af769-7a02c6d6fa9mr9604390a34.0.1759161474267; 
 Mon, 29 Sep 2025 08:57:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23193c8f2sm2656687a34.3.2025.09.29.08.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:57:53 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:57:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: u-boot@lists.denx.de, Sagar Patel <sagarmp@cs.unc.edu>,
 thomas.petazzoni@bootlin.com, Hendrik Donner <hd@os-cillation.de>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] checkpatch: use python3 to find codespell dictionary
Message-ID: <20250929155751.GG6093@bill-the-cat>
References: <20250929151252.1005683-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="unzN9HjmlfXujfXf"
Content-Disposition: inline
In-Reply-To: <20250929151252.1005683-1-kory.maincent@bootlin.com>
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


--unzN9HjmlfXujfXf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 05:12:51PM +0200, Kory Maincent wrote:

> From: Sagar Patel <sagarmp@cs.unc.edu>
>=20
> Import Linux patch to locate codespell dictionary:
> https://lore.kernel.org/lkml/20220309180048.147672-1-sagarmp@cs.unc.edu/

Please re-sync our copy of checkpatch.pl with v6.17 to bring in this
change along with others we're missing. It should be clear enough what
changes are local to U-Boot (it's almost all contained within a function
now, and so the call to that function, but also just now, running some
code checks on .env files). Thanks!

--=20
Tom

--unzN9HjmlfXujfXf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNqsewAKCRAr4qD1Cr/k
CjjXAQCmSbDVvYeR+ApUnkYHIEDNf+Q8LySo0gzvW+lFRYMCVQD+P84O0qucDKda
QjLptpAq0tv7HSO+MluPci966bK5Wwg=
=Q6C2
-----END PGP SIGNATURE-----

--unzN9HjmlfXujfXf--
