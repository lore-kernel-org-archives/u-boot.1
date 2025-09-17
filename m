Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04ED4CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EAB835EA;
	Wed, 17 Sep 2025 17:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eha2JhuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B24A835EA; Wed, 17 Sep 2025 17:08:05 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5408F835B3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-3305aceab00so6306570fac.2
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758121682; x=1758726482; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8u3+4UfHR0eIi8bhoZWKyRJfb8d+zujvME48IDbIO3Q=;
 b=eha2JhuJkyON8hOrEWpTfdaxehrDO9jhcVH1fDc6sG9BGaDeEW2p6pLy/WaFcs+STD
 GPdcarKzf8jhoplABTVq1I3Q74A6x+f6yNrP1l5LJpgTS7ZZZgIzvdgbEZfgOkEubjFi
 qMXJkb/Ic+MgAOUxs/f6JLTSmqgTL/AVIR4Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758121682; x=1758726482;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8u3+4UfHR0eIi8bhoZWKyRJfb8d+zujvME48IDbIO3Q=;
 b=rJeBhn61eDLCuvynfFCIkkjJHGYMAYfSeg8uK3M0OzoKUiUuNY8BGYcd99am5i0SXG
 Co/J9qm8/labdcYj7Xvo7aJAxMkI225cbbZMhtY1qcsQMEDGlhWIW2A08B+73NLLQwMY
 77ufZ6e58Sr0qcNCZ5Blgsjj6P/2XVmKhKAvQ4h+6jCsXoqVYUaH40iS0VmqJyLmofeg
 rZAiGdEdNCUxAN0DhpLeOQAoh1/OKUIiDVMJtQQnJJ6iav62MYBKzOFWWc34/9KJakr+
 iVHTdYUXzQPs3A9DrxsaveA/3O0IVv7yWR2y5sYmkBZygu01s8WxZAhNAEVsv9qNna1A
 FwJQ==
X-Gm-Message-State: AOJu0YwDuCW7BaOlYGgvs9TB1HFXwZ+STYGRVr457oliDWIn9OO5zW+4
 uzViIgb14TFB6f8XNbf4vWrBr8AkuyMKryuUDq0C8TcFxy+a4bWVOnc7k07w95gZ1QcxOViNtbZ
 rI1aoXCk=
X-Gm-Gg: ASbGncsN6ClV3LUVxOrKozAJaJ77JACJb3G7w1sqatexxekqxIgi8kU5A9FnjYQid5H
 6WVZLWc/T5EAhUF8hoHry3mJsl/AR+Lw9/x6CUiOnmqbcAX7kPPIeuQ2BtdtJdHYqIWQMAL1I1i
 T/zP2RBVGyEv+zLfdTM94IlPydiAzT8HVjDdYykZuwumi5b1UZMJAYa4ksEPWmvXUwNZwX76JzT
 9MHqCTf48QEFW9nQFCMxPqAI6FIELgjl65XdM2T17Dcf3sDOTzMORtzgPjMNPyFy8a4y6GSyB2d
 zORv7YKpYtWGVQhvV5yz6R4nvgfuYRFRcB9YVt7b0Tk9Z8FpThxGFeURQnyzjB/ACeyg5E6yl0X
 SC1o1HdHz9IsvUMuB7HV5Zh3cyJg5eG/ZmeqMdUoHH6UG7FBiCF3NdELj
X-Google-Smtp-Source: AGHT+IGpwckv6d1u+4tUCTa/lIQTHnJR9zvqrVKWC3KXS3IUYchwLlxtb2mZwnFh1w0t+dgKBlA2fA==
X-Received: by 2002:a05:6870:8989:b0:319:be1e:9dce with SMTP id
 586e51a60fabf-335bd998167mr1242057fac.5.1758121681953; 
 Wed, 17 Sep 2025 08:08:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7568a0140easm3935343a34.34.2025.09.17.08.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:08:01 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:07:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] board: dhelectronics: Check pointer before access in
 dh_get_value_from_eeprom_buffer()
Message-ID: <20250917150759.GJ124814@bill-the-cat>
References: <20250907010103.667681-1-marek.vasut@mailbox.org>
 <175811685980.752169.702390256025070470.b4-ty@konsulko.com>
 <079fe8fa-1c16-45de-926a-58c6bf69dae2@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wKqPAJupIXoTg70a"
Content-Disposition: inline
In-Reply-To: <079fe8fa-1c16-45de-926a-58c6bf69dae2@mailbox.org>
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


--wKqPAJupIXoTg70a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 03:54:24PM +0200, Marek Vasut wrote:
> On 9/17/25 3:47 PM, Tom Rini wrote:
> > On Sun, 07 Sep 2025 03:00:46 +0200, Marek Vasut wrote:
> >=20
> > > The eip pointer in dh_get_value_from_eeprom_buffer() might be NULL.
> > > The current NULL pointer check happens too late, after the eip was
> > > accessed in variable assignment. Reorder the two, so the NULL pointer
> > > check happens first, and any access second, otherwise the access may
> > > trigger a hang or other undefined behavior.
> > >=20
> > >=20
> > > [...]
> >=20
> > Applied to u-boot/next, thanks!
> >=20
> > [1/2] board: dhelectronics: Check pointer before access in dh_get_value=
_from_eeprom_buffer()
> >        commit: 1c735620e19e2ae07705cc38da1552ee6a696ff0
> > [2/2] board: dhelectronics: Use isascii() before isprint() in dh_read_e=
eprom_id_page()
> >        commit: fd396316432ad4a0f2998ea9eee9720be0e5d5f8
>=20
> These are bugfixes for master.

OK, I'll apply it there too now, but please note that cover letters /
fixes tags help make it clearer when a fix is important enough to come
in to master later in the cycle vs wait for the next release.

--=20
Tom

--wKqPAJupIXoTg70a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMrOywAKCRAr4qD1Cr/k
CkKoAP9TmB3w55KwKfEnFqO4wRol7Eia5n2VKstFk5OqaVH4fgD/awOhveC4MsvY
v0DDieia4rGzSesnvMcV9XXiLwCqkwc=
=/iHL
-----END PGP SIGNATURE-----

--wKqPAJupIXoTg70a--
