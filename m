Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF371CCD184
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 00:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6BD583B2C;
	Fri, 10 Oct 2025 02:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WH9CymnG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 881428409E; Fri, 10 Oct 2025 02:05:02 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB5D83B23
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 02:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7a7b084ef77so901732a34.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 17:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760054698; x=1760659498; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=y7HZFIgH1ykQwy0aClMFCmqANTrfhmrxkb8K5SeS/qQ=;
 b=WH9CymnGA7vF8KPZcuchy2lp152w+hKrmGCAP05ho9YzvmUJLHY3bfX2KKEuVfJ/Z/
 bzkydm7TF6TWB6l1wTjIWttpIq3h0aNucr7IGg/0rIAMn8kymg+1yZWmhpMHk2wWoWCW
 aPsWrMpOPOmVE1QfEfmklpTqRbXtoi68VZiIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760054698; x=1760659498;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7HZFIgH1ykQwy0aClMFCmqANTrfhmrxkb8K5SeS/qQ=;
 b=IpUtob7hcb7TXSbg+dQO3vDSwcEV9wHXTdf/ZnfZ39dyECQ1/G5QHBY870Npop6zue
 wxLVFt8NZ5wUR4NTzTQpQc3xLgO3rFFXO9ZXUHqUzKa1Seokw7q1MB3RvUfpQMv5/Kqp
 rLpA8ojawNHNlPjdDugn8RPAqwh4feLOSPuuyxns3JhwW1z4n6gkuvoYDIZ7z5r2fVG3
 v36yztWNOLNfEUELeewjmdlqKQxpoIHsdsz+K46I8jV8alC+qBcgb+MblvqYcB2ohXOx
 ytheoxOEQ8OLf+tHFv++Rh5YgBTGQVLX4JcQ7kbghpR20+z7mdFFnLt8S+6t3jOYdFOE
 m4Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj/Ulz+oXCsYSntJ+5asoRIJPYqB+yyDTAY3OPGmmdO8r4DnIJ4WnSEhIcykoNbEp5isIbG58=@lists.denx.de
X-Gm-Message-State: AOJu0YzTQ8B2/hGE39BPyHJkOjB9OEu474Kel/O1Fv0xX2j/LlEEznoE
 Ejusok6lWsdkEqLojTc8gQCqppqCQPrJ4+IjkPqP7ZydoLYSIUDFF6abuA/2HCZduIY=
X-Gm-Gg: ASbGnctKkIu1Q1iUg7smU3pJj0dcU8VVHsQmlkbxsRUbRkdbX8GZgbOGXFO7qwh6kjP
 AiM7N5CqCVgsqNhtCIrz4/TPzn0MlXLKtPZ2oIucvVX4ONpba/0SOrw9jR852/X4wpjLrVC2nVZ
 XiPXb3Iy7fxY9sBFeP7dX+KdFuRU6/0LU5wEHiKoF8tv2gVZlG6shdLWcSeC1NPOszxVcOeD4M8
 Qn0iPHIcCnnoqJZXOpaahs3cwDmzx8rPKn8dlGI3NtbNnWf5tBIvwF1TG+YOa3dQrMyi6+5JKJX
 1CWVhJuZq/1MkGGCMDpwyUsdFBhCB5G8XjuEgLs/Ts/QRk1/oyjek8vzKb1fV3oElbfU9DwM1tv
 Cb2tFYiMlB6MevZV7GVe3nCUWcIzjNxnPbYWR4Ym/JFUvEFTzxS3WBC3uDMPOnXBm2z5Eu/faXV
 Fgyy3NwinfbQ==
X-Google-Smtp-Source: AGHT+IGnzGV4rQWdUbZWXrSCRhzQlVspW6kdKfE1es86JmOz38R4Nu4YjEfpyUvGI4ua7SagDsC+Tw==
X-Received: by 2002:a05:6830:710c:b0:744:f113:fef8 with SMTP id
 46e09a7af769-7c0df7becc1mr5058975a34.35.1760054698519; 
 Thu, 09 Oct 2025 17:04:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f90510dfsm349061a34.5.2025.10.09.17.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 17:04:56 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:04:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 07/10] firmware: scmi: mailbox: Support
 arm,max_rx_timeout_ms
Message-ID: <20251010000453.GU298503@bill-the-cat>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
 <20250927-scmi-v1-7-5e9354fb3bff@nxp.com>
 <20251009201422.GA226328@bill-the-cat>
 <PAXPR04MB845960B0A575E637752842E288EFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="N6Y8CERn9aZ6/bFK"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845960B0A575E637752842E288EFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--N6Y8CERn9aZ6/bFK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:01:39AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 07/10] firmware: scmi: mailbox: Support
> > arm,max_rx_timeout_ms
> >=20
> > Reviewed-by: Tom Rini <trini@konsulko.com>
> >=20
> > However:
> > $ rg -g *.dtsi arm,max-rx-timeout-ms
> > dts/upstream/src/arm64/freescale/imx95.dtsi:
> > 	arm,max-rx-timeout-ms =3D <5000>;
> > dts/upstream/src/arm64/freescale/imx94.dtsi:
> > 	arm,max-rx-timeout-ms =3D <5000>;
> >=20
> > Is the timeout really 5 seconds on these platforms?
>=20
> NXP i.MX SCMI firmware does not allow timeout,
> In normal running, it is quite fast for SCMI firmware
> to return back. We just choose a quite large value
> to avoid potential corner case.

OK, thanks for confirming it was an intentional value there.

--=20
Tom

--N6Y8CERn9aZ6/bFK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOhNoQAKCRAr4qD1Cr/k
CiZMAQCTJfmBhpuInV5YcDgOMuMj3m31Vl694IIo2jROEsi0dAEAnYzWeJUK5duP
R6mR4HPiMNq5OagxXTa82fM4WJ/WGgQ=
=ZkrC
-----END PGP SIGNATURE-----

--N6Y8CERn9aZ6/bFK--
