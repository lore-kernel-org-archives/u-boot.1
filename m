Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF8DEE0207
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 19:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A85A86A21;
	Wed, 13 Sep 2023 21:24:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z6ejYSim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AFE86A21; Wed, 13 Sep 2023 21:24:28 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384AE86A1F
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 21:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d7ecdb99b7aso185645276.3
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 12:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694633065; x=1695237865; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m9D/lexQp7aKQIS3u0RyELf0MseinxnOFaO+Nc+fw1I=;
 b=Z6ejYSimnBeihZAJeUIccvS+0QzDmwZdv+Mjuo+dUTsUr0tiglHU/RxAw0dDb3WzrD
 Xowwp1xNksGQLwZBUqJCkK9mwvIE3C7aYLfQ9EZd17+cSr1rx1zinBKtPWnIvVsJP5yw
 Aa9cMiBRFTV5jkji+MrMR2raRcqzxsvuhUIhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694633065; x=1695237865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9D/lexQp7aKQIS3u0RyELf0MseinxnOFaO+Nc+fw1I=;
 b=JCLf+YxpxnEf7gdh9BU/Nemjovny5sUDDCEUI7sNhHCHB9TUDek2C3t1pJXxKuxw8/
 124062MqugDqnIplRxLmGAXy/Hibi0sJZ3M1dwL2be0yPyROcjbuSzT4wc9Mu7ZtZ2Tl
 I4bylTEULweWzColKYjRdwRnMVWwzceeC0ljs0ZpjLWinZ/wYGwMqc/P68uZt4JHecbN
 gekrkw2v8jaAtqgLijZGytkm0vYy8Cgqzqxqefpfdml1z7jz5YipXOjSw+pqSe1XmxqR
 3Ah5t7kOl8d/CUAUflKv0Sr4CgATImfBaT4aQxd30kyQD272KnwhjXfTkS53vFX0RNlW
 NCmA==
X-Gm-Message-State: AOJu0Yz6kaNZQrqxjkGluDnLg8J0qmwypa5zwM5N3yK9NlTEVOqKZlFz
 tXJBWI+n0QVp4USI4Q9FA3zenw==
X-Google-Smtp-Source: AGHT+IEO3HHjKD1SPgF/t+Y3C1yN7c44tZXdy70D+9VByPwlWoZgRtQpBOL4fpfMua91+YZQMy3aCw==
X-Received: by 2002:a05:6902:1504:b0:d0d:102c:78a8 with SMTP id
 q4-20020a056902150400b00d0d102c78a8mr3512621ybu.31.1694633064921; 
 Wed, 13 Sep 2023 12:24:24 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2580-cbcf-c7bd-45ce.res6.spectrum.com.
 [2603:6081:7b00:6400:2580:cbcf:c7bd:45ce])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a25874d000000b00d071631665fsm89466ybn.59.2023.09.13.12.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 12:24:24 -0700 (PDT)
Date: Wed, 13 Sep 2023 15:24:22 -0400
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>
Subject: Re: [PATCH 0/8] Add some more EFI capsule tooling support
Message-ID: <20230913192422.GP305624@bill-the-cat>
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ylogA38MmMlFEhZJ"
Content-Disposition: inline
In-Reply-To: <20230908120002.29851-1-sughosh.ganu@linaro.org>
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


--ylogA38MmMlFEhZJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 05:29:54PM +0530, Sughosh Ganu wrote:

> Recently, a set of patches were merged in next, which were adding
> support for generating capsules as part of the U-Boot build. Mid way
> through the review of those patches, it was decided to drop the
> patches for generating capsules through a config file. That was
> primarily due to the use of absolute paths in binman for testing the
> capsule genertion through config file. Now that the base set of
> patches have been merged, this series is picking up the remaining
> patches for review. This series addresses the concern that Simon Glass
> had with the use of absolute paths.
>=20
> The first set of patches are adding support for generating capsules by
> parsing the capsule parameters through a config file, and adding a
> binman entry type for this. These are patches 1-5.
>=20
> The other set of patches is for generating empty accept and revert
> capsules through binman. These capsules are needed for the FWU A/B
> update functionality.

I think what we really need next is to be able to implement and document
how to use the capsule (and FWU!) spec / mechanisms on another platform
and I think the Synquacer DeveloperBox would be a good target here as I
believe you have access to one and so does Simon to we can deal with
feedback on a real platform that both of you have access to.

--=20
Tom

--ylogA38MmMlFEhZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUCDGMACgkQFHw5/5Y0
tyyq7AwAg0O9xdi2Jvqd+CYLkZP38qct4OPQkiPlOE/qw23UMtyVaStBL/CnCbJT
7cSquxKf4rhRSP9OXyOV1cHbT7FB/mhJuuVB2J3QOOSN44s5ooKytPLjA0gS+k7v
08jcBsHVLckzhxyHP8ZZ1+PZ+w8Xz/HafPesS+Tp5oKWU7Kafu0IDROfGXMOVcnm
94F1W4HkRkww+DgviykFeIgJkeHh6PrrxNECgc3YlmXVX4p8nA+EPixPomqOTPk0
tO0G74DuvNVODKBlGRkL+uFWRzI+5FRJTkGJGAjVdH+p7V9AFo5TEL5LtGFeMQE5
LV+iA8+kpk04vWVLUGX9+ns8Gb2IsljWVjs7cRtDHFcmJaT6leJrUKO9uKTvBJSW
aH9HgKXmCKgNQ9qYOn04OPdVb5PCFzX0lGSwCUXZ4vrJF1HSbPKlV6qL9aN/7loW
DCpWld9+YuBBVKaNDAfeeeHuD1C1HEeDZtmvBZv/KCd0c8hGX+aVqDadmmHdXIS2
8dAGF7No
=nAwf
-----END PGP SIGNATURE-----

--ylogA38MmMlFEhZJ--
