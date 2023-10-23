Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772D1C25B46
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 17:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE8F486FE5;
	Mon, 23 Oct 2023 19:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TPKg0jmO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB9287024; Mon, 23 Oct 2023 19:28:04 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29F486FD0
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 19:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d9a4c0d89f7so3293073276.1
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698082079; x=1698686879; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gdinfPCLjo4hI/e82x0RKnb+oLxl9iCqr/I5spPzAMk=;
 b=TPKg0jmOvXTSlNVefTdjpz7VBXE1a2qVBkdkCrex4V6/wARcb1w4YcZkxUZeaASGK0
 Ngq/CI2+lztiEju3ascAUnbQqxewU2FWawBtDPxHx+0AJSAqew5m8myWJwCrKsgGSwEP
 pEXCHWmVnCLd34C4WoL1kkmlGv5I73Jzaq4Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698082079; x=1698686879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdinfPCLjo4hI/e82x0RKnb+oLxl9iCqr/I5spPzAMk=;
 b=k0TNT/IcHhJVjGF5Dyq9bopxvrZVV43Ds/eu7GLu2rV1vfeYMdPzQxv8U9S95stDC+
 tEUk4ANYWkII5GLKQDV7rbiID335VzXGd/EwKq/lxCmPIgmCDaXz3Ww2fks3LSRMnvi6
 9tTSqtXoxz3k3aXJVbYlRkIBOrzSC+W5DUeNFwxZj4sp7YC6mP11dex+LYroByROvMeL
 BZVOozq1bxLMXikoysTnAcVtatvuJHzQcuUvHxjk7idOzjyuHepBczxXcgBqPtJwt96d
 WBQI/ep+BAKwwPaLqPMpJfWZ5aVZuyUWo2+CXgwWgUd8AtyoXX04fGPsKTtrQfdfSCC9
 MAHw==
X-Gm-Message-State: AOJu0YxHDETI0pSiiZoqPzg3ShINSMl8C7vYDhZRWJeU3Sz8DVRdbiut
 1HNizdqvcg0+OpeC32CTEck5ng==
X-Google-Smtp-Source: AGHT+IEoPsKgOCyrV9xCDzOd4I0ugoBPMQbtU6WcRyGoEVyXHKg5TOfI3/+W7qU2zagH2olhD3+vMA==
X-Received: by 2002:a25:bc90:0:b0:d62:a199:fb18 with SMTP id
 e16-20020a25bc90000000b00d62a199fb18mr9119916ybk.60.1698082079568; 
 Mon, 23 Oct 2023 10:27:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 d191-20020a25e6c8000000b00d0b0bbe574asm2905335ybh.44.2023.10.23.10.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 10:27:59 -0700 (PDT)
Date: Mon, 23 Oct 2023 13:27:57 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [v4.1 2/2] CI, pytest: Add a test for sandbox without LTO
Message-ID: <20231023172757.GV496310@bill-the-cat>
References: <20231019150105.714407-24-trini@konsulko.com>
 <20231020215302.3511807-1-trini@konsulko.com>
 <20231020215302.3511807-2-trini@konsulko.com>
 <CAPnjgZ2jgfJ4GXR+2qt5Qi=MOc=kubLrMLgYBGuO_trinUHnag@mail.gmail.com>
 <20231021183438.GB53397@bill-the-cat>
 <CAPnjgZ2bKVTwEKcjeawootxXr-+iEmiowtctA52-=v07p+xBUQ@mail.gmail.com>
 <20231023133728.GH496310@bill-the-cat>
 <CAPnjgZ06w+uaSZr6PWo6NFoWfxiNuu-bar4e3zn+bVL-4wPvUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H0Roqk0vEJCVtF5v"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ06w+uaSZr6PWo6NFoWfxiNuu-bar4e3zn+bVL-4wPvUQ@mail.gmail.com>
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


--H0Roqk0vEJCVtF5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 10:13:52AM -0700, Simon Glass wrote:

[snip]
> BTW buildman supports -L which disabled LTO using the NO_LTO=3D1 option

I worry about putting sandbox-specific flags in buildman.  Outside of
sandbox, targets that enable LTO require LTO, just like any other CONFIG
option.

--=20
Tom

--H0Roqk0vEJCVtF5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2rR0ACgkQFHw5/5Y0
tyywngv/aBZu4OLk1SBn2VEdU36SmpI+PikbPqdxoXVBO7ri9ee6iFf40R190ezx
G3l6esUU02V7qZ6+48qV1R/qGKSE4aZHrZXIlhvlHv1ClcCg76eOFGhrpFSmxUnj
ASYHalwQ5SKnyVHD8qr+zrqwmzkJCZZB8InTURz87ziKrrKLVk+QAAfvjQfq6Nko
wpGyPpcZ1G6hChVihaXwDRrB3rOdrUjrlP9X0TdMxS2eMQOZaPHGWwH4uNsn2Aeh
24eYIyoWw9VsVjAJywDPu7q0ckiaThGvr4tgW81TwZ6XU4Eu0Dvn/pg9TbL96O9+
2jYyZF4QNKHkQ3Zl80K+LeC5b4eO/uHf1DqSyOCyzbNgkszLveNWaKlTbuKQObFr
HxWUsu3QOE4FKiAoPBjeJiFcm5GrJ69FQUIADyHMy4kAarqkx7Tf+EzPOdE2/AbB
SUARpRvwW9GopereZxDWjIxSW0A0v6ZOzgAvivRCYDSMy24tCnrwt3OBsQb1oBFY
Zdu7chAt
=Jeo3
-----END PGP SIGNATURE-----

--H0Roqk0vEJCVtF5v--
