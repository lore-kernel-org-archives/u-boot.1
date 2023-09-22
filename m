Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12ABCE7A86
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 22:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E52E86B70;
	Sat, 23 Sep 2023 00:27:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tpkEzlNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E179286B6B; Sat, 23 Sep 2023 00:26:59 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E488F86B5E
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 00:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59c0d329a8bso35018957b3.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695421616; x=1696026416; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9hAxNEnampdBNyg+A3mY92JF/LiaztboL+TSoPocvhI=;
 b=tpkEzlNRR5DhcwSdGp7szZXCxVVjygw/i3WVgFh1tcS2kvDjtTuf+fzR3e9lvVPf8C
 5bwcILOkVFqw4K2z+/MCxJ+/9/O7ZoctoSMiu2VRdqip9WogMIY+VeZJz8TMbOSjJksY
 AiovGqyKPfAxnhQD1W/+oAx5SykpqGjfeXeR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695421616; x=1696026416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hAxNEnampdBNyg+A3mY92JF/LiaztboL+TSoPocvhI=;
 b=I2Tu7b+DRRvFBr5sChPIlr0Rc3wU4YOg6LCGtZ6u+agRoRGplDZka1DdP1h0Mc9oRT
 O0KWVSV7PqzEtH9XdFDtVUDreZo8tFZwqhvmC8QGiXlEOfLiSs1hAs//KQRSoiJVIN6K
 KxvmxkUuQQuRUS6U6sbqHliYrP23EvVWY50bp45225Qe8LvMRgvJE/n/sZfv/jqpcy+x
 ggHBj2C0YQq1Z/EqVByWDOg0NA9faNJpNfVm1a/IyiGPHz+3Ciba4YZabpcQVFtgm7hg
 26m2eyScZzZugE9NPcHYVoAq/VjdsMcw24mlNyGam8uZJTUzOYTbTAAkbuapadfllWqt
 hZuA==
X-Gm-Message-State: AOJu0YzqRHU0n/k1hb0Uy14jwSrOOUubD4aZjLnlXUzyNoBiRL3w4qLe
 KCGZQtcvhnft4iZFUuhBZQLJCQ==
X-Google-Smtp-Source: AGHT+IEKZJ7Bc2SkERbPOvypk9r6QEG0ogvYI02fM6ubyJQ+3TwTRoAQ/cITgjmEWEGA6pUcBoBJeg==
X-Received: by 2002:a81:dd09:0:b0:598:48bb:37 with SMTP id
 e9-20020a81dd09000000b0059848bb0037mr985957ywn.24.1695421616718; 
 Fri, 22 Sep 2023 15:26:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c83a-32d9-8f81-ed72.res6.spectrum.com.
 [2603:6081:7b00:6400:c83a:32d9:8f81:ed72])
 by smtp.gmail.com with ESMTPSA id
 d202-20020a0ddbd3000000b0059bdba29ffdsm1125103ywe.13.2023.09.22.15.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 15:26:56 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:26:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, otavio@ossystems.com.br, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] pico-imx7d: Remove Vanessa from MAINTAINERS
Message-ID: <20230922222654.GI305624@bill-the-cat>
References: <20230919133911.3416072-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ASDXvAUPbWtN0FvJ"
Content-Disposition: inline
In-Reply-To: <20230919133911.3416072-1-festevam@gmail.com>
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


--ASDXvAUPbWtN0FvJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 10:39:11AM -0300, Fabio Estevam wrote:

> From: Fabio Estevam <festevam@denx.de>
>=20
> Vanessa's NXP e-mail is no longer active.
>=20
> Contacted her offline and she told me that she does not have
> access to the board anymore and it is OK to remove her
> from MAINTAINERS.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--ASDXvAUPbWtN0FvJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUOFK4ACgkQFHw5/5Y0
tyzk6Av/RAQiVrj2N3oCesRKDZ9BCfDyW0Y9by+DYAJHLkmnJScS4uZL6FlFucVt
B7COU69HEHec4j49b4WVAS3w6/q/xV1x4RdrpHXD6O5AHURTrSYxvLBTOmQBUHKM
Wf4zKqgG+rPF/G5M6VS4PPwNEKAKYdKY6Fm6ORYLFK60h18PIBiWs7avbcVl9Xmb
PLDj75k4TyMdmJXXcJ7OZ4vzgnctUS5vLVM6R7/lxczQfJH2Yw27GUaOfT6ljeZ6
300UXZbLQNRntVGMJ11f4MK2eVCvOCtwjifcyqV6XRFBqg2x9JLMNq+UxKI+K48p
o6YD9Txh1nal83SbUTowRjvQxwwhoc/87zQRULZPGJgpq1m2/zPbFbK0fqmUgast
RkU1wnJA8Ybv+BO6ULPU2bmoqbyUf9e2xKuqvbi5by3JMmxDXpHRtiHw4tpvOnha
nqF3DddLrz5f1PB91ufIP/FXyK+hlAV1d2kGJ9ezIGt5IqxCDkLlY3e3JizHIV0k
iD9nDY2C
=Dylp
-----END PGP SIGNATURE-----

--ASDXvAUPbWtN0FvJ--
