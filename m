Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD163C35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6734781F44;
	Fri, 14 Mar 2025 17:53:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JkO5w6XW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A32981F30; Fri, 14 Mar 2025 17:53:32 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBBE981EE5
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c0818add57so251903585a.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741971209; x=1742576009; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CDX+E3+wrNcpheiEzoFb9jULCJ7MGVGWps+AwesbYN4=;
 b=JkO5w6XW5uQfrWtyATfUDdEFucVUWQExx/eE//J8MKIfUza3yXIHoPHpV9JLWuCb+/
 Es3gUmtcPoLEK+e1C44TPXAmjJ54GGPEbljVai49MGXFdbrXm7LTBy21WM2umFLmlibL
 5chcdEe+gRax8i5kamXO/M6GyYIKzQMN6h0WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741971209; x=1742576009;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDX+E3+wrNcpheiEzoFb9jULCJ7MGVGWps+AwesbYN4=;
 b=eYHD1+jQ3zr5DcNNIdgkqT1MM1Gvkaz74Iln4dNH2+yi51zafL0kcbKuzYktc32k0j
 5sxzHBEbHabRi0WWLsd7Fur50smbSr9z1ner24prKtfZNMCopA2frz/poG2Yls+ayvaP
 sdkockN7jb2R8UXpERAetDyEeZkuc1FIJwq4NLO0vY7bBGW6v6p5OvaKW7Q8J8Z2MbnT
 QqPKN0v2FPk6Z866rVxbzwnJh9a36KQn83lL12FVIK/ZqqOfP75HSPqRKMJDLP7uctmF
 PSgrdKTrG0ejD72kpvulwpfsOlFQmMTBF4xzqLyVvH1Fcif8AzpPZHtUVifRkv2dvd04
 JJ6A==
X-Gm-Message-State: AOJu0Yz+vl+zhkJQdYU2QmI0Sok/nP8boF5vATGo8WdfkkmaZXHQPNWX
 +VrUPigIUdiPSVQI7c0Fj9grQo0ArCqsSw27QHUlTCwjxS6nWsRY11kBa+ZWps0=
X-Gm-Gg: ASbGncuGi55fCwc70/s4dE3yCJhFlxQF2k6LHo/3UPPUtjceTIqlSqA3DtHBYL+iLvH
 v2Ja0vg60OVnr64u1foaZw5VLdyoj0LtHRcGx1J8162QQnSk5cXrgRH+tie4auhCaoS13yRu8bK
 7IisveWkpqp+UsxNggiaqi3m5bxYvbrN1Xf1ywT8Y0NbTv8cyH2GfIHeuTF/TIe6zsZhPxZz+wn
 EXtlk/PgXeck5CpPNtzX3rA/3WCmS6XJoQzW7A+pMYExj6AwcxhScgEl3UCryKM3f/OUHRNBwvO
 KCzNMie8hySH3Sev4f/Y4w+L/qou8BEVRz34c7UPiUuqPA==
X-Google-Smtp-Source: AGHT+IEwCCNLq1D0XdPp2QcTdKw8zX5fsB6b0NFj7IbtqdAmVSTXAtx/jypjqLgPlj+K93jBIwMKsw==
X-Received: by 2002:a05:620a:3193:b0:7c5:5cc4:ca61 with SMTP id
 af79cd13be357-7c57c79bc00mr434138985a.12.1741971208728; 
 Fri, 14 Mar 2025 09:53:28 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c9a74fsm278258685a.51.2025.03.14.09.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:53:27 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:53:23 -0600
From: Tom Rini <trini@konsulko.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: Re: [resend v2 06/13] drivers: i3c: Add i3c sandbox simple test.
Message-ID: <20250314165323.GZ2640854@bill-the-cat>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-7-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fZaOFQncfbcblxkO"
Content-Disposition: inline
In-Reply-To: <20250314040902.43621-7-dinesh.maniyam@altera.com>
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


--fZaOFQncfbcblxkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:08:55PM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Add s simple test for the I3C uclass in sandbox.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
[snip]
> diff --git a/drivers/i3c/sandbox_i3c.c b/drivers/i3c/sandbox_i3c.c
> new file mode 100755
> index 00000000000..99ce769988d
> --- /dev/null
> +++ b/drivers/i3c/sandbox_i3c.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
> + */
> +
> +#include <dm.h>
> +#include <errno.h>
> +#include <i3c.h>
> +#include <linux/i3c/master.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;

Here and elsewhere in the series, audit for adding
DECLARE_GLOBAL_DATA_PTR without a "gd->" in the code.

--=20
Tom

--fZaOFQncfbcblxkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUXwMACgkQFHw5/5Y0
tyz3zQwAhGbZnkd83RNbdHCpqsEnOnQ3HihlQjPC78AzJ7dOPOWtRoBdSK5AZxwr
VrW5OjDmiokl9S/iHDPdegyAJAoMO8+MbOYHfSAwjH9EFZmHzBC2UXY1HaJUiOUI
KaoKPemStF1mU8YjNnBwAN1X1gU7dgQjZNlp3Nl9+0K3tUeMhJQmnhEPAJj/FabL
fiVdbFf/9MLxtzQ4RUauezS+olIxX4lFthAPrzf2De0qd68r2wxH9mW60arCPLFY
F/7GYbAK1auQoDENfbVxTXeSBMKLJSlSFdFEg8v1YTFSn48fT5pXn/ymqZdeT0Lf
adcuVGRadepKjepQAYQaiQjQHagv7uD7F5ZnKp8DE1jjs7X1yFNlsezdhn8KgC4h
4f0363byW2nDweUoJGEI1NmbwsWgOF1kvhBbKOD6gPKvVJtLhAV1ZCjVeexyWmTt
TshB02bEfbBQoT/ZcUmEPLNBoCM8vgZysEaZNAjZ+qTyuyRAE2VXbZTA75Fejne/
CPR91Coy
=1TTC
-----END PGP SIGNATURE-----

--fZaOFQncfbcblxkO--
