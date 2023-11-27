Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5A1C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4DB8762E;
	Mon, 27 Nov 2023 19:18:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JZGMPpSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4B88762E; Mon, 27 Nov 2023 19:18:48 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2F087761
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5cc55b82ee5so42352507b3.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701109125; x=1701713925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yCOpd8FxG37ah8Zsljhft85dMXTcl1RTy/dDnfomS5U=;
 b=JZGMPpSPNB6JJ00why8/L5o+re3EFQBG8MaSUlWc2837uHTGouy7mU2vq8achTmxH2
 DIeh8PympGDiY7ArDeLTBpsh/bZK3Km0Pj6wXMMhaFX080fZ5SMxF3LfwNY+6JQ5RnJA
 JJnBwen86DY8ncu22khoTHh2mq66RkMK3uFL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701109125; x=1701713925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yCOpd8FxG37ah8Zsljhft85dMXTcl1RTy/dDnfomS5U=;
 b=wpF5uhhWzgk0VP8oWpVhjdyGai6RoE6Y/4B2LOXPF28BjFPj6hbpiasMHWTECGh5EA
 CDI7ZfD5ZjS6Q4kw5QgTR7zR0uqm+4Z7yVp14D2WUbi084fiMtNhELkD1Mi7foB/tUqk
 Q5ruTyUXhgCzEWzcmQ7Llfcyk28MGzBnKzPhRTB3+CooVkYJOyKelhZufYt9WX1XrUop
 kNZGTsCVatDa8E3tpYmqA7P9+W5Y/2hXU2emE+RDghJDKouF7ZdmN8YD2Fe6n17NKYPE
 q48KEvjC3bJ5JsAlegmy7z3qJVDVVaAdzPi095DBU0reSsrKgPVKH8AqTw8RuBJq0XVL
 oEJw==
X-Gm-Message-State: AOJu0Yya5D0Um9rFMAtL9aC6GXzWsATK3K8bJTLuQGPyV80k09A9JPUO
 lZraCoVFgHFCsFK87LOPPLUzCg==
X-Google-Smtp-Source: AGHT+IF0l9QnrXYVuRsfWOb6bhbBmJypkVNEcV/3BidpbItGFeSH5XaEkL11bvC0zGXjjX3E0dfffQ==
X-Received: by 2002:a0d:c584:0:b0:5a1:fb1d:740a with SMTP id
 h126-20020a0dc584000000b005a1fb1d740amr11692699ywd.51.1701109125258; 
 Mon, 27 Nov 2023 10:18:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 k124-20020a0dc882000000b005a7daa09f43sm3433820ywd.125.2023.11.27.10.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:18:44 -0800 (PST)
Date: Mon, 27 Nov 2023 13:18:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 15/43] test_efi_loader.py: use $filesize var
Message-ID: <20231127181842.GN2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-16-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xNgNYUWQah2mkvEF"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-16-maxim.uvarov@linaro.org>
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


--xNgNYUWQah2mkvEF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:56:58PM +0600, Maxim Uvarov wrote:

> bootefi code relays in internal variable then to filesize environment.
> lwip tftp do not update this variable. For not I update test to provide
> correct size.
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>

This is a lwip problem then, loading a "file" should update filesize and
there's use cases, not just tests, which rely on this behavior.

--=20
Tom

--xNgNYUWQah2mkvEF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk3YIACgkQFHw5/5Y0
tyxuswv/U4MYpPFGz+4EbvhTH81KfAUn8UatYA/CAhNy0D2fqg/XdR+lCh/kwLWu
la0LC4feWU3Zz31Q9C79N+HmReoG/RFI5ub5CtuCm8pt6WaCYbKWKbpqs+qUFpqy
BUryrLyAQDEYr7CyvwTZFvlUdO8sBcQE702e8h7pNibgZDb9rKD0OgNEc8JS0Djb
A+hL10Z0lR9AgNi4gY5j7ey28LiyLx9+1reRXv+RGJocrocgPA/jTzpGKIn0pdy9
OkzTrAr+FQZwU1mr60rVWmpvpwV/AGHIgnreJLPReJVESDO9eeB59I+I/NvDQgS5
W9dfUA0LteG8u9uGAnJkZHK0iFWxFtdpImVqyIUkghSHBuc/85RMdgPsipFydoNO
fmejUm5wHS1YlhjB/HrBHBew2TpZ0A+Q5D/rCWyFAW/RSYoYP+DC+r1XqZNLf9TL
0ilRf5xnGd5q/oZ61DjYXB2SfrriG/EvNwnopcPyHMDc0zHvDiriWjmsAOhi0iyR
GR6+BbDi
=ITA2
-----END PGP SIGNATURE-----

--xNgNYUWQah2mkvEF--
