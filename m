Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF36AC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 18:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04FC8799C;
	Tue, 24 Oct 2023 20:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JU8d9F+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492C28797E; Tue, 24 Oct 2023 20:03:57 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1D887967
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 20:03:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d9b2ca542e5so4470514276.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 11:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698170629; x=1698775429; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2z1h3IIF0LE2ks2uI4gc7HvZqLOs2l66FD426Mrpi3E=;
 b=JU8d9F+LE21YIk7q0vkOxAGdUVEe5oABalZNgPfY3xkft7lIJgAQTnlLQQ2UXNfPRD
 hl78aTN9PY0ciRxC1rmSN9a35VHYJbvBjCKlrgFLrbxxZnSH2VJitW8F7AgVwdf8lW9v
 06g6eHOmsldOs1vXi5qSZNQD+QJYXK9AfMUs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698170629; x=1698775429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2z1h3IIF0LE2ks2uI4gc7HvZqLOs2l66FD426Mrpi3E=;
 b=KKcBE0dfx0NOUbigF8ERvJB47LsV0pk9g7afKVkq21X/jQVZ/jLocRp+buRSSM2JfT
 bJCBxxO52sspwogEOux14Otv1hRRU24B22gbDKc91fMjRFFYuKlm+anjy2AtiTeEqVfZ
 fA442NrRNxhvRSJSULetrE2GEkDcWAb0a15q/ngBQYfzF71LF3Dl83h1P7NzOXmP8RXA
 xz+VlKuBYBtL7ov8MyFxKtFU2RB396xGVaAchZDTxX7bCyTXWvDr1173w4sH0MCsEvrn
 Bu462iwumv+CDPKKyvHTdYTNH13ISSmOmqPW9hWYCTreV1a1C4uSbsd47xl/lGiMfcI+
 taSQ==
X-Gm-Message-State: AOJu0YxujSt/3SCwLAUUAJhWEBUxxEo2ojHmVnK5TAset5GucLOgJ1F3
 6UyBwbY3Guy4u8c1PR6T1d648A==
X-Google-Smtp-Source: AGHT+IH4xuuie/BRQVHt0DZ+kj2DibTIC8k6X5fYFpJwEeqic6t/BfwyOe3dAWJLwq71D/iS8qlZXA==
X-Received: by 2002:a25:97c3:0:b0:d9a:d184:8304 with SMTP id
 j3-20020a2597c3000000b00d9ad1848304mr12386151ybo.35.1698170628825; 
 Tue, 24 Oct 2023 11:03:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 n139-20020a254091000000b00d7ba4c5e31fsm3723713yba.39.2023.10.24.11.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 11:03:48 -0700 (PDT)
Date: Tue, 24 Oct 2023 14:03:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231024180346.GD496310@bill-the-cat>
References: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R4iT9XuI9OuREfOd"
Content-Disposition: inline
In-Reply-To: <20231024062032.8543-1-heinrich.schuchardt@canonical.com>
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


--R4iT9XuI9OuREfOd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 08:20:32AM +0200, Heinrich Schuchardt wrote:

> Forward and backward compatibility of Linux kernel device-trees is
> sometimes missing. One solution approach is to load a kernel specific
> device-tree. This can either be done via a U-Boot scripts (like the one
> generated by Debian package flash-kernel or by a boot loader like GRUB.
> The boot loader approach currently requires to know the device-tree name
> before first boot which makes it unusable for generic images.
>=20
> Expose the device-tree file name as EFI variable FdtFile.
> This will allow bootloaders to load a kernel specific device-tree.
>=20
> The variable will not be exposed on ACPI based systems or if the
> environment variable fdtfile is not defined.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--R4iT9XuI9OuREfOd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4BwIACgkQFHw5/5Y0
tyyM3Qv/c/lVI5KJO9hOCarXfQUCdl6DUatoSnTvHtLdevq52/6pdRBZgzB4EhRa
3avbp+CyP+4xhV2BQI1a70lrJCNKAK393K9EqjhnBlwhcoUAPlvzgyx7iHb6h/So
eHUR/9Flr2sr6XZVXpxRL99blulG5mtpL2yq60aw17hOfPXxJNgJYU4xD9G4gc0z
psPG4gz7Tx6tosXzjH7Bw77mJW9xqZfRiXwnjOpmFtR0a1KX7rWtGBFCjuo6Q5tj
PPiak+HqYueQM86Zg5g/nBrLH9ol4exu2k4HYfoFWk3wmNHFMdJVQCwLWfj+R57v
uAsix45jEr2bwl9K2Qw9863GxDGjFtqMWd+f1WEwkVaCxyN90vHrPT7DpmvM5+mz
UJSSV70DZRq0+gdxXiDHXDLhd4scwk2Iey2IvYDeanWlZGzdkO6TOrXbSnmuFKLA
TbMwVP6fEVeWZcJhW03GqZQJwv5TarMODf5LLgqBgMFRZ2Or5I5KQC9Cm6MkGJoh
MQtSQXaN
=9ypT
-----END PGP SIGNATURE-----

--R4iT9XuI9OuREfOd--
