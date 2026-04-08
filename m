Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD09810F995C
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75F2684129;
	Wed,  8 Apr 2026 18:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R4RgBKU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B7384106; Wed,  8 Apr 2026 18:25:56 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E504983D8A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-415c8a4d2e6so32558fac.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775665553; x=1776270353; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eijfFiiUfniOwYVZzFyJD5EJw0/5UArmtagwtOsIW1o=;
 b=R4RgBKU92lNcLgulSB5b4OFVLdAOqjjRDGh2Ej4nt5glVv+wr9z9a+/SGJg739L/an
 uKU2Z3pQxyhyvbCcpcHxiXxXgP9VUIjAwtjrB1Y0MqfIDFa/NbiknQDTfQqOhnUAWoGT
 kw7Jk0S7o5KndZx5o/FwHTJq8YzZTAp2cHO0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775665553; x=1776270353;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eijfFiiUfniOwYVZzFyJD5EJw0/5UArmtagwtOsIW1o=;
 b=HlJFKsXxjQPlhd31Pq6/Y6oXVSZK+omSBNmjLnT8omcErGWbKoFA2dT9uxPk0YNkQW
 jn3WJc73lCgW8zSQrblgnkA7fIZK+WDZNJwrIzDpwY/amcZxGlCsJOTK5I2aOo3+0AMW
 Pq8AJwQXkorFK9WUfghXHe58eBWzN0B5rz6HagbLeELPPB3g/xFg40PqjGuiMOFjKEGk
 Tn2JVcw+JFLxcNULGfvtLAEZxcTyO20YwOzOAuhx0Bf06bjiYv+Rf+b0tvRrx/ZGEF3+
 VDcFD/kuzLuFN4XgRikJBvEMVicmyxBgRauoKJ6/IbKKJncfHpSKQ2bM0cMV4CMv6t+P
 jVOQ==
X-Gm-Message-State: AOJu0YxGERBZ4bKIjUaJBeUAEzh7RYZ03ZwyT3O/tH9vVqeQjAK4R6ah
 JoyXZWA6F2efaFPJMijHaOSJwbMDS9eKL0w+UACjn8JaH0Ut72eiktuQiYf6kft9I/I=
X-Gm-Gg: AeBDiesfsksiD/0hRTnckGHkP/pWR5P4R3fHofC4AWKY7AswK1/Gx/Jn/Mlv9B5Udji
 BbyJNVT4tuUSKFHN5ZD7CrjzFR7+XfnAiro5BCdZJsfDM1czAOXbzwVogDibuV6keHxcH1p/glB
 RXTr69bMMAknfVVUgN89F1qZIJeBwUQTGiX+IXMRNwMq6Wj+Z/2dsiu2r+eCO+Iq03fjacEFrE/
 AECTG/cQwIv/Y9IbCmccl0WbMzdmcxLUzlDFEUEeBT5FL2XhIHHkSaKKCrkEQ4KcsbqaQ2babMZ
 H7Fj9dSpwQTuYhNBOg3+Xj+pow0JRl8zrkYzXmdGuZlygAyrhlQG7ZsmrB59tOUPW8BAUdu+O03
 uSrV1McdlvPMkE6ulG4lZJ/wUxdJ+h5OCTq1y1RbHyHa2wovlPzkSRtZyTtrVJXo2989mg9YKIF
 ZJPmf6py39dsThbnhvm0DGRbRgKiPeidJlIIwGJMYR1POhwG8KovpcllZM1n4P0pHbf8FEMIptz
 QTLFSpe/PQvySlns8R+/rzyjqwzNypqP+TLUmEgNK1XBPHI
X-Received: by 2002:a05:6871:a863:b0:404:1c81:596e with SMTP id
 586e51a60fabf-423bd8f9cb9mr29527fac.12.1775665552645; 
 Wed, 08 Apr 2026 09:25:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42356d581c1sm8115405fac.4.2026.04.08.09.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:25:52 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:25:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 02/13] boot: Move call to fit_image_select() and rename it
Message-ID: <20260408162550.GE41863@bill-the-cat>
References: <20260325165431.1027591-1-sjg@chromium.org>
 <20260325165431.1027591-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GX/wIp/Njj/P28Zf"
Content-Disposition: inline
In-Reply-To: <20260325165431.1027591-3-sjg@chromium.org>
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


--GX/wIp/Njj/P28Zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 10:54:11AM -0600, Simon Glass wrote:

> This function is named a bit vaguely, since it prints some info and then
> does verification of the image.
>=20
> Rename it to print_and_verify() and move the call to select_image().
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Renaming functions inside a bigger overall series makes review harder,
this should be independent, either before or after.

--=20
Tom

--GX/wIp/Njj/P28Zf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaBjQAKCRAr4qD1Cr/k
CpPLAP0VCR6sybGYHP5c82c7w77I5cfDZ6s1zFmy+4mZj0gKrgEAh3fAFAa2BmvF
rK27KhB7sXjtsN66DrzM1a316/6bbgA=
=5mFn
-----END PGP SIGNATURE-----

--GX/wIp/Njj/P28Zf--
