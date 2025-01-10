Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F8FE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 21:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DFC5800D0;
	Fri, 10 Jan 2025 22:15:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RCTOPWFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC83801F5; Fri, 10 Jan 2025 22:15:37 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 778AB80050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 22:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8ece4937fso19422506d6.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736543734; x=1737148534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IaDQBbJDQZVs5ooHpvzkNDGJeRIKDVlK5s7YLNSmvMY=;
 b=RCTOPWFz9YfXieUBxciPHi2ilpZezTDprHIGLGxCl+RMzswGUW0dCL4K31Q/5g7wfx
 /Vjv+QPuPSmNyFakan8LeO8KecfDoZh030eG/nL73dePu85LY2rwIckAN+9XQcJjt1y6
 jMffBi1fz8iQ7IwROcFGkaWClJUo3l/nEy6AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736543734; x=1737148534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaDQBbJDQZVs5ooHpvzkNDGJeRIKDVlK5s7YLNSmvMY=;
 b=rvu6AbWhY5ay0qiTU3zwrEeg7ZOlsh2mF1PIuw7Yi/ij2sNG/AHi9O6jsWRm2d6PLe
 Q0Ep5eyyKZHAfkVCZKsB76F0w/UBblMxjLQEst2Zyn/l7bsrV/9kQTzfW7qgb3oW7dd1
 3OjmabnovT2Nhs+F75S6Ak79/gyxgzgF7jCEA9eD5OjmiTxmqQtYJ3RXginVw80wzwsc
 tBiVrt1sbDXY3vRz4Qc1zWYypqZGDyZwN5uZi5XQCuv9k03Ig+g/HjIQQMLZKRyOFTcD
 1cDGkqpHE08R+GswDYhOFbxdG2GjudteAATGB5eXrCJgsWbBzt+Xu/mB/ZwBY6fmlNvF
 OAuQ==
X-Gm-Message-State: AOJu0YyZGiGsT6LIOGGEvE1HUi3bD4sbOd15+dfzRl1JE93OlVLcG9/j
 9SZ+3FPBy7xgtzkp6km6MwR3zaIixt6lHMrO7TRWNxT8pvqqKooY6oqmO0lEexA=
X-Gm-Gg: ASbGncs6oZKQNRj/k4sJFHSkrQbNobHxWTJR6YpIAkSg7EsglvWr8gGypZCkOyZYIul
 9Sb3ixmP/vb3jWdSiz4q/oZA0A1GOHnZz0S/nJPwy+c1ZqPX8IT537wUJB+5cSwpfNl1n9LDM3F
 khxULB0AD9lCzll9UBUnrCaIC2CAPHFcKwOcUkv7M4gBq6ks9p0Ad4odOL0cvk5JCfuGcrSYJvS
 932owN3L+I39UhgzRXCzHVOjXyicGC7HatHyGS7m2bSfbpEmF4CG8c=
X-Google-Smtp-Source: AGHT+IGdPN4DQhniMkrX7/8PFcblDgnB3faKXc3N93+8MAcUDCxSIzS32pdnY722QztkIuh82IakgQ==
X-Received: by 2002:a05:6214:1316:b0:6d8:e634:204d with SMTP id
 6a1803df08f44-6df9b2b29d3mr208760516d6.38.1736543734259; 
 Fri, 10 Jan 2025 13:15:34 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad88e3a3sm13081636d6.46.2025.01.10.13.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 13:15:33 -0800 (PST)
Date: Fri, 10 Jan 2025 15:15:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v2 17/33] boot: Update fit_image_get_emb_data to use abuf
Message-ID: <20250110211528.GO3476@bill-the-cat>
References: <20250106143229.3023771-1-sjg@chromium.org>
 <20250106143229.3023771-18-sjg@chromium.org>
 <20250108182528.GN3476@bill-the-cat>
 <CAFLszTh=HYTxwNSBOOmaiPpG+DO8tc52=XsQQiXAfMSpcwediA@mail.gmail.com>
 <20250109150954.GU3476@bill-the-cat>
 <CAFLszTg+pyMWMW-9rXe9D=siFpk1bbgTq1yk0g-+cms2aKnEuw@mail.gmail.com>
 <20250109180817.GC3476@bill-the-cat>
 <CAFLszThn-XcHruFe60TH8FnsKsH08NFEco2zt+9JBHkneQgo0Q@mail.gmail.com>
 <20250110161732.GI3476@bill-the-cat>
 <CAFLszTgiO2zPy06LziSOQ2tQAz9hh1rd9LEPtRfW+VxuLR1A4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CjNsaXyKlO0SiJqu"
Content-Disposition: inline
In-Reply-To: <CAFLszTgiO2zPy06LziSOQ2tQAz9hh1rd9LEPtRfW+VxuLR1A4g@mail.gmail.com>
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


--CjNsaXyKlO0SiJqu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 12:23:42PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 10 Jan 2025 at 09:17, Tom Rini <trini@konsulko.com> wrote:
[snip]
> > It be great if buildman size comparison had some way to csv the output.
> > That's what's missing imo from being able to have some automation or
> > even just nicer tooling.
>=20
> What sort of tooling could we have? I would like something in CI which
> reports code-size changes in a useful way, perhaps failing if the
> delta is too large for more than x boards. WDYT?

I don't want it making automated decisions (for example when platforms
enable features they grow, a lot, on purpose) but generating an output
that can be imported elsewhere would be good.  I want something that can
be thrown in a database (or added to a database). Setting aside the
challenge of LTO, and looking at what I see in a recent before/after, it
would be good to query and see that for ~60 platforms mpc8xxx_gpio_probe
grew by 44 bytes. Which platforms that is only matters if it's not clear
=66rom the log which commit that's likely from.

--=20
Tom

--CjNsaXyKlO0SiJqu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeBjeMACgkQFHw5/5Y0
tyzTPgv/QdjS4yLFvPcn/zC3hQmR3ZidlFBcnzficKuRl0CA/C2WNftHlarF8wLU
jZPEB3d5lrJROx7dQjwlHWJhPXaEQpzmw8AGOofos8Y8lG4520KaclAYXn62JtSG
rwCheJzZInkGgQiB2fGrywnFVcVgzv8w0AQA+/i1H7GgUe+VA+92i+b74ZF8zamS
SPKjBe03Eh5M2SW+R0aj7vX4lnB1Z/nO3XuOL6pz0DW/rlIjJrgYGvUMRKa267i1
Izf1UqLfdwPMCfQsrN7gUItHFzTuWx/YMUjhdQ66lGNX/+jvie0TyOu27ZYUdwQK
wIzJlqQ/QW1/ex6VVhFk1qusWTXG0CoYZUljEPn3ddQsytaYH9k6egbiLwta1rGn
D4AUtvOQBRAv4szCwDiYDJNTB0ghRSrKo4uncf66y1lHyLi840TiHGxvoTxTLTbL
DNZC7xL79jiAFqGw/WrSEhp86ZYpSPT7Px3NvYbg/qyu/cji6Bo+xBCsdL4/spUs
5eJ593SC
=2noR
-----END PGP SIGNATURE-----

--CjNsaXyKlO0SiJqu--
