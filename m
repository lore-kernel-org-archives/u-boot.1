Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78FFC35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC0D87BC6;
	Fri, 15 Dec 2023 14:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SWobo+iA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58DD87BD3; Fri, 15 Dec 2023 14:49:30 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 766D687BBD
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-67ad032559fso4371066d6.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702648167; x=1703252967; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m1V2abb+jqP7q59eoYmg01F9g2D+oCQFBJ35NP5GM1c=;
 b=SWobo+iAJ273Kq1ehdqZyxrYL40E9TvpQRACMueYTs9Q3RyKi/0+ZGNwd8AgRub54A
 38EknIy3/bNkR5vxTBCavGP1Pi7Qduaej5YRtW7pNGMubLIZ+c1Gl+IO+mbRUNysvSBc
 reLacYeY+09uCotMgaDGGtn0IXkP9sJFtu7r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702648167; x=1703252967;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1V2abb+jqP7q59eoYmg01F9g2D+oCQFBJ35NP5GM1c=;
 b=CIuhhueegtV0+HPnPoag2MLGPARc9NNyNbq1nQkRuZT9/F1tY6ZA6A7TSY06PmOW0T
 p5jGo/uTl/D1f/Z8xseLOhWI2weFwkhtfKAg0FEqgCFtwpYuqlyo619HyVt/It1SdhbZ
 LEdDRXe+fJ09sB0QlRvpH049rP2l1a9eVKnzrrUujlHC/szxTV19HGkOmuU5nGPME1ei
 x39Ai0rZgvGiDwMQ0ksaooQ5+Lm5CkOKuIApjeMJzjE6lmjGqyEdpKPU7RRg6yww6R5Z
 9LG2ZUwTJB3lcMh1Yishv5PeS22SFsjg3DdVuV+PEjZfY+RyHfE915qsI4s3uiUGNw5n
 a/qg==
X-Gm-Message-State: AOJu0YykXKwhCg3ETpKyr78kFORBU5TXJMBIDwIaJ1SG5EKHdi72AjrC
 Mz2AuTGXk6oPEeNCoyaB2TzWZQ==
X-Google-Smtp-Source: AGHT+IFpcbB2I4CBlkX3EhNF/97a7PH/+qMGmFOaIGOiiLe9GujWdZ2cC2Bo8MkcNkeR4aOou53zSA==
X-Received: by 2002:a0c:fb44:0:b0:67e:f55b:7eb0 with SMTP id
 b4-20020a0cfb44000000b0067ef55b7eb0mr4869791qvq.68.1702648167171; 
 Fri, 15 Dec 2023 05:49:27 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-faf3-908c-f76f-32dd.res6.spectrum.com.
 [2603:6081:7b00:6400:faf3:908c:f76f:32dd])
 by smtp.gmail.com with ESMTPSA id
 ff17-20020a0562140bd100b0067ae405e0a8sm690330qvb.57.2023.12.15.05.49.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 05:49:26 -0800 (PST)
Date: Fri, 15 Dec 2023 08:49:24 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alex Kiernan <alex.kiernan@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2 08/16] fastboot: Remove dependencies on CMDLINE
Message-ID: <20231215134924.GW2513409@bill-the-cat>
References: <20231215041919.2197788-1-sjg@chromium.org>
 <20231215041919.2197788-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8ym+fqEe1EWZt5WS"
Content-Disposition: inline
In-Reply-To: <20231215041919.2197788-8-sjg@chromium.org>
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


--8ym+fqEe1EWZt5WS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:19:06PM -0700, Simon Glass wrote:
> It is possible to boot a kernel without CMDLINE being enabled. Update
> the implementation to handle this, and drop the condition from the
> FASTBOOT config.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v2:
> - Avoid changing the logic when a command is not set
>=20
>  drivers/fastboot/Kconfig     |  1 -
>  drivers/fastboot/fb_common.c | 30 ++++++++++++++----------------
>  2 files changed, 14 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 11fc0fe1c800..837c6f1180da 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -1,5 +1,4 @@
>  menu "Fastboot support"
> -	depends on CMDLINE
> =20
>  config FASTBOOT
>  	bool

Please expand the help to note that CMDLINE is recommended and that the
more complex use cases that require running additional commands rather
than simply booting the OS will not work without CMDLINE, thanks.

--=20
Tom

--8ym+fqEe1EWZt5WS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV8WWEACgkQFHw5/5Y0
tywmiAv8Ci6FbOfx8JfA6LfaUVLdAHrjTJXaza6fnIAgSxkUT2xYAsyCw/PoA0EC
P0K/OhEi9/Aibv63pxOpYVSh+2rzjLS3hg+bpWbS5mzJOSOxJnKc57eb0q5jJZ2k
pfGXQ3RN45t1rHYJu74CSQubZrgYUdbjmVwhIX1J1gwAJxaDhTTAwJ0bI14J6HHn
sgML2aQ250NIIAw7NlmNnh9ct/glzdrY/BBUgiBXNtuoUiWALLM2fcwZ1nFDlCIx
66XHEBK70fEfU2PCj9MDDaCUXMcHxQ9GqgZogP9MGvbrhpMLA1a+va/8aG2RomhM
gBaFAaGTRvUSS5Q+RPQkRTcMeqCyrqm6EA8Bk7ugrtAKyzcO4AfqzJjCbEm1V2R6
tnlg3cqAMDy98AzXePfsUuG97xuUFvDsCMrIee+/Xzh4ySK47Wayck9MB4BIyPrl
ZKIzRhQG13r7hnFTDxFFOfUZnISUCSUi6waenRxLSTh3KXgkvTUgPmqmcUtcWWt1
I/evnRyx
=8KNE
-----END PGP SIGNATURE-----

--8ym+fqEe1EWZt5WS--
