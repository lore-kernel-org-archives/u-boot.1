Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7097D5B158
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 384C3890C6;
	Mon, 28 Oct 2024 22:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q0G3nqYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D890890E7; Mon, 28 Oct 2024 22:34:48 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31DB1890A9
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 22:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b175e059bdso364079885a.0
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730151285; x=1730756085; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aLzvfJ+x5U0mlMaz8GjFPoUoTty2c4ldefyMT6bpOig=;
 b=q0G3nqYoM09W2YOJHls5NiqTvTHyKC1muUIKIzyr9L3QuQG3gOB14SfQBcyhIQGLHf
 BxUl8Zah2xEO416T8O4l+D+YTcEhFnXEX8D6zPxNG9aZDaqNilWhkkBSHb9cPzwSqblG
 sUYaDqx8h/yvxSLlvygkSyKdLJE9q7bFjKHx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730151285; x=1730756085;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLzvfJ+x5U0mlMaz8GjFPoUoTty2c4ldefyMT6bpOig=;
 b=Y6CSKU5GI8NjmiYiJ0ugp8UQ61htlkKbb1gV4M5n+mTdrqRKMVOtsCXQ7r7zgOHWef
 xNoVWd3uaRWhJ3quKN7eiyHd2tSlMvkSo0M4LJZ5jGfFa2qHmvRj6p8mhki3apEc1HmW
 A5OlTUDqnOpx4H+jjxTno+ijErvKjpbwumjxoNnWJ2BFb36L867LKsmsWrnDtzKk4VKQ
 otyY00aB2ZhQsXBVOMyJyOw5J6xyCSmULgm54HEVmfY7LwwYWkyuH7xWqid1m102tcgE
 32KlPsNirSnE9GW9kdAXEAKVphUASyAB2j7bTuVuJxuHiwKykNootdvmjM5JElExCgnc
 /YGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfX+0OkOx6PJIEQmsoA2LZehZqbiAHUXWXQaC9OMmWR9PTKj/SsCr6FG806i6i4LhXmDazEo8=@lists.denx.de
X-Gm-Message-State: AOJu0YxP3oavTMKXEuAOz3Gmh4VemUBccKmDiekq2fFrUicAlFUhOeZ+
 7fOxLesej1zQ1dgaKrQlH6K7HxC7jBHXsrxK5yGzOR6ov6wbQiVqLLHc2jottcHSVd2A9TI0Bng
 rlU8=
X-Google-Smtp-Source: AGHT+IEkybsyw6SY7AzmRh4t0HJcGSSS/vtV8MvLoF/KQDIcB9udKSWt8c78ScunlZRMjbtnNExAgQ==
X-Received: by 2002:a05:620a:1a21:b0:7b1:43a5:2746 with SMTP id
 af79cd13be357-7b193eed90emr1644293985a.20.1730151284944; 
 Mon, 28 Oct 2024 14:34:44 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3484b6sm357409085a.124.2024.10.28.14.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 14:34:44 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:34:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 3/3] test/lib/uuid: Make lib_test_dynamic_uuid depend on
 SANDBOX
Message-ID: <20241028213441.GU4959@bill-the-cat>
References: <20241028164844.2308549-1-trini@konsulko.com>
 <20241028164844.2308549-3-trini@konsulko.com>
 <7eb00a6a-bba3-4aa5-ba63-1da2c63b3e5f@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pNMulwnf0wf0h+8Z"
Content-Disposition: inline
In-Reply-To: <7eb00a6a-bba3-4aa5-ba63-1da2c63b3e5f@canonical.com>
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


--pNMulwnf0wf0h+8Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 10:24:58PM +0100, Heinrich Schuchardt wrote:
> On 10/28/24 17:48, Tom Rini wrote:
> > The dynamic UUID test checks for the sandbox specific capsule UUID to be
> > used, so we can only perform this test on sandbox currently.
>=20
> The tested function is gen_v5_guid(). This function is used to generated
> capsule UUIDs. It receives the test data provided in dynamic_uuid_test_da=
ta
> test_data[]:
>=20
> * compatible string
> * image name
>=20
> The generated UUID is compared to a UUID provided in the test data.
>=20
> By chance the chosen test data contains the string 'sandbox'.
>=20
> It is not obvious why this test should depend on running on the sandbox.
>=20
> Where did it fail for you?

On Pi 3, I forget if it was rpi_3 or rpi_arm64_defconfig (with tweaks
like enabling CONFIG_UNIT_TEST).

--=20
Tom

--pNMulwnf0wf0h+8Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcgA24ACgkQFHw5/5Y0
tyzj0Av/V0+czE+GAY+vpBequmhXqsxd80+N7qXZk2bfBMsXO1Z9JigY4KIWVkr0
YFafJqJ2PTFL/diaXCFDJQC4S2fa47yOrtaLAHnOywCx3TY0B1EMtuD79iMT5OFY
aWVkY2NcZlZb7msR6uMEVp/LDTZMeyU9Yn8rAea5YJWMInbH7SmAxx9XMooAz9tF
ZJY1hs9sTCkVz0xUcNs2DXmtBPufHDHdFcVYtXsD1nUFYad/SsSWL8jKrb4q8FAM
AtfIPi/VPzf817kN6eUjxUlOWtjCi27iIbvqzh6jf8YbIvHcR8wazCVd69UEOk5C
TcMnH9VfjmOBIZSnmB0JWzTnFgNTLLGojIZqwdcu2uf0IraqmcG7h5qEWBZbhXsB
xx1Xk6qI6JtMSUt9+Zo2v8ssp+dGXEpTj8pHVaOmiFsrgDmFbnJPvDvsCrFS9rNq
drvFTdhj6eZUljsWV7OMNOfKGSrki+6zDjmFN8yW/PfhmzZNZJ+wEgGE/p0Z6Xul
qP31ROV4
=2WpA
-----END PGP SIGNATURE-----

--pNMulwnf0wf0h+8Z--
