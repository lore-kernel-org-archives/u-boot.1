Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A747FC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2164887A0E;
	Wed, 25 Oct 2023 01:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r4EO0mKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55CE879FC; Wed, 25 Oct 2023 01:17:26 +0200 (CEST)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06DF2874BF
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d9ad90e1038so4597784276.3
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189429; x=1698794229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dl+enlDnJiA0DZnY5WAflybKl08C1mJKrpOKluC/K08=;
 b=r4EO0mKS29+VDDPpRovgsf/K+Vg09oY+qIOjIS+mAK7tmtDOLNWmiTcVIKP0eRMTzo
 LnF526jC8kq3C4wuVfYjBM8Tr3+Q/049/ZhwoZDhp94biELP6rhVCR//DFmGf1qHXw5m
 Yl8uOt9hMvquZB66O6S0W9Z74UH/VRv/1CMn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189429; x=1698794229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dl+enlDnJiA0DZnY5WAflybKl08C1mJKrpOKluC/K08=;
 b=MUiRLtq7PQaoq4lulPYofPkOIbiXZJsb/77iLG1MMv+6yDOdGgxOj2vu9wg0siTaMF
 C3D1M0pL0+zxihVZkB8oorUTa13tgwIj6rmtpUlf5xBO4YNle/J1qVgJ8bTg4XS9qPCf
 /MP9GMGCSk03FFhCInofEPDggZiEhqFx7omBkjMpb+vgJGbI8LCUvJtyda/TmLgvrsHw
 mulvcVTv84Rb6QNocMNXKSIDlMKDBCgY1Nzt2tApEIZMNv2Z8UtRGjWwDI04b5hDMGZC
 L08R79IwWGX5dv6P2BehMTYOZsJb1zP2FV1KWgU2esG0kY+oAuHe/OoFxM0t+5yAblPb
 QIIA==
X-Gm-Message-State: AOJu0YyzcrJUJ4nYvGzdqwRdxJN60vMGJ006woTHpV7e1H5b3/nZlY52
 C8V9z3nSA1bYQHekVmLsMNCIWQ==
X-Google-Smtp-Source: AGHT+IE5fAVyvSsuvVmNXqzR5cZaqyD+88lbJ/pIOoPDPpwYRcSfYNt7X7X4qtS87M3xI8DO45o2OA==
X-Received: by 2002:a25:2404:0:b0:d9a:3992:192d with SMTP id
 k4-20020a252404000000b00d9a3992192dmr12747574ybk.16.1698189428807; 
 Tue, 24 Oct 2023 16:17:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a258184000000b00da034601e2esm1064313ybk.52.2023.10.24.16.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:17:08 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:17:06 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] firmware: scmi: add power domain protocol support
Message-ID: <20231024231706.GF496310@bill-the-cat>
References: <20231016053946.470458-1-takahiro.akashi@linaro.org>
 <20231016053946.470458-2-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FyKCB6ljEw7Muhnp"
Content-Disposition: inline
In-Reply-To: <20231016053946.470458-2-takahiro.akashi@linaro.org>
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


--FyKCB6ljEw7Muhnp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 02:39:43PM +0900, AKASHI Takahiro wrote:

> In this patch, added are helper functions to directly manipulate
> SCMI power domain management protocol. DM compliant power domain
> driver will be implemented on top of those interfaces in a succeeding
> patch.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--FyKCB6ljEw7Muhnp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UHIACgkQFHw5/5Y0
tyzcBQv/ZGTn0jScLWiSLirT5uHdec+GsSw7NczGOkYkBD0I4QGfEgo9iesx/E/H
/m9whwCgiSnADow4pjSFaBwN86UoYXzFDYdHPC4kos0Som8u+Ux1g1vNr6zhxZEK
H1fkm6OuNtj72snN3caIp+FBVlRypnQZEfXtVwjqA7t6JvkGI5SyaWDr9GBQ1rvX
zbXKOuIxpOOnBGeX/u4XaUOYEsIGGBi/dENeK/46N4aG0WDDkJxHKh+iWOCG5oC0
cIL4alCPJ7FO7/OuJt4feMepWhjvxiqGKfnh5tKfrUE7w0PMrf/YTtVeWyaEuMXG
0f3R7IGmyVf/23v82MsoT+X6pmFjsukpngpkGz8TUhsZ9HokWA46zHoLMPaCUpIP
VZwZ+yKkuZJPEal893ZvFLiQ+kiWZU/2HKoIH7wKJv7dE5yVdeVoVJalxvrRBycS
gQWPe8Xkqqov96fbWvHkvZ4vY85kHq7g8enP7j2RL6nUSMJ3IxyYVs36VGUxSP6f
v2u0W4ar
=0wfl
-----END PGP SIGNATURE-----

--FyKCB6ljEw7Muhnp--
