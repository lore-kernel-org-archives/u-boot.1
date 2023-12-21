Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6E0C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 21:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D9DF86BFA;
	Thu, 21 Dec 2023 22:07:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WSjYoIWn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D21A6869B6; Thu, 21 Dec 2023 22:07:07 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A547876D5
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 22:07:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-42786ec994bso7242701cf.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 13:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703192824; x=1703797624; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FdcuWZONBeamOsSzy/xc3tff99Wj8tpfPV/k+wNg/V0=;
 b=WSjYoIWnu5NVXrT3Ks0Vj8KXalthY/DxZBQScvaTHbE+TXVW3lDDvrlKplNHq9euDV
 UkrVi7lUAEVuRcO3A0TM+XKE5IPPqCn7Ubip//glQpRVnasjnxuDtnN7gvA+bCocjSbE
 EJXcptA0MKTh17pNSVI2JvsUDSScfWWJdBPnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703192824; x=1703797624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdcuWZONBeamOsSzy/xc3tff99Wj8tpfPV/k+wNg/V0=;
 b=aWgNxn9bS4KPHxVhbmMyN9zE4wKT1xwQzxQYOWSP0FprwD+oqdcHSTehclA2znUcCe
 LnLRvAdobuUupcxFe2+Bawt+jiXLS7hSnTB2Hw6MaXsY+dF6uuPQZ6mMoV/7PYLkXkfu
 GeJdTpjAsxNzBP/jL9VF2bnqGbqq5j/9GaO4kJ0bMqP+RE2S6lol7s8a6RIftEoo3Bb2
 Anzsm8+ptC7lWJQ4ws0Ai61p93DG1KgooMIk2Du8TlPfYdp+0o4DxjJEFUobGfdincOn
 QbHtTLvEckPFtms/EURc2RQouPDb1dhLqbpqsRgy++0H7luBE/cvk3vk8zBMpvBZYy80
 Ds4Q==
X-Gm-Message-State: AOJu0Yx3/aCIZTi/bFjTgSE3chqqmQkWkdGOcqsGnHiNkTnxoGjkwoyg
 Qo7WP+KgPQdrPnUolh6CAzbtvXfNPSQYRg==
X-Google-Smtp-Source: AGHT+IHJcdyg1lfHxVomyJ7qgRx78QDa0bNKox4lrqHW55zzOiV9+9NHGNG1RHcD5/7/12bi27jPbQ==
X-Received: by 2002:ac8:5d88:0:b0:423:a31f:665a with SMTP id
 d8-20020ac85d88000000b00423a31f665amr489819qtx.13.1703192823937; 
 Thu, 21 Dec 2023 13:07:03 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 cj27-20020a05622a259b00b004259bbf166esm1154276qtb.63.2023.12.21.13.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 13:07:03 -0800 (PST)
Date: Thu, 21 Dec 2023 16:07:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: Re: [PATCH] boot: add support for fdt_fixup command in environment
Message-ID: <20231221210701.GP2513409@bill-the-cat>
References: <20231211110317.697011-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qmWoEskIiEmcMpjp"
Content-Disposition: inline
In-Reply-To: <20231211110317.697011-1-matthias.schiffer@ew.tq-group.com>
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


--qmWoEskIiEmcMpjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 12:03:17PM +0100, Matthias Schiffer wrote:

> The "fdt" command is convenient for making small changes to the OS FDT,
> especially during development. This is easy when the kernel and FDT are
> loaded separately, but can be cumbersome for FIT images, requiring to
> unpack the image, manually apply overlays, etc.
>=20
> Add an option to execute a command "fdt_fixup" from the environment at
> the beginning of image_setup_libfdt() (after overlays are applied, and
> before the other fixups).
>=20
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--qmWoEskIiEmcMpjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEqPUACgkQFHw5/5Y0
tyxgegwAs7QhrJcbykhCSVqvJejAa5BshG5fFaPPwNrnSxyuBuxj5PpBIM4s+Os9
ZFm6Tm1M94I0ru3KtX4ZmH1M+JAPQQvlFwuxe3UZ7sl4UM0cvfjNpyzZf7g2LLq8
bhFY9ILjSR9Mrs9enzSM12ckDiJxvPtj+MtbUHPl+BpVj5gaz32ViMUK9geYeYWr
QSw3d+RkTqwxT7R7qgwWVYSDgJRrKfzS8+NsrMpxGfDXbjs1GLXVbQW2liJ1+4Fb
8Q6ritcW4n+C8sH1JQ4REpsMwd9B93nKyRnJQMyAUE0s68VAkhje09eoOvqDicE6
kdM4b6urxnIZTuip2ql9UrGWyREl6rx1k5qeJSTNX7j7p6dhZDfJmSFvg0VQO9w4
ZZV3Flg2IXpnkLhp8jBCIuH+PoOU4dJBx8C5FWdGSE53KhiqBakJKOp+Us7LcUN5
5LvMbNfIHGtb8db2xB50vzMLLMlyQkXtybeeUeKvVeyPglZgA6A8ehs/1nkmD0vO
6yqluVTa
=a9rR
-----END PGP SIGNATURE-----

--qmWoEskIiEmcMpjp--
