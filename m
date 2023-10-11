Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217EFCDB47B
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 18:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500E086D17;
	Wed, 11 Oct 2023 20:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UqQLuo19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F3A486CE5; Wed, 11 Oct 2023 20:41:37 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8536786CE5
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-59f82ad1e09so2080047b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049436; x=1697654236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ByOdugwUyAdnbeqsWOV4gdo4wZNSSK1hyaKfxqDGGTU=;
 b=UqQLuo19feiDrrHxWHqcumxal42QpgIdql3LbdNM3wQyQv3VnZiRprBhM2ZqknsY5m
 svTfrlUtr0nBvdDmdvLAyomg7DXTmaBNPml2yxlLVd/ijveSlxG3H1mGqlER7PL8Sh8h
 yzGnP1Rp/uGmBWqg1EvKrHPK2NxI0XMnS5kAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049436; x=1697654236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByOdugwUyAdnbeqsWOV4gdo4wZNSSK1hyaKfxqDGGTU=;
 b=P4HA4B2TwUfK7SQvJMvvk2ReYhlYV1ydvhqrfCGFJBk+07a5VBpOye9OdL4v8t/OSg
 UZyNy2K1s+FYAqmwZi8HQ4SmCf705s4BVSq4c9HgUMh8Ul6S99L4OTPTh6O+amMS1yeT
 LgOr61O+pScsuGqc80XpxMyAjifME6DHcEC9eq22HYV8BA6Hc73GqTNToml4WXldHHLv
 rgiEg6vccEMOY57kbQwwc4vrx3sKX4lwP48Hwov3kK+cItY0WyJvDb7fGoCsckzW2TZg
 SXIVI+e7VgRfKitXO3B39xHE3N8lsHGISM38oIAgfN5V4Gu6OJGERlCqCgWJxZkTp73H
 96mg==
X-Gm-Message-State: AOJu0YyMlBNYBzXuujtI3FF5Dg+eonTeZEIQitBZoz/TWOYAjiZdVviz
 HM6IhYTC0a/7WWXC3vex/1rDQw==
X-Google-Smtp-Source: AGHT+IG1SsLRPygsS7Gr/Y73PiZ/P4Lq5hsM99V0KYa83n+Z/jr8YckfpweqB40rzrMsVvFCF81YzQ==
X-Received: by 2002:a0d:cb02:0:b0:5a7:c935:6cf with SMTP id
 n2-20020a0dcb02000000b005a7c93506cfmr5550548ywd.24.1697049435813; 
 Wed, 11 Oct 2023 11:37:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a81a24b000000b00559fb950d9fsm5304101ywg.45.2023.10.11.11.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:15 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Lars Feyaerts <lars@bitbiz.be>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Massimo Pegorer <massimo.pegorer@vimar.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 2/2] mkimage: allow internalization of data-position
Message-ID: <20231011183713.GR3119521@bill-the-cat>
References: <20231002080014.1861669-1-lars@bitbiz.be>
 <20231002080014.1861669-2-lars@bitbiz.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uzjL3KjDCvEi/pjW"
Content-Disposition: inline
In-Reply-To: <20231002080014.1861669-2-lars@bitbiz.be>
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


--uzjL3KjDCvEi/pjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 10:00:14AM +0200, Lars Feyaerts wrote:

> Make it possible for data that was externalized using a static external
> position (-p) to be internalized. Enables the ability to convert
> existing FIT images built with -p to be converted to a FIT image where the
> data is internal, to be converted to a FIT image where the data is
> external relative to the end of the FIT (-E) or change the initial
> static external position to a different static external position (-p).
>=20
> Removing the original external-data-related properties ensures that
> they're not present after conversion. Without this, they would still be
> present in the resulting FIT even if the FIT has been, for example,
> internalized.
>=20
> Signed-off-by: Lars Feyaerts <lars@bitbiz.be>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--uzjL3KjDCvEi/pjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm61kACgkQFHw5/5Y0
tyydNwv+L11pR1AHZPyWZgMB/+8gLsOuL/bT63DiGzT4rsKPvsCIXWykzWJUOmaM
EDIiAxhcvSquru4EK3ZUaQWjkjE/A69t0gAxApg22nAA4GanM78nHON2s/OZDbO5
/bBTzaKrWqjCTgctTXR4op9eWIqudqyCnBwcWOLXbtjRhuvMNCabp4DX+JfeXi47
EGbDZrmPgla3ZMurWObcaoiCMnvoqPV1nyYyOljW6GL50+ZKhlRwdpmEivxPJ+ML
QMFtwI51gNu4BeePufjpum5YmY6wOUO9QiC5e1Z5EFKqgi4XrcJ2bKDawk3eJexD
bRGclAsX43hf//iGeBRvSVWYp8IKMtrf8HkjVjgZmZrW+xFJ08ysNKPy5YTn+knV
70hvPUwFqx4bbRhcNzB6xgy+FVcrZW7wRqrhDYq6BoEoriqN/Rf+/Gdwt8stcvXD
JVT9k2Tmbqa+fEP9Dl/6+wmOL6wK0MJCew74aqx8+Bhm2+UZirC2/QSVuKMEwEfE
aIN999pA
=LXRN
-----END PGP SIGNATURE-----

--uzjL3KjDCvEi/pjW--
