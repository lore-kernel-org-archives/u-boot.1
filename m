Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E2CC27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0526388912;
	Thu, 13 Jun 2024 17:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b6sP7KkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E8388917; Thu, 13 Jun 2024 17:33:10 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6515587F51
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5bad66c6e27so487204eaf.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718292787; x=1718897587; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D7qrAFowGPRJu2n926Sko195XjmAevRBA53vFlCxPgg=;
 b=b6sP7KkQrIf2qdxNtJpZG83Lk/KaeCJRhHwBWyyzass/PnAoz+9F5l4OkXtBRGdNW2
 vH1WIOwFb4w0arwaFYo2TcMtoohy4MgU8zcR7casOs2CAoeqYz/yyKpgIIRcE2Fsemhz
 FJ9HJqpUcWxjFqQFZLgdjeoVmKNA/19SFe5k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292787; x=1718897587;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D7qrAFowGPRJu2n926Sko195XjmAevRBA53vFlCxPgg=;
 b=r0RNUOPFZmIE3juUSnQ6gGCIJrpJ9ZBZ+Ne6nIRcHv55Ck1AQ6AXytirclafJTAP6e
 QrBWz2RGn8J3/rpOEKJHb7bGD42jdHo7w+8Eu9v/+4rDTZt5yNAX85tdYZPX8GBv0AXx
 kyvQWjmrNeeA12CkaarPmYcvcRAFWZUebzYRhi5B0a+vseQtXfAcpUsak43MdmN7EjiY
 q2JRVy3drz0yZMTYorccWfu2AVxZPWdZ0I/tsYgDqYF8tLzqrUnA0SgOpw9snFeki4WG
 hiB9W/JjyoqReE1YuEI3banDDHaWuKo4MTbU1d8soYl6VWYhsZF9Kk3anOpBDRkJSjpq
 s1nQ==
X-Gm-Message-State: AOJu0YzSNGq3AF+jBJqIzkiQhd4H2Pvr5STMYr+IZWTR9cFlxY1FBOu+
 mnmr031jSPO/qfEtlSVryrVXQzAuP6hDIeZfTLsDrWhkgVoqgI2XIIom/ZqBQpY=
X-Google-Smtp-Source: AGHT+IHZhKaENucYq2lYCqzp/2xzbM4vm2rV1JF8Wgs+/tsqVwtjsLD8cxwU3gfDjdOekfPjk8co5A==
X-Received: by 2002:a05:6820:1693:b0:5bb:218e:3436 with SMTP id
 006d021491bc7-5bdadb68e87mr26652eaf.1.1718292787062; 
 Thu, 13 Jun 2024 08:33:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd62928405sm200851eaf.45.2024.06.13.08.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:33:06 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:33:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v2 1/2] Create a common file for test
 scripts
Message-ID: <20240613153304.GL68077@bill-the-cat>
References: <20240613011512.2476324-1-sjg@chromium.org>
 <20240613011512.2476324-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7BYc0slGgxHXGjkX"
Content-Disposition: inline
In-Reply-To: <20240613011512.2476324-2-sjg@chromium.org>
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


--7BYc0slGgxHXGjkX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 07:15:11PM -0600, Simon Glass wrote:

> The top part of each of the u-boot-test-* files is common. Put it in
> a common script file to avoid duplication and to allow it to be
> replaced for the Labgrid integration.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--7BYc0slGgxHXGjkX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZrETAACgkQFHw5/5Y0
tyy8NgwAiUOVmKHWJcNORlcOLnbfTpWfovD7InRqflgMZWcfM2fSt/x2SCl1IMm4
clgBpt2akdWhxV3ceAfASFkWoQknWZhVygnIBwJqo2KmVk3fBprODUL6MIbrggD/
snKfsPAsCeIK+DbsvDg/nJ81MK5C1kHo03PX4scToGcXyd/n/IcYOJpLVJtJ5hMH
rdMr9AYcV0TS7Ql+QeA+svZrWI/In8/dvl7NzVLieP8uEBWLldnRAxReKYow+Amn
6zKbXI8L9teavpYq+cnifAZLa1XEjoVdn8Zrq8JyV6kYGkIDHYTQ8wTwZMMUjn5h
fOZBqKA28TB7zT4iAO6pyQrmtWIWP8lDj554jQ3w6m6SHPMYEsZ+H+hWrHkMuf4r
n+lIswJFBp43qeMCjAxiGq7nKB9GqfAhYKxxnU1VzGLngVtvud2JIWGgs5Nf03Da
bZb3ylZZHFPQPfUcn3531ZW82lKP/s9mcZgJa5L/HW5qrhcZ7SYRtg2qZls72P70
+h76kK2K
=7EjU
-----END PGP SIGNATURE-----

--7BYc0slGgxHXGjkX--
