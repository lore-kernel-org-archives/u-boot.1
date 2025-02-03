Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05451C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B391980780;
	Mon,  3 Feb 2025 21:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tnuesExj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6AB807D7; Mon,  3 Feb 2025 21:10:51 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825B080780
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-46c7855df10so84370381cf.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738613447; x=1739218247; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aCZJbHFLSPkX+UXBVRxG5DPb10LIVaUUK3Qcfu1fuYo=;
 b=tnuesExj8DrQWGuVs9xZmKreUpGEQ1HXLEU+Z4uk/6jKAly83tHefQsAtOmwXuffYF
 5FJRtamCkkjrsxjVvinvO76ozUfgh5gVj3TTuXBARcYhj4kd7qLHGFgsIk5qMc8pKC4H
 DjlIfI2JZssvRZA9I6EegJ7wJb0jUd/QZ3tWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738613447; x=1739218247;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aCZJbHFLSPkX+UXBVRxG5DPb10LIVaUUK3Qcfu1fuYo=;
 b=IRWTPB3JkNZzKPM1zGrulOqY2uj9bHj2rJLNl6Mz5Qilx1ZN/+EhCmdVUGqh7aVans
 ugI7ukIRp08VxnbjtxOY2i2tGGsPlDFtbfKcTyysRHIpFnficxRLS+RDsU0E2hCQtqj4
 TdGERTRQja+GrjsymTT+xXC3axGUEB/HVxundmLzxEVGT+HhBCQ1GpoHvO2jMOH5XJFw
 DcOCjxK13++gtVAqqmqJyX4R8ErH2b2trcodooXYcATfM43jroj+HULI4BWiGzBI3vIi
 VRyuvhbzXy2RmRbXajFpkVRtfSl/3qq4OoNO7qMubdUUxEJUku9wbQIYANhBw7lIX8pe
 lJuQ==
X-Gm-Message-State: AOJu0YzePZfRuZLkTuEahevMybqMMHFNjY6Dy/qsbAsix145lInJLRqD
 xUJLK7W52cRqjnb1MNVWC7N7fuzE97/C8D1pJl0OYoYl9ZegUEozcZneTQuH/O8=
X-Gm-Gg: ASbGncuNL9U3XGenRtGf5s28gvuA7P++R+27SPTPqTLWS4dWT/Njn4ddcAZ3iOAG/2G
 JSQcfJlk56wv78WFf2+/+L7JevHVrFbwHbI0HLzdQt+OJNXVGIjkxMN99le7qvOyUCTFCEQvRg3
 C+GQ45MCg5NBLV9cwY5Teh8i8mHaO/O3PdFk6GEGZ3plZvS4USAU3xZp07VW1hZ7d4WSUE5Tn7P
 E9T5S4esWtCo3CB9SWp2G7z2g4pRin/m6NyvqEZ+ATDzEqWxHukQkRi8oZnBPKC0d1FArKUv+Co
 GRLqRI2Ozro6184=
X-Google-Smtp-Source: AGHT+IF9NmltR8b8ct2Rop2tOnsh+jN5CXT5qAVc9aW7MIg6nejNk0vues21doa1NO9JwVJn+BDuNA==
X-Received: by 2002:a05:622a:130d:b0:466:a93f:c1c9 with SMTP id
 d75a77b69052e-46fd0aca884mr271950621cf.24.1738613447477; 
 Mon, 03 Feb 2025 12:10:47 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf1895b3sm52210511cf.71.2025.02.03.12.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:10:46 -0800 (PST)
Date: Mon, 3 Feb 2025 14:10:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH 32/32] efi: arm: Add an EFI app for arm64
Message-ID: <20250203201043.GU1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-33-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NnSgY8djOdN22zpH"
Content-Disposition: inline
In-Reply-To: <20250203174245.1331464-33-sjg@chromium.org>
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


--NnSgY8djOdN22zpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 10:42:25AM -0700, Simon Glass wrote:

> Introduce an EFI app for arm64 and update the documentation.
>=20
> Provide a value for LOAD_ADDR to avoid a link error.

What's the link error?

[snip]
> diff --git a/board/efi/Kconfig b/board/efi/Kconfig
> index 33bc364861a..75d272d2418 100644
> --- a/board/efi/Kconfig
> +++ b/board/efi/Kconfig
> @@ -45,4 +45,26 @@ source "board/efi/efi-x86_payload/Kconfig"
> =20
>  endif  # X86
> =20
> +if ARM
> +
> +choice
> +	prompt "Mainboard model"
> +	optional
> +
> +config TARGET_EFI_ARM_APP64
> +	bool "64-bit efi application"

Each of the targets should depend on the correct architecture and then
we don't have duplicate choice/prompt.

--=20
Tom

--NnSgY8djOdN22zpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehIsMACgkQFHw5/5Y0
tyxvXgv+PjTqBkPLtK/1uNXrJyomrGbZLJjTAUbxZsyLbRR1lKhvWe0yp0uBmDRG
uVXvubMC5DncDw5Q6vYovGDKgL7AhtKwfSWnQ8Wc3V/irl8PyMrGRUIhDPTjNagm
PUhOfNAvRHhNTWtVQkfjQVx7WujSPyUgt8KZev0QPlJiIgD8ux1bgVRcR8EUa/8i
ijDFNur7r8B5wbufCqupujdL3UI8SS7t/SWadVR/yelGULEYSNKS45RZSxDhqdLm
249nrBw8WdYPrtXNte9AmdWtSE8J7+itG1Az1yR+FhQIk4VjdHxBx7aAPYu9VoOa
+K01LxsJFfga0IsCCC0//x9udtvDwz5jLaQL4OTbGsksEkicA1lVnoTN9o2sQKHY
/xhR+tVRaAaVwvYD0mp/GXpwEb6PfhkRfHzE6iSTMXluMYcOsFnkOQk7hbEVWYve
y5jRr4roeSlPRb5hUQj/nM8bStfpw9NxNi0zTjP+LymDk86DTNY23+yEpHepHgxd
B+zwHVTp
=Xwk3
-----END PGP SIGNATURE-----

--NnSgY8djOdN22zpH--
