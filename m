Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C480C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 21:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 080FA82102;
	Mon,  5 May 2025 23:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gSmKvu2m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778B78210D; Mon,  5 May 2025 23:08:23 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414BB820EB
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 23:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7306482f958so3212232a34.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 14:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746479300; x=1747084100; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x2J3RXDm/HD5p9xhbuToFjnYNDuKJYzFrJDGRItCx3I=;
 b=gSmKvu2mXXcEABQpXo3pg0a/42NDFb6yF23n5VTlnGzRRJAru4UJZW+qALbFDoQ0Cu
 43AmYOo8FJR5lW/rhKt6QMk3R5rtQK61RQWxs0EsElDBD6ssx+9ogXH5grltnhNFjYe4
 2P7GtcRhmZUcWOgw6lvpNq2JR4AEhXWW3ZlLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746479300; x=1747084100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x2J3RXDm/HD5p9xhbuToFjnYNDuKJYzFrJDGRItCx3I=;
 b=jJsM/upfc8+jixxNEbUE9+uw1T07XMCTq0PjEblIdpzdYw92TiRzhA6hVH1KhILVnN
 1aVV1PStJgIdDfqJvvC2LInStgrHXPUf0Ywvn0L8xoxdl7fsCer8NG5iMe1e2JEAl65L
 a2tGORvXovPrKZhC9vbkEHtVV5MllGqvh5x3vdgOgmPZI3pP/ffoSUUcCTdU7uh9c3wj
 la1YSagUV8A5q7JxQ4fkpOGIW1dQY8E9bP4PNI8lvAKbnr+CtE3PghcHZu6W9Qvwyvor
 8E8Jkq6vh/rrZRcLkXGxfD8bm6uPQkpBpXJuv++XaH4upt/UOM5U2IX7BMu4dgnI9gJ4
 3R7A==
X-Gm-Message-State: AOJu0YzAsWvLvuHywfyn94H+v2j+lXI1/7RgcFXRXZhpdk7I3JbiAfAT
 YySQQ+rkU1bkiDdy2uPsYz4whPNimZydw+nS9g+nixF+AZEwF0hjIfPLb9eFcYFRKi3HrYo/SDc
 v
X-Gm-Gg: ASbGnctiIAbTjfLI9o49Yk/0k/Vu6w209H3YO1cftVkDc9PEEqvx6K0/Y1ewDPEZCnU
 +ijHPENHqY4H4wOUzrfQRELEzFPoVhzUUiAo6TGvb2zUiCSDya2YRsEQiuC+62eY7ubWzX8r6vw
 fiGS5LyejUeARWavXZKZlKd7UYaOJrDOIyV+GQuzCWgJOTraHYgngVcdIN6+pagpImgd+ru+Wry
 GFUQw8Wz96PTBINQL2lxy3ZumjVJT/z//yuD8pQavZNwTkYBM/8z7Q+tOdEbGokagZe8u2k7YW4
 U6z3Ee3w1jtCcGrlgdDQPoydjK68s4cnsiswjlhmrTX6VpuiDvM94Rg2PMPkTzM4GpU2jdh0ucU
 OVQ==
X-Google-Smtp-Source: AGHT+IEJz7oaKI+1ZHEJUjcizoAijmINXm9J9c9S4jNobBZ+MPvjKn7d2RntMAcRrfFRgEHfvurTmw==
X-Received: by 2002:a05:6830:6e9b:b0:72b:93a0:706e with SMTP id
 46e09a7af769-732062e5ce5mr631951a34.23.1746479300046; 
 Mon, 05 May 2025 14:08:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d350a9edsm1735188a34.66.2025.05.05.14.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 14:08:19 -0700 (PDT)
Date: Mon, 5 May 2025 15:08:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Javier Tia <javier.tia@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] test: Add setuptools to test requirements.txt
Message-ID: <20250505210817.GN5430@bill-the-cat>
References: <20250505205052.347616-1-javier.tia@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ne6woANkx/nXfBOj"
Content-Disposition: inline
In-Reply-To: <20250505205052.347616-1-javier.tia@linaro.org>
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


--Ne6woANkx/nXfBOj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 02:50:51PM -0600, Javier Tia wrote:

> It solves the following error:
>=20
> =E2=9D=AF ./test/py/test.py --bd sandbox --build
> +make O=3D/u-boot/build-sandbox -s sandbox_defconfig
> +make O=3D/u-boot/build-sandbox -s -j32
> Traceback (most recent call last):
>   File "/u-boot/build-sandbox/../scripts/dtc/pylibfdt/setup.py", line 23,=
 in <module>
>     from setuptools import setup, Extension
> ModuleNotFoundError: No module named 'setuptools
>=20
> Signed-off-by: Javier Tia <javier.tia@linaro.org>
> ---
>  test/py/requirements.txt | 1 +
>  1 file changed, 1 insertion(+)

This is the wrong place. You can't build U-Boot without
python3-setuptools being available, so it's part of the implicit or
explicit dependencies in doc/build/gcc.rst. I believe for Ubuntu/etc
it's implicit but should likely be explicit.

--=20
Tom

--Ne6woANkx/nXfBOj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgZKLYACgkQFHw5/5Y0
tyxWlQv/eGF6BpWuVffCKk7ebglUtb/k+CkddNTjBnvKAfkkQ47ZIObJU3+0Uw5y
6VKP/wguZtIU+ao/x1XApMauQpTnPJzkC9eTnK8cLitBrTH8+NPqTkpjuvURiZ9L
RfVCu3HV1D+rLyLO7e/6FPCbcmV9daSVw596BO1p/SC1c/kHw9FG6yZtrJl0zhaw
WwepIbwKgFvDrmcchHlXQSBHif6n8cmfGk2UgE9qONa8Fi998faqIehL8cZndHWm
79rjHPnUzIqk92sNnlBuiGlPPeiXLhaYd8VDd5jBLkco5HTHT8Aou/JKo5XPLA99
WclEPlk3yOTerGSJxyv1Ece1A40zP5ju3For9xTuMNz0eVAD+dERkp7jlgsgIBMM
4/dhIh0fkyBZpSN97LwZjCGMPrWbvkdRvfEo2wxPenWFrQ27voPCQzAdWMtsd+Le
P8HjaFrZlIzB/peehH+8E2oNKhoGWwlGLdEN7eSPLlMbF1/eNY/xuHvjF7Oog8BL
7pY895L3
=8+Zr
-----END PGP SIGNATURE-----

--Ne6woANkx/nXfBOj--
