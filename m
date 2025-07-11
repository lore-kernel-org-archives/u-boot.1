Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33471C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 16:08:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E25A82063;
	Fri, 11 Jul 2025 18:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kyfJ/cov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F65E826AA; Fri, 11 Jul 2025 18:08:15 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40466805D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 18:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7387f21daadso1747923a34.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752250092; x=1752854892; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VH3MfTx9CHhtjiCvWWFJKifZkMbmOUPZhHixEKLM79Q=;
 b=kyfJ/covu9l3R8z9vDOrDr9lQw9Qjh7X8nxoBJKk1GvKKJylycKSdOq1u9L9omn89I
 q3mTpH6pweee+FFboVjKTuGvItjEeE+ETbei6zyXfBrDiCVuQN7yWXu+pZB9GHSW1oQW
 bwmQkYHVnrWKTlVCpjql8H0/9X0RIXj6pjmIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752250092; x=1752854892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VH3MfTx9CHhtjiCvWWFJKifZkMbmOUPZhHixEKLM79Q=;
 b=hLuI/GBTtnkwpAzlhxwgrYz52dn7cfYWsxIFSW7bfLAXboMACzz9o7IjuHysZwXC/S
 PaTbwpQY7dzTKPkr90CbwLKyuf/hCixJQ2ZWKfRHmxV/vj6n5ODgYqB+ld8PcLnuvVqT
 R2xe3ey72qyipxIqOZXrqx5J7b4/hjjTb/usBEULhq85IsWorRps+sUkJKnmEhGYFZMo
 T7+MRF8UzIs1rCupzzL2q6pD3MBZrIckzsoCgdupTr1nO30BMrmCfeEMOce8gWQd2uZ4
 6rTXwq+3LcX2Jl06yeZOMiHBsUbLixPtozJGXRaIXJMqNN2Ulil/uah5SdVNegNe3LIP
 /gjw==
X-Gm-Message-State: AOJu0Yz7yOEcfP+Ij2Ox5a5pxRZHoHSTzA5pGKcJAa624vNJM79FP8SE
 JnnxC1ti5iW3fEXC2p7Wez4dat2vGicW7IUYJItUD2f2n653G+1MUd6D+mJaYFDKoAc=
X-Gm-Gg: ASbGnctYXXcxbZbOx+GdF+1wgqstildkEHP/7X5YF+R2l4oWcOVG6zDgu3ZNUTE1TaU
 ArYiS4I7YjsYb0RxhBh/gYllpLSRTNB+sKOTx5+9QtOsH+i6tMZA1I1yIsc0qzQ8biSm9z/GMI8
 WnWZgLSLxyqiGc/ihWK6GEPyY5Z6LaqHXBtWczFFw8JKx234D1W8LnXqkxk4lHtO6x56TvmOYrS
 EwOA9HhdyiCLyrXl/Hbm8AkD1BYfe3nKC5syL5PcXYKZnkn38jr8v5+Dwse7VzzNFIfpsQAqgeJ
 uxpqmvk0h8caR4UFw8M27SF2oFfTS8u+9BQE1P5GQOKrA9cdcUFlm02q4HpEahuv6eMmJIdqEzx
 L/ARi+RQqFJZpSlk0NRNT5XdArZ9zaVqKBiwoZAp3v0x0fI7H9MNqAAA1
X-Google-Smtp-Source: AGHT+IEQUeVvY/FNuGzLKG+jKyrqYGTkV0IWPJMNPFzabB7ugrePWKVpQySyLdlrMV+4XLErIuv6Vg==
X-Received: by 2002:a05:6808:1246:b0:40a:729d:82f3 with SMTP id
 5614622812f47-413c251ed29mr5088627b6e.1.1752250091547; 
 Fri, 11 Jul 2025 09:08:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-613e2e93514sm365868eaf.25.2025.07.11.09.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 09:08:10 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:08:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Robert Stone <rjstoneus@pm.me>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] drivers: remove -mgeneral-regs-only for truetype
Message-ID: <20250711160808.GA2230322@bill-the-cat>
References: <2a6ea8e8-788e-4eab-b06b-b553cf4f8320@pm.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MDiwBK8gX944bkdu"
Content-Disposition: inline
In-Reply-To: <2a6ea8e8-788e-4eab-b06b-b553cf4f8320@pm.me>
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


--MDiwBK8gX944bkdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 05, 2025 at 06:48:12PM +0000, Robert Stone wrote:

> From a364b45738c1fc2e937a8d845f419b8c5c64d751 Mon Sep 17 00:00:00 2001
> From: rjstone <rjstoneus@pm.me>
> Date: Sat, 5 Jul 2025 11:22:09 -0700
> Subject: [PATCH] drivers: remove -mgeneral-regs-only for truetype
>=20
> For almost everything, -mgeneral-regs-only is a good optimization, but
> console_truetype.c does using floating point, so the build will fail
> unless it is compiled without -mgeneral-regs-only.
> ---
> Sorry if this is formatted improperly. I had some trouble setting up patm=
an
> and format-patch. Also having some email software problems.

Can you please explain what config you're using that can lead to the
failure to compile here? I suspect this might be some x86 related "fun". Th=
anks.

--=20
Tom

--MDiwBK8gX944bkdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxNuUACgkQFHw5/5Y0
tyxEPgv/UWwBNhAioywGcuEL1tPzbBouGcx6iwld9St3QjiIQWG3gBF9Q6LxBUzw
9kU84M0xlzYC1yaUm1dNM2Wz9ZN6uCTMJIze4GjHQZMEJr8Sk6Up6pXFcPCmKhub
p/hS7QN0IVTelV7bNPHMbopRJzsH9AvuZ+5WEkbRLr4eSgM94ERe1Dn4mpmBaLSM
46meeti76dvms6/KMKPtsF8JNQaVYFPL5h1Qht73E4RL6OXc8OUU7nDsOtZe0MPT
ZMrMNrQHNlv2oo35dSmU0YJXp5Rkz1R4oocykHPYtWMe/jTeN0SzsfGeyXv5yINL
ZZpu7O36HuuImOQc7bLGXICChH5HlkM4plxgQOxsFqTfWCZw73AEyWoGpGEkOzHX
zUd88NGWiKmUrG3dkzykfgXp3SczqHePEDLQNz+OkRbTxIlLJZmL0BhCbf6dY8Is
KnqeYIRGywzkL9YFe1mR6mB/9D6mBaaJaQEeqET4f1gCijl4Ifc3H9YzDjPDiB9Z
nXdus93I
=gX+Z
-----END PGP SIGNATURE-----

--MDiwBK8gX944bkdu--
