Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF449C0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 05:37:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6E7800CF;
	Tue,  4 Feb 2025 06:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uprvFg0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF7DE80104; Tue,  4 Feb 2025 03:38:22 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA1E800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 03:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d8e8445219so44381386d6.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 18:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738636699; x=1739241499; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NH+c5uKI+5MQbeerPAK5Kd1chGlffv74/ourNaoij4g=;
 b=uprvFg0jFZQCDWOqPU7WC+juYYyLOj85cW2LRsQR8AKqYGvfF5cMPS57PDyLVU4UMG
 kFJA3FRWPaYChH1RikEjF3YEkA4dZ6sG7rqXN8UtsP+VhukLJZI24AibeqZBf+y+yiQt
 6EtMWZoGGGyc4/aikdC6qZ9MH031X1dM0Xd58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738636699; x=1739241499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NH+c5uKI+5MQbeerPAK5Kd1chGlffv74/ourNaoij4g=;
 b=xRQ8lkk8mQdkjwhk2WV140WOtBjBrUZ+Jnm0yCcXKhAgx3w0NYtjKGZrWrCkXNJv8c
 mdae1gqEAa9Ls0oeZ2le20FLKzxCVocWELqBc2J0s7jjQ6Bze0IK4HmXpn4WfHwLLkVM
 yrf597s3LOLvaT1qzOyKHcvSwNBzSnCY/c/gVkrsNixOyiVhA1qpb2DExKVYQOl1oJm5
 NmMNFubcXY0FgbDZ0/fG4aU1Wi2OJPkAy6Tk5w5J1pkfQ6qStBH1dst3IyOAN77Wlgz+
 QXSSjKcuJcROQexqWa+j/WKx5QwWjnIapINPlI8SUBNZ1LiE9DIRkdePoVGhRxWvyY06
 Nw6A==
X-Gm-Message-State: AOJu0Ywh21+rQNAussHx+aGpS5VigCqle7BvsgnRWrE4pha5BhT1FxwU
 Xs5EXarss0Ap/d48j+8Kr/dQF/kZbTnIbaHM+jtZ0NEpUd+a8ieuYd3mkSfvR3I=
X-Gm-Gg: ASbGncuEToVDISGxb6A6ou+5uv9Lyy7QU9MhrH2jL1C2+qkC3bZ34xm2Wup/6TOJna4
 CuDA8Rmv0qUv1QNoI5W+bFt9WaMHAEzeWvgxS0ym3WXsdu7XZifIwqBab1VJVX5FH0a95NQEKKh
 w/GfQTai3TFcC4iPpnrRO3kq/2nnePh9oZy+I1z2HhwyA99nFa8Ve2KA5MdGvM+4ajV1OOvf/AE
 3yeW6t9Qi/Ot2hhkf22UMh6vGlXJNa0akHqnzN3xB60XK1nU9fyAkBr9QIMzsLi23Ima+C2iGu7
 xboD/v1qPcHZFHc=
X-Google-Smtp-Source: AGHT+IFoMKZgFVgAkPd/87mxEuB7+5HmkbdxDAgUXgex55XHou3jCe+5zY+8duKZ5NEf08v4Xf6ATA==
X-Received: by 2002:a05:6214:3004:b0:6d8:7f8a:73f5 with SMTP id
 6a1803df08f44-6e243c1ac2dmr293782546d6.24.1738636699461; 
 Mon, 03 Feb 2025 18:38:19 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254813ebasm57033656d6.33.2025.02.03.18.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 18:38:18 -0800 (PST)
Date: Mon, 3 Feb 2025 20:38:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Daniel Palmer <daniel@0x0f.com>, Devarsh Thakkar <devarsht@ti.com>,
 Franco Venturi <fventuri@comcast.net>, Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Julien Masson <jmasson@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sam Edwards <CFSworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 00/19] vbe: Series part G
Message-ID: <20250204023813.GF1233568@bill-the-cat>
References: <20250126184333.4058848-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G+KTLzh92ibZhipZ"
Content-Disposition: inline
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 04 Feb 2025 06:37:00 +0100
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


--G+KTLzh92ibZhipZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 11:43:10AM -0700, Simon Glass wrote:

> This includes the VBE ABrec (A/B/recovery) implementation as well as a
> number of patches needed to make it work:
>=20
> - marking some code as used by SPL_RELOC
> - selection of images from a FIT based on the boot phase
> - removal of unwanted hash code which increases code-size too much
> - a few Kconfig-related additions for VPL
>=20
> Note: The goal for the next series (part H) is to enable VBE on
> rk3399-generic, i.e. able to boot on multiple rk3399-based boards with
> only the TPL phase being different for each board.

For the series, applied to u-boot/master, thanks!

--=20
Tom

--G+KTLzh92ibZhipZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehfY4ACgkQFHw5/5Y0
tyygSgwApC7g6TSE/MJfNJsKNs5KfeG/0fV2guZriJL1sZb3efOOjd1w7MFmb1b6
QHxESMaEr0LDBI3W4FYarWr85oPzBmK6eZmVqHQpVM8M4ZMfuRIWPcjj2svwvfnJ
A2pKZV2fhN0JwHyiKGSKfBTcep/dnWoG51Zs7KIlCqVsEg0lbq4a7ntD0o65K67t
mt7AeyqMvl+N58TIQVgxageRcsI9JLa7pOAVXZv6WOi8eDtn31t7S4BpZldjrW47
vjc//igAGsD/uQ16f/yi9lSlnNSVzjaXEly91Eb9WCZ6U2QMEVeRzlAsWSyyusXt
IX2y5HuqHQxGggEOM0IfEB02efGrH4FdZ+ugmSoHnRE42yqVnS8wR5K3JhKf5Bfa
8MhKx458RGwWvozm/BBq0NGC4TagtrcDwJ0cpul8yKxcPyHrlELMytr5RPpLdJb9
/yP3F4h95hiimVt55FXCl95X64XhEnffjwTL93qhDPUt+iBSgNOZ0m37hyAHZm7T
vWlSNCTY
=Y69A
-----END PGP SIGNATURE-----

--G+KTLzh92ibZhipZ--
