Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9BBEE4987
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2281D86F60;
	Fri, 18 Aug 2023 19:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TjZx/8Xe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7E786F6B; Fri, 18 Aug 2023 19:50:03 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7CE986F32
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-58d31f142eeso12176197b3.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692380999; x=1692985799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oEEL5Fq3PadMLQljSSDnA7Oq5qOFhXivptw072klJnQ=;
 b=TjZx/8XemzWuPTGfsuXkVyyG6ladsJOdN7FyLT2p0zJuC7p7imeTtJy0NdZh2dSaUF
 dTqfD6hox/8URywJKjWd/KB0aZ5nAAhW0fgDy9lgjKbduLX8SXaLY6rYfoST7FTaFBF7
 i3Pdn+g3W3+YocxjkvSlPuLGLa7hK1404ieBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692380999; x=1692985799;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEEL5Fq3PadMLQljSSDnA7Oq5qOFhXivptw072klJnQ=;
 b=l1n2aorXYh6X3C6iJRoY/oVe7zCvjMTmQVSU/if2C44WaDbAP6Dgcdy7XF1C5E9Ghl
 lqrCPdQuaV6tHVREfvJ3HA/KGdYoVl2qwDCnlnI01AHayzRjYVWEgGvuddCkNtFMvp/W
 I9F1jSvvHcnj2QtC8ktcwthh7NlVZwCNEphkGqy/VKRJ8p3/YdHRjpECMT4E2A7UDRc1
 Rt406nXL33TjWHWtfc6aQtRg/dHqP8E1dCOtk6ANBtRe+unJo2HPSOwTWFxnkx9kTdgs
 tdl+yPMClHZoaIehnJZ7Rxb59yiIjMJhpPiUGHb93Szv3Sku+iiwCqL+D255XeVMMrHI
 Da2g==
X-Gm-Message-State: AOJu0YzMJ3kT8ime+UQWu3Bhbyw6BFJzQLsZZdkwXJ1RKDyWUT3DIAxW
 XsahC2Ca+y5hD821zsr/n5vUPTB7ZX7fdCrLB4mA9A==
X-Google-Smtp-Source: AGHT+IFI5WjTeFSiI137t9k6MeBWKI4whYciWlyyJzcgiSHO0atqo/hCwxAimoEPHbfeLg37Ifxslg==
X-Received: by 2002:a81:4910:0:b0:56c:fafe:908b with SMTP id
 w16-20020a814910000000b0056cfafe908bmr3762884ywa.38.1692380999545; 
 Fri, 18 Aug 2023 10:49:59 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 u64-20020a816043000000b00582fae92aa7sm626661ywb.93.2023.08.18.10.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:49:59 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:49:57 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] CI: Switch to tools-only from sandbox_spl for tooling
 tests
Message-ID: <20230818174957.GI1515023@bill-the-cat>
References: <20230810165224.514772-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k5YdKG7WLC7FwP6g"
Content-Disposition: inline
In-Reply-To: <20230810165224.514772-1-trini@konsulko.com>
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


--k5YdKG7WLC7FwP6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 12:52:24PM -0400, Tom Rini wrote:

> When running tools for various tests use the tools-only build rather
> than sandbox_spl.  We used sandbox_spl here for historical reasons that
> are no longer true.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--k5YdKG7WLC7FwP6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfr0UACgkQFHw5/5Y0
tyxpPgv/eGUzb5pXjjhxFc718zmH3cBpv4LxmYDkRWd0t1aIugxvlBox/4+Ssy0X
PL8c9H1/nlXPK0lTg4ZJHwxi7dDiE1V3mnQ6lLiKdmp+oH6WAeCw0IelJUX1nFoI
yyEvi45ALADX5/kNE32BeVY89oEUZCUZDzIBMVzR8x28DIYvZsL7yE3AtPz5iJJd
MROZ17uU/lFqXEToGcGkX7acKdztCUmAIhbFWUkAWGsMhcjAQPShFHvMInflt5b7
BdMtpIzurnxYvoZvILZwy4inXE509JGXpR4uJ+ZBgS5lQ4ybHNADMQ6CSndoy8tj
ZUxVslK7VdsdHztox0PXTIxrHIE8GF5RgS073wXY7Dc73p1FL+zGYGPBhMPEhOlK
8dJlk3vcXQU2IBhZajHDvqbD22GLaB0YMK8qPyBN4Zs2gg+3FdZRz4AIw7KoCcEu
k6oiomZUfgkctlZ6rrujHZn2RBRPDvpkL2Xvy7Bm5jrxo6bdCrB/KUvpHOje/tT+
flE0wS/K
=q0y+
-----END PGP SIGNATURE-----

--k5YdKG7WLC7FwP6g--
